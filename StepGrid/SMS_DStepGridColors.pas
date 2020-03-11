unit SMS_DStepGridColors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TStepGridColorDialog = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ShapePosBack: TShape;
    SpeedButton4: TSpeedButton;
    ShapePosFont: TShape;
    SpeedButton1: TSpeedButton;
    ShapeNegBack: TShape;
    SpeedButton2: TSpeedButton;
    ShapeNegFont: TShape;
    SpeedButton3: TSpeedButton;
    ButtonOK: TButton;
    Button2: TButton;
    Label5: TLabel;
    ShapeFixed: TShape;
    SpeedButton5: TSpeedButton;
    Label6: TLabel;
    ShapeSelectedColor: TShape;
    SpeedButton6: TSpeedButton;
    Label7: TLabel;
    ShapeSelectedFont: TShape;
    SpeedButton7: TSpeedButton;
    ColorDialog1: TColorDialog;
    procedure SpeedColorButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StepGridColorDialog: TStepGridColorDialog;

implementation

{$R *.dfm}

procedure TStepGridColorDialog.SpeedColorButtonClick(Sender: TObject);
var
  aButton : TSpeedButton;
  aShape : TShape;
begin
  //
  aButton := Sender as TSpeedButton;
  //
  //aShape := nil;
  case aButton.Tag of
    1 :
      aShape := ShapeFixed;
    2 :
      aShape := ShapeSelectedColor;
    3 :
      aShape := ShapeSelectedFont;
    4 :
      aShape := ShapePosBack;
    5 :
      aShape := ShapePosFont;
    6 :
      aShape := ShapeNegBack;
    7 :
      aShape := ShapeNegFont;
    else
      Exit;
  end;
  //
  ColorDialog1.Color := aShape.Brush.Color;
  //
  if ColorDialog1.Execute then
    aShape.Brush.Color := ColorDialog1.Color;
end;

end.
