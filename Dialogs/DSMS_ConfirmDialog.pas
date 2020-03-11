unit DSMS_ConfirmDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TConfirmDialog = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    ButtonDeny: TButton;
    PanelConfirms: TPanel;
    GridConfirms: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridConfirmsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FTitles : TStringList;
    FDescs : TStringList;
  public
    { Public declarations }

    procedure AddConfirmMessage(stTitle, stDesc: String);

    function Execute: Boolean;
  end;

var
  ConfirmDialog: TConfirmDialog;

implementation

uses
  SMS_CtrlDrawings;

{$R *.dfm}

{ TConfirmDialog }

procedure TConfirmDialog.AddConfirmMessage(stTitle, stDesc: String);
begin
  FTitles.Add(stTitle);
  FDescs.Add(stDesc);

  if FTitles.Count > 1 then
  begin
    Height := Height + GridConfirms.DefaultRowHeight +
        GridConfirms.GridLineWidth;
    GridConfirms.Height := GridConfirms.Height +
        GridConfirms.DefaultRowHeight + GridConfirms.GridLineWidth;
    GridConfirms.RowCount := GridConfirms.RowCount + 1;
  end;

  GridConfirms.Cells[0, FTitles.Count] := stTitle;
  GridConfirms.Cells[1, FTitles.Count] := stDesc;

end;

function TConfirmDialog.Execute: Boolean;
begin
  Result := ShowModal = mrOk;

end;

procedure TConfirmDialog.FormCreate(Sender: TObject);
begin
  FTitles := TStringList.Create;
  FDescs := TStringList.Create;

  GridConfirms.ColWidths[0] := 100;
  GridConfirms.ColWidths[1] := 220;
end;

procedure TConfirmDialog.FormDestroy(Sender: TObject);
begin
  FTitles.Free;
  FDescs.Free;
end;

procedure TConfirmDialog.GridConfirmsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  GridDrawCell(GridConfirms, ACol, ARow, Rect, State);
end;

procedure TConfirmDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE  then
    ButtonDeny.Click;
end;

end.
