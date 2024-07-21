object FormAig: TFormAig
  Left = 496
  Top = 217
  Width = 363
  Height = 204
  Caption = 'Pilotage de l'#39'aiguillage'
  Color = clMaroon
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 8
    Width = 173
    Height = 23
    Caption = 'Pilotage de l'#39'aiguillage'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindow
    Font.Height = -19
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object LabelAdr1: TLabel
    Left = 56
    Top = 56
    Width = 65
    Height = 16
    Caption = 'LabelAdr1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindow
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelAdr2: TLabel
    Left = 224
    Top = 56
    Width = 65
    Height = 16
    Caption = 'LabelAdr2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindow
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonOK: TButton
    Left = 136
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object ButtonDev: TButton
    Left = 8
    Top = 88
    Width = 75
    Height = 25
    Caption = 'D'#233'vi'#233
    TabOrder = 1
    OnClick = ButtonDevClick
  end
  object ButtonDroit: TButton
    Left = 88
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Droit'
    TabOrder = 2
    OnClick = ButtonDroitClick
  end
  object ButtonDev2: TButton
    Left = 184
    Top = 88
    Width = 75
    Height = 25
    Caption = 'D'#233'vi'#233
    TabOrder = 3
    OnClick = ButtonDev2Click
  end
  object ButtonDroit2: TButton
    Left = 264
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Droit'
    TabOrder = 4
    OnClick = ButtonDroit2Click
  end
end
