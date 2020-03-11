unit SMS_TextFileEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TTextFileEditor = class(TForm)
    PanelBottomControl: TPanel;
    MemoFileContents: TMemo;
    ButtonSave: TButton;
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
    FFilePath : String;
  public
    { Public declarations }
    function Execute(stFile: String): Boolean;

  end;

var
  TextFileEditor: TTextFileEditor;

implementation

{$R *.dfm}

{ TForm2 }

function TTextFileEditor.Execute(stFile: String): Boolean;
var
  aFiles : TStringList;
begin
  FFilePath := stFile;
  //
  MemoFileContents.Lines.Clear;
  //
  aFiles := TStringList.Create;

  aFiles.LoadFromFile(stFile);

  try
    MemoFileContents.Lines.Assign(aFiles);

  finally
    aFiles.Free;
  end;


  Result := ShowModal = mrOk;
end;

procedure TTextFileEditor.ButtonSaveClick(Sender: TObject);
begin
  MemoFileContents.Lines.SaveToFile(FFilePath);
end;

end.
