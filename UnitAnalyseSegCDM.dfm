object FormAnalyseCDM: TFormAnalyseCDM
  Left = 216
  Top = 23
  Hint = '(aiguillages uniquement)'
  Anchors = [akLeft, akTop, akRight, akBottom]
  AutoScroll = False
  Caption = 'FormAnalyseCDM'
  ClientHeight = 660
  ClientWidth = 1032
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    1032
    660)
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 16
    Width = 977
    Height = 553
    HorzScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoScroll = False
    Color = clBlack
    ParentColor = False
    TabOrder = 0
    object ImageCDM: TImage
      Left = 0
      Top = 0
      Width = 937
      Height = 512
    end
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 576
    Width = 457
    Height = 73
    Anchors = [akLeft, akBottom]
    Caption = 'Affichages '
    TabOrder = 1
    object Label1: TLabel
      Left = 216
      Top = 16
      Width = 81
      Height = 13
      Caption = 'Afficher le port n'#176
    end
    object CheckConnexions: TCheckBox
      Left = 24
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Connexions'
      TabOrder = 0
      OnClick = CheckConnexionsClick
    end
    object CheckAdresses: TCheckBox
      Left = 24
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Adresses'
      TabOrder = 1
      OnClick = CheckAdressesClick
    end
    object CheckSegments: TCheckBox
      Left = 112
      Top = 16
      Width = 81
      Height = 17
      Caption = 'segments'
      TabOrder = 2
      OnClick = CheckSegmentsClick
    end
    object CheckPorts: TCheckBox
      Left = 112
      Top = 32
      Width = 121
      Height = 17
      Caption = 'Ports'
      TabOrder = 3
      OnClick = CheckSegmentsClick
    end
    object EditPort: TEdit
      Left = 304
      Top = 16
      Width = 57
      Height = 21
      TabOrder = 4
    end
    object ButtonAffPort: TButton
      Left = 368
      Top = 16
      Width = 73
      Height = 25
      Caption = 'Afficher le port'
      TabOrder = 5
      OnClick = ButtonAffPortClick
    end
  end
  object TrackBar1: TTrackBar
    Left = 992
    Top = 16
    Width = 37
    Height = 553
    Anchors = [akTop, akRight]
    Max = 200
    Min = 50
    Orientation = trVertical
    Position = 200
    TabOrder = 2
    OnChange = TrackBar1Change
  end
end
