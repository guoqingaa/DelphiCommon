unit SMS_LogWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSMSLogWindow = class(TForm)
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(stTitle, stLog: String);
  end;

var
  SMSLogWindow: TSMSLogWindow;

implementation

{$R *.dfm}

{ TForm2 }

procedure TSMSLogWindow.AddLog(stTitle, stLog: String);
var
  stLine : String;
begin
  //
  stLine := FormatDateTime('hh:nn:ss.zzz', Now) + Format('%20s   %40s', [stTitle, stLog]);;
  Memo1.Lines.Insert(0, stLine);
end;

end.
