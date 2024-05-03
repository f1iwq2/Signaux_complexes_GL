unit selection_train;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TFormSelTrain = class(TForm)
    ButtonOK: TButton;
    StringGridTrains: TStringGrid;
    LabelInfo: TLabel;
    ComboBoxCanton: TComboBox;
    Label1: TLabel;
    ImageBas: TImage;
    ImageHaut: TImage;
    Imagegauche: TImage;
    ImageDroite: TImage;
    LabelCanton: TLabel;
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
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSelTrain: TFormSelTrain;
  x,y,El,largC,hautC,indexTrainClic : Integer;

procedure actualise_seltrains;
procedure affecte_Train_canton(AdrTrain,idcanton : integer);
procedure raz_trains_Idcanton(idc : integer);
procedure raz_cantons_train(AdrTrain : integer);
procedure init_route_canton(idcanton,IdTrain : integer;init : boolean);

implementation

uses UnitPrinc,UnitConfigCellTCO,UnitTCO,UnitPlace,unitconfig,unitDebug;

{$R *.dfm}

// supprime une entrée du tableau event_det_train contenant l'adresse du train
procedure supprime_route(adresse : integer);
var index,i,j : integer;
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
    dec(n_trains);
  end;
end;

// initialise (init=true) ou raze (init=false) la route d'un train qui a été affectée au canton
procedure init_route_canton(idcanton,IdTrain : integer;init : boolean);
var horz : boolean;
    el1,el2,suiv,prec,sens,t : integer;
    tel1,tel2 : tequipement;
    s : string;
begin
  //Affiche('Init_route_canton '+intToSTR(idcanton)+' '+inttoSTR(idtrain),clYellow);
  renseigne_canton(idcanton);
  sens:=canton[IdCanton].Sens; // direction du train sur le canton
  horz:=canton[idcanton].horizontal;
  if horz then
  begin
    if sens=SensDroit then   //-------------------------------
    begin
      el1:=canton[idCanton].el1;   // gauche
      tel1:=canton[idCanton].typ1;
      el2:=canton[idCanton].el2; // droit
      tel2:=canton[idCanton].typ2;
      // si le suivant n'est pas un détecteur, le trouver
      if (tel2<>det) and (tel1<>buttoir) then
      begin
        suiv:=detecteur_suivant_El(el1,tel1,el2,tel2,1); // arrêt sur suivant
        el2:=suiv;
      end;
      // si le précédent n'est pas un détecteur, le trouver
      if (tel1<>det) and (tel1<>buttoir) then
      begin
        prec:=detecteur_suivant_El(el2,tel2,el1,tel1,1); // arrêt sur suivant
        el2:=prec;
      end;
      if init then
      begin
        //Affiche('nouvelle route vers droit',clYellow);
        inc(n_trains);
        s:=trains[idtrain].nom_train;
        event_det_train[n_trains].NbEl:=1 ;
        event_det_train[n_trains].AdrTrain:=trains[idtrain].adresse;
        event_det_train[n_trains].det[1].adresse:=el2;
        event_det_train[n_trains].det[1].etat:=false;
        event_det_train[n_trains].nom_train:=s;
        event_det_train[n_trains].NbEl:=1;

        MemZone[el1,el2].etat:=true;
        MemZone[el1,el2].train:=s;
        MemZone[el1,el2].AdrTrain:=trains[idtrain].adresse;
        maj_signaux(true);

        Affiche_Evt('1-0. Tampon train @'+intToStr(trains[idtrain].adresse)+' '+event_det_train[n_trains].nom_train+'--------',clWhite);
        Affiche_Evt(intToSTR(event_det_train[n_trains].det[1].adresse),clwhite);

        // réserver le canton
        if roulage then
        begin
          t:=canton[idcanton].ntco;
          zone_tco(t,el2,6,0,0,12);   // élément contigu à droite (6) du canton
          reserve_canton(el2,xcanton,trains[idtrain].adresse,0,nCantonsRes);
        end;
      end
      else
      begin
        // supprimer les 2 sens
        MemZone[el1,el2].etat:=false;
        MemZone[el1,el2].train:='';
        MemZone[el1,el2].AdrTrain:=0;
        MemZone[el2,el1].etat:=false;
        MemZone[el2,el1].train:='';
        MemZone[el2,el1].AdrTrain:=0;

        maj_signaux(true);
        supprime_route(trains[idTrain].adresse);
      end;
    end;
    if Sens=SensGauche then    //-------------------------------
    begin
      el2:=canton[idCanton].el1;   // gauche dans el2
      tel2:=canton[idCanton].typ1;
      el1:=canton[idCanton].el2; // droit dans el1
      tel1:=canton[idCanton].typ2;
      // si le suivant n'est pas un détecteur, le trouver
      if (tel1<>det) and (tel1<>buttoir) then
      begin
        suiv:=detecteur_suivant_El(el1,tel1,el2,tel2,1); // arrêt sur suivant
        el2:=suiv;
      end;
      // si le précédent n'est pas un détecteur, le trouver
      if (tel2<>det) and (tel1<>buttoir) then
      begin
        prec:=detecteur_suivant_El(el2,tel2,el1,tel1,1); // arrêt sur suivant
        el2:=prec;
      end;
      if init then
      begin
        //Affiche('nouvelle route vers gauche',clYellow);
        inc(n_trains);
        //init_route(n_trains,el2,el1,idtrain);
        s:=trains[idtrain].nom_train;
        event_det_train[n_trains].NbEl:=1 ;
        event_det_train[n_trains].AdrTrain:=trains[idtrain].adresse;
        event_det_train[n_trains].det[1].adresse:=el2;
        event_det_train[n_trains].det[1].etat:=false;
        event_det_train[n_trains].nom_train:=s;
        event_det_train[n_trains].NbEl:=1;

        MemZone[el1,el2].etat:=true;
        MemZone[el1,el2].train:=s;
        MemZone[el1,el2].AdrTrain:=trains[idtrain].adresse;
        maj_signaux(true);

        // réserver le canton
        if roulage then
        begin
          t:=canton[idcanton].ntco;
          zone_tco(t,el2,5,0,0,12);   // élément contigu à gauche (5) du canton
          reserve_canton(el2,xcanton,trains[idtrain].adresse,0,nCantonsRes);
        end;
      end
      else
      begin
        // supprimer les 2 sens
        MemZone[el2,el1].etat:=false;
        MemZone[el2,el1].train:='';
        MemZone[el2,el1].AdrTrain:=0;

        MemZone[el1,el2].etat:=false;
        MemZone[el1,el2].train:='';
        MemZone[el1,el2].AdrTrain:=0;
        maj_signaux(true);
        supprime_route(trains[idTrain].adresse);
      end;
    end;
  end
  else
  // canton vertical
  begin
    if Sens=SensBas then
    begin
      el1:=canton[idCanton].el1;   // haut
      tel1:=canton[idCanton].typ1;
      el2:=canton[idCanton].el2; // bas
      tel2:=canton[idCanton].typ2;
      // si le suivant n'est pas un détecteur, le trouver
      if (tel2<>det) and (tel1<>buttoir) then
      begin
        suiv:=detecteur_suivant_El(el1,tel1,el2,tel2,1); // arrêt sur suivant
        el2:=suiv;
      end;
      // si le précédent n'est pas un détecteur, le trouver
      if (tel1<>det) and (tel1<>buttoir) then
      begin
        prec:=detecteur_suivant_El(el2,tel2,el1,tel1,1); // arrêt sur suivant
        el2:=prec;
      end;
      if init then
      begin
        //Affiche('nouvelle route vers bas',clYellow);
        inc(n_trains);
        s:=trains[idtrain].nom_train;
        event_det_train[n_trains].NbEl:=1 ;
        event_det_train[n_trains].AdrTrain:=trains[idtrain].adresse;
        event_det_train[n_trains].det[1].adresse:=el2;
        event_det_train[n_trains].det[1].etat:=false;
        event_det_train[n_trains].nom_train:=s;
        event_det_train[n_trains].NbEl:=1;

        MemZone[el1,el2].etat:=true;
        MemZone[el1,el2].train:=s;
        MemZone[el1,el2].AdrTrain:=trains[idtrain].adresse;
        maj_signaux(true);

        // réserver le canton
        if roulage then
        begin
          t:=canton[idcanton].ntco;
          zone_tco(t,el2,8,0,0,12);   // élément contigu en bas (8) du canton
          reserve_canton(el2,xcanton,trains[idtrain].adresse,0,nCantonsRes);
        end;
      end
      else
      begin
        // supprimer les 2 sens
        MemZone[el1,el2].etat:=false;
        MemZone[el1,el2].train:='';
        MemZone[el1,el2].AdrTrain:=0;

        MemZone[el2,el1].etat:=false;
        MemZone[el2,el1].train:='';
        MemZone[el2,el1].AdrTrain:=0;
        maj_signaux(true);
        supprime_route(trains[idTrain].adresse);
      end;
    end;
    if Sens=SensHaut then
    begin
      el2:=canton[idCanton].el1;   // haut dans el2
      tel2:=canton[idCanton].typ1;
      el1:=canton[idCanton].el2; // bas dans el1
      tel1:=canton[idCanton].typ2;
      // si le suivant n'est pas un détecteur, le trouver
      if (tel1<>det) and (tel1<>buttoir) then
      begin
        suiv:=detecteur_suivant_El(el1,tel1,el2,tel2,1); // arrêt sur suivant
        el2:=suiv;
      end;
      // si le précédent n'est pas un détecteur, le trouver
      if (tel2<>det) and (tel1<>buttoir) then
      begin
        prec:=detecteur_suivant_El(el2,tel2,el1,tel1,1); // arrêt sur suivant
        el2:=prec;
      end;
      if init then
      begin
        //Affiche('nouvelle route vers haut',clYellow);
        inc(n_trains);
        //init_route(n_trains,el2,el1,idtrain);
        s:=trains[idtrain].nom_train;
        event_det_train[n_trains].NbEl:=1 ;
        event_det_train[n_trains].AdrTrain:=trains[idtrain].adresse;
        event_det_train[n_trains].det[1].adresse:=el2;
        event_det_train[n_trains].det[1].etat:=false;
        event_det_train[n_trains].nom_train:=s;
        event_det_train[n_trains].NbEl:=1;

        MemZone[el2,el1].etat:=false;
        MemZone[el2,el1].train:='';
        MemZone[el2,el1].AdrTrain:=0;

        MemZone[el1,el2].etat:=true;
        MemZone[el1,el2].train:=s;
        MemZone[el1,el2].AdrTrain:=trains[idtrain].adresse;
        maj_signaux(true);

        // réserver le canton
        if roulage then
        begin
          t:=canton[idcanton].ntco;
          zone_tco(t,el2,7,0,0,12);   // élément contigu en haut (7) du canton
          reserve_canton(el2,xcanton,trains[idtrain].adresse,0,nCantonsRes);
        end;
      end
      else
      begin
        // supprimer les 2 sens
        MemZone[el1,el2].etat:=false;
        MemZone[el1,el2].train:='';
        MemZone[el1,el2].AdrTrain:=0;

        MemZone[el2,el1].etat:=false;
        MemZone[el2,el1].train:='';
        MemZone[el2,el1].AdrTrain:=0;
        maj_signaux(true);
        supprime_route(trains[idTrain].adresse);
      end;
    end;
  end;
end;

// supprime le train AdrTrain de tous les cantons, et réaffiche les cantons effacés concernés
procedure raz_cantons_train(AdrTrain : integer);
var i,t,idcanton,idTCO,x,y : integer;
begin
  if (AdrTrain=0) then exit;
  //Affiche('Raz_cantons_train(Adr='+intToSTR(AdrTrain)+')',clyellow);
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
        Dessin_canton(idTCO,pcanvasTCO[idTCO],x,y,0,0);
      end;
    end;
    exit;
  end;
  {
  if indexTrain<>0 then
  begin
    for i:=1 to Ncantons do
    begin
      if canton[i].indexTrain=IndexTrain then
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
        Dessin_canton(idTCO,pcanvasTCO[idTCO],x,y,0,0);
      end;
    end;
  end;
  }

end;


// affecte le train id train ou adresse au canton et au TCO.
// désaffecte ce train pour tous les autres canton
// si adrTrain=9999 , train inconnu
// si adrTrain=0    ; efface
// et les pointeurs de trains de l'idTrain sont razés
procedure affecte_Train_canton(AdrTrain,idcanton : integer);
var idTrain,t,i : integer;
begin
  //Affiche('Affecte_train_canton: IdTrain='+intToSTR(idTrain)+' @='+intToSTR(AdrTrain)+' canton='+intToSTR(idcanton),clorange);
  if (IdCanton>0) and (idCanton<=nCantons) then
  begin
    if (AdrTrain<>0) and (adrTrain<>9999) then
    begin
      idTrain:=Index_train_adresse(adrTrain);

      raz_cantons_train(AdrTrain);   // efface tous les cantons affichant le train Adrtrain

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
    if (t>0) and (t<=nbreTCO) then TCO[t,canton[idCanton].x,canton[idCanton].y].train:=idTrain;
  end;
end;

// renvoie x,y El et indexCanton en variable globale
procedure quel_canton;
begin
  if IdCantonSelect=0 then exit;
  x:=canton[IdCantonSelect].x;
  y:=canton[IdCantonSelect].y;
  El:=tco[indexTCOCourant,x,y].BImage;
end;

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
      case canton[idcanton].Sens of
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
    s:='Canton '+intToSTR(IdCantonSelect)+' encadré par '+intToSTR(canton[IdCantonSelect].el1);
    i:=canton[IdCantonSelect].Sens1;
    case i of
      SensHaut : s:=s+' haut ';
      SensBas : s:=s+' bas ';
      SensGauche : s:=s+' gauche ';
      SensDroit : s:=s+' droit ';
    end;
    s:=s+' '+intToSTR(canton[IdCantonSelect].el2);

    i:=canton[IdCantonSelect].Sens2;
    case i of
      SensHaut : s:=s+' haut ';
      SensBas : s:=s+' bas ';
      SensGauche : s:=s+' gauche ';
      SensDroit : s:=s+' droit ';
    end;

    s:=s+' loco vers ';
    i:=canton[IdCantonSelect].Sens;
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
       end
       else
       begin
         cells[3,i]:=''; cells[4,i]:=''; cells[5,i]:='';
         cells[6,i]:='';  // efface la fleche
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
var i,x,y : integer;
begin
{  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
  Canton[3].indexTrain:=1;
  TCO[1,canton[3].x,canton[3].y].train:=1;
  trains[1].canton:=3;
 }

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
    ColCount:=7;
    RowCount:=Ntrains+1;
    Options := StringGridTrains.Options + [goEditing];
    ColWidths[0]:=30;
    ColWidths[1]:=200;     // icone
    ColWidths[2]:=150;     // nom du train
    ColWidths[3]:=60;      // canton
    ColWidths[4]:=100;
    ColWidths[5]:=100;
    ColWidths[6]:=30;


    Cells[1,0]:='Icône';
    Cells[2,0]:='Nom du train';
    Cells[3,0]:='N°canton';
    Cells[4,0]:='Nom du canton';
    Cells[5,0]:='TCO';
    Cells[6,0]:='Sens';

    RowHeights[0]:=22;
  end;

  for i:=1 to ntrains do
  begin
    with StringGridTrains do
    begin
      cells[2,i]:=trains[i].nom_train;
    end;
  end;

  // interdit la modification des cellules au clavier
  with StringGridTrains do
  begin
  for x:=0 to RowCount-1 do
    for y:=0 to ColCount-1 do
    StringGridTrains.Options := StringGridTrains.Options - [goEditing] - [goRangeSelect];    
  end;
end;


procedure TFormSelTrain.StringGridTrainsDrawCell(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
var indextrain,l,h,hautdest,largdest : integer;
    rd : double;
begin
 // Affiche('DrawCell '+intToSTR(Acol)+'x'+intToSTR(Arow),clred);

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

      //y:=rect.bottom-rect.top-HautDest;
      TransparentBlt(canvas.Handle,rect.Left+2,rect.Top,largDest,hautDest,
                     Trains[indexTrain].Icone.canvas.Handle,0,0,l,h,clWhite);
    end;
  end;

  // dessine les fleches
  if (Acol=6) and (Arow>0) then
    dessine_fleche(Arow,rect);
end;

// c = numéro de canton
procedure xxraz_trains_canton(c : integer);
var ax,ay,i,ic : integer;
begin

  for i:=1 to Ntrains do
  begin
    ic:=trains[i].canton;
    if ic=c then
    begin
      trains[i].canton:=0;
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

// raz des trains affectés au canton d'index "idc"
procedure raz_trains_idcanton(idc : integer);
var ax,ay,i,ic : integer;
begin
  for i:=1 to Ntrains do
  begin
    ic:=index_canton_numero(trains[i].canton);
    if ic=idc then
    begin
      trains[i].canton:=0;
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

// cliqué sur cellule pour changer la sélection du train ou la flèche
procedure TFormSelTrain.StringGridTrainsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var f,AutreTrain,AutreCanton,idAutrecanton,i : integer;
    faire : boolean;
begin
  if affevt then Affiche('FormSelTrain.StringGridTrainsSelectCell '+intToSTR(ACol)+' '+intToSTR(ARow),clYellow);
  if (Arow>nTrains) or (IdCantonSelect<1) then exit;

  //------------change la sélection du train
  if (Arow>=1) and (ACol<=5) then
  begin
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
      LabelInfo.caption:='Le train '+intToSTR(IndexTrainClic)+' est affecté au canton '+intToSTR(AutreCanton);
      exit;
    end;

    if faire then
    begin
      // vérifier si un autre train est affecté au canton
      AutreTrain:=canton[IdCantonSelect].indexTrain;
      if autreTrain<>0 then
      begin
        LabelInfo.caption:='Le train '+intToSTR(AutreTrain)+' est déjà affecté au canton - Effacement';
        faire:=true;
        if trains[indexTrainClic].canton=canton[IdCantonSelect].numero then faire:=false ; // ne pas faire l'affectaction, c'est une désaffectaction
        raz_trains_idcanton(IdCantonSelect);
        //Affiche('Et 1',clYellow);
        init_route_canton(IdCantonSelect,indexTrainClic,false);  // raz du placement du train et de sa route
      end;

      // affecter le train, le canton et le TCO
      if faire then
      begin
        if canton[IdCantonSelect].horizontal then canton[IdCantonSelect].Sens:=SensDroit else canton[IdCantonSelect].Sens:=SensBas;
        //Affiche('Et 2',clYellow);
        affecte_Train_canton(trains[indexTrainClic].adresse,IdCantonSelect);
        init_route_canton(IdCantonSelect,indexTrainClic,true);  // placement du train
      end;
    end;
  end;

  // change le sens----------------------------
  if Acol=6 then
  begin
    // si on a cliqué sur un train affecté, on procède
    IdAutreCanton:=index_canton_numero(trains[Arow].canton);
    if IdAutreCanton>0 then
    begin
      f:=canton[IdAutreCanton].Sens;

      inc(f);
      if canton[IdAutreCanton].horizontal then
      begin
        if (f<1) or (f>SensDroit) then f:=SensGauche;
      end
      else
      begin
        if (f=5) or (f<SensHaut) then f:=SensHaut;
      end;

      renseigne_canton(IdAutreCanton);
      canton[IdAutreCanton].Sens:=f;
      //Affiche('Et 3',clYellow);
      init_route_canton(IdCantonSelect,indexTrainClic,false);  // raz du placement du train et de sa route
      init_route_canton(IdCantonSelect,indexTrainClic,true);  // placement du train et de sa route

    end;
  end;

  maj_stringGrig;

  // met à jour les cantons
  for i:=1 to nCantons do
  begin
    dessin_canton(i,0,0);
  end;

end;

procedure actualise_seltrains;
var s : string;
    i : integer;
begin
  Quel_canton;
  s:='Sélection d''un train';
  if IdCantonSelect>0 then s:=s+' au canton '+intToSTR(IdCantonSelect)+' : '+canton[IdCantonSelect].nom;
  FormSelTrain.caption:=s;

  with formSelTrain.ComboBoxCanton do
  begin
    clear;
    for i:=1 to nCantons do items.add('Canton n°'+IntToSTR(canton[i].numero)+' '+canton[i].nom);
    ItemIndex:=IdCantonSelect-1;
  end;

  if IdCantonSelect=0 then formSelTrain.labelInfo.caption:='Sélectionnez un canton';

  maj_stringGrig;    // change indexcanton
end;

procedure TFormSelTrain.FormActivate(Sender: TObject);
begin
  actualise_Seltrains;
end;



procedure TFormSelTrain.StringGridTrainsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  key:=0; // évite le mouvement de sélection par les touches
end;

procedure TFormSelTrain.ComboBoxCantonChange(Sender: TObject);
begin
  IdCantonSelect:=ComboBoxCanton.itemIndex+1;
  maj_stringGrig;
  Affiche_TCO(indexTCOCourant);
end;



end.

