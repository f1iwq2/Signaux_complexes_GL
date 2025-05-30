Unit UnitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , jpeg, ComCtrls ,StrUtils, Unitprinc,
  MMSystem, Buttons , UnitPareFeu, verif_version, Menus, ClipBrd,
  Grids , unitHorloge, spin, Valedit , Math

  {$IF CompilerVersion >= 28.0}
  ,Vcl.Themes, ImgList
  {$IFEND}
  ;

type
  TFormConfig = class(TForm)
    ButtonAppliquerEtFermer: TButton;
    LabelInfo: TLabel;
    ImageSignaux: TImage;
    PageControl: TPageControl;
    TabSheetCDM: TTabSheet;
    TabSheetAutonome: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditAdrIPCDM: TEdit;
    EditPortCDM: TEdit;
    GroupBox5: TGroupBox;
    CheckVerifVersion: TCheckBox;
    CheckInfoVersion: TCheckBox;
    CheckLanceCDM: TCheckBox;
    CheckAvecTCO: TCheckBox;
    GroupBox6: TGroupBox;
    RadioButtonSS: TRadioButton;
    RadioButtonXN: TRadioButton;
    RadioButtonP50: TRadioButton;
    RadioButtonSP: TRadioButton;
    RadioButtonHSI: TRadioButton;
    RadioButtonECOS: TRadioButton;
    GroupBox7: TGroupBox;
    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    RadioButton16: TRadioButton;
    RadioButton17: TRadioButton;
    RadioButton18: TRadioButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditcomUSB: TEdit;
    EditTempoOctetUSB: TEdit;
    EditTempoReponse: TEdit;
    GroupBox4: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditIPLenz: TEdit;
    EditportLenz: TEdit;
    GroupBox8: TGroupBox;
    CheckBoxServAig: TCheckBox;
    CheckBoxServDet: TCheckBox;
    CheckBoxServAct: TCheckBox;
    CheckServPosTrains: TCheckBox;
    Label6: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    TabSheetAig: TTabSheet;
    Label12: TLabel;
    TabSheetBranches: TTabSheet;
    Label14: TLabel;
    TabSheetSig: TTabSheet;
    Label15: TLabel;
    TabSheetPN: TTabSheet;
    CheckBoxSrvSig: TCheckBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    GroupBox9: TGroupBox;
    GroupBox11: TGroupBox;
    LabelAdresse: TLabel;
    GroupBox10: TGroupBox;
    RadioButtonsans: TRadioButton;
    RadioButton30kmh: TRadioButton;
    RadioButton60kmh: TRadioButton;
    ImageAig: TImage;
    ImageTJD: TImage;
    ImageTri: TImage;
    GroupBox12: TGroupBox;
    ImageSignal: TImage;
    LabelAdrSig: TLabel;
    GroupBox13: TGroupBox;
    LabelDec: TLabel;
    LabelDetAss: TLabel;
    LabelElSuiv: TLabel;
    Label17: TLabel;
    MemoCarre: TMemo;
    ListBoxAig: TListBox;
    ComboBoxDec: TComboBox;
    EditDet1: TEdit;
    EditSuiv1: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    EditDet2: TEdit;
    EditSuiv2: TEdit;
    Label26: TLabel;
    EditDet3: TEdit;
    EditSuiv3: TEdit;
    Label27: TLabel;
    EditDet4: TEdit;
    EditSuiv4: TEdit;
    CheckVerrouCarre: TCheckBox;
    CheckInverse: TCheckBox;
    CheckFenEt: TCheckBox;
    GroupBoxDivers: TGroupBox;
    CheckBoxInitAig: TCheckBox;
    EditAdrSig: TEdit;
    Label32: TLabel;
    EditTempoAig: TEdit;
    EditAdrAig: TEdit;
    ComboBoxAig: TComboBox;
    GroupBox16: TGroupBox;
    LabelHG: TLabel;
    Edit_HG: TEdit;
    LabelBG: TLabel;
    EditPointe_BG: TEdit;
    ImageAffiche: TImage;
    EditP1: TEdit;
    EditP2: TEdit;
    EditP3: TEdit;
    EditP4: TEdit;
    LabelHD: TLabel;
    EditDevie_HD: TEdit;
    LabelBD: TLabel;
    EditDroit_BD: TEdit;
    Label18: TLabel;
    EditDevieS2: TEdit;
    LabelTJD1: TLabel;
    LabelTJD2: TLabel;
    Label33: TLabel;
    ComboBoxAsp: TComboBox;
    EditSpecUni: TEdit;
    LabelUni: TLabel;
    Buttonrestaure: TButton;
    ButtonNouvSig: TButton;
    ButtonSupSig: TButton;
    ButtonInsSig: TButton;
    ButtonNouvAig: TButton;
    BoutSupAig: TButton;
    ButtonAjSup: TButton;
    ButtonRestaureAig: TButton;
    GroupBox20: TGroupBox;
    ButtonValLigne: TButton;
    RichBranche: TRichEdit;
    ButtonVerifConfig: TButton;
    LabelResult: TLabel;
    Label34: TLabel;
    EditAigTriple: TEdit;
    GroupBox21: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    EditTempo10: TEdit;
    Label41: TLabel;
    EditFonte: TEdit;
    ComboBoxDD: TComboBox;
    LabelL: TLabel;
    EditL: TEdit;
    CheckBoxFB: TCheckBox;
    Label20: TLabel;
    ButtonConfigSR: TButton;
    GroupBoxEtatTJD: TGroupBox;
    RadioButtonTJD2: TRadioButton;
    RadioButtonTJD4: TRadioButton;
    CheckBoxRazSignaux: TCheckBox;
    EditTempoSignal: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    OpenDialogSon: TOpenDialog;
    LabelNumBranche: TLabel;
    Label43: TLabel;
    CheckBandeauTCO: TCheckBox;
    CheckPosAig: TCheckBox;
    ButtonEnregistre: TButton;
    CheckBoxDemarUSB: TCheckBox;
    CheckBoxDemarEth: TCheckBox;
    Memo5: TMemo;
    EditLAY: TEdit;
    Label13: TLabel;
    CheckFVC: TCheckBox;
    CheckFRC: TCheckBox;
    Label40: TLabel;
    GroupBox22: TGroupBox;
    RadioButtonDCC: TRadioButton;
    RadioButtonXpress: TRadioButton;
    TabSheetDccpp: TTabSheet;
    RichCdeDccpp: TRichEdit;
    Label10: TLabel;
    ListBoxTrains: TListBox;
    ButtonNT: TButton;
    ButtonSupprime: TButton;
    GroupBox23: TGroupBox;
    CheckEnvAigDccpp: TCheckBox;
    Image2: TImage;
    ButtonEnv: TButton;
    Label19: TLabel;
    EditBase: TEdit;
    Label29: TLabel;
    TabSheetTrains: TTabSheet;
    Label54: TLabel;
    Label55: TLabel;
    EditDebug: TEdit;
    CheckBoxVerifXpressNet: TCheckBox;
    PopupMenuRichedit: TPopupMenu;
    Copier1: TMenuItem;
    Coller1: TMenuItem;
    CheckBoxVersContrevoie: TCheckBox;
    CheckBoxContreVoie: TCheckBox;
    RadioButtonSpecifique: TRadioButton;
    EditSpecifique: TEdit;
    TabSheetDecodeurs: TTabSheet;
    Label61: TLabel;
    Label62: TLabel;
    LabelDecal: TLabel;
    LabelSorties: TLabel;
    GroupBox26: TGroupBox;
    Label67: TLabel;
    ComboBoxDecodeurPerso: TComboBox;
    LabelNa: TLabel;
    EditNbreAdr: TEdit;
    Label64: TLabel;
    ComboBoxNation: TComboBox;
    BoutonNouveau: TButton;
    ButtonSup: TButton;
    Label68: TLabel;
    LabelNbDecPers: TLabel;
    MemoBlanc: TMemo;
    Label69: TLabel;
    LabelCrois: TLabel;
    ListBoxSig: TListBox;
    PopupMenuListes: TPopupMenu;
    Slectionnertout1: TMenuItem;
    Nouveau1: TMenuItem;
    Supprimer1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    outcopierentatquetexte1: TMenuItem;
    CheckBoxAffMemo: TCheckBox;
    TabSheetPeriph: TTabSheet;
    ListBoxPeriph: TListBox;
    ButtonAjAccCom: TButton;
    ButtonSupAccCom: TButton;
    GroupBoxDesc: TGroupBox;
    Label71: TLabel;
    EditNomPeriph: TEdit;
    Label73: TLabel;
    LabelInfoAcc: TLabel;
    ButtonOuvreCom: TButton;
    GroupBoxPNA: TGroupBox;
    GroupBoxPNZ: TGroupBox;
    GroupBoxPN: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    EditAdrFerme: TEdit;
    EditAdrOuvre: TEdit;
    EditCdeFerme: TEdit;
    EditCdeOuvre: TEdit;
    ButtonTestFerme: TButton;
    ButtonTestOuvre: TButton;
    CheckPnPulse: TCheckBox;
    RadioButtonSimple: TRadioButton;
    RadioButtonZone: TRadioButton;
    RadioGroupActPN: TRadioGroup;
    ComboBoxPNCom: TComboBox;
    RadioCdeDec: TRadioGroup;
    ComboBoxDecCde: TComboBox;
    LabelTypCde: TLabel;
    N3: TMenuItem;
    outslectionner1: TMenuItem;
    EditChercher: TEdit;
    ButtonCherche: TButton;
    SBMonte: TSpeedButton;
    SBDesc: TSpeedButton;
    Label23: TLabel;
    Label28: TLabel;
    EditPortServeur: TEdit;
    CheckBoxZ21: TCheckBox;
    RadioButtonDCCpp: TRadioButton;
    CheckBoxSombre: TCheckBox;
    ButtonCouleur: TButton;
    ColorDialogFond: TColorDialog;
    LabelD12: TLabel;
    ButtonPropage: TButton;
    ButtonPFCDM: TButton;
    TabAvance: TTabSheet;
    Label39: TLabel;
    CheckBoxMsgAigInc: TCheckBox;
    TabSheetActions: TTabSheet;
    GroupBox15: TGroupBox;
    ListBoxActions: TListBox;
    ListBoxOperations: TListBox;
    Label44: TLabel;
    Label48: TLabel;
    RichEditInfo: TRichEdit;
    Button1: TButton;
    Button3: TButton;
    ButtonTestAction: TButton;
    PopupMenuActions: TPopupMenu;
    ModifAction: TMenuItem;
    TabSheetActionneurs: TTabSheet;
    ListBoxActionneurs: TListBox;
    Label30: TLabel;
    ButtonImRCDM: TButton;
    ButtonNouvAct: TButton;
    ButtonSupAct: TButton;
    GroupBoxAct: TGroupBox;
    LabeledEditAdrActionneur: TLabeledEdit;
    Label31: TLabel;
    TabSheetDet: TTabSheet;
    ListBoxDet: TListBox;
    Label42: TLabel;
    Button4: TButton;
    Button5: TButton;
    GroupBoxDet: TGroupBox;
    RadioGroupLEB: TRadioGroup;
    ImageTrain: TImage;
    PageControlTr: TPageControl;
    TabSheetTrGen: TTabSheet;
    GroupBox24: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label16: TLabel;
    SpeedButtonOuvre: TSpeedButton;
    Label46: TLabel;
    EditNomTrain: TEdit;
    EditAdresseTrain: TEdit;
    EditVitesseMaxi: TEdit;
    EditVitRalenti: TEdit;
    EditVitNom: TEdit;
    EditIcone: TEdit;
    LabeledEditTempoD: TLabeledEdit;
    CheckBoxSens: TCheckBox;
    ButtonRdT: TButton;
    EditLongLoco: TEdit;
    TabSheet1: TTabSheet;
    GroupBox14: TGroupBox;
    StringGridArr: TStringGrid;
    Label45: TLabel;
    TtabSheetEt: TTabSheet;
    GroupBox18: TGroupBox;
    LabeledEditV1: TLabeledEdit;
    LabeledEditV2: TLabeledEdit;
    LabeledEditV3: TLabeledEdit;
    LabelEt: TLabel;
    LabelErreur: TLabel;
    GroupBox19: TGroupBox;
    RadioButtonArrFin: TRadioButton;
    RadioButtonARMil: TRadioButton;
    Label47: TLabel;
    EditDecal: TEdit;
    LabelV2: TLabel;
    LabelV3: TLabel;
    LabelV1: TLabel;
    LabeledEditCalcV: TLabeledEdit;
    Label49: TLabel;
    LabeledEditCV3: TLabeledEdit;
    LabeledEditCV4: TLabeledEdit;
    LabeledEditCrans: TLabeledEdit;
    MemoCalc: TMemo;
    Label50: TLabel;
    gp1: TGroupBox;
    LabelRC: TLabel;
    MemoPeriph: TMemo;
    LEAdrDet: TLabeledEdit;
    LElongDet: TLabeledEdit;
    EditPortCde: TLabeledEdit;
    BoutonCom: TButton;
    EditOuvreEcran: TLabeledEdit;
    CheckBoxCR: TCheckBox;
    CbVis: TCheckBox;
    cbDTR: TCheckBox;
    cbRTS: TCheckBox;
    cbDet: TCheckBox;
    CbAct: TCheckBox;
    CbAig: TCheckBox;
    LabelNumeroP: TLabel;
    Prox1: TLabeledEdit;
    Prox2: TLabeledEdit;
    TabSheetFonctions: TTabSheet;
    GroupBoxLogique: TGroupBox;
    Label59: TLabel;
    Label60: TLabel;
    TreeViewL: TTreeView;
    ButtonAjouteVar: TButton;
    ComboBoxOperateur: TComboBox;
    ButtonVoir: TButton;
    ComboBoxVar: TComboBox;
    PanelAcc: TPanel;
    LabeledEditDCC: TLabeledEdit;
    LabeledEditEtatAcc: TLabeledEdit;
    ButtonSupLog: TButton;
    PopupMenuFL: TPopupMenu;
    M1: TMenuItem;
    Descendre1: TMenuItem;
    N4: TMenuItem;
    Supprimer2: TMenuItem;
    N5: TMenuItem;
    outdployer1: TMenuItem;
    outcontracter1: TMenuItem;
    ImageListLogic: TImageList;
    Label63: TLabel;
    ComboBoxFL: TComboBox;
    ButtonNouvFL: TButton;
    ButtonEvalue: TButton;
    LabeledEditNomLog: TLabeledEdit;
    LabelEtat: TLabel;
    SpinEditEtat: TSpinEdit;
    ButtonAjOpEnfant: TButton;
    LabelFonction: TLabel;
    LabeledEditNumFonc: TLabeledEdit;
    LabeledEditTrain: TLabeledEdit;
    ValueListEditor: TValueListEditor;
    Label65: TLabel;
    RadioGroupOP: TRadioGroup;
    Panel1: TPanel;
    GroupBoxStyles: TGroupBox;
    ComboStyle: TComboBox;
    RadioGroupCl: TRadioGroup;
    RadioButtonFIS88: TRadioButton;
    RadioButtonDSI2: TRadioButton;
    Memo4: TMemo;
    ButtonlCV3: TButton;
    ButtonlCV4: TButton;
    ListBoxPN: TListBox;
    ButtonNouvPN: TButton;
    ButtonSupPN: TButton;
    Label58: TLabel;
    ButtonRepriseDCC: TButton;
    TabSheetBouton: TTabSheet;
    GroupBoxB: TGroupBox;
    Shape1: TShape;
    ShapeBR: TShape;
    ShapeB1: TShape;
    ShapeB2: TShape;
    ShapeB3: TShape;
    ShapeB4: TShape;
    Label66: TLabel;
    LabelCode: TLabel;
    Label70: TLabel;
    Label72: TLabel;
    LabelId: TLabel;
    CheckBoxSrvTdcc: TCheckBox;
    ButtonHook: TButton;
    ShapeB5: TShape;
    ShapeB6: TShape;
    ShapeB7: TShape;
    ShapeB8: TShape;
    GroupBoxBR: TGroupBox;
    LabeledEditRm: TLabeledEdit;
    LabeledEditRp: TLabeledEdit;
    LabeledEditClic: TLabeledEdit;
    LabeledEditIncr: TLabeledEdit;
    GroupBoxBt: TGroupBox;
    LabeledEditF: TLabeledEdit;
    LabeledEditFn: TLabeledEdit;
    GroupBoxBloc: TGroupBox;
    ComboBoxUSBTr: TComboBox;
    Label74: TLabel;
    LabeledEditNUM: TLabeledEdit;
    LabeledEditCT: TLabeledEdit;
    TabSheetCompt: TTabSheet;
    Label75: TLabel;
    GroupBox17: TGroupBox;
    ComboBoxCompt: TComboBox;
    Label76: TLabel;
    BoutonCoulAig: TButton;
    Label77: TLabel;
    ButtonCoulGrad: TButton;
    Label78: TLabel;
    ButtonCoulNum: TButton;
    Label79: TLabel;
    ButtonCoulFond: TButton;
    Label80: TLabel;
    ButtonCoulArc: TButton;
    Label81: TLabel;
    Panel2: TPanel;
    ImageCtC: TImage;
    ButtonMod: TButton;
    GroupBox25: TGroupBox;
    ComboBoxEchelle: TComboBox;
    Label82: TLabel;
    TabSheetCourbes: TTabSheet;
    GroupBoxCVit: TGroupBox;
    ImageCourbes: TImage;
    LabelValeur: TLabel;
    LabelCran: TLabel;
    LabelVcms: TLabel;
    LabeledEditVit1: TLabeledEdit;
    LabeledEditVit2: TLabeledEdit;
    LabeledEditVit3: TLabeledEdit;
    LabelEchelle: TLabel;
    LabelV1Cons: TLabel;
    LabelV2Cons: TLabel;
    LabelV3Cons: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    procedure ButtonAppliquerEtFermerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxAigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButtonsansClick(Sender: TObject);
    procedure RadioButton30kmhClick(Sender: TObject);
    procedure RadioButton60kmhClick(Sender: TObject);
    procedure ComboBoxDecChange(Sender: TObject);
    procedure CheckVerrouCarreClick(Sender: TObject);
    procedure CheckInverseClick(Sender: TObject);
    procedure ComboBoxAspChange(Sender: TObject);
    procedure ButtonrestaureClick(Sender: TObject);
    procedure EditAdrFermeChange(Sender: TObject);
    procedure EditCdeFermeChange(Sender: TObject);
    procedure EditAdrOuvreChange(Sender: TObject);
    procedure EditCdeOuvreChange(Sender: TObject);
    procedure ButtonNouvAccClick(Sender: TObject);
    procedure ButtonNouvPNClick(Sender: TObject);
    procedure ButtonSupAccClick(Sender: TObject);
    procedure ButtonSupPNClick(Sender: TObject);
    procedure ButtonNouvSigClick(Sender: TObject);
    procedure ButtonSupSigClick(Sender: TObject);
    procedure ButtonInsSigClick(Sender: TObject);
    procedure ButtonNouvAigClick(Sender: TObject);
    procedure BoutSupAigClick(Sender: TObject);
    procedure ButtonAjSupClick(Sender: TObject);
    procedure ButtonRestaureAigClick(Sender: TObject);
    procedure ComboBoxAigChange(Sender: TObject);
    procedure ButtonValLigneClick(Sender: TObject);
    procedure RichBrancheMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonVerifConfigClick(Sender: TObject);
    procedure MemoCarreChange(Sender: TObject);
    procedure CheckInvInitClick(Sender: TObject);
    procedure ComboBoxDDChange(Sender: TObject);
    procedure EditLChange(Sender: TObject);
    procedure CheckBoxFBClick(Sender: TObject);
    procedure ButtonFSEClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditP3KeyPress(Sender: TObject; var Key: Char);
    procedure EditP4KeyPress(Sender: TObject; var Key: Char);
    procedure EditP1KeyPress(Sender: TObject; var Key: Char);
    procedure EditP2KeyPress(Sender: TObject; var Key: Char);
    procedure ButtonConfigSRClick(Sender: TObject);
    procedure EditDet1Change(Sender: TObject);
    procedure EditSuiv1Change(Sender: TObject);
    procedure EditDet2Change(Sender: TObject);
    procedure EditSuiv2Change(Sender: TObject);
    procedure EditDet3Change(Sender: TObject);
    procedure EditSuiv3Change(Sender: TObject);
    procedure EditDet4Change(Sender: TObject);
    procedure EditSuiv4Change(Sender: TObject);
    procedure EditSpecUniChange(Sender: TObject);
    procedure EditPointe_BGChange(Sender: TObject);
    procedure EditDroit_BDChange(Sender: TObject);
    procedure EditDevie_HDChange(Sender: TObject);
    procedure EditTempo10Change(Sender: TObject);
    procedure Edit_HGChange(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure RadioButtonTJD2Click(Sender: TObject);
    procedure RadioButtonTJD4Click(Sender: TObject);
    procedure EditTempoSignalChange(Sender: TObject);
    procedure RichBrancheKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxAigKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonEnregistreClick(Sender: TObject);
    procedure ButtonTestFermeClick(Sender: TObject);
    procedure ButtonTestOuvreClick(Sender: TObject);
    procedure CheckPnPulseClick(Sender: TObject);
    procedure CheckFVCClick(Sender: TObject);
    procedure CheckFRCClick(Sender: TObject);
    procedure ButtonEnvClick(Sender: TObject);
    procedure EditBaseChange(Sender: TObject);
    procedure RichCdeDccppChange(Sender: TObject);
    procedure CheckEnvAigDccppClick(Sender: TObject);
    procedure ListBoxTrainsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonSupprimeClick(Sender: TObject);
    procedure EditNomTrainChange(Sender: TObject);
    procedure EditAdresseTrainChange(Sender: TObject);
    procedure EditVitesseMaxihange(Sender: TObject);
    procedure ButtonNTClick(Sender: TObject);
    procedure EditVitNomChange(Sender: TObject);
    procedure EditVitRalentiChange(Sender: TObject);
    procedure CheckBoxVerifXpressNetClick(Sender: TObject);
    procedure ListBoxTrainsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonPFCDMClick(Sender: TObject);
    procedure EditLAYChange(Sender: TObject);
    procedure EditLAYExit(Sender: TObject);
    procedure Copier1Click(Sender: TObject);
    procedure Coller1Click(Sender: TObject);
    procedure RichCdeDccppMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RichCdeDccppKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioButtonSpecifiqueClick(Sender: TObject);
    procedure CheckBoxVersContrevoieClick(Sender: TObject);
    procedure CheckBoxContreVoieClick(Sender: TObject);
    procedure EditSpecifiqueChange(Sender: TObject);
    procedure BoutonNouveauClick(Sender: TObject);
    procedure EditNbreAdrChange(Sender: TObject);
    procedure ComboBoxDecodeurPersoChange(Sender: TObject);
    procedure ButtonSupClick(Sender: TObject);
    procedure ComboBoxNationChange(Sender: TObject);
    procedure MemoBlancChange(Sender: TObject);
    procedure ListBoxAigDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxSigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBoxSigKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxPNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBoxPNKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Slectionnertout1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure Nouveau1Click(Sender: TObject);
    procedure outcopierentatquetexte1Click(Sender: TObject);
    procedure ButtonOuvreComClick(Sender: TObject);
    procedure ButtonAjAccComClick(Sender: TObject);
    procedure EditNomPeriphChange(Sender: TObject);
    procedure ListBoxPeriphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonSupAccComClick(Sender: TObject);
    procedure ListBoxPeriphKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioButtonSimpleClick(Sender: TObject);    
   	procedure RadioButtonZoneClick(Sender: TObject);
   	procedure RadioGroupActPNClick(Sender: TObject);
   	procedure ComboBoxPNComChange(Sender: TObject);
    procedure ComboBoxDecCdeChange(Sender: TObject);
    procedure RadioCdeDecClick(Sender: TObject);
    procedure Toutslectionner1Click(Sender: TObject);
    procedure ButtonChercheClick(Sender: TObject);
    procedure EditChercherChange(Sender: TObject);
    procedure SBMonteClick(Sender: TObject);
    procedure SBDescClick(Sender: TObject);
    procedure EditPortServeurExit(Sender: TObject);
    procedure EditPortServeurChange(Sender: TObject);
    procedure EditAdrSigChange(Sender: TObject);
    procedure EditP3Exit(Sender: TObject);
    procedure EditP4Exit(Sender: TObject);
    procedure EditP1Exit(Sender: TObject);
    procedure EditP2Exit(Sender: TObject);
    procedure EditDevieS2Change(Sender: TObject);
    procedure ButtonCouleurClick(Sender: TObject);
    procedure ColorDialogFondShow(Sender: TObject);
    procedure ButtonPropageClick(Sender: TObject);
    procedure EditAdrAigExit(Sender: TObject);
    procedure EditAdrAigChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListBoxActionsMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBoxOperationsDrawItem(Control: TWinControl;
	Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxOperationsMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonTestActionClick(Sender: TObject);
    procedure ModifActionClick(Sender: TObject);
    procedure ListBoxActionsKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure ListBoxOperationsDblClick(Sender: TObject);
    procedure SpeedButtonOuvreClick(Sender: TObject);
    procedure EditIconeChange(Sender: TObject);
    procedure LabeledEditTempoDChange(Sender: TObject);
    procedure CheckBoxSensClick(Sender: TObject);
    procedure ButtonImRCDMClick(Sender: TObject);
    procedure ButtonSupActClick(Sender: TObject);
    procedure ListBoxActionneursMouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LabeledEditAdrActionneurChange(Sender: TObject);
    procedure ButtonNouvActClick(Sender: TObject);
    procedure ListBoxDetMouseDown(Sender: TObject; Button: TMouseButton;
	Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure RadioGroupLEBClick(Sender: TObject);
    procedure ListBoxActionsDblClick(Sender: TObject);
    procedure StringGridArrSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGridArrSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure EditAigTripleKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonRdTClick(Sender: TObject);
    procedure EditLongLocoChange(Sender: TObject);
    procedure LabeledEditV1Change(Sender: TObject);
    procedure LabeledEditV2Change(Sender: TObject);
    procedure LabeledEditV3Change(Sender: TObject);
    procedure EditDecalChange(Sender: TObject);
    procedure RadioButtonArrFinClick(Sender: TObject);
    procedure RadioButtonARMilClick(Sender: TObject);
    procedure LabeledEditCalcVChange(Sender: TObject);
    procedure LabeledEditCV3Change(Sender: TObject);
    procedure LabeledEditCV4Change(Sender: TObject);
    procedure LabeledEditCransChange(Sender: TObject);
    procedure ListBoxDetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LEAdrDetChange(Sender: TObject);
    procedure LElongDetChange(Sender: TObject);
    procedure EditPortCdeChange(Sender: TObject);
    procedure BoutonComClick(Sender: TObject);
    procedure EditOuvreEcranChange(Sender: TObject);
    procedure CheckBoxCRClick(Sender: TObject);
    procedure CbVisClick(Sender: TObject);
    procedure cbDTRClick(Sender: TObject);
    procedure cbRTSClick(Sender: TObject);
    procedure cbDetClick(Sender: TObject);
    procedure CbActClick(Sender: TObject);
    procedure CbAigClick(Sender: TObject);
    procedure Prox1Change(Sender: TObject);
    procedure Prox2Change(Sender: TObject);
    procedure ButtonSupLogClick(Sender: TObject);
    procedure ComboBoxOperateurDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ButtonAjouteVarClick(Sender: TObject);
    procedure ButtonVoirClick(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure Descendre1Click(Sender: TObject);
    procedure TreeViewLChange(Sender: TObject; Node: TTreeNode);
    procedure outdployer1Click(Sender: TObject);
    procedure outcontracter1Click(Sender: TObject);
    procedure ComboBoxOperateurChange(Sender: TObject);
    procedure ComboBoxVarChange(Sender: TObject);
    procedure ComboBoxVarDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LabeledEditDCCChange(Sender: TObject);
    procedure LabeledEditEtatAccChange(Sender: TObject);
    procedure ButtonNouvFLClick(Sender: TObject);
    procedure ComboBoxFLChange(Sender: TObject);
    procedure ButtonEvalueClick(Sender: TObject);
    procedure Supprimer2Click(Sender: TObject);
    procedure LabeledEditNomLogChange(Sender: TObject);
    procedure SpinEditEtatChange(Sender: TObject);
    procedure ButtonAjOpEnfantClick(Sender: TObject);
    procedure LabeledEditNumFoncChange(Sender: TObject);
    procedure LabeledEditTrainChange(Sender: TObject);
    procedure ValueListEditorSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure ValueListEditorDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ValueListEditorMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ButtonlCV4Click(Sender: TObject);
    procedure RadioGroupOPClick(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1Click(Sender: TObject);
    procedure ComboStyleChange(Sender: TObject);
    procedure RadioGroupClClick(Sender: TObject);
    procedure ButtonlCV3Click(Sender: TObject);
    procedure ButtonRepriseDCCClick(Sender: TObject);
    procedure ShapeBRMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabeledEditCTChange(Sender: TObject);
    procedure LabeledEditRmChange(Sender: TObject);
    procedure LabeledEditRpChange(Sender: TObject);
    procedure LabeledEditClicChange(Sender: TObject);
    procedure LabeledEditNUMChange(Sender: TObject);
    procedure LabeledEditFChange(Sender: TObject);
    procedure LabeledEditIncrChange(Sender: TObject);
    procedure ComboBoxUSBTrChange(Sender: TObject);
    procedure LabeledEditFnChange(Sender: TObject);
    procedure ButtonHookClick(Sender: TObject);
    procedure ShapeB5MousDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeB8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BoutonCoulAigClick(Sender: TObject);
    procedure ComboBoxComptChange(Sender: TObject);
    procedure ButtonCoulGradClick(Sender: TObject);
    procedure ButtonCoulNumClick(Sender: TObject);
    procedure ButtonCoulFondClick(Sender: TObject);
    procedure ButtonCoulArcClick(Sender: TObject);
    procedure ButtonModClick(Sender: TObject);
    procedure ValueListEditorSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure ComboBoxEchelleChange(Sender: TObject);
    procedure ImageCourbesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabeledEditVit1Change(Sender: TObject);
    procedure LabeledEditVit2Change(Sender: TObject);
    procedure LabeledEditVit3Change(Sender: TObject);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    procedure modif_editT(Sender : TObject);
    procedure modif_ComboTS(Sender : TObject);
    procedure modif_ComboL(Sender : TObject);
    procedure tbCde_onchange(Sender : Tobject);
  end;

  Tliste = record                                 // liste des param�tres avanc�s de la ValueListEditor
           Nom      : string;                     // Nom de la variable
           aide     : string;                     // pour le hint
           typ      : (Simple,PickList,titre);    // type d'entr�e : simple=entier  picklist=combobox  titre=texte sans variable associ�e
           masque   : string;                     // masque de saisie des entiers
           variable : pointer;                    // pointeur sur la variable � modifier
           typeVar  : (rien3,entier,bool,chaine); // type de la variable � modifier
           textePL1,textePL2 : string;            // texte des comboBox si typ est picklist
         end;

const
// constantes du fichier de configuration
NomConfig='ConfigGenerale.cfg';
Debug_ch='Debug';
Sombre_ch='Mode_Sombre';
couleur_fond_ch='coul_fond';
serveurIPCDM_Touche_ch='serveurIPCDM_Touche';
PortServeur_ch='Port_Serveur';
AntiTimeoutEthLenz_ch='AntiTimeoutEthLenz';
TempoTC_ch='TempoTC';
Verif_AdrXpressNet_ch='Verif_AdrXpressNet';
debugRoulage_ch='debugRoulage';
AffLoc_ch='AffLoc';
Filtrage_det_ch='Filtrage_det';
nCantons_Res_ch='nCantonsRes';
MaxSignalSens_ch='Max_Signal_Sens';
Algo_localisation_ch='Algo_localisation';
nb_det_dist_ch='nb_det_dist';
IpV4_PC_ch='IpV4_PC';
ServicesCDM_ch='ServicesCDM';
AffAigND_ch='AigND';
retro_ch='retro';
Ecran_ch='Ecran';
Z21_ch='Z21';
Init_aig_ch='Init_Aig';
PilotageTrainsCDM_ch='PilotageTrainsCDMNom';
LAY_ch='Lay';
Init_dem_aig_ch='Init_Dem_Aig';
Init_dem_interfaceUSBCOM_ch='Init_demUSBCOM';
Init_dem_interfaceEth_ch='Init_demETH';
IPV4_INTERFACE_ch='Ipv4_interface';
PROTOCOLE_SERIE_ch='Protocole_serie';
INTER_CAR_ch='Inter_car';
Tempo_maxi_ch='Tempo_maxi';
Entete_ch='Entete';
TCO_ch='TCO';
Nb_TCO_ch='NbreTCO';
MasqueBandeauTCO_ch='MasqueBandeauTCO';
CDM_ch='CDM';
Serveur_interface_ch='Serveur_interface';
fenetre_ch='Fenetre';
AffMemoFenetre_ch='AffMemoFenetre';
Tempo_aig_ch='Tempo_Aig';
Nb_cantons_Sig_ch='Nb_cantons_Sig';
Tempo_Signal_ch='Tempo_Feu';
Algo_Unisemaf_ch='Alg_Unisemaf';
NOTIF_VERSION_ch='notif_version';
verif_version_ch='verif_version';
Fonte_ch='Fonte';
ModeResa_ch='ModeResa';
Protocole_ch='Protocole';
Raz_signaux_ch='RazSignaux';
EnvAigDccpp_ch='EnvAigDccpp';
AdrBaseDetDccpp_ch='AdrBaseDetDccpp';
AvecVerifIconesTCO_ch='AvecVerifIconesTCO';
NomModuleCDM_ch='NomModuleCDM';
Style_ch='Style';
cbAffSig_ch='AffSig';
cbAck_ch='AvecAck';
ModeTache_ch='Asynchrone';
cbRes_ch='AffRes';
Nba_ch='NombreAdresses';
nation_ch='Nation';
Periph_ch='Periph';
comm_ch='Commande';
nom_dec_pers_ch='Nom_dec_pers';
Nom_fich_TCO_ch='Nom_fichier_TCO';
CheminProgCDM_ch='Chemin_progCDM';
LargeurF_ch='LargeurF'; // largeur de la fen�tre principale
HauteurF_ch='HauteurF';
OffsetXF_ch='OffsetX';  // .Left de la fen�tre principale
OffsetYF_ch='OffsetY';
LargeurFC_ch='LargeurFC'; // largeur de la fen�tre clock
HauteurFC_ch='HauteurFC';
OffsetXFC_ch='OffsetXC';  // .Left de la fen�tre clock
OffsetYFC_ch='OffsetYC';
option_demitour_ch='Option_demiTour';
MaxParcours_ch='MaxParcours';
MaxRoutes_ch='MaxRoutes';
PosSplitter_ch='Splitter';
horlogeInterne_ch='HorlogeInterne';
LanceHorl_ch='LanceHorl';
AffHorl_ch='AffHorl';
HeureInit_ch='HeureInit';
MinuteInit_ch='MinuteInit';
RetourHeure_ch='RetourHeure';
RetourMinute_ch='RetourMinute';
DureeMinute_ch='DureeMinute';
relanceHorl_init_ch='relanceHorl_init';
compteur_ch='compteur';
Affcompteur_ch='AffCompteur';
LargCompteur_ch='LargCompteur';
LargComptC_ch='LargCompteurC';
HautComptC_ch='HautCompteurC';
VerrouCompteur_ch='VerrouCompteur';
Echelle_ch='Echelle';
AffIconeTrCompteur_ch='AffIconeTrCompteur';
Onglet_ch='Onglet';

// sections de config
section_aig_ch='[section_aig]';
section_sig_ch='[section_sig]';
section_act_ch='[section_act]';  // anciens actionneurs
section_actV2_ch='[section_actions]';
section_PN_ch='[section_PN]';
section_branches_ch='[section_branches]';
section_dccpp_ch='[section_dcc++]';
section_initpp_ch='[init_dcc++]';
section_trains_ch='[section_trains]';
section_placement_ch='[section_placement]';
section_DecPers_ch='[section_decodeurs]';
section_accCOM_ch='[section_accCOMUSB]';
section_horloge_ch='[section horloge]';
section_actionneurs_ch='[section_actionneurs]';
section_detecteurs_ch='[section_detecteurs]';
section_logique_ch='[section_logique]';
section_blocs_USB_ch='[section_blocs_USB]';
section_compteurs_ch='[section_compteurs]';

rep_icones='icones';

const sd=' [d�valid�]';

// indice des icones donc des fonctions logiques
FoncVAR=0;
//--------
OpET=1;
OpOU=2;
OpNonET=3;
opNonOU=4;
//-------
EtatDCC=5;
EtatDet=6;
EtatBoutonTCO=7;
EtatMemoire=8;
NomVAR='Fonction logique';
NomOpET='Op�rateur ET';
NomOpOU='Op�rateur OU';
NomOpNonET='Op�rateur Non ET';
NomOpNonOU='Op�rateur Non OU';
NomEtatDCC='Etat DCC';
NomEtatDet='Etat d�tect./actionn.';
NomEtatBoutonTCO='Bouton TCO';
NomEtatMemoire='M�moire';
NomFonc : array[0..8] of string[25]=(NomVar,NomOpET,NomOpOu,NomOpNonET,NomOpNonOU,NomEtatDCC,NomEtatDet,NomEtatBoutonTCO,NomEtatMemoire);


var
  FormConfig: TFormConfig;
  AdresseIPCDM,AdresseIP,PortCom,recuCDM,residuCDM,RepConfig,Nom_Style_aff,Ancien_Nom_Style,
  scouleur : string;

  portCDM,TempoOctet,TimoutMaxInterface,Valeur_entete,PortInterface,prot_serie,NumPort,debug,
  LigneCliqueePN,AncLigneCliqueePN,clicMemo,Nb_cantons_Sig,protocole,Port,PortServeur,
  ligneclicAig,AncLigneClicAig,ligneClicSig,AncligneClicSig,EnvAigDccpp,AdrBaseDetDccpp,
  ligneClicBr,AncligneClicBr,ligneClicAct,AncLigneClicAct,IndexSignalclic,NumTrameCDM,
  Algo_localisation,Verif_AdrXpressNet,ligneclicTrain,AntiTimeoutEthLenz,NumBlocUSB,
  ligneDCC,decCourant,AffMemoFenetre,ligneClicAccPeriph,AncligneClicAccPeriph,ligneCherche,
  compt_Ligne,Ecran_SC,Max_Signal_Sens,nCantonsRes,ligneClicActionneur,BoutonBloc,
  TempoTC,Nbuttoirs,AncLigneClicActionneur,AncligneclicDet,ligneclicDet,foncCourante,
  NbreFL,IdOperateur,NbreBlocsUSB,Onglet,Echelle,ax : integer;

  ack_cdm,clicliste,config_modifie,clicproprietesSig,clicproprietesTrains,confasauver,trouve_MaxPort,
  modif_branches,ConfigPrete,trouve_section_dccpp,trouve_section_trains,trouve_section_acccomusb,
  trouveAvecVerifIconesTCO,Affiche_avert,activ,trouve_section_dec_pers,Z21,AffAigND,prem,
  PilotageTrainsCDMNom,LanceHorl,AffSig,AffRes,avecAck,affLoc,changeCom,tsbouton,VisuIntercepte,
  clicTree : boolean;

  paramcomptIm : tparamcompt;
  fichier : text;
  FbmcompC : tBitmap;
  FormatSettings : TFormatSettings;

  Liste : array[1..22] of Tliste;

  ValVitTrain : array[0..127] of integer;

  // composants dynamiques voies PN
  EditV1F,EditV1O,EditV2F,EditV2O,EditV3F,EditV3O,EditV4F,EditV4O,EditV5F,EditV5O,
  EditZdet1V1F,EditZdet2V1F,EditZdet1V1O,EditZdet2V1O,
  EditZdet1V2F,EditZdet2V2F,EditZdet1V2O,EditZdet2V2O,
  EditZdet1V3F,EditZdet2V3F,EditZdet1V3O,EditZdet2V3O,
  EditZdet1V4F,EditZdet2V4F,EditZdet1V4O,EditZdet2V4O,
  EditZdet1V5F,EditZdet2V5F,EditZdet1V5O,EditZdet2V5O : tEdit;

  // composants dynamiques d�codeurs personnalis�s
  EditT  : Array[1..10] of Tedit;
  TextBoxCde : array[1..19] of Tedit;

  LbPnVoie1,LbAPnVoie1,LbAPnVoie2,LbAPnVoie3,LbAPnVoie4,LbAPnVoie5,LbATitre,
  LbZTitre,LbZPnVoie1,LbZPnVoie2,LbZPnVoie3,LbZPnVoie4,LbZPnVoie5,
  LabelAvance1,LabelAvance2 : Tlabel;

  LabelDecCde : array[1..19] of TLabel;

  shape1,ShapeZ : Tshape;
  ShapeT : array[1..10] of TShape;

  ComboL1,ComboL2,ComboTS1,ComboTS2 : Array[1..10] of TComboBox;

function config_com(s : string) : boolean;
function connecte_CDM : boolean;
procedure decodeAig(s : string;var adr : integer;var B : char);
function sauve_config : boolean;
procedure lit_config;
Procedure aff_champs_signaux(index : integer);
function verif_coherence : boolean;
function compile_branche(s : string;i : integer) : boolean;
function encode_signal(i : integer): string;
procedure valide_branches;
procedure trier_aig;
procedure trier_cantons;
procedure trier_detecteurs;
procedure trier_actionneurs;
function decodeDCC(s : string) : string;
function encode_aig(index : integer): string;
function Ipok(s : string) : boolean;
procedure couleurs_config;
function encode_actions(i : integer) : string;
function encode_act_pn(i : integer) : string;
function encode_Periph(index : integer) : string;
procedure ajoute_champs_combos(i : integer);
function verif_trains : boolean;
function Maj_icone_train(IImage : Timage;index :integer;coulfond : Tcolor) : integer;
function evalue_fonction(NumFonc : integer;var formule : string) : boolean;
procedure fabrique_treeview(k : integer);
procedure compile_id_routes;
procedure genere_informations_BD;
function trouve_index_style : integer;
procedure ComboBoxFL_mizajour;
procedure clic_BRM;
function crans_to_Vrcms(v,idTrain : integer) : single;
procedure courbe_train(indexTrain : integer);

implementation

uses UnitDebug,UnitTCO, UnitSR, UnitCDF,UnitAnalyseSegCDM, unitPilote, unitclock,
  UnitModifAction,UnitConfigCellTCO, UnitRouteTrains,UnitCompteur;

{$R *.dfm}

procedure Maj_Hint_Signal(indexSignal : integer);
var s : string;
begin
  // ne pas supprimer le @= qui sert de marqueur pour identifier le signal
  s:='Index='+IntToSTR(indexSignal)+' @='+inttostr(Signaux[indexSignal].Adresse)+' D�codeur='+decodeur[Signaux[indexSignal].Decodeur]+
       ' Adresse d�tecteur associ�='+intToSTR(Signaux[indexSignal].Adr_det1)+
       ' Adresse �lement suivant='+intToSTR(Signaux[indexSignal].Adr_el_suiv1);
  if Signaux[indexSignal].Btype_suiv1=aig then s:=s+' (aig)';

  Signaux[indexSignal].Img.Hint:=s;
end;

// demande les services Com-IP � CDM
// demande � CDM d'envoyer les �tats sur changements des services demand�s.
// exemple: si on demande le service aiguillage, CDM renverra la position d'un aiguillage qui change d'�tat.
function services_CDM : boolean;
var s,ss : string;
    i : integer;
begin
  s:=place_id('C-C-00-0002-RQSERV-RTSIM|xxx|xx|');
  i:=0;
  if Srvc_Aig then begin s:=s+'SRV=ATNT;';inc(i);end;   // service changement aiguillage
  if Srvc_Act then begin s:=s+'SRV=AACT;';inc(i);end;   // service actionneurs
  if Srvc_Det then begin s:=s+'SRV=ADET;';inc(i);end;   // service d�tecteurs
  if Srvc_Pos then begin s:=s+'SRV=TSXY;';inc(i);end;   // service position et vitesses des trains
  if Srvc_Sig then begin s:=s+'SRV=ASIG;';inc(i);end;   // service signaux
  if Srvc_tspd then begin s:=s+'SRV=TSPD;';inc(i);end;  // service info train (si chgt vitesse)

  // ins�re le nombre de param�tres
  ss:=format('%.*d',[2,i]) ;
  delete(s,30,2);
  insert(ss,s,30);
  // ins�re la longueur des param�tres
  i:=length(s)-29;
  ss:=format('%.*d',[3,i]) ;
  delete(s,26,3);
  insert(ss,s,26);

  envoi_CDM(s);
  sleep(100);

  if ack_cdm then
  begin
    s:='Services accept�s: ';
    if Srvc_Aig then s:=s+'- aiguillages ';
    if Srvc_Act then s:=s+'- actionneurs ';
    if Srvc_Det then s:=s+'- d�tecteurs ';
    if Srvc_Pos then s:=s+'- position des trains ';
    if Srvc_sig then s:=s+'- �tat des signaux ';
    if Srvc_tspd then s:=s+'- chgt vitesse trains ';
    Affiche(s,clYellow);
  end;
  services_CDM:=ack_cdm;
  ack_cdm:=false;
end;

function connecte_CDM : boolean;
var s : string;
    i,erreur : integer;
    savack: boolean;
begin
  result:=false;
  // d�connexion de l'ancienne liaison �ventuelle
  Formprinc.ClientSocketCDM.Close;

  if (AdresseIPCDM<>'0') and IpOk(AdresseIPCDM) then
  begin
    if (ProcessRunning('CDR')) then
    begin
      // ouverture du socket CDM
      with Formprinc do
      begin
        ClientSocketCDM.port:=portCDM;
        ClientSocketCDM.Address:=AdresseIPCDM;
        ClientSocketCDM.Open;
      end;
      i:=0;
      repeat
        Sleep(50);
        inc(i);
        Application.processMessages;
      until (i>10) or CDM_connecte  ;
      //if i>10 then affiche('Timeout',clred);
      if not(CDM_connecte) then begin Affiche('Socket CDM non connect�',clOrange);exit;end;

      savAck:=avecAckCDM; // sauver l'�tat avecou sans ack
      avecAckCDM:=true;   // il faut l'ack pour la phase de connexion avec cdm
      // connexion � CDM rail
      recuCDM:='';
      s:='C-C-00-0001-CMDGEN-_CNCT|000|';
      envoi_cdm(s);
      if ack_cdm then
      begin
        ack_cdm:=false;
        Id_CDM:=copy(recuCDM,5,2);   // r�cup�re l'ID re�u de CDM, � utiliser dans toutes les futures trames
        val(id_CDM,i,erreur);
        if (i>0) and (erreur=0) then
        begin
          recucdm:='';
          s:='Connect� au serveur CDM rail avec l''ID='+Id_CDM;

          Affiche(s,clYellow);
          CDM_connecte:=true;

          // demande des services
          services_CDM;
          // demande la description des trains
          s:=place_id('C-C-01-0002-DSCTRN-DLOAD|000|');
          ntrains_cdm:=0;
          envoi_CDM(s);
          sleep(10);
          Application.ProcessMessages;
          result:=true;
        end
        else
        begin
          Affiche('Erreur ID ',clred);
          cdm_connecte:=false;
          result:=false;
        end;
        avecAckCDM:=savACK;
      end
      else
      begin
        Affiche('Pas de r�ponse de CDM',clred);
        cdm_connecte:=false;
        result:=false;
      end;
    end;
  end
  else
  begin
    if adresseIPCDM='0' then Affiche('La connexion � CDM n''est pas demand�e car l''adresse IP est nulle dans '+NomConfig,clcyan);
    if not(IpOk(AdresseIPCDM)) then Affiche('Adresse IP CDM incorrecte : '+AdresseIPCDM,clcyan);
    cdm_connecte:=false;
    result:=false;
  end;
end;

// teste si une adresse IP V4 est ok
function Ipok(s : string) : boolean;
var i,k,octet,erreur : integer;
begin
  for k:=1 to 3 do
  begin
    i:=pos('.',s);
    if i=0 then begin IpOK:=false;exit;end;
    val(copy(s,1,i-1),octet,erreur);if (erreur<>0) or (octet<0) or (octet>255) then begin IpOK:=false;exit;end;
    delete(s,1,i);
  end;
  val(s,octet,erreur);if (octet<0) or (octet>255) then begin IpOK:=false;exit;end;
  ipOK:=true;
end;

// v�rifie si la config de la com s�rie/usb est ok
// COM7:9600,n,8,1
function config_com(s : string) : boolean;
var sa : string;
    i,erreur,vitesse : integer;
begin
  s:=Uppercase(s);
  sa:=s;
  prot_serie:=-1;
  // trouver la vitesse
  i:=pos(':',s);
  if i<>0 then
  begin
    delete(s,1,i);
    val(s,vitesse,i);
    if (vitesse<>300) and (vitesse<>1200) and (vitesse<>2400) and (vitesse<>4800) and (vitesse<>9600) and
       (vitesse<>19200) and (vitesse<>38400) and (vitesse<>57600) and (vitesse<>115200) and (vitesse<>128000) and (vitesse<>256000) then
    begin
      Affiche('Vitesse COM ('+intToSTR(vitesse)+') incorrecte',clred);
      result:=false;
      exit;
    end;
  end
  else
  begin
    result:=false;
    exit;
  end;

  // supprimer la dernier param�tre
  i:=pos(',',s);
  if i<>0 then
  begin
    delete(s,1,i);
    i:=pos(',',s);
    if i<>0 then
    begin
      delete(s,1,i);
      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,1,i);
        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,1,i);
          Val(s,prot_serie,erreur);
        end;
      end;
    end;
  end;

  i:=pos('COM',sa);
  if i<>0 then delete(sa,1,3);
  val(sa,Numport,erreur);
  config_com:=not( (i=0) or (prot_serie=-1) or (prot_serie>4) or (i=0) );
end;

function encode_Periph(index : integer) : string;
var s : string;
begin
  s:=Tablo_periph[index].nom;
  if Tablo_periph[index].ScvAig then s:=s+',1' else s:=s+',0';
  if Tablo_periph[index].ScvDet then s:=s+',1' else s:=s+',0';
  if Tablo_periph[index].ScvAct then s:=s+',1' else s:=s+',0';
  if Tablo_periph[index].ScvVis then s:=s+',1' else s:=s+',0';
  if Tablo_periph[index].cr     then s:=s+',1' else s:=s+',0';
  if Tablo_periph[index].dtr    then s:=s+',1' else s:=s+',0';
  if Tablo_periph[index].rts    then s:=s+',1' else s:=s+',0';
  s:=s+','+Tablo_periph[index].protocole;

  result:=s;
end;

// transforme l'aiguillage de la base de donn�es aiguillage en texte
function encode_aig(index : integer): string;
var s : string;
    c : char;
    tjdC,tjsC,triC,croi : boolean;
begin
   if index=0 then exit;
   s:=IntToSTR(aiguillage[index].Adresse);
   tjdC:=aiguillage[index].modele=tjd;
   tjsC:=aiguillage[index].modele=tjs;
   triC:=aiguillage[index].modele=triple;
   croi:=aiguillage[index].modele=crois;
   if tjdC then s:=s+'TJD';
   if tjsC then s:=s+'TJS';
   if croi then s:=s+'CROI';
   if triC then begin s:=s+'TRI,';s:=s+intToSTR(aiguillage[index].AdrTriple);end;
   s:=s+',';
   // aiguillage normal ou triple
   if not(tjdC) and not(tjsC) and not(croi) then
   begin
     // P
     s:=s+'P';s:=s+intToSTR(aiguillage[index].Apointe);
     c:=aiguillage[index].APointeB ;
     if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     //if c=#0 then s:=s+'Z';
     // D
     s:=s+',D';s:=s+intToSTR(aiguillage[index].Adroit);
     c:=aiguillage[index].ADroitB ;
     if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     //if c=#0 then s:=s+'Z';
     // S
     s:=s+',S';s:=s+intToSTR(aiguillage[index].Adevie);
     c:=aiguillage[index].AdevieB ;
     if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     //if c=#0 then s:=s+'Z';
     // S2 aiguillage triple
     if triC then
     begin
       s:=s+',S2-';
       s:=s+intToSTR(aiguillage[index].Adevie2);
       c:=aiguillage[index].Adevie2B ;
       if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
       //if c=#0 then s:=s+'Z';
     end;
   end;

   // tjd-s 2/4 �tats
   if (tjdC or tjsC) then
   begin
     s:=s+'D('+intToSTR(aiguillage[index].Adroit);

     c:=aiguillage[index].AdroitB;if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDroit);

     c:=aiguillage[index].DDroitB;if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     s:=s+'),';
     s:=s+'S('+intToSTR(aiguillage[index].Adevie);

     c:=aiguillage[index].AdevieB;if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDevie);

     c:=aiguillage[index].DDevieB;if (c<>'Z') and (c<>#0) and (c<>' ') then s:=s+c;
     s:=s+')';
   end;

   if croi then
   begin
     s:=s+'D('+intToSTR(aiguillage[index].Adroit);
     c:=aiguillage[index].AdroitB;if (c<>'Z') and (c<>#0) and (c<>' ')then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDroit);
     c:=aiguillage[index].DDroitB;if (c<>'Z') and (c<>#0) and (c<>' ')then s:=s+c;
     s:=s+'),';
     s:=s+'S('+intToSTR(aiguillage[index].Adevie);
     c:=aiguillage[index].AdevieB;if (c<>'Z') and (c<>#0) and (c<>' ')then s:=s+c;
     s:=s+','+intToSTR(aiguillage[index].DDevie);
     c:=aiguillage[index].DDevieB;if (c<>'Z') and (c<>#0) and (c<>' ')then s:=s+c;
     s:=s+')';
   end;

   if tjsC then
   begin
     s:=s+',L'+intToSTR(aiguillage[index].Tjsint)+aiguillage[index].TjsintB;
   end;

   // vitesse de franchissement et inversion
   if not(croi) then
   begin
     case aiguillage[index].vitesse of
      0 :  s:=s+',V0';
      30 : s:=s+',V30';
      60 : s:=s+',V60';
      else begin
             s:=s+',V'+intToSTR(aiguillage[index].vitesse);
           end;
     end;

     if aiguillage[index].inversionCDM=1 then s:=s+',I1' else s:=s+',I0';
   end;

   // valeur d'initialisation
   if not(croi) then
   begin
     s:=s+',INIT(';
     s:=s+IntToSTR(aiguillage[index].posInit)+',';
     s:=s+IntToSTR(aiguillage[index].temps)+')';
   end;

   if tjdC or tjsC then
   begin
     if aiguillage[index].EtatTJD=2 then s:=s+',E2' else s:=s+',E4';
   end;

   s:=s+',C'+intToSTR(aiguillage[index].AdrCDM);

   encode_aig:=s;
end;

// renvoie un A si BT est un aiguillage (aig, tjd, tjs tri)
function TypeEl_to_char(BT : TEquipement) : string;
begin
  if (bt=aig) or (bt=tjd) or (bt=tjs) or (bt=triple) then result:='A'
    else result:='';
end;

// renvoie un texte pour le hint de l'aiguillage adr extr�mit� c
function TypeElAig_to_char(adr : integer;c : char) : string;
var s: string;
begin
  if (adr=0) and (c<>'D') and (c<>'S') and (c<>'P') then s:='Buttoir';

  if adr<>0 then
  begin
    if c='P' then s:='pointe de l''aiguillage '+IntToSTR(adr) else
    if c='S' then s:='position d�vi�e de l''aiguillage '+IntToSTR(adr) else
    if c='D' then s:='position droite de l''aiguillage '+IntToSTR(adr) else
    if (c<>'D') and (c<>'S') and (c<>'P') then s:='d�tecteur '+IntToSTR(adr) else
    s:='erreur';
  end;
  TypeElAIg_to_char:=s;
end;

// transforme le signal du tableau Signaux[] en texte
function encode_signal(i : integer): string;
var s : string;
    decod,adresse,aspect,j,k,NfeuxDir,CondCarre,CondFeuBlanc,nc : integer;
begin
  // adresse
  adresse:=Signaux[i].adresse;

  if adresse=0 then
  begin
    Affiche('Adresse nulle signal',clRed);
    result:='';
    exit;
  end;
  if affevt then Affiche('Encode_sig_feux('+IntToSTR(i)+') : adresse='+IntToSTR(adresse),clyellow);

  s:=IntToSTR(adresse)+',';
  // forme - D=directionnel ajouter 10
  aspect:=Signaux[i].aspect;
  if isDirectionnel(i) then s:=s+'D'+intToSTR(aspect-10)+',' else s:=s+IntToSTR(aspect)+',';

  // bouton feu blanc, n'existe pas pour un feu directionnel (aspect>10)
  if not(isDirectionnel(i)) then begin if Signaux[i].feublanc then s:=s+'1,' else s:=s+'0,';end;

  // d�codeur
  decod:=Signaux[i].decodeur;
  s:=s+IntToSTR(decod)+',';

  // detecteur et �lement suivant (4 maxi)
  // signal non directionnel
  if not(isDirectionnel(i)) then
  begin
    s:=s+'('+IntToSTR(Signaux[i].Adr_det1)+','+TypeEl_To_char(Signaux[i].Btype_suiv1)+IntToSTR(Signaux[i].Adr_el_suiv1);
    j:=Signaux[i].Adr_det2;
    if j<>0 then s:=s+','+IntToSTR(Signaux[i].Adr_det2)+','+TypeEl_To_char(Signaux[i].Btype_suiv2)+IntToSTR(Signaux[i].Adr_el_suiv2);
    j:=Signaux[i].Adr_det3;
    if j<>0 then s:=s+','+IntToSTR(Signaux[i].Adr_det3)+','+TypeEl_To_char(Signaux[i].Btype_suiv3)+IntToSTR(Signaux[i].Adr_el_suiv3);
    j:=Signaux[i].Adr_det4;
    if j<>0 then s:=s+','+IntToSTR(Signaux[i].Adr_det4)+','+TypeEl_To_char(Signaux[i].Btype_suiv4)+IntToSTR(Signaux[i].Adr_el_suiv4);
    s:=s+'),';

    //verrouillage au carr�
    if Signaux[i].verrouCarre then s:=s+'1' else s:=s+'0';
    // feu vert cli
    if Signaux[i].checkFV then s:=s+',FVC1' else s:=s+',FVC0';
    // feu rouge cli
    if Signaux[i].checkFR then s:=s+',FRC1' else s:=s+',FRC0';

    // si unisemaf ou LEB, param�tre suppl�mentaire
    if (decod=4) or (decod=6) then s:=s+',U'+intToSTR(Signaux[i].unisemaf);

    if (decod=4) then s:=s+',L'+intToSTR(signaux[i].BinLin);

    // conditions suppl�mentaires pour le carr�
    for nc:=1 to 6 do
    begin
      CondCarre:=Length(Signaux[i].condcarre[nc]);  // nombre de conditions (nombre de parenth�ses ex 3 pour (A21S,A6D)(A30S,A20D)(A1D,A2S,A3D)
      dec(condcarre);
      if condCarre>0 then
      begin
        s:=s+',(';
        for k:=1 to condcarre do
        begin
          s:=s+'A'+IntToSTR(Signaux[i].condcarre[nc][k].Adresse)+Signaux[i].condcarre[nc][k].PosAig;
          if k<condcarre then s:=s+',';
        end;
        s:=s+')';
      end;
    end;

    // conditions suppl�mentaires pour le feu blanc
    for nc:=1 to 6 do
    begin
      CondFeuBlanc:=Length(Signaux[i].CondFeuBlanc[nc]);  // nombre de conditions (nombre de parenth�ses ex 3 pour (A21S,A6D)(A30S,A20D)(A1D,A2S,A3D)
      dec(CondFeuBlanc);
      if CondFeuBlanc>0 then
      begin
        s:=s+',CFB(';
        for k:=1 to CondFeuBlanc do
        begin
          s:=s+'A'+IntToSTR(Signaux[i].CondFeuBlanc[nc][k].Adresse)+Signaux[i].CondFeuBlanc[nc][k].PosAig;
          if k<CondFeuBlanc then s:=s+',';
        end;
        s:=s+')';
      end;
    end;

    // d�codeur SR ou LEA
    if (Signaux[i].decodeur=7) or (Signaux[i].decodeur=11) then
    begin
      s:=s+',SR(';
      for nc:=1 to 8 do
      begin
        s:=s+intToSTR(Signaux[i].SR[nc].sortie1)+',';
        s:=s+intToSTR(Signaux[i].SR[nc].sortie0);
        if nc<8 then s:=s+',' else s:=s+')';
      end;
      s:=s+',NA'+intToSTR(Signaux[i].na);
    end;

    // d�codeur CDF ou digikeijs
    if (Signaux[i].decodeur=2) or (Signaux[i].decodeur=5) then
    begin
      s:=s+',MOT(';
      for nc:=1 to 19 do
      begin
        s:=s+intToSTR(Signaux[i].SR[nc].sortie1);
        if nc<19 then s:=s+',' else s:=s+')';
      end;
      s:=s+',NA'+intToSTR(Signaux[i].na);
    end;

    // signal belge
    if (Signaux[i].aspect=20) then
    begin
      s:=s+',NA'+intToSTR(Signaux[i].na)+',VCV';
      if Signaux[i].verscontrevoie then s:=s+'1' else s:=s+'0';
      s:=s+',CV';
      if Signaux[i].contrevoie then s:=s+'1' else s:=s+'0';
    end;
  end
  else
  // signaux directionnels
  begin
    NfeuxDir:=aspect-10;
    for j:=1 to NfeuxDir+1 do
    begin
      s:=s+'(';
      for k:=1 to Length(Signaux[i].AigDirection[j])-1 do
      begin
        s:=s+'A'+IntToSTR(Signaux[i].AigDirection[j][k].adresse) + Signaux[i].AigDirection[j][k].posaig;
        if k<Length(Signaux[i].AigDirection[j])-1 then s:=s+',';
      end;
      s:=s+')';
    end;
  end;

  encode_signal:=s;
end;

// d�code la ligne de signal et la stocke dans l'index i du tableau signaux
// sortie vrai si le signal a �t� stock� - faux si doublon
function decode_ligne_signal(chaine_signal : string;i : integer) : boolean;
var s,chaine,sa : string;
    j,k,l,t,id,adresse,adr,erreur ,asp,bd,decod: integer;
    c : char;
    multiple,fini : boolean;
begin
  //Affiche(chaine_signal,clyellow);
  decode_ligne_signal:=true;  // pas de doublon
  if i=0 then
  begin
    AfficheDebug('Erreur 670 : index nul',clred);
    exit;
  end;
  s:=chaine_signal;
  j:=pos(',',s);
  if j>1 then
  begin
    // adresse de signal
    val(s,adresse,erreur);
    if adresse=0 then begin affiche('Erreur 671 ligne '+s,clred);exit;end;
    // v�rifier si le signal existe d�ja pour ne pas le restocker
    for id:=1 to NbreSignaux do
    begin
      if Signaux[id].adresse=adresse then
      begin
        decode_ligne_signal:=false;
        exit;
      end;
    end;

    Delete(s,1,j);

    if adresse>MaxAcc then
      affiche('Erreur 637 : adresse signal '+intToSTR(adresse)+' trop �lev�e (maxi='+intToSTR(MaxAcc)+')',clred)
    else
    begin
      inc(NbreSignaux);
      Signaux[i].adresse:=adresse;
      tablo_Index_Signal[adresse]:=i; // stocker l'index provisoire avant tri
      j:=pos(',',s);
      if j>1 then
      begin
        sa:=copy(s,1,j-1);
        if sa[1]='D' then
        // signal directionnel ------------------------------------------
        begin
          delete(sa,1,1);
          j:=pos(',',s);
          val(sa,l,erreur); // nombre de feux du signal directionnel
          if l>6 then
          begin
            Affiche('Erreur 672.1 : '+chaine_signal+' 6 feux maximum pour un panneau directionnel',clred);
            exit;
          end;
          if l<3 then
          begin
            Affiche('Erreur 672.2 : '+chaine_signal+' 3 feux minimum pour un panneau directionnel',clred);
            exit;
          end;
          Signaux[i].aspect:=l+10;Delete(s,1,j);
          // d�codeur
          val(s,adr,erreur);
          Signaux[i].decodeur:=adr;
          if (adr>NbDecodeur-1) then Affiche('Erreur 673 : '+chaine_signal+' : erreur d�codeur inconnu',clred);
          j:=pos(',',s);Delete(s,1,j);
          // liste des aiguillages
          k:=1; // num�ro de feux directionnels
          repeat
            // boucle de direction
            delete(s,1,1); // supprimer ( ou le ,
            j:=1; // Nombre de descriptions d'aiguillages dans le signal
            repeat
              if s[1]<>'A' then begin Affiche('Erreur 674 - manque liste d''aiguillage(s) '+chaine_signal,clred);exit;end;
              delete(s,1,1);
              val(s,adr,erreur);  // adresse
              c:=#0;
              if erreur<>0 then c:=s[erreur];          // type
              setlength(Signaux[i].AigDirection[k],j+1);  // augmenter le tableau dynamique
              Signaux[i].AigDirection[k][j].PosAig:=c;
              Signaux[i].AigDirection[k][j].Adresse:=adr;
              delete(s,1,erreur);   // supprime jusque S
              //Affiche(s,clLime);
              if s[1]=',' then delete(s,1,1);
              inc(j);
            until s[1]=')';
            delete(s,1,1);
            inc(k);
          until length(s)<1;
          dec(k);
          if k<>l+1 then
          begin
            Affiche('Erreur 675 ligne '+chaine_signal,clred);
            Affiche('Nombre incorrect de description des aiguillages: '+intToSTR(k)+' pour '+intToSTR(l)+' feux directionnels',clred);
          end;
        end
        else
        // feu de signalisation---------------------------------
        begin
          val(sa,asp,erreur);  //aspect
          if (asp<2) or (asp=6) or (asp=8) or (asp>20) then
          begin
            Affiche('Erreur 676: configuration aspect ('+intToSTR(asp)+') signal incorrect � la ligne '+chaine_signal,clRed);
            asp:=2;
          end;
          Signaux[i].aspect:=asp;Delete(s,1,j);
          j:=pos(',',s);
          if j>1 then begin Signaux[i].FeuBlanc:=(copy(s,1,j-1))='1';delete(s,1,j);end;
          j:=pos(',',s);
          val(s,Signaux[i].decodeur,erreur);

          if (Signaux[i].decodeur>NbDecodeurdeBase+NbreDecPers-1) then Affiche('Erreur 677 : '+chaine_signal+' : erreur d�codeur inconnu: '+intToSTR(Signaux[i].decodeur),clred);
          if j<>0 then delete(s,1,j);
          Signaux[i].Adr_el_suiv1:=0;Signaux[i].Adr_el_suiv2:=0;Signaux[i].Adr_el_suiv3:=0;Signaux[i].Adr_el_suiv4:=0;
          Signaux[i].Btype_Suiv1:=rien;Signaux[i].Btype_Suiv2:=rien;Signaux[i].Btype_Suiv3:=rien;Signaux[i].Btype_Suiv4:=rien;
          Signaux[i].Adr_det1:=0;Signaux[i].Adr_det2:=0;Signaux[i].Adr_det3:=0;Signaux[i].Adr_det4:=0;
          // �l�ments optionnels des voies suppl�mentaires
          if j<>0 then
          begin
            sa:=s;
            multiple:=s[1]='(';
            if multiple then
            begin
              delete(s,1,1);
              j:=0;
              repeat
                adr:=0;
                k:=pos(',',s);
                if k>1 then
                begin
                  val(s,adr,erreur); // extraire l'adresse
                  Delete(s,1,k);
                  if Adr>NbMaxDet then
                  begin
                    Affiche('Erreur 677A : '+chaine_signal+' : adresse d�tecteur trop grand: '+intToSTR(adr),clred);
                    Adr:=NbMaxDet;
                  end;
                end;
                inc(j);
                if (j=1) then Signaux[i].Adr_det1:=adr;
                if (j=2) then Signaux[i].Adr_det2:=adr;
                if (j=3) then Signaux[i].Adr_det3:=adr;
                if (j=4) then Signaux[i].Adr_det4:=adr;
                //type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri
                if s[1]='A' then
                begin
                  if (j=1) then Signaux[i].Btype_Suiv1:=aig;
                  if (j=2) then Signaux[i].Btype_Suiv2:=aig;
                  if (j=3) then Signaux[i].Btype_Suiv3:=aig;
                  if (j=4) then Signaux[i].Btype_Suiv4:=aig;
                  delete(s,1,1);
                end
                else
                begin  // d�tecteur
                  if (j=1) then Signaux[i].Btype_Suiv1:=det;
                  if (j=2) then Signaux[i].Btype_Suiv2:=det;
                  if (j=3) then Signaux[i].Btype_Suiv3:=det;
                  if (j=4) then Signaux[i].Btype_Suiv4:=det;
                end;
                Val(s,adr,erreur);
                if Adr>NbMaxDet then
                begin
                  Affiche('Erreur 677B : '+chaine_signal+' : adresse �l�ment trop grand: '+intToSTR(adr),clred);
                  Adr:=NbMaxDet;
                end;
                if (j=1) then Signaux[i].Adr_el_suiv1:=Adr;
                if (j=2) then Signaux[i].Adr_el_suiv2:=Adr;
                if (j=3) then Signaux[i].Adr_el_suiv3:=Adr;
                if (j=4) then Signaux[i].Adr_el_suiv4:=Adr;
                delete(s,1,erreur-1);
                if s[1]=',' then delete(s,1,1);
                fini:=s[1]=')';
              until (fini) or (j>4);
           end;
         end;
       if (j>4) or (not(multiple)) then
       begin
         Affiche('Erreur 678: fichier de configuration ligne erronn�e : '+chaine_signal,clred);
         exit;
       end;
       k:=pos(',',s);
       delete(s,1,k);
       //Affiche('s='+s,clyellow);
       if length(s)=0 then begin Affiche('Erreur 679: fichier de configuration ligne erronn�e : '+chaine_signal,clred);exit;end;
       Signaux[i].VerrouCarre:=s[1]='1';
       delete(s,1,1);
       if length(s)>0 then if s[1]=',' then delete(s,1,1);
       if copy(s,1,3)='FVC' then
       begin
         delete(s,1,3);
         if length(s)>0 then begin Signaux[i].checkFV:=s[1]='1';delete(s,1,1);end;
       end;
       if length(s)>0 then if s[1]=',' then delete(s,1,1);
       if copy(s,1,3)='FRC' then
       begin
         delete(s,1,3);
         if length(s)>0 then begin Signaux[i].checkFR:=s[1]='1';delete(s,1,1);end;
       end;
       if length(s)>0 then if s[1]=',' then delete(s,1,1);
       if length(s)>0 then
       begin
         if copy(s,1,2)='NA' then
         begin
           delete(s,1,2);
           val(s,j,erreur);
           delete(s,1,1);
           if (j<2) or (j>5) then
           begin
             j:=5;affiche('Param�tre NA incorrect dans ligne '+chaine_signal,clred)
           end;
           Signaux[i].na:=j;
         end;
       end;

       if length(s)>0 then if s[1]=',' then delete(s,1,1);
       if length(s)>0 then
       begin
         if copy(s,1,3)='VCV' then
         begin
           delete(s,1,3);
           val(s,j,erreur);
           delete(s,1,1);
           if (j<0) or (j>1) then
           begin
             j:=0;affiche('Param�tre VCV incorrect dans ligne '+chaine_signal,clred)
           end;
           Signaux[i].verscontrevoie:=j=1;
         end;
       end;
       if length(s)>0 then if s[1]=',' then delete(s,1,1);
       if length(s)>0 then
       begin
         if copy(s,1,2)='CV' then
         begin
           delete(s,1,2);
           val(s,j,erreur);
           delete(s,1,1);
           if (j<0) or (j>1) then
           begin
             j:=0;affiche('Param�tre CV incorrect dans ligne '+chaine_signal,clred)
           end;
           Signaux[i].contrevoie:=j=1;
         end;
       end;
      if length(s)>0 then if s[1]='U' then delete(s,1,1);
      // si d�codeur UniSemaf (6) ou LEB (4) champ suppl�mentaire U
      decod:=Signaux[i].decodeur;
      if (decod=4) or (decod=6) then
      begin
        Val(s,k,erreur);
        delete(s,1,erreur);
        if k=0 then
        begin
          if decod=4 then
          begin
            Signaux[i].UniSemaf:=100 ; // passer en ancien pilotage
            Affiche('Erreur 679 : '+chaine_signal+' Manque d�finition cible signal LEB '+intToSTR(adresse),clred);
          end;
          if decod=6 then begin Affiche('Erreur 680 : '+chaine_signal+' Manque d�finition d�codeur UniSemaf signal '+intToSTR(adresse),clred);end;
        end
        else
          begin
            Signaux[i].UniSemaf:=k;
            if decod=4 then
            begin
              erreur:=verif_LEB(adresse,k);
              if erreur=1 then begin Affiche('Erreur 681 : '+chaine_signal+' Erreur code cible LEB',clred);end;
              if erreur=2 then
              begin
                Affiche('Erreur 682 : '+chaine_signal+' Erreur coh�rence signal (Adresse='+intToSTR(adresse)+' Aspect='+intToSTR(asp)+' et code cible LEB=('+intToSTR(k)+')',clred);
              end;
            end;
            if decod=6 then
            begin
              erreur:=verif_UniSemaf(adresse,k);
              if erreur=1 then begin Affiche('Erreur 682 : '+chaine_signal+' Erreur code Unisemaf',clred);end;
              if erreur=2 then
              begin
                Affiche('Erreur 682 : '+chaine_signal+' Erreur coh�rence signal (Adresse='+intToSTR(adresse)+' Aspect='+intToSTR(asp)+' et code Unisemaf=('+intToSTR(k)+')',clred);
              end;
            end;
          end;
        end;
      end;

      if length(s)>0 then if s[1]='L' then
      begin
        delete(s,1,1);
        // si d�codeur LEB (4) champ suppl�mentaire L : binaire ou lin�aire
        Val(s,k,erreur);
        delete(s,1,erreur);
        if (k<0) or (k>1) then k:=0;
        signaux[i].BinLin:=k;
      end;

     // voir si conditions suppl�mentaires de carr�
     l:=1;  // nombre de parenth�ses
     repeat
       t:=pos('(',s);
       if t=1 then
       begin
         //Affiche('Conditions suppl�mentaires pour le signal '+IntToSTR(adresse)+' parenth�se '+intToSTR(l),clyellow);
         k:=pos(')',s);
         sa:=copy(s,t+1,k-t); // contient l'int�rieur des parenth�ses sans les parenth�ses
         delete(s,1,k+1);//Affiche(s,clYellow);
         // boucle dans la parenth�se
         bd:=0;
         repeat
           inc(bd);
           setlength(Signaux[i].condCarre[l],bd+1);  // une condition en plus
           k:=pos(',',sa);
           if k<>0 then chaine:=copy(sa,1,k-1) else chaine:=sa;
           if chaine[1]='A' then
           begin
             delete(chaine,1,1);
             val(chaine,adresse,erreur);
             Signaux[i].condCarre[l][bd].Adresse:=adresse;
             if erreur<>0 then Signaux[i].condCarre[l][bd].PosAig:=chaine[erreur] else
             Affiche('Erreur 683 D�finition du signal '+IntToSTR(Signaux[i].adresse)+': Manque D ou S dans les conditions de carr� des aiguillages',clred);
           end;
           k:=pos(',',sa);if k<>0 then delete(sa,1,k);
         until k=0;
         inc(l);
       end;
       until t<>1;
       if length(s)>1 then if s[1]=',' then delete(s,1,1);

       // si conditions suppl�mentaires de feu blanc (CFB)
       l:=1;  // nombre de parenth�ses
       repeat
         t:=pos('CFB(',s);
         if t=1 then
         begin
         //Affiche('Conditions suppl�mentaires pour le signal '+IntToSTR(adresse)+' parenth�se '+intToSTR(l),clyellow);
           k:=pos(')',s);
           sa:=copy(s,t+4,k-4); // contient l'int�rieur des parenth�ses sans les parenth�ses
           delete(s,1,k+1);//Affiche(s,clYellow);

           // boucle dans la parenth�se
           bd:=0;
           repeat
             inc(bd);
             setlength(Signaux[i].condFeuBlanc[l],bd+1);  // une condition en plus
             k:=pos(',',sa);
             if k<>0 then chaine:=copy(sa,1,k-1)   // premier champ  ()
               else                     // le reste
               chaine:=sa;
             if chaine[1]='A' then
             begin
               delete(chaine,1,1);
               val(chaine,adresse,erreur);
               Signaux[i].condFeuBlanc[l][bd].Adresse:=adresse;
               if erreur<>0 then Signaux[i].condFeuBlanc[l][bd].PosAig:=chaine[erreur] else
                 Affiche('Erreur 684 D�finition du signal '+IntToSTR(Signaux[i].adresse)+': Manque D ou S dans les conditions de feu blanc des aiguillages',clred);
             end;
             k:=pos(',',sa);if k<>0 then delete(sa,1,k);
           until k=0;
           inc(l);
         end;
         until t<>1;
         if length(s)>1 then if s[1]=',' then delete(s,1,1);

       // champ SR
       if length(s)>2 then
       if copy(s,1,2)='SR' then
       begin
         delete(s,1,3);
         for l:=1 to 8 do
         begin
           k:=pos(',',s);
           val(s,j,erreur);
           delete(s,1,k);
           Signaux[i].SR[l].sortie1:=j;

           k:=pos(',',s);
           val(s,j,erreur);
           delete(s,1,k);
           Signaux[i].SR[l].sortie0:=j;
         end;
         if length(s)>2 then
         if copy(s,1,2)='NA' then
         begin
           delete(s,1,2);
           val(s,j,erreur);
           delete(s,1,erreur);
           Signaux[i].na:=j;

         end;
       end;

       // champ motif
       if length(s)>3 then if copy(s,1,3)='MOT' then
       begin
         delete(s,1,4);
         for l:=1 to 19 do
         begin
           k:=pos(',',s);
           val(s,j,erreur);
           delete(s,1,k);
           Signaux[i].SR[l].sortie1:=j;
         end;
         j:=pos('NA',s);
         if j<>1 then affiche('Manque param�tre NA dans ligne '+chaine_signal,clred)
         else
         begin
           delete(s,1,2);
           val(s,j,erreur);
           if (j<0) or (j>5) then
           begin
             j:=5;affiche('Param�tre NA incorrect dans ligne '+chaine_signal,clred)
          end;
          Signaux[i].na:=j;
        end;
      end;
      end;
    end;
  end;
end;

// transforme le d�tecteur en chaine
function encode_detecteur(i : integer) : string;
var adr : integer;
    s : string;
begin
  adr:=Adresse_detecteur[i];
  s:=intToSTR(adr)+','+intToSTR(detecteur[adr].longueur)+',';
  s:=s+intToSTR(detecteur[adr].ModeArret)+','+intToSTR(detecteur[adr].DistArret);
  result:=s;
end;

// transforme l'actionneur en chaine
function encode_actionneur(i : integer) : string;
begin
  if (i<1) or (i>nActionneurs) then
  begin
    result:='';
  end;
  result:=intToSTR(actionneur[i].adresse)+','+intToSTR(actionneur[i].prox1)+','+intToSTR(actionneur[i].prox2);
end;


// transforme l'action en chaine
function encode_actions(i : integer) : string;
var s : string;
    decl,action,Nb,j: integer;
begin
  if (i<1) or (i>maxTablo_act) then
  begin
    encode_actions:='';
    exit;
  end;

  s:=Tablo_Action[i].NomAction+',';

  decl:=Tablo_Action[i].declencheur;

  s:=s+'D'+intToSTR(decl)+',';
  case decl of
    declHorloge    : s:=s+intToSTR(Tablo_Action[i].heure)+','+intToSTR(Tablo_Action[i].minute)+',';
    declPeriph     : s:=s+intToSTR(Tablo_Action[i].NumPeriph)+','+Tablo_Action[i].ordrePeriph+',';
    DeclAccessoire : s:=s+intToSTR(Tablo_Action[i].adresse)+','+intToSTR(Tablo_Action[i].etat)+',';
    DeclDetAct     : s:=s+intToSTR(Tablo_Action[i].adresse)+','+intToSTR(Tablo_Action[i].etat)+','+Tablo_Action[i].trainDecl+',';
    DeclZoneDet    : s:=s+intToSTR(Tablo_Action[i].adresse)+','+intToSTR(Tablo_Action[i].adresse2)+','+intToSTR(Tablo_Action[i].etat)+','+Tablo_Action[i].trainDecl+',';
    DeclDemarTrain : s:=s+intToSTR(Tablo_Action[i].adresse)+','+Tablo_Action[i].trainDecl+',';
    DeclArretTrain : s:=s+intToSTR(Tablo_Action[i].adresse)+','+Tablo_Action[i].trainDecl+',';
    DeclSignal     : s:=s+intToSTR(Tablo_Action[i].adresse)+','+intToSTR(Tablo_Action[i].etat)+',';
    DeclFonction   : s:=s+intToSTR(Tablo_Action[i].adresse)+',';
    DeclClavier    : s:=s+intToSTR(Tablo_Action[i].adresse)+',';
  end;

  // conditions
  Nb:=Tablo_Action[i].NbCond;
  s:=s+'B'+IntToSTR(Nb)+',';
  for j:=1 to Nb do
  begin
    action:=Tablo_Action[i].TabloCond[j].numcondition;  // il n'y a qu'une condition (v8.8)
    s:=s+'C'+intToSTR(action)+',';  // num�ro de condition
    case action of
      condVitTrain : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].vitmini)+','+intToSTR(Tablo_Action[i].TabloCond[j].vitmaxi)+','+Tablo_Action[i].TabloCond[j].train+',';
      condPosAcc   : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].accessoire)+','+intToSTR(Tablo_Action[i].TabloCond[j].etat)+',';
      condHorl     : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].HeureMin)+','+intToSTR(Tablo_Action[i].TabloCond[j].MinuteMin)+','+
                              intToSTR(Tablo_Action[i].TabloCond[j].HeureMax)+','+intToSTR(Tablo_Action[i].TabloCond[j].MinuteMax)+',';
      condTrainSig : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].adresse)+','+Tablo_Action[i].TabloCond[j].train+',';
      condFonction : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].adresse)+',';
      condBouton   : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].adresse)+',';
      CondMemoireEgal,CondMemoireInf,CondMemoireSup
                   : s:=s+intToSTR(Tablo_Action[i].TabloCond[j].adresse)+','+intToSTR(Tablo_Action[i].TabloCond[j].etat)+',';
    end;
  end;

  Nb:=Tablo_Action[i].NbOperations;
  s:=s+'N'+intToSTR(nb)+',';

  for j:=1 to Nb do
  begin
    action:=Tablo_Action[i].TabloOp[j].numoperation;
    s:=s+'A'+intToSTR(action);
    if Tablo_Action[i].TabloOp[j].valide then s:=s+',1' else s:=s+',0';
    case action of
      ActionAffTCO    : s:=s+','+intToSTR(Tablo_Action[i].tabloOp[j].NumTCO);
      ActionAccessoire: begin
                          s:=s+','+intToSTR(Tablo_Action[i].tabloOp[j].adresse)+','+intToSTR(Tablo_Action[i].tabloOp[j].etat)+',';
                          if Tablo_Action[i].tabloOp[j].zero then s:=s+'Z' else s:=s+'S';
                        end;

      ActionVitesse   : s:=s+','+intToSTR(Tablo_Action[i].tabloOp[j].vitesse)+','+Tablo_Action[i].tabloOp[j].train;
      ActionCdePeriph : s:=s+','+intToSTR(Tablo_Action[i].tabloOp[j].periph)+','+Tablo_Action[i].tabloOp[j].chaine;
      ActionFonctionF : s:=s+','+intToSTR(Tablo_Action[i].tabloOp[j].fonctionF)+','+intToSTR(Tablo_Action[i].tabloOp[j].etat)+','+intToSTR(Tablo_Action[i].tabloOp[j].TempoF)+','+Tablo_Action[i].tabloOp[j].train;
      ActionSon       : s:=s+','+Tablo_Action[i].tabloOp[j].train;  // nom du fichier
      ActionTempo     : s:=s+','+intToSTR(Tablo_Action[i].tabloOp[j].TempoF);
      ActionBoutonTCO : s:=s+','+intToSTR(Tablo_Action[i].tabloOP[j].adresse)+','+intToSTR(Tablo_action[i].TabloOP[j].etat);
      ActionAffecteMemoire  : s:=s+','+intToSTR(Tablo_Action[i].tabloOP[j].adresse)+','+intToSTR(Tablo_Action[i].tabloOP[j].etat);
      ActionIncMemoire: s:=s+','+intToSTR(Tablo_Action[i].tabloOP[j].adresse);
      ActionDecMemoire: s:=s+','+intToSTR(Tablo_Action[i].tabloOP[j].adresse);

    end;

    if j<nb then s:=s+',';

 end;

  encode_actions:=s;
end;


// encode l'actionneur PN du tableau en texte
function encode_act_pn(i : integer) : string;
var s : string;
    voie,NbVoies : integer;
begin
  with formconfig do
  begin
    NbVoies:=Tablo_PN[i].NbVoies;
    if NbVoies>5 then nbVoies:=5;
    s:='';

    // par actionneur
    if tablo_pn[i].actionneur then
    begin
      for voie:=1 to NbVoies do
      begin
        s:=s+'('+intToSTR(tablo_PN[i].Voie[voie].ActFerme)+','+intToSTR(tablo_PN[i].Voie[voie].ActOuvre)+')';
        if voie<NbVoies then s:=s+',';
      end;
    end

    else
    // par zones de d�tecteur
    begin
      s:='';
      for voie:=1 to NbVoies do
      begin
        s:=s+'('+intToSTR(tablo_PN[i].Voie[voie].detZ1F)+'-'+intToSTR(tablo_PN[i].Voie[voie].detZ2F)+','+intToSTR(tablo_PN[i].Voie[voie].detZ1O)+
              '-'+intToSTR(tablo_PN[i].Voie[voie].detZ2O)+')';
        if voie<NbVoies then s:=s+',';
      end;
    end;

    // commande par accessoire
    if tablo_PN[i].TypeCde=0 then
    begin
      s:=s+',PN('+IntToSTR(tablo_PN[i].AdresseFerme)+',';
         s:=s+intToSTR(tablo_PN[i].commandeFerme)+',';
      s:=s+IntToSTR(tablo_PN[i].AdresseOuvre)+',';
         s:=s+intToSTR(tablo_PN[i].commandeOuvre)+'),';
    end;

    // commande par comusb
    if tablo_PN[i].TypeCde=1 then
    begin
      s:=s+',PN('+intToSTR(tablo_PN[i].AdresseFerme)+','+tablo_PN[i].commandeF+','+tablo_PN[i].commandeO+',0),';
    end;

    if tablo_PN[i].pulse=1 then s:=s+'1,' else s:=s+'0,';
    if tablo_PN[i].TypeCde=1 then s:=s+'1' else s:=s+'0';

  end;
  encode_act_pn:=s;
end;

// encode une entr�e de train
function encode_train(index : integer) : string;
var s: string;
    nc,i : integer;
begin
  with trains[index] do
  begin
    s:=nom_train+','+inttostr(adresse)+','+
    intToSTR(vitmax)+','+intToSTR(vitnominale)+','+
    intToSTR(vitRalenti)+','+NomIcone+','+intToSTR(TempsDemarreSig)+',';
    if inverse then s:=s+'1,' else s:=s+'0,';
    s:=s+intToSTR(longueur)+','+IntToSTR(ConsV1)+','+IntToSTR(ConsV2)+','+IntToSTR(ConsV3)+',';
    s:=s+FloatToSTRF(coeffV1,ffFixed,5,2,FormatSettings)+','+FloatToSTRF(coeffV2,ffFixed,5,2,FormatSettings)+','+FloatToSTRF(coeffV3,ffFixed,5,2,FormatSettings)+',';
    s:=s+intToSTR(CV3)+','+intToSTR(CV4)+','+intToSTR(crans);
    // arr�ts sur cantons
    for i:=1 to NbDetArret do
    begin
      nc:=DetecteurArret[i].detecteur;
      if nc<>0 then
      begin
        s:=s+',P';
        if detecteurArret[i].TPrec=aig then s:=s+'A';
        s:=s+intToSTR(detecteurArret[i].Prec);
        s:=s+',D'+intToSTR(nc)+',T'+intToSTR(DetecteurArret[i].temps);
      end;
    end;
  end;
  result:=s;
end;

// �crit le fichier de config en fonction du param�trage
procedure genere_config;
var s: string;
    fichierN : text;
    i,j,n,k : integer;
begin
  assignFile(fichierN,NomConfig);
  rewrite(fichierN);

  // ent�te
  // copie_commentaire;
  s:='/ Fichier de configuration de signaux_complexes_GL version '+versionSC+sousversion;
  writeln(fichierN,s);
  writeln(fichierN,CheminProgCDM_ch+'=',cheminProgrammesCDM);
  writeln(fichierN,largeurF_ch+'=',largeurF);
  writeln(fichierN,hauteurF_ch+'=',hauteurF);
  writeln(fichierN,OffsetXF_ch+'=',OffsetXF);
  writeln(fichierN,OffsetYF_ch+'=',OffsetYF);

  writeln(fichierN,largeurFC_ch+'=',largeurFC);
  writeln(fichierN,hauteurFC_ch+'=',hauteurFC);
  writeln(fichierN,OffsetXFC_ch+'=',OffsetXFC);
  writeln(fichierN,OffsetYFC_ch+'=',OffsetYFC);

  writeln(fichierN,PosSplitter_ch+'=',PosSplitter);

  writeln(fichierN,AvecVerifIconesTCO_ch+'=',AvecVerifIconesTCO);
  writeln(fichierN,Algo_localisation_ch+'=',Algo_localisation);
  writeln(fichierN,MaxSignalSens_ch+'=',Max_Signal_Sens);

  writeln(fichierN,debug_ch+'=',debug);
  if Modesombre then s:='1' else s:='0';
  writeln(fichierN,sombre_ch+'=',s);
  if debugRoulage then s:='1' else s:='0';
  writeln(fichierN,debugRoulage_ch+'=',s);
  if AffLoc then s:='1' else s:='0';
  writeln(fichierN,AffLoc_ch+'=',s);

  writeln(fichierN,couleur_fond_ch+'='+IntToHex(couleurFond,6));
  if serveurIPCDM_Touche then s:='1' else s:='0';
  writeln(fichierN,serveurIPCDM_Touche_ch+'='+s); 
  writeln(fichierN,PortServeur_ch+'=',PortServeur);
  writeln(fichierN,Filtrage_det_ch+'=',filtrageDet0);
  writeln(fichierN,nCantons_Res_ch+'=',nCantonsRes);
  writeln(fichierN,AntiTimeoutEthLenz_ch+'=',AntiTimeoutEthLenz);
  writeln(fichierN,TempoTC_ch+'=',TempoTC);
  // taille de la fonte
  writeln(fichierN,Fonte_ch+'=',TailleFonte);
  FormPrinc.FenRich.Font.Size:=TailleFonte;
  writeln(fichierN,Style_ch+'=',Nom_Style_aff);
  writeln(fichierN,Protocole_ch+'=',protocole);

  writeln(fichierN,Verif_AdrXpressNet_ch+'=',Verif_AdrXpressNet);

  // adresse ip et port de CDM
  writeln(fichierN,IpV4_PC_ch+'=',adresseIPCDM+':'+intToSTR(portCDM));

  // services CDM
  i:=0;
  if Srvc_Aig then i:=setbit(i,0);
  if Srvc_Act then i:=setbit(i,1);
  if Srvc_Det then i:=setbit(i,2);
  if Srvc_Pos then i:=setbit(i,3);
  if Srvc_Sig then i:=setbit(i,4);
  if Srvc_tspd then i:=setbit(i,5);
  writeln(fichierN,ServicesCDM_ch+'=',i);

  // adresse ip interface XpressNet
  writeln(fichierN,IPV4_Interface_ch+'=',adresseIP+':'+intToSTR(portInterface));

  // port com
  writeln(fichierN,Protocole_serie_ch+'=',portcom);

  // temporisation caract�re TempoOctet
  writeln(fichierN,Inter_Car_ch+'=',IntToSTR(TempoOctet));

  // temporisation attente maximale interface
  writeln(fichierN,Tempo_maxi_ch+'=',IntToSTR(TimoutMaxInterface));

  // entete Valeur_entete
  writeln(fichierN,Entete_ch+'=',intToSTR(Valeur_entete));

  // avec ou sans initialisation des aiguillages
  if AvecInitAiguillages then s:='1' else s:='0';
  writeln(fichierN,Init_Aig_ch+'='+s);

  // avec ou sans initialisation des aiguillages
  if PilotageTrainsCDMNom then s:='1' else s:='0';
  writeln(fichierN,PilotageTrainsCDM_ch+'='+s);

  // avec ou sans demande de la position des aiguillages en mode autonome
  if AvecDemandeAiguillages then s:='1' else s:='0';
  writeln(fichierN,Init_dem_aig_ch+'='+s);

  // temporisation initialisation des aiguillages
  writeln(fichierN,Tempo_aig_ch+'=',IntToSTR(Tempo_aig));

  writeln(fichierN,MaxParcours_ch+'=',IntToSTR(MaxParcours));
  writeln(fichierN,MaxRoutes_ch+'=',IntToSTR(MaxRoutes));
  writeln(fichierN,compteur_ch+'=',IntToSTR(compteur));
  writeln(fichierN,LargCompteur_ch+'=',IntToSTR(LargeurCompteurs));
  writeln(fichierN,LargComptC_ch+'=',IntToSTR(LargComptC));
  writeln(fichierN,HautComptC_ch+'=',IntToSTR(HautComptC));

  if VerrouilleCompteur then s:='1' else s:='0';
  writeln(fichierN,VerrouCompteur_ch+'=',s);

  writeln(fichierN,Echelle_ch+'='+intToSTR(Echelle));

  if affTrainCompteur then s:='1' else s:='0';
  writeln(fichierN,AffIconeTrCompteur_ch+'=',s);

  writeln(fichierN,Onglet_ch+'='+intToSTR(Onglet));

  if affCompteur then s:='1' else s:='0';
  writeln(fichierN,AffCompteur_ch+'=',s);

  // connexion de l'interface en COM/USB
  if AvecDemandeInterfaceUSB then s:='1' else s:='0';
  writeln(fichierN,Init_dem_interfaceUSBCOM_ch+'='+s);

  // connexion de l'interface en Ethernet
  if AvecDemandeInterfaceEth then s:='1' else s:='0';
  writeln(fichierN,Init_dem_interfaceEth_ch+'='+s);

  // plein �cran
  writeln(fichierN,Fenetre_ch+'=',fenetre);

  // �cran Signaux complexes
  writeln(fichierN,Ecran_ch+'=',intToSTR(Ecran_SC));

  // m�mo
  writeln(fichierN,AffMemoFenetre_ch+'=',AffMemoFenetre);

  // Nombre maxi de d�tecteurs consid�r�s distants
  writeln(fichierN,nb_det_dist_ch+'=',Nb_Det_Dist);

  // V�rification des versions au d�marrage
  if verifVersion then s:='1' else s:='0';
  writeln(fichierN,verif_version_ch+'=',s);

  // Notification de nouvelle version
  if notificationVersion then s:='1' else s:='0';
  writeln(fichierN,notif_version_ch+'=',s);

  // Avec TCO
  if AvecTCO then s:='1' else s:='0';
  writeln(fichierN,TCO_ch+'=',s);

  // nombre de TCO
  writeln(fichierN,Nb_TCO_ch+'=',NbreTCO);

  for i:=1 to 10 do
  begin
    s:=NomFichierTCO[i];
    if s='' then s:='TCO'+intToSTR(i);
    writeln(fichierN,Nom_fich_TCO_ch+intToSTR(i)+'=',s);
  end;

  if MasqueBandeauTCO then s:='1' else s:='0';
  writeln(fichierN,MasqueBandeauTCO_ch+'=',s);

  // lancement de CDM
  if LanceCDM then s:='1' else s:='0';
  writeln(fichierN,CDM_ch+'=',s);

  // Nom du lay
  writeln(fichierN,lay_ch+'=',Lay);

  writeln(fichierN,NomModuleCDM_ch+'=',NomModuleCDM);

  // Serveur d'interface de CDM
  writeln(fichierN,Serveur_interface_ch+'=',intToSTR(ServeurInterfaceCDM));

  // Serveur de r�trosignalisation Lenz de CDM
  writeln(fichierN,retro_ch+'=',intToSTR(ServeurRetroCDM));

  // Z21
  if Z21 then s:='1' else s:='0';
  writeln(fichierN,Z21_ch+'='+s);

  // Raz Signaux
  if Raz_Acc_signaux then s:='1' else s:='0';
  writeln(fichierN,Raz_signaux_ch+'='+s);

  if AffAigND then s:='1' else s:='0';
  writeln(fichierN,AffAigND_ch+'='+s);

  // temporisation entre 2 commandes d�codeurs signaux
  writeln(fichierN,Tempo_signal_ch+'=',IntToSTR(Tempo_Signal));

  // Nombre de cantons avant signal
  writeln(fichierN,Nb_cantons_Sig_ch+'=',intToSTR(Nb_cantons_Sig));

  // affichage �tats signaux
  if AffSig then s:='1' else s:='0';
  writeln(fichierN,cbAffSig_ch+'='+s);

  // affichage r�servation cantons
  if affRes then s:='1' else s:='0';
  writeln(fichierN,cbRes_ch+'='+s);

  // avec ack centrale
  if AvecAck then s:='1' else s:='0';
  writeln(fichierN,cbAck_ch+'='+s);

  if ModeTache then s:='1' else s:='0';
  writeln(fichierN,ModeTache_ch+'='+s);

  // avec option retour
  if option_demitour then s:='1' else s:='0';
  writeln(fichierN,option_demitour_ch+'='+s);

  // algorithme Unisemaf
  writeln(fichierN,Algo_unisemaf_ch+'=',IntToSTR(algo_Unisemaf));

  // aiguillages
  writeln(fichierN,'/------------');
  writeln(fichierN,section_aig_ch);
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_aig(i);
    aiguillage[i].modifie:=false;       // sauvegarde en cours, on d�marque
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_Branches_ch);
  // branches
  for i:=1 to NbreBranches do
  begin
    s:=Branche[i];
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');

  // d�codeurs de signaux personnalis�s (sauver avant les signaux pour avoir la liste des d�codeurs personnalis�s)
  writeln(fichierN,section_DecPers_ch);
  for i:=1 to NbreDecPers do
  begin
    s:=utf8encode('/ d�codeur n�'+intToSTR(i));
    Writeln(fichierN,s);
    writeln(fichierN,nom_dec_pers_ch+'='+decodeur_pers[i].nom);
    n:=decodeur_pers[i].NbreAdr;
    s:=Nba_ch+'='+intToSTR(n);
    writeln(fichierN,s);
    n:=decodeur_pers[i].nation;
    s:=nation_ch+'='+intToSTR(n);
    writeln(fichierN,s);
    s:=comm_ch+'='+intToSTR(decodeur_pers[i].commande);
    writeln(fichierN,s);
    s:=Periph_ch+'='+intToSTR(decodeur_pers[i].Peripherique);
    writeln(fichierN,s);
    // commande par centrale
    if decodeur_pers[i].commande=0 then
      for j:=1 to decodeur_pers[i].NbreAdr do
      begin
        s:=intToSTR(decodeur_pers[i].desc[j].etat1)+','+intToSTR(decodeur_pers[i].desc[j].etat2)+','+
           intToSTR(decodeur_pers[i].desc[j].offsetAdresse)+','+intToSTR(decodeur_pers[i].desc[j].sortie1)+','+
           intToSTR(decodeur_pers[i].desc[j].sortie2);
         writeln(fichierN,s);
      end;
      // commande par p�riph�rique
      if decodeur_pers[i].commande=1 then
      begin
        k:=decodeur_Pers[i].nation;
        if k=1 then
        for j:=1 to 19 do
        begin
          s:=utf8encode(etats[j])+','+decodeur_pers[i].desc[j].Chcommande;
          writeln(fichierN,s);
        end;
        if k=2 then
        begin
          for j:=1 to 9 do
          begin
            s:=EtatSignBelge[j]+','+decodeur_pers[i].desc[j].Chcommande;
            writeln(fichierN,s);
          end;
          for j:=10 to 19 do writeln(fichierN,' ,');
        end;
      end;  
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_sig_ch);
  // signaux
  for i:=1 to NbreSignaux do
  begin
    s:=encode_signal(i);
    // transformer le tableau signal en ligne
    //Affiche(s,clLime);
    if s='' then Affiche('Erreur 700 - Encodage du signal index='+IntToSTR(i),clRed);
    Signaux[i].modifie:=false;       // sauvegarde en cours, on d�marque
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_PN_ch);
  // PN
  for i:=1 to NbrePN do
  begin
    s:=encode_act_pn(i);
    if s<>'' then if s<>'' then writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  // actions
  writeln(fichierN,section_actV2_ch);
  for i:=1 to maxTablo_act do
  begin
    s:=encode_actions(i);
    if s<>'' then writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_dccpp_ch);
  writeln(fichierN,EnvAigDccpp_ch+'=',EnvAigDccpp);
  writeln(fichierN,AdrBaseDetDccpp_ch+'=',AdrBaseDetDccpp);

  writeln(fichierN,section_initpp_ch);
  // commandes DCC++
  i:=1;
  repeat
    s:=CdeDccpp[i];
    inc(i);
    if s<>'' then writeln(fichierN,s);
  until (s='') or (i>MaxCdeDccpp);
  writeln(fichierN,'0');

  // trains
  writeln(fichierN,'/------------');
  writeln(fichierN,section_trains_ch);
  for i:=1 to ntrains do
  begin
    writeln(fichierN,encode_train(i));
    // route du train
    for j:=1 to trains[i].routePref[0][0].adresse do
    begin
      s:='['+trains[i].NomRoute[j]+']'+',';
      if trains[i].routePref[j][0].talon then s:=s+'1,' else s:=s+'0,';  // sens
      s:=s+intToSTR(trains[i].routePref[j][0].pos);  // id route
      writeln(fichierN,s);
      if trains[i].routePref[j][0].adresse<>0 then Writeln(fichierN,'{'+route_totale_to_string(trains[i].routePref[j])+'}');
    end;
  end;
  writeln(fichierN,'0');

  // placement des trains dans les cantons
  writeln(fichierN,'/------------');
  writeln(fichierN,section_placement_ch);
  for i:=1 to ntrains do
    begin
      s:=trains[i].nom_train+',';
      j:=trains[i].canton;  //num�ro du canton
      s:=s+inttoSTR(j)+',';
      j:=index_canton_numero(j);
      if j<>0 then s:=s+intToSTR(canton[j].SensLoco)+',' else s:=s+'0,';
      if trains[i].inverse then s:=s+'1' else s:=s+'0';
      writeln(fichierN,s);
    end;
  writeln(fichierN,'0');

  // p�riph�riques comusb
  writeln(fichierN,'/------------');
  writeln(fichierN,section_accCOM_ch);
  for i:=1 to NbPeriph do
  begin
    s:=encode_Periph(i);
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  // horloge
  writeln(fichierN,'/------------');
  writeln(fichierN,section_horloge_ch);
  s:=horlogeInterne_ch+'=';
  if horlogeInterne then s:=s+'1' else s:=s+'0';
  writeln(fichierN,s);
  s:=LanceHorl_ch+'=';
  if LanceHorl then s:=s+'1' else s:=s+'0';
  writeln(fichierN,s);
  s:=AffHorl_ch+'=';
  if AffHorl then s:=s+'1' else s:=s+'0';
  writeln(fichierN,s);

  s:=relanceHorl_init_ch+'=';
  if relanceHorl_init then s:=s+'1' else s:=s+'0';
  writeln(fichierN,s);

  s:=HeureInit_ch+'='+intToSTR(HeureInit);
  writeln(fichierN,s);
  s:=MinuteInit_ch+'='+intToSTR(MinuteInit);
  writeln(fichierN,s);
  s:=RetourHeure_ch+'='+intToSTR(RetourHeure);
  writeln(fichierN,s);
  s:=RetourMinute_ch+'='+intToSTR(RetourMinute);
  writeln(fichierN,s);

  s:=DureeMinute_ch+'='+intToSTR(DureeMinute);
  writeln(fichierN,s);
  writeln(fichierN,'0');

  // actionneurs CDM
  writeln(fichierN,'/------------');
  writeln(fichierN,section_actionneurs_ch);
  for i:=1 to Nactionneurs do
  begin
    s:=encode_actionneur(i);
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  // d�tecteurs
  writeln(fichierN,'/------------');
  writeln(fichierN,section_detecteurs_ch);
  for i:=1 to NDetecteurs do
  begin
    s:=encode_detecteur(i);
    writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_logique_ch);
  for j:=1 to NbreFL do
  begin
    writeln(fichierN,'/--- Fonction '+intToSTR(j));
    writeln(FichierN,'"'+NomFonction[j]+'"');  // ajouter les guillemets pour �viter chaine vide
    n:=fonction[j,0].adresse;
    for i:=0 to n-1 do
    begin
      s:=intToSTR(i)+','+nomfonc[fonction[j,i].typ]+',';
      s:=s+'N'+intToSTR(fonction[j,i].niveau)+',';
      s:=s+'T'+intToSTR(fonction[j,i].typ)+',';
      s:=s+'A'+intToSTR(fonction[j,i].adresse)+',';
      s:=s+'E'+intToSTR(fonction[j,i].etat)+',';
      s:=s+'V'+','+fonction[j,i].train+',';
      s:=s+'O'+intToSTR(fonction[j,i].OpMemoire)+',';
      Writeln(fichierN,s);
    end;
    Writeln(fichierN,'FF'); // marqueur fin de fonction
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_blocs_USB_ch);
  for j:=1 to NbreBlocsUSB do
  begin
    s:='B'+intToSTR(j)+','+blocUSB[j].afftrain+',BR'+intToSTR(blocUSB[j].rotatifM)+','+intToSTR(blocUSB[j].rotatifP)+','+intToSTR(blocUSB[j].clic)+
           ','+intToSTR(blocUSB[j].increment)+
           ',B'+intToSTR(blocUSB[j].Bp1)+','+IntToSTR(blocUSB[j].Fbp1)+','+IntToSTR(blocUSB[j].Fnp1)+
           ',B'+intToSTR(blocUSB[j].Bp2)+','+IntToSTR(blocUSB[j].Fbp2)+','+IntToSTR(blocUSB[j].Fnp2)+
           ',B'+intToSTR(blocUSB[j].Bp3)+','+IntToSTR(blocUSB[j].Fbp3)+','+IntToSTR(blocUSB[j].Fnp3)+
           ',B'+intToSTR(blocUSB[j].Bp4)+','+IntToSTR(blocUSB[j].Fbp4)+','+IntToSTR(blocUSB[j].Fnp4)+
           ',B'+intToSTR(blocUSB[j].Bp5)+','+IntToSTR(blocUSB[j].Fbp5)+','+IntToSTR(blocUSB[j].Fnp5)+
           ',B'+intToSTR(blocUSB[j].Bp6)+','+IntToSTR(blocUSB[j].Fbp6)+','+IntToSTR(blocUSB[j].Fnp6)+
           ',B'+intToSTR(blocUSB[j].Bp7)+','+IntToSTR(blocUSB[j].Fbp7)+','+IntToSTR(blocUSB[j].Fnp7)+
           ',B'+intToSTR(blocUSB[j].Bp8)+','+IntToSTR(blocUSB[j].Fbp8)+','+IntToSTR(blocUSB[j].Fnp8)+
           ',B'+intToSTR(blocUSB[j].Bp9)+','+IntToSTR(blocUSB[j].Fbp9)+','+IntToSTR(blocUSB[j].Fnp9)+
           ',B'+intToSTR(blocUSB[j].Bp10)+','+IntToSTR(blocUSB[j].Fbp10)+','+IntToSTR(blocUSB[j].Fnp10);
    Writeln(fichierN,s);
  end;
  writeln(fichierN,'0');

  writeln(fichierN,'/------------');
  writeln(fichierN,section_compteurs_ch);
  for i:=1 to 3 do
  begin
    writeln(fichierN,'Compteur'+intToSTR(i));
    writeln(fichierN,'Aiguille='+intToHex(ParamCompteur[i].coulAig,6));
    writeln(fichierN,'Graduations='+intToHex(ParamCompteur[i].coulGrad,6));
    writeln(fichierN,'Numeros='+intToHex(ParamCompteur[i].coulNum,6));
    writeln(fichierN,'Fond='+intToHex(ParamCompteur[i].coulFond,6));
    writeln(fichierN,'Arc='+intToHex(ParamCompteur[i].coulArc,6));

  end;
  writeln(fichierN,'0');

  closefile(fichierN);
end;

// trier les cantons
procedure trier_cantons;
var i,j : integer;
    temp : TCanton;
begin
  for i:=1 to nCantons-1 do
  begin
    for j:=i+1 to nCantons do
    begin
      if canton[i].numero>canton[j].numero then
      begin
        temp:=canton[i];
        canton[i]:=canton[j];
        canton[j]:=temp;
      end;
    end;
  end;
end;

// trier les d�tecteurs
procedure trier_detecteurs;
var i,j,temp : integer;
begin
  for i:=1 to NDetecteurs-1 do
  begin
    for j:=i+1 to NDetecteurs do
    begin
      if Adresse_detecteur[i]>Adresse_detecteur[j] then
      begin
        temp:=Adresse_detecteur[i];
        Adresse_detecteur[i]:=Adresse_detecteur[j];
        Adresse_detecteur[j]:=temp;
      end;
    end;
  end;
  for i:=1 to NDetecteurs do
  begin
    temp:=adresse_detecteur[i];
    detecteur[temp].index:=i;
  end;
end;

procedure trier_actionneurs;
var i,j : integer;
    temp : Tactionneur;
begin
  for i:=1 to Nactionneurs-1 do
  begin
    for j:=i+1 to Nactionneurs do
    begin
      if actionneur[i].adresse>actionneur[j].adresse then
      begin
        temp:=actionneur[i];
        actionneur[i]:=actionneur[j];
        actionneur[j]:=temp;
      end;
    end;
  end;
end;

// trier les aiguillages par adresses croissantes
// et compl�te les aiguillages triples (cr��e aiguillahe homologue)
procedure trier_aig;
var i,j,adr : integer;
    temp : TAiguillage;
    s : string;
begin
  // attribue les index
  i:=1;
  while (i<MaxAiguillage) do
  begin
    // trouve les aiguillages triples
    if aiguillage[i].modele=triple then
    begin
      j:=index_aig(aiguillage[i].adrTriple);  // adresse de l'aiguillage homologue triple
      if j=0 then // si l'aiguillage n'a pas �t� trouv�, le cr�er
      begin
        inc(MaxAiguillage);
        aiguillage[MaxAiguillage].Adresse:=aiguillage[i].adrTriple;
        aiguillage[MaxAiguillage].modele:=aig;
        aiguillage[MaxAiguillage].visible:=false;
        aiguillage[MaxAiguillage].APointe:=aiguillage[i].Adroit;
        aiguillage[MaxAiguillage].APointeB:=aiguillage[i].AdroitB;
        aiguillage[MaxAiguillage].ADroit:=aiguillage[i].Adroit;
        aiguillage[MaxAiguillage].ADroitB:=aiguillage[i].AdroitB;
        aiguillage[MaxAiguillage].ADevie:=aiguillage[i].Adevie2;
        aiguillage[MaxAiguillage].ADevieB:=aiguillage[i].Adevie2B;
        config_modifie:=true;
      end
      else
        aiguillage[j].visible:=false;
    end
      else if aiguillage[i].visible then aiguillage[i].visible:=true; // si l'aiguillage a d�ja �t� marqu�, ne pas le d�marquer
    inc(i);
  end;

  // tri du tableau d'aiguillages
  for i:=1 to MaxAiguillage-1 do
  begin
    for j:=i+1 to MaxAiguillage do
    begin
      if aiguillage[i].Adresse>aiguillage[j].adresse then
      begin
        temp:=aiguillage[i];
        aiguillage[i]:=aiguillage[j];
        aiguillage[j]:=temp;
      end;
    end;
  end;

  // attribue les index
  for i:=1 to MaxAiguillage do
  begin
    adr:=aiguillage[i].adresse;
    tablo_index_aiguillage[adr]:=i;
  end;

  // r�affecte la listebox aiguillages
  if formconfig<>nil then
  begin
    formconfig.ListBoxAig.Clear;
    for i:=1 to MaxAiguillage do
    begin
      s:=encode_aig(i);
      formConfig.ListBoxAig.Items.AddObject(s, Pointer(clRed));
      Aiguillage[i].modifie:=false;
    end;
    formconfig.ListBoxAig.itemindex:=0;
  end;
end;

// trie les signaux par adresses croissantes
procedure trier_signaux;
var i,j,l,longestLength,pixelLength : integer;
    s,LongestString : string;
    tabloDet : TTabloDet;
    temp : TSignal;
begin
  for i:=1 to NbreSignaux-1 do
  begin
    for j:=i+1 to NbreSignaux do
    begin
      if Signaux[i].Adresse>Signaux[j].adresse then
      begin
        temp:=Signaux[i];
        Signaux[i]:=Signaux[j];
        Signaux[j]:=temp;
      end;
    end;
  end;

  // calcule les index
  for i:=1 to NbreSignaux do
  begin
    tablo_index_signal[Signaux[i].adresse]:=i;
  end;

  // trouver les d�tecteurs amont des signaux et les range dans la structure des signaux
  for i:=1 to NbreSignaux do
  begin
    adr:=Signaux[i].adresse;
    det_prec_signal(adr,TabloDet);
    Signaux[i].DetAmont:=TabloDet;
  end;

  if formconfig<>nil then
  begin
    formconfig.ListBoxSig.Clear;
    longestLength:=0;
    for i:=1 to NbreSignaux do
    begin
      s:=encode_signal(i);  // encode la ligne depuis le tableau feux
      //Affiche(s,clwhite);
      if s<>'' then
      begin
        formconfig.ListBoxSig.Items.Add(s);
        // trouver la chaine la plus longue pour la future scrollbar
        l:=Length(s);
        if l>LongestLength then
        begin
          LongestString:=s;
          LongestLength:=l;
        end;
        Signaux[i].modifie:=false;
      end;
    end;

    PixelLength:=formconfig.ListboxSig.Canvas.TextWidth(LongestString);
    // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
    SendMessage(formconfig.ListBoxSig.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);
  end;
end;


// trie les trains par adresses croissantes
// on utilise l'index 0 car si on d�clare une variabe temporaire
// t : Ttrain
// on a une erreur de stack overflow � l'ex�cution car la structure de Ttrain est trop grosse
procedure trier_trains;
var i,j : integer;
begin
  for i:=1 to ntrains-1 do
  begin
    for j:=i+1 to ntrains do
    begin
      if trains[i].Adresse>trains[j].adresse then
      begin
       trains[0]:=trains[i];
       trains[i]:=trains[j];
       trains[j]:=trains[0];
      end;
    end;
  end;
end;

// trouve les id des routesPref des trains et le stocke dedans
procedure compile_id_routes;
var t1,t2,r1,r2,Id,nr : integer;
    route1 : tUneroute;
begin
  // raz tous les ID de routes
  for t1:=1 to nTrains do
  begin
    nr:=trains[t1].routePref[0,0].adresse;  // nombre de routes
    for r1:=1 to nr do
    begin
      trains[t1].routePref[r1,0].pos:=0;
    end;
  end;

  Id:=1;
  // boucle des trains
  t1:=1;
  while (t1<=nTrains) do
  begin
    nr:=trains[t1].routePref[0,0].adresse;  // nombre de routes
    //r1:=routePref[1]; // route 1 du train t
    r1:=1;
    // boucle des routes
    while r1<nr+1 do
    begin
      route1:=trains[t1].routePref[r1];
      if trains[t1].routePref[r1,0].pos=0 then
      begin
        for t2:=t1 to nTrains do
        begin
          for r2:=1 to nr do
          begin
            //Affiche('Comparaison T'+intToSTR(t1)+' R'+intToSTR(r1)+' et T'+intToSTR(t2)+' R'+intToSTR(r2),clLime);
            if routes_identiques(route1,trains[t2].routePref[r2]) then
            begin
              trains[t2].routePref[r2,0].pos:=id;
              trains[t1].routePref[r1,0].pos:=id;
              //Affiche('Affecte T'+intToSTR(t1)+' R'+intToSTR(r1)+' et T'+intToSTR(t2)+' R'+intToSTR(r2)+' = '+intToSTR(id),clLime);
            end;
          end;
        end;
        inc(id);
      end;
      inc(r1);
    end;
    inc(t1);
  end;
end;

// compte le nombre de virgules dans la chaine
function Nbre_virgules(s : string) : integer ;
var i,c : integer;
begin
  c:=0;
  for i:=1 to length(s) do
    if s[i]=',' then inc(c);
  result:=c;
end;

function isOperateur(typ : integer): boolean;
begin
  result:=(typ>=OpET) and (typ<=OpNonOu);
end;

function isVariable(typ : integer): boolean;
begin
  result:=(typ>=EtatDCC) and (typ<=EtatMemoire);
end;

// donne le texte � mettre dans le tree view en fonction de l'index de fonction[]
// attention fonction[].typ doit �tre � jour
function texte_tv(fonc,i : integer) : string;
var s : string;
    etat,typ : integer;
begin
  if i=0 then typ:=0 else typ:=fonction[fonc,i].typ;  // pour l'indice 0, le type n'est pas significatif

  s:=NomFonc[typ]+' ';
  if typ=FoncVar then
  begin
    s:=NomVar+' '+IntToSTR(fonction[fonc,0].niveau); // delphi 12 n'accepte pas les tableaux de constante avec le 1er indice � 0 (NomFonc)
  end;
  if isVariable(typ) then
  begin
    if typ=EtatDCC then
    begin
      s:=s+intToSTR(fonction[fonc,i].adresse);
      etat:=fonction[fonc,i].etat;
      case etat of
        1 : s:=s+' d�vi� ';
        2 : s:=s+' droit ';
        else s:=s+' inconnu ';
      end;
      s:=s+'('+intToSTR(etat)+')';
    end;
    if typ=EtatDet then
    begin
      s:=s+fonction[fonc,i].train+' '+intToSTR(fonction[fonc,i].adresse)+' '+intToSTR(fonction[fonc,i].etat);
    end;
    if typ=EtatBoutonTCO then
    begin
      s:=s+intToSTR(fonction[fonc,i].adresse)+' ';
      etat:=fonction[fonc,i].etat;
      case etat of
        0 : s:=s+' d�sactiv� ';
        1 : s:=s+' activ� ';
        else s:=s+' inconnu ';
      end;
      s:=s+'('+intToSTR(etat)+')';
    end;
    if typ=EtatMemoire then
    begin
      s:=s+intToSTR(fonction[fonc,i].adresse);
      case fonction[fonc,i].opMemoire of
      0 : s:=s+' = ';
      1 : s:=s+' > ';
      2 : s:=s+' < ';
      end;
      s:=s+intToSTR(fonction[fonc,i].etat);
    end;
  end;
  result:=s;
end;

function texte_simple_tv(fonc,i : integer) : string;
var s : string;
    etat,typ : integer;
begin
  if i=0 then typ:=0 else typ:=fonction[fonc,i].typ;  // pour l'indice 0, le type n'est pas significatif

  if typ=FoncVar then
  begin
    s:=s+IntToSTR(fonction[fonc,0].niveau);
  end;

  if isVariable(typ) then
  begin
    if typ=EtatDCC then
    begin
      s:=s+intToSTR(fonction[fonc,i].adresse);
      etat:=fonction[fonc,i].etat;
      case etat of
        1 : s:=s+' d�vi� ';
        2 : s:=s+' droit ';
        else s:=s+' inconnu ';
      end;
    end;
    if typ=EtatDet then
    begin
      s:=s+intToSTR(fonction[fonc,i].adresse)+' '+intToSTR(fonction[fonc,i].etat);
    end;
    if typ=EtatBoutonTCO then
    begin
      s:=s+'Bt'+intToSTR(fonction[fonc,i].adresse)+' '+intToSTR(fonction[fonc,i].etat);
    end;
    if typ=EtatMemoire then
    begin
      s:=s+'Mem'+intToSTR(fonction[fonc,i].adresse);
      case fonction[fonc,i].opMemoire of
      0 : s:=s+' = ';
      1 : s:=s+' > ';
      2 : s:=s+' < ';
      end;
      s:=s+intToSTR(fonction[fonc,i].etat);
    end;
  end;

  if isOperateur(typ) then
  begin
    case typ of
    opET : s:=s+'ET';
    opOU : s:=s+'OU';
    opNonET: s:=s+'NonET';
    opNonOU: s:=s+'NonOU';
    end;
  end;
  result:=s;
end;

// g�n�re les informations calcul�es
procedure genere_informations_BD;
begin
  renseigne_TJDs_TCO;
  trier_aig;
  renseigne_tous_cantons;
  trier_cantons;
  trier_signaux;
  compile_id_routes;
end;

procedure lit_config;
var train,s,sa,SOrigine: string;
    c : char;
    tec,tjdC,tjsC,s2,triC,debugConfig,trouve_NbDetDist,trouve_ipv4_PC,trouve_retro,trouve_protocole,
    trouve_sec_init,trouve_init_aig,trouve_lay,trouve_IPV4_INTERFACE,trouve_PROTOCOLE_SERIE,trouve_INTER_CAR,
    trouve_Tempo_maxi,trouve_Entete,trouve_tco,trouve_cdm,trouve_Serveur_interface,trouve_fenetre,trouve_MasqueTCO,
    trouve_NOTIF_VERSION,trouve_verif_version,trouve_fonte,trouve_tempo_aig,trouve_raz,trouve_section_aig,
    trouve_section_branche,trouve_section_sig,trouve_section_act,trouve_tempo_signal,
    trouve_algo_uni,croi,trouve_Nb_cantons_Sig,trouve_dem_aig,trouve_demcnxCOMUSB,trouve_demcnxEth   : boolean;

    virgule,i_detect,erreur,aig2,detect,offset,j,position,i,
    ComptEl,Compt_IT,Num_Element,adr,Nligne,postriple,itl,vers,
    postjd,postjs,nv,it,Num_Champ,asp,adraig,poscroi,idtrain : integer;

    versR : double;

const LessThanValue=-1;
      EqualsValue=0;
      GreaterThanValue=1;

 function lit_ligne : string ;
    var esp,l1,l2 : integer;
    begin
      repeat
        readln(fichier,s);
        sOrigine:=s;
        s:=uppercase(s);
        if length(s)>0 then c:=s[1];
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      // supprime les espaces �ventuels sauf entre les guillements
      esp:=0;
      repeat
        l1:=pos('"',s);l2:=posEx('"',s,l1+1);
        esp:=posEx(' ',s,Esp+1);
        if (esp<>0) and (esp<l1) and (esp>l2) then delete(s,esp,1);
      until esp=0;
      lit_ligne:=s;
      if debug=1 then affiche(s,clLime);
    end;

  procedure compile_signaux;
  begin
  //Affiche('D�finition des signaux',clyellow);
  i:=1;Nligne:=1;
  NbreSignaux:=0;
  repeat
    inc(Nligne);
    s:=lit_ligne;
    if s<>'0' then
    begin
      if NbreSignaux>=NbreMaxiSignaux then
      begin
        Affiche('Nombre maximal de signaux atteint',clRed);
      end
      else
      begin
        if decode_ligne_signal(s,i) then    // d�code la chaine et stocke en tableau signal
        begin
          inc(i);
        end
        else
          Affiche('Erreur 9 : signal '+s+' en doublon a �t� ignor�',clred);
      end;
    end;
    until (s='0') or eof(fichier);
  end;

  procedure compile_branches;
  begin
  // branches
  NDetecteurs:=0;
  Nligne:=1;
  i_detect:=1;
  Nbuttoirs:=0;
  i:=1;
  //Affiche('D�finition des branches',clyellow);

  repeat
    s:=lit_ligne;
    if s<>'0' then
    begin
      branche[i]:=s;
      j:=1;offset:=1;
      inc(Nligne);
      compile_branche(s,i);
      inc(i);
    end;
  until (s='0') or eof(fichier) or (i>=MaxBranches);
  if i>MaxBranches then Affiche('Nombre maximal de branches atteint',clRed);
  NbreBranches:=i-1;
  end;

  procedure compile_pn;// Passage � niveau
  begin
    repeat
      s:=lit_ligne;
      s:=sOrigine;
      if s<>'0' then
      begin
        if pos('PN',uppercase(s))<>0 then
        begin
          //if k>0 then Tablo_Action[maxTablo_act].TabloOp[k].numoperation:=ActionPN;
          inc(NbrePN);
          NbreVoies:=0;
          repeat
            inc(NbreVoies);
            Delete(s,1,1); // supprime (
            // d�terminer si il y a un - avant le )
            j:=pos(')',s);
            i:=pos('-',s);
            if (i<j) and (i<>0) then
            begin
              // zone de d�tection
              Tablo_PN[NbrePN].actionneur:=false;
              val(s,j,erreur);
              Tablo_PN[NbrePN].voie[NbreVoies].detZ1F:=j;
              delete(s,1,erreur);

              val(s,j,erreur);
              Tablo_PN[NbrePN].voie[NbreVoies].detZ2F:=j;
              delete(s,1,erreur);

              val(s,j,erreur);
              Tablo_PN[NbrePN].voie[NbreVoies].detZ1O:=j;
              delete(s,1,erreur);

              val(s,j,erreur);
              Tablo_PN[NbrePN].voie[NbreVoies].detZ2O:=j;
            end
            else
            begin
              // actionneurs
              Tablo_PN[NbrePN].actionneur:=true;
              val(s,j,erreur);
              Tablo_PN[NbrePN].voie[NbreVoies].ActFerme:=j;
              //  Affiche('Ferme='+intToSTR(j),clyellow);
              i:=pos(',',s);
              Delete(S,1,i);
              val(s,j,erreur);
              Tablo_PN[NbrePN].voie[NbreVoies].ActOuvre:=j;
              // Affiche('Ouvre='+intToSTR(j),clyellow);
            end;

            i:=pos(')',s);Delete(S,1,i);
            i:=pos(',',s);Delete(S,1,i);
            Tablo_PN[NbrePN].compteur:=0;
          until (copy(s,1,2)='PN') or (NbreVoies=5);

          Tablo_PN[NbrePN].NbVoies:=NbreVoies;
          Delete(s,1,3);  // Supprime PN(
          val(s,j,erreur);
          Tablo_PN[NbrePN].Adresseferme:=j;   // adresse ferme ou num�ro accessoire
          Delete(s,1,erreur);
          // prendre le 4 param�tre (commande ACC ou COMUSB
          i:=pos(',',s);
          i:=posEx(',',s,i+1);
          i:=posEx(',',s,i+1);
          i:=posEx(',',s,i+1);
          val(copy(s,i+1,1),asp,erreur);
          if asp=0 then   // S peut peut �tre un nombre ou une chaine
          begin
            val(s,j,erreur);
            Tablo_PN[NbrePN].CommandeFerme:=j;
            j:=pos(',',s);
            Delete(s,1,j); // supprime s�parateurs

            val(s,j,erreur);
            Tablo_PN[NbrePN].AdresseOuvre:=j;
            Delete(s,1,erreur);
            val(s,j,erreur);
            Tablo_PN[NbrePN].CommandeOuvre:=j;
          end
          else
          begin
            // commande usb
            i:=pos(',',s);
            Tablo_PN[NbrePN].CommandeF:=copy(s,1,i-1);
            delete(s,1,i);
            i:=pos(',',s);
            Tablo_PN[NbrePN].CommandeO:=copy(s,1,i-1);
            delete(s,1,i);
          end;
          j:=pos(')',s);
          Delete(s,1,j); // supprime s�parateurs
          if length(s)>0 then
          begin
            // champ impulsion nouvelle syntaxe
            if s[1]=',' then delete(s,1,1);
            val(s,i,erreur);
            Tablo_PN[NbrePN].Pulse:=i;
            if erreur<>0 then
            begin
              delete(s,1,erreur);
              val(s,i,erreur);
              Tablo_PN[NbrePN].TypeCde:=i;
            end;
            s:='';
          end;
        end;
      end;
    until s='0';
  end;

  // anciens
  procedure compile_anciens_actionneurs;
  var i : integer;
  begin
  NbrePN:=0;
  confasauver:=true;
  // raz des actionneurs
  for i:=1 to Max_action do
  begin
    Tablo_Action[i].trainDecl:='';
    Tablo_Action[i].etat:=0;
    Tablo_Action[i].adresse:=0;
    Tablo_Action[i].adresse2:=0;
    Tablo_Action[i].trainDecl:='';
    Tablo_Action[i].declencheur:=0;
  end;

  maxTablo_act:=1;
  Nligne:=1;

  // d�finition des actionneurs et des PN int�gr�s anciens
  repeat
    s:=lit_ligne;
    if (s<>'0') and (s<>'')  then
    begin
     if (s[1]<>'(') then
     begin

      // premier champ type de d�clencheur--------------------
      // nombre      = actionneur/d�tecteur
      // MEM         = zone
      // Aaiguillage = aiguillage
      s:=sOrigine;  // travailler en min/maj
      Tablo_Action[maxtablo_act].NomAction:='Action '+intToSTR(maxtablo_act);

      // Mettre au moins une condition : vrai
      setlength(Tablo_Action[maxtablo_act].TabloCond,2);
      Tablo_Action[maxtablo_act].NbCond:=1;
      Tablo_Action[maxtablo_act].TabloCond[1].numcondition:=CondVrai;

      // �v�nement actionneur par horloge
      if (upcase(s[1])='H') then
      begin
        Tablo_Action[maxtablo_act].declencheur:=DeclHorloge;
        Delete(s,1,1);
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].heure:=j; //heure
        delete(s,1,erreur);
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].minute:=j; // minute
        delete(s,1,erreur);
        i:=pos(',',s);
        delete(s,1,i);
        i:=pos(',',s);
        delete(s,1,i);
      end
      else

      // �v�nement actionneur par accessoire
      if (upcase(s[1])='A') then
      begin
        Tablo_Action[maxtablo_act].declencheur:=DeclAccessoire;
        Delete(s,1,1);
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].adresse:=j;
        delete(s,1,erreur);
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].etat:=j;
        delete(s,1,erreur);
        i:=pos(',',s);
        //Tablo_Action[maxtablo_act].traindecl:=copy(s,1,i-1);  // inutile mais stock�
        delete(s,1,i);
      end
      else
      if upcase(s[1])='M' then     //MEM[
      begin
        Tablo_Action[maxtablo_act].declencheur:=DeclZoneDet;
        Delete(s,1,4);
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].adresse:=j;
        i:=pos(',',s);delete(s,1,i);
        val(s,j,erreur);
        i:=pos(',',s);
        Tablo_Action[maxtablo_act].adresse2:=j;
        delete(s,1,i);
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].etat:=j;
        delete(s,1,erreur);
        i:=pos(',',s);
        //Tablo_Action[maxtablo_act].traindecl:=copy(s,1,i-1);  // inutile mais stock�
        delete(s,1,i);
      end
      else
      if (s[1]<>'(') then
      begin
        // nombre
        Tablo_Action[maxtablo_act].declencheur:=DeclDetAct;
        val(s,j,erreur);
        Tablo_Action[maxtablo_act].adresse:=j;
        delete(s,1,erreur);
        val(s,j,erreur); delete(s,1,erreur);
        Tablo_Action[maxtablo_act].etat:=j;
        i:=pos(',',s);  // encadre le nom du train
        Tablo_Action[maxtablo_act].TrainDecl:=copy(s,1,i-1);
        delete(s,1,i);
      end;

      // type d'action -------------------------
      // F,etat,X
      // A,etat,X
      // "fichierson"
      // ACCnum
      setlength(Tablo_Action[maxtablo_act].TabloOp,2);
      Tablo_Action[maxtablo_act].NbOperations:=1;
      Tablo_Action[maxtablo_act].TabloOp[1].valide:=true;

      if upcase(s[1])='F' then
      begin
        // -----------------fonction loco
        Tablo_Action[maxTablo_act].TabloOp[1].numoperation:=ActionFonctionF;

        delete(s,1,1);
        val(s,j,erreur);
        Tablo_Action[maxTablo_act].TabloOp[1].fonctionF:=j;
        Delete(s,1,erreur);

        val(s,j,erreur);
        Tablo_Action[maxTablo_act].TabloOp[1].TempoF:=j div 100;
        Delete(s,1,erreur);

        Tablo_Action[maxTablo_act].TabloOp[1].train:=s;

        inc(maxTablo_act);
      end
      else

      if upcase(s[1])='V' then
      begin
        // -----------------vitesse
        Tablo_Action[maxTablo_act].TabloOp[1].numoperation:=ActionVitesse;

        delete(s,1,1);
        i:=pos(',',s);
        if i=0 then sa:=s;
        sa:=copy(s,1,i-1);
        val(sa,j,erreur);
        Tablo_Action[maxTablo_act].TabloOp[1].vitesse:=j;
        Delete(s,1,i);

        Tablo_Action[maxTablo_act].TabloOp[1].train:=s;

        inc(maxTablo_act);
      end
      else

      if uppercase(copy(s,1,3))='ACC' then
      begin
        // -----------------fonction commande p�riph�rique com usb
        Tablo_Action[maxTablo_act].TabloOp[1].numoperation:=ActionCdePeriph;

        delete(s,1,3);
        val(s,j,erreur);
        Tablo_Action[maxTablo_act].TabloOp[1].periph:=j;
        Delete(s,1,erreur);

        Tablo_Action[maxTablo_act].TabloOp[1].chaine:=s;

        inc(maxTablo_act);          // incr�menter index de stockage du tableau des actionneurs
        s:='';
      end
      else

      if s[1]='"' then
      begin
        // -----------------son
        Tablo_Action[maxTablo_act].TabloOp[1].numoperation:=ActionSon;

        delete(s,1,1);
        i:=pos('"',s);
        s:=copy(s,1,i-1);

        Tablo_Action[maxTablo_act].TabloOp[1].train:=s;
        s:='';
        inc(maxTablo_act);
      end
      else
      // accessoire
      if length(s)>0 then if (upcase(s[1])='A') and (upcase(s[2])<>'C') then
      begin
        Tablo_Action[maxTablo_act].TabloOp[1].numoperation:=ActionAccessoire;

        delete(s,1,1);
        val(s,j,erreur);
        Tablo_Action[maxTablo_act].TabloOp[1].adresse:=j;
        delete(s,1,erreur);

        val(s,j,erreur);
        Tablo_Action[maxTablo_act].TabloOp[1].etat:=j;
        Delete(s,1,erreur);

        Tablo_Action[maxTablo_act].TabloOp[1].zero:=s[1]='Z';
        inc(maxTablo_act);

        s:='';
     end;

     inc(Nligne);
    end;
    // Passage � niveau-----------------------------------------
    if (pos('PN',s)<>0) then
    begin
      s:=sOrigine;
      inc(NbrePN);
      NbreVoies:=0;
      repeat
        inc(NbreVoies);
        Delete(s,1,1); // supprime (
        // d�terminer si il y a un - avant le )
        j:=pos(')',s);
        i:=pos('-',s);
        if (i<j) and (i<>0) then
        begin
          // zone de d�tection
          Tablo_PN[NbrePN].actionneur:=false;
          val(s,j,erreur);
          Tablo_PN[NbrePN].voie[NbreVoies].detZ1F:=j;
          delete(s,1,erreur);

          val(s,j,erreur);
          Tablo_PN[NbrePN].voie[NbreVoies].detZ2F:=j;
          delete(s,1,erreur);

          val(s,j,erreur);
          Tablo_PN[NbrePN].voie[NbreVoies].detZ1O:=j;
          delete(s,1,erreur);

          val(s,j,erreur);
          Tablo_PN[NbrePN].voie[NbreVoies].detZ2O:=j;
        end
        else
        begin
          // actionneurs
          Tablo_PN[NbrePN].actionneur:=true;
          val(s,j,erreur);
          Tablo_PN[NbrePN].voie[NbreVoies].ActFerme:=j;
          //  Affiche('Ferme='+intToSTR(j),clyellow);
          i:=pos(',',s);
           Delete(S,1,i);
          val(s,j,erreur);
          Tablo_PN[NbrePN].voie[NbreVoies].ActOuvre:=j;
          // Affiche('Ouvre='+intToSTR(j),clyellow);
        end;

        i:=pos(')',s);Delete(S,1,i);
        i:=pos(',',s);Delete(S,1,i);
        Tablo_PN[NbrePN].compteur:=0;
      until (uppercase(copy(s,1,2))='PN') or (NbreVoies=5);

      Tablo_PN[NbrePN].NbVoies:=NbreVoies;
      Delete(s,1,3);  // Supprime PN(
      val(s,j,erreur);
      Tablo_PN[NbrePN].Adresseferme:=j;   // adresse ferme ou num�ro accessoire
      Delete(s,1,erreur);
      // prendre le 4 param�tre (commande ACC ou COMUSB
      i:=pos(',',s);
      i:=posEx(',',s,i+1);
      i:=posEx(',',s,i+1);
      i:=posEx(',',s,i+1);
      val(copy(s,i+1,1),asp,erreur);
      if asp=0 then   // S peut peut �tre un nombre ou une chaine
      begin
        val(s,j,erreur);
        Tablo_PN[NbrePN].CommandeFerme:=j;
        j:=pos(',',s);
        Delete(s,1,j); // supprime s�parateurs

        val(s,j,erreur);
        Tablo_PN[NbrePN].AdresseOuvre:=j;
        Delete(s,1,erreur);
        val(s,j,erreur);
        Tablo_PN[NbrePN].CommandeOuvre:=j;
      end
      else
      begin
        // commande usb
        i:=pos(',',s);
        Tablo_PN[NbrePN].CommandeF:=copy(s,1,i-1);
        delete(s,1,i);
        i:=pos(',',s);
        Tablo_PN[NbrePN].CommandeO:=copy(s,1,i-1);
        delete(s,1,i);
        end;
      j:=pos(')',s);
      Delete(s,1,j); // supprime s�parateurs
      if length(s)>0 then
      begin
        // champ impulsion nouvelle syntaxe
        if s[1]=',' then delete(s,1,1);
        val(s,i,erreur);
        Tablo_PN[NbrePN].Pulse:=i;
        if erreur<>0 then
        begin
          delete(s,1,erreur);
          val(s,i,erreur);
          Tablo_PN[NbrePN].TypeCde:=i;
        end;
        s:='';
      end;
    end;
  end;
  until (s='0') or eof(fichier) ;
  dec(maxTablo_act);

  end;

  procedure compile_actions;
  var n,k,l : integer;
  begin
    maxTablo_act:=1;
    Nligne:=1;

    // d�finition des actions
    repeat
      s:=lit_ligne;
      s:=sOrigine;
      if (s<>'0') and (s<>'') then
      begin
        i:=pos(',',s);
        sa:=copy(s,1,i-1);
        if sa='' then sa:='Action '+intToSTR(maxtablo_act);
        Tablo_Action[maxtablo_act].traite:=false;
        Tablo_Action[maxtablo_act].NomAction:=sa;
        // initialiser la condition toujours vrai par d�faut
        Tablo_Action[maxtablo_act].NbCond:=1;
        Setlength(Tablo_Action[maxtablo_act].TabloCond,2);
        Tablo_Action[maxtablo_act].TabloCond[1].numcondition:=CondVrai;

        Delete(s,1,i);
        // d�clencheur
        delete(s,1,1);
        Val(s,n,erreur);
        Tablo_Action[maxtablo_act].declencheur:=n;
        Delete(s,1,erreur);
        case n of
        Declhorloge :
          begin
            Val(s,i,erreur);Delete(s,1,erreur);
            Tablo_Action[maxtablo_act].heure:=i;
            Val(s,i,erreur);Delete(s,1,erreur);
            Tablo_Action[maxtablo_act].minute:=i;
          end;
        DeclPeriph :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].NumPeriph:=i;
             i:=pos(',',s); if i=0 then i:=length(s)+1;
             sa:=copy(s,1,i-1);delete(s,1,i);
             Tablo_Action[maxtablo_act].ordrePeriph:=sa;
            end;
         DeclAccessoire :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].adresse:=i;
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].etat:=i;
           end;
         DeclDetAct :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].adresse:=i;
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].etat:=i;
             i:=pos(',',s);if i=0 then i:=length(s)+1;
             sa:=copy(s,1,i-1);delete(s,1,i);
             Tablo_Action[maxtablo_act].trainDecl:=sa;
           end;
         DeclZoneDet :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].adresse:=i;
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].adresse2:=i;
             Val(s,i,erreur);Delete(s,1,erreur);
             Tablo_Action[maxtablo_act].etat:=i;
             i:=pos(',',s);
             sa:=copy(s,1,i-1);delete(s,1,i);
             Tablo_Action[maxtablo_act].trainDecl:=sa;
           end;
           DeclDemarTrain :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);  // seuil de vitesse : non utilis�
             Tablo_Action[maxtablo_act].adresse:=i;
             i:=pos(',',s);if i=0 then i:=length(s)+1;
             sa:=copy(s,1,i-1);delete(s,1,i);
             Tablo_Action[maxtablo_act].trainDecl:=sa;
           end;
           DeclArretTrain :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);  // seuil de vitesse : non utilis�
             Tablo_Action[maxtablo_act].adresse:=i;
             i:=pos(',',s);if i=0 then i:=length(s)+1;
             sa:=copy(s,1,i-1);delete(s,1,i);
             Tablo_Action[maxtablo_act].trainDecl:=sa;
           end;
           DeclSignal :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);  // adresse
             Tablo_Action[maxtablo_act].adresse:=i;
             i:=pos(',',s);
             Val(s,i,erreur);Delete(s,1,erreur);  // seuil de vitesse
             if (i<0) or (i>1) then i:=0;
             Tablo_Action[maxtablo_act].Etat:=i;
           end;
           DeclFonction :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);  // adresse
             Tablo_Action[maxtablo_act].adresse:=i;
           end;
           DeclClavier :
           begin
             Val(s,i,erreur);Delete(s,1,erreur);  // adresse
             Tablo_Action[maxtablo_act].adresse:=i;
           end;

        end;


        // conditions
        if s[1]='B' then
        begin
          delete(s,1,1);
          // nombre de conditions
          Val(s,n,erreur);
          Tablo_Action[maxtablo_act].NbCond:=n;
          Delete(s,1,erreur);
          setlength(Tablo_Action[maxtablo_act].TabloCond,n+1);
          for k:=1 to n do
          begin
            delete(s,1,1);
            val(s,j,erreur); delete(s,1,erreur);
            // num�ro de l'op�ration
            if (j<0) or (j>NbreConditions) then
            begin
              Affiche('Condition '+intToSTR(maxtablo_act)+' dans op�ration n�'+intToSTR(k)+' : cond inconnue :'+intToSTR(j),clred);
            end;
            Tablo_Action[maxtablo_act].tabloCond[k].numCondition:=j;
            case j of
            condVitTrain:
            begin
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].vitmini:=j;
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].vitmaxi:=j;
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloCond[k].train:=sa;
            end;
            condPosAcc :
            begin
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].accessoire:=j;
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].etat:=j;
            end;
            condHorl :
            begin
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].HeureMin:=j;
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].MinuteMin:=j;
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].HeureMax:=j;
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].MinuteMax:=j;
            end;
            condTrainSig :
            begin
              val(s,j,erreur); delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloCond[k].adresse:=j;
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloCond[k].train:=sa;
            end;
            CondFonction :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);  // adresse
              Tablo_Action[maxtablo_act].TabloCond[k].adresse:=i;
            end;
            CondBouton :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);  // num�ro de bouton
              Tablo_Action[maxtablo_act].TabloCond[k].adresse:=i;
            end;
            CondMemoireEgal,CondMemoireInf,CondMemoireSup :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].TabloCond[k].adresse:=i;
              erreur:=CompareValue(versR,9.70);
              if (erreur=equalsValue) or (erreur=GreaterThanValue) then    //versR>=9.70
              begin
                Val(s,i,erreur);Delete(s,1,erreur);
                Tablo_Action[maxtablo_act].tabloCond[k].etat:=i;
              end;
            end;
            end;
          end;
        end;

        // nombre d'actions
        delete(s,1,1);
        Val(s,n,erreur);
        if n=0 then n:=1;
        Tablo_Action[maxtablo_act].NbOperations:=n;
        Delete(s,1,erreur);

        setlength(Tablo_Action[maxtablo_act].TabloOp,n+1);
        Tablo_Action[maxtablo_act].tabloOP[1].numoperation:=0;
        for k:=1 to n do
        begin
          delete(s,1,1);  // supprime A de action
          val(s,j,erreur); delete(s,1,erreur);
          // num�ro de l'op�ration
          if (j<1) or (j>NbreOperations) then
          begin
            Affiche('Action '+intToSTR(maxtablo_act)+' dans op�ration n�'+intToSTR(k)+' : op inconnue :'+intToSTR(j),clred);
          end;
          Tablo_Action[maxtablo_act].tabloOP[k].numoperation:=j;

          // nouvelle version (pour param�tre d'activation)
          if versR>8.71 then
          begin
            val(s,l,erreur); delete(s,1,erreur);
            // �tat valid� ou d�valid�
            Tablo_Action[maxtablo_act].tabloOP[k].valide:=l=1;
          end else Tablo_Action[maxtablo_act].tabloOP[k].valide:=true;
          // param�tres des op�rations
          case j of
            ActionAffTCO :
            begin
              Val(s,i,erreur);delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].NumTCO:=i;
            end;
            ActionAffSC : begin end;
            ActionAffCDM : begin end;

            ActionAccessoire :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].adresse:=i;
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].etat:=i;
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloOp[k].zero:=sa='Z';
              delete(s,1,1);
            end;
            ActionArretTrains : begin end;
            ActionLanceHorl : begin end;
            ActionArretHorl : begin end;
            ActionInitHorl : begin end;
            ActionAffHorl : begin end;
            ActionVitesse :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].vitesse:=i;
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloOp[k].train:=sa;
            end;
            ActionCdePeriph :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);

              Tablo_Action[maxtablo_act].tabloOp[k].periph:=i;
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloOp[k].chaine:=sa;
            end;
            ActionFonctionF :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].fonctionF:=i;
              Val(s,i,erreur);Delete(s,1,erreur);
              // si version >9.4, champ suppl�mentaire
              if versR>=9.41 then
              begin
                Tablo_Action[maxtablo_act].tabloOp[k].Etat:=i;
                Val(s,i,erreur);Delete(s,1,erreur);
              end;
              Tablo_Action[maxtablo_act].tabloOp[k].TempoF:=i;
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloOp[k].train:=sa;
            end;
            ActionSon :
            begin
              i:=pos(',',s);
              if i<>0 then
              begin
                sa:=copy(s,1,i-1);delete(s,1,i);
              end
              else sa:=s;
              Tablo_Action[maxtablo_act].tabloOp[k].train:=sa;
            end;
            actionTempo :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].TempoF:=i;
            end;
            ActionBoutonTCO :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].adresse:=i;
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].etat:=i;
            end;
            ActionAffecteMemoire :
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].adresse:=i;
              // v9.7
              // si >=9.70
              if CompareValue(versR,9.70)>=0 then    
              begin
                Val(s,i,erreur);Delete(s,1,erreur);
                Tablo_Action[maxtablo_act].tabloOp[k].etat:=i;
              end;
            end;
            ActionIncMemoire:
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].adresse:=i;
            end;
            ActionDecMemoire:
            begin
              Val(s,i,erreur);Delete(s,1,erreur);
              Tablo_Action[maxtablo_act].tabloOp[k].adresse:=i;
            end;
          else
          begin
            if sOrigine<>'' then Affiche('Erreur 83: Action '+intToSTR(j)+' inconnue '+sOrigine,clred);
            Tablo_Action[maxtablo_act].TabloOp[k].numoperation:=0;
          end;
          end;
        end;
        inc(maxTablo_act);
      end;
    until (s='0') or eof(fichier) ;
    dec(maxTablo_act);
  end;

  procedure compile_aiguillages;
  begin
  //Affiche('D�finition des aiguillages',clyellow);
  maxaiguillage:=0;
  Nligne:=1;
  repeat
    s:=lit_ligne;
    inc(Nligne);
    //Affiche(s,ClLime);
    //chaine:=s;
    if debugconfig then Affiche(s,ClLime);
    if (s<>'0') then
    begin
      if MaxAiguillage>=NbreMaxiAiguillages then
      begin
        Affiche('Nombre maximal d''aiguillages atteint',clRed);
      end
      else
        inc(maxaiguillage);
      virgule:=pos(',',s);
      enregistrement:=copy(s,1,virgule-1);  // adresse de l'aiguillage [TRI]
      delete(s,1,virgule);
      postriple:=pos('TRI',enregistrement);triC:=postriple<>0;if triC then delete(enregistrement,postriple,3);
      postjd:=pos('TJD',enregistrement);tjdC:=postjd<>0;if tjdC then delete(enregistrement,postjd,3);
      postjs:=pos('TJS',enregistrement);tjsC:=postjs<>0;if tjsC then delete(enregistrement,postjs,3);
      poscroi:=pos('CROI',enregistrement);croi:=poscroi<>0;if croi then delete(enregistrement,poscroi,4);

      // adresse de l'aiguillage
      Val(enregistrement,adraig,erreur); // adraig = adresse de l'aiguillage

      if erreur<>0 then Affiche('Erreur aiguillage '+intToSTR(adraig)+' ; caract�re '+enregistrement[erreur]+' inconnu',clred);
      if debugConfig then Affiche('Adresse='+IntToSTR(adraig)+' enregistrement='+Enregistrement,clyellow);
      aiguillage[maxaiguillage].Adresse:=adraig;
      aiguillage[maxaiguillage].AncienAdresse:=adraig;
      aiguillage[maxaiguillage].visible:=true;

      tablo_index_aiguillage[adrAig]:=maxaiguillage;   // stockage index avant tri
      aiguillage[maxaiguillage].AdroitB:='Z'; aiguillage[maxaiguillage].AdevieB:='Z';
      aiguillage[maxaiguillage].DdroitB:='Z'; aiguillage[maxaiguillage].DdevieB:='Z';

      aiguillage[maxaiguillage].ApointeB:='Z';
      aiguillage[maxaiguillage].Adevie2B:='Z';

      if (triC) then aiguillage[maxaiguillage].modele:=triple;
      if (tjsC) then
      begin
        aiguillage[maxaiguillage].modele:=tjs
      end;
      if (tjdC) then
      begin
        aiguillage[maxaiguillage].modele:=tjd ;
      end;
      if not(tjsC) and not(tjdC) and not(triC) then
      begin
        aiguillage[maxaiguillage].modele:=aig;
      end;
      if croi then aiguillage[maxaiguillage].modele:=crois;

      if (triC) then
      begin
        Val(s,aig2,erreur); // aig = 2eme adresse de l'aiguillage
        aiguillage[maxaiguillage].AdrTriple:=aig2;
        virgule:=pos(',',s);
        delete(s,1,virgule);
      end;
      ComptEl:=0;Compt_It:=0;Num_element:=Num_element+1;
      // pr�parer l'enregistrement pour la boucle de ligne

      enregistrement:=s;

      Num_Champ:=1;
      itl:=0;
      repeat  // parcoure la ligne
        if (debugConfig) then Affiche('boucle de ligne: '+s,clYellow);
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='P') then
        begin
          if tjdC then begin affiche('Erreur P interdit dans une TJD : '+sOrigine,clred);exit; end;
          if debugconfig then Affiche('Section P - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          decodeAig(enregistrement,detect,c);
          if c='' then c:='Z';
          aiguillage[maxaiguillage].Apointe:=detect;
          aiguillage[maxaiguillage].ApointeB:=c;

          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(Enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        if (length(enregistrement)<>0) then  // section droite
        if (enregistrement[1]='D') then
        begin
          if debugconfig then Affiche('Section D - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          if tjdC or tjsC or croi then
          begin
            Delete(Enregistrement,1,2);
            decodeAig(Enregistrement,detect,c);
            aiguillage[maxaiguillage].Adroit:=detect;
            aiguillage[maxaiguillage].AdroitB:=c;
            i:=pos(',',Enregistrement);Delete(Enregistrement,1,i);
            decodeAig(Enregistrement,detect,c);
            aiguillage[maxaiguillage].DDroit:=detect;
            aiguillage[maxaiguillage].DdroitB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);exit;end;
            Delete(enregistrement,1,i+1);
          end
          else
          begin
            decodeAig(enregistrement,detect,c);
            if c='' then c:='Z';
            aiguillage[maxaiguillage].Adroit:=detect;
            aiguillage[maxaiguillage].AdroitB:=c;

            virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
            delete(enregistrement,1,virgule);
          end;
        end;

        if (length(enregistrement)<>0) then
        if (enregistrement[1]='S') then
        begin
          if debugconfig then Affiche('Section S - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;

          if tjdC or tjsC or croi then
          begin
            Delete(enregistrement,1,2);
            decodeAig(enregistrement,detect,c);
            aiguillage[maxaiguillage].Adevie:=detect;
            aiguillage[maxaiguillage].AdevieB:=c;
            i:=pos(',',enregistrement);Delete(enregistrement,1,i);
            decodeAig(enregistrement,detect,c);
            aiguillage[maxaiguillage].DDevie:=detect;
            aiguillage[maxaiguillage].DDevieB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);exit;end;
            Delete(enregistrement,1,i+1);

            //Affiche(enregistrement,clBlue);
          end
          else
          begin
            delete(enregistrement,1,1); // supprime le S
            i:=pos(',',enregistrement);
            if i=0 then i:=length(enregistrement)+1;
            s:=copy(enregistrement,1,i-1); // isole la zone S

            erreur:=pos('2-',s);
            S2:=erreur<>0;
            if (S2) then delete(s,erreur,2);

            erreur:=pos('S2',s); // description d'un rattachement � la branche S2 d'un aiguillage triple
            tec:=erreur<>0;  // ne supprimer que le 2
            if (tec) then delete(s,erreur+1,1);

            decodeAig(s,detect,c);

            if not(S2) and not(tec) then begin aiguillage[maxaiguillage].Adevie:=detect;aiguillage[maxaiguillage].AdevieB:=c;end;
            if     S2  and not(tec) then begin aiguillage[maxaiguillage].Adevie2:=detect;aiguillage[maxaiguillage].Adevie2B:=c;end;
            if     S2  and     tec  then begin aiguillage[maxaiguillage].Adevie2:=detect;aiguillage[maxaiguillage].Adevie2B:='T';end;

            virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
            delete(enregistrement,1,virgule);;
          end;
        end;

        // inversion aiguillage
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='I')  then
        begin
           inc(Num_Champ);
           delete(enregistrement,1,1);
           Val(enregistrement,adr,erreur);
           if (adr<0) or (adr>1) then begin Affiche('Erreur Inversion ; ligne '+sOrigine,clred);end;
           //Affiche(intTostr(adr),clblue);
           Aiguillage[maxaiguillage].inversionCDM:=adr;
           virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
           delete(enregistrement,1,virgule);
        end;

        // si vitesse d�finie
        if (length(enregistrement)<>0) then
        if enregistrement[1]='V' then
        begin
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          //Affiche('section vitesse d�finie aig='+intToSTR(aig)+'/'+intToSTR(adr),clyellow);
          aiguillage[maxaiguillage].vitesse:=adr;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
          delete(enregistrement,1,virgule);
        end;

        // TJS et L
        if (length(enregistrement)<>0) then
        if enregistrement[1]='L' then
        begin
          if not(tjsC) then begin Affiche('Erreur param�tre L ligne: '+sOrigine,clred);exit;end;
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          aiguillage[maxaiguillage].tjsInt:=adr;
          c:=#0;
          if erreur<>0 then c:=enregistrement[erreur];
          if ((c<>'S') and (c<>'D')) then
          begin
            c:=' ';Affiche('Erreur param�tre L '+sOrigine,clred);
          end;
          aiguillage[maxaiguillage].tjsIntB:=c;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        // Init aiguillage
        i:=pos('INIT(',enregistrement);
        if i=1 then
        begin
          inc(num_champ);
          delete(enregistrement,i,i+4);
          Val(enregistrement,position,erreur);
          i:=pos(',',enregistrement);
          if i<>0 then delete(enregistrement,1,i);
          Val(enregistrement,j,erreur);
          aiguillage[maxaiguillage].temps:=j;
          aiguillage[maxaiguillage].posinit:=position;
          i:=pos(')',enregistrement);
          delete(enregistrement,1,i);
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        // nombre d'�tats de la TJD
        if (length(enregistrement)<>0) then
        if enregistrement[1]='E' then
        begin
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          aiguillage[maxaiguillage].EtatTJD:=adr;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
          delete(enregistrement,1,virgule);
        end;

        if (length(enregistrement)<>0) then
        if enregistrement[1]='C' then
        begin
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          aiguillage[maxaiguillage].AdrCDM:=adr;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
          delete(enregistrement,1,virgule);
        end;

        inc(itl);
      until (enregistrement='') or (itl>3);
      if itl>4 then begin Affiche('Erreur 400 ligne '+sOrigine,clred);exit;end;

    end;
    until (sOrigine='0');
  end;

  // compile les d�codeurs personnalis�s
  procedure compile_dec_pers;
  var nv,j,k,l,adr,c : integer;
  begin
  Nligne:=1;
  s:='';
  repeat    // boucle de d�codeurs
    nv:=0;  // compteur nombre de variables
    c:=0;   // commande par centrale
    repeat  // boucle d'entete d'un d�codeur
      inc(Nligne);
      if s<>'0' then
      begin
        if NbreDecPers<NbreMaxiDecPers then
        begin
          // nom du d�codeur
          k:=pos(uppercase(nom_dec_pers_ch)+'=',s);
          if k=1 then
          begin
            s:='';
            inc(NbreDecPers);
            k:=pos('=',sOrigine);
            decodeur_pers[NbreDecPers].nom:=copy(sOrigine,k+1,length(sOrigine)-k+1);
            decodeur[NbDecodeurdeBase+NbreDecPers-1]:=copy(sOrigine,k+1,length(sOrigine)-k+1);
            inc(nv);
          end;

          // nombre d'adresses
          k:=pos(uppercase(nba_ch)+'=',s);
          if (k=1) and (NbreDecPers>0) then
          begin
            delete(s,1,length(nba_ch)+1);
            val(s,j,erreur);                        // ne pas �craser j il va �tre lu apr�s
            if j>10 then j:=10;
            decodeur_pers[NbreDecPers].NbreAdr:=j;
            inc(nv);
          end;

          // nation
          k:=pos(uppercase(nation_ch)+'=',s);
          if (k=1) and (NbreDecPers>0) then
          begin
            delete(s,1,length(nation_ch)+1);
            val(s,k,erreur);
            if (k=0) or (k>2) then k:=1;
            decodeur_pers[NbreDecPers].Nation:=k;
            inc(nv);
          end;

          // commande comm_ch
          k:=pos(uppercase(comm_ch)+'=',s);
          if (k=1) and (NbreDecPers>0) then
          begin
            delete(s,1,length(comm_ch)+1);
            val(s,c,erreur);
            if (c<0) or (c>1) then c:=0;
            decodeur_pers[NbreDecPers].commande:=c;     // ne pas �craser c
            if c=1 then j:=19;   // dire que la boucle des commandes est de 19 param�tres
            inc(nv);
          end;

          // p�riph�rique
          k:=pos(uppercase(Periph_ch)+'=',s);
          if (k=1) and (NbreDecPers>0) then
          begin
            delete(s,1,length(periph_ch)+1);
            val(s,k,erreur);
            decodeur_pers[NbreDecPers].Peripherique:=k;
            inc(nv);
          end;
        end;
      end;
      s:=lit_ligne;
    until eof(fichier) or (pos('=',sOrigine)=0) or (nv=5); // on sort de la boucle si on a lu les 5 variables

    adr:=1;
    if sOrigine<>'0' then
    repeat
      if s<>'0' then
      begin
        if c=0 then   //type commande 0=par centrale 1=com/socket
        begin
          k:=pos(',',s);
          val(s,l,erreur);
          delete(s,1,k);
          decodeur_pers[NbreDecPers].desc[adr].etat1:=l;
          k:=pos(',',s);
          val(s,l,erreur);
          delete(s,1,k);
          decodeur_pers[NbreDecPers].desc[adr].etat2:=l;
          k:=pos(',',s);
          val(s,l,erreur);
          delete(s,1,k);
          decodeur_pers[NbreDecPers].desc[adr].offsetadresse:=l;
          k:=pos(',',s);
          val(s,l,erreur);
          delete(s,1,k);
          decodeur_pers[NbreDecPers].desc[adr].sortie1:=l;
          k:=pos(',',s);
          val(s,l,erreur);
          delete(s,1,k);
          decodeur_pers[NbreDecPers].desc[adr].sortie2:=l;
          s:='';
          inc(adr);
        end;
        if c=1 then
        begin
          k:=pos(',',sOrigine);    // on ne tient compte que du 2�me champ
          s:=copy(sOrigine,k+1,length(sOrigine)-k+1);  // on ne copie que le 2eme champ
          decodeur_pers[NbreDecPers].desc[adr].Chcommande:=s;
          s:='';
          inc(adr);
        end;
      end;
      s:=lit_ligne;

      //else Affiche('Section d�codeurs - Nombre de descriptions du d�codeur "'+decodeur_pers[NbreDecPers].nom+'" diff�rents du nombre des adresses d�clar�es',clred);
    until (adr>j) or (s='0');

   until eof(fichier) or (s='0');
  end;

  procedure compile_dccpp;
  var nv,i  : integer;
  begin
  Nligne:=1;
  nv:=0;
  repeat
    lit_ligne;
    sa:=sOrigine;

    sa:=uppercase(EnvAigDccpp_ch);
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa)+1);
      val(s,EnvAigDccpp,erreur);
      s:='';
    end;

    sa:=uppercase(AdrBaseDetDccpp_ch);
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa)+1);
      val(s,AdrBaseDetDccpp,erreur);
      s:='';
    end;

    sa:=uppercase(section_initpp_ch);
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      nLigne:=1;
      repeat
        lit_ligne;
        s:=sOrigine;
        if s<>'0' then CdeDccpp[Nligne]:=s;
        inc(Nligne);
      until eof(fichier) or (s='') or (s='0') or (nLigne>MaxCdeDccpp);
    end;

    until eof(fichier) or (s='0');
  end;

  procedure compile_route(s : string);
  var v,i,j,erreur,n : integer;
      bug : boolean;
  begin
    j:=trains[ntrains].routePref[0][0].adresse; // index de la route
    s:=lowercase(s);
    if s<>'' then
    if s[1]='{' then
    begin
      delete(s,1,1);
      n:=0;i:=1;  // i est l'index de l'�l�ment dans la routePref
      with trains[ntrains] do
      repeat
        val(s,v,erreur);                   //{540->91 dev->92 droit->105 droit->106 droit->566}
        // d�tection bug ancien croisement cod� en 1030
        bug:=v>1000;
        if bug then
        begin
          v:=v div 10;
          routePref[j][i].pos:=0;
        end;
        routePref[j][i].adresse:=v;
        delete(s,1,erreur-1);
        while s[1]=' ' do
        begin
          delete(s,1,1);
        end;                                   
        if ((s[1]='-') or (s[1]='}')) and not bug then begin routePref[j][i].typ:=det;routePref[j][i].pos:=0;end
        else
        begin
          if s[1]=' ' then delete(s,1,1);
          routePref[j][i].typ:=aiguillage[index_aig(v)].modele;  // type de l'aiguillage;
          if copy(s,1,3)='dev' then begin delete(s,1,3);routePref[j][i].pos:=const_devie;end;
          if copy(s,1,5)='droit' then begin delete(s,1,5);routePref[j][i].pos:=const_droit;end;
          if copy(s,1,5)='crois' then begin delete(s,1,5);routePref[j][i].pos:=0;end;
        end;
        delete(s,1,2);
        inc(i);
      until length(s)<2;
      trains[ntrains].routePref[j][0].adresse:=i-1;
    end;
  end;

  procedure compile_trains;
  var i,j,erreur,n,id : integer;
      r : single;
      ss : string;
      lire,trouveNom,sens : boolean;
  begin
  ntrains:=0;

  lire:=true;
  repeat
    if lire then s:=lit_ligne;
    lire:=true;
    if s<>'0' then
    begin
      inc(nTrains);

      sa:=sOrigine;
      i:=pos(',',s);
      if i<>0 then
      begin
        trains[ntrains].nom_train:=copy(sa,1,i-1);
        delete(s,1,i-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        val(s,trains[ntrains].adresse,erreur);
        delete(s,1,erreur-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        val(s,trains[ntrains].vitMax,erreur);
        delete(s,1,erreur-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        val(s,trains[ntrains].vitnominale,erreur);
        delete(s,1,erreur-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        val(s,trains[ntrains].vitralenti,erreur);
        delete(s,1,erreur-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        i:=pos(',',s);
        if i=0 then i:=length(s)+1;
        trains[ntrains].NomIcone:=copy(s,1,i-1);
        Trains[ntrains].icone:=Timage.create(nil);

        with Trains[ntrains].icone do
        begin
          autosize:=true;
          align:=alNone;
          parent:=nil;
          name:='IconeTrain'+intToSTR(nTrains);
          top:=0;left:=0;
          width:=200;
          height:=100;
        end;

        Formprinc.ComboTrains.Items.Add(trains[ntrains].nom_train);
        delete(s,1,i-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        val(s,i,erreur);
        if (i<0) or (i>20) then i:=0;
        trains[ntrains].TempsDemarreSig:=i;
        delete(s,1,erreur-1);
      end;

      i:=pos(',',s);
      if i<>0 then
      begin
        delete(s,i,1);
        val(s,i,erreur);
        if (i<0) or (i>1) then i:=0;
        trains[ntrains].inverse:=i=1;
        delete(s,1,erreur-1);
      end;

      if versR>9.41 then
      begin
        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].longueur:=i;
          delete(s,1,erreur-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].ConsV1:=i;
          delete(s,1,erreur-1);
        end;
        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].ConsV2:=i;
          delete(s,1,erreur-1);
        end;
        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].ConsV3:=i;
          delete(s,1,erreur-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          i:=pos(',',s);
          ss:=copy(s,1,i-1);
          try
            r:=StrToFloat(ss,FormatSettings);
          except
            r:=0;
            Affiche('Erreur 93 : Format flottant incorrect : '+ss+' dans '+sOrigine,clred);
          end;
          trains[ntrains].CoeffV1:=r;
          delete(s,1,i-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          i:=pos(',',s);
          ss:=copy(s,1,i-1);
          try
            r:=StrToFloat(ss,FormatSettings);
          except
            r:=0;
            Affiche('Erreur 94 : Format flottant incorrect : '+ss+' dans '+sOrigine,clred);
          end;
          trains[ntrains].CoeffV2:=r;
          delete(s,1,i-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          i:=pos(',',s);
          if i<>0 then ss:=copy(s,1,i-1) else ss:=s;
          try
            r:=StrToFloat(ss,FormatSettings);
          except
            r:=0;
            Affiche('Erreur 95 : Format flottant incorrect : '+ss+' dans '+sOrigine,clred);
          end;
          trains[ntrains].CoeffV3:=r;
          if i<>0 then delete(s,1,i-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].CV3:=i;
          delete(s,1,erreur-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].CV4:=i;
          delete(s,1,erreur-1);
        end;

        i:=pos(',',s);
        if i<>0 then
        begin
          delete(s,i,1);
          val(s,i,erreur);
          trains[ntrains].crans:=i;
          delete(s,1,erreur-1);
        end;

      end;

      // d�tecteurs d'arret
      i:=pos(',',s);
      if i<>0 then
      begin
        j:=1;
        delete(s,i,1);  // supprime virgule
        repeat
          if s[1]='P' then
          begin
            delete(s,1,1);
            if s[1]='A' then
            begin
              trains[ntrains].DetecteurArret[j].TPrec:=aig;
              delete(s,1,1);
            end
            else trains[ntrains].DetecteurArret[j].Tprec:=det;
            val(s,i,erreur);
            trains[ntrains].DetecteurArret[j].Prec:=i;
            delete(s,1,erreur);
          end;
          if s[1]='D' then
          begin
            delete(s,1,1);
            val(s,i,erreur);
            trains[ntrains].DetecteurArret[j].detecteur:=i;
            delete(s,1,erreur);
          end;
          if s[1]='T' then
          begin
            delete(s,1,1);
            val(s,i,erreur);
            trains[ntrains].DetecteurArret[j].temps:=i;
            if erreur=0 then erreur:=length(s);
            delete(s,1,erreur);
          end;
          inc(j);
        until (s='') or (j>NbDetArret);
      end;
    end;

    // y a t-il une route
    lit_ligne;
    lire:=false;
    if length(s)>0 then
    while (s[1]='{') or (s[1]='[') do
    begin
      sens:=false;
      trouveNom:=false;
      if s[1]='[' then
      begin
        s:=sOrigine;
        trouveNom:=true;
        j:=trains[ntrains].RoutePref[0][0].adresse;
        inc(j);
        trains[ntrains].RoutePref[0][0].Adresse:=j;
        delete(s,1,1);
        i:=pos(']',s);
        trains[ntrains].nomRoute[j]:=copy(s,1,i-1);
        delete(s,1,i);
        //
        i:=pos(',',s);
        if i<>0 then
        begin
          // sens de la consigne de la route
          delete(s,1,1);
          sens:=s[1]='1';
          delete(s,1,1);
        end;
        i:=pos(',',s);
        id:=0;
        if i<>0 then
        begin
          // ID de route
          delete(s,1,1);
          val(s,id,erreur);
          delete(s,1,1);
        end;

        lit_ligne;
      end;

      if s[1]='{' then
      begin
        if not trouveNom then
        begin
          inc(trains[ntrains].RoutePref[0][0].adresse);  // si route sans nom, incr�meter l'index de route
        end;
        n:=trains[ntrains].RoutePref[0][0].adresse;
        trains[ntrains].routePref[n,0].talon:=sens;
        trains[ntrains].routePref[n,0].pos:=id;
        compile_route(s);
        lit_ligne;
        lire:=false;
      end;
    end;

  until (sOrigine='0') or (ntrains>=Max_Trains);

  if ntrains>1 then
    with Formprinc do
    begin
      ComboTrains.ItemIndex:=0;
      editadrtrain.Text:=inttostr(trains[1].adresse);
    end;
  end;

  procedure compile_periph;
  var i,erreur : integer;
  begin
    NbPeriph:=0;
    NbPeriph_COMUSB:=0;
    NbPeriph_socket:=0;
    repeat
      lit_ligne;
      if s<>'0' then
      begin
        inc(NbPeriph);
        sa:=sOrigine;
        i:=pos(',',sa);
        Tablo_periph[NbPeriph].nom:=copy(sa,1,i-1);
        delete(sa,1,i);
        val(sa,i,erreur);

        Tablo_periph[NbPeriph].ScvAig:=i=1;
        i:=pos(',',sa);Delete(sa,1,i);

        val(sa,i,erreur);
        Tablo_periph[NbPeriph].ScvDet:=i=1;

        i:=pos(',',sa);Delete(sa,1,i);
        val(sa,i,erreur);
        Tablo_periph[NbPeriph].ScvAct:=i=1;

        i:=pos(',',sa);Delete(sa,1,i);
        val(sa,i,erreur);
        Tablo_periph[NbPeriph].ScvVis:=i=1;

        i:=pos(',',sa);Delete(sa,1,i);
        val(sa,i,erreur);
        Tablo_periph[NbPeriph].cr:=i=1;

        // nouveaux champ dtr
        i:=pos(',',sa);Delete(sa,1,i);
        val(sa,i,erreur);

        // si pas de protocole
        if sa<>'' then
        begin
          if (i<2) and (upcase(sa[1])<>'C') then // adresse ip ou Com
          begin
            val(sa,i,erreur);
            Tablo_periph[NbPeriph].dtr:=i=1;
            i:=pos(',',sa);Delete(sa,1,i);

            val(sa,i,erreur);
            Tablo_periph[NbPeriph].rts:=i=1;
            i:=pos(',',sa);Delete(sa,1,i);
          end;

          Tablo_periph[NbPeriph].protocole:=uppercase(sa);
          i:=com_socket(NbPeriph);
          if i=1 then
          begin
            inc(NbPeriph_COMUSB);
            Tablo_periph[NbPeriph].numComposant:=NbPeriph_COMUSB;
          end;
          if i=2 then
          begin
            inc(NbPeriph_socket);
            Tablo_periph[NbPeriph].numComposant:=NbPeriph_socket;
          end;
          if i=0 then Affiche('Erreur 96 : le p�riph�rique '+Tablo_periph[NbPeriph].nom+' n''est pas reconnu comme COM/USB ou socket',clred);

          // extraire le num�ro de com5:9600,n,8,1
          i:=extract_int(sa);
          if i=0 then Affiche('Erreur 97 - Port COM nul : '+sOrigine,clred);
          Tablo_periph[NbPeriph].NumCom:=i;
        end;
      end;
    until (sOrigine='0') or (NbPeriph>=NbMaxi_Periph);
  end;

  procedure compile_actionneurs;
  begin
    Nactionneurs:=0;
    repeat
      lit_ligne;
      if s<>'0' then
      begin
        inc(Nactionneurs);
        val(s,i,erreur);
        actionneur[Nactionneurs].adresse:=i;
        delete(s,1,erreur);
        val(s,i,erreur);
        actionneur[Nactionneurs].prox1:=i;
        delete(s,1,erreur);
        val(s,i,erreur);
        actionneur[Nactionneurs].prox2:=i;
      end;
    until (sOrigine='0') or (s='');
    trier_actionneurs;
  end;

  procedure compile_detecteurs;
  begin
    repeat
      lit_ligne;
      if s<>'0' then
      begin
        val(s,j,erreur);
        delete(s,1,erreur);
        val(s,i,erreur);
        detecteur[j].longueur:=i;
        if erreur<>0 then
        begin
          delete(s,1,erreur);
          val(s,i,erreur);
          detecteur[j].ModeArret:=i;
        end;
        if erreur<>0 then
        begin
          delete(s,1,erreur);
          val(s,i,erreur);
          detecteur[j].distArret:=i;
        end;

      end;
    until (sOrigine='0') or (s='');
  end;

  procedure compile_fonctions;
  var posv,v,i,erreur : integer;
      ss : string;
      ligne : boolean;

  begin
    nbreFL:=0;
    idOperateur:=0;
    lit_ligne;
    repeat    // boucle des fonctions
      i:=pos('"',sOrigine);
      if i<>0 then delete(sOrigine,i,1);      // supprime les guillemets
      i:=pos('"',sOrigine);
      if i<>0 then delete(sOrigine,i,1);
      i:=0;
      NomFonction[NbreFL+1]:=sOrigine;
      lit_ligne;
      ligne:=false;
      repeat  // boucle de la fonction
        if (s<>'0') and (s<>'') then
        begin
          posv:=pos(',',s);
          // 0,Variables,N0,T0
          ss:=copy(s,1,posv-1);  // indice , non compil�
          delete(s,1,posv);

          posv:=pos(',',s);
          ss:=copy(s,1,posv-1);  // texte du type , non compil�
          delete(s,1,posv);

          Delete(s,1,1);         // supprime N
          val(s,v,erreur);
          Fonction[NbreFL+1,i].niveau:=v;
          Delete(s,1,erreur);

          Delete(s,1,1);        // supprime T
          val(s,v,erreur);
          delete(s,1,erreur);
          erreur:=CompareValue(versR,9.7,0.01);
          if (erreur=LessThanValue) or (erreur=EqualsValue) then
          begin
            if (v>=4) then inc(v);
          end;
          Fonction[NbreFL+1,i].typ:=v;
          inc(idOperateur);
          ArbreFonc[idOperateur,0]:=i;

          Delete(s,1,1);        // supprime A
          val(s,v,erreur);
          delete(s,1,erreur);
          Fonction[NbreFL+1,i].adresse:=v;

          Delete(s,1,1);        // supprime E
          val(s,v,erreur);
          delete(s,1,erreur);
          Fonction[NbreFL+1,i].etat:=v;

          j:=pos('V,',s);
          if j<>0 then delete(s,1,2);
          j:=pos(',',s);
          Fonction[NbreFL+1,i].train:=copy(s,1,j-1);
          if j<>0 then delete(s,1,j);

          j:=pos('O',s);
          if j<>0 then
          begin
            delete(s,1,1);
            val(s,v,erreur);
            Fonction[NbreFL+1,i].OpMemoire:=v;
          end;

          inc(i);
          lit_ligne;
          ligne:=true;
        end;
      until (s='FF') or (s='0') or (s='');  // fin de fonction
      c:='Z';
      if s='FF' then
      repeat
        readln(fichier,s);
        sOrigine:=s;
        if length(s)>0 then c:=s[1];
      until (c<>'/') or (s='') or eof(fichier) ;

     if ligne then inc(nbreFL);
    until (s='0') or (s='') ;  // fin des fonctions
  end;

  procedure compile_blocsUSB;
  var n,id,i : integer;
      ss : string;
  begin
    n:=0;
    repeat
      lit_ligne;
      if s<>'0' then
      begin
        s:=sOrigine;
        delete(s,1,1);
        val(s,i,erreur);  // i=num�ro de bloc usb de 1 � 10
        if i>10 then i:=10;
        delete(s,1,erreur);
        j:=pos(',',s);
        ss:=copy(s,1,j-1);
        blocUSB[i].AffTrain:=ss;delete(s,1,j);
        id:=index_train_nom(ss);
        trains[id].BlocUSB:=i;

        delete(s,1,2); // supprime BR
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].rotatifM:=j;
        val(s,j,erreur);delete(s,1,erreur);          //   B1,Pas d'affectation,BR45,43,224,4,B38,1,1,B233,2,0,B34,3,0,B39,4,0,B5,0,0,B6,0,0,B7,0,0,B8,0,0,B9,0,0,B10,0,0
        blocUsb[i].rotatifP:=j;             //107
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].clic:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].increment:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp1:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp1:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp1:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp2:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp2:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp2:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp3:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp3:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp3:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp4:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp4:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp4:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp5:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp5:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp5:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp6:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp6:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp6:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp7:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp7:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp7:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp8:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp8:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp8:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp9:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp9:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp9:=j;

        delete(s,1,1); // supprime B
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Bp10:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fbp10:=j;
        val(s,j,erreur);delete(s,1,erreur);
        blocUsb[i].Fnp10:=j;

        inc(n);
      end;
    until (sOrigine='0') or (s='') or (n>=10);
  end;

  procedure compile_compteurs;
  var n,i : integer;
  begin
    n:=1;
    repeat
      lit_ligne;
      if s<>'0' then
      begin
        lit_ligne;
        i:=pos('=',s);
        delete(s,1,i);
        val('$'+s,j,erreur);
        ParamCompteur[n].coulAig:=j;

        lit_ligne;
        i:=pos('=',s);
        delete(s,1,i);
        val('$'+s,j,erreur);
        ParamCompteur[n].coulGrad:=j;

        lit_ligne;
        i:=pos('=',s);
        delete(s,1,i);
        val('$'+s,j,erreur);
        ParamCompteur[n].CoulNum:=j;

        lit_ligne;
        i:=pos('=',s);
        delete(s,1,i);
        val('$'+s,j,erreur);
        ParamCompteur[n].coulFond:=j;

        lit_ligne;
        i:=pos('=',s);
        delete(s,1,i);
        val('$'+s,j,erreur);
        ParamCompteur[n].coulArc:=j;
      end;
      inc(n);
    until (sOrigine='0') or (s='') or (n>=10);
  end;


  procedure compile_horloge;
  begin
    repeat
      lit_ligne;
      if s<>'0' then
      begin
        sa:=uppercase(horlogeInterne_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          horlogeInterne:=s[1]='1';
        end;

        sa:=uppercase(LanceHorl_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          LanceHorl:=s[1]='1';
        end;

        sa:=uppercase(AffHorl_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          AffHorl:=s[1]='1';
        end;

        sa:=uppercase(relanceHorl_init_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          relanceHorl_init:=s[1]='1';
        end;

        sa:=uppercase(RetourHeure_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          val(s,RetourHeure,erreur);
        end;

        sa:=uppercase(RetourMinute_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          val(s,RetourMinute,erreur);
        end;

        sa:=uppercase(HeureInit_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          val(s,HeureInit,erreur);
        end;

        sa:=uppercase(MinuteInit_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          val(s,MinuteInit,erreur);
        end;

        sa:=uppercase(DureeMinute_ch);
        i:=pos(sa,s);
        if i=1 then
        begin
          inc(nv);
          delete(s,i,length(sa)+1);
          val(s,DureeMinute,erreur);
        end;

      end;
    until (sOrigine='0') or (s='');
  end;


  procedure lit_flux;
  label ici1,ici2,ici3,ici4 ;
  var i : integer;

  begin
    // valeurs par d�faut
    Nb_cantons_Sig:=3;
    nv:=0; it:=0;
    repeat
      s:=lit_ligne;

      sa:=uppercase(debug_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,debug,erreur);
      end;

      sa:=uppercase(sombre_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,i,erreur);
        Modesombre:=i=1;
      end;

      sa:=uppercase(couleur_fond_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val('$'+s,CouleurFond,erreur);
      end;

      sa:=uppercase(serveurIPCDM_Touche_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,i,erreur);
        serveurIPCDM_Touche:=i=1;
      end;

      sa:=uppercase(PortServeur_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,portServeur,erreur);
        if (portServeur<1) or (portServeur>65535) then
        begin
          Affiche('Erreur port serveur : '+intToSTR(portServeur),clred);
        portServeur:=5000;
        end;
      end;

      sa:=uppercase(Verif_AdrXpressNet_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,Verif_AdrXpressNet,erreur);
      end;

      sa:=uppercase(Nom_fich_TCO_ch);
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,1,length(sa));
        i:=extract_int(s);
        j:=pos('=',s);
        delete(s,1,j);
        if (i>0) and (i<11) then NomfichierTCO[i]:=s;
      end;

      sa:=uppercase(CheminProgCDM_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(sOrigine,1,length(sa));
        cheminProgrammesCDM:=sOrigine;
      end;

      sa:=uppercase(LargeurF_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,LargeurF,erreur);
      end;

      sa:=uppercase(HauteurF_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,HauteurF,erreur);
      end;

      sa:=uppercase(OffsetXF_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,OffsetXF,erreur);
      end;

      sa:=uppercase(OffsetYF_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,OffsetYF,erreur);
      end;

      sa:=uppercase(LargeurFC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,LargeurFC,erreur);
      end;

      sa:=uppercase(HauteurFC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,HauteurFC,erreur);
      end;

      sa:=uppercase(OffsetXFC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,OffsetXFC,erreur);
      end;

      sa:=uppercase(OffsetYFC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,OffsetYFC,erreur);
      end;


      sa:=uppercase(PosSplitter_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,PosSplitter,erreur);
      end;

      sa:=uppercase(Filtrage_det_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,filtrageDet0,erreur);
      end;

      sa:=uppercase(nCantons_Res_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        if (i<1) or (i>5) then i:=2;
        val(s,nCantonsRes,erreur);
      end;

      sa:=uppercase(AntiTimeoutEthLenz_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,AntiTimeoutEthLenz,erreur);
      end;

      sa:=uppercase(TempoTC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,tempoTC,erreur);
      end;

      sa:=uppercase(Algo_localisation_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        val(s,Algo_localisation,erreur);
        if Algo_localisation<>1 then Affiche('Avertissement: Algo_localisation='+intToSTR(algo_localisation)+' est exp�rimental et non garanti',clorange);
      end;

      sa:=uppercase(MaxSignalSens_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(s,i,length(sa));
        if (i<0) or (i>50) then i:=5;
        val(s,Max_Signal_Sens,erreur);
      end;

      sa:=uppercase(Style_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        delete(sOrigine,i,length(sa));
        val(sOrigine,i,erreur);
        if erreur=0 then sOrigine:='Windows';
        Nom_style_aff:=sOrigine;
      end;

      sa:=uppercase(Fonte_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_fonte:=true;
        delete(s,i,length(sa));
        val(s,TailleFonte,erreur);
        if (TailleFonte<8) or (tailleFonte>25) then taillefonte:=10;
        with FormPrinc.FenRich do
        begin
          //clear;
          Font.Size:=TailleFonte;
        end;
      end;

      sa:=uppercase(Protocole_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_protocole:=true;
        delete(s,i,length(sa));
        val(s,Protocole,erreur);
        if (Protocole<1) or (Protocole>2) then Protocole:=1;  //1=xpressnet 2=DCC+
      end;

      // adresse ip et port de CDM
      sa:=uppercase(IpV4_PC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_ipv4_PC:=true;
        delete(s,i,length(sa));
        i:=pos(':',s);
        if i<>0 then
        begin
          adresseIPCDM:=copy(s,1,i-1);Delete(s,1,i);
          val(s,portCDM,erreur);
          if (portCDM=0) or (portCDM>65535) or (erreur<>0) then affiche('Erreur port CDM : '+s,clred);
        end
        else affiche('Erreur adresse ip cdm rail '+s,clred);
      end;

      // Services CDM
      sa:=uppercase(ServicesCDM_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        Srvc_aig:=testbit(i,0);
        Srvc_act:=testbit(i,1);
        Srvc_det:=testbit(i,2);
        Srvc_pos:=testbit(i,3);
        Srvc_sig:=testbit(i,4);
        Srvc_tspd:=testbit(i,5);
      end;

      // adresse ip et port de la centrale
      sa:=uppercase(IPV4_INTERFACE_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_IPV4_INTERFACE:=true;
        delete(s,i,length(sa));
        i:=pos(':',s);
        if i<>0 then
        begin
          adresseIP:=copy(s,1,i-1);Delete(s,1,i);portInterface:=StrToINT(s);
          if (adresseIP<>'0') and (portInterface=0) then affiche('Erreur port nul : '+sOrigine,clRed);
        end
        else begin adresseIP:='0';parSocketLenz:=false;end;
      end;

      // configuration du port com interface
      sa:=uppercase(PROTOCOLE_SERIE_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_PROTOCOLE_SERIE:=true;
        delete(s,i,length(sa));
        if not(config_com(s)) then Affiche('Erreur port com mal d�clar� : '+s,clred);
        if (NumPort>MaxPortCom) then Affiche('Le port com est sup�rieur au nombre de COMx � explorer dans le fichier de configuraion',clred);
        portcom:=s;
      end;

      // temporisation entre 2 caract�res
      sa:=uppercase(INTER_CAR_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        trouve_INTER_CAR:=true;
        val(s,TempoOctet,erreur);
        if erreur<>0 then Affiche('Erreur temporisation entre 2 octets',clred);
      end;

      // temporisation attente maximale interface
      sa:=uppercase(TEMPO_MAXI_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        trouve_Tempo_maxi:=true;
        val(s,TimoutMaxInterface,erreur);
        if erreur<>0 then Affiche('Erreur temporisation maximale interface',clred);
      end;

      // entete
      sa:=uppercase(ENTETE_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        trouve_Entete:=true;
        val(s,Valeur_entete,erreur);
        entete:='';suffixe:='';
        if Valeur_entete=1 then begin entete:=#$FF+#$FE;suffixe:='';end;
        if (erreur<>0) or (valeur_entete>1) then Affiche('Erreur d�claration '+entete_ch,clred);
      end;

      // avec ou sans initialisation des aiguillages
      sa:=uppercase(INIT_AIG_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        trouve_init_aig:=true;
        inc(nv);
        delete(s,i,length(sa));
        AvecInitAiguillages:=s='1';
      end;

      // avec ou sans initialisation des aiguillages
      sa:=uppercase(PilotageTrainsCDM_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        PilotageTrainsCDMNom:=s='1';
      end;

      sa:=uppercase(debugRoulage_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        debugRoulage:=s='1';
      end;

      sa:=uppercase(AffLoc_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        AffLoc:=s='1';
      end;

      // avec demande de position des aiguillages en mode autonome au d�marrage
      sa:=uppercase(Init_dem_aig_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        trouve_dem_aig:=true;
        inc(nv);
        delete(s,i,length(sa));
        AvecDemandeAiguillages:=s='1';
      end;

      // avec demande de connexion en COM USB au d�marrage
      sa:=uppercase(Init_dem_interfaceUSBCOM_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        trouve_demcnxCOMUSB:=true;
        inc(nv);
        delete(s,i,length(sa));
        AvecDemandeInterfaceUSB:=s='1';
      end;

      // avec demande de connexion en ethernet au d�marrage
      sa:=uppercase(Init_dem_interfaceEth_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        trouve_demcnxEth:=true;
        inc(nv);
        delete(s,i,length(sa));
        AvecDemandeInterfaceEth:=s='1';
      end;

      // taille de la fenetre
      sa:=uppercase(fenetre_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_fenetre:=true;
        delete(s,i,length(sa));
        val(s,fenetre,erreur);
      end;

      // m�mo fenetre
      sa:=uppercase(AffMemoFenetre_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,AffMemoFenetre,erreur);
      end;

      // Nombre de cantons avant signal
      sa:=uppercase(Nb_cantons_Sig_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_Nb_cantons_Sig:=true;
        delete(s,i,length(sa));
        val(s,Nb_cantons_Sig,erreur);
        if (Nb_cantons_Sig<3) or (Nb_cantons_Sig>5) then Nb_cantons_Sig:=3;
      end;

      sa:=uppercase(cbAffSig_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        AffSig:=s='1';
      end;

      sa:=uppercase(cbRes_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        AffRes:=s='1';
      end;

      sa:=uppercase(cback_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        AvecAck:=s='1';
      end;

      sa:=uppercase(ModeTache_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        ModeTache:=s='1';
      end;

      sa:=uppercase(option_demitour_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        Option_demitour:=s='1';
      end;

      // temporisation aiguillages
      sa:=uppercase(Tempo_Aig_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_Tempo_aig:=true;
        delete(s,i,length(sa));
        val(s,Tempo_Aig,erreur);
      end;

      sa:=uppercase(compteur_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,compteur,erreur);
      end;

      sa:=uppercase(LargCompteur_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,LargeurCompteurs,erreur);
      end;

      sa:=uppercase(LargComptC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,LargComptC,erreur);
      end;

      sa:=uppercase(HautComptC_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,HautComptC,erreur);
      end;

      sa:=uppercase(AffCompteur_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        AffCompteur:=i=1;
      end;

      sa:=uppercase(VerrouCompteur_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        VerrouilleCompteur:=i=1;
      end;

      sa:=uppercase(Echelle_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        Echelle:=i;
      end;

      sa:=uppercase(AffIconeTrCompteur_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        AffTrainCompteur:=i=1;
      end;

      sa:=uppercase(Onglet_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        Onglet:=i;
      end;

      sa:=uppercase(MaxParcours_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_Tempo_aig:=true;
        delete(s,i,length(sa));
        val(s,MaxParcours,erreur);
        if MaxParcours<50 then MaxParcours:=50;
        if MaxParcours>MaxParcoursTablo then maxParcours:=MaxParcoursTablo;
      end;

      sa:=uppercase(MaxRoutes_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_Tempo_aig:=true;
        delete(s,i,length(sa));
        val(s,MaxRoutes,erreur);
        if MaxRoutes<5000 then MaxRoutes:=5000;
        if MaxRoutes>MaxRoutesCte then maxRoutes:=MaxRoutesCte;
      end;

      // temporisation d�codeurs de signal
      sa:=uppercase(Tempo_Signal_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_Tempo_signal:=true;
        delete(s,i,length(sa));
        val(s,Tempo_Signal,erreur);
        if Tempo_Signal=0 then Tempo_Signal:=100;
      end;

      // algo unisemaf
      sa:=uppercase(Algo_unisemaf_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_Algo_Uni:=true;
        delete(s,i,length(sa));
        val(s,algo_Unisemaf,erreur);
        if (algo_Unisemaf<0) or (algo_Unisemaf>2) then algo_Unisemaf:=1;
      end;

      sa:=uppercase(verif_version_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        trouve_verif_version:=true;
        inc(nv);
        delete(s,i,length(sa));
        // v�rification de la version au d�marrage
        verifVersion:=true;
        val(s,i,erreur);
        if erreur=0 then verifVersion:=i=1;
      end;

      sa:=uppercase(NOTIF_VERSION_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        trouve_NOTIF_VERSION:=true;
        // v�rification de la version au d�marrage
        val(s,i,erreur);
        notificationVersion:=i=1;
      end;

      sa:=uppercase(AvecVerifIconesTCO_ch);
      i:=pos(sa,s);
      if i<>0 then
      begin
        trouveAvecVerifIconesTCO:=true;
        inc(nv);
        delete(s,i,length(sa)+1);
        val(s,AvecVerifIconesTCO,erreur);
        AvecVerifIconesTCO:=0;  // forc� � 0
        s:='';
      end;

      sa:=uppercase(TCO_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        trouve_TCO:=true;
        val(s,i,erreur);
        AvecTCO:=i=1;
      end;

      sa:=uppercase(Nb_TCO_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        if (i<0) or (i>10) then i:=1;
        NbreTCO:=i;
      end;

      sa:=uppercase(MasqueBandeauTCO_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        trouve_MasqueTCO:=true;
        val(s,i,erreur);
        MasqueBandeauTCO:=i=1;
      end;

      sa:=uppercase(CDM_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_CDM:=true;
        delete(s,i,length(sa));
        val(s,i,erreur);
        LanceCDM:=i=1;
      end;

      sa:=uppercase(LAY_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_lay:=true;
        delete(s,i,length(sa));
        lay:=s;
      end;

      sa:=uppercase(NomModuleCDM_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        NomModuleCDM:=s;
      end;

      sa:=uppercase(SERVEUR_INTERFACE_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_serveur_interface:=true;
        delete(s,i,length(sa));
        val(s,i,erreur);
        ServeurInterfaceCDM:=i;
      end;

      sa:=uppercase(RETRO_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_retro:=true;
        delete(s,i,length(sa));
        val(s,i,erreur);
        ServeurRetroCDM:=i;
      end;

      sa:=uppercase(ecran_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        if i<1 then i:=1;
        Ecran_SC:=i;
      end;

      sa:=uppercase(Z21_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        Z21:=i=1;
      end;

      sa:=uppercase(nb_det_dist_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_NbDetDist:=true;
        delete(s,i,length(sa));
        val(s,i,erreur);
        if i<2 then begin i:=2;Affiche('Attention '+nb_det_dist_ch+' ramen� � '+IntToSTR(i),clOrange); end;
        Nb_Det_Dist:=i;
      end;

      sa:=uppercase(Raz_signaux_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        trouve_NbDetDist:=true;
        delete(s,i,length(sa));
        val(s,i,erreur);
        if i>1 then i:=1;
        Raz_Acc_signaux:=i=1;
      end;

      sa:=uppercase(AffAigND_ch)+'=';
      i:=pos(sa,s);
      if i=1 then
      begin
        inc(nv);
        delete(s,i,length(sa));
        val(s,i,erreur);
        if i>1 then i:=1;
        AffAigND:=i=1;
      end;

      // section aiguillages
      sa:=uppercase(section_aig_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_aig:=true;
        compile_aiguillages;
        trier_aig;
      end ;

      // section branche
      sa:=uppercase(section_branches_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_branche:=true;
        compile_branches;
        trier_detecteurs;
      end;

      // section signaux
      sa:=uppercase(section_sig_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_sig:=true;
        compile_signaux;
        trier_signaux;
      end;

      // section anciens actionneurs
      sa:=uppercase(section_act_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_act:=true;
        compile_anciens_actionneurs;
      end;

      // section PN
      sa:=uppercase(section_PN_ch);
      if pos(sa,s)<>0 then
      begin
        compile_PN;
      end;

      // section actionneurs
      sa:=uppercase(section_actV2_ch);
      if pos(sa,s)<>0 then
      begin
        compile_actions;
      end;

      // section dcc++
      sa:=uppercase(section_dccpp_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_dccpp:=true;
        compile_dccpp;
      end;

      // section trains
      sa:=uppercase(section_trains_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_trains:=true;
        compile_trains;
        trier_trains;
      end;

      // section d�dodeurs
      sa:=uppercase(section_DecPers_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_dec_pers:=true;
        compile_dec_pers;
      end;

      // section placement : mis dans les trains
      // "train",num�ro du canton,sens,pilotage inverse (inutile)
      sa:=uppercase(section_placement_ch);
      if pos(sa,s)<>0 then
      begin
        i:=1;
        repeat
          lit_ligne;
          s:=sOrigine;
          if s<>'0' then
          begin
            j:=pos(',',s);
            if j<>0 then
            begin
              // train
              train:=copy(s,1,j-1);
              idtrain:=index_train_nom(train);
              delete(s,1,j);
              // num�ro de canton (pas index)
              val(s,j,erreur);
              trains[idtrain].canton:=j;
              j:=pos(',',s);
              if j<>0 then
              begin
                // sens
                delete(s,1,j);
                val(s,j,erreur);
                trains[idtrain].sens:=j;
                // inverse, mais ne pas stocker, d�ja lu dans compile_trains
                j:=pos(',',s);
                if j<>0 then
                begin
                  delete(s,1,j);
                  val(s,j,erreur);
                end;
              end;
            end;
            inc(i);
            s:='';
          end;
        until (s='0') or eof(fichier);
      end;

      // section accesoires comusb
      sa:=uppercase(section_accCOM_ch);
      if pos(sa,s)<>0 then
      begin
        trouve_section_acccomusb:=true;
        compile_periph;
      end;

      // section horloge
      sa:=uppercase(section_horloge_ch);
      if pos(sa,s)<>0 then
      begin
        compile_horloge;
      end;

      // section actionneurs CDM
      sa:=uppercase(section_actionneurs_ch);
      if pos(sa,s)<>0 then
      begin
        compile_actionneurs;
      end;

      // section detecteurs
      sa:=uppercase(section_detecteurs_ch);
      if pos(sa,s)<>0 then
      begin
        compile_detecteurs;
      end;

      // section fonctions
      sa:=uppercase(section_logique_ch);
      if pos(sa,s)<>0 then
      begin
        compile_fonctions;
      end;

      sa:=uppercase(section_blocs_USB_ch);
      if pos(sa,s)<>0 then
      begin
        compile_blocsUSB;
      end;

      sa:=uppercase(section_compteurs_ch);
      if pos(sa,s)<>0 then
      begin
        compile_compteurs;
      end;

      inc(it);

    until (eof(fichier));

    end;  // fin de lit_flux

// d�but de la proc�dure lit_config
begin
  debugConfig:=false;
  trouve_NbDetDist:=false;
  trouveAvecVerifIconesTCO:=false;
  trouve_ipv4_PC:=false;
  trouve_retro:=false;
  trouve_sec_init:=false;
  trouve_section_acccomusb:=false;
  trouve_init_aig:=false;
  trouve_dem_aig:=false;
  trouve_tempo_aig:=false;
  trouve_tempo_signal:=false;
  trouve_INTER_CAR:=false;
  trouve_entete:=false;
  trouve_IPV4_INTERFACE:=false;
  trouve_Tempo_maxi:=false;
  trouve_PROTOCOLE_SERIE:=false;
  trouve_TCO:=false;
  trouve_LAY:=false;
  trouve_Serveur_interface:=false;
  trouve_cdm:=false;
  trouve_NOTIF_VERSION:=false;
  trouve_masqueTCO:=false;
  trouve_fenetre:=false;
  trouve_verif_version:=false;
  trouve_Fonte:=false;
  trouve_Raz:=false;
  trouve_demcnxCOMUSB:=false;
  trouve_demcnxEth:=false;
  trouve_Algo_Uni:=false;
  trouve_Nb_cantons_Sig:=false;
  AvecVerifIconesTCO:=1;
  NomfichierTCO[1]:='tco.cfg';  // pour compatibilit� anciennes versions
  for i:=2 to 10 do
  begin
    NomfichierTCO[i]:='tco'+intToSTR(i)+'.cfg';
  end;

  //trouve_FVR:=false;

  if not(trouve_tempo_signal) then
  begin
    s:=tempo_signal_ch;
    Tempo_Signal:=100;
    s:='';
  end;
  if not(trouve_NOTIF_VERSION) then s:=NOTIF_VERSION_ch;
  if not(trouve_verif_version) then s:=verif_version_ch;
  if not(trouve_fonte) then s:=fonte_ch;

  Nb_Det_Dist:=3;
  // initialisation des aiguillages avec des valeurs par d�faut
  for i:=1 to NbreMaxiAiguillages do
  begin
    Aiguillage[i].modele:=rien  ;  //  sans existence
    Aiguillage[i].adresse:=0;
    Aiguillage[i].adrTrain:=0;
    Aiguillage[i].position:=const_inconnu;  // position inconnue
    Aiguillage[i].PosInit:=const_inconnu;  // position inconnue
    Aiguillage[i].temps:=5;
    Aiguillage[i].inversionCDM:=0;
    Aiguillage[i].EtatTJD:=4;
    Aiguillage[i].vitesse:=0;
  end;
  for i:=1 to NbMaxDet do
  begin
    Detecteur[i].etat:=false;
    Detecteur[i].train:='';
    Detecteur[i].AdrTrain:=0;
    Detecteur[i].tempo0:=0;
    Detecteur[i].IndexTrainRoulant:=0;
    Ancien_detecteur[i]:=false;
  end;

  GetDir(0,s);
  Affiche('Lecture du fichier de configuration du r�pertoire',clYellow);
  Affiche(s,clyellow);

  try
    assignFile(fichier,NomConfig);
    reset(fichier);
  except
    Affiche('Fichier '+NomConfig+' non trouv� : cr�ation d''un fichier vide par d�faut',clred);
    portcom:='COMX:57600,N,8,1,2';
    adresseIPCDM:='127.0.0.1';portCDM:=9999;
    adresseIP:='192.168.1.23';portInterface:=5550;
    verifVersion:=true;
    Valeur_entete:=1;
    TempoOctet:=50;
    Ecran_sc:=1;
    Srvc_Aig:=true;
    Srvc_Act:=true;
    Srvc_Det:=true;
    Srvc_Pos:=true;
    Srvc_Sig:=false;
    Srvc_tspd:=false;
    TimoutMaxInterface:=7;
    AvecInitAiguillages:=false;
    PilotageTrainsCDMNom:=true;
    AvecDemandeInterfaceUSB:=false;
    AvecDemandeInterfaceEth:=false;
    AffSig:=true;
    AffRes:=true;
    AvecAck:=false;
    lay:='';
    Tempo_Aig:=100;
    Tempo_Signal:=100;
    ServeurInterfaceCDM:=1;
    Nb_cantons_Sig:=3;
    ServeurRetroCDM:=1;
    algo_Unisemaf:=1;
    TailleFonte:=10;
    Nb_Det_Dist:=3;
    genere_config;
    assignFile(fichier,NomConfig);
    reset(fichier);
  end;
  readln(fichier,s);
  // trouver la version avec laquelle le fichier de config a �t� cr��
  versR:=0;
  i:=pos('version',s);
  if i<>0 then
  begin
    delete(s,1,i+7);
    versR:=STRtoFloat(s,FormatSettings) ;
  end else
  begin
    versR:=0;
    Affiche('Version fichier de configuration inconnue',clred);
  end;
  versR:=roundTo(versR,-2);
  lit_flux;
  close(fichier);

  if modeTache then
  begin
    avecAckCDM:=false;
    avecAck:=false;
  end;
  configNulle:=(maxAiguillage=0) and (NbreBranches=0) and (NbreSignaux=0);
  if configNulle then Affiche('Fonctionnement en config nulle',ClYellow);

  s:='';//Affiche(intToSTR(Nv),clred);
  if not(trouve_NbDetDist) then s:=nb_det_dist_ch;
  if not(trouve_ipv4_PC) then s:=IpV4_PC_ch;
  if not(trouve_retro) then s:=retro_ch;
  if not(trouve_init_aig) then s:=INIT_AIG_ch;
  if not(trouve_INTER_CAR) then s:=INTER_CAR_ch;
  if not(trouve_Tempo_maxi) then s:=Tempo_maxi_ch;
  if not(trouve_Entete) then s:=Entete_ch;
  if not(trouve_LAY) then s:=s+LAY_ch;
  if not(trouve_TCO) then s:=TCO_ch;
  if not(trouve_CDM) then s:=CDM_ch;
  if not(trouve_Serveur_interface) then s:=Serveur_interface_ch;
  if not(trouve_fenetre) then s:=fenetre_ch;
  if not(trouve_tempo_aig) then s:=tempo_aig_ch;
  if not(trouve_Algo_Uni) then s:=Algo_unisemaf_ch;
  if not(trouve_Nb_cantons_Sig) then s:=Nb_cantons_Sig_ch;
  if not(trouve_dem_aig) then s:=Init_dem_aig_ch;
  if not(trouve_demcnxCOMUSB) then s:=Init_dem_interfaceUSBCOM_ch;
  if not(trouve_demcnxEth) then s:=Init_dem_interfaceEth_ch;
  if not(trouveAvecVerifIconesTCO) then confasauver:=true;

  if not(trouve_tempo_signal) then
  begin
    s:=tempo_signal_ch;
    Tempo_Signal:=100;
    s:='';
  end;
  if not(trouve_NOTIF_VERSION) then s:=NOTIF_VERSION_ch;
  if not(trouve_verif_version) then s:=verif_version_ch;
  if not(trouve_fonte) then s:=fonte_ch;

  if s<>'' then
  begin
    affiche('Manque variable(s) dans '+NomConfig+' : '+s,clOrange);
    Affiche('Elles seront r�g�n�r�es automatiquement',clOrange);
    confasauver:=true;
  end;
  if not(trouve_section_aig) then Affiche('Manque section '+section_aig_ch,clred);
  if not(trouve_section_sig) then Affiche('Manque section '+section_sig_ch,clred);
  if not(trouve_section_branche) then Affiche('Manque section '+section_branches_ch,clred);

  genere_informations_BD;

  {$IF CompilerVersion >= 28.0}
  Modesombre:=false;
  {$IFEND}
end;


// sauvegarder la config dans le fichier cfg
function Sauve_config : boolean;
begin
  // g�n�rer le fichier de config
  genere_config;
  Affiche('Configuration sauvegard�e',clLime);
  config_modifie:=false;
  confasauver:=false;
  sauve_config:=true;
  exit;
end;

function verifie_panneau_config : boolean;
var ChangeCDM,changeInterface,changeUSB,change_srv,ok : boolean;
    i,erreur : integer;
    s : string;
begin
  ok:=true;
  // V�rification de la configuration-------------------------------------------
  // contr�le adresse IP CDM
  with FormConfig do
  begin
    s:=EditAdrIPCDM.text;
    if s='' then s:='127.0.0.1';
    if not(IpOk(s)) then begin labelInfo.Caption:='Adresse IP CDM rail incorrecte';ok:=false;end;
    ChangeCDM:=s<>AdresseIPCDM;
    adresseIPCDM:=s;

    // contr�le port CDM
    val(EditPortCDM.Text,i,erreur);
    if i=0 then i:=9999;
    if (i>65535) or (i<0) then begin labelInfo.Caption:='Port CDM rail incorrect';ok:=false;end;
    changeCDM:=(portCDM<>i) or ChangeCDM;
    portCDM:=i;

    // taille fonte
    val(EditFonte.text,i,erreur);
    if (i<8) or (i>25) then i:=10;
    TailleFonte:=i;

    val(EditDebug.text,i,erreur);
    if (i<0) or (i>3) then i:=0;
    Debug:=i;

    if CheckBoxVerifXpressNet.checked then Verif_AdrXpressNet:=1 else Verif_AdrXpressNet:=0;

    Val(EditPortServeur.Text,i,erreur);
    if (i<1) or (i>65535) then i:=4500;
    portServeur:=i;

    // contr�le adresse IP interface
    s:=EditIPLenz.text;
    if s='' then s:='0';
    if not(IpOk(s)) and (s<>'0') then begin labelInfo.Caption:='Adresse IP interface Xpressnet incorrecte';ok:=false;end;
    changeInterface:=s<>AdresseIP;
    AdresseIP:=s;

    // contr�le port interface
    val(EditPortLenz.Text,i,erreur);
    if i=0 then i:=5550;
    if i>65535 then begin labelInfo.Caption:='Port Interface incorrect';ok:=false;end;
    changeInterface:=changeInterface or (i<>portinterface);
    portInterface:=i;

    Val(editTempoAig.Text,i,erreur);
    if i>3000 then begin labelInfo.Caption:='Temporisation de s�quencement incorrecte ';ok:=false;end;
    Tempo_Aig:=i;

    // contr�le protocole interface  COM3:57600,N,8,1,2
    s:=EditComUSB.Text;
    if s='' then s:='COM3:57600,N,8,1,2';
    if not(config_com(s)) then begin labelInfo.Caption:='Protocole s�rie USB Interface incorrect';ok:=false;end;
    changeUSB:=portcom<>s;
    portcom:=s;

    val(EditTempoOctetUSB.text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation octet incorrecte';ok:=false;end;
    TempoOctet:=i;

    val(EditOuvreEcran.Text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur �cran incorrecte';ok:=false;end;
    ecran_sc:=i;

    val(EditTempoReponse.text,i,erreur);
    if erreur<>0 then begin labelInfo.Caption:='Valeur temporisation de r�ponse interface';ok:=false;end;
    TimoutMaxInterface:=i;

    if RadioButton1.checked then Valeur_entete:=0;
    if RadioButton2.checked then Valeur_entete:=1;
    case Valeur_entete of
     0 : begin entete:='';suffixe:='';end;
     1 : begin entete:=#$FF+#$FE;suffixe:='';end;
    end;

    if changeCDM then connecte_CDM;
    if changeInterface then
    begin
      if (AdresseIP<>'0') and (adresseIP<>'') then
      begin
        connecte_interface_ethernet;
      end
    end;

    if changeUSB then
    begin
      deconnecte_USB;
      connecte_USB;
    end;

    verifVersion:=CheckVerifVersion.Checked;
    notificationVersion:=CheckInfoVersion.Checked;

    LanceCDM:=CheckLanceCDM.Checked;
    if CheckFenEt.checked then fenetre:=1 else fenetre:=0;
    if CheckBoxAffMemo.checked then AffMemoFenetre:=1 else AffMemoFenetre:=0;

    AvecTCO:=CheckAvecTCO.checked;
    MasqueBandeauTCO:=CheckBandeauTCO.checked;
    lay:=editLay.Text;
    if RadioButtonSS.Checked then ServeurInterfaceCDM:=0;
    if RadioButtonXn.Checked then ServeurInterfaceCDM:=1;
    if RadioButtonp50.Checked then ServeurInterfaceCDM:=2;
    if RadioButtonSP.Checked then ServeurInterfaceCDM:=3;
    if RadioButtonHSI.Checked then ServeurInterfaceCDM:=4;
    if RadioButtonDSI2.Checked then ServeurInterfaceCDM:=5;
    if RadioButtonFIS88.Checked then ServeurInterfaceCDM:=6;
    if RadioButtonDCCpp.Checked then ServeurInterfaceCDM:=7;
    if RadioButtonEcos.Checked then ServeurInterfaceCDM:=8;
    if RadioButton13.Checked then ServeurRetroCDM:=1;
    if RadioButton14.Checked then ServeurRetroCDM:=2;
    if RadioButton15.Checked then ServeurRetroCDM:=3;
    if RadioButton16.Checked then ServeurRetroCDM:=4;
    if RadioButton17.Checked then ServeurRetroCDM:=5;
    if RadioButton18.Checked then ServeurRetroCDM:=6;
    Z21:=CheckBoxZ21.Checked;

    // changement sur les services CDM
    change_srv:=Srvc_Aig<>CheckBoxServAig.checked;
    change_srv:=Srvc_Det<>CheckBoxServDet.checked or change_srv;
    change_srv:=Srvc_Act<>CheckBoxServAct.checked or change_srv;
    change_srv:=Srvc_Pos<>CheckServPosTrains.checked or change_srv;
    change_srv:=Srvc_Sig<>CheckBoxSrvSig.checked or change_srv;
    change_srv:=Srvc_tspd<>CheckBoxSrvTdcc.checked or change_srv;

    Srvc_Aig:=CheckBoxServAig.checked;
    Srvc_Det:=CheckBoxServDet.checked;
    Srvc_Act:=CheckBoxServAct.checked;
    Srvc_Pos:=CheckServPosTrains.checked;
    Srvc_Sig:=CheckBoxSrvSig.checked;
    Srvc_tspd:=CheckBoxSrvTdcc.checked;

    Raz_Acc_signaux:=CheckBoxRazSignaux.checked;
    AffAigND:=CheckBoxMsgAigInc.checked;
    AvecInitAiguillages:=CheckBoxInitAig.Checked;
    AvecDemandeAiguillages:=checkPosAig.checked;
    AvecDemandeInterfaceUSB:=CheckBoxDemarUSB.checked;
    AvecDemandeInterfaceEth:=CheckBoxDemarEth.checked;
    Modesombre:=CheckBoxSombre.Checked;

    protocole:=1;
    if RadioButtonXpress.Checked then
    begin
      protocole:=1;
      formprinc.EditEnvoi.Visible:=false;
      formprinc.ButtonEnv.Visible:=false;
    end;
    if RadioButtonDcc.Checked then
    begin
      protocole:=2;
      formprinc.EditEnvoi.Visible:=true;
      formprinc.ButtonEnv.Visible:=true;
    end;

    if checkEnvAigDccpp.Checked then EnvAigDccpp:=1 else EnvAigDccpp:=0;
    val(EditBase.Text,AdrBaseDetDccpp,erreur);
     if (AdrBaseDetDccpp<0) or (AdrBaseDetDccpp>2048) then AdrBaseDetDccpp:=513;
  end;
  if change_srv then services_CDM;
  verifie_panneau_config:=ok;
end;

procedure TFormConfig.ButtonAppliquerEtFermerClick(Sender: TObject);
var ok : boolean;
begin
  ok:=verifie_panneau_config;
  if ok then
  begin
    Sauve_config;
    formConfig.close;  // si la config est ok, on ferme la fenetre
  end;
end;

// affiche les champs du signal index
// LC=index du signal
procedure clicListeSignal(index : integer);
var AncAdresse,adresse,erreur : integer;
    s : string;
begin
  if (index<1) or (index>FormConfig.ListBoxSig.Items.Count) then exit;
  s:=Uppercase(FormConfig.ListBoxSig.Items[index-1]);   // ligne cliqu�e
  if s='' then
  begin
    ligneclicSig:=-1;
    exit;
  end;

  Signal_Sauve:=Signaux[index];  // sauvegarde

  AncLigneClicSig:=ligneclicSig;
  ligneClicSig:=index-1;

  // Mettre en rouge le signal modifi� quand on clique sur un autre signal
  if AncligneclicSig<>-1 then
  begin
    val(FormConfig.ListBoxSig.Items[AncLigneClicSig],AncAdresse,erreur);
  end;

  Val(s,Adresse,erreur);  // Adresse du signal
  if adresse=0 then exit;

  if Modesombre then Formconfig.editAdrSig.Color:=couleurfond else FormConfig.EditAdrSig.Color:=clWindow;

  aff_champs_signaux(index);   // affiche les champs du signal
  clicliste:=false;
end;

procedure champs_dec_centrale;
var i,nombre : integer;
begin
  if decCourant<1 then exit;
  decodeur_pers[decCourant].commande:=0;
  nombre:=decodeur_pers[decCourant].nbreAdr;
  for i:=1 to nombre do
  begin
    ComboTS1[i].Visible:=true;
    ComboTS2[i].Visible:=true;
    EditT[i].visible:=true;
    ComboL1[i].Visible:=true;
    ComboL2[i].Visible:=true;
    ShapeT[i].Visible:=true;
  end;
  for i:=nombre+1 to 10 do
  begin
    ComboTS1[i].Visible:=false;
    ComboTS2[i].Visible:=false;
    EditT[i].visible:=false;
    ComboL1[i].Visible:=false;
    ComboL2[i].Visible:=false;
    ShapeT[i].Visible:=false;
  end;

  with FormConfig do
  begin
    ComboBoxDecCde.Visible:=false;
    LabelTypCde.Visible:=false;
    LabelNA.Visible:=true;
    EditNbreAdr.Visible:=true;
  end;

  for i:=1 to 19 do
  begin
    LabelDecCde[i].Visible:=false;
    TextBoxCde[i].Visible:=false;
  end;

  with formconfig do
  begin
    labelDecal.caption:='D�calage'+#13+'d''adresse';
    LabelDecal.Left:=168;
    LabelSorties.visible:=true;
  end;
end;

procedure Champs_dec_Periph;
var i,n : integer;
begin
  if decCourant<1 then exit;
  decodeur_pers[decCourant].commande:=1;
  decodeur_pers[decCourant].NbreAdr:=10;
  for i:=1 to 10 do
  begin
    ComboTS1[i].Visible:=false;
    ComboTS2[i].Visible:=false;
    EditT[i].visible:=false;
    ComboL1[i].Visible:=false;
    ComboL2[i].Visible:=false;
    ShapeT[i].Visible:=false;
  end;
  with FormConfig do begin
    ComboBoxDecCde.Visible:=true;
    LabelTypCde.Visible:=true;
    LabelNA.Visible:=false;
    EditNbreAdr.Visible:=false;
  end;

  for i:=1 to 19 do
  begin
    LabelDecCde[i].Visible:=true;
    TextBoxCde[i].Visible:=true;
    TextBoxCde[i].Text:=decodeur_pers[decCourant].desc[i].Chcommande;
  end;

  n:=decodeur_pers[decCourant].nation;
  if n=2 then
  begin
    for i:=1 to 9 do
    begin
      LabelDecCde[i].caption:=EtatSignBelge[i];
      LabelDecCde[i].visible:=true;
    end;
    for i:=10 to 19 do
    begin
      LabelDecCde[i].visible:=false;
      TextBoxCde[i].Visible:=false;
    end;
  end;

  if n=1 then
  for i:=1 to 19 do
  begin
    LabelDecCde[i].caption:=Etats[i];
    LabelDecCde[i].visible:=true;
  end;

  with formconfig do
  begin
    ComboBoxDecCde.ItemIndex:=decodeur_pers[DecCourant].Peripherique-1;
    formconfig.labelDecal.caption:='Commandes'+#13+'Ascii';
    LabelDecal.Left:=160;
    formconfig.LabelSorties.visible:=false;
  end;
end;

// met � jour l'affichage du d�codeur courant depuis le tableau de config
procedure maj_decodeurs;
var nAdr,i,j,a,nation,typ : integer;
begin
  // si pas de d�codeur courant, on rend invisible toutes les adresses
  if decCourant=0 then nAdr:=0 else
  begin
    formConfig.ComboBoxNation.itemindex:=decodeur_pers[decCourant].nation-1;
    nAdr:=decodeur_pers[decCourant].NbreAdr;
    FormConfig.EditNbreAdr.Text:=intToSTR(decodeur_pers[decCourant].NbreAdr);
    nation:=decodeur_pers[decCourant].nation;
    typ:=decodeur_pers[decCourant].commande; //0=centrale 1=com/usb
  end;

  if typ=0 then
  begin
    for i:=1 to nAdr do
    begin
      comboL1[i].Items.Clear;
      comboL2[i].Items.Clear;
      if nation=1 then
      begin
        for j:=0 to 20 do
        begin
          comboL1[i].Items.add(Etats[j]);
          comboL2[i].Items.add(Etats[j]);
         end;
      end
      else
      for j:=0 to 9 do
      begin
        begin
          comboL1[i].Items.add(EtatSignBelge[j]);
          comboL2[i].Items.add(EtatSignBelge[j]);
         end;
      end;
      a:=decodeur_pers[decCourant].desc[i].etat1;
      ComboL1[i].itemIndex:=a;
      ComboL1[i].Visible:=true;

      a:=decodeur_pers[decCourant].desc[i].etat2;
      ComboL2[i].Itemindex:=a;
      ComboL2[i].Visible:=true;

      EditT[i].Text:=intToSTR(decodeur_pers[decCourant].desc[i].offsetAdresse);
      EditT[i].Visible:=true;
      a:=decodeur_pers[decCourant].desc[i].sortie1;
      ComboTS1[i].Itemindex:=a-1;
      ComboTS1[i].Visible:=true;
      a:=decodeur_pers[decCourant].desc[i].sortie2;
      ComboTS2[i].Itemindex:=a-1;
      ComboTS2[i].Visible:=true;
      ShapeT[i].Visible:=true;
    end;
    for i:=nADr+1 to 10 do
    begin
      ComboL1[i].Visible:=false;
      ComboL2[i].Visible:=false;
      EditT[i].Visible:=false;
      ComboTS1[i].Visible:=false;
      ComboTS2[i].Visible:=false;
      ShapeT[i].Visible:=false;
    end;
  end;

  FormConfig.RadioCdeDec.ItemIndex:=typ;
  if typ=0 then Champs_Dec_Centrale;
  if typ=1 then Champs_dec_Periph;
end;


// ajoute les champs des p�riph�riques dans les combos
procedure ajoute_champs_combos(i : integer);
var j : integer;
    s : string;
begin
  j:=com_socket(i);
  if j=1 then s:=Tablo_periph[i].nom+' (COM'+intToSTR(Tablo_periph[i].NumCom)+')';
  if j=2 then s:=Tablo_periph[i].nom+' ('+Tablo_periph[i].protocole+')';
  With formconfig do
  begin
    ComboBoxPNCom.Items.Add(s);
    ComboBoxDecCde.Items.Add(s);
  end;
  formModifAction.ComboBoxAccComUSB.Items.Add(s);
end;


// fabrique les combos des p�riph�riques
procedure fabrique_combos_periph;
var i : integer;
    s : string;
begin
  formModifAction.ComboBoxAccComUSB.clear;
  with FormConfig.ListBoxPeriph,FormConfig do
  begin
    ComboBoxPNCom.clear;
    ComboBoxDecCde.clear;
    for i:=0 to Count-1 do
    begin
      s:=items[i];
      ajoute_champs_combos(i+1);
    end;
  end;
end;


// met � jour le nom d'un champ d'index i dans les combos des p�riph�riques
procedure maj_champs_combos(i: integer);
var op,j,n : integer;
    s : string;
begin
  s:=Tablo_periph[i].nom;
  j:=com_socket(i);
  if j=0 then exit;
  if (j<1) or (j>2) then
  begin
    Affiche('Erreur 170 : type p�riph�rique inconnu='+intToSTR(j),clred);
    exit;
  end;
  if i>NbMaxi_Periph then
  begin
    Affiche('Erreur 171 : index p�riph�rique d�pass�='+intToSTR(i),clred);
    exit;
  end;
  if j=1 then s:=s+' (COM'+intToSTR(Tablo_periph[i].NumCom)+')';
  if j=2 then s:=s+' ('+Tablo_periph[i].protocole+')';
  with formconfig do
  begin
    n:=formModifAction.comboBoxACCComUSB.Items.Count;
    if n=0 then exit;
    if n<i then affiche('Anomalie ComboBox 7',clred);
    if ComboBoxPNCom.items.Count=0 then exit;
    formModifAction.ComboBoxAccComUSB.Items[i-1]:=s;

    // r�affiche le champ modifi� dans le comboboxAccComUSB
    for op:=1 to Tablo_Action[ligneclicAct+1].NbOperations do
      if Tablo_Action[ligneclicAct+1].tabloop[op].numoperation=ActionCdePeriph then if Tablo_Action[ligneclicAct+1].tabloOp[op].periph=i then formModifAction.ComboBoxAccComUSB.ItemIndex:=i-1;

    ComboBoxPNCom.items[i-1]:=s;
    if tablo_PN[lignecliqueePN+1].TypeCde=1 then if tablo_PN[lignecliqueePN+1].AdresseFerme=i then
    begin
      ComboBoxPNCom.ItemIndex:=i-1;
    end;
    ComboBoxDecCde.Items[i-1]:=s;
    if decodeur_pers[decCourant].commande=1 then if decodeur_pers[decCourant].peripherique=i then ComboBoxDecCde.ItemIndex:=i-1;
  end;
end;

// r�affecte les index des combos dans la base de donn�e
procedure reaffecte_index_combos(ancien1,ancien2,nouveau1,nouveau2 : integer);
var i,op : integer;
    s : string;
begin
  i:=1;
  repeat
    for op:=1 to Tablo_Action[i].NbOperations do
    begin
      if Tablo_Action[i].TabloOp[op].numoperation=ActionCdePeriph then
      begin
        if Tablo_Action[i].TabloOp[op].periph=ancien1 then
        begin
          Tablo_Action[i].tabloOp[op].periph:=nouveau1;
          s:=encode_actions(i);
          formConfig.ListBoxActions.Items[i-1]:=s;
          inc(i);
        end
        else
        if Tablo_Action[i].TabloOp[op].periph=ancien2  then
        begin
          Tablo_Action[i].TabloOp[op].periph:=nouveau2;
          s:=encode_actions(i);
          formConfig.ListBoxActions.Items[i-1]:=s;
          inc(i);
        end
        else
         inc(i);
      end
      else inc(i);
    end;
  until i>maxTablo_act ;

  i:=1;
  repeat
    // commande par p�riph�rique
    if Tablo_PN[i].typeCde=1 then
    begin
      if tablo_pn[i].AdresseFerme=ancien1 then // num�ro p�riph
      begin
        tablo_pn[i].AdresseFerme:=nouveau1;
        s:=encode_act_PN(i);
        FormConfig.ListBoxPN.Items[i-1]:=s;
        inc(i);
      end
      else
      if tablo_pn[i].AdresseFerme=ancien2 then // num�ro p�riph
      begin
        tablo_pn[i].AdresseFerme:=nouveau2;
        s:=encode_act_PN(i);
        FormConfig.ListBoxPN.Items[i-1]:=s;
        inc(i);
      end
      else
        inc(i);
    end
    else inc(i);
  until i>nbrePN ;

  i:=1;
  repeat
    if decodeur_pers[i].commande=1 then
    begin
      if decodeur_pers[i].peripherique=ancien1 then // num�ro p�riph
      begin
        decodeur_pers[i].peripherique:=nouveau1;
        inc(i);
      end
      else
      if decodeur_pers[i].peripherique=ancien2 then // num�ro p�riph
      begin
        decodeur_pers[i].peripherique:=nouveau2;
        inc(i);
      end
      else
        inc(i);
    end
    else inc(i);
  until i>NbreDecPers;
end;


procedure couleurs_config;
var i : integer;
    c : tcomponent;
begin
  if Modesombre then
  with formconfig do
  begin
    Color:=Couleurfond;
    // page principale
    for i:=0 to formconfig.ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurfond,couleurTexte);
    end;

    // onglet cdmrail GB5
    for i:=0 to GroupBox5.ComponentCount-1 do
    begin
      c:=GroupBox5.Components[i];
      composant(c,couleurfond,couleurTexte);
    end;

    // onglet d�codeurs
    for i:=0 to TabSheetDecodeurs.ComponentCount-1 do
    begin
      c:=TabSheetDecodeurs.Components[i];
      //Affiche(c.Name,clyellow);
      composant(c,couleurfond,couleurTexte);
    end;

    // PN
    for i:=0 to GroupBoxPNA.ComponentCount-1 do
    begin
      c:=GroupBoxPNA.Components[i];
      composant(c,couleurfond,couleurTexte);
    end;

    // p�riph�riques
    for i:=0 to TabSheetPeriph.ComponentCount-1 do
    begin
      c:=TabSheetPeriph.Components[i];
      composant(c,couleurfond,couleurTexte);
    end;

    // avanc�
    for i:=0 to TabAvance.ComponentCount-1 do
    begin
      c:=TabAvance.Components[i];
      composant(c,couleurfond,couleurTexte);
    end;
  end;
end;

// on change textBoxCde des d�codeurs
procedure TformConfig.tbCde_onchange(sender : Tobject);
var tb : tEdit;
    s,te : string;
    i : integer;
begin
  if affevt then affiche('tbCde_onchange',clyellow);
  tb:=sender as Tedit;
  s:=tb.Name;
  te:=tb.text;
  i:=extract_int(s);
  if (i<1) or (i>19) or (decCourant<1) then exit;
  decodeur_pers[decCourant].desc[i].Chcommande:=te;
end;

procedure raz_champs_pn;
begin
  with formconfig do
  begin
    editAdrFerme.Text:='';EditCdeFerme.text:='';
    editAdrOuvre.Text:='';EditCdeOuvre.text:='';
    editV1F.Text:='';editV1O.Text:='';
    editV2F.Text:='';editV2O.Text:='';
    editV3F.Text:='';editV3O.Text:='';
    editV4F.Text:='';editV4O.Text:='';
    editV5F.Text:='';editV5O.Text:='';
    EditZdet1V1F.text:='';EditZdet2V1F.text:='';EditZdet1V1O.text:='';EditZdet2V1O.text:='';
    EditZdet1V2F.text:='';EditZdet2V2F.text:='';EditZdet1V2O.text:='';EditZdet2V2O.text:='';
    EditZdet1V3F.text:='';EditZdet2V3F.text:='';EditZdet1V3O.text:='';EditZdet2V3O.text:='';
    EditZdet1V4F.text:='';EditZdet2V4F.text:='';EditZdet1V4O.text:='';EditZdet2V4O.text:='';
    EditZdet1V5F.text:='';EditZdet2V5F.text:='';EditZdet1V5O.text:='';EditZdet2V5O.text:='';
  end;
end;

procedure champs_pn_act;
begin
  with formConfig do
  begin
    comboBoxPNCom.Visible:=false;
    EditCdeOuvre.width:=25;
    editCdeFerme.Width:=25;
    editCdeOuvre.width:=25;
    editCdeFerme.top:=EditAdrFerme.Top;
    editCdeOuvre.top:=EditAdrOuvre.Top;
    ButtonTestFerme.Top:=EditAdrFerme.Top;
    ButtonTestOuvre.Top:=EditAdrOuvre.Top;

    editCdeFerme.Left:=168;
    editCdeOuvre.Left:=168;

    EditCdeOuvre.Hint:='Commande d''ouverture (0 � 2)';
    EditCdeFerme.Hint:='Commande de fermeture (0 � 2)';
    ButtonTestFerme.Hint:='Test de fermeture (mode CDM ou connect� � l''interface)';
    ButtonTestOuvre.Hint:='Test d''ouverture (mode CDM ou connect� � l''interface)';

    editCdeOuvre.Visible:=true;
    editAdrOuvre.Visible:=true;
    EditAdrFerme.Visible:=true;
    Label22.visible:=true;
    CheckPnPulse.Visible:=true;
    CheckPnPulse.top:=140;
    Label21.Caption:='Adresse de fermeture';
    EditAdrFerme.text:=IntToSTR(Tablo_PN[lignecliqueePN+1].AdresseFerme);
    EditAdrOuvre.text:=IntToSTR(Tablo_PN[lignecliqueePN+1].AdresseOuvre);
    EditCdeFerme.text:=intToSTR(Tablo_PN[lignecliqueePN+1].CommandeFerme);
    EditCdeOuvre.text:=intToSTR(Tablo_PN[lignecliqueePN+1].CommandeOuvre);
  end;
end;

procedure champs_pn_COMUSBSockets;
begin
  with formConfig do
  begin
    comboBoxPNCom.Visible:=true;
    ComboBoxPNCom.Width:=150;
    ComboBoxPNCom.Left:=4;
    ComboBoxPNCom.top:=120;
    EditAdrFerme.visible:=false;
    editAdrOuvre.Visible:=false;
    CheckPnPulse.Visible:=false;
    EditCdeOuvre.width:=50;
    editCdeFerme.width:=50;
    editCdeFerme.top:=120;ButtonTestFerme.Top:=120;ButtonTestFerme.Top:=120;
    editCdeOuvre.top:=150;ButtonTestOuvre.Top:=150;ButtonTestOuvre.Top:=150;
    editCdeFerme.Left:=160;
    editCdeOuvre.Left:=160;
    ButtonTestFerme.Hint:='Test de fermeture (par interface COM/USB)';
    ButtonTestOuvre.Hint:='Test d''ouverture (par interface COM/USB)';
    editcdeFerme.Hint:='Commande ASCII de fermeture';
    EditCdeOuvre.Hint:='Commande ASCII d''ouverture';
    Label22.visible:=false;
    Label21.Caption:='P�riph�rique COM/USB/Socket   Commandes';
    EditCdeFerme.Text:=Tablo_PN[lignecliqueePN+1].CommandeF;
    EditCdeOuvre.Text:=Tablo_PN[lignecliqueePN+1].CommandeO;
    ComboBoxPnCom.ItemIndex:=Tablo_PN[lignecliqueePN+1].AdresseFerme-1;
    CheckPNPulse.Visible:=false;
  end;
end;

procedure raz_champs_aig;
begin
  with formConfig do
  begin
    LabelInfo.caption:='';
    EditAdrAig.Text:='';
    EditAigTriple.Text:='';
    Edit_HG.text:='';
    editDevie_HD.Text:='';
    editDroit_BD.Text:='';
    editPointe_BG.Text:='';
    EditTempo10.text:='';
  end;
end;

// d�ploye tout le treeview de la fonction courante
Procedure tout_deployer;
var i : integer;
begin
  for i:=0 to Formconfig.TreeViewL.Items.Count-1 do
  begin
    formconfig.TreeViewL.Items[i].Expand(true);
  end;
  formconfig.ButtonAjOpEnfant.enabled:=false;
end;

// fabrique le tree view depuis la fonction k
procedure fabrique_treeview(k : integer);
var n,niveau,niveauPrec,j,i,idVar,typ : integer;
    node,nodePrec : Ttreenode;
    s : string;
begin
  if (k<1) or (k>NbreFL) then exit;
  formConfig.TreeViewL.Items.Clear;
  nodePrec:=formConfig.TreeViewL.Items.add(nil,texte_tv(k,0));   // Node origine
  // niv 0
  idOperateur:=0;
  idVar:=0;
  n:=fonction[k,0].adresse;
  for i:=1 to n-1 do
  begin
    begin
      if i>1 then niveauPrec:=fonction[k,i-1].niveau // niveau pr�c�dent  attention pour l'indice 0 c'est le num�ro de fonction
      else NiveauPrec:=1;
      niveau:=fonction[k,i].niveau;

      s:=texte_tv(k,i);

      // cr�er le nouveau node
      if niveau>niveauPrec then node:=formconfig.TreeViewL.items.addchild(nodePrec,s);
      if niveau=niveauPrec then node:=formconfig.TreeViewL.items.add(nodePrec,s);
      if niveau<niveauPrec then
      begin
        // remonter au niveau pr�c�dent
        j:=i;
        repeat
          dec(j);
        until (j=0) or (fonction[k,j].niveau=niveau);
        nodePrec:=formconfig.TreeViewL.Items[j];
        node:=formconfig.TreeViewL.items.add(nodePrec,s);
        if node.AbsoluteIndex<>i then Affiche('Erreur 784 : Fonction'+intToSTR(k)+': discordance '+intToSTR(Node.AbsoluteIndex)+' / '+intToSTR(i),clred);
      end;

      typ:=fonction[k,i].typ;

      node.ImageIndex:=typ;
      node.SelectedIndex:=typ;

      if node.parent<>nil then
      begin
        fonction[k,i].Indexprec:=node.Parent.AbsoluteIndex;
      end
        else fonction[k,i].Indexprec:=0;

      nodePrec:=node;
    end;
  end;
  {for i:=1 to 5 do
    for j:=1 to 4 do
    begin
      Affiche('ArbreFonc['+intToSTR(i)+','+intToSTR(j)+']='+inttostr(arbreFonc[i,j]),clOrange);
    end;}
  tout_deployer;
  formconfig.ButtonAjOpEnfant.enabled:=false;
end;

// si pas trouv� renvoie -1
function trouve_index_style : integer;
var i : integer;
    trouve : boolean;
    s : string;
begin
  //  supprime les espaces de nom_style_aff
  s:=nom_style_aff;
 { i:=1;
  repeat
    if s[i]=' ' then delete(s,i,1);
    inc(i);
  until i>length(s); }

  i:=1;
  repeat
    trouve:=lowercase(s)=lowercase(style[i].NomStyle);
    inc(i);
  until (i>NombreStyles) or (trouve);
  if trouve then result:=i-1 else result:=-1;
end;

// dessine la courbe de vitesse du train
procedure courbe_train(indexTrain : integer);
  procedure cord(var x,y : integer);
  begin
    x:=2*x;
    y:=(formConfig.ImageCourbes.Height-y*2);
  end;
  var x,y,c,vcms : integer ;
begin
  prem:=true;
  with formConfig.ImageCourbes.Canvas do
  begin
    Pen.Color := clWhite;
    Brush.Color := clWhite;
    pen.Mode:=pmCopy;
    Rectangle(0,0,formConfig.ImageCourbes.width,formConfig.ImageCourbes.Height);
    pen.width:=1;

    // dessine les axes en noir
    pen.Color:=clblack;
    moveTo(0,FormConfig.ImageCourbes.Height); LineTo(0,0);
    moveTo(0,FormConfig.ImageCourbes.Height-1); LineTo(formConfig.ImageCourbes.Width,FormConfig.ImageCourbes.Height-1);

    // dessine la 1ere vitesse de mesure
    pen.color:=clGreen;
    x:=trains[indexTrain].ConsV1; y:=0;
    cord(x,y); moveTo(x,y);
    formConfig.LabelV1Cons.left:=x+formConfig.ImageCourbes.Left-5;
    x:=trains[indexTrain].ConsV1; y:=round(crans_to_Vrcms(x,indexTrain));
    cord(x,y); LineTo(x,y);
    x:=0; y:=round(crans_to_Vrcms(trains[indexTrain].ConsV1,indexTrain));
    cord(x,y); LineTo(x,y);

    // dessine la 2eme vitesse de mesure
    x:=trains[indexTrain].ConsV2; y:=0;
    cord(x,y); moveTo(x,y);
    formConfig.LabelV2Cons.left:=x+formConfig.ImageCourbes.Left-5;
    x:=trains[indexTrain].ConsV2; y:=round(crans_to_Vrcms(x,indexTrain));
    cord(x,y); LineTo(x,y);
    x:=0; y:=round(crans_to_Vrcms(trains[indexTrain].ConsV2,indexTrain));
    cord(x,y); LineTo(x,y);

    // dessine la 3eme vitesse de mesure
    x:=trains[indexTrain].ConsV3; y:=0;
    cord(x,y); moveTo(x,y);
    formConfig.LabelV3Cons.left:=x+formConfig.ImageCourbes.Left-5;
    x:=trains[indexTrain].ConsV3; y:=round(crans_to_Vrcms(x,indexTrain));
    cord(x,y); LineTo(x,y);
    x:=0; y:=round(crans_to_Vrcms(trains[indexTrain].ConsV3,indexTrain));
    cord(x,y); LineTo(x,y);

    moveTo(0,FormConfig.ImageCourbes.Height);
    pen.Width:=2;
    pen.color:=clred;
    for x:=1 to 127 do
    begin
      vcms:=round(crans_to_Vrcms(x,indexTrain));
      c:=x;
      ValVitTrain[x]:=vcms;
      cord(c,vcms);
      lineTo(c,vcms);
    end;
  end;

  with formconfig do
  begin
    LabelCran.caption:='';
    LabelValeur.caption:='';
    LabelVcms.Caption:='';
  end;

end;

procedure clicListeTrains(index : integer);
var s : string;
    i,t : integer;
    r : single;
begin
  if affevt then Affiche('clicListeTrains '+intToSTR(index),clyellow);
  if index<1 then exit;
  if Trains[index].nom_train='' then exit;
  clicListe:=true;

  with formconfig do
  begin
    LabelInfo.caption:='';
    i:=trains[index].routePref[0][0].adresse;
    s:='';
    case i of
    0 : s:='Pas de route';
    1 : s:='1 route';
    else s:=intToSTR(i)+' routes';
    end;
    ButtonRdt.Caption:=s;

    editNomTrain.text:=Trains[index].nom_train;
    editAdresseTrain.Text:=intToSTR(trains[index].adresse);
    editVitesseMaxi.Text:=intToSTR(trains[index].vitmax);
    editLongLoco.text:=IntToSTR(trains[index].longueur);
    LabeledEditTempoD.Text:=intToSTR(trains[index].TempsDemarreSig);
    editVitRalenti.Text:=IntToSTR(trains[index].Vitralenti);
    editvitnom.text:=IntToSTR(trains[index].VitNominale);
    CheckBoxSens.Checked:=trains[index].inverse;
    s:=trains[index].NomIcone;
    editIcone.Text:=s;

    // Efface l'icone de train
    ImageTrain.Canvas.Rectangle(0,0,ImageTrain.Width,ImageTrain.Height);

    if s<>'' then
    begin
      Maj_icone_train(formconfig.ImageTrain,index,clWhite);
      Maj_icone_train(Image_Train[index],index,clWhite);
    end;

    // tableau des d�tecteurs d'arr�t
    for i:=1 to NbDetArret do
    begin
      t:=trains[index].DetecteurArret[i].temps;
      if t<>0 then
      begin
        s:='';
        if trains[index].DetecteurArret[i].TPrec<>det then s:='A';
        StringGridArr.Cells[1,i]:=s+intToSTR(trains[index].DetecteurArret[i].prec);
        StringGridArr.Cells[2,i]:=intToSTR(trains[index].DetecteurArret[i].detecteur);
        StringGridArr.Cells[3,i]:=intToSTR(t);
      end
      else
      begin
        StringGridArr.Cells[1,i]:='';
        StringGridArr.Cells[2,i]:='';
        StringGridArr.Cells[3,i]:='';
      end;
    end;

    LabeledEditVit1.text:=intToSTR(Trains[index].ConsV1);
    LabeledEditV1.Text:=FloatToSTRF(Trains[index].coeffV1,ffFixed,5,2,FormatSettings);

    LabeledEditVit2.text:=intToSTR(Trains[index].ConsV2);
    LabeledEditV2.Text:=FloatToSTRF(Trains[index].coeffV2,ffFixed,5,2,FormatSettings);

    LabeledEditVit3.text:=intToSTR(Trains[index].ConsV3);
    LabeledEditV3.Text:=FloatToSTRF(Trains[index].coeffV3,ffFixed,5,2,FormatSettings);

    if Trains[index].coeffV1<>0 then
    begin
      r:=Trains[index].consV1/Trains[index].coeffV1;
      LabelV1.Caption:='Vr1 (cm/s) = '+intToSTR(trains[index].consV1)+' (crans) / '+FloatToSTRF(Trains[index].coeffV1,ffFixed,5,2)+
                     ' = '+FloatToSTRF(r,ffFixed,5,2)+' cm/s';
    end
    else LabelV1.Caption:='Vr1';

    if Trains[index].coeffV2<>0 then
    begin
      r:=Trains[index].consV2/Trains[index].coeffV2;
      LabelV2.Caption:='Vr2 (cm/s) = '+intToSTR(trains[index].consV2)+' (crans) / '+FloatToSTRF(Trains[index].coeffV2,ffFixed,5,2)+
                     ' = '+FloatToSTRF(r,ffFixed,5,2)+' cm/s';
    end
    else LabelV2.Caption:='Vr2';

    if Trains[index].coeffV3<>0 then
    begin
      r:=Trains[index].consV3/Trains[index].coeffV3;
      LabelV3.Caption:='Vr3 (cm/s) = '+intToSTR(trains[index].consV3)+' (crans) / '+FloatToSTRF(Trains[index].coeffV3,ffFixed,5,2)+
                     ' = '+FloatToSTRF(r,ffFixed,5,2)+' cm/s';
    end
    else LabelV3.Caption:='Vr3';

    LabeledEditCV3.Text:=intToSTR(Trains[index].CV3);
    LabeledEditCV4.Text:=intToSTR(Trains[index].CV4);
    LabeledEditCrans.Text:=intToSTR(Trains[index].crans);

    courbe_train(index);

  end;
  clicListe:=false;
end;


procedure TFormConfig.FormCreate(Sender: TObject);
var i,j,x,y,l,k,LongestLength,PixelLength : integer;
    cs,s,LongestString : string;
    tp : tpersistent;
    trouve : boolean;
    param : TparamCompt;
    p: pointer;
begin
  if AffEvt or (debug=1) then Affiche('Cr�ation fen�tre config',clLime);

  ValueListEditor.Visible:=true;

  // liste des param�tres du mode expert de la ValueListEditor
  // syntaxe des masques:
  // 0 : chiffre  9 : chiffre ou espace   # : chiffre ou signe  L : lettre   ? : lettre ou espace
  // A : lettre ou chiffre   a : lettre, chiffre ou espace   & : tout caract�re


  with Liste[1] do
  begin
    Nom:='1. Seuil du nombre de d�tecteurs trop distants' ;
    aide:='Nombre de d�tecteurs consid�r�s comme trop distants'+#13+
          'Cette valeur d�pend de la taille du r�seau:'+#13+
          '3 pour les petits r�seaux jusque 5 ou 6 pour les grands' ;

    typ:= Simple ;
    masque:= '0';        // 1 chiffre
    variable:=@Nb_Det_Dist;
    typeVar:=entier;
  end;

  with Liste[2] do
  begin
    nom:='2. Nombre de cantons pr�sence train avant signal' ;
    aide:='Nombre de cantons � r�server (1 � 5) en avant du train.'+#13+
          'Utilis� en mode roulage.'+#13+
          'Cette valeur d�pend de la taille du r�seau.';
    typ:= Simple ;
    masque:= '0';
    variable:=@Nb_cantons_Sig;
    typeVar:=entier;
  end;

  with Liste[3] do
  begin
    nom:='3. Filtrage des d�tecteurs (x100ms) mode autonome';
    aide:='Temps de filtrage des d�tecteurs qui passent � 0'+#13+'Mode autonome uniquement';
    typ:=Simple ;
    masque:='0';
    variable:=@filtrageDet0;
    typeVar:=entier;
  end;

  with Liste[4] do
  begin
    nom:='4. Nombre de cantons � r�server en avant du train';
    aide:='Nombre de cantons � r�server en avant du train';
    typ:=Simple ;
    masque:= '0';
    variable:=@nCantonsRes;
    typeVar:=entier;
  end;

  with Liste[5] do
  begin
    nom:='5. Utilisation de l''anti timeout Ethernet';
    aide:='Si 1, envoie un caract�re chaque minute � la centrale '+#13+
          'pour �viter sa d�connexion (uniquement en Ethernet)';
    typ:= PickList;
    variable:=@AntiTimeoutEthLenz;
    typeVar:=Bool;
    textePL1:='Avec';         // textePL1 est toujours la valeur "vraie" du bool�en
    textePL2:='Sans';
  end;

  with Liste[6] do
  begin
    nom:='6. Facteur de Temporisation de t�l�commande CDM';
    aide:='Facteur multiplicateur de 1 � 10 pour la temporisation'+#13+
          'de la t�l�commande du d�marrage de CDM';
    typ:=Simple ;
    masque:= '0';
    variable:=@TempoTc;
    typeVar:=entier;
  end;
  with Liste[7] do
  begin
    nom:='7. Nombre maximal d''�lements par route';
    aide:= 'Nombre maximal d''�l�ments par route lors de la proposition du calcul des routes'+#13;
    typ:=Simple ;
    masque:= '000';
    variable:=@MaxParcours;
    typeVar:=entier;
  end;
  with Liste[8] do
  begin
    nom:='8. Nombre maximal de routes';
    aide:='Nombre maximal de routes lors de la proposition du calcul des routes'+#13;
    typ:=Simple ;
    masque:= '00000';
    variable:=@MaxRoutes;
    typeVar:=entier;
  end;
  with Liste[9] do
  begin
    nom:='9. Option demi tour des trains (mode autonome)';
    aide:='D�tecte le demi-tour des trains durant un parcours';
    typ := Picklist;
    variable:=@Option_demitour;
    typeVar:=bool;
    textePL1:='Avec';
    textePL2:='Sans';
  end;

  with Liste[10] do
  begin
    nom:='10. Algorithme de localisation des trains';
    aide:='Algorithme de localisation des trains';
    typ:=Simple ;
    masque:= '0';   //10
    variable:=@Algo_localisation;
    typeVar:=entier;
  end;

  with Liste[11] do
  begin
    nom:='11. Nombre maxi d''�l�ments de recherche d''un signal dans le bon sens';
    aide:='Nombre maxi d''�l�ments de recherche d''un signal dans le bon sens';
    typ:=Simple ;
    masque:= '0';
    variable:=@Max_signal_sens;
    typeVar:=entier;
  end;

  with Liste[12] do
  begin
    nom:='12. Attendre ACK de la centrale (mode autonome)';
    aide:='Attendre ACK de la centrale (mode autonome)';
    typ := Picklist;
    variable:=@avecAck;
    typeVar:=bool;
    textePL1:='Attendre';
    textePL2:='Ne pas attendre';
  end;
  with Liste[13] do
  begin
    nom:='13. M�thode de d�marrage du serveur de CDM rail';
    aide:='M�thode de d�marrage du serveur de CDM rail';
    typ:=Picklist;
    variable:=@ServeurIPCDM_touche;
    typeVar:=bool;
    textePL1:='Simulation de touches';
    textePL2:='Ligne de commandes';
  end;

  with Liste[14] do
  begin
    nom:='14. Chemin windows de CDM Rail (sans \CDM-Rail)';
    aide:='Chemin windows de CDM Rail (sans \CDM-Rail)';
    typ:=Simple ;
    masque:='';
    variable:=@cheminProgrammesCDM;
    typeVar:=chaine;
  end;

  with Liste[15] do
  begin
    nom:='15. Pilotage des trains dans CDM par nom ou adresse';
    aide:='Choix du mode de pilotage des trains'+#13+'par adresse ou par nom';
    typ:=PickList ;
    masque:='';
    variable:=@PilotageTrainsCDMNom;
    typeVar:=bool;
    textePL1:='Par nom du train';
    textePL2:='Par adresse du train';
  end;

  with Liste[16] do
  begin
    nom:='16. Visualisation d''interception clavier';
    aide:='Visualisation du caract�re d''interception clavier des blocs USB';
    typ:=PickList ;
    masque:='';
    variable:=@VisuIntercepte;
    typeVar:=bool;
    textePL1:='Valid�';
    textePL2:='Inhib�';
  end;

  with Liste[17] do
  begin
    nom:='17. Pilotage des accessoires';
    aide:='Pilotage des accessoires en mode asynchrone (conseill�) ou synchrone'+#13+
          '   Async=pas de blocage de la t�che principale'+#13+
          '   Sync=blocage temporaire de la t�che principale';
    typ:=PickList ;
    masque:='';
    variable:=@ModeTache;
    typeVar:=bool;
    textePL1:='Asynchrone (temps partag�)';
    textePL2:='Synchrone (temps s�quentiel)';
  end;

  with Liste[18] do begin
    nom:='    Affichages de la fen�tre principale';
    aide:='Affichages de la fen�tre principale';
    masque:='';
    variable:=nil;
    typeVar:=rien3;
  end;
  with Liste[19] do
  begin
    nom:='19. Ev�nements signaux';
    aide:='Affiche l''�tat des signaux lors de leur changement';
    typ:=PickList;
    masque:= '';
    variable:=@AffSig;
    typeVar:=bool;
    textePL1:='Oui';
    textePL2:='Non';
  end;

  with Liste[20] do
  begin
    nom:='20. R�servation/lib�ration des cantons';
    aide:='Affiche les r�servations/lib�ration des cantons lors du roulage des trains';
    typ:=PickList ;
    masque:='';
    variable:=@Affres;
    typeVar:=bool;
    textePL1:='Oui';
    textePL2:='Non';
  end;
  with Liste[21] do
  begin
    nom:='21. Debug roulage';
    aide:='Affiche des messages en mode roulage des trains en mode autonome';
    typ:=PickList ;
    masque:='';
    variable:=@DebugRoulage;
    typeVar:=bool;
    textePL1:='Oui';
    textePL2:='Non';
  end;
  with Liste[22] do
  begin
    nom:='22. Localisation trains';
    aide := 'Affiche des messages de localisation des trains' ;
    typ:=PickList ;
    masque:= '';                        //20
    variable:=@AffLoc;
    typeVar:=bool;
    textePL1:='Oui';
    textePL2:='Non';
  end;

  with ValueListEditor do
  begin
    Left:=1;
    Top:=32;
    width:=617;
    Height:=420;

    TitleCaptions[0]:='D�signation';
    TitleCaptions[1]:='Valeur';
    ColWidths[0]:=420;

    // cr�ation des lignes de la liste
    for i:=1 to 22 do
    begin
      p:=liste[i].variable;
      if liste[i].typeVar=entier then
       begin
         values[liste[i].Nom]:=intToSTR(integer(p^));    // �crire dans ValueListEditor.values la variable cr�e la ligne
       end;
       if liste[i].typeVar=bool then
       begin
         // la variable bool�enne contient les cha�nes "textePL1 et PL2" de la combobox (PickList) de s�lection
         if boolean(p^) then values[liste[i].Nom]:=liste[i].textePL1 else values[liste[i].Nom]:=liste[i].textePL2;
         ItemProps[i-1].EditStyle:=esPickList;
         ItemProps[i-1].PickList.clear;
         ItemProps[i-1].PickList.add(liste[i].textePL1);
         ItemProps[i-1].PickList.add(liste[i].textePL2);
       end;
       if liste[i].typeVar=chaine then values[liste[i].Nom]:=string(p^);
       if liste[i].typeVar=rien3 then values[liste[i].Nom]:='';      // titre et sans valeur
    end;
  end;

  ButtonVoir.Visible:=not(diffusion);
  LabeledEditTrain.Visible:=not(diffusion);

  editDebug.Hint:='D�bug au d�marrage'+#13+'0=sans'+#13+'1=Log d�marrage'+#13+'2=D�marrage par �tape'+#13+'3=Dynamique';
  TabSheetActionneurs.TabVisible:=not(diffusion); // invisible / visible
  TreeViewL.HideSelection:=false;
  TreeViewL.Images:=ImageListLogic;

  with SpinEditEtat do
  begin
    Top:=19;
    Left:=160;
    Visible:=false;
    text:='1';
    MaxValue:=2;
    Hint:='Etat de l''accessoire'+#13+
          '1=d�vi�'+#13+
          '2=droit';
    ShowHint:=true;
  end;

  LabelEtat.Top:=4;
  LabelEtat.Left:=160;
  LabelEtat.Visible:=false;

  with ComboBoxOperateur do
  begin
    Style:=csOwnerDrawFixed;
    clear;
    itemHeight:=18; // hauteur des icones
    items.add(nomopET);
    items.add(NomOpOU);
    items.add(NomOpNonET);
    items.add(NomOpNonOU);
  end;

  RadioGroupOP.visible:=false;

  with ComboBoxVar do
  begin
    Style:=csOwnerDrawFixed;
    clear;
    itemHeight:=18; // hauteur des icones
    items.add(NomEtatDCC);
    items.add(NomEtatDet);
    items.add(NomEtatBoutonTCO);
    items.add(NomEtatMemoire);
  end;

  s:=GetCurrentDir;
  if not(directoryExists(rep_icones)) then CreateDir(rep_icones);
  ChDir(s);  // revient au rep initial

  EditTempoOctetUSB.Hint:='Temporisation entre deux octets de la trame.'+#13+
                          'Cette valeur est ignor�e en protocole 2 (rts cts) et 4 (cts)';
  EditTempoOctetUSB.ShowHint:=true;
  visible:=false;
  clicListe:=true;
  position:=poMainFormCenter;
  RadioGroupLEB.Hint:='Mode binaire : CV12=0 '+#13+'Mode lin�aire : CV12<>0';
  cs:='ColorA='+IntToHex(couleurFond,6);  // pour rajouter aux couleurs personnalis�es de la fenetre couleur
  colorDialogFond.CustomColors.Add(cs);
  ButtonCouleur.Hint:='Change la couleur de fond de toutes les fen�tres de Signaux_Complexes.'+#13+
                      'Utilisez la couleur personnalis�e n�1 et apr�s modification,'+#13+
                      'cliquer sur "ajouter aux couleurs personnalis�es" qui seule sera sauvegard�e';

  Affiche_avert:=false;
  if affevt then affiche('FormConfig create',clLime);
  PageControlTR.ActivePage:=FormConfig.TabSheetTrGen;
  ButtonImRCDM.Hint:='Importation des actionneurs depuis le fichier '+#13+NomModuleCDM;
  foncCourante:=1;
  Aig_supprime.Adresse:=0;
  Signal_Supprime.Adresse:=0;
  Signal_sauve.adresse:=0;
  AncLigneCliqueePN:=-1;
  lignecliqueePN:=-1;
  clicListe:=false;
  changeCom:=false;
  ligneCherche:=0;
  Compt_ligne:=0;
  ConfigPrete:=true;
  richBranche.HideSelection:=false; // pour pouvoir copier coller la fenetre
  //groupBox21.Top:=304;
  GroupBox21.Left:=8;
  ButtonPropage.Hint:='Change les adresses dans les points de connexions'+#13+
                      'des aiguillages, des branches et des signaux'+#13+
                      'si on a chang� l''adresse d''un aiguillage';
  if debug=1 then Affiche('Fin cr�ation fen�tre config',clLime);

  EditNbreAdr.Text:='2';

  // trains
  for i:=1 to nTrains do  //
  begin
    cs:=trains[i].NomIcone;
    s:=GetCurrentDir;
    s:=s+'\icones';
    s:=s+'\'+cs;
    if cs<>'' then
    begin
      // lire le fichier icone
     if fileExists(s) then
      begin
        trains[i].icone.Picture.LoadFromFile(s);
      end
      else Affiche('Le fichier ic�ne train '+s+' n''a pas �t� trouv�',clred);
    end;
    cree_image_train(i);
  end;

  affecte_trains_config;  // affecte les trains aux cantons

  with StringGridArr do
  begin
    Hint:='-';
    ShowHint:=true;
    ColCount:=4;    // nombre de colonnes
    RowCount:=NbDetArret+1;
    Options := StringGridArr.Options + [goEditing];
    ColWidths[0]:=0;      // colonne grise invisible
    ColWidths[1]:=70;     // Pr�c�dent
    ColWidths[2]:=70;     // d�tecteur
    ColWidths[3]:=55;     // temps

    Cells[1,0]:='Pr�c�dent';
    Cells[2,0]:='D�tecteur';
    Cells[3,0]:='Temps (s)';
    for i:=0 to RowCount-1 do
      RowHeights[i]:=18;
   end;

  {$IF CompilerVersion >= 28.0}
  labelD12.Visible:=true;
  GroupBoxStyles.Visible:=true;
  {$IFEND}
  {$IFDEF WIN64}       // si compil� en 64 bits
  labelD12.Caption:='D12 x64';
  LabelD12.Left:=730;
  {$ENDIF}

  // cr�ation des champs dynamiques de l'onglet d�codeurs personnalis�s
  for i:=1 to 10 do
  begin
    y:=i*40+20;

    // rectangle
    ShapeT[i]:=Tshape.create(FormConfig.TabSheetDecodeurs);
    with ShapeT[i] do
    begin
      name:='Ligne'+intToSTR(i);
      left:=5;width:=350; top:=y;height:=42;
      brush.Style:=bsSolid;
      pen.color:=clBlack;
      shape:=stRectangle;
      parent:=TabSheetDecodeurs;
    end;

    ComboL1[i]:=TcomboBox.create(FormConfig.TabSheetDecodeurs);
    with ComboL1[i] do
    begin
      Name:='ComboL1'+intToSTR(i);
      text:='';
      left:=10;Top:=y;Width:=150;Height:=15;
      parent:=TabSheetDecodeurs;
      itemIndex:=-1;
      for j:=0 to 19 do items.add(etats[j]);
      onChange:=formConfig.modif_ComboL;
      Style:=csDropDownList;
      visible:=false;
    end;

    ComboL2[i]:=Tcombobox.create(FormConfig.TabSheetDecodeurs);
    with ComboL2[i] do
    begin
      Name:='ComboL2'+intToSTR(i);
      text:='';
      left:=10;Top:=y+20;Width:=150;Height:=15;
      parent:=TabSheetDecodeurs;
      itemIndex:=-1;
      for j:=0 to 19 do items.add(etats[j]);
      onChange:=formConfig.modif_ComboL;
      Style:=csDropDownList;
      visible:=false;
    end;

    // d�calage d'adresse
    EditT[i]:=TEdit.create(FormConfig.TabSheetDecodeurs);
    with EditT[i] do
    begin
      Name:='EditDecalT'+intToSTR(i);
      left:=180;Top:=y+10;Width:=30;Height:=15;
      text:='';
      parent:=TabSheetDecodeurs;
      visible:=false;
      Text:=intToSTR(i-1);
      onChange:=formConfig.modif_editT;
    end;

    ComboTS1[i]:=TComboBox.create(FormConfig.TabSheetDecodeurs);
    with ComboTS1[i] do
    begin
      Name:='ComboTS1'+intToSTR(i);
      left:=240;Top:=y;Width:=110;Height:=13;
      text:='';
      parent:=TabSheetDecodeurs;
      itemIndex:=-1;
      items.add('-  1 rouge d�vi�');
      items.add('+ 2 vert   droit');
      if (i-1) mod 2=0 then s:='Sortie 1' else s:='Sortie 2';
      Hint:=s;
      ShowHint:=true;
      visible:=false;
      Style:=csDropDownList;
      onChange:=formConfig.modif_ComboTS;
    end;

    ComboTS2[i]:=TComboBox.create(FormConfig.TabSheetDecodeurs);
    with ComboTS2[i] do
    begin
      Name:='ComboBoxTS2'+intToSTR(i);
      left:=240;Top:=y+20;Width:=110;Height:=13;
      text:='';
      parent:=TabSheetDecodeurs;
      itemIndex:=-1;
      items.add('-  1 rouge d�vi�');
      items.add('+ 2 vert  droit');
      if (i-1) mod 2=0 then s:='Sortie 1' else s:='Sortie 2';
      Hint:=s;
      ShowHint:=true;
      visible:=false;
      Style:=csDropDownList;
      onChange:=formConfig.modif_ComboTS;
    end;
  end;

  // composants dynamiques des d�codeurs personnalis�s pilot�s par p�riph�riques
  for i:=1 to 19 do
  begin
    y:=i*21+20;
    LabelDecCde[i]:=Tlabel.Create(FormConfig.TabSheetDecodeurs);
    with LabelDecCde[i] do
    begin
      Name:='LabelDecCde'+intToSTR(i);
      left:=20;Top:=y+20;Width:=110;Height:=13;
      caption:=etats[i];
      parent:=TabSheetDecodeurs;
      ShowHint:=false;
      visible:=false;
    end;

    TextBoxCde[i]:=Tedit.Create(FormConfig.TabSheetDecodeurs);
    with TextBoxCde[i] do
    begin
      Name:='TextBoxCde'+intToSTR(i);
      left:=150;Top:=y+20;Width:=120;Height:=15;
      text:='';
      parent:=TabSheetDecodeurs;
      ShowHint:=false;
      visible:=false;
      onChange:=formconfig.tbCde_onchange;
    end;
  end;

  GroupBoxPN.Top:=20;
  // composants onglet passage � niveau
  with GroupBoxPNA do
  begin
    Left:=8;
    top:=GroupBoxPN.Top+GroupBoxPN.Height+5;
    width:=GroupBoxPN.Width;
    height:=190;
    visible:=true;
  end;
  with GroupBoxPNZ do
  begin
    Left:=8;
    top:=GroupBoxPN.Top+GroupBoxPN.Height+5;
    width:=GroupBoxPN.Width;
    height:=190;
    visible:=false;
  end;

  LbATitre:=Tlabel.create(formconfig.GroupBoxPNA);
  with LbATitre do
  begin
    Left:=64;Top:=20;Width:=50;Height:=12;
    caption:='Act ferme               Act ouvre';
    name:='LbATitre';
    parent:=GroupBoxPNA;
  end;
  Shape1:=TShape.Create(formconfig.GroupBoxPNA);
  with Shape1 do
  begin
    Left:=64;Top:=40;Width:=140;Height:=2;
    name:='Shape1A';
    parent:=GroupBoxPNA;
  end;

  LbAPnVoie1:=Tlabel.create(formconfig.GroupBoxPNA);
  with LbAPnVoie1 do
  begin
    Left:=10;Top:=50;Width:=50;Height:=12;
    caption:='Voie1';
    name:='LbAPnVoie1';
    parent:=GroupBoxPNA;
  end;
  EditV1F:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV1F do
  begin
    Name:='EditV1F';
    left:=64;Top:=50;Width:=41;Height:=21;
    text:='';
    parent:=GroupBoxPNA;
    hint:='Actionneur de fermeture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditV1O:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV1O do
  begin
    Name:='EditV1O';
    left:=152;Top:=50;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;

  LbAPnVoie2:=Tlabel.create(formconfig.GroupBoxPNA);
  with LbAPnVoie2 do
  begin
    Left:=10;Top:=74;Width:=50;Height:=12;
    caption:='Voie2';
    name:='LbAPnVoie2';
    parent:=GroupBoxPNA;
  end;
  EditV2F:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV2F do
  begin
    Name:='EditV2F';
    left:=64;Top:=74;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur de fermeture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;
  EditV2O:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV2O do
  begin
    Name:='EditV2O';
    left:=152;Top:=74;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;

  LbAPnVoie3:=Tlabel.create(formconfig.GroupBoxPNA);
  with LbAPnVoie3 do
  begin
    Left:=10;Top:=98;Width:=50;Height:=12;
    caption:='Voie3';
    name:='LbAPnVoie3';
    parent:=GroupBoxPNA;
  end;
  EditV3F:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV3F do
  begin
    Name:='EditV3F';
    left:=64;Top:=98;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur de fermeture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;
  EditV3O:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV3O do
  begin
    Name:='EditV3O';
    left:=152;Top:=98;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;

  LbAPnVoie4:=Tlabel.create(formconfig.GroupBoxPNA);
  with LbAPnVoie4 do
  begin
    Left:=10;Top:=122;Width:=50;Height:=12;
    caption:='Voie4';
    name:='LbAPnVoie4';
    parent:=GroupBoxPNA;
  end;
  EditV4F:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV4F do
  begin
    Name:='EditV4F';
    left:=64;Top:=122;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur de fermeture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;
  EditV4O:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV4O do
  begin
    Name:='EditV4O';
    left:=152;Top:=122;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;


  LbAPnVoie5:=Tlabel.create(formconfig.GroupBoxPNA);
  with LbAPnVoie5 do
  begin
    Left:=10;Top:=146;Width:=50;Height:=12;
    caption:='Voie5';
    name:='LbAPnVoie5';
    parent:=GroupBoxPNA;
  end;
  EditV5F:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV5F do
  begin
    Name:='EditV5F';
    left:=64;Top:=146;Width:=41;Height:=21;
    text:='';
    parent:=GroupBoxPNA;
    hint:='Actionneur de fermeture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditV5O:=TEdit.create(FormConfig.GroupBoxPNA);
  with EditV5O do
  begin
    Name:='EditV5O';
    left:=152;Top:=146;Width:=41;Height:=21;
    text:='';
    hint:='Actionneur d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNA;
    onChange:=formConfig.modif_editT;
  end;

  //d�tecteurs de zone--------------------------------------------
  LbZTitre:=Tlabel.create(formconfig.GroupBoxPNZ);
  with LbZTitre do
  begin
    Left:=64;Top:=20;Width:=50;Height:=12;
    caption:='Zone ferme               Zone ouvre';
    name:='LbZTitre';
    parent:=GroupBoxPNZ;
  end;
  ShapeZ:=TShape.Create(formconfig.GroupBoxPNZ);
  with ShapeZ do
  begin
    Left:=64;Top:=40;Width:=170;Height:=2;
    name:='ShapeZ';
    parent:=GroupBoxPNZ;
  end;

  LbZPnVoie1:=Tlabel.create(formconfig.GroupBoxPNZ);
  with LbZPnVoie1 do
  begin
    Left:=10;Top:=50;Width:=50;Height:=12;
    caption:='Voie1';
    name:='LbZPnVoie1';
    parent:=GroupBoxPNZ;
  end;
  EditZDet1V1F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V1F do
  begin
    Name:='EditZDet1V1F';
    left:=64;Top:=50;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 1 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V1F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V1F do
  begin
    Name:='EditZDet2V1F';
    left:=100;Top:=50;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 2 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet1V1O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V1O do
  begin
    Name:='EditZDet1V1O';
    left:=152;Top:=50;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 1 d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V1O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V1O do
  begin
    Name:='EditZDet2V1O';
    left:=190;Top:=50;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 2 d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;

  LbZPnVoie2:=Tlabel.create(formconfig.GroupBoxPNZ);
  with LbZPnVoie2 do
  begin
    Left:=10;Top:=74;Width:=40;Height:=12;
    caption:='Voie2';
    name:='LbZPnVoie2';
    parent:=GroupBoxPNZ;
  end;
  EditZDet1V2F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V2F do
  begin
    Name:='EditZDet1V2F';
    left:=64;Top:=74;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 1 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V2F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V2F do
  begin
    Name:='EditZDet2V2F';
    left:=100;Top:=74;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 2 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet1V2O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V2O do
  begin
    Name:='EditZDet1V2O';
    left:=152;Top:=74;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 1 d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V2O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V2O do
  begin
    Name:='EditZDet2V2O';
    left:=190;Top:=74;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 2 d''ouverture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;

  // voie 3
  LbZPnVoie3:=Tlabel.create(formconfig.GroupBoxPNZ);
  with LbZPnVoie3 do
  begin
    Left:=10;Top:=98;Width:=50;Height:=12;
    caption:='Voie3';
    name:='LbZPnVoie3';
    parent:=GroupBoxPNZ;
  end;
  EditZDet1V3F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V3F do
  begin
    Name:='EditZDet1V3F';
    left:=64;Top:=98;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 1 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V3F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V3F do
  begin
    Name:='EditZDet2V3F';
    left:=100;Top:=98;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 2 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet1V3O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V3O do
  begin
    Name:='EditZDet1V3O';
    left:=152;Top:=98;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 1 d''ouverture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V3O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V3O do
  begin
    Name:='EditZDet2V3O';
    left:=190;Top:=98;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 2 d''ouverture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  // voie 4
  LbZPnVoie4:=Tlabel.create(formconfig.GroupBoxPNZ);
  with LbZPnVoie4 do
  begin
    Left:=10;Top:=122;Width:=50;Height:=12;
    caption:='Voie4';
    name:='LbZPnVoie4';
    parent:=GroupBoxPNZ;
  end;
  EditZDet1V4F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V4F do
  begin
    Name:='EditZDet1V4F';
    left:=64;Top:=122;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 1 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V4F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V4F do
  begin
    Name:='EditZDet2V4F';
    left:=100;Top:=122;Width:=35;Height:=21;
    text:='';
    hint:='D�tecteur 2 de fermeture';
    showhint:=true;
    parent:=GroupBoxPNZ;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet1V4O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V4O do
  begin
    Name:='EditZDet1V4O';
    left:=152;Top:=122;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 1 d''ouverture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V4O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V4O do
  begin
    Name:='EditZDet2V4O';
    left:=190;Top:=122;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 2 d''ouverture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  // voie 5
  LbZPnVoie5:=Tlabel.create(formconfig.GroupBoxPNZ);
  with LbZPnVoie5 do
  begin
    Left:=10;Top:=146;Width:=50;Height:=12;
    caption:='Voie5';
    name:='LbZPnVoie5';
    parent:=GroupBoxPNZ;
  end;
  EditZDet1V5F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V5F do
  begin
    Name:='EditZDet1V5F';
    left:=64;Top:=146;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 1 de fermeture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V5F:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V5F do
  begin
    Name:='EditZDet2V5F';
    left:=100;Top:=146;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 2 de fermeture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet1V5O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet1V5O do
  begin
    Name:='EditZDet1V5O';
    left:=152;Top:=146;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 1 d''ouverture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;
  EditZDet2V5O:=TEdit.create(FormConfig.GroupBoxPNZ);
  with EditZDet2V5O do
  begin
    Name:='EditZDet2V5O';
    left:=190;Top:=146;Width:=35;Height:=21;
    text:='';
    parent:=GroupBoxPNZ;
    hint:='D�tecteur 2 d''ouverture';
    showhint:=true;
    onChange:=formConfig.modif_editT;
  end;

  // remplit les 5 fen�tres de config des aiguillages branches signaux, actionneurs, accessoires comusb
  formconfig.ComboBoxDecodeurPerso.AutoComplete:=false; // mettre absolument � false sinon remplissage auto quand on tape et l'index s�lec peut changer!!!
  for i:=1 to NbreDecPers do
  begin
    s:=decodeur_pers[i].nom;
    formconfig.ComboBoxDecodeurPerso.Items.add(s);
  end;
  if NbreDecPers>0 then
  begin
    decCourant:=1;
    formconfig.ComboBoxDecodeurPerso.ItemIndex:=0;
    ComboBoxNation.ItemHeight:=decodeur_pers[decCourant].nation;
  end
  else formconfig.ComboBoxDecodeurPerso.ItemIndex:=-1;
  maj_decodeurs;

  // branches
  {
  clicListe:=true;
  RichBranche.clear;
  for i:=1 to NbreBranches do
  begin
    s:=Branche[i];
    RichBranche.Lines.Add(s);
    // RE_ColorLine(RichBranche,RichBranche.lines.count-1,ClAqua);
  end;
  With RichBranche do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end; }

  // signaux
  ListBoxSig.Items.clear;
  ComboBoxDec.items.Clear;
  for i:=0 to 11 do
  begin
    ComboBoxAsp.items.add(Aspects[i]);
  end;
  // d�codeurs de base
  for i:=1 to NbDecodeur do
  begin
    ComboBoxDec.items.add(decodeur[i-1]);
  end;

  // d�codeurs personalis�s
  for i:=1 to NbreDecPers do
  begin
    s:=decodeur_pers[i].nom;
    formconfig.ComboBoxDec.Items.add(s);
  end;

  longestLength:=0;
  for i:=1 to NbreSignaux do
  begin
    s:=encode_signal(i);  // encode la ligne depuis le tableau feux
    //Affiche(s,clwhite);
    if s<>'' then
    begin
      ListBoxSig.Items.Add(s);
      // trouver la chaine la plus longue pour la future scrollbar
      l:=Length(s);
      if l>LongestLength then
      begin
        LongestString:=s;
        LongestLength:=l;
      end;
      Signaux[i].modifie:=false;
    end;
  end;

  PixelLength:=ListboxSig.Canvas.TextWidth(LongestString);
  // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
  SendMessage(ListBoxSig.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);

  //comboBoxNation.Items.addObject('Fran�aise',Formprinc.Image9feux.Picture.Graphic);
  //comboBoxNation.Items.addObject('Belge',Formprinc.ImageSignal20.Picture.Graphic);
  //https://www.developpez.net/forums/d487670/environnements-developpement/delphi/composants-vcl/combobox-image-devant-ligne/
  comboboxNation.style:=csDropDownList;
  comboboxNation.Clear;
  comboBoxNation.Items.add('Fran�aise');
  comboBoxNation.Items.add('Belge');

  // actions
  ListBoxActions.Clear;
  longestLength:=0;
  for i:=1 to maxTablo_act do
  begin
    s:=encode_actions(i);
    if s<>'' then
    begin
      ListBoxActions.Items.add(s);
      // trouver la chaine la plus longue pour la future scrollbar
      l:=Length(s);
      if l>LongestLength then
      begin
        LongestString:=s;
        LongestLength:=l;
      end;
    end;
  end;
  PixelLength:=ListBoxActions.Canvas.TextWidth(LongestString)+GetSystemMetrics(SM_CXFRAME);
  // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
  // marche pas!!
  SendMessage(ListBoxActions.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);

  // actionneurs PN
  ListBoxPN.Clear;
  longestLength:=0;
  for i:=1 to NbrePN do
  begin
    s:=encode_act_pn(i);
    if s<>'' then
    begin
      ListBoxPN.items.Add(s);
      // trouver la chaine la plus longue pour la future scrollbar
      l:=Length(s);
      if l>LongestLength then
      begin
        LongestString:=s;
        LongestLength:=l;
      end;
    end;
  end;
  PixelLength:=ListboxPN.Canvas.TextWidth(LongestString)+8;
  // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
  SendMessage(ListBoxPN.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);
  champs_pn_act;

  if clicproprietesSig then clicListeSignal(IndexSignalClic);
  clicproprietesSig:=false;
  if clicproprietesTrains then clicListeTrains(ligneclicTrain+1);
  clicproprietesTrains:=false;

  // trains
  EditVitRalenti.Hint:='Vitesse apr�s l''avertissement'+#13+'en crans';
  EditVitNom.Hint:='Vitesse si voie libre'+#13+'en crans';
  EditVitesseMaxi.Hint:='Vitesse maximale autoris�e par le d�codeur'+#13+'en crans';
  
  i:=1;
  RichCdeDCCpp.clear;
  repeat
    if CdeDccpp[i]<>'' then
    begin
      RichCdeDccpp.Lines.add(CdeDccpp[i]);
      RE_ColorLine(RichCdeDccpp,RichCdeDccpp.lines.count-1,ClAqua);
    end;
    inc(i);
  until (CdeDccpp[i]='') or (i>MaxCdeDccpp);

  CheckEnvAigDccpp.Checked:=EnvAigDccpp=1;
  EditBase.Text:=intToSTR(AdrBaseDetDccpp);

  longestLength:=0;
  with ListBoxTrains do
  begin
    clear;
    for i:=1 to ntrains do
    begin
      s:=encode_train(i);
      items.Add(s);
      l:=Length(s);
      if l>LongestLength then
      begin
        LongestString:=s;
        LongestLength:=l;
      end;
    end;
  end;
  if ntrains<>0 then IdTrainClic:=1;

  ButtonlCV3.hint:='Passe la centrale en mode programmation et'+#13+
                  'lit le CV3 de la locomotive plac�e sur la voie de programmation';
  ButtonlCV4.hint:='Passe la centrale en mode programmation et'+#13+
                  'lit le CV4 de la locomotive plac�e sur la voie de programmation';

  PixelLength:=ListboxTrains.Canvas.TextWidth(LongestString)+8;
  // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
  SendMessage(ListBoxTrains.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);

  LabeledEditCrans.Hint:='Nombre de crans du d�codeur, 128 par d�faut.'+#13+
                         'Le nombre de crans � 128 est valid� par la mise � 1 du bit 1 du CV29 du d�codeur';
  LabeledEditCrans.ShowHint:=true;

  // compteurs
  ComboBoxCompt.ItemIndex:=0;

  FbmcompC:=Tbitmap.create;
  init_compteur(1,ImageCtC);

  // actionneurs
  with ListBoxActionneurs do
  begin
    clear;
    for i:=1 to Nactionneurs do items.add(encode_actionneur(i));
  end;

  // d�tecteurs
  with ListBoxDet do
  begin
    clear;
    for i:=1 to NDetecteurs do items.add(encode_detecteur(i));
  end;

  with EditPortCde do
  begin
    hint:='Port COM/USB : COMX:vitesse,parit�,nombre de bits de donn�es, nombre de bits de stop '+#13+
          'ou'+#13+
          'Socket : AdresseIPV4:port';
    ShowHint:=true;
  end;

  with cbDTR do
  begin
    hint:='COM/USB uniquement.'+#13+'D�coch�: mise � 0 de ligne DTR et �vite le reset de la plupart des arduinos,'+#13+'ou peut bloquer la transmission sur d''autres.';
    ShowHint:=true;
  end;

  // compilation avec D12----------------------------------------
  {$IF CompilerVersion >= 28.0}
  labelD12.Visible:=true;
  //  Styles (Embarcadero Dephi11)

  // remplir la combobox avec les styles disponibles
  for i:=0 to nombreStyles do
  begin
    ComboStyle.Items.Add(Style[i].NomStyle);
  end;

  i:=trouve_index_style;
  if i=-1 then i:=0;
  ComboStyle.ItemIndex:=i;

  CheckBoxSombre.Visible:=false;
  ButtonCouleur.Visible:=false;
  {$IFEND}

  ImageSignaux.picture.Assign(formpilote.ImageSignaux.Picture);

  EditComUSB.Hint:='COMX:vitesse,parit�,nombre de bits,bits de stop,protocole'+#13+
                   'procotole = 0 : sans protocole, avec temporisation d''envoi entre trames (LZV200)'+#13+
                   '          = 1 : protocole logiciel XON-XOFF avec temporisation d''envoi'+#13+
                   '          = 2 : protocole mat�riel RTS-CTS sans temporisation d''envoi (Interfaces Lenz LI)'+#13+
                   '          = 3 : Non utilis�'+#13+
                   '          = 4 : contr�le de la ligne CTS avant d''�mettre un caract�re avec temporisation d''envoi (Genli)';
  EditComUSB.showHint:=true;
  ListBoxAig.Height:=382;

  ligneclicAig:=-1;
  AncLigneClicAig:=-1;
  ligneClicSig:=-1;
  AncligneClicSig:=-1;
  ligneClicBr:=-1;
  AncligneClicBr:=-1;
  ligneClicAct:=-1;
  AncLigneClicAct:=-1;
  ligneClicAccPeriph:=-1;
  AncligneClicAccPeriph:=-1;

  fabrique_treeview(1);
  ComboBoxFL.Clear;
  for i:=1 to NbreFL do ComboBoxFL.Items.Add(NomVAR+' '+IntToSTR(i));

  if NbreFL<>0 then
  begin
    changeCom:=true;
    ComboBoxFL.ItemIndex:=0;
    LabeledEditNomLog.text:=nomFonction[1];
    LabeledEditNumFonc.text:=intToSTR(Fonction[1,0].niveau);
    changeCom:=false;
  end;

  // blocs usb
  ComboBoxUSBTr.Items.Add('Pas d''affectation');
  LabeledEditNUM.Text:=intToSTR(NumBlocUSB);
  for i:=1 to ntrains do
  begin
    ComboBoxUSBTr.Items.Add(trains[i].nom_train);
  end;
  i:=index_train_nom(BlocUSB[1].AffTrain);
  ComboBoxUSBTr.ItemIndex:=i;
  label72.caption:='La rotation de bouton changera la vitesse du train. L''appui sur le bouton stoppe le train.'+#13+
                   'Les �v�nements clavier sont intercept�s par signaux complexes ce qui ne n�cessite pas d''activer la fen�tre';

  with GroupBoxBr do
  begin
    Left:=312;
    top:=170;
    Width:=260;
    Height:=140;
    visible:=true;
  end;
  with GroupBoxBT do
  begin
    Left:=312;
    top:=170;
    Width:=260;
    Height:=140;
    Visible:=false;
  end;

  PageControl.ActivePage:=Formconfig.TabSheetCDM;  // force le premier onglet sur la page
  couleurs_config;
  formconfig.LabelInfo.Caption:='';
end;

// d�code un morceau d'une chaine d'aiguillage ('P5S')
// si erreur, B='?'
procedure decodeAig(s : string;var adr : integer;var B : char);
var erreur,i : integer;
begin
  if s='' then
  begin
    B:='?';adr:=0;
    exit;
  end;
  if (s[1]='P') or (s[1]='S') or (s[1]='D') then delete(s,1,1);
  if s='' then
  begin
    adr:=0;
    B:='Z';
    exit;
  end;
  // supprimer le champ suivant �ventuel
  i:=pos(',',s);
  if i<>0 then delete(s,i,length(s)-i+1);
  val(s,adr,erreur);
  if (adr<0) then begin B:='?';adr:=0;exit;end;
  if (erreur<>0) and (erreur<=length(s)) then
  begin
    if s[erreur]='S' then begin B:='S';exit;end;
    if s[erreur]='P' then begin B:='P';exit;end;
    if s[erreur]='D' then begin B:='D';exit;end;
  end;
  if erreur>length(s) then
  begin
    adr:=0;
    B:='?';
    exit;
  end;
  B:='Z';
end;

// renvoie les utilisateurs des p�riph�riques en fonction de la s�lection du p�riph�rique
function utilisateurs_peripheriques : string;
var i,j,n,op : integer;
   s : string;
begin
  n:=0;
  s:='P�riph�rique '+intToSTR(ligneClicAccPeriph+1)+' : '+Tablo_periph[ligneClicAccPeriph+1].nom+#13;
  s:=s+'------------------------'+#13;
  for i:=1 to maxTablo_act do
  begin
    for op:=1 to Tablo_Action[i].NbOperations do
    begin
      if Tablo_Action[i].tabloOp[op].numoperation=ActionCdePeriph then
      begin
        for j:=0 to NbPeriph-1 do
        begin
          if formconfig.ListBoxPeriph.selected[j] then
            if Tablo_Action[i].TabloOp[op].periph=j+1 then
            begin
              inc(n);
              s:=s+'Le p�riph�rique '+intToSTR(j+1)+' est utilis� par l''actionneur '+intToSTR(Tablo_Action[i].adresse)+#13;
            end;
        end;
      end;
    end;
  end;

  for i:=1 to nbrePN do
  begin
    // commande par p�riph�rique
    if Tablo_PN[i].typeCde=1 then
    begin
      for j:=0 to NbPeriph-1 do
      begin
        if formconfig.ListBoxPeriph.selected[j] then
          if Tablo_PN[i].AdresseFerme=j+1 then
          begin
            inc(n);
            s:=s+'Le p�riph�rique '+intToSTR(j+1)+' est utilis� par le PN '+intToSTR(Tablo_PN[i].voie[1].ActFerme)+#13;
          end;
      end;
    end;
  end;

  for i:=1 to NbreDecPers do
  begin
    if decodeur_pers[i].commande=1 then
    begin
      for j:=0 to NbPeriph-1 do
      begin
        if formconfig.ListBoxPeriph.selected[j] then
          if decodeur_pers[i].Peripherique=j+1 then
          begin
            inc(n);
            s:=s+'Le p�riph�rique '+intToSTR(j+1)+' est utilis� par le d�codeur personnalis� '+decodeur_pers[i].Nom+#13;
           end;
      end;
    end;
  end;

  if n=0 then s:=s+'Le p�riph�rique '+intToSTR(ligneClicAccPeriph+1)+' n''est pas utilis�'+#13;
  utilisateurs_peripheriques:=s;
end;


procedure Aff_champs_accPeriph_tablo(index : integer);
begin
  if (index<1) or (index>NbPeriph) then exit;
  clicliste:=true;
  formConfig.EditNomPeriph.Text:=Tablo_periph[index].nom;
  formconfig.cbAig.Checked:=Tablo_periph[index].ScvAig;
  formconfig.cbDet.Checked:=Tablo_periph[index].ScvDet;
  formconfig.cbAct.Checked:=Tablo_periph[index].ScvAct;
  formConfig.cbVis.Checked:=Tablo_periph[index].ScvVis;
  formConfig.cbDTR.Checked:=Tablo_periph[index].dtr;
  formConfig.cbRTS.Checked:=Tablo_periph[index].rts;

  formConfig.CheckBoxCR.Checked:=Tablo_periph[index].cr;

  formConfig.EditPortCde.text:=Tablo_periph[index].protocole;
  formconfig.MemoPeriph.Clear;
  clicliste:=false;
end;

// affiche le graphisme de l'aiguillage en fonction du tablo en index
procedure Aff_champs_aig_tablo(index : integer);
var Adresse,Adr2,ind,id2,erreur,position,AncienAdresse : integer;
    tjd,tri,tjs,croi : boolean;
    s,ss : string;
    i,vitesse : integer;
begin
  if index<1 then exit;
  s:=Uppercase(formConfig.ListBoxAig.items[index-1]);
  //Affiche(s,clLime);
  if s='' then exit;

  formconfig.labelInfo.caption:='';
  Val(s,Adresse,erreur);  // R�cup�rer l'adresse de l'aiguillage
  if adresse=0 then exit;

  ind:=Index_aig(adresse);
  clicliste:=true;

  ss:=InttoSTr(Adresse);
  formconfig.EditAdrAig.text:=ss;
  if Modesombre then formConfig.editAdrAig.Color:=couleurfond else FormConfig.EditAdrAig.Color:=clWindow;

  tjd:=pos('TJD',s)<>0 ;
  tri:=pos('TRI',s)<>0 ;
  tjs:=pos('TJS',s)<>0 ;
  croi:=pos('CROI',s)<>0 ;
  with formconfig do
  begin
    ImageAffiche.Picture.Bitmap.TransparentMode:=tmAuto;
    ImageAffiche.Picture.Bitmap.TransparentColor:=clblue;
    ImageAffiche.Transparent:=true;
    GroupBoxEtatTJD.Visible:=false;
    GroupBox21.Visible:=true;
    GroupBox10.Visible:=true;
    checkInverse.Visible:=true;

    GroupBox16.Enabled:=aiguillage[ind].visible;
    EditAdrAig.Enabled:=aiguillage[ind].visible;
    BoutSupAig.enabled:=aiguillage[ind].visible;
    ComboBoxAig.Enabled:=aiguillage[ind].visible;

    // tjd
    if tjd or tjs or croi then
    begin
      if not(croi) then begin Label20.Visible:=true; labelcrois.Visible:=false;end;
      if tjd or tjs then
      begin
        ComboBoxAig.ItemIndex:=1;
        EditL.Visible:=false;
        LabelL.Visible:=false;
        GroupBoxEtatTJD.Visible:=true;
        if aiguillage[ind].EtatTJD=2 then
        begin
          RadioButtonTJD2.Checked:=true;RadioButtonTJD4.Checked:=false;
          EditP1.Visible:=false;EditP2.Visible:=false;EditP3.Visible:=false;EditP4.Visible:=false;
          LabelTJD1.Visible:=false;LabelTJD2.Visible:=false;
          LabelInfo.Caption:='';
        end
        else if aiguillage[ind].EtatTJD=4 then
        begin
          RadioButtonTJD2.Checked:=false;RadioButtonTJD4.Checked:=true;
          EditP1.Visible:=true;EditP2.Visible:=true;EditP3.Visible:=true;EditP4.Visible:=true;
          LabelTJD1.Visible:=true;LabelTJD2.Visible:=true;
          LabelInfo.Caption:='';
        end
        else LabelInfo.Caption:='Nombre d''�tats de la TJD/S inconnu';
      end;

      if tjs then
      begin
       // GroupBoxEtatTJD.Visible:=true;
        ComboBoxAig.ItemIndex:=2;
        EditL.Visible:=true;
        LabelL.Visible:=true;
        LabelL.Caption:='L';
        EditL.Text:=IntToSTR(aiguillage[ind].tjsint)+aiguillage[ind].tjsintB;
      end;

      ImageAffiche.Picture.BitMap:=Imagetjd.Picture.Bitmap;
      labelBG.Caption:='S';
      Edit_HG.Visible:=true;
      EditAigTriple.Visible:=false;

      Edit_HG.ReadOnly:=false;
      EditPointe_BG.ReadOnly:=false;
      EditDevie_HD.ReadOnly:=false;
      EditDroit_BD.ReadOnly:=false;
      tjd:=true;
      labelHG.Visible:=true;

      CheckInverse.Visible:=true;
      EditDevieS2.Visible:=false;
      Label18.Visible:=false;
      adr2:=aiguillage[Index_Aig(adresse)].DDevie;
      id2:=Index_Aig(adr2);

      // champ en haut � gauche
      Edit_HG.Text:=intToSTR(aiguillage[index].ADroit)+aiguillage[Index_Aig(adresse)].ADroitB;
      Edit_HG.Hint:=TypeElAIg_to_char(aiguillage[index].Adroit,aiguillage[Index_Aig(adresse)].ADroitB);

      // champ en bas � gauche
      EditPointe_BG.Text:=intToSTR(aiguillage[index].ADevie)+aiguillage[Index].ADevieB;;
      EditPointe_BG.Hint:=TypeElAIg_to_char(aiguillage[index].ADevie,aiguillage[Index].ADevieB);

      // milieu haut gauche
      EditP1.Text:=intToSTR(adresse)+aiguillage[Index].DDroitB;
      // milieu bas gauche
      EditP2.Text:=intToSTR(adresse)+aiguillage[Index].DDevieB;

      // milieu haut droit
      EditP3.Text:=intToSTR(aiguillage[index].Ddevie)+aiguillage[index].DDevieB;
      // milieu bas droit
      EditP4.Text:=intToSTR(aiguillage[index].Ddroit)+aiguillage[index].DdroitB;

      if (aiguillage[ind].EtatTJD=4) or tjs then
      begin
        // droit haut
        EditDevie_HD.Text:=intToSTR(aiguillage[id2].Adevie)+aiguillage[id2].AdevieB;
        EditDevie_HD.Hint:=TypeElAIg_to_char(aiguillage[id2].Adevie,aiguillage[id2].AdevieB);
        LabelTJD1.Caption:=IntToSTR(adresse);

        // droit bas
        EditDroit_BD.Text:=intToSTR(aiguillage[id2].Adroit)+aiguillage[Id2].AdroitB;
        EditDroit_BD.Hint:=TypeElAIg_to_char(aiguillage[id2].ADroit,aiguillage[Id2].AdroitB);
        LabelTJD2.Caption:=IntToSTR(adr2);
      end;

      if ((aiguillage[ind].EtatTJD=2) and tjd) or croi then
      begin
        // droit haut
        EditDevie_HD.Text:=intToSTR(aiguillage[index].Ddevie)+aiguillage[index].DdevieB;
        EditDevie_HD.Hint:=TypeElAIg_to_char(aiguillage[index].Ddevie,aiguillage[index].DdevieB);
        LabelTJD1.Caption:=IntToSTR(adresse);
      
        // droit bas
        EditDroit_BD.Text:=intToSTR(aiguillage[index].Ddroit)+aiguillage[index].DdroitB;
        EditDroit_BD.Hint:=TypeElAIg_to_char(aiguillage[index].Ddroit,aiguillage[index].DdroitB); 
        LabelTJD2.Caption:=IntToSTR(adresse);
      end;

      CheckInverse.checked:=aiguillage[Index_Aig(adresse)].inversionCDM=1;

      vitesse:=aiguillage[Index_Aig(adresse)].vitesse;
      EditSpecifique.text:=intToSTR(vitesse);
      if vitesse=0  then begin RadioButtonSans.checked:=true; RadioButton30kmh.checked:=false;RadioButtonSpecifique.checked:=false;RadioButton60kmh.checked:=false;end
      else
      if vitesse=30 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=true; RadioButtonSpecifique.checked:=false;RadioButton60kmh.checked:=false;end
      else
      if vitesse=60 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButtonSpecifique.checked:=false;RadioButton60kmh.checked:=true;end
      else
        begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButtonSpecifique.checked:=true ;RadioButton60kmh.checked:=false;end;
    end;

    if croi then
    begin
      GroupBox21.Visible:=false;
      GroupBox10.Visible:=false;
      checkInverse.Visible:=false;
      editL.Visible:=false;
      labelL.Visible:=false;
      ComboBoxAig.ItemIndex:=4;
      editP1.Visible:=false;
      editP2.Visible:=false;
      editP3.Visible:=false;
      editP4.Visible:=false;
      labelTJD1.Visible:=false;
      labelTJD2.Visible:=false;
      labelcrois.Visible:=true;
    end;

    // aiguillage normal ou tri
    if (not(tjd) and not(tjs) and not(croi)) or tri then
    begin
      labelcrois.Visible:=false;
      EditL.Visible:=false;
      Label20.Visible:=false;
      LabelL.Visible:=false;
      ComboBoxAig.ItemIndex:=0;
      if not(tri) then
      begin
        ImageAffiche.Picture.BitMap:=Imageaig.Picture.Bitmap;
        EditDevieS2.Visible:=false;
        EditAigTriple.Visible:=false;
      end;
      labelBG.Caption:='P';
      EditPointe_BG.ReadOnly:=false;
      Edit_HG.Visible:=false;
      labelHG.Visible:=false;
      EditP1.Visible:=false;
      EditP2.Visible:=false;
      EditP3.Visible:=false;
      EditP4.Visible:=false;
      labelTJD1.Visible:=false;
      LabelTJD2.Visible:=false;

      Label18.Visible:=false;
      CheckInverse.checked:=aiguillage[Index_Aig(adresse)].inversionCDM=1;
      vitesse:=aiguillage[Index].vitesse;
      EditSpecifique.text:=intToSTR(vitesse);
      if vitesse=0 then begin RadioButtonSans.checked:=true;RadioButton30kmh.checked:=false;RadioButtonSpecifique.checked:=false;RadioButton60kmh.checked:=false;end
      else
      if vitesse=30 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=true;RadioButtonSpecifique.checked:=false;RadioButton60kmh.checked:=false;end
      else
      if vitesse=60 then begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButtonSpecifique.checked:=false;RadioButton60kmh.checked:=true;end
      else
      begin RadioButtonSans.checked:=false;RadioButton30kmh.checked:=false;RadioButtonSpecifique.checked:=true;RadioButton60kmh.checked:=false;
      end ;

      EditPointe_BG.Text:=intToSTR(aiguillage[index].Apointe)+aiguillage[index].ApointeB;
      EditPointe_BG.Hint:=TypeElAIg_to_char(aiguillage[index].Apointe,aiguillage[index].ApointeB);

      EditDevie_HD.Text:=intToSTR(aiguillage[index].Adevie)+aiguillage[index].AdevieB;
      EditDevie_HD.Hint:=TypeElAIg_to_char(aiguillage[index].Adevie,aiguillage[index].AdevieB);

      EditDroit_BD.Text:=intToSTR(aiguillage[index].Adroit)+aiguillage[index].AdroitB;
      EditDroit_BD.Hint:=TypeElAIg_to_char(aiguillage[index].Adroit,aiguillage[index].AdroitB);
      if tri then
      begin
        Label20.Visible:=true;

        ComboBoxAig.ItemIndex:=3; //  index de la combobox 0=aiguillage 1=TJD 2=TJS 3=aiguillage triple
        EditAigTriple.Visible:=true;
        labelTJD1.Visible:=false;
        LabelTJD2.Visible:=false;
        EditPointe_BG.ReadOnly:=false;
        labelBG.Caption:='P';
        ImageAffiche.Picture.BitMap:=ImageTri.Picture.Bitmap;
        EditDevieS2.Visible:=true;
        Label18.Visible:=true;
        adr2:=aiguillage[index].AdrTriple;
        EditDevieS2.text:=intToSTR(aiguillage[index].Adevie2)+aiguillage[index].Adevie2B;
        i:=aiguillage[index].Adrtriple;
        EditAigTriple.Text:=intToSTR(i);
      end;
    end;
  end;

  position:=aiguillage[index].posinit;
  if position=const_inconnu then formconfig.ComboBoxDD.ItemIndex:=2;
  if position=const_droit then formconfig.ComboBoxDD.ItemIndex:=1;
  if position=const_devie then formconfig.ComboBoxDD.ItemIndex:=0;
  formconfig.EditTempo10.text:=InttoSTr(aiguillage[index].temps);
  formconfig.EditTempo10.text:=InttoSTr(aiguillage[index].temps);

  if aiguillage[index].AdrCDM<>0 then
  begin
    if croi then s:='Croisement ' else s:='Aiguillage ';
    formconfig.labelInfo.caption:=s+'d�crivant la BJD '+intToSTR(aiguillage[index].AdrCDM);
  end;

  adresse:=aiguillage[ligneclicAig+1].Adresse;
  if adresse=0 then exit;
  index:=Index_Aig(Adresse);
  AncienAdresse:=aiguillage[index].AncienAdresse;
  if adresse<>AncienAdresse then
  FormConfig.ButtonPropage.Hint:='Change les adresses '+intToSTR(AncienAdresse)+' dans les points de connexions'+#13+
                         'des aiguillages et des branches par l''adresse '+intToSTR(adresse)
  else FormConfig.ButtonPropage.Hint:='Change les adresses dans les points de connexions'+#13+
                      'des aiguillages, des branches et des signaux'+#13+
                      'si on a chang� l''adresse d''un aiguillage';
  clicListe:=false;
end;


// transforme une chaine "�l�ment" en une chaine affichable pour le hint
// ex chaine_element("A32")=aiguillage 32
function chaine_element(Equip : Tequipement;adr : integer) : string;
var s: string;
begin
  case Equip of
  aig : s:='Aiguillage ';
  tjd : s:='Tjd ';
  tjs : s:='Tjs ';
  triple : s:='Aiguillage triple ';
  det : s:='D�tecteur ';
  else s:='Inconnu ';
  end;
  result:=s+intToSTR(adr);
end;



// mise � jour des champs du signal d'apr�s le tableau signaux
Procedure aff_champs_signaux(index : integer);
var j,l,d,p,k,nc,decodeur : integer;
    s : string;
begin
  if Affevt then affiche('Aff_champs_sig_feux('+intToSTR(index)+')',clyellow);
  if index<1 then exit;
  clicListe:=true;
  FormConfig.EditAdrSig.text:=InttoSTr(Signaux[index].adresse);

  with formconfig.ImageSignal do
  begin
    Picture.Bitmap.TransparentMode:=tmAuto;
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;
    picture.Bitmap:=Select_dessin_Signal(Signaux[index].aspect);
  end;

  if Signaux[index].contrevoie then inverse_image(formConfig.ImageSignal,Formprinc.ImageSignal20);

  with formconfig do
  begin
    MemoCarre.Lines.Clear;
    MemoBlanc.Lines.Clear;
    EditDet2.Text:=''; EditSuiv2.Text:='';
    EditDet3.Text:=''; EditSuiv3.Text:='';
    EditDet4.Text:=''; EditSuiv4.Text:='';
    ComboBoxDec.ItemIndex:=Signaux[index].decodeur;

    decodeur:=Signaux[index].decodeur;
    d:=Signaux[index].aspect;
    ButtonConfigSR.Visible:=false;

    case decodeur of
    2 : if not(isDirectionnel(index)) then
        begin
          ButtonConfigSR.Visible:=true; //cdf
        end;
    4 : begin
          EditSpecUni.Visible:=true;
          LabelUni.Caption:='Cible LEB';
          LabelUni.Visible:=true;
          EditSpecUni.Text:=IntToSTR(Signaux[index].Unisemaf);
          editSpecUni.Hint:='Param�tre de description de la cible LEB'+#13+'Mettre 100 pour les anciens d�codeurs (mode binaire uniquement)';
          editSpecUni.ShowHint:=true;
          j:=Signaux[index].UniSemaf;
          if j=100 then RadioGroupLEB.Visible:=false else RadioGroupLEB.Visible:=true;
          RadioGroupLEB.ItemIndex:=signaux[index].BinLin;
        end;
    7 : begin
          ButtonConfigSR.Visible:=true;
          //Aff_label_SR;
        end;
    5 : ButtonConfigSR.Visible:=true ; // digikeijs
    6 : begin
        EditSpecUni.Visible:=true;
        LabelUni.Caption:='Spec Unisemaf';
        LabelUni.Visible:=true;
        EditSpecUni.Text:=IntToSTR(Signaux[index].Unisemaf);
        editSpecUni.Hint:='Param�tre de description suppl�mentaire du d�codeur Unisemaf';
        editSpecUni.ShowHint:=true;
      end;
    9 : begin
        s:='D�codeur pour signaux belges SNCB - 4 aspects uniquement: ';
        labelInfo.Caption:=s+'vert - rouge - double jaune - rouge blanc';
      end;
    10 : begin
       s:='D�codeur pour signaux belges SNCB - 6 aspects + chiffre + V ';
       labelInfo.Caption:=s;
       labelUni.Caption:='Nombre d''adresses';LabelUni.Visible:=true;
       editSpecUni.Hint:='Nombre d''adresses occup�es par le signal';
       editSpecUni.ShowHint:=true;
       EditSpecUni.Visible:=true;
       EditSpecUni.Text:=IntToSTR(Signaux[index].Na);
       end;
    11: begin
         ButtonConfigSR.Visible:=true;
         //Aff_label_LEA;
       end;

  else labelInfo.Caption:='';
  end;

  if (decodeur<>4) and (decodeur<>6) and (decodeur<>10) then
      begin EditSpecUni.Visible:=false;LabelUni.Visible:=false;end;
  if decodeur<>4 then RadioGroupLEB.Visible:=false;
  // plus tard !!  if decodeur>=11 then ButtonConfigSR.Visible:=true;


  case d of
    2 : ComboBoxAsp.ItemIndex:=0;
    3 : ComboBoxAsp.ItemIndex:=1;
    4 : ComboBoxAsp.ItemIndex:=2;
    5 : ComboBoxAsp.ItemIndex:=3;
    7 : ComboBoxAsp.ItemIndex:=4;
    9 : ComboBoxAsp.ItemIndex:=5;
    20 : ComboBoxAsp.ItemIndex:=11;
  else
    ComboBoxAsp.ItemIndex:=d-10+4;
  end;

  // affiche ou non les checkbox en fonction de l'aspect
  if (((d=2) or (d>=5)) and (d<10)) or (d=20) then
  begin
    checkBoxFB.Visible:=true;
    Label69.Visible:=true;
    MemoBlanc.Visible:=true;
  end
  else
  begin
    checkBoxFB.Visible:=false;
    Label69.Visible:=false;
    MemoBlanc.Visible:=false;
  end;

  if d>2 then
  begin
    checkFVC.Visible:=true;
    checkFRC.Visible:=true;
  end
  else
  begin
    checkFVC.Visible:=false;
    checkFRC.Visible:=false;
  end;

  if ((d>3) and (d<10)) or (d=20) then CheckVerrouCarre.Visible:=true else CheckVerrouCarre.Visible:=false;
  if d=20 then
  begin
    CheckBoxVersContrevoie.Visible:=true;
    CheckBoxContrevoie.Visible:=true;
    CheckBoxContrevoie.Checked:=Signaux[index].contrevoie;
    CheckBoxVersContrevoie.Checked:=Signaux[index].Verscontrevoie;
    if Signaux[index].Btype_suiv1=Aig then s:='Permet d''afficher le chevron sur le signal si l''aiguillage '+intToSTR(Signaux[index].Adr_el_suiv1)+' est d�vi�'
      else s:='Permet d''afficher le chevron sur le signal si son aiguillage est d�vi�;'+char(13)+'mais ce signal n''est pas suivi d''un aiguillage';
    CheckBoxversContrevoie.Hint:=s;
    CheckBoxFB.caption:='Avec demande Blanc rouge';
    checkVerrouCarre.Caption:='verrouillable au rouge';
    checkVerrouCarre.Hint:='Positionne le signal au rouge si aucun train n''est pr�sent 3 cantons avant le signal';
    checkFVC.visible:=false;
    checkFRC.visible:=false;
  end
  else
  begin
    CheckBoxVersContrevoie.Visible:=false;
    CheckBoxContrevoie.Visible:=false;
    CheckBoxFB.caption:='Avec demande feu blanc';
    checkVerrouCarre.Caption:='verrouillable au carr�';
    checkVerrouCarre.Hint:='Positionne le signal au carr� si aucun train n''est pr�sent 3 cantons avant le signal';
  end;

  // signal normal
  if not(isDirectionnel(index)) then
  begin
    Label17.Caption:='Conditions suppl�mentaires d''affichage du carr� par les aiguillages :';
    label17.Width:=131;
    LabelDetAss.visible:=true;
    LabelElSuiv.visible:=true;
    label43.Visible:=true;

    EditDet1.Visible:=true;EditDet2.Visible:=true;EditDet3.Visible:=true;EditDet4.Visible:=true;
    EditSuiv1.Visible:=true;EditSuiv2.Visible:=true;EditSuiv3.Visible:=true;EditSuiv4.Visible:=true;
    Label24.Visible:=true; Label25.Visible:=true;Label26.Visible:=true;Label27.Visible:=true;
    EditDet1.Text:=IntToSTR(Signaux[index].Adr_det1);
    EditSuiv1.Text:=TypeEl_To_char(Signaux[index].Btype_suiv1)+IntToSTR(Signaux[index].Adr_el_suiv1);

    EditSuiv1.Hint:=chaine_element(Signaux[index].Btype_suiv1,Signaux[index].Adr_el_suiv1);
    j:=Signaux[index].Adr_det2;
    if j<>0 then
    begin
      Editdet2.Text:=IntToSTR(j);EditSuiv2.Text:=TypeEl_To_char(Signaux[index].Btype_suiv2)+IntToSTR(Signaux[index].Adr_el_suiv2);
      EditSuiv2.Hint:=chaine_element(Signaux[index].Btype_suiv2,Signaux[index].Adr_el_suiv2);
    end else begin EditDet2.Text:='';EditSuiv2.Text:='';EditSuiv2.Hint:='';end;
    j:=Signaux[index].Adr_det3;
    if j<>0 then
    begin
      EditDet3.Text:=IntToSTR(j);EditSuiv3.Text:=TypeEl_To_char(Signaux[index].Btype_suiv3)+IntToSTR(Signaux[index].Adr_el_suiv3);
      EditSuiv3.Hint:=chaine_element(Signaux[index].Btype_suiv3,Signaux[index].Adr_el_suiv3);
    end
    else begin EditDet3.Text:='';EditSuiv3.Text:='';EditSuiv3.Hint:='';end;
    j:=Signaux[index].Adr_det4;
    if j<>0 then
    begin
      EditDet4.Text:=IntToSTR(j);EditSuiv4.Text:=TypeEl_To_char(Signaux[index].Btype_suiv4)+IntToSTR(Signaux[index].Adr_el_suiv4);
      EditSuiv4.Hint:=chaine_element(Signaux[index].Btype_suiv4,Signaux[index].Adr_el_suiv4);
    end
    else
    begin
      EditDet4.Text:='';EditSuiv4.Text:='';EditSuiv4.Hint:='';
    end;
    checkVerrouCarre.Checked:=Signaux[index].VerrouCarre;
    checkBoxFB.Checked:=Signaux[index].FeuBlanc;
    checkFVC.Checked:=Signaux[index].checkFV;
    checkFRC.Checked:=Signaux[index].checkFR;
    // conditions suppl�mentaires du carr� par aiguillages
    l:=1;
    repeat
      nc:=Length(Signaux[index].condcarre[l])-1 ;
      if nc<>-1 then
      begin
        s:='';
        for k:=1 to nc do
        begin
          s:=s+'A'+IntToSTR(Signaux[index].condcarre[l][k].Adresse)+Signaux[index].condcarre[l][k].PosAig;
          if k<nc then s:=s+',';
        end;
        MemoCarre.Lines.Add(s);
      end;
      inc(l);
    until (nc<=0) or (l>6);
    // scrolle le MemoCarre sur la premi�re ligne
    MemoCarre.SelStart:=0;
    MemoCarre.Perform(EM_SCROLLCARET,0,0);
    // conditions suppl�mentaires du feu blanc par aiguillages
    l:=1;
    repeat
      nc:=Length(Signaux[index].condFeuBlanc[l])-1 ;
      if nc<>-1 then
      begin
        s:='';
        for k:=1 to nc do
        begin
          s:=s+'A'+IntToSTR(Signaux[index].condFeuBlanc[l][k].Adresse)+Signaux[index].condFeuBlanc[l][k].PosAig;
          if k<nc then s:=s+',';
        end;
        MemoBlanc.Lines.Add(s);
      end;
      inc(l);
    until (nc<=0) or (l>6);
    // scrolle le MemoCarre sur la premi�re ligne
    MemoBlanc.SelStart:=0;
    MemoBlanc.Perform(EM_SCROLLCARET,0,0);
     end
  else
  begin // directionnel
    Label17.Caption:='Conditions d''affichage du signal directionnel :';
    label17.Width:=131;
    label43.Visible:=false;
    LabelDetAss.visible:=false;
    LabelElSuiv.visible:=false;
    EditDet1.Visible:=false;EditDet2.Visible:=false;EditDet3.Visible:=false;EditDet4.Visible:=false;
    EditSuiv1.Visible:=false;EditSuiv2.Visible:=false;EditSuiv3.Visible:=false;EditSuiv4.Visible:=false;
    CheckVerrouCarre.Visible:=false;
    checkFVC.visible:=false;
    checkFRC.visible:=false;
    Label24.Visible:=false; Label25.Visible:=false;Label26.Visible:=false;Label27.Visible:=false;
    // conditions d'affichage du signal directionnel
    l:=Signaux[index].aspect-10; //nombre de feux du signal directionnel
    for p:=1 to L+1 do
    begin
     s:='';
     nc:=Length(Signaux[index].AigDirection[p])-1;
      for k:=1 to nc do
      begin
        s:=s+'A'+IntToSTR(Signaux[index].AigDirection[p][k].adresse) + Signaux[index].AigDirection[p][k].posaig;
        if k<nc then s:=s+',';
      end;
      MemoCarre.Lines.Add(s);
    end;
    // scrolle le MemoCarre sur la premi�re ligne
    MemoCarre.SelStart:=0;
    MemoCarre.Perform(EM_SCROLLCARET,0,0);
  end;
end;

  clicListe:=false;
end;

procedure raz_champs_sig;
begin
  with formconfig do
  begin
    LabelInfo.caption:='';
    EditDet1.Text:='';EditSuiv1.Text:='';
    EditDet2.Text:='';EditSuiv2.Text:='';
    EditDet3.Text:='';EditSuiv3.Text:='';
    EditDet4.Text:='';EditSuiv4.Text:='';
    EditAdrSig.Text:='';
    MemoCarre.Clear;
    ComboBoxAsp.ItemIndex:=-1;
    ComboBoxDec.ItemIndex:=-1;
    ImageSignal.Picture:=Nil;
    checkVerrouCarre.Checked:=false;
    checkBoxFB.Checked:=false;
    checkFVC.Checked:=false;
    checkFRC.Checked:=false;
  end;
end;


// cliqu� sur liste aiguillages
procedure TFormConfig.ListBoxAigMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,lc,adresse,erreur : integer;
    s : string;
begin
  clicliste:=true;
  if maxAiguillage<1 then exit;

  raz_champs_aig;
  ComboBoxAig.ItemIndex:=-1;
  formconfig.ComboBoxDD.ItemIndex:=-1;

  with Formconfig.ListBoxAig do
  begin
    i:=0;
    lc:=itemindex;
    //Affiche('num�ro de la ligne cliqu�e '+intToStr(lc),clyellow);
    s:=Uppercase(items[lc]);   // ligne cliqu�e
    if s='' then
    begin
      ligneclicAig:=-1;
      clicListe:=false;
      exit;
    end;

    Aig_sauve:=Aiguillage[lc+1];  // sauvegarde
    AncligneclicAig:=ligneclicAig;
    ligneclicAig:=lc;
  end;

  Val(s,Adresse,erreur);  // Adresse de l'aguillage
  if adresse=0 then exit;

  i:=index_aig(Adresse);

  aff_champs_Aig_tablo(i);
  clicliste:=false;
end;

procedure TFormConfig.Edit_HGChange(Sender: TObject);
var s : string;
    adr,adraig,erreur,index : integer;
    b : char;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt change HG',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneclicAig];
    Val(s,adrAig,erreur);
    //v�rifier la syntaxe
    s:=Edit_HG.text;
    decodeAig(s,adr,B);
    if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
    begin
      Index:=Index_Aig(AdrAig);
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';

      Aiguillage[index].Adroit:=adr;
      Aiguillage[index].AdroitB:=B;
      Edit_HG.Hint:=TypeElAIg_to_char(adr,B);

      // r�encoder la ligne
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[ligneclicAig]:=s;
      formconfig.ListBoxAig.selected[ligneclicAig]:=true;
    end
      else
        LabelInfo.caption:='Erreur pointe aiguillage '+intToSTR(AdrAig);
    end;
end;

// on change la valeur de la description du champ HG pour les TJD
procedure TFormConfig.EditDevie_HDChange(Sender: TObject);
var AdrAig,adr,adr2,erreur,index : integer;
    b : char;
    modele:Tequipement;
    s : string;
begin
  // cliqu� sur le edit d�vi� aiguillage
  // ne pas traiter si on a cliqu� sur la liste
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt change d�vi�',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneclicAig];
    Val(s,adrAig,erreur);
    //v�rifier la syntaxe de P
    s:=EditDevie_HD.text;
    decodeAig(s,adr,B);
    index:=index_aig(adrAig);
    if index=0 then exit;
    modele:=aiguillage[index].modele;

    if (modele=aig) or (modele=triple) then
    begin
      if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
      begin
        // aiguillage normal ou triple
        LabelInfo.caption:='';
        if (B='S') or (b='P') or (b='D') then
        begin
          if adr=AdrAig then LabelInfo.caption:='Un aiguillage ne peut pointer sur lui m�me ';
        end;

        Aiguillage[index].modifie:=true;
        // modifier la base de donn�es de l'aiguillage
        if b=#0 then b:='Z';
        Aiguillage[Index].ADevie:=adr;
        Aiguillage[Index].ADevieB:=B;
        EditDevie_HD.Hint:=TypeElAIg_to_char(adr,B);
        // r�encoder la ligne
        s:=encode_aig(Index);
        formconfig.ListBoxAig.items[ligneclicAig]:=s;
        formconfig.ListBoxAig.selected[ligneclicAig]:=true;
      end
      else
      begin
        LabelInfo.caption:='Erreur d�viation aiguillage '+intToSTR(AdrAig);
      end;
    end;

    if (modele=tjd) or (modele=tjs) then
    begin
      // TJD4/TJS
      if aiguillage[index].EtatTJD=4 then
      begin
        adr2:=aiguillage[index].DDroit;  // adresse homologue
        index:=Index_aig(adr2);
        if index=0 then
        begin
          labelInfo.Caption:='Renseignez le champ vert droit pour l''adresse homologue';
          exit;
        end;
        aiguillage[index].Adevie:=adr;
        aiguillage[index].AdevieB:=B;
        LabelInfo.caption:='Modification de la TJD homologe ('+IntToSTR(adr2)+')';
      end;
      if aiguillage[index].EtatTJD=2 then
      begin
        aiguillage[index].Ddevie:=adr;
        aiguillage[index].DdevieB:=B;
      end;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[index-1]:=s;
    end;

    if modele=crois then
    begin
      aiguillage[index].Ddevie:=adr;
      aiguillage[index].DdevieB:=B;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[index-1]:=s;
    end;
  end;
end;

// on change la valeur de la description de la d�viation de l'aiguillage
procedure TFormConfig.EditDroit_BDChange(Sender: TObject);
var AdrAig,adr,erreur,index,adr2 : integer;
    b : char;
    modele: TEquipement;
    s : string;
begin
  // cliqu� sur le edit droit aiguillage
  // ne pas traiter si on a cliqu� sur la liste
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt change droit',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneclicAig];
    Val(s,adrAig,erreur);
    //v�rifier la syntaxe de P
    s:=EditDroit_BD.text;
    decodeAig(s,adr,B);
    Index:=Index_Aig(AdrAig);
    if index=0 then exit;

    LabelInfo.caption:='';
    if (B='S') or (b='P') or (b='D') then
    begin
      if adr=AdrAig then LabelInfo.caption:='Un aiguillage ne peut pointer sur lui m�me ';
    end;

    modele:=aiguillage[index].modele;
    if (modele=aig) or (modele=triple) then
    begin
      if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
      begin
        Aiguillage[Index].modifie:=true;
        // modifier la base de donn�es de l'aiguillage
        if b=#0 then b:='Z';
        Aiguillage[index].ADroit:=adr;
        Aiguillage[index].ADroitB:=B;
        EditDroit_BD.Hint:=TypeElAIg_to_char(adr,B);
        // r�encoder la ligne
        s:=encode_aig(Index);
        formconfig.ListBoxAig.items[ligneclicAig]:=s;
        formconfig.ListBoxAig.selected[ligneclicAig]:=true;
      end
      else
      begin
        LabelInfo.caption:='Erreur droit aiguillage '+intToSTR(AdrAig);
      end;
    end;

    if (modele=tjd) or (modele=tjs) then
    begin
      // TJD4/TJS
      if aiguillage[index].EtatTJD=4 then
      begin
        adr2:=aiguillage[index].DDroit;  // adresse homologue
        index:=Index_aig(adr2);
        if index=0 then exit;
        aiguillage[index].Adroit:=adr;
        aiguillage[index].AdroitB:=B;
        LabelInfo.caption:='Modification de la TJD homologe ('+IntToSTR(adr2)+')';
      end;
      // TJD2
      if aiguillage[index].EtatTJD=2 then
      begin
        aiguillage[index].Ddroit:=adr;
        aiguillage[index].DdroitB:=B;
      end;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[index-1]:=s;
      //RE_ColorLine(Formconfig.ListBoxAig,index-1,ClWhite);
    end;

    if modele=crois then
    begin
      aiguillage[index].Ddroit:=adr;
      aiguillage[index].DdroitB:=B;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[index-1]:=s;
    end;
    if modele=triple then
    begin
      index:=index_aig(Aiguillage[index].Adrtriple);
      aiguillage[index].APointe:=adr;
      aiguillage[index].APointeB:=B;
      aiguillage[index].ADroit:=adr;
      aiguillage[index].ADroitB:=B;
     // s:=encode_aig(Index);
     // formconfig.ListBoxAig.items[ligneclicAig]:=s;
    end;
  end;

end;

procedure TFormConfig.EditPointe_BGChange(Sender: TObject);
var AdrAig,adr,erreur,index : integer;
    b : char;
    normal,tjdC,tjsC,triC,croi : boolean;
    s : string;
begin
  // cliqu� sur le edit pointe aiguillage
  // ne pas traiter si on a cliqu� sur la liste
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt change pointe',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneclicAig];
    Val(s,adrAig,erreur);
    Index:=Index_Aig(AdrAig);
    normal:=aiguillage[index].modele=aig;
    tjdC:=aiguillage[index].modele=tjd;
    tjsC:=aiguillage[index].modele=tjs;
    triC:=aiguillage[index].modele=triple;
    croi:=aiguillage[index].modele=crois;

    //v�rifier la syntaxe de P
    s:=Editpointe_BG.text;
    decodeAig(s,adr,B);
    if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
    begin
      LabelInfo.caption:='';
      if (B='S') or (b='P') or (b='D') then
      begin
        if adr=AdrAig then LabelInfo.caption:='Un aiguillage ne peut pointer sur lui m�me ';
      end;

      Aiguillage[index].modifie:=true;

      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';

      if normal or triC then
      begin
        Aiguillage[index].APointe:=adr;
        Aiguillage[index].APointeB:=B;
        // r�encoder la ligne
        s:=encode_aig(index);
        formconfig.ListBoxAig.items[ligneclicAig]:=s;
        formconfig.ListBoxAig.selected[ligneclicAig]:=true;
      end;
      if tjdC or tjsC or croi then
      begin
        Aiguillage[index].ADevie:=adr;
        Aiguillage[index].ADevieB:=B;
        s:=encode_aig(index);
        formconfig.ListBoxAig.items[ligneclicAig]:=s;
      end;
      EditPointe_BG.Hint:=TypeElAIg_to_char(adr,B);
    end
    else LabelInfo.caption:='Erreur pointe aiguillage '+intToSTR(AdrAig);
  end;
end;

procedure TFormConfig.EditDevieS2Change(Sender: TObject);
var AdrAig,adr,erreur,index : integer;
    b : char;
    s : string;
begin
  // cliqu� sur le edit droit aiguillage
  // ne pas traiter si on a cliqu� sur la liste
  if clicliste or (ligneClicAig<0)
   // or (ord(Key)<>VK_RETURN)
   then exit;
  if affevt then affiche('Evt change S2',clyellow);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    clicListe:=true;
    s:=formconfig.ListBoxAig.items[ligneclicAig];
    Val(s,adrAig,erreur);
    //v�rifier la syntaxe de P
    s:=EditDevieS2.text;
    decodeAig(s,adr,B);

    if ((B='S') or (B='P') or (B='D') or (B=#0) or (b='Z')) and (s<>'') then
    begin
      Index:=Index_Aig(AdrAig);
      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';
      Aiguillage[index].ADevie2:=adr;
      Aiguillage[index].ADevie2B:=B;
      // r�encoder la ligne
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[ligneclicAig]:=s;
      formconfig.ListBoxAig.selected[ligneclicAig]:=true;

      index:=index_aig(Aiguillage[index].Adrtriple);
      aiguillage[index].ADevie:=adr;
      aiguillage[index].ADevieB:=B;
     // s:=encode_aig(Index);
     // formconfig.ListBoxAig.items[ligneclicAig]:=s;

    end
    else
    begin
      LabelInfo.caption:='Erreur S2 aiguillage '+intToSTR(AdrAig);
    end;
  end;
  clicListe:=false;
end;

procedure TFormConfig.CheckInverseClick(Sender: TObject);
var s : string;
    adrAig,erreur : integer;
begin
  // r�cup�rer l'adresse de l'aiguillage cliqu�
  if clicliste or (ligneClicAig<0) then exit;
  if affevt then affiche('Evt change pointe',clyellow);
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if checkInverse.Checked then aiguillage[Index_Aig(adraig)].InversionCDM:=1 else aiguillage[Index_Aig(adraig)].InversionCDM:=0;
  // r�encoder la ligne
  s:=encode_aig(Index_Aig(AdrAig));
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;

procedure TFormConfig.RadioButtonsansClick(Sender: TObject);
var AdrAig,erreur,index : integer;
    s : string;
begin
  if clicliste then exit;
  if affevt then affiche('Evt RadioBouton sans vitesse',clyellow);
  if ligneclicAig<0 then exit;
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  aiguillage[index].vitesse:=0;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;

procedure TFormConfig.RadioButtonTJD2Click(Sender: TObject);
var AdrAig,erreur,index,adr2 : integer;
    s : string;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt RadioBouton tjd 2 �tats',clyellow);
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;

  EditP1.Visible:=false;EditP2.Visible:=false;EditP3.Visible:=false;EditP4.Visible:=false;
  LabelTJD1.Visible:=false;LabelTJD2.Visible:=false;

  index:=Index_Aig(AdrAig);
  aiguillage[index].etatTJD:=2;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;

  adr2:=aiguillage[index].Ddroit;  // adresse homologue
  index:=Index_Aig(Adr2);
  if index<>0 then
  begin
    aiguillage[index].etatTJD:=2;
    s:=encode_aig(index);
    formconfig.ListBoxAig.items[index-1]:=s;
  end;

  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;


procedure TFormConfig.RadioButtonTJD4Click(Sender: TObject);
var AdrAig,erreur,index,adr2 : integer;
    s : string;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt RadioBouton tjd 4 �tats',clyellow);
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;

  EditP1.Visible:=true;EditP2.Visible:=true;EditP3.Visible:=true;EditP4.Visible:=true;
  LabelTJD1.Visible:=true;LabelTJD2.Visible:=true;

  index:=Index_Aig(AdrAig);
  aiguillage[index].etatTJD:=4;
  aiguillage[index].modifie:=true;
  s:=encode_aig(index);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;

  adr2:=aiguillage[index].Ddroit;  // adresse homologue
  index:=Index_Aig(Adr2);
  if index<>0 then
  begin
    aiguillage[index].etatTJD:=4;
    aiguillage[index].modifie:=true;
    s:=encode_aig(index);
    formconfig.ListBoxAig.items[index-1]:=s;
  end;

  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;

procedure TFormConfig.RadioButton30kmhClick(Sender: TObject);
var AdrAig,erreur,index : integer;
    s : string;
begin
  if clicliste then exit;
  if ligneclicAig<0 then exit;
  if affevt then affiche('Evt RadioBouton vitesse 30',clyellow);
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  if index<>0 then
  begin
    aiguillage[index].vitesse:=30;
    aiguillage[index].modifie:=true;
  end;
  s:=encode_aig(index);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;

procedure vitesse_spec;
var s : string;
    AdrAig,erreur,index,v : integer;
begin
  if clicliste or (ligneclicAig<0) then exit;

  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  if index<>0 then
  begin
    val(formconfig.editSpecifique.Text,v,erreur);
    if (v>=99) or (v<1) or (erreur<>0) then begin FormConfig.labelInfo.Caption:='Erreur vitesse';exit;end;
    FormConfig.labelInfo.Caption:='';
    aiguillage[index].vitesse:=v;
    aiguillage[index].modifie:=true;
  end;
  s:=encode_aig(index);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;

procedure TFormConfig.EditSpecifiqueChange(Sender: TObject);
begin
  if affevt then affiche('Evt edit vitesse spec',clyellow);
  vitesse_spec;
end;

procedure TFormConfig.RadioButtonSpecifiqueClick(Sender: TObject);
begin
  if affevt then affiche('Evt RadioBouton vitesse spec',clyellow);
  vitesse_spec;
end;

procedure TFormConfig.RadioButton60kmhClick(Sender: TObject);
var AdrAig,erreur,index : integer;
    s : string;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt RadioBouton vitesse 60',clyellow);
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  if AdrAig=0 then exit;
  index:=Index_Aig(AdrAig);
  if index<>0 then
  begin
    aiguillage[Index].vitesse:=60;
    aiguillage[Index].modifie:=true;
  end;
  s:=encode_aig(index);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
end;

function verif_dec_sig(aff : boolean) : boolean;
var Adr,i,dec,aspect,indexAspect : integer;
begin
  result:=true;  
  for i:=1 to NbreSignaux do
  begin
    dec:=Signaux[i].decodeur;
    aspect:=Signaux[i].aspect;
    case aspect of
      2 : indexAspect:=0;
      3 : indexAspect:=1;
      4 : indexAspect:=2;
      5 : indexAspect:=3;
      7 : indexAspect:=4;
      9 : indexAspect:=5;
     12 : indexAspect:=6;
     13 : indexAspect:=7;
     14 : indexAspect:=8;
     15 : indexAspect:=9;
     16 : indexAspect:=10;
     20 : indexAspect:=11;
    end;
    Adr:=Signaux[i].adresse;
    //Affiche(IntToSTR(i)+' '+intToSTR(indexAspect)+' '+inttoSTR(dec),clred);
    case dec of
    // digital bahn
    1: if aspect=20 then begin result:=false;if aff then Affiche('Erreur 340 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // cdf
    2: if (aspect>=20) then begin result:=false;if aff then Affiche('Erreur 341 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // ls dec sncf
    3 : if (aspect>10) then begin result:=false;if aff then Affiche('Erreur 342 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // LEB
    4 : if aspect>10 then begin result:=false;if aff then Affiche('Erreur 343 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // dijikeijs
    5 : if aspect>10 then begin result:=false;if aff then Affiche('Erreur 344 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // paco unisemaf
    6 : if aspect>10 then begin result:=false;if aff then Affiche('Erreur 345 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // St�phane ravaux
    7 : if aspect>10 then begin result:=false;if aff then Affiche('Erreur 346 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // Arcomora
    8 : if aspect>10 then begin result:=false;if aff then Affiche('Erreur 347 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // LS DEC NMBS
    9 : if aspect<>20 then begin result:=false;if aff then Affiche('Erreur 348 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // B-models
    10 : if aspect<>20 then begin result:=false;if aff then Affiche('Erreur 349 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // LEA
    11 : if aspect>10 then begin result:=false;if aff then Affiche('Erreur 350 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);end;
    // personnalis�
    end;
    if (dec>=NbDecodeurdeBase) then
    begin
      // nationalit� du d�codeur
      if ((decodeur_pers[dec-NbDecodeurdeBase+1].nation=2) and (aspect<>20)) or
         ((decodeur_pers[dec-NbDecodeurdeBase+1].nation=1) and (aspect=20)) then
      begin
        result:=false;
        if aff then Affiche('Erreur 350 : Signal '+intToSTR(Adr)+': Combinaison d�codeur '+decodeur[dec]+' et aspect '+aspects[indexAspect]+' incompatibles',clred);
      end;
    end;
  end;
end;


procedure TFormConfig.ComboBoxDecChange(Sender: TObject);
var s: string;
    i,decodeur : integer;
begin
//  Affiche(IntToStr(ComboBoxDec.ItemIndex),clyellow);
  if clicListe then exit;
  labelInfo.caption:='';

  if NbreSignaux<ligneclicSig+1 then exit;
  i:=ligneclicSig+1;
  if i<1 then
  begin
    ComboBoxDec.ItemIndex:=-1;
    if NbreSignaux=0 then s:='Cr��z un signal ou ';
    s:='s�lectionnez un signal dans la liste';
    LabelInfo.Caption:=s;
    exit;
  end;

  decodeur:=ComboBoxDec.ItemIndex;

  if decodeur>NbDecodeur+NbreDecPers then exit;

  Signaux[i].decodeur:=decodeur;

  Maj_Hint_Signal(i);

  case decodeur of
   4 : begin
         labelUni.Caption:='Cible LEB';LabelUni.Visible:=true;
         EditSpecUni.Visible:=true;
         RadioGroupLEB.Visible:=true;
       end;
   6 : begin
         labelUni.Caption:='Spec Unisemaf';LabelUni.Visible:=true;
         EditSpecUni.Visible:=true;
       end;
   9 : begin
         s:='D�codeur pour signaux belges SNCB - 4 aspects uniquement: ';
         labelInfo.Caption:=s+'vert - rouge - double jaune - rouge blanc';
       end;
  10 : begin
         s:='D�codeur pour signaux belges SNCB - 6 aspects + chiffre + V ';
         labelInfo.Caption:=s;
         labelUni.Caption:='Nombre d''adresses';LabelUni.Visible:=true;
         EditSpecUni.Visible:=true;
       end
  else labelInfo.Caption:='';
  end;
  s:=encode_signal(i);
  formconfig.ListBoxSig.Items[ligneclicSig]:=s;
  ListBoxSig.selected[ligneClicSig]:=true;
  aff_champs_signaux(i);
  if not(verif_dec_sig(false)) then FormConfig.labelInfo.Caption:='Combinaison d�codeur / aspect incompatible';

  if affevt then Affiche('Evt ComboBox Decodeur',clOrange);
end;


procedure TFormConfig.EditDet1Change(Sender: TObject);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt detecteur 1',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet1.Text;
    Val(s,i,erreur);
    if (s='') or (erreur<>0) or (i<1) then begin LabelInfo.caption:='Erreur d�tecteur1 ';exit;end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_det1:=i;
    maj_hint_Signal(ligneClicSig+1);
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    Signaux[ligneClicSig+1].modifie:=true;
    ListBoxSig.selected[ligneClicSig]:=true;
  end;
end;

procedure TFormConfig.EditTempoSignalChange(Sender: TObject);
var i,erreur : integer;
    s : string;
begin
  s:=editTempoSignal.Text;
  Val(s,i,erreur);
  if (s='') or (erreur<>0) or (i<0) then begin LabelInfo.caption:='Erreur temporisation d�codeurs ';exit;end;
  LabelInfo.caption:=' ';
  Tempo_Signal:=i;
end;


procedure Suiv1;
   var s : string;
    i,erreur : integer;
    bt : Tequipement;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Element suivant1',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv1.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if (i<0) then begin LabelInfo.caption:='Erreur �l�ment suivant 1';exit;end;
      if (erreur<>0) and (erreur<=length(s)) then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig;
          delete(s,erreur,1);
          Val(s,i,erreur);
          if i<0 then begin LabelInfo.caption:='Erreur �l�ment suivant 1';exit;end;
        end
        else begin LabelInfo.caption:='Erreur �l�ment suivant 1';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_el_suiv1:=i;
    Signaux[ligneClicSig+1].Btype_suiv1:=bt;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
  end;
end;


procedure TFormConfig.EditSuiv1Change(Sender: TObject);
begin
  Suiv1;
end;

procedure Det2;
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt detecteur 2',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet2.Text;
    Val(s,i,erreur);
    if (s='') or (erreur<>0) or (i<1) then begin LabelInfo.caption:='Erreur d�tecteur2 ';exit;end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_det2:=i;
    maj_hint_Signal(ligneClicSig+1);
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet2Change(Sender: TObject);
begin
  det2;
end;


procedure TFormConfig.CheckVerrouCarreClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Verrou carr�',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    Signaux[ligneClicSig+1].VerrouCarre:=checkVerrouCarre.Checked;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.CheckBoxFBClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt FB',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    Signaux[ligneClicSig+1].FeuBlanc:=checkBoxFB.Checked;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure Suiv2;
var s : string;
    erreur,i: integer;
    bt : Tequipement;
begin
  if affevt then Affiche('Evt Element suivant2',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv2.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if (i<0) then begin LabelInfo.caption:='Erreur �l�ment suivant 2';exit;end;
      if (erreur<>0) and (erreur<=length(s)) then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
          if i<0 then begin LabelInfo.caption:='Erreur �l�ment suivant 2';exit;end;
        end
        else begin LabelInfo.caption:='Erreur �l�ment suivant 2';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_el_suiv2:=i;
    Signaux[ligneClicSig+1].Btype_suiv2:=bt;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
  end;
end;

procedure TFormConfig.EditSuiv2Change(Sender: TObject);
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) then exit;
  Suiv2;
end;

procedure det3;
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt detecteur 3',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet3.Text;
    Val(s,i,erreur);
    if (s='') or (erreur<>0) or (i<1) then begin LabelInfo.caption:='Erreur d�tecteur3 ';exit;end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_det3:=i;
    maj_hint_Signal(ligneClicSig+1);
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet3Change(Sender: TObject);
begin
  if clicliste or (ligneClicSig<0) then exit;
  det3;
end;

procedure Suiv3;
var s : string;
    erreur,i : integer;
    bt : Tequipement;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Element suivant3',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv3.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if (i<0) then begin LabelInfo.caption:='Erreur �l�ment suivant 3';exit;end;
      if (erreur<>0) and (erreur<=length(s)) then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
          if i<0 then begin LabelInfo.caption:='Erreur �l�ment suivant 3';exit;end;
        end
        else begin LabelInfo.caption:='Erreur �l�ment suivant 3';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_el_suiv3:=i;
    Signaux[ligneClicSig+1].Btype_suiv3:=bt;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
  end;
end;  

procedure TFormConfig.EditSuiv3Change(Sender: TObject);
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) then exit;
  suiv3;
end;

procedure det4;
var s : string;
    i,erreur : integer;
begin
  if clicliste then exit;
  if affevt then Affiche('Evt detecteur 4',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditDet4.Text;
    Val(s,i,erreur);
    if (s='') or (erreur<>0) or (i<1) then begin LabelInfo.caption:='Erreur d�tecteur4 ';exit;end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_det4:=i;
    maj_hint_Signal(ligneClicSig+1);
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.EditDet4Change(Sender: TObject);
begin
  if clicliste or (ligneClicSig<0) then exit;
  det4;
end;

procedure suiv4;
var s : string;
    erreur,i : integer;
    bt : Tequipement;
begin
  if clicliste or (ligneClicSig<0)  then exit;
  if affevt then Affiche('Evt Element suivant4',clOrange);
  
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSuiv4.Text;
    if s<>'' then
    begin
      Val(s,i,erreur);
      if (i<0) then begin LabelInfo.caption:='Erreur �l�ment suivant 4';exit;end;

      if (erreur<>0) and (erreur<=length(s)) then
      begin
        if (s[erreur]='A') and (erreur=1) then
        begin
          bt:=aig; 
          delete(s,erreur,1);
          Val(s,i,erreur);
          if i<0 then begin LabelInfo.caption:='Erreur �l�ment suivant 4';exit;end;
        end
        else begin LabelInfo.caption:='Erreur �l�ment suivant 4';exit;end;
      end
      else bt:=det;
    end
    else
    begin
      i:=0;
      bt:=rien;
    end;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].Adr_el_suiv4:=i;
    Signaux[ligneClicSig+1].Btype_suiv4:=bt;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
  end;
end;

procedure TFormConfig.EditSuiv4Change(Sender: TObject);
begin
  if clicliste or (comboBoxAsp.Itemindex>=6) or (ligneClicSig<0) then exit;
  Suiv4;
end;

procedure TFormConfig.ComboBoxAspChange(Sender: TObject);
var indexTCO,x,y,i,index,aspect,adresseFeu : integer;
    s : string;
    bm :tbitmap;
begin
  if clicListe then exit;

  if affevt then Affiche('Evt aspect',clOrange);
  labelInfo.Caption:='';
  i:=ComboBoxAsp.ItemIndex;
  //Affiche(IntToSTR(i),clyellow);
  case i of
  0 : aspect:=2;
  1 : aspect:=3;
  2 : aspect:=4;
  3 : aspect:=5;
  4 : aspect:=7;
  5 : aspect:=9;
  11 : aspect:=20;
  else aspect:=i+6;
  end;
  index:=ligneClicSig+1;  // index du feu
  if index<1 then
  begin
    ComboBoxAsp.ItemIndex:=-1;
    if NbreSignaux=0 then s:='Cr��z un signal ou ';
    s:='s�lectionnez un signal dans la liste';
    LabelInfo.Caption:=s;
    exit;
  end;
  if NbreSignaux<index then exit;
  //Affiche('Ligne cliqu�e='+IntToSTR(index),clyellow);

  Signaux[index].aspect:=aspect;

  s:=encode_signal(index);
  ListBoxSig.Items[ligneClicSig]:=s;
  aff_champs_signaux(index); // redessine les champs et le signal

  if not(verif_dec_sig(false)) then labelInfo.Caption:='Combinaison d�codeur / aspect incompatible';

  ListBoxSig.Selected[ligneClicSig]:=true;

  // change l'image du feu dans la feuille graphique principale
  bm:=Select_dessin_Signal(Signaux[index].aspect);
  if bm=nil then exit;
  Signaux[index].Img.picture.Bitmap:=bm;
  dessine_signal_mx(Signaux[index].Img.Canvas,0,0,1,1,Signaux[index].adresse,1);  // dessine les feux du signal

  // et dans les TCOs 
  for IndexTCO:=1 to NbreTCO do
  begin
    if formTCO[indexTCO]<>nil then
    begin
      for y:=1 to NbreCellY[indexTCO] do
      for x:=1 to NbreCellX[indexTCO] do
      begin
        if TCO[indexTCO,x,y].BImage=Id_Signal then   
        begin
          AdresseFeu:=Signaux[index].adresse;
          if tco[IndexTCO,x,y].Adresse=AdresseFeu then affiche_tco(indexTCO);
        end;
      end;
    end;
  end;
end;

procedure TFormConfig.EditSpecUniChange(Sender: TObject);
var erreur,i,Adr,decodeur : integer ;
    s : string ;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Unisemaf',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditSpecUni.Text;
    Val(s,i,erreur); // code unisemaf
    s:=EditAdrSig.Text;
    Val(s,Adr,erreur); // Adresse signal
    // v�rification code unisemaf
    decodeur:=Signaux[ligneClicSig+1].decodeur;
    if decodeur=4 then // LEB
    begin
      erreur:=verif_LEB(Adr,i);
      if erreur=1 then begin LabelInfo.caption:='Erreur code cible LEB';exit;end;
      if erreur=2 then begin LabelInfo.caption:='Erreur coh�rence aspect signal';exit;end;
      if i=100 then radioGroupLEB.Visible:=false else radioGroupLEB.Visible:=true;
      LabelInfo.caption:=' ';
      Signaux[ligneClicSig+1].Unisemaf:=i;
    end;
    if decodeur=6 then
    begin
      erreur:=verif_unisemaf(Adr,i);
      if erreur=1 then begin LabelInfo.caption:='Erreur code Unisemaf';exit;end;
      if erreur=2 then begin LabelInfo.caption:='Erreur coh�rence aspect signal';exit;end;
      LabelInfo.caption:=' ';
      Signaux[ligneClicSig+1].Unisemaf:=i;
    end;
    if decodeur=10 then Signaux[ligneClicSig+1].Na:=i;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
  end;
end;

procedure TFormConfig.ButtonrestaureClick(Sender: TObject);
var index : integer;
begin
  if (Signal_sauve.adresse<>0) and (ligneClicSig>=0) then
  begin
    clicListe:=true;
    index:=ligneClicSig+1;
    Signaux[index]:=Signal_sauve;
    ListBoxSig.Items[ligneClicSig]:=encode_signal(index);
    ListBoxSig.selected[ligneClicSig]:=true;
    aff_champs_signaux(index);  // r�affiche les champs
    Maj_Hint_Signal(index);
    // change l'image du feu dans la feuille graphique principale
    Signaux[index].Img.picture.Bitmap:=Select_dessin_Signal(Signaux[index].aspect);
    dessine_signal_mx(Signaux[index].Img.Canvas,0,0,1,1,Signaux[index].adresse,1);  // dessine les feux du signal
    clicListe:=false;
  end;
end;

procedure TFormConfig.EditAdrFermeChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt EditAdrFerme Change',clyellow);
  with Formconfig do
  begin 
    s:=EditAdrFerme.Text;
    Val(s,act,erreur);
    if (erreur<>0) or (act<1) then
    begin
      LabelInfo.caption:='Erreur adresse actionneur ferme';exit
    end else LabelInfo.caption:=' ';
    tablo_PN[lignecliqueePN+1].AdresseFerme:=act;
    s:=encode_act_PN(lignecliqueePN+1);
    ListBoxPN.items[lignecliqueePN]:=s;
    ListBoxPN.selected[lignecliqueePN]:=true;
  end;
end;

procedure TFormConfig.EditCdeFermeChange(Sender: TObject);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt EditCmdFerme Change',clyellow);
  with Formconfig do
  begin
    s:=EditCdeFerme.Text;
    if tablo_PN[lignecliqueePN+1].TypeCde=1 then
    begin
      tablo_PN[lignecliqueePN+1].CommandeF:=s;
    end
    else
    begin
      val(s,i,erreur);
      if (i<0) or (i>2) or (erreur<>0) then begin LabelInfo.caption:='Erreur Commande ferme actionneur';exit;end;
      LabelInfo.caption:=' ';
      tablo_PN[lignecliqueePN+1].CommandeFerme:=i;
    end;
    s:=encode_act_PN(lignecliqueePN+1);
    ListBoxPN.items[lignecliqueePN]:=s;
    ListBoxPN.selected[lignecliqueePN]:=true;
  end;
end;

procedure TFormConfig.EditAdrOuvreChange(Sender: TObject);
var s : string;
    act,erreur : integer;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt EditAdrOuvre Change',clyellow);
  with Formconfig do
  begin
    s:=EditAdrOuvre.Text;
    Val(s,act,erreur);
    if (erreur<>0) or (act<1) then
    begin
      LabelInfo.caption:='Erreur adresse actionneur ouvre';exit
    end else LabelInfo.caption:=' ';
    tablo_PN[lignecliqueePN+1].AdresseOuvre:=act;
    s:=encode_act_PN(lignecliqueePN+1);
    ListBoxPN.items[lignecliqueePN]:=s;
    ListBoxPN.selected[lignecliqueePN]:=true;
  end;
end;

procedure TFormConfig.EditCdeOuvreChange(Sender: TObject);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt EditCmdOuvre Change',clyellow);
  with Formconfig do
  begin
    s:=EditCdeOuvre.Text;

    if tablo_PN[lignecliqueePN+1].TypeCde=1 then
    begin
      tablo_PN[lignecliqueePN+1].CommandeO:=s;
    end
    else
    begin
      val(s,i,erreur);
      if (i<0) or (i>2) or (erreur<>0) then begin LabelInfo.caption:='Erreur Commande ferme actionneur';exit;end;
      LabelInfo.caption:=' ';
      tablo_PN[lignecliqueePN+1].CommandeOuvre:=i;
    end;

    s:=encode_act_PN(lignecliqueePN+1);
    ListBoxPN.items[lignecliqueePN]:=s;
    ListBoxPN.selected[lignecliqueePN]:=true;
  end;
end;

procedure ajoute_action;
var s: string;
    i : integer;
begin
  if affevt then affiche('Evt bouton nouveau acc',clyellow);
  if maxtablo_act>=Max_action then
  begin
    Affiche('Nombre maximal d''actionneurs atteint',clred);
    exit;
  end;
  clicliste:=true;
  inc(maxTablo_act);

  with formconfig.ListBoxActions do
    for i:=0 to items.Count-1 do Selected[i]:=false;

  // d�sactiver la ligne PN
  lignecliqueePN:=-1;

  Tablo_Action[maxtablo_act].NomAction:='ACTION'+intToSTR(maxtablo_act);

  SetLength(Tablo_Action[maxtablo_act].TabloOp,2);
  SetLength(Tablo_Action[maxtablo_act].TabloCond,2);
  Tablo_Action[maxtablo_act].NbCond:=1;
  Tablo_Action[maxtablo_act].NbOperations:=0;
  
  Tablo_Action[maxtablo_act].TabloCond[1].numcondition:=CondVrai;
  Tablo_Action[maxtablo_act].TabloOP[1].numoperation:=0;

  s:=encode_actions(MaxTablo_act);
  with formconfig.listBoxActions do
  begin
    items.add(s);
    Selected[maxTablo_act-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  formconfig.LabelInfo.caption:='';
  LigneClicAct:=MaxTablo_act-1;
  AncligneClicAct:=ligneClicAct;
  FormConfig.RichEditInfo.clear;
  formconfig.ListBoxOperations.Clear;

  clicliste:=false;
  config_modifie:=true;
end;

procedure TFormConfig.ButtonNouvAccClick(Sender: TObject);
begin
  ajoute_action;
end;

// affiche les champs de l'actionneur PN en fonction de l'index du tableau
procedure aff_champs_PN(i : integer);
var erreur,j,v,periph : integer;
    trouve : boolean;
    s : string;
begin

  if affevt then affiche('Aff_champs_PN('+intToSTR(i)+')',clyellow);
  if i<1 then
  begin
    clicliste:=false;
    exit;
  end;
  s:=Uppercase(FormConfig.ListBoxPN.items[i-1]);
  if s='' then
  begin
    clicliste:=false;
    exit;
  end;

  with formconfig do
  begin
    LabelInfo.caption:='';
    raz_champs_pn;
  end;

  // actionneur passage � niveau
  if s[1]='(' then
  begin
    //champs_type_pn;
    // trouver le num�ro de p�riph�rique
    v:=pos('PN(',s);
    delete(s,1,v+2);
    val(s,periph,erreur);
    {
    i:=0;
    repeat
      inc(i);
      trouve:=(Tablo_PN[i].AdresseFerme=adresse);
    until trouve or (i>NbrePN);
    if not(trouve) then exit;}

    with formConfig do
    begin
      RadioGroupActPN.itemindex:=Tablo_PN[i].TypeCde;

      if Tablo_PN[i].TypeCde=0 then champs_pn_act;
      if Tablo_PN[i].TypeCde=1 then champs_pn_comusbSockets;

      if Tablo_PN[i].Pulse=1 then trouve:=true else trouve:=false;
      CheckPnPulse.Checked:=trouve;

      // par actionneur
      if Tablo_PN[i].actionneur then
      begin
        RadioButtonSimple.Checked:=true;
        RadioButtonZone.Checked:=false;
        GroupBoxPNA.Visible:=true;
        GroupBoxPNZ.Visible:=false;
        EditV1F.text:=intToSTR(Tablo_PN[i].voie[1].ActFerme);
        EditV1O.text:=intToSTR(Tablo_PN[i].voie[1].ActOuvre);
        v:=Tablo_PN[i].nbvoies;
        if v>=2 then
        begin
          EditV2F.text:=intToSTR(Tablo_PN[i].voie[2].ActFerme);
          EditV2O.text:=intToSTR(Tablo_PN[i].voie[2].ActOuvre);
        end;
        if v>=3 then
        begin
          EditV3F.text:=intToSTR(Tablo_PN[i].voie[3].ActFerme);
          EditV3O.text:=intToSTR(Tablo_PN[i].voie[3].ActOuvre);
        end;
        if v>=4 then
        begin
          EditV4F.text:=intToSTR(Tablo_PN[i].voie[4].ActFerme);
          EditV4O.text:=intToSTR(Tablo_PN[i].voie[4].ActOuvre);
        end;
        if v>=5 then
        begin
          EditV5F.text:=intToSTR(Tablo_PN[i].voie[5].ActFerme);
          EditV5O.text:=intToSTR(Tablo_PN[i].voie[5].ActOuvre);
        end;

      end
      else
      begin
        // par zone de d�tecteurs
        RadioButtonSimple.Checked:=false;
        RadioButtonZone.Checked:=true;
        GroupBoxPNA.Visible:=false;
        GroupBoxPNZ.Visible:=true;
        v:=Tablo_PN[i].nbvoies;
        j:=Tablo_PN[i].voie[1].detZ1F;if j<>0 then
        begin
          EditZdet1V1F.text:=intToSTR(j);
          EditZdet2V1F.text:=intToSTR(Tablo_PN[i].voie[1].detZ2F);
          EditZdet1V1O.text:=intToSTR(Tablo_PN[i].voie[1].detZ1O);
          EditZdet2V1O.text:=intToSTR(Tablo_PN[i].voie[1].detZ2O);
          if v>=2 then
          begin
            EditZdet1V2F.text:=intToSTR(Tablo_PN[i].voie[2].detZ1F);
            EditZdet2V2F.text:=intToSTR(Tablo_PN[i].voie[2].detZ2F);
            EditZdet1V2O.text:=intToSTR(Tablo_PN[i].voie[2].detZ1O);
            EditZdet2V2O.text:=intToSTR(Tablo_PN[i].voie[2].detZ2O);
          end;
          if v>=3 then
          begin
            EditZdet1V3F.text:=intToSTR(Tablo_PN[i].voie[3].detZ1F);
            EditZdet2V3F.text:=intToSTR(Tablo_PN[i].voie[3].detZ2F);
            EditZdet1V3O.text:=intToSTR(Tablo_PN[i].voie[3].detZ1O);
            EditZdet2V3O.text:=intToSTR(Tablo_PN[i].voie[3].detZ2O);
          end;
          if v>=4 then
          begin
            EditZdet1V4F.text:=intToSTR(Tablo_PN[i].voie[4].detZ1F);
            EditZdet2V4F.text:=intToSTR(Tablo_PN[i].voie[4].detZ2F);
            EditZdet1V4O.text:=intToSTR(Tablo_PN[i].voie[4].detZ1O);
            EditZdet2V4O.text:=intToSTR(Tablo_PN[i].voie[4].detZ2O);
          end;
          if v>=5 then
          begin
            EditZdet1V5F.text:=intToSTR(Tablo_PN[i].voie[5].detZ1F);
            EditZdet2V5F.text:=intToSTR(Tablo_PN[i].voie[5].detZ2F);
            EditZdet1V5O.text:=intToSTR(Tablo_PN[i].voie[5].detZ1O);
            EditZdet2V5O.text:=intToSTR(Tablo_PN[i].voie[5].detZ2O);
          end;
        end;
      end;
    end;
  end;
  clicliste:=false;
end;


procedure ajoute_pn;
var s: string;
    i,j : integer;
begin
  if affevt then affiche('Evt bouton nouveau PN',clyellow);
  if maxtablo_act>=Max_action then
  begin
    Affiche('Nombre maximal d''actionneurs atteint',clred);
    exit;
  end;

  clicliste:=true;
  inc(nbrePN);
  i:=nbrePN;

  with formconfig.ListBoxPN do
    for i:=0 to items.Count-1 do Selected[i]:=false;
  ligneclicAct:=-1;

  raz_champs_pn;
  tablo_PN[NbrePN].AdresseFerme:=0;
  tablo_PN[NbrePN].AdresseOuvre:=0;
  tablo_PN[NbrePN].commandeFerme:=0;
  tablo_PN[NbrePN].CommandeOuvre:=0;
  tablo_PN[NbrePN].NbVoies:=1;
  tablo_PN[NbrePN].Pulse:=0;
  tablo_PN[NbrePN].actionneur:=true;

  for j:=1 to 5 do
  begin
    tablo_PN[NbrePN].Voie[j].ActFerme:=0;
    tablo_PN[NbrePN].Voie[j].ActOuvre:=0;
    tablo_PN[NbrePN].Voie[j].detZ1F:=0;
    tablo_PN[NbrePN].Voie[j].detZ1O:=0;
    tablo_PN[NbrePN].Voie[j].detZ2F:=0;
    tablo_PN[NbrePN].Voie[j].detZ2O:=0;
    tablo_PN[NbrePN].compteur:=0;
  end;

  s:=encode_act_pn(NbrePN);

  // ajouter et scroller en fin
  with formconfig.ListBoxPN do
  begin
    items.add(s);
    SetFocus;
    selected[NbrePN-1]:=true;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  with formConfig do
  begin
    GroupBoxPNA.Visible:=true;
    GroupBoxPNZ.Visible:=false;

    RadioButtonSimple.Checked:=true;
    RadioButtonZone.Checked:=false;

    LabelInfo.caption:='';
  end;
  LigneCliqueePN:=NbrePN-1;
  AncLigneCliqueePN:=LigneCliqueePN;
  tablo_PN[lignecliqueePN+1].Pulse:=1;
  Aff_champs_PN(nbrePN);
  clicliste:=false;
  config_modifie:=true;
end;

procedure TFormConfig.ButtonNouvPNClick(Sender: TObject);
begin
  ajoute_pn;
end;

procedure supprime_action;
var i,j,n : integer;
    ss,s: string;
begin
  ss:='';
  n:=0;
  for i:=0 to maxTablo_act-1 do
  begin
    if formconfig.ListBoxActions.selected[i] then
    begin
      ss:=ss+Tablo_Action[i+1].NomAction+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer ';
  if n=1 then s:=s+' l''action ' else s:=s+' les actions ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;

  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxActions.selected[i-1] then
    begin
      for j:=i to maxTablo_act-1 do
      begin
        formconfig.ListBoxActions.selected[j-1]:=formconfig.ListBoxActions.selected[j];
        Tablo_Action[j]:=Tablo_Action[j+1];
      end;
      dec(maxTablo_act);
      i:=0;
    end;
    inc(i);
  until i>maxTablo_act;

  config_modifie:=true;
  FormConfig.ListBoxActions.Clear;
  FormConfig.ListBoxOperations.clear;
  formConfig.RichEditInfo.Clear;

  // r�afficher la liste
  for i:=1 to maxTablo_act do
  begin
    s:=encode_actions(i);
    FormConfig.ListBoxActions.items.Add(s);
  end;
  ligneclicAct:=-1;
  AncligneclicAct:=-1;
  clicliste:=false;
end;

procedure TFormConfig.ButtonSupAccClick(Sender: TObject);
begin
  if affevt then affiche('Evt bouton Sup acc',clyellow);
  supprime_action;
end;

procedure supprime_pn;
var n,i,j : integer;
    ss,s: string;
begin
  if affevt then affiche('Evt bouton Sup PN',clyellow);

  ss:='';
  n:=0;
  for i:=0 to nbrePN-1 do
  begin
    if formconfig.ListBoxPN.selected[i] then
    begin
      if tablo_PN[i+1].Voie[1].ActFerme<>0 then ss:=ss+intToSTR(tablo_PN[i+1].Voie[1].ActFerme)+' '
      else ss:=ss+intToSTR(tablo_PN[i+1].Voie[1].detZ1F)+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer';
  if n=1 then s:=s+' le PN ' else s:=s+' les PNs ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;

  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxPN.selected[i-1] then
    begin

      for j:=i to nbrePN-1 do
      begin
        formconfig.ListBoxPN.selected[j-1]:=formconfig.ListBoxPN.selected[j];
        tablo_PN[j]:=tablo_PN[j+1];
      end;
      dec(nbrePN);
      i:=0;
    end;
    inc(i);                    
  until i>nbrePN;

  config_modifie:=true;
  FormConfig.ListBoxPN.Clear;
  raz_champs_PN;

  // r�afficher la liste
  for i:=1 to nbrePN do
  begin
    s:=encode_act_PN(i);
    FormConfig.ListBoxPN.items.Add(s);
  end;

  lignecliqueePN:=-1;
  AncLigneCliqueePN:=-1;
  ligneclicAct:=-1;
  AncligneclicAct:=-1;

  clicliste:=false;
end;

procedure TFormConfig.ButtonSupPNClick(Sender: TObject);
begin
  supprime_pn;
end;

// renvoie le nombre d'adresses occup�es par un signal
function nombre_adresses_signal(adr : integer) : integer;
var x,dec,nc,i,j : integer;
begin
  nc:=0;
  i:=index_Signal(adr);
  dec:=Signaux[i].decodeur;
  x:=Signaux[i].aspect;

  // signal directionnel
  if isDirectionnel(i) then
  begin
    nombre_adresses_signal:=x-10;
    exit;
  end;

  // nc=nombre d'adresses du signal
  if dec=0 then nc:=1;               // rien, occupe quand meme une adresse
  if dec=1 then nc:=14;              // digitalbahn
  if dec=2 then nc:=signaux[i].Na;   // cdf
  if dec=3 then nc:=8;               // ldt LS dec sncf
  if dec=4 then nc:=8;               // leb
  if dec=5 then nc:=Signaux[i].Na;   // digikeijs
  if dec=6 then                      // paco unisemaf
  begin
    x:=Signaux[index].Unisemaf;      // mod�le
    case x of
    2 : nc:=1;
    3,4 : nc:=2;
    51,52 : nc:=3;
    71 : nc:=2;
    72,73 : nc:=3;
    91,92 : nc:=3;
    93,94,95,96,97,98,99 : nc:=4;
    end;
  end;
  if dec=7 then nc:=Signaux[i].Na;   // SR
  if dec=8 then                      // arcomora
  begin
    case x of
    3 : nc:=3;
    4,5 : nc:=4;
    7 : nc:=5;
    9 : nc:=5;
    end;
  end;
  if dec=9 then nc:=2;               // LS-DEC-NMBS
  if dec=10 then nc:=Signaux[i].Na;  // Bmodels
  if dec=11 then nc:=Signaux[i].Na;  // LEA

  if dec>=NbDecodeurdeBase then
  begin
    j:=dec-NbDecodeurdeBase+1;
    nc:=decodeur_pers[j].NbreAdr;
  end;

  nombre_adresses_signal:=nc;
end;


procedure ajoute_signal;
var i,na,AdrMax : integer;
    s : string;
begin
  clicliste:=true;
  if NbreSignaux>=NbreMaxiSignaux then
  begin
    Affiche('Nombre maximal de signaux atteint',clRed);
    exit;
  end;

  with formconfig.ListBoxSig do
    for i:=0 to items.Count-1 do Selected[i]:=false;

  inc(NbreSignaux);

  AdrMax:=0;na:=0;
  for i:=1 to NbreSignaux do
  begin
    if AdrMax<Signaux[i].adresse then
    begin
      AdrMax:=Signaux[i].adresse;
    end;
  end;

  if AdrMax<>0 then na:=Nombre_adresses_signal(AdrMax);
  i:=NbreSignaux;
  if AdrMax+na>=MaxAcc then
  begin
    s:='L''adresse maximale de '+intToSTR(AdrMax)+' pour les signaux a �t� atteinte.'+#13+
       'Veuillez compacter la liste des signaux sur leurs adresses';
    Application.MessageBox(pchar(s),pchar('Erreur'), MB_Ok or MB_ICONERROR );
    exit;
  end;
  Signaux[i].Adresse:=AdrMax+na;
  if Signaux[i].Adresse=0 then Signaux[i].Adresse:=1;

  Signaux[i].Aspect:=3;
  Signaux[i].decodeur:=0;
  Signaux[i].verrouCarre:=false;
  Signaux[i].SR[1].sortie0:=1;
  Signaux[i].SR[1].sortie1:=6;
  Signaux[i].SR[2].sortie0:=2;
  Signaux[i].SR[2].sortie1:=3;
  Signaux[i].SR[3].sortie0:=9;
  Signaux[i].SR[3].sortie1:=10;
  Signaux[i].SR[4].sortie0:=4;
  Signaux[i].SR[4].sortie1:=5;
  Signaux[i].SR[5].sortie0:=7;
  Signaux[i].SR[5].sortie1:=8;
  Signaux[i].SR[6].sortie0:=0;
  Signaux[i].SR[6].sortie1:=0;
  Signaux[i].SR[7].sortie0:=16;
  Signaux[i].SR[7].sortie1:=18;
  Signaux[i].SR[8].sortie0:=19;
  Signaux[i].SR[8].sortie1:=0;
  Signaux[i].Na:=4;
  cree_image_signal(i);
  s:=encode_signal(i);

  // scroller � la fin et s�lectionner
  with formConfig.ListBoxSig do
  begin
    items.add(s);
    selected[i-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  formCOnfig.LabelInfo.caption:='';
  ligneClicSig:=i-1;
  AncligneClicSig:=ligneClicSig;
  aff_champs_signaux(i);
  clicliste:=false;
  Signal_sauve.Adresse:=0;
  config_modifie:=true;

  // encoder l'index
  tablo_index_signal[Signaux[i].Adresse]:=i;
end;

procedure TFormConfig.ButtonNouvSigClick(Sender: TObject);
begin
  ajoute_signal;
end;

procedure supprime_sig;
var n,i,j : integer;
    s,ss : string;
begin
  ss:='';
  n:=0;
  for i:=0 to NbreSignaux-1 do
  begin
    if formconfig.ListBoxSig.selected[i] then
    begin
      ss:=ss+ intToSTR(Signaux[i+1].adresse)+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer ';
  if n=1 then s:=s+' le signal ' else s:=s+' les signaux ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;
  raz_champs_sig;

  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxSig.selected[i-1] then
    begin
      Signal_supprime:=Signaux[i];  // sauvegarde le signal supprim�
      Signal_sauve.adresse:=0;       // d�valider sa d�finition

      FormConfig.ButtonInsSig.Caption:='Ajouter le signal '+intToSTR(Signaux[i].adresse)+' supprim�';

      // supprimer le signal i
      Affiche('Supprime signal '+intToSTR(Signaux[i].adresse),clOrange);

      formconfig.ListBoxSig.Items.Delete(i-1);

      Signaux[i].Img.free;  // supprime l'image, ce qui efface le signal du tableau graphique
      Signaux[i].Img:=nil;
      Signaux[i].Lbl.free;  // supprime le label
      Signaux[i].Lbl:=nil;
      Tablo_Index_Signal[Signaux[i].adresse]:=0;
      if Signaux[i].checkFB<>nil then
      begin
        Signaux[i].checkFB.Free;
        Signaux[i].CheckFB:=nil;
      end;  // supprime le check du feu blanc s'il existait

      for j:=i to NbreSignaux-1 do
      begin
        Signaux[j]:=Signaux[j+1];
        tablo_index_signal[signaux[j].adresse]:=j;
        if Signaux[j].img=nil then affiche('erreur',clred)
        else
          with Signaux[j].Img do
          begin
            Parent:=Formprinc.ScrollBoxSig;   // dire que l'image est dans la scrollBox1
            Top:=(HtImg+espY+20)*((j-1) div NbreImagePLigne);   // d�termine les points d'origine
            Left:=10+ (LargImg+5)*((j-1) mod (NbreImagePLigne));
            Name:='ImageSignal'+IntToSTR(Signaux[j].adresse);
            Maj_Hint_Signal(j);
          end;

        with Signaux[j].Lbl do
        begin
          Top:=HtImg+((HtImg+EspY+20)*((j-1) div NbreImagePLigne));
          Left:=10+ (LargImg+5)*((j-1) mod (NbreImagePLigne));
          caption:='@'+IntToSTR(Signaux[j].adresse);
        end;
        if Signaux[j].checkFB<>nil then
        with Signaux[j].CheckFB do
        begin
          Name:='CheckBoxFB'+intToSTR(Signaux[j].adresse);
          Hint:='Feu blanc';
          Top:=HtImg+15+((HtImg+EspY+20)*((j-1) div NbreImagePLigne));
          Left:=10+ (LargImg+5)*((j-1) mod (NbreImagePLigne));
        end;
      end;
      dec(NbreSignaux);
      i:=0;
    end;
    inc(i);
  until i>NbreSignaux;

  config_modifie:=true;
  FormConfig.ListBoxSig.Clear;

  // r�afficher la liste
  for i:=1 to NbreSignaux do
  begin
    s:=encode_signal(i);
    if s<>'' then
    begin
      FormConfig.ListBoxSig.items.Add(s);
    end;
  end;
  ligneClicSig:=-1;
  AncligneClicSig:=-1;

  // calcule les index - ne pas trier les signaux, il faudrait trier la fenetre graphique
  for i:=1 to NbreSignaux do
  begin
    tablo_index_signal[Signaux[i].adresse]:=i;
  end;

  clicliste:=false;

end;


procedure TFormConfig.ButtonSupSigClick(Sender: TObject);
begin
  Supprime_sig;
end;

// Ajouter le signal supprim�
procedure TFormConfig.ButtonInsSigClick(Sender: TObject);
var s : string;
begin
  if Signal_supprime.adresse<>0 then
  begin
    clicliste:=true;
    inc(NbreSignaux);
    Signaux[NbreSignaux]:=Signal_supprime;
    Tablo_Index_Signal[Signaux[NbreSignaux].adresse]:=NbreSignaux;   // index
    Signal_supprime.adresse:=0;  // d�valider le signal sauvegard�
    Signal_supprime.aspect:=0;
    cree_image_signal(NbreSignaux);
    config_modifie:=true;
    // r�afficher le rechedit
    s:=encode_signal(NbreSignaux);
    if s<>'' then
    begin
      with ListBoxSig.Items do
      begin
        ButtonInsSig.Caption:='Ajouter le signal supprim�';
        Add(s);
        ligneClicSig:=NbreSignaux-1;
        AncligneClicSig:=-1;
        SetFocus;
      end;
      aff_champs_signaux(NbreSignaux);
    end;
    clicListe:=false;
  end;
end;

// renvoie le num�ro de branche en d�faut
// si ok, renvoie 0
Function verif_extr_branches : integer;
var i,j,detect,erreur : integer;
    model,AncModel : Tequipement;
begin
  Erreur:=0;
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;
      AncModel:=model;
      model:=BrancheN[i][j].BType;
      if (j=1) and (model<>Aig) and (Model<>Buttoir) then
      begin
        Affiche('Erreur 3.1 branche '+intToSTR(i)+' : le premier �l�ment d''une branche doit �tre un buttoir ou un aiguillage',clred);
        erreur:=i;
      end;
      inc(j);
      until((model=rien) and (detect=0));
    if (Ancmodel<>Aig) and (AncModel<>Buttoir) then
    begin
      Affiche('Erreur 3.2 branche '+intToSTR(i)+' : le dernier �l�ment d''une branche doit �tre un buttoir ou un aiguillage',clred);
      erreur:=i;
    end;
  end;

  verif_extr_branches:=Erreur;
end;

//v�rifie si il n'y a pas de doublon dans l'adresse des trains
function verif_trains : boolean;
var i,j,adr : integer;
    nom : string;
begin
  result:=true;
  for i:=1 to nTrains do
  begin
    adr:=trains[i].adresse;
    nom:=trains[i].nom_train;
    for j:=i+1 to ntrains do
    begin
      if trains[j].Adresse=adr then
      begin
        Affiche('Les trains '+intToSTR(i)+' et '+intToSTR(j)+' ont la m�me adresse : '+intToSTR(adr),clred);
        result:=false;
      end;
      if trains[j].nom_train=nom then
      begin
        Affiche('Les trains '+intToSTR(i)+' et '+intToSTR(j)+' ont le m�me nom : '+nom,clred);
        result:=false;
      end;
    end;
  end;
end;


function verif_coherence : boolean;
var AncAdr,i,j,k,l,Indexaig,adr,adr2,extr,detect,condcarre,nc,index2,SuivAdr,indexTCO,AdrAig,
    x,y,extr2,adr3,adr4,index3,det1Br,det2Br,det1index,det2index,adresse,Adresse2,dec,nc2,op,
    delta,broft,adresse3 : integer;
    modAig,AncModel,model,km,SuivModel,model2,t1,t2: TEquipement;
    c : char;
    vitesse : longint;
    sort,OkSignal,ok,trouveSuiv,TrouvePrec,AdrOk,ok1,ok2,ok3,ok4 : boolean;
    s : string;
begin
  // validation des index signaux et d�tecteurs
  for i:=1 to NbreSignaux do
  begin
    tablo_index_signal[Signaux[i].adresse]:=i;
  end;
  for i:=1 to maxAiguillage do
  begin
    tablo_index_aiguillage[aiguillage[i].adresse]:=i;
  end;

  // v�rification de la coh�rence1
  // parcoure les branches jusqu'� trouver un aiguillage pour voir s'il a �t� d�crit
  ok:=true;
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;

      if (detect>NbMaxDet) and (detect<10000) then
      begin
        Affiche('Erreur 1: adresse d�tecteur trop grand: '+intToSTR(detect),clred);
        ok:=false;
      end;

      AncModel:=model;
      model:=BrancheN[i][j].BType;  // 1= d�tecteur  2= aiguillage  4=Buttoir

      if (model=aig) then
      begin
        //affiche('trouv� aig '+intToSTR(detect),clyellow);
        modAig:=aiguillage[Index_Aig(detect)].modele;
        if (modAig=rien) then
          begin
            Affiche('Erreur 2: Aiguillage '+intToStr(detect)+' non d�crit mais pr�sent en branche '+intToStr(i)+' pos. '+intToSTR(j),clred);
            ok:=false;
          end;
      end;
      j:=j+1;
    until((model=rien) and (detect=0));
    if (Ancmodel<>Aig) and (AncModel<>Buttoir) then
      Affiche('Erreur 3.2 branche '+intToSTR(i)+' : le dernier �l�ment d''une branche doit �tre un buttoir ou un aiguillage',clred);
  end;

  if verif_extr_branches<>0 then ok:=false;

  // v�rification de la coh�rence2
  // parcoure les aiguillages pour voir si les d�tecteurs sont en branches des d�tecteurs
  // et s'ils sont dans les branches
  // et les tjd pour voir si pb de coh�rence
  for Indexaig:=1 to maxaiguillage do
  begin
    modAig:=aiguillage[Indexaig].modele;
    // tjd ou tjs
    if ((modAig=tjd) and (aiguillage[Indexaig].EtatTJD=4)) or (modAig=tjs) then
    begin
      if aiguillage[Indexaig].Ddroit<>aiguillage[Indexaig].Ddevie then
      begin
        Affiche('Erreur 7: la TJD/S '+IntToStr(Indexaig)+' a des adresses de destination diff�rentes ('+intToSTR(aiguillage[Indexaig].Ddroit)+' et '+intToSTR(aiguillage[Indexaig].Ddevie)+')',clred);
        ok:=false;
      end;
      // v�rifier si son homologue est une tjd
      adr2:=aiguillage[Indexaig].Ddroit;
      if (aiguillage[Index_Aig(adr2)].modele<>tjd) and (aiguillage[Index_Aig(adr2)].modele<>tjs) then
      begin
        Affiche('Erreur 8: l''aiguillage '+intToStr(Adr2)+' n''est pas une TJD/S ou n''existe pas, mais apparait dans la TJD/S '+IntToSTR(aiguillage[Indexaig].Adresse),clred);
        ok:=false;
      end;
    end;

    // v�rifier si l'aiguillage est dans les branches
    if aiguillage[Indexaig].modele<>rien then
    begin
      trouve_aiguillage(aiguillage[Indexaig].adresse); // passe l'adresse de l'aiguillage � trouver
      if (IndexBranche_trouve=0) then
      begin
        Affiche('Erreur 6: aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' d�crit dans les aiguillages ; absent dans la description des branches',clRed);
        ok:=false;
      end;
    end;

    // exclure les TJD/S
    if (modAig<>tjd) and (modAig<>tjs) then
    begin
      // v�rifier si le d�tecteur sur la position droite est dans les branches
      adr:=aiguillage[Indexaig].Adroit;
      if (aiguillage[Indexaig].AdroitB='Z') or (aiguillage[Indexaig].AdroitB=#0) then
      begin
        trouve_detecteur(adr);
        if IndexBranche_trouve=0 then
        begin
          Affiche('Erreur 21.1: d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clred);
          ok:=false;
        end
        else
        begin
          AdrAig:=aiguillage[IndexAig].Adresse;
          if indexBranche_Trouve>1 then
          begin
            det1br:=brancheN[branche_trouve,indexBranche_trouve-1].Adresse; // adresse avant d�tecteur
            t1:=brancheN[branche_trouve,indexBranche_trouve-1].BType;
          end
          else det1br:=0;
          det2br:=brancheN[branche_trouve,indexBranche_trouve+1].Adresse; // adresse apr�s d�tecteur
          t2:=brancheN[branche_trouve,indexBranche_trouve+1].Btype;

          if (det1br<>AdrAig) and (t1=det) and (det2br<>AdrAig) and (t2=det) and (adr<>0) then
          begin
            Affiche('Erreur 21.2: Le d�tecteur '+intToSTR(adr)+' est d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais d�clar� dans la ',clred);
            s:='branche '+intToSTR(Branche_trouve)+' entre';
            if indexBranche_trouve>1 then
              if brancheN[branche_trouve,indexBranche_trouve-1].BType=aig then s:=s+' l''aiguillage ' else s:=s+' le d�tecteur ';
            s:=s+intToSTR(det1br)+' et ';
            if brancheN[branche_trouve,indexBranche_trouve+1].BType=aig then s:=s+' l''aiguillage ' else s:=s+' le d�tecteur ';
            s:=s+intToSTR(det2br);
            Affiche(s,clred);
            ok:=false;
          end;
        end;
      end;

    // v�rifier si le d�tecteur sur la position d�vi�e est dans les branches

      adr:=aiguillage[Indexaig].Adevie;
      if (aiguillage[Indexaig].AdevieB='Z') or (aiguillage[Indexaig].AdevieB=#0) then
      begin
        trouve_detecteur(adr);
        if IndexBranche_trouve=0 then
        begin
          Affiche('Erreur 22.1: d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clRed);
          ok:=false;
        end
        else
        begin
          AdrAig:=aiguillage[IndexAig].Adresse;
          //Affiche(intToSTR(adrAig),clred);

          delta:=0;
          if indexBranche_trouve>1 then
            repeat
              inc(delta);
            until (brancheN[branche_trouve,indexBranche_trouve-delta].BType<>act) or (indexBranche_trouve-delta=0); // pour passer un actionneur �ventuel
          if indexBranche_trouve-delta>0 then det1br:=brancheN[branche_trouve,indexBranche_trouve-delta].Adresse // adresse avant d�tecteur
          else det1br:=0;

          delta:=0;
          repeat
            inc(delta);
          until (brancheN[branche_trouve,indexBranche_trouve+delta].BType<>act); // pour passer un actionneur �ventuel
          det2br:=brancheN[branche_trouve,indexBranche_trouve+delta].Adresse; // adresse apr�s d�tecteur

          if (det1br<>AdrAig) and (det2br<>AdrAig) and (adr<>0) and (aiguillage[indexAig].visible) then
          begin
            Affiche('Erreur 22.2: Le d�tecteur '+intToSTR(adr)+' est d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais d�clar� dans la ',clred);
            s:='branche '+intToSTR(Branche_trouve)+' entre';
            if indexBranche_trouve>1 then
              if brancheN[branche_trouve,indexBranche_trouve-1].BType=aig then s:=s+' l''aiguillage ' else s:=s+' le d�tecteur ';
            s:=s+intToSTR(det1br)+' et ';
            if brancheN[branche_trouve,indexBranche_trouve+1].BType=aig then s:=s+' l''aiguillage ' else s:=s+' le d�tecteur ';
            s:=s+intToSTR(det2br);
            Affiche(s,clred);
            ok:=false;
          end;
        end;
      end;

      // v�rifier si le d�tecteur sur la pointe est dans les branches
      adr:=aiguillage[Indexaig].Apointe;
      if ( ((aiguillage[Indexaig].ApointeB='Z') or (aiguillage[Indexaig].ApointeB=#0)) and (aiguillage[Indexaig].modele=aig) ) then
      begin
        trouve_detecteur(adr);
        if IndexBranche_trouve=0 then
        begin
          Affiche('Erreur 23.1 : d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clRed);
          ok:=false;
        end
        else
        begin
          AdrAig:=aiguillage[IndexAig].Adresse;
          if indexBranche_trouve>1 then
          begin
            det1br:=brancheN[branche_trouve,indexBranche_trouve-1].Adresse; // adresse avant d�tecteur
            model:=brancheN[branche_trouve,indexBranche_trouve-1].Btype;
          end
          else begin det1br:=0;model:=det;end;

          det2br:=brancheN[branche_trouve,indexBranche_trouve+1].Adresse; // adresse apr�s d�tecteur
          model2:=brancheN[branche_trouve,indexBranche_trouve+1].Btype;
          if (det1br<>AdrAig) and (model=det) and (det2br<>AdrAig) and (model2=det) and (adr<>0) then
          begin
            Affiche('Erreur 23.2: Le d�tecteur '+intToSTR(adr)+' est d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais d�clar� dans la ',clred);
            s:='branche '+intToSTR(Branche_trouve)+' entre';
            if indexBranche_trouve>1 then
              if brancheN[branche_trouve,indexBranche_trouve-1].BType=aig then s:=s+' l''aiguillage ' else s:=s+' le d�tecteur ';
            s:=s+intToSTR(det1br)+' et ';
            if brancheN[branche_trouve,indexBranche_trouve+1].BType=aig then s:=s+' l''aiguillage ' else s:=s+' le d�tecteur ';
            s:=s+intToSTR(det2br);
            Affiche(s,clred);
            ok:=false;
          end;
        end;
      end;
      if (aiguillage[Indexaig].modele=triple) then // aiguillage triple
      begin
        if (aiguillage[Indexaig].Adevie2B='Z') or (aiguillage[Indexaig].Adevie2B=#0)  then
        begin
          adr:=aiguillage[Indexaig].Adevie2;
          trouve_detecteur(adr);
          if IndexBranche_trouve=0 then
          begin
            Affiche('Erreur 5 : d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aiguillage[Indexaig].adresse)+' mais absent dans la description des branches',clRed);
            ok:=false;
          end;
        end;
      end;
    end;
  end;

  // coh�rence 3 : v�rifie si aiguillage triple ok et si doublon aiguillage
  // si on rencontre un aiguilage triple v�rifier que c'est son adresse de base en branches
  for Indexaig:=1 to maxaiguillage do
  begin
    adr:=aiguillage[Indexaig].Adresse;
    if aiguillage[Indexaig].modele=triple then
    begin
      adr2:=aiguillage[Indexaig].AdrTriple;
      trouve_element(adr2,aig,0,false);  // pas d'affichage d'erreur si non trouv�
      if branche_trouve<>0 then
      begin
        Affiche('Erreur 6.0: La designation de l''aiguillage triple '+intToSTR(adr)+' doit se faire par son adresse de base',clred);
        Affiche('et non par son adresse secondaire ('+intToSTR(adr2)+') en branche '+intToSTR(branche_trouve),clred);
        ok:=false;
      end;

      if aiguillage[Indexaig].AdrTriple=0 then
      begin
        Affiche('Erreur 6.1: 2�me adresse de l''aiguillage triple '+intToSTR(adr)+' non d�finie',clred);
        ok:=false;
      end;
    end;


    for i:=Indexaig+1 to maxaiguillage do
    begin
      if adr=aiguillage[i].Adresse then
      begin
        affiche('Erreur 6.2: aiguillage '+intToSTR(adr)+' d�fini deux fois',clred);
        ok:=false;
      end;
    end;
  end;

  // coh�rence 4 : v�rifie si doublon signal ou si recouvrement avec un autre signal ou un aiguillage
  for j:=1 to NbreSignaux do
  begin
    adr:=Signaux[j].Adresse;
    nc:=nombre_adresses_signal(adr);

    for i:=1 to maxaiguillage do
    begin
      adr2:=aiguillage[i].Adresse;
      if ((adr2>=adr) and (adr2<=adr+nc-1)) then
      begin
        affiche('Erreur 7.1 : signal '+intToSTR(adr)+' ('+intToSTR(nc)+' adresses) et aiguillage '+intToSTR(adr2)+' se chevauchent',clred);
        ok:=false;
      end;
    end;

    for i:=j+1 to NbreSignaux do
    begin
      adr2:=Signaux[i].Adresse;
      nc2:=nombre_adresses_signal(adr2);
      if ((adr>adr2)      and (adr     <adr2+nc2-1)) or
         ((adr+nc-1>adr2) and (adr+nc-1<adr2+nc2-1))
      then
      begin
        affiche('Erreur 7.2 : signaux '+intToSTR(adr)+' ('+intToSTR(nc)+' adresses) et '+intToStr(adr2)+' ('+intToSTR(nc2)+' adresses) se chevauchent',clred);
        ok:=false;
      end;
    end;
  end;

  // coh�rence 5 ; v�rifie si aiguillages d�finis en condition suppl�mentaires de carr� existent
  // v�rifie aussi le d�codeur digikeijs
  for j:=1 to NbreSignaux do
  begin
    l:=1;
    nc:=Signaux[j].decodeur;
    if nc=5 then // digikeijs
    begin
      if Signaux[j].Na=0 then
      begin
        Affiche('Erreur 9.3 : signal '+intToSTR(Signaux[j].adresse)+' : Le nombre d''adresses du d�codeur digiKeijs est nul',clred);
        ok:=false;
      end;
    end;
    if (nc=2) and not(isDirectionnel(j)) then // cdf
    begin
      if Signaux[j].Na=0 then
      begin
        Affiche('Erreur 9.4 : signal '+intToSTR(Signaux[j].adresse)+' : Le nombre d''adresses du d�codeur CDF est nul',clred);
        ok:=false;
      end;
    end;
    repeat
      nc:=Length(Signaux[j].condcarre[l])-1 ;
      for k:=1 to nc do
      begin
        adr:=Signaux[j].condcarre[l][k].Adresse; // adresse de l'aiguillage
        if index_aig(adr)=0 then
        begin
          Affiche('Avertissement : Aig '+intToSTR(adr)+' d�fini dans les cond de carr� du signal '+intToSTR(Signaux[j].adresse)+' mais non existant',clOrange);
          ok:=false;
        end;
      end;
      inc(l);
    until (nc<=0) or (l>6);
  end;

  // coh�rence 6 : v�rifier si les d�tecteurs et les aiguillages associ�s aux signaux existent
  for j:=1 to NbreSignaux do
  begin
    i:=Signaux[j].Adr_det1;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.1: D�tecteur '+intToSTR(i)+' non existant dans les branches mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
      end;
    end
    else
    begin
      if not(isDirectionnel(j)) then
      begin
        ok:=false;
        Affiche('Erreur 8.2: D�tecteur inconnu ('+intToSTR(i)+') sur signal '+IntToSTR(Signaux[j].adresse),clred);
      end;
    end;

    i:=Signaux[j].Adr_det2;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.3: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
      end;
    end;

    i:=Signaux[j].Adr_det3;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.4: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
      end;
    end;

    i:=Signaux[j].Adr_det4;
    if i<>0 then
    begin
      trouve_detecteur(i);
      if IndexBranche_trouve=0 then
      begin
        ok:=false;
        Affiche('Erreur 8.5: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
      end;
    end;

    // �lement suivant 1
    i:=Signaux[j].Adr_el_suiv1;
    km:=Signaux[j].Btype_suiv1;
    if (i=0) and not(isDirectionnel(j)) then
    begin
      Affiche('Erreur 9.0: D�tecteur '+intToSTR(i)+' nul associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
      ok:=false;
    end;
    if i<>0 then
    begin
      if km=det then   // d�tecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.1: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end
        else
        begin
          // v�rifier si les deux d�tecteurs du signal sont contig�s (l et i)
          l:=Signaux[j].Adr_det1;
          trouve_detecteur(i);
          det1Br:=branche_trouve;
          det1Index:=IndexBranche_trouve;

          trouve_detecteur(l);
          det2Br:=branche_trouve;
          det2Index:=IndexBranche_trouve;

          if det1Index>det2Index then echange(det1Index,det2Index);
          delta:=1;
          k:=1;
          repeat
            t1:=brancheN[det1Br,det1Index+k].BType;
            if t1<>act then inc(delta);
            inc(k);
          until t1<>act;

          if (det1Br<>Det2Br) or (abs(det1Index-det2Index)>delta) then
          begin
            ok:=false;
            Affiche('Erreur 9.12: signal '+intToSTR(Signaux[j].adresse)+' : d�tecteurs '+intToSTR(i)+' et '+intToSTR(l)+' non contig�s ',clred);
          end;
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        k:=index_aig(i);
        if k=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.20: aiguillage '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end
        else
        begin
          // v�rifier si le d�tecteur du signal et l'aiguillage sont cons�cutifs
          l:=Signaux[j].Adr_det1;
          km:=aiguillage[k].modele;
          if km=aig then
          begin
            if (aiguillage[k].ADroit<>l) and (aiguillage[k].ADevie<>l) and (aiguillage[k].APointe<>l) then
            begin
              ok:=false;
              Affiche('Erreur 9.21: signal '+intToSTR(Signaux[j].adresse)+' : aiguillage '+intToSTR(i)+' et d�tecteur '+intToSTR(l)+' non contig�s ',clred);
            end;
          end;
          if (km=crois) or (km=tjs) or (km=tjd) then
          begin
            if (aiguillage[k].ADroit<>l) and (aiguillage[k].ADevie<>l) and (aiguillage[k].Ddroit<>l) and (aiguillage[k].Ddevie<>l) then
            begin
              ok:=false;
              Affiche('Erreur 9.22: signal '+intToSTR(Signaux[j].adresse)+' : aiguillage '+intToSTR(i)+' et d�tecteur '+intToSTR(l)+' non contig�s ',clred);
            end;
          end;
          if km=triple then
          begin
            if (aiguillage[k].Adevie2<>l) and (aiguillage[k].ADroit<>l) and (aiguillage[k].ADevie<>l) and (aiguillage[k].APointe<>l) then
            begin
              ok:=false;
              Affiche('Erreur 9.23: signal '+intToSTR(Signaux[j].adresse)+' : aiguillage '+intToSTR(i)+' et d�tecteur '+intToSTR(l)+' non contig�s ',clred);
            end;
          end;
        end;
      end;
    end;

    // �lement suivant 2
    i:=Signaux[j].Adr_el_suiv2;
    km:=Signaux[j].Btype_suiv2;
    if i<>0 then
    begin
      if km=det then   // d�tecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.3: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.4: aiguillage '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end;  
      end;
    end;

    // �lement suivant 3
    i:=Signaux[j].Adr_el_suiv3;
    km:=Signaux[j].Btype_suiv3;
    if i<>0 then
    begin
      if km=det then   // d�tecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.5: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.6: aiguillage '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end;
      end;
    end;

    // �lement suivant 4
    i:=Signaux[j].Adr_el_suiv4;
    km:=Signaux[j].Btype_suiv4;
    if i<>0 then
    begin
      if km=det then   // d�tecteur
      begin
        trouve_detecteur(i);
        if IndexBranche_trouve=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.7: D�tecteur '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end;
      end;
      if ((km=aig) or (km=tjs) or (km=tjd) or (km=triple)) then
      begin
        // aiguillage
        if index_aig(i)=0 then
        begin
          ok:=false;
          Affiche('Erreur 9.10: aiguillage '+intToSTR(i)+' non existant mais associ� au signal '+IntToSTR(Signaux[j].adresse),clred);
        end;
      end;
    end;
  end;

  // coh�rence 7
  // parcoure les aiguillages pour voir si les aiguillages d�clar�s aux extr�mit�s sont existants
  // et qu'ils ne pointent pas sur eux m�mes
  for Indexaig:=1 to maxaiguillage do
  //indexaig:=index_aig(93);
  begin
    adr:=aiguillage[indexaig].Adresse;
    model:=aiguillage[indexaig].modele;

    if adr>NbMaxDet then
    begin
      Affiche('Erreur 9.11: adresse aiguillage trop grand: '+intToSTR(adr),clred);
      ok:=false;
    end;

    // on ne v�rifie pas les tjd tjs crois
    //if (model<>tjd) and (model<>tjd) and (model<>crois) then
    begin

      adr2:=aiguillage[indexaig].ADroit;    // adresse de ce qui est connect� sur la position droite
      c:=aiguillage[indexaig].AdroitB;
      if (c='D') or (c='S') or (c='P') then
      begin
        if adr2=adr then affiche('Erreur 10.0 : la position droite de l''aiguillage '+intToSTR(adr)+' pointe sur elle m�me',clred);
        index2:=Index_aig(adr2);            // adresse de l'aiguillage connect�
        model2:=aiguillage[index2].modele;  // mod�le de l'aiguillage connect�

        begin
          // tjs ou tjs � 2 �tats ou croisement
          if ( ((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=2) ) or (model2=crois) then
          begin
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index2].DDevie) and (adr<>aiguillage[index2].Ddroit) then
            begin
              Affiche('Erreur 10.21: Discordance de d�claration aiguillages '+intToSTR(adr)+': '+intToSTR(adr2),clred);
              ok:=false;
            end;
          end;

          // tjs ou tjs � 4 �tats
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=4)) then
          begin
            adr3:=aiguillage[index2].Ddroit;  // 2eme adresse de la TJD
            index3:=index_aig(adr3);
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index3].ADevie) and (adr<>aiguillage[index3].Adroit) then
            begin
              Affiche('Erreur 10.22: Discordance de d�claration aiguillages  '+intToSTR(adr)+': '+intToSTR(adr2),clred);
              ok:=false;
            end;
          end;

          if (model2=aig) or (model2=triple) then
          begin
            if c='D' then
            begin
              extr:=aiguillage[index2].ADroit;
              if adr<>extr then
              begin
                Affiche('Erreur 10.23: Discordance de d�claration aiguillages '+intToSTR(adr)+'D: '+intToSTR(adr2)+'D diff�rent de '+intToSTR(extr),clred);
                ok:=false;
              end;
            end;
            if c='S' then
            begin
              extr:=aiguillage[index2].ADevie;
              if adr<>extr then
              begin
                Affiche('Erreur 10.24: Discordance de d�claration aiguillages '+intToSTR(adr)+'D: '+intToSTR(adr2)+'S diff�rent de '+intToSTR(extr),clred);
                ok:=false;
              end;
            end;
            if c='P' then
            begin
              extr:=aiguillage[index2].APointe;
              if adr<>extr then
              begin
                Affiche('Erreur 10.25: Discordance de d�claration aiguillages '+intToSTR(adr)+'D: '+intToSTR(adr2)+'P diff�rent de '+intToSTR(extr),clred);
                ok:=false;
              end;
            end;
          end;
        end;
      end;

      adr2:=aiguillage[indexaig].Adevie;  // adresse de ce qui est connect� sur la position d�vi�e
      c:=aiguillage[indexaig].AdevieB;
      if (c='D') or (c='S') or (c='P') then
      begin
        if adr2=adr then affiche('Erreur 10.1 : la position d�vi�e de l''aiguillage '+intToSTR(adr)+' pointe sur elle m�me',clred);
        index2:=Index_aig(adr2);            // adresse de l'aiguillage connect�
        model2:=aiguillage[index2].modele;  // mod�le de l'aiguillage connect�
        if index2=0 then
        begin
          ok:=false;
          Affiche('Erreur 10.30: aiguillage '+intToSTR(adr)+': d�claration d''un aiguillage '+IntToSTR(adr2)+' inexistant',clred);
        end
        else
        begin
          // tjs ou tjs � 2 �tats ou croisement
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=2)) or (model2=crois) then
          begin
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index2].DDevie) and (adr<>aiguillage[index2].Ddroit) then
            begin
              Affiche('Erreur 10.31: Discordance de d�claration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred);
              ok:=false;
            end;
          end;

          // tjs ou tjs � 4 �tats
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=4)) then
          begin
            adr3:=aiguillage[index2].Ddroit;  // 2eme adresse de la TJD
            index3:=index_aig(adr3);
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index3].ADevie) and (adr<>aiguillage[index3].Adroit) then
            begin
              Affiche('Erreur 10.32: Discordance de d�claration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred);
              ok:=false;
            end;
          end;

          if (model2=aig) or (model2=triple) then
          begin
            if c='D' then
            begin
              extr:=aiguillage[index2].ADroit;
              if adr<>extr then Affiche('Erreur 10.33: Discordance de d�claration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'D diff�rent de '+intToSTR(extr),clred);
            end;
            if c='S' then
            begin
              extr:=aiguillage[index2].ADevie;
              if adr<>extr then Affiche('Erreur 10.34: Discordance de d�claration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'S diff�rent de '+intToSTR(extr),clred);
            end;
            if c='P' then
            begin
              extr:=aiguillage[index2].APointe;
              if adr<>extr then Affiche('Erreur 10.35: Discordance de d�claration aiguillages '+intToSTR(adr)+'S: '+intToSTR(adr2)+'P diff�rent de '+intToSTR(extr),clred);
            end;
          end;
        end;
      end;

      adr2:=aiguillage[indexaig].APointe;  // adresse de ce qui est connect� sur la pointe
      c:=aiguillage[indexaig].ApointeB;
      if (c='D') or (c='S') or (c='P') then
      begin
        if adr2=adr then affiche('Erreur 10.2 : la pointe de l''aiguillage '+intToSTR(adr)+' pointe sur elle m�me',clred);
        index2:=Index_aig(adr2);            // adresse de l'aiguillage connect�
        model2:=aiguillage[index2].modele;  // mod�le de l'aiguillage connect�
        begin
          // tjs ou tjs � 2 �tats ou croisement
          if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=2)) or (model2=crois) then
          begin
            if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
               (adr<>aiguillage[index2].DDevie) and (adr<>aiguillage[index2].Ddroit) then
            begin
              Affiche('Erreur 10.41: Discordance de d�claration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred);
              ok:=false;
            end;

            // tjs ou tjs � 4 �tats
            if (((model2=tjs) or (model2=tjd)) and (aiguillage[index2].EtatTJD=4)) then
            begin
              adr3:=aiguillage[index2].Ddroit;  // 2eme adresse de la TJD
              index3:=index_aig(adr3);
              if (adr<>aiguillage[index2].Adevie) and (adr<>aiguillage[index2].ADroit) and
                 (adr<>aiguillage[index3].ADevie) and (adr<>aiguillage[index3].Adroit) then
              begin
                Affiche('Erreur 10.42: Discordance de d�claration aiguillage '+intToSTR(adr)+': '+intToSTR(adr2),clred);
                ok:=false;
              end;
            end;

            if (model2=aig) or (model2=triple) then
            begin
              if c='D' then
              begin
                extr:=aiguillage[index2].ADroit;
                if adr<>extr then Affiche('Erreur 10.43: Discordance de d�claration aiguillages '+intToSTR(adr)+'P: '+intToSTR(adr2)+'D diff�rent de '+intToSTR(extr),clred);
              end;
              if c='S' then
              begin
                extr:=aiguillage[index2].ADevie;
                if adr<>extr then Affiche('Erreur 10.44: Discordance de d�claration aiguillages '+intToSTR(adr)+'P: '+intToSTR(adr2)+'S diff�rent de '+intToSTR(extr),clred);
              end;
              if c='P' then
              begin
                extr:=aiguillage[index2].APointe;
                if adr<>extr then Affiche('Erreur 10.45: Discordance de d�claration aiguillages '+intToSTR(adr)+'P: '+intToSTR(adr2)+'P diff�rent de '+intToSTR(extr),clred);
              end;
            end; 
          end;  
        end;
      end;
    end;
  end;

  // coh�rence 8
  // parcoure les branches pour voir si les aiguillages aux extr�mit�s sont coh�rentes avec leurs d�clarations
  // probl�me : un aiguillage peut �tre a plusieurs endroits dans les branches
  {
  for i:=1 to NbreBranches do
  begin
    j:=1;  // on v�rifie entre j-1 et j+1
    detect:=BrancheN[i][1].Adresse;
    model:=BrancheN[i][1].BType;
    repeat
      AncAdr:=detect;AncModel:=model;
      detect:=BrancheN[i][j].Adresse;
      SuivAdr:=BrancheN[i][j+1].Adresse;
      SuivModel:=BrancheN[i][j+1].Btype;
      model:=BrancheN[i][j].BType;
      trouvePrec:=false;

      if (model=aig) then
      begin
        k:=index_aig(detect);
        // comparer au pr�c�dent
        if k<>0 then
        begin
          if j=1 then trouvePrec:=true;
          if (j>1) and (ancModel<>act) then
          begin
            if aiguillage[k].modele=Aig then
            begin
              if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
              if aiguillage[k].APointe=AncAdr then trouvePrec:=true;
            end;
            if aiguillage[k].modele=crois then
            begin
              if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
              if aiguillage[k].Ddroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].Ddevie=AncAdr then trouvePrec:=true;
            end;
            if aiguillage[k].modele=triple then
            begin
              if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
              if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
              if aiguillage[k].Adevie2=AncAdr then trouvePrec:=true;
            end;
            if (aiguillage[k].modele=Tjd) or (aiguillage[k].modele=TjS) then
            begin
              if aiguillage[k].EtatTJD=2 then
              begin
                if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
                if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
                if aiguillage[k].Ddroit=AncAdr then trouvePrec:=true;
                if aiguillage[k].Ddevie=AncAdr then trouvePrec:=true;
              end;
              if aiguillage[k].EtatTJD=4 then
              begin
                l:=index_aig(aiguillage[k].Ddroit); // 2eme adresse de la TJD
                if aiguillage[k].ADroit=AncAdr then trouvePrec:=true;
                if aiguillage[k].ADevie=AncAdr then trouvePrec:=true;
                if aiguillage[k].Ddroit=AncAdr then trouvePrec:=true;
                if aiguillage[l].Adroit=AncAdr then trouvePrec:=true;
                if aiguillage[l].Adevie=AncAdr then trouvePrec:=true;
                if aiguillage[l].Ddevie=AncAdr then trouvePrec:=true;
              end;
            end;

            if not(trouvePrec) then
            begin
              Affiche('Erreur 11: La description de l''aiguillage '+intToSTR(detect)+' ne correspond pas � son �l�ment contigu ('+intToStr(AncAdr)+') en branche '+intToSTR(i),clred);
              ok:=false;
            end;
          end;

          TrouveSuiv:=false;
          // comparer au suivant
          if (SuivModel<>rien) and (SuivModel<>act) then
          begin
            if aiguillage[k].modele=Aig then
            begin
              if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].APointe=SuivAdr then trouveSuiv:=true;
            end;
            if aiguillage[k].modele=Triple then
            begin
              if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].APointe=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].ADevie2=SuivAdr then trouveSuiv:=true;
            end;
            if (aiguillage[k].modele=Tjd) or (aiguillage[k].modele=TjS) then
            begin
              if aiguillage[k].EtatTJD=2 then
              begin
                if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
                if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
                if aiguillage[k].Ddroit=SuivAdr then trouveSuiv:=true;
                if aiguillage[k].Ddevie=SuivAdr then trouveSuiv:=true;
              end;
              if aiguillage[k].EtatTJD=4 then
              begin
                l:=index_aig(aiguillage[k].Ddroit); // 2eme adresse de la TJD
                if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
                if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
                if aiguillage[k].Ddroit=SuivAdr then trouveSuiv:=true;
                if aiguillage[l].Adroit=SuivAdr then trouveSuiv:=true;
                if aiguillage[l].Adevie=SuivAdr then trouveSuiv:=true;
                if aiguillage[l].Ddevie=SuivAdr then trouveSuiv:=true;
              end;
            end;
            if aiguillage[k].modele=crois then
            begin
              if aiguillage[k].ADroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].ADevie=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].Ddroit=SuivAdr then trouveSuiv:=true;
              if aiguillage[k].Ddevie=SuivAdr then trouveSuiv:=true;
            end;

            if not(trouveSuiv) then
            begin
              Affiche('Erreur 12: La description de l''aiguillage '+intToSTR(detect)+' ne correspond pas � son �l�ment contigu ('+intToStr(SuivAdr)+') en branche '+intToSTR(i),clred);
              ok:=false;
            end;
          end;
        end;
      end;
      inc(j);
    until((model=rien) and (detect=0)) ;
  end;
  }

  // 9. v�rifier les d�tecteurs s'ils apparaissent plusieurs fois
  for i:=1 to NDetecteurs do
  begin
    l:=0;  // compteur d�tecteur
    for j:=1 to NbreBranches do
    begin
      detect:=Adresse_detecteur[i];

      k:=1;
      repeat
        sort:=false;
        adr:=BrancheN[j,k].Adresse;
        Model:=BrancheN[j,k].BType;
        if ((adr=0) and (model=rien)) then sort:=true;
        inc(k);
        sort:=sort or ((adr=detect) and (model=det));
      until (sort);

      if adr=detect then inc(l);
    end;
    if l>1 then
    begin
      Affiche('Erreur 13: Le d�tecteur '+intToSTR(detect)+' appara�t '+intToSTR(l)+' fois dans les branches',clred);
      ok:=false;
    end;
  end;

  // 10. v�rifier la coh�rence TCO
  for indexTCO:=1 to NbreTCO do
  begin
    begin
      for y:=1 to NbreCellY[indexTCO] do
        for x:=1 to NbreCellX[indexTCO] do
        begin
          i:=TCO[indexTCO,x,y].BImage;
          adr:=TCO[indexTCO,x,y].adresse;
          if i=Id_signal then
          begin
            if index_Signal(adr)=0 then
            begin
              Affiche('Un signal '+IntToSTR(adr)+' est d�clar� dans le TCO'+intToSTR(indexTCO)+' ['+intToSTR(x)+','+intToSTR(y)+'] mais absent de la configuration',clred);
              ok:=false;
            end;
          end;
          if (i=21) or (i=22)  or (i=23) or (i=25) then
          begin
            if (adr<>0) and (tco[indexTCO,x,y].pont<>0) then
            begin
              Affiche('Erreur 48 TCO'+intToSTR(indexTCO)+' ['+intToSTR(x)+','+intToSTR(y)+'] d''adresse '+intToSTR(Adr)+' d�crite comme un croisement ou TJD/S car elle pr�sente une adresse',clred);
              Affiche('mais la cellule repr�sente un pont',clred);
             ok:=false;
            end;
          end;

          if IsAigTJDCroiTCO(i) then
          begin
            adr:=TCO[indexTCO,x,y].adresse;
            if (index_aig(adr)=0) and (adr<>0) then
            begin
              Affiche('Un aiguillage '+IntToSTR(adr)+' est d�clar� dans le TCO'+intToSTR(indexTCO)+' ['+intToSTR(x)+','+intToSTR(y)+'] mais absent de la configuration',clred);
              ok:=false;
            end;
          end;
          // �l�ment de voie lin�aire
          if (i=1) or (i=6) or (i=7) or (i=8) or (i=9) or (i=10) or (i=11) or (i=16) or (i=17) or (i=18) or (i=19) or (i=20) then
          begin
            adr:=TCO[indexTCO,x,y].adresse;
            if adr<>0 then
            begin
              j:=1;
              repeat
                trouveSuiv:=adr=Adresse_detecteur[j];
                inc(j);
              until (j>NDetecteurs) or trouveSuiv;
              if not(trouveSuiv) then
              begin
                Affiche('Un d�tecteur '+IntToSTR(adr)+' est d�clar� dans le TCO '+intToSTR(indexTCO)+' ['+intToSTR(x)+','+intToSTR(y)+'] mais absent de la configuration',clred);
                ok:=false;
              end;
            end;
          end;
          if not(verif_cellule(indexTCO,x,y,i)) then
          begin
            Affiche('TCO: Erreur de proximit� composants incompatibles: cellules TCO'+intToSTR(indexTCO)+' ['+intToSTR(x)+','+intToSTR(y)+'] ',clred);
            ok:=false;
          end;
        end;
    end;
  end;

  // v�rifier la coh�rence des TJD 4 �tats avec les branches
  for Indexaig:=1 to maxaiguillage do
  //indexaig:=index_aig(93);
  begin
    adr:=aiguillage[indexaig].Adresse;
    model:=aiguillage[indexaig].modele;

    // TJD 4 �tats
    if (model=tjd) or (model=tjs) and (aiguillage[indexAig].EtatTJD=4) then
    begin
      // ne pas tester si la TJD est la derni�re exemple : A25,529,A26,A28 : ne pas tester la 28
      l:=1;  // offset branche commence la recherche en 1
      j:=0;  // offset dans branche
      adresse:=aiguillage[indexAig].ADroit;    // �lements de la tjd
      adresse2:=aiguillage[indexAig].ADevie;
      adresse3:=aiguillage[indexAig].Ddroit;    // homologue
      Adrok:=false;
      Branche_trouve:=0;
      repeat
        j:=1;
        repeat
          k:=branche_trouve;  // ancien
          trouve_element_V1(adr,tjd,l,0,j,false,1);    // indexs de la tjd dans les branches , it=1 permet de ne pas rechercher la tjs homologue ce qui fausserait le r�sultat
          if branche_trouve<>0 then
          begin
            // il faut trouver adresse et adresse2 � gauche ou � droite le la TJD dans les branches

            // trouver si les �l�ments de connexion de la tjd sont les m�mes dans les branches

            // v�rifie si l'�l�m�nt Adroit (port0, NO), Adevie (port1, SO)  de la TJD est ok dans la branche en d�cr�ment
            if indexBranche_Trouve>1 then
            begin
              k:=BrancheN[Branche_trouve,indexBranche_Trouve-1].Adresse;   // �l�ment pr�c�dent
              ok1:=(k=adresse) or (k=adresse2) or (k=adresse3);
              Adrok:=Adrok or ok1;
            end;

            // pour la recherche en +, incr�menter l'indexbranche jusqu'� trouve un non actionneur
            // v�rifie si l'�l�m�nt Adroit (port0, NO) de la TJD est ok dans la branche en incr�ment
            ok2:=true;
            repeat
              sort:=BrancheN[Branche_trouve,indexBranche_Trouve+1].BType<>act;
              if not(sort) then inc(IndexBranche_trouve);
              if sort then
              begin
                k:=BrancheN[Branche_trouve,indexBranche_Trouve+1].Adresse;
                ok2:=(k=adresse) or (k=adresse2) or (k=adresse3);
                Adrok:=Adrok or ok2;
              end;
            until sort;

            if not(adrOK) then Affiche('La TJD '+intToSTR(adr)+' d�crite n''est pas coh�rente test 1 : branche '+intToSTR(Branche_trouve)+' '+
                      intToSTR(brancheN[Branche_trouve,indexBranche_Trouve+1].Adresse)+' diff�rent de '+intToSTR(adresse),clred);

            if indexBranche_Trouve>1 then Adrok:=Adrok or (BrancheN[Branche_trouve,indexBranche_Trouve-1].Adresse=adresse2);

            {
            repeat
              sort:=BrancheN[Branche_trouve,indexBranche_Trouve+1].BType<>act;
              if not(sort) then inc(IndexBranche_trouve);
              if sort then
                Adrok:=Adrok or (BrancheN[Branche_trouve,indexBranche_Trouve+1].Adresse=adresse2) ;
            until sort;
            }
            if not(Adrok) then
            begin
              Affiche('La TJD '+intToSTR(adr)+' d�crite n''est pas coh�rente avec les �lements contigus dans la branche '+intToSTR(Branche_trouve)+' :',clred);
              s:='TJD extr�mit�s -> '+intToSTR(adresse)+','+intToSTR(adresse2)+' mais trouv� ';
              extr:=BrancheN[Branche_trouve,indexBranche_Trouve-1].Adresse;
              if extr<>0 then s:=s+intToSTR(extr);
              extr:=BrancheN[Branche_trouve,indexBranche_Trouve+1].Adresse;
              if extr<>0 then s:=s+' '+intToSTR(extr);
              s:=s+' dans la branche '+intToSTR(Branche_trouve);
              Affiche(s,clred);
              ok:=false;
            end;
            j:=IndexBranche_trouve+1;
            l:=branche_trouve;
          end;
        until (branche_trouve=0) ;
        l:=Branche_trouve+1;
      until (Branche_trouve=0);
    end;
  end;

  // 10 trains
  if not(verif_trains) then ok:=false;

  // 11 Divers
  i:=pos(':',portcom);j:=pos(',',portcom);
  val(copy(portcom,i+1,j-i),vitesse,l);
  if (protocole=2) and (vitesse<>115200) then Affiche('La vitesse COM/USB en procotole DCC++ doit �tre de 115200 bauds',clred);

  // si xpressnet, pas d'accesoires interf�rant avec les d�tecteurs
  AdrOk:=True;
  if Verif_AdrXpressNet=1 then
  begin

    for i:=1 to maxaiguillage do
    begin
      adresse:=aiguillage[i].Adresse ;

      for k:=1 to NDetecteurs do
      begin
        adr:=((adresse_detecteur[k]-1) div 2) +1;   // transforme l'adresse du d�tecteur en accessoire (ex 513 devient 257)

        if adresse=adr then
        begin
          AdrOk:=false;
          ok:=false;
          Affiche('Erreur 13: l''aiguillage '+IntToSTR(adresse)+' chevauche le d�tecteur '+intToSTR(adresse_detecteur[k]),clred);
        end;
      end;
    end;

    for i:=1 to NbreSignaux do
    begin
      okSignal:=true;
      s:='';
      adresse:=Signaux[i].Adresse;
      nc:=Nombre_adresses_signal(adresse);

      for k:=1 to NDetecteurs do
      begin
        adr:=((adresse_detecteur[k]-1) div 2) +1;   // transforme l'adresse du d�tecteur en accessoire (ex 513 devient 257)

        //if (adresse=adr) or ((adresse+nc-1>=adr) and (adresse+nc<=adr)) then
        if (adr>=adresse) and (adr<=adresse+nc-1) then
        begin
          dec:=Signaux[i].decodeur;
          AdrOk:=false;
          ok:=false;
          okSignal:=false;
          s:=s+intToSTR(adresse_detecteur[k])+' ';
        end;
      end;

      if not(oksignal) then
      begin
        Affiche('Erreur 14: le signal '+IntToSTR(adresse)+' '+decodeur[dec]+' occupe '+intToSTR(nc)+' adresses de '+intToSTR(adresse)+
         ' � '+intToSTR(adresse+nc-1)+' et chevauche le(s) d�tecteur(s) ',clred);
        affiche(s,clred);
      end;
    end;

    // actions
    for i:=1 to maxTablo_act do
    begin
      for op:=1 to Tablo_Action[i].NbOperations do
      begin
        if Tablo_Action[i].tabloOp[op].numoperation=ActionAccessoire then
        begin
          adresse:=Tablo_Action[i].tabloOp[op].adresse;
          for k:=1 to NDetecteurs do
          begin
            adr:=((adresse_detecteur[k]-1) div 2) +1;   // transforme l'adresse du d�tecteur en accessoire (ex 513 devient 257)

            if (adresse=adr) then
            begin
              AdrOk:=false;
              ok:=false;
              Affiche('Erreur 15: l''action '+IntToSTR(Tablo_Action[i].adresse)+' enclenche l''accessoire '+intToSTR(adresse),clred);
              Affiche('et chevauche le d�tecteur '+intToStr(adresse_detecteur[k])+' interdit en XpressNet',clred);
            end;
          end;

          if Tablo_Action[i].tabloop[op].NumOperation=ActionCdePeriph then
          begin
            j:=Tablo_Action[i].tabloOp[op].periph;
            if j>10 then begin Affiche('Erreur 15.1 pilotage action '+intToSTR(Tablo_Action[i].adresse),clred);ok:=false;end;
            if j=0 then begin Affiche('Erreur 15.2 L''action '+intToSTR(Tablo_Action[i].adresse)+' n''a pas d''accessoire COM/USB d''affect�',clRed);ok:=false;end;
            if (j>0) and (j<11) and (Tablo_periph[j].NumCom=0) then
            begin
              Affiche('Erreur 15.3 L''action '+intToSTR(Tablo_Action[i].adresse)+' n''a pas d''accessoire COM/USB d''affect�',clRed);
              ok:=false;
            end;
          end;
        end;
      end;
    end;

    if not(AdrOk) then
    begin
      j:=MessageDlg('Une adresse ou des adresses DCC via XpressNet interf�re avec des d�tecteurs.'+#13+
                    'Si vous n''utilisez pas XpressNet, vous devez choisir d''ignorer cette erreur.'+#13+#13+
                    'Voulez vous ignorer cette erreur � l''avenir? ',mtConfirmation,[mbNo,mbYes],0) ;
      if j=mrYes then
      begin
        Verif_AdrXpressNet:=0;
        sauve_config;
      end;
    end;
  end;

  // actionneurs
  for i:=1 to maxTablo_act do
  begin
    for op:=1 to Tablo_Action[i].NbOperations do
    begin
      if Tablo_Action[i].TabloOp[op].numoperation=ActionCdePeriph then
      begin
        adresse:=Tablo_Action[i].TabloOp[op].periph;
        if adresse>NbPeriph then
        begin
          Affiche('Erreur 18 : l''action '+Tablo_Action[i].NomAction+' est li�e � un p�riph�rique n�'+intToSTR(adresse)+' COM/USB/Socket inexistant',clred);
          ok:=false;
        end;
      end;
    end;

    if Tablo_Action[i].declencheur=DeclZoneDet then  // si actionneur de zone
    begin
      adresse:=Tablo_Action[i].Adresse;
      adresse2:=Tablo_Action[i].Adresse2;
      //Affiche('Det_contigu '+intToSTR(adresse)+' '+intToSTR(adresse2),clred);
      det_contigu(adresse,adresse2,suivant,SuivModel);
      if (suivant=0) or (suivant>9995) then
      begin
        ok:=false;
        s:='Erreur 19: l''action '+IntToSTR(Tablo_Action[i].adresse)+' est enclench�e par les d�tecteurs '+intToSTR(adresse)+' ' +intToSTR(adresse2)+' qui ne sont pas contigus';
        Affiche(s,clred);
      end;
    end;
  end;

  // PN
  for i:=1 to NbrePN do
  begin
    if tablo_pn[i].TypeCde=1 then  // par com USB
    begin
      adresse:=tablo_pn[i].AdresseFerme;  //num�ro de p�riph�rique
      if adresse>NbPeriph then
      begin
        Affiche('Erreur 20 : le PN n�'+intToSTR(i)+' est li� � un p�riph�rique n�'+intToSTR(adresse)+' COM/USB/Socket inexistant',clred);
        ok:=false;
      end;
    end;
  end;

  // v�rification des compatibilit�s des d�codeurs de signaux et des aspects
  if not(verif_dec_sig(true)) then ok:=false;

  // v�rifie dans les branches si on a pas de doublon de d�tecteur
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;
      model:=BrancheN[i][j].BType;  // 1= d�tecteur  2= aiguillage  4=Buttoir

      if model=det then
      begin
        k:=j+1;
        repeat
           if BrancheN[i][k].Btype=det then
           begin
             l:=BrancheN[i][k].Adresse;
             if detect=l then
             begin
               Affiche('Erreur 20 : d�tecteur '+intToSTR(detect)+' d�fini plusieurs fois en branche '+intToSTR(i),clred);
               ok:=false;
             end;
           end;
           inc(k);
        until (BrancheN[i,k].BType=rien) and (BrancheN[i,k].Adresse=0);
      end;
      j:=j+1;
    until((model=rien) and (detect=0));
  end;

  // v�rifier si les signaux peuvent afficher un carr�
  for j:=1 to NbreSignaux do
  begin
    adr:=Signaux[j].Adresse;
    nc:=signaux[j].aspect;
    if (signaux[j].Btype_suiv1=aig) then
    begin
      adr2:=signaux[j].Adr_el_suiv1; // adresse de l'aiguillage
      adr3:=signaux[j].Adr_det1;     // adresse d�tecteur
      IndexAig:=Index_aig(adr2);
      // si le d�tecteur se trouve sur une position d�vi�e ou droite de l'aiguillage
      if ((aiguillage[IndexAig].ADevie=adr3) or (aiguillage[IndexAig].ADroit=adr3)) and (nc=3) then
      begin
        Affiche('Le signal '+intToSTR(adr)+' devrait comporter au moins 4 feux pour afficher un carr� car',clOrange);
        Affiche('il est positionn� avant l''aiguillage '+intToSTR(adr2)+' pris en talon',clOrange);
      end;
    end;
  end;

  verif_coherence:=ok;
end;

procedure ajoute_aiguillage;
var i : integer;
    s : string;
begin
  if MaxAiguillage>=NbreMaxiAiguillages then
  begin
    Affiche('Nombre maximal d''aiguillages atteint',clRed);
    exit;
  end;
  clicliste:=true;

  // d�s�lectionne tous les �l�ments de la list box
  with formconfig.ListBoxAig do
    for i:=0 to items.Count-1 do Selected[i]:=false;

  inc(MaxAiguillage);
  i:=MaxAiguillage;
  aiguillage[i].Adresse:=999;
  aiguillage[i].modele:=aig;
  aiguillage[i].AdroitB:='Z'; aiguillage[i].AdevieB:='Z';
  aiguillage[i].DdroitB:='D'; aiguillage[i].DdevieB:='S'; // pr�paration pour TJD/S
  aiguillage[i].EtatTJD:=4;
  aiguillage[i].ApointeB:='Z';
  aiguillage[i].Adevie2B:='Z';
  aiguillage[i].tjsintB:='D';
  aiguillage[i].AdrTrain:=0;
  aiguillage[i].posInit:=const_inconnu;
  aiguillage[i].Temps:=5;
  aiguillage[i].position:=const_inconnu;
  aiguillage[i].InversionCDM:=0;
  aiguillage[i].vitesse:=0;
  aiguillage[i].visible:=true;

  // encoder l'index
  tablo_index_aiguillage[aiguillage[i].Adresse]:=i;

  s:=encode_Aig(i);
  // scroller � la fin et s�lectionner
  with formconfig.ListBoxAig do
  begin
    items.add(s);
    selected[i-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  formconfig.LabelInfo.caption:='Aiguillage '+intToSTR(aiguillage[i].Adresse)+' cr��';
  ligneClicAig:=i-1;
  AncligneClicAig:=ligneClicAig;
  Aff_champs_aig_tablo(i);
  clicliste:=false;
  config_modifie:=true;
  Aig_sauve.Adresse:=0;
end;

procedure TFormConfig.ButtonNouvAigClick(Sender: TObject);
begin
  Ajoute_aiguillage;
end;


// supprime le ou les aiguillages s�lectionn�s dans le richEdit
procedure supprime_aig;
var n,i,j,AdrTri : integer;
    s,ss : string;
    trouve : boolean;
begin
  ss:='';
  n:=0;
  for i:=0 to MaxAiguillage-1 do
  begin
    if formconfig.ListBoxAig.selected[i] then
    begin
      // si triple, supprimer aussi l'homologue
      if Aiguillage[i+1].modele=triple then
      begin
        AdrTri:=aiguillage[i+1].Adrtriple;
        j:=0;
        repeat
          trouve:=Aiguillage[j+1].Adresse=adrTri;
          if trouve then
          begin
            formconfig.ListBoxAig.selected[j]:=true;
            //ss:=ss+intToSTR(adrTri)+' ';
          end;
          inc(j);
        until (j>MaxAiguillage-1) or trouve;
      end;
      inc(n);
    end;
  end;

  for i:=0 to MaxAiguillage-1 do
  begin
    if formconfig.ListBoxAig.selected[i] then ss:=ss+ intToSTR(aiguillage[i+1].adresse)+' ';
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer ';
  if n=1 then s:=s+' l''aiguillage ' else s:=s+' les aiguillages ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;
  raz_champs_aig;
  Aig_sauve.adresse:=0;             // d�valider sa d�finition
  Formconfig.editAdrAig.text:='';   // annule l'adresse, ce qui �vite le plantage quand on clique sur un champ de l'aiguillage


  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxAig.selected[i-1] then
    begin
      Affiche('Supprime aiguillage '+intToSTR(aiguillage[i].Adresse),clOrange);
      Aig_supprime:=aiguillage[i]; // sauve l'aiguillage supprim�
      FormConfig.ButtonAjSup.Caption:='Ajouter l''aig '+intToSTR(aiguillage[i].adresse)+' supprim�';

      for j:=i to MaxAiguillage-1 do
      begin
        formconfig.ListBoxAig.selected[j-1]:=formconfig.ListBoxAig.selected[j];
        Aiguillage[j]:=Aiguillage[j+1];
        tablo_index_aiguillage[aiguillage[j].Adresse]:=j;
      end;
      dec(MaxAiguillage);
      i:=0;
    end;
    inc(i);
  until i>maxaiguillage;

  config_modifie:=true;
  FormConfig.ListBoxAig.Clear;

  // r�afficher la liste
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_Aig(i);
    if s<>'' then
    begin
      FormConfig.ListBoxAig.items.Add(s);
    end;
  end;
  trier_aig; // recalcule les index
  ligneClicAig:=-1;
  AncligneClicAig:=-1;
  clicliste:=false;
end;

procedure TFormConfig.BoutSupAigClick(Sender: TObject);
begin
  Supprime_aig;
end;

procedure adresse_p1;
var AdrAig,adr,erreur,index,adr2 : integer;
    b,c : char;
    model: Tequipement;
    s : string;
begin
  if affevt then affiche('Evt change P1',clyellow);
  if clicliste or (ligneclicAig<0) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneClicAig];
    Val(s,adrAig,erreur);

    //v�rifier la syntaxe
    s:=EditP1.text;
    if RightStr(s,1)<>'D' then
    begin
      val(s,adr,erreur);
      clicListe:=true;
      if erreur=0 then s:=intToSTR(adr)+'D'
      else
      begin
        delete(s,length(s),1);
        s:=s+'D';
      end;
      editP1.text:=s;
      clicListe:=false;
    end;

    decodeAig(s,adr,B);
    if (B='D') and (adr<>0) then
    begin
      LabelInfo.caption:='';
      Index:=Index_Aig(AdrAig);
      model:=aiguillage[Index].modele;

      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';

      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP2.Text:=IntToSTR(adr)+c;

      // existe, v�rifier si c'est bien une TJD/S
      if (model=tjd) or (model=tjs) then
      begin
        if model=tjd then labelInfo.Caption:='Mise � jour de la TJD '+IntToSTR(adr);
        if model=tjs then labelInfo.Caption:='Mise � jour de la TJS '+IntToSTR(adr);
        aiguillage[Index].modele:=model;
        adr2:=aiguillage[index].adresse; // adresse avant modif
        tablo_index_aiguillage[adr2]:=0; // supprimer l'index de l'ancienne adresse

        aiguillage[index].adresse:=adr;     // met la nouvelle adresse � jour
        tablo_index_aiguillage[adr]:=index;
        s:=encode_aig(index);
        formconfig.ListBoxAig.items[index-1]:=s;

        adr2:=aiguillage[index].dDroit;   // adresse de la tjd homologue
        index:=tablo_index_aiguillage[adr2];
        if index<>0 then
        begin
          aiguillage[index].DDroit:=adr;   // mettre la nouvelle adresse dans la tjd/s homologue
          aiguillage[index].DDevie:=adr;
          s:=encode_aig(index);
          formconfig.ListBoxAig.items[index-1]:=s;
        end;
      end;
    end
      else
        LabelInfo.caption:='Erreur P1 TJD/S '+intToSTR(AdrAig);
    end;
  clicliste:=false;
end;


procedure adresse_p2;
var AdrAig,adr,adr2,erreur,index : integer;
    b,c : char;
    model: Tequipement;
    s : string;
begin
  if affevt then affiche('Evt change P2',clyellow);
  if clicliste or (ligneclicAig<0) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneClicAig];
    Val(s,adrAig,erreur);

    //v�rifier la syntaxe
    s:=EditP2.text;
    if RightStr(s,1)<>'S' then
    begin
      val(s,adr,erreur);
      clicListe:=true;
      if erreur=0 then s:=intToSTR(adr)+'S'
      else
      begin
        delete(s,length(s),1);
        s:=s+'S';
      end;
      editP2.text:=s;
      clicListe:=false;
    end;

    decodeAig(s,adr,B);
    if (B='S') and (adr<>0) then
    begin
      LabelInfo.caption:='';
      Index:=Index_Aig(AdrAig);
      model:=aiguillage[Index].modele;

      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';

      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP1.Text:=IntToSTR(adr)+c;

      // existe, v�rifier si c'est bien une TJD/S
      if (model=tjd) or (model=tjs) then
      begin
        if model=tjd then labelInfo.Caption:='Mise � jour de la TJD '+IntToSTR(adr);
        if model=tjs then labelInfo.Caption:='Mise � jour de la TJS '+IntToSTR(adr);
        aiguillage[Index].modele:=model;
        adr2:=aiguillage[index].adresse; // adresse avant modif
        tablo_index_aiguillage[adr2]:=0; // supprimer l'index de l'ancienne adresse

        aiguillage[index].adresse:=adr;     // met la nouvelle adresse � jour
        tablo_index_aiguillage[adr]:=index;
        s:=encode_aig(index);
        formconfig.ListBoxAig.items[index-1]:=s;

        adr2:=aiguillage[index].dDroit;   // adresse de la tjd homologue
        index:=tablo_index_aiguillage[adr2];
        if index<>0 then
        begin
          aiguillage[index].DDroit:=adr;   // mettre la nouvelle adresse dans la tjd/s homologue
          aiguillage[index].DDevie:=adr;
          s:=encode_aig(index);
          formconfig.ListBoxAig.items[index-1]:=s;
        end;
      end;
    end
      else
        LabelInfo.caption:='Erreur P1 TJD/S '+intToSTR(AdrAig);
    end;
  clicliste:=false;
end;

procedure adresse_p3;
var AdrAig,adr,erreur,index,adr2 : integer;
    b,c : char;
    model: Tequipement;
    s : string;
begin
  if affevt then affiche('Evt change P3',clyellow);
  if clicliste or (ligneclicAig<0) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneClicAig];
    Val(s,adrAig,erreur);

    //v�rifier la syntaxe
    s:=EditP3.text;
    if RightStr(s,1)<>'S' then
    begin
      val(s,adr,erreur);
      clicListe:=true;
      if erreur=0 then s:=intToSTR(adr)+'S'
      else
      begin
        delete(s,length(s),1);
        s:=s+'S';
      end;
      editP3.text:=s;
      clicListe:=false;
    end;

    decodeAig(s,adr,B);
    if (B='S') and (adr<>0) then
    begin
      LabelInfo.caption:='';
      Index:=Index_Aig(AdrAig);
      model:=aiguillage[Index].modele;

      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';

      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP4.Text:=IntToSTR(adr)+c;

      adr2:=aiguillage[index].Ddroit;  // 'ancienne' adresse avant �crasement
      aiguillage[index].Ddroit:=adr;
      //aiguillage[index].DdroitB:=B;
      aiguillage[index].Ddevie:=adr;
      aiguillage[index].DdevieB:=c;

      s:=encode_aig(index);
      formconfig.ListBoxAig.items[ligneClicAig]:=s;

      // index avant changement
      index:=index_aig(Adr2);

      if index=0 then    // si elle n'existe pas la cr�er
      begin
        // cr�er homologue
        if model=tjd then labelInfo.Caption:='Cr�ation de la TJD homologue '+IntToSTR(adr);
        if model=tjs then labelInfo.Caption:='Cr�ation de la TJS homologue '+IntToSTR(adr);

        inc(MaxAiguillage);
        index:=MaxAiguillage;
        aiguillage[index].Adresse:=Adr;
        tablo_index_aiguillage[adr]:=index;
        aiguillage[Index].modele:=model;
        aiguillage[Index].Adroit:=0;
        aiguillage[Index].AdroitB:='D';
        aiguillage[Index].Adevie:=0;
        aiguillage[Index].AdevieB:='D';
        aiguillage[Index].Ddroit:=adrAig;
        aiguillage[Index].DdroitB:='D';
        aiguillage[Index].Ddevie:=adrAig;
        aiguillage[Index].DdevieB:='S';
        aiguillage[Index].APointeB:='Z';
        aiguillage[Index].tjsINTB:='S';

        s:=encode_aig(index);
        formconfig.ListBoxAig.items.add(s);
        // scroller � la fin
        ListBoxAig.SetFocus;    // g�n�re evt adresse_p4 donc clicListe doit �tre � false
      end  // fin de la cr�ation
      else
      begin
        // si l'ancienne adresse = la nouvelle, on a rien chang�, sortir absolument sinon on va remetre l'index � 0
        if adr=adr2 then begin clicListe:=false;exit;end;
        model:=aiguillage[Index].modele;
        // existe, v�rifier si c'est bien une TJD/S
        if (model=tjd) or (model=tjs) then
        begin
          if model=tjd then labelInfo.Caption:='Mise � jour de la TJD homologue '+IntToSTR(adr);
          if model=tjs then labelInfo.Caption:='Mise � jour de la TJS homologue '+IntToSTR(adr);
          aiguillage[Index].modele:=model;
          aiguillage[index].adresse:=adr;
          tablo_index_aiguillage[adr]:=index;
          tablo_index_aiguillage[adr2]:=0;   // raz l'ancien index
          s:=encode_aig(index);
          formconfig.ListBoxAig.items[index-1]:=s;
        end;
      end;
    end
      else
        LabelInfo.caption:='Erreur P3 TJD '+intToSTR(AdrAig);
    end;
  clicliste:=false;
end;

procedure adresse_p4;
var AdrAig,adr,erreur,index,adr2 : integer;
    b,c : char;
    model: Tequipement;
    s : string;
begin
  if affevt then affiche('Evt change P4',clyellow);
  if clicliste or (ligneclicAig<0) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=formconfig.ListBoxAig.items[ligneClicAig];
    Val(s,adrAig,erreur);

    //v�rifier la syntaxe
    s:=EditP4.text;
    if RightStr(s,1)<>'D' then
    begin
      val(s,adr,erreur);
      clicListe:=true;
      if erreur=0 then s:=intToSTR(adr)+'D'
      else
      begin
        delete(s,length(s),1);
        s:=s+'D';
      end;
      editP4.text:=s;
      clicListe:=false;
    end;

    decodeAig(s,adr,B);
    if (B='D') and (adr<>0) then
    begin
      LabelInfo.caption:='';
      Index:=Index_Aig(AdrAig);
      model:=aiguillage[Index].modele;

      Aiguillage[index].modifie:=true;
      LabelInfo.caption:='';
      // modifier la base de donn�es de l'aiguillage
      if b=#0 then b:='Z';

      clicliste:=true;
      if B='D' then c:='S';
      if B='S' then c:='D';
      EditP3.Text:=IntToSTR(adr)+c;

      adr2:=aiguillage[index].Ddroit;  // 'ancienne' adresse avant �crasement
      aiguillage[index].Ddroit:=adr;
      //aiguillage[index].DdroitB:=B;
      aiguillage[index].Ddevie:=adr;
      aiguillage[index].DdevieB:=c;

      s:=encode_aig(index);
      formconfig.ListBoxAig.items[ligneClicAig]:=s;

      // index de l'ancienne adresse
      index:=index_aig(Adr2);

      if index=0 then    // si elle n'existe pas la cr�er
      begin
        // cr�er homologue
        if model=tjd then labelInfo.Caption:='Cr�ation de la TJD homologue '+IntToSTR(adr);
        if model=tjs then labelInfo.Caption:='Cr�ation de la TJS homologue '+IntToSTR(adr);

        inc(MaxAiguillage);
        index:=MaxAiguillage;
        aiguillage[index].Adresse:=Adr;
        tablo_index_aiguillage[adr]:=index;
        aiguillage[Index].modele:=model;
        aiguillage[Index].Adroit:=0;
        aiguillage[Index].AdroitB:='D';
        aiguillage[Index].Adevie:=0;
        aiguillage[Index].AdevieB:='D';
        aiguillage[Index].Ddroit:=adrAig;
        aiguillage[Index].DdroitB:='D';
        aiguillage[Index].Ddevie:=adrAig;
        aiguillage[Index].DdevieB:='S';
        aiguillage[Index].APointeB:='Z';
        aiguillage[Index].tjsINTB:='S';

        s:=encode_aig(index);
        formconfig.ListBoxAig.items.add(s);
        // scroller � la fin
        ListBoxAig.SetFocus;    // g�n�re evt adresse_p4 donc clicListe doit �tre � false
      end  // fin de la cr�ation
      else
      begin
        // si l'ancienne adresse = la nouvelle, on a rien chang�, sortir absolument sinon on va remetre l'index � 0
        if adr=adr2 then begin clicListe:=false;exit;end;
        model:=aiguillage[Index].modele;
        // existe, v�rifier si c'est bien une TJD/S
        if (model=tjd) or (model=tjs) then
        begin
          if model=tjd then labelInfo.Caption:='Mise � jour de la TJD homologue '+IntToSTR(adr);
          if model=tjs then labelInfo.Caption:='Mise � jour de la TJS homologue '+IntToSTR(adr);

          aiguillage[index].adresse:=adr;
          tablo_index_aiguillage[adr]:=index;
          tablo_index_aiguillage[adr2]:=0;   // supprimer l'ancien index
          s:=encode_aig(index);
          formconfig.ListBoxAig.items[index-1]:=s;
        end;
      end;
    end
      else
        LabelInfo.caption:='Erreur P4 TJD '+intToSTR(AdrAig);
    end;
  clicliste:=false;
end;

procedure TFormConfig.EditP1KeyPress(Sender: TObject; var Key: Char);
begin
  if clicliste or (ligneclicAig<0) or (ord(Key)<>VK_RETURN) then exit;
  adresse_p1;
end;

procedure TFormConfig.EditP2KeyPress(Sender: TObject; var Key: Char);
begin
  if clicliste or (ligneclicAig<0) or (ord(Key)<>VK_RETURN) then exit;
  adresse_p2;
end;

procedure TFormConfig.EditP3Exit(Sender: TObject);
begin
  adresse_p3;
end;

procedure TFormConfig.EditP4Exit(Sender: TObject);
begin
  adresse_p4;
end;

procedure TFormConfig.EditP3KeyPress(Sender: TObject; var Key: Char);
begin
  if clicliste or (ligneclicAig<0) or (ord(Key)<>VK_RETURN) then exit;
  adresse_P3;
end;


procedure TFormConfig.EditP4KeyPress(Sender: TObject; var Key: Char);
begin
  if clicliste or (ligneclicAig<0) or (ord(Key)<>VK_RETURN) then exit;
  adresse_p4;
end;

procedure TFormConfig.ButtonAjSupClick(Sender: TObject);
var s : string;
begin
  if Aig_supprime.adresse<>0 then
  begin
    inc(MaxAiguillage);
    aiguillage[MaxAiguillage]:=Aig_supprime;
    Tablo_Index_aiguillage[aiguillage[maxAiguillage].adresse]:=maxAiguillage;   // index
    Aig_Supprime.adresse:=0;  // d�valider l'aiguillage sauvegard�
    Aig_Supprime.modele:=rien;
    clicListe:=true;
    config_modifie:=true;

    // r�afficher les rechedit et scroller � la fin
    s:=encode_Aig(MaxAiguillage);  // ligne de l'aiguillage
    if s<>'' then
    with ListBoxAig do
    begin
      ButtonAjSup.Caption:='Ajouter l''aig supprim�';
      ligneClicAig:=MaxAiguillage-1;
      AncligneClicAig:=-1;
      ListBoxAig.items.Add(s);
      SetFocus;
      //Selstart:=ListBoxAig.GetTextLen-1;
      Perform(EM_SCROLLCARET,0,0);
    end;
    Aff_champs_aig_tablo(MaxAiguillage);
  end;
  clicListe:=false;
end;

procedure TFormConfig.ButtonRestaureAigClick(Sender: TObject);
var index : integer;
begin
  if ligneclicAig<0 then exit;
  if (Aig_sauve.adresse<>0) and (ligneclicAig>=0) then
  begin
    clicListe:=true;
    index:=ligneclicAig+1;    
    Aiguillage[index]:=Aig_sauve;
    ListBoxAig.items[ligneclicAig]:=encode_Aig(index);
    aff_champs_Aig_tablo(index);  // r�affiche les champs 
    clicListe:=false;
  end;
end;

procedure TFormConfig.ComboBoxAigChange(Sender: TObject);
var s: string;
    i,i2 : integer;
begin
  if clicListe then exit;
  if MaxAiguillage<ligneclicAig+1 then exit;
  if ligneclicAig<0 then exit;
  if affevt then Affiche('Evt ComboBox Aiguillage',clOrange);
  i:=ligneclicAig+1;
  case ComboBoxAig.ItemIndex of
  0 : aiguillage[i].modele:=aig;
  1 : aiguillage[i].modele:=tjd;
  2 : aiguillage[i].modele:=tjs;
  3 : aiguillage[i].modele:=triple;
  4 : aiguillage[i].modele:=crois;
  else aiguillage[i].modele:=rien;
  end;

  clicListe:=true;

  if (aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs) then
  begin
    if not(radioButtonTJD2.Checked) and not(radioButtonTJD4.Checked) then radioButtonTJD2.Checked:=true;
    if (aiguillage[i].tjsIntB<>'S') and (aiguillage[i].tjsIntB<>'D') then aiguillage[i].tjsIntB:='D';
    if aiguillage[i].EtatTJD=4 then
    begin
      // si la tjd homologue existe, changer son type aussi
      i2:=aiguillage[i].dDroit;
      i2:=tablo_index_aiguillage[i2];  // index tjd homologue
      if i2<>0 then
      begin
        LabelInfo.Caption:='Mise � jour TJD/S homologue';
        aiguillage[i2].modele:=aiguillage[i].modele;  // type vers homologue
        s:=encode_aig(i2);
        formconfig.ListBoxAig.items[i2-1]:=s;
      end;
    end;
  end;

  if aiguillage[i].modele=crois then LabelCrois.Visible:=true else LabelCrois.Visible:=false;

  s:=encode_aig(i);
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
  formconfig.ListBoxAig.selected[ligneclicAig]:=true;
  Aff_champs_aig_tablo(i);
  clicliste:=false;
end;

procedure valide_branches;
var s: string;
    ligne,esp : integer;
    ok : boolean;
begin
  ligne:=1;
  ok:=true;
  repeat
    s:=AnsiUpperCase(formConfig.RichBranche.Lines[ligne-1]);
    if s<>'' then
    begin
      // supprime les espaces �ventuels
      repeat
        esp:=pos(' ',s);
        if esp<>0 then delete(s,esp,1);
      until esp=0;
      if s<>'' then
      begin
        formConfig.RichBranche.Lines[ligne-1]:=s;
        branche[ligne]:=s;  // stocker la ligne dans la branche pour la compiler
        if compile_branche(s,ligne) then
        begin
          {$IF CompilerVersion < 28.0}
          RE_ColorLine(FormConfig.RichBranche,Ligne-1,ClLime);
          {$IFEND}
        end
        else
        begin
          RE_ColorLine(FormConfig.RichBranche,Ligne-1,ClRed);
          ok:=false;
        end;
        inc(ligne);
      end
    else FormConfig.RichBranche.Lines.Delete(ligne-1);
  end
  else FormConfig.RichBranche.Lines.Delete(ligne-1);

  until (ligne>FormConfig.RichBranche.Lines.count) or (ligne>=MaxBranches);
  NbreBranches:=ligne-1;
  if ligne>=MaxBranches then Affiche('Nombre maximal de branches atteint',clRed);

  ligne:=verif_extr_branches;
  if ligne<>0 then
  begin
    ok:=false;
    RE_ColorLine(FormConfig.RichBranche,Ligne-1,ClRed);
  end;

  if ok then
  begin
    FormConfig.labelResult.Caption:='Syntaxe correcte';
    config_modifie:=true;
    modif_branches:=false;
  end
    else FormConfig.labelResult.Caption:='Erreur de syntaxe';
end;

procedure TFormConfig.ButtonValLigneClick(Sender: TObject);
begin
  valide_branches;
end;

function virgule_suiv(sl : string;o : integer) : integer;
var k : integer;
begin
  o:=o+1;
  for k:=o to length(sl) do
  begin
   // Affiche(sl[k],clGreen);
    if sl[k]=',' then begin result:=k;exit;end;
  end;
  result:=0;
end;

// trouve l'enregistrement suivant apr�s l'offset dans une branche
// en sortie : trouve_enregistrement= nouvel offset, enregistrement
// si 0 en sortie: fin de ligne
function trouve_enregistrement_suiv(num_branche : integer;offset : integer) : integer;
var j : integer;
    ss : string;
begin
  j:=virgule_suiv(branche[Num_Branche],offset);    // pointe sur la virgule suivante
  if j<>0 then ss:=copy(branche[Num_Branche],offset,j-offset) // champ suivant
        else ss:=copy(branche[Num_Branche],offset,length(branche[Num_Branche])-offset+1); // si j=0 c'est la fin de la cha�ne
  enregistrement:=ss;
  if j=0 then result:=0 else result:=j+1;
end;

// compile une branche de r�seau sous forme de texte, et la stocke dans le tableau des branches
// cr�e les index dans la structure d�tecteurs et des aiguillages
// i = index de la branche � stocker
function compile_branche(s : string;i : integer) : boolean;
var offset,j,bd,detect,erreur,adresse,erreur2 : integer;
    c : char;
    trouve,code : boolean;
    se : string;
begin
   j:=1;offset:=1;
   code:=true;
   // la boucle repeat parcoure la ligne s
   repeat
     BrancheN[i,j].adresse:=0; // pr�parer le suivant � 0
     offset:=trouve_enregistrement_suiv(i,offset) ;
     if enregistrement='' then
     begin
       Affiche('Erreur ligne '+s,clred);
       compile_branche:=false;
       exit;
     end;
     se:=enregistrement;
     // d�coder l'enregistrement
     // si c'est un d�tecteur, fini trouv�
     Val(enregistrement,detect,erreur);      // d�termine si le champ est num�rique ou pas  (cad si aiguillage)
     // il y a un aiguillage   ou un espace apr�s le champ....en fin de ligne
     if erreur<>0 then
     begin
       c:=enregistrement[1];
       delete(enregistrement,1,1);

       if c='A' then
       begin
         Val(enregistrement,adresse,erreur2);
         if (adresse=0) or (erreur2<>0) then
         begin
           Affiche('Erreur 17 champ '+se+' ligne '+s,clred);
           code:=false;
         end;
         if adresse>NbMaxDet then
         begin
           Affiche('Erreur 18 ligne '+s+' : adresse aiguillage trop grand: '+intToSTR(adresse),clred);
           adresse:=NbMaxDet;
           code:=false;
         end;
         BrancheN[i,j].adresse:=adresse;
         BrancheN[i,j].btype:=aig; // ident aiguillage
       end
       else

       if c='T' then
       begin
         Val(enregistrement,adresse,erreur2);
         if (adresse=0) or (erreur2<>0) then
         begin
           Affiche('Erreur 19 champ '+se+' ligne '+s,clred);
           code:=false;
         end;
         if adresse>max_actionneurs then
         begin
           Affiche('Erreur 20 ligne '+s+' : adresse actionneur trop grand: '+intToSTR(adresse),clred);
           adresse:=NbMaxDet;
           code:=false;
         end;
         BrancheN[i,j].adresse:=adresse;
         BrancheN[i,j].btype:=act; // ident actionneur
         actionneur[adresse].NumBranche:=i;
         actionneur[adresse].IndexBranche:=j;
       end
       else

       begin
         Affiche('Erreur 21 champ '+se+' ligne '+s,clred);
         code:=false;
         erreur:=0; // forcer erreur � 0 pour obliger � passer sur un d�tecteur
       end;
     end;

     // d�tecteur
     if erreur=0 then
     begin
       if (detect>NbMaxDet) and (detect<10000) then
       begin
         Affiche('Erreur 22 ligne '+s+' : adresse d�tecteur trop grand: '+intToSTR(detect),clred);
         detect:=NbMaxDet;
         code:=false;
       end;
       BrancheN[i,j].adresse:=detect;      // adresse
       BrancheN[i,j].btype:=det;           // ident d�tecteur
       detecteur[detect].NumBranche:=i;    // detecteur[] est index� par le d�tecteur
       detecteur[detect].IndexBranche:=j;
       detecteur[detect].canton1:=0;
       detecteur[detect].canton2:=0;

       if (detect=0) then
       begin
         inc(Nbuttoirs);
         BrancheN[i,j].btype:=buttoir;
       end;

       // v�rifier si le d�tecteur est d�ja stock�
       bd:=0;
       repeat
         inc(bd);
         if bd>NbMaxDet then
         begin
           Affiche('Nombre maximal de d�tecteurs d�pass� ('+IntToSTR(NbMaxDet)+')',clred);
           code:=false;
         end
         else
           trouve:=Adresse_detecteur[bd]=detect;
       until ((bd=NDetecteurs+1) or trouve) or (bd>NbMaxDet) ;
       if not(trouve) then
       begin
         Adresse_detecteur[bd]:=detect;
         NDetecteurs:=bd;
       end;
     end;
     inc(j);

     BrancheN[i,j].adresse:=0; // pr�parer le suivant � 0
     BrancheN[i,j].BType:=rien;
     //Affiche('branche '+intToSTR(i)+' index='+intToStr(j),clGreen);
   until (offset=0) or (j>=MaxElBranches);
   if j=2 then
   begin
     Affiche('Branche '+IntToSTR(i)+' : Une branche doit contenir au moins deux �l�ments',clred);
     code:=false;
   end;
   if (j>=MaxElBranches) then Affiche('Nombre maximal d''�lements dans une branche atteint',clred);
   compile_branche:=code;
end;

procedure TFormConfig.RichBrancheMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,curseur,lc : integer;
begin
  if clicListe then exit;
  clicListe:=true;
  if affevt then affiche('Evt RichBranche clic',clyellow);
  with Formconfig.RichBranche do
  begin
    i:=Selstart;
    lc:=Perform(EM_LINEFROMCHAR,i,0);  // num�ro de la lign�e cliqu�e
    if lines[lc]<>'' then LabelNumBranche.Caption:='Branche n�'+intToSTR(lc+1) else LabelNumBranche.Caption:='';
    AncligneClicBr:=ligneClicBr;
    ligneClicBr:=lc;
    curseur:=SelStart;  // position initiale du curseur
    if AncligneClicBr<>ligneClicBr then
    begin
      if AncligneClicBr<>-1 then
      begin
        //RE_ColorLine(RichBranche,AncligneClicBr,ClAqua);
      end;
      //RE_ColorLine(RichBranche,ligneClicBr,ClYellow);
      selStart:=curseur;  // remettre le curseur en position initiale
    end;
  end;
  clicListe:=false;
end;

procedure TFormConfig.ButtonVerifConfigClick(Sender: TObject);
var s : string;
begin
  if verif_coherence then
  begin
    s:='La configuration est ok';  
    labelResult.Caption:=s;
    Affiche(s,clLime);
  end
  else
    labelResult.Caption:='Erreur de coh�rence';
end;

procedure TFormConfig.MemoCarreChange(Sender: TObject);
var s,sO: string;
    j,erreur,adr,ligne,aspect : integer;
    c : char;
    dir : boolean;
begin
  if (ligneClicSig<0) or clicListe then exit;
  if affevt then affiche('Evt MemoCarre change',clyellow);
  j:=MemoCarre.Selstart;
  clicMemo:=MemoCarre.Perform(EM_LINEFROMCHAR,j,0);     // num�ro de la ligne du curseur
  aspect:=Signaux[ligneClicSig+1].aspect;
  dir:=isDirectionnel(ligneClicSig+1);

  if dir and (clicMemo>aspect-10) then 
  begin
    clicListe:=true;
    LabelInfo.Caption:='Erreur '+intToSTR(aspect-9)+' conditions maxi pour un signal � '+intToSTR(aspect-10)+' directions';
    MemoCarre.Lines.Delete(clicMemo);
    clicListe:=false;
    exit;
  end;

  if not(dir) and (clicMemo>5) then
  begin
    clicListe:=true;
    LabelInfo.Caption:='Erreur 6 conditions maxi';
    MemoCarre.Lines.Delete(clicMemo);
    clicListe:=false;
    exit;
  end;

  // signal directionnel
  if dir then
  begin
    // boucle de ligne
    for ligne:=1 to 6 do
    begin
      s:=MemoCarre.Lines[ligne-1];
      sO:=s;
      // boucle de chaine
      j:=1;
      if s<>'' then
      repeat
        if s[1]<>'A' then begin LabelInfo.Caption:='Erreur manque A : '+sO;exit;end;
        delete(s,1,1);
        val(s,adr,erreur);  // adresse
        if adr=0 then exit;
        c:=#0;
        if erreur<>0 then c:=s[erreur];       // S ou D
        if (c<>'D') and (c<>'S') then begin LabelInfo.Caption:='Erreur manque D ou S : '+sO;exit;end;
        setlength(Signaux[ligneClicSig+1].AigDirection[ligne],j+1);  // augmenter le tableau dynamique
        Signaux[ligneClicSig+1].AigDirection[ligne][j].PosAig:=c;
        Signaux[ligneClicSig+1].AigDirection[ligne][j].Adresse:=adr;
        delete(s,1,erreur);   // supprime jusque D
        if length(s)<>0 then if s[1]=',' then delete(s,1,1);
        inc(j);
      until s=''
      else
        setlength(Signaux[ligneClicSig+1].AigDirection[ligne],0);
    end;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
  end

  else
  // signal normal
  begin
    // boucle de ligne
    for ligne:=1 to 6 do
    begin
      s:=uppercase(MemoCarre.Lines[ligne-1]);
      clicListe:=true;
      MemoCarre.Lines[ligne-1]:=s;
      clicListe:=false;
      sO:=s;
      j:=1;
      if s<>'' then 
      repeat
        if s[1]<>'A' then begin LabelInfo.Caption:='Erreur manque A : '+sO;exit;end;
        delete(s,1,1);
        val(s,adr,erreur);  // adresse
        if adr=0 then exit;
        c:=#0;
        if erreur<>0 then c:=s[erreur];       // S ou D
        if (c<>'D') and (c<>'S') then begin LabelInfo.Caption:='Erreur manque D ou S : '+sO;exit;end;
        setlength(Signaux[ligneClicSig+1].condCarre[ligne],j+1);  
        Signaux[ligneClicSig+1].condCarre[ligne][j].PosAig:=c;
        Signaux[ligneClicSig+1].condCarre[ligne][j].Adresse:=adr;
        delete(s,1,erreur);   // supprime jusque D
        if length(s)<>0 then if s[1]=',' then delete(s,1,1);
        inc(j);
      until s=''
      else
        setlength(Signaux[ligneClicSig+1].condCarre[ligne],0);
    end;    
  end;

  s:=encode_signal(ligneClicSig+1);
  ListBoxSig.Items[ligneClicSig]:=s;
  LabelInfo.Caption:='';
  clicListe:=false;
end;



procedure TFormConfig.ComboBoxDDChange(Sender: TObject);
var s: string;
    i,pos: integer;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
  
    i:=ComboBoxDD.ItemIndex;
    case i of
    0 :  pos:=const_devie;
    1 :  pos:=const_droit;
    2 :  pos:=const_inconnu;
    end;
    
    aiguillage[ligneclicAig+1].PosInit:=pos;
    aiguillage[ligneclicAig+1].modifie:=true;
    s:=encode_aig(ligneclicAig+1);
    ListBoxAig.items[ligneclicAig]:=s;
    formconfig.ListBoxAig.selected[ligneclicAig]:=true;
  end;
end;

procedure TFormConfig.EditTempo10Change(Sender: TObject);
var s : string;
    i,erreur : integer;
begin
  if clicliste or (ligneclicAig<0) then exit;

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditTempo10.Text;
    Val(s,i,erreur);
    if (i>0) and (i<50) then
    begin
      LabelInfo.caption:='';
      aiguillage[ligneclicAig+1].temps:=i;
      aiguillage[ligneclicAig+1].modifie:=true;
      s:=encode_aig(ligneclicAig+1);
      ListBoxAig.items[ligneclicAig]:=s;
      formconfig.ListBoxAig.selected[ligneclicAig]:=true;
    end;
  end; 
end;

procedure TFormConfig.CheckInvInitClick(Sender: TObject);
var adrAig,erreur : integer;
    s : string;
begin
  // r�cup�rer l'adresse de l'aiguillage cliqu�
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt change InvInit',clyellow);
  s:=formconfig.ListBoxAig.items[ligneclicAig];
  Val(s,adrAig,erreur);
  // r�encoder la ligne
  s:=encode_aig(Index_Aig(AdrAig));
  formconfig.ListBoxAig.items[ligneclicAig]:=s;
end;

procedure TFormConfig.EditLChange(Sender: TObject);
var s : string;
    i, erreur :integer;
begin
  if clicliste or (ligneclicAig<0) then exit;
  if affevt then affiche('Evt EditL Change',clyellow);
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  begin
    s:=EditL.Text;
    if s='' then exit;
    val(s,i,erreur);
    if (erreur<>0) then
      if (s[erreur]<>'S') and (s[erreur]<>'D') then
      begin
        LabelInfo.caption:='Erreur Champ L manque D ou S terminal';
        exit
      end
    else
    begin
      LabelInfo.caption:='';
      aiguillage[ligneclicAig+1].tjsint:=i;
      aiguillage[ligneclicAig+1].tjsintb:=s[erreur];
      s:=encode_aig(ligneclicAig+1);
      ListBoxAig.items[ligneclicAig]:=s;
    end;
  end;
end;

procedure TFormConfig.ButtonFSEClick(Sender: TObject);
begin
  close;
end;

procedure TFormConfig.FormClose(Sender: TObject; var Action: TCloseAction);
var index : integer;
    ok : boolean;
begin
  {$IF CompilerVersion >= 28.0}
  change_style;
  {$IFEND}
  tsbouton:=false;
  if modif_branches then
  begin
    if MessageDlg('Les branches ont �t� modifi�es mais non valid�es. Voulez fermer la fen�tre ?',mtConfirmation,[mbYes,mbNo],0)=mrNo then
    begin
      action:=tCloseAction(caNone);
      exit;
    end;
  end;
  modif_branches:=false;

  for index:=1 to NbreSignaux do
  begin
    // cr�er les nouveaux checkBox de feux blancs si de nouveaux ont �t� coch�s
    if Signaux[index].FeuBlanc and (Signaux[index].checkFB=nil) then
    begin
      Signaux[index].CheckFB:=TCheckBox.create(Formprinc.ScrollBoxSig);  // cr�e le handle
      with Signaux[index].CheckFB do
      begin
        onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la proc�dure de traitement quand on clique dessus
        Hint:=intToSTR(index);
        caption:='dem FB';
        Parent:=Formprinc.ScrollBoxSig;
        width:=100;height:=15;
        Top:=HtImg+15+((HtImg+EspY+20)*((index-1) div NbreImagePLigne));
        Left:=10+ (LargImg+5)*((index-1) mod (NbreImagePLigne));
        BringToFront;
      end;
    end;
    // supprimer les checkBox de feux blancs si ils ont �t� d�coch�s
    if not(Signaux[index].FeuBlanc) and (Signaux[index].checkFB<>nil) then
    begin
      Signaux[index].CheckFB.free;
      Signaux[index].CheckFB:=nil;
    end;
  end;

  ok:=verifie_panneau_config;

  if not(ok) then action:=tCloseAction(caNone);  // si la config est nok, on ferme pas la fenetre

  init_compteurs;
end;

procedure TFormConfig.ButtonConfigSRClick(Sender: TObject);
var decodeur : integer;
begin
  clicListe:=true;
  decodeur:=Signaux[ligneClicSig+1].decodeur;
  if (decodeur=7) or (decodeur=11) then  // SR ou LEA
  begin
    formSR.showmodal;
    formSR.close;
  end;
  if (decodeur=2) or (decodeur=5) then  // cdf ou digikeijs
  begin
    formCDF.showmodal;
    formCDF.close;
  end;

  if decodeur>=NbDecodeurdeBase then
  begin
    FormConfig.PageControl.ActivePage:=TabSheetDecodeurs;
    ComboBoxDecodeurPerso.ItemIndex:=decodeur-NbDecodeurdeBase;
  end;

  ListBoxSig.selected[ligneClicSig]:=true;
  clicListe:=false;
end;

procedure TFormConfig.PageControlChange(Sender: TObject);
begin
  Label20.Visible:=false;
  LabelInfo.caption:='';
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetPN then label40.Visible:=true
    else label40.Visible:=false;
  tsbouton:=FormConfig.PageControl.ActivePage=TabSheetBouton;
end;


procedure TFormConfig.RichBrancheKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var lc,curseur,i : integer;
begin
  modif_branches:=true;
  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt RichBranche keydown',clyellow);
    with Formconfig.RichBranche do
    begin
      i:=Selstart;
      lc:=Perform(EM_LINEFROMCHAR,i,0);  // num�ro de la lign�e cliqu�e
      if lc>0 then
      begin
        dec(lc);
        if lines[lc]<>'' then LabelNumBranche.Caption:='Branche n�'+intToSTR(lc+1) else LabelNumBranche.Caption:='';
        AncligneClicBr:=ligneClicBr;
        ligneClicBr:=lc;
        curseur:=SelStart;  // position initiale du curseur
        if AncligneClicBr<>ligneClicBr then
        begin
          if AncligneClicBr<>-1 then
          begin
            //RE_ColorLine(RichBranche,AncligneClicBr,ClAqua);
          end;
          //RE_ColorLine(RichBranche,ligneClicBr,ClYellow);
          selStart:=curseur;  // remettre le curseur en position initiale
        end;
      end;
   end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt RichBranche keydown',clyellow);
    with Formconfig.RichBranche do
    begin
      i:=Selstart;
      lc:=Perform(EM_LINEFROMCHAR,i,0);  // num�ro de la lign�e cliqu�e
      if lc<NbreBranches-1 then
      begin
        inc(lc);
        LabelNumBranche.Caption:='Branche n�'+intToSTR(lc+1);
        AncligneClicBr:=ligneClicBr;
        ligneClicBr:=lc;
        curseur:=SelStart;  // position initiale du curseur
        if AncligneClicBr<>ligneClicBr then
        begin
          if AncligneClicBr<>-1 then
          begin
            //RE_ColorLine(RichBranche,AncligneClicBr,ClAqua);
          end;
          //RE_ColorLine(RichBranche,ligneClicBr,ClYellow);
          selStart:=curseur;  // remettre le curseur en position initiale
        end;
      end;
   end;
  end;
  clicListe:=false;
end;


procedure TFormConfig.ListBoxAigKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var lc,i : integer;
begin
  if maxAiguillage<1 then exit;
  if key=VK_delete then supprime_aig;

  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxAig keydown',clyellow);
    with Formconfig.ListBoxAig do
    begin
      lc:=itemindex;
      if lc>0 then
      begin
        dec(lc);
        AncligneClicAig:=ligneClicAig;
        ligneClicAig:=lc;
        if AncligneClicAig<>ligneClicAig then
        begin
          aff_champs_Aig_tablo(lc+1);
        end;
      end;
   end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxAig keydown',clyellow);
    with Formconfig.ListBoxAig do
    begin
      i:=0;
      lc:=itemindex;
      if lc<maxaiguillage-1 then
      begin
        inc(lc);
        AncligneClicAig:=ligneClicAig;
        ligneClicAig:=lc;
        if AncligneClicAig<>ligneClicAig then
        begin
          aff_champs_Aig_tablo(lc+1);
        end;
      end;
   end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then
  begin
    ListBoxAig.SelectAll;
  end;

  clicListe:=false;

end;


procedure TFormConfig.ButtonEnregistreClick(Sender: TObject);
var ok: boolean;
begin
  ok:=verifie_panneau_config;
  if ok then Sauve_config;
end;

procedure TFormConfig.ButtonTestFermeClick(Sender: TObject);
var i,adr,cmd,erreur : integer;
    ts : Taccessoire;
begin
  i:=ligneCliqueePN+1;
  if i<1 then exit;
  // pilotage DCC
  if Tablo_PN[i].TypeCde=0 then
  begin
    val(editAdrFerme.Text,adr,erreur);if erreur<>0 then exit;
    val(editCdeFerme.Text,cmd,erreur);if erreur<>0 then exit;
    aff_acc:=true;
    if Tablo_PN[i].pulse=1 then ts:=aigP else ts:=signal;
    pilote_acc(adr,cmd,ts);
    aff_acc:=false;
  end
  else
  // par socket
  begin
    cmd:=Tablo_PN[i].AdresseFerme;  // num�ro accessoire
    cmd:=com_socket(cmd);           // si cmd ou socket
    if cmd=1 then ferme_pn_usb(i);
    if cmd=2 then ferme_pn_socket(i);
  end;
end;

procedure TFormConfig.ButtonTestOuvreClick(Sender: TObject);
var adr,cmd,erreur,i : integer;
    ts : Taccessoire;
begin
  i:=ligneCliqueePN+1;
  if i<1 then exit;
  if Tablo_PN[i].TypeCde=0 then
  begin
    val(editAdrOuvre.Text,adr,erreur);if erreur<>0 then exit;
    val(editCdeOuvre.Text,cmd,erreur);if erreur<>0 then exit;
    aff_acc:=true;
    if Tablo_PN[ligneCliqueePN+1].pulse=1 then ts:=aigP else ts:=signal;
    pilote_acc(adr,cmd,ts);
    aff_acc:=false;
  end
  else
  begin
    cmd:=Tablo_PN[i].AdresseFerme;  // num�ro accessoire
    cmd:=com_socket(cmd);
    if cmd=1 then ouvre_pn_usb(i);
    if cmd=2 then ouvre_pn_socket(i);
  end;
end;

procedure TFormConfig.CheckPnPulseClick(Sender: TObject);
var i : integer;
    s : string;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt CheckPnPulse Change',clyellow);
  with Formconfig do
  begin
    if CheckPnPulse.Checked then i:=1 else i:=0;
    tablo_PN[lignecliqueePN+1].Pulse:=i;
    s:=encode_act_PN(lignecliqueePN+1);
    ListBoxPN.items[lignecliqueePN]:=s;
    ListBoxPN.selected[lignecliqueePN]:=true;
  end;
end;

procedure TFormConfig.CheckFVCClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt FVC',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    Signaux[ligneClicSig+1].checkFV:=checkFVC.Checked;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.CheckFRCClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt FRC',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    Signaux[ligneClicSig+1].checkFR:=checkFRC.Checked;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.ButtonEnvClick(Sender: TObject);
begin
  init_dccpp;
end;

procedure TFormConfig.EditBaseChange(Sender: TObject);
var erreur : integer;
begin
  val(EditBase.Text,AdrBaseDetDccpp,erreur);
  if (AdrBaseDetDccpp<0) or (AdrBaseDetDccpp>2048) then 
  begin
    AdrBaseDetDccpp:=513;
    EditBase.Text:='513';
  end;  
end;

function decodeDCC(s : string) : string;
var i,erreur : integer;
    sr : string;
begin
  s:=AnsiUppercase(s);
  if copy(s,1,2)='<Y' then
  begin
    delete(s,1,2);
    val(s,i,erreur);
    sr:='Lecture de '+intToSTR(i)+' groupes de 8 d�tecteurs soit '+intToSTR(i*8)+' d�tecteurs';
    delete(s,1,erreur);
    val(s,i,erreur);
    case i of
    0 : sr:=sr+', en binaire';
    1 : sr:=sr+', en hexa bcd';
    2 : sr:=sr+', en hexa vrai';
    3 : sr:=sr+', sp�cifique';
    end;
  end;

  if copy(s,1,3)='<1>' then sr:='Mise sous tension de la voie';
  if copy(s,1,3)='<0>' then sr:='Mise hors tension de la voie';

  if copy(s,1,2)='<T' then
  begin
    delete(s,1,2);
    val(s,i,erreur);sr:='Positionne aiguillage '+intToSTR(i);
    delete(s,1,erreur);
    val(s,i,erreur);
    if i=0 then sr:=sr+' droit';
    if i=1 then sr:=sr+' d�vi�';
  end;

  if copy(s,1,2)='<E' then sr:='Ecrit en eprom';

  decodeDCC:=sr;
end;


procedure TFormConfig.RichCdeDccppChange(Sender: TObject);
var i,maxi : integer;
begin
  if activ then exit;
  maxi:=RichCdeDCCpp.Lines.count;
  if maxi>MaxCdeDccpp then maxi:=MaxCdeDccpp;
  for i:=1 to maxi do
  begin
    CdeDccpp[i]:=RichCdeDccpp.Lines[i-1];
  end;
  LabelInfo.caption:=decodeDCC(richCdeDCCpp.lines[ligneDCC]);
end;

procedure TFormConfig.CheckEnvAigDccppClick(Sender: TObject);
begin
  if CheckEnvAigDccpp.checked then EnvAigDccpp:=1 else EnvAigDccpp:=0;
end;

// copie et affiche l'icone du train index dans Iimage depuis Trains[].Icone
// Iimage: destination ; index: index du train
// en sortie : largeur de l'image g�n�r�e
function Maj_icone_train(IImage : Timage;index :integer;coulfond : Tcolor) : integer;
var h,l,HautDest,LargDest,y : integer;
    rd : single;
begin
  if (index<1) or (index>Ntrains) or (iImage=nil) then
  begin
    //Iimage.Picture:=nil;
    result:=0;
    exit;
  end
  else
    begin
      //Affiche('Maj_icone_train '+intToSTR(index),clYellow);
      // source
      l:=Trains[index].Icone.width;
      h:=Trains[index].Icone.Height;
      if h=0 then
      begin
        result:=0;
        exit;
      end;
      rd:=l/h;
      //Affiche(FloatToSTR(rd),clred);

      // destination : la hauteur est fix�e
      HautDest:=round(iImage.Height);
      LargDest:=round(Hautdest*rd);

      // si la largeur > que l'image, on fixe la largeur
      if LargDest>iImage.Width then
      begin
        LargDest:=iImage.Width;
        HautDest:=round(LargDest/rd);
      end;

      y:=iImage.Height-HautDest;

      with Iimage.Canvas do
      begin
        brush.Color:=coulfond;
        pen.Color:=clwhite;
        Rectangle(0,0,Iimage.Width,Iimage.Height);
      end;
      TransparentBlt(Iimage.canvas.Handle,0,y,largDest,hautDest,
                     Trains[index].Icone.canvas.Handle,0,0,l,h,clWhite);
    end;
  Iimage.refresh;

  result:=largdest;
end;


procedure TFormConfig.ListBoxTrainsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s : string;
begin
  //affiche('RichEditTrainChange',clyellow);
  clicListe:=true;

  ligneclicTrain:=ListBoxTrains.ItemIndex;

  //Affiche(intToSTR(lc),clyellow);

  if ligneclicTrain+1>ntrains then
  begin
    ligneclicTrain:=ntrains-1;
  end;
  if ligneclicTrain<0 then exit;
  s:=ListBoxTrains.items[ligneclicTrain];
  if s='' then exit;

  clicListeTrains(ligneclicTrain+1);

  clicliste:=false;
end;


procedure TFormConfig.EditNomTrainChange(Sender: TObject);
var i : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change nom train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  trains[ligneclicTrain+1].Nom_train:=EditNomTrain.text;
  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  LabelTrain[ligneclicTrain+1].Caption:=EditNomTrain.text;

  i:=formprinc.ComboTrains.ItemIndex;
  if i<0 then exit;
  formprinc.ComboTrains.Items[ligneclicTrain]:=EditNomTrain.text;
  formConfig.ComboBoxUSBTr.Items[LigneClicTrain+1]:=EditNomTrain.text;
  if LabelTrain[ligneclicTrain+1]<>nil then LabelTrain[ligneclicTrain+1].Caption:=EditNomTrain.text;
  if i=ligneclicTrain then
  begin
    formprinc.ComboTrains.Text:=EditNomTrain.text;
  end;
end;

procedure TFormConfig.EditAdresseTrainChange(Sender: TObject);
var erreur,i,j :integer;
    trouve : boolean;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change adresse train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(EditAdresseTrain.text,i,erreur);
  if (i<1) or (i>255) then
  begin
    LabelInfo.caption:='Erreur'; 
    exit;
  end;

  j:=1;
  repeat
    trouve:=(trains[j].adresse=i) and (j<>ligneclicTrain+1);
    inc(j);
  until (j>ntrains) or trouve;

  if trouve then
  begin
    dec(j);
    LabelInfo.caption:='Erreur: le train '+Trains[j].nom_train+' a d�j� l''adresse '+intToSTR(i);
    exit;
  end;
  LabelInfo.caption:='';

  trains[ligneclicTrain+1].adresse:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.EditVitesseMaxihange(Sender: TObject);
var erreur,i :integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change vitesse maxi train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(EditVitesseMaxi.text,i,erreur);
  if i<1 then exit;
  trains[ligneclicTrain+1].vitmax:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  formconfig.ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.EditLongLocoChange(Sender: TObject);
var erreur,i :integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change longueur train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(EditLongLoco.text,i,erreur);
  if i<1 then exit;
  trains[ligneclicTrain+1].longueur:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  formconfig.ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.EditVitNomChange(Sender: TObject);
var erreur,i : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change vitesse nominale train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetTrains then
  with Formconfig do
  begin
    val(EditVitNom.text,i,erreur);
    if i<1 then exit;
    trains[ligneclicTrain+1].vitNominale:=i;
    ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
    ListBoxTrains.selected[ligneclicTrain]:=true;
  end;
end;

procedure TFormConfig.EditVitRalentiChange(Sender: TObject);
var erreur,i : integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change vitesse ralenti train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetTrains then
  with Formconfig do
  begin
    val(EditVitRalenti.text,i,erreur);
    if i<1 then exit;
    trains[ligneclicTrain+1].vitRalenti:=i;
    ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
    ListBoxTrains.selected[ligneclicTrain]:=true;
  end;
end;

procedure ajoute_train;
var i : integer;
begin
  if nTrains>=Max_Trains then exit;
  clicListe:=true;
  inc(nTrains);
  with trains[ntrains] do
  begin
    nom_train:='train';
    adresse:=99;
    VitNominale:=60;
    VitRalenti:=40;
    vitmax:=120;
    icone:=Timage.create(nil);
    with icone do
    begin
      Name:='IconeTrain'+intToSTR(nTrains); 
      autosize:=true;
      align:=alNone;
      parent:=nil;
      top:=0;left:=0;
      width:=200;
      height:=100;
    end;
  end;

  clicListeTrains(ntrains);
  ligneclicTrain:=ntrains-1;
  clicListe:=false;

  formprinc.ComboTrains.Items.Add(trains[ntrains].nom_train);
  formconfig.ComboBoxUSBTr.Items.Add(trains[ntrains].nom_train);

  for i:=0 to ntrains-2 do formConfig.ListBoxTrains.selected[i]:=false;

  with formConfig.ListBoxTrains do
  begin
    items.add(encode_train(ntrains));
    selected[ntrains-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  cree_image_Train(ntrains);

  // ajoute le compteur
  cree_GB_compteur(ntrains);
end;

procedure TFormConfig.ButtonNTClick(Sender: TObject);
begin
  ajoute_train;
end;

// supprime le ou les train s�lectionn�s dans le richEdit
procedure supprime_train;
var i,j,n : integer;
    s,ss : string;
begin
  ss:='';
  for i:=0 to nTrains-1 do
  begin
    if formconfig.ListBoxTrains.selected[i] then
    begin
      ss:=ss+trains[i+1].nom_train+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer ';
  if n=1 then s:=s+' le train ' else s:=s+' les trains ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;

  with formconfig do
  begin
    editNomTrain.Text:='';
    editADresseTrain.text:='';
    editVitRalenti.Text:='';
    editVitNom.Text:='';
    editVitesseMaxi.text:='';
    editLongLoco.text:='';
    LabeledEditTempoD.text:='';
    checkboxSens.Checked:=false;
    editIcone.Text:='';
    LabeledEditV1.Text:='';
    LabeledEditV2.Text:='';
    LabeledEditV3.Text:='';
    LabeledEditCV3.Text:='';
    LabeledEditCV4.Text:='';
    LabeledEditCrans.Text:='';
  end;

  // suppression
  formCompteur[1].close;

  i:=1;
  repeat
    if formconfig.ListBoxTrains.selected[i-1] then
    begin
      j:=i;
      Affiche('Supprime train '+intToSTR(j)+' '+Trains[j].nom_train,clOrange);
      // lib�rer les composants car on va r�affecter des noms
      trains[j].icone.Free;
      image_train[j].free;
      labeltrain[j].free;
      LabelVitesse[j].free;
      labelBlocUSB[j].free;
      trains[j].icone:=nil;
      image_train[j]:=nil;
      labeltrain[j]:=nil;
      LabelVitesse[j]:=nil;
      labelBlocUSB[j]:=nil;
      // composants onglet compteurs
      compteurT[j].Img.Free;
      compteurT[j].img:=nil;
      compteurT[j].tb.Free;
      compteurT[j].tb:=nil;
      compteurT[j].lbl.Free;
      compteurT[j].lbl:=nil;
      compteurT[j].bouton.Free;
      compteurT[j].bouton:=nil;
      compteurT[j].FcBitmap.Free;
      compteurT[j].FcBitmap:=nil;
      compteurT[j].gb.free;
      compteurT[j].gb:=nil;

      // d�caler le reste du tableau
      for j:=i to nTrains do
      begin
        if j<ntrains then
        begin
         formconfig.ListBoxTrains.selected[j-1]:=formconfig.ListBoxTrains.selected[j];
          trains[j]:=trains[j+1];
          image_train[j]:=image_train[j+1];
          image_train[j].Name:='ImageTrain'+IntToSTR(j);
          // renseigne les composants train page principale
          labeltrain[j]:=labeltrain[j+1];
          LabelVitesse[j]:=LabelVitesse[j+1];
          LabelBlocUSB[j]:=LabelBlocUSB[j+1];
          renseigne_comp_trains(j);
          // onglet compteurs
          compteurT[j]:=compteurt[j+1];
          with compteurT[j] do
          begin
            gb.name:='GroupBoxT'+IntToSTR(j);
            lbl.Name:='LabelT'+IntToSTR(j);
            Img.Name:='ImageCompteurT'+IntToSTR(j);
            Bouton.Name:='BoutonT'+IntToSTR(j);
            tb.Name:='TrackBarT'+IntToSTR(j);
          end;
        end;
      end;
      dec(ntrains);
    end
    else
      inc(i);
  until i>ntrains;

  Formprinc.ScrollBoxTrains.Repaint;

  config_modifie:=true;
  FormConfig.ListBoxTrains.Clear;

  // r�afficher la liste
  for i:=1 to ntrains do
  begin
    s:=encode_train(i);
    FormConfig.ListBoxtrains.items.Add(s);
  end;

  formprinc.ComboTrains.Clear;
  with formconfig do
  begin
    comboBoxUSBTr.clear;
    comboBoxUSBTr.items.add('Pas d''affectation');
  end;
  for i:=1 to ntrains do
  begin
    FormPrinc.ComboTrains.items.Add(Trains[i].nom_train);
    FormConfig.ComboBoxUSBTr.items.Add(Trains[i].nom_train);
  end;

  ligneclicTrain:=-1;
  clicliste:=false;
end;


procedure TFormConfig.ButtonSupprimeClick(Sender: TObject);
begin
  supprime_train;
end;

procedure TFormConfig.CheckBoxVerifXpressNetClick(Sender: TObject);
begin
  if CheckBoxVerifXpressNet.checked then Verif_AdrXpressNet:=1 else Verif_AdrXpressNet:=0;
end;


procedure TFormConfig.ListBoxTrainsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_DELETE then supprime_train;
  if Key=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxTrains keyup',clyellow);
    with Formconfig.ListBoxTrains do
    begin
      if ligneclicTrain>0 then
      begin
        begin
          dec(ligneclicTrain);
          clicListeTrains(ligneclicTrain+1);
        end;
      end;
   end;
  end;

  if Key=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxTrains keydown',clyellow);
    with Formconfig.ListBoxTrains do
    begin
      if ligneclicTrain<ntrains-1 then
      begin
        begin
          inc(ligneclicTrain);
          clicListeTrains(ligneclicTrain+1);
        end;
      end;
   end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then ListBoxTrains.SelectAll;

  clicListe:=false;
end;

// affiche l'�tat de la r�gle "nom" du parefeu du chemin du programme avec exe
procedure regle(nom,chemin : string);
var i : integer;
    s : string;
    r : boolean;
begin
  i:=verifie_regle(nom);
  if i=0 then
  begin
    r:=cree_regle(nom,chemin);
    if r then
    begin
      s:='La r�gle d''autorisation '+nom+' a �t� ajout�e dans le pare-feu ';
      Affiche(s,clyellow);
      i:=verifie_regle(nom);
    end;
  end;

  if i=0 then s:='La r�gle d''autorisation '+nom+' n''a pas �t� trouv�e dans le pare-feu ';
  if i=1 then s:='La r�gle d''autorisation '+nom+' a �t� trouv�e dans le pare-feu mais elle est d�sactiv�e';
  if i=2 then s:='La r�gle d''autorisation '+nom+' a �t� trouv�e dans le pare-feu et elle est activ�e';
  Affiche(s,clyellow);
end;

procedure TFormConfig.ButtonPFCDMClick(Sender: TObject);
begin
  activecontrol:=nil;
  regle('CDM rail','\CDM-Rail\cdr.exe');
  regle('Signaux complexes','\Signaux_complexes\signaux_complexes_gl.exe');
end;

procedure TFormConfig.EditLAYChange(Sender: TObject);
var s : string;
begin
  if clicListe then exit;
  if not(Affiche_avert) then
  begin
    Affiche_avert:=true;
    s:='Pour que cette fonction soit op�rationnelle, dans CDM Rail, il faut charger votre r�seau, puis "d�finir le r�seau actuel comme ';
    s:=s+'r�seau de d�marrage" puis le d�valider';
    LabelInfo.caption:=s;
  end;
end;

procedure TFormConfig.EditLAYExit(Sender: TObject);
begin
  Affiche_avert:=false;
  LabelInfo.caption:='';
end;

procedure TFormConfig.Copier1Click(Sender: TObject);
var tc : Trichedit;
begin
  tc:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TRichEdit ;
  tc.CopyToClipboard;
  tc.SetFocus;
end;

procedure TFormConfig.Coller1Click(Sender: TObject);
var tc : Trichedit;
begin
  tc:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TRichEdit ;
  With tc do
  begin
    PasteFromClipboard;
    SetFocus;
  end;
end;

procedure TFormConfig.RichCdeDccppMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i : integer;
begin
  with Formconfig.RichCdeDCCpp do
  begin
    i:=Selstart;
    ligneDCC:=Perform(EM_LINEFROMCHAR,i,0);  // num�ro de la lign�e cliqu�e
    LabelInfo.caption:=decodeDCC(lines[ligneDCC]);
  end;
end;

procedure TFormConfig.RichCdeDccppKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i : integer;
begin
  with Formconfig.RichCdeDCCpp do
  begin
    i:=Selstart;
    ligneDCC:=Perform(EM_LINEFROMCHAR,i,0);  // num�ro de la lign�e cliqu�e
    if ord(Key)=VK_UP then dec(ligneDCC);
    if ord(Key)=VK_DOWN then inc(ligneDCC);
    if ligneDCC<0 then ligneDCC:=0;

    LabelInfo.caption:=decodeDCC(lines[ligneDCC]);
  end;

  if (Shift=[ssCtrl]) and (key=ord('A')) then
  begin
    RichCdeDccpp.SelectAll;
  end;
end;

procedure TFormConfig.CheckBoxVersContrevoieClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt VersContrevoie',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    Signaux[ligneClicSig+1].verscontrevoie:=checkBoxVersContreVoie.Checked;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;
  end;
end;

procedure TFormConfig.CheckBoxContreVoieClick(Sender: TObject);
var s : string;
    adr : integer;
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt Contrevoie',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  begin
    Signaux[ligneClicSig+1].contrevoie:=checkBoxContreVoie.Checked;
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Signaux[ligneClicSig+1].modifie:=true;

    aff_champs_signaux(ligneClicSig+1); // redessine les champs et le signal  - contient l'inversion de l'image

    // maj le signal dans la fenetre principale
    Signaux[ligneClicSig+1].Img.picture.Bitmap:=ImageSIgnal.Picture.Bitmap;  // et recopie le signal
    adr:=Signaux[ligneClicSig+1].adresse;
    if Signaux[ligneClicSig+1].contrevoie then Maj_Etat_Signal(adr,clignote_f or bita1_F) else Maj_Etat_Signal(adr,clignote_F);
    dessine_signal_mx(Signaux[ligneClicSig+1].Img.Canvas,0,0,1,1,Signaux[ligneClicSig+1].adresse,1);  // dessine les feux du signal
    for adr:=1 to NbreTCO do affiche_tco(adr);
  end;
end;

// v�rifie si une voie d'un PN actionneurs est nulle
function ligne_vide_actPN(voie : integer) : boolean;
var s : string;
    t1,t2 : tedit;
    v1,v2,erreur : integer;
begin
  s:='EditV'+intToSTR(voie)+'F';
  t1:=FormConfig.GroupBoxPNA.findComponent(s) as tedit;
  s:='EditV'+intToSTR(voie)+'O';
  t2:=FormConfig.GroupBoxPNA.findComponent(s) as tedit;
  val(t1.Text,v1,erreur);
  val(t2.Text,v2,erreur);
  result:=(v1=0) and (v2=0);
end;

// v�rifie si une voie d'un PN zones de d�tection est nulle
function ligne_vide_ZonesPN(voie : integer) : boolean;
var s : string;
    t1,t2,t3,t4 : tedit;
    v1,v2,v3,v4,erreur : integer;
begin
  s:='EditZDet1V'+intToSTR(voie)+'F';
  t1:=FormConfig.GroupBoxPNZ.findComponent(s) as tedit;
  s:='EditZDet2V'+intToSTR(voie)+'F';
  t2:=FormConfig.findComponent(s) as tedit;
  s:='EditZDet1V'+intToSTR(voie)+'O';
  t3:=FormConfig.findComponent(s) as tedit;
  s:='EditZDet2V'+intToSTR(voie)+'O';
  t4:=FormConfig.findComponent(s) as tedit;
  val(t1.Text,v1,erreur);
  val(t2.Text,v2,erreur);
  val(t3.Text,v3,erreur);
  val(t4.Text,v4,erreur);
  result:=(v1=0) and (v2=0) and (v3=0) and (v4=0);
end;

// modif editT
procedure Tformconfig.modif_editT(Sender : TObject);
var te : tEdit;
    adr,i,NbVoies,erreur,act,voie,det,numDet :integer;
    ouvre,ferme,v2Valide,v3valide,v4valide,v5valide : boolean;
    s,sb : string;
begin
  te:=Sender as Tedit;
  s:=lowercase(te.Name);
  sb:=te.Text;

  if pos('editdecalt',s)<>0 then
  begin
    if deccourant<1 then exit;
    adr:=extract_int(s);
    val(sb,i,erreur);
    if (erreur<>0) or (i<0) then
    begin
      labelInfo.caption:='Erreur adresse';
      exit;
    end;
    labelInfo.caption:='';
    decodeur_pers[deccourant].desc[adr].offsetAdresse:=i;
    exit;
  end;

  // passage � niveau - actionneurs
  if pos('editv',s)<>0 then
  begin
    i:=lignecliqueePN+1;
    voie:=extract_int(s);     // num�ro de voie modifi�e
    ouvre:=pos('o',s)<>0;     // champ ouvre
    ferme:=pos('f',s)<>0;     // champ ferme
    if clicliste or (lignecliqueePN<0) then exit;
    if affevt then affiche('Evt EditVXX Change',clyellow);
    with Formconfig do
    begin
      Val(sb,act,erreur);
      if ((erreur<>0) or (act<=0)) and (sb<>'') then
      begin
        LabelInfo.caption:='Erreur adresse actionneur';
        if ferme then tablo_PN[i].voie[voie].ActFerme:=0;
        if ouvre then tablo_PN[i].voie[voie].ActOuvre:=0;
        exit;
      end
      else LabelInfo.caption:=' ';
      if ferme then tablo_PN[i].voie[voie].ActFerme:=act;
      if ouvre then tablo_PN[i].voie[voie].ActOuvre:=act;
      NbVoies:=tablo_PN[i].NbVoies;

      if voie=2 then
      begin
        V2valide:=(EditV2O.text<>'') and (EditV2F.text<>'');
        if V2Valide and (NbVoies=1) then tablo_PN[i].NbVoies:=2;
        if not(V2Valide) then tablo_PN[i].NbVoies:=1;
      end;

      if voie=3 then
      begin
        V3valide:=(EditV3O.text<>'') and (EditV3F.text<>'');
        if V3Valide and (NbVoies=2) then tablo_PN[i].NbVoies:=3;
        if not(V3Valide) then tablo_PN[i].NbVoies:=2;
      end;

      if voie=4 then
      begin
        V4valide:=(EditV4O.text<>'') and (EditV4F.text<>'');
        if V4Valide and (NbVoies=3) then tablo_PN[i].NbVoies:=4;
        if not(V4Valide) then tablo_PN[i].NbVoies:=3;
      end;

      if voie=5 then
      begin
        V5valide:=(EditV5O.text<>'') and (EditV5F.text<>'');
        if V4Valide and (NbVoies=4) then tablo_PN[i].NbVoies:=5;
        if not(V5Valide) then tablo_PN[i].NbVoies:=4;
      end;

      // corriger le nombre de voies
      if ligne_vide_actPN(5) then tablo_PN[i].NbVoies:=4;
      if ligne_vide_actPN(4) then tablo_PN[i].NbVoies:=3;
      if ligne_vide_actPN(3) then tablo_PN[i].NbVoies:=2;
      if ligne_vide_actPN(2) then tablo_PN[i].NbVoies:=1;
      if ligne_vide_actPN(1) then tablo_PN[i].NbVoies:=0;

      s:=encode_act_PN(i);
      ListBoxPN.items[lignecliqueePN]:=s;
      ListBoxPN.Selected[lignecliqueePN]:=true;
    end;

    exit;
  end;

  // PN zones
  if pos('editz',s)<>0 then  //ex pour la voie 2: EditZdet1V2F EditZdet2V2F EditZdet1V2O EditZdet2V2O
  begin
    if clicliste or (lignecliqueePN<0) then exit;
    if affevt then affiche('Evt EditZdetXVX Change',clyellow);
    with Formconfig do
    begin
      i:=pos('det1',s);if i<>0 then begin numdet:=1;delete(s,1,i+3);end;
      i:=pos('det2',s);if i<>0 then begin numdet:=2;delete(s,1,i+3);end;

      voie:=extract_int(s);
      ouvre:=pos('o',s)<>0;
      ferme:=pos('f',s)<>0;

      s:=te.Text;
      Val(s,det,erreur);
      if ((erreur<>0) or (det<=0)) and (s<>'') then
      begin
        LabelInfo.caption:='Erreur adresse d�tecteur';exit
      end else LabelInfo.caption:=' ';
      i:=lignecliqueePN+1;
      if (numdet=1) and ferme then tablo_PN[i].voie[voie].DetZ1F:=det;
      if (numdet=1) and ouvre then tablo_PN[i].voie[voie].DetZ1O:=det;
      if (numdet=2) and ferme then tablo_PN[i].voie[voie].DetZ2F:=det;
      if (numdet=2) and ouvre then tablo_PN[i].voie[voie].DetZ2O:=det;

      NbVoies:=tablo_PN[i].NbVoies;
      if voie=2 then
      begin
        V2valide:=(EditZdet1V2F.text<>'') and (EditZdet1V2o.text<>'');
        if V2Valide and (NbVoies=1) then tablo_PN[i].NbVoies:=2;
        if not(V2Valide) then tablo_PN[i].NbVoies:=1;
      end;

      if voie=3 then
      begin
        V3valide:=(EditZdet1V3F.text<>'') and (EditZdet1V3O.text<>'');
        if V3Valide and (NbVoies=2) then tablo_PN[i].NbVoies:=3;
        if not(V3Valide) then tablo_PN[i].NbVoies:=2;
      end;

      if voie=4 then
      begin
        V4valide:=(EditZdet1V4F.text<>'') and (EditZdet1V4O.text<>'');
        if V4Valide and (NbVoies=3) then tablo_PN[i].NbVoies:=4;
        if not(V4Valide) then tablo_PN[i].NbVoies:=3;
      end;

      if voie=5 then
      begin
        V5valide:=(EditZdet1V5F.text<>'') and (EditZdet1V5O.text<>'');
        if V5Valide and (NbVoies=4) then tablo_PN[i].NbVoies:=5;
        if not(V5Valide) then tablo_PN[i].NbVoies:=4;
      end;

      // corriger le nombre de voies
      if ligne_vide_zonesPN(5) then tablo_PN[i].NbVoies:=4;
      if ligne_vide_zonesPN(4) then tablo_PN[i].NbVoies:=3;
      if ligne_vide_zonesPN(3) then tablo_PN[i].NbVoies:=2;
      if ligne_vide_zonesPN(2) then tablo_PN[i].NbVoies:=1;
      if ligne_vide_zonesPN(1) then tablo_PN[i].NbVoies:=0;

      s:=encode_act_PN(i);
      ListBoxPN.items[lignecliqueePN]:=s;
      ListBoxPN.Selected[lignecliqueePN]:=true;
    end;
  end;
end;


// changement combobox choix sorties 1 ou 2
procedure Tformconfig.modif_ComboTS(Sender : TObject);
var co : tComboBox;
    i,idx,adresse,erreur : integer;
    s : string;
begin
  if deccourant=0 then exit;
  co:=Sender as TCombobox;
  //i:=co.itemIndex;
  i:=extract_int(co.name);
  s:=intToSTR(i);
  idx:=co.itemIndex;

  val(s[1],i,erreur);        // rang
  delete(s,1,1);
  val(s,adresse,erreur);  // adresse

  if i=1 then decodeur_pers[deccourant].desc[adresse].sortie1:=idx+1;
  if i=2 then decodeur_pers[deccourant].desc[adresse].sortie2:=idx+1;
end;

// changement combobox Etats
procedure Tformconfig.modif_ComboL(Sender : TObject);
var co : tComboBox;
    idx,i,adresse,erreur : integer;
    s : string;
begin
  if deccourant=0 then exit;
  co:=Sender as TCombobox;
  //i:=co.itemIndex;
  i:=extract_int(co.name);
  s:=intToSTR(i);
  idx:=co.itemIndex;
  val(s[1],i,erreur);      // rang
  delete(s,1,1);
  val(s,adresse,erreur);  // adresse

  if i=1 then decodeur_pers[deccourant].desc[adresse].etat1:=idx;
  if i=2 then decodeur_pers[deccourant].desc[adresse].etat2:=idx;
end;


procedure rend_visible;
var i,erreur,nombre : integer;
begin
  val(formconfig.EditNbreAdr.Text,nombre,erreur);
  if (erreur<>0) or (nombre>10) then exit;

  decCourant:=formconfig.ComboBoxDecodeurPerso.ItemIndex+1;
  if decCourant<1 then exit;
  decodeur_pers[decCourant].nbreAdr:=nombre;

  decodeur_pers[decCourant].nom:=formconfig.ComboBoxDecodeurPerso.items[decCourant-1];

  maj_decodeurs;
  exit;

  for i:=1 to nombre do
  begin
    ComboTS1[i].Visible:=true;
    ComboTS2[i].Visible:=true;
    EditT[i].visible:=true;
    ComboL1[i].Visible:=true;
    ComboL2[i].Visible:=true;
  end;

  for i:=nombre+1 to 10 do
  begin
    ComboTS1[i].Visible:=false;
    ComboTS2[i].Visible:=false;
    EditT[i].visible:=false;
    ComboL1[i].Visible:=false;
    ComboL2[i].Visible:=false;
  end;

end;

// nouveau d�codeur personnalis�
procedure TFormConfig.BoutonNouveauClick(Sender: TObject);
var s: string;
    i,nombre,decCourant : integer;
begin
  if NbreDecPers>=NbreMaxiDecPers then exit;

  inc(NbreDecPers);
  s:='Personnalis� '+intToSTR(NbreDecPers);
  decodeur_pers[NbreDecPers].nom:=s;
  decodeur_pers[NbreDecPers].Nation:=1;
  decodeur_pers[NbreDecPers].Commande:=0;

  nombre:=4;
  decodeur_pers[NbreDecPers].NbreAdr:=nombre;
  formconfig.EditNbreAdr.Text:=intToSTR(nombre);

  ComboBoxDecodeurPerso.Items.Add(s);
  ComboBoxDecodeurPerso.ItemIndex:=NbreDecPers-1;

  decCourant:=formconfig.ComboBoxDecodeurPerso.ItemIndex+1;

  for i:=1 to Nombre do
  begin
    editT[i].Text:=IntToSTR(i-1);
    decodeur_pers[decCourant].desc[i].offsetAdresse:=i-1;
  end;

  rend_visible;
  // ajouter aux d�codeurs personalis�s
  s:=decodeur_pers[decCourant].nom;
  formconfig.ComboBoxDec.Items.add(s);
  config_modifie:=true;
  // ajouter aux d�codeurs
  inc(NbDecodeur);
  decodeur[NbDecodeur]:=s;
  LabelNbDecPers.caption:=intToSTR(NbreDecPers);

  //v�rifier si le d�codeur est utilis� dans les signaux pour changer son hint
  for i:=1 to NbreSignaux do
  begin
    if Signaux[i].decodeur=NbDecodeurdeBase+decCourant-1 then Maj_Hint_Signal(i);
  end;
end;

procedure TFormConfig.EditNbreAdrChange(Sender: TObject);
var i,erreur : integer;
begin
  val(EditNbreAdr.text,i,erreur);
  if (erreur<>0) or (i<1) or (i>10) then
  begin
    LabelInfo.Caption:='Nombre d''adresses valides de 1 � 10';
    exit;
  end;
  LabelInfo.Caption:='';
  rend_visible;
end;


procedure TFormConfig.ComboBoxDecodeurPersoChange(Sender: TObject);
var it,i,k : integer;
    s: string;
begin
  if affevt then Affiche('Evt ComboBoxDecodeurPerso',clyellow);

  it:=ComboBoxDecodeurPerso.ItemIndex;

  if it>=0 then decCourant:=it+1;
  //Affiche(intToSTR(decCourant)+' '+intToSTR(it)+' '+ComboBoxDecodeurPerso.Text,clred);

  //if a=-1 then
  if decCourant>=0 then
  begin
    // changement du nom
    if decCourant=0 then exit;
    s:=ComboBoxDecodeurPerso.Text;

    ComboBoxDecodeurPerso.items[decCourant-1]:=s;             // efface
    ComboBoxDecodeurPerso.itemIndex:=it;                      // remet

    decodeur_pers[decCourant].nom:=s;
    decodeur[NbDecodeurdeBase+DecCourant-1]:=s;

    k:=comBoBoxDec.ItemIndex;
    ComboBoxDec.Items[NbDecodeurdeBase+DecCourant-1]:=s;   // combobox du d�codeur, onglet signaux  - change son itemindex
    ComboBoxDec.ItemIndex:=k;
    //v�rifier si le d�codeur est utilis� dans les signaux pour changer son hint
    for i:=1 to NbreSignaux do
    begin
      if Signaux[i].decodeur=NbDecodeurdeBase+decCourant-1 then Maj_Hint_Signal(i);
    end;
  end;

  EditNbreAdr.Text:=intToSTR(decodeur_pers[decCourant].NbreAdr);
  //Affiche('D�codeur courant = '+intToSTR(decCourant),clyellow);
  maj_decodeurs;
end;

// renvoie vrai si chaine est dans le combobox 'combo' et renvoie son index
function trouve_entree_combo(combo : Tcombobox;chaine : string;var index : integer) : boolean;
var i,maxi : integer;
    trouve : boolean;
begin
  i:=0;
  maxi:=combo.items.Count;
  repeat
    trouve:=combo.Items[i]=chaine;
    inc(i);
  until trouve or (i=maxi);
  result:=trouve;
  index:=i-1;
end;

procedure TFormConfig.ButtonSupClick(Sender: TObject);
var s : string;
    i,ma,deco,supp : integer;
    aff : boolean;
begin
  // supprimer des d�codeurs personalis�s
  if decCourant=0 then exit;

  s:='Voulez vous supprimer le d�codeur personnalis� '#13+decodeur_pers[decCourant].nom+' ?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  //supprimer de la liste des d�codeurs peronnalis�s
  s:=decodeur_pers[decCourant].nom;
  if trouve_entree_combo(ComboBoxDec,s,i) then ComboBoxDec.Items.Delete(i)
    else exit;

  supp:=i;
  Affiche('Suppression d�codeur '+intToSTR(supp-1)+' '+s,clOrange);

  //supprimer de la liste des d�codeurs si elle est affect�e
  if trouve_entree_combo(ComboBoxDecodeurPerso,s,i) then ComboBoxDecodeurPerso.Items.Delete(i)
    else affiche('Anomalie ComboBox 1',clred);

  //if decCourant>0 then dec(decCourant);
  decCourant:=0;
  ComboBoxDecodeurPerso.ItemIndex:=-1;

  inc(i);
  ma:=i;
  // et supprimer la base
  for i:=ma to NbreDecPers-1 do
  begin
    Affiche('traitement d�codeur '+inttoSTR(i),clyellow);
    decodeur_pers[i]:=decodeur_pers[i+1];
  end;
  dec(NbreDecPers);
  if NbreDecPers=0 then ComboBoxDecodeurPerso.Text:='';
  config_modifie:=true;
  maj_decodeurs;

  // supprimer des d�codeurs
  decodeur[NbDecodeur]:='';
  dec(NbDecodeur);
  LabelNbDecPers.caption:=intToSTR(NbreDecPers);

  // si le d�codeur est attribu� aux signaux, les passer en rien
  aff:=false;
  for i:=1 to NbreSignaux do
  begin
    deco:=Signaux[i].decodeur;
    if deco=supp then
    begin
      Affiche('Le d�codeur du signal '+intToSTR(Signaux[i].adresse)+' a �t� r�affact� � rien',clOrange);
      Signaux[i].decodeur:=0;
      if i=ligneClicSig+1 then aff_champs_signaux(ligneClicSig+1);
      aff:=true;
    end;
    if deco>supp then
    begin
      dec(Signaux[i].decodeur);  // et d�cr�menter les autres d�codeurs personnalis�s de rang sup�rieur
      aff:=true;
    end;
  end;

  // r�afficher le richedit des signaux
  if aff then
  begin
    ListBoxSig.Items.Clear;
    for i:=1 to NbreSignaux do
    begin
      s:=encode_signal(i);  // encode la ligne depuis le tableau feux
      if s<>'' then
      begin
        ListBoxSig.Items.Add(s);
        Signaux[i].modifie:=false;
      end;
    end;
  end;
end;

procedure TFormConfig.ComboBoxNationChange(Sender: TObject);
var nation : integer;
begin
  if deccourant=0 then exit;
  nation:=ComboBoxNation.itemIndex+1;
  decodeur_pers[decCourant].nation:=nation;
  maj_decodeurs;
end;

procedure TFormConfig.MemoBlancChange(Sender: TObject);
var s,sO: string;
    j,erreur,adr,ligne,aspect : integer;
    c : char;
begin
  if (ligneClicSig<0) or clicListe then exit;
  if affevt then affiche('Evt MemoBlanc change',clyellow);
  j:=MemoCarre.Selstart;
  clicMemo:=MemoCarre.Perform(EM_LINEFROMCHAR,j,0);     // num�ro de la ligne du curseur
  aspect:=Signaux[ligneClicSig+1].aspect;

  if (clicMemo>5) then
  begin
    clicListe:=true;
    LabelInfo.Caption:='Erreur 6 conditions maxi';
    MemoCarre.Lines.Delete(clicMemo);
    clicListe:=false;
    exit;
  end;

  // signal normal
  // boucle de ligne
  for ligne:=1 to 6 do
  begin
    s:=uppercase(MemoBlanc.Lines[ligne-1]);
    clicListe:=true;
    MemoBlanc.Lines[ligne-1]:=s;
    clicListe:=false;
    sO:=s;
    j:=1;
    if s<>'' then
    repeat
      if s[1]<>'A' then begin LabelInfo.Caption:='Erreur manque A : '+sO;exit;end;
      delete(s,1,1);
      val(s,adr,erreur);  // adresse
      if adr=0 then exit;
      c:=#0;
      if erreur<>0 then c:=s[erreur];       // S ou D
      if (c<>'D') and (c<>'S') then begin LabelInfo.Caption:='Erreur manque D ou S : '+sO;exit;end;
      setlength(Signaux[ligneClicSig+1].condFeuBlanc[ligne],j+1);
      Signaux[ligneClicSig+1].condFeuBlanc[ligne][j].PosAig:=c;
      Signaux[ligneClicSig+1].condFeuBlanc[ligne][j].Adresse:=adr;
      delete(s,1,erreur);   // supprime jusque D
      if length(s)<>0 then if s[1]=',' then delete(s,1,1);
      inc(j);
    until s=''
    else
      setlength(Signaux[ligneClicSig+1].condFeuBlanc[ligne],0);
  end;

  s:=encode_signal(ligneClicSig+1);
  ListBoxSig.Items[ligneClicSig]:=s;
  ListBoxSig.selected[ligneClicSig]:=true;
  LabelInfo.Caption:='';
  clicListe:=false;
end;


procedure TFormConfig.ListBoxAigDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TListBox do
  begin
    Canvas.FillRect(Rect);
    Canvas.Font.Color := TColor(Items.Objects[Index]);
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TFormConfig.ListBoxSigMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  clicliste:=true;
  if NbreSignaux<1 then exit;

  raz_champs_sig;

  with Formconfig.ListBoxSig do
  begin
    ligneClicSig:=itemindex;
    clicListeSignal(ligneClicSig+1);
  end;
  clicliste:=false;
end;

procedure TFormConfig.ListBoxSigKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if NbreSignaux<1 then exit;
  if key=VK_delete then supprime_sig;

  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxSig.Items keydown',clyellow);
    with Formconfig.ListBoxSig.Items do
    begin
      if ligneClicSig>0 then
      begin
        dec(ligneClicSig);
        if AncligneClicSig<>ligneClicSig then
        begin
          AncligneClicSig:=ligneClicSig;
          aff_champs_signaux(ligneClicSig+1);
        end;
      end;
    end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxSig.Items keydown',clyellow);
    with Formconfig.ListBoxSig.Items do
    begin
      if ligneClicSig<NbreSignaux-1 then
      begin
        inc(ligneClicSig);
        if AncligneClicSig<>ligneClicSig then
        begin
          AncligneClicSig:=ligneClicSig;
          aff_champs_signaux(ligneClicSig+1);
        end;
      end;
    end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then
  begin
    ListBoxSig.SelectAll;
  end;

  clicListe:=false;
end;

procedure TFormConfig.ListBoxPNMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  clicliste:=true;
  LabelInfo.caption:='';
  raz_champs_PN;

  if nbrePN<1 then
  begin
    clicListe:=false;
    exit;
  end;

  AnclignecliqueePN:=lignecliqueePN;
  lignecliqueePN:=listBoxPN.ItemIndex;
  if lignecliqueePN<0 then
  begin
    clicLIste:=false;
    exit;
  end;

  Aff_champs_PN(lignecliqueePN+1);
  clicliste:=false;
end;

procedure TFormConfig.ListBoxPNKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_delete then supprime_PN;

  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt PN keydown',clyellow);
    with Formconfig.listBoxPN do
    begin
      if lignecliqueePN>0 then
      begin
        dec(lignecliqueePN);
        //if AnclignecliqueePN<>lignecliqueePN then
        begin
          AnclignecliqueePN:=lignecliqueePN;
          aff_champs_PN(lignecliqueePN+1);
        end;
      end;
   end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt PN keydown',clyellow);
    with Formconfig.ListBoxPN do
    begin
      if lignecliqueePN<NbrePN-1 then
      begin
        inc(lignecliqueePN);
        //if AnclignecliqueePN<>lignecliqueePN then
        begin
          AnclignecliqueePN:=lignecliqueePN;
          aff_champs_PN(lignecliqueePN+1);
        end;
      end;
   end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then ListBoxPN.SelectAll;

  clicListe:=false;
end;


procedure TFormConfig.Slectionnertout1Click(Sender: TObject);
var tl: TListBox;
begin
  tl:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TlistBox ;
  tl.SelectAll;
end;


// supprimer un p�riph�rique
procedure supprime_periph;
var ss,s : string;
    n,i,j : integer;
begin
  ss:='';
  n:=0;
  for i:=0 to NbPeriph-1 do
  begin
    if formconfig.ListBoxPeriph.selected[i] then
    begin
      ss:=ss+ intToSTr(i+1)+' '+Tablo_periph[i+1].nom+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer';
  if n=1 then s:=s+' le p�riph�rique ' else s:=s+' les p�riph�riques ';
  s:=s+ss+' ?'+#13;

  // v�rifier si le p�riph�rique est utilis�

  s:=s+utilisateurs_peripheriques;

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;
  formConfig.EditNomPeriph.text:='';
  FormConfig.LabelNumeroP.Caption:='P�riph�rique ';

  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxPeriph.selected[i-1] then
    begin
      for j:=i to NbPeriph-1 do
      begin
        formconfig.ListBoxPeriph.selected[j-1]:=formconfig.ListBoxPeriph.selected[j];
        Tablo_periph[j]:=Tablo_periph[j+1];
      end;
      dec(NbPeriph);
      Tablo_periph[NbPeriph+1].NumCom:=0;
      i:=0;
    end;
    inc(i);
  until i>NbPeriph;

  if NbPeriph<=NbMaxi_periph then formConfig.LabelInfoAcc.caption:='';

  config_modifie:=true;
  FormConfig.ListBoxPeriph.Clear;
  //supprimer les champs des combos
  formModifAction.ComboBoxAccComUSB.Clear;
  formconfig.ComboBoxPNCom.Clear;
  formConfig.comboBoxDecCde.Clear;

  // r�afficher la liste
  for i:=1 to NbPeriph do
  begin  
    s:=encode_Periph(i);
    if s<>'' then
    begin
      FormConfig.ListBoxPeriph.items.Add(s);
      ajoute_champs_combos(i);
    end;
  end;
  FormConfig.MemoPeriph.Clear;
  ligneClicAccPeriph:=-1;
  AncligneClicAccPeriph:=-1;
  clicliste:=false;
end;

procedure ajoute_Periph;
var i : integer;
    s : string;
begin
  if NbPeriph>=NbMaxi_Periph then
  begin
    formconfig.labelInfo.caption:='Nombre maximal de p�riph�riques COM/USB sockets';
    exit;
  end;
  clicliste:=true;

  // d�s�lectionne tout
  with formconfig.ListBoxPeriph do
    for i:=0 to items.Count-1 do Selected[i]:=false;

  inc(NbPeriph);
  if NbPeriph>10 then formConfig.LabelInfoAcc.caption:='Nombre maxi de p�riph�riques atteint : '+intToStr(NbPeriph);

  i:=NbPeriph;
  FormConfig.LabelNumeroP.Caption:='P�riph�rique '+intToSTR(NbPeriph);
  Tablo_periph[i].nom:='';
  Tablo_periph[i].NumCom:=0;

  s:=encode_Periph(i);
  // scroller � la fin et s�lectionner
  with formconfig.ListBoxPeriph do
  begin
    items.add(s);
    selected[i-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  formconfig.LabelInfo.caption:='P�riph�rique COM/USB/Socket cr��';
  ligneClicAccPeriph:=i-1;
  AncligneClicAccPeriph:=ligneClicAccPeriph;
  Aff_champs_accPeriph_tablo(i);
  s:='Nouveau p�riph�rique';
  formModifAction.ComboBoxAccComUSB.Items.Add(s);
  formconfig.ComboBoxPNCom.Items.Add(s);
  formconfig.ComboBoxDecCde.Items.Add(s);

  maj_champs_combos(i);

  formconfig.EditNomPeriph.text:=s;
  clicliste:=false;
  config_modifie:=true;
end;

// menu contextuel des listBox
procedure TFormConfig.Supprimer1Click(Sender: TObject);
var tl: TListBox;
    s : string;
begin
  tl:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TlistBox ;
  s:=tl.name;
  if s='ListBoxActions' then supprime_action;
  if s='ListBoxPN' then supprime_PN;
  if s='ListBoxSig' then supprime_sig;
  if s='ListBoxAig' then supprime_aig;
  if s='ListBoxTrains' then supprime_Train;
  if s='ListBoxPeriph' then supprime_periph;
end;

// menu contextuel des listBox
procedure TFormConfig.Nouveau1Click(Sender: TObject);
var tl: TListBox;
    s : string;
begin
  tl:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TlistBox ;
  s:=tl.name;
  if s='ListBoxActions' then ajoute_action;
  if s='ListBoxPN' then ajoute_PN;
  if s='ListBoxSig' then ajoute_signal;
  if s='ListBoxAig' then ajoute_aiguillage;
  if s='ListBoxTrains' then ajoute_train;
  if s='ListBoxPeriph' then ajoute_periph;
end;

procedure TFormConfig.outcopierentatquetexte1Click(Sender: TObject);
var tl: TListBox;
begin
  tl:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TlistBox ;
  ClipBoard.SetTextBuf(tl.Items.GetText);
end;

procedure TFormConfig.ButtonOuvreComClick(Sender: TObject);
var i,index : integer;
begin
//  Affiche(intToSTr(componentcount),clyellow);
  for i:=1 to NbMaxi_Periph do
  begin
    index:=com_socket(i);
    if index=1 then deconnecte_usb_periph(i);
    if index=2 then deconnecte_socket_periph(i);
  end;

  for i:=1 to NbPeriph do
  begin
    if com_socket(i)=1 then  // si port com$usb
    begin
      if connecte_usb_periph(i) then
        Affiche('COM'+intToSTR(Tablo_periph[i].numcom)+' p�riph�rique ouvert',clLime)
      else Affiche('COM'+intToSTR(Tablo_periph[i].numcom)+' p�riph�rique non ouvert',clOrange);
    end
    else
    begin  // si port com socket
      if connecte_socket_periph(i) then Affiche('Socket '+Tablo_periph[i].protocole+' demande ouverture ',clLime)
      else
        Affiche('Socket '+Tablo_periph[i].protocole+' commande p�riph�rique non ouvert',clOrange);
    end;
  end;
end;


procedure TFormConfig.ButtonAjAccComClick(Sender: TObject);
begin
  ajoute_Periph;
end;

procedure TFormConfig.EditNomPeriphChange(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  if affevt then affiche('Evt Edit act Change',clyellow);
  with Formconfig do
  begin
    s:=EditNomPeriph.Text;
    Tablo_periph[ligneClicAccPeriph+1].nom:=s;
    maj_champs_combos(ligneClicAccPeriph+1);
    s:=encode_Periph(ligneClicAccPeriph+1);
    ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
    ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
  end;
end;

procedure TFormConfig.ListBoxPeriphMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,lc : integer;
    s,sc : string;
begin
  clicliste:=true;
  if NbPeriph<1 then exit;
  with Formconfig.ListBoxPeriph do
  begin
    i:=0;
    lc:=itemindex;
    //Affiche('num�ro de la ligne cliqu�e '+intToStr(lc),clyellow);
    s:=Uppercase(items[lc]);   // ligne cliqu�e
    if s='' then
    begin
      ligneClicAccPeriph:=-1;
      exit;
    end;

    AncligneClicAccPeriph:=ligneClicAccPeriph;
    ligneClicAccPeriph:=lc;
  end;

  LabelNumeroP.Caption:='P�riph�rique '+intToSTR(lc+1);

  Aff_champs_accPeriph_tablo(lc+1);
  s:=utilisateurs_peripheriques;
  MemoPeriph.Clear;
  repeat
    i:=pos(#13,s);
    if i<>0 then
    begin
      sc:=copy(s,1,i-1);
      MemoPeriph.Lines.add(sc);
      delete(s,1,i);
    end;
  until i=0;

  clicliste:=false;
end;


procedure TFormConfig.ButtonSupAccComClick(Sender: TObject);
begin
  supprime_periph;
end;

procedure TFormConfig.ListBoxPeriphKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if NbPeriph<1 then exit;
  if key=VK_delete then supprime_periph;
  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxPeriph.Items keydown',clyellow);
    with Formconfig.ListBoxPeriph.Items do
    begin
      if ligneClicAccPeriph>0 then
      begin
        AncligneClicAccPeriph:=ligneClicAccPeriph;
        dec(ligneClicAccPeriph);
        if AncligneClicAccPeriph<>ligneClicAccPeriph then
        begin
          Aff_champs_accPeriph_tablo(ligneClicAccPeriph+1);
          LabelNumeroP.Caption:='P�riph�rique '+intToSTR(ligneClicAccPeriph+1);
        end;
      end;
    end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxPeriph.Items keydown',clyellow);
    with Formconfig.ListBoxPeriph.Items do
    begin
      if ligneClicAccPeriph<NbPeriph-1 then
      begin
        AncligneClicAccPeriph:=ligneClicAccPeriph;
        inc(ligneClicAccPeriph);
        if AncligneClicAccPeriph<>ligneClicAccPeriph then
        begin
          Aff_champs_accPeriph_tablo(ligneClicAccPeriph+1);
          LabelNumeroP.Caption:='P�riph�rique '+intToSTR(ligneClicAccPeriph+1);
        end;
      end;
   end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then
  begin
    ListBoxPeriph.SelectAll;
  end;

  clicListe:=false;
end;

procedure TFormConfig.RadioButtonSimpleClick(Sender: TObject);
begin
  if clicliste then exit;
  if affevt then Affiche('Evt RadioButtonSimple',clyellow);
  GroupBoxPNA.Visible:=true;
  GroupBoxPNZ.Visible:=false;
  if lignecliqueePN<0 then exit;
  tablo_pn[lignecliqueePN+1].actionneur:=true;
end;

procedure TFormConfig.RadioButtonZoneClick(Sender: TObject);
begin
  if clicliste then exit;
  if affevt then Affiche('Evt RadioButtonZone',clyellow);
  GroupBoxPNA.Visible:=false;
  GroupBoxPNZ.Visible:=true;
  if lignecliqueePN<0 then exit;
  tablo_pn[lignecliqueePN+1].actionneur:=false;
end;


procedure TFormConfig.RadioGroupActPNClick(Sender: TObject);
var s : string;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt radio',clyellow);
  begin
    if RadioGroupActPN.itemindex=0 then
    begin
      tablo_PN[lignecliqueePN+1].TypeCde:=0;
      champs_PN_Act;
    end;
    if RadioGroupActPN.itemindex=1 then
    begin
      tablo_PN[lignecliqueePN+1].TypeCde:=1;
      champs_PN_COMUSBSockets;
    end;
    s:=encode_act_PN(lignecliqueePN+1);
    ListBoxPN.items[lignecliqueePN]:=s;
  end;
end;

procedure TFormConfig.ComboBoxPNComChange(Sender: TObject);
var s : string;
begin
  if clicliste or (lignecliqueePN<0) then exit;
  if affevt then affiche('Evt Edit portPN Change',clyellow);
  Tablo_PN[lignecliqueePN+1].AdresseFerme:=ComboBoxPNCom.ItemIndex+1;
  s:=encode_act_PN(lignecliqueePN+1);
  ListBoxPN.Items[lignecliqueePN]:=s;
  ListBoxPN.Selected[lignecliqueePN]:=true;
end;

procedure TFormConfig.ComboBoxDecCdeChange(Sender: TObject);
begin
  if affevt then affiche('Evt ComboDecCde',clyellow);
  if decCourant=0 then exit;
  Decodeur_pers[decCourant].Peripherique:=ComboBoxDecCde.ItemIndex+1;
end;

procedure TFormConfig.RadioCdeDecClick(Sender: TObject);
begin
  if radioCdeDec.ItemIndex=0 then Champs_dec_Centrale;
  if radioCdeDec.ItemIndex=1 then Champs_dec_Periph;
end;

procedure TFormConfig.Toutslectionner1Click(Sender: TObject);
var tc : Trichedit;
begin
  tc:=(Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TRichEdit ;
  tc.SelectAll;
end;


procedure TFormConfig.ButtonChercheClick(Sender: TObject);
var  s,sc : string;
    l,i : integer;
    trouve : boolean;
begin
  sc:=lowercase(editchercher.Text);
  with RichBranche do
  begin
    repeat
      s:=lowercase(Lines[ligneCherche]);
      positionErreur:=pos(sc,s);
      trouve:=positionErreur<>0;
      inc(LigneCherche);
    until (LigneCherche>=Lines.Count) or trouve;

    if trouve then
    begin
      inc(compt_Ligne);
      //Affiche('trouv� en '+Lines[ligneErreur-1],clred);
      l:=0;
      for i:=0 to ligneCherche-1 do
      begin
        l:=l+length(Lines[i])+2;
      end;
      SelStart:= l-length(s)+positionErreur-3;
      SelLength:=length(sc);
      //SetFocus;      // afficher la s�lection
      Perform(EM_SCROLLCARET,0,0); // et scroller � l'endroit de la s�lection
    end
    else
    begin
      LigneCherche:=0;
    end;
  end;
end;

procedure TFormConfig.EditChercherChange(Sender: TObject);
begin
  ligneCherche:=0;
end;

procedure raz_selection_periph;
begin
  ligneClicAccPeriph:=-1;
  AncligneClicAccPeriph:=-1;
  with formConfig do
  begin
    EditNomPeriph.text:='';
    EditPortCde.text:='';
    CheckBoxCR.checked:=false;
    CbVis.checked:=false;
    cbAig.checked:=false;
    cbDet.checked:=false;
    cbAct.checked:=false;
  end;
end;

procedure TFormConfig.SBMonteClick(Sender: TObject);
var i,n,IndexListe : integer;
    Periph : TPeripherique;
    trouve : boolean;
    s : string;
begin
  n:=ListBoxPeriph.Count;
  if n<=1 then exit;
  i:=0;
  repeat
    trouve:=ListBoxPeriph.Selected[i];
    inc(i);
  until (i=n) or trouve;
  if not(trouve) then exit;

  dec(i);
  if i=0 then exit;

  LabelNumeroP.Caption:='';
  IndexListe:=i;
  s:=ListBoxPeriph.Items[i-1];
  ListBoxPeriph.Items[i-1]:=ListBoxPeriph.Items[i];
  ListBoxPeriph.Items[i]:=s;

  inc(i);

  Periph:=Tablo_periph[i-1];
  Tablo_periph[i-1]:=Tablo_periph[i];
  Tablo_periph[i]:=Periph;

  for i:=0 to n-1 do
  begin
    ListBoxPeriph.Selected[i]:=false;
  end;
  ListBoxPeriph.Selected[IndexListe-1]:=true;

  ligneClicAccPeriph:=IndexListe-1;
  Aff_champs_accPeriph_tablo(indexListe);

  reaffecte_index_combos(indexListe+1,IndexListe,IndexListe,IndexListe+1);
  fabrique_combos_periph;

  // r�affiche les champs qui contiennent les 3 combobox de p�riph�riques
  maj_decodeurs;
  Aff_champs_PN(lignecliqueePN+1);

  config_modifie:=true;
end;

procedure TFormConfig.SBDescClick(Sender: TObject);
var i,n,IndexListe : integer;
    trouve : boolean;
    Periph : Tperipherique;
    s : string;
begin
  n:=ListBoxPeriph.Count;
  if n<=1 then exit;
  i:=0;
  repeat
    trouve:=ListBoxPeriph.Selected[i];
    inc(i);
  until (i=n) or trouve;
  if not(trouve) then exit;
  dec(i);
  if i=n-1 then exit;
  IndexListe:=i;
  LabelNumeroP.caption:='';

   // inverse les deux entr�es de la listebox
  s:=ListBoxPeriph.Items[i+1];
  ListBoxPeriph.Items[i+1]:=ListBoxPeriph.Items[i];
  ListBoxPeriph.Items[i]:=s;

  inc(i);

  // inverse les deux entr�es des p�riph�riques
  Periph:=Tablo_periph[i+1];
  Tablo_periph[i+1]:=Tablo_periph[i];
  Tablo_periph[i]:=Periph;

  for i:=0 to n-1 do
  begin
    ListBoxPeriph.Selected[i]:=false;
  end;
  ListBoxPeriph.Selected[IndexListe+1]:=true;

  ligneClicAccPeriph:=IndexListe+1;
  Aff_champs_accPeriph_tablo(indexListe+2);

  //                      ancien1,ancien2,nouveau1,nouveau2
  reaffecte_index_combos(indexListe+1,IndexListe+2,IndexListe+2,IndexListe+1);
  fabrique_combos_periph;

  // r�affiche les champs qui contiennent les 3 combobox de p�riph�riques
  maj_decodeurs;
  //aff_champs_Act(ligneclicAct+1);
  Aff_champs_PN(lignecliqueePN+1);

  config_modifie:=true;
end;


procedure TFormConfig.EditPortServeurExit(Sender: TObject);
var i,erreur : integer;
begin
  Val(EditPortServeur.Text,i,erreur);
  if (i<1) or (i>65535) then EditPortServeur.Text:=IntToSTR(PortServeur);
end;

procedure TFormConfig.EditPortServeurChange(Sender: TObject);
begin
  if activ=false then config_modifie:=true;
end;

procedure TFormConfig.EditAdrSigChange(Sender: TObject);
var s : string;
    i, erreur : integer;
begin
  if clicliste then exit;
  if affevt then Affiche('Evt adresse signal',clOrange);
  // attention interf�rence avec clic droit propri�t�s sur un signal qui g�n�re un evt sur ce contr�le
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
  with Formconfig do
  begin
    s:=EditAdrSig.Text;
    if (s='') or (ligneClicSig<0) then exit;
    Val(s,i,erreur);
    if (erreur<>0) or (i<=0) or (i>MaxAcc) then
    begin
      EditAdrSig.Color:=clred;
      LabelInfo.caption:='Erreur adresse signal ';exit;
    end;
    if (index_Signal(i)<>0) then
    begin
      EditAdrSig.Color:=clred;
      LabelInfo.caption:='Signal '+intToSTR(i)+' existe, il ne sera pas �cras�';exit;
    end;

    if Modesombre then editAdrSig.Color:=couleurfond else EditAdrSig.Color:=clWindow;
    LabelInfo.caption:=' ';
    Signaux[ligneClicSig+1].adresse:=i;
    tablo_index_signal[i]:=ligneClicSig+1;

    Signaux[ligneClicSig+1].Lbl.caption:='@'+IntToSTR(i);
    s:=encode_signal(ligneClicSig+1);
    ListBoxSig.Items[ligneClicSig]:=s;
    ListBoxSig.selected[ligneClicSig]:=true;
    Maj_Hint_Signal(ligneClicSig+1);
  end;
end;

procedure TFormConfig.EditP1Exit(Sender: TObject);
begin
 adresse_P1;
end;

procedure TFormConfig.EditP2Exit(Sender: TObject);
begin
  adresse_P2;
end;

procedure TFormConfig.ButtonCouleurClick(Sender: TObject);
begin
  scouleur:='Couleur de fond de Signaux_complexes';
  if colorDialogFond.execute then
  begin
    Couleurfond:=colorDialogFond.Color;
    Maj_couleurs;
  end;
end;

procedure TFormConfig.ColorDialogFondShow(Sender: TObject);
begin
  SetWindowText(ColorDialogFond.Handle,pchar(scouleur));
end;

procedure TFormConfig.ButtonPropageClick(Sender: TObject);
var x,y,i,adresse,AncienAdresse,AdresseBr,v,erreur : integer;
    typ : tEquipement;
    s,Nb : string;
begin
  adresse:=aiguillage[ligneclicAig+1].Adresse;
  if adresse=0 then exit;
  index:=Index_Aig(Adresse);
  AncienAdresse:=aiguillage[index].AncienAdresse;
  if Adresse=AncienAdresse then exit;

  Affiche('Propagation de l''adresse '+intToSTR(adresse)+' en remplacement de l''ancienne adresse '+intToSTR(AncienAdresse),clOrange);

  // --------- aiguillages -----------
  for i:=1 to maxaiguillage do
  begin
    typ:=aiguillage[i].modele;
    if (typ=aig) or (typ=triple) then
    begin
      if aiguillage[i].ADroit=AncienAdresse then
      begin
        aiguillage[i].ADroit:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' droit',clyellow);
        config_modifie:=true;
      end;
      if aiguillage[i].ADevie=AncienAdresse then
      begin
        aiguillage[i].ADevie:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' d�vi�',clyellow);
        config_modifie:=true;
      end;
      if aiguillage[i].APointe=AncienAdresse then
      begin
        aiguillage[i].APointe:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' pointe',clyellow);
        config_modifie:=true;
      end;
    end;
    if typ=triple then if aiguillage[index].AdrTriple=AncienAdresse then
      begin
        aiguillage[i].AdrTriple:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' triple',clyellow);
        config_modifie:=true;
      end;
    if (typ=tjd) or (typ=tjs) or (typ=crois) then
    begin
      if aiguillage[i].ADroit=AncienAdresse then
      begin
        aiguillage[i].ADroit:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' Adroit',clyellow);
        config_modifie:=true;
      end;
      if aiguillage[i].ADevie=AncienAdresse then
      begin
        aiguillage[i].ADevie:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' Ddevie',clyellow);
        config_modifie:=true;
      end;
      if aiguillage[i].DDroit=AncienAdresse then
      begin
        aiguillage[i].DDroit:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' Ddroit',clyellow);
        config_modifie:=true;
      end;
      if aiguillage[i].DDevie=AncienAdresse then
      begin
        aiguillage[i].DDevie:=adresse;
        Affiche('R�affectation aiguillage '+intToSTR(aiguillage[i].Adresse)+' Ddevie',clyellow);
        config_modifie:=true;
      end;
    end;
  end;

  // r�affecte la listebox aiguillages
  formconfig.ListBoxAig.Clear;
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_aig(i);
    formConfig.ListBoxAig.Items.AddObject(s, Pointer(clYellow));
    Aiguillage[i].modifie:=false;
  end;
  formconfig.ListBoxAig.itemindex:=0;

  // branches ----------------------------------
  for i:=1 to NbreBranches do
  begin
    Nb:='';v:=0;
    s:=Branche[i];
    repeat
      v:=posEX(',',s,v+1);
      if s[1]='A' then
      begin
        delete(s,1,1);
        val(s,adresseBr,erreur);
        if adresseBr=ancienAdresse then
        begin
          Affiche('Changement dans branche '+intToSTR(i),clYellow);
          AdresseBr:=Adresse;
          config_modifie:=true;
        end;
        Nb:=Nb+'A'+intToSTR(adresseBr)+',';
      end
      else
      if s[1]='T' then
      begin
        delete(s,1,1);
        val(s,adresseBr,erreur);
        Nb:=Nb+'T'+intToSTR(adresseBr)+',';
      end
      else
      begin
        val(s,adresseBr,erreur);
        Nb:=Nb+intToSTR(adresseBr)+',';
      end;

      v:=pos(',',s);
      delete(s,1,v);

    until (v=0);
    delete(Nb,length(nb),1);
    branche[i]:=nb;
    compile_branche(nb,i);
  end;

  clicListe:=true;
  RichBranche.clear;
  for i:=1 to NbreBranches do
  begin
    s:=Branche[i];
    RichBranche.Lines.Add(s);
    RE_ColorLine(RichBranche,RichBranche.lines.count-1,ClAqua);
  end;
  With RichBranche do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;

  // --------- signaux
  for i:=1 to NbreSignaux do
  begin
    if (signaux[i].Adr_el_suiv1=AncienAdresse) and (signaux[i].Btype_suiv1=aig) then
    begin
      signaux[i].Adr_el_suiv1:=adresse;
      Affiche('Changement dans signal '+intToSTR(signaux[i].adresse),clYellow);
      config_modifie:=true;
    end;
    if (signaux[i].Adr_el_suiv2=AncienAdresse) and (signaux[i].Btype_suiv1=aig) then 
    begin
      signaux[i].Adr_el_suiv2:=adresse;
      Affiche('Changement dans signal '+intToSTR(signaux[i].adresse),clYellow);
      config_modifie:=true;
    end;  
    if (signaux[i].Adr_el_suiv3=AncienAdresse) and (signaux[i].Btype_suiv1=aig) then 
    begin
      signaux[i].Adr_el_suiv3:=adresse;
      Affiche('Changement dans signal '+intToSTR(signaux[i].adresse),clYellow);
      config_modifie:=true;
    end;  
    if (signaux[i].Adr_el_suiv4=AncienAdresse) and (signaux[i].Btype_suiv1=aig) then
    begin
      signaux[i].Adr_el_suiv4:=adresse;
      Affiche('Changement dans signal '+intToSTR(signaux[i].adresse),clYellow);
      config_modifie:=true;
    end;  
  end;

  // TCOs
  for i:=1 to NbreTCO do
  begin
    for y:=1 to NbreCellY[i] do
      for x:=1 to NbreCellX[i] do
      begin
        if tco[i,x,y].Adresse=AncienAdresse then
        begin
          tco[i,x,y].Adresse:=Adresse;
          Affiche('Changement dans TCO '+intToSTR(i)+' cellule '+intToSTR(x)+','+intToSTR(y),clyellow);
        end;
      end;
    Affiche_TCO(i);
  end;

  ButtonPropage.Hint:='Change les adresses dans les points de connexions'+#13+
                      'des aiguillages, des branches et des signaux'+#13+
                      'si on a chang� l''adresse d''un aiguillage';
  clicListe:=false;
end;

procedure change_adr_aig;
var s : string;
    nEtat,i,vide,erreur,index,adr2,AncienAdresse : integer;
    modele: TEquipement;
    c : char;
begin
  if clicliste then exit;
  if ligneclicAig<0 then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditAdrAig.Text;
    Val(s,i,erreur);
    if (erreur<>0) or (i<=0) or (i>MaxAcc) then
    begin
      EditAdrAig.Color:=clred;
      LabelInfo.caption:='Erreur adresse Aiguillage ';exit;
    end;

    index:=ligneclicAig+1;
    if index=0 then exit;

    modele:=aiguillage[index].modele;
    // si normal ou triple
    if (erreur<>0) or (i>MaxAcc) then begin LabelInfo.caption:='Erreur adresse aiguillage ';exit;end;
    //  v�rifier si l'adresse de l'aiguillage existe d�ja

    if (aiguillage[Index_Aig(i)].modele<>rien) then
    begin
      EditAdrAig.Color:=clred;
      LabelInfo.caption:='aiguillage '+IntToSTR(i)+' existe d�j� - ne sera pas �cras�' ;
      exit;
    end;

    if Modesombre then editAdrAig.Color:=couleurfond else EditAdrAig.Color:=clWindow;
    LabelInfo.caption:=' ';

    if (modele=aig) or (modele=triple) or (modele=crois) then
    begin
      if Modesombre then editAdrAig.Color:=couleurfond else EditAdrAig.Color:=clWindow;
      LabelInfo.caption:=' ';
      aiguillage[index].adresse:=i;
      aiguillage[index].modifie:=true;
      tablo_index_aiguillage[i]:=index;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[ligneclicAig]:=s;
      formconfig.ListBoxAig.selected[ligneclicAig]:=true;
    end;

    if (modele=tjd) or (modele=tjs) then
    begin
      clicListe:=true;
      nEtat:=aiguillage[index].EtatTJD;
      if nEtat=4 then
      begin
      // modifier les champs P1 et P2 avec la nouvelle adresse
        val(editP1.Text,vide,erreur);
        if erreur<>0 then c:=editP1.text[erreur] else c:='D';
        editP1.Text:=IntToSTR(i)+c;
        val(editP2.Text,vide,erreur);
        if erreur<>0 then c:=editP2.text[erreur] else c:='D';
        editP2.Text:=IntToSTR(i)+c;
      end;
      clicListe:=false;

      aiguillage[index].adresse:=i;
      tablo_index_aiguillage[i]:=index;
      aiguillage[index].modifie:=true;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[index-1]:=s;
      formconfig.ListBoxAig.selected[ligneclicAig]:=true;

      // modif homologue
      adr2:=aiguillage[index].Ddroit;
      index:=index_aig(adr2);
      if index<>0 then
      begin
        aiguillage[index].dDroit:=i;
        aiguillage[index].dDevie:=i;
        s:=encode_aig(index);
        formconfig.ListBoxAig.items[index-1]:=s;
      end;
      ListBoxSig.selected[ligneClicSig]:=true;
    end;

    adresse:=aiguillage[ligneclicAig+1].Adresse;
    if adresse=0 then exit;
    index:=Index_Aig(Adresse);
    AncienAdresse:=aiguillage[index].AncienAdresse;
    if adresse<>AncienAdresse then
    ButtonPropage.Hint:='Change les adresses '+intToSTR(AncienAdresse)+' dans les points de connexions'+#13+
                         'des aiguillages et des branches par l''adresse '+intToSTR(adresse);
  end;
end;

procedure TFormConfig.EditAdrAigExit(Sender: TObject);
begin
  exit;
  change_adr_aig;
end;


procedure TFormConfig.EditAdrAigChange(Sender: TObject);
var i : integer;
begin
  i:=ligneclicAig+1;
  if (i<1) or (i>MaxAiguillage) then exit;
  change_adr_aig;
end;

procedure affiche_echelle;
var s : string;
begin
  s:='La vitesse en km/h est calcul�e pour l''�chelle ';
  case echelle of
  0 : s:=s+'H0';
  1 : s:=s+'N';
  2 : s:=s+'Z';
  end;

  formConfig.LabelEchelle.caption:=s;
end;

procedure TFormConfig.FormActivate(Sender: TObject);
  var i : integer;
    s : string;
begin
  if affevt or (debug=1) then affiche('FormConfig activate',clLime);
  activ:=true;
  clicListe:=false;
  Edit_HG.Visible:=false;
  labelHG.Visible:=false;
  EditP1.Visible:=false;          
  EditP2.Visible:=false;
  EditP3.Visible:=false;
  EditP4.Visible:=false;
  LabelTJD1.Visible:=false;
  LabelTJD2.Visible:=false;
  EditDevieS2.Visible:=false;
  Label18.Visible:=false;
  Label20.Visible:=false;
 // if AvecRoulage=1 then LabelInfVitesse.Visible:=false else LabelInfVitesse.Visible:=true;

  EditP1.ReadOnly:=false;
  EditP2.ReadOnly:=false;
  EditP3.ReadOnly:=false;
  EditP4.ReadOnly:=false;
  EditPointe_BG.ReadOnly:=false;
  EditDevie_HD.ReadOnly:=false;
  EditDroit_BD.ReadOnly:=false;
  Edit_HG.ReadOnly:=false;

  CheckBoxAffMemo.Checked:=AffMemoFenetre=1;
  //EditNbCantons.text:=intToSTR(Nb_cantons_Sig);
  EditTempoSignal.Text:=IntToSTR(Tempo_Signal);
  ComboBoxEchelle.ItemIndex:=echelle;
  Affiche_echelle;

  //EditNbDetDist.text:=IntToSTR(Nb_Det_dist);
  EditAdrIPCDM.text:=adresseIPCDM;
  EditPortCDM.Text:=IntToSTR(portCDM);
  EditIPLenz.text:=AdresseIP;
  EditportLenz.text:=IntToSTR(PortInterface);
  EditTempoAig.Text:=IntToSTR(Tempo_Aig);
  EditOuvreEcran.Text:=intToSTR(ecran_SC);
  EditComUSB.Text:=PortCom;
  EditFonte.text:=IntToSTR(TailleFonte);
  editdebug.Text:=IntToSTR(debug);
  CheckBoxVerifXpressNet.Checked:=Verif_AdrXpressNet=1;
  editPortServeur.Text:=intToSTR(portServeur);
  EditTempoOctetUSB.text:=IntToSTR(TempoOctet);
  EditTempoReponse.Text:=IntToSTR(TimoutMaxInterface);
  RadioButton1.checked:=false;
  RadioButton2.checked:=false;
  if Valeur_entete=0 then RadioButton1.checked:=true;
  if Valeur_entete=1 then RadioButton2.checked:=true;
  LabelInfo.Width:=240;LabelInfo.Height:=65;LabelInfo.AutoSize:=false;
  LabelResult.width:=137;LabelResult.Height:=25;

  CheckVerifVersion.Checked:=verifVersion;
  CheckFenEt.Checked:=Fenetre=1;
  CheckInfoVersion.Checked:=notificationVersion;
  CheckLanceCDM.Checked:=LanceCDM;
  CheckAvecTCO.checked:=avecTCO;
  CheckBandeauTCO.Checked:=MasqueBandeauTCO;

  RadioButtonSS.Checked:=ServeurInterfaceCDM=0;
  RadioButtonXN.Checked:=ServeurInterfaceCDM=1;    // Xpressnet
  RadioButtonP50.Checked:=ServeurInterfaceCDM=2;   // P50x
  RadioButtonSP.Checked:=ServeurInterfaceCDM=3;    // Sprog
  RadioButtonHSI.Checked:=ServeurInterfaceCDM=4;   // hsi88
  RadioButtonDSI2.Checked:=ServeurInterfaceCDM=5;  // Dsi2
  RadioButtonFis88.Checked:=ServeurInterfaceCDM=6; // FIS88
  RadioButtonDccpp.Checked:=ServeurInterfaceCDM=7;  // Dccpp
  RadioButtonEcos.Checked:=ServeurInterfaceCDM=8;  // Dccpp
  

  RadioButton13.Checked:=ServeurRetroCDM=1;   // automatique
  RadioButton14.Checked:=ServeurRetroCDM=2;   // LI USB
  RadioButton15.Checked:=ServeurRetroCDM=3;   // Li101F
  RadioButton16.Checked:=ServeurRetroCDM=4;   // Li100F
  RadioButton17.Checked:=ServeurRetroCDM=5;   // Li100
  RadioButton18.Checked:=ServeurRetroCDM=6;   // Genli
  checkBoxZ21.Checked:=Z21;

  CheckBoxServAig.checked:=Srvc_Aig;
  CheckBoxServDet.checked:=Srvc_Det;
  CheckBoxServAct.checked:=Srvc_Act;
  CheckServPosTrains.checked:=Srvc_Pos;
  CheckBoxSrvSig.Checked:=Srvc_Sig;
  CheckBoxSrvTdcc.Checked:=Srvc_tspd;


  CheckBoxRazSignaux.checked:=Raz_Acc_signaux;
  CheckBoxMsgAigInc.checked:=AffAigND;
  CheckBoxInitAig.checked:=AvecInitAiguillages;
  //if PilotageTrainsCDMNom then rgPilTrains.ItemIndex:=1 else rgPilTrains.ItemIndex:=0;
  CheckPosAig.checked:=AvecDemandeAiguillages;
  CheckBoxDemarUSB.checked:=AvecDemandeInterfaceUSB;
  CheckBoxDemarEth.checked:=AvecDemandeInterfaceEth;
  CheckBoxSombre.Checked:=Modesombre;

  RadioButtonXpress.Checked:=protocole=1;
  RadioButtonDcc.Checked:=protocole=2;

  if NbreDecPers>0 then
    ComboBoxNation.Itemindex:=decodeur_pers[1].nation-1;

  clicListe:=true;  // empeche le traitement de l'evt text
  editLAY.Text:=lay;

  LabelNbDecPers.caption:=intToSTR(NbreDecPers);

  //l'onglet affich� est s�lectionn� � l'appel de la fiche dans l'unit� UnitPrinc
  clicListe:=false;
  activ:=false;

  if clicproprietesSig then clicListeSignal(IndexSignalClic);
  clicproprietesSig:=false;
  if clicproprietesTrains then clicListeTrains(ligneclicTrain+1);
  clicproprietesTrains:=false;


  // aiguillages
  ListBoxAig.Clear;
  for i:=1 to MaxAiguillage do
  begin
    s:=encode_aig(i);
    ListBoxAig.Items.AddObject(s, Pointer(clRed));
    Aiguillage[i].modifie:=false;
  end;
  ListBoxAig.itemindex:=0;

  // branches � r�afficher si changement de style
  RichBranche.clear;
  for i:=1 to NbreBranches do
  begin
    s:=Branche[i];
    RichBranche.Lines.Add(s);
    // RE_ColorLine(RichBranche,RichBranche.lines.count-1,ClAqua);
  end;
  With RichBranche do
  begin
    SelStart:=0;
    Perform(EM_SCROLLCARET,0,0);
  end;

  // trains
  with ListBoxTrains do
  begin
    clear;
    for i:=1 to ntrains do items.Add(encode_train(i));
  end;

  tsbouton:=FormConfig.PageControl.ActivePage=TabSheetBouton;

  with StringGridArr do
  begin
   for i:=1 to NbDetArret do
   begin
     cells[1,i]:='';
     cells[2,i]:='';
     cells[3,i]:='';
   end;
 end;
end;


procedure Affiche_action;
var i,io,j,decl :integer;
    s : string;
begin
  // remplir la listbox en fonction des op�rations de l'action cliqu�e
  with FormConfig.ListBoxOperations do
  begin
    clear;
    for i:=1 to Tablo_Action[ligneclicAct+1].NbOperations do
    begin
      j:=Tablo_Action[ligneclicAct+1].tabloOp[i].numoperation;
      s:=operations[j].nom;
      if not(Tablo_Action[ligneclicact+1].tabloOp[i].valide) then s:=s+sd;

      if j<1 then
        items.Add(Format('%d%s', [0, 'aucune op�ration']))
      else
      begin
        io:=Tablo_Action[ligneclicAct+1].tabloOp[i].numoperation;
        affecte_operation(io,formConfig.ListBoxOperations);
      end;
      itemHeight:=16;
    end;
  end;

  formConfig.RichEditInfo.clear;
  decl:=Tablo_Action[ligneclicAct+1].declencheur;
  if decl>Nbredeclencheurs then
  begin
    clicListe:=false;
    exit;
  end;

  s:=Info_action(ligneclicAct+1);

  if decl>0 then formConfig.RichEditInfo.Lines.Add(s);
end;

procedure TFormConfig.ListBoxActionsMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if maxTablo_act<1 then exit;
  clicliste:=true;
  //Affiche('ListBoxActions mouse down',clYellow);
  ligneclicAct:=listBoxActions.ItemIndex;
  if ligneclicAct<0 then
  begin
    clicliste:=false;
    exit;
  end;

  Affiche_action;

  ClicAction:=-1;

  clicliste:=false;
end;

procedure TFormConfig.ListBoxOperationsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);var
  i,erreur: Integer;
  ItemText: string;
begin
  with ListBoxOperations do
  begin
    ItemText:=Items[index];
    val(ItemText,i,erreur);
    Delete(ItemText,1,erreur-1);
    Canvas.Fillrect(Rect);
    formConfCellTCO.ImageListIcones.Draw(Canvas, Rect.Left, Rect.Top, i);
    Canvas.Textout(Rect.Left + formConfCellTCO.ImageListIcones.Width + 2, Rect.Top, ItemText);
  end;
end;

procedure TFormConfig.ListBoxOperationsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin
  ClicAction:=ListBoxOperations.ItemIndex;
end;

procedure action_relais(i : integer);
begin
  action(i);
end;

procedure TFormConfig.ButtonTestActionClick(Sender: TObject);
begin
  if (ligneclicAct<0) then exit;
  action_relais(ligneclicact+1);   // car action est une fonction d'une form...
end;

procedure TFormConfig.ModifActionClick(Sender: TObject);
begin
  DeclencheurAffiche:=0;
  OperationAffiche:=clicaction+1;
  formModifAction.ShowModal;
end;

procedure TFormConfig.ListBoxActionsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (maxTablo_act<1) or clicliste then exit;
  if key=VK_delete then supprime_action;

  if ord(Key)=VK_UP then
  begin
    clicListe:=true;
    with ListBoxActions.Items do
    begin
      if ligneClicAct>0 then
      begin
        dec(ligneClicAct);
        affiche_action;
      end;
    end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    with Formconfig.ListBoxactions.Items do
    begin
      if ligneClicAct<MaxTablo_act-1 then
      begin
        inc(ligneClicAct);
        affiche_action;
      end;
    end;
  end;

  if (Shift=[ssCtrl]) and (key = ord('A')) then
  begin
    ListBoxActions.SelectAll;
  end;
  clicListe:=false;
end;

procedure TFormConfig.ListBoxOperationsDblClick(Sender: TObject);
var s : string;
  op,i : integer;

begin
  if (clicAction<0) or (ligneclicAct<0) or clicliste then exit;
  Tablo_Action[ligneclicAct+1].tabloOp[clicaction+1].valide:=not(Tablo_Action[ligneclicAct+1].tabloOp[clicaction+1].valide);

  op:=Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].numoperation;

  s:=ListBoxOperations.Items[clicaction];
  i:=pos(sd,s);
  if i<>0 then delete(s,i,length(sd));

  if not(Tablo_Action[ligneclicact+1].tabloOp[clicaction+1].valide) then s:=s+sd;

  listBoxOperations.Items[clicaction]:=s;
  ListBoxActions.items[ligneClicAct]:=encode_actions(ligneclicAct+1);
end;


procedure TFormConfig.SpeedButtonOuvreClick(Sender: TObject);
var s,repini :string;    i : integer;begin  if ligneclicTrain<0 then exit;
  i:=ligneclicTrain+1;
  s:=rep_icones;
  repIni:=GetCurrentDir;           // si le repertoire icones n'existe pas, il passe au sup�rieur
  OpenDialogSon.InitialDir:=s;     // �a le change de rep !!
  OpenDialogSon.DefaultExt:='bmp';
  OpenDialogSon.Title:='Ouvrir un fichier BMP';
  OpenDialogSon.Filter:='Fichiers BMP (*.BMP)|*.bmp|Tous fichiers (*.*)|*.*';
  if openDialogSon.execute then
  begin
    s:=openDialogSon.filename;
    trains[i].NomIcone:=ExtractFileName(s);
    s:=trains[i].NomIcone;
    EditIcone.Text:=s;
    trains[i].icone.Picture.LoadFromFile(s);
    //ImageTrain.Canvas.Rectangle(0,0,ImageTrain.Width,ImageTrain.Height);
    Maj_icone_train(formconfig.ImageTrain,i,clWhite);
    Maj_icone_train(Image_Train[i],i,clWhite);
    formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
    //formconfig.ImageTrain.Picture.assign(trains[i].icone.Picture);
  end;
  chDir(RepIni);
end;

procedure TFormConfig.EditIconeChange(Sender: TObject);
var s,Nom,repIni : string;begin
  if ligneclicTrain<0 then exit;
  if clicliste then exit;
  repIni:=GetCurrentDir;
  Nom:=EditIcone.Text;
  s:=repIni+'\'+rep_icones+'\'+Nom;
  if fileExists(s) then
  begin
    trains[ligneclicTrain+1].NomIcone:=nom;
   // Affiche(s,clWhite);
    trains[ligneclicTrain+1].icone.Picture.LoadFromFile(s);
    Maj_icone_train(formconfig.ImageTrain,ligneclicTrain+1,clWhite);
    formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  end;
end;

procedure TFormConfig.LabeledEditTempoDChange(Sender: TObject);
var erreur,i :integer;begin
  if clicliste then exit;
  if affevt then affiche('Evt change temps d�marre train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(LabeledEditTempoD.text,i,erreur);
  if i<0 then exit;
  trains[ligneclicTrain+1].TempsDemarreSig:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  formconfig.ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.CheckBoxSensClick(Sender: TObject);
begin  if clicliste then exit;
  if affevt then affiche('Evt inverse train',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;

  trains[ligneclicTrain+1].inverse:=CheckBoxSens.Checked;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  formconfig.ListBoxTrains.selected[ligneclicTrain]:=true;
end;


procedure TFormConfig.ButtonImRCDMClick(Sender: TObject);
var nPeriph,ia,i,j,adr : integer;    ctyp : string;
begin
  if nSeg=0 then begin LabelInfo.caption:='Pas de structure r�seau CDM trouv�e';exit;end
  else LabelInfo.caption:='';

  if Nactionneurs<>0 then
  begin
    j:=MessageDlg('Voulez-vous supprimer les actionneurs existants?'
                  ,mtConfirmation,[mbNo,mbYes],0) ;
     if j=mrNo then exit;
  end;

  ia:=1;
  for i:=0 to nSeg-1 do
  begin
    nperiph:=Segment[i].nperiph;
    for j:=0 to nPeriph-1 do
    begin
      ctyp:=Segment[i].periph[j].typ;
      if ctyp='actuator' then
      begin
        adr:=Segment[i].periph[j].adresse;
        if adr<>0 then
        begin
          actionneur[ia].adresse:=adr;
          actionneur[ia].prox1:=0;
          actionneur[ia].prox2:=0;
          inc(ia);
        end;
      end;
    end;
  end;

  dec(ia);
  Nactionneurs:=ia;

  trier_actionneurs;

  clicListe:=true;
  listBoxActionneurs.Clear;
  for i:=1 to Nactionneurs do
  begin
    ListBoxActionneurs.Items.Add(encode_actionneur(i));
  end;
  clicListe:=false;
end;

procedure supprime_detecteur;
var n,i,j : integer;
    s,ss : string;
begin
  ss:='';
  n:=0;
  for i:=0 to nDetecteurs-1 do
  begin
    if formconfig.ListBoxDet.selected[i] then
    begin
      ss:=ss+ intToSTR(adresse_detecteur[i+1])+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer ';
  if n=1 then s:=s+' le d�tecteur ' else s:=s+' les d�tecteurs ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;

  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxDet.selected[i-1] then
    begin
      Affiche('Supprime le d�tecteur '+intToSTR(adresse_detecteur[i]),clOrange);

      for j:=i to nDetecteurs-1 do
      begin
        formconfig.ListBoxDet.selected[j-1]:=formconfig.ListBoxDet.selected[j];
        Adresse_Detecteur[j]:=Adresse_detecteur[j+1];
      end;
      dec(nDetecteurs);
      i:=0;
    end;
    inc(i);
  until i>nDetecteurs;

  config_modifie:=true;
  FormConfig.ListBoxDet.Clear;

  // r�afficher la liste
  for i:=1 to nDetecteurs do
  begin
    s:=encode_detecteur(i);
    if s<>'' then
    begin
      FormConfig.ListBoxDet.items.Add(s);
    end;
  end;
  ligneClicDet:=-1;
  AncligneClicDet:=-1;
  clicliste:=false;
end;


procedure supprime_actionneur;
var n,i,j : integer;
    s,ss : string;
begin
  ss:='';
  n:=0;
  for i:=0 to nActionneurs-1 do
  begin
    if formconfig.ListBoxActionneurs.selected[i] then
    begin
      ss:=ss+ intToSTR(actionneur[i+1].adresse)+' ';
      inc(n);
    end;
  end;
  if ss='' then exit;

  s:='Voulez-vous supprimer ';
  if n=1 then s:=s+' l''actionneur ' else s:=s+' les actionneurs ';
  s:=s+ss+' ?';

  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  clicliste:=true;

  // suppression
  n:=0;
  i:=1;
  repeat
    if formconfig.ListBoxActionneurs.selected[i-1] then
    begin
      Affiche('Supprime l''actionneur '+intToSTR(actionneur[i].Adresse),clOrange);

      for j:=i to nActionneurs-1 do
      begin
        formconfig.ListBoxActionneurs.selected[j-1]:=formconfig.ListBoxActionneurs.selected[j];
        actionneur[j]:=actionneur[j+1];
      end;
      dec(nActionneurs);
      i:=0;
    end;
    inc(i);
  until i>nActionneurs;

  config_modifie:=true;
  FormConfig.ListBoxActionneurs.Clear;

  // r�afficher la liste
  for i:=1 to nActionneurs do
  begin
    s:=encode_actionneur(i);
    if s<>'' then
    begin
      FormConfig.ListBoxActionneurs.items.Add(s);
    end;
  end;
  trier_actionneurs; // recalcule les index
  ligneClicActionneur:=-1;
  AncligneClicActionneur:=-1;
  clicliste:=false;
end;

procedure TFormConfig.ButtonSupActClick(Sender: TObject);
begin
  supprime_actionneur;
end;

procedure aff_champs_Detecteurs(i : integer);
var adr : integer;
begin
  inc(i);
  with formConfig do
  begin
    adr:=Adresse_detecteur[i];
    LEAdrDet.text:=intToSTR(adr);
    LELongDet.Text:=IntToSTR(detecteur[adr].longueur);
    EditDecal.Text:=IntToSTR(detecteur[adr].distArret);
    RadioButtonArrFin.Checked:=detecteur[adr].ModeArret=1;
    RadioButtonARMil.Checked:=detecteur[adr].ModeArret=2;
  end;
end;

procedure aff_champs_Actionneurs(i : integer);
begin
  inc(i);
  with formConfig do
  begin
    LabeledEditAdrActionneur.text:=intToSTR(actionneur[i].adresse);
    prox1.Text:=intToSTR(actionneur[i].prox1);
    prox2.Text:=intToSTR(actionneur[i].prox2);
  end;
end;

procedure TFormConfig.ListBoxActionneursMouseDown(Sender: TObject;
   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);var i,lc,adresse,erreur : integer;
    s : string;
begin
  if nActionneurs<1 then exit;

  clicListe:=true;
  //raz_champs_aig;

  with Formconfig.ListBoxActionneurs do
  begin
    i:=0;
    lc:=itemindex;
    //Affiche('num�ro de la ligne cliqu�e '+intToStr(lc),clyellow);
    s:=Uppercase(items[lc]);   // ligne cliqu�e
    if s='' then
    begin
      ligneclicActionneur:=-1;
      clicListe:=false;
      exit;
    end;

    AncligneclicActionneur:=ligneclicActionneur;
    ligneclicActionneur:=lc;
  end;

  Val(s,Adresse,erreur);  // Adresse de l'aguillage
  if adresse=0 then
  begin
    clicListe:=false;
    exit;
  end;

  aff_champs_Actionneurs(lc);
  clicliste:=false;
end;

procedure TFormConfig.LabeledEditAdrActionneurChange(Sender: TObject);
var adr,i,erreur : integer;    trouve : boolean;begin  if clicliste then exit;  if (ligneclicActionneur<0) or (ligneclicActionneur>=nActionneurs) or (nactionneurs<1) then exit;
  val(LabeledEditAdrActionneur.text,adr,erreur);

  i:=1;
  repeat
    trouve:=actionneur[i].adresse=adr;
    inc(i);
  until trouve or (i>nActionneurs);
  if trouve then
  begin
    LabelInfo.Caption:='L''actionneur '+intToSTR(adr)+' existe d�ja';
    exit;
  end;
  LabelInfo.Caption:='';

  if adr<0 then exit;
  actionneur[ligneclicActionneur+1].adresse:=adr;
  formconfig.ListBoxActionneurs.items[ligneclicActionneur]:=encode_actionneur(ligneclicactionneur+1);
  formconfig.ListBoxActionneurs.selected[ligneclicActionneur]:=true;
end;

Procedure ajoute_detecteur;
var s: string;
    i : integer;
begin
  if Ndetecteurs>=NbMaxDet then
  begin
    Affiche('Nombre maximal de d�tecteurs atteint',clred);
    exit;
  end;
  clicliste:=true;

  // d�s�lectionne tout
  with formconfig.ListBoxDet do
    for i:=0 to items.Count-1 do Selected[i]:=false;

  inc(nDetecteurs);
  i:=formConfig.ListBoxDet.items.Count+1;
  s:=encode_Detecteur(0);
  // scroller � la fin et s�lectionner
  with formconfig.ListBoxDet do
  begin
    items.add(s);
    selected[i-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  formconfig.LabelInfo.caption:='Detecteur 0 cr��';
  ligneClicDet:=i-1;
  AncligneClicDet:=ligneClicDet;
  aff_champs_Detecteurs(0);
  clicliste:=false;
  config_modifie:=true;
end;


procedure ajoute_actionneur;
var i : integer;
    s : string;
begin
  if nActionneurs>=Max_actionneurs then
  begin
    Affiche('Nombre maximal d''actionneurs atteint',clRed);
    exit;
  end;
  clicliste:=true;

  // d�s�lectionne tout
  with formconfig.ListBoxActionneurs do
    for i:=0 to items.Count-1 do Selected[i]:=false;

  inc(nActionneurs);
  i:=nActionneurs;
  actionneur[i].Adresse:=0;
  actionneur[i].prox1:=0;
  actionneur[i].prox2:=0;

  s:=encode_Actionneur(i);
  // scroller � la fin et s�lectionner
  with formconfig.ListBoxActionneurs do
  begin
    items.add(s);
    selected[i-1]:=true;
    SetFocus;
    perform(WM_VSCROLL,SB_BOTTOM,0);
  end;

  formconfig.LabelInfo.caption:='Actionneur '+intToSTR(actionneur[i].Adresse)+' cr��';
  ligneClicActionneur:=i-1;
  AncligneClicActionneur:=ligneClicActionneur;
  aff_champs_Actionneurs(i);
  clicliste:=false;
  config_modifie:=true;
end;

procedure TFormConfig.ButtonNouvActClick(Sender: TObject);
begin
  ajoute_actionneur;
end;

procedure TFormConfig.ListBoxDetMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);var i,lc,adresse,erreur : integer;
    s : string;
begin
  if nDetecteurs<1 then exit;

  clicListe:=true;

  with Formconfig.ListBoxDet do
  begin
    i:=0;
    lc:=itemindex;
    //Affiche('num�ro de la ligne cliqu�e '+intToStr(lc),clyellow);
    s:=Uppercase(items[lc]);   // ligne cliqu�e
    if s='' then
    begin
      ligneclicDet:=-1;
      clicListe:=false;
      exit;
    end;

    AncligneclicDet:=lc;
    ligneclicDet:=lc;
  end;

  Val(s,Adresse,erreur);  // Adresse de l'aguillage

  aff_champs_Detecteurs(lc);
  clicliste:=false;
end;

procedure TFormConfig.Button4Click(Sender: TObject);
begin
  Ajoute_detecteur;
end;

procedure TFormConfig.Button5Click(Sender: TObject);
begin
  supprime_detecteur;
end;

procedure TFormConfig.RadioGroupLEBClick(Sender: TObject);
begin
  if clicliste or (ligneClicSig<0) then exit;
  if affevt then Affiche('Evt RadioGroupLEB',clOrange);

  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetSig then
    Signaux[ligneClicSig+1].BinLin:=radioGroupLEB.ItemIndex;
end;

procedure modif_action;
begin
  if maxTablo_act<1 then exit;
  clicliste:=true;

  ligneclicAct:=formconfig.listBoxActions.ItemIndex;
  if ligneclicAct<0 then
  begin
    clicliste:=false;
    exit;
  end;

  Affiche_action;

  clicliste:=false;

  DeclencheurAffiche:=0;    // pas de demande d'affichage onglet/op�ration
  OperationAffiche:=0;
  clicaction:=0;
  formModifAction.showModal;
end;

procedure TFormConfig.ListBoxActionsDblClick(Sender: TObject);
begin
  modif_action;
end;

procedure TFormConfig.StringGridArrSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  case ACol of
  1 : StringGridArr.hint:='Element pr�c�dent : Aiguillage = pr�c�d� de A - D�tecteur = adresse';
  2 : StringGridArr.hint:='D�tecteur';
  3 : StringGridArr.hint:='Temps d''arr�t sur le d�tecteur en seconde(s)';
  end;

  // autorise uniquement la colonne 1 � 3 � �tre chang�e
  if (ACol=1) or (ACol=2) or (Acol=3) then
    StringGridArr.Options := StringGridArr.Options + [goEditing]
  else
    StringGridArr.Options := StringGridArr.Options - [goEditing];
end;

procedure TFormConfig.StringGridArrSetEditText(Sender: TObject; ACol,ARow: Integer; const Value: String);
var i,v,erreur : integer;
    s : string;
    tprec : tequipement;
begin
  if ligneclicTrain<0 then exit;
  i:=ligneclicTrain+1;
  s:=value;
  tprec:=rien;
  if length(s)>0 then
  begin
    if s[1]='A' then
    begin
     tprec:=aig;
      delete(s,1,1);
    end
    else tprec:=det;
  end;

  val(s,v,erreur);
  if v<0 then exit;

  config_modifie:=true;
  if aCol=1 then
  begin
    trains[i].DetecteurArret[Arow].prec:=v;
    trains[i].DetecteurArret[Arow].TPrec:=tprec;
  end;
  if aCol=2 then
  begin
    trains[i].DetecteurArret[Arow].detecteur:=v;
  end;
  if aCol=3 then
  begin
    trains[i].DetecteurArret[Arow].temps:=v;
  end;
  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.EditAigTripleKeyPress(Sender: TObject;
  var Key: Char);
 var s : string;
    i,erreur,index,ancien,adr1,adr2 : integer;
    model: TEquipement;
    nouveau : boolean;
begin
  if clicliste or (ligneclicAig<0) or (ord(Key)<>VK_RETURN) then exit;
  if FormConfig.PageControl.ActivePage=FormConfig.TabSheetAig then
  with Formconfig do
  begin
    s:=EditAigTriple.Text;
    Val(s,Adr2,erreur);
    index:=ligneclicAig+1;
    if index=0 then exit;

    model:=aiguillage[index].modele;
    if (model=triple) then
    begin
      if (erreur<>0) then begin LabelInfo.caption:='Erreur adresse aiguillage ';exit;end;
      //  v�rifier si l'adresse de l'aiguillage existe d�ja
      if (aiguillage[Index_Aig(i)].modele<>rien) then
      begin
        LabelInfo.caption:='aiguillage '+IntToSTR(i)+' existe d�ja - ne sera pas �cras�' ;
        exit;
      end ;
      LabelInfo.caption:='';

      Ancien:=aiguillage[index].AdrTriple;
      adr1:=aiguillage[index].adresse;
      aiguillage[index].AdrTriple:=adr2;
      aiguillage[index].modifie:=true;
      s:=encode_aig(index);
      formconfig.ListBoxAig.items[ligneclicAig]:=s;
      formconfig.ListBoxAig.selected[ligneclicAig]:=true;

      // cr�er aiguillage homologue
      if ancien<>Adr2 then
      begin
        i:=Index_aig(ancien);
        nouveau:=i=0;
        if nouveau then
        begin
          inc(MaxAiguillage);
          i:=MaxAiguillage;
        end;

        if i>=NbreMaxiAiguillages then
        begin
          Affiche('Nombre maximal d''aiguillages atteint',clRed);
          exit;
        end;

        // cr�er homologue triple
        aiguillage[i].Adresse:=adr2;
        aiguillage[i].modele:=aig;
        aiguillage[i].Apointe:=aiguillage[index].Adroit;
        aiguillage[i].ApointeB:='D';
        aiguillage[i].ADevie:=aiguillage[index].Adevie2;
        aiguillage[i].ADevieB:=aiguillage[index].Adevie2B;
        aiguillage[i].ADroit:=aiguillage[index].Adroit;
        aiguillage[i].ADroitB:=aiguillage[index].AdroitB;
        aiguillage[i].visible:=false;
        tablo_index_aiguillage[adr2]:=i;
        s:=encode_Aig(i);
        if nouveau then
        begin
          formconfig.ListBoxAig.items.add(s);
        end
        else formconfig.ListBoxAig.items[i-1]:=s;
      end;
    end;
  end;
end;

procedure TFormConfig.ButtonRdTClick(Sender: TObject);
begin
  if ligneclicTrain>-1 then
  begin
    if trains[ligneclicTrain+1].routePref[0][0].adresse>0 then
    with FormRouteTrain do
    begin
      PageControlRoutes.ActivePageIndex:=1;
      TabSheetRA.Enabled:=false;
      IndexTrainFR:=ligneclicTrain+1;
      irPref:=1;
      ShowModal;
    end;
  end;
end;

procedure TFormConfig.LabeledEditV1Change(Sender: TObject);
var r : single;
    erreur: boolean;
begin
  if (ligneClicTrain<0) or (clicliste) then exit;
  Erreur:=false;
  try
    r:=StrToFloat(labelededitV1.Text,FormatSettings);
  except
    erreur:=true;
    LabelErreur.caption:='Erreur';
    exit;
  end;
  if not(erreur) then
  begin
    LabelErreur.caption:='';
    if (r>=0) and (r<10) then trains[ligneclicTrain+1].CoeffV1:=r
    else
    begin
      LabelErreur.caption:='Hors limites';
      exit;
    end;
  end;

  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  calcul_equations_coeff(ligneclicTrain+1);
end;

procedure TFormConfig.LabeledEditV2Change(Sender: TObject);
var r : single;
    erreur: boolean;
begin
  if (ligneClicTrain<0) or (clicliste) then exit;
  Erreur:=false;
  try
    r:=StrToFloat(labelededitV2.Text,FormatSettings);
  except
    erreur:=true;
    LabelErreur.caption:='Erreur';
    exit;
  end;
  if not(erreur) then
  begin
    LabelErreur.caption:='';
    if (r>=0) and (r<10) then trains[ligneclicTrain+1].CoeffV2:=r
    else
    begin
      LabelErreur.caption:='Hors limites';
      exit;
    end;
  end;
  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  calcul_equations_coeff(ligneclicTrain+1);
end;

procedure TFormConfig.LabeledEditV3Change(Sender: TObject);
var r : single;
    erreur: boolean;
begin
  if (ligneClicTrain<0) or (clicliste) then exit;
  Erreur:=false;
  try
    r:=StrToFloat(labelededitV3.Text,FormatSettings);
  except
    erreur:=true;
    LabelErreur.caption:='Erreur';
    exit;
  end;
  if not(erreur) then
  begin
    LabelErreur.caption:='';
    if (r>=0) and (r<10) then trains[ligneclicTrain+1].CoeffV3:=r
    else
    begin
      LabelErreur.caption:='Hors limites';
      exit;
    end;
  end;
  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  calcul_equations_coeff(ligneclicTrain+1);
end;


procedure TFormConfig.EditDecalChange(Sender: TObject);
var l,r,i,erreur : integer;
begin
  if clicListe then exit;
  val(editDecal.Text,i,erreur);
  if (erreur<>0) or (i<1) then
  begin
    labelInfo.caption:='Erreur';
    exit;
  end;
  labelInfo.caption:='';
  r:=adresse_detecteur[ligneclicDet+1];

  l:=detecteur[r].longueur;
  if i>=l then
  begin
    labelInfo.caption:='Erreur : la distance d''arr�t est sup�rieure � la longueur du d�tecteur';
    exit;
  end;

  labelInfo.caption:='';

  detecteur[r].distArret:=i;
  ListBoxDet.items[ligneclicDet]:=encode_detecteur(ligneclicDet+1);
  ListBoxDet.selected[ligneclicDet]:=true;
end;

procedure TFormConfig.RadioButtonArrFinClick(Sender: TObject);
var r,d,l : integer;
begin
  if clicListe then exit;
  r:=adresse_detecteur[ligneclicDet+1];
  l:=detecteur[r].longueur;
  d:=detecteur[r].distArret;
  if d>=l then
  begin
    labelInfo.caption:='Erreur : la distance d''arr�t est sup�rieure � la longueur du d�tecteur';
  end;
  detecteur[r].ModeArret:=1;
  ListBoxDet.items[ligneclicDet]:=encode_detecteur(ligneclicDet+1);
  ListBoxDet.selected[ligneclicDet]:=true;
end;

procedure TFormConfig.RadioButtonARMilClick(Sender: TObject);
var r : integer;
begin
  if clicListe then exit;
  r:=adresse_detecteur[ligneclicDet+1];
  detecteur[r].ModeArret:=2;
  LabelInfo.Caption:='';
  ListBoxDet.items[ligneclicDet]:=encode_detecteur(ligneclicDet+1);
  ListBoxDet.selected[ligneclicDet]:=true;
end;

// calcul vitesse r�elle en cm/s du train IdTrain, de vitesse en crans
function crans_to_Vrcms(v,idTrain : integer) : single;
var coeff : single;
begin
  result:=0;
  with trains[idTrain] do
  begin
    if v<consV2 then coeff:=pente1*v+b1
      else coeff:=pente2*v+b2;
    if coeff<>0 then result:=v/coeff;
  end;
end;

procedure calculs;
var vitesse,erreur,distArret : integer;
    coeff,vitR,TempsArret : single;
begin
  val(FormConfig.LabeledEditCalcV.text,vitesse,erreur);
  vitesse:=abs(vitesse);
  if vitesse>127 then exit;

  vitR:=crans_to_Vrcms(vitesse,ligneClicTrain+1);
  with formconfig.MemoCalc do
  begin
    Lines.Clear;
    lines.add('Vitesse='+FloatToSTRF(vitR,ffFixed,5,2)+' cm/s');

    TempsArret:=0.896*Trains[ligneClicTrain+1].cv4*Vitesse/128;
    Lines.Add('Temps d''arr�t='+FloatToSTRF(TempsArret,ffFixed,5,2)+' s');

    distArret:=round(TempsArret*vitR/2.2);   // en cm
    Lines.Add('Distance approx d''arr�t='+IntToSTR(distArret)+' cm');
  end;
end;

procedure TFormConfig.LabeledEditCalcVChange(Sender: TObject);
var vitesse,erreur : integer;
begin
  if clicListe Then exit;
  val(LabeledEditCalcV.text,vitesse,erreur);
  if vitesse>127 then
  begin
    LabeledEditCalcV.text:='127';
    exit;
  end;
  calculs;
end;

procedure TFormConfig.LabeledEditCV3Change(Sender: TObject);
var erreur,i :integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change CV3',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(LabeledEditCV3.text,i,erreur);
  if i<0 then exit;
  trains[ligneclicTrain+1].cv3:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.LabeledEditCV4Change(Sender: TObject);
var erreur,i :integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change CV4',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(LabeledEditCV4.text,i,erreur);
  if i<0 then exit;
  trains[ligneclicTrain+1].cv4:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  calculs;
end;

procedure TFormConfig.LabeledEditCransChange(Sender: TObject);
var erreur,i :integer;
begin
  if clicliste then exit;
  if affevt then affiche('Evt change Crans',clyellow);
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  val(LabeledEditCrans.text,i,erreur);
  if i<0 then exit;
  trains[ligneclicTrain+1].Crans:=i;
  formconfig.ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
end;

procedure TFormConfig.ListBoxDetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if nDetecteurs<1 then exit;

  //if key=VK_delete then supprime_detecteur;

  if ord(Key)=VK_UP then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxSig.Items keydown',clyellow);
    with Formconfig.ListBoxDet.Items do
    begin
      if ligneClicDet>0 then
      begin
        dec(ligneClicDet);
        if AncligneClicDet<>ligneClicDet then
        begin
          AncligneClicDet:=ligneClicDet;
          aff_champs_Detecteurs(LigneClicDet);
        end;
      end;
    end;
  end;

  if ord(Key)=VK_DOWN then
  begin
    if clicListe then exit;
    clicListe:=true;
    if affevt then affiche('Evt ListBoxSig.Items keydown',clyellow);
    with Formconfig.ListBoxDet.Items do
    begin
      if ligneClicDet<nDetecteurs-1 then
      begin
        inc(ligneClicDet);
        if AncligneClicDet<>ligneClicDet then
        begin
          AncligneClicDet:=ligneClicDet;
          aff_champs_Detecteurs(ligneClicDet);
        end;
      end;
    end;
  end;

  if (Shift = [ssCtrl]) and (key = ord('A')) then
  begin
    ListBoxSig.SelectAll;
  end;

  clicListe:=false;
end;

procedure TFormConfig.LEAdrDetChange(Sender: TObject);
var i,erreur : integer;
    s : string;
begin
  exit;
  if clicListe then exit;
  val(LEAdrDet.text,i,erreur);
  if (erreur<>0) or (i<1) then
  begin
    labelInfo.caption:='Erreur';
    exit;
  end;
  labelInfo.caption:='';
  Adresse_detecteur[ligneclicDet+1]:=i;
  s:=encode_detecteur(ligneclicDet+1);
  formconfig.ListBoxDet.items[ligneclicDet]:=s;
  formconfig.ListBoxDet.selected[ligneclicDet]:=true;
end;

procedure TFormConfig.LElongDetChange(Sender: TObject);
var r,i,d,erreur :integer;
    s : string;
begin
  if clicListe then exit;
  val(LElongDet.Text,i,erreur);
  if (erreur<>0) or (i<1) then
  begin
    labelInfo.caption:='Erreur';
    exit;
  end;
  labelInfo.caption:='';
  r:=adresse_detecteur[ligneclicDet+1];

  d:=detecteur[r].distArret;
  if d>=i then
  begin
    labelInfo.caption:='Erreur : la longueur du d�tecteur est inf�rieure � la distance d''arr�t';
    exit;
  end;

  labelInfo.caption:='';
  detecteur[r].longueur:=i;
  s:=encode_detecteur(ligneclicDet+1);
  formconfig.ListBoxDet.items[ligneclicDet]:=s;
  formconfig.ListBoxDet.selected[ligneclicDet]:=true;
end;

procedure TFormConfig.EditPortCdeChange(Sender: TObject);
var s,te : string;
    i,v : integer;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  te:=EditPortCde.Text;
  Tablo_periph[ligneClicAccPeriph+1].Protocole:=te;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  i:=pos(':',te);if i=0 then begin LabelInfo.caption:='Syntaxe incorrecte';exit;end;
  te:=copy(te,1,i);
  i:=extract_int(te);
  if i=0 then begin LabelInfo.caption:='Erreur COM nul';exit;end;
  LabelInfo.caption:='';

  Tablo_periph[ligneClicAccPeriph+1].NumCom:=i;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;

  maj_champs_combos(ligneClicAccPeriph+1);

  // recalculer le nombre de sockets et de comusb
  // et r�affecter les num�ros de composants
  NbPeriph_COMUSB:=0;
  NbPeriph_Socket:=0;
  for i:=1 to NbMaxi_Periph do
  begin
    v:=com_socket(i);
    if v=1 then
    begin
      inc(NbPeriph_COMUSB);
      if NbPeriph_COMUSB>MaxComUSBPeriph then labelInfo.Caption:='Nombre maxi de p�riph�riques COM/USB atteint';
      Tablo_periph[i].numComposant:=NbPeriph_COMUSB;
    end;
    if v=2 then
    begin
      inc(NbPeriph_Socket);
      if NbPeriph_Socket>MaxComSocketPeriph then labelInfo.Caption:='Nombre maxi de p�riph�riques socket atteint';
      Tablo_periph[NbPeriph].numComposant:=NbPeriph_socket;
    end;
  end;
end;

procedure TFormConfig.BoutonComClick(Sender: TObject);
begin
  liste_portcom;
end;

procedure TFormConfig.EditOuvreEcranChange(Sender: TObject);
var i, erreur : integer;
begin
  begin
    val(EditOuvreEcran.text,i,erreur);
    if (erreur<>0) or (i<1) then
    begin
      labelInfo.caption:='Erreur �cran';
      exit;
    end;
    labelInfo.caption:='';
    Ecran_SC:=i;
  end;
end;

procedure TFormConfig.CheckBoxCRClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].CR:=CheckBoxCR.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;

procedure TFormConfig.CbVisClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].ScvVis:=cbVis.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;

procedure TFormConfig.cbDTRClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].DTR:=cbDTR.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;

procedure TFormConfig.cbRTSClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].RTS:=cbRTS.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;

procedure TFormConfig.cbDetClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].ScvDet:=cbDet.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;

procedure TFormConfig.CbActClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].ScvAct:=cbAct.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;

procedure TFormConfig.CbAigClick(Sender: TObject);
var s : string;
begin
  if clicliste or (ligneClicAccPeriph<0) then exit;
  Tablo_periph[ligneClicAccPeriph+1].ScvAig:=cbAig.Checked;
  s:=encode_Periph(ligneClicAccPeriph+1);
  ListBoxPeriph.Items[ligneClicAccPeriph]:=s;
  ListBoxPeriph.Selected[ligneClicAccPeriph]:=true;
end;


procedure TFormConfig.Prox1Change(Sender: TObject);
var i,erreur : integer;
    s : string;
begin
  labelInfo.caption:='';
  val(Prox1.Text,i,erreur);
  actionneur[ligneclicActionneur+1].prox1:=i;
  s:=encode_actionneur(ligneclicActionneur+1);
  formconfig.ListBoxActionneurs.items[ligneclicActionneur]:=s;
  formconfig.ListBoxActionneurs.selected[ligneclicActionneur]:=true;
end;

procedure TFormConfig.Prox2Change(Sender: TObject);
var i,erreur : integer;
    s : string;
begin
  labelInfo.caption:='';
  val(Prox2.Text,i,erreur);
  actionneur[ligneclicActionneur+1].prox2:=i;
  s:=encode_actionneur(ligneclicActionneur+1);
  formconfig.ListBoxActionneurs.items[ligneclicActionneur]:=s;
  formconfig.ListBoxActionneurs.selected[ligneclicActionneur]:=true;
end;

// gestion des fonctions -------------------
// https://wiki.freepascal.org/TTreeView

// supprime un �l�ment index d'une fonction fonc dans le tableau fonction[][]
procedure supprime_element_fonction(fonc,index : integer);
var i,n : integer;
begin
  n:=fonction[fonc,0].adresse;
  for i:=index to n-1 do
  begin
    fonction[fonc,i]:=fonction[fonc,i+1];
  end;
  if fonction[fonc,0].adresse>0 then dec(fonction[fonc,0].adresse);
end;


procedure TFormConfig.LabeledEditEtatAccChange(Sender: TObject);
var node : tTreenode;
    i,v,erreur : integer;
    s : string;
begin
  if ClicTree then exit;
  node:=TreeViewL.Selected;
  if node=nil then exit;
  i:=node.AbsoluteIndex;

  config_modifie:=true;
  val(LabeledEditEtatAcc.text,v,erreur);

  if (ComboBoxVar.ItemIndex=EtatDCC-EtatDCC) then
  begin
    if (v<0) or (v>2) then
    begin
      labelInfo.Caption:='Erreur';
      exit;
    end;
  end;

  if (ComboBoxVar.ItemIndex=EtatDet-EtatDCC) then
  begin
    if (v<0) or (v>1) then
    begin
      labelInfo.Caption:='Erreur';
      exit;
    end;
  end;

  if (ComboBoxVar.ItemIndex=EtatBoutonTCO-EtatDCC) then
  begin
    if (v<0) or (v>1) then
    begin
      labelInfo.Caption:='Erreur';
      exit;
    end;
  end;
  if (ComboBoxVar.ItemIndex=EtatMemoire-EtatDCC) then
  begin
  end;
  labelInfo.Caption:='';
  fonction[foncCourante,i].etat:=v;
  s:=texte_tv(foncCourante,i);
  node.Text:=s;
end;


procedure TFormConfig.LabeledEditDCCChange(Sender: TObject);
var node : tTreenode;
    i,v,erreur : integer;
    s : string;
begin
  if clicTree then exit;

  node:=TreeViewL.Selected;
  if node=nil then exit;
  i:=node.AbsoluteIndex;

  config_modifie:=true;
  val(LabeledEditDCC.text,v,erreur);
  if v<1 then
  begin
    labelInfo.Caption:='Erreur';
    exit;
  end;
  labelInfo.Caption:='';
  fonction[foncCourante,i].adresse:=v;
  s:=texte_tv(foncCourante,i);
  node.Text:=s;
end;


procedure TformConfig.outdployer1Click(Sender: TObject);
begin
  tout_deployer;
end;

procedure TFormConfig.ComboBoxVarDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  comboboxVar.canvas.fillrect(rect);

  // dessine l'icone
  imagelistLogic.Draw(comboBoxVar.Canvas,rect.left,rect.top,Index+EtatDCC);

  // ecrit le texte
  comboboxVar.canvas.textout(rect.left+imagelistLogic.width+2,rect.top,
                          comboboxVar.items[index]);
end;

procedure maj_champs_variable(i,foncCourante,iNode : integer);
begin
  with formconfig do
  begin
    if i=EtatDCC then
    begin
      LabelEtat.Visible:=true;
      SpinEditEtat.Visible:=true;
      RadioGroupOP.Visible:=false;
      LabeledEditEtatACC.Visible:=false;
      LabeledEditTrain.visible:=false;
      PanelAcc.Visible:=true;
      LabeledEditDcc.EditLabel.Caption:='Adresse accessoire';
      LabeledEditDCC.Text:=intToSTR(fonction[foncCourante,iNode].adresse);
      SpinEditEtat.Value:=fonction[foncCourante,iNode].etat;
      LabeledEditDCC.text:=intToSTR(fonction[foncCourante,iNode].adresse);
    end;

    if i=EtatDet then
    begin
      RadioGroupOP.Visible:=false;
      LabelEtat.Visible:=false;
      LabeledEditTrain.visible:=true;
      SpinEditEtat.Visible:=false;
      LabeledEditEtatACC.Visible:=true;
      LabeledEditDcc.EditLabel.Caption:='Adresse';
      LabeledEditTrain.Text:=fonction[foncCourante,iNode].train;
      LabeledEditEtatAcc.Text:=intToSTR(fonction[foncCourante,iNode].etat);
      LabeledEditDCC.text:=intToSTR(fonction[foncCourante,iNode].adresse);
    end;

    if i=EtatBoutonTCO then
    begin
      RadioGroupOP.Visible:=false;
      LabelEtat.Visible:=true;
      SpinEditEtat.Visible:=false;
      LabeledEditEtatACC.Visible:=true;
      LabeledEditTrain.visible:=false;
      PanelAcc.Visible:=true;
      LabeledEditDCC.Visible:=true;
      LabeledEditDcc.EditLabel.Caption:='Num�ro de bouton';
      LabeledEditDCC.Text:=intToSTR(fonction[foncCourante,iNode].adresse);
      LabeledEditEtatAcc.text:=intToSTR(fonction[foncCourante,iNode].etat);
    end;

    if i=EtatMemoire then
    begin
      with RadioGroupOP do
      begin
        Visible:=true;
        left:=208;
        top:=8;
      end;
      LabeledEditDCC.Visible:=true;
      LabeledEditDcc.EditLabel.Caption:='Num�ro de m�moire';
      LabeledEditTrain.visible:=false;
      LabeledEditEtatACC.Visible:=true;
      SpineditEtat.Visible:=false;
      LabelEtat.visible:=false;
      LabeledEditDCC.Text:=intToSTR(fonction[foncCourante,iNode].adresse);
      LabeledEditEtatAcc.text:=intToSTR(fonction[foncCourante,iNode].etat);
      RadioGroupOP.ItemIndex:=fonction[foncCourante,iNode].OpMemoire;
    end;
  end;
end;

procedure TFormConfig.ComboBoxVarChange(Sender: TObject);
var node : tTreenode;
    i,Fnode,inode : integer;
begin
  if clicListe then exit;
  node:=TreeViewL.Selected;
  if assigned(node) then
  begin
    i:=ComboBoxVar.ItemIndex;
    inode:=node.AbsoluteIndex;
    Fnode:=node.ImageIndex;
    // si le node est une fonction logique ET OU
    if isVariable(Fnode) then //and isVariable(i+opNON) then
    begin
      fonction[foncCourante,inode].typ:=i+etatDCC;
      node.Text:=texte_tv(foncCourante,inode);
      node.ImageIndex:=i+etatDCC;
      node.SelectedIndex:=i+etatDCC;

      Maj_champs_variable(i+EtatDCC,FoncCourante,inode);

    end;
  end;
end;

procedure TFormConfig.ComboBoxOperateurChange(Sender: TObject);
var node : tTreenode;
    i,inode,Fnode : integer;
begin
  if clicListe then exit;
  node:=TreeViewL.Selected;
  if assigned(node) then
  begin
    i:=ComboBoxOperateur.ItemIndex+1;
    inode:=node.AbsoluteIndex;
    Fnode:=node.ImageIndex;
    // si le node est un op�rateur ET OU NON
    if isOperateur(Fnode) and (isOperateur(i)) then
    begin
      fonction[foncCourante,inode].typ:=i;
      node.Text:=texte_tv(foncCourante,inode);
      node.ImageIndex:=i;
      node.SelectedIndex:=i;
    end;
  end;
end;


procedure TFormConfig.outcontracter1Click(Sender: TObject);
var i : integer;
begin
  for i:=0 to TreeViewL.Items.Count-1 do
  begin
    TreeViewL.Items[i].Collapse(true);
  end;
end;


procedure TFormConfig.TreeViewLChange(Sender: TObject; Node: TTreeNode);
// cliqu� ou s�lectionn� un node
var i,inode,typ,TypAdjAv,TypAdjAp,n : integer;
begin
  if Assigned(Node) then
  begin
    clicTree:=true;
    i:=node.ImageIndex;
    inode:=node.AbsoluteIndex;
    n:=fonction[foncCourante,0].adresse-1;

    //Affiche('Le node '+intToSTR(iNode)+' est '+node.Text+' image='+intToSTR(node.ImageIndex),clYellow);
    if i=foncVar then //racine du treeview
    begin
      TreeViewL.hint:='Num�ro de fonction logique';
      ComboBoxVar.Enabled:=false;
      ComboBoxOperateur.Enabled:=false;
      LabelEtat.visible:=false;
      SpineditEtat.visible:=false;
      ButtonAjOpEnfant.Enabled:=true;
      ButtonAjoutevar.enabled:=false;
      PanelAcc.Visible:=false;
      typ:=fonction[foncCourante,inode+1].typ;
      if node.HasChildren then
        ButtonAjOpEnfant.Enabled:=false
      else
        ButtonAjOpEnfant.Enabled:=true;
    end
      else ButtonAjoutevar.enabled:=true;

    if isOperateur(i) then
    begin
      // interdire mont�e descente menu
      PopupMenuFL.Items[0].Enabled:=false;
      PopupMenuFL.Items[1].Enabled:=false;

      TreeViewL.hint:='Op�rateur logique';
      ComboBoxVar.Enabled:=false;
      LabelEtat.visible:=false;
      SpineditEtat.visible:=false;
      LabeledEditEtatAcc.visible:=false;
      LabeledEditTrain.visible:=false;

      ComboBoxOperateur.Enabled:=true;
      ComboBoxOperateur.ItemIndex:=i-1;
      PanelAcc.Visible:=false;
      ButtonAjOpEnfant.Enabled:=true;
      //if i=1 then ButtonAjOpEnfant.Enabled:=false else ButtonAjOpEnfant.Enabled:=true;

      clicTree:=false;
      exit;
    end;

    if isVariable(i) then
    begin
      // autoriser mont�e descente menu que si l'adjacent est une variable
      TypAdjAv:=fonction[foncCourante,inode-1].typ;
      TypAdjAp:=fonction[foncCourante,inode+1].typ;
      if isVariable(TypAdjAv) then
      begin
        PopupMenuFL.Items[0].Enabled:=true;
      end
      else
      begin
        PopupMenuFL.Items[0].Enabled:=false;
      end;
      if isVariable(TypAdjAp) and (inode+1<=n) then
      begin
        PopupMenuFL.Items[1].Enabled:=true;
      end
      else
      begin
        PopupMenuFL.Items[1].Enabled:=false;
      end;

      TreeViewL.hint:='�tat logique';
      PanelAcc.Visible:=true;

      Maj_champs_variable(i,FoncCourante,Inode);

      ComboBoxVar.Enabled:=true;
      ComboBoxOperateur.Enabled:=false;
      ComboBoxVar.ItemIndex:=i-EtatDCC;
      ButtonAjoutevar.enabled:=true;
      ButtonAjOpEnfant.Enabled:=false;   // on ne peut pas ajouter d'op�rateur sur une variable
    end;
  end;
  clicTree:=false;
end;

// ins�re une entr�e dans le tableau fonction � l'indice index, et remplit niveau et fonc
procedure insersion(k,index,niveau,fonc : integer);
var i : integer;
begin
  for i:=fonction[k,0].adresse-1 downto index do
  begin
    fonction[k,i+1]:=fonction[k,i];
  end;
  fonction[k,index].niveau:=niveau;
  fonction[k,index].typ:=fonc;
end;

procedure insersion_simple(k,index : integer);
var i : integer;
begin
  for i:=fonction[k,0].adresse-1 downto index do
  begin
    fonction[k,i+1]:=fonction[k,i];
  end;
end;

procedure TFormConfig.Descendre1Click(Sender: TObject);
var nodeA,nodeB : tTreeNode;
    idA,idB : integer;
    fonc : Tfonction;
begin
  nodeA:=TreeviewL.Selected;
  if nodeA<>nil then
  // s'assurer que le suivant est un node fr�re
  if nodeA.GetNextSibling <> nil then
    // si oui le descendre
    // naAdd, naAddFirst, naAddChild, naAddChildFirst, naInsert  :
    // naAdd        Le nouveau node ou le node d�plac� devient le dernier fr�re de l�autre node.
    // naAddFirst   Le nouveau node ou le node d�plac� devient le 1er fr�re de l�autre node.
    // naInsert     Le nouveau node ou le node d�plac� devient le node fr�re imm�diatement avant l'autre node
    // naAddChild   Le nouveau node ou le node d�plac� devient le dernier enfant de l'autre node.
    // naAddChildFirst Le nouveau node ou le node d�plac� devient le premier enfant de l'autre node. Non reconnu en D7
  begin
    nodeB:=nodeA.GetNextSibling;
    {$IF CompilerVersion >= 28.0}   // si delphi>=11
    TreeviewL.Selected.MoveTo(nodeB,naAddChildFirst);
    {$ELSE}
    TreeviewL.Selected.MoveTo(nodeB,naAdd);
    {$IFEND}
    idA:=nodeA.AbsoluteIndex;
    idB:=nodeB.AbsoluteIndex;
    fonc:=fonction[foncCourante,iDA];
    fonction[foncCourante,idA]:=fonction[foncCourante,idB];
    fonction[foncCourante,idB]:=fonc;
    config_modifie:=true;
  end;
end;

// monter le node
procedure TFormConfig.M1Click(Sender: TObject);
var nodeA,nodeB : tTreeNode;
    idA,idB : integer;
    fonc : Tfonction;
begin
  nodeA:=TreeviewL.Selected;
  if(nodeA<>nil) then
    // Asssure qu'il y a un node fr�re au dessus
    if nodeA.GetPrevSibling <> nil then
    // oui le monter
    begin
      nodeB:=nodeA.GetPrevSibling; // celui du dessus
      idA:=nodeA.AbsoluteIndex;    // origine
      idB:=nodeB.AbsoluteIndex;    // destination
      fonc:=Fonction[foncCourante,idA];  // sauver le node origine
      TreeviewL.Selected.MoveTo(nodeB,naInsert);
      nodeB:=treeViewL.Items[idB];

      insersion_simple(fonccourante,idB);
      // remplir
      fonction[foncCourante,idB]:=fonc;
      // ajuster le niveau
      fonction[foncCourante,idB].niveau:=TreeViewL.items[idB].Level+1;
      // ajuster le parent
      fonction[foncCourante,idB].Indexprec:=TreeViewL.items[idB].Parent.AbsoluteIndex;
    end;
end;

procedure TFormConfig.ButtonVoirClick(Sender: TObject);
var i,n : integer;
    s : string;
begin
{  Affiche('tableau treeview---------',clOrange);
  for i:=0 to TreeViewL.Items.Count-1 do
  begin
    s:=inttoSTR(i)+' '+TreeViewL.Items[i].Text;
    s:=s+' Niveau=';
    s:=s+intToSTR(TreeViewL.Items[i].Level);
    if TreeViewL.Items[i].IsFirstNode then s:=s+' *';
    if TreeViewL.Items[i].HasChildren then s:=s+' ->';
    Affiche(s,clYellow);
  end;
}
  Affiche('tableau fonction----------',clOrange);
  n:=fonction[foncCourante,0].adresse;
  for i:=0 to n-1 do
  begin
    s:=inttoSTR(i)+' '+NomFonc[fonction[foncCourante,i].typ];
    if i=0 then s:=s+' Nombre='+intToSTR(Fonction[foncCourante,i].adresse)+' Num�ro='
    else  s:=s+' Niveau=';
    s:=s+intToSTR(fonction[foncCourante,i].niveau)+' idParent='+intToSTR(fonction[foncCourante,i].Indexprec);
    if i<>0 then s:=s+'  adr='+intToSTR(fonction[foncCourante,i].adresse)+' �tat='+intToSTR(fonction[foncCourante,i].etat);
    if fonction[foncCourante,i].train<>'' then s:=s+' '+fonction[foncCourante,i].train;
    Affiche(s,clYellow);
  end;
end;

// trouve le parent d'un op�rateur
procedure trouve_parent_OP(k,idNode : integer);
var j,niveau : integer;
    node : TTreenode;
begin
  niveau:=fonction[k,idnode].niveau;
  // remonter au niveau pr�c�dent
  j:=idNode;
  repeat
     dec(j);
  until (j=0) or (fonction[k,j].niveau=niveau);
  node:=formconfig.TreeViewL.Items[j];
  //if node.AbsoluteIndex<>i then Affiche('Erreur 784 : Fonction'+intToSTR(k)+': discordance '+intToSTR(Node.AbsoluteIndex)+' / '+intToSTR(idNode),clred);
  if node.Parent<>nil then fonction[k,idNode].Indexprec:=node.Parent.AbsoluteIndex
    else fonction[k,idNode].Indexprec:=node.AbsoluteIndex;
end;

procedure TFormConfig.ButtonAjOpEnfantClick(Sender: TObject);
  var node,NodeOrigine : Ttreenode;
    n,inode,inodeOrigine : integer;
begin
  n:=TreeViewL.Items.Count;
  if n>=95 then exit;
  // premier
  if n=0 then exit;

  nodeOrigine:=TreeViewL.Selected;
  if nodeOrigine=nil then exit;

  inodeOrigine:=NodeOrigine.AbsoluteIndex;

  if iNodeOrigine=0 then ButtonAjOpEnfant.Enabled:=false;

  Node:=TreeViewL.items.AddChild(nodeOrigine,NomFonc[1]) ;
  config_modifie:=true;

  Node.ImageIndex:=1;
  Node.SelectedIndex:=1;
  NodeOrigine.Expand(true);

  inode:=node.AbsoluteIndex;

  if inode<TreeViewL.Items.count then
  begin
    if not(diffusion) then Affiche('Insersion en '+inttoSTR(inode),clyellow);
    insersion(fonccourante,inode,node.level+1,opET);
  end
  else
  begin  // ajout en fin
    if not(diffusion) then Affiche('Ajout en '+inttoSTR(inode),clyellow);
    fonction[foncCourante,inode].niveau:=node.Level+1;
    fonction[foncCourante,inode].typ:=opET;
  end;

  fonction[foncCourante,inode].Indexprec:=inodeOrigine;
  fonction[foncCourante,0].adresse:=TreeViewL.Items.Count;

  trouve_parent_OP(FoncCOurante,inode);
end;

procedure supprime_fonction(n : integer);
var i : integer;
begin
  if NbreFL>0 then
  begin
    for i:=n to NbreFL-1 do
    begin
      fonction[i]:=fonction[i+1];
      NomFonction[i]:=NomFonction[i+1];
    end;
    dec(NbreFL);
    formconfig.ComboBoxFL.Clear;
    for i:=1 to NbreFL do formconfig.ComboBoxFL.Items.Add(texte_tv(i,0));

    formConfig.ComboBoxFL.ItemIndex:=-1;
  end
  else
  Affiche('Erreur de suppression',clred);
end;

// supprime un �l�ment du treeview et de fonction[]
// la suppression peut changer les niveaux
procedure supprime_node;
var inode,NivOrigine,Niv : integer;
    node,NodeOrigine : TtreeNode;
    s : string;
begin
  node:=formConfig.TreeViewL.Selected;
  if node=nil then exit;

  inode:=node.AbsoluteIndex;

  if node.HasChildren then
  begin
    s:='Voulez vous supprimer l''�l�ment ['+texte_tv(foncCourante,inode)+'] et ses enfants?';
    if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  end;

  config_modifie:=true;

  if node.HasChildren then
  begin
    NivOrigine:=node.Level;
    NodeOrigine:=node;
    inode:=NodeOrigine.AbsoluteIndex;
    Affiche('1.Supprime '+node.Text+' n='+intToSTR(NivOrigine)+' indexNode'+intToSTR(inode),clOrange);
    Supprime_element_fonction(foncCourante,inode);

    Niv:=nivorigine+1;
    while (niv>NivOrigine) and (node<>nil) do
    begin
      node:=node.GetNext;
      if node<>nil then
      begin
        Niv:=node.Level;
        if niv>NivOrigine then
        begin
          inode:=node.AbsoluteIndex;
          Affiche('2.Supprime '+node.Text+' n='+intToSTR(Niv)+' indexNode'+intToSTR(inode),clOrange);
          supprime_element_fonction(foncCourante,inode);
        end;
      end;
    end;
    nodeOrigine.delete;
    //Affiche('il reste '+intToSTR(fonction[foncCourante,0].adresse),clYellow);
    if fonction[foncCourante,0].adresse=0 then supprime_fonction(foncCourante);
    exit;
  end;

  node.Delete;
  supprime_element_fonction(foncCourante,inode);
  //Affiche('il reste '+intToSTR(fonction[foncCourante,0].adresse),clYellow);
  if fonction[foncCourante,0].adresse=0 then supprime_fonction(foncCourante);
end;

// supprime fonction logique
procedure TFormConfig.ButtonSupLogClick(Sender: TObject);
begin
  supprime_node;
end;

procedure TFormConfig.ButtonAjouteVarClick(Sender: TObject);
var NodeOrigine,node : Ttreenode;
    n,j,inode,niveau : integer;
begin
  n:=TreeViewL.Items.Count;
  if (n=0) or (n>=95) then exit;

  node:=nil;
  nodeOrigine:=TreeViewL.Selected;
  if nodeOrigine=nil then exit;

  // si le node origine est un op�rateur
  if isOperateur(nodeOrigine.ImageIndex) then
  begin
    Node:=TreeViewL.items.AddChild(nodeOrigine,NomEtatDCC);
    Node.ImageIndex:=EtatDCC;
    Node.SelectedIndex:=EtatDCC;
    NodeOrigine.Expand(true);
  end;

  // si le node origine est une variable
  if isVariable(nodeOrigine.ImageIndex) then
  begin
    Node:=TreeViewL.items.Add(nodeOrigine,NomEtatDCC);
    Node.ImageIndex:=EtatDCC;
    Node.SelectedIndex:=EtatDCC;
    NodeOrigine.Expand(true);
  end;

  config_modifie:=true;
  if node=nil then exit;

  inode:=node.AbsoluteIndex;
  //
  if inode<TreeViewL.Items.count then
  begin
    if not(diffusion) then Affiche('Insersion en '+inttoSTR(inode),clyellow);
    insersion(fonccourante,inode,node.level+1,EtatDCC);
  end
  else
  begin  // ajout en fin
    if not(diffusion) then Affiche('Ajout en '+inttoSTR(inode),clyellow);
    fonction[foncCourante,inode].niveau:=node.Level+1;
    fonction[foncCourante,inode].typ:=EtatDCC;
  end;

  Niveau:=TreeviewL.Items[inode].Level+1;

  // remonter au niveau pr�c�dent pour trouver le parent
  j:=iNode;
  repeat
    dec(j);
  until (j=0) or (fonction[foncCourante,j].niveau+1=niveau);
  fonction[foncCourante,iNode].Indexprec:=j;

  fonction[foncCourante,0].adresse:=TreeViewL.Items.Count;
end;

procedure TFormConfig.ComboBoxOperateurDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  ComboBoxOperateur.canvas.fillrect(rect);

  // Affiche l'image dans la comboboc
  imagelistLogic.Draw(ComboBoxOperateur.Canvas,rect.left,rect.top,Index+1); //+1 car on commence � 1

  if index=2 then SetTextColor(Canvas.Handle, clBlack)
    else SetTextColor(Canvas.Handle, clGray);

  // �crit le texte
  ComboBoxOperateur.canvas.textout(rect.left+imagelistLogic.width+2,rect.top,
                          ComboBoxOperateur.items[index]);
end;


// Nouvelle fonction
procedure TFormConfig.ButtonNouvFLClick(Sender: TObject);
begin
  if NbreFL>=100 then exit;
  inc(NbreFL,1);
  FoncCourante:=NbreFL; // nombre de fonctions
  ComboBoxFL.Items.add(NomVAR+' '+intToSTR(NbreFL));
  ComboBoxFL.ItemIndex:=NbreFL-1;
  LabeledEditNomLog.Text:=NomFonction[NbreFl];
  fonction[FoncCourante,0].niveau:=NbreFL;
  fonction[FoncCourante,0].typ:=FoncVar;           // identificateur de fonction

  fonction[foncCourante,0].adresse:=1;       // nombre d'�l�ments
  config_modifie:=true;
  ButtonAjOpEnfant.enabled:=false;
  ButtonAjoutevar.enabled:=false;

  treeViewL.items.Clear;
  TreeViewL.Items.add(nil,texte_tv(foncCourante,0));

  LabeledEditNumFonc.Text:=intToSTR(fonction[FoncCourante,0].niveau);
end;

procedure ComboBoxFL_mizajour;
var i : integer;
begin
  fabrique_treeview(FoncCourante);

  for i:=0 to formconfig.TreeViewL.Items.Count-1 do
  begin
    Formconfig.TreeViewL.Items[i].Expand(true);
  end;

  changeCom:=true;
  with Formconfig do
  begin
    LabelFonction.caption:='';
    LabeledEditNomLog.Text:=NomFonction[FoncCourante];
    LabeledEditNumFonc.Text:=intToSTR(fonction[FoncCourante,0].niveau);
    ButtonAjOpEnfant.enabled:=false;
    PanelACC.Visible:=false;
  end;
  changeCom:=false;
end;

procedure TFormConfig.ComboBoxFLChange(Sender: TObject);
begin
  if changeCom or ClicTree then exit;
  if affevt then Affiche('ComboBoxFL change',clyellow);
  FoncCourante:=ComboBoxFL.itemIndex+1;
  ComboBoxFL_mizajour;
end;

Function Etat_variable(k,i : integer): boolean ;
var pos,j,typ,adr : integer;
    resultat : boolean;
    train : string;
begin
  adr:=fonction[k,i].adresse;
  typ:=fonction[k,i].typ;

  if typ=EtatDCC then // si �tat DCC
  begin
    j:=index_aig(adr);
    pos:=aiguillage[j].position;
    result:=(pos=const_droit) and (fonction[k,i].etat=2) or (pos=const_devie) and (fonction[k,i].etat=1);   // 1=d�vi� 2=droit
    exit;
  end;

  if typ=EtatDet then // si �tat d�tecteur / actionneur
  begin
    resultat:=detecteur[adr].Etat=(fonction[k,i].etat=1);
    // ajouter ici si on teste un train sur d�tecteur
    train:=fonction[k,i].train;
    if train<>'' then
    begin
      //Affiche('Eval45 '+intToSTR(adr)+' '+Train,clwhite);
      if detecteur[adr].Train<>train then resultat:=false;
    end;
    result:=resultat;
    exit;
  end;

  if typ=EtatBoutonTCO then
  begin
    pos:=BoutonTCO[adr].etat;
    result:=((pos=1) and (fonction[k,i].etat=1)) or ((pos=0) and (fonction[k,i].etat=0));
    exit;
  end;

  if typ=EtatMemoire then
  begin
    pos:=memoire[adr];
    case fonction[k,i].OpMemoire of
    0 : result:=pos=fonction[k,i].etat;
    1 : result:=pos>fonction[k,i].etat;
    2 : result:=pos<fonction[k,i].etat;
    end;
    exit;
  end;
end;

// donne le suivant de m�me niveau de m�me index pr�c�dent
function suivant_niveau(k,i : integer) : integer;
var n,idparent,Niveau : integer;
    trouve : boolean;
begin
  n:=fonction[k,0].adresse;
  Niveau:=fonction[k,i].niveau;
  idparent:=fonction[k,i].Indexprec;
  repeat
    inc(i);
    trouve:=(fonction[k,i].niveau=niveau) and (fonction[k,i].IndexPrec=idparent);
  until trouve or (i>=n-1);

  if trouve then result:=i else result:=-1;
end;

// �value en r�cursif une branche d'op�rateur de fonction
// k : num�ro de fonction ; i : index dans l'arbre de la fonction ; compteur: compteur d'op�rande de l'op�rateur
function evalue_operateur(k,i,compteur : integer;var formule : string) : boolean;
var typ,typOP,niv,niveau,parent,suivant : integer;
    debugFonction,resultatOP,resultat : boolean;
    s : string;
begin
  debugFonction:=false;
  repeat
    typ:=fonction[k,i].typ;
    niveau:=fonction[k,i].niveau;
    niv:=niveau;
    fonction[k,i].traite:=true;
    if debugFonction then Affiche(IntToSTR(i)+' trait�',clyellow);

    if IsVariable(typ) then
    begin
      typOP:=fonction[k,i-1].typ; // type de l'op�rande � l'index pr�c�dent
      while isVariable(typ) and (niveau=niv) do
      begin
        if compteur=0 then
        begin
          resultat:=etat_variable(k,i);
        end
        else     // ************1er �tat de la variable
        begin
          if typOP=opET then resultat:=etat_variable(k,i) and resultat;
          if typOP=opOU then resultat:=etat_variable(k,i) or resultat;
          if typOP=opNonEt then resultat:=not(etat_variable(k,i) and resultat);
          if typOP=opNonOu then resultat:=not(etat_variable(k,i) or resultat);
        end;
        if compteur>0 then formule:=formule+', ';
        formule:=formule+texte_simple_tv(k,i);

        if debugFonction then
        begin
          s:='Id='+intToSTR(i)+' '+texte_TV(k,i);
          if resultat then s:=s+' 1' else s:=s+' 0';
          Affiche(s,clYellow);
        end;
        fonction[k,i].traite:=true;
        //Affiche(IntToSTR(i)+' trait�',clyellow);

        inc(i);
        inc(compteur);
        typ:=fonction[k,i].typ;
        niv:=fonction[k,i].niveau;
      end;
      // on sort car on vient de rencontrer un niveau diff�rent
      {if (compteur=1) and ((typOP=opNonET) or (typOP=opNonOU)) then
      begin
        resultat:=not(resultat); // inversion en cas d'une seule variable
        if debugFonction then
        begin
          if resultat then affiche('inversion R=1',clOrange) else affiche('inversion R=0',clOrange);
        end;
      end; }

      if niv<niveau then
      begin
        if debugFonction then Affiche('Sortie A car niveau inf�rieur � l''index '+intToSTR(i),clLime);
        formule:=formule+')';
        //Affiche(')',clyellow);
        result:=resultat;
        exit;
      end;
    end;

    if IsOperateur(typ) then
    begin
      if debugFonction then Affiche('Id='+intToSTR(i)+' '+texte_TV(k,i),clWhite);
      if i>1 then formule:=formule+', ';
      formule:=formule+texte_simple_tv(k,i)+'(';
      fonction[k,i].traite:=true;

      inc(i);
      resultatOP:=evalue_operateur(k,i,0,formule); //entr�e r�cursive ***********************
      dec(i);

      if debugFonction then
      begin
        s:='-------------R�sultat de l''op�rateur index '+intToSTR(i)+': ';
        if resultatOP then s:=s+'R= 1' else s:=s+'R= 0';
      end;

      parent:=fonction[k,i].Indexprec;
      typ:=fonction[k,parent].typ;
      if compteur=0 then resultat:=resultatOP else
      begin
        if debugfonction then Affiche('Passage0 1 variable',clWhite);
        if typ=opET then resultat:=resultat and resultatOP;
        if typ=opOU then resultat:=resultat or resultatOP;
        if typOP=opNonEt then resultat:=not(resultat and resultatOP);
        if typOP=opNonOu then resultat:=not(resultat or resultatOP);
      end;
      inc(compteur);
      if debugFonction then
      begin
        if resultat then s:=s+'r�sultat chain� R=1' else s:=s+'r�sultat chain� R=0';
        Affiche(s,clYellow);
      end;

      if fonction[k,i].traite then
      begin
        //il faut le suivant au i de m�me niveau et de m�me pr�c�dent
        suivant:=suivant_niveau(k,i);
        if debugFonction then Affiche('Suivant � l''index '+intToSTR(i)+' est '+intToSTR(suivant),clYellow);
        if suivant=-1 then
        begin
          result:=resultat;
          if debugFonction then Affiche('Sortie B ',clYellow);
          if i<>1 then formule:=formule+')';  // dernier )
          //Affiche(intToSTR(i)+')',clred);
          exit;
        end;
        i:=suivant;
      end;

      //suivant:=suivant_niveau(k,i);
      if (suivant=-1) and (fonction[k,i].niveau=2) then
      begin
        result:=resultat;
        if debugFonction then Affiche('Sortie finale ',clYellow);
        exit;
      end;
    end;

  until i>=fonction[k,0].adresse;

  result:=resultat;
end;

// �value la fonction NumFonc, et renvoie dans s sa formule
function evalue_fonction(NumFonc : integer;var formule : string) : boolean;
var i,nbre : integer;
begin
  nbre:=fonction[Numfonc,0].adresse;
  if nbre<2 then exit;

  for i:=1 to nbre-1 do
  begin
    fonction[NumFonc,i].traite:=false;
  end;

  formule:='';

  fonction[numFonc,0].etatprec:=fonction[numFonc,0].etatactuel;
  fonction[numFonc,0].etatactuel:=evalue_operateur(Numfonc,1,0,formule) ;    // pour g�rer le front montant
  result:=fonction[numFonc,0].etatactuel;
end;

procedure TFormConfig.ButtonEvalueClick(Sender: TObject);
var formule,vf : string;
begin
  //s:='R�sultat de fonction '+intToSTR(FoncCourante)+' '+NomFonction[FoncCourante]+' : ';

  if evalue_fonction(foncCourante,formule) then vf:='1' else vf:='0';

 // Affiche(s+vf,clLime);
  LabelFonction.caption:=formule+' = '+vf;
  //affiche(formule,clorange);

 { a:=aiguillage[1].position=const_devie;
  b:=aiguillage[2].position=const_devie;

  r:=not(a and not(b and b));
  if r then Affiche('oui',clYellow) else affiche('non',clYellow); }
end;

// menu
procedure TFormConfig.Supprimer2Click(Sender: TObject);
begin
  supprime_node;
end;

procedure TFormConfig.LabeledEditNomLogChange(Sender: TObject);
begin
  if clicListe then exit;
  NomFonction[foncCourante]:=LabelededitNomLog.text;
end;

procedure TFormConfig.SpinEditEtatChange(Sender: TObject);
var i,erreur,v : integer;
    node : tTreeNode;
begin
  if ClicTree then exit;
  node:=TreeViewL.Selected;
  if node=nil then exit;
  i:=node.AbsoluteIndex;

  val(SpinEditEtat.Text,v,erreur);
  if (v<1) or (v>2) or (erreur<>0) then
  begin
    SpinEditEtat.value:=0;
    exit;
  end;
  SpinEditEtat.value:=v;
  fonction[foncCourante,i].etat:=v;
  node.Text:=texte_tv(foncCourante,i);
end;

procedure TFormConfig.LabeledEditNumFoncChange(Sender: TObject);
var v,erreur : integer;
    s : string;
begin
  if clicTree or (foncCourante=0) or changeCom or (TreeViewL=nil) then exit;
  if affevt then Affiche('LabeledEditNumFonc Change',clyellow);
  config_modifie:=true;
  val(LabeledEditNumFonc.text,v,erreur);
  if (erreur<>0) or (v<1) then exit;
  fonction[foncCourante,0].Niveau:=v;
  s:=texte_tv(foncCourante,0);
  TreeviewL.Items[0].Text:=s;
  ChangeCom:=true;
  ComboBoxFL.Items[FoncCourante-1]:=s;
  ComboBoxFL.ItemIndex:=FoncCourante-1;

  changeCom:=false;
end;

procedure TFormConfig.LabeledEditTrainChange(Sender: TObject);
var node : tTreenode;
    i : integer;
begin
  if ClicTree then exit;
  node:=TreeViewL.Selected;
  if node=nil then exit;
  i:=node.AbsoluteIndex;

  config_modifie:=true;
  fonction[foncCourante,i].train:=labeledEditTrain.Text;
  node.Text:=texte_tv(foncCourante,i);
end;

// modification d'une valeur de la listeditor
procedure TFormConfig.ValueListEditorSetEditText(Sender: TObject; ACol,ARow: Integer; const Value: String);
var i,erreur : integer;
   s : string;
   p : pointer;
begin
//  Affiche('OnSetEditText '+intToSTR(Arow)+' '+Value,clYellow);
  s:=Lowercase(Value);
  val(value,i,erreur);
  LabelInfo.caption:='';
  p:=liste[Arow].variable;
  case Arow of
  1 :  begin
         if (erreur<>0) or (i<0) then exit;
         if (i<3) then labelInfo.Caption:='Valeur nombre de d�tecteurs trop distants incorrecte'
         else integer(p^):=i; //Nb_Det_Dist:=i;
       end;
  2 :  begin
         if (erreur<>0) or (i<0) then exit;
         if (i<3) or (i>5) then labelInfo.Caption:='Valeur nombre de cantons incorrecte'
         else integer(p^):=i;  // Nb_cantons_sig:=i;
       end;
  3 :  begin
         if (erreur<>0) or (i<0) then exit;
         if (i<3) or (i>5) then labelInfo.Caption:='Valeur incorrecte'
         else integer(p^):=i;  // FiltrageDet0:=i;
       end;
  4 :  begin
         if (erreur<>0) or (i<0) then exit;
         if (i<1) or (i>5) then labelInfo.Caption:='Valeur incorrecte'
         else integer(p^):=i;  // nCantonsRes:=i;
       end;
  5 :  begin
         if s=lowercase(liste[Arow].textePL1) then AntiTimeOutEthLenz:=1 else AntiTimeOutEthLenz:=0;
       end;
  6 :  begin
         if (erreur<>0) or (i<0) then exit;
         if (i<1) or (i>5) then labelInfo.Caption:='Valeur incorrecte'
         else integer(p^):=i;  // TempoTC:=i;
       end;
  7 : begin
         if (i<50) or (i>MaxParcoursTablo) then begin labelInfo.Caption:='Valeur incorrecte';exit;end;
         integer(p^):=i;  // MaxParcours:=i;
         //if MaxParcours<50 then MaxParcours:=50;
         //if MaxParcours>MaxParcoursTablo then maxParcours:=MaxParcoursTablo;
         //ValueListEditor.onSetEditText:=nil;
         //ValueListEditor.Cells[Acol,Arow]:=intToSTR(MaxParcours);
         //ValueListEditor.onSetEditText:=ValueListEditorSetEditText;
       end;
  8 : begin
         if (erreur<>0) or (i<0) then exit;
         if (i<1) or (i>MaxRoutesCte) then labelInfo.Caption:='Valeur incorrecte'
         else MaxRoutes:=i;
         if MaxRoutes<MaxRoutesCte then MaxRoutes:=MaxRoutesCte;
         if MaxRoutes>MaxRoutesCte then MaxRoutes:=MaxRoutesCte;
       end;
  9 : begin
         Option_DemiTour:=s=lowercase(liste[Arow].textePL1);
       end;
  10: begin
         if (erreur<>0) or (i<0) then exit;
         if (i<1) or (i>1) then labelInfo.Caption:='Valeur incorrecte'
         else integer(p^):=i;  // Algo_Localisation:=i;
       end;
  11: begin
         if (erreur<>0) or (i<0) then exit;
         if (i<5) or (i>50) then labelInfo.Caption:='Valeur incorrecte'
         else integer(p^):=i;  // Max_signal_sens:=i;
       end;
  12 :begin
         AvecAck:=s=lowercase(liste[Arow].textePL1);
       end;
  13 : begin
         ServeurIPCDM_touche:=s='simulation de touches';
       end;
  14 : begin
         if length(s)<1 then labelInfo.Caption:='Valeur incorrecte'
         else string(p^):=s;  // CheminProgrammesCDM:=s;
       end;
  15 : begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1);  // PilotageTrainsCDMNom
       end;
  16 : begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1); // VisuIntercepte
       end;
  17 : begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1); // modetache
         if modeTache then
         begin
            avecAckCDM:=false;
            avecAck:=false;
         end;
       end;

  19 :  begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1);
       end;
  20 :  begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1);
       end;
  21 :  begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1);
       end;
  22 :  begin
         boolean(p^):=s=lowercase(liste[Arow].textePL1);
       end;

  end;
end;

procedure TFormConfig.ValueListEditorDrawCell(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with ValueListEditor do
  begin
    Inc(Rect.Left,2);
    Inc(Rect.Top,2);
    //DrawText(Canvas.Handle,PChar(Cells[ACol, ARow]),-1,Rect,DT_NOPREFIX or DT_WORDBREAK);
    if (Arow=18) or (aRow=0) then Canvas.Font.Style:=[fsBold] else Canvas.Font.Style:=[];
    {$IF CompilerVersion >= 28.0}
    canvas.TextOut(Rect.left+2,Rect.Top,Cells[ACol, ARow] );
    {$ELSE}
    canvas.TextOut(Rect.left,Rect.Top,Cells[ACol, ARow] );
    {$IFEND}
 end;
end;

procedure TFormConfig.ValueListEditorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var BarInfo: TScrollInfo;
begin
  exit;
  y:=y div (ValueListEditor.RowHeights[0]+1);
  if (y>high(liste)) or (y<1) then exit;
//  GetScrollInfo(ValueListEditor.Handle,Integer(SB_Vert),BarInfo);
//  Affiche('OnMouseMove scrollBar='+intToSTr(barInfo.nPos)  ,clYellow);
 // ValueListEditor.hint:=Liste[y].aide;
end;

procedure TFormConfig.RadioGroupOPClick(Sender: TObject);
var node : tTreeNode;
    i : integer;
    s : string;
begin
  if ClicTree then exit;
  node:=TreeViewL.Selected;
  if node=nil then exit;
  i:=node.AbsoluteIndex;

  config_modifie:=true;

  if (ComboBoxVar.ItemIndex=EtatMemoire-EtatDCC) then
  begin
    fonction[foncCourante,i].opMemoire:=RadioGroupOP.ItemIndex;
    s:=texte_tv(foncCourante,i);
    node.Text:=s;
  end;
end;

procedure TFormConfig.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Panel1.BevelInner:=bvNone;
  Panel1.BevelOuter:=bvLowered
end;

procedure TFormConfig.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Panel1.BevelInner:=bvNone;
  Panel1.BevelOuter:=bvRaised;
end;

procedure TFormConfig.Panel1Click(Sender: TObject);
begin
  close;
end;

procedure TFormConfig.ComboStyleChange(Sender: TObject);
var i : integer;
begin
  if clicListe then exit;
  i:=ComboStyle.ItemIndex;
  if i<0 then exit;
  Nom_Style_aff:=comboStyle.Items[i];
end;

procedure TFormConfig.RadioGroupClClick(Sender: TObject);
var typ,i : integer;
begin
 typ:=radioGroupCl.ItemIndex;
  // sombre
  ComboStyle.Clear;
  for i:=0 to NombreStyles do
  begin
   if (typ=0) or
      ((style[i].clarte=sombre) and (typ=1)) or
      ((style[i].clarte=clair) and (typ=2))
         then ComboStyle.Items.add(Style[i].NomStyle);
  end;
end;


procedure TFormConfig.ButtonlCV3Click(Sender: TObject);
var valeur : integer;
begin
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  if portCommOuvert or parSocketLenz then
  begin
    valeur:=lire_cv(3);
    if valeur=-1 then
    begin
      LabelInfo.caption:='Erreur attente trop longue CV';
      exit;
    end;
    if valeur=-2 then
    begin
      LabelInfo.caption:='Pas de r�ponse de l''interface apr�s demande de passage en mode prog';
      exit;
    end;

    clicListe:=true;
    trains[ligneclicTrain+1].cv3:=valeur;
    LabeledEditCV3.Text:=IntToSTR(valeur);
    clicListe:=false;
  end;  
end;

procedure TFormConfig.ButtonlCV4Click(Sender: TObject);
var valeur : integer;
begin
  if (ligneclicTrain<0) or (ligneclicTrain>=ntrains) or (ntrains<1) then exit;
  if portCommOuvert or parSocketLenz then
  begin
    valeur:=lire_cv(4);
    if valeur=-1 then
    begin
      LabelInfo.caption:='Erreur attente trop longue CV';
      exit;
    end;
    if valeur=-2 then
    begin
      LabelInfo.caption:='Pas de r�ponse de l''interface apr�s demande de passage en mode prog';
      exit;
    end;

    clicListe:=true;
    trains[ligneclicTrain+1].cv4:=valeur;
    LabeledEditCV4.Text:=IntToSTR(valeur);
    clicListe:=false;
  end;
end;

procedure TFormConfig.ButtonRepriseDCCClick(Sender: TObject);
begin
  if portCommOuvert or parSocketLenz then reprise_dcc;
end;

procedure boutons;
begin
  with formConfig do
  begin
    shapeBR.Brush.Color:=clGray;
    shapeB1.Brush.Color:=clGray;
    shapeB2.Brush.Color:=clGray;
    shapeB3.Brush.Color:=clGray;
    shapeB4.Brush.Color:=clGray;
    shapeB5.Brush.Color:=clGray;
    shapeB6.Brush.Color:=clGray;
    shapeB7.Brush.Color:=clGray;
    shapeB8.Brush.Color:=clGray;
    GroupBoxBt.visible:=true;
    GroupBoxBr.visible:=false;
    GroupBoxBT.caption:='Bouton n�'+intToSTR(BoutonBloc);
  end;

end;

procedure rotatif;
begin
  with formConfig do
  begin
    ShapeBR.Brush.Color:=clYellow;
    shapeB1.Brush.Color:=clGray;
    shapeB2.Brush.Color:=clGray;
    shapeB3.Brush.Color:=clGray;
    shapeB4.Brush.Color:=clGray;
    shapeB5.Brush.Color:=clGray;
    shapeB6.Brush.Color:=clGray;
    shapeB7.Brush.Color:=clGray;
    shapeB8.Brush.Color:=clGray;
    GroupBoxBR.visible:=true;
    GroupBoxBT.Visible:=false;
  end;
end;

Procedure Aff_champs_BRM;
begin
  with formConfig do
  begin
    LabeledEditRM.Text:=intToSTR(blocUSB[NumBlocUSB].rotatifM);
    LabeledEditRP.Text:=intToSTR(blocUSB[NumBlocUSB].rotatifP);
    LabeledEditClic.Text:=intToSTR(blocUSB[NumBlocUSB].clic);
    if blocUSB[NumBlocUSB].increment<1 then blocUSB[NumBlocUSB].increment:=1;
    LabeledEditIncr.Text:=intToSTR(blocUSB[NumBlocUSB].increment);
  end;
end;

procedure clic_BRM;
begin
  rotatif;
  BoutonBloc:=99;
  Aff_champs_BRM;
end;

procedure TFormConfig.ShapeBRMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  clic_BRM;
end;

procedure TFormConfig.ShapeB1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=1;
  boutons;
  ShapeB1.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp1);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp1);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp1);
end;

procedure TFormConfig.ShapeB2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=2;
  boutons;
  ShapeB2.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp2);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp2);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp2);
end;

procedure TFormConfig.ShapeB3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=3;
  boutons;
  ShapeB3.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp3);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp3);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp3);
end;

procedure TFormConfig.ShapeB4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=4;
  boutons;
  ShapeB4.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp4);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp4);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp4);
end;

procedure TFormConfig.ShapeB5MousDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=5;
  boutons;
  ShapeB5.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp5);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp5);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp5);
end;

procedure TFormConfig.ShapeB6MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=6;
  boutons;
  ShapeB6.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp6);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp6);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp6);
end;

procedure TFormConfig.ShapeB7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=7;
  boutons;
  ShapeB7.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp7);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp7);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp7);
end;

procedure TFormConfig.ShapeB8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BoutonBloc:=8;
  boutons;
  ShapeB8.Brush.Color:=clYellow;
  LabeledEditCT.Text:=intToSTR(blocUSB[NumBlocUSB].Bp8);
  LabeledEditF.Text:=intToSTR(blocUSB[NumBlocUSB].Fbp8);
  LabeledEditFn.Text:=intToSTR(blocUSB[NumBlocUSB].Fnp8);
end;

procedure TFormConfig.LabeledEditCTChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditCT.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>255) then exit;
  case BoutonBloc of
  1 : blocUSB[NumBlocUSB].Bp1:=i;
  2 : blocUSB[NumBlocUSB].Bp2:=i;
  3 : blocUSB[NumBlocUSB].Bp3:=i;
  4 : blocUSB[NumBlocUSB].Bp4:=i;
  5 : blocUSB[NumBlocUSB].Bp5:=i;
  6 : blocUSB[NumBlocUSB].Bp6:=i;
  7 : blocUSB[NumBlocUSB].Bp7:=i;
  8 : blocUSB[NumBlocUSB].Bp8:=i;
  9 : blocUSB[NumBlocUSB].Bp9:=i;
  10 : blocUSB[NumBlocUSB].Bp10:=i;
  end;
end;

procedure TFormConfig.LabeledEditRmChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditRm.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>255) then exit;
  blocUSB[NumBlocUSB].rotatifM:=i;
end;

procedure TFormConfig.LabeledEditRpChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditRp.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>255) then exit;
  blocUSB[NumBlocUSB].rotatifP:=i;
end;

procedure TFormConfig.LabeledEditClicChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditClic.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>255) then exit;
  blocUSB[NumBlocUSB].clic:=i;
end;


procedure TFormConfig.LabeledEditNUMChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditNUM.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>10) then exit;
  NumBlocUSB:=i;
  LabeledEditCT.Text:='';
  LabeledEditRM.Text:='';
  LabeledEditRP.Text:='';
  LabeledEditClic.Text:='';
  LabeledEditF.Text:='';
  LabeledEditFn.Text:='';
  ShapeBR.Brush.Color:=clGray;
  shapeB1.Brush.Color:=clGray;
  shapeB2.Brush.Color:=clGray;
  shapeB3.Brush.Color:=clGray;
  shapeB4.Brush.Color:=clGray;
  LabelID.caption:=intToSTR(i);
  //Aff_champs_BRM;
  i:=index_train_nom(BlocUSB[NumBlocUSB].AffTrain);
  ComboBoxUSBTr.ItemIndex:=i;
  label72.caption:='';
end;

procedure TFormConfig.LabeledEditFChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditF.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>30) then exit;
  case boutonbloc of
  1 : blocUSB[NumBlocUSB].Fbp1:=i;
  2 : blocUSB[NumBlocUSB].Fbp2:=i;
  3 : blocUSB[NumBlocUSB].Fbp3:=i;
  4 : blocUSB[NumBlocUSB].Fbp4:=i;
  5 : blocUSB[NumBlocUSB].Fbp5:=i;
  6 : blocUSB[NumBlocUSB].Fbp6:=i;
  7 : blocUSB[NumBlocUSB].Fbp7:=i;
  8 : blocUSB[NumBlocUSB].Fbp8:=i;
  9 : blocUSB[NumBlocUSB].Fbp9:=i;
  10 : blocUSB[NumBlocUSB].Fbp10:=i;
  end;
end;

procedure TFormConfig.LabeledEditIncrChange(Sender: TObject);
var i,erreur : integer;
begin
  val(LabeledEditIncr.Text,i,erreur);
  if (erreur<>0) or (i<1) or (i>20) then exit;
  blocUSB[NumBlocUSB].increment:=i;
end;

procedure TFormConfig.ComboBoxUSBTrChange(Sender: TObject);
var idTrain,j,i : integer;
    s,sb : string;
begin
  idTrain:=ComboBoxUSBTr.ItemIndex;

  sb:='Bloc USB '+intToSTR(NumBlocUSB);
  for j:=1 to ntrains do
  begin
    if labelBlocUSB[j].Caption=sb then labelBlocUSB[j].Caption:='';  // lib�re l'affectation
  end;

  if idTrain=0 then
  begin
    blocUSB[NumBlocUSB].AffTrain:='Pas d''affectation';
    Label72.Caption:='La s�lection du train est celle de la page principale';
    LabelBlocUSB[idTrain].caption:='';
  end
  else
  begin
    s:=trains[idTrain].nom_train;
    blocUSB[NumBlocUSB].AffTrain:=s;
    Label72.Caption:=trains[idTrain].nom_train+' s�lectionn� pour le bloc USB '+intToSTR(NumBlocUSB);
    LabelBlocUSB[idTrain].caption:=sb;
  end;

  // d�saffecte tous les trains qui ont ce num�ro de bloc USB
  for i:=1 to nTrains do
  begin
    if trains[i].BlocUSB=NumBlocUSB then trains[i].BlocUSB:=0;
  end;
  // et r�affecte
  trains[idTrain].BlocUSB:=NumBlocUSB;
end;

procedure TFormConfig.LabeledEditFnChange(Sender: TObject);
var i,erreur :integer;
begin
  val(LabeledEditFn.Text,i,erreur);
  if (erreur<>0) or (i<0) or (i>1) then exit;
  case boutonbloc of
   1 : blocUSB[NumBlocUSB].Fnp1:=i;
   2 : blocUSB[NumBlocUSB].Fnp2:=i;
   3 : blocUSB[NumBlocUSB].Fnp3:=i;
   4 : blocUSB[NumBlocUSB].Fnp4:=i;
   5 : blocUSB[NumBlocUSB].Fnp5:=i;
   6 : blocUSB[NumBlocUSB].Fnp6:=i;
   7 : blocUSB[NumBlocUSB].Fnp7:=i;
   8 : blocUSB[NumBlocUSB].Fnp8:=i;
   9 : blocUSB[NumBlocUSB].Fnp9:=i;
  10 : blocUSB[NumBlocUSB].Fnp10:=i;
  end;
end;

procedure TFormConfig.ButtonHookClick(Sender: TObject);
begin
  UnHookWindowsHookEx(KBHook);  // supprimer le hook clavier
  KBHook:=SetWindowsHookExA(WH_KEYBOARD_LL,@ClavierHookLLProc,HInstance,0);  // accrocher le hook
  Affiche('Gestionnaire d''interception des claviers USB relanc�',clWhite);
end;

procedure TFormConfig.BoutonCoulAigClick(Sender: TObject);
var i : integer;
begin
  scouleur:='Couleur de l''aiguille';
  if colorDialogFond.execute then
  begin
    i:=ComboboxCompt.ItemIndex+1;
    ParamCompteur[i].coulAig:=colorDialogFond.Color;
    aiguille_compteur(1,1,ImageCTC);
  end;
end;

procedure TFormConfig.ComboBoxComptChange(Sender: TObject);
var i : integer;
begin
  i:=comboboxCompt.ItemIndex+1;
  if i=1 then
  begin
    buttonCoulGrad.enabled:=false;
    buttonCoulFond.enabled:=false;
  end
  else
  begin
    buttonCoulGrad.enabled:=true;
    buttonCoulFond.enabled:=true;
  end;
  init_compteur(1,ImageCtC);
end;

procedure TFormConfig.ButtonCoulGradClick(Sender: TObject);
var i : integer;
begin
  scouleur:='Couleur des graduations';
  if colorDialogFond.execute then
  begin
    i:=ComboboxCompt.ItemIndex+1;
    ParamCompteur[i].coulGrad:=colorDialogFond.Color;
    init_compteur(1,formConfig.ImageCtC);
    aiguille_compteur(1,1,ImageCTC);
  end;
end;

procedure TFormConfig.ButtonCoulNumClick(Sender: TObject);
var i : integer;
begin
  scouleur:='Couleur des chiffres';
  if colorDialogFond.execute then
  begin
    i:=ComboboxCompt.ItemIndex+1;
    ParamCompteur[i].CoulNum:=colorDialogFond.Color;
    init_compteur(1,formConfig.ImageCtC);
    aiguille_compteur(1,1,ImageCTC);
  end;
end;

procedure TFormConfig.ButtonCoulFondClick(Sender: TObject);
var i : integer;
begin
  scouleur:='Couleur de fond';
  if colorDialogFond.execute then
  begin
    i:=ComboboxCompt.ItemIndex+1;
    ParamCompteur[i].coulFond:=colorDialogFond.Color;
    init_compteur(1,formConfig.ImageCtC);
    aiguille_compteur(1,1,ImageCTC);
  end;
end;

procedure TFormConfig.ButtonCoulArcClick(Sender: TObject);
var i : integer;
begin
  scouleur:='Couleur d''arc';
  if colorDialogFond.execute then
  begin
    i:=ComboboxCompt.ItemIndex+1;
    ParamCompteur[i].coulArc:=colorDialogFond.Color;
    aiguille_compteur(1,1,ImageCTC);
  end;
end;

procedure TFormConfig.ButtonModClick(Sender: TObject);
begin
  modif_action;
end;

procedure TFormConfig.ValueListEditorSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  ValueListEditor.Hint:=liste[Arow].aide;
end;

procedure TFormConfig.ComboBoxEchelleChange(Sender: TObject);
begin
  // 0 : H0 1/87
  // 1 : N 1/160
  // 2 : Z 1/220
  echelle:=ComboBoxEchelle.ItemIndex;  // de 0 � 2
  Affiche_echelle;
end;

procedure TFormConfig.ImageCourbesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var i,j,maxi : integer;
    s : string;
begin
  i:=x div 2;
  if (i<0) or (i>127) then exit;

  with ImageCourbes.Canvas do
  begin
    maxi:=ImageCourbes.Height;
    pen.Color:=clYellow;
    pen.Mode:=pmXor;
    pen.width:=1;
    if not(prem) then
    begin
      j:=maxi-(ValVitTrain[ax div 2]*2);
      moveTo(0,j);LineTo(ax,j);LineTo(ax,maxi);
    end;

    j:=maxi-(ValVitTrain[i]*2);
    moveTo(0,j);LineTo(x,j);LineTo(x,maxi);
    prem:=false;
    ax:=x;
  end;

  s:='Cran '+intToSTR(i)+' : '+intToSTR(ValVitTrain[i])+' cm/s  ';
  s:=s+intToSTR(Vr_kmh(ValVitTrain[i]))+' km/h';

  LabelValeur.caption:=s;
  with LabelCran do
  begin
    Left:=x+ImageCourbes.Left-10;
    caption:=intToSTR(i);
  end;
  with LabelVCMS do
  begin
    if j>16 then top:=j+ImageCourbes.Top-5;

    caption:=intToSTR(ValVitTrain[i]);
  end;

end;

procedure TFormConfig.LabeledEditVit1Change(Sender: TObject);
var i,erreur : integer;
begin
  if (ligneClicTrain<0) or (clicliste) then exit;
  val(labelededitVit1.Text,i,erreur);

  if erreur=0 then
  begin
    LabelErreur.caption:='';
    if i<128 then trains[ligneclicTrain+1].ConsV1:=i
    else
    begin
      LabelErreur.caption:='Hors limites';
      exit;
    end;
  end;

  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  calcul_equations_coeff(ligneclicTrain+1);
end;

procedure TFormConfig.LabeledEditVit2Change(Sender: TObject);
var i,erreur : integer;
begin
  if (ligneClicTrain<0) or (clicliste) then exit;
  val(labelededitVit2.Text,i,erreur);

  if erreur=0 then
  begin
    LabelErreur.caption:='';
    if i<128 then trains[ligneclicTrain+1].ConsV2:=i
    else
    begin
      LabelErreur.caption:='Hors limites';
      exit;
    end;
  end;

  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;
  calcul_equations_coeff(ligneclicTrain+1);

end;

procedure TFormConfig.LabeledEditVit3Change(Sender: TObject);
var i,erreur : integer;
begin
  if (ligneClicTrain<0) or (clicliste) then exit;
  val(labelededitVit3.Text,i,erreur);

  if erreur=0 then
  begin
    LabelErreur.caption:='';
    if i<128 then trains[ligneclicTrain+1].ConsV3:=i
    else
    begin
      LabelErreur.caption:='Hors limites';
      exit;
    end;
  end;

  ListBoxTrains.items[ligneclicTrain]:=encode_train(ligneclicTrain+1);
  ListBoxTrains.selected[ligneclicTrain]:=true;

  calcul_equations_coeff(ligneclicTrain+1);

end;

end.


