unit DSMS_ListSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, SMS_ListSelector, Buttons, StdCtrls, ExtCtrls,
  SMS_CtrlUtils;

type
  TListSelectorDialog = class(TForm)
    ListClones: TListView;
    ListSelecteds: TListView;
    BtnSelect: TSpeedButton;
    BtnSelectAll: TSpeedButton;
    BtnUnSelect: TSpeedButton;
    BtnUnSelectAll: TSpeedButton;
    ButtonTop: TSpeedButton;
    BtnUp: TSpeedButton;
    BtnDown: TSpeedButton;
    ButtonBottom: TSpeedButton;
    Bevel1: TBevel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    CheckApplyAll: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSelectClick(Sender: TObject);
    procedure BtnSelectAllClick(Sender: TObject);
    procedure BtnUnSelectClick(Sender: TObject);
    procedure BtnUnSelectAllClick(Sender: TObject);
    procedure ButtonTopClick(Sender: TObject);
    procedure BtnUpClick(Sender: TObject);
    procedure BtnDownClick(Sender: TObject);
    procedure ButtonBottomClick(Sender: TObject);
  private
    FListSelector: TListSelectManager;
    FDefaultCloneClass: TListSelectorCloneItemClass;
    procedure SetDefaultCloneClass(
      const Value: TListSelectorCloneItemClass);
    { Private declarations }

    procedure RefreshListSelecteds;

    function Find(aClone: TListSelectorCloneItem): TListItem;

  public
    { Public declarations }
    function Execute : Boolean;

    function AddClone(aOrgItem : TObject) : TListSelectorCloneItem;

    property ListSelector : TListSelectManager read FListSelector;
    property DefaultCloneClass : TListSelectorCloneItemClass read FDefaultCloneClass
      write SetDefaultCloneClass;
  end;

var
  ListSelectorDialog: TListSelectorDialog;

implementation

{$R *.dfm}

procedure TListSelectorDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TListSelectorDialog.FormDestroy(Sender: TObject);
begin
  FListSelector.Free;

end;

procedure TListSelectorDialog.SetDefaultCloneClass(
  const Value: TListSelectorCloneItemClass);
begin
  FDefaultCloneClass := Value;
  //
  FListSelector := TListSelectManager.Create(FDefaultCloneClass);
end;

procedure TListSelectorDialog.FormCreate(Sender: TObject);
begin
  //
end;

function TListSelectorDialog.Execute: Boolean;
begin
  //AutoListColumnWidth(ListClones);
  RefreshListSelecteds;
  //AutoListColumnWidth(ListSelecteds);
  Result := ShowModal = mrOk;
end;

function TListSelectorDialog.AddClone(
  aOrgItem: TObject): TListSelectorCloneItem;
var
  aListItem : TListItem;
begin
  Result := FListSelector.AddClone;
  Result.OrgItem := aOrgItem;
  //
  aListItem := ListClones.Items.Add;
  aListItem.Caption := Result.GetTitle;
  aListItem.Data := Result;
end;

procedure TListSelectorDialog.BtnSelectClick(Sender: TObject);
begin
  if ListClones.Selected = nil then Exit;
  FListSelector.Select(TListSelectorCloneItem(ListClones.Selected.Data));
  //
  RefreshListSelecteds;
end;

procedure TListSelectorDialog.RefreshListSelecteds;
var
  i : Integer;
  aSelected : TListSelectorCloneItem;
  aListItem : TListItem;
begin
  ListSelecteds.Items.Clear;
  //
  for i := 0 to FListSelector.EnableList.Count-1 do
  begin
    aSelected := TListSelectorCloneItem(FListSelector.EnableList.Items[i]);

    aListItem := ListSelecteds.Items.Add;
    aListItem.Caption := aSelected.GetTitle;
    aListItem.Data := aSelected;
  end;
end;

procedure TListSelectorDialog.BtnSelectAllClick(Sender: TObject);
begin
//
  FListSelector.SelectAll;
  RefreshListSelecteds;
end;

procedure TListSelectorDialog.BtnUnSelectClick(Sender: TObject);
begin
//
  if ListSelecteds.Selected = nil then Exit;
  FListSelector.RemoveClone(TListSelectorCloneItem(ListSelecteds.Selected.Data));
  //
  RefreshListSelecteds;
end;

procedure TListSelectorDialog.BtnUnSelectAllClick(Sender: TObject);
begin
//
  FListSelector.RemoveAllClone;
  //
  RefreshListSelecteds;
end;

procedure TListSelectorDialog.ButtonTopClick(Sender: TObject);
begin
  if ListSelecteds.Selected = nil then Exit;
  //
  FListSelector.MoveTop(TListSelectorCloneItem(ListSelecteds.Selected.Data));

  RefreshListSelecteds;

  ListSelecteds.Selected := ListSelecteds.Items[0];
  //. movetop
end;

procedure TListSelectorDialog.BtnUpClick(Sender: TObject);
var
  aSelected : TListSelectorCloneItem;
begin
  //.  moveup
  if ListSelecteds.Selected = nil then Exit;
  //
  aSelected := TListSelectorCloneItem(ListSelecteds.Selected.Data);
  FListSelector.MoveUp(aSelected);

  RefreshListSelecteds;
  //
  ListSelecteds.Selected := Find(aSelected);

end;

procedure TListSelectorDialog.BtnDownClick(Sender: TObject);
var
  aSelected : TListSelectorCloneItem;
begin
  //. move down
  //.  moveup
  if ListSelecteds.Selected = nil then Exit;
  //
  aSelected := TListSelectorCloneItem(ListSelecteds.Selected.Data);
  FListSelector.MoveDown(aSelected);

  RefreshListSelecteds;

  ListSelecteds.Selected := Find(aSelected);

end;

procedure TListSelectorDialog.ButtonBottomClick(Sender: TObject);
begin
  //.  move bottom.
    if ListSelecteds.Selected = nil then Exit;
  //
  FListSelector.MoveBottom(TListSelectorCloneItem(ListSelecteds.Selected.Data));

  RefreshListSelecteds;

  ListSelecteds.Selected := ListSelecteds.Items[ListSelecteds.Items.Count-1];
end;

function TListSelectorDialog.Find(
  aClone: TListSelectorCloneItem): TListItem;
var
  i : Integer;
begin
  Result := nil;
  //
  for i := 0 to ListSelecteds.Items.Count-1 do
  begin
    if (aClone = TObject(ListSelecteds.Items[i].Data)) then
    begin
      Result := ListSelecteds.Items[i];
      Break;
    end;
  end;
end;

end.
