unit UnitRouteTrains;

// choix de la route pour tous les trains
// lance le roulage des trains

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
    ButtonSauveRoute: TButton;
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
  if not trouve then detect:=0;

  if trouve then
  begin
    trains[indexTrain].dernierdet:=detect;
    if debugRoulage then
    begin
      Affiche('Le détecteur du train '+train+' est le '+intToSTR(detect),clWhite);
    end;

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
      if adrSig<>0 then
      begin
        if traceliste then Affiche('Le signal dans le bon sens est '+intToSTR(AdrSig)+' '+chaine_signal(AdrSig),clOrange);
        if signal_rouge(AdrSig) then
        begin
          s:='Le train '+train+' est arreté au signal '+intToSTR(signaux[IndexSig].adresse);
          affiche(s,clyellow);
          trains[indexTrain].roulage:=1;
          exit;  // on sort car on ne démarre pas un train arrêté au rouge
        end;
      end;
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
    if trouve then
    begin
      dec(i);
      vitesse:=GrilleHoraire[i].vitesse;
      trains[indexTrain].roulage:=2;
      vitesse_loco(train,indextrain,adrTrain,vitesse,true);
    end;
  end;

  Maj_Signaux(true);  // avec détecteurs

  if not(roulage) then exit;



  s:='Lancement du train '+train;
  if detect<>0 then s:=s+' depuis détecteur '+intToSTR(Detect);
  Affiche(s,clYellow);
  if nivdebug>=1 then AfficheDebug(s,clyellow);
  trains[indexTrain].roulage:=2;
  if traceListe then AfficheDebug(s,clyellow);

  i:=trains[indexTrain].TempsDemarreSig;
  if i=0 then i:=1;
  trains[indextrain].TempoDemarre:=i;   // démarrage à la vitesse nominale
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
    RichEditRoute.Lines.Add(route_restreinte_to_string(trains[idTrain].route));
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
  close;
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
    adr2 : integer;
    typ,tprec: tequipement;
    trainTiers,SigBonSens,trouve : boolean;
    s : string;
begin
  //traceliste:=true;
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
    Affiche('AC train @'+intToSTR(AdrTrain)+'Detecteur='+intToSTR(detect)+' Pointeur'+intToSTR(pointeur)+' ->'+intToSTR(trains[idTrain].route[i].adresse),clOrange);
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
    trains[idTrain].arret_det:=true;
    Trains[idTrain].phase_arret:=0;
  end;

  traintiers:=false;
  icanton:=0;
  ncanton:=0;
  TrainExistant:=0;
  ideb:=trains[idTrain].PointRout;
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
            Affiche('Réservation Aig '+intToSTR(adr),clCyan);
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
  //TraceListe:=false;
end;

// Réserve les éléments s'ils ne sont pas déja réservés et positionne les aiguillages
// jusqu'au signal suivant (soit 1 canton)
// en entrée : index du train ; detect=détecteur à partir duquel faire la réservation et le positionnement des aiguillages
// en sortie : si erreur : -1   ou adresse du train qui a réservé le canton
// phase 0 : si le détecteur detect est en fin de route, alors on active l'arret du train
// phase 1 : tester si éléments réservés par train tiers jusqu'aux cantons suivants. Si oui, sortir.
// phase 2 : positionner les aiguillages
// phase 3 : réserver les aiguillages
function aig_cantonX(idTrain,detect : integer) : integer;
var AdrSig,n,i,ic,j,ideb,iFin,AdrTrain,etat,pointeur,voie1,voie2,indexSig1,indexSig2,AncPr,
    Trainexistant,adr,pos,index,Ncanton,icanton,NumCanton,det_arret,it,PointRoute,ElPrec,
    adr2 : integer;
    typ,tprec: tequipement;
    trainTiers,SigBonSens,trouve : boolean;
    s : string;
begin
  //traceliste:=true;
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
    Affiche('AC train @'+intToSTR(AdrTrain)+'Detecteur='+intToSTR(detect)+' Pointeur'+intToSTR(pointeur)+' ->'+intToSTR(trains[idTrain].route[i].adresse),clOrange);
    if i>=n then
    begin
      affiche('La route a été complètement traitée (réservation)',clOrange);
      result:=0;
    end;
  end;

  // mettre le pointeur de route j sur le détecteur "detect", après le pointeur 'AncPr'
  j:=1;
  AncPr:=trains[idTrain].PointRout;
  repeat
    trouve:=(trains[idTrain].route[j].adresse=detect) and (trains[idTrain].route[j].typ=det) and (j>=AncPr);
    if trouve then
    begin
      trains[idTrain].PointRout:=j;   //<<<<<<<<< le pointeur est stocké
      PointRoute:=j;
      if DebugRoulage then Affiche('Le pointeur de route est '+intToSTR(j)+'/'+intToSTR(n)+' au détecteur '+intToSTR(detect),clWhite);
    end;
    inc(j);
  until trouve or (j>n);

  // arrêt temporisé sur détecteur demandé
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
      trains[idTrain].TempoArretTemp:=trains[idTrain].DetecteurArret[it].temps*10;  // récupérer le temps d'arrêt sur le détecteur
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
    trains[idTrain].arret_det:=true;
    Trains[idTrain].phase_arret:=0;
  end;

  traintiers:=false;
  icanton:=0;
  ncanton:=0;
  TrainExistant:=0;
  ideb:=trains[idTrain].PointRout; // i;  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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

    If traceliste then affiche('Phase 2-3',clWhite);
    // phases 2 et 3
    trains[idtrain].roulage:=2; // roulage effectif
    result:=AdrTrain;
    if not(traintiers) then iFin:=i-1 else iFin:=icanton;  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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

        if ((typ=aig) or (typ=triple) or (typ=tjs) or (typ=tjd)) then
        begin
          if aiguillage[index].AdrTrain=0 then
          begin
            pilote_acc(adr,pos,AdrTrain); // pilote l'aig si il est reservé par le train ou non réservé
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
            Affiche('Réservation Aig '+intToSTR(adr),clCyan);
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
  //TraceListe:=false;
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
    demarre:=demarre_index_train(indexTrainFR);    // met la mémoire de roulage du train à 1
    aig_canton(indexTrainFR,trains[indexTrainFR].route[1].adresse);  // positionne aiguillage et fait les réservations
    if debugRoulage then Affiche_routes_brut;
  end;
  close;    // efface la route du TCO
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
  for idtrain:=1 to ntrains do
  begin
    //si le train est doté d'une route
    if trains[idTrain].route[0].adresse>0 then
    begin
      if debugRoulage then Affiche_routes_brut;
      demarre:=demarre_index_train(idtrain); // met la mémoire de roulage du train à 1
      aig_canton(idTrain,trains[idTrain].route[1].adresse);
    end;
  end;
  close;
end;

procedure TFormRouteTrain.ButtonSauveRouteClick(Sender: TObject);
var n : integer;
begin
  if (indexTrainFR<1) then exit;
  n:=trains[indexTrainFr].route[0].adresse;
  if n=0 then exit;

  Trains[indexTrainFr].routePref:=Trains[IndexTrainFr].route;
  Sauve_config;
end;



end.

