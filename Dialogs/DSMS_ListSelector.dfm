object ListSelectorDialog: TListSelectorDialog
  Left = 192
  Top = 125
  BorderStyle = bsDialog
  Caption = 'List Selector'
  ClientHeight = 417
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object BtnSelect: TSpeedButton
    Tag = 100
    Left = 294
    Top = 97
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
    Left = 294
    Top = 143
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
    Left = 294
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
    Left = 294
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
  object ButtonTop: TSpeedButton
    Tag = 700
    Left = 628
    Top = 89
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
  object BtnUp: TSpeedButton
    Tag = 700
    Left = 628
    Top = 137
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
    Left = 628
    Top = 184
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
  object ButtonBottom: TSpeedButton
    Tag = 800
    Left = 628
    Top = 243
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
  object Bevel1: TBevel
    Left = 9
    Top = 368
    Width = 635
    Height = 9
    Shape = bsTopLine
  end
  object ListClones: TListView
    Left = 8
    Top = 16
    Width = 273
    Height = 337
    Columns = <
      item
        AutoSize = True
        Caption = 'Title'
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object ListSelecteds: TListView
    Left = 344
    Top = 16
    Width = 281
    Height = 337
    Columns = <
      item
        AutoSize = True
        Caption = 'Title'
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object ButtonOK: TButton
    Left = 405
    Top = 379
    Width = 93
    Height = 29
    Caption = 'Apply'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object ButtonCancel: TButton
    Left = 524
    Top = 379
    Width = 93
    Height = 29
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object CheckApplyAll: TCheckBox
    Left = 208
    Top = 384
    Width = 81
    Height = 17
    Caption = 'Apply All'
    TabOrder = 4
  end
end
