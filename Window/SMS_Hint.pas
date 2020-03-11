unit SMS_Hint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Math;


const
  DEF_AUTO_SECOND = 3;

type
  TSMSHint = class(TForm)
    PaintHint: TPaintBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintHintPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaintHintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FTimer : TTimer;
    FStrings : TStringList;

    procedure TimerProc(Sender: TObject);
  public
    { Public declarations }
    procedure AddLine(stLine: String);
    procedure ShowHint(iAutoCloseSec: Integer = DEF_AUTO_SECOND);
  end;

//
procedure ShowSHint(const iAutoCloseSec: Integer = DEF_AUTO_SECOND);
function NewSHint: TSMSHint;

implementation

var
  gHint : TSMSHint = nil;

{$R *.dfm}



function NewSHint: TSMSHint;
begin
  if gHint <> nil then
    gHint.Free;

  Result := TSMSHint.Create(nil);
  gHint := Result;
end;

procedure ShowSHint(const iAutoCloseSec: Integer = DEF_AUTO_SECOND);
//var
//  aHint : TSMSHint;
begin
  if gHint <> nil then
    gHint.Free;
  //
  gHint := TSMSHint.Create(nil);
  gHint.ShowHint(iAutoCloseSec);

end;

procedure TSMSHint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSMSHint.ShowHint(iAutoCloseSec: Integer);
const
  HINT_POSITION_OFFSET = 10;
var
  aPoint : TPoint;
begin
  GetCursorPos(aPoint);
  Left := aPoint.X + HINT_POSITION_OFFSET;
  Top := aPoint.Y + HINT_POSITION_OFFSET;

  if iAutoCloseSec > 0 then
  begin
    FTimer := TTimer.Create(nil);
    FTimer.OnTimer := TimerProc;
    FTimer.Interval := iAutoCloseSec * 1000;
  end;

  Show;

end;

procedure TSMSHint.FormCreate(Sender: TObject);
begin
  //
  FStrings := TStringList.Create;
end;

procedure TSMSHint.FormDestroy(Sender: TObject);
begin
  //
  FStrings.Free;

  if FTimer <> nil then
    FTimer.Free;
  //
  if gHint = Self then
    gHint := nil;
end;

procedure TSMSHint.TimerProc(Sender: TObject);
begin
  //
  Release;
end;

procedure TSMSHint.AddLine(stLine: String);
begin
  FStrings.Add(stLine);

end;

procedure TSMSHint.PaintHintPaint(Sender: TObject);
const
  X_START = 3;
  LINE_Y_SPACE = 3;
  BACK_COLOR = clYellow;
var
  aSize : TSize;
  i, iX, iY : Integer;
begin
  with PaintHint.Canvas do
  begin
    iY := LINE_Y_SPACE;
    iX := X_START;

    for i := 0 to FStrings.Count-1 do
    begin
      aSize := TextExtent(FStrings[i]);
      Inc(iY, aSize.cy);
      Inc(iY, LINE_Y_SPACE);
      iX := Max(iX, aSize.cx+LINE_Y_SPACE*2);
    end;


    ClientHeight := iY;
    ClientWidth := iX;

    Brush.Color := BACK_COLOR;
    FillRect(PaintHint.BoundsRect);

    //Pen.Color := clBlack;
    Brush.Color := clBlack;
    FrameRect(PaintHint.BoundsRect);
    //FillRect(PaintHint.BoundsRect);
    //

    iY := LINE_Y_SPACE;
    Brush.Color := BACK_COLOR;
    for i := 0 to FStrings.Count-1 do
    begin

      TextOut(X_START, iY, FStrings[i]);
      Inc(iY, aSize.cy);
      Inc(iY, LINE_Y_SPACE);

    end;


  end;
end;

procedure TSMSHint.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Release;
end;

procedure TSMSHint.PaintHintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    Release;

end;


initialization

finalization
  if gHint <> nil then
    gHint.Free;

end.
