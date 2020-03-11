unit SMS_ViewProcessProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Math;

type
  TViewProcessProgress = class(TForm)
    PanelLastMessage: TPanel;
    PanelStatus: TPanel;
    ProgressBarProcess: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FLastMessage : String;
    //
    FStartTime : TDateTime;
    FTimer : TTimer;
    FCurrentProcessSec : Integer;
    FMaxProcessSec : Integer;

    procedure TimerProc(Sender: TObject);
  public
    { Public declarations }
    procedure UpdateMessage(stMessage : String);
    procedure StartViewProgress(iTotalStepCount: Integer);
  end;

var
  ViewProcessProgress: TViewProcessProgress;

implementation

{$R *.dfm}

{ TViewProcessProgress }

procedure TViewProcessProgress.UpdateMessage(stMessage: String);
begin
  //ListMessage.Items[0] := Format('%s', [stMessage]);
  PanelLastMessage.Caption := stMessage;
  FLastMessage := stMessage;
  FCurrentProcessSec := 0;
  ProgressBarProcess.Position := Min(ProgressBarProcess.Max, ProgressBarProcess.Position + 1);
end;

procedure TViewProcessProgress.FormCreate(Sender: TObject);
begin
//  ListMessage.Items.Add('');
  FTimer := TTimer.Create(Self);
  FTimer.OnTimer := TimerProc;

  FCurrentProcessSec := 0;
  FMaxProcessSec := 10;
end;

procedure TViewProcessProgress.StartViewProgress(iTotalStepCount: Integer);
begin
  FStartTime := Now;
  Position := poOwnerFormCenter;

  ProgressBarProcess.Max := iTotalStepCount;
  ProgressBarProcess.Position := 0;//iTotalStepCount;
  ShowModal;
end;

procedure TViewProcessProgress.FormDestroy(Sender: TObject);
begin
  FTimer.Free;
end;

procedure TViewProcessProgress.TimerProc(Sender: TObject);
var
  i : Integer;
begin
  //
  PanelLastMessage.Caption := FLastMessage + ' ';
  for i := 0 to FCurrentProcessSec-1 do
    PanelLastMessage.Caption := PanelLastMessage.Caption + ' . ';
  Inc(FCurrentProcessSec);
  //
  if FCurrentProcessSec > FMaxProcessSec then
    FCurrentProcessSec := 0;

  PanelStatus.Caption := Format('Progress Time: %s     %d / %d',
  [FormatDateTime('hh:nn:ss', Now-FStartTime),
    FCurrentProcessSec, FMaxProcessSec]);

end;

procedure TViewProcessProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caNone;
end;

end.
