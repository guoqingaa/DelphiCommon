unit DRichTokenDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, SMS_Strings, SMS_GlobalVariables, Menus, SMS_CtrlUtils;

type
  TRichTokenDialog = class(TForm)
    RichEditTokens: TRichEdit;
    PopupMenu1: TPopupMenu;
    CopytoClipboard1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CopytoClipboard1Click(Sender: TObject);
  private
    { Private declarations }
    FTextColors : TGlobalVariableStore;
    //
    FLineCharLen : Integer;
  public
    { Public declarations }
    procedure AddTokenLine(stSplitter, stLine: String);
    procedure AddTokenLine2(stSplitter, stLine: String);
    procedure AddTokenStrings(aStrings: TStrings);
    procedure AddTextColor(stText: String; aColor : TColor);
    function Execute: Boolean;
    //
    property LineCharLen : Integer read FLineCharLen write FLineCharLen;
  end;

var
  RichTokenDialog: TRichTokenDialog;

implementation

{$R *.dfm}

{ TRichTokenDialog }

procedure TRichTokenDialog.AddTextColor(stText: String; aColor: TColor);
begin
  FTextColors.RegVariable(stText, aColor);
end;

procedure TRichTokenDialog.AddTokenLine(stSplitter, stLine: String);
var
  i : Integer;
  aTokens : TStringList;
begin
  aTokens := TStringList.Create;
  //
  try
    GetTokens(stLine, aTokens, stSplitter[1]);
    //
    for i := 0 to aTokens.Count-1 do
      RichEditTokens.Lines.Add(aTokens[i]);
  finally
    aTokens.Free;
  end;
  //

end;

procedure TRichTokenDialog.AddTokenStrings(aStrings: TStrings);
var
  i, j, iPos : Integer;
  aVariable : TGlobalVariable;
begin

  RichEditTokens.WordWrap := False;
  RichEditTokens.Lines.Assign(aStrings);
  //

  for i := 0 to FTextColors.VariableCount-1 do
  begin
    aVariable := FTextColors.Variables[i];
    //
    iPos := 0;
    for j := 0 to RichEditTokens.Lines.Count-1 do
    begin
      if Pos(aVariable.Key, UpperCase(RichEditTokens.Lines[j])) > 0 then
      begin
        RichEditTokens.SelStart := iPos;
        RichEditTokens.SelLength := Length(RichEditTokens.Lines[j]) + FLineCharLen;
        RichEditTokens.SelAttributes.Color := Round(aVariable.Value);
      end;

      iPos := iPos + Length(RichEditTokens.Lines[j]) + FLineCharLen;
    end;

  end;

end;

function TRichTokenDialog.Execute: Boolean;
begin

  RichEditTokens.SelectAll;
  RichEditTokens.SelAttributes.Name := RichEditTokens.Font.Name;
  RichEditTokens.SelAttributes.Size := RichEditTokens.Font.Size;
  RichEditTokens.SelLength := 1;

  //Show;
  Result := ShowModal = mrOk;

end;

procedure TRichTokenDialog.FormCreate(Sender: TObject);
begin
  FTextColors := TGlobalVariableStore.Create;
  FLineCharLen := 0;
end;

procedure TRichTokenDialog.FormDestroy(Sender: TObject);
begin

  FTextColors.Free;
end;


procedure TRichTokenDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TRichTokenDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
  else if (ssCtrl in Shift) and (Key in [Ord('c'), Ord('C')]) then
    Key := 0;
end;

procedure TRichTokenDialog.CopytoClipboard1Click(Sender: TObject);
begin
  StringsCopyToClipBoard(RichEditTokens.Lines);
end;

procedure TRichTokenDialog.AddTokenLine2(stSplitter, stLine: String);
var
  aTokens : TStringList;
begin
  aTokens := TStringList.Create;
  //
  try
    GetTokens(stLine, aTokens, stSplitter[1]);
    //
    AddTokenStrings(aTokens);
  finally
    aTokens.Free;
  end;
  //

end;

end.
