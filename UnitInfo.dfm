object FormInfo: TFormInfo
  Left = 310
  Top = 250
  BorderIcons = [biMaximize, biHelp]
  BorderStyle = bsNone
  Caption = 'FormInfo'
  ClientHeight = 50
  ClientWidth = 615
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelInfo: TLabel
    Left = 8
    Top = 16
    Width = 54
    Height = 20
    Caption = 'LabelInfo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Timerinfo: TTimer
    OnTimer = TimerinfoTimer
    Left = 8
    Top = 8
  end
end
