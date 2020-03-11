unit SMS_RangeCompare;

interface

uses
  SysUtils, Classes, Windows, Types;

type

  TRangeItem = array[0..1] of Double;
  //
  {
  TRangeItem = record
    RangeCriteria : Double;
    Value : Integer;
  end;
  }
  TSMSRangeCompare = class
  private
    FCompareRange : array of TRangeItem;
  public
    procedure AddRange(dRangeHigh, dValue: Double);

    function CompareValue(dValue : Double): Double;

    constructor Create;
    destructor Destroy; override;
  end;

  TSMSRangeCompareTemplateItem = class
  private
    FRangeCompare : TSMSRangeCompare;
  public
    TemplateName : String;

    property Values : TSMSRangeCompare read FRangeCompare;

    constructor Create;
    destructor Destroy; override;
  end;

  TSMSRangeCompareManager = class
  private
    FRangeCompareTemplateList : TList;
  public
    constructor Create;
    destructor Destroy; override;

    function FindRangeCompareTemplate(stName: String): TSMSRangeCompareTemplateItem;
    function AddRangeCompareTemplate(stName: String): TSMSRangeCompareTemplateItem;
    //
    function ConfigTemplates: Boolean;
    //
    property RangeCompareTemplateList : TList read FRangeCompareTemplateList;
  end;



implementation

{ TSMSRangeCompare }

//uses



procedure TSMSRangeCompare.AddRange(dRangeHigh, dValue: Double);
var
  iLength : Integer;
begin
  iLength := Length(FCompareRange);
  SetLength(FCompareRange, iLength+1);
  FCompareRange[iLength][0] := dRangeHigh;
  FCompareRange[iLength][1] := dValue;

end;

function TSMSRangeCompare.CompareValue(dValue: Double): Double;
var
  i, iLength : Integer;
begin
  Result := 0;
  //
  iLength := Length(FCompareRange);
  //
  for i := 0 to iLength-1 do
  begin
    if dValue <= FCompareRange[i][0] then
    begin
      Result := FCompareRange[i][1];
      Break;
    end;
  end;
end;

constructor TSMSRangeCompare.Create;
begin
  SetLength(FCompareRange, 0);
end;

destructor TSMSRangeCompare.Destroy;
begin
  SetLength(FCompareRange, 0);

  inherited;
end;

{ TSMSRangeCompareTemplateItem }

constructor TSMSRangeCompareTemplateItem.Create;
begin
  //
  FRangeCompare := TSMSRangeCompare.Create;
end;

destructor TSMSRangeCompareTemplateItem.Destroy;
begin

  FRangeCompare.Free;
  //
  inherited;
end;

{ TSMSRangeCompareManager }

function TSMSRangeCompareManager.AddRangeCompareTemplate(
  stName: String): TSMSRangeCompareTemplateItem;
begin
  Result := FindRangeCompareTemplate(stName);
  //
  if Result = nil then
  begin
    Result := TSMSRangeCompareTemplateItem.Create;
    Result.TemplateName := stName;
  end;
end;

function TSMSRangeCompareManager.ConfigTemplates: Boolean;
begin
  //
end;

constructor TSMSRangeCompareManager.Create;
var
  aNearTemplate, aFarTemplate : TSMSRangeCompareTemplateItem;
begin
  FRangeCompareTemplateList := TList.Create;
  //
  aNearTemplate := AddRangeCompareTemplate('CF=NEAR');
  FRangeCompareTemplateList.Add(aNearTemplate);
  aNearTemplate.FRangeCompare.AddRange(150, 10);
  aNearTemplate.FRangeCompare.AddRange(300, 15);
  aNearTemplate.FRangeCompare.AddRange(600, 30);
  aNearTemplate.FRangeCompare.AddRange(900, 60);
  aNearTemplate.FRangeCompare.AddRange(1500, 90);
  aNearTemplate.FRangeCompare.AddRange(150000, 150);

  aNearTemplate := AddRangeCompareTemplate('CF=NEAR-10');
  FRangeCompareTemplateList.Add(aNearTemplate);
  aNearTemplate.FRangeCompare.AddRange(150, Round(10*0.9));
  aNearTemplate.FRangeCompare.AddRange(300, Round(15*0.9));
  aNearTemplate.FRangeCompare.AddRange(600, Round(30*0.9));
  aNearTemplate.FRangeCompare.AddRange(900, Round(60*0.9));
  aNearTemplate.FRangeCompare.AddRange(1500, Round(90*0.9));
  aNearTemplate.FRangeCompare.AddRange(150000, Round(150*0.9));


  aNearTemplate := AddRangeCompareTemplate('CF=NEAR-20');
  FRangeCompareTemplateList.Add(aNearTemplate);
  aNearTemplate.FRangeCompare.AddRange(150, Round(10*0.8));
  aNearTemplate.FRangeCompare.AddRange(300, Round(15*0.8));
  aNearTemplate.FRangeCompare.AddRange(600, Round(30*0.8));
  aNearTemplate.FRangeCompare.AddRange(900, Round(60*0.8));
  aNearTemplate.FRangeCompare.AddRange(1500, Round(90*0.8));
  aNearTemplate.FRangeCompare.AddRange(150000, Round(150*0.8));

  aNearTemplate := AddRangeCompareTemplate('CF=NEAR-50');
  FRangeCompareTemplateList.Add(aNearTemplate);
  aNearTemplate.FRangeCompare.AddRange(150, Round(10*0.5));
  aNearTemplate.FRangeCompare.AddRange(300, Round(15*0.5));
  aNearTemplate.FRangeCompare.AddRange(600, Round(30*0.5));
  aNearTemplate.FRangeCompare.AddRange(900, Round(60*0.5));
  aNearTemplate.FRangeCompare.AddRange(1500, Round(90*0.5));
  aNearTemplate.FRangeCompare.AddRange(150000, Round(150*0.5));


  aNearTemplate := AddRangeCompareTemplate('CF=NEAR-90');
  FRangeCompareTemplateList.Add(aNearTemplate);
  aNearTemplate.FRangeCompare.AddRange(150, Round(10*0.1));
  aNearTemplate.FRangeCompare.AddRange(300, Round(15*0.1));
  aNearTemplate.FRangeCompare.AddRange(600, Round(30*0.1));
  aNearTemplate.FRangeCompare.AddRange(900, Round(60*0.1));
  aNearTemplate.FRangeCompare.AddRange(1500, Round(90*0.1));
  aNearTemplate.FRangeCompare.AddRange(150000, Round(150*0.1));



  aFarTemplate := AddRangeCompareTemplate('CF=FAR');
  FRangeCompareTemplateList.Add(aFarTemplate);
  aFarTemplate.FRangeCompare.AddRange(150, 15);
  aFarTemplate.FRangeCompare.AddRange(300, 25);
  aFarTemplate.FRangeCompare.AddRange(600, 45);
  aFarTemplate.FRangeCompare.AddRange(900, 90);
  aFarTemplate.FRangeCompare.AddRange(1500, 135);
  aFarTemplate.FRangeCompare.AddRange(150000, 225);

  aFarTemplate := AddRangeCompareTemplate('CF=FAR-10');
  FRangeCompareTemplateList.Add(aFarTemplate);
  aFarTemplate.FRangeCompare.AddRange(150, Round(15*0.9));
  aFarTemplate.FRangeCompare.AddRange(300, Round(25*0.9));
  aFarTemplate.FRangeCompare.AddRange(600, Round(45*0.9));
  aFarTemplate.FRangeCompare.AddRange(900, Round(90*0.9));
  aFarTemplate.FRangeCompare.AddRange(1500, Round(135*0.9));
  aFarTemplate.FRangeCompare.AddRange(150000, Round(225*0.9));

  aFarTemplate := AddRangeCompareTemplate('CF=FAR-20');
  FRangeCompareTemplateList.Add(aFarTemplate);
  aFarTemplate.FRangeCompare.AddRange(150, Round(15*0.8));
  aFarTemplate.FRangeCompare.AddRange(300, Round(25*0.8));
  aFarTemplate.FRangeCompare.AddRange(600, Round(45*0.8));
  aFarTemplate.FRangeCompare.AddRange(900, Round(90*0.8));
  aFarTemplate.FRangeCompare.AddRange(1500, Round(135*0.8));
  aFarTemplate.FRangeCompare.AddRange(150000, Round(225*0.8));


  aFarTemplate := AddRangeCompareTemplate('CF=FAR-50');
  FRangeCompareTemplateList.Add(aFarTemplate);
  aFarTemplate.FRangeCompare.AddRange(150, Round(15*0.5));
  aFarTemplate.FRangeCompare.AddRange(300, Round(25*0.5));
  aFarTemplate.FRangeCompare.AddRange(600, Round(45*0.5));
  aFarTemplate.FRangeCompare.AddRange(900, Round(90*0.5));
  aFarTemplate.FRangeCompare.AddRange(1500, Round(135*0.5));
  aFarTemplate.FRangeCompare.AddRange(150000, Round(225*0.5));


end;

destructor TSMSRangeCompareManager.Destroy;
begin
  FRangeCompareTemplateList.Free;

  inherited;
end;

function TSMSRangeCompareManager.FindRangeCompareTemplate(
  stName: String): TSMSRangeCompareTemplateItem;
var
  i : Integer;
  aTemplateItem : TSMSRangeCompareTemplateItem;
begin
  Result := nil;
  //
  for i := 0 to FRangeCompareTemplateList.Count-1 do
  begin
    aTemplateItem := TSMSRangeCompareTemplateItem(FRangeCompareTemplateList.Items[i]);
    //
    if UpperCase(aTemplateItem.TemplateName) = UpperCase(stName) then
    begin
      Result := aTemplateItem;
      Break;
    end;
  end;

end;

end.
