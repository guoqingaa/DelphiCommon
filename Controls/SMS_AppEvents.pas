unit SMS_AppEvents;

interface

uses
  Forms, Windows, Messages, AppEvnts;

const
  WM_SAPP_MSG = WM_USER + 15000;

type

  TSAppMessageEvent = procedure(const Msg: TMsg) of object;

  TAppMessageItem = record
    Msg : UInt;
    MessageProc : TSAppMessageEvent;
  end;
  PAppMessageItem = ^TAppMessageItem;


  TSAppEvents = class
  private
    FAppEvents : TApplicationEvents;
    //
    FMsgReceivers : array of TAppMessageItem;
    //
    //TMessageEvent = procedure (var Msg: TMsg; var Handled: Boolean) of object;
    procedure MessageProc(var Msg: TMsg; var Handled: Boolean);
    function FindReceiver(const iMsg: UInt): PAppMessageItem;

  public
    constructor Create;
    destructor Destroy; override;
    //
    function Subscribe(iMsg: UInt; aProc: TSAppMessageEvent): Boolean;
    function UnSubscribe(iMsg: UInt): Boolean;
  end;

implementation

{ TSAppEvents }

constructor TSAppEvents.Create;
begin
  inherited;
  //
  FAppEvents := TApplicationEvents.Create(Application);
  FAppEvents.OnMessage := MessageProc;
end;

destructor TSAppEvents.Destroy;
begin
  if not Application.Terminated then
    FAppEvents.Free;
  //
  FMsgReceivers := nil;
  //
  inherited;
end;

function TSAppEvents.FindReceiver(const iMsg: UInt): PAppMessageItem;
var
  i, iLen : Integer;
begin
  Result := nil;
  //
  iLen := Length(FMsgReceivers);
  for i := 0 to iLen-1 do
    if FMsgReceivers[i].Msg = iMsg then
    begin
      Result := @FMsgReceivers[i];
      Break;
    end;
end;

procedure TSAppEvents.MessageProc(var Msg: TMsg; var Handled: Boolean);
var
  pReceiver : PAppMessageItem;
begin
  if Msg.message >= WM_SAPP_MSG then
  begin
    pReceiver := FindReceiver(Msg.message);
    if pReceiver <> nil then pReceiver.MessageProc(Msg);
  end;
end;

function TSAppEvents.Subscribe(iMsg: UInt;
  aProc: TSAppMessageEvent): Boolean;
var
  iLen : Integer;
begin
  Result := False;
  //
  if iMsg < WM_SAPP_MSG then Exit;
  //
  if FindReceiver(iMsg) <> nil then Exit;
  //
  if not Assigned(aProc) then Exit;
  //
  iLen := Length(FMsgReceivers);
  SetLength(FMsgReceivers, iLen+1);
  FMsgReceivers[iLen].Msg := iMsg;
  FMsgReceivers[iLen].MessageProc := aProc;
  //
end;

function TSAppEvents.UnSubscribe(iMsg: UInt): Boolean;
var
  i, iLen : Integer;
begin
  Result := False;
  //
  iLen := Length(FMsgReceivers);
  for i := 0 to iLen-1 do
  begin
    if FMsgReceivers[i].Msg = iMsg then
    begin
      if i = iLen-1 then
      begin
        SetLength(FMsgReceivers, iLen-1);
      end else
      begin
        FMsgReceivers[i] := FMsgReceivers[i+1];
      end;
    end;
  end;

end;

end.
