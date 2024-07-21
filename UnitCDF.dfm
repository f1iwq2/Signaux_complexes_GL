object FormCDF: TFormCDF
  Left = 369
  Top = 142
  BorderStyle = bsDialog
  Caption = 'Configuration du d'#233'codeur CDF'
  ClientHeight = 466
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label20: TLabel
    Left = 16
    Top = 48
    Width = 184
    Height = 26
    Caption = 
      'Tables d'#39'aspects du signal en fonction du motif envoy'#233' au d'#233'code' +
      'ur CDF'
    WordWrap = True
  end
  object Label1: TLabel
    Left = 8
    Top = 176
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 8
    Top = 200
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 8
    Top = 224
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 8
    Top = 248
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 8
    Top = 272
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 8
    Top = 296
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 8
    Top = 320
    Width = 32
    Height = 13
    Caption = 'Label7'
  end
  object Label8: TLabel
    Left = 8
    Top = 344
    Width = 32
    Height = 13
    Caption = 'Label8'
  end
  object Label9: TLabel
    Left = 8
    Top = 368
    Width = 32
    Height = 13
    Caption = 'Label9'
  end
  object Label10: TLabel
    Left = 8
    Top = 392
    Width = 38
    Height = 13
    Caption = 'Label10'
  end
  object Label11: TLabel
    Left = 184
    Top = 200
    Width = 38
    Height = 13
    Caption = 'Label11'
  end
  object Label12: TLabel
    Left = 184
    Top = 224
    Width = 38
    Height = 13
    Caption = 'Label12'
  end
  object Label13: TLabel
    Left = 184
    Top = 248
    Width = 38
    Height = 13
    Caption = 'Label13'
  end
  object Label14: TLabel
    Left = 184
    Top = 272
    Width = 38
    Height = 13
    Caption = 'Label14'
  end
  object Label15: TLabel
    Left = 184
    Top = 296
    Width = 38
    Height = 13
    Caption = 'Label15'
  end
  object Label16: TLabel
    Left = 184
    Top = 320
    Width = 38
    Height = 13
    Caption = 'Label16'
  end
  object Label17: TLabel
    Left = 184
    Top = 344
    Width = 38
    Height = 13
    Caption = 'Label17'
  end
  object Label18: TLabel
    Left = 184
    Top = 368
    Width = 38
    Height = 13
    Caption = 'Label18'
  end
  object Label19: TLabel
    Left = 184
    Top = 392
    Width = 38
    Height = 13
    Caption = 'Label19'
  end
  object ImageDigi: TImage
    Left = 240
    Top = 16
    Width = 57
    Height = 97
  end
  object Shape1: TShape
    Left = 168
    Top = 152
    Width = 2
    Height = 273
  end
  object Label21: TLabel
    Left = 120
    Top = 152
    Width = 29
    Height = 13
    Caption = 'Motif'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label22: TLabel
    Left = 296
    Top = 176
    Width = 29
    Height = 13
    Caption = 'Motif'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label23: TLabel
    Left = 16
    Top = 104
    Width = 205
    Height = 13
    Caption = 'Nombre d'#39'adresses occup'#233'es par le signal :'
  end
  object LabelTitre: TLabel
    Left = 16
    Top = 8
    Width = 63
    Height = 19
    Caption = 'Adresse'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label24: TLabel
    Left = 48
    Top = 124
    Width = 24
    Height = 13
    Caption = '1 '#224' 4'
  end
  object Edit1: TEdit
    Left = 120
    Top = 176
    Width = 25
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 120
    Top = 200
    Width = 25
    Height = 21
    TabOrder = 1
    OnChange = Edit2Change
  end
  object Edit3: TEdit
    Left = 120
    Top = 224
    Width = 25
    Height = 21
    TabOrder = 2
    OnChange = Edit3Change
  end
  object Edit4: TEdit
    Left = 120
    Top = 248
    Width = 25
    Height = 21
    TabOrder = 3
    OnChange = Edit4Change
  end
  object Edit5: TEdit
    Left = 120
    Top = 272
    Width = 25
    Height = 21
    TabOrder = 4
    OnChange = Edit5Change
  end
  object Edit6: TEdit
    Left = 120
    Top = 296
    Width = 25
    Height = 21
    TabOrder = 5
    OnChange = Edit6Change
  end
  object Edit7: TEdit
    Left = 120
    Top = 320
    Width = 25
    Height = 21
    TabOrder = 6
    OnChange = Edit7Change
  end
  object Edit8: TEdit
    Left = 120
    Top = 344
    Width = 25
    Height = 21
    TabOrder = 7
    OnChange = Edit8Change
  end
  object Edit9: TEdit
    Left = 120
    Top = 368
    Width = 25
    Height = 21
    TabOrder = 8
    OnChange = Edit9Change
  end
  object Edit10: TEdit
    Left = 120
    Top = 392
    Width = 25
    Height = 21
    TabOrder = 9
    OnChange = Edit10Change
  end
  object Edit11: TEdit
    Left = 296
    Top = 200
    Width = 25
    Height = 21
    TabOrder = 10
    OnChange = Edit11Change
  end
  object Edit12: TEdit
    Left = 296
    Top = 224
    Width = 25
    Height = 21
    TabOrder = 11
    OnChange = Edit12Change
  end
  object Edit13: TEdit
    Left = 296
    Top = 248
    Width = 25
    Height = 21
    TabOrder = 12
    OnChange = Edit13Change
  end
  object Edit14: TEdit
    Left = 296
    Top = 272
    Width = 25
    Height = 21
    TabOrder = 13
    OnChange = Edit14Change
  end
  object Edit15: TEdit
    Left = 296
    Top = 296
    Width = 25
    Height = 21
    TabOrder = 14
    OnChange = Edit15Change
  end
  object Edit16: TEdit
    Left = 296
    Top = 320
    Width = 25
    Height = 21
    TabOrder = 15
    OnChange = Edit16Change
  end
  object Edit17: TEdit
    Left = 296
    Top = 344
    Width = 25
    Height = 21
    TabOrder = 16
    OnChange = Edit17Change
  end
  object Edit18: TEdit
    Left = 296
    Top = 368
    Width = 25
    Height = 21
    TabOrder = 17
    OnChange = Edit18Change
  end
  object Edit19: TEdit
    Left = 296
    Top = 392
    Width = 25
    Height = 21
    TabOrder = 18
    OnChange = Edit19Change
  end
  object EditNAdresses: TEdit
    Left = 16
    Top = 120
    Width = 25
    Height = 21
    TabOrder = 19
    Text = '1'
    OnChange = EditNAdressesChange
  end
  object BitBtnOk: TBitBtn
    Left = 136
    Top = 432
    Width = 75
    Height = 25
    TabOrder = 20
    OnClick = BitBtnOkClick
    Kind = bkOK
  end
end
