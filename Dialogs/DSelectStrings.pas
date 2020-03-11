unit DSelectStrings;

interface

//
// »ç¿ë : FEFOrder
//

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TSelectStrings = class(TForm)
    ListStrings: TListBox;
    LabelTitle: TLabel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
  private
    function GetSelected: TObject;
    { Private declarations }
  public
    { Public declarations }

    function Open(aStrings: TStrings; aSelected: TObject): Boolean;

    property Selected : TObject read GetSelected;
  end;


function SelectStrings(aOwner: TForm; stTitle: String;
  aStrings: TStrings; aSelected: TObject = nil): TObject;

implementation

{$R *.dfm}

function SelectStrings(aOwner: TForm; stTitle: String; aStrings: TStrings;
  aSelected : TObject): TObject;
var
  aDialog : TSelectStrings;
begin
  //
  Result := nil;
  //
  aDialog := TSelectStrings.Create(aOwner);
  //
  aDialog.Caption := stTitle;
  aDialog.LabelTitle.Caption := stTitle;
  if aDialog.Open(aStrings, aSelected) then
    Result := aDialog.Selected;

end;


{ TForm3 }

function TSelectStrings.GetSelected: TObject;
begin
  Result := ListStrings.Items.Objects[ListStrings.ItemIndex];
end;

function TSelectStrings.Open(aStrings: TStrings; aSelected : TObject): Boolean;
var
  iP : Integer;
begin
  ListStrings.Items.Assign(aStrings);

  iP := ListStrings.Items.IndexOfObject(aSelected);
  if iP >= 0 then
    ListStrings.ItemIndex := iP;

  Result := ShowModal = mrOk;

end;

procedure TSelectStrings.Button1Click(Sender: TObject);
begin
  if ListStrings.ItemIndex < 0 then Exit;
  //
  ModalResult := mrOk;
end;

end.
