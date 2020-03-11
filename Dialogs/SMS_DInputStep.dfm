object StepInputDialog: TStepInputDialog
  Left = 192
  Top = 124
  BorderStyle = bsDialog
  Caption = 'Input Step'
  ClientHeight = 148
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 168
    Top = 20
    Width = 28
    Height = 15
    Caption = 'Start:'
  end
  object Label2: TLabel
    Left = 288
    Top = 20
    Width = 30
    Height = 15
    Caption = 'Last :'
  end
  object Label3: TLabel
    Left = 400
    Top = 20
    Width = 36
    Height = 15
    Caption = 'Count:'
  end
  object Label4: TLabel
    Left = 32
    Top = 48
    Width = 90
    Height = 15
    Caption = 'Last Reference :'
  end
  object EditName: TEdit
    Left = 24
    Top = 16
    Width = 121
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 0
  end
  object EditStart: TEdit
    Left = 208
    Top = 16
    Width = 63
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 1
    Text = '0'
  end
  object EditLast: TEdit
    Left = 328
    Top = 16
    Width = 63
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 2
    Text = '0'
  end
  object EditStep: TEdit
    Left = 448
    Top = 16
    Width = 63
    Height = 23
    ImeName = 'Microsoft Office IME 2007'
    TabOrder = 3
    Text = '0'
  end
  object ButtonOK: TButton
    Left = 346
    Top = 118
    Width = 75
    Height = 22
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 434
    Top = 118
    Width = 75
    Height = 22
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object CheckAutoLast: TCheckBox
    Left = 330
    Top = 43
    Width = 59
    Height = 17
    Caption = 'Auto'
    TabOrder = 6
    OnClick = CheckAutoLastClick
  end
  object EditLastRef: TEdit
    Left = 24
    Top = 72
    Width = 369
    Height = 23
    TabOrder = 7
  end
end
