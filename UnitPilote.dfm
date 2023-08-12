object FormPilote: TFormPilote
  Left = 479
  Top = 202
  BorderStyle = bsDialog
  Caption = 'Pilotage'
  ClientHeight = 350
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    331
    350)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTitrePilote: TLabel
    Left = 8
    Top = 8
    Width = 249
    Height = 34
    Caption = 'Pilotage du signal'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object ImagePilote: TImage
    Left = 224
    Top = 56
    Width = 81
    Height = 105
    Anchors = []
  end
  object LabelNbFeux: TLabel
    Left = 208
    Top = 248
    Width = 120
    Height = 13
    Caption = 'Nombre de feux '#224' allumer'
  end
  object LabelDec: TLabel
    Left = 200
    Top = 192
    Width = 72
    Height = 19
    Alignment = taCenter
    Caption = 'LabelDec'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 240
    Top = 176
    Width = 50
    Height = 13
    Caption = 'D'#233'codeur:'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 193
    Height = 185
    Caption = 'Signalisation de base'
    TabOrder = 0
    object RadioVert: TRadioButton
      Left = 8
      Top = 16
      Width = 169
      Height = 17
      Caption = 'Voie libre'
      TabOrder = 0
      OnClick = RadioVertClick
    end
    object RadioVertCli: TRadioButton
      Left = 8
      Top = 32
      Width = 169
      Height = 17
      Caption = 'Voie libre clignotant'
      TabOrder = 1
      OnClick = RadioVertCliClick
    end
    object RadioJaune: TRadioButton
      Left = 8
      Top = 48
      Width = 169
      Height = 17
      Caption = 'Avertissement'
      TabOrder = 2
      OnClick = RadioJauneClick
    end
    object RadioJaunecli: TRadioButton
      Left = 8
      Top = 64
      Width = 169
      Height = 17
      Caption = 'Avertissement clignotant'
      TabOrder = 3
      OnClick = RadioJaunecliClick
    end
    object RadioRouge: TRadioButton
      Left = 8
      Top = 80
      Width = 169
      Height = 17
      Caption = 'S'#233'maphore'
      TabOrder = 4
      OnClick = RadioRougeClick
    end
    object RadioRougeCli: TRadioButton
      Left = 8
      Top = 96
      Width = 161
      Height = 17
      Caption = 'Rouge cli'
      TabOrder = 5
      OnClick = RadioRougeCliClick
    end
    object RadioCarre: TRadioButton
      Left = 8
      Top = 112
      Width = 161
      Height = 17
      Caption = 'Carr'#233
      TabOrder = 6
      OnClick = RadioCarreClick
    end
    object RadioBlanc: TRadioButton
      Left = 8
      Top = 128
      Width = 169
      Height = 17
      Caption = 'Blanc'
      TabOrder = 7
      OnClick = RadioBlancClick
    end
    object RadioBlancCli: TRadioButton
      Left = 8
      Top = 144
      Width = 169
      Height = 17
      Caption = 'Blanc clignotant'
      TabOrder = 8
      OnClick = RadioBlancCliClick
    end
    object RadioViolet: TRadioButton
      Left = 8
      Top = 160
      Width = 177
      Height = 17
      Caption = 'Violet'
      TabOrder = 9
      OnClick = RadioVioletClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 240
    Width = 193
    Height = 89
    Caption = 'Signalisation combin'#233'e'
    TabOrder = 1
    object RadioRalen30: TRadioButton
      Left = 8
      Top = 16
      Width = 169
      Height = 17
      Caption = 'Ralentissement 30'
      TabOrder = 0
      OnClick = RadioRalen30Click
    end
    object RadioRappel30: TRadioButton
      Left = 8
      Top = 32
      Width = 169
      Height = 17
      Caption = 'Rappel de ralentissement 30'
      TabOrder = 1
      OnClick = RadioRappel30Click
    end
    object RadioRalen60: TRadioButton
      Left = 8
      Top = 48
      Width = 161
      Height = 17
      Caption = 'Ralentissement 60'
      TabOrder = 2
      OnClick = RadioRalen60Click
    end
    object RadioRappel60: TRadioButton
      Left = 8
      Top = 64
      Width = 169
      Height = 17
      Caption = 'Rappel de ralentissement 60'
      TabOrder = 3
      OnClick = RadioRappel60Click
    end
  end
  object ButtonPilote: TButton
    Left = 208
    Top = 296
    Width = 113
    Height = 33
    Caption = 'Envoyer la commande'
    TabOrder = 2
    OnClick = ButtonPiloteClick
  end
  object EditNbreFeux: TEdit
    Left = 240
    Top = 264
    Width = 57
    Height = 21
    TabOrder = 3
    Text = 'EditNbFeux'
    OnKeyPress = EditNbreFeuxKeyPress
  end
  object CheckVerrouCarre: TCheckBox
    Left = 216
    Top = 216
    Width = 113
    Height = 17
    Caption = 'Verrouiller au carr'#233
    TabOrder = 4
    OnClick = CheckVerrouCarreClick
  end
  object GroupBox3: TGroupBox
    Left = 120
    Top = 40
    Width = 193
    Height = 73
    Caption = 'Signalisation combin'#233'e'
    TabOrder = 5
    object CheckChiffre: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Chiffre'
      TabOrder = 0
      OnClick = CheckChiffreClick
    end
    object CheckChevron: TCheckBox
      Left = 16
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Chevron'
      TabOrder = 1
      OnClick = CheckChevronClick
    end
    object CheckClignote: TCheckBox
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Clignotants'
      TabOrder = 2
      OnClick = CheckClignoteClick
    end
  end
end
