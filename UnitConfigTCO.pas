unit UnitConfigTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , UnitTCO, ExtCtrls, Menus,
  Buttons;

type
  TFormConfigTCO = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    ButtonDessine: TButton;
    CheckDessineGrille: TCheckBox;
    EditNbCellX: TEdit;
    EditNbCellY: TEdit;
    LabelErreur: TLabel;
    ColorDialog1: TColorDialog;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    ImageAig: TImage;
    ImageFond: TImage;
    Label6: TLabel;
    ImageGrille: TImage;
    Label7: TLabel;
    ImageDetAct: TImage;
    Label8: TLabel;
    Memo1: TMemo;
    Label9: TLabel;
    Imagecanton: TImage;
    Label10: TLabel;
    ImageTexte: TImage;
    Label11: TLabel;
    Label12: TLabel;
    LabelMaxX: TLabel;
    LabelMaxY: TLabel;
    ImageQuai: TImage;
    Label13: TLabel;
    EditRatio: TEdit;
    Ratio: TLabel;
    Label14: TLabel;
    CheckCouleur: TCheckBox;
    Label1: TLabel;
    ImagePiedFeu: TImage;
    BitBtnOk: TBitBtn;
    procedure ButtonDessineClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageAigClick(Sender: TObject);
    procedure ImageFondClick(Sender: TObject);
    procedure ImageGrilleClick(Sender: TObject);
    procedure ImageDetActClick(Sender: TObject);
    procedure ImagecantonClick(Sender: TObject);
    procedure ColorDialog1Show(Sender: TObject);
    procedure ImageTexteClick(Sender: TObject);
    procedure ImageQuaiClick(Sender: TObject);
    procedure ImagePiedFeuClick(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var  FormConfigTCO: TFormConfigTCO;
     AvecGrille : boolean;
     titre_couleur : string;
     
implementation

uses UnitPrinc ;


{$R *.dfm}

procedure icone_aig;
var r : Trect;
    x1,y1,x2,y2,x3,y3,x4,y4 : integer;
begin
  with FormConfigTCO.ImageAig do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);

    canvas.pen.color:=clVoies;
    canvas.brush.color:=clvoies;
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);

    x1:=(width div 2); y1:=(height div 2)-3;
    x2:=3; y2:=0;
    x3:=0; y3:=3;
    x4:=0+(width div 2)-1; y4:=(height div 2)+3-1;
    canvas.Polygon([point(x1,y1),Point(x2,y2),Point(x3,y3),Point(x4,y4)]);
  end;
end;

procedure dessine_icones;
var r : Trect;
    x1,y1,x2,y2,jy1,jy2,larg,haut : integer;
begin
  // 1
  icone_aig;
  // 2
  with formConfigTCO.ImageFond do
  begin
    larg:=width ;
    haut:=height;
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);
  end;
  // 3
  with formConfigTCO.ImageGrille do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);
    canvas.Pen.color:=ClGrille;
    canvas.moveto(0,5); canvas.LineTo(width,5);
    canvas.moveto(27,0); canvas.LineTo(27,Height);
  end;
  // 4 détecteur
  with formConfigTCO.ImageDetAct do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);

    canvas.Brush.Color:=clAllume;
    canvas.pen.color:=clAllume;
    canvas.Pen.Mode:=pmCopy;
    r:=Rect(1,(height div 2)-6,width-1,(height div 2)+6);
    canvas.FillRect(r);

    canvas.pen.color:=clVoies;
    canvas.brush.color:=clVoies;
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);
  end;

  // 5 canton
  with formCOnfigTCO.Imagecanton do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);

    canvas.pen.color:=clCanton;
    canvas.brush.color:=clCanton;
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);
  end;

  // 6 texte
  with formCOnfigTCO.ImageTexte do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);
    canvas.Font.color:=clTexte;
    canvas.Pen.mode:=pmCopy;
    canvas.Textout(5,10,'Voie 1');
  end;

  // Quai
  with formconfigTCO.ImageQuai do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);
    canvas.Brush.Color:=clQuai;
    canvas.pen.color:=clQuai;
    x1:=0;
    x2:=x1+width;
    jy1:=(Haut div 2)-round(12*frYGlob); // pos Y de la bande sup
    jy2:=(Haut div 2)+round(12*frYGlob); // pos Y de la bande inf

    canvas.PolyGon([point(x1,jy1),point(x2,jy1),point(x2,jy2),point(x1,jy2)]);
  end;

  // pied signal
  with formconfigTCO.ImagePiedFeu do
  begin
    canvas.Pen.color:=clfond;
    canvas.Brush.Color:=clfond;
    canvas.Rectangle(0,0,Width,Height);
    canvas.Brush.Color:=clPiedSignal;
    canvas.pen.color:=clPiedSignal;
    canvas.Pen.Width:=2;
    x1:=Larg div 2;
    y1:=0;
    canvas.moveTo(x1,y1);
    y2:=HauteurCell div 2;
    canvas.LineTo(x1,y2);
    canvas.LineTo(x1-10,y2);
  end;

end;

function verif_config_TCO : boolean;  // renvoie true si ok
var erreur,mx,my : integer;
    ok : boolean;
begin
  ok:=true;
  with formConfigTCO do
  begin
    Val(EditNbCellX.Text,mx,erreur);
    if (mx<20) or (mx>MaxCellX) then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules X: mini=20 maxi='+IntToSTR(MaxCellX);
      ok:=false;
    end
    else NbreCellX:=mx;

    Val(EditNbCellY.Text,my,erreur);
    if (my<10) or (my>MaxCellY) then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules Y: mini=10 maxi='+IntToSTR(MaxCellY);
      ok:=false;
    end
    else NbreCellY:=my;

    if LargeurCell*NbreCellX>8192 then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules X';
      ok:=false;
    end;

    if HauteurCell*NbreCellY>8192 then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules Y';
      ok:=false;
    end;

    {
    Val(LabelTailleX.caption,LargeurCell,erreur);
    nokLg:=erreur<>0;
    if nokLg then LabelErreur.caption:='Erreur largeur de cellules';
    nokLg:=nokLg or (LargeurCell<20) or (LargeurCell>50)  ;
    if nokLg then LabelErreur.caption:='Erreur: Tailles des cellules - largeur cellules mini=20 maxi=50';

    Val(LabelTailleY.caption,HauteurCell,erreur);
    nokHt:=erreur<>0;
    if nokHt then LabelErreur.caption:='Erreur hauteur de cellules';
    nokHt:=nokHt or (HauteurCell<20) or (HauteurCell>50)  ;
    if nokHt then LabelErreur.caption:='Erreur: Tailles des cellules - hauteur cellules mini=20 maxi=50';
    }
    val(EditRatio.text,RatioC,erreur);

    AvecGrille:=checkDessineGrille.Checked;
    if checkCouleur.checked then ModeCouleurCanton:=1 else ModeCouleurCanton:=0;

  end;
  verif_config_TCO:=ok;
  NbCellulesTCO:=NbreCellX*NbreCellY;
end;


procedure TFormConfigTCO.ButtonDessineClick(Sender: TObject);
begin
  if verif_config_TCO then
  begin
    with formTCO do
    begin
      ImageTCO.Width:=LargeurCell*NbreCellX;
      ImageTCO.Height:=HauteurCell*NbreCellY;
    end;
    calcul_cellules;
    affiche_TCO;
  end;
end;


procedure TFormConfigTCO.FormActivate(Sender: TObject);
begin
  EditNbCellX.Text:=IntToSTR(NbreCellX);
  EditNbCellY.Text:=IntToSTR(NbreCellY);
  EditRatio.text:=IntToSTR(RatioC);
  checkDessineGrille.Checked:=AvecGrille;
  checkCouleur.Checked:=ModeCouleurCanton=1;
  labelMaxX.caption:='Max='+intToSTR(MaxCellX);
  labelMaxY.caption:='Max='+intToSTR(MaxCellY);
  dessine_icones;
end;


procedure TFormConfigTCO.ImageAigClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur des voies';
  ColorDialog1.Color:=clVoies;

  if ColorDialog1.execute then
  begin
    clVoies:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImageFondClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de fond';
  ColorDialog1.Color:=clfond;

  if ColorDialog1.execute then
  begin
    clfond:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImageGrilleClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de la grille';
  ColorDialog1.Color:=clGrille;

  if ColorDialog1.execute then
  begin
    ClGrille:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImageDetActClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de détecteur activé';
  ColorDialog1.Color:=clAllume;

  if ColorDialog1.execute then
  begin
    ClAllume:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImagecantonClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de canton activé';
  ColorDialog1.Color:=clAllume;

  if ColorDialog1.execute then
  begin
    ClCanton:=ColorDialog1.Color;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImageTexteClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du texte';
  ColorDialog1.Color:=cltexte;

  if ColorDialog1.execute then
  begin
    ClTexte:=ColorDialog1.Color;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImageQuaiClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du quai';
  ColorDialog1.Color:=clQuai;

  if ColorDialog1.execute then
  begin
    ClQuai:=ColorDialog1.Color;
    dessine_icones;
  end;
end;

procedure TFormConfigTCO.ImagePiedFeuClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du pied du signal';
  ColorDialog1.Color:=clPiedSignal;

  if ColorDialog1.execute then
  begin
    clPiedSignal:=ColorDialog1.Color;
    dessine_icones;
  end;
end;

// change le titre de la fenêtre de choix des couleurs à son ouverture
procedure TFormConfigTCO.ColorDialog1Show(Sender: TObject);
begin
  SetWindowText(ColorDialog1.Handle,pchar(titre_couleur));
end;

procedure TFormConfigTCO.BitBtnOkClick(Sender: TObject);
var ok : boolean;
begin
  ok:=true;

  if verif_config_TCO then
  begin
    with FormTCO.ImageTCO do
    begin
      Width:=LargeurCell*NbreCellX;
      Height:=HauteurCell*NbreCellY;
    end;

    try
      SetLength(TCO,NbreCellX+1,NbreCellY+1);
    except
      LabelErreur.caption:='TCO Mémoire insuffisante';
      NbreCellX:=20;NbreCellY:=12;
      SetLength(TCO,NbreCellX+1,NbreCellY+1);
      ok:=false;
    end;

    try
      SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);
    except
      LabelErreur.caption:='TamponTCO Mémoire insuffisante';
      NbreCellX:=20;NbreCellY:=12;
      SetLength(TamponTCO,NbreCellX+1,NbreCellY+1);
      ok:=false;
    end;

    AvecGrille:=checkDessineGrille.Checked;
    if ok then
    begin
      calcul_cellules;
      affiche_TCO;
      LabelErreur.caption:='';
      close;
   end;
  end;
end;

begin
end.
