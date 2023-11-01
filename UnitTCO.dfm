object FormTCO: TFormTCO
  Left = 14
  Top = 171
  Width = 1212
  Height = 580
  VertScrollBar.Visible = False
  Caption = 'c'
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenuTCO
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDragOver = FormDragOver
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseWheel = FormMouseWheel
  DesignSize = (
    1204
    529)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelZoom: TLabel
    Left = 1167
    Top = 3
    Width = 32
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Zoom'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ImageTemp: TImage
    Left = 731
    Top = 123
    Width = 121
    Height = 121
  end
  object ImageTemp2: TImage
    Left = 995
    Top = 76
    Width = 121
    Height = 121
  end
  object ScrollBox: TScrollBox
    Left = 10
    Top = 7
    Width = 946
    Height = 258
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
      942
      254)
    object ImageTCO: TImage
      Left = 56
      Top = 33
      Width = 745
      Height = 168
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = True
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      OnDblClick = ImageTCODblClick
      OnDragOver = ImageTCODragOver
      OnMouseDown = ImageTCOMouseDown
      OnMouseMove = ImageTCOMouseMove
      OnMouseUp = ImageTCOMouseUp
    end
  end
  object TrackBarZoom: TTrackBar
    Left = 1157
    Top = 18
    Width = 41
    Height = 311
    Anchors = [akTop, akRight]
    Ctl3D = True
    Max = 100
    Min = 15
    Orientation = trVertical
    ParentCtl3D = False
    Position = 78
    TabOrder = 0
    TabStop = False
    TickMarks = tmTopLeft
    OnChange = TrackBarZoomChange
  end
  object Panel1: TPanel
    Left = 2
    Top = 332
    Width = 1143
    Height = 185
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
      1143
      185)
    object Label1: TLabel
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
    object Label2: TLabel
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
    object Label5: TLabel
      Left = 440
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
    object Label6: TLabel
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
    object Label7: TLabel
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
    object Label8: TLabel
      Left = 328
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
    object Label9: TLabel
      Left = 384
      Top = 62
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
    object Label3: TLabel
      Left = 328
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
    object Label4: TLabel
      Left = 384
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
    object Label10: TLabel
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
    object Label11: TLabel
      Left = 272
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
    object Label50: TLabel
      Left = 680
      Top = 110
      Width = 18
      Height = 19
      Caption = '50'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 488
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
    object Label13: TLabel
      Left = 552
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
    object Label14: TLabel
      Left = 608
      Top = 14
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
    object Label15: TLabel
      Left = 664
      Top = 14
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
    object Label16: TLabel
      Left = 432
      Top = 62
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
    object Label17: TLabel
      Left = 488
      Top = 62
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
    object Label18: TLabel
      Left = 544
      Top = 62
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
    object Label19: TLabel
      Left = 608
      Top = 62
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
    object Label20: TLabel
      Left = 664
      Top = 62
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
    object Label21: TLabel
      Left = 728
      Top = 14
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
    object Label22: TLabel
      Left = 784
      Top = 14
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
    object Label51: TLabel
      Left = 720
      Top = 110
      Width = 18
      Height = 19
      Caption = '51'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 728
      Top = 62
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
    object Label25: TLabel
      Left = 792
      Top = 62
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
      Width = 33
      Height = 33
      OnDragOver = ImagePalette1DragOver
      OnEndDrag = ImagePalette1EndDrag
      OnMouseDown = ImagePalette1MouseDown
    end
    object ImagePalette2: TImage
      Left = 288
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette2DragOver
      OnEndDrag = ImagePalette2EndDrag
      OnMouseDown = ImagePalette2MouseDown
    end
    object ImagePalette3: TImage
      Left = 344
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette3DragOver
      OnEndDrag = ImagePalette3EndDrag
      OnMouseDown = ImagePalette3MouseDown
    end
    object ImagePalette4: TImage
      Left = 400
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette4DragOver
      OnEndDrag = ImagePalette4EndDrag
      OnMouseDown = ImagePalette4MouseDown
    end
    object ImagePalette5: TImage
      Left = 448
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette5DragOver
      OnEndDrag = ImagePalette5EndDrag
      OnMouseDown = ImagePalette5MouseDown
    end
    object ImagePalette12: TImage
      Left = 512
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette12DragOver
      OnEndDrag = ImagePalette12EndDrag
      OnMouseDown = ImagePalette12MouseDown
    end
    object ImagePalette13: TImage
      Left = 576
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette13DragOver
      OnEndDrag = ImagePalette13EndDrag
      OnMouseDown = ImagePalette13MouseDown
    end
    object ImagePalette14: TImage
      Left = 624
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette14DragOver
      OnEndDrag = ImagePalette14EndDrag
      OnMouseDown = ImagePalette14MouseDown
    end
    object ImagePalette15: TImage
      Left = 688
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette15DragOver
      OnEndDrag = ImagePalette15EndDrag
      OnMouseDown = ImagePalette15MouseDown
    end
    object ImagePalette21: TImage
      Left = 752
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette21DragOver
      OnEndDrag = ImagePalette21EndDrag
      OnMouseDown = ImagePalette21MouseDown
    end
    object ImagePalette22: TImage
      Left = 808
      Top = 8
      Width = 33
      Height = 33
      OnDragOver = ImagePalette22DragOver
      OnEndDrag = ImagePalette22EndDrag
      OnMouseDown = ImagePalette22MouseDown
    end
    object ImagePalette6: TImage
      Left = 232
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette6DragOver
      OnEndDrag = ImagePalette6EndDrag
      OnMouseDown = ImagePalette6MouseDown
    end
    object ImagePalette7: TImage
      Left = 288
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette7DragOver
      OnEndDrag = ImagePalette7EndDrag
      OnMouseDown = ImagePalette7MouseDown
    end
    object ImagePalette9: TImage
      Left = 400
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette9DragOver
      OnEndDrag = ImagePalette9EndDrag
      OnMouseDown = ImagePalette9MouseDown
    end
    object ImagePalette16: TImage
      Left = 448
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette16DragOver
      OnEndDrag = ImagePalette16EndDrag
      OnMouseDown = ImagePalette16MouseDown
    end
    object ImagePalette17: TImage
      Left = 504
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette17DragOver
      OnEndDrag = ImagePalette17EndDrag
      OnMouseDown = ImagePalette17MouseDown
    end
    object ImagePalette18: TImage
      Left = 576
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette18DragOver
      OnEndDrag = ImagePalette18EndDrag
      OnMouseDown = ImagePalette18MouseDown
    end
    object ImagePalette19: TImage
      Left = 624
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette19DragOver
      OnEndDrag = ImagePalette19EndDrag
      OnMouseDown = ImagePalette19MouseDown
    end
    object ImagePalette20: TImage
      Left = 688
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette20DragOver
      OnEndDrag = ImagePalette20EndDrag
      OnMouseDown = ImagePalette20MouseDown
    end
    object ImagePalette24: TImage
      Left = 752
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette24DragOver
      OnEndDrag = ImagePalette24EndDrag
      OnMouseDown = ImagePalette24MouseDown
    end
    object ImagePalette25: TImage
      Left = 808
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette25DragOver
      OnEndDrag = ImagePalette25EndDrag
      OnMouseDown = ImagePalette25MouseDown
    end
    object ImagePalette10: TImage
      Left = 232
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette10DragOver
      OnEndDrag = ImagePalette10EndDrag
      OnMouseDown = ImagePalette10MouseDown
    end
    object ImagePalette11: TImage
      Left = 288
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette11DragOver
      OnEndDrag = ImagePalette11EndDrag
      OnMouseDown = ImagePalette11MouseDown
    end
    object ImagePalette51: TImage
      Left = 736
      Top = 104
      Width = 33
      Height = 33
      Hint = 'Quai'
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette51DragOver
      OnEndDrag = ImagePalette51EndDrag
      OnMouseDown = ImagePalette51MouseDown
    end
    object ImagePalette50: TImage
      Left = 696
      Top = 104
      Width = 25
      Height = 41
      Hint = 'Signal'
      ParentShowHint = False
      ShowHint = True
      Stretch = True
      OnDragOver = ImagePalette50DragOver
      OnEndDrag = ImagePalette50EndDrag
      OnMouseDown = ImagePalette50MouseDown
    end
    object ImagePalette8: TImage
      Left = 344
      Top = 56
      Width = 33
      Height = 33
      OnDragOver = ImagePalette8DragOver
      OnEndDrag = ImagePalette8EndDrag
      OnMouseDown = ImagePalette8MouseDown
    end
    object ImagePalette26: TImage
      Left = 344
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette26DragOver
      OnEndDrag = ImagePalette26EndDrag
      OnMouseDown = ImagePalette26MouseDown
    end
    object Label26: TLabel
      Left = 320
      Top = 118
      Width = 18
      Height = 19
      Caption = '26'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette23: TImage
      Left = 496
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette23DragOver
      OnEndDrag = ImagePalette23EndDrag
      OnMouseDown = ImagePalette23MouseDown
    end
    object Label23: TLabel
      Left = 480
      Top = 110
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
    object Label27: TLabel
      Left = 376
      Top = 118
      Width = 18
      Height = 19
      Caption = '27'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette27: TImage
      Left = 400
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette27DragOver
      OnEndDrag = ImagePalette27EndDrag
      OnMouseDown = ImagePalette27MouseDown
    end
    object ImagePalette28: TImage
      Left = 448
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette28DragOver
      OnEndDrag = ImagePalette28EndDrag
      OnMouseDown = ImagePalette28MouseDown
    end
    object Label28: TLabel
      Left = 432
      Top = 110
      Width = 18
      Height = 19
      Caption = '28'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label29: TLabel
      Left = 536
      Top = 110
      Width = 18
      Height = 19
      Caption = '29'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette29: TImage
      Left = 552
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette29DragOver
      OnEndDrag = ImagePalette29EndDrag
      OnMouseDown = ImagePalette29MouseDown
    end
    object Label32: TLabel
      Left = 584
      Top = 110
      Width = 18
      Height = 19
      Caption = '32'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette32: TImage
      Left = 600
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette32DragOver
      OnEndDrag = ImagePalette32EndDrag
      OnMouseDown = ImagePalette32MouseDown
    end
    object Label33: TLabel
      Left = 632
      Top = 110
      Width = 18
      Height = 19
      Caption = '33'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette33: TImage
      Left = 648
      Top = 104
      Width = 33
      Height = 33
      OnDragOver = ImagePalette33DragOver
      OnEndDrag = ImagePalette33EndDrag
      OnMouseDown = ImagePalette33MouseDown
    end
    object Label34: TLabel
      Left = 208
      Top = 150
      Width = 18
      Height = 19
      Caption = '34'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ImagePalette34: TImage
      Left = 232
      Top = 144
      Width = 33
      Height = 33
      OnDragOver = ImagePalette34DragOver
      OnEndDrag = ImagePalette34EndDrag
      OnMouseDown = ImagePalette34MouseDown
    end
    object ImagePalette52: TImage
      Left = 808
      Top = 104
      Width = 33
      Height = 33
      Hint = 'Action'
      ParentShowHint = False
      ShowHint = True
      OnDragOver = ImagePalette52DragOver
      OnEndDrag = ImagePalette52EndDrag
      OnMouseDown = ImagePalette52MouseDown
    end
    object Label52: TLabel
      Left = 776
      Top = 110
      Width = 18
      Height = 19
      Caption = '52'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ButtonSauveTCO: TButton
      Left = 1037
      Top = 64
      Width = 96
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Sauvegarder TCO'
      TabOrder = 0
      TabStop = False
      WordWrap = True
      OnClick = ButtonSauveTCOClick
    end
    object Button1: TButton
      Left = 478
      Top = 152
      Width = 57
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Simu det 1'
      TabOrder = 1
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 414
      Top = 152
      Width = 57
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Simu Det 0'
      TabOrder = 2
      TabStop = False
      OnClick = Button2Click
    end
    object ButtonConfigTCO: TButton
      Left = 1037
      Top = 104
      Width = 96
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Configuration TCO'
      TabOrder = 3
      TabStop = False
      OnClick = ButtonConfigTCOClick
    end
    object ButtonSimu: TButton
      Left = 566
      Top = 152
      Width = 113
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Simu canton occup'#233
      TabOrder = 4
      TabStop = False
      OnClick = ButtonSimuClick
    end
    object ButtonMasquer: TButton
      Left = 1037
      Top = 144
      Width = 96
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Masquer bandeau'
      TabOrder = 5
      TabStop = False
      WordWrap = True
      OnClick = ButtonMasquerClick
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 185
      Height = 169
      Caption = 'Configuration cellule'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBackground
      Font.Height = -15
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object Label41: TLabel
        Left = 8
        Top = 24
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
      object Label71: TLabel
        Left = 8
        Top = 46
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
      object Label230: TLabel
        Left = 56
        Top = 72
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
      object Label65: TLabel
        Left = 8
        Top = 96
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
        Top = 146
        Width = 18
        Height = 18
      end
      object EditAdrElement: TEdit
        Left = 144
        Top = 20
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
        OnClick = EditAdrElementClick
      end
      object EditTypeImage: TEdit
        Left = 144
        Top = 44
        Width = 33
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        OnChange = EditTypeImageChange
      end
      object ButtonFonte: TButton
        Left = 8
        Top = 72
        Width = 41
        Height = 17
        Caption = 'Fonte'
        TabOrder = 2
        OnClick = ButtonFonteClick
      end
      object EditTexte: TEdit
        Left = 88
        Top = 70
        Width = 89
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clBackground
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = EditTexteChange
      end
      object ComboRepr: TComboBox
        Left = 88
        Top = 96
        Width = 89
        Height = 21
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clBackground
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 4
        TabStop = False
        OnChange = ComboReprChange
        Items.Strings = (
          'Sans'
          'Centrale'
          'Haut'
          'Bas'
          'R'#233'parti'
          'Centr'#233)
      end
      object CheckPinv: TCheckBox
        Left = 8
        Top = 126
        Width = 113
        Height = 17
        Hint = 'Cocher si l'#39'aiguillage est repr'#233'sent'#233' invers'#233
        Caption = 'aiguillage invers'#233
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = CheckPinvClick
      end
      object ButtonCoulFond: TButton
        Left = 80
        Top = 146
        Width = 81
        Height = 18
        Caption = 'Couleur de fond'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBackground
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = ButtonCoulFondClick
      end
    end
    object buttonRaz: TButton
      Left = 931
      Top = 144
      Width = 97
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Raz des occupations'
      TabOrder = 7
      TabStop = False
      WordWrap = True
      OnClick = buttonRazClick
    end
    object ButtonCalibrage: TButton
      Left = 686
      Top = 152
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Calibrage'
      TabOrder = 8
      TabStop = False
      OnClick = ButtonCalibrageClick
    end
    object ButtonDessiner: TButton
      Left = 931
      Top = 104
      Width = 97
      Height = 33
      Hint = 
        'Dessine le TCO '#224' la souris. Clic droit pour lever le pointeur. T' +
        'ouche Echap pour quitter le mode trac'#233'.'
      Anchors = [akTop, akRight]
      Caption = 'Dessiner le TCO'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      TabStop = False
      OnClick = ButtonDessinerClick
    end
    object ButtonAffSC: TButton
      Left = 931
      Top = 64
      Width = 97
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Afficher Signaux Complexes'
      TabOrder = 10
      TabStop = False
      WordWrap = True
      OnClick = ButtonAffSCClick
    end
    object RadioGroupSel: TRadioGroup
      Left = 959
      Top = 8
      Width = 169
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'Outil de s'#233'lection'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Cellules s'#233'lectionn'#233'es'
        'fen'#234'tre d'#233'pla'#231'able')
      ParentFont = False
      TabOrder = 11
      OnClick = RadioGroupSelClick
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 368
    Top = 8
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
      Caption = 'Annuler    ctrl+Z'
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
  object MainMenuTCO: TMainMenu
    Left = 1000
    Top = 48
    object MenuTCO: TMenuItem
      Caption = 'TCO'
      object SauvegarderleTCO1: TMenuItem
        Caption = 'Sauvegarder le TCO'
        OnClick = SauvegarderleTCO1Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object DessinerleTCO1: TMenuItem
        Caption = 'Dessiner le TCO'
        OnClick = DessinerleTCO1Click
      end
      object ConfigurationduTCO1: TMenuItem
        Caption = 'Configuration du TCO'
        OnClick = ConfigurationduTCO1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Redessine1: TMenuItem
        Caption = 'Redessine'
        OnClick = Redessine1Click
      end
    end
    object Affichebandeau1: TMenuItem
      Caption = 'Affiche bandeau'
      OnClick = Affichebandeau1Click
    end
    object Affichage1: TMenuItem
      Caption = 'Affichage'
      object Mosaquehorizontale1: TMenuItem
        Caption = 'Mosa'#239'que horizontale'
        OnClick = Mosaquehorizontale1Click
      end
      object Mosaqueverticale1: TMenuItem
        Caption = 'Mosa'#239'que verticale'
        OnClick = Mosaqueverticale1Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object AfficherSignauxComplexes1: TMenuItem
        Caption = 'Afficher Signaux Complexes'
        OnClick = AfficherSignauxComplexes1Click
      end
    end
  end
end
