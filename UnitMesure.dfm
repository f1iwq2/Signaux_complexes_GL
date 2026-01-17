object FormMesure: TFormMesure
  Left = 717
  Top = 117
  Width = 393
  Height = 357
  Caption = 'Mesure de la vitesse des trains'
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
    Left = 56
    Top = 0
    Width = 289
    Height = 29
    Caption = 
      'S'#233'lection d'#39'un train plac'#233' sur le TCO pour son '#233'talonnage. Le pa' +
      'rcours doit '#234'tre boucl'#233'.'
    WordWrap = True
  end
  object LabelEtat: TLabel
    Left = 24
    Top = 40
    Width = 12
    Height = 13
    Caption = '.   '
  end
  object Label2: TLabel
    Left = 64
    Top = 122
    Width = 168
    Height = 13
    Caption = 'Nombre de passages sur d'#233'tecteur '
  end
  object LabelP: TLabel
    Left = 32
    Top = 154
    Width = 180
    Height = 13
    Caption = 'Progression du  nombre de passages :'
  end
  object LabelProg: TLabel
    Left = 224
    Top = 152
    Width = 9
    Height = 16
    Caption = '. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelMesC: TLabel
    Left = 256
    Top = 202
    Width = 96
    Height = 15
    Alignment = taCenter
    Caption = 'Mesure en cours'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object ButtonOk: TButton
    Left = 272
    Top = 272
    Width = 75
    Height = 33
    Caption = 'Fermer'
    TabOrder = 0
    OnClick = ButtonOkClick
  end
  object ComboBoxTrains: TComboBox
    Left = 72
    Top = 64
    Width = 217
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 1
    Text = 'ComboBoxTrains'
    OnChange = ComboBoxTrainsChange
    OnDrawItem = ComboBoxTrainsDrawItem
  end
  object ButtonLanceMes: TButton
    Left = 40
    Top = 272
    Width = 75
    Height = 33
    Caption = 'Lancer la mesure'
    TabOrder = 2
    WordWrap = True
    OnClick = ButtonLanceMesClick
  end
  object EditNbrePassages: TEdit
    Left = 248
    Top = 120
    Width = 49
    Height = 21
    Hint = 'Condition d'#39'arr'#234't de la mesure par vitesse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = EditNbrePassagesChange
  end
  object ButtonArret: TButton
    Left = 160
    Top = 272
    Width = 75
    Height = 33
    Caption = 'Arreter'
    TabOrder = 4
    OnClick = ButtonArretClick
  end
  object LabeledEditV1: TLabeledEdit
    Left = 216
    Top = 176
    Width = 33
    Height = 21
    EditLabel.Width = 92
    EditLabel.Height = 13
    EditLabel.Hint = 'vitesse en crans (1-120)'
    EditLabel.Caption = 'Crans vitesse lente '
    EditLabel.ParentShowHint = False
    EditLabel.ShowHint = True
    LabelPosition = lpLeft
    LabelSpacing = 70
    TabOrder = 5
    OnChange = LabeledEditV1Change
  end
  object LabeledEditV2: TLabeledEdit
    Left = 216
    Top = 200
    Width = 33
    Height = 21
    EditLabel.Width = 109
    EditLabel.Height = 13
    EditLabel.Hint = 'vitesse en crans (1-120)'
    EditLabel.Caption = 'Crans vitesse moyenne'
    EditLabel.ParentShowHint = False
    EditLabel.ShowHint = True
    LabelPosition = lpLeft
    LabelSpacing = 70
    TabOrder = 6
    OnChange = LabeledEditV2Change
  end
  object LabeledEditV3: TLabeledEdit
    Left = 216
    Top = 224
    Width = 33
    Height = 21
    EditLabel.Width = 95
    EditLabel.Height = 13
    EditLabel.Hint = 'vitesse en crans (1-120)'
    EditLabel.Caption = 'Crans vitesse rapide'
    EditLabel.ParentShowHint = False
    EditLabel.ShowHint = True
    LabelPosition = lpLeft
    LabelSpacing = 70
    TabOrder = 7
    OnChange = LabeledEditV3Change
  end
end
