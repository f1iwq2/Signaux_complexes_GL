object FormConfigTCO: TFormConfigTCO
  Left = 311
  Top = 218
  BorderStyle = bsDialog
  Caption = 'Configuration du TCO'
  ClientHeight = 264
  ClientWidth = 618
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
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 83
    Height = 13
    Caption = 'Taille des cellules'
  end
  object Label2: TLabel
    Left = 176
    Top = 16
    Width = 5
    Height = 13
    Caption = 'x'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 156
    Height = 13
    Caption = 'Nombre de cellules en horizontal:'
  end
  object Label4: TLabel
    Left = 16
    Top = 80
    Width = 145
    Height = 13
    Caption = 'Nombre de cellules en vertical:'
  end
  object LabelErreur: TLabel
    Left = 302
    Top = 248
    Width = 3
    Height = 13
  end
  object ButtonOK: TButton
    Left = 168
    Top = 224
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object EditTailleCellX: TEdit
    Left = 128
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 1
    Text = 'EditTailleCellX'
  end
  object EditTailleCellY: TEdit
    Left = 192
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 2
    Text = 'EditTailleCellY'
  end
  object ButtonDessine: TButton
    Left = 16
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Redessine'
    TabOrder = 3
    OnClick = ButtonDessineClick
  end
  object CheckDessineGrille: TCheckBox
    Left = 16
    Top = 104
    Width = 105
    Height = 17
    Caption = 'dessine grille'
    TabOrder = 4
  end
  object EditNbCellX: TEdit
    Left = 184
    Top = 56
    Width = 49
    Height = 21
    TabOrder = 5
    Text = 'EditNbCellX'
  end
  object EditNbCellY: TEdit
    Left = 184
    Top = 80
    Width = 49
    Height = 21
    TabOrder = 6
    Text = 'EditNbCellY'
  end
  object GroupBox1: TGroupBox
    Left = 256
    Top = 8
    Width = 353
    Height = 233
    Caption = 'Couleurs '
    TabOrder = 7
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
      Left = 30
      Top = 80
      Width = 75
      Height = 13
      Caption = 'Couleur de fond'
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
      Top = 208
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
      Left = 240
      Top = 40
      Width = 42
      Height = 13
      Caption = 'statiques'
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 128
    Width = 241
    Height = 81
    BevelInner = bvLowered
    BevelKind = bkFlat
    BorderStyle = bsNone
    Lines.Strings = (
      'Si vous d'#233'finissez un nombre de cellules en '
      'horizontal ou en vertical plus petit(s) que l'#39'actuel'
      '(s), alors le TCO sera tronqu'#233', et les '#233'l'#233'ments '
      'tronqu'#233's seront perdus '#224' la prochaine '
      'sauvegarde.')
    ReadOnly = True
    TabOrder = 8
  end
  object ColorDialog1: TColorDialog
    OnShow = ColorDialog1Show
    Left = 48
    Top = 24
  end
end
