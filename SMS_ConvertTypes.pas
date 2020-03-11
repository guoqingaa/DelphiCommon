unit SMS_ConvertTypes;

interface

uses Windows, SysUtils,Dialogs;

type
  //-- union definiton for convertine ordinary type to char buffer
  TWordUnion = packed record
    case Integer of
      1 : (wValue : SmallInt);
      2 : (cBuf : array[0..1] of AnsiChar)
    end;

  TUWordUnion = packed record
    case Integer of
      1 : (wValue : Word);
      2 : (cBuf : array[0..1] of AnsiChar)
    end;

  TLongUnion = packed record
    case Integer of
      1 : (lValue : LongInt ) ;
      2 : (cBuf : array[0..3] of AnsiChar ) ;
    end;

  TULongUnion = packed record
    case Integer of
      1 : (lValue : Cardinal ) ;
      2 : (cBuf : array[0..3] of AnsiChar ) ;
    end;

  TFloatUnion = packed record
    case Integer of
      1 : (sValue : Single ) ;
      2 : (cBuf : array[0..3] of AnsiChar ) ;
    end;

  TDoubleUnion = packed record
    case Integer of
      1 : (dValue : Double ) ;
      2 : (cBuf : array[0..7] of AnsiChar ) ;
    end;

  TInt64Union = packed record
    case Integer of
      1 : (lValue : Int64 ) ;
      2 : (cBuf : array[0..7] of AnsiChar ) ;
    end;


  TDLUnion = packed record
    case Integer of
      1 : (Value : Double);
      2 : (Low, High : Integer);
  end;

function DLToDouble(iLongHigh, iLongLow : Integer): Double;
procedure DoubleToDL(dValue: Double;var iLongHigh, iLongLow: Integer);

function ConvertWord (szBuffer : PAnsiChar; var iP  : Integer; wValue : SmallInt) : Boolean;
function ConvertUWord(szBuffer : PAnsiChar; var iP : Integer; wValue : Word) : Boolean;
function ConvertLong(szBuffer : PAnsiChar; var iP : Integer; lValue : LongInt) : Boolean;
function ConvertULong(szBuffer : PAnsiChar; var iP : Integer; lValue : Cardinal) : Boolean;
function ConvertFloat(szBuffer : PAnsiChar; var iP : Integer; sValue : Single) : Boolean;
function ConvertDouble(szBuffer : PAnsiChar; var iP : Integer; dValue : Double) : Boolean;
function ConvertString(szBuffer : PAnsiChar; var iP : Integer; stValue : String) : Boolean;
function ConvertBytes(szBuffer : PAnsiChar; var iP : Integer; stValue : String) : Boolean;
function ConvertByte(szBuffer : PAnsiChar; var iP : Integer; byteValue : Byte) : Boolean;

function DeconvertWord(szBuffer : PAnsiChar; var iP : Integer; var wValue : SmallInt) : Boolean;
function DeconvertUWord(szBuffer : PAnsiChar; var iP : Integer; var wValue : Word) : Boolean;
function DeconvertLong(szBuffer : PAnsiChar; var iP : Integer; var lValue : LongInt) : Boolean;
function DeconvertULong(szBuffer : PAnsiChar; var iP : Integer; var lValue : Cardinal) : Boolean;
function DeconvertFloat(szBuffer : PAnsiChar; var iP : Integer; var sValue : Single) : Boolean;
function DeconvertDouble(szBuffer : PAnsiChar; var iP : Integer; var dValue : Double) : Boolean;
function DeconvertString(szBuffer : PAnsiChar; var iP : Integer; var stValue : String) : Boolean;
function DeconvertBytes(szBuffer : PAnsiChar; var iP : Integer; var stValue : String; iLen : Integer) : Boolean;
function DeconvertByte(szBuffer : PAnsiChar; var iP : Integer; var stValue : Byte) : Boolean;
function LDeconvertInt64(szBuffer : PAnsiChar; var iP : Integer; var lValue : Int64) : Boolean;

implementation

procedure DoubleToDL(dValue: Double;var iLongHigh, iLongLow: Integer);
var
  dDoubleLongUnion : TDLUnion;
begin
  dDoubleLongUnion.Value := dValue;
  iLongHigh := dDoubleLongUnion.High;
  iLongLow := dDoubleLongUnion.Low;
end;

function DLToDouble(iLongHigh, iLongLow : Integer): Double;
var
  dDoubleLongUnion : TDLUnion;

begin
  dDoubleLongUnion.High := iLongHigh;
  dDoubleLongUnion.Low := iLongLow;

  Result := dDoubleLongUnion.Value;
end;

function LDeconvertInt64(szBuffer : PAnsiChar; var iP : Integer; var lValue : Int64) : Boolean;

var
  recInt64 : TInt64Union;
begin
  try
    recInt64.cBuf[0] := szBuffer[iP+0];
    recInt64.cBuf[1] := szBuffer[iP+1];
    recInt64.cBuf[2] := szBuffer[iP+2];
    recInt64.cBuf[3] := szBuffer[iP+3];
    recInt64.cBuf[4] := szBuffer[iP+4];
    recInt64.cBuf[5] := szBuffer[iP+5];
    recInt64.cBuf[6] := szBuffer[iP+6];
    recInt64.cBuf[7] := szBuffer[iP+7];
    iP := iP+8;
    lValue := recInt64.lValue;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertWord(szBuffer : PAnsiChar; var iP : Integer; wValue : SmallInt) : Boolean;
var
  recSmall : TWordUnion;
begin
  try
    recSmall.wValue := wValue;
//    szBuffer[iP] := recSmall.cBuf[1];
//    szBuffer[iP+1] := recSmall.cBuf[0];
    szBuffer[iP] := recSmall.cBuf[0];
    szBuffer[iP+1] := recSmall.cBuf[1];
    iP := iP + 2;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertUWord(szBuffer : PAnsiChar; var iP : Integer; wValue : Word) : Boolean;
var
  recWord : TUWordUnion;
begin
  try
    recWord.wValue := wValue;
    szBuffer[ip] := recWord.cBuf[1];
    szBuffer[ip+1] := recWord.cBuf[0];
    iP := iP + 2;
    Result := True;
  except
    Result:= False;
  end;
end;


function ConvertLong(szBuffer : PAnsiChar; var iP : Integer; lValue : LongInt) : Boolean;
var
  recLong : TLongUnion;
//  szBuff : array[0..3] of AnsiChar;
begin
  try
    recLong.lValue := lValue;
    {
    szBuffer[iP] := recLong.cBuf[3];
    szBuffer[iP+1] := recLong.cBuf[2];
    szBuffer[iP+2] := recLong.cBuf[1];
    szBuffer[iP+3] := recLong.cBuf[0];
    }
    szBuffer[iP] := recLong.cBuf[0];
    szBuffer[iP+1] := recLong.cBuf[1];
    szBuffer[iP+2] := recLong.cBuf[2];
    szBuffer[iP+3] := recLong.cBuf[3];


    iP := iP + 4;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertULong(szBuffer : PAnsiChar; var iP : Integer; lValue : Cardinal) : Boolean;
var
  recLong : TULongUnion;
//  szBuff : array[0..3] of AnsiChar;
begin
  try
    recLong.lValue := lValue;
    szBuffer[iP] := recLong.cBuf[3];
    szBuffer[iP+1] := recLong.cBuf[2];
    szBuffer[iP+2] := recLong.cBuf[1];
    szBuffer[iP+3] := recLong.cBuf[0];
    iP := iP + 4;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertFloat(szBuffer : PAnsiChar; var iP : Integer; sValue : Single) : Boolean;
var
  recFloat : TFloatUnion;
//  szBuff : array[0..3] of AnsiChar;
begin
  try
    recFloat.sValue := sValue;
    szBuffer[iP]   := recFloat.cBuf[3];
    szBuffer[iP+1] := recFloat.cBuf[2];
    szBuffer[iP+2] := recFloat.cBuf[1];
    szBuffer[iP+3] := recFloat.cBuf[0];
    iP := iP + 4;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertDouble(szBuffer : PAnsiChar; var iP : Integer; dValue : Double) : Boolean;
var
  recDouble : TDoubleUnion;
//  szBuff : array[0..7] of AnsiChar;
begin
  try
    recDouble.dValue := dValue;
    szBuffer[iP]   := recDouble.cBuf[7];
    szBuffer[iP+1] := recDouble.cBuf[6];
    szBuffer[iP+2] := recDouble.cBuf[5];
    szBuffer[iP+3] := recDouble.cBuf[4];
    szBuffer[iP+4] := recDouble.cBuf[3];
    szBuffer[iP+5] := recDouble.cBuf[2];
    szBuffer[iP+6] := recDouble.cBuf[1];
    szBuffer[iP+7] := recDouble.cBuf[0];
    iP := iP + 8;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertString(szBuffer : PAnsiChar; var iP : Integer; stValue : String) : Boolean;
var
//  i : integer;
  iSize : SmallInt;
begin
  try
    iSize := Length(stValue);
    ConvertWord(szBuffer, iP, iSize);
//    ConvertLong(szBuffer, iP, iSize);

    CopyMemory(szBuffer+iP,@stValue[1], Length(stValue));
    iP := iP + Length(stValue) ;
    Result := True;
  except
    Result := False;
  end;
end;

function ConvertBytes(szBuffer : PAnsiChar; var iP : Integer; stValue : String) : Boolean;
var
  iSize : Integer;
begin
  try
    iSize := Length(stValue);

    CopyMemory(szBuffer + iP, @stValue[1], iSize);

    iP := iP + iSize;

    Result := True;
  except
    Result := False;
  end;
end;

// -----------------------------------------------------------------------------
//
//
function ConvertByte(szBuffer : PAnsiChar; var iP : Integer; byteValue : Byte) : Boolean;
begin
  try
    CopyMemory(szBuffer + iP, @byteValue, 1);

    iP := iP + 1;

    Result := True;
  except
    Result := False;
  end;
end;


function DeConvertWord(szBuffer : PAnsiChar; var iP : Integer; var wValue : SmallInt) : Boolean;
var
  recSmallInt : TWordUnion;
//  i : integer;
begin
  try
    recSmallInt.cBuf[0] := szBuffer[iP+0];
    recSmallInt.cBuf[1] := szBuffer[iP+1];
    {
    recSmallInt.cBuf[0] := szBuffer[iP+1];
    recSmallInt.cBuf[1] := szBuffer[iP+0];
    }
    wValue := recSmallInt.wValue;
    iP := iP + 2;
    Result := True;
  except
    Result := False;
  end;
end;

function DeconvertUWord(szBuffer : PAnsiChar; var iP : Integer; var wValue : Word) : Boolean;
var
  recSmallInt : TUWordUnion;
begin
  try
    recSmallInt.cBuf[0] := szBuffer[iP+1];
    recSmallInt.cBuf[1] := szBuffer[iP+0];

    wValue := recSmallInt.wValue;
    iP := iP + 2;
    Result := True;
  except;
    Result := False;
  end;
end;

function DeconvertLong(szBuffer : PAnsiChar; var iP : Integer; var lValue : LongInt) : Boolean;
var
  recLong : TLongUnion;
//  i : Integer;
begin
  try
    CopyMemory(@recLong.cBuf[0], szBuffer+iP, 4);


    recLong.cBuf[0] := szBuffer[iP+0];
    recLong.cBuf[1] := szBuffer[iP+1];
    recLong.cBuf[2] := szBuffer[iP+2];
    recLong.cBuf[3] := szBuffer[iP+3];

    {
    recLong.cBuf[0] := szBuffer[iP+3];
    recLong.cBuf[1] := szBuffer[iP+2];
    recLong.cBuf[2] := szBuffer[iP+1];
    recLong.cBuf[3] := szBuffer[iP+0];
    }
    iP := iP+4;
    lValue := recLong.lValue;
    Result := True;
  except
    Result := False;
  end;
end;

function DeconvertULong(szBuffer : PAnsiChar; var iP : Integer; var lValue : Cardinal) : Boolean;
var
  recLong : TULongUnion;
//  i : Integer;
begin
  try
    //CopyMemory(@recLong.cBuf[0], szBuffer+iP, 4);
    recLong.cBuf[0] := szBuffer[iP+3];
    recLong.cBuf[1] := szBuffer[iP+2];
    recLong.cBuf[2] := szBuffer[iP+1];
    recLong.cBuf[3] := szBuffer[iP+0];
    iP := iP+4;
    lValue := recLong.lValue;
    Result := True;
  except
    Result := False;
  end;
end;

function DeconvertFloat(szBuffer : PAnsiChar; var iP : Integer; var sValue : Single) : Boolean;
var
  recFloat : TFloatUnion;
//  i : Integer;
begin
  try
    //CopyMemory(@recLong.cBuf[0], szBuffer+iP, 4);
    recFloat.cBuf[0] := szBuffer[iP+3];
    recFloat.cBuf[1] := szBuffer[iP+2];
    recFloat.cBuf[2] := szBuffer[iP+1];
    recFloat.cBuf[3] := szBuffer[iP+0];
    iP := iP+4;
    sValue := recFloat.sValue;
    Result := True;
  except
    Result := False;
  end;
end;

function DeconvertDouble(szBuffer : PAnsiChar; var iP : Integer; var dValue : Double) : Boolean;
var
  recDouble : TDoubleUnion;
//  i : Integer;
begin
  try
    //CopyMemory(@recLong.cBuf[0], szBuffer+iP, 4);
    recDouble.cBuf[0] := szBuffer[iP+7];
    recDouble.cBuf[1] := szBuffer[iP+6];
    recDouble.cBuf[2] := szBuffer[iP+5];
    recDouble.cBuf[3] := szBuffer[iP+4];
    recDouble.cBuf[4] := szBuffer[iP+3];
    recDouble.cBuf[5] := szBuffer[iP+2];
    recDouble.cBuf[6] := szBuffer[iP+1];
    recDouble.cBuf[7] := szBuffer[iP+0];
    iP := iP+8;
    dValue := recDouble.dValue;
    Result := True;
  except
    Result := False;
  end;
end;



function DeConvertString(szBuffer : PAnsiChar; var iP : Integer; var stValue : String) : Boolean;
var
  iSize : SmallInt;
begin
  Result := False;
  iSize := 0;
  try
    if not DeconvertWord(szBuffer, iP, iSize) then Exit;


    SetLength(stValue, iSize);
    CopyMemory(@stValue[1], szBuffer+iP,iSize);

    iP := iP + iSize;
    Result := True;
  except
    Result := False;
  end;
end;

function DeConvertBytes(szBuffer : PAnsiChar; var iP : Integer; var stValue : String; iLen : Integer) : Boolean;
begin
  try
    SetLength(stValue, iLen);
    CopyMemory(@stValue[1], szBuffer + iP, iLen);
    iP := iP + iLen;
    Result := True;
  except
    Result := False;
  end;
end;


function DeconvertByte(szBuffer : PAnsiChar; var iP : Integer; var stValue : Byte) : Boolean;
begin
  try
    CopyMemory(@stValue, szBuffer + iP, 1);
    Inc(iP); 
    Result := True;
  except
    Result := False;
  end;
end;

end.
