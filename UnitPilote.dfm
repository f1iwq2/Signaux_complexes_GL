object FormPilote: TFormPilote
  Left = 330
  Top = 195
  BorderStyle = bsDialog
  Caption = 'Pilotage'
  ClientHeight = 350
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTitrePilote: TLabel
    Left = 8
    Top = 0
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
    Left = 208
    Top = 64
    Width = 113
    Height = 129
  end
  object LabelNbFeux: TLabel
    Left = 208
    Top = 208
    Width = 120
    Height = 13
    Caption = 'Nombre de feux '#224' allumer'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
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
      Caption = 'S'#233'maphore clignotant'
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
      Caption = 'Violet (cible '#224' 2 feux uniquement)'
      TabOrder = 9
      OnClick = RadioVioletClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 232
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
    Top = 288
    Width = 113
    Height = 33
    Caption = 'Envoyer la commande'
    TabOrder = 2
    OnClick = ButtonPiloteClick
  end
  object EditNbreFeux: TEdit
    Left = 240
    Top = 248
    Width = 57
    Height = 21
    TabOrder = 3
    Text = 'EditNbFeux'
    OnKeyPress = EditNbreFeuxKeyPress
  end
  object GroupBox3: TGroupBox
    Left = 328
    Top = 48
    Width = 209
    Height = 97
    Caption = 'pilotage unisemaf'
    TabOrder = 4
    object RadioButton1: TRadioButton
      Left = 8
      Top = 24
      Width = 145
      Height = 17
      Caption = 'Algo1 pilotage inverse'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 40
      Width = 145
      Height = 17
      Caption = 'Algo2 pilotage normal'
      TabOrder = 1
      OnClick = RadioButton2Click
    end
    object RadioButton3: TRadioButton
      Left = 8
      Top = 56
      Width = 193
      Height = 17
      Caption = 'Algo3 pilotage bits '#224' 1 seuls normal'
      TabOrder = 2
      OnClick = RadioButton3Click
    end
    object RadioButton4: TRadioButton
      Left = 8
      Top = 72
      Width = 193
      Height = 17
      Caption = 'Algo4 pilotage bits '#224' 1 seuls inverse'
      TabOrder = 3
      OnClick = RadioButton4Click
    end
  end
end
