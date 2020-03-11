unit SMS_ListSelector;

interface

uses
  SysUtils, Classes;

type

  TListSelectorCloneItem = class(TCollectionItem)
  public
    OrgItem : TObject;

    function GetTitle : String; virtual;
  end;

  TListSelectorCloneItemClass = class of TListSelectorCloneItem;

  TListSelectManager = class
  private
    FEnableList : TList;
    FDisableList: TList;

    FClones : TCollection;
    FCloneClass : TListSelectorCloneItemClass;
  public
    constructor Create(aCloneClass: TListSelectorCloneItemClass);
    destructor Destroy; override;

    function AddEnableClone: TListSelectorCloneItem;
    function AddClone : TListSelectorCloneItem;
    function FindClone(aOrgItem : TObject): TListSelectorCloneItem;

    procedure RemoveClone(aClone: TListSelectorCloneItem);
    procedure RemoveAllClone;
    procedure Clear;
    //
    procedure Select(aClone : TListSelectorCloneItem);
    procedure SelectAll;

    procedure MoveTop(aClone: TListSelectorCloneItem);
    procedure MoveBottom(aClone: TListSelectorCloneItem);
    procedure MoveUp(aClone: TListSelectorCloneItem);
    procedure MoveDown(aClone: TListSelectorCloneItem);
    //
    property EnableList : TList read FEnableList;
    property DisableList : TList read FDisableList;
  end;


implementation

{ TListSelectManager }

function TListSelectManager.AddClone: TListSelectorCloneItem;
begin
  Result := FClones.Add as FCloneClass;
end;

function TListSelectManager.AddEnableClone: TListSelectorCloneItem;
begin
  Result := FClones.Add as FCloneClass;
  FEnableList.Add(Result);
end;

(*
procedure TListSelectManager.Assign(aList: TList; aCloneClass: TListSelectorCloneItemClass);
var
  i : Integer;
  aClone : TListSelectorCloneItem;
begin
  Init(aCloneClass);

  //
  if aList <> nil then
  begin
    for i := 0 to aList.Count-1 do
    begin
      aClone := FClones.Add as FCloneClass;

      aClone.OrgItem := TObject(aList.Items[i]);


      FEnableList.Add(aClone);
    end;
  end;

end;
*)
procedure TListSelectManager.Clear;
begin

  FEnableList.Clear;
  FDisableList.Clear;
  FClones.Clear;
  
end;

constructor TListSelectManager.Create(aCloneClass: TListSelectorCloneItemClass);
begin
  FCloneClass := aCloneClass;

  FClones := TCollection.Create(FCloneClass);
  FEnableList := TList.Create;
  FDisableList := TList.Create;

end;

destructor TListSelectManager.Destroy;
begin
  FEnableList.Free;
  FDisableList.Free;
  FClones.Free;

  inherited;
end;


function TListSelectManager.FindClone(
  aOrgItem: TObject): TListSelectorCloneItem;
var
  i : Integer;
  aClone : TListSelectorCloneItem;
begin
  Result := nil;
  //
  for i := 0 to FClones.Count-1 do
  begin
    aClone := FClones.Items[i] as TListSelectorCloneItem;
    if aClone.OrgItem = aOrgItem then
    begin
      Result := aClone;
      Break;
    end;
  end;
end;

procedure TListSelectManager.MoveBottom(aClone: TListSelectorCloneItem);
var
  iCurIndex : Integer;
begin
  iCurIndex := FEnableList.IndexOf(aClone);
  if iCurIndex < 0 then Exit;
  //
  FEnableList.Move(iCurIndex, FEnableList.Count-1);
end;

procedure TListSelectManager.MoveDown(aClone: TListSelectorCloneItem);
var
  iCurIndex : Integer;
begin
  iCurIndex := FEnableList.IndexOf(aClone);
  if (iCurIndex < 0) or (iCurIndex = FEnableList.Count-1) then Exit;
  //
  FEnableList.Move(iCurIndex, iCurIndex+1);

end;

procedure TListSelectManager.MoveTop(aClone: TListSelectorCloneItem);
var
  iCurIndex : Integer;
begin
  iCurIndex := FEnableList.IndexOf(aClone);
  if iCurIndex < 0 then Exit;
  //
  FEnableList.Move(0, iCurIndex);

end;

procedure TListSelectManager.MoveUp(aClone: TListSelectorCloneItem);
var
  iCurIndex : Integer;
begin
  iCurIndex := FEnableList.IndexOf(aClone);
  if iCurIndex <= 0 then Exit;
  //
  FEnableList.Move(iCurIndex, iCurIndex-1);
end;

procedure TListSelectManager.RemoveAllClone;
var
  i : Integer;
begin
  for i := FEnableList.Count-1 downto 0 do
    RemoveClone(FEnableList.Items[i]);

end;

procedure TListSelectManager.RemoveClone(aClone: TListSelectorCloneItem);
begin
  FEnableList.Remove(aClone);

  if aClone.OrgItem = nil then
    aClone.Free
  else
    FDisableList.Add(aClone);
end;

procedure TListSelectManager.Select(aClone: TListSelectorCloneItem);
begin
  FEnableList.Add(aClone);
end;

procedure TListSelectManager.SelectAll;
var
  i : Integer;
  aClone : TListSelectorCloneItem;
begin
  //
  for i := 0 to FClones.Count-1 do
  begin
    aClone := FClones.Items[i] as TListSelectorCloneItem;
    //
    if FEnableList.IndexOf(aClone) < 0 then
      FEnableList.Add(aClone);
  end;

end;

{ TListSelectorCloneItem }

function TListSelectorCloneItem.GetTitle: String;
begin
  Result := '';
end;

end.
