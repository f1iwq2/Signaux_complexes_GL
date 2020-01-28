object FormDebug: TFormDebug
  Left = 390
  Top = 178
  BorderStyle = bsSingle
  Caption = 'FormDebug'
  ClientHeight = 639
  ClientWidth = 759
  Color = clWhite
  TransparentColorValue = clTeal
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 456
    Top = 52
    Width = 108
    Height = 13
    Caption = 'Niveau du Debug (0-3)'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 448
    Top = 12
    Width = 131
    Height = 18
    Caption = 'Fen'#234'tre de d'#233'bug'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 448
    Top = 84
    Width = 265
    Height = 209
    AutoSize = False
    Caption = 'Label3'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindow
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object EditNivDebug: TEdit
    Left = 576
    Top = 52
    Width = 73
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'EditNivDebug'
    OnKeyPress = EditNivDebugKeyPress
  end
  object MemoEvtDet: TMemo
    Left = 452
    Top = 300
    Width = 181
    Height = 281
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Tableau des '#233'v'#232'nements d'#233'tecteurs')
    ParentFont = False
    TabOrder = 1
  end
  object ButtonEcrLog: TButton
    Left = 456
    Top = 596
    Width = 97
    Height = 25
    Caption = 'Ecrire le log'
    TabOrder = 2
    OnClick = ButtonEcrLogClick
  end
  object MemoDebug: TMemo
    Left = 0
    Top = 0
    Width = 433
    Height = 625
    Lines.Strings = (
      'MemoDebug')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object SaveDialog: TSaveDialog
    Left = 616
    Top = 16
  end
end
