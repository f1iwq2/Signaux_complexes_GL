unit UnitRouteTrains;

// choix de la route pour tous les trains
// lance le roulage des trains

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,

  unitprinc,UnitConfig,unitTCO,UnitHorloge,unitFicheHoraire,UnitDebug,UnitRoute,selection_train;


type
  TFormRouteTrain = class(TForm)
    ComboBoxTrains: TComboBox;
    PageControlRoutes: TPageControl;
    TabSheetRA: TTabSheet;
    TabSheetRM: TTabSheet;
    ButtonEfface: TButton;
    ButtonSupprime: TButton;
    ButtonRouler1Tr: TButton;
    ButtonRoulerTsTrains: TButton;
    ButtonSauveRoute: TButton;
    ButtonM: TButton;
    ButtonQuitte: TButton;
    Panel1: TPanel;
    LabelRoute: TLabel;
    ImageTrainR: TImage;
    ListBoxRM: TListBox;
    ListBoxRA: TListBox;
    LabelRC: TLabel;
    LabelRM: TLabel;
    ButtonSR: TButton;
    ButtonSRS: TButton;
    EditnomRoute: TEdit;
    Label1: TLabel;
    CheckBoxSens: TCheckBox;
    CheckBoxSIRA: TCheckBox;
    LabelID: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ButtonQuitteClick(Sender: TObject);
    procedure ComboBoxTrainsChange(Sender: TObject);
    procedure RichEditRouteMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonEffaceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSupprimeClick(Sender: TObject);
    procedure ButtonRouler1TrClick(Sender: TObject);
    procedure ButtonRoulerTsTrainsClick(Sender: TObject);
    procedure ButtonSauveRouteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonMClick(Sender: TObject);
    procedure ListBoxRMMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBoxRAMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonSRClick(Sender: TObject);
    procedure ButtonSRSClick(Sender: TObject);
    procedure EditnomRouteChange(Sender: TObject);
    procedure ListBoxRMKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBoxSensClick(Sender: TObject);
    procedure CheckBoxSIRAClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;


var
  FormRouteTrain: TFormRouteTrain;
  IrPref : integer;

function aig_canton(idTrain,detect : integer) : integer;
function demarre_index_train(indexTrain  : integer) : boolean;
procedure couleurs_routeTrains;
function routes_identiques(route1,route2 : TUneroute) : boolean;

implementation

{$R *.dfm}

// renvoie l'adresse du signal du train sur détecteur
function Adresse_signal_det_train(detect,IndexTrain : integer) : integer;
var voie1,voie2,indexSig1,IndexSig2,AdrSig1,AdrSig2,IndexSig,AdrSig : integer;
    s : string;
begin
  if detect=0 then
  begin
    result:=0;
    exit;
  end;
  index_signal_det(detect,voie1,indexSig1,voie2,indexSig2);
  AdrSig:=0;AdrSig1:=0;AdrSig2:=0;
  if indexSig1<>0 then AdrSig1:=signaux[indexSig1].adresse;
  if indexSig2<>0 then AdrSig2:=signaux[indexSig2].adresse;

  // si le détecteur sur le train au départ dispose d'un signal
  if (AdrSig1<>0) or (AdrSig2<>0) then
  begin
    indexSig:=0;
    if (signaux[indexSig1].Adr_el_suiv1=trains[IndexTrain].ElSuivant) and (signaux[indexSig1].Btype_suiv1=trains[IndexTrain].TElSuivant) then
      indexSig:=IndexSig1;
    if (signaux[indexSig2].Adr_el_suiv1=trains[IndexTrain].ElSuivant) and (signaux[indexSig2].Btype_suiv1=trains[IndexTrain].TElSuivant) then
      indexSig:=IndexSig2;

    {
    // trouver le premier détecteur de la route et son suivant non traité pour trouver le signal dans le bon sens
    n:=trains[indexTrain].route[0].adresse;
    i:=1;det1:=0;el2:=0;trouve:=false;
    with trains[indexTrain] do
    begin
      repeat
        if route[i].typ=det then
        begin
          det1:=route[i].adresse;
          el2:=route[i+1].adresse;tel2:=route[i+1].typ;
          trouve:=true
        end;
        inc(i);
      until trouve or (i>n);
    end;

    //trouve le signal dans le bon sens
    IndexSig:=0;
    if AdrSig1<>0 then
    begin
      if (signaux[indexSig1].Adr_el_suiv1=el2) and (signaux[indexSig1].Btype_suiv1=tel2) then IndexSig:=IndexSig1;
    end;
    if adrSig2<>0 then
    begin
      if (signaux[indexSig2].Adr_el_suiv1=el2) and (signaux[indexSig2].Btype_suiv1=tel2) then IndexSig:=IndexSig2;
    end;
    }

    //AdrSig:=signaux[indexSig].adresse;
    if IndexSig=0 then begin result:=0;exit;end;

    //Affiche('IndexSig='+intToSTR(IndexSig)+' detect='+intToSTR(detect),clred);
    result:=signaux[indexSig].adresse;
    exit;
  end
  else result:=0;  // pas de signal
end;

// démarre un train si le signal n'est pas au rouge
// appelé par gestion des horaires dans le timer  ou  bouton rouler 1 train ou rouler tous les trains
function demarre_index_train(indexTrain  : integer) : boolean;
var i,n,det1,el2,vitesse,AdrTrain,idcanton,voie1,voie2,indexSig1,indexSig2,AdrSig1,AdrSig2,AdrSig,
    detect,indexSig,etsign : integer;
    tel2 : tequipement;
    trouve : boolean;
    Train,s : string;

begin
  formprinc.SBMarcheArretLoco.Visible:=true;

  //Affiche('demarre_index_Train',clWhite);
  // si il y a un signal sur le détecteur de démarrage du train est il au rouge?

  AdrTrain:=Trains[indexTrain].adresse;
  trains[indexTrain].PointRout:=0;
  Train:=Trains[indexTrain].nom_train;

  // balayer les détecteurs pour trouver sur quel détecteur est le train
  i:=1;
  repeat
    detect:=adresse_detecteur[i];
    trouve:=detecteur[detect].AdrTrain=AdrTrain;
    inc(i);
  until trouve or (i>NDetecteurs);
  if not trouve then
  begin
    detect:=0;
    Affiche('Le train '+train+' n''est pas déclaré sur le détecteur d''un canton',clOrange);
    Affiche('ou le détecteur du train n''est pas activé',clOrange);
    exit;
  end;

  roulage:=true;
  trains[indexTrain].dernierdet:=detect;
  if debugRoulage then
  begin
    Affiche('Le train '+train+' est sur le détecteur '+intToSTR(detect),clWhite);
  end;

  etsign:=Adresse_signal_det_train(detect,indexTrain);
  if etSign<>0 then
  begin
    if traceliste then Affiche('Le signal dans le bon sens est '+intToSTR(EtSign)+' '+chaine_signal(EtSign),clOrange);
    if signal_rouge(etSign) then
    begin
      s:='Le train '+trains[indexTrain].nom_train+' est arreté au signal '+intToSTR(etSign);
      affiche(s,clyellow);
      trains[indexTrain].roulage:=1;
      exit;  // on sort car on ne démarre pas un train arrêté au rouge
    end;
  end;

  vitesse:=trains[indexTrain].VitNominale;
 // trains[indexTrain].route[0].talon:=grilleHoraire[i].sens;    // copier le sens
//  if trains[indexTrain].inverse then vitesse:=-vitesse;

  if trains[indexTrain].route[0].talon then vitesse:=-vitesse;
  Idcanton:=trains[indexTrain].canton;

  // à supprimer, utilisé pour démarrer le train à la vitesse de la grille horaire mais à supprimer aussi
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
    if trouve then
    begin
      dec(i);
      vitesse:=GrilleHoraire[i].vitesse;
      if trains[indexTrain].route[0].talon then vitesse:=-vitesse;
      trains[indexTrain].roulage:=2;
      vitesse_loco(train,indextrain,adrTrain,vitesse,10,0);
    end;
  end;

  Maj_Signaux(true);  // avec détecteurs

  s:='Lancement du train '+train;
  if detect<>0 then s:=s+' depuis détecteur '+intToSTR(Detect);
  Affiche(s,clYellow);
  if nivdebug>=1 then AfficheDebug(s,clyellow);
  trains[indexTrain].roulage:=2;
  if traceListe then AfficheDebug(s,clyellow);

  // au lancement du train de la route, initialiser le tableau
  // event_det_train à 1
  i:=1;
  repeat
    if event_det_train[i].AdrTrain=AdrTrain then
    begin
      event_det_train[i].NbEl:=1;
      event_det_train[i].Det[1].adresse:=trains[indexTrain].DetecteurA;
      event_det_train[i].Det[1].etat:=true;
    end;
    inc(i);
  until (i>n_trains);

  i:=trains[indexTrain].TempsDemarreSig;
  if i=0 then i:=1;
  trains[indextrain].TempoDemarre:=i;   // démarrage à la vitesse nominale
end;

// si les routes route1 et route2 sont identiques, retourne vrai
function routes_identiques(route1,route2 : TUneroute) : boolean;
var n,i : integer;
    egal : boolean;
begin
  n:=route1[0].adresse;
  if n=route2[0].adresse then
  begin
    i:=1;
    repeat
      egal:=(route1[i].adresse=route2[i].adresse) and (route1[i].typ=route2[i].typ);
      inc(i);
    until (i>n) or not(egal);
    result:=egal;
  end
  else result:=false;
end;

// mise à jour des infos de la fenetre : combobox
procedure maj_infos(idtrain : integer);
var i,j,PixelLength : integer;
    s : string;
begin
  if idtrain<1 then exit;
  formRouteTrain.comboBoxTrains.Clear;
  formRouteTrain.ListBoxRM.Clear;
  for i:=1 to NTrains do
  begin
    s:=trains[i].nom_train;
    if trains[i].route[0].adresse<>0 then s:=s+' [route affectée]';
    j:=trains[i].routePref[0][0].adresse;
    if j<>0 then
    begin
      s:=s+' ['+intToSTR(j)+' route';
      if j=1 then s:=s+' mémorisée]';
      if j>1 then s:=s+'s mémorisées]';
    end;
    formRouteTrain.comboBoxTrains.items.add(s);
  end;

  formRouteTrain.comboBoxTrains.ItemIndex:=indexTrainFR-1;

  Maj_icone_train(FormRouteTrain.ImageTrainR,idTrain,clWhite);
  with formRouteTrain do
  begin
    TabSheetRM.Enabled:=false;
    ListBoxRA.Clear;

    if trains[idtrain].route[0].adresse<>0 then  // route affectée au train
    begin
      LabelRC.Caption:='Route courante affectée au train '+trains[idtrain].nom_train+
                       ' : '+trains[idTrain].NomRouteCour;
      s:=route_restreinte_to_string(trains[idTrain].route);
      ListBoxRA.items.Add(s);
      // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
      PixelLength:=Canvas.TextWidth(s)+30;
      SendMessage(ListBoxRA.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);

      labelroute.caption:='Route affectée au train '+trains[idtrain].nom_train;
      ButtonRouler1tr.caption:='Rouler le train '+trains[idtrain].nom_train;
      ButtonRouler1tr.enabled:=true;
    end
    else
    begin
      LabelRC.Caption:='Pas de route courante affectée au train '+trains[idtrain].nom_train;
      labelroute.caption:='Pas de route courante affectée au train '+trains[idtrain].nom_train;
    end;

    j:=trains[idtrain].routePref[0][0].adresse;
    TabSheetRM.Caption:='Routes mémorisées ('+intToSTR(j)+')';
    if j<>0 then  // nombre de route mémorisée du train
    begin
      s:=intToSTR(j)+' route';
      if j=1 then s:=s+' mémorisée au train ';
      if j>1 then s:=s+'s mémorisées au train ';
      s:=s+trains[idtrain].nom_train;
      LabelRM.Caption:=s;
      TabSheetRM.Enabled:=true;
      i:=1;
      PixelLength:=0;
      for j:=1 to trains[idtrain].routePref[0][0].adresse do
      begin
        s:='Id='+intToSTR(trains[idTrain].routePref[j][0].pos)+' '+route_restreinte_to_string(trains[idTrain].routePref[j]);
        if Canvas.TextWidth(s)+30>PixelLength then PixelLength:=Canvas.TextWidth(s)+30;
        ListBoxRM.Items.Add(s);
      end;
      EditNomRoute.Text:=trains[idTrain].NomRouteCour;
      SendMessage(ListBoxRM.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);      // crée la HorzScroll baz
    end
    else LabelRM.Caption:='Pas de route mémorisée au train '+trains[idtrain].nom_train;

    if (trains[idTrain].route[0].adresse=0) and (trains[idTrain].routePref[1][0].adresse=0) then
    begin

      ButtonRouler1tr.caption:=' ';
      ButtonRouler1tr.enabled:=false;
    end;
  end;
end;

procedure TFormRouteTrain.FormActivate(Sender: TObject);
begin
  maj_infos(indexTrainFR);

  if ntrains>0 then Maj_icone_train(FormRouteTrain.ImageTrainR,indexTrainFR,clWhite);
end;

procedure TFormRouteTrain.ButtonQuitteClick(Sender: TObject);
begin
  close;
end;

procedure TFormRouteTrain.ComboBoxTrainsChange(Sender: TObject);
begin
  indexTrainFR:=ComboBoxTrains.ItemIndex+1;
  efface_route_tco(false);
  maj_infos(indexTrainFR);
end;

procedure TFormRouteTrain.RichEditRouteMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // si le train de la route est en roulage, ne pas afficher la route car
  // sinon les index des trains passent à 0 dans les cantons par la fonction zone_tco
  if trains[indexTrainFR].roulage=0 then affiche_route_tco;
end;

procedure TFormRouteTrain.ButtonEffaceClick(Sender: TObject);
begin
  efface_route_tco(false);
end;

procedure TFormRouteTrain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  efface_route_tco(false);
  maj_signaux(true);
  maj_signaux(true);
end;

procedure TFormRouteTrain.ButtonSupprimeClick(Sender: TObject);
var r : integer;
begin
  indexTrainFR:=ComboBoxTrains.ItemIndex+1;
  if indexTrainFR<1 then exit;
  if trains[indexTrainfr].route[0].adresse<1 then exit;

  r:=MessageDlg('Voulez-vous supprimer cette route du train '+Trains[indexTrainFR].nom_train+' ?'
                ,mtConfirmation,[mbNo,mbYes],0) ;
  if r=mrNo then exit;

  efface_route_tco(false);

  supprime_route_train(indexTrainFR);

  maj_infos(indexTrainFR);
end;

// Réserve les éléments s'ils ne sont pas déja réservés et positionne les aiguillages
// jusqu'au signal suivant (soit 1 canton)
// en entrée : index du train ; detect=détecteur à partir duquel faire la réservation et le positionnement des aiguillages
// en sortie : si erreur : -1   ou adresse du train qui a réservé le canton
// phase 0 : si le détecteur detect est en fin de route, alors on active l'arret du train
// phase 1 : tester si éléments réservés par train tiers jusqu'aux cantons suivants. Si oui, sortir.
// phase 2 : positionner les aiguillages
// phase 3 : réserver les aiguillages
function aig_canton(idTrain,detect : integer) : integer;
var AdrSig,n,i,ic,j,ideb,iFin,AdrTrain,etat,pointeur,voie1,voie2,indexSig1,indexSig2,AncPr,
    Trainexistant,adr,pos,index,Ncanton,icanton,NumCanton,det_arret,it,PointRoute,ElPrec,
    adr2,etatSig : integer;
    typ,tprec: tequipement;
    trainTiers,SigBonSens,trouve : boolean;
    s : string;
begin
  //traceliste:=true;
  //if (detect=525) and (idTrain=4) then traceliste:=true else traceliste:=false;
  if ProcPrinc then AfficheDebug('Aig_canton '+intToSTR(idTrain)+' '+intToSTR(detect),clWhite);
  if debugRoulage then Affiche('Aig_canton '+intToSTR(idTrain)+' '+intToSTR(detect),clWhite);
  result:=0;

  If traceliste then
  begin
    if detecteur[detect].Etat then etat:=1 else etat:=0;
    affiche('Aig_canton Train id='+intToSTR(idtrain)+' '+intToSTR(detect)+' à '+intToSTR(etat)+'---------------Phase 1',clWhite);
  end;
  AdrTrain:=trains[idTrain].adresse;

  pointeur:=0;
  n:=trains[idTrain].route[0].adresse;
  repeat
    inc(pointeur);
  until (trains[idTrain].route[pointeur].traite=false) or (pointeur+1>=n);

  i:=pointeur-1;
  if i=0 then i:=1; // on commence à 1

  if DebugRoulage then
  begin
    Affiche('AC train @'+intToSTR(AdrTrain)+'Detecteur='+intToSTR(detect)+' Pointeur='+intToSTR(pointeur)+' prec='+intToSTR(trains[idTrain].route[i].adresse),clOrange);
    if i>=n then
    begin
      affiche('La route a été complètement traitée (réservation)',clOrange);
      result:=0;
    end;
  end;

  j:=1;
  AncPr:=trains[idTrain].PointRout;
  repeat

    trouve:=(trains[idTrain].route[j].adresse=detect) and (trains[idTrain].route[j].typ=det) and (j>=AncPr);
    if trouve then
    begin
      trains[idTrain].PointRout:=j;
      PointRoute:=j;
      if DebugRoulage then Affiche('Le pointeur de route est '+intToSTR(j)+'/'+intToSTR(n)+' au détecteur '+intToSTR(detect),clWhite);
    end;
    inc(j);
  until trouve or (j>n);

  // arrêt sur détecteur demandé
  trouve:=false;
  it:=1; // boucle de détecteurs dans les trains
  if roulage and (trains[idTrain].roulage>0) and (pointRoute>1) then
  repeat
    det_arret:=trains[idTrain].DetecteurArret[it].detecteur;
    elPrec:=trains[idTrain].DetecteurArret[it].prec;
    Tprec:=trains[idTrain].DetecteurArret[it].tprec;
    adr2:=0;
    // si le précédent est une TJD 4 états il faut tester les 2 adresses
    if Tprec=aig then
    begin
      j:=index_aig(elprec);
      if (aiguillage[j].modele=tjd) and (aiguillage[j].EtatTJD=4) then
      begin
        adr2:=aiguillage[j].DDroit;  // homologue
      end;
    end;
    if debugRoulage and (Det_arret<>0) then Affiche('Détecteur demande arrêt rencontré ('+intToSTR(det_arret)+')',clYellow);
    // detecteur courant=arret
    if (det_arret=detect) and (detecteur[detect].etat) and
       (trains[idTrain].route[PointRoute-1].adresse=ElPrec) and (trains[idTrain].route[PointRoute-1].typ=tPrec) and
       (pointroute<n) then
    begin
      Affiche('Demande arrêt train '+trains[idTrain].nom_train+' '+intToSTR(trains[idTrain].DetecteurArret[it].temps)+'s sur détecteur '+inttoStr(detect)+' prec='+intToSTR(trains[idTrain].route[PointRoute-1].adresse),ClOrange);
      //trains[idTrain].TempoArret:=2;
      trains[idTrain].TempoArretTemp:=trains[idTrain].DetecteurArret[it].temps*10;
      trains[idTrain].arret_det:=true;
      trains[idTrain].phase_arret:=0;
      trouve:=true;
    end;
    inc(it);
  until (it>NbDetArret) or trouve;

  if pointRoute>=n then
  begin
    // route traitée , arrêter le train
    if debugRoulage then Affiche('AC - Route terminée *****',clred);
    trains[idTrain].arret_det:=true;    // arret du train par le timer
    trains[idTrain].PointRout:=0;
    Trains[idTrain].phase_arret:=0;
  end;

  traintiers:=false;
  icanton:=0;
  ncanton:=0;
  TrainExistant:=0;
  ideb:=trains[idTrain].PointRout;
  ideb:=Pointeur; 
  AdrSig:=0;
  SigBonSens:=false;
  //TraceListe:=true;
  if traceliste then Affiche('Aiguillages',clOrange);
  with trains[idtrain] do
  begin
    // boucle de vérification de réservation des aiguillages par un train même lui même, jusqu'à rencontrer n cantons
    repeat
      typ:=route[i].typ;
      adr:=route[i].adresse;
      typ:=route[i].typ;
      if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
      begin
        if TraceListe then Affiche(intToSTR(adr)+' ',clOrange);
        // vérifier si l'aiguillage est libre
        TrainExistant:=Aiguillage[index_aig(adr)].AdrTrain;
        //if (trainexistant<>AdrTrain) and (TrainExistant<>0) then
        if (TrainExistant<>0) then
        begin
          result:=TrainExistant;
          trains[idtrain].roulage:=1;
          trainTiers:=true;
          if traceListe then Affiche('AC-Aiguillage '+intToSTR(adr)+' réservé par autre train : @='+intToSTR(result),clyellow);
        end;
      end;
      if (typ=det) then
      begin
        TrainExistant:=detecteur[adr].AdrTrainRes;
        if (TrainExistant<>AdrTrain) and (trainExistant<>0) then
        begin
          result:=TrainExistant;
          trains[idtrain].roulage:=1;  // le roulage est arrêté
          traintiers:=true;
          if traceListe then Affiche('AC-Détecteur '+intToSTR(adr)+' réservé par autre train : @='+intToSTR(result),clyellow);
          //exit;
        end;
        // si détecteur comporte signal
        index_signal_det(adr,voie1,indexSig1,voie2,indexSig2);
        if indexSig1<>0 then
        begin
          AdrSig:=0;
          // si le signal est dans le bon sens
          if (i+1<=n) then // si on arrive pas en bout de route
          begin
            if (signaux[indexSig1].Adr_el_suiv1=route[i+1].adresse) then
            begin
              AdrSig:=signaux[indexSig1].adresse;
              if TraceListe then Affiche('AC-Trouvé signal '+intToSTR(AdrSig)+' dans bon sens',clYellow);
              inc(nCanton);
              icanton:=i;
              SigBonSens:=true;
            end
            else
            begin
              if TraceListe then Affiche('AC-Trouvé signal '+intToSTR(signaux[indexSig1].adresse)+' dans mauvais sens',clYellow);
            end;

            if indexSig2<>0 then
            begin
              if (signaux[indexSig2].Adr_el_suiv1=route[i+1].adresse) then
              begin
                AdrSig:=signaux[indexSig2].adresse;
                if TraceListe then Affiche('AC-Trouvé signal '+intToSTR(AdrSig)+' dans bon sens',clYellow);
                inc(nCanton);
                icanton:=i;
                SigBonSens:=true;
              end
              else
              begin
                if TraceListe then Affiche('AC-Trouvé signal '+intToSTR(signaux[indexSig2].adresse)+' dans mauvais sens',clYellow);
              end;
            end;
          end;
        end;
      end;
      inc(i);
    until (i>n) or (SigBonSens and (nCanton=nCantonsRes+1)) or (trainTiers);

    if traceliste then affiche('Phase 2-3',clWhite);
    // phases 2 et 3
    trains[idtrain].roulage:=2; // roulage effectif
    result:=AdrTrain;

    // affectation ifin
    if not(traintiers) then iFin:=i-1 else iFin:=icanton;
    AdrTrain:=trains[idTrain].adresse;

    // balayage du (des) cantons libres -------------------------------------------------------------
    if traceListe or debugRoulage then Affiche('Balayage de '+intToSTR(ideb)+' à '+intToSTR(ifin)+' pour positionner et réserver aiguillages',clYellow);
    for i:=iDeb to iFin do
    begin
      route[i].traite:=true;
      typ:=route[i].typ;
      adr:=route[i].adresse;
      if (typ=aig) or (typ=triple) or (typ=tjs) or (typ=tjd) or (typ=crois) then
      begin
        pos:=route[i].pos;
        index:=index_aig(adr);

        if ((typ=aig) or (typ=triple) or (typ=tjs) or (typ=tjd)) then
        begin
          if aiguillage[index].AdrTrain=0 then
          begin
            pilote_acc(adr,pos,AdrTrain); // pilote l'aig si il est reservé par le train ou non réservé
            Sleep(100);
            s:='AC-Pilote aiguillage '+intToSTR(adr)+'='+intToSTR(pos);
            case pos of
              const_devie : s:=s+' (dévié)';
              const_droit : s:=s+' (droit)';
              else
              s:=s+' non positionné';
            end;
            if debugRoulage then Affiche(s,clWhite);
            if portCommOuvert or parSocketLenz or CDM_connecte then sleep(Tempo_Aig);
            // réservation
            if debugRoulage then Affiche('Réservation Aig '+intToSTR(adr),clCyan);
            aiguillage[index].adrTrain:=AdrTrain;
          end;
        end;
      end;
      if typ=det then
      begin
        detecteur[adr].AdrTrainRes:=adrTrain;
      end;
      Texte_aig_fond(adr);
    end;
  end;
  maj_signaux(false);

  // redémarre le train si arrêté au rouge et qu'il redémarre
  detect:=trains[idTrain].detecteurA;
  if detect<>0 then
  begin
    //Affiche('test Redémarre train '+intToSTR(idTrain)+' detecteur '+intToSTR(detect),clyellow);
    etatSig:=Adresse_signal_det_train(detect,idtrain);
    if (etatSig<>0) and (trains[idTrain].vitesseCons=0) then
    begin
      if not(Signal_Rouge(EtatSig)) then
      begin
        pilote_train(trains[idTrain].detecteurPrec,detect,trains[idTrain].adresse,1);
      end;
    end;
  end;
  //TraceListe:=false;
end;

// bouton rouler 1 train
procedure TFormRouteTrain.ButtonRouler1TrClick(Sender: TObject);
var demarre : boolean;
begin
  if (indexTrainFR<1) then exit;
  hide;
  efface_route_tco(false);

  // positionner les aiguillages de la route
  // si le train est doté d'une route
  if trains[indexTrainFR].route[0].adresse>0 then
  begin
    if debugRoulage then Affiche_routes_brut;
    aig_canton(indexTrainFR,trains[indexTrainFR].route[1].adresse);  // positionne aiguillage et fait les réservations
    demarre:=demarre_index_train(indexTrainFR);    // met la mémoire de roulage du train à 1
  end;
  maj_signaux(true);
  close;    // efface la route du TCO
end;

// bouton rouler tous les trains
procedure TFormRouteTrain.ButtonRoulerTsTrainsClick(Sender: TObject);
var idtrain : integer;
    demarre : boolean;
begin
  if (indexTrainFR<1) then exit;
  hide;
  efface_route_tco(false);
  maj_signaux(true);
  maj_signaux(true);

  // positionner les aiguillages de la 1ère route
  for idtrain:=1 to ntrains do
  begin
    //si le train est doté d'une route
    if trains[idTrain].route[0].adresse>0 then           
    
    begin
      if debugRoulage then Affiche_routes_brut;
      aig_canton(idTrain,trains[idTrain].route[1].adresse);
      demarre:=demarre_index_train(idtrain); // met la mémoire de roulage du train à 1
    end;
  end;
  close;
end;

procedure TFormRouteTrain.ButtonSauveRouteClick(Sender: TObject);
var n,i,j : integer;
    trouve : boolean;
begin
  if (indexTrainFR<1) then exit;
  n:=trains[indexTrainFr].route[0].adresse;
  if n=0 then exit;  // si pas de route

  //vérifier si la route existe déja en route pref
  i:=1;
  trouve:=false;
  repeat
    if trains[indexTrainFR].routePref[i][0].adresse=n then
    begin
      // comparer les éléments de la route "route" aux "routesPref"
      trouve:=true;
      for j:=1 to n do
        trouve:=(trains[indexTrainFR].routePref[i][j].adresse=trains[indexTrainFR].route[j].adresse) and trouve;
    end;
    inc(i);
  until (i>trains[indexTrainFR].routePref[0][0].adresse) or trouve;
  if trouve then
  begin
    LabelRoute.Caption:='La route existe déja en zone mémorisée';
    exit;
  end;

  i:=Trains[indexTrainFr].routePref[0][0].adresse;       // nombre de routes pref
  inc(i);
  if i>30 then
  begin
    LabelRoute.Caption:='Nombre de routes sauvegardées atteint';
    exit;
  end;
  Trains[indexTrainFr].routePref[0][0].adresse:=i;     // nombre de routes pref incrémenté

  Trains[indexTrainFr].routePref[i]:=Trains[IndexTrainFr].route;
  maj_infos(indexTrainFR);
  compile_id_routes;
  Sauve_config;
end;

procedure couleurs_routeTrains;
var c : tcomponent;
    i : integer;
begin
  if Modesombre then with formRouteTrain do
  begin
    Color:=Couleurfond;
    for i:=0 to ComponentCount-1 do
    begin
      c:=Components[i];
      if c is tListBox then
      begin
        (c as tListbox).Color:=color;
      end;
    end;
  end;
end;


procedure TFormRouteTrain.FormCreate(Sender: TObject);
begin
  PageControlRoutes.ActivePageIndex:=0;
  ButtonM.hint:='Affecter la route à ce train lors de sa sauvegarde et '+#13+'affecter le train au canton dans le sens de démarrage de la route';
  couleurs_RouteTrains;
  ComboBoxTrains.ItemIndex:=0;
  IndexTrainFR:=1;
  maj_infos(indexTrainFR);
end;

// choisir cette route mémorisée
procedure TFormRouteTrain.ButtonMClick(Sender: TObject);
var n,sens,el1R,el2R,el1,el2,IdCanton,detfin,IdCantonDest,IdCantonOrg : integer;
    t1,t2,t1R,t2R : tequipement;
begin
  if indexTrainFR<0 then begin labelRoute.caption:='Pas de train';exit;end;

  // la route préférentielle ne peut être validée que si le bon train est sur le bon canton
      // et qu'un des détecteurs est à 1
      // et dans le bon sens
       {//&&&
      det1:=trains[idtrain].routePref[1].adresse;
      IndexCanton:=index_canton_det(det1);
      if false and (canton[indexCanton].IndexTrain=idTrain) and (trains[idtrain].routePref[0].adresse<>0) then
      begin
        RichEditRoute.Lines.Add(route_restreinte_to_string(trains[idTrain].routePref));
        if trains[idtrain].routePref[0].adresse<>0 then
        begin
          labelroute.caption:='Route mémorisée affectée au train '+trains[idtrain].nom_train;
          ButtonRouler1tr.caption:='Rouler le train '+trains[idtrain].nom_train;
          ButtonRouler1tr.enabled:=true;
        end;
      end;
      }

  if trains[indexTrainFR].routePref[IrPref][0].adresse<>0 then
  begin
    trains[indexTrainFR].route:=trains[indexTrainFR].routePref[IrPref];    // affectation de la route au train
    checkBoxSIRA.checked:=trains[indexTrainFR].route[0].talon;
    trains[indexTrainFR].NomRouteCour:=trains[indexTrainFR].NomRoute[IrPref];

    el1R:=trains[indexTrainFR].routePref[IrPref][1].adresse;
    t1R:=trains[indexTrainFR].routePref[IrPref][1].typ;
    el2R:=trains[indexTrainFR].routePref[IrPref][2].adresse;
    t2R:=trains[indexTrainFR].routePref[IrPref][2].typ;

    // canton du départ de la route
    IdCanton:=index_canton_det(el1R);       // trouve l'index du canton du détecteur el1R (départ de route) = c'est le canton origine de la route
    if IdCanton=0 then begin labelRoute.caption:='Le train de départ n''est pas sur un canton';exit;end;
    FormRouteTrain.Caption:=trains[indexTrainFR].nom_train+' départ depuis canton '+intToSTR(canton[IdCanton].numero)+' '+canton[idcanton].nom;

    // déterminer le sens de la route pour affecter le sens de la loco dans le canton origine
    el1:=canton[idcanton].el1;
    t1:=canton[idcanton].typ1;  // toujours un détecteur
    el2:=canton[idcanton].el2;
    t2:=canton[idcanton].typ2;

    sens:=0;
    // cas 1 : les deux éléments du canton sont des détecteurs
    if (t1=det) and (t2=det) then
    begin
      // sous cas 1 : le 2ème élément de la route est un détecteur
      if t2r=det then
      begin
        if (el1r=el1) and (el2r=el2) then
          if canton[IdCanton].horizontal then sens:=SensDroit else sens:=SensBas;
        if (el1r=el2) and (el2r=el1) then
          if canton[IdCanton].horizontal then sens:=SensGauche else sens:=SensHaut;
      end
      else
      // sous cas 2 : le 2ème élement de la route est un aiguillage
      begin
        if (el1r=el2) then
          if canton[IdCanton].horizontal then sens:=SensDroit else sens:=SensBas;
        if (el1r=el1) then
          if canton[IdCanton].horizontal then sens:=SensGauche else sens:=SensHaut;
      end;
    end;

    // cas 2 : l'élément 1 (G) du canton est un aiguillage
    if (t1<>det) and (t2=det) then
    begin
      if (el1r=el2) then
        if canton[IdCanton].horizontal then sens:=SensDroit else sens:=SensBas;
      if (el1r=el2) and (el2r=el1) then
        if canton[IdCanton].horizontal then sens:=SensGauche else sens:=SensHaut;
    end;

    // cas 3 : l'élément 2 (D) du canton est un aiguillage
    if (t1=det) and (t2<>det) then
    begin
      if (el1r=el2) and (el2r=el2) then
        if canton[IdCanton].horizontal then sens:=SensDroit else sens:=SensBas;
      if (el1r=el1) then
        if canton[IdCanton].horizontal then sens:=SensGauche else sens:=SensHaut;
    end;

    if sens=0 then begin labelRoute.caption:='Le sens de circulation est incorrect';exit;end;
    affecte_Train_canton(Trains[indexTrainFR].adresse,IdCanton,sens);      // affecte le train au canton avec le sens

    // La procédure efface_affiche_route nécessite la variable "tabloroute" à jour, on utilise l'indice 1
    NumRoute:=1;
    tabloRoute[NumRoute]:=trains[indexTrainFR].route;
    Efface_Affiche_route;

    // supprimer les anciens cantons origine et destination
    idCantonOrg:=index_canton_numero(trains[indexTrainFR].cantonOrg);
    idCantonDest:=index_canton_numero(trains[indexTrainFR].cantonDest);

    if idcantonOrg<>0 then
    begin
      canton[idCantonOrg].NumcantonOrg:=0;
      canton[idCantonOrg].NumcantonDest:=0;
      canton[idCantonOrg].Bouton:=0;
      dessin_canton(IdCantonOrg,0);
    end;
    if idcantonDest<>0 then
    begin
      canton[idCantonDest].NumcantonOrg:=0;
      canton[idCantonDest].NumcantonDest:=0;
      canton[idCantonDest].Bouton:=0;
      dessin_canton(IdCantonDest,0);
    end;

    // affecter le canton origine et destination - IdCanton = canton départ de la route
    canton[IdCanton].bouton:=3;     // 3 = drapeau vert

    n:=trains[indexTrainFR].route[0].adresse ;
    detfin:=trains[indexTrainFR].route[n].adresse;
    IdCantonDest:=index_canton_det(detFin);
    if IdCantonDest<1 then begin labelRoute.caption:='Canton de destination incorrect';exit;end;

    canton[IdCanton].NumcantonOrg:=canton[Idcanton].numero;
    canton[IdCanton].NumcantonDest:=canton[IdcantonDest].numero;
    dessin_canton(IdCanton,0);

    // maj des champs org et dest du train
    trains[indexTrainFR].cantonOrg:=canton[IdCanton].NumCantonOrg;
    trains[indexTrainFR].cantonDest:=canton[IdCanton].NumCantonDest;

    canton[IdCantonDest].bouton:=4;
    canton[IdCantonDest].NumcantonOrg:=canton[Idcanton].numero;
    canton[IdCantonDest].NumcantonDest:=canton[IdcantonDest].numero;
    dessin_canton(IdCantonDest,0);
    maj_infos(indexTrainFR);

    PageControlRoutes.ActivePageIndex:=0;
  end;
end;


procedure TFormRouteTrain.ListBoxRMMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  NumRoute:=1;
  IrPref:=ListBoxRM.ItemIndex+1;
  if irPref<1 then exit;
  IndexLigneRoute:=IrPref;
  tabloRoute[NumRoute]:=trains[indexTrainFR].routePref[IrPref];
  Efface_Affiche_route;
  checkBoxSens.checked:=trains[indexTrainFR].routePref[IrPref][0].talon;
  LabelID.caption:='Id de la route : '+intToSTR(trains[indexTrainFR].routePref[IrPref][0].pos);

  // si le train de la route est en roulage, ne pas afficher la route car
  // sinon les index des trains passent à 0 dans les cantons par la fonction zone_tco
  if trains[indexTrainFR].roulage=0 then affiche_route_tco;
  EditNomRoute.Text:=trains[indexTrainFR].NomRoute[irPref];
end;

procedure TFormRouteTrain.ListBoxRAMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // si le train de la route est en roulage, ne pas afficher la route car
  // sinon les index des trains passent à 0 dans les cantons par la fonction zone_tco
  if trains[indexTrainFR].roulage=0 then affiche_route_tco;
 { Affiche(route_totale_to_string(trains[IndexTrainFR].routePref[1]),clYellow);
  Affiche(route_totale_to_string(trains[IndexTrainFR].route),clYellow);
 }
end;

procedure TFormRouteTrain.ButtonSRClick(Sender: TObject);
var i,n : integer;
    s : string;
begin
  if IrPref<1 then exit;

  s:='Voulez-vous supprimer la route mémorisée n°'+intToSTR(IrPref)+' ?';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  n:=trains[indexTrainFR].routePref[0][0].adresse;  // nombre de routes
  for i:=IrPref to n-1 do
    trains[indexTrainFR].routePref[i]:=trains[indexTrainFR].routePref[i+1];
  trains[indexTrainFR].routePref[0][0].adresse:=n-1;
  dec(irPref);
  maj_infos(indexTrainFR);
end;

procedure TFormRouteTrain.ButtonSRSClick(Sender: TObject);
begin
  labelRoute.Caption:='Routes sauvegardées';
  Sauve_config;
end;

procedure TFormRouteTrain.EditnomRouteChange(Sender: TObject);
begin
  if (IrPref<1) or (indexTrainFR<1) then exit;
  trains[indexTrainFR].NomRoute[irPref]:=EditNomRoute.text;
end;

procedure TFormRouteTrain.ListBoxRMKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if IrPref<0 then exit;
  if (ord(Key)=VK_UP) and (IrPref>1) then
  begin
    dec(IrPref);
  end
  else 
  if (ord(Key)=VK_DOWN) and (IrPref<ListBoxRM.Count) then
  begin
    inc(IrPref);
  end
  else exit;
  NumRoute:=IrPref;
  IndexLigneRoute:=IrPref;
  tabloRoute[NumRoute]:=trains[indexTrainFR].routePref[IrPref];
  checkBoxSens.checked:=trains[indexTrainFR].routePref[IrPref][0].talon;
  LabelID.caption:='Id de la route : '+intToSTR(trains[indexTrainFR].routePref[IrPref][0].pos);
  efface_affiche_route;
  EditNomRoute.Text:=trains[indexTrainFR].NomRoute[irPref];
end;

procedure TFormRouteTrain.CheckBoxSensClick(Sender: TObject);
begin
  if IndexTrainFR<0 then
  begin
    checkBoxSens.checked:=false;
    exit;
  end;
  trains[indexTrainFR].routePref[IrPref][0].talon:=checkBoxSens.checked;
end;

procedure TFormRouteTrain.CheckBoxSIRAClick(Sender: TObject);
begin
  if IndexTrainFR<0 then
  begin
    checkBoxSens.checked:=false;
    exit;
  end;
  trains[indexTrainFR].route[0].talon:=checkBoxSens.checked;
end;

end.

