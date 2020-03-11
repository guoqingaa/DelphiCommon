unit DTimeFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask;

type
  TTimeFilterDialog = class(TForm)
    CheckBoxBegin: TCheckBox;
    CheckBoxEnd: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MaskEditStart: TMaskEdit;
    MaskEditEnd: TMaskEdit;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function GetEndTime: TDateTime;
    function GetSelectEnd: Boolean;
    function GetSelectStart: Boolean;
    function GetStartTime: TDateTime;
    procedure SetEndTime(const Value: TDateTime);
    procedure SetSelectEnd(const Value: Boolean);
    procedure SetSelectStart(const Value: Boolean);
    procedure SetStartTime(const Value: TDateTime);
    { Private declarations }
  public
    { Public declarations }
    function Open : Boolean;
    property SelectStart : Boolean read GetSelectStart write SetSelectStart;
    property SelectEnd : Boolean read GetSelectEnd write SetSelectEnd;
    property StartTime : TDateTime read GetStartTime write SetStartTime;
    property EndTime : TDateTime read GetEndTime write SetEndTime;
  end;

var
  TimeFilterDialog: TTimeFilterDialog;

implementation

{$R *.dfm}

{ TForm1 }

function TTimeFilterDialog.GetEndTime: TDateTime;
var
  stValue : String;
begin
  stValue := MaskEditEnd.Text;
  Result := EncodeTime(StrToInt(Copy(stValue, 1, 2)), StrToInt(Copy(stValue, 4, 2)), 0, 0);
end;

function TTimeFilterDialog.GetSelectEnd: Boolean;
begin
  Result := CheckBoxEnd.Checked;

end;

function TTimeFilterDialog.GetSelectStart: Boolean;
begin
  Result := CheckBoxBegin.Checked;
end;

function TTimeFilterDialog.GetStartTime: TDateTime;
var
  stValue : String;
begin
  stValue := MaskEditStart.Text;
  Result := EncodeTime(StrToInt(Copy(stValue, 1, 2)), StrToInt(Copy(stValue, 4, 2)), 0, 0);

end;

function TTimeFilterDialog.Open: Boolean;
begin
  Result := ShowModal = mrOk;
end;

procedure TTimeFilterDialog.SetEndTime(const Value: TDateTime);
begin
  MaskEditEnd.Text := FormatDateTime('hh:nn', Value);
end;

procedure TTimeFilterDialog.SetSelectEnd(const Value: Boolean);
begin
  CheckBoxEnd.Checked := Value;
end;

procedure TTimeFilterDialog.SetSelectStart(const Value: Boolean);
begin
  CheckBoxBegin.Checked := Value;
end;

procedure TTimeFilterDialog.SetStartTime(const Value: TDateTime);
begin
  MaskEditStart.Text := FormatDateTime('hh:nn', Value);

end;

procedure TTimeFilterDialog.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Close;
end;

end.
