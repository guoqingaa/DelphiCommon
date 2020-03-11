unit SMS_DStepGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TStepGridConfig = class(TForm)
    Label1: TLabel;
    EditFixedCols: TEdit;
    ButtonOK: TButton;
    procedure ButtonOKClick(Sender: TObject);
  private
    function GetFixedCols: Integer;
    procedure SetFixedCols(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }

    function Open : Boolean;

    property FixedCols : Integer read GetFixedCols write SetFixedCols;
  end;

var
  StepGridConfig: TStepGridConfig;

implementation

{$R *.dfm}

procedure TStepGridConfig.ButtonOKClick(Sender: TObject);


begin
  ModalResult := mrOk;

end;

function TStepGridConfig.GetFixedCols: Integer;
begin
  Result := StrToInt(EditFixedCols.Text);
end;

function TStepGridConfig.Open: Boolean;
begin
  Result := ShowModal = mrOk
end;

procedure TStepGridConfig.SetFixedCols(const Value: Integer);
begin
  EditFixedCols.Text := IntToStr(Value);
end;

end.
