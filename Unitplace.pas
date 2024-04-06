unit Unitplace;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unitprinc, unitpilote , unitDebug, Buttons;

type
  TFormPlace = class(TForm)
    Label1: TLabel;
    ButtonInitAig: TButton;
    ButtonSauve: TButton;
    LabelTrain1: TLabel;
    LabelTrain2: TLabel;
    LabelTrain3: TLabel;
    LabelTrain4: TLabel;
    LabelTrain5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    LabelTrain6: TLabel;
    Edit6: TEdit;
    Label2: TLabel;
    ButtonPlace: TButton;
    LabelTexte: TLabel;
    Label3: TLabel;
    ButtonLanceRoutage: TButton;
    Button1: TButton;
    ButtonArretroutage: TButton;
    CheckInverse1: TCheckBox;
    CheckInverse2: TCheckBox;
    CheckInverse3: TCheckBox;
    CheckInverse4: TCheckBox;
    CheckInverse5: TCheckBox;
    CheckInverse6: TCheckBox;
    EditDir1: TEdit;
    Label4: TLabel;
    EditDir2: TEdit;
    EditDir3: TEdit;
    EditDir4: TEdit;
    EditDir5: TEdit;
    EditDir6: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    ButtonArretTrains: TButton;
    procedure ButtonInitAigClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonPlaceClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSauveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonLanceRoutageClick(Sender: TObject);
    procedure CheckInverse1Click(Sender: TObject);
    procedure CheckInverse2Click(Sender: TObject);
    procedure CheckInverse3Click(Sender: TObject);
    procedure CheckInverse4Click(Sender: TObject);
    procedure CheckInverse5Click(Sender: TObject);
    procedure CheckInverse6Click(Sender: TObject);
    procedure EditDir1Change(Sender: TObject);
    procedure EditDir2Change(Sender: TObject);
    procedure EditDir3Change(Sender: TObject);
    procedure EditDir4Change(Sender: TObject);
    procedure EditDir5Change(Sender: TObject);
    procedure EditDir6Change(Sender: TObject);
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
  FormPlace: TFormPlace;

procedure couleurs_place;
function demarre_index_train(indexTrain  : integer) : boolean;

implementation

uses UnitConfig, UnitTCO , UnitHorloge, unitFicheHoraire;

{$R *.dfm}



procedure TFormPlace.ButtonInitAigClick(Sender: TObject);
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

procedure TFormPlace.FormActivate(Sender: TObject);
begin
  if affevt then affiche('FormPlace activate',clLime);
  LabelTrain1.Caption:=trains[1].nom_train;
  Edit1.text:=intToSTR(placement[1].detecteur);
  EditDir1.Text:=IntToSTR(placement[1].detdir);
  CheckInverse1.Checked:=placement[1].inverse;
  LabelTrain2.Caption:=trains[2].nom_train;
  EditDir2.Text:=IntToSTR(placement[2].detdir);
  CheckInverse2.Checked:=placement[2].inverse;
  Edit2.text:=intToSTR(placement[2].detecteur);
  CheckInverse3.Checked:=placement[3].inverse;
  EditDir3.Text:=IntToSTR(placement[3].detdir);
  LabelTrain3.Caption:=trains[3].nom_train;
  Edit3.text:=intToSTR(placement[3].detecteur);
  LabelTrain4.Caption:=trains[4].nom_train;
  EditDir4.Text:=IntToSTR(placement[4].detdir);
  Edit4.text:=intToSTR(placement[4].detecteur);
  CheckInverse4.Checked:=placement[4].inverse;
  LabelTrain5.Caption:=trains[5].nom_train;
  EditDir5.Text:=IntToSTR(placement[5].detdir);
  Edit5.text:=intToSTR(placement[5].detecteur);
  CheckInverse5.Checked:=placement[5].inverse;
  LabelTrain6.Caption:=trains[6].nom_train;
  EditDir6.Text:=IntToSTR(placement[6].detdir);
  Edit6.text:=intToSTR(placement[6].detecteur);
  CheckInverse6.Checked:=placement[6].inverse;
  defocusControl(ButtonInitAig,false);
end;

procedure TFormPlace.ButtonPlaceClick(Sender: TObject);
var Suiv,prec,detect,erreur,i,it,indexTCO : integer;
    s,Ssuiv,NomTrain : string;
begin
  if cdm_connecte then
  begin
    Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;

  raz_tout;
  for detect:=1 to NbMaxDet do
  begin
    detecteur[detect].train:='';
    detecteur[detect].AdrTrain:=0;
    detecteur[detect].IndexTrain:=0;
    detecteur[detect].etat:=false;
  end;

  it:=0;
  for i:=1 to 6 do
  begin
    case i of
    1 : begin s:=edit1.Text;Ssuiv:=EditDir1.Text;end;
    2 : begin s:=edit2.Text;Ssuiv:=EditDir2.Text;end;
    3 : begin s:=edit3.Text;Ssuiv:=EditDir3.Text;end;
    4 : begin s:=edit4.Text;Ssuiv:=EditDir4.Text;end;
    5 : begin s:=edit5.Text;Ssuiv:=EditDir5.Text;end;
    6 : begin s:=edit6.Text;Ssuiv:=EditDir6.Text;end;
    end;

    if (s<>'') and (Ssuiv<>'') then
    begin
      val(s,detect,erreur);
      val(Ssuiv,Suiv,erreur);
      NomTrain:=trains[i].nom_train;
      if (detect>NbMaxDet )then LabelTexte.caption:='Erreur détecteur train '+intToSTR(i);
      if detect<>0 then
      begin
        prec:=det_suiv_cont(Suiv,detect,1);  // détecteur précédent (d'ou vient la loco) arret sur suivant
        if (prec<9990) then
        begin
          inc(it);

          detecteur[detect].etat:=true;
          detecteur[detect].AdrTrain:=trains[i].adresse;
          detecteur[detect].train:=placement[i].train;
          detecteur[detect].IndexTrain:=i;

          // valider zone précédente
          MemZone[prec,detect].etat:=true;
          MemZone[prec,detect].train:=placement[i].train;
          MemZone[prec,detect].Adrtrain:=trains[i].adresse;
          MemZone[prec,detect].IndexTrain:=i;
          //Affiche(inttostr(prec)+' '+intToSTR(detect),clorange);

          // remplir 1er élément du tableau
          event_det_train[it].NbEl:=1 ;
          event_det_train[it].AdrTrain:=trains[i].adresse;
          event_det_train[it].det[1].adresse:=prec;
          event_det_train[it].det[1].etat:=false;
          event_det_train[it].nom_train:=placement[i].train;

          inc(N_trains);

          // essai-------------------------
          Event_Detecteur(detect,true,nomtrain);
          detecteur[detect].AdrTrain:=trains[i].adresse;
          // -----------------------------

          Affiche('Positionnement train '+detecteur[detect].train+' sur détecteur '+intToSTR(detect)+' vers '+Ssuiv,clLime);


        end
        else
        begin
          s:='Train '+nomtrain +' non positionné car détecteurs '+IntToSTR(detect)+' '+intToSTR(suiv)+' non consécutifs';
          Affiche(s,clred);
          detecteur[detect].etat:=false;
          detecteur[detect].train:='';
          detecteur[detect].adrTrain:=0;
        end;
      end
      else
      begin
        detecteur[detect].etat:=false;
        detecteur[detect].train:='';
        detecteur[detect].adrTrain:=0;
      end;
    end;
  end;

  indexTCO:=1;
  if formTCO[indexTCO].Showing then
  begin
    affiche_tco(1);
  end;
  Maj_Signaux(true);
  Maj_Signaux(true);
end;

procedure TFormPlace.Edit1Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit1.Text,i,erreur);
  if (erreur<>0) or (i<0) then
  begin
    LabelTexte.caption:='Erreur détecteur 1';
    exit;
  end;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[1].train:=trains[1].nom_train;
  placement[1].detecteur:=i;
end;

procedure TFormPlace.Edit2Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit2.Text,i,erreur);
  if (erreur<>0) or (i<0) then
  begin
    LabelTexte.caption:='Erreur détecteur 2';
    exit;
  end;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[2].train:=trains[2].nom_train;
  placement[2].detecteur:=i;
end;

procedure TFormPlace.Edit3Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit3.Text,i,erreur);
  if (erreur<>0) or (i<0) then
  begin
    LabelTexte.caption:='Erreur détecteur 3';
    exit;
  end;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[3].train:=trains[3].nom_train;
  placement[3].detecteur:=i;
end;

procedure TFormPlace.Edit4Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit4.Text,i,erreur);
  if (erreur<>0) or (i<0) then
  begin
    LabelTexte.caption:='Erreur détecteur 4';
    exit;
  end;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[4].train:=trains[4].nom_train;
  placement[4].detecteur:=i;
end;

procedure TFormPlace.Edit5Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit5.Text,i,erreur);
  if (erreur<>0) or (i<0) then
  begin
    LabelTexte.caption:='Erreur détecteur 5';
    exit;
  end;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[5].train:=trains[5].nom_train;
  placement[5].detecteur:=i;
end;

procedure TFormPlace.Edit6Change(Sender: TObject);
var i,erreur : integer;
begin
  val(edit6.Text,i,erreur);
  if (erreur<>0) or (i<0) then
  begin
    LabelTexte.caption:='Erreur détecteur 6';
    exit;
  end;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[6].train:=trains[6].nom_train;
  placement[6].detecteur:=i;
end;

procedure TFormPlace.Button1Click(Sender: TObject);
begin
  formconfig.PageControl.ActivePage:=formconfig.TabSheetTrains;
  formconfig.showmodal;
  formconfig.Close;
end;

procedure TFormPlace.ButtonSauveClick(Sender: TObject);
begin
  sauve_config;
end;

procedure TFormPlace.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=chr(27) then close;
end;

// démarre un train si le signal n'est pas au rouge
function demarre_index_train(indexTrain  : integer) : boolean;
var det,vitesse,AdrTrain,i,indexPlace,adrSignal,id,a : integer;
    trouve,rouge : boolean;
    Train,s : string;

begin
   // si il y a un signal sur le détecteur de démarrage du train est il au rouge?
  i:=1;
  AdrTrain:=Trains[indexTrain].adresse;
  Train:=Trains[indexTrain].nom_train;

  det:=0;
  while (i<Ndetecteurs) and not(trouve) do
  begin
    Det:=Adresse_detecteur[i];
    trouve:=detecteur[i].AdrTrain=AdrTrain;
    inc(i);
  end;

  // le train est sur un détecteur ?
  if trouve then
  begin
   AdrSignal:=signal_detecteur(det); // trouve l'adresse du signal correspondant au détecteur
   if AdrSignal<>0 then
    begin
      id:=index_Signal(AdrSignal);
      a:=Signaux[id].EtatSignal;
      // si signal n'est pas rouge, ok
      rouge:=(a=semaphore_F) or (a=carre_F) and (a=violet_F);
      if rouge then
      begin
        Affiche('Le signal '+intToSTR(AdrSignal)+' étant rouge, le train '+train+' @'+intToSTR(AdrTrain)+' ne démarre pas',clyellow);
        result:=false;
        exit;
      end;
    end;
  end;

  vitesse:=trains[indexTrain].VitNominale;
  if roulage then
  begin
    // trouver le train dans le tableau de placement des trains
    indexPlace:=1;
    trouve:=false;
    while (indexPlace<6) and not(trouve)do
    begin
      trouve:=placement[indexPlace].train=train;
      inc(indexPlace);
    end;
    if not(trouve) then
    begin
      Affiche('Erreur 280 : Train '+train+' non trouvé en placement',clred);
      result:=false;
      exit;
    end;
    dec(indexPlace);
    if (placement[indexPlace].inverse) then vitesse:=-vitesse;
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
  if roulage then reserve_canton(Det,placement[indexPlace].detdir,adrtrain,0,nCantonsRes);
end;


procedure TFormPlace.ButtonLanceRoutageClick(Sender: TObject);
var i,j,adrDet,AdrTrain : integer;
    trouve,demarre : boolean;
begin
  if cdm_connecte then
  begin
    Affiche('Le placement des trains incompatible en mode CDM rail',clOrange);
    exit;
  end;

  trouve:=false;
  // explorer les détecteurs pour lancer les trains si le détecteur est affecté à un train
  for i:=1 to NDetecteurs do
  begin
    adrDet:=Adresse_detecteur[i];
    AdrTrain:=detecteur[AdrDet].AdrTrain;
    j:=index_train_adresse(AdrTrain);

    if Detecteur[adrDet].etat and (detecteur[adrDet].train<>'') then
    begin
      trouve:=true;
      roulage:=true;
      avecResa:=false;  // pour adrTrain ou NumTrain


      trains[j].roulage:=true;

      demarre:=demarre_index_train(j);
    end
    else
      trains[j].roulage:=false;
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
  if not(trouve) then Affiche('Pas de train placé',clOrange);
end;

procedure TFormPlace.ButtonArretTrainsClick(Sender: TObject);
var i : integer;
begin
  roulage:=false;
  avecRESA:=formConfig.CheckBoxRESA.Checked;
  Affiche('Arrêt du roulage de tous les trains',clorange);
  Formprinc.LabelTitre.caption:=titre+' ';
  for i:=1 to ntrains do
    vitesse_loco('',i,trains[i].adresse,0,true);
end;

procedure TFormPlace.CheckInverse1Click(Sender: TObject);
begin
  placement[1].inverse:=CheckInverse1.Checked;
end;

procedure TFormPlace.CheckInverse2Click(Sender: TObject);
begin
  placement[2].inverse:=CheckInverse2.Checked;
end;

procedure TFormPlace.CheckInverse3Click(Sender: TObject);
begin
  placement[3].inverse:=CheckInverse3.Checked;
end;

procedure TFormPlace.CheckInverse4Click(Sender: TObject);
begin
  placement[4].inverse:=CheckInverse4.Checked;
end;

procedure TFormPlace.CheckInverse5Click(Sender: TObject);
begin
  placement[5].inverse:=CheckInverse4.Checked;
end;

procedure TFormPlace.CheckInverse6Click(Sender: TObject);
begin
  placement[6].inverse:=CheckInverse6.Checked;
end;

procedure TFormPlace.EditDir1Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir1.Text,i,erreur);
  if (erreur<>0) or (i<0) then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[1].detdir:=i;
end;

procedure TFormPlace.EditDir2Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir2.Text,i,erreur);
  if (erreur<>0) or (i<0) then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[2].detdir:=i;
end;

procedure TFormPlace.EditDir3Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir3.Text,i,erreur);
  if (erreur<>0) or (i<0) then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[3].detdir:=i;
end;

procedure TFormPlace.EditDir4Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir4.Text,i,erreur);
  if (erreur<>0) or (i<0) then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[4].detdir:=i;
end;

procedure TFormPlace.EditDir5Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir5.Text,i,erreur);
  if (erreur<>0) or (i<0) then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[5].detdir:=i;
end;

procedure TFormPlace.EditDir6Change(Sender: TObject);
var i,erreur : integer;
begin
  val(editDir6.Text,i,erreur);
  if (erreur<>0) or (i<0) then exit;
  if index_adresse_detecteur(i)=0 then
  begin
    LabelTexte.caption:='Détecteur '+intToSTR(i)+' inexistant';
    exit;
  end;
  labelTexte.caption:='';
  placement[6].detdir:=i;
end;

procedure couleurs_place;
var i : integer;
    c : tComponent;
begin
  if sombre then with formPlace do
  begin
    color:=couleurFond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      composant(c,couleurFond,couleurTexte);
    end;
  end;
end;

procedure TFormPlace.FormCreate(Sender: TObject);
begin
  if affevt then affiche('FormPlace Create',clLime);
  if debug=1 then Affiche('Début création fenetre Place',clLime);
  position:=poMainFormCenter;
  PlaceAffiche:=true;
  couleurs_place;
  if debug=1 then Affiche('Fin création fenetre Place',clLime);
end;

procedure TFormPlace.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFormPlace.ButtonArretroutageClick(Sender: TObject);
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
