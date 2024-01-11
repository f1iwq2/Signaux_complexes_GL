unit UnitConfigTCO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls , UnitTCO, ExtCtrls, Menus,
  Buttons, Grids,
  ComCtrls;

type
  TFormConfigTCO = class(TForm)
    ButtonDessine: TButton;
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
    ImageQuai: TImage;
    Label13: TLabel;
    CheckCouleur: TCheckBox;
    Label1: TLabel;
    ImagePiedFeu: TImage;
    BitBtnOk: TBitBtn;
    RadioGroup1: TRadioGroup;
    RadioButtonCourbes: TRadioButton;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    StringGridTCO: TStringGrid;
    EditNbCellX: TEdit;
    EditNbCellY: TEdit;
    labelMaxX: TLabel;
    labelMaxY: TLabel;
    Ratio: TLabel;
    EditRatio: TEdit;
    Label14: TLabel;
    CheckBoxCreerEvt: TCheckBox;
    Label15: TLabel;
    Label2: TLabel;
    CheckDessineGrille: TCheckBox;
    EditEcran: TEdit;
    Label16: TLabel;
    TrackBarEpaisseur: TTrackBar;
    Label17: TLabel;
    Label18: TLabel;
    RadioButtonLignes: TRadioButton;
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
    procedure CheckBoxCreerEvtClick(Sender: TObject);
    procedure EditNbCellXChange(Sender: TObject);
    procedure EditNbCellYChange(Sender: TObject);
    procedure CheckDessineGrilleClick(Sender: TObject);
    procedure CheckCouleurClick(Sender: TObject);
    procedure RadioButtonLignesClick(Sender: TObject);
    procedure RadioButtonCourbesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarEpaisseurChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var  FormConfigTCO: TFormConfigTCO;
     clicConf : boolean;
     titre_couleur : string;
     graphisme : integer;

implementation

uses UnitPrinc,unitconfig ;


{$R *.dfm}

procedure icone_aig;
var r : Trect;
    x1,y1,x2,y2,x3,y3,x4,y4 : integer;
begin
  with FormConfigTCO.ImageAig do
  begin
    canvas.Pen.color:=clfond[indexTCOCourant];
    canvas.Brush.Color:=clfond[indexTCOCourant];
    canvas.Rectangle(0,0,Width,Height);

    canvas.pen.color:=clVoies[indexTCOCourant];
    canvas.brush.color:=clvoies[indexTCOCourant];
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

procedure dessine_icones_config(indexTCO : integer);
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
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);
  end;
  // 3
  with formConfigTCO.ImageGrille do
  begin
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);
    canvas.Pen.color:=ClGrille[IndexTCO];
    canvas.moveto(0,5); canvas.LineTo(width,5);
    canvas.moveto(27,0); canvas.LineTo(27,Height);
  end;
  // 4 détecteur
  with formConfigTCO.ImageDetAct do
  begin
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);

    canvas.Brush.Color:=clAllume[indexTCO];
    canvas.pen.color:=clAllume[indexTCO];
    canvas.Pen.Mode:=pmCopy;
    r:=Rect(1,(height div 2)-6,width-1,(height div 2)+6);
    canvas.FillRect(r);

    canvas.pen.color:=clVoies[indexTCO];
    canvas.brush.color:=clVoies[indexTCO];
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);
  end;

  // 5 canton
  with formCOnfigTCO.Imagecanton do
  begin
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);

    canvas.pen.color:=clCanton[indexTCO];
    canvas.brush.color:=clCanton[indexTCO];
    // bande horizontale
    r:=Rect(0,(height div 2)-3,width,(height div 2)+3);
    canvas.FillRect(r);
  end;

  // 6 texte
  with formCOnfigTCO.ImageTexte do
  begin
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);
    canvas.Font.color:=clTexte;
    canvas.Pen.mode:=pmCopy;
    canvas.Textout(5,10,'Voie 1');
  end;

  // Quai
  with formconfigTCO.ImageQuai do
  begin
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);
    canvas.Brush.Color:=clQuai[indexTCO];
    canvas.pen.color:=clQuai[indexTCO];
    x1:=0;
    x2:=x1+width;
    jy1:=(Haut div 2)-round(12*fryGlob[indexTCO]); // pos Y de la bande sup
    jy2:=(Haut div 2)+round(12*fryGlob[indexTCO]); // pos Y de la bande inf
    canvas.PolyGon([point(x1,jy1),point(x2,jy1),point(x2,jy2),point(x1,jy2)]);
  end;

  // pied signal
  with formconfigTCO.ImagePiedFeu do
  begin
    canvas.Pen.color:=clfond[indexTCO];
    canvas.Brush.Color:=clfond[indexTCO];
    canvas.Rectangle(0,0,Width,Height);
    canvas.Brush.Color:=clPiedSignal[indexTCO];
    canvas.pen.color:=clPiedSignal[indexTCO];
    canvas.Pen.Width:=2;
    x1:=Larg div 2;
    y1:=0;
    canvas.moveTo(x1,y1);
    y2:=haut div 2;
    canvas.LineTo(x1,y2);
    canvas.LineTo(x1-10,y2);
  end;
end;

function verif_config_TCO(indexTCO : integer) : boolean;  // renvoie true si ok
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
    else NbreCellX[indexTCO]:=mx;

    Val(EditNbCellY.Text,my,erreur);
    if (my<10) or (my>MaxCellY) then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules Y: mini=10 maxi='+IntToSTR(MaxCellY);
      ok:=false;
    end
    else NbreCellY[indexTCO]:=my;

    if ZoomMax*NbreCellX[indexTCO]>8192 then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules X';
      ok:=false;
    end;

    if ZoomMax*NbreCellY[indexTCO]>8192 then
    begin
      LabelErreur.caption:='Erreur: nombre de cellules Y';
      ok:=false;
    end;

    val(EditRatio.text,RatioC,erreur);

    AvecGrille[IndexTCO]:=checkDessineGrille.Checked;
    if checkCouleur.checked then ModeCouleurCanton:=1 else ModeCouleurCanton:=0;

  end;
  verif_config_TCO:=ok;
  NbCellulesTCO[indexTCO]:=NbreCellX[indexTCO]*NbreCellY[indexTCO];
end;


procedure TFormConfigTCO.ButtonDessineClick(Sender: TObject);
begin
  if verif_config_TCO(indexTCOCourant) then
  begin
    with formTCO[indexTCOCourant] do
    begin
      ImageTCO.Width:=LargeurCell[indexTCOCourant]*NbreCellX[indexTCOCourant];
      ImageTCO.Height:=HauteurCell[indexTCOCourant]*NbreCellY[indexTCOCourant];
    end;
    calcul_cellules(indexTCOCourant);
    affiche_TCO(indexTCOCourant);
  end;
end;


procedure TFormConfigTCO.FormActivate(Sender: TObject);
var s: string;
    i : integer;
begin
  clicConf:=true;
  s:='Configuration du tco '+inttostr(indextcocourant)+' - Fichier '+NomFichierTCO[indextcocourant];
  caption:=s;
  
  groupBox3.caption:='Configuration du TCO '+inttostr(indextcocourant);
  GroupBox1.Caption:='Couleurs du TCO '+inttostr(indextcocourant);
  EditNbCellX.Text:=IntToSTR(NbreCellX[indexTCOcourant]);
  EditNbCellY.Text:=IntToSTR(NbreCellY[indexTCOcourant]);
  EditRatio.text:=IntToSTR(RatioC);
  EditEcran.Text:=intToSTR(EcranTCO[indexTCOcourant]);
  RadioButtonCourbes.checked:=graphisme=2;
  RadioButtonLignes.checked:=graphisme=1;
  checkDessineGrille.Checked:=AvecGrille[IndexTCOCourant];
  checkCouleur.Checked:=ModeCouleurCanton=1;
  trackbarEpaisseur.Position:=Epaisseur_voies;
  labelMaxX.caption:='Max='+intToSTR(MaxCellX);
  labelMaxY.caption:='Max='+intToSTR(MaxCellY);
  Label15.caption:='Nbre de TCOs : '+intToSTR(NbreTCO);
  CheckBoxCreerEvt.checked:=EvtClicDet;
  dessine_icones_config(indexTCOCourant);
  s:='ColorA='+IntToHex(clfond[indexTCOcourant],6);  // ajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);
  for i:=1 to 10 do
  begin
    stringGridTCO.Cells[1,i]:=NomFichierTCO[i];

    if i<=nbreTCO then stringGridTCO.Cells[2,i]:='X' else stringGridTCO.Cells[2,i]:=' ';
  end;
//  stringGridTCO.canvas.Font.Style:=[fsBOld];
    clicConf:=false;
end;


procedure TFormConfigTCO.ImageAigClick(Sender: TObject);
var s : string;
begin
  titre_couleur:='Changer la couleur des voies';
  ColorDialog1.Color:=clVoies[indexTCOcourant];

  s:='ColorA='+IntToHex(clfond[indexTCOCourant],6);  // ajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);
  if ColorDialog1.execute then
  begin
    clVoies[indexTCOCourant]:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageFondClick(Sender: TObject);
var s : string;
begin
  titre_couleur:='Changer la couleur de fond';

  s:='ColorA='+IntToHex(clfond[indexTCOCourant],6);  // pour rajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);

  if ColorDialog1.execute then
  begin
    clfond[indexTCOCourant]:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageGrilleClick(Sender: TObject);
var s: string;
begin
  titre_couleur:='Changer la couleur de la grille';
  ColorDialog1.Color:=clGrille[IndexTCOCourant];

  s:='ColorA='+IntToHex(clfond[indexTCOCourant],6);  // ajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);

  if ColorDialog1.execute then
  begin
    ClGrille[IndexTCOCourant]:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageDetActClick(Sender: TObject);
var s: string;
begin
  titre_couleur:='Changer la couleur de détecteur activé';
  ColorDialog1.Color:=clAllume[indexTCOCourant];

  s:='ColorA='+IntToHex(clfond[indexTCOCourant],6);  // ajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);
  if ColorDialog1.execute then
  begin
    ClAllume[indexTCOCourant]:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImagecantonClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur de canton activé';
  ColorDialog1.Color:=clCanton[indexTCOCourant];

  if ColorDialog1.execute then
  begin
    ClCanton[indexTCOCourant]:=ColorDialog1.Color;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageTexteClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du texte';
  ColorDialog1.Color:=cltexte;

  if ColorDialog1.execute then
  begin
    ClTexte:=ColorDialog1.Color;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageQuaiClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du quai';
  ColorDialog1.Color:=clQuai[indexTCOCourant];

  if ColorDialog1.execute then
  begin
    ClQuai[indexTCOCourant]:=ColorDialog1.Color;
    dessine_icones_config(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImagePiedFeuClick(Sender: TObject);
begin
  titre_couleur:='Changer la couleur du pied du signal';
  ColorDialog1.Color:=clPiedSignal[indexTCOCourant];

  if ColorDialog1.execute then
  begin
    clPiedSignal[indexTCOCourant]:=ColorDialog1.Color;
    dessine_icones_config(indexTCOCourant);
  end;
end;

// change le titre de la fenêtre de choix des couleurs à son ouverture
procedure TFormConfigTCO.ColorDialog1Show(Sender: TObject);
begin
  SetWindowText(ColorDialog1.Handle,pchar(titre_couleur));
end;

procedure TFormConfigTCO.BitBtnOkClick(Sender: TObject);
var ok : boolean;
    i,x,y,erreur : integer;
    s : string;
begin
  ok:=true;
  if verif_config_TCO(indexTCOCourant) then
  begin
    with FormTCO[indexTCOCourant].ImageTCO do
    begin
      Width:=LargeurCell[indexTCOCourant]*NbreCellX[indexTCOCourant];
      Height:=HauteurCell[indexTCOCourant]*NbreCellY[indexTCOCourant];
    end;

    for y:=1 to NbreCellY[indexTCOCourant] do
      for x:=1 to NbreCellX[indexTCOCourant] do
        begin
          if tco[indexTCOCourant,x,y].CouleurFond=0 then tco[indexTCOCourant,x,y].CouleurFond:=clfond[indexTCOCourant];
        end;

    if RadioButtonLignes.Checked then
    begin
      if graphisme=2 then TCO_modifie:=true;
      graphisme:=1 ;
    end;
    if RadioButtonCourbes.Checked then
    begin
      if graphisme=1 then TCO_modifie:=true;
      graphisme:=2;
    end;

    epaisseur_voies:=trackBarEpaisseur.Position;

    val(editEcran.Text,i,erreur);
    if i<1 then i:=1;
    if i<>EcranTCO[indexTCOcourant] then tco_modifie:=true;
    EcranTCO[indexTCOcourant]:=i;
    AvecGrille[IndexTCOCourant]:=checkDessineGrille.Checked;
    if ok then
    begin
      for i:=1 to 10 do
      begin
        if NomFichierTCO[i]<>stringGridTCO.Cells[1,i] then
        begin
          config_modifie:=true;
          s:=stringGridTCO.Cells[1,i];
          // on peut vérifier le .cfg mais bon
          Affiche('Le nom du fichier '+NomFichierTCO[i]+' sera sauvegardé en '+s,clyellow);
          NomFichierTCO[i]:=s;
        end
        else
        NomFichierTCO[i]:=stringGridTCO.Cells[1,i];
      end;
      calcul_cellules(IndexTCOcourant);
      affiche_TCO(indexTCOcourant);

      dessine_icones(indexTCOCourant);
      LabelErreur.caption:='';
      close;
   end;
  end;
end;

procedure TFormConfigTCO.CheckBoxCreerEvtClick(Sender: TObject);
begin
  EvtClicDet:=CheckBoxCreerEvt.checked;
  if not(clicConf) then TCO_modifie:=true;
end;

procedure TFormConfigTCO.EditNbCellXChange(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
end;

procedure TFormConfigTCO.EditNbCellYChange(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
end;

procedure TFormConfigTCO.CheckDessineGrilleClick(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
  AvecGrille[IndexTCOcourant]:=checkDessineGrille.Checked;
  affiche_tco(indexTCOCourant);
end;

procedure TFormConfigTCO.CheckCouleurClick(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
end;

procedure TFormConfigTCO.RadioButtonLignesClick(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
  graphisme:=1;
end;

procedure TFormConfigTCO.RadioButtonCourbesClick(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
  graphisme:=2;
end;

procedure TFormConfigTCO.FormCreate(Sender: TObject);
var i : integer;
    c : tcomponent;
begin
  if debug=1 then Affiche('Création fenetre configTCO',clLime);
  for i:=0 to stringGridTCO.RowCount - 1 do
  with stringGridTCO do
  begin
    RowHeights[i]:=15;
    Cells[0,i+1]:=intToSTR(i+1);
  end;

  with stringGridTCO do
  begin
    Options := stringGridTCO.Options + [goEditing];
    ColWidths[0]:=30;
    ColWidths[1]:=200;
    ColWidths[2]:=15;
    Cells[0,0]:='Num';
    Cells[1,0]:='Nom fichier';
    Cells[2,0]:='X';
    font.Color:=clBlack;
  end;

  if sombre then
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;
  if debug=1 then Affiche('Fin création fenetre configTCO',clLime);
end;

procedure TFormConfigTCO.TrackBarEpaisseurChange(Sender: TObject);
var i : integer;
begin
  i:=trackbarEpaisseur.Position;
  Epaisseur_voies:=i;
  calcul_cellules(indexTCOCourant);
  affiche_tco(indexTCOcourant);
  TrackBarEpaisseur.Hint:='Epaisseur = '+IntToSTR(i);
end;





end.
