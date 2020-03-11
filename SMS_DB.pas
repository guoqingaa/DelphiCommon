unit SMS_DB;

interface

uses
  Classes, SysUtils,
  ActiveX,
  DB, ADODB;

type


  TRecordColumnItem = class(TCollectionItem)
  public
    ColumnName : String;
    Value : String;
    //ValueType : TVarType;
    //ValueAsDouble : Double;
    //ValueAsString : String;
    //ValueAsInteger : Integer;
  end;


  TDBConnector = class
  private
    FDBConnection: TADOConnection;

    FDBQuery: TADOQuery;

    FInsertTable : String;
    //FInsertColumns : TStringList;
    //FInsertValues : TStringList;
    FInsertColumns : TCollection;
    FDBQuery2: TADOQuery;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Connect(stConnectionString: String);

    procedure BeginInsert(stTableName: String);
    procedure RegColumn(stColumn, stValue: String); overload;
    procedure RegColumn(stColumn: String; dValue : Double); overload;
    procedure RegColumn(stColumn: String; iValue : Integer); overload;
    procedure RegColumnByDateTime(stColumn: String; aDateTime: TDateTime);

    procedure ExecInsert;

    property Query: TADOQuery read FDBQuery write FDBQuery;
    property Query2 : TADOQuery read FDBQuery2 write FDBQuery2;
  end;

var
  gDBConnector : TDBConnector;

implementation

uses ComObj;

{ TDBConnector }

procedure TDBConnector.BeginInsert(stTableName: String);
begin
  FInsertColumns.Clear;

  FInsertTable := stTableName;
end;

procedure TDBConnector.Connect(stConnectionString: String);
begin
  if FDBConnection.Connected then Exit;
  //
  FDBConnection.ConnectionString := stConnectionString;
  FDBConnection.Connected := True;

  FDBQuery.Connection := FDBConnection;
  FDBQuery2.Connection := FDBConnection;
  //FDBQuery.Active := True;
end;

constructor TDBConnector.Create;
begin
  //
  CoInitialize(nil);
  FDBConnection := TADOConnection.Create(nil);
  FDBQuery := TADOQuery.Create(nil);
  FDBQuery2 := TADOQuery.Create(nil);

  FInsertColumns := TCollection.Create(TRecordColumnItem);
end;

destructor TDBConnector.Destroy;
begin
  //
  FInsertColumns.Free;
    //
  FDBQuery.Free;
  FDBQuery2.Free;
  //
  FDBConnection.Free;

  inherited;
end;

procedure TDBConnector.ExecInsert;
var
  i : Integer;
  stQuery, stColumn, stValue : String;
  aColumn : TRecordColumnItem;
begin

  for i := 0 to FInsertColumns.Count-1 do
  begin
    aColumn := FInsertColumns.Items[i] as TRecordColumnItem;
    //
    if i = 0 then
    begin
      stColumn := '`'+aColumn.ColumnName+'`';
      //stColumn := '"'+aColumn.ColumnName+'"';
      //

      stValue := aColumn.Value;
    end else
    begin
      stColumn := stColumn + ',`'+aColumn.ColumnName+'`';
      //stColumn := stColumn + ',"'+aColumn.ColumnName+'"';
      stValue := stValue + ',' + aColumn.Value;
    end;

  end;
  stQuery := Format('INSERT INTO %s (%s) VALUES (%s) ',
      [FInsertTable, stColumn, stValue]);


  Query.SQL.Clear;
  Query.SQL.Add(stQuery);
  Query.ExecSQL;

  FInsertTable := '';
  FInsertColumns.Clear;
end;

procedure TDBConnector.RegColumn(stColumn, stValue: String);
var
  aRecordColumn : TRecordColumnItem;
begin
  aRecordColumn := FInsertColumns.Add as TRecordColumnItem;
  aRecordColumn.ColumnName := stColumn;
  //aRecordColumn.Value := '`'+stValue+'`';

  aRecordColumn.Value := ''''+stValue+'''';


//  aRecordColumn.ValueType := varString;
//  aRecordColumn.ValueAsString := stValue;
end;

procedure TDBConnector.RegColumn(stColumn: String; dValue: Double);
var
  aRecordColumn : TRecordColumnItem;
begin
  aRecordColumn := FInsertColumns.Add as TRecordColumnItem;
  aRecordColumn.ColumnName := stColumn;
  aRecordColumn.Value := Format('%.6f', [dValue]);
  //aRecordColumn.ValueType := varDouble;
  //aRecordColumn.ValueAsDouble := dValue;

end;

procedure TDBConnector.RegColumn(stColumn: String; iValue: Integer);
var
  aRecordColumn : TRecordColumnItem;
begin
  aRecordColumn := FInsertColumns.Add as TRecordColumnItem;
  aRecordColumn.ColumnName := stColumn;
  aRecordColumn.Value := IntToStr(iValue);
//  aRecordColumn.ValueType := varInteger;
//  aRecordColumn.ValueAsInteger := iValue;
end;

procedure TDBConnector.RegColumnByDateTime(stColumn: String;
  aDateTime: TDateTime);

var
  aRecordColumn : TRecordColumnItem;
begin
  aRecordColumn := FInsertColumns.Add as TRecordColumnItem;
  aRecordColumn.ColumnName := stColumn;
  aRecordColumn.Value := '"'+FormatDateTime('yyyy-mm-dd hh:nn:ss', aDateTime)+'"';

end;

initialization
  gDBConnector := TDBConnector.Create;

finalization
  gDBConnector.Free;


end.


INSERT INTO `temp_data`.`fut_sgx` (
`nID` ,
`szCode` ,
`nDate` ,
`nTime` ,
`nOpen` ,
`nHigh` ,
`nLow` ,
`nClose` ,
`lnMinVolume` ,
`lnMinAmount` ,
`nOI` 
)
VALUES (
NULL , 'pb1111', '20120303', '111111', '0', '0', '0', '0', '0', '0', '0'
);


