object FormFicheHoraire: TFormFicheHoraire
  Left = 358
  Top = 169
  Width = 617
  Height = 377
  Caption = 'Fiche horaire'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    609
    346)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 272
    Width = 310
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'Le nom des trains doit respecter l'#39#233'criture d'#233'clar'#233'e dans CDM Ra' +
      'il'
  end
  object LabelErreur: TLabel
    Left = 280
    Top = 296
    Width = 3
    Height = 13
    Anchors = [akLeft, akBottom]
  end
  object Label2: TLabel
    Left = 288
    Top = 320
    Width = 296
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Les horaires sont sauvegard'#233's dans le fichier '#39'FicheHoraire.txt"'
  end
  object ButtonOk: TButton
    Left = 16
    Top = 304
    Width = 75
    Height = 25
    Hint = 'Sauvegarde la fiche et ferme la fen'#234'tre'
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ButtonOkClick
  end
  object StringGridFO: TStringGrid
    Left = 8
    Top = 16
    Width = 593
    Height = 233
    ColCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    OnDrawCell = StringGridFODrawCell
    OnSetEditText = StringGridFOSetEditText
  end
end
