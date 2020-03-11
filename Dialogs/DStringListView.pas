unit DStringListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Math;

type
  TStringListViewForm = class(TForm)
    ListView1: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringList : TStringList;
    FMaxTokenCount : Integer;
  public
    { Public declarations }

    procedure AddString(stLine: String);
    procedure Clear;
    procedure Open;
  end;

var
  StringListViewForm: TStringListViewForm;

implementation

{$R *.dfm}

function GetTokens(stText : String; aTokens : TStringList; aSector : Char) : Integer;
var
  i, iLen : Integer;
  stToken : String;
begin
  //-- init
  Result := 0;
  aTokens.Clear;
  //--
  iLen := Length(stText);
  if iLen = 0 then Exit;
  // start parsing
  stToken := '';
  for i:= 1 to iLen do
    if stText[i] = aSector then
    begin
      aTokens.Add(stToken);
      stToken :=  '';
    end else
      stToken := stToken + stText[i];

  if stToken <> '' then
    aTokens.Add(stToken);
  //--
  Result := aTokens.Count;
end;


procedure TStringListViewForm.AddString(stLine: String);
var
  aTokens : TStringList;
begin
  FStringList.Add(stLine);
  //
  aTokens := TStringList.Create;

  try
    FMaxTokenCount := Max(FMaxTokenCount, GetTokens(stLine, aTokens, ','));
  finally
    aTokens.Free;
  end;

end;

procedure TStringListViewForm.Clear;
begin
  FStringList.Clear;
  FMaxTokenCount := 0;

end;

procedure TStringListViewForm.FormCreate(Sender: TObject);
begin
  FStringList := TStringList.Create;

end;

procedure TStringListViewForm.FormDestroy(Sender: TObject);
begin
  FStringList.Free;

end;

procedure TStringListViewForm.Open;
var
  aListItem : TListItem;
  aTokens : TStringList;
  i, j : Integer;
begin
  ListView1.Columns.Clear;
  ListView1.Items.Clear;

  for i := 0 to FMaxTokenCount-1 do
    ListView1.Columns.Add;
  //
  aTokens := TStringList.Create;

  try
    for i := 0 to FStringList.Count-1 do
    begin
      aTokens.Clear;
      //
      aListItem := ListView1.Items.Add;

      GetTokens(FStringList[i], aTokens, ',');
      aListItem.Caption := aTokens[0];
      //
      for j := 1 to aTokens.Count-1 do
      begin
        aListItem.SubItems.Add(aTokens[j]);
      end;
    end;
  finally
    aTokens.Free;
  end;

  ShowModal;

end;

end.
