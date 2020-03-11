unit SMS_DColumns;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CommCtrl,

  SMS_FormatColumns, SMS_Columns, ImgList, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TColumnsConfig = class(TForm)
    ListFields: TListView;
    Label14: TLabel;
    Label13: TLabel;
    ListSelected: TListView;
    BtnSelect: TSpeedButton;
    BtnSelectAll: TSpeedButton;
    BtnUnSelect: TSpeedButton;
    BtnUnSelectAll: TSpeedButton;
    BtnUp: TSpeedButton;
    BtnDown: TSpeedButton;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ButtonHelp: TButton;
    ImageList1: TImageList;
    ButtonBackColor: TSpeedButton;
    ButtonTextColor: TSpeedButton;
    Bevel1: TBevel;
    CheckUseParentColor: TCheckBox;
    ColorDialog1: TColorDialog;
    ButtonTop: TSpeedButton;
    ButtonBottom: TSpeedButton;
    MemoDesc: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOKClick(Sender: TObject);
    procedure ListSelectedDrawItem(Sender: TCustomListView;
      Item: TListItem; Rect: TRect; State: TOwnerDrawState);
    procedure ButtonBackColorClick(Sender: TObject);
    procedure CheckUseParentColorClick(Sender: TObject);
    procedure ButtonTextColorClick(Sender: TObject);
    procedure ListSelectedSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BtnSelectClick(Sender: TObject);
    procedure BtnUnSelectClick(Sender: TObject);
    procedure BtnSelectAllClick(Sender: TObject);
    procedure BtnUnSelectAllClick(Sender: TObject);
    procedure BtnUpClick(Sender: TObject);
    procedure BtnDownClick(Sender: TObject);
    procedure ListSelectedDblClick(Sender: TObject);
    procedure ListFieldsDblClick(Sender: TObject);
    procedure ListSelectedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonTopClick(Sender: TObject);
    procedure ButtonBottomClick(Sender: TObject);
  private
    { Private declarations }
    //FColumnConfig : TColumnCfgSet;

    FColumns : TColumns;

    function SelectedColumn(aListView: TListView): TSColumnItem;

    procedure RefreshColumns;
    procedure UpdateSelectedListItem(aColumn: TSColumnItem; aListItem: TListItem);
    procedure UpdateListItem(aColumn: TSColumnItem; aListItem: TListItem);


  public
    { Public declarations }
    function Open(aColumns : TColumns): Boolean;

    property Columns : TColumns read FColumns;
  end;

var
  ColumnsConfig: TColumnsConfig;

implementation

uses
  SMS_DColEdit;

const
  SELECTED_COLOR = $00F2BEB9;
  ODD_COLOR = $FFFFFF;
  EVEN_COLOR = $EEEEEE;


{$R *.DFM}

procedure TColumnsConfig.FormCreate(Sender: TObject);
begin

  FColumns := TColumns.Create;

  {
  FColumnConfig := TColumnCfgSet.Create(Self);
  FColumnConfig.SelectedColor := SELECTED_COLOR;
  FColumnConfig.SelectedFontColor := clBlack;
  with FColumnConfig do
  begin
    SetListViewControls(ListFields, ListSelected);
    SetSelectBtnControls(BtnSelect, BtnSelectAll, BtnUnSelect, BtnUnSelectAll, BtnUp, BtnDown);
  end;
  }
end;

procedure TColumnsConfig.FormDestroy(Sender: TObject);
begin
  //FColumnConfig.Free;

  FColumns.Free;
end;

procedure TColumnsConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TColumnsConfig.ButtonOKClick(Sender: TObject);
begin
  //FColumnConfig.ButtonOKClick(ButtonOK);
  ModalResult := mrOk;
end;

function TColumnsConfig.Open(aColumns: TColumns): Boolean;
begin
  FColumns.CopyFrom(aColumns);
  RefreshColumns;
  Result := ShowModal = mrOk;


  (*
  Result := False;
  if aColumns = nil then Exit;
  FColumnConfig.Init(aColumns);
  ListSelected.OnDrawItem := ListSelectedDrawItem;
  Result := ShowModal = mrOk;
  *)
end;

procedure TColumnsConfig.ListSelectedDrawItem(Sender: TCustomListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
  aColumn : TSColumnItem;
  stText : String;
  aListView : TListView;
//  aRefreshItem : TRefreshItem;
begin
  Rect.Bottom := Rect.Bottom-1;
  //
  aListView := Sender as TListView;
  //
  with aListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clBlack;
    end else
    begin
      Font.Color := clBlack;
      Brush.Color := clWhite;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    //-- caption
    if Item.Caption <> '' then
      TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(aListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption);

    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListSelected.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(aListView.Handle,i);

      stText := Item.SubItems[i];
      if i = 3 then
      begin
        aColumn := TSColumnItem(Item.Data);
        //
        if aColumn.UseParentColor then
          stText := 'Parent'
        else
        begin
          stText := 'Preview';
          Brush.Color := aColumn.BackColor;
          Font.Color := aColumn.FontColor;
        end;
      end;
      //
      if stText = '' then Continue;
      aSize := TextExtent(stText);

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
          iX, iY, stText);
    end;
  end;

  //
end;

procedure TColumnsConfig.ButtonBackColorClick(Sender: TObject);
var
  aColumn : TSColumnItem;
begin
  //
  if (ListSelected.Selected = nil) then Exit;
  //
  aColumn := TSColumnItem(ListSelected.Selected.Data);
  //
  if not aColumn.UseParentColor then
  begin
    ColorDialog1.Color := aColumn.BackColor;
    if ColorDialog1.Execute then
      aColumn.BackColor := ColorDialog1.Color;
  end;


end;

procedure TColumnsConfig.CheckUseParentColorClick(Sender: TObject);
var
  aColumn : TSColumnItem;
begin
  ButtonBackColor.Enabled := not CheckUseParentColor.Checked;
  ButtonTextColor.Enabled := not CheckUseParentColor.Checked;
  //
  if (ListSelected.Selected = nil) then Exit;
  //
  aColumn := TSColumnItem(ListSelected.Selected.Data);
  //
  aColumn.UseParentColor := CheckUseParentColor.Checked;
end;

procedure TColumnsConfig.ButtonTextColorClick(Sender: TObject);
var
  aColumn : TSColumnItem;
begin
  //
  if (ListSelected.Selected = nil) then Exit;
  //
  aColumn := TSColumnItem(ListSelected.Selected.Data);
  //
  if not aColumn.UseParentColor then
  begin
    ColorDialog1.Color := aColumn.FontColor;
    if ColorDialog1.Execute then
      aColumn.FontColor := ColorDialog1.Color;
  end;

end;

procedure TColumnsConfig.ListSelectedSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  aColumn : TSColumnItem;
begin
  if Item = nil then Exit;
  //
  aColumn := TSColumnItem(Item.Data);
  //
  CheckUseParentColor.Checked := aColumn.UseParentColor;
  //ListSelected.Hint := aColumn.Desc;
  MemoDesc.Lines.Clear;
  MemoDesc.Lines.CommaText := ',';
  MemoDesc.Lines.Text := aColumn.Title + ' : ' + aColumn.Desc;

end;

procedure TColumnsConfig.RefreshColumns;
var
  i : Integer;
  aColumn : TSColumnItem;
  aListItem : TListItem;
begin
  ListFields.Items.Clear;
  ListSelected.Items.Clear;
  //
  for i := 0 to FColumns.Count-1 do
  begin
    aColumn := FColumns.Items[i] as TSColumnItem;
    //
    if FColumns.ViewList.IndexOf(aColumn) < 0 then
    begin
      aListItem := ListFields.Items.Add;
      UpdateListItem(aColumn, aListItem);
    end;
    { else
    begin
      aListItem := ListSelected.Items.Add;
      UpdateSelectedListItem(aColumn, aListItem);
    end;
    }
    //
  end;
  //
  for i := 0 to FColumns.ViewList.Count-1 do
  begin
    aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
    aListItem := ListSelected.Items.Add;
    UpdateSelectedListItem(aColumn, aListItem);
  end;
end;

procedure TColumnsConfig.UpdateListItem(aColumn: TSColumnItem;
  aListItem: TListItem);
begin
  aListItem.Caption := aColumn.Title;
  aListItem.SubItems.Clear;
  aListItem.Data := aColumn;

  aListItem.SubItems.Add(aColumn._Title);
  {
  aListItem.SubItems.Add(IntToStr(aColumn.Width));
  aListItem.SubItems.Add(IntToStr(aColumn.Scale));
  }

end;

procedure TColumnsConfig.UpdateSelectedListItem(aColumn: TSColumnItem;
  aListItem: TListItem);
begin
  //
  UpdateListItem(aColumn, aListItem);
  aListItem.SubItems.Add(IntToStr(aColumn.Width));
  aListItem.SubItems.Add(IntToStr(aColumn.Scale));
end;

procedure TColumnsConfig.BtnSelectClick(Sender: TObject);
var
  aColumn : TSColumnItem;
begin
  //
  aColumn := SelectedColumn(ListFields);
  //
  if aColumn <> nil then
  begin
    FColumns.SelecteColumn(aColumn);
    RefreshColumns;
  end;


end;

function TColumnsConfig.SelectedColumn(aListView: TListView): TSColumnItem;
begin
  Result := nil;
  //
  if (aListView.Selected <> nil) and (aListView.Selected.Data <> nil) then
    Result := TSColumnItem(aListView.Selected.Data);

end;

procedure TColumnsConfig.BtnUnSelectClick(Sender: TObject);
var
  i : Integer;
  bMoved : Boolean;
  aColumn : TSColumnItem;
begin
  //
  bMoved := False;
  for i := 0 to ListSelected.Items.Count-1 do
  begin
    //
    if ListSelected.Items[i].Selected then
    begin
      aColumn := ListSelected.Items[i].Data;
      FColumns.UnSelectColumn(aColumn);
      bMoved := True;
    end;
    //
  end;
  //
  if bMoved then
    RefreshColumns;

  (*
  aColumn := SelectedColumn(ListSelected);

  if aColumn <> nil then
  begin
    FColumns.UnSelectColumn(aColumn);
    RefreshColumns;
  end;
  *)
end;

procedure TColumnsConfig.BtnSelectAllClick(Sender: TObject);
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  //
  for i := 0 to ListFields.Items.Count-1 do
  begin
    aColumn := TSColumnItem(ListFields.Items[i].Data);
    FColumns.SelecteColumn(aColumn);
  end;

  RefreshColumns;


end;

procedure TColumnsConfig.BtnUnSelectAllClick(Sender: TObject);
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  //
  for i := 0 to ListSelected.Items.Count-1 do
  begin
    aColumn := TSColumnItem(ListSelected.Items[i].Data);

    FColumns.UnSelectColumn(aColumn);
  end;

  RefreshColumns;


end;

procedure TColumnsConfig.BtnUpClick(Sender: TObject);
var
  aColumn : TSColumnItem;
  iP : Integer;
  aListItem : TListItem;
begin
  aColumn := SelectedColumn(ListSelected);
  //
  if aColumn <> nil then
  begin
    iP := FColumns.ViewList.IndexOf(aColumn);
    //
    if iP > 0 then
    begin
      FColumns.ViewList.Exchange(iP, iP-1);
      aListItem := ListSelected.Items.Insert(iP-1);
      aListItem.Assign(ListSelected.Selected);
      ListSelected.DeleteSelected;
      aListItem.Selected := True;
      //RefreshColumns;
    end;
  end;

end;

procedure TColumnsConfig.BtnDownClick(Sender: TObject);
var
  aColumn{, aDownColumn} : TSColumnItem;
  {aSelectedItem, aDownListItem,} aListItem : TListItem;
  iP : Integer;
begin
  aColumn := SelectedColumn(ListSelected);
  //
  if aColumn <> nil then
  begin
    iP := FColumns.ViewList.IndexOf(aColumn);
    //
    if iP < FColumns.ViewList.Count-1 then
    begin
      //gLog.Add exchange. ip, ip+1
      FColumns.ViewList.Exchange(iP, iP+1);
      aListItem := ListSelected.Items.Insert(iP+{1}2);

      aListItem.Assign(ListSelected.Selected);
      ListSelected.DeleteSelected;
      aListItem.Selected := True;
      (*
      aDownColumn := TSColumnItem(FColumns.ViewList.Items[iP+1]);
      aDownListItem := ListSelected.Items[ListSelected.ItemIndex+1];
      aSelectedItem := ListSelected.Items[ListSelected.ItemIndex];
      //
      UpdateSelectedListItem(aDownColumn, aSelectedItem);
      UpdateSelectedListItem(aColumn, aDownListItem);
      FColumns.ViewList.Exchange(iP, iP+1);
      ListSelected.Selected := aDownListItem;
      *)
    end;
  end;


end;

procedure TColumnsConfig.ListSelectedDblClick(Sender: TObject);
begin
  BtnUnSelectClick(nil);
end;

procedure TColumnsConfig.ListFieldsDblClick(Sender: TObject);
begin
  BtnSelectClick(BtnSelect);
end;

procedure TColumnsConfig.ListSelectedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aDialog : TColEditDialog;
  aColumn : TSColumnItem;
  aListItem : TListItem;
begin
  //
  aColumn  := SelectedColumn(ListSelected);
  aListItem := ListSelected.Selected;
  //
  if aColumn = nil then Exit;
  //
  if Button = mbRight then
  begin
    aDialog := TColEditDialog.Create(Self);
    //
    if aDialog.Open(aColumn) then
    begin
      aColumn.Assign(aDialog.EditedColumn);
      UpdateSelectedListItem(aColumn, aListItem);

      //RefreshColumns;
    end;
    //aDialog.Open()


  end;

end;


procedure TColumnsConfig.ButtonTopClick(Sender: TObject);
var
  aColumn : TSColumnItem;
  iP : Integer;
begin
  aColumn := SelectedColumn(ListSelected);
  //
  if aColumn <> nil then
  begin
    iP := FColumns.ViewList.IndexOf(aColumn);
    //
    if iP > 0 then
    begin
      FColumns.ViewList.Delete(iP);
      FColumns.ViewList.Insert(0, aColumn);
      //FColumns.ViewList.Exchange(iP, 0);
      RefreshColumns;
    end;
  end;

end;

procedure TColumnsConfig.ButtonBottomClick(Sender: TObject);

var
  aColumn : TSColumnItem;
  iP : Integer;
begin
  aColumn := SelectedColumn(ListSelected);
  //
  if aColumn <> nil then
  begin
    iP := FColumns.ViewList.IndexOf(aColumn);
    //
    if iP < FColumns.ViewList.Count-1 then
    begin
      //FColumns.ViewList.Exchange(iP, FColumns.ViewList.Count-1);
      FColumns.ViewList.Delete(iP);
      FColumns.ViewList.Add(aColumn);
      RefreshColumns;
    end;
  end;

end;

end.
