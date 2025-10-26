object FormRouteTrain: TFormRouteTrain
  Left = 202
  Top = 190
  BorderStyle = bsDialog
  Caption = 'Liste des routes affect'#233'es et m'#233'moris'#233'es aux trains'
  ClientHeight = 194
  ClientWidth = 850
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 849
    Height = 193
    Caption = 'Panel1'
    Color = clBtnShadow
    TabOrder = 3
    object LabelRoute: TLabel
      Left = 8
      Top = 120
      Width = 71
      Height = 13
      Caption = 'Route affect'#233'e'
    end
    object ImageTrainR: TImage
      Left = 8
      Top = 8
      Width = 241
      Height = 33
      ParentShowHint = False
      ShowHint = False
    end
    object LabelID: TLabel
      Left = 13
      Top = 96
      Width = 68
      Height = 13
      Caption = 'Id de la route :'
    end
  end
  object PageControlRoutes: TPageControl
    Left = 256
    Top = 8
    Width = 585
    Height = 177
    ActivePage = TabSheetRM
    TabOrder = 1
    object TabSheetRA: TTabSheet
      Caption = 'Route affect'#233'e'
      object LabelRC: TLabel
        Left = 8
        Top = 16
        Width = 154
        Height = 13
        Caption = 'Route courante affect'#233'e au train'
      end
      object ButtonEfface: TButton
        Left = 384
        Top = 108
        Width = 97
        Height = 33
        Hint = 'Efface le trac'#233' du train s'#233'lectionn'#233' du TCO'
        Caption = 'Efface route du TCO'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        WordWrap = True
        OnClick = ButtonEffaceClick
      end
      object ButtonSupprime: TButton
        Left = 275
        Top = 108
        Width = 97
        Height = 33
        Hint = 'Supprime la route du train s'#233'lectionn'#233
        Caption = 'Supprimer la route du train'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        WordWrap = True
        OnClick = ButtonSupprimeClick
      end
      object ButtonRouler1Tr: TButton
        Left = 184
        Top = 108
        Width = 83
        Height = 33
        Hint = 'Roule le train s'#233'lectionn'#233' s'#39'il dispose d'#39'une route'
        Caption = 'Rouler le train'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        WordWrap = True
        OnClick = ButtonRouler1TrClick
      end
      object ButtonRoulerTsTrains: TButton
        Left = 96
        Top = 108
        Width = 75
        Height = 33
        Hint = 'Roule tous les trains  qui ont une route affect'#233'e'
        Caption = 'Rouler tous les trains'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        WordWrap = True
        OnClick = ButtonRoulerTsTrainsClick
      end
      object ButtonSauveRoute: TButton
        Left = 8
        Top = 108
        Width = 81
        Height = 33
        Hint = 
          'Sauve la route dans la liste des routes m'#233'moris'#233'es si elle est u' +
          'nique et sauvegarde la configuration'
        Caption = 'Sauve route'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ButtonSauveRouteClick
      end
      object ListBoxRA: TListBox
        Left = 8
        Top = 40
        Width = 561
        Height = 49
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 5
        OnMouseDown = ListBoxRAMouseDown
      end
      object CheckBoxSIRA: TCheckBox
        Left = 464
        Top = 14
        Width = 97
        Height = 17
        Hint = 'Consigne inverse du train'
        Caption = 'Sens inverse'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = CheckBoxSIRAClick
      end
    end
    object TabSheetRM: TTabSheet
      Caption = 'Routes m'#233'moris'#233'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object LabelRM: TLabel
        Left = 8
        Top = 8
        Width = 135
        Height = 13
        Caption = 'Route m'#233'moris'#233'e de ce train'
      end
      object Label1: TLabel
        Left = 264
        Top = 8
        Width = 78
        Height = 13
        Caption = 'Nom de la route:'
      end
      object ButtonM: TButton
        Left = 8
        Top = 110
        Width = 81
        Height = 33
        Hint = 
          'Affecter la route '#224' ce train et affecter le train au canton dans' +
          ' le sens de d'#233'marrage de la route'
        Caption = 'Choisir cette route'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        WordWrap = True
        OnClick = ButtonMClick
      end
      object ListBoxRM: TListBox
        Left = 8
        Top = 32
        Width = 561
        Height = 73
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        PopupMenu = PopupMenuRoutes
        TabOrder = 1
        OnKeyDown = ListBoxRMKeyDown
        OnMouseDown = ListBoxRMMouseDown
      end
      object ButtonSR: TButton
        Left = 104
        Top = 110
        Width = 81
        Height = 33
        Caption = 'Supprimer route'
        TabOrder = 2
        WordWrap = True
        OnClick = ButtonSRClick
      end
      object ButtonSRS: TButton
        Left = 200
        Top = 110
        Width = 81
        Height = 33
        Hint = 'Sauve les routes m'#233'moris'#233'es'
        Caption = 'Sauve routes'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ButtonSRSClick
      end
      object EditnomRoute: TEdit
        Left = 344
        Top = 5
        Width = 217
        Height = 21
        TabOrder = 4
        OnChange = EditnomRouteChange
      end
      object CheckBoxSens: TCheckBox
        Left = 352
        Top = 118
        Width = 97
        Height = 17
        Hint = 'Consigne inverse du train'
        Caption = 'Sens inverse'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = CheckBoxSensClick
      end
    end
  end
  object ComboBoxTrains: TComboBox
    Left = 8
    Top = 56
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBoxTrainsChange
  end
  object ButtonQuitte: TButton
    Left = 8
    Top = 156
    Width = 81
    Height = 33
    Caption = 'Quitter'
    TabOrder = 2
    OnClick = ButtonQuitteClick
  end
  object PopupMenuRoutes: TPopupMenu
    OnPopup = PopupMenuRoutesPopup
    Left = 764
    Top = 144
    object Copierroute1: TMenuItem
      Caption = 'Copier route'
      OnClick = Copierroute1Click
    end
    object Collerroute1: TMenuItem
      Caption = 'Coller route'
      OnClick = Collerroute1Click
    end
  end
end
