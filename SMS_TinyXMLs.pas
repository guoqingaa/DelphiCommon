unit SMS_TinyXMLs;

interface

uses
  Windows;


  function TiGetNewXMLDocument: Boolean;
  procedure InitTinyXMLs;
  procedure FinalizeTinyXMLs;
  procedure FreeTinyDocument;
  function TiNewChildElement(pParent: Pointer; stTagName: String): Pointer;


  function TiSetStrAttribute2(stAttrName, stAttrValue : String): Boolean;
  function TiSetStrAttribute(pParent: Pointer; stAttrName, stAttrValue : String): Boolean;
  function TiSetDoubleAttribute(pParent: Pointer; stAttrName: String; dValue : Double): Boolean;
  function TiSetIntAttribute(pParent: Pointer; stAttrName: String; iValue : Integer): Boolean;

  procedure SetTiXMLLib(stLibFile : String);
  function TiSaveToFile(stFile : String): Boolean;
  function TiLoadFromFile(stFile : String): Boolean;
  function TiFirstChild(pParent: Pointer): Pointer;
  function TiNextSiblingProc(pParent: Pointer):Pointer;
  function TiGetRootElemnet(): Pointer;

  function TiGetIntAttribute(pParent: Pointer; stAttrName: String; pValue: PInteger): Boolean;
  function TiGetStrAttribute(pParent: Pointer; stAttrName: String; pValue: PAnsiChar): Boolean;
  function TiGetDoubleAttribute(pParent: Pointer; stAttrName: String; pValue: PDouble): Boolean;
  function TiGetTagName(pParent: Pointer): String;
  procedure FreeLastTiDocument;


type
  TTiNewDocumentProc = function (const szEncoding: PAnsiChar): Pointer; cdecl;

  TTiSaveToFile = function (szFileName : PAnsiChar) : Boolean; cdecl;
  TTiLoadFromFile = function (szFileName : PAnsiChar) : Boolean; cdecl;
  TTiNewChildElementProc = function(pParent: Pointer; stTagName: PAnsiChar): Pointer; cdecl;
  TTiSetStrAttrProc2 = function(szAttrName, szAttrValue: PAnsiChar): Boolean; cdecl;
  TTiSetStrAttrProc = function(pParent: Pointer; szAttrName, szAttrValue: PAnsiChar): Boolean; cdecl;
  TTiSetDoubleAttrProc = function(pParent: Pointer; szAttrName: PAnsiChar; dValue: Double): Boolean; cdecl;
  TTiSetIntAttrProc = function(pParent: Pointer; szAttrName: PAnsiChar; iValue: Integer): Boolean; cdecl;
  TTiFirstChildProc = function(pParent: Pointer):Pointer;cdecl;
  TTiNextSiblingProc = function(pParent: Pointer):Pointer;cdecl;
  TTiGetIntAttribute = function(pParent: Pointer; szAttrName: PAnsiChar; pValue: PInteger): Boolean; cdecl;
  TTiGetBoolAttribute = function(pParent: Pointer; szAttrName: PAnsiChar; pValue: PBoolean): Boolean; cdecl;
  TTiGetDoubleAttribute = function(pParent: Pointer; szAttrName: PAnsiChar; pValue: PDouble): Boolean; cdecl;
  TTiGetStrAttribute = function(pParent: Pointer; szAttrName, pValue: PAnsiChar): Boolean; cdecl;
  TTiGetRootElement = function(): Pointer; cdecl;
  TTiGetTagName = procedure(pParent: Pointer; szValue: PAnsiChar); cdecl;
  TTiFreeDocumentProc = procedure(); cdecl;

const
  TI_STRING_LENGTH = 500;

implementation

uses SysUtils;

var
  gLibFilePath : String;
  gLibHandle : THandle;
  gTiNewDocumentProc : TTiNewDocumentProc;
  gTiSaveToFileProc : TTiSaveToFile;
  gTiLoadFromFileProc : TTiLoadFromFile;
  gTiNewChildElementProc : TTiNewChildElementProc;
  gTiSetStrAttrProc2 : TTiSetStrAttrProc2;
  gTiSetStrAttrProc : TTiSetStrAttrProc;
  gTiSetDoubleAttrProc : TTiSetDoubleAttrProc;
  gTiSetIntAttrProc : TTiSetIntAttrProc;

  gTiFirstChildProc : TTiFirstChildProc;
  gTiNextSiblingProc : TTiNextSiblingProc;

  gTiGetIntAttribute : TTiGetIntAttribute;
  gTiGetDoubleAttribute : TTiGetDoubleAttribute;
  gTiGetStrAttribute : TTiGetStrAttribute;

  gTiGetRootElement : TTiGetRootElement;
  gTiGetTagName : TTiGetTagName;
  gTiFreeDocumentProc : TTiFreeDocumentProc;

procedure InitTinyXMLs;
begin
  if gLibHandle <= 0 then
  begin
    gLibHandle := LoadLibrary(PChar(gLibFilePath));
    //
    if gLibHandle > 0 then
    begin
      gTiNewDocumentProc := GetProcAddress(gLibHandle, 'NewDocument');
      //
      gTiSaveToFileProc := GetProcAddress(gLibHandle, 'SaveToFile');
      gTiLoadFromFileProc := GetProcAddress(gLibHandle, 'LoadFromFile');
      gTiNewChildElementProc := GetProcAddress(gLibHandle, 'NewChildElement');
      gTiSetStrAttrProc := GetProcAddress(gLibHandle, 'SetStrAttribute');
      gTiSetStrAttrProc2 := GetProcAddress(gLibHandle, 'SetStrAttribute2');
      gTiSetDoubleAttrProc := GetProcAddress(gLibHandle, 'SetDoubleAttribute');
      gTiSetIntAttrProc := GetProcAddress(gLibHandle, 'SetIntAttribute');
      gTiGetRootElement := GetProcAddress(gLibHandle, 'GetRootElement');
      gTiFirstChildProc := GetProcAddress(gLibHandle, 'FirstChild');
      gTiNextSiblingProc := GetProcAddress(gLibHandle, 'NextSibling');
      gTiGetIntAttribute := GetProcAddress(gLibHandle, 'GetIntAttribute');
      gTiGetDoubleAttribute := GetProcAddress(gLibHandle, 'GetDoubleAttribute');
      gTiGetStrAttribute := GetProcAddress(gLibHandle, 'GetStrAttribute');
      gTiGetTagName := GetProcAddress(gLibHandle, 'GetTagName');
      gTiFreeDocumentProc := GetProcAddress(gLibHandle, 'FreeDocument');

    end
    //;
  end;
end;

procedure FreeLastTiDocument;
begin
  gTiFreeDocumentProc;
end;

procedure FinalizeTinyXMLs;
begin
end;

procedure FreeTinyDocument;
begin

end;

function TiSetStrAttribute(pParent: Pointer; stAttrName, stAttrValue : String): Boolean;
var
  szAttrName, szAttrValue : array[0..500] of AnsiChar;
begin
  Result := False;
  //
  if gLibHandle <= 0 then Exit;
  //
  StrPCopy(szAttrName, stAttrName);
  StrPCopy(szAttrValue, stAttrValue);
  Result := gTiSetStrAttrProc(pParent, szAttrName, szAttrValue);

end;

function TiSetDoubleAttribute(pParent: Pointer; stAttrName: String; dValue : Double): Boolean;
var
  szAttrName : array[0..500] of AnsiChar;
begin
  Result := False;
  //
  if gLibHandle <= 0 then Exit;
  //
  StrPCopy(szAttrName, stAttrName);

  Result := gTiSetDoubleAttrProc(pParent, szAttrName, dValue);
end;

function TiSetIntAttribute(pParent: Pointer; stAttrName: String; iValue : Integer): Boolean;
var
  szAttrName : array[0..500] of AnsiChar;
begin
  Result := False;
  //
  if gLibHandle <= 0 then Exit;
  //
  StrPCopy(szAttrName, stAttrName);

  Result := gTiSetIntAttrProc(pParent, szAttrName, iValue);

end;

function TiSetStrAttribute2(stAttrName, stAttrValue : String): Boolean;
var
  szAttrName, szAttrValue : array[0..500] of AnsiChar;
begin
  Result := False;
  //
  if gLibHandle <= 0 then Exit;
  //
  StrPCopy(szAttrName, stAttrName);
  StrPCopy(szAttrValue, stAttrValue);
  Result := gTiSetStrAttrProc2(szAttrName, szAttrValue);
end;

function TiNewChildElement(pParent: Pointer; stTagName: String): Pointer;
var
  pTagName : PAnsiChar;
begin
  Result := nil;
  //
  if gLibHandle <= 0 then Exit;
  //
  GetMem(pTagName, Length(stTagName)+1);
  StrPCopy(pTagName, stTagName);

  Result := gTiNewChildElementProc(pParent, pTagName);

  FreeMem(pTagName);
end;


function TiSaveToFile(stFile : String): Boolean;
var
  //szFileName : PAnsiChar;
  szFileName2 : array[0..500] of AnsiChar;
begin
  Result := False;
  //
  if gLibHandle <= 0 then Exit;
  //
  StrPCopy(szFileName2, stFile);
  //GetMem(szFileName, Length(stFile)+1);
  //StrPCopy(szFileName, stFile);
  Result := gTiSaveToFileProc(szFileName2);
  //FreeMem(szFileName);
  //
end;

function TiGetIntAttribute(pParent: Pointer; stAttrName: String; pValue: PInteger): Boolean;
var
  szName : array[0..TI_STRING_LENGTH-1] of AnsiChar;
begin
  Result := False;
  if pParent = nil then Exit;
  StrPCopy(szName, stAttrName);
  Result := gTiGetIntAttribute(pParent, szName, pValue);
end;

function TiGetDoubleAttribute(pParent: Pointer; stAttrName: String; pValue: PDouble): Boolean;
var
  szName : array[0..TI_STRING_LENGTH-1] of AnsiChar;
begin
  Result := False;
  if pParent = nil then Exit;
  StrPCopy(szName, stAttrName);
  Result := gTiGetDoubleAttribute(pParent, szName, pValue);
end;


function TiGetStrAttribute(pParent: Pointer; stAttrName: String; pValue: PAnsiChar): Boolean;
var
  szName : array[0..TI_STRING_LENGTH-1] of AnsiChar;
begin
  Result := False;
  if pParent = nil then Exit;
  StrPCopy(szName, stAttrName);
  Result := gTiGetStrAttribute(pParent, szName, pValue);

end;

function TiGetTagName(pParent: Pointer): String;
var
  szValue : array[0..TI_STRING_LENGTH-1] of AnsiChar;
begin
  if pParent = nil then Exit;

  gTiGetTagName(pParent, szValue);
  Result := szValue;
end;

function TiLoadFromFile(stFile : String): Boolean;
var
  szFileName : array[0..TI_STRING_LENGTH-1] of AnsiChar;
begin
  Result := False;
  //
  if gLibHandle <= 0 then Exit;
  //
  StrPCopy(szFileName, stFile);
  Result := gTiLoadFromFileProc(szFileName);
  //
end;

function TiFirstChild(pParent: Pointer): Pointer;
begin
  Result := gTiFirstChildProc(pParent);
end;

function TiNextSiblingProc(pParent: Pointer):Pointer;
begin
  Result := gTiNextSiblingProc(pParent);
end;

function TiGetRootElemnet(): Pointer;
begin
  Result := gTiGetRootElement;
end;

procedure SetTiXMLLib(stLibFile : String);
begin
  gLibFilePath := stLibFile;
end;



function TiGetNewXMLDocument: Boolean;
begin
  //
  Result := False;

  if gLibHandle <= 0 then Exit;
  //
  //gTiNewDocumentProc('ISO-8859-1');  //GB2312
  gTiNewDocumentProc('EUC-KR');  //GB2312


end;

procedure SetRootElement(stTagName: String);
begin


end;

initialization

finalization
  FinalizeTinyXMLs;

end.



