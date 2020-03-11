unit SMS_ColumnsDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CommCtrl,

  SMS_ColumnConfiger, SMS_Columns, ImgList, StdCtrls, Buttons, ComCtrls, ExtCtrls;

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
  private
    { Private declarations }
    FColumnConfig : TColumnCfgSet;
  public
    { Public declarations }
    function Open(aColumns : TColumns): Boolean;
  end;

var
  ColumnsConfig: TColumnsConfig;

implementation

//uses
//  AppConsts;

{$R *.DFM}

procedure TColumnsConfig.FormCreate(Sender: TObject);
begin

  FColumnConfig := TColumnCfgSet.Create(Self);
  FColumnConfig.SelectedColor := clBlue;//SELECTED_COLOR2;
  FColumnConfig.SelectedFontColor := clBlack;
  with FColumnConfig do
  begin
    SetListViewControls(ListFields, ListSelected);
    SetSelectBtnControls(BtnSelect, BtnSelectAll, BtnUnSelect, BtnUnSelectAll, BtnUp, BtnDown);
  end;

end;

procedure TColumnsConfig.FormDestroy(Sender: TObject);
begin
  FColumnConfig.Free;
end;

procedure TColumnsConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TColumnsConfig.ButtonOKClick(Sender: TObject);
begin
  FColumnConfig.ButtonOKClick(ButtonOK);
  ModalResult := mrOk;
end;

function TColumnsConfig.Open(aColumns: TColumns): Boolean;
begin
  Result := False;
  if aColumns = nil then Exit;
  FColumnConfig.Init(aColumns);
  ListSelected.OnDrawItem := ListSelectedDrawItem;
  Result := ShowModal = mrOk;
end;

procedure TColumnsConfig.ListSelectedDrawItem(Sender: TCustomListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
  aColumn : TColumnItem;
  stText : String;
//  aRefreshItem : TRefreshItem;
begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListSelected.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := clBlue;//SELECTED_COLOR2;
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
              Rect.Top, ListView_GetColumnWidth(ListSelected.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption);

    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListSelected.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListSelected.Handle,i);

      stText := Item.SubItems[i];
      if i = 3 then
      begin
        aColumn := TColumnItem(Item.Data);
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

      case ListSelected.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListSelected.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListSelected.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListSelected.Handle,i+1), Rect.Bottom),
          iX, iY, stText);
    end;
  end;

  //
end;

procedure TColumnsConfig.ButtonBackColorClick(Sender: TObject);
var
  aColumn : TColumnItem;
begin
  //
  if (ListSelected.Selected = nil) then Exit;
  //
  aColumn := TColumnItem(ListSelected.Selected.Data);
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
  aColumn : TColumnItem;
begin
  ButtonBackColor.Enabled := not CheckUseParentColor.Checked;
  ButtonTextColor.Enabled := not CheckUseParentColor.Checked;
  //
  if (ListSelected.Selected = nil) then Exit;
  //
  aColumn := TColumnItem(ListSelected.Selected.Data);
  //
  aColumn.UseParentColor := CheckUseParentColor.Checked;
end;

procedure TColumnsConfig.ButtonTextColorClick(Sender: TObject);
var
  aColumn : TColumnItem;
begin
  //
  if (ListSelected.Selected = nil) then Exit;
  //
  aColumn := TColumnItem(ListSelected.Selected.Data);
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
  aColumn : TColumnItem;
begin
  if Item = nil then Exit;
  //
  aColumn := TColumnItem(Item.Data);
  //
  CheckUseParentColor.Checked := aColumn.UseParentColor;


end;

end.
