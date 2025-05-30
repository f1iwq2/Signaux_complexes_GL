unit UnitCompteur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math, ComCtrls, Menus, Unitprinc ;

const
pisur180=pi/180;
NbreCompteurs=1;

type
  TFormCompteur = class(TForm)
    ImageCompteur: TImage;
    TrackBarC: TTrackBar;
    PopupMenuC: TPopupMenu;
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
    N3: TMenuItem;
    Vitesseencrans1: TMenuItem;
    Vitesserelle1: TMenuItem;
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
    procedure Vitesseencrans1Click(Sender: TObject);
    procedure Vitesserelle1Click(Sender: TObject);
    procedure PopupMenuCPopup(Sender: TObject);
  private
    { D�clarations priv�es }
    protected
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;  // d�tecte fin de redimensionnement fen�tre
    //procedure WMNCPaint(var Mes : TWMNCPaint); message WM_NCPAINT;
  public
    { D�clarations publiques }
  end;

type
   typ=(Trien,fen,gb,im);    // un compteur peut �tre de la fenetre 'formCompteur' (fen), des groupBox de la fenetre principale (gb) ou d'une image (onglet compteurs formConfig)
   TTcompteur=array[1..1] of record
      FcBitMap : Tbitmap;
      paramcompt : TparamCompt;
  end;

var
  formCompteur : array[1..1] of TformCompteur;     // il y a 10 fenetres mais on utilise qu'un compteur.
  Scompteur :  TTCompteur;  //   Scompteur : associ� � grande fenetre compteur
  ParamCompteur : array[1..3] of record
    coulAig,coulGrad,CoulNum,CoulFond,CoulArc : tcolor;
  end;

  VerrouilleCompteur,affTrainCompteur,VitCrans : boolean;
  LargeurCompteurs,HauteurCompteurs,LargComptC,HautComptC : integer;
  couleurTete : tcolor;


Procedure Init_compteur(i : integer;c : Tcomponent);
procedure aiguille_compteur(c,idTrain : integer;comp : Tcomponent);
procedure dessin_fond_compteur(var param : TparamCompt;i: integer ; Im : tbitmap;typCompt : integer);
procedure position_compteur;
procedure affiche_train_compteur(c : integer);
procedure init_compteurs;
function Vr_kmh(v : integer) : integer;

implementation

uses  UnitTCO, UnitClock , UnitConfig, UnitDebug;

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
    ACanvas:=nil;
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

// convertit une vitesse en cm/s en km/h suivant l'�chelle
function Vr_kmh(v : integer) : integer;
begin
  case echelle of
  0 :  result:=(v*87*36) div 1000;    // H0
  1 :  result:=(v*160*36) div 1000;   // N
  2 :  result:=(v*220*36) div 1000;   // Z
  end;
end;

// change l'aiguille du compteur
// c : n� de fenetre du compteur     idTrain : index du train  comp : composant dans lequel se trouve le compteur (form, groupbox ou image)
procedure aiguille_compteur(c,idTrain : integer ; comp : Tcomponent);
var ComptLoc,x1,y1,x2,y2,x3,y3,x4,y4,vitesse,vitesseFin,lim,him : integer;
    angleDeb,AngleFinLoc,sinD,cosD,sinF,cosF : extended ;
    canvDest :tcanvas;
    param : Tparamcompt;
    typDest : typ;
begin
  if compteur<1 then exit;

  typDest:=Trien;
  if comp is tform then typDest:=fen;
  if comp is tgroupBox then typDest:=gb;
  if comp is tImage then typDest:=im;
  if TypDest=Trien then
  begin
    Affiche('Anomalie 47 c='+intToSTR(c)+' i='+intToSTR(idTrain),clred);
    exit;
  end;

  if idTrain<>0 then
  begin
    // d�termine d�but et fin de l'arc vert
    vitesse:=abs(trains[idTrain].VitesseCompteur);  // vitesse en cours
    vitesseFin:=abs(trains[idTrain].vitesseCons);   // vitesse consigne
  end
  else
  begin
    Vitesse:=0;
    VitesseFin:=0;
  end;

  // convertir les vitesses instantan�es et fin en angles par
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

  if not(VitCrans) then
  begin
    if trains[idTrain].CoeffV1<>0 then  // si le train est �talonn�
    begin
      vitesse:=round(crans_to_Vrcms(vitesse,idTrain));          // vitesse en cm/s
      vitesseFin:=round(crans_to_Vrcms(vitesseFin,idTrain));    // vitesse en cms/s

      vitesse:=vr_kmh(vitesse);
      VitesseFin:=vr_kmh(vitesseFin);

      if vitesse>param.AngleFin then vitesse:=param.AngleFin;
      if vitesseFin>param.AngleFin then VitesseFin:=param.AngleFin;
    end;
  end;

  with param do
  begin
    angleDeb:=ComptA*vitesse+comptB;
    angleFinLoc:=ComptA*vitesseFin+comptB;

    lim:=imgL;
    Him:=imgH;
  end;

  sincos(AngleDeb*pisur180,sinD,cosD);  // arc vitesse de d�but
  sincos(AngleFinLoc*pisur180,sinF,cosF);  // arc vitesse de fin

  with canvDest do
  begin
    // copie le fond du compteur
    if typdest=fen then copyrect(rect(0,0,lim,him),Scompteur[c].FcBitMap.canvas,rect(0,0,lim,him));
    if typdest=gb then copyrect(rect(0,0,lim,him),compteurT[c].FcBitMap.canvas,rect(0,0,lim,him));
    if typdest=im then copyrect(rect(0,0,lim,him),FbmcompC.canvas,rect(0,0,lim,him));

    // afficher l'arc vert
    with param do
    begin
      pen.mode:=pmCopy;
      pen.width:=round(4*redX);
      if (vitesse<>0) and (angleDeb<>angleFinLoc) then
      begin
        x1:=AigCX - rav;
        y1:=AigCY - rav;
        x2:=AigCX + rav;
        y2:=AigCY + rav;
        x3:=AigCX + Round(rav*sinD);
        y3:=AigCY - Round(rav*cosD);
        x4:=AigCX + Round(rav*sinF);
        y4:=AigCY - Round(rav*cosF);
        pen.color:=ParamCompteur[comptloc].coulArc;
        if angleDeb>=angleFinLoc then setArcDirection(Handle,AD_COUNTERCLOCKWISE) else setArcDirection(Handle,AD_CLOCKWISE) ;
        Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      end;

      // Afficher l'aiguille (angleDeb)
      pen.color:=ParamCompteur[comptloc].coulAig;
      MoveTo(AigCX,AigCY);
      LineTo(round(rAig*sinD)+AigCX,round(-rAig*cosD)+AigCY);
    end;
  end;
end;

procedure compteur_2(c : integer;bm : tbitmap;var param : tparamcompt);
var n,v,rayon2,rayon3,rayon4,x1,y1,x2,y2,xt,yt,lim,him,rg : integer;
    angle,incr,r : single;
    s : string;
begin
  angle:=10;     // angle d�but des graduations
  incr:=2.5;      // incr�ment d'angle en � des graduations
  n:=0;
  v:=0;
  lim:=bm.Width;
  him:=bm.height;

  with param do
  begin
    AngleFin:=170;                  // 170 angle fin des graduations
    r:=redx;                        // r�duction
    rg:=round(AigCX/1.05);          // rayon des graduations
    rayon2:=Rg-round(10*r);         // rayon de fin des graduations
    rayon3:=Rg-round(20*r);
    rayon4:=Rg-round(20*r);         // chiffres

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
      {$IF CompilerVersion >= 28.0}
      font.orientation:=0;
      {$IFEND}
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
    until angle>param.AngleFin+incr;

  AngleFin:=130;     // en fait vitesse maxi compteur
  end;
end;

procedure compteur_tachro(c : integer;bm : tbitmap;var param : tparamcompt);
var l,av,n,v,rayon2,rayon3,rayon4,x1,y1,x2,y2,xt,yt,lim,him,rg : integer;
    angle,incr,r,a,sinA,cosA : single;
    s : string;
begin
  angle:=-40;     // angle d�but des graduations
  incr:=2.5;      // incr�ment d'angle en � des graduations
  n:=0;
  v:=0;

  with param do
  begin
    angleFin:=220;  // angle fin des graduations en km/h
    lim:=ImgL;
    him:=ImgH;
    AigCX:=lim div 2;      // centre aiguille
    AigCY:=round(200*redY);

    r:=lim/400;            // r�duction
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

    Cercle(bm.Canvas,AigCX,AigCY,round(125*r),clGray,ParamCompteur[3].CoulFond);
    Cercle(bm.Canvas,AigCX,AigCY,round(10*r),clwhite,clWhite);

    with bm.Canvas do
    begin
      font.Name:='Arial';
      brush.color:=clBlack;
      pen.color:=ParamCompteur[3].coulgrad;
      font.color:=ParamCompteur[3].CoulNum;
      font.size:=round(r*20);
      //Affiche(intToSTR(font.size),clred);
      font.style:=[];
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

       // affiche les chiffres avec un angle
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

     cosA:=cos((angle+180)*pisur180);
     sinA:=sin((angle+180)*pisur180);
     x1:=round(cosA*Rg)+AigCX;
     y1:=round(SinA*Rg)+AigCY;
     // gros traits
     if n mod 5 = 0 then
     begin
       bm.Canvas.pen.Width:=round(4*r);
       x2:=round(cosA*rayon3)+AigCX;
       y2:=round(sinA*rayon3)+AigCY;
     end
     else
     begin
       // traits fins
       bm.Canvas.pen.Width:=round(2*r);
       x2:=round(cosA*rayon2)+AigCX;
       y2:=round(sinA*rayon2)+AigCY;
     end;

     with bm.Canvas do
     begin
       MoveTo(x1,y1);
       lineTo(x2,y2);
     end;
     inc(n);
     angle:=angle+incr;
    until angle>param.AngleFin+incr;
  end;

  // copie l'image du texte "tachro" mise � l'�chelle
  StretchBlt(bm.Canvas.Handle,round(145*r),round(90*r),round(lim*r),round(him*r),
             FormPrinc.ImageTachro.canvas.Handle,0,0,lim,him,srcCopy);

  param.AngleFin:=220;   // en fait vitesse maxi compteur
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
    Brush.Color:=$141414;

    font.name:='arial';
    font.Style:=[fsBold];

    // le compteurs 1  provient de bitmaps
    // le compteur 2 et 3 sont dessin�s par
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
          {$IF CompilerVersion >= 28.0}
          font.orientation:=0;
          {$IFEND}
          TextOut(round(50*redX),round(128*redY),'0');
          TextOut(round(36*redX),round(90*redY),'20');
          TextOut(round(50*redX),round(54*redY),'40');
          TextOut(round(90*redX),round(36*redY),'60');
          TextOut(round(129*redX),round(53*redY),'80');
          TextOut(round(137*redX),round(91*redY),'100');
          TextOut(round(126*redX),round(126*redY),'120');
          // centre de l'aiguille
          AigCX:=round(98*redX);
          AigCY:=round(98*redY);
          rAig:=round(AigCX / 1.5);
          angleFin:=127;  // en fait vitesse maxi compteur
          end;
      2 : begin
            // centre de l'aiguille et longueur
            AigCX:=lim div 2;
            AigCY:=round(200*redY);
            rAig:=round(AigCX/1.07);
            // le compteur 2 est dessin�
            compteur_2(i,im,param);
          end;
      3 : begin  // tachro
            // centre de l'aiguille et longueur
            AigCX:=lim div 2;
            AigCY:=round(200*redY);
            rAig:=round(AigCX/1.1);
            // le compteur tachro est dessin�
            compteur_tachro(i,im,param);
          end;
        end;
      end;
  end;
end;

procedure init_compteurs;
var i : integer;
begin
  for i:=1 to ntrains do
  begin
    init_compteur(i,CompteurT[i].gb);
  end;
  init_compteur(1,FormCompteur[1]);
end;

Procedure Init_compteur(i : integer;c : Tcomponent);
const ofs=30; // d�calage entre la taille de l'image et de la fenetre
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
  if ProcPrinc then Affiche('Init compteur de vitesse '+intToSTR(i)+' composant '+c.name,clYellow);

  typDest:=Trien;
  if c is tform then typDest:=fen;      // si le compteur est la fenetre unique
  if c is tGroupBox then typDest:=gb;   // si le compteur est le groupBox de la fenetre principale
  if c is tImage then typDest:=im;      // si le compteur est l'image de l'onglet config compteurs
  if typDest=Trien then
  begin
    Affiche('Anomalie 48 i='+intToSTR(i),clred);
    exit;
  end;

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
      mini:=-80;           // le 0 est � mini degr�s
      maxi:=120;           // le vmax est � max degr�s
      vmax:=160;           // vmax du compteur
      l:=400;
      h:=215;
    end;
    3 :
    begin
      mini:=-130;          // le 0 est � mini degr�s
      maxi:=132;           // le vmax est � max degr�s
      vmax:=210;           // vmax du compteur
      l:=400;
      h:=340;
    end;
  end;

  // fixer la largeur de la fen�tre
  if typDest=fen then
  begin
    Lim:=LargeurCompteurs-ofs;
    formCompteur[i].Width:=LargeurCompteurs;
    Scompteur[i].paramcompt.ComptA:=(maxi-mini)/vmax; // pente de conversion vitesse en degr�s compteur
    Scompteur[i].paramcompt.ComptB:=mini;             // coordonn�es origine conversion
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
    Affiche('non trait� 6',clred);
  end;

  // --- traitement par type de compteur
  if typDest=gb then  // GroupBox de l'onglet compteurs de la page principale
  begin
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
    3 : compteurT[i].paramcompt.rav:=round(115*compteurT[i].paramcompt.redx);
    end;

    //ne pas faire compteurT[i].FCBitMap.Free �� fait une exception si il est d�ja en nil, contrairement � D12.
    compteurT[i].fcBitMap:=tbitmap.Create;
    with compteurT[i].FCBitMap do
    begin
      Width:=lim;
      Height:=him;
    end;

    dessin_fond_compteur(compteurT[i].paramcompt,i,compteurT[i].fcBitmap,compteur);
    Aiguille_compteur(i,i,compteurT[i].gb);
  end;

  // fenetre compteur unique
  if typDest=fen then
  begin
    formCompteur[i].ImageCompteur.width:=Lim;
    Scompteur[i].paramcompt.redX:=Lim/l;
    Scompteur[i].paramcompt.redY:=Him/h;
    Scompteur[i].paramcompt.ImgL:=Lim;
    Scompteur[i].paramcompt.ImgH:=Him;
    case compteur of
    1 : Scompteur[i].paramcompt.rav:=round(70*Scompteur[i].paramcompt.redx);  // rayon de l'arc vert
    2 : Scompteur[i].paramcompt.rav:=round(100*Scompteur[i].paramcompt.redx);
    3 : Scompteur[i].paramcompt.rav:=round(115*Scompteur[i].paramcompt.redx);
    end;

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

      // imageC <-- FCBitMap (on �crit les vitesses) <- ImageCompteur (grande)
      // cr�er un bitmap r�duit qui sert de r�f�rence
      Scompteur[i].FCBitMap.Free;          // zizi
      Scompteur[i].fcBitMap:=tbitmap.Create;
      with Scompteur[i].FCBitMap do
      begin
        Width:=lim;
        Height:=him;
      end;
    end;
    dessin_fond_compteur(Scompteur[i].paramcompt,i,Scompteur[i].FcBitmap,compteur);

    Aiguille_compteur(i,IdTrainClic,formCompteur[i]);
    Affiche_train_compteur(i);
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
    //Aiguille_compteur(1,1,formconfig.ImageCTC);
    Aiguille_compteur(i,i,formconfig.ImageCTC);
  end;
end;

// repositionne le compteur principal
procedure position_compteur;
begin
  if not(Verrouillecompteur) then exit;
  if formCompteur[1]=nil then exit;
  with formCompteur[1] do
  begin
    Left:=formprinc.Left+formprinc.Width-width-2;
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
  init_compteurs;
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCOmpteur[1]);
end;

procedure TFormCompteur.Compteurdevitesse21Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=false;
  Compteurdevitesse21.checked:=true;
  Compteurtachro1.checked:=false;
  compteur:=2;
  init_compteurs;
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCompteur[1]);
end;

procedure TFormCompteur.Compteurtachro1Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=false;
  Compteurdevitesse21.checked:=false;
  Compteurtachro1.checked:=true;
  compteur:=3;
  init_compteurs;
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCompteur[1]);
end;

procedure TFormCompteur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AffCompteur:=false;
end;

procedure TFormCompteur.FormCreate(Sender: TObject);
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
  ImageTrain.Height:=30;         // les deux images doivent avoir la m�me hauteur
  ImageTProv.height:=ImageTrain.Height;

  // pour pouvoir redimensionner ImageTtrain, la premi�re �criture de width doit etre au maxi possible et
  // dessiner dedans sinon on ne peut plus l'agrandir au dela du maxi
  with ImageTrain do
  begin
    Width:=400;
    canvas.fillrect(rect(0,0,400,30));
  end;
end;

procedure TFormCompteur.TrackBarCChange(Sender: TObject);
var s : string;
    i,vit : integer;
    tt : ttrackbar;
    f : tform;
begin
  if clicTBtrain or clicTBGB then exit;
  clicTBFen:=true;

  tt:=sender as TTrackBar;
  f:=tt.Parent as tform;
  s:=f.caption;   // nom du train=caption de la fen�tre

  i:=index_train_nom(s);
  vit:=TrackBarC.position;
  //If affevt then Affiche('Changement TrackBarcc Vit='+intToSTR(vit),clyellow);
  compteurT[i].tb.Position:=vit;
  vitesse_loco(s,i,trains[i].adresse,vit,10,0);
  clicTBFen:=false;
end;

procedure TFormCompteur.FormResize(Sender: TObject);
begin
  refresh;
end;

procedure TFormCompteur.Button0Click(Sender: TObject);
var i : integer;
    tt : tbutton;
    f : Tform;
    s : string;
begin
  clicTBFen:=true;
  tt:=sender as TButton;
  f:=tt.Parent as tform;
  s:=f.caption;   // nom du train=caption de la fen�tre

  i:=index_train_nom(s);
  trains[i].vitesseCons:=0;
  compteurT[i].tb.Position:=0;
  trackBarC.Position:=0;
  //vitesse_loco(s,i,trains[i].adresse,0,10,0);
  clicTBFen:=false;
end;

procedure TFormCompteur.Affichericonedutrain1Click(Sender: TObject);
begin
  affTrainCompteur:=not(affTrainCompteur);
  afficherIconeDuTrain1.Checked:=affTrainCompteur;
  init_compteur(1,formcompteur[1]);
  affiche_train_compteur(1);

end;

procedure TFormCompteur.Vitesseencrans1Click(Sender: TObject);
begin
  Vitesseencrans1.Checked:=true;
  Vitesserelle1.checked:=false;
  VitCrans:=true;
end;

procedure TFormCompteur.Vitesserelle1Click(Sender: TObject);
begin
  Vitesserelle1.Checked:=true;
  Vitesseencrans1.Checked:=false;
  VitCrans:=false;
end;

procedure TFormCompteur.PopupMenuCPopup(Sender: TObject);
var c : tcomponent;
    f : tform;
    s : string;
    i : integer;
begin
  c:=popupmenuC.PopupComponent;  // trouver la form parente du popup
  c:=c.GetParentComponent;
  if c is tform then
  begin
    f:=c as tform;
    s:=f.caption;   // train
    i:=index_train_nom(s);
    if trains[i].CoeffV3=0 then
    begin
      Vitesseencrans1.enabled:=false;
      Vitesserelle1.enabled:=false;
    end
    else
    begin
      Vitesseencrans1.enabled:=true;
      Vitesserelle1.enabled:=true;
    end;
  end;
end;

end.
