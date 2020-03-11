unit SMS_DS;

interface

uses
  SysUtils, Classes, SyncObjs;

type

  TLinkedListData = record
    pData : Pointer;

    Before : Pointer;
    Next : Pointer;
  end;

  PLinkedListData = ^TLinkedListData;

  TLinkedList = class
  private
    FDuplicatedCount: Integer;
    function GetFirst: PLinkedListData;
    function GetLast: PLinkedListData;
  protected
    //FEvent : TEvent;
    FList : TList;
    FDelta : Integer;

    FAdding : Boolean;
    FCriticalSection : TCriticalSection;
  public
    TotalAddCount : Integer;
    TotalRemoveCount : Integer;
    Removing : Boolean;

    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    function Add : PLinkedListData;
    procedure RemoveFirst;
    procedure Remove(pTarget: Pointer);
//    procedure RemoveBefore(pTarget: PLinkedListData);

    property Delta : Integer read FDelta write FDelta;
    property List : TList read FList;
    property First : PLinkedListData read GetFirst;
    property Last : PLinkedListData read GetLast;

    //property LastMessage : String read FLastMessage;
    property DuplicatedCount : Integer read FDuplicatedCount;
  end;

  TListCollectionItem = class(TCollectionItem)
  private
  public
    //
    Data : TObject;
    Key : String;
    List : TList;
    //
    constructor Create(aColl: TCollection); override;
    destructor Destroy; override;

  end;

  TListCollectionItemClass = class of TListCollectionItem;

  //uses
  // TradeManager 에서 Sending Box 로 이용

  TListCollection = class
  private
    FCollection : TCollection;
    FBaseClass : TListCollectionItemClass;
    function GetList(i: Integer): TListCollectionItem;
    function GetListCount: Integer;
    function GetTotalCount: Integer;
  public
    constructor Create; overload;
    constructor Create(aItemClass : TListCollectionItemClass); overload;
    destructor Destroy; override;

    function FindList(const aData: TObject): TListCollectionItem; overload;
    function FindList(const stKey: String): TListCollectionItem; overload;
    function FindList(const stKey: String; const aData: TObject): TListCollectionItem; overload;

    //
    function AddItem(aData: TObject): TListCollectionItem; overload;
    function AddItem(stKey: String): TListCollectionItem; overload;

    procedure Clear;

    property List[i: Integer]: TListCollectionItem read GetList;
    property ListCount : Integer read GetListCount;
    //
    property TotalCount : Integer read GetTotalCount;
  end;


  TMLStringList = class
  private
    FChilds : TList;
    FParent: TMLStringList;
    function GetChild(i:Integer): TMLStringList;
    function GetCount: Integer;

  public
    Data : String;
    Data2 : String;

    constructor Create;
    destructor Destroy; override;

    function Add : TMLStringList;
    procedure Clear;

    property Parent : TMLStringList read FParent;
    property Childs[i:Integer]: TMLStringList read GetChild;
    property Count: Integer read GetCount;
  end;

  PStringLinkedListItem = ^TStringLinkedListItem;
  TStringLinkedListItem = record
    FString : String;

    Before : PStringLinkedListItem;
    Next : PStringLinkedListItem;
  end;



  TStringLinkedList = class(TLinkedList)
  private
    //FDuplicatedCount: Integer;
    //function GetFirst: PLinkedListData;
    //function GetLast: PLinkedListData;
  protected
    //FEvent : TEvent;
    //FList : TList;
    //FDelta : Integer;

    //FAdding : Boolean;
    //FCriticalSection : TCriticalSection;
  public
    //TotalAddCount : Integer;
    //TotalRemoveCount : Integer;
    //Removing : Boolean;

    //constructor Create;
    //destructor Destroy; override;

    //procedure Clear;

    procedure Add(stData: String);
    //procedure RemoveFirst;
    //procedure Remove(pTarget: Pointer);
//    procedure RemoveBefore(pTarget: PLinkedListData);

    //property Delta : Integer read FDelta write FDelta;
    //property List : TList read FList;
    //property First : PLinkedListData read GetFirst;
    //property Last : PLinkedListData read GetLast;

    //property LastMessage : String read FLastMessage;
    //property DuplicatedCount : Integer read FDuplicatedCount;
  end;

  TRecordItem = record
  end;

  TRecordItemList = array[0..MaxListSize] of TRecordItem;
  PRecordItemList = ^TRecordItemList;

  TRecordList = class
  protected
    FCount : Integer;
    FCapacity : Integer;

    procedure Grow;

    procedure SetCapacity(NewCapacity: Integer); virtual;
    function Add: Pointer; virtual;
    procedure Clear; virtual;

  public

    constructor Create;
    destructor Destroy; override;

    property Count : Integer read FCount;
    property Capacity : Integer read FCapacity write SetCapacity;
  end;

  TCommonCollectionItem = class(TCollectionItem)
  public
    KeyByString : String;
    KeyByInt : Integer;
    KeyByObject : TObject;
    //
    Key2ByString : String;
    Key2ByInt : Integer;
    Key2ByObject : TObject;

    procedure Assign(aSource: TPersistent); override;
  end;

  TCommonCollectionItemClass = class of TCommonCollectionItem;

  TCommonCollection = class(TCollection)
  private
    FName: String;
//    FItems : TCollection;
  public
    constructor Create(aItemClass: TCommonCollectionItemClass); virtual;
    destructor Destroy; override;

    function FindItem(const aKeyObject : TObject): TCommonCollectionItem; overload;
    function FindItem(const iKeyInt : Integer): TCommonCollectionItem; overload;
    function FindItem(const stKey : String): TCommonCollectionItem; overload;
    //
    function FindItem(const iKeyInt, iKeyInt2 : Integer): TCommonCollectionItem; overload;
    function FindItem(const iKeyInt, iKeyInt2 : Integer; var iP: Integer): TCommonCollectionItem; overload;
    function FindItem(const stKey, stKey2 : String): TCommonCollectionItem; overload;
    function FindItem(const aKeyObject: TObject;
              const iKeyInt, iKeyInt2 : Integer): TCommonCollectionItem; overload;

    property Name : String read FName write FName;

  end;

  TOHLCItem = class(TCommonCollectionItem)
  public
    Open :  Double;//Single;//
    Close : Double;//Single;//
    High : Double; //Single;//
    Low : Double; //Single;//
  end;

  TTOHLCItem = class(TOHLCItem)
  public
    T : TDateTime;
    V : Integer;
    LValue1 : Integer;
  end;

  TBarMatrixItem = class(TCommonCollectionItem)
  protected
    FBarCollection : TCommonCollection;
    //
    function GetBars(i: Integer): TTOHLCItem;
    function GetBarCount: Integer;

  public
    //
    //
    Tag : Integer;
    //
    procedure Initialize; virtual;
    //procedure InitValues; virtual;
    //
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    //
    function AddTOHLCItem: TTOHLCItem;
    //
    property Bars[i: Integer]: TTOHLCItem read GetBars; default;
    property BarCount : Integer read GetBarCount;
  end;

  TBarMatrixItemClass = class of TBarMatrixItem;

  TBarMatrix = class(TCommonCollection)
  public
    constructor Create; overload;
    constructor Create(aClass : TBarMatrixItemClass); overload;
    destructor Destroy; override;

    procedure SaveToFile(const stFileName: String);
    procedure Initialize;
    //procedure InitValues;

  end;
  

  TManagerCollection = class(TCommonCollection)
  public
    Path : String;
    RefCount : Cardinal;
    AutoSave : Boolean;

    procedure IncRef;
    procedure DecRef;

    procedure Save; virtual;
    procedure Load; virtual;

    constructor Create(aItemClass: TCommonCollectionItemClass); override;
    destructor Destroy; override;
  end;

  TArrayDataList = class
  protected
    FCount : Integer;
    FCapacity : Integer;


    procedure Grow;
    procedure SetCapacity(const NewCapacity: Integer); virtual;

  public
    destructor Destroy; override;
    property Count : Integer read FCount;

    procedure Clear; virtual;
  end;


  TTermRec = {$IFNDEF DoubleSize} packed {$ENDIF} record
    LastTime : TDateTime;
{$IFDEF DoubleSize}
    Open, High, Low, Close: Double;
{$ELSE}
    Open, High, Low, Close: Single;
{$ENDIF}
    Volume: Integer;
    OpenInt : LongInt;

{$IFDEF QUOTEX}

  {$IFDEF DoubleSize}
    BidPrice : Double;
    BidQty : Integer;
    AskPrice : Double;
    AskQty : Integer;
  {$ELSE}
    BidPrice : Single;
    BidQty : Integer;
    AskPrice : Single;
    AskQty : Integer;
  {$ENDIF}


{$ENDIF}

  end;
  PTermRec = ^TTermRec;

  TTermInsertEvent = procedure(const Sender: TObject;const bLast: Boolean;
    const  aTerm: TTermRec) of object;

  TTermItem = class(TCollectionItem)
  public
    DataRec : TTermRec;
  end;

  TBarItem = class(TCollectionItem)
  public
    T : TDateTime;

{$IFDEF DoubleSize}
    O, H, L, C: Double;
{$ELSE}
    O, H, L, C: Single;
{$ENDIF}
    V : Double;
    OI : LongInt;//Double;

    RefCount : Integer;
    EtcData : String;
{$IFDEF QUOTEX}
    Term : TTermRec;
{$ENDIF}

    procedure Assign(aSource: TPersistent); override;
  end;

  TBarItems = class(TCollection)
  public
    Symbol : String;

    function FindIntraDayItem(dTime: TDateTime): TBarItem;

    constructor Create;
  end;






implementation

uses DateUtils;


procedure TBarItem.Assign(aSource: TPersistent);
var
  aSourceItem : TBarItem;
begin
  aSourceItem := aSource as TBarItem;
  T := aSourceItem.T;
  O := aSourceItem.O;
  H := aSourceItem.H;
  L := aSourceItem.L;
  C := aSourceItem.C;
  V := aSourceItem.V;
  OI := aSourceItem.OI;


end;

{ TLinkedList }

function TLinkedList.Add: PLinkedListData;
var
  pNewData, pLastData : PLinkedListData;
begin
  //

  FCriticalSection.Enter;

  if FAdding then
    Inc(FDuplicatedCount);

  FAdding := True;
  try

    if Removing then
    begin
      Inc(FDuplicatedCount);
    end;
    if FList.Count > 0 then
      pLastData := FList[FList.Count-1]
    else
      pLastData := nil;

    New(pNewData);
    pNewData^.pData := nil;
    pNewData^.Before := nil;
    pNewData^.Next := nil;


    pNewData^.Before := pLastData;

    //
    if FList.Count mod FDelta = 0 then
      FList.Capacity := FList.Count + FDelta;

    if pLastData <> nil then
      pLastData^.Next := pNewData;

    FList.Add(pNewData);
    //
    Inc(TotalAddCount);

    Result := pNewData;

  finally
    FAdding := False;
    FCriticalSection.Leave;
  end;
end;

procedure TLinkedList.Clear;
var
  i : Integer;
begin
  for i := 0 to FList.Count-1 do
    Dispose(FList[i]);
  //
  FList.Clear;
  FList.Capacity := 0;

end;

constructor TLinkedList.Create;
begin
  //FEvent := TEvent.Create(nil, False, False, '');
  FCriticalSection := TCriticalSection.Create;

  FList := TList.Create;

  FDelta := 100;

  TotalAddCount := 0;
  TotalRemoveCount := 0;

  FDuplicatedCount := 0;
  FAdding := False;


end;


destructor TLinkedList.Destroy;
begin

  Clear;

  FList.Free;

  //FEvent.Free;
  FCriticalSection.Free;

  inherited;
end;

function TLinkedList.GetFirst: PLinkedListData;
begin
  Result := nil;
  //
  if FList.Count > 0 then
    Result := PLinkedListData(FList.Items[0]);

end;

function TLinkedList.GetLast: PLinkedListData;
begin
  Result := nil;
  //
  if FList.Count > 0 then
    Result := PLinkedListData(FList.Items[FList.Count-1]);
end;

procedure TLinkedList.Remove(pTarget: Pointer);
var
  pData, pNextData, pBefore  : PLinkedListData;
begin

  FCriticalSection.Enter;
  Removing := True;
  try
    pData := pTarget;
    pNextData := pData.Next;
    if pNextData <> nil then
      pNextData.Before := pData.Before;

    pBefore := pData.Before;

    if pBefore <> nil then
      pBefore.Next := pNextData;

    FList.Remove(pTarget);
    Dispose(pTarget);
    Inc(TotalRemoveCount);
  finally
    Removing := False;
    FCriticalSection.Leave;
  end;
end;
{
procedure TLinkedList.RemoveBefore(pTarget: PLinkedListData);
var
  pPreCurrent, pCurrent : PLinkedListData;
begin
  pCurrent := pTarget;
  while (pCurrent <> nil) do
  begin
    try
      pPreCurrent := pCurrent;

    finally
      pCurrent := pCurrent.Before;
      Remove(pPreCurrent);
    end;

  end;
end;
}
procedure TLinkedList.RemoveFirst;
begin
  if FList.Count = 0 then Exit;
  //

  FCriticalSection.Enter;
  Removing := True;
  try

    Dispose(FList.Items[0]);
    FList.Delete(0);
    Inc(TotalRemoveCount);
  finally
    Removing := False;
    FCriticalSection.Leave;
  end;
end;

{ TListCollection }

function TListCollection.AddItem(aData: TObject): TListCollectionItem;
begin
  Result := FCollection.Add as FBaseClass;
  Result.Data := aData;
end;

function TListCollection.AddItem(stKey: String): TListCollectionItem;
var
  i : Integer;
  aItem : TListCollectionItem;
begin
  //
  for i := 0 to FCollection.Count-1 do
  begin
    aItem := FCollection.Items[i] as TListCollectionItem;
    if CompareText(aItem.Key, stKey) = 0 then
    begin
      Result := aItem;
      Exit;
    end;
  end;
  //
  Result := FCollection.Add as TListCollectionItem;
  Result.Key := stKey;

end;

procedure TListCollection.Clear;
begin
  FCollection.Clear;
end;

constructor TListCollection.Create;
begin
  FCollection := TCollection.Create(TListCollectionItem);
  FBaseClass := TListCollectionItem;
end;

constructor TListCollection.Create(aItemClass: TListCollectionItemClass);
begin
  FCollection := TCollection.Create(aItemClass);
  FBaseClass := aItemClass;
end;

destructor TListCollection.Destroy;
begin
  FCollection.Free;
end;

function TListCollection.FindList(const aData: TObject): TListCollectionItem;
var
  i : Integer;
  aItem : TListCollectionItem;
begin
  Result := nil;
  //
  if aData = nil then Exit;
  //
  for i := 0 to FCollection.Count-1 do
  begin
    aItem := FCollection.Items[i] as TListCollectionItem;
    if aItem.Data = aData then
    begin
      Result := aItem;
      Break;
    end;
  end;
end;

function TListCollection.FindList(const stKey: String): TListCollectionItem;
var
  i : Integer;
  aItem : TListCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to FCollection.Count-1 do
  begin
    aItem := FCollection.Items[i] as TListCollectionItem;
    if CompareStr(aItem.Key, stKey) = 0 then
    begin
      Result := aItem;
      Break;
    end;
  end;
end;

function TListCollection.FindList(const stKey: String;
  const aData: TObject): TListCollectionItem;
var
  i : Integer;
  aItem : TListCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to FCollection.Count-1 do
  begin
    aItem := FCollection.Items[i] as TListCollectionItem;
    if (CompareStr(aItem.Key, stKey) = 0) and (aItem.Data = aData) then
    begin
      Result := aItem;
      Break;
    end;
  end;

end;

function TListCollection.GetList(i: Integer): TListCollectionItem;
begin
  Result := nil;
  //
  if (i>=0) and (i<FCollection.Count) then
    Result := FCollection.Items[i] as TListCollectionItem;
end;

function TListCollection.GetListCount: Integer;
begin
  Result := FCollection.Count;
end;

function TListCollection.GetTotalCount: Integer;
var
  i : Integer;
  aCollectionItem : TListCollectionItem;
begin
  //
  Result := 0;
  //
  for i := 0 to FCollection.Count-1 do
  begin
    aCollectionItem := FCollection.Items[i] as TListCollectionItem;
    //
    Inc(Result, aCollectionItem.List.Count);
  end;

end;

{ TListCollectionItem }

constructor TListCollectionItem.Create(aColl: TCollection);
begin
  inherited Create(aColl);

  List := TList.Create;

end;

destructor TListCollectionItem.Destroy;
begin
  List.Free;

  inherited;
end;

{ TMLStringList }

function TMLStringList.Add: TMLStringList;
begin
  Result := TMLStringList.Create;
  Result.FParent := Self;
  FChilds.Add(Result);

end;

procedure TMLStringList.Clear;
var
  i : Integer;
begin
  for i := Count-1 downto 0 do
  begin
    Childs[i].Free;
  end;

  FChilds.Clear;

end;

constructor TMLStringList.Create;
begin
  FChilds := TList.Create;

end;

destructor TMLStringList.Destroy;
var
  i : Integer;
begin

  for i := FChilds.Count-1 downto 0 do
    TObject(FChilds.Items[i]).Free;

  FChilds.Free;

end;

function TMLStringList.GetChild(i:Integer): TMLStringList;
begin
  Result := nil;
  //
  if (i >= 0) and (i < FChilds.Count) then
    Result := TMLStringList(FChilds.Items[i]);

end;

function TMLStringList.GetCount: Integer;
begin
  Result := FChilds.Count;
end;

{ TStringLinkedList }

procedure TStringLinkedList.Add(stData: String);
var
  pLastData, pNewData : PStringLinkedListItem;
begin
  //
  if FList.Count > 0 then
    pLastData := FList[FList.Count-1]
  else
    pLastData := nil;

  //pNewData := nil;
  //ReallocMem(pNewData, SizeOf(TStringLinkedListItem));
  New(pNewData);
  pNewData^.Before := nil;
  pNewData^.Next := nil;
  pNewData.FString := stData;


  if pLastData <> nil then
    pLastData^.Next := pNewData;
  pNewData^.Before := pLastData;

  //
  if FList.Count mod FDelta = 0 then
    FList.Capacity := FList.Count + FDelta;
  FList.Add(pNewData);
  //
  //Result := pNewData;

end;

{ TRecordList }

function TRecordList.Add: Pointer;
begin
  Result := nil;
  (*
  if FCount = FCapacity then Grow;

  Result := @FList[FCount];
  //
  Inc(FCount);
  *)
end;

procedure TRecordList.Clear;
begin
  (*
  if FCount <> 0 then
  begin
    Finalize(FList^[0], FCount);
    FCount := 0;
    SetCapacity(0);
  end;
  *)
end;

constructor TRecordList.Create;
begin
  FCount := 0;
end;

destructor TRecordList.Destroy;
begin

  inherited Destroy;
  (*
  if FCount <> 0 then Finalize(FList^[0], FCount);
  FCount := 0;
  SetCapacity(0);
  *)
end;

procedure TRecordList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);

end;

procedure TRecordList.SetCapacity(NewCapacity: Integer);
begin
  (*
  ReallocMem(FList, NewCapacity * SizeOf(TRecordItem));
  FCapacity := NewCapacity;
  *)
end;

{ TCommonCollection }



constructor TCommonCollection.Create(aItemClass: TCommonCollectionItemClass);
begin
  inherited Create(aItemClass);
//  FItems := TCollection.Create(aItemClass);
end;

destructor TCommonCollection.Destroy;
begin

  inherited;
end;

function TCommonCollection.FindItem(
  const iKeyInt: Integer): TCommonCollectionItem;
var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if aItem.KeyByInt = iKeyInt then
    begin
      Result := aItem;
      Break;
    end;
  end;

end;

function TCommonCollection.FindItem(
  const stKey: String): TCommonCollectionItem;

var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if aItem.KeyByString = Trim(stKey) then
    begin
      Result := aItem;
      Break;
    end;
  end;

end;

procedure TArrayDataList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else
    if FCapacity > 8 then
      Delta := 16
    else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

procedure TArrayDataList.Clear;
begin
  SetCapacity(0);
  FCount := 0;
  //SetCapacity(20000);

end;



destructor TArrayDataList.Destroy;
begin
  Clear;
  //
  inherited;
end;

procedure TArrayDataList.SetCapacity(const NewCapacity: Integer);
const
  PROC_TITLE = 'SetCapacity';
begin

  FCapacity := NewCapacity;
end;

function TCommonCollection.FindItem(const iKeyInt,
  iKeyInt2: Integer): TCommonCollectionItem;
var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if (aItem.KeyByInt = iKeyInt) and (aItem.Key2ByInt = iKeyInt2) then
    begin
      Result := aItem;
      Break;
    end;
  end;


end;

function TCommonCollection.FindItem(const stKey,
  stKey2: String): TCommonCollectionItem;
var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if (aItem.KeyByString = Trim(stKey)) and (aItem.Key2ByString = Trim(stKey)) then
    begin
      Result := aItem;
      Break;
    end;
  end;


end;

function TCommonCollection.FindItem(
  const aKeyObject: TObject): TCommonCollectionItem;
var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if (aItem.KeyByObject = aKeyObject) then
    begin
      Result := aItem;
      Break;
    end;
  end;


end;

function TCommonCollection.FindItem(const aKeyObject: TObject;
  const iKeyInt, iKeyInt2: Integer): TCommonCollectionItem;
var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if (aItem.KeyByInt = iKeyInt) and (aItem.Key2ByInt = iKeyInt2) and
        (aItem.KeyByObject = aKeyObject) then
    begin
      Result := aItem;
      Break;
    end;
  end;

end;

function TCommonCollection.FindItem(const iKeyInt, iKeyInt2: Integer;
  var iP: Integer): TCommonCollectionItem;
var
  i : Integer;
  aItem : TCommonCollectionItem;
begin
  Result := nil;
  //
  for i := iP to Count-1 do
  begin
    aItem := Items[i] as TCommonCollectionItem;
    //
    if (aItem.KeyByInt = iKeyInt) and (aItem.Key2ByInt = iKeyInt2) then
    begin
      Result := aItem;
      iP := i;
      Exit;
    end;
  end;
  iP := 0; 
end;

{ TBarItems }

constructor TBarItems.Create;
begin
  inherited Create(TBarItem);
end;

function TBarItems.FindIntraDayItem(dTime: TDateTime): TBarItem;
var
  i : Integer;
  aBarItem : TBarItem;
begin
  //
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    aBarItem := Items[i] as TBarItem;
    //                                     
    if CompareDateTime(dTime, aBarItem.T)<0 then
    begin
      Result := aBarItem;
      Break;
    end;

  end;
end;

{ TCommonCollectionItem }

procedure TCommonCollectionItem.Assign(aSource: TPersistent);
var
  aSourceItem : TCommonCollectionItem;
begin

  aSourceItem := aSource as TCommonCollectionItem;

  KeyByString := aSourceItem.KeyByString;
  KeyByInt := aSourceItem.KeyByInt;
  KeyByObject := aSourceItem.Key2ByObject;
    //
  Key2ByString := aSourceItem.Key2ByString;
  Key2ByInt := aSourceItem.Key2ByInt;
  Key2ByObject := aSourceItem.Key2ByObject;

end;

{ TManagerCollection }

constructor TManagerCollection.Create(
  aItemClass: TCommonCollectionItemClass);
begin
  inherited Create(aItemClass);
  //
  RefCount := 0;
  AutoSave := False;
end;

procedure TManagerCollection.DecRef;
begin
  Dec(RefCount);
  //
  if RefCount = 0 then
  begin
    if AutoSave then
      Save;
    //
    Free;
  end;
end;

destructor TManagerCollection.Destroy;
begin


  inherited;
end;

procedure TManagerCollection.IncRef;
begin
  Inc(RefCount);

end;

procedure TManagerCollection.Load;
begin

end;

procedure TManagerCollection.Save;
begin

end;

{ TBarMatrix }

constructor TBarMatrix.Create;
begin
  inherited Create(TBarMatrixItem);

end;


constructor TBarMatrix.Create(aClass: TBarMatrixItemClass);
begin
  inherited Create(aClass);

end;

procedure TBarMatrix.Initialize;
var
  i : Integer;
  aMatrixItem : TBarMatrixItem;
begin
  for i := 0 to Count-1 do
  begin
    aMatrixItem := Items[i] as TBarMatrixItem;
    aMatrixItem.Initialize;
  end;
end;

{
procedure TBarMatrix.InitValues;
var
  i : Integer;
  aMatrixItem : TBarMatrixItem;
begin
  for i := 0 to Count-1 do
  begin
    aMatrixItem := Items[i] as TBarMatrixItem;
    aMatrixItem.InitValues;
  end;
end;
}
procedure TBarMatrix.SaveToFile(const stFileName: String);
var
  i, j : Integer;
  aBaseMatrixItem, aMatrixItem : TBarMatrixItem;
  aItem : TTOHLCItem;
  stLine : String;
  aFiles : TStringList;
begin
  //
  aFiles := TStringList.Create;

  try
    aBaseMatrixItem := Items[0] as TBarMatrixItem;
    //
    stLine := ',';
    for i := 0 to Count-1 do
    begin
      aMatrixItem := Items[i] as TBarMatrixItem;
      stLine := stLine + aMatrixItem.KeyByString + ';'+ aMatrixItem.Key2ByString + ',';
    end;
    aFiles.Add(stLine);
    //
    for i := 0 to aBaseMatrixItem.BarCount-1 do
    begin
      aItem := aBaseMatrixItem.Bars[i];
      //
      stLine := FormatDateTime('yyyy-mm-dd', aItem.T) + ',' +
        Format('%f;%d;%f;%f;%f;%d', [aItem.Close, aItem.V, aItem.Open, aItem.High, aItem.Low, aItem.LValue1]);
      //
      for j := 1 to Count-1 do
      begin
        aMatrixItem := Items[j] as TBarMatrixItem;
        aItem := aMatrixItem.Bars[i];
        //
        stLine := stLine + ',' + Format('%f;%d;%f;%f;%f;%d',
          [aItem.Close, aItem.V, aItem.Open, aItem.High, aItem.Low, aItem.LValue1]);
      end;
      aFiles.Add(stLine);
    end;
    //
    aFiles.SaveToFile(stFileName);

  finally
    aFiles.Free;
  end;

end;

destructor TBarMatrix.Destroy;
begin

  inherited;
end;

{ TBarMatrixItem }

function TBarMatrixItem.AddTOHLCItem: TTOHLCItem;
begin
  Result := FBarCollection.Add as TTOHLCItem;
end;

constructor TBarMatrixItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  //
  FBarCollection := TCommonCollection.Create(TTOHLCItem);
  Tag := 0;
end;

destructor TBarMatrixItem.Destroy;
begin
  FBarCollection.Free;

  inherited;
end;

function TBarMatrixItem.GetBarCount: Integer;
begin
  Result := FBarCollection.Count;
end;

function TBarMatrixItem.GetBars(i: Integer): TTOHLCItem;
begin
  Result := nil;
  //
  if (i >=0) and (i < FBarCollection.Count) then
    Result := FBarCollection.Items[i] as TTOHLCItem;
end;

procedure TBarMatrixItem.Initialize;
begin
  //
  Tag := 0;
end;

{
procedure TBarMatrixItem.InitValues;
begin
  //
end;
}
end.
