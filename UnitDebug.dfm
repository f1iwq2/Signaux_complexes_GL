object FormDebug: TFormDebug
  Left = 258
  Top = 1
  VertScrollBar.Increment = 67
  VertScrollBar.Tracking = True
  VertScrollBar.Visible = False
  AutoScroll = False
  Caption = 'Fen'#234'tre de d'#233'bug'
  ClientHeight = 662
  ClientWidth = 878
  Color = clWindow
  TransparentColorValue = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    878
    662)
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBoxDebug: TScrollBox
    Left = 0
    Top = 0
    Width = 872
    Height = 677
    HorzScrollBar.Visible = False
    VertScrollBar.Position = 96
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    DesignSize = (
      851
      673)
    object LabelTitreDebug: TLabel
      Left = 475
      Top = -88
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
    object Label1: TLabel
      Left = 627
      Top = -86
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
    object RichDebug: TRichEdit
      Left = 0
      Top = -96
      Width = 454
      Height = 753
      Anchors = [akLeft, akTop, akRight]
      Color = clMaroon
      Lines.Strings = (
        'RichDebug')
      PopupMenu = PopupMenuRD
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = RichDebugChange
    end
    object ButtonRazTout: TButton
      Left = 465
      Top = 120
      Width = 97
      Height = 25
      Hint = 
        'Supprime les trains d'#233'tect'#233's ou en cas de nouveau RUN, permet de' +
        ' partir de 0'
      Anchors = [akTop, akRight]
      Caption = 'RAZ tous trains'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = ButtonRazToutClick
    end
    object ButtonCop: TButton
      Left = 465
      Top = 152
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
      TabOrder = 2
      WordWrap = True
      OnClick = ButtonCopClick
    end
    object ButtonAffEvtChrono: TButton
      Left = 465
      Top = 200
      Width = 97
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Affiche Evts d'#233'tecteurs et aig'
      TabOrder = 3
      WordWrap = True
      OnClick = ButtonAffEvtChronoClick
    end
    object ButtonCherche: TButton
      Left = 465
      Top = 240
      Width = 97
      Height = 25
      Hint = 'Cherche la cha'#238'ne "erreur"'
      Anchors = [akTop, akRight]
      Caption = 'Chercher erreurs'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = ButtonChercheClick
    end
    object ButtonEcrLog: TButton
      Left = 465
      Top = 88
      Width = 97
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Sauvegarder le log'
      TabOrder = 5
      OnClick = ButtonEcrLogClick
    end
    object ButtonRazTampon: TButton
      Left = 465
      Top = 272
      Width = 97
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Raz Tampon Ev'#232'nements ---->'
      TabOrder = 6
      WordWrap = True
      OnClick = ButtonRazTamponClick
    end
    object ButtonRazLog: TButton
      Left = 465
      Top = 312
      Width = 97
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Raz Tampon Log <-----'
      TabOrder = 7
      WordWrap = True
      OnClick = ButtonRazLogClick
    end
    object MemoEvtDet: TRichEdit
      Left = 570
      Top = 90
      Width = 272
      Height = 263
      Anchors = [akTop, akRight]
      Color = clBlack
      ScrollBars = ssVertical
      TabOrder = 8
      OnChange = MemoEvtDetChange
    end
    object GroupBox5: TGroupBox
      Left = 462
      Top = 360
      Width = 380
      Height = 57
      Anchors = [akTop, akRight]
      Caption = 'Simulation d'#233'tecteur / actionneur'
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 9
      object EditSimuDet: TEdit
        Left = 16
        Top = 24
        Width = 33
        Height = 21
        Hint = 'Adresse d'#39'un d'#233'tecteur'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object ButtonSimuDet0: TButton
        Left = 72
        Top = 16
        Width = 65
        Height = 33
        Caption = 'D'#233'tecteur '#224' 0'
        TabOrder = 1
        WordWrap = True
        OnClick = ButtonSimuDet0Click
      end
      object ButtonSimuDet1: TButton
        Left = 152
        Top = 16
        Width = 65
        Height = 33
        Caption = 'D'#233'tecteur '#224' 1'
        TabOrder = 2
        WordWrap = True
        OnClick = ButtonSimuDet1Click
      end
      object ButtonSimuAct0: TButton
        Left = 224
        Top = 16
        Width = 65
        Height = 33
        Caption = 'Actionneur '#224' 0'
        TabOrder = 3
        WordWrap = True
        OnClick = ButtonSimuAct0Click
      end
      object ButtonSimuAct1: TButton
        Left = 296
        Top = 16
        Width = 65
        Height = 33
        Caption = 'Actionneur '#224' 1'
        TabOrder = 4
        WordWrap = True
        OnClick = ButtonSimuAct1Click
      end
    end
    object GroupBox6: TGroupBox
      Left = 462
      Top = 424
      Width = 380
      Height = 52
      Anchors = [akTop, akRight]
      Caption = 'Sorties'
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 10
      object Label3: TLabel
        Left = 16
        Top = 24
        Width = 38
        Height = 13
        Caption = 'Adresse'
      end
      object Label5: TLabel
        Left = 104
        Top = 24
        Width = 27
        Height = 13
        Caption = 'Sortie'
      end
      object EditAdresse: TEdit
        Left = 64
        Top = 18
        Width = 33
        Height = 21
        Hint = 'Adresse d'#39'accessoire'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object EditSortie: TEdit
        Left = 136
        Top = 18
        Width = 25
        Height = 21
        Hint = 'Sortie 1 ou 2'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object Button1: TButton
        Left = 224
        Top = 16
        Width = 49
        Height = 25
        Hint = 
          'Mise '#224' 1 de la sortie - attention peut d'#233'truire les moteurs '#224' bo' +
          'bine'
        Caption = 'Mise '#224' 1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button0: TButton
        Left = 280
        Top = 16
        Width = 49
        Height = 25
        Hint = 'Mise '#224' 0 de la sortie'
        Caption = 'Mise '#224' 0'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button0Click
      end
    end
    object GroupBoxPrim: TGroupBox
      Left = 464
      Top = 488
      Width = 378
      Height = 185
      Anchors = [akTop, akRight]
      Caption = 'Fonctions primitives'
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 11
      object GroupBox3: TGroupBox
        Left = 8
        Top = 16
        Width = 361
        Height = 73
        Caption = 'Signal'
        TabOrder = 0
        object Label4: TLabel
          Left = 321
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
          Width = 49
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
          Left = 56
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
          Left = 320
          Top = 32
          Width = 33
          Height = 21
          Hint = 'Indiquer l'#39'adresse du signal '
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object ButtonCP: TButton
          Left = 120
          Top = 16
          Width = 81
          Height = 49
          Hint = 'Renvoie l'#39#233'tat des 3 cantons pr'#233'c'#233'dents au signal'
          Caption = 'Etat 3 cantons pr'#233'c'#233'dents signal'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          WordWrap = True
          OnClick = ButtonCPClick
        end
        object Button2: TButton
          Left = 200
          Top = 16
          Width = 65
          Height = 49
          Hint = 
            'Teste si la position des aiguillages en aval du signal doivent i' +
            'nsiquer un carr'#233' sur le signal'
          Caption = 'Cond Carr'#233' aiguillages'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          WordWrap = True
          OnClick = Button2Click
        end
        object ButtonAigDevie: TButton
          Left = 264
          Top = 16
          Width = 57
          Height = 49
          Hint = 'Test si des aiguillages sont d'#233'vi'#233's apr'#232's le signal'
          Caption = 'Aig d'#233'vi'#233' apr'#232's signal'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          WordWrap = True
          OnClick = ButtonAigDevieClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 96
        Width = 361
        Height = 81
        Caption = 'D'#233'tecteur/'#233'l'#233'ment suivant'
        TabOrder = 1
        object ButtonDetSuiv: TButton
          Left = 16
          Top = 16
          Width = 185
          Height = 25
          Hint = 
            'Renvoie le d'#233'tecteur suivant aux deux '#233'l'#233'ments (d'#233'tecteurs ou ai' +
            'guillages) '
          Caption = 'D'#233'tecteur suivant aux '#233'l'#233'ments'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ButtonDetSuivClick
        end
        object EditPrec: TEdit
          Left = 216
          Top = 34
          Width = 49
          Height = 21
          Hint = 'Element pr'#233'c'#233'dent'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object EditActuel: TEdit
          Left = 272
          Top = 34
          Width = 49
          Height = 21
          Hint = 'Element actuel'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object ButtonElSuiv: TButton
          Left = 16
          Top = 48
          Width = 185
          Height = 25
          Hint = 
            'Renvoie l'#39#233'l'#233'ment suivant aux deux '#233'l'#233'ments contigus (d'#233'tecteurs' +
            ' ou aiguillages) '
          Caption = 'Element suivant aux '#233'l'#233'ments'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = ButtonElSuivClick
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 466
      Top = -68
      Width = 376
      Height = 149
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
      TabOrder = 12
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
        Width = 289
        Height = 17
        Caption = 'Ev'#232'nements d'#233'tecteurs, aiguillages et actionneurs'
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
        Top = 128
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
        Top = 96
        Width = 233
        Height = 17
        Hint = 
          'Affiche les trames de la centrale XpressNet ou les trames CDM-Ra' +
          'il (COM_IP)'
        Caption = 'Trames '#233'chang'#233'es avec l'#39'interface ou CDM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = CheckTrameClick
      end
      object CheckBoxAffFD: TCheckBox
        Left = 8
        Top = 112
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
        TabOrder = 4
        OnClick = CheckBoxAffFDClick
      end
      object CheckBoxAffDebDecSig: TCheckBox
        Left = 8
        Top = 80
        Width = 193
        Height = 17
        Caption = 'Pilotage des d'#233'codeurs de signaux'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = CheckBoxAffDebDecSigClick
      end
      object EditDebugSignal: TEdit
        Left = 168
        Top = 12
        Width = 33
        Height = 21
        Hint = 
          'Adresse du signal seul '#224' surveiller ou si 0 surveille tous les s' +
          'ignaux'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnChange = EditDebugSignalChange
      end
      object CheckBoxTiers: TCheckBox
        Left = 8
        Top = 64
        Width = 273
        Height = 17
        Hint = 
          'N'#233'cessite d'#39'activer les services "signaux" et "position des trai' +
          'ns" dans la configuration g'#233'n'#233'rale'
        Caption = 'Ev'#232'vements tiers (signaux et position des trains)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = CheckBoxTiersClick
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 48
        Width = 177
        Height = 17
        Caption = 'Duplication Fen'#234'tre evts vers log'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = CheckBox1Click
      end
      object CheckDebugTCO: TCheckBox
        Left = 248
        Top = 128
        Width = 121
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Debug TCO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = CheckDebugTCOClick
      end
      object CheckDetSIg: TCheckBox
        Left = 248
        Top = 112
        Width = 121
        Height = 17
        Hint = 'Affichage des '#233'v'#232'nements d'#233'tecteurs et signaux avec tick'
        Alignment = taLeftJustify
        Caption = 'Det et signaux'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = CheckDetSIgClick
      end
      object CheckBoxPrinc: TCheckBox
        Left = 248
        Top = 96
        Width = 121
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Proc Principales'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = CheckBoxPrincClick
      end
    end
    object EditNivDebug: TEdit
      Left = 751
      Top = -88
      Width = 49
      Height = 21
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      Text = 'EditNivDebug'
      OnKeyPress = EditNivDebugKeyPress
    end
  end
  object SaveDialog: TSaveDialog
    Left = 752
    Top = 72
  end
  object PopupMenuRE: TPopupMenu
    Left = 752
    Top = 32
    object copier1: TMenuItem
      Caption = 'copier'
    end
  end
  object PopupMenuRD: TPopupMenu
    Left = 752
    Top = 104
    object Copier2: TMenuItem
      Caption = 'Copier'
      OnClick = Copier2Click
    end
  end
end
