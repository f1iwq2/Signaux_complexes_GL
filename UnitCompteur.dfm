object FormCompteur: TFormCompteur
  Left = 550
  Top = 218
  Width = 258
  Height = 262
  BorderStyle = bsSizeToolWin
  Caption = 'Compteur'
  Color = clBtnFace
  TransparentColorValue = clPurple
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ImageCompteur: TImage
    Left = 0
    Top = 0
    Width = 180
    Height = 128
    PopupMenu = PopupMenuC
  end
  object Labeltrain: TLabel
    Left = 32
    Top = 176
    Width = 10
    Height = 22
    Caption = #39#39
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ImageTprov: TImage
    Left = 56
    Top = 88
    Width = 161
    Height = 33
    Visible = False
  end
  object ImageTrain: TImage
    Left = 0
    Top = 192
    Width = 217
    Height = 33
  end
  object TrackBarC: TTrackBar
    Left = 0
    Top = 128
    Width = 129
    Height = 21
    Ctl3D = False
    Max = 127
    Min = -128
    ParentCtl3D = False
    TabOrder = 0
    OnChange = TrackBarCChange
  end
  object Button0: TButton
    Left = 96
    Top = 160
    Width = 17
    Height = 17
    Caption = '0'
    TabOrder = 1
    OnClick = Button0Click
  end
  object PopupMenuC: TPopupMenu
    OnPopup = PopupMenuCPopup
    Left = 184
    Top = 16
    object Verrouillerdevant1: TMenuItem
      Caption = 'Verrouiller devant'
      OnClick = Verrouillerdevant1Click
    end
    object Dverrouiller1: TMenuItem
      Caption = 'D'#233'verrouiller'
      OnClick = Dverrouiller1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Compteurdevitesse11: TMenuItem
      Caption = 'Compteur de vitesse 1'
      OnClick = Compteurdevitesse11Click
    end
    object Compteurdevitesse21: TMenuItem
      Caption = 'Compteur de vitesse 2'
      OnClick = Compteurdevitesse21Click
    end
    object Compteurtachro1: TMenuItem
      Caption = 'Compteur tachro'
      OnClick = Compteurtachro1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Affichericonedutrain1: TMenuItem
      Caption = 'Afficher icone du train'
      OnClick = Affichericonedutrain1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Vitesseencrans1: TMenuItem
      Caption = 'Vitesse en crans'
      OnClick = Vitesseencrans1Click
    end
    object Vitesserelle1: TMenuItem
      Caption = 'Vitesse r'#233'elle'
      OnClick = Vitesserelle1Click
    end
  end
end
