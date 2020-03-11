object SChartFrame: TSChartFrame
  Left = 0
  Top = 0
  Width = 506
  Height = 269
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object PaintChart: TPaintBox
    Left = 0
    Top = 0
    Width = 506
    Height = 269
    Align = alClient
    PopupMenu = PopupMenu1
    OnMouseUp = PaintChartMouseUp
    OnPaint = PaintChartPaint
  end
  object PopupMenu1: TPopupMenu
    Left = 296
    Top = 112
    object Properties1: TMenuItem
      Caption = 'Properties'
      OnClick = Properties1Click
    end
  end
end
