unit DSelectTwoWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSelectTwoWayDialog = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    ButtonCancel: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function GetSelectIndex: Integer;
    { Private declarations }
  public
    { Public declarations }
    function Open(stDialogName, stWay, stWay2 : String): Boolean;

    property SelectIndex : Integer read GetSelectIndex;
  end;

var
  SelectTwoWayDialog: TSelectTwoWayDialog;

implementation

{$R *.dfm}

{ TSelectTwoWayDialog }

function TSelectTwoWayDialog.GetSelectIndex: Integer;
begin
  Result := 0;
  if RadioButton2.Checked then
    Result := 1;
end;

function TSelectTwoWayDialog.Open(stDialogName, stWay,
  stWay2: String): Boolean;
begin
  RadioButton1.Caption := stWay;
  RadioButton2.Caption := stWay2;
  Caption := stDialogName;

  Result := ShowModal = mrOk;

end;

procedure TSelectTwoWayDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ButtonCancel.Click;
end;

end.
