unit UnitTCO;
// ne pas utiliser les éléments 30 et 31 qui sont les anciens signaux et quais
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote, UnitDebug,
  ComCtrls ,StrUtils, math, unitconfig, UnitAnalyseSegCDM,  Buttons , verif_version ;

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
    Panel1: TPanel;
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
    Button1: TButton;
    Button2: TButton;
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
    ButtonMasquer: TButton;
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
    Affichebandeau1: TMenuItem;
    Affichage1: TMenuItem;
    Mosaquehorizontale1: TMenuItem;
    Mosaqueverticale1: TMenuItem;
    N10: TMenuItem;
    AfficherSignauxComplexes1: TMenuItem;
    Signalvertical180: TMenuItem;
    RafrachirleTCO1: TMenuItem;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
    procedure Panel1DragOver(Sender, Source: TObject; X, Y: Integer;
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
    procedure ImagePalette24DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette24EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette24MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette25DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette25EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette25MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ImagePalette1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette4DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure EditTypeImageChange(Sender: TObject);
    procedure Toutslectionner1Click(Sender: TObject);
    procedure ButtonDessinerClick(Sender: TObject);
    procedure ImagePalette26DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette26EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette26MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette23EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette23DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette23MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette27DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette27MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette27EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette28DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette28EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette28MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette29DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette29EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette29MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette32DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette32EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette32MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette33DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette33EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette33MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette34DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette34EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette34MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditAdrElementClick(Sender: TObject);
    procedure ImagePalette52DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette52EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette52MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonAffSCClick(Sender: TObject);
    procedure RadioGroupSelClick(Sender: TObject);
    procedure SauvegarderleTCO1Click(Sender: TObject);
    procedure DessinerleTCO1Click(Sender: TObject);
    procedure ConfigurationduTCO1Click(Sender: TObject);
    procedure Redessine1Click(Sender: TObject);
    procedure Affichebandeau1Click(Sender: TObject);
    procedure Mosaquehorizontale1Click(Sender: TObject);
    procedure Mosaqueverticale1Click(Sender: TObject);
    procedure AfficherSignauxComplexes1Click(Sender: TObject);
    procedure Signalvertical180Click(Sender: TObject);

  private
    { Déclarations privées }
    function index_TCOMainMenu : integer;
  public
    { Déclarations publiques }
  end;

const
  MaxCellX=150;MaxCellY=70;
  licone=35;
  hicone=35;
  maxUndo=30;
  ZoomMax=(8191 div MaxCellX)-1;  // pour ne pas dépasser un canvas de 8191 pixel maxi
  ZoomMin=15;
  ClFond_ch='CoulFond';
  clVoies_ch='CoulVoies';
  clAllume_ch='CoulAllume';
  clGrille_ch='CoulGrille';
  clTexte_ch='CoulTexte';
  clQuai_ch='CoulQuai';
  clPiedSignal_ch='CoulPiedSig';
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

  // liaisons des voies pour chaque icone par bit (0=NO 1=Nord 2=NE 3=Est 4=SE 5=S 6=SO 7=Ouest)
  Liaisons : array[0..52] of integer=
   // 0   1   2   3   4   5  6   7  8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28 29 30 31
     (0,$88,$c8,$8c,$98,$89,$9,$84,$90,$48,$44,$11,$19,$c4,$91,$4c,$21,$24,$42,$12,$22,$cc,$99,$66,$23,$33,$26,$62,$32,$31,0,0,
     // 32  33  34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52
       $64,$13,$46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ;
type
  // structure d'une cellule du TCO
  TTCO = record
           Adresse     : integer;     // adresse du détecteur ou de l'aiguillage ou du feu OU si action sortie : adresse
           BImage      : integer;     // icone: 0=rien 1=voie 2=aiguillage gauche  ... 50=feu
           mode        : integer;     // couleur de voie 0=éteint 1=ClVoies 2=couleur dans le champ train
           train       : integer;     // numéro du train
           trajet      : integer;     // décrit le trajet ouvert sur la voie (cas d'un croisement ou d'une tjd/S)
           inverse     : boolean;     // aiguillage piloté inversé
           repr        : integer;     // position de la représentation texte 0 = rien 1=centré 2=Haut  3=Bas 4=réparti 5=double centré
           Texte       : string;      // texte de la cellule
           Fonte       : string;      // fonte du texte
           FontStyle   : string;      // GSIB  (Gras Souligné Italique Barré)
           coulFonte   : Tcolor;
           TailleFonte : integer;
           CouleurFond : Tcolor;      // couleur de fond
           // pour les signaux seulement ou action
           PiedFeu     : integer;     // type de pied au signal : signal à gauche=1 ou à droite=2 de la voie OU si action: type d'action
           x,y         : integer;     // coordonnées pixels relativés du coin sup gauche du signal pour le décalage par rapport au 0,0 cellule
           Xundo,Yundo : integer;     // coordonnées x,y de la cellule pour le undo
           FeuOriente  : integer;     // orientation du signal : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit  / OU si action : numéro du TCO etc
           liaisons    : integer;     // quadrants des liaisons
           epaisseurs  : integer;     // épaisseur des liaisons : si le bit n est à 1 : liaison fine
           pont        : integer;     // définition du pont : si le bit n est à 1 : pont (bits symétriques)
           buttoir     : integer;     // définition des buttoirs : si le bit n est à 1 : buttoir
           sortie      : integer;     // si action sortie : état
         end;

  // Outil graphique de sélection
  Trect_Select= record
                  NumTCO : integer;   // affectation du rectangle à ce tco
                  Gd,                 // grand rectangle
                  rN,rE,rS,rO,rNE,rNO,rSE,rSO : Trect;   // 8 poignées
               end;

var
  couleurAdresse,cltexte,CoulFonte : Tcolor;

  formTCO : array[1..10] of TformTCO;     // pointeur vers forms

  TamponAffecte,TCO_modifie,clicsouris,prise_N,
  clicTCO,piloteAig,BandeauMasque,eval_format,sauve_tco,prise_droit,prise_haut,
  prise_bas,prise_gauche,prise_NE,prise_NO,prise_SE,prise_SO,
  drag,TCOActive,TCOCree,ancienok,dbleClicTCO,auto_tcurs,EvtClicDet : boolean;

  HtImageTCO,LargImageTCO,XminiSel,YminiSel,XCoupe,Ycoupe,Temposouris,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,RatioC,ModeCouleurCanton,
  AncienXClicCell,AncienYClicCell,TCODrag,epaisseur_voies,Ax,Ay,TpsBougeSouris,
  Epaisseur,oldX,oldY,offsetSourisY,offsetSourisX,AvecVerifIconesTCO,indexTrace,IndexTCOCourant,
  ancienTraceX,ancienTraceY,rangUndo,NbreTCO,IndexTCOCreate,deltaXrect,deltaYrect,
  CellX,CellY : integer;

  titre_Fonte : string;

  // structure de tous les tco
  TCO : array[1..10] of
           array of array of TTco ;

  // tampon undo
  Undo : array[1..MaxUndo] of record
           nombre : integer;
           element : array[1..100] of TTCO ;
         end;

  // pour copier coller
  TamponTCO : array of array of TTco ;
  TamponTCO_Org : record
                   numTCO,x1,y1,x2,y2,NbreCellX,NbreCellY : integer;
                 end;

  Rect_select : Trect_Select;
  Sauv_rect_select : Trect;

  // tracé du train dans les TCO
  Trace_Train : array[1..10] of record
    train : array[1..Max_Trains] of record
      nombre : integer;
      route : array[1..500] of record x,y : integer;
      end;
    end;
    end;

  // tracé en mode dessin
  traceXY : Array[1..50] of record x,y : integer; // en coordonnées grille
            end;

  rAncien : TRect;
  VBm,OldBmp : TBitMap;
  PScrollBoxTCO : TScrollBox;

  // liste des variables par tco
  largeurCelld2,HauteurCelld2,NbCellulesTCO,NbreCellX,NbreCellY,LargeurCell,HauteurCell,
  Xentoure,Yentoure,XclicCell,YclicCell,EcranTCO,clGrille,clFond,ClAllume,ClVoies,
  ClCanton,clPiedSignal,ClQuai,ClBarriere,ZoomInit,Xinit,Yinit : array[1..10] of integer;
  PcanvasTCO : array[1..10] of Tcanvas;
  PBitMapTCO : array[1..10] of TbitMap;
  PImageTCO,PImageTemp : array[1..10] of Timage;
  frXGlob,frYGlob : array[1..10] of real;
  NomFichierTCO : array[1..10] of string;
  AvecGrille,SelectionAffichee,forminit,modeTrace,entoure : array[1..10] of boolean;


procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY : integer);
procedure calcul_cellules(indextco : integer);
procedure sauve_fichiers_tco;
procedure zone_TCO(indexTCO,det1,det2,train,mode: integer);
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
procedure signalG(indexTCO : integer);
procedure signalD(indexTCO : integer);
procedure lire_fichier_tco(indexTCO : integer);
procedure change_couleur_fond(indexTCO : integer);
function verif_cellule(IndexTCO,x,y,Bim : integer) : boolean;
procedure dessine_icones(indexTCO : integer);
procedure echange(var a,b : integer);
procedure Efface_Cellule(indextco : integer;Canvas : Tcanvas;x,y : integer;Mode : TPenMode);
procedure dessine_icone(indexTCO : integer;PCanvasTCO : tcanvas;Bimage,X,Y,mode : integer);
function IsAigTCO(i : integer) : boolean;
function index_TCO(t : Tobject) : integer;
procedure Init_TCO(indexTCO : integer);
procedure init_tampon_copiercoller;
procedure efface_trajet(det,train : integer);
Procedure Texte_aig_fond(adresse : integer);
procedure Maj_Aig_TCO(indexTCO : integer);

implementation

uses UnitConfigTCO, Unit_Pilote_aig, UnitConfigCellTCO ;

{$R *.dfm}

// renvoie l'index du tco d'après le nom de la forme (TCO1 TCO2)
// ne fonctionne que si t est un composant dont on peut remonter jusqu'à la form parent
// attention : si T est un popup menu, ca ne marche pas!!!
function index_TCO(t : Tobject) : integer;
var s : string;
    trouve : boolean;
    f : tcustomform;
    i,erreur : integer;
begin
  //s:=(t as Tcomponent).name;
  // Affiche(s,clWhite);
  f:=getparentForm(t as Tcontrol);
  s:=(f as Tcomponent).Name;
  //Affiche(s,clYellow);

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
procedure Accroche_Rectangle_selection(indexTCO,x,y : integer);
var dx,dy : integer;
    r : Trect;
    rien : boolean;
begin
  rien:=not(prise_droit) and not(prise_bas) and not(prise_gauche) and not(prise_haut) and not(prise_NE) and not(prise_NO) and not(prise_SE) and not(prise_SO);

  // poignée haut
  r:=Rect_Select.rN;
  if ((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_haut then
  begin
    screen.cursor:=crSizeNS;
    //if (not(prise_droit) and not(prise_bas) and not(prise_gauche) and not(prise_NE) and not(prise_NO) and not(prise_SE) and not(prise_SO)) and clicsouris  then
    if (rien and clicsouris) or prise_haut then
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
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_droit) then
  begin
    screen.cursor:=crSizeWE;
    //if (not(prise_haut) and not(prise_bas) and not(prise_gauche) and not(prise_NE) and not(prise_NO) and not(prise_SE) and not(prise_SO)) and clicsouris then
    if (rien and clicsouris) or prise_droit then
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
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_bas) then
  begin
    screen.cursor:=crSizeNS;
    if (rien and clicsouris) or prise_bas then
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
  r:=Rect_Select.rO;
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_gauche) then
  begin
    screen.cursor:=crSizeWE;
    if (rien and clicsouris) or prise_gauche then
    begin
      // efface l'ancien
      Affiche_Rectangle(IndexTCO,Rect_select);
      prise_gauche:=true;
      if x<rect_select.Gd.Right then
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
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_NE) then
  begin
    screen.cursor:=crSizeNESW;
    if (rien and clicsouris) or prise_NE then
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
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_NO) then
  begin
    screen.cursor:=crSizeNWSE;
    if (rien and clicsouris) or prise_NO then
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
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_SE) then
  begin
    screen.cursor:=crSizeNWSE;
    if (rien and clicsouris) or prise_SE then
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
  if (((x>=r.left) and (x<=r.Right) and (y>=r.top) and (y<=r.bottom)) or prise_SO) then
  begin
    screen.cursor:=crSizeNESW;
    if (rien and clicsouris) or prise_SO then
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
  if ((y>r.top) and (y<r.bottom) and (x>r.Left) and (x<r.Right)) or prise_N then
  begin
    screen.cursor:=crSizeAll;
    if not(prise_N) and clicSOuris then
    begin
      // sauvegarder le rectangle avant qu'on le bouge
      Sauv_rect_select:=Rect_Select.Gd;
      deltaXrect:=x-rect_Select.Gd.Left;
      DeltaYrect:=y-rect_Select.Gd.top;
    end;
    if (rien and clicsouris) or prise_N then
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
  ClTexte:=$00FF00;
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
        piedFeu:=0;
        x:=0;
        y:=0;
        FeuOriente:=0;
        Liaisons:=0;
        Epaisseur:=0;
        Buttoir:=0;
      end;
end;

procedure lire_fichier_tco(indexTCO : integer);
var fichier : textfile;
    s,sa,so : string;
    nv,x,y,i,j,m,adresse,valeur,erreur,FeuOriente,PiedFeu,tailleFont,e,NPar : integer;
    trouve_CoulFond,trouve_clVoies,trouve_clAllume,trouve_clGrille,trouve_clCanton,
    trouve_clTexte,trouve_clQuai,trouve_matrice,trouve_ratio,trouve_ModeCanton,
    trouve_AvecGrille,trouve_clPiedSignal : boolean;
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
   // assign(fichier,fichierTCO[indexTCO]);
    assign(fichier,NomfichierTCO[indexTCO]);
    reset(fichier);
  except
    init_tco(indexTCO);
    exit;
  end;
  {$I-}
  if debug=1 then Affiche('Lecture tco '+intToSTr(indexTCO)+' '+NomfichierTCO[indexTCO],clyellow);
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

  trouve_ModeCanton:=false;
  trouve_AvecGrille:=false;
  eval_format:=false;
  ModeCouleurCanton:=1;
  AvecGrille[indexTCO]:=true;
  clCanton[indexTCO]:=ClYellow;

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
    Affiche('TCO: le nombre de cellules X a été ramené à '+intToSTR(NbreCellX[indexTCO]),clred);
  end;
  if (NbreCellY[indexTCO]<5) or (NbreCellY[indexTCO]>MaxCellY) then
  begin
    NbreCellY[indexTCO]:=MaxCellY;
    Affiche('TCO: le nombre de cellules Y a été ramené à '+intToSTR(NbreCellX[indexTCO]),clred);
  end;

  try
    SetLength(TCO[indexTCO],MaxCellX+2,MaxCellY+2)
  except
    Affiche('TCO:Mémoire insuffisante pour'+intToSTR(MaxCellX)+' '+intToSTR(MaxCellY),clred);
    NbreCellX[indexTCO]:=20;NbreCellY[indexTCO]:=12;
    SetLength(TCO[indexTCO],NbreCellX[indexTCO]+2,NbreCellY[indexTCO]+2);
  end;

  try

    init_tampon_copiercoller;
  except
    Affiche('TamponTCO:Mémoire insuffisante',clred);
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
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO7',clred);closefile(fichier);exit;end;
        if valeur=30 then begin valeur:=Id_signal;sauve_tco:=true;end;
        if valeur=31 then begin valeur:=51;sauve_tco:=true;end;
        tco[indexTCO,x,y].Bimage:=valeur;
        tco[indexTCO,x,y].liaisons:=liaisons[valeur];
        delete(s,1,i);

        // 4 Inverse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO8',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO9',clred);closefile(fichier);exit;end;
        tco[indexTCO,x,y].inverse:=valeur=1;
        delete(s,1,i);

        // 5 FeuOriente
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO10',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),FeuOriente,erreur);if erreur<>0 then begin Affiche('ETCO11',clred);closefile(fichier);exit;end;
        delete(s,1,i);

        // 6 PiedFeu
        i:=pos(',',s); //j:=pos(')',s);
        //if j<i then i:=j;
        val(s,PiedFeu,erreur);
        delete(s,1,i);

        // si c'est un signal, remplir les paramètres du signal
        if tco[indexTCO,x,y].Bimage=Id_signal then
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
            tco[indexTCO,x,y].PiedFeu:=PiedFeu;
          end;
        end;
        // si c'est une action, remplir les paramètres de l'action
        if tco[indexTCO,x,y].Bimage=Id_action then
        begin
          tco[indexTCO,x,y].PiedFeu:=PiedFeu;       // quelle action
          tco[indexTCO,x,y].FeuOriente:=FeuOriente; // paramètre de l'action
        end;

        // 7 texte optionnel
        j:=pos(')',s);
        i:=pos(',',s);
        tco[indexTCO,x,y].Texte:='';
        if j>1 then // le , est avant le ) donc il y a un texte
        begin
          if j<i then m:=j else m:=i;
          tco[indexTCO,x,y].Texte:=copy(s,1,m-1) ;
          delete(s,1,m-1);
        end;

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

        // 14 pont
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

        i:=pos(')',s);
        if i<>0 then delete(s,1,i);

        inc(x);
      until s='';
    end;
    inc(y);x:=1;
  end;
  closefile(fichier);
  e:=sizeof(Tco) div 1024;
  //Affiche('Dimensions du tco : '+intToSTR(NbreCellX)+'x'+intToSTR(NbreCellY)+' / '+IntToSTR(e)+'Ko',clyellow);
  if not(trouve_clPiedSignal) then clPiedSignal:=Clvoies;

end;

procedure echange(var a,b : integer);
var i : integer;
begin
  i:=a;
  a:=b;
  b:=i;
end;

// donne l'équation de droite y=ax+b passant par les points (x1,y1) (x2,y2)
procedure droite(x1,y1,x2,y2: integer;var a,b: double);
begin
  if x2<>x1 then a:=(y2-y1)/(x2-x1) else a:=99999;
  b:=y1-a*x1;
end;


procedure sauve_fichiers_tco;
var fichier : textfile;
    s : string;
    couleurFonte : Tcolor;
    x,y,i : integer;
begin
  //x:=formconfig.MemoNomTCO.Lines.Count;
  //if x<0 then
  for i:=1 to NbreTCO do
  begin
    AssignFile(fichier,nomfichierTCO[i]);
    rewrite(fichier);
    Writeln(fichier,'/ Définitions TCO version '+version+sousversion);
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
    Writeln(fichier,ModeCouleurCanton_ch+'='+intToSTR(ModeCouleurCanton));
    if avecGrille[i] then s:='1' else s:='0';
    Writeln(fichier,Avecgrille_ch+'='+s);
    writeln(fichier,Graphisme_ch+'=',graphisme);
    writeln(fichier,Ecran_ch+'=',EcranTCO[i]);
    writeln(fichier,Epaisseur_voies_ch+'=',Epaisseur_voies);
    if EvtClicDet then s:='1' else s:='0';
    Writeln(fichier,EvtClicDet_ch+'='+s);

    writeln(fichier,matrice_ch+'='+IntToSTR(NbreCellX[i])+','+intToSTR(NbreCellY[i]));
    writeln(fichier,Ratio_ch+'='+intToSTR(ratioC));
    writeln(fichier,'/ Matrice TCO');
    writeln(fichier,'[Matrice]');
    writeln(fichier,
    '/ couleur fond,adresse,image,inversion aiguillage,Orientation du signal, pied du signal , [texte], representation, fonte, taille fonte, couleur fonte, style, épaisseurs, pont, buttoir ');
    for y:=1 to NbreCellY[i] do
    begin
      s:='';
      for x:=1 to NbreCellX[i] do
      begin
        s:=s+'('+intToHex(tco[i,x,y].CouleurFond,6)+','+inttostr(tco[i,x,y].Adresse)+','+IntToSTR(tco[i,x,y].BImage)+',';

        if tco[i,x,y].inverse then s:=s+'1,' else s:=s+'0,';

        s:=s+IntToSTR(tco[i,x,y].FeuOriente)+','+IntToSTR(tco[i,x,y].PiedFeu)+',';

        // texte
        s:=s+tco[i,x,y].Texte+',';
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
  Epaisseur:=LargeurCell[indexTCO]*epaisseur_voies div 30;   // épaisseur du trait pour PEN
  //Affiche(intToSTR(LargeurCell[indexTCO])+' '+intToSTR(epaisseur),clyellow);
end;

procedure entoure_cell_grille(indexTCO,x,y : integer);
// redessine le carré de grille de la cellule qui a été altéré par la mise à
// jour de la cellule
var Xorg,Yorg : integer;
begin;
  if not(AvecGrille[indexTCO]) then exit;
  Xorg:=(x-1)*LargeurCell[indexTCO];
  Yorg:=(y-1)*HauteurCell[indexTCO];
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
                rayonX,rayonY: Integer; StartDegres, StopDegres: Double);
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
begin
with PImageTCO[indexTCO].Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille[IndexTCO];
    Brush.Color:=clblue;
    //FillRect(r);
    r:=Rect(xminiSel+1,YminiSel+1,XmaxiSel+LargeurCell[indexTCO],yMaxiSel+hauteurCell[indexTCO]);
    Rectangle(r);
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
      jy1:=y0+(HauteurCell[indexTCO] div 2)-round(6*fryGlob[indexTCO]); // pos Y de la bande sup
      jy2:=y0+(HauteurCell[indexTCO] div 2)+round(6*fryGlob[indexTCO]); // pos Y de la bande inf
      if avecGrille[indexTCO] then r:=Rect(x0+1,jy1,xf-1,jy2) else
      r:=Rect(x0,jy1,x0+LargeurCell[indexTCO],jy2) ;
      FillRect(r);
    end;

    case mode of
      0 : couleur:=clVoies[indexTCO];
      1 : couleur:=clAllume[indexTCO];
      2 : couleur:=couleurTrain[TCO[IndexTCO,x,y].train];
    end;
    pen.color:=couleur;
    if testbit(ep,7) or testbit(ep,3) then pen.Width:=epaisseur div 2 else
      pen.Width:=epaisseur;
    moveTo(x0,yc);LineTo(xf,yc);
  end;
end;

// renvoie vrai si l'élément i est un aiguillage ou une TJD/S ou un croisement
function IsAigTCO(i : integer) : boolean;
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
    PCanvasTCO[indexTCO].TextOut((x-1)*larg+5,yl+3,s);
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

procedure affiche_texte(indextco,x,y : integer);
var b,x0,y0,xt,yt,repr,taillefont,tf : integer;
    ss,s,nf : string;
    c : Tcanvas;
begin

  x0:=(x-1)*LargeurCell[indexTCO];
  y0:=(y-1)*hauteurCell[indexTCO];
  //PCanvasTCO.Brush.Style:=bsSolid;
  s:=tco[indextco,x,y].Texte;
//  if s='' then exit;

  c:=PcanvasTCO[indextco];

  b:=tco[indextco,x,y].BImage;
  if (b=51) then PCanvasTCO[indextco].Brush.Color:=clQuai[indexTCO] else PCanvasTCO[indextco].Brush.Color:=tco[indextco,x,y].CouleurFond;
  c.Font.Color:=tco[indextco,x,y].CoulFonte;
  nf:=tco[indextco,x,y].fonte;
  if nf='' then ss:='Arial';
  c.Font.Name:=nf;

  ss:=tco[indextco,x,y].FontStyle;

  c.Font.Style:=style(ss);

  repr:=tco[indextco,x,y].repr;
  taillefont:=tco[indextco,x,y].TailleFonte;

  xt:=0;yt:=0;

  if taillefont=0 then taillefont:=8;
  tf:=(taillefont*LargeurCell[indexTCO]) div 40;
  c.font.Size:=tf;
  if b=id_action then c.Brush.Color:=ClGray;
  //affiche(intToSTR(taillefont*LargeurCell[indexTCO] div 40),clyellow);
  // champ texte
  //Affiche(nf+' '+intToSTR(tf)+' '+s,clred);
  case repr of
   0,1 : yt:=(hauteurCell[indexTCO] div 2)-round(tailleFont*fryGlob[indexTCO]);   // au milieu
     2 : yt:=1;  // haut
     3 : yt:=hauteurCell[indexTCO]-round(2*TailleFont*fryGlob[indexTCO]);   // bas
     5 : begin  // double centré XY
           xt:=(largeurCell[indexTCO] div 2)-(round(length(s)*(taillefont)*frxGlob[indexTCO]) div 2);
           yt:=(hauteurCell[indexTCO] div 2)-round(tailleFont*fryGlob[indexTCO]);   // texte centré
         end;
  end;

  if b=Id_Quai then xt:=6;
  if (b<>Id_Quai) and (b<>Id_action) then s:=s+'   ';

  if repr=4 then texte_reparti(s,indextco,x,y,tf) else
    c.Textout(x0+xt,y0+yt,s);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
      pen.width:=1;
      Polygon([point(x0+1,y0+hauteurCell[indexTCO]-epaisseur),Point(xc-(epaisseur div 2),jy1),Point(xc-epaisseur-epaisseur,jy1),Point(x0+1,y0+hauteurCell[indexTCO]-epaisseur-epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jy2:=yc+(Epaisseur div 2);   // pos Y de la bande inf
      r:=rect(x0+1,jy2+1,x0+LargeurCell[indexTCO]-1,jy2+epaisseur);
      FillRect(r);
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
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      pen.width:=1;
      Polygon([
      point(x0+3,yf-epaisseur-5),
      Point(xc+2*epaisseur,yc-epaisseur),
      Point(xc-epaisseur,yc-epaisseur)]);
      //Point(x0+1,y0+hauteurCell[indexTCO]-epaisseur-epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jy2:=yc+(Epaisseur div 2);   // pos Y de la bande inf
      r:=rect(x0+1,jy2+1,x0+LargeurCell[indexTCO]-1,jy2+epaisseur);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      pen.width:=1;
      Polygon([point(xc+epaisseur-4,yc+epaisseur-1),point(xc+2*epaisseur-1,yc-epaisseur),point(xc+3*epaisseur,yc-epaisseur),point(xc+2*epaisseur,yc+epaisseur-1)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
      r:=rect(x0+1,jy1,x0+LargeurCell[indexTCO]-1,jy1-epaisseur);
      FillRect(r);
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
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
      r:=rect(x0+1,jy1,x0+LargeurCell[indexTCO]-1,jy1-epaisseur);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc+round(0.3*epaisseur);y1:=yc-(epaisseur div 2)-1;
      x2:=x1+epaisseur;y2:=y1;
      x3:=x2+epaisseur;y3:=y2+epaisseur;
      x4:=x1+epaisseur;y4:=y3;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-12;y1:=yc-(epaisseur div 2)-1;
      x2:=x1+15;y2:=y1;
      x3:=x2+6;y3:=y2+8;
      x4:=x1+12;y4:=y3;
      Polygon([point(xc-round(2.1*epaisseur),yc-epaisseur-1),point(xc,yc-epaisseur-1),point(xc+3*epaisseur,yc+epaisseur),point(xc+round(2.0*epaisseur),yc+epaisseur)]);
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.width:=1;
      x1:=xc-(epaisseur div 2);y1:=yc+(epaisseur div 2);
      x2:=x1-epaisseur;y2:=y1;
      x3:=x2-epaisseur;y3:=y2-epaisseur-1;
      x4:=x3+epaisseur;y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.Width:=1;
      // efface le morceau
      x1:=xc-(epaisseur div 2)-10;y1:=yc-(epaisseur div 2);
      x2:=x1+20;y2:=y1-epaisseur;
      pen.color:=fond;
      Brush.Color:=fond;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
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
     // effacement du morceau
      pen.width:=1;
      x1:=xc+2*epaisseur;y1:=yc+(epaisseur div 2);
      x2:=x1-3*epaisseur;y2:=y1;
      x3:=x2;y3:=y2-epaisseur-2;
      x4:=x3+epaisseur;y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3)]);
    end;

    if position=const_droit then
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
     // if avecGrille then r:=Rect(x0+1,jy1,x0+LargeurCell[indexTCO]-1,jy2) else
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
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if (position=const_Devie) or (position=const_inconnu) then
    begin
      trajet_devie;    // affiche la position de la branche déviée
    end;

    if (position=const_droit) or (position=const_inconnu) then
    begin
      trajet_droit;
    end;

    if (position=const_Devie) then
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
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.width:=1;
      x1:=xc-2*epaisseur;y1:=yc-(epaisseur);
      x2:=xc+2*epaisseur;y2:=yc+2;
      x3:=x2;y3:=yc+(epaisseur div 2)+epaisseur;
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    if position=const_droit then
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

    if (position=const_Devie) or (position=const_inconnu) then
    begin
      trajet_devie;    // affiche la position de la branche déviée
    end;

    if (position=const_droit) or (position=const_inconnu) then
    begin
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-2*epaisseur-5;y1:=yc+(epaisseur div 2)+1;
      x2:=xc+epaisseur+10;y2:=y1+epaisseur;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-(epaisseur div 2)+1;y1:=yc-(epaisseur div 2)-1;
      x2:=x1-epaisseur-1;
      x3:=x2-epaisseur;y3:=yc+(epaisseur div 2)+1;
      x4:=x1-epaisseur-1;
      polygon([point(x1,y1),point(x2,y1),point(x3,y3),point(x4,y3)]);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc+(epaisseur)+3;y1:=yc-(epaisseur);
      x2:=xc+2*epaisseur+3;y2:=y1;
      x3:=xc;y3:=yc+epaisseur;
      x4:=xc-(3*epaisseur);y4:=y3;
      polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.width:=1;
      x1:=xc-2*epaisseur-5;y1:=yc-(epaisseur div 2);
      x2:=x1+3*epaisseur;y2:=y1-epaisseur;
      pen.color:=fond;
      Brush.Color:=fond;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
    end;

    if position=const_droit then
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
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-epaisseur;y1:=yc-(epaisseur div 2)-1;
      x2:=xc+epaisseur+10;y2:=yc-epaisseur-3;
      polygon([point(x1,y1),point(x2,y1),point(x2,y2),point(x1,y2)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      x1:=xc+(epaisseur div 2);y1:=yc+(epaisseur div 2);
      x2:=x1+epaisseur-1;y2:=yc-(epaisseur div 2);
      x3:=x1+10;
      polygon([point(x1,y1),point(x2,y2),point(x3,y2),point(x3,y1)]);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-epaisseur;y1:=yc-(epaisseur div 2)-1;
      x2:=xc+epaisseur+10;y2:=y1;
      x3:=xc-epaisseur-5;y3:=yc+epaisseur;
      x4:=xc-2*epaisseur;y4:=y3;
      polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;

    if position=const_droit then
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
      jx1:=x0+(LargeurCell[indexTCO] div 2)-round(6*frxGlob[indexTCO]); // pos Y de la bande sup
      jx2:=x0+(LargeurCell[indexTCO] div 2)+round(6*frxGlob[indexTCO]); // pos Y de la bande inf
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
var yp,x1,x2,y1,y2,x3,y3,x4,y4,x0,y0,xc,yc,xf,yf,trajet,ep,pont : integer;
    a1,b1,a2,b2 : double;
    md : tequipement;
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

  procedure TjdHaut;
  begin
    x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
    x2:=xf+(LargeurCell[indexTCO] div 3)+3;y2:=yc;
    x3:=x0;y3:=yc;
    x4:=xf;y4:=y0;

    with canvas do
    begin
      if testbit(ep,2) or testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure TjdBas;
  begin
    x1:=xf-x0;
    x1:=x0-(x1 div 3);y1:=yc;
    x2:=xf+xf-x1;y2:=yf+hauteurCell[indexTCO]*2+(hauteurCell[indexTCO] div 2);
    x3:=xf;y3:=yc;
    x4:=x0;y4:=yf;

    with canvas do
    begin
      if testbit(ep,6) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
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

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=clvoies[indexTCO];
    pen.color:=clvoies[indexTCO];

    horizontale;
    diagonale;
    md:=aiguillage[index_aig(tco[indextco,x,y].Adresse)].modele;
    if (md=tjd) or (md=tjs) then
    begin
      tjdbas;
      tjdhaut;
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
        tjdbas;
      end;
      if trajet=4 then // -/  O C NE
      begin
        {if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(x0,yc);LineTo(xc,yc);
        if testbit(ep,2) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,y0);}
        tjdhaut;
      end;
    end;
  end;
end;

// Element 22
procedure dessin_22(indexTCO : integer;Canvas : Tcanvas;x,y,mode : integer);
var pont,yp,x1,y1,x2,y2,x3,y3,x4,y4,x0,y0,xc,yc,xf,yf,trajet,ep : integer;
    md : tequipement;
    a1,b1,a2,b2 : double;
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

  procedure TJDbas;
  begin
    x1:=x0-LargeurCell[indexTCO]-(LargeurCell[indexTCO] div 3);y1:=yc;
    x2:=xf+(LargeurCell[indexTCO] div 3);y2:=yf+2*hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 2);
    x3:=xf;y3:=yf;
    x4:=x0;y4:=yc;
    ep:=tco[indextco,x,y].epaisseurs;
    with canvas do
    begin
      if testbit(ep,7) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure TJDHaut;
  begin
    x1:=x0-(LargeurCell[indexTCO] div 3);y1:=y0-2*hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 2);
    x2:=xf+LargeurCell[indexTCO]+(LargeurCell[indexTCO] div 3);y2:=yc;
    x3:=x0;y3:=y0;
    x4:=xf;y4:=yc;
    with canvas do
    begin
      if testbit(ep,0) or testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
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
    md:=aiguillage[index_aig(tco[indextco,x,y].Adresse)].modele;
    if (md=tjd) or (md=tjs) then
    begin
      TJDbas;
      TJDHaut;
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
       { if testbit(ep,0) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(x0,y0);LineTo(xc,yc);
        if testbit(ep,3) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,yc);}
        tjdhaut;
      end;
      if trajet=4 then // O C SE  -\
      begin
       { if testbit(ep,7) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(x0,yc);LineTo(xc,yc);
        if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,yf); }
        tjdbas;
      end;
    end;
  end;
end;

// Element 51 (quai)
procedure dessin_51(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
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
procedure dessin_52(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xf,yf,act : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell[indexTCO]+2;
  y0:=(y-1)*hauteurCell[indexTCO]+2;
  xf:=x0+LargeurCell[indexTCO]-4;
  yf:=y0+HauteurCell[indexTCO]-4;

  with canvas do
  begin
    Pen.Width:=1;

    Brush.Color:=clGray;
    pen.color:=clwhite;

    r:=rect(x0,y0,xf,yf);
    rectangle(r);

    if TCOActive then
    begin
      s:=tco[indexTCO,x,y].Fonte;
      if s='' then tco[indexTCO,x,y].Fonte:='Arial';
      //s:=tco[indexTCO,x,y].texte;
      s:='';
      if s='' then tco[indexTCO,x,y].repr:=5; // centré en X et Y
      act:=tco[indexTCO,x,y].PiedFeu;
      if act=1 then
      begin
        if s='' then s:='TCO'+intToSTR(tco[indexTCO,x,y].FeuOriente);  // feuoriente contient le numéro du TCO
        tco[indexTCO,x,y].texte:=s;
        tco[indexTCO,x,y].TailleFonte:=8;
        tco[indexTCO,x,y].FontStyle:='G';
      end;
      if act=2 then
      begin
        if s='' then s:='SC';
          tco[indexTCO,x,y].texte:=s;
          tco[indexTCO,x,y].TailleFonte:=8;
          tco[indexTCO,x,y].FontStyle:='G';
      end;
      if act=3 then
      begin
        if s='' then s:='CDM';
        tco[indexTCO,x,y].texte:=s;
        tco[indexTCO,x,y].TailleFonte:=8;
        tco[indexTCO,x,y].FontStyle:='G';
      end;
      if act=4 then
      begin
        if s='' then s:=intToSTR(tco[indexTCO,x,y].adresse);
        tco[indexTCO,x,y].texte:=s;
        tco[indexTCO,x,y].TailleFonte:=8;
        tco[indexTCO,x,y].FontStyle:='G';
      end;


      //tf:=(tco[indexTCO,x,y].TailleFonte*LargeurCell[indexTCO]) div 40;
      //tf:=(8*LargeurCell[indexTCO]) div 40;;

      //Font.Color:=clwhite;
      //font.Name:='Arial';
      //texte_reparti(s,indexTCO,x,y,tf);
      affiche_texte(indextco,x,y);
    end;

  end;
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jy1:=yc - Epaisseur-1;
      jx1:=xc-(Epaisseur div 2);
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1+epaisseur),Point(jx1+epaisseur,jy1-epaisseur),Point(jx1,jy1-epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc-(Epaisseur div 2);   // pos Y de la bande inf
      r:=rect(jx1,yc-10,jx1-Epaisseur,yc+10);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jx1:=xc-(Epaisseur div 2); jy1:=yc - Epaisseur+5;
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1+epaisseur+10),Point(jx1+epaisseur,jy1-epaisseur),Point(jx1,jy1-epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc-(Epaisseur div 2);   // pos Y de la bande inf
      r:=rect(jx1,yc-15,jx1-Epaisseur,yf);
      FillRect(r);
    end;
  end;
end;

// Element 23  croisement
procedure dessin_23(indexTCO : integer;Canvas : Tcanvas;x,y,mode: integer);
var x1,x2,y1,y2,xp,x0,y0,x3,y3,x4,y4,xf,yf,xc,yc,trajet,ep,pont : integer;
    a1,b1,a2,b2 : double;
    md : tEquipement;
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

  procedure tjd_d;
  begin
    x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
    x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
    x3:=xf;y3:=y0;
    x4:=xc;y4:=yf;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if testbit(ep,2) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure tjd_G;
  begin
    x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
    x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+round(hauteurCell[indexTCO] / 2.5);
    x3:=x0;y3:=yf;
    x4:=xc;y4:=y0;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if testbit(ep,1) or testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
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
      tjd_G;
      tjd_D;
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
        tjd_d;
      end;
      if trajet=4 then // N C SO
      begin
        {if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(xc,y0);LineTo(xc,yc);
        if testbit(ep,6) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(x0,yf);}
        tjd_g;
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
var xp,x0,y0,x3,y3,x4,y4,xf,yf,xc,yc,trajet,ep,pont,x1,x2,y1,y2 : integer;
    a1,b1,a2,b2 : double;
    md : tEquipement;
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

  procedure tjd_g;
  begin
    x1:=x0-(2*LargeurCell[indexTCO])-(LargeurCell[indexTCO] div 2);y1:=y0-(hauteurCell[indexTCO] div 3);
    x2:=x0+(LargeurCell[indexTCO] div 2);y2:=yf+hauteurCell[indexTCO]+(hauteurCell[indexTCO] div 3);
    x3:=xc;y3:=yf;
    x4:=x0;y4:=y0;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if testbit(ep,0) or testbit(ep,5) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
  end;

  procedure tjd_d;
  begin
    x1:=x0+(LargeurCell[indexTCO] div 2);y1:=y0-hauteurCell[indexTCO]-(hauteurCell[indexTCO] div 3);
    x2:=xf+(2*LargeurCell[indexTCO])+(LargeurCell[indexTCO] div 2);y2:=yf+round(hauteurCell[indexTCO] / 3);
    x3:=xc;y3:=y0;
    x4:=xf;y4:=yf;
    ep:=tco[indextco,x,y].epaisseurs;

    with canvas do
    begin
      if testbit(ep,1) or testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
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
      tjd_g;
      tjd_d;
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
        tjd_g;
      end;
      if trajet=4 then
      begin
        {if testbit(ep,1) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        moveto(xc,y0);LineTo(xc,yc);
        if testbit(ep,4) then pen.Width:=epaisseur div 2 else pen.Width:=epaisseur;
        lineTo(xf,yf);}
        tjd_d;
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jy1:=yc - 2*Epaisseur-1;
      jx1:=xc- (Epaisseur div 2);
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1),Point(jx1+epaisseur,jy1+epaisseur),Point(jx1,jy1+2*epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc+(Epaisseur div 2)+1;
      r:=rect(jx1,yc-15,jx1+Epaisseur,yc+10);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jx1:=xc-(Epaisseur div 2); jy1:=yc - Epaisseur-5;
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx1+epaisseur,jy1),Point(jx1+epaisseur,jy1+epaisseur),Point(jx1,jy1+4*epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc+(Epaisseur div 2);
      r:=rect(jx1+1,yc-15,jx1+Epaisseur,yf);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jx1:=xc-(Epaisseur div 2); jy1:=yc + Epaisseur+2;
      jx2:=jx1+epaisseur;jy2:=jy1-epaisseur;
      jx3:=jx2;jy3:=yc+2*epaisseur;
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc-(Epaisseur div 2);
      r:=rect(jx1,yc-3*epaisseur,jx1-Epaisseur,yf);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jx1:=xc-(Epaisseur div 2); jy1:=yc + Epaisseur;
      jx2:=jx1+epaisseur;jy2:=jy1-3*epaisseur;
      jx3:=jx2;jy3:=yc+2*epaisseur;
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc-(Epaisseur div 2);
      r:=rect(jx1,yc-3*epaisseur,jx1-Epaisseur,yf);
      FillRect(r);
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
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if (position=const_Devie) or (position=const_inconnu) then
    begin
      trajet_devie;    // affiche la position de la branche déviée
    end;

    if (position=const_droit) or (position=const_inconnu) then
    begin
      trajet_droit;
    end;

    if (position=const_Devie) then
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
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc+(Epaisseur div 2)+1;
      r:=rect(jx1,yc-3*epaisseur,jx1+Epaisseur,yf);
      FillRect(r);
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      jx1:=xc-(Epaisseur div 2); jy1:=yc - (2*Epaisseur );
      jx2:=jx1+epaisseur;jy2:=yc+epaisseur;
      jx3:=jx2;jy3:=yc+2*epaisseur;
      pen.width:=1;
      Polygon([point(jx1,jy1),Point(jx2,jy2),Point(jx3,jy3),Point(jx1,jy3)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jx1:=xc+(Epaisseur div 2);
      r:=rect(jx1,yc-3*epaisseur,jx1+Epaisseur,yf);
      FillRect(r);
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
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if (position=const_Devie) or (position=const_inconnu) then
    begin
      trajet_devie;    // affiche la position de la branche déviée
    end;

    if (position=const_droit) or (position=const_inconnu) then
    begin
      trajet_droit;
    end;

    if (position=const_Devie) then
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
    end;

    if position=const_droit then
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
      // effacement du morceau
      pen.width:=1;
      x1:=xc-round(epaisseur*1);y1:=yc-round(2.2*epaisseur);
      x2:=xc+round(epaisseur*0.7);y2:=y1;
      x3:=x2-round(epaisseur*0.2);y3:=yc+round(1.8*epaisseur);
      x4:=x1;y4:=yc-round(1.5*epaisseur);
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-2*epaisseur-5;y1:=yc+(epaisseur div 2)+1;
      x2:=xc+epaisseur+10;y2:=y1+epaisseur;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-(epaisseur div 2)+1;y1:=yc-(epaisseur div 2)-1;
      x2:=x1-epaisseur-1;
      x3:=x2-epaisseur;y3:=yc+(epaisseur div 2)+1;
      x4:=x1-epaisseur-1;
      polygon([point(x1,y1),point(x2,y1),point(x3,y3),point(x4,y3)]);
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
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc-round(0.7*epaisseur);y1:=yc-round(1.6*epaisseur);
      x2:=xc+round(0.9*epaisseur);y2:=y1;
      x3:=xc-round(0.3*epaisseur);y3:=yc+round(1.4*epaisseur);
      x4:=xc-round(0.7*epaisseur);y4:=y3;
      polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.width:=1;
      x1:=xc-2*epaisseur;y1:=yc-(3*epaisseur);
      x2:=xc-(epaisseur div 2);y2:=yc+epaisseur;
      pen.color:=fond;
      Brush.Color:=fond;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
    end;

    if position=const_droit then
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
    end;

    if position=const_droit then
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
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies[indexTCO];
    Pen.Color:=clVoies[indexTCO];
    Pen.Mode:=pmCopy;

    if (position=const_Devie) or (position=const_inconnu) then
    begin
      trajet_devie;    // affiche la position de la branche déviée
    end;

    if (position=const_droit) or (position=const_inconnu) then
    begin
      trajet_droit;
    end;

    if (position=const_Devie) then
    begin
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc+round(0.5*epaisseur);y1:=yc-round(3*epaisseur);
      x2:=xc+round(1.5*epaisseur);y2:=yc+epaisseur;
      polygon([point(x1,y1),point(x2,y1),point(x2,y2),point(x1,y2)]);
    end;

    if position=const_droit then
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
     // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.width:=1;
      x1:=xc+round(0.1*epaisseur);y1:=yc-round(1*epaisseur);
      x2:=xc+round(2*epaisseur);y2:=y1;
      x3:=xc-round(0.5*epaisseur);y3:=yc+round(3*epaisseur);
      x4:=xc-round(2*epaisseur);y4:=y3;
      polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;

    if position=const_droit then
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
    end;
  end;
end;

procedure dessin_34(indexTCO : integer;Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_34L(indexTco,Canvas,x,y,Mode);
  if graphisme=2 then dessin_34C(indexTco,Canvas,x,y,Mode);
end;

// calcul des facteurs de réductions X et Y pour l'adapter à l'image de destination
procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY : integer);
begin
  //frX:=DimDestX/DimOrgX;
  //frY:=DimDestY/DimOrgY;
  frx:=DimDestX/ZoomMax;
  fry:=DimDestY/ZoomMax;
  //Affiche(formatfloat('0.000000',frY),clyellow);
end;

procedure Feu_180(index : integer;ImageSource : TImage;x,y : integer;FrX,FrY : real;inverse : boolean);
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
procedure Feu_90G(index : integer;ImageSource : TImage;x,y : integer;FrX,FrY : real;inverse : boolean);
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
  //PimageTemp.Visible:=true;
  // copie l'image du signal retournée depuis image temporaire vers tco avec une réduction en mode transparennt
  TransparentBlt(PcanvasTCO[index].Handle,x,y,round(TailleY*FrY),round(TailleX*FrX),   // destination
                 PImageTemp[index].Canvas.Handle,0,0,TailleY,TailleX,clBlue);    // source - clblue est la couleur de transparence
  PImageTCO[index].Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

// copie de l'image du signal à 90° dans le canvas source et le tourne de 90° et le met dans l'image temporaire
procedure Feu_90D(index : integer;ImageSource : TImage;x,y : integer ; FrX,FrY : real;inverse : boolean);
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

procedure affiche_pied7_180(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1-63)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+40)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied9_180(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1-63)*frX),y+round(y1*frY) ) else
                   LineTo( x+round((x1+40)*frX),y+round(y1*frY) );
  end;
end;

procedure affiche_pied20_90G(index,x,y : integer;FrX,frY : real;pied : integer;contrevoie : boolean);
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
      if pied=1 then LineTo( x+round(x1*frX),y+round((y1+40)*frY) ) else     // a gauche
                     LineTo( x+round(x1*frX),y+round((y1-65)*frY) );         // a droite
    end
    else
    begin
      x1:=0;y1:=14;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      x1:=x1-6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if pied=1 then LineTo( x+round(x1*frX),y+round((y1+60)*frY) ) else
                     LineTo( x+round(x1*frX),y+round((y1-45)*frY) );
    end;
  end;
end;

procedure affiche_pied20_90D(index,x,y : integer;FrX,frY : real;pied : integer;contrevoie : boolean);
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
      if pied=1 then LineTo( x+round(x1*frX),y+round((y1+65)*frY) ) else     // a gauche
                     LineTo( x+round(x1*frX),y+round((y1-40)*frY) );         // a droite
    end
    else
    begin
      x1:=65;y1:=10;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      x1:=x1+6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if pied=1 then LineTo( x+round(x1*frX),y+round((y1-57)*frY) ) else
                     LineTo( x+round(x1*frX),y+round((y1+45)*frY) );
    end;
  end;
end;

procedure affiche_pied20_180(index,x,y : integer;FrX,frY : real;pied : integer;contrevoie : boolean);
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
      if pied=1 then LineTo( x+round((x1-50)*frX),y+round(y1*frY) ) else     // a gauche
                     LineTo( x+round((x1+55)*frX),y+round(y1*frY) );         // a droite
    end
    else
    begin
      x1:=38;y1:=0;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      y1:=y1-6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if pied=1 then LineTo( x+round((x1-63)*frX),y+round(y1*frY) ) else
                     LineTo( x+round((x1+40)*frX),y+round(y1*frY) );
    end;
  end;
end;

procedure affiche_pied20_vertical(index,x,y : integer;FrX,frY : real;pied : integer;contrevoie : boolean);
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
      if pied=1 then LineTo( x+round((x1+40)*frX),y+round(y1*frY) ) else
                     LineTo( x+round((x1-65)*frX),y+round(y1*frY) );
    end
    else
    begin
      x1:=18;y1:=102;
      moveTo( x+round(x1*frX),y+round(y1*frY) );
      y1:=y1+6;
      LineTo( x+round(x1*frX),y+round(y1*frY) );
      if pied=1 then LineTo( x+round((x1+62)*frX),y+round(y1*frY) ) else
                     LineTo( x+round((x1-40)*frX),y+round(y1*frY) );
    end;
  end;
end;


procedure affiche_pied2G_90G(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-50)*frYR) );
  end;
end;

procedure affiche_pied2G_90D(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) ) ;
  end;
end;

procedure affiche_pied_Vertical2G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=35;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) );
  end;
end;

procedure affiche_pied3G_90D(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied3G_90G(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1-4)*frX),y+round((y1+50)*frYR) ) else
                   LineTo( x+round((x1-4)*frX),y+round((y1-50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical3G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=42;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) )
             else  LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) ) ;
  end;
end;

procedure affiche_pied4G_90G(index,x,y : integer;FrX,frY : real;piedFeu : integer);
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
    if piedFeu=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*frYR) ) ;
  end;
end;

procedure affiche_pied4G_90D(index,x,y : integer;FrX,frY : real;piedfeu: integer);
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
    if piedFeu=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) )
                 else LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical4G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=55;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied9G_90D(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fryR)) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+40)*fryR));
  end;
end;

procedure affiche_pied5G_90D(index,x,y : integer;FrX,frY : real;piedFeu : integer);
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
    if piedFeu=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                      LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied5G_90G(index,x,y : integer;FrX,frY : real;piedFeu : integer);
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
    if piedFeu=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical5G(index,x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO[index] do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal[index];
    x1:=12;y1:=65;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );

    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied7G_90D(index,x,y : integer;FrX,frY : real;pied : integer);
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
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fryR) ) else
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

procedure affiche_pied9G_90G(index,x,y : integer;FrX,frY : real;pied : integer);
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

    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+58)*frYR) ) else
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
    // si la cellule au dessus contient un feu vertical, ne pas effacer la cellule
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
     frX,frY : real;
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
  PiedFeu:=tco[indextco,x,y].PiedFeu;  // gauche ou droite de la voie

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

  // affichage du feu et du pieds - orientation 90°G
  if Orientation=2 then
  begin
    Feu_90G(indexTCO,ImageFeu,x0,y0,frX,frY,contrevoie); // ici on passe l'origine du signal
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
    Feu_90D(indexTCO,ImageFeu,x0,y0,frX,frY,contrevoie);
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
    Feu_180(indexTCO,ImageFeu,x0,y0,frX,frY,contrevoie);
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
   Id_Quai   : dessin_51(indexTCO,PCanvasTCO,X,Y,mode);
   Id_action : dessin_52(indexTCO,PCanvasTCO,X,Y,mode);

   end;
end;


// affiche la cellule x et y en cases
// index est utilisé pour accéder au tableau du tracé de la fonction zone_tco
procedure affiche_cellule(indexTCO,x,y : integer);
var i,index,repr,Xorg,Yorg,xt,yt,mode,adresse,Bimage,aspect,oriente,pied,AdrTr : integer;
    typ : tequipement;
    inverse : boolean;
    s : string;
begin
  if tco[indextco,x,y].BImage=0 then exit;
  //Affiche('Affiche_cellule',clLime);
  PcanvasTCO[indexTCO].pen.Mode:=PmCopy;
  //pcanvasTCO.Brush.Style:=BsClear;
  adresse:=tco[indextco,x,y].Adresse;
  BImage:=tco[indextco,x,y].BImage;
  mode:=tco[indextco,x,y].mode; // mode pour la couleur
  repr:=tco[indextco,x,y].repr;

  Xorg:=(x-1)*LargeurCell[indexTCO];
  Yorg:=(y-1)*hauteurCell[indexTCO];

  // ------------- affichage de l'adresse ------------------
  s:=IntToSTR(adresse);
  // affiche d'abord l'icone de la cellule et colore la voie si zone ou détecteur actionnée selon valeur mode
  dessine_icone(indexTCO,PCanvasTCO[indexTCO],Bimage,X,Y,mode);

  PCanvasTCO[indexTCO].font.Size:=(LargeurCell[indexTCO] div 10)+4  ;
  //Affiche(intToSTR( (LargeurCell[indexTCO] div 30)+6),clyellow);

  // affiche le texte des aiguillages
  if IsAigTCO(Bimage) and (adresse<>0) then
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
        Brush.Color:=tco[indextco,x,y].CouleurFond;
        //SetBkMode(PCanvasTCO[indexTCO].Handle,TRANSPARENT);
        if avecRESA or roulage then s:=s+'  '; // efface l'adresse de réservation
      end
      else
      begin
        // couleur de fond de la réservation
        Brush.style:=bsSolid;
        Brush.Color:=clBlue;
        s:=s+intToSTR(AdrTr);
        //SetBkMode(PCanvasTCO[indexTCO].Handle,OPAQUE);
      end;

      //Brush.Style:=Bsclear;
      Font.Color:=tco[indextco,x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[indextco,x,y].FontStyle);
      xt:=0;yt:=0;
      if Bimage=2  then begin xt:=LargeurCell[indexTCO] div 2;yt:=1;end;
      if Bimage=3  then begin xt:=3;yt:=hauteurCell[indexTCO]-round(20*fryGlob[indexTCO]);end;
      if Bimage=4  then begin xt:=3;yt:=1;end;
      if Bimage=5  then begin xt:=3;yt:=hauteurCell[indexTCO]-round(20*fryGlob[indexTCO]);end;
      if Bimage=12 then begin xt:=1;yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
      if Bimage=13 then begin xt:=LargeurCell[indexTCO]-round(30*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
      if Bimage=14 then begin xt:=LargeurCell[indexTCO]-round(30*frxGlob[indexTCO]);yt:=1;end;
      if Bimage=15 then begin xt:=3;yt:=1;end;
      if Bimage=21 then begin xt:=(LargeurCell[indexTCO] div 2)+round(2*frxGlob[indexTCO]);yt:=round(40*fryGlob[indexTCO]);end;
      if Bimage=22 then begin xt:=(LargeurCell[indexTCO] div 2);yt:=-2;end;
      if Bimage=23 then begin xt:=round(33*frxGlob[indexTCO]);yt:=round(35*fryGlob[indexTCO]);end;
      if Bimage=24 then begin xt:=LargeurCell[indexTCO]-round(20*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
      if Bimage=25 then begin xt:=round(34*frxGlob[indexTCO]);yt:=round(8*fryGlob[indexTCO]);end;
      if Bimage=26 then begin xt:=1;yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
      if Bimage=27 then begin xt:=1;yt:=1;end;
      if Bimage=28 then begin xt:=1;yt:=1;end;
      if Bimage=29 then begin xt:=LargeurCell[indexTCO] div 2;yt:=1;end;
      if Bimage=32 then begin xt:=1;yt:=1;end;
      if Bimage=33 then begin xt:=1;yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
      if Bimage=34 then begin xt:=LargeurCell[indexTCO]-round(30*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
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
      Brush.Color:=tco[indextco,x,y].CouleurFond;
      Font.Color:=tco[indextco,x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[indextco,x,y].FontStyle);
      xt:=round(15*frxGlob[indexTCO]);
      case repr of
      1 : yt:=(hauteurCell[indexTCO] div 2)-round(7*fryGlob[indexTCO]);   // milieu
      2 : yt:=1;  // haut
      3 : yt:=hauteurCell[indexTCO]-round(17*fryGlob[indexTCO]);   // bas
      end;

{      // affiche/efface le nom du train du détecteur
      s:=s+'        ';
      case repr of
            1,3 : yt:=1;  // haut
            2 : yt:=hauteurCell[indexTCO]-round(17*fryGlob[indexTCO]);   // bas
      end;  }

      i:=detecteur[adresse].AdrTrain;
      if i<>0 then
      begin
        i:=index_train_adresse(i);
        if i<>0 then s:=s+' '+trains[i].nom_train;
      end;
      //PCanvasTCO[indexTCO].font.Size:=(LargeurCell[indexTCO] div 13)+4  ;
      TextOut(xOrg+xt,Yorg+yt,s+' ');
    end;
  end;

  // autres détecteurs
  if ((Bimage=7) or (Bimage=8) or (Bimage=9) or (Bimage=10) or (Bimage=17)  or (Bimage=20)) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO[indexTCO] do
    begin
      Brush.Color:=tco[indextco,x,y].CouleurFond;
      Font.Name:='Arial';
      Font.Style:=style(tco[indextco,x,y].FontStyle);
      Font.Color:=tco[indextco,x,y].coulFonte;
      TextOut(xOrg+round(2*frxGlob[indexTCO]),yOrg+round(2*fryGlob[indexTCO]),s);
    end;
  end;

  // autres détecteurs
  if (Bimage=18) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO[indexTCO] do
    begin
      Brush.Color:=tco[indextco,x,y].CouleurFond;
      Font.Name:='Arial';
      Font.Style:=style(tco[indextco,x,y].FontStyle);
      Font.Color:=tco[indextco,x,y].coulFonte;
      TextOut(xOrg+round(20*frxGlob[indexTCO]),yOrg+hauteurCell[indexTCO]-round(14*fryGlob[indexTCO]),s);
    end;
  end;

  // autres détecteurs
  if ((Bimage=6) or (Bimage=11) or (Bimage=16)) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO[indexTCO] do
    begin
      Brush.Color:=tco[indextco,x,y].CouleurFond;
      Font.Color:=tco[indextco,x,y].coulFonte;;
      Font.Style:=style(tco[indextco,x,y].FontStyle);
      Font.Name:='Arial';
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
    pied:=tco[indextco,x,y].PiedFeu;
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
        if inverse then begin xt:=LargeurCell[indexTCO]+round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(16*fryGlob[indexTCO]);end
        else begin xt:=LargeurCell[indexTCO]+round(10*frxGlob[indexTCO]);yt:=round(1*fryGlob[indexTCO]);end;
      end;
      if (oriente=4) then
      begin
        if inverse then begin xt:=LargeurCell[indexTCO]+round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(16*fryGlob[indexTCO]);end
        else begin xt:=round(2*frxGlob[indexTCO]);yt:=round(1*fryGlob[indexTCO]);end;
      end;
    end;
    if (aspect=9) and (Oriente=1) then begin xt:=LargeurCell[indexTCO]-round(25*frxGlob[indexTCO]);yt:=round(60*fryGlob[indexTCO]);end;
    if (aspect=9) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(17*fryGlob[indexTCO]);end;    // orientation G
    if (aspect=9) and (Oriente=3) then begin xt:=LargeurCell[indexTCO]+round(25*frxGlob[indexTCO]);yt:=1;end;
    if (aspect=9) and (Oriente=4) and (pied=1) then begin xt:=round(2*frxGlob[indexTCO]);yt:=round(10*frYGlob[indexTCO]);end;
    if (aspect=9) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;

    if (aspect=7) and (Oriente=1) then begin xt:=LargeurCell[indexTCO]-round(25*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO];end;
    if (aspect=7) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO]-round(15*fryGlob[indexTCO]);end;
    if (aspect=7) and (Oriente=3) then begin xt:=LargeurCell[indexTCO]+2;yt:=1;end;
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
    if (aspect=3) and (Oriente=3) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO];end;
    if (aspect=3) and (Oriente=4) and (pied=1) then begin xt:=round(35*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;
    if (aspect=3) and (Oriente=4) and (pied=2) then begin xt:=round(3*frxGlob[indexTCO]);yt:=round(1*frYGlob[indexTCO]);end;


    if (aspect=2) and (Oriente=1) and (pied=2) then begin xt:=round(-15*frxGlob[indexTCO]);yt:=1;end;  // signal à droite
    if (aspect=2) and (Oriente=1) and (pied=1) then begin xt:=round(45*frxGlob[indexTCO]);yt:=1;end;  // signal à gauche
    if (aspect=2) and (Oriente=2) then begin xt:=round(10*frxGlob[indexTCO]);yt:=hauteurCell[indexTCO];end;  // orientation G
    if (aspect=2) and (Oriente=3) then begin xt:=round(20*frxGlob[indexTCO]);yt:=round(40*fryGlob[indexTCO]);end;  // orientation D
    if (aspect=2) and (Oriente=4) then begin xt:=round(35*frxGlob[indexTCO]);yt:=round(2*fryglob[indexTCO]);end;  // orientation 180

    // signaux directionnels
    if (aspect>10) and (aspect<20) and(oriente=1) then begin xt:=1;yt:=hauteurCell[indexTCO]-round(14*fryGlob[indexTCO]);end;
    if (aspect>10) and (aspect<20) and (oriente=2) then begin xt:=LargeurCell[indexTCO]-round(15*frxGlob[indexTCO]);yt:=0;end;
    if (aspect>10) and (aspect<20) and (oriente=3) then begin xt:=LargeurCell[indexTCO]-round(15*frxGlob[indexTCO]);yt:=0;end;

    with PCanvasTCO[indexTCO] do
    begin
      Brush.Color:=tco[indextco,x,y].CouleurFond;
      Font.Color:=tco[indextco,x,y].coulFonte;
      Font.Style:=style(tco[indextco,x,y].FontStyle);
      Font.Name:='Arial';
      TextOut(xOrg+xt,yOrg+yt,s);
    end;
  end;
end;


procedure Entoure_cell(indexTCO,x,y : integer);
var r : Trect;
    x0,y0 : integer;
begin
  x0:=(x-1)*LargeurCell[indexTCO]+1;
  y0:=(y-1)*hauteurCell[indexTCO]+1;
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
  if not(entoure[indexTCO]) then
  begin
    Entoure_cell(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
    Xentoure[indexTCO]:=XClicCell[indexTCO];
    Yentoure[indexTCO]:=YclicCell[indexTCO];
    entoure[indexTCO]:=true;
  end
  else
  begin
    Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);   // efface l'ancien
    // si on clique sur le même on l'efface sans afficher un nouveau
    if (Xentoure[indexTCO]<>XclicCell[indexTCO]) or (Yentoure[indexTCO]<>YClicCell[indexTCO]) then
    begin
      Entoure_cell(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
    end
    else entoure[indexTCO]:=false;
    Xentoure[indexTCO]:=XClicCell[indexTCO];
    Yentoure[indexTCO]:=YclicCell[indexTCO];
  end;
end;

// affiche le tco suivant le tableau TCO
procedure Affiche_TCO(indexTCO : integer) ;
var x,y,x1,y1,DimX,DimY : integer;
    s : string;
    r : Trect;
begin
  if affevt then affiche('Affiche_tco',clLime);
  if pImageTCO[indexTCO]=nil then exit;
  DimX:=LargeurCell[indexTCO]*NbreCellX[indexTCO];
  DimY:=hauteurCell[indexTCO]*NbreCellY[indexTCO];
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
        brush.Color:=tco[indextco,x,y].CouleurFond;

        r:=rect(x1,y1,x1+LargeurCell[indexTCO],y1+hauteurCell[indexTCO]);
        FillRect(r);
      end;
  end;

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

  //afficher les cellules sauf les signaux
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        if tco[indextco,x,y].BImage<>Id_signal then
        begin
          affiche_cellule(indexTCO,x,y);
        end;
      end;

  //afficher les cellules des signaux et les textes pour que les pieds recouvrent le reste et afficher les textes
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        if tco[indextco,x,y].BImage=Id_signal then
        begin
          affiche_cellule(indexTCO,x,y);
        end;
        //Affiche(intToSTR(indexTCO)+' '+intToSTR(x)+' '+intToSTR(y),clred);
        s:=tco[indextco,x,y].Texte;
        if s<>'' then Affiche_texte(indexTCO,x,y);
      end;

  // afficher les sélections si elles sont présentes
  if entoure[indexTCO] then Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);
  if rect_select.NumTCO<>0 then Affiche_Rectangle(IndexTCO,Rect_select);
  if selectionaffichee[indexTCO] then Affiche_selection(indexTCO);
end;


procedure TFormTCO.FormCreate(Sender: TObject);
var s : string;
begin
  if affevt or (debug=1) then Affiche('FormTCO'+intToSTR(indexTCOCreate)+' create',clyellow);
  offsetSourisY:=-10; // permet de tenir l'icone au milieu quand on fait un glisser
  offsetSourisX:=-10;
  RadioGroupSel.ItemIndex:=0;
  auto_tcurs:=true;
  TCO_modifie:=false;
  rangUndo:=1;
  epaisseur_voies:=5;
  XclicCell[indexTCOCreate]:=1;
  YclicCell[indexTCOCreate]:=1;
  xCoupe:=0;yCoupe:=0;
  indexTrace:=0;
  KeyPreview:=true; // valide les évènements clavier
  TrackBarZoom.Tabstop:=false;     // permet d'avoir les evts curseurs
  ButtonSauveTCO.TabStop:=false;
  ButtonConfigTCO.TabStop:=false;
  Buttonmasquer.TabStop:=false;
  ButtonRaz.TabStop:=false;
  ButtonDessiner.TabStop:=false;
  //TrackBarZoom.position:=78;

  couleurAdresse:=clCyan;
  xMiniSel:=99999;yMiniSel:=99999;
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
  VBm:=TbitMap.Create;          // masque
  Vbm.Width:=100;
  Vbm.Height:=100;
  oldbmp:=Tbitmap.Create;
  oldbmp.width:=100;
  oldbmp.Height:=100;

  modeTrace[indexTCOCreate]:=false;   // pour tracer les voies à la souris
  //controlStyle:=controlStyle+[csOpaque];


  s:='Voie';
  ImagePalette6.Hint:=s;ImagePalette6.ShowHint:=true;
  ImagePalette7.Hint:=s;ImagePalette7.ShowHint:=true;
  ImagePalette8.Hint:=s;ImagePalette8.ShowHint:=true;
  ImagePalette9.Hint:=s;ImagePalette9.ShowHint:=true;
  ImagePalette10.Hint:=s;ImagePalette10.ShowHint:=true;
  ImagePalette11.Hint:=s;ImagePalette11.ShowHint:=true;
  ImagePalette16.Hint:=s;ImagePalette16.ShowHint:=true;
  ImagePalette17.Hint:=s;ImagePalette17.ShowHint:=true;
  ImagePalette18.Hint:=s;ImagePalette18.ShowHint:=true;
  ImagePalette19.Hint:=s;ImagePalette19.ShowHint:=true;

  s:='Voie pouvant porter un détecteur ou buttoir';
  ImagePalette1.Hint:=s;ImagePalette1.ShowHint:=true;
  ImagePalette20.Hint:=s;ImagePalette20.ShowHint:=true;

  s:='Voie ou buttoir';
  ImagePalette10.Hint:=s;ImagePalette10.ShowHint:=true;
  ImagePalette11.Hint:=s;ImagePalette11.ShowHint:=true;

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

  tcoCree:=true;
  if debug=1 then Affiche('Fin création fenêtre TCO',clLime);
end;


// trouve le détecteur det dans le TCO et renvoie x et y
// si on le trouve pas, renvoie x=0,y=0
procedure trouve_det(indexTCO,det : integer;var x,y : integer);
var xc,yc,b : integer;
    trouve : boolean;
begin
  yc:=1;
  repeat
    xc:=0;
    repeat
      inc(xc);
      b:=tco[indextco,xc,yc].Bimage;
      trouve:=(tco[indextco,xc,yc].Adresse=det) and
              ( (b=1) or (b=10) or (b=11) or (b=20) );  // trouvé détecteur- obligé de regarder le type d'objet car un détecteur et un signal peuvent avoir la même adresse!
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

// efface le trajet du tco du train depuis le détecteur jusqu'au premier aiguillage
procedure efface_trajet(det,train : integer);
var i,j,t,n,Bimage,x,y : integer;
    trouve : boolean;
begin
  for t:=1 to NbreTCO do
  begin
    n:=Trace_Train[t].train[train].nombre;
    if n=0 then exit;
    i:=n;
    repeat
      x:=Trace_Train[t].train[train].route[i].x;
      y:=Trace_Train[t].train[train].route[i].y;
      Bimage:=tco[t,x,y].BImage;
      trouve:=isAigTCO(Bimage);
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

// affiche le trajet dans le tco du train,ir =nombre d'éléments du tableau trace_train mode=couleur
procedure affiche_trajet(indexTCO,train,ir,mode : integer);
var i,sx,sy,x,y,ax,ay,Bimage,adresse : integer;
begin
  // et affichage de la route
  for i:=1 to ir do
  begin
    x:=Trace_Train[indexTCO].Train[train].route[i].x;
    y:=Trace_Train[indexTCO].Train[train].route[i].y;

    tco[Indextco,x,y].mode:=mode;  //mode;  // pour la couleur
    TCO[IndexTCO,x,y].train:=index_couleur;  // = numéro du train
    //Affiche(intToSTR(x)+' '+intToSTR(y),clorange);

    bimage:=tco[indextco,x,y].BImage;
    adresse:=tco[indextco,x,y].Adresse;
    tco[indextco,x,y].trajet:=0;

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
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=2;   // de haut droit vers bas gauche
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)   and (sy-y=-1) then tco[indextco,x,y].trajet:=4;   // de gauche vers haut droite
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=4;   // de haut droite vers gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=1)   and (sy-y=0)  then tco[indextco,x,y].trajet:=3;   // de bas gauche vers droite
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=3;   // de gauche vers haut droite
      if tco[indextco,x,y].trajet=0 then affiche('Erreur 70 TCO - Cellule '+intToSTR(x)+','+intToSTR(y),clred);
    end;

    // croisement
    if (bimage=22) and (i>1) then
    begin
      ax:=Trace_Train[indexTCO].Train[train].route[i-1].x;
      ay:=Trace_Train[indexTCO].Train[train].route[i-1].y;
      sx:=Trace_Train[indexTCO].Train[train].route[i+1].x;
      sy:=Trace_Train[indexTCO].Train[train].route[i+1].y;
      tco[indextco,x,y].trajet:=0;
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=1;   // de gauche à droite
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1) and (sy-y=0)  then tco[indextco,x,y].trajet:=1;   // de droite à gauche
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=2;   // de haut gauche vers bas droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1) and (sy-y=-1) then tco[indextco,x,y].trajet:=2;   // de bas droit vers haut gauche
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1) and (sy-y=-1) then tco[indextco,x,y].trajet:=3;   // de droit vers en haut à gauche
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)  and (sy-y=0)  then tco[indextco,x,y].trajet:=3;   // de haut à gauche vers droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1) and (sy-y=0)  then tco[indextco,x,y].trajet:=4;   // de bas à droite vers gauche
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)  and (sy-y=1)  then tco[indextco,x,y].trajet:=4;   // de gauche vers en bas a droite
      if tco[indextco,x,y].trajet=0 then affiche('Erreur 71 TCO - Cellule '+intToSTR(x)+','+intToSTR(y),clred);
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
  end;
end;


// allume ou éteint (mode=0 ou 1) la voie du train "train", zone de det1 à det2 sur le TCO
// si mode=0 : éteint
//        =1 : couleur détecteur allumé
//        =2 : couleur de l'index train
// Ne nécessite pas que les aiguillages aoient bien positionnés entre det1 et det2
// procédure récursive quand on passe par un aiguillage pour explorer les éléments opposés d'ou on vient si on l'aborde en pointe
procedure zone_tco(indexTCO,det1,det2,train,mode: integer);
var i,ir,adresse,Bimage,direction,ancienX,ancienY,x,y,xn,yn,Xdet1,yDet1,iteration,indexIr : integer;
    memtrouve,sortir,casok,indextrouve : boolean;
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
// x, y et ir sont locales pour des récursivités différentes, donc on les passe en paramètre pour transmettre à la
// récursivité suivante leur valeur, mais elles reprennent leur valeurs initiales à la remontée vers la résursivité appellante.
Procedure El_tco(x,y,train : integer; ir : integer);
var mdl : Tequipement;
    i,j  :integer;
    sortir : boolean;
begin
  // répète la route depuis un aiguillage
  inc(iteration);
  if DebugTCO then AfficheDebug('El_TCO',clorange);

  i:=0;
  repeat
    maj_route(indextco,x,y,train,ir);
    adresse:=tco[indextco,x,y].Adresse ;
    Bimage:=tco[indextco,x,y].Bimage;
    if debugTCO then
    begin
      s:='X='+intToSTR(x)+' y='+intToSTR(y)+' Elément='+intToSTR(Bimage);
      if adresse<>0 then s:=s+' Adresse='+intToSTR(adresse);
      AfficheDebug(s,clyellow);
    end;
    casok:=false;
    // vers case suivante: trouver le trajet pour rejoindre det1 à det2

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
          //if debugTCO then AfficheDebug('El 2',clyellow);
          yn:=y;
          if (ancienX<x) and (ancienY=y) then begin xn:=x+1;end;
          if (ancienX<x) and (ancienY>y) then begin xn:=x+1;xn:=x+1;end;
          if (ancienX>x) and (ancienY=Y) then
          begin
            //pris en pointe
            ancienX:=x;
            ancienY:=y;
            x:=x-1;
            el_tco(x,y,train,ir);   // essaye droit
            // essayer dévié
            if not(memtrouve) then
            begin
              AncienY:=y;
              AncienX:=x+1;
              y:=y+1;
              x:=x;
              el_tco(x,y,train,ir); // nouvelle itération
            end;
          end;
        end;
    3 : begin
          //if debugTCO then AfficheDebug('El 3',clyellow);
          if (ancienX>x) and (ancienY<=Y) then begin xn:=x-1;end;
          if (ancienX<x) and (ancienY=y) then
          begin
            // aiguillage pris en pointe
            // essayer droit
            ancienX:=x;AncienY:=y;
            x:=x+1;
            el_tco(x,y,train,ir);
            // essayer dévié
            if not(memtrouve) then
            begin
              AncienY:=y;
              AncienX:=x-1;
              y:=y-1;
              x:=x;
              el_tco(x,y,train,ir); // nouvelle itération
            end;
          end;
        end;

    4 : begin
          //if debugTCO then AfficheDebug('El 4',clyellow);
          if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
          if (ancienX>x) and (ancienY>y) then begin xn:=x-1;end;
          if (ancienX<x) and (ancienY=Y) then
          begin
            // essai droit
            AncienX:=x;AncienY:=y;
            x:=x+1;
            el_tco(x,y,train,ir);
            if not(memtrouve) then
            begin
              // essai dévié
              AncienY:=y;
              AncienX:=x-1;
              y:=y+1;x:=x;
              el_tco(x,y,train,ir); // nouvelle itération
            end;
          end;
        end;
    5 : begin
          //if debugTCO then AfficheDebug('El 5',clyellow);
          if (ancienX<x) and (ancienY<=y) then begin yn:=y;xn:=x+1;end;
          if (ancienX>x) and (ancienY=Y) then
          begin
            // pris en pointe pos droite
            ancienx:=x;ancieny:=y;
            x:=x-1;y:=y;
            el_tco(x,y,train,ir);
            if not(memtrouve) then
            begin
              // essai dévié
              AncienY:=y;
              AncienX:=x+1;
              y:=y-1;x:=x;
              el_tco(x,y,train,ir);
            end;
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
            ancienX:=x;ancienY:=y;
            x:=x+1;y:=y+1;
            el_tco(x,y,train,ir);
            if not(memtrouve) then
            begin
              // essai dévié
              AncienY:=y-1;
              AncienX:=x-1;
              y:=y-1;x:=x;
              el_tco(x,y,train,ir);
            end;
          end;
        end;
   13 : begin
          if (ancienX<x) and (ancienY>=Y) then begin xn:=x+1;yn:=y-1;end;
          if (ancienX>x) and (ancienY<Y) then
          begin
            // pris en pointe
             ancienX:=x;ancienY:=y;
             x:=x-1;y:=y+1;
             el_tco(x,y,train,ir);
             if not(memtrouve) then
             begin
               // essai dévié
               AncienY:=y-1;
               AncienX:=x+1;
               y:=y-1;x:=x;
               el_tco(x,y,train,ir);
             end;
           end;
         end;
    14 : begin
           if (ancienX<x) and (ancienY<=Y) then begin xn:=x+1;yn:=y+1;end;
           if (ancienX>x) and (ancienY>y) then
           begin
             // pris en pointe droit
             ancienX:=x;ancienY:=y;
             x:=x-1;y:=y-1;
             el_tco(x,y,train,ir);
             if not(memtrouve) then
             begin
               // essai dévié
               AncienY:=y+1;
               AncienX:=x+1;
               y:=y+1;x:=x;
               el_tco(x,y,train,ir);
             end;
           end;
         end;
    15 : begin
           if (ancienX>x) and (ancienY<=Y) then begin xn:=x-1;yn:=y+1;end;
           if (ancienX<x) and (ancienY>Y) then
           begin
              // aiguillage pris en pointe
              ancienX:=x;ancienY:=y;
              x:=x+1;y:=y-1;
              // essayer droit
              el_tco(x,y,train,ir);
              // essayer dévié
              if not(memtrouve) then
              begin
                AncienY:=y+1;
                AncienX:=x-1;
                y:=y+1;
                x:=x;
                el_tco(x,y,train,ir); // nouvelle itération
              end;
            end;

         end;
    16 : if ancienX<x then begin xn:=x;yn:=y+1  ;end else begin xn:=x-1;yn:=y-1;end;
    17 : if ancienY<y then begin xn:=x;yn:=y+1  ;end else begin xn:=x+1;yn:=y-1;end;
    18 : if AncienX<x then begin xn:=x;yn:=y-1  ;end else begin yn:=y+1;xn:=x-1;end;
    19 : if ancienY<y then begin xn:=x+1;yn:=y+1;end else begin xn:=x;yn:=y-1;end;
    20 : begin
            if debugTCO then
            begin
              s:='El 20';if adresse<>0 then s:=s+'adr='+intToStr(adresse);
              AfficheDebug(s,clyellow);
            end;
           xn:=x;
           casok:=true;
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
               if ancienX<x then  // on va à droite
               begin
                 // essayer vers E
                 ancienX:=x;ancienY:=y;
                 x:=x+1;
                 el_tco(x,y,train,ir);
                 if not(memtrouve) then
                 begin
                 // essai vers NE
                   AncienY:=y;
                   AncienX:=x-1;
                   y:=y-1;x:=x;
                   el_tco(x,y,train,ir);
                 end;
               end;
               if (ancienX>x) and not(Memtrouve) then  // on va à gauche
               begin
                 // essayer vers O
                 ancienX:=x;ancienY:=y;
                 x:=x-1;
                 el_tco(x,y,train,ir);
                 if not(memtrouve) then
                 begin
                 // essai vers SO
                   AncienY:=y;
                   AncienX:=x+1;
                   y:=y+1;x:=x;
                   el_tco(x,y,train,ir);
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
               if ancienX<x then  // on va à droite
               begin
                 // essayer vers E
                 ancienX:=x;ancienY:=y;
                 x:=x+1;
                 el_tco(x,y,train,ir);
                 if not(memtrouve) then
                 begin
                   // essai vers SE
                   AncienY:=y;
                   AncienX:=x-1;
                   y:=y+1;x:=x;
                   el_tco(x,y,train,ir);
                 end;
               end;
               if (ancienX>x) and not(Memtrouve) then  // on va à gauche
               begin
                 // essayer vers O
                 ancienX:=x;ancienY:=y;
                 x:=x-1;
                 el_tco(x,y,train,ir);
                 if not(memtrouve) then
                 begin
                   // essai vers NO
                   AncienY:=y;
                   AncienX:=x+1;
                   y:=y-1;x:=x;
                   el_tco(x,y,train,ir);
                 end;
               end;
             end;
           end;

           if (adresse=0) or (mdl=crois) then
           // croisement
           begin
             if DebugTCO then AfficheDebug('croisement',clyellow);
             if (ancienX<x) and (ancienY=Y) then begin casok:=true;xn:=x+1;end;
             if (ancienX>x) and (ancienY=Y) then begin casok:=true;xn:=x-1;end;
             if (ancienX>x) and (ancienY>Y) then begin casok:=true;xn:=x-1;yn:=y-1;end;
             if (ancienX<x) and (ancienY<Y) then begin casok:=true;xn:=x+1;yn:=y+1;end;
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
                    if ancienY<y then  // on va en bas
                    begin
                      // essayer vers S
                      ancienX:=x;ancienY:=y;
                      y:=y+1;
                      el_tco(x,y,train,ir);
                      if not(memtrouve) then
                      begin
                        // essai vers SO
                        AncienY:=y-1;
                        AncienX:=x;
                        x:=x-1;
                        el_tco(x,y,train,ir);
                      end;
                    end;
                    if (ancienY>y) and not(Memtrouve) then  // on monte
                    begin
                      // essayer vers N
                      ancienX:=x;ancienY:=y;
                      y:=y-1;
                      el_tco(x,y,train,ir);
                      if not(memtrouve) then
                      begin
                        // essai vers NE
                        AncienY:=y+1;
                        AncienX:=x;
                        x:=x+1;
                        el_tco(x,y,train,ir);
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
                 ancienX:=x;ancienY:=y;
                 y:=y-1;
                 // essayer droit
                 el_tco(x,y,train,ir);
                 // essayer dévié
                 if not(memtrouve) then
                 begin
                   AncienY:=y+1;
                   AncienX:=x;
                   x:=x-1;
                   el_tco(x,y,train,ir); // nouvelle itération
                 end;
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
                    if ancienY<y then  // on va en bas
                    begin
                      // essayer vers S
                      ancienX:=x;ancienY:=y;
                      y:=y+1;
                      el_tco(x,y,train,ir);
                      if not(memtrouve) then
                      begin
                        // essai vers SE
                        AncienY:=y-1;
                        AncienX:=x;
                        x:=x+1;
                        el_tco(x,y,train,ir);
                      end;
                    end;
                    if (ancienY>y) and not(Memtrouve) then  // on monte
                    begin
                      // essayer vers N
                      ancienX:=x;ancienY:=y;
                      y:=y-1;
                      el_tco(x,y,train,ir);
                      if not(memtrouve) then
                      begin
                        // essai vers NO
                        AncienY:=y+1;
                        AncienX:=x;
                        x:=x-1;
                        el_tco(x,y,train,ir);
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
               // on vient d'en bas
               if (ancienY>y) and (ancienX=x) then
               begin
                 ancienX:=x;ancienY:=y;
                 y:=y-1;
                 // essayer droit
                 el_tco(x,y,train,ir);
                 // essayer dévié
                 if not(memtrouve) then
                 begin
                   AncienY:=y+1;
                   AncienX:=x;
                   x:=x+1;
                   el_tco(x,y,train,ir); // nouvelle itération
                 end;
               end;
              end;
         27 : begin
               if debugTCO then AfficheDebug('El 27',clyellow);
               // on vient d'en bas
               if (ancienY>y) and (ancienX<=x) then begin yn:=y-1;xn:=x;end;
               // on vient d'en haut: pris en pointe
               if (ancienY<y) and (ancienX=x) then
               begin
                 ancienX:=x;ancienY:=y;
                 y:=y+1;
                 // essayer droit
                 el_tco(x,y,train,ir);
                 // essayer dévié
                 if not(memtrouve) then
                 begin
                   AncienY:=y-1;
                   AncienX:=x;
                   x:=x-1;
                   el_tco(x,y,train,ir); // nouvelle itération
                 end;
               end;
              end;
         28 : begin
               if debugTCO then AfficheDebug('El 28',clyellow);
               // on vient d'en bas ou droite
               if (ancienY>y) and (ancienX>=x) then begin yn:=y-1;xn:=x; end;

               // on vient d'en haut
               if (ancienY<y) and (ancienX=x) then
               begin
                 ancienX:=x;ancienY:=y;
                 y:=y+1;
                 // essayer droit
                 el_tco(x,y,train,ir);
                 // essayer dévié
                 if not(memtrouve) then
                 begin
                   AncienY:=y-1;
                   AncienX:=x;
                   x:=x+1;
                   el_tco(x,y,train,ir); // nouvelle itération
                 end;
               end;
             end;
    29 : begin
           //if debugTCO then AfficheDebug('El 12',clyellow);
           // on vient de bas
           if (ancienX>=x) and (ancienY>Y) then begin xn:=x-1;yn:=y-1;end;
           // on vient de NO
           if (ancienX<x) and (ancienY<Y) then
           begin
             ancienX:=x;ancienY:=y;
             y:=y+1;x:=x+1;
             // essayer droit
             el_tco(x,y,train,ir);
             // essayer dévié
             if not(memtrouve) then
             begin
               AncienY:=y-1;
               AncienX:=x-1;
               x:=x-1;
               el_tco(x,y,train,ir); // nouvelle itération
             end;
           end;
         end;
   32 :  begin
           if debugTCO then AfficheDebug('El 32',clyellow);
           // on vient d'en bas
           if (ancienX<=x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
           // on vient d'en haut à droite
           if (ancienX>x) and (ancienY<y) then
           // on vient de NE
           begin
             ancienX:=x;ancienY:=y;
             y:=y+1;x:=x-1;
             // essayer droit
             el_tco(x,y,train,ir);
             // essayer dévié
             if not(memtrouve) then
             begin
               AncienY:=y-1;
               AncienX:=x+1;
               x:=x+1;
               el_tco(x,y,train,ir); // nouvelle itération
             end;
           end;
         end;
    33 : begin
           //if debugTCO then AfficheDebug('El 14',clyellow);
           // on vient de haut
           if (ancienX<=x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           //on vient de bas droite
           if (ancienX>x) and (ancienY>y) then
           begin
              // on vient de SE
             ancienX:=x;ancienY:=y;
             y:=y-1;x:=x-1;
             // essayer droit
             el_tco(x,y,train,ir);
             // essayer dévié
             if not(memtrouve) then
             begin
               AncienY:=y+1;
               AncienX:=x+1;
               x:=x+1;
               el_tco(x,y,train,ir); // nouvelle itération
             end;
           end;
         end;
    34 : begin
           // on vient du N ou NE
           if (ancienX>=x) and (ancienY<y) then begin xn:=x-1;yn:=y+1;end;
           // on vient du SO
           if (ancienX<x) and (ancienY>y) then
           begin
             ancienX:=x;ancienY:=y;
             y:=y-1;x:=x+1;
             // essayer droit
             el_tco(x,y,train,ir);
             // essayer dévié
             if not(memtrouve) then
             begin
               AncienY:=y+1;
               AncienX:=x-1;
               x:=x-1;
               el_tco(x,y,train,ir); // nouvelle itération
             end;
           end;
         end;

         else

         begin
           // fausse route, sortir
           if DebugTCO then
             AfficheDebug('Sortie de calcul route TCO par élement '+intToSTR(Bimage)+' inconnu en x='+intToSTR(x)+' y='+intToSTR(y)+' sur route '+intToSTR(det1)+' à '+intToSTR(det2),clOrange);
           sortir:=true;
         end;
     end;

     inc(i);
     if (adresse=det2) then memTrouve:=true;
     if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and ((adresse<>det2) and (adresse<>det1) and (adresse<>0)) then sortir:=true;
     if (i>200) or (iteration>200) then sortir:=true;
     Maj_coords(AncienX,AncienY,x,y);
   until sortir or memtrouve;
   if DebugTCO and not(memtrouve) then AfficheDebug('Fin de boucle',clOrange);

   //mémoriser l'index de route si on a trouvé det2, et uniquement sur la première itération quand on l'a trouvé
   if memTrouve and not(indextrouve) then
   begin
     indexTrouve:=true;
     indexIr:=ir-1;
   end;
   if i>200 then Affiche('Erreur 487 : limite d''itérations TCO',clred);
   if iteration>200 then Affiche('Erreur 488 : limite de récursivité TCO',clred);
end;


// Début de la procédure zone_tco
begin
  if debugTCO then AfficheDebug('Zone_TCO det1='+intToSTR(det1)+' det2='+intToSTR(det2)+' Train'+intToSTR(Train)+' mode='+intToSTR(mode),clyellow);
  trouve_det(indexTCO,det1,Xdet1,Ydet1);
  if (Xdet1=0) or (Ydet1=0) then exit;

  memtrouve:=false;
  indextrouve:=false;

  Direction:=1;    // on teste 4 directions: 1=SE 2=NO 3=SO 4=NE

  repeat  // boucle de test de direction
    sortir:=false;
    x:=xDet1;y:=Ydet1;
    xn:=x;yn:=y;
    ir:=1;    // index de la route du tco
    i:=0;     // itérations
    if debugTCO then afficheDebug('Direction '+intToSTR(direction),clOrange);

    // initialiser les points d'où l'on vient
    if direction=1 then
    begin
       // vers SE
       ancieny:=ydet1+1;
       ancienx:=xdet1+1;
    end;
    if direction=2 then
    begin
      // vers NO
      ancieny:=ydet1-1;
      ancienx:=xdet1-1;
    end;
    if direction=3 then
    begin
      // SO
      ancieny:=ydet1+1;
      ancienx:=xdet1-1;
    end;
    if direction=4 then
    begin
      // vers NE
      ancieny:=ydet1-1;
      ancienx:=xdet1+1;
    end;


    if debugTCO then AfficheDebug('X='+intToSTR(x)+' Y='+IntToSTR(Y)+' AncienX='+intToSTR(ancienX)+' AncienY='+IntToSTR(ancienY),clyellow);

    // Affiche la cellule en fonction du mode
    iteration:=0;
    ir:=1;
    El_tco(x,y,train,ir);  // trouve l'élément suivant, et explore les ports de l'aiguillage en récursif

    inc(i);
    if (adresse=det2) then memTrouve:=true;
    if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and ((adresse<>det2) and (adresse<>det1) and (adresse<>0)) then sortir:=true;

    if (i>NbCellulesTCO[indexTCO]) then AfficheDebug('Erreur 1000 TCO : dépassement d''itérations - Route de '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    inc(direction)
  until (direction=5) or memtrouve ;

  if memTrouve then
  begin
    if debugTco then afficheDebug('TCO: Trouvé route de '+intToSTR(det1)+' à '+intToSTR(det2)+' en '+intToSTR(x)+','+intToSTR(y),clLime);
    Affiche_trajet(indexTCO,train,indexIr,mode);     // affiche le trajet dans le TCO
  end;
end;

// allume ou éteint (mode=0 ou 1) la voie, zone de det1 à det2 sur le TCO
// si mode=0 : éteint
//        =1 : couleur détecteur allumé
//        =2 : couleur de l'index train
// nécessite que les aiguillages aoient bien positionnés entre det1 et det2
procedure zone_TCO_ancien(indexTCO,det1,det2,mode: integer);
var direction,i,j,x,y,xn,yn,ancienY,ancienX,Xdet1,Ydet1,Xdet2,Ydet2,Bimage,adresse,
    pos,pos2,ir: integer;
    memtrouve,sortir,casok : boolean;
    mdl : Tequipement;
    s : string;
begin
  // trouver le détecteur det1
  if debugTCO then AfficheDebug('Zone_TCO det1='+intToSTR(det1)+' det2='+intToSTR(det2)+' mode='+intToSTR(mode),clyellow);
  trouve_det(indexTCO,det1,Xdet1,Ydet1);
  if (Xdet1=0) or (Ydet1=0) then exit;

  trouve_det(indexTCO,det2,Xdet2,Ydet2);
  if (Xdet2=0) or (Ydet2=0) then exit;

  if debugTCO then
  begin
    AfficheDebug('trouvé '+intToSTR(det1)+' en '+IntToSTR(xDet1)+'/'+intToSTR(ydet1),clyellow);
    AfficheDebug('trouvé '+intToSTR(det2)+' en '+IntToSTR(xDet2)+'/'+intToSTR(ydet2),clyellow);
  end;

  memtrouve:=false;

  Direction:=1;    // on teste 4 directions: 1=SE 2=NO 3=SO 4=NE
  repeat  // boucle de test de direction
    sortir:=false;
    x:=xDet1;y:=Ydet1;
    xn:=x;yn:=y;
    ir:=1;    // index de la route du tco
    i:=0;     // itérations
    if debugTCO then afficheDebug('Direction '+intToSTR(direction),clOrange);

    // initialiser les points d'où l'on vient
    if direction=1 then
    begin
       // vers SE
       casok:=true;
       ancieny:=ydet1+1;
       ancienx:=xdet1+1;
    end;
    if direction=2 then
    begin
      // vers NO
      casok:=true;
      ancieny:=ydet1-1;
      ancienx:=xdet1-1;
    end;
    if direction=3 then
    begin
      // SO
      casok:=true;
      ancieny:=ydet1+1;
      ancienx:=xdet1-1;
    end;
    if direction=4 then
    begin
      // vers NE
      casok:=true;
      ancieny:=ydet1-1;
      ancienx:=xdet1+1;
    end;


    // boucle de remplissage du tableau routeTCO de det1 à det2
    repeat
//      routetco[indexTCO,ir].x:=x;
//      routetco[indexTCO,ir].y:=y;
      if ir<500 then inc(ir);

      if debugTCO then AfficheDebug('X='+intToSTR(x)+' Y='+IntToSTR(Y)+' AncienX='+intToSTR(ancienX)+' AncienY='+IntToSTR(ancienY),clyellow);

      // Affiche la cellule en fonction du mode


      adresse:=tco[indextco,x,y].Adresse ;
      Bimage:=tco[indextco,x,y].Bimage;
      casok:=false;
      // vers case suivante: trouver le trajet pour rejoindre det1 à det2
      case Bimage of
      // voie
      1 : begin
            if debugTCO then
            begin
              s:='El 1';if adresse<>0 then s:=s+'adr='+intToStr(adresse);
              AfficheDebug(s,clyellow);
            end;
            if ancienX<x then xn:=x+1 else xn:=x-1;
          end;
      // aiguillage
      2 : begin
            //if debugTCO then AfficheDebug('El 2',clyellow);
            pos:=positionTCO(indexTCO,x,y);
            if (ancienX<x) and (ancienY=y) then begin xn:=x+1;end;
            if (ancienX>x) and (ancienY=Y) then
            begin
              xn:=x-1;
              if pos=const_devie then yn:=y+1;
            end;
            if (ancienX<x) and (ancienY>y) then begin xn:=x+1; end;
            if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
          end;
      3 : begin
            //if debugTCO then AfficheDebug('El 3',clyellow);
            pos:=positionTCO(indexTCO,x,y);
            if (ancienX<x) then begin xn:=x+1;if pos=const_devie then yn:=y-1;end;
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
            if (ancienX>x) and (ancienY<y) then begin xn:=x-1;end;
            if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
          end;
      4 : begin
            //if debugTCO then AfficheDebug('El 4',clyellow);
            pos:=positionTCO(indexTCO,x,y);
            if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;if pos=const_devie then yn:=y+1;end;
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
            if (ancienX>x) and (ancienY>y) then begin xn:=x-1;end;
            if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
          end;
    5 : begin
          //if debugTCO then AfficheDebug('El 5',clyellow);
          pos:=positionTCO(indexTCO,x,y);
          if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;end;
          if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;if pos=const_devie then yn:=y-1;end;
          if (ancienX<x) and (ancienY<y) then begin ;xn:=x+1;end;
          if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
        end;
    6 : begin
         //if debugTCO then AfficheDebug('El 6',clyellow);
         if ancienX<x then begin xn:=x+1;end
           else begin xn:=x-1;yn:=y-1;end;
         end;
    7 : if ancienx<x then begin xn:=x+1;yn:=y-1; end else begin xn:=x-1;end;
    8 : if ancienX<x then begin xn:=x+1;yn:=y+1; end else begin xn:=x-1;end;
    9 : if ancienX<x then begin xn:=x+1;end else begin xn:=x-1;yn:=y+1;end;
    10 : begin
           //if debugTCO then AfficheDebug('El 10',clyellow);
           if ancienX<x then begin xn:=x+1;yn:=y-1;end else begin xn:=x-1;yn:=y+1;end;
         end;
    11 : begin
           //if debugTCO then AfficheDebug('El 11',clyellow);
           if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end;
         end;
    12 : begin
           //if debugTCO then AfficheDebug('El 12',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;if pos=const_droit then yn:=y+1;end;
           if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;yn:=y-1;end;
           if (ancienX>x) and (ancienY>y) then begin xn:=x-1;yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
    13 : begin
           //if debugTCO then AfficheDebug('El 13',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;yn:=y-1;end;
           if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;if pos=const_droit then yn:=y+1;end;
           if (ancienX<x) and (ancienY>y) then begin xn:=x+1;yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
    14 : begin
           //if debugTCO then AfficheDebug('El 14',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;yn:=y+1;end;
           if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           if (ancienX>x) and (ancienY>y) then begin xn:=x-1;if pos=const_droit then yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
    15 : begin
           //if debugTCO then AfficheDebug('El 15',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;if pos=const_droit then yn:=y-1;end;
           if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;yn:=y+1;end;
           if (ancienX>x) and (ancienY=y) then begin xn:=x-1;yn:=y+1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
    16 : if ancienX<x then begin casok:=true;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end;
    17 : if ancienY<y then begin casok:=true;yn:=y+1;end else begin xn:=x+1;yn:=y-1;end;
    18 : if AncienX<x then begin casok:=true;yn:=y-1;end else begin yn:=y+1;xn:=x-1;end;
    19 : begin
           //if debugTCO then AfficheDebug('El 19',clyellow);
           casok:=true;
           if ancienY<y then begin xn:=x+1;yn:=y+1;end else yn:=y-1;
         end;
    20 : begin
            if debugTCO then
            begin
              s:='El 20';if adresse<>0 then s:=s+'adr='+intToStr(adresse);
              AfficheDebug(s,clyellow);
            end;
           xn:=x;
           casok:=true;
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
               pos:=aiguillage[j].position;
               if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;

               if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
               begin
                 j:=Index_Aig(aiguillage[j].Ddroit);
                 pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                 if (pos2=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
                 if (pos=const_droit) and (pos2=const_droit) then
                 begin
                   casok:=true;
                   if ancienX<x then xn:=x+1 else xn:=x-1;
                 end;
                 if (pos=const_devie) and (pos2=const_devie) then
                 begin
                   if ancienX<x then begin xn:=x+1;yn:=y-1;end
                   else begin casok:=true;xn:=x-1;yn:=y+1;end;
                 end;
                 if (pos=const_droit) and (pos2=const_devie) then
                 begin
                   if ancienX<x then xn:=x+1 else begin xn:=x-1;yn:=y+1;end;
                 end;
                 if (pos=const_devie) and (pos2=const_droit) then
                 begin
                   if ancienX<x then begin xn:=x+1;end
                                else begin xn:=x-1;yn:=y-1;end;
                 end;
               end;

               if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=2) then
               begin
                 if (pos=const_droit) then
                 begin
                   if ancienX<x then xn:=x+1 else xn:=x-1;
                 end;
                 if (pos=const_devie) then
                 begin
                   casok:=true;
                   if ancienX<x then begin xn:=x+1;yn:=y-1;end
                                else begin xn:=x-1;yn:=y+1;end ;
                 end;
               end;
             end;
           end;

           if (adresse=0) or (mdl=crois) then
           // croisement
           begin
             if DebugTCO then AfficheDebug('Croisement',clyellow);
             if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;end;
             if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
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
           //if debugTCO then AfficheDebug('El 22',clyellow);
           mdl:=rien;
           if adresse<>0 then
           begin
             j:=Index_Aig(adresse);
             mdl:=aiguillage[j].modele;
             // tjd ou tjs
             if (mdl=tjd) or (mdl=tjs) then
             begin
               pos:=aiguillage[j].position;
               if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;

               if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
               begin
                 j:=Index_Aig(aiguillage[j].Ddroit);
                 pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                 if (pos2=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
                 if (pos=const_droit) and (pos2=const_droit) then
                 begin
                   if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end;
                 end;
                 if (pos=const_devie) and (pos2=const_devie) then
                 begin
                   if ancienX<x then xn:=x+1 else xn:=x-1;
                 end;
                 if (pos=const_droit) and (pos2=const_devie) then
                 begin
                   if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;end ;
                 end;
                 if (pos=const_devie) and (pos2=const_droit) then
                 begin
                   if ancienX<x then xn:=x+1 else begin xn:=x-1;yn:=y-1;end;
                 end;
               end;
               if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=2) then
               begin
                 if (pos=const_droit) then
                 begin
                   if ancienX<x then xn:=x+1 else xn:=x-1;
                 end ;
                 if (pos=const_devie) then
                 begin
                   if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end
                 end;
               end;
             end;
           end;

           if (adresse=0) or (mdl=crois) then
           // croisement
           begin
             if DebugTCO then AfficheDebug('croisement',clyellow);
             if (ancienX<x) and (ancienY=Y) then begin casok:=true;xn:=x+1;end;
             if (ancienX>x) and (ancienY=Y) then begin casok:=true;xn:=x-1;end;
             if (ancienX>x) and (ancienY>Y) then begin casok:=true;xn:=x-1;yn:=y-1;end;
             if (ancienX<x) and (ancienY<Y) then begin casok:=true;xn:=x+1;yn:=y+1;end;
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
                    pos:=aiguillage[j].position;
                    if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;

                    if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
                    begin
                      j:=Index_Aig(aiguillage[j].Ddroit);
                      pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                      if (pos2=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
                      if (pos=const_droit) and (pos2=const_droit) then
                      begin
                        if ancienX<x then begin xn:=x+1;yn:=y-1;end else begin xn:=x-1;yn:=y+1;end;
                      end;
                      if (pos=const_devie) and (pos2=const_devie) then
                      begin
                        xn:=x;
                        if ancieny<y then yn:=y+1 else yn:=y-1;
                      end;
                      if (pos=const_droit) and (pos2=const_devie) then
                      begin
                        if ancieny<y then begin xn:=x;yn:=y+1;end else begin xn:=x+1;yn:=yn-1;end ;
                      end;
                      if (pos=const_devie) and (pos2=const_droit) then
                      begin
                        if ancieny<y then begin
                        xn:=x-1;yn:=y+1;end else begin
                        xn:=x;yn:=y-1;end;
                      end;
                    end;

                    if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=2) then
                    begin
                      if (pos=const_droit) then
                      begin
                        if ancienX<x then xn:=x+1 else xn:=x-1;
                      end ;
                      if (pos=const_devie) then
                      begin
                        if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end
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
               pos:=positionTCO(indexTCO,x,y);
               // on vient d'en bas
               if (ancienY>y) and (ancienX=x) then
               begin
                 yn:=y-1;if pos=const_devie then xn:=x-1 else xn:=x;
               end;
               // on vient d'en haut
               if (ancienY<y) and (ancienX=x) then
               begin
                 yn:=y+1;xn:=x;
               end;
               // on vient d'en haut gauche
               if (ancienY<y) and (ancienX<x) then
               begin
                 yn:=y+1;xn:=x;
               end;
               if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
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
                    pos:=aiguillage[j].position;
                    if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;

                    if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
                    begin
                      j:=Index_Aig(aiguillage[j].Ddroit);
                      pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                      if (pos2=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
                      if (pos=const_droit) and (pos2=const_droit) then
                      begin
                        if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end;
                      end;
                      if (pos=const_devie) and (pos2=const_devie) then
                      begin
                        if ancienX<x then xn:=x+1 else xn:=x-1;
                      end;
                      if (pos=const_droit) and (pos2=const_devie) then
                      begin
                        if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;end ;
                      end;
                      if (pos=const_devie) and (pos2=const_droit) then
                      begin
                        if ancienX<x then xn:=x+1 else begin xn:=x-1;yn:=y-1;end;
                      end;
                    end;
                    if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=2) then
                    begin
                      if (pos=const_droit) then
                      begin
                        if ancienX<x then xn:=x+1 else xn:=x-1;
                      end ;
                      if (pos=const_devie) then
                      begin
                        if ancienX<x then begin xn:=x+1;yn:=y+1;end else begin xn:=x-1;yn:=y-1;end
                     end;
                    end;
                  end;
                end;
                if (adresse=0) or (mdl=crois) then
                // croisement
                begin
                  if DebugTCO then AfficheDebug('Croisement',clyellow);
                  if (ancienX<x) and (ancienY<Y) then begin casok:=true;xn:=x+1;yn:=yn+1;end;
                  if (ancienX>x) and (ancienY>Y) then begin casok:=true;xn:=x-1;yn:=yn-1;end;
                  if (ancienX=x) and (ancienY<Y) then begin casok:=true;xn:=x;yn:=y+1;end;
                  if (ancienX=x) and (ancienY>Y) then begin casok:=true;xn:=x;yn:=y-1;end;
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
               pos:=positionTCO(indexTCO,x,y);
               // on vient d'en bas
               if (ancienY>y) and (ancienX=x) then
               begin
                 yn:=y-1;if pos=const_devie then xn:=x+1 else xn:=x;
               end;
               // on vient d'en haut
               if (ancienY<y) and (ancienX=x) then
               begin
                 yn:=y+1;xn:=x;
               end;
               // on vient d'en haut droite
               if (ancienY<y) and (ancienX>x) then
               begin
                 yn:=y+1;xn:=x;
               end;
               if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
              end;
         27 : begin
               if debugTCO then AfficheDebug('El 27',clyellow);
               pos:=positionTCO(indexTCO,x,y);
               // on vient d'en bas
               if (ancienY>y) and (ancienX=x) then
               begin
                 yn:=y-1;xn:=x;
               end;
               // on vient d'en haut
               if (ancienY<y) and (ancienX=x) then
               begin
                 yn:=y+1;if pos=const_devie then xn:=x-1 else xn:=x;
               end;
               // on vient d'en bas gauche
               if (ancienY>y) and (ancienX<x) then
               begin
                 yn:=y-1;xn:=x;
               end;
               if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
              end;
         28 : begin
               if debugTCO then AfficheDebug('El 28',clyellow);
               pos:=positionTCO(indexTCO,x,y);
               // on vient d'en bas
               if (ancienY>y) and (ancienX=x) then
               begin
                 yn:=y-1;xn:=x;
               end;
               // on vient d'en haut
               if (ancienY<y) and (ancienX=x) then
               begin
                 yn:=y+1;if pos=const_devie then xn:=x+1 else xn:=x;
               end;
               // on vient d'en bas droite
               if (ancienY>y) and (ancienX>x) then
               begin
                 yn:=y-1;xn:=x;
               end;
               if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
              end;
    29 : begin
           //if debugTCO then AfficheDebug('El 12',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           // on vient à de haut à gauche
           if (ancienX<x) and (ancienY<Y) then
           begin
             yn:=y+1;
             if pos=const_droit then xn:=x+1 else xn:=x;
           end;
           // on vient de bas droite
           if (ancienX>x) and (ancienY>Y) then begin xn:=x-1;yn:=y-1;end;
           // on vient de bas
           if (ancienX=x) and (ancienY>y) then begin xn:=x-1;yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
   32 :  begin
           if debugTCO then AfficheDebug('El 32',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           // on vient d'en bas à gauche
           if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
           // on vient d'en bas
           if (ancienX=x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
           // on vient d'en haut à droite
           if (ancienX>x) and (ancienY<y) then begin yn:=y+1;if pos=const_devie then xn:=x else xn:=x-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
    33 : begin
           //if debugTCO then AfficheDebug('El 14',clyellow);
           pos:=positionTCO(indexTCO,x,y);
           // on vient de haut
           if (ancienX=x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           // on vient de haut gauche
           if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           //on vient de bas droite
           if (ancienX>x) and (ancienY>y) then begin yn:=y-1;if pos=const_droit then xn:=x-1 else xn:=x;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;
    34 : begin
           pos:=positionTCO(indexTCO,x,y);
           // on vient du SE
           if (ancienX<x) and (ancienY>y) then begin yn:=y-1;if pos=const_droit then xn:=x+1 else xn:=x;end;
           // on vient du N
           if (ancienX=x) and (ancienY<y) then begin xn:=x-1;yn:=y+1;end;
           // on vient du NE
           if (ancienX>x) and (ancienY<y) then begin xn:=x-1;yn:=y+1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(indexTCO,x,y);sortir:=true;end;
         end;

         else

         begin
           // fausse route, sortir
           //if DebugTCO then
           //  Affichedebug('Sortie de calcul route TCO par élement '+intToSTR(Bimage)+' inconnu en x='+intToSTR(x)+' y='+intToSTR(y)+' sur route '+intToSTR(det1)+' à '+intToSTR(det2),clOrange);
           sortir:=true;
         end;
      end;
      inc(i);
      if (adresse=det2) then memTrouve:=true;
      if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and ((adresse<>det2) and (adresse<>det1) and (adresse<>0)) then sortir:=true;
      ancienX:=x;
      ancienY:=y;
      x:=xn;
      y:=yn;
    until (memTrouve) or (i>NbCellulesTCO[indexTCO]) or (x>NbreCellX[indexTCO]) or (y>NbreCellY[indexTCO]) or (x=0) or (y=0) or sortir; // or not(casok) ;

   { if not(casok) then
    begin
      Affiche('Erreur TCO incohérence tracé cellule '+intToSTR(x)+','+intToSTR(y),clred);
      exit;
    end;  }
    if (i>NbCellulesTCO[indexTCO]) then AfficheDebug('Erreur 1000 TCO : dépassement d''itérations - Route de '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    inc(direction)
  until (direction=5) or memtrouve ;

  //Affiche(intToSTR(x),clLime);
  if i>NbCellulesTCO[indexTCO] then
  begin
    // fausse route, sortir
    if DebugTCO then AfficheDebug('Erreur 1000 TCO : dépassement d''itérations - Route de '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    exit;
  end;
  if not(MemTrouve) then
  begin
    if DebugTCO then AfficheDebug('Pas de liaison entre '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    exit;
  end;

  if DebugTCO then AfficheDebug('trouvé liaison de '+IntToSTR(det1)+' à '+IntToSTR(det2),clLime);

  dec(ir);
  Affiche_trajet(indexTCO,1,ir,mode);

end;


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
          left:=((i-1) mod NbElLi)*(licone+20)+l+50;
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
          left:=((i-1) mod NbElLi)*(licone+20)+l+32;
          top:= ((i-1) div NbElLi)*(hicone+10)+16;
        end;
      end;
end;

// dessine l'icone d'image ip et la place en x y d'après son index
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
          left:=((i-1) mod NbElLi)*(licone+20)+l+50;
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
          left:=((i-1) mod NbElLi)*(licone+20)+l+32;
          top:= ((i-1) div NbElLi)*(hicone+10)+16;
        end;
      end;
end;

// dessine les icones du tco et les aligne
procedure dessine_icones(indexTCO : integer);
var ancH,ancW,i,lf,hf,sauv_ep: integer;
    ip : TImage;
    lbl : Tlabel;
begin
  // d'abord on positionne les icones
  with formTCO[indexTCO] do
  begin
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
    epaisseur:=4;
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

    dessin_51(indexTCO,ImagePalette51.canvas,1,1,0); //quai
    dessin_52(indexTCO,ImagePalette52.canvas,1,1,0); //action

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
  //  end;
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

    panel1.width:=clLarge-20;
    Panel1.Top:=clHaut-Panel1.Height-64; // 64=entete de la fenetre

    with ScrollBox do
    begin
      Width:=clLarge-55; // laisser 50 pixels pour la trackbarzoom + scrollBar
      //Width:=clLarge-300;  // mode pour voir les imageTemp
      top:=1;
      left:=1;
    end;

    if MasqueBandeauTCO then
    begin
      BandeauMasque:=true;
      Panel1.Hide;
      ScrollBox.Height:=clHaut-32;
    end
    else
    begin
      BandeauMasque:=false;
      Panel1.show;
      ScrollBox.Height:=ClHaut-Panel1.Height-ScrollBox.Top-64;
    end;
  end;  
end;

procedure TFormTCO.FormActivate(Sender: TObject);
//procedure PFormTCO[indexTCO].FormActivate(Sender: TObject);
var indextco : integer;
begin
  indextco:=index_TCO(sender);
  IndexTCOCourant:=indexTCO;
  if affevt then Affiche('Form TCO'+intToSTR(indexTCO)+' activate',clyellow);
  Caption:='TCO'+intToSTR(indexTCO)+' : '+NomFichierTCO[indexTCO];

  {initalisation des dimensions du tco - à ne faire qu'une fois}
  if not(Forminit[indexTCO]) then
  begin
    Button1.Visible:=not(Diffusion);
    Button2.Visible:=not(Diffusion);
    ButtonCalibrage.Visible:=not(diffusion);
    ButtonSimu.Visible:=not(Diffusion);
    ImageTemp.Visible:=not(Diffusion);
    ImageTemp2.Visible:=not(Diffusion);

    hauteurCell[indexTCO]:=ImagePalette1.Height;
    LargeurCell[indexTCO]:=ImagePalette1.Width;
    LargeurCelld2[indexTCO]:=LargeurCell[indexTCO] div 2;hauteurCelld2[indexTCO]:=hauteurCell[indexTCO] div 2;
    calcul_reduction(frxGlob[indexTCO],fryGlob[indexTCO],LargeurCell[indexTCO],hauteurCell[indexTCO]);

    dessine_icones(indexTCO);

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
    // peindre l'image en bleu pour la transparence , nécessaire en cas de décalage des signaux à 180° mais correction apportée dans feu_180
    with PImageTemp[indextco].Canvas do
    begin
      Pen.Color:=ClBlue;
      Brush.Color:=CLBlue;
     // FillRect(Rect(0,0,100,100));
    end;

    //PImageTemp[indextco].Canvas.Rectangle(0,0,PImageTemp[indextco].Width,PimageTemp[indextco].Height);
    //PImageTemp[indextco].Picture.Bitmap.TransparentMode:=tmAuto;
    //PImageTemp[indextco].Picture.Bitmap.TransparentColor:=clblue;
    //PImageTemp[indextco].Transparent:=true;


    //déclenche l'Affiche_tco
    if ZoomInit[indexTCO]<>0 then FormTCO[indexTCO].TrackBarZoom.Position:=ZoomInit[indexTCO] else TrackBarZoom.position:=34;
    TrackBarZoom.Max:=ZoomMax;
    TrackBarZoom.Min:=ZoomMin;

    positionne(indexTCO);

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
  //exit;
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

procedure Annule(indextco : integer);
var x,y,xu,yu,Xplace,yplace,adresse,i : integer;
begin
  if TamponAffecte then
  begin
    if (xCoupe<>0) and (ycoupe<>0) and (TamponTCO_org.numTCO=indexTCO) then
    begin
      for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do       // rectangle de la sélection
        for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
        begin
          xPlace:=xCoupe+x-TamponTCO_Org.x1;   // destination
          yPlace:=yCoupe+y-TamponTCO_Org.y1;
          if (xPlace<=NbreCellX[indexTCO]) and (yPlace<=NbreCellY[indexTCO]) then
          begin
            tco[indextco,xPlace,yPlace]:=tampontco[x,y];
            if tco[indextco,xPlace,yPlace].Bimage=Id_signal then
            begin
              adresse:=tco[indextco,xPlace,yPlace].Adresse;
            end;
          end;
        end;
    end;
    Affiche_TCO(indextco);
    tamponaffecte:=false;
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
  if debugTCO then Affiche('------------',clYellow);
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
    for y:=1 to NbreCelly[indexTCO] do
    begin
      moveto(1,y*hauteurCell[indexTCO]);
      LineTo(LargeurCell[indexTCO]*NbreCellX[indexTCO],y*hauteurCell[indexTCO]);
    end;
  end;
end;

// efface le contenu de la cellule, sauf le fond
procedure raz_cellule(indexTCO,x,y : integer);
begin
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
  tco[indextco,x,y].PiedFeu:=0;
  tco[indextco,x,y].x:=0;
  tco[indextco,x,y].y:=0;
  tco[indextco,x,y].xUndo:=0;
  tco[indextco,x,y].yUndo:=0;
  tco[indextco,x,y].FeuOriente:=0;
end;

procedure copier(indexTCO : integer);
var x,y : integer;
begin
  if SelectionAffichee[indexTCO] then
  begin
    TamponTCO_org.numTCO:=indexTCO;
    TamponTCO_Org.x1:=XminiSel div LargeurCell[indexTCO] +1;
    TamponTCO_Org.x2:=XmaxiSel div LargeurCell[indexTCO] +1;
    TamponTCO_Org.y1:=yminiSel div hauteurCell[indexTCO] +1;
    TamponTCO_Org.y2:=ymaxiSel div hauteurCell[indexTCO] +1;
    for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
      for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      begin
        //Affiche(intToSTR(x)+' '+intToSTR(y),clred);
        tampontco[x,y]:=tco[indextco,x,y];
      end;
    TamponAffecte:=true;
  end;
end;

procedure couper(indexTCO: integer);
var x,y,XCell1,YCell1,xCell2,yCell2 : integer;
begin
  with formTCO[indexTCO] do
  begin
    EditAdrElement.Text:='';
    EditTypeImage.Text:='';
    EditTexte.Text:='';
  end;

  // couper par la fenetre graphique
  if FormTCO[indexTCO].RadioGroupSel.ItemIndex=1 then
  begin
    xMiniSel:=Rect_select.Gd.Left;
    yMiniSel:=Rect_select.Gd.top;
    xMaxiSel:=Rect_select.Gd.right;
    yMaxiSel:=Rect_select.Gd.bottom;
    if xminiSel>xMaxiSel then echange(xminiSel,xMaxiSel);
    if yminiSel>yMaxiSel then echange(yminiSel,yMaxiSel);
    // effacer le rectangle
    Affiche_Rectangle(IndexTCO,Rect_select);
    Rect_select.NumTCO:=0; // indicateur de non affichage
  end;

  // couper sans sélection : on coupe une seule cellule
  if not(SelectionAffichee[indexTCO]) then
  begin
    tampontco[XclicCell[indexTCO],YclicCell[indexTCO]]:=tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]]; // pour pouvoir faire annuler couper
    TamponTCO_org.x1:=XclicCell[indexTCO];TamponTCO_org.y1:=YclicCell[indexTCO];
    TamponTCO_org.x2:=XclicCell[indexTCO];TamponTCO_org.y2:=YclicCell[indexTCO];

    raz_cellule(indextco,XclicCell[indexTCO],YClicCell[indexTCO]);

    efface_entoure(indexTCO);
    efface_cellule(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,XclicCell[indexTCO],YClicCell[indexTCO],PmCopy);
    TamponAffecte:=true;
    xCoupe:=XclicCell[indexTCO];yCoupe:=YclicCell[indexTCO];
    Affiche_tco(indexTCO);
    exit;
  end;

  TCO_modifie:=true;
  copier(indexTCO);
  SelectionAffichee[indexTCO]:=false;

  xCell1:=XminiSel div LargeurCell[indexTCO] +1;
  xCell2:=XmaxiSel div LargeurCell[indexTCO] +1;
  yCell1:=yminiSel div hauteurCell[indexTCO] +1;
  yCell2:=ymaxiSel div hauteurCell[indexTCO] +1;

  xCoupe:=XCell1;yCoupe:=yCell1;
  for y:=yCell1 to yCell2 do
    for x:=xCell1 to xCell2 do
    begin
      raz_cellule(indextco,x,y);
      //Affiche('Efface cellules '+IntToSTR(X)+' '+intToSTR(y),clyellow);
      efface_entoure(indexTCO);
      efface_cellule(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,X,Y,PmCopy);
      if avecGrille[indexTCO] then grille(indexTCO);
    end;
end;

procedure selection_bleue(indexTCO,cellX,cellY : integer);
var xMiniSelP,yminiSelP,xMaxiSelP,ymaxiSelP : integer;
    r : Trect;
begin
// zone de sélection bleue en coords pixels
  xMiniSel:=(Xentoure[indexTCO]-1)*LargeurCell[indexTCO];;
  yMiniSel:=(Yentoure[indexTCO]-1)*HauteurCell[indexTCO];;
  xMaxiSel:=(cellX-1)*LargeurCell[indexTCO];
  yMaxiSel:=(cellY-1)*hauteurCell[indexTCO];

  xminiSelP:=min(xminiSel,xMaxiSel);
  yminiSelP:=min(yminiSel,yMaxiSel);
  xmaxiSelP:=max(xminiSel,xMaxiSel);
  ymaxiSelP:=max(yminiSel,yMaxiSel);

  xminiSel:=xMiniSelP;
  yminiSel:=yMiniSelP;
  xMaxiSel:=xMaxiSelP;
  yMaxiSel:=yMaxiSelP;

  //Affiche('xMiniSel='+IntToSTR(xMiniSel)+' yMiniSel='+IntToSTR(yMiniSel)+' xMaxiSel='+IntToSTR(xMaxiSel)+' yMaxiSel='+IntToSTR(yMaxiSel),clOrange);

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

  r:=Rect(xminiSel+1,YminiSel+1,XmaxiSel+LargeurCell[indexTCO],yMaxiSel+hauteurCell[indexTCO]);

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
end;

// pour avoir les evts keydown, il faut dévalider les propriétés tabstop des boutons de la form.
procedure TFormTCO.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var s,d,indexTCO,x,y : integer;
    procede : boolean;
begin
  if affevt then Affiche('TCO.FormKeyDown',clOrange);

  indexTCO:=index_TCO(Sender);
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

  x:=XClicCell[indexTCO];
  y:=YClicCell[indexTCO];

  with formTCO[indexTCO] do
  begin
    if not(ssShift in Shift) then
    case Key of
     VK_right : if x<NbreCellX[indexTCO] then
                begin
                  inc(XClicCell[indexTCO]);
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

   if (ssCtrl in Shift) and (Key = Ord('Z')) then
   begin
     annule(indexTCO);
     exit;
   end;

     //VK_delete : affiche('delete',clorange);
  if procede then
  begin
    _entoure_cell_clic(indexTCO);
    clicTCO:=true;
    formTCO[indexTCO].EditAdrElement.Text:=IntToSTR(tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse);
    actualise(indexTCO);
    clicTCO:=false;
  end;
end;
{
procedure Elmentdroit1Click(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=Index_tco(sender);
  dessin_1(indexTCO,FormTCO[indexTCO].ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  FormTCO[indexTCO].EditAdrElement.Text:=IntToSTR(tco[indextco,XClicCellInserer,YClicCellInserer].Adresse);
end;

procedure Courbegaucheversdroite1Click(Sender: TObject);
var Position: TPoint;
    indexTCO : integer;
begin
  indexTCO:=Index_tco(sender);
  dessin_9(indexTCO,FormTCO[indexTCO].ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;

procedure Courbedroiteversgauche1Click(Sender: TObject);
var Position: TPoint;
    indexTCO : integer;
begin
  indexTCO:=Index_tco(sender);
  dessin_8(indexTCO,FormTCO[indexTCO].ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;

procedure CourbeSupD1Click(Sender: TObject);
var Position: TPoint;
    indexTCO : integer;
begin
  indexTCO:=Index_tco(sender);
  dessin_7(indexTCO,FormTCO[indexTCO].ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;

procedure CourbeSupG1Click(Sender: TObject);
var Position: TPoint;
    indexTCO : integer;
begin
  indexTCO:=Index_tco(sender);
  dessin_6(indexTCO,FormTCO[indexTCO].ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;
}

procedure debut_drag(image : TImage);
var h,l,indexTCO : integer;
    c : Tcomponent;
begin
  image.BeginDrag(true);
  c:=image.GetParentComponent;
  c:=c.GetparentComponent;
  indexTCO:=index_TCO(c as Tform);

  l:=image.Width;
  h:=image.height;
  StretchBlt(formTCO[indexTCO].ImageTemp.canvas.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],   // destination avec mise à l'échelle
             image.Canvas.Handle,0,0,l,h,srccopy);

  BitBlt(OldBmp.Canvas.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],FormTCO[IndexTCO].ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);
  StretchBlt(Vbm.Handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],   // destination masque avec mise à l'échelle
             image.Canvas.Handle,0,0,l,h,srccopy);
  drag:=true;
  TCODrag:=indexTCO;
  oldx:=offsetSourisX;
  oldy:=offsetSourisY;
end;

// on bouge l'icone du composant dans le tco
procedure TFormTCO.ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
var indexTCO,xl,yl : integer;
begin
  indexTCO:=Index_tco(sender);
  if affevt then Affiche('TCO'+intToSTR(IndexTCO)+' DragOver',clyellow);
  if TCODrag<>indexTCO then
  begin
    accept:=false;
    exit; // le drag source et destination sont différents
  end;
  xl:=x+offsetSourisX;
  yl:=y+offsetSourisY;
  Accept:=source is TImage;
  if drag then
  begin
    BitBlt(PImageTCO[indexTCO].canvas.handle,oldx,oldy,LargeurCell[indexTCO],hauteurCell[indexTCO],oldbmp.canvas.handle,0,0,SRCCOPY); // remettre la sauvegarde du bitmap à l'ancienne position souris
    BitBlt(oldbmp.canvas.handle,0,0,LargeurCell[indexTCO],hauteurCell[indexTCO],PImageTCO[IndexTCO].canvas.handle,xl,yl,SRCCOPY); // sauvegarder le bitmap actuel sous la souris
    oldx:=xl; oldy:=yl;
    BitBlt(PImageTCO[indexTCO].canvas.handle,xl,yl,LargeurCell[indexTCO],hauteurCell[indexTCO],Vbm.canvas.handle,0,0,SRCAND);   // prendre le masque de l'icone vers la souris, ne change rien...
    BitBlt(PImageTCO[indexTCO].canvas.handle,xl,yl,LargeurCell[indexTCO],hauteurCell[indexTCO],formTCO[indexTCO].ImageTemp.canvas.handle,0,0,SRCPAINT);  // copier l'icone vers la souris
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
    indexTCO,xclic,Yclic : integer;
begin
  if not(Target is TImage) then exit;
  s:=(Target as TImage).Name;
  if copy(s,1,8)<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;

  indexTCO:=Index_tco(sender);
  //Xclic:=XclicCell[indexTCO];
  //Yclic:=YClicCell[indexTCO];

  BitBlt(formTCO[indexTCO].imageTCO.canvas.handle,oldx,oldy,LargeurCell[indexTCO],hauteurCell[indexTCO],oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure(indexTCO);
  FormTCO[indexTCO].imageTCO.repaint;

  Xclic:=X div LargeurCell[indexTCO] +1;
  Yclic:=Y div hauteurCell[indexTCO] +1;
  XclicCell[indexTCO]:=Xclic;
  YClicCell[indexTCO]:=Yclic;

  if not(verif_cellule(indexTCO,Xclic,Yclic,icone)) then exit;
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
  id_Quai : dessin_51(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  id_action : dessin_52(indexTCO,FormTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,0);
  end;
    
  stocke_undo(indexTCO,1,XClic,YClic);
  maj_undo(1);
  tco[indextco,XClic,YClic].BImage:=icone;
  tco[indextco,XClic,YClic].liaisons:=liaisons[icone];
  tco[indextco,xClic,YClic].CoulFonte:=clYellow;
  formTCO[indexTCO].EditAdrElement.Text:=IntToSTR( tco[indextco,XClic,YClic].Adresse);
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
    Affiche_TCO(indexTCO);
    TCO_modifie:=true;
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
// exemple : deux lignes qui se croisent renvoie un croisement
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
         if quadrant=2 then
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
         if quadrant=4 then
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
         if quadrant=3 then result:=1;
       end;

   2 : begin
         if quadrant=2 then
         begin
           if premier then result:=21;
           if dernier then result:=2;
           if not(premier) and not(dernier) then result:=21;
         end;
         if quadrant=3 then result:=2;
       end;
   3 : begin
         if quadrant=2 then
         begin
           if premier then result:=3;
           if dernier then result:=21;
           if not(premier) and not(dernier) then result:=21;
         end;
         if quadrant=3 then result:=3;
       end;
   4 : begin
         if quadrant=4 then
         begin
           if premier then result:=4;
           if dernier then result:=22;
           if not(premier) and not(dernier) then result:=22;
         end;
         if quadrant=3 then result:=4;
       end;
   5 : begin
         if quadrant=4 then
         begin
           if premier then result:=22;
           if dernier then result:=5;
           if not(premier) and not(dernier) then result:=22;
         end;
         if quadrant=3 then result:=5;
       end;
   6 : begin
         if quadrant=3 then
         begin
           if premier then result:=6;
           if dernier then result:=5;
           if not(premier) and not(dernier) then result:=5;
         end;
         if quadrant=4 then
         begin
           if premier then result:=12;
           if dernier then result:=6;
           if not(premier) and not(dernier) then result:=12;
         end;
       end;
   7 : begin
         if quadrant=3 then
         begin
           if premier then result:=3;
           if dernier then result:=7;
           if not(premier) and not(dernier) then result:=3;
         end;
         if quadrant=2 then
         begin
           if premier then result:=7;
           if dernier then result:=13;
           if not(premier) and not(dernier) then result:=13;
         end;
       end;
   8 : begin
         if quadrant=3 then
         begin
           if premier then result:=4;
           if dernier then result:=8;
           if not(premier) and not(dernier) then result:=4;
         end;
         if quadrant=4 then
         begin
           if premier then result:=8;
           if dernier then result:=14;
           if not(premier) and not(dernier) then result:=14;
         end;
       end;
   9 : begin
         if quadrant=3 then
         begin
           if premier then result:=9;
           if dernier then result:=2;
           if not(premier) and not(dernier) then result:=2;
         end;
         if quadrant=2 then
         begin
           if premier then result:=15;
           if dernier then result:=9;
           if not(premier) and not(dernier) then result:=15;
         end;
       end;
  10 : begin
         if quadrant=2 then result:=10;
         if quadrant=3 then
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
         if quadrant=5 then
         begin
           if premier then
           begin
             //       SO
             if testbit(tco[indextco,x-1,y+1].liaisons,2) then result:=32 else result:=17;
           end;
           if dernier then
           begin
              //       NE
             if testbit(tco[indextco,x+1,y-1].liaisons,6) then result:=34 else result:=18;
           end;
           if not(premier) and not(dernier) then result:=23;
         end;
       end;
  11 : begin
         if quadrant=1 then result:=19;
         if quadrant=3 then
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
         if quadrant=4 then result:=11;
         if quadrant=5 then
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
         if quadrant=4 then result:=12;
         if quadrant=3 then
         begin
           if dernier then result:=22;
           if premier then result:=12;
           if not(premier) and not(dernier) then result:=22;
         end;
       end;
  13 : begin
         if quadrant=2 then result:=13;
         if quadrant=3 then
         begin
           if dernier then result:=13;
           if premier then result:=21;
           if not(premier) and not(dernier) then result:=21;
         end;
       end;
  14 : begin
         if quadrant=4 then result:=14;
         if quadrant=3 then
         begin
           if dernier then result:=14;
           if premier then result:=22;
           if not(premier) and not(dernier) then result:=22;
         end;
       end;

  15 : begin
         if quadrant=2 then result:=15;
         if quadrant=3 then
         begin
           if dernier then result:=21;
           if premier then result:=15;
           if not(premier) and not(dernier) then result:=21;
         end;

       end;

  16 : begin
          if quadrant=4 then
          begin
            if premier then result:=29;
            if dernier then result:=16;
            if not(premier) and not(dernier) then result:=29;
          end;
          if quadrant=5 then
          begin
            if testbit(tco[indextco,x,y-1].liaisons,5) then result:=24 else result:=16;
          end;
       end;

  17 : begin
          if quadrant=2 then
          begin
            if premier then result:=17;
            if dernier then result:=32;
            if not(premier) and not(dernier) then result:=32;
          end;
          if quadrant=5 then
          begin
            if premier then result:=17;
            if dernier then result:=26;
            if not(premier) and not(dernier) then result:=26;
          end;
        end;

  18 : begin
          if quadrant=2 then result:=34;
          if quadrant=5 then
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
          if quadrant=4 then result:=19;
          if quadrant=5 then
          begin
            result:=28;
          end;
        end;

  20 : begin
          if (quadrant=2) then
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
          if quadrant=4 then
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
          if quadrant=5 then result:=20;
        end;
   21 : result:=21;
   22 : result:=22;
   23 : result:=23;
   24 : begin
          if quadrant=4 then
          begin
            if dernier then
            begin
              if testbit(tco[indextco,x+1,y+1].liaisons,0) then result:=25 ;
              if not(testbit(tco[indextco,x+1,y+1].liaisons,0)) then result:=24 ;
            end;
            if premier then result:=25;
            if not(premier) and not(dernier) then result:=25;
          end;
          if quadrant=5 then result:=24;
        end;
  25 : result:=25;
  26 : begin
         if quadrant=2 then
         begin
           if premier then result:=26;
           if dernier then result:=23;
           if not(premier) and not(dernier) then result:=23;
         end;
       end;

   27 : begin
         if quadrant=2 then
         begin
           if premier then result:=23;
           if dernier then result:=27;
           if not(premier) and not(dernier) then result:=23;
         end;
         if quadrant=5 then result:=27;
       end;

    28 : begin
         if quadrant=4 then
         begin
           if premier then result:=28;
           if dernier then
           begin
             if (testbit(tco[indextco,x,y-1].liaisons,5)) and (testbit(tco[indextco,x+1,y+1].liaisons,0))  and (testbit(tco[indextco,x,y+1].liaisons,1)) then result:=25 else result:=28;
           end;
           if not(premier) and not(dernier) then result:=25;
         end;
         if quadrant=5 then result:=28;
       end;
  29 : begin
         if quadrant=4 then result:=29;
         if quadrant=5 then
         begin
           if dernier then result:=25;
           if premier then result:=29;
           if not(premier) and not(dernier) then result:=25;
         end;
       end;
  32 : begin
         if quadrant=2 then result:=32;
         if quadrant=5 then
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
         if quadrant=1 then
         begin
           if premier then result:=32;
           if dernier then result:=25;
           if not(premier) and not(dernier) then result:=25;
         end;
         if quadrant=5 then
         begin
           if premier then result:=25;
           if dernier then result:=33;
           if not(premier) and not(dernier) then result:=25;
         end;
         if quadrant=4 then result:=33;
       end;
  34 : begin
         if quadrant=2 then result:=34;
         if quadrant=5 then
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


// évènement qui se produit quand on clique gauche ou droit
procedure TFormTCO.ImageTCOMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var position : Tpoint;
    indexTCO,i,n,adresse,Bimage,xt,yt,xf,yf,xclic,yclic : integer;
    s : string;
begin
  indexTCO:=index_tco(sender);
  GetCursorPos(Position);
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;
  YClic:=position.Y;
  // coordonnées grille
  Xclic:=Xclic div LargeurCell[indexTCO] + 1;
  Yclic:=Yclic div hauteurCell[indexTCO] + 1;
  XclicCell[indexTCO]:=Xclic;
  YclicCell[indexTCO]:=Yclic;

  if button=mbLeft then
  begin
    if affEvt then Affiche('TCO Souris clicG enfoncée',clYellow);
    if dbleClicTCO then begin dbleClicTCO:=false;exit;end;

    if not(clicSouris) then
    begin
      // front montant souris

    end;

    auto_tcurs:=true;
    clicsouris:=true;

    Bimage:=tco[indextco,xclic,yclic].BImage;
    // action
    if (Bimage=id_action) and not(ConfCellTCO) then
    begin
      i:=tco[indextco,xclic,yclic].piedfeu;
      n:=tco[indextco,xclic,yclic].feuoriente;
      if i=1 then Affiche_fenetre_TCO(n,true);  // affiche le TCO n°n
      if i=2 then with formprinc do             // afficher signaux complexes
      begin
        windowState:=wsNormal; //Maximized;
        show;
        BringToFront;
      end;
      if (i=3) and (CDMhd<>0) then
      begin                                     // afficher CDM rail
        ShowWindow(CDMhd,SW_MAXIMIZE);
        SetForegroundWindow(CDMhd);             // met CDM en premier plan
        SetActiveWindow(CdmHd);
      end;
      if i=4 then                               // action accessoire
      begin
        // pilotage impulsionnel
        pilote_acc(tco[indextco,xclic,yclic].Adresse,tco[indextco,xclic,yclic].sortie,AigP);
      end;
    end;

    TempoSouris:=2 ; // démarre la tempo souris

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
              Bimage:=replace(indexTCO,xt,yt,1,3,xt=traceXY[1].x,xt=traceXY[2].x);
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
                Bimage:=replace(indexTCO,xt,yt,20,5,yt=traceXY[1].y,yt=traceXY[2].y);
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
                  Bimage:=replace(indexTCO,xt,yt,11,4,xt=traceXY[1].x,xt=traceXY[2].x);
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
                  Bimage:=replace(indexTCO,xt,yt,10,2,xt=traceXY[1].x,xt=traceXY[2].x);
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

    // si clic souris en mode fenetre graphique: initialisation
    if (RadioGroupSel.ItemIndex=1) then
    begin
      if rect_select.NumTCO<>indexTCO then
      begin
        affiche_rectangle(rect_select.NumTCO,Rect_select);  // effacer sur l'autre tco
      end;
      if not(selectionAffichee[indexTCO]) then
      begin
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
      end;
    end
    else
    begin
      xMiniSel:=99999;yMiniSel:=99999;
      xMaxiSel:=0;yMaxiSel:=0;

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
      if IsAigTCO(Bimage) then
      begin
        adresse:=tco[IndexTCO,xClic,yClic].Adresse;
        if adresse=0 then  s:='Aiguillage sans adresse'
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

    if not(selectionaffichee[indexTCO]) then _entoure_cell_clic(indexTCO);
    actualise(indexTCO);    // actualise la fenetre de config cellule
    end;

    clicTCO:=false;
  end;

  if button=mbRight then
  begin
    if affEvt then Affiche('TCO Souris clicD enfoncée',clLime);
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
    EditAdrElement.Text:=IntToSTR(tco[indextco,XClicCellInserer,YClicCellInserer].Adresse);
    EditTypeImage.Text:=IntToSTR(tco[indextco,XClicCellInserer,YClicCellInserer].Bimage);
  end;
end;


procedure TFormTCO.ImageTCOMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
var r : Trect;
    indexTCO,xMiniSelP,yMiniSelP,xMaxiSelP,yMaxiSelP : integer;
    ok : boolean;
begin
  if affevt then Affiche('ImageTCOMouseMove',clLime);
  if dbleClicTCO then begin dbleClicTCO:=false;exit;end;
  //Affiche(IntToSTR(tempoSouris),clred);
  indexTCO:=index_tco(sender);

  // exécuté uniquement si souris enfoncée et changement position souris
  if (radioGroupSel.ItemIndex=1) and ((ax<>x) or (ay<>y)) and selectionAffichee[indexTCO] then
  begin
    //Affiche(IntToSTR(tick),clred);
    Accroche_Rectangle_selection(indexTCO,x,y);
    exit;
  end;

  if Temposouris>0 then exit;
  // Affiche('*',cllime);
  //affiche(intToSTR(y),clorange);
  cellX:=x div LargeurCell[indexTCO]+1;     // variables globales
  cellY:=y div hauteurCell[indexTCO]+1;

  if (AncienXClicCell=CellX) and (AncienYClicCell=CellY) then exit;

  PimageTCO[indexTCO].Hint:='';
  AncienXClicCell:=CellX;
  AncienYClicCell:=CellY;

  //Affiche('cellX='+IntToSTR(Cellx)+' cellY='+intToSTR(cellY),clyellow);

  if CellX>NbreCellX[indexTCO] then exit;
  if CellY>NbreCellY[indexTCO] then exit;

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

  // zone de sélection bleue en coordonnées souris
  xMiniSel:=(XclicCell[indexTCO]-1)*LargeurCell[indexTCO];
  yMiniSel:=(YclicCell[indexTCO]-1)*hauteurCell[indexTCO];
  xMaxiSel:=(cellX-1)*LargeurCell[indexTCO];
  yMaxiSel:=(cellY-1)*hauteurCell[indexTCO];

  xminiSelP:=min(xminiSel,xMaxiSel);
  yminiSelP:=min(yminiSel,yMaxiSel);
  xmaxiSelP:=max(xminiSel,xMaxiSel);
  ymaxiSelP:=max(yminiSel,yMaxiSel);

  xminiSel:=xMiniSelP;
  yminiSel:=yMiniSelP;
  xMaxiSel:=xMaxiSelP;
  yMaxiSel:=yMaxiSelP;

  //Affiche('xMiniSel='+IntToSTR(xMiniSel)+' yMiniSel='+IntToSTR(yMiniSel)+' xMaxiSel='+IntToSTR(xMaxiSel)+' yMaxiSel='+IntToSTR(yMaxiSel),clOrange);
  //Affiche('XclicCell='+intToSTR(XclicCell[indexTCO])+' YclicCell='+intToSTR(XclicCell[indexTCO]),clorange);

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

  r:=Rect(xminiSel+1,YminiSel+1,XmaxiSel+LargeurCell[indexTCO],yMaxiSel+hauteurCell[indexTCO]);

  Rancien:=r;
  Affiche_selection(indexTCO);

  SelectionAffichee[indexTCO]:=true;
  //Affiche('Sélection affichée',clLime);
  if entoure[indexTCO] then begin Entoure_cell(indexTCO,Xentoure[indexTCO],Yentoure[indexTCO]);entoure[indexTCO]:=false;end; // efface
end;

procedure TFormTCO.ImageTCOMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if affevt then Affiche('Souris clic relachée',clyellow);
  clicsouris:=false;
  
  prise_droit:=false;
  prise_gauche:=false;
  prise_bas:=false;
  prise_haut:=false;
  prise_NE:=false;
  prise_SO:=false;
  prise_SE:=false;
  prise_NO:=false;
  prise_N:=false;
end;

procedure TFormTCO.ButtonRedessineClick(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=index_TCO(sender);
  Affiche_TCO(indexTCO);
end;

// changement de l'adresse d'un élément
procedure TFormTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index,indexTCO : integer;
    s: string;
begin
  //Affiche('Chgt adresse',clyellow);
  if clicTCO or ConfCellTCO then exit;
  clicTCO:=true;
  auto_tcurs:=false;  // interdit le déplacement du curseur encadré du TCO (pour que les touches curseur s'applique au Tedit)
  indexTCO:=index_TCO(sender);
  s:=formTCO[indexTCO].EditAdrElement.Text;
  if length(s)>1 then
  begin
    if (s[1]='A') or (s[1]='a') then delete(s,1,1);  
    EditAdrElement.Text:=s;
  end;

  Val(s,Adr,erreur);
  if erreur<>0 then exit;
  if (Adr<0) or (Adr>2048) then Adr:=0;
  clicTCO:=false;

  if Adr=0 then tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].repr:=2;

  efface_entoure(indexTCO);
  tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Adresse:=Adr;
  //formConfCellTCO.editAdrElement.Text:=intToSTR(Adr);
  tco_Modifie:=true;

  // si signal
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].BImage=Id_signal then
  begin
    index:=Index_Signal(adr);
    if index=0 then exit
    else
      begin
       //Affiche('Signal '+intToSTR(Adr),clyellow);
       affiche_tco(indexTCO);
     end;
  end;

  Affiche_cellule(indexTCO,XclicCell[indexTCO],YclicCell[indexTCO]);
end;


// mise à jour des cellules de l'adresse "adresse"
procedure Maj_TCO(indexTCO,Adresse : integer);
var x,y: integer;
begin
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        if tco[indextco,x,y].Adresse=Adresse then
        begin
          affiche_cellule(indexTCO,x,y);
          entoure_cell_grille(indexTCO,x,y);
        end;
      end;
end;

// mise à jour des aiguillages
procedure Maj_Aig_TCO(indexTCO :integer);
var x,y: integer;
begin
  for y:=1 to NbreCellY[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do
      begin
        if IsAigTCO(tco[indextco,x,y].Bimage) then
        begin
          affiche_cellule(indexTCO,x,y);
        end;
      end;
end;

// affiche les cellules des tco dont l'adresse d'aiguillage est adresse
Procedure Texte_aig_fond(adresse : integer);
var ntco,x,y,Bim : integer;
begin
  for ntco:=1 to NbreTCO do
  begin
    // trouver les cellules comportant l'aiguillage adresse
    for y:=1 to NbreCellY[ntco] do
      for x:=1 to NbreCellX[ntco] do
      begin
        Bim:=TCO[ntco,x,y].BImage;
        if IsAigTCO(Bim) then
        begin
          if TCO[ntco,x,y].Adresse=adresse then
          begin
            affiche_cellule(ntco,x,y);
          end;
        end;
      end;
  end;
end;

procedure TFormTCO.Button1Click(Sender: TObject);
begin
  Detecteur[569].etat:=true;
  Maj_tco(index_TCO(sender),569);
end;

procedure TFormTCO.Button2Click(Sender: TObject);
begin
  Detecteur[569].etat:=false;
  Maj_tco(index_TCO(sender),569);
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

procedure TFormTCO.ImagePalette50EndDrag(Sender, Target: TObject; X, Y: Integer);
var indexTCO,Xclic,Yclic : integer;
begin
  if not(Target is TImage) then exit;
  if (x=0) and (y=0) then exit;
  indexTCO:=index_TCO(sender);
  xclic:=xclicCell[indexTCO];
  yclic:=yclicCell[indexTCO];

  BitBlt(formTCO[indexTCO].imageTCO.canvas.handle,oldx,oldy,LargeurCell[indexTCO],hauteurCell[indexTCO],oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure(indexTCO);
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  Xclic:=Xclic div LargeurCell[indexTCO] +1;
  Yclic:=Yclic div hauteurCell[indexTCO] +1;
  stocke_undo(indexTCO,1,XClic,YClic);
  maj_undo(1);
  efface_cellule(indexTCO,formTCO[indexTCO].ImageTCO.Canvas,XClic,YClic,PmCopy);
  raz_cellule(indextco,xClic,yClic);
  tco[indextco,XClic,YClic].BImage:=Id_signal;
  tco[indextco,XClic,YClic].FeuOriente:=1;
  tco[indextco,XClic,YClic].PiedFeu:=1;
  tco[indextco,XClic,YClic].coulFonte:=clWhite;
  // ne pas convertir l'adresse sinon evt changement du composant et on écrase l'aspect EditAdrElement.Text:=IntToSTR( tco[indextco,XClicCell,YClicCell].Adresse);
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
  drag:=true;
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

procedure vertical_180(indexTCO : integer);
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
  vertical_180(index_tco(c));
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
  zone_tco(1,518,514,1,1);
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
  if IsAIgTCO(Bimage) then
  begin
    tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].inverse:=CheckPinv.checked;
    TCO_modifie:=true;
  end;
end;

procedure TFormTCO.ButtonMasquerClick(Sender: TObject);
begin
  Panel1.Hide;
  ScrollBox.Height:=ClientHeight-32;
  BandeauMasque:=true;
  defocusControl(ButtonMasquer,true);
end;

procedure TFormTCO.ImageTCODblClick(Sender: TObject);
var Bimage,Adresse,i,indextco : integer;
    tjdC : boolean;
begin
  if affEvt then Affiche('Double clic',clYellow);
  clicsouris:=false;
  auto_tcurs:=true;  // autorise le déplacement du des touches curseur encadré du TCO
  indexTCO:=index_TCO(sender);
  Bimage:=tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].BImage;
  Adresse:=tco[indextco,xClicCell[indexTCO],yClicCell[indexTCO]].Adresse;
  if adresse=0 then exit;

  // double clic sur détecteur : inversion
  if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and (adresse<>0) then
  begin
    if EvtClicDet then event_detecteur(adresse,not(detecteur[adresse].etat),'')
    else detecteur[adresse].etat:=not(detecteur[adresse].etat);
    Maj_TCO(indexTCO,Adresse)
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
  if isAigTCO(Bimage) or TJDc then
  begin
    aiguille:=Adresse;
    i:=Index_aig(Adresse);
    if i=0 then
    begin
      Affiche('Aiguillage '+intToSTR(adresse)+' non configuré pour pilotage',clOrange);
      exit;
    end;

    TformAig.create(nil);

    formAig.showmodal;
    formAig.close;
    piloteAig:=true;
  end;

  // commande de signal
  if Bimage=Id_signal then
  begin
    AdrPilote:=adresse;
    i:=Index_Signal(adresse);
    if i=0 then exit;
    TFormPilote.Create(Self);
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

      if (Signaux[i].aspect>10) and (Signaux[i].aspect<20) then
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
  clicsouris:=false;
  dbleClicTCO:=true;
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
  end_drag(51,x,y,sender,target);
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

procedure TFormTCO.Panel1DragOver(Sender, Source: TObject; X, Y: Integer;
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
    tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].PiedFeu:=2;
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
    tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].PiedFeu:=1;
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
var oriente,piedFeu,indexTCO : integer;
    c : Tcomponent;
begin
  if affevt then Affiche('on popup',clyellow);

  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);

  PopUpMenu1.Items[9][0].Caption:='Ligne au dessus de la '+intToSTR(YclicCell[indexTCO]);
  PopUpMenu1.Items[9][1].Caption:='Ligne en dessous de la '+intToSTR(YclicCell[indexTCO]);
  PopUpMenu1.Items[9][3].Caption:='Colonne à gauche de la '+intToSTR(XclicCell[indexTCO]);
  PopUpMenu1.Items[9][4].Caption:='Colonne à droite de la '+intToSTR(XclicCell[indexTCO]);

  PopUpMenu1.Items[10][0].Caption:='Ligne '+intToSTR(YclicCell[indexTCO]);
  PopUpMenu1.Items[10][1].Caption:='Colonne '+intToSTR(XclicCell[indexTCO]);

  // grise ou non l'entrée signal du menu
  if tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].Bimage=Id_signal then
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
    PiedFeu:=tco[indextco,XClicCell[indexTCO],YClicCell[indexTCO]].PiedFeu;
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


procedure TFormTCO.LigneDessusClick(Sender: TObject);
var x,y,indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellY[indexTCO]>=MaxCellY then exit;
  TamponAffecte:=false;
  init_tampon_copiercoller;

  for y:=NbreCellY[indexTCO]-1 downto YClicCell[indexTCO] do
    for x:=1 to NbreCellX[indexTCO] do tco[indextco,x,y+1]:=tco[indextco,x,y];

  for x:=1 to NbreCellX[indexTCO] do
  begin
    raz_cellule(indextco,x,YClicCell[indexTCO]);
  end;
  inc(NbreCellY[indexTCO]);
  affiche_TCO(indexTCO);
end;

procedure TFormTCO.LigneDessousClick(Sender: TObject);
var x,y,indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellY[indexTCO]>=MaxCellY then exit;
  TamponAffecte:=false;
  init_tampon_copiercoller;

  for y:=NbreCellY[indexTCO] downto YClicCell[indexTCO]+1 do
  begin
    for x:=1 to NbreCellX[indexTCO] do tco[indextco,x,y+1]:=tco[indextco,x,y];
  end;
  for x:=1 to NbreCellX[indexTCO] do
  begin
    raz_cellule(indextco,x,YClicCell[indexTCO]);
  end;
  inc(NbreCellY[indexTCO]);
  affiche_TCO(indexTCO);
end;

procedure TFormTCO.SupprimeLigneClick(Sender: TObject);
var x,y,indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellY[indexTCO]<=1 then exit;
  TamponAffecte:=false;
  // tampon de sauvegarde
  TamponTCO_org.numTCO:=indexTCO;
  TamponTCO_Org.NbreCellX:=NbreCellX[indexTCO];
  TamponTCO_Org.NbreCellY:=NbreCellY[indexTCO];
  TamponTCO_Org.x1:=1;
  TamponTCO_Org.x2:=NbreCellX[indexTCO];
  TamponTCO_Org.y1:=YClicCell[indexTCO];
  TamponTCO_Org.y2:=YClicCell[indexTCO];
  xcoupe:=1;ycoupe:=1;
  for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
    for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      begin
        //Affiche(intToSTR(x)+' '+intToSTR(y),clyellow);
        tampontco[x,y]:=tco[indextco,x,y];
      end;                       
  TamponAffecte:=true;


  // supression ligne
  for y:=YClicCell[indexTCO] to NbreCellY[indexTCO]-1 do
  begin
    for x:=1 to NbreCellX[indexTCO] do tco[indextco,x,y]:=tco[indextco,x,y+1];
  end;
  for x:=1 to NbreCellX[indexTCO] do
  begin
    raz_cellule(indextco,x,NbreCellY[indexTCO]);
    tco[indextco,x,NbreCellY[indexTCO]].Couleurfond:=Clfond[IndexTCO];
  end;
  dec(NbreCellY[indexTCO]);

  affiche_TCO(indexTCO);
end;

procedure TFormTCO.Colonnegauche1Click(Sender: TObject);
  var x,y,indexTCO : integer;
  c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellX[indexTCO]>=MaxCellX then exit;
  TamponAffecte:=false;
  init_tampon_copiercoller;

  for x:=NbreCellX[indexTCO] downto XClicCell[indexTCO] do
  begin
    for y:=1 to NbreCellY[indexTCO] do tco[indextco,x+1,y]:=tco[indextco,x,y];
  end;
  for y:=1 to NbreCellY[indexTCO] do
  begin
    raz_cellule(indextco,XClicCell[indexTCO],y);
    tco[indextco,XClicCell[indexTCO],y].Couleurfond:=Clfond[IndexTCO];
  end;
  inc(NbreCellX[indexTCO]);
  affiche_TCO(indexTCO);
end;

procedure TFormTCO.Colonnedroite1Click(Sender: TObject);
  var x,y,indexTCO : integer;
  c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellX[indexTCO]>=MaxCellX then exit;
  TamponAffecte:=false;

  init_tampon_copiercoller;

  for x:=NbreCellX[indexTCO] downto XClicCell[indexTCO]+1 do
  begin
    for y:=1 to NbreCellY[indexTCO] do tco[indextco,x+1,y]:=tco[indextco,x,y];
  end;
  for y:=1 to NbreCellY[indexTCO] do
  begin
    raz_cellule(indextco,XClicCell[indexTCO]+1,y);
    tco[indextco,XClicCell[indexTCO]+1,y].Couleurfond:=Clfond[IndexTCO];
  end;
  inc(NbreCellX[indexTCO]);
  affiche_TCO(indexTCO);
end;

// suppression colonne
procedure TFormTCO.ColonneClick(Sender: TObject);
var x,y,indexTCO : integer;
    c : tcomponent;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  if NbreCellX[indexTCO]<=1 then exit;
  TamponAffecte:=false;
  // tampon de sauvegarde
  TamponTCO_Org.NbreCellX:=NbreCellX[indexTCO];
  TamponTCO_Org.NbreCellY:=NbreCellY[indexTCO];
  TamponTCO_Org.x1:=xClicCell[indexTCO];
  TamponTCO_Org.x2:=xClicCell[indexTCO];
  TamponTCO_Org.y1:=1;
  TamponTCO_Org.y2:=NbreCellY[indexTCO];
  xcoupe:=1;ycoupe:=1;
  for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
    for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      tampontco[x,y]:=tco[indextco,x,y];
  TamponAffecte:=true;

  // supression colonne
  for x:=xClicCell[indexTCO] to NbreCellx[indexTCO]-1 do
  begin
    for y:=1 to NbreCelly[indexTCO] do
    begin
      tco[indextco,x,y]:=tco[indextco,x+1,y];
    end;
  end;
  for y:=1 to NbreCellY[indexTCO] do
  begin
    raz_cellule(indextco,NbreCellx[indexTCO],y);
    tco[indextco,NbreCellx[indexTCO],y].CouleurFond:=Clfond[IndexTCO];
  end;
  dec(NbreCellX[indexTCO]);

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
  }
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
end;

procedure change_couleur_fond(indexTCO : integer);
var cs : string;
    x,y,xmini,ymini,xmaxi,ymaxi : integer;
    modeselection : boolean;
begin
  xmini:=(XminiSel div LargeurCell[indexTCO]) +1;
  ymini:=(YminiSel div hauteurCell[indexTCO]) +1;
  xmaxi:=(XmaxiSel div LargeurCell[indexTCO]) +1;
  ymaxi:=(YmaxiSel div hauteurCell[indexTCO]) +1;
  modeSelection:=xmini<xmaxi;

  if modeSelection then
  begin
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
      if modeSelection then
      begin
        selectionaffichee[indexTCO]:=false;
        for y:=Ymini to Ymaxi do
          for x:=Xmini to Xmaxi do
            tco[indextco,x,y].CouleurFond:=ColorDialog1.Color;
      end
      else tco[indextco,XclicCell[indexTCO],YclicCell[indexTCO]].CouleurFond:=ColorDialog1.Color;

      ShapeCoulFond.Brush.Color:=ColorDialog1.Color;

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

procedure TFormTCO.Toutslectionner1Click(Sender: TObject);
var c: tcomponent;
    indextco : integer;
begin
  c:=popupmenu1.PopupComponent ;     // imageTCO
  c:=c.GetParentComponent;           // scrollBox
  c:=c.GetParentComponent;           // formTCO
  indexTCO:=index_tco(c);
  xminiSel:=0;
  yminiSel:=0;
  xMaxiSel:=(NbreCellX[indexTCO]-1)*LargeurCell[indexTCO];
  yMaxiSel:=(NbreCellY[indexTCO]-1)*hauteurCell[indexTCO];
  rAncien:=rect(xminiSel,YminiSel,xmaxiSel+LargeurCell[indexTCO],YMaxiSel+hauteurCell[indexTCO]);

  SelectionAffichee[indexTCO]:=true;
  with formTCO[indexTCO].imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille[IndexTCO];
    Brush.Color:=clblue;
    Rectangle(rAncien);
  end;
end;

procedure dessinerTCO(indexTCO : integer);
begin
  if not(modetrace[indexTCO]) then
  begin
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
  auto_tcurs:=false;
end;


procedure TFormTCO.ImagePalette52DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette52EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  end_drag(id_action,x,y,sender,target);
end;

procedure TFormTCO.ImagePalette52MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette52);
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
    // si le rectangle est affiché dans ce tco, l'effacer
    if Rect_select.NumTCO=indexTCO then affiche_rectangle(IndexTCO,Rect_select);
    Rect_select.NumTCO:=0;
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

function TformTCO.index_TCOMainMenu : integer;
var t : Tcontrol;
    s : string;
begin
  t:=FindControl(mainmenuTCO.WindowHandle);  // on ne peut pas remonter au parent d'un mainmenu avec getparentcomponent
  s:=t.name;
  result:=extract_int(s);
end;

procedure TFormTCO.SauvegarderleTCO1Click(Sender: TObject);
begin
  sauve_fichiers_tco;
end;

procedure TFormTCO.DessinerleTCO1Click(Sender: TObject);
var indexTCO : integer;

begin
  indexTCO:=index_TCOMainMenu;
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

procedure TFormTCO.Affichebandeau1Click(Sender: TObject);
var indexTCO : integer;
begin
  indexTCO:=index_TCOMainMenu;
  Panel1.Show;
  positionne(indexTCO);
  BandeauMasque:=false;
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

end.

