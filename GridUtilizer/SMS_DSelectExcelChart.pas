unit SMS_DSelectExcelChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActiveX, Excel_TLB;

type
  TSelectExcelChartType = class(TForm)
    RadioGroup1: TRadioGroup;
    ButtonSelect: TButton;
    procedure ButtonSelectClick(Sender: TObject);
  private
    function GetSelectType: TOleEnum;
    { Private declarations }
  public
    { Public declarations }
    function Open : Boolean;
    //
    property SelectType : TOleEnum read GetSelectType;
  end;

var
  SelectExcelChartType: TSelectExcelChartType;

implementation

{$R *.dfm}

{ TSelectExcelChartType }

function TSelectExcelChartType.GetSelectType: TOleEnum;
begin
  case RadioGroup1.ItemIndex of
    0 :
      Result := xlLineStacked;
    1 :
      Result := xlBarStacked;
    else
      Result := xlColumnStacked;
  end;

end;

function TSelectExcelChartType.Open: Boolean;
begin
  Result := ShowModal = mrOk;

end;

procedure TSelectExcelChartType.ButtonSelectClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
