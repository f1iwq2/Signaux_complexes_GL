object FormConfigTCO: TFormConfigTCO
  Left = 542
  Top = 389
  Width = 405
  Height = 251
  Caption = 'Configuration du TCO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 83
    Height = 13
    Caption = 'Taille des cellules'
  end
  object Label2: TLabel
    Left = 160
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
  object LabelNbCellX: TLabel
    Left = 192
    Top = 52
    Width = 96
    Height = 20
    Caption = 'LabelNbCellX'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelNbCellY: TLabel
    Left = 192
    Top = 76
    Width = 96
    Height = 20
    Caption = 'LabelNbCellX'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ButtonOK: TButton
    Left = 168
    Top = 176
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object EditTailleCellX: TEdit
    Left = 104
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 1
    Text = 'EditTailleCellX'
  end
  object EditTailleCellY: TEdit
    Left = 176
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 2
    Text = 'EditTailleCellY'
  end
  object ButtonDessine: TButton
    Left = 24
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Dessine'
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
end
