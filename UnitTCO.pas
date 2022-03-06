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
    Label5: TLabel;
    Label15: TLabel;
    EditAdrElement: TEdit;
    EditTypeElement: TEdit;
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
    procedure FormCreate(Sender: TObject);
    procedure ImageTCOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure dessin_AigPG_AG(Canvas : Tcanvas;x,y : integer;Mode , position : integer);
    procedure dessin_Aig45PG_AG(Canvas : Tcanvas;x,y : integer;Mode, position : integer);
    procedure dessin_Aig45PD_AG(Canvas : Tcanvas;x,y : integer;Mode, position : integer);
    procedure dessin_Aig45PD_AD(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
    procedure dessin_Aig45PG_AD(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
    procedure dessin_AigPD_AD(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
    procedure dessin_Diag1(Canvas : Tcanvas;x,y : integer;Mode : integer);
    procedure dessin_Diag2(Canvas : Tcanvas;x,y : integer;Mode : integer);
    procedure dessin_infG(Canvas : Tcanvas;x,y : integer;Mode : integer);
    procedure dessin_infD(Canvas : Tcanvas;x,y : integer;Mode : integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dessin_AigG_PD(canvas : Tcanvas;X,Y : integer; Mode,position : integer);
    procedure Elmentdroit1Click(Sender: TObject);
    procedure dessin_voie(Canvas : Tcanvas;x,y,mode : integer);
    procedure Courbegaucheversdroite1Click(Sender: TObject);
    procedure Courbedroiteversgauche1Click(Sender: TObject);
    procedure dessin_AigD_PG(Canvas : Tcanvas;x,y,Mode,position : integer);
    procedure CourbeSupD1Click(Sender: TObject);
    procedure dessin_SupD(Canvas : Tcanvas;x,y : integer; Mode : integer);
    procedure CourbeSupG1Click(Sender: TObject);
    procedure dessin_SupG(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    procedure Affiche_TCO;
    procedure affiche_cellule(x,y : integer);
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
    procedure dessin_16(Canvas : Tcanvas;x,y,mode: integer);
    procedure dessin_17(Canvas : Tcanvas;x,y,mode: integer);
    procedure dessin_18(Canvas : Tcanvas;x,y,mode: integer);
    procedure dessin_19(Canvas : Tcanvas;x,y,mode: integer);
    procedure dessin_20(Canvas : Tcanvas;x,y,mode: integer);
    procedure dessin_21(Canvas : Tcanvas;x,y,mode: integer);
    procedure dessin_22(Canvas : Tcanvas;x,y,mode: integer);
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
    procedure FormResize(Sender: TObject);
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
    procedure Colorer1Click(Sender: TObject);
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

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;



const
  ZoomMax=50;
  MaxCellX=150;MaxCellY=70;

type  
  // structure du TCO
  TTCO = array[1..MaxCellX] of array[1..MaxCellY] of record
               BType : TEquipement ;
               Adresse : integer ;    // adresse du détecteur ou de l'aiguillage ou du feu
               BImage : integer ;     // 0=rien 1=voie 2=aiguillage gauche gauche ... 30=feu
               mode :  integer;       // 0=éteint 1=allumé
               inverse : boolean;     // aiguillage piloté inversé
               repr     : integer;    // représentation 0 = rien 1=centrale 2=Haut  3=Bas
               Texte : string[30];
               Couleur : Tcolor;        // couleur de fond de la cellule
               // pour les feux seulement
               PiedFeu : integer; // type de pied au feu
               x,y     : integer ; // coordonnées pixels relativés du coin sup gauche pour le décalage par rapport à la cellule
               FeuOriente : integer;  // orientation du feu : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit
               Aspect    : integer;    // aspect du feu (2 feux...9 feux)
            end;

  
var
  clAllume,clVoies,Fond,couleurAdresse,clGrille,cltexte : Tcolor;
  FormTCO: TFormTCO;
  Forminit,sourisclic,SelectionAffichee,TamponAffecte,entoure,Diffusion,TCO_modifie,
  piloteAig : boolean;
  HtImageTCO,LargImageTCO,XclicCell,YclicCell,XminiSel,YminiSel,XCoupe,Ycoupe,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel ,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,Xentoure,Yentoure,
  AncienXClicCell,AncienYClicCell : integer;
  
  TamponTCO,tco : TTco ;
  // pour copier coller
  TamponTCO_Org : record 
                   x1,y1,x2,y2 : integer;
                  end;  
  rAncien : TRect;          
  PCanvasTCO : Tcanvas;
  PBitMapTCO : TBitMap;
  PScrollBoxTCO : TScrollBox;
  PImageTCO : Timage;
  PImageTemp : TImage;
  frXGlob,frYGlob : real;
  LargeurCell,HauteurCell,NbreCellX,NbreCellY,NbCellulesTCO : integer   ;

procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
procedure sauve_fichier_tco;
procedure zone_TCO(det1,det2,mode : integer);
procedure efface_entoure;

implementation

uses UnitConfigTCO, Unit_Pilote_aig;

{$R *.dfm}

procedure lire_fichier_tco;
var fichier : textfile;
    s : string;
    x,y,i,j,m,adresse,Aspect,valeur,erreur,FeuOriente,PiedFeu : integer;
    BT : TEquipement;
    function lit_ligne : string ;
    var c : char;
    begin
      repeat
        readln(fichier,s);
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
    NbreCellX:=35;NbreCellY:=20;LargeurCell:=30;HauteurCell:=30;
    exit;
  end;
  {$I-}

  x:=1;y:=1;NbreCellX:=0;NbreCellY:=0;

  // couleurs
  s:=lit_ligne;
  val('$'+s,fond,erreur);
  s:=lit_ligne;
  val('$'+s,clVoies,erreur);
  s:=lit_ligne;
  val('$'+s,clAllume,erreur);
  s:=lit_ligne;
  val('$'+s,clGrille,erreur);
  s:=lit_ligne;
  
  if pos(',',s)=0 then begin val('$'+s,cltexte,erreur);s:=lit_ligne;end;
  
  // taille de la matrice
  Val(s,NbreCellX,erreur);
  delete(s,1,erreur);
  Val(s,NbreCellY,erreur);
  NbCellulesTCO:=NbreCellX*NbreCellY;
  
  // largeur et hauteur des cellules
  s:=lit_ligne;
  Val(s,LargeurCell,erreur);
  delete(s,1,erreur);
  Val(s,HauteurCell,erreur);

  // lire le fichier
  while not eof(fichier) do
  begin
    s:=lit_ligne;
    if s[1]<>'/' then
    begin
      repeat
        i:=pos('(',s);
        if i=0 then begin closefile(fichier);exit;end;
        delete(s,i,1);

        // Btype
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        if valeur=1 then BT:=det;
        if valeur=2 then BT:=aig;
        if valeur=4 then BT:=buttoir;

        tco[x,y].BType:=BT;
        delete(s,1,i);

        // Adresse
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),adresse,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].adresse:=adresse;
        delete(s,1,i);

        //Bimage
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].Bimage:=valeur;
        delete(s,1,i);

        //Inverse
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].inverse:=valeur=1;
        delete(s,1,i);

        // FeuOriente (pas encore stocké)
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),FeuOriente,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        delete(s,1,i);

        // PiedFeu (pas encore stocké)
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
            aspect:=Feux[i].aspect;
            //Affiche('Feu '+IntToSTR(Adresse)+' aspect='+intToSTR(aspect),clyellow);
            tco[x,y].Aspect:=aspect;
            tco[x,y].FeuOriente:=FeuOriente;
            tco[x,y].x:=0;
            tco[x,y].y:=0;
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
          delete(s,1,m);
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
          val(s,j,erreur);
          tco[x,y].repr:=j;
          delete(s,1,erreur);
        end;

        { affiche('TCO'+intToSTR(x)+','+intToSTR(y)+'='+IntToSTR(tco[x,y].BType)+','+intToSTR(tco[x,y].Adresse)+','
         +intToSTR(tco[x,y].Bimage)+','+','+intToSTR(tco[x,y].PiedFeu)+','+tco[x,y].Texte,clyellow);
         }
        inc(x);
      until s='';
    end;
    inc(y);x:=1;
  end;
  closefile(fichier);
  Affiche('Dimensions du tco : '+intToSTR(NbreCellX)+'x'+intToSTR(NbreCellY),clyellow);

end;

procedure sauve_fichier_tco;
var fichier : textfile;
    s : string;
    x,y : integer;
begin
  AssignFile(fichier,'tco.cfg');
  rewrite(fichier);
  Writeln(fichier,'/ Couleurs : fond, voies, détecteur_activé, grille, textes');
  Writeln(fichier,IntToHex(fond,6));
  Writeln(fichier,IntToHex(ClVoies,6));
  Writeln(fichier,IntToHex(ClAllume,6));
  Writeln(fichier,IntToHex(ClGrille,6));
  Writeln(fichier,IntToHex(ClTexte,6));

  writeln(fichier,'/ Taille de la matrice x,y');
  writeln(fichier,IntToSTR(NbreCellX)+','+intToSTR(NbreCellY));
  writeln(fichier,'/ Largeur et hauteur des cellules en pixels');
  writeln(fichier,IntToSTR(LargeurCell)+','+intToSTR(HauteurCell));
  writeln(fichier,'/Dalle TCO');
  writeln(fichier,'/ type,adresse,image,inversion aiguillage,Orientation du feu, pied du feu , [texte], representation');
  for y:=1 to NbreCellY do
  begin
    s:='';
    for x:=1 to NbreCellX do
    begin
      s:=s+'('+IntToSTR(BTypeToNum(TCO[x,y].BType))+','+Format('%.*d',[3,TCO[x,y].Adresse])+','+
           IntToSTR(TCO[x,y].BImage)+',';

           if TCO[x,y].inverse then s:=s+'1,' else s:=s+'0,';

           if TCO[x,y].BImage=30 then
           begin
             s:=s+IntToSTR(TCO[x,y].FeuOriente)+','+IntToSTR(TCO[x,y].PiedFeu)+',';
           end
           else s:=s+'0,0,';
      // texte
      s:=s+TCO[x,y].Texte+',';
      s:=s+intToSTR(TCO[x,y].repr)+')';
    end;
    writeln(fichier,s);
  end;
  closefile(fichier);
  TCO_modifie:=false;
  Affiche('TCO sauvegardé',clyellow);
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

// élément de voie horizontale Element 1
procedure TFormTCO.dessin_voie(Canvas : Tcanvas;x,y,mode : integer);
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
    if (mode=1) then couleur:=clAllume else couleur:=clVoies;
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
procedure TformTCO.dessin_AigG_PD(canvas : Tcanvas;x,y : integer; Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
      x1:=x0+(largeurCell div 2); y1:=jy1+round(1*frYGlob);
      x2:=x0-round(1*FrXGlob);y2:=y0+HauteurCell-round(2*FrYGlob);     //1
      x3:=x0+round(2*FrXGlob);y3:=y0+HauteurCell;          //2
      x4:=x1+round(1*FrXGlob);y4:=jy2;                     //1
      canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
      //Canvas.Brush.Color:=clVoies;
    end;  
    
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
  jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
  inverse:=tco[x,y].inverse;
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    Pen.Color:=clVoies;
    Pen.Mode:=pmCopy;
    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or  (position=9) then
    if (position=const_Devie) or (position=9) then 
    begin
      horz;
      if (mode=1) and (position=const_devie) then 
      begin 
        Pen.color:=clAllume;Brush.color:=ClAllume 
      end 
      else 
      begin 
        Pen.color:=clVoies;Brush.Color:=clVoies;
      end;
      deviation;
      r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
      canvas.FillRect(r);

      // effacement du morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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

    // aiguillage droit (sans inversion) dévié (avec inversion)
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_Droit) then
    begin
      deviation;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
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
procedure TFormTCO.dessin_AigPG_AG(Canvas : Tcanvas;x,y : integer;Mode ,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
      x1:=x0+(largeurCell div 2)+round(1*frXGlob); y1:=jy1;
      x2:=x0+largeurCell-round(3*frXGlob); y2:=y0;
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
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    pen.color:=clVoies;
    Pen.Mode:=pmCopy;
    
    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin
      horz;
      if (mode=1) and (position=const_Devie) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      devie;
      r:=Rect(x0,jy1,x0+1+(LargeurCell div 2),jy2);
      canvas.FillRect(r);
      
      // effacement du morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_Droit) then
    begin
      devie;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) 
        then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clYellow;Brush.Color:=clVoies;end;
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
procedure TformTCO.dessin_AigD_PG(Canvas : Tcanvas;x,y,Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
  
  with canvas do
  begin
    // efface la cellule
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Pen.Mode:=pmCopy;
    pen.color:=clVoies;
    Brush.color:=clVoies;

    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin
      bande_horz;
      if (mode=1) and ( ((inverse=false) and (position=const_Devie)) or ((inverse=true) and (position=const_Droit)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      // demi bande droite
      r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
      Canvas.FillRect(r);
      deviation;
      // effacement du morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_Droit) then
    begin
      deviation;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then Brush.color:=clAllume else Brush.Color:=couleur;
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


// aiguillage pointe à droite, aiguillage droit Element 5
procedure TFormTCO.dessin_AigPD_AD(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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

  //Affiche('Position='+IntToSTR(position),clyellow);
  inverse:=tco[x,y].inverse;
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.COlor:=clVoies;
    Pen.Mode:=pmCopy;
    pen.color:=clVoies;

    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin
      horz;
      if (mode=1) and ( ((inverse=false) and (position=const_Devie)) or ((inverse=true) and (position=const_Droit)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      // demi bande droite
      r:=Rect(x0+(largeurCell div 2),jy1,x0+LargeurCell,jy2);
      Canvas.FillRect(r);
      deviation;

      // efface le morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
      
    // aiguillage droit (sans inversion) ou dévie (avec inversion)
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_Droit) then
    begin
      deviation;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
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
procedure TformTCO.dessin_SupG(Canvas : Tcanvas;x,y : integer;Mode : integer);
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

    if mode=1 then couleur:=clAllume else couleur:=clVoies;
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
procedure TformTCO.dessin_SupD(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
    
    if Mode=1 then couleur:=clAllume else couleur:=clVoies;
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
procedure TFormTCO.dessin_infD(Canvas : Tcanvas;x,y : integer;Mode : integer);
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

    if Mode=1 then couleur:=clAllume else couleur:=clVoies;
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
procedure TFormTCO.dessin_infG(Canvas : Tcanvas;x,y : integer;Mode : integer);
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

    if Mode=1 then couleur:=clAllume else couleur:=clVoies;
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
procedure TformTCO.dessin_Diag1(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
        x1:=x0;y1:=y0+hauteurCell-round(6*FryGlob);
        x2:=x0+largeurCell-round(6*FrXGlob);y2:=y0+1;
        x3:=x0+largeurCell-1;y3:=y0+round(9*FrYGlob);
        x4:=x0+round(9*FrXGlob); y4:=y0+hauteurCell-1;
        PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
    end;  
    
    x1:=x0;y1:=y0+hauteurCell-round(3*FryGlob);
    x2:=x0+largeurCell-round(3*FrXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*FrYGlob);
    x4:=x0+round(4*FrXGlob); y4:=y0+hauteurCell;

    if Mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.Color:=couleur;
    pen.color:=couleur;
  
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    
    
  end;
end;  

// élément 11
procedure TformTCO.dessin_Diag2(Canvas : Tcanvas;x,y : integer;Mode : integer);
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
        x1:=x0+round(6*FrXGlob);y1:=y0;
        x2:=x0+largeurCell-1;y2:=y0+HauteurCell-round(6*FrYGlob)-1;
        x3:=x0+largeurCell-round(8*FrXGlob)-1;y3:=y0+HauteurCell-1;
        x4:=x0;y4:=y0+round(8*frYGlob);
        PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
    end;  
    
    x1:=x0+round(3*FrXGlob);y1:=y0;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*FrYGlob);
    x3:=x0+largeurCell-round(4*FrXGlob);y3:=y0+HauteurCell;
    x4:=x0;y4:=y0+round(4*frYGlob);
    
    if mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.Color:=couleur;
    pen.color:=couleur;
  
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
  end;
end;  

// Element 12 aiguillage pointe 45°G vers droit
procedure TFormTCO.dessin_Aig45PG_AG(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
  
  with canvas do
  begin
    // efface cellule
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    pen.color:=clVoies;
    
    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin
      diagonale;
      if (mode=1) and ( ((inverse=false) and (position=const_Devie)) or ((inverse=true) and (position=const_Droit)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      horz;
      // morceau de diag à tracer en clAllume
      if mode=1 then
      begin
        x1:=x0+round(3*frXGlob);y1:=y0;
        x2:=x0+(largeurCell div 2)+round(7*frXGlob);y2:=jy2;//y2:=y0+(HauteurCell div 2);
        x3:=x2-round(9*frXGlob); y3:=y2;
        x4:=x0; y4:=y0+round(4*frYGlob);
        canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
           
      // efface le morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie))  then
    if (position=const_Droit) then
    begin
      horz;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
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
procedure TFormTCO.dessin_Aig45PD_AD(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
  
  with canvas do
  begin
    //efface
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);
    
    Brush.Color:=clVoies;
    pen.color:=clVoies;
   
    // aiguillage dévié (sans inversion) ou position inconnue (9) 
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin
      diagonale;
      if (mode=1) and ( ((inverse=false) and (position=const_Devie)) or ((inverse=true) and (position=const_Droit)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      horz;
      if mode=1 then
      begin
        // morceau de diagonale à tracer en clAllume
        x1:=x0+largeurCell-round(3*frXGlob);y1:=y0;
        x2:=x0+largeurCell;y2:=y0+round(4*FryGlob);
        x3:=x0+(largeurCell div 2)+round(4*frXGlob);y3:=jy2;
        x4:=x0+(largeurCell div 2)-round(7*frXGlob);y4:=jy2;
        canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
      
      // efface le morceau  
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_droit) then
    begin
      horz;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
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
procedure TFormTCO.dessin_Aig45PD_AG(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;
    pen.color:=clVoies;
    
    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin        
      diagonale;
      if (mode=1) and ( ((inverse=false) and (position=const_Devie)) or ((inverse=true) and (position=const_Droit)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      horz;
      
      if mode=1 then
      begin
        // morceau de diagonale à tracer en clAllume
        x1:=x0+(largeurCell div 2)-round(8*frXGlob); y1:=jy1;
        x2:=x1+round(8*frXGlob); y2:=y1;
        x3:=x0+largeurCell; y3:=y0+HauteurCell-round(3*fryGlob);
        x4:=x0+largeurCell-round(4*frXGlob);y4:=y0+HauteurCell;
        canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
      // efface le morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_Droit) then
    begin
      horz;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
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
procedure TFormTCO.dessin_Aig45PG_AD(Canvas : Tcanvas;x,y : integer;Mode,position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
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
  
  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=clVoies;                                       
    pen.color:=clVoies;
    
    // aiguillage dévié (sans inversion)
    //if ((inverse=false) and (position=const_Devie)) or
    //   ((inverse=true)  and (position=const_Droit)) or
    //   (position=9) then
    if (position=const_Devie) or (position=9) then
    begin            
      diagonale;
      if (mode=1) and ( ((inverse=false) and (position=const_Devie)) or ((inverse=true) and (position=const_Droit)) ) then begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      horz;
      if mode=1 then
      begin
        // morceau de diag à tracer en clAllume
        x1:=x0;y1:=y0+hauteurCell-round(3*frYGlob);
        x2:=x0+(largeurCell div 2);y2:=jy1;
        x3:=x2+round(9*frXglob);y3:=y2;
        x4:=x0+round(3*frYGlob);y4:=y0+hauteurCell;
        canvas.PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
      end;
      
      // efface le morceau
      //if ((inverse=false) and (position=const_Devie)) or
      //   ((inverse=true)  and (position=const_Droit)) then
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
    //if ((inverse=false) and (position=const_Droit)) or
    //   ((inverse=true)  and (position=const_Devie)) then
    if (position=const_Droit) then
    begin
      horz;
      if (mode=1) and ( ((inverse=false) and (position=const_droit)) or ((inverse=true) and (position=const_devie)) ) then  begin Pen.color:=clAllume;Brush.color:=ClAllume end else begin Pen.color:=clVoies;Brush.Color:=clVoies;end;
      diagonale;

      // efface morceau  
      x1:=x0+round(34*frXGlob);y1:=jy1;
      x2:=x1+round(6*frxGlob);y2:=y1;
      x3:=x2-round(12*FrxGlob);y3:=y2+round(12*fryGlob);
      x4:=x3-round(6*frxGlob);y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;  

// Element 16
procedure TFormTCO.dessin_16(Canvas : Tcanvas;x,y,mode: integer);
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

    if mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.COlor:=Couleur;
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
procedure TFormTCO.dessin_17(Canvas : Tcanvas;x,y,mode: integer);
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

    if mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.COlor:=Couleur;
    pen.color:=Couleur;
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
procedure TFormTCO.dessin_18(Canvas : Tcanvas;x,y,mode: integer);
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

    if mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.COlor:=Couleur;
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
procedure TFormTCO.dessin_19(Canvas : Tcanvas;x,y,mode: integer);
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

    if mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.COlor:=Couleur;
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
procedure TFormTCO.dessin_20(Canvas : Tcanvas;x,y,mode: integer);
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
    
    if mode=1 then couleur:=clAllume else couleur:=clVoies;
    Brush.COlor:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=pmCopy;
    xbv1:=x0+(LargeurCell div 2)-round(3*frXGlob); // pos x de la bande verticale
    xbv2:=x0+(LargeurCell div 2)+round(3*frXGlob); // pos x de la bande verticale
    r:=Rect(xbv1,y0,xbv2,y0+HauteurCell);
    FillRect(r);
  end;
end;

// Element 21 - croisement - TJD
procedure TFormTCO.dessin_21(Canvas : Tcanvas;x,y,mode: integer);
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
    Brush.Color:=clvoies;
    pen.color:=clvoies;
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);
    
  end;
end;

// Element 22
procedure TFormTCO.dessin_22(Canvas : Tcanvas;x,y,mode: integer);
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

procedure affiche_pied2G_90G(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1-7)*frX),y+round((y1+35)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+35)*frY) );
  end;
end;

procedure affiche_pied2G_90D(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1+7)*frX),y+round((y1-35)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1-35)*fry) );
  end;
end;

procedure affiche_pied_Vertical2G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=35;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+6)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied3G_90D(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=45;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1-35)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1-35)*fry) );
  end;
end;

procedure affiche_pied3G_90G(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1-7)*frX),y+round((y1+35)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+35)*frY) );
  end;
end;

procedure affiche_pied_Vertical3G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=42;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+6)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+6)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+7)*frY) );
  end;
end;

procedure affiche_pied4G_90G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=0;y1:=12;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1-7)*frX),y+round((y1+35)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+35)*frY) );
  end;
end;

procedure affiche_pied4G_90D(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1+7)*frX),y+round((y1-35)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1-35)*fry) );
  end;
end;

procedure affiche_pied_Vertical4G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=55;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+7)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+8)*frY) );
  end;
end;

procedure affiche_pied9G_90D(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1+7)*frX),y+round((y1-60)*fry));

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1-60)*fry) );
  end;
end;


procedure affiche_pied5G_90D(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1+7)*frX),y+round((y1-35)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1-35)*fry) );
  end;
end;

procedure affiche_pied5G_90G(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1-7)*frX),y+round((y1+35)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+35)*frY) );
  end;
end;

procedure affiche_pied_Vertical5G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=65;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+7)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    LineTo( x+round((x1+38)*frX),y+round((y1+8)*frY) );
  end;
end;

procedure affiche_pied7G_90D(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
    ech : real;
begin
  ech:=frY;frY:=frX;FrX:=ech;
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=75;y1:=38;
    moveTo( x+round((x1)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+7)*frX),y+round((y1-60)*fry) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1+6)*frX),y+round((y1-60)*fry) );
  end;
end;

procedure affiche_pied7G_90G(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1-7)*frX),y+round((y1+70-12)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+70-13)*frY) );
  end;
end;

procedure affiche_pied_Vertical7G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=75;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) );

    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    LineTo( x+round((x1+60)*frX),y+round((y1+8)*frY) );
  end;
end;

procedure affiche_pied9G_90G(x,y : integer;FrX,frY : real);
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
    LineTo( x+round((x1-7)*frX),y+round((y1+70-12)*frY) );

    moveTo( x+round((x1)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+1)*frY) );
    LineTo( x+round((x1-6)*frX),y+round((y1+70-13)*frY) );
  end;
end;

procedure affiche_pied_Vertical9G(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=90;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+60)*frX),y+round((y1+7)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    LineTo( x+round((x1+60)*frX),y+round((y1+8)*frY) );
    
  end;
end;

// Dessine un feu dans le canvas en x,y , dont l'adresse se trouve à la cellule x,y
procedure dessin_feu(CanvasDest : Tcanvas;x,y : integer );
var  x0,y0,xp,yp,orientation,adresse,aspect,TailleX,TailleY : integer;
     ImageFeu : Timage;
     frX,frY : real;
begin
  xp:=(x-1)*LargeurCell;
  yp:=(y-1)*HauteurCell;

  Adresse:=TCO[x,y].Adresse;

  Orientation:=TCO[x,y].FeuOriente;
  if Orientation=0 then Orientation:=1;  // cas d'un feu non encore renseigné

  aspect:=TCO[x,y].aspect;
  if aspect=0 then aspect:=9;
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

  // réduction variable en fonction de la taille des cellules. 50 est le Zoom Maxi
  calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);

  if orientation=3 then
  begin
    x0:=0;y0:=0;
    x0:=x0+xp;y0:=y0+yp;
    tco[x,y].x:=x0;
    tco[x,y].y:=y0;
  end;

  // décalage en X pour mettre la tete du feu alignée sur le bord droit de la cellule pour les feux tournés à 90G
  if orientation=2 then
  begin
    if aspect=9 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=7 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY);end;
    if aspect=5 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY); end;
    if aspect=4 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY); end;
    if aspect=3 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY); end;
    if aspect=2 then begin x0:=round(10*frX); y0:=HauteurCell-round(tailleX*frY); end;
    x0:=x0+xp;y0:=y0+yp;
    tco[x,y].x:=x0;
    tco[x,y].y:=y0;
  end;

  // décalage en X pour mettre rapprocher le feu du le bord droit de la cellule pour les feux verticaux
  if orientation=1 then
  begin
    if aspect=9 then begin x0:=0; y0:=0; end;
    if aspect=7 then begin x0:=0; y0:=0; end;
    if aspect=5 then begin x0:=round(25*frX); y0:=HauteurCell-round(tailleY*frY); end;
    if aspect=4 then begin x0:=round(25*frX); y0:=HauteurCell-round(tailleY*frY); end;
    if aspect=3 then begin x0:=round(25*frX); y0:=HauteurCell-round(tailleY*frY); end;
    if aspect=2 then begin x0:=round(25*frX); y0:=HauteurCell-round(tailleY*frY); end;
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
    if aspect=9 then affiche_pied_Vertical9G(x0,y0,frX,frY);
    if aspect=7 then affiche_pied_Vertical7G(x0,y0,frX,frY);
    if aspect=5 then affiche_pied_Vertical5G(x0,y0,frX,frY);
    if aspect=4 then affiche_pied_Vertical4G(x0,y0,frX,frY);
    if aspect=3 then affiche_pied_Vertical3G(x0,y0,frX,frY);
    if aspect=2 then affiche_pied_Vertical2G(x0,y0,frX,frY);
  end;

  // affichage du feu et du pieds - orientation 90°G
  if Orientation=2 then
  begin
    Feu_90G(ImageFeu,x0,y0,frX,frY); // ici on passe l'origine du feu
    // dessiner le pied
    case aspect of
    9 : affiche_pied9G_90G(x0,y0,frX,frY);
    7 : affiche_pied7G_90G(x0,y0,frX,frY);
    5 : affiche_pied5G_90G(x0,y0,frX,frY);
    4 : affiche_pied4G_90G(x0,y0,frX,frY);
    3 : affiche_pied3G_90G(x0,y0,frX,frY);
    2 : affiche_pied2G_90G(x0,y0,frX,frY);
    end;

  end;

  // affichage du feu et du pied - orientation 90°D
  if Orientation=3 then
  begin
    Feu_90D(ImageFeu,x0,y0,frX,frY);
    // dessiner le pied
    case aspect of
    9 : affiche_pied9G_90D(x0,y0,frX,frY);
    7 : affiche_pied7G_90D(x0,y0,frX,frY);
    5 : affiche_pied5G_90D(x0,y0,frX,frY);
    4 : affiche_pied4G_90D(x0,y0,frX,frY);
    3 : affiche_pied3G_90D(x0,y0,frX,frY);
    2 : affiche_pied2G_90D(x0,y0,frX,frY);
    end;
  end;

  // allumage des feux du signal -----------------
  dessine_feu_mx(canvasDest,x0,y0,frX,frY,adresse,orientation);
end;

procedure TFormTCO.Efface_Cellule(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
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

// affiche la cellule x et y en cases
procedure TformTCO.affiche_cellule(x,y : integer);
var repr,p,Xorg,Yorg,xt,yt,mode,adresse,Bimage,aspect,oriente,pos : integer;
    Bt : TEquipement;
    s : string;
begin
  PcanvasTCO.pen.Mode:=PmCopy;
  adresse:=tco[x,y].Adresse;
  bt:=tco[x,y].Btype;
  BImage:=tco[x,y].BImage;
  mode:=tco[x,y].mode;
  repr:=tco[x,y].repr;

  // récupérer la position de l'aiguillage
  if (bImage>=2)  then         //?????     and (btype<=15)
  begin
    if Adresse<>0 then pos:=Aiguillage[Index_Aig(adresse)].position
    else pos:=const_inconnu;
    if TCO[x,y].inverse then
    begin
      p:=const_inconnu;
      if pos=const_devie then p:=const_droit;
      if pos=const_droit then p:=const_devie;
      pos:=p;
    end;

  end;
  Xorg:=(x-1)*LargeurCell;
  Yorg:=(y-1)*HauteurCell;

  // ------------- affichage de l'adresse ------------------
  s:=IntToSTR(adresse);

 // pourquoi ? ? if y>1 then if (tco[x,y-1].Bimage=30) and (FeuTCO[i].FeuOriente=1) then exit;

  // affiche d'abord l'icone de la cellule et colore la voie si zone ou détecteur actionnée selon valeur mode
  case Bimage of
    //  0 : efface_cellule(PCanvasTCO,x,y,Clyellow,Mode);     &&&&&&&&&
      1 : dessin_voie(PCanvasTCO,X,Y,mode);
      2 : dessin_AigG_PD(PCanvasTCO,X,Y,mode,pos);
      3 : dessin_AigPG_AG(PCanvasTCO,X,Y,mode,pos);
      4 : dessin_AigD_PG(PCanvasTCO,X,Y,Mode,pos);
      5 : dessin_AigPD_AD(PCanvasTCO,X,Y,Mode,pos);
      6 : dessin_SupG(PCanvasTCO,X,Y,Mode);
      7 : dessin_SupD(PCanvasTCO,X,Y,Mode);
      8 : dessin_infD(PCanvasTCO,X,Y,Mode);
      9 : dessin_infG(PCanvasTCO,X,Y,mode);
     10 : dessin_Diag1(PCanvasTCO,X,Y,mode);
     11 : dessin_Diag2(PCanvasTCO,X,Y,mode);
     12 : dessin_Aig45PG_AG(PCanvasTCO,X,Y,mode,pos);
     13 : dessin_Aig45PD_AD(PCanvasTCO,X,Y,mode,pos);
     14 : dessin_Aig45PD_AG(PCanvasTCO,X,Y,mode,pos);
     15 : dessin_Aig45PG_AD(PCanvasTCO,X,Y,mode,pos);
     16 : dessin_16(PCanvasTCO,X,Y,mode);
     17 : dessin_17(PCanvasTCO,X,Y,mode);
     18 : dessin_18(PCanvasTCO,X,Y,mode);
     19 : dessin_19(PCanvasTCO,X,Y,mode);
     20 : dessin_20(PCanvasTCO,X,Y,mode);
     21 : dessin_21(PCanvasTCO,X,Y,mode);
     22 : dessin_22(PCanvasTCO,X,Y,mode);
     30 : dessin_feu(PCanvasTCO,X,Y);
  end;

  PCanvasTCO.font.Size:=(LargeurCell div 10)+4  ;
  //Affiche(intToSTR( (LargeurCell div 30)+6),clyellow);

  // affiche le texte des aiguillages
  if ((BImage=2) or (BImage=3) or (BImage=4) or (BImage=5) or (BImage=12) or (BImage=13) or (BImage=14) or (BImage=15) or (BImage=21) or (BImage=22)) and (adresse<>0) then
  begin
    if Bt<>tjs then s:='A'+s else s:='A'+s+'B';
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clYellow;
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
      Font.Color:=clWhite;
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

  if ((Bimage=10) or (Bimage=20))  and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clWhite;
      TextOut(xOrg+round(2*frXGlob),yOrg+round(2*fryGlob),s);
      //exit;
    end;
  end;

  if (Bimage=11) and (adresse<>0) then
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clWhite;
      TextOut(xOrg+round(28*frXGlob),yOrg+round(2*fryGlob),s);
      //exit;
    end;  
  end;

  // adresse des signaux
  if (BImage=30) and (adresse<>0) then
  begin
    aspect:=TCO[x,y].Aspect;
    oriente:=TCO[x,y].FeuOriente;
    xt:=0;yt:=0;
    if (aspect=9) and (Oriente=1) then begin xt:=LargeurCell-round(25*frXGlob);yt:=2*HauteurCell-round(25*fryGlob);end;
    if (aspect=9) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(17*frYGlob);end;    // orientation G
    if (aspect=9) and (Oriente=3) then begin xt:=LargeurCell+2;yt:=1;end;
    if (aspect=7) and (Oriente=1) then begin xt:=LargeurCell-round(25*frXGlob);yt:=2*HauteurCell-round(25*fryGlob);;end;
    if (aspect=7) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(15*frYGlob);end;
    if (aspect=7) and (Oriente=3) then begin xt:=LargeurCell+2;yt:=1;end;
    if (aspect=5) and (Oriente=1) then begin xt:=1;yt:=1;end;
    if (aspect=5) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=round(2*frYGlob);end;
    if (aspect=5) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(22*frYGlob);end;
    if (aspect=4) and (Oriente=1) then begin xt:=1;yt:=1;end;
    if (aspect=4) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=round(2*frYGlob);end;
    if (aspect=4) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(22*frYGlob);end;
    if (aspect=3) and (Oriente=1) then begin xt:=1;yt:=1;end;
    if (aspect=3) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=round(2*frYGlob);end;
    if (aspect=3) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(22*frYGlob);end;
    if (aspect=2) and (Oriente=1) then begin xt:=1;yt:=1;end;   // orientation V
    if (aspect=2) and (Oriente=2) then begin xt:=round(10*frXGlob);yt:=round(2*frYGlob);end;  // orientation G
    if (aspect=2) and (Oriente=3) then begin xt:=round(10*frXGlob);yt:=HauteurCell-round(22*frYGlob);end;  // orientation D
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clLime;
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
//    FillRect(r);
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

// affiche le tco suivant le tableau TCO
procedure TformTCO.Affiche_TCO ;
var x,y,x0,y0,DimX,DimY,repr,yt : integer;
    s : string;
    r : Trect;
begin
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
    Brush.Color:=clWhite;
    Pen.width:=1;
    r:=rect(0,0,ImageTCO.Width,ImageTCO.height);
    FillRect(r);
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

  PCanvasTCO.Font.Size:=8;
  //afficher les cellules des feux et les textes pour que les pieds recouvrent le reste et afficher les textes
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage=30 then
        begin
          affiche_cellule(x,y);
        end;
        s:=Tco[x,y].Texte;
        if s<>'' then
        begin
          x0:=(x-1)*Largeurcell;
          y0:=(y-1)*hauteurcell;
          //PCanvasTCO.Brush.Style:=bsSolid;
          PCanvasTCO.Brush.Color:=fond;
          //PCanvasTCO.pen.color:=clyellow;
          PcanvasTCO.Font.Color:=clTexte;
          repr:=tco[x,y].repr;
          case repr of
            1 : yt:=(HauteurCell div 2)-round(7*fryGlob);   // milieu
            2 : yt:=1;  // haut
            3 : yt:=HauteurCell-round(17*frYGlob);   // bas
          end;
          PcanvasTCO.Textout(x0+2,y0+yt,s);
        end;
      end;

  // afficher la grille
//  grille;

  if entoure then
  begin
    Entoure_cell(Xentoure,Yentoure);
  end;

end;


procedure TFormTCO.FormCreate(Sender: TObject);
begin
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
  DoubleBuffered:=true;
  comborepr.Enabled:=false;
  controlStyle:=controlStyle+[csOpaque];
end;

// clic gauche sur image
procedure TFormTCO.ImageTCOClick(Sender: TObject);
var  Position: TPoint;
     Bimage : integer;
     s : string;
begin
  //Affiche('1 Clic',clyellow);
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

  if (Bimage=1) or (Bimage=0) then
  begin
    s:=Tco[XClicCell,YClicCell].Texte;
    EditTexte.Text:=s;
    EditTexte.Visible:=true
  end
  else EditTexte.Visible:=false;

  if (Bimage=1) or (Bimage=0) then ComboRepr.Enabled:=true else comboRepr.Enabled:=false;

  LabelX.caption:=IntToSTR(XclicCell);
  LabelY.caption:=IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCellInserer,YClicCellInserer].BType));
  EdittypeImage.Text:=IntToSTR(BImage);
  ComboRepr.ItemIndex:=tco[XClicCell,yClicCell].repr;

  if not(selectionaffichee) then  _entoure_cell_clic;
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


// allume ou éteint (mode=0 ou 1) la voie, zone de det1 à det2 sur le TCO
procedure zone_TCO(det1,det2,mode : integer);
var i,x,y,ancienY,ancien2Y,ancienX,ancien2X,Xdet1,Ydet1,Xdet2,Ydet2,Bimage,adresse,
    pos,pos2 : integer;
    memtrouve : boolean;
    s : string;
begin
  // trouver le détecteur det1
  trouve_det(det1,Xdet1,Ydet1);
  if (Xdet1=0) or (Ydet1=0) then exit;

  trouve_det(det2,Xdet2,Ydet2);
  if (Xdet2=0) or (Ydet2=0) then exit;

  // inverser coordonnées des détecteurs si à l'envers en X
  if xDet2<xDet1 then
  begin
    x:=Xdet2;Xdet2:=Xdet1;Xdet1:=x;
    x:=Ydet2;Ydet2:=Ydet1;Ydet1:=x;
    x:=det2;det2:=det1;det1:=x;
  end;

  //Affiche('trouvé '+intToSTR(det1)+' en '+IntToSTR(xDet1)+'/'+intToSTR(ydet1),clyellow);
  //Affiche('trouvé '+intToSTR(det2)+' en '+IntToSTR(xDet2)+'/'+intToSTR(ydet2),clyellow);

  // Aller de det1 à det2 vers le sens X croissant du TCO
  ancienX:=Xdet2;ancienY:=yDet2-Ydet1;
  if ydet2<ydet1 then ancieny:=ydet1+1 else ancieny:=ydet1-1;
  if xdet2<xdet1 then ancienx:=xdet1+1 else ancienx:=xdet1-1;

  x:=xDet1;y:=Ydet1;
  i:=0; memtrouve:=false;

  repeat
    ancien2X:=ancienX;
    ancienX:=X;
    ancien2Y:=ancienY;
    ancienY:=y;
    //Affiche('X='+intToSTR(x)+' Y='+IntToSTR(Y),clyellow);

    // Affiche la cellule en fonction du mode
    Tco[x,y].mode:=mode;
    FormTCO.Affiche_cellule(x,y);
    adresse:=TCO[x,y].Adresse ;
    Bimage:=TCO[x,y].Bimage;

    // vers case suivante: trouver le trajet pour rejoindre det1 à det2
    case Bimage of
    // voie
    1 : if ancien2X<x then inc(x) else dec(x);
    // aiguillage pris en talon - pris en pointe
    2 : if ancien2X<x then inc(x) else
          begin
            pos:=aiguillage[Index_Aig(adresse)].position;
            if (pos=const_devie) then begin dec(x);inc(y); end;
            if (pos=const_droit) then dec(x);
            if pos=9 then exit;
          end;
    // aiguillage en pointe dévié: changer xy
    3 : begin
          if ancien2X<x then
          begin
            pos:=aiguillage[Index_Aig(adresse)].position;
            if (pos=const_devie) then begin inc(x);dec(y); end;
            if (pos=const_droit) then inc(x);
            if pos=9 then exit;
          end
          else dec(x);
        end;
    // aiguillage en pointe
    4 : begin
          if ancien2X<x then
          begin
            pos:=aiguillage[Index_Aig(adresse)].position;
            if (pos=const_devie) then begin inc(x);inc(y); end;
            if (pos=const_droit) then inc(x);
            if pos=9 then exit;
          end
          else dec(x);
        end;
      // aiguillage pris en talon - pris en pointe
    5 : if ancien2X<x then inc(x) else
        begin
          pos:=aiguillage[Index_Aig(adresse)].position;
          if (pos=const_devie) then begin dec(x);dec(y); end;
          if (pos=const_droit) then dec(x);
          if pos=9 then exit;
        end;
    // tourner à droite
    6 : if ancien2X<x then inc(x)
        else begin dec(x);dec(y);end;

    // tourner vers le haut
    7 :  if ancien2x<x then begin inc(x);dec(y); end else dec(x);
    // tourner vers le bas
    8 : if ancien2X<x then begin inc(x);inc(y); end else dec(x);
    // tourner
    9 : if ancien2X<x then inc(x) else begin dec(x);inc(y);end;
    // diagonale /
    10 : if ancien2X<x then begin inc(x);dec(y);end else begin dec(x);inc(y);end;
    // diagonale \
    11 : if ancien2X<x then begin inc(x);inc(y);end else begin dec(x);dec(y);end;
    // aiguillage en pointe
    12 : if ancien2X<x then
         begin
           pos:=aiguillage[Index_Aig(adresse)].position;
           if (pos=const_devie) then inc(x);
           if (pos=const_droit) then begin inc(x);inc(y);end;
           if pos=9 then exit;
         end
         else begin dec(x);dec(y);end;
    // aiguillage en talon
    13 :  if ancien2X<x then begin inc(x);dec(y); end
          else
          begin
            pos:=aiguillage[Index_Aig(adresse)].position;
            if (pos=const_devie) then dec(x);
            if (pos=const_droit) then begin dec(x);inc(y);end;
            if pos=9 then exit;
          end;
    // aiguillage en talon
    14 : if ancien2X<x then
         begin
           inc(x);inc(y);
         end else
         begin
           pos:=aiguillage[Index_Aig(adresse)].position;
           if (pos=const_devie) then dec(x);
           if (pos=const_droit) then begin dec(x);dec(y);end;
           if pos=9 then exit;
         end;
    // aiguillage en pointe
    15 : if ancien2X<x then
         begin
           pos:=aiguillage[Index_Aig(adresse)].position;
           if (pos=const_devie) then inc(x);
           if (pos=const_droit) then begin inc(x);dec(y);end;
           if pos=9 then exit;
         end
         else begin dec(x);inc(y);end;
    16 : if ancien2X<x then inc(y) else begin dec(x);dec(y);end;
    17 : if ancien2Y<y then begin inc(y);end else begin inc(x);dec(y);end;
    18 : if Ancien2X<x then dec(y) else begin inc(y);dec(x);end;
    19 : if ancien2Y<y then begin inc(x);inc(y);end else dec(y);
    20 : if ancien2Y<y then inc(y) else dec(y);
    21 : begin
           // tjd ou tjs
           if adresse<>0 then
           begin
             //pos:=aiguillage[Index_Aig(adresse].position;
             //pos2:=aiguillage[Index_Aig(aiguillage[Index_Aig(adresse].Apointe].position; // 2eme adresse de la TJD
             if (pos=const_droit) and (pos2=const_droit) then
             begin
               inc(x);
             end;
             if (pos=const_devie) and (pos2=const_devie) then
             begin
               inc(x);dec(y);
             end;
             if (pos=const_droit) and (pos2=const_devie) then
             begin
               inc(x);
             end;
             if (pos=const_devie) and (pos2=const_droit) then
             begin
               inc(x);dec(y);
             end;
           end
           else
           // croisement
           begin
             if ancien2Y=y then begin inc(x);end else begin inc(x);dec(y);end;
           end;
         end;
    // TJD ou croisement
    22 : begin
           // tjd ou tjs
           if adresse<>0 then
           begin
             pos:=aiguillage[Index_Aig(adresse)].position;
             //pos2:=aiguillage[Index_Aig(aiguillage[adresse].Apointe].position; // 2eme adresse de la TJD
             if (pos=const_droit) and (pos2=const_droit) then
             begin
               inc(x);inc(y);
             end;
             if (pos=const_devie) and (pos2=const_devie) then
             begin
               inc(x);
             end;
             if (pos=const_droit) and (pos2=const_devie) then
             begin
               inc(x);inc(y);
             end;
             if (pos=const_devie) and (pos2=const_droit) then
             begin
               inc(x);
             end;
           end
           else
           // croisement
           begin
             if ancien2Y=y then begin inc(x);end else begin inc(x);inc(y);end;
           end;
        end;
    else exit;
    end;
    inc(i);
    if adresse=det2 then memTrouve:=true;
  until (x=1) or (x=NbreCellX) or (y=NbreCellY) or ((adresse<>det2) and memTrouve) or (i>NbCellulesTCO);
  //Affiche(intToSTR(x),clLime);
  if i>NbCellulesTCO then
  begin
    s:='Erreur 1000 : dépassement d''itérations TCO: '+IntToSTR(det1)+' - '+IntToSTR(det2);
    Affiche(s,clred); AfficheDebug(s,clred);
  end;
end;

procedure TFormTCO.FormActivate(Sender: TObject);
begin
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

    PScrollBoxTCO:=FormTCO.ScrollBox;

    lire_fichier_tco;

    NbCellulesTCO:=NbreCellX*NbreCellY;

    calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);
    // dessiner les icônes
    dessin_AigPD_AD(ImagePalette5.Canvas,1,1,0,9);
    dessin_AigG_PD(ImagePalette2.Canvas,1,1,0,9);
    dessin_AigPG_AG(ImagePalette3.Canvas,1,1,0,9);
    dessin_AigD_PG(ImagePalette4.Canvas,1,1,0,9);
    dessin_voie(ImagePalette1.canvas,1,1,0);
    dessin_SupG(ImagePalette6.canvas,1,1,0);
    dessin_SupD(ImagePalette7.canvas,1,1,0);
    dessin_InfD(ImagePalette8.canvas,1,1,0);
    dessin_infG(ImagePalette9.canvas,1,1,0);
    dessin_Diag1(ImagePalette10.Canvas,1,1,0);
    dessin_Diag2(ImagePalette11.Canvas,1,1,0);
    dessin_Aig45PG_AG(ImagePalette12.Canvas,1,1,0,9);
    dessin_Aig45PD_AD(ImagePalette13.Canvas,1,1,0,9);
    dessin_Aig45PD_AG(ImagePalette14.Canvas,1,1,0,9);
    dessin_Aig45PG_AD(ImagePalette15.Canvas,1,1,0,9);
    dessin_16(ImagePalette16.canvas,1,1,0);
    dessin_17(ImagePalette17.canvas,1,1,0);
    dessin_18(ImagePalette18.canvas,1,1,0);
    dessin_19(ImagePalette19.canvas,1,1,0);
    dessin_20(ImagePalette20.canvas,1,1,0);
    dessin_21(ImagePalette21.canvas,1,1,0);
    dessin_22(ImagePalette22.canvas,1,1,0);

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
  end;
  TrackBarZoom.Position:=ZoomMax-LargeurCell+20;
end;

// evt qui se produit quand on clic droit dans l'image
procedure TFormTCO.ImageTCOContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var  Position: TPoint;

begin

  // efface le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);

  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;

  _entoure_cell_clic;

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
  //Entoure_cell(XclicCell,YclicCell);
  case Key of
     VK_right : if XClicCell<NbreCellX then inc(XClicCell);
     VK_left  : if XClicCell>1 then dec(XClicCell);
     VK_down  : if YClicCell<NbreCellY then inc(YClicCell);
     VK_up    : if YClicCell>1 then dec(YClicCell);
  end;
  LabelX.caption:=IntToSTR(XClicCell);  
  LabelY.caption:=IntToSTR(YClicCell);
  //Entoure_cell(XclicCell,YclicCell);   
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].BType));
end;

procedure TFormTCO.Elmentdroit1Click(Sender: TObject);
begin
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_voie(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCellInserer,YClicCellInserer].BType));
end;

procedure TFormTCO.Courbegaucheversdroite1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_infG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
end;

procedure TFormTCO.Courbedroiteversgauche1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_infD(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position); 
end;


procedure TFormTCO.CourbeSupD1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_SupD(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
end;

procedure TFormTCO.CourbeSupG1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_SupG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,0);
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
  dessin_AigPD_AD(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  tco[XClicCell,YClicCell].BType:=aig;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=5;  // image 5
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=aig;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=2;  // image 2
  dessin_AigG_PD(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigPG_AG(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  tco[XClicCell,YClicCell].BType:=aig;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=3;  // image 3
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_AigD_PG(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  tco[XClicCell,YClicCell].BType:=aig;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=4;  // image 4
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=voie;  // voie (3)
  tco[XClicCell,YClicCell].BImage:=1;  // image 1
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR(tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_SupG(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=6;  // image 6
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_SupD(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=7;  // image 7
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_infD(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=8;  // image 8
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_infG(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=9;  // image 9
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_Aig45PG_AG(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=12;  // image 12
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_Aig45PD_AD(ImageTCO.Canvas,XClicCell,YClicCell,0,9);      
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=13;  // image 13
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_Aig45PD_AG(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=14;  // image 14
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  Dessin_Aig45PG_AD(ImageTCO.Canvas,XClicCell,YClicCell,0,9);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=15;  // image 15
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=16;  // image 16
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=17;  // image 17
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=18;  // image 18
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=19;  // image 19
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=20;  // image 20
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=21;  
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=22;  
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
    if tco[XclicCell,YClicCell].Bimage=30 then
    begin
      // si c'est un feu, le supprimer dans le tableau FeuTCO
      
    //  i:=tco[XclicCell,YClicCell].indexFeuTCO;
    //  affiche('Index='+IntToSTR(i),clyellow);
    //  for j:=i+1 to NbfeuTCO do 
    //  begin
    //    FeuTCO[j-1]:=FeuTco[j];
    //    Affiche(IntToSTR(j-1)+'<-'+IntTostr(j),clyellow);
    //  end;  
    //  dec(NbFeuTCO); 

      // mettre à jour l'index dans le tableau des feux
      {
      for i:=1 to NbfeuTCO do
      begin
        Adresse:=feuTCO[i].Adresse;
        j:=Index_feu(adresse);
        feux[j].indexTCO:=i;
      end; 

      // et remettre à jour les index du tabloTCO
      for y:=1 to NbreCellY do
      for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage=30 then
        begin
          Adresse:=TCO[x,y].adresse;
          j:=Index_feu(adresse);
          TCO[x,y].IndexFeuTCO:=feux[j].indexTCO;
        end;  
      end;
      if NbfeuTCO>2 then dec(NbfeuTCO); 
     } 
    end;
   
    tamponTCO[XclicCell,YclicCell]:=tco[XclicCell,YclicCell]; // pour pouvoir faire annuler couper
    TamponTCO_org.x1:=XclicCell;TamponTCO_org.y1:=YclicCell;
    TamponTCO_org.x2:=XclicCell;TamponTCO_org.y2:=YclicCell;
   
    tco[XclicCell,YClicCell].BType:=rien;
    tco[XclicCell,YClicCell].Adresse:=0;
    tco[XclicCell,YClicCell].Bimage:=0;
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
      tco[x,y].BType:=rien;
      tco[x,y].Adresse:=0;
      tco[x,y].BImage:=0;
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
      xMiniSel:=99999;yMiniSel:=99999;
      xMaxiSel:=0;yMaxiSel:=0;
      sourisclic:=true;
      if SelectionAffichee then
      begin
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
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCellInserer,YClicCellInserer].BType));
  end; 
end;

procedure TFormTCO.ImageTCOMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
var  Position: TPoint;
     r : Trect;
     x0,y0,XSel1,YSel1,XSel2,YSel2 : integer;
begin
  SourisX.Caption:=IntToSTR(x);
  SourisY.Caption:=IntToSTR(y);
  
  if not(sourisclic) then exit;

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
  if entoure then begin Entoure_cell(Xentoure,Yentoure);entoure:=false;end; // efface 
end;

procedure TFormTCO.ImageTCOMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Affiche('MouseUp',clyellow);
  sourisclic:=false;
  
end;


procedure TFormTCO.ButtonRedessineClick(Sender: TObject);
begin
  Affiche_TCO;
end;

// changement de l'adresse d'un élément
procedure TFormTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur,index,aspect : integer;
begin
  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then
  begin
    EditAdrElement.text:=intToSTR(tco[XClicCell,YClicCell].Adresse);
    exit;
  end;

  tco[XClicCell,YClicCell].Adresse:=Adr;
  //Affiche('Chgt adresse',clyellow);

  if tco[XClicCell,YClicCell].BImage=30 then
  begin
    index:=Index_feu(adr);
    if index=0 then exit
    else 
      begin
       //Affiche('Feu '+intToSTR(Adr),clyellow);
       Aspect:=Feux[index].Aspect;
       tco[XClicCell,YClicCell].aspect:=aspect;
       affiche_tco;
     end;
  end;  
end;


procedure TFormTCO.EditAdrElementKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then 
  efface_entoure;
  affiche_cellule(XClicCell,YClicCell);
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
    case Bimage of
    // aiguillages
    2,3,4,5,12,13,14,15 : tco[XClicCell,YClicCell].Btype:=aig;
    // détecteur ou voie
    1,10,11,20 : tco[XClicCell,YClicCell].Btype:=voie;
    else tco[XClicCell,YClicCell].Btype:=rien;
    end;
    
    EditTypeElement.text:=intToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
    affiche_cellule(XClicCell,YClicCell);
  end;
end;

procedure TFormTCO.Maj_TCO(Adresse : integer);
var x,y,xOrg,yOrg : integer;
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
  dessin_Diag1(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=10;  // image 10
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[XClicCell,YClicCell].FeuOriente:=1; 
  entoure_cell_grille(XClicCell,YClicCell);  
  _entoure_cell_clic; 
  tco[XClicCell,YClicCell].x:=0;  //  XClicCell;  //??
  tco[XClicCell,YClicCell].y:=0;  //  YClicCell;  //??
   
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  dessin_Diag2(ImageTCO.Canvas,XClicCell,YClicCell,0);
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=11;  
  tco[XClicCell,YClicCell].Adresse:=0;  
  entoure_cell_grille(XClicCell,YClicCell); 
  _entoure_cell_clic;
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  tco[XClicCell,YClicCell].BType:=rien;  // rien
  tco[XClicCell,YClicCell].BImage:=30;
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[XClicCell,YClicCell].FeuOriente:=1;
  tco[XClicCell,YClicCell].Aspect:=9;
  tco[XClicCell,YClicCell].x:=0;
  tco[XClicCell,YClicCell].y:=0;

  // ne pas convertir l'adresse sinon evt changement du composant et on écrase l'aspect EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR(BtypeToNum(tco[XClicCell,YClicCell].Btype));
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
  aspect:=tco[XClicCell,YClicCell].aspect;
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
  aspect:=tco[XClicCell,YClicCell].aspect;
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
  LargeurCell:=ZoomMax-TrackBarZoom.Position+20;
  hauteurCell:=LargeurCell;
  Affiche_TCO;
  SelectionAffichee:=false;
end;


// interdire la fermeture de la fenêtre tco
procedure TFormTCO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=tCloseAction(caNone);
end;

procedure TFormTCO.EditTexteChange(Sender: TObject);
var x0,y0 : integer;
begin
  x0:=(XClicCell-1)*LargeurCell;
  y0:=(YClicCell-1)*HauteurCell;
  PCanvasTCO.Brush.Color:=fond;
  PcanvasTCO.Font.Color:=clTexte;  
  PCanvasTCO.TextOut(x0+2,y0+2,EditTexte.Text);
  Tco[XClicCell,YClicCell].Texte:=EditTexte.Text;
  TCO_modifie:=true;
end;

procedure TFormTCO.ButtonSimuClick(Sender: TObject);
begin
  aiguillage[Index_Aig(28)].position:=const_droit; 
  
  zone_TCO(548,580,1);
  zone_TCO(561,514,1);
  zone_TCO(530,520,1);
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
end;

procedure TFormTCO.ButtonAfficheBandeauClick(Sender: TObject);
begin
  Panel1.Show;
  ButtonAfficheBandeau.visible:=false;
  ScrollBox.Height:=ClientHeight-Panel1.Height-40;
end;

procedure TFormTCO.FormResize(Sender: TObject);
begin
  ScrollBox.Height:=ClientHeight-Panel1.Height-40;
end;


procedure TFormTCO.ImageTCODblClick(Sender: TObject);
var Bimage,Adresse,i : integer;
    tjdC : boolean;
    Msgdlg: Tform;
    Result : TModalResult;
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
      EtatSignalCplx[0]:=EtatSignalCplx[Adresse];
      LabelNbFeux.Visible:=False;
      EditNbreFeux.Visible:=false;
      GroupBox1.Visible:=true;
      GroupBox2.Visible:=true;
      efface_entoure;SelectionAffichee:=false;
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


procedure TFormTCO.Colorer1Click(Sender: TObject);
begin
  //BImage:=TCO[XClicCell,YClicCell].Bimage;
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


begin


end.
