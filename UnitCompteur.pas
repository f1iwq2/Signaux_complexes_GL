unit UnitCompteur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math, ComCtrls, Menus, Unitprinc ;

const
pisur180=pi/180;
NbreCompteurs=10;

type
  TFormCompteur = class(TForm)
    ImageCompteur: TImage;
    TrackBarC: TTrackBar;
    PopupMenu1: TPopupMenu;
    Verrouillerdevant1: TMenuItem;
    Dverrouiller1: TMenuItem;
    N1: TMenuItem;
    Compteurdevitesse11: TMenuItem;
    Compteurdevitesse21: TMenuItem;
    Compteurtachro1: TMenuItem;
    Labeltrain: TLabel;
    Button0: TButton;
    ImageTprov: TImage;
    N2: TMenuItem;
    Affichericonedutrain1: TMenuItem;
    ImageTrain: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Dverrouiller1Click(Sender: TObject);
    procedure Verrouillerdevant1Click(Sender: TObject);
    procedure Compteurdevitesse11Click(Sender: TObject);
    procedure Compteurdevitesse21Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Compteurtachro1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarCChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button0Click(Sender: TObject);
    procedure Affichericonedutrain1Click(Sender: TObject);
  private
    { Déclarations privées }
    protected
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;  // détecte fin de redimensionnement fenêtre
    //procedure WMNCPaint(var Mes : TWMNCPaint); message WM_NCPAINT;
  public
    { Déclarations publiques }
  end;

type
   typ=(fen,gb,im);
   TTcompteur=array[1..10] of record
      FcBitMap : Tbitmap;
      paramcompt : TparamCompt;
  end;

var
  formCompteur : array[1..10] of TformCompteur;
  Scompteur,CompteurPP :  TTCompteur;
  ParamCompteur : array[1..3] of record
    coulAig,coulGrad,CoulNum,CoulFond,CoulArc : tcolor;
  end;

  VerrouilleCompteur,affTrainCompteur : boolean;
  LargeurCompteurs,HauteurCompteurs,LargComptC,HautComptC : integer;
  couleurTete : tcolor;


Procedure Init_compteur(i : integer;c : Tcomponent);
procedure aiguille_compteur(c,idTrain : integer;comp : Tcomponent);
procedure dessin_fond_compteur(var param : TparamCompt;i: integer ; Im : tbitmap;typCompt : integer);
procedure position_compteur;
procedure affiche_train_compteur(c : integer);

implementation

uses  UnitTCO, UnitClock , UnitConfig;

{$R *.dfm}

// ne pas utiliser - essai
procedure affiche_caption(s : string);
var
  ACanvas : TCanvas;
  l,h : integer;
begin
  l:=formCompteur[1].Width-40;
  h:=30;
  ACanvas:=TCanvas.Create;
  try
    ACanvas.Handle:=GetWindowDC(FormCompteur[1].Handle);
    with ACanvas do
    begin
     // Brush.Color := couleurTete;
      Font.Name:='Arial';
      Font.Size:=12;
      Font.Color:=clCaptionText;
      Font.Style:=[fsBold];

      FillRect(rect(2,2,l,h));
      Textout(8,6,s);
    end;
  finally
    ReleaseDC(FormCompteur[1].Handle, ACanvas.Handle);
    ACanvas.Free;
  end;
end;

// affiche le nom du train dans le compteur
procedure affiche_train_compteur(c : integer);
var s : string;
    larg,haut : integer;
begin
  if idTrainClic<0 then exit;
  s:=trains[IdTrainClic].nom_train;
  with FormCompteur[c] do
  begin
    caption:=s;
    if affTrainCompteur then
    begin
      //Affiche(intToSTR(Imagetrain.Picture.Width),clYellow);
      larg:=Maj_icone_train(ImageTProv,IdTrainClic,clWhite);
      haut:=ImageTProv.height;
      ImageTrain.Width:=larg;
      ImageTrain.Height:=haut;
      ImageTrain.canvas.copyrect(rect(0,0,larg,haut),ImageTprov.canvas,rect(0,0,larg,haut));

      //Affiche(intToSTR(larg)+'x'+intToSTR(haut),clYellow);
      ImageTrain.left:=ImageCompteur.Picture.Width-larg;
    end;
    LabelTrain.caption:=s;
  end;
end;

// event fin de redimensionnement
procedure TFormCompteur.WMExitSizeMove(var Message: TMessage);
begin
  inherited;
  //Affiche('ExitSizeMove '+IntToSTR(Message.Msg)+' '+inTtOstr(message.WParam)+' '+intToSTR(message.LParam)+' '+intToSTR(message.WParamLo),clred);
  LargeurCompteurs:=formCompteur[1].Width;   // nouvelle largeur
  init_compteur(1,formcompteur[1]);
  affiche_train_compteur(1);
end;


// change l'aiguille du compteur
// c : du compteur     idTrain : index du train
procedure aiguille_compteur(c,idTrain : integer ; comp : Tcomponent);
var ComptLoc,x1,y1,x2,y2,x3,y3,x4,y4,vitesse,vitesseFin,lim,him : integer;
    angleDeb,AngleFin,sinD,cosD,sinF,cosF : extended ;
    canvDest :tcanvas;
    param : Tparamcompt;
    typDest : typ;
begin
  if compteur<1 then exit;

  if comp is tform then typDest:=fen;
  if comp is tgroupBox then typDest:=gb;
  if comp is tImage then typDest:=im;

  if idTrain<>0 then
  begin
    // détermine début et fin de l'arc vert
    vitesse:=abs(trains[idTrain].VitesseCompteur);  // vitesse en cours
    vitesseFin:=abs(trains[idTrain].vitesseCons);   // vitesse consigne
  end
  else
  begin
    vitesse:=0;
    VitesseFin:=0;
  end;

  // convertir les vitesses instantanées et fin en angles par
  // la formule angle=A.vitesse+b
  if typdest=fen then
  begin
    ComptLoc:=compteur;   // type de compteur 1 2 ou 3
    param:=Scompteur[c].paramcompt;
    canvDest:=formCompteur[c].ImageCompteur.Canvas;
  end;
  if typdest=gb then
  begin
    ComptLoc:=compteur;
    param:=CompteurT[c].paramcompt;
    canvDest:=compteurT[c].Img.Canvas;
  end;
  if typdest=im then
  begin
    ComptLoc:=formconfig.ComboBoxCompt.ItemIndex+1;
    param:=paramcomptIm;
    canvDest:=formconfig.ImageCtC.Canvas;
  end;

  with param do
  begin
    angleDeb:=ComptA*vitesse+comptB;
    angleFin:=ComptA*vitesseFin+comptB;
    lim:=imgL;
    Him:=imgH;
  end;

  sincos(angleDeb*pisur180,sinD,cosD);

  //Affiche('Ad,Af='+floatToSTR(AngleDeb)+' '+floatToSTR(AngleFin),clred);

  with canvDest do
  begin
    // copie le fond du compteur

    if typdest=fen then copyrect(rect(0,0,lim,him),Scompteur[c].FcBitMap.canvas,rect(0,0,lim,him));
    if typdest=gb then copyrect(rect(0,0,lim,him),compteurT[c].FcBitMap.canvas,rect(0,0,lim,him));
    if typdest=im then copyrect(rect(0,0,lim,him),FbmcompC.canvas,rect(0,0,lim,him));

    //moveto(0,0);lineTo(200,200);
    // afficher l'arc vert
    with param do
    begin
      pen.mode:=pmCopy;
      pen.width:=round(4*redX);
      if (vitesse<>0) and (angleDeb<>angleFin) then
      begin
        x1:=AigCX - rav;
        y1:=AigCY - rav;
        x2:=AigCX + rav;
        y2:=AigCY + rav;
        x3:=AigCX + Round(rav*sinD);
        y3:=AigCY - Round(rav*cosD);
        sincos(AngleFin*pisur180,sinF,cosF);  // paramètres d'angleFin
        x4:=AigCX + Round(rav*sinF);
        y4:=AigCY - Round(rav*cosF);
        pen.color:=ParamCompteur[comptloc].coulArc;
        if angleDeb>=angleFin then setArcDirection(Handle,AD_COUNTERCLOCKWISE) else setArcDirection(Handle,AD_CLOCKWISE) ;
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;

      // Afficher l'aiguille (angleDeb)
      pen.color:=ParamCompteur[comptloc].coulAig;
      MoveTo(AigCX,AigCY);
      LineTo(round(rAig*sinD)+AigCX,round(-rAig*cosD)+AigCY);
    end;
  end;
end;

procedure compteur_2(c : integer;bm : tbitmap;param : tparamcompt);
var l,av,n,v,rayon2,rayon3,rayon4,x1,y1,x2,y2,xt,yt,lim,him,rg : integer;
    angle,angleFin,incr,r,a : single;
    s : string;
begin
  angle:=10;     // angle début des graduations
  angleFin:=170;  // angle fin des graduations
  incr:=2.5;      // incrément d'angle en ° des graduations
  n:=0;
  v:=0;
  lim:=bm.Width;
  him:=bm.height;

  with param do
  begin
    //AigCX:=him div 2;               // centre aiguille
    //AigCY:=round(200*param.redY);
    r:=redx;                        // réduction
    //Raig[1]:=(Lim div 2)-round(10*r);  // rayon
    rg:=round(AigCX/1.05);            // rayon des graduations
    rayon2:=Rg-round(10*r);              // rayon de fin des graduations
    rayon3:=Rg-round(20*r);
    rayon4:=Rg-round(20*r);              // chiffres

    with bm.Canvas do
    begin
      pen.width:=1;
      pen.Color:=ParamCompteur[2].coulGrad;
      Brush.Color:=ParamCompteur[2].coulFond;
      brush.style:=bssolid;   // pour effacer
      FillRect(Rect(0,0,lim,him));

      Brush.Color:=ParamCompteur[2].coulFond;


      Cercle(bm.canvas,AigCX,AigCY,round(10*r),clBlack,clBlack);

      font.Name:='Arial';;
      font.color:=ParamCompteur[2].CoulNum;
      font.size:=round(r*20);
      font.style:=[fsbold];
    end;

    // dessine le cadran
    repeat
      // affiche les chiffres
      if n mod 10=0 then
      begin
        // pour centrer le chiffre de vitesse sur l'axe de la graduation
        // affiche les chiffres
        case v of
         0 : begin xt:=round(30*r);yt:=round(160*r);s:='0';end;
         1 : begin xt:=round(60*r);yt:=round(100*r);s:='20';end;
         2 : begin xt:=round(110*r);yt:=round(55*r);s:='40';end;
         3 : begin xt:=round(170*r);yt:=round(35*r);s:='60';end;
         4 : begin xt:=round(240*r);yt:=round(40*r);s:='80';end;
         5 : begin xt:=round(280*r);yt:=round(80*r);s:='100';end;
         6 : begin xt:=round(310*r);yt:=round(130*r);s:='120';end;
         //7 : begin xt:=round(300*r);yt:=round(100*r);s:='140';end;
        end;

       //bm.Canvas.brush.Style:=bsClear;
       bm.canvas.Brush.Style:=bsclear;  // pour transparent de la fonte
       bm.canvas.Textout(xt,yt,s);
       inc(v);
      end;

      x1:=round(cos((angle+180)*pisur180)*Rg)+AigCX;
      y1:=round(sin((angle+180)*pisur180)*Rg)+AigCY;
      // gros traits
      if n mod 5 = 0 then
      begin
        bm.canvas.pen.Width:=round(4*r);
        x2:=round(cos((angle+180)*pisur180)*rayon3)+AigCX;
        y2:=round(sin((angle+180)*pisur180)*rayon3)+AigCY;
      end
      else
      begin
        // traits fins
        bm.canvas.pen.Width:=round(2*r);
        x2:=round(cos((angle+180)*pisur180)*rayon2)+AigCX;
        y2:=round(sin((angle+180)*pisur180)*rayon2)+AigCY;
      end;

      with bm.canvas do
      begin
        Brush.Style:=bsSolid;
        pen.color:=ParamCompteur[2].coulGrad;
        MoveTo(x1,y1);
        lineTo(x2,y2);
      end;
      inc(n);
      angle:=angle+incr;       // 18
    until angle>AngleFin+incr;
  end;
end;

procedure compteur_tachro(c : integer;bm : tbitmap;param : tparamcompt);
var l,av,n,v,rayon2,rayon3,rayon4,x1,y1,x2,y2,xt,yt,lim,him,rg : integer;
    angle,angleFin,incr,r,a : single;
    s : string;
begin
  angle:=-40;     // angle début des graduations
  angleFin:=220;  // angle fin des graduations
  incr:=2.5;      // incrément d'angle en ° des graduations
  n:=0;
  v:=0;

  with param do
  begin
    lim:=ImgL;
    him:=ImgH;
    AigCX:=lim div 2;      // centre aiguille
    AigCY:=round(200*redY);

    r:=lim/400;            // réduction
    rg:=round(AigCX/1.07);            // rayon des graduations
    rayon2:=Rg-round(10*r);           // rayon de fin des graduations
    rayon3:=Rg-round(20*r);           // rayon des grands traits
    rayon4:=Rg-round(16*r);           // chiffres

    with Bm.Canvas do
    begin
      pen.width:=1;
      pen.Color:=ParamCompteur[3].coulfond;
      Brush.Color:=ParamCompteur[3].coulfond;
      Brush.Style:=bsSolid;
      FillRect(Rect(0,0,lim,him));
    end;

    Cercle(bm.Canvas,AigCX,AigCY,round(130*r),clGray,ParamCompteur[3].CoulFond);
    Cercle(bm.Canvas,AigCX,AigCY,round(10*r),clwhite,clWhite);

    with bm.Canvas do
    begin
      font.Name:='Arial';
      brush.color:=clBlack;
      pen.color:=ParamCompteur[3].coulgrad;
      font.color:=ParamCompteur[3].CoulNum;
      font.size:=round(r*20);
      //Affiche(intToSTR(font.size),clred);
      font.style:=[fsbold];
    end;

    // dessine le cadran
    repeat
     // affiche les chiffres
     if n mod 10=0 then
     begin
       s:=intToSTR(round(v));
       // pour centrer le chiffre de vitesse sur l'axe de la graduation
       a:=(bm.Canvas.TextWidth(s) div 2)/rayon4;
       if abs(a)>1 then a:=1;
       a:=arcSin(a);
       l:=round(a*180/pi);
       //Affiche(intToSTR(l),clYellow);
       xt:=round(cos((angle+180-l)*pisur180)*rayon4)+AigCX;
       yt:=round(sin((angle+180-l)*pisur180)*rayon4)+AigCY;

       // affiche les chiffres
       {$IF CompilerVersion >= 28.0}
       av:=round(90-angle)*10;
       bm.canvas.font.orientation:=av;
       bm.canvas.Textout(xt,yt,s);
       {$ELSE}
       av:=10+round(90-angle)*10;
       AffTexteIncliBordeTexture(bm.Canvas,xt,yt,bm.Canvas.font,clYellow,0,pmcopy,s,av);
       {$IFEND}

       inc(v,20);
     end;

     x1:=round(cos((angle+180)*pisur180)*Rg)+AigCX;
     y1:=round(sin((angle+180)*pisur180)*Rg)+AigCY;
     // gros traits
     if n mod 5 = 0 then
     begin
       bm.Canvas.pen.Width:=round(4*r);
       x2:=round(cos((angle+180)*pisur180)*rayon3)+AigCX;
       y2:=round(sin((angle+180)*pisur180)*rayon3)+AigCY;
     end
     else
     begin
       // traits fins
       bm.Canvas.pen.Width:=round(2*r);
       x2:=round(cos((angle+180)*pisur180)*rayon2)+AigCX;
       y2:=round(sin((angle+180)*pisur180)*rayon2)+AigCY;
     end;

     with bm.Canvas do
     begin
       MoveTo(x1,y1);
       lineTo(x2,y2);
     end;
     inc(n);
     angle:=angle+incr;       // 18
    until angle>AngleFin+incr;
  end;

  //lim:=formCompteur[c].ImageTachro.width;
  //him:=formCompteur[c].ImageTachro.height;
  lim:=param.ImgL;
  him:=param.ImgH;

  // copie l'image du texte "tachro" mise à l'échelle
  StretchBlt(bm.Canvas.Handle,round(145*r),round(85*r),round(lim*r),round(him*r),
             FormPrinc.ImageTachro.canvas.Handle,0,0,lim,him,srcCopy);
end;


// dessine dans le FbitMap
// le var est obligatoire
// typecompt : type du compteur 1 2 ou 3
procedure dessin_fond_compteur(var param : TparamCompt;i: integer ; Im : tbitmap;typCompt : integer);
var lim,him : integer;
begin
  lim:=param.ImgL;
  him:=param.ImgH;

  with Im.Canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=$141414; //$e0e0e0;

    font.name:='arial';
    font.Style:=[fsBold];

    // le compteurs 1  provient de bitmaps
    // le compteur 2 et 3 sont dessinés par
    with param do
    begin
      case typCompt of
      1 : begin
          // le compteur 1 provient d'une image
          StretchDraw(rect(0,0,Lim,Him),Formprinc.ImageCompteur1.Picture.Bitmap);
          Brush.Style:=bsSolid;
          Brush.Color:=$1F1A17;
          font.color:=ParamCompteur[1].CoulNum;
          font.size:=round(redx*10);
          TextOut(round(50*redX),round(128*redY),'0');
          TextOut(round(36*redX),round(90*redY),'20');
          TextOut(round(50*redX),round(54*redY),'40');
          TextOut(round(90*redX),round(36*redY),'60');
          TextOut(round(129*redX),round(53*redY),'80');
          TextOut(round(137*redX),round(91*redY),'100');
          TextOut(round(126*redX),round(126*redY),'120');
          // centre de l'aiguille
          AigCX:=round(98*redX);
          AigCY:=round(96*redY);
          rAig:=round(AigCX / 1.5);
          end;
      2 : begin
            // centre de l'aiguille et longueur
            AigCX:=lim div 2;
            AigCY:=round(200*redY);
            rAig:=round(AigCX/1.07);
            // le compteur 2 est dessiné
            compteur_2(i,im,param);
          end;
      3 : begin
            // centre de l'aiguille et longueur
            AigCX:=lim div 2;
            AigCY:=round(200*redY);
            rAig:=round(AigCX/1.07);
            // le compteur tachro est dessiné
            compteur_tachro(i,im,param);
          end;
        end;
      end;
  end;
end;

Procedure Init_compteur(i : integer;c : Tcomponent);
const ofs=30; // décalage entre la taille de l'image et de la fenetre
     // compteurs fenetre principale
      HautTb=10;  // hauteur trackbar
      ofsGBH=15;  // marge haut du groupbox
      ofsGBB=8;  // marge bas du groupbox

var comptLoc,l,h,lim,him,hfen,mini,maxi,vmax : integer;
    typDest : typ;
    r : single;
    image : timage;
    canv : tcanvas;
begin
  if (i<1) or (hautComptC=0) then exit;
  //Affiche('Init compteur de vitesse',clYellow);

  if c is tform then typDest:=fen;  // si le compteur est la fenetre, sinon le groupBox de la fenetre principale
  if c is tGroupBox then typDest:=gb;
  if c is tImage then typDest:=im;

  if (typDest=fen) or (typDest=gb) then ComptLoc:=compteur;
  if typDest=im then ComptLoc:=formconfig.ComboBoxCompt.ItemIndex+1;

  case ComptLoc of
    1 :
    begin
      mini:=-135;
      maxi:=152;
      vmax:=127;
      l:=formPrinc.ImageCompteur1.width;
      h:=formPrinc.ImageCompteur1.height;
    end;
    2 :
    begin
      mini:=-80;           // le 0 est à mini degrés
      maxi:=120;            // le vmax est à max degrés
      vmax:=160;           // vmax du compteur
      l:=400;
      h:=215;
    end;
    3 :
    begin
      mini:=-130;           // le 0 est à mini degrés
      maxi:=132;            // le vmax est à max degrés
      vmax:=210;           // vmax du compteur
      l:=400;
      h:=340;
    end;
  end;

  // fixer la largeur de la fenêtre
  if typDest=fen then
  begin
    Lim:=LargeurCompteurs-ofs;
    //p:=Scompteur[i].paramcompt;
    formCompteur[i].Width:=LargeurCompteurs;
    Scompteur[i].paramcompt.ComptA:=(maxi-mini)/vmax; // pente de conversion vitesse en degrés compteur
    Scompteur[i].paramcompt.ComptB:=mini;             // coordonnées origine conversion
  end;
  if typDest=gb then
  begin
    compteurT[i].paramcompt.ComptA:=(maxi-mini)/vmax;
    compteurT[i].paramcompt.ComptB:=mini;
  end;
  if typDest=im then
  begin
    paramcomptIm.ComptA:=(maxi-mini)/vmax;
    paramcomptIm.ComptB:=mini;
  end;

  r:=h/l;

  if l>=h then
  begin
    him:=round(lim*r);  // hauteur image
    //Affiche('Lim him = '+IntToSTR(lim)+' '+intToSTR(him),clLime);
    //Affiche('L h = '+IntToSTR(l)+' '+intToSTR(h),clLime);
  end
  else
  begin
    him:=round(h*largeurCompteurs/l);  // a revoir
    Affiche('non traité 6',clred);
  end;

  if typDest=fen then
  begin
    formCompteur[i].ImageCompteur.width:=Lim;
  end;
  if typDest=gb then
  begin
    //Lim:=compteurT[i].gb.Width-10-round(CompteurT[i].tb.Height/r);
    //him:=round(lim*r);
    if l>h then
    begin
      lim:=LargComptC-10;
      him:=round(lim*r);
    end
    else
    begin
      him:=HautComptC-ofsGBH-CompteurT[i].tb.Height-ofsGBB;
      lim:=round(him/r);
    end;
    //p:=compteurT[i].paramcompt;
    with CompteurT[i] do
    begin
      gb.Width:=LargComptC;
      gb.height:=ofsGBH+him+CompteurT[i].tb.Height+ofsGBB;
      gb.Top:=(gb.Height+5)*((i-1) div NbreCompteursPLigne);
      gb.left:=(LargComptC+5)*((i-1) mod (NbreCompteursPLigne));
      Img.height:=HautComptC;
      paramCompt.ImgL:=lim;
      paramCompt.imgH:=him; //HautCompt-HautTb-ofsGBH-ofsGBB;
      Img.picture.Bitmap.Width:=lim;
      Img.picture.Bitmap.Height:=him; //HautCompt-HautTb-ofsGBH-ofsGBB;
    end;
  end;

  if typDest=fen then
  begin
    Scompteur[i].paramcompt.redX:=Lim/l;
    Scompteur[i].paramcompt.redY:=Him/h;
    Scompteur[i].paramcompt.ImgL:=Lim;
    Scompteur[i].paramcompt.ImgH:=Him;

    case compteur of
    1 : Scompteur[i].paramcompt.rav:=round(70*Scompteur[i].paramcompt.redx);  // rayon de l'arc vert
    2 : Scompteur[i].paramcompt.rav:=round(100*Scompteur[i].paramcompt.redx);
    3 : Scompteur[i].paramcompt.rav:=round(122*Scompteur[i].paramcompt.redx);
    end;
  end;
  if typDest=gb then
  begin
    with compteurT[i] do
    begin
      paramcompt.redX:=Lim/l;
      paramcompt.redY:=Him/h;
      paramcompt.ImgL:=Lim;
      paramcompt.ImgH:=Him;
      tb.Top:=him+ofsGBH;    // position de la trackbar
      tb.Width:=lim;
      bouton.Top:=tb.Top-12;
      bouton.left:=(lim div 2)-6;
      bouton.Width:=16;
    end;

    case compteur of
    1 : compteurT[i].paramcompt.rav:=round(70*compteurT[i].paramcompt.redx);  // rayon de l'arc vert
    2 : compteurT[i].paramcompt.rav:=round(100*compteurT[i].paramcompt.redx);
    3 : compteurT[i].paramcompt.rav:=round(122*compteurT[i].paramcompt.redx);
    end;
  end;

  if typDest=fen then
  with formCompteur[i] do
  begin
    if VerrouilleCompteur then Left:=formprinc.Left+formprinc.Width-width;

    // ajuster hauteur de la fenetre
    Hfen:=him+trackBarC.height;
    if affTrainCompteur then Hfen:=Hfen+ImageTrain.Height+45 else
    Hfen:=Hfen+LabelTrain.Height+40;
    height:=hfen;
    Scompteur[i].paramcompt.ImgL:=Lim;
    Scompteur[i].paramcompt.ImgH:=Him;

    with ImageCompteur do
    begin
      Width:=Lim;
      Height:=Him;
      Picture.Bitmap.Width:=Lim;
      Picture.Bitmap.Height:=Him;
    end;
    with trackbarC do
    begin
      top:=him+ImageCompteur.Top;
      width:=lim-2;
      Left:=0;
      visible:=true;
    end;
    with labelTrain do
    begin
      top:=trackbarC.Top+TrackBarC.Height;
      left:=0;
    end;
    with button0 do
    begin
      top:=ImageCompteur.height-button0.height;//trackbarC.Top+TrackBarC.Height;
      left:=(lim div 2)-(width div 2);
    end;
    With ImageTprov do
    begin
      left:=0;
      width:=lim-2;
    end;
    With ImageTrain do
    begin
      top:=trackbarC.Top+TrackBarC.Height;
      left:=2;
      visible:=affTrainCompteur;
    end;

    // imageC <-- FCBitMap (on écrit les vitesses) <- ImageCompteur (grande)
    // créer un bitmap réduit qui sert de référence
    Scompteur[i].FCBitMap.Free;
    Scompteur[i].fcBitMap:=tbitmap.Create;
    with Scompteur[i].FCBitMap do
    begin
      Width:=lim;
      Height:=him;
    end;
  end;
  if typDest=gb then
  begin
    //p:=compteurT[i].paramcompt;
    compteurT[i].FCBitMap.Free;
    compteurT[i].fcBitMap:=tbitmap.Create;
    with compteurT[i].FCBitMap do
    begin
      Width:=lim;
      Height:=him;
    end;
  end;

  // image onglet config compteur
  if typdest=im then
  begin
    image:=c as tImage;
    lim:=Image.Width;
    if l>h then
    begin
      him:=round(lim*r);
    end
    else
    begin
      him:=round(lim*r);
      lim:=round(him/r);
    end;

    Image.Width:=lim;
    Image.Height:=him;

    paramcomptIm.redX:=Lim/l;
    paramcomptIm.redY:=Him/h;
    paramcomptIm.ImgL:=Lim;
    paramcomptIm.ImgH:=Him;
    i:=formconfig.ComboBoxCompt.Itemindex+1;
    case i of
    1 : paramcomptIm.rav:=round(70*paramcomptIm.redx);  // rayon de l'arc vert
    2 : paramcomptIm.rav:=round(100*paramcomptIm.redx);
    3 : paramcomptIm.rav:=round(122*paramcomptIm.redx);
    end;
    FbmcompC.Width:=lim;
    FbmcompC.height:=him;
    canv:=formconfig.ImageCtC.Canvas;//   Picture.Bitmap.Canvas;

    dessin_fond_compteur(paramcomptIm,1,FbmcompC,i);
    Aiguille_compteur(1,1,formconfig.ImageCTC);
    exit;
  end;

  // dessine le fond du compteur dans le FcBitmap (non visible)
  if typDest=fen then
  begin
    dessin_fond_compteur(Scompteur[i].paramcompt,i,Scompteur[i].FcBitmap,compteur);
    //canv:=formCompteur[i].ImageCompteur.Canvas;
    Aiguille_compteur(i,IdTrainClic,formCompteur[i]);
    Affiche_train_compteur(i);
  end;
  if typDest=gb then
  begin
    dessin_fond_compteur(compteurT[i].paramcompt,i,compteurT[i].fcBitmap,compteur);
    //canv:=compteurT[i].Img.Canvas;
    Aiguille_compteur(i,i,compteurT[i].gb);
  end;

  if typDest=im then Aiguille_compteur(i,i,formconfig.ImageCTC);
end;

// repositionne le compteur principal
procedure position_compteur;
begin
  if not(Verrouillecompteur) then exit;
  if formCompteur[1]=nil then exit;
  with formCompteur[1] do
  begin
    Left:=formprinc.Left+formprinc.Width-width-2;
    //left:=0;
  end;
  if (formClock<>nil) and not(fermeSC) then
  begin
    if FormClock.Showing then
    formCompteur[1].top:=formclock.top-formCompteur[1].height
      else
    formCompteur[1].top:=FormPrinc.top+formprinc.PageControl.top+100;
  end;
  //Affiche(intToSTR(formCompteur[1].top),clYellow);
end;


procedure TFormCompteur.FormActivate(Sender: TObject);
begin
  //Affiche('FormCompteur activate',clyellow);
  if VerrouilleCompteur then position_compteur;
end;

procedure TFormCompteur.Dverrouiller1Click(Sender: TObject);
begin
  SetWindowPos(Handle,HWND_NOTOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
  Verrouillerdevant1.Checked:=false;
  Dverrouiller1.Checked:=true;
  VerrouilleCompteur:=false;
end;

procedure TFormCompteur.Verrouillerdevant1Click(Sender: TObject);
begin
  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
  Verrouillerdevant1.Checked:=true;
  Dverrouiller1.Checked:=false;
  VerrouilleCompteur:=true;
end;

procedure TFormCompteur.Compteurdevitesse11Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=true;
  Compteurdevitesse21.checked:=false;
  Compteurtachro1.checked:=false;
  compteur:=1;
  init_compteur(1,formCOmpteur[1]);
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCOmpteur[1]);
end;

procedure TFormCompteur.Compteurdevitesse21Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=false;
  Compteurdevitesse21.checked:=true;
  Compteurtachro1.checked:=false;
  compteur:=2;
  init_compteur(1,formcompteur[1]);
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCompteur[1]);
end;

procedure TFormCompteur.Compteurtachro1Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=false;
  Compteurdevitesse21.checked:=false;
  Compteurtachro1.checked:=true;
  compteur:=3;
  init_compteur(1,formcompteur[1]);
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCompteur[1]);
end;

procedure TFormCompteur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AffCompteur:=false;
end;

procedure TFormCompteur.FormCreate(Sender: TObject);
var form : Tform;
    Acanvas : tcanvas;
begin
  //LargComptC:=150;HautCompTC:=150;
  // valeurs mini et maxi de la fenetre
  with constraints do
  begin
    MaxWidth:=400;
    MinWidth:=200;
    MaxHeight:=450;
    MinHeight:=100;
  end;

  if (Largeurcompteurs<=0) or (LargeurCompteurs>400) then LargeurCompteurs:=200;
  HauteurCompteurs:=200;
  ImageTrain.Height:=30;         // les deux images doivent avoir la même hauteur
  ImageTProv.height:=ImageTrain.Height;

  // pour pouvoir redimensionner ImageTtrain, la première écriture de width doit etre au maxi possible et
  // dessiner dedans sinon on ne peut plus l'agrandir au dela du maxi
  with ImageTrain do
  begin
    Width:=400;
    canvas.fillrect(rect(0,0,400,30));
  end;
end;

procedure TFormCompteur.TrackBarCChange(Sender: TObject);
var s : string;
    c,i,vit,larg : integer;
    tt : ttrackbar;
    f : tform;
begin
  if clicTBtrain or clicTBGB then exit;
  clicTBFen:=true;
  //If affevt then
  //Affiche('Changement TrackBarcc',clyellow);
  tt:=sender as TTrackBar;
  f:=tt.Parent as tform;
  s:=f.caption;   // nom du train=caption de la fenêtre

  i:=index_train_nom(s);
  vit:=TrackBarC.position;
  compteurT[i].tb.Position:=vit;
  vitesse_loco(s,i,trains[i].adresse,vit,10,0);
  clicTBFen:=false;
end;

procedure TFormCompteur.FormResize(Sender: TObject);
begin
  refresh;
end;

procedure TFormCompteur.Button0Click(Sender: TObject);
begin
  trackBarC.Position:=0;
end;

procedure TFormCompteur.Affichericonedutrain1Click(Sender: TObject);
begin
  affTrainCompteur:=not(affTrainCompteur);
  afficherIconeDuTrain1.Checked:=affTrainCompteur;
  init_compteur(1,formcompteur[1]);
  affiche_train_compteur(1);
end;

end.
