unit SMS_DInputStep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,

  SMS_Strings, SMS_Maths;

type
  TStepInputDialog = class(TForm)
    EditName: TEdit;
    EditStart: TEdit;
    EditLast: TEdit;
    EditStep: TEdit;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckAutoLast: TCheckBox;
    EditLastRef: TEdit;
    Label4: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckAutoLastClick(Sender: TObject);
  private
    function GetValue: String;
    { Private declarations }
  public
    { Public declarations }
    function Open(stName, stValue : String): Boolean;

    property Value : String read GetValue;
  end;

var
  StepInputDialog: TStepInputDialog;
  

implementation

{$R *.dfm}

const
  AUTO_MARK = '@';
  LASTREF_MARK = '$';

{ TStepInputDialog }

function TStepInputDialog.GetValue: String;
begin
  if (not CheckAutoLast.Checked) and (Length(Trim(EditLastRef.Text)) > 0) then
  begin
    Result := EditStart.Text + ',' +
      LASTREF_MARK + EditLastRef.Text + '/' + EditLast.Text + ',' + EditStep.Text;
    Exit;
  end;

  Result := EditStart.Text + ',' +
    IfThenString(CheckAutoLast.Checked, AUTO_MARK, '') +  EditLast.Text + ',' + EditStep.Text;
end;

function TStepInputDialog.Open(stName, stValue: String): Boolean;
var
  aTokens, aTokens2 : TStringList;
begin
  EditName.Text := stName;

  aTokens := TStringList.Create;

  try
    GetTokens(stValue, aTokens, ',');
    if aTokens.Count > 0 then
      EditStart.Text := aTokens[0];//Format('%f', [aTokens[0]]);
    if aTokens.Count > 1 then
    begin
      EditLast.Text := aTokens[1];
      //
      if (Length(EditLast.Text) > 0) then
      begin
        if (EditLast.Text[1] = '@') then
        begin
          CheckAutoLast.Checked := True;
          EditLast.Text := Copy(EditLast.Text, 2, Length(EditLast.Text)-1);
        end else
        if (EditLast.Text[1] = LASTREF_MARK) then
        begin
          aTokens2 := TStringList.Create;

          try
            GetTokens(Copy(EditLast.Text, 2, Length(EditLast.Text)-1),
              aTokens2, '/');
            //
            EditLast.Text := aTokens2[2];
            EditLastRef.Text := aTokens2[0] + '/' + aTokens2[1];

          finally
            aTokens2.Free;
          end;

        end;

      end;

    end;
    if aTokens.Count > 2 then
      EditStep.Text := aTokens[2];//Format('%f', [aTokens[2]]);
  finally
    aTokens.Free;
  end;


  Result := ShowModal = mrOk;
end;

procedure TStepInputDialog.ButtonOKClick(Sender: TObject);
var
  oValue : Variant;
begin

  if IsNumeric(EditStart.Text) and IsNumeric(EditLast.Text) and IsNumeric(EditStep.Text) then
    ModalResult := mrOk
  else
  begin
    ShowMessage('invalid input value');
  end;

end;

procedure TStepInputDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TStepInputDialog.CheckAutoLastClick(Sender: TObject);
begin
  //if CheckAutoLast.Checked then
  //  EditLast.Text := 'AUTO';
end;

end.
