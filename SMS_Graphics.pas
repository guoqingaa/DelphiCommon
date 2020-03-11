unit SMS_Graphics;

interface

uses
  SysUtils, Windows, Graphics, Math;

const
  LONG_COLOR = $E4E2FC;
  SHORT_COLOR = $F5E2DA;

  NODATA_COLOR = $FFDDDD;
  FIXED_COLOR = $DDDDDD;
  HIGHLIGHT_COLOR = $80FFFF;
  SELECTED_COLOR = $FF3333;
  SELECTED_COLOR2 = $00F2BEB9;
  SELECTED_COLOR3 = $00EFD3C6;
  SELECTED_COLOR4 = $00C56A31;

  BORDER_COLOR = $00C66931;


  LTYELLOW_COLOR = $00D0FFFF;

  DISABLED_COLOR = $BBBBBB;
  ERROR_COLOR = $008080FF;
  ODD_COLOR = $FFFFFF;
  EVEN_COLOR = $EEEEEE;


type
  TRGBColor = record
    Red, Green, Blue : Byte;
  end;

  THSBColor = record
    Hue, Saturnation, Brightness : Double;
  end;

(* dRatio : 0 ~ 1 사이의 부동 소수점
*)
function GetGradationColor(aBeginColor, aEndColor: TColor; dRatio: Double): TColor;
function GetGradationColor2(aBeginColor, aEndColor: TColor; dRatio: Double): TColor;
function GetGradationColor3(aBeginColor, aEndColor: TColor; dRatio: Double): TColor;

function DecBrightness(const aColor : TColor; dRatio : Double): TColor;

(* dRatio 0~1
*)
function GetGradationColor4(aBeginColor: TColor; dRatio: Double): TColor;

procedure HSLToRGB(const Hue, Saturtion, Lightness : Double;
  var Red, Green, Blue : Byte); // HSL -> RGB

function RGBToHSB(rgb : TRGBColor) : THSBColor;

//procedure RGBtoHSL(RGB: TColor; out H, S, L: Single);

implementation

procedure HSLToRGB(const Hue, Saturtion, Lightness : Double;
  var Red, Green, Blue : Byte);

  function HueToRGB(v1, v2, vH : Double) : Double;
  begin
    if vH < 0 then vH := vH + 1;
    if vH > 1 then vH := vH - 1;

    if ((6*vH) < 1) then
      Result :=(v1 + (v2 - v1) * 6 * vH)
    else
    if ((2*vH) < 1) then
      Result := v2
    else
    if ((3*vH) < 2) then
      Result := (v1 + (v2-v1)*((2/3)-vH)*6)
    else  Result := v1;
  end;

var
  dTemp, dTemp2 : Double;
begin
  if IsZero(Saturtion) then
  begin
    Red := Round(Lightness * 255);
    Green := Round(Lightness * 255);
    Blue := Round(Lightness * 255);
  end else
  begin
    if Lightness < 0.5 then
      dTemp := Lightness * (1 + Saturtion)
    else
      dTemp := (Lightness + Saturtion) - (Saturtion * Lightness);

    dTemp2 := 2 * Lightness - dTemp;

    Red := Round( 255 * HueToRGB(dTemp2, dTemp, Hue + ( 1 / 3 )) );
    Green := Round( 255 * HueToRGB(dTemp2, dTemp, Hue) );
    Blue := Round( 255 * HueToRGB(dTemp2, dTemp, Hue - (1 / 3)) );
  end;
end;


function RGBToHSB(rgb : TRGBColor) : THSBColor;
var
  minRGB, maxRGB, delta : Double; h , s , b : Double ;
begin
  //
  H := 0.0 ;
  minRGB := Min(Min(rgb.Red, rgb.Green), rgb.Blue) ;
  maxRGB := Max(Max(rgb.Red, rgb.Green), rgb.Blue) ;
  delta := ( maxRGB - minRGB ) ;

  b := maxRGB ;

  if (maxRGB <> 0.0) then
  s := 255.0 * Delta / maxRGB
  else s := 0.0;

  if (s <> 0.0) then
  begin
  if rgb.Red = maxRGB then
  h := (rgb.Green - rgb.Blue) / Delta
  else if rgb.Green = minRGB then
  h := 2.0 + (rgb.Blue - rgb.Red) / Delta
  else if rgb.Blue = maxRGB then
  h := 4.0 + (rgb.Red - rgb.Green) / Delta
  end
  else h := -1.0; h := h * 60 ;

  if h < 0.0 then h := h + 360.0;

  with result do
  begin
    Hue := h; Saturnation := s * 100 / 255;
    Brightness := b * 100 / 255;
  end;
end;

function GetGradationColor4(aBeginColor: TColor; dRatio: Double): TColor;
var
  rgb : TRGBColor;
  hsb : THSBColor;
  r,g,b : Byte;
begin
  //
  rgb.Red := GetBValue(ColorToRGB(aBeginColor));
  rgb.Green := GetGValue(ColorToRGB(aBeginColor));
  rgb.Blue := GetBValue(ColorToRGB(aBeginColor));

  hsb := RGBToHSB(rgb);
  hsb.Brightness := 240 - Round((240 - hsb.Brightness) * dRatio);
  HSLToRGB(hsb.Hue, hsb.Saturnation, hsb.Brightness, r, g, b);
  Result := Windows.RGB(r, g, b);

end;


function GetGradationColor3(aBeginColor, aEndColor: TColor; dRatio: Double): TColor;
var
  aStartRGB, aEndRGB, aResultRGB : array[0..2] of Byte;
begin
  aStartRGB[0] := GetRValue(ColorToRGB(aBeginColor));
  aStartRGB[1] := GetGValue(ColorToRGB(aBeginColor));
  aStartRGB[2] := GetBValue(ColorToRGB(aBeginColor));
  //
  aEndRGB[0] := GetRValue(ColorToRGB(aEndColor));
  aEndRGB[1] := GetGValue(ColorToRGB(aEndColor));
  aEndRGB[2] := GetBValue(ColorToRGB(aEndColor));
  //

  aResultRGB[0] := aStartRGB[0]+Floor((aEndRGB[0]-aStartRGB[0])*dRatio);
  aResultRGB[1] := aStartRGB[1]+Floor((aEndRGB[1]-aStartRGB[1])*dRatio);
  aResultRGB[2] := aStartRGB[2]+Floor((aEndRGB[2]-aStartRGB[2])*dRatio);

  Result := RGB(aResultRGB[0], aResultRGB[1], aResultRGB[2]);

end;

function DecBrightness(const aColor : TColor; dRatio : Double): TColor;
var
  aRGB : array[0..2] of Byte;
  iR, iG, iB : Smallint;
begin
  aRGB[0] := GetRValue(ColorToRGB(aColor));
  aRGB[1] := GetGValue(ColorToRGB(aColor));
  aRGB[2] := GetBValue(ColorToRGB(aColor));
  //

  //
  aRGB[0] := 255-Round((255-aRGB[0])*(dRatio)/100);
  aRGB[1] := 255-Round((255-aRGB[1])*(dRatio)/100);
  aRGB[2] := 255-Round((255-aRGB[2])*(dRatio)/100);
  //
  Result := RGB(aRGB[0], aRGB[1], aRGB[2]);
  {
  aResultRGB[0] := aStartRGB[0]+Floor((aStartRGB[0] - aEndRGB[0])*dRatio);
  aResultRGB[1] := aStartRGB[1]+Floor((aStartRGB[1] - aEndRGB[1])*dRatio);
  aResultRGB[2] := aStartRGB[2]+Floor((aStartRGB[2] - aEndRGB[2])*dRatio);

  Result := RGB(aResultRGB[0], aResultRGB[1], aResultRGB[2]);
  }

end;

function GetGradationColor(aBeginColor, aEndColor: TColor; dRatio: Double): TColor;
var
  aStartRGB, aEndRGB, aResultRGB : array[0..2] of Byte;
  iR, iG, iB : Smallint;
begin
  aStartRGB[0] := GetRValue(ColorToRGB(aBeginColor));
  aStartRGB[1] := GetGValue(ColorToRGB(aBeginColor));
  aStartRGB[2] := GetBValue(ColorToRGB(aBeginColor));
  //
  aEndRGB[0] := GetRValue(ColorToRGB(aEndColor));
  aEndRGB[1] := GetGValue(ColorToRGB(aEndColor));
  aEndRGB[2] := GetBValue(ColorToRGB(aEndColor));
  //
  {
  iR  := aStartRGB[0]+Floor((aStartRGB[0] - aEndRGB[0])*dRatio);
  if iR < 0 then iR := iR + 255;

  iG := aStartRGB[1]+Floor((aStartRGB[1] - aEndRGB[1])*dRatio);
  if iG < 0 then iG := iG + 255;
  iB := aStartRGB[2]+Floor((aStartRGB[2] - aEndRGB[2])*dRatio);
  if iB < 0 then iB := iB + 255;
  //
  Result := RGB(iR, iG, iB);
  }

  aResultRGB[0] := aStartRGB[0]+Floor((aStartRGB[0] - aEndRGB[0])*dRatio);
  aResultRGB[1] := aStartRGB[1]+Floor((aStartRGB[1] - aEndRGB[1])*dRatio);
  aResultRGB[2] := aStartRGB[2]+Floor((aStartRGB[2] - aEndRGB[2])*dRatio);

  Result := RGB(aResultRGB[0], aResultRGB[1], aResultRGB[2]);

end;



function GetGradationColor2(aBeginColor, aEndColor: TColor; dRatio: Double): TColor;
var
  aStartRGB, aEndRGB, aResultRGB : array[0..2] of Byte;
begin
  dRatio := Max(0, dRatio);
  dRatio := Min(1, dRatio);
  //
  aStartRGB[0] := GetRValue(ColorToRGB(aBeginColor));
  aStartRGB[1] := GetGValue(ColorToRGB(aBeginColor));
  aStartRGB[2] := GetBValue(ColorToRGB(aBeginColor));
  //
  aEndRGB[0] := GetRValue(ColorToRGB(aEndColor));
  aEndRGB[1] := GetGValue(ColorToRGB(aEndColor));
  aEndRGB[2] := GetBValue(ColorToRGB(aEndColor));
  //

  aResultRGB[0] := aStartRGB[0]-Floor((aStartRGB[0] - aEndRGB[0])*dRatio);
  aResultRGB[1] := aStartRGB[1]-Floor((aStartRGB[1] - aEndRGB[1])*dRatio);
  aResultRGB[2] := aStartRGB[2]-Floor((aStartRGB[2] - aEndRGB[2])*dRatio);

  Result := RGB(aResultRGB[0], aResultRGB[1], aResultRGB[2]);

end;


procedure RGBtoHSL(aColor: TColor; out H, S, L: Single);
var
  R, G, B: Single;
  D, mx, mn: Single;
  RGB : Longint;

  function _Max(AVarFirst, AVarSecond : Single) : Single ;
  begin
    if AVarFirst < AVarSecond then
      Result := AVarSecond
    else
      Result := AVarFirst ;
  end ;

  function _Min(AVarFirst, AVarSecond : Single) : Single ;
  begin
    if AVarFirst > AVarSecond then
      Result := AVarSecond
    else
      Result := AVarFirst ;
  end ;

begin
  RGB := ColorToRGB(aColor);
  //
  R := GetRValue(RGB); //TAlphaColorRec(RGB).R / $FF;
  G := GetGValue(RGB); // TAlphaColorRec(RGB).G / $FF;
  B := GetBValue(RGB); //TAlphaColorRec(RGB).B / $FF;
  mx := _Max(_Max(R, G), B);
  mn := _Min(_Min(R, G), B);
  H := (mx + mn) / 2;
  L := H;
  S := H;
  if (mx = mn) then
  begin
    S := 0;
    H := 0;
  end
  else
  begin
    D := mx - mn;
    if L > 0.5 then
      S := D / (2 - mx - mn)
    else
      S := D / (mx + mn);
    if (mx = R) then
      H := (G - B) / D
    else if (mx = G) then
      H := (B - R) / D + 2
    else
      H := (R - G) / D + 4;
    H := H / 6;
    if H < 0 then
      H := H + 1;
  end;
end;




end.

