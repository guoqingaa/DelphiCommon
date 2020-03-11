unit SMS_FormatColumns;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, Commctrl,



  SMS_Columns, ComCtrls, ExtCtrls, Menus,
  SMS_DColEdit, ImgList;

type
  TColumnCfgSet = class
  private
    FConfigForm : TForm;
    FListFields : TListView;
    FListSelected : TListView;
    FBtnSelect : TSpeedButton;
    FBtnSelectAll : TSpeedButton;
    FBtnUnSelect : TSpeedButton;
    FBtnUnSelectAll : TSpeedButton;
    FBtnUp : TSpeedButton;
    FBtnDown : TSpeedButton;
    FCheckDefault : TCheckBox;
    FButtonDefault : TButton;
    FButtonOK : TButton;
    FButtonCancel : TButton;
    FButtonHelp : TButton;

    FSelectedColor, FSelectedFontColor : TColor;

    procedure ItemChange(aList: TListView; iIndex1, iIndex2: Integer);
  public
    FColumns : TColumns;
    FSelectedLeft: TObject;
    FIsDefault : Boolean;

    constructor Create(aForm : TForm);
    destructor Destroy; override;

    // -- Setup Controls
    procedure SetListViewControls(aFields, aSelected: TListView);
    procedure SetSelectBtnControls(aSelect, aSelectAll, aUnSelect, aUnSelectAll, aUp, aDown: TSpeedButton);
    procedure SetButtonOKControls(aOK: TButton);
    procedure SetButtonCancelControls(aCancel: TButton);
    procedure SetButtonDefaultControls(aDefault: TButton);
    procedure SetButtonHelpControls(aHelp: TButton);
    procedure SetCheckControls(aCheck: TCheckBox);
    procedure SetSelectedColor(aColor: TColor);
    procedure SetSelectedFontColor(aColor: TColor);

    // -- Controls Event
    procedure ListFieldsDblClick(Sender: TObject);
    procedure ListFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListFieldsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListFieldsDrawItem(Sender: TCustomListView;
      Item: TListItem; Rect: TRect; State: TOwnerDrawState);
    procedure ListFieldsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListSelectedDblClick(Sender: TObject);
    procedure ListSelectedDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListSelectedDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    //procedure ListSelectedMouseDown(Sender: TObject; Button: TMouseButton;
    //  Shift: TShiftState; X, Y: Integer);
    procedure BtnMoveClick(Sender: TObject);
    procedure ItmeMove(Sender: TObject);
    procedure CheckDefaultClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonDefaultClick(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);

    procedure Init(aColumns: TColumns);
      
    property IsDefault : Boolean read FIsDefault;
    property SelectedColor : TColor write SetSelectedColor;
    property SelectedFontColor : TColor write SetSelectedFontColor;
  end;

implementation

{ TColumnCfgSet }

const
  SELECTED_COLOR = $00F2BEB9;
  ODD_COLOR = $FFFFFF;
  EVEN_COLOR = $EEEEEE;



constructor TColumnCfgSet.Create(aForm: TForm);
begin
  FConfigForm := aForm;

  if FConfigForm = nil then
    raise Exception.Create('폼이 할당되어야합니다');

  FSelectedColor := SELECTED_COLOR;
  FSelectedFontColor := clWhite;
  FIsDefault := False;
end;

destructor TColumnCfgSet.Destroy;
begin

  inherited;
end;

// Setup Controls
procedure TColumnCfgSet.SetListViewControls(aFields, aSelected: TListView);
begin
  FListFields := aFields;
  FListSelected := aSelected;

  FListFields.Tag := 10;
  FListSelected.Tag := 20;

  FListFields.OnDblClick := ListFieldsDblClick;
  FListFields.OnDragDrop := ListFieldsDragDrop;
  FListFields.OnDragOver := ListFieldsDragOver;
  FListFields.OnDrawItem := ListFieldsDrawItem;
  FListFields.OnSelectItem := ListFieldsSelectItem;

  FListSelected.OnDblClick := ListSelectedDblClick;
  FListSelected.OnDragDrop := ListSelectedDragDrop;
  FListSelected.OnDragOver := ListSelectedDragOver;
  FListSelected.OnDrawItem := ListFieldsDrawItem;
  //FListSelected.OnMouseDown := ListSelectedMouseDown;
end;

procedure TColumnCfgSet.SetSelectBtnControls(aSelect, aSelectAll, aUnSelect,
  aUnSelectAll, aUp, aDown: TSpeedButton);
begin
  FBtnSelect := aSelect;
  FBtnSelectAll := aSelectAll;
  FBtnUnSelect := aUnSelect;
  FBtnUnSelectAll := aUnSelectAll;
  FBtnUp := aUp;
  FBtnDown := aDown;

  FBtnSelect.ShowHint := True;
  FBtnSelectAll.ShowHint := True;
  FBtnUnSelect.ShowHint := True;
  FBtnUnSelectAll.ShowHint := True;
  FBtnSelect.Hint := '선택';
  FBtnSelectAll.Hint := '전체 선택';
  FBtnUnSelect.Hint := '선택취소';
  FBtnUnSelectAll.Hint := '전체 선택취소';

  FBtnUp.ShowHint := True;
  FBtnDown.ShowHint := True;
  FBtnUp.Hint := '위로';
  FBtnDown.Hint := '아래로';

  FBtnSelect.Tag := 100;
  FBtnSelectAll.Tag := 200;
  FBtnUnSelect.Tag := 300;
  FBtnUnSelectAll.Tag := 400;
  FBtnUp.Tag := 700;
  FBtnDown.Tag := 800;

  FBtnSelect.OnClick := BtnMoveClick;
  FBtnSelectAll.OnClick := BtnMoveClick;
  FBtnUnSelect.OnClick := BtnMoveClick;
  FBtnUnSelectAll.OnClick := BtnMoveClick;
  FBtnUp.OnClick := ItmeMove;
  FBtnDown.OnClick := ItmeMove;
end;

procedure TColumnCfgSet.SetButtonOKControls(aOK: TButton);
begin
  FButtonOK := aOK;
  FButtonOK.Tag := 12;
  FButtonOK.OnClick := ButtonOKClick;
end;

procedure TColumnCfgSet.SetButtonCancelControls(aCancel: TButton);
begin
  FButtonCancel := aCancel;
  FButtonCancel.Tag := 13;
  FButtonCancel.OnClick := ButtonCancelClick;
end;

procedure TColumnCfgSet.SetButtonDefaultControls(aDefault: TButton);
begin
  FButtonDefault := aDefault;
  FButtonDefault.Tag := 11;
  FButtonDefault.OnClick := ButtonDefaultClick;
end;

procedure TColumnCfgSet.SetButtonHelpControls(aHelp: TButton);
begin
  FButtonHelp := aHelp;
  FButtonHelp.OnClick := ButtonHelpClick;
end;

procedure TColumnCfgSet.SetCheckControls(aCheck: TCheckBox);
begin
  FCheckDefault := aCheck;
  FCheckDefault.OnClick := CheckDefaultClick;
end;

procedure TColumnCfgSet.SetSelectedColor(aColor: TColor);
begin
  FSelectedColor := aColor;
end;

procedure TColumnCfgSet.SetSelectedFontColor(aColor: TColor);
begin
  FSelectedFontColor := aColor;
end;

// -----------------------------------------------------------------------------
// ---------------------- Controls Event
// -----------------------------------------------------------------------------
// -- ListView Event
procedure TColumnCfgSet.ListFieldsDblClick(Sender: TObject);
begin
  BtnMoveClick(FBtnSelect);
end;

procedure TColumnCfgSet.ListFieldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if not(Sender is TListView) then Exit;
  if not (Source is TListView) then Exit;

  if ((Sender as TListView).Tag = 10) and ((Source as TListView).Tag = 20) then
    BtnMoveClick(FBtnUnSelect);
end;

procedure TColumnCfgSet.ListFieldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if not(Sender is TListView) then Exit;
  if not (Source is TListView) then Exit;
  
  if ((Sender as TListView).Tag = 10) and ((Source as TListView).Tag = 20) then
    Accept := True
  else
    Accept := False;
end;

procedure TColumnCfgSet.ListFieldsDrawItem(Sender: TCustomListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
  aListView : TListView;
begin
  if Sender = nil then Exit;
  if not(Sender is TListView) then Exit;
  
  aListView := Sender as TListView;

  Rect.Bottom := Rect.Bottom-1;
  //
  with aListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := FSelectedColor;
      Font.Color := FSelectedFontColor;
    end else
    begin
      Font.Color := clBlack;
      if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (aListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      aListView.SmallImages.Draw(aListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then

      //if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(aListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption);
      {
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
      }
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= aListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(aListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case aListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(aListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(aListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(aListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
{  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;
}
end;

procedure TColumnCfgSet.ListFieldsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  // 왼쪽 항목이 선택됨
  if Selected then
  begin
    FSelectedLeft:= TSColumnItem(Item.Data);
  end
  else
    FSelectedLeft:= nil;
end;

procedure TColumnCfgSet.ListSelectedDblClick(Sender: TObject);
begin
  BtnMoveClick(FBtnUnSelect);
end;

procedure TColumnCfgSet.ListSelectedDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if not(Sender is TListView) then Exit;
  if not (Source is TListView) then Exit;

  if ((Sender as TListView).Tag = 20) and ((Source as TListView).Tag = 10) then
    BtnMoveClick(FBtnSelect);

{$ifdef DEBUG}
//  gLog.Add(lkDebug, 'DColumnCfg', 'ClassName', Sender.ClassName);
{$endif}
end;

procedure TColumnCfgSet.ListSelectedDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if not(Sender is TListView) then Exit;
  if not (Source is TListView) then Exit;

  if ((Sender as TListView).Tag = 20) and ((Source as TListView).Tag = 10) then
    Accept := True
  else
    Accept := False;
end;

(*
procedure TColumnCfgSet.ListSelectedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aColumnTypes : TColumnTypes;
  {i,} iFlag: Integer;
  aColumn : TSColumnItem;
begin
  if Button <> mbRight then Exit;  // Mouse Right Button Click
  if FListSelected.SelCount <> 1 then Exit;
  //--2. Get selected
  iFlag:= FListSelected.Selected.Index;
  with FListSelected do
  begin
    //.. List내용 바꾸기
    aColumn := TSColumnItem(Items[iFlag].Data);
    aColumnTypes.FieldName:= Trim( TSColumnItem(Items[iFlag].Data).FieldName );
//    TColumnItem(FColumns.Defaults[i]).FieldName;
    aColumnTypes.Title:= Trim( Items[iFlag].SubItems[0] );
    aColumnTypes.Width:= Items[iFlag].SubItems[1];
    aColumnTypes.Scale:= Items[iFlag].SubItems[2];
    //..
    aColumnTypes.Alignment := aColumn.Alignment;
    aColumnTypes.ShowColorChange := aColumn.ShowColorChange;
    aColumnTypes:= SetColumns(FConfigForm, aColumnTypes);
    //..
    Items[iFlag].Caption := Trim( aColumnTypes.FieldName );
    Items[iFlag].SubItems[0]:= aColumnTypes.Title;
    Items[iFlag].SubItems[1]:= aColumnTypes.Width;
    Items[iFlag].SubItems[2]:= aColumnTypes.Scale;
    Items[iFlag].Selected;
    Items[iFlag].Focused;
    //.. 원천데이터 내용 바꾸기
    aColumn.ShowColorChange := aColumnTypes.ShowColorChange;
    aColumn.Alignment := aColumnTypes.Alignment;
    {
    for i:=0 to FColumns.ViewList.Count-1 do
    begin
      if TSColumnItem(FColumns.ViewList[i]) = FListSelected.Selected.Data then
      begin
        TSColumnItem(FColumns.ViewList[i]).Title:= aColumnTypes.Title;
        TSColumnItem(FColumns.ViewList[i]).Width:= StrToInt(aColumnTypes.Width);
        TSColumnItem(FColumns.ViewList[i]).Scale:= StrToInt(aColumnTypes.Scale);
        Break;
      end;
    end;
    }
  end;
end;
*)
procedure TColumnCfgSet.BtnMoveClick(Sender: TObject);
  var
  i : Integer;
  aItem: TListItem;
  aColumn : TSColumnItem;
  iInsert : Integer;
  bFirst : Boolean;
begin
  bFirst := True;
  iInsert := 0;
  case TComponent(Sender).Tag of
    100:  // select an item
    begin
      if FListFields.Selected = nil then Exit;
      aColumn := TSColumnItem(FListFields.Selected.Data);
      if FColumns.FindFixedDeatails(aColumn.FieldName) then Exit;

      for i:=0 to FColumns.Count-1 do
      begin
        if FListFields.Selected <> nil then
        if FColumns[i] = FListFields.Selected.Data then
        begin
          with FListSelected.Items.Add do
          begin
            Data:= FColumns[i];
            Caption:= (FColumns[i] as TSColumnItem).FieldName;
            SubItems.Add((FColumns[i] as TSColumnItem).Title);
            SubItems.Add(IntToStr((FColumns[i] as TSColumnItem).Width) ); // 넓이
            SubItems.Add(IntToStr((FColumns[i] as TSColumnItem).Scale)); // 단위
            SubItems.Add('');
          end;
          FListFields.Selected.Free;
          Exit;
        end;
      end;
    end;
    200:  // select All Item
    begin
      for i:= FListFields.Items.Count- 1 downto 0 do
      begin
        aColumn := TSColumnItem(FListFields.Items[i].Data);
        if FColumns.FindFixedDeatails(aColumn.FieldName) then Continue;

        if bFirst then
        with FListSelected.Items.Add do
        begin
          Data := aColumn;
          Caption := aColumn.Title;
          SubItems.Add(aColumn.FieldName);
          SubItems.Add(IntToStr(aColumn.Width));
          SubItems.Add(IntToStr(aColumn.Scale));
          SubItems.Add('');
          bFirst := False;
          iInsert := FListSelected.Items.Count- 1;
        end else
        with FListSelected.Items.Insert(iInsert) do
        begin
          Data := aColumn;
          Caption := aColumn.Title;
          SubItems.Add(aColumn.FieldName);
          SubItems.Add(IntToStr(aColumn.Width));
          SubItems.Add(IntToStr(aColumn.Scale));
          SubItems.Add('');
        end;
        FListFields.Items.Delete(i);

      end;
      {
      for i:=0 to FColumns.Count-1 do
      begin
        with ListSelected.Items.Add do
        begin
          Data:= FColumns[i];
          Caption:= (FColumns[i] as TColumnItem).Title;
          SubItems.Add((FColumns[i] as TColumnItem).FieldName);
          SubItems.Add(IntToStr((FColumns[i] as TColumnItem).Width) ); // 넓이
          SubItems.Add(IntToStr((FColumns[i] as TColumnItem).Scale)); // 단위
        end;
        ListFields.Items.Clear;
      end;
      }
    end;
    300:  // unselect an item
      begin
        if FListSelected.Selected <> nil then
        begin

          aColumn := TSColumnItem(FListSelected.Selected.Data);
          if FColumns.FindFixedDeatails(aColumn.FieldName) then Exit;

          for i:=0 to FColumns.Count-1 do
          begin
            if FColumns[i] = FListSelected.Selected.Data then
            begin
              with (FColumns[i] as TSColumnItem) do
              begin
                aItem:= FListFields.Items.Add;
                aItem.Caption:= FieldName;
                aItem.Data:= FColumns[i];
                aItem.SubItems.Add(Title);
              end;
              //FColumns.ViewList.Remove(FColumns[i] as TColumnItem);
              FListSelected.Selected.Free;
              Exit;
            end;
          end;
        end;
      end;
    400:
      begin
        for i:= FListSelected.Items.Count- 1 downto 0 do
        begin
          aColumn := TSColumnItem(FListSelected.Items[i].Data);
          if FColumns.FindFixedDeatails(aColumn.FieldName) then Continue;

          if bFirst then
          with FListFields.Items.Add do
          begin
            Data := aColumn;
            Caption := aColumn.Title;
            SubItems.Add(aColumn.FieldName);
            SubItems.Add(aColumn.Title);
            SubItems.Add(IntToStr(aColumn.Width));
            SubItems.Add(IntToStr(aColumn.Scale));
            SubItems.Add('');
            bFirst := False;
            iInsert := FListFields.Items.Count- 1;
          end else
          with FListFields.Items.Insert(iInsert) do
          begin
            Data := aColumn;
            Caption := aColumn.Title;
            SubItems.Add(aColumn.FieldName);
            SubItems.Add(aColumn.Title);
            SubItems.Add(IntToStr(aColumn.Width));
            SubItems.Add(IntToStr(aColumn.Scale));
            SubItems.Add('');
          end;
          FListSelected.Items.Delete(i);


        {
        ListFields.Items.Clear;
        for i:=0 to FColumns.Count-1 do
        begin
          with (FColumns[i] as TColumnItem) do
          begin
            aItem:= ListFields.Items.Add;
            aItem.Caption:= Title;
            aItem.Data:= FColumns[i];
          end;
        end;
        ListSelected.Items.Clear;
        }
        end;
      end;
  end;
  FListFields.Refresh;
  FListSelected.Refresh;
end;

procedure TColumnCfgSet.ItmeMove(Sender: TObject);
var
  iFlag, iMove: Integer;
  iDir: Integer;
  aColumn : TSColumnItem;
begin
  //--1. Check select count
  if FListSelected.SelCount <> 1 then Exit;
  //--2. Get selected
  iFlag:= FListSelected.Selected.Index;

  //Added by Seo  고정 필드를 위한 작업이다.
  aColumn:= TSColumnItem(FListSelected.Selected.Data);
  if FColumns.FindFixedDeatails(aColumn.FieldName) then Exit;

  //--3. Get New Position
  case (Sender as TComponent).Tag of
    700: iDir:= -1;
    800: iDir:= +1;
    else Exit;
  end;
  if ((iDir < 0) and (iFlag > 0)) or
     ((iDir > 0) and (iFlag < FListSelected.Items.Count-1)) then
    iMove := iFlag + iDir
  else
    Exit;

  //고정 필드를 위한 작업
  aColumn := TSColumnItem(FListSelected.Items[iMove].Data);
  if FColumns.FindFixedDeatails(aColumn.FieldName) then Exit;

  ItemChange(FListSelected, iFlag, iMove);

end;

procedure TColumnCfgSet.CheckDefaultClick(Sender: TObject);
begin
  FIsDefault:= FCheckDefault.Checked;
end;

procedure TColumnCfgSet.ButtonOKClick(Sender: TObject);
var
  i : Integer;
begin
  FColumns.ViewList.Clear;
  for i:=0 to FListSelected.Items.Count-1 do
    FColumns.ViewList.Add( FListSelected.Items[i].Data );
end;

procedure TColumnCfgSet.ButtonCancelClick(Sender: TObject);
begin

end;

procedure TColumnCfgSet.ButtonDefaultClick(Sender: TObject);
var
  i : Integer;
  aItem : TListItem;
  aColumn : TSColumnItem;
begin
  FListSelected.Items.Clear;
  FListFields.Items.Clear;

  for i:=0 to FColumns.Count-1 do
  begin
    aColumn := FColumns.Columns[i];
    if FColumns.Defaults.IndexOf(aColumn) >= 0 then // in Defaults
    begin
      aItem := FListSelected.Items.Add;
      aItem.Data := aColumn;
      aItem.Caption := aColumn.FieldName;
      aItem.SubItems.Add(aColumn.Title);
      aItem.SubItems.Add(IntToStr(aColumn.Width));
      aItem.SubItems.Add(IntToStr(aColumn.Scale));
      aItem.SubItems.Add('');
    end else
    begin
      aItem := FListFields.Items.Add;
      aItem.Data := aColumn;
      aItem.Caption := aColumn.FieldName;
      aItem.SubItems.Add(aColumn.Title);
    end;
  end;

end;

procedure TColumnCfgSet.ButtonHelpClick(Sender: TObject);
begin
//  gHelp.Show(ID_ColumnConfig);
end;

procedure TColumnCfgSet.ItemChange(aList: TListView; iIndex1,
  iIndex2: Integer);
var
  aTempItem: TSColumnItem;
  aTemp :String;
  i: Integer;
begin
  //--4. Swap
  with aList do
  begin
    //.. Data Object Change
    aTempItem:= Items[iIndex1].Data;
    Items[iIndex1].Data:= Items[iIndex2].Data;
    Items[iIndex2].Data:= aTempItem;
    //.. Head Change
    aTemp:= Items[iIndex1].Caption;
    Items[iIndex1].Caption:= Items[iIndex2].Caption;
    Items[iIndex2].Caption:= aTemp;
    //.. SubDataChange
    for i:= 0 to Items[iIndex1].SubItems.Count-1 do
    begin
      aTemp:= Items[iIndex1].SubItems[i];
      Items[iIndex1].SubItems[i] := Items[iIndex2].SubItems[i];
      Items[iIndex2].SubItems[i] := aTemp;
    end;
    //--5. set selected & focused
    Items[iIndex2].Selected:= True;
    Items[iIndex2].Focused:= True;
    //--6. redraw
    Refresh;
  end;

end;

procedure TColumnCfgSet.Init(aColumns: TColumns);
var
  i, j : Integer;
  aItem : TListItem;
  bFlag: Boolean;
  aColumn : TSColumnItem;
begin
  FColumns:= aColumns;

  FListFields.Items.Clear;
  FListSelected.Items.Clear;

  for i:=0 to FColumns.ViewList.Count-1 do
  begin
    aColumn := TSColumnItem(FColumns.ViewList[i]);
    if not(FColumns.FindNonVisibles(aColumn.FieldName)) then
    begin
      aItem:= FListSelected.Items.Add;
      aItem.Data:= TSColumnItem(FColumns.ViewList[i]);
      aItem.Caption:= TSColumnItem(FColumns.ViewList[i]).FieldName;
      aItem.SubItems.Add(TSColumnItem(FColumns.ViewList[i]).Title);
      aItem.SubItems.Add(IntToStr(TSColumnItem(FColumns.ViewList[i]).Width) );
      aItem.SubItems.Add(IntToStr(TSColumnItem(FColumns.ViewList[i]).Scale));
      aItem.SubItems.Add('');
    end;
  end;

  for i:=0 to FColumns.Count-1 do
  begin
    bFlag:= True;

    for j:=0 to FColumns.ViewList.Count-1 do
      if FColumns[i] = TSColumnItem(FColumns.ViewList[j]) then
      begin
        bFlag:= False;
        Break;
      end;

    if bFlag then
    begin
      aColumn := TSColumnItem(FColumns.Items[i]);
      if not(FColumns.FindNonVisibles(aColumn.FieldName)) then
      begin
        aItem:= FListFields.Items.Add;
        aItem.Caption:= FColumns[i].FieldName;
        aItem.Data:= FColumns[i];
        aItem.SubItems.Add(FColumns[i].Title);
      end;
    end;
  end;
end;

end.
