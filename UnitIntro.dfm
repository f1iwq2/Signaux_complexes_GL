object FormIntro: TFormIntro
  Left = 300
  Top = 150
  BorderStyle = bsDialog
  Caption = 'Introduction de donn'#233'es'
  ClientHeight = 106
  ClientWidth = 188
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEditDetAig: TLabeledEdit
    Left = 24
    Top = 24
    Width = 57
    Height = 21
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'D'#233'tecteur'
    TabOrder = 0
  end
  object ButtonTrCanton: TButton
    Left = 112
    Top = 64
    Width = 65
    Height = 25
    Caption = 'Trouver'
    TabOrder = 1
    OnClick = ButtonTrCantonClick
  end
  object LabeledEditCanton: TLabeledEdit
    Left = 24
    Top = 64
    Width = 57
    Height = 21
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Canton'
    TabOrder = 2
  end
  object ButtonTrDet: TButton
    Left = 112
    Top = 24
    Width = 65
    Height = 25
    Caption = 'Trouver'
    TabOrder = 3
    OnClick = ButtonTrDetClick
  end
end
