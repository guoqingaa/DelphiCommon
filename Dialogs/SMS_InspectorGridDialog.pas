unit SMS_InspectorGridDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, SMS_InspectorGrid, ExtCtrls;

type
  TInspectorGridDialog = class(TForm)
    Panel1: TPanel;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    PanelBackground: TPanel;
    PanelInspector: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FInspectorGrid: TInspectorGrid;
    FPanelMargin: Integer;
    procedure SetPanelMargin(const Value: Integer);
    function GetDialogHeight: Integer;
    procedure SetDialogHeight(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    function Execute: Boolean;

    property InspectorGrid : TInspectorGrid read FInspectorGrid;
    property PanelMargin : Integer read FPanelMargin write SetPanelMargin;
    property DialogHeight : Integer read GetDialogHeight write SetDialogHeight;
  end;

var
  InspectorGridDialog: TInspectorGridDialog;

implementation

{$R *.dfm}

const
  DEF_MARGIN = 10;

procedure TInspectorGridDialog.FormCreate(Sender: TObject);
begin
  FInspectorGrid := TInspectorGrid.Create(PanelInspector);

  SetPanelMargin(DEF_MARGIN);
end;

procedure TInspectorGridDialog.FormDestroy(Sender: TObject);
begin
  FInspectorGrid.Free;
end;

procedure TInspectorGridDialog.ButtonOKClick(Sender: TObject);
begin
  FInspectorGrid.ApplyProperties;
end;

function TInspectorGridDialog.Execute: Boolean;
begin
  FInspectorGrid.AutoSize();


  Result := ShowModal = mrOK;
  //

end;

procedure TInspectorGridDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TInspectorGridDialog.SetPanelMargin(
  const Value: Integer);
begin
  FPanelMargin := Value;

  PanelInspector.Left := FPanelMargin;
  PanelInspector.Width := PanelBackground.Width - FPanelMargin * 2;
  PanelInspector.Top := FPanelMargin;
  PanelInspector.Height := PanelBackground.Height - FPanelMargin * 2;
end;

procedure TInspectorGridDialog.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ButtonCancel.Click;

end;

function TInspectorGridDialog.GetDialogHeight: Integer;
begin
  Result := Height;
end;

procedure TInspectorGridDialog.SetDialogHeight(const Value: Integer);
begin
  Height := Value;
  //
  SetPanelMargin(FPanelMargin);
end;

end.
