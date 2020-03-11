unit LogManager;

interface

uses
  SysUtils, Classes;

type

  TLogManager = class
  private
    FOnAddLog: TNotifyEvent;

    FLogs : TStringList;
    //
    FSenderLength: Integer;
    FTitleLength: Integer;
    FAutoFileSave: Boolean;
    FSavePath: String;
    function GetLastLog: String;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddLog(stSender, stTitle, stLog: String);

    property OnAddLog: TNotifyEvent read FOnAddLog write FOnAddLog;

    property LastLog : String read GetLastLog;
    property SenderLength : Integer read FSenderLength write FSenderLength;
    property TitleLength : Integer read FTitleLength write FTitleLength;
    //
    property AutoFileSave : Boolean read FAutoFileSave write FAutoFileSave;
    property SavePath : String read FSavePath write FSavePath;
  end;

var
  gLogManager : TLogManager;

implementation

{ TLogManager }

procedure TLogManager.AddLog(stSender, stTitle, stLog: String);
var
  F : TextFile;
  stTotalLog : String;
begin
  stTotalLog := Format('%-20s %-*s %-*s : %-s',
    [FormatDateTime('mm/dd hh:nn:ss', Now), FSenderLength, stSender,
    FTitleLength, stTitle, stLog]);
  FLogs.Insert(0, stTotalLog);
  //
  if Assigned(FOnAddLog) then
    FOnAddLog(Self);
  //

  if not FAutoFileSave then Exit;

  AssignFile(F, FSavePath);
  //

  try
    if not FileExists(FSavePath) then
      Rewrite(F)
    else
      Append(F);
    //
    WriteLn(F, stTotalLog);
  finally
    CloseFile(F);
  end;
end;

constructor TLogManager.Create;
begin
  FLogs := TStringList.Create;

  FSenderLength := 20;
  FTitleLength := 30;

  FAutoFileSave := False;
  FSavePath := '';
end;

destructor TLogManager.Destroy;
begin
  FLogs.Free;
end;

function TLogManager.GetLastLog: String;
begin
  if FLogs.Count = 0 then
    Result := 'n.a.'
  else
    Result := FLogs[0];
end;

initialization
  gLogManager := TLogManager.Create;

finalization
  gLogManager.Free;

end.
