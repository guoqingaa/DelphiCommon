unit SMS_FileXTerms;

interface

uses
  SysUtils, Classes, SMS_Strings, SMS_DS, SMS_DateTimes, SMS_Types;

type

  TSFileXTerms = class
  private
    FOnLog: TNotifyStringEvent;
    FLongValue: Integer;
    function GetCount: Integer;
    function GetItems(i: Integer): TTermRec;
  protected
    FFileName: String;
    FProcessStartTime : TDateTIme;
    FReadCount : LongWord;
    //
    FThreadHandle : THandle;
    FThreadID : TThreadID;
    //
    FReadItems : array of TTermRec;
    FReadCapacity : LongWord;
    //
    procedure SetReadCapacity(const iNewSize: LongWord);
  public
    constructor Create;

    function Load : Boolean;
    //
    property FileName : String read FFileName write FFileName;
    property OnLog : TNotifyStringEvent read FOnLog write FOnLog;
    //
    property Count : Integer read GetCount;
    property Items[i:Integer]: TTermRec read GetItems; default;
    property LongValue : Integer read FLongValue write FLongValue;
  end;

implementation


function LoadFileThreadFunc(Parameter: Pointer): Integer;
const
  PROC_TITLE = 'Execute';
  FILE_READ_PROCESS_STEP = 100;
  BUFFER_SIZE = 4096;

var
  aXTerms : TSFileXTerms;
  //
  iReadCount : Integer;
  F : TextFile;
  szBuffer : array[0..BUFFER_SIZE-1] of AnsiChar;
  stLine : String;
  aFiles, aTokens : TStringList;
  stTime : String;
  //
  pCurrent : PTermRec;
  iTimeLength : Integer;
  aPrevLineDateTime : TDateTime;
  {
  aRequest : TGFRequestItem;
  //dtTime : TDateTime;
  iNum, iBase : Integer;
  iUserStartDate : Integer;
  iReqRefDate : TDateTime;

}
begin
  Result := 0;

  //
  //gLog.Add(lkDebug, PROC_TITLE, PROC_TITLE, 'Start to Thread...');

  aXTerms := TSFileXTerms(Parameter);
  //
  aXTerms.FProcessStartTime := Now;
  {
  iUserStartDate := 0;
  iReqRefDate := High(Integer);
  if RequestInfo.UseReqCode and (Length(RequestInfo.ReqCode) > 1) then
  begin
    ExtractReqCode(RequestInfo.ReqCode,iNum, iBase);
    //
    if RequestInfo.RefDate < 0 then
      iReqRefDate := RequestInfo.Contract.Commodity.DateOfSession[Now]
    else
      iReqRefDate := RequestInfo.RefDate;
    //
    case iBase of
      0 :
        iUserStartDate := Round(iReqRefDate - iNum);
      1 :
        iUserStartDate := Round(IncMonth(iReqRefDate, - iNum));
      2 :
        iUserStartDate := Round(IncYear(iReqRefDate, - iNum));
    end;
  end;
    //
  }

  //  gLog.Add(lkDebug, ClassName, PROC_TITLE, Format('ReqRefDate:%f, %s',
  //    [iReqRefDate, FFilePath]));


    {
    if not FileExists(FFilePath) then
    begin
      gLog.Add(lkError, ClassName, PROC_TITLE, 'file not exist :'+FFilePath);
      //NotifyComplete;
      RequestComplete;
      Exit;
    end;
    }
    //
    //dtTime := Now;



    //aNewBarItems := TCollection.Create(TBarItem);

    //try
  {$IFDEF DEBUG}
  //    gLog.Add(lkDebug, ClassName, PROC_TITLE, 'file path='+FFilePath);
  //    dtTime := Now;
  {$ENDIF}

    if FileExists(aXTerms.FFileName) then
    begin
      iReadCount := 0;
      aXTerms.FReadCount := 0;
      aFiles := TStringList.Create;
      aTokens := TStringList.Create;
      //
      AssignFile(F, aXTerms.FFileName);
      try
        SetTextBuf(F, szBuffer, BUFFER_SIZE);
        FileMode := 0;

        Reset(F);

        //aFiles.Clear;
        //aPrevLineDateTime := 0;
        //
        while not Eof(F) do
        with aXTerms do
        begin
          Readln(F, stLine);
          //

          //if (iReadCount mod FILE_READ_PROCESS_STEP = 0) then
          //  Application.ProcessMessages;
          //


          GetTokens(stLine, aTokens, ',');

          if aTokens.Count < 4 then continue;

          stTime := Trim(aTokens[0]);

          if Pos('date', LowerCase(stLine)) > 0 then continue;
          //
          Inc(iReadCount);
          SetReadCapacity(iReadCount);
          pCurrent := @FReadItems[iReadCount-1];

          try

            pCurrent.LastTime := DateStringToDateTime(stTime);
            //
            stTime := Trim(aTokens[1]);
            iTimeLength := Length(stTime);
            //
            if iTimeLength = 3 then  //'0903'분 이 아니라 '903'인 경우 처리
            begin
              stTime := '0' + stTime;
              iTimeLength := 4;
            end;
            //
            if iTimeLength = 4 then
              pCurrent.LastTime := pCurrent.LastTime +
               EncodeTime(StrToInt(Copy(stTime, 1, 2)), StrToInt(Copy(stTime, 3, 2)), 0, 0)
            else
              pCurrent.LastTime := pCurrent.LastTime +
                EncodeTime(StrToInt(Copy(stTime, 1, 2)), StrToInt(Copy(stTime, 4, 2)), 0, 0);
            //
            {
            if (RequestInfo.ChartBase in [cbTick, cbSec, cbMin]) and
              (not RequestInfo.Contract.Commodity.QueryInSession(
                pCurrent.LastTime)) then
            begin
              Dec(FReceiveCount);
              continue;
            end;
            //
            if RequestInfo.UseReqCode and
              (pCurrent.LastTime < iUserStartDate) then
            begin
              Dec(FReceiveCount);
              continue;
            end;
            //
            if RequestInfo.UseReqCode and
              (Floor(pCurrent.LastTime) > Floor(iReqRefDate)) then
            begin
              Dec(FReceiveCount);
              Break;
            end;
            }
            if pCurrent.LastTime < aPrevLineDateTime then
            begin
              {
              gLog.Add(lkError, ClassName, PROC_TITLE,
                Format('%s data sequence is not valid '+#13+'%s',
                  [FFilePath, stLine]));
              }
              Exit;
            end;
            //
            pCurrent.Open := StrToFloat(aTokens[2]);
            pCurrent.High := StrToFloat(aTokens[3]);
            pCurrent.Low := StrToFloat(aTokens[4]);
            pCurrent.Close := StrToFloat(aTokens[5]);
            //
            if aTokens.Count > 6 then
              pCurrent.Volume := StrToInt(aTokens[6])
            else
              pCurrent.Volume := 0;

            //OI 필드가 없는 DATA 도 있을 수 있슴.
            if aTokens.Count > 7 then
              pCurrent.OpenInt := StrToIntDef(aTokens[7], 0);
            //
            aPrevLineDateTime := pCurrent.LastTime;


          except
            if Assigned(FOnLog) then
              FOnLog(Format('file:%s, parsing error :%s', [aXTerms.FileName, stLine]));
          end;

          Inc(iReadCount);
          //Application.ProcessMessages;
        end;

      finally
        aXTerms.FReadCount := iReadCount;
        CloseFile(F);
        aFiles.Free;
        aTokens.Free;
      end;
    end;
    //


    //aRequest.ReArrange;
    //aRequest.RequestComplete;
    //
    if Assigned(aXTerms.FOnLog) then
      aXTerms.FOnLog(Format('load success file:%s, time: %s count:%d', [aXTerms.FileName,
        FormatDateTime('hh:nn:ss', Now - aXTerms.FProcessStartTime), aXTerms.Count]));
    {
    gLog.Add(lkDebug, ClassName, PROC_TITLE, );
    }
  //end;

end;

{ TSFileXTerms }


constructor TSFileXTerms.Create;
begin
  FLongValue := -1;
end;

function TSFileXTerms.GetCount: Integer;
begin
  Result := Length(FReadItems);
end;

function TSFileXTerms.GetItems(i: Integer): TTermRec;
begin
  if (i >= 0) and (i < Count) then
    Result := FReadItems[i];
end;

function TSFileXTerms.Load: Boolean;
begin
  Result := False;
  //
  if not FileExists(FFileName) then
  begin
    Exit;
    //
  end;
  //
  FThreadHandle := BeginThread(nil, 0{1024}, LoadFileThreadFunc, Self{paramter}, 0{createflag}, FThreadID);
  //
  if FThreadHandle = 0 then
  begin
    //ShowMessage('Invalid Thread Handle');
  end else
    Result := True;
end;

procedure TSFileXTerms.SetReadCapacity(const iNewSize: LongWord);
const
  SIZE_DELTA = 1000;
begin
  if iNewSize > FReadCapacity then
  begin
    SetLength(FReadItems, iNewSize + SIZE_DELTA{FReceiveCapacity+SIZE_DELTA});
    //Inc(FReceiveCapacity, SIZE_DELTA);
    FReadCapacity := iNewSize + SIZE_DELTA;
  end;
end;

end.
