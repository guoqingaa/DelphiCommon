unit SMS_Log;

interface

uses
  SysUtils, Windows;



  function OctalDump(szData : PChar; iSize : Integer) : String;
  function OctalDump1(szData : PChar; iSize : Integer) : String;
  function OctalDump2(szData : PChar; iSize : Integer) : String;

type

  TConsoleMonitor = class
  private
    FConsoleHwnd : THandle;
  public
    procedure WriteLn(stLine: String);
    //
    constructor Create(iWidth : Integer = 100; iHeight : Integer = 100) ;
    destructor Destroy;
  end;

implementation


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


{ TConsoleMonitor }

constructor TConsoleMonitor.Create(iWidth, iHeight: Integer);
var
  Chars :  DWORD;
  SBSize : _COORD;
begin
  AllocConsole;
  FConsoleHwnd := CreateConsoleScreenBuffer(GENERIC_WRITE,
        FILE_SHARE_WRITE,    nil, CONSOLE_TEXTMODE_BUFFER, nil );

  SBSize.X := iWidth;
  SBSize.Y := iHeight;
  SetConsoleScreenBufferSize(FConsoleHwnd, SBSize);
  SetConsoleActiveScreenBuffer(FConsoleHwnd);

end;

destructor TConsoleMonitor.Destroy;
begin
  FreeConsole;
end;

procedure TConsoleMonitor.WriteLn(stLine: String);
var
  Chars : DWORD;
begin
  //SetConsoleTextAttribute(FConsoleHwnd , 10);

  stLine := stLine + #13#10;
  WriteConsole(FConsoleHwnd, @stLine[1], Length(stLine), Chars, nil);
end;

end.

