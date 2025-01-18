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
    RadioGroupStyle: TRadioGroup;
    RadioGroupVoies: TRadioGroup;
    ImageCantonLibre: TImage;
    ImageCantonOccupe: TImage;
    Label19: TLabel;
    Label20: TLabel;
    procedure ButtonDessineClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageAigClick(Sender: TObject);
    procedure ImageFondClick(Sender: TObject);
    procedure ImageGrilleClick(Sender: TObject);
    procedure ImageDetAtlick(Sender: TObject);
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
    procedure FormCreate(Sender: TObject);
    procedure TrackBarEpaisseurChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroupVoiesClick(Sender: TObject);
    procedure RadioGroupStyleClick(Sender: TObject);
    procedure ImageCantonLibreClick(Sender: TObject);
    procedure ImageCantonOccupeClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var  FormConfigTCO: TFormConfigTCO;
     clicConf : boolean;
     titre_couleur : string;
     graphisme : integer;

procedure sauve_styles_tco(indexTCO: integer);
procedure restitue_styles(indexTCO: integer);
procedure jeu_clair(indexTCO: integer);

implementation

uses UnitPrinc,unitconfig ;


{$R *.dfm}

// icone exemple
procedure icone_aig;
begin
  with FormConfigTCO.ImageAig do
  begin
    canvas.Pen.color:=clfond[indexTCOCourant];
    canvas.Brush.Color:=clfond[indexTCOCourant];
    canvas.Rectangle(0,0,Width,Height);

    canvas.pen.color:=clVoies[indexTCOCourant];
    canvas.brush.color:=clvoies[indexTCOCourant];

    Canvas.Pen.Width:=4;
    canvas.MoveTo(0,height div 2);Canvas.LineTo(width,height div 2);

    canvas.MoveTo(width div 2,height div 2);Canvas.LineTo(0,0);

  end;
end;

procedure icone_canton_libre;
var haut,larg,yc1,yc2 : integer;
begin
  haut:=FormConfigTCO.ImageCantonLibre.Height;
  larg:=FormConfigTCO.ImageCantonLibre.Width;
  yc1:=haut div 4;
  yc2:=larg-(haut div 4);

  with FormConfigTCO.ImageCantonLibre.Canvas do
  begin
    Pen.color:=clfond[indexTCOCourant];
    Brush.Color:=clfond[indexTCOCourant];
    Rectangle(0,0,larg,Haut);

    Pen.Width:=1;

    Brush.Color:=CoulCantonLibre[indexTCOCourant];
    pen.color:=clwhite;

    Roundrect(0,yc1,larg,yc2,larg div 2,(yc2-yc1) div 2);
  end;
end;

procedure icone_canton_occupe;
var haut,larg,yc1,yc2 : integer;
begin
  haut:=FormConfigTCO.ImageCantonLibre.Height;
  larg:=FormConfigTCO.ImageCantonLibre.Width;
  yc1:=haut div 4;
  yc2:=larg-(haut div 4);

  with FormConfigTCO.ImageCantonOccupe.Canvas do
  begin
    Pen.color:=clfond[indexTCOCourant];
    Brush.Color:=clfond[indexTCOCourant];
    Rectangle(0,0,larg,Haut);

    Pen.Width:=1;

    Brush.Color:=CoulCantonOccupe[indexTCOCourant];
    pen.color:=clwhite;

    Roundrect(0,yc1,larg,yc2,larg div 2,(yc2-yc1) div 2);
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
    canvas.moveto(8,0); canvas.LineTo(8,Height);
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

  icone_canton_libre;
  icone_canton_occupe;

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
    if (ratioC<5) or (ratioC>15) then
    begin
      LabelErreur.caption:='Erreur: ratio';
      ok:=false;
    end;

    AvecGrille[IndexTCO]:=checkDessineGrille.Checked;
    if checkCouleur.checked then ModeCouleurCanton:=1 else ModeCouleurCanton:=0;

  end;
  verif_config_TCO:=ok;
  if ok then formConfigTCO.LabelErreur.caption:='';
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
    GridRect: TGridRect;
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
  RadioGroupVoies.ItemIndex:=graphisme-1;
  RadioGroupStyle.itemIndex:=JeuCouleurs-1;
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

  // selection
  GridRect.Top:= indextcocourant;
  GridRect.Left:= 1;
  GridRect.Right:= 1;
  GridRect.Bottom:= indextcocourant;
  StringGridTCO.Selection:= GridRect;

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
    sauve_styles_tco(indexTCOCourant);
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
    sauve_styles_tco(indexTCOCourant);
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
    sauve_styles_tco(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageDetAtlick(Sender: TObject);
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
    sauve_styles_tco(indexTCOCourant);
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
    sauve_styles_tco(indexTCOCourant);
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
    sauve_styles_tco(indexTCOCourant);
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
    sauve_styles_tco(indexTCOCourant);
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
    sauve_styles_tco(indexTCOCourant);
  end;
end;

// change le titre de la fenêtre de choix des couleurs à son ouverture
procedure TFormConfigTCO.ColorDialog1Show(Sender: TObject);
begin
  SetWindowText(ColorDialog1.Handle,pchar(titre_couleur));
end;

procedure TFormConfigTCO.BitBtnOkClick(Sender: TObject);
begin
  close;
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


procedure TFormConfigTCO.FormCreate(Sender: TObject);
var i : integer;
    c : tcomponent;
begin
  if debug=1 then Affiche('Création fenetre configTCO',clLime);
  position:=poMainFormCenter;
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

  if Modesombre then
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;

  With ImageAig do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImageFond do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImageGrille do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImageDetAct do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImageTexte do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImageQuai do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImagePiedFeu do
  begin
    Height:=32;
    Width:=32;
  end;
  With ImageCanton do
  begin
    Height:=32;
    Width:=32;
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

procedure TFormConfigTCO.FormClose(Sender: TObject;var Action: TCloseAction);
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
          Affiche('Le nom du fichier '+NomFichierTCO[i]+' du TCO'+intToSTR(i)+' sera sauvegardé en '+s,clyellow);
          NomFichierTCO[i]:=s;
        end
        else
        NomFichierTCO[i]:=stringGridTCO.Cells[1,i];
      end;
      menu_tco(nbreTCO);
      calcul_cellules(IndexTCOcourant);
      affiche_TCO(indexTCOcourant);
      dessine_icones(indexTCOCourant);
      LabelErreur.caption:='';
    end;
  end
  else action:=tCloseAction(caNone);  // si la config est nok, on ferme pas la fenetre
end;



procedure TFormConfigTCO.RadioGroupVoiesClick(Sender: TObject);
begin
  if not(clicConf) then TCO_modifie:=true;
  if RadioGroupVoies.itemIndex<0 then exit;
  tco_Modifie:=graphisme<>RadioGroupVoies.itemIndex+1;
  graphisme:=RadioGroupVoies.itemIndex+1;
end;

procedure sauve_styles_tco(indexTCO: integer);
var x,y : integer;
begin
  clvoiesSV:=clVoies[indexTCO];
  clFoncSV:=ClFond[indexTCO];
  clGrilleSV:=ClGrille[IndexTCO];
  clCoulCantonLibreSV:=CoulCantonLibre[IndexTco];
  clCoulCantonOccupeSV:=CoulCantonOccupe[IndexTCO];
  for y:=1 to NbreCellY[indexTCO] do
   for x:=1 to NbreCellX[indexTCO] do
     clCoulFondSV[IndexTCO,x,y]:=TCO[indexTCO,x,y].CouleurFond;
end;

procedure restitue_styles(indexTCO: integer);
var x,y : integer;
begin
  clVoies[indexTCO]:=clVoiesSV;
  ClFond[indexTCO]:=clFoncSV;
  ClGrille[IndexTCO]:=ClGrilleSV;
  CoulCantonLibre[IndexTco]:=ClCoulCantonLibreSV;
  CoulCantonOccupe[IndexTCO]:=ClCoulCantonOccupeSV;
  for y:=1 to NbreCellY[indexTCO] do
   for x:=1 to NbreCellX[indexTCO] do
     begin
       TCO[indexTCO,x,y].CouleurFond:=ClCoulFondSV[IndexTCO,x,y];
    end;
end;

procedure jeu_clair(indexTCO: integer);
var x,y : integer;
begin
  for indexTCO:=1 to NbreTco do
  begin
    clVoies[indexTCO]:=$A00000;
    ClFond[indexTCO]:=$A00000;
    ClGrille[IndexTCO]:=$FFC0C0;        // bleu
    CoulCantonLibre[IndexTco]:=$A0D0A0;    // vert
    CoulCantonOccupe[IndexTCO]:=$A0A0FF;   // rouge
    for y:=1 to NbreCellY[indexTCO] do
      for x:=1 to NbreCellX[indexTCO] do
        TCO[indexTCO,x,y].CouleurFond:=$c0c0c0;   // blanc doux
  end;
end;

procedure TFormConfigTCO.RadioGroupStyleClick(Sender: TObject);
var indexTCO,AncienJeuCouleurs : integer;
begin
  AncienJeuCouleurs:=JeuCouleurs;
  if ancienJeuCouleurs=1 then sauve_styles_tco(1);
  JeuCouleurs:=RadioGroupStyle.itemIndex+1;

  if (JeuCouleurs<0) or (AncienJeuCouleurs=JeuCouleurs) then exit;

  // mode sombre
  if JeuCouleurs=1 then
  begin
    for indexTCO:=1 to NbreTco do
    begin
      restitue_styles(indexTCO);
      Affiche_tco(indexTCO);
    end;
  end;

  // mode clair
  if JeuCouleurs=2 then
  begin
    for indexTCO:=1 to NbreTco do
    begin
      jeu_clair(indexTCO);
      Affiche_tco(indexTCO);
    end;
  end;

  NB:=JeuCouleurs=3;
end;

procedure TFormConfigTCO.ImageCantonLibreClick(Sender: TObject);
var s : string;
begin
  titre_couleur:='Changer la couleur du canton libre';
  ColorDialog1.Color:=clAllume[indexTCOCourant];

  s:='ColorA='+IntToHex(clfond[indexTCOCourant],6);  // ajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);
  if ColorDialog1.execute then
  begin
    CoulCantonLibre[indexTCOCourant]:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones_config(indexTCOCourant);
    sauve_styles_tco(indexTCOCourant);
  end;
end;

procedure TFormConfigTCO.ImageCantonOccupeClick(Sender: TObject);
var s : string;
begin
  titre_couleur:='Changer la couleur du canton occupé';
  ColorDialog1.Color:=clAllume[indexTCOCourant];

  s:='ColorA='+IntToHex(clfond[indexTCOCourant],6);  // ajouter aux couleurs personnalisées
  colorDialog1.CustomColors.Add(s);
  if ColorDialog1.execute then
  begin
    CoulCantonOccupe[indexTCOCourant]:=ColorDialog1.Color;
    TCO_modifie:=true;
    dessine_icones_config(indexTCOCourant);
    sauve_styles_tco(indexTCOCOurant);
  end;
end;



end.
