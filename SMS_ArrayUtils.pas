unit SMS_ArrayUtils;

interface

uses
  Windows, SysUtils, jpeg, Types;

  procedure PushArray(var A : array of Double);
  procedure PushIntArray(var A : array of Integer);
  procedure AddtoIntArray(var A : TIntegerDynArray; const iValue: Integer);
  procedure PushValueInArray(var A : TDoubleDynArray;
              const dValue: Double; const iMaxLength: Integer);
  function FindValueInArray(var A : TIntegerDynArray; const iValue: Integer): Integer;


  procedure SortArray(var SortArray : array of Double);

implementation

function FindValueInArray(var A : TIntegerDynArray; const iValue: Integer): Integer;
var
  i : Integer;
begin
  Result := -1;
  //
  for i := 0 to Length(A)-1 do
    if A[i] = iValue then
    begin
      Result := i;
      Break;
    end;
end;

procedure PushValueInArray(var A : TDoubleDynArray;
              const dValue: Double; const iMaxLength: Integer);
var
  iLength, iDiffLength : Integer;
begin
  iLength := Length(A);
  //
  SetLength(A, iLength+1);
  A[iLength] := dValue;

  iDiffLength := (iLength + 1) - iMaxLength;
  //
  if iDiffLength <= 0 then Exit;
  //
  MoveMemory(@A[0], @A[iDiffLength], iMaxLength * SizeOf(Double));
  SetLength(A, iMaxLength);

end;

procedure AddtoIntArray(var A : TIntegerDynArray; const iValue: Integer);
var
  iLength : Integer;
begin
  iLength := Length(A);
  SetLength(A, iLength+1);
  A[iLength] := iValue;
end;

procedure QuickSort(var SortArray: array of Double; L, R : Integer);
var
  I, J: Integer;
  P, T : Double;

begin

  repeat
    I := L;
    J := R;
    P := SortArray[(L + R) shr 1];
    repeat
      while SortArray[I] <  P do
        Inc(I);
      while SortArray[J] > P do
        Dec(J);
      if I <= J then
      begin
        T := SortArray[I];
        SortArray[I] := SortArray[J];
        SortArray[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(SortArray, L, J);
    L := I;
  until I >= R;
end;

procedure SortArray(var SortArray : array of Double);
begin
  if (Length(SortArray)=0) then Exit;
  //
  QuickSort(SortArray, 0, Length(SortArray)-1);
end;



procedure PushIntArray(var A : array of Integer);
var
  i, iLength : Integer;
begin
  iLength := Length(A);
  //
  for i := iLength-1 downto 1 do
  begin
    A[i] := A[i-1];
  end;


end;

procedure PushArray(var A : array of Double);
var
  i, iLength : Integer;
begin
  iLength := Length(A);
  //
  for i := iLength-1 downto 1 do
  begin
    A[i] := A[i-1];
  end;


end;

end.




unit AppUtils;

interface

uses Classes, SysUtils, Windows, WinSock, Grids, Graphics, ComCtrls, Controls,
     StdCtrls, Math, ShellAPI, Forms, CommCtrl, jpeg, Buttons, Clipbrd,
     //
     Globals, AppTypes, AppConsts, Broadcaster, SymbolStore, MMSystem, DMessage;

type
  TOSType = (ostUnknown, ostWin95, ostWin98, ostWinMe,
  					 ostWinNT, ostWin2000, ostWinXP);
             
  _SYSTEM_INFORMATION_CLASS = (
          SystemBasicInformation,
          SystemProcessorInformation,
          SystemPerformanceInformation,
          SystemTimeOfDayInformation,
          SystemNotImplemented1,
          SystemProcessesAndThreadsInformation,
          SystemCallCounts,
          SystemConfigurationInformation,
          SystemProcessorTimes,
          SystemGlobalFlag,
          SystemNotImplemented2,
          SystemModuleInformation,
          SystemLockInformation,
          SystemNotImplemented3,
          SystemNotImplemented4,
          SystemNotImplemented5,
          SystemHandleInformation,
          SystemObjectInformation,
          SystemPagefileInformation,
          SystemInstructionEmulationCounts,
          SystemInvalidInfoClass1,
          SystemCacheInformation,
          SystemPoolTagInformation,
          SystemProcessorStatistics,
          SystemDpcInformation,
          SystemNotImplemented6,
          SystemLoadImage,
          SystemUnloadImage,
          SystemTimeAdjustment,
          SystemNotImplemented7,
          SystemNotImplemented8,
          SystemNotImplemented9,
          SystemCrashDumpInformation,
          SystemExceptionInformation,
          SystemCrashDumpStateInformation,
          SystemKernelDebuggerInformation,
          SystemContextSwitchInformation,
          SystemRegistryQuotaInformation,
          SystemLoadAndCallImage,
          SystemPrioritySeparation,
          SystemNotImplemented10,
          SystemNotImplemented11,
          SystemInvalidInfoClass2,
          SystemInvalidInfoClass3,
          SystemTimeZoneInformation,
          SystemLookasideInformation,
          SystemSetTimeSlipEvent,
          SystemCreateSession,
          SystemDeleteSession,
          SystemInvalidInfoClass4,
          SystemRangeStartInformation,
          SystemVerifierInformation,
          SystemAddVerifier,
          SystemSessionProcessesInformation);
     SYSTEM_INFORMATION_CLASS = _SYSTEM_INFORMATION_CLASS;

     TNativeQuerySystemInformation = function(
          SystemInformationClass: SYSTEM_INFORMATION_CLASS;
          SystemInformation: Pointer;
          SystemInformationLength: ULONG;
          ReturnLength: PULONG
          ): ULONG; stdcall;
/////////////////////
     _SYSTEM_PROCESSOR_TIMES = packed record
          IdleTime,
          KernelTime,
          UserTime,
          DpcTime,
          InterruptTime: int64;
          InterruptCount: ULONG;
     end;

   SYSTEM_PROCESSOR_TIMES = _SYSTEM_PROCESSOR_TIMES;
   PSYSTEM_PROCESSOR_TIMES = ^_SYSTEM_PROCESSOR_TIMES;

var
  ZwQuerySystemInformation: TNativeQuerySystemInformation;
  CPUNTUsage: PSYSTEM_PROCESSOR_TIMES;
  CPUSize: DWORD;

  MediaTime : DWORD;

//-- file related
function ReadFromFile(stFile : String) : String;
procedure SaveToFile(stFile : String; szBuf : PChar; iSize : Integer); overload;
procedure SaveToFile(stFile, stData : String); overload;

//-- string related
function UpperCompare(Str1, Str2 : String) : Integer;
function FixLenStr(stValue : String; iFixLen : Integer) : String;
//-- stream
procedure StrToBin(aBinStream : TMemoryStream; stData : String);
function BinToStr(aBinStream : TMemoryStream) : String;
//-- registry
procedure LoadControlInfo(stKey : String; aControl : TControl;
                          bHeightOnly : Boolean = False);
procedure SaveControlInfo(stKey : String; aControl : TControl;
                          bHeightOnly : Boolean = False);
function LoadUseEmex : Boolean;
function LoadUseGOM : Boolean;

//-- Edit
procedure NumericEditKeyPress(Sender: TObject; var Key: Char);
//-- combo
procedure AddSymbolCombo(aSymbol : TSymbolItem; aCombo : TComboBox);
procedure AddSymbolCombo2(aSymbol : TSymbolItem; aCombo : TComboBox);
procedure SetCombo(aObj : TObject; aCombo : TComboBox);
//-- draw events
procedure DefaultListViewDrawGridLines(ListView: TListView; ItemRect: TRect);
procedure DefaultListViewDrawItem(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
procedure DefaultListViewDrawItem2(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
procedure DefaultListViewDrawItem3(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
procedure DefaultListViewDrawItem4(ListView: TListView;   //When Use a Empty ImageList
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
procedure DefaultListViewDrawItem5(ListView: TListView;   //When Use a Empty ImageList
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
procedure DefaultListViewDrawItem6(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
procedure DefaultListVolDrawItem(ListView: TListView; Item : TListITem; Rect : TRect;
  State : TOwnerDrawState ; Statusbar : TStatusBar = nil);
procedure DefaultGridDrawCell(Grid : TStringGrid; ACol, ARow: Integer;
                          Rect: TRect; State: TGridDrawState);
procedure HeaderDrawSection(Header: THeaderControl; Section: THeaderSection;
  const Rect: TRect; Pressed: Boolean);

//-- conversion routines
function IntToStrComma(i:Integer) : String; overload;
function IntToStrComma(d:Double) : String; overload;
function CommaStrToFloat(stValue: String) : Double;
//-- parse related functions
function GetTokens(stText : String; aTokens : TStringList) : Integer; overload;
function GetTokens(stText : String; aTokens : TStringList; aSector : Char) : Integer; overload;
function GetTokens(stText : String; aTokens : TStringList;
                   aSizes : array of Integer) : Integer; overload;
//-- network related
function GetLocalIP : String;
procedure OpenURL(stURL : String; bShow : Boolean = True);

//-- misc
function OctalDump(szData : PChar; iSize : Integer) : String;
function OctalDump1(szData : PChar; iSize : Integer) : String;
function OctalDump2(szData : PChar; iSize : Integer) : String;

// -- Cpu Usage Check return


function GetOSNT:Boolean;
function GetOSType : TOSType;
function InitNTCPUData: Boolean;
function GetNTCPUData: comp;

function Init9xPerfData(ObjCounter: string): Boolean;
function Get9xPerfData(ObjCounter: string): Integer;

function SetMediaTime : Boolean;
function GetDelayTime : TTime;
function ConvertMediaTime(aWord : DWord) : TTime;

function MakeGridTPosition(aGrid: TStringGrid;
    aOptionMonth: TOptionMonthlyItem; bFixed: Boolean):Boolean;

function AddTokens(stText : array of String) : String; forward;

// -- Color Utils

function EncodeRGB(const Red, Green, Blue : Byte) : TColor; //  RGB -> TColor

// -- Realtime ATM
function GetATM(const dClose : Double) : Double;

//-- capture screen
function CaptureScreen(const stFile : String): Boolean;

//-- activeX
function RegisterActiveX(stActiveXPath : String) : Boolean;

// Symbol Code Convert
function GetSymbolDesc(stSymbolCode : String) : String;

function DrawTitleButton(Sender : TForm; aBitmap : TBitmap;
  iRightIndex : Integer; bIsDown : Boolean) : TRect;

//-- ClipBoard functions

procedure GridToClipBoard(stText : String);
function ClipBoardToGrid : String;
procedure ListViewToClipBoard(aListView : TListView; bAllItems : Boolean);

//-- grid control
procedure ClearGrid(aGrid : TStringGrid; bClearObject, bExceptColumn: Boolean);
procedure DeleteGridRow(aGrid : TStringGrid; iRow : Integer);
procedure ExchangeGridRow(aGrid : TStringGrid; iRow1, iRow2 : Integer);

procedure GridScrollAdjust(aGrid: TStringGrid; iCenter: Integer);

//-- time functions
function GetPCTime : Integer;

const
  HTHELPBTN = HTSIZELAST + 1;
  HTREFRESHBTN = HTSIZELAST + 2;

  CLIP_COLUMN = #9;
  CLIP_ROW = #$D#$A;

implementation

uses Storages, ComObj;

procedure GridScrollAdjust(aGrid: TStringGrid; iCenter: Integer);
var

  iTop, iHalf, iFixed : Integer;
begin
  if (aGrid = nil) or (iCenter < 0) or (iCenter > aGrid.RowCount-1) then Exit;

  iFixed := aGrid.FixedRows;
  iHalf := aGrid.VisibleRowCount div 2;
  iTop := iCenter - iHalf;

  if iTop + aGrid.VisibleRowCount > aGrid.RowCount-1 then
    iTop := aGrid.RowCount - aGrid.VisibleRowCount;

  aGrid.TopRow := Max(iTop, iFixed);

end;

function GetPCTime : Integer;
var
  wHour, wMin, wSec, wMSec : Word;
begin
  DecodeTime(Time, wHour, wMin, wSec, wMSec);
  Result := wHour * 60 + wMin;
end;

procedure HeaderDrawSection(Header: THeaderControl; Section: THeaderSection;
  const Rect: TRect; Pressed: Boolean);
const
  LEFT_MARGIN = 5;
var
  aBrushColor : TColor;
  aSize : TSize;
  iHeight : Integer;
begin
  with Header.Canvas do
  begin
    aBrushColor := Brush.Color;

    Brush.Color := FIXED_COLOR;
    FillRect(Rect);

    aSize := TextExtent(Section.Text);
    iHeight := Rect.Bottom - Rect.Top;

    TextRect(Rect, Rect.Left + LEFT_MARGIN,
            Rect.Top + (iHeight - aSize.cy) div 2, Section.Text);

    Brush.Color := aBrushColor;
  end;

end;

procedure ExchangeGridRow(aGrid : TStringGrid; iRow1, iRow2 : Integer);
var
  i : Integer;
  stTemp : String;
  aTemp : TObject;
begin
  if (aGrid = nil) or
    (iRow1 > aGrid.RowCount-1) or (iRow2 > aGrid.RowCount-1) then Exit;

  for i := 0 to aGrid.ColCount-1 do
  begin
    stTemp := aGrid.Cells[i, iRow1];
    aTemp := aGrid.Objects[i, iRow1];

    aGrid.Cells[i, iRow1] := aGrid.Cells[i, iRow2];
    aGrid.Objects[i, iRow1] := aGrid.Objects[i, iRow2];

    aGrid.Cells[i, iRow2] := stTemp;
    aGrid.Objects[i, iRow2] := aTemp;
  end;

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

function UpperCompare(Str1, Str2 : String) : Integer;
begin
  Result := CompareStr(UpperCase(Str1), UpperCase(Str2));
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

procedure GridToClipBoard(stText : String);
begin
  Clipboard.AsText := stText;
end;

function ClipBoardToGrid : String;
begin
  Result := ClipBoard.AsText;
end;

procedure ClipBoardToStringGrid(aGrid: TStringGrid; iPastRow, iPastCol: Integer);
var
  iLinePos, iColPos : Integer;
  stClip : String;
  stLine, stCell : String;

  iCol, iRow : Integer;

  procedure UpdateCell(stText: String);
  begin
    if (iCol = -1) or (iRow = -1) then Exit;
    if (iCol > aGrid.ColCount-1) or (iRow > aGrid.RowCount-1) then Exit;

    aGrid.Cells[iCol, iRow] := stText;
  end;

begin

  if aGrid = nil then Exit;
  if (iPastRow = -1) or (iPastCol = -1) then Exit;
  iCol := iPastCol;
  iRow := iPastRow;

  stClip := Clipboard.AsText;

  iLinePos := Pos(CLIP_ROW, stClip);


  if iLinePos = 0 then
  begin
    UpdateCell(stClip);
    Exit;
  end;

  while(iLinePos <> 0) do
  begin
    stLine := Copy(stClip, 1, iLinePos-1);
    stClip := Copy(stClip, iLinePos+2, Length(stClip)-iLinePos-1);

    iColPos := Pos(CLIP_COLUMN, stLine);

    //if iColPos = 0 then continue;

    while(iColPos <> 0) do
    begin
      stCell := Copy(stLine, 1, iColPos-1);
      stLine := Copy(stLine, iColPos+1, Length(stLine)-iColPos);

      //if Length(stLine) = 0 then continue;  //empty cell

      iColPos := Pos(CLIP_COLUMN, stLine);
      UpdateCell(stCell);
      Inc(iCol);
    end;

    if Length(stLine) > 0 then
      UpdateCell(stLine);

    iLinePos := Pos(CLIP_ROW, stClip);
    Inc(iRow);
    iCol := iPastCol;
  end;

  {
  //if Length(stClip) > 0 then
  //begin
  //  stLine := stClip;
  // iColPos := Pos(CLIP_COLUMN, stLine);

    while(iColPos <> 0) do
    begin
      stCell := Copy(stLine, 1, iColPos-1);
      stLine := Copy(stLine, iColPos+1, Length(stLine)-iColPos);
      iColPos := Pos(CLIP_COLUMN, stLine);
      UpdateCell(stCell);
      Inc(iCol);
    end;

    if Length(stLine) > 0 then
      UpdateCell(stLine);

  end;
  }

end;

procedure ListViewToClipBoard(aListView : TListView; bAllItems : Boolean);
const
  CLIP_MAXSIZE = 10000;
var
  i, j : Integer;
  aListItem : TListItem;
  stClipBoard : String;
  aClipBuf : array[0..CLIP_MAXSIZE+5] of Char;
begin
  if aListView = nil then Exit;


  stClipBoard := '';

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


function DrawTitleButton(Sender : TForm; aBitmap : TBitmap;
  iRightIndex : Integer; bIsDown : Boolean) : TRect;
var
  xFrame, yFrame, xSize, ySize : Integer;

  aButtonRect, aRect : TRect;
  iDestWidth, iDestHeight : Integer;
  iOffsetY, iOffsetX : Integer;
  aColor : TColor;

begin
  xFrame := GetSystemMetrics(SM_CXFRAME);
  yFrame := GetSystemMetrics(SM_CYFRAME);

  xSize := GetSystemMetrics(SM_CXSIZE);
  ySize := GetSystemMetrics(SM_CYSIZE);

  aButtonRect := Bounds(Sender.Width - xFrame - iRightIndex*xSize + 1,
                        yFrame + 2, xSize - 2, ySize - 4);

  Sender.Canvas.Handle := GetWindowDC(Sender.Handle);

  try
    DrawButtonFace(Sender.Canvas, aButtonRect, 1, bsAutoDetect, False, bIsDown, False);
    aRect := Bounds(aButtonRect.Left + 2, aButtonRect.Top + 2, xSize - 6, ySize - 7);


    aColor := Sender.Canvas.Brush.Color;

    Sender.Canvas.Brush.Color := EncodeRGB(212, 208, 200);
    FillRect(Sender.Canvas.Handle, Rect(aRect.Left, aRect.Top, aRect.Right-1, aRect.Bottom-1), Sender.Canvas.Brush.Handle);
    Sender.Canvas.Brush.Color := aColor;

    if aBitmap <> nil then
    begin

      iDestWidth := aRect.Right - aRect.Left;
      iDestHeight := aRect.Bottom - aRect.Top;
      iOffsetY := Max((iDestHeight - aBitmap.Height) div 2 - 1  , 0);
      iOffsetX := Max((iDestWidth - aBitmap.Width) div 2, 0);
      BitBlt(Sender.Canvas.Handle, aRect.Left+iOffsetX, aRect.Top+iOffsetY, iDestWidth, iDestHeight,
        aBitmap.Canvas.Handle, 0 , 0, SRCCOPY);
    end;

  finally
    ReleaseDC(Sender.Handle, Sender.Canvas.Handle);
    Sender.Canvas.Handle := 0;
  end;
  Result := aButtonRect;
end;


function GetSymbolDesc(stSymbolCode : String) : String;
var
  iCount : Integer;
  stYear, stMonth : String;

  function GetYearDesc(stYear: Char) : String;
  const
    DEFAULT_YEAR = 1996;
//    OFFSET_NUMBER = 10;
    OFFSET_CHAR = 55;
    YEAR_CYCLE = 30;
  var
    iYear, iCurrent, iTemp : Integer;
    iMultiple : Integer;
  begin
    iCurrent := StrToInt(FormatDateTime('yyyy', gServerInfo.StdDate));
    
    iMultiple := 0;
    iTemp := iCurrent - YEAR_CYCLE;
    while (iTemp >= DEFAULT_YEAR) do
    begin
      Inc(iMultiple);
      iTemp := iTemp-YEAR_CYCLE;
    end;

    if stYear in ['0'..'5'] then
    begin
      iYear := DEFAULT_YEAR + StrToInt(stYear) + 4;     // 1996년을 기준으로...
    end
    else if stYear in ['6'..'9'] then
    begin
      iYear := DEFAULT_YEAR + StrToInt(stYear) - 6;
    end
    else if stYear in ['A'..'H'] then
      iYear := DEFAULT_YEAR + Ord(stYear) - OFFSET_CHAR
    else if stYear in ['J'..'N'] then
      iYear := DEFAULT_YEAR + Ord(stYear) - OFFSET_CHAR - 1
    else if stYear in ['P'..'T'] then
      iYear := DEFAULT_YEAR + Ord(stYear) - OFFSET_CHAR - 2
    else if stYear in ['V'..'W'] then
      iYear := DEFAULT_YEAR + Ord(stYear) - OFFSET_CHAR - 3;

    iYear := iYear + (iMultiple * YEAR_CYCLE);

    Result := Copy(IntToStr(iYear), 3, 2);
  end;

  function GetMonthDesc(stMonth: Char) : String;
  begin
    if stMonth in ['0'..'9'] then
      Result := '0' + stMonth
    else begin
      if CompareStr(stMonth, 'A') = 0 then Result := '10'
      else if CompareStr(stMonth, 'B') = 0 then Result := '11'
      else if CompareStr(stMonth, 'C') = 0 then Result := '12';
    end;
  end;

begin
  iCount := Length(stSymbolCode);

  case iCount of
    5 :     // Future
    begin
      stYear := GetYearDesc(stSymbolCode[4]);
      stMonth := GetMonthDesc(stSymbolCode[5]);

      Result := 'F ' + stYear + stMonth;
    end;

    8 :     // Option, Spread
    begin
      stYear := GetYearDesc(stSymbolCode[4]);
      stMonth := GetMonthDesc(stSymbolCode[5]);

      case stSymbolCode[1] of
        '2' : Result := 'C ' + stYear + stMonth + ' ' + Copy(stSymbolCode, 6, 3);
        '3' : Result := 'P ' + stYear + stMonth + ' ' + Copy(stSymbolCode, 6, 3);
        '4' : Result := 'F ' + stYear[1] + stMonth[1] + ' ' + Copy(stSymbolCode, 6, 3);
      end;
    end;
  end;
  
end;

function RegisterActiveX(stActiveXPath : String) : Boolean;
type
  TDLLEntry = function : HResult ; stdcall;
var
  Handle : THandle;
  pDllEntryPoint : TDllEntry;
begin
  Result := False;

  Handle := LoadLibraryA(PAnsiChar(stActiveXPath));

  if Handle <= HINSTANCE_ERROR then Exit;

  try
    pDllEntryPoint := GetProcAddress(Handle, 'DllRegisterServer');
    if Assigned(pDllEntryPoint) then OleCheck(pDllEntryPoint)
    else Exit;

    Result := True;
  finally
    FreeLibrary(Handle);
  end;
end;



//-- realtime ATM
function GetATM(const dClose : Double) : Double;
var
  dFloatPart : Double;
  iTemp, i10, i5 : Integer;
begin
  //
  i10 := Floor(dClose / 10);
  i5 := Floor((dClose - i10 *10) / 5);

  iTemp := i10 * 10 + i5 * 5;
  dFloatPart := dClose - iTemp;

  if dFloatPart < 10/8 then Result := iTemp
  else if dFloatPart < 30/8 then Result := iTemp + 2.5
  else Result := iTemp + 5;
end;


function EncodeRGB(const Red, Green, Blue : Byte) : TColor;
begin
  Result := Red + (Green shl 8) + (Blue shl 16);
end;



function MakeGridTPosition(aGrid: TStringGrid;
    aOptionMonth: TOptionMonthlyItem; bFixed: Boolean):Boolean;
var
  i, iOffset : Integer;
begin
  Result := False;

  if aGrid = nil then Exit;

  with aGrid do
  begin
    RowCount := 0;  //Reset

    if bFixed then
      iOffset := 1
    else
      iOffset := 0;

    if aOptionMonth <> nil then
    begin
      RowCount := aOptionMonth.StrikePriceCount+iOffset;
      FixedRows := iOffset;

      if bFixed then
      begin
        Cells[0,0] := 'Call';
        Cells[1,0] := '행사가';
        Cells[2,0] := 'Put';
      end;

      if gTPositionDownOrder then
        for i := 0 to aOptionMonth.StrikePriceCount-1 do
        begin
          Cells[0, i+iOffset] := '';
          Objects[0, i+iOffset] := aOptionMonth.StrikePrices[i].Symbols[otCall];
          Cells[1, i+iOffset] := aOptionMonth.StrikePrices[i].StrikeDesc;
          if bFixed then
            Objects[1, i+iOffset] := aOptionMonth.StrikePrices[i]
          else
            Objects[1, i+iOffset] := nil;
          Cells[2, i+iOffset] := '';
          Objects[2, i+iOffset] := aOptionMonth.StrikePrices[i].Symbols[otPut];
        end
      else
        for i := 0 to aOptionMonth.StrikePriceCount-1 do
        begin
          Cells[0, RowCount-1-i] := '';
          Objects[0, RowCount-1-i] := aOptionMonth.StrikePrices[i].Symbols[otCall];
          Cells[1, RowCount-1-i] := aOptionMonth.StrikePrices[i].StrikeDesc;
          if bFixed then
            Objects[1, RowCount-1-i] := aOptionMonth.StrikePrices[i]
          else
            Objects[1, RowCount-1-i] := nil;
          Cells[2, RowCount-1-i] := '';
          Objects[2, RowCount-1-i] := aOptionMonth.StrikePrices[i].Symbols[otPut];
        end;
    end else
    begin
      RowCount := 1+iOffset;
      FixedRows := iOffset;

      if bFixed then
      begin
        Cells[0,0] := 'Call';
        Cells[1,0] := '행사가';
        Cells[2,0] := 'Put';
      end;

    end;
  end;
  Result := True;
end;

//---------------------< file related routines >--------------------//

function ReadFromFile(stFile : String) : String;
var
  aFileStream : TFileStream;
  aStrStream : TStringStream;
begin
  Result := '';
  //
  aStrStream := TStringStream.Create('');
  try
    try
      aFileStream := TFileStream.Create(stFile, fmOpenRead);
      aStrStream.Seek(0, soFromBeginning);
      aStrStream.CopyFrom(aFileStream, aFileStream.Size);
      Result := aStrStream.DataString;
      aFileStream.Free;
    except
      Exit;
    end;
  finally
    aStrStream.Free;
  end;
end;

procedure SaveToFile(stFile : String; szBuf : PChar; iSize : Integer);
var
  aFileStream: TFileStream;
begin
  //
  aFileStream := TFileStream.Create(stFile, fmCreate);
  try
    aFileStream.Write(szBuf[0], iSize);
  finally
    aFileStream.Free;
  end;
end;


procedure SaveToFile(stFile, stData : String);
var
  aFileStream: TFileStream;
begin
  //
  aFileStream := TFileStream.Create(stFile, fmCreate);
  try
    aFileStream.Write(stFile[1], Length(stFile));
  finally
    aFileStream.Free;
  end;
end;



//---------------------< String related >-----------------------//

function FixLenStr(stValue : String; iFixLen : Integer) : String;
begin
  Result := Copy(Format('%-*s',[iFixLen, stValue]), 1, iFixLen);
end;

//
// stream
//
procedure StrToBin(aBinStream : TMemoryStream; stData : String);
var
  aStrStream : TStringStream;
begin
  aStrStream := TStringStream.Create('');
  try
    aStrStream.Seek(0, soFromBeginning);
    aStrStream.WriteString(stData);
    aBinStream.Clear;
    aBinStream.LoadFromStream(aStrStream);
  finally
    aStrStream.Free;
  end;
end;

function BinToStr(aBinStream : TMemoryStream) : String;
var
  aStrStream : TStringStream;
begin
  Result := '';
  //
  aStrStream := TStringStream.Create('');
  try
    aStrStream.Seek(0, soFromBeginning);
    aBinStream.SaveToStream(aStrStream);
    Result := aStrStream.DataString;
  finally
    aStrStream.Free;
  end;
end;

//
// Open a html file
//
procedure OpenURL(stURL : String; bShow : Boolean);
var
//  aInfo : TShellExecuteInfo;
  szURL : PChar;
  szParam : PChar;
  i, iLen, iPos : Integer;
  aTokens : TStringList;
  stToken, stParam : String;
begin
  if stURL = '' then Exit;

  iLen := Length(stURL);
  if iLen = 0 then Exit;

  try
    aTokens := TStringList.Create;
    aTokens.Clear;

    szURL := nil;
    szParam := nil;

    stToken := '';
    for i:=1 to iLen do
      case stURL[i] of
        #$0D : ; // ignored
        #$09, #$0A, '^', ';', ' ' :
          begin
            aTokens.Add(stToken);
            stToken := '';
          end;
        else
          stToken := stToken + stURL[i];
      end;

    if stToken <> '' then
      aTokens.Add(stToken);

    if aTokens.Count < 0 then Exit;

    //
    szURL := PChar(AllocMem(Length(aTokens[0])+1));
    StrPCopy(szURL, aTokens[0]);

    stParam := '';
    for i:=1 to aTokens.Count-1 do
      stParam := stParam + aTokens[i] + ' ';

    if aTokens.Count > 2 then
    begin
      szParam := PChar(AllocMem(Length(stParam)+1));
      StrPCopy(szParam, stParam);
    end;

  finally
    aTokens.Free;
  end;

  {  if( VarIsEmpty( IE ) )then
  begin
     IE := CreateOleObject( csOLEObjName );
     IE.Visible := true;
     IE.Navigate( stURL );
  end else
  begin
     WinHanlde := FindWIndow( 'IEFrame', nil );
     if( 0 <> WinHanlde )then
     begin
       IE.Navigate( stURL );
       SetForegroundWindow( WinHanlde );
     end;
  end;
}
  try
    iPos := Pos('.exe', stURL);  
    if iPos > 0 then
      ShellExecute(Application.Handle, 'open', szURL, szParam, '', SW_SHOWNORMAL )
    else
      ShellExecute(Application.Handle, 'open', PChar('IEXPLORE.EXE'), szURL, '', SW_SHOWNORMAL );

  finally
    FreeMem(szURL);
  end;

{  //
  try
    with aInfo do
    begin
      cbSize := SizeOf(aInfo);
      fMask := 0;
      Wnd := Application.Handle;
      lpVerb := nil;
      lpFile := szURL;
      lpParameters := szParam;
      lpDirectory := nil;
      if bShow then
        nShow := SW_SHOWNORMAL
      else
        nShow := SW_HIDE;

      hInstApp := 0; // set on return
    end;
    ShellExecuteEx(@aInfo);
  finally
    FreeMem(szURL);
  end;
}
end;

//----------------------------< Registry >----------------------------//

procedure LoadControlInfo(stKey : String; aControl : TControl;
                          bHeightOnly : Boolean);
begin  // Control 위치/크기 복구
  if (stKey = '') or (aControl = nil) then Exit;
  //
  OpenRegistry;
  try
    if not bHeightOnly then
    begin
      aControl.Left   := GetRegistryValue(stKey, 'Left',   aControl.Left);
      aControl.Top    := GetRegistryValue(stKey, 'Top',    aControl.Top);
      aControl.Width  := GetRegistryValue(stKey, 'Width',  aControl.Width);
    end;
    aControl.Height := GetRegistryValue(stKey, 'Height', aControl.Height);
  finally
    CloseRegistry;
  end;
end;

procedure SaveControlInfo(stKey : String; aControl : TControl;
                          bHeightOnly : Boolean);
begin  // Control 위치/크기 저장
  if (stKey = '') or (aControl = nil) then Exit;
  //
  OpenRegistry;
  try
    if not bHeightOnly then
    begin
      SetRegistryValue(stKey, 'Left',   aControl.Left);
      SetRegistryValue(stKey, 'Top',    aControl.Top);
      SetRegistryValue(stKey, 'Width',  aControl.Width);
    end;
    SetRegistryValue(stKey, 'Height', aControl.Height);
  finally
    CloseRegistry;
  end;
end;

function LoadUseEmex : Boolean;
const
  REG_KEY = 'Su';
begin
  OpenRegistry;
  try
    Result := GetRegistryValue(REG_KEY, 'isUseEmex', False);
  finally
    CloseRegistry;
  end;
end;

function LoadUseGOM : Boolean;
const
  REG_KEY = 'Su';
begin
  OpenRegistry;
  try
    Result := GetRegistryValue(REG_KEY, 'isUseGom', False);
  finally
    CloseRegistry;
  end;
end;

//-------------------< Edit Routines >----------------------//

procedure NumericEditKeyPress(Sender: TObject; var Key: Char);
var
  aEdit : TEdit;
  stNum : String;
  iDist : Integer;
begin
  if (Sender = nil) or not (Sender is TEdit) then Exit;
  //
  aEdit := Sender as TEdit;
  //
  if Ord(Key) in [VK_Return,VK_Left, VK_Right, VK_DELETE, VK_BACK] then
  else
  if Key in ['0'..'9'] then
  begin
    aEdit.SelText := Key;
    iDist := Length(aEdit.Text)-aEdit.SelStart;
    //
    stNum := StringReplace(aEdit.Text, ',', '', [rfReplaceAll]);
    if stNum <> '' then
      aEdit.Text := Format('%.0n',[StrToFloat(stNum)]);
    aEdit.SelStart := Length(aEdit.Text)-iDist;
    Key := #0;
  end else
    Key := #0;
end;

//-------------------< Combo Routines >--------------------//

procedure AddSymbolCombo(aSymbol : TSymbolItem; aCombo : TComboBox);
var
  iP : Integer;
begin
  if (aSymbol = nil) or (aCombo = nil) then Exit;
  //
  iP := aCombo.Items.IndexOfObject(aSymbol);
  if iP > 0 then
    aCombo.Items.Move(iP, 0)
  else if iP < 0 then
    aCombo.Items.InsertObject(0, aSymbol.Desc, aSymbol);
  //
  aCombo.ItemIndex := 0;
end;

procedure AddSymbolCombo2(aSymbol : TSymbolItem; aCombo : TComboBox);
var
  iP : Integer;
begin
  if (aSymbol = nil) or (aCombo = nil) then Exit;
  //
  iP := aCombo.Items.IndexOfObject(aSymbol);
  if iP > 0 then
    Exit
  else
    aCombo.Items.AddObject(aSymbol.ShortDesc, aSymbol);
end;

procedure SetCombo(aObj : TObject; aCombo : TComboBox);
var
  iP : Integer;
begin
  if (aObj = nil) or (aCombo = nil) then Exit;
  //
  iP := aCombo.Items.IndexOfObject(aObj);
  if iP >= 0 then
    aCombo.ItemIndex := iP;
end;

//-------------------< Draw routines >----------------------//

procedure DefaultListViewDrawGridLines(ListView: TListView; ItemRect: TRect);
var
  i, iRight : Integer;
begin
  //
  with ListView.Canvas do
  begin
    iRight := ListView.ClientRect.Left;
    Pen.Color := clLtGray;
    Pen.Width := 1;
    
    for i:=0 to ListView.Columns.Count-1 do
    begin
      iRight := iRight + ListView_GetColumnWidth(ListView.Handle,i);
      MoveTo(iRight, ItemRect.Top);
      LineTo(iRight, ItemRect.Bottom);
    end;
  end;
end;

procedure DefaultListViewDrawItem(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
  aRefreshItem : TRefreshItem;
begin

  if (Item.Data = nil) or
     not (TObject(Item.Data) is TRefreshItem) then Exit;
  //
  Rect.Bottom := Rect.Bottom-1;
  aRefreshItem := TRefreshItem(Item.Data);
  //
  with ListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clWhite;
    end else
    begin
      Font.Color := clBlack;
      if not aRefreshItem.Refreshed then
        Brush.Color := HIGHLIGHT_COLOR
      else if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then
      if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption)
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;


end;

procedure DefaultListViewDrawItem6(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
//  aRefreshItem : TRefreshItem;
begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR2;
      Font.Color := clBlack;
    end else
    begin
      Font.Color := clBlack;
      if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then
      if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption)
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;
  

end;


procedure DefaultListViewDrawItem2(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
//  aRefreshItem : TRefreshItem;
begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clWhite;
    end else
    begin
      Font.Color := clBlack;
      if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then
      if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption)
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;
  

end;

procedure DefaultListViewDrawItem3(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
  aRefreshItem : TRefreshItem;
begin

  if (Item.Data = nil) or
     not (TObject(Item.Data) is TRefreshItem) then Exit;
  //
  Rect.Bottom := Rect.Bottom-1;
  aRefreshItem := TRefreshItem(Item.Data);
  //
  with ListView.Canvas do
  begin
    //-- color
    if State >= [odSelected, odFocused] then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clWhite;
    end else
    begin
      Font.Color := clBlack;
      if not aRefreshItem.Refreshed then
        Brush.Color := HIGHLIGHT_COLOR
      else if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then
      if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption)
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;


end;

procedure DefaultListViewDrawItem4(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;

begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clWhite;
    end else
    begin
      Font.Color := clBlack;
      if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then

      //if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption);
      {
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
      }
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;
end;

procedure DefaultListViewDrawItem5(ListView: TListView;   //When Use a Empty ImageList
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;

begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clWhite;
    end else
    begin
      Font.Color := clBlack;
      Brush.Color := clWhite;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then

      //if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption);
      {
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
      }
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;
end;


procedure DefaultListVolDrawItem(ListView: TListView; Item : TListITem; Rect : TRect;
  State : TOwnerDrawState ; Statusbar : TStatusBar = nil);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;

begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListView.Canvas do
  begin
    //-- color

    if (odSelected in State) or (odFocused in State) then
    begin
      Brush.Color := SELECTED_COLOR;
      Font.Color := clWhite;
    end else
    begin
      Font.Color := clBlack;
      if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then

      //if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption);
      {
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
      }
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;
end;

// String Grid draw

procedure DefaultGridDrawCell(Grid : TStringGrid; ACol, ARow: Integer;
                          Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;
begin
  with Grid.Canvas do
  begin
    Font.Name := Grid.Font.Name;
    Font.Size := Grid.Font.Size;
    //
    stText := Grid.Cells[ACol, ARow];
    if gdFixed in State then
    begin
      Brush.Color := FIXED_COLOR;
      Font.Color := clBlack;
      aAlignment := taLeftJustify;
    end else
    begin
      if stText = '' then
       Brush.Color := NODATA_COLOR
      else
        Brush.Color := clWhite;
      Font.Color := clBlack;
      aAlignment := taRightJustify;
    end;
    //-- background
    FillRect(Rect);
    //-- text
    if stText = '' then Exit;
    //-- calc position
    aSize := TextExtent(stText);
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
    //-- put text
    case aAlignment of
      taLeftJustify :  iX := Rect.Left + 2;
      taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx;
    end;
    TextRect(Rect, iX, iY, stText);
  end;
end;

//-------------------< Conversion routines >----------------------//

function IntToStrComma(i:Integer) : String;
begin
  Result := Format('%.0n',[i*1.0]);
end;

function IntToStrComma(d:Double) : String;
begin
  Result := Format('%.0n',[d]);
end;

function CommaStrToFloat(stValue: String) : Double;
var
  stResult : String;
begin
  Result := 0.0;
  
  if Pos(',', stValue) > 0 then
  begin
    stResult := StringReplace(stValue, ',', '', [rfReplaceAll]);

    Result := StrToFloat(stResult);
  end;
end;

//-------------------< Parsing routines >--------------------------//

function GetTokens(stText : String; aTokens : TStringList;
                   aSizes : array of Integer) : Integer;
var
  i, iLen, iP : Integer;
begin
  //-- init
  Result := 0;
  aTokens.Clear;
  //-- validates
  iLen := Length(stText);
  if iLen = 0 then Exit;
  //-- start parsing
  iP := 1;
  for i:=0 to High(aSizes) do
    if iP+aSizes[i] <= iLen+1 then
    begin
      aTokens.Add(Copy(stText, iP, aSizes[i]));
      iP := iP + aSizes[i];
    end;
  //
  Result:= aTokens.Count;
end;

function GetTokens(stText : String; aTokens : TStringList) : Integer;
var
  i, iLen : Integer;
  stToken : String;
begin
  //-- init
  Result := 0;
  aTokens.Clear;
  //--
  iLen := Length(stText);
  if iLen = 0 then Exit;
  //-- start parsing
  stToken := '';
  for i:=1 to iLen do
    case stText[i] of
      #$0D : ; // ignored
      #$09, #$0A :
        begin
          aTokens.Add(stToken);
          stToken := '';
        end;
      else
        stToken := stToken + stText[i];
    end;
  if stToken <> '' then
    aTokens.Add(stToken);
  //-- return token count
  Result := aTokens.Count;
end;

function GetTokens(stText : String; aTokens : TStringList; aSector : Char) : Integer;
var
  i, iLen : Integer;
  stToken : String;
begin
  //-- init
  Result := 0;
  aTokens.Clear;
  //--
  iLen := Length(stText);
  if iLen = 0 then Exit;
  // start parsing
  stToken := '';
  for i:= 1 to iLen do
    if stText[i] = aSector then
    begin
      aTokens.Add(stToken);
      stToken :=  '';
    end else
      stToken := stToken + stText[i];
    
  if stToken <> '' then
    aTokens.Add(stToken);
  //--
  Result := aTokens.Count;
end;

//--------------------< Network related routines >-------------------//

function GetLocalIP : String;
var
  wVersionRequested : Word;
  aWSAData : TWSAData;
  aHostEnt : PHostEnt;
  stLocalHost : String;
begin
  //--
  Result := '';
  //--
  wVersionRequested := MAKEWORD(2,0); // will use WinSock version 2
  if WSAStartup(wVersionRequested, aWSAData) <> 0 then
  begin
    // tell the user that we couldn't find a usable WinSock DLL
    Exit;
  end;
  //
  try
    // check version support
    if (LOBYTE(aWSAData.wVersion) <> 2) or
       (HIBYTE(aWSAData.wVersion) <> 0) then Exit;
    //-- get ip
    SetLength(stLocalHost, 255);
    if GetHostName(PChar(stLocalHost), 255) <> 0 then Exit;
    SetLength(stLocalHost, StrLen(PChar(stLocalHost)));
    aHostEnt := GetHostByName(PChar(stLocalHost));
    if aHostEnt = nil then Exit;
    with aHostEnt^ do
      Result := Format('%d.%d.%d.%d', [ Byte(h_addr^[0]),Byte(h_addr^[1]),
                                        Byte(h_addr^[2]),Byte(h_addr^[3])]);
  finally
    WSACleanup;
  end;
end;

function OctalDump1(szData : PChar; iSize : Integer) : String;
var
  stHexa, stText : String;
  i : Integer;
begin
  stHexa := '';
  stText := '';

  for i := 0 to iSize-1 do
  begin
    {
    if ((Ord('0') <= Ord(szData[i])) and (Ord(szData[i]) <= Ord('1'))) or
      ((Ord('A') <= Ord(szData[i])) and (Ord(szData[i]) <= Ord('Z'))) or
      ((Ord('a') <= Ord(szData[i])) and (Ord(szData[i]) <= Ord('z'))) then
      stHexa := stHexa + szData[i]
    }
    if  (33<=Ord(szData[i])) and (Ord(szData[i]) <= 126) then
      stHexa := stHexa + szData[i]
    else
      stHexa := stHexa + '.';
  end;
  Result := stHexa;

end;

function OctalDump2(szData : PChar; iSize : Integer) : String;
var
  stHexa, stText : String;
  i : Integer;
begin
  stHexa := '';
  stText := '';

  for i:=0 to iSize-1 do
  begin
    stHexa := stHexa + Format('%2.2x ', [Ord(szData[i])]);
    {
    if Ord(szData[i]) < 32 then
      stText := stText + '.'
    else
      stText := stText + szData[i];
    case i mod 16 of
      3,7,11 : stHexa := stHexa + ' ';
      15 :
        begin
          Result := Result + Format('%-51s %s '#$0D#$0A,[stHexa, stText]);
          stHexa := '';
          stText := '';
        end;
    end;
    }
  end;
  Result := stHexa;
end;


function OctalDump(szData : PChar; iSize : Integer) : String;
var
  stHexa, stText : String;
  i : Integer;
begin
  Result := #$0D#$0A;

  stHexa := '';
  stText := '';

  for i:=0 to iSize-1 do
  begin
    stHexa := stHexa + Format('%2.2x ', [Ord(szData[i])]);
    if Ord(szData[i]) < 32 then
      stText := stText + '.'
    else
      stText := stText + szData[i];
    case i mod 16 of
      3,7,11 : stHexa := stHexa + ' ';
      15 :
        begin
          Result := Result + Format('%-51s %s '#$0D#$0A,[stHexa, stText]);
          stHexa := '';
          stText := '';
        end;
    end;
  end;

  if stHexa <> '' then
    Result := Result + Format('%-51s %s',[stHexa, stText]);
end;



//------------------------------------------------------------------------------



function Get9xPerfData(ObjCounter: string): Integer;
var
  rc, dwType, cbData: DWORD;
  hOpen: HKEY;
  Buffer: DWORD;
begin
  rc:=RegOpenKeyEx(HKEY_DYN_DATA,'PerfStats\StatData',0,KEY_READ,hOpen);
  if (rc=ERROR_SUCCESS) then begin
    cbData:=sizeof(DWORD);
    rc:=RegQueryValueEx(hOpen,PChar(ObjCounter),nil,@dwType,PBYTE(@Buffer),@cbData);
    RegCloseKey(hOpen);
    if (rc=ERROR_SUCCESS) then
      Result:=Buffer
    else
      Result:=-1;
  end else
    Result:=-1;
end;

function GetNTCPUData: comp;
begin
  ZwQuerySystemInformation(SystemProcessorTimes,CPUNTUsage,CPUSize,nil);
  Result:=CPUNTUsage^.IdleTime;
end;

function GetOSNT: Boolean;
var
  OS :TOSVersionInfo;
  NTDLL_DLL: THandle;
begin
  Result:=False;
  ZeroMemory(@OS,SizeOf(OS));
  OS.dwOSVersionInfoSize:=SizeOf(OS);
  GetVersionEx(OS);
  if OS.dwPlatformId=VER_PLATFORM_WIN32_NT then begin
     NTDLL_DLL:=GetModuleHandle('NTDLL.DLL');
     @ZwQuerySystemInformation:=GetProcAddress(NTDLL_DLL,'ZwQuerySystemInformation');
     InitNTCPUData;
     Result:=True;
  end
  else begin
     Init9xPerfData('KERNEL\CPUUsage');
  end;

end;

function GetOSType : TOSType;
var
  osv :TOSVersionInfo;
  aosType : TOSType;
  NTDLL_DLL: THandle;
begin
//  Result := False;
  ZeroMemory(@osv,SizeOf(osv));
  osv.dwOSVersionInfoSize := sizeof(osv);
	GetVersionEx(osv);

	case osv.dwPlatformId of
		VER_PLATFORM_WIN32_NT :    //	Win2000, WinXP
    	begin
      	if osv.dwMajorVersion <= 4 then
		      aosType := ostWinNT
        else if (osv.dwMajorVersion = 5) and (osv.dwMinorVersion = 0) then
        	aosType := ostWin2000
        else if (osv.dwMajorVersion = 5) and (osv.dwMinorVersion = 1) then
        	aosType := ostWinXP;

        NTDLL_DLL:=GetModuleHandle('NTDLL.DLL');
	      @ZwQuerySystemInformation:=GetProcAddress(NTDLL_DLL,'ZwQuerySystemInformation');
  	    InitNTCPUData;

//    	  Result:=True;
      end;
		VER_PLATFORM_WIN32_WINDOWS :
    	begin
      	if (osv.dwMajorVersion = 4) and (osv.dwMinorVersion = 0) then
		      aosType := ostWin95
        else if (osv.dwMajorVersion = 4) and (osv.dwMinorVersion = 10) then
        	aosType := ostWin98
        else if (osv.dwMajorVersion = 4) and (osv.dwMinorVersion = 90) then
        	aosType := ostWinMe;

        Init9xPerfData('KERNEL\CPUUsage');
//      	Result := False;
      end;
		else
    begin
    	aosType := ostUnknown;
//      Result := False;
    end;
	end; //	end Case

  Result := aostype;
end;

function Init9xPerfData(ObjCounter: string): Boolean;
var
  rc, dwType, cbData: DWORD;
  hOpen: HKEY;
  pB: PByte;
begin
  rc:=RegOpenKeyEx(HKEY_DYN_DATA,'PerfStats\StartStat',0,KEY_READ,hOpen);
  if (rc=ERROR_SUCCESS) then begin
    rc:=RegQueryValueEx(hOpen,PChar(ObjCounter),nil,@dwType,nil,@cbData);
    if (rc=ERROR_SUCCESS) then begin
      pB:=AllocMem(cbData);
      rc:=RegQueryValueEx(hOpen,PChar(ObjCounter),nil,@dwType,pB,@cbData);
      FreeMem(pB);
    end else
      raise Exception.Create('Unable to read performance data');
    RegCloseKey(hOpen);
  end else
    raise Exception.Create('Unable to start performance monitoring');
  Result:=rc=ERROR_SUCCESS;

end;

function InitNTCPUData: Boolean;
var
  R: ULONG;
  n: DWORD;
begin
  n:=0;
  CPUNTUsage:=AllocMem(SizeOf(SYSTEM_PROCESSOR_TIMES));
  R:=ZwQuerySystemInformation(SystemProcessorTimes,CPUNTUsage,SizeOf(SYSTEM_PROCESSOR_TIMES),nil);
  while R = $C0000004 do begin
    Inc(n);
    ReallocMem(CPUNTUsage,n*SizeOf(CPUNTUsage^));
    R:=ZwQuerySystemInformation(SystemProcessorTimes,CPUNTUsage,n*SizeOf(SYSTEM_PROCESSOR_TIMES),nil);
  end;
  CPUSize:=n*SizeOf(CPUNTUsage^);
  Result:=R=$00000000;

end;


function SetMediaTime : Boolean;
begin


  MediaTime := TimeGetTime;
  Result:= True;
end;

function GetDelayTime : TTime;
begin
  Result:= ConvertMediaTime(TimeGetTime-MediaTime);
end;


function ConvertMediaTime(aWord : DWord) : TTime;
var
  //iYear, iMonth, iDay,
  iHour, iMin, iSec, iMSec : DWORD;
  iDivHour , iDivMin , iDivSec : DWORD;
begin
  iDivHour := 60 * 60 * 1000;
  iDivMin := 60 * 1000;
  iDivSec := 1000;

  {iYear := aWord div 10000000000000;
  aWord := aWord mod 10000000000000;

  iMonth := aWord div 100000000000;
  aWord := aWord mod 100000000000;

  iDay := aWord div 1000000000;
  aWord := aWord mod 1000000000;}

  iHour := aWord div iDivHour;
  aWord := aWord - iHour*iDivHour;

  iMin := aWord div iDivMin;
  aWord := aWord - iMin*iDivHour;

  iSec := aWord div iDivSec;
  iMSec := aWord - iSec*iDivSec;

  {

  iHour := aWord div 10000000;
  aWord := aWord mod 10000000;

  iMin := aWord div 100000;
  aWord := aWord mod 100000;

  iSec := aWord div 1000;
  iMSec := aWord mod 1000;
  }
  {Result:= IntToStr(iHour) + ':' +
           IntToStr(iMin) + ':' +
           IntToStr(iSec) + ':' +
           IntToStr(iMSec);}

  Result:= //EncodeDate(iYear , iMonth , iDay) +
           EncodeTime(iHour , iMin , iSec, iMSec);

end;


function AddTokens(stText : array of String) : String;
const
  CH_TAB = #$09;
  CH_LF = #$0A;

var
  i, iLen : Integer;
begin
  iLen := High(stText);

  Result:= '';

  for i:= 0 to iLen do
  begin
    Result := Result + stText[i] + CH_TAB;
  end;
end;


TRegistry .. class어어
https://one-zero.tistory.com/entry/레지스트리Registry-등록

end.

