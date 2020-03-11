object CheckFilterDialog: TCheckFilterDialog
  Left = 192
  Top = 124
  Width = 301
  Height = 355
  Caption = 'CheckFilterDialog'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Button1: TButton
    Left = 24
    Top = 288
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 104
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 184
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object ListSelecteds: TCheckListBox
    Left = 8
    Top = 8
    Width = 268
    Height = 273
    ImeName = 'Microsoft Office IME 2007'
    ItemHeight = 15
    TabOrder = 3
  end
end
