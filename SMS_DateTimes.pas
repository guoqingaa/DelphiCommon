unit SMS_DateTimes;

interface

uses
  SysUtils, Math, Windows, DateUtils;

const
  MININUTES_INADAY = 1440;

  SUN_DAY = 1;
  MON_DAY = 2;
  TUE_DAY = 3;
  WED_DAY = 4;
  THU_DAY = 5;
  FRI_DAY = 6;
  SAT_DAY = 7;

  ONE_SECOND = 1/(24*3600);
  ONE_HOUR = 1/24;

type
  TDateMin = record
    //Date : Integer;   //date
    Date : Word;
    MMI : Word;       //miniute index
  end;
  //
  function CompareDateMin(const aDateMin, aDateMin2: TDateMin): Integer;
  procedure DecodeDateMin(const aDateMin: TDateMin;var wHour, wMin: Word);
  function DateMinToDateTime(const aDateMin: TDateMin) : TDateTime; overload;
  function DateMinToDateTime(const aDateMin: TDateMin; const wSec, wMSec: Word) : TDateTime; overload;
  function EncodeToDateMin(const dDateTime: TDateTime): TDateMin; overload;
  function EncodeToDateMin(const dDateTime: TDateTime; var wSec, wMSec: Word): TDateMin; overload;
  //
  function IncDateMin(const aDateMin: TDateMin; const iMMI : Integer): TDateMin;
  function DecDateMin(const aDateMin: TDateMin; const iMMI : Integer): TDateMin;
  //
  function CalcMMIndex(const iHour, iMin: Integer): Integer;
  function CalcAfterMMIndex(const iRef, iAfter: Integer): Integer;

  function TimeToInteger(const dDateTime: TDateTime): Integer;
  function DateTimeToString(const dDateTime: TDateTime): String;

  //--------------    string -> date or time ----------------------------
  function TimeStringToDateTime(const stTime: String): TDateTime;
  function DateStringToDateTime(const stDate: String): TDateTime;

  function Int8ToDate(const iDate: Integer): TDateTime;
  function DateToInt8(const iDate: Integer): Integer;
  function Int6ToTime(const iTime: Integer): TDateTime;
  function Int8ToTime(const iTime: Integer): TDateTime;
  function Int9ToTime(const iTime: Integer): TDateTime;


  function SecondToDateTime(const iSecond: Integer): TDateTime;
  function DateTimeToSecond(const dDateTime: TDateTime): Integer;

  //--------------------------------------------------

  function DateMin(const Date, MMI : Word): TDateMin;

  function GetMMIndex(const dtValue: TDateTime): Integer; overload;
  function GetMMIndex(const dtValue: TDateTime; var wSec, wMSec : Word): Integer; overload;
  //
  function DecTradingDay(iDate, iDec: Integer; aTradeDays: array of Integer): Integer;

  //
  function DateTimeToUnivDateTime(d:TDateTime):TDateTime;

implementation

function DateTimeToUnivDateTime(d:TDateTime):TDateTime;
var
  TZI:TTimeZoneInformation;
  LocalTime, UniversalTime:TSystemTime;
begin
  GetTimeZoneInformation(tzi);
  Result := IncHour(d, - tzi.Bias - TZI.Bias);
  {
  DateTimeToSystemTime(d,LocalTime);
  TzSpecificLocalTimeToSystemTime(@tzi,LocalTime,UniversalTime);
  Result := SystemTimeToDateTime(UniversalTime);
  }
end;

function DecTradingDay(iDate, iDec: Integer; aTradeDays: array of Integer): Integer;
var
  iLength, iDayofWeek : Integer;

  function IsTradingDay : Boolean;
  var
    i : Integer;
  begin
    Result := False;
    //
    for i := 0 to iLength-1 do
    begin
      if aTradeDays[i] = iDayOfWeek then
      begin
        Result := True;
        Break;
      end;
    end;
    //
  end;
  //
begin
  Result := iDate;
  //
  if iDec <= 0 then Exit;
  //
  iLength := Length(aTradeDays);  
  //
  repeat
    Dec(Result);
    iDayOfWeek := DayOfWeek(Result);
    //
    if IsTradingDay then
      Dec(iDec);
    //
  until (IsTradingDay and (iDec <= 0))


end;

function GetMMIndex(const dtValue : TDateTime) : Integer;
var
  wHH, wMM, wSS, wZZ : Word;
begin
  DecodeTime(dtValue, wHH, wMM, wSS, wZZ);
  Result := wHH*60 + wMM;
end;

function GetMMIndex(const dtValue: TDateTime; var wSec, wMSec : Word): Integer;
var
  wHH, wMM : Word;
begin
  DecodeTime(dtValue, wHH, wMM, wSec, wMSec);
  Result := wHH*60 + wMM;
end;


function DateMin(const Date, MMI : Word): TDateMin;
begin
  Result.Date := Date;
  Result.MMI := MMI;
end;

function DateTimeToSecond(const dDateTime: TDateTime): Integer;
var
  wHour, wMin, wSec, wMSec : Word;
begin
  DecodeTime(dDateTime, wHour, wMin, wSec, wMSec);
  Result := wHour * 3600 + wMin * 60 + wSec;

end;

function SecondToDateTime(const iSecond: Integer): TDateTime;
var
  wHour, wMin, wSec : Word;
begin
  Result := 0;

  try
    wHour := iSecond div 3600;
    wMin := iSecond mod 3600;
    wSec := wMin mod 60;
    wMin := wMin div 60;

    Result := EncodeTime(wHour, wMin, wSec, 0);
  except
  end;

end;

function DateToInt8(const iDate: Integer): Integer;
var
  stValue : String;
begin
  stValue := FormatDateTime('yyyymmdd', iDate);
  Result := StrToInt(stValue);
end;

function Int6ToTime(const iTime: Integer): TDateTime;
var
  wHour, wMin, wSec : Word;
begin
  //
  wHour := iTime div 10000;
  wMin := iTime mod 10000;
  wMin := wMin div 100;
  wSec := iTime mod 100;

  Result := EncodeTime(wHour, wMin, wSec, 0);

end;

function Int8ToTime(const iTime: Integer): TDateTime;
var
  wHour, wMin, wSec, wMSec : Integer;
begin
  wHour := iTime div 1000000;
  wMin := iTime mod  1000000;
  wMin := wMin div 10000;
  wSec := iTime mod 10000;
  wSec := wSec div 100;
  wMSec := iTime mod 100 * 10;

  Result := EncodeTime(wHour, wMin, wSec, wMSec);

end;

function Int9ToTime(const iTime: Integer): TDateTime;
var
  wHour, wMin, wSec, wMSec : Integer;
begin
  wHour := iTime div 10000000;
  wMin := iTime mod  10000000;
  wMin := wMin div 100000;
  wSec := iTime mod 100000;
  wSec := wSec div 1000;
  wMSec := iTime mod 1000;// * 10;

  Result := EncodeTime(wHour, wMin, wSec, wMSec);

end;


function Int8ToDate(const iDate: Integer): TDateTime;
var
  iValue : Integer;
  wYear, wMonth, wDay : Word;
begin
  wYear := iDate div 10000;
  iValue := iDate mod 10000;
  wMonth := iValue div 100;
  wDay := iValue mod 100;

  Result := EncodeDate(wYear, wMonth, wDay);

end;

function TimeToInteger(const dDateTime: TDateTime): Integer;
begin
  Result := StrToInt(FormatDateTime('hhnnsszzz', dDateTime));
end;

function TimeStringToDateTime(const stTime: String): TDateTime;
var
  wHour, wMin, wSec : Word;
  iLen, iValue : Integer;
begin
  //HH:NN:SS 포맷  or HH:NN   or HNN or HHNN 만 가능.
  Result := 0;
  //
  iLen := Length(stTime);
  //
  if iLen <= 4 then
  begin
    iValue := StrToIntDef(stTime, 0);
    //
    Result := EncodeTime(iValue div 100, iValue mod 100, 0, 0);
  end;

  if iLen < 5 then Exit;
  wHour := StrToInt(Copy(stTime, 1, 2));
  wMin := StrToInt(Copy(stTime, 4, 2));
  //
  if iLen < 8 then
    wSec := 0
  else
    wSec := StrToInt(Copy(stTime, 7, 2));
  //
  Result := EncodeTime(wHour, wMin, wSec, 0);

end;

function DateStringToDateTime(const stDate: String): TDateTime;
var
  wYear, wMonth, wDay : Word;
  iLength : Integer;
begin
  Result := 0;
  //
  iLength := Length(stDate);
  //
  if stDate[3] = '/' then
  begin
    wYear := StrToInt(Copy(stDate, 7, 4));
    wMonth := StrToInt(Copy(stDate, 1, 2));
    wDay := StrToInt(Copy(stDate, 4, 2));
    Result := EncodeDate(wYear, wMonth, wDay);
  end else
  if iLength = 10 then
  begin
    wYear := StrToInt(Copy(stDate, 1, 4));
    wMonth := StrToInt(Copy(stDate, 6, 2));
    wDay := StrToInt(Copy(stDate, 9, 2));
    Result := EncodeDate(wYear, wMonth, wDay);
  end else
  if iLength = 8 then
  begin
    if (stDate[3] = '-') then
    begin
      wYear := 2000 + StrToInt(Copy(stDate, 1, 2));
      wMonth := StrToInt(Copy(stDate, 4, 2));
      wDay := StrToInt(Copy(stDate, 7, 2));
      Result := EncodeDate(wYear, wMonth, wDay);
    end else
    begin
      //YYYYMMDD Format
      wYear := StrToInt(Copy(stDate, 1, 4));
      wMonth := StrToInt(Copy(stDate, 5, 2));
      wDay := StrToInt(Copy(stDate, 7, 2));
      Result := EncodeDate(wYear, wMonth, wDay);
    end;
  end;

end;

function DateTimeToString(const dDateTime: TDateTime): String;
begin
  Result := FormatDateTime('yy-mm-dd hh:nn', dDateTime);
end;


function CompareDateMin(const aDateMin, aDateMin2: TDateMin): Integer;
begin
  if aDateMin.Date > aDateMin2.Date then
    Result := 1
  else if aDateMin.Date < aDateMin2.Date then
    Result := -1
  else
  begin
    if aDateMin.MMI > aDateMin2.MMI then
      Result := 1
    else if aDateMin.MMI < aDateMin2.MMI then
      Result := -1
    else
      Result := 0;
  end;
end;


procedure DecodeDateMin(const aDateMin: TDateMin;var wHour, wMin: Word);
begin
  wHour := aDateMin.MMI div 60;
  wMin := aDateMin.MMI mod 60;
end;

function EncodeToDateMin(const dDateTime: TDateTime): TDateMin;
var
  wHour, wMin, wSec, wMSec : Word;
begin
  Result.Date := Floor(dDateTime);

  DecodeTime(dDateTime, wHour, wMin, wSec, wMSec);
  Result.MMI := wHour * 60 + wMin;
end;

function EncodeToDateMin(const dDateTime: TDateTime; var wSec, wMSec: Word): TDateMin;
var
  wHour, wMin : Word;
begin
  Result.Date := Floor(dDateTime);

  DecodeTime(dDateTime, wHour, wMin, wSec, wMSec);
  Result.MMI := wHour * 60 + wMin;

end;

function DateMinToDateTime(const aDateMin: TDateMin) : TDateTime;
begin
  Result := aDateMin.Date + EncodeTime(aDateMin.MMI div 60, aDateMin.MMI mod 60, 0, 0);
end;

function DateMinToDateTime(const aDateMin: TDateMin; const wSec, wMSec: Word) : TDateTime;
begin
  Result := aDateMin.Date + EncodeTime(aDateMin.MMI div 60, aDateMin.MMI mod 60, wSec, wMSec);
end;


function IncDateMin(const aDateMin: TDateMin; const iMMI : Integer): TDateMin;
begin
  Result := aDateMin;
  Result.MMI := Result.MMI + iMMI;
  Result.Date := Result.Date + Result.MMI div MININUTES_INADAY;
  Result.MMI := Result.MMI mod MININUTES_INADAY;
end;

function DecDateMin(const aDateMin: TDateMin;const iMMI : Integer): TDateMin;
begin
  Result := aDateMin;

  if Result.MMI - iMMI < 0 then
  begin
    Result.Date := Result.Date - 1 - (iMMI - Result.MMI) div MININUTES_INADAY;
    Result.MMI := MININUTES_INADAY- ((iMMI - Result.MMI)mod MININUTES_INADAY);
  end else
    Result.MMI := Result.MMI - iMMI;


end;

function CalcMMIndex(const iHour, iMin: Integer): Integer;
begin
  Result := iHour * 60 + iMin;
end;

function CalcAfterMMIndex(const iRef, iAfter: Integer): Integer;
begin
  Result := iRef + iAfter;
  Result := Result mod MININUTES_INADAY;
end;


end.
