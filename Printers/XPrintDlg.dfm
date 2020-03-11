object XPrintDialog: TXPrintDialog
  Left = 389
  Top = 225
  BorderStyle = bsDialog
  Caption = 'Setup Print'
  ClientHeight = 308
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 545
    Height = 53
    Caption = 'Printer'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 43
      Height = 15
      Caption = 'Name : '
    end
    object ComboPrinter: TComboBox
      Left = 61
      Top = 21
      Width = 417
      Height = 22
      Style = csOwnerDrawFixed
      ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
      ItemHeight = 16
      TabOrder = 0
      OnClick = ComboPrinterClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 72
    Width = 161
    Height = 53
    Caption = 'Number of Copies'
    TabOrder = 1
    object Label2: TLabel
      Left = 10
      Top = 25
      Width = 3
      Height = 15
    end
    object SpinCopies: TSpinEdit
      Left = 26
      Top = 20
      Width = 50
      Height = 24
      MaxValue = 100
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = SpinCopiesChange
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 136
    Width = 161
    Height = 65
    Caption = 'Orientation'
    TabOrder = 2
    object RadioLandscape: TRadioButton
      Left = 13
      Top = 20
      Width = 100
      Height = 17
      Caption = 'Landscape'
      TabOrder = 0
      OnClick = RadioOrientationClick
    end
    object RadioPortrait: TRadioButton
      Left = 13
      Top = 40
      Width = 84
      Height = 17
      Caption = 'Portrait'
      TabOrder = 1
      OnClick = RadioOrientationClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 183
    Top = 72
    Width = 164
    Height = 129
    Caption = 'Margin'
    TabOrder = 3
    object Label3: TLabel
      Left = 13
      Top = 25
      Width = 30
      Height = 15
      Caption = 'Top : '
    end
    object Label4: TLabel
      Left = 13
      Top = 50
      Width = 48
      Height = 15
      Caption = 'Bottom : '
    end
    object Label5: TLabel
      Left = 13
      Top = 75
      Width = 29
      Height = 15
      Caption = 'Left : '
    end
    object Label6: TLabel
      Left = 13
      Top = 100
      Width = 38
      Height = 15
      Caption = 'Right : '
    end
    object Label7: TLabel
      Left = 123
      Top = 26
      Width = 17
      Height = 15
      Caption = 'cm'
    end
    object Label8: TLabel
      Left = 123
      Top = 51
      Width = 17
      Height = 15
      Caption = 'cm'
    end
    object Label9: TLabel
      Left = 123
      Top = 75
      Width = 17
      Height = 15
      Caption = 'cm'
    end
    object Label10: TLabel
      Left = 123
      Top = 100
      Width = 17
      Height = 15
      Caption = 'cm'
    end
    object EditTop: TEdit
      Tag = 100
      Left = 64
      Top = 22
      Width = 55
      Height = 23
      ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
      TabOrder = 0
      OnChange = EditMarginChange
      OnExit = EditMarginExit
    end
    object EditBottom: TEdit
      Tag = 200
      Left = 64
      Top = 47
      Width = 55
      Height = 23
      ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
      TabOrder = 1
      OnChange = EditMarginChange
      OnExit = EditMarginExit
    end
    object EditLeft: TEdit
      Tag = 300
      Left = 64
      Top = 73
      Width = 55
      Height = 23
      ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
      TabOrder = 2
      OnChange = EditMarginChange
      OnExit = EditMarginExit
    end
    object EditRight: TEdit
      Tag = 400
      Left = 64
      Top = 98
      Width = 55
      Height = 23
      ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
      TabOrder = 3
      OnChange = EditMarginChange
      OnExit = EditMarginExit
    end
  end
  object CheckFitInPage: TCheckBox
    Left = 188
    Top = 223
    Width = 154
    Height = 17
    Caption = 'Fit in page'
    TabOrder = 4
    OnClick = CheckFitInPageClick
  end
  object GroupBox5: TGroupBox
    Left = 355
    Top = 72
    Width = 198
    Height = 201
    Cursor = crHandPoint
    Caption = 'Preview'
    TabOrder = 5
    object PaintPreview: TPaintBox
      Left = 2
      Top = 17
      Width = 194
      Height = 182
      Align = alClient
      OnClick = PreviewClick
      OnPaint = PaintPreviewPaint
    end
    object Image: TImage
      Left = 48
      Top = 56
      Width = 105
      Height = 105
      Stretch = True
      OnClick = PreviewClick
    end
  end
  object ButtonOK: TButton
    Left = 88
    Top = 274
    Width = 97
    Height = 25
    Caption = 'Print'
    ModalResult = 1
    TabOrder = 6
  end
  object Button3: TButton
    Left = 200
    Top = 274
    Width = 97
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object GroupBox6: TGroupBox
    Left = 8
    Top = 211
    Width = 161
    Height = 40
    Caption = 'Mono/Color'
    TabOrder = 8
    object RadioMono: TRadioButton
      Left = 8
      Top = 16
      Width = 49
      Height = 17
      Caption = 'Mono'
      TabOrder = 0
      OnClick = RadioColorClick
    end
    object RadioColor: TRadioButton
      Left = 80
      Top = 16
      Width = 49
      Height = 17
      Caption = 'Color'
      TabOrder = 1
      OnClick = RadioColorClick
    end
  end
end
