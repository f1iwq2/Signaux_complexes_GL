unit selection_train;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, UnitPrinc;

type
  TFormSelTrain = class(TForm)
    ButtonOK: TButton;
    LabelInfo: TLabel;
    ComboBoxCanton: TComboBox;
    Label1: TLabel;
    ImageBas: TImage;
    ImageHaut: TImage;
    Imagegauche: TImage;
    ImageDroite: TImage;
    LabelCanton: TLabel;
    StringGridTrains: TStringGrid;
    ButtonSauve: TButton;
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGridTrainsDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridTrainsSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure StringGridTrainsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBoxCantonChange(Sender: TObject);
    procedure ButtonSauveClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSelTrain: TFormSelTrain;
  x,y,El,largC,hautC,indexTrainClic : Integer;
  routeSav : TuneRoute;

procedure actualise_seltrains;
procedure affecte_Train_canton(AdrTrain,idcanton : integer);
procedure raz_trains_Idcanton(idc : integer);
procedure raz_cantons_train(AdrTrain : integer);
procedure trouve_det_canton(idcanton : integer;var el1,el2 : integer);
function trouve_det_suiv_canton(idcanton,detecteur,sensTCO : integer) : integer;
procedure Maj_detecteurs_canton(i,AdrTrain,adresse : integer);

implementation

uses UnitConfigCellTCO,UnitTCO,unitconfig,unitDebug, UnitRouteTrains,
  UnitInfo;

{$R *.dfm}

// mise à jour des précédent, suivant du détecteur à 1 du canton avec l'adresse de train si une loco est sur le canton
// i=index canton - AdrTrain=adresse du train - adresse=adresse du détecteur
// attention le suivant et le précédent concernent le détecteur, pas le canton
procedure Maj_detecteurs_canton(i,AdrTrain,adresse : integer);
var sens,e1c,e2c,prec,suivant : integer;
    typeSuiv,t1,t2,typePrec : tequipement;
    trouve : boolean;
begin
  sens:=canton[i].sensLoco;
  trouve:=false;
  e1c:=canton[i].el1;t1:=canton[i].typ1;
  e2c:=canton[i].el2;t2:=canton[i].typ2;

  // le détecteur considéré est le e1c
  if (e1c=adresse) and (t1=det) then
  begin
    case sens of
      sensGauche,sensHaut :
      begin
        suivant:=suivant_alg3(e2c,t2,e1c,t1,1); typeSuiv:=TypeGen;
        prec:=e2c;TypePrec:=t2;
        trouve:=true;
      end;
      sensDroit,sensBas :
      begin
        Suivant:=e2c;TypeSuiv:=t2;
        Prec:=suivant_alg3(e2c,t2,e1c,t1,1); typePrec:=TypeGen;
        trouve:=true;
      end;
    end;
  end;

  // le détecteur considéré est le e2c
  if (e2c=adresse) and (t1=det) then
  begin
    case sens of
      sensGauche,sensHaut :
      begin
        Suivant:=e1c;TypeSuiv:=t1;
        Prec:=suivant_alg3(e1c,t1,e2c,t2,1); typePrec:=TypeGen;
        trouve:=true;
      end;
      sensDroit,sensBas :
      begin
        suivant:=suivant_alg3(e1c,t1,e2c,t2,1); typeSuiv:=TypeGen;
        prec:=e1c;TypePrec:=t1;
        trouve:=true;
      end;
    end;
  end;

  if trouve then
  begin
    detecteur[adresse].suivant:=suivant;
    detecteur[adresse].TypSuivant:=TypeSuiv;
    detecteur[adresse].precedent:=prec;
    detecteur[adresse].TypPrecedent:=typePrec;
    detecteur[adresse].AdrTrain:=AdrTrain;
    detecteur[adresse].Train:=canton[i].NomTrain;
  end;
end;

// supprime une entrée du tableau event_det_train contenant l'adresse du train
procedure supprime_route(adresse : integer);
var i,j : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=event_det_train[i].AdrTrain=adresse;
    inc(i);
  until (trouve) or (i>n_trains);

  if trouve then
  begin
    //Affiche('Raz route train @'+intToSTR(adresse),clyellow);
    dec(i);
    for j:=i to n_trains-1 do
    begin
      event_det_train[j]:=event_det_train[j+1];
    end;
    dec(n_trains);    // nombre de trains en circulation
  end;
end;

// trouve les détecteurs contigus au canton en fonction des aiguillages positionnés
procedure trouve_det_canton(idcanton : integer;var el1,el2 : integer);
var suiv,prec :integer;
    tel1,tel2 : tequipement;
begin
  el1:=canton[idCanton].el1;   // gauche
  tel1:=canton[idCanton].typ1;
  el2:=canton[idCanton].el2; // droit
  tel2:=canton[idCanton].typ2;
  // si le suivant n'est pas un détecteur, le trouver
  if (tel2<>det) and (tel2<>buttoir) then
  begin
    suiv:=detecteur_suivant(el1,tel1,el2,tel2,1); // arrêt sur suivant
    if suiv>9990 then suiv:=0;
    el2:=suiv;
  end;
  // si le précédent n'est pas un détecteur, le trouver
  if (tel1<>det) and (tel1<>buttoir) then
  begin
    prec:=detecteur_suivant(el2,tel2,el1,tel1,1); // arrêt sur suivant
    if suiv>9990 then suiv:=0;
    el1:=prec;
  end;
end;

// trouve le détecteur suivant sur le canton idcanton, au détecteur "détecteur" dans le sensTCO
function trouve_det_suiv_canton(idcanton,detecteur,sensTCO : integer) : integer;
var t : integer;
begin
  t:=canton[idcanton].ntco;
  zone_tco(t,detecteur,sensTCO,0,0,12,false);   // élément contigu à droite (6) du canton , résultat dans xcanton  , teste les 2 pos des aig
  if tel1=Aig then xcanton:=detecteur_suivant(detecteur,det,xcanton,aig,1);
  result:=xcanton;
end;

// supprime le train AdrTrain de tous les cantons, et réaffiche les cantons effacés concernés
procedure raz_cantons_train(AdrTrain : integer);
var i,t,idTCO,x,y,detect : integer;
    trouve : boolean;
begin
  if (AdrTrain=0) then exit;
  //Affiche('Raz_cantons_train @='+intToSTR(AdrTrain),clyellow);
  if adrTrain<>0 then
  begin
    for i:=1 to Ncantons do
    begin
      if canton[i].adresseTrain=AdrTrain then
      begin
        t:=canton[i].indexTrain;
        trains[t].canton:=0;

        canton[i].indexTrain:=0;
        canton[i].adresseTrain:=0;
        canton[i].NomTrain:='';
        idTCO:=canton[i].Ntco;
        x:=canton[i].x;
        y:=canton[i].y;
        tco[idTCO,x,y].train:=0;
        tco[idTCO,x,y].mode:=0;
        Dessin_canton(idTCO,pcanvasTCO[idTCO],x,y,0);
      end;
    end;

    // balayer les détecteurs pour trouver sur quel détecteur est le train pour le razer
    // non
    {
    i:=1;
    repeat
      detect:=adresse_detecteur[i];
      trouve:=detecteur[detect].AdrTrain=AdrTrain;
      if trouve then
      begin
        detecteur[detect].Train:='';
        detecteur[detect].IndexTrainRoulant:=0;
        detecteur[detect].AdrTrain:=0;
        detecteur[detect].Suivant:=0;
        detecteur[detect].TypSuivant:=rien;
        detecteur[detect].Precedent:=0;
        detecteur[detect].TypPrecedent:=rien;
      end;
      inc(i);
    until trouve or (i>NDetecteurs);}
  end;
end;


// affecte le train id train ou adresse à l'Index canton et au TCO.
//
// désaffecte ce train pour tous les autres canton
// si adrTrain=9999 , train inconnu
// si adrTrain=0    ; efface
// et les pointeurs de trains de l'idTrain sont razés
procedure affecte_Train_canton(AdrTrain,idcanton : integer);
var idTrain,t,el1,el2 : integer;
    t1,t2 : tequipement;
begin
  //Affiche('Affecte_train_canton: IdTrain='+intToSTR(idTrain)+' @='+intToSTR(AdrTrain)+' Idcanton='+intToSTR(idcanton),clorange);
  if (IdCanton>0) and (idCanton<=nCantons) then
  begin
    if (AdrTrain<>0) and (adrTrain<>9999) then
    begin
      idTrain:=Index_train_adresse(adrTrain);

      raz_cantons_train(AdrTrain);   // efface tous les cantons contenant le train Adrtrain

      trains[idTrain].canton:=canton[idcanton].numero;
      canton[Idcanton].indexTrain:=idTrain;
      canton[Idcanton].NomTrain:=trains[idTrain].nom_train;
      canton[IdCanton].adresseTrain:=AdrTrain;
    end;
    if AdrTrain=9999 then
    begin
      idTrain:=9999;
      canton[Idcanton].NomTrain:='';
      canton[Idcanton].indexTrain:=9999;
      canton[IdCanton].adresseTrain:=0;
    end;
    if AdrTrain=0 then
    begin
      idTrain:=0;
      canton[Idcanton].NomTrain:='';
      canton[Idcanton].indexTrain:=0;
      canton[IdCanton].adresseTrain:=0;
    end;

    t:=canton[IdCanton].Ntco;
    if (t>0) and (t<=nbreTCO) then
    begin
      TCO[t,canton[idCanton].x,canton[idCanton].y].train:=idTrain;
    end;

    // si l'un des deux détecteurs est à 1, affecter la loco au détecteur
    el1:=canton[IdCanton].el1;t1:=canton[IdCanton].typ1;
    el2:=canton[IdCanton].el2;t2:=canton[IdCanton].typ2;
    if (t1=det) and detecteur[el1].Etat then
    begin
      detecteur[el1].AdrTrain:=AdrTrain;
      detecteur[el1].Train:=trains[idTrain].nom_train;
      Maj_detecteurs_canton(idCanton,AdrTrain,el1);
    end;
    if (t2=det) and detecteur[el2].Etat then
    begin
      detecteur[el2].AdrTrain:=AdrTrain;
      detecteur[el2].Train:=trains[idTrain].nom_train;
      Maj_detecteurs_canton(idCanton,AdrTrain,el2);
    end;
  end;
end;

// renvoie x,y El et indexCanton de IdCantonSelect en variable globale
procedure quel_canton;
begin
  if IdCantonSelect=0 then exit;
  x:=canton[IdCantonSelect].x;
  y:=canton[IdCantonSelect].y;
  El:=tco[indexTCOCourant,x,y].BImage;
end;

// dessine la flèche dans la colonne 6 de la stringrid
procedure Dessine_fleche(ligne : integer;r : Trect);
var indexTrain,IdCanton : integer;
    Image : TImage;
begin
  if (ligne>0) then
  with FormSelTrain do
  begin
    indexTrain:=ligne;
    Idcanton:=index_canton_numero(trains[indexTrain].canton);
    if (idcanton<1) or (idcanton>ncantons) then exit;

    with StringGridTrains do
    begin
      case canton[idcanton].SensLoco of
      1 : Image:=ImageGauche;
      2 : Image:=ImageDroite;
      3 : Image:=ImageHaut;
      4 : Image:=ImageBas;
      else exit;
      end;
      StretchBlt(canvas.Handle,r.left,r.Top,ColWidths[6],RowHeights[6],   // destination avec mise à l'échelle
                 image.Canvas.Handle,0,0,FormSelTrain.imageHaut.Width,FormSelTrain.imageHaut.Height,srccopy);
    end;
  end;
end;

procedure maj_stringGrig;
var i,ic,t,NumCanton : integer;
    s : string;
begin
  // maj de la stringGrig
  if IdCantonSelect>0 then
  begin
    s:='Sélection d''un train';
    s:=s+' au canton '+intToSTR(canton[IdCantonSelect].numero)+' : '+canton[IdCantonSelect].nom;
    FormSelTrain.caption:=s;

    s:='Canton '+intToSTR(canton[IdCantonSelect].numero)+' encadré par '+intToSTR(canton[IdCantonSelect].el1);
    i:=canton[IdCantonSelect].SensEl1;
    case i of
      SensHaut : s:=s+' haut ';
      SensBas : s:=s+' bas ';
      SensGauche : s:=s+' gauche ';
      SensDroit : s:=s+' droit ';
    end;
    s:=s+' '+intToSTR(canton[IdCantonSelect].el2);

    i:=canton[IdCantonSelect].SensEl2;
    case i of
      SensHaut : s:=s+' haut ';
      SensBas : s:=s+' bas ';
      SensGauche : s:=s+' gauche ';
      SensDroit : s:=s+' droit ';
    end;

    s:=s+' loco vers ';
    i:=canton[IdCantonSelect].SensLoco;
    case i of
      SensHaut : s:=s+' haut ';
      SensBas : s:=s+' bas ';
      SensGauche : s:=s+' gauche ';
      SensDroit : s:=s+' droit ';
    end;
    formSelTrain.LabelCanton.caption:=s;
  end;

  for i:=1 to ntrains do
  begin
   NumCanton:=trains[i].canton; // numéro de canton
   ic:=index_canton_numero(NumCanton);
   if ic<=ncantons then
   begin
     with FormSelTrain.StringGridTrains do
     begin
       if Ic<>0 then //canton ic affecté au train i
       begin
         cells[3,i]:=IntToSTR(NumCanton);
         cells[4,i]:=canton[Ic].nom;
         t:=canton[Ic].Ntco;
         s:='N°'+intToSTR(t)+' ';
         if t<>0 then s:=s+NomfichierTCO[t];
         cells[5,i]:=s;
         if trains[i].route[0].adresse<>0 then s:=' oui' else s:='';
         cells[7,i]:=s;
       end
       else
       begin
         cells[3,i]:=''; cells[4,i]:=''; cells[5,i]:='';
         cells[6,i]:='';  // efface la flèche
       end;
     end;
    end;
  end;
  FormSelTrain.StringGridTrains.Repaint;  // pour afficher correctement la fleche
end;

procedure TFormSelTrain.ButtonOKClick(Sender: TObject);
begin
  close;
end;

procedure TFormSelTrain.FormCreate(Sender: TObject);
var i : integer;
begin

  with ImageHaut do begin Width:=60;Height:=60;visible:=false; end;
  with ImageBas do begin Width:=60;Height:=60;visible:=false; end;
  with ImageDroite do begin Width:=60;Height:=60;visible:=false; end;
  with ImageGauche do begin Width:=60;Height:=60;visible:=false; end;

  hautC:=25;
  largC:=130;
  LabelInfo.caption:='';
  with StringGridTrains do
  begin
    //Options:=StringGridTrains.Options+[goEditing];
    Hint:='Sélection d''un train';
    ShowHint:=true;
    ColCount:=8;    // nombre de colonnes
    RowCount:=Ntrains+1;
    Options := StringGridTrains.Options + [goEditing];
    ColWidths[0]:=50;
    ColWidths[1]:=200;     // icone
    ColWidths[2]:=150;     // nom du train
    ColWidths[3]:=60;      // canton
    ColWidths[4]:=100;
    ColWidths[5]:=120;
    ColWidths[6]:=30;
    ColWidths[7]:=35;

    Cells[0,0]:='N° / @';
    Cells[1,0]:='Icône';
    Cells[2,0]:='Nom du train';
    Cells[3,0]:='Affectation'+#13+'au canton';
    Cells[4,0]:='Nom du canton';
    Cells[5,0]:='TCO';
    Cells[6,0]:='Sens';
    Cells[7,0]:='Route';

    RowHeights[0]:=30;
  end;

  for i:=1 to ntrains do
  begin
    with StringGridTrains do
    begin
      cells[0,i]:=intToSTR(i)+' @'+intToSTR(Trains[i].adresse);
      cells[2,i]:=trains[i].nom_train;
    end;
  end;

  // interdit la modification des cellules au clavier
  StringGridTrains.Options:=StringGridTrains.Options - [goEditing] - [goRangeSelect];
end;


procedure TFormSelTrain.StringGridTrainsDrawCell(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
var indextrain,l,h,hautdest,largdest : integer;
    rd : double;
    r : trect;
    coul: Tcolor;
    s : string;
begin
 // Affiche('DrawCell '+intToSTR(Acol)+'x'+intToSTR(Arow),clred);

  // titres sur 2 lignes
  if Arow=0 then
  with StringGridTrains do
  begin
    if Pos(#13,Cells[ACol,ARow])>0 then
    begin
      Coul:=canvas.Pixels[5,5];  // trouver la couleur de la première ligne de la stringgrid, car elle change en fonction des styles
      Canvas.Brush.Color:=coul;
      Canvas.FillRect(Rect);     // Efface la cellule qu'on va réécrire en mode WORDBREAK

      Inc(Rect.Left, 2);
      Inc(Rect.Top, 2);
      DrawText(Canvas.Handle,PChar(Cells[ACol, ARow]),-1,Rect,DT_NOPREFIX or DT_WORDBREAK);
    end;
  end;

  // affiche l'icone du train
  if (Acol=1) and (Arow>0) then
  with StringGridTrains do
  begin
    // dessine le train dans la colonne 1
    indextrain:=Arow;
    if trains[indexTrain].icone<>nil then
    begin
      // source
      //Affiche(intToSTR(Acol)+' '+intToSTR(Arow),clred);
      l:=Trains[indextrain].Icone.width;
      h:=Trains[indextrain].Icone.Height;
      if h=0 then exit;
      rd:=l/h;
      //Affiche(FloatToSTR(rd),clred);
      // destination : la hauteur est fixée
      HautDest:=rect.bottom-rect.top; //round(ImageTrain.Height);
      LargDest:=round(Hautdest*rd);

      // si la largeur > que l'image, on fixe la largeur
      if LargDest>rect.right-rect.left then  //ImageTrain.Width then
      begin
        LargDest:=rect.right-rect.left; // ImageTrain.Width;
        HautDest:=round(LargDest/rd);
      end;

      TransparentBlt(canvas.Handle,rect.Left+2,rect.Top,largDest,hautDest,
                     Trains[indexTrain].Icone.canvas.Handle,0,0,l,h,clWhite);
    end;
  end;

  // dessine les fleches
  if (Acol=6) and (Arow>0) then
    dessine_fleche(Arow,rect);

  // le carré de route
  if (acol=7) and (aRow>0) then
  begin
    if trains[Arow].route[0].adresse<>0 then
    begin
      with StringGridTrains.Canvas do
      begin
        pen.color:=clBlue;
        pen.Width:=3;
        rectangle(rect);
        s:='route';
        r.Left:=rect.Left+2;
        r.Top:=rect.Top+4;
        r.Right:=rect.Right-2;
        r.Bottom:=rect.Bottom-2;
        DrawText(Handle,PChar(s), -1,r ,DT_VCENTER or DT_CENTER or dt_wordbreak);
      end;
    end;
  end;
end;

// raz des trains affectés au canton d'index "idc"
procedure raz_trains_idcanton(idc : integer);
var ax,ay,i,ic : integer;
begin
  if traceliste then Affiche('Raz train affectés au canton index='+intToSTR(idc),clyellow);
  for i:=1 to Ntrains do
  begin
    ic:=index_canton_numero(trains[i].canton);
    if ic=idc then
    begin
      routeSav:=trains[i].route;         // sauvegarde la route
      trains[i].canton:=0;
      trains[i].route[0].adresse:=0;
      if ic<>0 then
      begin
        ax:=canton[Ic].x;
        ay:=canton[Ic].y;
        tco[IndexTCOCourant,ax,ay].train:=0;
        canton[Ic].indexTrain:=0;
        canton[Ic].adresseTrain:=0;
        canton[Ic].NomTrain:='';
      end;
    end;
  end;
end;


// cliqué sur cellule pour changer la sélection du train ou voir la route ou la flèche
procedure TFormSelTrain.StringGridTrainsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var f,AutreTrain,AutreCanton,idAutrecanton,i,ancienSens,AdrTrain,IdTrain,sensloco : integer;
    faire : boolean;
    s : string;
begin
  if IdCantonSelect=0 then IdCantonSelect:=AncienIdCantonSelect;
  if affevt then Affiche('FormSelTrain.StringGridTrainsSelectCell '+intToSTR(ACol)+' '+intToSTR(ARow),clYellow);
  if (Arow>nTrains) or (IdCantonSelect<1) then exit;

  faire:=false;
  //------------change la sélection du train
  if (Arow>=1) and (ACol<=5) then
  begin
    AncienSens:=0;
    indexTrainClic:=Arow;
    //  Affiche('ligne='+intToSTR(Arow)+' col='+intToSTR(Acol),clyellow);

    quel_canton;   // x,y El et indexCanton du canton activé

    faire:=true;
    LabelInfo.caption:='';
    // vérifier si le train est affecté à un autre canton
    AutreCanton:=trains[indexTrainClic].canton;
    idAutrecanton:=index_canton_numero(autreCanton);
    if (IdAutrecanton<>0) and (IdAutreCanton<>IdCantonSelect) then
    begin
      LabelInfo.caption:='Le train '+intToSTR(IndexTrainClic)+' '+trains[IndexTrainClic].nom_train+' est affecté au canton '+intToSTR(AutreCanton);
      exit;
    end;

   if Trains[IndexTrainClic].route[0].adresse<>0 then
    begin
      s:='Le train '+Trains[IndexTrainClic].nom_train+' a une route affectée.'+#13+
         'Supprimer le train du canton va également supprimer sa route.'+#13+
         'Voulez vous supprimer le train du canton ?';

      if Application.MessageBox(pchar(s),pchar('Confirmation de suppression de train du canton '+intToSTR(canton[IdCantonSelect].numero)),
         MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

      supprime_route_train(indextrainclic);
      StringGridTrains.cells[7,ARow]:='';
    end;

    if faire then
    begin
      // vérifier si un autre train est affecté au canton
      AutreTrain:=canton[IdCantonSelect].indexTrain;
      if autreTrain<>0 then
      begin
        LabelInfo.caption:='Le train '+intToSTR(AutreTrain)+' '+trains[AutreTrain].nom_train+' est déjà affecté au canton - Effacement';
        // affecter la route de l'ancien train au nouveau train
        routeSav:=trains[AutreTrain].route;  // sauve la route
        trains[AutreTrain].route[0].adresse:=0;
        StringGridTrains.Cells[7,AutreTrain]:='';
        trains[IndexTrainClic].route:=routeSav;

        AncienSens:=canton[idcantonSelect].SensLoco;
        faire:=true;
        if trains[indexTrainClic].canton=canton[IdCantonSelect].numero then faire:=false ; // ne pas faire l'affectaction, c'est une désaffectaction


        raz_trains_idcanton(IdCantonSelect);  // au retour, route contient la route du train razé du canton
        //Affiche('Et 1',clYellow);
        maj_signaux(true);
      end;


      // affecter le train, le canton et le TCO
      if faire then
      begin
        if anciensens=0 then if canton[IdCantonSelect].horizontal then SensLoco:=SensDroit else SensLoco:=SensBas;
        if ancienSens<>0 then SensLoco:=ancienSens;

        if (canton[IdCantonSelect].sensCirc<>0) then sensLoco:=canton[IdCantonSelect].sensCirc ;

        canton[IdCantonSelect].SensLoco:=sensLoco;
        affecte_Train_canton(trains[indexTrainClic].adresse,IdCantonSelect);  // le train affecté contient la route du train razé

        maj_signaux(true);
      end;
    end;
  end;

  // change le sens - (cliqué sur la flèche)---------------------------
  if Acol=6 then
  begin
    // si on a cliqué sur un train affecté, on procède
    IdAutreCanton:=index_canton_numero(trains[Arow].canton);
    if IdAutreCanton>0 then
    begin
      AdrTrain:=canton[IdAutreCanton].adresseTrain;
      IdTrain:=index_train_adresse(AdrTrain);
      // si le train a une route affectée
      if Trains[IdTrain].route[0].adresse<>0 then
      begin
        s:='Le train '+Trains[idTrain].nom_train+' a une route affectée.'+#13+
           'Changer son sens de départ va détruire sa route.'+#13+
           'Voulez vous changer le sens du train?';
        if Application.MessageBox(pchar(s),pchar('Confirmation pour changer le sens du train'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;
        supprime_route_train(idTrain);
      end;

      f:=canton[IdAutreCanton].SensLoco;

      inc(f);
      if canton[IdAutreCanton].horizontal then
      begin
        if (f<1) or (f>SensDroit) then f:=SensGauche;
      end
      else
      begin
        if (f=5) or (f<SensHaut) then f:=SensHaut;
      end;
      if (canton[IdAutreCanton].sensCirc<>0) and (canton[IdAutreCanton].SensCirc<>f) then
      begin
        s:='Le sens de circulation du canton '+intToSTR(canton[IdAutreCanton].numero)+' ne permet pas de positionner le train dans ce sens';
        LabelInfo.Caption:=s;
        FormInfo.LabelInfo.caption:=s;
        FormInfo.Top:=top+10;
        FormInfo.Left:=left+10;
        FormInfo.Show;
        exit;
      end;

      renseigne_canton(IdAutreCanton);
      canton[IdAutreCanton].SensLoco:=f;
      affecte_Train_canton(AdrTrain,idAutreCanton);
      //Affiche('Et 3',clYellow);
      maj_signaux(true);
    end;
  end;

  // cliqué sur la route
  if Acol=7 then
  begin
    indexTrainFR:=Arow;
    formRouteTrain.show;
  end;

  maj_stringGrig;

  // met à jour les cantons
  for i:=1 to nCantons do
  begin
    dessin_canton(i,0);
  end;

end;

// actualise la fenetre
procedure actualise_seltrains;
var s : string;
    i : integer;
begin
  with formSelTrain.StringGridTrains do
  begin
    RowCount:=Ntrains+1;
    for i:=1 to ntrains do
    begin
      cells[2,i]:=trains[i].nom_train;
    end;
  end;

  Quel_canton;
  FormSelTrain.caption:=s;

  with formSelTrain.ComboBoxCanton do
  begin
    clear;
    for i:=1 to nCantons do items.add('Canton n°'+IntToSTR(canton[i].numero)+'    '+canton[i].nom);
    ItemIndex:=IdCantonSelect-1;
  end;

  if IdCantonSelect=0 then formSelTrain.labelInfo.caption:='Sélectionnez un canton';

  maj_stringGrig;    // change indexcanton

end;


// positionne la VertscrollBar de la stringGrid
procedure Positionne_SG(n : integer);
var i : integer;
  {
  SB_LINEUP ;
  SB_LINELEFT ;
  SB_LINEDOWN ;
  SB_LINERIGHT ;
  SB_PAGEUP ;
  SB_PAGELEFT ;
  SB_PAGEDOWN ;
  SB_PAGERIGHT ;
  SB_THUMBPOSITION ;
  SB_THUMBTRACK ;
  SB_TOP ;
  SB_LEFT ;
  SB_BOTTOM ;
  SB_RIGHT ;
  SB_ENDSCROLL ;
  }
begin
  // Positionne la stringGrid
  SendMessage(formSelTrain.StringGridTrains.Handle, WM_VScroll, SB_TOP, 0);  // déplace en haut
  for i:=1 to n-5 do  // 7-2 c'est le nombre de lignes affichées par la stringgrid
    SendMessage(formSelTrain.StringGridTrains.Handle, WM_VScroll, SB_LINEDOWN, 0);  // déplace d'une ligne à la fois
end;

procedure TFormSelTrain.FormActivate(Sender: TObject);
var n,i,IndexTrain : integer;
    trouve : boolean;
    NomTrain : string;
begin
  actualise_Seltrains;
  if IdcantonSelect=0 then exit;
  IndexTrain:=canton[IdCantonSelect].indexTrain;
  NomTrain:=trains[indexTrain].nom_train;
  // trouver si le train est dans la grille
  with StringGridTrains do
  begin
    i:=1;n:=RowCount;
    repeat
      trouve:=cells[2,i]=nomTrain;
      inc(i);
    until trouve or (i>=n);
    if trouve then
    begin
      Positionne_SG(i);
    end;
  end;
end;

procedure TFormSelTrain.StringGridTrainsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  key:=0; // empêche le mouvement de sélection par les touches
end;

procedure TFormSelTrain.ComboBoxCantonChange(Sender: TObject);
begin
  IdCantonSelect:=ComboBoxCanton.itemIndex+1;
  maj_stringGrig;
  Affiche_TCO(indexTCOCourant);
end;


procedure TFormSelTrain.ButtonSauveClick(Sender: TObject);
begin
  Sauve_config;
end;

end.

