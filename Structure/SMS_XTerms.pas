unit SMS_XTerms;

interface

uses
  SysUtils, Classes,

  SMS_DateTimeDS;

type
  TSXTerms = class
  private
    FOnAddBefore: TNotifyEvent;
    //FQuotePlate : TQuotePlate;

    FDataList : TCDataList2;
    //FLastDefineTime : TDateTime;


    FOnBeforeInstrumentChange: TNotifyEvent;
    FOnAfterInstrumentChange: TNotifyEvent;
    //FConfig: TXTermsDataProperties;
    //FTempConfig: TXTermsConfig;
    {
    function GetData(i: Integer): PCDataItem;
    function GetDataCount: Integer;
    function GetDesc: String;
    }
  protected

    // source data
    FTicks : TCollection;

    // status flags
    FReady : Boolean;
    FLastChangedOnUpdate : Boolean;

    // events
    FOnAdd : TNotifyEvent;
    FOnUpdate : TNotifyEvent;
    FOnRefresh : TNotifyEvent;

    FRefMMIndex : Integer;
    FLastMMIndex : Integer;

    // data handlers
    //procedure NewRealTick(aTick : TTickRec); overload; // quote tick
    //procedure NewRealTick(aTick : TTickRec; aTerm: TTermRec); overload; // quote tick

    // event handlers
    //procedure TickProc(Sender, Receiver : TObject; DataObj : TObject;
    //               iBroadcastKind : Integer; btValue : TBroadcastType);
    //procedure CDataInserted(const Sender: TObject;const bLast: Boolean;
    //  const aTermItem: TTermRec);

  public

    LongValue : Integer;     //user define value
    ProcLongValue : Integer; // 로컬 함수에서는 임시적으로 사용하는 변수..

    constructor Create;
    {
    constructor CreateSmall;

    destructor Destroy; override;
    }
    //
    //procedure CopyFrom(aData: TXTerms);
    //procedure DataSizeNotifed(iSize: Integer);

    // define
    //procedure Undefine;
    //성공 : true
    //실패 : false
    //function Define(aRequestConfig : TXTermsConfig; aSource: TXTerms = nil): Boolean; overload;


    //
    {
    procedure GetMinMax(iStart, iEnd : Integer; var dMin, dMax : Double);
    function DateTimeDesc(iIndex : Integer) : String;
    }
    //
    //procedure SetPersistent(aElement: IXMLDOMElement);
    //procedure GetPersistent(aElement: IXMLDOMElement);
    {
    function FindData(const aDateMin: TDateMin; const cbBase : TChartBase):PCDataItem; overload;
    function FindData(const aDateMin: TDateMin; const cbBase : TChartBase; out iP: Integer):PCDataItem; overload;
    function FindData2(const aDateMin: TDateMin;
      const iP: Integer; const cbBase: TChartBase): Integer;
    }
    (*
    FindData3,4 차이점.
     - 못찾는 경우 v4는 0을 리턴
     - 찾는 경우 찾은 위치 다음 index 를 리턴.. 단. 리턴되는 값은 count 넘어서지 않는다.
    *)

    {
    function FindData3(const aDateMin: TDateMin; const  iSecond: Integer;
      const iP: Integer; const cbBase: TChartBase): Integer;
    function FindData4(const aDateMin: TDateMin; const  iSecond: Integer;
      const iP: Integer; const cbBase: TChartBase): Integer;
    }
    {
    procedure SaveToFile(stFileName : String; bAppend: Boolean = True);

    // attributes
    property Instrument : TInstrumentItem read FConfig.Instrument;

    property Config: TXTermsConfig read FConfig;
    property TempConfig : TXTermsConfig read FTempConfig write FTempConfig;

    property QuotePlate : TQuotePlate read FQuotePlate;
    property Desc : String read GetDesc;

    // events
    property OnAdd : TNotifyEvent read FOnAdd write FOnAdd;
    property OnAddBefore : TNotifyEvent read FOnAddBefore write FOnAddBefore;
    property OnUpdate : TNotifyEvent read FOnUpdate write FOnUpdate;
    property OnRefresh : TNotifyEvent read FOnRefresh write FOnRefresh;
    //
    property Ready : Boolean read FReady;
    property LastChangedOnUpdate : Boolean read FLastChangedOnUpdate;
    //
    property Data[i:Integer]: PCDataItem read GetData; default;
    property DataCount : Integer read GetDataCount;
    property DataList : TCDataList2 read FDataList;

    property OnBeforeInstrumentChange : TNotifyEvent read FOnBeforeInstrumentChange write FOnBeforeInstrumentChange;
    property OnAfterInstrumentChange : TNotifyEvent read FOnAfterInstrumentChange write FOnAfterInstrumentChange;
    }
  end;

implementation

{ TSXTerms }

constructor TSXTerms.Create;
begin

end;

end.







uses Classes, SysUtils, Math, Windows,
     //

     AppTypes, SMS_Broadcaster,
     HDataBank, ChartTypes,

     SMS_XMLs, MSXML_TLB,
     MarketIF, ChartIF, ChartIFTypes,
     MarketManager,

     SMS_DateTimes, SMS_Systems, SMS_DateTimeDS,
     SMS_DS;

type
  TXTermMode = (xmTick, xmTerm); // obsolete

  TTickItem = class(TCollectionItem)
  public
    TickInfo : TTickRec;
{$IFDEF QUOTEX}
    Term : TTermRec;
{$ENDIF}
  end;
  //
  {
  TSmallCDataList = class(TCDataList)
  private
    FList : PSmallCDataItemList;
  public
    destructor Destroy; override;
  end;
  }

  ECDataListCapacityError = class(Exception);

  TXTermsConfig = record
    Instrument : TInstrumentItem; //
    MarketIF : TMarketIF;         //
    ChartIF : TChartIF;          //

    DataType : TChartDataType;   //
    Period : Integer;           //
    Base : TChartBase;          //
    ReqCount : Integer;         //
    UseReqRange: Boolean;       //
    ReqRefDate : Integer;       //     0 보다 작으면 Local Date
    ReqCode : String;           //

    IsFull : Boolean;           //
    MandatoryRefresh : Boolean;
    //
    RealTimeOffset : Integer;     //
    HourOffset : Integer;  //
  end;

  TXTermsDataProperties = TXTermsConfig;

  TXTerms = class
  private
    FOnAddBefore: TNotifyEvent;
    FQuotePlate : TQuotePlate;

    FDataList : TCDataList2;
    FLastDefineTime : TDateTime;
    //FDataList : TCDataList;

    FOnBeforeInstrumentChange: TNotifyEvent;
    FOnAfterInstrumentChange: TNotifyEvent;
    FConfig: TXTermsDataProperties;
    FTempConfig: TXTermsConfig;
    function GetData(i: Integer): PCDataItem;
    function GetDataCount: Integer;
    function GetDesc: String;
  protected

    // source data
    FTicks : TCollection;

    // status flags
    FReady : Boolean;
    FLastChangedOnUpdate : Boolean;

    // events
    FOnAdd : TNotifyEvent;
    FOnUpdate : TNotifyEvent;
    FOnRefresh : TNotifyEvent;

    FRefMMIndex : Integer;
    FLastMMIndex : Integer;

    // data handlers
    procedure NewRealTick(aTick : TTickRec); overload; // quote tick
    procedure NewRealTick(aTick : TTickRec; aTerm: TTermRec); overload; // quote tick

    // event handlers
    procedure TickProc(Sender, Receiver : TObject; DataObj : TObject;
                   iBroadcastKind : Integer; btValue : TBroadcastType);
    procedure CDataInserted(const Sender: TObject;const bLast: Boolean;
      const aTermItem: TTermRec);

  public

    LongValue : Integer;     //user define value
    ProcLongValue : Integer; // 로컬 함수에서는 임시적으로 사용하는 변수..

    constructor Create;
    constructor CreateSmall;

    destructor Destroy; override;
    //
    procedure CopyFrom(aData: TXTerms);
    procedure DataSizeNotifed(iSize: Integer);

    // define
    procedure Undefine;
    //성공 : true
    //실패 : false
    function Define(aRequestConfig : TXTermsConfig; aSource: TXTerms = nil): Boolean; overload;


    //
    procedure GetMinMax(iStart, iEnd : Integer; var dMin, dMax : Double);
    function DateTimeDesc(iIndex : Integer) : String;
    //
    procedure SetPersistent(aElement: IXMLDOMElement);
    procedure GetPersistent(aElement: IXMLDOMElement);

    function FindData(const aDateMin: TDateMin; const cbBase : TChartBase):PCDataItem; overload;
    function FindData(const aDateMin: TDateMin; const cbBase : TChartBase; out iP: Integer):PCDataItem; overload;
    function FindData2(const aDateMin: TDateMin;
      const iP: Integer; const cbBase: TChartBase): Integer;

    (*
    FindData3,4 차이점.
     - 못찾는 경우 v4는 0을 리턴
     - 찾는 경우 찾은 위치 다음 index 를 리턴.. 단. 리턴되는 값은 count 넘어서지 않는다.
    *)

    function FindData3(const aDateMin: TDateMin; const  iSecond: Integer;
      const iP: Integer; const cbBase: TChartBase): Integer;
    function FindData4(const aDateMin: TDateMin; const  iSecond: Integer;
      const iP: Integer; const cbBase: TChartBase): Integer;

    procedure SaveToFile(stFileName : String; bAppend: Boolean = True);

    // attributes
    property Instrument : TInstrumentItem read FConfig.Instrument;

    property Config: TXTermsConfig read FConfig;
    property TempConfig : TXTermsConfig read FTempConfig write FTempConfig;

    property QuotePlate : TQuotePlate read FQuotePlate;
    property Desc : String read GetDesc;

    // events
    property OnAdd : TNotifyEvent read FOnAdd write FOnAdd;
    property OnAddBefore : TNotifyEvent read FOnAddBefore write FOnAddBefore;
    property OnUpdate : TNotifyEvent read FOnUpdate write FOnUpdate;
    property OnRefresh : TNotifyEvent read FOnRefresh write FOnRefresh;
    //
    property Ready : Boolean read FReady;
    property LastChangedOnUpdate : Boolean read FLastChangedOnUpdate;
    //
    property Data[i:Integer]: PCDataItem read GetData; default;
    property DataCount : Integer read GetDataCount;
    property DataList : TCDataList2 read FDataList;

    property OnBeforeInstrumentChange : TNotifyEvent read FOnBeforeInstrumentChange write FOnBeforeInstrumentChange;
    property OnAfterInstrumentChange : TNotifyEvent read FOnAfterInstrumentChange write FOnAfterInstrumentChange;

  end;

  {
  TSmallXTerms = class(TXTerms)
  protected
    FDataList : TSmallCDataList;
  end;
  }
  TXTermsList = class
  private
    FList : TList;
    function GetCount: Integer;
    function GetItem(i: Integer): TXTerms;
    function GetAllReady: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function Add : TXTerms;
    function Remove(aData: TXTerms): Boolean;
    procedure Clear;

    property Items[i:Integer]: TXTerms read GetItem; default;
    property Count: Integer read GetCount;

    property AllReady : Boolean read GetAllReady;
    property List : TList read FList;
  end;

  TSmallXTermsList = class(TXTermsList)

  end;

  procedure InitXTermsConfig(var aConfig: TXTermsConfig);


implementation

uses
  AppConsts, LogManager, Utils, DateUtils, SMS_Maths, Globals;

const
  DEF_REQ_COUNT = 1000;



procedure InitXTermsConfig(var aConfig: TXTermsConfig);
begin
  with aConfig do
  begin
    Instrument := nil;
    MarketIF := nil;
    ChartIF := nil;

    DataType := hdTrades;
    Period := 1;
    Base := cbMin;
    ReqCount := DEF_REQ_COUNT;
    UseReqRange := False;
    if Time >= 15/24 then
      ReqRefDate := Floor(Now)+1
    else
      ReqRefDate := Floor(Now);
    ReqCode := '1M';

    IsFull := False;
    MandatoryRefresh := False;

    RealTimeOffset := 0;
    HourOffset := 0;
  end;
end;


//=================================================================//
                           { TXTerms }
//=================================================================//

//---------------------------------------------------------//
//                    Create / Destroy                     //
//---------------------------------------------------------//

constructor TXTerms.Create;
begin
  FDataList := TCDataList2.Create;
  FTicks := TCollection.Create(TTickItem);
  //initialization fields
  InitXTermsConfig(FConfig);
  InitXTermsConfig(FTempConfig);

  //
  FReady := False;

end;

destructor TXTerms.Destroy;
const
  PROC_TITLE = 'Destroy';
var
  stInstrument : String;
  //dTime : TDateTime;
begin
  //
  gHDataBank.CancelRequest(Self);
  //
  if Instrument <> nil then
    Instrument.Unsubscribe(FConfig.MarketIF, Self);
  //
  FTicks.Free;

  gHDataBank.ReleaseRecycle(Self);

  //dTime := Now;
  FDataList.Free;
  {
  gLog.AddNoMessage(lkDebug, ClassName, PROC_TITLE,
    Format('data list release time:%s', [FormatDateTime('hh:nn:ss', Now-dTime)]));
  }
  if Instrument = nil then
    stInstrument := 'empty'
  else
    stInstrument := Instrument.Symbol;

  {
  gLog.AddNoMessage(lkDebug, ClassName, PROC_TITLE,
    stInstrument + '--' + GetMemoryShortStatus);
  }
  inherited;
end;

procedure TXTerms.Undefine;
begin
  //-- unsubscribe quote
  if (Instrument <> nil) and (FConfig.MarketIF <> nil) then
  begin
    Instrument.Unsubscribe(FConfig.MarketIF, Self);
    FConfig.Instrument := nil;
    FQuotePlate := nil;
  end;

  FTicks.Clear;

  //gHDataBank.CancelRequest(FConfig.ChartIF, Self);
  gHDataBank.CancelRequest(Self);

  FDataList.Clear;

  //
  FReady := False;
end;

//---------------------------------------------------------//
//                    Data Arrived                         //
//---------------------------------------------------------//

// New tick data
// real time tick data
procedure TXTerms.TickProc(Sender, Receiver, DataObj: TObject;
  iBroadcastKind: Integer; btValue: TBroadcastType);
const
  PROC_TITLE = 'TickProc';
var
  aInstrument : TInstrumentItem;
begin
  aInstrument := DataObj as TInstrumentItem;
  //
  if FQuotePlate = nil then Exit;
  //
  if (FConfig.Instrument <> nil) and
     (FConfig.Instrument = aInstrument) and
     (iBroadcastKind = PID_TICK) and
     (btValue = btNew) then
  begin
    if FReady then
{$IFDEF DEBUG}
    begin
      try
        NewRealTick(FQuotePlate.LastTick) // last tick
      except on E: Exception do
        gLog.Add(lkDebug, ClassName, PROC_TITLE, E.Message)
      end;
    end
{$ELSE}
      NewRealTick(FQuotePlate.LastTick) // last tick
{$ENDIF}
    else
    begin
      if FQuotePlate.LastTick.IsReceivePrice then
      begin
        //
        with FTicks.Add as TTickitem, FQuotePlate do
        begin
          TickInfo := LastTick;
{$IFDEF QUOTEX}
          Term.BidPrice := BidQuotes[1].Price;
          Term.BidQty := BidQuotes[1].Qty;
          //
          Term.AskPrice := AskQuotes[1].Price;
          Term.AskQty := AskQuotes[1].Qty;
{$ENDIF}
        end;
      end;
    end;
  end;
end;

//---------------------------------------------------------//
//                    Data Manipulation                    //
//---------------------------------------------------------//



//
//  New Tick
//

procedure TXTerms.NewRealTick(aTick : TTickRec);
const
  PROC_TITLE = 'NewRealTick';
var
  bBeforeRef : Boolean;
  aTickDateMin, aTickLastDateMin : TDateMin;
  wYY1, wOO1, wDD1, wYY2, wOO2, wDD2 : Word;
  aTime : TDateTime;
  iDayOfWeek : Integer;
  bNew : Boolean;
  dPrice : Double;
  wHour, wMin, wSec, wMSec : Word;
{$IFDEF DEBUG}
//  aRecordTime : TDateTime;
{$ENDIF}

  pDataItem : PCDataItem;
  dRange : Double;
begin
  //-- get last item

  if FDataList.Count = 0 then
    pDataItem := nil
  else
    pDataItem := @(FDataList.List[FDataList.Count-1]);

  // -- check cutting range
  if (Instrument.Commodity.ContractType <> ctOption) and
     (pDataItem <> nil) and gFutureRangeCutting then
  begin
    dRange := Abs(pDataItem^.C) * gFutureCuttingRange;
    //
    if ((aTick.Price > pDataItem^.C + dRange) or
        (aTick.Price < pDataItem^.C - dRange)) then
    begin
      gLog.Add(lkWarning, ClassName, PROC_TITLE,
        Format('%s cut out of data>> price:%f/last:%f',
          [Instrument.Symbol, aTick.Price, pDataItem^.C]));
      Exit;
    end;
    //
    if ((aTick.Low > pDataItem^.C + dRange) or
        (aTick.Low < pDataItem^.C - dRange)) then
    begin
      gLog.Add(lkWarning, ClassName, PROC_TITLE,
        Format('%s low price cut out of data>> price:%f/last:%f',
          [Instrument.Symbol, aTick.Low, pDataItem^.C]));
      //Exit;
    end;
  end;

  //
  if (FConfig.Base = cbMin) then
  begin
    if (FConfig.RealTimeOffset <> 0) then
      aTick.Time := IncSecond(aTick.Time, FConfig.RealTimeOffset * -1);
    if (FConfig.HourOffset <> 0) then
      aTick.Time := IncHour(aTick.Time, FConfig.HourOffset * -1);
  end;// else

  aTime := aTick.Time;
  aTickDateMin := EncodeToDateMin(aTime);
  aTickLastDateMin := IncDateMin(aTickDateMin, 1);
  //
  dPrice := aTick.Price;
  //

  //
  //-- check new or update
  if pDataItem = nil then
    bNew := True
  else
  case FConfig.Base of
    cbTick :
      bNew := (pDataItem.Count >= FConfig.Period);

    cbMin :
      bNew := CompareDateMin(pDataItem^.LastDateMin, aTickLastDateMin)<0;

    //
    cbDaily : bNew := (pDataItem^.LastDateMin.Date <> Floor(aTime));{ and // new day
                      (pDataItem^.Count >= FConfig.Period);}
              // 현재 1일 봉 외 지원안함
    //
    cbWeekly :
      begin
        iDayOfWeek := DayOfWeek(pDataItem^.LastDateMin.Date);
        bNew := (pDataItem^.LastDateMin.Date+(7-iDayOfWeek) < Floor(aTime)) and // new week
                (pDataItem^.Count >= FConfig.Period);
      end;
    //
    cbMonthly :
      begin
        DecodeDate(aTime, wYY1, wOO1, wDD1);
        DecodeDate(pDataItem^.LastDateMin.Date, wYY2, wOO2, wDD2);
        bNew := ((wYY1 <> wYY2) or (wOO1 <> wOO2)) and // new month
                 (pDataItem^.Count >= FConfig.Period);
      end;
    else
      Exit;

  end;

  // add up
  if bNew then
  begin
    if Assigned(FOnAddBefore) then
      FOnAddBefore(Self);
    //
    pDataItem := FDataList.Add;
    //
    if FConfig.Base = cbMin then
    begin
      //
      if FRefMMIndex = aTickLastDateMin.MMI then
        pDataItem.LastDateMin := aTickLastDateMin
      else
      begin
        pDataItem.LastDateMin.Date := aTickDateMin.Date;
        bBeforeRef := False;
        if FRefMMIndex > aTickDateMin.MMI then
        begin
          Dec(pDataItem.LastDateMin.Date);
          pDataItem.LastDateMin.MMI :=
            FRefMMIndex + ((aTickDateMin.MMI + MININUTES_INADAY - FRefMMIndex) div FConfig.Period + 1)*FConfig.Period;
          bBeforeRef := True;
        end else
          pDataItem.LastDateMin.MMI :=
            FRefMMIndex + ((aTickDateMin.MMI - FRefMMIndex) div FConfig.Period + 1)*FConfig.Period;
        //
        if pDataItem.LastDateMin.MMI >= MININUTES_INADAY then
        begin
          Inc(pDataItem.LastDateMin.Date);
          pDataItem.LastDateMin.MMI := pDataItem^.LastDateMin.MMI mod MININUTES_INADAY;
        end;
        //
        if bBeforeRef then
          pDataItem.LastDateMin.MMI := Min(FRefMMIndex, pDataItem.LastDateMin.MMI);

      end;

    end else
    if FConfig.Base = cbTick then
    begin
      pDataItem.LastDateMin := aTickDateMin;//.Date := Floor(aTime);
      DecodeTime(aTick.Time, wHour, wMin, wSec, wMSec);
      pDataItem.LastSecond := wSec;
//{$IFDEF BUG}
      //if (aTickDateMin.MMI = 540) and (wSec = 0) then
      //  gLog.Add(lkDebug, ClassName, PROC_TITLE, Format('%s 09:00:00 new tick received, %d', [Instrument.Symbol, aTick.Size]));
//{$ENDIF}

    end else
    begin //daily...monthly
      //pDataItem^.LastDateMin.Date := Floor(aTime);

      //daily...monthly 는 lasttime 잘 두해야 한다. (todo:}
      pDataItem.LastDateMin.MMI := FLastMMIndex;{FRefMMIndex;}
      pDataItem.LastDateMin.Date := Floor(aTime);

    end;
    //
    with pDataItem^ do
    begin
      Count := 1;
      O := dPrice;
      //
      //중국 tick - day high,low system 때문에
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.High ,FQuotePlate.PrevLastTick.High,
            Instrument.Commodity.PriceEpsilon)>0) then
        H := aTick.High
      else
        H := dPrice;
      //
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.Low, FQuotePlate.PrevLastTick.Low,
            Instrument.Commodity.PriceEpsilon)<0) then
        L := aTick.Low
      else
        L := dPrice;

      //
      C := dPrice;
      //
{$IFDEF QUOTEX}
      with FQuotePlate do
      begin
        Term.BidPrice := BidQuotes[1].Price;
        Term.AskPrice := AskQuotes[1].Price;
        Term.BidQty := BidQuotes[1].Qty;
        Term.AskQty := AskQuotes[1].Qty;
      end;
{$ENDIF}

      if FConfig.DataType = hdBid then
        FillVol := aTick.AccBidVolume
      else if FConfig.DataType = hdAsk then
        FillVol := aTick.AccAskVolume
      else
        FillVol := aTick.Size;
      //
      OpenInt := aTick.OpenInt;
    end;
    //

//    gLog.Add(lkDebug, classname, 'refreshed',
//      formatdatetime('last:hhnn', DateMinToDateTime((Items[Count-1] as TXTermItem).LastDateMin)));
{$IFDEF DEBUG}
//    aRecordTime := Now;
{$ENDIF}

    if FReady and Assigned(FOnAdd) then
      FOnAdd(Self);

//    gLog.Add(lkDebug, ClassName, 'Add', FormatDateTime('ss.zzz', Now-aRecordTime));
  end else
  begin
    //update case

    with pDataItem^ do
    begin
      //중국 tick - day high,low system 때문에
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.High ,FQuotePlate.PrevLastTick.High,
              Instrument.Commodity.PriceEpsilon)>0) then
          H := Max(H, aTick.High)
      else
          H := Max(H, dPrice);
        //
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.Low ,FQuotePlate.PrevLastTick.Low,
              Instrument.Commodity.PriceEpsilon)<0) then
          L := Min(L, aTick.Low)
      else
          L := Min(L, dPrice);
      //
    end;
    //

    FLastChangedOnUpdate :=
        not(CompareValue(pDataItem^.C - dPrice, Instrument.Commodity.PriceEpsilon)=0);
    //
    with pDataItem^ do
    begin
      C := dPrice;
      if FConfig.DataType = hdAsk then
        FillVol := aTick.AccAskVolume
      else if FConfig.DataType = hdBid then
        FillVol := aTick.AccBidVolume
      else
        FillVol := FillVol + aTick.Size;
      OpenInt := aTick.OpenInt;
      Inc(Count);
    end;
    //
    if FReady and Assigned(FOnUpdate) then
      FOnUpdate(Self);
  end;
end;

//---------------------------------------------------------//
//                    Misc                                 //
//---------------------------------------------------------//

procedure TXTerms.GetMinMax(iStart, iEnd : Integer; var dMin, dMax : Double);
var
  //i : Integer;
  bInit : Boolean;
  dMn, dMx : Double;
  //pStart, pEnd : PCDataItem;
  i : Integer;
begin
  dMn := 0.0;
  dMx := 0.0;
  //
  {###
  if iStart > FDataList.FList.Count-1 then
    pStart := FDataList.FList[FDataList.FList.Count-1]
  else
    pStart := FDataList.FList[iStart];
  }
  { ###
  if iStart > FDataList.Count-1 then
    pStart := @(FDataList.List[FDataList.Count-1])
  else
    pStart := @(FDataList.List[iStart]);
  }
  {###
  if iEnd > FDataList.FList.Count-1 then
    pEnd := FDataList.FList[FDataList.FList.Count-1]
  else
    pEnd := FDataList.FList[iEnd];
  }
  {###
  if iEnd > FDataList.Count-1 then
    pEnd := @FDataList.List[FDataList.Count-1]
  else
    pEnd := @FDataList.List[iEnd];
  }

  //
  bInit := False;

  //
  for i := iStart to iEnd do
  begin
    with FDataList.List^[i] do
    begin

      if bInit then
      begin
        dMn := Min(dMn, L);
        dMx := Max(dMx, H);
      end else
      begin
        dMn := L;
        dMx := H;
        bInit := True;
      end;
    end;

  end;
  (*###
  while (pStart <> nil) and (pStart <> pEnd.Before) do
//  for i:=iStart to iEnd do
  begin
    //if i > Count-1 then break;

    //with Items[i] as TXTermItem do
    with pStart^ do
    begin
//      if not Valid then Continue;
      if bInit then
      begin
        dMn := Min(dMn, L);
        dMx := Max(dMx, H);
      end else
      begin
        dMn := L;
        dMx := H;
      end;
    end;

    pStart := pStart^.Next;
  end;
  //
  *)
  dMin := dMn;
  dMax := dMx;
end;

function TXTerms.DateTimeDesc(iIndex : Integer) : String;
begin
  Result := '';
end;

//---------------------------------------------------------//
//                    Property Methods                     //
//---------------------------------------------------------//


(*
function TXTerms.GetXTerm(i : Integer) : TXTermItem;
begin
  if (i>=0) and (i<Count) then
    Result := Items[i] as TXTermItem
  else
    Result := nil;
end;
*)


function TXTerms.FindData(const aDateMin: TDateMin;
  const cbBase: TChartBase): PCDataItem;
var
  i : Integer;
  pData : PCDataItem;
begin

  Result := nil;
  //
  for i := 0 to FDataList.Count-1 do
  begin
    pData := @FDataList.List[i];

    with pData^ do
    case cbBase of
      cbTick :;
      cbMin :
        if CompareDateMin(LastDateMin, aDateMin)=0 then
        begin
          Result := pData;
          break;
        end;
      cbDaily, cbWeekly, cbMonthly :
        if LastDateMin.Date = aDateMin.Date then
        begin
          Result := pData;
          break;
        end;
    end;
  end;
end;

function TXTerms.Define(aRequestConfig : TXTermsConfig; aSource: TXTerms): Boolean;
const
  PROC_TITLE = 'Define';
var
  aRequestInfo : TChartRequestInfo;
  bUnsubscribed : Boolean;
  aHReqItem : THDataRequestItem;
  bChangeInstrument : Boolean;
begin
  Result := False;
  //
  if aRequestConfig.Instrument = nil then Exit;   //--> fail

  // ignore same condition
  with aRequestConfig do
  if not MandatoryRefresh then
  begin
    if (FConfig.Instrument = Instrument) and
       (FConfig.ChartIF = ChartIF) and
       (FConfig.MarketIF = MarketIF) and
       (FConfig.DataType = DataType) and
       (FConfig.Period = Period) and (FConfig.Base = Base) and
       //(FConfig.ReqCount = ReqCount) and
       //(FConfig.ReqRefDate = ReqRefDate) and
       (FConfig.RealTimeOffset = RealTimeOffset) and
       (FConfig.HourOffset = HourOffset) and
       (FConfig.UseReqRange = UseReqRange) and
        Boolean(IfThen(UseReqRange,
            Ord(FConfig.ReqRefDate = ReqRefDate),
            Ord(FConfig.ReqCount = ReqCount))) and
       (FConfig.DataType = DataType) and

       (CompareText(FConfig.ReqCode, ReqCode)=0) then Exit;   //--> fail (last exit)
  end;
  //
  FLastDefineTime := Now;

  bChangeInstrument := FConfig.Instrument <> aRequestConfig.Instrument;
  // change instrument or market vendor..
  if (bChangeInstrument) or
      (FConfig.MarketIF <> aRequestConfig.MarketIF) then
  begin

    //
    if (bChangeInstrument) and Assigned(FOnBeforeInstrumentChange) then
      FOnBeforeInstrumentChange(Self);

    // unsubscribe ...
    if FConfig.Instrument <> nil then
      FConfig.Instrument.Unsubscribe(FConfig.MarketIF, Self);

    //
    FConfig.Instrument := aRequestConfig.Instrument;
    FConfig.MarketIF := aRequestConfig.MarketIF;

    //set reference MMIndex
    if FConfig.Instrument.Commodity.SessionCount > 0 then
    begin
      FRefMMIndex := FConfig.Instrument.Commodity.Sessions[0].StartTimeIndex;
      FLastMMIndex := FConfig.Instrument.Commodity.Sessions[0].EndTimeIndex;
    end;

    //... code - suppose that a instrument have one session per day
    //         - must change code when use instruments that have multi-seesion per day

    if (bChangeInstrument) and Assigned(FOnAfterInstrumentChange) then
      FOnAfterInstrumentChange(Self);
    //
    bUnsubscribed := True;
  end else
    bUnsubscribed := False;
  //
  FConfig.ChartIF := aRequestConfig.ChartIF;

  //
  FTicks.Clear;


  FDataList.Clear;

  if aSource <> nil then
    CopyFrom(aSource);

  //
  FReady := False;
  //FCDataPointer := 0;
  //
  if Assigned(FOnRefresh) then
    FOnRefresh(Self);
  //
  aRequestInfo.Contract := aRequestConfig.Instrument;
  aRequestInfo.ReqCount := aRequestConfig.ReqCount;        //요청기간1


  //aRequestInfo.RefTime := Now;                   //기준일

  aRequestInfo.Period := aRequestConfig.Period;
  aRequestInfo.ChartBase := aRequestConfig.Base;

  FConfig := aRequestConfig;

  aRequestInfo.DataType := aRequestConfig.DataType;
  aRequestInfo.UseReqCode := aRequestConfig.UseReqRange;

  aRequestInfo.Receiver := Self;

  aRequestInfo.MandatoryRefresh := aRequestConfig.MandatoryRefresh;
  aRequestInfo.ReqCode := aRequestConfig.ReqCode;
  aRequestInfo.RefDate := aRequestConfig.ReqRefDate;
  aRequestInfo.HourOffset := aRequestConfig.HourOffset;
  //DataID  //reserved


  //gLog.Add(lkDebug, ClassName, PROC_TITLE, FConfig.Instrument.Symbol);


  if (bUnsubscribed) and (FConfig.MarketIF <> nil) then
  begin
    FQuotePlate :=
       FConfig.Instrument.Subscribe(FConfig.MarketIF, PID_TICK, [btNew], Self, TickProc);
  end;
  //
  if (aSource = nil) and (FConfig.ChartIF <> nil) then
  begin
    aHReqItem := gHDataBank.Request(aRequestConfig.ChartIF, aRequestInfo, CDataInserted);
    //
    if aHReqItem <> nil then  //recycle 된 data 는 size notify 요청을 하지 않는다.
      aHReqItem.DataSizeNotifyEvent := DataSizeNotifed;
  end else
  begin
    FReady := True;
    //
    if Assigned(FOnRefresh) then
      FOnRefresh(Self);
  end;

  Result := True;

end;

procedure TXTerms.CDataInserted(const Sender: TObject;const bLast{, bRewind}: Boolean;
  const aTermItem: TTermRec);
const
  PROC_TITLE = 'CDataInserted';
var
  stValue, stLastDate : String;
  i : Integer;
  aSession, aSession2 : TSessionItem;
  bCutted : Boolean;

  pData, pBackData : PCDataItem;
  aTickInfo : TTickRec;
  stFirstDate : String;
  aDateTime : TDateTime;
  wSec, wMSec : Word;
  aTickItem : TTickItem;
begin

  //
  if bLast then
  begin
    //
{$IFDEF DEBUG}
    gLog.Add(lkDebug, ClassName, PROC_TITLE, Format('count: %.0n', [FDataList.Count*1.0]));
{$ENDIF}

    for i := 0 to FTicks.Count-1 do
    begin
      aTickItem := FTicks.Items[i] as TTickItem;
      aTickInfo := aTickItem.TickInfo;
      //
{$IFDEF QUOTEX}
      NewRealTick(aTickInfo, aTickItem.Term);
{$ELSE}
      NewRealTick(aTickInfo);
{$ENDIF}
    end;
    FTicks.Clear;
    //

    FReady := True;
    //
    gHDataBank.RegisterRecycle(Self);

    {
    if Count > 0 then
    gLog.Add(lkDebug, classname, 'refreshed',
      formatdatetime('last:hhnn', DateMinToDateTime((Items[Count-1] as TXTermItem).LastDateMin)));
    }

    //cutting closing data
    bCutted := False;
    if gCutClosingData and
      (gCutClosingExceptions.IndexOf(FConfig.Instrument.Commodity.Symbol)<0) then
    begin
      //
      for i := DataCount-2 downto 0 do
      begin

        pData := Data[i];
        pBackData := Data[i+1];
        //
        if bCutted then
        begin
          bCutted := False;
          Continue;
        end;
        //
        aSession := FConfig.Instrument.Commodity.SessionByDateMin[pData^.LastDateMin];
        aSession2 := FConfig.Instrument.Commodity.SessionByDateMin[pBackData^.LastDateMin];
        //
        if (aSession <> aSession2) then
        begin
          FDataList.Delete(i);
          bCutted := True;
        end;

      end;

    end;
    //
    //Inc(gRefreshedAllocatedMemorySize, SizeOf(TCDataItem) * FDataList.FCapacity);
    //gLog.AddNoMessage(lkDebug, ClassName, PROC_TITLE, Format('refreshed allocated memory=%d',
    //  [gRefreshedAllocatedMemorySize]));
    if Instrument = nil then
      stValue := ''
    else
      stValue := Instrument.Symbol;

    stFirstDate := '';
    //
    if FDataList.Count > 0 then
    begin
      stFirstDate := FormatDateTime('yy-mm-dd',
        DateMinToDateTime(FDataList.List[0].LastDateMin));
      stLastDate := FormatDateTime('yy-mm-dd',
        DateMinToDateTime(FDataList.List[FDataList.Count-1].LastDateMin));
    end;
    //

{$IFDEF DEBUG}
    gLog.Add(lkDebug, ClassName, PROC_TITLE, Format('count: %.0n', [FDataList.Count*1.0]));
{$ENDIF}

    {
    gLog.Add(lkDebug, ClassName, PROC_TITLE,
      Format('instrument:%s count: %.0n /cap:%.0n/%s :: %s/%d/%s/elpased:%s',
        [stValue, FDataList.FCount*1.0, FDataList.FCapacity*1.0,
          stFirstDate, stLastDate, SizeOf(TCDataItem),GetMemTotalAddress,
          FormatDateTime('hh:nn:ss.zzz', Now-FLastDefineTime)]));
    }
    if Assigned(FOnRefresh) then
      FOnRefresh(Self);
    //

  end else
  begin
    //
    pData := FDataList.Add;
    //
    with pData^ do
    begin
{$IFDEF QUOTEX}
      Term := aTermItem;
{$ENDIF}
      //
      aDateTime := aTermItem.LastTime;
      if (FConfig.Base = cbMin) and (FConfig.HourOffset <> 0) then
        aDateTime := IncHour(aTermItem.LastTime, FConfig.HourOffset * -1);
      //
      LastDateMin.Date := Floor(aDateTime);
      LastDateMin.MMI := GetMMIndex(aDateTime, wSec, wMSec);
      //
      if FConfig.Base = cbTick then
        LastSecond := wSec;
      //
      O := aTermItem.Open;
      H := aTermItem.High;
      L := aTermItem.Low;
      C := aTermItem.Close;
      FillVol := aTermItem.Volume;
      OpenInt := aTermItem.OpenInt;

//{$IFDEF BUG}
      Count := 1;
//{$ENDIF}

    end;

  end;
  //
end;


procedure TXTerms.CopyFrom(aData: TXTerms);
const
  PROC_TITLE = 'CopyFrom';
begin
  FConfig := aData.Config;
  //Clear;
  FDataList.Clear;
  // ....LOG
  FDataList.SetCapacity(aData.DataCount);
  FDataList.SetCount(aData.DataCount);
  CopyMemory(@FDataList.List[0], @aData.FDataList.List[0], SizeOf(TCDataItem)*aData.DataCount);
  //
  FReady := True;
  //Inc(gRefreshedAllocatedMemorySize, SizeOf(TCDataItem) * FDataList.FCapacity);

  if Assigned(FOnRefresh) then
    FOnRefresh(Self);

end;

{ TCDataList }

{
function TCDataList.Add: PCDataItem;
var
  pLastData, pNewData : PCDataItem;
begin
  //
  if FList.Count > 0 then
    pLastData := FList[FList.Count-1]
  else
    pLastData := nil;

  New(pNewData);
  pNewData^.Before := nil;
  pNewData^.Next := nil;


  if pLastData <> nil then
    pLastData^.Next := pNewData;
  pNewData^.Before := pLastData;

  //
  if FList.Count mod FDelta = 0 then
    FList.Capacity := FList.Count + FDelta;
  FList.Add(pNewData);
  //
  Result := pNewData;

end;
}

{
function TCDataList.Delete(pPos: PCDataItem): Integer;
begin
  Result := FList.IndexOf(pPos);
  //
  if Result >= 0 then
  begin
    FList.Remove(pPos);

    //
    if pPos^.before <> nil then
      pPos^.before^.Next := pPos^.Next;

    //
    if pPos^.Next <> nil then
      pPos^.Next.Before := pPos^.Before;

    //
    Dispose(pPos);
  end;
end;
}
{
function TCDataList.Insert(iPos: Integer): PCDataItem;
var

  pPos, pData : PCDataItem;

begin
  Result := nil;

  if (iPos = FList.Count) then
  begin
    Result := Add;
    Exit;
  end;

  if (iPos < 0) or (iPos > FList.Count-1) then Exit;
  //
  pPos := FList.Items[iPos];
  //

  New(pData);
  pData^.Before := nil;
  pData^.Next := nil;

  if pPos^.Before <> nil then
    pPos^.Before^.Next := pData;

  pData^.Before := pPos.Before;
  pData^.Next := pPos;
  pPos^.Before := pData;

  if FList.Count mod FDelta = 0 then
    FList.Capacity := FList.Count + FDelta;
  FList.Insert(iPos, pData);

  Result := pData;
end;
}

{
function TCDataList.Insert(pPos: PCDataItem): PCDataItem;
var
  iP : Integer;
  pData : PCDataItem;
begin
  Result := nil;

  iP := FList.IndexOf(pPos);
  //
  if iP < 0 then Exit;
  //
  New(pData);

  pData^.Before := nil;
  pData^.Next := nil;

  if pPos^.Before <> nil then
    pPos^.Before^.Next := pData;

  pData^.Before := pPos.Before;
  pData^.Next := pPos;
  pPos^.Before := pData;

  if FList.Count mod FDelta = 0 then
    FList.Capacity := FList.Count + FDelta;
  FList.Insert(iP, pData);

  Result := pData;

end;
}
function TXTerms.GetData(i: Integer): PCDataItem;
begin
  Result := nil;
  //
  if (i>=0) and (i<FDataList.Count) then
    Result := @(FDataList.List[i]);
end;


function TXTerms.GetDataCount: Integer;
begin
  Result := FDataList.Count;
end;


procedure TXTerms.SaveToFile(stFileName: String; bAppend: Boolean);
var
  stLine : String;

  F : TextFile;
  i : Integer;
begin
  //
  //if not FileExists(stFileName) then Exit;

  AssignFile(F, stFileName);
  //
  try

    if FileExists(stFileName) and bAppend then
      Append(F)
    else
    begin
      try
        Rewrite(F);
      except
        Exit;
      end;
    end;
    //Rewrite(F);
    //Reset(F);
    (*
    pStart := Data[0];
    while (pStart <> nil) do
    begin
      stLine := FormatDateTime('yyyy-mm-dd,hh:nn:ss', DateMinToDateTime(pStart.LastDateMin));
      //if gPriceMode = pmInteger then
        stLine := stLine + Format(',%f,%f,%f,%f,0,0',
          [pStart.O, pStart.H, pStart.L, pStart.C]);
      //
      Writeln(F, stLine);
      //
      pStart := pStart^.Next;
    end;
    *)
    for i := 0 to FDataList.Count-1 do
    begin
      with FDataList.List^[i] do
      begin
        //
        if Config.Base = cbTick then
          stLine := FormatDateTime('yyyy-mm-dd,hh:nn:ss',
            DateMinToDateTime(LastDateMin, LastSecond, 0))
        else
          stLine := FormatDateTime('yyyy-mm-dd,hh:nn:ss', DateMinToDateTime(LastDateMin));
        //
        stLine := stLine + Format(',%f,%f,%f,%f,%d,%d',
          [{pStart.}O, {pStart.}H, {pStart.}L, {pStart.}C, FillVol, OpenInt]);

{$IFDEF QUOTEX}
        stLine := stLine + Format(',%f,%d,%f,%d', [Term.AskPrice, Term.AskQty,
          Term.BidPrice, Term.BidQty])
{$ENDIF}
      end;
      //
      Writeln(F, stLine);

    end;
  finally
    CloseFile(F);
  end;



  (*
  aFiles := TStringList.Create;

  try
    aFiles.Clear;
    //
    pStart := Data[0];
    //
    while (pStart <> nil) do
    begin
      stLine := FormatDateTime('yyyy/mm/dd hh:nn:ss', DateMinToDateTime(pStart.LastDateMin));
      //if gPriceMode = pmInteger then
        stLine := stLine + Format(',%f,%f,%f,%f',
          [pStart.O, pStart.H, pStart.L, pStart.C]);
      //
      aFiles.Add(stLine);
      //
      pStart := pStart^.Next;
    end;
    //
    aFiles.SaveToFile(stFileName);

  finally
    aFiles.Free;
  end;
  *)
end;

procedure TXTerms.GetPersistent(aElement: IXMLDOMElement);
//var
//  iSessionDate : Integer;
begin
  //
  if FConfig.Instrument <> nil then
  begin
    //aElement.setAttribute('exchange', FConfig.Instrument.Commodity.Exchange.Symbol);
    //aElement.setAttribute('product', FConfig.Instrument.Commodity.Symbol);
    //aElement.setAttribute('contract', FConfig.Instrument.Expiry);
    //
    //if FConfig.Instrument.Expiry = '' then
      aElement.setAttribute('symbol', FConfig.Instrument.Symbol);
    //iSessionDate := FConfig.Instrument.Commodity.DateOfSession[Now];
    //aElement.setAttribute('req_refdate_today', FConfig.ReqRefDate = iSessionDate);
  end;
  //
  //aElement.setAttribute('req_refdate_today', FConfig.ReqRefDate < 0);
  aElement.setAttribute('period', FConfig.Period);
  aElement.setAttribute('base', FConfig.Base);
  aElement.setAttribute('data_type', FConfig.DataType);
  aElement.setAttribute('req_count', FConfig.ReqCount);
  aElement.setAttribute('req_refdate', FConfig.ReqRefDate);


  aElement.setAttribute('use_reqrange', FConfig.UseReqRange);
  aElement.setAttribute('req_code', FConfig.ReqCode);
  aElement.setAttribute('realtime_offset', FConfig.RealTimeOffset);
  aElement.setAttribute('history_offset', FConfig.HourOffset);

  if FConfig.ChartIF = nil then
    aElement.setAttribute('hdata_vendor', '')
  else
    aElement.setAttribute('hdata_vendor', FConfig.ChartIF.AppliedVendorName);

  if FConfig.MarketIF = nil then
    aElement.setAttribute('rdata_vendor', '')
  else
    aElement.setAttribute('rdata_vendor', FConfig.MarketIF.AppliedVendorName);
end;

procedure TXTerms.SetPersistent(aElement: IXMLDOMElement);
const
  PROC_TITLE = 'SetPersistent';
var
  aReqConfig : TXTermsConfig;
  stExchange, stProduct, stContract, stSymbol : String;
  aExchange : TExchangeItem;
  aProduct : TProductItem;
  iValue : Integer;
  stValue : String;
begin
  try
    //
    InitXTermsConfig(aReqConfig);
    //
    stExchange := ''; stProduct := ''; stContract := ''; stSymbol := '';

    GetAttribute(aElement, 'exchange', stExchange);
    GetAttribute(aElement, 'product', stProduct);
    GetAttribute(aElement, 'contract', stContract);
    //
    if stContract = '' then
    begin
      if GetAttribute(aElement, 'symbol', stSymbol) then
        aReqConfig.Instrument := gMarketManager.FindInstrument(stSymbol);

      if aReqConfig.Instrument = nil then
      begin
        gLog.Add(lkError, ClassName, PROC_TITLE,
          Format('Instrument not found:%s,%s,%s,%s',
            [stExchange, stProduct, stContract, stSymbol]));
        //Exit;
      end;

    end else
    begin
      aReqConfig.Instrument := gMarketManager.FindContract(aElement.getAttribute('exchange'),
                            aElement.getAttribute('product'),
                            aElement.getAttribute('contract'));

    end;


    //
    if (aReqConfig.Instrument = nil) and (stProduct <> '') and (stExchange <> '') then
    begin
      aExchange := gMarketManager.FindExchange(stExchange);
      if aExchange <> nil then
      begin
        aProduct := aExchange.FindCommodity(stProduct, ctFuture);
        if (aProduct <> nil) and (aProduct.ContractCount > 0) then
        begin
          aReqConfig.Instrument := aProduct.Contracts[0];
          //
          gLog.Add(lkWarning, ClassName, PROC_TITLE,
            Format('not found instrument->(%s/%s/%s => %s',
              [stExchange, stProduct, stContract,
                aReqConfig.Instrument.Symbol]));

        end;
      end;
    end;

    if GetAttribute(aElement, 'hdata_vendor', stValue) then
      aReqConfig.ChartIF := gChartIFList.InterfacesByVendor[stValue] as TChartIF;
    //
    if GetAttribute(aElement, 'rdata_vendor', stValue) then
    begin
      aReqConfig.MarketIF := gMarketIFList.InterfacesByVendor[stValue] as TMarketIF;
      //
      if aReqConfig.MarketIF = nil then
      begin
        gLog.Add(lkWarning, ClassName, PROC_TITLE,
          Format('not found market interface:%s (E:%s,P:%s,C:%s,S:%s',
            [stValue, stExchange, stProduct, stContract, stSymbol]));

      end;
    end;

    GetAttribute(aElement, 'use_reqrange', aReqConfig.UseReqRange);
    GetAttribute(aElement, 'req_count', aReqConfig.ReqCount);
    if GetAttribute(aElement, 'data_type', iValue) then
      aReqConfig.DataType := TChartDataType(iValue);

    //
    if aReqConfig.ReqCount < 0 then
      aReqConfig.ReqCount := DEF_REQ_COUNT;
    //
    if aReqConfig.Instrument = nil then
      aReqConfig.ReqRefDate := Floor(Now)
    else
      aReqConfig.ReqRefDate := aReqConfig.Instrument.Commodity.DateOfSession[Now];
    //
    GetAttribute(aElement, 'req_refdate', aReqConfig.ReqRefDate);
    {
    if GetAttribute(aElement, 'req_refdate_today', bValue) then
    begin
      if not bValue then
        GetAttribute(aElement, 'req_refdate', aReqConfig.ReqRefDate);
    end;
    }
    //
    GetAttribute(aElement, 'req_code', aReqConfig.ReqCode);
    aReqConfig.Base :=aElement.getAttribute('base');
    GetAttribute(aElement, 'period', aReqConfig.Period);
    GetAttribute(aElement, 'realtime_offset', aReqConfig.RealTimeOffset);
    GetAttribute(aElement, 'history_offset', aReqConfig.HourOffset);


    if aReqConfig.Instrument = nil then
    begin
      FReady := True;
      //
      if Assigned(FOnRefresh) then
        FOnRefresh(Self);
    end else
      Define(aReqConfig);

  except
    gLog.Add(lkWarning, ClassName, PROC_TITLE,
      Format('workspace loading error Exch:%s Prod:%s Cont:%s Symbol:%s',
        [stExchange, stProduct, stContract, stSymbol]));
  end;
end;

{ TXTermsList }

function TXTermsList.Add: TXTerms;
begin
  Result := TXTerms.Create;
  FList.Add(Result);
end;

procedure TXTermsList.Clear;
var
  i : Integer;
begin
  for i := FList.Count-1 downto 0 do
    Remove(TXTerms(FList.Items[i]));
end;

constructor TXTermsList.Create;
begin
  FList := TList.Create;
end;

destructor TXTermsList.Destroy;
var
  i : Integer;
  aXTerms : TXTerms;
begin
  for i := FList.Count-1 downto 0 do
  begin
    aXTerms := TXTerms(FList.Items[i]);
    aXTerms.Undefine;
    aXTerms.Free;
  end;

  FList.Free;

  inherited;
end;

function TXTermsList.GetAllReady: Boolean;
var
  i : Integer;
  aData : TXTerms;
begin
  Result := False;
  //
  for i := 0 to FList.Count-1 do
  begin
    aData := TXTerms(FList.Items[i]);
    //
    if i = 0 then
      Result := aData.Ready
    else
      Result := aData.Ready and Result;
    //
    if not Result then Break;
  end;

end;

function TXTermsList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TXTermsList.GetItem(i: Integer): TXTerms;
begin
  Result := TXTerms(FList.Items[i]);
end;

function TXTermsList.Remove(aData: TXTerms): Boolean;
begin
  Result := FList.Remove(aData)>=0;
  //
  aData.Undefine;
  aData.Free;
end;

function TXTerms.FindData2(const aDateMin: TDateMin;const iP: Integer;
  const cbBase: TChartBase): Integer;
var
  i : Integer;
  pPointer : PCDataItem;
begin
  //
  Result := -1;
  //
  for i := iP to FDataList.Count-1 do
  begin
    pPointer := @FDataList.List[i];
    //
    with pPointer^ do
    case cbBase of
      cbTick :;
      cbMin :
        if CompareDateMin(LastDateMin, aDateMin)=0 then
        begin
          Result := i;
          break;
        end;
      cbDaily, cbWeekly, cbMonthly :
        if LastDateMin.Date = aDateMin.Date then
        begin
          Result := i;
          break;
        end;
    end;
  end;

end;

procedure TXTerms.DataSizeNotifed(iSize: Integer);
begin
  //
  //###FDataList.FList.Capacity := iSize;
  FDataList.SetCapacity(iSize);
end;


constructor TXTerms.CreateSmall;
begin
  FDataList := TCDataList2.Create;
  FTicks := TCollection.Create(TTickItem);

  //initialization fields
  InitXTermsConfig(FConfig);
  InitXTermsConfig(FTempConfig);

  //
  FReady := False;

end;


{ TSmallCDataList }

{
destructor TSmallCDataList.Destroy;
begin

  inherited;
end;
}



function TXTerms.FindData(const aDateMin: TDateMin;
  const cbBase: TChartBase; out iP: Integer): PCDataItem;
var
  i : Integer;
  pData : PCDataItem;
begin

  Result := nil;
  iP := -1;
  //
  for i := 0 to FDataList.Count-1 do
  begin
    pData := @FDataList.List[i];

    with pData^ do
    case cbBase of
      cbTick :;
      cbMin :
        if CompareDateMin(LastDateMin, aDateMin)=0 then
        begin
          Result := pData;
          iP := i;
          break;
        end;
      cbDaily, cbWeekly, cbMonthly :
        if LastDateMin.Date = aDateMin.Date then
        begin
          Result := pData;
          iP := i;
          break;
        end;
    end;
  end;

end;

function TXTerms.FindData3(const aDateMin: TDateMin; const iSecond,
  iP: Integer; const cbBase: TChartBase): Integer;
var
  i : Integer;
  pPointer : PCDataItem;
begin
  //
  Result := -1;
  //
  for i := iP to FDataList.Count-1 do
  begin
    pPointer := @FDataList.List[i];
    //
    with pPointer^ do
    case cbBase of
      cbTick :
        if (CompareDateMin(LastDateMin, aDateMin)=0) and (LastSecond = iSecond) then
        begin
          Result := i;
          break;
        end;
      cbMin :
        if CompareDateMin(LastDateMin, aDateMin)=0 then
        begin
          Result := i;
          break;
        end;
      cbDaily, cbWeekly, cbMonthly :
        if LastDateMin.Date = aDateMin.Date then
        begin
          Result := i;
          break;
        end;
    end;
  end;


end;

function TXTerms.GetDesc: String;
begin
  Result := '';
  //
  if FConfig.Instrument <> nil then
    Result := FConfig.Instrument.Symbol;
  //
  Result := Result + Format('@%d%s', [FConfig.Period, ChartBaseDescs[FConfig.Base]]);

end;

procedure TXTerms.NewRealTick(aTick: TTickRec; aTerm: TTermRec);
const
  PROC_TITLE = 'NewTick';
var
  bBeforeRef : Boolean;
  aTickDateMin, aTickLastDateMin : TDateMin;
  wYY1, wOO1, wDD1, wYY2, wOO2, wDD2 : Word;
  aTime : TDateTime;
  iDayOfWeek : Integer;
  bNew : Boolean;
  dPrice : Double;
  wHour, wMin, wSec, wMSec : Word;
{$IFDEF DEBUG}
//  aRecordTime : TDateTime;
{$ENDIF}

  pDataItem : PCDataItem;
  dRange : Double;
begin
  //-- get last item

  if FDataList.Count = 0 then
    pDataItem := nil
  else
    pDataItem := @(FDataList.List[FDataList.Count-1]);

  // -- check cutting range
  if (Instrument.Commodity.ContractType <> ctOption) and
     (pDataItem <> nil) and gFutureRangeCutting then
  begin
    dRange := Abs(pDataItem^.C) * gFutureCuttingRange;
    if ((aTick.Price > pDataItem^.C + dRange) or
        (aTick.Price < pDataItem^.C - dRange)) then
    begin
      gLog.Add(lkWarning, ClassName, PROC_TITLE,
        Format('%s cut out of data>> price:%f/last:%f',
          [Instrument.Symbol, aTick.Price, pDataItem^.C]));
      Exit;
    end;
  end;

  //
  if (FConfig.Base = cbMin) then//and (FConfig.RealTimeOffset <> 0) then
  begin
    if (FConfig.RealTimeOffset <> 0) then
      aTick.Time := IncSecond(aTick.Time, FConfig.RealTimeOffset * -1);
    if (FConfig.HourOffset <> 0) then
      aTick.Time := IncHour(aTick.Time, FConfig.HourOffset * -1);
  end;// else

  aTime := aTick.Time;
  //

  dPrice := aTick.Price;
  //
  aTickDateMin := EncodeToDateMin(aTime);
  aTickLastDateMin := IncDateMin(aTickDateMin, 1);
  //
  //-- check new or update
  if pDataItem = nil then
    bNew := True
  else
  case FConfig.Base of
    cbTick :
      bNew := (pDataItem.Count >= FConfig.Period);

    cbMin :
      bNew := CompareDateMin(pDataItem^.LastDateMin, aTickLastDateMin)<0;

    //
    cbDaily : bNew := (pDataItem^.LastDateMin.Date <> Floor(aTime));{ and // new day
                      (pDataItem^.Count >= FConfig.Period);}
              // 현재 1일 봉 외 지원안함
    //
    cbWeekly :
      begin
        iDayOfWeek := DayOfWeek(pDataItem^.LastDateMin.Date);
        bNew := (pDataItem^.LastDateMin.Date+(7-iDayOfWeek) < Floor(aTime)) and // new week
                (pDataItem^.Count >= FConfig.Period);
      end;
    //
    cbMonthly :
      begin
        DecodeDate(aTime, wYY1, wOO1, wDD1);
        DecodeDate(pDataItem^.LastDateMin.Date, wYY2, wOO2, wDD2);
        bNew := ((wYY1 <> wYY2) or (wOO1 <> wOO2)) and // new month
                 (pDataItem^.Count >= FConfig.Period);
      end;
    else
      Exit;

  end;

  // add up
  if bNew then
  begin
    if Assigned(FOnAddBefore) then
      FOnAddBefore(Self);
    //
    pDataItem := FDataList.Add;
    //
    if FConfig.Base = cbMin then
    begin
      //
      if FRefMMIndex = aTickLastDateMin.MMI then
        pDataItem.LastDateMin := aTickLastDateMin
      else
      begin
        pDataItem.LastDateMin.Date := aTickDateMin.Date;
        bBeforeRef := False;
        if FRefMMIndex > aTickDateMin.MMI then
        begin
          Dec(pDataItem.LastDateMin.Date);
          pDataItem.LastDateMin.MMI :=
            FRefMMIndex + ((aTickDateMin.MMI + MININUTES_INADAY - FRefMMIndex) div FConfig.Period + 1)*FConfig.Period;
          bBeforeRef := True;
        end else
          pDataItem.LastDateMin.MMI :=
            FRefMMIndex + ((aTickDateMin.MMI - FRefMMIndex) div FConfig.Period + 1)*FConfig.Period;
        //
        if pDataItem.LastDateMin.MMI >= MININUTES_INADAY then
        begin
          Inc(pDataItem.LastDateMin.Date);
          pDataItem.LastDateMin.MMI := pDataItem^.LastDateMin.MMI mod MININUTES_INADAY;
        end;
        //
        if bBeforeRef then
          pDataItem.LastDateMin.MMI := Min(FRefMMIndex, pDataItem.LastDateMin.MMI);

      end;

    end else
    if FConfig.Base = cbTick then
    begin
      pDataItem.LastDateMin := aTickDateMin;//.Date := Floor(aTime);
      DecodeTime(aTick.Time, wHour, wMin, wSec, wMSec);
      pDataItem.LastSecond := wSec;
    end else
    begin //daily...monthly
      //pDataItem^.LastDateMin.Date := Floor(aTime);

      //daily...monthly 는 lasttime 잘 두해야 한다. (todo:}
      pDataItem.LastDateMin.MMI := FLastMMIndex;{FRefMMIndex;}
      pDataItem.LastDateMin.Date := Floor(aTime);

    end;

    with pDataItem^ do
    begin
      Count := 1;
      O := dPrice;
      //
      //중국 tick - day high,low system 때문에
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.High ,FQuotePlate.PrevLastTick.High,
            Instrument.Commodity.PriceEpsilon)>0) then
        H := aTick.High
      else
        H := dPrice;
      //
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.Low, FQuotePlate.PrevLastTick.Low,
            Instrument.Commodity.PriceEpsilon)<0) then
        L := aTick.Low
      else
        L := dPrice;
      //
      C := dPrice;
      //
{$IFDEF QUOTEX}
      with FQuotePlate do
      begin
        Term := aTerm;
      end;
{$ENDIF}

      if FConfig.DataType = hdBid then
        FillVol := aTick.AccBidVolume
      else if FConfig.DataType = hdAsk then
        FillVol := aTick.AccAskVolume
      else
        FillVol := aTick.Size;
      OpenInt := aTick.OpenInt;
    end;
    //

//    gLog.Add(lkDebug, classname, 'refreshed',
//      formatdatetime('last:hhnn', DateMinToDateTime((Items[Count-1] as TXTermItem).LastDateMin)));
{$IFDEF DEBUG}
//    aRecordTime := Now;
{$ENDIF}

    if FReady and Assigned(FOnAdd) then
      FOnAdd(Self);

//    gLog.Add(lkDebug, ClassName, 'Add', FormatDateTime('ss.zzz', Now-aRecordTime));
  end else
  begin
    //update case

    with pDataItem^ do
    begin
      //중국 tick - day high,low system 때문에
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.High ,FQuotePlate.PrevLastTick.High,
            Instrument.Commodity.PriceEpsilon)>0) then
        H := Max(H, aTick.High)
      else
        H := Max(H, dPrice);
      //
      if (FConfig.Base in [cbTick, cbMin]) and
         (FQuotePlate.PrevLastTick.IsReceivePrice) and
         (CompareValue(aTick.Low ,FQuotePlate.PrevLastTick.Low,
            Instrument.Commodity.PriceEpsilon)<0) then
        L := Min(L, aTick.Low)
      else
        L := Min(L, dPrice);
    end;
    //

    FLastChangedOnUpdate :=
        not(CompareValue(pDataItem^.C - dPrice, Instrument.Commodity.PriceEpsilon)=0);
    //
    with pDataItem^ do
    begin
      C := dPrice;
      if FConfig.DataType = hdAsk then
        FillVol := aTick.AccAskVolume
      else if FConfig.DataType = hdBid then
        FillVol := aTick.AccBidVolume
      else
        FillVol := FillVol + aTick.Size;
      OpenInt := aTick.OpenInt;
      Inc(Count);
    end;
    //
    if FReady and Assigned(FOnUpdate) then
      FOnUpdate(Self);
  end;


end;

function TXTerms.FindData4(const aDateMin: TDateMin; const iSecond,
  iP: Integer; const cbBase: TChartBase): Integer;
var
  i : Integer;
  pPointer : PCDataItem;
begin
  //
  Result := 0;
  //
  for i := iP to FDataList.Count-1 do
  begin
    pPointer := @FDataList.List[i];
    //
    with pPointer^ do
    case cbBase of
      cbTick :
        if (CompareDateMin(LastDateMin, aDateMin)=0) and (LastSecond = iSecond) then
        begin
          Result := Min(FDataList.Count-1, i+1);
          break;
        end;
      cbMin :
        if CompareDateMin(LastDateMin, aDateMin)=0 then
        begin
          Result := Min(FDataList.Count-1, i+1);
          break;
        end;
      cbDaily, cbWeekly, cbMonthly :
        if LastDateMin.Date = aDateMin.Date then
        begin
          Result := Min(FDataList.Count-1, i+1);
          break;
        end;
    end;
  end;
end;

end.

