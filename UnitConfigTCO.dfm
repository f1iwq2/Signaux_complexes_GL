object FormConfigTCO: TFormConfigTCO
  Left = 311
  Top = 218
  BorderStyle = bsDialog
  Caption = 'Configuration du TCO'
  ClientHeight = 277
  ClientWidth = 665
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
  object Label3: TLabel
    Left = 16
    Top = 44
    Width = 156
    Height = 13
    Caption = 'Nombre de cellules en horizontal:'
  end
  object Label4: TLabel
    Left = 16
    Top = 68
    Width = 145
    Height = 13
    Caption = 'Nombre de cellules en vertical:'
  end
  object LabelErreur: TLabel
    Left = 16
    Top = 216
    Width = 3
    Height = 13
  end
  object LabelMaxX: TLabel
    Left = 235
    Top = 44
    Width = 53
    Height = 13
    Caption = 'LabelMaxX'
  end
  object LabelMaxY: TLabel
    Left = 235
    Top = 68
    Width = 53
    Height = 13
    Caption = 'LabelMaxY'
  end
  object Ratio: TLabel
    Left = 16
    Top = 16
    Width = 25
    Height = 13
    Caption = 'Ratio'
  end
  object Label14: TLabel
    Left = 80
    Top = 16
    Width = 17
    Height = 13
    Caption = '/10'
  end
  object ButtonDessine: TButton
    Left = 16
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Redessine'
    TabOrder = 0
    OnClick = ButtonDessineClick
  end
  object CheckDessineGrille: TCheckBox
    Left = 160
    Top = 16
    Width = 97
    Height = 17
    Caption = 'dessine grille'
    TabOrder = 1
  end
  object EditNbCellX: TEdit
    Left = 184
    Top = 40
    Width = 49
    Height = 21
    TabOrder = 2
    Text = 'EditNbCellX'
  end
  object EditNbCellY: TEdit
    Left = 184
    Top = 64
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'EditNbCellY'
  end
  object GroupBox1: TGroupBox
    Left = 304
    Top = 8
    Width = 353
    Height = 265
    Caption = 'Couleurs '
    TabOrder = 4
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
      Left = 48
      Top = 240
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
      Left = 56
      Top = 208
      Width = 281
      Height = 17
      Caption = 'Couleur du canton activ'#233' par la couleur du train'
      TabOrder = 0
    end
  end
  object Memo1: TMemo
    Left = 16
    Top = 168
    Width = 273
    Height = 65
    BevelInner = bvLowered
    BevelKind = bkFlat
    BorderStyle = bsNone
    Lines.Strings = (
      'Si vous d'#233'finissez un nombre de cellules en '
      'horizontal ou en vertical plus petit(s) que l'#39'actuel(s), '
      'alors le TCO sera tronqu'#233', et les '#233'l'#233'ments tronqu'#233's '
      'seront perdus '#224' la prochaine sauvegarde.')
    ReadOnly = True
    TabOrder = 5
  end
  object EditRatio: TEdit
    Left = 48
    Top = 13
    Width = 25
    Height = 21
    Hint = 'Rapport X/Y d'#39'affichage des cellules'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = 'EditRatio'
  end
  object BitBtnOk: TBitBtn
    Left = 208
    Top = 240
    Width = 75
    Height = 25
    TabOrder = 7
    OnClick = BitBtnOkClick
    Kind = bkOK
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 96
    Width = 273
    Height = 57
    Caption = 'Graphisme'
    TabOrder = 8
  end
  object RadioButtonLignes: TRadioButton
    Left = 40
    Top = 112
    Width = 113
    Height = 17
    Caption = 'Lignes bris'#233'es'
    TabOrder = 9
  end
  object RadioButtonCourbes: TRadioButton
    Left = 40
    Top = 128
    Width = 113
    Height = 17
    Caption = 'Lignes courbes'
    TabOrder = 10
  end
  object ColorDialog1: TColorDialog
    OnShow = ColorDialog1Show
    Left = 272
    Top = 8
  end
end
