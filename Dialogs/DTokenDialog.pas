unit DTokenDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SMS_Strings, StdCtrls;

type
  TTokenDialog = class(TForm)
    MemoTokens: TMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddTokenLine(stSplitter, stLine: String);
    procedure AddTokenStrings(aStrings: TStrings);

  end;


procedure ExecuteTokenDialog(AOwner: TComponent; aStrings: TStrings); overload;
procedure ExecuteTokenDialog(AOwner: TComponent; stSplitter, stLine: String;
          var iWidth, iHeight: Integer); overload;

var
  TokenDialog: TTokenDialog;

implementation

{$R *.dfm}
procedure ExecuteTokenDialog(AOwner: TComponent; stSplitter, stLine: String;
  var iWidth, iHeight: Integer);
var
  aDialog : TTokenDialog;
begin
  aDialog := TTokenDialog.Create(AOwner);

  try
    aDialog.AddTokenLine(stSplitter, stLine);
    if (iWidth > 0) or (iHeight > 0) then
    begin
      aDialog.Width := iWidth;
      aDialog.Height := iHeight;
    end;
    //
    aDialog.ShowModal;
    iWidth := aDialog.Width;
    iHeight := aDialog.Height;
  finally
    aDialog.Free;
  end;
end;


procedure ExecuteTokenDialog(AOwner: TComponent; aStrings: TStrings);
var
  aDialog : TTokenDialog;
begin
  aDialog := TTokenDialog.Create(AOwner);

  try
    aDialog.AddTokenStrings(aStrings);

    aDialog.ShowModal;
  finally
    aDialog.Free;
  end;
end;

{ TForm1 }

procedure TTokenDialog.AddTokenLine(stSplitter, stLine: String);
var
  i : Integer;
  aTokens : TStringList;
begin
  //
  if Length(stSplitter) = 0 then
  begin
    MemoTokens.Lines.Add(stLine);
    Exit;
  end;
  //
  aTokens := TStringList.Create;

  try
    GetTokens(stLine, aTokens, stSplitter[1]);
    for i := 0 to aTokens.Count-1 do
    begin
      if Length(Trim(aTokens[i])) = 0 then continue;
      //
      MemoTokens.Lines.Add(aTokens[i]);
    end;

  finally
    aTokens.Free;
  end;

end;

procedure TTokenDialog.AddTokenStrings(aStrings: TStrings);
begin
  MemoTokens.Lines.Assign(aStrings);
end;

procedure TTokenDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

end.
