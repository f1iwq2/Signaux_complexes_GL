object FormSimulation: TFormSimulation
  Left = 332
  Top = 283
  Width = 438
  Height = 189
  Caption = 'Simulation'
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
    Left = 16
    Top = 32
    Width = 330
    Height = 16
    Caption = 'Intervalle de temps entre deux '#233'v'#232'nements d'#233'tecteurs (s)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object ButtonCharge: TButton
    Left = 160
    Top = 96
    Width = 105
    Height = 41
    Caption = 'Charger un fichier de simulation'
    TabOrder = 0
    WordWrap = True
    OnClick = ButtonChargeClick
  end
  object EditIntervalle: TEdit
    Left = 352
    Top = 32
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '1'
    OnKeyPress = EditIntervalleKeyPress
  end
  object CheckBoxRapide: TCheckBox
    Left = 56
    Top = 56
    Width = 97
    Height = 17
    Caption = 'Mode rapide'
    TabOrder = 2
  end
  object OpenDialog: TOpenDialog
    Left = 48
    Top = 96
  end
end
