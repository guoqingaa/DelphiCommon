unit DInputString;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TInputStringDialog = class(TForm)
    EditInput: TEdit;
    ButtonOK: TButton;
    Button2: TButton;
    procedure ButtonOKClick(Sender: TObject);
  private
    function GetInputString: String;
    { Private declarations }
  public
    { Public declarations }
    function Open : Boolean;
    //
    property InputString : String read GetInputString;
  end;

var
  InputStringDialog: TInputStringDialog;

implementation

{$R *.dfm}

{ TForm2 }

function TInputStringDialog.GetInputString: String;
begin
  Result := EditInput.Text;
end;

function TInputStringDialog.Open: Boolean;
begin
  Result := ShowModal = mrOk;

end;

procedure TInputStringDialog.ButtonOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
