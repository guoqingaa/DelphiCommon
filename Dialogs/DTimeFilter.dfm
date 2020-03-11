object TimeFilterDialog: TTimeFilterDialog
  Left = 192
  Top = 124
  BorderStyle = bsDialog
  Caption = 'TimeFilterDialog'
  ClientHeight = 140
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 15
  object CheckBoxBegin: TCheckBox
    Left = 40
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Begin'
    TabOrder = 0
  end
  object CheckBoxEnd: TCheckBox
    Left = 208
    Top = 24
    Width = 97
    Height = 17
    Caption = 'End'
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 56
    Top = 48
    Width = 121
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 224
    Top = 48
    Width = 121
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 3
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 80
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 168
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 5
  end
  object Button3: TButton
    Left = 256
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
  end
  object MaskEditStart: TMaskEdit
    Left = 56
    Top = 80
    Width = 120
    Height = 23
    EditMask = '!90:00;1;_'
    ImeName = 'Microsoft Office IME 2007'
    MaxLength = 5
    TabOrder = 7
    Text = '  :  '
  end
  object MaskEditEnd: TMaskEdit
    Left = 224
    Top = 80
    Width = 120
    Height = 23
    EditMask = '!90:00;1;_'
    ImeName = 'Microsoft Office IME 2007'
    MaxLength = 5
    TabOrder = 8
    Text = '  :  '
  end
end
