unit SMS_XMLs;

interface

uses
  SysUtils, Classes, Graphics, Grids,
   MSXML_TLB, Math;

const
  XML_CLASSID = 'msxml2.domdocument';
  XML_INSTRUCTION_TARGET = 'xml';
  XML_INSTRUCTION_DATA = 'version="1.0"';


  function GetXMLDocument: IXMLDOMDocument;
  function GetPMADocument(stDataBase: String): IXMLDOMElement;
  function AddPMARecord(aElement: IXMLDOMElement; stColumn: String;
               oValue: Variant): IXMLDOMElement;

  //---------------------------- set ------------------------------------------
  function MakeChildElement(aDoc: IXMLDOMDocument; aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '') : IXMLDOMElement; overload;
  function MakeChildElement(aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '';
                bInsertFront: Boolean = False) : IXMLDOMElement; overload;


  procedure setFontElement(aElement: IXMLDOMElement; aFont : TFont);
  procedure setStringArray(aElement: IXMLDOMElement; aStringArray : array of String);
  procedure setXMLStrings(aElement: IXMLDOMElement; aStrings: TStrings;
              stNodeName: String = '');
  procedure getXMLStrings(aElement: IXMLDOMElement; aStrings: TStrings;
              stNodeName: String);

  //------------------------------get-------------------------------------------



  procedure GetFontAttribute(aElement: IXMLDOMElement; aFont : TFont);
  //
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var bValue: Boolean): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var iValue: Integer): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var wValue: Word): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var iValue: Int64): Boolean; overload;

  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var stValue: String): Boolean; overload;
{$IFNDEF VER150}
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var stValue: AnsiString): Boolean; overload;
{$ENDIF}
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var dValue: Double): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var aColor: TColor): Boolean; overload;
  function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var vValue: OleVariant): Boolean; overload;


  //---------------------- find node ---------------------------------------

  function GetFirstElementByTag(aStartingNode: IXMLDOMElement; stTag: String): IXMLDOMElement;
  function GetFirstElementByTagAttr(aStartingNode: IXMLDOMElement; stTag, stAttr, stAttrValue: String): IXMLDOMElement;

  function FindChildElement(aRefNode: IXMLDOMElement; stParent,
              stChildTag, stChild : String): IXMLDOMElement; overload;
  function FindChildElement(aRefNode: IXMLDOMElement;
              stChildTag : String): IXMLDOMElement; overload;
  //
  function GetAttributeInList(aList: IXMLDOMNodeList; stAttrName: String;
              aAttrList: TStringList): Integer;

  procedure SetGridPersistence(aGrid: TStringGrid; aElement : IXMLDOMElement);
  procedure GetGridPersistence(aGrid: TStringGrid; aElement : IXMLDOMElement);
  //
  procedure SetShiftAttribute(aElement: IXMLDOMElement; aShiftState: TShiftState);
  function GetShiftAttribute(aElement: IXMLDOMElement): TShiftState;


implementation

uses
  ComObj;

procedure SetShiftAttribute(aElement: IXMLDOMElement; aShiftState: TShiftState);
begin
  aElement.setAttribute('shift', ssShift in aShiftState);
  aElement.setAttribute('alt', ssAlt in aShiftState);
  aElement.setAttribute('ctrl', ssCtrl in aShiftState);
  aElement.setAttribute('left', ssLeft in aShiftState);
  aElement.setAttribute('right', ssRight in aShiftState);
  aElement.setAttribute('middle', ssMiddle in aShiftState);
  aElement.setAttribute('double', ssDouble in aShiftState);
end;

function GetShiftAttribute(aElement: IXMLDOMElement): TShiftState;
var
  bValue : Boolean;
begin
  Result := [];

  if GetAttribute(aElement, 'shift', bValue) and bValue then
    Result := Result + [ssShift];
  if GetAttribute(aElement, 'alt', bValue) and bValue then
    Result := Result + [ssAlt];
  if GetAttribute(aElement, 'ctrl', bValue) and bValue then
    Result := Result + [ssCtrl];
  if GetAttribute(aElement, 'left', bValue) and bValue then
    Result := Result + [ssLeft];
  if GetAttribute(aElement, 'right', bValue) and bValue then
    Result := Result + [ssRight];
  if GetAttribute(aElement, 'middle', bValue) and bValue then
    Result := Result + [ssMiddle];
  if GetAttribute(aElement, 'double', bValue) and bValue then
    Result := Result + [ssDouble];
end;




procedure setXMLStrings(aElement: IXMLDOMElement; aStrings: TStrings; stNodeName: String = '');
var
  i : Integer;
  aNewElement : IXMLDOMElement;
begin
  //
  if Length(stNodeName) = 0 then
  begin
    aNewElement := aElement;
  end else
    aNewElement := MakeChildElement(aElement, stNodeName);
  //
  for i := 0 to aStrings.Count-1 do
  begin
    MakeChildElement(aNewElement, 'item', 'data', aStrings[i]);
  end;
end;

procedure setStringArray(aElement: IXMLDOMElement; aStringArray : array of String);
var
  i : Integer;
begin
  //
  for i := 0 to Length(aStringArray)-1 do
  begin
    MakeChildElement(aElement, 'item', 'data', aStringArray[i]);
  end;
end;


procedure setFontElement(aElement: IXMLDOMElement; aFont : TFont);
begin
  aElement.setAttribute('font_name', aFont.Name);
  aElement.setAttribute('font_size', aFont.Size);
  aElement.setAttribute('font_color', aFont.Color);

  aElement.setAttribute('bold', fsBold in aFont.Style);
  aElement.setAttribute('italic', fsItalic in aFont.Style);
  aElement.setAttribute('underline', fsUnderline in aFont.Style);
  aElement.setAttribute('strikeout', fsStrikeOut in aFont.Style);
end;

procedure GetFontAttribute(aElement: IXMLDOMElement; aFont : TFont);
var
  stValue : String;
  iValue : Integer;
  bValue : Boolean;
begin
  if GetAttribute(aElement, 'font_name', stValue) then
    aFont.Name := stValue;
  if GetAttribute(aElement, 'font_size', iValue) then
    aFont.Size := iValue;
  if GetAttribute(aElement, 'font_color', iValue) then
    aFont.Color := iValue;

  aFont.Style := [];
  if GetAttribute(aElement, 'bold', bValue) and bValue then
     aFont.Style := aFont.Style + [fsBold];
  if GetAttribute(aElement, 'italic', bValue) and bValue then
    aFont.Style := aFont.Style + [fsItalic];
  if GetAttribute(aElement, 'underline', bValue) and bValue then
    aFont.Style := aFont.Style + [fsUnderline];
  if GetAttribute(aElement, 'strikeout', bValue) and bValue then
    aFont.Style := aFont.Style + [fsStrikeOut];

end;

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
  //
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
              var wValue: Word): Boolean; overload;
var
  aAttrNode : IXMLDOMAttribute;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    wValue := aAttrNode.value;
    Result := True;
  end;

end;

function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var iValue: Int64): Boolean;
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

{$IFNDEF VER150}
function GetAttribute(aElement: IXMLDomElement; stAttrName: String;
              var stValue: AnsiString): Boolean; overload;
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
{$ENDIF}

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
  iErrCode : Integer;
begin
  Result := False;
  //
  aAttrNode := aElement.getAttributeNode(stAttrName);
  if aAttrNode <> nil then
  begin
    Val(aAttrNode.value, dValue, iErrCode);
    //
    if iErrCode = 0 then
      Result := True
    else
    begin
      dValue := Nan;
      Result := False;
    end;
  end;
end;


function MakeChildElement(aDoc: IXMLDOMDocument; aParent: IXMLDOMElement;
                stChildName: String;
                stAttrName: String = ''; stAttrValue: String = '') : IXMLDOMElement;
begin
  if aDoc = nil then
    aDoc := GetXMLDocument;
  //
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
                stAttrName: String = ''; stAttrValue: String = '';
                bInsertFront: Boolean = False) : IXMLDOMElement;
begin
  if aParent = nil then Exit;

  Result := aParent.ownerDocument.createElement(stChildName);

  if bInsertFront and (aParent.childNodes.length > 0) then
    aParent.insertBefore(Result, aParent.childNodes.item[0])
  else
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



function FindChildElement(aRefNode: IXMLDOMElement; stParent,
  stChildTag, stChild : String): IXMLDOMElement;
var
  i : Integer;
  stValue : String;
  aChild : IXMLDOMElement;
begin
  Result := nil;
  //
  //
  for i := 0 to aRefNode.childNodes.length-1 do
  begin
    aChild := aRefNode.childNodes[i] as IXMLDOMElement;
    //
    if GetAttribute(aChild, stChildTag, stValue) and (stValue = stChild) then
    begin
      Result := aChild;
      Break;
    end;
  end;
end;

function FindChildElement(aRefNode: IXMLDOMElement;
              stChildTag : String): IXMLDOMElement;
var
  i : Integer;
  aChild : IXMLDOMElement;
begin
  Result := nil;
  //
  //
  for i := 0 to aRefNode.childNodes.length-1 do
  begin
    aChild := aRefNode.childNodes[i] as IXMLDOMElement;
    //
    if aChild.tagName = stChildTag then
    begin
      Result := aChild;
      Break;
    end;
  end;
end;



function GetFirstElementByTag(aStartingNode: IXMLDOMElement; stTag: String): IXMLDOMElement;
var
  aNodeList: IXMLDOMNodeList;
begin
  Result := nil;
  //
  if aStartingNode = nil then Exit;
  //
  aNodeList := aStartingNode.getElementsByTagName(stTag);
  if aNodeList.length > 0 then
    Result := aNodeList.item[0] as IXMLDOMElement;

end;

function GetFirstElementByTagAttr(aStartingNode: IXMLDOMElement;
   stTag, stAttr, stAttrValue: String): IXMLDOMElement;
var
  aNodeList: IXMLDOMNodeList;
  i : Integer;
  aNode : IXMLDOMElement;
  stValue : String;
begin
  Result := nil;
  //
  if aStartingNode = nil then Exit;
  //
  aNodeList := aStartingNode.getElementsByTagName(stTag);
  //
  for i := 0 to aNodeList.length-1 do
  begin
    aNode := aNodeList.item[i] as IXMLDOMElement;
    //
    if GetAttribute(aNode, stAttr, stValue) and (stValue = stAttrValue) then
    begin
      Result := aNode;
      Break;
    end;
  end;

end;


procedure SetGridPersistence(aGrid: TStringGrid; aElement : IXMLDOMElement);
var
  i, iValue : Integer;
  aChildNode : IXMLDOMElement;
begin
  if (aGrid = nil) or (aElement = nil) then Exit;
  //
  for i := 0 to aElement.childNodes.length-1 do
  begin
    aChildNode := aElement.childNodes.item[i] as IXMLDOMElement;
    if GetAttribute(aChildNode, 'width', iValue) and (i < aGrid.ColCount) then
      aGrid.ColWidths[i] := iValue;
  end;
end;

procedure GetGridPersistence(aGrid: TStringGrid; aElement : IXMLDOMElement);
var
  i : Integer;
  aChildNode : IXMLDOMElement;
begin
  if (aGrid = nil) or (aElement = nil) then Exit;
  //
  for i := 0 to aGrid.ColCount-1 do
  begin
    aChildNode := MakeChildElement(aElement, 'col');
    aChildNode.setAttribute('width', aGrid.ColWidths[i]);
  end;

end;

function GetPMADocument(stDataBase: String): IXMLDOMElement;
var
  aXMLProcessing : IXMLDOMProcessingInstruction;
  aDoc : IXMLDOMDocument;
  aElement : IXMLDOMElement;
begin
  Result := nil;
  try
    aDoc := CreateOleObject(XML_CLASSID) as IXMLDomDocument;
    //
    if aDoc = nil then Exception.Create('');
  except
    Result := nil;
    Exit;
  end;
  //
  aXMLProcessing := aDoc.createProcessingInstruction(XML_INSTRUCTION_TARGET,
          XML_INSTRUCTION_DATA);
  aDoc.appendChild(aXMLProcessing);
  //

  aElement := aDoc.createElement('pma_xml_export');
  aDoc.documentElement := aElement;
  Result := MakeChildElement(aElement, 'database');
  Result.setAttribute('name', stDataBase);
  {
  aElement := MakeChildElement(aElement, 'table');
  aElemenResult.setAttribute('name', stTable);
  }
end;


function AddPMARecord(aElement: IXMLDOMElement; stColumn: String;
  oValue: Variant): IXMLDOMElement;
begin
  Result := MakeChildElement(aElement, 'column');
  Result.setAttribute('name', stColumn);
  Result.text := oValue;
end;

procedure getXMLStrings(aElement: IXMLDOMElement; aStrings: TStrings; stNodeName: String);
var
  i : Integer;
  aNodeList, aNode : IXMLDOMElement;
  stValue : String;
begin
  aStrings.Clear;
  //
  aNodeList := GetFirstElementByTag(aElement, stNodeName);
  if aNodeList <> nil then
  begin
    for i := 0 to aNodeList.childNodes.length-1 do
    begin
      aNode := aNodeList.childNodes.item[i] as IXMLDOMElement;
      //
      if GetAttribute(aNode, 'data', stValue) then
        aStrings.Add(stValue);
    end;
  end;

end;



end.
