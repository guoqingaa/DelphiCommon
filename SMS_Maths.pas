unit SMS_Maths;

interface

uses
  SysUtils, Windows, Types, Classes;

const
  EPSILON = 10e-8;
  BIG_INT = High(Integer);

  ONE_MEGA = 1048576;
  ONE_GIGA = 1073741824;

  function IsEpsilonZero(const dValue: Double): Boolean;
  function IsNotEpsilonZero(const dValue: Double): Boolean;
  function RealString(dReal: Double; iMaxPrecision : Integer = 5): String;

  //function IsNumeric(oValue: Variant): Boolean;
  function IsNumeric(const stValue: String): Boolean;
  function IsNumeric2(stValue: String): Boolean;


  function MaxValues(aValues: array of Double): Double;
  function MinValues(aValues: array of Double): Double;

  function LinerSlope(yValues, xValues: array of double; var interceptValue, rValue: double):Double;
  function ExcelSlope(yValues, xValues: array of Double): Double;
  function ExcelSlopeENanB(const yOrgValues, xOrgValues: array of Double; const iStart, iLength: Integer): Double;

  function LinRegArray(aPriceArray : array of Double; iSize: Integer;
    TgtPos: Double; var oLRSlope, oLRAngle, oLRIntercept, oLRValueRaw : Double): Double;

  function AverageENan(const aValues: array of Double): Double;
  function AverageENanSL(const aValues: array of Double; const iStart, iLength: Integer): Double;

  function ByteToMegaByte(const dValue: Double): Double;

  function GetGCD(aIntArray: TIntegerDynArray): Integer;

  function ShortestLength(p1, p2, p : TPoint) : Double;
  function IntegerToFractionPrice(const iNumber: Integer): Double;


type
    TCombinationEvent = procedure(aResult: array of Byte) of object;

  procedure Combination(aCombinationEvent: TCombinationEvent;
    var aValue: array of Byte; n, r: Byte;
    index: Byte = 0; target: Byte = 0);

  function CombinationCount(const n,r : Integer): Int64;
  function CombinationCount2(const n, r: Integer): Int64;

  function Factorial(const n: Integer): Int64;

  procedure GenerateCombination(aCallBack : TCombinationEvent;
              aInput : array of Byte; n, r : Byte;
              index: Byte = 0; target: Byte= 0);
  procedure GenerateCombinationV2(aCallBack : TCombinationEvent;
              aInput : array of Byte; s{start number}, n, r : Byte;
              index: Byte = 0; target: Byte= 0);



type
  TCombinationCalculator = class;

  TCombinationCalculateThread = class(TThread)
  protected


    procedure ThreadCombination(const  n, r, index, target: Byte ); virtual;

    procedure Execute; override;
  public
    FN : Byte;
    FR : Byte;

    FIndex : Byte;
    FTarget : Byte;
    //
    FIntArray : array of Byte;
    IntArrayLength : Integer;
    FComplete : Boolean;

    ParentCalculator : TCombinationCalculator;

    constructor CreateThread; virtual;
    destructor Destroy; override;

    property IsComplete: Boolean read FComplete;

  end;

  TCombinationCalculateThreadClass = class of TCombinationCalculateThread;

  TCombinationCalculator = class
  private
    FCalcThreadClass : TCombinationCalculateThreadClass;


    FThreadCount: Integer;
    FCurrentThreadCount : Integer;
    FOnCombinationSelected: TCombinationEvent;

    Fn : Byte;
    Fr : Byte;
    FIndex : Byte;
    FTarget : Byte;

    FIntArray : array of Byte;
    FOnCompleted: TNotifyEvent;
    FOnThreadTerminated: TNotifyEvent;
    FLiveThreadCount: Integer;


    procedure CalcCombination(n, r: Byte;
                index: Byte = 0; target: Byte = 0);

  protected

  public
    FCalculateThreadList : TList;

    constructor Create;
    destructor Destroy; override;

    procedure ThreadComplete(Sender: TObject);

    procedure StartCombination(n, r: Byte; index: Byte = 0; target: Byte = 0);

    property OnCombinationSelected : TCombinationEvent
      read FOnCombinationSelected write FOnCombinationSelected;

    property OnCompleted : TNotifyEvent read FOnCompleted write FOnCompleted;
    property OnThreadTeminated : TNotifyEvent read FOnThreadTerminated write FOnThreadTerminated;

    property ThreadClass : TCombinationCalculateThreadClass read FCalcThreadClass
                write FCalcThreadClass;
    property ThreadCount : Integer read FThreadCount write FThreadCount;
    property ThreadList : TList read FCalculateThreadList write FCalculateThreadList;
    property LiveThreadCount : Integer read FLiveThreadCount write FLiveThreadCount;
    property CurrentThreadCount : Integer read FCurrentThreadCount write FCurrentThreadCount;

  end;



implementation

uses Math;

//============================================================================//
// 직선의 방정식 ax + by + c = 0 과 (p,q)인 점과의 최단거리
// d(최단거리) = |ap + bq + c| / root(a*a + b*b)
//============================================================================//
function ShortestLength(p1, p2, p : TPoint) : Double;
var
  m, dSlope : Double;
  a, b, c : Double;

begin
  // y= ax + m
  // y = dSlope * x + m

  if IsZero(p1.x - p2.x) then
    dSlope := 0.0
  else
    dSlope := (p1.y - p2.y) / (p1.x - p2.x);


  // b ?
  m := p1.y - dSlope*p1.x;

  // ax - y + m = 0
  a := dSlope;
  b := -1;
  c := m;

  Result := Abs(a*p.x + b*p.y + c)/sqrt(a*a + b*b);

end;

function IntegerToFractionPrice(const iNumber: Integer): Double;
begin
  if iNumber mod 10 = 2 then
    Result := (iNumber div 10) + 0.25
  else if iNumber mod 10 = 4 then
    Result := (iNumber div 10) + 0.5
  else if iNumber mod 10 = 6 then
    Result := (iNumber div 10) + 0.75
  else
    Result := (iNumber div 10);
end;


procedure GenerateCombination(aCallBack : TCombinationEvent;
              aInput : array of Byte; n, r : Byte;
              index: Byte = 0; target: Byte= 0);

    procedure combinationUtil(
            aOutput : array of Byte;
            iStart, iEnd, index : Byte);
    var
      i : Integer;
    begin
      //
      if (index = r) then
      begin
        aCallBack(aOutput);
        Exit;
      end;
      //
      i := iStart;
      while ((i <= iEnd) and (iEnd-i+1>= r-index)) do
      begin
        aOutput[index] := aInput[i];
          combinationUtil(aOutput, i+1{istart}, iend{iend}, index+1{index});
        Inc(i);
      end;
      //

    end;

    procedure StartCombination;
    var
      aOutput : array of Byte;
    begin
      // A temporary array to store all combination one by one

      SetLength(aOutput, r);

      // Print all combination using temprary array 'data[]'
      combinationUtil(aOutput, 0{start}, n-1{end}, 0{index});
    end;


begin
  StartCombination;
end;



procedure GenerateCombinationV2(aCallBack : TCombinationEvent;
              aInput : array of Byte; s{start number}, n, r : Byte;
              index: Byte = 0; target: Byte= 0);

    procedure CombinationUtil(
            aOutput : array of Byte;
            iStart, iEnd, index : Byte);
    var
      i : Integer;
    begin
      //
      if (index = r) then
      begin
        aCallBack(aOutput);
        Exit;
      end;
      //
      i := iStart;
      while ((i <= iEnd) and (iEnd-i+1>= r-index)) do
      begin
        aOutput[index] := aInput[i];
          combinationUtil(aOutput, i+1{istart}, iend{iend}, index+1{index});
        Inc(i);
      end;
      //

    end;

    procedure StartCombination;
    var
      aOutput : array of Byte;
    begin
      // A temporary array to store all combination one by one

      SetLength(aOutput, r);

      // Print all combination using temprary array 'data[]'
      combinationUtil(aOutput, s{start}, n-1{end}, 0{index});
    end;


begin
  StartCombination;
end;


function GetGCD(aIntArray: TIntegerDynArray): Integer;

  function InnerGCD(u, v : Integer): Integer;
  var
    temp: Integer;
  begin

    while(v<>0) do
    begin
      temp := u mod v;
      u := v;
      v := temp;
    end;

    Result := u;

  end;

var
  i : Integer;
begin
  if Length(aIntArray)=0 then
    Result := 1
  else if Length(aIntArray)= 1 then
    Result := aIntArray[0]
  else
  begin
    Result := 1;

    for i := 0 to Length(aIntArray)-2 do
    begin
      if i = 0 then
        Result := InnerGCD(aIntArray[0], aIntArray[1])
      else
        Result := InnerGCD(Result, aIntArray[i+1]);
    end;

    {
    for i := 0 to Length(aIntArray)-2 do
    begin
      Result := InnerGCD(Result, InnerGCD(aIntArray[i], aIntArray[i+1]));
    end;
    }
  end;
end;



function ByteToMegaByte(const dValue: Double): Double;
begin
  Result := dValue / ONE_MEGA;
end;

function CombinationCount2(const n, r: Integer): Int64;
const
  MAXNR = 100;
var
  i, j : Integer;
  bc : array of array of uint64;
begin

  SetLength(bc, MAXNR, MAXNR);
  for i := 0 to n do
    bc[i][0] := 1;
  //
  for j := 0 to n do
    bc[j][j] := 1;
  //
  for i := 1 to n do
    for j := 1 to i-1 do
      bc[i][j] := bc[i-1][j-1] + bc[i-1][j];
  //
  Result := bc[n][r];

  bc := nil;
end;

function CombinationCount(const n,r : Integer): Int64;
begin
  //Result := round(Factorial(n)/Factorial(n-r)*Factorial(r));
  if (r = 0) or (r = n) then
  begin
    Result := 1;
    Exit;
  end else
  if (r = 1) then
  begin
    Result := n;
    Exit;
  end;
  Result := CombinationCount(n-1, r-1) + CombinationCount(n-1, r);
end;


function Factorial(const n: Integer): Int64;
var
  i : Integer;
begin
  Result := 1;
  //
  for i := 1 to n do
    Result := Result * i;
end;


procedure Combination(aCombinationEvent: TCombinationEvent;
   var aValue: array of Byte;  n, r,
  index, target: Byte);
begin
  if (r = 0) then
  begin
    //
    if Assigned(aCombinationEvent) then
      aCombinationEvent(aValue);
    //
  end else
  if (target = n) then Exit
  else
  begin
    aValue[index] := target;
    Combination(aCombinationEvent, aValue, n , r - 1, index + 1, target + 1);
    Combination(aCombinationEvent, aValue, n, r, index, target + 1);
  end;

end;



function AverageENan(const aValues: array of Double): Double;
var
  i, iCount : Integer;
begin
  Result := 0;
  iCount := 0;
  for i := 0 to Length(aValues)-1 do
  begin
    if not IsNan(aValues[i]) then
    begin
      Result := Result + aValues[i];
      Inc(iCount);
    end;
  end;
  if iCount = 0 then
    Result := Nan
  else
    Result := Result / iCount;
end;

function AverageENanSL(const aValues: array of Double; const iStart, iLength: Integer): Double;
var
  i, iCount: Integer;
begin
  //
  Result := 0;
  iCount := 0;
  for i := iStart to Min(Length(aValues)-1, iStart+iLength-1) do
  begin
    if not IsNan(aValues[i]) then
    begin
      Result := Result + aValues[i];
      Inc(iCount);
    end;
  end;
  if iCount = 0 then
    Result := Nan
  else
    Result := Result / iCount;
end;

{
function IsNumeric(oValue: Variant): Boolean;
begin
  Result := TVarData(oValue).VType in [varDouble, varSingle, varInteger, varByte,
    varShortInt, varWord, varLongWord, varInt64, varCurrency];
end;
}

function IsNumeric(const stValue: String): Boolean;
var
  V : Double;
  Code : Integer;
begin
  Val(stValue, V, Code);
  Result := Code = 0;
end;

function IsNumeric2(stValue: String): Boolean;
var
  V : Double;
  Code : Integer;
begin
  stValue := StringReplace(stValue, ',', '', [rfReplaceAll]);
  Val(stValue, V, Code);
  Result := Code = 0;
end;


function MaxValues(aValues: array of Double): Double;
var
  i : Integer;
  dValue : Double;
begin
  Result := NaN;
  //
  for i := 0 to Length(aValues)-1 do
  begin
    dValue := aValues[i];
    //
    if i = 0 then
      Result := dValue
    else
      Result := Max(Result, dValue);
  end;

end;

function MinValues(aValues: array of Double): Double;
var
  i : Integer;
  dValue : Double;
begin
  Result := NaN;
  //
  for i := 0 to Length(aValues)-1 do
  begin
    dValue := aValues[i];
    //
    if i = 0 then
      Result := dValue
    else
      Result := Min(Result, dValue);
  end;

end;


function RealString(dReal: Double; iMaxPrecision : Integer = 5): String;
var
  i : Integer;
begin
  Result := Format('%.*f', [iMaxPrecision, dReal]);
  for i := Length(Result) downto 1 do
    if Result[i] ='0' then
      Result := Copy(Result, 1, i-1)
    else
      Break;
end;

function IsEpsilonZero(const dValue: Double): Boolean;
begin
  Result := (dValue > -EPSILON) and (dValue < EPSILON);
end;

function IsNotEpsilonZero(const dValue: Double): Boolean;
begin
  Result := not IsEpsilonZero(dValue);
end;


function ExcelSlope(yValues, xValues: array of Double): Double;
var
  i, iLength : Integer;
  xAvg, yAvg : Double;
  dTopSum, dBottomSum : Double;
begin
  iLength := length(yValues);
  //
  if iLength <> Length(xValues) then
  begin
    Result := -1;
    Exit;
  end;
  //
  xAvg := Sum(xValues)/iLength;
  yAvg := Sum(yValues)/iLength;
  //
  dTopSum := 0;
  dBottomSum := 0;
  for i := 0 to iLength-1 do
  begin
    dTopSum := dTopSum + (xValues[i]-xAvg)*(yValues[i]-yAvg);
    dBottomSum := dBottomSum + (xValues[i]-xAvg)*(xValues[i]-xAvg);
  end;
  Result := dTopSum / dBottomSum;

end;

function ExcelSlopeENanB(const yOrgValues, xOrgValues: array of Double; const iStart, iLength: Integer): Double;
var
  i, iMLength, iXLength, iYLength, iLen : Integer;
  yValues, xValues : array of Double;
  xAvg, yAvg : Double;
  dTopSum, dBottomSum : Double;
begin
  //
  iXLength := Length(xOrgValues);
  iYLength := Length(yOrgValues);
  if iXLength <> iYLength then
  begin
    Result := Nan;
    Exit;
  end;
  //
  iMLength := IfThen(iStart - iLength + 1 < 0, iLength + (iStart - iLength + 1), iLength);
  //
  {
  SetLength(yValues, iMLength);
  SetLength(xValues, iMLength);
  //
  CopyMemory(@yValues[0], @yOrgValues[Max(0, iStart-iLength+1)], iMLength*SizeOf(Double));
  CopyMemory(@xValues[0], @xOrgValues[Max(0, iStart-iLength+1)], iMLength*SizeOf(Double));
  }
  //
  for i := iStart-1 downto 0 do
  begin
    if (IsNan(xOrgValues[i])=False) and (IsNan(yOrgValues[i])=False) then
    begin
      {
      if i < iMLength-1 then
      begin
        iLen := Length(xValues);
        if iLen = 1 then
        begin
          Result := Nan;
          Exit;
        end;
        //
        if i+1 < iLen then
        begin
          MoveMemory(@xValues[i], @xValues[i+1], (iMLength-1-i)*SizeOf(Double));
          MoveMemory(@yValues[i], @yValues[i+1], (iMLength-1-i)*SizeOf(Double));
        end;
      end;
      SetLength(xValues, Length(xValues)-1);
      SetLength(yValues, Length(yValues)-1);
      //
      continue;
      //
      }
    end;
  end;
  Result := ExcelSlope(yValues, xValues);

end;

function LinerSlope(yValues, xValues: array of double; var interceptValue, rValue: double):Double;
var
  i, iLength : integer;
  ySum, xSum, xySum, yySum, xxSum, yAvg, xAvg: double;
begin

  xySum := 0;
  xxSum := 0;
  yySum := 0;
  iLength := length(yValues);

  //x, y 길이가 맞지 않으면 처리 중지.
  if iLength <> length(xValues) then
  begin
    interceptValue := -1;
    Result := -1;
    Exit;
  end;
 //
  //ySum := Sum(yValues);
  //xSum := Sum(xValues);

 for i := 0 to iLength -1 do
 begin
   ySum := ySum + yValues[i];
   xxSum := xxSum + xValues[i]*xValues[i];
   yySum := yySum + yValues[i]*yValues[i];
   xSum := xSum + xValues[i];
   xySum := xySum + (yValues[i]*xValues[i]);
 end;
 yAvg := ySum / iLength;
 xAvg := xSum / iLength;
 //
 Result         := (xySum - (xSum * yAvg)) / (xxSum - (xSum*xAvg));
 //
 interceptValue := yAvg - (Result * xAvg);
 //
 try
   rValue         := (iLength*xySum - xSum*ySum )
                      /
                     sqrt(
                     (iLength * xxSum - xSum*xSum)
                      *
                     (iLength * yySum - ySum*ySum)
                     );
 except on E: Exception do
 end;
end;


{ Linear Regression multiple-output function - array version; see MULTIPLE-OUTPUT 
  FUNCTIONS note below }
function LinRegArray(aPriceArray : array of Double; iSize: Integer;
  TgtPos: Double; var oLRSlope, oLRAngle, oLRIntercept, oLRValueRaw : Double): Double;

(*
	PriceArray[MaxSize]( numericarray ), { element 0 not used }
	Size( numericsimple ), { MaxSize >= Size > 1 }
	TgtPos( numericsimple ), { use negative integer for future, positive for past }
	oLRSlope( numericref ),
	oLRAngle( numericref ),
	oLRIntercept( numericref ), { intercept at vertical through PriceArray[Size] }
	oLRValueRaw( numericref ) ; { adjustment for calling offset, oLRSlope *
	 ExecOffset, not added in as in non-array version, since array functions are
	 considered to be independent of the time series }
*)
var
	dSumXY : Double;
	dSumY : Double;
	dSumX : Double;
	dSumXSqr : Double;
	dOneSixth : Double;
	dDivisor : Double;
  i{, j} : Integer;
begin
  //dSumXY := 0;
	//dSumY := 0;
	//dSumX := 0;
	//dSumXSqr := 0;
	dOneSixth := ( 1 / 6 );
	//dDivisor := 0;


  if iSize > 1 then
	begin
  	dSumX := iSize * ( iSize - 1 ) * 0.5 ;
	  dSumXSqr := iSize * ( iSize - 1 ) * ( 2 * iSize - 1 ) * dOneSixth ;
  	dDivisor := Power( dSumX, 2 ) - iSize * dSumXSqr ;
	  dSumXY := 0;
    for i := 1 to iSize do
    begin
      dSumXY := dSumXY + ( i - 1 ) * aPriceArray[i] ;
    end ;

    dSumY := 0;
    for i := 1 to iSize do
      dSumY := dSumY + aPriceArray[i];

    oLRSlope := ( iSize * dSumXY - dSumX * dSumY) / dDivisor ;
    oLRAngle := ArcTan( oLRSlope ) ;
    oLRIntercept := ( dSumY - oLRSlope * dSumX ) / iSize ;
    oLRValueRaw := oLRIntercept + oLRSlope * ( iSize - 1 - TgtPos ) ;
    Result := 1 ;
  end else
  	Result := -1 ;

end;


{ TCombinationCalculator }

procedure TCombinationCalculator.CalcCombination(n, r, index, target: Byte);
var
  i : Integer;
  aThread : TCombinationCalculateThread;
begin
  if (r = 0) then
  begin
    //
    if Assigned(FOnCombinationSelected) then
      FOnCombinationSelected(FIntArray);
    //
  end else
  if (target = n) then Exit
  else
  begin
    FIntArray[index] := target;

    if FLiveThreadCount < FThreadCount then
    begin
      Inc(FLiveThreadCount);
      aThread := FCalcThreadClass.CreateThread;
      aThread.Priority := tpNormal;
      aThread.ParentCalculator := Self;
      aThread.OnTerminate := ThreadComplete;
      aThread.FN := n;
      aThread.FR := r-1;
      aThread.FIndex := index+1;
      aThread.FTarget := target + 1;

      //copy values
      SetLength(aThread.FIntArray, Length(FIntArray));
      for i := 0 to Length(FIntArray)-1 do
        aThread.FIntArray[i] := FIntArray[i];

      FCalculateThreadList.Add(aThread);
      Inc(FCurrentThreadCount);
      aThread.Resume;
    end else                                                          //5, 3 -> 5, 2
      CalcCombination(n , r - 1, index + 1, target + 1);

    //
     if FLiveThreadCount < FThreadCount then
    begin
      Inc(FLiveThreadCount);
      aThread := FCalcThreadClass.CreateThread;
      aThread.Priority := tpNormal;
      aThread.ParentCalculator := Self;
      aThread.OnTerminate := ThreadComplete;
      aThread.FN := n;
      aThread.FR := r;
      aThread.FIndex := index;
      aThread.FTarget := target + 1;

      //copy values
      SetLength(aThread.FIntArray, Length(FIntArray));
      for i := 0 to Length(FIntArray)-1 do
        aThread.FIntArray[i] := FIntArray[i];

      FCalculateThreadList.Add(aThread);
      Inc(FCurrentThreadCount);
      aThread.Resume;
    end else                                               //5, 3
      CalcCombination(n, r, index, target + 1);


  end;

end;

constructor TCombinationCalculator.Create;
begin
  FThreadCount := 1;
  FCurrentThreadCount := 0;
  FLiveThreadCount := 0;

  FCalculateThreadList := TList.Create;
  FCalcThreadClass := TCombinationCalculateThread;

end;

destructor TCombinationCalculator.Destroy;
begin
  FCalculateThreadList.Free;

  inherited;
end;

{
procedure TCombinationCalculator.SetThreadCount(const Value: Integer);
begin
  FThreadCount := Value;
end;
}
procedure TCombinationCalculator.StartCombination(n, r, index,
  target: Byte);
begin
  //
  Fn := n;
  Fr := r;
  FIndex := index;
  FTarget := target;
  //
  SetLength(FIntArray, r);
  CalcCombination(n, r);

end;

procedure TCombinationCalculator.ThreadComplete(Sender: TObject);
begin
  //
  Dec(FLiveThreadCount);
  //

  if Assigned(FOnThreadTerminated) then
    FOnThreadTerminated(Sender);
  //
  FCalculateThreadList.Remove(Sender);
  //
  if FCalculateThreadList.Count = 0 then
    if Assigned(FOnCompleted) then  FOnCompleted(Self);

  {
  bAllComplete := False;
  for i := 0 to FCalculateThreadList.Count-1 do
  begin
    aThread := TCombinationCalculateThread(FCalculateThreadList.Items[i]);
    //
    if not aThread.FComplete then Exit;
    //
    if i = 0 then
      bAllComplete := aThread.FComplete
    else
      bAllComplete := bAllComplete and aThread.FComplete;
  end;
  //
  if bAllComplete and Assigned(FOnCompleted) then FOnCompleted(Self);
  }
end;

{ TCombinationCalculateThread }

constructor TCombinationCalculateThread.CreateThread;
begin
  inherited Create(True);
  //FreeOnTerminate := False;
end;

destructor TCombinationCalculateThread.Destroy;
begin
  FIntArray := nil;
  inherited;
end;

procedure TCombinationCalculateThread.Execute;
begin
  FComplete := False;

  ThreadCombination(FN, FR, FIndex, FTarget);

  FComplete := True;
end;

{
procedure TCombinationCalculateThread.SetR(const Value: Integer);
begin
  FR := Value;
  SetLength(FIntArray, FR);
end;
}
procedure TCombinationCalculateThread.ThreadCombination(const n, r, index,
  target: Byte);
var
  i : Integer;
  aThread : TCombinationCalculateThread;
begin
  if (r = 0) then
  begin
    //
    if Assigned(ParentCalculator.FOnCombinationSelected) then
      ParentCalculator.FOnCombinationSelected(FIntArray);
    //
  end else
  if (target = n) then Exit
  else
  begin
    FIntArray[index] := target;
                                           //5, 3 -> 5, 2

    if ParentCalculator.FLiveThreadCount < ParentCalculator.FThreadCount then
    begin
      Inc(ParentCalculator.FLiveThreadCount);
      aThread := ParentCalculator.FCalcThreadClass.CreateThread;
      aThread.Priority := tpNormal;
      aThread.ParentCalculator := ParentCalculator;
      aThread.OnTerminate := ParentCalculator.ThreadComplete;
      aThread.FN := n;
      aThread.FR := r-1;
      aThread.FIndex := index+1;
      aThread.FTarget := target + 1;

      //copy values
      SetLength(aThread.FIntArray, Length(FIntArray));
      for i := 0 to Length(FIntArray)-1 do
        aThread.FIntArray[i] := FIntArray[i];

      ParentCalculator.FCalculateThreadList.Add(aThread);
      ParentCalculator.FCurrentThreadCount := ParentCalculator.FCurrentThreadCount+1;
      aThread.Resume;
    end else
      ThreadCombination(n , r - 1, index + 1, target + 1);



    if ParentCalculator.FLiveThreadCount < ParentCalculator.FThreadCount then
    begin
      ParentCalculator.FLiveThreadCount := ParentCalculator.FLiveThreadCount + 1;
      aThread := ParentCalculator.FCalcThreadClass.CreateThread;
      aThread.Priority := tpNormal;
      aThread.ParentCalculator := ParentCalculator;
      aThread.OnTerminate := ParentCalculator.ThreadComplete;
      aThread.FN := n;
      aThread.FR := r;
      aThread.FIndex := index;
      aThread.FTarget := target + 1;

      //copy values
      SetLength(aThread.FIntArray, Length(FIntArray));
      for i := 0 to Length(FIntArray)-1 do
        aThread.FIntArray[i] := FIntArray[i];

      ParentCalculator.FCalculateThreadList.Add(aThread);
      Inc(ParentCalculator.FCurrentThreadCount);
      aThread.Resume;
    end else
      ThreadCombination(n, r, index, target + 1);
  end;

end;

end.

(*
function calculateSlope(yValues, xValues: array of double; var interceptValue, rValue: double):double;
 var
   i, c : integer;
   ySum, xSum, xySum, yySum, xxSum, yAve, xAve: double;
 begin
   ySum  := 0;
   xSum  := 0;
   xySum := 0;
   xxSum := 0;
   yySum := 0;
   c := length(yValues);
   if c <> length(xValues) then
   begin
     interceptValue := -1;
     Result := -1;
     Exit;
   end;
   for i := 0 to c -1 do
   begin
     ySum := ySum + yValues[i];
     xxSum := xxSum + xValues[i]*xValues[i];
     yySum := yySum + yValues[i]*yValues[i];
     xSum := xSum + xValues[i];
     xySum := xySum + (yValues[i]*xValues[i]);  end;
   yAve := ySum / c;
   xAve := xSum / c;
   Result         := (xySum - (xSum * yAve)) / (xxSum - (xSum*xAve));
   interceptValue := yAve - (Result * xAve);
   try
     rValue         := (c*xySum - xSum*ySum )
                        /
                       sqrt(
                       (c * xxSum - xSum*xSum)
                        *
                       (c * yySum - ySum*ySum)
                       );
   except on E: Exception do
   end;
 end;
*)
