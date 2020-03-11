object ColumnsConfig: TColumnsConfig
  Left = 292
  Top = 116
  BorderStyle = bsDialog
  Caption = 'Format Columns'
  ClientHeight = 543
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Label14: TLabel
    Left = 19
    Top = 6
    Width = 60
    Height = 15
    Caption = 'UnSelcted '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 272
    Top = 7
    Width = 48
    Height = 15
    Caption = 'Selected'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object BtnSelect: TSpeedButton
    Tag = 100
    Left = 230
    Top = 153
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      16020000424D160200000000000036000000280000000D0000000C0000000100
      180000000000E0010000C40E0000C40E00000000000000000000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000C0C0C0
      C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF
      0000FF0000FF0000C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0FF0000FF0000FF0000FF0000C0C0C0C0C0C000FF0000FF0000
      FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000C0C0
      C000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF0000FF000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000FF000000FF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000C0C0C000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000FF0000FF0000C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000FF0000
      C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF
      0000FF0000C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000}
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    OnClick = BtnSelectClick
  end
  object BtnSelectAll: TSpeedButton
    Tag = 200
    Left = 230
    Top = 199
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      16020000424D160200000000000036000000280000000D0000000C0000000100
      180000000000E0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
      FFFFFFFFFFFFFFFFFF00FFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF0000FF0000FFFFFFFFFFFFFFFFFF00FFFFFFFF0000FF0000FF0000FFFF
      FFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFFFF00FFFFFFFF0000
      FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFF
      FF00FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFF0000FF0000
      FF0000FF0000FF000000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFF
      FFFFFF0000FF0000FF0000FF0000FF000000FFFFFFFF0000FF0000FF0000FF00
      00FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFFFF00FFFFFFFF0000
      FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFFFFFFFFF
      FF00FFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
      FFFFFFFFFFFFFFFFFF00FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
    ParentFont = False
    OnClick = BtnSelectAllClick
  end
  object BtnUnSelect: TSpeedButton
    Tag = 300
    Left = 230
    Top = 246
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      16020000424D160200000000000036000000280000000D0000000C0000000100
      180000000000E0010000C40E0000C40E00000000000000000000C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C0FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0FF0000FF0000FF0000C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0FF0000FF0000FF00
      00FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0FF0000
      FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
      0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FF0000FF0000FF000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000FF000000C0C0C0FF0000FF0000FF0000FF00
      00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000C0C0C0C0C0C0
      FF0000FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C000C0C0C0C0C0C0C0C0C0FF0000FF0000FF0000C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0FF0000FF0000C0C0C0C0
      C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0FF0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000}
    ParentFont = False
    OnClick = BtnUnSelectClick
  end
  object BtnUnSelectAll: TSpeedButton
    Tag = 400
    Left = 230
    Top = 293
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      16020000424D160200000000000036000000280000000D0000000C0000000100
      180000000000E0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF0000FFFFFF00FFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF0000FF0000FFFFFF00FFFFFFFFFFFFFF0000FF0000FF00
      00FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFFFFF00FFFFFFFF0000
      FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFF
      FF00FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFF0000FF0000FF0000
      FF0000FF0000FFFFFF00FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFF
      0000FF0000FF0000FF0000FF0000FFFFFF00FFFFFFFF0000FF0000FF0000FF00
      00FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFFFF00FFFFFFFFFFFF
      FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FFFF
      FF00FFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF0000FF0000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
    ParentFont = False
    OnClick = BtnUnSelectAllClick
  end
  object BtnUp: TSpeedButton
    Tag = 700
    Left = 624
    Top = 190
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      DE000000424DDE0000000000000076000000280000000C0000000D0000000100
      04000000000068000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888CCCC8888
      00008888CCCC888800008888CCCC888800008888CCCC888800008888CCCC8888
      00008888CCCC888800008888CCCC88880000CCCCCCCCCCCC00008CCCCCCCCCC8
      000088CCCCCCCC880000888CCCCCC88800008888CCCC8888000088888CC88888
      0000}
    ParentFont = False
    OnClick = BtnUpClick
  end
  object BtnDown: TSpeedButton
    Tag = 800
    Left = 624
    Top = 237
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      DE000000424DDE0000000000000076000000280000000C0000000D0000000100
      04000000000068000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0088888CC88888
      00008888CCCC88880000888CCCCCC888000088CCCCCCCC8800008CCCCCCCCCC8
      0000CCCCCCCCCCCC00008888CCCC888800008888CCCC888800008888CCCC8888
      00008888CCCC888800008888CCCC888800008888CCCC888800008888CCCC8888
      0000}
    ParentFont = False
    OnClick = BtnDownClick
  end
  object ButtonBackColor: TSpeedButton
    Left = 401
    Top = 471
    Width = 128
    Height = 25
    Caption = 'Background Color'
    Flat = True
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B07A58FFB07A58FFB07A58FFFFFFFF00DD9BD9FFDD9BD9FFDD9BD9FFFFFF
      FF00B177FFFFB177FFFFB177FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B07A58FFB07A58FFB07A58FFFFFFFF00DD9BD9FFDD9BD9FFDD9BD9FFFFFF
      FF00B177FFFFB177FFFFB177FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B07A58FFB07A58FFB07A58FFFFFFFF00DD9BD9FFDD9BD9FFDD9BD9FFFFFF
      FF00B177FFFFB177FFFFB177FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2EBD0FFB2EBD0FFB2EBD0FFFFFFFF006DCC50FF6DCC50FF6DCC50FFFFFF
      FF00EBB060FFEBB060FFEBB060FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2EBD0FFB2EBD0FFB2EBD0FFFFFFFF006DCC50FF6DCC50FF6DCC50FFFFFF
      FF00EBB060FFEBB060FFEBB060FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2EBD0FFB2EBD0FFB2EBD0FFFFFFFF006DCC50FF6DCC50FF6DCC50FFFFFF
      FF00EBB060FFEBB060FFEBB060FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B6FFEFF6B6FFEFF6B6FFEFFFFFFFF0073AAFFFF73AAFFFF73AAFFFFFFFF
      FF0067D5F0FF67D5F0FF67D5F0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B6FFEFF6B6FFEFF6B6FFEFFFFFFFF0073AAFFFF73AAFFFF73AAFFFFFFFF
      FF0067D5F0FF67D5F0FF67D5F0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B6FFEFF6B6FFEFF6B6FFEFFFFFFFF0073AAFFFF73AAFFFF73AAFFFFFFFF
      FF0067D5F0FF67D5F0FF67D5F0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    OnClick = ButtonBackColorClick
  end
  object ButtonTextColor: TSpeedButton
    Left = 533
    Top = 471
    Width = 84
    Height = 25
    Caption = 'Text Color'
    Flat = True
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B07A58FFB07A58FFB07A58FFFFFFFF00DD9BD9FFDD9BD9FFDD9BD9FFFFFF
      FF00B177FFFFB177FFFFB177FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B07A58FFB07A58FFB07A58FFFFFFFF00DD9BD9FFDD9BD9FFDD9BD9FFFFFF
      FF00B177FFFFB177FFFFB177FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B07A58FFB07A58FFB07A58FFFFFFFF00DD9BD9FFDD9BD9FFDD9BD9FFFFFF
      FF00B177FFFFB177FFFFB177FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2EBD0FFB2EBD0FFB2EBD0FFFFFFFF006DCC50FF6DCC50FF6DCC50FFFFFF
      FF00EBB060FFEBB060FFEBB060FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2EBD0FFB2EBD0FFB2EBD0FFFFFFFF006DCC50FF6DCC50FF6DCC50FFFFFF
      FF00EBB060FFEBB060FFEBB060FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2EBD0FFB2EBD0FFB2EBD0FFFFFFFF006DCC50FF6DCC50FF6DCC50FFFFFF
      FF00EBB060FFEBB060FFEBB060FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B6FFEFF6B6FFEFF6B6FFEFFFFFFFF0073AAFFFF73AAFFFF73AAFFFFFFFF
      FF0067D5F0FF67D5F0FF67D5F0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B6FFEFF6B6FFEFF6B6FFEFFFFFFFF0073AAFFFF73AAFFFF73AAFFFFFFFF
      FF0067D5F0FF67D5F0FF67D5F0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006B6FFEFF6B6FFEFF6B6FFEFFFFFFFF0073AAFFFF73AAFFFF73AAFFFFFFFF
      FF0067D5F0FF67D5F0FF67D5F0FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
    OnClick = ButtonTextColorClick
  end
  object Bevel1: TBevel
    Left = 8
    Top = 501
    Width = 657
    Height = 9
    Shape = bsTopLine
  end
  object ButtonTop: TSpeedButton
    Tag = 700
    Left = 624
    Top = 142
    Width = 35
    Height = 35
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      0A020000424D0A0200000000000036000000280000000C0000000D0000000100
      180000000000D4010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF00
      00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFF
      FFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ParentFont = False
    OnClick = ButtonTopClick
  end
  object ButtonBottom: TSpeedButton
    Tag = 800
    Left = 624
    Top = 288
    Width = 35
    Height = 32
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      0A020000424D0A0200000000000036000000280000000C0000000D0000000100
      180000000000D4010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF0000FF0000FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
      FFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
      00FF0000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ParentFont = False
    OnClick = ButtonBottomClick
  end
  object ListFields: TListView
    Tag = 10
    Left = 19
    Top = 30
    Width = 205
    Height = 427
    Columns = <
      item
        Caption = 'Column'
        Width = 91
      end
      item
        Caption = 'Title'
        Width = 91
      end>
    DragMode = dmAutomatic
    GridLines = True
    OwnerDraw = True
    ReadOnly = True
    RowSelect = True
    SmallImages = ImageList1
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = ListFieldsDblClick
    OnDrawItem = ListSelectedDrawItem
  end
  object ListSelected: TListView
    Tag = 20
    Left = 272
    Top = 30
    Width = 345
    Height = 387
    Columns = <
      item
        Caption = 'Column'
        Width = 91
      end
      item
        Caption = 'Title'
        Width = 91
      end
      item
        Alignment = taRightJustify
        Caption = 'Width'
        Width = 44
      end
      item
        Alignment = taRightJustify
        Caption = 'Unit'
        Width = 44
      end
      item
        Alignment = taCenter
        Caption = 'Color'
      end>
    DragMode = dmAutomatic
    GridLines = True
    MultiSelect = True
    OwnerDraw = True
    ReadOnly = True
    ParentShowHint = False
    ShowHint = True
    SmallImages = ImageList1
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = ListSelectedDblClick
    OnDrawItem = ListSelectedDrawItem
    OnMouseDown = ListSelectedMouseDown
    OnSelectItem = ListSelectedSelectItem
  end
  object ButtonOK: TButton
    Left = 173
    Top = 510
    Width = 93
    Height = 29
    Caption = 'Apply'
    Default = True
    TabOrder = 2
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 292
    Top = 510
    Width = 93
    Height = 29
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object ButtonHelp: TButton
    Left = 410
    Top = 510
    Width = 93
    Height = 29
    Cancel = True
    Caption = 'Help'
    TabOrder = 4
  end
  object CheckUseParentColor: TCheckBox
    Left = 280
    Top = 475
    Width = 113
    Height = 17
    Caption = 'Use Parent color'
    TabOrder = 5
    OnClick = CheckUseParentColorClick
  end
  object MemoDesc: TMemo
    Left = 272
    Top = 424
    Width = 345
    Height = 36
    TabOrder = 6
  end
  object ImageList1: TImageList
    Left = 112
    Top = 248
  end
  object ColorDialog1: TColorDialog
    Options = [cdFullOpen]
    Left = 144
    Top = 357
  end
end
