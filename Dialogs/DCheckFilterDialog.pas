unit DCheckFilterDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst;

type
  TCheckFilterDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListSelecteds: TCheckListBox;
  private
    function GetISelected(i: Integer): Integer;
    function GetSelectCount: Integer;
    function GetSelected(i: Integer): String;
    function GetSelectedItem(i: Integer): TObject;
    { Private declarations }
  public
    { Public declarations }

    procedure AddItem(stItemText: String; aItem: TObject);

    function Execute : Boolean;

    property SelectCount: Integer read GetSelectCount;
    property SelectedItem[i:Integer]: TObject read GetSelectedItem;
    property Selecteds[i:Integer]: String read GetSelected;
    property ISelecteds[i:Integer]: Integer read GetISelected;
  end;

var
  CheckFilterDialog: TCheckFilterDialog;

implementation

{$R *.dfm}

{ TForm3 }

procedure TCheckFilterDialog.AddItem(stItemText: String; aItem: TObject);
begin
  ListSelecteds.AddItem(stItemText, aItem);
end;

function TCheckFilterDialog.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

function TCheckFilterDialog.GetISelected(i: Integer): Integer;
var
  iP : Integer;
begin
  Result := -1;
  //
  for iP := 0 to ListSelecteds.SelCount-1 do
    if ListSelecteds.Selected[iP] then
    begin
      Result := iP;
      Dec(i);
      //
      if i < 0 then Break;
    end;


end;

function TCheckFilterDialog.GetSelectCount: Integer;
begin
    Result := ListSelecteds.SelCount;
end;

function TCheckFilterDialog.GetSelected(i: Integer): String;
var
  iP : Integer;
begin
  Result := '';
  //
  for iP := 0 to ListSelecteds.SelCount-1 do
    if ListSelecteds.Selected[iP] then
    begin
      Result := ListSelecteds.Items.Strings[iP];
      Dec(i);
      //
      if i < 0 then Break;
    end;

end;

function TCheckFilterDialog.GetSelectedItem(i: Integer): TObject;
var
  iP : Integer;
begin
  Result := nil;
  //
  for iP := 0 to ListSelecteds.SelCount-1 do
    if ListSelecteds.Selected[iP] then
    begin
      Result := ListSelecteds.Items.Objects[iP];
      Dec(i);
      //
      if i < 0 then Break;
    end;


end;

end.
