object FormTCO: TFormTCO
  Left = 1549
  Top = 156
  Width = 928
  Height = 590
  Caption = 'FormTCO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
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
  object DrawGrid: TDrawGrid
    Left = 48
    Top = 408
    Width = 521
    Height = 137
    Color = clBlack
    DefaultColWidth = 30
    DefaultRowHeight = 30
    FixedCols = 0
    FixedRows = 0
    TabOrder = 0
    OnDrawCell = DrawGridDrawCell
  end
  object Button1: TButton
    Left = 320
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ScrollBox: TScrollBox
    Left = 16
    Top = 40
    Width = 865
    Height = 353
    TabOrder = 2
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 857
      Height = 345
      OnClick = ImageTCOClick
    end
  end
end
