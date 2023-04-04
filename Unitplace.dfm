object FormPlace: TFormPlace
  Left = 368
  Top = 142
  BorderStyle = bsDialog
  Caption = 'Placement des trains'
  ClientHeight = 485
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 229
    Height = 20
    Caption = 'Placement des trains pour le roulage'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelTrain1: TLabel
    Left = 8
    Top = 64
    Width = 30
    Height = 13
    Caption = 'Train1'
  end
  object LabelTrain2: TLabel
    Left = 8
    Top = 88
    Width = 30
    Height = 13
    Caption = 'Train2'
  end
  object LabelTrain3: TLabel
    Left = 8
    Top = 112
    Width = 30
    Height = 13
    Caption = 'Train3'
  end
  object LabelTrain4: TLabel
    Left = 8
    Top = 136
    Width = 30
    Height = 13
    Caption = 'Train4'
  end
  object LabelTrain5: TLabel
    Left = 8
    Top = 160
    Width = 30
    Height = 13
    Caption = 'Train5'
  end
  object LabelTrain6: TLabel
    Left = 8
    Top = 184
    Width = 30
    Height = 13
    Caption = 'Train6'
  end
  object Label2: TLabel
    Left = 91
    Top = 32
    Width = 70
    Height = 26
    Alignment = taRightJustify
    Caption = 'D'#233'tecteurs de placement'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object LabelTexte: TLabel
    Left = 9
    Top = 232
    Width = 120
    Height = 13
    Caption = '.                                       '
  end
  object Label3: TLabel
    Left = 8
    Top = 208
    Width = 293
    Height = 13
    Caption = 'Pour ne pas placer un train, mettre 0 en face de son d'#233'tecteur'
  end
  object Label4: TLabel
    Left = 168
    Top = 32
    Width = 54
    Height = 26
    Caption = 'D'#233'tecteurs destinataire'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 8
    Top = 40
    Width = 73
    Height = 13
    Caption = 'Nom du train'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonInitAig: TButton
    Left = 16
    Top = 248
    Width = 273
    Height = 25
    Caption = 'Positionner les aiguillages en position initiale'
    TabOrder = 0
    OnClick = ButtonInitAigClick
  end
  object ButtonSauve: TButton
    Left = 16
    Top = 408
    Width = 273
    Height = 25
    Hint = 
      'Enregistre la configuration de placement dans le fichier de conf' +
      'iguration'
    Caption = 'Enregistrer la configuration de  placement'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = ButtonSauveClick
  end
  object Edit1: TEdit
    Left = 128
    Top = 64
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur recevant le train 1'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 128
    Top = 88
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur recevant le train 2'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 128
    Top = 112
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur recevant le train 3'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnChange = Edit3Change
  end
  object Edit4: TEdit
    Left = 128
    Top = 136
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur recevant le train 4'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnChange = Edit4Change
  end
  object Edit5: TEdit
    Left = 128
    Top = 160
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur recevant le train 5'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnChange = Edit5Change
  end
  object Edit6: TEdit
    Left = 128
    Top = 184
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur recevant le train 6'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnChange = Edit6Change
  end
  object ButtonPlace: TButton
    Left = 16
    Top = 280
    Width = 273
    Height = 25
    Caption = 'Placer les trains sur les d'#233'tecteurs ci-dessus'
    TabOrder = 8
    OnClick = ButtonPlaceClick
  end
  object ButtonLanceRoutage: TButton
    Left = 16
    Top = 312
    Width = 273
    Height = 25
    Caption = 'Lancer le roulage'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = ButtonLanceRoutageClick
  end
  object Button1: TButton
    Left = 208
    Top = 448
    Width = 81
    Height = 25
    Caption = 'Config trains'
    TabOrder = 10
    OnClick = Button1Click
  end
  object ButtonArretroutage: TButton
    Left = 16
    Top = 376
    Width = 273
    Height = 25
    Hint = 'Arr'#234't des trains et lib'#232're les r'#233'servations'
    Caption = 'Arr'#234't du roulage'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = ButtonArretroutageClick
  end
  object CheckInverse1: TCheckBox
    Left = 208
    Top = 64
    Width = 89
    Height = 17
    Hint = 'Pilotage en sens inverse'
    Caption = 'sens inverse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = CheckInverse1Click
  end
  object CheckInverse2: TCheckBox
    Left = 208
    Top = 88
    Width = 89
    Height = 17
    Hint = 'Pilotage en sens inverse'
    Caption = 'sens inverse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = CheckInverse2Click
  end
  object CheckInverse3: TCheckBox
    Left = 208
    Top = 112
    Width = 89
    Height = 17
    Hint = 'Pilotage en sens inverse'
    Caption = 'sens inverse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = CheckInverse3Click
  end
  object CheckInverse4: TCheckBox
    Left = 208
    Top = 136
    Width = 89
    Height = 17
    Hint = 'Pilotage en sens inverse'
    Caption = 'sens inverse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = CheckInverse4Click
  end
  object CheckInverse5: TCheckBox
    Left = 208
    Top = 160
    Width = 89
    Height = 17
    Hint = 'Pilotage en sens inverse'
    Caption = 'sens inverse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = CheckInverse5Click
  end
  object CheckInverse6: TCheckBox
    Left = 208
    Top = 184
    Width = 89
    Height = 17
    Hint = 'Pilotage en sens inverse'
    Caption = 'sens inverse'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = CheckInverse6Click
  end
  object EditDir1: TEdit
    Left = 168
    Top = 64
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur suivant vers lequel doit se diriger le train 1'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
    OnChange = EditDir1Change
  end
  object EditDir2: TEdit
    Left = 168
    Top = 88
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur suivant vers lequel doit se diriger le train 2'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    OnChange = EditDir2Change
  end
  object EditDir3: TEdit
    Left = 168
    Top = 112
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur suivant vers lequel doit se diriger le train 3'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnChange = EditDir3Change
  end
  object EditDir4: TEdit
    Left = 168
    Top = 136
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur suivant vers lequel doit se diriger le train 4'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    OnChange = EditDir4Change
  end
  object EditDir5: TEdit
    Left = 168
    Top = 160
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur suivant vers lequel doit se diriger le train 5'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
    OnChange = EditDir5Change
  end
  object EditDir6: TEdit
    Left = 168
    Top = 184
    Width = 33
    Height = 21
    Hint = 'D'#233'tecteur suivant vers lequel doit se diriger le train 6'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
    OnChange = EditDir6Change
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 448
    Width = 73
    Height = 25
    TabOrder = 24
    OnClick = BitBtn1Click
    Kind = bkClose
  end
  object ButtonArretTrains: TButton
    Left = 16
    Top = 344
    Width = 273
    Height = 25
    Hint = 'Arr'#234'te tous les trains'
    Caption = 'Arr'#234't des trains'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
    OnClick = ButtonArretTrainsClick
  end
end
