object FormVersion: TFormVersion
  Left = 222
  Top = 260
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'V'#233'rification de version'
  ClientHeight = 234
  ClientWidth = 645
  Color = clNavy
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Arial Narrow'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object Memo1: TMemo
    Left = 8
    Top = 16
    Width = 625
    Height = 209
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -19
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object TimerVerif: TTimer
    OnTimer = TimerVerifTimer
  end
end
