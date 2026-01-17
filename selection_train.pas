unit selection_train;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, UnitPrinc, ComCtrls;

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
    ButtonSauve: TButton;
    StringGridTrains: TStringGrid;
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
  largC,hautC,LargeurSGT,indexTrainClic,HauteurLigneSGT : Integer;
  routeSav : TuneRoute;

procedure actualise_seltrains;
procedure affecte_Train_canton(AdrTrain,idcanton,sens : integer);
procedure raz_cantons_train(AdrTrain : integer;raz : boolean);
procedure trouve_det_canton(idcanton : integer;var el1,el2 : integer);
function trouve_det_suiv_canton(idcanton,detecteur,sensTCO : integer) : integer;
procedure Maj_detecteurs_canton(i,AdrTrain,adresse : integer);

implementation

uses UnitConfigCellTCO,UnitTCO,unitconfig,unitDebug, UnitRouteTrains,UnitInfo;

{$R *.dfm}

// mise à jour des précédent, suivant du détecteur à 1 du canton avec l'adresse de train si une loco est sur le canton
// i=index canton - AdrTrain=adresse du train - adresse=adresse du détecteur
// attention le suivant et le précédent concernent le détecteur, pas le canton
procedure Maj_detecteurs_canton(i,AdrTrain,adresse : integer);
var j,sens,e1c,e2c,prec,suivant : integer;
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
  if (e2c=adresse) and (t2=det) then
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
    j:=index_train_adresse(AdrTrain);
    trains[j].ElSuivant:=suivant;
    trains[j].tElSuivant:=typesuiv;
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
// si raz=true : raz aussi le train du détecteur
procedure raz_cantons_train(AdrTrain : integer;raz : boolean);
var i,t,idTCO,x,y,detect : integer;
    trouve : boolean;
begin
  if (AdrTrain=0) then exit;
  if procPrinc then AfficheDebug('Raz_cantons_train @='+intToSTR(AdrTrain),clyellow);
  //Affiche('Raz_cantons_train @='+intToSTR(AdrTrain),clyellow);
  if adrTrain<>0 then
  begin
    for i:=1 to Ncantons do
    begin
      if canton[i].adresseTrain=AdrTrain then
      begin
        t:=canton[i].indexTrain;
        trains[t].canton:=0;
        routeSav:=trains[t].route;         // sauvegarde la route
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

    // supprimer le canton du train
    i:=index_train_adresse(AdrTrain);
    if i<>0 then
    begin
      trains[i].canton:=0;
    end;

    // Maj_icone_train(Image_Train[i],i,clWhite);   // maj arrière plan train page principale

    // balayer les détecteurs pour trouver sur quel détecteur est le train pour le razer
    // non
    if raz then
    begin
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
      until trouve or (i>NDetecteurs);
    end;
  end;
end;


// affecte le train Adrtrain à l'Index canton dans le sens, et affecte la loco au détecteur à 1 du canton
// désaffecte ce train pour tous les autres cantons
// si adrTrain=9999 , train inconnu
// si adrTrain=0    ; efface le train du canton
// et les pointeurs de trains de l'idTrain sont razés
procedure affecte_Train_canton(AdrTrain,idcanton,sens : integer);
var idTrain,t,el1,el2 : integer;
    t1,t2 : tequipement;
begin
  if ProcPrinc then
   AfficheDebug('Affecte_train_canton: @='+intToSTR(AdrTrain)+' Idcanton='+intToSTR(idcanton),clorange);
//  Affiche('Affecte_train_canton: @='+intToSTR(AdrTrain)+' Idcanton='+intToSTR(idcanton),clyellow);
  if (IdCanton>0) and (idCanton<=nCantons) then
  begin
    idTrain:=0;
    if (AdrTrain<>0) and (adrTrain<>9999) then
    begin
      idTrain:=Index_train_adresse(adrTrain);

      raz_cantons_train(AdrTrain,false);  // efface tous les cantons contenant le train Adrtrain sans raz du détecteur
      //Maj_icone_train(Image_Train[idTrain],idTrain,$e0e0e0);   // maj arrière plan train page principale
      trains[idTrain].canton:=canton[idcanton].numero;
      trains[idTrain].sens:=sens;
      canton[IdCanton].SensLoco:=sens;
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

    // affecte le canton avec l'id du train, même si nul
    t:=canton[IdCanton].Ntco;
    if (t>0) and (t<=nbreTCO) then
    begin
      TCO[t,canton[idCanton].x,canton[idCanton].y].train:=idTrain;
    end;

    if AdrTrain=0 then  // effacement train du canton
    begin
      idTrain:=canton[Idcanton].indexTrain;
      trains[idTrain].canton:=0;
      canton[Idcanton].NomTrain:='';
      canton[Idcanton].indexTrain:=0;
      canton[IdCanton].adresseTrain:=0;
      idTrain:=0;
    end;

    // si l'un des deux éléments adjacents au canton est un détecteur à 1, affecter la loco au détecteur
    el1:=canton[IdCanton].el1;t1:=canton[IdCanton].typ1;
    el2:=canton[IdCanton].el2;t2:=canton[IdCanton].typ2;
    if (t1=det) and detecteur[el1].Etat then
    begin
      detecteur[el1].AdrTrain:=AdrTrain;
      if idTrain<>0 then detecteur[el1].Train:=trains[idTrain].nom_train;
      Maj_detecteurs_canton(idCanton,AdrTrain,el1);
    end;
    if (t2=det) and detecteur[el2].Etat then
    begin
      detecteur[el2].AdrTrain:=AdrTrain;
      if idTrain<>0 then detecteur[el2].Train:=trains[idTrain].nom_train;
      Maj_detecteurs_canton(idCanton,AdrTrain,el2);
    end;
  end;

  maj_signaux(false);
  dessin_canton(idCanton,0);   // redessine le canton

  //affiche('Det du canton '+intToSTR(canton[Idcanton].numero)+' det1='+intToSTR(canton[Idcanton].det1)+' det2='+intToSTR(canton[Idcanton].det2),clyellow);
end;

// renvoie x,y El et indexCanton de IdCantonSelect
procedure quel_canton(var x,y,el : integer);
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
      SensGauche : Image:=ImageGauche;   
      SensDroit : Image:=ImageDroite;
      SensHaut : Image:=ImageHaut;
      SensBas : Image:=ImageBas;
      else exit;
      end;
      StretchBlt(canvas.Handle,r.left,r.Top,ColWidths[6],RowHeights[6],   // destination avec mise à l'échelle
                 image.Canvas.Handle,0,0,FormSelTrain.imageHaut.Width,FormSelTrain.imageHaut.Height,srccopy);
    end;
  end;
end;

procedure maj_stringGrig;
var i,ic,t,NumCanton,Adr : integer;
    s : string;
begin
  // maj de la stringGrig
  if AffEvt then Affiche('Maj_stringGrid',clYellow);
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

    adr:=canton[idCantonSelect].adresseTrain;
    if adr<>0 then
    begin
      adr:=index_train_adresse(adr);
      s:=s+' train '+trains[adr].nom_train+' vers ';
      i:=canton[IdCantonSelect].SensLoco;
      case i of
        SensHaut : s:=s+' haut ';
        SensBas : s:=s+' bas ';
        SensGauche : s:=s+' gauche ';
        SensDroit : s:=s+' droit ';
      end;
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
  HauteurLigneSGT:=round(30/redFonte);
  with ImageHaut do begin Width:=60;Height:=60;visible:=false; end;
  with ImageBas do begin Width:=60;Height:=60;visible:=false; end;
  with ImageDroite do begin Width:=60;Height:=60;visible:=false; end;
  with ImageGauche do begin Width:=60;Height:=60;visible:=false; end;

  hautC:=25;
  largC:=130;
  LabelInfo.caption:='';
  with StringGridTrains do
  begin
    Anchors:=[];
    Anchors:=[AkTop,AkLeft,akright,akBottom];

    Hint:='Sélection d''un train';
    ShowHint:=true;
    ColCount:=8;    // nombre de colonnes
    RowCount:=Ntrains+1;
    ColWidths[0]:=round(50/RedFonte);;
    ColWidths[1]:=round(200/RedFonte);;     // icone
    ColWidths[2]:=round(150/RedFonte);;     // nom du train
    ColWidths[3]:=round(60/RedFonte);;      // canton
    ColWidths[4]:=round(100/RedFonte);;
    ColWidths[5]:=round(120/RedFonte);;
    ColWidths[6]:=round(30/RedFonte);;
    ColWidths[7]:=round(35/RedFonte);;
    LargeurSGT:=0;
    for i:=0 to 7 do LargeurSGT:=LargeurSGT+ColWidths[i];
    width:=LargeurSGT+30;

    Cells[0,0]:='Train'+#13+'N° / @';
    Cells[1,0]:='Icône';
    Cells[2,0]:='Nom du train';
    Cells[3,0]:='Affectation'+#13+'au canton';
    Cells[4,0]:='Nom du canton';
    Cells[5,0]:='TCO';
    Cells[6,0]:='Sens';
    Cells[7,0]:='Route';

    for i:=0 to RowCount-1 do
      RowHeights[i]:=HauteurLigneSGT;
  end;

  for i:=1 to ntrains do
  begin
    with StringGridTrains do
    begin
      cells[0,i]:=intToSTR(i)+' @'+intToSTR(Trains[i].adresse);
      cells[2,i]:=trains[i].nom_train;
    end;
  end;

  //options de la stringgrid
  StringGridTrains.Options:=StringGridTrains.options
  //pas édition  pas multiselect  trackbar dynamique   autoriz le dimensionnement des colonnes
  - [goEditing] - [goRangeSelect] + [goThumbTracking]+ [goColSizing]
  + [goAlwaysShowEditor] //- [goFixedRowDefAlign];

end;


procedure TFormSelTrain.StringGridTrainsDrawCell(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
var indextrain,l,h,hautdest,largdest : integer;
    rd : single;
    r : trect;
    coul: Tcolor;
    s : string;
begin
  //Affiche('DrawCell '+intToSTR(Acol)+'x'+intToSTR(Arow),clred);
  // titres sur 2 lignes
  if Arow=0 then
  with StringGridTrains do
  begin
    if Pos(#13,Cells[ACol,ARow])>0 then
    begin
      Coul:=canvas.Pixels[3,1];  // trouver la couleur de la première ligne de la stringgrid, car elle change en fonction des styles
      Canvas.Brush.Color:=coul;
      Canvas.FillRect(Rect);     // Efface la cellule qu'on va réécrire en mode WORDBREAK
      // rectangle du texte
      Inc(Rect.Left,1);
      Inc(Rect.Top,1);
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


// cliqué ou roulé la molette souris sur cellule pour changer la sélection du train ou voir la route ou la flèche
procedure TFormSelTrain.StringGridTrainsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var f,AutreTrain,AutreCanton,idAutrecanton,i,ancienSens,AdrTrain,IdTrain,sensloco,x,y,el : integer;
    faire : boolean;
    s : string;
begin
  if IdCantonSelect=0 then IdCantonSelect:=AncienIdCantonSelect;
  if affevt then Affiche('FormSelTrain.StringGridTrainsSelectCell col='+intToSTR(ACol)+' lig='+intToSTR(ARow),clYellow);
  if (Arow>nTrains) or (IdCantonSelect<1) then exit;

  faire:=false;
  //------------change la sélection du train
  if (Arow>=1) and (ACol<=5) then
  begin
    AncienSens:=0;
    indexTrainClic:=Arow;
    //  Affiche('ligne='+intToSTR(Arow)+' col='+intToSTR(Acol),clyellow);

    quel_canton(x,y,el);   // x,y El et indexCanton du canton activé

    faire:=true;
    LabelInfo.caption:='';
    // vérifier si le train est affecté à un autre canton
    AutreCanton:=trains[indexTrainClic].canton;
    idAutrecanton:=index_canton_numero(autreCanton);
    if (IdAutrecanton<>0) and (IdAutreCanton<>IdCantonSelect) then
    begin
      s:='Le train '+intToSTR(IndexTrainClic)+' '+trains[IndexTrainClic].nom_train+' est affecté au canton '+intToSTR(AutreCanton);
      LabelInfo.caption:=s;
      StringGridTrains.hint:='Affectation impossible,'+#13+s;
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
        LabelInfo.caption:='Suppression du train '+intToSTR(AutreTrain)+' '+trains[AutreTrain].nom_train+' du canton '+intToSTR(autrecanton);
        // affecter la route de l'ancien train au nouveau train
        routeSav:=trains[AutreTrain].route;  // sauve la route
        trains[AutreTrain].route[0].adresse:=0;
        StringGridTrains.Cells[7,AutreTrain]:='';
        trains[IndexTrainClic].route:=routeSav;

        AncienSens:=canton[idcantonSelect].SensLoco;
        faire:=true;
        if trains[indexTrainClic].canton=canton[IdCantonSelect].numero then faire:=false ; // ne pas faire l'affectaction, c'est une désaffectaction

        //raz_trains_idcanton(IdCantonSelect);  // au retour, route contient la route du train razé du canton
        raz_cantons_train(trains[AutreTrain].adresse,true);
        //Affiche('Et 1',clYellow);
        maj_signaux(false);
      end;


      // affecter le train, le canton et le TCO
      if faire then
      begin
        if anciensens=0 then if canton[IdCantonSelect].horizontal then SensLoco:=SensDroit else SensLoco:=SensBas;
        if ancienSens<>0 then SensLoco:=ancienSens;

        if (canton[IdCantonSelect].sensCirc<>0) then sensLoco:=canton[IdCantonSelect].sensCirc ;

        affecte_Train_canton(trains[indexTrainClic].adresse,IdCantonSelect,sensLoco);  // le train affecté contient la route du train razé
        s:='Affectation du train '+intToSTR(IndexTrainClic)+' '+trains[indexTrainClic].nom_train+' au canton '+intToSTR(canton[idcantonSelect].numero);
        LabelInfo.caption:=s;
        StringGridTrains.hint:=s;
        maj_signaux(false);
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

      inc(f);    // les sens vont de 1 à 4
      if canton[IdAutreCanton].horizontal then
      begin
        if (f<SensGauche) or (f>SensDroit) then f:=SensGauche;
      end
      else
      begin
        if (f>SensBas) or (f<SensHaut) then f:=SensHaut;
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

      renseigne_canton(IdAutreCanton);    //?? pourquoi faire le canton est normalement déjà renseigné
      affecte_Train_canton(AdrTrain,idAutreCanton,f);
      //Affiche('Et 3',clYellow);
      maj_signaux(false);
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
  maj_signaux(false);

end;

// actualise la fenetre
procedure actualise_seltrains;
var s : string;
    i,x,y,el : integer;
begin
  with formSelTrain.StringGridTrains do
  begin
    RowCount:=Ntrains+1;
    for i:=1 to ntrains do
    begin
      cells[2,i]:=trains[i].nom_train;
    end;
  end;

  Quel_canton(x,y,el);   // renvoie le canton en fonction de la var globale  IdCantonSelect
  FormSelTrain.caption:='';     // s est indéfini !!

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
begin
 formSelTrain.stringGridTrains.Perform(WM_VSCROLL,SB_TOP,0);
 for i:=1 to n-1 do
   formSelTrain.stringGridTrains.Perform(WM_VSCROLL,SB_LINEDOWN,0);
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
      Positionne_SG(i-1);       // positionne la scrollbar
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

