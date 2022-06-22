unit UnitTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote, UnitDebug, 
  ComCtrls  ;

type
  TFormTCO = class(TForm)
    LabelX: TLabel;
    Label2: TLabel;
    LabelY: TLabel;
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
    Label4: TLabel;
    Label15: TLabel;
    EditAdrElement: TEdit;
    EditTypeImage: TEdit;
    ImageTemp: TImage;
    ImagePalette5: TImage;
    Label6: TLabel;
    ImagePalette2: TImage;
    Label7: TLabel;
    Label10: TLabel;
    ImagePalette1: TImage;
    ImagePalette6: TImage;
    ImagePalette7: TImage;
    ImagePalette8: TImage;
    ImagePalette9: TImage;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ImagePalette3: TImage;
    ImagePalette4: TImage;
    Label8: TLabel;
    Label9: TLabel;
    ImagePalette10: TImage;
    Label16: TLabel;
    ImagePalette11: TImage;
    Label17: TLabel;
    ImagePalette30: TImage;
    Label18: TLabel;
    ButtonSauveTCO: TButton;
    ButtonRedessine: TButton;
    Button1: TButton;
    Button2: TButton;
    Label19: TLabel;
    ButtonConfigTCO: TButton;
    Annulercouper: TMenuItem;
    N5: TMenuItem;
    ImagePalette12: TImage;
    Label20: TLabel;
    Label3: TLabel;
    ImagePalette13: TImage;
    Label21: TLabel;
    ImagePalette14: TImage;
    Label22: TLabel;
    ImagePalette15: TImage;
    Label23: TLabel;
    EditTexte: TEdit;
    ButtonSimu: TButton;
    CheckPinv: TCheckBox;
    ImagePalette16: TImage;
    Label24: TLabel;
    ImagePalette17: TImage;
    Label25: TLabel;
    ImagePalette18: TImage;
    Label26: TLabel;
    ImagePalette19: TImage;
    Label27: TLabel;
    ImagePalette20: TImage;
    Label28: TLabel;
    ButtonMasquer: TButton;
    ButtonAfficheBandeau: TButton;
    ImagePalette21: TImage;
    Label29: TLabel;
    ImagePalette22: TImage;
    Label30: TLabel;
    ComboRepr: TComboBox;
    Label1: TLabel;
    ImagePalette23: TImage;
    Label31: TLabel;
    FontDialog1: TFontDialog;
    ButtonFonte: TButton;
    N2: TMenuItem;
    Signalgauchedelavoie1: TMenuItem;
    Signaldroitedelavoie1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ImageTCOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
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
    procedure ImagePalette1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
    procedure Efface_Cellule(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
    procedure MenuCopierClick(Sender: TObject);
    procedure MenuCollerClick(Sender: TObject);
    procedure ButtonRedessineClick(Sender: TObject);
    procedure grille;
    procedure EditAdrElementChange(Sender: TObject);
    procedure EditTypeImageKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Maj_TCO(Adresse : integer);
    procedure ImageDiag10EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImagePalette10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDiag11EndDrag(Sender, Target: TObject; X, Y: Integer);
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
    procedure EditAdrElementKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    procedure ImagePalette23DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette23EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePalette23MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonFonteClick(Sender: TObject);
    procedure FontDialog1Show(Sender: TObject);
    procedure Signaldroitedelavoie1Click(Sender: TObject);
    procedure Signalgauchedelavoie1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  ZoomMax=50;ZoomMin=20;
  MaxCellX=150;MaxCellY=70;
  ClFond_ch='CoulFond';
  clVoies_ch='CoulVoies';
  clAllume_ch='CoulAllume';
  clGrille_ch='CoulGrille';
  clTexte_ch='CoulTexte';
  clQuai_ch='CoulQuai';
  Matrice_ch='Matrice';
  Cellule_ch='Cellule';
  ClCanton_ch='CoulCanton';
  Ratio_ch='Ratio';
  AvecGrille_ch='AvecGrille';
  ModeCouleurCanton_ch='ModeCouleurCanton';

type
  // structure du TCO
  TTCO = array[1..MaxCellX] of array[1..MaxCellY] of record
               Adresse     : integer ;    // adresse du détecteur ou de l'aiguillage ou du feu
               BImage      : integer ;    // 0=rien 1=voie 2=aiguillage gauche gauche ... 30=feu
               mode        : Tcolor;      // couleur de voie 0=éteint
               inverse     : boolean;     // aiguillage piloté inversé
               repr        : integer;     // position de la représentation texte 0 = rien 1=centrale 2=Haut  3=Bas
               Texte       : string[30];  // texte de la cellule
               Fonte       : string[30];  // fonte du texte
               FontStyle   : string[4];   // GSIB  (Gras Souligné Italique Barré)
               coulFonte   : Tcolor;
               TailleFonte : integer;
               Couleur     : Tcolor;      // couleur de fond de la cellule
               // pour les feux seulement
               PiedFeu     : integer;     // type de pied au feu : signal à gauche=1 ou à droite=2 de la voie
               x,y         : integer ;    // coordonnées pixels relativés du coin sup gauche du feu pour le décalage par rapport à la cellule
               FeuOriente  : integer;     // orientation du feu : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit
            end;

var
  clAllume,clVoies,Fond,couleurAdresse,clGrille,cltexte,clQuai,CoulFonte,ClCanton : Tcolor;
  FormTCO: TFormTCO;
  Forminit,sourisclic,SelectionAffichee,TamponAffecte,entoure,Diffusion,TCO_modifie,
  piloteAig,AncienFormatTCO,BandeauMasque,eval_format : boolean;
  HtImageTCO,LargImageTCO,XclicCell,YclicCell,XminiSel,YminiSel,XCoupe,Ycoupe,Temposouris,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel ,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,Xentoure,Yentoure,RatioC,ModeCouleurCanton,
  AncienXClicCell,AncienYClicCell,LargeurCell,HauteurCell,NbreCellX,NbreCellY,NbCellulesTCO : integer;
  titre_Fonte : string;
  TamponTCO,tco : TTco ;
  // pour copier coller
  TamponTCO_Org : record
                   x1,y1,x2,y2 : integer;
                  end;
  rAncien : TRect;
  PCanvasTCO : Tcanvas;
  PBitMapTCO : TBitMap;
  PScrollBoxTCO : TScrollBox;
  PImageTCO,PImageTemp : Timage;
  frXGlob,frYGlob : real;

procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
procedure calcul_cellules;
procedure sauve_fichier_tco;
procedure zone_TCO(det1,det2,mode: integer);
procedure efface_entoure;
procedure affiche_TCO;

implementation

uses UnitConfigTCO, Unit_Pilote_aig;

{$R *.dfm}

procedure lire_fichier_tco;
var fichier : textfile;
    s,sa : string;
    nv,x,y,i,j,m,adresse,valeur,erreur,FeuOriente,PiedFeu,tailleFont : integer;
    e : integer;
    trouve_CoulFond,trouve_clVoies,trouve_clAllume,trouve_clGrille,trouve_clCanton,
    trouve_clTexte,trouve_clQuai,trouve_matrice,trouve_cellule,trouve_ModeCanton,
    trouve_AvecGrille : boolean;
    function lit_ligne : string ;
    var c : char;
    begin
      repeat
        readln(fichier,s);
        s:=Uppercase(s);
        //Affiche(s,clWhite);
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
    exit;
  end;
  {$I-}
  x:=1;y:=1;NbreCellX:=0;NbreCellY:=0; RatioC:=10;
  trouve_clAllume:=false;
  trouve_CoulFond:=false;
  trouve_clVoies:=false;
  trouve_clGrille:=false;
  trouve_clTexte:=false;
  trouve_clQuai:=false;
  trouve_matrice:=false;
  trouve_cellule:=false;
  trouve_clCanton:=false;
  trouve_ModeCanton:=false;
  trouve_AvecGrille:=false;
  ancienFormatTCO:=false;
  eval_format:=false;
  ModeCouleurCanton:=1;
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
      fond:=i;
      eval_format:=true;
    end
    else 
    begin 
      if eval_format=false then
      begin
        val('$'+s,Fond,erreur);
        ancienformatTCO:=true;
        eval_format:=true;
      end;  
    end;
 
    if ancienformatTCO then begin s:=lit_ligne; val('$'+s,clVoies,erreur);end;
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

    if ancienformatTCO then begin s:=lit_ligne; val('$'+s,clAllume,erreur);end;
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
  
    if ancienformatTCO then begin s:=lit_ligne;val('$'+s,clGrille,erreur);end;
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

    if ancienformatTCO then begin s:=lit_ligne; val('$'+s,clTexte,erreur);end;
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

    if ancienformatTCO then begin s:=lit_ligne; val('$'+s,clQuai,erreur);end;
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

    // nouveaux -----------------------------------------------------
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
    if ancienformatTCO then begin s:=lit_ligne;val(s,NbreCellX,erreur);i:=pos(',',s);delete(s,1,i);Val(s,NbreCellY,erreur);end;
    sa:=uppercase(Matrice_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_matrice:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      NbreCellX:=i;
      i:=pos(',',s);delete(s,1,i);
      Val(s,NbreCellY,erreur)
    end;
       
    // Ancien largeur et hauteur des cellules
    if ancienformatTCO then begin s:=lit_ligne;val(s,LargeurCell,erreur);i:=pos(',',s);delete(s,1,i);Val(s,HauteurCell,erreur);end;
    {
    sa:=uppercase(Cellule_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_cellule:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      LargeurCell:=i;
      i:=pos(',',s);delete(s,1,i);
      Val(s,HauteurCell,erreur)
    end;
    }
    
    // ratio
    sa:=uppercase(Ratio_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_cellule:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      RatioC:=i;
    end;
    
  until (pos('[MATRICE]',uppercase(s))<>0) or (eof(fichier) or AncienFormatTCO); 

  NbCellulesTCO:=NbreCellX*NbreCellY;
  
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
        delete(s,i,1);

        // rien
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO2',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO3',clred);closefile(fichier);exit;end;
        delete(s,1,i);

        // Adresse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO4',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),adresse,erreur);
        if erreur<>0 then begin Affiche('ETCO5',clred);closefile(fichier);exit;end;
        tco[x,y].adresse:=adresse;
        delete(s,1,i);

        //Bimage
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO6',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO7',clred);closefile(fichier);exit;end;
        tco[x,y].Bimage:=valeur;
        delete(s,1,i);

        //Inverse
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO8',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin Affiche('ETCO9',clred);closefile(fichier);exit;end;
        tco[x,y].inverse:=valeur=1;
        delete(s,1,i);

        // FeuOriente 
        i:=pos(',',s);
        if i=0 then begin Affiche('ETCO10',clred);closefile(fichier);exit;end;
        val(copy(s,1,i-1),FeuOriente,erreur);if erreur<>0 then begin Affiche('ETCO11',clred);closefile(fichier);exit;end;
        delete(s,1,i);

        // PiedFeu 
        i:=pos(',',s); //j:=pos(')',s);
        //if j<i then i:=j;
        val(s,PiedFeu,erreur);
        delete(s,1,i);

        // si c'est un feu, remplir les paramètres du feu
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

        // texte optionnel
        j:=pos(')',s);
        i:=pos(',',s);
        tco[x,y].Texte:='';
        if j>1 then // le , est avant le ) donc il y a un texte
        begin
          if j<i then m:=j else m:=i;
          tco[x,y].Texte:=copy(s,1,m-1) ;
          delete(s,1,m-1);
        end;

        if s[1]=')' then
        begin
          // ici on est dans l'ancien format
          Delete(s,1,1);
          tco[x,y].repr:=2; // en haut
          tco[x,y].Couleur:=fond;
        end
        else
        begin
          if s[1]=',' then delete(s,1,1);
          val(s,j,erreur);
          tco[x,y].repr:=j;
          delete(s,1,erreur-1);
          if s[1]=',' then // on pointe sur ( en ancien format
          begin
            // fonte
            delete(s,1,1);
            i:=pos(',',s);
            tco[x,y].fonte:=copy(s,1,i-1);    
            //Affiche(fonte,clyellow);
            Delete(s,1,i);

            Val(s,taillefont,erreur);
            tco[x,y].TailleFonte:=taillefont;
            delete(s,1,erreur);

            i:=pos(',',s);
            val('$'+s,coulFonte,erreur);
            if ancienFormatTCO then
            begin
              m:=tco[x,y].BImage;
              case m of
              1 : coulFonte:=ClYellow;
              2,3,4,5,12,13,14,15,21,22 : coulfonte:=ClLime;
              30 : coulFonte:=clLime;
              end;
            end;
            tco[x,y].coulFonte:=coulFonte;
            delete(s,1,i);
            if s[1]<>')' then
            begin
              // style GISB
              i:=pos(')',s);
              tco[x,y].fontstyle:=copy(s,1,i-1);
            end;

            i:=pos(')',s);
            //Affiche(IntToHEX(coulFonte,6),clred);
            delete(s,1,i);

          end
          else delete(s,1,1); // ancien format

        end;
        inc(x);
      until s='';
    end;
    inc(y);x:=1;
  end;
  closefile(fichier);

  if not(trouve_AvecGrille) then ancienFormatTCO:=true;  // provoque la sauvegarde
  e:=sizeof(Tco) div 1024;
  Affiche('Dimensions du tco : '+intToSTR(NbreCellX)+'x'+intToSTR(NbreCellY)+' / '+IntToSTR(e)+'Ko',clyellow);
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
  Writeln(fichier,clFond_ch+'='+IntToHex(fond,6));
  Writeln(fichier,clVoies_ch+'='+IntToHex(ClVoies,6));
  Writeln(fichier,clAllume_ch+'='+IntToHex(ClAllume,6));
  Writeln(fichier,clGrille_ch+'='+IntToHex(ClGrille,6));
  Writeln(fichier,clTexte_ch+'='+IntToHex(ClTexte,6));
  Writeln(fichier,clQuai_ch+'='+IntToHex(ClQuai,6));
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
  writeln(fichier,'/ inutilisé,adresse,image,inversion aiguillage,Orientation du feu, pied du feu , [texte], representation, fonte, taille fonte, couleur fonte, style ');
  for y:=1 to NbreCellY do
  begin
    s:='';
    for x:=1 to NbreCellX do
    begin
      s:=s+'(0,'+inttostr(TCO[x,y].Adresse)+','+IntToSTR(TCO[x,y].BImage)+',';

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
  hauteurCell:=(LargeurCell * RatioC) div 10;
end;
  
procedure entoure_cell_grille(x,y : integer);
// redessine le carré de grille de la cellule qui a été altéré par la mise à
// jour de la cellule
var Xorg,Yorg : integer;
begin;
  Xorg:=(x-1)*LargeurCell;
  Yorg:=(y-1)*HauteurCell;
  if AvecGrille then With PcanvasTCO do
  begin
    Pen.Color:=clGrille;
    Pen.mode:=PmCopy;
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
    Brush.Color:=Fond;
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
var position : integer;
begin
  position:=aiguillage[index_Aig(TCO[x,y].Adresse)].position ;
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
    Brush.Color:=Fond;
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
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);
  end;
end;


 { diagonale
    x1:=x0;y1:=y0+hauteurCell-round(3*FryGlob);
    x2:=x0+largeurCell-round(3*FrXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*FrYGlob);
    x4:=x0+round(4*FrXGlob); y4:=y0+hauteurCell;
  }
// element 2
procedure dessin_2(canvas : Tcanvas;x,y : integer; Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;

    procedure horz;
    begin
      // bande horizontale
      r:=Rect(x0,jy1,x0+LargeurCell,jy2);
      canvas.FillRect(r);
    end;

    procedure deviation;
    begin
      //Canvas.Brush.Color:=clRed;
      x1:=x0+(largeurCell div 2)-round(1*FrXGlob); y1:=jy1+round(1*frYGlob);
      x2:=x0-round(1*FrXGlob);y2:=y0+HauteurCell-round(2*FrYGlob);     //1
      x3:=x0+round(4*FrXGlob);y3:=y0+HauteurCell;          //2
      x4:=x1+round(2*FrXGlob);y4:=jy2;                     //1
      canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
    Pen.Mode:=pmCopy;

    if (position=const_Devie) or (position=9) then
    begin
      horz;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      deviation;

      r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
      canvas.FillRect(r);

      if (position=const_Devie) then
      begin
        x1:=x1;y1:=jy1;
        x2:=x1-6;y2:=jy2;
        x3:=x2-6;y3:=y2;
        x4:=x1-6;y4:=jy1;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;
    end;

    if (position=const_Droit) then
    begin
      deviation;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      horz;
      // effacement du morceau
      x1:=x1+3;y1:=jy2;
      x2:=x1-10;y2:=y1;
      x3:=x2-5;y3:=y2+3;
      x4:=x1-5;y4:=y3;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;

// aiguillage pointe à gauche, aiguillage gauche Element 3
procedure dessin_3(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;

    procedure horz;
    begin
      r:=Rect(x0,jy1,x0+LargeurCell,jy2);
      canvas.FillRect(r);
    end;

    procedure devie;
    begin
      //brush.color:=clblue;
      x1:=x0+(largeurCell div 2)-round(1*frXGlob); y1:=jy1;
      x2:=x0+largeurCell-round(4*frXGlob); y2:=y0;
      x3:=x0+largeurCell; y3:=y0+round(3*frYGlob);
      x4:=x0+(largeurCell div 2)+round(1*frXGlob);y4:=jy2-round(1*frYGlob);
      canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    pen.color:=clVoies;
    Pen.Mode:=pmCopy;
    
    // aiguillage dévié (sans inversion)
    if (position=const_Devie) or (position=9) then
    begin
      horz;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
        end;
      Pen.color:=couleur;Brush.Color:=couleur;
      devie;

      r:=Rect(x0,jy1,x0+1+(LargeurCell div 2),jy2);
      canvas.FillRect(r);
      
      // effacement du morceau
      if (position=const_Devie) then
      begin
        x1:=x4+round(2*frXGlob);y1:=jy2-round(1*frYGlob);
        x2:=x1+round(5*frXGlob);y2:=jy1;
        x3:=x2+round(5*frXGlob);y3:=y2;
        x4:=x1+round(5*frXGlob);y4:=y1;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;  
    end;

    // aiguillage droit (sans inversion) dévié (avec inversion)
    if (position=const_Droit) then
    begin
      devie;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      horz; 
      // aiguillage droit
      x1:=x1-1;y1:=jy1-1;
      x2:=x1+10;y2:=y1;
      x3:=x2;y3:=y2-3;
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;  
  end;
end;

// Element 4
procedure dessin_4(Canvas : Tcanvas;x,y,Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;

    procedure bande_horz;
    begin
      // bande horizontale
      r:=Rect(x0,jy1,x0+LargeurCell,jy2);
      Canvas.FillRect(r);
    end;

    procedure deviation;
    begin
      // déviation
      x1:=x0+(largeurCell div 2)+round(1*frXGlob); y1:=jy1+round(1*frYGlob);
      x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*frYGlob);
      x3:=x0+largeurCell-round(3*frXGlob);y3:=y0+HauteurCell;
      x4:=x0+(largeurCell div 2)-round(1*frXGlob);y4:=jy2-round(1*frYGlob);
      Canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    // efface la cellule
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Pen.Mode:=pmCopy;
    pen.color:=clVoies;
    Brush.color:=clVoies;

    if (position=const_Devie) or (position=9) then    
    begin
      bande_horz;
      begin
        case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
        end;
        Pen.color:=couleur;Brush.Color:=couleur;
      end;
      
      // demi bande droite
      r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
      Canvas.FillRect(r);
      deviation;
      // effacement du morceau
      if (position=const_Devie) then
      begin
        x1:=x1;y1:=jy1;
        x2:=x1+5;y2:=jy2-1;
        x3:=x2+6;y3:=y2;
        x4:=x1+6;y4:=y1;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;  
    end;

    // aiguillage droit (sans inversion) dévié (avec inversion)
    if (position=const_Droit) then
    begin
      deviation;
      begin
        case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
        end;
        Pen.color:=couleur;Brush.Color:=couleur;
      end;
      bande_horz;

      // efface le morceau
      x1:=x4;y1:=jy2;
      x2:=x1+10;y2:=y1;
      x3:=x2;y3:=y2+3;
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;


// Element 5
procedure dessin_5(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;

    procedure horz;
    begin
      // bande horizontale
      r:=Rect(x0,jy1,x0+LargeurCell,jy2);
      Canvas.FillRect(r);
    end;

    procedure deviation;
    begin
      x1:=x0+(largeurCell div 2); y1:=jy1;
      x2:=x0+round(3*FrXGlob); y2:=y0;
      x3:=x0; y3:=y0+round(3*FrYGlob);
      x4:=x0+(largeurCell div 2)-round(1*FrXGlob); y4:=jy2-round(1*FrYGlob);
      canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*FrXGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*FrYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.COlor:=clVoies;
    Pen.Mode:=pmCopy;
    pen.color:=clVoies;

    if (position=const_Devie) or (position=const_inconnu) then
    begin
      horz;
      begin 
        case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
        end;
        Pen.color:=couleur;Brush.Color:=couleur;
      end;
      // demi bande droite
      r:=Rect(x0+(largeurCell div 2),jy1,x0+LargeurCell,jy2);
      Canvas.FillRect(r);
      deviation;

      // efface le morceau
      if (position=const_Devie) then
      begin
        x1:=x1-12;y1:=jy1;
        x2:=x1+5;y2:=jy2-1;
        x3:=x2+6;y3:=y2;
        x4:=x1+6;y4:=y1;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;
    end;

    if (position=const_Droit) then
    begin
      deviation;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
        Pen.color:=couleur;Brush.Color:=couleur;
      horz;
      // efface le morceau
      x1:=x4-10;y1:=jy1-1;
      x2:=x1+10;y2:=y1;
      x3:=x2;y3:=y2-3;
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;


// coin supérieur gauche (Element 6)
procedure dessin_6(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.COlor:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2)-round(1*frXGlob); y1:=jy2-round(2*frYGlob);
    x2:=x0;y2:=y0+round(2*frYGlob);
    x3:=x0+round(3*frXGlob);y3:=y0;
    x4:=x0+(LargeurCell div 2);y4:=jy1;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// Element 7
procedure dessin_7(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.COlor:=Couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2)+4,jy2);
    FillRect(r);

    x1:=x0+(LargeurCell div 2)+round(2*frXGlob);y1:=jy1;
    x2:=x0+LargeurCell-round(2*frXGlob);y2:=y0;
    x3:=x0+LargeurCell;y3:=y0+round(4*frYGlob);
    x4:=x0+(LargeurCell div 2)+round(4*frXGlob);y4:=jy2-round(2*frYGlob);
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// courbe: droit vers bas  -\  Element 8
procedure dessin_8(Canvas : Tcanvas;x,y : integer;Mode : integer);
var jy1,jy2,x0,y0,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.COlor:=Couleur;
    Pen.Mode:=pmCopy;
    pen.color:=Couleur;

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2) ;
    y1:=jy1;
    x2:=x0+LargeurCell; y2:=y0+HauteurCell-round(3*frYGlob);
    x3:=x0+LargeurCell -round(2*frXGlob);  y3:=y0+HauteurCell;
    x4:=x0+(LargeurCell div 2); y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// courbe bas gauche vers droit  Elément 9
procedure dessin_9(Canvas : Tcanvas;x,y : integer;Mode : integer);
var jy1,jy2,x0,y0,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.COlor:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0+(largeurCell div 2),jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0; y1:=y0+HauteurCell-round(4*frYGlob);
    x2:=x0+(LargeurCell div 2) ;  y2:=jy1;
    x3:=x0+(LargeurCell div 2) +round(2*frXGlob); y3:=jy2;
    x4:=x0+round(4*frXGlob); y4:=y0+HauteurCell;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// élément 10
procedure dessin_10(Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Adr:=TCO[x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume;
        pen.color:=clAllume;
        Pen.Mode:=pmCopy;
        x1:=x0;y1:=y0+hauteurCell-round(7*FryGlob);
        x2:=x0+largeurCell-round(8*FrXGlob);y2:=y0+1;
        x3:=x0+largeurCell-1;y3:=y0+round(9*FrYGlob);
        x4:=x0+round(9*FrXGlob); y4:=y0+hauteurCell-1;
        PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
    end;

    x1:=x0;y1:=y0+hauteurCell-round(3*FryGlob);
    x2:=x0+largeurCell-round(3*FrXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*FrYGlob);
    x4:=x0+round(4*FrXGlob); y4:=y0+hauteurCell;

    case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
    end;
    Pen.color:=couleur;Brush.Color:=couleur;

    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

  end;
end;

// élément 11
procedure dessin_11(Canvas : Tcanvas;x,y : integer;Mode : integer);
var Adr, x0,y0,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Adr:=TCO[x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume;
        pen.color:=clAllume;
        Pen.Mode:=pmCopy;
        x1:=x0+round(7*FrXGlob);y1:=y0;
        x2:=x0+largeurCell-1;y2:=y0+HauteurCell-round(7*FrYGlob)-1;
        x3:=x0+largeurCell-round(8*FrXGlob)-1;y3:=y0+HauteurCell-1;
        x4:=x0;y4:=y0+round(8*frYGlob);
        PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
    end;  
    
    x1:=x0+round(3*FrXGlob);y1:=y0;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*FrYGlob);
    x3:=x0+largeurCell-round(4*FrXGlob);y3:=y0+HauteurCell;
    x4:=x0;y4:=y0+round(4*frYGlob);
    
    case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;
  
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
  end;
end;  

// Element 12 aiguillage pointe 45°G vers droit
procedure dessin_12(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;
    procedure horz;
    begin
      // bande horizontale
      //r:=Rect(x0,jy1,x0+LargeurCell,jy2);
      //Canvas.FillRect(r);

      r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
      canvas.FillRect(r);
    end;

    procedure diagonale;
    begin
      x1:=x0+round(3*frXGlob);y1:=y0;
      x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*frYGlob);
      x3:=x0+largeurCell-round(4*frXGlob); y3:=y0+HauteurCell;
      x4:=x0; y4:=y0+round(4*frYGlob);
    
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    // efface cellule
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    pen.color:=clVoies;
    
    if (position=const_Devie) or (position=9) then
    begin
      diagonale;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      horz;
      
      x1:=x0+round(3*frXGlob);y1:=y0;
      x2:=x0+(largeurCell div 2)+round(7*frXGlob);y2:=jy2;//y2:=y0+(HauteurCell div 2);
      x3:=x2-round(9*frXGlob); y3:=y2;
      x4:=x0; y4:=y0+round(4*frYGlob);
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
                
      // efface le morceau
      if (position=const_Devie) then
      begin
        x1:=x0+round(22*frxGlob);y1:=jy2; //+round(FrYGlob*1);
        x2:=x1+round(12*frxGlob);y2:=y1;
        x3:=x2;y3:=y2+3;
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.COlor:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;  
    end;
    
    // aiguillage droit (sans inversion) ou dévie (avec inversion)
    if (position=const_Droit) then
    begin
      horz;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
        end;
        Pen.color:=couleur;Brush.Color:=couleur;
      diagonale;

      // efface le morceau
      x1:=x0+round(26*frXGlob);y1:=jy1;
      x2:=x1+round(10*frxGlob);y2:=y1;
      x3:=x2+round(12*FrxGlob);y3:=y2+round(12*fryGlob);
      x4:=x3-round(10*frxGlob);y4:=y3;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;

// Elément 13
procedure dessin_13(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;
    procedure horz;
    begin
      // bande horizontale
      r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
      canvas.FillRect(r);
    end;

    procedure diagonale;
    begin
      x1:=x0;y1:=y0+hauteurCell-round(3*frYGlob);
      x2:=x0+largeurCell-round(3*frXGlob);y2:=y0;
      x3:=x0+largeurCell;y3:=y0+round(4*FryGlob);
      x4:=x0+round(4*frXGlob);y4:=y0+hauteurCell;
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;
    
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    //efface
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);
    
    Brush.Color:=clVoies;
    pen.color:=clVoies;
   
    // aiguillage dévié (sans inversion) ou position inconnue (9)
    if (position=const_Devie) or (position=const_inconnu) then
    begin
      diagonale;
      case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      horz;
    
      // morceau de diagonale à tracer en clAllume
      x1:=x0+largeurCell-round(3*frXGlob);y1:=y0;
      x2:=x0+largeurCell;y2:=y0+round(4*FryGlob);
      x3:=x0+(largeurCell div 2)+round(4*frXGlob);y3:=jy2;
      x4:=x0+(largeurCell div 2)-round(7*frXGlob);y4:=jy2;
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      
      // efface le morceau  
      if (position=const_Devie) then
      begin 
        // efface le morceau
        x1:=x0+round(12*frXGlob);y1:=jy2; 
        x2:=x1+round(20*frxGlob);y2:=y1;
        x3:=x2;y3:=y2+round(3*frYGlob);
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;
    end;
    
    // aiguillage droit (sans inversion) ou dévie (avec inversion)
    if (position=const_droit) then
    begin
      horz;
      begin 
        case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
        end;
        Pen.color:=couleur;Brush.Color:=couleur;
      end;
      diagonale;

      // efface le morceau
      x1:=x0+round(19*frXGlob);y1:=jy1;
      x2:=x1+round(6*frxGlob);y2:=y1;
      x3:=x2-round(12*FrxGlob);y3:=y2+round(12*fryGlob);
      x4:=x3-round(8*frxGlob);y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;  
  end;
end;

// Element 14
procedure dessin_14(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;

    procedure horz;
    begin
      r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
      canvas.FillRect(r);
    end;

    procedure diagonale;
    begin
      x1:=x0+round(3*frXGlob); y1:=y0;
      x2:=x0+largeurCell; y2:=y0+HauteurCell-round(3*fryGlob);
      x3:=x0+largeurCell-round(4*frXGlob);y3:=y0+HauteurCell;
      x4:=x0; y4:=y0+round(4*frYGlob);
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    pen.color:=clVoies;
    
    // aiguillage dévié (sans inversion)
    if (position=const_Devie) or (position=9) then
    begin        
      diagonale;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      horz;
      
      // morceau de diagonale à tracer en clAllume
      x1:=x0+(largeurCell div 2)-round(8*frXGlob); y1:=jy1;
      x2:=x1+round(8*frXGlob); y2:=y1;
      x3:=x0+largeurCell; y3:=y0+HauteurCell-round(3*fryGlob);
      x4:=x0+largeurCell-round(4*frXGlob);y4:=y0+HauteurCell;
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

      // efface le morceau
      if (position=const_Devie) then
      begin
        // efface le morceau
        x1:=x0+round(2*frXGlob);y1:=jy1-round(1*fryGlob); 
        x2:=x1+round(23*frxGlob);y2:=y1;
        x3:=x2;y3:=y2-round(3*fryGlob);
        x4:=x1;y4:=y3;
        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;  
    end;
   
    // aiguillage droit (sans inversion) ou dévie (avec inversion)
    if (position=const_Droit) then
    begin
      horz;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      diagonale;
      // efface le morceau
      x1:=x0+round(10*frXGlob);y1:=jy1;
      x2:=x1+round(6*frxGlob);y2:=y1;
      x3:=x2+round(12*FrxGlob);y3:=y2+round(12*fryGlob);
      x4:=x3-round(5*frxGlob);y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;


// Element 15
procedure dessin_15(Canvas : Tcanvas;x,y : integer;Mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2,position : integer;
    inverse : boolean;
    r : Trect;
    
    procedure horz;
    begin
      r:=Rect(x0+(LargeurCell div 2)+1,jy1,x0+LargeurCell,jy2);
      canvas.FillRect(r);
    end;

    procedure diagonale;
    begin
      x1:=x0;y1:=y0+hauteurCell-round(3*frYGlob);
      x2:=x0+largeurCell-round(3*frXGlob);y2:=y0;
      x3:=x0+largeurCell;y3:=y0+round(4*frYGlob);
      x4:=x0+round(3*frYGlob);y4:=y0+hauteurCell;
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
    end;

begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  position:=positionTCO(x,y);
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;                                       
    pen.color:=clVoies;
    
    // aiguillage dévié (sans inversion)
    if (position=const_Devie) or (position=const_inconnu) then
    begin  
      diagonale;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      horz;
      // morceau de diag à tracer 
      x1:=x0-round(0*frxglob);y1:=y0+hauteurCell-round(3*frYGlob);
      x2:=x0+(largeurCell div 2)-round(0*frXGlob);y2:=jy1;
      x3:=x2+round(8*frXglob);y3:=y2;
      x4:=x0+round(3*frYGlob);y4:=y0+hauteurCell;
      canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      
      // efface le morceau
      if (position=const_Devie) then
      begin
        x1:=x0+round(20*frXGlob);y1:=jy1-round(1*frYGlob); 
        x2:=x1+round(23*frxGlob);y2:=y1;
        x3:=x2;y3:=y2-round(3*frYGlob);
        x4:=x1;y4:=y3;

        pen.color:=fond;
        Brush.Color:=fond;
        Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      end;
    end;
    
    // aiguillage droit (sans inversion) ou dévie (avec inversion)
    if (position=const_Droit) then
    begin
      horz;
      case mode of
        0: couleur:=clVoies;
        1: couleur:=clAllume;
        2: couleur:=couleurtrain[index_couleur];
      end;
      Pen.color:=couleur;Brush.Color:=couleur;
      diagonale;

      // efface morceau  
      x1:=x0+round(34*frXGlob);y1:=jy1;
      x2:=x1+round(6*frxGlob);y2:=y1;
      x3:=x2-round(12*FrxGlob);y3:=y2+round(12*fryGlob);
      x4:=x3-round(8*frxGlob);y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]); 
    end;
  end;
end;  

// Element 16
procedure dessin_16(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,xbv1,xbv2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xbv1:=x0+(LargeurCell div 2)-round(3*frXGlob); // pos x de la bande verticale
  xbv2:=x0+(LargeurCell div 2)+round(3*frXGlob); // pos x de la bande verticale

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

     case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;

    // brush.color:=clblue;
    x1:=x0; y1:=y0+round(3*frYGlob);
    x2:=x0+round(2*frXGlob);y2:=y0;
    x3:=x0+(LargeurCell div 2)+round(2*frXGlob);y3:=y0+(HauteurCell div 2);
    x4:=x0+(LargeurCell div 2)-round(3*frXGlob);y4:=y3;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    r:=Rect(xbv1,y0+HauteurCell div 2,xbv2,y0+HauteurCell);
    FillRect(r);
  end;
end;

// Element 17
procedure dessin_17(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,xbv1,xbv2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xbv1:=x0+(LargeurCell div 2)-round(3*frXGlob); // pos x de la bande verticale
  xbv2:=x0+(LargeurCell div 2)+round(3*frXGlob); // pos x de la bande verticale

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=pmCopy;

    // brush.color:=clblue;
    x1:=x0+largeurCell-round(3*frxGlob); y1:=y0;
    x2:=x0+LargeurCell;y2:=y0+round(2*frYGlob);
    x3:=x0+(LargeurCell div 2)+round(2*frXGlob);y3:=y0+(HauteurCell div 2);
    x4:=x0+(LargeurCell div 2)-round(3*frXGlob);y4:=y3;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    r:=Rect(xbv1,y0+HauteurCell div 2,xbv2,y0+HauteurCell);
    FillRect(r);
  end;
end;

// Elément 18
procedure dessin_18(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,xbv1,xbv2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xbv1:=x0+(LargeurCell div 2)-round(3*frXGlob); // pos x de la bande verticale
  xbv2:=x0+(LargeurCell div 2)+round(3*frXGlob); // pos x de la bande verticale

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;

    // brush.color:=clblue;
    x1:=x0+(largeurCell div 2)-round(3*frxGlob); y1:=y0+(HauteurCell div 2);
    x2:=x0+(largeurCell div 2)+round(2*frxGlob); y2:=y1;
    x3:=x0+round(2*frXGlob);y3:=y0+HauteurCell;
    x4:=x0;y4:=y0+HauteurCell-round(3*frYGlob);
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    r:=Rect(xbv1,y0+HauteurCell div 2,xbv2,y0);
    FillRect(r);
  end;
end;

// Element 19
procedure dessin_19(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,xbv1,xbv2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  xbv1:=x0+(LargeurCell div 2)-round(3*frXGlob); // pos x de la bande verticale
  xbv2:=x0+(LargeurCell div 2)+round(3*frXGlob); // pos x de la bande verticale

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end;
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;

    // brush.color:=clblue;
    x1:=x0+(largeurCell div 2)-round(3*frxGlob); y1:=y0+(HauteurCell div 2);
    x2:=x0+(largeurCell div 2)+round(2*frxGlob); y2:=y1;
    x3:=x0+largeurCell;y3:=y0+HauteurCell-round(2*frYGlob);
    x4:=x0+largeurCell-round(3*frXGlob);y4:=y0+HauteurCell;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    r:=Rect(xbv1,y0+HauteurCell div 2,xbv2,y0);
    FillRect(r);
  end;
end;

// Element 20
procedure dessin_20(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,xbv1,xbv2,adr : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;


  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Adr:=TCO[x,y].adresse;
    if Adr<>0 then
    begin
      if detecteur[Adr].etat then
      begin
        Brush.Color:=clAllume;
        pen.color:=clAllume;
        Pen.Mode:=pmCopy;
        xbv1:=x0+(LargeurCell div 2)-round(6*frXGlob); // pos x de la bande verticale
        xbv2:=x0+(LargeurCell div 2)+round(6*frXGlob); // pos x de la bande verticale
        r:=Rect(xbv1,y0,xbv2,y0+HauteurCell);
        FillRect(r);
      end;
    end;

    case mode of
      0: couleur:=clVoies;
      1: couleur:=clAllume;
      2: couleur:=couleurtrain[index_couleur];
    end; 
    Brush.Color:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    xbv1:=x0+(LargeurCell div 2)-round(3*frXGlob); // pos x de la bande verticale
    xbv2:=x0+(LargeurCell div 2)+round(3*frXGlob); // pos x de la bande verticale
    r:=Rect(xbv1,y0,xbv2,y0+HauteurCell);
    FillRect(r);
  end;
end;

// Element 21 - croisement - TJD
procedure dessin_21(Canvas : Tcanvas;x,y,mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clvoies;
    pen.color:=clvoies;

    // diagonale
    x1:=x0;y1:=y0+hauteurCell-round(3*FryGlob);
    x2:=x0+largeurCell-round(3*FrXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*FrYGlob);
    x4:=x0+round(4*FrXGlob); y4:=y0+hauteurCell;
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    // horizontale
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);
    
  end;
end;

// Element 22
procedure dessin_22(Canvas : Tcanvas;x,y,mode : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin

    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clvoies;
    pen.color:=clvoies;

    // diagonale
    x1:=x0+round(3*FrXGlob);y1:=y0;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*FrYGlob);
    x3:=x0+largeurCell-round(4*FrXGlob);y3:=y0+HauteurCell;
    x4:=x0;y4:=y0+round(4*frYGlob);
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    // horizontale
    Brush.Color:=clvoies;
    pen.color:=clvoies;
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

  end;
end;

// Element 23
procedure dessin_23(Canvas : Tcanvas;x,y,mode: integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin

    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clQuai;
    pen.color:=clQuai;
    x1:=x0;y1:=y0;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*FrYGlob);
    x3:=x0+largeurCell-round(4*FrXGlob);y3:=y0+HauteurCell;
    x4:=x0;y4:=y0+round(4*frYGlob);

    jy1:=y0+(HauteurCell div 2)-round(14*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(14*frYGlob); // pos Y de la bande inf
    
    PolyGon([point(x1,jy1),point(x2,jy1),point(x2,jy2),point(x1,jy2)]);
  end;
end;

// calcul des facteurs de réductions X et Y pour l'adapter à l'image de destination
procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
begin
  frX:=DimDestX/DimOrgX;
  frY:=DimDestY/DimOrgY;
end;

// Affiche dans le TCO en x,y un Feu à 90° d'après l'image transmise
// x y en coordonnées pixels
procedure Feu_90G(ImageSource : TImage;x,y : integer;FrX,FrY : real);
var p : array[0..2] of TPoint;
    TailleY,TailleX : integer;
begin
  TailleY:=ImageSource.Picture.Height;
  TailleX:=ImageSource.Picture.Width;
  //offset:=2*largeurCell-TailleX;
 // Affiche(intToSTR(offset),clyellow);
  
  // copie à 90°G sans mise à l'échelle dans l'image provisoire
  p[0].X:=TailleY;  //90;
  p[0].Y:=0;  //0;
  p[1].X:=TailleY;  //90;
  p[1].Y:=TailleX;  //49;
  p[2].X:=0;  //0;
  p[2].Y:=0;  //0;
  // copie l'image du feu depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
  PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

  // copie l'image du feu retournée depuis image temporaire vers tco avec une réduction en mode transparennt
  TransparentBlt(PcanvasTCO.Handle,x,y,round(TailleY*FrY),round(TailleX*FrX),   // destination
             PImageTemp.Canvas.Handle,0,0,TailleY,TailleX,clBlue);    // source - clblue est la couleur de transparence
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

// copie de l'image du feu à 90° dans le canvas source et le tourne de 90° et le met dans l'image temporaire
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
  // copie l'image du feu depuis imagesource vers image temporaire à la même échelle mais retournée à 90°
  PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,TailleX,TailleY,0,0,0);

  // et copier l'image avec mise à l'échelle tournée sur le TCO
  TransparentBlt(PcanvasTCO.Handle,x,y,round(tailleY*FrY),round(tailleX*FrX),
                 PImageTemp.Canvas.Handle,0,0,TailleY,TailleX,clBlue);
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

procedure affiche_pied2G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1-7)*frX),y+round((y1+50)*frY) ) else
                   LineTo( x+round((x1-7)*frX),y+round((y1-50)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frY) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-50)*frY) ) ;
  end;
end;

procedure affiche_pied2G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=35;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-50)*fry) ) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+50)*fry) ) ;

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fry) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fry) )
  end;
end;

procedure affiche_pied_Vertical2G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=35;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied3G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=45;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-50)*fry) ) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+50)*fry) );  

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fry) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+50)*fry) ) ;
  end;
end;

procedure affiche_pied3G_90G(x,y : integer;FrX,frY : real;pied : integer);    
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1-7)*frX),y+round((y1+50)*frY) ) else
                   LineTo( x+round((x1-7)*frX),y+round((y1-50)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frY) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-50)*fry) );
  end;
end;

procedure affiche_pied_Vertical3G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=42;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+6)*frY) )
             else  LineTo( x+round((x1-50)*frX),y+round((y1+6)*frY) ) ;
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) ) ;
  end;
end;

procedure affiche_pied4G_90G(x,y : integer;FrX,frY : real;piedFeu : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1-7)*frX),y+round((y1+50)*frY) ) else
                      LineTo( x+round((x1-7)*frX),y+round((y1-50)*frY) ) ;

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    if piedFeu=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frY) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*frY) ) ;
  end;
end;

procedure affiche_pied4G_90D(x,y : integer;FrX,frY : real;piedfeu: integer);
var x1,y1 : integer;
    ech : real;
begin                                            
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=55;y1:=12;
    moveTo( x+round(x1*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1+7)*frX),y+round((y1-50)*fry) )
                 else LineTo( x+round((x1+7)*frX),y+round((y1+50)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    if piedFeu=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fry) ) else
                      LineTo( x+round((x1+6)*frX),y+round((y1+50)*fry) );
  end;
end;

procedure affiche_pied_Vertical4G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=55;                               
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+8)*frY) ) else
                   LineTo( x+round((x1-50)*frX),y+round((y1+8)*frY) );
  end;
end;

procedure affiche_pied9G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    var ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=90;y1:=38;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fry)) else 
                   LineTo( x+round((x1+7)*frX),y+round((y1+40)*fry));

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-62)*fry) ) else 
                   LineTo( x+round((x1+6)*frX),y+round((y1+40)*fry)) ;
  end;
end;


procedure affiche_pied5G_90D(x,y : integer;FrX,frY : real;piedFeu : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=66;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1+7)*frX),y+round((y1-50)*fry) ) else
                      LineTo( x+round((x1+7)*frX),y+round((y1+50)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    if piedFeu=1 then LineTo( x+round((x1+6)*frX),y+round((y1-50)*fry) ) else
                      LineTo( x+round((x1+6)*frX),y+round((y1+50)*fry) );
  end;
end;

procedure affiche_pied5G_90G(x,y : integer;FrX,frY : real;piedFeu : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
   Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    if piedFeu=1 then LineTo( x+round((x1-7)*frX),y+round((y1+50)*frY) ) else
                      LineTo( x+round((x1-7)*frX),y+round((y1-50)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    if piedFeu=1 then LineTo( x+round((x1-6)*frX),y+round((y1+50)*frY) ) else
                      LineTo( x+round((x1-6)*frX),y+round((y1-50)*fry) );
  end;
end;

procedure affiche_pied_Vertical5G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=65;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    
    if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+7)*frY) ) else 
                   LineTo( x+round((x1-50)*frX),y+round((y1+7)*frY) ); 
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
     if pied=1 then LineTo( x+round((x1+50)*frX),y+round((y1+8)*frY) ) else 
                   LineTo( x+round((x1-50)*frX),y+round((y1+8)*frY) ); 
  end;
end;

procedure affiche_pied7G_90D(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clorange;
    x1:=75;y1:=38;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1+7)*frX),y+round((y1-62)*fry) ) else
                   LineTo( x+round((x1+7)*frX),y+round((y1+38)*fry) ) ;

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1+6)*frX),y+round((y1-62)*fry) ) else
                   LineTo( x+round((x1+6)*frX),y+round((y1+38)*fry) ) ;
  end;
end;

procedure affiche_pied7G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1-7)*frX),y+round((y1+60)*frY) ) else
                   LineTo( x+round((x1-7)*frX),y+round((y1-40)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+60)*frY) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-40)*frY) )
  end;
end;

procedure affiche_pied_Vertical7G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=75;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) ) else 
                   LineTo( x+round((x1-40)*frX),y+round((y1+7)*frY) ) ;

    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+8)*frY) ) else 
                   LineTo( x+round((x1-40)*frX),y+round((y1+8)*frY) ) ;
  end;
end;

procedure affiche_pied9G_90G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    if pied=1 then LineTo( x+round((x1-7)*frX),y+round((y1+58)*frY) ) else
                   LineTo( x+round((x1-7)*frX),y+round((y1-40)*frY) ) ;

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    if pied=1 then LineTo( x+round((x1-6)*frX),y+round((y1+58)*frY) ) else
                   LineTo( x+round((x1-6)*frX),y+round((y1-40)*frY) ) ;
  end;
end;

procedure affiche_pied_Vertical9G(x,y : integer;FrX,frY : real;pied : integer);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=90;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) ) else 
                   LineTo( x+round((x1-40)*frX),y+round((y1+7)*frY) ) ;
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    if pied=1 then LineTo( x+round((x1+60)*frX),y+round((y1+8)*frY) ) else
                   LineTo( x+round((x1-40)*frX),y+round((y1+8)*frY) ) ;
    
  end;
end;

// Dessine un feu dans le canvasDest en x,y , dont l'adresse se trouve à la cellule x,y
procedure dessin_feu(CanvasDest : Tcanvas;x,y : integer );
var  x0,y0,xp,yp,orientation,adresse,aspect,PiedFeu,TailleX,TailleY : integer;
     ImageFeu : Timage;
     frX,frY : real;
begin
  xp:=(x-1)*LargeurCell;
  yp:=(y-1)*HauteurCell;

  Adresse:=TCO[x,y].Adresse;

  Orientation:=TCO[x,y].FeuOriente;
  if Orientation=0 then Orientation:=1;  // cas d'un feu non encore renseigné

  aspect:=feux[index_feu(adresse)].aspect;
  if aspect=0 then aspect:=9;
  if aspect>9 then exit;
 // Affiche(IntToSTR(i)+' '+intToSTR(aspect),clred);

  case aspect of
  2 :  ImageFeu:=Formprinc.Image2feux;
  3 :  ImageFeu:=Formprinc.Image3feux;
  4 :  ImageFeu:=Formprinc.Image4feux;
  5 :  ImageFeu:=Formprinc.Image5feux;
  7 :  ImageFeu:=Formprinc.Image7feux;
  9 :  ImageFeu:=Formprinc.Image9feux;
  else ImageFeu:=Formprinc.Image9feux;
  end;

  TailleX:=ImageFeu.picture.BitMap.Width;
  TailleY:=ImageFeu.picture.BitMap.Height; // taille du feu d'origine  (verticale)
  PiedFeu:=TCO[x,y].PiedFeu;

  // réduction variable en fonction de la taille des cellules. 50 est le Zoom Maxi
  calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);

  if orientation=3 then  //D
  begin
    if aspect=9 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=5 then begin x0:=0; y0:=round(tailleX/2*frY);end;
    if aspect=4 then begin x0:=0; y0:=round(tailleX/2*frY);end;
    if aspect=3 then begin x0:=0; y0:=round(tailleX/2*frY);end;
    if aspect=2 then begin x0:=0; y0:=round(tailleX/2*frY);end;
    x0:=x0+xp;y0:=y0+yp;
    tco[x,y].x:=x0;
    tco[x,y].y:=y0;
  end;

  // décalage en X pour mettre la tete du feu alignée sur le bord droit de la cellule pour les feux tournés à 90G
  if orientation=2 then
  begin
    if aspect=9 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=5 then begin x0:=round(10*frX); y0:=round(tailleX/2*frY);end;
    if aspect=4 then begin x0:=round(10*frX); y0:=round(tailleX/2*frY);end;
    if aspect=3 then begin x0:=round(8*frX); y0:=round(tailleX/2*frY);end;
    if aspect=2 then begin x0:=round(10*frX); y0:=round(tailleX/2*frY);end;
    x0:=x0+xp;y0:=y0+yp;
    tco[x,y].x:=x0;
    tco[x,y].y:=y0;
  end;

  // décalage en X pour mettre rapprocher le feu du le bord droit de la cellule pour les feux verticaux
  if orientation=1 then
  begin
    if aspect=9 then begin x0:=0; y0:=0; end;
    if aspect=7 then begin x0:=0; y0:=0; end;
    if aspect=5 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=4 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=3 then begin x0:=round(13*frx); y0:=0;end;
    if aspect=2 then begin x0:=round(13*frx); y0:=0;end;
    x0:=x0+xp;y0:=y0+yp;
    tco[x,y].x:=x0;
    tco[x,y].y:=y0;
  end;

  // affichage du feu et du pied - orientation verticale
  if (Orientation=1) then
  begin
    // copie avec mise à l'échelle de l'image du feu
    TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   ImageFeu.Canvas.Handle,0,0,TailleX,TailleY,clBlue);
    PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
    if aspect=9 then affiche_pied_Vertical9G(x0,y0,frX,frY,piedFeu);
    if aspect=7 then affiche_pied_Vertical7G(x0,y0,frX,frY,piedFeu);
    if aspect=5 then affiche_pied_Vertical5G(x0,y0,frX,frY,piedFeu);
    if aspect=4 then affiche_pied_Vertical4G(x0,y0,frX,frY,piedFeu);
    if aspect=3 then affiche_pied_Vertical3G(x0,y0,frX,frY,PiedFeu);
    if aspect=2 then affiche_pied_Vertical2G(x0,y0,frX,frY,PiedFeu);
  end;

  // affichage du feu et du pieds - orientation 90°G
  if Orientation=2 then
  begin
    Feu_90G(ImageFeu,x0,y0,frX,frY); // ici on passe l'origine du feu
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

  // affichage du feu et du pied - orientation 90°D
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

procedure TformTCO.Efface_Cellule(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
var x0,y0 : integer;
    r : TRect;
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

  with canvas do
  begin
    Pen.Mode:=mode;
    Pen.color:=clLime;
    Brush.Color:=couleur ;//Fond;
    Brush.style:=bsSolid;
    rectangle(r);
    fillRect(r);
  end;
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
procedure affiche_cellule(x,y : integer);
var i,repr,p,Xorg,Yorg,xt,yt,mode,adresse,Bimage,aspect,oriente,pos,pos2,pied : integer;
    Bt : TEquipement;
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

 // pourquoi ? ? if y>1 then if (tco[x,y-1].Bimage=30)  then exit;

  // affiche d'abord l'icone de la cellule et colore la voie si zone ou détecteur actionnée selon valeur mode
  case Bimage of
      //0 : formTCO.efface_cellule(PCanvasTCO,x,y,fond,pmcopy);
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
     30 : dessin_feu(PCanvasTCO,X,Y);
  end;

  PCanvasTCO.font.Size:=(LargeurCell div 10)+4  ;
  //Affiche(intToSTR( (LargeurCell div 30)+6),clyellow);

  // affiche le texte des aiguillages
  if ((BImage=2) or (BImage=3) or (BImage=4) or (BImage=5) or (BImage=12) or (BImage=13) or (BImage=14) or
      (BImage=15) or (BImage=21) or (BImage=22)) and (adresse<>0) then
  begin
    s:='A'+s;
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
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
      TextOut(xOrg+xt,yOrg+yt,s);
      //exit;
    end;
  end;

  // détecteurs
  if ((BImage=1) ) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=tco[x,y].coulFonte;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      xt:=round(15*frXGlob);
      case repr of
      1 : yt:=(HauteurCell div 2)-round(7*fryGlob);   // milieu
      2 : yt:=1;  // haut
      3 : yt:=HauteurCell-round(17*frYGlob);   // bas
      end;
      if repr<>0 then
      begin
        TextOut(xOrg+xt,Yorg+yt,s);
      end;
    end;
  end;

  if ((Bimage=7) or (Bimage=8) or (Bimage=9) or (Bimage=10) or (Bimage=17)  or (Bimage=20))  and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      Font.Color:=tco[x,y].coulFonte;
      TextOut(xOrg+round(2*frXGlob),yOrg+round(2*fryGlob),s);
    end;
  end;

  if (Bimage=18) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Name:='Arial';
      Font.Style:=style(tco[x,y].FontStyle);
      Font.Color:=tco[x,y].coulFonte;
      TextOut(xOrg+round(20*frXGlob),yOrg+HauteurCell-round(14*frYGlob),s);
    end;
  end;

  if ((Bimage=6) or (Bimage=11) or (Bimage=16)) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
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
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
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
    r:=Rect(x0,y0,x0+largeurCell,y0+LargeurCell);
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
      Xentoure:=XClicCell;Yentoure:=YclicCell;entoure:=true;
    end
    else
    begin
      Entoure_cell(Xentoure,Yentoure);   // efface l'ancien
      Entoure_cell(XclicCell,YclicCell);
      Xentoure:=XClicCell;Yentoure:=YclicCell;
    end;
end;

procedure affiche_texte(x,y : integer);
var x0,y0,yt,repr : integer;
    ss,s : string;
    fs : TFontStyles;
begin
  x0:=(x-1)*Largeurcell;
  y0:=(y-1)*hauteurcell;
  //PCanvasTCO.Brush.Style:=bsSolid;

  if TCO[x,y].BImage=23 then PCanvasTCO.Brush.Color:=clQuai else PCanvasTCO.Brush.Color:=fond;
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

  s:=tco[x,y].Texte;
  PcanvasTCO.Textout(x0+2,y0+yt,s);
end;

// affiche le tco suivant le tableau TCO
procedure Affiche_TCO ;
var x,y,x0,y0,DimX,DimY,yt : integer;
    s : string;
    r : Trect;
begin
  //affiche('Affiche_tco',clLime);
  DimX:=LargeurCell*NbreCellX;
  DimY:=HauteurCell*NbreCellY;

  PImageTCO.Height:=DimY;
  PImageTCO.Width:=DimX;

  PBitMapTCO.Height:=DimY;
  PBitMapTCO.Width:=DimX;

  PScrollBoxTCO.HorzScrollBar.Range:=DimX;
  PScrollBoxTCO.VertScrollBar.Range:=DimY;

  calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);
  //Affiche(formatfloat('0.000000',frxGlob),clyellow);

  //effacer tout
  with PcanvasTCO do
  begin
    Pen.width:=1;
    Brush.Style:=bsSolid;
    Brush.Color:=fond;
    pen.color:=clyellow;
    r:=rect(0,0,NbreCellX*LargeurCell,NbreCelly*HauteurCell);
    FillRect(r);
  end;

  //afficher les cellules sauf les feux
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage<>30 then
        begin
          affiche_cellule(x,y);
        end;
        
      end;

  //afficher les cellules des feux et les textes pour que les pieds recouvrent le reste et afficher les textes
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


procedure TFormTCO.FormCreate(Sender: TObject);
begin
  //Affiche('FormTCO create',clyellow);
  caption:='TCO';
  AvecGrille:=true;
  TCO_modifie:=false;
  XclicCell:=1;
  YclicCell:=1;
  xCoupe:=0;yCoupe:=0;
  KeyPreview:=false; // invalide les évènements clavier
  fond:=$202050;
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
  //controlStyle:=controlStyle+[csOpaque];
end;

// clic gauche sur image
procedure TFormTCO.ImageTCOClick(Sender: TObject);
var  Position: TPoint;
     Bimage : integer;
     s : string;
begin
  //Affiche('Clic gauche',clLime);
 
  GetCursorPos(Position);
  {
  Menuitem:=TmenuItem.Create(popupMenu1);
  MenuItem.caption:='Element';
 // MenuItem.onclick:=
  MenuItem.Tag:=GetTickCount;
  popupMenu1.Items.Add(MenuItem); }

  Position:=ImageTCO.screenToCLient(Position);
  //Affiche(IntToSTR(position.x),clyellow);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if XclicCell>NbreCellX then exit;
  if YclicCell>NbreCellY then exit;

  Bimage:=tco[XClicCell,YClicCell].Bimage;

  // si aiguillage, mettre à jour l'option de pilotage inverse
  if (bimage=2) or (bimage=3) or (bimage=4) or (bimage=5) or (bimage=12) or (bimage=13)
     or (bimage=14) or (bimage=15) then
  begin
    CheckPinv.enabled:=true ;
    CheckPinv.checked:=TCO[XClicCell,YClicCell].inverse;
  end
    else CheckPinv.enabled:=false;

  if (Bimage=1) or (Bimage=0) or (Bimage=23) then
  begin
    s:=Tco[XClicCell,YClicCell].Texte;
    EditTexte.Text:=s;
    EditTexte.Visible:=true;
    ComboRepr.Enabled:=true;
  end
  else
  begin
    EditTexte.Visible:=false;
    comboRepr.Enabled:=false;
  end;

  LabelX.caption:=IntToSTR(XclicCell);
  LabelY.caption:=IntToSTR(YclicCell);

  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeImage.Text:=IntToSTR(BImage);
  ComboRepr.ItemIndex:=tco[XClicCell,yClicCell].repr;

  if not(selectionaffichee) then _entoure_cell_clic;
end;

// trouve le détecteur det dans le TCO et renvoie X et Y
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
    until (xc=NbreCellX+1) or trouve;
    inc(yc);
  until (yc=NbreCellY+1) or trouve;  
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
var i,j,x,y,xn,yn,ancienY,ancienX,Xdet1,Ydet1,Xdet2,Ydet2,Bimage,adresse,
    pos,pos2,ir : integer;
    memtrouve,increment,sortir : boolean;
    mdl : Tequipement;
    routeTCO : array[1..100] of record
      x,y : integer;
    end;
    s : string;
begin
  // trouver le détecteur det1
  if debugTCO then AfficheDebug('Zone_TCO det1='+intToSTR(det1)+' det2='+intToSTR(det2)+' mode='+intToSTR(mode)+' couleur='+intToSTR(index_couleur),clyellow);
  trouve_det(det1,Xdet1,Ydet1);
  if (Xdet1=0) or (Ydet1=0) then exit;

  trouve_det(det2,Xdet2,Ydet2);
  if (Xdet2=0) or (Ydet2=0) then exit;

  increment:=true;
  // inverser coordonnées des détecteurs si à l'envers en X
  if xDet2<xDet1 then increment:=false;

  //Affiche('trouvé '+intToSTR(det1)+' en '+IntToSTR(xDet1)+'/'+intToSTR(ydet1),clyellow);
  //Affiche('trouvé '+intToSTR(det2)+' en '+IntToSTR(xDet2)+'/'+intToSTR(ydet2),clyellow);

  // Aller de det1 à det2 vers le sens X croissant du TCO

  if ydet2<ydet1 then ancieny:=ydet1+1 else ancieny:=ydet1-1;
  if xdet2<xdet1 then ancienx:=xdet1+1 else ancienx:=xdet1-1;
  x:=xDet1;y:=Ydet1;
  xn:=x;yn:=y;
  i:=0; memtrouve:=false; sortir:=false;
  ir:=1;

  repeat
    routeTCO[ir].x:=x;
    routeTCO[ir].y:=y;
    if ir<100 then inc(ir); 
    
  
    if debugTCO then AfficheDebug('X='+intToSTR(x)+' Y='+IntToSTR(Y)+' AncienX='+intToSTR(ancienX)+' AncienY='+IntToSTR(ancienY),clyellow);

    // Affiche la cellule en fonction du mode
    Tco[x,y].mode:=mode;

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
    20 : if ancienY<y then yn:=y+1 else yn:=y-1;
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
             if DebugTCO then AfficheDebug('croisement',clyellow);
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
         end

       else

       begin
         // fausse route, sortir
         if DebugTCO then
           AfficheDebug('Sortie de calcul route TCO par élement '+intToSTR(Bimage)+' inconnu en x='+intToSTR(x)+' y='+intToSTR(y)+' sur route '+intToSTR(det1)+' à '+intToSTR(det2),clOrange);
         sortir:=true;
       end;
    end;
    inc(i);
    if adresse=det2 then memTrouve:=true;
    ancienX:=X;
    ancienY:=y;
    x:=xn;
    y:=yn;
  //until (x=1) or (x=NbreCellX) or (y=NbreCellY) or ((adresse<>det2) and memTrouve) or (i>NbCellulesTCO);
  until ((adresse<>det2) and memTrouve) or (i>NbCellulesTCO) or sortir;

  //Affiche(intToSTR(x),clLime);
  if i>NbCellulesTCO then
  begin
    // fausse route, sortir
    if DebugTCO then AfficheDebug('Erreur 1000 TCO : dépassement d''itérations - Route de '+IntToSTR(det1)+' à '+IntToSTR(det2),clred);
    exit;
  end;

  dec(ir);
  for i:=1 to ir do 
    Affiche_cellule(routeTCO[i].x,routeTCO[i].y);
  
end;

procedure TFormTCO.FormActivate(Sender: TObject);
begin
  //Affiche('Form TCO activate',clyellow);
  if not(Forminit) then
  begin
    FormInit:=true;
    Button1.Visible:=not(Diffusion);
    Button2.Visible:=not(Diffusion);
    ButtonSimu.Visible:=not(Diffusion);
    ImageTemp.Visible:=not(Diffusion);
    SourisX.Visible:=not(Diffusion);
    SourisY.Visible:=not(Diffusion);
    ButtonAfficheBandeau.visible:=false;
    TrackBarZoom.Max:=ZoomMax;
    TrackBarZoom.Min:=ZoomMin;
    

    PScrollBoxTCO:=FormTCO.ScrollBox;

    lire_fichier_tco;
    HauteurCell:=ImagePalette1.Height;
    LargeurCell:=ImagePalette1.Width;
    calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);

    // dessiner les icônes
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

    //Affiche_tco;
    TrackBarZoom.Position:=(ZoomMax+Zoommin) div 2;

    if MasqueBandeauTCO then
    begin
      ButtonAfficheBandeau.visible:=true;
      BandeauMasque:=true;
      Panel1.Hide;
      ScrollBox.Height:=ClientHeight-40;
    end
    else
    begin
      BandeauMasque:=false;
      Panel1.show;
      ScrollBox.Height:=ClientHeight-Panel1.Height-40;
    end;
  end;

end;

// evt qui se produit quand on clic droit dans l'image
procedure TFormTCO.ImageTCOContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var  Position: TPoint;

begin
  //Affiche('Clic droit',clyellow);
  // efface le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);

  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;

 // _entoure_cell_clic;

  LabelX.caption:=IntToSTR(XclicCell);
  LabelY.caption:=IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);
  //Affiche('XClicCell='+intToSTR(XclicCell)+' '+'YClicCell='+intToSTR(YclicCell),clyellow);
end;


procedure TFormTCO.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  exit;
  Entoure_cell(XclicCell,YclicCell);
  case Key of
     VK_right : if XClicCell<NbreCellX then inc(XClicCell);
     VK_left  : if XClicCell>1 then dec(XClicCell);
     VK_down  : if YClicCell<NbreCellY then inc(YClicCell);
     VK_up    : if YClicCell>1 then dec(YClicCell);
  end;
  LabelX.caption:=IntToSTR(XClicCell);  
  LabelY.caption:=IntToSTR(YClicCell);
  Entoure_cell(XclicCell,YclicCell);   
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
end;

procedure Elmentdroit1Click(Sender: TObject);
begin
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_voie(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  FormTCO.EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
end;

procedure Courbegaucheversdroite1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_9(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
end;

procedure Courbedroiteversgauche1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_8(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position); 
end;


procedure CourbeSupD1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_7(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
end;

procedure CourbeSupG1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_6(FormTCO.ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);

end;

procedure TFormTCO.ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  // Accept:=source is TImage;
end;


procedure TFormTCO.FormDockOver(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette5.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette5EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_5(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=5;  // image 5
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
 
end;

procedure TFormTCO.ImagePalette2EndDrag(Sender,Target: TObject; X,Y: Integer);
begin      
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  tco[XClicCell,YClicCell].BImage:=2;  // image 2
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  dessin_2(ImageTCO.Canvas,XClicCell,YClicCell,0);
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
  
end;

procedure TFormTCO.ImagePalette2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette2.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette3EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_3(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=3;  // image 3
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette3.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette4EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_4(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=4;  // image 4
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette4.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette1EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(target=ImageTCO) then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_voie(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=1;  // image 1
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
  
end;

procedure TFormTCO.ImagePalette1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette1.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette6EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_6(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=6;  // image 6
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette6.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette7EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_7(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=7;  // image 7
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette7.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette8EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_8(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=8;  // image 8
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette8MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette7.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette9MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette9.BeginDrag(true);
end;


procedure TFormTCO.ImagePalette12MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ImagePalette12.BeginDrag(true);
end;


procedure TFormTCO.ImagePalette13MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette13.BeginDrag(true);
end;


procedure TFormTCO.ImagePalette14MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette14.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette15MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette15.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette16MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette16.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette17MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette17.BeginDrag(true);
end;


procedure TFormTCO.ImagePalette18MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ImagePalette18.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette19MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette19.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette20MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette20.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette21MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette21.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette22MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette22.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette9EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
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
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_12(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=12;  // image 12
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
  
end;


procedure TFormTCO.ImagePalette13EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_13(ImageTCO.Canvas,XClicCell,YClicCell,0);      
  tco[XClicCell,YClicCell].BImage:=13;  // image 13
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
  
end;

procedure TFormTCO.ImagePalette14EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_14(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=14;  // image 14
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette15EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_15(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=15;  // image 15
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette16EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_16(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=16;  // image 16
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette17EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_17(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=17;  // image 17
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;
   
procedure TFormTCO.ImagePalette18EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_18(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=18;  // image 18
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette19EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_19(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=19;  // image 19
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette20EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_20(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=20;  // image 20
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette21EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_21(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=21;
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette22EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_22(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=22;
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
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
    TamponTCO_Org.x1:=XminiSel div LargeurCell +1;
    TamponTCO_Org.x2:=XmaxiSel div LargeurCell +1;
    TamponTCO_Org.y1:=yminiSel div LargeurCell +1;
    TamponTCO_Org.y2:=ymaxiSel div LargeurCell +1; 
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
    efface_cellule(ImageTCO.Canvas,XclicCell,YClicCell,fond,PmCopy);
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
      efface_cellule(ImageTCO.Canvas,X,Y,fond,PmCopy);
      if avecGrille then grille;
    end;
end;

procedure TFormTCO.AnnulercouperClick(Sender: TObject);
var x,y,Xplace,yplace,adresse : integer;
begin
  if TamponAffecte then
  begin

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
begin
//  ImageTCO.BeginDrag(true);
    if button=mbLeft then
    begin
      //Affiche('Souris clic enfoncée',clLime);
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
    end;

    if button=mbRight then
    begin
      GetCursorPos(Position);
      Position:=ImageTCO.screenToCLient(Position);
      Xclic:=position.X;
      YClic:=position.Y;
  
      // coordonnées grille
      XclicCell:=Xclic div largeurCell + 1;
      YclicCell:=Yclic div hauteurCell + 1;

       LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  end;
end;

procedure TFormTCO.ImageTCOMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
var  Position: TPoint;
     r : Trect;
     cellX,cellY,x0,y0,XSel1,YSel1,XSel2,YSel2,Bimage : integer;
     s : string;
begin
  //Affiche('Mouse Move direct',clLime);
  if Temposouris<1 then exit;
  if not(sourisclic) then exit;
  //Affiche('Mouse Move',clLime);
  SourisX.Caption:=IntToSTR(x);
  SourisY.Caption:=IntToSTR(y);

  cellX:=x div largeurCell+1;
  cellY:=y div hauteurCell+1;

  if CellX>NbreCellX then exit;
  if CellY>NbreCellY then exit;

  Bimage:=tco[cellX,cellY].BImage;
  s:='Type Image='+IntToSTR(Bimage);
  ImageTCO.Hint:=s;

  // on a cliqué la souris en la bougeant : sélection bleue en cours
  GetCursorPos(Position);
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;
  YClic:=position.Y;

  // coordonnées grille
  AncienXClicCell:=XclicCell;
  AncienYClicCell:=YclicCell;
  XclicCell:=Xclic div largeurCell + 1;
  YclicCell:=Yclic div hauteurCell + 1;
  if (AncienXClicCell=XclicCell) and (AncienYClicCell=YclicCell) then exit;
  if XclicCell>NbreCellX then exit;
  if YclicCell>NbreCellY then exit;

  //Affiche('MouseMove',clyellow);
  //Affiche('X='+IntToSTR(XClicCell)+' Y='+intToSTR(YclicCell),clyellow);

  x0:=(XclicCell-1)*LargeurCell;
  y0:=(YclicCell-1)*HauteurCell;
  //Affiche('X0='+IntToSTR(x0)+' Y0='+intToSTR(y0),clyellow);

  AncienXMiniSel:=xMiniSel;
  AncienYMiniSel:=YminiSel;
  AncienXmaxiSel:=XmaxiSel;
  AncienYMaxiSel:=YmaxiSel;

  if xMiniSel>x0 then XminiSel:=X0;
  if yMiniSel>y0 then yminiSel:=y0;
  if xMaxiSel<x0 then xmaxiSel:=x0;
  if yMaxiSel<y0 then ymaxiSel:=y0;

  //Affiche('xMiniSel='+IntToSTR(xMiniSel)+' xMaxiSel='+IntToSTR(xMaxiSel)+' yMiniSel='+IntToSTR(yMiniSel)+' yMaxiSel='+IntToSTR(yMaxiSel),clOrange);

  // efface l'ancien rectangle de sélection
  if SelectionAffichee then
  with imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille;
    Brush.Color:=clblue;
    //FillRect(r);
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
var Adr,erreur,index,aspect : integer;
begin
  //Affiche('Chgt adresse',clyellow);

  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then Adr:=0;
    
  if Adr=0 then tco[XClicCell,YClicCell].repr:=2;

  tco[XClicCell,YClicCell].Adresse:=Adr;

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


procedure TFormTCO.EditAdrElementKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then 
  begin
    efface_entoure;
    affiche_cellule(XClicCell,YClicCell);
  end;  
end;

procedure TFormTCO.EditTypeImageKeyPress(Sender: TObject; var Key: Char);
var Bimage,erreur : integer;
begin
  if ord(Key)=VK_RETURN then
  begin
    Key:=#0; // évite beeping
    Val(EditTypeImage.Text,Bimage,erreur);
    //Affiche('Keypressed / Bimage='+IntToSTR(bimage),clyellow);
    if (erreur<>0) or (Bimage<0) or (Bimage>15) then 
    begin
      EditTypeImage.text:=intToSTR(tco[XClicCell,YClicCell].BImage);
      exit;
    end;  
    TCO_modifie:=true;
    tco[XClicCell,YClicCell].Bimage:=Bimage;

    affiche_cellule(XClicCell,YClicCell);
  end;
end;

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


// dépose d'un feu sur le TCO
procedure TFormTCO.ImageDiag10EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_10(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=10;  // image 10
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[XClicCell,YClicCell].FeuOriente:=1; 
  entoure_cell_grille(XClicCell,YClicCell); 
  tco[xClicCell,YClicCell].CoulFonte:=clYellow; 
  _entoure_cell_clic; 
  tco[XClicCell,YClicCell].x:=0;  //  XClicCell;  //??
  tco[XClicCell,YClicCell].y:=0;  //  YClicCell;  //??
   
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette10.BeginDrag(true);
end;

procedure TFormTCO.ImageDiag11EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_11(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=11;
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  tco[xClicCell,YClicCell].CoulFonte:=clYellow;
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette11MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette11.BeginDrag(true);
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
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  //PCanvasTCO.Draw((xClicCell-1)*LargeurCell,(yClicCell-1)*HauteurCell,ImageFeu.Picture.Bitmap);
  tco[XClicCell,YClicCell].BImage:=30;
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[XClicCell,YClicCell].FeuOriente:=1;
  tco[XClicCell,YClicCell].PiedFeu:=1;
  tco[XClicCell,YClicCell].coulFonte:=clWhite;
  
  tco[XClicCell,YClicCell].x:=0;
  tco[XClicCell,YClicCell].y:=0;

  // ne pas convertir l'adresse sinon evt changement du composant et on écrase l'aspect EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);

  dessin_feu(PCanvasTCO,XclicCell,YClicCell);
  entoure_cell_grille(XClicCell,YClicCell);
  _entoure_cell_clic;

end;


procedure TFormTCO.ImagePalette30MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ImagePalette30.BeginDrag(true);
end;


procedure TFormTCO.Tourner90GClick(Sender: TObject);
var BImage : integer;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>30 then exit;

  TCO_modifie:=true;

  // effacement de l'ancien feu
  if tco[XClicCell,YClicCell].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  if tco[XClicCell,YClicCell].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell-1,yClicCell,fond,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[XClicCell,YClicCell].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,fond,PmCopy);
  end;

  tco[XClicCell,YClicCell].FeuOriente:=2;  // feu orienté à 90° gauche
  Affiche_TCO;
end;

procedure TFormTCO.Tourner90DClick(Sender: TObject);
var BImage ,aspect,adresse : integer;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>30 then exit;

  TCO_modifie:=true;

  adresse:=TCO[XClicCell,YClicCell].Adresse;
  aspect:=feux[index_feu(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // ancien feu orienté orienté 90D
  if tco[XClicCell,YClicCell].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // ancien feu orienté orienté 90G
  if tco[XClicCell,YClicCell].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[XClicCell,YClicCell].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,fond,PmCopy);
  end;

  tco[XClicCell,YClicCell].FeuOriente:=3;  // feu orienté à 90° droit
  //dessin_feu(PCanvasTCO,XclicCell,YClicCell);
  Affiche_TCO;
end;


procedure TFormTCO.Pos_vertClick(Sender: TObject);
var BImage ,aspect,Adresse : integer;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  // si c'est autre chose qu'un feu, sortir
  if Bimage<>30 then exit;

  TCO_modifie:=true;
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  aspect:=feux[index_feu(adresse)].Aspect;
  if aspect=0 then aspect:=9;

  // effacement de l'ancien feu

  // ancien feu orienté orienté 90D
  if tco[XClicCell,YClicCell].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    // si le feu occupe 2 cellules
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // ancien feu orienté orienté 90G
  if tco[XClicCell,YClicCell].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    // si le feu occupe 2 cellules
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if tco[XClicCell,YClicCell].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,fond,PmCopy);
  end;

  tco[XClicCell,YClicCell].FeuOriente:=1;  // feu orienté à 180°
  //dessin_feu(PCanvasTCO,XclicCell,YClicCell);
  affiche_tco;

end;

procedure TFormTCO.TrackBarZoomChange(Sender: TObject);
begin
  calcul_cellules;
  Affiche_TCO;
  SelectionAffichee:=false;
  //Affiche(intTostr(TrackBarZoom.Position),clLime);
end;


// interdire la fermeture de la fenêtre tco
procedure TFormTCO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=tCloseAction(caNone);
end;

procedure TFormTCO.EditTexteChange(Sender: TObject);
begin
  PCanvasTCO.Brush.Color:=fond;

  if Tco[XClicCell,YClicCell].texte='' then
  begin
    Tco[XClicCell,YClicCell].CoulFonte:=clTexte;
    Tco[XClicCell,YClicCell].TailleFonte:=8;
  end;
  Tco[XClicCell,YClicCell].Texte:=EditTexte.Text;
  TCO_modifie:=true;
  affiche_texte(XClicCell,YClicCell);
end;

procedure TFormTCO.ButtonSimuClick(Sender: TObject);
begin
  aiguillage[Index_Aig(1)].position:=const_droit;
  aiguillage[Index_Aig(2)].position:=const_droit;
  aiguillage[Index_Aig(3)].position:=const_droit;
  aiguillage[Index_Aig(4)].position:=const_devie;
  aiguillage[Index_Aig(5)].position:=const_droit;
  aiguillage[Index_Aig(7)].position:=const_devie;
  aiguillage[Index_Aig(12)].position:=const_droit;
  aiguillage[Index_Aig(20)].position:=const_droit;
  aiguillage[Index_Aig(21)].position:=const_droit;
  aiguillage[Index_Aig(26)].position:=const_droit;
  aiguillage[Index_Aig(28)].position:=const_devie;
  index_couleur:=1;
  aiguillage[Index_Aig(81)].position:=const_droit;
  aiguillage[Index_Aig(82)].position:=const_droit;
  aiguillage[Index_Aig(120)].position:=const_droit;
  aiguillage[Index_Aig(119)].position:=const_droit;
  aiguillage[Index_Aig(116)].position:=const_droit;
  aiguillage[Index_Aig(117)].position:=const_devie;
   
  
  zone_TCO(518,523,1);
end;

procedure TFormTCO.CheckPinvClick(Sender: TObject);
var Bimage : integer;
begin
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
  Bimage:=Tco[xClicCell,yClicCell].BImage;
  Adresse:=TCO[xClicCell,yClicCell].Adresse;
  if adresse=0 then exit;

  tjdC:=false;
  if (Bimage=21) or (Bimage=22) then
  begin
    i:=Index_aig(Adresse);
    tjdC:=(aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs);
  end;

  // commande aiguillage
  if (Bimage=2) or (Bimage=3) or (Bimage=4) or (Bimage=5) or (Bimage=12) or
     (Bimage=13) or (Bimage=14) or (Bimage=15) or TJDc then
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
      sourisclic:=false;  // évite de générer un cadre de sélection
    end;
  end;
end;

procedure TFormTCO.ComboReprChange(Sender: TObject);
begin
  tco[XClicCell,YClicCell].Repr:=comborepr.ItemIndex;
  efface_entoure;SelectionAffichee:=false;
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

procedure TFormTCO.ImagePalette23DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=true;
end;

procedure TFormTCO.ImagePalette23EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if not(Target is TImage) then exit;
  if (Target as TImage).Name<>'ImageTCO' then exit;
  if (x=0) and (y=0) then exit;
  efface_entoure;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_23(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BImage:=23;
  tco[XClicCell,YClicCell].Adresse:=0;
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette23MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette23.BeginDrag(true);
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

procedure TFormTCO.ImagePalette20DragOver(Sender, Source: TObject; X,
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

procedure TFormTCO.ButtonFonteClick(Sender: TObject);
var s,ss : string;
    fs : TFontStyles;
begin
  s:='Fonte et couleur pour la cellule ('+intToSTR(xClicCell)+','+intToSTR(YClicCell)+') Texte: ';
  ss:=tco[xClicCell,YClicCell].Texte;
  if ss='' then s:=s+inttoSTR(tco[xClicCell,YClicCell].Adresse) else s:=s+ss;
  
  titre_fonte:=s;
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

procedure TFormTCO.FontDialog1Show(Sender: TObject);
begin
  SetWindowText(FontDialog1.Handle,pchar(titre_Fonte));
end;

procedure TFormTCO.Signaldroitedelavoie1Click(Sender: TObject);
begin
  if TCO[XClicCell,YClicCell].Bimage=30 then
  begin
    TCO[XClicCell,YClicCell].PiedFeu:=2;
    Affiche_TCO;
  end;
end;

procedure TFormTCO.Signalgauchedelavoie1Click(Sender: TObject);
begin
  if TCO[XClicCell,YClicCell].Bimage=30 then
  begin
    TCO[XClicCell,YClicCell].PiedFeu:=1;
    Affiche_TCO;
  end;  
end;


begin
end.
