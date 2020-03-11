object ConfirmDialog: TConfirmDialog
  Left = 192
  Top = 124
  BorderStyle = bsDialog
  Caption = 'Confirm Dialog'
  ClientHeight = 117
  ClientWidth = 350
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
  object Panel1: TPanel
    Left = 0
    Top = 76
    Width = 350
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 176
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Accept'
      ModalResult = 1
      TabOrder = 0
    end
    object ButtonDeny: TButton
      Left = 260
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Deny'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PanelConfirms: TPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 76
    Align = alClient
    TabOrder = 1
    object GridConfirms: TStringGrid
      Left = 14
      Top = 10
      Width = 321
      Height = 54
      BorderStyle = bsNone
      ColCount = 2
      DefaultDrawing = False
      RowCount = 2
      ScrollBars = ssNone
      TabOrder = 0
      OnDrawCell = GridConfirmsDrawCell
    end
  end
end
