object FormRouteTrain: TFormRouteTrain
  Left = 518
  Top = 183
  BorderStyle = bsDialog
  Caption = 'Liste des routes affect'#233'es aux trains'
  ClientHeight = 156
  ClientWidth = 580
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ImageTrainR: TImage
    Left = 328
    Top = 8
    Width = 241
    Height = 33
    ParentShowHint = False
    ShowHint = False
  end
  object LabelRoute: TLabel
    Left = 16
    Top = 48
    Width = 71
    Height = 13
    Caption = 'Route affect'#233'e'
  end
  object ComboBoxTrains: TComboBox
    Left = 16
    Top = 16
    Width = 225
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBoxTrainsChange
  end
  object ButtonQuitte: TButton
    Left = 8
    Top = 118
    Width = 89
    Height = 33
    Caption = 'Quitter'
    TabOrder = 1
    OnClick = ButtonQuitteClick
  end
  object RichEditRoute: TRichEdit
    Left = 8
    Top = 64
    Width = 569
    Height = 49
    Color = clNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    OnMouseDown = RichEditRouteMouseDown
  end
  object ButtonEfface: TButton
    Left = 480
    Top = 120
    Width = 97
    Height = 33
    Hint = 'Efface le trac'#233' du train s'#233'lectionn'#233' du TCO'
    Caption = 'Efface route du TCO'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    WordWrap = True
    OnClick = ButtonEffaceClick
  end
  object ButtonSupprime: TButton
    Left = 371
    Top = 120
    Width = 97
    Height = 33
    Hint = 'Supprime la route du train s'#233'lectionn'#233
    Caption = 'Supprimer la route du train'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    WordWrap = True
    OnClick = ButtonSupprimeClick
  end
  object ButtonRouler1Tr: TButton
    Left = 256
    Top = 120
    Width = 107
    Height = 33
    Hint = 'Roule le train s'#233'lectionn'#233' s'#39'il dispose d'#39'une route'
    Caption = 'Rouler le train'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    WordWrap = True
    OnClick = ButtonRouler1TrClick
  end
  object ButtonRoulerTsTrains: TButton
    Left = 168
    Top = 120
    Width = 75
    Height = 33
    Hint = 'Roule tous les trains  qui ont une route affect'#233'e'
    Caption = 'Rouler tous les trains'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    WordWrap = True
    OnClick = ButtonRoulerTsTrainsClick
  end
end
