object SMSHint: TSMSHint
  Left = 192
  Top = 125
  BorderStyle = bsNone
  Caption = 'SMSHint'
  ClientHeight = 74
  ClientWidth = 204
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 14
  object PaintHint: TPaintBox
    Left = 0
    Top = 0
    Width = 204
    Height = 74
    Align = alClient
    OnMouseDown = PaintHintMouseDown
    OnPaint = PaintHintPaint
  end
end