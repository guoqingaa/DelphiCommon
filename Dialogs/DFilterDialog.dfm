object FilterDialog: TFilterDialog
  Left = 192
  Top = 122
  BorderStyle = bsDialog
  Caption = 'Filter'
  ClientHeight = 307
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object ListSelecteds: TListBox
    Left = 16
    Top = 16
    Width = 249
    Height = 244
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ImeName = 'Microsoft Office IME 2007'
    ItemHeight = 15
    MultiSelect = True
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 272
    Width = 60
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 80
    Top = 272
    Width = 60
    Height = 25
    Caption = 'Clear'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 208
    Top = 272
    Width = 60
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 144
    Top = 272
    Width = 60
    Height = 25
    Caption = 'SelectAll'
    TabOrder = 4
    OnClick = Button4Click
  end
end
