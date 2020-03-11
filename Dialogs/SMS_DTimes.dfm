object TimesDialog: TTimesDialog
  Left = 11
  Top = 18
  BorderStyle = bsDialog
  Caption = 'TimesDialog'
  ClientHeight = 156
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object PanelControl: TPanel
    Left = 0
    Top = 83
    Width = 247
    Height = 73
    Align = alBottom
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 88
      Top = 40
      Width = 73
      Height = 22
      Caption = 'OK'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 168
      Top = 40
      Width = 73
      Height = 22
      Caption = 'Cancel'
      OnClick = SpeedButton2Click
    end
    object ButtonAdd: TSpeedButton
      Left = 102
      Top = 6
      Width = 65
      Height = 22
      Caption = 'Add'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = ButtonAddClick
    end
    object ButtonClear: TSpeedButton
      Left = 174
      Top = 6
      Width = 65
      Height = 22
      Caption = 'Clear'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = ButtonClearClick
    end
    object CheckApplyAll: TCheckBox
      Left = 19
      Top = 9
      Width = 70
      Height = 17
      Caption = 'Apply All'
      TabOrder = 0
    end
  end
  object PanelPicker: TPanel
    Left = 0
    Top = 0
    Width = 247
    Height = 83
    Align = alClient
    TabOrder = 1
  end
  object PopupMenu1: TPopupMenu
    Left = 64
    Top = 40
    object Remove1: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
  end
end
