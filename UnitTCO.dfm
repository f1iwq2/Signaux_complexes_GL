object FormTCO: TFormTCO
  Left = 162
  Top = 174
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
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = [beLeft, beTop, beRight]
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    DesignSize = (
      1032
      371)
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 1009
      Height = 353
      Anchors = [akLeft, akTop, akRight, akBottom]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
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
    OnDragOver = Panel1DragOver
    DesignSize = (
      1100
      166)
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 103
      Height = 16
      Caption = 'Adresse de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 8
      Top = 38
      Width = 93
      Height = 16
      Caption = 'Image de l'#39#233'l'#233'ment: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      OnDragOver = ImagePalette5DragOver
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
      OnDragOver = ImagePalette2DragOver
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
      Hint = 'Voie pouvant porter un d'#233'tecteur'
      DragMode = dmAutomatic
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette1DragOver
      OnEndDrag = ImagePalette1EndDrag
      OnMouseDown = ImagePalette1MouseDown
    end
    object ImagePalette6: TImage
      Left = 216
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnDragOver = ImagePalette6DragOver
      OnEndDrag = ImagePalette6EndDrag
      OnMouseDown = ImagePalette6MouseDown
    end
    object ImagePalette7: TImage
      Left = 288
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnDragOver = ImagePalette7DragOver
      OnEndDrag = ImagePalette7EndDrag
      OnMouseDown = ImagePalette7MouseDown
    end
    object ImagePalette8: TImage
      Left = 360
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnDragOver = ImagePalette8DragOver
      OnEndDrag = ImagePalette8EndDrag
      OnMouseDown = ImagePalette8MouseDown
    end
    object ImagePalette9: TImage
      Left = 432
      Top = 56
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      OnDragOver = ImagePalette9DragOver
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
      OnDragOver = ImagePalette3DragOver
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
      OnDragOver = ImagePalette10DragOver
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
      OnDragOver = ImagePalette11DragOver
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
      Left = 440
      Top = 104
      Width = 25
      Height = 41
      Hint = 'Signal'
      DragMode = dmAutomatic
      ParentShowHint = False
      ShowHint = True
      Stretch = True
      OnDragOver = ImagePalette30DragOver
      OnEndDrag = ImagePalette30EndDrag
      OnMouseDown = ImagePalette30MouseDown
    end
    object Label18: TLabel
      Left = 408
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
      OnDragOver = ImagePalette12DragOver
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
      OnDragOver = ImagePalette13DragOver
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
      OnDragOver = ImagePalette14DragOver
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
      OnDragOver = ImagePalette15DragOver
      OnEndDrag = ImagePalette15EndDrag
      OnMouseDown = ImagePalette15MouseDown
    end
    object Label23: TLabel
      Left = 56
      Top = 64
      Width = 27
      Height = 16
      Caption = 'Texte'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      OnDragOver = ImagePalette16DragOver
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
      OnDragOver = ImagePalette17DragOver
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
      OnDragOver = ImagePalette18DragOver
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
      OnDragOver = ImagePalette19DragOver
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
      OnDragOver = ImagePalette20DragOver
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
      Hint = 'Croisement ou TJD ou TJS'
      DragMode = dmAutomatic
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette21DragOver
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
      Hint = 'Croisement ou TJD ou TJS'
      DragMode = dmAutomatic
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette22DragOver
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
    object Label1: TLabel
      Left = 8
      Top = 88
      Width = 75
      Height = 16
      Caption = 'position du texte'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object ImagePalette23: TImage
      Left = 360
      Top = 104
      Width = 41
      Height = 41
      Hint = 'Quai'
      DragMode = dmAutomatic
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette23DragOver
      OnEndDrag = ImagePalette23EndDrag
      OnMouseDown = ImagePalette23MouseDown
    end
    object Label31: TLabel
      Left = 336
      Top = 118
      Width = 18
      Height = 19
      Caption = '23'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EditAdrElement: TEdit
      Left = 144
      Top = 16
      Width = 33
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = EditAdrElementChange
      OnKeyDown = EditAdrElementKeyDown
    end
    object EditTypeImage: TEdit
      Left = 144
      Top = 40
      Width = 33
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = EditTypeImageKeyPress
    end
    object ButtonSauveTCO: TButton
      Left = 992
      Top = 48
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Sauvegarder TCO'
      TabOrder = 2
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
      TabOrder = 3
      OnClick = ButtonRedessineClick
    end
    object Button1: TButton
      Left = 784
      Top = 112
      Width = 89
      Height = 25
      Caption = 'Simu det 1'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 880
      Top = 112
      Width = 89
      Height = 25
      Caption = 'Simu Det 0'
      TabOrder = 5
      OnClick = Button2Click
    end
    object ButtonConfigTCO: TButton
      Left = 992
      Top = 88
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Configuration TCO'
      TabOrder = 6
      OnClick = ButtonConfigTCOClick
    end
    object EditTexte: TEdit
      Left = 88
      Top = 64
      Width = 89
      Height = 21
      TabOrder = 7
      OnChange = EditTexteChange
    end
    object ButtonSimu: TButton
      Left = 864
      Top = 80
      Width = 113
      Height = 25
      Caption = 'Simu canton occup'#233
      TabOrder = 8
      OnClick = ButtonSimuClick
    end
    object CheckPinv: TCheckBox
      Left = 16
      Top = 112
      Width = 161
      Height = 17
      Caption = 'aiguillage invers'#233
      TabOrder = 9
      OnClick = CheckPinvClick
    end
    object ButtonMasquer: TButton
      Left = 992
      Top = 128
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Masquer bandeau'
      TabOrder = 10
      WordWrap = True
      OnClick = ButtonMasquerClick
    end
    object ComboRepr: TComboBox
      Left = 88
      Top = 88
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 11
      OnChange = ComboReprChange
      Items.Strings = (
        'Sans'
        'Centrale'
        'Haut'
        'Bas')
    end
    object ButtonFonte: TButton
      Left = 8
      Top = 64
      Width = 41
      Height = 17
      Caption = 'Fonte'
      TabOrder = 12
      OnClick = ButtonFonteClick
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
      Caption = 'Positionner feu 90'#176' '#224' gauche'
      OnClick = Tourner90GClick
    end
    object Tourner90D: TMenuItem
      Caption = 'Positionner feu 90'#176' '#224' droite'
      OnClick = Tourner90DClick
    end
    object Pos_vert: TMenuItem
      Caption = 'Positionner feu verticalement'
      OnClick = Pos_vertClick
    end
  end
  object FontDialog1: TFontDialog
    OnShow = FontDialog1Show
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 256
    Top = 432
  end
end
