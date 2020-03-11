object TextEditor: TTextEditor
  Left = 192
  Top = 124
  Width = 659
  Height = 397
  Caption = 'Text'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object MemoText: TMemo
    Left = 0
    Top = 0
    Width = 643
    Height = 318
    Align = alClient
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 318
    Width = 643
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object ButtonOK: TButton
      Left = 424
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object Cancel: TButton
      Left = 512
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
