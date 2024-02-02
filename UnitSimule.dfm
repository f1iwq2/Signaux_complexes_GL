object FormSimulation: TFormSimulation
  Left = 332
  Top = 283
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Ouvrir un fichier de simulation'
  ClientHeight = 150
  ClientWidth = 431
  Color = clActiveBorder
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 369
    Height = 16
    Caption = 'Intervalle de temps entre deux '#233'v'#232'nements d'#233'tecteurs (x100ms)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object ButtonCharge: TButton
    Left = 160
    Top = 104
    Width = 105
    Height = 41
    Caption = 'Charger un fichier de simulation'
    TabOrder = 0
    WordWrap = True
    OnClick = ButtonChargeClick
  end
  object EditIntervalle: TEdit
    Left = 384
    Top = 24
    Width = 41
    Height = 21
    TabOrder = 1
    Text = '0'
    OnChange = EditIntervalleChange
    OnKeyPress = EditIntervalleKeyPress
  end
  object CheckRaz: TCheckBox
    Left = 64
    Top = 48
    Width = 313
    Height = 17
    Caption = 'RAZ des trains et de leurs placements avant de d'#233'marrer'
    TabOrder = 2
  end
  object CheckEvalroutes: TCheckBox
    Left = 64
    Top = 64
    Width = 345
    Height = 17
    Caption = 
      'Affichage de l'#39#233'valuation des routes des trains dans la fen'#234'tre ' +
      'debug'
    TabOrder = 3
  end
  object OpenDialog: TOpenDialog
    Left = 48
    Top = 96
  end
end
