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
    ButtonFenPil: TButton;
    Button1: TButton;
    ButtonRaf: TButton;
    GroupBox1: TGroupBox;
    EditObligeCanton: TEdit;
    EditInterditCanton: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ButtonTrouver: TButton;
    CheckBoxRoutesLongues: TCheckBox;
    CheckBoxDebugRoutes: TCheckBox;
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
    procedure ButtonParcours(Sender: TObject);
    procedure ButtonRafClick(Sender: TObject);
    procedure EditObligeCantonChange(Sender: TObject);
    procedure EditInterditCantonChange(Sender: TObject);
    procedure ButtonTrouverClick(Sender: TObject);
    procedure ListBoxRoutesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckBoxRoutesLonguesClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormRoute: TFormRoute;
  parcoursDet : TUneroute;
  CoulText : Tcolor;
  StyleText : integer;
  AncLigneRoute,NumRoute,AncRoute,IndexLigneRoute,IdTrainCourant,Nprop,NpropTot : integer;
  list_det_obl,list_det_int : array[1..20] of record
              adresse : integer;
              n :integer;
              end;

procedure raz_route_fenetre;
procedure raz_toutes_routes;
procedure efface_route_tco(affecte_loco :boolean);
function affiche_route_tco : boolean;
procedure Efface_Affiche_route;

implementation

uses UnitDebug,unitTCO,UnitConfig, UnitRouteTrains , Selection_Train;

{$R *.dfm}

// efface la route parcoursDet[] du TCO indexTCOcourant
// si affecte_loco=true : affecte la loco rencontrée aux cantons
procedure efface_route_tco(affecte_loco :boolean);
var n,det1,nti,x,y,det2,i,indexAig : integer;
    t : tequipement;
begin
  if Nbretco<1 then exit;
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
      zone_tco(indexTCOcourant,det1,det2,1,0,0,true,affecte_loco); // mode "aiguillages mis"
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

  // rafraichir la position des aiguillages dans les TCO
  for nti:=1 to NbreTCO do
  begin
    for y:=1 to NbreCellY[nti] do
      for x:=1 to NbreCellX[nti] do
        begin
          if IsAigTJDCroiTCO(tco[nti,x,y].BImage) then
          begin
            affiche_cellule(nti,x,y);
           // entoure_cell_grille(indexTCO,x,y);
          end;
        end;
    FormTCO[nti].Repaint;
  end;
end;

// efface la fenetre et la route du tco
procedure raz_route_fenetre;
begin
  efface_route_tco(false);     // ne change pas l'affectation de la loco rencontrée

  formRoute.ListBoxRoutes.Clear;
  Indexligneroute:=-1;
  NumRoute:=-1;
end;


// Affiche sans effacer l'ancienne, la route du TCO indexTCOcourant du tableau ParcoursDet[]
function Affiche_route_TCO : boolean ;
var i,n,det1,det2,indexAig : integer;
    t :tequipement;
    ok : boolean;
begin
  if Nbretco<1 then begin result:=false;exit;end;
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
      //Affiche('Aig='+intToSTR(ParcoursDet[i].adresse)+' pos='+intToSTR(aiguillage[IndexAig].position),clYellow);
      aiguillage[indexAig].position:=ParcoursDet[i].pos;           // forcer la position de l'aiguillage sue le parcours
    end;                                                           // car on utilise TRUE dans la fonction zone_tco
    if t=det then
    begin
      det2:=ParcoursDet[i].adresse;
      //          tco,det1,det2,train,adrTrain,Mode,posAig,affecte_loco
      ok:=zone_tco(indexTCOcourant,det1,det2,1,0,1,true,false) and ok;     //posAig=true=teste les routes en récursif  affecte_loco=n'affecte pas la loco
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

// Efface route du TCO, fabrique le tableau ParcoursDet[] depuis TabloRoute[id] et affiche la route dans le TCO contenue dans ParcoursDet[]
procedure Efface_Affiche_route;
var n,id : integer;
    ok : boolean;
    s : string;
begin
  if Nbretco<1 then exit;
  AncLigneRoute:=IndexLigneRoute;

  if IndexLigneRoute<0 then exit;
  id:=IndexLigneRoute;
  formRoute.ButtonDetail.caption:='Détail route '+intToSTR(id+1);
  formRoute.ButtonEfface.caption:='Efface route '+intToSTR(id+1)+' du TCO';

  efface_route_tco(false);

  // fabriquer le tableau parcoursDet[] depuis tabloRoute[]
  parcoursDet:=tabloRoute[NumRoute];
  n:=ParcoursDet[0].adresse;

  // Affiche les routes
  ok:=Affiche_route_tco;

  s:=intToSTR(Nprop)+' propositions - Route '+intToSTR(NumRoute)+'/'+intToSTR(NbreRoutes)+' : '+intToSTR(n)+' éléments';
  //if not(ok) then s:=s+' - Route pas affichable car des éléments ne sont pas au TCO';
  formRoute.LabelNombre.Caption:=s;
end;


// r: numéro de route
procedure clic_route(r : integer);
var idTrain : integer;
begin
  // copier la route au train
  if (idcantonroute<1) or (Indexligneroute<0) then exit;
  idTrain:=Index_Train_adresse(canton[idCantonRoute].AdrTrainRoute);
  //IdTrain:=canton[idcantonRoute].indexTrain;
  if (idtrain<0) or (idTrain>Max_Trains) then
  begin
    // le train a été déplacé
    affiche('Anomalie 50',clred);
    exit;
  end;
  if r<1 then exit;
  trains[idTrain].route:=tabloroute[r];

  formRoute.ButtonFenPil.enabled:=trains[IdTrain].route[0].adresse<>0;

  // efface une éventuelle autre route du tco et affiche la route cliquée dans le tco
  Efface_affiche_route;
end;

// transforme la liste de chaine des cantons obligatoires en détecteurs
procedure detObl_to_liste;
var i,n,j,erreur :integer;
    s : string;
begin
  // transformer la liste des cantons obligatoires en détecteurs
  for i:=1 to 20 do begin list_det_obl[i].adresse:=0;list_det_obl[i].n:=0;end;

  i:=1;
  s:=formRoute.EditObligeCanton.text;
  while (length(s)>0) and (i<20) do
  begin
    val(s,n,erreur); // n= numéro de canton
    delete(s,1,erreur);
    while not(s='') and not(s[1] in ['0'..'9']) do
    begin
      delete(s,1,1);
    end;

    if erreur=0 then s:='';
    j:=index_canton_numero(n);
    if j<>0 then
    begin
      if canton[j].typ1=det then
      begin
        list_det_obl[i].adresse:=canton[j].el1;
        inc(i);
      end;
      if canton[j].typ2=det then
      begin
        list_det_obl[i].adresse:=canton[j].el2;
        inc(i);
      end;
    end;
  end;
end;

// transforme la liste de chaine des cantons interdits en détecteurs
procedure detInt_to_liste;
var i,n,j,erreur :integer;
    s : string;
begin
  for i:=1 to 20 do begin list_det_int[i].adresse:=0;list_det_int[i].n:=0;end;

  // transformer la liste des cantons interdits en détecteurs
  i:=1;
  s:=formRoute.EditInterditCanton.text;
  while (length(s)>0) and (i<20) do
  begin
    val(s,n,erreur); // n= numéro de canton
    delete(s,1,erreur);
    while not(s='') and not(s[1] in ['0'..'9']) do
    begin
      delete(s,1,1);
    end;

    if erreur=0 then s:='';
    j:=index_canton_numero(n);
    if j<>0 then
    begin
      if canton[j].typ1=det then
      begin
        list_det_int[i].adresse:=canton[j].el1;
        //Affiche('détecteur interdit '+intToSTR(canton[j].el1),clOrange);
        inc(i);
      end;
      if canton[j].typ2=det then
      begin
        list_det_int[i].adresse:=canton[j].el2;
        //Affiche('détecteur interdit '+intToSTR(canton[j].el2),clOrange);
        inc(i);
      end;
    end;
  end;
end;

// affiche les routes du train courant
procedure maj_fenetre;
var iI,iO,l,pluslongue,n,j,k,pixelLength,np : integer;
    s,chaineLongue : string;
    trouveObl,trouveint,aflongue : boolean;
begin
  if (idcantonroute<1) or (cantonorg=0) or (cantonDest=0) then
  begin
    FormRoute.caption:='Pas de canton depart/arrivée';
    exit;
  end;
  Nprop:=0; NpropTot:=0;
  formRoute.caption:='Liste des routes trouvées du train '+canton[idcantonRoute].NomTrain+' pour aller de '+intToSTR(DetDepart)+' (canton '+intToSTR(cantonOrg)+
           ') à '+intToSTR(DetaTrouve)+' (canton '+intToSTR(cantonDest)+')';
  plusLongue:=0;

  formRoute.ButtonDetail.caption:='Détail route ';
  formRoute.ButtonEfface.caption:='Efface route ';

  if idcantonRoute<>0 then formRoute.ListBoxRoutes.Hint:='Sélectionne une route pour l''affecter au train '+canton[idcantonRoute].NomTrain;

  IdCantonClic:=Idcantonroute;
  IdTrainCourant:=canton[idcantonRoute].indexTrain;
  if idTrainCourant>9000 then
  begin
    Affiche('Anomalie 626 ',clred);
    messageBeep(Mb_iconError);
    exit;
  end;

  if NbreRoutes>0 then FormRoute.labelInfo.Caption:='Cliquer sur une route pour la visualiser sur le TCO et l''affecter au train';

  Screen.Cursor:=crSQLWait;

  // regarder chaque route pour les détecteurs obligatoires / interdits et l'afficher
  aflongue:=FormRoute.checkBoxRoutesLongues.checked;
  np:=tabloroute[1,0].adresse;

  if NbreRoutes>0 then formRoute.listBoxRoutes.Clear;

  for j:=1 to NbreRoutes do
  begin
    // compter le nombre de détecteur obligatoires et interdits
    iO:=1;
    for k:=1 to 20 do begin list_det_obl[k].n:=0;list_det_int[k].n:=0;end;
    n:=tabloroute[j,0].adresse;
    // obligatoires
    while (iO<=20) and (list_det_obl[iO].adresse<>0) do
    begin
      for k:=1 to n do
      begin
        if (tabloroute[j,k].typ=det) and (list_det_obl[iO].adresse=tabloroute[j,k].adresse) then inc(list_Det_obl[iO].n);
      end;
      inc(iO);
    end;
    // interdits
    iI:=1;
    while (iI<=20) and (list_det_int[iI].adresse<>0) do
    begin
      for k:=1 to n do
      begin
        if (tabloroute[j,k].typ=det) and (list_det_int[iI].adresse=tabloroute[j,k].adresse) then inc(list_Det_int[iI].n);
      end;
      inc(iI);
    end;

    trouveObl:=true;
    trouveInt:=false;
    // trouver si cette route j contient tous détecteurs obligatoires
    // ou des détecteurs interdits
    for k:=1 to iI-1 do
    begin
      trouveInt:=TrouveInt or (list_det_int[k].n>0);
    end;
    // obligatoires
    for k:=1 to iO-1 do
    begin
      trouveObl:=TrouveObl and (list_det_obl[k].n>0);
    end;
    if trouveObl and not trouveint then
    begin
      s:=intToSTR(j)+'. ';
      s:=s+route_restreinte_to_string(tabloroute[j]);
      l:=Length(s);
      if l>pluslongue then
      begin
        chainelongue:=s;
        pluslongue:=l;
      end;
      inc(NpropTot);
      if round(n/np)>2 then
      begin
        if afLongue then
        begin
          coulText:=clOrange;
          StyleText:=1; // gras
          FormRoute.ListBoxRoutes.Items.AddObject(s,pointer(integer(StyleText)));     //
          //FormRoute.ListBoxRoutes.Items.AddObject(s,pointer(CoulText));   //ne pas utiliser à cause des styles D12 - permet d'afficher un texte en couleurs avec l'evt onDrawItem
        end
      end
      else
      begin
        inc(Nprop);
        coulText:=clYellow;
        StyleText:=0; // normal
        FormRoute.ListBoxRoutes.Items.AddObject(s,pointer(integer(StyleText)));
        //FormRoute.ListBoxRoutes.Items.AddObject(s,pointer(CoulText));   // ne pas utiliser à cause des styles D12 - permet d'afficher un texte en couleurs avec l'evt onDrawItem
      end;
    end;
  end;
  Screen.Cursor:=crDefault;

  PixelLength:=FormRoute.ListboxRoutes.Canvas.TextWidth(chaineLongue)+30;
  // positionne une scrollbar dans la listbox - pour l'enlever, envoyer 0 dans pixelLength
  SendMessage(FormRoute.ListBoxRoutes.Handle,LB_SETHORIZONTALEXTENT,PixelLength,0);

  // icone train
  if idcantonRoute<>0 then Maj_icone_train(FormRoute.ImageTrainR,idTrainCourant,clWhite);

  formRoute.ButtonFenPil.enabled:=trains[IdTrainCourant].route[0].adresse<>0;

  if NbreRoutes=1 then clic_route(0);

  s:=intToSTR(Nprop)+' propositions - Route '+intToSTR(NumRoute)+'/'+intToSTR(NbreRoutes)+' : '+intToSTR(n)+' éléments';
  FormRoute.LabelNombre.caption:=s;

end;

procedure TFormRoute.FormActivate(Sender: TObject);
begin
  maj_fenetre;
  coulText:=clYellow;
end;

procedure TFormRoute.ListBoxRoutesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s : string;
    erreur : integer;
begin
  IndexLigneRoute:=listBoxRoutes.Itemindex;
  if IndexLigneRoute<0 then exit;
  s:=ListBoxRoutes.items[IndexLigneRoute];
  val(s,NumRoute,erreur);
  clic_route(NumRoute);
end;

procedure TFormRoute.ButtonEffaceClick(Sender: TObject);
begin
  efface_route_tco(false);
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
  if (Indexligneroute<0) or (NumRoute<1) then exit;

  with formprinc do
  begin
    windowState:=wsNormal; //Maximized;
    show;
    BringToFront;
  end;

  j:=Indexligneroute+1;
  n:=tabloroute[j,0].adresse;
  Affiche('Route '+intToSTR(j)+' ---------------n='+intToSTR(n),clwhite);
  for i:=1 to n do
  begin
    s:=intToSTR(i)+' : '+intToSTR(tabloroute[j,i].adresse)+' '+BTypeToChaine(tabloroute[j,i].typ)+' ';
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
  efface_route_tco(false);
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
var s : string;
    erreur : integer;
begin
  if (indexLigneRoute<0) or (ListBoxRoutes.Count=0) then exit;
  if (ord(Key)=VK_UP) and (Indexligneroute>0) then
  begin
    dec(IndexligneRoute);
  end;
  if (ord(Key)=VK_DOWN) and (Indexligneroute+1<ListBoxRoutes.Count) then
  begin
    inc(IndexligneRoute);
  end;
  //Affiche('9985 '+intToSTR(indexLigneROute)+'/'+intToSTR(Nprop),clWhite);
  s:=ListBoxRoutes.items[IndexLigneRoute];

  val(s,NumRoute,erreur);
  efface_affiche_route;
end;


procedure TFormRoute.FormCreate(Sender: TObject);
begin
  ButtonFenPil.hint:='Ouvre la fenêtre de pilotage des trains'+#13+'ce qui permet de lancer leur roulage';
  ButtonDetail.hint:='Affiche le détail de la route en fenêtre principale';
  EditObligeCanton.Text:='aucun';
  EditInterditCanton.Text:='aucun';
  EditObligeCanton.Hint:='Numéro de cantons séparés par des virgules (10 maxi)'+#13+'Laisser vide pour aucune obligation';
  EditInterditCanton.Hint:='Numéro de cantons séparés par des virgules (10 maxi)'+#13+'Laisser vide pour aucune interdiction';

  ListBoxRoutes.Style:=lbOwnerDrawFixed;    //pour déclencher l'evt on drawitem
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
  efface_route_tco(false);
end;

procedure TFormRoute.ButtonFenPilClick(Sender: TObject);
begin
  if idcantonRoute<1 then exit;
  indexTrainFR:=canton[idcantonRoute].indexTrain;
  with FormRouteTrain do
  begin
    TabSheetRA.Enabled:=true;
    show;
  end;
  close;
end;

procedure TFormRoute.ButtonParcours(Sender: TObject);
var i,j,n,p,det1,det2,indexAig : integer;
   s : string;
   typ : tequipement;
begin
  if (Indexligneroute<0) or (NumRoute<1) then exit;
  efface_route_tco(false);
  hide;
  j:=NumRoute;
  n:=tabloroute[j,0].adresse;
  i:=1;
  det2:=0;
  toucheTCO:=#0;
  repeat
    s:=intToSTR(tabloroute[j,i].adresse)+' '+BTypeToChaine(tabloroute[j,i].typ)+' ';
    p:=tabloRoute[j,i].pos;
    typ:=tabloRoute[j,i].typ;

    if (typ=aig) or (typ=tjd) or (typ=triple) then
    begin
      indexaig:=index_aig(ParcoursDet[i].adresse);
      aiguillage[indexAig].AncPos:=aiguillage[IndexAig].position;  // sauvegarder position
      //Affiche('Aig='+intToSTR(ParcoursDet[i].adresse)+' pos='+intToSTR(aiguillage[IndexAig].position),clYellow);
      aiguillage[indexAig].position:=ParcoursDet[i].pos;           // forcer la position de l'aiguillage sue le parcours
    end;

    if typ=det then
    begin                          // attention on ne gère que le TCO1
      Zone_TCO(indexTCOcourant,det1,det2,1,0,0,true,false);   // faire true et positionner les aiguillages
      det1:=det2;
      det2:=tabloroute[j,i].adresse;
      Zone_TCO(indexTCOcourant,det1,det2,1,0,1,false,false);
      FormTCO[1].Caption:=intToSTR(i)+'/'+intToSTR(n)+' '+intToSTR(det1)+' '+intToSTR(det2)+ '       Arrêt par touche Echap';
      //Affiche(intToSTR(det1)+' '+intToSTR(det2),clyellow);
    end;

    Application.ProcessMessages;
    Sleep(500);

    inc(i);
  until (i>n) or (toucheTCO=#27);

  // remettre les aiguillages
  for i:=2 to n do
  begin
    typ:=ParcoursDet[i].typ;
    if (typ=aig) or (typ=tjd) or (typ=triple) then
    begin
      indexaig:=index_aig(ParcoursDet[i].adresse);
      aiguillage[indexAig].Position:=aiguillage[indexAig].AncPos;  // restitue position
    end;
  end;

  Affiche_route_tco;
  titre_fenetre(1);
  Show;
  //Affiche('Fini',clred);
end;

procedure TFormRoute.ButtonRafClick(Sender: TObject);
begin
  maj_fenetre;
end;

procedure TFormRoute.EditObligeCantonChange(Sender: TObject);
begin
  detObl_to_liste;
end;

procedure TFormRoute.EditInterditCantonChange(Sender: TObject);
begin
  detInt_to_liste;
end;

procedure TFormRoute.ButtonTrouverClick(Sender: TObject);
var r,sens,sensCanton,indexTCO,IdCantonOrg : integer;
begin
  if cantonOrg=0 then exit;

  IdCantonOrg:=index_canton_numero(cantonOrg);
  //IdCantonDest:=index_canton_numero(cantonDest);
  sensCanton:=canton[IdCantonOrg].sensLoco;
  // sens de la loco dans le canton
  case sensCanton of
    sensGauche : sens:=SensTCO_O;
    sensDroit  : sens:=SensTCO_E;
    SensHaut   : sens:=SensTCO_N;
    SensBas    : sens:=SensTCO_S;
  end;
  IndexTCO:=canton[IdcantonOrg].Ntco;
  r:=prepare_route(IndexTCO,CantonOrg,DetaTrouve,sens);
  if r<>0 then
  begin
   { case r of
    1 : s:='Erreur 846: aucun des deux détecteurs du canton n''est activé';
    2 : s:='Erreur 15 : le sens de la loco du canton de départ aboutit à un buttoir';
    3 : s:='Erreur 14 : configuration canton de départ '+intToSTR(canton[cantonOrg].numero)+' sans détecteur contigu';
    end;
    ListBoxRoutes.Clear;
    ListBoxRoutes.items.AddObject(s,pointer(CoulText)); }
    exit;
 end;
  maj_fenetre;
end;

procedure TFormRoute.ListBoxRoutesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var  fs : integer;
     s : string;
begin
  //myBrush := TBrush.Create;
  with (Control as TListBox).Canvas do // draw on control canvas, not on the form
  begin
{    if Index = 3 then
      myColor := clRed
    else
      myColor := clBlack;

    myBrush.Style := bsSolid;
    myBrush.Color := myColor;

    Windows.FillRect(handle, Rect, myBrush.Handle);
    Pen.color:=clWhite;//CoulText;
    myBrush.color:=clBlue;
    Brush.Style := bsClear;
    TextOut(Rect.Left, Rect.Top, (Control as TListBox).Items[Index]);
    MyBrush.Free; }
    FillRect(Rect);   // on à cause des styles
    s:=ListBoxRoutes.Items[Index];
    fs:=integer(ListBoxRoutes.Items.Objects[Index]);
    if fs=0 then font.style:=[] else font.Style:=[fsBold];
//    Font.Color:=TColor(ListBoxRoutes.Items.Objects[Index]); ne pas changer de couleur à cause des styles
    TextOut(Rect.Left+2, Rect.Top, s);
  end;
end;

procedure TFormRoute.CheckBoxRoutesLonguesClick(Sender: TObject);
begin
  Maj_fenetre;
end;

end.
