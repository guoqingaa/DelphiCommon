unit SMS_Network;

interface

uses
  SysUtils, Classes, Windows, Messages,
  IdSMTP, IdMessage, IdComponent,
  {$IFNDEF VER150}
  IdAttachment, {$ENDIF} IdSSLOpenSSL, SMS_Messages, SMS_Systems;

type

   TMailSenderStatus = ( msResolving,
                msConnecting,
                msConnected,
                msDisconnecting,
                msDisconnected,
                msStatusText,
                msftpTransfer,  // These are to eliminate the TIdFTPStatus and the
                msftpReady,     // coresponding event
                msftpAborted);  // These can be use din the other protocols to.

  TMailSenderStatusType = procedure (ASender: TObject; const AStatus: TMailSenderStatus;
                const AStatusText: string) of object;

  TSMS_EMailSender = class
  private
    FOnStatus: TMailSenderStatusType;
    FPort: Integer;
    FUserName: String;
    FHost: String;
    FPassword: String;
    FSender: String;
  public
    ReceipientsList : TStringList;

    constructor Create;
    destructor Destroy; override;

    procedure Connect; virtual;
    procedure Disconnect; virtual;

    function Send(stTitle: String; stContents: TStrings;
                aAttacheds : TStrings; out stMessage: String): Boolean; virtual;

    property OnStatus : TMailSenderStatusType read FOnStatus write FOnStatus;

    property Host : String read FHost write FHost;
    property Port : Integer read FPort write FPort;
    property UserName : String read FUserName write FUserName;
    property Password : String read FPassword write FPassword;
    property Sender : String read FSender write FSender;
  end;


  TSMS_IdEmailSender = class(TSMS_EMailSender)
  private
    FSMTP : TIdSMTP;
    FMailMessage : TIdMessage;

    //
{$IFDEF VER150}
    FIdSSLIOHandlerSocket: TIdSSLIOHandlerSocket;
{$ELSE}
    FIdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
{$ENDIF}
    //
    FIsTerminating : Boolean;
    //
    FConnectSSLEvent : Boolean;

    //procedure ThreadConnect;
    procedure StatusProc(ASender: TObject; const AStatus: TIdStatus;
                const AStatusText: string);
    procedure IdStatusProc(ASender: TObject; const AStatus: TIdStatus;
             const AStatusText: string);
    procedure IdStatusInfo({$IFNDEF VER150}const{$ENDIF} AMsg: string);
    //
    procedure Connected(Sender: TObject);
    procedure Disconnected(Sender: TObject);

  public

    function Send(stTitle: String; stContents: TStrings;
                aAttacheds : TStrings; out stMessage: String): Boolean; override;

    procedure ConnectSSL;
    procedure Connect; override;

    constructor Create(stHost, stUser, stPassword: String; iPort: Integer);
    destructor Destroy; override;

    property SMTPControl : TIdSMTP read FSMTP;



  end;

  TEMailSenderThread = class(TThread)
  private
    FMailSender : TSMS_IdEmailSender;
  public
    constructor Create(aMailSender: TSMS_IdEmailSender);
  end;

  TEmailSenderConnectThread = class(TEMailSenderThread)
  protected
    procedure Execute; override;
  end;

  TEmailSenderSendThread = class(TEMailSenderThread)
  private
//    FSendingTime : TDateTime;
    FAttached : String;
    FTitle : String;
    FContents : TStringList;
    //
//    procedure Send;
  protected
    procedure Execute; override;
  public
    constructor Create(aMailSender: TSMS_IdEmailSender);
    destructor Destroy; override;
  end;

  TSMS_CSmtpMailSender = class;
  TSmtpMailSenderThread = class(TThread)
  private
    FMailSender : TSMS_CSmtpMailSender;
    //FSender: String;
    FTitle : String;
    FContents : TStringList;
    FAttacheds : TStringList;
    FSuccessSent : Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  SmtpServerParam = record
    	Host : array[0..99] of AnsiChar;
	    Port : Integer;
	    User : array[0..99] of AnsiChar;
  	  Password : array[0..99] of AnsiChar;
  	  SMTP_SECURITY_TYPE : Integer;
      DebugMode : Boolean;
  end;

  TConnectSmtpServerProc = procedure(aParam : SmtpServerParam); cdecl;
  TSmtpSendProc = function(szSubject, szSender: PAnsiChar): Boolean; cdecl;
  TSmtpClearMsgProc = procedure(); cdecl;
  TSmtpClearRecipientProc = procedure(); cdecl;
  TSmtpAddMsgLineProc = procedure(szLine: PAnsiChar); cdecl;
  TSmtpAddRecipientProc = procedure(szRecipient: PAnsiChar); cdecl;
  TSmtpClearAttchedProc = procedure(); cdecl;
  TSmtpAddAttachProc = procedure(szAttach: PAnsiChar); cdecl;
  TSmtpMailSenderStatusProc = procedure(stTitle, stContents : String) of object;

  TSMS_CSmtpMailSender = class(TSMS_EMailSender)
  private
    FLibHandle : THandle;
    FLibPath: String;
    FLibFile: String;
    FSecurityType: Integer;

    FConnectProc : TConnectSmtpServerProc;
    FSendProc : TSmtpSendProc;
    FClearMsgProc :TSmtpClearMsgProc;
    FAddMsgLineProc : TSmtpAddMsgLineProc;
    FClearRecipientProc : TSmtpClearRecipientProc;
    FAddRecipientProc : TSmtpAddRecipientProc;
    FClearAttachedProc : TSmtpClearAttchedProc;
    FAddAttachProc : TSmtpAddAttachProc;
    FThread : TSmtpMailSenderThread;
    FDebugMode: Boolean;
    FOnStatusChange: TSmtpMailSenderStatusProc;

    procedure ThreadTerminated(Sender: TObject);


  public
    procedure Connect; override;
    procedure Disconnect; override;

    function Send(stTitle: String; stContents: TStrings;
               aAttacheds : TStrings; out stMessage: String): Boolean; override;

    constructor Create;
    destructor Destroy; override;

    property LibPath : String read FLibPath write FLibPath;
    property LibFlie : String read FLibFile write FLibFile;
    property SecurityType : Integer read FSecurityType write FSecurityType;
    property DebugMode : Boolean read FDebugMode write FDebugMode;
    property OnStatusChange : TSmtpMailSenderStatusProc read FOnStatusChange write FOnStatusChange;
  end;

implementation

uses IdTCPClient;

{ TSMS_EmailSender }

const
  MESSAGE_CONNECTED = WM_USER + 1000;


procedure TSMS_IdEmailSender.Connect;
begin
  FSMTP.Connect;

  ConnectSSL;

end;

procedure TSMS_IdEmailSender.Connected(Sender: TObject);
begin
  //FOnStatus(Self, msStatusText,
  //  Format('EmailSender:Connected count', []));

end;

procedure TSMS_IdEmailSender.ConnectSSL;
begin
  if FIdSSLIOHandlerSocket = nil then
  begin
{$IFDEF VER150}
    FIdSSLIOHandlerSocket := TIdSSLIOHandlerSocket.Create(nil);
{$ELSE}
    FIdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

{$ENDIF}

    FIdSSLIOHandlerSocket.SSLOptions.Method := sslvTLSv1;

    FIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;
    //(sslmUnassigned, sslmClient, sslmServer, sslmBoth);
    FIdSSLIOHandlerSocket.Open;

    FSMTP.IOHandler := FIdSSLIOHandlerSocket;

    if FConnectSSLEvent then
    begin
      FIdSSLIOHandlerSocket.OnStatus := IdStatusProc;
      FIdSSLIOHandlerSocket.OnStatusInfo := IdStatusInfo;
    end;
  end;
  //

end;

constructor TSMS_IdEmailSender.Create(stHost, stUser, stPassword: String;
  iPort: Integer);
begin
  //
  FMailMessage := TIdMessage.Create(nil);
  //
  FSMTP := TIdSMTP.Create(nil);
  {$IFDEF VER150}
  FSMTP.AuthenticationType := atLogin;//} atnone;
  {$ENDIF}
  FSMTP.Port := iPort;
  FSMTP.Host := stHost;
  FSMTP.Username := stUser;
  FSMTP.Password := stPassword;
  //
  FHost := FSMTP.Host;
  FPort := FSMTP.Port;
  FUserName := FSMTP.Username;
  FPassword := FSMTP.Password;

  FSMTP.OnStatus := StatusProc;
  FSMTP.OnConnected := Connected;
  FSMTP.OnDisconnected := Disconnected;
  //
  FIsTerminating := False;
  FConnectSSLEvent := False;
  //

end;

destructor TSMS_IdEmailSender.Destroy;
begin
  //
  FIsTerminating := True;
  FSMTP.Disconnect;
  //ReceipientsList.Free;
  FSMTP.Free;
  inherited;
end;

procedure TSMS_IdEmailSender.Disconnected(Sender: TObject);
begin
  //
  //if not FIsTerminating then
  //  FSMTP.Connect;
end;

procedure TSMS_IdEmailSender.IdStatusInfo({$IFNDEF VER150}const{$ENDIF} AMsg: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Self, msStatusText, 'IOInfo:'+AMsg);
end;

procedure TSMS_IdEmailSender.IdStatusProc(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(ASender, TMailSenderStatus(astatus), 'IO:'+astatustext);

end;


function TSMS_IdEmailSender.Send(stTitle: String; stContents: TStrings;
  aAttacheds : TStrings; out stMessage: String): Boolean;
const
  PROC_TITLE = 'Send';
var
  aSendThread : TEmailSenderSendThread;
begin
  //
  Result := FSMTP.Connected;

  if not Result then
  begin
    stMessage := 'SMTP Not Connected';
    Exit;
  end;
  aSendThread := TEmailSenderSendThread.Create(Self);
  aSendThread.FTitle := stTitle;
  
  aSendThread.FContents.Assign(stContents);
  if (aAttacheds.Count > 0) then
    aSendThread.FAttached := aAttacheds[0];
  aSendThread.Resume;

  (*
  FOnStatus(Self, msStatusText,
    Format('trying to send %s %s', [stTitle, stContents.Text]));
  Result := False;
  //
  if not FSMTP.Connected then
  begin
    stMessage := 'Not Connected';
    FOnStatus(Self, msStatusText,
      Format('trying to send but not connected', []));
    AddFailedMail;
    Exit;
  end;
  //
  with FMailMessage do
  begin
    Subject := stTitle;
    Priority := mpNormal;
    Headers.Text := 'Content-type: text/html';

    From.Address := FSMTP.Username;

    CCList.EMailAddresses := '';
    BccList.EMailAddresses := '';

    Recipients.Clear;
    //Body.Add('testingg..');
    Body.Assign(stContents);
    //
    for i := 0 to ReceipientsList.Count-1 do
      with Recipients.Add do
        Text := ReceipientsList[i];
  end;

  try
    //FSMTP.SendMsg(FMailMessage, False);
    FSMTP.Send(FMailMessage);
    Result := True;

  except on E: Exception do   ////EIdProtocalReplyError
    begin
      stMessage := E.Message;
      AddFailedMail;
    end;
  end;
  *)
end;

procedure TSMS_IdEmailSender.StatusProc(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(ASender, TMailSenderStatus(AStatus), AStatusText);
end;

{ TEmailSenderThread }


{
procedure TSMS_EmailSender.ThreadConnect;
var
  aThread : TEmailSenderConnectThread;
begin
  aThread := TEmailSenderConnectThread.Create(Self);
  aThread.FMailSender := Self;
  aThread.Resume;
end;
}
{ TSMS_EMailSender }

procedure TSMS_EMailSender.Connect;
begin
  //
end;

constructor TSMS_EMailSender.Create;
begin
  ReceipientsList := TStringList.Create;

end;

destructor TSMS_EMailSender.Destroy;
begin
  ReceipientsList.Free;

  inherited;
end;

procedure TSMS_EMailSender.Disconnect;
begin
  //
end;

function TSMS_EMailSender.Send(stTitle: String; stContents: TStrings;
  aAttacheds : TStrings; out stMessage: String): Boolean;
begin
  Result := False;
end;

{ TEMailSenderThread }

constructor TEmailSenderThread.Create(aMailSender: TSMS_IdEmailSender);
begin
  inherited Create(True);
  //
  FMailSender := aMailSender;
  Priority := tpIdle;
  FreeOnTerminate := True;
end;

{ TEmailSenderConnectThread }

procedure TEmailSenderConnectThread.Execute;
begin
  FMailSender.Connect;

end;

{ TEmailSenderSendThread }


constructor TEmailSenderSendThread.Create(aMailSender: TSMS_IdEmailSender);
begin
  inherited Create(aMailSender);
  //
  FContents := TStringList.Create;
end;

destructor TEmailSenderSendThread.Destroy;
begin
  FContents.Free;
  //
  inherited;
end;

procedure TEmailSenderSendThread.Execute;
var
  i : Integer;
  aAttached : TIdAttachment;
begin
  {
  if FMailSender.FSMTP.Connected then
    Send;//Synchronize(Send);
  //
  if Assigned(FMailSender.FOnStatus) then
    FMailSender.OnStatus(Self, msStatusText,
      Format('sending time:%s', [FormatDateTime('hh:nn:ss.zzz', FSendingTime)]));

  FOnStatus(Self, msStatusText,
    Format('trying to send %s %s', [stTitle, stContents.Text]));

  Result := False;
  //

  if not FSMTP.Connected then
  begin
    stMessage := 'Not Connected';
    FOnStatus(Self, msStatusText,
      Format('trying to send but not connected', []));
    AddFailedMail;
    Exit;
  end;
  }
  FMailSender.FSMTP.Disconnect;
  FMailSender.FSMTP.Connect;// ThreadConnect;
  //
  with FMailSender, FMailSender.FMailMessage do
  begin
    Subject := FTitle;
    Priority := mpNormal;
    Headers.Text := 'Content-type: text/html';

    From.Address := FSMTP.Username;
    From.Name := 'SDCM';

    CCList.EMailAddresses := '';
    BccList.EMailAddresses := '';

    Recipients.Clear;

    Body.Assign(FContents);
    //
    for i := 0 to ReceipientsList.Count-1 do
      with Recipients.Add do
        Text := ReceipientsList[i];
  end;


{$IFDEF VER150}

  aAttached := TIdAttachment.Create(FMailSender.FMailMessage.MessageParts, FAttached);

{$ELSE}
  if FileExists(FAttached) then
  begin
    aAttached := FMailSender.FMailMessage.MessageParts.Add as TIdAttachment;
    aAttached.LoadFromFile(FAttached);
  end;

  {$ENDIF}

  //
  try
    //
    FMailSender.FSMTP.Send(FMailSender.FMailMessage);
    //
  except on E: Exception do   ////EIdProtocalReplyError
    begin
//      stMessage := E.Message;
//      AddFailedMail;

    end;
  end;

  FMailSender.FMailMessage.MessageParts.Clear;

  FMailSender.FSMTP.Disconnect;
end;
{
procedure TEmailSenderSendThread.Send;
var
  aTime : TDateTime;
begin
  aTime := Now;
  FMailSender.FSMTP.Send(FMailSender.FMailMessage);
  FSendingTime := Now - aTime;
end;
}

{ TSMS_CSmtpMailSender }

procedure TSMS_CSmtpMailSender.Connect;
const
  LIB_FILE = 'CSmtp.dll';
  PROC_TITLE = 'Connect';
var
  aParam : SmtpServerParam;
begin
  //
  Disconnect;
  //
  if DirectoryExists(FLibPath) then
    AppendEnvPath(FLibPath);
  //
  FLibHandle := LoadLibrary(PChar(FLibPath + FLibFile));

  if FLibHandle > 0 then
  begin
    FConnectProc := GetProcAddress(FLibHandle, 'ConnectSmtpServer');
    FSendProc := GetProcAddress(FLibHandle, 'SendMail');
    FClearMsgProc := GetProcAddress(FLibHandle, 'ClearMailMsg');
    FAddMsgLineProc := GetProcAddress(FLibHandle, 'AddMsgLine');
    FClearRecipientProc := GetProcAddress(FLibHandle, 'ClearRecipient');
    FAddRecipientProc := GetProcAddress(FLibHandle, 'AddRecipient');
    FClearAttachedProc := GetProcAddress(FLibHandle, 'ClearAttachedFiles');
    FAddAttachProc := GetProcAddress(FLibHandle, 'AttachFile');
    //
    StrPCopy(aParam.Host, FHost);
    aParam.Port := FPort;
    StrPCopy(aParam.User, FUserName);
    StrPCopy(aParam.Password, FPassword);
    aParam.SMTP_SECURITY_TYPE := 1;
    aParam.DebugMode := FDebugMode;// True;//False;
{$IFDEF DEBUG}
    aParam.DebugMode := True;
{$ENDIF}
    //
    if Assigned(FConnectProc) then
      FConnectProc(aParam)
    else
      Disconnect;
  end else
  if Assigned(FOnStatusChange) then
    FOnStatusChange(PROC_TITLE, Format('Not Found CSmtp Lib', []));
end;

constructor TSMS_CSmtpMailSender.Create;
begin
  inherited;

  FLibFile := 'CSmtp.dll';
  FDebugMode := False;
end;

destructor TSMS_CSmtpMailSender.Destroy;
begin
  FreeLibrary(FLibHandle);
  inherited;
end;

procedure TSMS_CSmtpMailSender.Disconnect;
begin
  FSendProc := nil;
  FClearMsgProc := nil;
  FAddMsgLineProc := nil;
  FClearRecipientProc := nil;
  FAddRecipientProc := nil;
  FConnectProc := nil;
  FClearAttachedProc := nil;
  FAddAttachProc := nil;

  if (FLibHandle > 0) then
    FreeLibrary(FLibHandle);

end;

function TSMS_CSmtpMailSender.Send(stTitle: String; stContents: TStrings;
  aAttacheds : TStrings; out stMessage: String): Boolean;
//var
  //i : Integer;
  //aThread : TSmtpMailSenderThread;
begin
  Result := False;
  //
  if FThread <> nil then Exit;


  Result := True;

  FThread := TSmtpMailSenderThread.Create;

  FThread.FTitle := stTitle;
  FThread.FMailSender := Self;
  FThread.Priority := tpIdle;
  FThread.FreeOnTerminate := True;
  FThread.FContents.Assign(stContents);
  FThread.FAttacheds.Assign(aAttacheds);
  FThread.OnTerminate := ThreadTerminated;

  FThread.Resume;
  //Result := FSendProc(PAnsiChar(stTitle));

end;

procedure TSMS_CSmtpMailSender.ThreadTerminated(Sender: TObject);
const
  PROC_TITLE = 'ThreadTerminated';
var
  stTitle, stOutMessage : String;
  aContents, aAttached : TStringList;
  bFailed : Boolean;
begin
  //
  aContents := TStringList.Create;
  aAttached := TStringList.Create;

  try
    stTitle := FThread.FTitle;
    aContents.Assign(FThread.FContents);
    aAttached.Assign(FThread.FAttacheds);
    bFailed := not FThread.FSuccessSent;
    FThread := nil;
    //
    if bFailed then
    begin
      //Send(stTitle, aContents, aAttached, stOutMessage);
      if Assigned(FOnStatusChange) then
        FOnStatusChange(PROC_TITLE, 'Sending Failure!');
    end;
  finally
    aContents.Free;
    aAttached.Free;
  end;
end;

{ TSmtpMailSenderThread }

constructor TSmtpMailSenderThread.Create;
begin
  inherited Create(True);

  FContents := TStringList.Create;
  FAttacheds := TStringList.Create;
end;

destructor TSmtpMailSenderThread.Destroy;
begin
  FContents.Free;
  FAttacheds.Free;
end;

procedure TSmtpMailSenderThread.Execute;
var
  i : Integer;
begin
  FSuccessSent := False;
  //
  FMailSender.Disconnect;
  FMailSender.Connect;
  //
  if FMailSender.FLibHandle <= 0 then
  begin
    FSuccessSent := True; //라이브러리가 없는 경우 재전송을 포기한다.
    if Assigned(FMailSender.FOnStatusChange) then
      FMailSender.FOnStatusChange(ClassName, 'Not Found LibHandle');
    Exit;
  end;


  //

  with FMailSender do
  begin
    if not Assigned(FSendProc) then Exit;

    FClearRecipientProc();
    for i := 0 to ReceipientsList.Count-1 do
      FAddRecipientProc(PAnsiChar(ReceipientsList[i]));

    FClearMsgProc();
    //
    for i := 0 to FContents.Count-1 do
      FAddMsgLineProc(PAnsiChar(FContents[i]));

    FClearAttachedProc();
    if FAttacheds <> nil then
      for i := 0 to FAttacheds.Count-1 do
        FAddAttachProc(PAnsiChar(FAttacheds[i]));
  end;

  if (FMailSender <> nil) and (Assigned(FMailSender.FSendProc)) then
  begin
    //FMailSender.Connect;
    FSuccessSent := FMailSender.FSendProc(PAnsiChar(FTitle), PAnsiChar(FMailSender.FSender));
  end;

end;

end.

{
unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SMS_XMLs, MSXML_TLB, Grids, DB, ADODB, Math, SMS_Strings,
  Buttons, SMS_Media, IdNNTP, IdBaseComponent, IdComponent, jpeg,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdPOP3, IdMessage, IdSMTP, SMS_StatusViewer,
  Menus;



type

  TDBAccountItem = class(TCollectionItem)
  public

    AccountCode : String;
    Desc : String;
    Broker : String;
    LossCut : Integer;
    LosscutAlertRatio : Double;

    StartDate : TDateTime;

    //Init_Capital : Double;
    Equity_Value : Double;
    Initialized : Boolean;
    AccPL : Double;
    LastUpdateDate : TDateTime;

    PrevMonthLastPrice : Double;
    PrevMonth2LastPrice : Double;
    PrevMonth3LastPrice : Double;

    MonthlyLastPrices : array[0..5] of Double;

    Active : Boolean;


  end;

  TAccountItem = class;

  TBroker = class(TCollectionItem)
  public
    Accounts : TCollection;

    BrokerName : String;


    constructor Create(aColl: TCollection); override;
    destructor Destroy; override;

    function FindAccount(stValue: String): TAccountItem;
  end;

  TAccountItem = class(TCollectionItem)
  public
    Code : String;
    Desc : String;

    Losscut : Integer;
    LosscutAlertRatio : Double;
    //
    EquityValue : Double;

    DepositTotal : Double;
    DailyPL : Double;
    LastDailyPL : Double;

    LiquidTotal : Double;
    Commission : Double;
    AccPL : Double;
    //InitCapital : Double;
    UpdateTime : TDateTIme;
    DBUpdateTime : TDateTime;
    StartDate : TDateTime;
    EstimateDeposit : Double;

    Positions : TStringList;

    MonthlyLastPrices : array[0..5] of Double;

    RiskAlertedTime : Double;
    LosscutAlertedTime : Double;

    EnableAlert : Boolean;

    constructor Create(aColl: TCollection); override;
    destructor Destroy; override;
  end;

  TMailingTimes = class(TCollectionItem)
  public
    CheckHour : Word;
    CheckMin : Word;
    CheckSecond : Word;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    ButtonRefresh: TButton;
    GridAccounts: TStringGrid;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOConnection2: TADOConnection;
    ADOQuery2: TADOQuery;
    EditRefreshInterval: TEdit;
    ButtonStartTimer: TSpeedButton;
    Splitter1: TSplitter;
    GridPositions: TStringGrid;
    Button1: TButton;
    EditBroker: TEdit;
    ButtonMail: TButton;
    IdPOP31: TIdPOP3;
    IdMessage1: TIdMessage;
    IdSMTP1: TIdSMTP;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ButtonReconnectDB: TSpeedButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    PopupMenu1: TPopupMenu;
    UnableAlertmessage1: TMenuItem;
    Button3: TButton;
    procedure ButtonRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridAccountsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ButtonStartTimerClick(Sender: TObject);
    procedure GridPositionsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure ButtonMailClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ButtonReconnectDBClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UnableAlertmessage1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
    FBrokers : TCollection;
    FDBAccounts : TCollection;

    FSymbols : TStringList;

    FTimer : TTimer;
    FMailingTimer : TTimer;

    FMailingList : TStringList;

    FMailingTimes : TCollection;

    FApplicationPath : String;
    FLoadingPath : String;

    FAutoMailing : Boolean;

    FPrevHour : Word;
    FPrevMin : Word;
    FPrevSec : Word;
    //FPrevMMIndex : Word;

    FRiskAlertedSound : String;

    FLossCutAlertColor : TColor;
    //FLossCutAlertRatio : Double;

    procedure InitFields;
    procedure MailingTimerProc(Sender: TObject);
    procedure InitControls;

    procedure LoadBroker(stFile: String);

    procedure RefreshAccounts;
    procedure RefreshAccountsByProfit(aAccList: TList);
    procedure UpdateAccount(iP: Integer);



    procedure RefreshPositions;
    procedure RefreshPositionsByProfit(aAccList: TList);

    procedure RefreshDBAccounts;

    procedure QueryCNDBAccounts;
    procedure QueryBrokers;

    function FindDBAccount(stAccount: String): TDBAccountItem;

    procedure TimerProc(Sender: TObject);

    function FindSymbol(stSymbol: String): Integer;
    procedure CloneSymbolArray(aStrings: TStrings);
    //
    function FindBroker(stValue: String): TBroker;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation



uses
  SMS_Graphics, IdEMailAddress, FSetup;

const
  ALERT_CONDITION = -3.5;
  ALERT_CONDITION2 = -5;

procedure TForm1.ButtonRefreshClick(Sender: TObject);
var
  i : Integer;
  stBrokers : TStringList;
  aList : TList;
begin
  //FBrokers.Clear;

  stBrokers := TStringList.Create;

  try
    GetTokens(EditBroker.Text, stBrokers, ',');
    for i := 0 to stBrokers.Count-1 do
      LoadBroker(FLoadingPath + stBrokers[i]+'.xml');
    {
    LoadBroker('1.xml');
    LoadBroker('2.xml');
    LoadBroker('3.xml');
    LoadBroker('4.xml');
    LoadBroker('5.xml');
    LoadBroker('6.xml');
    LoadBroker('7.xml');
    }
  finally
    stBrokers.Free;
  end;

  aList := TList.Create;

  try

    IF RadioGroup1.ItemIndex = 0 then
    begin
      RefreshAccounts;
      RefreshPositions;
    end else
    begin
      RefreshAccountsByProfit(aList);
      RefreshPositionsByProfit(aList);
    end;



  finally
    aList.Free;
  end;
end;

procedure TForm1.LoadBroker(stFile: String);
var
  i, j : Integer;
  aDoc : IXMLDOMDocument;
  aBroker : TBroker;
  aAccsElement, aAccElement : IXMLDOMElement;
  aAccount : TAccountItem;
  stValue : String;
  dValue, dUpdateTime : Double;
  aDBAccount : TDBAccountItem;
  aPositions, aPositionElement : IXMLDOMElement;
  iValue, iValue2, iP : Integer;

begin
  aDoc := GetXMLDocument;
  if aDoc.load(stFile) then
  begin

    aAccsElement := aDoc.documentElement as IXMLDOMElement;
    //aAccsElement := GetFirstElementByTag(aDoc.documentElement, 'accounts') as IXMLDOMElement;
    //
    if aAccsElement = nil then Exit;
    //
    if GetAttribute(aAccsElement, 'broker', stValue) then
    begin
      aBroker := FindBroker(stValue);
      if aBroker = nil then
      begin
        aBroker := FBrokers.Add as TBroker;
      end;

      aBroker.BrokerName := stValue;
    end;
    //
    GetAttribute(aAccsElement, 'update_time', dUpdateTime);

    for i := 0 to aAccsElement.childNodes.length-1 do
    begin
      aAccElement := aAccsElement.childNodes[i] as IXMLDOMElement;
      //

      //aAccount := aBroker.Accounts.Add as TAccountItem;


      //
      if GetAttribute(aAccElement, 'code', stValue) then
      begin
        aAccount := aBroker.FindAccount(stValue);
        //
        if aAccount = nil then
          aAccount := aBroker.Accounts.Add as TAccountItem;

        aAccount.Code := stValue;
        //

      end;
      //
      CloneSymbolArray(aAccount.Positions);
      aAccount.UpdateTime := dUpdateTime;


      aDBAccount := FindDBAccount(aAccount.Code);
      //

      //if  aDBAccount.
      if aDBAccount = nil then
      begin
        aBroker.Accounts.Delete(aAccount.Index);
        continue;
      end;

      if aDBAccount <> nil then
      begin
        //aAccount.InitCapital := aDBAccount.Init_Capital;
        aAccount.EquityValue := aDBAccount.Equity_Value;
        aAccount.DBUpdateTime := aDBAccount.LastUpdateDate;
        aAccount.StartDate := aDBAccount.StartDate;
        aAccount.Losscut := aDBAccount.LossCut;
        aAccount.LosscutAlertRatio := aDBAccount.LosscutAlertRatio;
        aAccount.MonthlyLastPrices[0] := aDBAccount.PrevMonthLastPrice;
      end;
      //
      if aDBAccount <> nil then

        aAccount.AccPL := aDBAccount.AccPL;


      if GetAttribute(aAccElement, 'desc', stValue) then
        aAccount.Desc := stValue;
      //

      if GetAttribute(aAccElement, 'deposit_total', dValue) then
        aAccount.DepositTotal := dValue;
      //
      if GetAttribute(aAccElement, 'daily_pl', dValue) then
        aAccount.DailyPL := dValue;
      //
      if GetAttribute(aAccElement, 'liquid_total', dValue) then
        aAccount.LiquidTotal := dValue;
      if GetAttribute(aAccElement, 'commission', dValue) then
        aAccount.Commission := dValue;
      if GetAttribute(aAccElement, 'estimate_deposit', dValue) then
        aAccount.EstimateDeposit := dValue;


      //

      aPositions := GetFirstElementByTag(aAccElement, 'positions');
      //
      //if aPositions.childNodes.length = 0 then continue;

      //aPositions := aPositions.childNodes.item[0] as IXMLDOMElement;
      if aPositions = nil then continue;
      //
      //reset positions
      for j := 0 to aAccount.Positions.Count-1 do
        aAccount.Positions[j] := '0';

      for j := 0 to aPositions.childNodes.length-1 do
      begin
        aPositionElement := aPositions.childNodes[j] as IXMLDOMElement;
        //
        if GetAttribute(aPositionElement, 'symbol', stValue) then
        begin
          iP := FindSymbol(stValue);
          //
          if iP < 0 then continue;
          //
          iValue := 0;
          if not GetAttribute(aPositionElement, 'long_qty', iValue) then
          begin
            StatusViewer.AddMessage('warning: invalid tag name');

          end;

          iValue2 := 0;
          if not GetAttribute(aPositionElement, 'short_qty', iValue2) then
          begin
            StatusViewer.AddMessage('warning: invalid tag name');
          end;

          aAccount.Positions[iP] := IntToStr(StrToInt(aAccount.Positions[iP])+ iValue - iValue2);



        end;

      end;

    end;

  end;


end;

procedure TForm1.RefreshAccounts;

var
  i, iP, j : Integer;
  aBroker : TBroker;
  aAccount : TAccountItem;
  dExpected : Double;
begin
  GridAccounts.RowCount := 2;
  //
  //GridAccounts.ColCount := 14;

  GridAccounts.Cells[1, 0] := 'Account';
  GridAccounts.Cells[2, 0] := 'Deposit';
  GridAccounts.Cells[3, 0] := 'DailyPL';
  GridAccounts.Cells[4, 0] := 'Liquid';
  GridAccounts.Cells[5, 0] := 'R-Liquid %';
  GridAccounts.Cells[6, 0] := 'Fees';
  GridAccounts.Cells[7, 0] := 'capital';
  GridAccounts.Cells[8, 0] := 'estimate';
  GridAccounts.Cells[9, 0] := 'DailyPL %';
  GridAccounts.Cells[10, 0] := 'AccPL %';
  GridAccounts.Cells[11, 0] := 'Expected %';
  GridAccounts.Cells[12, 0] := 'Losscut %';
  GridAccounts.Cells[13, 0] := 'Remain-Losscut %';
  GridAccounts.Cells[14, 0] := 'Update time';
  GridAccounts.Cells[15, 0] := 'DB Update time';
  GridAccounts.Cells[16, 0] := 'Start Date';
  GridAccounts.Cells[17, 0] := 'Monthly';
  GridAccounts.Cells[18, 0] := 'M-Days';






  iP := 1;
  for i := 0 to FBrokers.Count-1 do
  begin
    aBroker := FBrokers.Items[i] as TBroker;
    //
    GridAccounts.RowCount := iP+1;
    GridAccounts.Objects[0, iP] := aBroker;
    GridAccounts.Cells[0, iP] := aBroker.BrokerName;

    Inc(iP);
    //
    for j := 0 to aBroker.Accounts.Count-1 do
    begin
      aAccount := aBroker.Accounts.Items[j] as TAccountItem;
      //

      try
      GridAccounts.RowCount := iP+1;
      GridAccounts.Objects[0, iP] := aAccount;

      UpdateAccount(iP);
      (*
      GridAccounts.Cells[0, iP] := aAccount.Code;
      GridAccounts.Cells[1, iP] := aAccount.Desc;
      GridAccounts.Cells[2, iP] := Format('%.0n', [aAccount.DepositTotal]);
      GridAccounts.Cells[3, iP] := Format('%.0n', [aAccount.DailyPL]);
      GridAccounts.Cells[4, iP] := Format('%.0n', [aAccount.LiquidTotal]);

      if not IsZero(aAccount.EquityValue) then
        GridAccounts.Cells[5, iP] := Format('%.0f%%', [100-aAccount.LiquidTotal/aAccount.EquityValue*100]);
      GridAccounts.Cells[6, iP] := Format('%.0n', [aAccount.Commission]);
      GridAccounts.Cells[7, iP] := Format('%.0n', [aAccount.EquityValue]);
      if not IsZero(aAccount.EquityValue) then
      begin
        GridAccounts.Cells[8, iP] := Format('%.2f%%', [aAccount.DailyPL / aAccount.EquityValue * 100]);
        if aAccount.DailyPL / aAccount.EquityValue * 100 < ALERT_CONDITION then
          aAccount.RiskAlertedTime := Now;
      end;

      GridAccounts.Cells[9, iP] := Format('%.2n', [aAccount.AccPL*100]);

      dExpected := aAccount.AccPL*100+aAccount.DailyPL / aAccount.EquityValue * 100;
      if not IsZero(aAccount.EquityValue) then
        GridAccounts.Cells[10, iP] := Format('%.2n', [dExpected]);

      GridAccounts.Cells[12, iP] := Format('%f', [(dExpected+aAccount.Losscut)]);
      GridAccounts.Cells[11, iP] := IntToStr(aAccount.Losscut);

      GridAccounts.Cells[13, iP] := FormatDateTime('yy/mm/dd hh:nn', aAccount.UpdateTime);

      GridAccounts.Cells[14, iP] := FormatDateTime('yy/mm/dd', aAccount.DBUpdateTime);
      GridAccounts.Cells[15, iP] := FormatDateTime('yy/mm/dd', aAccount.StartDate);

      GridAccounts.Cells[16, iP] :=
        Format('%.2f',[(aAccount.AccPL-aAccount.MonthlyLastPrices[0])/(aAccount.MonthlyLastPrices[0]+1)*100]);

      GridAccounts.Cells[17, iP] := IntToStr(Floor(Now- aAccount.StartDate));

      *)
      {
      GridAccounts.Cells[15, iP] :=
        Format('%.f',[(aAccount.MonthlyLastPrices[0]*100)]);
      }
      Inc(iP);

      except
      end;

    end;

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  iWidth : Integer;
  i , iValue: Integer;
  aDoc : IXMLDOMDocument;
  aElement, aElement2, aElement3 : IXMLDOMElement;
  bValue : Boolean;
  stValue : String;
begin
  FLossCutAlertColor := clRed;
  //FLossCut

  Caption := Caption + '  ver 0.005';
  //
  FMailingList := TStringList.Create;
  FApplicationPath := ExtractFilePath(Application.ExeName);
  FLoadingPath := FApplicationPath;

  FMailingTimes := TCollection.Create(TMailingTimes);
  with FMailingTimes.Add as TMailingTimes do
  begin
    CheckHour := 10;
    CheckMin := 16;
    CheckSecond := 0;
  end;
  //
  with FMailingTimes.Add as TMailingTimes do
  begin
    CheckHour := 11;
    CheckMin := 31;
    CheckSecond := 0;
  end;
  //
  with FMailingTimes.Add as TMailingTimes do
  begin
    CheckHour := 14;
    CheckMin := 00;
    CheckSecond := 0;
  end;

  FMailingTimer := TTimer.Create(Self);
  FMailingTimer.OnTimer := MailingTimerProc;
  FMailingTimer.Interval := 1000;
  FMailingTimer.Enabled := True;




  FBrokers := TCollection.Create(TBroker);
  FDBAccounts := TCollection.Create(TDBAccountItem);

  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerProc;

  FSymbols := TStringList.Create;
  FSymbols.Add('IF');
  FSymbols.Add('CU');
  FSymbols.Add('RU');
  FSymbols.Add('RB');
  FSymbols.Add('SR');
  FSymbols.Add('TA');


  InitControls;


  QueryCNDBAccounts;


  aDoc := GetXMLDocument;
  if aDoc.load(FApplicationPath + 'configs.xml') then
  begin
    //aElement := aDoc.childNodes[0] as IXMLDOMElement;
    aElement := aDoc.documentElement as IXMLDOMElement;
    //
    //FLoadingPath := aElement.getAttribute('loading_path');
    if GetAttribute(aElement, 'loading_path', stValue) then
    begin
      FLoadingPath := stValue;
      caption := caption + '  ' + FLoadingPath;
    end;

    iValue := aElement.getAttribute('left');
    Left := iValue;
    iValue := aElement.getAttribute('top');
    Top := iValue;
    if GetAttribute(aElement, 'width', iValue) then
      Width := iValue;
    //
    if GetAttribute(aElement, 'height', iValue) then
      Height := iValue;

    if GetAttribute(aElement, 'brokers', stValue) then
      EditBroker.Text := stValue;

    if GetAttribute(aElement, 'auto_mailing', bValue) then
      FAutoMailing := bValue;
    //
    if GetAttribute(aElement, 'alert_sound', stValue) then
      FRiskAlertedSound := stValue;

    if GetAttribute(aElement, 'auto_refresh', bValue) then
    begin
      ButtonStartTimer.Down := bValue;
      ButtonStartTimerClick(nil);
    end;


    aElement2 := GetFirstElementByTag(aElement, 'mailing_list');
    //
    if aElement2 <> nil then
      for i := 0 to aElement2.childNodes.length-1 do
      begin
        aElement3 := aElement2.childNodes[i] as IXMLDOMElement;
        if GetAttribute(aElement3, 'address', stValue) then
          FMailingList.Add(stValue);
      end;




  end;

  {
  iWidth := 0;
  for i := 0 to GridAccounts.ColCount-1 do
    iWidth := iWidth + GridAccounts.ColWidths[i];
  GridAccounts.Width := iWidth;
  }

end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i : Integer;
  aDoc : IXMLDOMDocument;
  aElement, aElement2, aElement3 : IXMLDOMElement;
begin
  aDoc := GetXMLDocument;
  aElement := MakeChildElement(aDoc, nil, 'configs');
  aElement.setAttribute('loading_path', FLoadingPath);
  aElement.setAttribute('brokers', EditBroker.Text);
  aElement.setAttribute('left', Left);
  aElement.setAttribute('top', Top);
  aElement.setAttribute('width', Width);
  aElement.setAttribute('height', Height);
  aElement.setAttribute('loading_path', FLoadingPath);
  aElement.setAttribute('auto_mailing', FAutoMailing);
  aElement.setAttribute('alert_sound', FRiskAlertedSound);
  aElement.setAttribute('auto_refresh', ButtonStartTimer.Down);
  //
  aElement2 := MakeChildElement(aElement, 'mailing_list');
  //
  for i:= 0 to FMailingList.Count-1 do
  begin
    aElement3 := MakeChildElement(aElement2, 'address');
    aElement3.setAttribute('address', FMailingList[i]);
  end;

  aDoc.save('configs.xml');




  FSymbols.Free;

//  FTimer.Free;
  //
  FDBAccounts.Free;
  FBrokers.Free;
  //
  FMailingList.Free;
end;

{ TBroker }

constructor TBroker.Create(aColl: TCollection);
begin
  inherited Create(aColl);

  Accounts := TCollection.Create(TAccountItem);

end;

destructor TBroker.Destroy;
begin
  Accounts.Free;

  inherited;
end;

procedure TForm1.GridAccountsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  LOSS_CUT_READY = 5;

var
  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;
  stValue : String;
  aRowRect : TRect;
  i : Integer;
  aBroker : TBroker;
  dValue : Double;
  aAccount : TAccountItem;
  iColor : Byte;
  aFontStyle : TFontStyles;
begin

  with GridAccounts.Canvas do
  begin
    try
    aFontStyle := Font.Style;
    Font.Name := GridAccounts.Font.Name;
    Font.Size := GridAccounts.Font.Size;
    //
    stText := GridAccounts.Cells[ACol, ARow];
    if gdFixed in State then
    begin
      Brush.Color := clBtnFace;//FIXED_COLOR;
      Font.Color := clBlack;
      aAlignment := taLeftJustify;
    end else
    begin

      {
      if stText = '' then
       Brush.Color := clWhite//NODATA_COLOR
      else
        Brush.Color := clWhite;
      }
      Brush.Color := clWhite;
      //
      if gdSelected in State then
        Brush.Color := SELECTED_COLOR2;

      //
      if (ACol = 9) and (stText <> '')then
      begin

        dValue := StrToFloat(StringReplace(stText, '%', '', [rfReplaceAll]));
        //
        if Abs(dValue) > 3 then
          Brush.Color := clBtnFace;

      end;
      Font.Color := clBlack;

      if (ACol = 5) and (stText <> '')then
      begin

        dValue := StrToFloat(StringReplace(stText, '%', '', [rfReplaceAll]));
        //
        //if Abs(dValue) > 30 then

        iColor := Round((100-dValue)*255/100);
        Brush.Color := RGB(iColor, iColor, iColor);

        if iColor < 50 then
          Font.Color := clWhite;

      end;


      if (ACol in [3,9,10,11,17]) and (stText <> '') then
      begin
        //stValue := StringReplace(stText, ',', '', [rfReplaceAlll]);
        if stText[1] = '-' then
          Font.Color := clBlue
        else
          Font.Color := clRed;

      end;



      aAlignment := taRightJustify;

      if ACol in [1] then
        aAlignment := taLeftJustify;


    end;
    //-- background
    if GridAccounts.Objects[0, ARow] is TBroker then
    begin
      aBroker := GridAccounts.Objects[0, ARow] as TBroker;
      //
      aRowRect.Top := Rect.Top;
      aRowRect.Bottom := Rect.Bottom;
      aRowRect.Left := GridAccounts.CellRect(0, AROW).Left;
      aRowRect.Right := GridAccounts.CellRect(0, AROW).Right;

      for i := 1 to GridAccounts.ColCount-1 do
      begin
        aRowRect.Right := GridAccounts.CellRect(i, AROW).Right;

      end;
      Brush.Color := EVEN_COLOR;//clLtGray;
      FillRect(aRowRect);
      stText := aBroker.BrokerName;
      //-- text
      if stText = '' then Exit;
      //-- calc position

      aSize := TextExtent(stText);
      iY := aRowRect.Top + (aRowRect.Bottom - aRowRect.Top - aSize.cy) div 2;
      iX := aRowRect.Left + (aRowRect.Right-aRowRect.Left-aSize.cx) div 2;
      //-- put text
      iX := aRowRect.Left + (aRowRect.Right-aRowRect.Left-aSize.cx) div 2;
      {
      case aAlignment of
        //taLeftJustify :  iX := aRowRect.Left + 2;
        //taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
        //taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx;
      end;
      }
      TextRect(aRowRect, iX, iY, stText);

    end else
    begin

      if GridAccounts.Objects[0, ARow] is TAccountItem then
      begin
        aAccount := GridAccounts.Objects[0, ARow] as TAccountItem;
        //
        if ACol = 1 then
        begin
          if (aAccount.AccPL < 0.1) then
          begin
            Brush.Color := clYellow;

            if aAccount.DailyPL / aAccount.EquityValue * 100 < ALERT_CONDITION then
              Brush.Color := clGreen;
          end else
          begin
            if aAccount.DailyPL / aAccount.EquityValue * 100 < ALERT_CONDITION2 then
              Brush.Color := clMoneyGreen;
          end;

          if not aAccount.EnableAlert then
            Font.Style := Font.Style + [fsStrikeOut];;
        end;

        if ACol = 13 then      //remain - loss cut
        begin
          try
            dValue := StrToFloat(stText);
            if dValue < 0 then
            begin
              Brush.Color := clGreen;
            end else
            if dValue < LOSS_CUT_READY then
            begin
              Brush.Color := clMoneyGreen;

               dValue := StrToFloat(GridAccounts.Cells[10, ARow]); //AccPL
               //
               if dValue < aAccount.LosscutAlertRatio * -1 then
               begin
                 Brush.Color := FLosscutAlertColor;
                 ///
               end;


            end

          except

          end;

        end;


      end;

      FillRect(Rect);
      //-- text
      if stText = '' then Exit;
      //-- calc position
      aSize := TextExtent(stText);
      iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
      iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      //-- put text
      case aAlignment of
        taLeftJustify :  iX := Rect.Left + 2;
        taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
        taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx;
      end;
      TextRect(Rect, iX, iY, stText);
    end;

    except
    end;
    Font.Style := aFontStyle;
  end;



end;

procedure TForm1.QueryCNDBAccounts;
var
  aAccount : TDBAccountItem;
  //aBroker : TBrokerItem;
  stBroker : String;
  i : Integer;
  dValue : Double;
  dYearMonth : TDateTime;
  wYear, wMonth, wDay : Word;

  dYearMonth2 : TDateTime;
  wYear2, wMonth2, wDay2 : Word;

  aAccFiles, aTokens : TStringList;
begin
  FDBAccounts.Clear;
  FBrokers.Clear;
  //

  aAccFiles := TStringList.Create;
  aTokens := TStringList.Create;
  aAccFiles.LoadFromFile('c:\acc_info.txt');

  try
    for i := 0 to aAccFiles.Count-1 do
    begin
      GetTokens(aAccFiles[i], aTokens, ',');
      //
      aAccount := FDBAccounts.Add as TDBAccountItem;
      aAccount.AccountCode := aTokens[2];
      aAccount.Broker := aTokens[1];
      aAccount.Desc := aTokens[0];
      aAccount.LossCut := StrToInt(aTokens[3]);
      aAccount.LosscutAlertRatio := StrToFloat(aTokens[4]);
      aAccount.StartDate := StrToFloat(aTokens[5]);
      aAccount.Equity_Value := StrToFloat(aTokens[6]);
      aAccount.AccPL := StrToFloat(aTokens[7]);

      {
      aAccount.LossCut := ADOQuery1.FieldByName('losscut').AsInteger;
      aAccount.LossCutAlertRatio := ADOQuery1.FieldByName('losscut_warning').AsFloat;

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s order by dateM asc', [aAccount.AccountCode]);
      ADOQuery2.Open;
      ADOQuery2.First;
      aAccount.StartDate := ADOQuery2.FieldByName('dateM').AsDateTime;



      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s order by dateM desc', [aAccount.AccountCode]);
      ADOQuery2.Open;
      ADOQuery2.First;

      dValue := ADOQuery2.FieldByName('ref_capital').AsFloat;
      aAccount.Equity_Value := dValue;

      dValue := ADOQuery2.FieldByName('AccPL').AsFloat;
      aAccount.AccPL := dValue;

      aAccount.LastUpdateDate := ADOQuery2.FieldByName('dateM').AsDateTime;

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s and Month(dateM)=%d and year(dateM)=%d order by dateM desc', [aAccount.AccountCode, wMonth, wYear]);
      ADOQuery2.Open;
      aAccount.PrevMonthLastPrice := ADOQuery2.FieldByName('AccPL').AsFloat;
      //



            //
      dYearMonth2 := Now;
      dYearMonth2 := IncMonth(dYearMonth2, -2);
      DecodeDate(dYearMonth2, wYear2, wMonth2, wDay2);

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s and Month(dateM)=%d and year(dateM)=%d order by dateM desc', [aAccount.AccountCode, wMonth2, wYear2]);
      ADOQuery2.Open;
      aAccount.PrevMonth2LastPrice := ADOQuery2.FieldByName('AccPL').AsFloat;

      //
      dYearMonth2 := Now;
      dYearMonth2 := IncMonth(dYearMonth2, -3);
      DecodeDate(dYearMonth2, wYear2, wMonth2, wDay2);

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s and Month(dateM)=%d and year(dateM)=%d order by dateM desc', [aAccount.AccountCode, wMonth2, wYear2]);
      ADOQuery2.Open;
      aAccount.PrevMonth3LastPrice := ADOQuery2.FieldByName('AccPL').AsFloat;
      }


    end;

  (*
  dYearMonth := Now;

  dYearMonth := IncMonth(dYearMonth, -1);
  DecodeDate(dYearMonth, wYear, wMonth, wDay);


  ADOQuery1.SQL.Text := 'select * from xe_cn_accounts';//'select * from xe_cn_accounts order by broker';
  ADOQuery1.Open;

  //ShowMessage('open count='+ IntToStr(ADOQuery1.RecordCount));

  ADOQuery1.First;

  while (not ADOQuery1.Eof) do
  begin
    try
      if CompareText(ADOQuery1.FieldByName('active').AsString, 'N') = 0 then
        continue;
      //
      aAccount := FDBAccounts.Add as TDBAccountItem;
      aAccount.AccountCode := ADOQuery1.FieldByName('account_no').AsString;
      aAccount.Desc := ADOQuery1.FieldByName('account_name').AsString;//ADOQuery1.FieldByName('broker').AsString;
      aAccount.Broker := ADOQuery1.FieldByName('broker').AsString;
      //aAccount.Init_Capital := ADOQuery1.FieldByName('init_capital').AsFloat;
      aAccount.LossCut := ADOQuery1.FieldByName('losscut').AsInteger;
      aAccount.LossCutAlertRatio := ADOQuery1.FieldByName('losscut_warning').AsFloat;

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s order by dateM asc', [aAccount.AccountCode]);
      ADOQuery2.Open;
      ADOQuery2.First;
      aAccount.StartDate := ADOQuery2.FieldByName('dateM').AsDateTime;



      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s order by dateM desc', [aAccount.AccountCode]);
      ADOQuery2.Open;
      ADOQuery2.First;

      dValue := ADOQuery2.FieldByName('ref_capital').AsFloat;
      aAccount.Equity_Value := dValue;

      dValue := ADOQuery2.FieldByName('AccPL').AsFloat;
      aAccount.AccPL := dValue;

      aAccount.LastUpdateDate := ADOQuery2.FieldByName('dateM').AsDateTime;

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s and Month(dateM)=%d and year(dateM)=%d order by dateM desc', [aAccount.AccountCode, wMonth, wYear]);
      ADOQuery2.Open;
      aAccount.PrevMonthLastPrice := ADOQuery2.FieldByName('AccPL').AsFloat;
      //



            //
      dYearMonth2 := Now;
      dYearMonth2 := IncMonth(dYearMonth2, -2);
      DecodeDate(dYearMonth2, wYear2, wMonth2, wDay2);

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s and Month(dateM)=%d and year(dateM)=%d order by dateM desc', [aAccount.AccountCode, wMonth2, wYear2]);
      ADOQuery2.Open;
      aAccount.PrevMonth2LastPrice := ADOQuery2.FieldByName('AccPL').AsFloat;

      //
      dYearMonth2 := Now;
      dYearMonth2 := IncMonth(dYearMonth2, -3);
      DecodeDate(dYearMonth2, wYear2, wMonth2, wDay2);

      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Text := Format('select * from xe_cn_acc_money where account=%s and Month(dateM)=%d and year(dateM)=%d order by dateM desc', [aAccount.AccountCode, wMonth2, wYear2]);
      ADOQuery2.Open;
      aAccount.PrevMonth3LastPrice := ADOQuery2.FieldByName('AccPL').AsFloat;

    finally
      ADOQuery1.Next;
    end;
  end;
  *)
  finally
    aTokens.Free;
    aAccFiles.Free;
  end;
end;

function TForm1.FindDBAccount(stAccount: String): TDBAccountItem;
var
  i : Integer;
  aAccount: TDBAccountItem;
begin
  //
  Result := nil;
  //
  for i := 0 to FDBAccounts.Count-1 do
  begin
    aAccount := FDBAccounts.Items[i] as TDBAccountItem;
    //
    if aAccount.AccountCode = stAccount then
    begin
      Result := aAccount;
      Break;
    end;

  end;
end;

function TBroker.FindAccount(stValue: String): TAccountItem;
var
  i : Integer;
  aAccount : TAccountItem;
begin
  Result := nil;
  //
  for i := 0 to Accounts.Count-1 do
  begin
    aAccount := Accounts.Items[i] as TAccountItem;
    //
    if (UpperCase(Trim(aAccount.Code)) = UpperCase(Trim(stValue))) then
    begin
      Result := aAccount;
      Break;
    end

  end;
end;

{ TDBAccountItem }



procedure TForm1.TimerProc(Sender: TObject);
var
  i, j : Integer;
  aBroker : TBroker;
  aAccount : TAccountItem;
  dNow : TDateTime;
begin
  //
  ButtonRefresh.Click;
  //

  for i := 0 to FBrokers.Count-1 do
  begin
    aBroker := FBrokers.Items[i] as TBroker;
    //
    for j := 0 to aBroker.Accounts.Count-1 do
    begin
      aAccount := aBroker.Accounts.Items[j] as TAccountItem;
      //
      if ((aAccount.RiskAlertedTime > 0) and (aAccount.EnableAlert)) then

      begin
        dNow := Frac(Now);
        {
        if ((dNow - Frac(aAccount.RiskAlertedTime)) > EncodeTime(0, 0, 59, 0)) then
        }
        begin
          PlaySoundFile(FRiskAlertedSound);
          StatusViewer.AttachTime := True;
          StatusViewer.AddMessage(Format('%s touched Daily Loss', [aAccount.Desc]));

        end;
      end;

      if ((aAccount.LosscutAlertedTime > 0) and (aAccount.EnableAlert)) then
      begin
        PlaySoundFile(FRiskAlertedSound);
        StatusViewer.AttachTime := True;
        StatusViewer.AddMessage(Format('%s touched the loss-cut limit', [aAccount.Desc]));
      end;


    end;

  end;
end;

procedure TForm1.ButtonStartTimerClick(Sender: TObject);
begin
  if ButtonStartTimer.Down then
  begin
    FTimer.Enabled := True;
    FTimer.Interval := StrToInt(EditRefreshInterval.Text)*1000;
  end else
    FTimer.Enabled := False;
end;

{ TAccountItem }

constructor TAccountItem.Create(aColl: TCollection);
begin
  inherited Create(aColl);
  //
  Positions := TStringList.Create;

  RiskAlertedTime := -1;
  LosscutAlertedTime := -1;

  EnableAlert := True;

end;

destructor TAccountItem.Destroy;
begin
  Positions.Free;
  inherited;
end;

procedure TForm1.CloneSymbolArray(aStrings: TStrings);
var
  i : Integer;
begin
  aStrings.Clear;
  //
  for i := 0 to FSymbols.Count-1 do
    aStrings.Add('0');
end;

function TForm1.FindSymbol(stSymbol: String): Integer;
var
  i : Integer;
begin
  Result := -1;
  //
  Result := FSymbols.IndexOf(UpperCase(Trim(stSymbol)));

end;

procedure TForm1.RefreshPositions;
var
  i, iP, j, k : Integer;
  aBroker : TBroker;
  aAccount : TAccountItem;
begin
  GridPositions.RowCount := 2;
  //
  with GridPositions do
  begin
    Cells[0, 0] := 'Account';
    for i := 0 to FSymbols.Count-1 do
      Cells[i+1, 0] := FSymbols[i];
  end;

  iP := 1;
  for i := 0 to FBrokers.Count-1 do
  begin
    aBroker := FBrokers.Items[i] as TBroker;
    //
    GridPositions.RowCount := iP+1;
    GridPositions.Objects[0, iP] := aBroker;
    GridPositions.Cells[0, iP] := aBroker.BrokerName;

    Inc(iP);
    //
    for j := 0 to aBroker.Accounts.Count-1 do
    begin
      aAccount := aBroker.Accounts.Items[j] as TAccountItem;
      //
      GridPositions.RowCount := iP+1;
      GridPositions.Objects[0, iP] := aAccount;
      GridPositions.Cells[0, iP] := aAccount.Desc;//aAccount.Code;


      for k := 0 to aAccount.Positions.Count-1 do
      begin
        GridPositions.Cells[k+1, iP] := aAccount.Positions[k];
      end;

      Inc(iP);


    end;

  end;


end;

procedure TForm1.GridPositionsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;
  stValue : String;
  aRowRect : TRect;
  i : Integer;
  aBroker : TBroker;
begin
  with GridPositions.Canvas do
  begin
    Font.Name := GridPositions.Font.Name;
    Font.Size := GridPositions.Font.Size;
    //
    stText := GridPositions.Cells[ACol, ARow];
    if gdFixed in State then
    begin
      Brush.Color := clBtnFace;//FIXED_COLOR;
      Font.Color := clBlack;
      aAlignment := taLeftJustify;
    end else
    begin
      if stText = '' then
       Brush.Color := clWhite//NODATA_COLOR
      else if gdSelected in State then
        Brush.Color := SELECTED_COLOR2
      else
        Brush.Color := clWhite;

      Font.Color := clBlack;
      if (ACol <> 0) and (stText <> '') then
      begin
        //stValue := StringReplace(stText, ',', '', [rfReplaceAlll]);
        if stText[1] = '-' then
          Font.Color := clBlue
        else if stText = '0' then
          Font.Color := clBlack
        else
          Font.Color := clRed;

      end;



      aAlignment := taRightJustify;

      if ACol in [0] then
        aAlignment := taLeftJustify;


    end;
    //-- background
    if GridAccounts.Objects[0, ARow] is TBroker then
    begin
      aBroker := GridAccounts.Objects[0, ARow] as TBroker;
      //
      aRowRect.Top := Rect.Top;
      aRowRect.Bottom := Rect.Bottom;
      aRowRect.Left := GridAccounts.CellRect(0, AROW).Left;
      aRowRect.Right := GridAccounts.CellRect(0, AROW).Right;

      for i := 1 to GridAccounts.ColCount-1 do
      begin
        aRowRect.Right := GridAccounts.CellRect(i, AROW).Right;

      end;
      Brush.Color := EVEN_COLOR;//clLtGray;
      FillRect(aRowRect);
      stText := aBroker.BrokerName;
      //-- text
      if stText = '' then Exit;
      //-- calc position

      aSize := TextExtent(stText);
      iY := aRowRect.Top + (aRowRect.Bottom - aRowRect.Top - aSize.cy) div 2;
      iX := aRowRect.Left + (aRowRect.Right-aRowRect.Left-aSize.cx) div 2;
      //-- put text
      iX := aRowRect.Left + (aRowRect.Right-aRowRect.Left-aSize.cx) div 2;
      {
      case aAlignment of
        //taLeftJustify :  iX := aRowRect.Left + 2;
        //taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
        //taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx;
      end;
      }
      TextRect(aRowRect, iX, iY, stText);

    end else
    begin
      FillRect(Rect);
      //-- text
      if stText = '' then Exit;
      //-- calc position
      aSize := TextExtent(stText);
      iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
      iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      //-- put text
      case aAlignment of
        taLeftJustify :  iX := Rect.Left + 2;
        taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
        taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx;
      end;
      TextRect(Rect, iX, iY, stText);
    end;
  end;

end;

function DBAccountSortProc(Item1, Item2: Pointer): Integer;
var
  aAcc, aAcc2 : TDBAccountItem;
begin
  Result := CompareStr(TDBAccountItem(Item1).Broker, TDBAccountItem(Item2).Broker);
  if Result = 0 then
  begin
    Result := Round(TDBAccountItem(Item1).StartDate - TDBAccountItem(Item2).StartDate);
  end;

end;

procedure TForm1.RefreshDBAccounts;
var
  i, iP : Integer;
  aDBAccountList : TList;
  aDBAccount : TDBAccountItem;

begin
  GridAccounts.RowCount := 2;
  GridAccounts.ColCount := 7;

  aDBAccountList := TList.Create;
  //
  for i := 0 to FDBAccounts.Count-1 do
    aDBAccountList.Add(FDBAccounts.Items[i]);

  aDBAccountList.Sort(@DBAccountSortProc);

  try
    //for i := 0 to FDBAccounts.Count-1 do
    //  aDBAccountList.Add(FDBAccounts.Items[i]);
    //


    GridAccounts.RowCount := FDBAccounts.Count+1;
    //

    iP := 1;
    with GridAccounts do
    begin
      for i := 0 to aDBAccountList.Count-1 do
      begin
        aDBAccount := TDBAccountItem(aDBAccountList.Items[i]);
        //

        GridAccounts.Cells[0, iP] := aDBAccount.Desc;
        GridAccounts.Cells[1, iP] := aDBAccount.Broker;
        GridAccounts.Cells[2, iP] := Format('%.2f',[aDBAccount.AccPL*100]);
        GridAccounts.Cells[3, iP] := Format('%.2f',[aDBAccount.PrevMonthLastPrice*100]);
        if not IsZero(aDBAccount.PrevMonthLastPrice) then
        GridAccounts.Cells[4, iP] := Format('%.2f', [aDBAccount.AccPL / aDBAccount.PrevMonthLastPrice]);

        GridAccounts.Cells[5, iP] := FormatDateTime('yy//mm/dd', aDBAccount.StartDate);
        GridAccounts.Cells[6, iP] := IntToStr(Round(Now-aDBAccount.StartDate));


        Inc(iP);

      end;
    end;
  finally
    aDBAccountList.Free;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  RefreshDBAccounts;
end;

procedure TForm1.QueryBrokers;
begin
  //ADOQuery1.SQL.Text := 'select * from xe_cn_accounts';

end;

procedure TForm1.InitControls;
begin
  {
  GridAccounts.ColWidths[1] := 50;
  GridAccounts.ColWidths[4] := 0;
  GridAccounts.ColWidths[5] := 60;
  GridAccounts.ColWidths[6] := 40;
  GridAccounts.ColWidths[8] := 40;
  GridAccounts.ColWidths[9] := 40;
  GridAccounts.ColWidths[10] := 40;
  GridAccounts.ColWidths[11] := 100;
  GridAccounts.ColWidths[12] := 60;
  GridAccounts.ColWidths[14] := 40;
  GridAccounts.ColWidths[15] := 40;
  }
end;

procedure TForm1.ButtonMailClick(Sender: TObject);
var
  i : Integer;
  amsg : tidmessage;
  aBitmap : TBitmap;

  hHandle : HWND;
  DC : HDC;
  W, H : Integer;

  aJPG : TJPEGImage;

attach :     TIdAttachment;
  txtPart : TIdText;

begin

  aBitmap := TBitmap.Create;
  aJPG := TJPEGImage.Create;



  hHandle := Handle;

  DC := GetWindowDC(hHandle);


  aBitmap.Width := Width;
  aBitmap.Height := Height;

  try

    BitBlt(aBitmap.Canvas.Handle, 0, 0, aBitmap.Width, aBitmap.Height, DC, 0, 0, SRCCOPY);

    aJPG.Assign(aBitmap);
    aJPG.CompressionQuality := 30;


    aJPG.SaveToFile(FApplicationPath + '\aa.jpg');
  finally
    ReleaseDC(hHandle, DC);
    aBitmap.Free;
    aJPG.Free;
  end;
  






//IdSMTP1.H
//IdMessage1.From.Text := 'sms2@thegosu.com';
//IdMessage1.ReplyTo.EMailAddresses := 'sms2@thegosu.com';
  //IdMessage1.Recipients.EMailAddresses := 'sms@thegosu.com';

  with IdMessage1 do
  begin
  Subject := 'CHN Account Viewer '+FormatDateTime(' (yy-mm-dd hh:nn) ', Now);
  Priority := mpNormal;
  //Body[0] := '자동으로 만들어짐';
  CCList.EMailAddresses := '';
  BccList.EMailAddresses := '';
  //ReceiptRecipient.Text := 'sms@thegosu.com';

    Recipients.Clear;
    //Recipients.Assign(FMailingList);

    for i := 0 to FMailingList.Count-1 do
      with Recipients.Add do
        Text := FMailingList[i];

    {
    with Recipients.Add do
      Text := 'sms@thegosu.com';
    with Recipients.Add do
      Text := 'sky@thegosu.com';
    }

    CharSet := 'euc-kr';
    ContentType := 'text/html';

end;


  IdMessage1.MessageParts.Clear;
  attach := TIdAttachment.Create(IdMessage1.MessageParts, FApplicationPath + '\aa.jpg');
  attach.ContentType := 'image/jpeg';

  txtPart := TidText.Create(IdMessage1.MessageParts);
  txtPart.ContentType := 'text/plain';
  txtPart.Body.Text := 'automatic mail sending';
//'automatic creation';//'자동으로 만들어짐';



IdSMTP1.AuthenticationType := atnone;
IdSMTP1.Connect;
try
IdSMTP1.Send(IdMessage1);
//IdSMTP1.ProcessMessage(IdMessage1, 'C:\AA.BMP');
finally
  IdSMTP1.Disconnect;
end;





end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  FLoadingPath := EditBroker.Text;
end;

procedure TForm1.MailingTimerProc(Sender: TObject);
var
  i : Integer;
  aMailingItem : TMailingTimes;
  wHour, wMin, wSec, wMSec : Word;
  iMMIndex, iPrevMMIndex, iMailingIndex : Integer;
begin
  //
  if FAutoMailing=False then Exit;
  //
  DecodeTime(Now, wHour, wMin, wSec, wMSec);

  try
  //
  iMMIndex := wHour * 60 * 60 + wMin * 60 + wSec;
  iPrevMMIndex := FPrevHour * 60 * 60 + FPrevMin * 60 + FPrevSec;
  if iPrevMMIndex < 1 then Exit;
  //
  for i := 0 to FMailingTimes.Count-1 do
  begin
    aMailingItem := FMailingTimes.Items[i] as TMailingTimes;
    //
    iMailingIndex := aMailingItem.CheckHour * 60 * 60 + aMailingItem.CheckMin * 60 + aMailingItem.CheckSecond;

    if (iMailingIndex <= iMMIndex) and (iMailingIndex > iPrevMMIndex) then
    begin
      ButtonMail.Click;
    end;


  end;


  finally
  FPrevHour := wHour;
  FPrevMin := wMin;
  FPrevSec := wSec;
  end;

end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  i : Integer;
  aDlg : TSetupDialog;
begin
  aDlg := TSetupDialog.Create(Self);

  try
    aDlg.CheckAutoMailing.Checked := FAutoMailing;
    aDlg.EditLoadingPath.Text := FLoadingPath;
    aDlg.MemoMailingList.Lines.Assign(FMailingList);
    aDlg.EditAlertSound.Text := FRiskAlertedSound;
    //

    //FMailingTimes.Count

    if aDlg.ShowModal = mrOk then
    begin
      FLoadingPath := aDlg.EditLoadingPath.Text;
      FAutoMailing := aDlg.CheckAutoMailing.Checked;
      FMailingList.Assign(aDlg.MemoMailingList.Lines);
      FRiskAlertedSound := aDlg.EditAlertSound.Text;
    end;

  finally
    aDlg.Free;
  end;
  //SetupDialog.Visible := True;
end;

procedure TForm1.ButtonReconnectDBClick(Sender: TObject);
begin
  QueryCNDBAccounts;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  StatusViewer.FontSize := 12;
  StatusViewer.FontStyles := [fsBold];

  StatusViewer.Show;
end;


function AccountSort(Item1, Item2: Pointer): Integer;
var
  aAccount1, aAccount2 : TAccountItem;
  dValue1, dValue2 : Double;
begin
  Result := 0;
  //

  aAccount1 := TAccountItem(Item1);
  aAccount2 := TAccountItem(Item2);
  //

  //
  if (aAccount1 = nil) or (aAccount2 = nil) then Exit;

  dValue1 := aAccount1.AccPL*100+aAccount1.Losscut;
  dValue2 := aAccount2.AccPL*100+aAccount2.Losscut;

  Result := Round((dValue1 - dValue2)*1000);
  {
  if (dValue1 > dValue2) then
    Result := 1
  else
    Result := -1;
  }
  Exit;

  //sult := Round((aAccount1.AccPL*100+aAccount1.Losscut) - (aAccount2.AccPL*100+aAccount2.Losscut));
end;

procedure TForm1.RefreshAccountsByProfit(aAccList: TList);
//const
//  ALERT_CONDITION = -3.5;
var
  i, iP, j : Integer;
  aBroker : TBroker;
  aAccount : TAccountItem;
  dExpected : Double;

  //aAccList : TList;




begin
  GridAccounts.RowCount := 2;
  //
  //GridAccounts.ColCount := 14;

  GridAccounts.Cells[1, 0] := 'Account';
  GridAccounts.Cells[2, 0] := 'Deposit';
  GridAccounts.Cells[3, 0] := 'DailyPL';
  GridAccounts.Cells[4, 0] := 'Liquid';
  GridAccounts.Cells[5, 0] := 'R-Liquid %';
  GridAccounts.Cells[6, 0] := 'Fees';
  GridAccounts.Cells[7, 0] := 'capital';
  GridAccounts.Cells[8, 0] := 'DailyPL %';
  GridAccounts.Cells[9, 0] := 'AccPL %';
  GridAccounts.Cells[10, 0] := 'Expected %';
  GridAccounts.Cells[11, 0] := 'Losscut %';
  GridAccounts.Cells[12, 0] := 'Remain-Losscut %';
  GridAccounts.Cells[13, 0] := 'Update time';
  GridAccounts.Cells[14, 0] := 'DB Update time';
  GridAccounts.Cells[15, 0] := 'Start Date';
  GridAccounts.Cells[16, 0] := 'Monthly';
  GridAccounts.Cells[17, 0] := 'M-Days';


  //aAccList := TList.Create;
  aAccList.Clear;

  try
    for i := 0 to FBrokers.Count-1 do
    begin
      aBroker := FBrokers.Items[i] as TBroker;
      //
      //
      for j := 0 to aBroker.Accounts.Count-1 do
      begin
        aAccount := aBroker.Accounts.Items[j] as TAccountItem;
        aAccList.Add(aAccount);
      end;
    end;

    aAccList.Sort(@AccountSort);

    iP := 1;
    for i := 0 to aAccList.Count-1 do
    begin
      aAccount := TAccountItem(aAccList.Items[i]);

      GridAccounts.RowCount := iP+1;
      GridAccounts.Objects[0, iP] := aAccount;
      UpdateAccount(iP);
      (*
      GridAccounts.Cells[0, iP] := aAccount.Code;
      GridAccounts.Cells[1, iP] := aAccount.Desc;
      GridAccounts.Cells[2, iP] := Format('%.0n', [aAccount.DepositTotal]);
      GridAccounts.Cells[3, iP] := Format('%.0n', [aAccount.DailyPL]);
      GridAccounts.Cells[4, iP] := Format('%.0n', [aAccount.LiquidTotal]);

      if not IsZero(aAccount.EquityValue) then
        GridAccounts.Cells[5, iP] := Format('%.0f%%', [100-aAccount.LiquidTotal/aAccount.EquityValue*100]);
      GridAccounts.Cells[6, iP] := Format('%.0n', [aAccount.Commission]);
      GridAccounts.Cells[7, iP] := Format('%.0n', [aAccount.EquityValue]);
      if not IsZero(aAccount.EquityValue) then
      begin
        GridAccounts.Cells[8, iP] := Format('%.2f%%', [aAccount.DailyPL / aAccount.EquityValue * 100]);
        if aAccount.DailyPL / aAccount.EquityValue * 100 < ALERT_CONDITION then
          aAccount.RiskAlertedTime := Now;
      end;

      GridAccounts.Cells[9, iP] := Format('%.2n', [aAccount.AccPL*100]);

      dExpected := aAccount.AccPL*100+aAccount.DailyPL / aAccount.EquityValue * 100;
      if not IsZero(aAccount.EquityValue) then
        GridAccounts.Cells[10, iP] := Format('%.2n', [dExpected]);

      GridAccounts.Cells[12, iP] := Format('%f', [(dExpected+aAccount.Losscut)]);
      GridAccounts.Cells[11, iP] := IntToStr(aAccount.Losscut);

      GridAccounts.Cells[13, iP] := FormatDateTime('yy/mm/dd hh:nn', aAccount.UpdateTime);

      GridAccounts.Cells[14, iP] := FormatDateTime('yy/mm/dd', aAccount.DBUpdateTime);
      GridAccounts.Cells[15, iP] := FormatDateTime('yy/mm/dd', aAccount.StartDate);

      GridAccounts.Cells[16, iP] :=
        Format('%.2f',[(aAccount.AccPL-aAccount.MonthlyLastPrices[0])/(aAccount.MonthlyLastPrices[0]+1)*100]);

      GridAccounts.Cells[17, iP] := IntToStr(Floor(Now- aAccount.StartDate));
      *)
      Inc(iP);


    end;
  finally
    //aAccList.Free;
  end;


  Exit;


  iP := 1;
  for i := 0 to FBrokers.Count-1 do
  begin
    aBroker := FBrokers.Items[i] as TBroker;
    //
    GridAccounts.RowCount := iP+1;
    GridAccounts.Objects[0, iP] := aBroker;
    GridAccounts.Cells[0, iP] := aBroker.BrokerName;

    Inc(iP);
    //
    for j := 0 to aBroker.Accounts.Count-1 do
    begin
      aAccount := aBroker.Accounts.Items[j] as TAccountItem;
      //

      try
      GridAccounts.RowCount := iP+1;
      GridAccounts.Objects[0, iP] := aAccount;

      UpdateAccount(iP);
      (*
      GridAccounts.Cells[0, iP] := aAccount.Code;
      GridAccounts.Cells[1, iP] := aAccount.Desc;
      GridAccounts.Cells[2, iP] := Format('%.0n', [aAccount.DepositTotal]);
      GridAccounts.Cells[3, iP] := Format('%.0n', [aAccount.DailyPL]);
      GridAccounts.Cells[4, iP] := Format('%.0n', [aAccount.LiquidTotal]);

      if not IsZero(aAccount.EquityValue) then
        GridAccounts.Cells[5, iP] := Format('%.0f%%', [100-aAccount.LiquidTotal/aAccount.EquityValue*100]);
      //수수료
      GridAccounts.Cells[6, iP] := Format('%.0n', [aAccount.Commission]);
      //capital
      GridAccounts.Cells[7, iP] := Format('%.0n', [aAccount.EquityValue]);

      //DailyPL
      if not IsZero(aAccount.EquityValue) then
      begin
        aAccount.LastDailyPL := aAccount.DailyPL / aAccount.EquityValue * 100;
        GridAccounts.Cells[8, iP] := Format('%.2f%%', [aAccount.LastDailyPL]);
        if aAccount.LastDailyPL < ALERT_CONDITION then
        begin
          aAccount.RiskAlertedTime := Now;
          StatusViewer.AddMessage(aAccount.Desc + 'touched daily max loss');
        end;
      end;

      GridAccounts.Cells[9, iP] := Format('%.2n', [aAccount.AccPL*100]);

      dExpected := aAccount.AccPL*100+aAccount.DailyPL / aAccount.EquityValue * 100;
      if not IsZero(aAccount.EquityValue) then
        GridAccounts.Cells[10, iP] := Format('%.2n', [dExpected]);

      GridAccounts.Cells[12, iP] := Format('%f', [(dExpected+aAccount.Losscut)]);
      GridAccounts.Cells[11, iP] := IntToStr(aAccount.Losscut);

      GridAccounts.Cells[13, iP] := FormatDateTime('yy/mm/dd hh:nn', aAccount.UpdateTime);

      GridAccounts.Cells[14, iP] := FormatDateTime('yy/mm/dd', aAccount.DBUpdateTime);
      GridAccounts.Cells[15, iP] := FormatDateTime('yy/mm/dd', aAccount.StartDate);

      GridAccounts.Cells[16, iP] :=
        Format('%.2f',[(aAccount.AccPL-aAccount.MonthlyLastPrices[0])/(aAccount.MonthlyLastPrices[0]+1)*100]);

      GridAccounts.Cells[17, iP] := IntToStr(Floor(Now- aAccount.StartDate));
      *)

      {
      GridAccounts.Cells[15, iP] :=
        Format('%.f',[(aAccount.MonthlyLastPrices[0]*100)]);
      }
      Inc(iP);

      except
      end;

    end;

  end;


end;

procedure TForm1.UpdateAccount(iP: Integer);
var
  aAccount : TAccountItem;
  dExpected : Double;
begin
  aAccount := GridAccounts.Objects[0, iP] as TAccountItem;
  GridAccounts.Cells[0, iP] := aAccount.Code;
  GridAccounts.Cells[1, iP] := aAccount.Desc;
  GridAccounts.Cells[2, iP] := Format('%.0n', [aAccount.DepositTotal]);
  GridAccounts.Cells[3, iP] := Format('%.0n', [aAccount.DailyPL]);
  GridAccounts.Cells[4, iP] := Format('%.0n', [aAccount.LiquidTotal]);

  if not IsZero(aAccount.EquityValue) then
    GridAccounts.Cells[5, iP] := Format('%.0f%%', [100-aAccount.LiquidTotal/aAccount.EquityValue*100]);
  //수수료
  GridAccounts.Cells[6, iP] := Format('%.0n', [aAccount.Commission]);
  //capital
  GridAccounts.Cells[7, iP] := Format('%.0n', [aAccount.EquityValue]);
  //estimate
  GridAccounts.Cells[8, iP] := Format('%.0n', [aAccount.EstimateDeposit]);

  //DailyPL
  if not IsZero(aAccount.EquityValue) then
  begin
    aAccount.LastDailyPL := aAccount.DailyPL / aAccount.EquityValue * 100;
    GridAccounts.Cells[9, iP] := Format('%.2f%%', [aAccount.LastDailyPL]);
   if ((aAccount.AccPL < 0.1) and (aAccount.LastDailyPL < ALERT_CONDITION)) or
       ((aAccount.AccPL >= 0.1) and (aAccount.LastDailyPL < ALERT_CONDITION2)) then
      begin
        aAccount.RiskAlertedTime := Now;
        //StatusViewer.AddMessage(aAccount.Desc + ' touched daily max loss');
      end;
  end;

  GridAccounts.Cells[10, iP] := Format('%.2n', [aAccount.AccPL*100]);

  dExpected := aAccount.AccPL*100+aAccount.DailyPL / aAccount.EquityValue * 100;
  if not IsZero(aAccount.EquityValue) then
  begin
    GridAccounts.Cells[11, iP] := Format('%.2n', [dExpected]);
    if dExpected < aAccount.LosscutAlertRatio * -1 then
    begin
      aAccount.LosscutAlertedTime := Now;
      StatusViewer.AddMessage(Format('Account:%s/expect:%f/limit:%f', [aAccount.Desc, dExpected, aAccount.LosscutAlertRatio]));
    end;
  end;

  GridAccounts.Cells[13, iP] := Format('%f', [(dExpected+aAccount.Losscut)]);
  GridAccounts.Cells[12, iP] := IntToStr(aAccount.Losscut);

  GridAccounts.Cells[14, iP] := FormatDateTime('yy/mm/dd hh:nn', aAccount.UpdateTime);

  GridAccounts.Cells[15, iP] := FormatDateTime('yy/mm/dd', aAccount.DBUpdateTime);
  GridAccounts.Cells[16, iP] := FormatDateTime('yy/mm/dd', aAccount.StartDate);

  GridAccounts.Cells[17, iP] :=
    Format('%.2f',[(aAccount.AccPL-aAccount.MonthlyLastPrices[0])/(aAccount.MonthlyLastPrices[0]+1)*100]);

  GridAccounts.Cells[18, iP] := IntToStr(Floor(Now- aAccount.StartDate));





end;

procedure TForm1.UnableAlertmessage1Click(Sender: TObject);
var
  aAccount : TAccountItem;
begin
  aAccount := GridAccounts.Objects[0, GridAccounts.Row] as TAccountItem;
  //
  if aAccount = nil then Exit;
  //
  aAccount.EnableAlert := not aAccount.EnableAlert;

  //RefreshAccounts;

end;

procedure TForm1.InitFields;
begin

end;

function TForm1.FindBroker(stValue: String): TBroker;
var
  i : Integer;
  aBroker : TBroker;
begin
  Result := nil;
  //
  for i := 0 to FBrokers.Count-1 do
  begin
    aBroker := FBrokers.Items[i] as TBroker;
    //
    if UpperCase(Trim(aBroker.BrokerName)) = UpperCase(Trim(stValue)) then
    begin
      Result := aBroker;
      Break;
    end;
  end;
end;

procedure TForm1.RefreshPositionsByProfit(aAccList: TList);
var
  i, iP, j, k : Integer;
//  aBroker : TBroker;
  aAccount : TAccountItem;
begin
  GridPositions.RowCount := 2;
  //
  with GridPositions do
  begin
    Cells[0, 0] := 'Account';
    for i := 0 to FSymbols.Count-1 do
      Cells[i+1, 0] := FSymbols[i];
  end;

  iP := 1;

  for i := 0 to aAccList.Count-1 do
  begin
    aAccount := TAccountItem(aAccList.Items[i]);
    //
    GridPositions.RowCount := iP+1;
    GridPositions.Objects[0, iP] := aAccount;
    GridPositions.Cells[0, iP] := aAccount.Desc;




    for j := 0 to aAccount.Positions.Count-1 do
    begin
      GridPositions.Cells[j+1, iP] := aAccount.Positions[j];
    end;


    //GridPositions.RowCount := iP+1;

    Inc(iP);
    //



  end;


end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i, j : Integer;
  aBroker : TBroker;
  aAccount : TAccountItem;
  dTotal : Double;
begin
  aBroker := FindBroker('Huayuan');
  //
  dTotal := 0;
  if aBroker <> nil then
  begin
    for j := 0 to aBroker.Accounts.Count-1 do
    begin
      aAccount := TAccountItem(aBroker.Accounts.Items[j]);
      //
      if aAccount.Code <> '7090219' then
        dTotal := dTotal + aAccount.EstimateDeposit;

    end;
  end;

  StatusViewer.AddMessage('GICC TOTAL estimated deposit =='+Format('%.0n', [dTotal]));

end;

end.



--이메일 보내는 방법이 잘 구현된게 없어서 올립니다.
--델마당과 다른 사이트를 참고해서 조합해서 만들었습니다.
--함수형식입니다. 사용하시면서 개선사항 있으면 올려주세요


function IdSMTP_Mail(const Server: String; const Port: Integer;const
   UserField, PasswordField: String; FromField, ToField, SubjectField, CompanyField,
   TextField: WideString; FileNames: TStringList): String;
 //uses IdSMTP, IdMessage; <=요거 유스절에 선언하세요!
var
   IdSMTP: TIdSMTP;
   IdMessage: TIdMessage;
   aFileList:TStringList;
   atc:TIdAttachment;

  txtpart : TIdText;
   htmpart : TIdText;
   UTFString : UTF8string;
   i:Integer;
 begin
   Result:='';
   IdSMTP := TIdSMTP.Create(nil);
   IdSMTP.AuthenticationType := atLogin; // 로그인 방식
  IdSMTP.Host     := Server;
   IdSMTP.Port     := Port;
   IdSMTP.Username:=UserField;
   IdSMTP.Password:=PasswordField;

  IdMessage := TIdMessage.Create(nil);

  IdMessage.CharSet := 'euc-kr';
   IdMessage.Headers.Text := 'Content-type: text/html';
   IdMessage.ContentType := 'text/html';

  IdMessage.From.Address := FromField; // 보내는사람
  IdMessage.Recipients.EMailAddresses := ToField;//받는사람
  IdMessage.Subject   := SubjectField; // 제목
  IdMessage.Body.Add(TextField);

 

  if FileNames<>nil then begin
      if FileNames.Count>0 then begin
         For i:=0 to FileNames.Count-1 do begin
            TIdAttachment.Create(IdMessage.MessageParts, Trim(FileNames.Strings[i]));
         end;
         txtpart := TIdText.Create(IdMessage.MessageParts);
         txtpart.ContentType := 'text/plain'; 
         htmpart := TIdText.Create(IdMessage.MessageParts);
         // Attachments Case By Mime Type -> chartset - UTF-8 인코딩해서 보낸다 (변환필수) 핵심
        UTFString := UTF8Encode(WideString(TextField));   // <--- delphi 7 version 함수
        htmpart.Body.Add(UTFString);
         htmpart.ContentType := 'text/html';
      end;
   end;
   Try
     IdSMTP.Connect;
     IdSMTP.Send(IdMessage);
   Except on E:Exception do begin
     Result:='메일전송중 오류발생!'+#13+E.Message;
   end; end;
   if FileNames.Count>0 then begin
      txtpart.Free;
      htmpart.Free;
   end;
   IdSMTP.Disconnect;
   IdSMTP.Free;
   IdMessage.Free;
   IdSMTP:=nil;
   IdMessage:=nil;
 end;



