unit SMS_CtrlDrawings;

interface

uses
  Classes, StdCtrls, Controls, Windows, Graphics, Grids, ComCtrls, CommCtrl;


  procedure GridDrawCell(Grid : TStringGrid; ACol, ARow: Integer;
                          Rect: TRect; State: TGridDrawState);
  procedure HeaderDrawSection(Header: THeaderControl; Section: THeaderSection;
    const Rect: TRect; Pressed: Boolean);

  procedure PenStyleComboDrawItem(Control : TWinControl; Index : Integer;
    Rect : TRect; State : TOwnerDrawState);

  procedure DefaultGridDrawCell(Grid : TStringGrid; ACol, ARow: Integer;
                          Rect: TRect; State: TGridDrawState);
  procedure DefaultListViewDrawItem6(ListView: TListView;
    Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);

implementation

uses
  SMS_Graphics;

procedure DefaultListViewDrawItem6(ListView: TListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState; Statusbar : TStatusBar = nil);
var
  i, iX, iY, iLeft : Integer;
  aSize : TSize;
//  aRefreshItem : TRefreshItem;
begin
  Rect.Bottom := Rect.Bottom-1;
  //
  with ListView.Canvas do
  begin
    //-- color
    if (odSelected in State) {or (odFocused in State)} then
    begin
      Brush.Color := SELECTED_COLOR2;
      Font.Color := clBlack;
    end else
    begin
      Font.Color := clBlack;
      if Item.Index mod 2 = 1 then
        Brush.Color := EVEN_COLOR
      else
        Brush.Color := ODD_COLOR;
    end;
    //-- background
    FillRect(Rect);
    //-- icon
    aSize := TextExtent('9');
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    if (Item.ImageIndex >=0) and (ListView.SmallImages <> nil) then
    begin
      // aListView.SmallImages.BkColor := Brush.Color;
      ListView.SmallImages.Draw(ListView.Canvas, Rect.Left+1, Rect.Top,
                              Item.ImageIndex);
    end;
    //-- caption
    if Item.Caption <> '' then
      if ListView.SmallImages = nil then
        TextRect(
            Classes.Rect(0,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + 2, iY, Item.Caption)
      else
        TextRect(
            Classes.Rect(Rect.Left + ListView.SmallImages.Width,
              Rect.Top, ListView_GetColumnWidth(ListView.Handle,0), Rect.Bottom),
            Rect.Left + ListView.SmallImages.Width + 2, iY, Item.Caption);
    //-- subitems
    iLeft := Rect.Left;
    for i:=0 to Item.SubItems.Count-1 do
    begin
      if i+1 >= ListView.Columns.Count then Break;
      iLeft := iLeft + ListView_GetColumnWidth(ListView.Handle,i);

      if Item.SubItems[i] = '' then Continue;
      aSize := TextExtent(Item.SubItems[i]);

      case ListView.Columns[i+1].Alignment of
        taLeftJustify :  iX := iLeft + 2;
        taCenter :       iX := iLeft +
             (ListView_GetColumnWidth(ListView.Handle,i+1)-aSize.cx) div 2;
        taRightJustify : iX := iLeft +
              ListView_GetColumnWidth(ListView.Handle,i+1) - 2 - aSize.cx;
        else iX := iLeft + 2; // redundant coding
      end;
      TextRect(
          Classes.Rect(iLeft, Rect.Top,
             iLeft + ListView_GetColumnWidth(ListView.Handle,i+1), Rect.Bottom),
          iX, iY, Item.SubItems[i]);
    end;
  end;

  // additional service
  if StatusBar <> nil then
  begin
    for i:=0 to StatusBar.Panels.Count-1 do
      if i < ListView.Columns.Count then
        StatusBar.Panels[i].Width := ListView_GetColumnWidth(ListView.Handle,i)
  end;


end;


procedure DefaultGridDrawCell(Grid : TStringGrid; ACol, ARow: Integer;
                          Rect: TRect; State: TGridDrawState);
var
  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;
begin
  with Grid.Canvas do
  begin
    Font.Name := Grid.Font.Name;
    Font.Size := Grid.Font.Size;
    //
    stText := Grid.Cells[ACol, ARow];
    if gdFixed in State then
    begin
      Brush.Color := FIXED_COLOR;
      Font.Color := clBlack;
      aAlignment := taLeftJustify;
    end else
    begin
      if stText = '' then
       Brush.Color := NODATA_COLOR
      else
        Brush.Color := clWhite;
      Font.Color := clBlack;
      aAlignment := taRightJustify;
    end;
    //-- background
    FillRect(Rect);
    //-- text
    if stText = '' then Exit;
    //-- calc position
    aSize := TextExtent(stText);
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
    //-- put text
    case aAlignment of
      taLeftJustify :  iX := Rect.Left + 2;
      taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - 2 - aSize.cx;
    end;
    TextRect(Rect, iX, iY, stText);
  end;
end;

procedure HeaderDrawSection(Header: THeaderControl; Section: THeaderSection;
  const Rect: TRect; Pressed: Boolean);
const
  LEFT_MARGIN = 5;
var
  aBrushColor : TColor;
  aSize : TSize;
  iHeight : Integer;
begin
  //
  with Header.Canvas do
  begin
    aBrushColor := Brush.Color;
    //
    Brush.Color := FIXED_COLOR;
    FillRect(Rect);
    //
    aSize := TextExtent(Section.Text);
    iHeight := Rect.Bottom - Rect.Top;
    //
    TextRect(Rect, Rect.Left + LEFT_MARGIN,
            Rect.Top + (iHeight - aSize.cy) div 2, Section.Text);
    //
    Brush.Color := aBrushColor;
  end;
  //
end;


procedure GridDrawCell(Grid : TStringGrid; ACol, ARow: Integer;
                          Rect: TRect; State: TGridDrawState);
const
  SPACE = 10;

var
  aAlignment : TAlignment;
  iX, iY : Integer;
  aSize : TSize;
  stText : String;
begin
  with Grid.Canvas do
  begin
    Font.Name := Grid.Font.Name;
    Font.Size := Grid.Font.Size;
    //
    stText := Grid.Cells[ACol, ARow];
    if gdFixed in State then
    begin
      Brush.Color := FIXED_COLOR;
      Font.Color := clBlack;
      aAlignment := taLeftJustify;
    end else
    begin
      if stText = '' then
       Brush.Color := NODATA_COLOR
      else
        Brush.Color := clWhite;
      Font.Color := clBlack;
      aAlignment := taRightJustify;
    end;
    //-- background
    FillRect(Rect);
    //-- text
    if stText = '' then Exit;
    //-- calc position
    aSize := TextExtent(stText);
    iY := Rect.Top + (Rect.Bottom - Rect.Top - aSize.cy) div 2;
    iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
    //-- put text
    case aAlignment of
      taLeftJustify :  iX := Rect.Left + SPACE;
      taCenter :       iX := Rect.Left + (Rect.Right-Rect.Left-aSize.cx) div 2;
      taRightJustify : iX := Rect.Left + Rect.Right-Rect.Left - SPACE - aSize.cx;
    end;
    TextRect(Rect, iX, iY, stText);
  end;
end;



procedure PenStyleComboDrawItem(Control : TWinControl; Index : Integer;
  Rect : TRect; State : TOwnerDrawState);
var
  aCombo : TComboBox;
  aPenStyle: TPenStyle;
begin
  aCombo := Control as TComboBox;
  aPenStyle := aCombo.Canvas.Pen.Style;

  with aCombo.Canvas do
  begin
    Brush.Color := clWhite;
    Pen.Mode := pmCopy;

    if odSelected in State then
    begin

      Pen.Color := clBlue;
      Rectangle(Rect);
    end else
      FillRect(Rect);

    Pen.Width := 1;
    Brush.Color := clWhite;
    Pen.Color := clBlack;

    case Index of
      0 : Pen.Style := psSolid;
      1 : Pen.Style := psDash;
      2 : Pen.Style := psDot;
      3 : Pen.Style := psDashDot;
      4 : Pen.Style := psDashDotDot;
    end;

    MoveTo(Rect.Left+3, (Rect.Bottom + Rect.Top) div 2);
    LineTo(Rect.Right-3, (Rect.Bottom + Rect.Top) div 2);

  end;

  aCombo.Canvas.Pen.Style := aPenStyle;
end;


end.
