unit SMS_Excels;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Excel_TLB, ComObj;


type

  TExcelParser = class
  private
    FApplication : IDispatch;
    FExcelApplication : ExcelApplication;

    FFilePath: String;
    FWorkSheetName: String;
    FIndexCol: Integer;
    FStartRow: Integer;

    FOutput : TStringList;
    FLastCol: Integer;
    FSplitter: String;

  public
    constructor Create;
    destructor Destroy; override;
    //
    property FilePath : String read FFilePath write FFilePath;
    property WorkSheetName : String read FWorkSheetName write FWorkSheetName;

    property IndexCol : Integer read FIndexCol write FIndexCol;
    property LastCol : Integer read FLastCol write FLastCol;
    property StartRow : Integer read FStartRow write FStartRow;
    property Output : TStringList read FOutput;

    property Splitter : String read FSplitter write FSplitter;

    procedure Execute;

  end;

  function ExportToExcel(): Boolean;

implementation

function ExportToExcel(): Boolean;
begin
(*
type
  AVarArray = array[0..3] of Variant;
  PAVarArray = ^AVarArray;
const
  EXCEL_FIXED = 15;
  EXCEL_BLACK = 1;
  EXCEL_WHITE = 2;
var
  aApplication : _Application;
  aWorkBook : _Workbook;
  aWorkSheet : _Worksheet;
  vWorkSheet : OleVariant;
  vRange : OleVariant;

  aColumn : TSColumnItem;
  i, j, iCnt : Integer;

  vValue : Variant;
  stText : String;
  dValue : Double;
  aMergedRect : TMergedRect;

  vArray : Variant;
  aSheets : OleVariant;  

begin
  //
  Result := nil;
  //
  try
    aApplication := GetActiveOleObject('Excel.Application') as _Application;
  except
    try
      aApplication := CreateOleObject('Excel.Application') as _Application;
    except
      Exit;
    end;
  end;

  Result := aApplication;
  //
  if aApplication.ActiveWorkbook = nil then
    aWorkBook := aApplication.WorkBooks.Add(NULL, 0) as _Workbook
  else
    aWorkBook := aApplication.ActiveWorkbook;
  //
  aWorkSheet := aWorkBook.Worksheets.Add(NULL, NULL, 1, xlWorkSheet, 0) as _WorkSheet;
  //
  aSheets := aWorkBook.Sheets;
  iCnt := 1;
  while True do
  begin
    vWorkSheet := NULL;
    try
      vWorkSheet := aSheets.Item[stWorkSheet];
    except
    end;
    //

    if VarIsNull(vWorkSheet) then
    begin
      aWorkSheet.Name := stWorkSheet + '_' + IntToStr(iCnt);
      Break;
    end;
    //
    Inc(iCnt);
  end;

   //
  aWorkSheet := aWorkBook.ActiveSheet as _WorkSheet;
  vWorkSheet := aWorkSheet;
  vWorkSheet.Cells.Font.Name := FGrid.Font.Name;
  vWorkSheet.Cells.Font.Size := iFontSize;
  //
  for i := 0 to FGrid.ColCount-1 do
  begin
    //
    aColumn := nil;
    //
    if FUseColumns and FOwnerColumn then
      aColumn := FGrid.Objects[i, FColumnRow] as TSColumnItem
    else if FUseColumns and (i <= FColumns.ViewList.Count-1) then
      aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
    //
    if aColumn <> nil then
    begin
      if aColumn.Alignment = taLeftJustify then
        vWorkSheet.Range[ExcelAddress(i+1, 1),
          ExcelAddress(i+1, FGrid.RowCount)].HorizontalAlignment := xlLeft
      else if aColumn.Alignment = taCenter then
        vWorkSheet.Range[ExcelAddress(i+1, 1),
          ExcelAddress(i+1, FGrid.RowCount)].HorizontalAlignment := xlCenter
      else
        vWorkSheet.Range[ExcelAddress(i+1, 1),
          ExcelAddress(i+1, FGrid.RowCount)].HorizontalAlignment := xlRight;
    end;
    //
    for j := 0 to FGrid.RowCount-1 do
    begin
      aColumn := nil;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[i, FColumnRow] as TSColumnItem
      else if FUseColumns and (i <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[i]);
      //
      if FOwnerData and (aColumn <> nil) then
      begin
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, i, j, aColumn.Title, vValue);
          if TVarData(vValue).VType = varInteger then
            stText := IntToStr(vValue)
          else if TVarData(vValue).VType = varDouble then
            stText := Format('%.*f', [aColumn.Scale, Double(vValue)])
          else if TVarData(vValue).VType = varString then
            stText := vValue;
          //
          if (TVarData(vValue).VType in [varInteger, varDouble]) and
            (aColumn.ShowColorChange) then
          begin
            try
              vWorkSheet.Cells[j+1, i+1].NumberFormat := '#,##;[»¡°­]-#,##'
            except
              try
                vWorkSheet.Cells[j+1, i+1].NumberFormat := '#,##;[RED]-#,##'
              except
              end;
            end;
          end;

          if FUseThousandComma then
          begin
            if TVarData(vValue).VType in [varInteger, varDouble] then
            begin
              dValue := vValue * 1.0;
              stText := Format('%.*n', [aColumn.Scale, dValue]);
            end;
          end;

        end;
      end else
        stText := FGrid.Cells[i, j];

      if (aColumn <> nil) and (j = FColumnRow) then
      begin
        stText := aColumn.Title;
      end;
      //
      //draw border of a cell
      //vWorkSheet.Cells[j+1, i+1].Borders.ColorIndex := EXCEL_BLACK;
      //

    end;

    if (i < FGrid.FixedCols) then
        vWorkSheet.Range[ExcelAddress(i+1, 1),
            ExcelAddress(i+1, FGrid.RowCount)].Interior.ColorIndex := EXCEL_FIXED;

  end;

  //-------------------------------------------------------------------------

  vArray := VarArrayCreate([1, FGrid.ColCount], varVariant);

  for i := 0 to FGrid.RowCount-1 do
  begin
    for j := 0 to FGrid.ColCount-1 do
    begin
      aColumn := nil;
      //
      if FUseColumns and FOwnerColumn then
        aColumn := FGrid.Objects[j, FColumnRow] as TSColumnItem
      else if FUseColumns and (j <= FColumns.ViewList.Count-1) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[j]);
      //
      if FOwnerData and (aColumn <> nil) then
      begin
        if Assigned(FOnOwnerData) then
        begin
          FOnOwnerData(FGrid, j, i, aColumn.Title, vValue);
          if TVarData(vValue).VType = varInteger then
            stText := IntToStr(vValue)
          else if TVarData(vValue).VType = varDouble then
            stText := Format('%.*f', [aColumn.Scale, Double(vValue)])
          else if TVarData(vValue).VType = varString then
            stText := vValue;
          //

          if UseThousandComma then
          begin
            if TVarData(vValue).VType in [varInteger, varDouble] then
            begin
              dValue := vValue * 1.0;
              stText := Format('%.*n', [aColumn.Scale, dValue]);
            end;
          end;

        end;
      end else
        stText := FGrid.Cells[j, i];

      if (aColumn <> nil) and (i = FColumnRow) then
      begin
        stText := aColumn.Title;
      end;
      //
      //draw border of a cell
      //vWorkSheet.Cells[j+1, i+1].Borders.ColorIndex := EXCEL_BLACK;
      //


      vArray[j+1] := stText;

      //vWorkSheet.Cells[j+1, i+1].EntireColumn.AutoFit;
    end;



    if (i < FGrid.FixedRows) then
      vWorkSheet.Range[ExcelAddress(1,i+1),
          ExcelAddress(FGrid.ColCount, i+1)].Interior.ColorIndex := EXCEL_FIXED;


    vWorkSheet.Range[ExcelAddress(1,i+1),
          ExcelAddress(FGrid.ColCount, i+1)].Value := vArray;

  end;

  //merge Ã³¸®
  for i := 0 to FGrid.RowCount-1 do
    for  j := 0 to FGrid.ColCount-1 do
      if IsMergedCell(j, i, aMergedRect) then
      begin

        if (aMergedRect.Rect.Left = j) and (aMergedRect.Rect.Top = i) then
        begin

          vWorkSheet.Cells[i+1,j+1] := aMergedRect.Value;
          vRange := vWorkSheet.Range[ExcelAddress(aMergedRect.Rect.Left+1, aMergedRect.Rect.Top+1),
                      ExcelAddress(aMergedRect.Rect.Right+1, aMergedRect.Rect.Bottom+1)];
          vRange.Merge;
          vRange.HorizontalAlignment := xlCenter;

        end;

      end;

  for i := 0 to FGrid.ColCount-1 do
    vWorkSheet.Cells[1, i+1].EntireColumn.AutoFit;

  aApplication.Visible[0] := True;

*)
end;

{ TExcelParser }

constructor TExcelParser.Create;
begin
  FOutput := TStringList.Create;
  FSplitter := ',';
end;

destructor TExcelParser.Destroy;
begin
  FOutput.Free;

  inherited;
end;

procedure TExcelParser.Execute;
var
  i : Integer;
  vApplication : OleVariant;
  aExcelApplication : ExcelApplication;
  //aWorkSheet : ExcelWorksheet;
  vWorkSheet : OleVariant;
  //aStartRange : ExcelRange;
  //vStartRange : OleVariant;

  //vIndex : OleVariant;

  //aWorkSheets : Worksheets;
  //vWorkSheets : OleVariant;

  stIndex : String;
  iP : Integer;
  stLine, stValue : String;
begin


    FApplication := CreateOleObject('Excel.Application') as _Application;
    vApplication := FApplication;

    if not FileExists(FFilePath) then Exit;
    //
    FOutput.Clear;


    vApplication.WorkBooks.Open(FFilePath);

    try
      aExcelApplication := ExcelApplication(TVarData(vApplication).VDispatch);

      vWorkSheet := vApplication.WorkSheets[FWorkSheetName];

      stIndex := vWorkSheet.Cells[FStartRow,FIndexCol];
      iP := 0;

      while (stIndex <> '') do
      begin
        stLine := stIndex;
        for i := FIndexCol+1 to FLastCol do
        begin
          stValue := vWorkSheet.Cells[FStartRow+iP, i];
          stLine := stLine + FSplitter + stValue;
        end;

        FOutput.Add(stLine);

        Inc(iP);
        stIndex := Trim(vWorkSheet.Cells[FStartRow+iP,FIndexCol])
      end;
    finally
      vApplication.Quit;
    end;

end;

end.



