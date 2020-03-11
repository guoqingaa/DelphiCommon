unit SMS_Highlighter;

interface

uses
  Classes;

type

  THighlightItem = class(TCollectionItem)
  public
    TimeOut : Integer;
    HighlightObject : TObject;
    HighlightNumber : Integer;
  end;

  THighlighter = class
  private
    FItems : TCollection;
    FDuration: Integer;
    function GetHighlighted(i: Integer): THighlightItem;
    function GetHighlightedCount: Integer;
    function GetHightlight(i: Integer): THighlightItem;
    function GetHightlightCount: Integer;
    //
    function FindHighlight(aObject: TObject): THighlightItem; overload;
    function FindHighlight(iNumber: Integer): THighlightItem; overload;
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure DoHighlight(aObject: TObject); overload;
    procedure DoHighlight(iNumber: Integer); overload;
    //
    procedure PassTime(iTime: Integer);
    //
    property HighlightCount : Integer read GetHightlightCount;
    property Highlights[i:Integer]: THighlightItem read GetHightlight;
    //
    property Highlighteds[i:Integer]: THighlightItem read GetHighlighted;
    property HighlightedCount: Integer read GetHighlightedCount;
    //
    property Duration : Integer read FDuration write FDuration;
  end;

implementation

{ THighlighter }

constructor THighlighter.Create;
begin
  FItems := TCollection.Create(THighlightItem);

  FDuration := 5;
end;

destructor THighlighter.Destroy;
begin
  FItems.Free;
  //
  inherited;
end;

procedure THighlighter.DoHighlight(aObject: TObject);
var
  aItem : THighlightItem;
begin
  //
  aItem := FindHighlight(aObject);
  //
  if aItem = nil then
  begin
    aItem := FItems.Add as THighlightItem;
    aItem.HighlightObject := aObject;
  end else
    aItem.TimeOut := FDuration;
end;

procedure THighlighter.DoHighlight(iNumber: Integer);
var
  aItem : THighlightItem;
begin
  //
  aItem := FindHighlight(iNumber);
  //
  if aItem = nil then
  begin
    aItem := FItems.Add as THighlightItem;
    aItem.HighlightNumber := iNumber;
  end else
    aItem.TimeOut := FDuration;
end;

function THighlighter.FindHighlight(aObject: TObject): THighlightItem;
var
  i : Integer;
begin
  //
  Result := nil;
  //
  for i := 0 to FItems.Count-1 do
  begin
    if (FItems.Items[i] as THighlightItem).HighlightObject = aObject then
    begin
      Result := FItems.Items[i] as THighlightItem;
      break;
    end;
  end;

end;

function THighlighter.FindHighlight(iNumber: Integer): THighlightItem;
var
  i : Integer;
begin
  //
  Result := nil;
  //
  for i := 0 to FItems.Count-1 do
  begin
    if (FItems.Items[i] as THighlightItem).HighlightNumber = iNumber then
    begin
      Result := FItems.Items[i] as THighlightItem;
      break;
    end;
  end;
end;

function THighlighter.GetHighlighted(i: Integer): THighlightItem;
var
  j : Integer;
  aItem : THighlightItem;
begin
  //
  Result := nil;
  //
  for j := 0 to FItems.Count-1 do
  begin
    aItem := FItems.Items[j] as THighlightItem;
    //
    if aItem.TimeOut mod 2 = 0 then
    begin
      Dec(i);
      //
      if i < 0 then
      begin
        Result := aItem;
        break;
      end;
    end;
  end;

end;

function THighlighter.GetHighlightedCount: Integer;
var
  i : Integer;
  aItem : THighlightItem;
begin
  //
  Result := 0;
  //
  for i := 0 to FItems.Count-1 do
  begin
    aItem := FItems.Items[i] as THighlightItem;
    //
    if aItem.TimeOut mod 2 = 0 then
      Inc(Result);
  end;

end;

function THighlighter.GetHightlight(i: Integer): THighlightItem;
begin
  Result := nil;
  //
  if (i >= 0) and (i < FItems.Count) then
    Result := FItems.Items[i] as THighlightItem;

end;

function THighlighter.GetHightlightCount: Integer;
begin
  Result := FItems.Count;
end;

procedure THighlighter.PassTime(iTime: Integer);
var
  i : Integer;
  aItem : THighlightItem;
begin
  for i := FItems.Count-1 downto 0 do
  begin
    aItem := FItems.Items[i] as THighlightItem;
    //
    Dec(aItem.TimeOut);
    //
    if aItem.TimeOut = 0 then
      aItem.Free;
  end;

end;

end.
