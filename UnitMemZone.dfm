object FormMemZone: TFormMemZone
  Left = 391
  Top = 155
  BorderStyle = bsDialog
  Caption = 'Activer / d'#233'sactiver des m'#233'moires de zone'
  ClientHeight = 173
  ClientWidth = 370
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
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 329
    Height = 33
    Caption = 
      'Les m'#233'moires de zone sont constitu'#233'es de deux d'#233'tecteurs contigu' +
      's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object LabelInfo: TLabel
    Left = 16
    Top = 120
    Width = 3
    Height = 13
  end
  object Shape1: TShape
    Left = 216
    Top = 88
    Width = 137
    Height = 9
    Brush.Color = clBlue
  end
  object Shape2: TShape
    Left = 232
    Top = 83
    Width = 25
    Height = 20
    Brush.Color = clRed
  end
  object Shape3: TShape
    Left = 312
    Top = 83
    Width = 25
    Height = 20
    Brush.Color = clRed
  end
  object Label2: TLabel
    Left = 225
    Top = 56
    Width = 35
    Height = 19
    Caption = 'Det1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 304
    Top = 56
    Width = 35
    Height = 19
    Caption = 'Det2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonOk: TButton
    Left = 280
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = ButtonOkClick
  end
  object LabeledEditDet1: TLabeledEdit
    Left = 152
    Top = 56
    Width = 33
    Height = 21
    EditLabel.Width = 77
    EditLabel.Height = 13
    EditLabel.Caption = 'De : d'#233'tecteur 1'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 1
  end
  object LabeledEditDet2: TLabeledEdit
    Left = 152
    Top = 88
    Width = 33
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = ' '#224' : d'#233'tecteur 2'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 2
  end
  object ButtonAct: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Activer'
    TabOrder = 3
    OnClick = ButtonActClick
  end
  object ButtonDes: TButton
    Left = 96
    Top = 144
    Width = 75
    Height = 25
    Caption = 'D'#233'sactiver'
    TabOrder = 4
    OnClick = ButtonDesClick
  end
  object ButtonClicDet1: TButton
    Left = 24
    Top = 56
    Width = 25
    Height = 25
    Hint = 'Cliquer sur le d'#233'tecteur 1 dans le TCO'
    Caption = 'Clic'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = ButtonClicDet1Click
  end
  object Button1: TButton
    Left = 24
    Top = 84
    Width = 25
    Height = 25
    Hint = 'Cliquer sur le d'#233'tecteur 2 dans le TCO'
    Caption = 'Clic'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = Button1Click
  end
end
