object InspectorGridDialog: TInspectorGridDialog
  Left = 192
  Top = 125
  BorderStyle = bsDialog
  ClientHeight = 413
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 374
    Width = 366
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonOK: TButton
      Left = 174
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = ButtonOKClick
    end
    object ButtonCancel: TButton
      Left = 257
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PanelBackground: TPanel
    Left = 0
    Top = 0
    Width = 366
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PanelInspector: TPanel
      Left = 72
      Top = 16
      Width = 209
      Height = 345
      Caption = 'Panel'
      TabOrder = 0
    end
  end
end
