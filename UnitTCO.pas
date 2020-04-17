unit UnitTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote,
  ComCtrls ;

type
  TFormTCO = class(TForm)
    LabelX: TLabel;
    Label2: TLabel;
    LabelY: TLabel;
    PopupMenu1: TPopupMenu;
    MenuCouper: TMenuItem;
    N1: TMenuItem;
    Label1: TLabel;
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
    ImagePaletteDroit: TImage;
    ImageSupG: TImage;
    ImageSupD: TImage;
    ImageInfD: TImage;
    ImageInfG: TImage;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ImagePalette3: TImage;
    ImagePalette4: TImage;
    Label8: TLabel;
    Label9: TLabel;
    ImageDiag1: TImage;
    Label16: TLabel;
    ImageDiag2: TImage;
    Label17: TLabel;
    ImageFeu: TImage;
    Label18: TLabel;
    ButtonSauveTCO: TButton;
    ButtonRedessine: TButton;
    Button1: TButton;
    Button2: TButton;
    Label19: TLabel;
    ButtonConfigTCO: TButton;
    Annulercouper: TMenuItem;
    N5: TMenuItem;
    ImageAig45PG_AG: TImage;
    Label20: TLabel;
    Label3: TLabel;
    ImageAig45PD_AD: TImage;
    Label21: TLabel;
    ImageAig45PD_AG: TImage;
    Label22: TLabel;
    ImageAig45PG_AD: TImage;
    Label23: TLabel;
    EditTexte: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ImageTCOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure dessin_AigPG_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
    procedure dessin_Aig45PG_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode; position : integer);
    procedure dessin_Aig45PD_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode; position : integer);
    procedure dessin_Aig45PD_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
    procedure dessin_Aig45PG_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
    procedure dessin_AigPD_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
    procedure dessin_Diag1(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_Diag2(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_infG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_infD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure Entoure_cell(x,y : integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//    procedure Aiguillagegauchepointedroite1Click(Sender: TObject);
    procedure dessin_AigG_PD(canvas : Tcanvas;X,Y : integer; couleur : Tcolor;Mode : TPenMode;position : integer);
    procedure Elmentdroit1Click(Sender: TObject);
    procedure dessin_voie(Canvas : Tcanvas;x,y : integer;couleur : TColor;Mode : TPenMode);
    procedure Courbegaucheversdroite1Click(Sender: TObject);
    procedure Courbedroiteversgauche1Click(Sender: TObject);
//    procedure Aiguillagedroitpointegauche1Click(Sender: TObject);
    procedure dessin_AigD_PG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode;position : integer );
    procedure CourbeSupD1Click(Sender: TObject);
    procedure dessin_SupD(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
    procedure CourbeSupG1Click(Sender: TObject);
    procedure dessin_SupG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
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
    procedure ImagePaletteDroitEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImagePaletteDroitMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageSupGEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageSupGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSupDEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageSupDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageInfDEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageInfDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageInfGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageInfGEndDrag(Sender, Target: TObject; X, Y: Integer);
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
    procedure affiche_cellule(x,y : integer;mode : TPenMode);
    procedure grille;
    procedure EditAdrElementChange(Sender: TObject);
    procedure EditTypeImageKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Maj_TCO(Adresse : integer);
    procedure ImageDiag1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageDiag1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageDiag2EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageDiag2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonConfigTCOClick(Sender: TObject);
    procedure ImageFeuEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ImageFeuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Tourner90GClick(Sender: TObject);
    procedure Tourner90DClick(Sender: TObject);
    procedure Pos_vertClick(Sender: TObject);
    procedure TrackBarZoomChange(Sender: TObject);
    procedure AnnulercouperClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageAig45PG_AGEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImageAig45PG_AGMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageAig45PD_ADEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImageAig45PD_ADMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageAig45PD_AGEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImageAig45PD_AGMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageAig45PG_ADEndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure ImageAig45PG_ADMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditTexteChange(Sender: TObject);
    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;



const
  clGrille=$404040;
  ZoomMax=50;
  MaxCellX=100;MaxCellY=50;

type  
  
  TTCO = array[1..MaxCellX] of array[1..MaxCellY] of record
               BType : integer ;      // 1= détecteur  2= aiguillage 3=bis 4=Buttoir 
               Adresse : integer ;    // adresse du détecteur ou de l'aiguillage ou du feu
               IndexFeu   : integer ;    // index du feu dans le tableau FeuTCO
               BImage : integer ;     // 0=rien 1=voie 2=aiguillage gauche gauche ... 30=feu
               Texte : string[30];
               //FeuAspect : integer;   // aspect du feu (2 feux...9 feux)
               //FeuOriente : integer ; // orientation du feu : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit
               PiedFeu : integer; // type de pied au feu
            end;
  TfeuTCO = array[1..50] of record
              Adresse : integer ; // adresse du feu;
              x,y     : integer ; // coordonnées pixels
              FeuOriente : integer;
              PiedFeu   : integer;
              Aspect    : integer;
              end;

  
var
  Fond,couleurAdresse : Tcolor;
  FormTCO: TFormTCO;
  Forminit,sourisclic,SelectionAffichee,TamponAffecte,entoure,Diffusion,TCO_modifie : boolean;
  HtImageTCO,LargImageTCO,XclicCell,YclicCell,XminiSel,YminiSel,XCoupe,Ycoupe,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel ,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer,Xentoure,Yentoure : integer;
  
  TamponTCO,tco : TTco ;
  TamponTCO_Org : record 
           x1,y1,x2,y2 : integer;
                  end;  
  FeuTCO : TFeuTCO;
  NbFeuTCO : integer;                
  rAncien : TRect;          
  PCanvasTCO : Tcanvas;
  PBitMapTCO : TBitMap;
  PScrollBoxTCO : TScrollBox;
  PImageTCO : Timage;
  PImageTemp : TImage;
  frXGlob,frYGlob : real;
  LargeurCell,HauteurCell,NbreCellX,NbreCellY : integer   ;

procedure calcul_reduction(Var frx,fry : real;DimDestX,DimDestY,DimOrgX,DimOrgY : integer);
procedure sauve_fichier_tco;
  
implementation

uses UnitConfigTCO;


{$R *.dfm}


procedure lire_fichier_tco;
var fichier : textfile;
    s : string;
    x,y,i,adresse,Aspect,valeur,erreur,FeuOriente,PiedFeu : integer;

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
  try
    assignFile(fichier,'tco.cfg');
    reset(fichier);
  except
    exit;
  end;

  x:=1;y:=1;NbreCellX:=0;NbreCellY:=0;NbFeuTCO:=0;
  // taille de la matrice
  s:=lit_ligne;
  Val(s,NbreCellX,erreur);
  delete(s,1,erreur);
  Val(s,NbreCellY,erreur);
  
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
        tco[x,y].BType:=valeur;
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

        // FeuOriente (pas encore stocké)
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),FeuOriente,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        delete(s,1,i);

        // PiedFeu (pas encore stocké)
        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),PiedFeu,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        delete(s,1,i);

        // si c'est un feu, remplir tableau feux
        if tco[x,y].Bimage=30 then
        begin
          inc(NbFeuTCO);
         // Affiche(intToSTR(tco[x,y].Adresse),clyellow);
          i:=index_feu(adresse);
          if i<>0 then 
          begin
            aspect:=Feux[i].aspect;
            // Affiche('Feu '+IntToSTR(Adresse)+' aspect='+intToSTR(aspect),clyellow);
            Feux[i].indexTCO:=NbFeuTCO;
            FeuTCO[NbFeuTCO].Aspect:=aspect;
          end;  
          FeuTCO[NbFeuTCO].Adresse:=adresse;
          FeuTCO[NbFeuTCO].FeuOriente:=FeuOriente;
          FeuTCO[NbFeuTCO].x:=x;
          FeuTCO[NbFeuTCO].y:=y;
          FeuTCO[NbFeuTCO].PiedFeu:=PiedFeu;  

          TCO[x,y].IndexFeu:=NbFeuTCO;
          TCO[x,y].PiedFeu:=PiedFeu;        
        end;
        
        i:=pos(')',s);
        if i<>1 then 
          tco[x,y].Texte:=copy(s,1,i-1) 
        else
          tco[x,y].Texte:='';
        delete(s,1,i);
        inc(x);

      until s='';
    end;
    inc(y);x:=1;
  end;
  closefile(fichier);
  Affiche('Dimensions du tco : '+intToSTR(NbreCellX)+'x'+intToSTR(NbreCellY)+' NbeFeuxTCO='+IntToSTR(NbFeuTCO),clyellow);
  
end;

procedure sauve_fichier_tco;
var fichier : textfile;
    s : string;
    x,y,i,erreur : integer;
begin
  AssignFile(fichier,'tco.cfg');
  rewrite(fichier);
  writeln(fichier,'/type(0=rien 1=voie/détecteur 2=aig 3=aigBis , adresse , image=1 à 10 ,orientation');
  writeln(fichier,'/ Taille de la matrice x,y');
  writeln(fichier,IntToSTR(NbreCellX)+','+intToSTR(NbreCellY));
  writeln(fichier,'/ Largeur et hauteur des cellules en pixels');
  writeln(fichier,'/ type,adresse,image,Orientation du feu, pied du feu');
  
  writeln(fichier,IntToSTR(LargeurCell)+','+intToSTR(HauteurCell));
  
  writeln(fichier,'/Dalle TCO');
  for y:=1 to NbreCellY do
  begin
    s:='';
    for x:=1 to NbreCellX do
    begin
      s:=s+'('+IntToSTR(TCO[x,y].BType)+','+Format('%.*d',[3,TCO[x,y].Adresse])+','+
           IntToSTR(TCO[x,y].BImage)+',';
           if TCO[x,y].BImage=30 then 
           begin
             i:=TCO[x,y].IndexFeu;
             s:=s+IntToSTR(FeuTCO[i].FeuOriente)+','+IntToSTR(TCO[x,y].PiedFeu)+',';
           end
           else s:=s+'0,0,';
      // texte
      s:=s+TCO[x,y].Texte+')';
    end;
    writeln(fichier,s);
  end;
  closefile(fichier);
  Affiche('TCO sauvegardé',clyellow);
end;


procedure TformTCO.grille;
var x,y : integer;
    r : Trect;
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
procedure TFormTCO.dessin_voie(Canvas : Tcanvas;x,y : integer;couleur : TColor;Mode : TPenMode);
var Adr, x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    // bande blanche
    if (x<=NbreCellX) and (y<=NbreCellY) then
    begin
      Adr:=TCO[x,y].Adresse;
      if Detecteur[Adr] then 
      begin
        Brush.Color:=clWhite;
        pen.color:=couleur;
        Pen.Mode:=Mode;
        jy1:=y0+(HauteurCell div 2)-round(6*frYGlob); // pos Y de la bande sup
        jy2:=y0+(HauteurCell div 2)+round(6*frYGlob); // pos Y de la bande inf
        r:=Rect(x0,jy1,x0+LargeurCell,jy2);
        FillRect(r);
        couleur:=clblue;
      end;
    end;
      
    Brush.Color:=couleur;
    pen.color:=couleur;
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);


  end;
end;

// élément 10
procedure TformTCO.dessin_Diag1(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
var Adr, x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    x1:=x0;y1:=y0+hauteurCell-round(3*FryGlob);
    x2:=x0+largeurCell-round(3*FrXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*FrYGlob);
    x4:=x0+round(4*FrXGlob); y4:=y0+hauteurCell;
    
    Brush.Color:=couleur;
    pen.color:=couleur;
  
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
  end;
end;  

// élément 11
procedure TformTCO.dessin_Diag2(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
var Adr, x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    x1:=x0+round(3*FrXGlob);y1:=y0;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*FrYGlob);
    x3:=x0+largeurCell-round(4*FrXGlob);y3:=y0+HauteurCell;
    x4:=x0;y4:=y0+round(4*frYGlob);
    
    Brush.Color:=couleur;
    pen.color:=couleur;
  
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
  end;
end;  

// courbe bas gauche vers droit  Elément 9 
procedure TFormTCO.dessin_infG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
var jy1,jy2,x0,y0,i,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.COlor:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=Mode;

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

// courbe: droit vers bas  -\  Element 8
procedure TFormTCO.dessin_infD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
var jy1,jy2,x0,y0,i,x1,y1,x2,y2,x3,y3,x4,y4 : integer;
    r : Trect;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.COlor:=Couleur;
    Pen.Mode:=Mode;
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


// Element 7
procedure TformTCO.dessin_SupD(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
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

    Brush.COlor:=Couleur;
    pen.color:=couleur;
    Pen.Mode:=Mode;
  
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2)+4,jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2)+round(2*frXGlob);y1:=jy1;
    x2:=x0+LargeurCell-round(2*frXGlob);y2:=y0;
    x3:=x0+LargeurCell;y3:=y0+round(4*frYGlob);
    x4:=x0+(LargeurCell div 2)+round(4*frXGlob);y4:=jy2-round(2*frYGlob);
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// coin supérieur gauche (Element 6)
procedure TformTCO.dessin_SupG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
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

    Brush.COlor:=Couleur;
    pen.color:=Couleur;
    Pen.Mode:=Mode;

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

// Element 15
procedure TFormTCO.dessin_Aig45PG_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
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

    x1:=x0;y1:=y0+hauteurCell-round(3*frYGlob);
    x2:=x0+largeurCell-round(3*frXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*frYGlob);
    x4:=x0+round(3*frYGlob);y4:=y0+hauteurCell;
    
    Brush.Color:=couleur;
    pen.color:=couleur;
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // aiguillage dévié
    if position=const_Devie then
    begin              
      x1:=x0+round(20*frXGlob);y1:=jy1-round(1*frYGlob); 
      x2:=x1+round(23*frxGlob);y2:=y1;
      x3:=x2;y3:=y2-round(3*frYGlob);
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
    // aiguillage droit
    if position=const_Droit then
    begin
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


// Element 14
procedure TFormTCO.dessin_Aig45PD_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
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

    x1:=x0+round(3*frXGlob); y1:=y0;
    x2:=x0+largeurCell; y2:=y0+HauteurCell-round(3*fryGlob);
    x3:=x0+largeurCell-round(4*frXGlob);y3:=y0+HauteurCell;
    x4:=x0; y4:=y0+round(4*frYGlob);
    
    Brush.Color:=couleur;
    pen.color:=couleur;
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
    FillRect(r);

    // aiguillage dévié
    if position=const_Devie then
    begin              
      x1:=x0+round(2*frXGlob);y1:=jy1-round(1*fryGlob); 
      x2:=x1+round(23*frxGlob);y2:=y1;
      x3:=x2;y3:=y2-round(3*fryGlob);
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
    // aiguillage droit
    if position=const_Droit then
    begin
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

// Elément 13
procedure TFormTCO.dessin_Aig45PD_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
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

    x1:=x0;y1:=y0+hauteurCell-round(3*frYGlob);
    x2:=x0+largeurCell-round(3*frXGlob);y2:=y0;
    x3:=x0+largeurCell;y3:=y0+round(4*FryGlob);
    x4:=x0+round(4*frXGlob);y4:=y0+hauteurCell;
    
    Brush.Color:=couleur;
    pen.color:=couleur;
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
    FillRect(r);

    // aiguillage dévié
    if position=const_Devie then
    begin              
      x1:=x0+round(12*frXGlob);y1:=jy2; 
      x2:=x1+round(20*frxGlob);y2:=y1;
      x3:=x2;y3:=y2+round(3*frYGlob);
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
    // aiguillage droit
    if position=const_Droit then
    begin
      x1:=x0+round(18*frXGlob);y1:=jy1;
      x2:=x1+round(5*frxGlob);y2:=y1;
      x3:=x2-round(12*FrxGlob);y3:=y2+round(12*fryGlob);
      x4:=x3-round(8*frxGlob);y4:=y3;
      pen.color:=fond;
      Brush.Color:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
  end;
end;

// Element 12 aiguillage pointe 45°G vers droit
procedure TFormTCO.dessin_Aig45PG_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
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

    x1:=x0+round(3*frXGlob);y1:=y0;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*frYGlob);
    x3:=x0+largeurCell-round(4*frXGlob); y3:=y0+HauteurCell;
    x4:=x0; y4:=y0+round(4*frYGlob);
    
    Brush.Color:=couleur;
    pen.color:=couleur;
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
    FillRect(r);
    
    // aiguillage dévié
    if position=const_Devie then
    begin              
      x1:=x0+round(22*frxGlob);y1:=jy2; //+round(FrYGlob*1);
      x2:=x1+round(12*frxGlob);y2:=y1;
      x3:=x2;y3:=y2+3;
      x4:=x1;y4:=y3;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    
    // aiguillage droit
    if position=const_Droit then
    begin
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

// aiguillage pointe à gauche, aiguillage gauche Element 3
procedure TFormTCO.dessin_AigPG_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=couleur;
    pen.color:=couleur;
    Pen.Mode:=Mode;
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf

    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    //brush.color:=clblue;
    x1:=x0+(largeurCell div 2)+round(1*frXGlob); y1:=jy1;
    x2:=x0+largeurCell-round(3*frXGlob); y2:=y0;
    x3:=x0+largeurCell; y3:=y0+round(3*frYGlob);
    x4:=x0+(largeurCell div 2)+round(1*frXGlob);y4:=jy2-round(1*frYGlob);
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    // aiguillage dévié
    if position=const_Devie then
    begin
      x1:=x4+round(2*frXGlob);y1:=jy2-round(1*frYGlob);
      x2:=x1+round(5*frXGlob);y2:=jy1;
      x3:=x2+round(5*frXGlob);y3:=y2;
      x4:=x1+round(5*frXGlob);y4:=y1;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    if position=const_Droit then
    begin
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


// aiguillage pointe à droite, aiguillage droit Element 5
procedure TFormTCO.dessin_AigPD_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode;position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.COlor:=couleur;
    Pen.Mode:=Mode;
    pen.color:=couleur;

    jy1:=y0+(HauteurCell div 2)-round(3*FrXGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*FrYGlob); // pos Y de la bande inf

    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    //FillRect(r);
    Rectangle(r);
    //brush.color:=clblue;
    x1:=x0+(largeurCell div 2); y1:=jy1;
    x2:=x0+round(3*FrXGlob); y2:=y0;
    x3:=x0; y3:=y0+round(3*FrYGlob);
    x4:=x0+(largeurCell div 2)-round(1*FrXGlob); y4:=jy2-round(1*FrYGlob);
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    // aiguillage dévié
    if position=const_Devie then
    begin
      x1:=x1-12;y1:=jy1;
      x2:=x1+5;y2:=jy2-1;
      x3:=x2+6;y3:=y2;
      x4:=x1+6;y4:=y1;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    // aiguillage droit
    if position=const_Droit then
    begin
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

// element 2
procedure TformTCO.dessin_AigG_PD(canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode; position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.COlor:=couleur;
    Pen.Mode:=Mode;
    pen.color:=couleur;

    // bande horizontale
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // déviation
    x1:=x0+(largeurCell div 2); y1:=jy1+round(1*frYGlob);
    x2:=x0-round(1*FrXGlob);y2:=y0+HauteurCell-round(2*FrYGlob);
    x3:=x0+round(2*FrXGlob);y3:=y0+HauteurCell;
    x4:=x1+round(1*FrXGlob);y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    // aiguillage dévié
    if position=const_Devie then
    begin
      x1:=x1;y1:=jy1;
      x2:=x1-6;y2:=jy2;
      x3:=x2-6;y3:=y2;
      x4:=x1-6;y4:=jy1;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;
    if position=const_Droit then
    begin
      // aiguillage droit
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

// Element 4
procedure TformTCO.dessin_AigD_PG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode;position : integer);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : Trect;
    s : string;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  with canvas do
  begin
    Brush.Color:=Fond;
    r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);
    FillRect(r);

    Brush.Color:=couleur;
    Pen.Mode:=Mode;
    pen.color:=couleur;

    // bande horizontale
    jy1:=y0+(HauteurCell div 2)-round(3*frYGlob); // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+round(3*frYGlob); // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // déviation
    x1:=x0+(largeurCell div 2)+round(1*frXGlob); y1:=jy1+round(1*frYGlob);
    x2:=x0+largeurCell;y2:=y0+HauteurCell-round(3*frYGlob);
    x3:=x0+largeurCell-round(3*frXGlob);y3:=y0+HauteurCell;
    x4:=x0+(largeurCell div 2)-round(1*frXGlob);y4:=jy2-round(1*frYGlob);
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);

    // aiguillage dévié
    if position=const_Devie then
    begin
      x1:=x1;y1:=jy1;
      x2:=x1+5;y2:=jy2-1;
      x3:=x2+6;y3:=y2;
      x4:=x1+6;y4:=y1;
      pen.color:=fond;
      Brush.COlor:=fond;
      Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
    end;

    if position=const_Droit then
    begin
      // aiguillage droit
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
    x0,y0,TailleY,TailleX  : integer;
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


// renvoie un pointeur vers l'image du feu suivant l'aspect du feu de adresse
// ne marche pas
function PointeurImage(adresse : integer) : TImage;
var i,aspect : integer;
    Pim : TImage;
begin
  // trouver l'aspect du feu
  i:=Index_feu(adresse);
  aspect:=feux[i].aspect;
  
  pim:=nil;
  case aspect of
  2 : Pim:=Formprinc.Image2feux;
  3 : Pim:=Formprinc.Image3feux;
  4 : Pim:=Formprinc.Image4feux;
  5 : Pim:=Formprinc.Image5feux;
  7 : Pim:=Formprinc.Image7feux;
  9 : Pim:=Formprinc.Image9feux;
  else Pim:=Formprinc.Image3feux;
  end;
  PointeurImage:=Pim;
end;

procedure cercle(ACanvas : Tcanvas;x,y,rayon : integer;couleur : Tcolor);
begin
with PCanvasTCO do
  begin
    brush.Color:=couleur;
    Ellipse(x-rayon,y-rayon,x+rayon,y+rayon);
  end;
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

procedure affiche_pied_VerticalG(x,y : integer;FrX,frY : real);
var x1,y1 : integer;
begin
  with PcanvasTCO do
  begin
    Pen.Color:=clOrange;
    x1:=12;y1:=90;
    moveTo( x+round((x1+0)*frX),y+round(y1*frY) );
    LineTo( x+round((x1+0)*frX),y+round((y1+7)*frY) );
    LineTo( x+round((x1+50-12)*frX),y+round((y1+7)*frY) );
    
    moveTo( x+round((x1+1)*frX),y+round((y1+0)*frY) );
    LineTo( x+round((x1+1)*frX),y+round((y1+8)*frY) );
    LineTo( x+round((x1+50-12)*frX),y+round((y1+8)*frY) );
    
  end;
end;

// Dessine un feu dans le canvas en x,y , dont l'adresse se trouve à la cellule x,y
procedure dessin_feu(CanvasDest : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
var  OffsetX,x0,y0,orientation,adresse,i,aspect,TailleX,TailleY,NbCellDest : integer;
     ImageFeu : Timage;
     frX,frY : real;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;

  Adresse:=TCO[x,y].Adresse;
  //if adresse=0 then exit;

  i:=TCO[x,y].indexfeu;
  Orientation:=feuTCO[i].FeuOriente; 
  if Orientation=0 then Orientation:=1;  // cas d'un feu non encore renseigné

  aspect:=feuTCO[i].aspect;
  //Affiche(IntToSTR(i)+' '+intToSTR(aspect),clred);

  offsetX:=0;
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

  // décalage en X pour mettre la tete du feu alignée sur le bord droit de la cellule pour les feux tournés à 90G
  if orientation=2 then
  begin
    if aspect=9 then x0:=x0+round(10*frX); 
    if aspect=7 then x0:=x0+round(10*frX);  
    if aspect=5 then begin x0:=x0+round(10*frX); y0:=y0+HauteurCell-round(tailleX*frY); end;
    if aspect=4 then begin x0:=x0+round(10*frX); y0:=y0+HauteurCell-round(tailleX*frY); end;
    if aspect=3 then begin x0:=x0+round(10*frX); y0:=y0+HauteurCell-round(tailleX*frY); end;
    if aspect=2 then begin x0:=x0+round(10*frX); y0:=y0+HauteurCell-round(tailleX*frY); end;
  end;
  
  // orientation verticale
  if (Orientation=1) then 
  begin                              
    // copie avec mise à l'échelle                   
    TransparentBlt(canvasDest.Handle,x0,y0,round(TailleX*frX),round(TailleY*frY),
                   ImageFeu.Canvas.Handle,0,0,TailleX,TailleY,clBlue);
    PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
    if aspect=9 then affiche_pied_VerticalG(x0,y0,frX,frY);
  end;

  // orientation 90°G
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

  // orientation 90°D
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
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : TRect;
begin
  if y>1 then
  begin
    // si la cellule au dessus contient un feu vertical, ne pas effacer la cellule
 //   if (tco[x,y-1].BImage=12) and (tco[x,y-1].FeuOriente=1) then exit;
  end;
  if x<NbreCellX then
  begin
    // si la cellule à gauche contient un feu 90D, ne pas effacer la cellule
//    if (tco[x-1,y].BImage=12) and (tco[x-1,y].FeuOriente=3) then exit;
  end;              

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

// transforme les branches en TCO
// trop compliqué. Il faudra dessiner son TCO soit meme
procedure construit_TCO;
var x,y,i,j,Max,indexMax : integer;
begin
  // étape 0 Raz du TCO
  for y:=1 to 20 do
    for x:=1 to 20 do
    begin
      TCO[x,y].Adresse:=0;
      TCO[x,y].Btype:=0;
    end;  

  //étape 1 trouver la branche la plus longue
  Max:=0;
  for i:=1 to  NbreBranches do
  begin
    j:=0;
    repeat
      inc(j);
    until BrancheN[i,j].Adresse=0;
    if j>Max then begin Max:=j-1;IndexMax:=i;end;
  end;
  Affiche('La branche la plus grande a pour index '+IntToSTR(IndexMax),clOrange);

  // stocker cette branche au milieu du TCO (en 5)
  for i:=1 to Max do
  begin
    TCO[i,5].Adresse:=BrancheN[IndexMax,i].Adresse;
    TCO[i,5].Btype:=BrancheN[IndexMax,i].Btype;
  end;
end;


// affiche la cellule. x et y en cases
procedure TformTCO.affiche_cellule(x,y : integer;mode : TPenMode);
var i,Xorg,Yorg,adresse,btype,Bimage,aspect,oriente,pos : integer;
    s : string;
begin
  PcanvasTCO.pen.Mode:=PmCopy;
  adresse:=tco[x,y].Adresse;
  btype:=tco[x,y].Btype;
  BImage:=tco[x,y].BImage;
  if (bImage>=2) and (btype<=14) then pos:=Aiguillage[adresse].position;

  Xorg:=(x-1)*LargeurCell;
  Yorg:=(y-1)*HauteurCell;
  s:=IntToSTR(adresse);
  if Btype=2 then s:='A'+s;
  if Btype=3 then s:='A'+s+'B';

  i:=Tco[x,y].IndexFeu;
  
  if y>1 then if (tco[x,y-1].Bimage=30) and (FeuTCO[i].FeuOriente=1) then exit;
  
  case Bimage of 
    //  0 : efface_cellule(PCanvasTCO,x,y,Clyellow,Mode);     &&&&&&&&&
      1 : dessin_voie(PCanvasTCO,X,Y,Clyellow,Mode);
      2 : dessin_AigG_PD(PCanvasTCO,X,Y,Clyellow,mode,pos);
      3 : dessin_AigPG_AG(PCanvasTCO,X,Y,Clyellow,mode,pos);
      4 : dessin_AigD_PG(PCanvasTCO,X,Y,Clyellow,Mode,pos);
      5 : dessin_AigPD_AD(PCanvasTCO,X,Y,Clyellow,Mode,pos);
      6 : dessin_SupG(PCanvasTCO,X,Y,Clyellow,Mode);
      7 : dessin_SupD(PCanvasTCO,X,Y,Clyellow,Mode);
      8 : dessin_infD(PCanvasTCO,X,Y,Clyellow,Mode);
      9 : dessin_infG(PCanvasTCO,X,Y,Clyellow,mode);
     10 : dessin_Diag1(PCanvasTCO,X,Y,Clyellow,mode);
     11 : dessin_Diag2(PCanvasTCO,X,Y,Clyellow,mode);
     12 : dessin_Aig45PG_AG(PCanvasTCO,X,Y,Clyellow,mode,pos);
     13 : dessin_Aig45PD_AD(PCanvasTCO,X,Y,Clyellow,mode,pos);
     14 : dessin_Aig45PD_AG(PCanvasTCO,X,Y,Clyellow,mode,pos);
     15 : dessin_Aig45PG_AD(PCanvasTCO,X,Y,Clyellow,mode,pos);
     30 : dessin_feu(PCanvasTCO,X,Y,Clyellow,mode);
  end;

  PCanvasTCO.font.Size:=(LargeurCell div 10)+4  ;
//  Affiche(intToSTR( (LargeurCell div 30)+6),clyellow);
  
  // affiche le texte des aiguillages
  if (BImage>=2) and (BImage<29) and (adresse<>0) then 
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clYellow;
      x:=0;y:=0;
      if Bimage=4  then begin x:=1;y:=0;end;
      if Bimage=5  then begin x:=1;y:=HauteurCell-12;end;
      if Bimage=12 then begin x:=1;y:=HauteurCell-12;end;
      TextOut(xOrg+x,yOrg+y,s);
      exit;
    end;  
  end;
     
  // détecteurs
  if (BImage=1) and (adresse<>0) then 
  begin // Adresse de l'élément
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clWhite;
      TextOut(xOrg+1,yOrg+1,s);
      exit;
    end;  
  end;

  // texte des signaux
  if (BImage=30) and (adresse<>0) then 
  begin 
    i:=tco[x,y].IndexFeu;
    if i=0 then exit;
    aspect:=feuTCO[i].aspect;
    oriente:=Feutco[i].FeuOriente;
    x:=0;y:=0;
    if (aspect=9) and (Oriente=1) then begin x:=LargeurCell-round(18*frXGlob);y:=2*HauteurCell-round(18*fryGlob);end;
    if (aspect=9) and (Oriente=2) then begin x:=round(10*frXGlob);y:=HauteurCell-round(17*frYGlob);end;    // orientation G
    if (aspect=9) and (Oriente=3) then begin x:=LargeurCell+2;y:=1;end;
    if (aspect=7) and (Oriente=1) then begin x:=LargeurCell-round(18*frXGlob);y:=HauteurCell+1;end;
    if (aspect=7) and (Oriente=2) then begin x:=round(10*frXGlob);y:=HauteurCell-round(15*frYGlob);end;
    if (aspect=7) and (Oriente=3) then begin x:=LargeurCell+2;y:=1;end;
    if (aspect=5) and (Oriente=1) then begin x:=round(24*frXGlob);y:=1;end;
    if (aspect=5) and (Oriente=2) then begin x:=round(10*frXGlob);y:=round(2*frYGlob);end;
    if (aspect=5) and (Oriente=3) then begin x:=round(10*frXGlob);y:=HauteurCell-round(22*frYGlob);end;
    if (aspect=4) and (Oriente=1) then begin x:=LargeurCell-18;y:=1;end;
    if (aspect=4) and (Oriente=2) then begin x:=round(10*frXGlob);y:=round(2*frYGlob);end;
    if (aspect=4) and (Oriente=3) then begin x:=round(10*frXGlob);y:=HauteurCell-round(22*frYGlob);end;
    if (aspect=3) and (Oriente=1) then begin x:=LargeurCell-18;y:=1;end;
    if (aspect=3) and (Oriente=2) then begin x:=round(10*frXGlob);y:=round(2*frYGlob);end;
    if (aspect=3) and (Oriente=3) then begin x:=round(10*frXGlob);y:=HauteurCell-round(22*frYGlob);end;
    if (aspect=2) and (Oriente=1) then begin x:=LargeurCell-round(18*frXGlob);y:=1;end;   // orientation V
    if (aspect=2) and (Oriente=2) then begin x:=round(10*frXGlob);y:=round(2*frYGlob);end;  // orientation G
    if (aspect=2) and (Oriente=3) then begin x:=round(10*frXGlob);y:=HauteurCell-round(22*frYGlob);end;  // orientation D
    with PCanvasTCO do
    begin
      Brush.Color:=fond;
      Font.Color:=clLime;
      TextOut(xOrg+x,yOrg+y,s);
    end;  
  end;

  //canvasTCO.TextOut(xOrg+1,yOrg+1,IntToSTR(x));  
end;

// affiche le tco suivant le tableau TCO
procedure TformTCO.Affiche_TCO ;
var x,y,x0,y0,DimX,DimY : integer;
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
        if TCO[x,y].BImage<>30 then affiche_cellule(x,y,PmCopy);
      end;

  PCanvasTCO.Font.Size:=8;    
  //afficher les cellules des feux pour que les pieds recouvrent le reste et afficher les textes
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if TCO[x,y].BImage=30 then affiche_cellule(x,y,PmCopy);
        s:=Tco[x,y].Texte;
        if s<>'' then 
        begin
          x0:=(x-1)*Largeurcell;
          y0:=(y-1)*hauteurcell;
          PcanvasTCO.Textout(x0+2,y0+1,s);
        end;  
      end;

  // afficher la grille
  grille;    
  
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
end;

// clic gauche sur image
procedure TFormTCO.ImageTCOClick(Sender: TObject);
var  Position: TPoint;
     i ,adresse,Bimage : integer;
     s : string;
begin
  GetCursorPos(Position);
 
  Position:=ImageTCO.screenToCLient(Position);
  //Affiche(IntToSTR(position.x),clyellow);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if XclicCell>NbreCellX then exit;   
  if YclicCell>NbreCellY then exit;

  Bimage:=tco[XClicCell,YClicCell].Bimage;

  if not(SelectionAffichee) then // si la sélection bleue n'est pas affichée
  begin
    if not(entoure) then    // si la cellule n'avait pas été entourée
    begin
      Entoure_cell(XclicCell,YclicCell);
      entoure:=true;
      Xentoure:=XClicCell;Yentoure:=YclicCell;
    end
    else
    begin
      Entoure_cell(Xentoure,Yentoure);   // efface l'ancien
      Entoure_cell(XclicCell,YclicCell);
      Xentoure:=XClicCell;Yentoure:=YclicCell;
    end;

    if (Bimage=1) or (Bimage=0) then
    begin 
      s:=Tco[XClicCell,YClicCell].Texte;
      EditTexte.Text:=s;
      EditTexte.Visible:=true   
    end   
    else EditTexte.Visible:=false;
    
 end;   
  
  LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);

  EdittypeImage.Text:=IntToSTR(BImage);
  if Bimage=30 then  //feu
  begin
    Adresse:=tco[XClicCellInserer,YClicCellInserer].Adresse;
    i:=Index_Feu(adresse);
  end;
   
  
  //Affiche('XClicCell='+intToSTR(XclicCell)+' '+'YClicCell='+intToSTR(YclicCell),clyellow);
  //Affiche('Evt ImageTCOclick',clYellow);
end;

procedure TformTCO.Entoure_cell(x,y : integer);
var r : Trect;
    x0,y0 : integer;
begin
  x0:=(x-1)*LargeurCell+1;
  y0:=(y-1)*HauteurCell+1;
  with ImageTCO.canvas do
  begin
    Pen.width:=3;
    Pen.Color:=clyellow;
    Brush.Color:=clBlack;
    Brush.Style:=bsSolid;
    Pen.Mode:=PmXor;
    r:=Rect(x0,y0,x0+largeurCell,y0+LargeurCell);
    Rectangle(r);
    Pen.width:=1;
//    FillRect(r);
  end;

end;


procedure TFormTCO.FormActivate(Sender: TObject);
begin
  if not(Forminit) then
  begin
    FormInit:=true;
    Button1.Visible:=not(Diffusion);
    Button2.Visible:=not(Diffusion);
    ImageTemp.Visible:=not(Diffusion);
    
    lire_fichier_tco;

    calcul_reduction(frxGlob,fryGlob,LargeurCell,HauteurCell,ZoomMax,ZoomMax);
    // dessiner les icônes
    dessin_AigPD_AD(ImagePalette5.Canvas,1,1,clyellow,pmCopy,0);
    dessin_AigG_PD(ImagePalette2.Canvas,1,1,clyellow,pmCopy,0);
    dessin_AigPG_AG(ImagePalette3.Canvas,1,1,clyellow,pmCopy,0);
    dessin_AigD_PG(ImagePalette4.Canvas,1,1,clyellow,pmCopy,0);
    dessin_voie(ImagePaletteDroit.canvas,1,1,Clyellow,pmCopy);
    dessin_SupG(ImageSupG.canvas,1,1,Clyellow,pmCopy);
    dessin_SupD(ImageSupD.canvas,1,1,Clyellow,pmCopy);
    dessin_InfD(ImageInfD.canvas,1,1,Clyellow,pmCopy);
    dessin_infG(ImageInfG.canvas,1,1,Clyellow,pmCopy);
    dessin_Diag1(ImageDiag1.Canvas,1,1,Clyellow,pmCopy);
    dessin_Diag2(ImageDiag2.Canvas,1,1,Clyellow,pmCopy);
    dessin_Aig45PG_AG(ImageAig45PG_AG.Canvas,1,1,Clyellow,pmCopy,0);
    dessin_Aig45PD_AD(ImageAig45PD_AD.Canvas,1,1,Clyellow,pmCopy,0);
    dessin_Aig45PD_AG(ImageAig45PD_AG.Canvas,1,1,Clyellow,pmCopy,0);
    dessin_Aig45PG_AD(ImageAig45PG_AD.Canvas,1,1,Clyellow,pmCopy,0);
    
    
    ImageTCO.Width:=LargeurCell*NbreCellX;
    ImageTCO.Height:=HauteurCell*NbreCellY;
    
    ImageTCO.Picture.Create;
    ImageTCO.Picture.Bitmap.Height:=HauteurCell*NbreCellY;
    ImageTCO.Picture.BitMap.Width:=LargeurCell*NbreCellX;
 
    
    PCanvasTCO:=FormTCO.ImageTCO.Picture.Bitmap.Canvas;
    PBitMapTCO:=FormTCO.ImageTCO.Picture.Bitmap;
    PScrollBoxTCO:=FormTCO.ScrollBox;
    PImageTCO:=FormTCO.ImageTCO;
    PImageTemp:=FormTCO.ImageTemp;
    PImageTemp.Canvas.Rectangle(0,0,PImageTemp.Width,PimageTemp.Height);
    
    With ImageFeu do
    begin
      Picture.Bitmap.TransparentMode:=tmAuto; 
      Picture.Bitmap.TransparentColor:=clblue;
      Transparent:=true;
      Picture.Bitmap:=Formprinc.Image9feux.Picture.Bitmap;
    end;  
    Affiche_tco;
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

  if not(SelectionAffichee) then
  begin
    if not(entoure) then 
    begin
      Entoure_cell(XclicCell,YclicCell);entoure:=true;
      Xentoure:=XClicCell;Yentoure:=YclicCell;
    end
    else
    begin
      Entoure_cell(Xentoure,Yentoure);   // efface l'ancien
      Entoure_cell(XclicCell,YclicCell);
      Xentoure:=XClicCell;Yentoure:=YclicCell;
    end;
 end;   

  LabelX.caption:=IntToSTR(XclicCell);
  LabelY.caption:=IntToSTR(YclicCell);

  label1.caption:='clicContext';


  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);
  
  //Affiche('XClicCell='+intToSTR(XclicCell)+' '+'YClicCell='+intToSTR(YclicCell),clyellow);
end;



(*
procedure TFormTCO.Aiguillagegauchepointedroite1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_AigG_PD(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);

end; 

procedure TFormTCO.Aiguillagedroitpointegauche1Click(Sender: TObject);
var  Position: TPoint;
begin
  tco[XClicCellInserer,YClicCellInserer].Adresse:=1;
  tco[XClicCellInserer,YClicCellInserer].Btype:=5;
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_AigD_PG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy,0);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);
  
end;   *)

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
  EdittypeElement.Text:=IntToSTR(tco[XClicCell,YClicCell].BType);
  
end;

procedure TFormTCO.Elmentdroit1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_voie(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);

end;

procedure TFormTCO.Courbegaucheversdroite1Click(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_infG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
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
  dessin_infD(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
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
  dessin_SupD(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
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
  dessin_SupG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);

end;

procedure TFormTCO.ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
//   Accept:=source is TImage;
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
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigPD_AD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=2;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=5;  // image 5
  
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);  
end;

procedure TFormTCO.ImagePalette2EndDrag(Sender,Target: TObject; X,Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigG_PD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=2;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=2;  // image 2

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);  
end;

procedure TFormTCO.ImagePalette2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette2.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette3EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigPG_AG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=2;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=3;  // image 3

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);  
end;

procedure TFormTCO.ImagePalette3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette3.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette4EndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigD_PG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=2;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=4;  // image 4

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePalette4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette4.BeginDrag(true);
end;

procedure TFormTCO.ImagePaletteDroitEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_voie(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=1;  // voie
  tco[XClicCell,YClicCell].BImage:=1;  // image 1
  tco[XClicCell,YClicCell].Adresse:=0;  

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImagePaletteDroitMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePaletteDroit.BeginDrag(true);
end;

procedure TFormTCO.ImageSupGEndDrag(Sender, Target: TObject; X,Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_SupG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=6;  // image 6
  tco[XClicCell,YClicCell].Adresse:=0;  

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageSupGMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageSupG.BeginDrag(true);
end;

procedure TFormTCO.ImageSupDEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_SupD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=7;  // image 7
  tco[XClicCell,YClicCell].Adresse:=0;  

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageSupDMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageSupD.BeginDrag(true);
end;

procedure TFormTCO.ImageInfDEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_infD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=8;  // image 8
  tco[XClicCell,YClicCell].Adresse:=0;  

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageInfDMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageInfD.BeginDrag(true);
end;

procedure TFormTCO.ImageInfGMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageInfG.BeginDrag(true);
end;


procedure TFormTCO.ImageAig45PG_AGMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ImageAig45PG_AG.BeginDrag(true);
end;


procedure TFormTCO.ImageAig45PD_ADMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageAig45PD_AD.BeginDrag(true);
end;


procedure TFormTCO.ImageAig45PD_AGMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageAig45PD_AG.BeginDrag(true);
end;

procedure TFormTCO.ImageAig45PG_ADMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageAig45PG_AD.BeginDrag(true);
end;

procedure TFormTCO.ImageInfGEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_infG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=9;  // image 9
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageAig45PG_AGEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_Aig45PG_AG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=12;  // image 12
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;


procedure TFormTCO.ImageAig45PD_ADEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_Aig45PD_AD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=13;  // image 13
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageAig45PD_AGEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_Aig45PD_AG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=14;  // image 14
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;


procedure TFormTCO.ImageAig45PG_ADEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  Dessin_Aig45PG_AD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy,0);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=15;  // image 15
  tco[XClicCell,YClicCell].Adresse:=0;  // rien
  
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
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
var  Position: TPoint;
     r : Trect;
     x0,y0,x,y,XCell1,YCell1,xCell2,yCell2 : integer;
begin
  if not(SelectionAffichee) then exit;

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
      tco[x,y].BType:=0;
      tco[x,y].Adresse:=0;
      tco[x,y].BImage:=0;
      //Affiche('Efface cellules '+IntToSTR(X)+' '+intToSTR(y),clyellow);
      efface_cellule(ImageTCO.Canvas,X,Y,fond,PmCopy);
      if avecGrille then grille;
    end;
end;

procedure TFormTCO.AnnulercouperClick(Sender: TObject);
var x,y,Xplace,yplace : integer;
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
          if (xPlace<=NbreCellX) and (yPlace<=NbreCellY) then tco[xPlace,yPlace]:=tamponTCO[x,y];
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
  
      // coordonnées grilleg
      XclicCell:=Xclic div largeurCell + 1;
      YclicCell:=Yclic div hauteurCell + 1;

       LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);
  end; 
end;

procedure TFormTCO.ImageTCOMouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
var  Position: TPoint;
     r : Trect;
     x0,y0,XSel1,YSel1,XSel2,YSel2 : integer;
begin
  //Affiche('MouseMove',clyellow);
  //Affiche(IntToSTR(X),clyellow);
  SourisX.Caption:=IntToSTR(x);
  SourisY.Caption:=IntToSTR(y);
  
  if not(sourisclic) then exit;

  // on a cliqué la souris en la bougeant : sélection bleue en cours
  //Affiche('MouseMove',clyellow);
  GetCursorPos(Position);
  Position:=ImageTCO.screenToCLient(Position);
  Xclic:=position.X;
  YClic:=position.Y;
  
  // coordonnées grille
  XclicCell:=Xclic div largeurCell + 1;
  YclicCell:=Yclic div hauteurCell + 1;

  if XclicCell>NbreCellX then exit;
  if YclicCell>NbreCellY then exit;
  
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
  
  if SelectionAffichee then
  with imageTCO.Canvas do
  begin
    Pen.Mode:=PmXor;
    Pen.color:=clGrille;
    Brush.Color:=clblue;
    //FillRect(r);
    Rectangle(rAncien);
  end;
  
  r:=Rect(xminiSel+1,YminiSel+1,XmaxiSel+largeurCell,yMaxiSel+hauteurCell);

  XSel1:=Xminisel div largeurCell + 1;
  YSel1:=Yminisel div hauteurCell + 1;
  XSel2:=Xmaxisel div largeurCell + 1;
  YSel2:=Ymaxisel div hauteurCell + 1;
  
  // Affiche(intToSTR(Xsel1)+' '+intToStr(Ysel1)+' '+intToSTR(Xsel2)+' '+intToStr(Ysel2),clYellow);
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
  if entoure then Entoure_cell(Xentoure,Yentoure); // efface 
  entoure:=false;
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
var Adr,erreur,i,index : integer;
begin
  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then 
  begin
    EditAdrElement.text:=intToSTR(tco[XClicCell,YClicCell].Adresse);
    exit;
  end;  
  
  tco[XClicCell,YClicCell].Adresse:=Adr;
  TCO_modifie:=true;
  // Efface_cellule(PCanvasTCO,XClicCell,YClicCell+1,Fond,pmcopy);

  // si c'est un feu, mettre à jour le tableau FeuTCO
  if tco[XClicCell,YClicCell].BImage=30 then
  begin
    index:=Index_feu(adr);
    if index=0 then 
    begin 
      //affiche('Erreur feu inexistant',clred)
      exit;
    end  
    else 
      begin
       //Affiche('Feu '+intToSTR(Adr),clyellow);
       i:=tco[XClicCell,YClicCell].IndexFeu;
       FeuTCO[i].Aspect:=Feux[index].aspect;
       FeuTCO[i].Adresse:=Adr;
       
       //affiche_cellule(XClicCell,YClicCell,pmCopy);
     end;  
  end;  
  affiche_tco;
end;


procedure TFormTCO.EditTypeImageKeyPress(Sender: TObject; var Key: Char);
var Bimage,erreur : integer;
begin
  if ord(Key) = VK_RETURN then
  begin
    Key:=#0; // évite beeping
    Val(EditTypeImage.Text,Bimage,erreur);
   // Affiche(IntToSTR(bimage),clyellow);
    if (erreur<>0) or (Bimage<0) or (Bimage>15) then 
    begin
      EditTypeImage.text:=intToSTR(tco[XClicCell,YClicCell].BImage);
      exit;
    end;  
    TCO_modifie:=true;
    tco[XClicCell,YClicCell].Bimage:=Bimage;
    case Bimage of
    // aiguillages
    1,2,3,4,13,14,15 : tco[XClicCell,YClicCell].Btype:=2;
    // détecteur ou voie
    5 : tco[XClicCell,YClicCell].Btype:=1;
    else tco[XClicCell,YClicCell].Btype:=0;
    end;
    
    EditTypeElement.text:=intToSTR(tco[XClicCell,YClicCell].Btype);
    affiche_cellule(XClicCell,YClicCell,pmCopy);
  end;
end;

procedure TFormTCO.Maj_TCO(Adresse : integer);
var x,y : integer;
begin
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        if tco[x,y].Adresse=Adresse then 
        affiche_cellule(x,y,PmCopy);
      end;
end;

procedure TFormTCO.Button1Click(Sender: TObject);
begin
    Detecteur[569]:=true;
   Maj_tco(569); 
end;


procedure TFormTCO.Button2Click(Sender: TObject);
begin
   Detecteur[569]:=false;
   Maj_tco(569);
end;


// dépose d'un feu sur le TCO
procedure TFormTCO.ImageDiag1EndDrag(Sender, Target: TObject; X, Y: Integer);
var i : integer;
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  inc(NbFeuTCO);
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_Diag1(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=10;  // image 10
  tco[XClicCell,YClicCell].Adresse:=0;  
  tco[XClicCell,YClicCell].IndexFeu:=NbFeuTCO;
  Feutco[NbFeuTCO].FeuOriente:=1;  
   
  FeuTCO[NbFeuTCO].Adresse:=0;
  FeuTCO[NbFeuTCO].x:=XClicCell;
  FeuTCO[NbFeuTCO].y:=YClicCell;
   
  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageDiag1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageDiag1.BeginDrag(true);
end;

procedure TFormTCO.ImageDiag2EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_Diag2(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=11;  
  tco[XClicCell,YClicCell].Adresse:=0;  

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;

procedure TFormTCO.ImageDiag2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImageDiag2.BeginDrag(true);
end;

procedure TFormTCO.ButtonConfigTCOClick(Sender: TObject);
begin
  TformconfigTCO.create(self);
  formconfigTCO.showmodal;
  formconfigTCO.close;
end;

procedure TFormTCO.ImageFeuEndDrag(Sender, Target: TObject; X, Y: Integer);
var r : Trect;
    i : integer;
begin
  if (x=0) and (y=0) then exit;
  TCO_modifie:=true;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  //PCanvasTCO.Draw((xClicCell-1)*LargeurCell,(yClicCell-1)*HauteurCell,ImageFeu.Picture.Bitmap);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=30;  
  tco[XClicCell,YClicCell].Adresse:=0;
  inc(NbFeuTCO);
  tco[XClicCell,YClicCell].indexFeu:=NbFeuTCO;   
  FeuTco[NbFeuTCO].FeuOriente:=1;
  FeuTco[NbFeuTCO].Aspect:=9;

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);

  dessin_feu(PCanvasTCO,XclicCell,YClicCell,Clyellow,pmCopy);

end;


procedure TFormTCO.ImageFeuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ImageFeu.BeginDrag(true);
end;

 
procedure TFormTCO.Tourner90GClick(Sender: TObject);
var BImage,aspect,adresse,index : integer;
    ImageFeu : TImage;
    frX,frY : real;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>30 then exit; 

  TCO_modifie:=true;
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  index:=TCO[XClicCell,YClicCell].indexFeu;  
  
  // effacement de l'ancien feu
  if FeuTCO[index].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;
  
  if FeuTCO[index].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell-1,yClicCell,fond,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if FeuTCO[index].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,fond,PmCopy);
  end;

  FeuTCO[index].FeuOriente:=2;  // feu orienté à 90° gauche
 
  dessin_feu(PCanvasTCO,XclicCell,YClicCell,Clyellow,pmCopy);
end;

procedure TFormTCO.Tourner90DClick(Sender: TObject);
var BImage ,aspect,adresse,index : integer;
    ImageFeu : TImage;
    frX,frY : real;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>30 then exit; 

  TCO_modifie:=true;
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  index:=TCO[XClicCell,YClicCell].indexFeu;  
  aspect:=FeuTCO[index].aspect;
  if aspect=0 then aspect:=9;
  
  // ancien feu orienté orienté 90D
  if FeuTCO[index].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // ancien feu orienté orienté 90G
  if FeuTCO[index].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if FeuTCO[index].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,fond,PmCopy);
  end;
   
  FeuTCO[index].FeuOriente:=3;  // feu orienté à 90° droit
  dessin_feu(PCanvasTCO,XclicCell,YClicCell,Clyellow,pmCopy);
end;


procedure TFormTCO.Pos_vertClick(Sender: TObject);
var BImage ,aspect,index,Adresse : integer;
    ImageFeu : TImage;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  // si c'est autre chose qu'un feu, sortir
  if Bimage<>30 then exit; 

  TCO_modifie:=true;
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  index:=TCO[XClicCell,YClicCell].indexFeu;  
  aspect:=feuTCO[index].aspect;
  if aspect=0 then aspect:=9;
  
  // effacement de l'ancien feu
  
  // ancien feu orienté orienté 90D
  if FeuTCO[index].FeuOriente=3 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    // si le feu occupe 2 cellules
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // ancien feu orienté orienté 90G  
  if FeuTCO[index].FeuOriente=2 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    // si le feu occupe 2 cellules
    if aspect>=4 then Efface_Cellule(PCanvasTCO,xClicCell+1,yClicCell,fond,PmCopy);
  end;

  // si l'image était verticale, il faut effacer la cellule en bas
  if FeuTCO[index].FeuOriente=1 then
  begin
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,fond,PmCopy);
    Efface_Cellule(PCanvasTCO,xClicCell,yClicCell+1,fond,PmCopy);
  end;
  
  FeuTCO[index].FeuOriente:=1;  // feu orienté à 180° 
  dessin_feu(PCanvasTCO,XclicCell,YClicCell,Clyellow,pmCopy);
  
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
  
  PCanvasTCO.TextOut(x0+2,y0+2,EditTexte.Text);
  Tco[XClicCell,YClicCell].Texte:=EditTexte.Text;
  TCO_modifie:=true;
end;
  
begin


end.
