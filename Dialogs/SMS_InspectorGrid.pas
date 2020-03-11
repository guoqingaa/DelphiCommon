unit SMS_InspectorGrid;

interface

uses
  SysUtils, Classes, Windows, Controls, Messages, StdCtrls, Dialogs, ExtCtrls,
  Grids, Graphics, ComCtrls, Types, Math, Registry,

  SMS_FileDirDialog, SMS_Strings, SMS_CtrlUtils, SMS_Hint, SMS_Files;

type



  TPropertyType = (ptSep, ptInt, ptFloat, ptBool, ptFile, ptDir, ptEnum,
                      ptColor, ptTime, ptText, ptPassword, ptWord, ptReadOnly);

  TPropertyItem = class(TCollectionItem)
  public
    PropertyName : String;
    OrgValue : Pointer;

    Value : Variant;
    Value2 : Variant;

    PropertyType : TPropertyType;
    Desc : String;
    //
    TagObject : TObject;
  end;

  TInspectorGrid = class(TStringGrid)
  private
    FPropertyItems : TCollection;
    FComboBevelKind : TBevelKind;

    FDateTimePicker : TDateTimePicker;
    FDateTimeCol : Integer;
    FDateTimeRow : Integer;

    FComboBox : TComboBox;
    FComboCol : Integer;
    FComboRow : Integer;

    FEditRow : Integer;
    FReadOnly: Boolean;

    FSeparatorColor : TColor;
    FSeparatorFontColor : TColor;
    FNameColor: TColor;
    FHeadColor: TColor;
    FReadOnlyColor: TColor;
    FLeftMargin: Word;
    FOnInspectorSelected: TSelectCellEvent;
    //
    FLastMessage : String;

    procedure StringGridSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure StringGridSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure GridDblClick(Sender: TObject);

    procedure ProcessSelectedCell(ACol, ARow: Longint); //override;


    procedure ComboChangeItem(Sender: TObject);
    procedure ComboMeasureItem(Control: TWinControl; Index: Integer;
        var Height: Integer);
    (*
    procedure ComboDrawItem(Control: TWinControl; Index: Integer;
                Rect: TRect; State: TOwnerDrawState);
    *)
    procedure DateTimePickerChange(Sender: TObject);
    function GetValues(stName: String): Variant;
    procedure SetReadOnly(const Value: Boolean);
    function GetTitleWidth: Integer;
    procedure SetTitleWidth(const Value: Integer);
    function GetValueWidth: Integer;
    procedure SetValueWidth(const Value: Integer);
    procedure SetSeparatorColor(const Value: TColor);
    procedure SetReadOnlyColor(const Value: TColor);
    procedure SetSeparatorFontColor(const Value: TColor);
    function GetProperty(i: Integer): TPropertyItem;
    function GetPropertyCount: Integer;


  protected

    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    //procedure Update(ACol, ARow: Integer); reintroduce

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    //
    //procedure InvalidateUpdateCell(ACol, ARow: Longint);

  public
    function AddGroupSeparator(stGroup: String): TPropertyItem;
    function AddEnumProperty(stProperty: String;
                aEnums: array of String; var oValue): TPropertyItem;
    function AddEnumProperty2(stProperty: String;
                aEnums: array of String;iValue: Pointer): TPropertyItem;

    function AddReadOnlyProperty(stProperty: String; oValue: Variant): TPropertyItem;
    function AddIntProperty(stProperty: String;
                 var iValue: Integer): TPropertyItem; overload;
    function AddIntProperty(stProperty: String;
                 var iValue: Integer; stDesc: String): TPropertyItem; overload;
    function AddWordProperty(stProperty: String; var wValue: Word): TPropertyItem;
    function AddFloatProperty(stProperty: String; var dValue: Double; stDesc: String = ''): TPropertyItem;
    function AddBoolProperty(stProperty: String;var bValue: Boolean; stDesc: String = ''): TPropertyItem;
    function AddFilePathProperty(stProperty: String; var stValue: String): TPropertyItem;
    function AddDirProperty(stProperty: String; var stDir : String): TPropertyItem;

    function AddColorProperty(stProperty: String; var aColor : TColor) : TPropertyItem;
    function AddTimeProperty(stProperty: String; var aTime: TDateTime): TPropertyItem;
    function AddTextProperty(stProperty: String; var stValue: String): TPropertyItem; overload;
    function AddAnsiTextProperty(stProperty: AnsiString; var stValue: AnsiString): TPropertyItem; overload;
    function AddTextProperty(stProperty: String; var stValue: String; stDesc: String): TPropertyItem; overload;
    function AddPasswordProperty(stPassword: String; var stValue: String): TPropertyItem;

  public
    //
    procedure UpdatePropertyCell(aProperty : TPropertyItem);
    procedure UpdatePropertyName(aProperty : TPropertyItem);
    function FindProperty(stName: String): TPropertyItem;
    //

    function ApplyProperties: Boolean;
    procedure AutoSizeNameField(iSpace: Integer = 10);
    procedure AutoSize(iSpace: Integer = 10);

    property Values[stName: String] : Variant read GetValues; default;

  public
    property ReadOnly : Boolean read FReadOnly write SetReadOnly;
    property TitleWidth : Integer read GetTitleWidth write SetTitleWidth;
    property ValueWidth : Integer read GetValueWidth write SetValueWidth;

    property HeadColor : TColor read FHeadColor write FHeadColor;
    property NameColor : TColor read FNameColor write FNameColor;
    property SeparatorColor : TColor read FSeparatorColor write SetSeparatorColor;
    property SeparatorFontColor : TColor read FSeparatorFontColor write SetSeparatorFontColor;
    property ReadOnlyColor : TColor read FReadOnlyColor write SetReadOnlyColor;

    property LeftMargin : Word read FLeftMargin write FLeftMargin;

    property Properties[i: Integer]: TPropertyItem read GetProperty;
    property PropertyCount : Integer read GetPropertyCount;
    //
    property OnInspectorSelected : TSelectCellEvent read FOnInspectorSelected write FOnInspectorSelected;

  end;




implementation

uses
  DStringPriority, StrUtils;

const
  WM_SELECT_CELL = WM_USER + 100;


{ TInspectorGrid }

var
  gRecentFileList: TStringList;
  //gRecentDirList : TStringList;

//const
//  REG_KEY_PATH = '\SOFTWARE\SDCM';







constructor TInspectorGrid.Create(AOwner: TComponent);
const
  SCROLL_BAR_WIDTH = 20;
begin
  inherited Create(AOwner);

  FEditRow := -1;
  FLeftMargin := 0;

  FPropertyItems := TCollection.Create(TPropertyItem);

  Parent := AOwner as TWinControl;
  Align := alClient;


  if Parent is TPanel then
  begin
    (Parent as TPanel).BevelInner := bvNone;
    (Parent as TPanel).BevelOuter := bvNone;
    Font.Assign((Parent as TPanel).Font);
    Canvas.Font.Name := Font.Name;
    Canvas.Font.Size := Font.Size;
  end;


  ColCount := 2;
  RowCount := 1;
  Cells[0,0] := 'name';
  Cells[1,0] := 'value';

  FComboBevelKind := bkNone;
  FixedCols := 0;
  //
  {
  FSeparatorColor := clBtnFace;
  FSeparatorFontColor := clBlack;
  }
  FSeparatorColor := clHighlight;
  FSeparatorFontColor := clWhite;

  FReadOnlyColor := clBtnFace;
  FNameColor := clBtnFace;
  FHeadColor := clBtnFace;
  //
  Show;
  ColWidths[1] := ClientWidth - ColWidths[0] - SCROLL_BAR_WIDTH;

  FComboBox := TComboBox.CreateParented(Parent.Handle);

  FComboBox.OnChange := ComboChangeItem;
  FComboBox.OnMeasureItem := ComboMeasureItem;
  //FComboBox.OnDrawItem := ComboDrawItem;
  FComboBox.Style := csOwnerDrawVariable;
  FComboBox.Parent := Parent;
  FComboBox.Visible := False;
  //
  FDateTimePicker := TDateTimePicker.CreateParented(Parent.Handle);
  FDateTimePicker.Parent := Parent;
  FDateTimePicker.Visible := False;
  FDateTimePicker.Format := 'HH:mm:ss';
  FDateTimePicker.DateFormat := dfShort;
  FDateTimePicker.Kind := dtkTime;
  FDateTimePicker.DateMode := dmUpDown;
  FDateTimePicker.OnChange := DateTimePickerChange;
  //

  DefaultDrawing := False;
  DefaultRowHeight := 18;
  Options := Options - [goRangeSelect];
//  Options := Options + [goRowSelect];
  OnSelectCell := StringGridSelectCell;
  OnSetEditText := StringGridSetEditText;

  OnDblClick := GridDblClick;



end;


function TInspectorGrid.AddBoolProperty(stProperty: String;
  var bValue: Boolean; stDesc: String = ''): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.Value := bValue;
  Result.OrgValue := @bValue;
  Result.PropertyType := ptBool;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;
end;

function TInspectorGrid.AddFilePathProperty(stProperty: String;
  var stValue: String): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.OrgValue := @stValue;
  Result.Value := stValue;
  Result.PropertyType := ptFile;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;
end;

procedure TInspectorGrid.ComboChangeItem(Sender: TObject);
var
  aProperty : TPropertyItem;
  aTokens : TStringList;
begin
  //
  aProperty := Objects[0, FComboRow] as TPropertyItem;

  case aProperty.PropertyType of
    ptBool :
      begin
        if FComboBox.ItemIndex = 0 then
          aProperty.Value := True
        else
          aProperty.Value := False;
        //
        Cells[1, FComboRow] := aProperty.Value;
      end;

    ptEnum :
      begin
        aProperty.Value := FComboBox.ItemIndex;

        aTokens := TStringList.Create;

        try
          aTokens.Delimiter := ',';
          aTokens.Text := aProperty.Value2;
          Cells[1, FComboRow] := aTokens[FComboBox.ItemIndex];

        finally
          aTokens.Free;
        end;
      end;
  end;
end;

(*
procedure TInspectorGrid.ComboDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  iX, iY : Integer;
  aSize : TSize;

  stText : String;
begin
  FComboBox.Canvas.Brush.Color := clWhite;
  FComboBox.Canvas.FillRect(Rect);

  if Index < 0 then Exit;

  stText := FComboBox.Items[Index];
  if stText <> '' then
  begin
    FComboBox.Canvas.Font.Color := clBlack;
    //-- calc position
    aSize := FComboBox.Canvas.TextExtent(stText);
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
    //-- put text

    iX := Rect.Left + 2;

    FComboBox.Canvas.TextRect(Rect, iX, iY, stText);
    //
  end;



end;
*)

procedure TInspectorGrid.ComboMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  //
  //Height := 20;

  Height := Max(1, Height{RowHeights[FComboRow]}-GridLineWidth*2){combo bevel 상단 SD(2)+ 하단(1)};

end;


destructor TInspectorGrid.Destroy;
begin
  FPropertyItems.Free;
  inherited;
end;


procedure TInspectorGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
const
  LONG_COLOR = $E4E2FC;
  SHORT_COLOR = $F5E2DA;

  NODATA_COLOR = $FFDDDD;
  FIXED_COLOR = $DDDDDD;
  HIGHLIGHT_COLOR = $80FFFF;
  SELECTED_COLOR = $FF3333;
  SELECTED_COLOR2 = $00F2BEB9;
  SELECTED_COLOR3 = $00EFD3C6;
  SELECTED_COLOR4 = $00C56A31;

  BORDER_COLOR = $00C66931;

  DISABLED_COLOR = $BBBBBB;
  ERROR_COLOR = $008080FF;
  ODD_COLOR = $FFFFFF;
  EVEN_COLOR = $EEEEEE;
var
  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;
  aProperty : TPropertyItem;

begin

  ARect := CellRect(ACol, ARow);
  with Canvas do
  begin   
    //
    stText := Cells[ACol, ARow];

    aProperty := nil;
    if Objects[0, ARow] is TPropertyItem then
      aProperty := Objects[0, ARow] as TPropertyItem;
    //
    if (ACol = 1) and (aProperty <> nil) and (aProperty.PropertyType = ptPassword) then
      stText := DupeString('*', Length(stText));

    Font.Color := clBlack;
    //
    if ((aProperty <> nil) and (aProperty.PropertyType = ptSep)) then
    begin
      Brush.Color := FSeparatorColor;
      Font.Color := FSeparatorFontColor;
    end else
    if ((aProperty <> nil) and (aProperty.PropertyType = ptReadOnly)) then
      Brush.Color := FReadOnlyColor
    else if (ARow = 0) then
      Brush.Color := FHeadColor
    else if(ACol = 0) then
      Brush.Color := FNameColor//clBtnFace
    else if (aProperty <> nil) and (aProperty.PropertyType = ptColor) then
      Brush.Color := aProperty.Value
    else if gdSelected in AState then
      Brush.Color := SELECTED_COLOR2
    else
      Brush.Color := clWhite;
    //
    aAlignment := taLeftJustify;
    if (ACol > 0) and
      (aProperty <> nil) and (aProperty.PropertyType in [ptDir, ptFile]) then
      aAlignment := taRightJustify;

    //-- background
    FillRect(ARect);
    //-- text
    if stText = '' then Exit;
    //-- calc position
    aSize := TextExtent(stText);
    iY := ARect.Top + ({ARect.Bottom - ARect.Top}RowHeights[ARow] - aSize.cy) div 2;
    iX := ARect.Left + (ARect.Right-ARect.Left-aSize.cx) div 2;
    //-- put text
    case aAlignment of
      taLeftJustify :  iX := ARect.Left + 2 + FLeftMargin;
      taCenter :       iX := ARect.Left + (ARect.Right-ARect.Left-aSize.cx) div 2;
      taRightJustify : iX := ARect.Left + ARect.Right-ARect.Left - 2 - aSize.cx;
    end;
    TextRect(ARect, iX, iY, stText);
  end;


end;




procedure TInspectorGrid.GridDblClick(Sender: TObject);
var
  aProperty : TPropertyItem;
  aDialog : TFileDirDialog;
  stFile : String;
  aColorDialog : TColorDialog;
  aHint : TSMSHint;

begin
  //
  aProperty := Objects[0, Row] as TPropertyItem;
  //
  if aProperty = nil then Exit;
  //
  if (Col = 0) then
  begin
    if aProperty.Desc <> '' then
    begin
      aHint := NewSHint;
      //
      aHint.AddLine(aProperty.Desc);
      aHint.ShowHint();
    end;
  end;
  //
  if aProperty.PropertyType in [ptFile, ptDir] then
  begin
    if (InplaceEditor <> nil) and InplaceEditor.Visible then
    begin
      aDialog := TFileDirDialog.Create(Self);

      try
        stFile := aProperty.Value;
        if ((aProperty.PropertyType = ptFile) and (aDialog.OpenFile(stFile))) or
           ((aProperty.PropertyType = ptDir) and (aDialog.OpenDirectroy(stFile))) then
          begin
            //aProperty.Value := stFile;
            aProperty.Value := aDialog.Selected;
            Cells[1, Row] := aProperty.Value;
            HideEditor;
            Invalidate;
            if aProperty.PropertyType = ptDir then
              RegisterRecentDirList(stFile);
          end;

      finally
        aDialog.Free;
      end;
    end;
  end else
  if aProperty.PropertyType = ptColor then
  begin
    aColorDialog := TColorDialog.Create(Self);

    try
      aColorDialog.Options := [cdFullOpen, cdPreventFullOpen, cdShowHelp,
         cdSolidColor, cdAnyColor];
      aColorDialog.Color := aProperty.Value;
      if aColorDialog.Execute then
        aProperty.Value := aColorDialog.Color;

      Invalidate;

    finally
      aColorDialog.Free;
    end;
  end;



end;

procedure TInspectorGrid.ProcessSelectedCell(ACol, ARow: Integer);
var
  i : Integer;
  aRect : TRect;
  {iWidth,} //iHeight : Integer;
  aProperty : TPropertyItem;
  aPoint, aPoint2 : TPoint;
  bVisibleCombo : Boolean;
  bVisibleTime : Boolean;
  aTokens : TStringList;
  bCanSelected : Boolean;
begin
  //
  Options := Options - [goEditing];
  bVisibleCombo := False;
  bVisibleTime := False;
  //
  aRect := CellRect(aCol, ARow);
  //
  //iHeight := ARect.Bottom-ARect.Top+1;
  //iWidth := ARect.Right - ARect.Left + 1;
  //
  if (ARow > 0) then
  begin
    aProperty := Objects[0, ARow] as TPropertyItem;
    //
    if aProperty <> nil then
    begin
      if (ACol = 1) then
      begin

        case aProperty.PropertyType of
          ptTime :
            begin
              bVisibleTime := True;
              //
              aPoint := Parent.ScreenToClient(ClientToScreen(aRect.TopLeft));
              aPoint2 := Parent.ScreenToClient(ClientToScreen(aRect.BottomRight));

              FDateTimePicker.Time := aProperty.Value;

              FDateTimePicker.SetBounds(aPoint.X, aPoint.Y,
                aPoint2.X-aPoint.X+1, aPoint2.Y-aPoint.Y+GridLineWidth*2);

              FDateTimeCol := ACol;
              FDateTimeRow := ARow;

            end;
          ptBool:
            begin
              FComboBox.Visible := False;
              FComboBox.Items.Clear;

              FComboBox.Items.Add('True');
              FComboBox.Items.Add('False');

              if aProperty.Value = True then
                FComboBox.ItemIndex := 0
              else
                FComboBox.ItemIndex := 1;
              //
              aPoint := Parent.ScreenToClient(ClientToScreen(aRect.TopLeft));
              aPoint2 := Parent.ScreenToClient(ClientToScreen(aRect.BottomRight));

{$IFNDEF VER150}
              FComboBox.BoundsRect := Rect(aPoint.X, aPoint.Y, aPoint2.X, aPoint2.Y);
{$ELSE}

              FComboBox.SetBounds(aPoint.X, aPoint.Y-1,
                aPoint2.X-aPoint.X+1, aPoint2.Y-aPoint.Y+GridLineWidth*2+1);
{$ENDIF}

              FComboCol := ACol;
              FComboRow := ARow;
              bVisibleCombo := True;

            end;

          ptColor, ptReadOnly, ptSep :
            begin
            end;

          ptEnum:
            begin
              FComboBox.Visible := False;
              FComboBox.Items.Clear;

              aTokens := TStringList.Create;

              try
                aTokens.Delimiter := ',';
                aTokens.Text := aProperty.Value2;

                for i := 0 to aTokens.Count-1 do
                  FComboBox.Items.Add(aTokens[i]);

                FComboBox.ItemIndex := aProperty.Value;
              finally
                aTokens.Free;
              end;
              //
              aPoint := Parent.ScreenToClient(ClientToScreen(aRect.TopLeft));
              aPoint2 := Parent.ScreenToClient(ClientToScreen(aRect.BottomRight));
              //
              FComboBox.SetBounds(aPoint.X, aPoint.Y, aPoint2.X-aPoint.X+1, aPoint2.Y-aPoint.Y+1+GridLineWidth*2);
              FComboCol := ACol;
              FComboRow := ARow;
              bVisibleCombo := True;
            end;

          ptPassword :
          begin
            Options := Options + [goEditing];
            Cells[1, ARow] := DupeString('*', Length(aProperty.Value));
          end;

          else
          begin
            Options := Options + [goEditing];
            Cells[1, ARow] := aProperty.Value;
          end;

        end;

      end;
    end;
  end;
  //
  FComboBox.Visible := bVisibleCombo;
  FDateTimePicker.Visible := bVisibleTime;
  //
  if Assigned(FOnInspectorSelected) then
    FOnInspectorSelected(Self, ACol, ARow, bCanSelected);

end;

procedure TInspectorGrid.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := True;



  //PostMessage(Handle, WM_SELECT_CELL, ACol, ARow);
  ProcessSelectedCell(ACol, ARow);
end;

procedure TInspectorGrid.StringGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var
  aProperty : TPropertyItem;
begin
  //
  aProperty := Objects[0, ARow] as TPropertyItem;
  aProperty.Value := Value;

end;



function TInspectorGrid.AddDirProperty(stProperty: String;
  var stDir: String): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.OrgValue := @stDir;
  Result.Value := stDir;
  Result.PropertyType := ptDir;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;
end;

function TInspectorGrid.ApplyProperties: Boolean;
var
  i : Integer;
  aProperty : TPropertyItem;
begin
  Result := True;
  //
  for i := 0 to FPropertyItems.Count-1 do
  begin
    aProperty := FPropertyItems.Items[i] as TPropertyItem;
    //
    try
      case aProperty.PropertyType of

        ptFile, ptDir, ptText, ptPassword:
          begin
            PString(aProperty.OrgValue)^ := aProperty.Value;
            //
            if aProperty.PropertyType = ptDir then
              RegisterRecentDirList(aProperty.Value);
          end;

        ptBool :
          begin
            PBoolean(aProperty.OrgValue)^ := aProperty.Value;
          end;

        ptWord :
          PWord(aProperty.OrgValue)^ := aProperty.Value;

        ptInt, ptColor :
          begin
            PInt(aProperty.OrgValue)^ := aProperty.Value;
          end;

        ptFloat :
          begin
            PDouble(aProperty.OrgValue)^ := aProperty.Value;
          end;

        ptEnum :
          begin
            PByte(aProperty.OrgValue)^ := aProperty.Value;
          end;

        ptTime :
          PDateTime(aProperty.OrgValue)^ := aProperty.Value;
      end;
      //
    except on E: Exception do
      begin
        Result := False;
        if FLastMessage <> '' then
          FLastMessage := FLastMessage + '^';
        FLastMessage := FLastMessage + Format('%s:%s',[aProperty.PropertyName, E.Message]);
      end;
    end;
  end;

end;

function TInspectorGrid.AddGroupSeparator(stGroup: String): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stGroup;
  Result.PropertyType := ptSep;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stGroup;
  Objects[0, RowCount-1] := Result;
end;

function TInspectorGrid.AddIntProperty(stProperty: String;
  var iValue: Integer): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.Value := iValue;
  Result.OrgValue := @iValue;
  Result.PropertyType := ptInt;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;
end;

function TInspectorGrid.AddFloatProperty(stProperty: String;
  var dValue: Double; stDesc: String): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.Desc := stDesc;
  Result.PropertyName := stProperty;
  Result.Value := dValue;
  Result.OrgValue := @dValue;
  Result.PropertyType := ptFloat;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;

end;


function TInspectorGrid.AddEnumProperty(stProperty: String;
  aEnums: array of String; var oValue): TPropertyItem;
var
  i{, iP} : Integer;
  aStrings : TStringList;
  //wValue : Word;
begin
  Result := nil;
  //
  //TVarData(oValue).VType
  //ShowMessage(IntToStr(Integer(oValue)));



  if Byte(oValue) > Length(aEnums)-1 then Exit;

  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  aStrings := TStringList.Create;
  try
    for i := 0 to Length(aEnums)-1 do
      aStrings.Add(aEnums[i]);
    aStrings.Delimiter := ',';
    Result.Value2 := aStrings.Text;
  finally
    aStrings.Free;
  end;

  Result.OrgValue := @oValue;
  Result.Value := Byte(oValue);
  Result.PropertyType := ptEnum;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := aEnums[Byte(oValue)];
end;

function TInspectorGrid.AddColorProperty(stProperty: String;
  var aColor: TColor): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.OrgValue := @aColor;
  Result.Value := aColor;
  Result.PropertyType := ptColor;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  //Cells[1, RowCount-1] := Result.Value;
end;

function TInspectorGrid.AddTimeProperty(stProperty: String;
  var aTime: TDateTime): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.OrgValue := @aTime;
  Result.Value := aTime;
  Result.PropertyType := ptTime;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;
  Cells[1, RowCount-1] := FormatDateTime('hh:nn:ss', aTime);

end;

procedure TInspectorGrid.DateTimePickerChange(Sender: TObject);
var
  aProperty : TPropertyItem;
begin
  aProperty := Objects[0, FDateTimeRow] as TPropertyItem;
  //
  if aProperty.PropertyType = ptTime then
  begin
    aProperty.Value := FDateTimePicker.Time;
    Cells[1, FDateTimeRow{RowCount-1}] := FormatDateTime('hh:nn:ss', aProperty.Value);
  end;


end;

function TInspectorGrid.FindProperty(stName: String): TPropertyItem;
var
  i : Integer;
  aProperty : TPropertyItem;
begin
  Result := nil;
  //
  for i := 0 to FPropertyItems.Count-1 do
  begin
    aProperty := FPropertyItems.Items[i] as TPropertyItem;
    //
    if LowerCase(Trim(aProperty.PropertyName)) = LowerCase(Trim(stName)) then
    begin
      Result := aProperty;
      Break;
    end;

  end;


end;

function TInspectorGrid.GetValues(stName: String): Variant;
var
  aProperty : TPropertyItem;
begin
  Result := '';
  //
  aProperty := FindProperty(stName);
  //
  if aProperty <> nil then
    Result := aProperty.Value;

end;

function TInspectorGrid.AddTextProperty(stProperty: String;
  var stValue: String): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.OrgValue := @stValue;
  Result.Value := stValue;
  Result.PropertyType := ptText;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;
  Cells[1, RowCount-1] := stValue;

end;

procedure TInspectorGrid.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
  //
  if Value then
    Options := Options - [goEditing]
  else
    Options := Options + [goEditing];
end;

procedure TInspectorGrid.Clear;
//var
  //i : Integer;
begin

  FPropertyItems.Clear;
  //
  RowCount := 1;
  ColCount := 2;

end;


function TInspectorGrid.AddEnumProperty2(stProperty: String;
  aEnums: array of String; iValue: Pointer): TPropertyItem;
var
  i{, iP} : Integer;
  aStrings : TStringList;
  wValue : Byte;
begin
  Result := nil;
  //
  //TVarData(oValue).VType
  //ShowMessage(IntToStr(Integer(oValue)));

  wValue := PByte(iValue)^;

  if wValue > Length(aEnums)-1 then Exit;

  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  aStrings := TStringList.Create;
  try
    for i := 0 to Length(aEnums)-1 do
      aStrings.Add(aEnums[i]);
    aStrings.Delimiter := ',';
    Result.Value2 := aStrings.Text;
  finally
    aStrings.Free;
  end;

  Result.OrgValue := @iValue;
  Result.Value := Integer(iValue);
  Result.PropertyType := ptEnum;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := aEnums[Integer(iValue)];

end;

function TInspectorGrid.GetTitleWidth: Integer;
begin
  Result := ColWidths[0];
end;

procedure TInspectorGrid.SetTitleWidth(const Value: Integer);
begin
  ColWidths[0] := Value;    
end;

function TInspectorGrid.GetValueWidth: Integer;
begin
  Result := ColWidths[1];
end;

procedure TInspectorGrid.SetValueWidth(const Value: Integer);
begin
  ColWidths[1] := Value;
end;

procedure TInspectorGrid.SetSeparatorColor(const Value: TColor);
begin
  FSeparatorColor := Value;
  //
  Refresh;
end;

procedure TInspectorGrid.AutoSizeNameField(iSpace: Integer);
begin
  ColWidths[0] := GridColWidth(Self, 0, iSpace);
end;

function TInspectorGrid.AddPasswordProperty(stPassword: String;
  var stValue: String): TPropertyItem;
begin
  Result := AddTextProperty(stPassword, stValue);
  Result.PropertyType := ptPassword;

end;

procedure TInspectorGrid.AutoSize(iSpace: Integer);
const
  SCROLLBAR_SIZE = 5;
begin
  AutoSizeNameField(iSpace);
  //
  ColWidths[1] := ClientWidth - ColWidths[0] - SCROLLBAR_SIZE;


end;

function TInspectorGrid.AddWordProperty(stProperty: String;
  var wValue: Word): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.Value := wValue;
  Result.OrgValue := @wValue;
  Result.PropertyType := ptWord;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;
end;

function TInspectorGrid.AddReadOnlyProperty(stProperty: String;
  oValue: Variant): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.Value := oValue;
  Result.PropertyType := ptReadOnly;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;

  Cells[1, RowCount-1] := Result.Value;
end;

procedure TInspectorGrid.SetReadOnlyColor(const Value: TColor);
begin
  FReadOnlyColor := Value;

  Invalidate;
end;

procedure TInspectorGrid.SetSeparatorFontColor(const Value: TColor);
begin
  FSeparatorFontColor := Value;

  Invalidate;
end;

function TInspectorGrid.AddIntProperty(stProperty: String;
  var iValue: Integer; stDesc: String): TPropertyItem;
begin
  Result := AddIntProperty(stProperty, iValue);
  Result.Desc := stDesc;
end;

function TInspectorGrid.AddTextProperty(stProperty: String;
  var stValue: String; stDesc: String): TPropertyItem;
begin
  Result := AddTextProperty(stProperty, stValue);
  Result.Desc := stDesc;
end;

procedure TInspectorGrid.UpdatePropertyCell(aProperty: TPropertyItem);
var
  i : Integer;
begin
  //
  for i := 1 to RowCount-1 do
  begin
    //
    if aProperty = Objects[0, i] then
    begin
      if aProperty.PropertyType = ptText then
      begin
        Cells[1, i] := aProperty.Value
      end;
      //
      Break;
    end;

  end;

end;

function TInspectorGrid.AddAnsiTextProperty(stProperty: AnsiString;
  var stValue: AnsiString): TPropertyItem;
begin
  Result := FPropertyItems.Add as TPropertyItem;
  Result.PropertyName := stProperty;
  Result.OrgValue := @stValue;
  Result.Value := stValue;
  Result.PropertyType := ptText;

  RowCount := RowCount + 1;
  //
  Cells[0, RowCount-1] := stProperty;
  Objects[0, RowCount-1] := Result;
  Cells[1, RowCount-1] := stValue;
end;

{
procedure TInspectorGrid.InvalidateUpdateCell(ACol, ARow: Integer);
begin
  InvalidateCell(ACol, ARow);
end;
}
procedure TInspectorGrid.UpdatePropertyName(aProperty: TPropertyItem);
var
  i : Integer;
begin
  //
  for i := 1 to RowCount-1 do
  begin
    //
    if aProperty = Objects[0, i] then
    begin

      Cells[0, i] := aProperty.PropertyName;

      //
      Break;
    end;

  end;

end;

function TInspectorGrid.GetProperty(i: Integer): TPropertyItem;
begin
  Result := nil;
  //
  if (i >= 0) and (i < FPropertyItems.Count) then
    Result := FPropertyItems.Items[i] as TPropertyItem;
end;

function TInspectorGrid.GetPropertyCount: Integer;
begin
  Result := FPropertyItems.Count;
end;


end.



