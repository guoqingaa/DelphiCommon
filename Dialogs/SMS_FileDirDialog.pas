unit SMS_FileDirDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls, MMSystem, SMS_Files;

type

  TFileDirDialog = class(TForm)
    OpenDialog1: TOpenDialog;
    PanelDirectory: TPanel;
    Label1: TLabel;
    ButtonSelectDirectory: TSpeedButton;
    PanelFile: TPanel;
    Label2: TLabel;
    EditFile: TEdit;
    ButtonSelectFile: TSpeedButton;
    Panel3: TPanel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    ButtonPlay: TSpeedButton;
    ComboDirectories: TComboBox;
    procedure ButtonSelectDirectoryClick(Sender: TObject);
    procedure ButtonSelectFileClick(Sender: TObject);
    procedure ButtonPlayClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    //FSelected: String;      
    function GetSelected: String;
    { Private declarations }

  public
    { Public declarations }
    function OpenFile(var stFile: String) : Boolean;
    function OpenDirectroy(var stDirectory : String) : Boolean;

    property Selected: String read GetSelected;
  end;

  type
  PShellLinkInfoStruct = ^TShellLinkInfoStruct;
  TShellLinkInfoStruct = record
    FullPathAndNameOfLinkFile: array[0..MAX_PATH] of Char;
    FullPathAndNameOfFileToExecute: array[0..MAX_PATH] of Char;
    ParamStringsOfFileToExecute: array[0..MAX_PATH] of Char;
    FullPathAndNameOfWorkingDirectroy: array[0..MAX_PATH] of Char;
    Description: array[0..MAX_PATH] of Char;
    FullPathAndNameOfFileContiningIcon: array[0..MAX_PATH] of Char;
    IconIndex: Integer;
    HotKey: Word;
    ShowCommand: Integer;
    FindData: TWIN32FINDDATA;
  end;

var
  FileDirDialog: TFileDirDialog;

implementation

{$R *.dfm}

function TFileDirDialog.OpenDirectroy(var stDirectory: String): Boolean;
begin
  PanelFile.Visible := False;
  EditFile.Visible := False;

  ComboDirectories.Text := stDirectory;
  Height := Height - 40;

  GetRecentDirsFromRegistry(ComboDirectories.Items); 

  Result := ShowModal = mrOk;
  //
  if Result then
    stDirectory := ComboDirectories.Text;
end;

function TFileDirDialog.OpenFile(var stFile: String): Boolean;
begin
  PanelDirectory.Visible := False;
  ComboDirectories.Visible := False;

  EditFile.Text := stFile;
  Height := Height - 40;

  Result := ShowModal = mrOk;
  //
  if Result then
    stFile := EditFile.Text;

end;

procedure TFileDirDialog.ButtonSelectDirectoryClick(Sender: TObject);
var
  stDir : String;

begin
  stDir := ComboDirectories.Text;
  //
  if SelectDirectory('select directory', '', stDir) then
  begin
    if stDir[Length(stDir)] <> '\' then
      stDir := stDir + '\';
    //
    ComboDirectories.Text := stDir;
  end;
  

end;

procedure TFileDirDialog.ButtonSelectFileClick(Sender: TObject);
begin
  //OpenDialog1.FileName := EditEtcFile.Text;
  OpenDialog1.FileName := EditFile.Text;
  if OpenDialog1.Execute then
  begin
    EditFile.Text := OpenDialog1.FileName;
  end;

end;


function TFileDirDialog.GetSelected: String;
begin
  if ComboDirectories.Visible then
    Result := ComboDirectories.Text
  else
    Result := EditFile.Text;
end;

procedure TFileDirDialog.ButtonPlayClick(Sender: TObject);
var
  szBuf : array[0..1000] of Char;
begin
  MMSystem.PlaySound(StrPCopy(szBuf, EditFile.Text), 0,
              SND_ASYNC + SND_FILENAME + SND_NODEFAULT);
end;

procedure TFileDirDialog.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ButtonCancel.Click;
end;

end.
