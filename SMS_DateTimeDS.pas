unit SMS_DateTimeDS;

interface

uses
  SysUtils, Windows,
  SMS_DateTimes, SMS_DS;

// 4³â  1ºÐºÀ °³¼ö = 1440 * 300 * 4 = 1,728,000
const
  MaxCDataListSize = Maxint div 1024;  // 1024 = 2,097,152

type
  PCDataItem = ^TCDataItem;
  TCDataItem = {$IFNDEF DoubleSize} packed {$ENDIF}record
    LastDateMin : TDateMin;
    LastSecond : Byte;

{$IFDEF DoubleSize}
    O, H, L, C : Double;
{$ELSE}
    O, H, L, C : Single;
{$ENDIF}

{$IFDEF QUOTEX}

    Term : TTermRec;

{$ENDIF}         

    FillVol : Integer;
    OpenInt : LongInt;//Double;

    Count : Word;
  end;

  TCDataItemList = array[0..MaxCDataListSize] of TCDataItem;
  PCDataItemList = ^TCDataItemList;

  TCDataList2 = class(TArrayDataList)
  private
    FList: PCDataItemList;
  protected

  public
    function Add: PCDataItem;
    procedure Delete(i: Integer);
    procedure SetCapacity(const NewCapacity: Integer); override;
    procedure SetCount(const NewCount: Integer);
    //
    constructor Create;
    destructor Destroy; override;
    //
    property List : PCDataItemList read FList;
  end;

implementation


{ TCDataList2 }

function TCDataList2.Add: PCDataItem;
//var
//  iOffset : Integer;
begin
  if FCount = FCapacity then Grow;
  //
  Result := @FList^[FCount];
  ZeroMemory(@FList^[FCount], SizeOf(TCDataItem));
  //Result.Next := nil;
  //Result.Before := nil;
  {
  if FCount > 0 then
  begin
    Result.Before := @(FList^[FCount-1]);
    FList^[FCount-1].Next := @(FList^[FCount]);//Result;
    //
    //iOffset := @(FList^[FCount])-@(FList^[FCount-1]);
  end;
  }
  Inc(FCount);

end;

procedure TCDataList2.Delete(i: Integer);
begin

  Dec(FCount);
  if i < FCount then
    System.Move(FList^[i + 1], FList^[i],
      (FCount - i) * SizeOf(TCDataItem));
end;

{
function TCDataList2.Insert(pPos: PCDataItem): PCDataItem;
begin

end;
}

{
function TCDataList2.Insert(iPos: Integer): PCDataItem;
begin

end;
}

procedure TCDataList2.SetCapacity(const NewCapacity: Integer);
const
  PROC_TITLE = 'SetCapacity';
//var
//  aPointer : Pointer;
begin
  //aPointer := FList;
// try
   ReallocMem(FList, NewCapacity * SizeOf(TCDataItem));

{  except on E:Exception do

    gLog.AddNoMessage(lkError, ClassName, PROC_TITLE,
      Format('size: %d * %d = %d %s',
        [NewCapacity, SizeOf(TCDataItem), NewCapacity*SizeOf(TCDataItem), E.Message]));
  end;
}
  //
  {
  if aPointer <> FList then
  begin
    gLog.Add(lkDebug, ClassName, 'SetCapacity', 'mem reassigned');
    //CopyMemory(FList, aPointer, FCapacity);
  end;
  }
  FCapacity := NewCapacity;
end;



destructor TCDataList2.Destroy;
begin
  Clear;
  //Finalize(FList^);
  FList := nil;

  inherited;
end;

constructor TCDataList2.Create;
begin
  Clear;
  //SetCapacity(200000);

end;

procedure TCDataList2.SetCount(const NewCount: Integer);
begin
  FCount := NewCount;
  ZeroMemory(@FList^[0], SizeOf(TCDataItem)*FCount);

end;



end.
