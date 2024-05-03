unit Unitplace;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unitprinc, unitpilote , unitDebug, Buttons, ExtCtrls;

type
  TFormRoulage = class(TForm)
    Label1: TLabel;
    ButtonInitAig: TButton;
    ButtonSauve: TButton;
    LabelTexte: TLabel;
    ButtonLanceRoutage: TButton;
    Button1: TButton;
    ButtonArretroutage: TButton;
    BitBtn1: TBitBtn;
    ButtonArretTrains: TButton;
    procedure ButtonInitAigClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSauveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonLanceRoutageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ButtonArretTrainsClick(Sender: TObject);
    procedure ButtonArretroutageClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormRoulage: TFormRoulage;

procedure couleurs_place;
function demarre_index_train(indexTrain  : integer) : boolean;
procedure init_route(indexeventdet,prec,detect,indextrain : integer);
procedure raz_route(indexeventdet,prec,detect,indextrain : integer);

implementation

uses UnitConfig, UnitTCO , UnitHorloge, unitFicheHoraire, Selection_Train;

{$R *.dfm}


procedure raz_route(indexeventdet,prec,detect,indextrain : integer);
begin
  if indexeventdet>N_trains then exit;
  Affiche('RAZ route',clyellow);
  detecteur[detect].etat:=false;
  detecteur[detect].AdrTrain:=0;
  detecteur[detect].train:='';
  detecteur[detect].IndexTrain:=0;

  // dévalider zone
  MemZone[prec,detect].etat:=false;
  MemZone[prec,detect].train:='';
  MemZone[prec,detect].Adrtrain:=0;
  MemZone[prec,detect].IndexTrain:=0;
 //Affiche(inttostr(prec)+' '+intToSTR(detect),clorange);

  // raz 1er élément du tableau
  event_det_train[indexeventdet].NbEl:=0 ;
  event_det_train[indexeventdet].AdrTrain:=0;
  event_det_train[indexeventdet].det[1].adresse:=0;
  event_det_train[indexeventdet].det[1].etat:=false;
  event_det_train[indexeventdet].nom_train:='';

  // il faudrait supprimer et décaler indexeventdet

  detecteur[detect].AdrTrain:=0;

end;


// monte le détecteur detect, affecte son train, valide la zone
// remplit le tableau event_det_train
procedure init_route(indexeventdet,prec,detect,indextrain : integer);
begin
  if indexeventdet>N_trains then exit;

  detecteur[detect].etat:=true;
  detecteur[detect].AdrTrain:=trains[indextrain].adresse;
  detecteur[detect].train:=trains[indextrain].nom_train;
  detecteur[detect].IndexTrain:=indextrain;

  // valider zone précédente
  MemZone[prec,detect].etat:=true;
  MemZone[prec,detect].train:=trains[indextrain].Nom_train;
  MemZone[prec,detect].Adrtrain:=trains[indextrain].adresse;
  MemZone[prec,detect].IndexTrain:=indextrain;
 //Affiche(inttostr(prec)+' '+intToSTR(detect),clorange);

  // remplir 1er élément du tableau
  event_det_train[indexeventdet].NbEl:=1 ;
  event_det_train[indexeventdet].AdrTrain:=trains[indextrain].adresse;
  event_det_train[indexeventdet].det[1].adresse:=prec;
  event_det_train[indexeventdet].det[1].etat:=false;
  event_det_train[indexeventdet].nom_train:=trains[indextrain].nom_train;

  Event_Detecteur(detect,true,trains[indexTrain].nom_train);
  detecteur[detect].AdrTrain:=trains[indexTrain].adresse;

end;


procedure TFormRoulage.ButtonInitAigClick(Sender: TObject);
begin
  if cdm_connecte then
  begin
    Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;
  ButtonLanceRoutage.Enabled:=false;
  init_aiguillages;
  ButtonLanceRoutage.Enabled:=true;
end;

procedure TFormRoulage.FormActivate(Sender: TObject);
begin
  if affevt then affiche('FormPlace activate',clLime);
  defocusControl(ButtonInitAig,false);
end;


procedure TFormRoulage.Button1Click(Sender: TObject);
begin
  formconfig.PageControl.ActivePage:=formconfig.TabSheetTrains;
  formconfig.showmodal;
  formconfig.Close;
end;

procedure TFormRoulage.ButtonSauveClick(Sender: TObject);
begin
  sauve_config;
end;

procedure TFormRoulage.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

// démarre un train si le signal n'est pas au rouge
function demarre_index_train(indexTrain  : integer) : boolean;
var det,vitesse,AdrTrain,i,adrSignal,id,a,idcanton,sens : integer;
    trouve,rouge : boolean;
    Train,s : string;

begin
  // si il y a un signal sur le détecteur de démarrage du train est il au rouge?
  i:=1;
  AdrTrain:=Trains[indexTrain].adresse;
  Train:=Trains[indexTrain].nom_train;
  det:=0;

  vitesse:=trains[indexTrain].VitNominale;
  if roulage then
  begin
    if trains[indexTrain].inverse then vitesse:=-vitesse;
    Idcanton:=trains[indexTrain].canton;
    {if idcanton>0 then
    begin
      sens:=canton[idcanton].Sens;
      if (sens=sensdroit) or (sens=senshaut) then det:=canton[idcanton].el2;
      if (sens=sensGauche) or (sens=sensbas) then det:=canton[idcanton].el1;
    end;}

    init_route_canton(idcanton,Indextrain,true);
  end;

  if horloge then
  begin
    // trouver le train dans la grille horaire
    i:=1;
    trouve:=false;
    while (i<MaxHoraire) and not(trouve)do
    begin
      trouve:=grilleHoraire[i].NomTrain=train;
      inc(i);
    end;
    dec(i);
    vitesse:=GrilleHoraire[i].vitesse;
    vitesse_loco(train,indextrain,adrTrain,vitesse,true);
    exit;
  end;


  // vitesse_loco('',adrTrain,j,trains[j].VitNominale,not(placement[j].inverse),true);
  vitesse_loco('',indextrain,adrTrain,vitesse,true);
  Maj_Signaux(true);  // avec détecteurs
  s:='Lancement du train '+train;
  if det<>0 then s:=s+' depuis détecteur '+intToSTR(Det);
  Affiche(s,clYellow);
  if traceListe then AfficheDebug(s,clyellow);


  //if roulage then reserve_canton(Det,suivant,adrtrain,0,nCantonsRes);
end;


procedure TFormRoulage.ButtonLanceRoutageClick(Sender: TObject);
var i,j,adrDet,AdrTrain : integer;
    trouve,demarre : boolean;
begin
  if cdm_connecte then
  begin
    Affiche('Le placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;

  trouve:=false;

  for i:=1 to ncantons do
  begin
    adrTrain:=canton[i].adresseTrain;
    if adrTrain<>0 then
    begin
      trouve:=true;
      roulage:=true;
      j:=index_train_adresse(AdrTrain);
      demarre:=demarre_index_train(j);

    end;


  end;


  // au moins un train démarre
  if trouve then
  begin
    Maj_Signaux(true);
    Formprinc.LabelTitre.caption:=titre+' - Mode roulage en cours';
    with Formprinc.SBMarcheArretLoco do
    begin
      Visible:=true;
    end;
  end;
  if not(trouve) then Affiche('Pas de train placé sur les cantons du TCO',clOrange);
end;

procedure TFormRoulage.ButtonArretTrainsClick(Sender: TObject);
var i : integer;
begin
  roulage:=false;
  avecRESA:=formConfig.CheckBoxRESA.Checked;
  Affiche('Arrêt du roulage de tous les trains',clorange);
  Formprinc.LabelTitre.caption:=titre+' ';
  for i:=1 to ntrains do
    vitesse_loco('',i,trains[i].adresse,0,true);
end;

procedure couleurs_place;
var i : integer;
    c : tComponent;
begin
  if sombre then with formRoulage do
  begin
    color:=couleurFond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;
end;

procedure TFormRoulage.FormCreate(Sender: TObject);
begin
  if affevt then affiche('FormPlace Create',clLime);
  if debug=1 then Affiche('Début création fenetre Place',clLime);
  position:=poMainFormCenter;
  PlaceAffiche:=true;
  couleurs_place;
  if debug=1 then Affiche('Fin création fenetre Place',clLime);
end;

procedure TFormRoulage.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFormRoulage.ButtonArretroutageClick(Sender: TObject);
var i : integer;
begin
  roulage:=false;
  Affiche('Arrêt du roulage de tous les trains et libération des aiguillages',clorange);
  Formprinc.LabelTitre.caption:=titre+' ';
  for i:=1 to ntrains do
    vitesse_loco('',i,trains[i].adresse,0,true);
  raz_tout;
end;

begin
end.
