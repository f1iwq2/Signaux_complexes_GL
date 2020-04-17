object FormTCO: TFormTCO
  Left = 232
  Top = 211
  Width = 992
  Height = 681
  VertScrollBar.Visible = False
  Caption = 'FormTCO'
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDockOver = FormDockOver
  OnKeyDown = FormKeyDown
  DesignSize = (
    976
    643)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelX: TLabel
    Left = 72
    Top = 6
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 6
    Width = 49
    Height = 16
    Caption = 'Cellule'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelY: TLabel
    Left = 96
    Top = 6
    Width = 7
    Height = 16
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 776
    Top = 8
    Width = 3
    Height = 13
    Caption = '-'
  end
  object SourisX: TLabel
    Left = 232
    Top = 8
    Width = 6
    Height = 13
    Caption = '0'
  end
  object SourisY: TLabel
    Left = 288
    Top = 8
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ImageTemp: TImage
    Left = 16
    Top = 464
    Width = 97
    Height = 97
  end
  object Label19: TLabel
    Left = 912
    Top = 456
    Width = 32
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 'Zoom'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScrollBox: TScrollBox
    Left = 8
    Top = 32
    Width = 889
    Height = 433
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      885
      429)
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 865
      Height = 361
      Anchors = [akLeft, akTop, akRight, akBottom]
      PopupMenu = PopupMenu1
      OnClick = ImageTCOClick
      OnContextPopup = ImageTCOContextPopup
      OnDragOver = ImageTCODragOver
      OnMouseDown = ImageTCOMouseDown
      OnMouseMove = ImageTCOMouseMove
      OnMouseUp = ImageTCOMouseUp
    end
  end
  object TrackBarZoom: TTrackBar
    Left = 912
    Top = 40
    Width = 41
    Height = 409
    Anchors = [akTop, akRight, akBottom]
    Max = 50
    Min = 20
    Orientation = trVertical
    Position = 20
    TabOrder = 1
    TickMarks = tmTopLeft
    OnChange = TrackBarZoomChange
  end
  object Panel1: TPanel
    Left = 8
    Top = 472
    Width = 953
    Height = 153
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 8
      Width = 137
      Height = 20
      Caption = 'Adresse de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 32
      Width = 116
      Height = 20
      Caption = 'Type de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 8
      Top = 56
      Width = 123
      Height = 20
      Caption = 'Image de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object ImagePalette5: TImage
      Left = 504
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette5EndDrag
      OnMouseDown = ImagePalette5MouseDown
    end
    object Label6: TLabel
      Left = 200
      Top = 22
      Width = 9
      Height = 19
      Caption = '1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette2: TImage
      Left = 288
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette2EndDrag
      OnMouseDown = ImagePalette2MouseDown
    end
    object Label7: TLabel
      Left = 272
      Top = 22
      Width = 9
      Height = 19
      Caption = '2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 488
      Top = 22
      Width = 9
      Height = 19
      Caption = '5'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePaletteDroit: TImage
      Left = 216
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePaletteDroitEndDrag
      OnMouseDown = ImagePaletteDroitMouseDown
    end
    object ImageSupG: TImage
      Left = 216
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageSupGEndDrag
      OnMouseDown = ImageSupGMouseDown
    end
    object ImageSupD: TImage
      Left = 288
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageSupDEndDrag
      OnMouseDown = ImageSupDMouseDown
    end
    object ImageInfD: TImage
      Left = 360
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageInfDEndDrag
      OnMouseDown = ImageInfDMouseDown
    end
    object ImageInfG: TImage
      Left = 432
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageInfGEndDrag
      OnMouseDown = ImageInfGMouseDown
    end
    object Label11: TLabel
      Left = 200
      Top = 70
      Width = 9
      Height = 19
      Caption = '6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 272
      Top = 70
      Width = 9
      Height = 19
      Caption = '7'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 344
      Top = 70
      Width = 9
      Height = 19
      Caption = '8'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 416
      Top = 70
      Width = 9
      Height = 19
      Caption = '9'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette3: TImage
      Left = 360
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette3EndDrag
      OnMouseDown = ImagePalette3MouseDown
    end
    object ImagePalette4: TImage
      Left = 432
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette4EndDrag
      OnMouseDown = ImagePalette4MouseDown
    end
    object Label8: TLabel
      Left = 344
      Top = 22
      Width = 9
      Height = 19
      Caption = '3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 416
      Top = 22
      Width = 9
      Height = 19
      Caption = '4'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageDiag1: TImage
      Left = 216
      Top = 104
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageDiag1EndDrag
      OnMouseDown = ImageDiag1MouseDown
    end
    object Label16: TLabel
      Left = 192
      Top = 118
      Width = 18
      Height = 19
      Caption = '10'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageDiag2: TImage
      Left = 288
      Top = 104
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageDiag2EndDrag
      OnMouseDown = ImageDiag2MouseDown
    end
    object Label17: TLabel
      Left = 264
      Top = 118
      Width = 17
      Height = 19
      Caption = '11'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageFeu: TImage
      Left = 368
      Top = 104
      Width = 25
      Height = 41
      DragMode = dmAutomatic
      Stretch = True
      OnEndDrag = ImageFeuEndDrag
      OnMouseDown = ImageFeuMouseDown
    end
    object Label18: TLabel
      Left = 336
      Top = 118
      Width = 18
      Height = 19
      Caption = '30'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageAig45PG_AG: TImage
      Left = 576
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageAig45PG_AGEndDrag
      OnMouseDown = ImageAig45PG_AGMouseDown
    end
    object Label20: TLabel
      Left = 552
      Top = 22
      Width = 18
      Height = 19
      Caption = '12'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 624
      Top = 22
      Width = 18
      Height = 19
      Caption = '13'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageAig45PD_AD: TImage
      Left = 648
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageAig45PD_ADEndDrag
      OnMouseDown = ImageAig45PD_ADMouseDown
    end
    object Label21: TLabel
      Left = 696
      Top = 22
      Width = 18
      Height = 19
      Caption = '14'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageAig45PD_AG: TImage
      Left = 720
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageAig45PD_AGEndDrag
      OnMouseDown = ImageAig45PD_AGMouseDown
    end
    object Label22: TLabel
      Left = 768
      Top = 22
      Width = 18
      Height = 19
      Caption = '15'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImageAig45PG_AD: TImage
      Left = 792
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageAig45PG_ADEndDrag
      OnMouseDown = ImageAig45PG_ADMouseDown
    end
    object Label23: TLabel
      Left = 8
      Top = 85
      Width = 33
      Height = 20
      Caption = 'Texte'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object EditAdrElement: TEdit
      Left = 152
      Top = 8
      Width = 33
      Height = 28
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = EditAdrElementChange
    end
    object EditTypeElement: TEdit
      Left = 152
      Top = 32
      Width = 33
      Height = 33
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object EditTypeImage: TEdit
      Left = 152
      Top = 56
      Width = 33
      Height = 28
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnKeyPress = EditTypeImageKeyPress
    end
    object ButtonSauveTCO: TButton
      Left = 854
      Top = 48
      Width = 91
      Height = 33
      Caption = 'Sauvegarder TCO'
      TabOrder = 3
      WordWrap = True
      OnClick = ButtonSauveTCOClick
    end
    object ButtonRedessine: TButton
      Left = 856
      Top = 8
      Width = 89
      Height = 33
      Caption = 'Redessine'
      TabOrder = 4
      OnClick = ButtonRedessineClick
    end
    object Button1: TButton
      Left = 672
      Top = 88
      Width = 89
      Height = 25
      Caption = 'Simu det 1'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 672
      Top = 120
      Width = 89
      Height = 25
      Caption = 'Simu Det 0'
      TabOrder = 6
      OnClick = Button2Click
    end
    object ButtonConfigTCO: TButton
      Left = 832
      Top = 88
      Width = 113
      Height = 33
      Caption = 'Configuration TCO'
      TabOrder = 7
      OnClick = ButtonConfigTCOClick
    end
    object EditTexte: TEdit
      Left = 96
      Top = 88
      Width = 89
      Height = 21
      TabOrder = 8
      OnChange = EditTexteChange
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    object Annulercouper: TMenuItem
      Caption = 'Annuler couper'
      OnClick = AnnulercouperClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object MenuCouper: TMenuItem
      Caption = 'Couper'
      OnClick = MenuCouperClick
    end
    object MenuCopier: TMenuItem
      Caption = 'Copier'
      OnClick = MenuCopierClick
    end
    object MenuColler: TMenuItem
      Caption = 'Coller'
      OnClick = MenuCollerClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Tourner90G: TMenuItem
      Caption = 'Positionner 90'#176' '#224' gauche'
      OnClick = Tourner90GClick
    end
    object Tourner90D: TMenuItem
      Caption = 'Positionner 90'#176' '#224' droite'
      OnClick = Tourner90DClick
    end
    object Pos_vert: TMenuItem
      Caption = 'Positionner verticalement'
      OnClick = Pos_vertClick
    end
  end
end
