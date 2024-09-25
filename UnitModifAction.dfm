object FormModifAction: TFormModifAction
  Left = 448
  Top = 165
  BorderStyle = bsDialog
  Caption = 'Modifier une action'
  ClientHeight = 443
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 16
    Top = 10
    Width = 62
    Height = 16
    Caption = 'Action(s)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelInfo: TLabel
    Left = 316
    Top = 416
    Width = 3
    Height = 13
  end
  object ButtonOk: TButton
    Left = 16
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = ButtonOkClick
  end
  object ComboBoxActions: TComboBox
    Left = 88
    Top = 8
    Width = 585
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBoxActionsChange
  end
  object PageControlAct: TPageControl
    Left = 8
    Top = 64
    Width = 729
    Height = 337
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 2
    object TabSheetDecl: TTabSheet
      Caption = 'D'#233'clencheur'
      object LabelDecl: TLabel
        Left = 16
        Top = 24
        Width = 193
        Height = 13
        Caption = 'Liste de d'#233'clencheurs disponibles'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ListBoxDeclench: TListBox
        Left = 0
        Top = 60
        Width = 201
        Height = 189
        ItemHeight = 13
        TabOrder = 0
        OnDrawItem = ListBoxDeclenchDrawItem
      end
      object GroupBoxDecl: TGroupBox
        Left = 224
        Top = 52
        Width = 481
        Height = 149
        Caption = 'Param'#232'tres du d'#233'clencheur '
        TabOrder = 1
        object LabelAdresse: TLabel
          Left = 16
          Top = 36
          Width = 38
          Height = 13
          Caption = 'Adresse'
          WordWrap = True
        end
        object LabelTrain: TLabel
          Left = 8
          Top = 112
          Width = 86
          Height = 13
          Caption = 'Train d'#233'clencheur'
          WordWrap = True
        end
        object LabelEtat: TLabel
          Left = 32
          Top = 72
          Width = 19
          Height = 13
          Caption = 'Etat'
        end
        object Labelheure: TLabel
          Left = 120
          Top = 36
          Width = 6
          Height = 13
          Caption = 'h'
        end
        object ImageIcone: TImage
          Left = 304
          Top = 24
          Width = 16
          Height = 16
        end
        object EditAdr: TEdit
          Left = 80
          Top = 32
          Width = 33
          Height = 21
          Hint = 'Adresse'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = EditAdrChange
        end
        object EditAdr2: TEdit
          Left = 136
          Top = 32
          Width = 33
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnChange = EditAdr2Change
        end
        object EditTrainDecl: TEdit
          Left = 120
          Top = 112
          Width = 241
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnChange = EditTrainDeclChange
        end
        object SpinEditEtat: TSpinEdit
          Left = 80
          Top = 68
          Width = 33
          Height = 22
          MaxValue = 2
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = SpinEditEtatChange
        end
        object RadioEtatSignal: TRadioGroup
          Left = 152
          Top = 24
          Width = 433
          Height = 73
          Caption = 'Etat de changements du signal'
          Items.Strings = (
            'Ouverture inconditionnelle du signal (quitte le rouge)'
            
              'Ouverture du signal sur VL (passage au vert, vert cli, blanc, bl' +
              'anc cli)'
            
              'Ouverture restreinte du signal (passage '#224' l'#39'avertissement, ralen' +
              ' ou rappel)'
            'Fermeture du signal (passage au carr'#233', s'#233'maphore,violet)')
          TabOrder = 4
          OnClick = RadioEtatSignalClick
        end
      end
      object RichEditInf: TRichEdit
        Left = 224
        Top = 216
        Width = 481
        Height = 73
        ReadOnly = True
        TabOrder = 2
      end
      object ButtonApplDecl: TButton
        Left = 16
        Top = 276
        Width = 75
        Height = 25
        Hint = 'Application du d'#233'clencheur '#224' l'#39'action s'#233'lectionn'#233'e'
        Caption = 'Appliquer >>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ButtonApplDeclClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Conditions'
      ImageIndex = 1
      object Label4: TLabel
        Left = 16
        Top = 24
        Width = 169
        Height = 13
        Caption = 'Liste de conditions diponibles'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape2: TShape
        Left = 232
        Top = 8
        Width = 3
        Height = 293
        Brush.Color = clBlack
      end
      object Label6: TLabel
        Left = 258
        Top = 8
        Width = 118
        Height = 13
        Caption = 'Condition '#224' observer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ListBoxCondTot: TListBox
        Left = 0
        Top = 60
        Width = 201
        Height = 185
        ItemHeight = 13
        TabOrder = 0
        OnDrawItem = ListBoxCondTotDrawItem
      end
      object ListBoxConditions: TListBox
        Left = 248
        Top = 28
        Width = 201
        Height = 201
        Hint = 'Condition de r'#233'alisation du d'#233'clencheur'
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnDrawItem = ListBoxConditionsDrawItem
        OnMouseDown = ListBoxConditionsMouseDown
      end
      object GroupBox1: TGroupBox
        Left = 488
        Top = 24
        Width = 225
        Height = 265
        Caption = 'Param'#232'tres de la condition'
        TabOrder = 2
        object LabelHeureDebut: TLabel
          Left = 8
          Top = 86
          Width = 74
          Height = 13
          Caption = 'Heure de d'#233'but'
        end
        object LabelHeureFin: TLabel
          Left = 8
          Top = 104
          Width = 58
          Height = 13
          Caption = 'Heure de fin'
        end
        object LabelEtat2: TLabel
          Left = 8
          Top = 136
          Width = 19
          Height = 13
          Caption = 'Etat'
        end
        object ChampTrain: TLabeledEdit
          Left = 24
          Top = 184
          Width = 161
          Height = 21
          Hint = 'train'
          EditLabel.Width = 24
          EditLabel.Height = 13
          EditLabel.Caption = 'Train'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = ChampTrainChange
        end
        object Champ1: TLabeledEdit
          Left = 64
          Top = 40
          Width = 41
          Height = 21
          EditLabel.Width = 38
          EditLabel.Height = 13
          EditLabel.Caption = 'Adresse'
          EditLabel.WordWrap = True
          LabelPosition = lpLeft
          LabelSpacing = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnChange = Champ1Change
        end
        object Champ2: TLabeledEdit
          Left = 168
          Top = 40
          Width = 41
          Height = 21
          EditLabel.Width = 39
          EditLabel.Height = 13
          EditLabel.Caption = 'Champ2'
          EditLabel.WordWrap = True
          LabelPosition = lpLeft
          LabelSpacing = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnChange = Champ2Change
        end
        object SpinEditHeure1: TSpinEdit
          Left = 96
          Top = 80
          Width = 41
          Height = 22
          MaxValue = 23
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = SpinEditHeure1Change
        end
        object SpinEditMn1: TSpinEdit
          Left = 160
          Top = 80
          Width = 41
          Height = 22
          MaxValue = 59
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = SpinEditMn1Change
        end
        object SpinEditHeure2: TSpinEdit
          Left = 96
          Top = 104
          Width = 41
          Height = 22
          MaxValue = 23
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnChange = SpinEditHeure2Change
        end
        object SpinEditMn2: TSpinEdit
          Left = 160
          Top = 104
          Width = 41
          Height = 22
          MaxValue = 59
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = SpinEditMn2Change
        end
        object SpinEditEtat2: TSpinEdit
          Left = 96
          Top = 136
          Width = 33
          Height = 22
          MaxValue = 0
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Value = 0
          OnChange = SpinEditEtat2Change
        end
      end
      object ButtonAppCond: TButton
        Left = 16
        Top = 276
        Width = 75
        Height = 25
        Hint = 
          'Mise '#224' jour du champ de conditions vers le champ de  la liste de' +
          's conditions '#224' observer'
        Caption = 'Appliquer >>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = ButtonAppCondClick
      end
    end
    object TabSheetOp: TTabSheet
      Caption = 'Op'#233'rations'
      ImageIndex = 2
      object Shape1: TShape
        Left = 232
        Top = 8
        Width = 3
        Height = 293
        Brush.Color = clBlack
      end
      object Label3: TLabel
        Left = 258
        Top = 8
        Width = 157
        Height = 13
        Caption = 'Liste d'#39'op'#233'rations '#224' r'#233'aliser'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 8
        Width = 168
        Height = 13
        Caption = 'Liste d'#39'op'#233'rations disponibles'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButtonSupprime: TSpeedButton
        Left = 338
        Top = 255
        Width = 23
        Height = 22
        Hint = 'Supprime une op'#233'ration de la liste'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFF9FFFFFFF9
          9FFFFF999FFFFF9999FFF99999FFF999999F9999999F9999999FF99999999999
          99FFFF99999999999FFFFFF999999999FFFFFFFF9999999FFFFFFFF999999999
          FFFFFF99999999999FFFF9999999999999FF9999999F9999999F999999FFF999
          999FF9999FFFFF9999FFFF99FFFFFFF99FFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButtonSupprimeClick
      end
      object Label1: TLabel
        Left = 240
        Top = 258
        Width = 94
        Height = 13
        Caption = 'Supprimer op'#233'ration'
      end
      object ComboBoxFamille: TComboBox
        Left = 0
        Top = 32
        Width = 217
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBoxFamilleChange
      end
      object ListBoxOper: TListBox
        Left = 0
        Top = 60
        Width = 217
        Height = 185
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        OnDrawItem = ListBoxOperDrawItem
      end
      object ListBoxOperations: TListBox
        Left = 248
        Top = 28
        Width = 225
        Height = 201
        Hint = 'Liste chronologique des op'#233'rations '#224' effectuer'
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnDblClick = ListBoxOperationsDblClick
        OnDrawItem = ListBoxOperationsDrawItem
        OnKeyDown = ListBoxOperationsKeyDown
        OnMouseDown = ListBoxOperationsMouseDown
      end
      object GroupBoxParam: TGroupBox
        Left = 488
        Top = 24
        Width = 225
        Height = 265
        Caption = 'Param'#232'tres de l'#39'op'#233'ration'
        TabOrder = 3
        object SpeedButtonCharger: TSpeedButton
          Left = 128
          Top = 216
          Width = 25
          Height = 34
          Hint = 'Ouvre un fichier son WAV'
          Flat = True
          Glyph.Data = {
            BA060000424DBA06000000000000360400002800000019000000170000000100
            0800000000008402000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A6000020400000206000002080000020A0000020C0000020E000004000000040
            20000040400000406000004080000040A0000040C0000040E000006000000060
            20000060400000606000006080000060A0000060C0000060E000008000000080
            20000080400000806000008080000080A0000080C0000080E00000A0000000A0
            200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
            200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
            200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
            20004000400040006000400080004000A0004000C0004000E000402000004020
            20004020400040206000402080004020A0004020C0004020E000404000004040
            20004040400040406000404080004040A0004040C0004040E000406000004060
            20004060400040606000406080004060A0004060C0004060E000408000004080
            20004080400040806000408080004080A0004080C0004080E00040A0000040A0
            200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
            200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
            200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
            20008000400080006000800080008000A0008000C0008000E000802000008020
            20008020400080206000802080008020A0008020C0008020E000804000008040
            20008040400080406000804080008040A0008040C0008040E000806000008060
            20008060400080606000806080008060A0008060C0008060E000808000008080
            20008080400080806000808080008080A0008080C0008080E00080A0000080A0
            200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
            200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
            200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
            2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
            2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
            2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
            2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
            2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
            2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
            2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF0A0A00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF272727271C120A00FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF000000FF27BF7F77776F2727271D130A0000FFFFFF
            FFFFFFFFFFFFFF000000FF26F6BFBFBF7F7F7F77776F2F27271D130A0000FFFF
            FFFFFF000000FF2F6FF6BFBFBFBFBF7F7F7F7F7F7F6F2F2F270AFFFFFFFFFF00
            0000FF2727F6BFBFBFBFBFBF7F7F7F7F7F7F7F7F7726FFFFFFFFFF000000FF27
            6FF6BFBFBFBFBFBFBF7F7F7F7F7F7F7F7F2F00FFFFFFFF000000FF27BF6FF6BF
            BFBFBFBFBFBF7F7F7F7F7F7F7F771CFFFFFFFF000000FF27BF27F6BFBFBFBFBF
            BFBFBF7F7F7F7F7F7FBF2F00FFFFFF000000FF27BF2FF6BFBFBFBFBFBFBFBFBF
            7F7F7F7F7FBF7713FFFFFF000000FF277F376FF6BFBFBFBFBFBFBFBFBF7F7F7F
            7F7FBF2F00FFFF000000FF277F3727F6BFBFBFBFBFBFBFBFBFBF7F7F7F7FBF77
            0AFFFF000000FF277F372F27276FF6F6F6F6F6BFBFBFBFBF7F7F7FBF2700FF00
            0000FF277F37373737372F2F27276F77BFBFBFBFBFBFBFBF6F0AFF000000FF27
            7F373737373737373737372F2F276F6F7777777F7F1DFF000000FF277F373737
            3737373737373737373737372F6F2F272727FF000000FF277F37373737373737
            3737373737373737377FBF270A0AFF000000FF277F373737373737377FBFBFBF
            BFBFBFBFBFF6270AFFFFFF000000FF277F373737373737372666272727272727
            272752FFFFFFFF000000FF27BFBFBFBFBFBFBFBF25FFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000FF266F2727272727276F13FFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButtonChargerClick
        end
        object SpeedButtonJoue: TSpeedButton
          Left = 56
          Top = 216
          Width = 41
          Height = 33
          Hint = 'Joue le son'
          Flat = True
          Glyph.Data = {
            4E010000424D4E010000000000003E0000002800000022000000220000000100
            010000000000100100000000000000000000020000000000000000000000FFFF
            FF00FFFFFFFFC0000000FFFFFFFFC0000000FFFFFFFFC0000000C0000000C000
            0000800000004000000000000000000000001FFFFFFE000000003FFFFFFF0000
            00003FFFFFFF000000003FFFFFFF000000003FF8FFFF000000003FF03FFF0000
            00003FF00FFF000000003FF303FF000000003FF3C0FF000000003FF3F07F0000
            00003FF3FC7F000000003FF3FC7F000000003FF3E07F000000003FF381FF0000
            00003FF207FF000000003FF01FFF000000003FF07FFF000000003FF9FFFF0000
            00003FFFFFFF000000003FFFFFFF000000003FFFFFFF000000001FFFFFFE0000
            000000000000000000008000000040000000C0000000C0000000FFFFFFFFC000
            0000FFFFFFFFC0000000FFFFFFFFC0000000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButtonJoueClick
        end
        object LabelPeriph: TLabel
          Left = 24
          Top = 128
          Width = 62
          Height = 13
          Caption = 'P'#233'riph'#233'rique:'
        end
        object LabelEtatOp: TLabel
          Left = 128
          Top = 36
          Width = 19
          Height = 13
          Caption = 'Etat'
        end
        object LabeledEditTrain: TLabeledEdit
          Left = 16
          Top = 184
          Width = 161
          Height = 21
          Hint = 'train'
          EditLabel.Width = 24
          EditLabel.Height = 13
          EditLabel.Caption = 'Train'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = LabeledEditTrainChange
        end
        object LabeledEditAdresse: TLabeledEdit
          Left = 64
          Top = 32
          Width = 41
          Height = 21
          EditLabel.Width = 38
          EditLabel.Height = 13
          EditLabel.Caption = 'Adresse'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 1
          OnChange = LabeledEditAdresseChange
        end
        object LabeledEditFonctionF: TLabeledEdit
          Left = 144
          Top = 56
          Width = 41
          Height = 21
          EditLabel.Width = 47
          EditLabel.Height = 13
          EditLabel.Caption = 'FonctionF'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 2
          OnChange = LabeledEditFonctionFChange
        end
        object CheckBoxRAZ: TCheckBox
          Left = 24
          Top = 104
          Width = 145
          Height = 17
          Caption = 'Remise '#224' 0 apr'#232's pilotage'
          TabOrder = 3
          OnClick = CheckBoxRAZClick
        end
        object ComboBoxAccComUSB: TComboBox
          Left = 16
          Top = 144
          Width = 201
          Height = 21
          Hint = 'Nom de l'#39'accessoire d'#233'fini dans l'#39'onglet "p'#233'riph'#233'riques COM/USB"'
          Style = csDropDownList
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnChange = ComboBoxAccComUSBChange
        end
        object LabeledEditTempoF: TLabeledEdit
          Left = 144
          Top = 80
          Width = 33
          Height = 21
          EditLabel.Width = 72
          EditLabel.Height = 13
          EditLabel.Caption = 'Tempo x100ms'
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 5
          OnChange = LabeledEditTempoFChange
        end
        object SpinEditEtatop: TSpinEdit
          Left = 152
          Top = 32
          Width = 33
          Height = 22
          MaxValue = 0
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 0
          OnChange = SpinEditEtatopChange
        end
      end
      object ButtonAjouter: TButton
        Left = 128
        Top = 276
        Width = 75
        Height = 25
        Hint = 
          'Ajouter l'#39'op'#233'ration s'#233'lectionn'#233'e dans la liste des op'#233'rations '#224' ' +
          'r'#233'aliser'
        Caption = 'Ajouter >>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = ButtonAjouterClick
      end
      object ButtonAppAction: TButton
        Left = 16
        Top = 276
        Width = 75
        Height = 25
        Hint = 
          'Mise '#224' jour du champ d'#39'op'#233'ration vers le champ de  la liste d'#39'op' +
          #233'rations '#224' r'#233'aliser'
        Caption = 'Appliquer >>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = ButtonAppActionClick
      end
      object SpinButton1: TSpinButton
        Left = 400
        Top = 248
        Width = 33
        Height = 41
        Hint = 'Change l'#39'ordre d'#39'ex'#233'cution des op'#233'rations'
        DownGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000000000000080800000808000008080000080
          8000008080000080800000808000000000000000000000000000008080000080
          8000008080000080800000808000000000000000000000000000000000000000
          0000008080000080800000808000000000000000000000000000000000000000
          0000000000000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        UpGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000000000000000000000000000000000000000000000000000000000000080
          8000008080000080800000000000000000000000000000000000000000000080
          8000008080000080800000808000008080000000000000000000000000000080
          8000008080000080800000808000008080000080800000808000000000000080
          8000008080000080800000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        OnDownClick = SpinButton1DownClick
        OnUpClick = SpinButton1UpClick
      end
    end
  end
  object LabeledEditNomAct: TLabeledEdit
    Left = 88
    Top = 36
    Width = 225
    Height = 21
    Hint = 'Nom de l'#39'action au choix'
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = 'Nom de l'#39'action'
    LabelPosition = lpLeft
    LabelSpacing = 5
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = LabeledEditNomActChange
  end
  object OpenDialogSon: TOpenDialog
    Left = 680
  end
end
