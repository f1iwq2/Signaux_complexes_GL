unit UnitCompteur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, math, ComCtrls, Menus;

const
pisur180=pi/180;
NbreCompteurs=10;

type
  TFormCompteur = class(TForm)
    ImageCompteur: TImage;
    TrackBar1: TTrackBar;
    LabelTrain: TLabel;
    PopupMenu1: TPopupMenu;
    Verrouillerdevant1: TMenuItem;
    Dverrouiller1: TMenuItem;
    N1: TMenuItem;
    Compteurdevitesse11: TMenuItem;
    Compteurdevitesse21: TMenuItem;
    Compteurtachro1: TMenuItem;
    ImageTachro: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Dverrouiller1Click(Sender: TObject);
    procedure Verrouillerdevant1Click(Sender: TObject);
    procedure Compteurdevitesse11Click(Sender: TObject);
    procedure Compteurdevitesse21Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Compteurtachro1Click(Sender: TObject);
  private
    { Déclarations privées }
    protected
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;  // détecte fin de redimensionnement fenêtre
  public
    { Déclarations publiques }
  end;

var
  formCompteur : array[1..10] of TformCompteur;
  AigCX,AigCY,Raig,Rav : array[1..NbreCompteurs] of integer;
  redX,redY,ComptA,ComptB : array[1..NbreCompteurs] of single;
  FCBitMap : array[1..NbreCompteurs] of tBitmap;
  VerrouilleCompteur : boolean;
  LargeurCompteurs,HauteurCompteurs : integer;


Procedure Init_compteur(i : integer);
procedure aiguille_compteur_l(id,idTrain : integer);
procedure position_compteur;
procedure affiche_train_compteur(c : integer);

implementation

uses UnitPrinc, UnitTCO, UnitClock;

{$R *.dfm}

// event fin de redimmensionnement
procedure TFormCompteur.WMExitSizeMove(var Message: TMessage);
begin
  inherited;
  // Affiche(IntToSTR(Message.Msg)+' '+inTtOstr(message.WParam)+' '+intToSTR(message.LParam)+' '+intToSTR(message.WParamLo),clred);
  LargeurCompteurs:=formCompteur[1].Width;   // nouvelle largeur
  init_compteur(1);
end;

// affiche le nom du train
procedure affiche_train_compteur(c : integer);
var s : string;
begin
  s:=trains[IdTrainClic].nom_train;
  FormCompteur[c].caption:=s;
  with FormCompteur[c].labelTrain do
  begin
    caption:=s;
    Width:=FormCompteur[c].Width-5;
  end;
end;

procedure aiguille_compteur_l(id,idTrain : integer);
var x1,y1,x2,y2,x3,y3,x4,y4,vitesse,vitesseFin,lim,him : integer;
    angleDeb,AngleFin,sinD,cosD,sinF,cosF : extended ;
begin
  if compteur<1 then exit;

  if idTrain<>0 then
  begin
    vitesse:=abs(trains[idTrain].VitesseCompteur);
    vitesseFin:=abs(trains[idTrain].vitesseCons);
  end
  else
  begin
    vitesse:=0;VitesseFin:=0;
  end;

  // convertir les vitesses instantanées et fin en angles par
  // la formule angle=A.vitesse+b
  angleDeb:=comptA[id]*vitesse+comptB[id];
  angleFin:=ComptA[id]*vitesseFin+comptB[id];

  sincos(angleDeb*pisur180,sinD,cosD);

  with formCompteur[id].ImageCompteur do
  begin
    lim:=width;
    him:=Height;
  end;

  with formCompteur[id].ImageCompteur.Canvas do
  begin
    copyrect(rect(0,0,lim,him),FcBitMap[id].canvas,rect(0,0,lim,him));

    // afficher l'arc vert
    if (vitesse<>0) and (angleDeb<>angleFin) then
    begin
      x1:=AigCX[id] - rav[id];
      y1:=AigCY[id] - rav[id];
      x2:=AigCX[id] + rav[id];
      y2:=AigCY[id] + rav[id];
      x3:=AigCX[id] + Round(rav[id]*sinD);
      y3:=AigCY[id] - Round(rav[id]*cosD);
      sincos(AngleFin*pisur180,sinF,cosF);  // paramètres d'angleFin
      x4:=AigCX[id] + Round(rav[id]*sinF);
      y4:=AigCY[id] - Round(rav[id]*cosF);
      pen.color:=clLime;
      moveTo(X3,y3);LineTo(x3+2,y3+2);
      if angleDeb>angleFin then setArcDirection(Handle,AD_COUNTERCLOCKWISE) else setArcDirection(Handle,AD_CLOCKWISE) ;
      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
    end;
    // Afficher l'aiguille (angleDeb)
    if compteur=3 then Pen.color:=$ffa0a0 else Pen.color:=clred;
    MoveTo(AigCX[id],AigCY[id]);
    LineTo(round(rAig[id]*sinD)+AigCX[id],round(-rAig[id]*cosD)+AigCY[id]);
  end;

  formCompteur[id].ImageCompteur.Repaint;
end;

procedure compteur_tachro;
var l,av,n,v,rayon2,rayon3,rayon4,x1,y1,x2,y2,xt,yt,lim,him,rg : integer;
    angle,angleFin,incr,r,a : single;
    s : string;
begin
  angle:=-40;     // angle début des graduations
  angleFin:=220;  // angle fin des graduations
  incr:=2.5;      // incrément d'angle en ° des graduations
  n:=0;
  v:=0;
  lim:=fcbitmap[1].Width;
  him:=fcbitmap[1].height;

  with fcBitmap[1] do
  begin
    AigCX[1]:=width div 2;               // centre aiguille
    AigCY[1]:=AigCX[1];
    r:=width/400;                        // réduction
    //Raig[1]:=(Lim div 2)-round(10*r);  // rayon
    rg:=round(AigCX[1]/1.05);            // rayon des graduations
    rayon2:=Rg-round(10*r);              // rayon de fin des graduations
    rayon3:=Rg-round(20*r);
    rayon4:=Rg-round(20*r);              // chiffres

    with fcBitmap[1].Canvas do
    begin
      pen.width:=1;
      pen.Color:=clWhite;
      Brush.Color:=clBlack;
      Brush.Style:=bsSolid;
      FillRect(Rect(0,0,lim,him));

      Cercle(fcBitmap[1].Canvas,AigCX[1],AigCY[1],round(130*r),clGray,clblack);
      Cercle(fcBitmap[1].Canvas,AigCX[1],AigCY[1],round(10*r),clwhite,clWhite);

      font.Name:='Arial';
      brush.color:=clBlack;
      pen.color:=clwhite;
      font.color:=clWhite;
      font.size:=round(r*20);
      //Affiche(intToSTR(font.size),clred);
      font.style:=[fsbold];
    end;
  end;

  // dessine le cadran
  repeat
     // affiche les chiffres
     if n mod 10=0 then
     begin
       s:=intToSTR(round(v));
       // pour centrer le chiffre de vitesse sur l'axe de la graduation
       a:=(fcBitmap[1].canvas.TextWidth(s) div 2)/rayon4;
       if abs(a)>1 then a:=1;
       a:=arcSin(a);
       l:=round(a*180/pi);
       //Affiche(intToSTR(l),clYellow);
       xt:=round(cos((angle+180-l)*pisur180)*rayon4)+AigCX[1];
       yt:=round(sin((angle+180-l)*pisur180)*rayon4)+AigCY[1];

       // affiche les chiffres
       {$IF CompilerVersion >= 28.0}
       av:=round(90-angle)*10;
       fcBitmap[1].canvas.font.orientation:=av;
       fcBitmap[1].canvas.Textout(xt,yt,s);
       {$ELSE}
       av:=10+round(90-angle)*10;
       AffTexteIncliBordeTexture(fcBitmap[1].canvas,xt,yt,fcBitmap[1].canvas.font,clYellow,0,pmcopy,s,av);
       {$IFEND}

       inc(v,20);
     end;

     x1:=round(cos((angle+180)*pisur180)*Rg)+AigCX[1];
     y1:=round(sin((angle+180)*pisur180)*Rg)+AigCY[1];
     // gros traits
     if n mod 5 = 0 then
     begin
       fcBitmap[1].canvas.pen.Width:=round(4*r);
       x2:=round(cos((angle+180)*pisur180)*rayon3)+AigCX[1];
       y2:=round(sin((angle+180)*pisur180)*rayon3)+AigCY[1];
     end
     else
     begin
       // traits fins
       fcBitmap[1].canvas.pen.Width:=round(2*r);
       x2:=round(cos((angle+180)*pisur180)*rayon2)+AigCX[1];
       y2:=round(sin((angle+180)*pisur180)*rayon2)+AigCY[1];
     end;

     with fcBitmap[1].canvas do
     begin
       MoveTo(x1,y1);
       lineTo(x2,y2);
     end;
     inc(n);
     angle:=angle+incr;       // 18
  until angle>AngleFin+incr;

  lim:=formCompteur[1].ImageTachro.width;
  him:=formCompteur[1].ImageTachro.height;

  // copie l'image tachro mise à l'échelle
  StretchBlt(fcBitmap[1].canvas.Handle,round(145*r),round(85*r),round(lim*r),round(him*r),
             FormCompteur[1].ImageTachro.canvas.Handle,0,0,lim,him,srcCopy);
end;

Procedure Init_compteur(i : integer);
const ofs=20; // décalage entre la taille de l'image et de la fenetre
var l,h,lim,him,hfen,mini,maxi,vmax : integer;
begin
  if i<1 then exit;
  //Affiche('Init compteur de vitesse',clYellow);

  // fixer la largeur de la fenêtre
  formCompteur[i].Width:=LargeurCompteurs;
  Lim:=LargeurCompteurs-ofs;
  formCompteur[i].ImageCompteur.width:=Lim;
  case compteur of
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
      mini:=-81;           // le 0 est à mini degrés
      maxi:=82;            // le vmax est à max degrés
      vmax:=160;           // vmax du compteur
      l:=formPrinc.ImageCompteur2.width;
      h:=formPrinc.ImageCompteur2.height;
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

  ComptA[i]:=(maxi-mini)/vmax; // pente de conversion vitesse en degrés compteur
  ComptB[i]:=mini;             // coordonnées origine conversion

  if l>=h then
  begin
    him:=round(lim*h/l);  // hauteur image
    //Affiche('Lim him = '+IntToSTR(lim)+' '+intToSTR(him),clLime);
    //Affiche('L h = '+IntToSTR(l)+' '+intToSTR(h),clLime);
  end
  else
  begin
    him:=round(h*largeurCompteurs/l);  // a revoir
  end;

  redX[i]:=Lim/l;
  redY[i]:=Him/h;
  case compteur of
  1 : rav[i]:=round(70*redx[i]);  // rayon de l'arc vert
  2 : rav[i]:=round(100*redx[i]);
  3 : rav[i]:=round(122*redx[i]);
  end;

  with formCompteur[i] do
  begin
    if VerrouilleCompteur then Left:=formprinc.Left+formprinc.Width-width;

    // ajuster hauteur de la fenetre
    hfen:=him+LabelTrain.Height+40; //formCompteur[i].TrackBar1.height+48;//+10;
    height:=hfen;

    with constraints do
    begin
      MaxWidth:=400;
      MinWidth:=200;
      MaxHeight:=450;
      MinHeight:=100;
    end;

    ImageCompteur.Width:=Lim;
    ImageCompteur.Height:=Him;
    ImageCompteur.Picture.Bitmap.Width:=Lim;
    ImageCompteur.Picture.Bitmap.Height:=Him;

    trackBar1.top:=ImageCompteur.Height+8;
    trackBar1.width:=LargeurCompteurs-5;

    LabelTrain.top:=ImageCompteur.top+ImageCompteur.Height; //trackBar1.top+formCompteur[i].trackBar1.height;
    LabelTrain.Width:=Lim-2;
  end;

  // imageC <-- FCBitMap (on écrit les vitesses) <- ImageCompteur2 (grande)

  // créer un bitmap réduit qui sert de référence
  FCBitMap[i].Free;
  FCBitMap[i]:=TBitMap.Create;
  FCBitMap[i].Width:=lim;
  FCBitMap[i].Height:=him;

  with FCBitMap[i].Canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=$141414; //$e0e0e0;

    if compteur=1 then StretchDraw(rect(0,0,Lim,Him),Formprinc.ImageCompteur1.Picture.Bitmap);
    if compteur=2 then StretchDraw(rect(0,0,Lim,Him),Formprinc.ImageCompteur2.Picture.Bitmap);

    font.name:='arial';
    font.Style:=[fsBold];

    // les compteurs 1 et 2 proviennent de bitmaps
    // le compteur 3 (tachro) est dessiné par "compteur_tachro"
    case compteur of
    1 : begin
          Brush.Style:=bsSolid;
          Brush.Color:=$1F1A17;
          font.color:=clwhite;
          font.size:=round(redx[i]*10);
          TextOut(round(50*redX[i]),round(128*redY[i]),'0');
          TextOut(round(36*redX[i]),round(90*redY[i]),'20');
          TextOut(round(50*redX[i]),round(54*redY[i]),'40');
          TextOut(round(90*redX[i]),round(36*redY[i]),'60');
          TextOut(round(129*redX[i]),round(53*redY[i]),'80');
          TextOut(round(137*redX[i]),round(91*redY[i]),'100');
          TextOut(round(126*redX[i]),round(126*redY[i]),'120');
          // centre de l'aiguille
          AigCX[i]:=round(98*redX[i]);
          AigCY[i]:=round(96*redY[i]);
          rAig[i]:=round(AigCX[i] / 1.5);
        end;
    2 : begin
          font.color:=clblue;
          Brush.Style:=bsSolid;
          Brush.Color:=clWhite;
          font.size:=round(redx[i]*22);
          TextOut(round(47*redX[i]),round(167*redY[i]),'0');
          TextOut(round(58*redX[i]),round(118*redY[i]),'20');
          TextOut(round(89*redX[i]),round(80*redY[i]),'40');
          TextOut(round(133*redX[i]),round(50*redY[i]),'60');
          TextOut(round(190*redX[i]),round(40*redY[i]),'80');
          TextOut(round(232*redX[i]),round(50*redY[i]),'100');
          TextOut(round(274*redX[i]),round(80*redY[i]),'120');
          TextOut(round(306*redX[i]),round(118*redY[i]),'140');
          TextOut(round(324*redX[i]),round(168*redY[i]),'160');
          // centre de l'aiguille et longueur
          AigCX[i]:=round(204*redX[i]);
          AigCY[i]:=round(207*redY[i]);
          rAig[i]:=round(AigCX[i]/1.05);
        end;
    3 : begin
          // centre de l'aiguille et longueur
          AigCX[i]:=lim div 2;
          AigCY[i]:=him div 2;
          rAig[i]:=round(AigCX[i]/1.07);
          compteur_tachro;
        end;
    end;

  end;

  // ajuste la taille
  with FormCompteur[i].ImageCompteur do
  begin
    canvas.pen.color:=clRed;
    canvas.pen.width:=3;  // épaisseur aiguille
  end;

  //formprinc.DoubleBuffered:=true;

  Aiguille_compteur_l(i,IdTrainClic);
end;

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
  init_compteur(1);
  affiche_train_compteur(1);
  aiguille_compteur_l(1,idTrainClic);
end;

procedure TFormCompteur.Compteurdevitesse21Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=false;
  Compteurdevitesse21.checked:=true;
  Compteurtachro1.checked:=false;
  compteur:=2;
  init_compteur(1);
  affiche_train_compteur(1);
  aiguille_compteur_l(1,idTrainClic);
end;

procedure TFormCompteur.Compteurtachro1Click(Sender: TObject);
begin
  Compteurdevitesse11.checked:=false;
  Compteurdevitesse21.checked:=false;
  Compteurtachro1.checked:=true;
  compteur:=3;
  init_compteur(1);
  affiche_train_compteur(1);
  aiguille_compteur_l(1,idTrainClic);
end;

procedure TFormCompteur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AffCompteur:=false;
end;


begin
  LargeurCompteurs:=200;
  HauteurCompteurs:=200;




end.
