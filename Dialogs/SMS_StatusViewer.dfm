object StatusViewer: TStatusViewer
  Left = 353
  Top = 124
  Width = 433
  Height = 471
  Caption = 'StatusViewer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 417
    Height = 432
    Align = alClient
    ImeName = 'Microsoft Office IME 2007'
    PopupMenu = PopupMenu1
    TabOrder = 0
    WordWrap = False
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 88
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
  end
end
