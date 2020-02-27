object FormDebug: TFormDebug
  Left = 302
  Top = 166
  BorderStyle = bsSingle
  Caption = 'Fen'#234'tre de d'#233'bug'
  ClientHeight = 639
  ClientWidth = 759
  Color = clWhite
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 464
    Top = 28
    Width = 108
    Height = 13
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
    Left = 448
    Top = 4
    Width = 131
    Height = 18
    Caption = 'Fen'#234'tre de d'#233'bug'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 448
    Top = 136
    Width = 105
    Height = 225
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
    Left = 592
    Top = 20
    Width = 73
    Height = 21
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
    Left = 560
    Top = 368
    Width = 185
    Height = 221
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
    Left = 448
    Top = 560
    Width = 97
    Height = 29
    Caption = 'Sauvegarder le log'
    TabOrder = 2
    OnClick = ButtonEcrLogClick
  end
  object MemoDebug: TMemo
    Left = 0
    Top = 0
    Width = 433
    Height = 625
    Lines.Strings = (
      'MemoDebug')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object CheckAffSig: TCheckBox
    Left = 448
    Top = 48
    Width = 297
    Height = 17
    Caption = 'Affichage du fonctionnement des signaux'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = CheckAffSigClick
  end
  object ButtonRazTampon: TButton
    Left = 448
    Top = 520
    Width = 97
    Height = 33
    Caption = 'Raz Tampon Ev'#232'nements'
    TabOrder = 5
    WordWrap = True
    OnClick = ButtonRazTamponClick
  end
  object ButtonCherche: TButton
    Left = 448
    Top = 480
    Width = 97
    Height = 33
    Caption = 'Chercher erreurs'
    TabOrder = 6
    OnClick = ButtonChercheClick
  end
  object MemoDet: TMemo
    Left = 560
    Top = 136
    Width = 185
    Height = 225
    Color = clMaroon
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object ButtonAffEvtChrono: TButton
    Left = 448
    Top = 440
    Width = 97
    Height = 33
    Caption = 'Affiche Evts chrono d'#233'tecteurs'
    TabOrder = 8
    WordWrap = True
    OnClick = ButtonAffEvtChronoClick
  end
  object CheckAffAffecTrains: TCheckBox
    Left = 448
    Top = 64
    Width = 289
    Height = 17
    Caption = 'Affichage d'#39'affectation des trains aux d'#233'tecteurs'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = CheckAffAffecTrainsClick
  end
  object CheckBoxTraceLIste: TCheckBox
    Left = 448
    Top = 80
    Width = 289
    Height = 17
    Caption = 'Affichage des '#233'valuations des routes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = CheckBoxTraceLIsteClick
  end
  object CheckTrame: TCheckBox
    Left = 448
    Top = 96
    Width = 281
    Height = 17
    Caption = 'Affichage des trames '#233'chang'#233'es avec l'#39'interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = CheckTrameClick
  end
  object ButtonCop: TButton
    Left = 448
    Top = 384
    Width = 97
    Height = 49
    Caption = 'Copie fen'#234'te principale dans debug'
    TabOrder = 12
    WordWrap = True
    OnClick = ButtonCopClick
  end
  object SaveDialog: TSaveDialog
    Left = 680
    Top = 8
  end
end
