object FormPlace: TFormPlace
  Left = 313
  Top = 116
  BorderStyle = bsDialog
  Caption = 'Placement des trains'
  ClientHeight = 442
  ClientWidth = 307
  Color = clBtnFace
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
    Left = 32
    Top = 8
    Width = 229
    Height = 20
    Caption = 'Placement des trains pour le roulage'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelTrain1: TLabel
    Left = 152
    Top = 56
    Width = 30
    Height = 13
    Caption = 'Train1'
  end
  object LabelTrain2: TLabel
    Left = 152
    Top = 80
    Width = 30
    Height = 13
    Caption = 'Train2'
  end
  object LabelTrain3: TLabel
    Left = 152
    Top = 104
    Width = 30
    Height = 13
    Caption = 'Train3'
  end
  object LabelTrain4: TLabel
    Left = 152
    Top = 128
    Width = 30
    Height = 13
    Caption = 'Train4'
  end
  object LabelTrain5: TLabel
    Left = 152
    Top = 152
    Width = 30
    Height = 13
    Caption = 'Train5'
  end
  object LabelTrain6: TLabel
    Left = 152
    Top = 176
    Width = 30
    Height = 13
    Caption = 'Train7'
  end
  object Label2: TLabel
    Left = 96
    Top = 40
    Width = 52
    Height = 13
    Caption = 'D'#233'tecteurs'
  end
  object LabelTexte: TLabel
    Left = 19
    Top = 224
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 8
    Top = 208
    Width = 293
    Height = 13
    Caption = 'Pour ne pas placer un train, mettre 0 en face de son d'#233'tecteur'
  end
  object Buttonferme: TButton
    Left = 16
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Fermer'
    TabOrder = 0
    OnClick = ButtonfermeClick
  end
  object ButtonInitAig: TButton
    Left = 16
    Top = 272
    Width = 273
    Height = 25
    Caption = 'Positionner les aiguillages en position initiale'
    TabOrder = 1
    OnClick = ButtonInitAigClick
  end
  object ButtonSauve: TButton
    Left = 16
    Top = 368
    Width = 273
    Height = 25
    Caption = 'Enregistrer la configuration de roulage'
    TabOrder = 2
    OnClick = ButtonSauveClick
  end
  object Edit1: TEdit
    Left = 96
    Top = 56
    Width = 49
    Height = 21
    TabOrder = 3
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 96
    Top = 80
    Width = 49
    Height = 21
    TabOrder = 4
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 96
    Top = 104
    Width = 49
    Height = 21
    TabOrder = 5
    OnChange = Edit3Change
  end
  object Edit4: TEdit
    Left = 96
    Top = 128
    Width = 49
    Height = 21
    TabOrder = 6
    OnChange = Edit4Change
  end
  object Edit5: TEdit
    Left = 96
    Top = 152
    Width = 49
    Height = 21
    TabOrder = 7
    OnChange = Edit5Change
  end
  object Edit6: TEdit
    Left = 96
    Top = 176
    Width = 49
    Height = 21
    TabOrder = 8
    OnChange = Edit6Change
  end
  object ButtonPlace: TButton
    Left = 16
    Top = 240
    Width = 273
    Height = 25
    Caption = 'Placer les trains sur les d'#233'tecteurs ci-dessus'
    TabOrder = 9
    OnClick = ButtonPlaceClick
  end
  object ButtonLanceRoutage: TButton
    Left = 16
    Top = 304
    Width = 273
    Height = 25
    Caption = 'Lancer le roulage'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = ButtonLanceRoutageClick
  end
  object Button1: TButton
    Left = 208
    Top = 400
    Width = 81
    Height = 25
    Caption = 'Config trains'
    TabOrder = 11
    OnClick = Button1Click
  end
  object ButtonArretroutage: TButton
    Left = 16
    Top = 336
    Width = 273
    Height = 25
    Caption = 'Arr'#234't du roulage'
    TabOrder = 12
    OnClick = ButtonArretroutageClick
  end
end