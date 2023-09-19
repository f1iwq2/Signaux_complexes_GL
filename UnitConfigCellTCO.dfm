object FormConfCellTCO: TFormConfCellTCO
  Left = 477
  Top = 168
  BorderStyle = bsDialog
  Caption = 'FormConfCellTCO'
  ClientHeight = 430
  ClientWidth = 282
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
  OnHide = FormHide
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 304
    Width = 265
    Height = 97
    Caption = 'Texte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 41
      Width = 93
      Height = 20
      Caption = 'Position du texte:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
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
        'Bas'
        'R'#233'parti'
        'Centr'#233)
    end
    object ButtonFonte: TButton
      Left = 160
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
      Width = 241
      Height = 24
      TabOrder = 2
      OnChange = EditTexteCCTCOChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 297
    Caption = 'El'#233'ment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label15: TLabel
      Left = 8
      Top = 22
      Width = 111
      Height = 20
      Caption = 'Image de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 192
      Top = 14
      Width = 53
      Height = 20
      Caption = 'Adresse : '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object ImagePaletteCC: TImage
      Left = 128
      Top = 24
      Width = 41
      Height = 41
      OnMouseDown = ImagePaletteCCMouseDown
    end
    object EditTypeImage: TEdit
      Left = 40
      Top = 48
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
      OnChange = EditTypeImageChange
    end
    object GroupBoxOrientation: TGroupBox
      Left = 8
      Top = 152
      Width = 249
      Height = 73
      Caption = 'Orientation du signal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
        Font.Height = -12
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
        Font.Height = -12
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
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = RadioButtonHDClick
      end
    end
    object GroupBoxImplantation: TGroupBox
      Left = 8
      Top = 232
      Width = 249
      Height = 57
      Caption = 'Implantation du signal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
        Font.Height = -12
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
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = RadioButtonDClick
      end
    end
    object EditAdrElement: TEdit
      Left = 200
      Top = 40
      Width = 33
      Height = 24
      Hint = 'Adresse DCC de l'#39#233'l'#233'ment'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnChange = EditAdrElementChange
    end
    object ButtonFond: TButton
      Left = 8
      Top = 104
      Width = 89
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
    object RadioGroupSel: TRadioGroup
      Left = 104
      Top = 88
      Width = 153
      Height = 57
      Caption = 'S'#233'lection clic ic'#244'ne ci-dessus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Epaisseurs de voie'
        'Pont')
      ParentFont = False
      TabOrder = 5
    end
    object GroupBoxAction: TGroupBox
      Left = 24
      Top = 184
      Width = 249
      Height = 105
      Caption = 'Action'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object RadioButtonAffTCO: TRadioButton
        Left = 8
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Afficher TCO n'#176
        TabOrder = 0
        OnClick = RadioButtonAffTCOClick
      end
      object EditNumTCO: TEdit
        Left = 104
        Top = 20
        Width = 33
        Height = 21
        TabOrder = 1
        OnChange = EditNumTCOChange
      end
      object RadioButtonSC: TRadioButton
        Left = 8
        Top = 40
        Width = 169
        Height = 17
        Caption = 'Afficher Signaux complexes'
        TabOrder = 2
        OnClick = RadioButtonSCClick
      end
      object RadioButtonCDM: TRadioButton
        Left = 8
        Top = 56
        Width = 113
        Height = 17
        Caption = 'Afficher CDM rail'
        TabOrder = 3
        OnClick = RadioButtonCDMClick
      end
    end
  end
  object CheckPinv: TCheckBox
    Left = 8
    Top = 408
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
    Left = 168
    Top = 400
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = BitBtnOkClick
    Kind = bkOK
  end
end
