object StepGridConfig: TStepGridConfig
  Left = 1584
  Top = 98
  Width = 281
  Height = 400
  Caption = 'Format StepGrid'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 57
    Height = 13
    Caption = 'Fixed Cols : '
  end
  object EditFixedCols: TEdit
    Left = 76
    Top = 22
    Width = 121
    Height = 21
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 0
    Text = '1'
  end
  object ButtonOK: TButton
    Left = 88
    Top = 296
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = ButtonOKClick
  end
end
