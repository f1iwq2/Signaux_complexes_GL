object FormRoulage: TFormRoulage
  Left = 368
  Top = 142
  BorderStyle = bsDialog
  Caption = 'Roulage des trains'
  ClientHeight = 275
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 8
    Width = 116
    Height = 20
    Caption = 'Roulage des trains'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelTexte: TLabel
    Left = 17
    Top = 32
    Width = 120
    Height = 13
    Caption = '.                                       '
  end
  object ButtonInitAig: TButton
    Left = 16
    Top = 56
    Width = 273
    Height = 25
    Caption = 'Positionner les aiguillages en position initiale'
    TabOrder = 0
    OnClick = ButtonInitAigClick
  end
  object ButtonSauve: TButton
    Left = 16
    Top = 184
    Width = 273
    Height = 25
    Hint = 
      'Enregistre la configuration de placement dans le fichier de conf' +
      'iguration'
    Caption = 'Enregistrer la configuration de  placement'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = ButtonSauveClick
  end
  object ButtonLanceRoutage: TButton
    Left = 16
    Top = 88
    Width = 273
    Height = 25
    Caption = 'Lancer le roulage'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = ButtonLanceRoutageClick
  end
  object Button1: TButton
    Left = 216
    Top = 240
    Width = 81
    Height = 25
    Caption = 'Config trains'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ButtonArretroutage: TButton
    Left = 16
    Top = 152
    Width = 273
    Height = 25
    Hint = 'Arr'#234't des trains et lib'#232're les r'#233'servations'
    Caption = 'Arr'#234't du roulage'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = ButtonArretroutageClick
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 240
    Width = 73
    Height = 25
    TabOrder = 5
    OnClick = BitBtn1Click
    Kind = bkClose
  end
  object ButtonArretTrains: TButton
    Left = 16
    Top = 120
    Width = 273
    Height = 25
    Hint = 'Arr'#234'te tous les trains'
    Caption = 'Arr'#234't des trains'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = ButtonArretTrainsClick
  end
end
