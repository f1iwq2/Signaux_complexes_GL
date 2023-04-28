object FormAnalyseCDM: TFormAnalyseCDM
  Left = 154
  Top = 36
  AutoScroll = False
  Caption = 'FormAnalyseCDM'
  ClientHeight = 660
  ClientWidth = 1032
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    1032
    660)
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 16
    Width = 977
    Height = 537
    HorzScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoScroll = False
    Color = clBlack
    ParentColor = False
    TabOrder = 0
    object ImageCDM: TImage
      Left = 0
      Top = 0
      Width = 937
      Height = 512
    end
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 560
    Width = 257
    Height = 89
    Anchors = [akLeft, akBottom]
    Caption = 'Affichages '
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 56
      Width = 81
      Height = 13
      Caption = 'Afficher le port n'#176
    end
    object CheckConnexions: TCheckBox
      Left = 24
      Top = 16
      Width = 97
      Height = 17
      Hint = 'Points de connexions des ports des d'#233'tecteurs et des actionneurs'
      Caption = 'Connexions'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CheckConnexionsClick
    end
    object CheckAdresses: TCheckBox
      Left = 24
      Top = 32
      Width = 97
      Height = 17
      Hint = 'Adresses des d'#233'tecteurs et actionneurs'
      Caption = 'Adresses'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CheckAdressesClick
    end
    object CheckSegments: TCheckBox
      Left = 112
      Top = 16
      Width = 81
      Height = 25
      Caption = 'segments'
      TabOrder = 2
      OnClick = CheckSegmentsClick
    end
    object CheckPorts: TCheckBox
      Left = 112
      Top = 32
      Width = 121
      Height = 17
      Hint = 'Affiche le num'#233'ro de segment et le port de CDM'
      Caption = 'Ports'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = CheckPortsClick
    end
    object EditPort: TEdit
      Left = 112
      Top = 56
      Width = 57
      Height = 21
      TabOrder = 4
    end
    object ButtonAffPort: TButton
      Left = 176
      Top = 56
      Width = 73
      Height = 25
      Caption = 'Afficher le port'
      TabOrder = 5
      OnClick = ButtonAffPortClick
    end
  end
  object TrackBar1: TTrackBar
    Left = 992
    Top = 16
    Width = 37
    Height = 553
    Anchors = [akTop, akRight]
    Max = 200
    Min = 50
    Orientation = trVertical
    Position = 200
    TabOrder = 2
    OnChange = TrackBar1Change
  end
  object GroupBox2: TGroupBox
    Left = 280
    Top = 560
    Width = 145
    Height = 89
    Anchors = [akLeft, akBottom]
    Caption = 'Strat'#233'gies d'#39'importation'
    TabOrder = 3
    object CheckDebugAnalyse: TCheckBox
      Left = 16
      Top = 24
      Width = 121
      Height = 17
      Caption = 'Debug importation'
      TabOrder = 0
      OnClick = CheckDebugAnalyseClick
    end
    object CheckDebugBranches: TCheckBox
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Debug branches'
      TabOrder = 1
      OnClick = CheckDebugBranchesClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 432
    Top = 560
    Width = 537
    Height = 89
    Anchors = [akLeft, akBottom]
    Caption = 'Param'#232'tres'
    TabOrder = 4
    DesignSize = (
      537
      89)
    object ButtonImporter: TButton
      Left = 382
      Top = 40
      Width = 75
      Height = 25
      Hint = 'Lancement de l'#39'importation'
      Anchors = [akLeft, akBottom]
      Caption = 'Importer'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ButtonImporterClick
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 24
      Width = 305
      Height = 57
      Caption = 'Adressage des croisements'
      TabOrder = 1
    end
    object RadioCroisSuite: TRadioButton
      Left = 24
      Top = 40
      Width = 217
      Height = 17
      Caption = 'Croisements '#224' la suite des aiguillages'
      TabOrder = 2
    end
    object RadioCroisBase: TRadioButton
      Left = 24
      Top = 56
      Width = 217
      Height = 17
      Caption = 'Croisements '#224' partir de l'#39'adresse de base'
      TabOrder = 3
    end
    object EditBaseCrois: TEdit
      Left = 240
      Top = 54
      Width = 41
      Height = 21
      TabOrder = 4
      Text = '100'
      OnChange = EditBaseCroisChange
    end
  end
end
