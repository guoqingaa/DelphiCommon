object SelectExcelChartType: TSelectExcelChartType
  Left = 198
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Select Chart Type'
  ClientHeight = 236
  ClientWidth = 259
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 24
    Width = 201
    Height = 161
    Caption = 'Type'
    ItemIndex = 0
    Items.Strings = (
      'Line Stacked'
      'Bar Stacked'
      'Column Stacked')
    TabOrder = 0
  end
  object ButtonSelect: TButton
    Left = 96
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 1
    OnClick = ButtonSelectClick
  end
end
