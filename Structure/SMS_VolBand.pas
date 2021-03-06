unit SMS_VolBand;

interface

uses
  SysUtils, Classes, Math,
  SMS_Steps, SMS_DS;

type

  TVolBandItem = class(TCommonCollectionItem)
  public
    //DateInt : Integer;
    BandHigh : Double;
    BandLow : Double;
  end;

  TVolBandStore = class;
  TVolBandItems = class(TCommonCollectionItem)
  private
    FParent : TVolBandStore;
    FItems : TCommonCollection;    {TVolBandItem}
    FRefCount: Integer;
    procedure SetRefCount(const Value: Integer);
    //FIsDone: Boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure CheckInvalidate;

    property RefCount : Integer read FRefCount write SetRefCount;
    property Items : TCommonCollection read FItems;

    //property IsDone : Boolean read FIsDone write FIsDone;
  end;

  TVolBandStore = class(TCommonCollection)
  public
    function AddItems: TVolBandItems;
  end;

  TVolBandCreater = class
    FCurrentPriceStepsADay : TPriceStepsADay;

    FBandRatio : Double;      // ( 0~0.9) 사이의 소수점
  private
    FLastAddedStep : TPriceStepItem;
    FVolBandItems : TVolBandItems;
    FVolBandP : Integer;

    procedure SetBandRatio(const Value: Double);
  public
    LatestPriceStepVolSums : TPriceStepsADay;
    DailyPriceSteps : TCommonCollection;
    //
    BandLow : Double;
    BandHigh : Double;
    StepSize : Double;
    VolDays : Integer;
    Symbol : String;

    ExecKey : String;

    NewCalculateMode : Boolean;

    constructor Create;
    destructor Destroy; override;

    procedure Init;
    procedure Clear;

    function AddDailyStepsItem: TPriceStepsADay;
    function CalculateBands(const iDateInt: Integer): Boolean;
    function AddVol(const dPrice: Double; dVol : Double): TPriceStepItem;
    procedure SumLatestPriceStepVols;
    //
    function LoadBandFromStore(const iDate: Integer): Boolean;

    property BandRatio : Double read FBandRatio write SetBandRatio;

  end;

implementation

var
  gVolBandStore3 : TVolBandStore = nil;


{ TVolBandItems }


procedure TVolBandItems.CheckInvalidate;
begin
  if FItems.Count = 0 then
    Free;
end;

constructor TVolBandItems.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  //
  //FIsDone := False;
  //
  FItems := TCommonCollection.Create(TVolBandItem);
  FRefCount := 0;
end;

destructor TVolBandItems.Destroy;
begin
  FItems.Free;

  inherited;

  //if FParent.Count = 0 then
  //  FreeAndNil(FParent);
end;

procedure TVolBandItems.SetRefCount(const Value: Integer);
begin
  FRefCount := Value;
  //
  {
  if FRefCount <= 0 then
    Free;
  }
end;

{ TVolBandCreater }

function TVolBandCreater.AddDailyStepsItem: TPriceStepsADay;
begin
  FCurrentPriceStepsADay := DailyPriceSteps.Add as TPriceStepsADay;
  BandLow := NaN;
  BandHigh := NaN;
  FLastAddedStep := nil;
end;


function TVolBandCreater.AddVol(const dPrice: Double; dVol : Double): TPriceStepItem;
var
  i : Integer;
  aStep : TPriceStepItem;
  dLow, dHigh : Double;
begin
  Result := nil;
  //
  if (FLastAddedStep <> nil) and
      (FLastAddedStep.PriceLow <= dPrice) and (dPrice < FLastAddedStep.PriceHigh) then
    Result := FLastAddedStep;
  //
  if Result = nil then
  begin
    //
    for i := 0 to FCurrentPriceStepsADay.Steps.Count-1 do
    begin
      aStep := FCurrentPriceStepsADay.Steps.Items[i] as TPriceStepItem;
      //
      if (dPrice < aStep.PriceLow) then
      begin
        Result := FCurrentPriceStepsADay.Steps.Insert(i) as TPriceStepItem;
        dLow := Floor(dPrice/StepSize)*StepSize;
        dHigh := dLow + StepSize;
        Result.PriceLow := dLow;
        Result.PriceHigh := dHigh;
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
    Result := FCurrentPriceStepsADay.Steps.Add as TPriceStepItem;
    //
    dLow := Floor(dPrice/StepSize)*StepSize;
    dHigh := dLow + StepSize;
    Result.PriceLow := dLow;
    Result.PriceHigh := dHigh;
  end;
  //
  Result.Data := Result.Data + dVol;
  FLastAddedStep := Result;
end;

(* old version
function TVolBandCreater.CalculateBands(const iDateInt: Integer): Boolean;
var
  dRemains, dCurrent, dTarget, dTotal: Currency;
  i, iCount : Integer;
  aStepItem : TPriceStepItem;
  aVolItem : TVolBandItem;
begin
  Result := False;
  if not NewCalculateMode then
  begin
    //loading 모드시 store에서 가져온다.
    aVolItem := FVolBandItems.Items.FindItem(iDateInt, 0, FVolBandP) as TVolBandItem;
    if aVolItem <> nil then
    begin
      BandHigh := aVolItem.BandHigh;
      BandLow := aVolItem.BandLow;
      Result := True;
      Exit;
    end;
    //
  end;

  dTotal := LatestPriceStepVolSums.GetDataSum;
  dCurrent := 0;
  dTarget := dTotal * (0.5 - FBandRatio / 2);
  iCount := 0;
  BandHigh := Nan;
  BandLow := Nan;
  //
  for i := 0 to LatestPriceStepVolSums.Steps.Count-1 do
  begin
    aStepItem := LatestPriceStepVolSums.Steps.Items[i] as TPriceStepItem;
    //
    dCurrent := dCurrent + aStepItem.Data;
    //
    if dCurrent >= dTarget then
    begin
      if iCount = 0 then
      begin
        BandLow := aStepItem.PriceLow;
        dTarget := dTotal * (1 - (0.5 - FBandRatio / 2));
        iCount := 1;
      end else
      begin
        BandHigh := aStepItem.PriceHigh;
        Break;
      end;
    end;
  end;
  //
  aVolItem := FVolBandItems.Items.Add as TVolBandItem;
  aVolItem.KeyByInt := iDateInt;
  aVolItem.BandHigh := BandHigh;
  aVolItem.BandLow := BandLow;

end;
*)
function TVolBandCreater.CalculateBands(const iDateInt: Integer): Boolean;
var
  dRemains, dCurrent, dTarget, dTotal: Currency;
  i, iCount : Integer;
  aStepItem : TPriceStepItem;
  aVolItem : TVolBandItem;
begin
  Result := False;

  dTotal := LatestPriceStepVolSums.GetDataSum;
  dCurrent := 0;
  dTarget := dTotal * (0.5 - FBandRatio / 2);
  iCount := 0;
  BandHigh := Nan;
  BandLow := Nan;
  //
  for i := 0 to LatestPriceStepVolSums.Steps.Count-1 do
  begin
    aStepItem := LatestPriceStepVolSums.Steps.Items[i] as TPriceStepItem;
    //
    dCurrent := dCurrent + aStepItem.Data;
    //
    if dCurrent >= dTarget then
    begin
      if iCount = 0 then
      begin
        BandLow := aStepItem.PriceLow;
        dTarget := dTotal * (1 - (0.5 - FBandRatio / 2));
        iCount := 1;
      end else
      begin
        BandHigh := aStepItem.PriceHigh;
        Break;
      end;
    end;
  end;
  //
  aVolItem := FVolBandItems.Items.Add as TVolBandItem;
  aVolItem.KeyByInt := iDateInt;
  aVolItem.BandHigh := BandHigh;
  aVolItem.BandLow := BandLow;
  Result := True;

end;

procedure TVolBandCreater.Clear;
begin
  DailyPriceSteps.Clear;
  FLastAddedStep := nil;
  //
  LatestPriceStepVolSums := DailyPriceSteps.Add as TPriceStepsADay;
  FCurrentPriceStepsADay := nil;
end;

constructor TVolBandCreater.Create;
begin
  BandRatio := 0.4;
  StepSize := 1;
  NewCalculateMode := True;
  //
  DailyPriceSteps := TCommonCollection.Create(TPriceStepsADay);
  Clear;

end;

destructor TVolBandCreater.Destroy;
begin
  DailyPriceSteps.Free;
  //
  inherited;
end;

procedure TVolBandCreater.Init;
begin
  //
  if gVolBandStore3 = nil then
    gVolBandStore3 := TVolBandStore.Create(TVolBandItems);
  //
  if FVolBandItems <> nil then
    FVolBandItems.CheckInvalidate;
  //
  ExecKey := Format('%s_S%fL%d_R%.1f', [Symbol, StepSize, VolDays, BandRatio]);
  //
  FVolBandItems := gVolBandStore3.FindItem(ExecKey) as TVolBandItems;
  if FVolBandItems = nil then
  begin
    FVolBandItems := gVolBandStore3.AddItems;
    FVolBandItems.KeyByString := ExecKey;
  end;
  //
  FVolBandP := 0;

end;

(* old version
function TVolBandCreater.LoadBandFromStore(const iDate: Integer): Boolean;
begin
  BandLow := Nan;
  BandHigh := Nan;
  //
  Result := CalculateBands(iDate);
end;
*)

function TVolBandCreater.LoadBandFromStore(const iDate: Integer): Boolean;
var
  aVolItem : TVolBandItem;
begin
  BandLow := Nan;
  BandHigh := Nan;
  Result := False;
  //
  //loading 모드시 store에서 가져온다.
  aVolItem := FVolBandItems.Items.FindItem(iDate, 0, FVolBandP) as TVolBandItem;
  if aVolItem <> nil then
  begin
    BandHigh := aVolItem.BandHigh;
    BandLow := aVolItem.BandLow;
    Result := True;
  end;
  //
end;


procedure TVolBandCreater.SetBandRatio(const Value: Double);
begin
  FBandRatio := Min(Value, 0.9);
end;

procedure TVolBandCreater.SumLatestPriceStepVols;
var
  i, j, iP: Integer;
  aPriceSteps : TPriceStepsADay;
  aPriceStepItem : TPriceStepItem;
begin

  // version 1.
  LatestPriceStepVolSums.Clear;// Steps.Clear;
  //
  iP := 1;
  //iRemove := -1;
  for i := DailyPriceSteps.Count-1 downto 1 do
  begin
    aPriceSteps := DailyPriceSteps.Items[i] as TPriceStepsADay;
    //
    for j := aPriceSteps.Steps.Count-1 downto 0 do
    begin
      aPriceStepItem := aPriceSteps.Steps.Items[j] as TPriceStepItem;
      LatestPriceStepVolSums.AddData(aPriceStepItem.PriceLow,
        aPriceStepItem.PriceHigh, aPriceStepItem.Data);
    end;
    //
    Inc(iP);
    //
    if iP > VolDays then
    begin
      //
      Break;
    end;
  end;
  //

end;

{ TVolBandStore }

function TVolBandStore.AddItems: TVolBandItems;
begin
  Result := Add as TVolBandItems;
  Result.FParent := Self;
end;


initialization

finalization
  gVolBandStore3.Free;

end.
