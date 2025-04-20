unit UnitTCO;

// ne pas utiliser les éléments 30 et 31 qui sont les anciens signaux et quais
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote, UnitDebug,
  ComCtrls ,StrUtils, math, unitconfig, UnitAnalyseSegCDM,  Buttons , verif_version,
  UnitHorloge, ImgList ;

type
  TFormTCO = class(TForm)
    PopupMenu1: TPopupMenu;
    MenuCouper: TMenuItem;
    N1: TMenuItem;
    MenuCopier: TMenuItem;
    MenuColler: TMenuItem;
    ScrollBox: TScrollBox;
    ImageTCO: TImage;
    Tourner90G: TMenuItem;
    Tourner90D: TMenuItem;
    Pos_vert: TMenuItem;
    TrackBarZoom: TTrackBar;
    PanelBas: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label50: TLabel;
    ButtonSauveTCO: TButton;
    LabelZoom: TLabel;
    ButtonConfigTCO: TButton;
    Annulercouper: TMenuItem;
    N5: TMenuItem;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ButtonSimu: TButton;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label51: TLabel;
    FontDialog1: TFontDialog;
    N2: TMenuItem;
    Signalgauchedelavoie1: TMenuItem;
    Signaldroitedelavoie1: TMenuItem;
    N3: TMenuItem;
    Signal1: TMenuItem;
    N4: TMenuItem;
    GroupBox1: TGroupBox;
    Label41: TLabel;
    EditAdrElement: TEdit;
    EditTypeImage: TEdit;
    Label71: TLabel;
    ButtonFonte: TButton;
    Label230: TLabel;
    EditTexte: TEdit;
    ComboRepr: TComboBox;
    Label65: TLabel;
    CheckPinv: TCheckBox;
    N6: TMenuItem;
    Inserer: TMenuItem;
    Supprimer: TMenuItem;
    LigneDessus: TMenuItem;
    LigneDessous: TMenuItem;
    SupprimeLigne: TMenuItem;
    Colonne: TMenuItem;
    N7: TMenuItem;
    Colonnegauche1: TMenuItem;
    Colonnedroite1: TMenuItem;
    buttonRaz: TButton;
    ButtonCalibrage: TButton;
    ButtonCoulFond: TButton;
    ColorDialog1: TColorDialog;
    ShapeCoulFond: TShape;
    Label24: TLabel;
    Label25: TLabel;
    ImagePalette1: TImage;
    ImagePalette2: TImage;
    ImagePalette3: TImage;
    ImagePalette4: TImage;
    ImagePalette5: TImage;
    ImagePalette12: TImage;
    ImagePalette13: TImage;
    ImagePalette14: TImage;
    ImagePalette15: TImage;
    ImagePalette21: TImage;
    ImagePalette22: TImage;
    ImagePalette6: TImage;
    ImagePalette7: TImage;
    ImagePalette9: TImage;
    ImagePalette16: TImage;
    ImagePalette17: TImage;
    ImagePalette18: TImage;
    ImagePalette19: TImage;
    ImagePalette20: TImage;
    ImagePalette24: TImage;
    ImagePalette25: TImage;
    ImagePalette10: TImage;
    ImagePalette11: TImage;
    ImagePalette51: TImage;
    ImagePalette50: TImage;
    ImagePalette8: TImage;
    ImageTemp: TImage;
    ImageTemp2: TImage;
    Toutslectionner1: TMenuItem;
    ButtonDessiner: TButton;
    ImagePalette26: TImage;
    Label26: TLabel;
    ImagePalette23: TImage;
    Label23: TLabel;
    Label27: TLabel;
    ImagePalette27: TImage;
    ImagePalette28: TImage;
    Label28: TLabel;
    Label29: TLabel;
    ImagePalette29: TImage;
    Label32: TLabel;
    ImagePalette32: TImage;
    Label33: TLabel;
    ImagePalette33: TImage;
    Label34: TLabel;
    ImagePalette34: TImage;
    ImagePalette52: TImage;
    Label52: TLabel;
    ButtonAffSC: TButton;
    RadioGroupSel: TRadioGroup;
    MainMenuTCO: TMainMenu;
    MenuTCO: TMenuItem;
    SauvegarderleTCO1: TMenuItem;
    N8: TMenuItem;
    DessinerleTCO1: TMenuItem;
    ConfigurationduTCO1: TMenuItem;
    Bandeau: TMenuItem;
    Affichage: TMenuItem;
    Mosaquehorizontale1: TMenuItem;
    Mosaqueverticale1: TMenuItem;
    N10: TMenuItem;
    AfficherSignauxComplexes1: TMenuItem;
    Signalvertical180: TMenuItem;
    RafrachirleTCO1: TMenuItem;
    RechargerleTCOdepuislefichier1: TMenuItem;
    ImagePalette53: TImage;
    Label53: TLabel;
    Supprimercanton1: TMenuItem;
    N9: TMenuItem;
    Affecterlocomotiveaucanton1: TMenuItem;
    Routes: TMenuItem;
    AffRoutes: TMenuItem;
    ImageDrapVert: TImage;
    ImageDrapRouge: TImage;
    Optiondesroutes1: TMenuItem;
    Trouverunlment1: TMenuItem;
    ImageBt0Bistable: TImage;
    ImageBt1Bistable: TImage;
    Mmoiredezone1: TMenuItem;
    N11: TMenuItem;
    Modeslection1: TMenuItem;
    Modedplacement1: TMenuItem;
    N12: TMenuItem;
    //TimerTCO: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette5EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette2EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette3EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette4EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette1EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette6EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette7EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette8EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette9EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ButtonSauveTCOClick(Sender: TObject);
    procedure MenuCouperClick(Sender: TObject);
    procedure ImageTCOMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageTCOMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageTCOMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuCopierClick(Sender: TObject);
    procedure MenuCollerClick(Sender: TObject);
    procedure ButtonRedessineClick(Sender: TObject);
    procedure EditAdrElementChange(Sender: TObject);
    procedure ImagePalette10EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette11EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonConfigTCOClick(Sender: TObject);
    procedure ImagePalette50EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette50MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Tourner90GClick(Sender: TObject);
    procedure Tourner90DClick(Sender: TObject);
    procedure Pos_vertClick(Sender: TObject);
    procedure TrackBarZoomChange(Sender: TObject);
    procedure AnnulercouperClick(Sender: TObject);
    procedure ImagePalette12EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette12MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette13EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette13MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette14EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette14MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette15EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette15MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditTexteChange(Sender: TObject);
    procedure ButtonSimuClick(Sender: TObject);
    procedure CheckPinvClick(Sender: TObject);
    procedure ImagePalette16MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette16EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette17EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette17MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette18EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette18MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette19EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette19MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette20MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette20EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ButtonMasquerClick(Sender: TObject);
    procedure ImagePalette21EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette22EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette21MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette22MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageTCODblClick(Sender: TObject);
    procedure ComboReprChange(Sender: TObject);
    procedure ImagePalette1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette5DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette12DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette13DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette14DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette15DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette21DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette22DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette7DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette8DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette9DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette16DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette17DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette18DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette19DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette20DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette10DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette11DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette50DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure PanelBasDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette51DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette51EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette51MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonFonteClick(Sender: TObject);
    procedure FontDialog1Show(Sender: TObject);
    procedure Signaldroitedelavoie1Click(Sender: TObject);
    procedure Signalgauchedelavoie1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure LigneDessusClick(Sender: TObject);
    procedure LigneDessousClick(Sender: TObject);
    procedure SupprimeLigneClick(Sender: TObject);
    procedure Colonnegauche1Click(Sender: TObject);
    procedure Colonnedroite1Click(Sender: TObject);
    procedure ColonneClick(Sender: TObject);
    procedure buttonRazClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ButtonCalibrageClick(Sender: TObject);
    procedure ButtonCoulFondClick(Sender: TObject);
    procedure ColorDialog1Show(Sender: TObject);
     procedure ImagePalette24DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette24EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette24MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette25DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette25EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette25MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ImagePalette1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette4DragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
    procedure EditTypeImageChange(Sender: TObject);
    procedure Toutslectionner1Click(Sender: TObject);
    procedure ButtonDessinerClick(Sender: TObject);
    procedure ImagePalette26DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette26EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette26MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette23EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette23DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette23MouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette27DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette27MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette27EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette28DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette28EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette28MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette29DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette29EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette29MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette32DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette32EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette32MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette33DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette33EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette33MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette34DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette34EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImagePalette34MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditAdrElementClick(Sender: TObject);
    procedure ImagePalette53DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
     procedure ImagePalette52EndDrag(Sender, Target: TObject; X, Y: Integer);
     procedure ImagePalette53MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonAffSCClick(Sender: TObject);
    procedure RadioGroupSelClick(Sender: TObject);
    procedure SauvegarderleTCO1Click(Sender: TObject);
    procedure DessinerleTCO1Click(Sender: TObject);
    procedure ConfigurationduTCO1Click(Sender: TObject);
    procedure Redessine1Click(Sender: TObject);
    procedure BandeauClick(Sender: TObject);
    procedure Mosaquehorizontale1Click(Sender: TObject);
    procedure Mosaqueverticale1Click(Sender: TObject);
    procedure AfficherSignauxComplexes1Click(Sender: TObject);
    procedure Signalvertical180Click(Sender: TObject);
    procedure RechargerleTCOdepuislefichier1Click(Sender: TObject);
    procedure Supprimercanton1Click(Sender: TObject);
    procedure Affecterlocomotiveaucanton1Click(Sender: TObject);
    procedure ImagePalette52MouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette52DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette53EndDrag(Sender, Target: TObject; X,Y: Integer);
    procedure ImageTCOEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure AffRoutesClick(Sender: TObject);
    procedure Optiondesroutes1Click(Sender: TObject);
    procedure Trouverunlment1Click(Sender: TObject);
    { Déclarations privées }
    function index_TCOMainMenu : integer;
    procedure Mmoiredezone1Click(Sender: TObject);
    procedure EditAdrElementExit(Sender: TObject);
    procedure Modeslection1Click(Sender: TObject);
    procedure Modedplacement1Click(Sender: TObject);
  public
    { Déclarations publiques }
  end;

const
  // sens du train ou de circulation dans les cantons
  SensGauche=1;
  SensDroit=2;
  SensHaut=3;
  SensBas=4;
  // sens dans les TCO
  SensTCO_O=5;  // gauche
  SensTCO_E=6;  // droite
  SensTCO_N=7;  // N
  SensTCO_S=8;  // S
  SensTCO_NO=9; // NO
  SensTCO_NE=10; // NE
  SensTCO_SE=11; // SE
  SensTCO_SO=12; // SO
  // fonction replace (2=NE 3=Est 4=SE 5=S )
  Nord=1;
  NordEst=2;
  Est=3;
  SudEst=4;
  Sud=5;
  SudOuest=6;
  Ouest=7;
  NordOuest=8;

  MaxCellX=150;MaxCellY=70;
  licone=26;   // largeur icone du bas 35
  hicone=licone;
  Xicones=40;  //début de la zone icones
  maxUndo=30;
  ZoomMax=(8191 div MaxCellX)-1;  // pour ne pas dépasser un canvas de 8191 pixel maxi
  ZoomMin=15;
  ClFond_ch='CoulFond';
  clVoies_ch='CoulVoies';
  clAllume_ch='CoulAllume';
  clGrille_ch='CoulGrille';
  clTexte_ch='CoulTexte';
  clQuai_ch='CoulQuai';
  ClCantonLibre_ch='CoulCantonLibre';
  ClCantonOccupe_ch='CoulCantonOccupe';
  clPiedSignal_ch='CoulPiedSig';
  JeuCouleurs_ch='JeuCouleurs';
  Matrice_ch='Matrice';
  Cellule_ch='Cellule';
  ClCanton_ch='CoulCanton';
  Ratio_ch='Ratio';
  EvtClicDet_ch='EvtClicDet';
  AvecGrille_ch='AvecGrille';
  ModeCouleurCanton_ch='ModeCouleurCanton';
  Graphisme_ch='Graphisme';
  Ecran_ch='Ecran';
  Epaisseur_voies_ch='EpVoies';
  ZoomInit_ch='ZoomInit';
  XYInit_ch='XYInit';
  Id_signal=50;
  Id_Quai=51;
  Id_action=52;
  Id_canton=53;  // codification de l'icone à la dépose
  Id_cantonH=60; // codifications de l'icone dans le TCO
  Id_cantonV=70; //           "

  // liaisons des voies pour chaque icone par N° de bit (0=NO 1=Nord 2=NE 3=Est 4=SE 5=S 6=SO 7=Ouest) 7
  // un bit à 1 indique une liaison de l'élément
  Liaisons : array[0..53] of integer=
   // 0   1   2   3   4   5  6   7  8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28 29 30 31
     (0,$88,$c8,$8c,$98,$89,$9,$84,$90,$48,$44,$11,$19,$c4,$91,$4c,$21,$24,$42,$12,$22,$cc,$99,$66,$23,$33,$26,$62,$32,$31,0,0,
     // 32  33  34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53
       $64,$13,$46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ;
type
  // structure d'une cellule du TCO
  TTCO = record
           Adresse     : integer;     // adresse du détecteur ou de l'aiguillage ou du feu OU si action sortie : adresse
           BImage      : integer;     // icone: 0=rien 1=voie 2=aiguillage gauche  ... 50=feu
           mode        : integer;     // couleur de voie 0=éteint 1=ClVoies 2=couleur dans le champ train
           train       : integer;     // index du train
           trajet      : integer;     // décrit le trajet ouvert sur la voie (cas d'un croisement ou d'une tjd/S)
           inverse     : boolean;     // aiguillage piloté inversé
           repr        : integer;     // position de la représentation texte 0 = rien 1=centré 2=Haut  3=Bas 4=réparti 5=double centré
           etat        : integer;     // état du bouton
           Texte       : string;      // texte de la cellule
           Fonte       : string;      // fonte du texte
           FontStyle   : string;      // GSIB  (Gras Souligné Italique Barré)
           coulFonte   : Tcolor;
           TailleFonte : integer;
           CouleurFond : Tcolor;      // couleur de fond
           // pour les signaux seulement ou action
           PiedSignal  : integer;     // type de pied au signal : signal à gauche=1 ou à droite=2 de la voie OU si action: type d'action
           NumCanton   : integer;     // numéro de canton, pas son index
           x,y         : integer;     // coordonnées pixels relativés du coin sup gauche du signal pour le décalage par rapport au 0,0 cellule
           Xundo,Yundo : integer;     // coordonnées x,y de la cellule pour le undo
           FeuOriente  : integer;     // orientation du signal : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit  / OU si action : numéro du TCO etc / OU Nbre éléments du canton
           liaisons    : integer;     // quadrants des liaisons
           epaisseurs  : integer;     // épaisseur des liaisons : si le bit n est à 1 : liaison fine
           SensCirc    : integer;     // sens de la circulation des trains dans canton à la lecture du tco, copié dans canton au renseignement du canton tous sens=0  SensGauche=1  SensDroit=2  SensHaut=3  SensBas=4
           pont        : integer;     // définition du pont : si le bit n est à 1 : pont (bits symétriques) OU si canton: alignement train (0=centré 1=Gauche/haut 2=droite/bas)
           buttoir     : integer;     // définition des buttoirs : si le bit n°n est à 1 : buttoir ; ou encadre cellule
           sortie      : integer;     // si action sortie : état
           suivHG,suivBD : integer;   // suivant haut ou gauche / suivant bas ou droit dans le cas d'une TJD/S
           typHG,typBD :tequipement;
           // adjacents aux TJD
           TjdNO,TjdN,TjdNE,TjdE,TjdSE,TjdS,TjdSO,TjdO : integer;  // adresses de la tjd attachée aux éléments ci dessous
           suivNO,SuivN,SuivNE,SuivE,SuivSE,SuivS,SuivSO,SuivO : integer;
           typeNO,typeN,typeNE,typeE,typeSE,typeS,typeSO,typeO : tequipement;
         end;

  // élément graphique "canton"
  Tcanton = record
             numero        : integer;  // numéro du canton
             SensLoco      : integer;  // sens de la loco stockée sur le canton 1=Sensgauche 2=Sensdroit 3=Senshaut 4=Sensbas
             Ntco          : integer;  // numéro du tco
             Nelements     : integer;  // nombre de cellules du canton
             nom           : string;   // nom du canton
             x,y           : integer;  // début du canton dans le TCO
             // éléments contigus
             el1,el2       : integer;  // éléments contigus au canton el1=gauche/haut el2=droit/bas
             typ1,typ2     : tEquipement;  // type des éléments contigus au canton: un des deux doit être un détecteur
             det1,det2     : integer;  // détecteurs contigus, changement en fonction des aiguillages
             SensEl1,SensEl2 : integer;// indique le sens de l'élément par rapport au canton
             SensCirc      : integer;  // sens de la circulation des trains dans canton  tous sens=0  Gauche=1  Droit=2  Haut=3  Bas=4
             //                           dupliqué dans TCO[].sensCirc
             signal        : integer;  // adresse du signal associé (le canton est avant le signal)
             NomTrain      : string;   // nom du train sur le canton
             indexTrain    : integer;  // index du train sur le canton
             adresseTrain  : integer;  // adresse du train sur le canton
             Gd            : tRect;    // rectangle de sélection (contour du canton)
             rO,rE,rS,rN   : tRect;    // rectangles des 4 poignées
             Xicone,yIcone : integer;  // début de l'image du train (coord absolues)
             Licone,HIcone : integer;  // largeur, hauteur icone du train
             bouton        : integer;  // état du bouton de commande du canton: 0=jaune 1=vert  2=bleu  3=drapeau vert 4=drapeau rouge
             select        : boolean;  // si le canton a été sélectionné par clic souris
             horizontal    : boolean;  // si le canton est horizontal ou verticel
             maxi,mini     : integer;  // valeurs mini et maxi des coordonnées à ne pas dépasser lors d'un tirage des poignées
             NumcantonOrg,NumCantonDest
                           : integer;  // canton origine et destination d'une route , concerne le canton départ ou arrivée
             AdrTrainRoute : integer;  // adresse du train qui a une route, concerne le canton départ ou arrivée
           end;

  // rectangle graphique de sélection
  Trect_Select= record
                  NumTCO : integer;   // affectation du rectangle à ce tco
                  Gd,                 // grand rectangle
                  rN,rE,rS,rO,rNE,rNO,rSE,rSO : Trect;   // 8 poignées
               end;

var
  couleurAdresse,cltexte,CoulFonte,clCoulGrilleSV,clvoiesSV,
  clFoncSV,clGrilleSV,clCoulCantonLibreSV,clCoulCantonOccupeSV : Tcolor;

  TamponAffecte,TCO_modifie,prise_N,affPosFil,clicsouris,modeGlisse,
  clicTCO,piloteAig,BandeauMasque,eval_format,sauve_tco,prise_droit,prise_haut,deja_calcule,
  prise_bas,prise_gauche,prise_NE,prise_NO,prise_SE,prise_SO,ligneAffiche,colonneAffiche,
  TCOActive,TCOCree,ancienok,dbleClicTCO,auto_tcurs,EvtClicDet,SelecBouge,NB : boolean;

  HtImageTCO,LargImageTCO,XminiSel,YminiSel,Temposouris,ligne_supprime,JeuCouleurs,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,RatioC,ModeCouleurCanton,xSourisClic,ySourisClic,
  AncienXClicCell,AncienYClicCell,TCODrag,epaisseur_voies,ASourisx,ASourisy,TpsBougeSouris,
  Epaisseur,oldX,oldY,offsetSourisY,offsetSourisX,AvecVerifIconesTCO,indexTrace,IndexTCOCourant,
  ancienTraceX,ancienTraceY,rangUndo,NbreTCO,IndexTCOCreate,deltaXrect,deltaYrect,
  CellX,CellY,AncienXclic,AncienYclic,xCadre1,yCadre1,xCadre2,yCadre2,colonne_supprime,
  couleurAction,couleurCanton,Ncantons,Xcanton,Ycanton,IdCantonSelect,IdCantonClic,AxSC,AySC,Drag,
  Ldrag,Hdrag,IdCantonDragOrg,idcantonRoute,cantonOrg,cantonDest,AncienIdCantonSelect,
  indexTrainFR : integer;

  ToucheTCO : char;

  Tel1,tel2 : Tequipement;

  titre_Fonte,s90,s91,s93,s94,s100,s101 : string;

  // élements dupliqués dans le TCO :
  canton : array[1..MaxCantons] of Tcanton;

  // structure de tous les tco
  TCO : array[1..10] of
           array of array of TTco;

  ClCoulFondSV : array[1..10] of array[1..MaxCellX,1..MaxCellY] of Tcolor;

  // tampon undo
  Undo : array[1..MaxUndo] of record
           nombre : integer;
           element : array[1..100] of TTCO ;
         end;

  // pour copier coller
  TamponTCO : array of array of TTco ;
  TamponTCO_Org : record
                   numTCO,
                   x1,y1,x2,y2,     // coordoonnées rectangulaires de la sélection
                   NbreCellX,NbreCellY,
                   Xorg,Yorg : integer; // point d'origine de la sélection
                 end;

  Rect_select : Trect_Select;  // rectangle de sélection graphique
  Sauv_rect_select : Trect;

  // tracé du train dans les TCO
  Trace_Train : array[0..10] of record
    train : array[0..Max_Trains] of record
      nombre : integer;
      route : array[1..500] of record x,y : integer;
      end;
    end;
    end;

  // tracé en mode dessin
  traceXY : Array[1..50] of record x,y : integer; // en coordonnées grille
            end;

  boutonTCO : array[0..100] of record
        etat : integer;  // état des boutons du TCO ; l'index est le numéro de bouton
        idtco,x,y : integer;
        existe : boolean;
        end;

  rAncien : TRect;
  OldBmp : TBitMap;
  PScrollBoxTCO : TScrollBox;

  // liste des variables par tco de 1 à 10
  largeurCelld2,HauteurCelld2,NbCellulesTCO,NbreCellX,NbreCellY,LargeurCell,HauteurCell,
  Xentoure,Yentoure,XclicCell,YclicCell,EcranTCO,clGrille,clFond,ClAllume,ClVoies,
  ClCanton,clPiedSignal,ClQuai,ClBarriere,ZoomInit,Xinit,Yinit,CoulCantonLibre,
  CoulCantonOccupe : array[1..10] of integer;
  formTCO : array[1..10] of TformTCO;     // pointeur vers forms
  PcanvasTCO : array[1..10] of Tcanvas;
  PBitMapTCO : array[1..10] of TbitMap;
  PImageTCO,PImageTemp : array[1..10] of Timage;
  frXGlob,frYGlob : array[1..10] of single;
  NomFichierTCO : array[1..10] of string;
  AvecGrille,SelectionAffichee,forminit,modeTrace,entoure : array[1..10] of boolean;

  {$IF CompilerVersion >= 28.0}
  BallonHint : TballoonHint;
  {$IFEND}


procedure calcul_reduction(Var frx,fry : single;DimDestX,DimDestY : integer);
procedure calcul_cellules(indextco : integer);
procedure sauve_fichiers_tco;
function zone_tco(indexTCO,det1,det2,train,adrTrain,mode: integer;posAig,affecte_loco : boolean) : boolean; overload;
function zone_tco(indexTCO,adr : integer;typEl : tequipement;Sens,mode: integer;posAig,affecte_loco : boolean) : boolean; overload;
procedure _entoure_cell_clic(indexTCO: integer);
procedure Affiche_TCO(indexTCO : integer) ;
procedure affiche_cellule(indexTCO,x,y : integer);
procedure efface_entoure(indexTCO : integer);
procedure affiche_texte(indextco,x,y : integer);
procedure change_fonte(indexTCO : integer);
procedure Tourne90G(indexTCO : integer);
procedure Tourne90D(indexTCO : integer);
procedure Maj_TCO(indexTCO,Adresse : integer);
procedure Vertical(indexTCO : integer);
procedure Vertical180(indexTCO : integer);
procedure signalG(indexTCO : integer);
procedure signalD(indexTCO : integer);
procedure lire_fichier_tco(indexTCO : integer);
procedure change_couleur_fond(indexTCO : integer);
function verif_cellule(IndexTCO,x,y,Bim : integer) : boolean;
procedure dessine_icones(indexTCO : integer);
procedure echange(var a,b : integer);
procedure Efface_Cellule(indextco : integer;Canvas : Tcanvas;x,y : integer;Mode : TPenMode);
procedure dessine_icone(indexTCO : integer;PCanvasTCO : tcanvas;Bimage,X,Y,mode : integer);
function IsAigTJDCroiTCO(i : integer) : boolean;
function index_TCO(t : Tobject) : integer;
procedure Init_TCO(indexTCO : integer);
procedure init_tampon_copiercoller;
procedure efface_trajet(det,train : integer);
Procedure Texte_aig_fond(adresse : integer);
procedure Maj_Aig_TCO(indexTCO : integer);
procedure encadre_ligne;
procedure encadre_colonne;
function IsCanton(i : integer) : boolean;
function index_canton(indexTCO,x,y : integer) : integer;
function index_canton_det(detecteur : integer) : integer;
function IsCantonH(i : integer) : boolean; overload;
function IsCantonH(indexTCO,x,y : integer) : boolean;  overload;
function IsCantonV(i : integer) : boolean; overload;
function IsCantonV(indexTCO,x,y : integer) : boolean;  overload;
procedure dessin_canton(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer); overload;
procedure dessin_canton(IdCanton : integer;mode : integer) ; overload;
procedure supprime_canton(c : integer);
procedure renseigne_tous_cantons;
procedure renseigne_canton(i : integer); overload;
function index_canton_numero(n : integer) : integer;
procedure renseigne_TJDs_TCO;
procedure Affiche_temps_arret(IdTrain,tps : integer);
procedure titre_fenetre(indexTCO : integer);
function IsVoieDroite(i : integer) : boolean;
function trouve_canton(el1 : integer;tel1 : tequipement;el2 : integer;tel2 : tequipement) : integer;
procedure origine_canton(var x,y : integer);

implementation

uses UnitConfigTCO, Unit_Pilote_aig, UnitConfigCellTCO, UnitClock, selection_train ,
  UnitRoute, UnitRouteTrains, UnitInfo, UnitIntro, UnitMemZone;

{$R *.dfm}

procedure supprime_canton(c : integer);
var i : integer;
begin
  if c<>0 then
  begin
    //Affiche('Suppression canton '+intToSTR(c),clorange);
    for i:=c to ncantons-1 do       // supprime le canton c de la liste
      canton[i]:=canton[i+1];
    dec(ncantons);
  end;
end;

// ramener les coordonnées à la première cellule du canton
procedure coord_canton(indexTCO : integer;var x,y : integer);
var el : integer;
begin
  El:=TCO[indexTCO,x,y].BImage;
  if isCantonH(El) then
  begin
    x:=x-(el-Id_cantonH);
  end;
  if isCantonV(El) then
  begin
    y:=y-(el-Id_cantonV);
  end;
end;

// renvoie l'index du canton en x,y
function index_canton(IndexTCO,x,y : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  coord_canton(indexTCO,x,y);  // ramener les coordonnées à la première cellule
  i:=1;
  repeat
    trouve:=(canton[i].x=x) and (canton[i].y=y);
    inc(i);
  until (i>nCantons) or trouve;
  if trouve then result:=i-1 else result:=0;
end;

// renvoie l'index du canton associé au détecteur det
function index_canton_det(detecteur : integer) : integer;
var i,det1,det2 : integer;
    trouve : boolean;
begin
  i:=1;
  result:=0;
  repeat
    det1:=canton[i].el1;
    det2:=canton[i].el2;
    trouve:=((det1=detecteur) and (canton[i].typ1=det)) or ((det2=detecteur) and (canton[i].typ2=det));
    inc(i);
  until (i>Ncantons) or trouve;
  if trouve then result:=i-1;
end;

// renvoie l'index du canton en fonction de son numéro
function index_canton_numero(n : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  if n=0 then begin result:=0;exit;end;
  i:=1;
  result:=0;
  repeat
    trouve:=canton[i].numero=n;
    inc(i);
  until (i>=Ncantons+1) or trouve;
  if trouve then result:=i-1;
end;

// renvoie l'index du tco d'après le nom de la forme (TCO1 TCO2)
// ne fonctionne que si t est un composant dont on peut remonter jusqu'à la form parent
// attention : si T est un popup menu, ca ne marche pas!!!
function index_TCO(t : Tobject) : integer;
var s : string;
    trouve : boolean;
    f : tcustomform;
    i,erreur : integer;
begin
  f:=getparentForm(t as Tcontrol);
  s:=(f as Tcomponent).Name;

  i:=0;
  repeat
    inc(i);
    trouve:=s[i] in ['0'..'9'];
  until trouve or (i>=length(s));
  if trouve then
  begin
    delete(s,1,i-1);
    val(s,result,erreur);
  end
  else result:=0;
end;

// renvoie l'index de canton encadré par les 2 éléments el1 et el2
function trouve_canton(el1 : integer;tel1 : tequipement;el2 : integer;tel2 : tequipement) : integer;
var i,eLc1,eLc2 : integer;
    teLc1,teLc2 : tequipement;
    trouve : boolean;
begin
  i:=1;
  result:=0;
  repeat
    eLc1:=canton[i].el1; teLc1:=canton[i].typ1;
    eLc2:=canton[i].el2; teLc2:=canton[i].typ2;

    trouve:=((elc1=el1) and (teLc1=tel1) and (elc2=el2) and (teLc2=tel2)) or
            ((elc2=el1) and (teLc2=tel1) and (elc1=el2) and (teLc1=tel2)) ;
    inc(i);
  until (trouve) or (i>nCantons);
  if trouve then result:=i-1;
end;


// le tampon est aussi grand que le x/y du plus grand TCO
procedure init_tampon_copiercoller;
begin
  SetLength(TamponTCO,MaxCellX+2,MaxCellY+2);
end;

// affiche le rectangle de sélection graphique
Procedure Affiche_Rectangle(IndexTCO : integer;r : Trect_Select);
begin
  if indexTCO<1 then exit;
  with PCanvasTCO[IndexTCO] do
  begin
    with pen do
    begin
      Mode:=PmXor;
      color:=clWhite;
      width:=1;
    end;
    Brush.Color:=clblue;

    Rectangle(r.Gd);   // Grand rectangle
    Rectangle(r.rN);   // rectangle poignée haut
    Rectangle(r.rE);
    Rectangle(r.rO);
    Rectangle(r.rS);
    Rectangle(r.rNE);
    Rectangle(r.rNO);
    Rectangle(r.rSO);
    Rectangle(r.rSE);
  end;
end;

// calcule les poignées du rectangle de sélection graphique
procedure Init_rectangle(IndexTCO : integer;var r : Trect_Select);
var xp,yp : integer;
begin
  with r do
  begin
    // poignée nord (haut)
    xp:=(r.Gd.right+r.Gd.Left) div 2;
    yp:=r.Gd.Top;
    rn.Left:=xp-5;
    rn.top:=yp-5;
    rn.Right:=xp+5;
    rn.Bottom:=yp+5;

     // poignée droite
    xp:=r.Gd.Right;
    yp:=(r.Gd.Bottom+r.Gd.top) div 2;
    rE.Left:=xp-5;
    re.top:=yp-5;
    re.Right:=xp+5;
    re.Bottom:=yp+5;

     // poignée bas
    xp:=(r.gd.right+r.gd.Left) div 2;
    yp:=r.gd.Bottom;
    rS.Left:=xp-5;
    rs.top:=yp-5;
    rs.Right:=xp+5;
    rs.Bottom:=yp+5;

    // poignée gauche
    xp:=r.gd.Left;
    yp:=(r.gd.Bottom+r.gd.top) div 2;
    rO.Left:=xp-5;
    rO.top:=yp-5;
    ro.Right:=xp+5;
    ro.Bottom:=yp+5;

    // nord est
    xp:=r.gd.right;
    yp:=r.gd.top;
    rNE.Left:=xp-5;
    rNE.top:=yp-5;
    rNE.Right:=xp+5;
    rNE.Bottom:=yp+5;

    // sud est
    xp:=r.gd.right;
    yp:=r.gd.bottom;
    rSE.Left:=xp-5;
    rSE.top:=yp-5;
    rSE.Right:=xp+5;
    rSE.Bottom:=yp+5;

    // sud ouest
    xp:=r.gd.left;
    yp:=r.gd.bottom;
    rSO.Left:=xp-5;
    rSO.top:=yp-5;
    rSO.Right:=xp+5;
    rSO.Bottom:=yp+5;

    // nord ouest
    xp:=r.gd.left;
    yp:=r.gd.top;
    rNO.Left:=xp-5;
    rNO.top:=yp-5;
    rNO.Right:=xp+5;
    rNO.Bottom:=yp+5;
  end;
end;

// Accroche les poignées et bouge le rectangle de sélection graphique
// ici, la souris est enfoncée et est entrain de bouger en x,y
procedure Accroche_Rectangle_selection(indexTCO,x,y : integer);
var dx,dy,maxX,maxY : integer;
    r : Trect;
    rien : boolean;
begin
  rien:=not(prise_droit) and not(prise_bas) and not(prise_gauche) and not(prise_haut) and not(prise_NE) and not(prise_NO) and not(prise_SE) and not(prise_SO);

  maxX:=LargeurCell[indexTCO]*NbreCellX[indexTCO];
  maxY:=HauteurCell[indexTCO]*NbreCellY[indexTCO];

  // poignée haut
  r:=Rect_Select.rN;
  if ( ((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_haut) and (y>0) then
  begin
    screen.cursor:=crSizeNS;
    //if (not(prise_droit) and not(prise_bas) and not(prise_gauche) and not(prise_NE) and not(prise_NO) and not(prise_SE) and not(prise_SO)) and clicsouris  then
    if (rien and (clicsouris)) or prise_haut then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      if y<rect_select.Gd.bottom then
      begin
        rect_Select.gd.top:=y;
      end
      else
      begin
        // inversion
        rect_Select.gd.bottom:=y;
      end;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
      prise_haut:=true;  // mémorise si la souris va vite
    end;
    exit;
  end;

  // poignée droite
  r:=Rect_Select.re;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_droit) then //and (x<MaxX) then
  begin
    screen.cursor:=crSizeWE;
    //if (not(prise_haut) and not(prise_bas) and not(prise_gauche) and not(prise_NE) and not(prise_NO) and not(prise_SE) and not(prise_SO)) and clicsouris then
    if (rien and (clicsouris)) or prise_droit then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_droit:=true;
      if x>rect_select.Gd.Left then
      begin
        rect_Select.gd.right:=x;
      end
      else
      begin
        // inversion
        rect_Select.gd.left:=x;
      end;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // poignée bas
  r:=Rect_Select.rS;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_bas) then //and (y<MaxY) then
  begin
    screen.cursor:=crSizeNS;
    if (rien and (clicsouris)) or prise_bas then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_bas:=true;
      if y>rect_select.Gd.top then
      begin
        rect_Select.gd.bottom:=y;
      end
      else
      begin
        // inversion
        rect_Select.gd.top:=y;
      end;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // poignée gauche
  r:=Rect_Select.rO;  // rectangle ouest=poignée gauche
  // si x est dans le rectangle
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_gauche) then //and (x>0) then
  begin
    screen.cursor:=crSizeWE;
    if (rien and (clicsouris)) or prise_gauche then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_gauche:=true;
      if (x<rect_select.Gd.Right) then
      begin
        rect_Select.gd.left:=x;
      end
      else
      begin
        // inversion
        rect_Select.gd.right:=x;
      end;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // poignée NE
  r:=Rect_Select.rNE;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_NE) then //and (x<MaxX) and (y>0) then
  begin
    screen.cursor:=crSizeNESW;
    if (rien and (clicsouris)) or prise_NE then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_NE:=true;
      rect_Select.gd.right:=x;
      rect_Select.gd.top:=y;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // poignée NO
  r:=Rect_Select.rNO;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_NO) then //and (x>0) and (y>0) then
  begin
    screen.cursor:=crSizeNWSE;
    if (rien and (clicsouris)) or prise_NO then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_NO:=true;
      rect_Select.gd.left:=x;
      rect_Select.gd.top:=y;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // poignée SE
  r:=Rect_Select.rSE;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_SE) then //and (x<MaxX) and (y<MaxY) then
  begin
    screen.cursor:=crSizeNWSE;
    if (rien and (clicsouris)) or prise_SE then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_SE:=true;
      rect_Select.gd.right:=x;
      rect_Select.gd.bottom:=y;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // poignée SO
  r:=Rect_Select.rSO;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_SO) then //and (x>0) and (y<MaxY) then
  begin
    screen.cursor:=crSizeNESW;
    if (rien and (clicsouris)) or prise_SO then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_SO:=true;
      rect_Select.gd.left:=x;
      rect_Select.gd.bottom:=y;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // selec rectangle : bouger en toutes directions
  r:=Rect_select.Gd;
  if ((y>r.top) and (y<r.bottom) and (x>r.Left) and (x<r.Right) and (x>0) and (x<MaxX) and (y>0) and (y<maxY)) or prise_N then
  begin
    screen.cursor:=crSizeAll;
    if not(prise_N) and (clicsouris) then
    begin
      // sauvegarder le rectangle avant qu'on le bouge
      Sauv_rect_select:=Rect_Select.Gd;
      deltaXrect:=x-rect_Select.Gd.Left;
      DeltaYrect:=y-rect_Select.Gd.top;
    end;
    if (rien and (clicsouris)) or prise_N then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_N:=true;
      with rect_Select.Gd do
      begin
        dy:=y-Sauv_rect_select.Top;
        dx:=x-Sauv_rect_select.left;
        top:=Sauv_rect_select.top+dy-DeltaYrect;
        bottom:=Sauv_rect_select.Bottom+dy-DeltaYrect;
        left:=x-deltaXrect;
        right:=Sauv_rect_select.right+dx-DeltaXrect;
      end;
      init_rectangle(indexTCO,rect_select);
      Affiche_Rectangle(indexTCO,rect_Select);
    end;
    exit;
  end;

  // si hors sélection, on remet le curseur normal
  screen.cursor:=crDefault;
end;


// calcule les poignées du rectangle de sélection canton
procedure Init_rectangle_canton(IndexTCO,indexCanton : integer);
var xp,yp : integer;
begin
  with canton[indexcanton] do
  begin
    // poignée nord (haut)
    xp:=(Gd.right+Gd.Left) div 2;
    yp:=Gd.Top;
    rn.Left:=xp-5;
    rn.top:=yp-5;
    rn.Right:=xp+5;
    rn.Bottom:=yp+5;

     // poignée droite
    xp:=Gd.Right;
    yp:=(Gd.Bottom+Gd.top) div 2;
    rE.Left:=xp-5;
    re.top:=yp-5;
    re.Right:=xp+5;
    re.Bottom:=yp+5;

     // poignée bas
    xp:=(gd.right+gd.Left) div 2;
    yp:=gd.Bottom;
    rS.Left:=xp-5;
    rs.top:=yp-5;
    rs.Right:=xp+5;
    rs.Bottom:=yp+5;

    // poignée gauche
    xp:=gd.Left;
    yp:=(gd.Bottom+gd.top) div 2;
    rO.Left:=xp-5;
    rO.top:=yp-5;
    ro.Right:=xp+5;
    ro.Bottom:=yp+5;

  end;
end;

// affiche le rectangle de sélection canton
Procedure Affiche_Rectangle_canton(IndexTCO,indexCanton : integer);
var h : boolean;
begin
  if indexTCO<1 then exit;
  with PCanvasTCO[IndexTCO],canton[indexCanton] do
  begin
    with pen do
    begin
      Mode:=PmXor;
      color:=clWhite;
      width:=1;
    end;
    Brush.Color:=CoulCantonLibre[indexTCO];

    Rectangle(canton[indexCanton].Gd);   // Grand rectangle
    h:=canton[indexcanton].horizontal;
    if h then
    begin
      Rectangle(rE);
      Rectangle(rO);
    end
    else
    begin
      Rectangle(rN);   // rectangle poignée haut
      Rectangle(rS);
    end;
  end;
end;

// si accroché, résultat=true
// x y coordonnées graphiques
function Accroche_canton(IndexTCO,IndexCanton,x,y : integer) : boolean;
var n,Bim,larg,haut,xt,yt,adr,Xorg,Yorg,yr,xr,xm,ym : integer;
    r : Trect;
    ok,rien,versE,versO,versN,versS : boolean;
begin
  //Affiche('AC',clWhite);
  if canton[indexCanton].Ntco<>IndexTCO then
  begin
    //Affiche('Canton différent',clred);
    result:=false;
    exit;
  end;  // si le canton n'est pas sur le bon TCO
  rien:=not(prise_droit) and not(prise_bas) and not(prise_gauche) and not(prise_haut) ;

  larg:=largeurCell[IndexTCO];
  haut:=HauteurCell[IndexTCO];
  xt:=(x div larg)+1;   // coords cellule de la souris
  yt:=(y div Haut)+1;
  Xorg:=canton[indexCanton].x;  // origine du canton
  Yorg:=canton[indexCanton].y;
  Bim:=tco[indexTCO,xt,yt].Bimage;
  Adr:=tco[indexTCO,xt,yt].Adresse;
//  Affiche(intToSTR(adr)+' '+intToSTR(Bim),clred);

  // calcule les limites en cas de détecteur
  n:=canton[indexCanton].Nelements;
  if ( (adr<>0)  ) and not(deja_calcule) then
  begin
    //Affiche('recalcul',clYellow);
    deja_calcule:=true;
    if canton[indexCanton].horizontal then
    begin
      xr:=canton[indexCanton].x;
      xm:=xr+n;
      canton[indexCanton].maxi:=(xt-1)*larg;
      canton[indexCanton].mini:=(xt)*larg;
    end
    else
    begin
      yr:=canton[indexCanton].y;
      ym:=yr+n;
      canton[indexCanton].maxi:=(ym-1)*haut;
      canton[indexCanton].mini:=(yr-1)*haut;
    end;
  end;

  // Affiche('x='+IntToSTR(x)+' y='+intToSTR(y)+' mini='+intToSTR(canton[indexCanton].mini)+' maxi='+intToSTR(canton[indexCanton].maxi),clred);
  versE:=x>AxSC;
  versO:=x<=AxSC;
  versS:=y>AySC;
  versN:=y<AySC;

  //if versE then Affiche('+',clYellow);
  //if versO then begin  Affiche('-',clYellow); end;

  AxSC:=x;AySC:=y;
  ok:=(Adr=0) and ( (Bim=1) or (Bim=20) or ((Bim>=Id_cantonH) and (bim<=Id_cantonH+9)) or ((Bim>=Id_cantonV) and (bim<=Id_cantonV+9)));
  if not(ok) then   // sortir car non ok
  begin
    //result:=true;
    result:=false;
    exit;
  end;

  // poignée gauche
  r:=canton[indexCanton].rO;
  // si x est dans le rectangle
  if (((x>=r.left-5) and (x<=r.Right+5) and (y>=r.top-5) and (y<=r.bottom+5)) or prise_gauche) then //and (x>0) then
  begin
    ok:=( (Bim=1) or (Bim=0) or ((Bim>=Id_cantonH) and (bim<=Id_cantonH+9)) or ((Bim>=Id_cantonV) and (bim<=Id_cantonV+9)));
    ok:=ok and (x>canton[indexCanton].mini);   // empeche d'aller à gauche
    if not(ok) then begin result:=true;exit;end;

    n:=1+(abs(canton[indexCanton].gd.right-x) div larg);
    if (n>10) or (n<4) then begin result:=false;exit;end; // nombre de cellules tirées : maxi 9
    screen.cursor:=crSizeWE;
    if (rien and (clicsouris)) or prise_gauche then
    begin
      // efface l'ancien
      Affiche_Rectangle_canton(IndexTCO,IndexCanton);
      prise_gauche:=true;
      if (x<canton[indexCanton].Gd.Right) then
      begin
        canton[indexCanton].gd.left:=x;
      end
      else
      begin
        // inversion
        canton[indexCanton].gd.right:=x;
      end;
      Init_rectangle_canton(indexTCO,IndexCanton);
      Affiche_Rectangle_canton(indexTCO,IndexCanton);
    end;
    result:=true;
    exit;
  end;

  // poignée droite
  r:=canton[indexCanton].rE;

  if (((x>=r.left-5) and (x<=r.Right+5) and (y>=r.top-5) and (y<=r.bottom+5)) or prise_droit) then //and (x<MaxX) then
  begin

    ok:=( (Bim=1) or (Bim=0) or ((Bim>=Id_cantonH) and (bim<=Id_cantonH+9)) or ((Bim>=Id_cantonV) and (bim<=Id_cantonV+9)));
    ok:=ok and (x<canton[indexCanton].maxi);   // empeche d'aller à droite
    if not(ok) then
    begin
      result:=true;
      exit;
    end;

    n:=1+(abs(canton[indexCanton].gd.Left-x) div larg);
    //Affiche(intToSTR(canton[indexCanton].gd.Left)+' '+intToSTR(x)+' n='+intToSTR(n),clYellow);
    if (n>10) or (n<4) then begin result:=false;exit;end; // nombre de cellules tirées : maxi 9
    screen.cursor:=crSizeWE;
    if (rien and (clicsouris)) or prise_droit then
    begin
      //Affiche('traite',clOrange);
      // efface l'ancien
      Affiche_Rectangle_canton(IndexTCO,IndexCanton);
      prise_droit:=true;
      if x>canton[indexCanton].Gd.Left then  // si la souris passe à gauche de la poignée gauche : inversion
      begin
        canton[indexCanton].gd.right:=x;
      end
      else
      begin
        // inversion
        canton[indexCanton].gd.left:=x;
      end;
      Init_rectangle_canton(indexTCO,IndexCanton);
      Affiche_Rectangle_canton(indexTCO,IndexCanton);
      prise_droit:=true;
    end;
    result:=true;
    exit;
  end;

  // poignée haut
  r:=canton[indexCanton].rN;
  if ( ((x>=r.left-5) and (x<=r.Right+5) and (y>=r.top-5) and (y<=r.bottom+5)) or prise_haut) and (y>0) then
  begin
    ok:=(Bim=0) or (Bim=20) or ((Bim>=Id_cantonH) and (bim<=Id_cantonH+9)) or ((Bim>=Id_cantonV) and (bim<=Id_cantonV+9));
    ok:=ok and (y>canton[indexCanton].mini);   // empeche d'aller en haut
    if not(ok) then begin result:=true;exit;end;

    n:=1+(abs(canton[indexCanton].gd.bottom-y) div larg);  // nombre de cellules tirées
    if (n>10) or (n<4) then begin result:=false;exit;end;; // nombre de cellules tirées : maxi 9
    screen.cursor:=crSizeNS;
    if (rien and (clicsouris)) or prise_haut then
    begin
      // efface l'ancien
      Affiche_Rectangle_canton(IndexTCO,IndexCanton);
      if y<canton[indexCanton].Gd.bottom then
      begin
        canton[indexCanton].gd.top:=y;
      end
      else
      begin
        // inversion
        canton[indexCanton].gd.bottom:=y;
      end;
      Init_rectangle_canton(indexTCO,IndexCanton);
      Affiche_Rectangle_canton(indexTCO,IndexCanton);
      prise_haut:=true;  // mémorise si la souris va vite ????????????
    end;
    result:=true;
    exit;
  end;


  // bas
  r:=canton[indexCanton].rS;
  if (((x>=r.left-5) and (x<=r.Right+5) and (y>=r.top-5) and (y<=r.bottom+5)) or prise_bas) then //and (y<MaxY) then
  begin
    ok:=(Bim=0) or (Bim=20) or ((Bim>=Id_cantonH) and (bim<=Id_cantonH+9)) or ((Bim>=Id_cantonV) and (bim<=Id_cantonV+9));
    ok:=ok and (y<canton[indexCanton].maxi);   // empeche d'aller en bas
    if not(ok) then begin result:=true;exit;end;

    n:=1+(abs(canton[indexCanton].gd.top-y) div larg);
    if (n>10) or (n<4) then begin result:=false;exit;end;; // nombre de cellules tirées : maxi 9
    screen.cursor:=crSizeNS;
    if (rien and (clicsouris)) or prise_bas then
    begin
      // efface l'ancien
      Affiche_Rectangle_canton(IndexTCO,IndexCanton);
      prise_bas:=true;
      if y>canton[indexCanton].Gd.top then
      begin
        canton[indexCanton].gd.bottom:=y;
      end
      else
      begin
        // inversion
        canton[indexCanton].gd.top:=y;
      end;
      Init_rectangle_canton(indexTCO,IndexCanton);
      Affiche_Rectangle_canton(indexTCO,IndexCanton);
    end;
    result:=true;
    exit;
  end;

   // si hors sélection, on remet le curseur normal
  screen.cursor:=crDefault;
  result:=false;
end;

// trouve l'élément adresse de type el dans le TCO et renvoie x et y
// si on le trouve pas, renvoie x=0,y=0
procedure trouve_El(indexTCO,adresse: integer;el : tequipement;var x,y : integer);
var xc,yc,b : integer;
    tq : tequipement;
    trouve : boolean;
begin
  yc:=1;
  repeat
    xc:=0;
    repeat
      inc(xc);
      b:=tco[indextco,xc,yc].Bimage;
      if IsAigTJDCroiTCO(b) then tq:=aig else tq:=det;
      if b=id_signal then tq:=sig;
      if tco[indextco,xc,yc].buttoir<>0 then tq:=buttoir;

      trouve:=(tco[indextco,xc,yc].Adresse=adresse) and (tq=el) ;

    until (xc=NbreCellX[indexTCO]) or trouve;
    inc(yc);
  until (yc>NbreCellY[indexTCO]) or trouve;
  dec(yc);
  if trouve then
  begin
    x:=xc;
    y:=yc;
  end
  else
  begin
    x:=0;
    y:=0;
  end;
end;

// remplit les informations du canton avec les éléments adjacents, et des détecteurs adjacents
// et vérifie si le canton ne contient pas de case incorrecte
// i : indexCanton
// remplit les champs horizontal, el1,el2,typ1,typ2,sens1,sens2 de canton[]
// et les champs canton1 et canton2 du tableau detecteurs[]
// remplit les case du TCO avec les Images du canton
procedure renseigne_canton(i : integer;Horz :boolean) ; overload;
var t,x,y,n,j,indexTCO : integer;
begin
  if i<1 then exit;
  indexTCO:=canton[i].Ntco;
  if indexTCO>NbreTCO then
  begin
    Affiche('Erreur 32',clred);
    FormTCO[IndexTCO].Caption:='Erreur 32';
    exit;
  end;
  x:=canton[i].x;
  y:=canton[i].y;
  t:=canton[i].Ntco;

  canton[i].horizontal:=tco[indexTCO,x,y].BImage=Id_cantonH;
  canton[i].SensCirc:=tco[IndexTCO,x,y].SensCirc;

  if horz then
  begin
    zone_tco(t,i,SensTCO_O,0,0,11,false,false); // demande éléments contigus à gauche (5) du canton, résultats dans var globales xCanton et tel1
    if xCanton=0 then tel1:=buttoir;
    canton[i].el1:=xCanton;
    canton[i].typ1:=tel1;
    canton[i].SensEl1:=SensGauche;
    if tel1=det then detecteur[xCanton].canton1:=canton[i].numero;

    zone_tco(t,i,SensTCO_E,0,0,11,false,false); // demande éléments contigus à droite (6) du canton, résultats dans var globales xCanton et tel1
    if xCanton=0 then tel1:=buttoir;
    canton[i].el2:=xCanton;
    canton[i].typ2:=tel1;
    canton[i].SensEl2:=SensDroit;
    if tel1=det then detecteur[xCanton].canton2:=canton[i].numero;
  end
  else
  begin
    // canton vertical
    zone_tco(t,i,SensTCO_N,0,0,11,false,false); // demande éléments contigus en haut (7) du canton, résultats dans var globales xCanton et tel1
    if xCanton=0 then tel1:=buttoir;
    canton[i].el1:=xCanton;
    canton[i].typ1:=tel1;
    canton[i].SensEl1:=SensHaut;
    if tel1=det then detecteur[xCanton].canton1:=canton[i].numero;

    zone_tco(t,i,SensTCO_S,0,0,11,false,false); // demande éléments contigus en bas (8) du canton, résultats dans var globales xCanton et tel1
    if xCanton=0 then tel1:=buttoir;
    canton[i].el2:=xCanton;
    canton[i].typ2:=tel1;
    canton[i].SensEl2:=SensBas;
    if tel1=det then detecteur[xCanton].canton2:=canton[i].numero;
  end;

  n:=canton[i].Nelements;
{  if horz then for j:=0 to n-1 do tco[t,x+j,y].BImage:=Id_cantonH+j
  else for j:=0 to n-1 do tco[t,x,y+j].BImage:=Id_cantonV+j;
  }
  if (canton[i].el1=canton[i].el2) and (canton[i].typ1=det) and (canton[i].typ2=det) then
  begin
    Affiche('Erreur 210 : Le canton '+intToSTR(canton[i].numero)+' dans le tco '+intToSTR(t)+' dispose de deux détecteurs contigus d''adresses identiques: '+intToSTR(canton[i].el1),clred);
  end;

  // vérifie si le canton a une case incorrecte
  if horz then
  begin
    t:=Id_cantonH;
    for j:=x to x+n-1 do
    begin
      if not iscantonH(tco[indexTCO,j,y].BImage) then
      begin
        Affiche('Correction canton '+intToSTR(canton[i].numero)+' en x='+intToSTR(j),clCyan);
        tco[indexTCO,j,y].BImage:=t;
        TCO_modifie:=true;
      end;
      inc(t);
    end;
  end
  else
  begin
    t:=Id_cantonV;
    for j:=y to y+n-1 do
    begin
      if not iscantonV(tco[indexTCO,x,j].BImage) then
      begin
        Affiche('Correction canton '+intToSTR(canton[i].numero)+' en y='+intToSTR(j),clCyan);
        tco[indexTCO,x,j].BImage:=t;
        TCO_modifie:=true;
      end;
      inc(t);
    end;
  end;

  //Affiche(intToSTR(xCanton)+' '+intToStr(yCanton),clyellow);
end;

// renseigne le canton index i avec les éléments contigus
procedure renseigne_canton(i : integer); overload;
var x,y,it : integer;
    Horz : boolean;
begin
  it:=canton[i].Ntco;
  x:=canton[i].x;
  y:=canton[i].y;
  horz:=tco[it,x,y].BImage=Id_cantonH;
  canton[i].horizontal:=horz;
  Horz:=canton[i].horizontal;
  renseigne_canton(i,Horz);
end;

procedure renseigne_tous_cantons;
var i : integer;
begin
  for i:=1 to Ncantons do
  begin
    renseigne_canton(i);
  end;
end;

// renseigne les éléments contigus des tjd des tco
procedure renseigne_TJDs_TCO;
var t,x,y,adr1,Bim,Netats,Adr2,index1,index2 : integer;
    typEL : tequipement;
    deb : boolean;
begin
  deb:=false;
  for t:=1 to NbreTco do
  begin
    for y:=1 to NbreCellY[t] do
      for x:=1 to NbreCellX[t] do
      begin
        Bim:=tco[t,x,y].BImage;
        adr1:=tco[t,x,y].Adresse;
        if adr1<>0 then
        begin
          index1:=index_aig(adr1);
          if index1<>0 then
          begin
            TypEl:=aiguillage[index1].modele;
            NEtats:=aiguillage[index1].EtatTJD;
            if Netats=4 then
            begin
              Adr2:=aiguillage[index1].DDroit; // homologue
              Index2:=index_aig(adr2);
            end;
            if (typEL=Tjd) or (typel=Tjs) then
            begin
              if deb then Affiche(intToSTR(adr1),clred);

              case Bim of
              21 : begin
                     zone_tco(t,adr1,typEl,SensTCO_E,13,false,false);  // chercher 1er élément à droite - xcanton Tel1
                     tco[t,x,y].SuivE:=xCanton;
                     tco[t,x,y].TypeE:=tel1;
                     if deb then Affiche('E='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_SO,13,false,false);  // chercher 1er élément SO
                     tco[t,x,y].SuivSO:=xCanton;
                     tco[t,x,y].TypeSO:=tel1;
                     if deb then Affiche('SO='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_O,13,false,false);  // élément à gauche
                     tco[t,x,y].SuivO:=xCanton;
                     tco[t,x,y].TypeO:=tel1;
                     if deb then Affiche('O='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_NE,13,false,false);  // chercher 1er élément NE
                     tco[t,x,y].SuivNE:=xCanton;
                     tco[t,x,y].TypeNE:=tel1;
                     if deb then Affiche('NE='+intToSTR(xcanton),clLime);

                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivE) or (aiguillage[index1].Adroit=tco[t,x,y].SuivNE) then
                     begin
                       tco[t,x,y].TjdE:=Adr1;
                       tco[t,x,y].TjdNE:=Adr1;
                       if deb then Affiche('La partie droite est attachée à la TJD '+intToSTR(adr1),clCyan);
                     end;
                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivO) or (aiguillage[index1].Adroit=tco[t,x,y].SuivSO) then
                     begin
                       tco[t,x,y].TjdO:=Adr1;
                       tco[t,x,y].TjdSO:=Adr1;
                       if deb then Affiche('La partie gauche est attachée à la TJD '+intToSTR(adr1),clCyan);
                     end;
                     if (aiguillage[index2].Adroit=tco[t,x,y].SuivE) or (aiguillage[index2].Adroit=tco[t,x,y].SuivNE) then
                     begin
                       tco[t,x,y].TjdE:=Adr2;
                       tco[t,x,y].TjdNE:=Adr2;
                       if deb then Affiche('La partie droite est attachée à la TJD '+intToSTR(adr2),clCyan);
                     end;
                     if (aiguillage[index2].Adroit=tco[t,x,y].SuivO) or (aiguillage[index2].Adroit=tco[t,x,y].SuivSO) then
                     begin
                       tco[t,x,y].TjdO:=Adr2;
                       tco[t,x,y].TjdSO:=Adr2;
                       if deb then Affiche('La partie gauche est attachée à la TJD '+intToSTR(adr2),clCyan);
                     end;

                   end;

              22 : begin
                     zone_tco(t,adr1,typEl,SensTCO_E,13,false,false);  // chercher 1er élément à droite - xcanton Tel1
                     tco[t,x,y].SuivE:=xCanton;
                     tco[t,x,y].TypeE:=tel1;
                     if deb then Affiche('E='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_SE,13,false,false);  // chercher 1er élément à droite - xcanton Tel1
                     tco[t,x,y].SuivSE:=xCanton;
                     tco[t,x,y].TypeSE:=tel1;
                     if deb then Affiche('SE='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_O,13,false,false);  // élément à gauche
                     tco[t,x,y].SuivO:=xCanton;
                     tco[t,x,y].TypeO:=tel1;
                     if deb then Affiche('O='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_NO,13,false,false);  // chercher 1er élément à droite - xcanton Tel1
                     tco[t,x,y].SuivNO:=xCanton;
                     tco[t,x,y].TypeNO:=tel1;
                     if deb then Affiche('NO='+intToSTR(xcanton),clLime);

                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivE) or (aiguillage[index1].Adroit=tco[t,x,y].SuivSE) then
                     begin
                       tco[t,x,y].TjdE:=Adr1;
                       tco[t,x,y].TjdSE:=Adr1;
                       if deb then Affiche('La partie droite est attachée à la TJD '+intToSTR(adr1),clCyan);
                     end;
                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivO) or (aiguillage[index1].Adroit=tco[t,x,y].SuivNO) then
                     begin
                       tco[t,x,y].TjdO:=Adr1;
                       tco[t,x,y].TjdNO:=Adr1;
                       if deb then Affiche('La partie gauche est attachée à la TJD '+intToSTR(adr1),clCyan);
                     end;
                     if (aiguillage[index2].Adroit=tco[t,x,y].SuivE) or (aiguillage[index2].Adroit=tco[t,x,y].SuivSE) then
                     begin
                       tco[t,x,y].TjdE:=Adr2;
                       tco[t,x,y].TjdSE:=Adr2;
                       if deb then Affiche('La partie droite est attachée à la TJD '+intToSTR(adr2),clCyan);
                     end;
                     if (aiguillage[index2].Adroit=tco[t,x,y].SuivO) or (aiguillage[index2].Adroit=tco[t,x,y].SuivNO) then
                     begin
                       tco[t,x,y].TjdO:=Adr2;
                       tco[t,x,y].TjdNO:=Adr2;
                       if deb then Affiche('La partie gauche est attachée à la TJD '+intToSTR(adr2),clCyan);
                     end;
                   end;
              23 : begin
                     zone_tco(t,adr1,typEl,SensTCO_N,13,false,false);  // haut
                     tco[t,x,y].SuivN:=xCanton;
                     tco[t,x,y].TypeN:=tel1;
                     if deb then Affiche('N='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_S,13,false,false);  // élément bas
                     tco[t,x,y].SuivS:=xCanton;
                     tco[t,x,y].TypeS:=tel1;
                     if deb then Affiche('S='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_NE,13,false,false);
                     tco[t,x,y].SuivNE:=xCanton;
                     tco[t,x,y].TypeNE:=tel1;
                     if deb then Affiche('NE='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_SO,13,false,false);
                     tco[t,x,y].SuivSO:=xCanton;
                     tco[t,x,y].TypeSO:=tel1;
                     if deb then Affiche('SO='+intToSTR(xcanton),clLime);

                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivN) or (aiguillage[index1].Adroit=tco[t,x,y].SuivNE) then
                     begin
                       tco[t,x,y].TjdN:=Adr1;
                       tco[t,x,y].TjdNE:=Adr1;
                       if deb then Affiche('La partie haute est attachée à la TJD '+intToSTR(adr1),clCyan);
                     end;
                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivS) or (aiguillage[index1].Adroit=tco[t,x,y].SuivSO) then
                     begin
                       tco[t,x,y].TjdS:=Adr1;
                       tco[t,x,y].TjdSO:=Adr1;
                       if deb then Affiche('La partie basse est attachée à la TJD '+intToSTR(adr1),clCyan);
                     end;
                     if (aiguillage[index2].Adroit=tco[t,x,y].SuivN) or (aiguillage[index2].Adroit=tco[t,x,y].SuivNE) then
                     begin
                       tco[t,x,y].TjdN:=Adr2;
                       tco[t,x,y].TjdNE:=Adr2;
                       if deb then Affiche('La partie haute est attachée à la TJD '+intToSTR(adr2),clCyan);
                     end;
                     if (aiguillage[index2].Adroit=tco[t,x,y].SuivS) or (aiguillage[index2].Adroit=tco[t,x,y].SuivSO) then
                     begin
                       tco[t,x,y].TjdS:=Adr2;
                       tco[t,x,y].TjdSO:=Adr2;
                       if deb then Affiche('La partie basse est attachée à la TJD '+intToSTR(adr2),clCyan);
                     end;
                   end;

              25 : begin
                     zone_tco(t,adr1,typEl,SensTCO_N,13,false,false);  // haut
                     tco[t,x,y].SuivN:=xCanton;
                     tco[t,x,y].TypeN:=tel1;
                     if deb then Affiche('N='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_S,13,false,false);  // élément bas
                     tco[t,x,y].SuivS:=xCanton;
                     tco[t,x,y].TypeS:=tel1;
                     if deb then Affiche('S='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_NO,13,false,false);  // chercher 1er élément à droite - xcanton Tel1
                     tco[t,x,y].SuivNO:=xCanton;
                     tco[t,x,y].TypeNO:=tel1;
                     if deb then Affiche('NO='+intToSTR(xcanton),clLime);

                     zone_tco(t,adr1,typEl,SensTCO_SE,13,false,false);  // chercher 1er élément à droite - xcanton Tel1
                     tco[t,x,y].SuivSE:=xCanton;
                     tco[t,x,y].TypeSE:=tel1;
                     if deb then Affiche('SE='+intToSTR(xcanton),clLime);

                     if (aiguillage[index1].Adroit=tco[t,x,y].SuivN) or (aiguillage[index1].Adroit=tco[t,x,y].SuivNO) then
                     begin
                       tco[t,x,y].TjdN:=Adr1;
                       tco[t,x,y].TjdNO:=Adr1;
                       if deb then Affiche('La partie haute est attachée à la TJD '+intToSTR(adr1),clCyan);
                    end;
                    if (aiguillage[index1].Adroit=tco[t,x,y].SuivS) or (aiguillage[index1].Adroit=tco[t,x,y].SuivSE) then
                    begin
                      tco[t,x,y].TjdS:=Adr1;
                      tco[t,x,y].TjdSE:=Adr1;
                      if deb then Affiche('La partie basse est attachée à la TJD '+intToSTR(adr1),clCyan);
                    end;
                    if (aiguillage[index2].Adroit=tco[t,x,y].SuivN) or (aiguillage[index2].Adroit=tco[t,x,y].SuivNO) then
                    begin
                      tco[t,x,y].TjdN:=Adr2;
                      tco[t,x,y].TjdNO:=Adr2;
                      if deb then Affiche('La partie haute est attachée à la TJD '+intToSTR(adr2),clCyan);
                    end;
                    if (aiguillage[index2].Adroit=tco[t,x,y].SuivS) or (aiguillage[index2].Adroit=tco[t,x,y].SuivSE) then
                    begin
                      tco[t,x,y].TjdS:=Adr2;
                      tco[t,x,y].TjdSE:=Adr2;
                      if deb then Affiche('La partie basse est attachée à la TJD '+intToSTR(adr2),clCyan);
                    end;
                  end;
              end;
            end;
          end;
        end;
      end;
    end;
end;

// créée un nouveau TCO qui n'existait pas
procedure Init_TCO(indexTCO : integer);
var x,y : integer;
begin
  sauve_tco:=true;
  Affiche('Nouveau tco '+intToSTr(indexTCO),clyellow);
  NbreCellX[indexTCO]:=35;NbreCellY[indexTCO]:=20;LargeurCell[indexTCO]:=35;HauteurCell[indexTCO]:=35;
  largeurCelld2[indexTCO]:=largeurCell[indexTCO] div 2;HauteurCelld2[indexTCO]:=HauteurCell[indexTCO] div 2;
  EcranTCO[indexTCO]:=1;
  RatioC:=10;
  ClFond[indexTCO]:=$000040;
  ClVoies[indexTCO]:=$0077FF;
  ClAllume[indexTCO]:=$00FFFF;
  ClGrille[IndexTCO]:=$404040;
  CoulCantonLibre[indexTCO]:=$004000;
  CoulCantonOccupe[indexTCO]:=$000040;
  ClQuai[indexTCO]:=$808080;
  clPiedSignal[indexTCO]:=$4080FF;
  ClCanton[indexTCO]:=$00FFFF;
  AvecGrille[indexTCO]:=true;
  if indexTCO=1 then Graphisme:=2;
  SetLength(TCO[indexTCO],MaxCellX+2,MaxCellY+2); // +2 pour éviter les erreurs d'index sur +1 et -1
  init_tampon_copiercoller;

  for x:=1 to NbreCellX[indexTCO] do
    for y:=1 to NbreCellY[indexTCO] do
      with tco[indextco,x,y] do
      begin
        CouleurFond:=clfond[indexTCO];
        Adresse:=0;
        Bimage:=0;
        repr:=2;
        Texte:='';
        fonte:='Arial';
        fontSTyle:='';
        PiedSignal:=0;
        NumCanton:=0;
        x:=0;
        y:=0;
        FeuOriente:=0;
        Liaisons:=0;
        Epaisseur:=0;
        Buttoir:=0;
        sortie:=0;
        SensCirc:=0;
      end;
end;

procedure lire_fichier_tco(indexTCO : integer);
var fichier : textfile;
    s,sa,so : string;
    Bim,nv,x,y,i,j,m,adresse,valeur,erreur,FeuOriente,PiedFeu,tailleFont,e,NPar : integer;
    trouve_CoulFond,trouve_clVoies,trouve_clAllume,trouve_clGrille,trouve_clCanton,
    trouve_clTexte,trouve_clQuai,trouve_matrice,trouve_ratio,trouve_ModeCanton,
    trouve_AvecGrille,trouve_clPiedSignal,cuc,trouve_clCantonOccupe,trouve_clCantonLibre,
    LecCanton : boolean;

    function lit_ligne : string ;
    var c : char;
    begin
      repeat
        readln(fichier,s);
        so:=s;
        s:=Uppercase(s);
        //Affiche(s,clWhite);
        c:=#0;
        if length(s)>0 then c:=s[1];
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      lit_ligne:=s;
    end;

begin
  //Affiche(GetCurrentDir,clYellow);
  {$I+}
  try
    assignFile(fichier,NomfichierTCO[indexTCO]);
    reset(fichier);
  except
    init_tco(indexTCO);
    exit;
  end;
  {$I-}
  if debug=1 then Affiche('Lecture tco '+intToSTr(indexTCO)+' '+NomfichierTCO[indexTCO],clLime);
  x:=1;y:=1;NbreCellX[indexTCO]:=0;NbreCellY[indexTCO]:=0; RatioC:=10;
  Graphisme:=1;
  trouve_clAllume:=false;
  trouve_CoulFond:=false;
  trouve_clVoies:=false;
  trouve_clGrille:=false;
  trouve_clTexte:=false;
  trouve_clPiedSignal:=false;
  trouve_clQuai:=false;
  trouve_matrice:=false;
  trouve_ratio:=false;
  trouve_clCanton:=false;
  trouve_clCantonLibre:=False;
  trouve_clCantonOccupe:=False;
  trouve_ModeCanton:=false;
  trouve_AvecGrille:=false;
  eval_format:=false;
  ModeCouleurCanton:=1;
  AvecGrille[indexTCO]:=true;
  clCanton[indexTCO]:=ClYellow;

  // supprimer les cantons de ce TCO
  for i:=1 to Ncantons do
  begin
    if canton[i].Ntco=indexTCO then supprime_canton(i);
  end;

  // couleurs
  repeat
    s:=lit_ligne;

    sa:=uppercase(ClFond_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_CoulFond:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clfond[indexTCO]:=i;
     // eval_format:=true;
    end;

    sa:=uppercase(clVoies_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clVoies:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clVoies[indexTCO]:=i;
    end;

    sa:=uppercase(ZoomInit_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      ZoomInit[indexTCO]:=i;
    end;

    sa:=uppercase(XYInit_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      XInit[indexTCO]:=i;
      delete(s,1,erreur);
      val(s,i,erreur);
      YInit[indexTCO]:=i;
    end;

    sa:=uppercase(clAllume_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clAllume:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clAllume[indexTCO]:=i;
    end;

    sa:=uppercase(clGrille_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clGrille:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clGrille[IndexTCO]:=i;
    end;

    sa:=uppercase(clTexte_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clTexte:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clTexte:=i;
    end;

    sa:=uppercase(clQuai_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clQuai:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clQuai[indexTCO]:=i;
    end;

    sa:=uppercase(ClCantonLibre_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clCantonLibre:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      CoulCantonLibre[indexTCO]:=i;
    end;

    sa:=uppercase(ClCantonOccupe_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clCantonOccupe:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      CoulCantonOccupe[indexTCO]:=i;
    end;

    sa:=uppercase(clPiedSignal_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clPiedSignal:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clPiedSignal[indexTCO]:=i;
    end;

    sa:=uppercase(ClCanton_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clCanton:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      ClCanton[indexTCO]:=i;
    end;

    sa:=uppercase(ModeCouleurCanton_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_ModeCanton:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      ModeCouleurCanton:=i;
    end;

    sa:=uppercase(Graphisme_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      if (i<1) or (i>2) then i:=1;
      Graphisme:=i;
    end;

    sa:=uppercase(Ecran_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      if (i<1) or (i>2) then i:=1;
      EcranTCO[indexTCO]:=i;
    end;

    sa:=uppercase(JeuCouleurs_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      if (i<1) or (i>3) then i:=1;
      JeuCouleurs:=i;
    end;

    sa:=uppercase(Epaisseur_voies_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      if (i<1) or (i>10) then i:=5;
      Epaisseur_voies:=i;
    end;

    sa:=uppercase(AvecGrille_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_AvecGrille:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      AvecGrille[indexTCO]:=i=1;
    end;

    // taille de la matrice
    sa:=uppercase(Matrice_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_matrice:=true;
      delete(s,i,length(sa));
      val(s,NbreCellX[indexTCO],erreur);
      i:=pos(',',s);delete(s,1,i);
      Val(s,NbreCellY[indexTCO],erreur)
    end;

    // ratio
    sa:=uppercase(Ratio_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_ratio:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      RatioC:=i;
    end;

    // evt clic det
    sa:=uppercase(EvtClicDet_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      val(s,i,erreur);
      EvtClicDet:=i=1;
    end;

  until (pos('[MATRICE]',uppercase(s))<>0) or (eof(fichier));

  NbCellulesTCO[indexTCO]:=NbreCellX[indexTCO]*NbreCellY[indexTCO];

  if (NbreCellX[indexTCO]<20) or (NbreCellX[indexTCO]>MaxCellX) then
  begin
    NbreCellX[indexTCO]:=MaxCellX;
    s:='TCO: le nombre de cellules X a été ramené à '+intToSTR(NbreCellX[indexTCO]);
    Affiche(s,clred);
    FormTCO[IndexTCO].Caption:=s;
  end;
  if (NbreCellY[indexTCO]<5) or (NbreCellY[indexTCO]>MaxCellY) then
  begin
    NbreCellY[indexTCO]:=MaxCellY;
    s:='TCO: le nombre de cellules Y a été ramené à '+intToSTR(NbreCellX[indexTCO]);
    FormTCO[IndexTCO].Caption:=s;
    Affiche(s,clred);
  end;

  try
    SetLength(TCO[indexTCO],MaxCellX+2,MaxCellY+2)
  except
    s:='TCO:Mémoire insuffisante pour'+intToSTR(MaxCellX)+' '+intToSTR(MaxCellY);
    Affiche(s,clred);
    FormTCO[IndexTCO].Caption:=s;
    NbreCellX[indexTCO]:=20;NbreCellY[indexTCO]:=12;
    SetLength(TCO[indexTCO],NbreCellX[indexTCO]+2,NbreCellY[indexTCO]+2);
  end;

  try
    init_tampon_copiercoller;
  except
    s:='TamponTCO:Mémoire insuffisante';
    Affiche(s,clred);
    FormTCO[IndexTCO].Caption:=s;
    NbreCellX[indexTCO]:=20;NbreCellY[indexTCO]:=12;
    init_tampon_copiercoller;
  end;

  // lire la matrice
  while not eof(fichier) do
  begin
    lit_ligne;
    s:=so;
    if s[1]<>'/' then
    begin
      repeat
        i:=pos('(',s);
        if i=0 then begin
          Affiche(s,clYellow);
          Affiche('ETCO1',clred);closefile(fichier);exit;
        end;
        delete(s,1,i);
        // compter le nombre de virgules avant le )
        npar:=0;i:=0;
        j:=pos(')',s);
        repeat
          i:=posEx(',',s,i+1);
          inc(npar);
        until (i>j) or (i=0);

        if npar<15 then sauve_tco:=true;

        // 1 couleur de fond
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO2',clred);closefile(fichier);exit;end;
        val('$'+copy(s,1,i-1),CoulFonte,erreur);
        if erreur<>0 then begin Affiche('ETCO3',clred);closefile(fichier);exit;end;
        if coulFonte=0 then
        begin coulFonte:=clfond[indexTCO];sauve_tco:=true;end;
        tco[indexTCO,x,y].CouleurFond:=coulFonte;
        delete(s,1,i);

        // 2 Adresse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO4',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),adresse,erreur);
        if erreur<>0 then begin Affiche('ETCO5',clred);closefile(fichier);exit;end;
        tco[indexTCO,x,y].adresse:=adresse;
        delete(s,1,i);

        // 3 Bimage
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO6',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);
        if erreur<>0 then begin Affiche('ETCO7',clred);closefile(fichier);exit;end;
        // anciens id
          if valeur=30 then begin valeur:=Id_signal;sauve_tco:=true;end;
          if valeur=31 then begin valeur:=id_Quai;sauve_tco:=true;end;
        tco[indexTCO,x,y].Bimage:=valeur;
        if valeur<=34 then tco[indexTCO,x,y].liaisons:=liaisons[valeur] else tco[indexTCO,x,y].liaisons:=0;
        Bim:=valeur;
        cuc:=false;

        // cantons
        if (valeur=Id_CantonH) or (valeur=Id_CantonV) then
        begin
          if ncantons<MaxCantons then
          begin
            cuc:=true;    // mémo id canton
            LecCanton:=true; // mis à 1, et mis à 0 quand on a trouvé la fin de canton
            inc(nCantons);
            // le numéro de canton est lu plus loin
            canton[ncantons].x:=x;
            canton[ncantons].y:=y;
            canton[ncantons].indexTrain:=0;
            canton[ncantons].Ntco:=indexTCO;
          end
          else Affiche('Nombre maximal de cantons atteints',clred);
        end;

        delete(s,1,i);

        // 4 - Inverse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO8',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO9',clred);closefile(fichier);exit;end;
        tco[indexTCO,x,y].inverse:=valeur=1;
        delete(s,1,i);

        // 5 - FeuOriente ou Nombre de cellules Canton
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO10',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),FeuOriente,erreur);

        if cuc then
        begin
          if FeuOriente=0 then FeuOriente:=3;
          canton[ncantons].Nelements:=FeuOriente;
          tco[indexTCO,x,y].FeuOriente:=FeuOriente;
        end;

        if erreur<>0 then begin Affiche('ETCO11',clred);closefile(fichier);exit;end;
        delete(s,1,i);

        // 6 - PiedFeu ou numéro de canton
        i:=pos(',',s);
        //if j<i then i:=j;
        val(s,PiedFeu,erreur);
        delete(s,1,i);
        if (Bim=Id_CantonH) or (Bim=Id_CantonV) then
        begin
         // affiche(inttostr(piedfeu),clyellow);
          //Affiche('indexcanton='+intToSTR(ncantons)+' numcanton lu='+intToSTR(piedFeu),clOrange);
          tco[indexTCO,x,y].NumCanton:=PiedFeu;
          if cuc then
          begin
            canton[ncantons].numero:=piedFeu;
          end;
        end;

        // si c'est un signal, remplir les paramètres du signal
        if Bim=Id_signal then
        begin
          i:=Index_Signal(adresse);
          if i<>0 then
          begin
            //Affiche('Feu '+IntToSTR(Adresse)+' aspect='+intToSTR(aspect),clyellow);
            if FeuOriente<1 then FeuOriente:=1;
            if FeuOriente>4 then FeuOriente:=1;
            tco[indexTCO,x,y].FeuOriente:=FeuOriente;
            tco[indexTCO,x,y].x:=0;
            tco[indexTCO,x,y].y:=0;

            if PiedFeu<1 then PiedFeu:=1;
            if PiedFeu>2 then PiedFeu:=2;
            tco[indexTCO,x,y].PiedSignal:=PiedFeu;
          end;
        end;
        // si c'est une action, remplir les paramètres de l'action
        if tco[indexTCO,x,y].Bimage=Id_action then
        begin
          tco[indexTCO,x,y].PiedSignal:=PiedFeu;       // quelle action
          tco[indexTCO,x,y].FeuOriente:=FeuOriente; // paramètre de l'action
          if (PiedFeu=AcBouton_bistable) then
          begin
            if (adresse<=100) and (adresse>0) then
            begin
              BoutonTCO[adresse].existe:=true;
              BoutonTCO[adresse].idtco:=IndexTCO;
              BoutonTCO[adresse].x:=x;
              BoutonTCO[adresse].y:=y;
            end
            else Affiche('Erreur N° de bouton TCO incorrect ('+intToSTR(adresse)+')',clred);
          end;
        end;

        // 7 texte optionnel
        j:=pos(')',s);
        i:=pos(',',s);
        tco[indexTCO,x,y].Texte:='';
        if j>1 then // le , est avant le ) donc il y a un texte
        begin
          if j<i then m:=j else m:=i;
          so:=copy(s,1,m-1);
          if (Bim=Id_CantonH) or (Bim=Id_CantonV) then
          begin
            canton[ncantons].nom:=so;
          end
          else tco[indexTCO,x,y].Texte:=so;
        end;

        delete(s,1,m-1);

        // 8 représentation
        if s[1]=',' then delete(s,1,1);
        val(s,j,erreur);
        tco[indexTCO,x,y].repr:=j;
        delete(s,1,erreur-1);

        // 9 fonte
        if s[1]=',' then delete(s,1,1);
        i:=pos(',',s);
        tco[indexTCO,x,y].fonte:=copy(s,1,i-1);
          //Affiche(fonte,clyellow);
        Delete(s,1,i);

        // 10 taille fonte
        Val(s,taillefont,erreur);
        tco[indexTCO,x,y].TailleFonte:=taillefont;
        delete(s,1,erreur);

        // 11 couleur fonte
        i:=pos(',',s);
        val('$'+s,coulFonte,erreur);
        tco[indexTCO,x,y].coulFonte:=coulFonte;
        delete(s,1,i);

        // 12 style
        if (s[1]<>')') and (s[1]<>',') then
        begin
          // style GISB
          i:=pos(')',s); j:=pos(',',s);
          if j<i then i:=j;
          tco[indexTCO,x,y].fontstyle:=copy(s,1,i-1);
          delete(s,1,i-1);
        end;

        // 13 épaisseur
        if npar>=13 then
        begin
          delete(s,1,1); // supprimer la virgule
          val(s,i,erreur);
          tco[indexTCO,x,y].epaisseurs:=i;
          i:=pos(')',s); j:=pos(',',s);if j<i then i:=j;
          delete(s,1,i-1);
        end;

        // 14 pont : ou alignement train dans canton
        if npar>=14 then
        begin
          delete(s,1,1); // supprimer la virgule
          val(s,i,erreur);
          tco[indexTCO,x,y].pont:=i;
          i:=pos(')',s); j:=pos(',',s);if j<i then i:=j;
          delete(s,1,i-1);
        end;

        // 15 buttoir
        if npar>=15 then
        begin
          delete(s,1,1); // supprimer la virgule
          val(s,i,erreur);
          tco[indexTCO,x,y].buttoir:=i;
          //if i<>0 then tco[indexTCO,x,y].Adresse:=0;  // pas d'adresse dans un buttoir
          i:=pos(')',s); j:=pos(',',s);if j<i then i:=j;
          delete(s,1,i-1);
        end;

        // 16 sortie action
        if npar>=16 then
        begin
          delete(s,1,1); // supprimer la virgule
          val(s,i,erreur);
          tco[indexTCO,x,y].sortie:=i;
          delete(s,1,erreur-1);
        end;

        // 17 nouveau version 8.9 sens circulation du canton
        if npar>=17 then
        begin
          delete(s,1,1); // supprimer la virgule
          val(s,i,erreur);
          if (i<0) or (i>4) then i:=0;
          tco[indexTCO,x,y].SensCirc:=i;
          delete(s,1,erreur-1);
        end;

        i:=pos(')',s);
        if i<>0 then delete(s,1,i);

        inc(x);
      until s='';
    end;
    inc(y);x:=1;
  end;
  closefile(fichier);
  renseigne_tous_cantons;
  trier_cantons;
       

  sauve_styles_tco(indexTCO); // sauver le jeu sombre
  if jeucouleurs=2 then jeu_clair(indexTCO);

  e:=sizeof(Tco) div 1024;
  //Affiche('Dimensions du tco : '+intToSTR(NbreCellX)+'x'+intToSTR(NbreCellY)+' / '+IntToSTR(e)+'Ko',clyellow);
  if not(trouve_clPiedSignal) then clPiedSignal:=Clvoies;
  if not(trouve_clCantonLibre) then CoulCantonLibre[indexTCO]:=$004000;
  if not(trouve_clCantonOccupe) then CoulCantonOccupe[indexTCO]:=$40;

end;

procedure echange(var a,b : integer);
var i : integer;
begin
  i:=a;
  a:=b;
  b:=i;
end;

// donne l'équation de droite y=ax+b passant par les points (x1,y1) (x2,y2)
procedure droite(x1,y1,x2,y2: integer;var a,b: single);
begin
  if x2<>x1 then a:=(y2-y1)/(x2-x1) else a:=99999;
  b:=y1-a*x1;
end;

procedure sauve_fichiers_tco;
var fichier : textfile;
    s : string;
    couleurFonte : Tcolor;
    x,y,i,id,Bimage : integer;
begin
  //x:=formconfig.MemoNomTCO.Lines.Count;
  //if x<0 then
  for i:=1 to NbreTCO do
  begin
    restitue_styles(i);
    AssignFile(fichier,nomfichierTCO[i]);
    rewrite(fichier);
    Writeln(fichier,'/ Définitions TCO version '+versionSC+sousversion);
    writeln(fichier,ZoomInit_ch+'=',ZoomInit[i]);
    writeln(fichier,XYInit_ch+'=',XInit[i],',',Yinit[i]);
    Writeln(fichier,clFond_ch+'='+IntToHex(clfond[i],6));
    Writeln(fichier,clVoies_ch+'='+IntToHex(ClVoies[i],6));
    Writeln(fichier,clAllume_ch+'='+IntToHex(ClAllume[i],6));
    Writeln(fichier,clGrille_ch+'='+IntToHex(ClGrille[i],6));
    Writeln(fichier,clTexte_ch+'='+IntToHex(ClTexte,6));
    Writeln(fichier,clQuai_ch+'='+IntToHex(ClQuai[i],6));
    Writeln(fichier,clPiedSignal_ch+'='+intToHex(clPiedSignal[i],6));
    Writeln(fichier,ClCanton_ch+'='+IntToHex(ClCanton[i],6));
    Writeln(fichier,ClCantonLibre_ch+'='+IntToHex(CoulCantonLibre[i],6));
    Writeln(fichier,ClCantonOccupe_ch+'='+IntToHex(CoulCantonOccupe[i],6));

    Writeln(fichier,ModeCouleurCanton_ch+'='+intToSTR(ModeCouleurCanton));
    if avecGrille[i] then s:='1' else s:='0';
    Writeln(fichier,Avecgrille_ch+'='+s);
    writeln(fichier,Graphisme_ch+'=',graphisme);
    writeln(fichier,Ecran_ch+'=',EcranTCO[i]);
    writeln(fichier,JeuCouleurs_ch+'=',JeuCouleurs);
    writeln(fichier,Epaisseur_voies_ch+'=',Epaisseur_voies);
    if EvtClicDet then s:='1' else s:='0';
    Writeln(fichier,EvtClicDet_ch+'='+s);

    writeln(fichier,matrice_ch+'='+IntToSTR(NbreCellX[i])+','+intToSTR(NbreCellY[i]));
    writeln(fichier,Ratio_ch+'='+intToSTR(ratioC));
    writeln(fichier,'/ Matrice TCO');
    writeln(fichier,'[Matrice]');
    writeln(fichier,
    '/ couleur fond,adresse,image,inversion aiguillage,Orientation du signal, pied du signal , [texte], representation, fonte, taille fonte, couleur fonte, style, épaisseurs, pont, buttoir, sortieAction, sensCirculation ');
    for y:=1 to NbreCellY[i] do
    begin
      s:='';
      for x:=1 to NbreCellX[i] do
      begin
        // couleur fond , adresse , Image
        Bimage:=tco[i,x,y].BImage;
        s:=s+'('+intToHex(tco[i,x,y].CouleurFond,6)+','+inttostr(tco[i,x,y].Adresse)+','+IntToSTR(Bimage)+',';

        // inversion
        if tco[i,x,y].inverse then s:=s+'1,' else s:=s+'0,';

        // orientation signal ou Nombre éléments cantons
        if (Bimage=Id_CantonH) or (Bimage=Id_cantonV) then s:=s+intToSTR(tco[i,x,y].FeuOriente)
        else s:=s+IntToSTR(tco[i,x,y].FeuOriente);
        s:=s+',';

        // piedFeu ou index canton
        if (Bimage=Id_CantonH) or (Bimage=Id_cantonV) then s:=s+intToSTR(tco[i,x,y].NumCanton)
        else s:=s+IntToSTR(tco[i,x,y].PiedSignal);
        s:=s+',';

        // texte ou nom du canton
        if (Bimage=Id_CantonH) or (Bimage=Id_cantonV) then
        begin
          id:=index_canton_numero(tco[i,x,y].NumCanton);
          s:=s+canton[id].nom+',';
        end
        else s:=s+tco[i,x,y].Texte+',';
        // représentation
        s:=s+intToSTR(tco[i,x,y].repr);
        // NomFonte
        s:=s+','+tco[i,x,y].Fonte;
        //taille fonte
        s:=s+','+intToSTR(tco[i,x,y].tailleFonte);
        // couleur fonte
        couleurfonte:=tco[i,x,y].coulFonte;
        s:=s+','+intTohex(couleurFonte,6);
        s:=s+','+tco[i,x,y].FontStyle;
        s:=s+','+intToSTR(tco[i,x,y].epaisseurs);
        s:=s+','+intToSTR(tco[i,x,y].pont);
        s:=s+','+intToSTR(tco[i,x,y].buttoir);
        s:=s+','+intToSTR(tco[i,x,y].sortie);
        s:=s+','+intToSTR(tco[i,x,y].SensCirc);
        s:=s+')';
      end;
      writeln(fichier,s);
    end;
    closefile(fichier);
    Affiche('TCO '+nomFichierTCO[i]+' sauvegardé',clyellow);
  end;
  TCO_modifie:=false;

end;

// calcule les Hauteur et Largeur des cellules en fonction du Zoom
procedure calcul_cellules(indexTCO : integer);
var pos : integer;
begin
  if affevt then affiche('Calcul_cellules',clyellow);

  pos:=ZoomMax-ZoomInit[indexTCO]+ZoomMin;
  //Affiche('Position TrackBar°'+intToSTR(indexTCO)+'='+intToSTR(pos),clyellow);
  LargeurCell[indexTCO]:=pos;

  //Affiche('LargeurCell TCO N°'+intToSTR(indexTCO)+'='+intToSTR(largeurcell[indexTCO]),clyellow);
  hauteurCell[indexTCO]:=(LargeurCell[indexTCO] * RatioC) div 10;
  largeurCelld2[indexTCO]:=largeurCell[indexTCO] div 2;
  HauteurCelld2[indexTCO]:=HauteurCell[indexTCO] div 2;

  //Affiche(intToSTR(LargeurCell[indexTCO])+' '+intToSTR(epaisseur),clyellow);
end;

procedure affiche_info(id,x,y : integer;s : string);
begin
  FormInfo.LabelInfo.caption:=s;
  FormInfo.Top:=FormTCO[id].top+y-FormTCO[id].ScrollBox.vertScrollBar.Position+20;
  FormInfo.Left:=FormTCO[id].left+x-FormTCO[id].ScrollBox.HorzScrollBar.Position+50;
  if formInfo.left+formInfo.Width>formTCO[id].Left+formTCO[id].Width then
    formInfo.left:=formTCO[id].Width-formInfo.Width;
  FormInfo.Show;
end;

// renvoie la position de l'aiguillage en position x,y du tco indextco
function positionTCO(indexTCO,x,y : integer) : integer;
var position,i : integer;
begin
  i:=index_Aig(tco[indextco,x,y].Adresse);
  position:=aiguillage[i].position ;
  if (position=0) or (i=0) then begin result:=const_inconnu;exit;end;
  if tco[indextco,x,y].inverse then
  begin
    if position=const_droit then begin result:=const_devie;exit;end;
    if position=const_devie then begin result:=const_droit;exit;end;
    result:=const_inconnu;
    exit;
  end
  else result:=position;
end;

// arc elliptique à deux rayons différents
procedure D_Arc2R(Canvas: TCanvas; CentreX,CentreY: integer;
                rayonX,rayonY: Integer; StartDegres, StopDegres: single);
var sinA,cosA : extended;
    x1,x2,x3,x4,y1,y2,y3,y4: Integer;
begin
  if StopDegres<0 then setArcDirection(Canvas.Handle,AD_COUNTERCLOCKWISE)
    else setArcDirection(Canvas.Handle,AD_CLOCKWISE);

  StartDegres:=startDegres*pisur180;
  stopDegres:=StartDegres+stopDegres*pisur180;
  x1:=CentreX - rayonX;
  y1:=CentreY - rayonY;
  x2:=CentreX + rayonX;
  y2:=CentreY + rayonY;
  SinCos(StartDegres,SinA,CosA);
  x4:=CentreX + round(rayonX*CosA);
  y4:=Centrey - Round(rayonY*SinA);
  SinCos(StopDegres,SinA,CosA);
  x3:=CentreX + round(rayonX*CosA);
  y3:=Centrey - round(rayonY*SinA);
  Canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
end;

// affiche la sélection bleue des cellules
procedure affiche_selection(indexTCO : integer);
var r : Trect;
    larg,haut : integer;
begin
  if FormTCO[indexTCO].RadioGroupSel.ItemIndex=0 then
  begin
    larg:=largeurCell[indexTCO];
    haut:=HauteurCell[indexTCO];

    with PImageTCO[indexTCO].Canvas do
    begin
      Pen.Mode:=PmXor;
      Pen.color:=clGrille[IndexTCO];
      Brush.Color:=clblue;
      //FillRect(r);
      r:=Rect((xminiSel-1)*Larg,(YminiSel-1)*Haut,(XmaxiSel)*larg,(yMaxiSel)*haut);
      Rectangle(r);
    end;
  end;
end;


procedure efface_selection(indexTCO : integer);
begin
  if SelectionAffichee[indexTCO] then
  begin
    //Affiche('efface sélection',clOrange);
    with formtco[indexTCO].imageTCO.Canvas do
    begin
      Pen.Mode:=PmXor;
      Pen.color:=clGrille[IndexTCO];
      Brush.Color:=clblue;
      //FillRect(r);
      Rectangle(rAncien);
    end;
    SelectionAffichee[indexTCO]:=false;
  end;
end;

// élément de voie horizontale Element 1
procedure dessin_1(indexTCO: integer;Canvas : Tcanvas;x,y,mode : integer);
var Adr,yf,xf,x0,y0,jy1,jy2,ep,xc,yc,but : integer;
    r : Trect;
    couleur : Tcolor;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*HauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(HauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+HauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  but:=tco[indextco,x,y].buttoir;

  with canvas do
  begin
    //Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Mode:=pmCopy;

    // buttoir
    if but<>0 then
    begin
      case mode of
        0 : couleur:=clVoies[indexTCO];
        1 : couleur:=clAllume[indexTCO];
        2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      pen.color:=couleur;
      if testbit(ep,7) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;

      if testBit(but,7) then
      begin
        moveTo(x0,yc);LineTo(xc,yc);
      end;
      if testBit(but,3) then
      begin
        moveTo(xc,yc);LineTo(xf,yc);
      end;

      Pen.Width:=epaisseur;
      pen.Color:=Clred;
      moveto(xc,yc+round(7*fryGlob[indexTCO]));
      LineTo(xc,yc-round(7*fryGlob[indexTCO]));
      exit;
    end;


    // détecteur
    Adr:=tco[indextco,x,y].adresse;
    if adr<>0 then
    begin
      pen.Width:=1;
      if detecteur[Adr].etat then
      begin
        brush.Color:=clAllume[indexTCO];
        pen.color:=clAllume[indexTCO];
      end
      else
      begin
        pen.color:=tco[indextco,x,y].CouleurFond;
        brush.color:=tco[indextco,x,y].CouleurFond;
      end;
      // dessine la bande horizontale
      jy1:=y0+(HauteurCell[indexTCO] div 2)-round(7*fryGlob[indexTCO]); // pos Y de la bande sup
      jy2:=y0+(HauteurCell[indexTCO] div 2)+round(7*fryGlob[indexTCO]); // pos Y de la bande inf
      if avecGrille[indexTCO] then r:=Rect(x0+1,jy1,xf-1,jy2) else
      r:=Rect(x0,jy1,x0+LargeurCell[indexTCO],jy2) ;
      FillRect(r);
    end;

    // dessine la voie
    case mode of
      0 : couleur:=clVoies[indexTCO];
      1 : couleur:=clAllume[indexTCO];
      2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    pen.color:=couleur;
    if testbit(ep,7) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    moveTo(x0,yc);LineTo(xf,yc);
  end;
end;

function IsVoieDroite(i : integer) : boolean;
begin
  result:=(i=1) or (i=10) or (i=11) or (i=20);
end;

// renvoie vrai si l'élément i est un canton H ou V
function IsCanton(i : integer) : boolean;
begin
  result:=((i>=Id_cantonH) and (i<=Id_CantonH+9)) or ((i>=Id_cantonV) and (i<=Id_CantonV+9))
end;

// renvoie vrai si l'élément i est un canton H
function IsCantonH(i : integer) : boolean;  overload;
begin
  result:=((i>=Id_cantonH) and (i<=Id_CantonH+9));
end;

// 2eme forme ; si x,y est un canton
function IsCantonH(indexTCO,x,y : integer) : boolean;  overload;
var b : integer;
begin
  b:=tco[indexTCO,x,y].BImage;
  result:=((b>=Id_cantonH) and (b<=Id_CantonH+9));
end;

// renvoie vrai si l'élément i est un canton V
function IsCantonV(i : integer) : boolean; overload;
begin
  result:=((i>=Id_cantonV) and (i<=Id_CantonV+9));
end;

// 2eme forme
function IsCantonV(indexTCO,x,y : integer) : boolean;  overload;
var b : integer;
begin
  b:=tco[indexTCO,x,y].BImage;
  result:=(b>=Id_cantonV) and (b<=Id_CantonV+9);
end;

// renvoie vrai si l'élément i est un aiguillage ou une TJD/S ou un croisement
function IsAigTJDCroiTCO(i : integer) : boolean;
begin
  result:=((i=2) or (i=3) or (i=4) or (i=5) or (i=12) or (i=13) or (i=14) or (i=15) or
          ((i>=21) and (i<=34) )) ;
end;

// écrit le texte réparti sur plusieurs lignes.
// ne fonctionne qu'avec certaines fontes
// x,y : en cellules
// tf=taille fonte
Procedure Texte_reparti(s : string;indexTCO,x,y,tf : integer);
var c : Tcanvas;
    st : array[1..10] of string;
    haut,larg,i,l,PixelLength,NombreMots,yl : integer;
begin
  if (s='') or (indexTCO=0) then exit;
  // supprimer les espaces en fin
  i:=Length(s);
  if s[i]=' ' then
  begin
    repeat
      dec(i);
    until (s[i]<>' ') or (i=1);
    delete(s,i+1,length(s)-i);
  end;

  // découper la chaine s dans le tableau st
  if tf=0 then tf:=8;
  c:=PcanvasTCO[indexTCO];
  i:=1;l:=length(s);NombreMots:=1;
  repeat
    i:=pos(' ',s);
    if i=0 then st[NombreMots]:=s else st[NombreMots]:=copy(s,1,i-1);
    delete(s,1,i);
    inc(NombreMots);
  until (i>l) or (i=0);
  dec(NombreMots);

  PixelLength:=tf;

  // x y en cellules
  larg:=LargeurCell[indexTCO];
  haut:=HauteurCell[indexTCO];
  l:=0; // compteur de lignes
  i:=1;
  // faire une ligne
  repeat
    s:='';
    repeat
      s:=s+st[i]+' ';
      inc(i);
      //Affiche(s+' '+intToSTR(tf*length(s+st[i])),clyellow);
    until (round(0.8*tf*length(s+st[i]))>larg) or (i>NombreMots);
    //yl:=(y-1)*round((l*tf));
    delete(s,length(s),1);
    yl:=round(1.5*l*tf)+((y-1)*haut);

    with PCanvasTCO[indexTCO] do
    begin
      {$IF CompilerVersion >= 28.0}
      font.orientation:=0;
      {$IFEND}
      TextOut((x-1)*larg+5,yl+3,s);
    end;
    inc(l);
  until (i>NombreMots);
end;


function style(s : string) : TfontStyles;
var fs : tFontStyles;
begin
  fs:=[];
  if pos('G',s)<>0 then fs:=fs+[fsbold];
  if pos('I',s)<>0 then fs:=fs+[fsItalic];
  if pos('S',s)<>0 then fs:=fs+[fsUnderline];
  if pos('B',s)<>0 then fs:=fs+[fsStrikeout];
  style:=fs;
end;

function Taille_Fonte(tf : integer) : integer;
var Larg : integer;
begin
  Larg:=LargeurCell[indexTCOCourant];
  result:=((Larg*tf) div 40)+1;
end;

procedure affiche_texte(indextco,x,y : integer);
var b,x0,y0,xt,yt,repr,largCell,hautCell,tf,tailleFont : integer;
    ss,s,nf : string;
    c : Tcanvas;
    r : Trect;
begin
  c:=PcanvasTCO[indextco];
  if c=nil then exit;

  {$IF CompilerVersion >= 28.0}
  c.font.orientation:=0;
  {$IFEND}
  c.Brush.Color:=tco[indexTCO,x,y].CouleurFond;
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  //PCanvasTCO.Brush.Style:=bsSolid;
  s:=tco[indextco,x,y].Texte;
  b:=tco[indextco,x,y].BImage;

  if not NB then
  begin
    if (b=id_Quai) then c.Brush.Color:=clQuai[indexTCO]
      else
        c.Brush.Color:=tco[indextco,x,y].CouleurFond;

    c.Font.Color:=tco[indextco,x,y].CoulFonte;
  end
  else
  begin
    PCanvasTCO[indextco].Brush.color:=clWhite;
    c.Font.color:=clBlack;
  end;

  nf:=tco[indextco,x,y].fonte;
  if nf='' then ss:='Arial';
  c.Font.Name:=nf;

  ss:=tco[indextco,x,y].FontStyle;
  c.Font.Style:=style(ss);

  repr:=tco[indextco,x,y].repr;

  xt:=round(5*frXGlob[indexTCO]);yt:=0;

  taillefont:=tco[indextco,x,y].TailleFonte;
  if taillefont=0 then taillefont:=8;
  tf:=(taillefont*LargeurCell[indexTCO]) div 40;
  c.font.Size:=tf;

  if b=id_action then c.Brush.Color:=couleurAction;

  if b=Id_cantonH then
  begin
    repr:=0;xt:=4;yt:=4;
    s:=format('%d',[TCO[indexTCO,x,y].Numcanton]);
  end
  else
  if b=Id_cantonV then
  begin
    repr:=0;xt:=2;yt:=4;
    s:=format('%d',[TCO[indexTCO,x,y].Numcanton]);
  end
  else
  if (b=id_action) and (tco[indexTCO,x,y].PiedSignal=AcBouton_bistable) then
  begin
    exit;
  end;

  case repr of
   0,1 : yt:=(hauteurCell[indexTCO] div 2)-(round(c.textHeight(s) div 2));   // au milieu Y
     2 : yt:=1;  // haut
     3 : yt:=hauteurCell[indexTCO]-round(c.textHeight(s));   // bas
     5 : begin  // double centré XY
           r.Left:=x0;
           r.Top:=y0+3;
           r.Right:=x0+largeurCell[indexTCO];
           r.bottom:=y0+hauteurCell[indexTCO];
           // centrage et positionnement:  DT_TOP or DT_CENTER or DT_VCENTER or DT_CENTER
           // césures de mots : DT_SINGLELINE   DT_WORDBREAK
           // ? : dt_noclip
           //DrawText(PcanvasTCO[indexTCO].Handle,PChar(s), -1, R,DT_VCENTER or DT_CENTER or DT_SINGLELINE );
           DrawText(PcanvasTCO[indexTCO].Handle,PChar(s), -1, R,DT_VCENTER or DT_CENTER or dt_wordbreak );

           exit;
         end;
  end;

  if b=Id_Quai then xt:=6;
  if (b<>Id_Quai) and (b<>Id_action) then s:=s+'   ';

  //c.pen.color:=clLime;c.Moveto(X0,y0);c.lineto(x0,y0+c.textHeight(s));

  if repr=4 then texte_reparti(s,indextco,x,y,c.font.size) else
    c.Textout(x0+xt,y0+yt,s);
  

  // texte encadré
  if tco[indextco,x,y].buttoir=1 then
  begin
    largCell:=LargeurCell[indexTCO];
    hautCell:=HauteurCell[indexTCO];

    with PCanvasTCO[indexTCO] do
    begin
      pen.width:=(epaisseur div 2);
      tf:=TextWidth(tco[indextco,x,y].Texte);

      tf:=(tf div largCell)*largCell+largCell;
      pen.color:=clWhite;
      moveTo(x0,y0);LineTo(x0+tf,y0);
      LineTo(x0+tf,y0+hautCell);
      LineTo(x0,y0+hautCell);
      LineTo(x0,y0);
    end;
  end;
end;

procedure dessin_2L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy2,xf,yf,position,jy1,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,yf);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  fond:=tco[indextco,x,y].CouleurFond;
  position:=positionTCO(indexTCO,x,y);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
        pen.width:=1;
        Polygon([point(x0+1,y0+hauteurCell[indexTCO]-epaisseur),Point(xc-(epaisseur div 2),jy1),Point(xc-epaisseur-epaisseur,jy1),Point(x0+1,y0+hauteurCell[indexTCO]-epaisseur-epaisseur)]);
     end;
     if affPosFil then
     begin
       pen.color:=fond;
       Brush.Color:=fond;
       pen.width:=epaisseur div 2;
       moveTo(xf,yc);LineTo(xc,yc);LineTo(x0,yf);
     end;
    end;

    if position=const_droit then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jy2:=yc+(Epaisseur div 2);   // pos Y de la bande inf
        r:=rect(x0+1,jy2+1,x0+LargeurCell[indexTCO]-1,jy2+epaisseur);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;

  end;
end;

// courbe
procedure dessin_2C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy2,xf,yf,position,x1,y1,x2,y2,x3,y3,x4,y4,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  fond:=tco[indextco,x,y].CouleurFond;
  position:=positionTCO(indexTCO,x,y);
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=xf-x0;
  x1:=x0-(x1 div 3);y1:=yc;
  x2:=xf+xf-x1;y2:=yf+hauteurCell[indexTCO]*2+(hauteurCell[indexTCO] div 2);
  x3:=xf;y3:=yc;
  x4:=x0;y4:=yf;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      // effacement du morceau
      if not(affPosFil) then
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        Polygon([
          point(x0+3,yf-epaisseur-5),
          Point(xc+2*epaisseur,yc-epaisseur),
          Point(xc-epaisseur,yc-epaisseur)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
      end;
    end;

    if position=const_droit then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jy2:=yc+(Epaisseur div 2);   // pos Y de la bande inf
        r:=rect(x0+1,jy2+1,x0+LargeurCell[indexTCO]-1,jy2+epaisseur);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;
  end;
end;

procedure dessin_2(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_2L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_2C(indexTCO,Canvas,x,y,Mode);
end;

procedure dessin_3L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy1,xf,yf,position,ep : integer;
    fond : Tcolor;
    r : Trect;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xf,y0);lineto(xc,yc);
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(x0,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  fond:=tco[indextco,x,y].CouleurFond;
  position:=positionTCO(indexTCO,x,y);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;
    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        pen.width:=1;
        Polygon([point(xc+epaisseur-4,yc+epaisseur-1),point(xc+2*epaisseur-1,yc-epaisseur),point(xc+3*epaisseur,yc-epaisseur),point(xc+2*epaisseur,yc+epaisseur-1)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xc,yc);LineTo(xf,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
        r:=rect(x0+1,jy1,x0+LargeurCell[indexTCO]-1,jy1-epaisseur);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;
  end;
end;

procedure dessin_3C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy1,xf,yf,position,x1,y1,x2,y2,x3,y3,x4,y4,ep : integer;
    fond : Tcolor;
    r : Trect;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
  x2:=xf+(LargeurCell[indexTCO] div 3)+3;y2:=yc;
  x3:=x0;y3:=yc;
  x4:=xf;y4:=y0;

  position:=positionTCO(indexTCO,x,y);
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        pen.width:=1;
        x1:=xc-2*epaisseur;y1:=yc+epaisseur-1;
        x2:=xc+2*epaisseur-2;y2:=yc-epaisseur;
        x3:=x2+epaisseur;y3:=y2;
        x4:=x1+epaisseur;y4:=y1;
        Polygon([point(x1,y1),
        point(x2,y2),
        point(x3,y3),
        point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
        //moveTo(x0,yc);LineTo(xc-round(4*FrxGlob[indexTCO]),yc);LineTo(xf,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
        r:=rect(x0+1,jy1,x0+LargeurCell[indexTCO]-1,jy1-epaisseur);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;
  end;
end;


procedure dessin_3(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_3L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_3C(indexTCO,Canvas,x,y,Mode);
end;

procedure dessin_4L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;
   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xf,yf);lineto(xc,yc);
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(x0,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  fond:=tco[indextco,x,y].CouleurFond;
  position:=positionTCO(indexTCO,x,y);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc+round(0.3*epaisseur);y1:=yc-(epaisseur div 2)-1;
        x2:=x1+epaisseur;y2:=y1;
        x3:=x2+epaisseur;y3:=y2+epaisseur;
        x4:=x1+epaisseur;y4:=y3;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xc,yc);LineTo(xf,yf);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        // efface le morceau
        x1:=xc-epaisseur-1;y1:=yc+(epaisseur div 2)+1;
        x2:=x1+25;y2:=y1+5;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;
  end;
end;

procedure dessin_4C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=yc;
  x2:=xf+(LargeurCell[indexTCO] div 3);y2:=yf+2*hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 2);
  x3:=xf;y3:=yf;
  x4:=x0;y4:=yc;

  position:=positionTCO(indexTCO,x,y);
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosfil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-12;y1:=yc-(epaisseur div 2)-1;
        x2:=x1+15;y2:=y1;
        x3:=x2+6;y3:=y2+8;
        x4:=x1+12;y4:=y3;
        Polygon([point(xc-round(2.1*epaisseur),yc-epaisseur-1),point(xc,yc-epaisseur-1),point(xc+3*epaisseur,yc+epaisseur),point(xc+round(2.0*epaisseur),yc+epaisseur)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(x0,yc);LineTo(xc-round(4*frxGlob[indexTCO]),yc);LineTo(xf,yf);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosfil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        // efface le morceau
        x1:=xc-3*epaisseur;y1:=yc+(epaisseur div 2)+1;
        x2:=xc+2*epaisseur+2;y2:=y1+5;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;
  end;
end;

procedure dessin_4(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_4L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_4C(indexTCO,Canvas,x,y,Mode);
end;

procedure dessin_5L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  fond:=tco[indextco,x,y].CouleurFond;
  position:=positionTCO(indexTCO,x,y);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-(epaisseur div 2);y1:=yc+(epaisseur div 2);
        x2:=x1-epaisseur;y2:=y1;
        x3:=x2-epaisseur;y3:=y2-epaisseur-1;
        x4:=x3+epaisseur;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,yc);LineTo(xc,yc);LineTo(x0,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-(epaisseur div 2)-10;y1:=yc-(epaisseur div 2);
        x2:=x1+20;y2:=y1-epaisseur;
        pen.color:=fond;
        Brush.Color:=fond;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,yc);LineTo(x0,yc);
      end;
    end;
  end;
end;

procedure dessin_5C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yc);lineto(xc,yc);    
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTCO,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2)+4;
  x2:=xf+LargeurCell[indexTCO]+(LargeurCell[indexTCO] div 3);y2:=yc;
  x3:=x0;y3:=y0;
  x4:=xf;y4:=yc;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc+2*epaisseur;y1:=yc+(epaisseur div 2);
        x2:=x1-3*epaisseur;y2:=y1;
        x3:=x2;y3:=y2-epaisseur-2;
        x4:=x3+epaisseur;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xf,yc);LineTo(xc+round(5*frxGlob[indexTCO]),yc);LineTo(x0,y0);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        // efface le morceau
        x1:=xc-(epaisseur div 2)-15;y1:=yc-(epaisseur div 2);
        x2:=xf;y2:=y1-epaisseur-2;
        pen.color:=fond;
        Brush.Color:=fond;
        r:=rect(x1,y1,x2,y2-1);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yc);LineTo(xf,yc);
      end;
    end;
  end;
end;


procedure dessin_5(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_5L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_5C(indexTCO,Canvas,x,y,Mode);
end;

// coin supérieur gauche (Element 6)
procedure dessin_6L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;

    case mode of
        0: couleur:=clVoies[indexTCO];
        1: couleur:=ClCanton[indexTCO];
        2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Pen.Width:=epaisseur;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;

    if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    moveto(x0,y0);lineto(xc,yc);
    if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    Lineto(x0+LargeurCell[indexTCO],yc);
  end;
end;

// coin supérieur gauche (Element 6)
procedure dessin_6C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
  x2:=xf+LargeurCell[indexTCO]+(LargeurCell[indexTCO] div 3);y2:=yc;
  x3:=x0;y3:=y0;
  x4:=xf;y4:=yc;
  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;

    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;

    if testbit(ep,0) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_6(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_6L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_6C(indexTCO,Canvas,x,y,Mode);
end;

// Element 7
procedure dessin_7L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;

    if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    moveto(x0,yc);lineto(xc,yc);
    if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    lineto(x0+LargeurCell[indexTCO],y0);

  end;
end;

procedure dessin_7C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  ep:=tco[indextco,x,y].epaisseurs;
  // mode rond
  x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
  x2:=xf+(LargeurCell[indexTCO] div 3)+3;y2:=yc;
  x3:=x0;y3:=yc;
  x4:=xf;y4:=y0;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,2) or testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_7(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_7L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_7C(indexTCO,Canvas,x,y,Mode);
end;

// courbe: droit vers bas  -\  Element 8
procedure dessin_8L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies[indexTCO];
        1: couleur:=ClCanton[indexTCO];
        2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    Pen.Mode:=pmCopy;
    pen.color:=Couleur;

    if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    moveto(x0,yc);lineto(xc,yc);
    if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    lineto(x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
  end;
end;

procedure dessin_8C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=yc;
  x2:=xf+(LargeurCell[indexTCO] div 3);y2:=yf+2*hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 2);
  x3:=xf;y3:=yf;
  x4:=x0;y4:=yc;
  ep:=tco[indextco,x,y].epaisseurs;


  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies[indexTCO];
        1: couleur:=ClCanton[indexTCO];
        2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    Pen.Mode:=pmCopy;
    pen.color:=Couleur;
    if testbit(ep,7) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_8(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_8L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_8C(indexTCO,Canvas,x,y,Mode);
end;

// courbe bas gauche vers droit  Elément 9
procedure dessin_9l(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies[indexTCO];
        1: couleur:=ClCanton[indexTCO];
        2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
   
    if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    MoveTo(x0,y0+hauteurCell[indexTCO]);lineto(xc,yc);
    if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    LineTo(x0+LargeurCell[indexTCO],yc);

  end;
end;


// courbe bas gauche vers droit  Elément 9
procedure dessin_9c(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
    // mode rond
  x1:=xf-x0;
  x1:=x0-(x1 div 3);y1:=yc;
  x2:=xf+xf-x1;y2:=yf+hauteurCell[indexTCO]*2+(hauteurCell[indexTCO] div 2);
  x3:=xf;y3:=yc;
  x4:=x0;y4:=yf;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies[indexTCO];
        1: couleur:=ClCanton[indexTCO];
        2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,6) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;

    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_9(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_9L(indexTCO,Canvas,x,y,Mode);
  if graphisme=2 then dessin_9C(indexTCO,Canvas,x,y,Mode);
end;

// élément 10
procedure dessin_10(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr,but,x0,y0,xc,yc,xf,yf,ep: integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  but:=tco[indextco,x,y].buttoir;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);


    if but<>0 then
    begin
      case mode of
        0 : couleur:=clVoies[indexTCO];
        1 : couleur:=clAllume[indexTCO];
        2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      pen.color:=couleur;
      if testbit(ep,2) or testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;

      if testBit(but,2) then
      begin
        moveTo(xf,y0);LineTo(xc,yc);
      end;
      if testBit(but,6) then
      begin
        moveTo(x0,yf);LineTo(xc,yc);
      end;

      Pen.Width:=epaisseur;
      pen.Color:=Clred;
      moveto(xc-round(5*frxGlob[indexTCO]),yc-round(5*fryGlob[indexTCO]));
      LineTo(xc+round(5*frxGlob[indexTCO]),yc+round(5*fryGlob[indexTCO]));
      exit;
    end;

    Adr:=tco[indextco,x,y].adresse;
    // détecteur
    if adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        brush.Color:=clAllume[indexTCO];
        pen.color:=clAllume[indexTCO];
      end
      else
      begin
        pen.color:=tco[indextco,x,y].CouleurFond;
        brush.color:=tco[indextco,x,y].CouleurFond;
      end;
      pen.Width:=epaisseur+3;
      MoveTo(x0+LargeurCell[indexTCO],y0);LineTo(x0,y0+hauteurCell[indexTCO]);
    end;

    // voie
    case mode of
    0 : couleur:=clVoies[indexTCO];
    1 : couleur:=clAllume[indexTCO];
    2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    pen.color:=couleur;

    if testbit(ep,6) or testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    MoveTo(x0+LargeurCell[indexTCO],y0);LineTo(x0,y0+hauteurCell[indexTCO]);
  end;
end;

// élément 11
procedure dessin_11(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0,xc,yc,xf,yf,ep,but : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  but:=tco[indextco,x,y].buttoir;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;

    if testbit(but,0) or testbit(but,4) then
    begin
      case mode of
        0 : couleur:=clVoies[indexTCO];
        1 : couleur:=clAllume[indexTCO];
        2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      pen.color:=couleur;
      if testbit(ep,0) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;

      if testBit(but,0) then
      begin
        moveTo(x0,y0);LineTo(xc,yc);
      end;
      if testBit(but,4) then
      begin
        moveTo(xf,yf);LineTo(xc,yc);
      end;

      Pen.Width:=epaisseur;
      pen.Color:=Clred;
      moveto(xc+round(5*frxGlob[indexTCO]),yc-round(5*fryGlob[indexTCO]));
      LineTo(xc-round(5*frxGlob[indexTCO]),yc+round(5*fryGlob[indexTCO]));
      exit;
    end;


    Adr:=tco[indextco,x,y].adresse;
   // détecteur
    if adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        brush.Color:=clAllume[indexTCO];
        pen.color:=clAllume[indexTCO];
      end
      else
      begin
        pen.color:=tco[indextco,x,y].CouleurFond;
        brush.color:=tco[indextco,x,y].CouleurFond;
      end;
      pen.Width:=epaisseur+3;
      MoveTo(x0,y0);LineTo(x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    end;

    // voie
    case mode of
    0 : couleur:=clVoies[indexTCO];
    1 : couleur:=clAllume[indexTCO];
    2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    pen.color:=couleur;

    if testbit(ep,0) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    MoveTo(x0,y0);LineTo(x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
  end;
end;


// Element 12
procedure dessin_12L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTCO,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_Devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;    // affiche la position de la branche déviée
      end;

      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else

    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affposfil then
      begin
      // effacement du morceau
        pen.width:=1;
        x1:=xc-epaisseur;y1:=yc+(epaisseur div 2)+1;
        x2:=x1+3*epaisseur;y2:=y1;
        x3:=x2;y3:=y2+epaisseur;
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);LineTo(xc,yc);LineTo(xf,yc);
      end;
    end;
    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc+(epaisseur div 2)-2;y1:=yc-(epaisseur div 2)-1;
        x2:=x1+epaisseur;y2:=y1;
        x3:=x2+epaisseur+2;y3:=y2+epaisseur+2;
        x4:=x3-epaisseur;y4:=y3;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);LineTo(xf,yf);
      end;
    end;  
  end;
end;

procedure dessin_12C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : tcolor;
   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  ep:=tco[indextco,x,y].epaisseurs;
  // mode rond
  x1:=x0-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
  x2:=xf+LargeurCell[indexTCO]+(LargeurCell[indexTCO] div 3);y2:=yc;
  x3:=x0;y3:=y0;
  x4:=xf;y4:=yc;

  position:=positionTCO(indexTCO,x,y);
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end
    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affPosFil then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-2*epaisseur;y1:=yc-(epaisseur);
        x2:=xc+2*epaisseur;y2:=yc+2;
        x3:=x2;y3:=yc+(epaisseur div 2)+epaisseur;
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(x0,y0);LineTo(xc-round(4*FrxGlob[indexTCO]),yc-round(6*FryGlob[indexTCO]));LineTo(xf,yc);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        x1:=xc-epaisseur-1;y1:=yc-(2*epaisseur)-1;
        x2:=x1+epaisseur;y2:=y1;
        x3:=x2+2*epaisseur+5;y3:=y2+3*epaisseur;
        x4:=x3-epaisseur;y4:=y3;
        pen.Width:=1;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);LineTo(xf,yf);
      end;
    end;
  end;
end;


procedure dessin_12(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_12L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_12C(indexTco,Canvas,x,y,Mode);
end;


// Elément 13
procedure dessin_13L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yf);lineto(xc,yc);    
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,yf);lineto(xc,yc);  
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(x0,yc);
     end;
   end;
   
begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_Devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;

      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affposFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-2*epaisseur-5;y1:=yc+(epaisseur div 2)+1;
        x2:=xc+epaisseur+10;y2:=y1+epaisseur;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,y0);LineTo(xc,yc);LineTo(x0,yc);
      end;
    end;
    if position=const_droit then
    begin
      if not affPosFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-round(0.4*epaisseur);y1:=yc-(epaisseur div 2);
        x2:=x1-epaisseur;
        x3:=x2-epaisseur;y3:=yc+(epaisseur div 2)+1;
        x4:=x1-epaisseur-1;
        polygon([point(x1,y1),point(x2,y1),point(x3,y3),point(x4,y3)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,y0);LineTo(x0,yf);
      end;
    end;
  end;
end;

procedure dessin_13C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(xf,y0);lineto(xc,yc);
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(x0,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
  x2:=xf+(LargeurCell[indexTCO] div 3)+3;y2:=yc;
  x3:=x0;y3:=yc;
  x4:=xf;y4:=y0;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;


    if (position=const_Devie) then
    begin
      if not affPosFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc+(epaisseur)+3;y1:=yc-(epaisseur);
        x2:=xc+2*epaisseur+3;y2:=y1;
        x3:=xc;y3:=yc+epaisseur;
        x4:=xc-(3*epaisseur);y4:=y3;
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xf,y0);LineTo(xc+round(6*FrxGlob[indexTCO]),yc-round(6*FryGlob[indexTCO]));LineTo(x0,yc);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not affposFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-(epaisseur div 2);y1:=yc-(2*epaisseur);
        x2:=xc+epaisseur;
        x3:=xc-epaisseur-2;y3:=yc+(epaisseur div 2)+1;
        x4:=xc-2*epaisseur;y4:=y3;
        polygon([point(x1,y1),point(x2,y1),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,y0);LineTo(x0,yf);
      end;
    end;
  end;
end;

procedure dessin_13(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_13L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_13C(indexTco,Canvas,x,y,Mode);
end;

// Element 14
procedure dessin_14l(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(x0,yc);lineto(xc,yc);    // partie droite
     end;
   end;

 
begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

   if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(affposfil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-2*epaisseur-5;y1:=yc-(epaisseur div 2);
        x2:=x1+3*epaisseur;y2:=y1-epaisseur;
        pen.color:=fond;
        Brush.Color:=fond;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xf,yf);LineTo(xc,yc);lineto(x0,yc);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(affposfil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-epaisseur-3;y1:=yc-(epaisseur div 2)-1;
        x2:=x1-epaisseur;y2:=y1;
        x3:=x2+epaisseur+2;y3:=y2+epaisseur+2;
        x4:=x3+epaisseur;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,yf);lineto(x0,y0);
      end;
    end;  
  end;
end;

procedure dessin_14c(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,y0);lineto(xf,yf);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=yc;
  x2:=xf+(LargeurCell[indexTCO] div 3);y2:=yf+2*hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 2);
  x3:=xf;y3:=yf;
  x4:=x0;y4:=yc;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;


    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-epaisseur-2;y1:=yc-(epaisseur div 2);
        x2:=xc+epaisseur;y2:=y1;
        x3:=xc+3*epaisseur+3;y3:=yc+2*epaisseur;
        x4:=xc+2*epaisseur+4;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        r:=rect(x1,y1,x2,y2);
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xf,yf);LineTo(xc,yc+round(4*fryGlob[indexTCO]));lineto(x0,yc);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-(2*epaisseur)+3;y1:=yc-(epaisseur div 2)-1;
        x2:=xc-(3*epaisseur)+4;y2:=y1;
        x3:=xc;y3:=yc+2*epaisseur;
        x4:=xc+epaisseur;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,yf);lineto(x0,y0);
      end;
    end;
  end;
end;

procedure dessin_14(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_14L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_14C(indexTco,Canvas,x,y,Mode);
end;

// Element 15
procedure dessin_15L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,position,ep : integer;
    fond : Tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yf);lineto(xc,yc);
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,yf);lineto(xc,yc);
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yc);    // partie droite
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-epaisseur;y1:=yc-(epaisseur div 2)-1;
        x2:=xc+epaisseur+10;y2:=yc-epaisseur-3;
        polygon([point(x1,y1),point(x2,y1),point(x2,y2),point(x1,y2)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yf);LineTo(xc,yc);LineTo(xf,yc);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        x1:=xc+(epaisseur div 2);y1:=yc+(epaisseur div 2);
        x2:=x1+epaisseur-1;y2:=yc-(epaisseur div 2);
        x3:=x1+10;
        polygon([point(x1,y1),point(x2,y2),point(x3,y2),point(x3,y1)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yf);LineTo(xf,y0);
      end;
    end;
  end;
end;

procedure dessin_15C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : Tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yf);lineto(xc,yc);
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=xf-x0;
  x1:=x0-(x1 div 3);y1:=yc;
  x2:=xf+xf-x1;y2:=yf+hauteurCell[indexTCO]*2+(hauteurCell[indexTCO] div 2);
  x3:=xf;y3:=yc;
  x4:=x0;y4:=yf;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;
  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-epaisseur;y1:=yc-(epaisseur div 2)-1;
        x2:=xc+epaisseur+10;y2:=y1;
        x3:=xc-epaisseur-5;y3:=yc+epaisseur;
        x4:=xc-2*epaisseur;y4:=y3;
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(x0,yf);LineTo(xc,yc+round(4*fryGlob[indexTCO]));LineTo(xf,yc);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        x1:=xc+(epaisseur)+epaisseur-1;y1:=yc-(epaisseur);
        x2:=x1+2*epaisseur;y2:=y1;
        x3:=xc+(epaisseur);y3:=yc+(2*epaisseur);
        x4:=xc-epaisseur-1;y4:=y3;
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yf);LineTo(xf,y0);
      end;
    end;
  end;
end;

procedure dessin_15(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_15L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_15C(indexTco,Canvas,x,y,Mode);
end;


// Element 16
procedure dessin_16L(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

     case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,0) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur ;
    MoveTo(x0,y0);lineTo(xc,yc);LineTo(xc,y0+hauteurCell[indexTCO]);
  end;
end;

procedure dessin_16C(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
  x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
  x3:=xc;y3:=yf;
  x4:=x0;y4:=y0;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,0) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;


procedure dessin_16(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_16L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_16C(indexTco,Canvas,x,y,Mode);
end;


// Element 17
procedure dessin_17l(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,2) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    MoveTo(x0+LargeurCell[indexTCO],y0);LineTo(xc,yc);LineTo(xc,y0+hauteurCell[indexTCO]);
  end;
end;

// Element 17
procedure dessin_17c(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
  x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
  x3:=xf;y3:=y0;
  x4:=xc;y4:=yf;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,2) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_17(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_17L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_17C(indexTco,Canvas,x,y,Mode);
end;

// Elément 18
procedure dessin_18l(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,1) or testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    MoveTo(x0,y0+hauteurCell[indexTCO]);LineTo(xc,yc);LineTo(xc,y0);
  end;
end;

procedure dessin_18c(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
  x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+round(hauteurCell[indexTCO] / 2.5);
  x3:=x0;y3:=yf;
  x4:=xc;y4:=y0;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=clfond[indexTCO];
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,1) or testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_18(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_18L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_18C(indexTco,Canvas,x,y,Mode);
end;

// Element 19
procedure dessin_19l(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,1) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    moveto(xc,y0);LineTo(xc,yc);LineTo(x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
  end;
end;

procedure dessin_19c(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf,ep : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
  x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+round(hauteurCell[indexTCO] / 3);
  x3:=xc;y3:=y0;
  x4:=xf;y4:=yf;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Width:=1;

    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    if testbit(ep,1) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_19(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_19L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_19C(indexTco,Canvas,x,y,Mode);
end;

// Element 20
procedure dessin_20(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var jx1,jx2,x0,y0,xc,xf,yf,yc,adr,ep,but : integer;
    r : Trect;
    couleur : tcolor;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  but:=tco[indextco,x,y].buttoir;

  with canvas do
  begin
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    Pen.Mode:=pmCopy;

    if but<>0 then
    begin
      case mode of
        0 : couleur:=clVoies[indexTCO];
        1 : couleur:=clAllume[indexTCO];
        2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      pen.color:=couleur;
      if testbit(ep,1) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;

      if testBit(but,1) then
      begin
        moveTo(xc,y0);LineTo(xc,yc);
      end;
      if testBit(but,5) then
      begin
        moveTo(xc,yc);LineTo(xc,yf);
      end;

      Pen.Width:=epaisseur;
      pen.Color:=Clred;
      moveto(x0+round(20*fryGlob[indexTCO]),yc);
      LineTo(xf-round(20*fryGlob[indexTCO]),yc);
      exit;
    end;

    // état détecteur
    Adr:=tco[indextco,x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume[indexTCO];
        pen.color:=clAllume[indexTCO];
      end
      else
      begin
        couleur:=tco[indextco,x,y].CouleurFond;
        Brush.Color:=couleur;
        pen.color:=couleur;
      end;
      jx1:=x0+(LargeurCell[indexTCO] div 2)-round(7*frxGlob[indexTCO]); // pos Y de la bande sup
      jx2:=x0+(LargeurCell[indexTCO] div 2)+round(7*frxGlob[indexTCO]); // pos Y de la bande inf
      if avecGrille[indexTCO] then r:=Rect(jx1,y0+1,jx2,y0+hauteurCell[indexTCO]-1) else
      r:=Rect(jx1,y0,jx2,y0+hauteurCell[indexTCO]) ;
      FillRect(r);
    end;

    // voie
    case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;

    if testbit(ep,1) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
    MoveTo(xc,y0);LineTo(xc,y0+hauteurCell[indexTCO]);
  end;
end;

// Element 21 - croisement - TJD
procedure dessin_21(indexTCO : integer;Canvas : Tcanvas;x,y,mode : integer);
var yp,x1,x2,y1,y2,x3,y3,x4,y4,x0,y0,xc,yc,xf,yf,trajet,ep,pont,adr1,adr2,
    index1,index2,etatTJD,position1,position2,sHG,sBD : integer;
    a1,b1,a2,b2 : single;
    md,tHG,tBD : tequipement;
    fond : tcolor;
  procedure horizontale;
  begin
    with canvas do
    begin
      if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(x0,yc);LineTo(xc,yc);
      if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xf,yc);
    end;
  end;

  procedure diagonale;
  begin
    with canvas do
    begin
      if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(x0,yf);LineTo(xc,yc);
      if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xf,y0);
    end;
  end;

  procedure TjdHaut(dessin : integer);
  begin
    x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
    x2:=xf+(LargeurCell[indexTCO] div 3)+3;y2:=yc;
    x3:=x0;y3:=yc;
    x4:=xf;y4:=y0;

    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,2) or testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  // si dessin=1 dessine en épaisseur de voie
  // si dessin=2 dessine en épaisseur de trajet
  procedure TjdBas(dessin : integer);
  begin
    x1:=xf-x0;
    x1:=x0-(x1 div 3);y1:=yc;
    x2:=xf+xf-x1;y2:=yf+hauteurCell[indexTCO]*2+(hauteurCell[indexTCO] div 2);
    x3:=xf;y3:=yc;
    x4:=x0;y4:=yf;

    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,6) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else pen.width:=epaisseur div 2;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  fond:=tco[indextco,x,y].CouleurFond;
  pont:=tco[indextco,x,y].pont;
  md:=aiguillage[index_aig(tco[indextco,x,y].Adresse)].modele;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=clvoies[indexTCO];
    pen.color:=clvoies[indexTCO];

    horizontale;
    diagonale;

    if (md=tjd) or (md=tjs) then
    begin
      tjdbas(1);
      tjdhaut(1);
    end;

    // horizontale
    if testbit(pont,3) or testbit(pont,7) then
    begin
      // dessiner le pont
      pen.color:=clfond[indexTCO];
      yp:=yc-(epaisseur);
      moveto(x0+5,yp);lineTo(xf-5,yp);
      yp:=yc+(epaisseur);
      moveto(x0+5,yp);lineTo(xf-5,yp);

      // barrières du pont
      pen.color:=clBarriere[indexTCO];
      pen.Width:=epaisseur div 2;
      moveto(x0+5,yp);lineTo(xf-5,yp);
      yp:=yc-(epaisseur);
      moveto(x0+5,yp);lineTo(xf-5,yp);
    end;

    // diagonale
    if testbit(pont,2) or testbit(pont,6) then
    begin
      pen.color:=clfond[indexTCO];
      droite(xf,y0,x0,yf,a1,b1);
      // droite a2,b2 // passant par x2,y2
      a2:=a1;

      // masquage sup
      x2:=xf-round(24*frxGlob[indexTCO]);y2:=y0+round(12*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(6*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // barrière sup
      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      x2:=xf-round(24*frxGlob[indexTCO]);y2:=y0+round(12*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(6*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // masquage inf
      pen.Width:=epaisseur;
      pen.color:=clFond[indexTCO];
      x2:=xf-round(7*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(16*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // barrière inf
      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      //x2:=xf-round(10*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      x2:=xf-round(7*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(22*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);
    end;

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[indextco,x,y].trajet;
      case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then horizontale; // horizontale
      if trajet=2 then diagonale;  // diagonale
      if trajet=3 then // SO C E   /-
      begin
       { if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(x0,yf);LineTo(xc,yc);
        if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,yc);}
        tjdbas(1);
      end;
      if trajet=4 then // -/  O C NE
      begin
        {if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(x0,yc);LineTo(xc,yc);
        if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,y0);}
        tjdhaut(1);
      end;
    end;
  end;

  // dessin position de la tjd
  adr1:=tco[indexTCO,x,y].Adresse;
  Index1:=Index_aig(adr1);
  md:=aiguillage[Index1].modele;
  if (md=tjd) or (md=tjs) then
  begin
    EtatTJD:=aiguillage[index1].EtatTJD;   // nombre d'états de la tjd (2 ou 4)
    position1:=aiguillage[index1].position;
    sHG:=TCO[indexTCO,x,y].suivHG;tHG:=TCO[indexTCO,x,y].typHG;
    sBD:=TCO[indexTCO,x,y].suivBD;tBD:=TCO[indexTCO,x,y].typBD;
    canvas.pen.color:=clfond[indexTCO];
    canvas.pen.Width:=epaisseur div 2;
    if etatTJD=4 then
    begin
      adr2:=aiguillage[index1].DDevie;  // homologue
      Index2:=Index_aig(adr2);
      position2:=aiguillage[index2].position;

      if (position1=const_devie) and (position2=const_devie) then
      begin
        with canvas do begin
          moveTo(x0,yf);LineTo(xf,y0);
        end;
      end;

      if (position1=const_droit) and (position2=const_droit) then
      begin
        with canvas do begin
          moveTo(x0,yc);LineTo(xf,yc);
        end;
      end;

      if (position1=const_droit) and (position2=const_devie) then
      begin
        if tco[indexTCO,x,y].tjdE=adr1 then
        with canvas do begin
          //moveTo(x0,yc);LineTo(xc,yc);Lineto(xf,y0);
          tjdhaut(2);
        end;
        if tco[indexTCO,x,y].tjdE=adr2 then
        with canvas do begin
          //moveTo(x0,yf);LineTo(xc,yc);Lineto(xf,yc);
          tjdbas(2);
        end;
      end;

      if (position1=const_devie) and (position2=const_droit) then
      begin
        if tco[indexTCO,x,y].tjdE=adr1 then
        with canvas do begin
          //moveTo(x0,yf);LineTo(xc,yc);Lineto(xf,yc);
          tjdbas(2);
        end;
        if tco[indexTCO,x,y].tjdE=adr2 then
        with canvas do begin
          //moveTo(x0,yc);LineTo(xc,yc);Lineto(xf,y0);
          tjdhaut(2);
        end;
      end;
    end;
   
    if etatTJD=2 then
    begin
      if position1=const_droit then
      with canvas do
      begin
        moveTo(x0,yf);LineTo(xf,y0);
        moveTo(x0,yc);LineTo(xf,yc);
      end;
      if position1=const_devie then
      with canvas do
      begin                                                              
        // donne l'équation de droite y=ax+b passant par les points (x1,y1) (x2,y2)
        droite(xc,yc,xf,y0,a1,b1);
        //haut
        moveTo(x0,yc); LineTo(xc-epaisseur,yc);
        LineTo(xc+epaisseur,round((xc+epaisseur)*a1+b1) ); LineTo(xf,y0);
        //bas
        moveTo(x0,yf);
        LineTo(xc-epaisseur,round((xc-epaisseur)*a1+b1) );
        lineTo(xc+epaisseur,yc);
        LineTo(xf,yc);
      end;  
    end;
  end;
end;

// Element 22
procedure dessin_22(indexTCO : integer;Canvas : Tcanvas;x,y,mode : integer);
var pont,yp,x1,y1,x2,y2,x3,y3,x4,y4,x0,y0,xc,yc,xf,yf,trajet,ep,position1,position2,
    adr1,adr2,index1,index2,etatTJD,sHG,sBD : integer;
    md,tHG,tBD : tequipement;
    a1,b1,a2,b2 : single;
    fond : Tcolor;
 procedure horizontale;
  begin
    with canvas do
    begin
      if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(x0,yc);LineTo(xc,yc);
      if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xf,yc);
    end;
  end;

  procedure diagonale;
  begin
    with canvas do
    begin
      if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(x0,y0);LineTo(xc,yc);
      if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xf,yf);
    end;
  end;

  procedure TJDbas(dessin :integer); // morceau courbe bas
  begin
    x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=yc;
    x2:=xf+(LargeurCell[indexTCO] div 3);y2:=yf+2*hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 2);
    x3:=xf;y3:=yf;
    x4:=x0;y4:=yc;
    ep:=tco[indextco,x,y].epaisseurs;
    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,7) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure TJDHaut(dessin :integer);  // morceau courbe haut
  begin
    x1:=x0-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
    x2:=xf+LargeurCell[indexTCO]+(LargeurCell[indexTCO] div 3);y2:=yc;
    x3:=x0;y3:=y0;
    x4:=xf;y4:=yc;
    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,0) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  pont:=tco[indextco,x,y].pont;
  fond:=tco[indextco,x,y].CouleurFond;
  md:=aiguillage[index_aig(tco[indextco,x,y].Adresse)].modele;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    Brush.Color:=clvoies[indexTCO];
    pen.color:=clvoies[indexTCO];
    pen.width:=epaisseur;

    diagonale;
    horizontale;

    if (md=tjd) or (md=tjs) then
    begin
      TJDbas(1);
      TJDHaut(1);
    end;

    // horizontale
    if testbit(pont,3) or testbit(pont,7) then
    begin
      // dessiner le pont
      pen.color:=clFond[indexTCO];
      yp:=yc-(epaisseur);
      moveto(x0+5,yp);lineTo(xf-5,yp);
      yp:=yc+(epaisseur);
      moveto(x0+5,yp);lineTo(xf-5,yp);

      // barrières du pont
      pen.color:=clBarriere[indexTCO];
      pen.Width:=epaisseur div 2;
      moveto(x0+5,yp);lineTo(xf-5,yp);
      yp:=yc-(epaisseur);
      moveto(x0+5,yp);lineTo(xf-5,yp);
    end;

    // diagonale
    if testbit(pont,0) or testbit(pont,4) then
    begin
      pen.color:=clfond[indexTCO];
      droite(x0,y0,xf,yf,a1,b1);
      // droite a2,b2 // passant par x2,y2
      a2:=a1;

      // masquage G
      x2:=x0+round(8*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(18*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // barrière
      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      x2:=x0+round(8*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(18*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // masquage D
      pen.Width:=epaisseur;
      pen.color:=clfond[indexTCO];
      x2:=x0+round(20*frxGlob[indexTCO]);y2:=y0+round(11*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(8*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      pen.width:=epaisseur div 2;
      pen.color:=clwhite;
      x2:=x0+round(20*frxGlob[indexTCO]);y2:=y0+round(11*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(8*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);
    end;

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[indextco,x,y].trajet;
      case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then horizontale;
      if trajet=2 then diagonale;
      if trajet=3 then // NO centre E  \-
      begin
        tjdhaut(1);
      end;
      if trajet=4 then // O C SE  -\
      begin
        tjdbas(1);
      end;
    end;
  end;

  // position de la tjd
  adr1:=tco[indexTCO,x,y].Adresse;
  Index1:=Index_aig(adr1);
  if (md=tjd) or (md=tjs) then
  begin
    EtatTJD:=aiguillage[index1].EtatTJD;   // nombre d'états de la tjd (2 ou 4)
    position1:=aiguillage[index1].position;
    sHG:=TCO[indexTCO,x,y].suivHG;tHG:=TCO[indexTCO,x,y].typHG;
    sBD:=TCO[indexTCO,x,y].suivBD;tBD:=TCO[indexTCO,x,y].typBD;
    canvas.pen.color:=clfond[indexTCO];
    canvas.pen.Width:=epaisseur div 2;
    if etatTJD=4 then
    begin
      adr2:=aiguillage[index1].DDevie;  // homologue
      Index2:=Index_aig(adr2);
      position2:=aiguillage[index2].position;

      if (position1=const_devie) and (position2=const_devie) then
      begin
        with canvas do begin
          moveTo(x0,yc);LineTo(xf,yc);
        end;
      end;

      if (position1=const_droit) and (position2=const_droit) then
      begin
        with canvas do begin
          moveTo(x0,y0);LineTo(xf,yf);
        end;
      end;

      if (position1=const_droit) and (position2=const_devie) then
      begin
        if tco[indexTCO,x,y].tjdE=adr1 then
        {with canvas do
        begin
          moveTo(x0,y0);LineTo(xc,yc);Lineto(xf,yc);
        end;}
        tjdhaut(2);
        if tco[indexTCO,x,y].tjdE=adr2 then
        tjdbas(2);
        {with canvas do
        begin
          moveTo(x0,yc);LineTo(xc,yc);Lineto(xf,yf);
        end;}
      end;

      if (position1=const_devie) and (position2=const_droit) then
      begin
        if tco[indexTCO,x,y].tjdE=adr1 then
        {with canvas do begin
          moveTo(x0,yc);LineTo(xc,yc);Lineto(xf,yf);
        end;}
        tjdbas(2);
        if tco[indexTCO,x,y].tjdE=adr2 then
        {with canvas do begin
          moveTo(x0,y0);LineTo(xc,yc);Lineto(xf,yc);
         end;}
        tjdhaut(2);
      end;
    end;

    if etatTJD=2 then
    begin
      if position1=const_droit then
      with canvas do
      begin
        moveTo(x0,y0);LineTo(xf,yf);
        moveTo(x0,yc);LineTo(xf,yc);
      end;
      if position1=const_devie then
      with canvas do
      begin                                                              
        // donne l'équation de droite y=ax+b passant par les points (x1,y1) (x2,y2)
        droite(x0,y0,xc,yc,a1,b1);
        moveTo(x0,y0);LineTo(xc-epaisseur,round((xc-epaisseur)*a1+b1) ); LineTo(xc+epaisseur,yc); LineTo(xf,yc);

        moveTo(x0,yc);lineTo(xc-epaisseur,yc);
        LineTo(xc+epaisseur,round((xc+epaisseur)*a1+b1) );
        LineTo(xf,yf);
      end;  
    end;
  end;
 
end;

// Element 51 (quai)
procedure dessin_Quai(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,x2,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    Brush.Color:=clQuai[indexTCO];
    pen.color:=clQuai[indexTCO];
    x1:=x0;
    x2:=x0+LargeurCell[indexTCO];

    jy1:=y0+(hauteurCell[indexTCO] div 2)-round(14*fryGlob[indexTCO]); // pos Y de la bande sup
    jy2:=y0+(hauteurCell[indexTCO] div 2)+round(14*fryGlob[indexTCO]); // pos Y de la bande inf
    r:=rect(x1,jy1,x2,jy2);
    rectangle(r);
  end;
end;

// action
procedure dessin_Action(indexTCO : integer;Canvas : Tcanvas;x,y : integer);
var adresse,x0,y0,xf,yf,act,larg,haut,etat : integer;
    r : Trect;
    s : string;
begin
  if PcanvasTCO[indexTCO]=nil then exit;

  larg:=LargeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];

  x0:=(x-1)*Larg;
  y0:=(y-1)*haut;
  xf:=x0+Larg;
  yf:=y0+Haut;


  with canvas do
  begin
    Pen.Width:=1;

    Brush.Color:=couleurAction;
    pen.color:=clwhite;

    r:=rect(x0,y0,xf,yf);
    rectangle(r);

    s:=tco[indexTCO,x,y].Fonte;
    if s='' then tco[indexTCO,x,y].Fonte:='Arial';
    //s:=tco[indexTCO,x,y].texte;
    s:='';
    if s='' then tco[indexTCO,x,y].repr:=5; // centré en X et Y
    act:=tco[indexTCO,x,y].PiedSignal;
    case act of
    AcChangeTCO :
    begin
      if s='' then s:='TCO'+format('%d',[TCO[indexTCO,x,y].FeuOriente]);  // feuoriente contient le numéro du TCO
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;
    AcAffSC :
    begin
      if s='' then s:='SC';
        tco[indexTCO,x,y].texte:=s;
        tco[indexTCO,x,y].TailleFonte:=8;
        tco[indexTCO,x,y].FontStyle:='G';
        tco[indextco,x,y].repr:=5;
    end;
    AcAffCDM :
    begin
      if s='' then s:='CDM';
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
      tco[indextco,x,y].repr:=5; // centré
    end;
    AcActSortie :
    begin
      if s='' then s:=intToSTR(tco[indexTCO,x,y].adresse);
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;
    AcStopTrains :
    begin
      if s='' then s:='STOP';
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;

    AcMarche_Horloge :
    begin
      if s='' then s:='MA'+#13+'horl';
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;

    AcArret_Horloge :
    begin
      if s='' then s:='AR'+#13+'horl';
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;

    AcInit_Horloge :
    begin
      if s='' then s:='Init'+#13+'horl';
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;

    AcAff_horloge :
    begin
      if s='' then s:='Aff'+#13+'horl';
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
    end;

    AcBouton_bistable :
    begin
      adresse:=tco[indexTCO,x,y].Adresse;
      if adresse<>0 then
      begin
        etat:=boutonTCO[adresse].etat;
        s:=intToSTR(adresse);
      end
      else
      begin
        etat:=0;
        s:='?';
      end;
      tco[indexTCO,x,y].texte:=s;
      tco[indexTCO,x,y].TailleFonte:=8;
      tco[indexTCO,x,y].FontStyle:='G';
      if etat=0 then
           StretchBlt(Canvas.Handle,x0,y0,larg,haut,
                   FormTCO[indexTCO].ImageBt0Bistable.canvas.Handle,0,0,48,48,srccopy)
                   //FormTCO[indexTCO].Image1.canvas.Handle,0,0,48,48,srccopy)
          else
          StretchBlt(Canvas.Handle,x0,y0,larg,haut,
                     FormTCO[indexTCO].ImageBt1Bistable.canvas.Handle,0,0,48,48,srccopy);


      canvas.Brush.color:=$c1c1c1; // couleur de fond du bouton
      canvas.Font.color:=clBlack;
      canvas.font.Style:=[];
      Canvas.textOut(x0+3,y0+3,s);
      //tco[indextco,x,y].repr:=2;
      //PImageTCO[indexTCO].Picture.Bitmap.Canvas.Brush.Color:=clred; //$c3c3c3;
      //PImageTCO[indexTCO].Picture.Bitmap.Canvas.pen.Color:=clred;
      //pen.Color:=clBlue;
      //font.Color:=clGreen;
      //canvas.Brush.Style := bsClear;
      //SetBkMode(PImageTCO[indexTCO].Picture.Bitmap.Canvas.Handle, Transparent);
      //PImageTCO[indexTCO].Picture.Bitmap.Canvas.textOut(x0+3,y0+3,s);
      //exit;
    end;
    end;
    //affiche_texte(indextco,x,y);
  end;
end;


procedure dessin_icone_canton(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,yc1,yc2,xf,yf,larg,haut : integer;
    s : string;
begin
  if PcanvasTCO[indexTCO]=nil then exit;

  larg:=LargeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];

  x0:=(x-1)*Larg;
  y0:=(y-1)*haut;
  xf:=x0+larg;
  yf:=y0+Haut;
  yc1:=y0+(haut div 4);
  yc2:=yf-(haut div 4);

  with canvas do
  begin
    Pen.Width:=1;

    Brush.Color:=CoulCantonLibre[indexTCO];
    pen.color:=clwhite;

    Roundrect(x0,yc1,xf,yc2,(xf-x0) div 2,(yc2-yc1) div 2);

    s:=tco[indexTCO,x,y].Fonte;
    if s='' then tco[indexTCO,x,y].Fonte:='Arial';
  end;
end;

procedure Affiche_temps_arret(IdTrain,tps : integer);
var larg,haut,IdC,x,y,n,x0,y0,IndexTCO,xRond,yRond,etat : integer;
    Horz : boolean;
    cf : Tcolor;
begin
  IdC:=index_canton_numero(Trains[idTrain].canton);
  //Affiche(intToSTR(canton[idc].numero),clYellow);
  if idc=0 then exit;
  indexTCO:=canton[Idc].Ntco;
  if indexTCO=0 then exit;
  etat:=canton[Idc].bouton;
  if etat>=3 then exit;
  larg:=LargeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];
  x:=canton[Idc].x;
  y:=canton[Idc].y;
  x0:=(x-1)*Larg;
  y0:=(y-1)*haut;
  n:=canton[Idc].Nelements;
  horz:=canton[Idc].horizontal;
  if horz then
  begin
    XRond:=x0+(n*Larg)-larg;
    Xrond:=xrond+round(20*frXGlob[IndexTCO]);
    Yrond:=y0+(Haut div 2)-round(10*fryGlob[indexTCO]);
  end
  else
  begin
    XRond:=x0+(Larg div 2)-5;
    YRond:=y0+(n*Haut)-haut;
  end;

  case etat of
   0 : cf:=ClYellow;
   1 : cf:=ClCyan;
   2 : cf:=ClLime;
  end;

  with PcanvasTCO[IndexTCO] do
  begin
    Brush.color:=cf;
    Font.Color:=clBlue;
    {$IF CompilerVersion >= 28.0}
    font.orientation:=0;
    {$IFEND}
    if tps=0 then TextOut(xRond,yRond,'  ') else
    TextOut(xRond,yRond,format('%d',[tps div 10])+' ');
  end;
end;


// dessine le canton H
// mode=0 canton normal  mode=1 : affiche le canton en mode rectangle de sélection avec les poignées
//       =3  drapeau vert  =4 drapeau rouge
procedure dessin_cantonH(indexTCO : integer;Canvas : Tcanvas;x,y,mode : integer);
var i,xi,yi,x0,y0,yf,yc,xt,yt,dx,dy,larg,haut,xr,xm,LargDest,Hautdest,indexTrain,NumC,sens,
    offsetY,xf,AdrTrain,Xcentre,yCentre,n,al,r,l,h,HautDestF,LargDestF,LargSrc,HautSrc,OffsetX,
    bouton : integer;
    frX,frY,rd : single;
    coul : tcolor;
    p : array[0..2] of TPoint;
    s : string;
begin
  if PcanvasTCO[indexTCO]=nil then exit;
  //Affiche('CANTONH '+intToSTR(x)+' '+intToSTR(y),clred);
  larg:=LargeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];
  n:=tco[indexTCO,x,y].FeuOriente; // nombre de cellules du canton

  x0:=(x-1)*Larg;
  y0:=(y-1)*haut;
  yc:=y0+(haut div 2);  // y centre
  xf:=x0+n*larg+1;
  yf:=y0+Haut+1;   // +1 pour les jonctions verticales etre 2 cantons

  with canvas do
  begin
    Pen.Width:=1;
  //  brush.Color:=tco[indexTCO,x,y].CouleurFond;
    s:=tco[indexTCO,x,y].Fonte;
    if s='' then tco[indexTCO,x,y].Fonte:='Arial';

    NumC:=TCO[indexTCO,x,y].NumCanton; // numéro du canton, pas son index;
    i:=index_canton_numero(NumC);    // index du canton "piedfeu"
    if i=0 then begin
      Affiche('Erreur 19H : index canton nul en TCO'+intToSTR(indexTCO)+' x='+intToSTR(x)+' y='+intToSTR(y),clred);exit;end;

    indexTrain:=TCO[IndexTCO,x,y].train;
    if (indexTrain<0) or (indexTrain>NTrains) then
    begin
      Affiche('Anomalie 670',clred);
      exit;
    end;
    AdrTrain:=canton[i].adresseTrain;
    //Affiche('Canton '+intToSTR(canton[i].numero)+' adrTrain='+intToSTR(AdrTrain),clLime);

    if AdrTrain<>0 then indexTrain:=index_train_adresse(adrTrain);

    if (AdrTrain<>0) or (indexTrain=9999) then coul:=CoulCantonOccupe[indexTCO]      // couleurCanton
      else coul:=CoulCantonLibre[indexTCO];
    Brush.Color:=coul;

    // mode=1 : représenter avec les poignées de sélection
    if mode=1 then
    begin
      pen.Mode:=PmXor;
      pen.Color:=ClWhite;
      // init grand rectangle
      with canton[i] do
      begin
        gd.Left:=x0;
        gd.Top:=y0;
        gd.Right:=x0+n*larg;
        gd.Bottom:=y0+haut;
      end;

      Init_rectangle_canton(indexTCO,i);
      Affiche_Rectangle_canton(indexTCO,i);
      canton[i].select:=true;
    end
    else
    begin
      pen.Mode:=pmCopy;
      canton[i].select:=false;
    end;

    if coul<$50000 then
    begin
      pen.color:=clwhite;
      Font.color:=clYellow;
    end
    else
    begin
      pen.color:=clBlack;
      font.color:=ClBlue;
    end;
    Roundrect(x0,y0,xf,yf,15,15);
    font.style:=style(tco[indextco,x,y].FontStyle);

    // numéro de canton
    with font do
    begin
      Name:=tco[indextco,x,y].fonte;
      {$IF CompilerVersion >= 28.0}
      orientation:=0;
      {$IFEND}
    end;
    Textout(x0+6,y0+2,format('%d',[TCO[indexTCO,x,y].Numcanton]));
    //Textout(x0+6,y0+2,intToSTR(canton[i].numero));

    // bouton
    Xcentre:=Xf-(larg div 2);
    Ycentre:=Yc;
    r:=larg div 3;
    bouton:=canton[i].bouton;
    case bouton of
      0 : couleur:=clyellow;
      1 : couleur:=clLime;
      2 : couleur:=clAqua;
    end;
    if bouton<=2 then cercle(PcanvasTCO[indexTCO],xCentre,ycentre,r,couleur,couleur)
    else
    begin
      if bouton=3 then
        // drapeau vert
        StretchBlt(PcanvasTCO[indexTCO].Handle,xf-larg,yf-haut,larg,haut,
                   FormTCO[indexTCO].ImageDrapVert.canvas.Handle,1,1,63,63,srccopy);
      if bouton=4 then
        // drapeau rouge
        StretchBlt(PcanvasTCO[indexTCO].Handle,xf-larg,yf-haut,larg,haut,
                   FormTCO[indexTCO].ImageDrapRouge.canvas.Handle,1,1,63,63,srccopy);
    end;

    calcul_reduction(frx,fry,Larg,haut);
    if (indexTrain=0) or (indexTrain=9999)  then
    begin
      // affiche le nom du canton
      s:=canton[i].nom;
      if s<>'' then
      begin
        font.Size:=((Larg*10) div 30)+1;             //((LargCell*5) div 29);
        Brush.Color:=coul;
        dx:=TextWidth(s) div 2;
        dy:=TextHeight(s) div 2;
        Textout(((x0+xf) div 2)-dx,((y0+yf) div 2)-dy,s);
      end;
      exit;
    end;

    // dessin de la loco ----------------------
    if (trains[indexTrain].icone=nil) or (Trains[indexTrain].Icone.height=0) then exit;

    //---redimensionnement
    HautDest:=round(haut/1.2);

    LargSrc:=Trains[indexTrain].Icone.width;
    HautSrc:=Trains[indexTrain].Icone.height;
    rd:=LargSrc/HautSrc;

    offsetX:=15;                    // décalage X de la loco
    largDest:=round(HautDest*rd);
    if largdest>((n-1)*larg)-offsetX then  // -1 pour le bouton
    begin
      largdest:=(n-1)*larg-offsetX;
      hautDest:=round(largdest/rd);
    end;
    // --------fin du redimensionnement
    offsetY:=(haut div 2)-(hautDest div 2)+1; // centrer l'icone au centre Y

    sens:=canton[i].SensLoco;
    if (sens<>SensGauche) and (sens<>SensDroit) and (sens<>0) then
    begin
      Sens:=SensGauche;
      canton[i].SensLoco:=sens;
      Affiche('Anomalie sens train canton '+intToSTR(canton[i].numero)+' incohérent ; repositionné à gauche',clOrange);
    end;
    case sens of
      0,sensGauche : begin
                       xi:=x0+OffsetX;
                       xt:=xi+largDest+round(10*frx);yt:=y0+round(20*fry);dx:=xf-larg;dy:=yf; // espace restant
                     end;
      sensDroit    : begin
                       xi:=xf-largdest-larg;
                       xt:=x0+round(5*frx);yt:=y0+round(20*fry);dx:=xi+largdest-larg;dy:=y0+offsety+hautdest;
                     end;
    end;

    // Nom du train
    s:=canton[i].NomTrain;
    l:=TextWidth(s);
    if l<dx-xt then
    begin
      font.Style:=[];
      font.Size:=((Larg*10) div 40)+1;             //((LargCell*5) div 29);
     // Affiche(intToSTR(numC)+' '+intToSTR(font.size),clYellow);
      brush.color:=coul;
      textout(xt,yt,s);
    end;
    Canton[i].Xicone:=xi;
    Canton[i].Yicone:=y0;
    Canton[i].Licone:=LargDest;
    Canton[i].Hicone:=HautDest;

    if sens=SensGauche then
    begin
      // efface l'image temporaire
      with FormTCO[indexTCO].ImageTemp2.Canvas do
      begin
        pen.color:=clwhite;
        brush.Color:=clblack;
        Rectangle(0,0,500,500);
      end;

      // matrice de copie à 180°G sans mise à l'échelle dans l'image provisoire
      p[0].X:=largSrc;
      p[0].Y:=0;
      p[1].X:=0;
      p[1].Y:=0;
      p[2].X:=LargSrc;
      p[2].Y:=HautSrc;

      PlgBlt(FormTCO[indexTCO].ImageTemp2.Canvas.Handle,p,
            Trains[indexTrain].Icone.canvas.Handle,0,0,largSrc,HautSrc,0,0,0);   // image 180°

      // !!! TransparentBLt ne mirroire pas les images. et StretchBlt pour inverser mais assombrit l'image
      TransparentBlt(PcanvasTCO[indexTCO].Handle,xi,y0+offsetY,largDest,hautDest,
                     FormTCO[indexTCO].ImageTemp2.canvas.Handle,0,0,LargSrc,HautSrc,clWhite);
    end
    else
    // sens droit
    TransparentBlt(PcanvasTCO[indexTCO].Handle,xi,y0+offsetY,largDest,hautDest,
                   Trains[indexTrain].Icone.canvas.Handle,0,0,Trains[indexTrain].Icone.width,Trains[indexTrain].Icone.height,clWhite);

    PImageTCO[indexTCO].Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.

  end;
end;

procedure dessin_cantonV(indexTCO : integer;Canvas : Tcanvas;x,y,mode : integer);
var AdrTrain,i,xi,yi,xt,yt,x0,xc,yc,y0,xf,yf,dx,dy,larg,haut,hautDest,LargDest,LargSrc,HautSrc,yr,ym,l,
    xCentre,yCentre,r,indexTrain,n,al,bouton,sens : integer;
    frX,frY,rd : single;
    coul : tcolor;
    s : string;
    p : array[0..2] of TPoint;
    TailleY,TailleX : integer;
begin
  if PcanvasTCO[indexTCO]=nil then exit;

  larg:=LargeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];
  n:=tco[indexTCO,x,y].FeuOriente; // nombre de cellules du canton

  x0:=(x-1)*Larg;
  y0:=(y-1)*Haut;
  xc:=x0+(larg div 2);
  yc:=y0+(Haut div 2);
  xf:=x0+larg+1;
  yf:=y0+(n*Haut)+1;   // +1 pour les jonctions verticales etre 2 cantons

  tailleX:=larg;
  tailleY:=n*Haut;

  with canvas do
  begin
    Pen.Width:=1;
    //brush.Color:=tco[indexTCO,x,y].CouleurFond;
    s:=tco[indexTCO,x,y].Fonte;
    if s='' then tco[indexTCO,x,y].Fonte:='Arial';

    i:=TCO[indexTCO,x,y].NumCanton; // numéro du canton
    i:=index_canton_numero(i);    // index du canton
    if i=0 then begin Affiche('Erreur 19V : canton nul en TCO'+intToSTR(IndexTCO)+' x='+intToSTR(x)+' y='+intToSTR(y),clred);exit;end;

    {
    s:=canton[i].nom;
    Pen.color:=clwhite;
    textOUT(x0-length(s)*8,y0+1,s);}

    indexTrain:=TCO[IndexTCO,x,y].train;
    if (indexTrain<0) or (indexTrain>NTrains) then
    begin
      Affiche('Anomalie 671',clred);
      exit;
    end;

    AdrTrain:=canton[i].adresseTrain;
    if AdrTrain<>0 then indexTrain:=index_train_adresse(adrTrain);

    if (AdrTrain<>0) or (indexTrain=9999) then coul:=CoulCantonOccupe[indexTCO]      // couleurCanton
      else coul:=CoulCantonLibre[indexTCO];
    Brush.Color:=coul;

    // mode=1 représenter avec les poignées de sélection
    if mode=1 then
    begin
      pen.mode:=pmXor;
      pen.color:=clWhite;
      // init grand rectangle
      with canton[i] do
      begin
        gd.Left:=x0;
        gd.Top:=y0;
        gd.Right:=x0+larg;
        gd.Bottom:=y0+n*haut;
      end;
      Init_rectangle_canton(indexTCO,i);
      Affiche_Rectangle_canton(indexTCO,i);
      canton[i].select:=true;
    end
    else
    begin
      pen.Mode:=pmCopy;
      canton[i].select:=false;
    end;

    if coul<$50000 then
    begin
      pen.color:=clwhite;
      Font.color:=clYellow;
    end
    else
    begin
      pen.color:=clBlack;
      font.color:=ClBlue;
    end;
    Roundrect(x0,y0,xf,yf,15,15);
    font.style:=style(tco[indextco,x,y].FontStyle);

    // numéro de canton
    with font do
    begin
      Name:=tco[indextco,x,y].fonte;
      {$IF CompilerVersion >= 28.0}
      font.orientation:=0;
      {$IFEND}
    end;
    Textout(x0+2,y0+6,format('%d',[canton[i].numero]));

    Xcentre:=Xc+1;
    Ycentre:=Yf-(haut div 2);
    r:=larg div 3;
    bouton:=canton[i].bouton;
    case bouton of
      0 : couleur:=clyellow;
      1 : couleur:=clLime;
      2 : couleur:=ClAqua;
    end;
    if bouton<=2 then cercle(PcanvasTCO[indexTCO],xCentre,ycentre,r,couleur,couleur)
    else
    begin
      if bouton=3 then // drapeau vert
      begin
        StretchBlt(PcanvasTCO[indexTCO].Handle,xf-larg,yf-haut,larg,haut,
                   FormTCO[indexTCO].ImageDrapVert.canvas.Handle,1,1,63,63,srccopy);
      end;
      if bouton=4 then // drapeau rouge
      begin
        StretchBlt(PcanvasTCO[indexTCO].Handle,xf-larg,yf-haut,larg,haut,
                   FormTCO[indexTCO].ImageDrapRouge.canvas.Handle,1,1,63,63,srccopy);
      end;
    end;

    calcul_reduction(frx,fry,Larg,haut);
    if (indexTrain=0) or (indexTrain=9999)  then
    begin
      // affiche le nom du canton
      //Affiche('pas de train',clYellow);
      s:=canton[i].nom;
      if s<>'' then
      begin
        font.Size:=((Larg*10) div 30)+1;             //((LargCell*5) div 29);
        Brush.Color:=coul;
        dy:=TextWidth(s) div 2;
        dx:=TextHeight(s) div 2;
        xi:=((x0+xf) div 2)-dx-1;
        yi:=((y0+yf) div 2)+dy;
        {$IF CompilerVersion >= 28.0}
        font.orientation:=900;
        Textout(xi,yi,s);
        {$ELSE}
        AffTexteIncliBordeTexture(PCanvasTCO[indexTCO],xi,yi,
                                  PCanvasTCO[indexTCO].Font,clYellow,0,pmcopy,s+'   ',900);
        {$IFEND}
      end;
      exit;
    end;

    // pas d'icone
    if (trains[indexTrain].icone=nil) or (Trains[indexTrain].Icone.height=0) then exit;



    // ----- prépare l'icone du train
    hautdest:=round(haut/1.2);

    LargSrc:=Trains[indexTrain].Icone.width;
    HautSrc:=Trains[indexTrain].Icone.height;

    rd:=LargSrc/HautSrc;
    largDest:=round(hautdest*rd);

    echange(largDest,HautDest);

    if hautdest>(n-1)*haut then
    begin
      hautdest:=(n-1)*haut;
      largDest:=round(HautDest/rd);
    end;

    sens:=canton[i].SensLoco;
    if (sens<>SensHaut) and (sens<>SensBas) and (sens<>0) then
    begin
      Sens:=SensHaut;
      canton[i].SensLoco:=sens;
      Affiche('Anomalie sens train canton '+intToSTR(canton[i].numero)+' incohérent ; repositionné en haut',clOrange);
    end;
    case sens of
      0,sensHaut : begin
                     yi:=y0+10;
                      // coordonnées du texte de la loco
                     xt:=x0+round(40*frx);yt:=yi+hautdest+round(10*fry);dx:=xf;dy:=yf-haut;
                   end;
      sensBas  : begin
                   yi:=yf-Hautdest-haut;
                   xt:=x0+round(40*frx);yt:=y0+round(10*fry);dx:=x0+Largdest;dy:=yi-haut
                 end;
    end;

    s:=canton[i].NomTrain;
    l:=TextWidth(s);
    Brush.Color:=coul;
    if l<dy-yt then
    {$IF CompilerVersion >= 28.0}
    begin
      font.orientation:=900;
      Textout(xi,yi,s);
    end;
    {$ELSE}
    AffTexteIncliBordeTexture(PCanvasTCO[indexTCO],xt,yt,
                              PCanvasTCO[indexTCO].Font,clYellow,0,pmcopy,s,-900);
    {$IFEND}

    Canton[i].Xicone:=x0+round(8*frx);
    Canton[i].Yicone:=yi;
    Canton[i].Licone:=LargDest;
    Canton[i].Hicone:=HautDest;

    if sens=SensHaut then
    begin
      with FormTCO[indexTCO].ImageTemp2.Canvas do
      begin
        pen.color:=clwhite;
        brush.Color:=clblack;
        Rectangle(0,0,500,500);
      end;

      // Mise à 90°
      p[0].X:=HautSrc;
      p[0].Y:=0;
      p[1].X:=HautSrc;
      p[1].Y:=LargSrc;
      p[2].X:=0;
      p[2].Y:=0;

      PlgBlt(FormTCO[indexTCO].ImageTemp.Canvas.Handle,p,
             Trains[indexTrain].Icone.canvas.Handle,0,0,largSrc,HautSrc,0,0,0);   // image 90°

      // et inversion miroir
      p[0].X:=0;
      p[0].Y:=LargSrc;
      p[1].X:=HautSrc;
      p[1].Y:=LargSrc;
      p[2].X:=0;
      p[2].Y:=0;

      PlgBlt(FormTCO[indexTCO].ImageTemp2.Canvas.Handle,p,
             FormTCO[indexTCO].ImageTemp.Canvas.Handle,0,0,HautSrc,largSrc,0,0,0);   // image 90°

      // copie l'image du signal retournée depuis image temporaire vers tco avec une réduction en mode transparent
      // c'est moche
      TransparentBlt(pcanvasTCO[indexTCO].Handle,x0+round(8*frx),yi,largDest,hautDest,   // destination avec mise à l'échelle
                     FormTCO[indexTCO].ImageTemp2.Canvas.Handle,0,0,HautSRC,LargSrc,clWhite);


      // StretchBlt est beau mais ne copie pas en transparent!
      //SetStretchBltMode(pCanvasTCO[indexTCO].Handle,halftone);           // blackonwhite


      //formTCO[indexTCO].ImageTCO.Transparent:=true;
      //formTCO[indexTCO].TransparentColor:=true;
      //formTCO[indexTCO].ImageTCO.Picture.Bitmap.TransparentColor:=clwhite;
      //pCanvasTCO[indexTCO].Brush.Color:=clwhite;
      //StretchBlt(pCanvasTCO[indexTCO].Handle,x0+round(8*frx),yi,largDest,hautDest,
      //           FormTCO[indexTCO].ImageTemp2.canvas.Handle,0,0,HautSRC,LargSrc,patcopy);

      //formTCO[indexTCO].ImageTCO.Transparent:=true;
      //formTCO[indexTCO].TransparentColor:=true;
      //formTCO[indexTCO].ImageTCO.Stretch:=true;
      //pCanvasTCO[indexTCO].CopyRect(rect( x0+round(8*frx),yi,largDest,hautDest),
      //                              FormTCO[indexTCO].ImageTemp2.Canvas,rect(0,0,HautSrc,LargSrc));

      //pCanvasTCO[indexTCO].Draw(x0+round(8*frx),yi,FormTCO[indexTCO].ImageTemp2.Picture.Bitmap);
      //StretchBitmapRectTransparent

    end
    else
    begin
      // Sens loco bas
      // matrice de copie à 90°G sans mise à l'échelle dans l'image provisoire
      p[0].X:=HautSrc;  //90;
      p[0].Y:=0;  //0;
      p[1].X:=HautSrc;  //90;
      p[1].Y:=LargSrc;  //49;
      p[2].X:=0;  //0;
      p[2].Y:=0;  //0;
      PlgBlt(FormTCO[indexTCO].ImageTemp2.Canvas.Handle,p,
            Trains[indexTrain].Icone.canvas.Handle,0,0,largSrc,HautSrc,0,0,0);   // image 90°
      // copie l'image du signal retournée depuis image temporaire vers tco avec une réduction en mode transparent
      TransparentBlt(pcanvasTCO[indexTCO].Handle,x0+round(8*frx),yi,largDest,hautDest,   // destination avec mise à l'échelle
                 FormTCO[indexTCO].ImageTemp2.Canvas.Handle,0,0,HautSrc,LargSrc,clWhite);
    end;
  end;
end;


//idcanton : indexcanton
// dessine le canton IdCanton en mode "mode"
// mode 0:canton normal  1:canton avec poignées
procedure dessin_canton(IdCanton : integer;mode : integer) ; overload;
var indexTCO,x,y : integer;
begin
  if IdCanton<1 then exit;
  //Affiche('Dessin canton id='+intToSTR(Idcanton)+' num='+intToSTR(canton[idcanton].numero)+' mode='+inttostr(mode),clred);
  indexTCO:=canton[idCanton].Ntco;
  if (PcanvasTCO[indexTCO]=nil) or (indexTCO=0) then exit;
  x:=canton[IdCanton].x;
  y:=canton[IdCanton].y;
  if isCantonV(indexTCO,x,y) then
  begin
    dessin_cantonV(indexTCO,PCanvasTCO[indexTCO],x,y,mode);
    exit;
  end;
  dessin_cantonH(indexTCO,PCanvasTCO[indexTCO],x,y,mode);
end;

// mode=0 canton normal  mode=1 : affiche le canton en mode rectangle de sélection avec les poignées
procedure dessin_canton(indexTCO : integer;Canvas : Tcanvas;x,y,mode : integer); overload;
begin
  if PcanvasTCO[indexTCO]=nil then exit;
  if isCantonV(indexTCO,x,y) then
  begin
    dessin_cantonV(indexTCO,Canvas,x,y,mode);
    exit;
  end;
  dessin_cantonH(indexTCO,Canvas,x,y,mode);
end;

// Element 24
procedure dessin_24L(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,position,ep : integer;
    r : Trect;
    fond: tcolor;

  procedure trajet_droit;
  begin
    couleur:=clvoies[indexTCO];
    if mode>0 then
    begin
      if position=const_droit then
      begin
        if mode=1 then couleur:=clcanton[indexTCO];
        if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
    end;
    with canvas do
    begin
      if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      pen.color:=couleur;
      moveto(xc,y0);lineto(xc,yc);
      if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      lineto(xc,yf);
    end;
  end;

  procedure trajet_devie;
  begin
    couleur:=clvoies[indexTCO];
    if mode>0 then
    begin
      if position=const_devie then
      begin
        if mode=1 then couleur:=clcanton[indexTCO];
        if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
    end;
    with canvas do
    begin
      pen.color:=couleur;
      if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveto(x0,y0);lineto(xc,yc);
      if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      lineto(xc,yf);
    end;
  end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  ep:=tco[indextco,x,y].epaisseurs;
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(affposFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jy1:=yc - Epaisseur-1;
        jx1:=xc-(Epaisseur div 2);
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1+epaisseur),Point(jx1+epaisseur,jy1-epaisseur),Point(jx1,jy1-epaisseur)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,yf);LineTo(xc,yc);LineTo(x0,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not(affposFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc-(Epaisseur div 2);   // pos Y de la bande inf
        r:=rect(jx1,yc-10,jx1-Epaisseur,yc+10);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,yf);LineTo(xc,y0);
      end;
    end;
  end;
end;

// Element 24
procedure dessin_24C(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
  x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
  x3:=xc;y3:=yf;
  x4:=x0;y4:=y0;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;


    if (position=const_Devie) then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jx1:=xc-(Epaisseur div 2); jy1:=yc - Epaisseur+5;
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1+epaisseur+10),Point(jx1+epaisseur,jy1-epaisseur),Point(jx1,jy1-epaisseur)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xc,yf);LineTo(xc,yc+round(8*fryGlob[indexTCO]));LineTo(x0,y0);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc-(Epaisseur div 2);   // pos Y de la bande inf
        r:=rect(jx1,yc-15,jx1-Epaisseur,yf);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,yf);LineTo(xc,y0);
      end;
    end;
  end;
end;

// Element 23  croisement
procedure dessin_23(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x1,x2,y1,y2,xp,x0,y0,x3,y3,x4,y4,xf,yf,xc,yc,trajet,ep,pont,
    adr1,adr2,index1,index2,position1,position2,EtatTJD,sHG,sBD : integer;
    a1,b1,a2,b2 : single;
    md,tHG,tBD : tEquipement;
    fond : tcolor;
  procedure verticale;
  begin
    with canvas do
    begin
      if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(xc,y0);LineTo(xc,yc);
      if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xc,yf);
    end;
  end;

  procedure diagonale;
  begin
    with canvas do
    begin
      if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(xf,y0);LineTo(xc,yc);
      if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(x0,yf);
    end;
  end;

  procedure tjd_d(dessin : integer);
  begin
    x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
    x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
    x3:=xf;y3:=y0;
    x4:=xc;y4:=yf;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,2) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure tjd_G(dessin : integer);
  begin
    x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
    x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+round(hauteurCell[indexTCO] / 2.5);
    x3:=x0;y3:=yf;
    x4:=xc;y4:=y0;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,1) or testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  pont:=tco[indextco,x,y].pont;
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    Brush.Color:=clvoies[indexTCO];
    pen.color:=clvoies[indexTCO];
    pen.width:=epaisseur;

    diagonale;
    verticale;
    md:=aiguillage[index_aig(tco[indextco,x,y].Adresse)].modele;
    if (md=tjd) or (md=tjs) then
    begin
      tjd_G(1);
      tjd_D(1);
    end;

    // verticale
    if testbit(pont,1) or testbit(pont,5) then
    begin
      // masquages
      pen.color:=clfond[indexTCO];
      xp:=xc-(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);
      xp:=xc+(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);

      // barrières du pont
      pen.color:=clBarriere[indexTCO];
      pen.Width:=epaisseur div 2;
      xp:=xc-(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);
      xp:=xc+(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);
    end;

    // diagonale
    if testbit(pont,2) or testbit(pont,6) then
    begin
      pen.color:=clfond[indexTCO];
      droite(xf,y0,x0,yf,a1,b1);
      // droite a2,b2 // passant par x2,y2
      a2:=a1;

      // masquage G
      x2:=xf-round(21*frxGlob[indexTCO]);y2:=y0+round(12*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(6*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // barrière
      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      x2:=xf-round(21*frxGlob[indexTCO]);y2:=y0+round(12*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(6*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // masquage D
      pen.Width:=epaisseur;
      pen.color:=clFond[indexTCO];
      x2:=xf-round(10*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(16*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // barrière
      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      x2:=xf-round(10*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=x0+round(16*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);
    end;

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[indextco,x,y].trajet;
      case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then verticale;
      if trajet=2 then diagonale;
      if trajet=3 then // NE C S
      begin
        {if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(xf,y0);LineTo(xc,yc);
        if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xc,yf);}
        tjd_d(1);
      end;
      if trajet=4 then // N C SO
      begin
        {if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(xc,y0);LineTo(xc,yc);
        if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(x0,yf);}
        tjd_g(1);
      end;
    end;
  end;

  // dessin position de la tjd
  adr1:=tco[indexTCO,x,y].Adresse;
  Index1:=Index_aig(adr1);
  md:=aiguillage[Index1].modele;
  if (md=tjd) or (md=tjs) then
  begin
    EtatTJD:=aiguillage[index1].EtatTJD;   // nombre d'états de la tjd (2 ou 4)
    position1:=aiguillage[index1].position;
    sHG:=TCO[indexTCO,x,y].suivHG;tHG:=TCO[indexTCO,x,y].typHG;
    sBD:=TCO[indexTCO,x,y].suivBD;tBD:=TCO[indexTCO,x,y].typBD;
    canvas.pen.color:=clfond[indexTCO];;
    canvas.pen.Width:=epaisseur div 2;
    if etatTJD=4 then
    begin
      adr2:=aiguillage[index1].DDevie;  // homologue
      Index2:=Index_aig(adr2);
      position2:=aiguillage[index2].position;

      if (position1=const_devie) and (position2=const_devie) then
      begin
        with canvas do begin
          moveTo(xc,y0);LineTo(xc,yf);
        end;
      end;

      if (position1=const_droit) and (position2=const_droit) then
      begin
        with canvas do begin
          moveTo(x0,yf);LineTo(xf,y0);
        end;
      end;

      if (position1=const_droit) and (position2=const_devie) then
      begin
        if tco[indexTCO,x,y].tjdS=adr1 then
        {with canvas do begin
          moveTo(xf,y0);LineTo(xc,yc);Lineto(xc,yf);
        end;}
        tjd_d(2);
        if tco[indexTCO,x,y].tjdS=adr2 then
        {with canvas do begin
          moveTo(xc,y0);LineTo(xc,yc);Lineto(x0,yf);
        end;}
        tjd_g(2);
      end;

      if (position1=const_devie) and (position2=const_droit) then
      begin
        if tco[indexTCO,x,y].tjdS=adr1 then
        {with canvas do begin
          moveTo(xc,y0);LineTo(xc,yc);Lineto(x0,yf);
        end; }
        tjd_g(2);
        if tco[indexTCO,x,y].tjdS=adr2 then
        {with canvas do begin
          moveTo(xf,y0);LineTo(xc,yc);Lineto(xc,yf);
        end;}
        tjd_d(2);
      end;
    end;

    if etatTJD=2 then
    begin
      if position1=const_droit then
      with canvas do
      begin
        moveTo(xc,y0);LineTo(xc,yf);
        moveTo(xf,y0);LineTo(x0,yf);
      end;
      if position1=const_devie then
      with canvas do
      begin
        // donne l'équation de droite y=ax+b passant par les points (x1,y1) (x2,y2)
        droite(xc,yc,x0,yf,a1,b1);
        //gauche
        moveTo(xc,y0); LineTo(xc,yc-epaisseur);
        LineTo(xc-epaisseur,round((xc-epaisseur)*a1+b1) ); LineTo(x0,yf);
        //droite
        moveTo(xc,yf);
        lineTo(xc,yc+epaisseur);
        LineTo(xc+epaisseur,round((xc+epaisseur)*a1+b1) );
        LineTo(xf,y0);
      end;
    end;
  end;
end;

procedure dessin_24(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_24L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_24C(indexTco,Canvas,x,y,Mode);
end;

// Element 25  croisement
procedure dessin_25(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var xp,x0,y0,x3,y3,x4,y4,xf,yf,xc,yc,trajet,ep,pont,x1,x2,y1,y2,
    adr1,adr2,index1,index2,position1,position2,EtatTJD,sHG,sBD : integer;
    a1,b1,a2,b2 : single;
    md,tHG,tBD : tEquipement;
    fond : tcolor;
  procedure verticale;
  begin
    with canvas do
    begin
      if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(xc,y0);LineTo(xc,yc);
      if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xc,yf);
    end;
  end;

  procedure diagonale;
  begin
    with canvas do
    begin
      if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveTo(x0,y0);LineTo(xc,yc);
      if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      LineTo(xf,yf);
    end;
  end;

  procedure tjd_g(dessin : integer);
  begin
    x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
    x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
    x3:=xc;y3:=yf;
    x4:=x0;y4:=y0;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,0) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure tjd_d(dessin : integer);
  begin
    x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
    x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+round(hauteurCell[indexTCO] / 3);
    x3:=xc;y3:=y0;
    x4:=xf;y4:=yf;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if dessin=1 then
      begin
        if testbit(ep,1) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
      end;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  xc:=x0+(LargeurCell[indexTCO] div 2);
  yc:=y0+(hauteurCell[indexTCO] div 2);
  xf:=x0+LargeurCell[indexTCO];
  yf:=y0+hauteurCell[indexTCO];
  ep:=tco[indextco,x,y].epaisseurs;
  pont:=tco[indextco,x,y].pont;
  fond:=tco[indexTco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=tco[indextco,x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    //FillRect(r);

    Brush.Color:=clvoies[indexTCO];
    pen.color:=clvoies[indexTCO];
    pen.width:=epaisseur;

    verticale;
    diagonale;
    md:=aiguillage[index_aig(tco[indextco,x,y].Adresse)].modele;
    if (md=tjd) or (md=tjs) then
    begin
      tjd_g(1);
      tjd_d(1);
    end;

    // verticale
    if testbit(pont,1) or testbit(pont,5) then
    begin
      // masquages
      pen.color:=clfond[indexTCO];
      xp:=xc-(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);
      xp:=xc+(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);

      // barrières du pont
      pen.color:=clBarriere[indexTCO];
      pen.Width:=epaisseur div 2;
      xp:=xc-(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);
      xp:=xc+(epaisseur);
      moveto(xp,y0+epaisseur);lineTo(xp,yf-epaisseur);
    end;

     // diagonale
    if testbit(pont,0) or testbit(pont,4) then
    begin
      pen.color:=clfond[indexTCO];
      droite(x0,y0,xf,yf,a1,b1);
      // droite a2,b2 // passant par x2,y2
      a2:=a1;

      // masquage G
      x2:=x0+round(8*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(18*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // barrière
      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      x2:=x0+round(8*frxGlob[indexTCO]);y2:=y0+round(18*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(18*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      // masquage D
      pen.Width:=epaisseur;
      pen.color:=clfond[indexTCO];
      x2:=x0+round(20*frxGlob[indexTCO]);y2:=y0+round(11*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(8*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);

      pen.width:=epaisseur div 2;
      pen.color:=clBarriere[indexTCO];
      x2:=x0+round(20*frxGlob[indexTCO]);y2:=y0+round(11*fryGlob[indexTCO]);
      b2:=y2-a2*x2;
      x1:=xf-round(8*frxGlob[indexTCO]);
      y1:=round(a2*x1+b2);
      moveto(x1,y1);lineTo(x2,y2);
    end;

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[indextco,x,y].trajet;
      case mode of
      0: couleur:=clVoies[indexTCO];
      1: couleur:=ClCanton[indexTCO];
      2: couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;

      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then verticale;
      if trajet=2 then diagonale;
      if trajet=3 then // NO C S
      begin
        {if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(x0,y0);LineTo(xc,yc);
        if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xc,yf);}
        tjd_g(1);
      end;
      if trajet=4 then
      begin
        {if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(xc,y0);LineTo(xc,yc);
        if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,yf);}
        tjd_d(1);
      end;
    end;
  end;

  // dessin position de la tjd
  adr1:=tco[indexTCO,x,y].Adresse;
  Index1:=Index_aig(adr1);
  md:=aiguillage[Index1].modele;
  if (md=tjd) or (md=tjs) then
  begin
    EtatTJD:=aiguillage[index1].EtatTJD;   // nombre d'états de la tjd (2 ou 4)
    position1:=aiguillage[index1].position;
    sHG:=TCO[indexTCO,x,y].suivHG;tHG:=TCO[indexTCO,x,y].typHG;
    sBD:=TCO[indexTCO,x,y].suivBD;tBD:=TCO[indexTCO,x,y].typBD;
    canvas.pen.color:=clfond[indexTCO];
    canvas.pen.Width:=epaisseur div 2;
    if etatTJD=4 then
    begin
      adr2:=aiguillage[index1].DDevie;  // homologue
      Index2:=Index_aig(adr2);
      position2:=aiguillage[index2].position;

      if (position1=const_devie) and (position2=const_devie) then
      begin
        with canvas do begin
          moveTo(x0,y0);LineTo(xf,yf);
        end;
      end;

      if (position1=const_droit) and (position2=const_droit) then
      begin
        with canvas do begin
          moveTo(xc,yf);LineTo(xc,y0);
        end;
      end;

      if (position1=const_droit) and (position2=const_devie) then
      begin
        if tco[indexTCO,x,y].tjdS=adr1 then
        {with canvas do begin
          moveTo(xc,y0);LineTo(xc,yc);Lineto(xf,yf);
        end;}
        tjd_d(2);
        if tco[indexTCO,x,y].tjdS=adr2 then
        {with canvas do begin
          moveTo(x0,y0);LineTo(xc,yc);Lineto(xc,yf);
        end; }
        tjd_g(2);
      end;

      if (position1=const_devie) and (position2=const_droit) then
      begin
        if tco[indexTCO,x,y].tjdS=adr1 then
        {with canvas do begin
          moveTo(x0,y0);LineTo(xc,yc);Lineto(xc,yf);
        end; }
        tjd_g(2);
        if tco[indexTCO,x,y].tjdS=adr2 then
        {with canvas do begin
          moveTo(xc,y0);LineTo(xc,yc);Lineto(xf,yf);
        end; }
        tjd_d(2);
      end;
    end;

    if etatTJD=2 then
    begin
      if position1=const_droit then
      with canvas do
      begin
        moveTo(xc,y0);LineTo(xc,yf);
        moveTo(x0,y0);LineTo(xf,yf);
      end;  
      if position1=const_devie then
      with canvas do
      begin                                                              
        // donne l'équation de droite y=ax+b passant par les points (x1,y1) (x2,y2)
        droite(x0,y0,xf,yf,a1,b1);
        //gauche
        moveTo(xc,yf); LineTo(xc,yc+epaisseur);
        LineTo(xc-epaisseur,round((xc-epaisseur)*a1+b1) ); LineTo(x0,y0);
        //droite
        moveTo(xc,y0);
        lineTo(xc,yc-epaisseur);
        LineTo(xc+epaisseur,round((xc+epaisseur)*a1+b1) );
        LineTo(xf,yf);
      end;  
    end;
  end;
 
end;

// Element 26
procedure dessin_26L(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,position,ep : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xc,yf);lineto(xc,yc);
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineTo(xf,y0);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;


    if (position=const_Devie) then
    begin
      if not affposFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jy1:=yc - 2*Epaisseur-1;
        jx1:=xc- (Epaisseur div 2);
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1),Point(jx1+epaisseur,jy1+epaisseur),Point(jx1,jy1+2*epaisseur)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,yf);LineTo(xc,yc);LineTo(xf,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc+(Epaisseur div 2)+1;
        r:=rect(jx1,yc-15,jx1+Epaisseur,yc+10);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,yf);LineTo(xc,y0);
      end;
    end;
  end;
end;

// Element 26
procedure dessin_26C(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
  x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
  x3:=xf;y3:=y0;
  x4:=xc;y4:=yf;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not AffPosFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jx1:=xc-(Epaisseur div 2); jy1:=yc - Epaisseur-5;
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1),Point(jx1+epaisseur,jy1+epaisseur),Point(jx1,jy1+4*epaisseur)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xc,yf);LineTo(xc,yc+round(4*FryGlob[indexTCO]));LineTo(xf,y0);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc+(Epaisseur div 2);
        r:=rect(jx1+1,yc-15,jx1+Epaisseur,yf);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,yf);LineTo(xc,y0);
      end;
    end;
  end;
end;

procedure dessin_26(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_26L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_26C(indexTco,Canvas,x,y,Mode);
end;

// Element 27
procedure dessin_27L(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,jx2,jy2,jx3,jy3,xc,yc,jx1,jy1,xf,yf,position,ep : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xc,y0);lineto(xc,yc);    // verticale complete
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineTo(x0,yf);
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affPosFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jx1:=xc-(Epaisseur div 2); jy1:=yc + Epaisseur+2;
        jx2:=jx1+epaisseur;jy2:=jy1-epaisseur;
        jx3:=jx2;jy3:=yc+2*epaisseur;
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,y0);LineTo(xc,yc);LineTo(x0,yf);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc-(Epaisseur div 2);
        r:=rect(jx1,yc-3*epaisseur,jx1-Epaisseur,yf);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,y0);LineTo(xc,yf);
      end;
    end;
  end;
end;

// Element 27c
procedure dessin_27C(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,jx2,jy2,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,ep,
    jx3,jy3 : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 3);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
  x2:=xc;y2:=yf+round(hauteurCell[indexTCO] / 2.9);

  x3:=x0;y3:=yf;
  x4:=xc;y4:=y0;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jx1:=xc-(Epaisseur div 2); jy1:=yc + Epaisseur;
        jx2:=jx1+epaisseur;jy2:=jy1-3*epaisseur;
        jx3:=jx2;jy3:=yc+2*epaisseur;
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xc,y0);LineTo(xc,yc-round(4*frxGlob[indexTCO]));LineTo(x0,yf);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc-(Epaisseur div 2);
        r:=rect(jx1,yc-3*epaisseur,jx1-Epaisseur,yf);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,y0);LineTo(xc,yf);
      end;
    end;
  end;
end;

procedure dessin_27(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_27L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_27C(indexTco,Canvas,x,y,Mode);
end;

// Element 28
procedure dessin_28L(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,jx2,jy2,jx3,jy3,xc,yc,jx1,jy1,xf,yf,position,ep : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineTo(xf,yf);
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_Devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;    // affiche la position de la branche déviée
      end;

      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end
    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPoSFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jx1:=xc-(Epaisseur div 2); jy1:=yc + (Epaisseur div 2);
        jx2:=jx1+epaisseur;jy2:=jy1+epaisseur;
        jx3:=jx2;jy3:=yc+2*epaisseur;
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
      end  
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,y0);LineTo(xc,yc);LineTo(xf,yf);
      end;  
    end;

    if position=const_droit then
    begin
      if not(AffPoSFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc+(Epaisseur div 2);
        r:=rect(jx1,yc-3*epaisseur,jx1+Epaisseur,yf);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,y0);LineTo(xc,yf);  
      end;
    end;
  end;
end;

// Element 28
procedure dessin_28C(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,jx2,jy2,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,ep,
    jx3,jy3 : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  // mode rond
  x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
  x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+(hauteurCell[indexTCO] div 3);
  x3:=xc;y3:=y0;
  x4:=xf;y4:=yf;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;


    if (position=const_Devie) then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        jx1:=xc-(Epaisseur div 2); jy1:=yc - (2*Epaisseur );
        jx2:=jx1+epaisseur;jy2:=yc+epaisseur;
        jx3:=jx2;jy3:=yc+2*epaisseur;
        pen.width:=1;
        Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xc,y0);LineTo(xc,yc-round(4*fryGlob[indexTCO]));LineTo(xf,yf);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        jx1:=xc+(Epaisseur div 2);
        r:=rect(jx1,yc-3*epaisseur,jx1+Epaisseur,yf);
        FillRect(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xc,y0);LineTo(xc,yf);
      end;
    end;
  end;
end;

procedure dessin_28(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_28L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_28C(indexTco,Canvas,x,y,Mode);
end;

// Element 29
procedure dessin_29L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_Devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;    // affiche la position de la branche déviée
      end;

      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else

    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc+(epaisseur div 2)+1;y1:=yc-epaisseur;
        x2:=x1+epaisseur;y2:=y1;
        x3:=x2;y3:=y2+4*epaisseur;
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);lineTo(xc,yc);LineTo(xc,yf);
      end;
    end;
    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-(epaisseur div 2);y1:=yc+(epaisseur div 2);
        x2:=x1+epaisseur;y2:=y1+epaisseur;
        x3:=x2;y3:=y2+(epaisseur div 2);
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);LineTo(xf,yf);
      end;
    end;
  end;
end;

procedure dessin_29C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : tcolor;
   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
  x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
  x3:=xc;y3:=yf;
  x4:=x0;y4:=y0;
  ep:=tco[indextco,x,y].epaisseurs;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-round(epaisseur*1);y1:=yc-round(2.2*epaisseur);
        x2:=xc+round(epaisseur*0.7);y2:=y1;
        x3:=x2-round(epaisseur*0.2);y3:=yc+round(1.8*epaisseur);
        x4:=x1;y4:=yc-round(1.5*epaisseur);
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(x0,y0);LineTo(xc-round(6*FrxGlob[indexTCO]),yc);LineTo(xc,yf);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-round(epaisseur*2.3);y1:=yc-round(epaisseur*1.4);
        x2:=x1+3*epaisseur;y2:=y1+3*epaisseur;
        x3:=x2;y3:=y2+(epaisseur div 2);
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);LineTo(xf,yf);
      end;
    end;
  end;
end;

procedure dessin_29(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_29L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_29C(indexTco,Canvas,x,y,Mode);
end;

// Elément 32
procedure dessin_32L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xf,y0);lineto(xc,yc);    
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(x0,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xf,y0);lineto(xc,yc);
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,yf);  
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-round(1.5*epaisseur);y1:=yc-(epaisseur)+1;
        x2:=xc-(epaisseur div 2);y2:=y1+4*epaisseur;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,y0);LineTo(xc,yc);LineTo(xc,yf);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc+round(0.9*epaisseur);y1:=yc;
        x2:=x1+round(1.0*epaisseur);
        x3:=xc-round(0.5*epaisseur);y3:=y1+round(2.2*epaisseur);
        x4:=x3-round(0.9*epaisseur);
        polygon([point(x1,y1),point(x2,y1),point(x3,y3),point(x4,y3)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,y0);LineTo(x0,yf);
      end;
    end;
  end;
end;

procedure dessin_32C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : tcolor;
   
   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xf,y0);lineto(xc,yc);
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(x0,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
  x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
  x3:=xf;y3:=y0;
  x4:=xc;y4:=yf;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;


    if (position=const_Devie) then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc-round(0.7*epaisseur);y1:=yc-round(1.6*epaisseur);
        x2:=xc+round(0.9*epaisseur);y2:=y1;
        x3:=xc-round(0.3*epaisseur);y3:=yc+round(1.4*epaisseur);
        x4:=xc-round(0.7*epaisseur);y4:=y3;
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xf,y0);LineTo(xc+round(4*frxGlob[indexTCO]),yc);LineTo(xc,yf);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc+round(2.8*epaisseur);y1:=yc-(2*epaisseur);
        x2:=xc+(4*epaisseur);
        x3:=xc+(1*epaisseur);y3:=yc+(epaisseur);
        x4:=xc-round(0.2*epaisseur);y4:=y3;
        polygon([point(x1,y1),point(x2,y1),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,y0);LineTo(x0,yf);
      end;
    end;
  end;
end;

procedure dessin_32(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_32L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_32C(indexTco,Canvas,x,y,Mode);
end;

// Element 33
procedure dessin_33L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,y0);lineto(xc,yc);
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(xf,yf);lineto(xc,yc);
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,y0);
     end;
   end;


begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

   if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-2*epaisseur;y1:=yc-(3*epaisseur);
        x2:=xc-(epaisseur div 2);y2:=yc+epaisseur;
        pen.color:=fond;
        Brush.Color:=fond;
        r:=rect(x1,y1,x2,y2);
        rectangle(r);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,yf);lineTo(x0,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not(affPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-round(1.3*epaisseur);y1:=yc-(2*epaisseur) ;
        x2:=xc+round(0.6*epaisseur);y2:=y1;
        x3:=xc+round(2.5*epaisseur);y3:=yc+(epaisseur div 2);
        x4:=xc+round(1.2*epaisseur);y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(xf,yf);LineTo(xc,yc);LineTo(xc,y0);
      end;
    end;
  end;
end;

procedure dessin_33c(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    r : Trect;
    fond : tcolor;

  procedure trajet_droit;
  begin
    couleur:=clvoies[indexTCO];
    if mode>0 then
    begin
      if position=const_droit then
      begin
        if mode=1 then couleur:=clcanton[indexTCO];
        if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
    end;

    with canvas do
    begin
      pen.color:=couleur;
      if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      moveto(x0,y0);lineto(xc,yc);
      if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      lineto(xf,yf);
    end;
  end;

  procedure trajet_devie;
  begin
    couleur:=clvoies[indexTCO];
    if mode>0 then
    begin
      if position=const_devie then
      begin
        if mode=1 then couleur:=clcanton[indexTCO];
        if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
      end;
    end;

    with canvas do
    begin
      pen.color:=couleur;
      if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
    end;
  end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
  x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+(hauteurCell[indexTCO] div 3);
  x3:=xc;y3:=y0;
  x4:=xf;y4:=yf;
  ep:=tco[indextco,x,y].epaisseurs;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.width:=1;
        x1:=xc-round(1.5*epaisseur);y1:=yc-round(2.5*epaisseur);
        x2:=xc-round(0.6*epaisseur);y2:=y1;
        x3:=xc+round(1.3*epaisseur);y3:=yc+2*epaisseur;
        x4:=xc+round(0.4*epaisseur);y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        r:=rect(x1,y1,x2,y2);
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(xf,yf);LineTo(xc+round(4*FrxGlob[indexTCO]),yc);LineTo(xc,y0);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not(AffPosFil) then
      begin
        // effacement du morceau
        pen.Width:=1;
        x1:=xc-round(1.3*epaisseur);y1:=yc-(2*epaisseur);
        x2:=xc+round(0.9*epaisseur);y2:=y1;
        x3:=xc+round(3.5*epaisseur);y3:=yc+2*epaisseur;
        x4:=xc+round(2.9*epaisseur);y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,y0);LineTo(xf,yf);
      end;
    end;
  end;
end;

procedure dessin_33(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_33L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_33C(indexTco,Canvas,x,y,Mode);
end;

// Element 34
procedure dessin_34L(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : Tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       pen.color:=couleur;
       moveto(x0,yf);lineto(xc,yc);
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,yf);lineto(xc,yc);    // diag complete
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xc,y0);    // partie droite
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_Devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;    // affiche la position de la branche déviée
      end;

      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end
    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affposFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc+round(0.5*epaisseur);y1:=yc-round(3*epaisseur);
        x2:=xc+round(1.5*epaisseur);y2:=yc+epaisseur;
        polygon([point(x1,y1),point(x2,y1),point(x2,y2),point(x1,y2)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yf);LineTo(xc,yc);LineTo(xc,y0);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        x1:=xc-round(0.5*epaisseur);y1:=yc-round(2*epaisseur);
        x2:=xc+round(0.5*epaisseur);y2:=y1;
        x3:=x2;y3:=yc-round(1.3*epaisseur);
        x4:=x1;y4:=yc-round(0.3*epaisseur);
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yf);LineTo(xf,y0);
      end;
    end;
  end;
end;

procedure dessin_34C(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position,ep : integer;
    fond : Tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       moveto(x0,yf);lineto(xc,yc);
       if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       lineto(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies[indexTCO];
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton[indexTCO];
         if mode=2 then couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell[indexTCO];       // x origine
  y0:=(y-1)*hauteurCell[indexTCO];       // y origine
  yc:=y0+(hauteurCell[indexTCO] div 2);  // y centre
  xc:=x0+(LargeurCell[indexTCO] div 2);  // x centre
  xf:=x0+LargeurCell[indexTCO];          // x fin
  yf:=y0+hauteurCell[indexTCO];          // y fin
  // mode rond
  x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
  x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+(hauteurCell[indexTCO] div 3);
  x3:=x0;y3:=yf;
  x4:=xc;y4:=y0;

  position:=positionTCO(indexTco,x,y);
  fond:=tco[indextco,x,y].CouleurFond;
  ep:=tco[indextco,x,y].epaisseurs;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if mode>0 then
    begin
      if (position=const_devie) or (position=const_inconnu) then
      begin
        trajet_droit;
        trajet_devie;
      end;
      if (position=const_droit) then
      begin
        trajet_devie;
        trajet_droit;
      end;
    end

    else
    begin
      trajet_devie;
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
      if not affPosFil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=1;
        x1:=xc+round(0.1*epaisseur);y1:=yc-round(1*epaisseur);
        x2:=xc+round(2*epaisseur);y2:=y1;
        x3:=xc-round(0.5*epaisseur);y3:=yc+round(3*epaisseur);
        x4:=xc-round(2*epaisseur);y4:=y3;
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        //moveTo(x0,yf);LineTo(xc-round(6*frxGlob[indexTCO]),yc);LineTo(xc,y0);
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;
    end;

    if position=const_droit then
    begin
      if not affposfil then
      begin
        // effacement du morceau
        pen.color:=fond;
        Brush.Color:=fond;
        pen.Width:=1;
        x1:=xc-round(2.3*epaisseur);y1:=yc-round(2*epaisseur);
        x2:=xc+round(epaisseur);y2:=y1;
        x3:=x2;y3:=yc-round(2*epaisseur);
        x4:=x1;y4:=yc+round(1.1*epaisseur);
        polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end
      else
      begin
        pen.color:=fond;
        Brush.Color:=fond;
        pen.width:=epaisseur div 2;
        moveTo(x0,yf);LineTo(xf,y0);
      end;
    end;
  end;
end;

procedure dessin_34(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_34L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_34C(indexTco,Canvas,x,y,Mode);
end;

// calcul des facteurs de réductions X et Y pour l'adapter à l'image de destination
procedure calcul_reduction(Var frx,fry : single;DimDestX,DimDestY : integer);
begin
  frx:=DimDestX/ZoomMax;
  fry:=DimDestY/ZoomMax;
  //Affiche(formatfloat('0.000000',frY),clyellow);
end;

procedure Signal_180(index : integer;ImageSource : TImage;x,y : integer;FrX,FrY : real;inverse : boolean);
var p : array[0..2] of TPoint;
    TailleY,TailleX : integer;
begin
  TailleY:=ImageSource.Picture.Height+0;
  TailleX:=ImageSource.Picture.Width+0;

  // copie à 180° sans mise à l'échelle dans l'image provisoire
  // il y a un décalage observé par la fonction PlgBlt d'1 pixel quand on tourne de 180°. Les corrections +1 et -1 servent à corriger cet effet.
  // coin supérieur gauche NO
  p[0].X:=TailleX+1;
  p[0].Y:=TailleY+1;
  // coin supérieur droit NE
  p[1].X:=0;
  p[1].Y:=TailleY;
  // coin inférieur gauche SO
  p[2].X:=TailleX+1;
  p[2].Y:=0;

  {with PImageTemp[index].Canvas do
  begin
    pen.Color:=clred;
    moveTO(00,0);lineTo(100,0);
    moveto(0,00);lineto(0,100);
  end;
  }
  if inverse then
  begin
    inverse_image(FormTCO[index].ImageTemp2,ImageSource);
    // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 180°
    PlgBlt(PImageTemp[Index].Canvas.Handle,p,FormTCO[index].ImageTemp2.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);
  end
  else //                                                             source               facultatif
    PlgBlt(PImageTemp[index].Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

    TransparentBlt(PcanvasTCO[index].Handle,x-1,y,round(TailleX*FrX),round(TailleY*FrY),   // destination
                 PImageTemp[index].Canvas.Handle,0,0,TailleX,TailleY,clBlue);    // source - clblue est la couleur de transparence
end;


// Affiche dans le TCO en x,y un signal à 90° d'après l'image transmise
// x y en coordonnées pixels
procedure Signal_90G(index : integer;ImageSource : TImage;x,y : integer;FrX,FrY : real;inverse : boolean);
var p : array[0..2] of TPoint;
    TailleY,TailleX : integer;
begin
  TailleY:=ImageSource.Picture.Height;
  TailleX:=ImageSource.Picture.Width;

  // copie à 90°G sans mise à l'échelle dans l'image provisoire
  p[0].X:=TailleY;  //90;
  p[0].Y:=0;  //0;
  p[1].X:=TailleY;  //90;
  p[1].Y:=TailleX;  //49;
  p[2].X:=0;  //0;
  p[2].Y:=0;  //0;

  //&& parent pour l'index

  if inverse then
  begin
    inverse_image(FormTCO[index].ImageTemp2,ImageSource);
    // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
    PlgBlt(PImageTemp[Index].Canvas.Handle,p,FormTCO[index].ImageTemp2.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);
  end
  else
    PlgBlt(PImageTemp[index].Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);
  // copie l'image du signal retournée depuis image temporaire vers tco avec une réduction en mode transparennt
  TransparentBlt(PcanvasTCO[index].Handle,x,y,round(TailleY*FrY),round(TailleX*FrX),   // destination
                 PImageTemp[index].Canvas.Handle,0,0,TailleY,TailleX,clBlue);    // source - clblue est la couleur de transparence
  PImageTCO[index].Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

// copie de l'image du signal à 90° dans le canvas source et le tourne de 90° et le met dans l'image temporaire
procedure Signal_90D(index : integer;ImageSource : TImage;x,y : integer ; FrX,FrY : real;inverse : boolean);
var p : array[0..2] of TPoint;
    TailleY,TailleX  : integer;
begin
  TailleY:=ImageSource.Picture.Height;
  TailleX:=ImageSource.Picture.Width;

  // copie à 90°D dans l'image provisoire
  p[0].X:=0;
  p[0].Y:=TailleX;  //49;
  p[1].X:=0;
  p[1].Y:=0;
  p[2].X:=TailleY;  //90;
  p[2].Y:=TailleX;  //49;

  if inverse then
  begin
    inverse_image(FormTCO[index].ImageTemp2,ImageSource);
    // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
    PlgBlt(PImageTemp[index].Canvas.Handle,p,FormTCO[index].ImageTemp2.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);
  end
  else
    PlgBlt(PImageTemp[index].Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

  // et copier l'image avec mise à l'échelle tournée sur le TCO
  TransparentBlt(PcanvasTCO[index].Handle,x,y,round(tailleY*FrY),round(tailleX*FrX),
                 PImageTemp[index].Canvas.Handle,0,0,TailleY,TailleX,clBlue);
  PImageTCO[index].Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

procedure affiche_pied2_180(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=13;y1:=-3;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    y1:=y1-6;
    LineTo( x+round(x1*frX),y+round(y1*frY) );
    if pied=1 then LineTo( x+round((x1-50)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+50)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied3_180(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=13;y1:=-3;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    y1:=y1-6;
    LineTo( x+round(x1*frX),y+round(y1*frY) );
    if pied=1 then LineTo( x+round((x1-50)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+50)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied4_180(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=13;y1:=-3;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    y1:=y1-6;
    LineTo( x+round(x1*frX),y+round(y1*frY) );
    if pied=1 then LineTo( x+round((x1-50)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+50)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied5_180(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=13;y1:=-3;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    y1:=y1-6;
    LineTo( x+round(x1*frX),y+round(y1*frY) );
    if pied=1 then LineTo( x+round((x1-50)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+50)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied7_180(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=38;y1:=0;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    y1:=y1-6;
    LineTo( x+round(x1*frX),y+round(y1*frY) );
    if piedSignal=1 then LineTo( x+round((x1-63)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+40)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied9_180(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=38;y1:=0;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    y1:=y1-6;
    LineTo( x+round(x1*frX),y+round(y1*frY) );
    if piedSignal=1 then LineTo( x+round((x1-63)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+40)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied20_90G(index,x,y : integer;FrX,frY : real;piedSignal : integer;contrevoie : boolean);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];

    if contrevoie then
    begin
      x1:=0;y1:=34;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      x1:=x1-6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round(x1*frX),y+round((y1+40)*frY) ) else     // a gauche
                     LineTo( x+round(x1*frX),y+round((y1-65)*frY) );         // a droite
    end
    else
    begin
      x1:=0;y1:=14;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      x1:=x1-6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round(x1*frX),y+round((y1+60)*frY) ) else
                     LineTo( x+round(x1*frX),y+round((y1-45)*frY) );
    end;
  end;
end;

procedure affiche_pied20_90D(index,x,y : integer;FrX,frY : real;piedSignal : integer;contrevoie : boolean);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];

    if contrevoie then
    begin
      x1:=65;y1:=-8;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      x1:=x1+6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round(x1*frX),y+round((y1+65)*frY) ) else     // a gauche
                     LineTo( x+round(x1*frX),y+round((y1-40)*frY) );         // a droite
    end
    else
    begin
      x1:=65;y1:=10;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      x1:=x1+6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round(x1*frX),y+round((y1-57)*frY) ) else
                     LineTo( x+round(x1*frX),y+round((y1+45)*frY) );
    end;
  end;
end;

procedure affiche_pied20_180(index,x,y : integer;FrX,frY : real;piedSignal : integer;contrevoie : boolean);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];

    if contrevoie then
    begin
      x1:=20;y1:=0;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      y1:=y1-6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round((x1-50)*frX),y+round(y1*frY) ) else     // a gauche
                     LineTo( x+round((x1+55)*frX),y+round(y1*frY) );         // a droite
    end
    else
    begin
      x1:=38;y1:=0;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      y1:=y1-6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round((x1-63)*frX),y+round(y1*frY) ) else
                     LineTo( x+round((x1+40)*frX),y+round(y1*frY) );
    end;
  end;
end;

procedure affiche_pied20_vertical(index,x,y : integer;FrX,frY : real;piedSignal : integer;contrevoie : boolean);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];

    if contrevoie then
    begin
      x1:=38;y1:=102;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      y1:=y1+6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round((x1+40)*frX),y+round(y1*frY) ) else
                     LineTo( x+round((x1-65)*frX),y+round(y1*frY) );
    end
    else
    begin
      x1:=18;y1:=102;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      y1:=y1+6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if piedSignal=1 then LineTo( x+round((x1+62)*frX),y+round(y1*frY) ) else
                     LineTo( x+round((x1-40)*frX),y+round(y1*frY) );
    end;
  end;
end;


procedure affiche_pied2G_90G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frYR) );
    if piedSignal=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-50)*frYR) );
  end;
end;

procedure affiche_pied2G_90D(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,frYR: real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=35;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frYR) );
    if piedSignal=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) ) ;
  end;
end;

procedure affiche_pied_Vertical2G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=35;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) );
  end;
end;

procedure affiche_pied3G_90D(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,fryR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=45;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied3G_90G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-4)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1-4)*frX),y+round((y1+50)*frYR) ) else
                   LineTo( x+round((x1-4)*frX),y+round((y1-50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical3G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=42;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) )
             else  LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) ) ;
  end;
end;

procedure affiche_pied4G_90G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    fryR,ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*frYR) ) ;
  end;
end;

procedure affiche_pied4G_90D(index,x,y : integer;FrX,frY : real;piedSignal: integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=55;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) )
                 else LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical4G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=55;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied9G_90D(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    var ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=90;y1:=38;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fryR)) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+40)*fryR));
  end;
end;

procedure affiche_pied5G_90D(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=66;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                      LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied5G_90G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,fryR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical5G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=65;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );

    if piedSignal=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied7G_90D(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=75;y1:=38;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if piedSignal=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fryR) ) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+38)*fryR) ) ;
  end;
end;

procedure affiche_pied7G_90G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Color:=clPiedSignal[index];
    Pen.Width:=2;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frYR) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+60)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-40)*frYR) ) ;
  end;
end;

procedure affiche_pied_Vertical7G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=75;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-40)*frX),y+round((y1+7)*frY) ) ;
  end;
end;

procedure affiche_pied9G_90G(index,x,y : integer;FrX,frY : real;piedSignal : integer);
var x1,y1 : integer;
    frYR,ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO[index] do
  begin
    Pen.Color:=clPiedSignal[index];
    pen.Width:=2;
    x1:=0;y1:=12;
    // segment horizontal
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frYR) );

    if piedSignal=1 then LineTo( x+round((x1-6)*frX),y+round((y1+58)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-40)*frYR) ) ;
  end;
end;

procedure affiche_pied_Vertical9G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=90;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-40)*frX),y+round((y1+7)*frY) ) ;
  end;
end;

procedure Efface_Cellule(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : TPenMode);
var x0,y0 : integer;
    r : TRect;
    c : tcolor;
begin
  {
  if y>1 then
  begin
    // si la cellule au dessus contient un signal vertical, ne pas effacer la cellule
    // if (tco[indextco,x,y-1].BImage=12) and (tco[indextco,x,y-1].FeuOriente=1) then exit;
  end;
  if x<NbreCellX then
  begin
    // si la cellule à gauche contient un feu 90D, ne pas effacer la cellule
    // if (tco[indextco,x-1,y].BImage=12) and (tco[indextco,x-1,y].FeuOriente=3) then exit;
  end;
  }
  if (x>NbreCellX[indexTCO]) or (y>NbreCellY[indexTCO]) or (x<1) or (y<1) then exit;

  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
  c:=tco[indextco,x,y].CouleurFond;

  with canvas do
  begin
    Pen.Mode:=mode;
    Pen.Width:=1;
    Pen.color:=c;;
    Brush.Color:=c;
    Brush.style:=bsSolid;
    fillRect(r);
  end;

  if avecGrille[indexTCO] then
  begin
    canvas.pen.color:=clGrille[indexTCO];
    r:=Rect(x0,y0,x0+LargeurCell[indexTCO]+1,y0+hauteurCell[indexTCO]+1);
    canvas.rectangle(r);
  end;

end;

// Dessine un signal dans le canvasDest en x,y , dont l'adresse se trouve à la cellule x,y
procedure dessin_Signal(indexTCO : integer;CanvasDest : Tcanvas;x,y : integer );
var  index,x0,y0,xp,yp,orientation,adresse,aspect,PiedFeu,TailleX,TailleY,larg,haut : integer;
     ImageFeu : Timage;
     Contrevoie : boolean;
     frX,frY : single;
begin
  if (x>NbreCellX[indexTCO]) or (y>NbreCellY[indexTCO]) or (x<1) or (y<1) or (NbreSignaux=0) then exit;

  larg:=LargeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];

  xp:=(x-1)*larg; // coordonnées cellule
  yp:=(y-1)*haut;
  Adresse:=tco[indextco,x,y].Adresse;

  Orientation:=tco[indextco,x,y].FeuOriente;
  if Orientation=0 then Orientation:=1;  // cas d'un signal non encore renseigné

  index:=Index_Signal(adresse);
  aspect:=Signaux[index].aspect;

  if aspect=0 then aspect:=9;
  //if aspect>9 then exit;
  //Affiche(IntToSTR(i)+' '+intToSTR(aspect),clred);

  case aspect of
  2 :  ImageFeu:=Formprinc.Image2feux;
  3 :  ImageFeu:=Formprinc.Image3feux;
  4 :  ImageFeu:=Formprinc.Image4feux;
  5 :  ImageFeu:=Formprinc.Image5feux;
  7 :  ImageFeu:=Formprinc.Image7feux;
  9 :  ImageFeu:=Formprinc.Image9feux;
  12 : ImageFeu:=Formprinc.Image2Dir;
  13 : ImageFeu:=Formprinc.Image3Dir;
  14 : ImageFeu:=Formprinc.Image4Dir;
  15 : ImageFeu:=Formprinc.Image5Dir;
  16 : ImageFeu:=Formprinc.Image6Dir;
  20 : ImageFeu:=formprinc.ImageSignal20;

  else ImageFeu:=Formprinc.Image9feux;
  end;

  TailleX:=ImageFeu.picture.BitMap.Width;
  TailleY:=ImageFeu.picture.BitMap.Height; // taille du feu d'origine  (verticale)
  PiedFeu:=tco[indextco,x,y].PiedSignal;  // gauche ou droite de la voie

  // réduction variable en fonction de la taille des cellules. 50 est le Zoom Maxi
  calcul_reduction(frx,fry,Larg,haut);

  x0:=0;y0:=0; // pour les signaux directionnels

  // point d'origine dans la cellule du signal
  if orientation=3 then  //90°D
  begin
    if aspect=20 then begin x0:=round(10*frX); y0:=hauteurCell[indexTCO]-round(tailleX*frY);end;
    if aspect=9 then begin x0:=round(10*frX); y0:=hauteurCell[indexTCO]-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=hauteurCell[indexTCO]-round(tailleX*frY);end;
    if aspect=5 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
    if aspect=4 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
    if aspect=3 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
    if aspect=2 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
  end;

  // décalage en X pour mettre la tete du signal alignée sur le bord droit de la cellule pour les signaux tournés à 90G
  if orientation=2 then //90°G
  begin
    if aspect=20 then begin x0:=0; y0:=0;end;
    if aspect=9 then begin x0:=round(10*frX); y0:=hauteurCell[indexTCO]-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=hauteurCell[indexTCO]-round(tailleX*frY);end;
    if aspect=5 then begin x0:=round(10*frX); y0:=round((tailleX/2)*frY);end;
    if aspect=4 then begin x0:=round(10*frX); y0:=round((tailleX/2)*frY);end;
    if aspect=3 then begin x0:=round(8*frX);  y0:=round((tailleX/2)*frY);end;
    if aspect=2 then begin x0:=round(10*frX); y0:=round((tailleX/2)*frY);end;
  end;

  // décalage en X pour rapprocher le signal du le bord droit de la cellule pour les feux verticaux
  if (orientation=1) then
  begin
    if aspect=20 then begin x0:=0; y0:=0; end;
    if aspect=9 then begin x0:=0; y0:=0; end;
    if aspect=7 then begin x0:=0; y0:=0; end;
    if aspect=5 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=4 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=3 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=2 then begin x0:=round(13*frx); y0:=0;end;
  end;

  if orientation=4 then
  begin
    if aspect=2 then begin x0:=round(14*frx);y0:=round(15*fry);end;
    if aspect=3 then begin x0:=round(14*frx);y0:=round(15*fry);end;
    if aspect=4 then begin x0:=round(14*frx);y0:=round(15*fry);end;
    if aspect=5 then begin x0:=round(14*frx);y0:=round(15*fry);end;
    if aspect=7 then begin x0:=round(2*frx);y0:=round(15*fry);end;
    if aspect=9 then begin x0:=round(2*frx);y0:=round(15*fry);end;
  end;

  x0:=x0+xp;y0:=y0+yp;     // coordonnées cellule + décalage
  tco[indextco,x,y].x:=x0;
  tco[indextco,x,y].y:=y0;

  Contrevoie:=Signaux[index].contrevoie;

  // affichage du signal et du pied - orientation verticale
  if (Orientation=1) then
  begin
    // si inversion
    if Signaux[index].contrevoie then
    begin
      inverse_image(FormTCO[indexTCO].ImageTemp,ImageFeu);
      // copie avec mise à l'échelle de l'image du signal
      TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   FormTCO[indexTCO].ImageTemp.Canvas.Handle,0,0,TailleX,TailleY,clBlue);
    end
    else
      // copie avec mise à l'échelle de l'image du signal
      TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   ImageFeu.Canvas.Handle,0,0,TailleX,TailleY,clBlue);

    PImageTCO[indexTCO].Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
    case aspect of
    20 : affiche_pied20_vertical(indexTCO,x0,y0,frX,frY,piedFeu,contrevoie);
    9 : affiche_pied_Vertical9G(indexTCO,x0,y0,frX,frY,piedFeu);
    7 : affiche_pied_Vertical7G(indexTCO,x0,y0,frX,frY,piedFeu);
    5 : affiche_pied_Vertical5G(indexTCO,x0,y0,frX,frY,piedFeu);
    4 : affiche_pied_Vertical4G(indexTCO,x0,y0,frX,frY,piedFeu);
    3 : affiche_pied_Vertical3G(indexTCO,x0,y0,frX,frY,PiedFeu);
    2 : affiche_pied_Vertical2G(indexTCO,x0,y0,frX,frY,PiedFeu);
    end;
  end;

  // affichage du signal et du pied - orientation 90°G
  if Orientation=2 then
  begin
    Signal_90G(indexTCO,ImageFeu,x0,y0,frX,frY,contrevoie); // ici on passe l'origine du signal
    // dessiner le pied
    case aspect of
    20 : affiche_pied20_90G(indexTCO,x0+2,y0+round(fry*5),frX,frY,piedFeu,contrevoie);
    9 : affiche_pied9G_90G(indexTCO,x0,y0,frX,frY,piedFeu);
    7 : affiche_pied7G_90G(indexTCO,x0,y0,frX,frY,piedFeu);
    5 : affiche_pied5G_90G(indexTCO,x0,y0,frX,frY,piedFeu);
    4 : affiche_pied4G_90G(indexTCO,x0,y0,frX,frY,piedFeu);
    3 : affiche_pied3G_90G(indexTCO,x0,y0,frX,frY,piedFeu);
    2 : affiche_pied2G_90G(indexTCO,x0,y0,frX,frY,piedFeu);
    end;
  end;

  // affichage du signal et du pied - orientation 90°D
  if Orientation=3 then
  begin
    Signal_90D(indexTCO,ImageFeu,x0,y0,frX,frY,contrevoie);
    // dessiner le pied
    case aspect of
    20 : affiche_pied20_90D(indexTCO,x0+(LargeurCell[indexTCO] div 2)+round(frx*12),y0+(hauteurCell[indexTCO] div 2),frX,frY,piedFeu,contrevoie);
    9 : affiche_pied9G_90D(indexTCO,x0,y0,frX,frY,piedFeu);
    7 : affiche_pied7G_90D(indexTCO,x0,y0,frX,frY,piedFeu);
    5 : affiche_pied5G_90D(indexTCO,x0,y0,frX,frY,piedFeu);
    4 : affiche_pied4G_90D(indexTCO,x0,y0,frX,frY,piedFeu);
    3 : affiche_pied3G_90D(indexTCO,x0,y0,frX,frY,PiedFeu);
    2 : affiche_pied2G_90D(indexTCO,x0,y0,frX,frY,PiedFeu);
    end;
  end;

  // 180°
  if orientation=4 then
  begin
    Signal_180(indexTCO,ImageFeu,x0,y0,frX,frY,contrevoie);
    case aspect of
    2 : affiche_pied2_180(indexTCO,x0,y0,frX,frY,PiedFeu);
    3 : affiche_pied3_180(indexTCO,x0,y0,frX,frY,PiedFeu);
    4 : affiche_pied4_180(indexTCO,x0,y0,frX,frY,PiedFeu);
    5 : affiche_pied5_180(indexTCO,x0,y0,frX,frY,PiedFeu);
    7 : affiche_pied7_180(indexTCO,x0,y0,frX,frY,PiedFeu);
    9 : affiche_pied9_180(indexTCO,x0,y0,frX,frY,PiedFeu);
    20 : affiche_pied20_180(indexTCO,x0,y0,frX,frY,PiedFeu,contrevoie);
    end;
  end;

  // allumage des feux du signal -----------------
  dessine_signal_mx(canvasDest,x0,y0,frX,frY,adresse,orientation);
end;


// dessine l'icone n° Bimage dans le canvas PcanvasTCO, aux coordonnées cellules x,y en mode
procedure dessine_icone(indexTCO : integer;PCanvasTCO : tcanvas;Bimage,X,Y,mode : integer);
begin
  case Bimage of
   // 0 : efface_cellule(PCanvasTCO,x,y,pmcopy);
    1 : dessin_1(indexTCO,PCanvasTCO,X,Y,mode);
    2 : dessin_2(indexTCO,PCanvasTCO,X,Y,mode);
    3 : dessin_3(indexTCO,PCanvasTCO,X,Y,mode);
    4 : dessin_4(indexTCO,PCanvasTCO,X,Y,Mode);
    5 : dessin_5(indexTCO,PCanvasTCO,X,Y,Mode);
    6 : dessin_6(indexTCO,PCanvasTCO,X,Y,Mode);
    7 : dessin_7(indexTCO,PCanvasTCO,X,Y,Mode);
    8 : dessin_8(indexTCO,PCanvasTCO,X,Y,Mode);
    9 : dessin_9(indexTCO,PCanvasTCO,X,Y,mode);
   10 : dessin_10(indexTCO,PCanvasTCO,X,Y,mode);
   11 : dessin_11(indexTCO,PCanvasTCO,X,Y,mode);
   12 : dessin_12(indexTCO,PCanvasTCO,X,Y,mode);
   13 : dessin_13(indexTCO,PCanvasTCO,X,Y,mode);
   14 : dessin_14(indexTCO,PCanvasTCO,X,Y,mode);
   15 : dessin_15(indexTCO,PCanvasTCO,X,Y,mode);
   16 : dessin_16(indexTCO,PCanvasTCO,X,Y,mode);
   17 : dessin_17(indexTCO,PCanvasTCO,X,Y,mode);
   18 : dessin_18(indexTCO,PCanvasTCO,X,Y,mode);
   19 : dessin_19(indexTCO,PCanvasTCO,X,Y,mode);
   20 : dessin_20(indexTCO,PCanvasTCO,X,Y,mode);
   21 : dessin_21(indexTCO,PCanvasTCO,X,Y,mode);
   22 : dessin_22(indexTCO,PCanvasTCO,X,Y,mode);
   23 : dessin_23(indexTCO,PCanvasTCO,X,Y,mode);
   24 : dessin_24(indexTCO,PCanvasTCO,X,Y,mode);
   25 : dessin_25(indexTCO,PCanvasTCO,X,Y,mode);
   26 : dessin_26(indexTCO,PCanvasTCO,X,Y,mode);
   27 : dessin_27(indexTCO,PCanvasTCO,X,Y,mode);
   28 : dessin_28(indexTCO,PCanvasTCO,X,Y,mode);
   29 : dessin_29(indexTCO,PCanvasTCO,X,Y,mode);
   32 : dessin_32(indexTCO,PCanvasTCO,X,Y,mode);
   33 : dessin_33(indexTCO,PCanvasTCO,X,Y,mode);
   34 : dessin_34(indexTCO,PCanvasTCO,X,Y,mode);

   Id_signal : dessin_Signal(indexTCO,PCanvasTCO,X,Y);
   Id_Quai   : dessin_Quai(indexTCO,PCanvasTCO,X,Y,mode);
   Id_action : dessin_Action(indexTCO,PCanvasTCO,X,Y);

   // les cantons sont affichés dans affiche_cellule car il faut dessiner les trains
   end;
end;

procedure origine_canton(var x,y : integer);
var Bimage : integer;
begin
  Bimage:=tco[indexTCOCourant,x,y].BImage;
  if isCantonH(Bimage) then
  begin
    x:=x-(Bimage-Id_cantonH);    // revenir à la coordonnée X du début du canton
  end
  else
  if isCantonV(Bimage) then
  begin
    y:=y-(Bimage-Id_cantonV);    // revenir à la coordonnée Y du début du canton
  end
  else
  begin
    x:=0;y:=0;
  end;
end;


// affiche la cellule x et y en cases
// index est utilisé pour accéder au tableau du tracé de la fonction zone_tco
procedure affiche_cellule(indexTCO,x,y : integer);
var i,index,repr,Xorg,Yorg,xt,yt,mode,adresse,Bimage,aspect,oriente,pied,AdrTr,
    HautCell,LargCell : integer;
    typ : tequipement;
    inverse : boolean;
    s : string;
    clfond : tcolor;
begin
  if indexTCO=0 then exit;
  if indexTCO>nbreTCO then
  begin
    Affiche('Erreur 269',clred);
    exit;
  end;
  if PcanvasTCO[indexTCO]=nil then exit;

  //Affiche('Affiche_cellule',clLime);
  PcanvasTCO[indexTCO].pen.Mode:=PmCopy;
  //pcanvasTCO.Brush.Style:=BsClear;
  adresse:=tco[indextco,x,y].Adresse;
  BImage:=tco[indextco,x,y].BImage;
  mode:=tco[indextco,x,y].mode; // mode pour la couleur
  clFond:=tco[indextco,x,y].CouleurFond;
  repr:=tco[indextco,x,y].repr;
  Epaisseur:=LargeurCell[indexTCO]*epaisseur_voies div 30;
  HautCell:=hauteurCell[indexTCO];
  largCell:=LargeurCell[indexTCO];
  if not NB then clFond:=tco[indextco,x,y].CouleurFond else clFond:=clWhite;
  Xorg:=(x-1)*LargCell;
  Yorg:=(y-1)*HautCell;

  // affiche d'abord l'icone de la cellule et colore la voie si zone ou détecteur actionnée selon valeur mode
  dessine_icone(indexTCO,PCanvasTCO[indexTCO],Bimage,X,Y,mode);
  // dessin du train sur le canton
    if (Bimage=Id_CantonH) or (Bimage=Id_CantonV) then dessin_canton(indexTCO,PCanvasTCO[indexTCO],x,y,0);


  if LargCell>24 then
  begin
    with PCanvasTCO[indexTCO] do
    begin
      Brush.Color:=clFond;
      font.Size:=((LargCell*6) div 30)+1;             //((LargCell*5) div 29);
      if NB then font.color:=clBlack else
        Font.Color:=tco[indextco,x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[indextco,x,y].FontStyle);
    end;


    // ------------- affichage de l'adresse ------------------
    //s:=IntToSTR(adresse);
    s:=format('%d',[adresse]);

    // affiche le texte des aiguillages
    if IsAigTJDCroiTCO(Bimage) and (adresse<>0) then
    begin
      if adresse<>0 then s:='A'+s+' ' else s:=' ';
      with PCanvasTCO[indexTCO] do
      begin
        // si réservation par train
        i:=index_aig(adresse);
        AdrTr:=aiguillage[i].AdrTrain;
        typ:=aiguillage[i].modele;

        if AdrTr=0 then
        begin
          if not NB then Brush.Color:=tco[indextco,x,y].CouleurFond else Brush.color:=clwhite;
          //SetBkMode(PCanvasTCO[indexTCO].Handle,TRANSPARENT);
         if roulage then s:=s+'  '; // efface l'adresse de réservation
        end
        else
        begin
          // couleur de fond de la réservation
          Brush.style:=bsSolid;
          Brush.Color:=clBlue;
          //s:=s+intToSTR(AdrTr);
          s:=s+format('%d',[adrTr]);
          //SetBkMode(PCanvasTCO[indexTCO].Handle,OPAQUE);
        end;

        //Brush.Style:=Bsclear;

        xt:=0;yt:=0;
        if Bimage=2  then begin xt:=LargeurCell[indexTCO] div 2;yt:=1;end;
        if Bimage=3  then begin xt:=3;yt:=hauteurCell[indexTCO]-round(18*fryGlob[indexTCO]);end;
        if Bimage=4  then begin xt:=10*round(frxGlob[indexTCO]);yt:=1;end;
        if Bimage=5  then begin xt:=3;yt:=hauteurCell[indexTCO]-round(18*fryGlob[indexTCO]);end;
        if Bimage=12 then begin xt:=round(35*frxGlob[indexTCO]);yt:=2;end;
        if Bimage=13 then begin xt:=LargeurCell[indexTCO]-round(30*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
        if Bimage=14 then begin xt:=LargeurCell[indexTCO]-round(30*frxGlob[indexTCO]);yt:=1;end;
        if Bimage=15 then begin xt:=3;yt:=1;end;
        if Bimage=21 then begin xt:=-round(5*frxGlob[indexTCO]);yt:=0;end;
        if Bimage=22 then begin xt:=(LargeurCell[indexTCO] div 2);yt:=-2;end;
        if Bimage=23 then begin xt:=round(33*frxGlob[indexTCO]);yt:=round(35*fryGlob[indexTCO]);end;
        if Bimage=24 then begin xt:=LargeurCell[indexTCO]-round(20*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
        if Bimage=25 then begin xt:=round(34*frxGlob[indexTCO]);yt:=round(8*fryGlob[indexTCO]);end;
        if Bimage=26 then begin xt:=round(35*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
        if Bimage=27 then begin xt:=3;yt:=1;end;
        if Bimage=28 then begin xt:=round(35*frxGlob[indexTCO]);yt:=1;end;
        if Bimage=29 then begin xt:=LargeurCell[indexTCO] div 2;yt:=1;end;
        if Bimage=32 then begin xt:=3;yt:=1;end;
        if Bimage=33 then begin xt:=3;yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
        if Bimage=34 then begin xt:=LargeurCell[indexTCO]-round(30*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+xt,yOrg+yt,s);
      end;
    end;

    // détecteurs voie horizontale
    if ((BImage=1) ) and (adresse<>0) then
    begin // Adresse de l'élément
     xt:=3;
     if repr<>0 then
      with PCanvasTCO[indexTCO] do
      begin
        if not NB then Brush.Color:=tco[indextco,x,y].CouleurFond else Brush.Color:=clwhite;
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        Font.Name:='Arial';
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        xt:=round(6*frxGlob[indexTCO]);
        case repr of
        1 : yt:=(hauteurCell[indexTCO] div 2)-round(7*fryGlob[indexTCO]);   // milieu
        2 : yt:=2;  // haut
        3 : yt:=hauteurCell[indexTCO]-round(17*fryGlob[indexTCO]);   // bas
        end;

      {
      // affiche/efface le nom du train du détecteur
      s:=s+'        ';
      case repr of
            1,3 : yt:=1;  // haut
            2 : yt:=hauteurCell[indexTCO]-round(17*fryGlob[indexTCO]);   // bas
      end;
      }

      {i:=detecteur[adresse].AdrTrain;
      if i<>0 then
      begin
        i:=index_train_adresse(i);   // trouve le nom du train par son adresse
        if i<>0 then s:=s+' '+trains[i].nom_train;
      end
      else if roulage then s:=s+'                         ';
      }
      //PCanvasTCO[indexTCO].font.Size:=(LargeurCell[indexTCO] div 13)+4  ;
        AdrTr:=detecteur[adresse].AdrTrainRes;
        if AdrTr<>0 then
        begin
          Brush.style:=bsSolid;
          Brush.Color:=clBlue;
          s:=s+' '+format('%d',[adrTr]);
        end
        else
        begin
          Brush.style:=bsSolid;
          Brush.Color:=clfond;
          Pen.color:=clfond;
          pen.mode:=PmCopy;
          pen.Width:=1;
          rectangle(xOrg+xt,Yorg+yt-1,xOrg+LargCell-1,Yorg+yt+round(17*fryGlob[indexTCO]));
        end;
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+xt,Yorg+yt,s);
      end;
    end;

    if ((Bimage=8) or (Bimage=10)   ) and (adresse<>0) then
    begin
      with PCanvasTCO[indexTCO] do
      begin
        xt:=round(25*frxGlob[indexTCO]);
        yt:=round(35*fryGlob[indexTCO]);
        Font.Name:='Arial';
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        AdrTr:=detecteur[adresse].AdrTrainRes;
        if AdrTr<>0 then
        begin
          Brush.style:=bsSolid;
          Brush.Color:=clBlue;
          //s:=s+' '+intToSTR(AdrTr);
          s:=s+' '+format('%d',[adrTr]);
        end
        else
        begin
          Brush.style:=bsSolid;
          Brush.Color:=clfond;
          Pen.color:=clfond;
          pen.mode:=PmCopy;
          pen.Width:=1;
          rectangle(xOrg+xt,Yorg+yt,xOrg+LargCell,Yorg+yt+11);
        end;
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+xt,yOrg+yt,s);
      end;
    end;

    // autres détecteurs
    if ((Bimage=7) or (Bimage=9) or (Bimage=17) ) and (adresse<>0) then
    begin // Adresse de l'élément
      with PCanvasTCO[indexTCO] do
      begin
        xt:=round(2*frxGlob[indexTCO]);
        yt:=round(2*fryGlob[indexTCO]);
        Font.Name:='Arial';
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        AdrTr:=detecteur[adresse].AdrTrainRes;
        if AdrTr<>0 then
        begin
          Brush.style:=bsSolid;
          if not NB then Brush.Color:=clBlue else Brush.color:=clwhite;
          s:=s+' '+format('%d',[adrTr]);
        end
        else
        begin
          Brush.style:=bsSolid;
          Brush.Color:=clfond;
          Pen.color:=clfond;
          pen.mode:=PmCopy;
          pen.Width:=1;
          rectangle(xOrg+xt,Yorg+yt,xOrg+LargCell,Yorg+yt+11);
        end;
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+xt,yOrg+yt,s);
      end;
    end;

    // écriture adresse à 90°
    if (Bimage=20) and (adresse<>0) then
    begin
      with PCanvasTCO[indexTCO] do
      begin
        Font.Name:='Arial';
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        AdrTr:=detecteur[adresse].AdrTrainRes;
        if (AdrTr<>0) then
        begin
          Brush.style:=bsSolid;
          if not NB then clfond:=clBlue else clfond:=clwhite;
          //s:=s+' '+intToSTR(AdrTr);
          s:=s+' '+format('%d',[adrTr]);
        end;

        //PCanvasTCO[indexTCO].font.Size:=taille_fonte(; //PCanvasTCO[indexTCO].font.Size+1;
        xt:=Xorg-1;
        yt:=yOrg+HautCell-round(2*fryGlob[indexTCO]);
        {$IF CompilerVersion >= 28.0}
        font.orientation:=900;
        Textout(xt,yt,s);
        {$ELSE}
        AffTexteIncliBordeTexture(PCanvasTCO[indexTCO],xt,yt,
                                  PCanvasTCO[indexTCO].Font,clYellow,0,pmcopy,s+'   ',900);
        {$IFEND}
      end;
    end;

    // autres détecteurs
    if ((Bimage=18) or (Bimage=19)) and (adresse<>0) then
    begin // Adresse de l'élément
      with PCanvasTCO[indexTCO] do
      begin
        if not NB then Brush.Color:=tco[indextco,x,y].CouleurFond else Brush.color:=clwhite;
        Font.Name:='Arial';
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+round(20*frxGlob[indexTCO]),yOrg+hauteurCell[indexTCO]-round(14*fryGlob[indexTCO]),s);
      end;
    end;

    // autres détecteurs
    if ((Bimage=6) or (Bimage=11) or (Bimage=16)) and (adresse<>0) then
    begin // Adresse de l'élément
      with PCanvasTCO[indexTCO] do
      begin
        if not NB then Brush.Color:=tco[indextco,x,y].CouleurFond else Brush.color:=clwhite;
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        Font.Name:='Arial';
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+round(28*frxGlob[indexTCO]),yOrg+round(2*fryGlob[indexTCO]),s);
        //exit;
      end;
    end;

    // adresse des signaux
    if (BImage=Id_signal) and (adresse<>0) then
    begin
      index:=Index_Signal(adresse);
      aspect:=Signaux[index].Aspect;
      oriente:=tco[indextco,x,y].FeuOriente;
      pied:=tco[indextco,x,y].PiedSignal;
      inverse:=Signaux[index].contrevoie;    // pour signal belge
      xt:=0;yt:=0;
      // signal belge
      if (aspect=20) then
      begin
        if (Oriente=1) then
        begin
          if inverse then begin xt:=2;yt:=2*hauteurCell[indexTCO]-round(16*fryGlob[indexTCO]);end
          else
          begin xt:=(LargeurCell[indexTCO] div 2)+round(5*frxGlob[indexTCO]);yt:=2*hauteurCell[indexTCO]-round(20*fryGlob[indexTCO]); end;
        end;
        if (Oriente=2) then
        begin
          if inverse then begin xt:=round(20*frxGlob[indexTCO]);yt:=round(3*fryGlob[indexTCO]);end
          else
          begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(16*fryGlob[indexTCO]);end;
        end;
        if (Oriente=3) then
        begin
          if inverse then begin xt:=round(10*frxGlob[indexTCO]);yt:=round(50*frxGlob[indexTCO]);end
          else begin xt:=round(60*frxGlob[indexTCO]);yt:=round(1*frxGlob[indexTCO])end;
        end;
        if (oriente=4) then
        begin
          if inverse then begin xt:=round(40*frxGlob[indexTCO]);yt:=round(40*fryGlob[indexTCO]);end
          else begin xt:=round(2*frxGlob[indexTCO]);yt:=round(10*fryGlob[indexTCO]);end;
        end;
      end;
      if (aspect=9) and (Oriente=1) then begin xt:=LargeurCell[indexTCO]-round(25*frxGlob[indexTCO]);yt:=round(60*fryGlob[indexTCO]);end;
      if (aspect=9) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(17*fryGlob[indexTCO]);end;    // orientation G
      if (aspect=9) and (Oriente=3) then begin xt:=LargeurCell[indexTCO]+round(20*frxGlob[indexTCO]);yt:=round(10*frYGlob[indexTCO]);end;
      if (aspect=9) and (Oriente=4) and (pied=1) then begin xt:=round(2*frxGlob[indexTCO]);yt:=round(10*frYGlob[indexTCO]);end;
      if (aspect=9) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;

      if (aspect=7) and (Oriente=1) then begin xt:=LargeurCell[indexTCO]-round(25*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO];end;
      if (aspect=7) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(25*fryGlob[indexTCO]);end;
      if (aspect=7) and (Oriente=3) then begin xt:=LargeurCell[indexTCO]+2;yt:=round(4*frYGlob[indexTCO]);end;
      if (aspect=7) and (Oriente=4) and (pied=1) then begin xt:=round(2*frxGlob[indexTCO]);yt:=round(10*frYGlob[indexTCO]);end;
      if (aspect=7) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;

      if (aspect=5) and (Oriente=1) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]+round(25*fryGlob[indexTCO]);end;
      if (aspect=5) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO] ;end;
      if (aspect=5) and (Oriente=3) then begin xt:=round(10*frxGlob[indexTCO]);yt:=-round(14*fryGlob[indexTCO]);end;
      if (aspect=5) and (Oriente=4) and (pied=1) then begin xt:=round(35*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;
      if (aspect=5) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;

      if (aspect=4) and (Oriente=1) then begin xt:=1;yt:=hauteurCell[indexTCO]+round(20*fryGlob[indexTCO]);end;
      if (aspect=4) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO];end;
      if (aspect=4) and (Oriente=3) then begin xt:=round(10*frxGlob[indexTCO]);yt:=-round(14*fryGlob[indexTCO]);end;
      if (aspect=4) and (Oriente=4) and (pied=1) then begin xt:=round(35*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;
      if (aspect=4) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;

      if (aspect=3) and (Oriente=1) and (pied=2) then begin xt:=round(-15*frxGlob[indexTCO]);yt:=1;end;  // signal à droite
      if (aspect=3) and (Oriente=1) and (pied=1) then begin xt:=round(45*frxGlob[indexTCO]);yt:=1;end;  // signal à gauche
      if (aspect=3) and (Oriente=2) and (pied=1) then begin xt:=round(10*frxGlob[indexTCO]);yt:=round(40*fryGlob[indexTCO]);end;   // signal à G
      if (aspect=3) and (Oriente=2) and (pied=2) then begin xt:=round(20*frxGlob[indexTCO]);yt:=0;end;   // signal à droite
      if (aspect=3) and (Oriente=3) then begin xt:=round(40*frxGlob[indexTCO]);yt:=round(36*fryGlob[indexTCO]);end;
      if (aspect=3) and (Oriente=4) and (pied=1) then begin xt:=round(35*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;
      if (aspect=3) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;

      if (aspect=2) and (Oriente=1) and (pied=2) then begin xt:=round(-15*frxGlob[indexTCO]);yt:=1;end;  // signal à droite
      if (aspect=2) and (Oriente=1) and (pied=1) then begin xt:=round(45*frxGlob[indexTCO]);yt:=1;end;  // signal à gauche
      if (aspect=2) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO];end;  // orientation G
      if (aspect=2) and (Oriente=3) then begin xt:=round(20*frxGlob[indexTCO]);yt:=round(40*fryGlob[indexTCO]);end;  // orientation D
      if (aspect=2) and (Oriente=4) then begin xt:=round(40*frxGlob[indexTCO]);yt:=round(10*fryglob[indexTCO]);end;  // orientation 180

      // signaux directionnels
      if (aspect>10) and (aspect<20) and (oriente=1) then begin xt:=1;yt:=hauteurCell[indexTCO]-round(14*fryGlob[indexTCO]);end;
      if (aspect>10) and (aspect<20) and (oriente=2) then begin xt:=LargeurCell[indexTCO]-round(15*frxGlob[indexTCO]);yt:=0;end;
      if (aspect>10) and (aspect<20) and (oriente=3) then begin xt:=LargeurCell[indexTCO]-round(15*frxGlob[indexTCO]);yt:=0;end;

      with PCanvasTCO[indexTCO] do
      begin
        if not NB then Brush.Color:=tco[indextco,x,y].CouleurFond else Brush.color:=clwhite;
        if NB then font.color:=clblack else
          Font.Color:=tco[indextco,x,y].coulFonte;
        //Font.Style:=style(tco[indextco,x,y].FontStyle);
        Font.Name:='Arial';
        {$IF CompilerVersion >= 28.0}
        font.orientation:=0;
        {$IFEND}
        TextOut(xOrg+xt,yOrg+yt,s);
      end;
    end;
  end;
end;

procedure entoure_cell_grille(indexTCO,x,y : integer);
// redessine le carré de grille de la cellule qui a été altéré par la mise à
// jour de la cellule
var Xorg,Yorg : integer;
begin;
  if not(AvecGrille[indexTCO]) then exit;
  Xorg:=(x-1)*LargeurCell[indexTCO];
  Yorg:=(y-1)*HauteurCell[indexTCO];
  if PcanvasTCO[indexTCO]<>nil then
  With PcanvasTCO[indexTCO] do
  begin
    Pen.Color:=clGrille[IndexTCO];
    Pen.mode:=PmCopy;
    Pen.width:=1;
    MoveTo(Xorg,YOrg);
    LineTo(Xorg+LargeurCell[indexTCO],YOrg);
    LineTo(Xorg+LargeurCell[indexTCO],YOrg+HauteurCell[indexTCO]);
    LineTo(Xorg,YOrg+HauteurCell[indexTCO]);
    LineTo(Xorg,YOrg);
  end;
end;

procedure Entoure_cell(indexTCO,x,y : integer);
var r : Trect;
    x0,y0 : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  with PcanvasTCO[indexTCO] do
  begin
    Pen.width:=3;
    Pen.Color:=clyellow;
    Brush.Color:=clBlack;
    Brush.Style:=bsSolid;
    Pen.Mode:=PmXor;
    r:=Rect(x0,y0,x0+LargeurCell[indexTCO],y0+hauteurCell[indexTCO]);
    Rectangle(r);
    Pen.width:=1;
    Pen.Mode:=PmCopy;
  end;
end;

procedure efface_entoure(indexTCO : integer);
begin
  if (entoure[indexTCO]) then
  begin
    Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);
    entoure[indexTCO]:=false;
  end
end;

procedure _entoure_cell_clic(indexTCO: integer);
begin
  // si entoure pas affiché
  if not(entoure[indexTCO]) then
  begin
    Entoure_cell(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
    Xentoure[indexTCO]:=XClicCell[indexTCO];
    Yentoure[indexTCO]:=YclicCell[indexTCO];
    entoure[indexTCO]:=true;
    exit;
  end
  else
  begin
    // si entoure affiché
    Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);   // efface l'ancien
    // si on clique sur une cellule différente affiche un nouveau
    if (Xentoure[indexTCO]<>XclicCell[indexTCO]) or (Yentoure[indexTCO]<>YClicCell[indexTCO]) then
    begin
      Entoure_cell(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
      Xentoure[indexTCO]:=XClicCell[indexTCO];
      Yentoure[indexTCO]:=YclicCell[indexTCO];
      exit;
    end
    else
    // on a cliqué sur ancien
    entoure[indexTCO]:=false;
    Xentoure[indexTCO]:=XClicCell[indexTCO];
    Yentoure[indexTCO]:=YclicCell[indexTCO];
  end;
end;

// affiche le tco "index"
procedure Affiche_TCO(indexTCO : integer) ;
var Bim,x,y,x1,y1,DimX,DimY : integer;
    s : string;
    r : Trect;
begin
  if affevt then affiche('Affiche_tco',clLime);
  if indexTCO>nbreTCO then
  begin
    Affiche('Erreur 267',clred);
    exit;
  end;
  if pImageTCO[indexTCO]=nil then exit;
  DimX:=LargeurCell[indexTCO]*NbreCellX[indexTCO];
  DimY:=hauteurCell[indexTCO]*NbreCellY[indexTCO];
  Epaisseur:=LargeurCell[indexTCO]*epaisseur_voies div 30;
  // DimX DimY maxi 8191 pixels pour les bitmap
  if (dimX>8192) then begin Affiche('Espace TCO X trop grand',clred); exit; end;
  if (dimY>8192) then begin Affiche('Espace TCO Y trop grand',clred); exit; end;

  PImageTCO[indexTCO].Height:=DimY;
  PImageTCO[indexTCO].Width:=DimX;

  ClBarriere[indexTCO]:=not(clfond[indexTCO]) and $FFFFFF;

  PBitMapTCO[indexTCO].Height:=DimY;
  PBitMapTCO[indexTCO].Width:=DimX;

  with formTCO[indexTCO].ScrollBox do
  begin
    HorzScrollBar.Range:=DimX;
    HorzScrollBar.Tracking:=true;
    HorzScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si on clique sur la trackbar!!
    VertScrollBar.Range:=DimY;
    VertScrollBar.Tracking:=true;
    VertScrollBar.Smooth:=false;
  end;

  calcul_reduction(frxGlob[indexTCO],fryGlob[indexTCO],LargeurCell[indexTCO],hauteurCell[indexTCO]);
  //Affiche(formatfloat('0.000000',frxGlob[indexTCO]),clyellow);

  //effacer toutes cellules par cellule car chaque cellule a une couleur de fond spécifique
  with PcanvasTCO[indexTCO] do
  begin
    Pen.width:=1;
    Brush.Style:=bsSolid;
    pen.color:=clyellow;
    pen.Mode:=PmCopy;

    for y:=1 to NbreCellY[indexTCO] do
      for x:=1 to NbreCellX[indexTCO] do
      begin
        x1:=(x-1)*LargeurCell[indexTCO];
        y1:=(y-1)*hauteurCell[indexTCO];
        if not NB then brush.Color:=tco[indextco,x,y].CouleurFond else brush.color:=clWhite;

        r:=rect(x1,y1,x1+LargeurCell[indexTCO],y1+hauteurCell[indexTCO]);
        FillRect(r);
      end;
  end;

  // afficher la grille
  if AvecGrille[indexTCO] then
  begin
    y1:=HauteurCell[IndexTCO]*NbreCellY[indexTCO];
    with PcanvasTCO[indexTCO] do pen.color:=clGrille[IndexTCO];

    //Affiche(intToSTr(clGrille[IndexTCO]),clred);
    with PcanvasTCO[indexTCO] do
    begin
      for x:=1 to NbreCellX[indexTCO] do
      begin
        x1:=(x-1)*largeurCell[indexTCO];
        moveto(x1,0);LineTo(x1,y1);           // lignes verticales
      end;
      x1:=LargeurCell[IndexTCO]*NbreCellX[indexTCO];
      for y:=1 to NbreCellY[indexTCO] do
      begin
        y1:=(y-1)*HauteurCell[indexTCO];
        moveto(0,y1);LineTo(x1,y1);           // lignes horizontales
      end;
    end;
  end;

  //afficher les cellules sauf les signaux et les cantons
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        Bim:=tco[indextco,x,y].BImage;
        if (Bim<>Id_signal) and (Bim<>Id_CantonH) and (Bim<>Id_CantonV) then
        begin
          affiche_cellule(indexTCO,x,y);
        end;
      end;

  //afficher les cellules des signaux et des cantons et les textes pour que les pieds recouvrent le reste et afficher les textes
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        Bim:=tco[indextco,x,y].BImage;
        if (Bim=Id_signal) or (Bim=Id_CantonH) or (Bim=Id_CantonV) then
        begin
          affiche_cellule(indexTCO,x,y);
        end;

        //Affiche(intToSTR(indexTCO)+' '+intToSTR(x)+' '+intToSTR(y),clred);
        s:=tco[indextco,x,y].Texte;
        if s<>'' then
        begin
          if (bim<>Id_cantonV) and (Bim<>id_cantonH) then Affiche_texte(indexTCO,x,y);
        end;
      end;

  //afficher les cellules vides qui ont un encadré
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        Bim:=tco[indextco,x,y].BImage;
        if (bim=0) and (tco[indextco,x,y].buttoir<>0) then affiche_cellule(indexTCO,x,y);
      end;

  // afficher les sélections si elles sont présentes
  if entoure[indexTCO] then Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);
  if (rect_select.NumTCO<>0) and (IndexTCO=rect_select.NumTCO) then Affiche_Rectangle(IndexTCO,Rect_select);    // rectangle graphique
  if selectionaffichee[indexTCO] then Affiche_selection(indexTCO);
end;


procedure TFormTCO.FormCreate(Sender: TObject);
var s : string;
begin
  NB:=false; // mode noir et blanc pour l'affichage
  if jeucouleurs=0 then JeuCouleurs:=1; // style de couleur sombre par défaut
  clicsouris:=false;
  if affevt or (debug=1) then Affiche('FormTCO'+intToSTR(indexTCOCreate)+' create',clLime);
  procetape('Création fenêtre TCO');
  //Screen.OnActiveControlChange := ActiveControlChanged;

  {$IF CompilerVersion >= 28.0}
  BallonHint:=TballoonHint.Create(self);
  with BallonHint do
  begin
    parent:=self;
    name:='BallonHint';
  end;
  {$IFEND}

  ModeSlection1.checked:=false;
  ModeDplacement1.Checked:=true;
  modeGlisse:=true;
  affPosFil:=true;
  visible:=false;  // ne s'affiche pas par défaut et évite l'effet fenetre fantome.
  ClTexte:=$00FF00;
  IdCantonSelect:=0;
  indexTrainFR:=0;
  PCanvasTCO[indexTCOCreate]:=nil;
  offsetSourisY:=-10; // permet de tenir l'icone au milieu quand on fait un glisser
  offsetSourisX:=-10;
  RadioGroupSel.ItemIndex:=0;
  ligne_supprime:=0;
  colonne_supprime:=0;
  auto_tcurs:=true;
  TCO_modifie:=false;
  rangUndo:=1;
  epaisseur_voies:=5;
  XclicCell[indexTCOCreate]:=1;
  YclicCell[indexTCOCreate]:=1;
  TamponTCO_org.Xorg:=0;
  TamponTCO_org.Yorg:=0;
  indexTrace:=0;
  KeyPreview:=true; // valide les évènements clavier
  TrackBarZoom.Tabstop:=false;     // permet d'avoir les evts curseurs
  ButtonSauveTCO.TabStop:=false;
  ButtonConfigTCO.TabStop:=false;
  ButtonRaz.TabStop:=false;
  ButtonDessiner.TabStop:=false;
  SelecBouge:=false;
  //TrackBarZoom.position:=78;

  ImageTemp2.Width:=500;
  ImageTemp2.Height:=500;
  ImageTemp.Width:=500;
  ImageTemp.Height:=500;

  couleurAdresse:=clCyan;
  xMiniSel:=99999;yMiniSel:=99999;   // coordonnées cellules
  xMaxiSel:=0;yMaxiSel:=0;
  SelectionAffichee[indexTCOCreate]:=false;
  //ImageTCO.Canvas.font.Name:='Arial';  //<--- peut générer exception out of ressource!!
  clTexte:=ClLime;
  // évite le clignotement pendant les affichages mais ne marche pas
  //DoubleBuffered:=true;
  comborepr.Enabled:=false;
  // pour imageTCO incluse dans la scollbox: mettre autosize à true, et ne pas mettre align à alclient.
  // c'est pour éviter le clignotement lors du glisser déposer des icones.
  with imageTCO do
  begin
    AutoSize:=true;
    align:=alNone;
    Top:=0;
    Left:=0;
  end;
  oldbmp:=Tbitmap.Create;
  oldbmp.width:=300;
  oldbmp.Height:=300;

  modeTrace[indexTCOCreate]:=false;   // pour tracer les voies à la souris
  //controlStyle:=controlStyle+[csOpaque];

  s:='Voie';
  ImagePalette6.Hint:=s;ImagePalette6.ShowHint:=true;
  ImagePalette7.Hint:=s;ImagePalette7.ShowHint:=true;
  ImagePalette8.Hint:=s;ImagePalette8.ShowHint:=true;
  ImagePalette9.Hint:=s;ImagePalette9.ShowHint:=true;
  ImagePalette16.Hint:=s;ImagePalette16.ShowHint:=true;
  ImagePalette17.Hint:=s;ImagePalette17.ShowHint:=true;
  ImagePalette18.Hint:=s;ImagePalette18.ShowHint:=true;
  ImagePalette19.Hint:=s;ImagePalette19.ShowHint:=true;

  s:='Voie pouvant porter un détecteur ou buttoir';
  ImagePalette1.Hint:=s;ImagePalette1.ShowHint:=true;
  ImagePalette10.Hint:=s;ImagePalette10.ShowHint:=true;
  ImagePalette11.Hint:=s;ImagePalette11.ShowHint:=true;
  ImagePalette20.Hint:=s;ImagePalette20.ShowHint:=true;

  s:='Aiguillage';
  ImagePalette2.Hint:=s;ImagePalette2.ShowHint:=true;
  ImagePalette3.Hint:=s;ImagePalette3.ShowHint:=true;
  ImagePalette4.Hint:=s;ImagePalette4.ShowHint:=true;
  ImagePalette5.Hint:=s;ImagePalette5.ShowHint:=true;
  ImagePalette12.Hint:=s;ImagePalette12.ShowHint:=true;
  ImagePalette13.Hint:=s;ImagePalette13.ShowHint:=true;
  ImagePalette14.Hint:=s;ImagePalette14.ShowHint:=true;
  ImagePalette15.Hint:=s;ImagePalette15.ShowHint:=true;
  ImagePalette24.Hint:=s;ImagePalette24.ShowHint:=true;
  ImagePalette26.Hint:=s;ImagePalette26.ShowHint:=true;
  ImagePalette27.Hint:=s;ImagePalette27.ShowHint:=true;
  ImagePalette28.Hint:=s;ImagePalette28.ShowHint:=true;
  ImagePalette29.Hint:=s;ImagePalette29.ShowHint:=true;
  ImagePalette32.Hint:=s;ImagePalette32.ShowHint:=true;
  ImagePalette33.Hint:=s;ImagePalette33.ShowHint:=true;
  ImagePalette34.Hint:=s;ImagePalette34.ShowHint:=true;

  s:='Croisement ou TJD ou TJS ou pont';
  ImagePalette21.Hint:=s;ImagePalette21.ShowHint:=true;
  ImagePalette22.Hint:=s;ImagePalette22.ShowHint:=true;
  ImagePalette23.Hint:=s;ImagePalette23.ShowHint:=true;
  ImagePalette25.Hint:=s;ImagePalette25.ShowHint:=true;

  s90:='Insère une ligne au dessus';
  popupMenu1.Items[9][0].Hint:=s90;
  s91:='Insère une ligne en dessous';
  popupMenu1.Items[9][1].Hint:=s91;

  s93:='Insère une colonne à gauche';
  popupMenu1.Items[9][3].Hint:=s93;
  s94:='Insère une colonne à droite';
  popupMenu1.Items[9][4].Hint:=s94;

  s100:='Supprime la ligne pointée';
  popupMenu1.Items[10][0].Hint:=s100;
  s101:='Supprime la colonne pointée';
  popupMenu1.Items[10][1].Hint:=s101;

  if MasqueBandeauTCO then
  begin
    bandeauMasque:=true;
    Bandeau.Caption:='Afficher le bandeau';
  end;
  tcoCree:=true;
  if debug=1 then Affiche('Fin création fenêtre TCO',clLime);
end;


procedure Erreur_TCO(indexTCO,x,y : integer);
var s : string;
    i,adresse : integer;
begin
  s:='Erreur 92 TCO - Cellule '+intToSTR(x)+','+intToSTR(y)+' ';
  adresse:=tco[indextco,x,y].Adresse;
  i:=index_aig(adresse);
  if i=0 then s:=s+'aiguillage '+intToSTR(adresse)+' inconnu';
  if i<>0 then s:=s+'position aiguillage '+intToSTR(adresse)+' inconnue';
  Affiche(s,clred);
end;

// efface le trajet du tco du numéro du train depuis le détecteur jusqu'au premier aiguillage
procedure efface_trajet(det,train : integer);
var i,j,t,n,Bimage,x,y : integer;
    trouve : boolean;
begin
  if Train>Max_Trains then
  begin
    Affiche('Erreur 85: paramètre maximal train atteint',clred);
    exit;
  end;

  for t:=1 to NbreTCO do
  begin
    if PcanvasTCO[t]<>nil then
    begin
      n:=Trace_Train[t].train[train].nombre;
      if n=0 then exit;
      i:=n;
      repeat
        x:=Trace_Train[t].train[train].route[i].x;
        y:=Trace_Train[t].train[train].route[i].y;
        Bimage:=tco[t,x,y].BImage;
        trouve:=IsAigTJDCroiTCO(Bimage);
        dec(i);
      until trouve or (i=0);

      if trouve then
      begin
        for j:=i+1 downto 1 do
        begin
          x:=Trace_Train[t].train[train].route[j].x;
          y:=Trace_Train[t].train[train].route[j].y;
          tco[t,x,y].mode:=0;
          Affiche_cellule(t,x,y);
        end;
      end;
   end;
  end;
end;

// renvoie le sens de la loco en circulation dans le canton
// on utilise le détecteur suivant du train pour trouver le sens de déplacement du train
function sens_train_canton(AdrTrain,Idcanton : integer) : integer;
var adrdet,IndexTrain : integer;
    horz : boolean;
begin
  result:=0;
  indexTrain:=index_train_adresse(AdrTrain);
  if indexTrain=0 then exit;

  adrdet:=trains[indexTrain].detecteurSuiv;
  //Affiche('DetecteurSuiv='+intToSTR(adrDet),clYellow);

  if adrdet=0 then exit;
  horz:=canton[idcanton].horizontal;
  if horz then
  begin
    if (canton[idcanton].el1=AdrDet) and (canton[idcanton].typ1=det) then begin result:=SensGauche;exit;end;
    if (canton[idcanton].el2=AdrDet) and (canton[idcanton].typ2=det) then begin result:=SensDroit;exit;end;
  end;
  if (canton[idcanton].el1=AdrDet) and (canton[idcanton].typ1=det) then begin result:=SensHaut;exit;end;
  if (canton[idcanton].el2=AdrDet) and (canton[idcanton].typ2=det) then begin result:=SensBas;exit;end;

end;

// affiche le trajet Trace_Train[] dans le tco du train,ir =nombre d'éléments du tableau trace_train mode=couleur
// mode=0 : effacement du trajet
// sinon mode = couleur du train
// affecte_loco = true : procède à l'affectation du train dans les cantons
//             = false : ne change pas le train dans le canton
procedure affiche_trajet(indexTCO,train,AdrTrain,ir,mode : integer;affecte_loco : boolean);
var i,sx,sy,x,y,ax,ay,Bimage,adresse,IdCanton,IdTrain,AncTrain,
    DernierDet,sens : integer;
    cant : boolean;
begin
  // et affichage de la route
  if debugTCO then
  begin
    if ir<>0 then
    begin
      x:=Trace_Train[indexTCO].Train[train].route[1].x;
      y:=Trace_Train[indexTCO].Train[train].route[1].y;
      ax:=Trace_Train[indexTCO].Train[train].route[ir].x;
      ay:=Trace_Train[indexTCO].Train[train].route[ir].y;
    end;
    AfficheDebug('Affiche_trajet TCO'+intToSTR(indexTCO)+' '+intToSTR(x)+','+intToSTR(y)+' à '+intToSTR(ax)+','+intToSTR(ay)+' mode='+intToSTR(mode),clLime);
  end;
  for i:=1 to ir do
  begin
    x:=Trace_Train[indexTCO].Train[train].route[i].x;
    y:=Trace_Train[indexTCO].Train[train].route[i].y;
    bimage:=tco[indextco,x,y].BImage;
    cant:=IsCanton(Bimage);

    if debugTCO then
    begin
      AfficheDebug('x='+intToSTR(x)+' y='+intToSTR(y),clLime);
    end;

    tco[Indextco,x,y].mode:=mode;  //mode;  // pour la couleur
    idTrain:=0;
    if mode>0 then Idtrain:=index_couleur  // = numéro du train
      else IdTrain:=0; // efface train

    adresse:=tco[indextco,x,y].Adresse;
    if adresse<>0 then
    begin
      // si l'adresse est un détecteur
      if (index_adresse_detecteur(adresse)<>0) then DernierDet:=adresse;
    end;
    tco[indextco,x,y].trajet:=0;


    //Affiche('Affiche_trajet: Affecte '+intToSTR(IdTrain)+' au TCO '+intToSTR(indexTCO)+' '+intToSTR(x)+' '+intToSTR(y),clWhite);
    // si pas canton, affectation du train à la cellule---------------------------
    if not(cant) then TCO[IndexTCO,x,y].train:=IdTrain
    else
    begin
      // si canton affecte ou désaffecte le train au canton
      // voir pour afficher le train si le détecteur d'entrée du canton passa à 1

      IdCanton:=index_canton_numero(TCO[indexTCO,x,y].NumCanton); // index canton

      AncTrain:=0;
      if (idcanton<>0) and affecte_loco then
      begin
        if mode=0 then // désaffecter le train
        begin
          //Affiche('Désaffecte train canton'+intToSTR(canton[idcanton].numero),clYellow);
          affecte_train_canton(0,idCanton,canton[idcanton].sensLoco)
        end
        else
        begin
          begin
            AncTrain:=detecteur[dernierDet].AdrTrain;
            if ancTrain<>0 then
            begin
              //Affiche('Affecte train canton'+intToSTR(canton[idcanton].numero),clYellow);
              sens:=sens_train_canton(AdrTrain,Idcanton);

              affecte_train_canton(AncTrain,idcanton,sens);
            end;
          end;
        end;

      end;
      //if (idcanton<>0) and  not affecte_Loco then Affiche('Pas en mode affecte_loco',clOrange);
    end;

    // pour les croisements il faut mettre à jour la variable "trajet" pour l'affichage dans la cellule
    if (bimage=21) and (i>1) then
    begin
      ax:=Trace_Train[indexTCO].Train[train].route[i-1].x;
      ay:=Trace_Train[indexTCO].Train[train].route[i-1].y;
      sx:=Trace_Train[indexTCO].Train[train].route[i+1].x;
      sy:=Trace_Train[indexTCO].Train[train].route[i+1].y;

      tco[indextco,x,y].trajet:=0;
      if (ax-x=-1) and (ay-y=0)  and  (sx-x=1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=1;   // de gauche à droite
      if (ax-x=1)  and (ay-y=0)  and  (sx-x=-1) and (sy-y=0)  then tco[indextco,x,y].trajet:=1;   // de droite à gauche
      if (ax-x=-1) and (ay-y=1)  and  (sx-x=1)  and (sy-y=-1) then tco[indextco,x,y].trajet:=2;   // de bas gauche vers haut droit
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=2;   // de NE vers SO
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)   and (sy-y=-1) then tco[indextco,x,y].trajet:=4;   // de gauche vers haut droite
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=4;   // de haut droite vers gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=1)   and (sy-y=0)  then tco[indextco,x,y].trajet:=3;   // de bas gauche vers droite
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=3;   // de gauche vers haut droite
      if tco[indextco,x,y].trajet=0 then
        affiche('Erreur 70 TCO - Cellule '+intToSTR(x)+','+intToSTR(y),clred);
    end;

    // croisement
    if (bimage=22) and (i>1) then
    begin
      ax:=Trace_Train[indexTCO].Train[train].route[i-1].x;
      ay:=Trace_Train[indexTCO].Train[train].route[i-1].y;
      sx:=Trace_Train[indexTCO].Train[train].route[i+1].x;
      sy:=Trace_Train[indexTCO].Train[train].route[i+1].y;
      tco[indextco,x,y].trajet:=0;
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=1;   // 1 de gauche à droite
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1) and (sy-y=0)  then tco[indextco,x,y].trajet:=1;   // 2 de droite à gauche
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=2;   // 3 de haut gauche vers bas droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1) and (sy-y=-1) then tco[indextco,x,y].trajet:=2;   // 4 de bas droit vers haut gauche
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1) and (sy-y=-1) then tco[indextco,x,y].trajet:=3;   // 5 de droit vers en haut à gauche
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=3;   // 6 de haut à gauche vers droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1) and (sy-y=0)  then tco[indextco,x,y].trajet:=4;   // 7 de bas à droite vers gauche
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=4;   // de gauche vers en bas a droite
      if tco[indextco,x,y].trajet=0 then
        affiche('Erreur 71 TCO'+intToSTR(indexTCO)+' - Ax='+intToSTR(ax)+' Ay='+intToSTR(Ay)+' Cellule '+intToSTR(x)+','+intToSTR(y)
                                     +' Sx='+intToSTR(sx)+'Sy='+intToSTR(sy),clred);
    end;

    // croisement
    if (bimage=23) and (i>1) then
    begin
      ax:=Trace_Train[indexTCO].Train[train].route[i-1].x;
      ay:=Trace_Train[indexTCO].Train[train].route[i-1].y;
      sx:=Trace_Train[indexTCO].Train[train].route[i+1].x;
      sy:=Trace_Train[indexTCO].Train[train].route[i+1].y;
      tco[indextco,x,y].trajet:=0;
      if (ax-x=0)  and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[indextco,x,y].trajet:=1;   // de haut à bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[indextco,x,y].trajet:=1;   // de bas à haut
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1) and (sy-y=1)  then tco[indextco,x,y].trajet:=2;   // de haut droit vers bas gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=1)  and (sy-y=-1) then tco[indextco,x,y].trajet:=2;   // de bas gauche vers haut droit
      if (ax-x=1)  and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[indextco,x,y].trajet:=3;   // de haut droit vers bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=1)  and (sy-y=-1) then tco[indextco,x,y].trajet:=3;   // de bas vers haut droit
      if (ax-x=0)  and (ay-y=-1) and (sx-x=-1) and (sy-y=1)  then tco[indextco,x,y].trajet:=4;   // de haut vers bas gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[indextco,x,y].trajet:=4;   // de bas gauche vers haut
      if tco[indextco,x,y].trajet=0 then affiche('Erreur 72 TCO - Cellule '+intToSTR(x)+','+intToSTR(y),clred);
    end;

    // croisement
    if (bimage=25) and (i>1) then
    begin
      ax:=Trace_Train[indexTCO].Train[train].route[i-1].x;
      ay:=Trace_Train[indexTCO].Train[train].route[i-1].y;
      sx:=Trace_Train[indexTCO].Train[train].route[i+1].x;
      sy:=Trace_Train[indexTCO].Train[train].route[i+1].y;
      tco[indextco,x,y].trajet:=0;
      if (ax-x=0)  and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[indextco,x,y].trajet:=1;   // de haut à bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[indextco,x,y].trajet:=1;   // de bas à haut
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=2;   // de haut gauche vers bas droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1) and (sy-y=-1) then tco[indextco,x,y].trajet:=2;   // de bas droit vers haut gauche
      if (ax-x=-1) and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[indextco,x,y].trajet:=3;   // de NO vers S
      if (ax-x=0)  and (ay-y=1)  and (sx-x=-1) and (sy-y=-1) then tco[indextco,x,y].trajet:=3;   // de S vers haut gauche
      if (ax-x=0)  and (ay-y=-1) and (sx-x=1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=4;   // de N vers SE
      if (ax-x=1)  and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[indextco,x,y].trajet:=4;   // de SE vers N
      if tco[indextco,x,y].trajet=0 then affiche('Erreur 73 TCO - Cellule '+intToSTR(x)+','+intToSTR(y),clred);
    end;
    Affiche_cellule(indexTCO,x,y);
    //Affiche('AC='+intToSTR(x)+' '+intToSTR(y),clyellow);
  end;
end;

// allume ou éteint (mode=0 ou 1) la voie du train "train", zone de det1 à det2 sur le TCO
// AdrTrain = adresse du train
// train est l'index du train qui a été créé par le roulage (tableau event_det_train[train] )
// det1 et det2 doivent être consécutifs sur le TCO, mais peuvent être séparés par des aiguillages
// si mode=0 : éteint la voie
//        =1 : allume la voie couleur détecteur allumé
//        =2 : allume la voie couleur de l'index train
//        =10 : arrêt sur trouvé canton, et renvoie le x,y du canton dans les variables globales xCanton,yCanton
//        =11 : det1=indexcanton det2=direction -  renvoie les éléments adjacent du canton dans la direction indiquée dans xCanton et tel1
//        =12 : det1 = détecteur de départ - renvoie l'élément sursuivant (peut être un aiguillage)dans la direction demandée dans xCanton et tel1
//              direction=det2 = TCO_N TCO_NE etc
//        =13 : det1=adresse de l'élément TypEL : type de l'élément, s'arrête au suivant, suivant la direction
// Ne nécessite pas que les aiguillages en talon soient bien positionnés entre det1 et det2
// PosAig = False: teste toutes les routes en récursif les aiguillages en pointe
//          True:  suit les aiguillages en pointe qui doivent être positionnés
// affecte_loco : true : efface la loco
// en sortie : true si det2 a été trouvé
//
function zone_tco_gx(indexTCO,det1: integer;typEL : tequipement;det2,train,adrTrain,mode: integer;posAig,affecte_loco : boolean) : boolean;
var i,ir,adresse,But,Bimage,direction,ancienX,ancienY,x,y,xn,yn,Xdet1,yDet1,iteration,indexIr,AdrTr,
    NbTrouve,AdrTr1,adrTr2 : integer;
    memtrouve,sortir,indextrouve : boolean;
    s : string;

  // stocke la route dans le tableau, et incrémente l'index
  procedure maj_route(indexTCO,x,y,train : integer;var ir : integer);
  begin
    if debugTCO then AfficheDebug('Ir='+IntToSTR(ir)+'->'+intToSTR(x)+' '+intToSTR(y),clyellow);

    if (train<0) or (train>Max_Trains) then
    begin
      Affiche('Erreur index train',clred);
      exit;
    end;

    // stocke le tracé
    if debugTCO then AfficheDebug('Stocke en '+intToSTR(ir),clWhite);
    Trace_Train[indexTCO].train[train].route[ir].x:=x;
    Trace_Train[indexTCO].train[train].route[ir].y:=y;
    Trace_Train[indexTCO].train[train].Nombre:=ir;
    if ir<500 then inc(ir);
  end;

  // mise à jour de x,y, nouvelles coordonnées par xn,yn (var globales de la procédure zone_tco)
  procedure Maj_coords(var ancienX,ancienY,x,y : integer);
  begin
    ancienX:=x;
    ancienY:=y;
    x:=xn;
    y:=yn;
  end;


  // El_Tco : trouve l'élément en x,y et constuit la route à l'élément de destination suivant, suivant
  // les variables ancienX et ancienY
  // AncienX,AncienY, x, y et ir sont locales pour des récursivités différentes, donc on les passe en paramètre pour transmettre à la
  // récursivité suivante leur valeur, mais elles reprennent leur valeurs initiales à la remontée vers la résursivité appellante.
  Procedure El_tco(AncienX,ancienY,x,y,train : integer; ir : integer);
  var mdl : Tequipement;
      i,j,index,position,TjdHom,Index_TjdHom,position2 : integer;
      c1,c2 : char;
      SortirBoucle,NePasfaire : boolean;
  begin
    // répète la route depuis un aiguillage
    inc(iteration);
    //Affiche('123iteration '+intToSTR(iteration),clWhite);
    if DebugTCO then AfficheDebug('El_TCO'+intToSTR(X)+' '+intToSTR(Y),clYellow);
    //Affiche('El_TCO'+intToSTR(X)+' '+intToSTR(Y),clYellow);
    i:=0;
    repeat
      sortirBoucle:=false;
      maj_route(indextco,x,y,train,ir);
      adresse:=tco[indextco,x,y].Adresse ;
      index:=index_aig(adresse);
      if index<>0 then
      begin
        position:=aiguillage[index].position;
        if (tco[indexTCO,x,y].inverse) and (position<>const_inconnu) then
        begin
          if position=const_devie then position:=const_droit else position:=const_devie;
        end;
      end;

      Bimage:=tco[indextco,x,y].Bimage;
      //if adresse=det1 then ir:=1; // index de stockage de trace
      if debugTCO then
      begin
        s:='x='+intToSTR(x)+' y='+intToSTR(y)+' Elément='+intToSTR(Bimage);
        if adresse<>0 then s:=s+' Adresse='+intToSTR(adresse);
        if adresse=det1 then s:=s+' il s''agit du det1';
        AfficheDebug(s,clyellow);
      end;
      // vers case suivante: trouver le trajet pour rejoindre det1 à det2

      // si canton, prendre les coordonnées du canton
      if (Bimage>=id_cantonH) and (Bimage<=id_cantonH+9) then
      begin
        //if mode=10 then trouveCanton:=true;
        if (Bimage=id_cantonH) and (mode=10) then
        begin
          Xcanton:=x-(Bimage-Id_cantonH);    // revenir à la coordonnée X du début du canton
          Ycanton:=y;  // variable globale
        end;
        Bimage:=1;  // substituer au canton un élément de voie H
      end;
      if (Bimage>=id_cantonV) and (Bimage<=id_cantonV+9) then
      begin
        if (Bimage=Id_cantonV) and (mode=10) then
        begin
          Xcanton:=x;
          Ycanton:=y-(Bimage-Id_cantonH);    // revenir à la coordonnée Y du début du canton
        end;
        Bimage:=20; // substituer au canton un élément de voie V
      end;

      // spécial mode 11 et 12
      nepasfaire:=(mode=12) and (adresse<>0) and (adresse<>det1);
      nepasfaire:=((mode=11) and (adresse<>0)) or nepasfaire;
      nepasfaire:=((mode=13) and (adresse<>0) and (adresse<>det1)) or nepasfaire;

      if not(nepasFaire) then
      case Bimage of
      // voie
      1 : begin
            if debugTCO then
            begin
              s:='El 1';if adresse<>0 then s:=s+'adr='+intToStr(adresse);
              AfficheDebug(s,clyellow);
            end;
            yn:=y;
            if ancienX<x then xn:=x+1 else xn:=x-1;
          end;
      // aiguillage
      2 : begin
            yn:=y;
            if (ancienX<x) and (ancienY=y) then begin xn:=x+1;end;
            if (ancienX<x) and (ancienY>y) then begin xn:=x+1;yn:=y;end;
            if (ancienX>x) and (ancienY=Y) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;
                ancienY:=y;
                dec(x);
                el_tco(AncienX,AncienY,x,y,train,ir);   // essaye droit
                inc(x);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                AncienX:=x;AncienY:=y;
                dec(x);inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
      3 : begin
            if (ancienX>x) and (ancienY<=Y) then begin xn:=x-1;yn:=y;end; // pris en pointe
            if (ancienX<x) and (ancienY=y) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;AncienY:=y;
                inc(x);
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(x);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;AncienY:=y;
                inc(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

      4 : begin
            //if debugTCO then AfficheDebug('El 4',clyellow);
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
            if (ancienX>x) and (ancienY>y) then begin xn:=x-1;end;
            if (ancienX<x) and (ancienY=Y) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                AncienX:=x;AncienY:=y;
                inc(x);
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(x);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                // essai dévié
                AncienX:=x;AncienY:=y;
                inc(x);inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

      5 : begin
            if (ancienX<x) and (ancienY<=y) then begin yn:=y;xn:=x+1;end;  //on vient de O
            if (ancienX>x) and (ancienY=Y) then // on vient de E
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienx:=x;ancieny:=y;
                dec(x);
                el_tco(ancienx,ancienY,x,y,train,ir);
                inc(x);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                AncienX:=x;AncienY:=y;
                dec(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

      6 : if ancienX<x then begin xn:=x+1;yn:=y;end else begin xn:=x-1;yn:=y-1;end;
      7 : if ancienx<x then begin xn:=x+1;yn:=y-1; end else begin yn:=y;xn:=x-1;end;
      8 : if ancienX<x then begin xn:=x+1;yn:=y+1; end else begin yn:=y;xn:=x-1;end;
      9 : if ancienX<x then begin xn:=x+1;yn:=y; end else begin xn:=x-1;yn:=y+1;end;
     10 : if ancienX<x then begin xn:=x+1;yn:=y-1;end else begin xn:=x-1;yn:=y+1;end;
     11 : if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end;
     12 : begin
            if (ancienX>x) and (ancienY>=Y) then begin xn:=x-1;yn:=y-1;end;
            if (ancienX<x) and (ancienY<Y) then
            begin
              // droit
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                inc(x);inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(x);dec(y);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                // essai dévié
                ancienX:=x;ancienY:=y;
                inc(x);
                el_tco(ancienx,ancienY,x,y,train,ir);
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
     13 : begin
            if (ancienX<x) and (ancienY>=Y) then begin xn:=x+1;yn:=y-1;end;
            if (ancienX>x) and (ancienY<Y) then
            begin
              // pris en pointe
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
               ancienX:=x;ancienY:=y;
               dec(x);inc(y);
               el_tco(ancienx,ancienY,x,y,train,ir);
               inc(x);dec(y);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                dec(x);
                el_tco(ancienx,ancienY,x,y,train,ir);
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
     14 : begin
            if (ancienX<x) and (ancienY<=Y) then begin xn:=x+1;yn:=y+1;end;
            if (ancienX>x) and (ancienY>y) then
            begin
              // pris en pointe droit
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                dec(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                inc(x);inc(y);
              end;
              // essayer dévié
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                // essai dévié
                ancienX:=x;ancienY:=y;
                dec(x);
                el_tco(ancienx,ancienY,x,y,train,ir);
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
     15 : begin
             if (ancienX>x) and (ancienY<=Y) then begin xn:=x-1;yn:=y+1;end;
             if (ancienX<x) and (ancienY>Y) then
             begin
               if not(posAig) or (posAig and (position=const_droit)) then
               begin
                 ancienX:=x;ancienY:=y;
                 inc(x);dec(y);
                 el_tco(ancienx,ancienY,x,y,train,ir);
                 dec(x);inc(y);
                end;
                if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
                begin
                  ancienX:=x;ancienY:=y;
                  inc(x);
                  el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
                end;
                if (position=const_inconnu) and posaig then sortir:=true;
              end;
           end;
      16 : if ancienX<x then begin xn:=x;yn:=y+1  ;end else begin xn:=x-1;yn:=y-1;end;
      17 : if ancienY<y then begin xn:=x;yn:=y+1  ;end else begin xn:=x+1;yn:=y-1;end;
      18 : if AncienX<x then begin xn:=x;yn:=y-1  ;end else begin yn:=y+1;xn:=x-1;end;
      19 : if ancienY<y then begin xn:=x+1;yn:=y+1;end else begin xn:=x;yn:=y-1;end;
      20,Id_CantonV : begin
              if debugTCO then
              begin
                s:='El 20';if adresse<>0 then s:=s+'adr='+intToStr(adresse);
                AfficheDebug(s,clyellow);
              end;
             xn:=x;
             if (ancienY<y) then yn:=y+1 else yn:=y-1;
           end;
      21 : begin
             //if debugTCO then AfficheDebug('El 21',clyellow);
             mdl:=rien;
             if adresse<>0 then
             begin
               j:=Index_Aig(adresse);
               mdl:=aiguillage[j].modele;
               if (mdl=tjs) or (mdl=tjd) then
               begin
                 // tjd ou tjs
                 if (mode=13) then
                 begin
                   if (ancienX<x) and (ancienY=y) then  // on va à l'Est en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     x:=x+1;
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;

                   if (ancienX>x) and (ancienY<y) then  // on va au SO en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     dec(x);inc(y);
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;

                   if (ancienX<x) and (ancienY>y) then  // on va au NE en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     inc(x);dec(y);
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;

                   if (ancienX>x) and (ancienY=y) then  // on va au O en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     dec(x);
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;
                 end
                 else   // pas mode 13
                 begin
                   if not(posAig) then
                   begin
                     if ancienX<x then  // on va à droite
                     begin
                       // on esten mode récursif
                       // essayer vers E
                       ancienX:=x;ancienY:=y;
                       x:=x+1;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                       if not(memtrouve) then
                       begin
                         // essai vers NE
                         AncienY:=y;
                         AncienX:=x-1;
                         y:=y-1;x:=x;
                         el_tco(ancienx,ancienY,x,y,train,ir);
                       end;
                     end;
                     if (ancienX>x) and not(Memtrouve) then  // on va à gauche
                     begin
                       // essayer vers O
                       ancienX:=x;ancienY:=y;
                       x:=x-1;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                       if not(memtrouve) then
                       begin
                         // essai vers SO
                         AncienY:=y;
                         AncienX:=x+1;
                         y:=y+1;x:=x;
                         el_tco(ancienx,ancienY,x,y,train,ir);
                       end;
                     end
                   end
                   else // mode posaig=true : on tient compte de la position des aiguillages pur suivre le parcours
                   begin
                     if aiguillage[index].EtatTJD=4 then              // TJD 4 états
                     begin
                       TjdHom:=aiguillage[index].Ddevie;              // adresse de la TJD homologue
                       Index_TjdHom:=index_aig(TjdHom);               // Index de la TJD homologue
                       position2:=aiguillage[Index_TjdHom].position;  // position de la TJD homologue

                       tjd4(adresse,position,TjdHom,position2,c1,c2); // retourne c1 et C2
                       if (ancienY<y) and (ancienX>x) then            // on vient du NE
                       begin
                         if c1=c2 then                                // si on traverse la TJD
                         begin
                           dec(x);inc(y);                             // on va au SO
                         end
                         else                                         // si on passe la TJD en courbe
                         begin
                           dec(x);                                    // on va à l'Ouest
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX>x) then            // on vient de E
                       begin
                         if c1=c2 then                                // si on traverse la TJD
                         begin
                           dec(x);                                    //on va à l'O
                         end
                         else
                         begin
                           dec(x);inc(y)                              // on va au SO
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX<x) then // on vient du O
                       begin
                         if c1=c2 then  // si on traverse la TJD
                         begin
                           inc(x); //on va à l'E
                         end
                         else
                         begin
                           inc(x);dec(y) // on va au NE
                         end;
                       end
                       else
                       if (ancienY>y) and (ancienX<x) then // on vient du SO
                       begin
                         if c1=c2 then  // si on traverse la TJD
                         begin
                           inc(x);dec(y) //on va au NE
                         end
                         else
                         begin
                           inc(x); // on va E
                         end;
                       end;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                     end
                     else
                     begin   // TJD 2 états
                       if (ancienY<y) and (ancienX>x) then            // on vient du NE
                       begin
                         if position=const_droit then                 // si on traverse la TJD
                         begin
                           dec(x);inc(y);                             // on va au SO
                         end
                         else                                         // si on passe la TJD en courbe
                         begin
                           dec(x);                                    // on va à l'Ouest
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX>x) then            // on vient de E
                       begin
                         if position=const_droit then                 // si on traverse la TJD
                         begin
                           dec(x);                                    //on va à l'O
                         end
                         else
                         begin
                           dec(x);inc(y)                              // on va au SO
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX<x) then // on vient du O
                       begin
                         if position=const_droit then
                         begin
                           inc(x); //on va à l'E
                         end
                         else
                         begin
                           inc(x);dec(y) // on va au NE
                         end;
                       end
                       else
                       if (ancienY>y) and (ancienX<x) then // on vient du SO
                       begin
                         if position=const_droit then  // si on traverse la TJD
                         begin
                           inc(x);dec(y) //on va au NE
                         end
                         else
                         begin
                           inc(x); // on va E
                         end;
                       end;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                     end;
                   end;
                 end;
               end;
             end;

             if (adresse=0) or (mdl=crois) then
             // croisement
             begin
               if DebugTCO then AfficheDebug('Croisement',clyellow);
               if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;yn:=y;end;
               if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;yn:=y;end;
               if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
               if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;yn:=y+1;end;
             end;
             if (mdl=aig) then
             begin
               Affiche('Erreur 48 TCO : la cellule '+intToSTR(x)+','+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
               Affiche('mais la cellule représente un croisement ou une TJD/S',clred);
               exit;
             end;
           end;
      // TJD ou croisement
      22 : begin
             mdl:=rien;
             if adresse<>0 then
             begin
               j:=Index_Aig(adresse);
               mdl:=aiguillage[j].modele;
               if (mdl=tjs) or (mdl=tjd) then
               begin
                 // tjd ou tjs
                 if (mode=13) then
                 begin
                   if (ancienX<x) and (ancienY=y) then  // on va à l'Est en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     x:=x+1;
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;

                   if (ancienX<x) and (ancienY<y) then  // on va au SE en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     inc(x);inc(y);
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;

                   if (ancienX>x) and (ancienY>y) then  // on va au NO en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     dec(x);dec(y);
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;

                   if (ancienX>x) and (ancienY=y) then  // on va au O en mode 13
                   begin
                     ancienX:=x;ancienY:=y;
                     dec(x);
                     el_tco(ancienx,ancienY,x,y,train,ir);
                   end;
                 end
                 else  // pas mode 13
                 begin
                   if not posAig then
                   begin
                     if (ancienX<x) then  // on va à droite
                     begin
                       // essayer vers E
                       ancienX:=x;ancienY:=y;
                       x:=x+1;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                       if not(memtrouve) then
                       begin
                         // essai vers SE
                         AncienY:=y;
                         AncienX:=x-1;
                         y:=y+1;x:=x;
                         el_tco(ancienx,ancienY,x,y,train,ir);
                       end;
                     end;
                     if ((ancienX>x) and not(Memtrouve)) then  // on va à gauche
                     begin
                       // essayer vers O
                       ancienX:=x;ancienY:=y;
                       x:=x-1;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                       if not(memtrouve) then
                       begin
                         // essai vers NO
                         AncienY:=y;
                         AncienX:=x+1;
                         y:=y-1;x:=x;
                         el_tco(ancienx,ancienY,x,y,train,ir);
                       end;
                     end;
                   end
                   else  // mode posAig
                   begin
                     if aiguillage[index].EtatTJD=4 then
                     begin
                       TjdHom:=aiguillage[index].Ddevie;
                       Index_TjdHom:=index_aig(TjdHom);
                       position2:=aiguillage[Index_TjdHom].position;
                       tjd4(adresse,position,TjdHom,position2,c1,c2);  // retourne c1 et C2
                       if (ancienY<y) and (ancienX<x) then // on vient du NO
                       begin
                         if c1=c2 then  // si on traverse la TJD
                         begin
                           inc(x);inc(y);
                         end
                         else
                         begin
                           inc(x); // on va à l'E
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX>x) then // on vient de E
                       begin
                         if c1=c2 then  // si on traverse la TJD
                         begin
                           dec(x); //on va à l'O
                         end
                         else
                         begin
                           dec(x);dec(y) // on va au NO
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX<x) then // on vient du O
                       begin
                         if c1=c2 then  // si on traverse la TJD
                         begin
                           inc(x); //on va à l'E
                         end
                         else
                         begin
                           inc(x);inc(y) // on va au SE
                         end;
                       end
                       else
                       if (ancienY>y) and (ancienX>x) then // on vient du SE
                       begin
                         if c1=c2 then  // si on traverse la TJD
                         begin
                           dec(x);dec(y) //on va au NO
                         end
                         else
                         begin
                           dec(x); // on va O
                         end;
                       end;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                     end
                     else
                     begin // TJD 2 états
                       if (ancienY<y) and (ancienX<x) then // on vient du NO
                       begin
                         if position=const_droit then  // si on traverse la TJD
                         begin
                           inc(x);inc(y);
                         end
                         else
                         begin
                           inc(x); // on va à l'E
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX>x) then // on vient de E
                       begin
                         if position=const_droit then  // si on traverse la TJD
                         begin
                           dec(x); //on va à l'O
                         end
                         else
                         begin
                           dec(x);dec(y) // on va au NO
                         end;
                       end
                       else
                       if (ancienY=y) and (ancienX<x) then // on vient du O
                       begin
                         if position=const_droit then  // si on traverse la TJD
                         begin
                           inc(x); //on va à l'E
                         end
                         else
                         begin
                           inc(x);inc(y) // on va au SE
                         end;
                       end
                       else
                       if (ancienY>y) and (ancienX>x) then // on vient du SE
                       begin
                         if position=const_droit then  // si on traverse la TJD
                         begin
                           dec(x);dec(y) //on va au NO
                         end
                         else
                         begin
                           dec(x); // on va O
                         end;
                       end;
                       el_tco(ancienx,ancienY,x,y,train,ir);
                     end;
                   end;
                 end;
               end;
             end;

             if (adresse=0) or (mdl=crois) then
             // croisement
             begin
               if DebugTCO then AfficheDebug('croisement',clyellow);
               if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;end;
               if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
               if (ancienX>x) and (ancienY>Y) then begin xn:=x-1;yn:=y-1;end;
               if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
             end;
             if (mdl=aig) then
             begin
               Affiche('Erreur 49 TCO : la cellule '+intToSTR(x)+','+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
               Affiche('mais la cellule représente un croisement ou une TJD/S',clred);
               exit;
             end;
           end;

         // tjd ou croisement
         23 : begin
                if debugTCO then AfficheDebug('El 23',clyellow);
                mdl:=rien;
                if adresse<>0 then
                begin
                  j:=Index_Aig(adresse);
                  mdl:=aiguillage[j].modele;
                  // tjd ou tjs
                  if (mdl=tjd) or (mdl=tjs) then
                  begin
                    if (mode=13) then
                    begin
                      if (ancienX=x) and (ancienY>y) then  // on va à N en mode 13
                      begin
                        ancienX:=x;ancienY:=y;
                        dec(y);
                        el_tco(ancienx,ancienY,x,y,train,ir);
                      end;

                      if (ancienX>x) and (ancienY<y) then  // on va au SO en mode 13
                      begin
                        ancienX:=x;ancienY:=y;
                        dec(x);inc(y);
                        el_tco(ancienx,ancienY,x,y,train,ir);
                      end;

                      if (ancienX<x) and (ancienY>y) then  // on va au NE en mode 13
                      begin
                        ancienX:=x;ancienY:=y;
                        inc(x);dec(y);
                        el_tco(ancienx,ancienY,x,y,train,ir);
                      end;

                      if (ancienX=x) and (ancienY<y) then  // on va au S en mode 13
                      begin
                        ancienX:=x;ancienY:=y;
                        inc(y);
                        el_tco(ancienx,ancienY,x,y,train,ir);
                      end;
                    end
                    else  // pas mode 13
                    begin
                      if not(posAig) then
                      begin
                        if ancienY<y then  // on va en bas
                        begin
                          // essayer vers S
                          ancienX:=x;ancienY:=y;
                          y:=y+1;
                          el_tco(ancienx,ancienY,x,y,train,ir);
                          if not(memtrouve) then
                          begin
                            // essai vers SO
                            AncienY:=y-1;
                            AncienX:=x;
                            x:=x-1;
                            el_tco(ancienx,ancienY,x,y,train,ir);
                          end;
                        end;
                        if (ancienY>y) and not(Memtrouve) then  // on monte
                        begin
                          // essayer vers N
                          ancienX:=x;ancienY:=y;
                          y:=y-1;
                          el_tco(ancienx,ancienY,x,y,train,ir);
                          if not(memtrouve) then
                          begin
                            // essai vers NE
                            AncienY:=y+1;
                            AncienX:=x;
                            x:=x+1;
                            el_tco(ancienx,ancienY,x,y,train,ir);
                          end;
                        end;
                      end
                      else  // mode posAig
                      begin
                        if aiguillage[index].EtatTJD=4 then
                        begin
                          TjdHom:=aiguillage[index].Ddevie;    
                          Index_TjdHom:=index_aig(TjdHom);
                          position2:=aiguillage[Index_TjdHom].position;
                          tjd4(adresse,position,TjdHom,position2,c1,c2);  // retourne c1 et C2
                          if (ancienY<y) and (ancienX>x) then // on vient du NE
                          begin
                            if c1=c2 then  // si on traverse la TJD
                            begin
                              dec(x);inc(y);   // on va au SO
                            end
                            else
                            begin
                              inc(y); // on va au S
                            end;
                          end
                          else
                          if (ancienY<y) and (ancienX=x) then // on vient de N
                          begin
                            if c1=c2 then  // si on traverse la TJD
                            begin
                              inc(y); //on va au S
                            end
                            else
                            begin
                              dec(x);inc(y) // on va au SO
                            end;
                          end
                          else
                          if (ancienY=y) and (ancienX<x) then // on vient du SO
                          begin
                            if c1=c2 then  // si on traverse la TJD
                            begin
                              inc(x);dec(y); //on va au NE
                            end
                            else
                            begin
                              dec(y) // on va au N
                            end;
                          end
                          else
                          if (ancienY>y) and (ancienX=x) then // on vient du S
                          begin
                            if c1=c2 then  // si on traverse la TJD
                            begin
                              dec(y) //on va au N
                            end
                            else
                            begin
                              inc(x);dec(y); // on va NE
                            end;
                          end;
                          el_tco(ancienx,ancienY,x,y,train,ir);
                        end
                        else
                        begin  // TJD 2 états
                          if (ancienY<y) and (ancienX>x) then // on vient du NE
                          begin
                            if position=const_droit then  // si on traverse la TJD
                            begin
                              dec(x);inc(y);   // on va au SO
                            end
                            else
                            begin
                              inc(y); // on va au S
                            end;
                          end
                          else
                          if (ancienY<y) and (ancienX=x) then // on vient de N
                          begin
                            if position=const_droit then  // si on traverse la TJD
                            begin
                              inc(y); //on va au S
                            end
                            else
                            begin
                              dec(x);inc(y) // on va au SO
                            end;
                          end
                          else
                          if (ancienY=y) and (ancienX<x) then // on vient du SO
                          begin
                            if position=const_droit then  // si on traverse la TJD
                            begin
                              inc(x);dec(y); //on va au NE
                            end
                            else
                            begin
                              dec(y) // on va au N
                            end;
                          end
                          else
                          if (ancienY>y) and (ancienX=x) then // on vient du S
                          begin
                            if position=const_droit then  // si on traverse la TJD
                            begin
                              dec(y) //on va au N
                            end
                            else
                            begin
                              inc(x);dec(y); // on va NE
                            end;
                          end;
                          el_tco(ancienx,ancienY,x,y,train,ir);
                        end;
                      end;
                    end;
                  end;
                end;
                if (adresse=0) or (mdl=crois) then
                // croisement
                begin
                  if DebugTCO then AfficheDebug('Croisement',clyellow);
                  if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;yn:=yn+1;end;
                  if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;yn:=yn-1;end;
                  if (ancienX=x) and (ancienY<Y) then begin xn:=x;yn:=y+1;end;
                  if (ancienX=x) and (ancienY>Y) then begin xn:=x;yn:=y-1;end;
                end;
                if (mdl=aig) then
                begin
                  Affiche('Erreur 50 TCO : la cellule '+intToSTR(x)+','+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
                  Affiche('mais la cellule représente un croisement ou une TJD/S',clred);
                  exit;
                end;
              end;

     24 : begin
            if debugTCO then AfficheDebug('El 24',clyellow);
            // on vient d'en haut ou en haut à gauche
            if (ancienY<y) and (ancienX<=x) then begin yn:=y+1;xn:=x;end;
            // on vient d'en bas : prise en pointe
            if (ancienY>y) and (ancienX=x) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                inc(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                dec(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

       // tjd ou croisement
     25 : begin
            mdl:=rien;
            if adresse<>0 then
            begin
              j:=Index_Aig(adresse);
              mdl:=aiguillage[j].modele;
              // tjd ou tjs
              if (mdl=tjd) or (mdl=tjs) then
              begin
                if (mode=13) then
                begin
                  if (ancienX=x) and (ancienY<y) then  // on va au S en mode 13
                  begin
                    ancienX:=x;ancienY:=y;
                    inc(y);
                    el_tco(ancienx,ancienY,x,y,train,ir);
                  end;

                  if (ancienX<x) and (ancienY<y) then  // on va au SE en mode 13
                  begin
                    ancienX:=x;ancienY:=y;
                    inc(x);inc(y);
                    el_tco(ancienx,ancienY,x,y,train,ir);
                  end;

                  if (ancienX>x) and (ancienY>y) then  // on va au NO en mode 13
                  begin
                    ancienX:=x;ancienY:=y;
                    dec(x);dec(y);
                    el_tco(ancienx,ancienY,x,y,train,ir);
                  end;

                  if (ancienX=x) and (ancienY>y) then  // on va au N en mode 13
                  begin
                    ancienX:=x;ancienY:=y;
                    dec(y);
                    el_tco(ancienx,ancienY,x,y,train,ir);
                  end;
                end
                else  // pas mode 13
                begin
                  if not posAig then
                  begin
                    if ancienY<y then  // on va en bas
                    begin
                      // essayer vers S
                      ancienX:=x;ancienY:=y;
                      y:=y+1;
                      el_tco(ancienx,ancienY,x,y,train,ir);
                      if not(memtrouve) then
                      begin
                        // essai vers SE
                        AncienY:=y-1;
                        AncienX:=x;
                        x:=x+1;
                        el_tco(ancienx,ancienY,x,y,train,ir);
                      end;
                    end;
                    if (ancienY>y) and not(Memtrouve) then  // on monte
                    begin
                      // essayer vers N
                      ancienX:=x;ancienY:=y;
                      y:=y-1;
                      el_tco(ancienx,ancienY,x,y,train,ir);
                      if not(memtrouve) then
                      begin
                        // essai vers NO
                        AncienY:=y+1;
                        AncienX:=x;
                        x:=x-1;
                        el_tco(ancienx,ancienY,x,y,train,ir);
                      end;
                    end;
                  end
                  else
                  begin   // mode posaig
                    if aiguillage[index].EtatTJD=4 then
                    begin
                      TjdHom:=aiguillage[index].Ddevie;
                      Index_TjdHom:=index_aig(TjdHom);
                      position2:=aiguillage[Index_TjdHom].position;
                      tjd4(adresse,position,TjdHom,position2,c1,c2);  // retourne c1 et C2
                      if (ancienY<y) and (ancienX<x) then // on vient du NO
                      begin
                        if c1=c2 then  // si on traverse la TJD
                        begin
                          inc(x);inc(y);   // on va au SE
                        end
                        else
                        begin
                          inc(y); // on va au S
                        end;
                      end
                      else
                      if (ancienY<y) and (ancienX=x) then // on vient de N
                      begin
                        if c1=c2 then  // si on traverse la TJD
                        begin
                          inc(y); //on va au S
                        end
                        else
                        begin
                          inc(x);inc(y) // on va au SE
                        end;
                      end
                      else
                      if (ancienY>y) and (ancienX>x) then // on vient du SE
                      begin
                        if c1=c2 then  // si on traverse la TJD
                        begin
                          dec(x);dec(y); //on va au NO
                        end
                        else
                        begin
                          dec(y) // on va au N
                        end;
                      end
                      else
                      if (ancienY>y) and (ancienX=x) then // on vient du S
                      begin
                        if c1=c2 then  // si on traverse la TJD
                        begin
                          dec(y) //on va au N
                        end
                        else
                        begin
                          dec(x);dec(y); // on va NO
                        end;
                      end;
                      el_tco(ancienx,ancienY,x,y,train,ir);
                    end
                    else // tjs 2 états
                    begin
                      if (ancienY<y) and (ancienX<x) then // on vient du NO
                      begin
                        if position=const_droit then  // si on traverse la TJD
                        begin
                          inc(x);inc(y);   // on va au SE
                        end
                        else
                        begin
                          inc(y); // on va au S
                        end;
                      end
                      else
                      if (ancienY<y) and (ancienX=x) then // on vient de N
                      begin
                        if position=const_droit then  // si on traverse la TJD
                        begin
                          inc(y); //on va au S
                        end
                        else
                        begin
                          inc(x);inc(y) // on va au SE
                        end;
                      end
                      else
                      if (ancienY>y) and (ancienX>x) then // on vient du SE
                      begin
                        if position=const_droit then  // si on traverse la TJD
                        begin
                          dec(x);dec(y); //on va au NO
                        end
                        else
                        begin
                          dec(y) // on va au N
                        end;
                      end
                      else
                      if (ancienY>y) and (ancienX=x) then // on vient du S
                      begin
                        if position=const_droit then  // si on traverse la TJD
                        begin
                          dec(y) //on va au N
                        end
                        else
                        begin
                          dec(x);dec(y); // on va NO
                        end;
                      end;
                      el_tco(ancienx,ancienY,x,y,train,ir);
                    end;
                  end;
                end;
              end;
            end;
            if (adresse=0) or (mdl=crois) then
            // croisement
            begin
              if DebugTCO then AfficheDebug('Croisement',clyellow);
              if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=yn+1;end;
              if (ancienX>x) and (ancienY>Y) then begin xn:=x-1;yn:=yn-1;end;
              if (ancienX=x) and (ancienY<Y) then begin xn:=x;yn:=y+1;end;
              if (ancienX=x) and (ancienY>Y) then begin xn:=x;yn:=y-1;end;
            end;
            if (mdl=aig) then
            begin
              Affiche('Erreur 51 TCO : la cellule '+intToSTR(x)+','+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
              Affiche('mais la cellule représente un croisement ou une TJD/S',clred);
              exit;
            end;
          end;

     26 : begin
            if debugTCO then AfficheDebug('El 26',clyellow);
            if (ancienY<y) and (ancienX>=x) then begin yn:=y+1;xn:=x;end;
            if (ancienY>y) and (ancienX=x) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                inc(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                inc(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

     27 : begin
            if debugTCO then AfficheDebug('El 27',clyellow);
            // on vient d'en bas
            if (ancienY>y) and (ancienX<=x) then begin yn:=y-1;xn:=x;end;
            // on vient d'en haut: pris en pointe
            if (ancienY<y) and (ancienX=x) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                inc(y);
                // essayer droit
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                dec(x);inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
     28 : begin
            if debugTCO then AfficheDebug('El 28',clyellow);
            // on vient d'en bas ou droite
            if (ancienY>y) and (ancienX>=x) then begin yn:=y-1;xn:=x; end;
            // on vient d'en haut
            if (ancienY<y) and (ancienX=x) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                inc(x);inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
     29 : begin
            //if debugTCO then AfficheDebug('El 12',clyellow);
            // on vient de bas
            if (ancienX>=x) and (ancienY>Y) then begin xn:=x-1;yn:=y-1;end;
            // on vient de NO
            if (ancienX<x) and (ancienY<Y) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                inc(x);inc(y);
                // essayer droit
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(x);dec(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

     32 : begin
            if debugTCO then AfficheDebug('El 32',clyellow);
            // on vient d'en bas
            if (ancienX<=x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
            // on vient d'en haut à droite
            if (ancienX>x) and (ancienY<y) then
            // on vient de NE
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                dec(x);inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                inc(x);dec(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                inc(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

     33 : begin
           //if debugTCO then AfficheDebug('El 14',clyellow);
           // on vient de haut
           if (ancienX<=x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           //on vient de bas droite
           if (ancienX>x) and (ancienY>y) then
           begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                dec(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                inc(x);inc(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;
     34 : begin
            // on vient du N ou NE
            if (ancienX>=x) and (ancienY<y) then begin xn:=x-1;yn:=y+1;end;
            // on vient du SO
            if (ancienX<x) and (ancienY>y) then
            begin
              if not(posAig) or (posAig and (position=const_droit)) then
              begin
                ancienX:=x;ancienY:=y;
                inc(x);dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);
                dec(x);inc(y);
              end;
              if not(memtrouve) and not(sortir) and (not(posaig) or (posAig and (position=const_devie))) then
              begin
                ancienX:=x;ancienY:=y;
                dec(y);
                el_tco(ancienx,ancienY,x,y,train,ir);  // nouvelle itération
              end;
              if (position=const_inconnu) and posaig then sortir:=true;
            end;
          end;

         else

         begin
           // fausse route, sortir
           if DebugTCO then
             AfficheDebug('Sortie de calcul route TCO'+intToSTR(indexTCO)+' par élement '+intToSTR(Bimage)+' inconnu en x='+intToSTR(x)+' y='+intToSTR(y)+' sur route '+intToSTR(det1)+' à '+intToSTR(det2),clOrange);
           sortirBoucle:=true;
         end;
     end;

     but:=tco[indexTCO,x,y].buttoir;

     inc(i);
     // éléments adj
     if (mode=11) and ( (adresse<>0) or (tco[indexTCO,x,y].buttoir<>0)) then sortir:=true;
     //if (mode=11) and ((adresse=0) or (tco[indexTCO,x,y].buttoir<>0)) then sortir:=true;
     if (mode=12) and ( ((adresse<>0) and (adresse<>det1)) or (tco[indexTCO,x,y].buttoir<>0)) then sortir:=true;

     if (mode=13) and ( ((adresse<>0) and (adresse<>det1)) or (tco[indexTCO,x,y].buttoir<>0)) then begin
     sortir:=true;memtrouve:=true;end;

     if (adresse=det2) and (adresse<>0) then memTrouve:=true;
     if (adresse=0) and (det2=0) and (but<>0) then memTrouve:=true;
     if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and ((adresse<>det2) and (adresse<>det1) and (adresse<>0)) then sortirBoucle:=true;
     if (i>200) or (iteration>200) then sortir:=true;
     Maj_coords(AncienX,AncienY,x,y);
   until sortir or memtrouve or SortirBoucle;
   result:=memTrouve;
   if DebugTCO and not(memtrouve) and not(sortir) then
     AfficheDebug('Fin de boucle dét '+intToSTR(det2)+' non trouvé',clOrange);

   //mémoriser l'index de route si on a trouvé det2, et uniquement sur la première itération quand on l'a trouvé
   if memTrouve and not(indextrouve) then
   begin
     if debugTCO and (mode<>10) then AfficheDebug('Trouvé '+intToSTR(det2),clLime);
     indexTrouve:=true;
     indexIr:=ir-1;
   end;
   if sortir and ((mode=11) or (mode=12)) and debugTCO then AfficheDebug('Trouvé '+intToSTR(det2),clLime);

   if i>200 then AfficheDebug('Erreur 487 : limite d''itérations TCO'+intToSTR(indexTCO)+' trajet de '+intToSTR(det1)+' à '+intToSTR(det2)+' x='+intToSTR(x)+' y='+intToSTR(y),clred);
   if iteration>200 then AfficheDebug('Erreur 488 : limite de récursivité TCO'+intToSTR(indexTCO)+'trajet de '+intToSTR(det1)+' à '+intToSTR(det2)+' x='+intToSTR(x)+' y='+intToSTR(y),clred);
  end;


// Début de la procédure zone_tco_gx, qui affiche le tracé
begin
  if debugTCO then
  begin
    if mode<>11 then AfficheDebug('Zone_TCO'+intToSTR(indexTCO)+' det1='+intToSTR(det1)+' det2='+intToSTR(det2)+' Train'+intToSTR(Train)+' mode='+intToSTR(mode),clWhite);
    if mode=11 then  AfficheDebug('Zone_TCO'+intToSTR(indexTCO)+' canton='+intToSTR(det1)+' dir='+intToSTR(det2)+' mode='+intToSTR(mode),clWhite);
  end;
  if (IndexTCO<1) or (IndexTCO>NbreTCO) then exit;
  if (PcanvasTCO[indexTCO]=nil) and (mode<10) then exit;

  if (mode<=10) then
  begin
    // départ aux coordonnées X1 Y1
    trouve_el(indexTCO,det1,det,Xdet1,Ydet1);
    if (Xdet1=0) or (Ydet1=0) then exit;
  end;

  AdrTr1:=Detecteur[det1].AdrTrain;
  AdrTr2:=Detecteur[det2].AdrTrain;

  memtrouve:=false;
  NbTrouve:=0;
  indextrouve:=false;

  if mode<=10 then Direction:=1    // on teste 4 directions: 1=SE 2=NO 3=SO 4=NE
  else
  begin
    Direction:=det2;
  end;

  repeat  // boucle de test de direction
    sortir:=false;
    if mode<=10 then
    begin
      // départ
      x:=xDet1;
      y:=Ydet1;
    end;
    if mode=11 then
    begin
     if det1=0 then
     begin
       Affiche('Erreur 122 ',clred);
       exit;
     end;
      x:=canton[det1].x;
      y:=canton[det1].y;
    end;
    if mode=12 then
    begin
      trouve_El(indexTCO,det1,det,x,y);
    end;
    if mode=13 then
    begin
      if (typEL=tjd) or (typEL=tjs) then typEL:=aig;
      trouve_El(indexTCO,det1,TypEl,x,y);
    end;

    xn:=x;yn:=y;
    ir:=1;    // index de la route du tco
    i:=0;     // itérations
    if debugTCO then afficheDebug('Direction '+intToSTR(direction),clOrange);

    // initialiser les points d'où l'on vient
    case direction of
    1 : begin
      // du SE
      if mode<=10 then
      begin ancieny:=ydet1+1;ancienx:=xdet1+1;end
      else
      // vers gauche
      begin ancieny:=y; ancienx:=x+1; end;
    end;
    2 : begin
      // du NO
      if mode<=10 then
      begin ancieny:=ydet1-1;ancienx:=xdet1-1;end
      else
      // vers droite
      begin ancieny:=y; ancienx:=x-1; end;
    end;
    3 : begin
      // du SO
      if mode<=10 then
      begin ancieny:=ydet1+1;ancienx:=xdet1-1;end
      else
      // vers bas
      begin ancieny:=y-1; ancienx:=x; end;
    end;
    4 : begin
      // du NE
      if mode<=10 then
      begin ancieny:=ydet1-1;ancienx:=xdet1+1;end
      else
      // vers haut
      begin ancieny:=y+1; ancienx:=x; end;
    end;

    // uniquement modes 11/12/13: recherche élément à gauche
    SensTCO_O : begin
          ancienx:=x+1; ancieny:=y;
        end;
    // uniquement mode 11/12/13: recherche élément à droite
    SensTCO_E : begin
          ancienx:=x-1; ancieny:=y;
        end;
    // uniquement mode 11/12/13: recherche élément NO
    SensTCO_NO : begin
          ancienx:=x+1; ancieny:=y+1;
        end;

    // uniquement mode 11/12/13: recherche élément NE
    SensTCO_NE : begin
          ancienx:=x-1; ancieny:=y+1;
        end;

    // uniquement mode 11/12/13: recherche élément SE
    SensTCO_SE : begin
          ancienx:=x-1; ancieny:=y-1;
        end;

    // uniquement mode 11/12/13: recherche élément SO
    SensTCO_SO : begin
          ancienx:=x+1; ancieny:=y-1;
        end;

    // uniquement mode 11/12/13: recherche élément en haut
    SensTCO_N : begin
          ancienx:=x; ancieny:=y+1;
        end;
    // uniquement mode 11/12/13: recherche élément en bas
    SensTCO_S : begin
          ancienx:=x; ancieny:=y-1;
        end;
    end;

    if debugTCO then AfficheDebug('X='+intToSTR(x)+' Y='+IntToSTR(Y)+' AncienX='+intToSTR(ancienX)+' AncienY='+IntToSTR(ancienY),clyellow);

    // Affiche la cellule en fonction du mode
    iteration:=0;
    ir:=1;
    if mode=10 then
    begin
      xCanton:=0;
      ycanton:=0;
    end;

    el_tco(ancienx,ancienY,x,y,train,ir);   // *********** trouve l'élément suivant, et explore les ports de l'aiguillage en récursif si posAig=true

//    if (mode=11) and ((adresse<>0) or (but<>0) or sortir) then
    if (mode=11) then
    begin
      MemTrouve:=true;
      Xcanton:=adresse;
      if IsAigTJDCroiTCO(Bimage) then Tel1:=aig else tel1:=det;
      if but<>0 then tel1:=Buttoir;
    end;
    if ((mode=12) or (mode=13)) and (adresse<>det1) then
    begin
      Xcanton:=adresse;
      if IsAigTJDCroiTCO(Bimage) then Tel1:=aig else tel1:=det;
      Memtrouve:=true;
    end;

    if debugTCO then AfficheDebug('retour',clWhite);
    inc(i);
    if (adresse=det2) then memTrouve:=true;
    if (mode<=10) and ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and ((adresse<>det2) and (adresse<>det1) and (adresse<>0)) then sortir:=true;
    //if (mode>10) and ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and ((adresse<>det2) and (adresse<>det1) and (adresse<>0)) then sortir:=true;

    if (i>NbCellulesTCO[indexTCO]) then AfficheDebug('Erreur 1000 TCO'+intToSTR(indexTCO)+' : dépassement d''itérations - Route de '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    inc(direction)
  until ((direction=5) and (mode<=10)) or ((direction=9) and (mode>=11)) or memtrouve  ;

  if memTrouve then
  begin
    if debugTco then
    begin
      afficheDebug('TCO: Trouvé route de '+intToSTR(det1)+' à '+intToSTR(det2),clLime);
      if (mode=10) and (xCanton<>0) and (ycanton<>0) then afficheDebug('TCO: Trouvé canton en '+intToSTR(xCanton)+','+intToSTR(yCanton),clLime);
      if (mode=11) then AfficheDebug('Trouvé1='+intToSTR(xcanton),clLime);
    end;
    if mode<3 then
    begin
      if AdrTr1<>0 then
      begin
        AdrTr:=AdrTr1;
        //Affiche(intToSTR(det1)+' '+intToSTR(det2)+' Mode '+intToSTR(mode)+' Le détecteur1 '+intToSTR(Det1)+ ' est affecté au train @'+intToSTR(AdrTr1),clYellow);
      end;
      if AdrTr2<>0 then
      begin
        AdrTr:=Adrtr2;
        //Affiche(intToSTR(det1)+' '+intToSTR(det2)+' Mode '+intToSTR(mode)+' Le détecteur2 '+intToSTR(Det2)+ ' est affecté au train @'+intToSTR(AdrTr2),clYellow);
      end;
      Affiche_trajet(indexTCO,train,AdrTrain,indexIr,mode,affecte_loco);     // affiche le trajet dans le TCO
    end;
  end;
end;

// fonction appellable en modes 1 2 3 10 11 12
// affiche le tracé de det1 à det2; n°Train n°i (pas son index), adresseTrain, mode=0=éteint =1 allumejaune =2 allume selon index,
// posAig=false : ne tient pas compte de la position des aiguillages pour le tracé (cherche en récursif det2
//       = true : suit le tracé suivant la position des aiguillages jusque det2
// affecte_loco=true : affecte loco si on rencontre un canton. Si mode=0 çà désaffecte la loco au canton
//             =false : ne change pas l'affectation d'un canton rencontré
function zone_tco(indexTCO,det1,det2,train,adrTrain,mode: integer;posAig,affecte_loco : boolean) : boolean; overload;
begin
  result:=zone_tco_gx(indexTCO,det1,det,det2,train,adrTrain,mode,posAig,affecte_loco);
end;

// fonction appellable en mode 13
function zone_tco(indexTCO,adr : integer;typEl : tequipement;sens,mode: integer;posAig,affecte_loco : boolean) : boolean; overload;
begin
  result:=zone_tco_gx(indexTCO,adr,typEL,sens,0,0,mode,posAig,affecte_loco);
end;


// positionne l'icone du groupe G2 (signal, quai, action)
procedure positionne_icone_G2(IndexTCO : integer;ip : timage;lbl : tlabel;i : integer);
const NbElLi=12;
var s : string;
     l : integer;
begin
 l:=formTCO[1].groupBox1.Width;
 dec(i,17);

 if ip<>nil then
      begin
        with ip do
        begin
          width:=licone;
          height:=hicone;
          left:=((i-1) mod NbElLi)*(licone+20)+l+xicones;
          top:= ((i-1) div NbElLi)*(hicone+10)+8;
          with canvas do
          begin
            Pen.Color:=clFond[IndexTCO];
            Brush.color:=clFond[IndexTCO];
            Rectangle(0,0,licone,hicone);
          end;
        end;
      end;
      if lbl<>nil then
      begin
        with lbl do
        begin
          s:=intToSTR(i+17);
          if i<10 then s:='  '+s;
          caption:=s;
          left:=((i-1) mod NbElLi)*(licone+20)+l+xicones-18;
          top:= ((i-1) div NbElLi)*(hicone+10)+16;
        end;
      end;
end;

// positionne l'icone d'image ip et la place en x y d'après son index i
procedure positionne_iconeLbIm(IndexTCO : integer;ip : timage;lbl : tlabel;i : integer);
const NbElLi=12;
var s : string;
    l : integer;
begin
  l:=formTCO[1].groupBox1.Width;

  if (i>=32) and (i<=34) then dec(i,2);

  if ip<>nil then
  begin
    with ip do
    begin
      width:=licone;
      height:=hicone;
      left:=((i-1) mod NbElLi)*(licone+20)+l+Xicones;
      top:= ((i-1) div NbElLi)*(hicone+10)+8;
      with canvas do
      begin
        Pen.Color:=clFond[IndexTCO];
        Brush.color:=clFond[IndexTCO];
        Rectangle(0,0,licone,hicone);
      end;
    end;
  end;
  if lbl<>nil then
  begin
    with lbl do
    begin
      if (i=35) or (i=36) or (i=37) then s:=intToSTR(i+15) else
      if (i>=30) and (i<=32) then
      s:=intToSTR(i+2)
      else
        s:=intToSTR(i);
      if i<10 then s:='  '+s;
      caption:=s;
      left:=((i-1) mod NbElLi)*(licone+20)+l+Xicones-18;
      top:= ((i-1) div NbElLi)*(hicone+10)+16;
    end;
  end;
end;

// dessine les icones du bandeau du tco et les aligne
procedure dessine_icones(indexTCO : integer);
var ancH,ancW,i,lf,hf,sauv_ep: integer;
    ip : TImage;
    lbl : Tlabel;
begin
  // d'abord on positionne les icones
  with formTCO[indexTCO] do
  begin

    // groupe 1 les voies, les aiguillages, les TJD
    for i:=1 to 29 do
    begin
      ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
      lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
      positionne_iconeLbIm(indexTCO,ip,lbl,i);
    end;

    for i:=32 to 34 do
    begin
      ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
      lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
      positionne_iconeLbIm(IndexTCO,ip,lbl,i);
    end;


    // groupe 2
    i:=Id_signal;
    ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
    lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
    positionne_icone_G2(IndexTCO,ip,lbl,i);
    i:=Id_Quai;
    ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
    lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
    positionne_icone_G2(IndexTCO,ip,lbl,i);
    i:=Id_action;
    ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
    lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
    positionne_icone_G2(IndexTCO,ip,lbl,i);
    i:=Id_canton;
    ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
    lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
    positionne_icone_G2(IndexTCO,ip,lbl,i);



    // signal
    ip:=findComponent('ImagePalette51') as Timage;
    if ip<>nil then
    begin
      with ip do
      begin
        with canvas do
        begin
          Pen.Color:=clFond[IndexTCO];
          Brush.color:=clFond[IndexTCO];
          Rectangle(0,0,licone,hicone);
        end;
      end;
    end;

    // et puis on les dessine
    sauv_ep:=epaisseur;
    epaisseur:=3;
    ancw:=LargeurCell[indexTCO];
    AncH:=hauteurCell[indexTCO];
    hauteurCell[indexTCO]:=ImagePalette1.Height;
    LargeurCell[indexTCO]:=ImagePalette1.Width;
    dessin_5(indexTCO,ImagePalette5.Canvas,1,1,0);  //posX,posY,état,position
    dessin_2(indexTCO,ImagePalette2.Canvas,1,1,0);
    dessin_3(indexTCO,ImagePalette3.Canvas,1,1,0);
    dessin_4(indexTCO,ImagePalette4.Canvas,1,1,0);
    dessin_1(indexTCO,ImagePalette1.canvas,1,1,0);
    dessin_6(indexTCO,ImagePalette6.canvas,1,1,0);
    dessin_7(indexTCO,ImagePalette7.canvas,1,1,0);
    dessin_8(indexTCO,ImagePalette8.canvas,1,1,0);
    dessin_9(indexTCO,ImagePalette9.canvas,1,1,0);
    dessin_10(indexTCO,ImagePalette10.Canvas,1,1,0);
    dessin_11(indexTCO,ImagePalette11.Canvas,1,1,0);
    dessin_12(indexTCO,ImagePalette12.Canvas,1,1,0);
    dessin_13(indexTCO,ImagePalette13.Canvas,1,1,0);
    dessin_14(indexTCO,ImagePalette14.Canvas,1,1,0);
    dessin_15(indexTCO,ImagePalette15.Canvas,1,1,0);
    dessin_16(indexTCO,ImagePalette16.canvas,1,1,0);
    dessin_17(indexTCO,ImagePalette17.canvas,1,1,0);
    dessin_18(indexTCO,ImagePalette18.canvas,1,1,0);
    dessin_19(indexTCO,ImagePalette19.canvas,1,1,0);
    dessin_20(indexTCO,ImagePalette20.canvas,1,1,0);
    dessin_21(indexTCO,ImagePalette21.canvas,1,1,0);
    dessin_22(indexTCO,ImagePalette22.canvas,1,1,0);
    dessin_23(indexTCO,ImagePalette23.canvas,1,1,0);
    dessin_24(indexTCO,ImagePalette24.canvas,1,1,0);
    dessin_25(indexTCO,ImagePalette25.canvas,1,1,0);
    dessin_26(indexTCO,ImagePalette26.canvas,1,1,0);
    dessin_27(indexTCO,ImagePalette27.canvas,1,1,0);
    dessin_28(indexTCO,ImagePalette28.canvas,1,1,0);
    dessin_29(indexTCO,ImagePalette29.canvas,1,1,0);
    dessin_32(indexTCO,ImagePalette32.canvas,1,1,0);
    dessin_33(indexTCO,ImagePalette33.canvas,1,1,0);
    dessin_34(indexTCO,ImagePalette34.canvas,1,1,0);

    dessin_Quai(indexTCO,ImagePalette51.canvas,1,1,0); //quai
    dessin_Action(indexTCO,ImagePalette52.canvas,1,1); //action
    dessin_icone_canton(indexTCO,ImagePalette53.canvas,1,1,0); //action


    LargeurCell[indexTCO]:=20;

    with formprinc.Image9Feux do
    begin
      lf:=width;
      hf:=height;
    end;
    With ImagePalette50 do
    begin
      Picture.Bitmap.TransparentMode:=tmAuto;
      Picture.Bitmap.TransparentColor:=clblue;
      Transparent:=true;
    end;
      //Picture.Bitmap:=Formprinc.Image9feux.Picture.Bitmap;
      TransparentBlt(ImagePalette50.canvas.Handle,8,0,LargeurCell[indexTCO],hauteurCell[indexTCO],
                 formprinc.Image9Feux.Canvas.Handle,0,0,50,90,clBlue);
  end;
  LargeurCell[indexTCO]:=ancW;
  hauteurCell[indexTCO]:=ancH;
  epaisseur:=sauv_ep;
end;

procedure positionne(indexTCO : integer);
var clLarge,ClHaut : integer;
begin
  with formTCO[indexTCO] do
  begin
    clLarge:=Width;
    clHaut:=Height;

    panelBas.width:=clLarge-5;
    PanelBas.Top:=clHaut-PanelBas.Height-50; // 50=entete de la fenetre

    with ScrollBox do
    begin
      if diffusion then Width:=clLarge-55 // laisser 50 pixels pour la trackbarzoom + scrollBar
      else Width:=clLarge-500;  // &&& mode pour voir les imageTemp
      top:=0;
      left:=0;
    end;

   // if MasqueBandeauTCO then
    if bandeauMasque then
    begin
      //BandeauMasque:=true;
      PanelBas.Hide;
      //ScrollBox.Height:=clientHeight;
      ScrollBox.Height:=ClHaut-ScrollBox.Top-58;
    end
    else
    begin
      BandeauMasque:=false;
      PanelBas.show;
      ScrollBox.Height:=ClHaut-PanelBas.Height-ScrollBox.Top-58;
    end;
  end;
end;

procedure titre_fenetre(indexTCO : integer);
begin
  FormTCO[IndexTCO].Caption:='TCO'+intToSTR(indexTCO)+' : '+NomFichierTCO[indexTCO];
end;

procedure TFormTCO.FormActivate(Sender: TObject);
//procedure PFormTCO[indexTCO].FormActivate(Sender: TObject);
var indextco : integer;
begin
  indextco:=index_TCO(sender);
  IndexTCOCourant:=indexTCO;
  if affevt or (debug=1) then Affiche('Form TCO'+intToSTR(indexTCO)+' activate',clyellow);
  titre_fenetre(indexTCO);
  if indexTCO=0 then exit;
  {initalisation des dimensions du tco - à ne faire qu'une fois}
  if not(Forminit[indexTCO]) then
  begin
    ButtonCalibrage.Visible:=not(diffusion);
    ButtonSimu.Visible:=not(Diffusion);
    ImageTemp.Visible:=not(Diffusion);
    ImageTemp2.Visible:=not(Diffusion);

    hauteurCell[indexTCO]:=ImagePalette1.Height;
    LargeurCell[indexTCO]:=ImagePalette1.Width;
    LargeurCelld2[indexTCO]:=LargeurCell[indexTCO] div 2;hauteurCelld2[indexTCO]:=hauteurCell[indexTCO] div 2;
    calcul_reduction(frxGlob[indexTCO],fryGlob[indexTCO],LargeurCell[indexTCO],hauteurCell[indexTCO]);

    NbCellulesTCO[indexTCO]:=NbreCellX[indexTCO]*NbreCellY[indexTCO];
    ImageTCO.Width:=LargeurCell[indexTCO]*NbreCellX[indexTCO];
    ImageTCO.Height:=hauteurCell[indexTCO]*NbreCellY[indexTCO];

    ImageTCO.Picture.Create;
    ImageTCO.Picture.Bitmap.Height:=hauteurCell[indexTCO]*NbreCellY[indexTCO];
    ImageTCO.Picture.BitMap.Width:=LargeurCell[indexTCO]*NbreCellX[indexTCO];

    //initialiser les pointeurs images du tco
    PCanvasTCO[indextco]:=FormTCO[indextco].ImageTCO.Picture.Bitmap.Canvas;
    PBitMapTCO[indextco]:=FormTCO[indextco].ImageTCO.Picture.Bitmap;
    PImageTCO[indextco]:=FormTCO[indextco].ImageTCO;

    // initialiser le pointeur image temporaire du TCO
    PImageTemp[indextco]:=FormTCO[indextco].ImageTemp;

    dessine_icones(indexTCO);

    //déclenche l'Affiche_tco
    if ZoomInit[indexTCO]<>0 then FormTCO[indexTCO].TrackBarZoom.Position:=ZoomInit[indexTCO] else TrackBarZoom.position:=34;
    TrackBarZoom.Max:=ZoomMax;
    TrackBarZoom.Min:=ZoomMin;

    positionne(indexTCO);

    renseigne_tous_cantons;
    renseigne_TJDs_TCO;
    FormInit[indexTCO]:=true;
  end;
  if indexTCO=NbreTCO then TCOActive:=true;
end;


// vérifie que les icones adjacentes sont cohérentes  - ne pas utiliser....
function verif_cellule(IndexTCO,x,y,Bim : integer) : boolean;
var res,verif : boolean;
    Bimz,i,bl : integer;
begin
  result:=true;
  verif:=false;
  if (bim>=Id_signal) or (AvecVerifIconesTCO=0) then exit;

  res:=true;
  bl:=liaisons[Bim];
  for i:=0 to 7 do
  begin
    //Affiche(IntToHex(bl,2),clyellow);
    // NO
    if testbit(bl,i) then
    begin
      if (i=0) then
      begin
        if (x>1) and (y>1) then
        begin
          Bimz:=tco[indexTCO,x-1,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],4) ) then res:=false;
        end;
        if x>1 then
        begin
          Bimz:=tco[indexTCO,x-1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],2) then res:=false;
        end;
        if y>1 then
        begin
          Bimz:=tco[indexTCO,x,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],6) then res:=false;
        end;
        if verif and not(res) then affiche('NO 0',clred);
      end;

      // N
      if (i=1) then
      begin
        if (y>1) then
        begin
          Bimz:=tco[indexTCO,x,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],5) ) then res:=false;
        end;
        if verif and not(res) then affiche('N 1',clred);
      end;

      // NE
      if (i=2) then
      begin
        if (x<NbreCellX[indexTCO]) and (y>1) then
        begin
          Bimz:=tco[indexTCO,x+1,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],6) ) then res:=false;
        end;
        if (x<NbreCellX[indexTCO]) then
        begin
          Bimz:=tco[indexTCO,x+1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],0) then res:=false;
        end;
        if (y>1) then
        begin
          Bimz:=tco[indexTCO,x,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],4) then res:=false;
        end;
        if verif and not(res) then affiche('NE 2',clred);
      end;

      // E
      if (i=3) then
      begin
        if (x<NbreCellX[indexTCO]) then
        begin
          Bimz:=tco[indexTCO,x+1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],7) ) then res:=false;
        end;
        if verif and not(res) then affiche('E 3',clred);
      end;

      // SE
      if (i=4) then
      begin
        if (x<NbreCellX[indexTCO]) and (y<NbreCellY[indexTCO]) then
        begin
          Bimz:=tco[indextco,x+1,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],0) ) then res:=false;
        end;
        if (x<NbreCellX[indexTCO]) then
        begin
          Bimz:=tco[indextco,x+1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],6) then res:=false;
        end;
        if (y<NbreCellY[indexTCO]) then
        begin
          Bimz:=tco[indextco,x,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],2) then res:=false;
        end;
        if verif and not(res) then affiche('SE 4',clred);
      end;

      // S
      if (i=5) then
      begin
        if (y<NbreCelly[indexTCO]) then
        begin
          Bimz:=tco[indexTCO,x,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],1) ) then res:=false;
        end;
        if verif and not(res) then affiche('S 5',clred);
      end;

      // SO
      if (i=6) then
      begin
        if (x>1) and (y<NbreCelly[indexTCO]) then
        begin
          Bimz:=tco[indextco,x-1,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],2) ) then res:=false;
        end;
        if x>1 then
        begin
          Bimz:=tco[indextco,x-1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],4) then res:=false;
        end;
        if (y<NbreCelly[indexTCO]) then
        begin
          Bimz:=tco[indextco,x,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],0) then res:=false;
        end;
        if verif and not(res) then affiche('SO 6',clred);
      end;

      // O
      if (i=7) then
      begin
        if (x>1) then
        begin
          Bimz:=tco[indextco,x-1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],3) ) then res:=false;
        end;
        if verif and not(res) then affiche('O 7',clred);
      end;
    end;
  end;

  //if res=true then Affiche('oui',ClLime) else Affiche('non',clred);
  result:=res;
end;

// supprime le canton index et efface son dessin, le remplace par des voies
procedure supprime_remplace_canton(index : integer);
var el,i,n,xc,yc,idT : integer;
begin
  if (index<1) or (index>ncantons) then exit;

  // désaffecter le train du canton
  i:=canton[index].indexTrain;
  if i<>0 then
  begin
    affecte_Train_canton(0,index,0);
  end;

  n:=canton[index].Nelements;
  xc:=canton[index].x;
  yc:=canton[index].y;
  idT:=canton[index].Ntco;
  El:=tco[idt,xc,yc].BImage;

  if isCantonH(El) then
  begin
    for i:=xc to xc+n-1 do
    begin
      tco[idT,i,yc].BImage:=1;
      tco[idT,i,yc].Texte:='';
      tco[idT,i,yc].NumCanton:=0;
      tco[idT,i,yc].FeuOriente:=0;
    end;
  end
  else
  if isCantonV(El) then
  begin
    for i:=yc to yc+n-1 do
    begin
      tco[idT,xc,i].BImage:=20;
      tco[idT,xc,i].Texte:='';
      tco[idT,xc,i].NumCanton:=0;
      tco[idT,xc,i].FeuOriente:=0;
    end;
  end;

  //Affiche('Nel canton 12='+intToSTR(canton[12].Nelements),clYellow);

  supprime_canton(index);
end;

// efface le contenu de la cellule, sauf le fond
procedure raz_cellule(indexTCO,x,y : integer);
var bim : integer;
begin
  bim:=tco[indexTCO,x,y].BImage;
  if iscanton(bim) then
  begin
    bim:=index_canton(indexTCO,x,y);
    if bim<>0 then supprime_canton(bim);
  end;

  tco[indextco,x,y].Adresse:=0;
  tco[indextco,x,y].Mode:=0;
  tco[indextco,x,y].Trajet:=0;
  tco[indextco,x,y].inverse:=false;
  tco[indextco,x,y].repr:=0;
  tco[indextco,x,y].Bimage:=0;
  tco[indextco,x,y].liaisons:=0;
  tco[indextco,x,y].epaisseurs:=0;
  tco[indextco,x,y].buttoir:=0;
  tco[indextco,x,y].pont:=0;
  tco[indextco,x,y].sortie:=0;
  tco[indextco,x,y].Texte:='';
  tco[indextco,x,y].Fonte:='';
  tco[indextco,x,y].FontStyle:='';
  tco[indextco,x,y].CoulFonte:=0;
  // tco[indextco,x,y].CouleurFond:=0;
  tco[indextco,x,y].PiedSignal:=0;
  tco[indexTCO,x,y].NumCanton:=0;
  tco[indextco,x,y].x:=0;
  tco[indextco,x,y].y:=0;
  tco[indextco,x,y].xUndo:=0;
  tco[indextco,x,y].yUndo:=0;
  tco[indextco,x,y].FeuOriente:=0;
end;

// insère une colonne dans le Tco indexTCO à la colonne "colonne"
procedure insere_colonne(indexTCO,colonne : integer);
var x,y,i,Bim,xx,n,xc,yc : integer;
begin
  if NbreCellX[indexTCO]>=MaxCellX then exit;

  // balayer les cantons pour corriger leurs coordonnées
  for i:=1 to nCantons do
  begin
    x:=canton[i].x;
    if x>=colonne then inc(canton[i].x);
  end;

  xc:=0;
  // voir si la colonne contient un canton horz, et réajuster son nombre
  for y:=1 to NbreCellY[indexTCO] do
  begin
    if isCantonH(tco[indexTCO,colonne,y].BImage) then
    begin
      yc:=y;xc:=colonne;
      origine_canton(xc,yc);
      n:=tco[indexTCO,xc,yc].NumCanton;
      if n<>0 then
      begin
        i:=index_canton_numero(n);
        //Affiche('Canton '+intToSTR(n)+' réajusté',clOrange);
        if canton[i].Nelements<10 then
        begin
          inc(canton[i].Nelements);
          inc(tco[indexTCO,xc,yc].FeuOriente);
        end
      end;
    end;
  end;

  // insère la nouvelle colonne
  for x:=NbreCellX[indexTCO] downto colonne do
  begin
    for y:=1 to NbreCellY[indexTCO] do
    begin
      tco[indextco,x+1,y]:=tco[indextco,x,y];
    end;
  end;

  // efface la nouvelle colonne
  for y:=1 to NbreCellY[indexTCO] do
  begin
    Bim:=tco[indexTco,colonne,y].Bimage;
    if not(isCantonH(Bim)) then raz_cellule(indextco,colonne,y);
    tco[indextco,colonne,y].Couleurfond:=Clfond[IndexTCO];
  end;

  inc(NbreCellX[indexTCO]);

  // verifier si les cantons horizontaux: corriger leurs origine y et ses Bimage
  for x:=1 to NbreCellX[indexTCO] do
    for y:=1 to NbreCellY[indexTCO] do
    begin
      Bim:=tco[indextco,x,y].BImage;
      if Bim=id_CantonH then
      begin
        i:=tco[indexTCO,x,y].NumCanton;
        i:=Index_canton_numero(i);
        n:=canton[i].Nelements;
        canton[i].x:=x;   // origine X
        i:=0;
        for xx:=x to x+n-1 do     // parcourir les Bimage du canton
        begin
          tco[indexTCO,xx,y].BImage:=Id_CantonH+i;
          inc(i);
        end;
        if isCantonH(tco[indexTCO,x+n,y].BImage) then tco[indexTCO,x+n,y].BImage:=0;
      end;
    end;

  // verifier si les cantons horz: corriger leurs origine y et ses Bimage
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
    begin
      Bim:=tco[indextco,x,y].BImage;
      if Bim=id_CantonH then
      begin
        i:=tco[indexTCO,x,y].NumCanton;
        i:=Index_canton_numero(i);
        n:=canton[i].Nelements;
        canton[i].x:=x;   // origine X
        i:=0;
        for xx:=x to x+n-1 do     // parcourir les Bimage du canton
        begin
          tco[indexTCO,xx,y].BImage:=Id_CantonH+i;
          inc(i);
        end;
        if isCantonH(tco[indexTCO,x+n,y].BImage) then tco[indexTCO,x+n,y].BImage:=0;
      end;
    end;

  tco_modifie:=true;
end;

procedure insere_ligne(indexTCO,ligne : integer);
var x,y,i,n,yy,xc,yc,Bim : integer;
begin
  if NbreCellY[indexTCO]>=MaxCellY then exit;

  // balayer les cantons pour corriger leurs coordonnées
  for i:=1 to nCantons do
  begin
    y:=canton[i].y;
    if y>=ligne then inc(canton[i].y);
  end;

  yc:=0;
  // voir si la ligne contient un canton vertical, réajuster son nombre
  for x:=1 to NbreCellX[indexTCO] do
  begin
    if isCantonV(tco[indexTCO,x,ligne].BImage) then
    begin
      xc:=x;yc:=ligne;
      origine_canton(xc,yc);
      n:=tco[indexTCO,xc,yc].NumCanton;
      if n<>0 then
      begin
        i:=index_canton_numero(n);
        //Affiche('Canton '+intToSTR(n)+' réajusté',clOrange);
        if canton[i].Nelements<10 then
        begin
          inc(canton[i].Nelements);
          inc(tco[indexTCO,xc,yc].FeuOriente);
        end
      end;
    end;
  end;

  // insère la ligne
  for y:=NbreCellY[indexTCO] downto ligne do
    for x:=1 to NbreCellX[indexTCO] do
    begin
      tco[indextco,x,y+1]:=tco[indextco,x,y];
    end;      

  // efface la nouvelle ligne
  for x:=1 to NbreCellX[indexTCO] do
  begin
    Bim:=tco[indexTco,x,ligne].Bimage;
    if not(isCantonV(Bim)) then raz_cellule(indextco,x,ligne);
    tco[indextco,x,ligne].Couleurfond:=Clfond[IndexTCO];
  end;
  inc(NbreCellY[indexTCO],1);

  // verifier si les cantons verticaux: corriger leurs origine y et ses Bimage
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
    begin
      Bim:=tco[indextco,x,y].BImage;
      if Bim=id_CantonV then
      begin
        i:=tco[indexTCO,x,y].NumCanton;
        i:=Index_canton_numero(i);
        n:=canton[i].Nelements;
        canton[i].y:=y;   // origine Y
        i:=0;
        for yy:=y to y+n-1 do     // parcourir les Bimage du canton
        begin
          tco[indexTCO,x,yy].BImage:=Id_CantonV+i;
          inc(i);
        end;
        if isCantonV(tco[indexTCO,x,y+n].BImage) then tco[indexTCO,x,y+n].BImage:=0;
      end;
    end;

  tco_modifie:=true;
end;

// crée un canton
// si numéro=0, un numéro sera attribué
// si numéro<>0 ce numéro sera attribué
procedure cree_canton(indexTCO,x,y,numero : integer;Horz : boolean);
var maxi,libre,nc,i : integer;
begin
  if numero=0 then
  begin
    maxi:=0; Libre:=0;
    for nc:=1 to nCantons do
    begin
      if canton[nc].numero>maxi then maxi:=canton[nc].numero;      // trouve le numéro maxi de canton
      if (nc>=2) and (nc<nCantons) then if canton[nc].numero+1<>canton[nc+1].numero then
      begin
        libre:=canton[nc].numero+1;
        for i:=1 to nCantons do if canton[i].numero=Libre then Libre:=0;
      end;
    end;
    inc(maxi);
    if libre<>0 then Maxi:=Libre;
    numero:=maxi;
  end;

  inc(Ncantons);

  canton[Ncantons].horizontal:=Horz;
  canton[Ncantons].numero:=numero;
  canton[Ncantons].Nelements:=3;
  canton[Ncantons].x:=x;
  canton[Ncantons].y:=y;
  canton[Ncantons].nom:='';
  canton[Ncantons].Ntco:=indexTCO;
  canton[Ncantons].indexTrain:=0;
  canton[Ncantons].adresseTrain:=0;
  canton[Ncantons].NomTrain:='';
  canton[Ncantons].SensLoco:=0;
  canton[Ncantons].NumcantonOrg:=0;
  canton[Ncantons].NumCantonDest:=0;
  canton[Ncantons].bouton:=0;
  tco[indextco,x,y].Texte:='';
  tco[indexTCO,x,y].FeuOriente:=3;  // nbre éléments du canton
  tco[indexTCO,x,y].NumCanton:=Numero;

  if Horz then for i:=1 to 3 do tco[indextco,x+i-1,y].BImage:=id_cantonH+i-1;
  if not(Horz) then for i:=1 to 3 do tco[indextco,x,y+i-1].BImage:=id_cantonV+i-1;
  dessin_canton(Ncantons,0);
  renseigne_canton(Ncantons);
end;


procedure Annule(indextco : integer);
var x,y,xu,yu,Xplace,n,yplace,adresse,i,Bimage,nc,
    Xcanton,Ycanton : integer;
begin
  if (TamponTCO_org.numTCO<>indexTCO) then exit;

  if ligne_supprime<>0 then insere_ligne(indexTCO,ligne_Supprime);
  if colonne_supprime<>0 then insere_colonne(indexTCO,colonne_Supprime);

  if TamponAffecte then
  begin
    if (TamponTCO_org.Xorg<>0) and (TamponTCO_org.Yorg<>0) then
    begin
      for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do       // rectangle de la sélection
        for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
        begin
          xPlace:=TamponTCO_org.Xorg+x-TamponTCO_Org.x1;   // destination
          yPlace:=TamponTCO_org.Yorg+y-TamponTCO_Org.y1;

          if (xPlace<=NbreCellX[indexTCO]) and (yPlace<=NbreCellY[indexTCO]) then
          begin
            Bimage:=tampontco[x,y].BImage;
            if (Bimage=Id_cantonH) or (Bimage=Id_cantonV) then
            begin
              //Affiche('xy='+IntToSTR(x)+','+intToSTR(y)+' Bimage='+intToSTR(Bimage),clYellow);
              Xcanton:=x;Ycanton:=y;
              origine_canton(Xcanton,Ycanton);
              if xcanton=0 then  // cas d'un canton supprimé
              begin
                // reconstituer le canton
                n:=TamponTCO[x,y].FeuOriente;
                nc:=TamponTCO[x,y].NumCanton;
                Cree_canton(indexTCOCourant,x,y,nc,isCantonH(Bimage));
                i:=Index_Canton_numero(nc);
                canton[i].Nelements:=n;
                xcanton:=x;
                ycanton:=y;
              end;
              i:=Index_Canton_numero(tco[indexTCOcourant,xcanton,ycanton].NumCanton);
              if i=0 then Affiche('Annule : canton inconnu',clred); //else affiche('Canton '+intToSTR(tco[indexTCOcourant,xcanton,ycanton].NumCanton),clyellow);
            end;

            tco[indextco,xPlace,yPlace]:=tampontco[x,y];
            if tco[indextco,xPlace,yPlace].Bimage=Id_signal then
            begin
              adresse:=tco[indextco,xPlace,yPlace].Adresse;
            end;
          end;
        end;
    end;
    Affiche_TCO(indextco);
    tco_modifie:=true;
    tamponaffecte:=false;
    ligne_supprime:=0;
    colonne_supprime:=0;
    exit;
  end;

  // restaure par le tampon undo le tracé
  if rangUndo>1 then
  begin
    dec(rangUndo);
    for i:=1 to undo[rangUndo].nombre do
    begin
      xu:=undo[rangUndo].element[i].Xundo;
      yu:=undo[rangUndo].element[i].Yundo;
      if (xu<=NbreCellX[indexTCO]) and (yu<=NbreCellY[indexTCO]) then tco[indextco,xu,yu]:=undo[rangUndo].element[i];
    end;
    Affiche_tco(indexTCO);
    tco_modifie:=true;
    exit;
  end;
end;

procedure stop_modetrace(indexTCO : integer);
begin
  modetrace[indexTCO]:=false;
  screen.cursor:=crDefault;
  IndexTrace:=0;
  traceXY[1].x:=0;traceXY[1].y:=0;
  traceXY[2].x:=0;traceXY[2].y:=0;
  affiche_tco(indexTCO);
  FormTCO[indexTCO].Caption:='TCO'+intToSTR(indexTCO)+' : '+NomFichierTCO[indexTCO];
  screen.cursor:=crDefault;
end;

procedure grille(indexTCO : integer);
var x,y : integer;
begin
  if not(AvecGrille[indexTCO]) then exit;
  With PCanvasTCO[indexTCO] do
  begin
    pen.color:=ClGrille[IndexTCO];
    pen.Width:=1;
    Brush.Color:=ClFond[IndexTCO];
    pen.mode:=PmCopy;
    // lignes verticales
    for x:=1 to NbreCellX[indexTCO] do
    begin
      moveto(x*LargeurCell[indexTCO],1);
      LineTo(x*LargeurCell[indexTCO],hauteurCell[indexTCO]*NbreCelly[indexTCO]);
    end;
    // lignes horizontales
    for y:=1 to NbreCelly[indexTCO] do
    begin
      moveto(1,y*hauteurCell[indexTCO]);
      LineTo(LargeurCell[indexTCO]*NbreCellX[indexTCO],y*hauteurCell[indexTCO]);
    end;
  end;
end;


procedure copier(indexTCO : integer);
var x,y,xmax,ymax,larg,haut : integer;
begin
  if SelectionAffichee[indexTCO] then
  begin
    if FormTCO[indexTCO].RadioGroupSel.ItemIndex=1 then
    begin
      larg:=largeurCell[indexTCO];
      haut:=hauteurCell[indexTCO];
      xMax:=larg*NbreCellX[indexTCO];
      yMax:=haut*NbreCellY[indexTCO];

      xMiniSel:=(Rect_select.Gd.Left div larg)+1;
      yMiniSel:=(Rect_select.Gd.top div haut)+1;
      xMaxiSel:=(Rect_select.Gd.right div larg)+1;
      yMaxiSel:=(Rect_select.Gd.bottom div haut)+1;
      if xminiSel>xMaxiSel then echange(xminiSel,xMaxiSel);
      if yminiSel>yMaxiSel then echange(yminiSel,yMaxiSel);
      if xMiniSel<1 then xMiniSel:=1;
      if xMiniSel>xMax then xMiniSel:=xMax;
      if yMiniSel<1 then yMiniSel:=1;
      if yMiniSel>yMax then yMiniSel:=yMax;
      if xMaxiSel>xMax then xmaxiSel:=xMax;
      if yMaxiSel>yMax then ymaxiSel:=yMax;
    end;

    TamponTCO_org.numTCO:=indexTCO;
    tamponTCO_Org.Xorg:=xMiniSel;
    tamponTCO_Org.Yorg:=yMiniSel;
    TamponTCO_Org.x1:=XminiSel ;
    TamponTCO_Org.x2:=XmaxiSel ;
    TamponTCO_Org.y1:=yminiSel ;
    TamponTCO_Org.y2:=ymaxiSel ;
    for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
      for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      begin
        tampontco[x,y]:=tco[indextco,x,y];
      end;
    TamponAffecte:=true;
  end

  else

  // copie sans sélection : on coupe une seule cellule
  begin
    tampontco[XclicCell[indexTCO],YclicCell[indexTCO]]:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]]; // pour pouvoir faire annuler couper
    TamponTCO_org.x1:=XclicCell[indexTCO];TamponTCO_org.y1:=YclicCell[indexTCO];
    TamponTCO_org.x2:=XclicCell[indexTCO];TamponTCO_org.y2:=YclicCell[indexTCO];
    TamponTCO_org.numTCO:=indexTCO;
    TamponAffecte:=true;
    TamponTCO_org.xOrg:=XclicCell[indexTCO];
    TamponTCO_org.yOrg:=YclicCell[indexTCO];
  end;
end;

procedure couper(indexTCO: integer);
var x,y,xMax,Ymax,XCell1,YCell1,xCell2,yCell2,haut,larg,Bim,index : integer;
    s : string;
    raz_canton: boolean;
begin
  larg:=largeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];

  raz_canton:=false;
  if (XclicCell[indexTCO]=0) or (YclicCell[indexTCO]=0) then exit;
  //Affiche(intToSTR(ancienXclic)+' '+intToSTR(XclicCell[indexTCO]),clred);
  //if (AncienXclic=XclicCell[indexTCO]) and (AncienYclic=YclicCell[indexTCO]) then exit;
  AncienXclic:=XclicCell[indexTCO];
  AncienYclic:=YclicCell[indexTCO];

  {
  with formTCO[indexTCO] do
  begin
    EditAdrElement.Text:='';
    EditTypeImage.Text:='';
    EditTexte.Text:='';
  end;  }

  // couper par la fenetre graphique
  if FormTCO[indexTCO].RadioGroupSel.ItemIndex=1 then
  begin
    xMax:=larg*NbreCellX[indexTCO];
    yMax:=haut*NbreCellY[indexTCO];

    xMiniSel:=(Rect_select.Gd.Left div larg)+1;
    yMiniSel:=(Rect_select.Gd.top div haut)+1;
    xMaxiSel:=(Rect_select.Gd.right div larg)+1;
    yMaxiSel:=(Rect_select.Gd.bottom div haut)+1;
    if xminiSel>xMaxiSel then echange(xminiSel,xMaxiSel);
    if yminiSel>yMaxiSel then echange(yminiSel,yMaxiSel);
    if xMiniSel<1 then xMiniSel:=1;
    if xMiniSel>xMax then xMiniSel:=xMax;
    if yMiniSel<1 then yMiniSel:=1;
    if yMiniSel>yMax then yMiniSel:=yMax;
    if xMaxiSel>xMax then xmaxiSel:=xMax;
    if yMaxiSel>yMax then ymaxiSel:=yMax;
    TamponTCO_org.xOrg:=xminiSel;
    TamponTCO_org.yOrg:=yminiSel;

    //Affiche('xMiniSel='+IntToSTR(xMiniSel)+' yMiniSel='+IntToSTR(yMiniSel)+' xMaxiSel='+IntToSTR(xMaxiSel)+' yMaxiSel='+IntToSTR(yMaxiSel),clOrange);
    //Affiche('xcoupe'+intToSTR(xcoupe),clyellow);

    // effacer le rectangle
    Affiche_Rectangle(IndexTCO,Rect_select);
    Rect_select.NumTCO:=0; // indicateur de non affichage
  end;

  // couper sans sélection : on coupe une seule cellule
  if not(SelectionAffichee[indexTCO]) then
  begin
    // si c'est un canton, le supprimer en remplaçant par les voies
    Bim:=tco[indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]].BImage;

    if isCanton(Bim) then
    begin
      index:=index_canton(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
      s:='Voulez vous supprimer le canton ';
      if index<>0 then s:=s+intToSTR(canton[index].numero)+' '+canton[index].nom;
      s:=s+' ?';
      if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

      bim:=index_canton(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
      supprime_remplace_canton(bim);
      raz_canton:=true;
    end;

    tampontco[XclicCell[indexTCO],YclicCell[indexTCO]]:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]]; // pour pouvoir faire annuler couper
    TamponTCO_org.x1:=XclicCell[indexTCO];TamponTCO_org.y1:=YclicCell[indexTCO];
    TamponTCO_org.x2:=XclicCell[indexTCO];TamponTCO_org.y2:=YclicCell[indexTCO];

    if not(raz_canton) then raz_cellule(indextco,XclicCell[indexTCO],YClicCell[indexTCO]);

    TamponTCO_org.numTCO:=indexTCO;
    efface_entoure(indexTCO);
    efface_cellule(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,XclicCell[indexTCO],YClicCell[indexTCO],PmCopy);
    TamponAffecte:=true;
    TamponTCO_org.xOrg:=XclicCell[indexTCO];
    TamponTCO_org.yOrg:=YclicCell[indexTCO];
    Affiche_tco(indexTCO);
    exit;
  end;

  TCO_modifie:=true;

  // avant de faire copier, supprimer les cantons
  for y:=yminiSel to ymaxiSel do
    for x:=XminiSel to XmaxiSel do
    begin
      Bim:=tco[indexTCO,x,y].BImage;
      if isCanton(Bim) then
      begin
        bim:=index_canton(indexTCO,x,y);
        supprime_remplace_canton(bim);
      end;
    end;

  copier(indexTCO);
  SelectionAffichee[indexTCO]:=false;

  xCell1:=XminiSel;
  xCell2:=XmaxiSel;
  yCell1:=yminiSel;
  yCell2:=ymaxiSel;

  for y:=yCell1 to yCell2 do
    for x:=xCell1 to xCell2 do
    begin
      raz_cellule(indextco,x,y);
      //Affiche('Efface cellules '+IntToSTR(x)+' '+intToSTR(y),clyellow);
      efface_entoure(indexTCO);
      efface_cellule(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,X,Y,PmCopy);
      if avecGrille[indexTCO] then grille(indexTCO);
    end;
end;

// coordonnées cellules
procedure selection_bleue(indexTCO,cellX,cellY : integer);
var xMiniSelP,yminiSelP,xMaxiSelP,ymaxiSelP,larg,haut : integer;
    r : Trect;
begin
  larg:=largeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];

  // zone de sélection bleue en cellules
  xMiniSel:=(Xentoure[indexTCO]);
  yMiniSel:=(Yentoure[indexTCO]);
  xMaxiSel:=(cellX);
  yMaxiSel:=(cellY);

  xminiSelP:=min(xminiSel,xMaxiSel);
  yminiSelP:=min(yminiSel,yMaxiSel);
  xmaxiSelP:=max(xminiSel,xMaxiSel);
  ymaxiSelP:=max(yminiSel,yMaxiSel);

  xminiSel:=xMiniSelP;
  yminiSel:=yMiniSelP;
  xMaxiSel:=xMaxiSelP;
  yMaxiSel:=yMaxiSelP;

  //Affiche('xMiniSel='+IntToSTR(xMiniSel)+' yMiniSel='+IntToSTR(yMiniSel)+' xMaxiSel='+IntToSTR(xMaxiSel)+' yMaxiSel='+IntToSTR(yMaxiSel),clOrange);
  //Affiche('xcoupe'+intToSTR(xcoupe),clyellow);

  // efface l'ancien rectangle de sélection
  if SelectionAffichee[indexTCO] then
  with formTCO[indexTCO].ImageTCO.canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille[IndexTCO];
    Brush.Color:=clblue;
    Rectangle(rAncien);
  end;

  if piloteAig then begin SelectionAffichee[indexTCO]:=false;piloteAig:=false;exit;end;

  r:=Rect((xminiSel-1)*larg,(YminiSel-1)*haut,(XmaxiSel)*larg,(yMaxiSel*haut));

  // Affiche le nouveau rectangle de sélection
  Rancien:=r;
  with formTCO[indexTCO].ImageTCO.canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille[IndexTCO];
    Brush.Color:=clblue;
    //FillRect(r);
    Rectangle(r);
  end;
  SelectionAffichee[indexTCO]:=true;
  if affevt then Affiche('Sélection bleue 1',clCyan);
end;

procedure selec_tout(indexTCO : integer);
begin
  if indexTCO<0 then exit;
  xminiSel:=1;
  yminiSel:=1;
  xMaxiSel:=NbreCellX[indexTCO];
  yMaxiSel:=NbreCellY[indexTCO];
  rAncien:=rect(xminiSel,YminiSel,xmaxiSel*LargeurCell[indexTCO],YMaxiSel*hauteurCell[indexTCO]);

  SelectionAffichee[indexTCO]:=true;
  with formTCO[indexTCO].imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille[IndexTCO];
    Brush.Color:=clblue;
    Rectangle(rAncien);
  end;
  TamponTCO_org.xOrg:=1;
  TamponTCO_org.yOrg:=1;
end;


// pour avoir les evts keydown, il faut dévalider les propriétés tabstop des boutons de la form.
procedure TFormTCO.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var s,d,indexTCO : integer;
    procede : boolean;
begin
  if affevt then Affiche('TCO.FormKeyDown',clOrange);
  indexTCO:=index_TCO(Sender);
  //Affiche('Avant xClicCell='+intToSTR(XClicCell[indexTCO]),clCyan);

  if (RadioGroupSel.ItemIndex=1) and (Key=Vk_Escape) then
  begin
    if Rect_select.NumTCO=indexTCO then affiche_rectangle(IndexTCO,Rect_select);
    Rect_select.NumTCO:=0;
    selectionAffichee[indexTCO]:=false;
    exit;
  end;

  if not(auto_tcurs) or (RadioGroupSel.ItemIndex=1) then exit;

  procede:=false;  // indicateur on a tapé une touche de curseur
  //Affiche(intToSTR(key),clyellow);

  with formTCO[indexTCO] do
  begin
    if not(ssShift in Shift) then
    case Key of
     VK_right : if XclicCell[indexTCO]<NbreCellX[indexTCO] then
                begin
                  inc(XClicCell[indexTCO]);
                  // Affiche('Incrémente',clLime);
                  d:=(xClicCell[indexTCO]+1)*LargeurCell[indexTCO];
                  s:=scrollBox.HorzScrollBar.Position;
                  if d-s>ScrollBox.Width then scrollBox.HorzScrollBar.Position:=s+LargeurCell[indexTCO];
                  procede:=true;
                end
                else exit;
     VK_left  : if XClicCell[indexTCO]>1 then
                begin
                  dec(XClicCell[indexTCO]);
                  d:=(xClicCell[indexTCO]-1)*LargeurCell[indexTCO];
                  s:=scrollBox.HorzScrollBar.Position;
                  if d<=s then
                  begin
                    s:=s-LargeurCell[indexTCO];
                    if s<LargeurCell[indexTCO] then s:=0;
                    scrollBox.HorzScrollBar.Position:=s;
                  end;
                  procede:=true;
                end
                else exit;
     VK_down  : if YClicCell[indexTCO]<NbreCellY[indexTCO] then
                begin
                  inc(YClicCell[indexTCO]);
                  d:=(yClicCell[indexTCO]+1)*hauteurCell[indexTCO];
                  s:=scrollBox.VertScrollBar.Position;
                  if d-s>ScrollBox.Height then scrollBox.VertScrollBar.Position:=s+hauteurCell[indexTCO];
                  procede:=true;
                end
                else exit;
     VK_up    : if YClicCell[indexTCO]>1 then
                begin
                  dec(YClicCell[indexTCO]);
                  d:=(yClicCell[indexTCO]-1)*hauteurCell[indexTCO];
                  s:=scrollBox.VertScrollBar.Position;
                  if d<s then
                  begin
                    s:=s-hauteurCell[indexTCO];
                    if s<hauteurCell[indexTCO] then s:=0;
                    scrollBox.VertScrollBar.Position:=s;
                  end;
                  procede:=true;
                end
                else exit;
     VK_ESCAPE  : begin
                    stop_modetrace(indexTCO);
                  end;
     VK_DELETE : couper(indexTCO);
     end;

     if (ssShift in Shift) then
     case key of
     VK_right :  begin
                   if XClicCell[indexTCO]<NbreCellX[indexTCO] then
                   begin
                     inc(XClicCell[indexTCO]);
                     d:=(xClicCell[indexTCO]+1)*LargeurCell[indexTCO];
                     s:=scrollBox.HorzScrollBar.Position;
                     if d-s>ScrollBox.Width then scrollBox.HorzScrollBar.Position:=s+LargeurCell[indexTCO];
                     procede:=true;
                   end
                   else exit;
                   selection_bleue(indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]);
                   exit;
                 end;
     VK_down :  begin
                   if YClicCell[indexTCO]<NbreCellY[indexTCO] then
                   begin
                     inc(YClicCell[indexTCO]);
                     d:=(yClicCell[indexTCO]+1)*hauteurCell[indexTCO];
                     s:=scrollBox.VertScrollBar.Position;
                     if d-s>ScrollBox.Height then scrollBox.VertScrollBar.Position:=s+hauteurCell[indexTCO];
                     procede:=true;
                   end
                   else exit;
                   selection_bleue(indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]);
                   exit;
                 end;
     VK_up   :  begin
                if YClicCell[indexTCO]>1 then
                begin
                  dec(YClicCell[indexTCO]);
                  d:=(yClicCell[indexTCO]-1)*hauteurCell[indexTCO];
                  s:=scrollBox.VertScrollBar.Position;
                  if d<s then
                  begin
                    s:=s-hauteurCell[indexTCO];
                    if s<hauteurCell[indexTCO] then s:=0;
                    scrollBox.VertScrollBar.Position:=s;
                  end;
                  procede:=true;
                end
                else exit;
                selection_bleue(indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]);
                exit;
                end;
     VK_left  : begin
                if XClicCell[indexTCO]>1 then
                begin
                  dec(XClicCell[indexTCO]);
                  d:=(xClicCell[indexTCO]-1)*LargeurCell[indexTCO];
                  s:=scrollBox.HorzScrollBar.Position;
                  if d<=s then
                  begin
                    s:=s-LargeurCell[indexTCO];
                    if s<LargeurCell[indexTCO] then s:=0;
                    scrollBox.HorzScrollBar.Position:=s;
                  end;
                  procede:=true;
                end
                else exit;
                selection_bleue(indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]);
                exit;
                end;
     end;
   end;

   if (ssCtrl in Shift) then
   begin
     case char(Key) of
       'Z' : annule(indexTCO);
       'A' : selec_tout(indexTCO);
     end;
     exit;
   end;

  //VK_delete : affiche('delete',clorange);
  if procede then
  begin
    _entoure_cell_clic(indexTCO);
    //Affiche('xClicCell='+intToSTR(XClicCell[indexTCO]),clYellow);
    clicTCO:=true;
    formTCO[indexTCO].EditAdrElement.Text:=IntToSTR(tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse);
    defocusControl(EditAdrElement,true); // pour enlever le curseur
    actualise(indexTCO);
    clicTCO:=false;
  end;
end;

procedure Debut_drag_train(IndexTCO,x,y : integer);
var n,iD,xg,yg : integer;
    horizontal : boolean;
begin
  if affevt then affiche('Debut_drag_train',clYellow);
  Id:=Index_canton_numero(Tco[indexTCO,x,y].NumCanton);
  if (id=0) or Maj_signaux_cours then exit;
  n:=canton[Id].Nelements;
  horizontal:=canton[Id].horizontal;

  PImageTCO[indexTCO].BeginDrag(true);

  IdCantonDragOrg:=Id;
  cantonOrg:=canton[id].numero;
  lDrag:=canton[id].Licone-1;
  hDrag:=canton[id].Hicone-1;
  xg:=canton[id].Xicone+1;  // début de l'image du train (coord absolues)
  yg:=canton[id].Yicone+1;

  // ImageTemp <- image du canton du tco
  BitBlt(formTCO[indexTCO].ImageTemp.canvas.Handle,0,0,lDrag,hDrag,
         PcanvasTCO[indexTCO].Handle,xg,yg,srcCopy);

  //formTCO[indexTCO].ImageTemp.Repaint;

  // OldBMP<-ImageTCO ; sauve le bitmap sous le pointeur de la souris
  BitBlt(OldBmp.Canvas.Handle,0,0,lDrag,hDRag,
         FormTCO[IndexTCO].ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);

  drag:=2;            // drag train d'un canton
  TCODrag:=indexTCO;
  oldx:=offsetSourisX;
  oldy:=offsetSourisY;
end;

procedure debut_drag(image : TImage);
var h,l,indexTCO : integer;
    c : Tcomponent;
begin
  if affevt then affiche('Debut_drag',clYellow);
  image.BeginDrag(true);
  c:=image.GetParentComponent;
  c:=c.GetparentComponent;
  indexTCO:=index_TCO(c as Tform);

  l:=image.Width;
  h:=image.height;

  // ImageTemp <- imageicone
  StretchBlt(formTCO[indexTCO].ImageTemp.canvas.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],   // destination avec mise à l'échelle
             image.Canvas.Handle,0,0,l,h,srccopy);

  // OldBMP<-ImageTCO ; sauve le bitmap sous le pointeur de la souris
  BitBlt(OldBmp.Canvas.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],FormTCO[IndexTCO].ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);

  drag:=1;  // drag train d'une icone de tco
  TCODrag:=indexTCO;
  oldx:=offsetSourisX;
  oldy:=offsetSourisY;
end;

// on bouge l'icone du composant dans le tco
procedure TFormTCO.ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
var indexTCO,xl,yl : integer;
begin
  indexTCO:=Index_tco(sender);

  if (TCODrag<>indexTCO) then
  begin
    accept:=false;
    exit; // le drag tco source et destination sont différents
  end;
  xl:=x+offsetSourisX;
  yl:=y+offsetSourisY;
  Accept:=source is TImage;
  if drag=1 then // icone de TCO
  begin
    if affevt then Affiche('TCO'+intToSTR(IndexTCO)+' DragOver type1 x='+intToSTR(x)+' y='+intToSTR(y),clyellow);
    // canvasTCO<-oldBMP  restitue l'ancien en oldx,oldy fond avant le nouveau
    BitBlt(PImageTCO[indexTCO].canvas.handle,oldx,oldy,LargeurCell[indexTCO],hauteurCell[indexTCO],oldbmp.canvas.handle,0,0,SRCCOPY); // remettre la sauvegarde du bitmap à l'ancienne position souris
    // oldbmp(0,0)<-canvasTCO(x1,y1)  sauve le nouveau bitmap en x1,y1
    BitBlt(oldbmp.canvas.handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],PImageTCO[IndexTCO].canvas.handle,xl,yl,SRCCOPY); // sauvegarder le bitmap actuel sous la souris
    oldx:=xl; oldy:=yl;
    // canvasTCO(x1,y1)<-ImageTemp(0,0)
    BitBlt(PImageTCO[indexTCO].canvas.handle,xl,yl,LargeurCell[indexTCO],hauteurCell[indexTCO],FormTCO[indexTCO].imagetemp.canvas.handle,0,0,SRCCOPY);  // copier l'icone vers la souris
    PImageTCO[IndexTCO].Repaint;
  end;
  if drag=2 then // loco
  begin
    //if affevt then
    //Affiche('TCO'+intToSTR(IndexTCO)+' DragOver type2 x='+intToSTR(x)+' y='+intToSTR(y),clyellow);
    // canvasTCO<-oldBMP  restitue l'ancien en oldx,oldy fond avant le nouveau
    BitBlt(PCanvasTCO[indexTCO].handle,oldx,oldy,LDrag,hDRag,oldbmp.canvas.handle,0,0,SRCCOPY); // remettre la sauvegarde du bitmap à l'ancienne position souris
    // oldbmp(0,0)<-canvasTCO(x1,y1)  sauve le nouveau bitmap en x1,y1
    BitBlt(oldbmp.canvas.handle,0,0,LDrag,hDrag,PCanvasTCO[IndexTCO].handle,xl,yl,SRCCOPY); // sauvegarder le bitmap actuel sous la souris
    oldx:=xl; oldy:=yl;
    // canvasTCO(x1,y1)<-ImageTemp(0,0)
    BitBlt(PcanvasTCO[indexTCO].handle,xl,yl,Ldrag,hDrag,FormTCO[indexTCO].imagetemp.canvas.handle,0,0,SRCCOPY);  // copier l'icone vers la souris
    PImageTCO[IndexTCO].Repaint;

  end;
end;


// met le tableau undo a jour après un remplissage
procedure maj_undo(i : integer);
var k : integer;
begin
  undo[rangUndo].nombre:=i;
  if rangUndo<maxUndo then inc(rangUndo) else
  begin
    // si le tampon undo est plein, on décale
    for k:=1 to maxundo-1 do
    begin
      undo[k]:=undo[k+1];
    end;
    undo[maxundo].nombre:=0;
  end;
end;

// sauve le tracé dans undo avant modif du tracé
procedure stocke_undo(indexTCO,i,xu,yu : integer);
begin
  if i>=100 then exit;

  tco[indextco,xu,yu].Xundo:=xu;  // stocke les coordonnées de la cellule concernée
  tco[indextco,xu,yu].Yundo:=yu;

  undo[rangUndo].element[i]:=tco[indextco,xu,yu];
  //affiche('Rang undo='+intToSTR(rangundo),clYellow);
end;


procedure end_Drag(icone,x,y : integer;Sender, Target: TObject);
var s : string;
indexTCO,i,xclic,Yclic,bim,nc,maxi,libre : integer;
begin
  if not(Target is TImage) then exit;
  s:=(Target as TImage).Name;
  if copy(s,1,8)<>'ImageTCO' then exit;   // si le composant de destination n'est pas ImageTCO, sortir
  if (x=0) and (y=0) then exit;
  drag:=0;
  indexTCO:=Index_tco(sender);

  BitBlt(formTCO[indexTCO].imageTCO.canvas.handle,oldx,oldy,LargeurCell[indexTCO],hauteurCell[indexTCO],oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure(indexTCO);
  FormTCO[indexTCO].imageTCO.repaint;

  Xclic:=X div LargeurCell[indexTCO] +1;
  Yclic:=Y div hauteurCell[indexTCO] +1;
  XclicCell[indexTCO]:=Xclic;
  YClicCell[indexTCO]:=Yclic;
  //Affiche('XXX='+intToSTR(x),clyellow);
  //if not(verif_cellule(indexTCO,Xclic,Yclic,icone)) then exit;
  // interdit de déposer sur un canton
  if isCanton(tco[IndexTCO,Xclic,Yclic].BImage) then exit;

  efface_cellule(IndexTCO,formTCO[indexTCO].ImageTCO.Canvas,Xclic,YClic,PmCopy);
  TCO_modifie:=true;

  case icone of
  1 : dessin_1(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  2 : dessin_2(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  3 : dessin_3(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  4 : dessin_4(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  5 : dessin_5(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  6 : dessin_6(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  7 : dessin_7(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  8 : dessin_8(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  9 : dessin_9(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  10 : dessin_10(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  11 : dessin_11(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  12 : dessin_12(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  13 : dessin_13(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  14 : dessin_14(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  15 : dessin_15(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  16 : dessin_16(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  17 : dessin_17(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  18 : dessin_18(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  19 : dessin_19(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  20 : dessin_20(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  21 : dessin_21(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  22 : dessin_22(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  23 : dessin_23(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  24 : dessin_24(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  25 : dessin_25(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  26 : dessin_26(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  27 : dessin_27(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  28 : dessin_28(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  29 : dessin_29(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  32 : dessin_32(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  33 : dessin_33(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  34 : dessin_34(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  id_Quai : dessin_Quai(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  id_action : dessin_Action(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic);
  id_canton :

    // autorisé à déposer que sur les icones 1 et 20
    begin
      bim:=tco[indextco,XClic,YClic].BImage; // icone d'origine
      if ((bim<>1) and (bim<>20)) or (Ncantons>=MaxCantons) then
      begin
        Affiche_TCO(indexTCO);
        s:='Un canton doit être déposé sur un élément horizontal ou vertical d''au moins 3 cases';
        formTCO[indexTCO].Caption:=s;
        Affiche_TCO(indexTCO);
        Affiche_info(indexTCO,x,y,s);
        exit;
      end;

      for i:=0 to 2 do
      begin
        if Bim=1 then  // Horizontal
        begin
          if (tco[indexTCO,Xclic+i,Yclic].BImage<>1) or (tco[indexTCO,Xclic+i,Yclic].Adresse<>0) then
          begin
            s:='Un canton doit être déposé sur un élément horizontal ou vertical d''au moins 3 cases';
            formTCO[indexTCO].Caption:=s;
            Affiche_TCO(indexTCO);
            Affiche_info(indexTCO,x,y,s);
            exit;
          end;
        end;
        if Bim=20 then // Vertical
        begin
          if (tco[indexTCO,Xclic,Yclic+i].BImage<>20) or (tco[indexTCO,Xclic,Yclic+i].Adresse<>0) then
          begin
            s:='Un canton doit être déposé sur un élément horizontal ou vertical d''au moins 3 cases';
            formTCO[indexTCO].Caption:=s;
            Affiche_TCO(indexTCO);
            Affiche_info(indexTCO,x,y,s);
            exit;
          end;
        end;
      end;

      // l'un des deux éléments du canton doit être un détecteur
      canton[Ncantons+1].Nelements:=3;
      canton[Ncantons+1].x:=Xclic;
      canton[Ncantons+1].y:=Yclic;
      canton[Ncantons+1].Ntco:=indexTCO;
      renseigne_canton(Ncantons+1,Bim=1);
      if (canton[Ncantons+1].typ1<>det) and (canton[Ncantons+1].typ2<>det) then
      begin
        s:='Un canton doit avoir un détecteur comme élément adjacent';
        formTCO[indexTCO].Caption:=s;
        Affiche_TCO(indexTCO);
        Affiche_info(indexTCO,x,y,s);
        exit;
      end;
      cree_canton(IndexTCO,xClic,yClic,0,Bim=1);   // 0 = attribuer un nouveau numéro
    end;
  end;

  stocke_undo(indexTCO,1,XClic,YClic);
  maj_undo(1);
  if icone<>id_canton then tco[indextco,XClic,YClic].BImage:=icone;              // Image de la cellule
  tco[indextco,XClic,YClic].liaisons:=liaisons[icone];  // liaisons des voies
  tco[indextco,xClic,YClic].CoulFonte:=clYellow;
  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Repr:=2;

  formTCO[indexTCO].EditAdrElement.Text:=IntToSTR(tco[indextco,XClic,YClic].Adresse);

  formTCO[indexTCO].EdittypeImage.Text:=IntToSTR(tco[indextco,XClic,YClic].BImage);
end;

procedure TFormTCO.ImagePalette5EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(5,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette2EndDrag(Sender,Target: TObject; X,Y: Integer);
begin
  end_drag(2,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette2);
end;

procedure TFormTCO.ImagePalette3EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(3,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette3);
end;

procedure TFormTCO.ImagePalette4EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(4,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette4);
end;

procedure TFormTCO.ImagePalette5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette5);
end;

procedure TFormTCO.ImagePalette1EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(1,x,y,Sender,Target);
end;


procedure TFormTCO.ImagePalette6EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(6,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette6);
end;

procedure TFormTCO.ImagePalette7EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(7,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette7);
end;

procedure TFormTCO.ImagePalette8EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(8,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette8);
end;

procedure TFormTCO.ImagePalette9MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette9);
end;

procedure TFormTCO.ImagePalette12MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette12);
end;

procedure TFormTCO.ImagePalette13MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette13);
end;

procedure TFormTCO.ImagePalette14MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette14);
end;

procedure TFormTCO.ImagePalette15MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette15);
end;

procedure TFormTCO.ImagePalette16MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette16);
end;

procedure TFormTCO.ImagePalette17MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette17);
end;

procedure TFormTCO.ImagePalette18MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette18);
end;

procedure TFormTCO.ImagePalette19MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette19);
end;

procedure TFormTCO.ImagePalette21MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette21);
end;

procedure TFormTCO.ImagePalette22MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette22);
end;

procedure TFormTCO.ImagePalette9EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(9,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette12EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(12,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette13EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(13,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette14EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(14,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette15EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(15,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette16EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  end_drag(16,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette17EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(17,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette18EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(18,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette19EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(19,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette21EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(21,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette22EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  end_drag(22,x,y,Sender,Target);
end;

procedure TFormTCO.ButtonSauveTCOClick(Sender: TObject);
begin
  sauve_fichiers_tco;
  defocusControl(ButtonSauveTCO,true);
end;

procedure TFormTCO.MenuCollerClick(Sender: TObject);
var x,y,xPlace,yPlace,indexTCO: integer;
    c : tComponent;
begin
  if TamponAffecte then
  begin
    c:=popupmenu1.PopupComponent ;     // imageTCO
    c:=c.GetParentComponent;           // scrollBox
    c:=c.GetParentComponent;           // formTCO
    indexTCO:=index_tco(c);
    for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do       // rectangle de la sélection
      for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      begin
        xPlace:=XclicCell[indexTCO]+x-TamponTCO_Org.x1;   // destination
        yPlace:=YclicCell[indexTCO]+y-TamponTCO_Org.y1;
        if (xPlace<=NbreCellX[indexTCO]) and (yPlace<=NbreCellY[indexTCO]) then tco[indextco,xPlace,yPlace]:=tampontco[x,y];
      end;
    selectionaffichee[indexTCO]:=false;  
    Affiche_TCO(indexTCO);
    TCO_modifie:=true;
    ligne_supprime:=0;
    colonne_supprime:=0;

    // efface rectangle graphique
    if Rect_select.NumTCO=indexTCO then affiche_rectangle(IndexTCO,Rect_select);
    Rect_select.NumTCO:=0;
    selectionAffichee[indexTCO]:=false;

  end;
end;

procedure TFormTCO.MenuCopierClick(Sender: TObject);
var indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  copier(indexTCO);
  ligne_supprime:=0;
  colonne_supprime:=0;
end;

// supprimer la sélection
procedure TFormTCO.MenuCouperClick(Sender: TObject);
var indexTCO : integer;
    c : Tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  couper(indexTCO);
  ligne_supprime:=0;
  colonne_supprime:=0;
end;


procedure TFormTCO.AnnulercouperClick(Sender: TObject);
var indexTCO : integer;
    c : tComponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  Annule(indexTCO);
end;

// renvoie une icone en fonction des 4 tracés désirés
// exemple : deux lignes qui se croisent renvoient un croisement
// el  = élement à remplacer
// quadrant des 4 tracés (2=NE 3=Est 4=SE 5=S )
// premier : si c'est le premier élément du tracé
// dernier : si c'est le dernier élément du tracé
// on regarde si l'élément est connecté par testbit(tco[indextco,x,y].liaisons,numbit) numbit=0=NO 1=N 2=NE 3=E 4=SE 5=S 6=SO 7=O
function replace(indexTCO,x,y,el,quadrant : integer;premier,dernier : boolean) : integer;
var bim : integer;
begin
  //if debugTCO then Affiche('Quadrant '+intToSTR(quadrant),clred);
  result:=0;
  bim:=tco[indextco,x,y].BImage;
  // élément d'origine
  case bim of
   0 : result:=el;
   1 : begin
         if quadrant=NordEst then
         begin
           if premier then
           begin
             if testbit(tco[indextco,x+1,y].liaisons,3) then result:=3 else result:=7;
           end;
           if dernier then
           begin
             if testbit(tco[indextco,x-1,y].liaisons,3) then result:=2 else result:=9;
           end;
           if not(premier) and not(dernier) then result:=21;
         end;
         if quadrant=SudEst then
         begin
           if dernier then
           begin
             if not(testbit(tco[indextco,x-1,y].liaisons,3)) then result:=6;
             if testbit(tco[indextco,x-1,y].liaisons,3) then result:=5;
           end;
           if premier then
           begin
             if testbit(tco[indextco,x+1,y].liaisons,7) then result:=4 ;
             if not(testbit(tco[indextco,x+1,y].liaisons,7)) then result:=8;
           end;
           if not(premier) and not(dernier) then
           begin
             if testbit(tco[indextco,x-1,y].liaisons,3) and testbit(tco[indextco,x+1,y].liaisons,7) then result:=22;
             if not(testbit(tco[indextco,x-1,y].liaisons,3)) and testbit(tco[indextco,x+1,y].liaisons,7) then result:=12;
             if not(testbit(tco[indextco,x+1,y].liaisons,7)) and testbit(tco[indextco,x-1,y].liaisons,3) then result:=14;
           end;
         end;
         if quadrant=Est then result:=1;
       end;

   2 : begin
         if quadrant=NordEst then
         begin
           if premier then result:=21;
           if dernier then result:=2;
           if not(premier) and not(dernier) then result:=21;
         end;
         if quadrant=Est then result:=2;
       end;
   3 : begin
         if quadrant=NordEst then
         begin
           if premier then result:=3;
           if dernier then result:=21;
           if not(premier) and not(dernier) then result:=21;
         end;
         if quadrant=Est then result:=3;
       end;
   4 : begin
         if quadrant=SudEst then
         begin
           if premier then result:=4;
           if dernier then result:=22;
           if not(premier) and not(dernier) then result:=22;
         end;
         if quadrant=Est then result:=4;
       end;
   5 : begin
         if quadrant=SudEst then
         begin
           if premier then result:=22;
           if dernier then result:=5;
           if not(premier) and not(dernier) then result:=22;
         end;
         if quadrant=Est then result:=5;
       end;
   6 : begin
         if quadrant=Est then
         begin
           if premier then result:=6;
           if dernier then result:=5;
           if not(premier) and not(dernier) then result:=5;
         end;
         if quadrant=SudEst then
         begin
           if premier then result:=12;
           if dernier then result:=6;
           if not(premier) and not(dernier) then result:=12;
         end;
       end;
   7 : begin
         if quadrant=Est then
         begin
           if premier then result:=3;
           if dernier then result:=7;
           if not(premier) and not(dernier) then result:=3;
         end;
         if quadrant=NordEst then
         begin
           if premier then result:=7;
           if dernier then result:=13;
           if not(premier) and not(dernier) then result:=13;
         end;
       end;
   8 : begin
         if quadrant=Est then
         begin
           if premier then result:=4;
           if dernier then result:=8;
           if not(premier) and not(dernier) then result:=4;
         end;
         if quadrant=SudEst then
         begin
           if premier then result:=8;
           if dernier then result:=14;
           if not(premier) and not(dernier) then result:=14;
         end;
       end;
   9 : begin
         if quadrant=Est then
         begin
           if premier then result:=9;
           if dernier then result:=2;
           if not(premier) and not(dernier) then result:=2;
         end;
         if quadrant=NordEst then
         begin
           if premier then result:=15;
           if dernier then result:=9;
           if not(premier) and not(dernier) then result:=15;
         end;
       end;
  10 : begin
         if quadrant=NordEst then result:=10;
         if quadrant=Est then
         begin
           if premier then begin if testbit(tco[indextco,x+1,y-1].liaisons,6) then result:=15 else result:=9;end
           else
           if dernier then begin if testbit(tco[indextco,x-1,y+1].liaisons,2) then result:=13 else result:=7;end
           else
           if not(premier) and not(dernier) then
           begin
             if (testbit(tco[indextco,x-1,y+1].liaisons,2)) and (testbit(tco[indextco,x+1,y-1].liaisons,6)) then result:=21;
             if not(testbit(tco[indextco,x-1,y+1].liaisons,2)) and (testbit(tco[indextco,x+1,y-1].liaisons,6)) then result:=3;
             if testbit(tco[indextco,x-1,y+1].liaisons,2) and not(testbit(tco[indextco,x+1,y-1].liaisons,6)) then result:=2;
           end;
         end;
         if quadrant=Sud then
         begin
           if premier then
           begin
             //       SO
             if testbit(tco[indextco,x-1,y+1].liaisons,2) then result:=32 else result:=17;
           end;
           if dernier then
           begin
              //      NE
             if testbit(tco[indextco,x+1,y-1].liaisons,6) then result:=34 else result:=18;
           end;
           if not(premier) and not(dernier) then result:=23;
         end;
       end;
  11 : begin
         if quadrant=Nord then result:=19;
         if quadrant=Est then
         begin
           if dernier then begin if testbit(tco[indextco,x-1,y-1].liaisons,4) then result:=14 else result:=8;end
           else
           if premier then begin if testbit(tco[indextco,x+1,y+1].liaisons,0) then result:=12 else result:=6;end
           else
           if not(premier) and not(dernier) then
           begin
             if (testbit(tco[indextco,x-1,y-1].liaisons,4)) and (testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=22;
             if not(testbit(tco[indextco,x-1,y-1].liaisons,4)) and (testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=4;
             if testbit(tco[indextco,x-1,y-1].liaisons,4) and not(testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=5;
           end;
         end;
         if quadrant=SudEst then result:=11;
         if quadrant=Sud then
         begin
           if dernier then
           begin
             //       NO
             if testbit(tco[indextco,x-1,y-1].liaisons,4) then result:=33 else result:=19;
           end;
           if premier then
           begin
             //       SE
             if testbit(tco[indextco,x+1,y+1].liaisons,0) then result:=29 else result:=16;
           end;
           if not(premier) and not(dernier) then result:=25;
         end;
       end;
  12 : begin
         if quadrant=SudEst then result:=12;
         if quadrant=Est then
         begin
           if dernier then result:=22;
           if premier then result:=12;
           if not(premier) and not(dernier) then result:=22;
         end;
       end;
  13 : begin
         if quadrant=NordEst then result:=13;
         if quadrant=Est then
         begin
           if dernier then result:=13;
           if premier then result:=21;
           if not(premier) and not(dernier) then result:=21;
         end;
       end;
  14 : begin
         if quadrant=SudEst then result:=14;
         if quadrant=Est then
         begin
           if dernier then result:=14;
           if premier then result:=22;
           if not(premier) and not(dernier) then result:=22;
         end;
       end;

  15 : begin
         if quadrant=NordEst then result:=15;
         if quadrant=Est then
         begin
           if dernier then result:=21;
           if premier then result:=15;
           if not(premier) and not(dernier) then result:=21;
         end;
       end;

  16 : begin
          if quadrant=SudEst then
          begin
            if premier then result:=29;
            if dernier then result:=16;
            if not(premier) and not(dernier) then result:=29;
          end;
          if quadrant=Sud then
          begin
            if testbit(tco[indextco,x,y-1].liaisons,5) then result:=24 else result:=16;
          end;
       end;

  17 : begin
          if quadrant=NordEst then
          begin
            if premier then result:=17;
            if dernier then result:=32;
            if not(premier) and not(dernier) then result:=32;
          end;
          if quadrant=Sud then
          begin
            if premier then result:=17;
            if dernier then result:=26;
            if not(premier) and not(dernier) then result:=26;
          end;
        end;

  18 : begin
          if quadrant=NordEst then result:=34;
          if quadrant=Sud then
          begin
            if premier then result:=27;
            if dernier then
            begin
              if testbit(tco[indextco,x,y+1].liaisons,1) then result:=21;result:=18;
            end;
            if not(premier) and not(dernier) then result:=27;
          end;
        end;

  19 : begin
          if quadrant=SudEst then result:=19;
          if quadrant=Sud then
          begin
            result:=28;
          end;
        end;

  20 : begin
          if (quadrant=NordEst) then
          begin
            if premier then
            begin
              //                    /N
              if not(testbit(tco[indextco,x,y-1].liaisons,5)) then result:=17 else result:=26;
              //                    SO
              if (testbit(tco[indextco,x-1,y+1].liaisons,2)) then result:=23;
              //                    /SO                               N
              if not(testbit(tco[indextco,x-1,y+1].liaisons,2)) and testbit(tco[indextco,x-1,y].liaisons,5) then result:=26;
            end;
            if dernier then
            begin
               //           /S
               if not(testbit(tco[indextco,x,y+1].liaisons,1)) then result:=18 else result:=27;
            end;
            if not(premier) and not(dernier) then result:=23;
          end;
          if quadrant=SudEst then
          begin
            if dernier then
            begin
              if (testbit(tco[indextco,x,y-1].liaisons,5)) and not(testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=24;
              if (testbit(tco[indextco,x,y-1].liaisons,5)) and (testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=25;
              if not(testbit(tco[indextco,x,y-1].liaisons,5)) and not(testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=16;
            end;
            if premier then
            begin
              if (testbit(tco[indextco,x-1,y-1].liaisons,4)) then result:=25;
              //         /NO                                          /S
              if not(testbit(tco[indextco,x-1,y-1].liaisons,4)) and not(testbit(tco[indextco,x,y+1].liaisons,1)) then result:=19;
              //         /NO                                          S
              if not(testbit(tco[indextco,x-1,y-1].liaisons,4)) and (testbit(tco[indextco,x,y+1].liaisons,1)) then result:=28;

            end;
            if not(premier) and not(dernier) then result:=25;
          end;
          if quadrant=Sud then result:=20;
        end;
   21 : result:=21;
   22 : result:=22;
   23 : result:=23;
   24 : begin
          if quadrant=SudEst then
          begin
            if dernier then
            begin
              if testbit(tco[indextco,x+1,y+1].liaisons,0) then result:=25 ;
              if not(testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=24 ;
            end;
            if premier then result:=25;
            if not(premier) and not(dernier) then result:=25;
          end;
          if quadrant=Sud then result:=24;
        end;
  25 : result:=25;
  26 : begin
         if quadrant=NordEst then
         begin
           if premier then result:=26;
           if dernier then result:=23;
           if not(premier) and not(dernier) then result:=23;
         end;
       end;

   27 : begin
         if quadrant=NordEst then
         begin
           if premier then result:=23;
           if dernier then result:=27;
           if not(premier) and not(dernier) then result:=23;
         end;
         if quadrant=Sud then result:=27;
       end;

  28 : begin
         if quadrant=SudEst then
         begin
           if premier then result:=28;
           if dernier then
           begin
             if (testbit(tco[indextco,x,y-1].liaisons,5)) and (testbit(tco[indextco,x+1,y+1].liaisons,0))  and (testbit(tco[indextco,x,y+1].liaisons,1)) then result:=25 else result:=28;
           end;
           if not(premier) and not(dernier) then result:=25;
         end;
         if quadrant=Sud then result:=28;
       end;
  29 : begin
         if quadrant=SudEst then result:=29;
         if quadrant=Sud then
         begin
           if dernier then result:=25;
           if premier then result:=29;
           if not(premier) and not(dernier) then result:=25;
         end;
       end;
  32 : begin
         if quadrant=NordEst then result:=32;
         if quadrant=Sud then
         begin
           if dernier then result:=23;
           if premier then
           begin
             //            N
             if (testbit(tco[indextco,x,y-1].liaisons,5)) then result:=23 else result:=32;
           end;
           if not(premier) and not(dernier) then
           begin
             //            N
             if (testbit(tco[indextco,x,y-1].liaisons,5)) then result:=23 else result:=32;
           end;
         end;
       end;
  33 : begin
         if quadrant=Nord then
         begin
           if premier then result:=32;
           if dernier then result:=25;
           if not(premier) and not(dernier) then result:=25;
         end;
         if quadrant=Sud then
         begin
           if premier then result:=25;
           if dernier then result:=33;
           if not(premier) and not(dernier) then result:=25;
         end;
         if quadrant=SudEst then result:=33;
       end;
  34 : begin
         if quadrant=NordEst then result:=34;
         if quadrant=Sud then
         begin
           if dernier then result:=34;
           if premier then result:=23;
           if not(premier) and not(dernier) then result:=23;
         end;
       end;
   end;
   tco[indextco,x,y].coulFonte:=clyellow;
   if result=1 then
   begin
     tco[indextco,x,y].repr:=2;
   end;
end;

function passe_bouton_canton(IndexTCO,x,y : integer) : integer;
var Xc,Yc,i,IdCanton,larg,haut,n : integer;
    trouve : boolean;
begin
  larg:=largeurCell[IndexTCO];
  haut:=HauteurCell[IndexTCO];
  //xt:=(x div larg)+1;   // coords cellule de la souris
  //yt:=(y div Haut)+1;
  IdCanton:=1;
  i:=1;
  //Affiche('--------',clYellow);
  repeat
    Xc:=canton[i].x;
    Yc:=canton[i].y;
    n:=canton[i].Nelements;
    if Canton[i].horizontal then
    begin
      yc:=(yc-1)*haut;
      Xc:=Xc+n-1;
      xc:=(xc-1)*larg;
    end
    else
    begin
      Xc:=(Xc-1)*larg;
      Yc:=Yc+n-1;
      yc:=(yc-1)*Haut;
    end;
    inc(i);

    //Affiche(INtToSTR(x)+' '+intToSTR(xc)+' '+intToSTR(xc+larg)+'/'+INtToSTR(y)+' '+intToSTR(yc)+' '+intToSTR(yc+Haut),clred);
    trouve:=(x>Xc+4) and (x<Xc+larg-6) and (y>Yc+4) and (y<Yc+haut-6);
  until trouve or (i>nCantons);
  if trouve then result:=i-1
  else result:=0;
end;

// sélectionne le canton du tco, qui a été cliqué à la souris
procedure selec_canton(indexTCO : integer);
var i,idTrain,Bimage,xt,yt,xclic,yclic : integer;
    s,s1,s2 : string;
begin
  xclic:=XclicCell[indexTCO];
  yclic:=YclicCell[indexTCO];

  Bimage:=tco[indextco,xclic,yclic].BImage;
  efface_entoure(indexTCO);
  if IscantonH(Bimage) then
  begin
    xt:=xClic-(Bimage-Id_cantonH);
    yt:=yClic;
    IdCantonSelect:=index_canton_numero(TCO[IndexTCO,xt,yt].NumCanton);
  end;
  if IscantonV(Bimage) then
  begin
    yt:=yClic-(Bimage-Id_cantonV);
    xt:=xClic;
    IdCantonSelect:=index_canton_numero(TCO[IndexTCO,xt,yt].NumCanton);
  end;
  //Affiche('Selection canton id='+intToSTR(IdCantonSelect)+' num='+intToSTR(TCO[IndexTCO,xt,yt].NumCanton),clYellow);
  if (IdCantonSelect<1) or (IdCantonSelect>ncantons) then
  begin Affiche('TCO'+inttoSTR(indexTCO)+' anomalie 5 : indexCanton='+intToSTR(IdCantonSelect)+' '+intToSTR(xt)+','+intToSTR(yt),clred);exit;end;
  // provoque l'affichage du canton en mode sélection (1)
  Dessin_canton(IdCantonSelect,1);

  canton[IdCantonSelect].maxi:=99999;   // limites d'autorisation de glissage des poignées au maxi
  canton[IdCantonSelect].mini:=0;
  deja_calcule:=false;
  //adresse:=index_canton_numero(TCO[IndexTCO,xt,yt].NumCanton);  //???
  idTrain:=canton[IdCantonSelect].IndexTrain;

  actualise_seltrains;

  if idcantonSelect=0 then exit;
  s:='Canton ';
  s:=s+intToSTR(canton[IdCantonSelect].numero)+' '+canton[idcantonselect].nom+#13;
  s:=s+'Origine x='+intToSTR(canton[IdCantonSelect].x)+' y='+intToSTR(canton[IdCantonSelect].y)+
       ' Long='+intToSTR(canton[IdCantonSelect].Nelements);

  s1:=s;
  i:=canton[IdCantonSelect].indexTrain;
  if (i>0) and (i<=Ntrains) then
  begin
    s2:='Occupé par le train n°'+intToSTR(i)+' '+canton[IdCantonSelect].NomTrain+' '+ #13;
    s2:=s2+'Adresse='+intToSTR(trains[i].adresse);
  end;

  {$IF CompilerVersion < 28.0}
  formTCO[indexTCO].imageTCO.hint:=s1+#13+s2;
  {$IFEND}

  {$IF CompilerVersion >= 28.0}
  with formTCO[indexTCO] do
  begin
    BallonHint.Title:=s1;
    BallonHint.Description:=s2;
    BallonHint.Style:=bhsBalloon;
    BallonHint.HideAfter:=4000;
    x:=(canton[IdCantonSelect].x-1)*LargeurCell[indexTCO]+(LargeurCell[indexTCO] div 2);
    y:=(canton[IdCantonSelect].y-1)*HauteurCell[indexTCO]+HauteurCell[indexTCO] div 2;
    ballonhint.ShowHint(PimageTCO[indexTCO].ClientToScreen(point(x,y))); // affiche le ballonHint
 end;
 {$IFEND}
end;

// évènement qui se produit quand on clique gauche ou droit
procedure TFormTCO.ImageTCOMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var position : Tpoint;
    Numcanton,xt,yt,bt,indexTCO,i,j,n,adresse,Bimage,xf,yf,xclic,yclic,el1,el2,senscanton,larg,haut,
    indexTrain,idcantonOrg,idcantonDest,AdrTrain,sens,etat : integer;
    tel1,tel2 : tequipement;
    s : string;
    presTrain,Horz,Pc,trouve : boolean;
begin
  if affEvt then affiche('ImageTCO mouse down',clYellow);
  if Tdoubleclic<>0 then exit;

  indexTCO:=index_tco(sender);
  if indexTCO<1 then exit;
  GetCursorPos(Position);

  xSourisClic:=x;
  ySourisClic:=y;

  Position:=ImageTCO.screenToCLient(Position);

  larg:=LargeurCell[indextco];
  haut:=HauteurCell[indextco];
  Xclic:=position.X div LargeurCell[indexTCO] + 1;
  Yclic:=position.Y div hauteurCell[indexTCO] + 1;
  if button=mbLeft then
  begin
    //Affiche('TCO'+intToSTR(indexTCO)+' souris clicG enfoncée',clYellow);
    //if affEvt then Affiche('TCO'+intToSTR(i)+' souris clicG enfoncée',clYellow);
    if dbleClicTCO then begin dbleClicTCO:=false;exit;end;

    // coordonnées grille
    AncienXclic:=XclicCell[indexTCO];
    AncienYclic:=YclicCell[indexTCO];
    XclicCell[indexTCO]:=Xclic;
    YclicCell[indexTCO]:=Yclic;
    auto_tcurs:=true;
    clicsouris:=true;
    Bimage:=tco[indextco,xclic,yclic].BImage;

    pc:=false;
    if IdCantonSelect<>0 then // si on clique sur un canton, augmenter les tolérances
    begin
      //Affiche('idcantonSelect'+IntToSTR(IdCantonSelect),clYellow);
      Horz:=Canton[IdCantonSelect].horizontal;
      if horz then
      begin
        pc:=(position.x>canton[IdCantonSelect].Gd.Left-5) and (position.x<canton[IdCantonSelect].Gd.Right+5);
      end
      else
      begin
        pc:=(position.y>canton[IdCantonSelect].Gd.Top-5) and (position.y<canton[IdCantonSelect].Gd.Bottom+5);
      end;
    end;
    // clic sur canton
    //if isCanton(Bimage) then

    if pc then
    begin
     {
      IdCantonClic:=index_canton(indexTCO,xclic,yclic);
      if IdCantonClic>0 then
      begin
        s:='Canton '+intToSTR(canton[IdCantonClic].numero)+' '+canton[idcantonClic].nom+#13;
        s:=s+'Origine x='+intToSTR(canton[IdCantonClic].x)+' y='+intToSTR(canton[IdCantonClic].y)+#13;
        i:=canton[IdCantonClic].indexTrain;
        if (i>0) and (i<=Ntrains) then
        begin
          s:=s+'Occupé par le train n°'+intToSTR(i)+' '+canton[IdCantonClic].NomTrain+' '+ #13;
          s:=s+'Adresse='+intToSTR(trains[i].adresse);
        end;
        ImageTCO.hint:=s;
      end;               }
    end

    else
      begin
        //Affiche('RAZ1 x='+intToSTR(xclic)+' Idcanton'+intToSTR(idcantonSelect),clred);
        // réaffiche le TCO pour désélectionner le canton qui a été sélectionné, mais ona cliqué ailleurs
        if IdCantonSelect<>0 then
        begin
          IdCantonSelect:=0;  // pas cliqué sur un canton
          Affiche_TCO(indexTCO);
        end;
      end;


    // ------------------ si clic sur bouton canton
    IdCantonClic:=passe_bouton_canton(indexTCO,x,y);
    if (IdCantonClic>0) and not(ConfCellTCO) then
    begin
      //Affiche('Clic'+IntToSTR(IdCanton),clYellow);
      bt:=canton[IdCantonClic].bouton;
      case bt of
        0 : bt:=1;
        1 : bt:=2;
        2 : bt:=0;
      end;
      canton[IdCantonClic].bouton:=bt;
      Dessin_canton(IdCantonClic,0);     // colore le bouton en bt
      el1:=canton[IdCantonClic].el1;tel1:=canton[IdCantonClic].typ1;
      el2:=canton[IdCantonClic].el2;tel2:=canton[IdCantonClic].typ2;

      // coordonnées du bouton en xt,yt
      n:=canton[IdCantonClic].Nelements;
      if canton[IdCantonClic].horizontal then
      begin
        xt:=(canton[IdCantonClic].x+n-2)*larg;
        yt:=(canton[IdCantonClic].y-1)*Haut;
      end
      else
      begin
        xt:=(canton[IdCantonClic].x-1)*LargeurCell[indextco];
        yt:=(canton[IdCantonClic].y+n-2)*HauteurCell[indexTCO];
      end;

      // pas de départ en mode CDM
      if Cdm_Connecte then
      begin
        FormTCO[IndexTCO].Caption:='Les routes sont incompatibles en mode CDM rail';
        exit;
      end;

      // validation détecteur départ si pas de départ défini
      if (detdepart=0) and (bt<3) and not(ConfCellTCO) then     //  bt=3 drapeau vert 4=drapeau rouge
      begin
        indexTrain:=canton[IdCantonClic].indexTrain;
        if indexTrain=0 then exit;         // si pas de train affecté au canton
        if trains[indexTrain].roulage<>0 then
        begin
          ImageTCO.hint:='Canton occupé par train '+canton[IdCantonClic].NomTrain;
          imageTCO.ShowHint:=true;
          exit; // si route en cours, ne rien faire
        end;
        //voir si det1 ou det2 est occupé
        titre_fenetre(indexTCO);
        PresTrain:=false;
        if tel1=det then presTrain:=detecteur[el1].Etat;
        if tel2=det then presTrain:=detecteur[el2].Etat or PresTrain;
        if not(PresTrain) then
        begin
          FormTCO[IndexTCO].Caption:='Attention, aucun train n''est physiquement présent dans le canton pour définir une route - Aucun des deux détecteurs encadrant le canton n''est à 1';
          exit;
        end;

        if tel1=det then detDepart:=el1;
        if tel2=det then detDepart:=el2;
        cantonOrg:=canton[IdCantonClic].numero;
        canton[IdCantonClic].NumCantonOrg:=cantonOrg;
        sensCanton:=canton[IdCantonClic].sensLoco;
        case sensCanton of // sens de la loco dans le canton
          sensGauche : begin sens:=5;end;
          sensDroit : begin sens:=6;end;
          SensHaut : begin sens:=7;end;
          SensBas : begin sens:=8;end;
        end;
        //Affiche('Départ depuis '+intToSTR(detDepart),clLime);
        formTCO[indexTCO].caption:='Route depuis détecteur '+intToSTR(detDepart);
        idcantonRoute:=IdCantonClic;
        ImageTCO.Hint:='Départ depuis canton '+intToSTR(canton[IdCantonClic].numero)+' dét='+intToSTR(detDepart);
        Screen.Cursor:=crUpArrow; //crHourGlass;

        // image du drapeau vert
        canton[IdCantonClic].bouton:=3;
        dessin_canton(IdCantonClic,0);
        canton[idCantonClic].AdrTrainRoute:=Trains[indexTrain].adresse;
        //trains[IndexTrain].Det_depart:=DetDepart;
        formroute.close;
      end
      else
      begin
        // detdépart validé : valider le det de destination sauf si route en roulage
        if (detatrouve=0) and (bt<=3) and not(ConfCellTCO) and (canton[idCantonClic].NumCantonDest=0) then // bt=3 drapeau vert bt=4 drapeau rouge
        begin
          if (canton[IdCantonClic].adresseTrain<>0) and (bt<3) then
          begin
            ImageTCO.Hint:='Canton occupé par train '+canton[IdCantonClic].nomtrain;
            exit;
          end;
          if tel1=det then detatrouve:=el1;
          if tel2=det then detatrouve:=el2;
          cantonDest:=canton[IdCantonClic].numero;
          canton[IdCantonClic].NumCantonOrg:=cantonOrg;
          canton[IdCantonClic].NumCantonDest:=cantonDest; // c'est lui meme
          idcantonOrg:=index_canton_numero(cantonOrg);
          if idcantonOrg=0 then exit;
          canton[idcantonOrg].NumcantonOrg:=cantonOrg;
          canton[idcantonOrg].NumcantonDest:=cantonDest;

          //Affiche('Arrivée en '+intToSTR(detatrouve),clLime);
          ImageTCO.Cursor:=crDefault;
          // trouve les routes  - sens du canton d'origine
          sensCanton:=canton[IdCantonOrg].sensLoco;
          case sensCanton of // sens de la loco dans le canton
            sensGauche : begin sens:=SensTCO_O;end;
            sensDroit : begin sens:=SensTCO_E;end;
            SensHaut : begin sens:=SensTCO_N;end;
            SensBas : begin sens:=SensTCO_S;end;
          end;

          // affiche la fenetre des routes ou de la route affectée au train,
          indexTrain:=canton[IdCantonOrg].indexTrain;
          if indexTrain>9000 then
          begin
            Affiche('Anomalie 627',clred);
             messageBeep(Mb_iconError);
            exit;
          end;
          Trains[IndexTrain].cantonOrg:=cantonOrg;
          Trains[IndexTrain].cantonDest:=cantonDest;
          formTCO[indexTCO].Caption:='TCO'+intToSTR(indexTCO)+' : '+NomFichierTCO[indexTCO];
          Screen.cursor:=crDefault;

          // drapeau rouge : 4
          canton[IdCantonClic].bouton:=4;
          canton[idCantonClic].AdrTrainRoute:=Trains[indexTrain].adresse;
          dessin_canton(IdCantonClic,0);
          FormTCO[IndexTCO].Caption:='Calcul des routes en cours.....................';

          application.processMessages;
          prepare_route(indexTCO,cantonOrg,detAtrouve,sens);   // à gauche(5) du détecteur / droite (6) / en bas (8) / haut (7)
          if trains[indexTrain].route[0].adresse<>0 then formRouteTrain.show else
          begin
            indexTCOcourant:=indexTCO;
            formRoute.show;
          end;
          titre_Fenetre(indexTCO);
          //detatrouve:=0;
          //detDepart:=0;
          exit;
        end;
        // on clique sur le drapeau vert ou rouge
        if (bt>=3) then   // canton de destination
        begin
          // est-ce un canton de destination?
          if idcantonClic<1 then exit;
          Numcanton:=canton[IdCantonClic].numero;
          if canton[IdCantonClic].NumCantonDest=NumCanton then
          begin
            Numcanton:=canton[IdCantonClic].NumcantonOrg;   // revenir au canton origine de la route
            if numcanton=0 then exit;
            IdCantonClic:=index_canton_numero(NumCanton);
          end;

          // indexTrainFR:=canton[IdCantonClic].AdrTrainRoute;  // train concerné par la route. Ne pas utiliser car si on clique sur
          indexTrain:=canton[IdCantonClic].indexTrain;
          // la route dans la fenêtre des routes alors que le train n'est pas dans le canton (la route est démarrée) alors le
          // train disparaît du canton ( canton[].indexTrain repasse à 0)
          //if indexTrainFR<>0 then
          if indextrain<>0 then
          begin
            indexTrainFR:=IndexTrain;  // la formRouteTrain utilise IndexTrainFR
            if (trains[indexTrain].route[0].adresse<>0) then
            begin
              // afficher la fenetre des routes
              formRouteTrain.PageControlRoutes.ActivePage:=formRouteTrain.TabSheetRA;
              formRouteTrain.show;
            end
            else formRoute.show;
          end;
          AdrTrain:=canton[IdCantonClic].AdrTrainRoute;
          if AdrTrain<>0 then
          begin
            IndexTrain:=index_train_adresse(AdrTrain);
            ImageTCO.Hint:='Route affectée au train '+Trains[indexTrain].nom_train;
          end
        end;
      end;
      exit;
    end
    else

    // ------------------ traitement clic sur canton sélectionné : le désélectionner
    titre_fenetre(indexTCO);
    if (IdCantonSelect<>0) and not(ConfCellTCO) then
    begin
      if accroche_canton(indexTCO,IdCantonSelect,x,y) then
      begin
       // Affiche('on a pas cliqué sur les poignées dans MouseDown',clred);
        exit;   // on a pas cliqué sur les poignées
      end;
      begin
        // sinon, désélect le canton
        IndexTCO:=canton[IdCantonSelect].Ntco;   // reprendre l'index du TCO depuis le canton car on a peut etre cliqué sur un autre TCO
        //Affiche('Desel',clred);
        xt:=canton[IdCantonSelect].x;
        yt:=canton[IdCantonSelect].y;
        IdCantonClic:=index_canton_numero(TCO[IndexTCO,xt,yt].NumCanton);
        Affiche_rectangle_canton(indexTCO,IdCantonSelect);  // efface la sélection
        Dessin_canton(IdCantonClic,0);
        AncienIdCantonSelect:=IdCantonSelect;
        IdCantonSelect:=0;
        //Affiche('RAZ2',clred);
      end;
    end;

    // ne pas mettre de else sinon confusion entre le clic et le double clic du canton
    // ------------------ traitement clic sur canton non sélectionné : le sélectionner
    begin
      if IsCanton(Bimage) and not(ConfCellTCO) then
      begin
        formRoute.Close;
        selec_canton(indexTCO);
        actualise(indexTCO);   // actualise la fenetre de paramétrage
        //if IdcantonSelect>0 then ImageTCO.Hint:='canton '+intToSTR(canton[IdCantonSelect].numero);
        exit;
      end;
    end;

    // action
    if (Bimage=id_action) and not(ConfCellTCO) then
    begin
      i:=tco[indextco,xclic,yclic].PiedSignal; // type d'action
      n:=tco[indextco,xclic,yclic].feuoriente;
      //Affiche('Clic bouton action i='+intToSTR(i)+' n='+intToSTR(n),clYellow);
      case i of
      AcChangeTCO : Affiche_fenetre_TCO(n,true);  // affiche le TCO n°n
      AcAffSC : with formprinc do             // afficher signaux complexes
      begin
        windowState:=wsNormal; //Maximized;
        show;
        BringToFront;
      end;
      AcAffCDM :
      begin
        if CDMhd<>0 then
        begin                                 // afficher CDM rail
          ShowWindow(CDMhd,SW_MAXIMIZE);
          SetForegroundWindow(CDMhd);             // met CDM en premier plan
          SetActiveWindow(CdmHd);
        end;
      end;
      AcActSortie :                               // action accessoire
      begin
        // pilotage impulsionnel
        pilote_acc(tco[indextco,xclic,yclic].Adresse,tco[indextco,xclic,yclic].sortie,AigP);
      end;
      AcStopTrains :
      begin
        stop_trains;
      end;
      AcMarche_Horloge : Demarre_horloge;
      AcArret_horloge : horloge:=false;
      AcInit_horloge :
      begin
        Init_Horloge;
      end;
      AcAff_horloge : affiche_horloge;
      AcBouton_bistable:
      begin

        adresse:=tco[indextco,xclic,yclic].Adresse;
        if (adresse<=0) or (adresse>100) then exit;
        etat:=boutonTCO[adresse].etat;
        inc(etat);
        if etat=2 then etat:=0;
        boutonTCO[adresse].etat:=etat;
             
        dessin_Action(indexTCO,pcanvasTCO[indextco],xclic,yclic);
        // explorer tous les tco pour voir s'il y un autre bouton tco avec la même adresse
        for i:=1 to NbreTCO do
          for y:=1 to NbreCellY[i] do
            for x:=1 to NbreCellX[i] do
            begin
              if tco[i,x,y].BImage=Id_Action then
              begin
                if tco[i,x,y].PiedSignal=acBouton_bistable then
                begin
                  j:=tco[indextco,xclic,yclic].Adresse;
                  if j=adresse then
                  begin
                    dessin_Action(i,pcanvasTCO[i],x,y);
                  end;
                end;
              end;
            end;
      end;
      end;
    end;

    TempoSouris:=2 ; // démarre la tempo clic souris

    // clic en mode dessin
    if modeTrace[indexTCO] then
    begin
      if indextrace=0 then
      begin
        inc(indexTrace);
        traceXY[indexTrace].x:=XClic;
        traceXY[indexTrace].y:=Yclic;
        exit;
      end;

      if indextrace=1 then
      begin
        // vérifier coordonnées valides
        if ( abs(XClic-traceXY[1].x)=abs(YClic-traceXY[1].y) ) or
          ( XClic-traceXY[1].x=0 ) or ( YClic-traceXY[1].y=0 ) then
        begin
          traceXY[2].x:=XClic;
          traceXY[2].y:=Yclic;
          xf:=XClic;
          yf:=Yclic;

          // si origine=destination, annuler
          if (traceXY[1].x=traceXY[2].x) and (traceXY[1].y=traceXY[2].y) then
          begin
            indexTrace:=1;
            traceXY[2].x:=0;traceXY[2].y:=0;
            exit;
          end;

          // premier tracé
          indextrace:=1;

          if traceXY[1].y=traceXY[2].y then
          begin
            yt:=traceXY[1].y;
            if traceXY[1].x>traceXY[2].x then echange(traceXY[1].x,traceXY[2].x);
            // tracé horizontal (vers la droite)
            i:=1;
            for xt:=traceXY[1].x to traceXY[2].x do
            begin
              stocke_undo(indextco,i,xt,yt);  // stocke les points de la ligne entière dessinée
              inc(i);
              Bimage:=replace(indexTCO,xt,yt,1,Est,xt=traceXY[1].x,xt=traceXY[2].x);
              tco[indextco,xt,yt].BImage:=Bimage;
              tco[indextco,xt,yt].liaisons:=liaisons[Bimage];
            end;
            maj_undo(i-1); // stocke le nombre de points de la ligne

            affiche_tco(indextco);
          end

          else
          begin
            if traceXY[1].x=traceXY[2].x then
            begin
              xt:=traceXY[1].x;
              if traceXY[1].y>traceXY[2].y then echange(traceXY[1].y,traceXY[2].y);
              // tracé vertical (le bas) (quadrant 5)
              i:=1;
              for yt:=traceXY[1].y to traceXY[2].y do
              begin
                stocke_undo(indexTCO,i,xt,yt);
                inc(i);
                Bimage:=replace(indexTCO,xt,yt,20,Sud,yt=traceXY[1].y,yt=traceXY[2].y);
                tco[indextco,xt,yt].BImage:=Bimage;
                tco[indextco,xt,yt].liaisons:=liaisons[Bimage];
              end;
              maj_undo(i-1);
              affiche_tco(indexTCO);
            end

            // indice 1 doit toujours < que indice 2
            // tracé diagonal vers en bas à droite (quadrant 4)
            else
            begin
              if (traceXY[1].x>traceXY[2].x) then
              begin
                echange(traceXY[1].x,traceXY[2].x);
                echange(traceXY[1].y,traceXY[2].y);
              end;

              if (traceXY[1].y<traceXY[2].y) then
              begin
                yt:=traceXY[1].y;
                // tracé diagonal vers la droite (quadrant 4)
                i:=1;
                for xt:=traceXY[1].x to traceXY[2].x do
                begin
                  stocke_undo(indexTCO,i,xt,yt);
                  inc(i);
                  Bimage:=replace(indexTCO,xt,yt,11,SudEst,xt=traceXY[1].x,xt=traceXY[2].x);
                  tco[indextco,xt,yt].BImage:=Bimage;
                  tco[indextco,xt,yt].liaisons:=liaisons[Bimage];
                  inc(yt);
                end;
                maj_undo(i-1);
                affiche_tco(indexTCO);
              end
              else
              begin
                // tracé diagonal vers en haut à droite (quadrant 2)
                yt:=traceXY[1].y;
                i:=1;
                for xt:=traceXY[1].x to traceXY[2].x do
                begin
                  stocke_undo(indexTCO,i,xt,yt);
                  inc(i);          
                  Bimage:=replace(indexTCO,xt,yt,10,NordEst,xt=traceXY[1].x,xt=traceXY[2].x);
                  tco[indextco,xt,yt].BImage:=Bimage;
                  tco[indextco,xt,yt].liaisons:=liaisons[Bimage];
                  dec(yt);
                end;
                maj_undo(i-1);
                affiche_tco(indexTCO);
              end;
            end;
          end;
          // préparer le suivant
          traceXY[1].x:=xf;traceXY[1].y:=yf;
          traceXY[2].x:=0;traceXY[2].y:=0;
          indextrace:=1;
          tco_modifie:=true;
        end;
      end ;
      exit;
    end;

    // si clic souris en mode fenetre graphique: initialisation du rectangle bleu de sélection graphique
    if (RadioGroupSel.ItemIndex=1) and not(ConfCellTCO) then
    begin
      if not(selectionAffichee[indexTCO]) then
      begin
        // si une zone de sélection est affichée  annuler toutes
        for n:=1 to NbreTCO do
        begin
          // mode cellule
          if SelectionAffichee[n] then
          begin
            //Affiche('efface sélection',clOrange);
            with formTCO[n].imageTCO.Canvas do
            begin
              Pen.Mode:=PmXor;
              Pen.color:=clGrille[n];
              Brush.Color:=clblue;
              Rectangle(rAncien);
            end;
          end;
          // mode graphique
          if (n<>indexTCO) and (rect_select.NumTCO=n) then
          begin
            Affiche('Efface sur TCO'+intToSTR(n),clred);
            affiche_rectangle(rect_select.NumTCO,Rect_select);  // effacer sur l'autre tco
            rect_select.NumTCO:=0;
          end;
        end;

        // créer nouveau rectangle graphique
        rect_select.NumTCO:=indexTCO;  // indicateur d'affichage
        with Rect_select.Gd do
        begin
          Left:=(xclic-1)*largeurcell[indexTCO];
          Top:=(yclic-1)*hauteurCell[indexTCO];
          Right:=(xclic)*largeurCell[indexTCO];
          Bottom:=(yclic)*hauteurCell[indexTCO];
        end;
        Init_rectangle(IndexTCO,Rect_Select);
        Affiche_Rectangle(indexTCO,Rect_select);
        selectionAffichee[indexTCO]:=true;
        if affevt then Affiche('Sélection bleue 2',clCyan);
      end;
    end
    else
    begin
    //  xMiniSel:=99999;yMiniSel:=99999;
    //  xMaxiSel:=0;yMaxiSel:=0;

      // si une zone de sélection est affichée sur un des TCO, annuler toutes
      for n:=1 to NbreTCO do
        if SelectionAffichee[n] then
        begin
          //Affiche('efface sélection',clOrange);
          with formTCO[n].imageTCO.Canvas do
          begin
            Pen.Mode:=PmXor;
            Pen.color:=clGrille[n];
            Brush.Color:=clblue;
            Rectangle(rAncien);
          end;
          SelectionAffichee[n]:=false;
        end;

      // clic gauche, gestion des Hints
      clicTCO:=true;
      //Affiche('xcliccell='+IntToSTR(XclicCell[indexTCO])+' ycliccell='+IntToSTR(YclicCell[indexTCO]),clyellow);

      if Bimage=id_signal then
      begin
        adresse:=tco[IndexTCO,xClic,yClic].Adresse;
        if (adresse=0) or (index_signal(adresse)=0) then s:='Signal sans adresse' else
          s:=infosignal(adresse);
        ImageTCO.Hint:=s;
      end
      else
      if IsAigTJDCroiTCO(Bimage) then
      begin
        adresse:=tco[IndexTCO,xClic,yClic].Adresse;
        if adresse=0 then s:='Aiguillage sans adresse'
        else
        begin
          i:=index_aig(adresse);
          if aiguillage[i].modele<>crois then
          begin
            if Adresse<>0 then
            begin
              s:='Aiguillage '+intToSTR(adresse)+' Position=';
              n:=aiguillage[i].position;
              case n of
                const_inconnu : s:=s+'inconnue ';
                const_droit   : s:=s+'droit ';
                const_devie   : s:=s+'devie ';
              end;
              if ((aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs)) and (aiguillage[i].EtatTJD=4) then
              begin
                adresse:=aiguillage[i].DDevie;
                s:=s+#13+'Aiguillage '+intToSTR(adresse)+' Position=';
                i:=index_aig(adresse);
                n:=aiguillage[i].position;
                case n of
                  const_inconnu : s:=s+'inconnue';
                  const_droit   : s:=s+'droit';
                  const_devie   : s:=s+'devie';
                end;
              end;
            end
          end
          else s:='Croisement '+intToSTR(adresse);
          // réservation
          n:=aiguillage[i].AdrTrain;
          if n<>0 then s:=s+#13+'Réservé par train '+intToSTR(n);
        end;
        ImageTCO.Hint:=s;
      end
      else ImageTCO.Hint:='';

      if Xclic>NbreCellX[indexTCO] then exit;
      if Yclic>NbreCellY[indexTCO] then exit;
      //if cantonSelect<>0 then exit;
      if not(selectionaffichee[indexTCO]) and (Tdoubleclic=0) then _entoure_cell_clic(indexTCO);
      actualise(indexTCO);    // actualise la fenetre de config cellule
      actualise_memZone(indexTCO);
    end;

    clicTCO:=false;
  end;

  if button=mbRight then
  begin
    if affEvt then Affiche('TCO Souris clicD enfoncée',clLime);
    AncienXclic:=XclicCell[indexTCO];
    AncienYclic:=YclicCell[indexTCO];

    XclicCell[indexTCO]:=Xclic;
    YclicCell[indexTCO]:=Yclic;

    Bimage:=tco[indexTCO,xclic,yclic].BImage;
    if not(isCanton(Bimage)) then _entoure_cell_clic(indexTCO);
    auto_tcurs:=true;
    if modetrace[indexTCO] then
    begin
      traceXY[1].x:=0;traceXY[1].y:=0;
      traceXY[2].x:=0;traceXY[2].y:=0;
      indextrace:=0;
      affiche_tco(indexTCO);
      screen.cursor:=crUpArrow;
      exit;
    end;
    XclicCellInserer:=XClic;
    YclicCellInserer:=YClic;
    clicTCO:=true;
    EditAdrElement.Text:=IntToSTR(tco[indextco,XClicCellInserer,YClicCellInserer].Adresse);
    defocusControl(EditAdrElement,true);
    EditTypeImage.Text:=IntToSTR(tco[indextco,XClicCellInserer,YClicCellInserer].Bimage);
    CheckPinv.Checked:=tco[indextco,XClicCellInserer,YClicCellInserer].inverse;
    clicTCO:=false;
  end;
  titre_fenetre(indexTCO);
end;


procedure TFormTCO.ImageTCOMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
var r : Trect;
    Bim,idTrain,indexTCO,dx,dy,xMiniSelP,yMiniSelP,xMaxiSelP,yMaxiSelP,larg,haut,IdCanton : integer;
    ok : boolean;
begin
//  if affevt then Affiche('ImageTCOMouseMove',clLime);
  if dbleClicTCO then
  begin
    dbleClicTCO:=false;
    exit;
  end;
  //Affiche(IntToSTR(tempoSouris),clred);
  indexTCO:=index_tco(sender);

  cellX:=x div LargeurCell[indexTCO]+1;     // variables globales
  cellY:=y div hauteurCell[indexTCO]+1;
  //Affiche(intToSTR(x)+','+intToSTR(y),clYellow);

  //Affiche('IdCantonSelect='+intToSTR(IdCantonSelect),clWhite);
  // exécuté uniquement si changement position souris
  if (aSourisx<>x) or (aSourisy<>y) then
  begin
    aSourisx:=x;
    aSourisy:=y;
    if (radioGroupSel.ItemIndex=1) then
    begin
      //Affiche(IntToSTR(tick),clred);
      Accroche_Rectangle_selection(indexTCO,x,y);
      exit;
    end;

    // vérifier si sélection canton
    if IdCantonSelect<>0 then
    begin
      //Affiche('Acc',clOrange);
      if Accroche_canton(IndexTCO,IdCantonSelect,x,y) then
      begin
        //Affiche('On a pas cliqué sur les poignées dans mouseMove',clred);
        exit;
      end;

      idTrain:=canton[IdCantonSelect].indexTrain;
      // ajouté Maj_signaux_cours car si on déplace un train pendant une maj de signaux, çà plante en fin de procédure TFormTCO.ImageTCOEndDrag
      if (clicsouris) and (idTrain<>0) and not(Maj_signaux_cours) then if (trains[IdTrain].icone<>nil) and (trains[IdTrain].icone.width<>0) then
      begin
        debut_drag_train(IndexTCO,canton[IdCantonSelect].x,canton[IdCantonSelect].y);
        exit;
      end;
      exit;
    end;

    // vérifier si on passe au dessus d'un bouton canton
    IdCanton:=passe_bouton_canton(indexTCO,x,y);
    if idCanton<>0 then
    begin
      PimageTCO[indexTCO].Cursor:=crHandPoint;
    end
    else PimageTCO[indexTCO].Cursor:=CrDefault;

    if clicSouris and modeGlisse then
    begin
      dx:=(xSourisClic-x) div 2;
      dy:=(ySourisClic-y) div 2;
      if dx<>0 then ScrollBox.HorzScrollBar.Position:=ScrollBox.HorzScrollBar.Position+dx;
      if dy<>0 then ScrollBox.VertScrollBar.Position:=ScrollBox.VertScrollBar.Position+dy;
    end;

  end;

  if idcantonselect<>0 then exit;

  aSourisx:=x;
  aSourisy:=y;

  if selecBouge then exit;
  if Temposouris>0 then exit;
  //affiche(intToSTR(cellx),clorange);


  if (AncienXClicCell=CellX) and (AncienYClicCell=CellY) then exit;

 //PimageTCO[indexTCO].Hint:='';
  AncienXClicCell:=CellX;
  AncienYClicCell:=CellY;

  //Affiche('cellX='+IntToSTR(Cellx)+' cellY='+intToSTR(cellY),clyellow);

  if CellX>NbreCellX[indexTCO] then exit;
  if CellY>NbreCellY[indexTCO] then exit;

  // si dessin voies tco
  if modeTrace[indexTCO] then
  begin
    if indexTrace>0 then
    begin
      with formTCO[indexTCO].ImageTCO.canvas do
      begin
        Pen.Mode:=pmXor;
        Pen.Color:=clwhite;
        Pen.Width:=2;
        // efface le précédent
        if traceXY[indextrace+1].x<>0 then
        begin
          if debugTCO then Affiche('Efface précédent',clyellow);
          if ancienok then Pen.color:=clyellow else pen.color:=clGray;
          MoveTo(traceXY[indexTrace].x*LargeurCell[indexTCO]-LargeurCelld2[indexTCO],traceXY[indexTrace].y*hauteurCell[indexTCO]-hauteurCelld2[indexTCO]);
          LineTo(ancienTraceX*LargeurCell[indexTCO]-LargeurCelld2[indexTCO],ancienTraceY*hauteurCell[indexTCO]-hauteurCelld2[indexTCO]);
        end;
        if debugTCO then Affiche('Trace',clyellow);
        ancienTraceX:=cellx;
        ancienTraceY:=celly;
        ok:=( abs(cellX-traceXY[indexTrace].x)=abs(cellY-traceXY[indexTrace].y)  ) or
            ( cellX-traceXY[indexTrace].x=0 ) or ( cellY-traceXY[indexTrace].y=0 ) ;

        if (ancienok=false) and ok then screen.cursor:=crUpArrow;
        if ancienok and (ok=false) then screen.cursor:=crNoDrop;
        Ancienok:=ok;
        if ok then Pen.color:=clyellow else pen.color:=clGray;

        MoveTo(traceXY[indexTrace].x*LargeurCell[indexTCO]-LargeurCelld2[indexTCO],traceXY[indexTrace].y*hauteurCell[indexTCO]-hauteurCelld2[indexTCO]);
        LineTo(cellX*LargeurCell[indexTCO]-LargeurCelld2[indexTCO],CellY*hauteurCell[indexTCO]-hauteurCelld2[indexTCO]);

        if ok then
        begin
          traceXY[indextrace+1].x:=cellX;
          traceXY[indextrace+1].y:=cellY;
        end;
      end;
    end;
    exit;
  end;

  TpsBougeSouris:=5;
  if not(clicsouris) or (temposouris>0) then exit;

  //Affiche('sélection cours',clred);

  Bim:=Tco[IndexTCO,cellx,celly].Bimage;
  //Affiche('ajuste rect '+intToSTR(Bim)+' '+intToSTR(cellx)+' '+intToSTR(celly),clWhite);
  if isCanton(Bim) then exit;      // évite de tirer une sélection bleue depuis un TCO

  larg:=largeurCell[indexTCO];
  haut:=hauteurCell[indexTCO];

  // zone de sélection bleue en coordonnées cellules
  xMiniSel:=XclicCell[indexTCO];
  yMiniSel:=YclicCell[indexTCO];
  xMaxiSel:=cellX;    // cellX = position cellule souris actuelle
  yMaxiSel:=cellY;

  xminiSelP:=min(xminiSel,xMaxiSel);
  yminiSelP:=min(yminiSel,yMaxiSel);
  xmaxiSelP:=max(xminiSel,xMaxiSel);
  ymaxiSelP:=max(yminiSel,yMaxiSel);

  xminiSel:=xMiniSelP;
  yminiSel:=yMiniSelP;
  xMaxiSel:=xMaxiSelP;
  yMaxiSel:=yMaxiSelP;

 // Affiche('xMiniSel='+IntToSTR(xMiniSel)+' yMiniSel='+IntToSTR(yMiniSel)+' xMaxiSel='+IntToSTR(xMaxiSel)+' yMaxiSel='+IntToSTR(yMaxiSel),clOrange);
 // Affiche('XclicCell='+intToSTR(XclicCell[indexTCO])+' YclicCell='+intToSTR(XclicCell[indexTCO]),clorange);

  // efface l'ancien rectangle de sélection
  if SelectionAffichee[indexTCO] then
  with imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille[IndexTCO];
    Brush.Color:=clblue;
    Rectangle(rAncien);
  end;

  if piloteAig then begin SelectionAffichee[indexTCO]:=false;piloteAig:=false;exit;end;

  r:=Rect((xminiSel-1)*larg,(YminiSel-1)*haut,XmaxiSel*larg,yMaxiSel*haut);

  Rancien:=r;
  Affiche_selection(indexTCO);

  SelectionAffichee[indexTCO]:=true;
  if affevt then Affiche('Sélection bleue 3',clCyan);
  //Affiche('Sélection affichée',clLime);
  if entoure[indexTCO] then begin Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);entoure[indexTCO]:=false;end; // efface
end;

procedure TFormTCO.ImageTCOMouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var An,Nouvx,Nouvy,xc,yc,n,indexTCO,lg,ht,xo,yo,larg,haut,i : integer;
begin
  if affevt then Affiche('ImageTCO mouseUp',clyellow);
  clicsouris:=false;
  SelecBouge:=false;
  indextco:=index_TCO(sender);

  if IdCantonSelect<>0 then
  begin
    larg:=LargeurCell[indexTCO];
    haut:=HauteurCell[indexTCO];
    screen.cursor:=crDefault;

    // relache la souris sur sélection canton
    if prise_droit or prise_gauche then
    begin
      with canton[IdCantonSelect] do
      begin
        xc:=x;
        yc:=y; // évite la confusion entre canton[].x et le x de l'entrée de procédure
        An:=Nelements;  // ancien nombre d'éléments
        n:=round(abs(gd.Left-gd.Right)/ larg);  // nouveau nombre d'éléments
        if prise_droit then
        begin
          NouvX:=xc;
          for i:=1 to n do Tco[indexTCO,xc+i-1,yc].BImage:=Id_CantonH+(i-1);
          if n<An then for i:=n to An do Tco[indexTCO,Nouvx+i-1,yc].BImage:=1;  // si on a diminué le nombre de cases du canton, remplir les anciennes de 1
        end;
        if prise_gauche then
        begin
          for i:=1 to n do
          begin
            NouvX:=xc-(n-Nelements);
            tco[indexTCO,NouvX+i-1,yc].Bimage:=Id_CantonH+(i-1);
          end;
          if n<An then for i:=xc to Nouvx-1 do Tco[indexTCO,i,yc].BImage:=1;  // si on a diminué le nombre de cases du canton, remplir les anciennes de 1
        end;
        Nelements:=n;
        tco[indexTCO,xc,yc].Texte:='';
        tco[IndexTCO,NouvX,yc].FeuOriente:=n;  // nouveau nombre d'éléments
        tco[IndexTCO,NouvX,yc].NumCanton:=canton[IdCantonSelect].numero;
        Tco[IndexTCO,NouvX,yc].texte:=Tco[IndexTCO,xc,yc].texte;
        Tco[IndexTCO,NouvX,yc].train:=Tco[IndexTCO,xc,yc].train;
        canton[IdCantonSelect].x:=NouvX;
        //Dessin_cantonH(indexTCO,PcanvasTCO[indexTCO],NouvX,yc,0);
        Affiche_TCO(IndexTCO);
      end;
    end;
    if prise_haut or prise_bas then
    begin
      with canton[IdCantonSelect] do
      begin
        xc:=x;
        yc:=y; // évite la confusion entre canton[].x et le x de l'entrée de procédure
        An:=Nelements;  // ancien nombre d'éléments
        n:=round(abs(gd.bottom-gd.top) / haut);
        if prise_bas then
        begin
          NouvY:=yc;
          for i:=1 to n do Tco[indexTCO,xc,yc+i-1].BImage:=Id_CantonV+(i-1);
          if n<An then for i:=n to An-1 do Tco[indexTCO,xc,Nouvy+i].BImage:=20;  // si on a diminué le nombre de cases du canton, remplir les anciennes de 20
        end;
        if prise_haut then
        begin
          for i:=1 to n do
          begin
            NouvY:=yc-(n-Nelements);
            tco[indexTCO,xc,NouvY+i-1].Bimage:=Id_CantonV+(i-1);
          end;
          if n<An then for i:=yc to Nouvy-1 do Tco[indexTCO,xc,i].BImage:=20;
        end;
        Nelements:=n;
        tco[indexTCO,xc,yc].Texte:='';
        tco[IndexTCO,xc,NouvY].FeuOriente:=n;
        tco[IndexTCO,xc,NouvY].NumCanton:=canton[IdCantonSelect].numero;
        Tco[IndexTCO,xc,Nouvy].train:=Tco[IndexTCO,xc,yc].train;
        Tco[IndexTCO,xc,Nouvy].Texte:=Tco[IndexTCO,xc,yc].texte;
        canton[IdCantonSelect].y:=NouvY;
        //Dessin_cantonV(indexTCO,PcanvasTCO[indexTCO],xc,Nouvy,0);
        Affiche_TCO(IndexTCO);
      end;
    end;
  end;

  prise_droit:=false;
  prise_gauche:=false;
  prise_bas:=false;
  prise_haut:=false;
  prise_NE:=false;
  prise_SO:=false;
  prise_SE:=false;
  prise_NO:=false;
  prise_N:=false;

  // on relache la souris après avoir tiré un rectange de sélection
  if selectionAffichee[indexTCO] and (FormTCO[indexTCO].RadioGroupSel.ItemIndex=0) then
  //
  begin
    xo:=(xMiniSel-1)*LargeurCell[indexTCO];
    yo:=(yMiniSel-1)*hauteurCell[indexTCO];
    lg:=((xMaxiSel-xMiniSel)+1)*LargeurCell[indexTCO];
    ht:=((yMaxiSel-yMiniSel)+1)*HauteurCell[indexTCO];
    //affiche('relache carré',clWhite);
    SelecBouge:=true;

    // poubouge dynamique BitBlt(oldbmp.canvas.handle,0,0,lg,ht,FormTCO[IndexTCO].ImageTCO.Canvas.Handle,xo,yo,SRCCOPY);

  end;
end;

procedure TFormTCO.ButtonRedessineClick(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=index_TCO(sender);
  Affiche_TCO(indexTCO);
end;

// changement de l'adresse d'un élément
procedure TFormTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,indexTCO,Bim : integer;
    s: string;
begin
//  exit;
  //Affiche('EditAdrElement change',clyellow);
  //if clicTCO or not(ConfCellTCO) then exit;

  if clicTCO then
  begin
    HideCaret(EditAdrElement.Handle);  // supprime le curseur
    exit;
  end;
  //clicTCO:=true;
  indexTCO:=index_TCO(sender);
  bim:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;
  if bim=0 then exit;

  auto_tcurs:=false;  // interdit le déplacement du curseur encadré du TCO (pour que les touches curseur s'applique au Tedit)
  s:=formTCO[indexTCO].EditAdrElement.Text;
  if length(s)>1 then
  begin
    if (s[1]='A') or (s[1]='a') then delete(s,1,1);
    EditAdrElement.Text:=s;
  end;

  Val(s,Adr,erreur);
  if erreur<>0 then begin clicTCO:=false;exit; end;
  if (Adr<0) or (Adr>2048) then Adr:=0;
  clicTCO:=false;

  if Adr=0 then tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].repr:=2;

  efface_entoure(indexTCO);
  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse:=Adr;
  formConfCellTCO.editAdrElement.Text:=intToSTR(Adr);
  tco_Modifie:=true;

  // si signal
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].BImage=Id_signal then
  begin
    {index:=Index_Signal(adr);
    if index=0 then exit
    else }
      begin
       affiche_tco(indexTCO);
     end;
  end;

  Affiche_cellule(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
end;


// mise à jour des cellules de l'adresse "adresse"
procedure Maj_TCO(indexTCO,Adresse : integer);
var x,y: integer;
begin
  if indexTCO>nbreTCO then
  begin
    Affiche('Erreur 268',clred);
    exit;
  end;
  if PcanvasTCO[indexTCO]=nil then exit;

  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        if tco[indextco,x,y].Adresse=Adresse then
        begin
          affiche_cellule(indexTCO,x,y);
          entoure_cell_grille(indexTCO,x,y);  // si grille
        end;
      end;
end;

// mise à jour des aiguillages
procedure Maj_Aig_TCO(indexTCO :integer);
var x,y: integer;
begin
  if PcanvasTCO[indexTCO]=nil then exit;
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        if IsAigTJDCroiTCO(tco[indextco,x,y].Bimage) then
        begin
          affiche_cellule(indexTCO,x,y);
        end;
      end;
end;

// affiche les cellules des tco dont l'adresse d'aiguillage/dét est adresse
Procedure Texte_aig_fond(adresse : integer);
var ntco,x,y,Bim : integer;
begin
  for ntco:=1 to NbreTCO do
  begin
    // trouver les cellules comportant l'aiguillage adresse
    if PcanvasTCO[ntco]<>nil then
    begin
      for y:=1 to NbreCellY[ntco] do
        for x:=1 to NbreCellX[ntco] do
        begin
          Bim:=TCO[ntco,x,y].Bimage;
          if TCO[ntco,x,y].Adresse=adresse then
          begin
            affiche_cellule(ntco,x,y);
          end;
        end;
    end;
  end;
end;



procedure TFormTCO.ImagePalette10EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  end_drag(10,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette11EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(11,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette10);
end;

procedure TFormTCO.ImagePalette11MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette11);
end;

procedure TFormTCO.ButtonConfigTCOClick(Sender: TObject);
begin
  TformconfigTCO.create(self);
  formconfigTCO.showmodal;
  formconfigTCO.close;
  defocusControl(ButtonConfigTCO,true);
end;

// dépose un signal
procedure TFormTCO.ImagePalette50EndDrag(Sender, Target: TObject; X, Y: Integer);
var indexTCO,Xclic,Yclic : integer;
begin
  if not(Target is TImage) then exit;
  if (x=0) and (y=0) then exit;
  indexTCO:=index_TCO(sender);

  xclicCell[indexTCO]:=(x div LargeurCell[indexTCO]) +1;
  yclicCell[indexTCO]:=(y div LargeurCell[indexTCO]) +1;

  xclic:=xclicCell[indexTCO];
  yclic:=yclicCell[indexTCO];

  BitBlt(formTCO[indexTCO].imageTCO.canvas.handle,oldx,oldy,LargeurCell[indexTCO],hauteurCell[indexTCO],oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure(indexTCO);
  TCO_modifie:=true;
  stocke_undo(indexTCO,1,XClic,YClic);
  maj_undo(1);
  efface_cellule(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,PmCopy);
  raz_cellule(indextco,xClic,yClic);
  tco[indextco,XClic,YClic].BImage:=Id_signal;
  tco[indextco,XClic,YClic].FeuOriente:=1;
  tco[indextco,XClic,YClic].PiedSignal:=1;
  tco[indextco,XClic,YClic].coulFonte:=clWhite;
  clicTCO:=true;
  editAdrElement.Text:='';
  clicTCO:=false;
  EdittypeImage.Text:=IntToSTR(tco[indextco,XClic,YClic].BImage);
  Dessin_Signal(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,XClic,YClic);
end;


procedure TFormTCO.ImagePalette50MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var l,h,indexTCO : integer;
begin
  l:=Formprinc.Image9feux.width;    //57
  h:=Formprinc.Image9feux.height;   //105
  indexTCO:=Index_tco(sender);
  TCODrag:=IndexTCO;
  ImagePalette50.BeginDrag(true);
  BitBlt(OldBmp.Canvas.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);
  drag:=1;
  oldx:=offsetSourisX;oldy:=offsetSourisY;

  with formTCO[indexTCO].ImageTemp2.Canvas do
  begin
    pen.Color:=clfond[IndexTCO];
    brush.Color:=clblack;
    Rectangle(0,0,91,91);
  end;
  TransparentBlt(formTCO[indexTCO].ImageTemp2.canvas.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],   // destination avec mise à l'échelle   //50,50 ok 51,51 nok
                 formprinc.Image9feux.Canvas.Handle,0,0,50,90,clblue);

  formtco[indexTCO].ImageTCO.repaint;
  formTCO[indexTCO].ImageTemp:=formTCO[indexTCO].ImageTemp2;
  BitBlt(formTCO[indexTCO].ImageTemp.canvas.Handle,0,0,20,20,formTCO[indexTCO].ImageTemp2.canvas.Handle,0,0,SRCCOPY);
  formtco[indexTCO].ImageTCO.repaint;
end;

procedure Tourne90G(indexTCO : integer);
var BImage : integer;
begin
  if actualize then exit;
  BImage:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;
  if Bimage<>Id_signal then exit;

  TCO_modifie:=true;

  // effacement de l'ancien signal
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=3 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=2 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]-1,yClicCell[indexTCO],PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=1 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO]+1,PmCopy);
  end;

  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente:=2;  // signal orienté à 90° gauche
  Affiche_TCO(indexTCO);
  actualise(indexTCO);    // met à jour la fenetre de config de la cellule
end;

procedure TFormTCO.Tourner90GClick(Sender: TObject);
var indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  tourne90G(indextco);      
end;

procedure tourne90D(indexTCO : integer);
var BImage,aspect,adresse : integer;
begin
  if actualize then exit;
  BImage:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;
  if Bimage<>Id_signal then exit;

  TCO_modifie:=true;

  adresse:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse;
  aspect:=Signaux[Index_Signal(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // ancien signal orienté orienté 90D
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=3 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    if aspect>=4 then Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  // ancien signal orienté orienté 90G
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=2 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    if aspect>=4 then Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=1 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO]+1,PmCopy);
  end;

  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente:=3;  // feu orienté à 90° droit
  Affiche_TCO(indexTCO);
  actualise(indexTCO);    // met à jour la fenetre de config de la cellule
end;

procedure TFormTCO.Tourner90DClick(Sender: TObject);
var c : tcomponent;
    indexTCO : integer;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  tourne90D(indextco);
end;

procedure vertical180(indexTCO : integer);
var BImage ,aspect,Adresse : integer;
begin
  if actualize then exit;
  BImage:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;
  // si c'est autre chose qu'un signal, sortir
  if Bimage<>Id_signal then exit;

  TCO_modifie:=true;
  adresse:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse;
  aspect:=Signaux[Index_Signal(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // effacement de l'ancien signal

  // ancien signal orienté orienté 90D
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=3 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    // si le signal occupe 2 cellules
    if aspect>=4 then Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  // ancien signal orienté orienté 90G
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=2 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    // si le signal occupe 2 cellules
    if aspect>=4 then Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=1 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO]+1,PmCopy);
  end;

  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente:=4;  // signal orienté à 180°
  affiche_tco(indexTCO);
  actualise(indexTCO);    // met à jour la fenetre de config de la cellule
end;


procedure vertical(indexTCO : integer);
var BImage ,aspect,Adresse : integer;
begin
  if actualize then exit;
  BImage:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;
  // si c'est autre chose qu'un signal, sortir
  if Bimage<>Id_signal then exit;

  TCO_modifie:=true;
  adresse:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse;
  aspect:=Signaux[Index_Signal(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // effacement de l'ancien signal

  // ancien signal orienté orienté 90D
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=3 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    // si le signal occupe 2 cellules
    if aspect>=4 then Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  // ancien signal orienté orienté 90G
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=2 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    // si le signal occupe 2 cellules
    if aspect>=4 then Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO]+1,yClicCell[indexTCO],PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente=1 then
  begin
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO],PmCopy);
    Efface_Cellule(indexTCO,PCanvasTCO[indexTCO],xClicCell[indexTCO],yClicCell[indexTCO]+1,PmCopy);
  end;

  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].FeuOriente:=1;  // signal orienté à 180°
  affiche_tco(indexTCO);
  actualise(indexTCO);    // met à jour la fenetre de config de la cellule
end;

procedure TFormTCO.Pos_vertClick(Sender: TObject);
var c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  vertical(index_tco(c));
end;

procedure TFormTCO.Signalvertical180Click(Sender: TObject);
var c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  vertical180(index_tco(c));
end;

procedure TFormTCO.TrackBarZoomChange(Sender: TObject);
var indextco : integer;
begin
  if affevt then Affiche('TrackBarZoomChange',clyellow);
  indexTCO:=index_tco(sender);
  ZoomInit[indexTCO]:=TrackBarZoom.Position;
  //Affiche(intToSTR(TrackBarZoom.position),clred);
  calcul_cellules(indexTCO);
  Affiche_TCO(indexTCO);
  SelectionAffichee[indexTCO]:=false;
  Rect_select.NumTCO:=0;
  AncienIdCantonSelect:=IdCantonSelect;
  IdCantonSelect:=0;

  tabstop:=false;
  defocusControl(trackbarZoom,true);
 {  Affiche(intToSTR(FormTCO.ScrollBox.HorzScrollBar.Range),clyellow);
  with formTCO.imagetCO.Canvas do
  begin
    moveTo(0,0);
    pen.Color:=clwhite;
    LineTo(FormTCO.ScrollBox.HorzScrollBar.Range,100);
    lineTo(0,300);
  end;  }
end;


procedure TFormTCO.EditTexteChange(Sender: TObject);
var indexTCO : integer;
begin
  if clicTCO then exit;
  if affevt then Affiche('TCO.EditTextChange',clOrange);
  auto_tcurs:=false;  // interdit le déplacement du curseur encadré du TCO (pour que les touches curseur s'applique au Tedit)
  indexTCO:=index_TCO(sender);
  PCanvasTCO[indexTCO].Brush.Color:=Clfond[IndexTCO];
  efface_entoure(indexTCO);

  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].texte='' then
  begin
    tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].CoulFonte:=clTexte;
    tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].TailleFonte:=8;
  end;

  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Texte:=EditTexte.Text;
  formConfCellTCO.EditTexteCCTCO.Text:=EditTexte.Text;
  TCO_modifie:=true;
  affiche_texte(indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]);
end;

procedure TFormTCO.ButtonSimuClick(Sender: TObject);
begin
  aiguillage[Index_Aig(1)].position:=const_devie;
  aiguillage[Index_Aig(2)].position:=const_devie;
  aiguillage[Index_Aig(3)].position:=const_droit;
  aiguillage[Index_Aig(4)].position:=const_devie;
  aiguillage[Index_Aig(5)].position:=const_devie;
  aiguillage[Index_Aig(8)].position:=const_droit;
  aiguillage[Index_Aig(9)].position:=const_devie;
  aiguillage[Index_Aig(7)].position:=const_devie;
  aiguillage[Index_Aig(12)].position:=const_devie;
  aiguillage[Index_Aig(20)].position:=const_droit;
  aiguillage[Index_Aig(21)].position:=const_droit;
  aiguillage[Index_Aig(26)].position:=const_droit;
  aiguillage[Index_Aig(28)].position:=const_droit;
  index_couleur:=1;
  aiguillage[Index_Aig(81)].position:=const_droit;
  aiguillage[Index_Aig(82)].position:=const_droit;
  aiguillage[Index_Aig(120)].position:=const_droit;
  aiguillage[Index_Aig(119)].position:=const_droit;
  aiguillage[Index_Aig(116)].position:=const_droit;
  aiguillage[Index_Aig(117)].position:=const_devie;

  //debugTco:=true;
  zone_tco(1,527,519,1,0,1,false,false);
 //   zone_tco(518,515,1);

  //zone_tco(522,514,1);

  //zone_tco(514,522,1);
end;

procedure TFormTCO.CheckPinvClick(Sender: TObject);
var Bimage,indexTCO : integer;
begin
  if clicTCO then exit;
  if actualize then exit;
  indexTCO:=index_TCO(sender);
  if (xClicCell[indexTCO]=0) or (xClicCell[indexTCO]>NbreCellX[indexTCO]) or (yClicCell[indexTCO]=0) or (yClicCell[indexTCO]>NbreCelly[indexTCO]) then exit;
  Bimage:=tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].Bimage;
  if IsAigTJDCroiTCO(Bimage) then
  begin
    tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].inverse:=CheckPinv.checked;
    TCO_modifie:=true;
  end;
end;

procedure TFormTCO.ButtonMasquerClick(Sender: TObject);
begin
  PanelBas.Hide;
  ScrollBox.Height:=ClientHeight-32;
  BandeauMasque:=true;
  Bandeau.Caption:='Afficher le bandeau';
end;

procedure TFormTCO.ImageTCODblClick(Sender: TObject);
var Bimage,Adresse,i,indextco,xt,yt,idcanton : integer;
    tjdC : boolean;
begin
  if affEvt then Affiche('Double clic',clYellow);
  //clicsouris:=false;

  doubleclic:=true;
  Tdoubleclic:=3;

  auto_tcurs:=true;  // autorise le déplacement du des touches curseur encadré du TCO
  indexTCO:=index_TCO(sender);

  Bimage:=tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].BImage;
  Adresse:=tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].Adresse;

  // double clic sur détecteur : inversion
  if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and (adresse<>0) then
  //if not(isAigTCO(Bimage)) and (adresse<>0) then
  begin
    if EvtClicDet then
    begin
      //if detecteur[adresse].etat=false then
      efface_entoure(indextco);
      event_detecteur(adresse,not(detecteur[adresse].etat),'');
    end
      else detecteur[adresse].etat:=not(detecteur[adresse].etat);
    //clicsouris:=false;
    //Maj_TCO(indexTCO,Adresse);
    doubleclic:=false;
    exit;
  end;

  tjdC:=false;
  // commande tjd/c
  if (Bimage=21) or (Bimage=22) or (Bimage=23) or (Bimage=25) then
  begin
    i:=Index_aig(Adresse);
    if aiguillage[i].modele=crois then exit;
    tjdC:=(aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs);
  end;

  // commande aiguillage
  if IsAigTJDCroiTCO(Bimage) or TJDc then
  begin
    aiguille:=Adresse;
    i:=Index_aig(Adresse);
    if i=0 then
    begin
      Affiche('Aiguillage '+intToSTR(adresse)+' non configuré pour pilotage',clOrange);
      doubleclic:=false;
      exit;
    end;

    TformAig.create(nil);

    formAig.showmodal;
    formAig.close;
    piloteAig:=true;
  end;

  if isCanton(Bimage) then
  begin
    if IdCantonSelect>0 then
    begin
      IndexTCO:=canton[IdCantonSelect].Ntco;   // reprendre l'index du TCO depuis le canton car on a peut etre cliqué sur un autre TCO
      xt:=canton[IdCantonSelect].x;
      yt:=canton[IdCantonSelect].y;
      IdCanton:=TCO[IndexTCO,xt,yt].NumCanton;
      formSelTrain.Show;
      doubleclic:=false;
      exit;
    end;
  end;

  // commande de signal
  if Bimage=Id_signal then
  begin
    AdrPilote:=adresse;
    i:=Index_Signal(adresse);
    if i=0 then begin doubleclic:=false;exit;end;
    with formPilote do
    begin
      show;
      ImagePilote.Parent:=FormPilote;
      ImagePilote.Picture.Bitmap.TransparentMode:=tmAuto;
      ImagePilote.Picture.Bitmap.TransparentColor:=clblue;
      ImagePilote.Transparent:=true;

      ImagePilote.Picture.BitMap:=Signaux[i].Img.Picture.Bitmap;
      LabelTitrePilote.Caption:='Pilotage du signal '+intToSTR(Adresse);
      Signaux[0].EtatSignal:=Signaux[i].EtatSignal;

      LabelNbFeux.Visible:=False;
      EditNbreFeux.Visible:=false;
      GroupBox1.Visible:=true;
      GroupBox2.Visible:=true;
      efface_entoure(indexTCO);
      SelectionAffichee[indexTCO]:=false;

      if isDirectionnel(i) then
      begin
        GroupBox1.Visible:=false;
        GroupBox2.Visible:=false;
        LabelNbFeux.Visible:=true;
        EditNbreFeux.Visible:=true;
        EditNbreFeux.Text:='1';
      end
      else
      begin
        LabelNbFeux.Visible:=False;
        EditNbreFeux.Visible:=false;
        GroupBox1.Visible:=true;
        if (Signaux[i].aspect<20) then GroupBox2.Visible:=true else GroupBox2.Visible:=false;
      end;
    end;
  end;
  //clicsouris:=false;
  dbleClicTCO:=true;
  doubleclic:=false;
end;

procedure TFormTCO.ComboReprChange(Sender: TObject);
var indexTCO : integer;
begin
  if clicTCO then exit;
  indexTCO:=index_TCO(sender);
  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Repr:=comborepr.ItemIndex;
  efface_entoure(indexTCO);
  SelectionAffichee[indexTCO]:=false;
  formConfCellTCO.ComboRepr.ItemIndex:=ComboRepr.ItemIndex;
  defocusControl(ComboRepr,true);
  affiche_tco(indexTCO);
end;

procedure TFormTCO.ImagePalette1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette2DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette3DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette4DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette5DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette12DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette13DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette14DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette15DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette21DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette22DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette51DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette24DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette25DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette20DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;


procedure TFormTCO.ImagePalette51EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(id_Quai,x,y,sender,target);
end;


procedure TFormTCO.ImagePalette24EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(24,x,y,sender,target);
end;

procedure TFormTCO.ImagePalette25EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(25,x,y,sender,target);
end;

procedure TFormTCO.ImagePalette20EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(20,x,y,sender,target);
end;

procedure TFormTCO.ImagePalette51MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette51);
end;

procedure TFormTCO.ImagePalette24MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette24);
end;

procedure TFormTCO.ImagePalette25MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette25);
end;

procedure TFormTCO.ImagePalette20MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette20);
end;

procedure TFormTCO.ImagePalette6DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette7DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette8DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette9DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette16DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette17DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette18DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette19DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette10DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette11DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette50DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.PanelBasDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure change_fonte(indexTCO : integer);
var s,ss : string;
    fs : TFontStyles;
begin
  s:='Fonte et couleur pour la cellule ('+intToSTR(xClicCell[indexTCO])+','+intToSTR(YClicCell[indexTCO])+') Texte: ';
  ss:=tco[indextco,xClicCell[indexTCO],YClicCell[indexTCO]].Texte;
  if ss='' then s:=s+inttoSTR(tco[indextco,xClicCell[indexTCO],YClicCell[indexTCO]].Adresse) else s:=s+ss;

  titre_fonte:=s;
  With FormTCO[indexTCO] do
  begin
    FontDialog1.Font.Name:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].Fonte;
    FontDialog1.Font.Color:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].CoulFonte;
    FontDialog1.Font.Size:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].taillefonte;

    fs:=[];
    s:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].FontStyle;
    if pos('G',s)<>0 then fs:=fs+[fsbold];
    if pos('I',s)<>0 then fs:=fs+[fsItalic];
    if pos('S',s)<>0 then fs:=fs+[fsUnderline];
    if pos('B',s)<>0 then fs:=fs+[fsStrikeout];
    FontDialog1.Font.Style:=fs;

    if FontDialog1.execute then
    begin
      tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].Fonte:=FontDialog1.Font.Name;
      tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].CoulFonte:=FontDialog1.Font.Color;
      tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].taillefonte:=FontDialog1.Font.Size;
      fs:=FontDialog1.Font.Style;
      s:='';
      if fsBold in fs then s:=s+'G';
      if fsItalic in fs then s:=s+'I';
      if fsUnderline in fs then s:=s+'S';
      if fsStrikeout in fs then s:=s+'B';
      tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].FontStyle:=s;
      affiche_tco(indexTCO);
    end;
  end;
end;

procedure TFormTCO.ButtonFonteClick(Sender: TObject);
begin
  change_fonte(index_tco(sender));
end;

procedure TFormTCO.FontDialog1Show(Sender: TObject);
begin
  SetWindowText(FontDialog1.Handle,pchar(titre_Fonte));
end;

procedure TFormTCO.ColorDialog1Show(Sender: TObject);
begin
  SetWindowText(ColorDialog1.Handle,pchar(titre_couleur));
end;

procedure signalD(indexTCO : integer);
begin
  if actualize then exit;
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage=Id_signal then
  begin
    tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].PiedSignal:=2;
    Affiche_TCO(indexTCO);
    TCO_modifie:=true;
    actualise(indexTCO);    // met à jour la fenetre de config de la cellule
  end;
end;

procedure TFormTCO.Signaldroitedelavoie1Click(Sender: TObject);
var c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  signalD(index_TCO(c));
end;

procedure signalG(indexTCO : integer);
begin
  if actualize then exit;
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage=Id_signal then
  begin
    tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].PiedSignal:=1;
    Affiche_TCO(indexTCO);
    TCO_modifie:=true;
    actualise(indexTCO);    // met à jour la fenetre de config de la cellule
  end;
end;

procedure TFormTCO.Signalgauchedelavoie1Click(Sender: TObject);
var c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  signalG(index_tco(c));
end;

procedure TFormTCO.PopupMenu1Popup(Sender: TObject);
var Bim,oriente,piedFeu,indexTCO : integer;
    c : Tcomponent;
begin
  if affevt then Affiche('on popup',clyellow);
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  indexTCOcourant:=indexTCO;

  PopUpMenu1.Items[9][0].Caption:='Ligne au dessus de la '+intToSTR(YclicCell[indexTCO]);
  PopUpMenu1.Items[9][1].Caption:='Ligne en dessous de la '+intToSTR(YclicCell[indexTCO]);
  PopUpMenu1.Items[9][3].Caption:='Colonne à gauche de la '+intToSTR(XclicCell[indexTCO]);
  PopUpMenu1.Items[9][4].Caption:='Colonne à droite de la '+intToSTR(XclicCell[indexTCO]);

  PopUpMenu1.Items[10][0].Caption:='Ligne '+intToSTR(YclicCell[indexTCO]);
  PopUpMenu1.Items[10][1].Caption:='Colonne '+intToSTR(XclicCell[indexTCO]);

  // grise ou non l'entrée signal du menu
  Bim:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage;
  if Bim=Id_signal then
  begin
    PopUpMenu1.Items[6].Enabled:=true;
    // coche sur l'orientation du signal
    oriente:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Feuoriente;
    if oriente=1 then
    begin
      PopUpMenu1.Items[6][0].checked:=false;
      PopUpMenu1.Items[6][1].checked:=false;
      PopUpMenu1.Items[6][2].checked:=true;
      PopUpMenu1.Items[6][3].checked:=false;
    end;
    if oriente=2 then
    begin
      PopUpMenu1.Items[6][0].checked:=true;
      PopUpMenu1.Items[6][1].checked:=false;
      PopUpMenu1.Items[6][2].checked:=false;
      PopUpMenu1.Items[6][3].checked:=false;
    end;
    if oriente=3 then
    begin
      PopUpMenu1.Items[6][0].checked:=false;
      PopUpMenu1.Items[6][1].checked:=true;
      PopUpMenu1.Items[6][2].checked:=false;
      PopUpMenu1.Items[6][3].checked:=false;
    end;
    if oriente=4 then
    begin
      PopUpMenu1.Items[6][0].checked:=false;
      PopUpMenu1.Items[6][1].checked:=false;
      PopUpMenu1.Items[6][2].checked:=false;
      PopUpMenu1.Items[6][3].checked:=true;
    end;
    // coche sur l'orientation du pied
    PiedFeu:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].PiedSignal;
    if PiedFeu=1 then
    begin
      PopUpMenu1.Items[6][5].checked:=true;
      PopUpMenu1.Items[6][6].checked:=false;
    end;
    if PiedFeu=2 then
    begin
      PopUpMenu1.Items[6][5].checked:=false;
      PopUpMenu1.Items[6][6].checked:=true;
    end;
  end
  else
    PopUpMenu1.Items[6].Enabled:=false;

  if iscanton(Bim) then
  begin
    PopUpMenu1.Items[12].Enabled:=true;
    PopUpMenu1.Items[13].Enabled:=true
  end
  else
  begin
    PopUpMenu1.Items[12].Enabled:=false;
    PopUpMenu1.Items[13].Enabled:=false;
  end;

end;

// encadre la ligne cliquée du tco courant
procedure encadre_ligne;
var ligneY : integer;
begin
  ligneY:=YClicCell[indexTCOcourant];
  xCadre1:=1;yCadre1:=(ligneY-1)*HauteurCell[IndexTcoCourant];
  xCadre2:=NbreCellX[IndexTCOCourant]*LargeurCell[IndexTCOCourant] ; yCadre2:=(ligneY)*HauteurCell[IndexTcoCourant];
  with PcanvasTCO[indexTCOCourant] do
  begin
    pen.Mode:=pmXor;
    pen.width:=5;
    pen.Color:=clred;
    Brush.Color:=clblack;
    Rectangle(xCadre1,yCadre1,xCadre2,yCadre2);
    ligneAffiche:=not(ligneAffiche);
  end;
end;

// encadre la colonne cliquée du tco courant
procedure encadre_colonne;
var ligneY : integer;
begin
  ligneY:=XClicCell[indexTCOcourant];
  xCadre1:=(ligneY-1)*HauteurCell[IndexTcoCourant];yCadre1:=1;
  xCadre2:=(ligneY)*HauteurCell[IndexTcoCourant];  yCadre2:=NbreCellY[IndexTCOCourant]*HauteurCell[IndexTcoCourant];
  with PcanvasTCO[indexTCOCourant] do
  begin
    pen.Mode:=pmXor;
    pen.width:=5;
    pen.Color:=clred;
    Brush.color:=clBlack;
    Rectangle(xCadre1,yCadre1,xCadre2,yCadre2);
    colonneAffiche:=not(colonneAffiche);
  end;
end;

procedure TFormTCO.N3Click(Sender: TObject);
var c : Tcomponent;
    indexTCO : integer;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);

  FormConfCellTCO.show;
  FormConfCellTCO.BringToFront;
  actualise(IndexTCO);   // actualiser après avoir affiché formConfCellTCO
end;

procedure TFormTCO.LigneDessousClick(Sender: TObject);
var indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);

  if NbreCellY[indexTCO]>=MaxCellY then exit;
  TamponAffecte:=false;
  init_tampon_copiercoller;
  ligne_Supprime:=YClicCell[indexTCO]+1; // variable globale
  insere_ligne(indexTCO,ligne_Supprime);
  affiche_TCO(indexTCO);
end;

procedure TFormTCO.LigneDessusClick(Sender: TObject);
var c : tcomponent;
    indexTCO : integer;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);

  if NbreCellY[indexTCO]>=MaxCellY then exit;
  TamponAffecte:=false;
  init_tampon_copiercoller;
  ligne_Supprime:=YClicCell[indexTCO]; // variable globale
  insere_ligne(indexTCO,ligne_Supprime);
  affiche_TCO(indexTCO);
end;

// insersion colonne
procedure TFormTCO.Colonnegauche1Click(Sender: TObject);
var indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellX[indexTCO]>=MaxCellX then exit;

  TamponAffecte:=false;
  init_tampon_copiercoller;
  colonne_supprime:=XClicCell[indexTCO];
  insere_colonne(indexTCO,colonne_supprime);
  affiche_TCO(indexTCO);
end;

procedure TFormTCO.Colonnedroite1Click(Sender: TObject);
var indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellX[indexTCO]>=MaxCellX then exit;

  TamponAffecte:=false;
  init_tampon_copiercoller;
  colonne_supprime:=XClicCell[indexTCO]+1;
  insere_colonne(indexTCO,colonne_supprime);
  affiche_TCO(indexTCO);
end;


procedure TFormTCO.SupprimeLigneClick(Sender: TObject);
var x,y,i,yy,indexTCO,n,xc,yc,Bimage : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellY[indexTCO]<=1 then exit;
  TamponAffecte:=true;
  ligne_supprime:=YClicCell[indexTCO];
  // tampon de sauvegarde

  TamponTCO_org.numTCO:=indexTCO;
  TamponTCO_Org.NbreCellX:=NbreCellX[indexTCO];
  TamponTCO_Org.NbreCellY:=NbreCellY[indexTCO];
  TamponTCO_Org.x1:=1;
  TamponTCO_Org.y1:=ligne_supprime;
  TamponTCO_Org.x2:=NbreCellX[indexTCO];
  TamponTCO_Org.y2:=ligne_supprime;

  // case de destination
  TamponTCO_org.xOrg:=1;
  TamponTCO_org.yOrg:=ligne_supprime;

  // remplir tampon de sauvegarde
  for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
    for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      begin
        //Affiche(intToSTR(x)+' '+intToSTR(y),clyellow);
        tampontco[x,y]:=tco[indextco,x,y];
      end;

  // balayer les cantons pour supprimer canton horizontal
  for i:=1 to nCantons do
  begin
    y:=canton[i].y;
    n:=canton[i].numero;
    if (canton[i].horizontal) and (y=ligne_Supprime) then
    begin
      //supprimer le canton horizontal
      supprime_remplace_canton(i);
      Affiche('canton '+intToSTR(n)+' supprimé',clOrange);
    end
  end;

  yc:=0;
  // voir si la ligne contient un canton vertical, réajuster son nombre
  for x:=1 to NbreCellX[indexTCO] do
  begin
    if isCantonV(tco[indexTCO,x,ligne_supprime].BImage) then
    begin
      xc:=x;yc:=ligne_Supprime;
      origine_canton(xc,yc);
      n:=tco[indexTCO,xc,yc].NumCanton;
      if n<>0 then
      begin
        i:=index_canton_numero(n);
        if canton[i].Nelements=3 then
        begin
          Affiche('Le canton '+intToSTR(n)+' est supprimé car il comporte moins de 3 cases',clOrange);
          supprime_remplace_canton(i);
        end
        else
        begin
          //Affiche('Diminution Canton '+intToSTR(n)+' réajusté',clOrange);
          dec(canton[i].Nelements);
          dec(tco[indexTCO,xc,yc].FeuOriente);
        end;
      end;
    end;
  end;

  // décalage TCO sur ligne supprimée
  for y:=ligne_supprime to NbreCellY[indexTCO]-1 do
  begin
    for x:=1 to NbreCellX[indexTCO] do
    begin
      // ne pas écraser ler 1er élément d'un cantonV car il contient le nombre
      if (tco[indexTco,x,y].BImage<>id_cantonV) then tco[indextco,x,y]:=tco[indextco,x,y+1];
    end;
  end;

  // supprimer la dernière ligne du tco
  for x:=1 to NbreCellX[indexTCO] do
  begin
    raz_cellule(indextco,x,NbreCellY[indexTCO]);
    tco[indextco,x,NbreCellY[indexTCO]].Couleurfond:=Clfond[IndexTCO];
  end;
  dec(NbreCellY[indexTCO]);

  // décrémenter les coordonnées Y des cantons dont la ligne est supérieure à la ligne supprimée
  for i:=1 to nCantons do
  begin
    y:=canton[i].y;
    if y>=ligne_supprime then dec(canton[i].y);
  end;

  // verifier si les cantons verticaux: corriger leurs origine y et ses Bimage
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
    begin
      Bimage:=tco[indextco,x,y].BImage;
      if Bimage=id_CantonV then
      begin
        i:=tco[indexTCO,x,y].NumCanton;
        i:=Index_canton_numero(i);
        n:=canton[i].Nelements;
        canton[i].y:=y;   // origine Y
        i:=0;
        for yy:=y to y+n-1 do     // parcourir les Bimage du canton
        begin
          tco[indexTCO,x,yy].BImage:=Id_CantonV+i;
          inc(i);
        end;
      end;
    end;

  TCO_modifie:=true;
  affiche_TCO(indexTCO);
end;

// suppression colonne
procedure TFormTCO.ColonneClick(Sender: TObject);
var x,y,xx,xc,yc,i,indexTCO,n,Bimage : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellX[indexTCO]<=1 then exit;
  TamponAffecte:=true;
  colonne_supprime:=XClicCell[indexTCO];

  // tampon de sauvegarde
  TamponTCO_org.numTCO:=indexTCO;
  TamponTCO_Org.NbreCellX:=NbreCellX[indexTCO];
  TamponTCO_Org.NbreCellY:=NbreCellY[indexTCO];
  TamponTCO_Org.x1:=colonne_supprime;
  TamponTCO_Org.x2:=colonne_supprime;
  TamponTCO_Org.y1:=1;
  TamponTCO_Org.y2:=NbreCellY[indexTCO];

  // cellule de destination
  TamponTCO_org.xOrg:=colonne_supprime;
  TamponTCO_org.yOrg:=1;

  // remplir tampon de sauvegarde
  for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
    for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      tampontco[x,y]:=tco[indextco,x,y];


  // balayer les cantons pour supprimer canton verticzl
  for i:=1 to nCantons do
  begin
    x:=canton[i].x;
    n:=canton[i].numero;
    if not(canton[i].horizontal) and (x=colonne_Supprime) then
    begin
      //supprimer le canton vertical
      supprime_remplace_canton(i);
      Affiche('canton '+intToSTR(n)+' supprimé',clOrange);
    end
  end;

  xc:=0;
  // voir si la ligne contient un canton horizontal, réajuster son nombre
  for y:=1 to NbreCellY[indexTCO] do
  begin
    if isCantonH(tco[indexTCO,colonne_supprime,y].BImage) then
    begin
      yc:=y;xc:=colonne_Supprime;
      origine_canton(xc,yc);
      n:=tco[indexTCO,xc,yc].NumCanton;
      if n<>0 then
      begin
        i:=index_canton_numero(n);
        if canton[i].Nelements=3 then
        begin
          Affiche('Le canton '+intToSTR(n)+' est supprimé car il comporte moins de 3 cases',clOrange);
          supprime_remplace_canton(i);
        end
        else
        begin
          //Affiche('Canton '+intToSTR(n)+' réajusté',clOrange);
          dec(canton[i].Nelements);
          dec(tco[indexTCO,xc,yc].FeuOriente);
        end;
      end;
    end;
  end;

  // supression colonne
  for x:=xClicCell[indexTCO] to NbreCellx[indexTCO]-1 do
  begin
    for y:=1 to NbreCelly[indexTCO] do
    begin
      if (tco[indextco,x,y].BImage<>id_cantonH) then tco[indextco,x,y]:=tco[indextco,x+1,y];
    end;
  end;

  // supprimer la dernière colonne du TCO
  for y:=1 to NbreCellY[indexTCO] do
  begin
    raz_cellule(indextco,NbreCellx[indexTCO],y);
    tco[indextco,NbreCellx[indexTCO],y].CouleurFond:=Clfond[IndexTCO];
  end;
  dec(NbreCellX[indexTCO]);

  // décrémenter les coordonnées Y des cantons dont la colonne est supérieure à la colonne supprimée
  for i:=1 to nCantons do
  begin
    x:=canton[i].x;
    if x>=colonne_supprime then dec(canton[i].x);
  end;

  // verifier les cantons horizontaux: corriger leurs origine y et ses Bimage
  for x:=1 to NbreCellX[indexTCO] do
    for y:=1 to NbreCellY[indexTCO] do
    begin
      Bimage:=tco[indextco,x,y].BImage;
      if Bimage=id_CantonH then
      begin
        i:=tco[indexTCO,x,y].NumCanton;
        i:=Index_canton_numero(i);
        n:=canton[i].Nelements;
        canton[i].x:=x;   // origine X
        i:=0;
        for xx:=x to x+n-1 do     // parcourir les Bimage du canton
        begin
          tco[indexTCO,xx,y].BImage:=Id_CantonH+i;
          inc(i);
        end;
      end;
    end;

  TCO_modifie:=true;
  affiche_TCO(indexTCO);
end;

procedure TFormTCO.buttonRazClick(Sender: TObject);
var x,y,indexTCO : integer;
begin
  indexTCO:=index_tco(sender);
  for x:=1 to NbreCellx[indexTCO] do
    for y:=1 to NbreCelly[indexTCO] do tco[indextco,x,y].mode:=0;
  Affiche_TCO(indexTCO);
  defocusControl(buttonRaz,true);
end;

procedure TFormTCO.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var i,maxi,indexTCO : integer;
begin
  if affevt then Affiche('FormMouseWheel',clOrange);
  indexTCO:=index_tco(sender);
  i:=FormTCO[indexTCO].TrackBarZoom.Position;

  if WheelDelta>0 then
  begin
    if (i<=ZoomMin) then
    begin
      FormTCO[indexTCO].TrackBarZoom.Position:=ZoomMin;
      exit;
    end;
    dec(i);
  end
  else
  begin
    if (i>=ZoomMax) then
    begin
      FormTCO[indexTCO].TrackBarZoom.Position:=ZoomMax;
      exit;
    end;
    inc(i);
  end;

  // positionner la trackbar zoom
  FormTCO[indexTCO].TrackBarZoom.Position:=i;
  calcul_cellules(indexTCO);
  Affiche_TCO(indexTCO);
  SelectionAffichee[indexTCO]:=false;

  //positionner les trackbar du scrollbox sur la position cliquée de la souris
  {GetCursorPos(Position);
  x:=position.x div LargeurCell[indexTCO] +1 ;
  y:=position.Y div hauteurCell[indexTCO] +1 ;
  ScrollBox.HorzScrollBar.position:=x;
  ScrollBox.VertScrollBar.position:=y;
  exit;}

  maxi:=ScrollBox.HorzScrollBar.Range-ScrollBox.ClientWidth;
  i:=round(xClicCell[indexTCO]*maxi/NbreCellx[indexTCO]);
  ScrollBox.HorzScrollBar.position:=i;

  maxi:=ScrollBox.VertScrollBar.Range-ScrollBox.ClientHeight;
  i:=round(yClicCell[indexTCO]*maxi/NbreCelly[indexTCO]);
  ScrollBox.VertScrollBar.position:=i;
end;

procedure TFormTCO.ButtonCalibrageClick(Sender: TObject);
var indexTCO,x,y : integer;
begin
  x:=0;
  y:=0;
  indexTCO:=index_tco(sender);
  Affiche('Calibrage='+intToSTR(largeurCell[indexTCO]),clyellow);
  calcul_reduction(frxGlob[indexTCO],fryGlob[indexTCO],LargeurCell[indexTCO],hauteurCell[indexTCO]);
  with imageTCO.Canvas do
  begin
    pen.color:=clyellow;
    moveTo( round(x),round(y*fryGlob[indexTCO]) );
    LineTo( round((x+LargeurCell[indexTCO])),round(y+hauteurCell[indexTCO]*ratioC/10) );
  end;
  Affiche(formatfloat('0.000000',frxGlob[indexTCO]),clyellow);
  //dessin_Action(1,PcanvasTCO[1],3,3,1);

end;

procedure change_couleur_fond(indexTCO : integer);
var cs : string;
    x,y,xmini,ymini,xmaxi,ymaxi : integer;
begin
  xmini:=XminiSel;
  ymini:=YminiSel;
  xmaxi:=XmaxiSel;
  ymaxi:=YmaxiSel;

  if selectionaffichee[indexTCO] then
  begin
    if (FormTCO[indexTCO].RadioGroupSel.ItemIndex=1) and (Rect_select.NumTCO=indexTCO) then
    begin
      xMini:=(Rect_select.Gd.Left div largeurCell[indexTCO])+1;
      yMini:=(Rect_select.Gd.top div hauteurCell[indexTCO])+1;
      xMaxi:=(Rect_select.Gd.right div largeurCell[indexTCO])+1;
      yMaxi:=(Rect_select.Gd.bottom div hauteurCell[indexTCO])+1;
    end;

    cs:='Fond de la sélection ['+intToSTR(Xmini)+','+intToSTR(Ymini)+'] ['+intToSTR(Xmaxi)+','+intToSTR(Ymaxi)+']';
    titre_couleur:=cs;
  end
  else
  begin
    if (xClicCell[indexTCO]=0) or (YclicCell[indexTCO]=0) then exit;
    titre_couleur:='Fond de la cellule '+intToSTR(XClicCell[indexTCO])+','+intToSTR(YclicCell[indexTCO]);
  end;

  with formTCO[indexTCO] do
  begin
    cs:='ColorA='+IntToHex(clfond[IndexTCO],6);  // pour rajouter aux couleurs personnalisées
    colorDialog1.CustomColors.Add(cs);
    if colorDialog1.Execute then
    begin
      if selectionaffichee[indexTCO] then
      begin
        selectionaffichee[indexTCO]:=false;

        // efface le rectangle de sélection graphique
        if (FormTCO[indexTCO].RadioGroupSel.ItemIndex=1) and (Rect_select.NumTCO=indexTCO) then
        begin
          affiche_rectangle(IndexTCO,Rect_select);
          Rect_select.NumTCO:=0;
        end;
        for y:=Ymini to Ymaxi do
          for x:=Xmini to Xmaxi do
            tco[indextco,x,y].CouleurFond:=ColorDialog1.Color;
      end
      else tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].CouleurFond:=ColorDialog1.Color;

      ShapeCoulFond.Brush.Color:=ColorDialog1.Color;

      sauve_styles_tco(indexTCO);
      TCO_modifie:=true;
      Affiche_TCO(indexTCO);
    end;
  end;
end;


procedure TFormTCO.ButtonCoulFondClick(Sender: TObject);
begin
  change_couleur_fond(index_tco(sender));
end;

procedure TFormTCO.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if affevt then Affiche('TCO.FormKeyPress',clOrange);
  //MessageBeep(MB_ICONEXCLAMATION);
  toucheTCO:=key;
end;

procedure TFormTCO.ImagePalette1MouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette1);
end;

procedure TFormTCO.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.EditTypeImageChange(Sender: TObject);
var Bimage,erreur,indexTCO : integer;
begin
  // plus éditable
  if clicTCO or not(ConfCellTCO) then exit;
  if affevt then Affiche('TCO evt editTypeImageChange',clorange);
  if actualize then exit;
  indexTCO:=index_tco(sender);
  Val(EditTypeImage.Text,Bimage,erreur);
  if (erreur<>0) or not(Bimage in[0..29,32..34,id_signal,id_quai,id_action]) then
  begin
    exit;
  end;
  TCO_modifie:=true;

  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage:=Bimage;
  //formConfCellTCO.EditTypeImage.Text:=intToSTR(Bimage);
  //actualise(indexTCO); // pour mise à jour de l'image de la fenetre FormConfCellTCO
  efface_entoure(indexTCO);
  affiche_cellule(indexTCO,XClicCell[indexTCO],YClicCell[indexTCO]);
end;

// popup menu
procedure TFormTCO.Toutslectionner1Click(Sender: TObject);
var c: tComponent;
    indexTCO : integer;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if indexTCO<1 then exit;
  // si le rectangle de sélection graphique est affiché dans ce tco, l'effacer
  if Rect_select.NumTCO=indexTCO then
  begin
    affiche_rectangle(IndexTCO,Rect_select);
    Rect_select.NumTCO:=0;
    selectionAffichee[indexTCO]:=false;
  end;
  RadioGroupSel.ItemIndex:=0; // repasser en mode sélection par cellules
  selec_tout(indexTCO);
end;

procedure dessinerTCO(indexTCO : integer);
begin
  if not(modetrace[indexTCO]) then
  begin
    tamponAffecte:=false;
    ligne_supprime:=0;
    colonne_supprime:=0;
    modetrace[indexTCO]:=true;
    indexTrace:=0;
    traceXY[1].x:=0;
    traceXY[1].y:=0;
    traceXY[2].x:=0;
    traceXY[2].x:=0;
    FormTCO[indexTCO].Caption:='TCO'+intToSTR(indexTCO)+' ** Mode dessin **  Clic droit pour lever le pointeur. Touche Echap pour quitter le mode tracé. CTRL-Z ou annuler pour annuler les derniers tracés.';
    screen.cursor:=crUpArrow;
  end
  else stop_modetrace(indexTCO);
end;

procedure TFormTCO.ButtonDessinerClick(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=index_tco(sender);
  dessinerTCO(indexTCO);
  defocusControl(buttonDessiner,true);
end;


procedure TFormTCO.ImagePalette26DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette26EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(26,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette26MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette26);
end;

procedure TFormTCO.ImagePalette23EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(23,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette23DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette23MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette23);
end;

procedure TFormTCO.ImagePalette27DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette27MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette27);
end;

procedure TFormTCO.ImagePalette27EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(27,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette28DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette28EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(28,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette28MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette28);
end;

procedure TFormTCO.ImagePalette29DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 accept:=true;
end;

procedure TFormTCO.ImagePalette29EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(29,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette29MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette29);
end;

procedure TFormTCO.ImagePalette32DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette32EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(32,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette32MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette32);
end;

procedure TFormTCO.ImagePalette33DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette33EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(33,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette33MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette33);
end;

procedure TFormTCO.ImagePalette34DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette34EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(34,x,y,Sender,Target);
end;

procedure TFormTCO.ImagePalette34MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette34);
end;

procedure TFormTCO.EditAdrElementClick(Sender: TObject);
begin
//  auto_tcurs:=false;
end;

procedure TFormTCO.ImagePalette53DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette52EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(id_Action,x,y,sender,target);
end;

procedure TFormTCO.ImagePalette53MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette53);
end;

procedure TFormTCO.ButtonAffSCClick(Sender: TObject);
begin
  with formprinc do
  begin
    windowState:=wsNormal; //Maximized;
    show;
    BringToFront;
  end;
end;


procedure TFormTCO.RadioGroupSelClick(Sender: TObject);
var indexTCO : integer;
begin
  indextco:=index_TCO(sender);
  if indexTCO=0 then exit;
  // sélection par cellules
  if RadioGroupSel.ItemIndex=0 then
  begin
    screen.cursor:=crDefault;
    // efface le rectangle graphique du TCO courant
    if Rect_select.NumTCO=indexTCO then
    begin
      affiche_rectangle(IndexTCO,Rect_select);
      Rect_select.NumTCO:=0;
    end;
    selectionAffichee[indexTCO]:=false;
  end;
  // sélection par outil graphique
  if RadioGroupSel.ItemIndex=1 then
  begin
    efface_entoure(indexTCO);
    efface_selection(IndexTCO);
    selectionAffichee[indexTCO]:=false;
  end;

  defocusControl(RadioGroupSel,true);
end;

// renvoie le numéro de TCO à l'origine de l'evt du mainmenutco
function TformTCO.index_TCOMainMenu : integer;
var t : Tcontrol;
    s : string;
begin
  t:=FindControl(mainmenuTCO.WindowHandle);  // on ne peut pas remonter au parent d'un mainmenu avec getparentcomponent
  s:=t.name;   // nom de la form TCOx
  result:=extract_int(s);
end;

procedure TFormTCO.SauvegarderleTCO1Click(Sender: TObject);
begin
  sauve_fichiers_tco;
end;

procedure TFormTCO.DessinerleTCO1Click(Sender: TObject);
var indexTCO : integer;

begin
  indexTCO:=index_TCOMainMenu; // renvoie le numéro du TCO qui est à l'origine de l'evt menu
  dessinerTCO(indexTCO);
end;

procedure TFormTCO.ConfigurationduTCO1Click(Sender: TObject);
begin
  TformconfigTCO.create(self);
  formconfigTCO.showmodal;
  formconfigTCO.close;
  defocusControl(ButtonConfigTCO,true);
end;

procedure TFormTCO.Redessine1Click(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=index_TCOMainMenu;
  Affiche_TCO(indexTCO);
end;

procedure masque_bandeau(indexTCO : integer);
begin
  with formTCO[indexTCO] do
  begin
    PanelBas.Hide;
    ScrollBox.Height:=ClientHeight;
    BandeauMasque:=true;
    Bandeau.Caption:='Afficher le bandeau';
  end;
end;

procedure TFormTCO.BandeauClick(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=index_TCOMainMenu;
  if bandeauMasque then
  begin
    PanelBas.Show;
    PanelBas.Visible:=true;
    BandeauMasque:=false;
    positionne(indexTCO);
    Bandeau.Caption:='Masquer le bandeau';
    exit;
  end
  else
  begin
    masque_bandeau(indexTCO);
  end;
end;

procedure TFormTCO.Mosaquehorizontale1Click(Sender: TObject);
begin
  mosaiqueH;
end;

procedure TFormTCO.Mosaqueverticale1Click(Sender: TObject);
begin
  mosaiqueV;
end;

procedure TFormTCO.AfficherSignauxComplexes1Click(Sender: TObject);
begin
  with formprinc do
  begin
    windowState:=wsNormal; //Maximized;
    show;
    BringToFront;
  end;
end;

procedure TFormTCO.RechargerleTCOdepuislefichier1Click(Sender: TObject);
var indexTCO,res : integer;
begin
  indexTCO:=index_TCOMainMenu;
  if TCO_modifie then
  begin
    res:=MessageDlg('Un des TCO a été modifié. '+#13+'Voulez-vous recharger le TCO : '+nomfichierTCO[indexTCO],mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if res=mrNo then exit;
  end;
  TCO_modifie:=false;
  lire_fichier_tco(indexTCO);
  Affiche_TCO(indexTCO);
end;

procedure TFormTCO.Supprimercanton1Click(Sender: TObject);
var c : tcomponent;
   index,El,indexTCO,xc,yc : integer;
   s : string;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  xc:=xClicCell[indexTCO];
  yc:=yClicCell[indexTCO];
  El:=tco[indexTCO,xc,yc].BImage;

  if isCanton(El) then
  begin
    s:='Voulez vous supprimer le canton ';
    if isCantonH(El) then xc:=xc-(El-Id_cantonH);
    if isCantonV(El) then yc:=yc-(El-Id_cantonV);

    index:=index_canton(indexTCO,xc,yc);
    if index<>0 then s:=s+intToSTR(canton[index].numero)+' '+canton[index].nom;
    s:=s+' ?';
    if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
  end;

  supprime_remplace_canton(index);
  tco_modifie:=true;
  Affiche_tco(indexTCO);
end;

procedure TFormTCO.Affecterlocomotiveaucanton1Click(Sender: TObject);
var c : tcomponent;
   El,indexTCO,xc,yc : integer;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  xc:=xClicCell[indexTCO];
  yc:=yClicCell[indexTCO];
  El:=tco[indexTCO,xc,yc].BImage;
  if isCanton(El) then
  //if ((El>=Id_CantonH) and (El<=Id_CantonH+9)) or ((El>=Id_CantonV) and (El<=Id_CantonV+9)) then
  begin
    formSelTrain.Show;
  end;
end;

procedure TFormTCO.ImagePalette52MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   debut_drag(ImagePalette52);
end;

procedure TFormTCO.ImagePalette52DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette53EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(53,x,y,Sender,Target);
end;

procedure raz_canton_org_dest(idcantonDragOrg : integer);
var idtrain,Norg,Ndest : integer;
begin
  idTrain:=canton[idcantonDragOrg].indexTrain;
  trains[idtrain].canton:=0;
  Trains[idtrain].route[0].adresse:=0;
  canton[idcantonDragOrg].NomTrain:='';
  canton[idcantonDragOrg].indexTrain:=0;
  canton[idcantonDragOrg].adresseTrain:=0;
  Norg:=index_canton_numero(canton[idcantonDragOrg].NumcantonOrg);
  Ndest:=index_canton_numero(canton[idcantonDragOrg].NumcantonDest);
  canton[idcantonDragOrg].NumcantonOrg:=0;
  canton[idcantonDragOrg].NumcantonDest:=0;
  canton[idcantonDragOrg].bouton:=0;
  if norg>0 then
  begin
    canton[Norg].bouton:=0;
    canton[Norg].NumcantonOrg:=0;
    canton[Norg].NumCantonDest:=0;
    dessin_canton(Norg,0);
  end;
  if nDest>0 then
  begin
    canton[Ndest].bouton:=0;
    canton[Ndest].NumcantonOrg:=0;
    canton[Ndest].NumCantonDest:=0;
    dessin_canton(Ndest,0);
  end;
  TCO[canton[idcantonDragOrg].Ntco,canton[idcantonDragOrg].x,canton[idcantonDragOrg].y].train:=0;
end;

// fin de drag des trains dans le canton de dépose
procedure TFormTCO.ImageTCOEndDrag(Sender, Target: TObject; X, Y: Integer);
var s : string;
    Sens,idCantondest,IdTrain,Bim,xdest,ydest,xOrg,Yorg,indexTCO,milieuX_pix,milieuY_pix,
    xPix,yPix,adresse,AdrTrain,xDrag,yDrag,trainDest,idTrainDest : integer;
    t : tequipement;
begin
  if not(Target is TImage) then exit;
  s:=(Target as TImage).Name;
  if copy(s,1,8)<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  indexTCO:=Index_tco(sender);
  Drag:=0;

  xDrag:=x;yDrag:=y;
  // canton origine
  xOrg:=canton[IdCantonDragOrg].x;
  yOrg:=canton[IdCantonDragOrg].y;

  // coordonnnées cellules de la destination
  xdest:=(x div largeurCell[indexTCO])+1;
  ydest:=(y div largeurCell[indexTCO])+1;
  x:=xdest;
  y:=ydest;
  coord_canton(indexTCO,x,y);  // x et y deviennent les coordonnées origine du canton

  Bim:=tco[indexTCO,xdest,ydest].BImage;
  // si on dépose pas sur un canton
  if not(IsCanton(Bim)) then
  begin
    s:='Voulez vous supprimer le train '+canton[idcantonDragOrg].NomTrain+' du canton '+intToSTR(canton[idcantonDragOrg].numero)+' ?';
    if Application.MessageBox(pchar(s),pchar('confirmation'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idYes then
    begin
      supprime_route_train(canton[idcantonDragOrg].indexTrain);
      AdrTrain:=canton[idcantonDragOrg].adresseTrain;
      Raz_cantons_train(AdrTrain,true);
      raz_canton_org_dest(idcantonDragOrg);
    end;

    Affiche_TCO(indexTCO);
    exit;
  end;

  // dessine le train sur le canton de destination
  //BitBlt(PcanvasTCO[indexTCO].handle,oldx+50,oldy,LIcone,hIcone,oldbmp.canvas.handle,0,0,SRCCOPY);


  // ici on dépose sur un canton
  AdrTrain:=canton[IdCantonDragOrg].adresseTrain; // train sur le canton source
  cantonDest:=tco[IndexTCO,x,y].NumCanton;
  IdCantonDest:=index_canton_numero(cantonDest);
  IdTrain:=index_train_adresse(AdrTrain);

  Traindest:=canton[IdcantonDest].adresseTrain;
  idTrainDest:=index_train_adresse(TrainDest);

  if (TrainDest<>0) and (TrainDest<>AdrTrain) then
  begin
    s:='Le train '+Trains[idTrain].nom_train+' va écraser le train '+Trains[idTrainDest].nom_train+#13;
    s:=s+'Voulez-vous continuer?';
    if Application.MessageBox(pchar(s),pchar('Confirmation'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then
    begin
      Affiche_tco(indexTCO);
      exit;
    end;
  end;

  // si le train du canton source a une route affectée
  if Trains[IdTrain].route[0].adresse<>0 then
  begin
    s:='Le train '+Trains[idTrain].nom_train+' a une route affectée.'+#13;
    if idcantonDest=idcantonDragOrg then s:=s+'Changer le sens de départ va détruire sa route.'+#13
    else s:=s+'Changer le train de canton va détruire sa route.'+#13;
    s:=s+'Voulez vous continuer ?';
    if Application.MessageBox(pchar(s),pchar('Confirmation'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then
    begin
      Affiche_tco(indexTCO);
      exit;
    end;
    supprime_route_train(idTrain);
  end;

  // voir si gauche ou droit du canton
  Xpix:=(x-1)*LargeurCell[indexTCO];
  Ypix:=(y-1)*HauteurCell[indexTCO];

  milieuX_pix:=xpix+(canton[idcantonDest].Nelements*largeurCell[indexTCO] div 2);
  milieuY_pix:=ypix+(canton[idcantonDest].Nelements*HauteurCell[indexTCO] div 2);

  if canton[idcantonDest].horizontal then
  begin
    if xDrag>milieuX_pix then sens:=sensDroit
    else sens:=sensGauche;
  end
  else
  begin
    if yDrag>milieuY_pix then sens:=sensBas
    else sens:=sensHaut;
  end;

  // vérifier si le sens de dépose est compatible avec le sens du canton
  if (canton[idcantonDest].SensCirc<>0) and (canton[idcantonDest].SensCirc<>sens) then
  begin
    s:='Le sens de circulation du canton '+intToSTR(canton[idcantonDest].numero)+' ne permet pas de positionner le train dans ce sens';
    formTCO[indexTCO].Caption:=s;
    //Affiche(intToSTR(ypix),clred);
    Affiche_TCO(indexTCO);
    FormInfo.LabelInfo.caption:=s;
    Affiche_info(indexTCO,xpix,ypix,s);
    exit;
  end;

  // raz train canton d'origine
  IdTrain:=canton[IdCantonDragOrg].indexTrain;
  supprime_route_train(canton[idcantonDragOrg].indexTrain);
  //Raz_trains_idcanton(IdCantonDragOrg);  // raz du train du canton
  raz_cantons_train(canton[idCantonDragOrg].adresseTrain,true); // true=avec raz détecteur

  // affectation train canton destination
  affecte_Train_canton(trains[idTrain].adresse,IdCantonDest,sens);

  // si le canton destination était occupé au déplacement d'un train de canton
  if (TrainDest<>0) and (cantonDest<>CantonOrg) then
  begin
    supprime_route_train(idTrainDest);
    raz_cantons_train(TrainDest,true); // true=avec raz détecteur
  end;

  Affiche_TCO(indexTCO);
  XclicCell[indexTCO]:=xDest;
  YclicCell[indexTCO]:=yDest;

  if idcantonDragOrg<>IdCantonDest then
  begin
    raz_canton_org_dest(idcantonDragOrg);
  end;
  actualise_seltrains;  // actualise la fenetre FormSelTrains

  // Affecter le train au détecteur si l'élément concerné du canton est un détecteur
  case sens of
    SensGauche,SensHaut : begin adresse:=canton[idCantonDest].el1; t:=canton[idCantonDest].typ1;end;
    SensDroit,sensBas   : begin adresse:=canton[idCantonDest].el2; t:=canton[idCantonDest].typ2;end;
  end;
  if t=det then
  begin
    detecteur[adresse].AdrTrain:=canton[idCantonDest].adresseTrain;
    detecteur[adresse].Train:=canton[idCantonDest].NomTrain;
  end;
  maj_signaux(false);
end;


procedure TFormTCO.AffRoutesClick(Sender: TObject);
var x,y,idc : integer;
begin
  with formrouteTrain do
  begin
    windowState:=wsNormal; //Maximized;;
    TabSheetRA.Enabled:=true;
    x:=XClicCell[indexTCOCourant];
    y:=YClicCell[indexTCOCourant];
    if isCanton(TCO[indexTcoCourant,x,y].BImage) then
    begin
      origine_canton(x,y);
      if (x<>0) and (y<>0) then
      begin
        idc:=Index_Canton_numero(tco[indexTCOcourant,x,y].NumCanton);    //index canton
        indextrainFR:=canton[idc].indexTrain;
      end;
    end;
    Show;
  end;
end;

procedure TFormTCO.Optiondesroutes1Click(Sender: TObject);
var GMode,l2,h2 : integer;
    XFormScale,XFormRot,XFormOld,XFormXLat,xform  : TXForm;
    angle,Zoom : single;
    recta : trect;
begin
 formRoute.Show;
 { angle:=5;
  Zoom:=2;
  l2:=trains[1].icone.picture.width div 2;
  h2:=trains[1].icone.picture.height div 2;


  GMode:=SetGraphicsMode(PCanvasTCO[1].Handle, GM_ADVANCED);
  if GetWorldTransform(PCanvasTCO[1].Handle, XFormOld) then  // renvoie la matrice courante dans XformOld
  begin
    // faire les 3 transformations
    XFormRot:=XForm_Rotation(Angle,Point(l2,h2));      // rotation autour du centre
    XFormScale:=XForm_Echelle(Zoom,Zoom,point(l2,h2)); // Zoom au point central
    XFormXLat:=XForm_Translation(x-l2,y-h2);           // décalage

    // Combiner les 3 transformations
    CombineTransform(XForm,XFormRot,XFormScale);     // Xform<-- f(XformRot,XformScale)
    CombineTransform(XForm,XForm,XFormXLat);         // Xform<-- f(Xform,XformScale)

    if not(premaff) then recta:=rect(trains[1].x0,trains[1].y0,trains[1].x1,trains[1].y1);
    premaff:=false;
    PCanvasTCO[1].CopyRect(recta,trains[1].SBitmap.canvas,rect(0,0,trains[1].x1-trains[1].x0,trains[1].y1-trains[1].y0));   // copie dans Acanvas <-- SbitMap.canvas

    // sauvegarder à la nouvelle position avant d'afficher la nouvelle position
    recta:=rect(x0,y0,x1,y1);
    trains[IndexTrain].sbitmap.canvas.CopyRect(rect(0,0,larg,haut),Acanvas,recta);   // copie dans sbitmap.canvas <-- Acanvas
    //FormAnalyseCDM.Image1.Canvas.CopyRect(rect(0,0,larg,haut),Acanvas,recta );

    trains[IndexTrain].x0:=x0;
    trains[IndexTrain].y0:=y0;
    trains[IndexTrain].x1:=x1;
    trains[IndexTrain].y1:=y1;

    // appliquer les transformations dans le canvas et afficher l'icône du train
    SetWorldTransform(ACanvas.Handle,XForm);         // mettre dans le canvas
    ACanvas.Draw(0,0,FWICImage);                     // afficher le bitmap
    SetWorldTransform(ACanvas.Handle,XFormOld);
  end; }
end;

procedure TFormTCO.Trouverunlment1Click(Sender: TObject);
var x,y : integer;
    trouve : boolean;
begin
  IndexTCOCourant:=index_TCOMainMenu;
  AchercherDet:=0;
  AchercherCanton:=0;
  FormIntro.showmodal;
  y:=1;
  repeat
    x:=1;
    repeat
      if AchercherDet<>0 then trouve:=tco[IndexTCOCourant,x,y].Adresse=AchercherDet;
      if AchercherCanton<>0 then
        trouve:=tco[IndexTCOCourant,x,y].NumCanton=Acherchercanton;
      inc(x);
    until (x>NbreCellX[IndexTCOCourant]) or trouve;
    inc(y);
  until (y>NbreCellY[IndexTCOCourant]) or trouve;
  if trouve then
  begin
    dec(x);dec(y);
    x:=(x-1)*LargeurCell[indexTCOCourant];
    y:=(y-1)*HauteurCell[indexTCOCourant];
    with PcanvasTCO[indexTcoCourant] do
    begin
      Pen.Color:=clLime;
      Pen.Width:=3;
      moveto(0,0);LineTo(x,y);
    end;
  end;
end;

procedure TFormTCO.Mmoiredezone1Click(Sender: TObject);
begin
  FormMemZone.show;
  FormMemZone.BringToFront;

end;

procedure TFormTCO.EditAdrElementExit(Sender: TObject);
begin
  auto_tcurs:=true;  // réautorise le déplacement du curseur
  defocusControl(EditAdrElement,true);
end;

procedure TFormTCO.Modeslection1Click(Sender: TObject);
begin
  ModeSlection1.checked:=true;
  ModeDplacement1.Checked:=false;
  modeGlisse:=false;
end;

procedure TFormTCO.Modedplacement1Click(Sender: TObject);
begin
  ModeSlection1.checked:=false;
  ModeDplacement1.Checked:=true;
  modeGlisse:=true;
end;

end.


