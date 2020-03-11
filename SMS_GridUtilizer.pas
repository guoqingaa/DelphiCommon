unit SMS_GridUtilizer;

interface

uses
  SysUtils, Forms, Classes, Grids, Dialogs, Controls, Windows, Graphics, Math,
  ComObj, Variants, Excel_TLB, MSXML_TLB, Menus,

  SMS_Columns, DSelectExcelChart, DGridColors, SMS_CtrlUtils, SMS_Types,
  SMS_Hint, SMS_Graphics;

type

(* Todo list


*)

  TCustomGridOwnerDataProc = procedure(const Grid: TStringGrid;
    const ACol, ARow : Integer; const stColumn: String; out stValue: Variant) of object;


  TCustomGridOwnerDataProc2 = procedure(const Grid: TStringGrid; const  ACol, ARow,
    iColumnIndex: Integer; out stValue: Variant) of object;


  TCustomGridOwnerStyleProc = procedure(const Grid: TStringGrid;
    const ACol, ARow, iColumnIndex: Integer; const State: TGridDrawState;
    var aBackColor: TColor; var aFontColor : TColor;
    var aFontStyles : TFontStyles) of object;

  TCustomGridPosEvent = procedure(Grid: TStringGrid; ACol, ARow: Integer) of object;

  TColumnEvent = procedure(aColumn : TSColumnItem) of object;



//  TCustomGridOwnerColorStyleProc = procedure(GridUtilizer: TObject; ACol, ARow : Integer;
//    State: TGridDrawState; out aBackColor, aFontColor: TColor; out aFontStyle: TFontStyles) of object;

  TMergedRect = record
    Rect : TRect;
    Value : String;
  end;

  //
  TGridUtilizer = class
  private
    FGrid: TStringGrid;
    FColumns: TColumns;
    FFixedColor: TColor;
    FGridColor : TColor;

    FSelectedFrameRect : Boolean;
    FSelectedFrameWidth : Integer;
    FSelectedColor: TColor;
    FSelectedFontColor: TColor;

    FUseColumns: Boolean;
    FOwnerData: Boolean;
    FOnOwnerData: TCustomGridOwnerDataProc;
    FPositiveFontColor: TColor;
    FPositiveBackColor : TColor;
    FNegativeFontColor: TColor;
    FNegativeBackColor : TColor;

    FMergedColRects : array of TMergedRect;
    FOwnerColumn: Boolean;
    FColumnRow: Integer;
    FConsolidateRow: Integer;
    FUseThousandComma: Boolean;
    FOnOwnerStyle: TCustomGridOwnerStyleProc;
    FBackFontColor: TColor;
    FBackColor: TColor;
    FUseColumnFontSize: Boolean;
    FColumnFontSize: Integer;
    FOnOwnerData2: TCustomGridOwnerDataProc2;
    FOnDoubleClick: TCustomGridPosEvent;
    FOnColumnSizing: TColumnEvent;
    FEnvPath: String;
    FShowColumns: Boolean;
    FOnOwnerDraw: TDrawCellEvent;
    FOnOwnerMouseUp: TMouseEvent;
    FColumnDoubleClickHint: Boolean;
    FOnAfterColumnsAlignChange: TNotifyEvent;

    function GetCellVarString(const aValue: Variant; const iScale: Integer; out bIsNumeric: Boolean): String;

    //---------- virtual procedures -------------------------
    procedure SetGrid(const Value: TStringGrid); virtual;
    procedure DrawCell(const ACol, ARow: Integer; Rect: TRect; stText : String;
      aAlignment: TAlignment; iMargin: Integer; State: TGridDrawState); virtual;
    procedure SetCanvasColor(aColumn: TSColumnItem; const ACol, ARow: Integer;
          State: TGridDrawState); virtual;

    function GetCellText(const aColumn : TSColumnItem;
      const ACol, ARow: Integer;var bOwnerDataConnected: Boolean; var dValue: Double): String; virtual;
    procedure SetAlignmentMargin(aColumn: TSColumnItem;var aAlignment: TAlignment; var iMargin: Integer); virtual;
    //

    procedure GridDblClick(Sender: TObject);
    procedure CustomGridDrawCell(Sender: TObject; ACol,
        ARow: Integer; Rect: TRect; State: TGridDrawState); virtual;
    procedure LeftTopChanged(Sender: TObject);
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormatMenuColumnsClick(Sender: TObject);
    procedure FormatMenuColorClick(Sender: TObject);
    procedure FormatMenuFontClick(Sender: TObject);

    function IsMergedCell(iCol, iRow: Integer; var Rect: TMergedRect): Boolean;

    procedure RefreshColumnWidthValues;
    procedure ColumnsSetPersistence(Sender: TObject);
    procedure SetBackColor(const Value: TColor);
    procedure SetBackFontColor(const Value: TColor);

    procedure LoadEnvironment;
    procedure SaveEnvironment;
    procedure GetDefault(iVersion: Integer; stKey: String; aNode: IXMLDomElement);
    procedure SetDefault(iVersion: Integer; stKey: String; aNode: IXMLDomElement);
    procedure SetEnvPath(const Value: String);

  public
    procedure InitColors;
  public
    constructor Create(aGrid: TStringGrid);
    destructor Destroy; override;
    //
    procedure AddMergeInfo(iLeft, iTop, iRight, iBottom: Integer; stValue: String);
    procedure ClearMergeInfo;
    //
    procedure AssignColumns(aColumns: TColumns);

    //-- related with columns
    procedure AddColumnDefault(stTitle: String; iWidth, iPrecision: Integer;
      aAlignment : TAlignment; bUpDownColor: Boolean = False);
    function AddColumnView(stTitle: String; iWidth: Integer = 100;
      iPrecision: Integer=0; aAlignment : TAlignment= taCenter; bUpDownColor: Boolean = False): TSColumnItem; overload;
    function AddColumnView(stTitle, stDesc: String; iWidth: Integer = 100;
      iPrecision: Integer=0; aAlignment : TAlignment= taCenter; bUpDownColor: Boolean = False): TSColumnItem; overload;

    procedure RefreshColumnWidths;
    procedure RefreshColumnCount(iOffset: Integer = 0);
    procedure AutoColumnSize(const iSpace: Integer = 3; iStartRow : Integer = 0);
    procedure AutoColumnWidth(const iSpace: Integer = 3; iStartRow: Integer = 0);

    procedure UpdateRow(iRow: Integer);
    procedure DisconnectEvents;

    //-- related to save to exacl
    function SaveToCSV: Boolean;
    function ExportToExcel(stWorkSheet: String; iFontSize: Integer = 9): _Application;
    //
    procedure ExportToExcelChart(stName: String;
      iFontSize, xlChartType: Integer; aXColumn, aYColumn: TSColumnItem); overload;
    procedure ExportToExcelChart(stName: String;
      iFontSize, xlChartType: Integer; iXColumnIndex, iYColumnIndex: Integer); overload;
    procedure ExportToExcelChart(stName: String;
      iFontSize, xlChartType, iXRow: Integer; iColumns : Array of Integer); overload;

    //-- get set persistence
    procedure GetPersistence(aElement: IXMLDOMElement);
    procedure SetPersistence(aElement: IXMLDOMElement);


    //-- configure
    function ConfigColumns(aOwner: TForm): Boolean;
    function ConfigColors(aOwner : TForm): Boolean;
    procedure ColorDefaultLoaded(Sender: TObject);

    procedure AutoPopup(aMenu : TMenuItem); overload;
    procedure AutoPopup(aPopup: TPopupMenu); overload;

    //bIncludeColumn : True; -> column에도 동시에 적용된다.
    function ConfigFont(aOwner: TForm; bIncludeColumn: Boolean= False): Boolean;

    //-------------------------- related with UI ---------------------------
    procedure AssignFont(aFont : TFont; bIncludeColumn : Boolean); overload;
    procedure AssignFont(aFont : TFont; bIncludeColumn : Boolean;
        iColumnSpace: Integer; iStartRow: Integer = 0); overload;  //with column resize

    procedure AssignColor(aGridUtilizer: TGridUtilizer);


    //-- properties

    property Grid: TStringGrid read FGrid;
    property Columns : TColumns read FColumns;


    //owner column : true 인 경우 column 이 사용자가 지정한 특정한 row
    //( owner column row) 에 위치한다.
    //               false 인 경우 row = 0 에 자동 위치한다.
    property OwnerColumn : Boolean read FOwnerColumn write FOwnerColumn;

    //columnRow 를 음수값으로 지정하면 column 이 보이지 않는다.
    property ColumnRow : Integer read FColumnRow write FColumnRow;       //
    //
    //
    property UseColumns : Boolean read FUseColumns write FUseColumns;
    property OwnerData : Boolean read FOwnerData write FOwnerData;
    property ColumnDoubleClickHint : Boolean read FColumnDoubleClickHint write FColumnDoubleClickHint;
    property ConsolidateRow : Integer read FConsolidateRow write FConsolidateRow;
    property UseThousandComma : Boolean read FUseThousandComma write FUseThousandComma;
    property UseColumnFontSize : Boolean read FUseColumnFontSize write FUseColumnFontSize;
    property ColumnFontSize : Integer read FColumnFontSize;
    property EnvPath : String read FEnvPath write SetEnvPath;

    //
    //-------------------------------- colors ---------------------------------
    //
    property FixedColor : TColor read FFixedColor write FFixedColor;
    property SelectedColor : TColor read FSelectedColor write FSelectedColor;
    property SelectedFontColor : TColor read FSelectedFontColor write FSelectedFontColor;
    property PositiveFontColor : TColor read FPositiveFontColor write FPositiveFontColor;
    property PositiveBackColor : TColor read FPositiveBackColor write FPositiveBackColor;
    property NegativeFontColor : TColor read FNegativeFontColor write FNegativeFontColor;
    property NegativeBackColor : TColor read FNegativeBackColor write FNegativeBackColor;
    property BackColor : TColor read FBackColor write SetBackColor;
    property BackFontColor : TColor read FBackFontColor write SetBackFontColor;

    //
    //-------------------------------- events -----------------------------------
    //
    property OnOwnerMouseUp : TMouseEvent read FOnOwnerMouseUp write FOnOwnerMouseUp;
    property OnDoubleClick : TCustomGridPosEvent read FOnDoubleClick write FOnDoubleClick;
    property OnOwnerData : TCustomGridOwnerDataProc read FOnOwnerData write FOnOwnerData;
    property OnOwnerData2 : TCustomGridOwnerDataProc2 read FOnOwnerData2 write FOnOwnerData2;
    property OnOwnerStyle : TCustomGridOwnerStyleProc read FOnOwnerStyle write FOnOwnerStyle;
    property OnOwnerDraw : TDrawCellEvent read FOnOwnerDraw write FOnOwnerDraw;               //
    property OnColumnSizing : TColumnEvent read FOnColumnSizing write FOnColumnSizing;
    //
    property OnAfterColumnsAlignChange : TNotifyEvent read FOnAfterColumnsAlignChange write FOnAfterColumnsAlignChange;
  end;

  {
  TGridUtilizer2 = class(TGridUtilizer)
  private
    FRefColumn: Integer;
    FOnUtilizerSelectCell: TSelectCellEvent;
    //
    procedure CustomGridDrawCell(Sender: TObject; ACol,
        ARow: Integer; Rect: TRect; State: TGridDrawState); override;
    procedure SetGrid(const Value: TStringGrid); override;
    procedure SelectCell(Sender: TObject; ACol, ARow: Longint;
                var CanSelect: Boolean);
  public
    constructor Create(aGrid: TStringGrid);

    property RefColumn : Integer read FRefColumn write FRefColumn;

    property OnUtilizerSelectCell : TSelectCellEvent read FOnUtilizerSelectCell
        write FOnUtilizerSelectCell;
  end;
  }
  TGridUtilizer3 = class(TGridUtilizer)
  protected
    FRefColumn : Integer;
    FOnUtilizerSelectCell: TSelectCellEvent;
    //
    procedure SetGrid(const Value: TStringGrid); override;
    procedure SetCanvasColor2(aColumn: TSColumnItem; const ACol, ARow: Integer;
          State: TGridDrawState;const bOwnerDataConnected: Boolean; const dValue: Double); virtual;
    procedure SelectCell(Sender: TObject; ACol, ARow: Longint;
                var CanSelect: Boolean);
  public
    constructor Create(aGrid: TStringGrid);
    (*version1 과 틀린점 :
      DrawCell 에서 ver1. 은 ownerstyle 이 ownerdata 보다 먼저
      ver3 은 ownerdata 가 ownerstyle 보다 먼저.
    *)
    procedure CustomGridDrawCell(Sender: TObject; ACol,
        ARow: Integer; Rect: TRect; State: TGridDrawState); override;
    //
    property RefColumn : Integer read FRefColumn write FRefColumn;
    //
    property OnUtilizerSelectCell : TSelectCellEvent read FOnUtilizerSelectCell
        write FOnUtilizerSelectCell;
  end;
  //


  (*
  TGridUtilizer4 = class(TGridUtilizer2)
  public
    //*version3 과 틀린점 :
    //  ownerdata 를 하지 않더라도 column의 showcolorchange=true 이면... up, down
    //  별 색상 표시..
    //
    procedure CustomGridDrawCell(Sender: TObject; ACol,
        ARow: Integer; Rect: TRect; State: TGridDrawState); override;
  end;
  *)


{
  OwnerData 를 true로 해야 Column의 ShowChange 가 작동한다.

}

implementation

uses
  SMS_XMLs;

const
  ENV_FILE = 'GridUtilizer.xml';

{ TCustomGridDrawer }

procedure TGridUtilizer.AddColumnDefault(stTitle: String; iWidth,
  iPrecision: Integer; aAlignment: TAlignment; bUpDownColor: Boolean);
var
  aColumnItem : TSColumnItem;
begin
  //
  aColumnItem := FColumns.AddColumnToDefault(stTitle, iWidth, aAlignment, iPrecision);
  aColumnItem.ShowColorChange := bUpDownColor;

end;

function TGridUtilizer.AddColumnView(stTitle: String; iWidth,
  iPrecision: Integer; aAlignment: TAlignment; bUpDownColor : Boolean): TSColumnItem;
//var
//  aColumnItem : TColumnItem;
begin
  //
  Result := FColumns.AddColumnToView(stTitle, iWidth, aAlignment, iPrecision);
  Result.ShowColorChange := bUpDownColor;
  //

  FGrid.ColCount := Max(FGrid.FixedCols+1, FColumns.ViewList.Count);
  FGrid.ColWidths[FGrid.ColCount-1] := iWidth;
end;

constructor TGridUtilizer.Create(aGrid: TStringGrid);
begin
  FColumns := TColumns.Create;
  FColumns.OnSetPersistence := ColumnsSetPersistence;
  //
  InitColors;
  //
  FUseColumns := True;
  FOwnerData := False;
  FOwnerColumn := False;
  FColumnRow := 0;
  FConsolidateRow := 1;
  FUseThousandComma := True;

  FShowColumns := True;
  FUseColumnFontSize := True;
  FColumnFontSize := 9;
  FColumnDoubleClickHint := False;

  SetLength(FMergedColRects, 0);

  SetGrid(aGrid);
  FGrid.ColCount := 0;
  AssignFont(FGrid.Font, True);

end;

destructor TGridUtilizer.Destroy;
begin
  SetLength(FMergedColRects, 0);
  //
  FColumns.Free;

  inherited;
end;


procedure TGridUtilizer.CustomGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iMargin : Integer;
  stText : String;
  aPenColor, aBrushColor, aFontColor : TColor;
  aColumn : TSColumnItem;
  vValue : Variant;
  bCallBack : Boolean;
  aStyles : TFontStyles;
  bIsNumeric : Boolean;
begin
  //gLog.Add(lkDebug, FGrid.Name , IntToStr(ACol), IntToStr(ARow));

  aColumn := nil;
  //
  with FGrid.Canvas do
  begin
    aBrushColor := Brush.Color;
    aFontColor := Font.Color;
    aStyles := Font.Style;
    aPenColor := Pen.Color;
    //
    try
      //
      Font.Name := FGrid.Font.Name;
      Font.Size := FGrid.Font.Size;
      Font.Style := FGrid.Font.Style;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[ACol, FColumnRow] as TSColumnItem
      else if FUseColumns and (ACol <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[ACol]);
      //
      if aColumn <> nil then
      begin
        aAlignment := aColumn.Alignment;
        iMargin := aColumn.Margin;
      end else
      begin
        aAlignment :=taLeftJustify;
        iMargin := 0;
      end;
      //
      SetCanvasColor(aColumn, ACol, ARow, State);
      (*
      //------------------- set default background color ----------------------
      if gdFixed in State then
      begin
        Brush.Color := FFixedColor;
        Font.Color := clBlack;
        if FUseColumnFontSize then
          Font.Size := FColumnFontSize;
      end else
      if (gdSelected in State) and (not FSelectedFrameRect) then
      begin
        Brush.Color := FSelectedColor;
        Font.Color := FSelectedFontColor;
      end else
      if (aColumn <> nil) and (not aColumn.UseParentColor) then
      begin
        Brush.Color := aColumn.BackColor;
        Font.Color := aColumn.FontColor;
      end else
      begin
        Brush.Color := FBackColor;
        Font.Color := FBackFontColor;
      end;
      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      //&&>>>
      if Assigned(FOnOwnerStyle) and (aColumn <> nil) then
      begin
        aOwnerStyles := Grid.Canvas.Font.Style;
        aOwnerBackColor := Brush.Color;
        aOwnerFontColor := Font.Color;
        //
        FOnOwnerStyle(Grid, ACol, ARow, aColumn.Index,
          State, aOwnerBackColor, aOwnerFontColor, aOwnerStyles);
        //
        Brush.Color := aOwnerBackColor;
        Font.Color := aOwnerFontColor;
        Grid.Canvas.Font.Style := aOwnerStyles;
      end;
      *)
      //
      //
      if FOwnerData and (aColumn <> nil) then
      begin
        //
        bCallBack := False;
        //
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, ACol, ARow, aColumn.Title, vValue);
          bCallBack := True;
        end else
        if Assigned(FOnOwnerData2) then
        begin
          FOnOwnerData2(FGrid, ACol, ARow, aColumn.Index, vValue);
          bCallBack := True;
        end;
        //
        if bCallBack then
        begin
          //
          stText := GetCellVarString(vValue, aColumn.Scale, bIsNumeric);

          //---------  determine color in showcolorchange column --------------

          if //(not(gdSelected in State)) and
            (TVarData(vValue).VType in [varInteger, varDouble]) and
            (aColumn.ShowColorChange) then
          begin
            if IsZero(vValue) then
            else if vValue > 0 then   //positive number
            begin

              //아래 gdSelected in State 필요 없을까?
              //
              //if (not(gdSelected in State)) or (FSelectedFrameRect) then
              //begin
                Font.Color := FPositiveFontColor;
                Brush.Color := FPositiveBackColor;
              //end;
            end else      //negative number
            begin

              //if (not(gdSelected in State)) or (FSelectedFrameRect) then
              //begin
                Brush.Color := FNegativeBackColor;
                Font.Color := FNegativeFontColor;
              //end;
            end;
          end;

        end;
      end else
        stText := FGrid.Cells[ACol, ARow];
      //

      // print column
      if (aColumn <> nil) and (ARow = FColumnRow) then
      begin
        stText := aColumn._Title;
      end;
      //&&<<<
      //
      DrawCell(ACol, ARow, Rect, stText, aAlignment, iMargin, State);
      (*
      if IsMergedCell(ACol, ARow, aMergedRect) then
      begin
        //
        Brush.Color := FFixedColor;
        //
        if (aMergedRect.Rect.Left >= FGrid.LeftCol + FGrid.VisibleColCount) or
          (aMergedRect.Rect.Top >= FGrid.TopRow + FGrid.VisibleRowCount) then
        begin
          FillRect(Rect);
          Exit;
        end;
        //
        if (aMergedRect.Rect.Right >= FGrid.LeftCol + FGrid.VisibleColCount) then
          aMergedRect.Rect.Right := FGrid.LeftCol + FGrid.VisibleColCount;
        //
        if (aMergedRect.Rect.Left > aMergedRect.Rect.Right) then Exit;
        if (aMergedRect.Rect.Top > aMergedRect.Rect.Bottom) then Exit;
        //
        aRect1:= FGrid.CellRect(Max(FGrid.LeftCol, aMergedRect.Rect.Left) ,aMergedRect.Rect.Top);
        aRect2:= FGrid.CellRect(aMergedRect.Rect.Right, aMergedRect.Rect.Bottom);
        //
        aRect1.Right := aRect2.Right;
        aRect1.Bottom := aRect2.Bottom;
        //
        stText := aMergedRect.Value;
        //
        FillRect(aRect1);
        //
        if aRect1.Bottom - aRect1.TOP<=1 then Exit;
        //
        iX := aRect1.Left+(aRect1.Right-aRect1.Left-TextWidth(stText)) div 2;
        iY := aRect1.Top +(aRect1.Bottom-aRect1.Top-TextHeight(stText)) div 2;
        //
        Font.Color := clBlack;
        TextRect(aRect1, iX, iY, stText);
      end else
      begin //if not merged rect...
        //
        if FConsolidateRow > 1 then
        begin
          if (ARow+1-FGrid.FixedRows) mod FConsolidateRow <> 0 then
            Rect.Bottom := Rect.Bottom + FGrid.GridLineWidth;
        end;
        //-- background
        FillRect(Rect);
        //-- text
        if stText <> '' then
        begin
          //-- calc position
          aSize := TextExtent(stText);
          iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
          iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
          //-- put text
          case aAlignment of
            taLeftJustify :  iX := Rect.Left + 2 + iMargin;
            taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
            taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx - iMargin;
          end;
          TextRect(Rect, iX, iY, stText);
          //
        end;
        //
        if (gdSelected in State) and (FSelectedFrameRect) then
        begin
          Pen.Width := FSelectedFrameWidth;
          Pen.Color := FSelectedFontColor;
          MoveTo(Rect.Left-1, Rect.Top + FSelectedFrameWidth - 1);
          LineTo(Rect.Right, Rect.Top + FSelectedFrameWidth - 1);
          MoveTo(Rect.Left-1, Rect.Bottom-1);
          LineTo(Rect.Right, Rect.Bottom-1);
        end;
      end;
      //
      if Assigned(FOnOwnerDraw) then
        FOnOwnerDraw(Sender, ACol, ARow, Rect, State);
      *)
      //
    finally
      Pen.Color := aPenColor;
      Brush.Color := aBrushColor;
      Font.Color := aFontColor;
      Font.Style := aStyles;
    end;
  end;

  //except
  //  ShowMessage(Grid.Name+IntToStr(ARow));
  //end;

end;



procedure TGridUtilizer.SetGrid(const Value: TStringGrid);
begin
  FGrid := Value;
  //
  FGrid.OnDrawCell := CustomGridDrawCell;
  FGrid.OnTopLeftChanged := LeftTopChanged;
  FGrid.OnMouseUp := MouseUp;
  FGrid.OnDblClick := GridDblClick;
  //
end;

procedure TGridUtilizer.AddMergeInfo(iLeft, iTop, iRight,
  iBottom: Integer; stValue: String);
var
  iLength : Integer;

begin
  //
  iLength := Length(FMergedColRects);
  SetLength(FMergedColRects, iLength+1);
  FMergedColRects[iLength].Rect.Left := iLeft;
  FMergedColRects[iLength].Rect.Right := iRight;
  FMergedColRects[iLength].Rect.Top := iTop;
  FMergedColRects[iLength].Rect.Bottom := iBottom;
  FMergedColRects[iLength].Value := stValue;

  //
  FGrid.DefaultDrawing := False;
end;

function TGridUtilizer.IsMergedCell(iCol, iRow: Integer; var Rect: TMergedRect): Boolean;
var
  i : Integer;
  iLength : Integer;
begin
  Result := False;
  iLength := Length(FMergedColRects);
  //
  for i := 0 to iLength-1 do
  begin
    if (FMergedColRects[i].Rect.Left <= iCol) and (iCol <= FMergedColRects[i].Rect.Right) and
       (FMergedColRects[i].Rect.Top <= iRow) and (iRow <= FMergedColRects[i].Rect.Bottom) then
    begin
      Result := True;
      Rect := FMergedColRects[i];
      break;
    end;
  end;

end;

procedure TGridUtilizer.ClearMergeInfo;
begin
  SetLength(FMergedColRects, 0);
end;

procedure TGridUtilizer.LeftTopChanged(Sender: TObject);
begin
  //
  FGrid.Refresh;
end;

// grid의 width를 columns 의 width로  동기화한다.
procedure TGridUtilizer.RefreshColumnWidths;
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  if FOwnerColumn then
  begin
    for i := 0 to FGrid.ColCount-1 do
    begin
      if FGrid.Objects[i, FColumnRow] is TSColumnItem then
      begin
        aColumn := TSColumnItem(FGrid.Objects[i, FColumnRow]);
        FGrid.ColWidths[i] := aColumn.Width;

      end;
    end;
  end else
  begin
    //
    FGrid.ColCount := FColumns.ViewList.Count;
    //
    for i := 0 to FColumns.ViewList.Count-1 do
    begin
      aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
      //
      if i < FGrid.ColCount then
        FGrid.ColWidths[i] := aColumn.Width;
    end;
    //
  end;

end;


procedure TGridUtilizer.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //
  if Button = mbLeft then
  begin
    RefreshColumnWidthValues;
  end;
  //
  if Assigned(FOnOwnerMouseUp) then
    FOnOwnerMouseUp(Sender, Button, Shift, X, Y);

end;

//grid의 column width를 columns 오브젝트의 width 속성에 재할당한다.
procedure TGridUtilizer.RefreshColumnWidthValues;
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  if FOwnerColumn then
  begin
    for i := 0 to FGrid.ColCount-1 do
    begin
      if FGrid.Objects[i, FColumnRow] is TSColumnItem then
      begin
        aColumn := FGrid.Objects[i, FColumnRow] as TSColumnItem;
        //
        if aColumn.Width <> FGrid.ColWidths[i] then
        begin
          aColumn.Width := FGrid.ColWidths[i];
          if Assigned(FOnColumnSizing) then
            FOnColumnSizing(aColumn);
        end;
      end;
    end
  end else
  begin
    for i := 0 to FColumns.ViewList.Count-1 do
    begin
      aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
      if i < FGrid.ColCount then
      begin
        if aColumn.Width <> FGrid.ColWidths[i] then
        begin
          aColumn.Width := FGrid.ColWidths[i];
          //
          if Assigned(FOnColumnSizing) then
            FOnColumnSizing(aColumn);
        end;
      end;
    end;

  end;

end;

procedure TGridUtilizer.ColumnsSetPersistence(Sender: TObject);
begin
  //
  RefreshColumnWidths;
end;

function ExcelAddress(iCol, iRow: Integer): String;
const
  LENGTH = 26;
var
  iMul : Integer;
  iRemain : Integer;
begin
  Result := '';
  iRemain := (iCol-1) mod Length;
  Result := Result + Char(Ord('A')+iRemain);
  //
  iMul := (iCol-1) div LENGTH;

  if iMul > 0 then
    Result := Chr(Ord('A')+iMul-1)+RESULT;

  Result := Result + IntToStr(iRow);
end;

function TGridUtilizer.ExportToExcel(stWorkSheet: String; iFontSize: Integer) : _Application;
type
  AVarArray = array[0..3] of Variant;
  PAVarArray = ^AVarArray;
const
  EXCEL_FIXED = 15;
  EXCEL_BLACK = 1;
  EXCEL_WHITE = 2;
var
  aApplication : _Application;
  aWorkBook : _Workbook;
  aNewSheet, aSheet : _Worksheet;
  vWorkSheet : OleVariant;
  vRange : OleVariant;

  aColumn : TSColumnItem;
  i, j, iCnt : Integer;

  vValue : Variant;
  stText : String;
  dValue : Double;
  aMergedRect : TMergedRect;

  vArray : Variant;
  aSheets : Sheets;//OleVariant;
  bDuplicated : Boolean;
  stNewWorkSheet : String;
begin
  //
  Result := nil;
  //
  try
    aApplication := GetActiveOleObject('Excel.Application') as _Application;
  except
    try
      aApplication := CreateOleObject('Excel.Application') as _Application;
    except
      Exit;
    end;
  end;

  Result := aApplication;
  //
  if aApplication.ActiveWorkbook = nil then
    aWorkBook := aApplication.WorkBooks.Add(NULL, 0) as _Workbook
  else
    aWorkBook := aApplication.ActiveWorkbook;
  //
  aNewSheet := aWorkBook.Worksheets.Add(NULL, NULL, 1, xlWorkSheet, 0) as _WorkSheet;
  //
  stNewWorkSheet := stWorkSheet;
  vWorkSheet := aWorkBook.Worksheets[1];//stWorkSheet];
  aSheets := aWorkBook.Sheets;
  iCnt := 1;
  while True do
  begin

    bDuplicated := False;
    for i := 1 to aWorkBook.Sheets.Count do
    begin
      aSheet := aWorkBook.Sheets[i] as _Worksheet;
      if aSheet.Name = stNewWorkSheet then
      begin
        bDuplicated := True;
      end;
    end;
    //
    if bDuplicated then
      stNewWorkSheet := stWorkSheet + '_' + IntToStr(iCnt)
    else
    begin
      aNewSheet.Name := stNewWorkSheet;
      Break;
    end;


    Inc(iCnt);
  end;

   //
  //aWorkSheet := aWorkBook.ActiveSheet as _WorkSheet;
  vWorkSheet := aNewSheet;
  vWorkSheet.Cells.Font.Name := FGrid.Font.Name;
  vWorkSheet.Cells.Font.Size := iFontSize;
  //
  for i := 0 to FGrid.ColCount-1 do
  begin
    //
    aColumn := nil;
    //
    if FUseColumns and FOwnerColumn then
      aColumn := FGrid.Objects[i, FColumnRow] as TSColumnItem
    else if FUseColumns and (i <= FColumns.ViewList.Count-1) then
      aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
    //
    if aColumn <> nil then
    begin
      if aColumn.Alignment = taLeftJustify then
        vWorkSheet.Range[ExcelAddress(i+1, 1),
          ExcelAddress(i+1, FGrid.RowCount)].HorizontalAlignment := xlLeft
      else if aColumn.Alignment = taCenter then
        vWorkSheet.Range[ExcelAddress(i+1, 1),
          ExcelAddress(i+1, FGrid.RowCount)].HorizontalAlignment := xlCenter
      else
        vWorkSheet.Range[ExcelAddress(i+1, 1),
          ExcelAddress(i+1, FGrid.RowCount)].HorizontalAlignment := xlRight;
    end;
    //
    for j := 0 to FGrid.RowCount-1 do
    begin
      aColumn := nil;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[i, FColumnRow] as TSColumnItem
      else if FUseColumns and (i <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
      //
      if FOwnerData and (aColumn <> nil) then
      begin
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, i, j, aColumn.Title, vValue);
          if TVarData(vValue).VType = varInteger then
            stText := IntToStr(vValue)
          else if TVarData(vValue).VType = varDouble then
            stText := Format('%.*f', [aColumn.Scale, Double(vValue)])
          else if TVarData(vValue).VType = varString then
            stText := vValue;
          //
          if (TVarData(vValue).VType in [varInteger, varDouble]) and
            (aColumn.ShowColorChange) then
          begin
            try
              vWorkSheet.Cells[j+1, i+1].NumberFormat := '#,##;[빨강]-#,##'
            except
              try
                vWorkSheet.Cells[j+1, i+1].NumberFormat := '#,##;[RED]-#,##'
              except
              end;
            end;
          end;

          if FUseThousandComma then
          begin
            if TVarData(vValue).VType in [varInteger, varDouble] then
            begin
              dValue := vValue * 1.0;
              stText := Format('%.*n', [aColumn.Scale, dValue]);
            end;
          end;

        end;
      end else
        stText := FGrid.Cells[i, j];

      if (aColumn <> nil) and (j = FColumnRow) then
      begin
        stText := aColumn._Title;
      end;
      //
      //draw border of a cell
      //vWorkSheet.Cells[j+1, i+1].Borders.ColorIndex := EXCEL_BLACK;
      //

    end;

    if (i < FGrid.FixedCols) then
        vWorkSheet.Range[ExcelAddress(i+1, 1),
            ExcelAddress(i+1, FGrid.RowCount)].Interior.ColorIndex := EXCEL_FIXED;

  end;

  //-------------------------------------------------------------------------

  vArray := VarArrayCreate([1, FGrid.ColCount], varVariant);

  for i := 0 to FGrid.RowCount-1 do
  begin
    for j := 0 to FGrid.ColCount-1 do
    begin
      aColumn := nil;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[j, FColumnRow] as TSColumnItem
      else if FUseColumns and (j <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[j]);
      //
      if FOwnerData and (aColumn <> nil) then
      begin
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, j, i, aColumn.Title, vValue);
          if TVarData(vValue).VType = varInteger then
            stText := IntToStr(vValue)
          else if TVarData(vValue).VType = varDouble then
            stText := Format('%.*f', [aColumn.Scale, Double(vValue)])
          else if TVarData(vValue).VType = varString then
            stText := vValue;
          //

          if UseThousandComma then
          begin
            if TVarData(vValue).VType in [varInteger, varDouble] then
            begin
              dValue := vValue * 1.0;
              stText := Format('%.*n', [aColumn.Scale, dValue]);
            end;
          end;

        end;
      end else
        stText := FGrid.Cells[j, i];

      if (aColumn <> nil) and (i = FColumnRow) then
      begin
        stText := aColumn._Title;
      end;
      //
      //draw border of a cell
      //vWorkSheet.Cells[j+1, i+1].Borders.ColorIndex := EXCEL_BLACK;
      //


      vArray[j+1] := stText;

      //vWorkSheet.Cells[j+1, i+1].EntireColumn.AutoFit;
    end;



    if (i < FGrid.FixedRows) then
      vWorkSheet.Range[ExcelAddress(1,i+1),
          ExcelAddress(FGrid.ColCount, i+1)].Interior.ColorIndex := EXCEL_FIXED;


    vWorkSheet.Range[ExcelAddress(1,i+1),
          ExcelAddress(FGrid.ColCount, i+1)].Value := vArray;

  end;

  //merge 처리
  for i := 0 to FGrid.RowCount-1 do
    for  j := 0 to FGrid.ColCount-1 do
      if IsMergedCell(j, i, aMergedRect) then
      begin

        if (aMergedRect.Rect.Left = j) and (aMergedRect.Rect.Top = i) then
        begin

          vWorkSheet.Cells[i+1,j+1] := aMergedRect.Value;
          vRange := vWorkSheet.Range[ExcelAddress(aMergedRect.Rect.Left+1, aMergedRect.Rect.Top+1),
                      ExcelAddress(aMergedRect.Rect.Right+1, aMergedRect.Rect.Bottom+1)];
          vRange.Merge;
          vRange.HorizontalAlignment := xlCenter;

        end;

      end;

  for i := 0 to FGrid.ColCount-1 do
    vWorkSheet.Cells[1, i+1].EntireColumn.AutoFit;

  aApplication.Visible[0] := True;


end;

procedure TGridUtilizer.ExportToExcelChart(stName: String; iFontSize, xlChartType: Integer;
 aXColumn, aYColumn: TSColumnItem);
var
  iXColumnIndex, iYColumnIndex : Integer;

  //
  function GetColumnIndex(aColumn: TSColumnItem): Integer;
  var
    j : Integer;
    aGridColumn : TSColumnItem;

  begin
    Result := 0;
    for j := 0 to FGrid.ColCount-1 do
    begin
      aGridColumn := nil;
      if FUseColumns and FOwnerColumn then
        aGridColumn := FGrid.Objects[j, FColumnRow] as TSColumnItem
      else if FUseColumns and (j <= FColumns.ViewList.Count-1) then
        aGridColumn := TSColumnItem(FColumns.ViewList.Items[j]);
      //
      if aGridColumn = aColumn then
      begin
        Result := j;
        Break;
      end;
    end;
  end;

begin
  //
  iXColumnIndex := GetColumnIndex(aXColumn);
  iYColumnIndex := GetColumnIndex(aYColumn);
  //
  ExportToExcelChart(stName, iFontSize, xlChartType, iXColumnIndex, iYColumnIndex);
end;


procedure TGridUtilizer.ExportToExcelChart(stName: String; iFontSize, xlChartType, iXColumnIndex, iYColumnIndex: Integer);
var
  aApplication : _Application;
  vApplication : OleVariant;
  vWorkBook : OleVariant;
  vWorkSheet : OleVariant;
  vChart : OleVariant;
  vRange1, vRange2, vRange : OleVariant;
  dMin : Double;
  aDlg : TSelectExcelChartType;
begin
  //
  aApplication := ExportToExcel(stName, iFontSize);
  vApplication := aApplication;
  //
  if aApplication = nil then Exit;
  //
  vWorkBook := aApplication.ActiveWorkBook;
  vWorkSheet := vWorkBook.ActiveSheet;
  //
  vChart := vWorkBook.Charts.Add;
  vChart.ChartArea.Font.Name := FGrid.Font.Name;
  vChart.ChartArea.Font.Size := iFontSize;

  if xlChartType < 0 then
  begin
    aDlg := TSelectExcelChartType.Create(nil);

    try
      aDlg.Open;
      vChart.ChartType := aDlg.SelectType;
    finally
      aDlg.Free;
    end;

  end else
    vChart.ChartType := xlLineStacked;
  //
  vRange1 := vWorkSheet.Range[ExcelAddress(iXColumnIndex+1, 1),
        ExcelAddress(iXColumnIndex+1, FGrid.RowCount)];

  vRange2 := vWorkSheet.Range[ExcelAddress(iYColumnIndex+1, 1),
        ExcelAddress(iYColumnIndex+1, FGrid.RowCount)];
  vRange := vApplication.Union(vRange1, vRange2);

  vChart.SetSourceData(vRange , xlColumns);
  dMin := vApplication.WorksheetFunction.Min(vRange2);
  vChart.Axes(xlValue, xlPrimary).CrossesAt := dMin - Abs(dMin) * 0.01;
  vChart.Axes(xlValue).MajorGridLines.Border.LineStyle := xlDot;
end;

procedure TGridUtilizer.ExportToExcelChart(stName: String; iFontSize, xlChartType, iXRow :
  Integer; iColumns: array of Integer);

var
  i, iColumnIndex : Integer;
  aApplication : _Application;
  vApplication : OleVariant;
  vWorkBook : OleVariant;
  vWorkSheet : OleVariant;
  vChart : OleVariant;
  vRange1, vRange2, vRange : OleVariant;
  dMin : Double;
  aDlg : TSelectExcelChartType;
begin
  //
  aApplication := ExportToExcel(stName, iFontSize);
  vApplication := aApplication;
  //
  if aApplication = nil then Exit;
  //
  vWorkBook := aApplication.ActiveWorkBook;
  vWorkSheet := vWorkBook.ActiveSheet;
  //
  vChart := vWorkBook.Charts.Add;
  vChart.ChartArea.Font.Name := FGrid.Font.Name;
  vChart.ChartArea.Font.Size := iFontSize;
  //vChart.PlotBy := xlRows;

  if xlChartType < 0 then
  begin
    aDlg := TSelectExcelChartType.Create(nil);

    try
      aDlg.Open;
      vChart.ChartType := aDlg.SelectType;
    finally
      aDlg.Free;
    end;

  end else
    vChart.ChartType := xlLineStacked;
  //
  for i := 0 to Length(iColumns)-1 do
  begin
    iColumnIndex := iColumns[i];
    if i = 0 then
      vRange := vWorkSheet.Range[ExcelAddress(iColumnIndex+1, iXRow+1),
        ExcelAddress(iColumnIndex+1, iXRow+1)]
    else
    begin
      vRange1 := vWorkSheet.Range[ExcelAddress(iColumnIndex+1, iXRow+1),
        ExcelAddress(iColumnIndex+1, iXRow+1)];
      vRange := vApplication.Union(vRange1, vRange);
    end;
  end;

  vChart.SetSourceData(vRange , xlRows);
  dMin := vApplication.WorksheetFunction.Min(vRange2);
  vChart.Axes(xlValue, xlPrimary).CrossesAt := dMin - Abs(dMin) * 0.01;
  vChart.Axes(xlValue).MajorGridLines.Border.LineStyle := xlDot;

end;

procedure TGridUtilizer.RefreshColumnCount(iOffset: Integer);
begin
  FGrid.ColCount := FColumns.ViewList.Count+ iOffset;
end;

procedure TGridUtilizer.UpdateRow(iRow: Integer);
var
  i : Integer;
begin
  //
  for i := 0 to FGrid.ColCount-1 do
  begin
    if FGrid.Cells[i, iRow] = '0' then
      FGrid.Cells[i, iRow] := '1'
    else
      FGrid.Cells[i, iRow] := '0';
  end;

end;

function TGridUtilizer.ConfigColors(aOwner: TForm): Boolean;
var
  aDlg : TGridColorDialog;

begin
  //
  //
  aDlg := TGridColorDialog.Create(aOwner);
  aDlg.OnLoadDefault := ColorDefaultLoaded;

  try
    aDlg.ShapeFixed.Brush.Color := FFixedColor;
    aDlg.ShapeSelectedColor.Brush.Color := FSelectedColor;
    aDlg.ShapeSelectedFont.Brush.Color := FSelectedFontColor;
    aDlg.ShapePosBack.Brush.Color := FPositiveBackColor;
    aDlg.ShapePosFont.Brush.Color := FPositiveFontColor;
    aDlg.ShapeNegBack.Brush.Color := FNegativeBackColor;
    aDlg.ShapeNegFont.Brush.Color := FNegativeFontColor;
    aDlg.CheckSelectedFrameRect.Checked := FSelectedFrameRect;
    aDlg.ShapeBackColor.Brush.Color := FBackColor;
    aDlg.ShapeBackFontColor.Brush.Color := FBackFontColor;
    aDlg.EditSelectedFrameWidth.Text := IntToStr(FSelectedFrameWidth);
    aDlg.GridUtilizer := Self;
    //
    aDlg.InspectorGrid.AddColorProperty('GridColor', FGridColor);
    //
    Result := aDlg.ShowModal = mrOk;
    if Result then
    begin
      //
      FFixedColor := aDlg.ShapeFixed.Brush.Color;
      FSelectedColor := aDlg.ShapeSelectedColor.Brush.Color;
      FSelectedFontColor := aDlg.ShapeSelectedFont.Brush.Color;
      FPositiveFontColor := aDlg.ShapePosFont.Brush.Color;
      FPositiveBackColor := aDlg.ShapePosBack.Brush.Color;
      FNegativeFontColor := aDlg.ShapeNegFont.Brush.Color;
      FNegativeBackColor := aDlg.ShapeNegBack.Brush.Color;
      FBackColor := aDlg.ShapeBackColor.Brush.Color;
      FBackFontColor := aDlg.ShapeBackFontColor.Brush.Color;
      FSelectedFrameRect := aDlg.CheckSelectedFrameRect.Checked;
      FSelectedFrameWidth := StrToIntDef(aDlg.EditSelectedFrameWidth.Text, 1);
      //
      FGrid.Refresh;
      SaveEnvironment;

    end;

  finally
    aDlg.Free;
  end;
end;

function TGridUtilizer.ConfigFont(aOwner: TForm; bIncludeColumn: Boolean): Boolean;
var
  aDlg : TFontDialog;
  //aSize : TSize;
  //iSize : Integer;
  //i : Integer;
begin
  //
  aDlg := TFontDialog.Create(aOwner);

  try
    aDlg.Font := FGrid.Font;

    Result := aDlg.Execute;
    if Result then
    begin
      AssignFont(aDlg.Font, bIncludeColumn);
      SaveEnvironment;
      (*
      FGrid.Font.Assign(aDlg.Font);
      FGrid.Canvas.Font.Assign(aDlg.Font);
      //
      aSize := FGrid.Canvas.TextExtent('8');
      FGrid.DefaultRowHeight := aSize.cy + 2;
      //
      if bIncludeColumn then
        FColumnFontSize := FGrid.Canvas.Font.Size;

      if FUseColumnFontSize then
      begin
        iSize := FGrid.Canvas.Font.Size;
        try
          FGrid.Canvas.Font.Size := FColumnFontSize;
          aSize := FGrid.Canvas.TextExtent('8');
          for i := 0 to FGrid.FixedRows-1 do
            FGrid.RowHeights[i] := aSize.cy + 2;
        finally
          FGrid.Canvas.Font.Size := iSize;
        end;
      end;
      *)

    end;

  finally
    aDlg.Free;
  end;

end;

procedure TGridUtilizer.GetPersistence(aElement: IXMLDOMElement);
var
  aColumnsElement : IXMLDOMElement;
begin
  //
  aColumnsElement := MakeChildElement(aElement, 'columns');
  FColumns.GetPersistence(aColumnsElement);

  aElement.setAttribute('fixed_color', FFixedColor);
  aElement.setAttribute('selected_framerect', FSelectedFrameRect);
  aElement.setAttribute('selected_frame_width', FSelectedFrameWidth);
  aElement.setAttribute('selected_color', FSelectedColor);
  aElement.setAttribute('selected_fontcolor', FSelectedFontColor);
  aElement.setAttribute('pos_backcolor', FPositiveBackColor);
  aElement.setAttribute('pos_fontcolor', FPositiveFontColor);
  aElement.setAttribute('neg_backcolor', FNegativeBackColor);
  aElement.setAttribute('neg_fontcolor', FNegativeFontColor);
  aElement.setAttribute('back_color', FBackColor);
  aElement.setAttribute('back_font_color', FBackFontColor);
  //
  aElement.setAttribute('font', FGrid.Font.Name);
  aElement.setAttribute('font_size', FGrid.Font.Size);
  aElement.setAttribute('font_isbold', fsbold in FGrid.Font.Style);
  aElement.setAttribute('use_columnfont', FUseColumnFontSize);
end;

procedure TGridUtilizer.SetPersistence(aElement: IXMLDOMElement);
var
  stValue : String;
  i, iValue, iSize : Integer;
  bValue : Boolean;
  aSize : TSize;
  aColumnsNode : IXMLDOMElement;
begin
  aColumnsNode := GetFirstElementByTag(aElement, 'columns');
  //
  if aColumnsNode <> nil then
    FColumns.SetPersistence(aColumnsNode);
  //
  GetAttribute(aElement, 'fixed_color', FFixedColor);
  GetAttribute(aElement, 'selected_framerect', FSelectedFrameRect);
  GetAttribute(aElement, 'selected_frame_width', FSelectedFrameWidth);
  GetAttribute(aElement, 'selected_color', FSelectedColor);
  GetAttribute(aElement, 'selected_fontcolor', FSelectedFontColor);
  GetAttribute(aElement, 'pos_backcolor', FPositiveBackColor);
  GetAttribute(aElement, 'pos_fontcolor', FPositiveFontColor);
  GetAttribute(aElement, 'neg_backcolor', FNegativeBackColor);
  GetAttribute(aElement, 'neg_fontcolor', FNegativeFontColor);
  GetAttribute(aElement, 'back_color', FBackColor);
  GetAttribute(aElement, 'back_font_color', FBackFontColor);
  GetAttribute(aElement, 'use_columnfont', FUseColumnFontSize);
  //
  if GetAttribute(aElement, 'font', stValue) then
  begin
    FGrid.Font.Name := stValue;
    FGrid.Canvas.Font.Name := stValue;
  end;
  if GetAttribute(aElement, 'font_size', iValue) then
  begin
    FGrid.Font.Size := iValue;
    FGrid.Canvas.Font.Size := iValue;
    aSize := FGrid.Canvas.TextExtent('8');
    FGrid.DefaultRowHeight := aSize.cy + 2;

    if FUseColumnFontSize then
    begin
      iSize := FGrid.Canvas.Font.Size;
      try
        FGrid.Canvas.Font.Size := FColumnFontSize;
        aSize := FGrid.Canvas.TextExtent('8');
        for i := 0 to FGrid.FixedRows-1 do
          FGrid.RowHeights[i] := aSize.cy + 2;
      finally
        FGrid.Canvas.Font.Size := iSize;
      end;
    end;
  end;
  //
  if GetAttribute(aElement, 'font_isbold', bValue) then
  begin
    if bValue then
      FGrid.Font.Style := FGrid.Font.Style + [fsBold]
    else
      FGrid.Font.Style := FGrid.Font.Style - [fsBold];
  end;
  //
  FGrid.Refresh;

end;

procedure TGridUtilizer.SetBackColor(const Value: TColor);
begin
  FBackColor := Value;
end;

procedure TGridUtilizer.SetBackFontColor(const Value: TColor);
begin
  FBackFontColor := Value;
end;

procedure TGridUtilizer.AssignFont(aFont: TFont; bIncludeColumn: Boolean);
var
  aSize : TSize;
  i, iSize : Integer;
begin
  FGrid.Font.Assign(aFont);
  FGrid.Canvas.Font.Assign(aFont);
  //
  aSize := FGrid.Canvas.TextExtent('8');
  FGrid.DefaultRowHeight := aSize.cy + (aSize.cy div 10)*2 + 1{2};
  //
  if bIncludeColumn then
    FColumnFontSize := FGrid.Canvas.Font.Size;

  if FUseColumnFontSize then
  begin
    iSize := FGrid.Canvas.Font.Size;
    try
      FGrid.Canvas.Font.Size := FColumnFontSize;
      aSize := FGrid.Canvas.TextExtent('8');
      for i := 0 to FGrid.FixedRows-1 do
        FGrid.RowHeights[i] := aSize.cy + (aSize.cy div 15)*2 + 1{2};
    finally
      FGrid.Canvas.Font.Size := iSize;
    end;
  end;

end;

procedure TGridUtilizer.DisconnectEvents;
begin
  FOnOwnerData := nil;;
  FOnOwnerStyle := nil;
  FOnOwnerData2 := nil;
end;

procedure TGridUtilizer.AssignColumns(aColumns: TColumns);
var
  i : Integer;
  aSource, aTarget : TSColumnItem;
begin
  //
  FColumns.AllClear;
  FColumns.Assign(aColumns);
  for i := 0 to aColumns.ViewList.Count-1 do
  begin
    aSource := TSColumnItem(aColumns.ViewList.Items[i]);
    //
    aTarget := FColumns.Items[aSource.Index] as TSColumnItem;
    //
    if aTarget = nil then continue;
    //
    FColumns.ViewList.Add(aTarget);
  end;
  //
  RefreshColumnCount;
  RefreshColumnWidths;

end;

function TGridUtilizer.ConfigColumns(aOwner: TForm): Boolean;
begin
  Result := FColumns.Config(aOwner);
  //
  if Result then
  begin
    //
    RefreshColumnCount; //--inserted
    RefreshColumnWidths;
    FGrid.Refresh;
    SaveEnvironment;
  end;
end;

procedure TGridUtilizer.GridDblClick(Sender: TObject);
var
  aPoint : TPoint;
  iCol, iRow : Integer;
  aHint : TSMSHint;
  aColumn : TSColumnItem;
begin
  //
  GetCursorPos(aPoint);
  aPoint := FGrid.ScreenToClient(aPoint);
  FGrid.MouseToCell(aPoint.X, aPoint.Y, iCol, iRow);   
  //
  if Assigned(FOnDoubleClick) then
    FOnDoubleClick(FGrid, iCol, iRow);
  //
  if FColumnDoubleClickHint then
  begin
    //
    if (iRow = FColumnRow) and (iCol >= 0) and (iCol < FColumns.ViewList.Count) then
    begin
      //
      aColumn := FColumns.ViewList.Items[iCol];
      //
      aHint := NewSHint;
      //
      aHint.AddLine(aColumn._Title);
      if Length(aColumn.Desc) > 0 then
        aHint.AddLine(aColumn.Desc);
      aHint.ShowHint();
      //
    end;
  end;
  //
end;

function TGridUtilizer.SaveToCSV: Boolean;
var
  aColumn : TSColumnItem;
  i, j : Integer;
  vValue : Variant;
  stText : String;
  //
  stLine : String;
  aFiles : TStringList;
  aSaveDialog : TSaveDialog;

  stFile : String;
  bIsNumeric : Boolean;

begin
  //
  //Result := False;

  aSaveDialog := TSaveDialog.Create(FGrid);
  //
  try
    aSaveDialog.DefaultExt := '.csv';

    Result := aSaveDialog.Execute;
    //
    if Result then
      stFile := aSaveDialog.FileName;
  finally
    aSaveDialog.Free;
  end;
  //
  if not Result then Exit;
  //
  aFiles := TStringList.Create;

  try
    for i := 0 to FGrid.ColCount-1 do
    begin
      aColumn := nil;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[i, FColumnRow] as TSColumnItem
      else if FUseColumns and (i <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
      //
      stLine := stLine + aColumn._Title + ',';
    end;
    aFiles.Add(stLine);
    //
    for i := 0 to FGrid.RowCount-1 do
    begin
      //
      stLine := '';
      //
      for j := 0 to FGrid.ColCount-1 do
      begin
        aColumn := nil;
        //
        if FUseColumns and FOwnerColumn then
          aColumn := FGrid.Objects[j, FColumnRow] as TSColumnItem
        else if FUseColumns and (j <= FColumns.ViewList.Count-1) then
          aColumn := TSColumnItem(FColumns.ViewList.Items[j]);
        //
        //
        if FOwnerData and (aColumn <> nil) then
        begin
          if Assigned(FOnOwnerData) then
          begin
            FOnOwnerData(FGrid, j, i, aColumn.Title, vValue);
            stText := GetCellVarString(vValue, aColumn.Scale, bIsNumeric);
          end else
          if Assigned(FOnOwnerData2) then
          begin
            FOnOwnerData2(FGrid, j, i, aColumn.Index, vValue);
            stText := GetCellVarString(vValue, aColumn.Scale, bIsNumeric);
          end;
        end else
          stText := FGrid.Cells[i, j];

        if (aColumn <> nil) and (FOwnerColumn) and (j = FColumnRow) then
        begin
          stText := aColumn.Title;
        end;
        //
        stText := StringReplace(stText, ',', '', [rfReplaceAll]);
        stLine := stLine + stText + ',';

      end;
      aFiles.Add(stLine);

    end;
    aFiles.SaveToFile(stFile);
  finally
    aFiles.Free;
  end;


end;

procedure TGridUtilizer.AssignColor(aGridUtilizer: TGridUtilizer);
begin
  FixedColor := aGridUtilizer.FixedColor;
  SelectedColor := aGridUtilizer.SelectedColor;
  SelectedFontColor := aGridUtilizer.SelectedFontColor;
  PositiveFontColor := aGridUtilizer.PositiveFontColor;
  PositiveBackColor := aGridUtilizer.PositiveBackColor;
  NegativeFontColor := aGridUtilizer.NegativeFontColor;
  NegativeBackColor := aGridUtilizer.NegativeBackColor;
  BackColor := aGridUtilizer.BackColor;
  BackFontColor := aGridUtilizer.BackFontColor;
  FSelectedFrameRect := aGridUtilizer.FSelectedFrameRect;
  FSelectedFrameWidth := aGridUtilizer.FSelectedFrameWidth;
  //
  FGrid.Invalidate;
end;

procedure TGridUtilizer.AutoColumnSize(const iSpace: Integer; iStartRow: Integer);
var
  i : Integer;
begin
  //
  if FUseColumns then Exit;
  //
  for i := 0 to FGrid.ColCount-1 do
  begin
    FGrid.ColWidths[i] := GridColWidth(FGrid, i, iSpace, iStartRow);
  end;
end;

procedure TGridUtilizer.AssignFont(aFont: TFont; bIncludeColumn: Boolean;
  iColumnSpace: Integer; iStartRow: Integer);
begin
  AssignFont(aFont, bIncludeColumn);
  AutoColumnSize(iColumnSpace, iStartRow);
end;

procedure TGridUtilizer.AutoColumnWidth(const iSpace: Integer;
  iStartRow: Integer);
var
  i : Integer;
begin
  //
  for i := 0 to FGrid.ColCount-1 do
  begin
    FGrid.ColWidths[i] := GridColWidth(FGrid, i, iSpace, iStartRow);
  end;

end;

procedure TGridUtilizer.GetDefault(iVersion: Integer; stKey: String;
  aNode: IXMLDomElement);
begin

end;

procedure TGridUtilizer.SetDefault(iVersion: Integer; stKey: String;
  aNode: IXMLDomElement);
begin


end;

procedure TGridUtilizer.LoadEnvironment;
var
  aDoc : IXMLDOMDocument;
  stValue : String;
  i, iValue, iSize : Integer;
  aSize : TSize;
  bValue : Boolean;
begin
  aDoc := GetXMLDocument;
  //
  if not aDoc.load(FEnvPath + ENV_FILE) then Exit;
  //
  GetAttribute(aDoc.documentElement, 'fixed_color', FFixedColor);
  GetAttribute(aDoc.documentElement, 'selected_framerect', FSelectedFrameRect);
  GetAttribute(aDoc.documentElement, 'selected_frame_width', FSelectedFrameWidth);
  GetAttribute(aDoc.documentElement, 'selected_color', FSelectedColor);
  GetAttribute(aDoc.documentElement, 'selected_fontcolor', FSelectedFontColor);
  GetAttribute(aDoc.documentElement, 'pos_backcolor', FPositiveBackColor);
  GetAttribute(aDoc.documentElement, 'pos_fontcolor', FPositiveFontColor);
  GetAttribute(aDoc.documentElement, 'neg_backcolor', FNegativeBackColor);
  GetAttribute(aDoc.documentElement, 'neg_fontcolor', FNegativeFontColor);

  GetAttribute(aDoc.documentElement, 'use_columnfont', FUseColumnFontSize);
  //
  if GetAttribute(aDoc.documentElement, 'font', stValue) then
  begin
    FGrid.Font.Name := stValue;
    FGrid.Canvas.Font.Name := stValue;
  end;
  if GetAttribute(aDoc.documentElement, 'font_size', iValue) then
  begin
    FGrid.Font.Size := iValue;
    FGrid.Canvas.Font.Size := iValue;
    aSize := FGrid.Canvas.TextExtent('8');
    FGrid.DefaultRowHeight := aSize.cy + 2;

    if FUseColumnFontSize then
    begin
      iSize := FGrid.Canvas.Font.Size;
      try
        FGrid.Canvas.Font.Size := FColumnFontSize;
        aSize := FGrid.Canvas.TextExtent('8');
        for i := 0 to FGrid.FixedRows-1 do
          FGrid.RowHeights[i] := aSize.cy + 2;
      finally
        FGrid.Canvas.Font.Size := iSize;
      end;
    end;
  end;


  if GetAttribute(aDoc.documentElement, 'font_isbold', bValue) then
  begin
    if bValue then
      FGrid.Font.Style := FGrid.Font.Style + [fsBold]
    else
      FGrid.Font.Style := FGrid.Font.Style - [fsBold];
  end;
  //
  FGrid.Invalidate;

end;

procedure TGridUtilizer.SaveEnvironment;
var
  aDoc : IXMLDOMDocument;
  aElement : IXMLDOMElement;
begin
  aDoc := GetXMLDocument;

  aElement := MakeChildElement(aDoc, nil, 'environment');

  aElement.setAttribute('fixed_color', FFixedColor);
  aElement.setAttribute('selected_framerect', FSelectedFrameRect);
  aElement.setAttribute('selected_frame_width', FSelectedFrameWidth);
  aElement.setAttribute('selected_color', FSelectedColor);
  aElement.setAttribute('selected_fontcolor', FSelectedFontColor);
  aElement.setAttribute('pos_backcolor', FPositiveBackColor);
  aElement.setAttribute('pos_fontcolor', FPositiveFontColor);
  aElement.setAttribute('neg_backcolor', FNegativeBackColor);
  aElement.setAttribute('neg_fontcolor', FNegativeFontColor);
  //
  aElement.setAttribute('font', FGrid.Font.Name);
  aElement.setAttribute('font_size', FGrid.Font.Size);
  aElement.setAttribute('font_isbold', fsbold in FGrid.Font.Style);
  aElement.setAttribute('use_columnfont', FUseColumnFontSize);

  if DirectoryExists(FEnvPath) then
    aDoc.save(FEnvPath + ENV_FILE);
end;

procedure TGridUtilizer.SetEnvPath(const Value: String);
begin
  FEnvPath := Value;
  //
  LoadEnvironment;
end;

function TGridUtilizer.GetCellVarString(const aValue: Variant; const iScale: Integer;
   out bIsNumeric: Boolean): String;
var
  aVarType : Word;
begin
  Result := '';
  aVarType := TVarData(aValue).VType;
  //
  bIsNumeric := IsNumericVarType(aVarType);
  if bIsNumeric then
  begin
    if IsNan(aValue) then
      Result := 'Nan'
    else if FUseThousandComma then
      Result := Format('%.*n', [iScale, Double(aValue)*1.0])
    else
    begin
      if IsOrdinalVarType(aVarType) then
        Result := IntToStr(aValue)
      else if IsFloatPointVarType(aVarType) then
        Result := Format('%.*f', [iScale, Double(aValue)]);
    end;
  end else
    Result := aValue;

end;



{ TGridUtilizer2 }

(*
constructor TGridUtilizer2.Create(aGrid: TStringGrid);
begin
  inherited Create(aGrid);

  FRefColumn := -1;
end;

procedure TGridUtilizer2.CustomGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iMargin : Integer;
  stText : String;

  aPenColor, aBrushColor, aFontColor : TColor;
  aColumn : TSColumnItem;
  vValue : Variant;
  bCallBack : Boolean;
  aOwnerBackColor, aOwnerFontColor : TColor;
  aStyles, aOwnerStyles : TFontStyles;
begin
  //try
//  gLog.Add(lkDebug, FGrid.Name , IntToStr(ACol), IntToStr(ARow));

  aColumn := nil;
  //
  with FGrid.Canvas do
  begin
    aBrushColor := Brush.Color;
    aFontColor := Font.Color;
    aStyles := Font.Style;
    aPenColor := Pen.Color;
    //
    try
      //
      Font.Name := FGrid.Font.Name;
      Font.Size := FGrid.Font.Size;
      Font.Style := FGrid.Font.Style;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[ACol, FColumnRow] as TSColumnItem
      else if FUseColumns and (ACol <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[ACol]);
      //
      SetAlignmentMargin(aColumn, aAlignment, iMargin);
      {
      if aColumn <> nil then
      begin
        aAlignment := aColumn.Alignment;
        iMargin := aColumn.Margin;
      end else
      begin
        aAlignment :=taLeftJustify;
        iMargin := 0;
      end;
      }
      //------------------- set default background color ----------------------
      if gdFixed in State then
      begin
        Brush.Color := FFixedColor;
        Font.Color := clBlack;
        if FUseColumnFontSize then
          Font.Size := FColumnFontSize;
      end else
      if ((gdSelected in State) or ((ACol = FRefColumn) and (ARow = FGrid.Row))) and (not FSelectedFrameRect) then
      begin
        Brush.Color := FSelectedColor;
        Font.Color := FSelectedFontColor;
      end else
      if (aColumn <> nil) and (not aColumn.UseParentColor) then
      begin
        Brush.Color := aColumn.BackColor;
        Font.Color := aColumn.FontColor;
      end else
      begin
        Brush.Color := FBackColor;
        Font.Color := FBackFontColor;
      end;
      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

      if Assigned(FOnOwnerStyle) and (aColumn <> nil) then
      begin
        aOwnerStyles := Grid.Canvas.Font.Style;
        aOwnerBackColor := Brush.Color;
        aOwnerFontColor := Font.Color;
        //
        FOnOwnerStyle(Grid, ACol, ARow, aColumn.Index,
          State, aOwnerBackColor, aOwnerFontColor, aOwnerStyles);
        //
        Brush.Color := aOwnerBackColor;
        Font.Color := aOwnerFontColor;
        Grid.Canvas.Font.Style := aOwnerStyles;
      end;

      if FOwnerData and (aColumn <> nil) then
      begin
        //
        bCallBack := False;
        //
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, ACol, ARow, aColumn.Title, vValue);
          bCallBack := True;
        end else
        if Assigned(FOnOwnerData2) then
        begin
          FOnOwnerData2(FGrid, ACol, ARow, aColumn.Index, vValue);
          bCallBack := True;
        end;
        //
        if bCallBack then
        begin
          //
          stText := GetCellVarString(vValue, aColumn.Scale);

          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

          //---------  determine color in showcolorchange column --------------

          if //(not(gdSelected in State)) and
            (TVarData(vValue).VType in [varInteger, varDouble]) and
            (aColumn.ShowColorChange) then
          begin
            if IsZero(vValue) then
            else if vValue > 0 then   //positive number
            begin

              //아래 gdSelected in State 필요 없을까?
              //
              //if (not(gdSelected in State)) or (FSelectedFrameRect) then
              //begin
                Font.Color := FPositiveFontColor;
                Brush.Color := FPositiveBackColor;
              //end;
            end else      //negative number
            begin

              //if (not(gdSelected in State)) or (FSelectedFrameRect) then
              //begin
                Brush.Color := FNegativeBackColor;
                Font.Color := FNegativeFontColor;
              //end;
            end;
          end;

        end;
      end else
        stText := FGrid.Cells[ACol, ARow];
      //

      // print column
      if (aColumn <> nil) and (ARow = FColumnRow) then
      begin
        stText := aColumn.Title;
      end;
      //
      DrawCell(ACol, ARow, Rect, stText, aAlignment, iMargin, State);
      //
    finally
      Pen.Color := aPenColor;
      Brush.Color := aBrushColor;
      Font.Color := aFontColor;
      Font.Style := aStyles;
    end;
  end;

end;

procedure TGridUtilizer2.SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  //
  FGrid.Invalidate;
  //
  if Assigned(FOnUtilizerSelectCell) then
    FOnUtilizerSelectCell(Sender, ACol, ARow, CanSelect);
end;

procedure TGridUtilizer2.SetGrid(const Value: TStringGrid);
begin
  inherited SetGrid(Value);
  FGrid.OnSelectCell := SelectCell;

end;
*)
function TGridUtilizer.AddColumnView(stTitle, stDesc: String; iWidth,
  iPrecision: Integer; aAlignment: TAlignment;
  bUpDownColor: Boolean): TSColumnItem;
begin
  Result := AddColumnView(stTitle, iWidth, iPrecision, aAlignment, bUpDownColor);
  Result.Desc := stDesc;
end;

{ TGridUtilizer3 }

constructor TGridUtilizer3.Create(aGrid: TStringGrid);
begin
  inherited Create(aGrid);
  //
  FRefColumn := -1;
end;

procedure TGridUtilizer3.CustomGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iMargin : Integer;
  stText : String;

  aPenColor, aBrushColor, aFontColor : TColor;
  aColumn : TSColumnItem;
  dValue : Double;
  bOwnerConnected : Boolean;
  aStyles : TFontStyles;

begin
  //gLog.Add(lkDebug, FGrid.Name , IntToStr(ACol), IntToStr(ARow));

  aColumn := nil;
  //
  with FGrid.Canvas do
  begin
    aBrushColor := Brush.Color;
    aFontColor := Font.Color;
    aStyles := Font.Style;
    aPenColor := Pen.Color;
    //
    try
      //
      Font.Name := FGrid.Font.Name;
      Font.Size := FGrid.Font.Size;
      Font.Style := FGrid.Font.Style;
      //
      dValue := NaN;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[ACol, FColumnRow] as TSColumnItem
      else if FUseColumns and (ACol <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[ACol]);
      //
      SetAlignmentMargin(aColumn, aAlignment, iMargin);
      stText := GetCellText(aColumn, ACol, ARow, bOwnerConnected, dValue);
      //
      SetCanvasColor2(aColumn, ACol, ARow, State, bOwnerConnected, dValue);
      DrawCell(ACol, ARow, Rect, stText, aAlignment, iMargin, State);
      //
    finally
      Pen.Color := aPenColor;
      Brush.Color := aBrushColor;
      Font.Color := aFontColor;
      Font.Style := aStyles;
    end;
  end;

end;

procedure TGridUtilizer3.SetGrid(const Value: TStringGrid);
begin
  inherited SetGrid(Value);
  FGrid.OnSelectCell := SelectCell;
end;

procedure TGridUtilizer3.SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  //
  FGrid.Invalidate;
  //
  if Assigned(FOnUtilizerSelectCell) then
    FOnUtilizerSelectCell(Sender, ACol, ARow, CanSelect);
end;

{ TGridUtilizer4 }

(*
procedure TGridUtilizer4.CustomGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iMargin : Integer;
  stText : String;
  aPenColor, aBrushColor, aFontColor : TColor;
  aColumn : TSColumnItem;
  vValue : Variant;
  bCallBack : Boolean;
  aOwnerBackColor, aOwnerFontColor : TColor;
  aStyles, aOwnerStyles : TFontStyles;
begin
  //
  aColumn := nil;
  //
  with FGrid.Canvas do
  begin
    aBrushColor := Brush.Color;
    aFontColor := Font.Color;
    aStyles := Font.Style;
    aPenColor := Pen.Color;
    //
    try
      //
      Font.Name := FGrid.Font.Name;
      Font.Size := FGrid.Font.Size;
      Font.Style := FGrid.Font.Style;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[ACol, FColumnRow] as TSColumnItem
      else if FUseColumns and (ACol <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[ACol]);
      //
      SetAlignmentMargin(aColumn, aAlignment, iMargin);

      //------------------- set default background color ----------------------
      if gdFixed in State then
      begin
        Brush.Color := FFixedColor;
        Font.Color := clBlack;
        if FUseColumnFontSize then
          Font.Size := FColumnFontSize;
      end else
      //if (gdSelected in State) and (not FSelectedFrameRect) then
      if ((gdSelected in State) or ((ACol = FRefColumn) and (ARow = FGrid.Row))) and (not FSelectedFrameRect) then
      begin
        Brush.Color := FSelectedColor;
        Font.Color := FSelectedFontColor;
      end else
      if (aColumn <> nil) and (not aColumn.UseParentColor) then
      begin
        Brush.Color := aColumn.BackColor;
        Font.Color := aColumn.FontColor;
      end else
      begin
        Brush.Color := FBackColor;
        Font.Color := FBackFontColor;
      end;
      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      //
      bCallBack := False;
      if FOwnerData and (aColumn <> nil) then
      begin
        //
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, ACol, ARow, aColumn.Title, vValue);
          bCallBack := True;
        end else
        if Assigned(FOnOwnerData2) then
        begin
          FOnOwnerData2(FGrid, ACol, ARow, aColumn.Index, vValue);
          bCallBack := True;
        end;
        //
      end;

      // Ownerdata 를 사용하지 않더라도... showchangecolor 이면... up,down 색상을 표시한다.
      if bCallBack then
        stText := GetCellVarString(vValue, aColumn.Scale)
      else
      begin
        //
        stText := FGrid.Cells[ACol, ARow];
        vValue := StrToFloatDef(stText, 0);
      end;
      //  
      //---------  determine color in showcolorchange column --------------

      if (TVarData(vValue).VType in [varInteger, varDouble]) and
        (aColumn.ShowColorChange) then
      begin
        if IsZero(vValue) then
        else if vValue > 0 then   //positive number
        begin
          Font.Color := FPositiveFontColor;
          Brush.Color := FPositiveBackColor;
        end else      //negative number
        begin
          Brush.Color := FNegativeBackColor;
          Font.Color := FNegativeFontColor;
        end;
      end;
      //
      if Assigned(FOnOwnerStyle) and (aColumn <> nil) then
      begin
        aOwnerStyles := Grid.Canvas.Font.Style;
        aOwnerBackColor := Brush.Color;
        aOwnerFontColor := Font.Color;
        //
        FOnOwnerStyle(Grid, ACol, ARow, aColumn.Index,
          State, aOwnerBackColor, aOwnerFontColor, aOwnerStyles);
        //
        Brush.Color := aOwnerBackColor;
        Font.Color := aOwnerFontColor;
        Grid.Canvas.Font.Style := aOwnerStyles;
      end;

      // print column
      if (aColumn <> nil) and (ARow = FColumnRow) then
      begin
        stText := aColumn.Title;
      end;
      //
      DrawCell(ACol, ARow, Rect, stText, aAlignment, iMargin, State);
      //
    finally
      Pen.Color := aPenColor;
      Brush.Color := aBrushColor;
      Font.Color := aFontColor;
      Font.Style := aStyles;
    end;
  end;

end;
*)

procedure TGridUtilizer.DrawCell(const ACol, ARow: Integer; Rect: TRect;
  stText: String; aAlignment: TAlignment; iMargin: Integer; State: TGridDrawState);
var
  aMergedRect : TMergedRect;
  aRect1, aRect2 : TRect;
  //stText : String;
  iX, iY : Integer;
  aSize: TSize;
begin
  //
  with FGrid.Canvas do
  if IsMergedCell(ACol, ARow, aMergedRect) then
  begin
    //
    Brush.Color := FFixedColor;
    //
    if (aMergedRect.Rect.Left >= FGrid.LeftCol + FGrid.VisibleColCount) or
      (aMergedRect.Rect.Top >= FGrid.TopRow + FGrid.VisibleRowCount) then
    begin
      FillRect(Rect);
      Exit;
    end;
    //
    if (aMergedRect.Rect.Right >= FGrid.LeftCol + FGrid.VisibleColCount) then
      aMergedRect.Rect.Right := FGrid.LeftCol + FGrid.VisibleColCount;
    //
    if (aMergedRect.Rect.Left > aMergedRect.Rect.Right) then Exit;
    if (aMergedRect.Rect.Top > aMergedRect.Rect.Bottom) then Exit;
    //
    aRect1:= FGrid.CellRect(Max(FGrid.LeftCol, aMergedRect.Rect.Left) ,aMergedRect.Rect.Top);
    aRect2:= FGrid.CellRect(aMergedRect.Rect.Right, aMergedRect.Rect.Bottom);
    //
    aRect1.Right := aRect2.Right;
    aRect1.Bottom := aRect2.Bottom;
    //
    stText := aMergedRect.Value;
    //
    FillRect(aRect1);
    //
    if aRect1.Bottom - aRect1.TOP<=1 then Exit;
    //
    iX := aRect1.Left+(aRect1.Right-aRect1.Left-TextWidth(stText)) div 2;
    iY := aRect1.Top +(aRect1.Bottom-aRect1.Top-TextHeight(stText)) div 2;
    //
    Font.Color := clBlack;
    TextRect(aRect1, iX, iY, stText);
  end else
  begin //if not merged rect...
    //
    if FConsolidateRow > 1 then
    begin
      if (ARow+1-FGrid.FixedRows) mod FConsolidateRow <> 0 then
        Rect.Bottom := Rect.Bottom + FGrid.GridLineWidth;
    end;
    //-- background
    FillRect(Rect);
    //-- text
    if stText <> '' then
    begin
      //-- calc position
      aSize := TextExtent(stText);
      iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
      iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      //-- put text
      case aAlignment of
        taLeftJustify :  iX := Rect.Left + 2 + iMargin;
        taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
        taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx - iMargin;
      end;
      TextRect(Rect, iX, iY, stText);
      //
    end;
    //
    if (gdSelected in State) and (FSelectedFrameRect) and (FSelectedFrameWidth  > 0) then
    begin
      Pen.Width := FSelectedFrameWidth;
      Pen.Color := FSelectedFontColor;
      MoveTo(Rect.Left-1, Rect.Top + FSelectedFrameWidth - 1);
      LineTo(Rect.Right, Rect.Top + FSelectedFrameWidth - 1);
      MoveTo(Rect.Left-1, Rect.Bottom-1);
      LineTo(Rect.Right, Rect.Bottom-1);
    end;
  end;
  //
  if Assigned(FOnOwnerDraw) then
    FOnOwnerDraw(FGrid, ACol, ARow, Rect, State);

end;

procedure TGridUtilizer.SetCanvasColor(aColumn: TSColumnItem;
  const ACol, ARow: Integer; State: TGridDrawState);
var
  aOwnerStyles : TFontStyles;
  aOwnerBackColor, aOwnerFontColor : TColor;

begin
  with FGrid.Canvas do
  begin
    if gdFixed in State then
    begin
      Brush.Color := FFixedColor;
      Font.Color := clBlack;
      if FUseColumnFontSize then
        Font.Size := FColumnFontSize;
    end else
    if (gdSelected in State) and (not FSelectedFrameRect) then
    begin
      Brush.Color := FSelectedColor;
      Font.Color := FSelectedFontColor;
    end else
    if (aColumn <> nil) and (not aColumn.UseParentColor) then
    begin
      Brush.Color := aColumn.BackColor;
      Font.Color := aColumn.FontColor;
    end else
    begin
      Brush.Color := FBackColor;
      Font.Color := FBackFontColor;
    end;
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    //&&>>>
    if Assigned(FOnOwnerStyle) and (aColumn <> nil) then
    begin
      aOwnerStyles := Grid.Canvas.Font.Style;
      aOwnerBackColor := Brush.Color;
      aOwnerFontColor := Font.Color;
      //
      FOnOwnerStyle(Grid, ACol, ARow, aColumn.Index,
        State, aOwnerBackColor, aOwnerFontColor, aOwnerStyles);
      //
      Brush.Color := aOwnerBackColor;
      Font.Color := aOwnerFontColor;
      Grid.Canvas.Font.Style := aOwnerStyles;
    end;
  end;
end;

procedure TGridUtilizer3.SetCanvasColor2(aColumn: TSColumnItem;
  const ACol, ARow: Integer; State: TGridDrawState;
    const bOwnerDataConnected: Boolean; const dValue: Double);
var
  aOwnerStyles : TFontStyles;
  aOwnerBackColor, aOwnerFontColor : TColor;
  bIsRefColumn : Boolean;
begin
  with FGrid.Canvas do
  begin
    bIsRefColumn := (ACol = FRefColumn) and (ARow = FGrid.Row);
    //
    if gdFixed in State then
    begin
      Brush.Color := FFixedColor;
      Font.Color := clBlack;
      if FUseColumnFontSize then
        Font.Size := FColumnFontSize;
    end else
    if (aColumn <> nil) and aColumn.UseGradationEffect and
      (aColumn.GradationMinValue <= dValue) and (dValue <= aColumn.GradationMaxValue) then
    begin
      {
      Brush.Color := GetGradationColor(aColumn.GradationMaxColor, aColumn.GradationMinColor,
        (dValue - aColumn.GradationMinValue) / (aColumn.GradationMaxValue - aColumn.GradationMinValue));
      }
      Brush.Color := DecBrightness(aColumn.GradationMaxColor,
        (dValue - aColumn.GradationMinValue) / (aColumn.GradationMaxValue - aColumn.GradationMinValue)*100);


      Font.Color := FBackFontColor;
    end else
    if bOwnerDataConnected and (aColumn.ShowColorChange) then
    begin
      //
      if IsInfinite(dValue) or IsZero(dValue) then
      else if dValue > 0 then   //positive number
      begin
        Font.Color := FPositiveFontColor;
        Brush.Color := FPositiveBackColor;
      end else      //negative number
      begin
        Brush.Color := FNegativeBackColor;
        Font.Color := FNegativeFontColor;
      end;
      //
    end else
    if ((gdSelected in State) or bIsRefColumn) and (not FSelectedFrameRect) then
    begin
      Brush.Color := FSelectedColor;
      Font.Color := FSelectedFontColor;
    end else
    if (aColumn <> nil) and (not aColumn.UseParentColor) then
    begin
      Brush.Color := aColumn.BackColor;
      Font.Color := aColumn.FontColor;
    end else
    begin
      Brush.Color := FBackColor;
      Font.Color := FBackFontColor;
    end;
    //
    if Assigned(FOnOwnerStyle) and (aColumn <> nil) then
    begin
      aOwnerStyles := Grid.Canvas.Font.Style;
      aOwnerBackColor := Brush.Color;
      aOwnerFontColor := Font.Color;
      //
      FOnOwnerStyle(Grid, ACol, ARow, aColumn.Index,
        State, aOwnerBackColor, aOwnerFontColor, aOwnerStyles);
      //
      Brush.Color := aOwnerBackColor;
      Font.Color := aOwnerFontColor;
      Grid.Canvas.Font.Style := aOwnerStyles;
    end;
  end;
end;


function TGridUtilizer.GetCellText(const aColumn: TSColumnItem;
  const ACol, ARow: Integer; var bOwnerDataConnected: Boolean; var dValue: Double): String;
var
  vValue : Variant;
  bIsNumeric : Boolean;
begin
  Result := '';
  //
  bOwnerDataConnected := False;
  //
  if FOwnerData and (aColumn <> nil) then
  begin
    //
    if Assigned(FOnOwnerData) then
    begin
      FOnOwnerData(FGrid, ACol, ARow, aColumn.Title, vValue);
      bOwnerDataConnected := True;
    end else
    if Assigned(FOnOwnerData2) then
    begin
      FOnOwnerData2(FGrid, ACol, ARow, aColumn.Index, vValue);
      bOwnerDataConnected := True;
    end;
    //
    if bOwnerDataConnected then
    begin
      //
      Result := GetCellVarString(vValue, aColumn.Scale, bIsNumeric);
      if bIsNumeric then dValue := vValue
      else dValue := NaN;
      //
    end;
  end;

  if not bOwnerDataConnected then
    Result := FGrid.Cells[ACol, ARow];
  //

  // print column
  if (aColumn <> nil) and (ARow = FColumnRow) then
    Result := aColumn._Title;


end;

procedure TGridUtilizer.SetAlignmentMargin(aColumn: TSColumnItem;
  var aAlignment: TAlignment; var iMargin: Integer);
begin
  if aColumn <> nil then
  begin
    aAlignment := aColumn.Alignment;
    iMargin := aColumn.Margin;
  end else
  begin
    aAlignment :=taLeftJustify;
    iMargin := 0;
  end;

end;

procedure TGridUtilizer.AutoPopup(aMenu: TMenuItem);
var
  aSubMenu : TMenuItem;
begin
  //
  if aMenu = nil then Exit;
  //
  aMenu.Clear;
  aMenu.OnClick := nil;
  //
  aSubMenu := TMenuItem.Create(FGrid);
  aSubMenu.Caption := 'Format Columns';
  aSubMenu.OnClick := FormatMenuColumnsClick;
  aMenu.Add(aSubMenu);
  //
  aSubMenu := TMenuItem.Create(FGrid);
  aSubMenu.Caption := 'Format Colors';
  aSubMenu.OnClick := FormatMenuColorClick;
  aMenu.Add(aSubMenu);
  //
  aSubMenu := TMenuItem.Create(FGrid);
  aSubMenu.Caption := 'Format Font';
  aSubMenu.OnClick := FormatMenuFontClick;
  aMenu.Add(aSubMenu);


end;

procedure TGridUtilizer.FormatMenuColumnsClick(Sender: TObject);
begin
  if ConfigColumns(nil) then
  begin
    if Assigned(FOnAfterColumnsAlignChange) then
      FOnAfterColumnsAlignChange(Self);
    //
    FGrid.Invalidate;
  end;
end;

procedure TGridUtilizer.FormatMenuColorClick(Sender: TObject);
begin
  if ConfigColors(nil) then
    FGrid.Invalidate;
end;

procedure TGridUtilizer.FormatMenuFontClick(Sender: TObject);
begin
  if ConfigFont(nil) then
    FGrid.Invalidate;
end;

procedure TGridUtilizer.AutoPopup(aPopup: TPopupMenu);
var
  aMenu : TMenuItem;
begin
  //
  if aPopup = nil then Exit;
  //
  FGrid.PopupMenu := aPopup;
  //
  aMenu := TMenuItem.Create(FGrid);
  aMenu.Caption := 'Format Grid';
  aPopup.Items.Add(aMenu);
  //
  AutoPopup(aMenu);
end;

procedure TGridUtilizer.InitColors;
begin
  FFixedColor := clBtnFace;
  FSelectedFrameRect := True;//False;
  FSelectedFrameWidth := 1;
  FSelectedColor := $00F2BEB9;
  FSelectedFontColor := clBlack;
  FPositiveFontColor := clRed;
  FNegativeFontColor := clBlue;
  FPositiveBackColor := clWhite;
  FNegativeBackColor := clWhite;
  FBackColor := clWhite;
  FBackFontColor := clBlack;

  FGridColor := clWindow;
end;

procedure TGridUtilizer.ColorDefaultLoaded(Sender: TObject);
var
  aDialog : TGridColorDialog;
begin
  if not(Sender is TGridColorDialog) then Exit;
  //
  aDialog := Sender as TGridColorDialog;
  //
  InitColors;
  //
  with aDialog do
  begin
  ShapeFixed.Brush.Color := FFixedColor;
  ShapeSelectedColor.Brush.Color := FSelectedColor;
  ShapeSelectedFont.Brush.Color := FSelectedFontColor;
  ShapePosBack.Brush.Color := FPositiveBackColor;
  ShapePosFont.Brush.Color := FPositiveFontColor;
  ShapeNegBack.Brush.Color := FNegativeBackColor;
  ShapeNegFont.Brush.Color := FNegativeFontColor;
  CheckSelectedFrameRect.Checked := FSelectedFrameRect;
  ShapeBackColor.Brush.Color := FBackColor;
  ShapeBackFontColor.Brush.Color := FBackFontColor;
  EditSelectedFrameWidth.Text := IntToStr(FSelectedFrameWidth);
  end;


end;

end.


{
oWB.Charts.Add;
oWB.ActiveChart.ChartType := xlLineMarkers;
oWB.ActiveChart.SetSourceData(oSheet.Range['C'+intToStr(liStart+3)+':C'+intToStr(liStart+7)], xlColumns);
oWB.ActiveChart.SeriesCollection[1].XValues := '='''+lsComName+'-'+lsRN+'''!R'+intToStr(liStart+4)+'C2:R'+intToStr(liStart+7)+'C2';
oWB.ActiveChart.Location(xlLocationAsObject, lsComName+'-'+lsRN);
oWB.ActiveChart.HasTitle := False;
oWB.ActiveChart.Axes(xlCategory, xlPrimary).HasTitle := True;
oWB.ActiveChart.Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text := '농도';
oWB.ActiveChart.Axes(xlValue, xlPrimary).HasTitle := True;
oWB.ActiveChart.Axes(xlValue, xlPrimary).AxisTitle.Characters.Text := '흡광도';
oWB.ActiveChart.Axes(xlCategory).HasMajorGridlines := True;
oWB.ActiveChart.Axes(xlCategory).HasMinorGridlines := True;
oWB.ActiveChart.Axes(xlCategory).AxisBetweenCategories := False; //가로축 0에서부터 시작
oWB.ActiveChart.Axes(xlValue).HasMajorGridlines := True;
oWB.ActiveChart.Axes(xlValue).HasMinorGridlines := False;
oWB.ActiveChart.HasLegend := False;
oWB.ActiveChart.HasDataTable := False;
oWB.ActiveChart.PlotArea.Interior.ColorIndex := xlNone;
}
