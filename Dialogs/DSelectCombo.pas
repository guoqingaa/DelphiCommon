unit DSelectCombo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSelectComboDialog = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    ButtonOK: TButton;
    procedure ButtonOKClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

    function Open(aStrings : TStrings): Boolean;
    //
  end;


implementation

{$R *.dfm}


function TSelectComboDialog.Open(aStrings: TStrings): Boolean;
begin
  ComboBox1.Items.Assign(aStrings);
  Result := ShowModal = mrOk;
end;

procedure TSelectComboDialog.ButtonOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
