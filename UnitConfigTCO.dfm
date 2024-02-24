object FormConfigTCO: TFormConfigTCO
  Left = 296
  Top = 201
  BorderStyle = bsDialog
  Caption = 'Configuration du TCO'
  ClientHeight = 420
  ClientWidth = 665
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
  PixelsPerInch = 96
  TextHeight = 13
  object LabelErreur: TLabel
    Left = 104
    Top = 384
    Width = 3
    Height = 13
  end
  object ButtonDessine: TButton
    Left = 16
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Redessine'
    TabOrder = 0
    OnClick = ButtonDessineClick
  end
  object GroupBox1: TGroupBox
    Left = 304
    Top = 8
    Width = 353
    Height = 281
    Caption = 'Couleurs du TCO'
    TabOrder = 1
    object Label5: TLabel
      Left = 21
      Top = 32
      Width = 84
      Height = 13
      Caption = 'Couleur des voies'
    end
    object ImageAig: TImage
      Left = 128
      Top = 16
      Width = 41
      Height = 41
      OnClick = ImageAigClick
    end
    object ImageFond: TImage
      Left = 128
      Top = 64
      Width = 41
      Height = 41
      OnClick = ImageFondClick
    end
    object Label6: TLabel
      Left = 33
      Top = 72
      Width = 75
      Height = 26
      Alignment = taRightJustify
      Caption = 'Couleur de fond par d'#233'faut'
      WordWrap = True
    end
    object ImageGrille: TImage
      Left = 128
      Top = 112
      Width = 41
      Height = 41
      OnClick = ImageGrilleClick
    end
    object Label7: TLabel
      Left = 31
      Top = 128
      Width = 74
      Height = 13
      Caption = 'couleur de grille'
    end
    object ImageDetAct: TImage
      Left = 128
      Top = 160
      Width = 41
      Height = 41
      OnClick = ImageDetActClick
    end
    object Label8: TLabel
      Left = 26
      Top = 176
      Width = 79
      Height = 13
      Caption = 'D'#233'tecteur activ'#233
    end
    object Label9: TLabel
      Left = 218
      Top = 176
      Width = 66
      Height = 13
      Caption = 'Canton activ'#233
    end
    object Imagecanton: TImage
      Left = 296
      Top = 160
      Width = 41
      Height = 41
      OnClick = ImagecantonClick
    end
    object Label10: TLabel
      Left = 56
      Top = 256
      Width = 258
      Height = 13
      Caption = 'Cliquez sur l'#39'ic'#244'ne pour changer la couleur de l'#39#233'l'#233'ment'
    end
    object ImageTexte: TImage
      Left = 296
      Top = 16
      Width = 41
      Height = 41
      OnClick = ImageTexteClick
    end
    object Label11: TLabel
      Left = 197
      Top = 24
      Width = 87
      Height = 13
      Caption = 'Couleur des textes'
    end
    object Label12: TLabel
      Left = 192
      Top = 40
      Width = 93
      Height = 13
      Caption = 'statiques par d'#233'faut'
    end
    object ImageQuai: TImage
      Left = 296
      Top = 64
      Width = 41
      Height = 41
      OnClick = ImageQuaiClick
    end
    object Label13: TLabel
      Left = 214
      Top = 80
      Width = 74
      Height = 13
      Caption = 'Couleur de quai'
    end
    object Label1: TLabel
      Left = 184
      Top = 120
      Width = 102
      Height = 26
      Alignment = taRightJustify
      Caption = 'Couleur des pieds de signaux'
      WordWrap = True
    end
    object ImagePiedFeu: TImage
      Left = 296
      Top = 112
      Width = 41
      Height = 41
      OnClick = ImagePiedFeuClick
    end
    object CheckCouleur: TCheckBox
      Left = 64
      Top = 224
      Width = 281
      Height = 17
      Caption = 'Couleur du canton activ'#233' par la couleur du train'
      TabOrder = 0
      OnClick = CheckCouleurClick
    end
  end
  object Memo1: TMemo
    Left = 304
    Top = 360
    Width = 353
    Height = 49
    BevelInner = bvLowered
    BevelKind = bkFlat
    BorderStyle = bsNone
    Lines.Strings = (
      
        'Si vous d'#233'finissez un nombre de cellules en horizontal ou en ver' +
        'tical plus '
      
        'petit(s) que l'#39'actuel(s), alors le TCO sera tronqu'#233', et les '#233'l'#233'm' +
        'ents tronqu'#233's '
      'seront perdus '#224' la prochaine sauvegarde.')
    ReadOnly = True
    TabOrder = 2
  end
  object BitBtnOk: TBitBtn
    Left = 208
    Top = 384
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = BitBtnOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 304
    Top = 296
    Width = 353
    Height = 57
    Caption = 'Graphisme de tous les TCOs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object RadioButtonCourbes: TRadioButton
    Left = 392
    Top = 328
    Width = 113
    Height = 17
    Caption = 'Lignes courbes'
    TabOrder = 5
    OnClick = RadioButtonCourbesClick
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 89
    Caption = 'Configuration du TCO '
    TabOrder = 6
    object Label3: TLabel
      Left = 16
      Top = 20
      Width = 156
      Height = 13
      Caption = 'Nombre de cellules en horizontal:'
    end
    object Label4: TLabel
      Left = 16
      Top = 44
      Width = 145
      Height = 13
      Caption = 'Nombre de cellules en vertical:'
    end
    object labelMaxX: TLabel
      Left = 224
      Top = 20
      Width = 49
      Height = 13
      Caption = 'labelMaxX'
    end
    object labelMaxY: TLabel
      Left = 224
      Top = 44
      Width = 49
      Height = 13
      Caption = 'labelMaxY'
    end
    object Label16: TLabel
      Left = 152
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Ouvrir sur '#233'cran'
    end
    object EditNbCellX: TEdit
      Left = 176
      Top = 16
      Width = 41
      Height = 21
      TabOrder = 0
      Text = 'EditNbCellX'
      OnChange = EditNbCellXChange
    end
    object EditNbCellY: TEdit
      Left = 176
      Top = 40
      Width = 41
      Height = 21
      TabOrder = 1
      Text = 'EditNbCellY'
    end
    object CheckDessineGrille: TCheckBox
      Left = 16
      Top = 64
      Width = 97
      Height = 17
      Caption = 'dessine grille'
      TabOrder = 2
      OnClick = CheckDessineGrilleClick
    end
    object EditEcran: TEdit
      Left = 240
      Top = 64
      Width = 25
      Height = 21
      Hint = 'Num'#233'ro de l'#39#233'cran sur lequel le TCO s'#39'ouvrira'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = 'EditEcran'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 104
    Width = 289
    Height = 273
    Caption = 'Configuration de tous les TCOs'
    TabOrder = 7
    object Ratio: TLabel
      Left = 8
      Top = 208
      Width = 25
      Height = 13
      Caption = 'Ratio'
    end
    object Label14: TLabel
      Left = 72
      Top = 208
      Width = 17
      Height = 13
      Caption = '/10'
    end
    object Label15: TLabel
      Left = 8
      Top = 184
      Width = 86
      Height = 13
      Caption = 'Nombre de TCO : '
    end
    object Label2: TLabel
      Left = 104
      Top = 184
      Width = 64
      Height = 13
      Caption = '(10 maximum)'
    end
    object Label17: TLabel
      Left = 146
      Top = 202
      Width = 49
      Height = 26
      Alignment = taRightJustify
      Caption = 'Epaisseur des voies'
      WordWrap = True
    end
    object Label18: TLabel
      Left = 208
      Top = 184
      Width = 63
      Height = 13
      Caption = '2               10'
    end
    object StringGridTCO: TStringGrid
      Left = 8
      Top = 16
      Width = 273
      Height = 161
      ColCount = 3
      FixedColor = clAppWorkSpace
      RowCount = 11
      TabOrder = 0
      ColWidths = (
        64
        64
        64)
      RowHeights = (
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24)
    end
    object EditRatio: TEdit
      Left = 40
      Top = 205
      Width = 25
      Height = 21
      Hint = 'Rapport X/Y d'#39'affichage des cellules'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'EditRatio'
    end
    object CheckBoxCreerEvt: TCheckBox
      Left = 8
      Top = 240
      Width = 273
      Height = 17
      Hint = 'Pour simuler l'#39'action d'#39'une locomotive sur un d'#233'tecteur'
      Caption = 'Cr'#233'er '#233'v'#232'nement d'#233'tecteur sur double clic d'#233'tecteur'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = CheckBoxCreerEvtClick
    end
    object TrackBarEpaisseur: TTrackBar
      Left = 200
      Top = 200
      Width = 81
      Height = 33
      Hint = 'Change les '#233'paisseurs des voies'
      Min = 2
      ParentShowHint = False
      Position = 2
      ShowHint = True
      TabOrder = 3
      TickMarks = tmTopLeft
      OnChange = TrackBarEpaisseurChange
    end
  end
  object RadioButtonLignes: TRadioButton
    Left = 392
    Top = 312
    Width = 113
    Height = 17
    Caption = 'Lignes bris'#233'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = RadioButtonLignesClick
  end
  object ColorDialog1: TColorDialog
    OnShow = ColorDialog1Show
    Left = 272
  end
end
