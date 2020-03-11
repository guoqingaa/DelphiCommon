unit SMS_StatusViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus;

type
  TStatusViewer = class(TForm)
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    Clear1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
  private
    { Private declarations }
    FAttachTime : Boolean;
    FAutoPopup: Boolean;
    function GetFont: TFont;
    function GetFontSize: Integer;
    procedure SetFont(const Value: TFont);
    procedure SetFontSize(const Value: Integer);
    function GetFontStyle: TFontStyles;
    procedure SetFontStyle(const Value: TFontStyles);


  public
    { Public declarations }
    procedure AddMessage(stMessage: String);

    property AttachTime : Boolean read FAttachTime write FAttachTime;
    property AutoPopup : Boolean read FAutoPopup write FAutoPopup;
    property FontSize : Integer read GetFontSize write SetFontSize;
    property FontStyles : TFontStyles read GetFontStyle write SetFontStyle;
  end;

var
  StatusViewer: TStatusViewer;

implementation

{$R *.dfm}

{ TStatusViewer }

procedure TStatusViewer.AddMessage(stMessage: String);
begin
  if FAttachTime then
    Memo1.Lines.Insert(0, Format('%.20s  %s', [FormatDateTime('hh:nn:ss.zzz', Now),  stMessage]))
  else
    Memo1.Lines.Insert(0, stMessage);
  //
  if FAutoPopup then
  begin
    Show;

  end;
end;

procedure TStatusViewer.FormCreate(Sender: TObject);
begin
  FAttachTime := True;
end;

function TStatusViewer.GetFont: TFont;
begin

end;

function TStatusViewer.GetFontSize: Integer;
begin
  Result := Memo1.Font.Size;
end;

function TStatusViewer.GetFontStyle: TFontStyles;
begin
  Result := Memo1.Font.Style;
end;

procedure TStatusViewer.SetFont(const Value: TFont);
begin

end;

procedure TStatusViewer.SetFontSize(const Value: Integer);
begin
   Memo1.Font.Size := Value;
end;

procedure TStatusViewer.SetFontStyle(const Value: TFontStyles);
begin
  Memo1.Font.Style := Value;

end;

procedure TStatusViewer.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TStatusViewer.Clear1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.
