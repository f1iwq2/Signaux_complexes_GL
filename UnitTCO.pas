unit UnitTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids , UnitPrinc, StdCtrls, ExtCtrls, Menus, UnitPilote ;

type
  TFormTCO = class(TForm)
    LabelX: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelY: TLabel;
    PopupMenu1: TPopupMenu;
    MenuCouper: TMenuItem;
    N1: TMenuItem;
    Insrer1: TMenuItem;
    aiguillageG_PG: TMenuItem;
    Label1: TLabel;
    aiguillageD_PD: TMenuItem;
    N2: TMenuItem;
    Aiguillagegauchepointedroite1: TMenuItem;
    Aiguillagedroitpointegauche1: TMenuItem;
    N3: TMenuItem;
    Elmentdroit1: TMenuItem;
    N4: TMenuItem;
    Courbegaucheversdroite1: TMenuItem;
    Courbedroiteversgauche1: TMenuItem;
    CourbeSupD1: TMenuItem;
    CourbeSupG1: TMenuItem;
    Label4: TLabel;
    EditAdrElement: TEdit;
    Label5: TLabel;
    EditTypeElement: TEdit;
    ImagePalette1: TImage;
    ImagePalette2: TImage;
    ImagePalette3: TImage;
    ImagePalette4: TImage;
    ImagePaletteDroit: TImage;
    ImageSupG: TImage;
    ImageSupD: TImage;
    ImageInfD: TImage;
    ImageInfG: TImage;
    ButtonSauveTCO: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    MenuCopier: TMenuItem;
    MenuColler: TMenuItem;
    ButtonRedessine: TButton;
    ScrollBox: TScrollBox;
    ImageTCO: TImage;
    Label15: TLabel;
    EditTypeImage: TEdit;
    Button1: TButton;
    Button2: TButton;
    ImageDiag1: TImage;
    Label16: TLabel;
    ImageDiag2: TImage;
    Label17: TLabel;
    ButtonConfigTCO: TButton;
    ImageFeu: TImage;
    Label18: TLabel;
    ImageTemp: TImage;
    Tourner90G: TMenuItem;
    Tourner90D: TMenuItem;
    SourisX: TLabel;
    SourisY: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ImageTCOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageTCOContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure aiguillageG_PGClick(Sender: TObject);
    procedure dessin_AigPG_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_AigPD_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_Diag1(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_Diag2(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_infG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure dessin_infD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
    procedure Entoure_cell(x,y : integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure aiguillageD_PDClick(Sender: TObject);
    procedure Aiguillagegauchepointedroite1Click(Sender: TObject);
    procedure dessin_AigG_PD(canvas : Tcanvas;X,Y : integer; couleur : Tcolor;Mode : TPenMode);
    procedure Elmentdroit1Click(Sender: TObject);
    procedure dessin_voie(Canvas : Tcanvas;x,y : integer;couleur : TColor;Mode : TPenMode);
    procedure Courbegaucheversdroite1Click(Sender: TObject);
    procedure Courbedroiteversgauche1Click(Sender: TObject);
    procedure Aiguillagedroitpointegauche1Click(Sender: TObject);
    procedure dessin_AigD_PG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
    procedure CourbeSupD1Click(Sender: TObject);
    procedure dessin_SupD(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
    procedure CourbeSupG1Click(Sender: TObject);
    procedure dessin_SupG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
    procedure ImageTCODragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImagePalette1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePalette1EndDrag(Sender, Target: TObject; X, Y: Integer);
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
    procedure Maj_TCO(Adresse : integer;etat : boolean);
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
    
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

  TTCO = array[1..100] of array[1..50] of record
               BType : integer ;      // 1= détecteur  2= aiguillage 3=bis 4=Buttoir 
               Adresse : integer ;    // adresse du détecteur ou de l'aiguillage ou du feu
               BImage : integer ;     // 0=rien 1=voie 2=aiguillage gauche gauche ... 12=feu
               FeuAspect : integer;   // aspect du feu (2 feux...9 feux)
               FeuOriente : integer ; // orientation du feu : 1 vertical en bas  / 2 horizontal gauche / 3 horizontal droit
            end;
  
const
  clGrille=$707070;
  
var
  Fond,couleurAdresse : Tcolor;
  FormTCO: TFormTCO;
  Forminit,sourisclic,SelectionAffichee,TamponAffecte : boolean;
  HtImageTCO,LargImageTCO,XclicCell,YclicCell,XminiSel,YminiSel,
  XmaxiSel,YmaxiSel,AncienXMiniSel,AncienXMaxiSel ,AncienYMiniSel,AncienYMaxiSel,
  Xclic,Yclic,XClicCellInserer,YClicCellInserer : integer;
  
  TamponTCO,tco : TTco ;
  TamponTCO_Org : record 
           x1,y1,x2,y2 : integer;
                  end;  
  rAncien : TRect;          
  PCanvasTCO : Tcanvas;
  PBitMapTCO : TBitMap;
  PScrollBoxTCO : TScrollBox;
  PImageTCO : Timage;
  PImageTemp : TImage;

  LargeurCell,HauteurCell,NbreCellX,NbreCellY : integer   ;

implementation

uses UnitConfigTCO;


{$R *.dfm}


procedure lire_fichier_tco;
var fichier : textfile;
    s : string;
    x,y,i,valeur,erreur : integer;

    function lit_ligne : string ;
    var c : char;
    begin
      repeat
        readln(fichier,s);
        s:=uppercase(s);
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

  x:=1;y:=1;NbreCellX:=0;NbreCellY:=0;

  //Faire une passe pour lire la taille de la matrice
  while not eof(fichier) do
  begin
    s:=lit_ligne;
    if s[1]<>'/' then
    begin
      inc(NbreCellY);  NbreCellX:=0;
      repeat
        i:=pos(')',s);
        if i=0 then begin closefile(fichier);exit;end;
        delete(s,1,i);
        inc(NbreCellX);
      until s='';
    end;
  end;
  reset(fichier);

  // 2eme passe  : lire le fichier
  while not eof(fichier) do
  begin
    s:=lit_ligne;
    if s[1]<>'/' then
    begin
      repeat
        i:=pos('(',s);
        if i=0 then begin closefile(fichier);exit;end;
        delete(s,i,1);

        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].BType:=valeur;
        delete(s,1,i);

        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].adresse:=valeur;
        delete(s,1,i);

        i:=pos(',',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].Bimage:=valeur;
        delete(s,1,i);

        i:=pos(')',s);
        if i=0 then begin closefile(fichier);exit;end;
        val(copy(s,1,i-1),valeur,erreur);if erreur<>0 then begin closefile(fichier);exit;end;
        tco[x,y].FeuOriente:=valeur;
        delete(s,1,i);

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
    x,y,erreur : integer;
begin
  AssignFile(fichier,'tco.cfg');
  rewrite(fichier);
  writeln(fichier,'/type(0=rien 1=voie/détecteur 2=aig 3=aigBis , adresse , image=1 à 10 ,orientation');
  writeln(fichier,'/Dalle TCO');
  for y:=1 to NbreCellY do
  begin
    s:='';
    for x:=1 to NbreCellX do
    begin
      s:=s+'('+IntToSTR(TCO[x,y].BType)+','+Format('%.*d',[3,TCO[x,y].Adresse])+','+
           IntToSTR(TCO[x,y].BImage)+','+IntToSTR(TCO[x,y].FeuOriente)+')';
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

// élément de voie horizontale
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
        jy1:=y0+(HauteurCell div 2)-6; // pos Y de la bande sup
        jy2:=y0+(HauteurCell div 2)+6; // pos Y de la bande inf
        r:=Rect(x0,jy1,x0+LargeurCell,jy2);
        FillRect(r);
      end;
    end;
      
    Brush.Color:=couleur;
    pen.color:=couleur;
    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
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

    x1:=x0;
    y1:=y0+hauteurCell-3;
    x2:=x0+largeurCell-3;
    y2:=y0;
    x3:=x0+largeurCell;
    y3:=y0+4;
    x4:=x0+4;
    y4:=y0+hauteurCell;
    
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

    x1:=x0+3;
    y1:=y0;
    x2:=x0+largeurCell;
    y2:=y0+HauteurCell-3;
    x3:=x0+largeurCell-4;
    y3:=y0+HauteurCell;
    x4:=x0;
    y4:=y0+4;
    
    Brush.Color:=couleur;
    pen.color:=couleur;
  
    PolyGon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);
  end;
end;  

// courbe bas gauche vers droit
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

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0+(largeurCell div 2),jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0;
    y1:=y0+HauteurCell-3;
    x2:=x0+(LargeurCell div 2) -0;
    y2:=jy1;
    x3:=x0+(LargeurCell div 2) +2;
    y3:=jy2;
    x4:=x0+3;
    y4:=y0+HauteurCell;
    Polygon([point(x1-2,y1+2),Point(x2,y2),Point(x3,y3),Point(x4-2,y4+2)]);
  end;
end;

// courbe: droit vers bas  -\
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

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2) ;
    y1:=jy1;
    x2:=x0+LargeurCell;
    y2:=y0+HauteurCell-3;
    x3:=x0+LargeurCell -2;
    y3:=y0+HauteurCell;
    x4:=x0+(LargeurCell div 2);
    y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;


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
    pen.color:=Couleur;
    Pen.Mode:=Mode;
  
    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+(LargeurCell div 2),jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2);
    y1:=jy1;
    x2:=x0+LargeurCell-2;
    y2:=y0;
    x3:=x0+LargeurCell;
    y3:=y0+2;
    x4:=x0+(LargeurCell div 2);
    y4:=jy2-2;
    Polygon([point(x1-2,y1+2),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// coin supérieur gauche
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

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0+(LargeurCell div 2),jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // brush.color:=clblue;
    x1:=x0+(LargeurCell div 2);
    y1:=jy2-2;
    x2:=x0;
    y2:=y0;
    x3:=x0+3;
    y3:=y0;
    x4:=x0+(LargeurCell div 2);
    y4:=jy1;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

// aiguillage pointe à gauche, aiguillage gauche
procedure TFormTCO.dessin_AigPG_AG(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
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
    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf

    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    //brush.color:=clblue;
    x1:=x0+(largeurCell div 2);
    y1:=jy1;
    x2:=x0+largeurCell-3;
    y2:=y0;
    x3:=x0+largeurCell;
    y3:=y0+3;
    x4:=x0+(largeurCell div 2)+7;
    y4:=jy1;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3+2,y3-2),Point(x4+2,y4-2)]);
  end;
end;


// aiguillage pointe à droite, aiguillage droit
procedure TFormTCO.dessin_AigPD_AD(Canvas : Tcanvas;x,y : integer;couleur : Tcolor;Mode : TPenMode);
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

    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf

    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    //FillRect(r);
    Rectangle(r);
    //brush.color:=clblue;
    x1:=x0+(largeurCell div 2); y1:=jy1;
    x2:=x0+3; y2:=y0;
    x3:=x0; y3:=y0+3;
    x4:=x0+(largeurCell div 2); y4:=jy2-1;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4-1,y4-1)]);
  end;
end;

procedure TformTCO.dessin_AigG_PD(canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
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
    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // déviation
    x1:=x0+(largeurCell div 2); y1:=jy1+1;
    x2:=x0;y2:=y0+HauteurCell-2;
    x3:=x0+1;y3:=y0+HauteurCell;
    x4:=x1;y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4-1,y4-1)]);
  end;
end;


procedure TformTCO.dessin_AigD_PG(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
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
    jy1:=y0+(HauteurCell div 2)-3; // pos Y de la bande sup
    jy2:=y0+(HauteurCell div 2)+3; // pos Y de la bande inf
    r:=Rect(x0,jy1,x0+LargeurCell,jy2);
    FillRect(r);

    // déviation
    x1:=x0+(largeurCell div 2); y1:=jy1+1;
    x2:=x0+largeurCell;y2:=y0+HauteurCell-2;
    x3:=x0+largeurCell-3;y3:=y0+HauteurCell;
    x4:=x0+(largeurCell div 2);y4:=jy2;
    Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4-1,y4-1)]);
  end;
end;

// Affiche dans le TCO en x,y un Feu à 90° d'après l'image transmise 
// x y en coordonnées grille (cellule)
procedure Feu_90G(ImageSource : TImage;x,y : integer);
var p : array[0..2] of TPoint; 
    x0,y0,HtFeu,LgFeu : integer;
begin
  x0:=(x-2)*LargeurCell;  
  y0:=(y-1)*HauteurCell;
  HtFeu:=ImageSource.Picture.Height;
  lgFeu:=ImageSource.Picture.Width;
  // Affiche('Taille X feu_90G='+IntToSTR(lgFeu),clLime);
  //PImageTCO.Picture.Bitmap.TransparentMode:=tmFixed; // tmAuto;
  //PImageTCO.Picture.Bitmap.TransparentColor:=clBlue;
  //PImageTCO.Transparent:=true;
  // copie à 90°G sans mise à l'échelle dans l'image provisoire
  p[0].X:=HtFeu;  //90;
  p[0].Y:=0;  //0;
  p[1].X:=HtFeu;  //90;
  p[1].Y:=LgFeu;  //49;
  p[2].X:=0;  //0;
  p[2].Y:=0;  //0;
  PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,lgFeu,HtFeu,0,0,0);
  PImageTemp.Picture.Bitmap.Modified:=True; 
  //PlgBlt(PImageTemp.Canvas.Handle,p,formprinc.Image5feux.Canvas.Handle,0,0,49,90,0,0,0);
  // et copier l'image tournée sur le TCO
  //StretchBlt(PcanvasTCO.Handle,x0,y0,LargeurCell*2,HauteurCell,
  //           PImageTemp.Canvas.Handle,0,0,HtFeu,LgFeu,srccopy);
  TransparentBlt(PcanvasTCO.Handle,x0,y0,LargeurCell*2,HauteurCell,
             PImageTemp.Canvas.Handle,0,0,HtFeu,LgFeu,clBlue);    // clblue est la couleur de transparence
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
end;

// copie de l'image du feu à 90° dans le canvas source et le tourne de 90° et le met dans l'image temporaire
procedure Feu_90D(ImageSource : TImage;x,y : integer);
var p : array[0..2] of TPoint; 
    x0,y0,HtFeu,LgFeu  : integer;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  HtFeu:=ImageSource.Picture.Height;
  lgFeu:=ImageSource.Picture.Width;
  // copie à 90°D dans l'image provisoire
  p[0].X:=0;
  p[0].Y:=LgFeu;  //49;
  p[1].X:=0;
  p[1].Y:=0;
  p[2].X:=HtFeu;  //90;
  p[2].Y:=LgFeu;  //49;
  PlgBlt(PImageTemp.Canvas.Handle,p,ImageSource.Canvas.Handle,0,0,LgFeu,HtFeu,0,0,0);
  PImageTemp.Picture.Bitmap.Modified:=True; 
  // et copier l'image avec mise à l'échelle tournée sur le TCO
  TransparentBlt(PcanvasTCO.Handle,x0,y0,LargeurCell*2,HauteurCell,
                 PImageTemp.Canvas.Handle,0,0,HtFeu,LgFeu,clBlue);
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
  
end;

 // copie de l'image du feu à 180° depuis le canvas source et le met dans l'image temporaire
procedure Feu_180(CanvasSource : TCanvas);
var src,dest : Trect; 
begin
  dest:=bounds(0, 0, 49, 90);
  src:=rect(0, 0, 49, 90); // V flip

  //  dest:=bounds(0, 0, image1.Picture.Width, image1.Picture.Height);
  //src:=rect(0, image1.Picture.Height-1, image1.Picture.Width-1, 0); // Vertical flip

  //src:=rect(image1.Picture.Width-1, 0, 0, image1.Picture.Height-1); // Horizontal flip
  //src:=rect(image1.Picture.Width-1, image1.Picture.Height-1, 0, 0); // Both flip
  PimageTemp.Picture.Bitmap.Canvas.StretchDraw(dest,Formprinc.Image9feux.Picture.Graphic);
  PImageTemp.Picture.Bitmap.Modified:=True; 
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

// provisoire
procedure cercle(ACanvas : Tcanvas;x,y,rayon : integer;couleur : Tcolor);
begin
with PCanvasTCO do
  begin
    brush.Color:=couleur;
    Ellipse(x-rayon,y-rayon,x+rayon,y+rayon);
  end;
end;

// Dessine un feu dans le canvas en x,y , dont l'adresse se trouve à la cellule x,y
procedure dessin_feu(CanvasDest : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
var  x0,y0,orientation,adresse,i,aspect,TailleX,TailleY : integer;
     ImageFeu : Timage;
     frX,frY : real;
begin
  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  
  Orientation:=TCO[x,y].FeuOriente; 
  Adresse:=TCO[x,y].Adresse;
  i:=Index_feu(adresse);
  aspect:=feux[i].aspect;
  
  case aspect of
  2 :  ImageFeu:=Formprinc.Image2feux;
  3 :  ImageFeu:=Formprinc.Image3feux;
  4 :  ImageFeu:=Formprinc.Image4feux;
  5 :  ImageFeu:=Formprinc.Image5feux;
  7 :  ImageFeu:=Formprinc.Image7feux;
  9 :  ImageFeu:=Formprinc.Image9feux;
  else ImageFeu:=Formprinc.Image3feux;
  end;
  
  //ImageFeu:=PointeurImage(adresse); // pointeur vers le type de feu à dessiner
  TailleY:=ImageFeu.picture.BitMap.Height; // 50 taille du feu d'origine  (verticale)
  TailleX:=ImageFeu.picture.BitMap.Width;  //91n
  
  //Facteurs de réductions X et Y pour un signal vertical
  frX:=LargeurCell/TailleX;
  frY:=2*HauteurCell/TailleY;
  //Affiche('FrX='+floatToSTR(frX)+' FrY='+floatToSTR(frY),clyellow);

  // affiche l'icône du signal---------------
  if (Orientation=1) then 
  begin
    //Affiche('Adresse='+intToSTR(Adresse)+' Xfeu='+IntToSTR(X0)+' Yfeu='+intToSTR(y0),clyellow);
    TransparentBlt(canvasDest.Handle,x0,y0,LargeurCell,HauteurCell*2,
                   ImageFeu.Canvas.Handle,0,0,TailleX,TailleY,clBlue);
    PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.
  end;
  if Orientation=2 then 
  begin
    Feu_90G(ImageFeu,x,y); // ici on passe l'origine du feu 
    x0:=x0-largeurCell;
    //Affiche('Adresse='+intToSTR(Adresse)+' Xfeu='+IntToSTR(X0)+' Yfeu='+intToSTR(y0),clyellow);
    // y0:=y0+largeurCell;
  end;  
  if Orientation=3 then 
  begin
    Feu_90D(ImageFeu,x,y);
  end;  

  // écrire le texte ------------------
    with PcanvasTCO do
    begin
      font.Size:=5;
      Brush.Color:=fond;
      Font.Color:=CouleurAdresse;
      if Aspect=9 then TextOut(x0-LargeurCell,y0+8,IntToSTR(Adresse))
      else TextOut(x0+1,y0+8,IntToSTR(Adresse));
    end;  

   
  // allumage des feux du signal -----------------
  (*TailleY:=HauteurCell*2;
  TailleX:=LargeurCell;
  frX:=LargeurCell/TailleX;
  frY:=HauteurCell/TailleY;*)
  case aspect of
    4 : dessine_feu4(canvasDest,x0,y0,frX,frY,etatsignalcplx[adresse],orientation);
    9 : dessine_feu9(canvasDest,x0,y0,frX,frY,etatsignalcplx[adresse],orientation);
  end;
end;

procedure TFormTCO.Efface_Cellule(Canvas : Tcanvas;x,y : integer; couleur : Tcolor;Mode : TPenMode);
var x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,jy1,jy2 : integer;
    r : TRect;
begin
  if y>1 then
  begin
    // si la cellule au dessus contient un feu vertical, ne pas effacer la cellule
    if (tco[x,y-1].BImage=12) and (tco[x,y-1].FeuOriente=1) then exit;
  end;
  if x<NbreCellX then
  begin
    // si la cellule à gauche contient un feu 90D, ne pas effacer la cellule
    if (tco[x-1,y].BImage=12) and (tco[x-1,y].FeuOriente=3) then exit;
  end;              

  x0:=(x-1)*LargeurCell;
  y0:=(y-1)*HauteurCell;
  r:=Rect(x0,y0,x0+LargeurCell,y0+HauteurCell);

  with canvas do
  begin
    Pen.Mode:=mode;
    Pen.color:=clLime;
    Brush.Color:=Fond;
    Brush.style:=bsSolid;
    rectangle(r);
    fillRect(r);
  end;  
end;

// transforme les branches en TCO
// à voir, trop compliqué. Il faudra dessiner son TCO soit meme
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
var Xorg,Yorg,i,btype,Bimage : integer;
    s : string;
begin
  i:=tco[x,y].Adresse;
  btype:=tco[x,y].Btype;
  BImage:=tco[x,y].BImage;
  Xorg:=(x-1)*LargeurCell;
  Yorg:=(y-1)*HauteurCell;
  s:=IntToSTR(i);
  if Btype=2 then s:='A'+s;
  if Btype=3 then s:='A'+s+'B';

  if y>1 then if (tco[x,y-1].Bimage=12) and (tco[x,y-1].FeuOriente=1) then exit;
  
  case Bimage of 
    // ne pas passer la forme ds le paramètre canvas, çà ne s'affichera pas
    //  0 : efface_cellule(PCanvasTCO,x,y,Clyellow,Mode);     &&&&&&&&&
      1 : dessin_AigPD_AD(PCanvasTCO,X,Y,Clyellow,Mode);
      2 : dessin_AigG_PD(PCanvasTCO,X,Y,Clyellow,mode);
      3 : dessin_AigPG_AG(PCanvasTCO,X,Y,Clyellow,mode);
      4 : dessin_AigD_PG(PCanvasTCO,X,Y,Clyellow,Mode);
      5 : dessin_voie(PCanvasTCO,X,Y,Clyellow,Mode);
      6 : dessin_SupG(PCanvasTCO,X,Y,Clyellow,Mode);
      7 : dessin_SupD(PCanvasTCO,X,Y,Clyellow,Mode);
      8 : dessin_infD(PCanvasTCO,X,Y,Clyellow,Mode);
      9 : dessin_infG(PCanvasTCO,X,Y,Clyellow,mode);
     10 : dessin_Diag1(PCanvasTCO,X,Y,Clyellow,mode);
     11 : dessin_Diag2(PCanvasTCO,X,Y,Clyellow,mode);
     12 : dessin_feu(PCanvasTCO,X,Y,Clyellow,mode);
       
     //else entoure_cell(x,y);
  end;

  
  if (BImage>=2) and (BImage<12) and (i<>0) then 
     begin // Adresse de l'élément
      with PCanvasTCO do
       begin
         font.Size:=5;
         Brush.Color:=fond;
         Font.Color:=CouleurAdresse;
         TextOut(xOrg+1,yOrg+1,s);
       end;  
     end
     else  
     if (BImage=1) and (i<>0) then 
     begin // Adresse de l'élément
       with PCanvasTCO do
       begin
         font.Size:=5;
         Brush.Color:=fond;
         Font.Color:=CouleurAdresse;
         TextOut(xOrg+1,yOrg+21,s);
       end;  
     end;
   //canvasTCO.TextOut(xOrg+1,yOrg+1,IntToSTR(x));  
end;

// affiche le tco suivant le tableau TCO
procedure TformTCO.Affiche_TCO ;
var x,y,DimX,DimY : integer;
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
  
  //effacer tout
  with PcanvasTCO do
  begin
    Brush.Color:=clWhite;
    r:=rect(0,0,ImageTCO.Width,ImageTCO.height);
    FillRect(r);      
    Brush.Style:=bsSolid;
    Brush.Color:=fond;
    pen.color:=clyellow;
    r:=rect(0,0,NbreCellX*LargeurCell,NbreCelly*HauteurCell);
    FillRect(r);
  end;

  //afficher les cellules
  for y:=1 to NbreCellY do
    for x:=1 to NbreCellX do
      begin
        affiche_cellule(x,y,PmCopy);
      end;

  // afficher la grille
  grille;    
end;


procedure TFormTCO.FormCreate(Sender: TObject);
begin
  caption:='TCO';
  LargeurCell:=25;
  HauteurCell:=25;
  AvecGrille:=true;
   
  XclicCell:=1;
  YclicCell:=1;
  KeyPreview:=false; // invalide les évènements clavier
  fond:=$202050;
  couleurAdresse:=Cyan;
  xMiniSel:=999;yMiniSel:=999;
  xMaxiSel:=0;yMaxiSel:=0;
  SelectionAffichee:=false;
end;



// clic gauche sur image
procedure TFormTCO.ImageTCOClick(Sender: TObject);
var  Position: TPoint;
begin
  //Entoure_cell(XclicCell,YclicCell);
  GetCursorPos(Position);
 
  Position:=ImageTCO.screenToCLient(Position);
  //Affiche(IntToSTR(position.x),clyellow);
  Xclic:=position.X;YClic:=position.Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  if XclicCell>NbreCellX then exit;   
  if YclicCell>NbreCellY then exit;
  
  
  LabelX.caption:=IntToSTR(XclicCell);  
  LabelY.caption:=IntToSTR(YclicCell);
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);
  EdittypeImage.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BImage);

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
//    FillRect(r);
  end;

end;


procedure TFormTCO.FormActivate(Sender: TObject);
begin
  if not(Forminit) then
  begin
    FormInit:=true;
    lire_fichier_tco;
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
    
    // dessiner les icônes
    dessin_AigPD_AD(ImagePalette1.Canvas,1,1,clyellow,pmCopy);
    dessin_AigG_PD(ImagePalette2.Canvas,1,1,clyellow,pmCopy);
    dessin_AigPG_AG(ImagePalette3.Canvas,1,1,clyellow,pmCopy);
    dessin_AigD_PG(ImagePalette4.Canvas,1,1,clyellow,pmCopy);
    dessin_voie(ImagePaletteDroit.canvas,1,1,Clyellow,pmCopy);
    dessin_SupG(ImageSupG.canvas,1,1,Clyellow,pmCopy);
    dessin_SupD(ImageSupD.canvas,1,1,Clyellow,pmCopy);
    dessin_InfD(ImageInfD.canvas,1,1,Clyellow,pmCopy);
    dessin_infG(ImageInfG.canvas,1,1,Clyellow,pmCopy);
    dessin_Diag1(ImageDiag1.Canvas,1,1,Clyellow,pmCopy);
    dessin_Diag2(ImageDiag2.Canvas,1,1,Clyellow,pmCopy);

    With ImageFeu do
    begin
      Picture.Bitmap.TransparentMode:=tmAuto; 
      Picture.Bitmap.TransparentColor:=clblue;
      Transparent:=true;
      Picture.Bitmap:=Formprinc.Image9feux.Picture.Bitmap;
    end;  
    Affiche_tco;
  end;

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
  LabelX.caption:=IntToSTR(XclicCell);
  LabelY.caption:=IntToSTR(YclicCell);
  label1.caption:='clicContext';
  XclicCellInserer:=XClicCell;
  YclicCellInserer:=YClicCell;
  //Entoure_cell(XclicCellInserer,YclicCellInserer);
  
  //Affiche('XClicCell='+intToSTR(XclicCell)+' '+'YClicCell='+intToSTR(YclicCell),clyellow);
end;

// menu droit "clic aiguillage G PG"
procedure TFormTCO.aiguillageG_PGClick(Sender: TObject);
var  Position: TPoint;
begin
  // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_AigPG_AG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);

end;

// menu droit "clic aiguillage D PD"
procedure TFormTCO.aiguillageD_PDClick(Sender: TObject);
var  Position: TPoint;
begin
   // effacer le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_AigPD_AD(ImageTCO.Canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);

end;


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
  tco[XClicCellInserer,YClicCellInserer].Btype:=1;
  // effacer le carré pointeur 
  //Entoure_cell(XclicCell,YclicCell);
  // dessine le dessin
  dessin_AigD_PG(ImageTCO.canvas,XClicCellInserer,YClicCellInserer,clyellow,pmCopy);
  // remet le carré pointeur
  //Entoure_cell(XclicCell,YclicCell);

  EditAdrElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].Adresse);
  EdittypeElement.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BType);
  
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

procedure TFormTCO.ImagePalette1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ImagePalette1.BeginDrag(true);
end;

procedure TFormTCO.ImagePalette1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigPD_AD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=2;  // aiguillage
  tco[XClicCell,YClicCell].BImage:=1;  // image 1

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);  
end;



procedure TFormTCO.ImagePalette2EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigG_PD(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
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
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigPG_AG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
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
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_AigD_PG(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
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
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_voie(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=1;  // voie
  tco[XClicCell,YClicCell].BImage:=5;  // image 5
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

procedure TFormTCO.ImageInfGEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  if (x=0) and (y=0) then exit;
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

procedure TFormTCO.ButtonSauveTCOClick(Sender: TObject);
begin
  sauve_fichier_tco;
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

// supprimer la sélection
procedure TFormTCO.MenuCouperClick(Sender: TObject);
var  Position: TPoint;
     r : Trect;
     x0,y0,x,y,XCell1,YCell1,xCell2,yCell2 : integer;
begin
  if not(SelectionAffichee) then exit;

  copier;

  SelectionAffichee:=false;

  xCell1:=XminiSel div LargeurCell +1;
  xCell2:=XmaxiSel div LargeurCell +1;
  yCell1:=yminiSel div HauteurCell +1;
  yCell2:=ymaxiSel div HauteurCell +1;
  
  for y:=yCell1 to yCell2 do
    for x:=xCell1 to xCell2 do
    begin
      tco[x,y].BType:=0;
      tco[x,y].Adresse:=0;
      tco[x,y].BImage:=0;
      //Affiche('Efface cellules '+IntToSTR(X)+' '+intToSTR(y),clyellow);
      efface_cellule(ImageTCO.Canvas,X,Y,Clyellow,PmCopy);
      
    end;

end;

procedure TFormTCO.ImageTCOMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var position : Tpoint;
begin
    if button=mbLeft then
    begin
      xMiniSel:=999;yMiniSel:=999;
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
  EdittypeImage.Text:=IntToSTR(tco[XClicCellInserer,YClicCellInserer].BImage);
      
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
end;

procedure TFormTCO.ImageTCOMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Affiche('MouseUp',clyellow);
  sourisclic:=false;
  
end;



procedure TFormTCO.MenuCopierClick(Sender: TObject);
begin
  copier;
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
  
end;

procedure TFormTCO.ButtonRedessineClick(Sender: TObject);
begin
  Affiche_TCO;
end;

procedure TFormTCO.EditAdrElementChange(Sender: TObject);
var Adr,erreur : integer;
begin
  Val(EditAdrElement.Text,Adr,erreur);
  if (erreur<>0) or (Adr<0) or (Adr>2048) then 
  begin
    EditAdrElement.text:=intToSTR(tco[XClicCell,YClicCell].Adresse);
    exit;
  end;  
  tco[XClicCell,YClicCell].Adresse:=Adr;
  affiche_cellule(XClicCell,YClicCell,pmCopy);
end;


procedure TFormTCO.EditTypeImageKeyPress(Sender: TObject; var Key: Char);
var Bimage,erreur : integer;
begin
  if ord(Key) = VK_RETURN then
  begin
    Key := #0; // prevent beeping
    Val(EditTypeImage.Text,Bimage,erreur);
   // Affiche(IntToSTR(bimage),clyellow);
    if (erreur<>0) or (Bimage<0) or (Bimage>11) then 
    begin
      EditTypeImage.text:=intToSTR(tco[XClicCell,YClicCell].BImage);
      exit;
    end;  
    tco[XClicCell,YClicCell].Bimage:=Bimage;
    case Bimage of
    // aiguillages
    1,2,3,4 : tco[XClicCell,YClicCell].Btype:=2;
    // détecteur ou voie
    5 : tco[XClicCell,YClicCell].Btype:=1;
    else tco[XClicCell,YClicCell].Btype:=0;
    end;
    
    EditTypeElement.text:=intToSTR(tco[XClicCell,YClicCell].Btype);
    affiche_cellule(XClicCell,YClicCell,pmCopy);
  end;
end;

procedure TFormTCO.Maj_TCO(Adresse : integer;etat : boolean);
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
   Detecteur[513]:=true;
   Maj_tco(513,true);
   with PCanvasTCO do
   begin
    pen.Mode:=pmCopy;
    pen.color:=clRed;
    brush.color:=clGreen;
    Rectangle(2,2,140,140);
   end;  
end;

procedure TFormTCO.Button2Click(Sender: TObject);
begin
   Detecteur[513]:=false;
   Maj_tco(513,false);
end;

procedure TFormTCO.ImageDiag1EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if (x=0) and (y=0) then exit;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  dessin_Diag1(ImageTCO.Canvas,XClicCell,YClicCell,Clyellow,pmCopy);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=10;  // image 10
  tco[XClicCell,YClicCell].Adresse:=0;  

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
begin
  if (x=0) and (y=0) then exit;
  Xclic:=X;YClic:=Y;
  XclicCell:=Xclic div largeurCell +1;
  YclicCell:=Yclic div hauteurCell +1;
  //PCanvasTCO.Draw((xClicCell-1)*LargeurCell,(yClicCell-1)*HauteurCell,ImageFeu.Picture.Bitmap);
  tco[XClicCell,YClicCell].BType:=0;  // rien
  tco[XClicCell,YClicCell].BImage:=12;  
  tco[XClicCell,YClicCell].Adresse:=0;
  tco[XClicCell,YClicCell].FeuOriente:=1;
  
  Affiche(IntToSTR(XclicCell),clyellow);
  Affiche(IntToSTR(YclicCell),clyellow);
    
  TransparentBlt(PcanvasTCO.Handle,(xClicCell-1)*LargeurCell,(yClicCell-1)*HauteurCell,LargeurCell,HauteurCell*2,Formprinc.Image9feux.Canvas.Handle,0,0,
             Formprinc.Image9feux.Picture.Bitmap.Width,Formprinc.Image9feux.Picture.Bitmap.Height,clBlue);
  PImageTCO.Picture.Bitmap.Modified:=True;  // rafraichit l'affichage sinon le stretchblt n'apparaît pas.

  EditAdrElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Adresse);
  EdittypeElement.Text:=IntToSTR( tco[XClicCell,YClicCell].Btype);
  EdittypeImage.Text:=IntToSTR(tco[XClicCell,YClicCell].BImage);
end;



procedure TFormTCO.ImageFeuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ImageFeu.BeginDrag(true);
end;

 
procedure TFormTCO.Tourner90GClick(Sender: TObject);
var BImage,aspect,adresse : integer;
    ImageFeu : TImage;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>12 then exit; 
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  ImageFeu:=PointeurImage(adresse);

  TCO[XClicCell,YClicCell].FeuOriente:=2;  // feu orienté à 90° gauche
  // effacer le feu
  Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,clred,PmCopy);

  Feu_90G(ImageFeu,XClicCell,YclicCell);
  Efface_cellule(PCanvasTCO,xClicCell,yClicCell+1,clred,PmCopy);  // efface la partie basse du feu vertical
end;

procedure TFormTCO.Tourner90DClick(Sender: TObject);
var BImage ,aspect,adresse : integer;
    ImageFeu : TImage;
begin
  BImage:=TCO[XClicCell,YClicCell].Bimage;
  if Bimage<>12 then exit; 
  adresse:=TCO[XClicCell,YClicCell].Adresse;
  ImageFeu:=PointeurImage(adresse);
  
  TCO[XClicCell,YClicCell].FeuOriente:=3;  // feu orienté à 90° droit
  // effacer le feu
  Efface_Cellule(PCanvasTCO,xClicCell,yClicCell,clred,PmCopy);
 
  Feu_90D(ImageFeu,XClicCell,YclicCell);
  Efface_cellule(PcanvasTCO,xClicCell,yClicCell+1,clred,PmCopy);  // efface la partie basse du feu vertical

end;


end.
