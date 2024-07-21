object FormFicheHoraire: TFormFicheHoraire
  Left = 358
  Top = 169
  BorderStyle = bsDialog
  Caption = 'Fiche horaire'
  ClientHeight = 346
  ClientWidth = 527
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 272
    Width = 310
    Height = 13
    Caption = 
      'Le nom des trains doit respecter l'#39#233'criture d'#233'clar'#233'e dans CDM Ra' +
      'il'
  end
  object LabelErreur: TLabel
    Left = 136
    Top = 304
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 208
    Top = 328
    Width = 296
    Height = 13
    Caption = 'Les horaires sont sauvegard'#233's dans le fichier '#39'FicheHoraire.txt"'
  end
  object ButtonOk: TButton
    Left = 16
    Top = 304
    Width = 75
    Height = 25
    Hint = 'Sauvegarde la fiche et ferme la fen'#234'tre'
    Caption = 'Ok'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ButtonOkClick
  end
  object StringGridFO: TStringGrid
    Left = 8
    Top = 16
    Width = 505
    Height = 233
    ColCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    OnDrawCell = StringGridFODrawCell
  end
end
