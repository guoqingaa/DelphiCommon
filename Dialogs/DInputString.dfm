object InputStringDialog: TInputStringDialog
  Left = 100
  Top = 98
  BorderStyle = bsDialog
  Caption = 'InputStringDialog'
  ClientHeight = 66
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EditInput: TEdit
    Left = 96
    Top = 25
    Width = 121
    Height = 21
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 0
  end
  object ButtonOK: TButton
    Left = 240
    Top = 24
    Width = 75
    Height = 25
    Caption = 'ButtonOK'
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object Button2: TButton
    Left = 328
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
  end
end
