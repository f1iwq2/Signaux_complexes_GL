object FormIntro: TFormIntro
  Left = 300
  Top = 150
  BorderStyle = bsDialog
  Caption = 'Introduction de donn'#233'es'
  ClientHeight = 95
  ClientWidth = 186
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
    Left = 40
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'D'#233'tecteur'
    TabOrder = 0
  end
  object ButtonTrouver: TButton
    Left = 56
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Trouver'
    TabOrder = 1
    OnClick = ButtonTrouverClick
  end
end
