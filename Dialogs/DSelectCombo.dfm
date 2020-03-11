object SelectComboDialog: TSelectComboDialog
  Left = 1584
  Top = 98
  Width = 298
  Height = 152
  Caption = 'SelectComboDialog'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 56
    Top = 24
    Width = 169
    Height = 21
    ImeName = 'Microsoft Office IME 2007'
    ItemHeight = 13
    TabOrder = 0
    Text = 'ComboBox1'
  end
  object Button1: TButton
    Left = 152
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 64
    Top = 72
    Width = 75
    Height = 25
    Caption = 'ButtonOK'
    TabOrder = 2
    OnClick = ButtonOKClick
  end
end
