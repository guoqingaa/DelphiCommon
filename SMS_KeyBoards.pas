unit SMS_KeyBoards;

interface

uses
  Classes, Windows, Dialogs, ActnList, SMS_DS, SMS_Actions, MSXML_TLB, SMS_XMLs;

type


  TKeyCombinationItem = class(TCommonCollectionItem)
  public
    Key: Word;
    Shift: TShiftState;
    Action : TSAction;
    Tag : Integer;
    //
    constructor Create(aColl: TCollection); override;
    procedure Assign(aSource: TPersistent); override;

  end;

  TKeyCombinations = class(TCommonCollection)
    //FActions : TList;
  public
    function Load(const stFile: String): Boolean;
    procedure Save(const stFile: String);

    function FindCombination(const Shift: TShiftState;
              const Key: Word): TKeyCombinationItem;

    function RegisterKeyAction(Sender: TObject; const stTitle: String;
                const Shift: TShiftState; const Key: Word;
                const iTag: Integer = 0): TKeyCombinationItem;

    constructor Create;
    destructor Destroy; override;
  end;


  function GetKeyShiftStateDescs(aShift: TShiftState) : String;

  function AsciiString(Key: Word): String;



implementation



{ TKeyCombinations }

function AsciiString(Key: Word): String;
begin
  case Key of
    VK_F1 :
      Result := 'F1';
    VK_F2 :
      Result := 'F2';
    VK_LEFT :
      Result := 'LEFT';
    VK_RIGHT :
      Result := 'RIGHT';
    VK_UP :
      Result := 'UP';
    VK_DOWN :
      Result := 'DOWN';
    VK_ESCAPE :
      Result := 'Esc';
    VK_PRIOR :
      Result := 'PgUp';
    VK_NEXT :
      Result := 'PgDn';
    VK_HOME :
      Result := 'Home';

  else
    Result := Chr(Key);
  end;
end;

function GetKeyShiftStateDescs(aShift: TShiftState) : String;
begin
  Result := '';

  if ssShift in aShift then
    Result := Result + ',' + 'Shift'
  {else}; if ssAlt in aShift then
    Result := Result + ',' + 'Alt'
  {else}; if ssCtrl in aShift then
    Result := Result + ',' + 'Ctrl'
  {else}; if ssLeft in aShift then
    Result := Result + ',' + 'Left'
  {else}; if ssRight in aShift then
    Result := Result + ',' + 'Right'
  {else}; if ssMiddle in aShift then
    Result := Result + ',' + 'Middle'
  {else}; if ssDouble in aShift then
    Result := Result + ',' + 'Double';
  //   : array[TShiftState] of String = ('Shift', 'Alt' , 'Ctrl',
//    'Left', 'Right', 'Middle', 'Double');

end;

constructor TKeyCombinations.Create;
begin
  inherited Create(TKeyCombinationItem);
  //
  //FActions := TList.Create;

end;

destructor TKeyCombinations.Destroy;
//var
//  i : Integer;
begin
  {
  for i := 0 to FActions.Count-1 do
    TAction(FActions.Items[i]).Free;

  FActions.Free;
  }
  inherited;
end;

function TKeyCombinations.FindCombination(const Shift: TShiftState;
  const Key: Word): TKeyCombinationItem;
var
  i : Integer;
  aItem : TKeyCombinationItem;
begin
  Result := nil;
  //
  if Key = 0 then Exit;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TKeyCombinationItem;
    //
    if (Key = aItem.Key) and (Shift = aItem.Shift) then
    begin
      //
      Result := aItem;
      Break;
    end;
  end;

end;

function TKeyCombinations.Load(const stFile: String): Boolean;
var
  aDoc : IXMLDOMDocument;
  aElement, aElement2 : IXMLDOMElement;
  i, iTag : Integer;
  stValue : String;
  aKeyItem : TKeyCombinationItem;
  wValue, wShift : Word;
begin
  aDoc := GetXMLDocument;
  //
  Result := aDoc.load(stFile);

  if Result then
  begin

    //aElement := GetFirstElementByTag(aDoc.documentElement, 'items');
    aElement := aDoc.documentElement;
    //
    if aElement <> nil then
      for i := 0 to aElement.childNodes.length-1 do
      begin
        aElement2 := aElement.childNodes.item[i] as IXMLDOMElement;
        //
        if GetAttribute(aElement2, 'key', stValue) then
        begin
          aKeyItem := FindItem(stValue) as TKeyCombinationItem;
          //
          if aKeyItem <> nil then
          begin

            if GetAttribute(aElement2, 'key_word', wValue) and
                GetAttribute(aElement2, 'shift', wShift) and
                GetAttribute(aElement2, 'tag', iTag) then
            begin

              aKeyItem.Key := wValue;
              //TShiftState(aKeyItem.Shift) := wShift;
              aKeyItem.Tag := iTag;
              aKeyItem.Shift := GetShiftAttribute(aElement2);
            end;
          end;

        end;



      end;
  end;

end;

function TKeyCombinations.RegisterKeyAction(Sender: TObject; const stTitle: String;
  const Shift: TShiftState; const Key: Word; const iTag: Integer): TKeyCombinationItem;
begin
  Result := FindCombination(Shift, Key);
  //
  if Result <> nil then
  begin
    ShowMessage('Duplicate Key Combination');
    Result := nil;
  end;
  Result := Add as TKeyCombinationItem;
  Result.KeyByString := stTitle;
  Result.Shift := Shift;
  Result.Key := Key;
  Result.Tag := iTag;

end;

procedure TKeyCombinations.Save(const stFile: String);
var
  i : Integer;
  aDoc : IXMLDOMDocument;
  aElement, aElement2 : IXMLDOMElement;
  aItem : TKeyCombinationItem;
begin
  aDoc := GetXMLDocument;
  //
  aElement := MakeChildElement(aDoc, nil, 'items');


  for i := 0 to Count-1 do
  begin
    aElement2 := MakeChildElement(aElement, 'item');
    aItem := Items[i] as TKeyCombinationItem;
    aElement2.setAttribute('key', aItem.KeyByString);

    aElement2.setAttribute('key_word', aItem.Key);
    SetShiftAttribute(aElement2, aItem.Shift);
    aElement2.setAttribute('tag', aItem.Tag); 

  end;
  //
  aDoc.save(stFile);

end;

{ TKeyCombinationItem }

procedure TKeyCombinationItem.Assign(aSource: TPersistent);
var
  aSourceItem : TKeyCombinationItem;
begin
  inherited Assign(aSource);
  //
  aSourceItem := aSource as TKeyCombinationItem;
  //

  Key := aSourceItem.Key;
  Shift := aSourceItem.Shift;
  Action := aSourceItem.Action;

end;

constructor TKeyCombinationItem.Create(aColl: TCollection);
begin
  inherited Create(aColl);

  Key := 0;
  Shift := [];
  Tag := 0;

end;

end.
