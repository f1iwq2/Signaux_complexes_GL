unit UnitTCO;
// na pas utiliser les éléments 30 et 31 qui sont les anciens signaux et quais
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote, UnitDebug,
  ComCtrls ,StrUtils, math, unitconfig, UnitAnalyseSegCDM,  Buttons , verif_version ;

type
  TFormTCO = class(TForm)
    LabelCoord: TLabel;
    LabelCellule: TLabel;
    PopupMenu1: TPopupMenu;
    MenuCouper: TMenuItem;
    N1: TMenuItem;
    MenuCopier: TMenuItem;
    MenuColler: TMenuItem;
    ScrollBox: TScrollBox;
    ImageTCO: TImage;
    Tourner90G: TMenuItem;
    Tourner90D: TMenuItem;
    SourisX: TLabel;
    SourisY: TLabel;
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
    ButtonRedessine: TButton;
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
    ButtonAfficheBandeau: TButton;
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
    outslectionner1: TMenuItem;
    ButtonDessiner: TButton;
    ButtonTrajet: TButton;
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
    procedure Maj_TCO(Adresse : integer);
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
    procedure ButtonAfficheBandeauClick(Sender: TObject);
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
    procedure outslectionner1Click(Sender: TObject);
    procedure ButtonDessinerClick(Sender: TObject);
    procedure ButtonTrajetClick(Sender: TObject);
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

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  licone=35;
  hicone=35;
  maxUndo=30;
  ZoomMax=50;ZoomMin=15;
  MaxCellX=150;MaxCellY=70;
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
  AvecGrille_ch='AvecGrille';
  ModeCouleurCanton_ch='ModeCouleurCanton';
  Graphisme_ch='Graphisme';
  // liaisons des voies pour chaque icone par bit (0=NO 1=Nord 2=NE 3=Est 4=SE 5=S 6=SO 7=Ouest)
  Liaisons : array[0..51] of integer=
     //   1   2   3   4   5  6   7  8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27 28  29 30 31
     (0,$88,$c8,$8c,$98,$89,$9,$84,$90,$48,$44,$11,$19,$c4,$91,$4c,$21,$24,$42,$12,$22,$cc,$99,$66,$23,$33,$26,$62,$32,$31,0,0,
     // 32  33  34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51
       $62,$13,$46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ;
type
  // structure du TCO
  TTCO = record
           Adresse     : integer;     // adresse du détecteur ou de l'aiguillage ou du feu
           BImage      : integer;     // 0=rien 1=voie 2=aiguillage gauche gauche ... 50=feu
           mode        : integer;     // couleur de voie 0=éteint 1=ClVoies 2=couleur en fonction du train
           trajet      : integer;     // décrit le trajet ouvert sur la voie (cas d'un croisement ou d'une tjd/S)
           inverse     : boolean;     // aiguillage piloté inversé
           repr        : integer;     // position de la représentation texte 0 = rien 1=centrale 2=Haut  3=Bas
           Texte       : string;      // texte de la cellule
           Fonte       : string;      // fonte du texte
           FontStyle   : string;      // GSIB  (Gras Souligné Italique Barré)
           coulFonte   : Tcolor;
           TailleFonte : integer;
           CouleurFond : Tcolor;      // couleur de fond
           // pour les signaux seulement
           PiedFeu     : integer;     // type de pied au signal : signal à gauche=1 ou à droite=2 de la voie
           x,y         : integer;     // coordonnées pixels relativés du coin sup gauche du signal pour le décalage par rapport au 0,0 cellule
           Xundo,Yundo : integer;     // coordonnées x,y de la cellule pour le undo
           FeuOriente  : integer;     // orientation du signal : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit
           liaisons    : integer;     // quadrants des liaisons
         end;

var
  clAllume,clVoies,clFond,couleurAdresse,clGrille,cltexte,clQuai,CoulFonte,ClCanton,clPiedSignal : Tcolor;

  FormTCO: TFormTCO;

  Forminit,SelectionAffichee,TamponAffecte,entoure,TCO_modifie,clicsouris,
  clicTCO,piloteAig,BandeauMasque,eval_format,sauve_tco,formConfCellTCOAff,
  drag,TCOActive,TCOCree,modeTrace,ancienok,dbleClicTCO,auto_tcurs : boolean;

  HtImageTCO,LargImageTCO,XclicCell,YclicCell,XminiSel,YminiSel,XCoupe,Ycoupe,Temposouris,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel ,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,Xentoure,Yentoure,RatioC,ModeCouleurCanton,
  AncienXClicCell,AncienYClicCell,LargeurCell,HauteurCell,NbreCellX,NbreCellY,NbCellulesTCO,
  Epaisseur,oldX,oldY,offsetSourisY,offsetSourisX,AvecVerifIconesTCO,indexTrace,
  largeurCelld2,HauteurCelld2,ancienTraceX,ancienTraceY,rangUndo : integer;

  titre_Fonte : string;

  TamponTCO,tco : array of array of TTco ;

  Undo : array[1..MaxUndo] of record
           nombre : integer;
           element : array[1..100] of TTCO ;
         end;

  // pour copier coller
  TamponTCO_Org : record
                   x1,y1,x2,y2,NbreCellX,NbreCellY : integer;
                 end;
  routeTCO : array[1..500] of record
      x,y : integer;
    end;

  // tracé
  traceXY : Array[1..50] of record x,y : integer; // en coordonnées grille
            end;

  rAncien : TRect;
  PCanvasTCO : Tcanvas;
  PBitMapTCO,VBm,OldBmp : TBitMap;
  PScrollBoxTCO : TScrollBox;
  PImageTCO,PImageTemp : Timage;
  frXGlob,frYGlob : real;

procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
procedure calcul_cellules;
procedure sauve_fichier_tco;
procedure zone_TCO(det1,det2,mode: integer);
procedure efface_entoure;
procedure affiche_TCO;
procedure affiche_cellule(x,y : integer);
procedure _entoure_cell_clic;
procedure affiche_texte(x,y : integer);
procedure change_fonte;
procedure Tourne90G;
procedure Tourne90D;
procedure Vertical;
procedure signalG;
procedure signalD;
procedure lire_fichier_tco;
procedure grise_ligne_tco;
procedure change_couleur_fond;
function verif_cellule(x,y,Bim : integer) : boolean;
procedure dessine_icones;
procedure echange(var a,b : integer);
procedure Efface_Cellule(Canvas : Tcanvas;x,y : integer;Mode : TPenMode);

implementation

uses UnitConfigTCO, Unit_Pilote_aig, UnitConfigCellTCO;

{$R *.dfm}

procedure lire_fichier_tco;
var fichier : textfile;
    s,sa : string;
    nv,x,y,i,j,m,adresse,valeur,erreur,FeuOriente,PiedFeu,tailleFont,e,NPar : integer;
    trouve_CoulFond,trouve_clVoies,trouve_clAllume,trouve_clGrille,trouve_clCanton,
    trouve_clTexte,trouve_clQuai,trouve_matrice,trouve_ratio,trouve_ModeCanton,
    trouve_AvecGrille,trouve_clPiedSignal : boolean;
    function lit_ligne : string ;
    var c : char;
    begin
      repeat
        readln(fichier,s);
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
    assign(fichier,'tco.cfg');
    reset(fichier);
  except
    Affiche('Nouveau tco',clyellow);
    NbreCellX:=35;NbreCellY:=20;LargeurCell:=35;HauteurCell:=35;
    largeurCelld2:=largeurCell div 2;HauteurCelld2:=HauteurCell div 2;
    RatioC:=10;
    ClFond:=$000040;
    ClVoies:=$0077FF;
    ClAllume:=$00FFFF;
    ClGrille:=$404040;
    ClTexte:=$00FF00;
    ClQuai:=$808080;
    clPiedSignal:=$4080FF;
    ClCanton:=$00FFFF;
    AvecGrille:=true;
    Graphisme:=1;
    SetLength(TCO,NbreCellX+1,NbreCellY+1);
    SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);
    for x:=1 to NbreCellX do
      for y:=1 to NbreCellY do
        with tco[x,y] do
        begin
          CouleurFond:=clfond;
          Adresse:=0;
          Bimage:=0;
          repr:=0;
          Texte:='';
          fonte:='';
          fontSTyle:='';
          piedFeu:=0;
          x:=0;
          y:=0;
          FeuOriente:=0;
          Liaisons:=0;
        end;
    exit;
  end;
  {$I-}
  x:=1;y:=1;NbreCellX:=0;NbreCellY:=0; RatioC:=10;
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
  AvecGrille:=true;
  clCanton:=ClYellow;

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
      clfond:=i;
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
      clVoies:=i;
    end;

    sa:=uppercase(clAllume_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clAllume:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clAllume:=i;
    end;

    sa:=uppercase(clGrille_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clGrille:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clGrille:=i;
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
      clQuai:=i;
    end;

    sa:=uppercase(clPiedSignal_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clPiedSignal:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      clPiedSignal:=i;
    end;

    sa:=uppercase(ClCanton_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_clCanton:=true;
      delete(s,i,length(sa));
      val('$'+s,i,erreur);
      ClCanton:=i;
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

    sa:=uppercase(AvecGrille_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_AvecGrille:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      AvecGrille:=i=1;
    end;
    //----------------------------------------------------------------

    // taille de la matrice
    sa:=uppercase(Matrice_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_matrice:=true;
      delete(s,i,length(sa));
      val(s,NbreCellX,erreur);
      i:=pos(',',s);delete(s,1,i);
      Val(s,NbreCellY,erreur)
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

  until (pos('[MATRICE]',uppercase(s))<>0) or (eof(fichier));

  NbCellulesTCO:=NbreCellX*NbreCellY;

  if (NbreCellX<20) or (NbreCellX>MaxCellX) then
  begin
    NbreCellX:=MaxCellX;
    Affiche('TCO: le nombre de cellules X a été ramené à '+intToSTR(NbreCellX),clred);
  end;
  if (NbreCellY<5) or (NbreCellY>MaxCellY) then
  begin
    NbreCellY:=MaxCellY;
    Affiche('TCO: le nombre de cellules Y a été ramené à '+intToSTR(NbreCellX),clred);
  end;

  try
    SetLength(TCO,NbreCellX+1,NbreCellY+1);
  except
    Affiche('TCO:Mémoire insuffisante pour'+intToSTR(NbreCellX)+' '+intToSTR(NbreCellY),clred);
    NbreCellX:=20;NbreCellY:=12;
    SetLength(TCO,NbreCellX+1,NbreCellY+1);
  end;

  try
    SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);
  except
    Affiche('TamponTCO:Mémoire insuffisante',clred);
    NbreCellX:=20;NbreCellY:=12;
    SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);
  end;


  // lire la matrice
  while not eof(fichier) do
  begin
    s:=lit_ligne;
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

        if npar<>13 then sauve_tco:=true;

        // 1 couleur de fond
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO2',clred);closefile(fichier);exit;end;
        val('$'+copy(s,1,i-1),CoulFonte,erreur);
        if erreur<>0 then begin Affiche('ETCO3',clred);closefile(fichier);exit;end;
        if coulFonte=0 then
        begin coulFonte:=clfond;sauve_tco:=true;end;
        tco[x,y].CouleurFond:=coulFonte;
        delete(s,1,i);

        // 2 Adresse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO4',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),adresse,erreur);
        if erreur<>0 then begin Affiche('ETCO5',clred);closefile(fichier);exit;end;
        tco[x,y].adresse:=adresse;
        delete(s,1,i);

        //3 Bimage
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO6',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO7',clred);closefile(fichier);exit;end;
        if valeur=30 then begin valeur:=50;sauve_tco:=true;end;
        if valeur=31 then begin valeur:=51;sauve_tco:=true;end;
        tco[x,y].Bimage:=valeur;
        tco[x,y].liaisons:=liaisons[valeur];
        delete(s,1,i);

        //4 Inverse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO8',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO9',clred);closefile(fichier);exit;end;
        tco[x,y].inverse:=valeur=1;
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
        if tco[x,y].Bimage=50 then
        begin
          i:=Index_Signal(adresse);
          if i<>0 then
          begin
            //Affiche('Feu '+IntToSTR(Adresse)+' aspect='+intToSTR(aspect),clyellow);
            if FeuOriente<1 then FeuOriente:=1;
            if FeuOriente>3 then FeuOriente:=3;
            tco[x,y].FeuOriente:=FeuOriente;
            tco[x,y].x:=0;
            tco[x,y].y:=0;

            if PiedFeu<1 then PiedFeu:=1;
            if PiedFeu>2 then PiedFeu:=2;
            TCO[x,y].PiedFeu:=PiedFeu;
          end;
        end;

        // 7 texte optionnel
        j:=pos(')',s);
        i:=pos(',',s);
        tco[x,y].Texte:='';
        if j>1 then // le , est avant le ) donc il y a un texte
        begin
          if j<i then m:=j else m:=i;
          tco[x,y].Texte:=copy(s,1,m-1) ;
          delete(s,1,m-1);
        end;

        // 8 représentation
        if s[1]=',' then delete(s,1,1);
        val(s,j,erreur);
        tco[x,y].repr:=j;
        delete(s,1,erreur-1);

        // 9 fonte
        if s[1]=',' then delete(s,1,1);
        i:=pos(',',s);
        tco[x,y].fonte:=copy(s,1,i-1);
          //Affiche(fonte,clyellow);
        Delete(s,1,i);

        // 10 taille fonte
        Val(s,taillefont,erreur);
        tco[x,y].TailleFonte:=taillefont;
        delete(s,1,erreur);

        // 11 couleur fonte
        i:=pos(',',s);
        val('$'+s,coulFonte,erreur);
        tco[x,y].coulFonte:=coulFonte;
        delete(s,1,i);

        //12 style
        if (s[1]<>')') and (s[1]<>',') then
        begin
          // style GISB
          i:=pos(')',s); j:=pos(',',s);
          if j<i then i:=j;
          tco[x,y].fontstyle:=copy(s,1,i-1);
          delete(s,1,i-1);    //ne pas supprimer la virgule
        end;

        if npar=13 then
        begin
          delete(s,1,1); // supprimer la virgule
          val(s,i,erreur);
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

procedure sauve_fichier_tco;
var fichier : textfile;
    s : string;
    couleurFonte : Tcolor;
    x,y : integer;
begin
  AssignFile(fichier,'tco.cfg');
  rewrite(fichier);
  Writeln(fichier,'/ Définitions TCO version '+version+sousversion);
  Writeln(fichier,clFond_ch+'='+IntToHex(clfond,6));
  Writeln(fichier,clVoies_ch+'='+IntToHex(ClVoies,6));
  Writeln(fichier,clAllume_ch+'='+IntToHex(ClAllume,6));
  Writeln(fichier,clGrille_ch+'='+IntToHex(ClGrille,6));
  Writeln(fichier,clTexte_ch+'='+IntToHex(ClTexte,6));
  Writeln(fichier,clQuai_ch+'='+IntToHex(ClQuai,6));
  Writeln(fichier,clPiedSignal_ch+'='+intToHex(clPiedSignal,6));
  Writeln(fichier,ClCanton_ch+'='+IntToHex(ClCanton,6));
  Writeln(fichier,ModeCouleurCanton_ch+'='+intToSTR(ModeCouleurCanton));
  if avecGrille then s:='1' else s:='0';
  Writeln(fichier,Avecgrille_ch+'='+s);
  writeln(fichier,Graphisme_ch+'=',graphisme);

  writeln(fichier,'/ Taille de la matrice x,y');
  writeln(fichier,matrice_ch+'='+IntToSTR(NbreCellX)+','+intToSTR(NbreCellY));
  writeln(fichier,'/ Ratio d''affichage celluleX/CelluleY');
  writeln(fichier,Ratio_ch+'='+intToSTR(ratioC));
  writeln(fichier,'/Matrice TCO');
  writeln(fichier,'[Matrice]');
  writeln(fichier,'/ couleur fond,adresse,image,inversion aiguillage,Orientation du signal, pied du signal , [texte], representation, fonte, taille fonte, couleur fonte, style, réserve ');
  for y:=1 to NbreCellY do
  begin
    s:='';
    for x:=1 to NbreCellX do
    begin
      s:=s+'('+intToHex(TCO[x,y].CouleurFond,6)+','+inttostr(TCO[x,y].Adresse)+','+IntToSTR(TCO[x,y].BImage)+',';

      if TCO[x,y].inverse then s:=s+'1,' else s:=s+'0,';

      if TCO[x,y].BImage=50 then
      begin
        s:=s+IntToSTR(TCO[x,y].FeuOriente)+','+IntToSTR(TCO[x,y].PiedFeu)+',';
      end
      else s:=s+'0,0,';

      // texte
      s:=s+TCO[x,y].Texte+',';
      // représentation
      s:=s+intToSTR(TCO[x,y].repr);
      // NomFonte
      s:=s+','+TCO[x,y].Fonte;
      //taille fonte
      s:=s+','+intToSTR(TCO[x,y].tailleFonte);
      // couleur fonte
      couleurfonte:=TCO[x,y].coulFonte;
      s:=s+','+intTohex(couleurFonte,6);
      s:=s+','+TCO[x,y].FontStyle;
      s:=s+',0';
      s:=s+')';
    end;
    writeln(fichier,s);
  end;
  closefile(fichier);
  TCO_modifie:=false;
  Affiche('TCO sauvegardé',clyellow);
end;

procedure calcul_cellules;
begin
  LargeurCell:=ZoomMax-FormTCO.TrackBarZoom.Position+ZoomMin;
  //Affiche(intToSTR(largeurcell),clyellow);
  hauteurCell:=(LargeurCell * RatioC) div 10;
  largeurCelld2:=largeurCell div 2;HauteurCelld2:=HauteurCell div 2;
  Epaisseur:=LargeurCell div 7;   // épaisseur du trait pour PEN
end;

procedure entoure_cell_grille(x,y : integer);
// redessine le carré de grille de la cellule qui a été altéré par la mise à
// jour de la cellule
var Xorg,Yorg : integer;
begin;
  if not(AvecGrille) then exit;
  Xorg:=(x-1)*LargeurCell;
  Yorg:=(y-1)*HauteurCell;
  With PcanvasTCO do
  begin
    Pen.Color:=clGrille;
    Pen.mode:=PmCopy;
    Pen.width:=1;
    MoveTo(Xorg,YOrg);
    LineTo(Xorg+LargeurCell,YOrg);
    LineTo(Xorg+LargeurCell,YOrg+HauteurCell);
    LineTo(Xorg,YOrg+HauteurCell);
    LineTo(Xorg,YOrg);
  end;
end;



function positionTCO(x,y : integer) : integer;
var position,i : integer;
begin
  i:=index_Aig(TCO[x,y].Adresse);
  position:=aiguillage[i].position ;
  if (position=0) or (i=0) then begin result:=const_inconnu;exit;end;
  if TCO[x,y].inverse then
  begin
    if position=const_droit then begin result:=const_devie;exit;end;
    if position=const_devie then begin result:=const_droit;exit;end;
    result:=const_inconnu;
    exit;
  end
  else result:=position;
end;

// arc à deux rayons différents
procedure D_Arc2R(Canvas: TCanvas; CenterX,CenterY: integer;
                rayonX,rayonY: Integer; StartDegres, StopDegres: Double);
var
  sinA,cosA   : extended;
  x1,x2,x3,x4: Integer;
  y1,y2,y3,y4: Integer;
begin
  if StopDegres<0 then setArcDirection(Canvas.Handle,AD_COUNTERCLOCKWISE)
    else setArcDirection(Canvas.Handle,AD_CLOCKWISE);

  StartDegres:=startDegres*pisur180;
  stopDegres:=StartDegres+stopDegres*pisur180;
  x1:=CenterX - rayonX;
  y1:=CenterY - rayonY;
  x2:=CenterX + rayonX;
  y2:=CenterY + rayonY;
  SinCos(StartDegres,SinA,CosA);
  x4:=CenterX + Round(rayonX*CosA);
  y4:=Centery - Round(rayonY*SinA);
  SinCos(StopDegres,SinA,CosA);
  x3:=CenterX + Round(rayonX*CosA);
  y3:=Centery - Round(rayonY*SinA);
  Canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
end;

procedure efface_selection;
begin
  if SelectionAffichee then
    begin
      //Affiche('efface sélection',clOrange);
      with formtco.imageTCO.Canvas do
      begin
        Pen.Mode:=PmXor;
        Pen.color:=clGrille;
        Brush.Color:=clblue;
        //FillRect(r);
        Rectangle(rAncien);
      end;
      SelectionAffichee:=false;
    end;
end;

// élément de voie horizontale Element 1
procedure dessin_voie(Canvas : Tcanvas;x,y,mode : integer);
var Adr, x0,y0,jy1,jy2 : integer;
    r : Trect;
    couleur : Tcolor;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    //Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Mode:=pmCopy;
   { r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);
    }

    Adr:=TCO[x,y].adresse;

    // détecteur
    if adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        brush.Color:=clAllume;
        pen.color:=clAllume;
      end
      else
      begin
        pen.color:=TCO[x,y].CouleurFond;
        brush.color:=TCO[x,y].CouleurFond;
      end;
      jy1:=y0+(HauteurCell div 2)-round(6*frYGlob); // pos Y de la bande sup
      jy2:=y0+(HauteurCell div 2)+round(6*frYGlob); // pos Y de la bande inf
      if avecGrille then r:=Rect(x0+1,jy1,x0+LargeurCell-1,jy2) else
      r:=Rect(x0,jy1,x0+LargeurCell,jy2) ;
      FillRect(r);
    end;

    // voie
    jy1:=y0+(HauteurCell div 2);
    Pen.Width:=epaisseur;

    case mode of
    0 : couleur:=clVoies;
    1 : couleur:=clAllume;
    2 : couleur:=couleurtrain[index_couleur];
    end;
    pen.color:=couleur;
    moveTo(x0,jy1);LineTo(x0+LargeurCell,jy1);
  end;
end;


procedure dessin_2L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy1,jy2,xf,yf,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
       moveto(x0,yf);lineto(xc,yc);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xc,yc);    // partie déviée

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // 2eme partie droite toujours allumée
       moveto(xc,yc);LineTo(xf,yc);

       // 1ere partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(x0,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do 
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // horizontale complete
       moveto(x0,yf);lineto(xc,yc);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz g en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yf);LineTo(xc,yc);LineTo(xf,yc);  // trajet déviée
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  fond:=TCO[x,y].CouleurFond;
  position:=positionTCO(x,y);

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
      jy1:=yc-(Epaisseur div 2);   // pos Y de la bande sup
      pen.width:=1;
      Polygon([point(x0+1,y0+hauteurCell-epaisseur),Point(xc-(epaisseur div 2),jy1),Point(xc-epaisseur-epaisseur,jy1),Point(x0+1,y0+hauteurcell-epaisseur-epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jy2:=yc+(Epaisseur div 2);   // pos Y de la bande inf
      r:=rect(x0+1,jy2+1,x0+largeurCell-1,jy2+epaisseur);
      FillRect(r);
    end;
  end;
end;

// essai courbe
procedure dessin_2C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy2,xf,yf,position,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  fond:=TCO[x,y].CouleurFond;
  position:=positionTCO(x,y);

  // mode rond
  x1:=xf-x0;
  x1:=x0-(x1 div 3);y1:=yc;
  x2:=xf+xf-x1;y2:=yf+hauteurCell*2+(hauteurCell div 2);
  x3:=xf;y3:=yc;
  x4:=x0;y4:=yf;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
      //Point(x0+1,y0+hauteurcell-epaisseur-epaisseur)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      jy2:=yc+(Epaisseur div 2);   // pos Y de la bande inf
      r:=rect(x0+1,jy2+1,x0+largeurCell-1,jy2+epaisseur);
      FillRect(r);
    end;
  end;
end;

procedure dessin_2(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_2L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_2C(Canvas,x,y,Mode);
end;

procedure dessin_3L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy1,xf,yf,position : integer;
    fond : Tcolor;
    r : Trect;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
       moveto(xc,yc);lineto(xf,y0);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);lineto(xf,y0);    // partie déviée

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie gauche toujours allumée
       moveto(x0,yc);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // horizontale complete
       moveto(xc,yc);lineto(xf,y0);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz droite en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(xf,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yc);LineTo(xc,yc);LineTo(xf,y0);  // partie déviée
     end;
   end;
     

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
      r:=rect(x0+1,jy1,x0+largeurCell-1,jy1-epaisseur);
      FillRect(r);
    end;
  end;
end;

procedure dessin_3C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,jy1,xf,yf,position,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    fond : Tcolor;
    r : Trect;

   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin

  // mode rond
  x1:=x0-largeurCell-(largeurCell div 3);y1:=y0-2*hauteurCell-(hauteurCell div 2);
  x2:=xf+(largeurcell div 3)+3;y2:=yc;
  x3:=x0;y3:=yc;
  x4:=xf;y4:=y0;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;
  efface_selection;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
      r:=rect(x0+1,jy1,x0+largeurCell-1,jy1-epaisseur);
      FillRect(r);
    end;
  end;
  {
  with canvas do
  begin
    pen.Color:=clwhite;
    pen.width:=1;
    moveto(x1,y1);lineto(x2,y2);
  end; }
end;


procedure dessin_3(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1  then dessin_3L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_3C(Canvas,x,y,Mode);
end;

procedure dessin_4L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
       moveto(xc,yc);lineto(xf,yf);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);lineto(xf,yf);    // partie déviée

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie gauche toujours allumée
       moveto(x0,yc);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // horizontale complete
       moveto(xc,yc);lineto(xf,yf);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz droite en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(xf,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yc);LineTo(xc,yc);LineTo(xf,yf);  // trajet dévié
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
      x1:=xc+(epaisseur div 2);y1:=yc-(epaisseur div 2)-1;
      x2:=x1+8;y2:=y1;
      x3:=x2+6;y3:=y2+7;
      x4:=x1+6;y4:=y3;
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
      x2:=x1+21;y2:=y1+5;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
    end;
  end;
end;

procedure dessin_4C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin

  // mode rond
  x1:=x0-largeurCell-(largeurCell div 3);y1:=yc;
  x2:=xf+(largeurcell div 3);y2:=yf+2*hauteurcell+(hauteurcell div 2);
  x3:=xf;y3:=yf;
  x4:=x0;y4:=yc;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
      x3:=x2+6;y3:=y2+7;
      x4:=x1+12;y4:=y3;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    if position=const_droit then
    begin
      // effacement du morceau
      pen.color:=fond;
      Brush.Color:=fond;
      pen.Width:=1;
      // efface le morceau
      x1:=xc-2*epaisseur;y1:=yc+(epaisseur div 2)+1;
      x2:=xc+2*epaisseur+2;y2:=y1+5;
      r:=rect(x1,y1,x2,y2);
      rectangle(r);
    end;
  end;
end;


procedure dessin_4(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_4L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_4C(Canvas,x,y,Mode);
end;

procedure dessin_5L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
       moveto(x0,y0);lineto(xc,yc);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xc,yc);    // partie déviée

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // 2eme partie droite toujours allumée
       moveto(xc,yc);LineTo(xf,yc);

       // 1ere partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(x0,yc);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xf,yc);    // horizontale complete
       moveto(x0,y0);lineto(xc,yc);    // partie déviée
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz g en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,y0);LineTo(xc,yc);LineTo(xf,yc);  // trajet dévié
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_5C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yc);lineto(xf,yc);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  // mode rond
  x1:=x0-(largeurCell div 3);y1:=y0-2*hauteurCell-(hauteurCell div 2)+4;
  x2:=xf+largeurCell+(largeurcell div 3);y2:=yc;
  x3:=x0;y3:=y0;
  x4:=xf;y4:=yc;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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


procedure dessin_5(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_5L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_5C(Canvas,x,y,Mode);
end;

// coin supérieur gauche (Element 6)
procedure dessin_6L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=ClCanton;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Pen.Width:=epaisseur;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    MoveTo(x0,y0);LineTo(xc,yc);Lineto(x0+largeurCell,yc);
  end;
end;

// coin supérieur gauche (Element 6)
procedure dessin_6C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-(largeurCell div 3);y1:=y0-2*hauteurCell-(hauteurCell div 2);
  x2:=xf+largeurCell+(largeurcell div 3);y2:=yc;
  x3:=x0;y3:=y0;
  x4:=xf;y4:=yc;
  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;

    case mode of
        0: couleur:=clVoies;
        1: couleur:=ClCanton;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Pen.Width:=epaisseur;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_6(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_6L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_6C(Canvas,x,y,Mode);
end;

// Element 7
procedure dessin_7L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    Pen.Width:=epaisseur;
    MoveTo(x0,yc);LineTo(xc,yc);lineto(x0+largeurCell,y0);
  end;
end;

procedure dessin_7C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-largeurCell-(largeurCell div 3);y1:=y0-2*hauteurCell-(hauteurCell div 2);
  x2:=xf+(largeurcell div 3)+3;y2:=yc;
  x3:=x0;y3:=yc;
  x4:=xf;y4:=y0;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    Pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_7(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_7L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_7C(Canvas,x,y,Mode);
end;

// courbe: droit vers bas  -\  Element 8
procedure dessin_8L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=ClCanton;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    Pen.Mode:=pmCopy;
    pen.color:=Couleur;
    pen.Width:=epaisseur;
    moveto(x0,yc);lineto(xc,yc);lineto(x0+largeurCell,y0+hauteurCell);
  end;
end;

procedure dessin_8C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-largeurCell-(largeurCell div 3);y1:=yc;
  x2:=xf+(largeurcell div 3);y2:=yf+2*hauteurcell+(hauteurcell div 2);
  x3:=xf;y3:=yf;
  x4:=x0;y4:=yc;


  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=ClCanton;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    Pen.Mode:=pmCopy;
    pen.color:=Couleur;
    pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_8(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_8L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_8C(Canvas,x,y,Mode);
end;

// courbe bas gauche vers droit  Elément 9
procedure dessin_9l(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=ClCanton;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    pen.width:=epaisseur;
    MoveTo(x0,y0+hauteurCell);LineTo(xc,yc);LineTo(x0+largeurCell,yc);
  end;
end;


// courbe bas gauche vers droit  Elément 9
procedure dessin_9c(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;
  yf:=y0+HauteurCell;
    // mode rond
  x1:=xf-x0;
  x1:=x0-(x1 div 3);y1:=yc;
  x2:=xf+xf-x1;y2:=yf+hauteurCell*2+(hauteurCell div 2);
  x3:=xf;y3:=yc;
  x4:=x0;y4:=yf;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=ClCanton;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    pen.width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_9(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_9L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_9C(Canvas,x,y,Mode);
end;

// élément 10
procedure dessin_10(Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0: integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Adr:=TCO[x,y].adresse;
    // détecteur
    if adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        brush.Color:=clAllume;
        pen.color:=clAllume;
      end
      else
      begin
        pen.color:=TCO[x,y].CouleurFond;
        brush.color:=TCO[x,y].CouleurFond;
      end;
     // if avecGrille then r:=Rect(x0+1,jy1,x0+LargeurCell-1,jy2) else
      pen.Width:=epaisseur+3;
      MoveTo(x0+largeurCell,y0);LineTo(x0,y0+hauteurCell);
    end;

    // voie
    Pen.Width:=epaisseur;

    case mode of
    0 : couleur:=clVoies;
    1 : couleur:=clAllume;
    2 : couleur:=couleurtrain[index_couleur];
    end;
    pen.color:=couleur;
    MoveTo(x0+largeurCell,y0);LineTo(x0,y0+hauteurCell);
  end;
end;

// élément 11
procedure dessin_11(Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0 : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Adr:=TCO[x,y].adresse;
// détecteur
    if adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        brush.Color:=clAllume;
        pen.color:=clAllume;
      end
      else
      begin
        pen.color:=TCO[x,y].CouleurFond;
        brush.color:=TCO[x,y].CouleurFond;
      end;
     // if avecGrille then r:=Rect(x0+1,jy1,x0+LargeurCell-1,jy2) else
      pen.Width:=epaisseur+3;
      MoveTo(x0,y0);LineTo(x0+largeurCell,y0+hauteurCell);
    end;

    // voie
    Pen.Width:=epaisseur;

    case mode of
    0 : couleur:=clVoies;
    1 : couleur:=clAllume;
    2 : couleur:=couleurtrain[index_couleur];
    end;
    pen.color:=couleur;
    MoveTo(x0,y0);LineTo(x0+largeurCell,y0+hauteurCell);
  end;
end;


// Element 12
procedure dessin_12L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(xc,yc);lineto(xf,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);lineto(xf,yc);    // partie droite

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie haute toujours allumée
       moveto(x0,y0);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(xc,yc);lineto(xf,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie sup en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(xf,yf);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,y0);LineTo(xc,yc);LineTo(xf,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_12C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : tcolor;
   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
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
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;



begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-(largeurCell div 3);y1:=y0-2*hauteurCell-(hauteurCell div 2);
  x2:=xf+largeurCell+(largeurcell div 3);y2:=yc;
  x3:=x0;y3:=y0;
  x4:=xf;y4:=yc;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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


procedure dessin_12(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_12L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_12C(Canvas,x,y,Mode);
end;


// Elément 13
procedure dessin_13L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(x0,yc);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xc,yc);    // partie horz

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie basse toujours allumée
       moveto(x0,yf);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(x0,yc);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie inf en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(x0,yf);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yc);LineTo(xc,yc);LineTo(xf,y0);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_13C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yf);lineto(xf,y0);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;



begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-largeurCell-(largeurCell div 3);y1:=y0-2*hauteurCell-(hauteurCell div 2);
  x2:=xf+(largeurcell div 3)+3;y2:=yc;
  x3:=x0;y3:=yc;
  x4:=xf;y4:=y0;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_13(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_13L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_13C(Canvas,x,y,Mode);
end;

// Element 14
procedure dessin_14l(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(x0,yc);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yc);lineto(xc,yc);    // partie droite

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie basse toujours allumée
       moveto(xf,yf);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(x0,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(x0,yc);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie sup en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(xf,yf);LineTo(xc,yc);LineTo(x0,yc);
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_14c(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
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
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-largeurCell-(largeurCell div 3);y1:=yc;
  x2:=xf+(largeurcell div 3);y2:=yf+2*hauteurcell+(hauteurcell div 2);
  x3:=xf;y3:=yf;
  x4:=x0;y4:=yc;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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


procedure dessin_14(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_14L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_14C(Canvas,x,y,Mode);
end;


// Element 15
procedure dessin_15L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,position : integer;
    fond : Tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(xc,yc);lineto(xf,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);lineto(xf,yc);    // partie droite

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie basse toujours allumée
       moveto(x0,yf);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(xc,yc);lineto(xf,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie sup en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(xf,y0);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yf);LineTo(xc,yc);LineTo(xf,yc);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_15C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : Tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yf);lineto(xf,y0);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=xf-x0;
  x1:=x0-(x1 div 3);y1:=yc;
  x2:=xf+xf-x1;y2:=yf+hauteurCell*2+(hauteurCell div 2);
  x3:=xf;y3:=yc;
  x4:=x0;y4:=yf;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_15(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_15L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_15C(Canvas,x,y,Mode);
end;


// Element 16
procedure dessin_16L(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

     case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    Pen.width:=epaisseur;
    MoveTo(x0,y0);lineTo(xc,yc);LineTo(xc,y0+hauteurCell);
  end;
end;


procedure dessin_16C(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-(2*largeurCell)-(largeurcell div 2);y1:=y0-(hauteurCell div 3);
  x2:=x0+(largeurcell div 2);y2:=yf+hauteurcell+(hauteurCell div 3);
  x3:=xc;y3:=yf;
  x4:=x0;y4:=y0;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    Pen.width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;


procedure dessin_16(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_16L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_16C(Canvas,x,y,Mode);
end;


// Element 17
procedure dessin_17l(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Pen.Width:=epaisseur;
    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    MoveTo(x0+LargeurCell,y0);LineTo(xc,yc);LineTo(xc,y0+hauteurCell);
  end;
end;

// Element 17
procedure dessin_17c(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;
  yf:=y0+HauteurCell;
  x1:=x0+(largeurcell div 2);y1:=y0-(hauteurCell div 3);
  x2:=xf+(2*largeurCell)+(largeurcell div 2);y2:=yf+hauteurcell+(hauteurCell div 3);
  x3:=xf;y3:=y0;
  x4:=xc;y4:=yf;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Pen.Width:=epaisseur;
    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_17(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_17L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_17C(Canvas,x,y,Mode);
end;

// Elément 18
procedure dessin_18l(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    Pen.Width:=epaisseur;
    MoveTo(x0,y0+hauteurCell);LineTo(xc,yc);LineTo(xc,y0);
  end;
end;

procedure dessin_18c(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+largeurCell;
  yf:=y0+HauteurCell;
  x1:=x0-(2*largeurCell)-(largeurcell div 2);y1:=y0-hauteurCell-(hauteurCell div 3);
  x2:=x0+(largeurcell div 2);y2:=yf+(hauteurCell div 3);
  x3:=x0;y3:=yf;
  x4:=xc;y4:=y0;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=clfond;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    Pen.Width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_18(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_18L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_18C(Canvas,x,y,Mode);
end;

// Element 19
procedure dessin_19l(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurcell div 2);
  yc:=y0+(Hauteurcell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    Pen.width:=epaisseur;
    moveto(xc,y0);LineTo(xc,yc);LineTo(x0+largeurCell,y0+HauteurCell);
  end;
end;

procedure dessin_19c(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,x1,y1,x2,y2,x3,y3,x4,y4,xf,yf : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurcell div 2);
  yc:=y0+(Hauteurcell div 2);
  xf:=x0+largeurCell;
  yf:=y0+HauteurCell;
  x1:=x0+(largeurcell div 2);y1:=y0-hauteurCell-(hauteurCell div 3);
  x2:=xf+(2*largeurCell)+(largeurcell div 2);y2:=yf+(hauteurCell div 3);
  x3:=xc;y3:=y0;
  x4:=xf;y4:=yf;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;

    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    Pen.width:=epaisseur;
    canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4);
  end;
end;

procedure dessin_19(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_19L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_19C(Canvas,x,y,Mode);
end;


// Element 20
procedure dessin_20(Canvas : Tcanvas;x,y,mode: integer);
var jx1,jx2,x0,y0,xc,adr : integer;
    r : Trect;
    couleur : tcolor;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Mode:=pmCopy;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    // état détecteur
    Adr:=TCO[x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume;
        pen.color:=clAllume;
      end
      else
      begin
        couleur:=TCO[x,y].CouleurFond;
        Brush.Color:=couleur;
        pen.color:=couleur;
      end;
      jx1:=x0+(LargeurCell div 2)-round(6*frxGlob); // pos Y de la bande sup
      jx2:=x0+(LargeurCell div 2)+round(6*frxGlob); // pos Y de la bande inf
      if avecGrille then r:=Rect(jx1,y0+1,jx2,y0+HauteurCell-1) else
        r:=Rect(jx1,y0,jx2,y0+HauteurCell) ;
      FillRect(r);
    end;

    // voie
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;

    //jx1:=y0+(HauteurCell div 2);
    Pen.Width:=epaisseur;

    MoveTo(xc,y0);LineTo(xc,y0+HauteurCell);
  end;
end;

// Element 21 - croisement - TJD
procedure dessin_21(Canvas : Tcanvas;x,y,mode : integer);
var x0,y0,xc,yc,trajet : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Brush.Color:=clvoies;
    pen.color:=clvoies;
    pen.width:=epaisseur;
    moveTo(x0,y0+hauteurCell);LineTo(x0+LargeurCell,y0);  // diagonale
    moveTo(x0,yc);LineTo(x0+largeurCell,yc);    // horizontale

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[x,y].trajet;
      case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then begin moveTo(x0,yc);LineTo(x0+largeurCell,yc);end; // horizontale
      if trajet=2 then begin moveTo(x0,y0+hauteurCell);LineTo(x0+LargeurCell,y0);end;  // diagonale
      if trajet=3 then
      begin
        moveto(x0,y0+HauteurCell);LineTo(xc,yc);lineTo(x0+largeurCell,yc);
      end;
      if trajet=4 then
      begin
        moveto(x0,yc);LineTo(xc,yc);lineTo(x0+largeurCell,y0);
      end;
    end;
  end;
end;

// Element 22
procedure dessin_22(Canvas : Tcanvas;x,y,mode : integer);
var x0,y0,xc,yc,trajet : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(LargeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Brush.Color:=clvoies;
    pen.color:=clvoies;
    pen.width:=epaisseur;

    moveto(x0,y0);lineTo(x0+largeurCell,y0+hauteurCell); // diagonale
    moveTo(x0,yc);LineTo(x0+largeurCell,yc); // horizontale

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[x,y].trajet;
      case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then begin moveTo(x0,yc);LineTo(x0+largeurCell,yc);end; // horizontale
      if trajet=2 then begin moveto(x0,y0);lineTo(x0+largeurCell,y0+hauteurCell);end; // diagonale
      if trajet=3 then
      begin
        moveto(x0,y0);LineTo(xc,yc);lineTo(x0+largeurCell,yc);
      end;
      if trajet=4 then
      begin
        moveto(x0,yc);LineTo(xc,yc);lineTo(x0+largeurCell,y0+hauteurcell);
      end;

    end;
  end;
end;

// Element 51 (quai)
procedure dessin_51(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,x2,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Brush.Color:=clQuai;
    pen.color:=clQuai;
    x1:=x0;
    x2:=x0+largeurCell;

    jy1:=y0+(HauteurCell div 2)-round(14*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(14*frYGlob); // pos Y de la bande inf
    r:=rect(x1,jy1,x2,jy2);
    rectangle(r);
  end;
end;

// Element 24
procedure dessin_24L(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,position : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
       moveto(x0,y0);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xc,yc);    // partie déviée éteinte

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // 2eme partie droite toujours allumée
       moveto(xc,yf);LineTo(xc,yc);

       // 1ere partie en fonction de la position
       if position=const_devie then 
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xc,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // verticale complete
       moveTo(x0,y0);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz g en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,y0);LineTo(xc,yc);LineTo(xc,yf);  // trajet déviée
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
procedure dessin_24C(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


     
begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  // mode rond
  x1:=x0-(2*largeurCell)-(largeurcell div 2);y1:=y0-(hauteurCell div 3);
  x2:=x0+(largeurcell div 2);y2:=yf+hauteurcell+(hauteurCell div 3);
  x3:=xc;y3:=yf;
  x4:=x0;y4:=y0;
  
  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    {
    pen.Width:=1;
    pen.color:=clyellow;
    moveto(x1,y1);lineTo(x2,y2);
    ellipse(x1,y1,x2,y2);
    }
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
procedure dessin_23(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xf,yf,xc,yc,trajet : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(LargeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+LargeurCell;
  yf:=y0+HauteurCell;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Brush.Color:=clvoies;
    pen.color:=clvoies;
    pen.width:=epaisseur;

    moveto(xf,y0);lineTo(x0,yf); // diagonale
    moveTo(xc,y0);LineTo(xc,yf); // verticale

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[x,y].trajet;
      case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then begin moveTo(xc,y0);LineTo(xc,yf);end; // verticale    
      if trajet=2 then begin moveto(xf,y0);lineTo(x0,yf);end; // diagonale
      if trajet=3 then
      begin
        moveto(xf,y0);LineTo(xc,yc);lineTo(xc,yf);  //
      end;
      if trajet=4 then
      begin
        moveto(xc,y0);LineTo(xc,yc);lineTo(x0,yf); // -\
      end;

    end;
  end;
end;



procedure dessin_24(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_24L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_24C(Canvas,x,y,Mode);
end;

// Element 25  croisement
procedure dessin_25(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xf,yf,xc,yc,trajet : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(LargeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  xf:=x0+LargeurCell;
  yf:=y0+HauteurCell;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    //r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    //FillRect(r);

    Brush.Color:=clvoies;
    pen.color:=clvoies;
    pen.width:=epaisseur;

    moveto(x0,y0);lineTo(xf,yf); // diagonale
    moveTo(xc,y0);LineTo(xc,yf); // verticale

    // regarder d'ou on vient de la route du tco
    if mode>0 then
    begin
      trajet:=tco[x,y].trajet;
      case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
      end;
      Brush.Color:=couleur;
      pen.color:=couleur;
      if trajet=1 then begin moveTo(xc,y0);LineTo(xc,yf);end; // verticale
      if trajet=2 then begin moveto(x0,y0);lineTo(xf,yf);end; // diagonale
      if trajet=3 then
      begin
        moveto(x0,y0);LineTo(xc,yc);lineTo(xc,yc);  //
      end;
      if trajet=4 then
      begin
        moveto(xc,y0);LineTo(xc,yc);lineTo(xf,yf); // -\
      end;

    end;
  end;
end;

// Element 26
procedure dessin_26L(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,position : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
       moveto(xf,y0);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xf,y0);lineto(xc,yc);    // partie déviée éteinte

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // 2eme partie droite toujours allumée
       moveto(xc,yf);LineTo(xc,yc);

       // 1ere partie en fonction de la position
       if position=const_devie then 
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xc,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // verticale complete
       moveTo(xf,y0);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz d en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(xf,y0);LineTo(xc,yc);LineTo(xc,yf);  // trajet déviée
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
procedure dessin_26C(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


     
begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  // mode rond
  x1:=x0+(largeurcell div 2);y1:=y0-(hauteurCell div 3);
  x2:=xf+(2*largeurCell)+(largeurcell div 2);y2:=yf+hauteurcell+(hauteurCell div 3);
  x3:=xf;y3:=y0;
  x4:=xc;y4:=yf;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_26(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_26L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_26C(Canvas,x,y,Mode);
end;

// Element 27
procedure dessin_27L(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,jx2,jy2,jx3,jy3,xc,yc,jx1,jy1,xf,yf,position : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
       moveto(x0,yf);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xc,yc);    // partie déviée éteinte

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // 2eme partie droite toujours allumée
       moveto(xc,y0);LineTo(xc,yc);

       // 1ere partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xc,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // verticale complete
       moveTo(x0,yf);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yf);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yf);LineTo(xc,yc);LineTo(xc,y0);  // trajet déviée
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

// Element 27
procedure dessin_27C(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,jx2,jy2,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,
    jx3,jy3 : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  // mode rond       
  x1:=x0-(2*largeurCell)-(largeurcell div 3);y1:=y0-hauteurcell-(hauteurCell div 3);
  x2:=xc;y2:=yf+(hauteurCell div 3);    // div 3 permet d'avoir un angle a 45° plutot que div 2

  x3:=x0;y3:=yf;
  x4:=xc;y4:=y0;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_27(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_27L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_27C(Canvas,x,y,Mode);
end;

// Element 28
procedure dessin_28L(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,jx2,jy2,jx3,jy3,xc,yc,jx1,jy1,xf,yf,position : integer;
    r : Trect;
    fond: tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
       moveto(xf,yf);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xf,yf);lineto(xc,yc);    // partie déviée éteinte

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // 2eme partie droite toujours allumée
       moveto(xc,y0);LineTo(xc,yc);

       // 1ere partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xc,yf);

     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yf);    // verticale complete
       moveTo(xf,yf);lineto(xc,yc);    // partie déviée
     end;

     if (mode=1) or (mode=2) then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yf);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(xf,yf);LineTo(xc,yc);LineTo(xc,y0);  // trajet déviée
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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
procedure dessin_28C(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,jx2,jy2,xf,yf,x1,y1,x2,y2,x3,y3,x4,y4,position,
    jx3,jy3 : integer;
    r : Trect;
    fond: tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(xc,y0);lineto(xc,yf);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  // mode rond
  x1:=x0+(largeurcell div 2);y1:=y0-hauteurCell-(hauteurCell div 3);
  x2:=xf+(2*largeurCell)+(largeurcell div 2);y2:=yf+(hauteurCell div 3);
  x3:=xc;y3:=y0;
  x4:=xf;y4:=yf;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=Fond;;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_28(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_28L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_28C(Canvas,x,y,Mode);
end;

// Element 29
procedure dessin_29L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(xc,yc);lineto(xc,yf);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);lineto(xc,yf);    // partie droite

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie haute toujours allumée
       moveto(x0,y0);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,yf);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(xc,yc);lineto(xc,yf);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie sup en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(xf,yf);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,y0);LineTo(xc,yc);LineTo(xc,yf);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_29C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : tcolor;
   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
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
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;



begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-(2*largeurCell)-(largeurcell div 2);y1:=y0-(hauteurCell div 3);
  x2:=x0+(largeurcell div 2);y2:=yf+hauteurcell+(hauteurCell div 3);
  x3:=xc;y3:=yf;
  x4:=x0;y4:=y0;


  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_29(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_29L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_29C(Canvas,x,y,Mode);
end;

// Elément 32
procedure dessin_32L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(xc,yf);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie horz couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yf);lineto(xc,yc);    // partie déviée

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie basse toujours allumée
       moveto(x0,yf);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(xc,yf);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(x0,yf);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(xc,yf);LineTo(xc,yc);LineTo(xf,y0);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_32C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : tcolor;

   procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yf);lineto(xf,y0);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;



begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0+(largeurcell div 2);y1:=y0-(hauteurCell div 3);
  x2:=xf+(2*largeurCell)+(largeurcell div 2);y2:=yf+hauteurcell+(hauteurCell div 3);
  x3:=xf;y3:=y0;
  x4:=xc;y4:=yf;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_32(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_32L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_32C(Canvas,x,y,Mode);
end;

// Element 34
procedure dessin_33L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(xc,y0);lineto(xc,yc);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,y0);lineto(xc,yc);    // partie droite

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie basse toujours allumée
       moveto(xf,yf);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(x0,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);lineto(xf,yf);    // diag complete
       moveto(xc,y0);lineto(xc,yc);    // partie verticale
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie sup en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,y0);LineTo(xc,yc);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(xf,yf);LineTo(xc,yc);LineTo(xc,y0);
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_33c(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    r : Trect;
    fond : tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
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
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0+(largeurcell div 2);y1:=y0-hauteurCell-(hauteurCell div 3);
  x2:=xf+(2*largeurCell)+(largeurcell div 2);y2:=yf+(hauteurCell div 3);
  x3:=xc;y3:=y0;
  x4:=xf;y4:=yf;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_33(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_33L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_33C(Canvas,x,y,Mode);
end;

// Element 34
procedure dessin_34L(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : Tcolor;

   procedure trajet_droit;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(xc,yc);lineto(xc,y0);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie droite couleur voies
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);lineto(xc,y0);    // partie droite

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       // première partie basse toujours allumée
       moveto(x0,yf);LineTo(xc,yc);

       // 2eme partie en fonction de la position
       if position=const_devie then
       begin
         pen.color:=clvoies;
         Brush.Color:=clvoies;
       end;
       LineTo(xf,y0);
     end;
   end;

   procedure trajet_devie;
   begin
     if mode=0 then
     with canvas do
     begin
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(x0,yf);lineto(xf,y0);    // diag complete
       moveto(xc,yc);lineto(xc,y0);    // partie droite
     end;
     if (mode=1) or (mode=2) then
     with canvas do
     begin
       // partie sup en couleur de voie
       pen.color:=clvoies;
       Brush.Color:=clvoies;
       moveto(xc,yc);LineTo(xf,y0);

       if mode=1 then couleur:=ClCanton;
       if mode=2 then couleur:=couleurtrain[index_couleur];
       pen.color:=couleur;
       Brush.Color:=couleur;
       moveto(x0,yf);LineTo(xc,yc);LineTo(xc,y0);
     end;
   end;

begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_34C(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,y3,x4,y4,position : integer;
    fond : Tcolor;

procedure trajet_droit;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_droit then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       moveto(x0,yf);lineto(xf,y0);    // partie droite
     end;
   end;

   procedure trajet_devie;
   begin
     couleur:=clvoies;
     if mode>0 then
     begin
       if position=const_devie then
       begin
         if mode=1 then couleur:=clcanton;
         if mode=2 then couleur:=couleurtrain[index_couleur];
       end;
     end;

     with canvas do
     begin
       pen.color:=couleur;
       Arc(x1,y1,x2,y2,x3,y3,x4,y4); //courbe
     end;
   end;


begin
  x0:=(x-1)*LargeurCell;       // x origine
  y0:=(y-1)*HauteurCell;       // y origine
  yc:=y0+(HauteurCell div 2);  // y centre
  xc:=x0+(LargeurCell div 2);  // x centre
  xf:=x0+largeurCell;          // x fin
  yf:=y0+HauteurCell;          // y fin
  // mode rond
  x1:=x0-(2*largeurCell)-(largeurcell div 2);y1:=y0-hauteurCell-(hauteurCell div 3);
  x2:=x0+(largeurcell div 2);y2:=yf+(hauteurCell div 3);
  x3:=x0;y3:=yf;
  x4:=xc;y4:=y0;

  position:=positionTCO(x,y);
  fond:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=fond;
    Pen.Color:=fond;
    //r:=Rect(x0,y0,xf,yf);
    //FillRect(r);      // efface la cellule

    Pen.Width:=epaisseur;
    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
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

procedure dessin_34(Canvas : Tcanvas;x,y : integer;Mode : integer);
begin
  if graphisme=1 then dessin_34L(Canvas,x,y,Mode);
  if graphisme=2 then dessin_34C(Canvas,x,y,Mode);
end;

// calcul des facteurs de réductions X et Y pour l'adapter à l'image de destination
procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
begin
  frX:=DimDestX/DimOrgX;
  frY:=DimDestY/DimOrgY;
  //Affiche(formatfloat('0.000000',frY),clyellow);
end;

// Affiche dans le TCO en x,y un signal à 90° d'après l'image transmise
// x y en coordonnées pixels
procedure Feu_90G(ImageSource : TImage;x,y : integer;FrX,FrY : real;inverse : boolean);
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

  if inverse then
  begin
    inverse_image(FormTCO.ImageTemp2,ImageSource);
    // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
    PlgBlt(PImageTemp.Canvas.Handle,p,FormTCO.ImageTemp2.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);
  end
  else
    PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

  //PimageTemp.Visible:=true;
  // copie l'image du signal retournée depuis image temporaire vers tco avec une réduction en mode transparennt
  TransparentBlt(PcanvasTCO.Handle,x,y,round(TailleY*FrY),round(TailleX*FrX),   // destination
                 PImageTemp.Canvas.Handle,0,0,TailleY,TailleX,clBlue);    // source - clblue est la couleur de transparence
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

// copie de l'image du signal à 90° dans le canvas source et le tourne de 90° et le met dans l'image temporaire
procedure Feu_90D(ImageSource : TImage;x,y : integer ; FrX,FrY : real;inverse : boolean);
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
    inverse_image(FormTCO.ImageTemp2,ImageSource);
    // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
    PlgBlt(PImageTemp.Canvas.Handle,p,FormTCO.ImageTemp2.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);
  end
  else
    PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

  // et copier l'image avec mise à l'échelle tournée sur le TCO
  TransparentBlt(PcanvasTCO.Handle,x,y,round(tailleY*FrY),round(tailleX*FrX),
                 PImageTemp.Canvas.Handle,0,0,TailleY,TailleX,clBlue);
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

procedure affiche_pied2G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frYR) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-50)*frYR) );
  end;
end;

procedure affiche_pied2G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,frYR: real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=35;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frYR) );
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) ) ;
  end;
end;

procedure affiche_pied_Vertical2G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=12;y1:=35;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) );
  end;
end;

procedure affiche_pied3G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,fryR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=45;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied3G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-4)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1-4)*frX),y+round((y1+50)*frYR) ) else
                   LineTo( x+round((x1-4)*frX),y+round((y1-50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical3G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=12;y1:=42;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) )
             else  LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) ) ;
  end;
end;

procedure affiche_pied4G_90G(x,y : integer;FrX,frY : real;piedFeu : integer);
var x1,y1 : integer;
    fryR,ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*frYR) ) ;
  end;
end;

procedure affiche_pied4G_90D(x,y : integer;FrX,frY : real;piedfeu: integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=55;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) )
                 else LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical4G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=12;y1:=55;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied9G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    var ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=90;y1:=38;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fryR)) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+40)*fryR));
  end;
end;

procedure affiche_pied5G_90D(x,y : integer;FrX,frY : real;piedFeu : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=66;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fryR) ) else
                      LineTo( x+round((x1+6)*frX),y+round((y1+50)*fryR) );
  end;
end;

procedure affiche_pied5G_90G(x,y : integer;FrX,frY : real;piedFeu : integer);
var x1,y1 : integer;
    ech,fryR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frYR) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*fryR) );
  end;
end;

procedure affiche_pied_Vertical5G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=12;y1:=65;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );

    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied7G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=75;y1:=38;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fryR) ) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+38)*fryR) ) ;
  end;
end;

procedure affiche_pied7G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech,frYR : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Color:=clPiedSignal;
    Pen.Width:=2;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frYR) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+60)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-40)*frYR) ) ;
  end;
end;

procedure affiche_pied_Vertical7G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=12;y1:=75;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-40)*frX),y+round((y1+7)*frY) ) ;
  end;
end;

procedure affiche_pied9G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    frYR,ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  frYR:=frY*ratioC/10;
  with PcanvasTCO do
  begin
    Pen.Color:=clPiedSignal;
    pen.Width:=2;
    x1:=0;y1:=12;
    // segment horizontal
    moveTo( x+round(x1*frX),y+round(y1*frYR) );
    LineTo( x+round((x1-6)*frX),y+round((y1+0)*frYR) );

    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+58)*frYR) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-40)*frYR) ) ;
  end;
end;

procedure affiche_pied_Vertical9G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Width:=2;
    Pen.Color:=clPiedSignal;
    x1:=12;y1:=90;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-40)*frX),y+round((y1+7)*frY) ) ;
  end;
end;

procedure Efface_Cellule(Canvas : Tcanvas;x,y : integer;Mode : TPenMode);
var x0,y0 : integer;
    r : TRect;
    c : tcolor;
begin
  {
  if y>1 then
  begin
    // si la cellule au dessus contient un feu vertical, ne pas effacer la cellule
    // if (tco[x,y-1].BImage=12) and (tco[x,y-1].FeuOriente=1) then exit;
  end;
  if x<NbreCellX then
  begin
    // si la cellule à gauche contient un feu 90D, ne pas effacer la cellule
    // if (tco[x-1,y].BImage=12) and (tco[x-1,y].FeuOriente=3) then exit;
  end;
  }
  if (x>NbreCellX) or (y>NbreCellY) or (x<1) or (y<1) then exit;

  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
  c:=TCO[x,y].CouleurFond;

  with canvas do
  begin
    Pen.Mode:=mode;
    Pen.Width:=1;
    Pen.color:=c;;
    Brush.Color:=c;
    Brush.style:=bsSolid;
    fillRect(r);
  end;
end;

// Dessine un signal dans le canvasDest en x,y , dont l'adresse se trouve à la cellule x,y
procedure dessin_Signal(CanvasDest : Tcanvas;x,y : integer );
var  index,x0,y0,xp,yp,orientation,adresse,aspect,PiedFeu,TailleX,TailleY : integer;
     ImageFeu : Timage;
     frX,frY : real;
begin
  //Efface_Cellule(CanvasDest,x,y,pmCopy);
  if (x>NbreCellX) or (y>NbreCellY) or (x<1) or (y<1) then exit;

  xp:=(x-1)*LargeurCell;
  yp:=(y-1)*HauteurCell;
  Adresse:=TCO[x,y].Adresse;

  Orientation:=TCO[x,y].FeuOriente;
  if Orientation=0 then Orientation:=1;  // cas d'un signal non encore renseigné

  index:=Index_Signal(adresse);
  aspect:=feux[index].aspect;
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
  PiedFeu:=TCO[x,y].PiedFeu;  // gauche ou droite de la voie

  // réduction variable en fonction de la taille des cellules. 50 est le Zoom Maxi
  calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);

  x0:=0;y0:=0; // pour les signaux directionnels
  if orientation=3 then  //D
  begin
    if aspect=20 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=9 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=5 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
    if aspect=4 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
    if aspect=3 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
    if aspect=2 then begin x0:=0; y0:=round((tailleX/2)*frY);end;
  end;

  // décalage en X pour mettre la tete du signal alignée sur le bord droit de la cellule pour les signaux tournés à 90G
  if orientation=2 then
  begin
    if aspect=20 then begin x0:=0; y0:=0;end;
    if aspect=9 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=5 then begin x0:=round(10*frX); y0:=round((tailleX/2)*frY);end;
    if aspect=4 then begin x0:=round(10*frX); y0:=round((tailleX/2)*frY);end;
    if aspect=3 then begin x0:=round(8*frX);  y0:=round((tailleX/2)*frY);end;
    if aspect=2 then begin x0:=round(10*frX); y0:=round((tailleX/2)*frY);end;
  end;

  // décalage en X pour rapprocher le signal du le bord droit de la cellule pour les feux verticaux
  if orientation=1 then
  begin
    if aspect=20 then begin x0:=0; y0:=0; end;
    if aspect=9 then begin x0:=0; y0:=0; end;
    if aspect=7 then begin x0:=0; y0:=0; end;
    if aspect=5 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=4 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=3 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=2 then begin x0:=round(13*frx); y0:=0;end;
  end;

  x0:=x0+xp;y0:=y0+yp;
  tco[x,y].x:=x0;
  tco[x,y].y:=y0;

  // affichage du signal et du pied - orientation verticale
  if (Orientation=1) then
  begin
    // si inversion
    if feux[index].contrevoie then
    begin
      inverse_image(FormTCO.ImageTemp,ImageFeu);
      // copie avec mise à l'échelle de l'image du signal
      TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   FormTCO.ImageTemp.Canvas.Handle,0,0,TailleX,TailleY,clBlue);
    end
    else
      // copie avec mise à l'échelle de l'image du signal
      TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   ImageFeu.Canvas.Handle,0,0,TailleX,TailleY,clBlue);

    PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
    case aspect of
    20 : affiche_pied_Vertical5G(x0+round(10*frx),y0+hauteurCell-round(10*fry),frX,frY,piedFeu);
    9 : affiche_pied_Vertical9G(x0,y0,frX,frY,piedFeu);
    7 : affiche_pied_Vertical7G(x0,y0,frX,frY,piedFeu);
    5 : affiche_pied_Vertical5G(x0,y0,frX,frY,piedFeu);
    4 : affiche_pied_Vertical4G(x0,y0,frX,frY,piedFeu);
    3 : affiche_pied_Vertical3G(x0,y0,frX,frY,PiedFeu);
    2 : affiche_pied_Vertical2G(x0,y0,frX,frY,PiedFeu);
    end;
  end;

  // affichage du feu et du pieds - orientation 90°G
  if Orientation=2 then
  begin
    Feu_90G(ImageFeu,x0,y0,frX,frY,feux[index].contrevoie); // ici on passe l'origine du signal
    // dessiner le pied
    case aspect of
    20 : affiche_pied5G_90G(x0+2,y0+round(fry*5),frX,frY,piedFeu);
    9 : affiche_pied9G_90G(x0,y0,frX,frY,piedFeu);
    7 : affiche_pied7G_90G(x0,y0,frX,frY,piedFeu);
    5 : affiche_pied5G_90G(x0,y0,frX,frY,piedFeu);
    4 : affiche_pied4G_90G(x0,y0,frX,frY,piedFeu);
    3 : affiche_pied3G_90G(x0,y0,frX,frY,piedFeu);
    2 : affiche_pied2G_90G(x0,y0,frX,frY,piedFeu);
    end;
  end;

  // affichage du signal et du pied - orientation 90°D
  if Orientation=3 then
  begin
    Feu_90D(ImageFeu,x0,y0,frX,frY,feux[index].contrevoie);
    // dessiner le pied
    case aspect of
    20 : affiche_pied5G_90D(x0+(largeurCell div 2)+round(frx*12),y0+(hauteurCell div 2),frX,frY,piedFeu);
    9 : affiche_pied9G_90D(x0,y0,frX,frY,piedFeu);
    7 : affiche_pied7G_90D(x0,y0,frX,frY,piedFeu);
    5 : affiche_pied5G_90D(x0,y0,frX,frY,piedFeu);
    4 : affiche_pied4G_90D(x0,y0,frX,frY,piedFeu);
    3 : affiche_pied3G_90D(x0,y0,frX,frY,PiedFeu);
    2 : affiche_pied2G_90D(x0,y0,frX,frY,PiedFeu);
    end;
  end;

  // allumage des feux du signal -----------------
  dessine_feu_mx(canvasDest,x0,y0,frX,frY,adresse,orientation);
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

// affiche la cellule x et y en cases
// index est utilisé pour accéder au tableau du tracé de la fonction zone_tco
procedure affiche_cellule(x,y : integer);
var i,index,repr,Xorg,Yorg,xt,yt,mode,adresse,Bimage,aspect,oriente,pied : integer;
    inverse : boolean;
    s : string;
begin
  //if tco[x,y].BImage=0 then exit;
  //Affiche('Affiche_cellule',clLime);
  PcanvasTCO.pen.Mode:=PmCopy;
  //pcanvasTCO.Brush.Style:=BsClear;
  adresse:=tco[x,y].Adresse;
  BImage:=tco[x,y].BImage;
  mode:=tco[x,y].mode;
  repr:=tco[x,y].repr;

  Xorg:=(x-1)*LargeurCell;
  Yorg:=(y-1)*HauteurCell;

  // ------------- affichage de l'adresse ------------------
  s:=IntToSTR(adresse);

  // affiche d'abord l'icone de la cellule et colore la voie si zone ou détecteur actionnée selon valeur mode
  case Bimage of
   // 0 : efface_cellule(PCanvasTCO,x,y,pmcopy);
    1 : dessin_voie(PCanvasTCO,X,Y,mode);
    2 : dessin_2(PCanvasTCO,X,Y,mode);
    3 : dessin_3(PCanvasTCO,X,Y,mode);
    4 : dessin_4(PCanvasTCO,X,Y,Mode);
    5 : dessin_5(PCanvasTCO,X,Y,Mode);
    6 : dessin_6(PCanvasTCO,X,Y,Mode);
    7 : dessin_7(PCanvasTCO,X,Y,Mode);
    8 : dessin_8(PCanvasTCO,X,Y,Mode);
    9 : dessin_9(PCanvasTCO,X,Y,mode);
   10 : dessin_10(PCanvasTCO,X,Y,mode);
   11 : dessin_11(PCanvasTCO,X,Y,mode);
   12 : dessin_12(PCanvasTCO,X,Y,mode);
   13 : dessin_13(PCanvasTCO,X,Y,mode);
   14 : dessin_14(PCanvasTCO,X,Y,mode);
   15 : dessin_15(PCanvasTCO,X,Y,mode);
   16 : dessin_16(PCanvasTCO,X,Y,mode);
   17 : dessin_17(PCanvasTCO,X,Y,mode);
   18 : dessin_18(PCanvasTCO,X,Y,mode);
   19 : dessin_19(PCanvasTCO,X,Y,mode);
   20 : dessin_20(PCanvasTCO,X,Y,mode);
   21 : dessin_21(PCanvasTCO,X,Y,mode);
   22 : dessin_22(PCanvasTCO,X,Y,mode);
   23 : dessin_23(PCanvasTCO,X,Y,mode);
   24 : dessin_24(PCanvasTCO,X,Y,mode);
   25 : dessin_25(PCanvasTCO,X,Y,mode);
   26 : dessin_26(PCanvasTCO,X,Y,mode);
   27 : dessin_27(PCanvasTCO,X,Y,mode);
   28 : dessin_28(PCanvasTCO,X,Y,mode);
   29 : dessin_29(PCanvasTCO,X,Y,mode);
   32 : dessin_32(PCanvasTCO,X,Y,mode);
   33 : dessin_33(PCanvasTCO,X,Y,mode);
   34 : dessin_34(PCanvasTCO,X,Y,mode);

   50 : dessin_Signal(PCanvasTCO,X,Y);
   51 : dessin_51(PCanvasTCO,X,Y,mode);
   end;

  PCanvasTCO.font.Size:=(LargeurCell div 10)+4  ;
  //Affiche(intToSTR( (LargeurCell div 30)+6),clyellow);

  // affiche le texte des aiguillages
  if ((BImage=2) or (BImage=3) or (BImage=4) or (BImage=5) or (BImage=12) or (BImage=13) or (BImage=14) or
      (BImage=15) or
      ((BImage>=21) and (BImage<=34) )) and (adresse<>0) then
  begin
    if adresse<>0 then s:='A'+s+' ' else s:=' ';
    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      //Brush.Style:=Bsclear;
      Font.Color:=tco[x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      xt:=0;yt:=0;
      if Bimage=2  then begin xt:=3;yt:=1;end;
      if Bimage=3  then begin xt:=3;yt:=HauteurCell-round(20*fryGlob);end;
      if Bimage=4  then begin xt:=3;yt:=1;end;
      if Bimage=5  then begin xt:=3;yt:=HauteurCell-round(20*fryGlob);end;
      if Bimage=12 then begin xt:=1;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=13 then begin xt:=LargeurCell-round(30*frXGlob);yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=14 then begin xt:=LargeurCell-round(30*frXGlob);yt:=1;end;
      if Bimage=15 then begin xt:=3;yt:=1;end;
      if Bimage=21 then begin xt:=3;yt:=1;end;
      if Bimage=22 then begin xt:=3;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=24 then begin xt:=LargeurCell-round(20*frXGlob);yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=25 then begin xt:=1;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=26 then begin xt:=1;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=27 then begin xt:=1;yt:=1;end;
      if Bimage=28 then begin xt:=1;yt:=1;end;
      if Bimage=29 then begin xt:=LargeurCell div 2;yt:=1;end;
      if Bimage=32 then begin xt:=1;yt:=1;end;
      if Bimage=33 then begin xt:=1;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=34 then begin xt:=LargeurCell-round(30*frXGlob);yt:=HauteurCell-round(15*frYGlob);end;


      TextOut(xOrg+xt,yOrg+yt,s);
    end;
  end;

  // détecteurs voie horizontale
  if ((BImage=1) ) and (adresse<>0) then
  begin // Adresse de l'élément
    if repr<>0 then
    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      Font.Color:=tco[x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      xt:=round(15*frXGlob);
      case repr of
      1 : yt:=(HauteurCell div 2)-round(7*fryGlob);   // milieu
      2 : yt:=1;  // haut
      3 : yt:=HauteurCell-round(17*frYGlob);   // bas
      end;
      TextOut(xOrg+xt,Yorg+yt,s);

      // affiche/efface le nom du train du détecteur
      s:='        ';
      case repr of
            1,3 : yt:=1;  // haut
            2 : yt:=HauteurCell-round(17*frYGlob);   // bas
      end;
      i:=detecteur[adresse].AdrTrain;
      if i<>0 then
      begin
        i:=index_train_adresse(i);
        if i<>0 then s:=trains[i].nom_train;
      end;
      PCanvasTCO.font.Size:=(LargeurCell div 13)+4  ;
      TextOut(xOrg,Yorg+yt,s+' ');
    end;
  end;

  // autres détecteurs
  if ((Bimage=7) or (Bimage=8) or (Bimage=9) or (Bimage=10) or (Bimage=17)  or (Bimage=20)) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      Font.Color:=tco[x,y].coulFonte;
      TextOut(xOrg+round(2*frXGlob),yOrg+round(2*fryGlob),s);
    end;
  end;

  // autres détecteurs
  if (Bimage=18) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      Font.Color:=tco[x,y].coulFonte;
      TextOut(xOrg+round(20*frXGlob),yOrg+HauteurCell-round(14*frYGlob),s);
    end;
  end;

  // autres détecteurs
  if ((Bimage=6) or (Bimage=11) or (Bimage=16)) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      Font.Color:=tco[x,y].coulFonte;;
      Font.Style:=style(tco[x,y].FontStyle);
      Font.Name:='Arial';
      TextOut(xOrg+round(28*frXGlob),yOrg+round(2*fryGlob),s);
      //exit;
    end;
  end;

  // adresse des signaux
  if (BImage=50) and (adresse<>0) then
  begin
    index:=Index_Signal(adresse);
    aspect:=feux[index].Aspect;
    oriente:=TCO[x,y].FeuOriente;
    pied:=TCO[x,y].PiedFeu;
    inverse:=feux[index].contrevoie;
    xt:=0;yt:=0;
    if (aspect=20) and (Oriente=1) then
    begin
      if inverse then begin xt:=2;yt:=2*HauteurCell-round(16*fryGlob);end
      else
      begin xt:=(largeurCell div 2)+round(5*frXglob);yt:=2*HauteurCell-round(20*fryGlob); end;
    end;
    if (aspect=20) and (Oriente=2) then
    begin
      if inverse then begin xt:=round(20*frxGlob);yt:=round(3*fryGlob);end
      else
      begin xt:=round(10*frxGlob);yt:=HauteurCell-round(16*fryGlob);end;
    end;
    if (aspect=20) and (Oriente=3) then
    begin
      if inverse then begin xt:=largeurCell+round(10*frxGlob);yt:=HauteurCell-round(16*fryGlob);end
      else begin xt:=largeurCell+round(10*frxGlob);yt:=round(1*fryGlob);end;
    end;
    if (aspect=9) and (Oriente=1) then begin xt:=LargeurCell-round(25*frXGlob);yt:=2*HauteurCell-round(25*fryGlob);end;
    if (aspect=9) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(17*frYGlob);end;    // orientation G
    if (aspect=9) and (Oriente=3) then begin xt:=LargeurCell+round(25*frXglob);yt:=1;end;
    if (aspect=7) and (Oriente=1) then begin xt:=LargeurCell-round(25*frXGlob);yt:=HauteurCell;end;
    if (aspect=7) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(15*frYGlob);end;
    if (aspect=7) and (Oriente=3) then begin xt:=LargeurCell+2;yt:=1;end;
    if (aspect=5) and (Oriente=1) then begin xt:=round(10*frXGlob);yt:=HauteurCell+round(25*fryGlob);end;
    if (aspect=5) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell ;end;
    if (aspect=5) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=-round(14*frYGlob);end;
    if (aspect=4) and (Oriente=1) then begin xt:=1;yt:=HauteurCell+round(20*fryGlob);end;
    if (aspect=4) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell;end;
    if (aspect=4) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=-round(14*frYGlob);end;
    if (aspect=3) and (Oriente=1) and (pied=2) then begin xt:=round(-15*frXglob);yt:=1;end;  // signal à droite
    if (aspect=3) and (Oriente=1) and (pied=1) then begin xt:=round(45*frXglob);yt:=1;end;  // signal à gauche
    if (aspect=3) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=-round(14*frYGlob);end;
    if (aspect=3) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=HauteurCell;end;
    if (aspect=2) and (Oriente=1) and (pied=2) then begin xt:=round(-15*frXglob);yt:=1;end;  // signal à droite
    if (aspect=2) and (Oriente=1) and (pied=1) then begin xt:=round(45*frXglob);yt:=1;end;  // signal à gauche
    if (aspect=2) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell;end;  // orientation G
    if (aspect=2) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=HauteurCell;end;  // orientation D
    if (aspect>10) and (aspect<20) and(oriente=1) then begin xt:=1;yt:=HauteurCell-round(14*frYGlob);end;
    if (aspect>10) and (aspect<20) and (oriente=2) then begin xt:=LargeurCell-round(15*frXGlob);yt:=0;end;
    if (aspect>10) and (aspect<20) and (oriente=3) then begin xt:=LargeurCell-round(15*frXGlob);yt:=0;end;

    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      Font.Color:=tco[x,y].coulFonte;
      Font.Style:=style(tco[x,y].FontStyle);
      Font.Name:='Arial';
      TextOut(xOrg+xt,yOrg+yt,s);
    end;
  end;

  entoure_cell_grille(x,y);
  //canvasTCO.TextOut(xOrg+1,yOrg+1,IntToSTR(x));
end;

procedure Entoure_cell(x,y : integer);
var r : Trect;
    x0,y0 : integer;
begin
  x0:=(x-1)*LargeurCell+1;
  y0:=(y-1)*HauteurCell+1;
  with PcanvasTCO do
  begin
    Pen.width:=3;
    Pen.Color:=clyellow;
    Brush.Color:=clBlack;
    Brush.Style:=bsSolid;
    Pen.Mode:=PmXor;
    r:=Rect(x0,y0,x0+largeurCell,y0+HauteurCell);
    Rectangle(r);
    Pen.width:=1;
    Pen.Mode:=PmCopy;
  end;
end;

procedure efface_entoure;
begin
 if (entoure) then
    begin
      Entoure_cell(Xentoure,Yentoure);
      entoure:=false;
    end
end;

procedure _entoure_cell_clic;
begin
  if not(entoure) then
    begin
      Entoure_cell(XclicCell,YclicCell);
      Xentoure:=XClicCell;Yentoure:=YclicCell;
      entoure:=true;
    end
    else
    begin
      Entoure_cell(Xentoure,Yentoure);   // efface l'ancien
      // si on clique sur le même on l'efface sans afficher un nouveau
      if (Xentoure<>XclicCell) or (Yentoure<>YClicCell) then
      begin
        Entoure_cell(XclicCell,YclicCell);
      end
      else entoure:=false;

      Xentoure:=XClicCell;Yentoure:=YclicCell;
    end;
end;

procedure affiche_texte(x,y : integer);
var x0,y0,yt,repr : integer;
    ss,s : string;
begin
  x0:=(x-1)*Largeurcell;
  y0:=(y-1)*hauteurcell;
  //PCanvasTCO.Brush.Style:=bsSolid;

  if (TCO[x,y].BImage=51) then PCanvasTCO.Brush.Color:=clQuai else PCanvasTCO.Brush.Color:=tco[x,y].CouleurFond;
  //PCanvasTCO.pen.color:=clyellow;
  PcanvasTCO.Font.Color:=tco[x,y].CoulFonte;
  ss:=tco[x,y].fonte;
  if ss='' then ss:='Arial';
  PcanvasTCO.Font.Name:=ss;
  ss:=tco[x,y].FontStyle;

  PcanvasTCO.Font.Style:=style(ss);

  repr:=tco[x,y].repr;
  taillefonte:=tco[x,y].TailleFonte;
  case repr of
    0,1 : yt:=(HauteurCell div 2)-round(tailleFonte*fryGlob);   // milieu
      2 : yt:=1;  // haut
      3 : yt:=HauteurCell-round(2*TailleFonte*frYGlob);   // bas
  end;

  if taillefonte=0 then taillefonte:=8;
  PCanvasTCO.font.Size:=(taillefonte*LargeurCell) div 40;

  s:=tco[x,y].Texte+'  ';
  PcanvasTCO.Textout(x0+2,y0+yt,s);
end;

// affiche le tco suivant le tableau TCO
procedure Affiche_TCO ;
var x,y,x1,y1,DimX,DimY : integer;
    s : string;
    r : Trect;
begin
  if affevt then affiche('Affiche_tco',clLime);
  if pImageTCO=nil then exit;
  DimX:=LargeurCell*NbreCellX;
  DimY:=HauteurCell*NbreCellY;
  // DimX DimY maxi 8191 pixels pour les bitmap
  if (dimX>8192) then begin Affiche('Espace TCO X trop grand',clred); exit; end;
  if (dimY>8192) then begin Affiche('Espace TCO Y trop grand',clred); exit; end;

  PImageTCO.Height:=DimY;
  PImageTCO.Width:=DimX;

  PBitMapTCO.Height:=DimY;
  PBitMapTCO.Width:=DimX;


  //PScrollBoxTCO.HorzScrollBar.Range:=DimX;
  //PScrollBoxTCO.
  with formTCO.ScrollBox do
  begin
    HorzScrollBar.Range:=DimX;
    HorzScrollBar.Tracking:=true;
    HorzScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si on clique sur la trackbar!!
    VertScrollBar.Range:=DimY;
    VertScrollBar.Tracking:=true;
    VertScrollBar.Smooth:=false;
  end;


  //formTCO.ScrollBox.Width:=DimX;

  calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);
  //Affiche(formatfloat('0.000000',frxGlob),clyellow);

  //effacer tout
  with PcanvasTCO do
  begin
    Pen.width:=1;
    Brush.Style:=bsSolid;
    pen.color:=clyellow;

    for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        x1:=(x-1)*largeurCell;
        y1:=(y-1)*hauteurCell;
        brush.Color:=TCO[x,y].CouleurFond;

        r:=rect(x1,y1,x1+LargeurCell,y1+HauteurCell);
        FillRect(r);
      end;
  end;

  //afficher les cellules sauf les signaux
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage<>50 then
        begin
          affiche_cellule(x,y);
        end;
      end;

  //afficher les cellules des signaux et les textes pour que les pieds recouvrent le reste et afficher les textes
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage=50 then
        begin
          affiche_cellule(x,y);
        end;

        s:=Tco[x,y].Texte;
        if s<>'' then Affiche_texte(x,y);
      end;

  if entoure then
  begin
    Entoure_cell(Xentoure,Yentoure);
  end;
end;

procedure grise_ligne_tco;
var x : integer;
begin
  for x:=1 to NbreCellX do
  begin
    Affiche_Cellule(x,YClicCell);
  end;
end;

procedure TFormTCO.FormCreate(Sender: TObject);
begin
  if affevt or (debug=1) then Affiche('FormTCO create',clyellow);
  offsetSourisY:=-10;
  offsetSourisX:=-10;
  auto_tcurs:=true;
  caption:='TCO';
  TCO_modifie:=false;
  rangUndo:=1;
  XclicCell:=1;
  YclicCell:=1;
  xCoupe:=0;yCoupe:=0;
  indexTrace:=0;
  KeyPreview:=true; // valide les évènements clavier
  TrackBarZoom.Tabstop:=false;     // permet d'avoir les evts curseurs
  Buttonredessine.TabStop:=false;
  ButtonSauveTCO.TabStop:=false;
  ButtonConfigTCO.TabStop:=false;
  Buttonmasquer.TabStop:=false;
  ButtonRaz.TabStop:=false;
  ButtonDessiner.TabStop:=false;

  Clfond:=$202050;
  couleurAdresse:=Cyan;
  xMiniSel:=99999;yMiniSel:=99999;
  xMaxiSel:=0;yMaxiSel:=0;
  SelectionAffichee:=false;
  ImageTCO.Canvas.font.Name:='Arial';
  clAllume:=clYellow;
  clVoies:=clOrange;
  clTexte:=ClLime;
  clGrille:=$404040;
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

  modeTrace:=false;   // pour tracer les voies à la souris
  //controlStyle:=controlStyle+[csOpaque];

  TCOCree:=true;
  if debug=1 then Affiche('Fin création fenêtre TCO',clLime);
end;


// trouve le détecteur det dans le TCO et renvoie x et y
// si on le trouve pas, renvoie x=0,y=0
procedure trouve_det(det : integer;var x,y : integer);
var xc,yc : integer;
    trouve : boolean;
begin
  yc:=1;
  repeat
    xc:=0;
    repeat
      inc(xc);
      trouve:=tco[xc,yc].Adresse=det;
    until (xc=NbreCellX) or trouve;
    inc(yc);
  until (yc=NbreCellY) or trouve;
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

procedure Erreur_TCO(x,y : integer);
var s : string;
    i,adresse : integer;
begin
  s:='Erreur 92 TCO : cellule '+intToSTR(x)+','+intToSTR(y)+' ';
  adresse:=tco[x,y].Adresse;
  i:=index_aig(adresse);
  if i=0 then s:=s+'aiguillage '+intToSTR(adresse)+' inconnu';
  if i<>0 then s:=s+'position aiguillage '+intToSTR(adresse)+' inconnue';
  Affiche(s,clred);
end;


// allume ou éteint (mode=0 ou 1) la voie, zone de det1 à det2 sur le TCO
// si mode=0 : éteint
//        =1 : couleur détecteur allumé
//        =2 : couleur de l'index train

procedure zone_TCO(det1,det2,mode: integer);
var direction,i,j,x,y,xn,yn,ancienY,ancienX,Xdet1,Ydet1,Xdet2,Ydet2,Bimage,adresse,
    pos,pos2,ir,ax,ay,sx,sy: integer;
    memtrouve,sortir,horz,diag,casok : boolean;
    mdl : Tequipement;
    s : string;
begin
  // trouver le détecteur det1
  if debugTCO then AfficheDebug('Zone_TCO det1='+intToSTR(det1)+' det2='+intToSTR(det2)+' mode='+intToSTR(mode)+' couleur='+intToSTR(index_couleur),clyellow);
  trouve_det(det1,Xdet1,Ydet1);
  if (Xdet1=0) or (Ydet1=0) then exit;

  trouve_det(det2,Xdet2,Ydet2);
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
       // descendre et à droite
       casok:=true;
       ancieny:=ydet1+1;
       ancienx:=xdet1+1;
    end;
    if direction=2 then
    begin
      // monter et à gauche
      casok:=true;
      ancieny:=ydet1-1;
      ancienx:=xdet1-1;
    end;
    if direction=3 then
    begin
      // commencer par descendre et à gauche
      casok:=true;
      ancieny:=ydet1+1;
      ancienx:=xdet1-1;
    end;
    if direction=4 then
    begin
      // commencer par monter et à droite
      casok:=true;
      ancieny:=ydet1-1;
      ancienx:=xdet1+1;
    end;


    // boucle de remplissage du tableau routeTCO de det1 à det2
    repeat
      routeTCO[ir].x:=x;
      routeTCO[ir].y:=y;
      if ir<500 then inc(ir);

      if debugTCO then AfficheDebug('X='+intToSTR(x)+' Y='+IntToSTR(Y)+' AncienX='+intToSTR(ancienX)+' AncienY='+IntToSTR(ancienY),clyellow);

      // Affiche la cellule en fonction du mode


      adresse:=TCO[x,y].Adresse ;
      Bimage:=TCO[x,y].Bimage;
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
            pos:=positionTCO(x,y);
            if (ancienX<x) and (ancienY=y) then begin xn:=x+1;end;
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;if pos=const_devie then yn:=y+1;end;
            if (ancienX<x) and (ancienY>y) then begin xn:=x+1; end;
            if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
          end;
      3 : begin
            //if debugTCO then AfficheDebug('El 3',clyellow);
            pos:=positionTCO(x,y);
            if (ancienX<x) then begin xn:=x+1;if pos=const_devie then yn:=y-1;end;
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
            if (ancienX>x) and (ancienY<y) then begin xn:=x-1;end;
            if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
          end;
      4 : begin
            //if debugTCO then AfficheDebug('El 4',clyellow);
            pos:=positionTCO(x,y);
            if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;if pos=const_devie then yn:=y+1;end;
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;end;
            if (ancienX>x) and (ancienY>y) then begin xn:=x-1;end;
            if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
          end;
    5 : begin
          //if debugTCO then AfficheDebug('El 5',clyellow);
          pos:=positionTCO(x,y);
          if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;end;
          if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;if pos=const_devie then yn:=y-1;end;
          if (ancienX<x) and (ancienY<y) then begin ;xn:=x+1;end;
          if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;;
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
           pos:=positionTCO(x,y);
           if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;if pos=const_droit then yn:=y+1;end;
           if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;yn:=y-1;end;
           if (ancienX>x) and (ancienY>y) then begin xn:=x-1;yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
         end;
    13 : begin
           //if debugTCO then AfficheDebug('El 13',clyellow);
           pos:=positionTCO(x,y);
           if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;yn:=y-1;end;
           if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;if pos=const_droit then yn:=y+1;end;
           if (ancienX<x) and (ancienY>y) then begin xn:=x+1;yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
         end;
    14 : begin
           //if debugTCO then AfficheDebug('El 14',clyellow);
           pos:=positionTCO(x,y);
           if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;yn:=y+1;end;
           if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           if (ancienX>x) and (ancienY>y) then begin xn:=x-1;if pos=const_droit then yn:=y-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
         end;
    15 : begin
           //if debugTCO then AfficheDebug('El 15',clyellow);
           pos:=positionTCO(x,y);
           if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;if pos=const_droit then yn:=y-1;end;
           if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;yn:=y+1;end;
           if (ancienX>x) and (ancienY=y) then begin xn:=x-1;yn:=y+1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;

               if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
               begin
                 j:=Index_Aig(aiguillage[j].Ddroit);
                 pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                 if (pos2=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
             Affiche('Erreur 48 TCO : la cellule '+intToSTR(x)+'/'+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
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
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;

               if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
               begin
                 j:=Index_Aig(aiguillage[j].Ddroit);
                 pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                 if (pos2=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
             Affiche('Erreur 48 TCO : la cellule '+intToSTR(x)+'/'+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
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
                    if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;

                    if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
                    begin
                      j:=Index_Aig(aiguillage[j].Ddroit);
                      pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                      if (pos2=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
                  Affiche('Erreur 48 TCO : la cellule '+intToSTR(x)+'/'+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
                  Affiche('mais la cellule représente un croisement ou une TJD/S',clred);
                  exit;
                end;

              end;


         24 : begin
               if debugTCO then AfficheDebug('El 24',clyellow);
               pos:=positionTCO(x,y);
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
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
                    if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;

                    if ((mdl=tjd) or (mdl=tjs)) and (aiguillage[j].EtatTJD=4) then
                    begin
                      j:=Index_Aig(aiguillage[j].Ddroit);
                      pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                      if (pos2=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
                  Affiche('Erreur 48 TCO : la cellule '+intToSTR(x)+'/'+intToSTR(y)+' d''adresse '+intToSTR(Adresse)+' est décrite comme un aiguillage ',clred);
                  Affiche('mais la cellule représente un croisement ou une TJD/S',clred);
                  exit;
                end;
              end;

         26 : begin
               if debugTCO then AfficheDebug('El 26',clyellow);
               pos:=positionTCO(x,y);
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
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
              end;
         27 : begin
               if debugTCO then AfficheDebug('El 27',clyellow);
               pos:=positionTCO(x,y);
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
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
              end;
         28 : begin                
               if debugTCO then AfficheDebug('El 28',clyellow);
               pos:=positionTCO(x,y);
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
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
              end;
    29 : begin
           //if debugTCO then AfficheDebug('El 12',clyellow);
           pos:=positionTCO(x,y);
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
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
         end;
   32 :  begin
           if debugTCO then AfficheDebug('El 32',clyellow);
           pos:=positionTCO(x,y);
           // on vient d'en bas à gauche
           if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
           // on vient d'en bas
           if (ancienX=x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
           // on vient d'en haut à droite
           if (ancienX>x) and (ancienY<y) then begin yn:=y+1;if pos=const_devie then xn:=x else xn:=x-1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
         end;
    33 : begin
           //if debugTCO then AfficheDebug('El 14',clyellow);
           pos:=positionTCO(x,y);
           // on vient de haut
           if (ancienX=x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           // on vient de haut gauche
           if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
           //on vient de bas droite
           if (ancienX>x) and (ancienY>y) then begin yn:=y-1;if pos=const_droit then xn:=x-1 else xn:=x;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
         end;
    34 : begin
           pos:=positionTCO(x,y);
           // on vient du SE
           if (ancienX<x) and (ancienY>y) then begin yn:=y-1;if pos=const_droit then xn:=x+1 else xn:=x;end;
           // on vient du N
           if (ancienX=x) and (ancienY<y) then begin xn:=x-1;yn:=y+1;end;
           // on vient du NE
           if (ancienX>x) and (ancienY<y) then begin xn:=x-1;yn:=y+1;end;
           if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
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
      ancienX:=x;
      ancienY:=y;
      x:=xn;
      y:=yn;
    until (memTrouve) or (i>NbCellulesTCO) or (x>NbreCellX) or (y>NbreCellY) or (x=0) or (y=0) or sortir; // or not(casok) ;

   { if not(casok) then
    begin
      Affiche('Erreur TCO incohérence tracé cellule '+intToSTR(x)+','+intToSTR(y),clred);
      exit;
    end;  }
    if (i>NbCellulesTCO) then AfficheDebug('Erreur 1000 TCO : dépassement d''itérations - Route de '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    inc(direction)
  until (direction=5) or memtrouve ;

  //Affiche(intToSTR(x),clLime);
  if i>NbCellulesTCO then
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
  // et affichage de la route
  for i:=1 to ir do
  begin
    x:=routeTCO[i].x;
    y:=routeTCO[i].y;
    Tco[x,y].mode:=mode;
    //Affiche(intToSTR(x)+' '+intToSTR(y),clorange);

    bimage:=TCO[x,y].BImage;
    adresse:=TCO[x,y].Adresse;
    tco[x,y].trajet:=0;

    // croisement
    if (bimage=21) and (i>1) then
    begin
      j:=index_aig(adresse);
      mdl:=aiguillage[j].modele;
      ax:=routeTCO[i-1].x;
      ay:=routeTCO[i-1].y;
      sx:=routeTCO[i+1].x;  // suivant
      sy:=routeTCO[i+1].y;
      if (ax-x=-1) and (ay-y=0)  and  (sx-x=1)  and (sy-y=0)  then tco[x,y].trajet:=1;   // de gauche à droite
      if (ax-x=1)  and (ay-y=0)  and  (sx-x=-1) and (sy-y=0)  then tco[x,y].trajet:=1;   // de droite à gauche
      if (ax-x=-1) and (ay-y=1)  and  (sx-x=1)  and (sy-y=-1) then tco[x,y].trajet:=2;   // de bas gauche vers haut droit
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1)  and (sy-y=1)  then tco[x,y].trajet:=2;   // de haut droit vers bas gauche
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)   and (sy-y=-1) then tco[x,y].trajet:=4;   // de gauche vers haut droite
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1)  and (sy-y=0)  then tco[x,y].trajet:=4;   // de haut droite vers gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=1)   and (sy-y=0)  then tco[x,y].trajet:=3;   // de bas gauche vers droite
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1)  and (sy-y=1)  then tco[x,y].trajet:=3;   // de gauche vers haut droite
      if tco[x,y].trajet=0 then affiche('Erreur 50 TCO',clred);
    end;

    // croisement
    if (bimage=22) and (i>1) then
    begin
      j:=index_aig(adresse);
      mdl:=aiguillage[j].modele;
      ax:=routeTCO[i-1].x;  // précédent
      ay:=routeTCO[i-1].y;
      sx:=routeTCO[i+1].x;  // suivant
      sy:=routeTCO[i+1].y;
      if (ax-x=-1) and (ay-y=0)  and  (sx-x=1)  and (sy-y=0)  then tco[x,y].trajet:=1;   // de gauche à droite
      if (ax-x=1)  and (ay-y=0)  and  (sx-x=-1) and (sy-y=0)  then tco[x,y].trajet:=1;   // de droite à gauche
      if (ax-x=-1) and (ay-y=-1) and  (sx-x=1)  and (sy-y=1)  then tco[x,y].trajet:=2;   // de haut gauche vers bas droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1)  and (sy-y=-1) then tco[x,y].trajet:=2;   // de bas droit vers haut gauche
      if (ax-x=1)  and (ay-y=0)  and (sx-x=-1)  and (sy-y=-1) then tco[x,y].trajet:=3;   // de droit vers en haut à gauche
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)   and (sy-y=0)  then tco[x,y].trajet:=3;   // de haut à gauche vers droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1)  and (sy-y=0)  then tco[x,y].trajet:=4;   // de bas à droite vers gauche
      if (ax-x=-1) and (ay-y=0)  and (sx-x=1)   and (sy-y=1)  then tco[x,y].trajet:=4;   // de gauche vers en bas a droite
      if tco[x,y].trajet=0 then affiche('Erreur 51 TCO',clred);
    end;

    // croisement
    if (bimage=23) and (i>1) then
    begin
      j:=index_aig(adresse);
      mdl:=aiguillage[j].modele;
      ax:=routeTCO[i-1].x;  // précédent
      ay:=routeTCO[i-1].y;
      sx:=routeTCO[i+1].x;  // suivant
      sy:=routeTCO[i+1].y;
      if (ax-x=0)  and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[x,y].trajet:=1;   // de haut à bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[x,y].trajet:=1;   // de bas à haut
      if (ax-x=1)  and (ay-y=-1) and (sx-x=-1) and (sy-y=1)  then tco[x,y].trajet:=2;   // de haut droit vers bas gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=1)  and (sy-y=-1) then tco[x,y].trajet:=2;   // de bas gauche vers haut droit
      if (ax-x=1)  and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[x,y].trajet:=3;   // de haut droit vers bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=1)  and (sy-y=-1) then tco[x,y].trajet:=3;   // de bas vers haut droit
      if (ax-x=0)  and (ay-y=-1) and (sx-x=-1) and (sy-y=1)  then tco[x,y].trajet:=4;   // de haut vers bas gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[x,y].trajet:=4;   // de bas gauche vers haut
      if tco[x,y].trajet=0 then affiche('Erreur 52 TCO',clred);
    end;

    // croisement
    if (bimage=25) and (i>1) then
    begin
      j:=index_aig(adresse);
      mdl:=aiguillage[j].modele;
      ax:=routeTCO[i-1].x;  // précédent
      ay:=routeTCO[i-1].y;
      sx:=routeTCO[i+1].x;  // suivant
      sy:=routeTCO[i+1].y;
      if (ax-x=0)  and (ay-y=-1) and (sx-x=0)  and (sy-y=1)  then tco[x,y].trajet:=1;   // de haut à bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[x,y].trajet:=1;   // de bas à haut
      if (ax-x=-1) and (ay-y=-1) and (sx-x=1)  and (sy-y=1)  then tco[x,y].trajet:=2;   // de haut gauche vers bas droit
      if (ax-x=1)  and (ay-y=1)  and (sx-x=-1) and (sy-y=-1) then tco[x,y].trajet:=2;   // de bas droit vers haut gauche
      if (ax-x=-1) and (ay-y=1)  and (sx-x=0)  and (sy-y=1)  then tco[x,y].trajet:=3;   // de haut gauche vers bas
      if (ax-x=0)  and (ay-y=1)  and (sx-x=-1) and (sy-y=-1) then tco[x,y].trajet:=3;   // de bas vers haut gauche
      if (ax-x=0)  and (ay-y=-1) and (sx-x=1)  and (sy-y=1)  then tco[x,y].trajet:=4;   // de haut vers bas droite
      if (ax-x=-1) and (ay-y=1)  and (sx-x=0)  and (sy-y=-1) then tco[x,y].trajet:=4;   // de bas droit vers haut
      if tco[x,y].trajet=0 then affiche('Erreur 53 TCO',clred);
    end;
    Affiche_cellule(x,y);
  end;
end;

procedure dessine_icone(ip : timage;lbl : tlabel;i : integer);
const NbElLi=12;
var s : string;
begin
  if i=50 then i:=35;  // pour affichage en XY
  if i=51 then i:=36;
  if ip<>nil then
      begin
        with ip do
        begin
          width:=licone;
          height:=hicone;
          left:=((i-1) mod NbElLi)*(licone+20)+230;
          top:= ((i-1) div NbElLi)*(hicone+10)+8;
          with canvas do
          begin
            Pen.Color:=clFond;
            Brush.color:=clFond;
            Rectangle(0,0,licone,hicone);
          end;
        end;
      end;
      if lbl<>nil then
      begin
        with lbl do
        begin
          if (i=35) or (i=36) then s:=intToSTR(i+15) else
            s:=intToSTR(i);
          if i<10 then s:='  '+s;
          caption:=s;
          left:=((i-1) mod NbElLi)*(licone+20)+212;
          top:= ((i-1) div NbElLi)*(hicone+10)+16;
        end;
      end;
end;



// dessine les icones du tco et les aligne
procedure dessine_icones;
var ancH,ancW,i,lf,hf: integer;
    ip : TImage;
    lbl : Tlabel;
begin
  with formTCO do
  begin
    for i:=1 to 29 do
    begin
      ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
      lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
      dessine_icone(ip,lbl,i);
    end;

    for i:=32 to 34 do
    begin
      ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
      lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
      dessine_icone(ip,lbl,i);
    end;


    i:=50;
    ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
    lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
    dessine_icone(ip,lbl,i);
    i:=51;
    ip:=findComponent('ImagePalette'+intToSTR(i)) as Timage;
    lbl:=findComponent('Label'+intToSTR(i)) as Tlabel;
    dessine_icone(ip,lbl,i);

    // signal
    ip:=findComponent('ImagePalette51') as Timage;
    if ip<>nil then
    begin
      with ip do
      begin
        with canvas do
        begin
          Pen.Color:=clFond;
          Brush.color:=clFond;
          Rectangle(0,0,licone,hicone);
        end;
      end;
    end;

    epaisseur:=4;
    ancw:=LargeurCell;
    AncH:=hauteurCell;
    HauteurCell:=ImagePalette1.Height;
    LargeurCell:=ImagePalette1.Width;
    dessin_5(ImagePalette5.Canvas,1,1,0);  //posX,posY,état,position
    dessin_2(ImagePalette2.Canvas,1,1,0);
    dessin_3(ImagePalette3.Canvas,1,1,0);
    dessin_4(ImagePalette4.Canvas,1,1,0);
    dessin_voie(ImagePalette1.canvas,1,1,0);
    dessin_6(ImagePalette6.canvas,1,1,0);
    dessin_7(ImagePalette7.canvas,1,1,0);
    dessin_8(ImagePalette8.canvas,1,1,0);
    dessin_9(ImagePalette9.canvas,1,1,0);
    dessin_10(ImagePalette10.Canvas,1,1,0);
    dessin_11(ImagePalette11.Canvas,1,1,0);
    dessin_12(ImagePalette12.Canvas,1,1,0);
    dessin_13(ImagePalette13.Canvas,1,1,0);
    dessin_14(ImagePalette14.Canvas,1,1,0);
    dessin_15(ImagePalette15.Canvas,1,1,0);
    dessin_16(ImagePalette16.canvas,1,1,0);
    dessin_17(ImagePalette17.canvas,1,1,0);
    dessin_18(ImagePalette18.canvas,1,1,0);
    dessin_19(ImagePalette19.canvas,1,1,0);
    dessin_20(ImagePalette20.canvas,1,1,0);
    dessin_21(ImagePalette21.canvas,1,1,0);
    dessin_22(ImagePalette22.canvas,1,1,0);
    dessin_23(ImagePalette23.canvas,1,1,0);
    dessin_24(ImagePalette24.canvas,1,1,0);
    dessin_25(ImagePalette25.canvas,1,1,0);
    dessin_26(ImagePalette26.canvas,1,1,0);
    dessin_27(ImagePalette27.canvas,1,1,0);
    dessin_28(ImagePalette28.canvas,1,1,0);
    dessin_29(ImagePalette29.canvas,1,1,0);
    dessin_32(ImagePalette32.canvas,1,1,0);
    dessin_33(ImagePalette33.canvas,1,1,0);
    dessin_34(ImagePalette34.canvas,1,1,0);

    dessin_51(ImagePalette51.canvas,1,1,0); //quai

    LargeurCell:=20;

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
      TransparentBlt(ImagePalette50.canvas.Handle,8,0,largeurCell,Hauteurcell,
                 formprinc.Image9Feux.Canvas.Handle,0,0,50,90,clBlue);
  //  end;
  end;
  LargeurCell:=ancW;
  HauteurCell:=ancH;
end;

procedure TFormTCO.FormActivate(Sender: TObject);
var s : string;
begin
  if affevt then Affiche('Form TCO activate',clyellow);
  if not(Forminit) then
  begin
    FormInit:=true;
    Button1.Visible:=not(Diffusion);
    Button2.Visible:=not(Diffusion);
    ButtonCalibrage.Visible:=not(diffusion);
    ButtonSimu.Visible:=not(Diffusion);
    ImageTemp.Visible:=not(Diffusion);
    ImageTemp2.Visible:=not(Diffusion);
    ButtonTrajet.visible:=not(diffusion);
    SourisX.Visible:=not(Diffusion);
    SourisY.Visible:=not(Diffusion);
    ButtonAfficheBandeau.visible:=false;
    TrackBarZoom.Max:=ZoomMax;
    TrackBarZoom.Min:=ZoomMin;

    HauteurCell:=ImagePalette1.Height;
    LargeurCell:=ImagePalette1.Width;
    largeurCelld2:=largeurCell div 2;HauteurCelld2:=HauteurCell div 2;
    calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);

    dessine_icones;

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

    s:='Voie pouvant porter un détecteur';
    ImagePalette1.Hint:=s;ImagePalette1.ShowHint:=true;
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


    s:='Croisement ou TJD ou TJS';
    ImagePalette21.Hint:=s;ImagePalette21.ShowHint:=true;
    ImagePalette22.Hint:=s;ImagePalette22.ShowHint:=true;
    ImagePalette25.Hint:=s;ImagePalette25.ShowHint:=true;

    NbCellulesTCO:=NbreCellX*NbreCellY;
    ImageTCO.Width:=LargeurCell*NbreCellX;
    ImageTCO.Height:=HauteurCell*NbreCellY;

    ImageTCO.Picture.Create;
    ImageTCO.Picture.Bitmap.Height:=HauteurCell*NbreCellY;
    ImageTCO.Picture.BitMap.Width:=LargeurCell*NbreCellX;

    PCanvasTCO:=FormTCO.ImageTCO.Picture.Bitmap.Canvas;
    PBitMapTCO:=FormTCO.ImageTCO.Picture.Bitmap;

    PImageTCO:=FormTCO.ImageTCO;
    PImageTemp:=FormTCO.ImageTemp;
    PImageTemp.Canvas.Rectangle(0,0,PImageTemp.Width,PimageTemp.Height);



    //Affiche_tco par  r
    trackBarZoom.Position:=(ZoomMax+Zoommin) div 2;

    ScrollBox.Width:=clientWidth-80;
    if MasqueBandeauTCO then
    begin
      ButtonAfficheBandeau.visible:=true;
      BandeauMasque:=true;
      Panel1.Hide;
      ScrollBox.Height:=ClientHeight-30;
    end
    else
    begin
      BandeauMasque:=false;
      Panel1.show;
      ScrollBox.Height:=ClientHeight-Panel1.Height-30;
    end;
  end;
  TCOActive:=true;
end;


// vérifie que les icones adjacentes sont cohérentes
function verif_cellule(x,y,Bim : integer) : boolean;
var res,verif : boolean;
    Bimz,i,bl : integer;
begin
  result:=true;
  verif:=false;
  if (bim>=50) or (AvecVerifIconesTCO=0) then exit;
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
          Bimz:=tco[x-1,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],4) ) then res:=false;
        end;
        if x>1 then
        begin
          Bimz:=tco[x-1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],2) then res:=false;
        end;
        if y>1 then
        begin
          Bimz:=tco[x,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],6) then res:=false;
        end;
        if verif and not(res) then affiche('NO 0',clred);
      end;

      // N
      if (i=1) then
      begin
        if (y>1) then
        begin
          Bimz:=tco[x,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],5) ) then res:=false;
        end;
        if verif and not(res) then affiche('N 1',clred);
      end;

      // NE
      if (i=2) then
      begin
        if (x<NbreCellX) and (y>1) then
        begin
          Bimz:=tco[x+1,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],6) ) then res:=false;
        end;
        if (x<NbreCellX) then
        begin
          Bimz:=tco[x+1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],0) then res:=false;
        end;
        if (y>1) then
        begin
          Bimz:=tco[x,y-1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],4) then res:=false;
        end;
        if verif and not(res) then affiche('NE 2',clred);
      end;

      // E
      if (i=3) then
      begin
        if (x<NbreCellX) then
        begin
          Bimz:=tco[x+1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],7) ) then res:=false;
        end;
        if verif and not(res) then affiche('E 3',clred);
      end;

      // SE
      if (i=4) then
      begin
        if (x<NbreCellX) and (y<NbreCellY) then
        begin
          Bimz:=tco[x+1,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],0) ) then res:=false;
        end;
        if (x<NbreCellX) then
        begin
          Bimz:=tco[x+1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],6) then res:=false;
        end;
        if (y<NbreCellY) then
        begin
          Bimz:=tco[x,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],2) then res:=false;
        end;
        if verif and not(res) then affiche('SE 4',clred);
      end;

      // S
      if (i=5) then
      begin
        if (y<NbreCelly) then
        begin
          Bimz:=tco[x,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],1) ) then res:=false;
        end;
        if verif and not(res) then affiche('S 5',clred);
      end;

      // SO
      if (i=6) then
      begin
        if (x>1) and (y<NbreCelly) then
        begin
          Bimz:=tco[x-1,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],2) ) then res:=false;
        end;
        if x>1 then
        begin
          Bimz:=tco[x-1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],4) then res:=false;
        end;
        if (y<NbreCelly) then
        begin
          Bimz:=tco[x,y+1].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and testbit(liaisons[bimZ],0) then res:=false;
        end;
        if verif and not(res) then affiche('SO 6',clred);
      end;

      // O
      if (i=7) then
      begin
        if (x>1) then
        begin
          Bimz:=tco[x-1,y].BImage;
          if (bimz>=1) and (bimz<=25)  and (bimz<>23) and not( testbit(liaisons[bimZ],3) ) then res:=false;
        end;
        if verif and not(res) then affiche('O 7',clred);
      end;
    end;
  end;

  //if res=true then Affiche('oui',ClLime) else Affiche('non',clred);
  result:=res;
end;

procedure Annule;
var x,y,xu,yu,Xplace,yplace,adresse,i : integer;
begin
  if TamponAffecte then
  begin
    NbreCellX:=TamponTCO_org.NbreCellX;
    NbreCellY:=TamponTCO_org.NbreCellY;
    if (xCoupe<>0) and (ycoupe<>0) then
    begin
      for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do       // rectangle de la sélection
        for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
        begin
          xPlace:=xCoupe+x-TamponTCO_Org.x1;   // destination
          yPlace:=yCoupe+y-TamponTCO_Org.y1;
          if (xPlace<=NbreCellX) and (yPlace<=NbreCellY) then
          begin
            tco[xPlace,yPlace]:=tamponTCO[x,y];
            if tco[xPlace,yPlace].Bimage=50 then
            begin
              adresse:=tco[xPlace,yPlace].Adresse;
            end;
          end;
        end;
    end;
    Affiche_TCO;
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
      if (xu<=NbreCellX) and (yu<=NbreCellY) then tco[xu,yu]:=undo[rangUndo].element[i];
    end;
    Affiche_tco;
    exit;
  end;
end;


procedure stop_modetrace;
begin
  modetrace:=false;
  FormTCO.Caption:='TCO';
  screen.cursor:=crDefault;
  modeTrace:=false;
  IndexTrace:=0;
  traceXY[1].x:=0;traceXY[1].y:=0;
  traceXY[2].x:=0;traceXY[2].y:=0;
  affiche_tco;
  if debugTCO then Affiche('------------',clYellow);
  FormTCO.Caption:='TCO';
  screen.cursor:=crDefault;
end;

procedure grille;
var x,y : integer;
begin
  if not(AvecGrille) then exit;
  With PCanvasTCO do
  begin
    pen.color:=ClGrille;
    pen.Width:=1;
    Brush.Color:=ClFond;
    pen.mode:=PmCopy;
    // lignes verticales
    for x:=1 to NbreCellX do
    begin
      moveto(x*LargeurCell,1);
      LineTo(x*LargeurCell,HauteurCell*NbreCelly);
    end;
    for y:=1 to NbreCelly do
    begin
      moveto(1,y*HauteurCell);
      LineTo(LargeurCell*NbreCellX,y*HauteurCell);
    end;
  end;
end;


procedure copier;
var x,y : integer;
begin
  if SelectionAffichee then
  begin
    TamponTCO_org.NbreCellX:=NbreCellX;
    TamponTCO_org.NbreCellY:=NbreCellY;

    TamponTCO_Org.x1:=XminiSel div LargeurCell +1;
    TamponTCO_Org.x2:=XmaxiSel div LargeurCell +1;
    TamponTCO_Org.y1:=yminiSel div HauteurCell +1;
    TamponTCO_Org.y2:=ymaxiSel div HauteurCell +1;
    for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
      for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
        tamponTCO[x,y]:=tco[x,y];
    TamponAffecte:=true;
  end;
end;


procedure couper;
var x,y,XCell1,YCell1,xCell2,yCell2 : integer;
begin
  with formTCO do
  begin
    TamponTCO_org.NbreCellX:=NbreCellX;
    TamponTCO_org.NbreCellY:=NbreCellY;
    EditAdrElement.Text:='';
    EditTypeImage.Text:='';
    EditTexte.Text:='';
  end;

  // couper sans sélection : on coupe une seule cellule
  if not(SelectionAffichee) then
  begin
    tamponTCO[XclicCell,YclicCell]:=tco[XclicCell,YclicCell]; // pour pouvoir faire annuler couper
    TamponTCO_org.x1:=XclicCell;TamponTCO_org.y1:=YclicCell;
    TamponTCO_org.x2:=XclicCell;TamponTCO_org.y2:=YclicCell;

    tco[XclicCell,YClicCell].Adresse:=0;
    tco[XclicCell,YClicCell].Bimage:=0;
    tco[XclicCell,YClicCell].liaisons:=0;
    tco[XclicCell,YClicCell].Texte:='';

    efface_entoure;
    efface_cellule(formTCO.ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
    TamponAffecte:=true;
    xCoupe:=XclicCell;yCoupe:=YclicCell;
    Affiche_tco;
    exit;
  end;

  TCO_modifie:=true;
  copier;
  SelectionAffichee:=false;

  xCell1:=XminiSel div LargeurCell +1;
  xCell2:=XmaxiSel div LargeurCell +1;
  yCell1:=yminiSel div HauteurCell +1;
  yCell2:=ymaxiSel div HauteurCell +1;

  xCoupe:=XCell1;yCoupe:=yCell1;
  for y:=yCell1 to yCell2 do
    for x:=xCell1 to xCell2 do
    begin
      tco[x,y].Adresse:=0;
      tco[x,y].BImage:=0;
      tco[x,y].liaisons:=0;
      tco[x,y].Texte:='';
      //Affiche('Efface cellules '+IntToSTR(X)+' '+intToSTR(y),clyellow);
      efface_entoure;
      efface_cellule(formTCO.ImageTCO.Canvas,X,Y,PmCopy);
      if avecGrille then grille;
    end;
end;


// pour avoir les evts keydown, il faut dévalider les propriétés tabstop des boutons de la form.
procedure TFormTCO.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var s,d : integer;
    procede : boolean;
begin
  if affevt then Affiche('TCO.FormKeyDown',clOrange);

  procede:=false;  // indicateur on a tapé une touche de curseur
  //Affiche(intToSTR(key),clyellow);
  if auto_tcurs then
  case Key of
     VK_right : if XClicCell<NbreCellX then
                begin
                  inc(XClicCell);
                  d:=(xClicCell+1)*largeurcell;
                  s:=scrollBox.HorzScrollBar.Position;
                  if d-s>FormTCO.ScrollBox.Width then scrollBox.HorzScrollBar.Position:=s+largeurCell;
                  procede:=true;
                end
                else exit;
     VK_left  : if XClicCell>1 then
                begin
                  dec(XClicCell);
                  d:=(xClicCell-1)*largeurCell;
                  s:=scrollBox.HorzScrollBar.Position;
                  if d<=s then
                  begin
                    s:=s-largeurCell;
                    if s<largeurCell then s:=0;
                    scrollBox.HorzScrollBar.Position:=s;
                  end;
                  procede:=true;
                end
                else exit;
     VK_down  : if YClicCell<NbreCellY then
                begin
                  inc(YClicCell);
                  d:=(yClicCell+1)*HauteurCell;
                  s:=scrollBox.VertScrollBar.Position;
                  if d-s>FormTCO.ScrollBox.Height then scrollBox.VertScrollBar.Position:=s+HauteurCell;
                  procede:=true;
                end
                else exit;
     VK_up    : if YClicCell>1 then
                begin
                  dec(YClicCell);
                  d:=(yClicCell-1)*HauteurCell;
                  s:=scrollBox.VertScrollBar.Position;
                  if d<s then
                  begin
                    s:=s-HauteurCell;
                    if s<HauteurCell then s:=0;
                    scrollBox.VertScrollBar.Position:=s;
                  end;
                  procede:=true;
                end
                else exit;
     VK_ESCAPE  : begin
                    stop_modetrace;
                  end;
     VK_DELETE : couper;

     end;

     if (ssCtrl in Shift) and (Key = Ord('Z')) then
     begin
       annule;
       exit;
     end;

     //VK_delete : affiche('delete',clorange);
  if procede then
  begin
    LabelCoord.caption:=IntToSTR(XClicCell)+','+IntToSTR(YClicCell);
    _entoure_cell_clic;
    clicTCO:=true;
    EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
    actualise;
    clicTCO:=false;
  end;
end;

procedure Elmentdroit1Click(Sender: TObject);
begin
  dessin_voie(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  FormTCO.EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
end;

procedure Courbegaucheversdroite1Click(Sender: TObject);
var Position: TPoint;
begin
  dessin_9(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;

procedure Courbedroiteversgauche1Click(Sender: TObject);
var Position: TPoint;
begin
  dessin_8(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;


procedure CourbeSupD1Click(Sender: TObject);
var Position: TPoint;
begin
  dessin_7(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;

procedure CourbeSupG1Click(Sender: TObject);
var Position: TPoint;
begin
  dessin_6(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  GetCursorPos(Position);
end;

procedure debut_drag(image : TImage);
var h,l : integer;
begin
  image.BeginDrag(true);
  l:=image.Width;
  h:=image.height;
  StretchBlt(formTCO.ImageTemp.canvas.Handle,0,0,largeurCell,HauteurCell,   // destination avec mise à l'échelle
             image.Canvas.Handle,0,0,l,h,srccopy);

  BitBlt(OldBmp.Canvas.Handle,0,0,LargeurCell,HauteurCell,FormTCO.ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);
  StretchBlt(Vbm.Handle,0,0,largeurCell,HauteurCell,   // destination masque avec mise à l'échelle
             image.Canvas.Handle,0,0,l,h,srccopy);
  drag:=true;
  oldx:=offsetSourisX;oldy:=offsetSourisY;
end;


procedure TFormTCO.ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
var xl,yl : integer;
begin
  xl:=x+offsetSourisX;
  yl:=y+offsetSourisY;
  // Accept:=source is TImage;
  if drag then
  begin
    BitBlt(PImageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY); // remettre la sauvegarde du bitmap à l'ancienne position souris
    BitBlt(oldbmp.canvas.handle,0,0,LargeurCell,HauteurCell,PImageTCO.canvas.handle,xl,yl,SRCCOPY); // sauvegarder le bitmap actuel sous la souris
    oldx:=xl; oldy:=yl;
    BitBlt(PImageTCO.canvas.handle,xl,yl,LargeurCell,HauteurCell,Vbm.canvas.handle,0,0,SRCAND);   // prendre le masque de l'icone vers la souris, ne change rien...
    BitBlt(PImageTCO.canvas.handle,xl,yl,LargeurCell,HauteurCell,formTCO.ImageTemp.canvas.handle,0,0,SRCPAINT);  // copier l'icone vers la souris
    PImageTCO.Repaint;
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
procedure stocke_undo(i,xu,yu : integer);
begin
  if i>=100 then exit;

  tco[xu,yu].Xundo:=xu;  // stocke les coordonnées de la cellule concernée
  tco[xu,yu].Yundo:=yu;

  undo[rangUndo].element[i]:=tco[xu,yu];
  //affiche('Rang undo='+intToSTR(rangundo),clYellow);
end;

procedure TFormTCO.ImagePalette5EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,5)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  dessin_5(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=5;  // image 5
  tco[XClicCell,YClicCell].liaisons:=liaisons[5];
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette2EndDrag(Sender,Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,2)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=2;  // image 2
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  dessin_2(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].liaisons:=liaisons[2];
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette2);
end;

procedure TFormTCO.ImagePalette3EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,3)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  dessin_3(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=3;  // image 3
  tco[XClicCell,YClicCell].liaisons:=liaisons[3];
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette3);
end;

procedure TFormTCO.ImagePalette4EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,4)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_4(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=4;  // image 4
  tco[XClicCell,YClicCell].liaisons:=liaisons[4];
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
  if not(target=ImageTCO) then exit;
  if (x=0) and (y=0) then exit;
  drag:=false;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,1)) then exit;

  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_voie(ImageTCO.Canvas,XClicCell,YClicCell,0);

  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=1;  // image 1
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[XClicCell,YClicCell].liaisons:=liaisons[1];

  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;


procedure TFormTCO.ImagePalette6EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,6)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_6(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=6;  // image 6
  tco[XClicCell,YClicCell].liaisons:=liaisons[6];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette6);
end;

procedure TFormTCO.ImagePalette7EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,7)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_7(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=7;  // image 7
  tco[XClicCell,YClicCell].liaisons:=liaisons[7];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette7);
end;

procedure TFormTCO.ImagePalette8EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,8)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;;
  dessin_8(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=8;  // image 8
  tco[XClicCell,YClicCell].liaisons:=liaisons[8];
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,9)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_9(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=9;  // image 9
  tco[XClicCell,YClicCell].liaisons:=liaisons[9];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette12EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,12)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_12(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=12;  // image 12
  tco[XClicCell,YClicCell].liaisons:=liaisons[12];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;


procedure TFormTCO.ImagePalette13EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  imageTCO.repaint;
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,13)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_13(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=13;  // image 13
  tco[XClicCell,YClicCell].liaisons:=liaisons[13];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette14EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,14)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_14(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=14;  // image 14
  tco[XClicCell,YClicCell].liaisons:=liaisons[14];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette15EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,15)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_15(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=15;  // image 15
  tco[XClicCell,YClicCell].liaisons:=liaisons[15];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette16EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,16)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_16(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=16;  // image 16
  tco[XClicCell,YClicCell].liaisons:=liaisons[16];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette17EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,17)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_17(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=17;  // image 17
  tco[XClicCell,YClicCell].liaisons:=liaisons[17];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;
   
procedure TFormTCO.ImagePalette18EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,18)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_18(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=18;  // image 18
  tco[XClicCell,YClicCell].liaisons:=liaisons[18];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette19EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,19)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_19(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=19;  // image 19
  tco[XClicCell,YClicCell].liaisons:=liaisons[19];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette21EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,21)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_21(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=21;
  tco[XClicCell,YClicCell].liaisons:=liaisons[21];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette22EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;  
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,22)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_22(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=22;
  tco[XClicCell,YClicCell].liaisons:=liaisons[22];
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ButtonSauveTCOClick(Sender: TObject);
begin
  sauve_fichier_tco;
  defocusControl(ButtonSauveTCO,true);
end;

procedure TFormTCO.MenuCollerClick(Sender: TObject);
var x,y,xPlace,yPlace : integer;
begin
  if TamponAffecte then
  begin
    for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do       // rectangle de la sélection
     for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
     begin
       xPlace:=XclicCell+x-TamponTCO_Org.x1;   // destination
       yPlace:=YclicCell+y-TamponTCO_Org.y1;
       if (xPlace<=NbreCellX) and (yPlace<=NbreCellY) then tco[xPlace,yPlace]:=tamponTCO[x,y];
     end;
  end;
  Affiche_TCO;
  TCO_modifie:=true;
end;


procedure TFormTCO.MenuCopierClick(Sender: TObject);
begin
  copier;
end;

// supprimer la sélection
procedure TFormTCO.MenuCouperClick(Sender: TObject);
begin
  couper;
end;


procedure TFormTCO.AnnulercouperClick(Sender: TObject);
begin
  Annule;
end;

// renvoie un élément du TCO par l'icone en fonction du tracé désiré 4
// exemple : deux lignes qui se croisent renvoie un croisement
// el  = élement à remplacer
// Bim = élément d'origine
// quadrant du tracé (2=NE 3=Est 4=SE 5=S )
// premier : si c'est le premier élément du tracé
// dernier : si c'est le dernier élément du tracé
// on regarde si l'élément est connecté par testbit(tco[x,y].liaisons,numbit) numbit=0=NO 1=N 2=NE 3=E 4=SE 5=S 6=SO 7=O
function replace(x,y,el,quadrant : integer;premier,dernier : boolean) : integer;
var bim : integer;
begin
  //if debugTCO then Affiche('Quadrant '+intToSTR(quadrant),clred);
  result:=0;
  bim:=tco[x,y].BImage;
  // élément d'origine
  case bim of
   0 : result:=el;
   1 : begin
         if quadrant=2 then
         begin
           if premier then
           begin
             if testbit(tco[x+1,y].liaisons,3) then result:=3 else result:=7;
           end;
           if dernier then
           begin
             if testbit(tco[x-1,y].liaisons,3) then result:=2 else result:=9;
           end;
           if not(premier) and not(dernier) then result:=21;
         end;
         if quadrant=4 then
         begin
           if dernier then
           begin
             if not(testbit(tco[x-1,y].liaisons,3)) then result:=6;
             if testbit(tco[x-1,y].liaisons,3) then result:=5;
           end;
           if premier then
           begin
             if testbit(tco[x+1,y].liaisons,7) then result:=4 ;
             if not(testbit(tco[x+1,y].liaisons,7)) then result:=8;
           end;
           if not(premier) and not(dernier) then
           begin
             if testbit(tco[x-1,y].liaisons,3) and testbit(tco[x+1,y].liaisons,7) then result:=22;
             if not(testbit(tco[x-1,y].liaisons,3)) and testbit(tco[x+1,y].liaisons,7) then result:=12;
             if not(testbit(tco[x+1,y].liaisons,7)) and testbit(tco[x-1,y].liaisons,3) then result:=14;
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
           if premier then begin if testbit(tco[x+1,y-1].liaisons,6) then result:=15 else result:=9;end
           else
           if dernier then begin if testbit(tco[x-1,y+1].liaisons,2) then result:=13 else result:=7;end
           else
           if not(premier) and not(dernier) then
           begin
             if (testbit(tco[x-1,y+1].liaisons,2)) and (testbit(tco[x+1,y-1].liaisons,6)) then result:=21;
             if not(testbit(tco[x-1,y+1].liaisons,2)) and (testbit(tco[x+1,y-1].liaisons,6)) then result:=3;
             if testbit(tco[x-1,y+1].liaisons,2) and not(testbit(tco[x+1,y-1].liaisons,6)) then result:=2;
           end;
         end;
         if quadrant=5 then
         begin
           if premier then
           begin
             //       SO
             if testbit(tco[x-1,y+1].liaisons,2) then result:=32 else result:=17;
           end;
           if dernier then
           begin
              //       NE
             if testbit(tco[x+1,y-1].liaisons,6) then result:=34 else result:=18;
           end;
           if not(premier) and not(dernier) then result:=23;
         end;
       end;
  11 : begin
         if quadrant=1 then result:=19;
         if quadrant=3 then
         begin
           if dernier then begin if testbit(tco[x-1,y-1].liaisons,4) then result:=14 else result:=8;end
           else
           if premier then begin if testbit(tco[x+1,y+1].liaisons,0) then result:=12 else result:=6;end
           else
           if not(premier) and not(dernier) then
           begin
             if (testbit(tco[x-1,y-1].liaisons,4)) and (testbit(tco[x+1,y+1].liaisons,0)) then result:=22;
             if not(testbit(tco[x-1,y-1].liaisons,4)) and (testbit(tco[x+1,y+1].liaisons,0)) then result:=4;
             if testbit(tco[x-1,y-1].liaisons,4) and not(testbit(tco[x+1,y+1].liaisons,0)) then result:=5;
           end;
         end;
         if quadrant=4 then result:=11;
         if quadrant=5 then
         begin
           if dernier then
           begin
             //       NO
             if testbit(tco[x-1,y-1].liaisons,4) then result:=33 else result:=19;
           end;
           if premier then
           begin
             //       SE
             if testbit(tco[x+1,y+1].liaisons,0) then result:=29 else result:=16;
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
            if testbit(tco[x,y-1].liaisons,5) then result:=24 else result:=16;
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
              if testbit(tco[x,y+1].liaisons,1) then result:=21;result:=18;
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
              if not(testbit(tco[x,y-1].liaisons,5)) then result:=17 else result:=26;
              //                    SO
              if (testbit(tco[x-1,y+1].liaisons,2)) then result:=23;
              //                    /SO                               N
              if not(testbit(tco[x-1,y+1].liaisons,2)) and testbit(tco[x-1,y].liaisons,5) then result:=26;
            end;
            if dernier then
            begin
               //           /S
               if not(testbit(tco[x,y+1].liaisons,1)) then result:=18 else result:=27;
            end;
            if not(premier) and not(dernier) then result:=23;
          end;
          if quadrant=4 then
          begin
            if dernier then
            begin
              if (testbit(tco[x,y-1].liaisons,5)) and not(testbit(tco[x+1,y+1].liaisons,0)) then result:=24;
              if (testbit(tco[x,y-1].liaisons,5)) and (testbit(tco[x+1,y+1].liaisons,0)) then result:=25;
              if not(testbit(tco[x,y-1].liaisons,5)) and not(testbit(tco[x+1,y+1].liaisons,0)) then result:=16;
            end;
            if premier then
            begin
              if (testbit(tco[x-1,y-1].liaisons,4)) then result:=25;
              //         /NO                                          /S
              if not(testbit(tco[x-1,y-1].liaisons,4)) and not(testbit(tco[x,y+1].liaisons,1)) then result:=19;
              //         /NO                                          S
              if not(testbit(tco[x-1,y-1].liaisons,4)) and (testbit(tco[x,y+1].liaisons,1)) then result:=28;

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
              if testbit(tco[x+1,y+1].liaisons,0) then result:=25 ;
              if not(testbit(tco[x+1,y+1].liaisons,0)) then result:=24 ;
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
             if (testbit(tco[x,y-1].liaisons,5)) and (testbit(tco[x+1,y+1].liaisons,0))  and (testbit(tco[x,y+1].liaisons,1)) then result:=25 else result:=28;
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
             if (testbit(tco[x,y-1].liaisons,5)) then result:=23 else result:=32;
           end;
           if not(premier) and not(dernier) then
           begin
             //            N
             if (testbit(tco[x,y-1].liaisons,5)) then result:=23 else result:=32;
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
   tco[x,y].coulFonte:=clyellow;
   if result=1 then
   begin
     tco[x,y].repr:=2;
   end;
end;



// évènement qui se produit quand on clique gauche ou droit
procedure TFormTCO.ImageTCOMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var position : Tpoint;
    i,Bimage,xt,yt,xf,yf : integer;
begin
  if button=mbLeft then
  begin
    if affEvt then Affiche('TCO Souris clicG enfoncée',clYellow);
    if dbleClicTCO then begin dbleClicTCO:=false;exit;end;
    auto_tcurs:=true;
    clicsouris:=true;
    GetCursorPos(Position);
    Position:=formTCO.ImageTCO.screenToCLient(Position);
    //Affiche(IntToSTR(position.x),clyellow);
    Xclic:=position.X;YClic:=position.Y;
    XclicCell:=Xclic div largeurCell +1;
    YclicCell:=Yclic div hauteurCell +1;
    TempoSouris:=2 ; // démarre la tempo souris

    // clic en mode dessin
    if modeTrace then
    begin
      if indextrace=0 then
      begin
        inc(indexTrace);
        traceXY[indexTrace].x:=XClicCell;
        traceXY[indexTrace].y:=YclicCell;
        exit;
      end;

      if indextrace=1 then
      begin
        // vérifier coordonnées valides
        if ( abs(XClicCell-traceXY[1].x)=abs(YClicCell-traceXY[1].y) ) or
          ( XClicCell-traceXY[1].x=0 ) or ( YClicCell-traceXY[1].y=0 ) then
        begin
          traceXY[2].x:=XClicCell;
          traceXY[2].y:=YclicCell;
          xf:=XClicCell;
          yf:=YclicCell;

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
              stocke_undo(i,xt,yt);  // stocke les points de la ligne entière dessinée
              inc(i);
              Bimage:=replace(xt,yt,1,3,xt=traceXY[1].x,xt=traceXY[2].x);
              tco[xt,yt].BImage:=Bimage;
              tco[xt,yt].liaisons:=liaisons[Bimage];
            end;
            maj_undo(i-1); // stocke le nombre de points de la ligne

            affiche_tco;
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
                stocke_undo(i,xt,yt);
                inc(i);
                Bimage:=replace(xt,yt,20,5,yt=traceXY[1].y,yt=traceXY[2].y);
                tco[xt,yt].BImage:=Bimage;
                tco[xt,yt].liaisons:=liaisons[Bimage];
              end;
              maj_undo(i-1);
              affiche_tco;
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
                  stocke_undo(i,xt,yt);
                  inc(i);
                  Bimage:=replace(xt,yt,11,4,xt=traceXY[1].x,xt=traceXY[2].x);
                  tco[xt,yt].BImage:=Bimage;
                  tco[xt,yt].liaisons:=liaisons[Bimage];
                  inc(yt);
                end;
                maj_undo(i-1);
                affiche_tco;
              end
              else
              begin
                // tracé diagonal vers en haut à droite (quadrant 2)
                yt:=traceXY[1].y;
                i:=1;
                for xt:=traceXY[1].x to traceXY[2].x do
                begin
                  stocke_undo(i,xt,yt);
                  inc(i);
                  Bimage:=replace(xt,yt,10,2,xt=traceXY[1].x,xt=traceXY[2].x);
                  tco[xt,yt].BImage:=Bimage;
                  tco[xt,yt].liaisons:=liaisons[Bimage];
                  dec(yt);
                end;
                maj_undo(i-1);
                affiche_tco;
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

    //Temposouris:=0;
    xMiniSel:=99999;yMiniSel:=99999;
    xMaxiSel:=0;yMaxiSel:=0;
    if SelectionAffichee then
    begin
      //Affiche('efface sélection',clOrange);
      with imageTCO.Canvas do
      begin
        Pen.Mode:=PmXor;
        Pen.color:=clGrille;
        Brush.Color:=clblue;
        //FillRect(r);
        Rectangle(rAncien);
      end;
      SelectionAffichee:=false;
    end;

    // clic gauche
    clicTCO:=true;
    //Affiche('xcliccell='+IntToSTR(XclicCell)+' ycliccell='+IntToSTR(YclicCell),clyellow);
    if XclicCell>NbreCellX then exit;
    if YclicCell>NbreCellY then exit;

    if not(selectionaffichee) then _entoure_cell_clic;
    actualise;    // actualise la fenetre de config cellule
    clicTCO:=false;
  end;


  if button=mbRight then
  begin
    if affEvt then Affiche('TCO Souris clicD enfoncée',clLime);
    auto_tcurs:=true;

    if modetrace then
    begin
      traceXY[1].x:=0;traceXY[1].y:=0;
      traceXY[2].x:=0;traceXY[2].y:=0;
      indextrace:=0;
      affiche_tco;
      screen.cursor:=crUpArrow;
      exit;
    end;

    GetCursorPos(Position);
    Position:=ImageTCO.screenToCLient(Position);
    Xclic:=position.X;
    YClic:=position.Y;
    // coordonnées grille
    XclicCell:=Xclic div largeurCell + 1;
    YclicCell:=Yclic div hauteurCell + 1;
    LabelCoord.caption:=IntToSTR(XClicCell)+','+IntToSTR(YClicCell);
    XclicCellInserer:=XClicCell;
    YclicCellInserer:=YClicCell;
    //Entoure_cell(XclicCellInserer,YclicCellInserer);
    EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
    EditTypeImage.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Bimage);
  end;
end;

procedure TFormTCO.ImageTCOMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
var r : Trect;
    cellX,cellY,XSel1,YSel1,XSel2,YSel2,Bimage,xMiniSelP,yMiniSelP,xMaxiSelP,yMaxiSelP : integer;
    ok : boolean;
begin
  if affevt then Affiche('ImageTCOMouseMove',clLime);
  if dbleClicTCO then begin dbleClicTCO:=false;exit;end;
  if Temposouris>0 then begin exit;end;
  // Affiche('*',cllime);
  SourisX.Caption:=IntToSTR(x);
  SourisY.Caption:=IntToSTR(y);
  //affiche(intToSTR(x),clorange);
  cellX:=x div largeurCell+1;
  cellY:=y div hauteurCell+1;

  //Affiche('Cellx='+IntToSTR(Cellx)+' Celly='+intToSTR(Celly)+' AncienCellx='+IntToSTR(AncienXClicCell)+' AncienCelly='+intToSTR(AncienYClicCell),clorange);

  if (AncienXClicCell=CellX) and (AncienYClicCell=CellY) then exit;

  AncienXClicCell:=CellX;
  AncienYClicCell:=CellY;

  //Affiche('cellX='+IntToSTR(Cellx)+' cellY='+intToSTR(cellY),clyellow);

  if CellX>NbreCellX then exit;
  if CellY>NbreCellY then exit;

  Bimage:=tco[cellX,cellY].BImage;

  if modeTrace then
  begin
    if indexTrace>0 then
    begin
      with ImageTCO.canvas do
      begin
        Pen.Mode:=pmXor;
        Pen.Color:=clwhite;
        Pen.Width:=2;
        // efface le précédent
        if traceXY[indextrace+1].x<>0 then
        begin
          if debugTCO then Affiche('Efface précédent',clyellow);
          if ancienok then Pen.color:=clyellow else pen.color:=clGray;
          MoveTo(traceXY[indexTrace].x*largeurCell-LargeurCelld2,traceXY[indexTrace].y*hauteurCell-HauteurCelld2);
          LineTo(ancienTraceX*largeurcell-largeurCelld2,ancienTraceY*HauteurCell-HauteurCelld2);
        end;
        if debugTCO then Affiche('Trace',clyellow);
        ancienTraceX:=cellx;
        ancienTraceY:=celly;
        ok:=( abs(cellX-traceXY[indexTrace].x)=abs(cellY-traceXY[indexTrace].y) ) or
            ( cellX-traceXY[indexTrace].x=0 ) or ( cellY-traceXY[indexTrace].y=0 )  ;

        if (ancienok=false) and ok then screen.cursor:=crUpArrow;
        if ancienok and (ok=false) then screen.cursor:=crNoDrop;
        Ancienok:=ok;
        if ok then Pen.color:=clyellow else pen.color:=clGray;

        MoveTo(traceXY[indexTrace].x*largeurCell-LargeurCelld2,traceXY[indexTrace].y*hauteurCell-HauteurCelld2);
        LineTo(cellX*largeurCell-largeurCelld2,CellY*hauteurCell-HauteurCelld2);

        if ok then
        begin
          traceXY[indextrace+1].x:=cellX;
          traceXY[indextrace+1].y:=cellY;
        end;
      end;
    end;
    exit;
  end;

  if not(clicsouris) or (temposouris>0) then exit;

  xMiniSel:=(XclicCell-1)*LargeurCell;
  yMiniSel:=(YclicCell-1)*HauteurCell;
  xMaxiSel:=(cellX-1)*LargeurCell;
  yMaxiSel:=(cellY-1)*HauteurCell;

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
  if SelectionAffichee then
  with imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille;
    Brush.Color:=clblue;
    Rectangle(rAncien);
  end;

  if piloteAig then begin SelectionAffichee:=false;piloteAig:=false;exit;end;

  r:=Rect(xminiSel+1,YminiSel+1,XmaxiSel+largeurCell,yMaxiSel+hauteurCell);

  XSel1:=Xminisel div largeurCell + 1;
  YSel1:=Yminisel div hauteurCell + 1;
  XSel2:=Xmaxisel div largeurCell + 1;
  YSel2:=Ymaxisel div hauteurCell + 1;

  //Affiche(intToSTR(Xsel1)+' '+intToStr(Ysel1)+' '+intToSTR(Xsel2)+' '+intToStr(Ysel2),clYellow);
  // Affiche le nouveau rectangle de sélection
  Rancien:=r;
  with imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille;
    Brush.Color:=clblue;
    //FillRect(r);
    Rectangle(r);
  end;
  SelectionAffichee:=true;
  //Affiche('Sélection affichée',clLime);
  if entoure then begin Entoure_cell(Xentoure,Yentoure);entoure:=false;end; // efface
end;

procedure TFormTCO.ImageTCOMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if affevt then Affiche('Souris clic relachée',clyellow);
  clicsouris:=false;
end;

procedure TFormTCO.ButtonRedessineClick(Sender: TObject);
begin
  Affiche_TCO;
  defocusControl(ButtonRedessine,true);
end;

// changement de l'adresse d'un élément
procedure TFormTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index : integer;
    s: string;
begin
  //Affiche('Chgt adresse',clyellow);
  if clicTCO or not(formConfCellTCOAff) then exit;
  clicTCO:=true;
  auto_tcurs:=false;  // interdit le déplacement du curseur encadré du TCO (pour que les tuouches curseur s'applique au Tedit)

  s:=EditAdrElement.Text;
  if length(s)>1 then
  begin
    if (s[1]='A') or (s[1]='a') then delete(s,1,1);  
    EditAdrElement.Text:=s;
  end;

  Val(s,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;
  clicTCO:=false;

  if Adr=0 then tco[XClicCell,YClicCell].repr:=2;

  efface_entoure;
  tco[XClicCell,YClicCell].Adresse:=Adr;
  //formConfCellTCO.editAdrElement.Text:=intToSTR(Adr);
  tco_Modifie:=true;

  // si signal
  if tco[XClicCell,YClicCell].BImage=50 then
  begin
    index:=Index_Signal(adr);
    if index=0 then exit
    else
      begin
       //Affiche('Signal '+intToSTR(Adr),clyellow);
       affiche_tco;
     end;
  end;

  Affiche_cellule(XclicCell,YclicCell);
end;


// mise à jour des cellules de l'adresse "adresse"
procedure TFormTCO.Maj_TCO(Adresse : integer);
var x,y: integer;
begin
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if tco[x,y].Adresse=Adresse then
        begin
          affiche_cellule(x,y);
          entoure_cell_grille(x,y);
        end;
      end;
end;

procedure TFormTCO.Button1Click(Sender: TObject);
begin
  Detecteur[569].etat:=true;
  Maj_tco(569);
end;

procedure TFormTCO.Button2Click(Sender: TObject);
begin
  Detecteur[569].etat:=false;
  Maj_tco(569);
end;


procedure TFormTCO.ImagePalette10EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if not(target=ImageTCO) then exit;
  if (x=0) and (y=0) then exit;
  drag:=false;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,10)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_10(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=10;
  tco[XClicCell,YClicCell].liaisons:=liaisons[10];
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  tco[XClicCell,YClicCell].Adresse:=0;
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;


procedure TFormTCO.ImagePalette11EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(target=ImageTCO) then exit;
  if (x=0) and (y=0) then exit;
  drag:=false;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,11)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  dessin_11(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=11;
  tco[XClicCell,YClicCell].liaisons:=liaisons[11];
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  tco[XClicCell,YClicCell].Adresse:=0;
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  tco[XClicCell,YClicCell].BImage:=50;
  tco[XClicCell,YClicCell].liaisons:=0;
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[XClicCell,YClicCell].FeuOriente:=1;
  tco[XClicCell,YClicCell].PiedFeu:=1;
  tco[XClicCell,YClicCell].coulFonte:=clWhite;

  tco[XClicCell,YClicCell].x:=0;
  tco[XClicCell,YClicCell].y:=0;
  // ne pas convertir l'adresse sinon evt changement du composant et on écrase l'aspect EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
  Dessin_Signal(ImageTCO.Canvas,XClicCell,YClicCell);
end;


procedure TFormTCO.ImagePalette50MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var l,h : integer;
begin
  l:=Formprinc.Image9feux.width;    //57
  h:=Formprinc.Image9feux.height;   //105
  ImagePalette50.BeginDrag(true);
  BitBlt(OldBmp.Canvas.Handle,0,0,LargeurCell,HauteurCell,ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);
  drag:=true;
  oldx:=offsetSourisX;oldy:=offsetSourisY;

  with formTCO.ImageTemp2.Canvas do
  begin
    pen.Color:=clfond;
    brush.Color:=clblack;
    Rectangle(0,0,91,91);
  end;
  TransparentBlt(formTCO.ImageTemp2.canvas.Handle,0,0,largeurCell,HauteurCell,   // destination avec mise à l'échelle   //50,50 ok 51,51 nok
                 formprinc.Image9feux.Canvas.Handle,0,0,50,90,clblue);

  formtco.ImageTCO.repaint;
  formTCO.ImageTemp:=formTCO.ImageTemp2;
  BitBlt(formTCO.ImageTemp.canvas.Handle,0,0,20,20,formTCO.ImageTemp2.canvas.Handle,0,0,SRCCOPY);

  formtco.ImageTCO.repaint;
end;

procedure Tourne90G;
var BImage : integer;
begin
  if actualize then exit;
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>50 then exit;

  TCO_modifie:=true;

  // effacement de l'ancien signal
  if tco[XClicCell,YClicCell].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,PmCopy);
  end;

  if tco[XClicCell,YClicCell].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell-1,yClicCell,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[XClicCell,YClicCell].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,PmCopy);
  end;

  tco[XClicCell,YClicCell].FeuOriente:=2;  // signal orienté à 90° gauche
  Affiche_TCO;
  actualise;    // met à jour la fenetre de config de la cellule
end;

procedure TFormTCO.Tourner90GClick(Sender: TObject);
begin
  tourne90G;
end;

procedure tourne90D;
var BImage,aspect,adresse : integer;
begin
  if actualize then exit;
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>50 then exit;

  TCO_modifie:=true;

  adresse:=TCO[XClicCell,YClicCell].Adresse;
  aspect:=feux[Index_Signal(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // ancien signal orienté orienté 90D
  if tco[XClicCell,YClicCell].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,PmCopy);
  end;

  // ancien signal orienté orienté 90G
  if tco[XClicCell,YClicCell].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[XClicCell,YClicCell].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,PmCopy);
  end;

  tco[XClicCell,YClicCell].FeuOriente:=3;  // feu orienté à 90° droit
  Affiche_TCO;
  actualise;    // met à jour la fenetre de config de la cellule
end;

procedure TFormTCO.Tourner90DClick(Sender: TObject);
begin
  tourne90D;
end;  

procedure vertical;
var BImage ,aspect,Adresse : integer;
begin
  if actualize then exit;
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  // si c'est autre chose qu'un signal, sortir
  if Bimage<>50 then exit;

  TCO_modifie:=true;
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  aspect:=feux[Index_Signal(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // effacement de l'ancien signal

  // ancien signal orienté orienté 90D
  if tco[XClicCell,YClicCell].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    // si le signal occupe 2 cellules
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,PmCopy);
  end;

  // ancien signal orienté orienté 90G
  if tco[XClicCell,YClicCell].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    // si le signal occupe 2 cellules
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[XClicCell,YClicCell].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,PmCopy);
  end;

  tco[XClicCell,YClicCell].FeuOriente:=1;  // signal orienté à 180°
  affiche_tco;
  actualise;    // met à jour la fenetre de config de la cellule
end;

procedure TFormTCO.Pos_vertClick(Sender: TObject);
begin
  vertical;
end;

procedure TFormTCO.TrackBarZoomChange(Sender: TObject);
begin
  if affevt then Affiche('TrackVBarZoomChange',clyellow);
  calcul_cellules;
  Affiche_TCO;
  SelectionAffichee:=false;
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
begin
  if clicTCO then exit;
  if affevt then Affiche('TCO.EditTextChange',clOrange);
  auto_tcurs:=false;  // interdit le déplacement du curseur encadré du TCO (pour que les tuouches curseur s'applique au Tedit)

  PCanvasTCO.Brush.Color:=Clfond;
  efface_entoure;

  if Tco[XClicCell,YClicCell].texte='' then
  begin
    Tco[XClicCell,YClicCell].CoulFonte:=clTexte;
    Tco[XClicCell,YClicCell].TailleFonte:=8;
  end;

  Tco[XClicCell,YClicCell].Texte:=EditTexte.Text;
  formConfCellTCO.EditTexteCCTCO.Text:=EditTexte.Text;
  TCO_modifie:=true;
//  affiche_texte(XClicCell,YClicCell);
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
  zone_tco(518,514,1);
 //   zone_tco(518,515,1);

  //zone_tco(522,514,1);

  //zone_tco(514,522,1);
end;

procedure TFormTCO.CheckPinvClick(Sender: TObject);
var Bimage : integer;
begin
  if clicTCO then exit;
  if actualize then exit;
  if (xClicCell=0) or (xClicCell>NbreCellX) or (yClicCell=0) or (yClicCell>NbreCelly) then exit;
  Bimage:=Tco[xClicCell,yClicCell].Bimage;
  if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13)
     or (bimage=14) or (bimage=15) then
     begin
       TCO[xClicCell,yClicCell].inverse:=CheckPinv.checked;
       TCO_modifie:=true;
     end;
end;

procedure TFormTCO.ButtonMasquerClick(Sender: TObject);
begin
  Panel1.Hide;
  ButtonAfficheBandeau.visible:=true;
  ScrollBox.Height:=ClientHeight-40;
  //ScrollBox.Anchors:=[akLeft,AkTop,AkRight,akBottom];
  BandeauMasque:=true;
  defocusControl(ButtonMasquer,true);
end;

procedure TFormTCO.ButtonAfficheBandeauClick(Sender: TObject);
begin
  Panel1.Show;
  ButtonAfficheBandeau.visible:=false;
  ScrollBox.Height:=ClientHeight-Panel1.Height-40;
  BandeauMasque:=false;
end;

procedure TFormTCO.ImageTCODblClick(Sender: TObject);
var Bimage,Adresse,i : integer;
    tjdC : boolean;
begin
  if affEvt then Affiche('Double clic',clYellow);
  clicsouris:=false;
  auto_tcurs:=true;  // autorise le déplacement du des touches curseur encadré du TCO 

  Bimage:=Tco[xClicCell,yClicCell].BImage;
  Adresse:=Tco[xClicCell,yClicCell].Adresse;
  if adresse=0 then exit;

  // double clic sur détecteur : inversion
  if ((Bimage=1) or (Bimage=20) or (Bimage=10) or (Bimage=11)) and (adresse<>0) then
  begin
    detecteur[adresse].etat:=not(detecteur[adresse].etat);
    Affiche_tco;
  end;

  tjdC:=false;
  // commande tjd/c
  if (Bimage=21) or (Bimage=22) or (Bimage=23) or (Bimage=25) then
  begin
    i:=Index_aig(Adresse);
    tjdC:=(aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs);
  end;

  // commande aiguillage
  if (Bimage=2) or (Bimage=3) or (Bimage=4) or (Bimage=5) or (Bimage=12) or
     (Bimage=13) or (Bimage=14) or (Bimage=15) or (Bimage=24) or ((Bimage>=26) and (Bimage<=34)) or
           TJDc then
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
  if Bimage=50 then
  begin
    AdrPilote:=adresse;
    i:=Index_Signal(adresse);
    if i=0 then exit;
    TFormPilote.Create(Self);
    with formPilote do
    begin
      show;
      ImagePilote.top:=40;ImagePilote.left:=220;
      ImagePilote.Parent:=FormPilote;
      ImagePilote.Picture.Bitmap.TransparentMode:=tmAuto;
      ImagePilote.Picture.Bitmap.TransparentColor:=clblue;
      ImagePilote.Transparent:=true;

      ImagePilote.Picture.BitMap:=feux[i].Img.Picture.Bitmap;
      LabelTitrePilote.Caption:='Pilotage du signal '+intToSTR(Adresse);
      feux[0].EtatSignal:=feux[i].EtatSignal;

      LabelNbFeux.Visible:=False;
      EditNbreFeux.Visible:=false;
      GroupBox1.Visible:=true;
      GroupBox2.Visible:=true;
      efface_entoure;
      SelectionAffichee:=false;

      if (feux[i].aspect>10) and (feux[i].aspect<20) then
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
        if (feux[i].aspect<20) then GroupBox2.Visible:=true else GroupBox2.Visible:=false;
      end;
    end;
  end;
  clicsouris:=false;
  dbleClicTCO:=true;
end;

procedure TFormTCO.ComboReprChange(Sender: TObject);
begin
  if clicTCO then exit;
  tco[XClicCell,YClicCell].Repr:=comborepr.ItemIndex;
  efface_entoure;
  SelectionAffichee:=false;
  formConfCellTCO.ComboRepr.ItemIndex:=ComboRepr.ItemIndex;
  defocusControl(ComboRepr,true);
  affiche_tco;
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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  Dessin_51(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=51;
  tco[XClicCell,YClicCell].liaisons:=0;
  tco[XClicCell,YClicCell].Adresse:=0;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;


procedure TFormTCO.ImagePalette24EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,24)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_24(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=24;
  tco[XClicCell,YClicCell].liaisons:=liaisons[24];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette25EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,25)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_25(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=25;
  tco[XClicCell,YClicCell].liaisons:=liaisons[25];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette20EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,20)) then exit;
  TCO_modifie:=true;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  Dessin_20(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=20;
  tco[XClicCell,YClicCell].liaisons:=liaisons[20];
  tco[XClicCell,YClicCell].Adresse:=0;
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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

procedure change_fonte;
var s,ss : string;
    fs : TFontStyles;
begin
  s:='Fonte et couleur pour la cellule ('+intToSTR(xClicCell)+','+intToSTR(YClicCell)+') Texte: ';
  ss:=tco[xClicCell,YClicCell].Texte;
  if ss='' then s:=s+inttoSTR(tco[xClicCell,YClicCell].Adresse) else s:=s+ss;

  titre_fonte:=s;
  With FormTCO do
  begin
    FontDialog1.Font.Name:=tco[XclicCell,YclicCell].Fonte;
    FontDialog1.Font.Color:=tco[XclicCell,YclicCell].CoulFonte;
    FontDialog1.Font.Size:=tco[XclicCell,YclicCell].taillefonte;

    fs:=[];
    s:=tco[XclicCell,YclicCell].FontStyle;
    if pos('G',s)<>0 then fs:=fs+[fsbold];
    if pos('I',s)<>0 then fs:=fs+[fsItalic];
    if pos('S',s)<>0 then fs:=fs+[fsUnderline];
    if pos('B',s)<>0 then fs:=fs+[fsStrikeout];
    FontDialog1.Font.Style:=fs;

    if FontDialog1.execute then
    begin
      tco[XclicCell,YclicCell].Fonte:=FontDialog1.Font.Name;
      tco[XclicCell,YclicCell].CoulFonte:=FontDialog1.Font.Color;
      tco[XclicCell,YclicCell].taillefonte:=FontDialog1.Font.Size;
      fs:=FontDialog1.Font.Style;
      s:='';
      if fsBold in fs then s:=s+'G';
      if fsItalic in fs then s:=s+'I';
      if fsUnderline in fs then s:=s+'S';
      if fsStrikeout in fs then s:=s+'B';
      tco[XclicCell,YclicCell].FontStyle:=s;
      affiche_tco;
    end;
  end;
end;

procedure TFormTCO.ButtonFonteClick(Sender: TObject);
begin 
  change_fonte;
end;

procedure TFormTCO.FontDialog1Show(Sender: TObject);
begin
  SetWindowText(FontDialog1.Handle,pchar(titre_Fonte));
end;

procedure TFormTCO.ColorDialog1Show(Sender: TObject);
begin
  SetWindowText(ColorDialog1.Handle,pchar(titre_couleur));
end;

procedure signalD;
begin
  if actualize then exit;
  if TCO[XClicCell,YClicCell].Bimage=50 then
  begin
    TCO[XClicCell,YClicCell].PiedFeu:=2;
    Affiche_TCO;
    TCO_modifie:=true;
    actualise;    // met à jour la fenetre de config de la cellule
  end;
end;

procedure TFormTCO.Signaldroitedelavoie1Click(Sender: TObject);
begin
  signalD;
end;

procedure signalG;
begin
  if actualize then exit;
  if TCO[XClicCell,YClicCell].Bimage=50 then
  begin
    TCO[XClicCell,YClicCell].PiedFeu:=1;
    Affiche_TCO;
    TCO_modifie:=true;
    actualise;    // met à jour la fenetre de config de la cellule
  end;
end;

procedure TFormTCO.Signalgauchedelavoie1Click(Sender: TObject);
begin
  signalG;
end;

procedure TFormTCO.PopupMenu1Popup(Sender: TObject);
var oriente,piedFeu : integer;
begin
  if affevt then Affiche('on popup',clyellow);
 // if modetrace then Abort;
  PopUpMenu1.Items[9][0].Caption:='Ligne au dessus de la '+intToSTR(YclicCell);
  PopUpMenu1.Items[9][1].Caption:='Ligne en dessous de la '+intToSTR(YclicCell);
  PopUpMenu1.Items[9][3].Caption:='Colonne à gauche de la '+intToSTR(XclicCell);
  PopUpMenu1.Items[9][4].Caption:='Colonne à droite de la '+intToSTR(XclicCell);

  PopUpMenu1.Items[10][0].Caption:='Ligne '+intToSTR(YclicCell);
  PopUpMenu1.Items[10][1].Caption:='Colonne '+intToSTR(XclicCell);

  // grise ou non l'entrée signal du menu
  if tco[XClicCell,YClicCell].Bimage=50 then
  begin
    PopUpMenu1.Items[6].Enabled:=true;
    oriente:=tco[XClicCell,YClicCell].Feuoriente;
    if oriente=1 then
    begin
      PopUpMenu1.Items[6][0].checked:=false;
      PopUpMenu1.Items[6][1].checked:=false;
      PopUpMenu1.Items[6][2].checked:=true;
    end;
    if oriente=2 then
    begin
      PopUpMenu1.Items[6][0].checked:=true;
      PopUpMenu1.Items[6][1].checked:=false;
      PopUpMenu1.Items[6][2].checked:=false;
    end;
    if oriente=3 then
    begin
      PopUpMenu1.Items[6][0].checked:=false;
      PopUpMenu1.Items[6][1].checked:=true;
      PopUpMenu1.Items[6][2].checked:=false;
    end;
    PiedFeu:=tco[XClicCell,YClicCell].PiedFeu;
    if PiedFeu=1 then
    begin
      PopUpMenu1.Items[6][4].checked:=true;
      PopUpMenu1.Items[6][5].checked:=false;
    end;
    if PiedFeu=2 then
    begin
      PopUpMenu1.Items[6][4].checked:=false;
      PopUpMenu1.Items[6][5].checked:=true;
    end;
  end
  else
    PopUpMenu1.Items[6].Enabled:=false;
end;


procedure TFormTCO.N3Click(Sender: TObject);
begin
  actualise;
  FormConfCellTCO.show;
  FormConfCellTCO.BringToFront;
end;


procedure TFormTCO.LigneDessusClick(Sender: TObject);
var x,y : integer;
begin
  if NbreCellY>=MaxCellY then exit;
  TamponAffecte:=false;
  SetLength(TCO,NbreCellX+1,NbreCellY+2);  // ajoute une ligne en Y
  SetLength(TamponTCO,NbreCellX+1,NbreCellY+2);
  
  for y:=NbreCellY-1 downto YClicCell do
  begin
    for x:=1 to NbreCellX do
    begin
      tco[x,y+1]:=tco[x,y];
    end;
  end;
  for x:=1 to NbreCellX do
  begin
    tco[x,YClicCell].Adresse:=0;
    tco[x,YClicCell].BImage:=0;
    tco[x,YClicCell].inverse:=false;
    tco[x,YClicCell].repr:=0;
    tco[x,YClicCell].texte:='';
    tco[x,YClicCell].fonte:='';
    tco[x,YClicCell].CouleurFond:=Clfond;
    tco[x,YClicCell].PiedFeu:=0;
    tco[x,YClicCell].FeuOriente:=0;
  end;
  inc(NbreCellY);
  affiche_TCO;
end;

procedure TFormTCO.LigneDessousClick(Sender: TObject);
var x,y : integer;
begin
  if NbreCellY>=MaxCellY then exit;
  TamponAffecte:=false;
  SetLength(TCO,NbreCellX+1,NbreCellY+2); // ajoute une ligne en Y
  SetLength(TamponTCO,NbreCellX+1,NbreCellY+2); // ajoute une ligne en Y

  for y:=NbreCellY downto YClicCell+1 do
  begin
    for x:=1 to NbreCellX do tco[x,y+1]:=tco[x,y];
  end;
  for x:=1 to NbreCellX do
  begin
    tco[x,YClicCell+1].Adresse:=0;
    tco[x,YClicCell+1].BImage:=0;
    tco[x,YClicCell+1].inverse:=false;
    tco[x,YClicCell+1].repr:=0;
    tco[x,YClicCell+1].texte:='';
    tco[x,YClicCell+1].fonte:='';
    tco[x,YClicCell+1].Couleurfond:=Clfond;
    tco[x,YClicCell+1].PiedFeu:=0;
    tco[x,YClicCell+1].FeuOriente:=0;
  end;
  inc(NbreCellY);
  affiche_TCO;
end;

procedure TFormTCO.SupprimeLigneClick(Sender: TObject);
var x,y : integer;
begin
  if NbreCellY<=1 then exit;
  TamponAffecte:=false;
  // tampon de sauvegarde
  TamponTCO_Org.NbreCellX:=NbreCellX;
  TamponTCO_Org.NbreCellY:=NbreCellY;
  TamponTCO_Org.x1:=1;
  TamponTCO_Org.x2:=NbreCellX;
  TamponTCO_Org.y1:=1;
  TamponTCO_Org.y2:=NbreCellY; 
  xcoupe:=1;ycoupe:=1;
  for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
    for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      begin
        //Affiche(intToSTR(x)+' '+intToSTR(y),clyellow);
        tamponTCO[x,y]:=tco[x,y];
      end;  
  //TamponAffecte:=true;

  // supression ligne
  for y:=YClicCell to NbreCellY-1 do
  begin
    for x:=1 to NbreCellX do tco[x,y]:=tco[x,y+1];
  end;
  for x:=1 to NbreCellX do
  begin
    tco[x,NbreCellY].Adresse:=0;
    tco[x,NbreCellY].BImage:=0;
    tco[x,NbreCellY].inverse:=false;
    tco[x,NbreCellY].repr:=0;
    tco[x,NbreCellY].texte:='';
    tco[x,NbreCellY].fonte:='';
    tco[x,NbreCellY].Couleurfond:=Clfond;
    tco[x,NbreCellY].PiedFeu:=0;
    tco[x,NbreCellY].FeuOriente:=0;
  end;
  dec(NbreCellY);
  SetLength(TCO,NbreCellX+1,NbreCellY+1);  // ajuste la taille du tableau
  SetLength(TamponTCO,NbreCellX+1,NbreCellY+1); // ajoute une ligne en Y
  
  affiche_TCO;
end;

procedure TFormTCO.Colonnegauche1Click(Sender: TObject);
  var x,y : integer;
begin
  if NbreCellX>=MaxCellX then exit;
  TamponAffecte:=false;
  SetLength(TCO,NbreCellX+2,NbreCellY+1);  // ajoute taille X
  SetLength(TamponTCO,NbreCellX+2,NbreCellY+1); 
  
  for x:=NbreCellX downto XClicCell do
  begin
    for y:=1 to NbreCellY do tco[x+1,y]:=tco[x,y];
  end;
  for y:=1 to NbreCellY do
  begin
    tco[XClicCell,y].Adresse:=0;
    tco[XClicCell,y].BImage:=0;
    tco[XClicCell,y].inverse:=false;
    tco[XClicCell,y].repr:=0;
    tco[XClicCell,y].texte:='';
    tco[XClicCell,y].fonte:='';
    tco[XClicCell,y].Couleurfond:=Clfond;
    tco[XClicCell,y].PiedFeu:=0;
    tco[XClicCell,y].FeuOriente:=0;
  end;
  inc(NbreCellX);
  affiche_TCO;
end;

procedure TFormTCO.Colonnedroite1Click(Sender: TObject);
  var x,y : integer;
begin
  if NbreCellX>=MaxCellX then exit;
  TamponAffecte:=false;
  SetLength(TCO,NbreCellX+2,NbreCellY+1);  // ajoute taille X
  SetLength(TamponTCO,NbreCellX+2,NbreCellY+1);  // ajoute taille X
  
  for x:=NbreCellX downto XClicCell+1 do
  begin
    for y:=1 to NbreCellY do tco[x+1,y]:=tco[x,y];
  end;
  for y:=1 to NbreCellY do
  begin
    tco[XClicCell+1,y].Adresse:=0;
    tco[XClicCell+1,y].BImage:=0;
    tco[XClicCell+1,y].inverse:=false;
    tco[XClicCell+1,y].repr:=0;
    tco[XClicCell+1,y].texte:='';
    tco[XClicCell+1,y].fonte:='';
    tco[XClicCell+1,y].Couleurfond:=Clfond;
    tco[XClicCell+1,y].PiedFeu:=0;
    tco[XClicCell+1,y].FeuOriente:=0;
  end;
  inc(NbreCellX);
  affiche_TCO;
end;

// suppression colonne
procedure TFormTCO.ColonneClick(Sender: TObject);
var x,y : integer;
begin
  if NbreCellX<=1 then exit;
  TamponAffecte:=false;
  // tampon de sauvegarde
  TamponTCO_Org.NbreCellX:=NbreCellX;
  TamponTCO_Org.NbreCellY:=NbreCellY; 
  TamponTCO_Org.x1:=1;
  TamponTCO_Org.x2:=NbreCellX;
  TamponTCO_Org.y1:=1;
  TamponTCO_Org.y2:=NbreCellY; 
  xcoupe:=1;ycoupe:=1;
  for y:=TamponTCO_Org.y1 to TamponTCO_Org.y2 do
    for x:=TamponTCO_Org.x1 to TamponTCO_Org.x2 do
      tamponTCO[x,y]:=tco[x,y];
 // TamponAffecte:=true;

  // supression colonne
  for x:=xClicCell to NbreCellx-1 do
  begin
    for y:=1 to NbreCelly do
    begin
      tco[x,y]:=tco[x+1,y];
    end;
  end;
  for y:=1 to NbreCellY do
  begin
    tco[NbreCellx,y].Adresse:=0;
    tco[NbreCellx,y].BImage:=0;
    tco[NbreCellx,y].inverse:=false;
    tco[NbreCellx,y].repr:=0;
    tco[NbreCellx,y].texte:='';
    tco[NbreCellx,y].fonte:='';
    tco[NbreCellx,y].CouleurFond:=Clfond;
    tco[NbreCellx,y].PiedFeu:=0;
    tco[NbreCellx,y].FeuOriente:=0;
  end;
  dec(NbreCellX);
  SetLength(TCO,NbreCellX+1,NbreCellY+1);  // ajuste taille
  SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);  // ajuste taille

  affiche_TCO;
end;

procedure TFormTCO.buttonRazClick(Sender: TObject);
var x,y : integer;
begin
  for x:=1 to NbreCellx do
    for y:=1 to NbreCelly do tco[x,y].mode:=0;
  Affiche_TCO;
  defocusControl(buttonRaz,true);
end;

procedure TFormTCO.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var i,maxi : integer;
begin
  if affevt then Affiche('FormMouseWheel',clOrange);
  i:=FormTCO.TrackBarZoom.Position;

  if WheelDelta>0 then
  begin
    if (i<=ZoomMin) then
    begin
      FormTCO.TrackBarZoom.Position:=ZoomMin;
      exit;
    end;
    dec(i);
  end
  else
  begin
    if (i>=ZoomMax) then
    begin
      FormTCO.TrackBarZoom.Position:=ZoomMax;
      exit;
    end;
    inc(i);
  end;

  // positionner la trackbar zoom
  FormTCO.TrackBarZoom.Position:=i;
  calcul_cellules;
  Affiche_TCO;
  SelectionAffichee:=false;

  //positionner les trackbar du scrollbox sur la position cliquée de la souris
  {GetCursorPos(Position);
  x:=position.x div largeurCell +1 ;
  y:=position.Y div HauteurCell +1 ;
  }
  maxi:=ScrollBox.HorzScrollBar.Range-ScrollBox.ClientWidth;
  i:=round(xClicCell*maxi/NbreCellx);
  ScrollBox.HorzScrollBar.position:=i;

  maxi:=ScrollBox.VertScrollBar.Range-ScrollBox.ClientHeight;
  i:=round(yClicCell*maxi/NbreCelly);
  ScrollBox.VertScrollBar.position:=i;
end;

procedure TFormTCO.ButtonCalibrageClick(Sender: TObject);
var x,y : integer;
begin
   x:=0;
   y:=0;
   calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);
   with imageTCO.Canvas do
   begin
     pen.color:=clyellow;
     moveTo( round(x),round(y*frYGlob) );
     LineTo( round((x+LargeurCell)),round(y+HauteurCell*ratioC/10) );
   end;
   Affiche(formatfloat('0.000000',fryglob),clyellow);
end;

procedure change_couleur_fond;
var cs : string;
    x,y,xmini,ymini,xmaxi,ymaxi : integer;
    modeselection : boolean;
begin
  xmini:=(XminiSel div LargeurCell) +1;
  ymini:=(YminiSel div HauteurCell) +1;
  xmaxi:=(XmaxiSel div LargeurCell) +1;
  ymaxi:=(YmaxiSel div HauteurCell) +1;
  modeSelection:=xmini<xmaxi;

  if modeSelection then
  begin
    cs:='Fond de la sélection ['+intToSTR(Xmini)+','+intToSTR(Ymini)+'] ['+intToSTR(Xmaxi)+','+intToSTR(Ymaxi)+']';
    titre_couleur:=cs;
  end
  else
  begin
    if (xClicCell=0) or (YclicCell=0) then exit;
    titre_couleur:='Fond de la cellule '+intToSTR(XClicCell)+','+intToSTR(YclicCell);
  end;

  with formTCO do
  begin
    cs:='ColorA='+IntToHex(clfond,6);  // pour rajouter aux couleurs personnalisées
    colorDialog1.CustomColors.Add(cs);
    if colorDialog1.Execute then
    begin
      if modeSelection then
      begin
        selectionaffichee:=false;
        for y:=Ymini to Ymaxi do
          for x:=Xmini to Xmaxi do
          begin
            tco[x,y].CouleurFond:=ColorDialog1.Color;
          end;
      end
      else tco[XclicCell,YclicCell].CouleurFond:=ColorDialog1.Color;

      ShapeCoulFond.Brush.Color:=ColorDialog1.Color;

      TCO_modifie:=true;
      Affiche_TCO;
    end;
  end;
end;


procedure TFormTCO.ButtonCoulFondClick(Sender: TObject);
begin
  change_couleur_fond;
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
var Bimage,erreur : integer;
begin
  if clicTCO or not(formConfCellTCOAff) then exit;
  if affevt then Affiche('TCO evt editTypeImageChange',clorange);
  if actualize then exit;
  Val(EditTypeImage.Text,Bimage,erreur);
  if (erreur<>0) or not(Bimage in[0..22,24..25,50,51]) then
  begin
    exit;
  end;
  TCO_modifie:=true;
  tco[XClicCell,YClicCell].Bimage:=Bimage;
  formConfCellTCO.EditTypeImage.Text:=intToSTR(Bimage);
  actualise; // pour mise à jour de l'image de la fenetre FormConfCellTCO
  efface_entoure;
  affiche_cellule(XClicCell,YClicCell);
end;

procedure TFormTCO.outslectionner1Click(Sender: TObject);
begin
  xminiSel:=0;
  yminiSel:=0;
  xMaxiSel:=(NbreCellX-1)*LargeurCell;
  yMaxiSel:=(NbreCellY-1)*HauteurCell;
  rAncien:=rect(xminiSel,YminiSel,xmaxiSel+LargeurCell,YMaxiSel+HauteurCell);

  SelectionAffichee:=true;
  with imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille;
    Brush.Color:=clblue;
    Rectangle(rAncien);
  end;
end;

procedure TFormTCO.ButtonDessinerClick(Sender: TObject);
begin
  if not(modetrace) then
  begin
    modetrace:=true;
    indexTrace:=0;
    traceXY[1].x:=0;
    traceXY[1].y:=0;
    traceXY[2].x:=0;
    traceXY[2].x:=0;
    FormTCO.Caption:='** Mode dessin **  Clic droit pour lever le pointeur. Touche Echap pour quitter le mode tracé. CTRL-Z ou annuler pour annuler les derniers tracés.';
    screen.cursor:=crUpArrow;
  end
  else stop_modetrace;
  defocusControl(buttonDessiner,true);
end;

procedure TFormTCO.ButtonTrajetClick(Sender: TObject);
var c : Tcanvas;
begin
  c:=FormTCO.ImageTCO.canvas;
  //efface_cellule(c,5,1,pmcopy);
  TCO[5,1].Adresse:=1;dessin_2(c,5,1,1);
  TCO[7,1].Adresse:=1;dessin_3(c,7,1,1);
  TCO[9,1].Adresse:=1;dessin_4(c,9,1,1);
  TCO[11,1].Adresse:=1;dessin_5(c,11,1,1);
  TCO[5,3].Adresse:=1;dessin_12(c,5,3,1);
  TCO[7,3].Adresse:=1;dessin_13(c,7,3,1);
  TCO[9,3].Adresse:=1;dessin_14(c,9,3,1);
  TCO[11,3].Adresse:=1;dessin_15(c,11,3,1);
  TCO[5,5].Adresse:=1;dessin_24(c,5,5,1);
  

end;



procedure TFormTCO.ImagePalette26DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette26EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,26)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_26(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=26;
  tco[XClicCell,YClicCell].liaisons:=liaisons[26];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette26MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette26);
end;

procedure TFormTCO.ImagePalette23EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,23)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_23(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=23;
  tco[XClicCell,YClicCell].liaisons:=liaisons[23];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,27)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_27(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=27;
  tco[XClicCell,YClicCell].liaisons:=liaisons[27];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette28DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette28EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,28)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;

  Dessin_28(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=28;
  tco[XClicCell,YClicCell].liaisons:=liaisons[28];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);

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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,29)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_29(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=29;
  tco[XClicCell,YClicCell].liaisons:=liaisons[29];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,32)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_32(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=32;
  tco[XClicCell,YClicCell].liaisons:=liaisons[32];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,33)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_33(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=33;
  tco[XClicCell,YClicCell].liaisons:=liaisons[33];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  BitBlt(imageTCO.canvas.handle,oldx,oldy,LargeurCell,HauteurCell,oldbmp.canvas.handle,0,0,SRCCOPY);
  efface_entoure;
  imageTCO.repaint;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if not(verif_cellule(XclicCell,YclicCell,34)) then exit;
  efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
  TCO_modifie:=true;
  Dessin_34(ImageTCO.Canvas,XClicCell,YClicCell,0);
  stocke_undo(1,XClicCell,YClicCell);
  maj_undo(1);
  tco[XClicCell,YClicCell].BImage:=34;
  tco[XClicCell,YClicCell].liaisons:=liaisons[34];
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
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

end.
