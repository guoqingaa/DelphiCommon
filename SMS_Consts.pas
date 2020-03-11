unit SMS_Consts;

interface

uses
  Classes;

const
  MAX_REAL = High(Integer)*1.0;
  MIN_REAL = MAX_REAL * -1.0;


  INVALID_VALUE = High(Integer);
  CHECK_INVALID_VALUE = INVALID_VALUE/10;

  MILLION = 1000000;
  THOUSAND = 1000;
  HUNDRED_MILLION = MILLION * 100;

  NA_DESC = 'N.A.';

  AlignmentDescs : array[TAlignment] of String = ('Left', 'Right', 'Center');

  function IsInvalidValue(const dValue: Double): Boolean;



implementation


function IsInvalidValue(const dValue: Double): Boolean;
begin
  Result := Abs(dValue) > CHECK_INVALID_VALUE;
end;

end.
