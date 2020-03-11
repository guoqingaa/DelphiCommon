unit DStringPriority;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, SMS_ImageList;

type
  TStringPriorityConfig = class(TForm)
    ListBoxStrings: TListBox;
    EditAdd: TEdit;
    ButtonUp: TSpeedButton;
    ButtonDown: TSpeedButton;
    ButtonAdd: TSpeedButton;
    ButtonDelete: TSpeedButton;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonUpClick(Sender: TObject);
    procedure ButtonDownClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPriority : TStringList;
  public
    { Public declarations }

    function Open(aPriority : TStringList): Boolean;
  end;

var
  StringPriorityConfig: TStringPriorityConfig;

implementation

{$R *.dfm}

procedure TStringPriorityConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TStringPriorityConfig.Open(aPriority: TStringList): Boolean;
begin
  //
  FPriority := aPriority;
  ListBoxStrings.Items.Assign(aPriority);

  Result := ShowModal = mrOk;

end;

procedure TStringPriorityConfig.ButtonUpClick(Sender: TObject);
begin
  if ListBoxStrings.ItemIndex < 1 then Exit;

  ListBoxStrings.Items.Exchange(ListBoxStrings.ItemIndex, ListBoxStrings.ItemIndex-1);

end;

procedure TStringPriorityConfig.ButtonDownClick(Sender: TObject);
begin
  if (ListBoxStrings.ItemIndex < 0) or
      (ListBoxStrings.ItemIndex = ListBoxStrings.Items.Count-1) then Exit;
  //
  ListBoxStrings.Items.Exchange(ListBoxStrings.ItemIndex, ListBoxStrings.ItemIndex+1);

end;

procedure TStringPriorityConfig.ButtonAddClick(Sender: TObject);
begin
  if Length(EditAdd.Text) = 0 then Exit;
  //
  if ListBoxStrings.Items.IndexOf(EditAdd.Text) >= 0 then
  begin
    ShowMessage('duplicated input');
    Exit;
  end;
  ListBoxStrings.Items.Add(EditAdd.Text);
end;

procedure TStringPriorityConfig.ButtonDeleteClick(Sender: TObject);
begin
  if ListBoxStrings.ItemIndex < 0 then Exit;
  //
  ListBoxStrings.DeleteSelected;
end;

procedure TStringPriorityConfig.ButtonOKClick(Sender: TObject);
begin
  FPriority.Assign(ListBoxStrings.Items);
  //
  ModalResult := mrOk;
end;

procedure TStringPriorityConfig.SpeedButton1Click(Sender: TObject);
begin
  ListBoxStrings.Items.Clear;
end;

procedure TStringPriorityConfig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ButtonCancel.Click;
end;

procedure TStringPriorityConfig.FormCreate(Sender: TObject);
begin
  gAppImageList.AutoLoadButtons([ButtonAdd]);
end;

end.
