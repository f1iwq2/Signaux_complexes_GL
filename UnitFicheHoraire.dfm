object FormFicheHoraire: TFormFicheHoraire
  Left = 358
  Top = 169
  Width = 628
  Height = 385
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
    620
    354)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 313
    Width = 310
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 
      'Le nom des trains doit respecter l'#39#233'criture d'#233'clar'#233'e dans CDM Ra' +
      'il'
  end
  object LabelErreur: TLabel
    Left = 99
    Top = 297
    Width = 3
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '.'
  end
  object Label2: TLabel
    Left = 104
    Top = 329
    Width = 296
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Les horaires sont sauvegard'#233's dans le fichier '#39'FicheHoraire.txt"'
  end
  object ButtonOk: TButton
    Left = 8
    Top = 313
    Width = 75
    Height = 32
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
    Width = 601
    Height = 273
    ColCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    OnDrawCell = StringGridFODrawCell
    OnSetEditText = StringGridFOSetEditText
  end
end
