unit SMS_StepGrid;

interface

uses
  SysUtils, Controls, Dialogs, Messages, Grids, Windows, Graphics, Classes, Math, Forms, Clipbrd,
  SMS_Columns, MSXML2_TLB, SMS_XMLs2, SMS_DStepGridColors, SMS_Graphics, SMS_DStepGrid;

type

  TStepItem = class(TCollectionItem)
  public
    StepName : String;
    Data : TObject;
  end;
  //

  TStepRowItem = class(TCollectionItem)
  public
    Data : TObject;
  end;

  TStepGridItem = class(TCollectionItem)
  private
    //FStepItems : TCollection;
    FStepRowItems : TCollection;
  public
    Data : TObject;
    //
    Left,Top,Bottom,Right : Integer;
    //
    constructor Create(aColl: TCollection); override;
    destructor Destroy;



    function AddStepRowItem : TStepRowItem;



  end;

  TStepGridOwnerDataEvent = procedure(StepGrid: TObject; ACol, ARow : Integer;
    aStepGrid: TStepGridItem; aStep: TStepItem; aColumn : TSColumnItem;
    aRowItem: TStepRowItem; out stValue: Variant; var aRect: TRect) of object;
//

  TStepGridSelectCellEvent = procedure(Grid: TStringGrid; aRowItem: TStepRowItem) of object;


  TStepGrid = class
  private
    FGrid : TStringGrid;
    FColumns : TColumns;

    FStepGridItems :  TCollection;

    FStepItems : TCollection;
    //FStepRowItems : TCollection;

    FStepDistributed : Boolean;


    FFixedColor: TColor;
    FFixedColorV : TColor;
    FSelectedColor: TColor;
    FSelectedFontColor: TColor;
    FBackColor: TColor;
    FBackFontColor: TColor;
    FNegativeFontColor: TColor;
    FPositiveBackColor: TColor;
    FPositiveFontColor: TColor;
    FNegativeBackColor: TColor;
    FOnOwnerData: TStepGridOwnerDataEvent;

    //
    FFixedRows : Integer;
    FFixedCols: Integer;
    FOnSelectCell: TStepGridSelectCellEvent;
    //FEvenStepBackColor: TColor;

    FFloor : Integer;


    procedure StepGridDrawCell(Sender: TObject; ACol,
        ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StepGridMatrixSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);

    procedure SetFixedCols(const Value: Integer);
    procedure SetFixedColor(const Value: TColor);
    procedure SetSelctedColor(const Value: TColor);
    procedure SetSelectedFontColor(const Value: TColor);
    procedure SetBackColor(const Value: TColor);
    procedure SetBackFontColor(const Value: TColor);
    procedure SetNegativeBackColor(const Value: TColor);
    procedure SetNegativeFontColor(const Value: TColor);
    procedure SetPositiveBackColor(const Value: TColor);
    procedure SetPositiveFontColor(const Value: TColor);
    procedure SetOnOwnerData(const Value: TStepGridOwnerDataEvent);
    procedure SetEvenStepBackColor(const Value: TColor);
    procedure SetIsStepDistributed(const Value: Boolean);
    function GetStepGrids(i: Integer): TStepGridItem;
    function GetStepGridCount: Integer;
    function GetStepCount: Integer;
    procedure SetFixedRows(const Value: Integer);
    function GetRowHeight: Integer;
    procedure SetRowHeight(const Value: Integer);
  public

    constructor Create(aGrid: TStringGrid);
    destructor Destroy;

//    function AddRowItem : TStepRowItem;
    function AddStepItem : TStepItem;
    function AddStepGridItem : TStepGridItem;

    function FindStepGridItem(ACol, ARow: Integer): TStepGridItem;
    //
    procedure Refresh;
    procedure Resize;
    procedure Clear;
    //
    procedure GetPersistence(aElement: IXMLDOMElement);
    procedure SetPersistence(aElement: IXMLDOMElement);
    //
    function ConfigColors(aOwner : TForm): Boolean;
    function ConfigFont(aOwner: TForm): Boolean;
    function ConfigGrid(aOwner: TForm): Boolean;
    //
    function GetSelectedRowItem: TStepRowItem;
    //
    procedure CopyClipboard;
    procedure CopyAllClipboard;


    property Columns : TColumns read FColumns;
    property FixedCols : Integer read FFixedCols write SetFixedCols;
    property FixedRows : Integer read FFixedRows write SetFixedRows;

    property FixedColor : TColor read FFixedColor write SetFixedColor;
    property SelectedColor : TColor read FSelectedColor write SetSelctedColor;
    property SelectedFontColor : TColor read FSelectedFontColor write SetSelectedFontColor;

    property PositiveFontColor : TColor read FPositiveFontColor write SetPositiveFontColor;
    property PositiveBackColor : TColor read FPositiveBackColor write SetPositiveBackColor;
    property NegativeFontColor : TColor read FNegativeFontColor write SetNegativeFontColor;
    property NegativeBackColor : TColor read FNegativeBackColor write SetNegativeBackColor;
    property BackColor : TColor read FBackColor write SetBackColor;
    //property EvenStepBackColor : TColor read FEvenStepBackColor write SetEvenStepBackColor;
    property BackFontColor : TColor read FBackFontColor write SetBackFontColor;

    property StepDistributed : Boolean read FStepDistributed write SetIsStepDistributed;


    //
    property OnOwnerData : TStepGridOwnerDataEvent read FOnOwnerData write SetOnOwnerData;
    property OnSelectCell: TStepGridSelectCellEvent read FOnSelectCell write FOnSelectCell;

    property StepCount : Integer read GetStepCount;

    property StepGrids[i:Integer]: TStepGridItem read GetStepGrids;
    property StepGridCount : Integer read GetStepGridCount;

    property Floor : Integer read FFloor write FFloor;
    property RowHeight : Integer read GetRowHeight write SetRowHeight;

  end;

implementation

{ TStepGrid }

constructor TStepGrid.Create(aGrid: TStringGrid);
begin
  FStepDistributed := True;
  FFloor := 1;

  FGrid := aGrid;
  FGrid.OnDrawCell := StepGridDrawCell;
  FGrid.OnSelectCell := StepGridMatrixSelectCell;
  FGrid.DefaultDrawing := False;

  FStepGridItems := TCollection.Create(TStepGridItem);
  FColumns := TColumns.Create;
  FStepItems := TCollection.Create(TStepItem);
  //FStepRowItems := TCollection.Create(TStepRowItem);

  //
  FFixedRows := 2;

  FGrid.ColCount := FFixedCols + 1;
  //FGrid.FixedCols := FFixedCols;
  FGrid.FixedCols := 0;
  //
  FGrid.RowCount := FFixedRows + 1;
  //FGrid.FixedRows := FFixedRows;
  //
  FFixedColor := clBtnFace;
  FFixedColorV := clSilver;
  FSelectedColor :=  SELECTED_COLOR2;// seclBlue;
  FSelectedFontColor := clWhite;
  FBackColor := clWhite;
  //FEvenStepBackColor := clLtGray;
  FBackFontColor := clBlack;
  FPositiveFontColor := clGreen;
  FPositiveBackColor := clWhite;
  FNegativeFontColor := clRed;
  FNegativeBackColor := clWhite;

end;


destructor TStepGrid.Destroy;
begin

  FStepItems.Free;
  FStepGridItems.Free;
  //FStepRowItems.Free;
  FColumns.Free;
end;


procedure TStepGrid.StepGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  RIGHT_MARGIN = 2;
var

  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;

  aBrushColor, aFontColor : TColor;

  aColumn : TSColumnItem;
  vValue : Variant;
//  aMergedRect : TMergedRect;
  aRect1, aRect2, aMergeRect, aBoundRect : TRect;

  dValue : Double;

  aStepItem : TStepItem;
  aStepRowItem : TStepRowItem;
  iValue : Integer;
  aStepGridItem : TStepGridItem;
  iP, iCount : Integer;
  iFloor, iMod : Integer;
begin


  with FGrid.Canvas do
  begin
    aBrushColor := Brush.Color;
    aFontColor := Font.Color;

    try
      //
      Font.Name := FGrid.Font.Name;
      Font.Size := FGrid.Font.Size;
      Font.Style := FGrid.Font.Style;
      //

      iCount := FFixedCols + FColumns.ViewList.Count*FStepItems.Count;
      iP := ACol div iCount;

      (*
      if (iP >= 0) and (iP<FStepItems.Count) then
        aStepGridItem := FStepGridItems.Items[iP] as TStepGridItem
      else
        aStepGridItem := nil;
      *)
      aStepGridItem := FindStepGridItem(ACol, ARow);

      //
      if FStepDistributed then  //step들이 분산된 경우
      begin

        iP := (ACol mod iCount)-FixedCols;
        //iP := ((ACol mod iCount)-FixedCols) mod FColumns.ViewList.Count;
        if (iP>= 0) then
          aColumn := TSColumnItem(FColumns.ViewList.Items[iP mod FColumns.ViewList.Count])
        else
          aColumn := nil;
        //
        {
        if (FColumns.ViewList.Count > 0) and (ACol > FFixedCols-1) then
          aColumn := TColumnItem(FColumns.ViewList.Items[
                (ACol - FFixedCols) mod FColumns.ViewList.Count])
        else
          aColumn := nil;
        }
      end else
      begin
        if (FColumns.ViewList.Count > 0) and (ACol > FFixedCols-1) then
          aColumn := TSColumnItem(FColumns.ViewList.Items[
                (ACol - FFixedCols) div FStepItems.Count])
        else
          aColumn := nil;

      end;

      if aColumn <> nil then
        aAlignment := aColumn.Alignment
      else
        aAlignment :=taLeftJustify;
      //

      (*
      if Assigned(FOnOwnerColorStyle) then
      begin
        FOnOwnerColorStyle(Self, ACol, ARow, State, aOwnerBackColor, aOwnerFontColor, aOwnerFontStyle);
        Brush.Color := aOwnerBackColor;
        Font.Color := aOwnerFontColor;
        Font.Style := aOwnerFontStyle;
      end else
      begin
      *)

      //end;
      //
      aStepItem := nil;
      aStepRowItem := nil;
      if Assigned(FOnOwnerData) then
      begin

        if FStepDistributed then
        begin
          if FColumns.ViewList.Count <> 0 then
          begin
            //iValue := (ACol-FFixedCols) div FColumns.ViewList.Count;
            iValue := (ACol mod (FColumns.ViewList.Count*FStepItems.Count + FFixedCols));
            if iValue >= FixedCols then
            begin
              iValue := (iValue - FFixedCols) div FColumns.ViewList.Count;
              if (iValue >= 0) and (iValue < FStepItems.Count) then
              //if (ACol > FFixedCols-1) and (iValue <= FStepItems.Count-1) then
                aStepItem := FStepItems.Items[iValue] as TStepItem;
              //
            end;
          end;
        end else
        begin
          if FStepItems.Count > 0 then
          begin
            iValue := (ACol-FFixedCols) mod FStepItems.Count;
            if (ACol > FFixedCols-1) and (iValue <= FStepItems.Count-1) then
              aStepItem := FStepItems.Items[iValue] as TStepItem;
          end;
          //
        end;
        //
        if aStepGridItem <> nil then
        begin
          iValue := ARow-aStepGridItem.Top-FFixedRows;

          if (iValue>=0) and (iValue < aStepGridItem.FStepRowItems.Count) then
            aStepRowItem := aStepGridItem.FStepRowItems.Items[iValue] as TStepRowItem;
        end;

        aBoundRect := Classes.Rect(ACol, ARow, ACol, ARow);
        vValue := '';
        FOnOwnerData(Self, ACol, ARow, aStepGridItem, aStepItem, aColumn, aStepRowItem, vValue, aBoundRect);
        //
        aRect1 := FGrid.CellRect(aBoundRect.Left ,aBoundRect.Top);
        aRect2 := FGrid.CellRect(Min(FGrid.Left + FGrid.VisibleColCount, aBoundRect.Right), aBoundRect.Bottom);
        Rect.Left := aRect1.Left;
        Rect.Top := aRect1.Top;
        Rect.Right := aRect2.Right;
        Rect.Bottom := aRect2.Bottom;
        //    Rect := aMergeRect;

        //
        // set background color
        if gdFixed in State then
        begin
          Brush.Color := FFixedColor;
          Font.Color := clBlack;
          //if FUseColumnFontSize then
          //  Font.Size := FColumnFontSize;
        end else
        if (gdSelected in State) and (aStepRowItem <> nil) then
        begin
          Brush.Color := FSelectedColor;
          Font.Color := FSelectedFontColor;
        end else
        if (aColumn <> nil) and (not aColumn.UseParentColor) then
        begin
          Brush.Color := aColumn.BackColor;
          Font.Color := aColumn.FontColor;
        end else
        if (ACol < FFixedCols) then
        begin
          Brush.Color := FFixedColor;
          Font.Color := clBlack;
        end else
        begin
          Brush.Color := FBackColor;
          Font.Color := FBackFontColor;
        end;


        if (aStepRowItem = nil) then
        begin
          Brush.Color := FFixedColor;
        end;
        //
        if (aStepItem = nil) then
        begin
          aAlignment := taRightJustify;
          Brush.Color := FFixedColorV;
        end;
        //

        //
        if TVarData(vValue).VType = varInteger then
          stText := IntToStr(vValue)
        else if TVarData(vValue).VType = varDouble then
        begin
          if aColumn <> nil then
            stText := Format('%.*f', [aColumn.Scale, Double(vValue)])
          else
            stText := FloatToStr(vValue);
        end else if TVarData(vValue).VType = varString then
          stText := vValue;

        //determine font color

        if (aColumn <> nil) and {(not(gdSelected in State)) and}
          (TVarData(vValue).VType in [varInteger, varDouble]) and
          (aColumn.ShowColorChange) then
        begin
          if IsZero(vValue) then
          else if vValue > 0 then
          begin
            Font.Color := FPositiveFontColor;
            //Brush.Color := FPositiveBackColor;
          end else
          begin
            Font.Color := FNegativeFontColor;
            //Brush.Color := FNegativeBackColor;
          end;
        end;




        //
        if (aColumn <> nil) and (TVarData(vValue).VType in [varInteger, varDouble]) then
        begin
          if (aColumn.UseGradationEffect) and  (aStepRowItem <> nil) and (vValue >= aColumn.GradationMinValue) then
          begin
            Brush.Color := GetGradationColor(clBlack, clWhite,
              (vValue-aColumn.GradationMinValue) / (aColumn.GradationMaxValue-aColumn.GradationMinValue));
          end else
          if (aColumn.UseMaxColor) and (aColumn.MaxValue <= vValue) then
            Brush.Color := aColumn.MaxColor
          else if (aCOlumn.UseMinColor) and (aColumn.MinValue >= vValue) then
            Brush.Color := aColumn.MinColor;

          //
          if aColumn.UseThousandComma then
          begin
            dValue := vValue * 1.0;
            stText := Format('%.*n', [aColumn.Scale, dValue]);
          end;

        end;
        //
        if (aStepItem <> nil) and (ARow = 0) then
        begin
          //처리 merge
        end;

      end;


      {
      if (aColumn <> nil) and (ARow = FOwnerColumnRow) then
      begin
        stText := aColumn.Title;
      end;
      }

      (*
      if IsMergedCell(ACol, ARow, aMergedRect) then
      begin
        //if Length(stText) = 0 then Exit;
        //
        Brush.Color := FFixedColor;
        //
        if (aMergedRect.Rect.Left >= FGrid.LeftCol + FGrid.VisibleColCount) or
          (aMergedRect.Rect.Top >= FGrid.TopRow + FGrid.VisibleRowCount) then
        begin
          FillRect(Rect);
          Exit;
        end;

//        if (aMergedRect.Left >= FGrid.FixedCols) and
//        if (aMergedRect.Top >= FGrid.FixedRows) and
        if (aMergedRect.Rect.Right >= FGrid.LeftCol + FGrid.VisibleColCount) then
          aMergedRect.Rect.Right := FGrid.LeftCol + FGrid.VisibleColCount;

        if (aMergedRect.Rect.Left > aMergedRect.Rect.Right) then Exit;
        if (aMergedRect.Rect.Top > aMergedRect.Rect.Bottom) then Exit;

        aRECT1:= FGrid.CellRect(Max(FGrid.LeftCol, aMergedRect.Rect.Left) ,aMergedRect.Rect.Top);
        aRECT2:= FGrid.CellRect(aMergedRect.Rect.Right, aMergedRect.Rect.Bottom);

        aRect1.Right := aRect2.Right;
        aRect1.Bottom := aRect2.Bottom;

        stText := aMergedRect.Value;


        FillRect(aRect1);
        //RectAngle(lRECT1);
        if aRect1.Bottom - aRect1.TOP<=1 then Exit;

        iX := aRect1.Left+(aRect1.Right-aRect1.Left-TextWidth(stText)) div 2;
        iY := aRect1.Top +(aRect1.Bottom-aRect1.Top-TextHeight(stText)) div 2;
        //
        Font.Color := clBlack;
        TextRect(aRect1, iX, iY, stText);
      end else
      begin

        if FConsolidateRow > 1 then
        begin
          if (ARow+1-FGrid.FixedCols) mod FConsolidateRow <> 0 then
            Rect.Bottom := Rect.Bottom + FGrid.GridLineWidth;
        end;
        *)

      //-- background
      (*
      if (aStepItem <> nil) and (ARow = 0) and (aColumn <> nil) then
      begin
        if FStepDistributed then
        begin
          //처리 merge
          if FColumns.ViewList.IndexOf(aColumn) = 0 then
          begin
            aRect1 := FGrid.CellRect(ACol ,ARow);
            aRect2 := FGrid.CellRect(ACol+FColumns.ViewList.Count-1, ARow);
            aMergeRect.Left := aRect1.Left;
            aMergeRect.Top := aRect1.Top;
            aMergeRect.Right := aRect2.Right;
            aMergeRect.Bottom := aRect2.Bottom;
            Rect := aMergeRect;
            aAlignment := taCenter;
          end;
        end else
        begin
          if (aStepItem <> nil) and (aStepItem.Index = 0) then
          begin
            aRect1 := FGrid.CellRect(ACol ,ARow);
            aRect2 := FGrid.CellRect(ACol+FStepItems.Count-1, ARow);
            aMergeRect.Left := aRect1.Left;
            aMergeRect.Top := aRect1.Top;
            aMergeRect.Right := aRect2.Right;
            aMergeRect.Bottom := aRect2.Bottom;
            Rect := aMergeRect;
            aAlignment := taCenter;
          end;

        end;

      end else*)
      FillRect(Rect);


      //-- text
      //if stText = '' then Exit;
      //-- calc position
      aSize := TextExtent(stText);
      iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
      iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      //-- put text
      case aAlignment of
        taLeftJustify :  iX := Rect.Left + 2;
        taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
        taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx - RIGHT_MARGIN;
      end;
      (*
      if (FStepDistributed and (aStepItem <> nil) and (ARow = 0) and (aColumn <> nil) and (FColumns.ViewList.IndexOf(aColumn)<>0)) or
         (not FStepDistributed and (ARow = 0) and (aStepItem.Index <> 0)) then
        //
      else*)
        TextRect(Rect, iX, iY, stText);
      //
      Pen.Color := clBlack;

      if FStepDistributed then
      begin
        iValue := FColumns.ViewList.IndexOf(aColumn);
        //
        if (iValue = FColumns.ViewList.Count-1) or (ACol < FFixedCols) then
        begin
          Pen.Color := clBlack;
          MoveTo(Rect.Right, Rect.Top);
          LineTo(Rect.Right, Rect.Bottom+1);
        end;
      end else
      begin
        //
        if ((aStepItem <> nil) and (aStepItem.Index  = FStepItems.Count-1)) or (ACol < FFixedCols) then
        begin
          Pen.Color := clBlack;
          MoveTo(Rect.Right, Rect.Top);
          LineTo(Rect.Right, Rect.Bottom+1);
        end;

      end;
      if (aStepGridItem <> nil) and (aStepGridItem.Top = ARow) then
      begin
        MoveTo(Rect.Left, Rect.Top-1);
        LineTo(Rect.Right, Rect.Top-1);
      end;
      //
      //
    finally
      Brush.Color := aBrushColor;
      Font.Color := aFontColor;
    end;
  end;

end;


procedure TStepGrid.SetFixedCols(const Value: Integer);
var
  bChange : Boolean;
begin
  bChange := FFixedCols <> Value;

  FFixedCols := Value;

  if bChange then
    Resize;

end;

procedure TStepGrid.SetFixedColor(const Value: TColor);
begin
  FFixedColor := Value;
end;

procedure TStepGrid.SetSelctedColor(const Value: TColor);
begin
  FSelectedColor := Value;
end;

procedure TStepGrid.SetSelectedFontColor(const Value: TColor);
begin
  FSelectedFontColor := Value;
end;

procedure TStepGrid.SetBackColor(const Value: TColor);
begin
  FBackColor := Value;
end;

procedure TStepGrid.SetBackFontColor(const Value: TColor);
begin
  FBackFontColor := Value;
end;

procedure TStepGrid.SetNegativeBackColor(const Value: TColor);
begin
  FNegativeBackColor := Value;
end;

procedure TStepGrid.SetNegativeFontColor(const Value: TColor);
begin
  FNegativeFontColor := Value;
end;

procedure TStepGrid.SetPositiveBackColor(const Value: TColor);
begin
  FPositiveBackColor := Value;
end;

procedure TStepGrid.SetPositiveFontColor(const Value: TColor);
begin
  FPositiveFontColor := Value;
end;

procedure TStepGrid.SetOnOwnerData(const Value: TStepGridOwnerDataEvent);
begin
  FOnOwnerData := Value;
end;

{
function TStepGrid.AddRowItem: TStepRowItem;
begin
  Result := FStepRowItems.Add as TStepRowItem;
end;
}
function TStepGrid.AddStepItem: TStepItem;
begin
  Result := FStepItems.Add as TStepItem;
end;

procedure TStepGrid.Resize;
const
  DEFAULT_COLWIDTH = 40;
var
  aStepGridItem : TStepGridItem;
  i, iCount, iP : Integer;
  aColumn : TSColumnItem;
  iFloor, iMod, iFloorCount : Integer;
begin
  //
  if FStepGridItems.Count > 0 then
  begin
    aStepGridItem := FStepGridItems.Items[0] as TStepGridItem;
    FGrid.RowCount := Max(FFixedRows+1, (FFixedRows+aStepGridItem.FStepRowItems.Count)*FFloor);
  end;
  //
  iFloor := FStepGridItems.Count div FFloor;
  iMod := FStepGridItems.Count mod FFloor;
  if iMod > 0 then
    Inc(iFloor);
  //
  FGrid.ColCount := Max(FFixedCols+1, iFloor*(FFixedCols + FStepItems.Count*FColumns.ViewList.Count));
  //

  //
  iFloorCount := 0;
  for i := 0 to FStepGridItems.Count-1 do
  begin
    aStepGridItem := FStepGridItems.Items[i] as TStepGridItem;
    //
    aStepGridItem.Left := (i mod iFloor)*( FFixedCols + FStepItems.Count*FColumns.ViewList.Count);
    aStepGridItem.Right := aStepGridItem.Left + ( FFixedCols + FStepItems.Count*FColumns.ViewList.Count)-1;
    aStepGridItem.Top := (iFloorCount) * (aStepGridItem.FStepRowItems.Count+ FFixedRows);
    aStepGridItem.Bottom := aStepGridItem.Top + (aStepGridItem.FStepRowItems.Count-1+ FFixedRows);
    //
    if (i+1) mod iFloor = 0 then
    begin
      Inc(iFloorCount);
    end;

  end;

  //FGrid.FixedCols := FFixedCols;
  FGrid.FixedCols := 0;
  FGrid.FixedRows := 0;//FFixedRows;
  //
  if FStepDistributed then
  begin
    for i := 0 to FGrid.ColCount-1 do
    begin
      iCount := FFixedCols + FColumns.ViewList.Count*FStepItems.Count;
      iP := (i mod iCount)-FixedCols;
      //iP := ((ACol mod iCount)-FixedCols) mod FColumns.ViewList.Count;
      if (iP>= 0) then
        aColumn := TSColumnItem(FColumns.ViewList.Items[iP mod FColumns.ViewList.Count])
      else
        aColumn := nil;

      if aColumn = nil then
        FGrid.ColWidths[i] := DEFAULT_COLWIDTH
      else
        FGrid.ColWidths[i] := aColumn.Width;
    end;
  end;


  FGrid.Refresh;

end;

procedure TStepGrid.Clear;
var
  i : Integer;
  aStepGridItem : TStepGridItem;
begin
  FStepItems.Clear;
  FStepGridItems.Clear;
//  FStepRowItems.Clear;
  for i := 0 to FStepGridItems.Count-1 do
  begin
    aStepGridItem := FStepGridItems.Items[i] as TStepGridItem;
    aStepGridItem.FStepRowItems.Clear;
  end;
end;

procedure TStepGrid.GetPersistence(aElement: IXMLDOMElement);
begin
  //
  aElement.setAttribute('fixed_color', FFixedColor);
  aElement.setAttribute('selected_color', FSelectedColor);
  aElement.setAttribute('selected_fontcolor', FSelectedFontColor);
  aElement.setAttribute('pos_backcolor', FPositiveBackColor);
  aElement.setAttribute('pos_fontcolor', FPositiveFontColor);
  aElement.setAttribute('neg_backcolor', FNegativeBackColor);
  aElement.setAttribute('neg_fontcolor', FNegativeFontColor);

end;

procedure TStepGrid.SetPersistence(aElement: IXMLDOMElement);
var
  aColor : string;
begin


  
  GetAttribute(aElement, 'fixed_color', FFixedColor);
  GetAttribute(aElement, 'selected_color', FSelectedColor);
  GetAttribute(aElement, 'selected_fontcolor', FSelectedFontColor);
  GetAttribute(aElement, 'pos_backcolor', FPositiveBackColor);
  GetAttribute(aElement, 'pos_fontcolor', FPositiveFontColor);
  GetAttribute(aElement, 'neg_backcolor', FNegativeBackColor);
  GetAttribute(aElement, 'neg_fontcolor', FNegativeFontColor);

end;

function TStepGrid.ConfigColors(aOwner: TForm): Boolean;
var
  aDlg : TStepGridColorDialog;
begin
  //
  //
  aDlg := TStepGridColorDialog.Create(aOwner);

  try
    aDlg.ShapeFixed.Brush.Color := FFixedColor;
    aDlg.ShapeSelectedColor.Brush.Color := FSelectedColor;
    aDlg.ShapeSelectedFont.Brush.Color := FSelectedFontColor;
    aDlg.ShapePosBack.Brush.Color := FPositiveBackColor;
    aDlg.ShapePosFont.Brush.Color := FPositiveFontColor;
    aDlg.ShapeNegBack.Brush.Color := FNegativeBackColor;
    aDlg.ShapeNegFont.Brush.Color := FNegativeFontColor;
    Result := aDlg.ShowModal = mrOk;
    if Result then
    begin

      FFixedColor := aDlg.ShapeFixed.Brush.Color;
      FSelectedColor := aDlg.ShapeSelectedColor.Brush.Color;
      FSelectedFontColor := aDlg.ShapeSelectedFont.Brush.Color;
      FPositiveFontColor := aDlg.ShapePosFont.Brush.Color;
      FPositiveBackColor := aDlg.ShapePosBack.Brush.Color;
      FNegativeFontColor := aDlg.ShapeNegFont.Brush.Color;
      FNegativeBackColor := aDlg.ShapeNegBack.Brush.Color;
      //
      FGrid.Refresh;
    end;

  finally
    aDlg.Free;
  end;
end;

function TStepGrid.ConfigFont(aOwner: TForm): Boolean;
var
  aDlg : TFontDialog;
  aSize : TSize;
  iSize : Integer;
  i : Integer;
begin
  //
  aDlg := TFontDialog.Create(aOwner);

  try
    aDlg.Font := FGrid.Font;

    Result := aDlg.Execute;
    if Result then
    begin
      FGrid.Font.Assign(aDlg.Font);
      FGrid.Canvas.Font.Assign(aDlg.Font);
      //
      aSize := FGrid.Canvas.TextExtent('8');
      FGrid.DefaultRowHeight := aSize.cy + 2;
      //
      (*
      if FUseColumnFontSize then
      begin
        iSize := FGrid.Canvas.Font.Size;
        try
          FGrid.Canvas.Font.Size := FColumnFontSize;
          aSize := FGrid.Canvas.TextExtent('8');
          for i := 0 to FGrid.FixedRows-1 do
            FGrid.RowHeights[i] := aSize.cy + 2;
        finally
          FGrid.Canvas.Font.Size := iSize;
        end;
      end;
      *)

    end;

  finally
    aDlg.Free;
  end;
end;

procedure TStepGrid.SetEvenStepBackColor(const Value: TColor);
begin
//  FEvenStepBackColor := Value;
end;

procedure TStepGrid.Refresh;
begin
  FGrid.Refresh;
end;

function TStepGrid.GetSelectedRowItem: TStepRowItem;
var
  aStepGridItem : TStepGridItem;
  iValue : Integer;
begin
  Result := nil;
  //
  if (FGrid.Row < 0) then Exit;
  //
  aStepGridItem := FindStepGridItem(FGrid.Col, FGrid.Row);
  //
  if aStepGridItem <> nil then
  begin
    if aStepGridItem <> nil then
    begin
      iValue := FGrid.Row-aStepGridItem.Top-FFixedRows;

      if (iValue>=0) and (iValue < aStepGridItem.FStepRowItems.Count) then
        Result := aStepGridItem.FStepRowItems.Items[iValue] as TStepRowItem;
    end;
  end;

end;

const
  CLIP_MAXSIZE = 100000;
  CLIP_COLUMN = #09;
  CLIP_ROW = #$A;
//  CLIP_ROW = #$D#$A;

procedure TStepGrid.CopyClipboard;
var
  j, i : Integer;
  stClip : String;
  szBuf : array[0..CLIP_MAXSIZE+5] of Char;
  aStepRowItem : TStepRowItem;
  aStepItem : TStepItem;
  aColumnItem : TSColumnItem;
  vValue : Variant;
  stValue : String;
begin
  //
  stClip := '';
  //

  (*
  for i := FFixedRows to FGrid.RowCount-1 do
  begin
    for j := 0 to FGrid.ColCount-1 do

    begin
      aStepRowItem := FStepRowItems.Items[i-FFixedRows] as TStepRowItem;
      //
      if j < FFixedCols then
        aColumnItem := nil
      else
        aColumnItem := TColumnItem(FColumns.ViewList.Items[(j-FFixedCols) mod FColumns.ViewList.Count]);
      //
      if j < FFixedCols then
        aStepItem := nil
      else
        aStepItem := FStepItems.Items[(j-FFixedCols) div FColumns.ViewList.Count] as TStepItem;


      if Assigned(FOnOwnerData) then
        FOnOwnerData(Self, j, i, aStepItem, aColumnItem, aStepRowItem, vValue);
      //

      if TVarData(vValue).VType = varInteger then
        stValue := IntToStr(vValue)
      else if TVarData(vValue).VType = varDouble then
      begin
        if aColumnItem <> nil then
          stValue := Format('%.*f', [aColumnItem.Scale, Double(vValue)])
        else
          stValue := FloatToStr(vValue);
      end else if TVarData(vValue).VType = varString then
        stValue := vValue;



      stClip := stClip + stValue;
      if j <> FGrid.ColCount-1 then
        stClip := stClip + ' ' + CLIP_COLUMN;



    end;


    stClip := stClip + CLIP_ROW;

  end;

  //
  if Length(stClip) = 0 then Exit;
  //
  if Length(stClip) > CLIP_MAXSIZE then
    stClip := Copy(stClip, 1, CLIP_MAXSIZE);
  //

  StrPCopy(szBuf, stClip);
  ClipBoard.SetTextBuf(szBuf);

  ShowMessage('send to clipboard');
  *)
end;


procedure TStepGrid.StepGridMatrixSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  aStepRowItem : TStepRowItem;
  aStepGridItem : TStepGridItem;
  iValue : Integer;
begin
  //

  if Assigned(FOnSelectCell) then
  begin
    //
    aStepGridItem := FindStepGridItem(ACol, ARow);

    if aStepGridItem <> nil then
    begin
      iValue := ARow-aStepGridItem.Top-FFixedRows;

      if (iValue>=0) and (iValue < aStepGridItem.FStepRowItems.Count) then
        aStepRowItem := aStepGridItem.FStepRowItems.Items[iValue] as TStepRowItem;
    end;

    FOnSelectCell(FGrid, aStepRowItem);

  end;

end;

procedure TStepGrid.SetIsStepDistributed(const Value: Boolean);
begin
  FStepDistributed := Value;
  Refresh;
end;

function TStepGrid.ConfigGrid(aOwner: TForm): Boolean;
var
  aDialog : TStepGridConfig;
begin
  aDialog := TStepGridConfig.Create(aOwner);
  //
  aDialog.FixedCols := FixedCols;
  if aDialog.Open then
  begin
    FixedCols := aDialog.FixedCols;

  end;


end;

function TStepGrid.AddStepGridItem: TStepGridItem;
begin
  Result := FStepGridItems.Add as TStepGridItem;
end;

function TStepGrid.GetStepGrids(i: Integer): TStepGridItem;
begin
  Result := nil;
  //
  if (i>=0) and (i<FStepGridItems.Count) then
    Result := FStepGridItems.Items[i] as TStepGridItem;
end;

function TStepGrid.GetStepGridCount: Integer;
begin
  Result := FStepGridItems.Count;
end;

function TStepGrid.GetStepCount: Integer;
begin
  Result := FStepItems.Count;
end;

procedure TStepGrid.SetFixedRows(const Value: Integer);
var
  bChange : Boolean;
begin
  bChange := FFixedRows = Value;
  //

  FFixedRows := Value;
  //
  if bChange then
    Resize;
end;

function TStepGrid.FindStepGridItem(ACol, ARow: Integer): TStepGridItem;
var
  i : Integer;
  aItem : TStepGridItem;
begin

  Result := nil;
  //
  for i := 0 to FStepGridItems.Count-1 do
  begin
    aItem := FStepGridItems.Items[i] as TStepGridItem;
    //
    if (aItem.Left <= ACol) and (ACol <= aItem.Right) and
       (aItem.Top <= ARow) and (ARow <= aItem.Bottom) then
    begin
      Result := aItem;
      Break;
    end;
  end;

end;

function TStepGrid.GetRowHeight: Integer;
begin
  Result := FGrid.DefaultRowHeight;
end;

procedure TStepGrid.SetRowHeight(const Value: Integer);
begin
  FGrid.DefaultRowHeight := Value;
end;

procedure TStepGrid.CopyAllClipboard;
var
  j, i : Integer;
  stClip : String;
  szBuf : array[0..CLIP_MAXSIZE+5] of Char;
  aStepRowItem : TStepRowItem;
  aStepItem : TStepItem;
  aColumnItem : TSColumnItem;
  vValue : Variant;
  stValue : String;
  //
  iCount, iP : Integer;
  aStepGridItem : TStepGridItem;
  aColumn : TSColumnItem;
  iValue : Integer;
  aBoundRect : TRect;
begin
  //
  stClip := '';
  //


  for i := 0 to FGrid.RowCount-1 do
  begin
    for j := 0 to FGrid.ColCount-1 do
    begin
      iCount := FFixedCols + FColumns.ViewList.Count*FStepItems.Count;
      iP := j div iCount;

      aStepGridItem := FindStepGridItem(j, i);

      //
      if FStepDistributed then  //step들이 분산된 경우
      begin

        iP := (j mod iCount)-FixedCols;
        //iP := ((ACol mod iCount)-FixedCols) mod FColumns.ViewList.Count;
        if (iP>= 0) then
          aColumn := TSColumnItem(FColumns.ViewList.Items[iP mod FColumns.ViewList.Count])
        else
          aColumn := nil;
        //
        {
        if (FColumns.ViewList.Count > 0) and (ACol > FFixedCols-1) then
          aColumn := TColumnItem(FColumns.ViewList.Items[
                (ACol - FFixedCols) mod FColumns.ViewList.Count])
        else
          aColumn := nil;
        }
      end else
      begin
        if (FColumns.ViewList.Count > 0) and (j > FFixedCols-1) then
          aColumn := TSColumnItem(FColumns.ViewList.Items[
                (j - FFixedCols) div FStepItems.Count])
        else
          aColumn := nil;

      end;


      //end;
      //
      aStepItem := nil;
      aStepRowItem := nil;
      if Assigned(FOnOwnerData) then
      begin

        if FStepDistributed then
        begin
          if FColumns.ViewList.Count <> 0 then
          begin
            //iValue := (ACol-FFixedCols) div FColumns.ViewList.Count;
            iValue := (j mod (FColumns.ViewList.Count*FStepItems.Count + FFixedCols));
            if iValue >= FixedCols then
            begin
              iValue := (iValue - FFixedCols) div FColumns.ViewList.Count;
              if (iValue >= 0) and (iValue < FStepItems.Count) then
              //if (ACol > FFixedCols-1) and (iValue <= FStepItems.Count-1) then
                aStepItem := FStepItems.Items[iValue] as TStepItem;
              //
            end;
          end;
        end else
        begin
          if FStepItems.Count > 0 then
          begin
            iValue := (j-FFixedCols) mod FStepItems.Count;
            if (j > FFixedCols-1) and (iValue <= FStepItems.Count-1) then
              aStepItem := FStepItems.Items[iValue] as TStepItem;
          end;
          //
        end;
        //
        if aStepGridItem <> nil then
        begin
          iValue := i-aStepGridItem.Top-FFixedRows;

          if (iValue>=0) and (iValue < aStepGridItem.FStepRowItems.Count) then
            aStepRowItem := aStepGridItem.FStepRowItems.Items[iValue] as TStepRowItem;
        end;

        aBoundRect := Classes.Rect(j, i, j, i);
        stValue := '';
        vValue := '';
        FOnOwnerData(Self, j, i, aStepGridItem, aStepItem, aColumn, aStepRowItem, vValue, aBoundRect);
        //

        //
        if TVarData(vValue).VType = varInteger then
          stValue := IntToStr(vValue)
        else if TVarData(vValue).VType = varDouble then
        begin
          if aColumn <> nil then
            stValue := Format('%.*f', [aColumn.Scale, Double(vValue)])
          else
            stValue := FloatToStr(vValue);
        end else if TVarData(vValue).VType = varString then
          stValue := vValue;
        //

        stClip := stClip + stValue;
        if j <> FGrid.ColCount-1 then
          stClip := stClip + ' ' + CLIP_COLUMN;
      end;

    end;


    stClip := stClip + CLIP_ROW;

  end;

  //
  if Length(stClip) = 0 then Exit;
  //
  if Length(stClip) > CLIP_MAXSIZE then
    stClip := Copy(stClip, 1, CLIP_MAXSIZE);
  //

  StrPCopy(szBuf, stClip);
  ClipBoard.SetTextBuf(szBuf);

  ShowMessage('send to clipboard');


end;

{ TStepGridItem }

function TStepGridItem.AddStepRowItem: TStepRowItem;
begin
  Result := FStepRowItems.Add as TStepRowItem;
end;

constructor TStepGridItem.Create(aColl: TCollection);
begin
  inherited Create(aColl);


  FStepRowItems := TCollection.Create(TStepRowItem);
end;

destructor TStepGridItem.Destroy;
begin

  FStepRowItems.Free;
end;

end.



