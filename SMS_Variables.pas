unit SMS_Variables;

interface

uses
  SysUtils, Classes, Math;

type

  TSVariable = class(TCollectionItem)
  public
    Key : String;
    //
    Value : Double;
    Value2 : Double;
    Value3 : Double;
    //
    OValue : Variant;

    procedure Assign(aSource: TPersistent); override;

    constructor Create(aColl: TCollection); override;
  end;

  TSVariables = class
  private
    FVariables : TCollection;
    FVariableList : TList;
    //
    function FindVariable(stKey: String): TSVariable;
    function GetVariableCount: Integer;
    function GetVariableItem(i: Integer): TSVariable;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    function RegVariable(stKey: String; dValue: Double): TSVariable;
    function RegVariable2(stKey: String; dValue, dValue2: Double): TSVariable;

    procedure UnRegVariable(stKey: String);

    function GetVariable(stKey: String): Double;
    function GetVariable2(stKey: String; var dValue1, dValue2: Double): TSVariable;

    procedure Assign(aOtherStore : TSVariables);

    property VariableCount: Integer read GetVariableCount;
    property Variables[i:Integer]: TSVariable read GetVariableItem;
    //
  end;



implementation

{ TSVariable }

procedure TSVariable.Assign(aSource: TPersistent);
var
  aSourceVariable : TSVariable;
begin
  //
  aSourceVariable := aSource as TSVariable;

  Key := aSourceVariable.Key;
  Value := aSourceVariable.Value;
  Value2 := aSourceVariable.Value2;
  Value3 := aSourceVariable.Value3;
  OValue := aSourceVariable.OValue;

end;

constructor TSVariable.Create(aColl: TCollection);
begin
  inherited Create(aColl);

end;

{ TSVariables }

procedure TSVariables.Assign(aOtherStore: TSVariables);
var
  i, j : Integer;
  aVariable : TSVariable;
begin

  FVariables.Assign(aOtherStore.FVariables);
  FVariableList.Clear;
  //FVariableList.Assign(aOtherStore.FVariableList);
  for i := 0 to aOtherStore.VariableCount-1 do
  begin

    for j := 0 to FVariables.Count-1 do
    begin
      aVariable := FVariables.Items[j] as TSVariable;
      if CompareStr(aVariable.Key, UpperCase(Trim(aOtherStore.Variables[i].Key))) = 0 then
      begin
        FVariableList.Add(aVariable);
        Break;
      end;
    end;

  end;

end;

procedure TSVariables.Clear;
begin
  FVariableList.Clear;
  FVariables.Clear;
end;

constructor TSVariables.Create;
begin
  FVariables := TCollection.Create(TSVariable);
  FVariableList := TList.Create;
  //
end;

destructor TSVariables.Destroy;
begin
  //
  FVariableList.Free;
  FVariables.Free;

  inherited;

  inherited;
end;

function TSVariables.FindVariable(stKey: String): TSVariable;
var
  i : Integer;
  aVariable : TSVariable;
begin
  Result := nil;
  //
  for i := 0 to FVariableList.Count-1 do
  begin
    aVariable := TSVariable(FVariableList.Items[i]);
    //
    if CompareStr(aVariable.Key, UpperCase(Trim(stKey))) = 0 then
    begin
      FVariableList.Move(i, 0);
      Result := aVariable;
      Break;
    end;
  end;

end;

function TSVariables.GetVariable(stKey: String): Double;
var
  aVariable : TSVariable;
begin
  aVariable := FindVariable(stKey);
  //
  if aVariable = nil then
    Result := NaN
  else
    Result := aVariable.Value;

end;

function TSVariables.GetVariable2(stKey: String; var dValue1,
  dValue2: Double): TSVariable;
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

function TSVariables.GetVariableCount: Integer;
begin
    Result := FVariableList.Count;
end;

function TSVariables.GetVariableItem(i: Integer): TSVariable;
begin
  Result := nil;
  //
  if (i >= 0) and (i<FVariableList.Count) then
  begin
    Result := TSVariable(FVariableList.Items[i]);
  end;

end;

function TSVariables.RegVariable(stKey: String;
  dValue: Double): TSVariable;
var
  iP : Integer;
  //aVariable : TGlobalVariable;
begin
  Result := FindVariable(stKey);
  //
  if Result = nil then
  begin
    Result := FVariables.Add as TSVariable;
    Result.Key := Trim(UpperCase(stKey));
    FVariableList.Add(Result);
  end;
  //
  Result.Value := dValue;
  //
  iP := FVariableList.IndexOf(Result);
  FVariableList.Move(iP, 0);
  //
end;

function TSVariables.RegVariable2(stKey: String; dValue,
  dValue2: Double): TSVariable;
var
  iP : Integer;
begin
  Result := FindVariable(stKey);
  //
  if Result = nil then
  begin
    Result := FVariables.Add as TSVariable;
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

end;

procedure TSVariables.UnRegVariable(stKey: String);
var
  aVariable : TSVariable;
begin
  aVariable := FindVariable(stKey);

  if aVariable <> nil then
  begin
    FVariableList.Remove(aVariable);
    aVariable.Free;
  end;

end;

end.
