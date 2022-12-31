object FormSimulation: TFormSimulation
  Left = 332
  Top = 283
  Width = 447
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
    Left = 8
    Top = 32
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
    Top = 96
    Width = 105
    Height = 41
    Caption = 'Charger un fichier de simulation'
    TabOrder = 0
    WordWrap = True
    OnClick = ButtonChargeClick
  end
  object EditIntervalle: TEdit
    Left = 384
    Top = 32
    Width = 41
    Height = 21
    TabOrder = 1
    Text = '0'
    OnChange = EditIntervalleChange
    OnKeyPress = EditIntervalleKeyPress
  end
  object CheckAffTick: TCheckBox
    Left = 64
    Top = 64
    Width = 313
    Height = 17
    Caption = 'RAZ des trains et de leurs placements avant de d'#233'marrer'
    TabOrder = 2
  end
  object OpenDialog: TOpenDialog
    Left = 48
    Top = 96
  end
end
