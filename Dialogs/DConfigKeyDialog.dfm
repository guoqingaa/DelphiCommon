object ConfigKeyDialog: TConfigKeyDialog
  Left = 232
  Top = 124
  Width = 341
  Height = 480
  Caption = 'Format Key Values'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 333
    Height = 408
    Align = alClient
    DropDownRows = 12
    KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
    TabOrder = 0
    OnClick = ValueListEditor1Click
    OnEditButtonClick = ValueListEditor1EditButtonClick
    ColWidths = (
      150
      177)
  end
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 333
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button2: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button2'
      ModalResult = 1
      TabOrder = 0
    end
    object Button1: TButton
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Insert Row'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 184
    Top = 192
  end
end
