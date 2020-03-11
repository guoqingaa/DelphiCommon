object TextFileEditor: TTextFileEditor
  Left = 204
  Top = 125
  Width = 832
  Height = 389
  Caption = 'TextFileEditor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottomControl: TPanel
    Left = 0
    Top = 310
    Width = 816
    Height = 41
    Align = alBottom
    TabOrder = 0
    object ButtonSave: TButton
      Left = 224
      Top = 8
      Width = 75
      Height = 25
      Caption = 'ButtonSave'
      TabOrder = 0
      OnClick = ButtonSaveClick
    end
  end
  object MemoFileContents: TMemo
    Left = 0
    Top = 0
    Width = 816
    Height = 310
    Align = alClient
    ImeName = 'Microsoft Office IME 2007'
    Lines.Strings = (
      'Memo')
    TabOrder = 1
  end
end
