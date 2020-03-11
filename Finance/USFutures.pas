unit USFutures;

interface

uses
  SysUtils;

function USFutMonthCodeToNumeric(cCode: Char): String;

implementation

function USFutMonthCodeToNumeric(cCode: Char): String;
begin
  Result := '';
  case UpperCase(cCode)[1] of
    'F':
      Result := '01';
    'G':
      Result := '02';
    'H' :
      Result := '03';
    'J' :
      Result := '04';
    'K' :
      Result := '05';
    'M' :
      Result := '06';
    'N' :
      Result := '07';
    'Q' :
      Result := '08';
    'U' :
      Result := '09';
    'V' :
      Result := '10';
    'X' :
      Result := '11';
    'Z' :
      Result := '12';
  end;
end;

end.
