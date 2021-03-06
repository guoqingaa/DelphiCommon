unit DConfigKeyDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, CheckLst, ExtCtrls;

type
  TConfigKeyDialog = class(TForm)
    ValueListEditor1: TValueListEditor;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ValueListEditor1EditButtonClick(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigKeyDialog: TConfigKeyDialog;

implementation

{$R *.dfm}

procedure TConfigKeyDialog.FormCreate(Sender: TObject);
begin
  ValueListEditor1.ColCount := 3;
end;

procedure TConfigKeyDialog.Button1Click(Sender: TObject);
begin
  ValueListEditor1.InsertRow('', '', True);
  ValueListEditor1.ItemProps[ValueListEditor1.RowCount-2].EditStyle := esEllipsis;
end;
procedure TConfigKeyDialog.ValueListEditor1EditButtonClick(
  Sender: TObject);
begin
  //
  if OpenDialog1.Execute then
  begin
    ValueListEditor1.Strings[ValueListEditor1.Row-1] := OpenDialog1.FileName;
  end;
end;

procedure TConfigKeyDialog.ValueListEditor1Click(Sender: TObject);
begin
  if ValueListEditor1.Strings.Count > 0 then
    ValueListEditor1.ItemProps[ValueListEditor1.Row-1].EditStyle := esEllipsis;
end;

end.
