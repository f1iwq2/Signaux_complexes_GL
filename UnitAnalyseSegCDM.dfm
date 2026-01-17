object FormAnalyseCDM: TFormAnalyseCDM
  Left = 210
  Top = 94
  AutoScroll = False
  Caption = 'Fen'#234'tre r'#233'seau CDM'
  ClientHeight = 596
  ClientWidth = 1041
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseWheel = FormMouseWheel
  OnResize = FormResize
  DesignSize = (
    1041
    596)
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 1001
    Top = 512
    Width = 27
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Zoom'
    WordWrap = True
  end
  object ImageLoco: TImage
    Left = 688
    Top = 600
    Width = 65
    Height = 25
    Picture.Data = {
      07544269746D61701A020000424D1A0200000000000076000000280000003100
      00000F0000000100040000000000A40100000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FFF77777BBB777777777
      777777777777777777BBB77777FFF0000000FF777777B7B77777777777777777
      7777777777B7B777777FF0000000FF777777BBB7999999999999999999977777
      77BBB777777FF0000000FF777777BBBBBBB7777777777777779777BBBBBBB777
      777FF0000000FF777777BBBBBBBBBB7777777777779BBBBBBBBBB777777FF000
      0000FF777777BBB7BBBB77777777777777977BBBB7BBB777777FF0000000FF77
      7777BBBB7777777777777777779999997BBBB777777FF0000000FF777777B7B7
      77777777777777777777777777B7B777777FF0000000FFF77777BBB777777777
      777777777777777777BBB77777FFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF0000000}
    Transparent = True
    Visible = False
  end
  object Label5: TLabel
    Left = 1005
    Top = 528
    Width = 12
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '+ -'
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 16
    Width = 986
    Height = 457
    HorzScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoScroll = False
    Color = clBlack
    ParentColor = False
    TabOrder = 0
    object ImageCDM: TImage
      Left = 24
      Top = 8
      Width = 873
      Height = 465
      ParentShowHint = False
      ShowHint = True
      OnClick = ImageCDMClick
      OnMouseDown = ImageCDMMouseDown
      OnMouseMove = ImageCDMMouseMove
      OnMouseUp = ImageCDMMouseUp
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 484
    Width = 385
    Height = 109
    Anchors = [akLeft, akBottom]
    Caption = 'Affichages '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 50
      Width = 76
      Height = 26
      Caption = 'Afficher le segment/port n'#176
      WordWrap = True
    end
    object Label3: TLabel
      Left = 8
      Top = 84
      Width = 82
      Height = 13
      Caption = 'Allumer d'#233'tecteur'
    end
    object CheckConnexions: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Hint = 'Points de connexions des ports des d'#233'tecteurs et des actionneurs'
      Caption = 'Connexions'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CheckConnexionsClick
    end
    object CheckDet: TCheckBox
      Left = 8
      Top = 32
      Width = 97
      Height = 17
      Hint = 'Adresses des d'#233'tecteurs'
      Caption = 'Adresses det'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CheckDetClick
    end
    object CheckSegments: TCheckBox
      Left = 128
      Top = 16
      Width = 81
      Height = 17
      Caption = 'segments'
      TabOrder = 2
      OnClick = CheckSegmentsClick
    end
    object CheckPorts: TCheckBox
      Left = 240
      Top = 32
      Width = 129
      Height = 17
      Hint = 'Affiche le num'#233'ro de segment et le port de CDM'
      Caption = 'Ports et segments'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = CheckPortsClick
    end
    object EditPort: TEdit
      Left = 96
      Top = 56
      Width = 49
      Height = 21
      TabOrder = 4
    end
    object ButtonAffPort: TButton
      Left = 152
      Top = 56
      Width = 73
      Height = 25
      Caption = 'Afficher'
      TabOrder = 5
      OnClick = ButtonAffPortClick
    end
    object EditDetecteur: TEdit
      Left = 96
      Top = 80
      Width = 33
      Height = 21
      TabOrder = 6
    end
    object ButtonAffDet: TButton
      Left = 152
      Top = 80
      Width = 73
      Height = 25
      Caption = 'Allumer'
      TabOrder = 7
      OnClick = ButtonAffDetClick
    end
    object CheckColorationDiff: TCheckBox
      Left = 240
      Top = 16
      Width = 137
      Height = 17
      Caption = 'Coloration diff'#233'renti'#233'e'
      TabOrder = 8
      OnClick = CheckColorationDiffClick
    end
    object ButtonAllumeTs: TButton
      Left = 232
      Top = 80
      Width = 129
      Height = 25
      Caption = 'Allume tous les d'#233'tecteurs'
      TabOrder = 9
      OnClick = ButtonAllumeTsClick
    end
    object ButtonImprime: TButton
      Left = 232
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Imprimer'
      TabOrder = 10
      OnClick = ButtonImprimeClick
    end
    object CheckBoxAutres: TCheckBox
      Left = 128
      Top = 32
      Width = 97
      Height = 17
      Hint = 'Adresses des aiguillages, actionneurs et signaux'
      Caption = 'Autres adresses'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = CheckDetClick
    end
  end
  object TrackBar1: TTrackBar
    Left = 1001
    Top = 16
    Width = 37
    Height = 489
    Hint = 'Curseur de Zoom'
    Anchors = [akTop, akRight]
    Max = 90
    Min = 50
    Orientation = trVertical
    ParentShowHint = False
    Position = 90
    ShowHint = True
    TabOrder = 2
    OnChange = TrackBar1Change
  end
  object GroupBoxSegment: TGroupBox
    Left = 400
    Top = 484
    Width = 177
    Height = 109
    Anchors = [akLeft, akBottom]
    Caption = 'Segment'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 22
      Width = 42
      Height = 13
      Caption = 'Segment'
    end
    object LabelAdresse: TLabel
      Left = 11
      Top = 44
      Width = 44
      Height = 13
      Caption = 'Adresse :'
    end
    object LabelPorts: TLabel
      Left = 11
      Top = 66
      Width = 33
      Height = 13
      Caption = 'Ports : '
      WordWrap = True
    end
    object EditSegment: TEdit
      Left = 80
      Top = 16
      Width = 41
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object EditAdresse: TEdit
      Left = 64
      Top = 40
      Width = 57
      Height = 21
      Hint = 'Changement de l'#39'adresse de l'#39'aiguillage'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = EditAdresseChange
    end
  end
  object Memo1: TMemo
    Left = 584
    Top = 492
    Width = 105
    Height = 93
    Anchors = [akLeft, akBottom]
    Lines.Strings = (
      'cliquez sur un '
      'segment du r'#233'seau '
      'pour avoir d'#39'autres '
      'informations')
    ReadOnly = True
    TabOrder = 4
  end
  object ButtonAnime: TButton
    Left = 752
    Top = 496
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Test anime'
    TabOrder = 5
    OnClick = ButtonAnimeClick
  end
  object PrintDialog1: TPrintDialog
    Left = 728
    Top = 560
  end
end
