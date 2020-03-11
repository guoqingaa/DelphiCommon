{$WARN SYMBOL_DEPRECATED OFF}
unit SMS_Messages;

interface

uses
  Classes, Windows, Forms, Messages, Controls;

const
  WM_TEMP = WM_USER + 1100;
  WM_TEMP2 = WM_USER + 1200;

type

  TMessageEvent = procedure(iParam: Integer) of object;
  TMessageEvent2 = procedure(iParam, iParam2: Integer) of object;

  TWindowMessageBox = class
  public
    Handle : THandle;

    OnMessageArrived : TMessageEvent2;

    procedure MessageCallBack(var aMsg: TMessage);virtual;

    constructor Create;
    destructor Destroy; override;

    procedure PostMessage(iParam, iParam2 : Integer);
    procedure SendMessage(iParam, iParam2 : Integer);
  end;

  //when create this object, must use "CreateParented" function

  TMessageGenerator = class(TWinControl)
  private
    FOnMessage: TMessageEvent;
    FOnMessage2: TMessageEvent2;
    FUserMessage: Integer;


  public
    //
    procedure Trigger(iParam: Integer);
    procedure MessageArrived(var aMsg: TMessage); message WM_TEMP;
    procedure MessageArrived2(var aMsg: TMessage); message WM_TEMP2;

    //procedure MessageArrived(var aMsg: TMessage); message FUserMessage;


    procedure Trigger2(iParam, iParam2 : Integer);
    //
    procedure TriggerUserMessage(iParam: Integer);

    property OnMessage: TMessageEvent read FOnMessage write FOnMessage;
    property OnMessage2 : TMessageEvent2 read FOnMessage2 write FOnMessage2;

    property UserMessage : Integer read FUserMessage write FUserMessage;
  end;

implementation

{ TMessageGenerator }

procedure TMessageGenerator.MessageArrived(var aMsg: TMessage);
begin
  //
  if Assigned(FOnMessage) then
    FOnMessage(aMsg.WParam);
end;

procedure TMessageGenerator.MessageArrived2(var aMsg: TMessage);
begin
  if Assigned(FOnMessage2) then
    FOnMessage2(aMsg.WParam, aMsg.LParam);
end;

procedure TMessageGenerator.Trigger(iParam: Integer);
begin
  //
  PostMessage(Handle, WM_TEMP, iParam, 0);
end;

procedure TMessageGenerator.Trigger2(iParam, iParam2: Integer);
begin
  PostMessage(Handle, WM_TEMP2, iParam, iParam2);
end;

procedure TMessageGenerator.TriggerUserMessage(iParam: Integer);
begin
  PostMessage(Handle, FUserMessage, iParam, 0);
  
end;

{ TWindowMessageBox }

constructor TWindowMessageBox.Create;
begin
  Handle := AllocateHWnd(MessageCallBack);
  //
end;

destructor TWindowMessageBox.Destroy;
begin


  DeallocateHWnd(Handle);
  //
  inherited;
end;

procedure TWindowMessageBox.MessageCallBack(var aMsg: TMessage);
begin
  if aMsg.Msg = WM_TEMP then
  begin
    if Assigned(OnMessageArrived) then
      OnMessageArrived(aMsg.WParam, aMsg.LParam);
    //

  end else
  begin
    Dispatch(aMsg);
  end;


end;

procedure TWindowMessageBox.PostMessage(iParam, iParam2: Integer);
begin
  Windows.PostMessage(Handle, WM_TEMP, iParam, iParam2);
end;

procedure TWindowMessageBox.SendMessage(iParam, iParam2: Integer);
begin
  //
  Windows.SendMessage(Handle, WM_TEMP, iParam, iParam2);

end;

end.
