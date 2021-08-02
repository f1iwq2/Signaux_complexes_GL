object FormVersion: TFormVersion
  Left = 197
  Top = 230
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'V'#233'rification de version'
  ClientHeight = 213
  ClientWidth = 644
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
    Left = 0
    Top = 0
    Width = 641
    Height = 209
    BorderStyle = bsNone
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -19
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object TimerVerif: TTimer
    OnTimer = TimerVerifTimer
  end
end
