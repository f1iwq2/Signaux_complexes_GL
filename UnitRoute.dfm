object FormRoute: TFormRoute
  Left = 201
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Route'
  ClientHeight = 257
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
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfo: TLabel
    Left = 16
    Top = 16
    Width = 324
    Height = 13
    Caption = 
      'Cliquer sur une route pour la visualiser sur le TCO et l'#39'affecte' +
      'r au train'
  end
  object LabelNombre: TLabel
    Left = 19
    Top = 192
    Width = 29
    Height = 13
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
    Top = 80
    Width = 609
    Height = 105
    Hint = 'S'#233'lectionne une route pour l'#39'affecter au train courant'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyDown = ListBoxRoutesKeyDown
    OnMouseDown = ListBoxRoutesMouseDown
  end
  object ButtonEfface: TButton
    Left = 424
    Top = 216
    Width = 97
    Height = 33
    Hint = 'Efface la route du tco'
    Caption = 'Efface route du TCO'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    WordWrap = True
    OnClick = ButtonEffaceClick
  end
  object ButtonQuitte: TButton
    Left = 16
    Top = 216
    Width = 89
    Height = 33
    Caption = 'Quitter'
    TabOrder = 2
    OnClick = ButtonQuitteClick
  end
  object ButtonDetail: TButton
    Left = 320
    Top = 216
    Width = 97
    Height = 33
    Hint = 'D'#233'tail route'
    Caption = 'D'#233'tail route'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = ButtonDetailClick
  end
  object ButtonRAZ: TButton
    Left = 528
    Top = 216
    Width = 97
    Height = 33
    Hint = 'Annule toutes les routes pour ce train'
    Caption = 'D'#233'valider routes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = ButtonRAZClick
  end
  object ComboBoxTrains: TComboBox
    Left = 16
    Top = 48
    Width = 601
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    Visible = False
  end
  object ButtonFenPil: TButton
    Left = 232
    Top = 216
    Width = 83
    Height = 33
    Hint = 'Ouvre la fen'#234'tre de pilotage des trains'
    Caption = 'Fen'#234'tre de pilotage'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    WordWrap = True
    OnClick = ButtonFenPilClick
  end
end
