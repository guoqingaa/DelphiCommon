unit Futures;

interface

uses
  SysUtils;

function GetIndexFutureExpiry: string;
function GetMYCode(stInput: String): String;

implementation

function GetIndexFutureExpiry: string;
const Months: Integer = 3;
var y,m,d: Word; DT: TDateTime; Next: Boolean; yStr, Expiry: string;
begin
  DecodeDate(Date,y,m,d);
  DT := EncodeDate(y,m,1);
  case DayOfWeek(DT) of
    1:Next := d > 11;
    2:Next := d > 10;
    3:Next := d > 9;
    4:Next := d > 8;
    5:Next := d > 7;
    6:Next := d > 6;
    7:Next := d > 12;
    else Next := false;
  end;
  if Next then m := m + 1;
  if m = 13 then
    begin
      y := y + 1;
      m := 1;
    end;
  while m mod Months > 0 do inc(m);
  yStr := IntToStr(y);
  Expiry := yStr;
  if m < 10 then Expiry := Expiry + '0';
  Expiry := Expiry + IntToStr(m);
  Result := Expiry;
end;


function GetMYCode(stInput: String): String;
var
  iMonth : Integer;
  stMonth : String;
begin
  Result := '';

  if Length(stInput)>=6 then
  begin
    Result := Copy(stInput, 3, 2);
    stMonth := Copy(stInput, 5, 2);
    iMonth := StrToInt(stMonth);
    //
    case iMonth of
      1 : Result := 'F'+Result;
      2 : Result := 'G'+Result;
      3 : Result := 'H'+Result;
      4 : Result := 'J'+Result;
      5 : Result := 'K'+Result;
      6 : Result := 'M'+Result;
      7 : Result := 'N'+Result;
      8 : Result := 'Q'+Result;
      9 : Result := 'U'+Result;
      10 : Result := 'V'+Result;
      11 : Result := 'X'+Result;
      12 : Result := 'Z'+Result;
    end;
  end;


end;


end.
