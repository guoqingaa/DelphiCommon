unit SMS_Progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TSMS_ProgressWindow = class(TForm)
    ListMessage: TListBox;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    procedure ListMessageMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
  private
    { Private declarations }
    FTotalStepCount : Integer;
    FPosition : Integer;
    FProgressMessage : String;

    procedure ShowNowProgress;
  public
    { Public declarations }
    procedure ShowProgress(stProgressMessage: String; iTotalStep: Integer);
    procedure SetPosition(iPosition: Integer; stMessage: String);
    procedure UpdateMessage(stMessage : String);
    procedure UpdateLastMessage(stMessage: String);
  end;

var
  SMS_ProgressWindow: TSMS_ProgressWindow;

implementation

{$R *.dfm}

procedure TSMS_ProgressWindow.ListMessageMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height := 20;
end;

procedure TSMS_ProgressWindow.SetPosition(iPosition: Integer;
  stMessage: String);
begin
  FPosition := iPosition;
  ShowNowProgress;
end;

procedure TSMS_ProgressWindow.ShowNowProgress;
begin

  ProgressBar1.Position := FPosition;
  ProgressBar1.Max := FPosition;
  //AdvProgressBar1.Position := FPosition;
  //AdvProgressBar1.Max := FTotalStepCount;

  ListMessage.Items.Add(Format('%s %d / %d', [FProgressMessage, FPosition , FTotalStepCount]));

end;

procedure TSMS_ProgressWindow.ShowProgress(stProgressMessage: String; iTotalStep: Integer);
begin
  (*
  ListMessage.Items.Clear;
  FTotalStepCount := iTotalStep;
  FProgressMessage := stProgressMessage;
  //
  ShowNowProgress;
  *)
  Position := poOwnerFormCenter;
  ShowModal;
end;

procedure TSMS_ProgressWindow.UpdateLastMessage(stMessage: String);
begin
  if ListMessage.Items.Count = 0 then Exit;
  //
  ListMessage.Items[ListMessage.Items.Count-1] := Format('%s', [stMessage]);

end;

procedure TSMS_ProgressWindow.UpdateMessage(stMessage: String);
begin
  ListMessage.Items.Add(Format('%s', [stMessage]));
  ListMessage.ItemIndex := ListMessage.Items.Count-1;

end;

end.
