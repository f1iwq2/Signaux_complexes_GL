object FormRoute: TFormRoute
  Left = 338
  Top = 290
  BorderStyle = bsDialog
  Caption = 'Route'
  ClientHeight = 298
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    634
    298)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfo: TLabel
    Left = 8
    Top = 8
    Width = 324
    Height = 13
    Caption = 
      'Cliquer sur une route pour la visualiser sur le TCO et l'#39'affecte' +
      'r au train'
  end
  object LabelNombre: TLabel
    Left = 19
    Top = 234
    Width = 29
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Route'
  end
  object ImageTrainR: TImage
    Left = 376
    Top = 8
    Width = 241
    Height = 33
    ParentShowHint = False
    ShowHint = False
  end
  object ListBoxRoutes: TListBox
    Left = 16
    Top = 116
    Width = 609
    Height = 114
    Hint = 'S'#233'lectionne une route pour l'#39'affecter au train courant'
    Anchors = [akLeft, akBottom]
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenuR
    ShowHint = True
    TabOrder = 0
    OnDblClick = ListBoxRoutesDblClick
    OnDrawItem = ListBoxRoutesDrawItem
    OnKeyDown = ListBoxRoutesKeyDown
    OnMouseDown = ListBoxRoutesMouseDown
  end
  object ButtonEfface: TButton
    Left = 424
    Top = 258
    Width = 97
    Height = 33
    Hint = 'Efface la route du tco'
    Anchors = [akLeft, akBottom]
    Caption = 'Efface route du TCO'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    WordWrap = True
    OnClick = ButtonEffaceClick
  end
  object ButtonQuitte: TButton
    Left = 16
    Top = 259
    Width = 89
    Height = 32
    Anchors = [akLeft, akBottom]
    Caption = 'Quitter'
    TabOrder = 2
    OnClick = ButtonQuitteClick
  end
  object ButtonDetail: TButton
    Left = 320
    Top = 258
    Width = 97
    Height = 33
    Hint = 'D'#233'tail route'
    Anchors = [akLeft, akBottom]
    Caption = 'D'#233'tail route'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = ButtonDetailClick
  end
  object ButtonRAZ: TButton
    Left = 528
    Top = 258
    Width = 97
    Height = 33
    Hint = 'Annule toutes les routes pour ce train'
    Anchors = [akLeft, akBottom]
    Caption = 'D'#233'valider routes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = ButtonRAZClick
  end
  object ButtonFenPil: TButton
    Left = 224
    Top = 258
    Width = 83
    Height = 33
    Hint = 'Ouvre la fen'#234'tre de pilotage des trains'
    Anchors = [akLeft, akBottom]
    Caption = 'Choisir cette route'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    WordWrap = True
    OnClick = ButtonFenPilClick
  end
  object Button1: TButton
    Left = 128
    Top = 258
    Width = 75
    Height = 33
    Hint = 
      'Affiche la route sous forme d'#39'une progression du train sur cette' +
      ' route'
    Anchors = [akLeft, akBottom]
    Caption = 'Parcours route'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    WordWrap = True
    OnClick = ButtonParcours
  end
  object ButtonRaf: TButton
    Left = 384
    Top = 78
    Width = 89
    Height = 25
    Hint = 
      'R'#233'affiche la liste des routes en fonction des filtres, d'#39'apr'#232's l' +
      'a liste des routes trouv'#233'es'
    Caption = 'Rafra'#238'chir la liste'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = ButtonRafClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 32
    Width = 321
    Height = 65
    Caption = 'Filtrage des routes'
    TabOrder = 8
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 189
      Height = 13
      Caption = 'Obligation de passer par le(s) canton(s) :'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 194
      Height = 13
      Caption = 'Interdiction de passer par le(s) canton(s) :'
    end
    object EditObligeCanton: TEdit
      Left = 216
      Top = 20
      Width = 81
      Height = 21
      Hint = 'Num'#233'ro de cantons s'#233'par'#233's par des virgules (10 maxi)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = EditObligeCantonChange
    end
    object EditInterditCanton: TEdit
      Left = 216
      Top = 38
      Width = 81
      Height = 21
      Hint = 'Num'#233'ro de cantons s'#233'par'#233's par des virgules (10 maxi)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = EditInterditCantonChange
    end
  end
  object ButtonTrouver: TButton
    Left = 496
    Top = 78
    Width = 97
    Height = 25
    Hint = 'Recalcule les routes en fonction des filtres'
    Caption = 'Trouver les routes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = ButtonTrouverClick
  end
  object CheckBoxRoutesLongues: TCheckBox
    Left = 384
    Top = 54
    Width = 209
    Height = 17
    Caption = 'Afficher les routes longues (en gras)'
    TabOrder = 10
    OnClick = CheckBoxRoutesLonguesClick
  end
  object CheckBoxDebugRoutes: TCheckBox
    Left = 552
    Top = 232
    Width = 65
    Height = 17
    Caption = 'Debug'
    TabOrder = 11
  end
  object PopupMenuR: TPopupMenu
    OnPopup = PopupMenuRPopup
    Left = 344
    Top = 8
    object Choisircetteroute1: TMenuItem
      Caption = 'Choisir cette route'
      OnClick = Choisircetteroute1Click
    end
  end
end
