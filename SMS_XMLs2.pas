unit SMS_XMLs2;

interface

uses
  SysUtils, Classes, Graphics,
   MSXML2_TLB;

const
  XML_CLASSID = 'msxml2.domdocument';
  XML_INSTRUCTION_TARGET = 'xml';
  XML_INSTRUCTION_DATA = 'version="1.0"';


  function GetXMLDocument: IXMLDOMDocument;
  //
  function MakeChildElement(aDoc: IXMLDOMDocument; aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '') : IXMLDOMElement; overload;
  function MakeChildElement(aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '') : IXMLDOMElement; overload;

  function GetFirstElementByTag(aStartingNode: IXMLDOMElement; stTag: String): IXMLDOMElement;

  //
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var bValue: Boolean): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var iValue: Integer): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var stValue: String): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var dValue: Double): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var aColor: TColor): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var vValue: OleVariant): Boolean; overload;





  function GetAttributeInList(aList: IXMLDOMNodeList; stAttrName: String;
              aAttrList: TStringList): Integer;



implementation

uses
  ComObj;

function GetAttributeInList(aList: IXMLDOMNodeList; stAttrName: String;
              aAttrList: TStringList): Integer;
var
  i : Integer;
  aElement : IXMLDOMElement;
  aAttrNode : IXMLDOMAttribute;
  aNodeList : IXMLDomNodeList;
begin
  Result := 0;
  if aList = nil then Exit;
  //
  if aList.length = 0 then Exit;
  aNodeList := aList.item[0].childNodes;
  //
  aAttrList.Clear;
  for i := 0 to aNodeList.length-1 do
  begin
    aElement := aNodeList.item[i] as IXMLDomElement;
    //
    aAttrNode := aElement.getAttributeNode(stAttrName);
    if aAttrNode <> nil then
      aAttrList.Add(aAttrNode.nodeValue);
  end;
  Result := aAttrList.Count;
end;

function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var bValue: Boolean): Boolean;
var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    bValue := aAttrNode.value;
    Result := True;
  end;
end;

function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var iValue: Integer): Boolean; overload;

var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    iValue := aAttrNode.value;
    Result := True;
  end;
end;

function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var stValue: String): Boolean; overload;
var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    stValue := aAttrNode.value;
    Result := True;
  end;
end;


function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var aColor: TColor): Boolean; overload;
var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    aColor := aAttrNode.value;
    Result := True;
  end;
end;

function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var vValue: OleVariant): Boolean; overload;
var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    vValue := aAttrNode.value;
    Result := True;
  end;
end;



function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var dValue: Double): Boolean; overload;
var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    dValue := aAttrNode.value;
    Result := True;
  end;
end;


function MakeChildElement(aDoc: IXMLDOMDocument; aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '') : IXMLDOMElement;
begin
  Result := aDoc.createElement(stChildName);

  if aParent = nil then
    aDoc.documentElement := Result
  else
    aParent.appendChild(Result);
  //
  if (Length(stAttrName) <> 0) and (Length(stAttrValue) <> 0) then
    Result.setAttribute(stAttrName, stAttrValue);

end;

function MakeChildElement(aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '') : IXMLDOMElement;
begin
  if aParent = nil then Exit;

  Result := aParent.ownerDocument.createElement(stChildName);

  aParent.appendChild(Result);
  //
  if (Length(stAttrName) <> 0) and (Length(stAttrValue) <> 0) then
    Result.setAttribute(stAttrName, stAttrValue);

end;




function GetXMLDocument : IXMLDOMDocument;
var
  aXMLProcessing : IXMLDOMProcessingInstruction;
begin
  try
    Result := CreateOleObject(XML_CLASSID) as IXMLDomDocument;
    //
    if Result = nil then Exception.Create('');
  except
    Result := nil;
    Exit;
  end;
  //
  aXMLProcessing := Result.createProcessingInstruction(XML_INSTRUCTION_TARGET,
          XML_INSTRUCTION_DATA);
  Result.appendChild(aXMLProcessing);
  //
end;





function GetFirstElementByTag(aStartingNode: IXMLDOMElement; stTag: String): IXMLDOMElement;
var
  aNodeList: IXMLDOMNodeList;
begin
  Result := nil;
  //
  aNodeList := aStartingNode.getElementsByTagName(stTag);
  if aNodeList.length > 0 then
    Result := aNodeList.item[0] as IXMLDOMElement;

end;

end.
