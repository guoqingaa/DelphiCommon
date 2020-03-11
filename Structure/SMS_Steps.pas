unit SMS_Steps;

interface

uses
  SysUtils, Classes, Math, SMS_DS;

type

  TPriceStepItem = class(TCommonCollectionItem)
  public
    PriceLow : Double; // included
    PriceHigh : Double; // not included
    Data : Double;

    destructor Destroy; override;
  end;

  TPriceStepsADay = class(TCommonCollectionItem)
  private
    FSteps : TCommonCollection;
    FLastAdded : TPriceStepItem;
  public
    constructor Create(aColl: TCollection); override;

    destructor Destroy; override;
    //
    // 자동으로 가격이 낮은 순서대로 sorting 이 됨.
    function AddData(const dPrice, dPriceHigh, dData : Double) : TPriceStepItem;
    procedure RemoveData(const dPrice, dPriceHigh, dData : Double);
    procedure Clear;

    function FindBestStep(iGrade : Integer): TPriceStepItem;

    function GetVariance : Double;
    function GetStdDev : Double;
    function GetDataSum : Currency;

    property Steps : TCommonCollection read FSteps;
  end;


implementation

{ TPriceStepsADay }

function TPriceStepsADay.AddData(
  const dPrice, dPriceHigh, dData: Double): TPriceStepItem;
var
  i : Integer;
  aStep : TPriceStepItem;
begin
  Result := nil;
  //
  if (FLastAdded <> nil) and
      (FLastAdded.PriceLow <= dPrice) and (dPrice < FLastAdded.PriceHigh) then
    Result := FLastAdded;
  //
  if Result = nil then
  begin
    //
    for i := 0 to FSteps.Count-1 do
    begin
      aStep := FSteps.Items[i] as TPriceStepItem;
      //
      if (dPrice < aStep.PriceLow) then
      begin
        Result := FSteps.Insert(i) as TPriceStepItem;
        Result.PriceLow := dPrice;
        Result.PriceHigh := dPriceHigh;
        //
        Break;
      end;
      if (aStep.PriceLow <= dPrice) and (dPrice < aStep.PriceHigh) then
      begin
        Result := aStep;
        Break;
      end;
    end;
    //
  end;
  //
  if Result = nil then
  begin
    Result := FSteps.Add as TPriceStepItem;
    //
    Result.PriceLow := dPrice;
    Result.PriceHigh := dPriceHigh;
  end;
  //
  Result.Data := Result.Data + dData;
  FLastAdded := Result;

end;

procedure TPriceStepsADay.Clear;
begin
  FSteps.Clear;
  FLastAdded := nil;
end;

constructor TPriceStepsADay.Create(aColl: TCollection);
begin
  inherited Create(aColl);
  //
  FSteps := TCommonCollection.Create(TPriceStepItem);
  FLastAdded := nil;
end;


destructor TPriceStepsADay.Destroy;
begin
  FSteps.Free;

  inherited;
end;

function PriceStepCompare(Item1, Item2: Pointer): Integer;
var
  aStep, aStep2 : TPriceStepItem;
begin
  aStep := TPriceStepItem(Item1);
  aStep2 := TPriceStepItem(Item2);
  //
  Result := CompareValue(aStep.Data, aStep2.Data)*-1;

end;


function TPriceStepsADay.FindBestStep(iGrade: Integer): TPriceStepItem;
var
  i : Integer;
  aStep : TPriceStepItem;
  aList : TList;
begin
  Result := nil;
  //
  aList := TList.Create;

  try
    for i := 0 to FSteps.Count-1 do
    begin
      aStep := FSteps.Items[i] as TPriceStepItem;
      //
      aList.Add(aStep);
    end;
    aList.Sort(PriceStepCompare);
    //
    if iGrade < aList.Count then
      Result := TPriceStepItem(aList.Items[iGrade]);
  finally
    aList.Free;
  end;

end;

{
procedure TPriceStepsADay.GetSortedSteps(iGrade: Integer);
var
  i : Integer;
  aStep : TPriceStepItem;
  aList : TList;
begin

  //
  aList := TList.Create;

  try
    for i := 0 to FSteps.Count-1 do
    begin
      aStep := FSteps.Items[i] as TPriceStepItem;
      //
      aList.Add(aStep);
      aList.Sort(PriceStepCompare);
    end;
    //
    if iGrade < aList.Count then
      Result := TPriceStepItem(aList.Items[iGrade]);
  finally
    aList.Free;
  end;


end;
}
function TPriceStepsADay.GetDataSum: Currency;
var
  i : Integer;
begin
  Result := 0;
  for i := 0 to FSteps.Count-1 do
    with FSteps.Items[i] as TPriceStepItem do
      Result := Result + Data;
end;

function TPriceStepsADay.GetStdDev: Double;
begin

end;

function TPriceStepsADay.GetVariance: Double;
begin

end;

procedure TPriceStepsADay.RemoveData(const dPrice, dPriceHigh,
  dData: Double);
var
  i : Integer;
  aStep : TPriceStepItem;
begin
  for i := 0 to FSteps.Count-1 do
  begin
    aStep := FSteps.Items[i] as TPriceStepItem;
    //
    if (dPrice = aStep.PriceLow) and (dPriceHigh = aStep.PriceHigh) then
    begin
      aStep.Data := aStep.Data - dData;
      //
      if IsZero(aStep.Data) then
        aStep.Free;
      Break;
    end;
  end;
  //

end;

{ TPriceStepItem }

destructor TPriceStepItem.Destroy;
begin

  inherited;
end;

end.
