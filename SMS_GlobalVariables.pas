unit SMS_GlobalVariables;

interface

uses
  Classes, SMS_Broadcaster;

const
  VAR_BROADCAST = 1000;

type

  TGlobalVariable = class(TCollectionItem)
  public
    Key : String;
    //
    Value : Double;
    Value2 : Double;
    Value3 : Double;
    //
    BroadCastable : Boolean;

    procedure Assign(aSource: TPersistent); override;

    constructor Create(aColl: TCollection); override;
  end;

  TGlobalVariableStore = class
  private
    FVariables : TCollection;
    FVariableList : TList;
    //
    FBroadcaster : TBroadcaster;

    function FindVariable(stKey: String): TGlobalVariable;
    function GetVariableCount: Integer;
    function GetVariableItem(i: Integer): TGlobalVariable;

  public
    constructor Create;
    destructor Destroy; override;

    function RegVariable(stKey: String; dValue: Double): TGlobalVariable;
    function RegVariable2(stKey: String; dValue, dValue2: Double): TGlobalVariable;

    procedure UnRegVariable(stKey: String);

    function GetVariable(stKey: String): Double;
    function GetVariable2(stKey: String; var dValue1, dValue2: Double): TGlobalVariable;

    procedure Assign(aOtherStore : TGlobalVariableStore);

    property VariableCount: Integer read GetVariableCount;
    property Variables[i:Integer]: TGlobalVariable read GetVariableItem;
    //
    property Broadcaster : TBroadcaster read FBroadcaster;
  end;


var
  gGlobalVariableStore : TGlobalVariableStore;

implementation

uses SysUtils, Math;

{ TGlobalVariableStore }

procedure TGlobalVariableStore.Assign(aOtherStore: TGlobalVariableStore);
var
  i, j : Integer;
  aVariable : TGlobalVariable;
begin

  FVariables.Assign(aOtherStore.FVariables);
  FVariableList.Clear;
  //FVariableList.Assign(aOtherStore.FVariableList);
  for i := 0 to aOtherStore.VariableCount-1 do
  begin

    for j := 0 to FVariables.Count-1 do
    begin
      aVariable := FVariables.Items[j] as TGlobalVariable;
      if CompareStr(aVariable.Key, UpperCase(Trim(aOtherStore.Variables[i].Key))) = 0 then
      begin
        FVariableList.Add(aVariable);
        Break;
      end;
    end;

  end;
end;

constructor TGlobalVariableStore.Create;
begin
  FVariables := TCollection.Create(TGlobalVariable);
  FVariableList := TList.Create;
  //
  FBroadcaster := TBroadcaster.Create;

end;

destructor TGlobalVariableStore.Destroy;
begin
  FBroadcaster.Free;
  //
  FVariableList.Free;
  FVariables.Free;

  inherited;
end;

function TGlobalVariableStore.FindVariable(stKey: String): TGlobalVariable;
var
  i : Integer;
  aVariable : TGlobalVariable;
begin
  Result := nil;
  //
  for i := 0 to FVariableList.Count-1 do
  begin
    aVariable := TGlobalVariable(FVariableList.Items[i]);
    //
    if CompareStr(aVariable.Key, UpperCase(Trim(stKey))) = 0 then
    begin
      FVariableList.Move(i, 0);
      Result := aVariable;
      Break;
    end;
  end;

end;

function TGlobalVariableStore.GetVariable(stKey: String): Double;
var
  aVariable : TGlobalVariable;
begin
  aVariable := FindVariable(stKey);
  //
  if aVariable = nil then
    Result := NaN
  else
    Result := aVariable.Value;
end;

function TGlobalVariableStore.GetVariable2(stKey: String; var dValue1,
  dValue2: Double): TGlobalVariable;
//var
//  aVariable : TGlobalVariable;
begin
  Result := FindVariable(stKey);
  //
  if Result = nil then
  begin
    dValue1 := NaN;
    dValue2 := NaN;
  end else
  begin
    dValue1 := Result.Value;
    dValue2 := Result.Value2;
  end;

end;

function TGlobalVariableStore.GetVariableCount: Integer;
begin
  Result := FVariableList.Count;
end;

function TGlobalVariableStore.GetVariableItem(i: Integer): TGlobalVariable;
begin
  Result := nil;
  //
  if (i >= 0) and (i<FVariableList.Count) then
  begin
    Result := TGlobalVariable(FVariableList.Items[i]);
  end;

end;

function TGlobalVariableStore.RegVariable(stKey: String; dValue: Double): TGlobalVariable;
var
  iP : Integer;
  //aVariable : TGlobalVariable;
begin
  Result := FindVariable(stKey);
  //
  if Result = nil then
  begin
    Result := FVariables.Add as TGlobalVariable;
    Result.Key := Trim(UpperCase(stKey));
    FVariableList.Add(Result);
  end;
  //
  Result.Value := dValue;
  //
  iP := FVariableList.IndexOf(Result);
  FVariableList.Move(iP, 0);
  //
  if Result.BroadCastable then
  begin
    FBroadcaster.Broadcast(Self, Result, VAR_BROADCAST, btUpdate);
  end;

end;

function TGlobalVariableStore.RegVariable2(stKey: String; dValue, dValue2: Double): TGlobalVariable;
var
  iP : Integer;
  //aVariable : TGlobalVariable;
begin
  Result := FindVariable(stKey);
  //
  if Result = nil then
  begin
    Result := FVariables.Add as TGlobalVariable;
    Result.Key := Trim(UpperCase(stKey));
    FVariableList.Add(Result);
  end;
  //
  Result.Value := dValue;
  Result.Value2 := dValue2;
  //
  iP := FVariableList.IndexOf(Result);
  FVariableList.Move(iP, 0);
  //
  if Result.BroadCastable then
  begin
    FBroadcaster.Broadcast(Self, Result, VAR_BROADCAST, btUpdate);
  end;

end;

procedure TGlobalVariableStore.UnRegVariable(stKey: String);
var
  aVariable : TGlobalVariable;
begin
  aVariable := FindVariable(stKey);

  if aVariable <> nil then
  begin
    FVariableList.Remove(aVariable);
    aVariable.Free;
  end;

end;

{ TGlobalVariable }

procedure TGlobalVariable.Assign(aSource: TPersistent);
var
  aSourceVariable : TGlobalVariable;
begin
  //
  aSourceVariable := aSource as TGlobalVariable;

  Key := aSourceVariable.Key;
  Value := aSourceVariable.Value;
  Value2 := aSourceVariable.Value2;
  Value3 := aSourceVariable.Value3;
end;

constructor TGlobalVariable.Create(aColl: TCollection);
begin
  inherited Create(aColl);

  BroadCastable := False;
end;

initialization
//  gGlobalVariableStore := TGlobalVariableStore.Create;

finalization
//  gGlobalVariableStore.Free;

end.
