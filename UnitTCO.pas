unit UnitTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote, UnitDebug,
  ComCtrls ,StrUtils, math ;

type
  TFormTCO = class(TForm)
    LabelCoord: TLabel;
    Label2: TLabel;
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
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ButtonSauveTCO: TButton;
    ButtonRedessine: TButton;
    Button1: TButton;
    Button2: TButton;
    Label19: TLabel;
    ButtonConfigTCO: TButton;
    Annulercouper: TMenuItem;
    N5: TMenuItem;
    Label20: TLabel;
    Label3: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    ButtonSimu: TButton;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    ButtonMasquer: TButton;
    ButtonAfficheBandeau: TButton;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    FontDialog1: TFontDialog;
    N2: TMenuItem;
    Signalgauchedelavoie1: TMenuItem;
    Signaldroitedelavoie1: TMenuItem;
    N3: TMenuItem;
    Signal1: TMenuItem;
    N4: TMenuItem;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    EditAdrElement: TEdit;
    EditTypeImage: TEdit;
    Label15: TLabel;
    ButtonFonte: TButton;
    Label23: TLabel;
    EditTexte: TEdit;
    ComboRepr: TComboBox;
    Label1: TLabel;
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
    Label5: TLabel;
    Label32: TLabel;
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
    ImagePalette31: TImage;
    ImagePalette30: TImage;
    ImagePalette8: TImage;
    ImageTemp: TImage;
    ImageTemp2: TImage;
    outslectionner1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
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
    procedure grille;
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
    procedure ImagePalette30EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette30MouseDown(Sender: TObject; Button: TMouseButton;
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
    procedure ImagePalette30DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Panel1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ImagePalette31DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette31EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette31MouseDown(Sender: TObject;
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


  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
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
  // liaisons des voies pour chaque icone par bit (0=NO 1=Nors 2=NE 3=Est 4=SE 5=S 6=SO 7=Ouest)
  Liaisons : array[0..29] of integer=
     (0,$88,$c8,$8c,$98,$89,$9,$84,$90,$48,$44,$11,$19,$c4,$91,$4c,$21,$24,$42,$12,$22,$cc,$99,$00,$23,$33,0,0,0,0) ;
type
  // structure du TCO
  TTCO = record
           Adresse     : integer;     // adresse du détecteur ou de l'aiguillage ou du feu
           BImage      : integer;     // 0=rien 1=voie 2=aiguillage gauche gauche ... 30=feu
           mode        : integer;     // couleur de voie 0=éteint 1=ClVoies 2=couleur en fonction du train
           trajet      : integer;     // décrit le trajet ouvert sur la voie (cas d'un croisement ou d'ue tjd/S)
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
           FeuOriente  : integer;     // orientation du signal : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit
         end;

var
  clAllume,clVoies,clFond,couleurAdresse,clGrille,cltexte,clQuai,CoulFonte,ClCanton,clPiedSignal : Tcolor;

  FormTCO: TFormTCO;

  Forminit,sourisclic,SelectionAffichee,TamponAffecte,entoure,Diffusion,TCO_modifie,
  clicTCO,piloteAig,BandeauMasque,eval_format,TCOouvert,sauve_tco,formConfCellTCOAff,
  drag : boolean;

  HtImageTCO,LargImageTCO,XclicCell,YclicCell,XminiSel,YminiSel,XCoupe,Ycoupe,Temposouris,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel ,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,Xentoure,Yentoure,RatioC,ModeCouleurCanton,
  AncienXClicCell,AncienYClicCell,LargeurCell,HauteurCell,NbreCellX,NbreCellY,NbCellulesTCO,
  Epaisseur,oldX,oldY,offsetSourisY,offsetSourisX,AvecVerifIconesTCO : integer;

  titre_Fonte : string;

  TamponTCO,tco : array of array of TTco ;

  // pour copier coller
  TamponTCO_Org : record
                   x1,y1,x2,y2,NbreCellX,NbreCellY : integer;
                 end;
  routeTCO : array[1..500] of record
      x,y : integer;
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
  {$I+}
  try
    assign(fichier,'tco.cfg');
    reset(fichier);
  except
    Affiche('Nouveau tco',clyellow);
    NbreCellX:=35;NbreCellY:=20;LargeurCell:=35;HauteurCell:=35;
    RatioC:=10;
    ClFond:=$202050;
    ClVoies:=$0077FF;
    ClAllume:=$00FFFF;
    ClGrille:=$404040;
    ClTexte:=$00FF00;
    ClQuai:=$808080;
    clPiedSignal:=$4080FF;
    ClCanton:=$00FFFF;
    AvecGrille:=true;
    SetLength(TCO,NbreCellX+1,NbreCellY+1);
    SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);
    for x:=1 to NbreCellX do
      for y:=1 to NbreCellY do
        tco[x,y].CouleurFond:=clfond;
    exit;
  end;
  {$I-}
  x:=1;y:=1;NbreCellX:=0;NbreCellY:=0; RatioC:=10;
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
        if valeur=23 then begin valeur:=31;sauve_tco:=true;end; // nouvelle version icone 23 passe à 31
        tco[x,y].Bimage:=valeur;
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
        if tco[x,y].Bimage=30 then
        begin
          i:=index_feu(adresse);
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

procedure sauve_fichier_tco;
var fichier : textfile;
    s : string;
    couleurFonte : Tcolor;
    x,y : integer;
begin
  AssignFile(fichier,'tco.cfg');
  rewrite(fichier);
  Writeln(fichier,'/ Définitions');
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

      if TCO[x,y].BImage=30 then
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


procedure TformTCO.grille;
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

function positionTCO(x,y : integer) : integer;
var position,i : integer;
begin
  i:=index_Aig(TCO[x,y].Adresse);
  position:=aiguillage[i].position ;
  if position=0 then begin result:=const_inconnu;exit;end;
  if TCO[x,y].inverse then
  begin
    if position=const_droit then begin result:=const_devie;exit;end;
    if position=const_devie then begin result:=const_droit;exit;end;
    result:=const_inconnu;
    exit;
  end
  else result:=position;
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
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Mode:=pmCopy;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    // détecteur à 1
    Adr:=TCO[x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume;
        pen.color:=clAllume;
        jy1:=y0+(HauteurCell div 2)-round(6*frYGlob); // pos Y de la bande sup
        jy2:=y0+(HauteurCell div 2)+round(6*frYGlob); // pos Y de la bande inf
        if avecGrille then r:=Rect(x0+1,jy1,x0+LargeurCell-1,jy2) else
          r:=Rect(x0,jy1,x0+LargeurCell,jy2) ;
        FillRect(r);
      end;
    end;

    // voie
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;

    jy1:=y0+(HauteurCell div 2);
    Pen.Width:=epaisseur;

    moveTo(x0,jy1);LineTo(x0+LargeurCell,jy1);
  end;
end;

procedure dessin_2(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

procedure dessin_3(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

procedure dessin_4(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

procedure dessin_5(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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


// coin supérieur gauche (Element 6)
procedure dessin_6(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);
  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// Element 7
procedure dessin_7(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// courbe: droit vers bas  -\  Element 8
procedure dessin_8(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);  
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// courbe bas gauche vers droit  Elément 9
procedure dessin_9(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// élément 10
procedure dessin_10(Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0: integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Adr:=TCO[x,y].adresse;
       
    if (Adr<>0) and (detecteur[Adr].etat) then couleur:=clAllume
    else
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    if (detecteur[Adr].etat) then
    begin
      Brush.Color:=couleur;
      pen.color:=couleur;
      Pen.Mode:=pmCopy;
      Pen.Width:=epaisseur+3;
      MoveTo(x0+largeurCell,y0);LineTo(x0,y0+hauteurCell);
      pen.color:=clvoies;
    end;
    Brush.Color:=couleur;
    pen.color:=couleur; 
    Pen.Mode:=pmCopy;
    Pen.Width:=epaisseur;
    MoveTo(x0+largeurCell,y0);LineTo(x0,y0+hauteurCell);
  end;

end;

// élément 11
procedure dessin_11(Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Adr:=TCO[x,y].adresse;
    if (Adr<>0) and (detecteur[Adr].etat) then couleur:=clAllume
    else
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    if (detecteur[Adr].etat) then
    begin
      Brush.Color:=couleur;
      pen.color:=couleur;
      Pen.Mode:=pmCopy;
      Pen.Width:=epaisseur+3;
      moveTo(x0,y0);LineTo(x0+largeurCell,y0+hauteurCell);
      pen.color:=clvoies;
    end;
    pen.color:=couleur; 
    Brush.Color:=couleur;
    Pen.Mode:=pmCopy;
    Pen.Width:=epaisseur;
    moveTo(x0,y0);LineTo(x0+largeurCell,y0+hauteurCell);
  end;
end;


// Element 12
procedure dessin_12(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

// Elément 13
procedure dessin_13(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

// Element 14
procedure dessin_14(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

// Element 15
procedure dessin_15(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,xc,yc,xf,yf,x1,x2,y1,y2,x3,position : integer;
    r : Trect;
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

// Element 16
procedure dessin_16(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// Element 17
procedure dessin_17(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// Elément 18
procedure dessin_18(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// Element 19
procedure dessin_19(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurcell div 2);
  yc:=y0+(Hauteurcell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Width:=1;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// Element 20
procedure dessin_20(Canvas : Tcanvas;x,y,mode: integer);
var jx1,jx2,x0,y0,xc,adr : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);

  with canvas do
  begin
    Brush.Color:=TCO[x,y].CouleurFond;
    Pen.Mode:=pmCopy;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    // détecteur à 1
    Adr:=TCO[x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume;
        pen.color:=clAllume;
        jx1:=x0+(LargeurCell div 2)-round(6*frxGlob); // pos Y de la bande sup
        jx2:=x0+(LargeurCell div 2)+round(6*frxGlob); // pos Y de la bande inf
        if avecGrille then r:=Rect(jx1,y0+1,jx2,y0+HauteurCell-1) else
          r:=Rect(jx1,y0,jx2,y0+HauteurCell) ;
        FillRect(r);
      end;
    end;

    // voie
    case mode of
      0: couleur:=clVoies;
      1: couleur:=ClCanton;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;

    jx1:=y0+(HauteurCell div 2);
    Pen.Width:=epaisseur;

    MoveTo(xc,y0);LineTo(xc,y0+HauteurCell);
  end;
end;

// Element 21 - croisement - TJD
procedure dessin_21(Canvas : Tcanvas;x,y,mode : integer);
var x0,y0,xc,yc,trajet : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(largeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xc:=x0+(LargeurCell div 2);
  yc:=y0+(hauteurCell div 2);

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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

// Element 23 (31)
procedure dessin_31(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,x2,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Pen.Width:=1;
    Brush.Color:=TCO[x,y].CouleurFond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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
procedure dessin_24(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xc,yc,jx1,jy1,jx2,xf,yf,position : integer;
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
    r:=Rect(x0,y0,xf,yf);
    FillRect(r);      // efface la cellule

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

// Element 25  croisement
procedure dessin_25(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xf,yf,xc,yc,trajet : integer;
    r : Trect;
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
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

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



// calcul des facteurs de réductions X et Y pour l'adapter à l'image de destination
procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
begin
  frX:=DimDestX/DimOrgX;
  frY:=DimDestY/DimOrgY;
  //Affiche(formatfloat('0.000000',frY),clyellow);
end;

// Affiche dans le TCO en x,y un signal à 90° d'après l'image transmise
// x y en coordonnées pixels
procedure Feu_90G(ImageSource : TImage;x,y : integer;FrX,FrY : real);
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
  // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
  PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

  // copie l'image du signal retournée depuis image temporaire vers tco avec une réduction en mode transparennt
  TransparentBlt(PcanvasTCO.Handle,x,y,round(TailleY*FrY),round(TailleX*FrX),   // destination
                 PImageTemp.Canvas.Handle,0,0,TailleY,TailleX,clBlue);    // source - clblue est la couleur de transparence
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

// copie de l'image du signal à 90° dans le canvas source et le tourne de 90° et le met dans l'image temporaire
procedure Feu_90D(ImageSource : TImage;x,y : integer ; FrX,FrY : real);
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
  // copie l'image du signal depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
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
    frYR:=frY*ratioC/10;
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
procedure dessin_feu(CanvasDest : Tcanvas;x,y : integer );
var  x0,y0,xp,yp,orientation,adresse,aspect,PiedFeu,TailleX,TailleY : integer;
     ImageFeu : Timage;
     frX,frY : real;
begin
  Efface_Cellule(CanvasDest,x,y,pmCopy);

  xp:=(x-1)*LargeurCell;
  yp:=(y-1)*HauteurCell;
  Adresse:=TCO[x,y].Adresse;

  Orientation:=TCO[x,y].FeuOriente;
  if Orientation=0 then Orientation:=1;  // cas d'un signal non encore renseigné

  aspect:=feux[index_feu(adresse)].aspect;
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
    // copie avec mise à l'échelle de l'image du signal
    TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   ImageFeu.Canvas.Handle,0,0,TailleX,TailleY,clBlue);
    PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
    case aspect of
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
    Feu_90G(ImageFeu,x0,y0,frX,frY); // ici on passe l'origine du signal
    // dessiner le pied
    case aspect of
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
    Feu_90D(ImageFeu,x0,y0,frX,frY);
    // dessiner le pied
    case aspect of
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
var i,repr,Xorg,Yorg,xt,yt,mode,adresse,Bimage,aspect,oriente,pied : integer;
    s : string;
begin
  //Affiche('Affiche_cellule',clLime);
  PcanvasTCO.pen.Mode:=PmCopy;
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
    0 : efface_cellule(PCanvasTCO,x,y,pmcopy);
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
   23,31 : dessin_31(PCanvasTCO,X,Y,mode);
   24 : dessin_24(PCanvasTCO,X,Y,mode);
   25 : dessin_25(PCanvasTCO,X,Y,mode);
   30 : dessin_feu(PCanvasTCO,X,Y);
   end;

  PCanvasTCO.font.Size:=(LargeurCell div 10)+4  ;
  //Affiche(intToSTR( (LargeurCell div 30)+6),clyellow);

  // affiche le texte des aiguillages
  if ((BImage=2) or (BImage=3) or (BImage=4) or (BImage=5) or (BImage=12) or (BImage=13) or (BImage=14) or
      (BImage=15) or (BImage=21) or (BImage=22) or (BImage=24) or (BImage=25)) and (adresse<>0) then
  begin
    s:='A'+s;
    with PCanvasTCO do
    begin
      Brush.Color:=tco[x,y].CouleurFond;
      Font.Color:=tco[x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      xt:=0;yt:=0;
      if Bimage=2  then begin xt:=3;yt:=1;end;
      if Bimage=3  then begin xt:=3;yt:=HauteurCell-round(20*fryGlob);end;
      if Bimage=4  then begin xt:=3;yt:=1;end;
      if Bimage=5  then begin xt:=3;yt:=HauteurCell-round(20*fryGlob);end;
      if Bimage=12 then begin xt:=3;yt:=HauteurCell-round(20*frYGlob);end;
      if Bimage=13 then begin xt:=3;yt:=1;end;
      if Bimage=14 then begin xt:=LargeurCell-round(25*frXGlob);yt:=1;end;
      if Bimage=15 then begin xt:=3;yt:=1;end;
      if Bimage=21 then begin xt:=3;yt:=1;end;
      if Bimage=22 then begin xt:=3;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=24 then begin xt:=3;yt:=HauteurCell-round(15*frYGlob);end;
      if Bimage=25 then begin xt:=1;yt:=HauteurCell-round(15*frYGlob);end;
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
      i:=detecteur[adresse].AdrTrain;
      if i<>0 then
      begin
        i:=index_train_adresse(i);
        if i<>0 then
        begin
          case repr of
            1,3 : yt:=1;  // haut
            2 : yt:=HauteurCell-round(17*frYGlob);   // bas
          end;
          s:=trains[i].nom_train;
          PCanvasTCO.font.Size:=(LargeurCell div 13)+4  ;
          TextOut(xOrg,Yorg+yt,s);
        end;
      end;
    end;
  end;

  // autres détecteurs
  if ((Bimage=7) or (Bimage=8) or (Bimage=9) or (Bimage=10) or (Bimage=11) or (Bimage=17)  or (Bimage=20))  and (adresse<>0) then
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
  if (BImage=30) and (adresse<>0) then
  begin
    aspect:=feux[index_feu(adresse)].Aspect;
    oriente:=TCO[x,y].FeuOriente;
    pied:=TCO[x,y].PiedFeu;
    xt:=0;yt:=0;
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
    if (aspect>10) and (oriente=1) then begin xt:=1;yt:=HauteurCell-round(14*frYGlob);end;
    if (aspect>10) and (oriente=2) then begin xt:=LargeurCell-round(15*frXGlob);yt:=0;end;
    if (aspect>10) and (oriente=3) then begin xt:=LargeurCell-round(15*frXGlob);yt:=0;end;

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

  if (TCO[x,y].BImage=23) or (TCO[x,y].BImage=31) then PCanvasTCO.Brush.Color:=clQuai else PCanvasTCO.Brush.Color:=tco[x,y].CouleurFond;
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
var x,y,DimX,DimY : integer;
    s : string;
    r : Trect;
begin
  if affevt then affiche('Affiche_tco',clLime);
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
    HorzScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si onclique sur la trackbar!!
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
    Brush.Color:=Clfond;
    pen.color:=clyellow;
    r:=rect(0,0,NbreCellX*LargeurCell,NbreCelly*HauteurCell);
    FillRect(r);
  end;

  //afficher les cellules sauf les signaux
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage<>30 then
        begin
          affiche_cellule(x,y);
        end;
      end;

  //afficher les cellules des signaux et les textes pour que les pieds recouvrent le reste et afficher les textes
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage=30 then
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
  if affevt then Affiche('FormTCO create',clyellow);
  offsetSourisY:=-10;
  offsetSourisX:=-10;
  caption:='TCO';
  AvecGrille:=true;
  TCO_modifie:=false;
  XclicCell:=1;
  YclicCell:=1;
  xCoupe:=0;yCoupe:=0;
  KeyPreview:=false; // invalide les évènements clavier
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
  //controlStyle:=controlStyle+[csOpaque];

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
  s:='Erreur TCO: ';
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
    memtrouve,sortir,horz,diag : boolean;
    mdl : Tequipement;
    s : string;
begin
  // trouver le détecteur det1
  if debugTCO then AfficheDebug('Zone_TCO det1='+intToSTR(det1)+' det2='+intToSTR(det2)+' mode='+intToSTR(mode)+' couleur='+intToSTR(index_couleur),clyellow);
  trouve_det(det1,Xdet1,Ydet1);
  if (Xdet1=0) or (Ydet1=0) then exit;

  trouve_det(det2,Xdet2,Ydet2);
  if (Xdet2=0) or (Ydet2=0) then exit;

  // inverser coordonnées des détecteurs si à l'envers en X

  if debugTCO then
  begin
    AfficheDebug('trouvé '+intToSTR(det1)+' en '+IntToSTR(xDet1)+'/'+intToSTR(ydet1),clyellow);
    AfficheDebug('trouvé '+intToSTR(det2)+' en '+IntToSTR(xDet2)+'/'+intToSTR(ydet2),clyellow);
  end;

  memtrouve:=false;

  Direction:=1;
  repeat  // boucle de test de direction
    sortir:=false;
    x:=xDet1;y:=Ydet1;
    xn:=x;yn:=y;
    ir:=1;    // index de la route du tco
    i:=0;
    if debugTCO then afficheDebug('Direction '+intToSTR(direction),clOrange);
    if direction=1 then
    begin
       // commencer par descendre et à droite
       ancieny:=ydet1+1;
       ancienx:=xdet1+1;
    end;
    if direction=2 then
    begin
      // commencer par monter et à gauche
      ancieny:=ydet1-1;
      ancienx:=xdet1-1;
    end;
    if direction=3 then
    begin
      // commencer par descendre et à droite
      ancieny:=ydet1+1;
      ancienx:=xdet1+1;
    end;
    if direction=4 then
    begin
      // commencer par monter et à droite
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
            if (ancienX<x) and (ancienY=y) then xn:=x+1;
            if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;if pos=const_devie then yn:=y+1;end;
            if (ancienX<x) and (ancienY>y) then xn:=x+1;
            if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
          end;
      3 : begin
            //if debugTCO then AfficheDebug('El 3',clyellow);
            pos:=positionTCO(x,y);
            if (ancienX<x) then begin xn:=x+1;if pos=const_devie then yn:=y-1;end;
            if (ancienX>x) and (ancienY=Y) then xn:=x-1;
            if (ancienX>x) and (ancienY<y) then xn:=x-1;
            if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
          end;
      4 : begin
            //if debugTCO then AfficheDebug('El 4',clyellow);
            pos:=positionTCO(x,y);
            if (ancienX<x) and (ancienY=Y) then begin xn:=x+1;if pos=const_devie then yn:=y+1;end;
            if (ancienX>x) and (ancienY=Y) then xn:=x-1;
            if (ancienX>x) and (ancienY>y) then xn:=x-1;
            if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
          end;
    5 : begin
          //if debugTCO then AfficheDebug('El 5',clyellow);
          pos:=positionTCO(x,y);
          if (ancienX<x) and (ancienY=Y) then xn:=x+1;
          if (ancienX>x) and (ancienY=Y) then begin xn:=x-1;if pos=const_devie then yn:=y-1;end;    
          if (ancienX<x) and (ancienY<y) then xn:=x+1;
          if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;;
        end;
    6 : begin
         //if debugTCO then AfficheDebug('El 6',clyellow);
         if ancienX<x then xn:=x+1
           else begin xn:=x-1;yn:=y-1;end;
         end;  
    7 : if ancienx<x then begin xn:=x+1;yn:=y-1; end else xn:=x-1;
    8 : if ancienX<x then begin xn:=x+1;yn:=y+1; end else xn:=x-1;
    9 : if ancienX<x then xn:=x+1 else begin xn:=x-1;yn:=y+1;end;
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
    16 : if ancienX<x then yn:=y+1 else begin xn:=x-1;yn:=y-1;end;
    17 : if ancienY<y then begin yn:=y+1;end else begin xn:=x+1;yn:=y-1;end;
    18 : if AncienX<x then yn:=y-1 else begin yn:=y+1;xn:=x-1;end;
    19 : begin
           //if debugTCO then AfficheDebug('El 19',clyellow);
           if ancienY<y then begin xn:=x+1;yn:=y+1;end else yn:=y-1;
         end; 
    20 : begin
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
               pos:=aiguillage[j].position;
               if (pos=const_inconnu) then begin Erreur_TCO(x,y);exit;end;

               if (mdl=tjd) or (mdl=tjs) and (aiguillage[j].EtatTJD=4) then
               begin
                 j:=Index_Aig(aiguillage[j].Ddroit);
                 pos2:=aiguillage[j].position; // 2eme adresse de la TJD
                 if (pos2=const_inconnu) then begin Erreur_TCO(x,y);exit;end;
                 if (pos=const_droit) and (pos2=const_droit) then
                 begin
                   if ancienX<x then xn:=x+1 else xn:=x-1;
                 end;
                 if (pos=const_devie) and (pos2=const_devie) then
                 begin
                   if ancienX<x then begin xn:=x+1;yn:=y-1;end
                   else begin xn:=x-1;yn:=y+1;end;
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

               if (mdl=tjd) or (mdl=tjs) and (aiguillage[j].EtatTJD=2) then
               begin
                 if (pos=const_droit) then
                 begin
                   if ancienX<x then xn:=x+1 else xn:=x-1;
                 end;
                 if (pos=const_devie) then
                 begin
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
             if (ancienX<x) and (ancienY=Y) then xn:=x+1;
             if (ancienX>x) and (ancienY=Y) then xn:=x-1;
             if (ancienX<x) and (ancienY>Y) then begin xn:=x+1;yn:=y-1;end;
             if (ancienX>x) and (ancienY<Y) then begin xn:=x-1;yn:=y+1;end;
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

               if (mdl=tjd) or (mdl=tjs) and (aiguillage[j].EtatTJD=4) then
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
               if (mdl=tjd) or (mdl=tjs) and (aiguillage[j].EtatTJD=2) then
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
             if (ancienX<x) and (ancienY=Y) then xn:=x+1;
             if (ancienX>x) and (ancienY=Y) then xn:=x-1;
             if (ancienX>x) and (ancienY>Y) then begin xn:=x-1;yn:=y-1;end;
             if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=y+1;end;
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

                    if (mdl=tjd) or (mdl=tjs) and (aiguillage[j].EtatTJD=4) then
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
                    if (mdl=tjd) or (mdl=tjs) and (aiguillage[j].EtatTJD=2) then
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
                  if (ancienX<x) and (ancienY<Y) then begin xn:=x+1;yn:=yn+1;end;
                  if (ancienX>x) and (ancienY>Y) then begin xn:=x-1;yn:=yn-1;end;
                  if (ancienX=x) and (ancienY<Y) then begin xn:=x;yn:=y+1;end;
                  if (ancienX=x) and (ancienY>Y) then begin xn:=x;yn:=y-1;end;
                end;

              end
         else

         begin
           // fausse route, sortir
           //if DebugTCO then
           //  AfficheDebug('Sortie de calcul route TCO par élement '+intToSTR(Bimage)+' inconnu en x='+intToSTR(x)+' y='+intToSTR(y)+' sur route '+intToSTR(det1)+' à '+intToSTR(det2),clOrange);
           sortir:=true;
         end;
      end;
      inc(i);
      if adresse=det2 then memTrouve:=true;
      ancienX:=X;
      ancienY:=y;
      x:=xn;
      y:=yn;
    until (memTrouve) or (i>NbCellulesTCO) or (x>NbreCellX) or (y>NbreCellY) or (x=0) or (y=0) or sortir;
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
      if tco[x,y].trajet=0 then affiche('Erreur 52 TCO',clred);
    end;
    Affiche_cellule(x,y);
  end;
end;

procedure TFormTCO.FormActivate(Sender: TObject);
var s : string;
    r :Trect;
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
    SourisX.Visible:=not(Diffusion);
    SourisY.Visible:=not(Diffusion);
    ButtonAfficheBandeau.visible:=false;
    TrackBarZoom.Max:=ZoomMax;
    TrackBarZoom.Min:=ZoomMin;

    HauteurCell:=ImagePalette1.Height;
    LargeurCell:=ImagePalette1.Width;
    calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);

    // dessiner les icônes
    epaisseur:=5;
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
    dessin_31(ImagePalette31.canvas,1,1,0);
    dessin_24(ImagePalette24.canvas,1,1,0);
    dessin_25(ImagePalette25.canvas,1,1,0);

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

    With ImagePalette30 do
    begin
      Picture.Bitmap.TransparentMode:=tmAuto;
      Picture.Bitmap.TransparentColor:=clblue;
      Transparent:=true;
      Picture.Bitmap:=Formprinc.Image9feux.Picture.Bitmap;

    end;

    //Affiche_tco par  r
    trackBarZoom.Position:=(ZoomMax+Zoommin) div 2;

    ScrollBox.Width:=clientWidth-80;
    //ScrollBox.Width:=clientWidth-200;
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
  TCOouvert:=true;
end;

// evt qui se produit quand on clic droit dans l'image
procedure TFormTCO.ImageTCOContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var  Position: TPoint;
begin
  GetCursorPos(Position);

  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;

  _entoure_cell_clic;

  LabelCoord.caption:=IntToSTR(XclicCell)+','+IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);
  //Affiche('XClicCell='+intToSTR(XclicCell)+' '+'YClicCell='+intToSTR(YclicCell),clyellow);
end;

// vérifie que les icones adjacentes sont cohérentes
function verif_cellule(x,y,Bim : integer) : boolean;
var res,verif : boolean;
    Bimz,i : integer;
    bl,bz : integer;
begin
  result:=true;
  verif:=false;
  if (bim=23) or (bim>=30) or (AvecVerifIconesTCO=0) then exit;
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

procedure TFormTCO.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  exit;
  if affevt then Affiche('TCO.FormKeyDown',clOrange);
  Entoure_cell(XclicCell,YclicCell);
  case Key of
     VK_right : if XClicCell<NbreCellX then inc(XClicCell);
     VK_left  : if XClicCell>1 then dec(XClicCell);
     VK_down  : if YClicCell<NbreCellY then inc(YClicCell);
     VK_up    : if YClicCell>1 then dec(YClicCell);
     VK_delete : affiche('delete',clorange);
  end;
  LabelCoord.caption:=IntToSTR(XClicCell)+','+IntToSTR(YClicCell);
  Entoure_cell(XclicCell,YclicCell);
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
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
begin
  image.BeginDrag(true);
  StretchBlt(formTCO.ImageTemp.canvas.Handle,0,0,largeurCell,HauteurCell,   // destination avec mise à l'échelle
             image.Canvas.Handle,0,0,41,41,srccopy);

  BitBlt(OldBmp.Canvas.Handle,0,0,LargeurCell,HauteurCell,FormTCO.ImageTCO.Canvas.Handle,offsetSourisX,offsetSourisY,SRCCOPY);
  StretchBlt(Vbm.Handle,0,0,largeurCell,HauteurCell,   // destination masque avec mise à l'échelle
             image.Canvas.Handle,0,0,41,41,srccopy);
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

  TCO_modifie:=true;

  dessin_5(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=5;  // image 5
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

  TCO_modifie:=true;

  tco[XClicCell,YClicCell].BImage:=2;  // image 2
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  dessin_2(ImageTCO.Canvas,XClicCell,YClicCell,0);
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

  TCO_modifie:=true;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  dessin_3(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=3;  // image 3
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

  TCO_modifie:=true;
  dessin_4(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=4;  // image 4
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

  TCO_modifie:=true;
  dessin_voie(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=1;  // image 1
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  tco[XClicCell,YClicCell].Adresse:=0;
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

  TCO_modifie:=true;
  dessin_6(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=6;  // image 6
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

  TCO_modifie:=true;
  dessin_7(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=7;  // image 7
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

  TCO_modifie:=true;;
  dessin_8(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=8;  // image 8
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

  TCO_modifie:=true;
  dessin_9(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=9;  // image 9
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

  TCO_modifie:=true;
  dessin_12(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=12;  // image 12
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

  TCO_modifie:=true;
  dessin_13(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=13;  // image 13
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

  TCO_modifie:=true;
  dessin_14(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=14;  // image 14
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

  TCO_modifie:=true;

  Dessin_15(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=15;  // image 15
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

  TCO_modifie:=true;

  Dessin_16(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=16;  // image 16
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

  TCO_modifie:=true;
  Dessin_17(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=17;  // image 17
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

  TCO_modifie:=true;

  Dessin_18(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=18;  // image 18
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

  TCO_modifie:=true;
  Dessin_19(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=19;  // image 19
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

  TCO_modifie:=true;
  Dessin_21(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=21;
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

  TCO_modifie:=true;

  Dessin_22(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=22;
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ButtonSauveTCOClick(Sender: TObject);
begin
  sauve_fichier_tco;
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

procedure TFormTCO.MenuCopierClick(Sender: TObject);
begin
  copier;
end;

// supprimer la sélection
procedure TFormTCO.MenuCouperClick(Sender: TObject);
var  x,y,XCell1,YCell1,xCell2,yCell2 : integer;
begin
  TamponTCO_org.NbreCellX:=NbreCellX;
  TamponTCO_org.NbreCellY:=NbreCellY;
  
  // couper sans sélection : on coupe une seule cellule
  if not(SelectionAffichee) then
  begin
    tamponTCO[XclicCell,YclicCell]:=tco[XclicCell,YclicCell]; // pour pouvoir faire annuler couper
    TamponTCO_org.x1:=XclicCell;TamponTCO_org.y1:=YclicCell;
    TamponTCO_org.x2:=XclicCell;TamponTCO_org.y2:=YclicCell;

    tco[XclicCell,YClicCell].Adresse:=0;
    tco[XclicCell,YClicCell].Bimage:=0;
    tco[XclicCell,YClicCell].Texte:='';

    efface_entoure;
    efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,PmCopy);
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
      tco[x,y].Texte:='';
      //Affiche('Efface cellules '+IntToSTR(X)+' '+intToSTR(y),clyellow);
      efface_entoure;
      efface_cellule(ImageTCO.Canvas,X,Y,PmCopy);
      if avecGrille then grille;
    end;
end;

procedure TFormTCO.AnnulercouperClick(Sender: TObject);
var x,y,Xplace,yplace,adresse : integer;
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
            if tco[xPlace,yPlace].Bimage=30 then
            begin
              adresse:=tco[xPlace,yPlace].Adresse;
            end;
          end;
        end;
    end;
  end;
  Affiche_TCO;
end;


// évènement qui se produit quand on clique gauche ou droit
procedure TFormTCO.ImageTCOMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var position : Tpoint;
    Bimage : integer;
    s : string;
begin
  if button=mbLeft then
  begin
    if affEvt then Affiche('TCO Souris clicG enfoncée',clLime);
    Temposouris:=0;
    xMiniSel:=99999;yMiniSel:=99999;
    xMaxiSel:=0;yMaxiSel:=0;
    sourisclic:=true;
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
    GetCursorPos(Position);

    Position:=formTCO.ImageTCO.screenToCLient(Position);
    //Affiche(IntToSTR(position.x),clyellow);
    Xclic:=position.X;YClic:=position.Y;
    XclicCell:=Xclic div largeurCell +1;
    YclicCell:=Yclic div hauteurCell +1;
    //Affiche('xcliccell='+IntToSTR(XclicCell)+' ycliccell='+IntToSTR(YclicCell),clyellow);
    if XclicCell>NbreCellX then exit;
    if YclicCell>NbreCellY then exit;
    Bimage:=tco[XClicCell,YClicCell].Bimage;
    if formConfCellTCOAff then
    begin

    // si aiguillage, mettre à jour l'option de pilotage inverse
    if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13)
       or (bimage=14) or (bimage=15) or (bimage=24) then
    begin
      // aiguillage inversé
      with FormConfCellTCO.CheckPinv do
      begin
        enabled:=true;
        checked:=TCO[XClicCell,YClicCell].inverse;
      end;
      CheckPinv.checked:=TCO[XClicCell,YClicCell].inverse;
      CheckPinv.enabled:=true ;
    end
    else
    begin
      CheckPinv.enabled:=false;
      FormConfCellTCO.checkPinv.enabled:=false;
    end;
    end;

    // si voie ou rien ou signal ou quai
    if (Bimage=1) or (Bimage=0) or (Bimage=23) or (Bimage=31) or (Bimage=30) then
    begin
      s:=Tco[XClicCell,YClicCell].Texte;
      EditTexte.Text:=s;
      EditTexte.Visible:=true;
      ComboRepr.Enabled:=true;
    end
    else
    begin
      formTCO.EditTexte.Visible:=false;
      formTCO.comboRepr.Enabled:=false;
    end;

    s:=IntToSTR(XclicCell)+','+IntToSTR(YclicCell);
    LabelCoord.caption:=s;
    GroupBox1.Caption:='Configuration cellule '+s;
    XclicCellInserer:=XClicCell;
    YclicCellInserer:=YClicCell;
    EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
    EdittypeImage.Text:=IntToSTR(BImage);
    ComboRepr.ItemIndex:=tco[XClicCell,yClicCell].repr;
    ShapeCoulFond.Brush.Color:=tco[XClicCell,yClicCell].CouleurFond;

    if not(selectionaffichee) then _entoure_cell_clic;
    actualise;    // actualise la fenetre de config cellule
    clicTCO:=false;
  end;

  if button=mbRight then
  begin
    if affEvt then Affiche('TCO Souris clicD enfoncée',clLime);
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
    cellX,cellY,x0,y0,XSel1,YSel1,XSel2,YSel2,Bimage,xMiniSelP,yMiniSelP,xMaxiSelP,yMaxiSelP : integer;
    s : string;
begin
  //Affiche('ImageTCOMouseMove',clLime);
  if Temposouris<1 then exit;
  if not(sourisclic) then exit;
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

  if piloteAig then begin SelectionAffichee:=false;piloteAig:=false;SourisClic:=false;exit;end;

  r:=Rect(xminiSel+1,YminiSel+1,XmaxiSel+largeurCell,yMaxiSel+hauteurCell);

  XSel1:=Xminisel div largeurCell + 1;
  YSel1:=Yminisel div hauteurCell + 1;
  XSel2:=Xmaxisel div largeurCell + 1;
  YSel2:=Ymaxisel div hauteurCell + 1;

  // Affiche(intToSTR(Xsel1)+' '+intToStr(Ysel1)+' '+intToSTR(Xsel2)+' '+intToStr(Ysel2),clYellow);
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
  sourisclic:=false;
  //Affiche('Souris clic relachée',clyellow);
end;

procedure TFormTCO.ButtonRedessineClick(Sender: TObject);
begin
  Affiche_TCO;
end;

// changement de l'adresse d'un élément
procedure TFormTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index : integer;
begin
  //Affiche('Chgt adresse',clyellow);
  if clicTCO or not(formConfCellTCOAff) then exit;
  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;

  if Adr=0 then tco[XClicCell,YClicCell].repr:=2;

  tco[XClicCell,YClicCell].Adresse:=Adr;
  formConfCellTCO.editAdrElement.Text:=intToSTR(Adr);
  tco_Modifie:=true;
  if tco[XClicCell,YClicCell].BImage=30 then
  begin
    index:=Index_feu(adr);
    if index=0 then exit
    else
      begin
       //Affiche('Feu '+intToSTR(Adr),clyellow);
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

  TCO_modifie:=true;
  dessin_10(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=10;
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

  TCO_modifie:=true;
  dessin_11(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=11;  
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
end;

procedure TFormTCO.ImagePalette30EndDrag(Sender, Target: TObject; X, Y: Integer);
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
  tco[XClicCell,YClicCell].BImage:=30;
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[XClicCell,YClicCell].FeuOriente:=1;
  tco[XClicCell,YClicCell].PiedFeu:=1;
  tco[XClicCell,YClicCell].coulFonte:=clWhite;

  tco[XClicCell,YClicCell].x:=0;
  tco[XClicCell,YClicCell].y:=0;
  // ne pas convertir l'adresse sinon evt changement du composant et on écrase l'aspect EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
  Dessin_feu(ImageTCO.Canvas,XClicCell,YClicCell);
end;


procedure TFormTCO.ImagePalette30MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var l,h : integer;
begin
  l:=Formprinc.Image9feux.width;    //57
  h:=Formprinc.Image9feux.height;   //105
  ImagePalette30.BeginDrag(true);
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
  if Bimage<>30 then exit;

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
  if Bimage<>30 then exit;

  TCO_modifie:=true;

  adresse:=TCO[XClicCell,YClicCell].Adresse;
  aspect:=feux[index_feu(adresse)].Aspect;
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
  //dessin_feu(PCanvasTCO,XclicCell,YClicCell);
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
  if Bimage<>30 then exit;

  TCO_modifie:=true;
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  aspect:=feux[index_feu(adresse)].Aspect;
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
  //dessin_feu(PCanvasTCO,XclicCell,YClicCell);
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
//  Affiche(intTostr(TrackBarZoom.Position),clLime);
end;


procedure TFormTCO.EditTexteChange(Sender: TObject);
begin
  if clicTCO then exit;
  if affevt then Affiche('TCO.EditTextChange',clOrange);
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
  affiche_texte(XClicCell,YClicCell);
end;

procedure TFormTCO.ButtonSimuClick(Sender: TObject);
begin
  aiguillage[Index_Aig(1)].position:=const_droit;
  aiguillage[Index_Aig(2)].position:=const_devie;
  aiguillage[Index_Aig(3)].position:=const_droit;
  aiguillage[Index_Aig(4)].position:=const_devie;
  aiguillage[Index_Aig(5)].position:=const_devie;
  aiguillage[Index_Aig(8)].position:=const_devie;
  aiguillage[Index_Aig(9)].position:=const_droit;
  aiguillage[Index_Aig(7)].position:=const_devie;
  aiguillage[Index_Aig(12)].position:=const_devie;
  aiguillage[Index_Aig(20)].position:=const_droit;
  aiguillage[Index_Aig(21)].position:=const_droit;
  aiguillage[Index_Aig(26)].position:=const_devie;
  aiguillage[Index_Aig(28)].position:=const_droit;
  index_couleur:=1;
  aiguillage[Index_Aig(81)].position:=const_droit;
  aiguillage[Index_Aig(82)].position:=const_droit;
  aiguillage[Index_Aig(120)].position:=const_droit;
  aiguillage[Index_Aig(119)].position:=const_droit;
  aiguillage[Index_Aig(116)].position:=const_droit;
  aiguillage[Index_Aig(117)].position:=const_devie;

  //zone_TCO(530,520,1);
  //zone_TCO(515,517,1);
  zone_tco(522,527,1);

  //zone_tco(599,527,1);

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
  if (Bimage=21) or (Bimage=22) or (Bimage=25) then
  begin
    i:=Index_aig(Adresse);
    tjdC:=(aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs);
  end;

  // commande aiguillage
  if (Bimage=2) or (Bimage=3) or (Bimage=4) or (Bimage=5) or (Bimage=12) or
     (Bimage=13) or (Bimage=14) or (Bimage=15) or (Bimage=24) or TJDc then
  begin
    aiguille:=Adresse;
    TformAig.create(nil);

    formAig.showmodal;
    formAig.close;
    sourisclic:=false;  // évite de générer un cadre de sélection:=false;
    piloteAig:=true;
  end;

  // commande de signal
  if Bimage=30 then
  begin
    AdrPilote:=adresse;
    i:=Index_feu(adresse);
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

      if feux[i].aspect>10 then
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
        GroupBox2.Visible:=true;
      end;
      sourisclic:=false;  // évite de générer un cadre de sélection
    end;
  end;
end;

procedure TFormTCO.ComboReprChange(Sender: TObject);
begin
  if clicTCO then exit;
  tco[XClicCell,YClicCell].Repr:=comborepr.ItemIndex;
  efface_entoure;
  SelectionAffichee:=false;
  formConfCellTCO.ComboRepr.ItemIndex:=ComboRepr.ItemIndex;
  sourisclic:=false;
  //affiche_cellule(XClicCell,yClicCell);
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

procedure TFormTCO.ImagePalette31DragOver(Sender, Source: TObject; X,
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


procedure TFormTCO.ImagePalette31EndDrag(Sender, Target: TObject; X,
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
  Dessin_31(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=31;
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

  TCO_modifie:=true;

  Dessin_24(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=24;
  tco[XClicCell,YClicCell].Adresse:=0;
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

  TCO_modifie:=true;
  Dessin_25(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=25;
  tco[XClicCell,YClicCell].Adresse:=0;
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

  Dessin_20(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=20;
  tco[XClicCell,YClicCell].Adresse:=0;
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette31MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  debut_drag(ImagePalette31);
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

procedure TFormTCO.ImagePalette30DragOver(Sender, Source: TObject; X,
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
  if TCO[XClicCell,YClicCell].Bimage=30 then
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
  if TCO[XClicCell,YClicCell].Bimage=30 then
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
  //Affiche('on popup',clyellow);
  
  PopUpMenu1.Items[9][0].Caption:='Ligne au dessus de la '+intToSTR(YclicCell);
  PopUpMenu1.Items[9][1].Caption:='Ligne en dessous de la '+intToSTR(YclicCell);
  PopUpMenu1.Items[9][3].Caption:='Colonne à gauche de la '+intToSTR(XclicCell);
  PopUpMenu1.Items[9][4].Caption:='Colonne à droite de la '+intToSTR(XclicCell);

  PopUpMenu1.Items[10][0].Caption:='Ligne '+intToSTR(YclicCell);
  PopUpMenu1.Items[10][1].Caption:='Colonne '+intToSTR(XclicCell);

  // grise ou non l'entrée signal du menu
  if tco[XClicCell,YClicCell].Bimage=30 then
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
  if (erreur<>0) or not(Bimage in[0..22,24..25,30,31]) then
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

begin
end.
