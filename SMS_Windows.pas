unit SMS_Windows;

interface

uses
  SysUtils, Windows, Classes, ShellAPI, Forms;

  procedure OpenApplication(stPath, stApplication, stParam: String);
  procedure OpenCommand(stCommand : String; bShow : Boolean);
  procedure OpenURL(stURL : String; bShow : Boolean);

implementation


procedure OpenApplication(stPath, stApplication, stParam: String);
var
  szPath, szProcess, szParam : array[0..1000] of Char;
begin
 StrPCopy(szPath, stPath);
 StrPCopy(szProcess, stApplication);
 StrPCopy(szParam, stParam);
 ShellExecute(Application.Handle, 'open', szProcess, szParam, szPath, SW_SHOWNORMAL );
end;

procedure OpenCommand(stCommand : String; bShow : Boolean);
var
  szURL : PChar;
  szParam : PChar;
  i, iLen : Integer;
  aTokens : TStringList;
  stToken, stParam : String;
begin
  if stCommand = '' then Exit;

  iLen := Length(stCommand);
  if iLen = 0 then Exit;
  //
  aTokens := TStringList.Create;
  try

    aTokens.Clear;

    szURL := nil;
    szParam := nil;

    stToken := '';
    for i:=1 to iLen do
      case stCommand[i] of
        #$0D : ; // ignored
        #$09, #$0A, '^', ';', ' ' :
          begin
            aTokens.Add(stToken);
            stToken := '';
          end;
        else
          stToken := stToken + stCommand[i];
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

  try
    ShellExecute(Application.Handle, 'open', szURL, szParam, '', SW_SHOWNORMAL )
  finally
    FreeMem(szURL);
  end;

end;


procedure OpenURL(stURL : String; bShow : Boolean);
var
  szURL : PChar;
  szParam : PChar;
  i, iLen, iPos : Integer;
  aTokens : TStringList;
  stToken, stParam : String;
begin
  if stURL = '' then Exit;

  iLen := Length(stURL);
  if iLen = 0 then Exit;

  aTokens := TStringList.Create;
  try
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

  try
    iPos := Pos('.exe', stURL);
    if iPos > 0 then
      ShellExecute(Application.Handle, 'open', szURL, szParam, '', SW_SHOWNORMAL )
    else
      ShellExecute(Application.Handle, 'open', PChar('IEXPLORE.EXE'), szURL, '', SW_SHOWNORMAL );

  finally
    FreeMem(szURL);
  end;

end;


end.




