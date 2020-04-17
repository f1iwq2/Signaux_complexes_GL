object FormConfig: TFormConfig
  Left = 316
  Top = 238
  Width = 598
  Height = 382
  Caption = 'Configuration g'#233'n'#233'rale'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 128
    Top = 288
    Width = 332
    Height = 13
    Caption = 
      'Ces param'#232'tres ne sont pas modifi'#233's dans les fichiers de configu' +
      'ration '
    WordWrap = True
  end
  object LabelInfo: TLabel
    Left = 14
    Top = 192
    Width = 3
    Height = 16
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 81
    Caption = 'CDM Rail'
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 26
      Width = 150
      Height = 13
      Caption = 'Adresse IP du serveur CDM rail '
    end
    object Label2: TLabel
      Left = 14
      Top = 50
      Width = 115
      Height = 13
      Caption = 'Port du serveur CDM rail'
    end
    object EditAdrIPCDM: TEdit
      Left = 176
      Top = 24
      Width = 81
      Height = 21
      TabStop = False
      TabOrder = 0
      Text = 'EditAdrIPCDM'
    end
    object EditPortCDM: TEdit
      Left = 176
      Top = 48
      Width = 81
      Height = 21
      TabStop = False
      TabOrder = 1
      Text = 'EditPortCDM'
    end
  end
  object GroupBox2: TGroupBox
    Left = 280
    Top = 8
    Width = 290
    Height = 153
    Caption = 'Acc'#232's USB - S'#233'rie '#224' l'#39'interface vers la centrale LENZ'
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 56
      Width = 128
      Height = 13
      Caption = 'Protocole s'#233'rie USB (COM)'
    end
    object Label4: TLabel
      Left = 16
      Top = 80
      Width = 126
      Height = 26
      Caption = 'Temporisation d'#39'envoi des octets de la trame (ms)'
      WordWrap = True
    end
    object Label5: TLabel
      Left = 16
      Top = 112
      Width = 152
      Height = 26
      Caption = 'Temporisation d'#39'attente de la r'#233'ponse de l'#39'interface (x 100 ms)'
      WordWrap = True
    end
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 249
      Height = 13
      Caption = 'Ces param'#232'tres sont utilis'#233's en fonctionnement sans '
    end
    object Label10: TLabel
      Left = 8
      Top = 32
      Width = 40
      Height = 13
      Caption = 'CDM rail'
    end
    object EditcomUSB: TEdit
      Left = 160
      Top = 56
      Width = 121
      Height = 21
      TabStop = False
      TabOrder = 0
      Text = 'EditcomUSB'
    end
    object EditTempoOctetUSB: TEdit
      Left = 232
      Top = 88
      Width = 49
      Height = 21
      TabStop = False
      TabOrder = 1
      Text = 'EditTempoOctetUSB'
    end
    object EditTempoReponse: TEdit
      Left = 232
      Top = 120
      Width = 49
      Height = 21
      TabStop = False
      TabOrder = 2
      Text = 'EditTempoReponse'
    end
  end
  object Button1: TButton
    Left = 112
    Top = 312
    Width = 105
    Height = 25
    Caption = 'Appliquer et Fermer'
    TabOrder = 2
    OnClick = Button1Click
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 96
    Width = 265
    Height = 105
    Caption = 'Acc'#232's r'#233'seau '#224' l'#39'interface vers la centrale LENZ'
    TabOrder = 3
    object Label7: TLabel
      Left = 14
      Top = 56
      Width = 95
      Height = 13
      Caption = 'Adresse IP interface'
    end
    object Label8: TLabel
      Left = 14
      Top = 82
      Width = 82
      Height = 13
      Caption = 'Port de l'#39'interface'
    end
    object Label11: TLabel
      Left = 8
      Top = 16
      Width = 249
      Height = 13
      Caption = 'Ces param'#232'tres sont utilis'#233's en fonctionnement sans '
    end
    object Label12: TLabel
      Left = 8
      Top = 32
      Width = 40
      Height = 13
      Caption = 'CDM rail'
    end
    object EditIPLenz: TEdit
      Left = 176
      Top = 56
      Width = 81
      Height = 21
      TabStop = False
      TabOrder = 0
      Text = 'EditIPLenz'
    end
    object EditportLenz: TEdit
      Left = 176
      Top = 80
      Width = 81
      Height = 21
      TabStop = False
      TabOrder = 1
      Text = 'EditportLenz'
    end
  end
  object GroupBox4: TGroupBox
    Left = 280
    Top = 168
    Width = 289
    Height = 73
    Caption = 'Ent'#234'te des trames vers l'#39'interface'
    TabOrder = 4
    object RadioButton1: TRadioButton
      Left = 8
      Top = 16
      Width = 225
      Height = 17
      Caption = 'Sans ent'#234'te (interfaces s'#233'rie)'
      TabOrder = 0
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 32
      Width = 225
      Height = 17
      Caption = 'Ent'#234'te FF FE (interfaces natives USB)'
      TabOrder = 1
    end
    object RadioButton3: TRadioButton
      Left = 8
      Top = 48
      Width = 265
      Height = 17
      Caption = 'Ent'#234'te E4 - Suffixe 0D 0D 0A (arduino XpressNet)'
      TabOrder = 2
    end
  end
  object Button2: TButton
    Left = 352
    Top = 312
    Width = 113
    Height = 25
    Caption = 'Fermer sans appliquer'
    TabOrder = 5
    OnClick = Button2Click
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 208
    Width = 265
    Height = 57
    Caption = 'Versions du programme'
    TabOrder = 6
    object CheckVerifVersion: TCheckBox
      Left = 8
      Top = 16
      Width = 249
      Height = 17
      Caption = 'V'#233'rifications de nouvelle version au d'#233'marrage'
      TabOrder = 0
    end
    object CheckInfoVersion: TCheckBox
      Left = 8
      Top = 32
      Width = 241
      Height = 17
      Caption = 'Information sur la version actuelle'
      TabOrder = 1
    end
  end
end
