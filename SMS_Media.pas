unit SMS_Media;

interface

uses
  SysUtils, MMSystem;

  procedure PlaySoundFile(stFile: String);



implementation

procedure PlaySoundFile(stFile: String);
var
  szBuf : array[0..1000] of Char;
begin
  PlaySound(StrPCopy(szBuf, stFile), 0,
    SND_ASYNC + SND_FILENAME + SND_NODEFAULT);
end;

end.
