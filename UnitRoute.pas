unit UnitRoute;

// choix des routes pour un train

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, StdCtrls, ExtCtrls , UnitPrinc;

type
  TFormRoute = class(TForm)
    ListBoxRoutes: TListBox;
    ButtonEfface: TButton;
    LabelInfo: TLabel;
    ButtonQuitte: TButton;
    LabelNombre: TLabel;
    ButtonDetail: TButton;
    ButtonRAZ: TButton;
    ImageTrainR: TImage;
    ComboBoxTrains: TComboBox;
    ButtonFenPil: TButton;
    procedure FormActivate(Sender: TObject);
    procedure ListBoxRoutesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonEffaceClick(Sender: TObject);
    procedure ButtonQuitteClick(Sender: TObject);
    procedure ButtonDetailClick(Sender: TObject);
    procedure ButtonRAZClick(Sender: TObject);
    procedure ListBoxRoutesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonFenPilClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormRoute: TFormRoute;
  parcoursDet : TUneroute;
  AncLigneRoute,LigneRoute,IdTrainCourant : integer;

procedure raz_route_fenetre;
procedure raz_toutes_routes;
procedure efface_route_tco;
function affiche_route_tco : boolean;
procedure Efface_Affiche_route;

implementation

uses UnitDebug,unitTCO,UnitConfig, UnitRouteTrains;

{$R *.dfm}

// efface la route parcoursDet[]
procedure efface_route_tco;
var n,det1,det2,i,indexAig : integer;
    t : tequipement;
begin
  n:=parcoursdet[0].adresse;
  det1:=parcoursdet[1].adresse;
  for i:=2 to n do
  begin
    det2:=parcoursdet[i].adresse;
    t:=ParcoursDet[i].typ;
    if (t=aig) or (t=tjd) or (t=triple) then
    begin
      indexaig:=index_aig(ParcoursDet[i].adresse);
      aiguillage[indexAig].AncPos:=aiguillage[indexAig].position;  // sauve position
      aiguillage[indexAig].position:=parcoursDet[i].pos;
    end;
    if t=det then
    begin
      zone_tco(1,det1,det2,1,0,0,true); // mode "aiguillages mis"
      det1:=det2;
    end;
  end;
  // remettre les aiguillages
  for i:=2 to n do
  begin
    t:=ParcoursDet[i].typ;
    if (t=aig) or (t=tjd) or (t=triple) then
    begin
      indexaig:=index_aig(ParcoursDet[i].adresse);
      aiguillage[indexAig].Position:=aiguillage[indexAig].AncPos;  // restitue position
    end;
  end;
end;

// efface la fenetre et la route du tco
procedure raz_route_fenetre;
begin
  efface_route_tco;

  formRoute.ListBoxRoutes.Clear;
  ligneroute:=-1;
end;

// Affiche sans effacer l'ancienne, la route du TCO du tableau ParcoursDet[]
// détruit l'index du train dans le canton  !!!! zizi
function Affiche_route_TCO : boolean ;
var i,n,det1,det2,indexAig : integer;
    t :tequipement;
    ok : boolean;
begin
 //exit;
  n:=ParcoursDet[0].adresse;
  ok:=true;
  det1:=parcoursDet[1].adresse;
  for i:=2 to n do
  begin
    t:=ParcoursDet[i].typ;
    if (t=aig) or (t=tjd) or (t=triple) then
    begin
      indexaig:=index_aig(ParcoursDet[i].adresse);
      aiguillage[indexAig].AncPos:=aiguillage[IndexAig].position;  // sauvegarder position
      aiguillage[indexAig].position:=ParcoursDet[i].pos;           // forcer la position de l'aiguillage sue le parcours
    end;                                                           // car on utilise TRUE dans la fonction zone_tco
    if t=det then
    begin
      det2:=ParcoursDet[i].adresse;
      ok:=zone_tco(1,det1,det2,1,0,1,true) and ok;
      det1:=det2;
    end;
  end;

  // remettre la position d'origine des aiguillages
  for i:=1 to n do
  begin
    t:=ParcoursDet[i].typ;
    if (t=aig) or (t=tjd) or (t=triple) then
    begin
      indexaig:=index_aig(ParcoursDet[i].adresse);
      aiguillage[indexAig].Position:=aiguillage[IndexAig].AncPos;  // remettre position
    end;
  end;
  result:=ok;
end;

// Efface, fabrique le tableau ParcoursDet[] depuis TabloRoute[id] affiche la route dans le TCO contenue dans ParcoursDet[]
procedure Efface_Affiche_route;
var n,id : integer;
    ok : boolean;
    s : string;
begin
  AncLigneRoute:=LigneRoute;

  if LigneRoute<0 then exit;
  id:=LigneRoute+1;
  formRoute.ButtonDetail.caption:='Détail route '+intToSTR(id);
  formRoute.ButtonEfface.caption:='Efface route '+intToSTR(id)+' du TCO';

  efface_route_tco;

  // fabriquer le tableau parcoursDet[] depuis tabloRoute[]
  parcoursDet:=tabloRoute[id];
  n:=ParcoursDet[0].adresse;

  // Affiche les routes
  ok:=Affiche_route_tco;

  s:='Route '+intToSTR(id)+'/'+intToSTR(NbreRoutes)+' : '+intToSTR(n)+' éléments';
  //if not(ok) then s:=s+' - Route pas affichable car des éléments ne sont pas au TCO';
  formRoute.LabelNombre.Caption:=s;
end;


procedure clic_route(r : integer);
var idTrain : integer;
begin
  LigneRoute:=r;
  // copier la route au train
  if (idcantonroute<1) or (ligneroute<0) then exit;
  idTrain:=Index_Train_adresse(canton[idCantonRoute].AdrTrainRoute);
  //IdTrain:=canton[idcantonRoute].indexTrain;
  if idtrain<1 then
  begin
    // le train a été déplacé
    affiche('Anomalie 50',clred);
    exit;
  end;

  trains[idTrain].route:=tabloroute[LigneRoute+1];

  formRoute.ButtonFenPil.enabled:=trains[IdTrain].route[0].adresse<>0;

  Efface_affiche_route;

end;


// affiche les routes du train courant
procedure maj_fenetre;
var l,pluslongue,n,j,pixelLength : integer;
    s,chaineLongue : string;
begin
  if (cantonorg=0) or (cantonDest=0) then FormRoute.caption:='Pas de canton depart/arrivée' else
  formRoute.caption:='Liste des routes trouvées du train '+canton[idcantonRoute].NomTrain+' pour aller de '+intToSTR(DetDepart)+' (canton '+intToSTR(cantonOrg)+
           ') à '+intToSTR(DetaTrouve)+' (canton '+intToSTR(cantonDest)+')';
  plusLongue:=0;

  formRoute.ButtonDetail.caption:='Détail route ';
  formRoute.ButtonEfface.caption:='Efface route ';

  if idcantonRoute<>0 then formRoute.ListBoxRoutes.Hint:='Sélectionne une route pour l''affecter au train '+canton[idcantonRoute].NomTrain;
  formRoute.listBoxRoutes.Clear;

  // trouver le canton dest d'après le canton origine cliqué
  if IdCantonClic=0 then exit;
  idCantonRoute:=index_canton_numero(canton[idCantonClic].NumcantonOrg);

  if idcantonroute<>0 then
  begin
    IdTrainCourant:=canton[idcantonRoute].indexTrain;
    if idTrainCourant>9000 then
    begin
      Affiche('Anomalie 626 ',clred);
      messageBeep(Mb_iconError);
      exit;
    end;
  end
  else idtraincourant:=0;

  if NbreRoutes>0 then FormRoute.labelInfo.Caption:='Cliquer sur une route pour la visualiser sur le TCO et l''affecter au train';

  for j:=1 to NbreRoutes do
  begin
    n:=tabloroute[j,0].adresse;
    s:=intToSTR(j)+'. ';
    s:=s+route_to_string(tabloroute[j]);
    l:=Length(s);
    if l>pluslongue then
    begin
      chainelongue:=s;
      pluslongue:=l;
    end;

    FormRoute.listBoxRoutes.Items.Add(s);
  end;

  PixelLength:=FormRoute.ListboxRoutes.Canvas.TextWidth(chaineLongue)+30;
  // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
  SendMessage(FormRoute.ListBoxRoutes.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);

  // icone train
  if idcantonRoute<>0 then Maj_icone_train(FormRoute.ImageTrainR,idTrainCourant);

  formRoute.ButtonFenPil.enabled:=trains[IdTrainCourant].route[0].adresse<>0;

  if NbreRoutes=1 then clic_route(0);
end;

procedure TFormRoute.FormActivate(Sender: TObject);
begin
  maj_fenetre;
end;

procedure TFormRoute.ListBoxRoutesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  LigneRoute:=listBoxRoutes.Itemindex;
  clic_route(ligneRoute);
end;

procedure TFormRoute.ButtonEffaceClick(Sender: TObject);
begin
  efface_route_tco;
end;

procedure TFormRoute.ButtonQuitteClick(Sender: TObject);
begin
  close;
end;


procedure TFormRoute.ButtonDetailClick(Sender: TObject);
var i,j,n,p : integer;
   s : string;
   typ : tequipement;
begin
  if ligneroute<0 then exit;
  with formprinc do
  begin
    windowState:=wsNormal; //Maximized;
    show;
    BringToFront;
  end;

  j:=ligneroute+1;
  n:=tabloroute[j,0].adresse;
  Affiche('Route '+intToSTR(j)+' ---------------n='+intToSTR(n),clwhite);
  for i:=1 to n do
  begin
    s:=intToSTR(tabloroute[j,i].adresse)+' '+BTypeToChaine(tabloroute[j,i].typ)+' ';
    p:=tabloRoute[j,i].pos;
    typ:=tabloRoute[j,i].typ;
    if (typ=aig) or (typ=tjd) or (typ=tjs) or (typ=triple) then
    begin
      case p of
        const_droit : s:=s+'droit';
        const_devie : s:=s+'dev';
        0 : s:=s+'talon';
        else s:=s+intToSTR(p);
      end;
      if tabloroute[j,i].talon then s:=s+' (en talon)';
    end;
    Affiche(s,clyellow);
  end;
end;

procedure RAZ_toutes_routes;
var i,idt : integer;
begin
  efface_route_tco;
  raz_route_fenetre;

  // raz état des boutons des cantons org et dest
  if cantonOrg>0 then canton[cantonOrg].bouton:=0;
  if cantonDest>0 then canton[cantonDest].bouton:=0;

  i:=index_canton_numero(cantonOrg);
  if i>0 then
  begin
    canton[i].bouton:=0;
    dessin_canton(i,0);   // remet le bouton jaune du canton org
    // raz la route du train
    idt:=canton[i].indexTrain;
    if idt>0 then
    begin
      trains[idt].route[0].adresse:=0;
    end;
  end;

  i:=index_canton_numero(cantonDest);
  if i>0 then
  begin
    canton[i].bouton:=0;
    dessin_canton(i,0);   // remet le bouton jaune du canton dest
  end;

  // efface icone train
  with formRoute do
  begin
    ImageTrainR.Canvas.Rectangle(0,0,ImageTrainr.Width,ImageTrainr.Height);
    labelNombre.caption:='';
  end;

  formRoute.ButtonFenPil.enabled:=false;

  formRoute.caption:='Routes';

  NbreRoutes:=0;
  detDepart:=0;
  detAtrouve:=0;
  cantonOrg:=0;
  cantonDest:=0;
end;

procedure TFormRoute.ButtonRAZClick(Sender: TObject);
begin
  raz_toutes_routes;
  close;
end;

procedure TFormRoute.ListBoxRoutesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key)=VK_UP) and (ligneroute>0) then
  begin
    dec(ligneRoute);
    efface_affiche_route;
  end;
  if (ord(Key)=VK_DOWN) and (ligneroute+1<NbreRoutes) then
  begin
    inc(ligneRoute);
    efface_affiche_route;
  end;
end;


procedure TFormRoute.FormCreate(Sender: TObject);
begin
  ButtonFenPil.hint:='Ouvre la fenêtre de pilotage des trains'+#13+'ce qui permet de lancer leur roulage';
  ButtonDetail.hint:='Affiche le détail de la route en fenêtre principale';

  // fenêtre toujours devant
  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NoMove or SWP_NoSize);
end;


procedure TFormRoute.FormClose(Sender: TObject; var Action: TCloseAction);
var idtrain : integer;
begin
  if (idcantonroute<1) or (idcantonRoute>nCantons) then exit;
  IdTrain:=canton[idcantonRoute].indexTrain;
  if idtrain>0 then
  begin
    caption:='Routes';
    if trains[idTrain].route[0].adresse<>0 then raz_route_fenetre;
    // efface icone train
    with formRoute do
    begin
      ImageTrainR.Canvas.Rectangle(0,0,ImageTrainr.Width,ImageTrainr.Height);
      labelNombre.caption:='';
    end;

  end;
  efface_route_tco;
end;

procedure TFormRoute.ButtonFenPilClick(Sender: TObject);
begin
  indexTrainFR:=canton[idcantonRoute].indexTrain;
  FormRouteTrain.show;
  close;
end;

end.
