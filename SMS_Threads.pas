unit SMS_Threads;

interface

uses
  Classes, SyncObjs;

type

  TSMSThread = class(TThread)
  private
    FOnSMSTerminated: TNotifyEvent;
  public
    property OnSMSTerminated : TNotifyEvent read FOnSMSTerminated write FOnSMSTerminated;
  end;

  TSMSThreadList = class
  private
    FThreadList : TList;

    procedure Clear;

    procedure ThreadTerminateProc(Sender: TObject);
  public
    procedure RegisterThread(aThread : TSMSThread); overload;
    procedure RegisterThread(aThread : TThread); overload;

    procedure TerminateThread(aThread : TThread);    


    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSMSThreadList }

procedure TSMSThreadList.RegisterThread(aThread: TSMSThread);
begin
  if FThreadList.IndexOf(aThread) < 0 then
  begin
    FThreadList.Add(aThread);
    aThread.OnTerminate := ThreadTerminateProc;
  end;

end;

constructor TSMSThreadList.Create;
begin
  FThreadList := TList.Create;

end;

destructor TSMSThreadList.Destroy;
begin
  Clear;

  FThreadList.Free;

  inherited;
end;

procedure TSMSThreadList.Clear;
var
  i : Integer;
  aThread : TThread;
begin
  for i := FThreadList.Count-1 downto 0 do
  begin
    aThread := FThreadList.Items[i];
    TerminateThread(aThread);
  end;
  //
//  WaitForSingleObject(

end;

procedure TSMSThreadList.ThreadTerminateProc(Sender: TObject);
begin
  //
  FThreadList.Remove(Sender);

end;

procedure TSMSThreadList.RegisterThread(aThread: TThread);
begin
  if FThreadList.IndexOf(aThread) < 0 then
  begin
    FThreadList.Add(aThread);
    //aThread.OnTerminate := ThreadTerminateProc;
  end;
end;

procedure TSMSThreadList.TerminateThread(aThread: TThread);
begin
  //aThread.FreeOnTerminate := True;      쓰레드를 죽이는 코드는 무조건 에러를 불러온다.
  //현재 쓰레드를 free 하지 못하고 있슴.
  aThread.OnTerminate := ThreadTerminateProc;
  aThread.Terminate;
  aThread.WaitFor;
end;

end.
