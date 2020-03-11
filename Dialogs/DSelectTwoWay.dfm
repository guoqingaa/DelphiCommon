object SelectTwoWayDialog: TSelectTwoWayDialog
  Left = 0
  Top = 130
  BorderStyle = bsDialog
  ClientHeight = 155
  ClientWidth = 292
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object RadioButton1: TRadioButton
    Left = 64
    Top = 32
    Width = 113
    Height = 17
    Caption = 'Integral'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 64
    Top = 72
    Width = 113
    Height = 17
    Caption = 'Independent'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 72
    Top = 120
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object ButtonCancel: TButton
    Left = 160
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
