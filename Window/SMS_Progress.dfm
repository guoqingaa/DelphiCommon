object SMS_ProgressWindow: TSMS_ProgressWindow
  Left = 321
  Top = 198
  BorderStyle = bsDialog
  Caption = 'SMS_ProgressWindow'
  ClientHeight = 218
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListMessage: TListBox
    Left = 0
    Top = 0
    Width = 355
    Height = 177
    Style = lbOwnerDrawFixed
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ImeName = 'Microsoft Office IME 2007'
    ItemHeight = 20
    ParentFont = False
    TabOrder = 0
    OnMeasureItem = ListMessageMeasureItem
  end
  object Panel1: TPanel
    Left = 0
    Top = 177
    Width = 355
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object ProgressBar1: TProgressBar
      Left = 16
      Top = 8
      Width = 321
      Height = 17
      TabOrder = 0
    end
  end
end
