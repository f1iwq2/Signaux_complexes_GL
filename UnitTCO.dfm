object FormTCO: TFormTCO
  Left = 147
  Top = 77
  Width = 1141
  Height = 678
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
  OnCreate = FormCreate
  OnDragOver = FormDragOver
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseWheel = FormMouseWheel
  DesignSize = (
    1133
    647)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelCoord: TLabel
    Left = 64
    Top = 0
    Width = 18
    Height = 16
    Caption = '0,0'
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
  object Label19: TLabel
    Left = 1077
    Top = 391
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
  object ImageTemp: TImage
    Left = 888
    Top = 96
    Width = 97
    Height = 97
  end
  object ImageTemp2: TImage
    Left = 888
    Top = 208
    Width = 97
    Height = 97
  end
  object ScrollBox: TScrollBox
    Left = 8
    Top = 18
    Width = 827
    Height = 351
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = [beLeft, beTop, beRight]
    Color = clBlack
    ParentColor = False
    TabOrder = 1
    DesignSize = (
      823
      347)
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 715
      Height = 305
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = True
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      OnContextPopup = ImageTCOContextPopup
      OnDblClick = ImageTCODblClick
      OnDragOver = ImageTCODragOver
      OnMouseDown = ImageTCOMouseDown
      OnMouseMove = ImageTCOMouseMove
      OnMouseUp = ImageTCOMouseUp
    end
  end
  object TrackBarZoom: TTrackBar
    Left = 1077
    Top = 18
    Width = 41
    Height = 350
    Anchors = [akTop, akRight, akBottom]
    Ctl3D = True
    Max = 50
    Min = 20
    Orientation = trVertical
    ParentCtl3D = False
    Position = 20
    TabOrder = 0
    TabStop = False
    TickMarks = tmTopLeft
    OnChange = TrackBarZoomChange
  end
  object Panel1: TPanel
    Left = 0
    Top = 464
    Width = 1123
    Height = 173
    Anchors = [akLeft, akRight, akBottom]
    Color = clActiveBorder
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnDragOver = Panel1DragOver
    DesignSize = (
      1123
      173)
    object Label6: TLabel
      Left = 216
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
    object Label7: TLabel
      Left = 288
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
      Left = 504
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
    object Label11: TLabel
      Left = 216
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
      Left = 288
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
      Left = 360
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
      Left = 432
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
    object Label8: TLabel
      Left = 360
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
      Left = 432
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
    object Label16: TLabel
      Left = 208
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
    object Label17: TLabel
      Left = 280
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
    object Label18: TLabel
      Left = 352
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
    object Label20: TLabel
      Left = 568
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
      Left = 640
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
    object Label21: TLabel
      Left = 712
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
    object Label22: TLabel
      Left = 784
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
    object Label24: TLabel
      Left = 496
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
    object Label25: TLabel
      Left = 568
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
    object Label26: TLabel
      Left = 640
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
    object Label27: TLabel
      Left = 712
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
    object Label28: TLabel
      Left = 784
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
    object Label29: TLabel
      Left = 856
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
    object Label30: TLabel
      Left = 928
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
    object Label31: TLabel
      Left = 424
      Top = 118
      Width = 18
      Height = 19
      Caption = '31'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 856
      Top = 70
      Width = 18
      Height = 19
      Caption = '24'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label32: TLabel
      Left = 928
      Top = 70
      Width = 18
      Height = 19
      Caption = '25'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette1: TImage
      Left = 232
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette1DragOver
      OnEndDrag = ImagePalette1EndDrag
      OnMouseDown = ImagePalette1MouseDown
    end
    object ImagePalette2: TImage
      Left = 304
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette2DragOver
      OnEndDrag = ImagePalette2EndDrag
      OnMouseDown = ImagePalette2MouseDown
    end
    object ImagePalette3: TImage
      Left = 376
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette3DragOver
      OnEndDrag = ImagePalette3EndDrag
      OnMouseDown = ImagePalette3MouseDown
    end
    object ImagePalette4: TImage
      Left = 448
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette4DragOver
      OnEndDrag = ImagePalette4EndDrag
      OnMouseDown = ImagePalette4MouseDown
    end
    object ImagePalette5: TImage
      Left = 520
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette5DragOver
      OnEndDrag = ImagePalette5EndDrag
      OnMouseDown = ImagePalette5MouseDown
    end
    object ImagePalette12: TImage
      Left = 592
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette12DragOver
      OnEndDrag = ImagePalette12EndDrag
      OnMouseDown = ImagePalette12MouseDown
    end
    object ImagePalette13: TImage
      Left = 664
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette13DragOver
      OnEndDrag = ImagePalette13EndDrag
      OnMouseDown = ImagePalette13MouseDown
    end
    object ImagePalette14: TImage
      Left = 736
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette14DragOver
      OnEndDrag = ImagePalette14EndDrag
      OnMouseDown = ImagePalette14MouseDown
    end
    object ImagePalette15: TImage
      Left = 808
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette15DragOver
      OnEndDrag = ImagePalette15EndDrag
      OnMouseDown = ImagePalette15MouseDown
    end
    object ImagePalette21: TImage
      Left = 880
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette21DragOver
      OnEndDrag = ImagePalette21EndDrag
      OnMouseDown = ImagePalette21MouseDown
    end
    object ImagePalette22: TImage
      Left = 952
      Top = 8
      Width = 41
      Height = 41
      OnDragOver = ImagePalette22DragOver
      OnEndDrag = ImagePalette22EndDrag
      OnMouseDown = ImagePalette22MouseDown
    end
    object ImagePalette6: TImage
      Left = 232
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette6DragOver
      OnEndDrag = ImagePalette6EndDrag
      OnMouseDown = ImagePalette6MouseDown
    end
    object ImagePalette7: TImage
      Left = 304
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette7DragOver
      OnEndDrag = ImagePalette7EndDrag
      OnMouseDown = ImagePalette7MouseDown
    end
    object ImagePalette9: TImage
      Left = 448
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette9DragOver
      OnEndDrag = ImagePalette9EndDrag
      OnMouseDown = ImagePalette9MouseDown
    end
    object ImagePalette16: TImage
      Left = 520
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette16DragOver
      OnEndDrag = ImagePalette16EndDrag
      OnMouseDown = ImagePalette16MouseDown
    end
    object ImagePalette17: TImage
      Left = 592
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette17DragOver
      OnEndDrag = ImagePalette17EndDrag
      OnMouseDown = ImagePalette17MouseDown
    end
    object ImagePalette18: TImage
      Left = 664
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette18DragOver
      OnEndDrag = ImagePalette18EndDrag
      OnMouseDown = ImagePalette18MouseDown
    end
    object ImagePalette19: TImage
      Left = 736
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette19DragOver
      OnEndDrag = ImagePalette19EndDrag
      OnMouseDown = ImagePalette19MouseDown
    end
    object ImagePalette20: TImage
      Left = 808
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette20DragOver
      OnEndDrag = ImagePalette20EndDrag
      OnMouseDown = ImagePalette20MouseDown
    end
    object ImagePalette24: TImage
      Left = 880
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette24DragOver
      OnEndDrag = ImagePalette24EndDrag
      OnMouseDown = ImagePalette24MouseDown
    end
    object ImagePalette25: TImage
      Left = 952
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette25DragOver
      OnEndDrag = ImagePalette25EndDrag
      OnMouseDown = ImagePalette25MouseDown
    end
    object ImagePalette10: TImage
      Left = 232
      Top = 104
      Width = 41
      Height = 41
      OnDragOver = ImagePalette10DragOver
      OnEndDrag = ImagePalette10EndDrag
      OnMouseDown = ImagePalette10MouseDown
    end
    object ImagePalette11: TImage
      Left = 304
      Top = 104
      Width = 41
      Height = 41
      OnDragOver = ImagePalette11DragOver
      OnEndDrag = ImagePalette11EndDrag
      OnMouseDown = ImagePalette11MouseDown
    end
    object ImagePalette31: TImage
      Left = 448
      Top = 104
      Width = 41
      Height = 41
      Hint = 'Quai'
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette31DragOver
      OnEndDrag = ImagePalette31EndDrag
      OnMouseDown = ImagePalette31MouseDown
    end
    object ImagePalette30: TImage
      Left = 384
      Top = 104
      Width = 25
      Height = 41
      Hint = 'Signal'
      ParentShowHint = False
      ShowHint = True
      Stretch = True
      OnDragOver = ImagePalette30DragOver
      OnEndDrag = ImagePalette30EndDrag
      OnMouseDown = ImagePalette30MouseDown
    end
    object ImagePalette8: TImage
      Left = 376
      Top = 56
      Width = 41
      Height = 41
      OnDragOver = ImagePalette8DragOver
      OnEndDrag = ImagePalette8EndDrag
      OnMouseDown = ImagePalette8MouseDown
    end
    object ButtonSauveTCO: TButton
      Left = 1015
      Top = 48
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Sauvegarder TCO'
      TabOrder = 0
      TabStop = False
      WordWrap = True
      OnClick = ButtonSauveTCOClick
    end
    object ButtonRedessine: TButton
      Left = 1015
      Top = 8
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Redessine'
      TabOrder = 1
      TabStop = False
      OnClick = ButtonRedessineClick
    end
    object Button1: TButton
      Left = 496
      Top = 136
      Width = 89
      Height = 25
      Caption = 'Simu det 1'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 496
      Top = 104
      Width = 89
      Height = 25
      Caption = 'Simu Det 0'
      TabOrder = 3
      OnClick = Button2Click
    end
    object ButtonConfigTCO: TButton
      Left = 1015
      Top = 88
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Configuration TCO'
      TabOrder = 4
      TabStop = False
      OnClick = ButtonConfigTCOClick
    end
    object ButtonSimu: TButton
      Left = 592
      Top = 128
      Width = 113
      Height = 25
      Caption = 'Simu canton occup'#233
      TabOrder = 5
      OnClick = ButtonSimuClick
    end
    object ButtonMasquer: TButton
      Left = 1015
      Top = 128
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Masquer bandeau'
      TabOrder = 6
      TabStop = False
      WordWrap = True
      OnClick = ButtonMasquerClick
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 185
      Height = 153
      Caption = 'Configuration cellule'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBackground
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
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
      object ShapeCoulFond: TShape
        Left = 160
        Top = 130
        Width = 18
        Height = 18
      end
      object EditAdrElement: TEdit
        Left = 144
        Top = 12
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
      end
      object EditTypeImage: TEdit
        Left = 144
        Top = 36
        Width = 33
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = EditTypeImageChange
      end
      object ButtonFonte: TButton
        Left = 8
        Top = 64
        Width = 41
        Height = 17
        Caption = 'Fonte'
        TabOrder = 2
        OnClick = ButtonFonteClick
      end
      object EditTexte: TEdit
        Left = 88
        Top = 60
        Width = 89
        Height = 21
        TabOrder = 3
        OnChange = EditTexteChange
      end
      object ComboRepr: TComboBox
        Left = 88
        Top = 84
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        TabStop = False
        OnChange = ComboReprChange
        Items.Strings = (
          'Sans'
          'Centrale'
          'Haut'
          'Bas')
      end
      object CheckPinv: TCheckBox
        Left = 8
        Top = 110
        Width = 113
        Height = 17
        Hint = 'Cocher si l'#39'aiguillage est repr'#233'sent'#233' invers'#233
        Caption = 'aiguillage invers'#233
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = CheckPinvClick
      end
      object ButtonCoulFond: TButton
        Left = 80
        Top = 130
        Width = 81
        Height = 18
        Caption = 'Couleur de fond'
        TabOrder = 6
        OnClick = ButtonCoulFondClick
      end
    end
    object buttonRaz: TButton
      Left = 911
      Top = 128
      Width = 92
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Raz des occupations'
      TabOrder = 8
      TabStop = False
      WordWrap = True
      OnClick = buttonRazClick
    end
    object ButtonCalibrage: TButton
      Left = 592
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Calibrage'
      TabOrder = 9
      OnClick = ButtonCalibrageClick
    end
    object ButtonDessiner: TButton
      Left = 816
      Top = 128
      Width = 89
      Height = 33
      Hint = 
        'Dessine le TCO '#224' la souris. Clic droit pour lever le pointeur. T' +
        'ouche Echap pour quitter le mode trac'#233'.'
      Anchors = [akTop, akRight]
      Caption = 'Dessiner le TCO'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = ButtonDessinerClick
    end
  end
  object ButtonAfficheBandeau: TButton
    Left = 1069
    Top = 415
    Width = 57
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Affiche Bandeau'
    TabOrder = 3
    WordWrap = True
    OnClick = ButtonAfficheBandeauClick
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
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
    object Signal1: TMenuItem
      Caption = 'Signal'
      object Tourner90G: TMenuItem
        Caption = 'Signal 90'#176' '#224' gauche'
        OnClick = Tourner90GClick
      end
      object Tourner90D: TMenuItem
        Caption = 'Signal 90'#176' '#224' droite'
        OnClick = Tourner90DClick
      end
      object Pos_vert: TMenuItem
        Caption = 'Signal vertical'
        OnClick = Pos_vertClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Signalgauchedelavoie1: TMenuItem
        Caption = 'Signal '#224' gauche de la voie'
        OnClick = Signalgauchedelavoie1Click
      end
      object Signaldroitedelavoie1: TMenuItem
        Caption = 'Signal '#224' droite de la voie'
        OnClick = Signaldroitedelavoie1Click
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object outslectionner1: TMenuItem
      Caption = 'Tout s'#233'lectionner'
      OnClick = outslectionner1Click
    end
    object Inserer: TMenuItem
      Caption = 'Inserer'
      object LigneDessus: TMenuItem
        Caption = 'Ligne au dessus'
        Hint = 'ins'#232're une ligne au dessus'
        OnClick = LigneDessusClick
      end
      object LigneDessous: TMenuItem
        Caption = 'Ligne en dessous'
        OnClick = LigneDessousClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Colonnegauche1: TMenuItem
        Caption = 'Colonne '#224' gauche'
        OnClick = Colonnegauche1Click
      end
      object Colonnedroite1: TMenuItem
        Caption = 'Colonne '#224' droite'
        OnClick = Colonnedroite1Click
      end
    end
    object Supprimer: TMenuItem
      Caption = 'Supprimer'
      object SupprimeLigne: TMenuItem
        Caption = 'Ligne'
        OnClick = SupprimeLigneClick
      end
      object Colonne: TMenuItem
        Caption = 'Colonne'
        OnClick = ColonneClick
      end
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = 'Propri'#233't'#233's'
      OnClick = N3Click
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
  object ColorDialog1: TColorDialog
    OnShow = ColorDialog1Show
    Left = 448
    Top = 432
  end
end
