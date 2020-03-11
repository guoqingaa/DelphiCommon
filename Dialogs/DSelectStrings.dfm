object SelectStrings: TSelectStrings
  Left = 192
  Top = 124
  BorderStyle = bsDialog
  Caption = 'SelectStrings'
  ClientHeight = 362
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object LabelTitle: TLabel
    Left = 24
    Top = 16
    Width = 54
    Height = 15
    Caption = 'LabelTitle'
  end
  object Bevel1: TBevel
    Left = 22
    Top = 312
    Width = 249
    Height = 6
  end
  object ListStrings: TListBox
    Left = 32
    Top = 40
    Width = 225
    Height = 257
    ImeName = 'Microsoft Office IME 2007'
    ItemHeight = 15
    TabOrder = 0
  end
  object Button1: TButton
    Left = 96
    Top = 328
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 184
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
