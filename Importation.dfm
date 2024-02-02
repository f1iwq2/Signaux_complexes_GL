object FormImportation: TFormImportation
  Left = 314
  Top = 286
  Width = 610
  Height = 214
  Caption = 'Compilation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCompiler: TButton
    Left = 160
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Compiler'
    TabOrder = 0
    OnClick = ButtonCompilerClick
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 10
    Width = 169
    Height = 119
    Caption = 'Strat'#233'gies de compilation'
    TabOrder = 1
    object CheckDebugAnalyse: TCheckBox
      Left = 8
      Top = 32
      Width = 113
      Height = 17
      Hint = 'Affiche le debug importation en page Debug'
      Caption = 'Debug importation'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CheckDebugAnalyseClick
    end
    object CheckDebugBranches: TCheckBox
      Left = 8
      Top = 56
      Width = 97
      Height = 17
      Hint = 'Affiche le debug branches en page Debug'
      Caption = 'Debug branches'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CheckDebugBranchesClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 198
    Top = 10
    Width = 377
    Height = 119
    Caption = 'Param'#232'tres'
    TabOrder = 2
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 24
      Width = 281
      Height = 65
      Caption = 'Adressage des croisements'
      TabOrder = 0
    end
    object RadioCroisSuite: TRadioButton
      Left = 24
      Top = 40
      Width = 217
      Height = 17
      Caption = 'Croisements '#224' la suite des aiguillages'
      TabOrder = 1
    end
    object RadioCroisBase: TRadioButton
      Left = 24
      Top = 56
      Width = 217
      Height = 17
      Caption = 'Croisements '#224' partir de l'#39'adresse de base'
      TabOrder = 2
    end
    object EditBaseCrois: TEdit
      Left = 240
      Top = 54
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '100'
      OnChange = EditBaseCroisChange
    end
  end
  object ButtonAnnuler: TButton
    Left = 264
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Annuler'
    TabOrder = 3
    OnClick = ButtonAnnulerClick
  end
end
