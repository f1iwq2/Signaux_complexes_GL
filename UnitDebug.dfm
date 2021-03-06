object FormDebug: TFormDebug
  Left = 192
  Top = 290
  Width = 855
  Height = 817
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
  OnCreate = FormCreate
  DesignSize = (
    839
    779)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 655
    Top = 4
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
    Left = 487
    Top = 2
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
  object EditNivDebug: TEdit
    Left = 767
    Top = 2
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
    Left = 591
    Top = 320
    Width = 239
    Height = 225
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
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = MemoEvtDetChange
  end
  object ButtonEcrLog: TButton
    Left = 487
    Top = 312
    Width = 97
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Sauvegarder le log'
    TabOrder = 2
    OnClick = ButtonEcrLogClick
  end
  object ButtonRazTampon: TButton
    Left = 487
    Top = 344
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Raz Tampon Ev'#232'nements ---->'
    TabOrder = 3
    WordWrap = True
    OnClick = ButtonRazTamponClick
  end
  object ButtonCherche: TButton
    Left = 487
    Top = 280
    Width = 97
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Chercher erreurs'
    TabOrder = 4
    OnClick = ButtonChercheClick
  end
  object ButtonAffEvtChrono: TButton
    Left = 487
    Top = 240
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Affiche Evts d'#233'tecteurs et aig'
    TabOrder = 5
    WordWrap = True
    OnClick = ButtonAffEvtChronoClick
  end
  object ButtonCop: TButton
    Left = 487
    Top = 192
    Width = 97
    Height = 41
    Anchors = [akTop, akRight]
    Caption = 'Copie fen'#234'te principale dans debug'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = ButtonCopClick
  end
  object RichEdit: TRichEdit
    Left = 591
    Top = 160
    Width = 239
    Height = 153
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HideScrollBars = False
    ParentFont = False
    PopupMenu = PopupMenuRE
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
    OnChange = RichEditChange
  end
  object ButtonRazLog: TButton
    Left = 487
    Top = 384
    Width = 97
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Raz Tampon Log <-----'
    TabOrder = 8
    WordWrap = True
    OnClick = ButtonRazLogClick
  end
  object GroupBox1: TGroupBox
    Left = 485
    Top = 608
    Width = 353
    Height = 145
    Anchors = [akTop, akRight]
    Caption = 'Fonctions primitives'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 9
    object GroupBox3: TGroupBox
      Left = 8
      Top = 16
      Width = 337
      Height = 73
      Caption = 'Signal'
      TabOrder = 0
      object Label4: TLabel
        Left = 281
        Top = 10
        Width = 32
        Height = 13
        Caption = 'Signal:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ButtonSigSuiv: TButton
        Left = 8
        Top = 16
        Width = 57
        Height = 49
        Hint = 'Etat du signal suivant'
        Caption = 'Etat signal suivant'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        WordWrap = True
        OnClick = ButtonSigSuivClick
      end
      object ButtonCanSuivSig: TButton
        Left = 64
        Top = 16
        Width = 65
        Height = 49
        Hint = 'Renvoie l'#39'occupation du canton suivant le signal'
        Caption = 'Etat canton suivant signal'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        WordWrap = True
        OnClick = ButtonCanSuivSigClick
      end
      object EditSigSuiv: TEdit
        Left = 280
        Top = 32
        Width = 41
        Height = 21
        Hint = 'Indiquer l'#39'adresse du signal '
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object Button1: TButton
        Left = 128
        Top = 16
        Width = 81
        Height = 49
        Caption = 'Etat 3 cantons pr'#233'c'#233'dents signal'
        TabOrder = 3
        WordWrap = True
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 208
        Top = 16
        Width = 65
        Height = 49
        Caption = 'Cond Carr'#233' aiguillages'
        TabOrder = 4
        WordWrap = True
        OnClick = Button2Click
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 88
      Width = 337
      Height = 49
      Caption = 'D'#233'tecteur suivant'
      TabOrder = 1
      object ButtonDetSuiv: TButton
        Left = 16
        Top = 16
        Width = 185
        Height = 25
        Hint = 
          'Renvoie l'#39#233'l'#233'ment suivant aux deux '#233'l'#233'ments (d'#233'tecteurs ou aigui' +
          'llages) '
        Caption = 'D'#233'tecteur suivant aux '#233'l'#233'ments'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = ButtonDetSuivClick
      end
      object EditPrec: TEdit
        Left = 216
        Top = 18
        Width = 49
        Height = 21
        Hint = 'Element pr'#233'c'#233'dent'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object EditActuel: TEdit
        Left = 272
        Top = 18
        Width = 49
        Height = 21
        Hint = 'Element actuel'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 485
    Top = 20
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
    TabOrder = 10
    object CheckAffSig: TCheckBox
      Left = 8
      Top = 16
      Width = 161
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
      Left = 8
      Top = 32
      Width = 201
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
      Left = 8
      Top = 112
      Width = 185
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
      Left = 8
      Top = 80
      Width = 233
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
      Left = 8
      Top = 48
      Width = 153
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
      Left = 8
      Top = 96
      Width = 193
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
      Left = 8
      Top = 64
      Width = 193
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
  object RichDebug: TRichEdit
    Left = 8
    Top = 8
    Width = 470
    Height = 743
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'RichDebug')
    PopupMenu = PopupMenuRD
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 11
    OnChange = RichDebugChange
  end
  object GroupBox5: TGroupBox
    Left = 487
    Top = 552
    Width = 345
    Height = 49
    Anchors = [akTop, akRight]
    Caption = 'Simulation d'#233'tecteur'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 12
    object EditSimuDet: TEdit
      Left = 8
      Top = 16
      Width = 73
      Height = 21
      Hint = 'Adresse d'#39'un d'#233'tecteur'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object ButtonSimuDet0: TButton
      Left = 120
      Top = 16
      Width = 75
      Height = 25
      Caption = 'D'#233'tecteur '#224' 0'
      TabOrder = 1
      OnClick = ButtonSimuDet0Click
    end
    object ButtonSimuDet1: TButton
      Left = 232
      Top = 16
      Width = 75
      Height = 25
      Caption = 'D'#233'tecteur '#224' 1'
      TabOrder = 2
      OnClick = ButtonSimuDet1Click
    end
  end
  object ButtonRazTout: TButton
    Left = 488
    Top = 160
    Width = 97
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'RAZ tous trains'
    TabOrder = 13
    OnClick = ButtonRazToutClick
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
  object PopupMenuRD: TPopupMenu
    Left = 808
    Top = 360
    object Copier2: TMenuItem
      Caption = 'Copier'
      OnClick = Copier2Click
    end
  end
end
