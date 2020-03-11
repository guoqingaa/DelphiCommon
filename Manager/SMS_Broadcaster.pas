unit SMS_Broadcaster;

interface

uses Classes, ExtCtrls, SysUtils, Dialogs,
     //
   {AppTypes,} SMS_StatusManager;


const
  BID_ALL = 0;
  DECAY_DELAY = 2; // seconds

  EVENT_OBJECT = 1;
  EVENT_STRING = 2;

type
  TBroadcastType = (btNew, btUpdate, btDelete, btRefresh);
  TBroadcastTypes = set of TBroadcastType;
  TBroadcastEvent = procedure(Sender, Receiver, DataObj : TObject;
                  iBroadcastKind : Integer; btValue : TBroadcastType) of object;
  TBroadcastStrEvent =  procedure(Sender, Receiver : TObject;
                  stData : String;
                  iBroadcastKind : Integer; btValue : TBroadcastType) of object;

  { TRefreshItem }
  TRefreshItem = class(TCollectionItem)
  public
    Refreshed : Boolean;
  end;

  { TDecayItem }
  TDecayItem = class(TCollectionItem)
  public
    BroadcastKind : Integer;
    DataObj : TRefreshItem;
    Elapsed : Integer; // elpased seconds
    Requested : Integer; // Requested seconds
  end;

  { TBroadcastReqItem }

  TBroadcastReqItem = class(TCollectionItem)
  public
    Receiver : TObject;
    EventType : Integer;
    RecProc : TBroadcastEvent;
    RecStrProc : TBroadcastStrEvent;
    ReqKind : Integer;
    ReqTypes : TBroadcastTypes;
  end;

  { TBroadcaster }
  TBroadcaster = class
  private
    FBroadcastReqs : TCollection;
    FDecays : TCollection;

    procedure AddDecay(DataObj : TRefreshItem;
                       iBroadcastKind : Integer; iDecay : Integer);
    procedure TimerProc(Sender : TObject);
  public
    constructor Create;
    destructor Destroy; override;
    // initialize
    procedure Clear;
    // request subscription
    procedure Subscribe( iBroadcastKind : Integer; btValues : TBroadcastTypes;
                         Receiver : TObject; RecProc : TBroadcastEvent;
                         bTopPriority : Boolean = False);
    procedure SubscribeStr( iBroadcastKind : Integer; btValues : TBroadcastTypes;
                         Receiver : TObject; RecStrProc : TBroadcastStrEvent;
                         bTopPriority : Boolean = False);

    procedure UnSubscribe( Receiver : TObject );
    function IsSubscribed(Receiver:TObject; iKind:Integer) : Boolean; overload;
    function IsSubscribed(iKind: Integer): Boolean; overload;
    // request broadcast
    procedure Broadcast(Sender, DataObj : TObject;
                        iBroadcastKind : Integer; btValue : TBroadcastType;
                        bDelivery: Boolean = False);
    procedure BroadcastString(Sender : TObject;
                        stData : String;
                        iBroadcastKind : Integer; btValue : TBroadcastType;
                        bDelivery: Boolean = False);
    //
    function Count : Integer;
    function SubscribeReceivers : String;
  end;

  //----------------------------------------------------------
  // Beater is used to give heart beat at regular interval
  // to objects which need it.
  // It was designed to reduce OS resource taken by TTimer,
  // in which ONE timer is charged of all broadcasters
  //-----------------------------------------------------------

  { Beater item}

  TBeaterItem = class(TCollectionItem)
  public
    Receiver : TObject;
    TimerProc : TNotifyEvent;
    Data : Integer;
  end;

  { Beater }
  TBeater = class(TStatusObject)
  private
    FTimer : TTimer;
    FListeners : TCollection;
    //
    procedure TimerProc(Sender : TObject);

    function GetInterval : Cardinal;
  public
    constructor Create(const iInterval: Integer = 1000);
    destructor Destroy; override;

    function Add(aReceiver : TObject; aProc : TNotifyEvent): TBeaterItem; overload;
    procedure Add(aReceiver : TObject; aProc : TNotifyEvent; iData:Integer); overload;
    function Add(aReceiver : TObject; aProc : TNotifyEvent; bCheckDuplicated : Boolean): TBeaterItem; overload;

    procedure Remove(aReceiver : TObject); overload;
    procedure Remove(aReceiver : TObject; iData: Integer); overload;
    function GetStatus(aList : TStrings) : Integer; override;

    property Interval : Cardinal read GetInterval;
  end;

var
  gBeater : TBeater;
  gMicroBeater : TBeater;

implementation


//================================================================//
                       { TBroadcaster }
//================================================================//

//----------------< Public services >------------------------//

procedure TBroadcaster.Broadcast(Sender, DataObj: TObject;
  iBroadcastKind : Integer; btValue: TBroadcastType; bDelivery : Boolean);
var
  i, iCount : Integer;
  aItem : TBroadcastReqItem;
  //aFiles : TStringList;
begin
  //
  if (DataObj = nil) then Exit;
  //-- before broadcast
  if (DataObj is TRefreshItem) and
     (btValue <> btRefresh) then
    (DataObj as TRefreshItem).Refreshed := False;
  //-- broadcast

  try
    iCount := 0;
    for i:=0 to FBroadcastReqs.Count-1 do
    begin
      if i <= FBroadcastReqs.Count-1 then // fool-proof
      begin
        aItem := FBroadcastReqs.Items[i] as TBroadcastReqItem;
        //
        if aItem.EventType <> EVENT_OBJECT then continue;
        //
        if ((aItem.ReqKind = BID_ALL) or (aItem.ReqKind = iBroadcastKind)) and
           (btValue in aItem.ReqTypes) then
        begin
          try
            if not bDelivery then
               aItem.RecProc(Sender, aItem.Receiver, Dataobj, iBroadcastKind, btValue)
            else if bDelivery and (Sender = aItem.Receiver) then
              aItem.RecProc(Sender, aItem.Receiver, Dataobj, iBroadcastKind, btValue);
          except
            {
            aFiles := TStringList.Create;
            aFiles.Add((aItem.Receiver as TObject).ClassName);
            aFiles.SavetoFile('c:\abc.txt');
            aFiles.Free;
            }
          {
            gLog.Add(lkDebug, 'BroadCaster', 'Broadcast Error',
              (Sender as TObject).ClassName + ' Send To ' +
              (aItem.Receiver as TObject).ClassName);
          }
          end;
          Inc(iCount);
        end;
      end;
    end;

    //-- decay for highlight
    if DataObj is TRefreshItem then
      if iCount = 0 then
        (DataObj as TRefreshItem).Refreshed := True
      else
      if btValue in [btNew, btUpdate] then
         AddDecay(DataObj as TRefreshItem, iBroadcastKind, DECAY_DELAY);

  except
   
  end;
end;

procedure TBroadcaster.Subscribe(iBroadcastKind: Integer;
  btValues: TBroadcastTypes; Receiver: TObject; RecProc: TBroadcastEvent;
  bTopPriority : Boolean);
var
  aItem : TBroadcastReqItem;
begin
  //
  if (Receiver = nil) or not Assigned(RecProc) then Exit;
  //
  if bTopPriority then
    aItem := FBroadcastReqs.Insert(0) as TBroadcastReqItem
  else
    aItem := FBroadcastReqs.Add as TBroadcastReqItem;
  aItem.EventType := EVENT_OBJECT;
  aItem.Receiver := Receiver;
  aItem.RecProc := RecProc;
  aItem.ReqKind := iBroadcastKind;
  aItem.ReqTypes := btValues;
end;

procedure TBroadcaster.UnSubscribe(Receiver : TObject);
var
  i : Integer;
  aItem : TBroadcastReqItem;
begin
  //
  if (Receiver = nil) then Exit;
  //
  for i := FBroadcastReqs.Count-1 downto 0 do
  begin
    aItem := FBroadcastReqs.Items[i] as TBroadcastReqItem;
    if aItem.Receiver = Receiver then
      aItem.Free;
  end;
end;

function TBroadcaster.IsSubscribed(Receiver:TObject; iKind:Integer) : Boolean;
var
  i : Integer;
  aItem : TBroadcastReqItem;
begin
  Result := False;
  //
  for i := 0 to FBroadcastReqs.Count-1 do
  begin
    aItem := FBroadcastReqs.Items[i] as TBroadcastReqItem;
    if (aItem.Receiver = Receiver) and
       (aItem.ReqKind = iKind) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TBroadcaster.IsSubscribed(iKind: Integer): Boolean;
var
  i : Integer;
  aItem : TBroadcastReqItem;
begin
  Result := False;
  //
  for i := 0 to FBroadcastReqs.Count-1 do
  begin
    aItem := FBroadcastReqs.Items[i] as TBroadcastReqItem;
    if (aItem.ReqKind = iKind) then
    begin
      Result := True;
      Break;
    end;
  end;

end;


//---------------------< private operations >----------------------//

procedure TBroadcaster.AddDecay(DataObj: TRefreshItem; iBroadcastKind : Integer;
                                iDecay: Integer);
var
  i : Integer;
  aDecayItem : TDecayItem;
begin
  //-- if already exists then recycle it!
  for i:= 0 to FDecays.Count-1 do
  begin
    aDecayItem := FDecays.Items[i] as TDecayItem;
    if (aDecayItem.DataObj = DataObj) and
       (aDecayItem.BroadcastKind = iBroadcastKind) then
    begin
      aDecayItem.Elapsed := 0;
      Exit;
    end;
  end;
  //-- else add new one
  aDecayItem := FDecays.Add as TDecayItem;
  aDecayItem.BroadcastKind := iBroadcastKind;
  aDecayItem.DataObj := DataObj;
  aDecayItem.Requested := iDecay;
  //-- subscribe to timer
  if FDecays.Count = 1 then
    gBeater.Add(Self, TimerProc);
end;

procedure TBroadcaster.TimerProc(Sender: TObject);
var
  i : Integer;
  aItem : TDecayItem;
begin
  //-- check decay
  for i:= FDecays.Count-1 downto 0 do
  begin
    aItem := FDecays.Items[i] as TDecayItem;
    Inc(aItem.Elapsed);
    if aItem.Elapsed >= aItem.Requested then
    try
      aItem.DataObj.Refreshed := True;
      Broadcast(Self, aItem.DataObj, aItem.BroadcastKind, btRefresh);
      aItem.Free;
    except
      // ignored
    end;
  end;
  //-- unsubscibe to timer
  if FDecays.Count = 0 then
    gBeater.Remove(Self);
end;

function TBroadcaster.Count : Integer;
begin
  Result := FBroadcastReqs.Count;
end;

//---------------------< Init/final >----------------------------//

constructor TBroadcaster.Create;
begin
  FBroadcastReqs := TCollection.Create(TBroadcastReqItem);
  FDecays := TCollection.Create(TDecayItem);
end;

destructor TBroadcaster.Destroy;
begin
  if FDecays.Count > 0 then
  begin
    if gBeater <> nil then
     gBeater.Remove(Self);
  end;
  //
  FDecays.Free;
  FBroadcastReqs.Free;

  inherited;
end;

procedure TBroadcaster.Clear;
begin
  if FDecays.Count > 0 then
    gBeater.Remove(Self);
  //
  FDecays.Clear;
  FBroadcastReqs.Clear;
end;

//================================================================//
                              { TBeater }
//================================================================//

constructor TBeater.Create(const iInterval: Integer);
begin
  FListeners := TCollection.Create(TBeaterItem);
  //
  FTimer := TTimer.Create(nil);
  FTimer.Interval := iInterval; // 1 second
  FTimer.OnTimer := TimerProc;
  FTimer.Enabled := False;
end;

destructor TBeater.Destroy;
begin
  //FTimer.Enabled := False;
  FTimer.Free;
  FListeners.Free;

  inherited;
end;

function TBeater.Add(aReceiver: TObject; aProc: TNotifyEvent): TBeaterItem;
begin
  Result := FListeners.Add as TBeaterItem;
  with Result do
  begin
    Receiver := aReceiver;
    TimerProc := aProc;
  end;
  //
  if not FTimer.Enabled then
    FTimer.Enabled := True;
end;

procedure TBeater.Remove(aReceiver : TObject);
var
  i : Integer;
begin
  for i:=FListeners.Count-1 downto 0 do
  with FListeners.Items[i] as TBeaterItem do
    if Receiver = aReceiver then
    begin
      FListeners.Items[i].Free;
      //Break;
    end;
  //
  if FListeners.Count = 0 then
    FTimer.Enabled := False;
end;

procedure TBeater.TimerProc(Sender: TObject);
var
  i : Integer;
  aBeaterItem : TBeaterItem;
begin
  for i:=FListeners.Count-1 downto 0 do
  try
    if i <= FListeners.Count-1 then
    begin
      aBeaterItem := FListeners.Items[i] as TBeaterItem;
      aBeaterItem.TimerProc(aBeaterItem);
    end;
  except
    // ignored;
  end;
end;

function TBeater.GetStatus(aList : TStrings) : Integer;
var
  i : Integer;
begin
  Result := 0;
  //
  if aList = nil then Exit;

  aList.Clear;
  for i:=0 to FListeners.Count-1 do
  try
    aList.Add(IntToStr(i) + ':' +
             (FListeners.Items[i] as TBeaterItem).Receiver.ClassName)
  except
    aList.Add(IntToStr(i) + ': Reference Error');
  end;

  Result := aList.Count;
end;


function TBeater.GetInterval: Cardinal;
begin
  Result := 1;

  if FTimer = nil then Exit;

  Result:= FTimer.Interval;
end;


procedure TBroadcaster.SubscribeStr(iBroadcastKind: Integer;
  btValues: TBroadcastTypes; Receiver: TObject;
  RecStrProc: TBroadcastStrEvent; bTopPriority: Boolean);
var
  aItem : TBroadcastReqItem;
begin
  //
  if (Receiver = nil) or not Assigned(RecStrProc) then Exit;
  //
  if bTopPriority then
    aItem := FBroadcastReqs.Insert(0) as TBroadcastReqItem
  else
    aItem := FBroadcastReqs.Add as TBroadcastReqItem;

  aItem.EventType := EVENT_STRING;
  aItem.Receiver := Receiver;
  aItem.RecStrProc := RecStrProc;
  aItem.ReqKind := iBroadcastKind;
  aItem.ReqTypes := btValues;
end;

procedure TBroadcaster.BroadcastString(Sender: TObject; stData: String;
  iBroadcastKind: Integer; btValue: TBroadcastType; bDelivery: Boolean);
var
  i{, iCount} : Integer;
  aItem : TBroadcastReqItem;
begin

  //-- broadcast

  try
    //iCount := 0;
    for i:=0 to FBroadcastReqs.Count-1 do
    begin
      if i <= FBroadcastReqs.Count-1 then // fool-proof
      begin
        aItem := FBroadcastReqs.Items[i] as TBroadcastReqItem;
        //
        if aItem.EventType <> EVENT_STRING then continue;
        //
        if ((aItem.ReqKind = BID_ALL) or (aItem.ReqKind = iBroadcastKind)) and
           (btValue in aItem.ReqTypes) then
        begin
          try
            if not bDelivery then
               aItem.RecStrProc(Sender, aItem.Receiver, stData, iBroadcastKind, btValue)
            else if bDelivery and (Sender = aItem.Receiver) then
              aItem.RecStrProc(Sender, aItem.Receiver, stData, iBroadcastKind, btValue);
          except
            {
            gLog.Add(lkDebug, 'BroadCaster', 'Broadcast Error',
              (Sender as TObject).ClassName + ' Send To ' +
              (aItem.Receiver as TObject).ClassName);
            }
          end;
          //Inc(iCount);
        end;
      end;
    end;

  except
    //  none    Modify Oct, 8, 2003 Jaebeom jeon
  end;

end;

procedure TBeater.Remove(aReceiver: TObject; iData: Integer);
var
  i : Integer;
begin
  for i:=FListeners.Count-1 downto 0 do
  with FListeners.Items[i] as TBeaterItem do
    if (Receiver = aReceiver) and (Data = iData) then
    begin
      FListeners.Items[i].Free;
      //Break;
    end;
  //
  if FListeners.Count = 0 then
    FTimer.Enabled := False;


end;

procedure TBeater.Add(aReceiver: TObject; aProc: TNotifyEvent;
  iData: Integer);
var
  aBeaterItem : TBeaterItem;
begin
  aBeaterItem := Add(aReceiver, aProc);
  aBeaterItem.Data := iData;

end;

function TBeater.Add(aReceiver: TObject; aProc: TNotifyEvent;
  bCheckDuplicated: Boolean): TBeaterItem;
var
  i : Integer;
  aListener : TBeaterItem;
begin
  Result := nil;
  //
  if bCheckDuplicated then
  begin
    for i := 0 to FListeners.Count-1 do
    begin
      aListener := FListeners.Items[i] as TBeaterItem;
      //
      if (aListener.Receiver = aReceiver) and (@aListener.TimerProc = @aProc) then
        Exit;
    end;
  end;
  //
  Result := Add(aReceiver, aProc);
end;

function TBroadcaster.SubscribeReceivers: String;
var
  i : Integer;
  aReq : TBroadcastReqItem;
begin
  Result := '';
  //
  for i := 0 to FBroadcastReqs.Count-1 do
  begin
    aReq := FBroadcastReqs.Items[i] as TBroadcastReqItem;
    //
    if i > 0 then
      Result := Result + ',';
    //
    Result := Result + aReq.Receiver.ClassName+'('+IntToStr(aReq.ReqKind)+')';
  end;
end;

end.
