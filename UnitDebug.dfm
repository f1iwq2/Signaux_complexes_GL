object FormDebug: TFormDebug
  Left = 186
  Top = 143
  Width = 809
  Height = 773
  Caption = 'Fen'#234'tre de d'#233'bug'
  Color = clWindow
  TransparentColorValue = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    793
    735)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 609
    Top = 7
    Width = 108
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Niveau du Debug (0-3)'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 441
    Top = 4
    Width = 131
    Height = 18
    Anchors = [akTop, akRight]
    Caption = 'Fen'#234'tre de d'#233'bug'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 441
    Top = 168
    Width = 97
    Height = 193
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Label3'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindow
    Font.Height = -13
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object EditNivDebug: TEdit
    Left = 721
    Top = 4
    Width = 49
    Height = 21
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'EditNivDebug'
    OnKeyPress = EditNivDebugKeyPress
  end
  object MemoEvtDet: TMemo
    Left = 545
    Top = 408
    Width = 233
    Height = 221
    Anchors = [akTop, akRight]
    Color = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'Tableau des '#233'v'#232'nements '
      'fronts descendants d'#233'tecteurs')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ButtonEcrLog: TButton
    Left = 441
    Top = 504
    Width = 97
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Sauvegarder le log'
    TabOrder = 2
    OnClick = ButtonEcrLogClick
  end
  object MemoDebug: TMemo
    Left = 0
    Top = 8
    Width = 426
    Height = 722
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoDebug')
    ScrollBars = ssVertical
    TabOrder = 3
    WordWrap = False
  end
  object ButtonRazTampon: TButton
    Left = 441
    Top = 584
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Raz Tampon Ev'#232'nements ---->'
    TabOrder = 4
    WordWrap = True
    OnClick = ButtonRazTamponClick
  end
  object ButtonCherche: TButton
    Left = 441
    Top = 464
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Chercher erreurs'
    TabOrder = 5
    OnClick = ButtonChercheClick
  end
  object ButtonAffEvtChrono: TButton
    Left = 441
    Top = 424
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Affiche Evts d'#233'tecteurs et aig'
    TabOrder = 6
    WordWrap = True
    OnClick = ButtonAffEvtChronoClick
  end
  object ButtonCop: TButton
    Left = 441
    Top = 368
    Width = 97
    Height = 49
    Anchors = [akTop, akRight]
    Caption = 'Copie fen'#234'te principale dans debug'
    TabOrder = 7
    WordWrap = True
    OnClick = ButtonCopClick
  end
  object RichEdit: TRichEdit
    Left = 545
    Top = 168
    Width = 233
    Height = 233
    Anchors = [akTop, akRight]
    HideScrollBars = False
    PopupMenu = PopupMenuRE
    ScrollBars = ssVertical
    TabOrder = 8
  end
  object ButtonRazLog: TButton
    Left = 441
    Top = 544
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Raz Tampon Log <-----'
    TabOrder = 9
    WordWrap = True
    OnClick = ButtonRazLogClick
  end
  object GroupBox1: TGroupBox
    Left = 441
    Top = 633
    Width = 353
    Height = 97
    Anchors = [akRight, akBottom]
    Caption = 'Fonctions primitives'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 10
    object ButtonSigSuiv: TButton
      Left = 16
      Top = 24
      Width = 97
      Height = 25
      Hint = 'Etat du signal suivant'
      Caption = 'Etat signal suivant'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ButtonSigSuivClick
    end
    object EditSigSuiv: TEdit
      Left = 280
      Top = 24
      Width = 49
      Height = 21
      Hint = 'Indiquer l'#39'adresse du signal '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object EditPrec: TEdit
      Left = 224
      Top = 58
      Width = 49
      Height = 21
      Hint = 'Element pr'#233'c'#233'dent'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object EditActuel: TEdit
      Left = 288
      Top = 58
      Width = 49
      Height = 21
      Hint = 'Element actuel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object ButtonDetSuiv: TButton
      Left = 16
      Top = 56
      Width = 201
      Height = 25
      Hint = 
        'Renvoie l'#39#233'l'#233'ment suivant aux deux '#233'l'#233'ments (d'#233'tecteurs ou aigui' +
        'llages) '
      Caption = 'D'#233'tecteur suivant aux '#233'l'#233'ments'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = ButtonDetSuivClick
    end
    object ButtonCanSuivSig: TButton
      Left = 128
      Top = 16
      Width = 105
      Height = 33
      Hint = 'Renvoie l'#39'occupation du canton suivant le signal'
      Caption = 'Etat canton suivant signal occup'#233
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      WordWrap = True
      OnClick = ButtonCanSuivSigClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 433
    Top = 24
    Width = 345
    Height = 137
    Anchors = [akTop, akRight]
    Caption = 'S'#233'lections d'#39'affichage'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 11
    object CheckAffSig: TCheckBox
      Left = 24
      Top = 16
      Width = 297
      Height = 17
      Caption = 'Fonctionnement des signaux'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckAffSigClick
    end
    object CheckBoxEvtDetAig: TCheckBox
      Left = 24
      Top = 32
      Width = 281
      Height = 17
      Caption = 'Ev'#232'nements d'#233'tecteurs et aiguillages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CheckBoxEvtDetAigClick
    end
    object CheckBoxTraceLIste: TCheckBox
      Left = 24
      Top = 112
      Width = 289
      Height = 17
      Caption = 'Evaluations des routes des trains'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CheckBoxTraceLIsteClick
    end
    object CheckTrame: TCheckBox
      Left = 24
      Top = 80
      Width = 305
      Height = 17
      Caption = 'Trames '#233'chang'#233'es avec l'#39'interface ou CDM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = CheckTrameClick
    end
    object CheckBoxAct: TCheckBox
      Left = 24
      Top = 48
      Width = 257
      Height = 17
      Caption = 'Ev'#232'vements actionneurs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = CheckBoxActClick
    end
    object CheckBoxAffFD: TCheckBox
      Left = 24
      Top = 96
      Width = 297
      Height = 17
      Caption = 'Fronts descendants des d'#233'tecteurs'
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 5
      OnClick = CheckBoxAffFDClick
    end
    object CheckBoxAffDebDecSig: TCheckBox
      Left = 24
      Top = 64
      Width = 265
      Height = 17
      Caption = 'Pilotage des d'#233'codeurs de signaux'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = CheckBoxAffDebDecSigClick
    end
  end
  object SaveDialog: TSaveDialog
    Left = 768
    Top = 488
  end
  object PopupMenuRE: TPopupMenu
    Left = 768
    Top = 432
    object copier1: TMenuItem
      Caption = 'copier'
      OnClick = copier1Click
    end
  end
end
