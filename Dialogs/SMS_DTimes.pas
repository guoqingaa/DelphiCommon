unit SMS_DTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls, Menus;
  //                 

type
  TTimesDialog = class(TForm)
    PanelControl: TPanel;
    PanelPicker: TPanel;
    CheckApplyAll: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ButtonAdd: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Remove1: TMenuItem;
    ButtonClear: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
  private
    { Private declarations }
    FPickerList : TList;

    FTop : Integer;
    FPopupedPicker : TDateTimePicker;
    procedure AddTime(dTime: TDateTime);
    procedure RemoveTime(aPicker : TDateTimePicker);
    function GetTime(i: Integer): TDateTime;
    function GetTimeCount: Integer;
    procedure PickerContextPopup(Sender: TObject; aPoint: TPoint;var bHandled : Boolean);

  public
    { Public declarations }
    function Open(aTimes : array of Double): Boolean;
    //
    property TimeCount : Integer read GetTimeCount;
    property Times[i:Integer]: TDateTime read GetTime;

  end;

var
  TimesDialog: TTimesDialog;

implementation

const
  PICKER_Y_SPACE = 10;
  PICKER_DEF_X = 20;

{$R *.dfm}

procedure TTimesDialog.AddTime(dTime : TDateTime);
var
  aPicker : TDateTimePicker;
  iYChange : Integer;
begin
  aPicker := TDateTimePicker.Create(Self);
  aPicker.Parent := PanelPicker;
  aPicker.Kind := dtkTime;
  if dTime < 0 then
    aPicker.Time := Now
  else
    aPicker.Time := dTime;
  //
  aPicker.OnContextPopup := PickerContextPopup;
  aPicker.PopupMenu := PopupMenu1;
  FPickerList.Add(aPicker);
  aPicker.Top := FTop;
  aPicker.Left := PICKER_DEF_X;
  iYChange := aPicker.Height + PICKER_Y_SPACE;
  FTop := FTop + iYChange;
  Height := Height + iYChange;


end;

procedure TTimesDialog.FormCreate(Sender: TObject);
begin
// DateTimePicker1: TDateTimePicker;
  FTop := PICKER_Y_SPACE;
  ClientHeight := FTop + PanelControl.Height;
  FPickerList := TList.Create;
end;

procedure TTimesDialog.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to FPickerList.Count-1 do
    TObject(FPickerList.Items[i]).Free;
  FPickerList.Free;

end;

function TTimesDialog.Open(aTimes: array of Double): Boolean;
var
  i : Integer;
begin
  for i := 0 to Length(aTimes)-1 do
    AddTime(aTimes[i]);

  Result := ShowModal = mrOk;
end;

procedure TTimesDialog.SpeedButton1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TTimesDialog.ButtonAddClick(Sender: TObject);
begin
  AddTime(-1);
end;

procedure TTimesDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TTimesDialog.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TTimesDialog.GetTime(i: Integer): TDateTime;
begin
  Result := -1;
  //
  if (i >= 0) and (i < FPickerList.Count) then
    Result := TDateTimePicker(FPickerList.Items[i]).DateTime;
end;

function TTimesDialog.GetTimeCount: Integer;
begin
  Result := FPickerList.Count;
end;

procedure TTimesDialog.RemoveTime(aPicker: TDateTimePicker);
var
  i, iP : Integer;
  aPicker2 : TDateTimePicker;
begin
  iP := FPickerList.IndexOf(aPicker);
  //
  if iP < 0 then Exit;
  //
  for i := iP+1 to FPickerList.Count-1 do
  begin
    aPicker2 := TDateTimePicker(FPickerList.Items[i]);
    //
    aPicker2.Top := aPicker2.Top - aPicker.Height - PICKER_Y_SPACE;
  end;
  Height := Height - aPicker.Height - PICKER_Y_SPACE;

  FTop := FTop - aPicker.Height - PICKER_Y_SPACE;

  FPickerList.Remove(aPicker);
  aPicker.Free;
end;

procedure TTimesDialog.PickerContextPopup(Sender: TObject; aPoint: TPoint;
  var bHandled: Boolean);
begin
  //
  FPopupedPicker := Sender as TDateTimePicker;
end;


procedure TTimesDialog.Remove1Click(Sender: TObject);
begin
  if FPopupedPicker <> nil then
    RemoveTime(FPopupedPicker);
end;

procedure TTimesDialog.ButtonClearClick(Sender: TObject);
var
  i : Integer;
begin
  FPopupedPicker := nil;
  //
  for i := FPickerList.Count-1 downto 0 do
    RemoveTime(TDateTimePicker(FPickerList.Items[i]));
end;

end.
