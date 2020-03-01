object FormTCO: TFormTCO
  Left = 267
  Top = 203
  Width = 928
  Height = 590
  Caption = 'FormTCO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LabelX: TLabel
    Left = 32
    Top = 16
    Width = 53
    Height = 19
    Caption = 'LabelX'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 13
    Height = 13
    Caption = 'X='
  end
  object Label3: TLabel
    Left = 104
    Top = 16
    Width = 13
    Height = 13
    Caption = 'X='
  end
  object LabelY: TLabel
    Left = 120
    Top = 16
    Width = 51
    Height = 19
    Caption = 'Label1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 496
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 320
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ScrollBox: TScrollBox
    Left = 16
    Top = 40
    Width = 865
    Height = 433
    TabOrder = 1
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 857
      Height = 425
      PopupMenu = PopupMenu1
      OnClick = ImageTCOClick
      OnContextPopup = ImageTCOContextPopup
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 568
    Top = 296
    object Position1: TMenuItem
      Caption = 'Position'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Insrer1: TMenuItem
      Caption = 'Ins'#233'rer'
      object aiguillageG_PG: TMenuItem
        Caption = 'Aiguillage gauche ; pointe '#224' gauche'
        OnClick = aiguillageG_PGClick
      end
      object aiguillageD_PD: TMenuItem
        Caption = 'Aiguillage droit ; pointe '#224' droite'
        OnClick = aiguillageD_PDClick
      end
    end
  end
end
