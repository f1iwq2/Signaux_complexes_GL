object FormTCO: TFormTCO
  Left = 1395
  Top = 198
  Width = 1139
  Height = 694
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
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDockOver = FormDockOver
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  DesignSize = (
    1123
    656)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelX: TLabel
    Left = 64
    Top = 0
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
    Left = 8
    Top = 0
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
    Left = 88
    Top = 0
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
  object SourisX: TLabel
    Left = 128
    Top = 2
    Width = 6
    Height = 13
    Caption = '0'
  end
  object SourisY: TLabel
    Left = 168
    Top = 2
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ImageTemp: TImage
    Left = 24
    Top = 394
    Width = 97
    Height = 97
  end
  object Label19: TLabel
    Left = 1059
    Top = 407
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
    Top = 18
    Width = 1036
    Height = 375
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight]
    BevelEdges = [beLeft, beTop, beRight]
    TabOrder = 0
    DesignSize = (
      1032
      371)
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 1012
      Height = 303
      Anchors = [akLeft, akTop, akRight, akBottom]
      PopupMenu = PopupMenu1
      OnClick = ImageTCOClick
      OnContextPopup = ImageTCOContextPopup
      OnDblClick = ImageTCODblClick
      OnDragOver = ImageTCODragOver
      OnMouseDown = ImageTCOMouseDown
      OnMouseMove = ImageTCOMouseMove
      OnMouseUp = ImageTCOMouseUp
    end
  end
  object TrackBarZoom: TTrackBar
    Left = 1051
    Top = 34
    Width = 41
    Height = 366
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
    Top = 479
    Width = 1100
    Height = 166
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      1100
      166)
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
    object ImagePalette1: TImage
      Left = 216
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette1EndDrag
      OnMouseDown = ImagePalette1MouseDown
    end
    object ImagePalette6: TImage
      Left = 216
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette6EndDrag
      OnMouseDown = ImagePalette6MouseDown
    end
    object ImagePalette7: TImage
      Left = 288
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette7EndDrag
      OnMouseDown = ImagePalette7MouseDown
    end
    object ImagePalette8: TImage
      Left = 360
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette8EndDrag
      OnMouseDown = ImagePalette8MouseDown
    end
    object ImagePalette9: TImage
      Left = 432
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette9EndDrag
      OnMouseDown = ImagePalette9MouseDown
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
    object ImagePalette10: TImage
      Left = 216
      Top = 104
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageDiag10EndDrag
      OnMouseDown = ImagePalette10MouseDown
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
    object ImagePalette11: TImage
      Left = 288
      Top = 104
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImageDiag11EndDrag
      OnMouseDown = ImagePalette11MouseDown
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
    object ImagePalette30: TImage
      Left = 376
      Top = 104
      Width = 25
      Height = 41
      DragMode = dmAutomatic
      Stretch = True
      OnEndDrag = ImagePalette30EndDrag
      OnMouseDown = ImagePalette30MouseDown
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
    object ImagePalette12: TImage
      Left = 576
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette12EndDrag
      OnMouseDown = ImagePalette12MouseDown
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
    object ImagePalette13: TImage
      Left = 648
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette13EndDrag
      OnMouseDown = ImagePalette13MouseDown
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
    object ImagePalette14: TImage
      Left = 720
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette14EndDrag
      OnMouseDown = ImagePalette14MouseDown
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
    object ImagePalette15: TImage
      Left = 792
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette15EndDrag
      OnMouseDown = ImagePalette15MouseDown
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
    object ImagePalette16: TImage
      Left = 504
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette16EndDrag
      OnMouseDown = ImagePalette16MouseDown
    end
    object Label24: TLabel
      Left = 480
      Top = 70
      Width = 18
      Height = 19
      Caption = '16'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette17: TImage
      Left = 576
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette17EndDrag
      OnMouseDown = ImagePalette17MouseDown
    end
    object Label25: TLabel
      Left = 552
      Top = 70
      Width = 18
      Height = 19
      Caption = '17'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette18: TImage
      Left = 648
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette18EndDrag
      OnMouseDown = ImagePalette18MouseDown
    end
    object Label26: TLabel
      Left = 624
      Top = 70
      Width = 18
      Height = 19
      Caption = '18'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette19: TImage
      Left = 720
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette19EndDrag
      OnMouseDown = ImagePalette19MouseDown
    end
    object Label27: TLabel
      Left = 696
      Top = 70
      Width = 18
      Height = 19
      Caption = '19'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette20: TImage
      Left = 792
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette20EndDrag
      OnMouseDown = ImagePalette20MouseDown
    end
    object Label28: TLabel
      Left = 768
      Top = 70
      Width = 18
      Height = 19
      Caption = '20'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette21: TImage
      Left = 864
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette21EndDrag
      OnMouseDown = ImagePalette21MouseDown
    end
    object Label29: TLabel
      Left = 840
      Top = 22
      Width = 18
      Height = 19
      Caption = '21'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette22: TImage
      Left = 936
      Top = 8
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnEndDrag = ImagePalette22EndDrag
      OnMouseDown = ImagePalette22MouseDown
    end
    object Label30: TLabel
      Left = 912
      Top = 22
      Width = 18
      Height = 19
      Caption = '22'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
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
      OnKeyDown = EditAdrElementKeyDown
    end
    object EditTypeElement: TEdit
      Left = 152
      Top = 32
      Width = 33
      Height = 28
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
      Left = 992
      Top = 48
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Sauvegarder TCO'
      TabOrder = 3
      WordWrap = True
      OnClick = ButtonSauveTCOClick
    end
    object ButtonRedessine: TButton
      Left = 992
      Top = 8
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Redessine'
      TabOrder = 4
      OnClick = ButtonRedessineClick
    end
    object Button1: TButton
      Left = 440
      Top = 112
      Width = 89
      Height = 25
      Caption = 'Simu det 1'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 536
      Top = 112
      Width = 89
      Height = 25
      Caption = 'Simu Det 0'
      TabOrder = 6
      OnClick = Button2Click
    end
    object ButtonConfigTCO: TButton
      Left = 992
      Top = 88
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
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
    object ButtonSimu: TButton
      Left = 632
      Top = 112
      Width = 113
      Height = 25
      Caption = 'Simu canton occup'#233
      TabOrder = 9
      OnClick = ButtonSimuClick
    end
    object CheckPinv: TCheckBox
      Left = 16
      Top = 120
      Width = 161
      Height = 17
      Caption = 'Pilotage aiguillage invers'#233
      TabOrder = 10
      OnClick = CheckPinvClick
    end
    object ButtonMasquer: TButton
      Left = 992
      Top = 128
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Masquer bandeau'
      TabOrder = 11
      WordWrap = True
      OnClick = ButtonMasquerClick
    end
    object ButtonConstruit: TButton
      Left = 880
      Top = 88
      Width = 89
      Height = 33
      Caption = 'Construit TCO'
      TabOrder = 12
      OnClick = ButtonConstruitClick
    end
  end
  object ButtonAfficheBandeau: TButton
    Left = 1051
    Top = 431
    Width = 57
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Affiche Bandeau'
    TabOrder = 3
    WordWrap = True
    OnClick = ButtonAfficheBandeauClick
  end
  object PopupMenu1: TPopupMenu
    Left = 360
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
    object N5: TMenuItem
      Caption = '-'
    end
    object Annulercouper: TMenuItem
      Caption = 'Annuler couper'
      OnClick = AnnulercouperClick
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
