unit SMS_CtrlUtils;

interface

uses
  StdCtrls, Classes, Forms, Windows, SysUtils, ComCtrls, Clipbrd, Grids, Buttons, ExtCtrls, Controls,
  Dialogs, Math, Menus;


  //------------------------ screen -------------------------
  function IsOutofMonitor(aRect : TRect): Boolean;


  //-------------------------- ListView ----------------------

  procedure ListViewToClipBoard(aListView : TListView; bAllItems : Boolean);
  procedure ListViewToCSV(aListView: TListView; stPath: String);
  procedure RefreshListFiles(aListView: TListView; stTargetDir, stSuffix : String);
  function ListFilesCompare(Item1, Item2 : TListItem; lParamSort: Integer): Integer; stdcall;
  //procedure AutoListColumnWidth(aListView: TListView; iSpace: Integer = 3);
  //
  //-------------------------- grid ------------------------------------------
  procedure GridToClipBoardRev(aGrid: TStringGrid);
  procedure GridToClipBoard(aGrid: TStringGrid);
  procedure PullDownGrid(aGrid: TStringGrid; iRefRow: Integer);
  procedure PullDownGrid2(aGrid: TStringGrid; const iRefRow: Integer; const bExpand: Boolean = True);
  procedure PullUpGrid(aGrid: TStringGrid; iRefRow, iMaxRow: Integer);
  procedure ExchangeGridRow(aGrid: TStringGrid; iRow1, iRow2: Integer);
  procedure DeleteGridRow(aGrid : TStringGrid; iRow : Integer);
  procedure GridUpdateRow(aGrid: TStringGrid; iRow: Integer);
  procedure ClearGrid(aGrid: TStringGrid); overload;
  procedure ClearGrid(aGrid : TStringGrid; bClearObject, bExceptColumn: Boolean); overload;
  procedure ClearCellGrid(aGrid : TStringGrid; iStartRow, iStartCol: Integer); overload;
  function GridColWidth(aGrid: TStringGrid; iCol, iSpace: Integer;
             iStartRow: Integer = 0): Integer;
  procedure AutoGridColumnWidth(aGrid: TStringGrid; iStartRow : Integer = 0;
                iWidthAddition : Integer = 0);
  procedure GridCurrentPos(aGrid: TStringGrid; var iCol, iRow: Integer);
  procedure GridAutoHeight(aGrid: TStringGrid);

  //--------------------------------------------------------------------------

  procedure StatusBarAutoSize(aStatusBar: TStatusBar; iWidthAddition : Integer = 0);



  //---------------------------- combo box ---------------------------------
  procedure SetComboIndex(aCombo: TComboBox; aObj: TObject);
  procedure ApplyComboRecentlyItem(aComboBox: TComboBox; aStrings: TStrings;
              iMaxRows : Integer = 10);
  function SetCombo(aObj : TObject; aCombo : TComboBox): Boolean; //changed : true
  procedure SetCombo2(stText: String; aObj: TObject; aCombo : TComboBox; iInsP: Integer = 0);

  //-------------------------- page control --------------------------------

  function AddPage(aPageControl: TPageControl; stCaption: String) : TTabSheet;
  procedure ClearPage(aPageControl : TPageControl);

  procedure StringsCopyToClipBoard(aStrings: TStrings);

  //--------------------------- menu control --------------------------------
  procedure ClearMenu(aMenu : TMenuItem);
  procedure SetMenuChecked(aMenu: TMenuItem; aObject: TObject);



type

  TFormHandlerConfig = record
    EscClose : Boolean;
    EscapeProc: TNotifyEvent;
  end;

  TFormDefaultHandler = class
  private
    FForm : TForm;
    FEscapeProc : TNotifyEvent;
    //
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    constructor Create(aForm: TForm; aHandlerConfig: TFormHandlerConfig);
  end;


function SelectColorClick(aShape : TShape): Boolean;

implementation

uses Types;

procedure ClearMenu(aMenu : TMenuItem);
var
  i : Integer;
begin
  //
  for i := 0 to aMenu.Count-1 do
    aMenu.Free;

  for i := aMenu.Count-1 downto 0 do
    aMenu.Delete(i);
end;
//

function ListFilesCompare(Item1, Item2 : TListItem; lParamSort: Integer): Integer; stdcall;
var
  iP : Integer;
begin
  iP := Abs(lParamSort);
  //
  //Result := Item1.ImageIndex - Item2.ImageIndex;
  //
  Result := 0;
  //
  //if Result = 0 then
  //begin
    //
    if iP <= 1 then
      Result := lParamSort * CompareText(Item1.Caption, Item2.Caption)
    else
      Result := lParamSort * CompareText(Item1.SubItems[iP-2], Item2.SubItems[iP-2]);
  //end;
end;

procedure RefreshListFiles(aListView: TListView; stTargetDir, stSuffix : String);
var
  stPath : String;
  sr: TSearchRec;
  aItem : TListItem;
begin
  //
  aListView.Items.Clear;
  //
  if not DirectoryExists(stTargetDir) then Exit;
  //
  stTargetDir := IncludeTrailingPathDelimiter(stTargetDir);
  //if stTargetDir[Length(stTargetDir)] <> '\' then
  //  stTargetDir := stTargetDir + '\';
  //
  stPath := stTargetDir + '*.' + stSuffix;
  //
  if FindFirst(stPath, faAnyFile, sr) = 0 then
  begin
    aItem := aListView.Items.Add;
    aItem.Caption := ChangeFileExt(sr.Name, '');
    aItem.SubItems.Add(FormatDateTime('yyyy/mm/dd hh:nn', FileDateToDateTime(sr.Time)));
    while FindNext(sr) = 0 do
    begin
      aItem := aListView.Items.Add;
      aItem.Caption := ChangeFileExt(sr.Name, '');
      aItem.SubItems.Add(FormatDateTime('yyyy/mm/dd hh:nn', FileDateToDateTime(sr.Time)));
    end;
  end;
  FindClose(sr);

  aListView.CustomSort(@ListFilesCompare, aListView.Tag);
  //Result := True;

end;

procedure SetMenuChecked(aMenu: TMenuItem; aObject: TObject);
var
  i : Integer;
begin
  //
  if aMenu = nil then Exit;
  //
  for i := 0 to aMenu.Count-1 do
    aMenu.Items[i].Checked := False;
  //
  for i := 0 to aMenu.Count-1 do
    if aMenu.Items[i].Tag = Integer(aObject) then
    begin
      aMenu.Items[i].Checked := True;
      Break;
    end;

end;

function IsOutofMonitor(aRect: TRect): Boolean;
var
  i : Integer;
  aIntersect : TRect;
begin
  Result := True;
  for i := 0 to Screen.MonitorCount-1 do
  begin
    if IntersectRect(aIntersect, aRect, Screen.Monitors[i].BoundsRect) then //non-overlap -> false
    begin
      Result := False;
      Break;
    end;
  end;
end;

function AddPage(aPageControl: TPageControl; stCaption: String) : TTabSheet;
begin
  Result := TTabSheet.Create(aPageControl);
  Result.Caption := stCaption;
  Result.PageControl := aPageControl;
end;

procedure ClearPage(aPageControl : TPageControl);
var
  i : Integer;
begin
  for i := aPageControl.PageCount-1 downto 0 do
    aPageControl.Pages[i].Free;

end;

procedure StatusBarAutoSize(aStatusBar: TStatusBar; iWidthAddition : Integer = 0);
var
  i : Integer;
  aSize : TSize;
begin

  for i := 0 to aStatusBar.Panels.Count-1 do
  begin
    aStatusBar.Canvas.Font.Assign(aStatusBar.Font);
    aSize := aStatusBar.Canvas.TextExtent(aStatusBar.Panels[i].Text);
    aStatusBar.Panels[i].Width := Max(0, aSize.cx + iWidthAddition*2);
  end;
  aStatusBar.Invalidate;

end;

procedure AutoGridColumnWidth(aGrid: TStringGrid; iStartRow : Integer = 0;
                iWidthAddition : Integer = 0);
var
  i : Integer;
begin
  for i := 0 to aGrid.ColCount-1 do
  begin
    aGrid.ColWidths[i] := GridColWidth(aGrid, i, iWidthAddition, iStartRow);
  end;
end;

procedure GridCurrentPos(aGrid: TStringGrid; var iCol, iRow: Integer);
var
  aPoint : TPoint;
begin
  GetCursorPos(aPoint);
  aPoint := aGrid.ScreenToClient(aPoint);
  aGrid.MouseToCell(aPoint.X, aPoint.Y, iCol, iRow);
end;

procedure GridAutoHeight(aGrid: TStringGrid);
var
  aSize : TSize;
  i : Integer;
begin
  //aGrid.Canvas.Assign(aGrid.Font);

  //aGrid.Font.
  aSize := aGrid.Canvas.TextExtent('9');
  aGrid.DefaultRowHeight := aSize.cy + Round(aSize.cy*0.6);

  for i := 0 to aGrid.RowCount-1 do
    aGrid.RowHeights[i] := aGrid.DefaultRowHeight;

end;

function GridColWidth(aGrid: TStringGrid; iCol, iSpace: Integer;
   iStartRow: Integer): Integer;
var
  i : Integer;
  aSize : TSize;
begin
  Result := 0;
  //

  for i := iStartRow to aGrid.RowCount-1 do
  begin
    aSize := aGrid.Canvas.TextExtent(aGrid.Cells[iCol, i]);
    if i = iStartRow then
      Result := aSize.cx + iSpace * 2
    else
      Result := Max(Result, aSize.cx + iSpace * 2);
  end;
end;

procedure ClearGrid(aGrid : TStringGrid; bClearObject, bExceptColumn : Boolean);
var
  i, j, iRowStart : Integer;
begin
  if bExceptColumn then iRowStart := 1
  else iRowStart := 0;

  for i := 0 to aGrid.ColCount-1 do
    for j := iRowStart to aGrid.RowCount-1 do
    begin
      aGrid.Cells[i, j] := '';
      if bClearObject then aGrid.Objects[i, j] := nil;
    end;
end;

procedure ClearCellGrid(aGrid : TStringGrid; iStartRow, iStartCol: Integer);
var
  i, j : Integer;
begin

  for i := iStartCol to aGrid.ColCount-1 do
    for j := iStartRow to aGrid.RowCount-1 do
    begin
      aGrid.Cells[i, j] := '';
    end;


end;


const
  CLIP_MAXSIZE = 10000;
  CLIP_COLUMN = #9;
  CLIP_ROW = #$D#$A;

procedure StringsCopyToClipBoard(aStrings: TStrings);
var
  i : Integer;
  stClipBoard : String;
  aClipBuf : array of Char;

begin
  if aStrings = nil then Exit;
  //
  stClipBoard := '';
  //
  for i := 0 to aStrings.Count-1 do
    stClipBoard := stClipBoard + aStrings[i] + CLIP_COLUMN + CLIP_ROW;
  //
  if Length(stClipBoard) = 0 then Exit;

  SetLength(aClipBuf, Length(stClipBoard) + 2);

  StrPCopy(@aClipBuf[0], stClipBoard);
  ClipBoard.SetTextBuf(@aClipBuf[0]);
end;
{
procedure AutoListColumnWidth(aListView: TListView; iSpace: Integer);
var
  i, j : Integer;
  aListItem : TListItem;
  aListColumn : TListColumn;
  iX : Integer;
begin
  if aListView = nil then Exit;
  //
  for i := 0 to aListView.Columns.Count-1 do
  begin
    aListColumn := aListView.Column[i];

    //
    for j := 0 to aListView.Items.Count-1 do
    begin
      aListItem := aListView.Items[j];
      //
      if j = 0 then
      begin
        if i = 0 then
          iX := aListView.Canvas.TextWidth(aListItem.Caption)
        else
          iX := aListView.Canvas.TextWidth(aListItem.SubItems[i-1]);
      end else
      begin
        if i = 0 then
          iX := Max(iX, aListView.Canvas.TextWidth(aListItem.Caption))
        else
          iX := Max(iX, aListView.Canvas.TextWidth(aListItem.SubItems[i-1]));
      end;
    end;
    //
    aListColumn.Width := iX + iSpace * 2;
  end;


end;
}
procedure ListViewToClipBoard(aListView : TListView; bAllItems : Boolean);
var
  i, j : Integer;
  aListItem : TListItem;
  stClipBoard : String;
  aClipBuf : array[0..CLIP_MAXSIZE+5] of Char;
begin
  if aListView = nil then Exit;
  //
  stClipBoard := '';
  //
  for i := 0 to aListView.Items.Count-1 do
  begin

    aListItem := aListView.Items[i];

    if not(bAllItems or aListItem.Selected) then continue;

    stClipBoard := stClipBoard + aListItem.Caption + CLIP_COLUMN;

    for j := 0 to aListItem.SubItems.Count-1 do
    begin
      if j = aListItem.SubItems.Count-1 then
        stClipBoard := stClipBoard + aListItem.SubItems[j]
      else
        stClipBoard := stClipBoard + aListItem.SubItems[j] + CLIP_COLUMN
    end;

    stClipBoard := stClipBoard + CLIP_ROW;
  end;

  if Length(stClipBoard) = 0 then Exit;

  if Length(stClipBoard) > CLIP_MAXSIZE then
    stClipBoard := Copy(stClipBoard, 1, 1000);

  StrPCopy(aClipBuf, stClipBoard);
  ClipBoard.SetTextBuf(aClipBuf);

end;

procedure ListViewToCSV(aListView: TListView; stPath: String);
var
  i, j : Integer;
  aFiles : TStringList;
  //aListColumn : TListColumn;
  stLine : String;
  aListItem : TListItem;
begin
  aFiles := TStringList.Create;


  try

    for i := 0 to aListView.Columns.Count-1 do
    begin
      if i = 0 then
        stLine := aListView.Columns[0].Caption
      else
        stLine := stLine + ',' + aListView.Columns[i].Caption;
    end;
    //
    aFiles.Add(stLine);
    //
    for i := 0 to aListView.Items.Count-1 do
    begin
      aListItem := aListView.Items[i];
      stLine := aListItem.Caption;
      for j := 0 to aListItem.SubItems.Count-1 do
        stLine := stLine + ',' + aListItem.SubItems[j];
      aFiles.Add(stLine);
    end;


    aFiles.SaveToFile(stPath);
  finally
    aFiles.Free;
  end;

end;

procedure GridToClipBoardRev(aGrid: TStringGrid);
var
  i, j : Integer;
  stClip : String;
  szBuf : array[0..CLIP_MAXSIZE+5] of Char;
begin
  if aGrid = nil then Exit;
  //
  stClip := '';
  //
  for i := 0 to aGrid.ColCount-1 do
  begin
    //
    for j := 0 to aGrid.RowCount-1 do
    begin
      stClip := stClip + aGrid.Cells[i, j];
      if j <> aGrid.RowCount-1 then
        stClip := stClip + CLIP_COLUMN;
    end;
    //
    stClip := stClip + CLIP_ROW;
  end;
  //
  if Length(stClip) = 0 then Exit;
  //
  if Length(stClip) > CLIP_MAXSIZE then
    stClip := Copy(stClip, 1, 1000);
  //
  StrPCopy(szBuf, stClip);
  ClipBoard.SetTextBuf(szBuf);
end;

procedure GridToClipBoard(aGrid: TStringGrid);
var
  i, j : Integer;
  stClip : String;
  szBuf : array[0..CLIP_MAXSIZE+5] of Char;
begin
  if aGrid = nil then Exit;
  //
  stClip := '';
  //
  for i := 0 to aGrid.RowCount-1 do
  begin
    //
    for j := 0 to aGrid.ColCount-1 do
    begin
      stClip := stClip + aGrid.Cells[j, i];
      if j <> aGrid.ColCount-1 then
        stClip := stClip + CLIP_COLUMN;
    end;
    //
    stClip := stClip + CLIP_ROW;
  end;
  //
  if Length(stClip) = 0 then Exit;
  //
  if Length(stClip) > CLIP_MAXSIZE then
    stClip := Copy(stClip, 1, 1000);
  //
  StrPCopy(szBuf, stClip);
  ClipBoard.SetTextBuf(szBuf);
end;

procedure ClearGrid(aGrid: TStringGrid);
var
  i, j : Integer;
begin
  //for i := 0 to aGrid.ColCount-1 do
  //  aGrid.Cols[i].Clear;

  for i := 0 to aGrid.ColCount-1 do
    for j := 0 to aGrid.RowCount-1 do
    begin
      aGrid.Cells[i, j] := '';
      aGrid.Objects[i, j] := nil;
    end;

end;



{ TFormDefaultHandler }

constructor TFormDefaultHandler.Create(aForm: TForm; aHandlerConfig: TFormHandlerConfig);
begin
  FForm := aForm;
  //
  if aHandlerConfig.EscClose then
  begin
    FForm.KeyPreview := True;
    FEscapeProc := aHandlerConfig.EscapeProc;
    FForm.OnKeyDown := FormKeyDown;
  end;

end;

procedure TFormDefaultHandler.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if Assigned(FEscapeProc) then
      FEscapeProc(nil)
    else
      FForm.Close;
  end;
end;

function SelectColorClick(aShape : TShape): Boolean;
var
  aDialog : TColorDialog;
begin
  Result := False;
  //
  aDialog := TColorDialog.Create(nil);

  try
    aDialog.Color := aShape.Brush.Color;
    if aDialog.Execute then
    begin
      aShape.Brush.Color := aDialog.Color;
      aShape.Pen.Color := aDialog.Color;
      Result := True;
    end;
  finally
    aDialog.Free;
  end;
end;

procedure PullDownGrid(aGrid: TStringGrid; iRefRow: Integer);
var
  i, j : Integer;
begin
  if aGrid = nil then Exit;
  //
  aGrid.RowCount := aGrid.RowCount+1;
  for i := aGrid.RowCount-2 downto iRefRow do
    for j := 0 to aGrid.ColCount-1 do
    begin
      aGrid.Cells[j, i+1] := aGrid.Cells[j, i];
      aGrid.Objects[j, i+1] := aGrid.Objects[j, i];
    end;
end;

procedure PullDownGrid2(aGrid: TStringGrid;
  const iRefRow: Integer; const bExpand : Boolean);
var
  i : Integer;
begin
  if aGrid = nil then Exit;
  //
  if bExpand then
    aGrid.RowCount := aGrid.RowCount+1;

  for i := aGrid.RowCount-2 downto iRefRow do
  begin
    aGrid.Rows[i+1].Assign(aGrid.Rows[i]);
  end;
end;


procedure PullUpGrid(aGrid: TStringGrid; iRefRow, iMaxRow: Integer);
var
  i, j : Integer;
begin
  if aGrid = nil then Exit;
  //

  if iRefRow = aGrid.RowCount-1 then
  begin
    for j := 0 to aGrid.ColCount-1 do
    begin
      aGrid.Cells[j, iRefRow] := '';
      aGrid.Objects[j, iRefRow] := nil;
    end;
  end else
  begin
    for i := iRefRow+1 to aGrid.RowCount-1 do
    begin
      for j := 0 to aGrid.ColCount-1 do
      begin
        aGrid.Cells[j, i-1] := aGrid.Cells[j, i];
        aGrid.Objects[j, i-1] := aGrid.Objects[j, i];
      end;
    end;
  end;

  aGrid.RowCount := Max(iMaxRow, aGrid.RowCount-1);
end;

(*
procedure ExchangeGridRow(aGrid: TStringGrid; iRow, iRow2: Integer);
var
  i : Integer;
  stValue : String;
  aObject : TObject;
begin
  if aGrid = nil then Exit;
  //
  for i := 0 to aGrid.ColCount-1 do
  begin
    stValue := aGrid.Cells[i, iRow];
    aGrid.Cells[i, iRow] := aGrid.Cells[i, iRow2];
    aGrid.Cells[i, iRow2] := stValue;
    //
    aObject := aGrid.Objects[i, iRow];
    aGrid.Objects[i, iRow] := aGrid.Objects[i, iRow2];
    aGrid.Objects[i, iRow2] := aObject;
  end;

end;
*)
procedure ExchangeGridRow(aGrid : TStringGrid; iRow1, iRow2 : Integer);
var
  i : Integer;
  stTemp : String;
  aTemp : TObject;
begin
  if (aGrid = nil) or
    (iRow1 > aGrid.RowCount-1) or (iRow2 > aGrid.RowCount-1) then Exit;
  //
  for i := 0 to aGrid.ColCount-1 do
  begin
    stTemp := aGrid.Cells[i, iRow1];
    aTemp := aGrid.Objects[i, iRow1];

    aGrid.Cells[i, iRow1] := aGrid.Cells[i, iRow2];
    aGrid.Objects[i, iRow1] := aGrid.Objects[i, iRow2];

    aGrid.Cells[i, iRow2] := stTemp;
    aGrid.Objects[i, iRow2] := aTemp;
  end;
  //
end;



procedure GridUpdateRow(aGrid: TStringGrid; iRow: Integer);
var
  i : Integer;
begin
  if aGrid = nil then Exit;
  //
  for i := 0 to aGrid.ColCount-1 do
    aGrid.Cells[i, iRow] := '';
end;

//=========================================================================
//                      combo box utils
//=========================================================================

procedure SetComboIndex(aCombo: TComboBox; aObj: TObject);
var
  i : Integer;
begin
  if aCombo = nil then Exit;
  //
  for i := 0 to aCombo.Items.Count-1 do
  begin
    if aCombo.Items.Objects[i] = aObj then
    begin
      aCombo.ItemIndex := i;
      Break;
    end;
  end;

end;

function SetCombo(aObj : TObject; aCombo : TComboBox): Boolean;
var
  iP : Integer;
begin
  Result := False;

  if (aObj = nil) or (aCombo = nil) then Exit;
  //
  iP := aCombo.Items.IndexOfObject(aObj);
  if iP >= 0 then
  begin
    Result := aCombo.ItemIndex <> iP;
    aCombo.ItemIndex := iP;
  end;
end;

procedure SetCombo2(stText: String; aObj : TObject; aCombo : TComboBox; iInsP: Integer);
var
  iP : Integer;
begin
  if (aObj = nil) or (aCombo = nil) then Exit;
  //
  iP := aCombo.Items.IndexOfObject(aObj);
  if iP >= 0 then
    aCombo.ItemIndex := iP
  else
  begin
    aCombo.Items.InsertObject(iInsP, stText, aObj);
    aCombo.ItemIndex := iInsP;
  end;
end;

procedure ApplyComboRecentlyItem(aComboBox: TComboBox; aStrings: TStrings;
  iMaxRows: Integer);
var
  iP : Integer;
begin
  iP := aStrings.IndexOf(aComboBox.Text);
  if iP >= 0 then
    aStrings.Delete(iP);
  //
  aStrings.Insert(0, aComboBox.Text);
  //
  if aStrings.Count > iMaxRows then
    aStrings.Delete(aStrings.Count-1);
  //
  aComboBox.Items.Assign(aStrings);
  aComboBox.ItemIndex := 0;

end;

procedure DeleteGridRow(aGrid : TStringGrid; iRow : Integer);
var
  i, j : Integer;

begin
  if aGrid = nil then Exit;

  for i := iRow to aGrid.RowCount-2 do
    for j := 0 to aGrid.ColCount-1 do
    begin
      aGrid.Cells[j, i] := aGrid.Cells[j, i+1];
      aGrid.Objects[j, i] := aGrid.Objects[j, i+1];
    end;

  if aGrid.FixedRows = aGrid.RowCount-1 then
  begin

    for i := 0 to aGrid.ColCount-1 do
    begin
      aGrid.Cells[i, aGrid.RowCount-1] := '';
      aGrid.Objects[i, aGrid.RowCount-1] := nil;
    end;

  end
  else
    aGrid.RowCount := aGrid.RowCount-1;

end;



end.
