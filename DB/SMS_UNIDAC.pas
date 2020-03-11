unit SMS_UNIDAC;

interface

uses
  SysUtils, Classes, Dialogs

{$IFDEF UNIDAC}
  ,
  DBAccess,
  Uni,
  UniProvider,
  MySQLUniProvider,
  MemDS
{$ENDIF}

  ,Windows;

{$IFDEF UNIDAC}
  procedure DropView(aUniQuery: TUniQuery; stView : String);


type
  TUniDBConnector = class
  private
    FUniConnection : TUniConnection;
    //


    FDBQuery : TUniQuery;
    FUniSQL : TUniSQL;

  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure Connect(stServer, stDataBase, stUser, stPassword: String);

    procedure ExecuteSQL(stSQL: String);
    procedure OpenSQL(stSQL: String);

    function GetNewQuery : TUniQuery;
    procedure RemoveQuery(aQuery: TUniQuery);

    property Query : TUniQuery read FDBQuery;
    property UniSQL : TUniSQL read FUniSQL;
    property Connection : TUniConnection read FUniConnection;
    //
  end;

{$ENDIF}

implementation

{$IFDEF UNIDAC}
procedure DropView(aUniQuery: TUniQuery; stView : String);
begin
  try

    aUniQuery.SQL.Clear;
    aUniQuery.SQL.Add(
      Format('drop view %s', [stView]));
    aUniQuery.ExecSQL;

  except
  end;

end;

  //


{ TUniDBConnector }

procedure TUniDBConnector.Connect(stServer, stDataBase,
  stUser, stPassword: String);
begin

  FUniConnection.Server := stServer;
  FUniConnection.Database := stDataBase;
  FUniConnection.Username := stUser;
  FUniConnection.Password := stPassword;
  FUniConnection.Connect;

end;

constructor TUniDBConnector.Create;
begin
  FUniConnection := TUniConnection.Create(nil);
  FUniConnection.ProviderName := 'MySQL';
  FUniConnection.SpecificOptions.Add('UseUniCode=True');
  FUniConnection.LoginPrompt := True;
  FUniConnection.SpecificOptions.Add('UseUniCode=True');

  FDBQuery := TUniQuery.Create(nil);

  (FDBQuery as TUniQuery).Connection := FUniConnection;

  FUniSQL := TUniSQL.Create(nil);


end;

destructor TUniDBConnector.Destroy;
begin

  FUniSQL.Free;
  FUniConnection.Free;


  inherited;
end;

procedure TUniDBConnector.ExecuteSQL(stSQL: String);
begin
  FDBQuery.SQL.Clear;
  FDBQuery.SQL.Add(stSQL);

  try
    FDBQuery.Execute;
  except
    ShowMessage(stSQL);
  end;
end;

function TUniDBConnector.GetNewQuery: TUniQuery;
begin

end;

procedure TUniDBConnector.OpenSQL(stSQL: String);
begin

end;

procedure TUniDBConnector.RemoveQuery(aQuery: TUniQuery);
begin

end;

{$ENDIF}

end.
