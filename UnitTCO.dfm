object FormTCO: TFormTCO
  Left = 333
  Top = 121
  Width = 928
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
  OnCreate = FormCreate
  OnDockOver = FormDockOver
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LabelX: TLabel
    Left = 32
    Top = 14
    Width = 53
    Height = 19
    Caption = 'LabelX'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 13
    Height = 13
    Caption = 'X='
  end
  object Label3: TLabel
    Left = 104
    Top = 16
    Width = 13
    Height = 13
    Caption = 'X='
  end
  object LabelY: TLabel
    Left = 120
    Top = 14
    Width = 51
    Height = 19
    Caption = 'Label1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 776
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label4: TLabel
    Left = 24
    Top = 480
    Width = 175
    Height = 25
    Caption = 'Adresse de l'#39#233'l'#233'ment: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 512
    Width = 150
    Height = 25
    Caption = 'Type de l'#39#233'l'#233'ment: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
  end
  object ImagePalette1: TImage
    Left = 440
    Top = 480
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImagePalette1EndDrag
    OnMouseDown = ImagePalette1MouseDown
  end
  object ImagePalette2: TImage
    Left = 512
    Top = 480
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImagePalette2EndDrag
    OnMouseDown = ImagePalette2MouseDown
  end
  object ImagePalette3: TImage
    Left = 584
    Top = 480
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImagePalette3EndDrag
    OnMouseDown = ImagePalette3MouseDown
  end
  object ImagePalette4: TImage
    Left = 656
    Top = 480
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImagePalette4EndDrag
    OnMouseDown = ImagePalette4MouseDown
  end
  object ImagePaletteDroit: TImage
    Left = 440
    Top = 528
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImagePaletteDroitEndDrag
    OnMouseDown = ImagePaletteDroitMouseDown
  end
  object ImageSupG: TImage
    Left = 512
    Top = 528
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImageSupGEndDrag
    OnMouseDown = ImageSupGMouseDown
  end
  object ImageSupD: TImage
    Left = 584
    Top = 528
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImageSupDEndDrag
    OnMouseDown = ImageSupDMouseDown
  end
  object ImageInfD: TImage
    Left = 656
    Top = 528
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImageInfDEndDrag
    OnMouseDown = ImageInfDMouseDown
  end
  object ImageInfG: TImage
    Left = 728
    Top = 528
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImageInfGEndDrag
    OnMouseDown = ImageInfGMouseDown
  end
  object Label6: TLabel
    Left = 424
    Top = 488
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
    Left = 496
    Top = 488
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
  object Label8: TLabel
    Left = 568
    Top = 488
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
    Left = 640
    Top = 488
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
    Left = 424
    Top = 536
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
    Left = 496
    Top = 536
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
    Left = 568
    Top = 536
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
    Left = 640
    Top = 536
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
    Left = 712
    Top = 536
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
  object Label15: TLabel
    Left = 24
    Top = 544
    Width = 158
    Height = 25
    Caption = 'Image de l'#39#233'l'#233'ment: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
  end
  object ImageDiag1: TImage
    Left = 440
    Top = 576
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImageDiag1EndDrag
    OnMouseDown = ImageDiag1MouseDown
  end
  object Label16: TLabel
    Left = 416
    Top = 584
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
    Left = 512
    Top = 576
    Width = 41
    Height = 41
    DragMode = dmAutomatic
    OnEndDrag = ImageDiag2EndDrag
    OnMouseDown = ImageDiag2MouseDown
  end
  object Label17: TLabel
    Left = 488
    Top = 584
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
    Left = 200
    Top = 10
    Width = 83
    Height = 13
    Caption = 'Taille des cellules'
  end
  object Label19: TLabel
    Left = 336
    Top = 10
    Width = 5
    Height = 13
    Caption = '/'
  end
  object EditAdrElement: TEdit
    Left = 200
    Top = 480
    Width = 89
    Height = 33
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = EditAdrElementChange
  end
  object EditTypeElement: TEdit
    Left = 200
    Top = 512
    Width = 89
    Height = 33
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = 'EditTypeElement'
  end
  object ButtonSauveTCO: TButton
    Left = 784
    Top = 480
    Width = 91
    Height = 33
    Caption = 'Sauvegarder TCO'
    TabOrder = 2
    WordWrap = True
    OnClick = ButtonSauveTCOClick
  end
  object ButtonRedessine: TButton
    Left = 784
    Top = 520
    Width = 89
    Height = 33
    Caption = 'Redessine'
    TabOrder = 3
    OnClick = ButtonRedessineClick
  end
  object ScrollBox: TScrollBox
    Left = 16
    Top = 40
    Width = 865
    Height = 433
    TabOrder = 4
    object ImageTCO: TImage
      Left = 0
      Top = 0
      Width = 857
      Height = 425
      PopupMenu = PopupMenu1
      OnClick = ImageTCOClick
      OnContextPopup = ImageTCOContextPopup
      OnDragOver = ImageTCODragOver
      OnMouseDown = ImageTCOMouseDown
      OnMouseMove = ImageTCOMouseMove
      OnMouseUp = ImageTCOMouseUp
    end
  end
  object EditTypeImage: TEdit
    Left = 200
    Top = 552
    Width = 89
    Height = 33
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'EditTypeImage'
    OnKeyPress = EditTypeImageKeyPress
  end
  object Button1: TButton
    Left = 784
    Top = 560
    Width = 89
    Height = 25
    Caption = 'Simu det 1'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 792
    Top = 592
    Width = 75
    Height = 25
    Caption = 'Simu Det 0'
    TabOrder = 7
    OnClick = Button2Click
  end
  object EditCellX: TEdit
    Left = 296
    Top = 8
    Width = 33
    Height = 21
    TabOrder = 8
    Text = 'EditCellX'
    OnKeyPress = EditCellXKeyPress
  end
  object EditCellY: TEdit
    Left = 352
    Top = 8
    Width = 33
    Height = 21
    TabOrder = 9
    Text = 'EditCellY'
    OnKeyPress = EditCellYKeyPress
  end
  object PopupMenu1: TPopupMenu
    Left = 352
    Top = 472
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
    object Insrer1: TMenuItem
      Caption = 'Ins'#233'rer'
      object aiguillageG_PG: TMenuItem
        Caption = 'Aiguillage gauche ; pointe '#224' gauche'
        OnClick = aiguillageG_PGClick
      end
      object aiguillageD_PD: TMenuItem
        Caption = 'Aiguillage droit ; pointe '#224' droite'
        OnClick = aiguillageD_PDClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Aiguillagegauchepointedroite1: TMenuItem
        Caption = 'Aiguillage gauche ; pointe '#224' droite'
        OnClick = Aiguillagegauchepointedroite1Click
      end
      object Aiguillagedroitpointegauche1: TMenuItem
        Caption = 'Aiguillage droit : pointe '#224' gauche'
        OnClick = Aiguillagedroitpointegauche1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Elmentdroit1: TMenuItem
        Caption = 'El'#233'ment droit'
        OnClick = Elmentdroit1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Courbegaucheversdroite1: TMenuItem
        Caption = 'Courbe infD'
        OnClick = Courbegaucheversdroite1Click
      end
      object Courbedroiteversgauche1: TMenuItem
        Caption = 'Courbe infG'
        OnClick = Courbedroiteversgauche1Click
      end
      object CourbeSupD1: TMenuItem
        Caption = 'Courbe SupD'
        OnClick = CourbeSupD1Click
      end
      object CourbeSupG1: TMenuItem
        Caption = 'Courbe SupG'
        OnClick = CourbeSupG1Click
      end
    end
  end
end
