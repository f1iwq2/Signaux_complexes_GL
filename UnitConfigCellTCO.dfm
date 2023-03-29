object FormConfCellTCO: TFormConfCellTCO
  Left = 467
  Top = 112
  BorderStyle = bsDialog
  Caption = 'FormConfCellTCO'
  ClientHeight = 402
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 264
    Width = 233
    Height = 97
    Caption = 'Texte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 41
      Width = 79
      Height = 16
      Caption = 'Position du texte:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object ComboRepr: TComboBox
      Left = 8
      Top = 60
      Width = 89
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
      OnChange = ComboReprChange
      Items.Strings = (
        'Sans'
        'Centrale'
        'Haut'
        'Bas')
    end
    object ButtonFonte: TButton
      Left = 112
      Top = 56
      Width = 81
      Height = 25
      Caption = 'Fonte'
      TabOrder = 1
      OnClick = ButtonFonteClick
    end
    object EditTexteCCTCO: TEdit
      Left = 8
      Top = 16
      Width = 209
      Height = 24
      TabOrder = 2
      OnChange = EditTexteCCTCOChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 233
    Height = 257
    Caption = 'El'#233'ment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label15: TLabel
      Left = 8
      Top = 22
      Width = 93
      Height = 16
      Caption = 'Image de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object ImagePalette: TImage
      Left = 112
      Top = 24
      Width = 41
      Height = 41
      Hint = 'Voie pouvant porter un d'#233'tecteur'
      DragMode = dmAutomatic
      ParentShowHint = False
      ShowHint = True
      Stretch = True
    end
    object Label2: TLabel
      Left = 168
      Top = 14
      Width = 48
      Height = 16
      Caption = 'Adresse : '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object EditTypeImage: TEdit
      Left = 32
      Top = 40
      Width = 33
      Height = 21
      Hint = 'Num'#233'ro d'#39'image de l'#39#233'l'#233'ment'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = EditTypeImageKeyPress
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 112
      Width = 209
      Height = 73
      Caption = 'Orientation du signal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object RadioButtonHG: TRadioButton
        Left = 16
        Top = 16
        Width = 169
        Height = 17
        Caption = 'Horizontal gauche'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = RadioButtonHGClick
      end
      object RadioButtonV: TRadioButton
        Left = 16
        Top = 48
        Width = 169
        Height = 17
        Caption = 'Vertical'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = RadioButtonVClick
      end
      object RadioButtonHD: TRadioButton
        Left = 16
        Top = 32
        Width = 169
        Height = 17
        Caption = 'Horizontal droit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = RadioButtonHDClick
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 192
      Width = 209
      Height = 57
      Caption = 'Implantation du signal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object RadioButtonG: TRadioButton
        Left = 16
        Top = 16
        Width = 113
        Height = 17
        Caption = #224' gauche de la voie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = RadioButtonGClick
      end
      object RadioButtonD: TRadioButton
        Left = 16
        Top = 32
        Width = 113
        Height = 17
        Caption = #224' droite de la voie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = RadioButtonDClick
      end
    end
    object EditAdrElement: TEdit
      Left = 176
      Top = 40
      Width = 33
      Height = 24
      Hint = 'Adresse DCC de l'#39#233'l'#233'ment'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyPress = EditAdrElementKeyPress
    end
    object ButtonFond: TButton
      Left = 16
      Top = 72
      Width = 97
      Height = 33
      Caption = 'Couleur de fond de la cellule'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      WordWrap = True
      OnClick = ButtonFondClick
    end
  end
  object CheckPinv: TCheckBox
    Left = 8
    Top = 368
    Width = 129
    Height = 17
    Hint = 'Cocher si l'#39'aiguillage est repr'#233'sent'#233' invers'#233
    Caption = 'aiguillage invers'#233
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = CheckPinvClick
  end
  object BitBtnOk: TBitBtn
    Left = 152
    Top = 368
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = BitBtnOkClick
    Kind = bkOK
  end
end
