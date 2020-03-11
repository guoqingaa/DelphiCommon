unit SMS_Columns;

//
//
//
//

interface

uses
  Classes, SysUtils, Grids, Forms, Graphics,

  MSXML_TLB, SMS_XMLs;

type

  TColumns = class;

  TSColumnItem = class(TCollectionItem)
  public
    // fixed attributes
    FieldName: String;   // 컬럼명
    DefWidth : Integer;  // 기본넓이
    Alignment : TAlignment;
    // variable attributes
    Title : String;     // 항목
    Width : Integer;    // 넓이
    Scale : Integer;    // 단위, 현재 Precision 으로 사용됨.
    UseThousandSep : Boolean;
    Desc : String;

    ShowColorChange : Boolean;  //증감 색 표현 여부
    UseParentColor : Boolean;
    BackColor : TColor;
    FontColor : TColor;
    // default attributes
    _Width : Integer;
    _Title : String;
    _Scale : Integer;
    //
    RegacyTitle : String;
    //
    UseGradationEffect : Boolean;
    GradationMinValue : Integer;
    GradationMaxValue : Integer;
    GradationMinColor : TColor;
    GradationMaxColor : TColor;
    //GradationFont

    //UseMaxColor : Boolean;
    //MaxValue : Integer;
    //MaxColor : TColor;

    //UseMinColor : Boolean;
    //MinValue : Integer;
    //MinColor : TColor;
    //
    UseThousandComma : Boolean;
    //
    Margin : Integer;

    Parent : TColumns;

    Value : Double;
    ValueAsText : String;

    UserAsBool : Boolean;

    constructor Create(aColl: TCollection); override;

    procedure Assign(Source : TPersistent); override;
  end;

  TColumns = class(TCollection)
  private
    FDefaults : TList;
    FViewList : TList;
    FNonVisibles : TStrings;
    FFixedDetails : TStrings;
    FOnSetPersistence: TNotifyEvent;

    function GetColumn(i : Integer) : TSColumnItem;
    function FindColumn(aTarget : TList ; stKeyField : String) : TSColumnItem;
  public
    constructor Create;
    destructor Destroy; override;

    procedure CopyFrom(aColumns : TColumns);

    function AddColumn(stTitle : String; iDefWidth : Integer;
        aAlignment : TAlignment = taRightJustify; bShowColorChange : Boolean = False;
        iScale : Integer = 1): TSColumnItem;
    function AddColumnToView(stTitle : String ; iDefWidth : Integer = 100;
        aAlignment : TAlignment = taRightJustify; iScale : Integer = 1): TSColumnItem;
    function AddColumnToView2(stTitle : String ; iDefWidth : Integer = 100;
        aAlignment : TAlignment = taRightJustify; bShowChangeColor : Boolean = False; iScale : Integer = 1): TSColumnItem; overload;

    function AddColumnToDefault(stTitle : String; iDefWidth : Integer;   //Not Used
        aAlignment : TAlignment = taRightJustify; iScale : Integer = 1): TSColumnItem;  //Added by Seo
    //ViewList 에 있는 아이템들중 같은 타이틀의 Column 이 존재하면 FDefault 에 그냥 포인터만 추가
    //Column이 존재하지 않으면 새로 Column을 생성한 후 값 설정 후 FDefault 에 추가

    procedure AddNonVisibles(stNonVisible : String);
    procedure ClearNonVisibles;
    function FindNonVisibles(stNonVisible : String): Boolean;

    procedure UnSelectColumn(aColumn : TSColumnItem);
    procedure SelecteColumn(aColumn: TSColumnItem);

    procedure AddFixedDetails(stFixed : String);
    procedure ClearFixedDetails;
    function FindFixedDeatails(stFixed : String) : Boolean;

    function FindColumnItem(stColumn : String): TSColumnItem;
    function FindRegacyColumnItem(const stColumn: String): TSColumnItem;
    function GetViewIndex(const stColumn: String): Integer;

    procedure AllClear;
    procedure ViewToDefault;
    procedure DefaultToView;

    procedure RaiseColumn(aTarget : TList ; iIndex , iCount : Integer); //Not Used

    // work Form Called
    procedure SetPersistence(aNode: IXMLDOMElement);
    procedure GetPersistence(aNode: IXMLDOMElement);

    procedure RefreshGridHeaders(aGrid: TStringGrid; iRow, iStartCol: Integer);
    procedure UpdateColumnsWidth(aGrid: TStringGrid; iStartCol: Integer);

    function Config(aOwner: TForm): Boolean;
    // properties
    property Columns[i:Integer] : TSColumnItem read GetColumn; default;

    property Defaults : TList read FDefaults;
    property ViewList : TList read FViewList;

    property OnSetPersistence : TNotifyEvent read FOnSetPersistence write FOnSetPersistence;

  end;

implementation

uses
  SMS_DColumns;

//========================================================//
//                Init / Final                            //
//========================================================//

constructor TColumns.Create;
begin
  FDefaults := TList.Create;
  FViewList := TList.Create;
  FNonVisibles := TStringList.Create;
  FFixedDetails := TStringList.Create;

  inherited Create(TSColumnItem);
end;

destructor TColumns.Destroy;
begin
  FDefaults.Free;
  FViewList.Free;
  FNonVisibles.Free;
  FFixedDetails.Free;

  inherited;
end;

function TColumns.AddColumn(stTitle : String; iDefWidth : Integer;
    aAlignment : TAlignment; bShowColorChange : Boolean; iScale : Integer): TSColumnItem;
begin
  Result := Add as TSColumnItem;
  with Result do
  begin
    FieldName:= stTitle;
    DefWidth := iDefWidth;
    Alignment := aAlignment;

    Title := stTitle;
    Width := iDefWidth;
    Scale := iScale;
    ShowColorChange := bShowColorChange;

    _Title := Title;
    _Width := Width;
    _Scale := Scale;
    Parent := Self;
  end;
end;

function TColumns.AddColumnToView(stTitle: String; iDefWidth: Integer;
  aAlignment: TAlignment; iScale: Integer): TSColumnItem;
var
  aColumn : TSColumnItem;
begin
  aColumn := FindColumn(FDefaults , stTitle);
  if aColumn = nil then
  begin
    aColumn := Add as TSColumnItem;
    with aColumn do
    begin
      FieldName:= stTitle;
      DefWidth := iDefWidth;
      Alignment := aAlignment;

      Title := stTitle;
      Width := iDefWidth;
      Scale := iScale;

      _Title := Title;
      _Width := Width;
      _Scale := Scale;

      Parent := Self;
    end;
    FDefaults.Add(aColumn);
  end;
  FViewList.Add(aColumn);
  Result := aColumn;
end;


function TColumns.AddColumnToDefault(stTitle: String; iDefWidth: Integer;
  aAlignment: TAlignment; iScale: Integer): TSColumnItem;
var
  aColumn : TSColumnItem;
begin
  aColumn := FindColumn(FViewList , stTitle);
  if aColumn = nil then
  begin
    aColumn := Add as TSColumnItem;
    with aColumn do
    begin
      FieldName:= stTitle;
      DefWidth := iDefWidth;
      Alignment := aAlignment;

      Title := stTitle;
      Width := iDefWidth;
      Scale := iScale;

      _Title := Title;
      _Width := Width;
      _Scale := Scale;

      Parent := Self;
    end;
  end;
  FDefaults.Add(aColumn);
  Result := aColumn;
end;


function TColumns.GetColumn(i : Integer) : TSColumnItem;
begin
  if (i >= 0) and (i < Count) then
    Result := Items[i] as TSColumnItem
  else
    Result := nil;
end;

// FDefaults -> FViewList
procedure TColumns.DefaultToView;
var
  aColItem : TSColumnItem;
  i : Integer;
begin
  FViewList.Clear;

  for i:=0 to FDefaults.Count - 1 do
  begin
    aColItem := TSColumnItem(FDefaults[i]);
    aColItem.Title := aColItem._Title;
    aColItem.Width := aColItem._Width;
    aColItem.Scale := aColItem._Scale;
    FViewList.Add(aColItem);
  end;
end;

// FViewList -> FDefaults
procedure TColumns.ViewToDefault;
var
  aColItem : TSColumnItem;
  i : Integer;
begin
  FDefaults.Clear;

  for i:=0 to FViewList.Count - 1 do
  begin
    aColItem := TSColumnItem(FViewList[i]);
    aColItem._Title := aColItem.Title;
    aColItem._Width := aColItem.Width;
    aColItem._Scale := aColItem.Scale;
    FDefaults.Add(aColItem);
  end;
end;
//========================================================//
//                Load / Save                             //
//========================================================//


procedure TColumns.GetPersistence(aNode: IXMLDOMElement);
var
  i, iIndex : Integer;
  aColItem: TSColumnItem;
  aColumnNode : IXMLDOMElement;
begin

  for i := 0 to FViewList.Count-1 do
  begin
    aColItem:= TSColumnItem(FViewList[i]);

    aColumnNode := MakeChildElement(aNode.ownerDocument, aNode, 'column');

      // col index
    iIndex := aColItem.Index;
    aColumnNode.setAttribute('index', iIndex);

    aColumnNode.setAttribute('alignment', aColItem.Alignment);
    aColumnNode.setAttribute('title', aColItem.Title);
    aColumnNode.setAttribute('_title', aColItem._Title);
    aColumnNode.setAttribute('width', aColItem.Width);
    aColumnNode.setAttribute('scale', aColItem.Scale);
    aColumnNode.setAttribute('margin', aColItem.Margin);
    aColumnNode.setAttribute('use_parentcolor', aColItem.UseParentColor);
    aColumnNode.setAttribute('backcolor', aColItem.BackColor);
    aColumnNode.setAttribute('fontcolor', aColItem.FontColor);
    aColumnNode.setAttribute('show_colorchange', aColItem.ShowColorChange);
    aColumnNode.setAttribute('use_thousandsep', aColItem.UseThousandSep);
    aColumnNode.setAttribute('user_bool', aColItem.UserAsBool);
    //
    aColumnNode.setAttribute('UseGradationEffect', aColItem.UseGradationEffect);
    aColumnNode.setAttribute('GradationMinValue', aColItem.GradationMinValue);
    aColumnNode.setAttribute('GradationMaxValue', aColItem.GradationMaxValue);
    aColumnNode.setAttribute('GradationMinColor', aColItem.GradationMinColor);
    aColumnNode.setAttribute('GradationMaxColor', aColItem.GradationMaxColor);
    //
    //aColumnNode.setAttribute('UseMaxColor', aColItem.UseMaxColor);
    //aColumnNode.setAttribute('MaxColor', aColItem.MaxColor);
    //aColumnNode.setAttribute('UseMinColor', aColItem.UseMinColor);
    //aColumnNode.setAttribute('MinColor', aColItem.MinColor);

  end;
  //

end;

procedure TColumns.SetPersistence(aNode: IXMLDOMElement);
var      
  aColItem: TSColumnItem;
  i: Integer;
  iIndex : Integer;
  aColumnNode : IXMLDOMElement;
  bValue : Boolean;
  iValue : Integer;
  stTitle, stValue : String;

begin
  FViewList.Clear;
  //
  for i := 0 to aNode.childNodes.length-1 do
  begin
    aColumnNode := aNode.childNodes[i] as IXMLDOMElement;
    iIndex := aColumnNode.getAttribute('index');
    //
    stTitle := aColumnNode.getAttribute('title');
    //
    aColItem := FindColumnItem(stTitle);
    //
    if aColItem = nil then
    begin
      aColItem := FindRegacyColumnItem(stTitle);
      //
      if aColItem = nil then
        continue;
    end;
    //
    if GetAttribute(aColumnNode, '_title', stValue) then
      aColItem._Title := stValue;
    //
    aColItem.Width := aColumnNode.getAttribute('width');
    aColItem.Scale :=  aColumnNode.getAttribute('scale');

    if GetAttribute(aColumnNode, 'margin', iValue) then
      aColItem.Margin := iValue;
    if GetAttribute(aColumnNode, 'alignment', iValue) then
      aColItem.Alignment := TAlignment(iValue);
    if GetAttribute(aColumnNode, 'use_parentcolor', bValue) then
      aColItem.UseParentColor := bValue;
    if GetAttribute(aColumnNode, 'backcolor', iValue) then
      aColItem.BackColor := iValue;
    if GetAttribute(aColumnNode, 'fontcolor', iValue) then
      aColItem.FontColor := iValue;

    if GetAttribute(aColumnNode, 'show_colorchange', bValue) then
      aColItem.ShowColorChange := bValue;
    //
    GetAttribute(aColumnNode, 'use_thousandsep', aColItem.UseThousandSep);
    GetAttribute(aColumnNode, 'user_bool', aColItem.UserAsBool);
    //
    GetAttribute(aColumnNode, 'UseGradationEffect', aColItem.UseGradationEffect);
    GetAttribute(aColumnNode, 'GradationMinValue', aColItem.GradationMinValue);
    GetAttribute(aColumnNode, 'GradationMaxValue', aColItem.GradationMaxValue);
    GetAttribute(aColumnNode, 'GradationMinColor', aColItem.GradationMinColor);
    GetAttribute(aColumnNode, 'GradationMaxColor', aColItem.GradationMaxColor);
    //
    //GetAttribute(aColumnNode, 'UseMaxColor', aColItem.UseMaxColor);
    //GetAttribute(aColumnNode, 'MaxColor', aColItem.MaxColor);
    //GetAttribute(aColumnNode, 'UseMinColor', aColItem.UseMinColor);
    //GetAttribute(aColumnNode, 'MinColor', aColItem.MinColor);
    //
    FViewList.Add( aColItem );
  end;
  //
  if Assigned(FOnSetPersistence) then
    FOnSetPersistence(Self);
  //

end;


function TColumns.FindColumn(aTarget: TList;
  stKeyField: String): TSColumnItem;
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  Result := nil;
  for i := 0 to aTarget.Count - 1 do
  begin
    aColumn := TSColumnItem(aTarget.Items[i]);
    if aColumn.FieldName = stKeyField then
    begin
      Result := aColumn;
      break;
    end;
  end;
end;



procedure TColumns.AddNonVisibles(stNonVisible: String);
begin
  if Assigned(FindColumn(FDefaults , stNonVisible)) or
    Assigned(FindColumn(FViewList , stNonVisible)) then
    FNonVisibles.Add(stNonVisible);
end;

procedure TColumns.ClearNonVisibles;
begin
  FNonVisibles.Clear;
end;


function TColumns.FindNonVisibles(stNonVisible: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to FNonVisibles.Count - 1 do
    if FNonVisibles.Strings[i] = stNonVisible then
    begin
      Result := True;
      break;
    end;

end;


procedure TColumns.RaiseColumn(aTarget: TList; iIndex, iCount: Integer);
//var
//  i : Integer;
//  aDest , aSource : TColumnItem;
begin

  if iIndex >= aTarget.Count-1 then Exit;
  if iIndex - iCount < 0 then Exit;

  //aDest := TColumnItem(aTarget.Items[iIndex-iCount]);
  //aSource := TColumnItem(aTarget.Items[iIndex]);

end;

procedure TColumns.AddFixedDetails(stFixed: String);
begin
  if Assigned(FindColumn(FDefaults , stFixed)) or
    Assigned(FindColumn(FViewList , stFixed)) then
    FFixedDetails.Add(stFixed);
end;

procedure TColumns.ClearFixedDetails;
begin
  FFixedDetails.Clear;
end;

function TColumns.FindFixedDeatails(stFixed: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i:= 0 to FFixedDetails.Count- 1 do
    if stFixed = FFixedDetails.Strings[i] then
    begin
      Result := True;
      break;
    end;
end;

function TColumns.FindColumnItem(stColumn: String): TSColumnItem;
var
  i : Integer;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    if CompareText(Trim((Items[i] as TSColumnItem).Title), Trim(stColumn)) = 0 then
    begin
      Result := Items[i] as TSColumnItem;
      Break;
    end;
  end;

end;

procedure TColumns.RefreshGridHeaders(aGrid: TStringGrid; iRow, iStartCol: Integer);
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  //
  for i := 0 to FViewList.Count-1 do
  begin
    aColumn := TSColumnItem(FViewList.Items[i]);
    aGrid.Cells[iStartCol+i, iRow] := aColumn.FieldName;
    aGrid.ColWidths[iStartCol+i] := aColumn.Width;
  end;
end;

procedure TColumns.UpdateColumnsWidth(aGrid: TStringGrid;
  iStartCol: Integer);
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  //
  for i := iStartCol to aGrid.ColCount-1 do
  begin
    aColumn := TSColumnItem(FViewList.Items[i-iStartCol]);
    aColumn.Width := aGrid.ColWidths[i];
  end;
end;

function TColumns.Config(aOwner: TForm): Boolean;
var
  aDlg : TColumnsConfig;
begin
  //
  aDlg := TColumnsConfig.Create(aOwner);

  try
    Result := aDlg.Open(Self);

    if Result then
    begin
      CopyFrom(aDlg.Columns);
    end;

  finally
    aDlg.Free;
  end;
end;

{ TColumnItem }

procedure TSColumnItem.Assign(Source: TPersistent);
var
  aSourceItem : TSColumnItem;
begin
  aSourceItem := Source as TSColumnItem;
  //
  FieldName := aSourceItem.FieldName;
  DefWidth := aSourceItem.DefWidth;
  Alignment := aSourceItem.Alignment;
  Desc := aSourceItem.Desc;
  // variable attributes
  Title := aSourceItem.Title;
  Width := aSourceItem.Width;
  Scale := aSourceItem.Scale;
  UseThousandSep := aSourceItem.UseThousandSep;
  ShowColorChange := aSourceItem.ShowColorChange;
  UseParentColor := aSourceItem.UseParentColor;
  BackColor := aSourceItem.BackColor;
  FontColor := aSourceItem.FontColor;

  UserAsBool := aSourceItem.UserAsBool;

  _Width := aSourceItem._Width;
  _Title := aSourceItem._Title;
  _Scale := aSourceItem._Scale;
  //
  UseGradationEffect := aSourceItem.UseGradationEffect;
  GradationMinValue := aSourceItem.GradationMinValue;
  GradationMaxValue := aSourceItem.GradationMaxValue;
  GradationMinColor := aSourceItem.GradationMinColor;
  GradationMaxColor := aSourceItem.GradationMaxColor;
  //
  //UseMaxColor := aSourceItem.UseMaxColor;
  //MaxColor := aSourceItem.MaxColor;
  //UseMinColor := aSourceItem.UseMinColor;
  //MinColor := aSourceItem.MinColor;

  //Parent := aSourceItem.Parent;

end;

constructor TSColumnItem.Create(aColl: TCollection);
begin
  inherited Create(aColl);
  //
  UseParentColor := True;
  BackColor := clWhite;
  FontColor := clBlack;
  UseThousandSep := True;
  UserAsBool := False;

  Margin := 0;

end;

procedure TColumns.CopyFrom(aColumns: TColumns);
var
  i : Integer;
  aSourceColumn, aColumn : TSColumnItem;
begin
  //
  FDefaults.Clear;
  FViewList.Clear;
  Assign(aColumns);
  //
  for i := 0 to Count-1 do
  begin
    aColumn := Items[i] as TSColumnItem;
    aColumn.Parent := Self;
  end;

  for i := 0 to aColumns.Defaults.Count-1 do
  begin
    aSourceColumn := TSColumnItem(aColumns.Defaults.Items[i]);
    //
    aColumn := FindColumnItem(aSourceColumn.Title);
    //
    if aColumn <> nil then
      FDefaults.Add(aColumn);
  end;
  //
  for i := 0 to aColumns.ViewList.Count-1 do
  begin
    aSourceColumn := TSColumnItem(aColumns.ViewList.Items[i]);
    //
    aColumn := FindColumnItem(aSourceColumn.Title);
    //
    if aColumn <> nil then
      FViewList.Add(aColumn);
  end;
end;

procedure TColumns.AllClear;
begin
  FDefaults.Clear;
  FViewList.Clear;
  FNonVisibles.Clear;
  FFixedDetails.Clear;

  Clear;

end;

procedure TColumns.SelecteColumn(aColumn: TSColumnItem);
begin
  if aColumn.Parent <> Self then Exit;
  //
  if FViewList.IndexOf(aColumn) < 0 then
    FViewList.Add(aColumn);

end;

procedure TColumns.UnSelectColumn(aColumn: TSColumnItem);
begin
  if aColumn.Parent <> Self then Exit;
  //
  FViewList.Remove(aColumn);
end;

function TColumns.FindRegacyColumnItem(
  const stColumn: String): TSColumnItem;
var
  i : Integer;
begin
  Result := nil;
  //
  for i := 0 to Count-1 do
  begin
    if CompareText(Trim((Items[i] as TSColumnItem).RegacyTitle), Trim(stColumn)) = 0 then
    begin
      Result := Items[i] as TSColumnItem;
      Break;
    end;

  end;

end;

function TColumns.GetViewIndex(const stColumn: String): Integer;
var
  i : Integer;
  aColumn : TSColumnItem;
begin
  Result := -1;
  //
  //
  for i := 0 to Count-1 do
  begin
    if CompareText(Trim((Items[i] as TSColumnItem).Title), Trim(stColumn)) = 0 then
    begin
      aColumn := Items[i] as TSColumnItem;
      //
      Result := FViewList.IndexOf(aColumn);
      Break;
    end;
  end;

end;

function TColumns.AddColumnToView2(stTitle: String; iDefWidth: Integer;
  aAlignment: TAlignment; bShowChangeColor: Boolean;
  iScale: Integer): TSColumnItem;
begin
  Result := FindColumn(FDefaults, stTitle);
  //
  if Result = nil then
  begin
    Result := AddColumn(stTitle, iDefWidth, aAlignment, bShowChangeColor, iScale);
    FDefaults.Add(Result);
  end;
  //
  FViewList.Add(Result);
  //
end;

end.
