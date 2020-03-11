unit SMS_FTPThread;

interface

uses
  SysUtils, Classes, IdFTP, IdStack;

type
  TFTPThread = class(TThread)
  private
    FFTPConnector : TIdFTP;
    FCmd : Integer;
    FSource : String;
    FDest : String;
    FErrorMessage: String;
    FErrorIndex : Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(aFTPConnector: TIdFTP; iCmd: Integer); overload;
    constructor Create(aFTPConnector: TIdFTP; stSource, stDest : String); overload;

    property DownloadFile : String read FSource;
    property ErrorMessage : String read FErrorMessage;
    property ErrorIndex : Integer read FErrorIndex;
  end;

implementation

{ TFTPThread }

constructor TFTPThread.Create(aFTPConnector: TIdFTP; iCmd: Integer);
begin
  FFTPConnector := aFTPConnector;
  FCmd := iCmd;
  FErrorMessage := '';
  //
  inherited Create(False);
end;


constructor TFTPThread.Create(aFTPConnector: TIdFTP; stSource,
  stDest: String);
begin
  FFTPConnector := aFTPConnector;
  FCmd := 5;
  FSource := stSource;
  FDest := stDest;
  FErrorMessage := '';
  //
  inherited Create(False);
end;

procedure TFTPThread.Execute;
begin
  FErrorMessage := '';
  try
    case FCmd of
      0 : FFTPConnector.Connect;
      5 : FFTPConnector.Get(FSource, FDest, True);
    end;

  except
    on E: Exception do
      FErrorMessage := E.Message;

  end;

end;

end.
