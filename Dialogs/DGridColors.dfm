object GridColorDialog: TGridColorDialog
  Left = 198
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Grid Colors Properties'
  ClientHeight = 450
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 18
    Top = 265
    Width = 154
    Height = 15
    Caption = 'Positive Background Color : '
  end
  object Label2: TLabel
    Left = 60
    Top = 297
    Width = 112
    Height = 15
    Caption = 'Positive Font Color : '
  end
  object Label3: TLabel
    Left = 13
    Top = 345
    Width = 159
    Height = 15
    Caption = 'Negative Background Color : '
  end
  object Label4: TLabel
    Left = 55
    Top = 377
    Width = 117
    Height = 15
    Caption = 'Negative Font Color : '
  end
  object ShapePosBack: TShape
    Left = 188
    Top = 263
    Width = 120
    Height = 21
  end
  object SpeedButton4: TSpeedButton
    Tag = 4
    Left = 312
    Top = 262
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object ShapePosFont: TShape
    Left = 188
    Top = 295
    Width = 120
    Height = 21
  end
  object SpeedButton1: TSpeedButton
    Tag = 5
    Left = 312
    Top = 294
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object ShapeNegBack: TShape
    Left = 188
    Top = 343
    Width = 120
    Height = 21
  end
  object SpeedButton2: TSpeedButton
    Tag = 6
    Left = 312
    Top = 342
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object ShapeNegFont: TShape
    Left = 188
    Top = 375
    Width = 120
    Height = 21
  end
  object SpeedButton3: TSpeedButton
    Tag = 7
    Left = 312
    Top = 374
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object Label5: TLabel
    Left = 101
    Top = 24
    Width = 71
    Height = 15
    Caption = 'Fixed Color : '
  end
  object ShapeFixed: TShape
    Left = 188
    Top = 22
    Width = 120
    Height = 21
  end
  object SpeedButton5: TSpeedButton
    Tag = 1
    Left = 312
    Top = 21
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object Label6: TLabel
    Left = 82
    Top = 201
    Width = 90
    Height = 15
    Caption = 'Selected Color : '
  end
  object ShapeSelectedColor: TShape
    Left = 188
    Top = 199
    Width = 120
    Height = 21
  end
  object SpeedButton6: TSpeedButton
    Tag = 2
    Left = 312
    Top = 198
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object Label7: TLabel
    Left = 55
    Top = 229
    Width = 117
    Height = 15
    Caption = 'Selected Font Color : '
  end
  object ShapeSelectedFont: TShape
    Left = 188
    Top = 227
    Width = 120
    Height = 21
  end
  object SpeedButton7: TSpeedButton
    Tag = 3
    Left = 312
    Top = 226
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object Label8: TLabel
    Left = 17
    Top = 90
    Width = 155
    Height = 15
    Caption = 'Selected FrameRect Width : '
  end
  object Bevel1: TBevel
    Left = 5
    Top = 407
    Width = 350
    Height = 10
    Shape = bsTopLine
  end
  object ShapeBackColor: TShape
    Left = 188
    Top = 128
    Width = 120
    Height = 21
  end
  object SpeedButton8: TSpeedButton
    Tag = 8
    Left = 312
    Top = 127
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object Label9: TLabel
    Left = 60
    Top = 130
    Width = 110
    Height = 15
    Caption = 'BackGround Color : '
  end
  object Label10: TLabel
    Left = 34
    Top = 162
    Width = 137
    Height = 15
    Caption = 'BackGround Font Color : '
  end
  object ShapeBackFontColor: TShape
    Left = 188
    Top = 160
    Width = 120
    Height = 21
  end
  object SpeedButton9: TSpeedButton
    Tag = 9
    Left = 312
    Top = 159
    Width = 23
    Height = 22
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
    OnClick = SpeedColorButtonClick
  end
  object ButtonOK: TButton
    Left = 96
    Top = 418
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object ButtonCancel: TButton
    Left = 176
    Top = 418
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object CheckSelectedFrameRect: TCheckBox
    Left = 192
    Top = 64
    Width = 145
    Height = 17
    Caption = 'Selected Frame Rect'
    TabOrder = 2
  end
  object EditSelectedFrameWidth: TEdit
    Left = 187
    Top = 87
    Width = 121
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 3
    Text = '1'
  end
  object ButtonLoadDefault: TButton
    Left = 260
    Top = 418
    Width = 75
    Height = 25
    Caption = 'LoadDefault'
    TabOrder = 4
    OnClick = ButtonLoadDefaultClick
  end
  object PanelColors: TPanel
    Left = 352
    Top = 16
    Width = 313
    Height = 381
    Caption = 'PanelColors'
    TabOrder = 5
  end
  object ColorDialog1: TColorDialog
    Left = 32
    Top = 21
  end
end
