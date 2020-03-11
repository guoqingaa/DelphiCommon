unit SMS_Strings;

interface

uses
  SysUtils, Classes, Windows, Types, SMS_Types;

  function GetTokens(const stText : String;
    aTokens : TStringList;const aSector : Char) : Integer;

  function FastGetTokens(const stText: AnsiString; aTokens: TStrings; const Delimiter: AnsiChar): Integer;


  function ArrayToString(aValue: array of String; cSplitter: Char): String;
  procedure StrCommaToIntArray(const stValue: String; out aArray: TIntegerDynArray);
  procedure StrToIntPairArray(const stValue: String; out aArray: TIntPairArray);

  procedure SortWithPriorities(aStrings, aPriorities: TStrings);

  function IfThenString(const bValue: Boolean; const stTrueValue, stFalseValue: String): String;
  function CommaStrToFloat(stValue: String): Extended;
  //
  function UpperCompare(Str1, Str2 : String) : Integer;
  function FixLenStr(stValue : String; iFixLen : Integer) : String;

implementation

procedure StrToIntPairArray(const stValue: String; out aArray: TIntPairArray);
var
  i, iStart, iLast, iLength : Integer;
  aTokens, aTokens2 : TStringList;
begin
  //SetLength(aArray, 0);
  aArray := nil;
  //
  aTokens := TStringList.Create;
  aTokens2 := TStringList.Create;

  try
    GetTokens(stValue, aTokens, ';');
    //
    for i := 0 to aTokens.Count-1 do
    begin
      GetTokens(aTokens[i], aTokens2, '-');
      //
      if aTokens2.Count = 2 then
      begin
        iStart := StrToInt(aTokens2[0]);
        iLast := StrToInt(aTokens2[1]);
        //
        if iStart < iLast then
        begin
          iLength := Length(aArray);
          SetLength(aArray, iLength+1);
          aArray[iLength].IntValue := iStart;
          aArray[iLength].IntValue2 := iLast;
        end;
      end;
    end;

  finally
    aTokens.Free;
    aTokens2.Free;
  end;
end;

function FixLenStr(stValue : String; iFixLen : Integer) : String;
begin
  Result := Copy(Format('%-*s',[iFixLen, stValue]), 1, iFixLen);
end;

function UpperCompare(Str1, Str2 : String) : Integer;
begin
  Result := CompareStr(UpperCase(Str1), UpperCase(Str2));
end;

function CommaStrToFloat(stValue: String): Extended;
begin
  stValue := StringReplace(stValue, ',', '', [rfReplaceAll]);
  Result := StrToFloat(stValue);
end;

function IfThenString(const bValue: Boolean; const stTrueValue, stFalseValue: String): String;
begin
  if bValue then
    Result := stTrueValue
  else
    Result := stFalseValue;
end;

procedure StrCommaToIntArray(const stValue: String;
              out aArray : TIntegerDynArray);
var
  i : Integer;
  aTokens : TStringList;
begin
  //
  SetLength(aArray, 0);

  aTokens := TStringList.Create;

  try
    GetTokens(stValue, aTokens, ',');
    //
    for i := 0 to aTokens.Count-1 do
    begin
      SetLength(aArray, Length(aArray)+1);
      aArray[Length(aArray)-1] := StrToInt(aTokens[i]);
    end;
    //
  finally
    aTokens.Free;
  end;


end;



function ArrayToString(aValue: array of String; cSplitter: Char): String;
var
  i, iLength : Integer;
begin
  iLength := Length(aValue);
  //
  Result := '';
  for i := 0 to iLength-1 do
  begin
    Result := Result + aValue[i];
    //
    if i < iLength-1 then
      Result := Result + cSplitter;
  end;
end;

procedure SortWithPriorities(aStrings, aPriorities: TStrings);
var
  i, j, iPos : Integer;
  aTmpStrings : TStringList;

begin
  aTmpStrings := TStringList.Create;

  try
    for i := 0 to aPriorities.Count-1 do
    begin
      for j := 0 to aStrings.Count-1 do
      begin
        iPos := Pos(aPriorities[i], aStrings[j]);
        //
        if iPos > 0 then
        begin
          aTmpStrings.Add(aStrings[j]);
          aStrings.Delete(j);
          Break;
        end;

      end;
    end;

    //
    for i := 0 to aStrings.Count-1 do
      aTmpStrings.Add(aStrings[i]);
    //
    aStrings.Assign(aTmpStrings);

  finally
    aTmpStrings.Free;
  end;

end;


function GetTokens(const stText : String; aTokens : TStringList;const  aSector : Char) : Integer;
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


function FastGetTokens(const stText: AnsiString; aTokens: TStrings; const Delimiter: AnsiChar): Integer;
var
  P, P1: PAnsiChar;
  S: AnsiString;
begin
  aTokens.Clear;
  P := PAnsiChar(stText);
  while P^ in [#1..{' '}#31] do
    P := CharNextA(P);
  //
  while P^ <> #0 do
  begin
    P1 := P;
    while (P^ > #31{' '}) and (P^ <> Delimiter) do
      P := CharNextA(P);
    //
    SetString(S, P1, P - P1);
    aTokens.Add(S);
    //
    while P^ in [#1..#31{' '}] do
      P := CharNextA(P);
    //
    if P^ = Delimiter then
    begin
      P1 := P;

      if CharNextA(P1)^ = #0 then
        Break;//aTokens.Add('');
      repeat
        P := CharNextA(P);
      until not (P^ in [#1..#31{' '}]);
    end;
  end;
end;


end.
