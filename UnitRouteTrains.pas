unit UnitRouteTrains;

// choix de la route pour tous les trains

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFormRouteTrain = class(TForm)
    ComboBoxTrains: TComboBox;
    ImageTrainR: TImage;
    ButtonQuitte: TButton;
    RichEditRoute: TRichEdit;
    LabelRoute: TLabel;
    ButtonEfface: TButton;
    ButtonSupprime: TButton;
    ButtonRouler1Tr: TButton;
    ButtonRoulerTsTrains: TButton;
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
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormRouteTrain: TFormRouteTrain;

function aig_canton(idTrain,detect : integer) : integer;
function demarre_index_train(indexTrain  : integer) : boolean;

implementation

uses unitprinc,UnitConfig,unitTCO,UnitHorloge,unitFicheHoraire,UnitDebug,UnitRoute;

{$R *.dfm}

// démarre un train si le signal n'est pas au rouge
// appelé par gestion des horaires dans le timer  ou  bouton rouler 1 train ou rouler tous les trains
function demarre_index_train(indexTrain  : integer) : boolean;
var i,n,det1,el2,vitesse,AdrTrain,idcanton,voie1,voie2,indexSig1,indexSig2,AdrSig1,AdrSig2,AdrSig,
    detect,indexSig : integer;
    tel2 : tequipement;
    trouve : boolean;
    Train,s : string;

begin
  formprinc.SBMarcheArretLoco.Visible:=true;
  //Affiche('demarre_index_Train',clWhite);
  // si il y a un signal sur le détecteur de démarrage du train est il au rouge?
  i:=1;
  AdrTrain:=Trains[indexTrain].adresse;
  Train:=Trains[indexTrain].nom_train;

  detect:=trains[indexTrain].dernierdet;
  index_signal_det(detect,voie1,indexSig1,voie2,indexSig2);
  AdrSig1:=0;AdrSig2:=0;
  if indexSig1<>0 then AdrSig1:=signaux[indexSig1].adresse;
  if indexSig2<>0 then AdrSig2:=signaux[indexSig2].adresse;

  // si le détecteur sur le train au départ dispose d'un signal
  if (AdrSig1<>0) or (AdrSig2<>0) then
  begin
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

    AdrSig:=signaux[indexSig].adresse;
    if traceliste then Affiche('Le signal dans le bon sens est '+intToSTR(AdrSig)+' '+chaine_signal(AdrSig),clOrange);
    if signal_rouge(AdrSig) then
    begin
      s:='Le train '+train+' est arreté au signal '+intToSTR(signaux[IndexSig].adresse);
      affiche(s,clyellow);
      trains[indexTrain].roulage:=1;
      exit;
    end;
  end;

  vitesse:=trains[indexTrain].VitNominale;
  if roulage then
  begin
    if trains[indexTrain].inverse then vitesse:=-vitesse;
    Idcanton:=trains[indexTrain].canton;

    //init_route_canton(idcanton,Indextrain,true);

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
    trains[indexTrain].roulage:=2;
    vitesse_loco(train,indextrain,adrTrain,vitesse,true);
    exit;
  end;

  Maj_Signaux(true);  // avec détecteurs

  if not(roulage) then exit;

  s:='Lancement du train '+train;
  if detect<>0 then s:=s+' depuis détecteur '+intToSTR(Detect);
  Affiche(s,clYellow);
  AfficheDebug(s,clyellow);
  trains[indexTrain].roulage:=2;
  if traceListe then AfficheDebug(s,clyellow);

  i:=trains[indexTrain].TempsDemarreSig;
  if i=0 then i:=1;
  trains[indextrain].TempoDemarre:=i;
end;


procedure maj_infos(idtrain : integer);
var i : integer;
    s : string;
begin
  formRouteTrain.comboBoxTrains.Clear;

  for i:=1 to NTrains do
  begin
    s:=trains[i].nom_train;
    if trains[i].route[0].adresse<>0 then s:=s+' [route affectée]';
    formRouteTrain.comboBoxTrains.items.add(s);
  end;

  formRouteTrain.comboBoxTrains.ItemIndex:=indexTrainFR-1;

  Maj_icone_train(FormRouteTrain.ImageTrainR,idTrain);
  with formRouteTrain do
  begin
    RicheditRoute.Clear;
    RichEditRoute.Lines.Add(route_to_string(trains[idTrain].route));
    if trains[idtrain].route[0].adresse<>0 then
    begin
      labelroute.caption:='Route affectée au train '+trains[idtrain].nom_train;
      ButtonRouler1tr.caption:='Rouler le train '+trains[idtrain].nom_train;
      ButtonRouler1tr.enabled:=true;
    end
    else
    begin
      labelroute.caption:='Pas de route affectée au train '+trains[idtrain].nom_train;
      ButtonRouler1tr.caption:=' ';
      ButtonRouler1tr.enabled:=false;
    end;
  end;
end;

procedure TFormRouteTrain.FormActivate(Sender: TObject);
begin
  maj_infos(indexTrainFR);

  if ntrains>0 then Maj_icone_train(FormRouteTrain.ImageTrainR,indexTrainFR);
end;

procedure TFormRouteTrain.ButtonQuitteClick(Sender: TObject);
begin
  close;
end;

procedure TFormRouteTrain.ComboBoxTrainsChange(Sender: TObject);
begin
  indexTrainFR:=ComboBoxTrains.ItemIndex+1;
  efface_route_tco;
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
  efface_route_tco;
end;

procedure TFormRouteTrain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  efface_route_tco;
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

  efface_route_tco;

  supprime_route_train(indexTrainFR);
  maj_infos(indexTrainFR);
end;

// Réserve les éléments s'ils ne sont pas déja réservés et positionne les aiguillages
// jusqu'au signal suivant (soit 1 canton)
// en entrée : index du train ; detect=détecteur à partir duquel faire la réservation et le positionnement des aiguillages
// en sortie : si erreur : -1   ou adresse du train qui a réservé le canton
// phase 0 : si le détecteur detect est en fin de route, alors on active l'arret du train
// phase 1 : tester si éléments réservés par train tiers jusqu'au signal suivant. Si oui, sortir.
// phase 2 : positionner les aiguillages
// phase 3 : réserver les aiguillages
function aig_canton(idTrain,detect : integer) : integer;
var AdrSig,n,i,ideb,iFin,AdrTrain,etat,pointeur,voie1,voie2,indexSig1,indexSig2,
    Trainexistant,adr,pos,index,Ncanton,icanton : integer;
    typ: tequipement;
    trainTiers,SigBonSens : boolean;
    s : string;
begin
  //traceliste:=true;
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

  if traceListe then
  begin
    Affiche('AC train @'+intToSTR(AdrTrain)+'Detecteur='+intToSTR(detect)+' Pointeur'+intToSTR(pointeur)+' ->'+intToSTR(trains[idTrain].route[i].adresse),clOrange);
    if i>=n then
    begin
      affiche('La route a été complètement traitée (réservation)',clOrange);
      result:=0;
    end;
  end;

  if (detect=trains[idTrain].route[n].adresse) and (trains[idTrain].route[n].typ=det) then
  begin
    // route traitée , arrêter le train
    trains[idTrain].TempoArretCour:=0;
    trains[idTrain].TempoArret:=50;
  end;

  traintiers:=false;
  icanton:=0;
  ncanton:=0;
  TrainExistant:=0;
  ideb:=i;
  AdrSig:=0;
  SigBonSens:=false;
  if traceliste then Affiche('Aiguillages',clOrange);
  with trains[idtrain] do
  begin
    // boucle de vérification de réservation des aiguillages par un train tiers, jusqu'à rencontrer n cantons
    repeat
      typ:=route[i].typ;
      adr:=route[i].adresse;
      typ:=route[i].typ;
      if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
      begin
        if TraceListe then Affiche(intToSTR(adr)+' ',clOrange);
        // vérifier si l'aiguillage est libre
        TrainExistant:=Aiguillage[index_aig(adr)].AdrTrain;
        if (trainexistant<>AdrTrain) and (TrainExistant<>0) then
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

    If traceliste then affiche('Phase 2-3',clWhite);
    // phases 2 et 3
    trains[idtrain].roulage:=2; // roulage effectif
    result:=AdrTrain;
    if not(traintiers) then iFin:=i-1 else iFin:=icanton;
    AdrTrain:=trains[idTrain].adresse;

    // balayage du (des) cantons libres
    if traceListe then Affiche('Balayage de '+intToSTR(ideb)+' à '+intToSTR(ifin)+' pour positionner et réserver aiguillages',clYellow);
    for i:=iDeb to iFin do
    begin
      route[i].traite:=true;
      typ:=route[i].typ;
      adr:=route[i].adresse;
      if (typ=aig) or (typ=triple) or (typ=tjs) or (typ=tjd) or (typ=crois) then
      begin
        pos:=route[i].pos;
        index:=index_aig(adr);

        if (typ=aig) or (typ=triple) or (typ=tjs) or (typ=tjd) then
        begin
          pilote_acc(adr,pos,AdrTrain); // pilote l'aig si il est reservé par le train ou non réservé

          s:='AC- Pilote aiguillage '+intToSTR(adr)+'='+intToSTR(pos);
          case pos of
            const_devie : s:=s+' (dévié)';
            const_droit : s:=s+' (droit)';
            else
            s:=s+' non positionné';
          end;
          //if traceListe then
          Affiche(s,clWhite);
          if portCommOuvert or parSocketLenz or CDM_connecte then sleep(Tempo_Aig);
        end;
        // réservation
        aiguillage[index].adrTrain:=AdrTrain;
      end;
      if typ=det then detecteur[adr].AdrTrainRes:=adrTrain;
      Texte_aig_fond(adr);
    end;
  end;
  maj_signaux(false);
end;

// bouton rouler 1 train
procedure TFormRouteTrain.ButtonRouler1TrClick(Sender: TObject);
var demarre : boolean;
begin
  if (indexTrainFR<1) then exit;
  roulage:=true;
  efface_route_tco;
  maj_signaux(true);

  // positionner les aiguillages de la route
  // si le train est doté d'une route
  if trains[indexTrainFR].route[0].adresse>0 then
  begin
    aig_canton(indexTrainFR,trains[indexTrainFR].route[1].adresse);  // positionne aiguillage et fait les réservations
    demarre:=demarre_index_train(indexTrainFR);    // met la mémoire de roulage du train à 1
  end;
  close;
end;

// bouton rouler tous les trains
procedure TFormRouteTrain.ButtonRoulerTsTrainsClick(Sender: TObject);
var idtrain : integer;
    demarre : boolean;
begin
  if (indexTrainFR<1) then exit;
  roulage:=true;
  efface_route_tco;
  maj_signaux(true);
  maj_signaux(true);

  // positionner les aiguillages de la 1ère route
  idtrain:=1;
  repeat
    //si le train est doté d'une route
    if trains[idTrain].route[0].adresse>0 then
    begin
      aig_canton(idTrain,trains[idTrain].route[1].adresse);
    end;
    inc(idtrain);
  until (idtrain>ntrains);

  for idtrain:=1 to ntrains do
  begin
    //si le train est doté d'une route
    if trains[idTrain].route[0].adresse>0 then demarre:=demarre_index_train(idtrain); // met la mémoire de roulage du train à 1
  end;
  close;
end;

end.

