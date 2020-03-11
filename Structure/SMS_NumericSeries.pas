unit SMS_NumericSeries;

interface

uses
  SysUtils, Classes, Math, Types;

type
{ Numeric Series }

  TSNumericSeriesItem = class(TCollectionItem)
  public
    IsValid : Boolean;
    Value : Double;
  end;

  TSNumericSeriesStore = class;

  TSNumericSeries = class(TCollectionItem)
  private
    FParent : TSNumericSeriesStore;
    function GetIValids(i: Integer): Boolean;

  protected
    FKey : String;
    FData : TCollection;

    FLastChanged : Boolean;

    //
    procedure FillGap;
    // property methods
    function GetValid(i:Integer) : Boolean;
    function GetValue(i:Integer) : Double;
    function GetIValue(i:integer) : Double;
    procedure SetIValue(i:Integer; dValue : Double);
    //

  public
    Data1 : TObject;  //user defined value
    Data2 : TObject;  //user defined value
    //
    constructor Create(aColl : TCollection); override;
    destructor Destroy; override;

    constructor CustomCreate(aColl : TCollection); // used by childern

    //function Average(iP, iLength: Integer): Double;
    //function StdDev(iP, iLength: Integer): Double;

    //function MinValue(iP, iLength: Integer): Double;
    //function MaxValue(iP, iLength: Integer): Double;

    procedure Tick;
    function Count : Integer;
    //procedure GetMinMax(iStart, iEnd : Integer; var dMin, dMax : Double);

    property Key : String read FKey write FKey;


    property Valids[i:Integer] : Boolean read GetValid;
    property Values[i:Integer] : Double read GetValue;
    property IValids[i:Integer] : Boolean read GetIValids;
    property IValues[i:Integer] : Double read GetIValue write SetIValue; default;


    property NumericData: TCollection read FData;
    property LastChanged : Boolean read FLastChanged;
  end;

  TSNumericSeriesStore = class(TCollection)
  private
    FCurrentBar: Integer;
    procedure SetCurrentBar(const Value: Integer);
  public
    //
    constructor Create;
    //
    procedure Tick;
    procedure Reset;
    function Get(const stKey : String) : TSNumericSeries;
    //
    property CurrentBar : Integer read FCurrentBar write SetCurrentBar;

  end;

  {
  function SNumericSeriesCovariance(aSeries1, aSeries2: TSNumericSeries;
                const iP, iLength: Integer): Double;
  }
implementation


function TSNumericSeries.Count: Integer;
begin
  Result := FData.Count;
end;

constructor TSNumericSeries.Create(aColl: TCollection);
begin
  inherited Create(aColl);

  FData := TCollection.Create(TSNumericSeriesItem);
  FLastChanged := True;
  //
  Data1 := nil;
  Data2 := nil;

end;

constructor TSNumericSeries.CustomCreate(aColl: TCollection);
begin
  inherited Create(aColl);

  FLastChanged := True;
  // children have to create FData object

end;

destructor TSNumericSeries.Destroy;
begin
  FData.Free;
  //
  inherited;
end;

procedure TSNumericSeries.FillGap;
var
  i : Integer;
begin
  for i:=1 to FParent.CurrentBar-(FData.Count-1) do
  with FData.Add as TSNumericSeriesItem do
  begin
    IsValid := False;
    Value := 0.0;
  end;
end;

function TSNumericSeries.GetIValids(i: Integer): Boolean;
var
  iP : Integer;
begin
  if FData.Count < FParent.FCurrentBar then FillGap;
  //
  iP := FParent.FCurrentBar - i;
  //
  if (iP >= 0) and (iP < FData.Count) then
    Result := (FData.Items[iP] as TSNumericSeriesItem).IsValid
  else
    Result := False;

end;
//
constructor TSNumericSeriesStore.Create;
begin
  inherited Create(TSNumericSeries);
end;

function TSNumericSeriesStore.Get(const stKey: String): TSNumericSeries;
var
  i : Integer;
begin
  Result := nil;
  //
  for i:=0 to Count-1 do
    with Items[i] as TSNumericSeries do
    if Key = stKey then
    begin
      Result := Items[i] as TSNumericSeries;
      Break;
    end;
  //
  if Result = nil then
  begin
    Result := Add as TSNumericSeries;
    Result.Key := stKey;
    Result.FParent := Self;
  end;

end;

procedure TSNumericSeriesStore.Reset;
var
  i : Integer;
begin
  for i:=0 to Count-1 do
    (Items[i] as TSNumericSeries).FData.Clear;
  //
  FCurrentBar := 0;
end;

procedure TSNumericSeriesStore.SetCurrentBar(const Value: Integer);
begin
  FCurrentBar := Value;
end;

function TSNumericSeries.GetIValue(i: integer): Double;
var
  iP : Integer;
begin
  if FData.Count < FParent.CurrentBar then FillGap;
  //
  iP := FParent.CurrentBar - i;
  //
  if (iP >= 0) and (iP < FData.Count) then
    Result := (FData.Items[iP] as TSNumericSeriesItem).Value
  else
    Result := 0.0;

end;


function TSNumericSeries.GetValid(i: Integer): Boolean;
begin
  if (i>=0) and (i<FData.Count) then
    Result := (FData.Items[i] as TSNumericSeriesItem).IsValid
  else
    Result := False;
end;

function TSNumericSeries.GetValue(i: Integer): Double;
begin
  if (i>=0) and (i<FData.Count) then
    Result := (FData.Items[i] as TSNumericSeriesItem).Value
  else
    Result := 0.0;
end;


procedure TSNumericSeries.SetIValue(i: Integer; dValue: Double);
var
  j, iP : Integer;
  aItem : TSNumericSeriesItem;
begin
  //
  if FData.Count-1 < FParent.FCurrentBar then FillGap;
  //
  iP := FParent.FCurrentBar - i;
  //
  if iP > FData.Count-1 then
    for j:=1 to iP-(FData.Count-1) do
    with FData.Add as TSNumericSeriesItem do
    begin
      IsValid := False;
      Value := 0.0;
    end;
  //
  if (iP >= 0) and (iP < FData.Count) then
  begin
    aItem := FData.Items[iP] as TSNumericSeriesItem;
    with aItem do
    begin
      //
      if i = 0 then
      begin
        FLastChanged := True;
        //
        if Value = dValue then
        begin
          FLastChanged := False;
        end;

        if not IsValid then
          FLastChanged := True;
      end;

      IsValid := not IsNan(dValue);
      //IsValid := True;
      Value := dValue;
    end;
  end;

end;

procedure TSNumericSeries.Tick;
var
  aItem : TSNumericSeriesItem;
begin
  if FData.Count > 0 then
    aItem := FData.Items[FData.Count-1] as TSNumericSeriesItem
  else
    aItem := nil;
  //-- add an item and copy previous value
  with FData.Add as TSNumericSeriesItem do
  if aItem <> nil then
  begin
    IsValid := aItem.IsValid;
    Value := aItem.Value;
  end else
  begin
    IsValid := False;
    Value := 0.0;
  end;
end;

procedure TSNumericSeriesStore.Tick;
var
  i : Integer;
begin
  for i:=0 to Count-1 do
  (Items[i] as TSNumericSeries).Tick;

end;

end.
