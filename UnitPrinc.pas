Unit UnitPrinc;
(********************************************
  programme signaux complexes Graphique Lenz
  delphi 7 + activeX Tmscomm + clientSocket
 ********************************************
 note sur le pilotage des accessoires:
 raquette   octet sortie
    +            2    = aiguillage droit  = sortie 2 de l'adresse d'accessoire
    -            1    = aiguillage dévié  = sortie 1 de l'adresse d'accessoire
*)

// en mode simulation run, CDM ne renvoie pas les détecteurs au départ du RUN.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls, ShellAPI,
  ImgList, ScktComp, StrUtils, Menus, ActnList, MSCommLib_TLB , unitConfig  ;

type
  TFormPrinc = class(TForm)
    BoutVersion: TButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    LabelTitre: TLabel;
    BoutonRaf: TButton;
    ScrollBox1: TScrollBox;
    ClientSocketLenz: TClientSocket;
    GroupBox1: TGroupBox;
    EditAdresse: TEdit;
    Label2: TLabel;
    Editval: TEdit;
    Label3: TLabel;
    ButtonCommande: TButton;
    ButtonTest: TButton;
    ButtonInfo: TButton;
    MainMenu1: TMainMenu;
    Interface1: TMenuItem;
    MenuConnecterUSB: TMenuItem;
    DeconnecterUSB: TMenuItem;
    N2: TMenuItem;
    MenuConnecterEthernet: TMenuItem;
    MenuDeconnecterEthernet: TMenuItem;
    StatusBar1: TStatusBar;
    Label4: TLabel;
    MSCommUSBLenz: TMSComm;
    LabelEtat: TLabel;
    loco: TButton;
    Afficher1: TMenuItem;
    Etatdesdtecteurs1: TMenuItem;
    Etatdesaiguillages1: TMenuItem;
    N3: TMenuItem;
    Codificationdesaiguillages1: TMenuItem;
    Image9feux: TImage;
    Image7feux: TImage;
    Image5feux: TImage;
    Image4feux: TImage;
    Image3feux: TImage;
    Image2feux: TImage;
    ButtonAffDebug: TButton;
    N4: TMenuItem;
    ConnecterCDMrail: TMenuItem;
    DeconnecterCDMRail: TMenuItem;
    Image2Dir: TImage;
    Image3Dir: TImage;
    Image4Dir: TImage;
    Image5Dir: TImage;
    Image6Dir: TImage;
    Codificationdesfeux1: TMenuItem;
    Divers1: TMenuItem;
    Versions1: TMenuItem;
    ChronoDetect: TMenuItem;
    ClientSocketCDM: TClientSocket;
    FichierSimu: TMenuItem;
    ButtonEcrCV: TButton;
    ButtonReprise: TButton;
    OpenDialog: TOpenDialog;
    N1: TMenuItem;
    LireunfichierdeCV1: TMenuItem;
    SaveDialog: TSaveDialog;
    N5: TMenuItem;
    Quitter1: TMenuItem;
    Button2: TButton;
    Config: TMenuItem;
    Label1: TLabel;
    LabelNbTrains: TLabel;
    ButtonLitCV: TButton;
    Codificationdesactionneurs1: TMenuItem;
    ButtonArretSimu: TButton;
    OuvrirunfichiertramesCDM1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MSCommUSBLenzComm(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure BoutVersionClick(Sender: TObject);
    procedure ButtonCommandeClick(Sender: TObject);
    procedure EditvalEnter(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BoutonRafClick(Sender: TObject);
    procedure ClientSocketLenzError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketLenzRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ButtonTestClick(Sender: TObject);
    procedure ButtonInfoClick(Sender: TObject);
    procedure MenuConnecterUSBClick(Sender: TObject);
    procedure DeconnecterUSBClick(Sender: TObject);
    procedure MenuConnecterEthernetClick(Sender: TObject);
    procedure MenuDeconnecterEthernetClick(Sender: TObject);
    procedure locoClick(Sender: TObject);
    procedure AffEtatDetecteurs(Sender: TObject);
    procedure Etatdesaiguillages1Click(Sender: TObject);
    procedure Codificationdesaiguillages1Click(Sender: TObject);
    procedure ClientSocketCDMError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ClientSocketLenzConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCDMConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCDMRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ButtonAffDebugClick(Sender: TObject);
    procedure ConnecterCDMrailClick(Sender: TObject);
    procedure DeconnecterCDMRailClick(Sender: TObject);
    procedure ClientSocketCDMDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Codificationdesfeux1Click(Sender: TObject);
    procedure Versions1Click(Sender: TObject);
    procedure ClientSocketLenzDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ChronoDetectClick(Sender: TObject);
    procedure FichierSimuClick(Sender: TObject);
    procedure ButtonEcrCVClick(Sender: TObject);
    procedure ButtonRepriseClick(Sender: TObject);
    procedure LireunfichierdeCV1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure ConfigClick(Sender: TObject);
    procedure ButtonLitCVClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Codificationdesactionneurs1Click(Sender: TObject);
    procedure ButtonArretSimuClick(Sender: TObject);
    procedure OuvrirunfichiertramesCDM1Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure DoHint(Sender : Tobject);
  public
    { Déclarations publiques }
    Procedure ImageOnClick(Sender : TObject);
    procedure proc_checkBoxFB(Sender : Tobject);
  end;


const
titre='Signaux complexes GL ';
tempoFeu = 100;
MaxAcc = 2048;
LargImg=50;HtImg=91;
const_droit=2;const_devie=1;  // positions aiguillages transmises par la centrale LENZ
const_devieG_CDM=3;  // positions aiguillages transmises par cdm
const_devieD_CDM=2;  // positions aiguillages transmises par cdm
const_droit_CDM=0;  // positions aiguillages transmises par cdm

EtatSign : array[0..13] of string[20] =('carré','sémaphore','sémaphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');

type TBranche = record
               BType : integer ;   // 1= détecteur  2= aiguillage 3=bis 4=Buttoir
               Adresse : integer ; // adresse du détecteur ou de l'aiguillage
            end;

     Taiguillage = record
                 objet  : integer;          // objet dans CDM rail
                 modele : integer;          // 0=n'existe pas  1=aiguillage 2=TJD 3=TJS 4=aiguillage triple
                 position,                  // position actuelle : 1=dévié  2=droit
                 Adrtriple,                 // 2eme adresse pour un aiguillage triple
                 temps,                     // temps de pilotage (durée de l'impulsion en x 100 ms)
                 inversion : integer;       // pilotage inversé pour la commande (en mode sans CDM) 0=normal 1=inversé
                 InversionCDM : integer ;   // inversion pour les aiguillages BIS en lecture (pour parer bug CDM)
                 vitesse : integer;         // vitesse de franchissement de l"aiguillage en position déviée (60 ou 90)

                 ADroit : integer ;         // (identifiant extérieur à la TJD) connecté sur la position droite en talon
                 ADroitB : char ;           // id de branche pour TJD
                 ADroitBis : integer ;      // 0=pas connecté à aiguillage dont l'adresse est bis  =1 connecté à un aig bis

                 ADevie : integer ;         // (identifiant extérieur) adresse de l'élément connecté en position déviée
                 ADevieB : char;            // caractère (D ou S)si aiguillage de l'élément connecté en position déviée
                 AdevieBis : integer ;      // 0=pas connecté à aiguillage dont l'adresse est bis  =1 connecté à un aig bis

                 APointe : integer;         // adresse de l'élément connecté en position droite ; pour les TJD : adresse de l'autre tjd
                 APointeB : char;
                 ApointeBis : integer;      // 0=pas connecté à aiguillage dont l'adresse est bis  =1 connecté à un aig bis

                 tjsint   : integer;
                 tjsintb  : char ;

                  // éléments connectés sur la branche déviée 2 (cas d'un aiguillage triple)
                 Adevie2 : integer;
                 Adevie2B : char ;
                 Adevie2Bis : integer;

                end;

Taccessoire     = (aig,feu);
TMA             = (valide,devalide);


var ancien_tablo_signalCplx,EtatsignalCplx : array[0..MaxAcc] of word;
    AvecInitAiguillages,tempsCli,combine,NbreFeux,pasreponse,AdrDevie,
    NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
    Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,NbrePN : integer;
    
    Hors_tension2,traceSign,TraceZone,Ferme,parSocket,ackCdm,PremierFD,
    NackCDM,MsgSim,succes,recu_cv,AffActionneur,AffAigDet,
    TraceListe,clignotant,nack,Maj_feux_cours,configNulle : boolean;

    branche : array [1..100] of string;

const
  ClBleuClair=$FF7070 ;
  Cyan=$FFA0A0;
  clviolet=$FF00FF;
  GrisF=$414141;
  clOrange=$0077FF;
  Feu_X=50;Feu_Y=91;
  Max_Simule=10000;
  NbCouleurTrain=8;
  couleurTrain : array[1..NbCouleurTrain] of Tcolor = (clYellow,clLime,clOrange,clAqua,clFuchsia,clLtGray,clred,clWhite);

var
  FormPrinc: TFormPrinc;
  ack,portCommOuvert,trace,AffMem,AfficheDet,CDM_connecte,parSocketCDM,
  DebugOuv,Raz_Acc_signaux,AvecInit,AvecTCO,terminal : boolean;
  tablo : array of byte;  // tableau rx usb
  Enregistrement,chaine_Envoi,chaine_recue,Id_CDM,Af,
  entete,suffixe,ConfStCom : string;
  maxaiguillage,detecteur_chgt,Temps,TpsRecuCom,Tempo_init,Suivant,TypeGen,
  NbreImagePligne,NbreBranches,Index2_det,branche_det,Index_det,
  I_simule,maxTablo_act,NbreVoies,AdresseFeuSuivant,El_suivant : integer;
  Ancien_detecteur,detecteur : array[0..1024] of boolean;  // anciens état des détecteurs et adresses des détecteurs et leur état
  Adresse_detecteur : array[0..60] of integer; // adresses des détecteurs par index
  mem : array[0..1024] of boolean ; // mémoire des états des détecteurs
  MemZone : array[0..1024,0..1024] of boolean ; // mémoires de zones
  (* Train : array[1..30] of record
             index : integer ; // nombre de routes pour ce train
             route : array[1..2000] of record
             Mem1,Mem2 : integer;
           end;
          end;
    *)
  Tablo_actionneur : array[1..100] of
  record
    actionneur,etat,fonction,tempo : integer;
    train : string;
  end;

  Tablo_PN : array[1..20] of
  record
    AdresseFerme  : integer;  // adresse de pilotage DCC pour la fermeture
    commandeFerme : integer;  // commande de fermeture (1 ou 2)
    AdresseOuvre  : integer;  // adresse de pilotage DCC pour l'ouverture
    commandeOuvre : integer;  // commande d'ouverture (1 ou 2)
    NbVoies       : integer;  // Nombre de voies du PN
    Voie : array [1..10] of record
             ActFerme,ActOuvre : integer ; // actionneurs provoquant la fermeture et  l'ouverture
             PresTrain : boolean; // mémoire de présence de train sur la voie
           end;
  end;

  Tablo_Simule : array[0..Max_Simule] of
    record
      tick : longint;
      Detecteur,Aiguillage,etat : integer ;
    end;
  Route : array[1..2000] of record
     Mem1,Mem2 : integer;
     end;  
  TempoAct,RangActCours,N_Cv,index_simule,NDetecteurs,N_Trains,N_routes : integer;
  tablo_CV : array [1..255] of integer;
  couleur : Tcolor;
  fichier : text;
  recuCDML : array of string;
  tick,Premier_tick : longint;

  // l'indice du tableau aiguillage est son adresse
  aiguillage : array[0..MaxAcc] of Taiguillage;
  aiguillageB : array[0..MaxAcc] of Taiguillage;


  // signaux
  feux : array[1..MaxAcc] of record
                 adresse, aspect : integer; // adresse du feu, aspect (2 feux..9 feux 12=direction 2 feux .. 16=direction 6 feux)
                 Img : TImage;              // Pointeur sur structure TImage du feu
                 Lbl : TLabel;              // pointeur sur structure Tlabel du feu
                 check : TCheckBox;         // pointeur sur structure Checkbox avec feu blanc
                 FeuBlanc : boolean ;       // avec checkbox ou pas
                 decodeur : integer;        // type du décodeur
                 Adr_det1 : integer;        // adresse du détecteur1 sur lequel il est implanté
                 Adr_det2 : integer;        // adresse du détecteur2 sur lequel il est implanté (si un signal est pour plusieurs voies)
                 Adr_det3 : integer;        // adresse du détecteur3 sur lequel il est implanté (si un signal est pour plusieurs voies)
                 Adr_det4 : integer;        // adresse du détecteur4 sur lequel il est implanté (si un signal est pour plusieurs voies)
                 Adr_el_suiv1 : integer;     // adresse de l'élément1 suivant
                 Adr_el_suiv2 : integer;     // adresse de l'élément2 suivant (si un signal est pour plusieurs voies)
                 Adr_el_suiv3 : integer;     // adresse de l'élément3 suivant (si un signal est pour plusieurs voies)
                 Adr_el_suiv4 : integer;     // adresse de l'élément4 suivant (si un signal est pour plusieurs voies)
                 Btype_suiv1 : integer ;     // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv2 : integer ;     // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv3 : integer ;     // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv4 : integer ;     // type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 VerrouCarre : boolean ;    // si vrai, le feu se verrouille au carré si pas de train avant le signal
                 EtatSignal  : word  ;      // comme EtatSignalCplx
                 UniSemaf : integer ;        // définition supplémentaire de la cible pour les décodeurs UNISEMAF
                 AigDirection : array[1..6] of array of record  // pour les signaux directionnels : contient la liste des aiguillages associés
                                               Adresse : integer;     // 6 feux max associés à un tableau dynamique décrivant les aiguillages
                                               posAig  : char;
                                               end;
                end;
  Fimage : Timage;

  BrancheN : array[1..100,1..200] of TBranche;

{$R *.dfm}

// utilisation dans unité UnitPilote et configunit
function Index_feu(adresse : integer) : integer;
procedure dessine_feu2(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_feu3(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_feu4(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_feu5(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_feu7(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_feu9(Acanvas : Tcanvas;x,y : integer;frX,frY : real;etatsignal : word;orientation : integer);
procedure dessine_dir2(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_dir3(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_dir4(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_dir5(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_dir6(Acanvas : Tcanvas;EtatSignal : word);
procedure Maj_Etat_Signal(adresse,aspect : integer);
procedure Affiche(s : string;lacouleur : TColor);
procedure envoi_signal(Adr : integer);
procedure pilote_direction(Adr,nbre : integer);
procedure connecte_USB;
procedure deconnecte_usb;
function IsWow64Process: Boolean;
procedure Dessine_feu_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : real;adresse : integer;orientation : integer);

implementation

uses UnitDebug, verif_version, UnitPilote, UnitSimule, UnitTCO;

procedure menu_interface(MA : TMA);
var val : boolean;
begin
  val:=MA=valide;
  with formprinc do
  begin
    MenuConnecterUSB.enabled:=val;
    DeConnecterUSB.enabled:=val;
    MenuConnecterEthernet.enabled:=val;
    MenuDeConnecterEthernet.enabled:=val;
  end;  
end;

procedure Tformprinc.DoHint(Sender : Tobject);
begin
  StatusBar1.Simpletext:=Application.Hint;
end;

// conversion du motif de bits de la configuration du signal complexe en deux mots:
// premier mot : (retour de la fonction=(premiers bits)code de la signalisation
// deuxième mot: variable Combine = code de la signalisation combinée
// Exemple code_to_aspect(10001000000000)  renvoie jaune et Combine=rappel_30
function code_to_aspect(codebin : word) : word;
var i,mot,premierbit : word;
begin
  mot:=codebin;
  i:=0;premierbit:=0;Combine:=0;

  while (i<15) do
  begin
    if (mot and 1)=1 then  // si bit 0 du mot est à 1
    begin
       if (premierbit=0) then premierbit:=i else Combine:=i;
    end;
    mot:=mot shr 1; //décaler à droite
    inc(i);
  end;
  code_to_aspect:=premierbit;
end;

// dessine un cercle plein dans le feu
procedure cercle(ACanvas : Tcanvas;x,y,rayon : integer;couleur : Tcolor);
begin
  with Acanvas do
  begin
    brush.Color:=couleur;
    Pen.Color:=clBlack;
    Ellipse(x-rayon,y-rayon,x+rayon,y+rayon);
  end;
  //Affiche(IntToSTR(y),clyellow);
end;

// dessine les feux sur une cible à 2 feux
procedure dessine_feu2(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,code,rayon,xViolet,YViolet,xBlanc,yBlanc,
    LgImage,HtImage : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  rayon:=round(6*frX);

  LgImage:=Formprinc.Image2feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image2feux.Picture.Bitmap.Height;
  
  XBlanc:=13;  YBlanc:=11;
  xViolet:=13; yViolet:=23;

  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=HtImage-yViolet;YViolet:=XViolet;XViolet:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
  end;
 
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=LgImage-XBlanc;Xblanc:=Yblanc;Yblanc:=Temp;
    Temp:=LgImage-Xviolet;Xviolet:=Yviolet;Yviolet:=Temp;
  end;
 
  XBlanc:=round(xBlanc*Frx)+x;   YBlanc:=round(Yblanc*Fry)+Y;
  XViolet:=round(XViolet*FrX)+x; YViolet:=round(YViolet*FrY)+Y;
         
  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
  cercle(ACanvas,xViolet,yViolet,rayon,GrisF);

  // allumages
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clWhite);
  if code=violet then cercle(ACanvas,xViolet,yViolet,rayon,clviolet);
end;

// dessine les feux sur une cible à 3 feux
procedure dessine_feu3(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var  Temp,code,rayon,xSem,Ysem,xJaune,Yjaune,Xvert,Yvert,
    LgImage,HtImage : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  rayon:=round(6*frX);

  LgImage:=Formprinc.Image3feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image3feux.Picture.Bitmap.Height;
  
  Xvert:=13;  Yvert:=11;
  xSem:=13;   ySem:=22;
  xJaune:=13; yJaune:=33;

  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;
 
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
  end;
 
  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
 
  // extinctions
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
  if not((code=vert_cli)  and clignotant) then cercle(ACanvas,xVert,yVert,rayon,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,xJaune,yJaune,rayon,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clRed);
end;

// dessine les feux sur une cible à 4 feux
// orientation=1 vertical 
procedure dessine_feu4(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,code,rayon,xSem,Ysem,xJaune,Yjaune,Xcarre,Ycarre,Xvert,Yvert,
    LgImage,HtImage : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  rayon:=round(6*frX);

  LgImage:=Formprinc.Image4feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image4feux.Picture.Bitmap.Height;
  
  Xcarre:=13; ycarre:=11;
  Xvert:=13;  Yvert:=22;
  xSem:=13;   ySem:=33;
  xJaune:=13; yJaune:=44;

  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;
 
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
  end;
 
  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
  Xcarre:=round(Xcarre*FrX)+x;  Ycarre:=round(Ycarre*FrY)+Y;
 
  //extinctions
  cercle(ACanvas,Xcarre,yCarre,rayon,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,Xsem,Ysem,rayon,GrisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,Xvert,yvert,rayon,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,Xjaune,YJaune,rayon,GrisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,Xjaune,yJaune,rayon,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clRed);
  if code=carre then
  begin
    cercle(ACanvas,xSem,Ysem,rayon,clRed);
    cercle(ACanvas,xCarre,yCarre,rayon,clRed);
  end;
end;

// dessine les feux sur une cible à 5 feux
procedure dessine_feu5(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var code, XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,
    Temp,rayon,LgImage,HtImage : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  rayon:=round(6*frX);
  XBlanc:=13; YBlanc:=22;
  xJaune:=13; yJaune:=55;
  Xcarre:=13; Ycarre:=11;
  XSem:=13;   Ysem:=44;
  XVert:=13;  YVert:=33;

  LgImage:=Formprinc.Image5feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image5feux.Picture.Bitmap.Height;
    
  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;
  
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;
  end;

  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xblanc:=round(XBlanc*FrX)+x;  YBlanc:=round(YBlanc*FrY)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
  Xcarre:=round(Xcarre*FrX)+x;  Ycarre:=round(Ycarre*FrY)+Y;

  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
  cercle(ACanvas,xcarre,ycarre,rayon,GrisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,xvert,yvert,rayon,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xjaune,yjaune,rayon,GrisF);

  //allumages
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xsem,ysem,rayon,clRed);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xblanc,yblanc,rayon,clWhite);
  if code=carre then
  begin
    cercle(ACanvas,xcarre,ycarre,rayon,clRed);
    cercle(ACanvas,xsem,ysem,rayon,clRed);
  end;
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xvert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(ACanvas,xJaune,yjaune,rayon,clorange);
end;


// dessine les feux sur une cible à 7 feux
procedure dessine_feu7(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var code, XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Temp,rayon,LgImage,HtImage : integer;
begin
  code:=code_to_aspect(Etatsignal); // et combine
  rayon:=round(6*frX);
  XBlanc:=13; YBlanc:=23;
  Xral1:=13;  YRal1:=11;
  Xral2:=37;  YRal2:=11;
  xJaune:=13; yJaune:=66;
  Xcarre:=13; Ycarre:=35;
  XSem:=13;   Ysem:=56;
  XVert:=13;  YVert:=45;

  LgImage:=Formprinc.Image7feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image7feux.Picture.Bitmap.Height;
    
  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
    Temp:=HtImage-yRal1;YRal1:=XRal1;XRal1:=Temp;
    Temp:=HtImage-yRal2;YRal2:=XRal2;XRal2:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;
  
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;
    Temp:=LgImage-Xral1;Xral1:=Yral1;Yral1:=Temp;
    Temp:=LgImage-Xral2;Xral2:=Yral2;Yral2:=Temp; 
  end;

  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xblanc:=round(XBlanc*FrX)+x;  YBlanc:=round(YBlanc*FrY)+Y;
  XRal1:=round(XRal1*FrX)+x;    YRal1:=round(YRal1*FrY)+Y;
  XRal2:=round(XRal2*FrX)+x;    YRal2:=round(YRal2*FrY)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
  Xcarre:=round(Xcarre*FrX)+x;  Ycarre:=round(Ycarre*FrY)+Y;

  // effacements
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,grisF);
  if not((code=ral_60) and clignotant) or not((combine=ral_60) and clignotant) then
  begin
    cercle(ACanvas,Xral1,Yral1,rayon,grisF);cercle(ACanvas,Xral2,Yral2,rayon,GrisF);
  end;
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,xVert,yVert,rayon,GrisF);
  cercle(ACanvas,xcarre,yCarre,rayon,GrisF);cercle(ACanvas,xSem,ySem,rayon,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);

  // Allumages
  if (code=ral_30) or (combine=ral_30) or ((code=ral_60) or (combine=ral_60)) and clignotant then
  begin
    cercle(ACanvas,xRal1,yRal1,rayon,clOrange);cercle(ACanvas,xRal2,yRal2,Rayon,clOrange);
  end;
  if (code=jaune) or ((code=jaune_cli) and clignotant) then cercle(Acanvas,xjaune,yjaune,rayon,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xsem,ysem,rayon,clRed);
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clWhite);
  if code=carre then
  begin
    cercle(ACanvas,xCarre,yCarre,rayon,clRed);
    cercle(ACanvas,xSem,ySem,rayon,clRed);
  end;
end;

// dessine les feux sur une cible à 9 feux
procedure dessine_feu9(Acanvas : Tcanvas;x,y : integer;frX,frY : real;etatsignal : word;orientation : integer);
var code,rayon, 
    XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Xrap1,Yrap1,Xrap2,Yrap2,Temp          : integer;
    LgImage,HtImage,xt,yt : integer;
begin
  rayon:=round(6*frX);
  code:=code_to_aspect(Etatsignal); // et aspect
  // mise à l'échelle des coordonnées des feux en fonction du facteur de réduction frX et frY et x et y (offsets)

  XBlanc:=13; YBlanc:=36;
  Xral1:=13;  YRal1:=24;
  Xral2:=37;  YRal2:=24;
  xJaune:=13; yJaune:=80;
  xRap1:=37;  yRap1:=12;
  xrap2:=37;  yRap2:=37;
  Xcarre:=13; Ycarre:=47;
  XSem:=13;   Ysem:=69;
  XVert:=13;  YVert:=58;

  LgImage:=Formprinc.Image9feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image9feux.Picture.Bitmap.Height;
    
  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
    Temp:=HtImage-yRal1;YRal1:=XRal1;XRal1:=Temp;
    Temp:=HtImage-yRal2;YRal2:=XRal2;XRal2:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
    Temp:=HtImage-yRap1;YRap1:=XRap1;XRap1:=Temp;
    Temp:=HtImage-yRap2;YRap2:=XRap2;XRap2:=Temp;
  end;
  
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    frX:=2*LargeurCell/HtImage;
    frY:=HauteurCell/LgImage;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;
    Temp:=LgImage-Xral1;Xral1:=Yral1;Yral1:=Temp;
    Temp:=LgImage-Xral2;Xral2:=Yral2;Yral2:=Temp;
    Temp:=LgImage-Xrap1;Xrap1:=Yrap1;Yrap1:=Temp;
    Temp:=LgImage-Xrap2;Xrap2:=Yrap2;Yrap2:=Temp;   
  end;

  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xblanc:=round(XBlanc*FrX)+x;  YBlanc:=round(YBlanc*FrY)+Y;
  XRal1:=round(XRal1*FrX)+x;    YRal1:=round(YRal1*FrY)+Y;
  XRal2:=round(XRal2*FrX)+x;    YRal2:=round(YRal2*FrY)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
  Xcarre:=round(Xcarre*FrX)+x;  Ycarre:=round(Ycarre*FrY)+Y;
  XRap1:=round(XRap1*FrX)+x;    YRap1:=round(YRap1*FrY)+Y;
  XRap2:=round(XRap2*FrX)+x;    YRap2:=round(YRap2*FrY)+Y;

  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,Rayon,grisF);
  if not((code=ral_60) and clignotant) or not((combine=ral_60) and clignotant) then
  begin
    cercle(ACanvas,Xral1,Yral1,rayon,grisF);cercle(ACanvas,xRal2,yRal2,rayon,grisF);
  end;
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,grisF);
  if not((code=rappel_60) and clignotant) or not((combine=rappel_60) and clignotant) then
  begin
    cercle(ACanvas,xrap1,yrap1,rayon,grisF);cercle(ACanvas,xrap2,yrap2,rayon,grisF);
  end;
  cercle(ACanvas,xcarre,Ycarre,rayon,grisF); // carré supérieur
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,grisF);
  if not((code=vert_cli) and clignotant) then  cercle(ACanvas,xvert,yvert,rayon,grisF);

  // allumages
  if ((code=ral_60) and clignotant) or (code=ral_30) or
     ((combine=ral_60) and clignotant) or (combine=ral_30) then
  begin
    cercle(ACanvas,Xral1,yRal1,rayon,clOrange);cercle(ACanvas,xral2,yral2,rayon,clOrange);
  end;

  if ((code=rappel_60) and clignotant) or (code=rappel_30) or
     ((combine=rappel_60) and clignotant) or (combine=rappel_30) then
  begin
    cercle(ACanvas,xrap1,yrap1,rayon,clOrange);cercle(ACanvas,xrap2,yrap2,rayon,clOrange);
  end;
  if ((code=jaune_cli) and clignotant) or (code=jaune) then cercle(Acanvas,xjaune,yjaune,rayon,clOrange);
  if ((code=semaphore_cli) and clignotant) or (code=semaphore) then cercle(ACanvas,Xsem,ySem,rayon,clRed);
  if ((code=vert_cli) and clignotant) or (code=vert) then cercle(ACanvas,xvert,yvert,rayon,clGreen);
  if ((code=blanc_cli) and clignotant) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clWhite);

  if code=carre then
  begin
    cercle(ACanvas,xcarre,yCarre,rayon,clRed);
    cercle(ACanvas,xsem,ysem,rayon,clRed);
  end;
end;



// dessine les feux sur une cible directionnelle à 2 feux
procedure dessine_dir3(Acanvas : Tcanvas;EtatSignal : word);
begin
  if EtatSignal=0 then
  begin
    cercle(ACanvas,11,13,6,GrisF);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,GrisF);
  end;
  if EtatSignal=1 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,grisF);
  end;
  if EtatSignal=2 then
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,grisF);
  end;
  if EtatSignal=3 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
  end;
end;

// dessine les feux sur une cible directionnelle à 4 feux
procedure dessine_dir4(Acanvas : Tcanvas;EtatSignal : word);
begin
  if EtatSignal=0 then 
  begin
    cercle(ACanvas,11,13,6,GrisF);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,GrisF);
    cercle(ACanvas,43,13,6,GrisF);
  end;
  if EtatSignal=1 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,grisF);
    cercle(ACanvas,43,13,6,GrisF);
  end;
  if EtatSignal=2 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,grisF);
    cercle(ACanvas,43,13,6,GrisF);
  end;
  if EtatSignal=3 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,GrisF);
  end;
  if EtatSignal=4 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
  end;
  if EtatSignal=5 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
    cercle(ACanvas,53,13,6,clWhite);
  end;
end;

procedure dessine_dir5(Acanvas : Tcanvas;EtatSignal : word);
begin
  if EtatSignal=0 then 
  begin
    cercle(ACanvas,11,13,6,GrisF);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,GrisF);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
  end;
  if EtatSignal=1 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,grisF);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
  end;
  if EtatSignal=2 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,grisF);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
  end;
  if EtatSignal=3 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
  end;
  if EtatSignal=4 then
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
    cercle(ACanvas,53,13,6,GrisF);
  end;
  if EtatSignal=5 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
    cercle(ACanvas,53,13,6,clWhite);
  end;
end;

procedure dessine_dir6(Acanvas : Tcanvas;EtatSignal : word);
begin
  if EtatSignal=0 then
  begin
    cercle(ACanvas,11,13,6,GrisF);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,GrisF);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
    cercle(ACanvas,63,13,6,GrisF);
  end;
  if EtatSignal=1 then
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,GrisF);
    cercle(ACanvas,33,13,6,grisF);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
    cercle(ACanvas,63,13,6,GrisF);
  end;
  if EtatSignal=2 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,grisF);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
    cercle(ACanvas,63,13,6,GrisF);
  end;
  if EtatSignal=3 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,GrisF);
    cercle(ACanvas,53,13,6,GrisF);
    cercle(ACanvas,63,13,6,GrisF);
  end;
  if EtatSignal=4 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
    cercle(ACanvas,53,13,6,GrisF);
    cercle(ACanvas,63,13,6,GrisF);
  end;
  if EtatSignal=5 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
    cercle(ACanvas,53,13,6,clWhite);
    cercle(ACanvas,63,13,6,GrisF);
  end;
  if EtatSignal=6 then 
  begin
    cercle(ACanvas,11,13,6,clWhite);
    cercle(ACanvas,22,13,6,clWhite);
    cercle(ACanvas,33,13,6,clWhite);
    cercle(ACanvas,43,13,6,clWhite);
    cercle(ACanvas,53,13,6,clWhite);
    cercle(ACanvas,63,13,6,clWhite);
  end;
end;


// dessine les feux sur une cible directionnelle à 2 feux
procedure dessine_dir2(Acanvas : Tcanvas;EtatSignal : word);
begin
  if EtatSignal=0 then 
  begin
    cercle(ACanvas,12,13,6,GrisF);
    cercle(ACanvas,25,13,6,GrisF);
  end;
  if EtatSignal=1 then 
  begin
    cercle(ACanvas,12,13,6,clWhite);
    cercle(ACanvas,25,13,6,GrisF);
  end;
  if EtatSignal=2 then 
  begin
    cercle(ACanvas,12,13,6,clWhite);
    cercle(ACanvas,25,13,6,clWhite);
  end;

end;


// affiche un texte dans la fenêtre
procedure Affiche(s : string;lacouleur : TColor);
begin
  couleur:=lacouleur;
  with formprinc.ListBox1 do
  begin
     Items.addObject(s,pointer(lacouleur));
     TopIndex:= Items.Count - 1;
  end;
end;




// renvoie l'index du feu dans le tableau feux[] en fonction de son adresse
//si pas de feu renvoie 0
function Index_feu(adresse : integer) : integer;
var i : integer;
    trouve : boolean;
begin
i:=1;
  repeat
    trouve:=feux[i].adresse=adresse;
    if not(trouve) then inc(i);
  until (trouve) or (i>=100);
  if trouve then Index_feu:=i else Index_feu:=0 ;
end;

// dessine l'aspect du feu en fonction de son adresse dans la partie droite de droite
procedure Dessine_feu_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : real;adresse : integer;orientation : integer);
var i : integer;
begin
  i:=Index_feu(adresse);
  if i<>0 then
  case feux[i].aspect of
  // feux de signalisation
   2 : dessine_feu2(CanvasDest,x,y,frx,fry,EtatSignalCplx[adresse],orientation);
   3 : dessine_feu3(CanvasDest,x,y,frx,fry,EtatSignalCplx[adresse],orientation);
   4 : dessine_feu4(CanvasDest,x,y,frx,fry,EtatSignalCplx[adresse],orientation);
   5 : dessine_feu5(CanvasDest,x,y,frx,fry,EtatSignalCplx[adresse],orientation);
   7 : dessine_feu7(CanvasDest,x,y,frx,fry,EtatSignalCplx[adresse],orientation);
   9 : dessine_feu9(CanvasDest,x,y,frx,fry,EtatSignalCplx[adresse],orientation);
  // indicateurs de direction
  12 : dessine_dir2(CanvasDest,EtatSignalCplx[adresse]);
  13 : dessine_dir3(CanvasDest,EtatSignalCplx[adresse]);
  14 : dessine_dir4(CanvasDest,EtatSignalCplx[adresse]);
  15 : dessine_dir5(CanvasDest,EtatSignalCplx[adresse]);
  16 : dessine_dir6(CanvasDest,EtatSignalCplx[adresse]);
  end;
end;

// dessine l'aspect du feu en fonction de son adresse dans la partie droite de droite
procedure Dessine_feuxx(adresse : integer);
var i : integer;
begin
  i:=Index_feu(adresse);
  if i<>0 then
  case feux[i].aspect of
  // feux de signalisation
   2 : dessine_feu2(Feux[i].Img.Canvas,0,0,1,1,EtatSignalCplx[adresse],1);
   3 : dessine_feu3(Feux[i].Img.Canvas,0,0,1,1,EtatSignalCplx[adresse],1);
   4 : dessine_feu4(Feux[i].Img.Canvas,0,0,1,1,EtatSignalCplx[adresse],1);
   5 : dessine_feu5(Feux[i].Img.Canvas,0,0,1,1,EtatSignalCplx[adresse],1);
   7 : dessine_feu7(Feux[i].Img.Canvas,0,0,1,1,EtatSignalCplx[adresse],1);
   9 : dessine_feu9(Feux[i].Img.Canvas,0,0,1,1,EtatSignalCplx[adresse],1);
  // indicateurs de direction
  12 : dessine_dir2(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  13 : dessine_dir3(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  14 : dessine_dir4(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  15 : dessine_dir5(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  16 : dessine_dir6(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  end;
end;

Procedure TFormprinc.ImageOnClick(Sender : Tobject);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;

begin
  P_image_pilote:=Sender as TImage;  // récupérer l'objet image de la forme pilote
  s:=P_Image_pilote.Hint;
  //Affiche(s,clyellow);
  i:=pos('@',s);  if i<>0 then delete(s,i,1);
  i:=pos('=',s);  if i<>0 then delete(s,i,1);
  i:=pos(' ',s);
  if i<>0 then s:=copy(s,1,i-1);
  val(s,AdrPilote,erreur);
  i:=Index_feu(AdrPilote);
  
  with Formpilote do
  begin
    TFormPilote.Create(Self);
    show;
  
    ImagePilote.top:=40;ImagePilote.left:=220;
    ImagePilote.Parent:=FormPilote;
    ImagePilote.Picture.Bitmap.TransparentMode:=tmAuto; 
    ImagePilote.Picture.Bitmap.TransparentColor:=clblue;
    ImagePilote.Transparent:=true;
    ImagePilote.Picture.BitMap:=Feux[i].Img.Picture.Bitmap;
    LabelTitrePilote.Caption:='Pilotage du signal '+intToSTR(AdrPilote);
    EtatSignalCplx[0]:=EtatSignalCplx[AdrPilote];
    if feux[i].aspect>10 then
    begin
      GroupBox1.Visible:=false;
      GroupBox2.Visible:=false;
      LabelNbFeux.Visible:=true;
      EditNbreFeux.Visible:=true;
      EditNbreFeux.Text:='1';
    end
    else
    begin
      LabelNbFeux.Visible:=False;
      EditNbreFeux.Visible:=false;
      GroupBox1.Visible:=true;
      GroupBox2.Visible:=true;
    end;
  end;
end;

// créée une image dynamiquement pour un nouveau feu déclaré dans le fichier de config
procedure cree_image(rang : integer);
var TypeFeu : integer;
    s : string;
const espY = 15;//40; // espacement Y entre deux lignes de feux
begin
  TypeFeu:=feux[rang].aspect;
  Feux[rang].Img:=Timage.create(Formprinc.ScrollBox1);
  with Feux[rang].Img do
  begin
    Parent:=Formprinc.ScrollBox1;   // dire que l'image est dans la scrollBox1
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // détermine les dimensions
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    //Left:=10+(LargImg+10)*((rang-1) mod (NbreImagePLigne));
    s:='@='+inttostr(feux[rang].Adresse)+' Decodeur='+intToSTR(feux[rang].Decodeur)+' Adresse détecteur associé='+intToSTR(feux[rang].Adr_det1)+
       ' Adresse élement suivant='+intToSTR(feux[rang].Adr_el_suiv1);
    if feux[rang].Btype_suiv1=2 then s:=s+' (aig)';
    if feux[rang].Btype_suiv1=5 then s:=s+' (aig bis)';
    Hint:=s;
    onClick:=Formprinc.Imageonclick;
    //width:=100;
    //Height:=100;
    Picture.Bitmap.TransparentMode:=tmAuto; 
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;
    
    case TypeFeu of   // charger le bit map depuis le fichier
    2 : picture.bitmap:=Formprinc.Image2feux.picture.Bitmap;
    3 : picture.bitmap:=Formprinc.Image3feux.picture.Bitmap;
    4 : picture.bitmap:=Formprinc.Image4feux.picture.Bitmap;
    5 : picture.bitmap:=Formprinc.Image5feux.picture.Bitmap;
    7 : picture.bitmap:=Formprinc.Image7feux.picture.Bitmap;
    9 : picture.bitmap:=Formprinc.Image9feux.picture.Bitmap;
   
    12 : picture.bitmap:=Formprinc.Image2Dir.picture.Bitmap;
    13 : picture.bitmap:=Formprinc.Image3Dir.picture.Bitmap;
    14 : picture.bitmap:=Formprinc.Image4Dir.picture.Bitmap;
    15 : picture.bitmap:=Formprinc.Image5Dir.picture.Bitmap;
    16 : picture.bitmap:=Formprinc.Image6Dir.picture.Bitmap;
    end;
    
    // mettre rouge par défaut
    if TypeFeu=2 then EtatSignalCplx[feux[rang].adresse]:=violet_F;
    if TypeFeu=3 then EtatSignalCplx[feux[rang].adresse]:=semaphore_F;
    if (TypeFeu>3) and (TypeFeu<10) then EtatSignalCplx[feux[rang].adresse]:=carre_F;
    if TypeFeu>10 then EtatSignalCplx[feux[rang].adresse]:=0;

    dessine_feu_mx(Feux[rang].Img.Canvas,0,0,1,1,feux[rang].adresse,1);
    //if feux[rang].aspect=5 then cercle(Picture.Bitmap.Canvas,13,22,6,ClYellow);
  end;

  // créée le label pour afficher son adresse
  Feux[rang].Lbl:=Tlabel.create(Formprinc.ScrollBox1);
  with Feux[rang].Lbl do
  begin
    caption:='@'+IntToSTR(Feux[rang].adresse);
    Parent:=Formprinc.ScrollBox1;
    width:=100;height:=20;
    Top:=HtImg+((HtImg+EspY+20)*((rang-1) div NbreImagePLigne));
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    BringToFront;
  end;

  // créée le checkBox si un feu blanc est déclaré sur ce feu
  if feux[rang].FeuBlanc then
  begin
    Feux[rang].check:=TCheckBox.create(Formprinc.ScrollBox1);  // ranger l'adresse de la Checkbox dans la structure du feu
    Feux[rang].check.onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la procédure de traitement quand on clique dessus
    Feux[rang].check.Hint:=intToSTR(rang);  // affecter l'index du feu dans le HINT pour pouvoir le retrouver plus tard

    with Feux[rang].Check do
    begin
      caption:='dem FB';
      Parent:=Formprinc.ScrollBox1;
      width:=100;height:=15;
      Top:=HtImg+15+((HtImg+EspY+20)*((rang-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
      BringToFront;
    end;
  end;
end;

// calcule le checksum d'une trame
Function Checksum(s : string) : string;
var i : integer;
    check : byte;
begin
  check:=0;
  for i:=1 to length(s) do
  begin
    check:=check xor ord(s[i]);
  end;
  checksum:=s+char(check);
end;

// renvoie une chaine ASCI Hexa affichable à partir d'une chaîne
function chaine_HEX(s: string) : string;
var i : integer;
    sa_hex: string;
begin
  sa_hex:='';
  for i:=1 to length(s) do
  begin
    sa_hex:=sa_hex+IntToHex(ord(s[i]),2)+' ';
  end;
  chaine_HEX:=sa_hex;
end;

// Affiche une chaîne en Hexa Ascii
procedure affiche_chaine_hex(s : string;couleur : Tcolor);
begin
  if trace then Affiche(chaine_HEX(s),couleur);
end;

// temporisation en x 100 ms (0,1 s)
procedure Tempo(ValTemps : integer);
begin
  temps:=Valtemps;
  repeat
    Application.ProcessMessages;
  until (temps<=0);
end;


// envoi d'une chaîne à la centrale par USBLenz ou socket, n'attend pas l'ack
// ici on envoie pas à CDM
procedure envoi_ss_ack(s : string);
var i,timeout,valto : integer;
begin
//  com:=formprinc.MSCommUSBLenz;
  s:=entete+s+suffixe;
  if Trace then Affiche('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClGreen);
  // par port com-usb

  if portCommOuvert then
  begin
    if (protocole=4) then // le protocole 4 contrôle simplement la ligne CTS avant de transmettre et temporise octet par octet
    begin
      i:=1;
      valto:=10;
      //Affiche('envoi en tenant compte cts',clyellow);
        repeat
          timeout:=0;
          repeat
            //Application.ProcessMessages;
            inc(timeout);
            Sleep(20);
          until (Formprinc.MSCommUSBLenz.CTSHolding=true) or (timeout>valto);
          if timeout<=valto then
          begin
            //if formprinc.MSCommUSBLenz.CTSHolding then sa:='CTS=1 ' else sa:='CTS=0 ';
            FormPrinc.MSCommUSBLenz.Output:=s[i];
            //if terminal then Affiche(sa+s[i],clyellow) else Affiche(sa+chaine_hex(s[i]),clyellow);
            inc(i);
          end;
        until (i=length(s)+1) or (timeout>valto);
        if timeout>valto then affiche('Erreur attente interface trop longue',clred);
    end;
    if (protocole=2) or (tempoOctet=0) then begin FormPrinc.MSCommUSBLenz.Output:=s;exit;end;
    if (protocole=0) or (protocole=1) or (protocole=3) then
    begin
      for i:=1 to length(s) do
      begin
        FormPrinc.MSCommUSBLenz.Output:=s[i];
        //if terminal then Affiche(s[i],clyellow) else Affiche(chaine_hex(s[i]),clyellow);
        Application.ProcessMessages;
        Sleep(TempoOctet);
      end;
    end;
  end;

  // par socket (ethernet)
  if parSocket then Formprinc.ClientSocketLenz.Socket.SendText(s);
end;

// envoi d'une chaîne à la centrale Lenz par USBLenz ou socket, puis attend l'ack ou le nack
function envoi(s : string) : boolean;
var temps : integer;
begin
  if Hors_tension2=false then
  begin
    envoi_ss_ack(s);
    // attend l'ack
    ack:=false;nack:=false;
    if portCommOuvert or ParSocket then
    begin
      temps:=0;
      repeat
        Application.processMessages;
        inc(temps);Sleep(100);
      until ferme or ack or nack or (temps>TimoutMaxInterface); // l'interface répond < 5s en mode normal et 1,5 mn en mode programmation
      if not(ack) or nack then
      begin
        Affiche('Pas de réponse de l''interface',clRed);inc(pasreponse);
        // &&&&if pasreponse>3 then hors_tension2:=true;
      end;
      if ack then begin pasreponse:=0;hors_tension2:=false;end;
    end;
  end;
  envoi:=ack;
end;

Function chaine_CDM_Func(fonction,etat : integer;train : string) : string;
var so,sx,s : string;
begin
  {  exemple de commande envoyée au serveur pour une fonction
  C-C-00-0002-CMDTRN-DCCSF|029|03|NAME=nomdutrain;CSTEP=0;FXnumfonction=etat;

  C-C-00-0002-CMDTRN-DCCSF|029|03|NAME=train;CSTEP=0;FX0=0;
  C-C-00-0002-CMDTRN-DCCSF|029|03|NAME=train;CSTEP=0;FX1=0;
  C-C-00-0002-CMDTRN-DCCSF|047|06|NAME=train;CSTEP=0;FX0=1;FX1=1;FX2=1;FX3=1;
  maxi=C-C-00-0002-CMDTRN-DCCSF|111|16|NAME=train;CSTEP=0;FX0=1;FX1=1;FX2=1;FX3=1;FX4=0;FX5=0;FX6=0;FX7=0;FX8=0;FX9=0;FX10=0;FX11=0;FX12=0;FX13=0;
  }
  so:=place_id('C-C-01-0004-CMDTRN-DCCSF');
  s:=s+'NAME='+train+';';
  s:=s+'CSTEP=0;';
  s:=s+'FX'+intToSTR(fonction)+'='+intToSTR(etat)+';';
  sx:=format('%.*d',[2,3])+'|';  // 3 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;
  chaine_CDM_Func:=so+s;
end;

// prépare la chaîne de commande pour un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat1 : integer) : string;
var so,sx,s : string;
begin
 {  exemple de commande envoyée au serveur pour un manoeuvrer accessoire
  C-C-00-0004-CMDACC-DCCAC|018|02|AD=100;STATE=1;
  "	NAME : nom de l'aiguille
  "	OBJ: numéro CDM-Rail de l'aiguille (index)
  "	AD: adresse (DCC) de l'aiguille
  "	AD2: adresse #2 (DCC) de l'aiguille (TJD bi-moteurs ou aiguille triples)
  "	STATE: état de l'aiguille
  o	0: position droite (non déviée)
  o	1: dévié (TJD, bretelles doubles)
  o	2: dévié droit
  o	3: dévié gauche
  o	4: pos. droite #2 (TJD 4 états)
  o	5: pos. déviée #2 (TJD 4 états)
  }
  so:=place_id('C-C-01-0004-CMDACC-DCCAC');
  s:=s+'AD='+format('%.*d',[1,adresse])+';';
  s:=s+'STATE='+format('%.*d',[1,etat1])+';';

  sx:=format('%.*d',[2,2])+'|';  // 2 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_Acc:=so+s;
end;

procedure envoie_fonction_CDM(fonction,etat : integer;train : string);
var s : string;
begin
  s:=chaine_CDM_Func(fonction,etat,train);
  if trace then affiche(s,clLime);
  envoi_cdm(s);
end;


// active ou désactive une sortie. Une adresse comporte deux sorties identifiées par "octet"
// Adresse : adresse de l'accessoire
// octet : numéro (1-2) de la sortie à cette adresse
// etat  : false (désactivé) true (activé)
procedure pilote_direct(adresse:integer;octet : byte;etat : boolean);
var  groupe : integer ;
     fonction : byte;
     s : string;
begin
  groupe:=(adresse-1) div 4;
  fonction:=((adresse-1) mod 4)*2 + (octet-1);
  // pilotage
  if etat then
  s:=#$52+Char(groupe)+char(fonction or $80)
  else
  s:=#$52+Char(groupe)+char(fonction or $88);

  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
end;

procedure pilote_direct01(adresse:integer;octet:integer);
var  groupe : integer ;
     fonction : byte;
     s : string;
begin
  if octet=0 then octet:=2;
  groupe:=(adresse-1) div 4;
  fonction:=((adresse-1) mod 4)*2 + (octet-1);
  // pilotage
  if octet=2 then
  s:=#$52+Char(groupe)+char(fonction or $80)
  else
  s:=#$52+Char(groupe)+char(fonction or $88);

  s:=checksum(s);
  if envoi(s) then exit else envoi(s);     // envoi de la trame et attente Ack  sinon renvoyer
end;


// pilotage d'un accessoire (décodeur d'aiguillage, de signal)
// octet = 0 ou 1 ou 2
// la sortie "octet" est mise à 1 puis à 0
// acc = aig ou feu
procedure pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire);
var  groupe,temps : integer ;
     fonction : byte;
     s : string;
begin
  //Affiche(IntToSTR(adresse)+' '+intToSTr(octet),clYellow);
  // pilotage par CDM rail
  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    s:=chaine_CDM_Acc(adresse,octet);
    envoi_CDM(s);
    if (acc=feu) and not(Raz_Acc_signaux) then exit;
    s:=chaine_CDM_Acc(adresse,0);
    envoi_CDM(s);
    exit;
  end;

  // pilotage par USB ou par réseau de la centrale
  // test si pilotage inversé
  // Affiche('Accessoire '+intToSTR(adresse),clLime);
  if hors_tension2=false then
  begin
    if aiguillage[adresse].inversion=1 then
    begin
      if octet=1 then octet:=2 else octet:=1;
    end;
    if (octet=0) or (octet>2) then exit;
    groupe:=(adresse-1) div 4;
    fonction:=((adresse-1) mod 4)*2 + (octet-1);
    // pilotage à 1
    s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
    // si l'accessoire est un feu et sans raz des signaux, sortir
    if (acc=feu) and not(Raz_Acc_signaux) then exit;

    // si aiguillage, faire une temporisation
    //if (index_feu(adresse)=0) or (Acc=aig) then
    if Acc=Aig then
    begin
      temps:=aiguillage[adresse].temps;if temps=0 then temps:=4;
      if portCommOuvert or ParSocket then tempo(temps);
    end;
    sleep(50);

    // pilotage à 0 pour éteindre le pilotage de la bobine du relais
    s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
  end;
end;

// pilote accessoire en entrée 0->2  1->1
procedure pilote_acc01(adresse : integer;octet : byte);
var  groupe : integer ;
     fonction : byte;
     s : string;
begin
  // test si pilotage inversé
  if octet=0 then octet:=2;
  if aiguillage[adresse].inversion=1 then
  begin
    if octet=1 then octet:=2 else octet:=1;
  end;
  if (octet=0) or (octet>2) then exit;
  groupe:=(adresse-1) div 4;
  fonction:=((adresse-1) mod 4)*2 + (octet-1);
  // pilotage à 1
  s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
  sleep(10);    // temps minimal pour ne pas avoir le défaut station occupée qd on pilote un signal leb
  //temps:=aiguillage[adresse].temps;if temps=0 then temps:=4;
  // si l'accessoire est un feu, fixer l tempo à 1
  //if index_feu(adresse)<>0 then temps:=1;

  //if portCommOuvert or ParSocket then tempo(temps);
  // pilotage à 0 pour éteindre le pilotage de la bobine du relais
  s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
end;

procedure vitesse_loco(loco : integer;vitesse : integer;sens : boolean);
var s : string;
begin
  if sens then vitesse:=vitesse or 128;
  s:=#$e4+#$13+#$0+char(loco)+char(vitesse);
  s:=checksum(s);
  envoi(s);
end;

function testBit(n : word;position : integer) : boolean;
begin
   testBit:=n and (1 shl position) = (1 shl position);
end;

Function RazBit(n : word;position : integer) : word;
begin
  RazBit:=n and not(1 shl position);
end;

Function SetBit(n : word;position : integer) : word;
begin
  SetBit:=n or (1 shl position);
end;

// mise à jour état signal complexe dans le tableau de bits du signal EtatSignalCplx */
// adresse : adresse du signal complexe
// Aspect : code représentant l'état du signal de 0 à 15
procedure Maj_Etat_Signal(adresse,aspect : integer);
begin

  if testBit((EtatSignalCplx[adresse]),aspect)=false then  // si le bit dans l'état du signal n'est pas allumé, procéder.
  begin
    // effacement du motif de bits en fonction du nouvel état demandé suivant la règle des signaux complexes
    if (aspect<=blanc_cli) then
    begin
      EtatSignalCplx[adresse]:=0;  //Tout aspect <=7 efface les autres
    end;
    if (aspect=jaune) then // jaune
    begin
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],jaune_cli); // cas du jaune: efface le bit du jaune clignotant (bit 9)
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],ral_30);  // cas du jaune: efface le bit du ral_30 (bit 10)
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],ral_60);  // cas du jaune: efface le bit du ral_60 (bit 11)
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($00FF);   // et effacer les bits 0 à 7
    end;
    if (aspect=jaune_cli) then // jaune clignotant
    begin
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],jaune);   // cas du jaunecli: efface le bit du jaune  (bit 8)
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and $FF00;   // et effacer les bits 0 à 7
    end;
    if (aspect=ral_30) then // ralentissement 30
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($3BFF);   // cas du ral 30: efface les bits 0 1 2 3 4 5 6 7 8 9 11 12 et 13 :  11 1000 1111 1111
    end;
    if (aspect=ral_60) then // ralentissement 60
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($35FF);   // cas du ral 60: efface les bits 8 10 12 et 13 et de 0 à 7  : 11 0100 1111 1111
    end;
    if (aspect=rappel_30) then // rappel 30
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($2cff);   // cas du rappel 30: efface les bits 0 1 2 3 4 5 6 7 10 11 et 13 : 10 1100 1111 0000
    end;
    if (aspect=rappel_60) then // rappel 60
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($1Cff);   // cas du rappel 60: efface les bits 0 1 2 3 4 5 6 7 10 11 et 12  1 1100 1111 0000
    end;
    if (aspect=aspect8) then // ral_60_jaune_cli décodeur LDT
    begin
      EtatSignalCplx[adresse]:=jaune_cli_F or ral_60_F;   // cas du ralentissement 60 + avertissement clignotant : efface les bits 10 11 et 12
    end;
    if (aspect<>aspect8) then
    begin
      EtatSignalCplx[adresse]:=SetBit(EtatSignalCplx[adresse],aspect);   // allume le numéro du bit de la fonction du signal
      // Affiche(IntToSTR(EtatSignalCplx[adresse]),clyellow);
    end;
  end;
end;


{=============================================
envoie les données au décodeur digital bahn équipé du logiciel "led_schalten"
sur un panneau directionnel - adresse : adresse du signal - code de 1 à 3 pour allumer
; le panneau directionnel à 1, 2 ou 3 leds.
============================================== }
procedure envoi_directionBahn(adr : integer;code : integer);
var i : integer;
begin
  if (EtatSignalCplx[adr]<>code) then
  begin
    if (traceSign) then Affiche('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);
    if AffSignal then AfficheDebug('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);

    case code of
    0 :  begin      pilote_acc(adr,1,feu);   // sortie 1 à 0
                    sleep(tempoFeu);
                    pilote_acc(adr+1,1,feu); // sortie 2 à 0
                    sleep(Tempofeu);
                    pilote_acc(adr+2,1,feu); // sortie 3 à 0
                    sleep(TempoFeu);
         end;
    1 :  begin      pilote_acc(adr,2,feu);   // sortie 1 à 1
                    sleep(tempoFeu);
                    pilote_acc(adr+1,1,feu); // sortie 2 à 0
                    sleep(Tempofeu);
                    pilote_acc(adr+2,1,feu); // sortie 3 à 0
                    sleep(TempoFeu);
          end;
    2 :  begin      pilote_acc(adr,2,feu);   // sortie 1 à 1
                    sleep(tempoFeu);
                    pilote_acc(adr+1,2,feu); // sortie 2 à 1
                    sleep(Tempofeu);
                    pilote_acc(adr+2,1,feu); // sortie 3 à 0
                    sleep(TempoFeu);
          end;
    3 :  begin      pilote_acc(adr,2,feu);   // sortie 1 à 1
                    sleep(tempoFeu);
                    pilote_acc(adr+1,2,feu); // sortie 2 à 1
                    sleep(Tempofeu);
                    pilote_acc(adr+2,2,feu); // sortie 3 à 1
                    sleep(TempoFeu);
          end;
    end;
    EtatSignalCplx[adr]:=code;
    Dessine_feu_mx(Feux[Index_Feu(adr)].Img.Canvas,0,0,1,1,adr,1);
  end;
end;


{ =============================================
envoie les données au signal de direction pour un décodeur CDF
adresse : adresse du signal - code de 1 à 3 pour allumer
le panneau directionnel à 1, 2, 3 ou 4 leds.
============================================== }
procedure envoi_directionCDF(adr : integer;code : integer);
begin
  if (EtatSignalCplx[adr]<>code) then
  begin
    if traceSign then Affiche('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
    if AffSignal then AfficheDebug('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

    case code of
      // éteindre toutes les leds
    0 :
      begin
        pilote_acc(adr,1,feu) ;
        sleep(200);
      end;
      // code 1 : allume le feu le plus à gauche
    1 :
      begin
        pilote_acc(adr,2,feu) ;
        sleep(200);
      end;
    2 : //allume 2 feux
      begin
        pilote_acc(adr+1,1,feu) ;
        sleep(200);
      end;
      // code 3 : allume 3 feux
    3 :
      begin
        pilote_acc(adr+1,2,feu) ;
        sleep(200);
      end;
    end;
    EtatSignalCplx[adr]:=code;
  end;
end;

procedure Envoi_DirectionLEB(Adr : integer;code : integer);
begin
  if (EtatSignalCplx[adr]<>code) then
  begin
    if traceSign then Affiche('signal directionnel LEB: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
    if aFFsIGNAL then AfficheDebug('signal directionnel LEB: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

    case code of
    0 : begin pilote_acc(adr+5,2,feu) ;  pilote_acc(adr+6,2,feu) ;end;  //00
    1 : begin pilote_acc(adr+5,1,feu) ;  pilote_acc(adr+6,2,feu) ;end;  //10
    2 : begin pilote_acc(adr+5,2,feu) ;  pilote_acc(adr+6,1,feu) ;end;  //01
    3 : begin pilote_acc(adr+5,1,feu) ;  pilote_acc(adr+6,1,feu) ;end;  //11
    end;
    EtatSignalCplx[adr]:=code;
  end;
end;

{==========================================================================
envoie les données au décodeur CDF pour un signal
===========================================================================*}
procedure envoi_CDF(adresse : integer);
var code,aspect,index : integer;
begin
  index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau
  code:=feux[index].aspect; // aspect du feu;
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    aspect:=code_to_aspect(code);
    if traceSign then affiche('Signal CDF: '+intToSTR(adresse)+' '+intToSTR(code),clOrange);
    if Affsignal then afficheDebug('Signal CDF: '+intToSTR(adresse)+' '+intToSTR(code),clOrange);
  
  
    if (aspect=carre)     then pilote_acc(adresse,2,feu) ;
    if (aspect=semaphore) then pilote_acc(adresse,1,feu) ;
    if (aspect=vert)      then pilote_acc(adresse+1,1,feu) ;
    if (aspect=jaune)     then pilote_acc(adresse+1,2,feu);
    // signalisation non combinée rappel 30 seul
    if (aspect=rappel_30) then pilote_acc(adresse+1,1,feu);

    // signalisation combinée  - rappel 30 + avertissement - à tester......
    if (Combine=0)      then pilote_acc(adresse+2,1,feu) ;    // éteindre rappel 30
    if (Combine=rappel_30) then pilote_acc(adresse+2,2,feu) ; // allumer rappel 30  
    Dessine_feu_mx(Feux[Index_Feu(adresse)].Img.Canvas,0,0,1,1,adresse,1);
  end;
end;

{==========================================================================
envoie les données au décodeur LEB pour un signal
===========================================================================*}
procedure envoi_LEB(adr : integer);
var codebin,aspect : integer;
    s : string;
  procedure envoi5_LEB(selection :byte);
  var i : integer;
  begin
    s:='';
    for i:=0 to 4 do
    begin
      if (testBit(selection,i)) then begin pilote_acc(adr+i,1,feu);s:=s+'1';end
      else begin pilote_acc(adr+i,2,feu) ; s:=s+'0';end;
      //if (testBit(selection,i)) then begin pilote_acc(adr+i,1);s:=s+'1';end
      //else begin pilote_acc(adr+i,2) ; s:=s+'0';end;
      //Sleep(60);
    end;
    //Affiche(inttoStr(selection),clOrange);
    //Affiche(s,clOrange);
  end;
begin

if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //; && (stop_cmd==FALSE))
begin
  ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr];
  codebin:=EtatSignalCplx[adr];
  aspect:=code_to_aspect(codebin);
  if traceSign then
  begin
    s:='Signal LEB:  ad'+IntToSTR(adr)+'='+etatSign[aspect];
    //s:='Signal LEB:  ad'+IntToSTR(adr)+' aspect='+intToSTR(aspect)+' combine='+intToSTR(combine);
    if Combine<>0 then s:=s+' + '+etatSign[combine];
    Affiche(s,clOrange);
  end;
  if AffSignal then
  begin
    s:='Signal LEB:  ad'+IntToSTR(adr)+'='+etatSign[aspect];
    //s:='Signal LEB:  ad'+IntToSTR(adr)+' aspect='+intToSTR(aspect)+' combine='+intToSTR(combine);
    if Combine<>0 then s:=s+' + '+etatSign[combine];
    AfficheDebug(s,clOrange);
  end;
  
  Sleep(60);  // si le feu se positionne à la suite d'un positionnement d'aiguillage, on peut avoir le message station occupée

  if (Combine=0) then
  begin
    if (aspect=carre)         then envoi5_LEB(0);
    if (aspect=violet)        then envoi5_LEB(1);
    if (aspect=blanc_cli)     then envoi5_LEB(2);
    if (aspect=blanc)         then envoi5_LEB(3);
    if (aspect=semaphore)     then envoi5_LEB(4);
    if (aspect=semaphore_cli) then envoi5_LEB(5);
    if (aspect=jaune)         then envoi5_LEB(8);
    if (aspect=jaune_cli)     then envoi5_LEB($a);
    if (aspect=vert_cli)      then envoi5_LEB($c);
    if (aspect=vert)          then envoi5_LEB($d);
    if (aspect=rappel_30)     then envoi5_LEB(6);
    if (aspect=rappel_60)     then envoi5_LEB(7);
    if (aspect=ral_30)        then envoi5_LEB(9);
    if (aspect=ral_60)        then envoi5_LEB($b);
  end;
  if (aspect=0) then
  begin
    if (Combine=rappel_30)    then envoi5_LEB(6);
    if (Combine=rappel_60)    then envoi5_LEB(7);
    if (Combine=ral_30)       then envoi5_LEB(9);
    if (Combine=ral_60)       then envoi5_LEB($b);
  end;
  if ((Combine=rappel_30) and (aspect=jaune))     then envoi5_LEB($e);
  if ((Combine=rappel_30) and (aspect=jaune_cli)) then envoi5_LEB($f);
  if ((Combine=rappel_60) and (aspect=jaune))     then envoi5_LEB($10);
  if ((Combine=rappel_60) and (aspect=jaune_cli)) then envoi5_LEB($11);
  if ((Combine=ral_60)    and (aspect=jaune_cli)) then envoi5_LEB($12);
  Dessine_feu_mx(Feux[Index_Feu(adr)].Img.Canvas,0,0,1,1,adr,1);
end;
end;

(*==========================================================================
envoie les données au décodeur NMRA étendu
       adresse=adresse sur le BUS DCC
       code=code d'allumage :
0.	Carré
1.	Sémaphore
2.	Sémaphore clignotant
3.	Vert
4.	Vert clignotant
5.	Carré violet
6.	Blanc
7.	Blanc clignotant
8.	Avertissement
9.	Avertissement clignotant
10.	Ralentissement 30
11.	Ralentissement 60
12.	Ralentissement 60 + avertissement clignotant
13.	Rappel 30
14.	Rappel 60
15.	Rappel 30 + avertissement
16.	Rappel 30 + avertissement clignotant
17.	Rappel 60 + avertissement
18.	rappel 60 + avertissement clignotant

/*===========================================================================*)
procedure envoi_NMRA(adresse: integer);
var valeur,code,codebin,aspect : integer ;
    s : string;
begin
  //index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau
  //code:=feux[index].aspect; // aspect du feu;
    

  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    codebin:=EtatSignalCplx[adresse];
    code:=code_to_aspect(codebin);

    if traceSign then
    begin
      s:='Signal NMRA:  ad'+IntToSTR(adresse)+'='+etatSign[aspect];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      Affiche(s,clOrange);
    end;
    if AffSignal then
    begin
      s:='Signal NMRA:  ad'+IntToSTR(adresse)+'='+etatSign[aspect];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      AfficheDebug(s,clOrange);
    end;

    if combine=0 then
    case (code) of
      carre                     : valeur:=0;
      semaphore                 : valeur:=1;
      semaphore_cli             : valeur:=2;
      vert                      : valeur:=3;
      vert_cli                  : valeur:=4;
      violet                    : valeur:=5;
      blanc                     : valeur:=6;
      blanc_cli                 : valeur:=7;
      jaune                     : valeur:=8;
      jaune_cli                 : valeur:=9;
      ral_30                    : valeur:=10;
      ral_60                    : valeur:=11;
      rappel_30                 : valeur:=13;
      rappel_60                 : valeur:=14;
    end;

    if aspect=0 then 
    begin
      if combine=rappel_30 then valeur:=13;
      if combine=rappel_60 then valeur:=14;
    end;
    
    if (Combine=ral_60)    and (aspect=jaune_cli) then valeur:=12;
    if (Combine=rappel_30) and (aspect=jaune)     then valeur:=15;
    if (Combine=rappel_30) and (aspect=jaune_cli) then valeur:=16;     
    if (Combine=rappel_60) and (aspect=jaune)     then valeur:=17;        
    if (Combine=rappel_60) and (aspect=jaune_cli) then valeur:=18;  

    pilote_acc(adresse,valeur,feu);
    Dessine_feu_mx(Feux[Index_Feu(adresse)].Img.Canvas,0,0,1,1,adresse,1);
  end;
end;

// décodeur unisemaf (paco)
procedure envoi_UniSemaf(adresse: integer);
var modele,index,code,codebin : integer ;
    s : string;
begin
  index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau

 if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    codebin:=EtatSignalCplx[adresse];
    code:=code_to_aspect(codebin);

    if traceSign then
    begin
      s:='Signal UniSemaf: ad'+IntToSTR(adresse)+'='+etatSign[code];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      Affiche(s,clOrange);
    end;
    if AffSignal then 
    begin
      s:='Signal UniSemaf: ad'+IntToSTR(adresse)+'='+etatSign[code];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      AfficheDebug(s,clOrange);
    end;
    
    // pour Unisemaf, la cible est définie dans le champ Unisemaf de la structure feux

    modele:=feux[index].Unisemaf;
    //Affiche('Adresse='+intToSTR(Adresse)+' code='+intToSTR(code)+' combine'+intToSTR(combine),clyellow);
        if modele=2 then // 2 feux
        begin
          if code=blanc then      pilote_acc(adresse,1,feu);
          if code=blanc_cli then  pilote_acc(adresse,1,feu);
          if code=violet then     pilote_acc(adresse,2,feu);
        end;

        if modele=3 then // 3 feux
        begin
          if code=vert then       pilote_acc(adresse,1,feu);
          if code=vert_cli then   pilote_acc(adresse,1,feu);

          if code=semaphore then  pilote_acc(adresse,2,feu);
          if code=semaphore_cli then pilote_acc(adresse,2,feu);

          if code=jaune then      pilote_acc(adresse+1,1,feu);
          if code=jaune_cli then  pilote_acc(adresse+1,1,feu);
        end;

        if modele=4 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          end;
        end;
        // 51=carré + blanc
        if modele=51 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          blanc                 : pilote_acc(adresse+2,1,feu);
          blanc_cli             : pilote_acc(adresse+2,1,feu);
          end;
        end;
        // 52=VJR + blanc + violet
        if modele=52 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          violet                : pilote_acc(adresse+2,1,feu);
          blanc                 : pilote_acc(adresse+1,2,feu);
          blanc_cli             : pilote_acc(adresse+1,2,feu);
          end;
        end;
        // 71=VJR + ralentissement 30
        if modele=71 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          ral_30                : pilote_acc(adresse+1,2,feu);
          end;
        end;
        // 72=VJR + carré + ralentissement 30
        if modele=72 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          ral_30                : pilote_acc(adresse+2,1,feu);
          end;
        end;
        // 73=VJR + carré + ralentissement 60
        if modele=73 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          ral_60                : pilote_acc(adresse+2,1,feu);
          end;
        end;
        // 91=VJR + carré + rappel 30
        if modele=91 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          rappel_30             : pilote_acc(adresse+2,1,feu);
          end;
        end;

        // 92=VJR + carré + rappel 60
        if modele=92 then
        begin
          case code of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          rappel_60             : pilote_acc(adresse+2,1,feu);
          end;
        end;

        // 93=VJR + carré + ral30 + rappel 30
        if modele=93 then
        begin
          if combine=0 then
          begin
            if code=vert                  then pilote_acc(adresse,1,feu);
            if code=vert_cli              then pilote_acc(adresse,1,feu);
            if code=jaune                 then pilote_acc(adresse,2,feu);
            if code=jaune_cli             then pilote_acc(adresse,2,feu);
            if code=semaphore             then pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if code=carre                 then pilote_acc(adresse+1,2,feu);
            if code=ral_30                then pilote_acc(adresse+2,1,feu);
            if code=rappel_30             then pilote_acc(adresse+2,2,feu);
          end;
          if (code=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,feu);
        end;

        // 94=VJR + carré + ral60 + rappel60
        if modele=94 then
        begin
          if combine=0 then
          begin
            if code=vert                  then pilote_acc(adresse,1,feu);
            if code=vert_cli              then pilote_acc(adresse,1,feu);
            if code=jaune                 then pilote_acc(adresse,2,feu);
            if code=jaune_cli             then pilote_acc(adresse,2,feu);
            if code=semaphore             then pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if code=carre                 then pilote_acc(adresse+1,2,feu);
            if code=ral_60                then pilote_acc(adresse+2,1,feu);
            if code=rappel_60             then pilote_acc(adresse+2,2,feu);
          end;
          if (code=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;

        // 95=VJR + carré + ral30 + rappel 60
        if modele=95 then
        begin
          if combine=0 then
          begin
            if code=vert                  then pilote_acc(adresse,1,feu);
            if code=vert_cli              then pilote_acc(adresse,1,feu);
            if code=jaune                 then pilote_acc(adresse,2,feu);
            if code=jaune_cli             then pilote_acc(adresse,2,feu);
            if code=semaphore             then pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if code=carre                 then pilote_acc(adresse+1,2,feu);
            if code=ral_30                then pilote_acc(adresse+2,1,feu);
            if code=rappel_60             then pilote_acc(adresse+2,2,feu);
          end;
          if (code=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;
        // 96=VJR + blanc + carré + ral30 + rappel30
        if modele=96 then
        begin
          if combine=0 then
          begin
            if code=vert               then pilote_acc(adresse,1,feu);
            if code=vert_cli           then pilote_acc(adresse,1,feu);
            if code=jaune              then pilote_acc(adresse,2,feu);
            if code=jaune_cli          then pilote_acc(adresse,2,feu);
            if code=semaphore          then pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli      then pilote_acc(adresse+1,1,feu);
            if code=carre              then pilote_acc(adresse+1,2,feu);
            if code=ral_30             then pilote_acc(adresse+2,1,feu);
            if code=rappel_30          then pilote_acc(adresse+2,2,feu);
            if code=blanc              then pilote_acc(adresse+3,2,feu);
            if code=blanc_cli          then pilote_acc(adresse+3,2,feu);
          end;
          if (code=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,feu);
        end;

        // 97=VJR + blanc + carré + ral30 + rappel60
        if modele=97 then
        begin
          if combine=0 then
          begin
            if code=vert                  then pilote_acc(adresse,1,feu);
            if code=vert_cli              then pilote_acc(adresse,1,feu);
            if code=jaune                 then pilote_acc(adresse,2,feu);
            if code=jaune_cli             then pilote_acc(adresse,2,feu);
            if code=semaphore             then pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if code=carre                 then pilote_acc(adresse+1,2,feu);
            if code=ral_30                then pilote_acc(adresse+2,1,feu);
            if code=rappel_60             then pilote_acc(adresse+2,2,feu);
            if code=blanc                 then pilote_acc(adresse+3,2,feu);
            if code=blanc_cli             then pilote_acc(adresse+3,2,feu);
          end;
          if (code=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;
        
        // 98=VJR + blanc + violet + ral30 + rappel30
        if modele=98 then
        begin
          if combine=0 then
          begin
            if code=vert then               pilote_acc(adresse,1,feu);
            if code=vert_cli then           pilote_acc(adresse,1,feu);
            if code=jaune then              pilote_acc(adresse,2,feu);
            if code=jaune_cli then          pilote_acc(adresse,2,feu);
            if code=semaphore then          pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli then      pilote_acc(adresse+1,1,feu);
            if code=violet then             pilote_acc(adresse+1,2,feu);
            if code=ral_30 then             pilote_acc(adresse+2,1,feu);
            if code=rappel_30 then          pilote_acc(adresse+2,2,feu);
            if code=blanc then              pilote_acc(adresse+3,2,feu);
            if code=blanc_cli then          pilote_acc(adresse+3,2,feu);
          end;
          if (code=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,feu);
        end;

        // 99=VJR + blanc + violet + ral30 + rappel60
        if modele=99 then
        begin
          if combine=0 then
          begin
            if code=vert                  then pilote_acc(adresse,1,feu);
            if code=vert_cli              then pilote_acc(adresse,1,feu);
            if code=jaune                 then pilote_acc(adresse,2,feu);
            if code=jaune_cli             then pilote_acc(adresse,2,feu);
            if code=semaphore             then pilote_acc(adresse+1,1,feu);
            if code=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if code=violet                then pilote_acc(adresse+1,2,feu);
            if code=ral_30                then pilote_acc(adresse+2,1,feu);
            if code=rappel_60             then pilote_acc(adresse+2,2,feu);
            if code=blanc                 then pilote_acc(adresse+3,2,feu);
            if code=blanc_cli             then pilote_acc(adresse+3,2,feu);
          end;
          if (code=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;
    Dessine_feu_mx(Feux[Index_Feu(adresse)].Img.Canvas,0,0,1,1,adresse,1);
  end;
end;

{==========================================================================
envoie les données au décodeur LDT
       adresse=adresse sur le BUS DCC
       code=code d'allumage selon l'adressage (ex carre, vert, rappel_30 ..).
       mode=mode du décodeur adressé, de 1 à 2
       un décodeur occupe 8 adresses
       Le mode 1 permet la commande des signaux de 2, 3 et 4 feux
       Le mode 2 permet la commande de signaux de plus de 4 feux
===========================================================================}
procedure envoi_LDT(adr : integer);
var codebin,aspect,mode : integer;
begin
  codebin:=EtatSignalCplx[adr];
  aspect:=code_to_aspect(codebin);
  if aspect>carre then mode:=2 else mode:=1;
  if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr];
    //if (tempo_ACC>0) then sleep(100);  // les commandes entre 2 feux successives doivent être séparées au minimum de 100 ms
    if traceSign then affiche('Signal LDT: '+IntToSTR(adr)+' '+intToSTR(mode)+' '+intTOSTR(codebin),clOrange);
    if AffSignal then afficheDebug('Signal LDT: '+IntToSTR(adr)+' '+intToSTR(mode)+' '+intTOSTR(codebin),clOrange);
    
    if (aspect=semaphore) or (aspect=vert) or (aspect=carre) or (aspect=jaune) then mode:=1 else mode:=2;

    case mode of
      // pour les décodeurs en mode 0, il faut écrire la routine vous même car le pilotage dépend du cablage
      // sauf pour le sémaphore, vert et jaune fixe
    1 :       // mode 1: feux 2 3 & 4 feux
    begin
      if (aspect=semaphore) then pilote_acc(adr,1,feu);
      if (aspect=vert)      then pilote_acc(adr,2,feu);
      if (aspect=carre)     then pilote_acc(adr+1,1,feu);
      if (aspect=jaune)     then pilote_acc(adr+1,2,feu);
    end;
    2 :      // mode 2: plus de 4 feux
    begin
      if (aspect=semaphore) then begin pilote_acc(adr+2,1,feu);sleep(tempoFeu);pilote_acc(adr,1,feu);end;
      if (aspect=vert)   then begin pilote_acc(adr+2,1,feu);sleep(tempoFeu);pilote_acc(adr,2,feu);end;
      if (aspect=carre)  then begin pilote_acc(adr+2,1,feu);sleep(tempoFeu);pilote_acc(adr+1,1,feu);end;
      if (aspect=jaune)  then begin pilote_acc(adr+2,1,feu);sleep(tempoFeu);pilote_acc(adr+1,2,feu);end;
      if (aspect=violet) then begin pilote_acc(adr+2,2,feu);sleep(tempoFeu);pilote_acc(adr,1,feu);end;
      if (aspect=blanc)  then begin pilote_acc(adr+2,2,feu);sleep(tempoFeu);pilote_acc(adr,2,feu);end;
      if (aspect=semaphore) then begin pilote_acc(adr+2,2,feu);sleep(tempoFeu);pilote_acc(adr+1,1,feu);end;
      if (aspect=aspect8) then begin pilote_acc(adr+2,2,feu);sleep(tempoFeu);pilote_acc(adr+1,2,feu);end;
      if (aspect=ral_60_jaune_cli) then begin pilote_acc(adr+3,1,feu);sleep(tempoFeu);pilote_acc(adr,1,feu);end;  // demande groupe 3
      if (aspect=vert_cli) then begin pilote_acc(adr+3,1,feu);sleep(tempoFeu);pilote_acc(adr,2,feu);end; // demande groupe 3
      if (aspect=Disque_D) then begin pilote_acc(adr+3,1,feu);sleep(tempoFeu);pilote_acc(adr+1,1,feu);end;// demande groupe 3
      if (aspect=jaune_cli) then begin pilote_acc(adr+3,1,feu);sleep(tempoFeu);pilote_acc(adr+1,2,feu);end;
      if (aspect=ral_30) then begin pilote_acc(adr+3,2,feu);sleep(tempoFeu);pilote_acc(adr,1,feu);end;
      if (aspect=ral_60) then begin pilote_acc(adr+3,2,feu);sleep(tempoFeu);pilote_acc(adr,2,feu);end;
      if (aspect=rappel_30) then begin pilote_acc(adr+3,2,feu);sleep(tempoFeu);pilote_acc(adr+1,1,feu);end;
      if (aspect=rappel_60) then begin pilote_acc(adr+3,2,feu);sleep(tempoFeu);pilote_acc(adr+1,2,feu);end;
    end;
    end;
  Dessine_feu_mx(Feux[Index_Feu(adr)].Img.Canvas,0,0,1,1,adr,1);
  end;
end;


procedure envoi_virtuel(adresse : integer);
var
  aspect,code : integer;
begin
  code:=etatsignalcplx[adresse];
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    aspect:=code_to_aspect(code); // transforme le motif de bits en numéro  "code des aspects des signaux"
    if (tracesign) then Affiche('Signal virtuel: ad'+intToSTR(adresse)+'='+etatSign[aspect],clOrange);
    if AffSignal then AfficheDebug('Signal virtuel: ad'+intToSTR(adresse)+'='+etatSign[aspect],clOrange);
    Dessine_feu_mx(Feux[Index_Feu(adresse)].Img.Canvas,0,0,1,1,adresse,1);
  end;
end;

(*==========================================================================
envoie les données au décodeur digitalbahn équipé du logiciel "led_signal_10"
       adresse=adresse sur le BUS DCC
       codebin=motif de bits représentant l'état des feux L'allumage est fait en
       adressant l'une des 14 adresses pour les 14 leds possibles du feu.
       Ici on met le bit 1 à 1 (état "vert" du programme hexmanipu
===========================================================================*)
//procedure envoi_signalBahn(adresse,codebin : integer);
procedure envoi_signalBahn(adresse : integer);
var aspect,combineLoc,codebin : integer;
    ralrap, jau ,Ancralrap,Ancjau : boolean;
    s : string;
begin
//    s:='@='+IntToSTR(adresse)+' '+intToSTR(ancien_tablo_signalCplx[adresse])+' '+intToSTR(EtatsignalCplx[adresse]);
//    affiche(s,ClYellow);
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    codebin:=EtatSignalCplx[adresse];
    aspect:=code_to_aspect(codebin); // transforme le motifs de bits en numéro  "code des aspects des signaux"
    combineLoc:=combine;  // copier dans variable locale
    //dessine_feu(adresse);
    if traceSign then
    begin
      s:='Signal bahn: ad'+IntToSTR(adresse)+'='+etatSign[aspect];
      if CombineLoc<>0 then s:=s+' + '+etatSign[combineLoc];
      Affiche(s,clOrange);
    end;
    if AffSignal then
    begin
      s:='Signal bahn: ad'+IntToSTR(adresse)+'='+etatSign[aspect];
      if CombineLoc<>0 then s:=s+' + '+etatSign[combineLoc];
      AfficheDebug(s,clOrange);
    end;
    // spécifique au décodeur digital bahn:
    // si le signal affichait un signal combiné, il faut éteindre le signal avec un sémaphore
    // avant d'afficher le nouvel état non combiné
    Ancralrap:=(TestBit(ancien_tablo_signalCplx[adresse],ral_30)) or (TestBit(ancien_tablo_signalCplx[adresse],ral_60)) or
               (TestBit(ancien_tablo_signalCplx[adresse],rappel_30)) or (TestBit(ancien_tablo_signalCplx[adresse],rappel_60)) ;
    // si ancien état du signal=jaune ou jaune cli
    Ancjau:=(TestBit(ancien_tablo_signalCplx[adresse],jaune)) or (TestBit(ancien_tablo_signalCplx[adresse],jaune_cli)) ;

    // si état demandé du signal=ralentissement ou rappel
    ralrap:=(TestBit(codebin,ral_30)) or (TestBit(codebin,ral_60)) or
           (TestBit(codebin,rappel_30)) or (TestBit(codebin,rappel_60)) ;
    // si état demandé du signal=jaune ou cli
    jau:=TestBit(codebin,jaune) or TestBit(codebin,jaune_cli) ;

    //effacement du signal combiné par sémaphore suivant condition
    if (((Ancralrap and not(ralrap)) or (Ancjau and not(jau))) and (aspect>=8)) then
    begin
      Sleep(40);
      pilote_acc(adresse+semaphore,2,feu) ;
     // dessine_feu(adresse);
    end;

    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];

    sleep(40);  // les commandes entre 2 feux successifs doivent être séparées au minimum de 100 ms
    // affichage du premier aspect du signal(1er bit à 1 dans codebin
    pilote_acc(adresse+aspect,2,feu) ;


    // affichage de la signalisation combinée (2ème bit à 1 dans codebin)
    if (CombineLoc<>0) then
    begin
      sleep(40);
      pilote_ACC(adresse+CombineLoc,2,feu) ;
    end;
    Dessine_feu_mx(Feux[Index_Feu(adresse)].Img.Canvas,0,0,1,1,adresse,1);
  end;
end;

//évaluation des signaux ancienne version==================================================================*/
procedure signaux;
var Num_voie,signalCplx,i : integer;
    PresTrain,a,b,c : boolean;
begin
// signal 176 =========================================================*/
signalCplx:=176;
a:=MemZone[524,521] and (aiguillage[8].position=2);
b:=MemZone[514,522] and (aiguillage[8].position<>2);
PresTrain:=MemZone[527,520]  or ((aiguillage[7].position<>2) and ( a or b or MemZone[521,527] or MemZone[522,527]));
if (((aiguillage[20].position<>2) and (aiguillage[12].position<>2)) or (PresTrain=FALSE)) then
     Maj_Etat_Signal(signalCplx,carre)
else
begin
  // si train quitte zone de détection du signal
  if ( (MemZone[520,530] and (aiguillage[20].position=2) and (aiguillage[26].position=2)) or
       (MemZone[520,529] and (aiguillage[20].position=2) and (aiguillage[26].position<>2)) or
       (MemZone[520,517] and (aiguillage[20].position<>2)) ) then
  begin
     if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin  // 26==0 : voie droite   <>0 : voie gauche
    a:=((aiguillage[20].position<>2) and (testBit(EtatSignalCplx[358],carre)) or (testbit(EtatSignalCplx[358],semaphore)));
    b:=((aiguillage[20].position=2) and (testBit(EtatSignalCplx[420],carre)) or (testbit(EtatSignalCplx[420], semaphore)));

    if (a or b) then
    begin    // si signal complexe suivant est au carré ou sémaphore
      Maj_Etat_Signal(signalCplx,jaune);       // afficher un avertissement
    end
    else
    begin
      if ((aiguillage[11].position<>2) and (aiguillage[20].position<>2)
        and (aiguillage[12].position=2) and (aiguillage[18].position<>2)) then // si aiguille suivante prise en pointe est déviée
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
      end
      else
      begin
        a:=(aiguillage[20].position<>2) and testbit(EtatSignalCplx[358],jaune);
        b:=((aiguillage[20].position=2) and testbit(EtatSignalCplx[420],jaune));
        if (a or b) then              // si signal cplx suivant est jaune
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          Maj_Etat_Signal(signalCplx,jaune_cli);   // afficher un avertissement clignotant sur le signal complexe
        end
        else Maj_Etat_Signal(signalCplx,vert);      // sinon afficher un feu vert
      end;
    end;
  end;
end;

// signal 190 ================================================================ */
signalCplx:=190;
if memZone[523,526]=true then // si train quite zone de détection du signal
  begin
    Maj_Etat_Signal(signalCplx,semaphore);     //  mettre un sémaphore}
  end
  else
  begin
    if testBit(EtatSignalCplx[302],carre) or testBit(EtatSignalCplx[302],semaphore) then  // si signal complexe suivant= carré ou sémaphore
     // Maj_Etat_Signal(signalCplx,jaune); //
      Maj_Etat_Signal(signalCplx,semaphore_cli)
    else
    begin
      if (aiguillage[9].position<>2) then                   // si aiguille suivante déviée?
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        if testBit(EtatSignalCplx[302],jaune) then         // si signal suivant jaune ?
          Maj_Etat_Signal(signalCplx,jaune_cli);
        Maj_Etat_Signal(signalCplx,ral_60);      // afficher ralentissement
      end
      else   // aiguille 9 droite
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        if testBit(EtatSignalCplx[302],jaune_F) then       // si signal cplx suivant est jaune
          Maj_Etat_Signal(signalCplx,jaune_cli)
          else Maj_Etat_Signal(signalCplx,vert);
      end;
    end;
  end;


//  signal 204 ============================================================*/
  signalCplx:=204;
  PresTrain:=(aiguillage[8].position=2) and (MemZone[521,527] or MemZone[524,521])
          or ((aiguillage[8].position<>2) and (MemZone[522,527] or MemZone[514,522] or MemZone[518,514]));
  if (PresTrain=FALSE) then Maj_Etat_Signal(signalCplx,carre)        // si pas de train avant le signal, mettre au carré
  else
  begin
    if ( (MemZone[527,520] and (aiguillage[7].position<>2)) or
         (MemZone[527,519] and (aiguillage[7].position=2)) ) then // si train quitte détection signal
    begin
      if (TestBit(EtatSignalCplx[signalCplx],carre)=FALSE) then Maj_Etat_Signal(signalCplx,semaphore);
    end
    else
    begin
      if (aiguillage[7].position<>2) then                         // aiguille locale prise en pointe déviée?
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,rappel_30);      // afficher rappel ralentissement
        if (TestBit(EtatSignalCplx[176],carre)) or (testBit(EtatSignalCplx[176],semaphore)) then // si signal complexe suivant rouge
             Maj_Etat_Signal(signalCplx,jaune)
        else
             if TestBit(EtatSignalCplx[176],jaune) then                  // si signal complexe suivant est jaune
               Maj_Etat_Signal(signalCplx,jaune_cli);
      end
      else  // pas aiguille locale déviée
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        // si signal suivant est rouge
        if TestBit(EtatSignalCplx[330],carre) or testBit(EtatSignalCplx[330],semaphore) then Maj_Etat_Signal(signalCplx,jaune)
        else
        begin
          if TestBit(EtatSignalCplx[330],jaune) or TestBit(EtatSignalCplx[330],ral_30)
            or TestBit(EtatSignalCplx[330],ral_60) then // si signal suivant est jaune ou ral_30 ou 60
              Maj_Etat_Signal(signalCplx,jaune_cli)
          else Maj_Etat_Signal(signalCplx,vert);
       end;
     end;
   end;
  end;

// signal 218 ============================================================*/
signalCplx:=218;
if MemZone[525,528] or MemZone[525,535] then Maj_Etat_Signal(signalCplx,semaphore)  // si train quitte zone détection du signal
else
  // si signal suivant est rouge
  begin
    a:=(testBit(EtatSignalCplx[344],carre) or testBit(EtatSignalCplx[344],semaphore)) and (aiguillage[17].position<>2);
    b:=(testBit(EtatSignalCplx[392],carre) or testBit(EtatSignalCplx[392],semaphore)) and (aiguillage[17].position=2);
    if (a or b) then
    begin
      Maj_Etat_Signal(signalCplx,jaune);
    end
    else
    begin
      // si aiguille distante déviée
      if ( ((aiguillage[19].position<>2) or ((aiguillage[19].position=2) and (aiguillage[22].position<>2))) and (aiguillage[17].position<>2) ) then
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,ral_30);
      end
      else
      begin
        // si signal suivant jaune
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        a:=testBit(EtatSignalCplx[344],jaune) and (aiguillage[17].position<>2);
        b:=testBit(EtatSignalCplx[392],jaune) and (aiguillage[17].position=2);
        if (a or b) then
        begin
          Maj_Etat_Signal(signalCplx,jaune_cli);
        end
        else
        begin
          Maj_Etat_Signal(signalCplx,vert);
        end;
      end;
    end;
  end;

// signal 232 ============================================================*/
signalCplx:=232;
if ((aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position=2) and (aiguillage[6].position<>0)) then
begin
  if detecteur[516] then Maj_Etat_Signal(signalCplx,blanc)
    else Maj_Etat_Signal(signalCplx,blanc_cli)
end
else Maj_Etat_Signal(signalCplx,violet);

// signal 260 ============================================================*/
signalCplx:=260;
// aiguilles vers manoeuvre
//i:=index_feu(SignalCplx);
//a:=(feux[i].check.checked=true) and (aiguillage[1].position<>2) and (aiguillage[3].position<>2) and (aiguillage[5].position=2) and detecteur[518];
//b:=(aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position=2) and (aiguillage[6].position<>2);
//if (a or b) then Maj_Etat_Signal(signalCplx,blanc)     // feu blanc
//else
  begin
    // équations de présence train avant signal
    a:= MemZone[525,528] and (aiguillage[17].position<>2) and (aiguillage[10].position<>2);
    b:= MemZone[526,513] and (aiguillage[10].position<>2);
    PresTrain:=(a or b or MemZone[513,518] or MemZone[528,518]) and (aiguillage[19].position<>2);

    // équations d'aiguillages prises en talon mal positionnées
    a:=((aiguillage[1].position<>2) and (aiguillage[3].position<>2) and (aiguillage[5].position<>2));
    b:=((aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position=2) and (aiguillage[6].position=2));
    a:=false;b:=false;prestrain:=true;
    if (a or b  or (PresTrain=FALSE)) then maj_Etat_Signal(signalCplx,carre)
    else
    begin    //si train quitte zone 518
      a:=((MemZone[518,523] and (aiguillage[1].position=2)) or
          (MemZone[518,515] and (aiguillage[1].position<>2) and (aiguillage[3].position<>2)) or
          (MemZone[518,514] or MemZone[514,522]) and ((aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position<>2)));
      if a then
      begin
        if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
      end
      else
      begin
        if feux[index_feu(signalCplx)].check.checked then Maj_Etat_Signal(signalCplx,blanc)
        else
        begin
          if (aiguillage[1].position<>2) then                     // aiguille locale prise en pointe déviée?
          begin
            EtatSignalCplx[signalCplx]:=0; // raz état du signal
            Maj_Etat_Signal(signalCplx,rappel_30);      // afficher rappel ralentissement
            a:=((aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position<>2))  // vers voie 514
                 and (testBit(EtatSignalCplx[288],carre) or testBit(EtatSignalCplx[288],semaphore)) ; // si signal complexe suivant rouge
            b:=((aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position=2))  ; //ou voie en buttoir
            if (a or b) then
              Maj_Etat_Signal(signalCplx,jaune)
            else
            begin
              if testBit(EtatSignalCplx[288],jaune) then                   // si signal complexe suivant est jaune
                    Maj_Etat_Signal(signalCplx,jaune_cli);
            end;
          end
          else  // pas aiguille locale déviée
          begin
            // si signal suivant est rouge
            EtatSignalCplx[signalCplx]:=0;               // raz état du signal
            a:=(aiguillage[1].position=2) and testBit(EtatSignalCplx[190],semaphore) or testBit(EtatSignalCplx[190],semaphore_cli) or testbit(EtatSignalCplx[190],carre);
            //a:=a or (aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position=2) and (aiguillage[6].position<>2);
            //a:=a or (aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position<>2) and TestBit(EtatSignalCplx[288],semaphore) or testBit(EtatSignalCplx[288],carre);
            if a then Maj_Etat_Signal(signalCplx,jaune)
            else
            begin
              if testBit(EtatSignalCplx[190],jaune) or testBit(EtatSignalCplx[190],ral_30)
                  or testBit(EtatSignalCplx[190],ral_60) then // si signal cplx suivant est jaune ou ral_30 ou 60
                     Maj_Etat_Signal(signalCplx,jaune_cli)
                  else
                  begin
                    i:=Index_feu(signalCplx);
                    if feux[i].FeuBlanc then
                    begin
                        if feux[i].check.Checked then
                          Maj_etat_signal(signalCplx,blanc) else Maj_etat_signal(signalCplx,vert);
                    end
                    else Maj_etat_signal(signalCplx,vert);
                  end;
            end;
          end;
        end;  
      end;
    end;
  end;

// signal 274 ============================================================*/
  signalCplx:=274;
  if MemZone[524,521] then // si train quite détection du signal
    Maj_Etat_Signal(signalCplx,semaphore)
  else
  begin
    if TestBit(EtatSignalCplx[600],carre) or testBit(EtatSignalCplx[600],semaphore) then
    Maj_Etat_Signal(signalCplx,jaune)
    else
    begin
      if testBit(EtatSignalCplx[600],ral_30) or testBit(EtatSignalCplx[600],jaune) then Maj_Etat_Signal(signalCplx,jaune_cli)
         else
            Maj_Etat_Signal(signalCplx,vert);
    end;
  end;

// signal 288 =========================================================*/
signalCplx:=288;
PresTrain:=MemZone[513,531] or MemZone[528,531] or MemZone[524,531] or MemZone[518,514] or MemZone[531,518] ;
//PresTrain:=(PresTrain and (aiguillage[1].position<>2) and (aiguillage[3].position=2) and (aiguillage[4].position<>2) );
PresTrain:=PresTrain or MemZone[514,522];

if ((PresTrain=FALSE) or (aiguillage[8].position=2)) then Maj_Etat_Signal(signalCplx,carre)
else
begin
  if MemZone[522,527] then
  begin
    if TestBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore); //  sinon mettre un sémaphore}
  end
  else
  begin
    if TestBit(EtatSignalCplx[204],carre) or testBit(EtatSignalCplx[204],semaphore) then    // si signal complexe suivant est au carré ou sémaphore
    begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,jaune);       // afficher un avertissement
    end
    else
    begin
      if (aiguillage[7].position<>2) then                   // si aiguille suivante prise en pointe est déviée
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
      end
      else
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        if testBit(EtatSignalCplx[204],jaune) then              // si signal suivant est jaune
            Maj_Etat_Signal(signalCplx,jaune_cli)   // afficher un avertissement clignotant sur le signal complexe
        else Maj_Etat_Signal(signalCplx,vert);      // sinon afficher un feu vert
      end;
    end;
  end;
end;

// signal 302 ============================================================*/
signalCplx:=302;
PresTrain:=((MemZone[513,518] or MemZone[528,518] or MemZone[524,518]) and (aiguillage[1].position=2)) or MemZone[518,523] or MemZone[523,526] ;
if PresTrain=FALSE then Maj_Etat_Signal(signalCplx,carre)
else
begin
  if (MemZone[526,513] and (aiguillage[9].position=2)) or
     (MemZone[526,515] and (aiguillage[9].position<>2)) then   // si train quitte zone de détection du signal
  begin
      if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then
        Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin
    if (aiguillage[9].position<>2) then                      // si aiguille locale déviée
    begin
      EtatSignalCplx[signalCplx]:=0; // raz état du signal
      Maj_Etat_Signal(signalCplx,rappel_60);      // afficher rappel ralentissement
      if (testBit(EtatSignalCplx[316],carre) or testBit(EtatSignalCplx[316],semaphore )) then   // si signal suivant rouge
        Maj_Etat_Signal(signalCplx,jaune);
      // signal suivant jaune avec aiguille locale déviée
      if testBit(EtatSignalCplx[316],jaune) then                  // si signal cplx suivant est jaune
        Maj_Etat_Signal(signalCplx,jaune_cli);
    end
    else  // si aiguille locale non déviée
    begin
      // si signal suivant rouge
      if testBit(EtatSignalCplx[462],semaphore) or testBit(EtatSignalCplx[462],carre) then
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,jaune);
      end
      else
      begin
        // si aiguille suivante prise en pointe déviée
        if ((aiguillage[19].position<>2) or ((aiguillage[19].position=2) and (aiguillage[22].position<>2))) then
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          Maj_Etat_Signal(signalCplx,jaune);    // le ral30 est remplacé par avertissement sur ce signal
        end
        else
        // si signal suivant est jaune ou ralentissement 30
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          if (testBit(EtatSignalCplx[462],jaune) or testBit(EtatSignalCplx[462],ral_30)) then
            Maj_Etat_Signal(signalCplx,jaune_cli)
          else
            Maj_Etat_Signal(signalCplx,vert);
        end;
      end;
    end;
  end;
end;

// signal 316 ============================================================*/
signalCplx:=316;
// aiguillages vers voies de garage
if ( (aiguillage[5].position=2) and (aiguillage[3].position<>2) and (aiguillage[1].position<>2) ) or
   ( feux[index_feu(signalCplx)].check.checked) then
   begin
     if detecteur[518] then Maj_Etat_Signal(signalCplx,blanc_cli) else Maj_Etat_Signal(signalCplx,blanc) ;
   end
else
begin
  PresTrain:=MemZone[526,515] or (((MemZone[518,523] and (aiguillage[1].position=2)) or MemZone[523,526]) and (aiguillage[9].position<>2)) ;
  // équations d'aiguillages mal positionnés

  a:=((aiguillage[5].position=2) and (aiguillage[3].position=2)) or
            ((aiguillage[5].position=2) and (aiguillage[1].position=2)) or
            ((aiguillage[5].position<>2) and (aiguillage[2].position=2)) or
            ((aiguillage[5].position<>2) and (aiguillage[2].position<>2) and (aiguillage[12].position=2))  ;
  if a or (PresTrain=FALSE) then Maj_Etat_Signal(signalCplx,carre)
  else
  begin  // train quitte zone de détection du signal
    if ( (MemZone[515,517] and (aiguillage[5].position<>2)) or
         (MemZone[515,518] and (aiguillage[5].position=2)) ) then
    begin
      if TestBit(EtatSignalCplx[signalCplx],carre)=false then Maj_Etat_Signal(signalCplx,semaphore);
    end
    else
    begin
      if feux[index_feu(signalCplx)].check.checked then Maj_Etat_Signal(signalCplx,blanc)
      else
      begin
        if ( ((aiguillage[5].position<>2) and (aiguillage[2].position<>2)) and
           (testBit(EtatSignalCplx[358],carre) or testBit(EtatSignalCplx[358],semaphore)) ) then           // si signalCplx suivant est carré
            Maj_Etat_Signal(signalCplx,jaune)
         else
         if ( ((aiguillage[5].position=2) and (aiguillage[3].position<>2) and (aiguillage[1].position<>2)) and     // si signal suivant est rouge
           (testBit(EtatSignalCplx[497],carre) or testBit(EtatSignalCplx[497],semaphore)) ) then
           Maj_Etat_Signal(signalCplx,jaune)
         else
         begin
           if (((aiguillage[11].position<>2) and (aiguillage[5].position<>2)) or
               ((aiguillage[10].position<>2) and (aiguillage[5].position=2))  ) then
           // si aiguille suivante prise en pointe est déviée
             Maj_Etat_Signal(signalCplx,ral_30)      // afficher ralentissement

           else
           begin
             // si aiguille suivante en pointe est déviée
             if ((aiguillage[29].position<>2) and (aiguillage[5].position=2)) then// si aiguille suivante prise en pointe est déviée
             begin
               Maj_Etat_Signal(signalCplx,ral_60);      // afficher ralentissement 60
             end
             else
             begin
                // si signal suivant est jaune
               if ( ((aiguillage[5].position=2) and (aiguillage[3].position<>2) and (aiguillage[1].position<>2)) and
                   (testBit(EtatSignalCplx[497],jaune)) ) then
                  Maj_Etat_Signal(signalCplx,jaune_cli)
               else
               if  ( ((aiguillage[5].position<>2) and (aiguillage[2].position<>2)) and
                  (testBit(EtatSignalCplx[358],jaune)) ) then
                  Maj_Etat_Signal(signalCplx,jaune_cli)
               else
                 Maj_Etat_Signal(signalCplx,vert);
             end;
          end;
        end;
      end;
    end;
  end;
end;


signalCplx:=330;  //--------------------------------------------------------------------
a:=MemZone[521,527] or MemZone[524,521] ; // and (aiguillage[8].position=0)) ;
b:=MemZone[522,527] or MemZone[514,522] or MemZone[518,514] or MemZone[514,522]; // and (aiguillage[8].position=0)) ;  ///à voirrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
PresTrain:=MemZone[527,519] or ( (aiguillage[7].position=2) and (a or b));

// aiguilles 2 et 12 mal positionnées ou pas de train
  if (aiguillage[2].position=1) or (aiguillage[12].position=2) or (PresTrain=FALSE) then
  Maj_Etat_Signal(signalCplx,carre)          //  mettre un carré}
  else
  begin
    //if (Mem_519_517=true) then
    if MemZone[519,517] then
    begin
      if (testbit(EtatSignalCplx[signalCplx],carre)=FALSE) then  Maj_Etat_Signal(signalCplx,semaphore);   //  sinon mettre un sémaphore}
    end
    else
    begin
      if (testbit(EtatSignalCplx[358],carre)) or  (testbit(EtatSignalCplx[358],semaphore)) then   // si signal complexe suivant est au carré ou sémaphore
        Maj_Etat_Signal(signalCplx,jaune)       // afficher un avertissement
      else
      begin
        if (aiguillage[11].position<>2) then            // si aiguille suivante prise en pointe est déviée
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          Maj_Etat_Signal(signalCplx,ral_30);          // afficher ralentissement
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          if testbit(EtatSignalCplx[358],jaune) then   // si signal suivant est jaune
               Maj_Etat_Signal(signalCplx,jaune_cli)   // afficher un avertissement clignotant sur le signal complexe
          else Maj_Etat_Signal(signalCplx,vert);       // sinon afficher un feu vert
        end;
      end;
    end;
  end;


// signal 344============================================================*/
signalCplx:=344;
PresTrain:=(MemZone[525,528] or MemZone[517,525] or MemZone[534,525] or MemZone[538,525]) and (aiguillage[17].position<>2);

if (((aiguillage[10].position=2) or (aiguillage[10].position<>2) and (aiguillage[19].position=2) and
                                    (aiguillage[22].position<>2) and (aiguillage[24].position<>2))
      or (PresTrain=FALSE) )  then   // si aiguillage 10 non dévié  ou pas de train avant signal
      Maj_Etat_Signal(signalCplx,carre)                //  mettre un carré}
else
begin
  if ( (MemZone[528,518] and (aiguillage[19].position<>2))  or
       (MemZone[528,537] and (aiguillage[19].position=2) and (aiguillage[22].position=2)) or
       (MemZone[528,538] and (aiguillage[19].position=2) and (aiguillage[22].position<>2)) ) then
  begin
    if (testbit(EtatSignalCplx[signalCplx],carre)=FALSE) then Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin
    if ((aiguillage[19].position<>2) or (aiguillage[22].position<>2)) then   // aiguilles locales déviées
    begin
      EtatSignalCplx[signalCplx]:=0; // raz état du signal
      Maj_Etat_Signal(signalCplx,rappel_30);
      // si aiguilles distantes déviée ou signal distant rouge -> avertissement
      a:=((aiguillage[19].position<>2) and ((aiguillage[1].position<>2) or testBit(EtatSignalCplx[260],semaphore) or testBit(EtatSignalCplx[260],carre))) ;
      b:=((aiguillage[22].position<>2) and ((aiguillage[11].position<>2) or testBit(EtatSignalCplx[477],semaphore) or testBit(EtatSignalCplx[477],carre))) ;
      if a or b then begin Maj_Etat_Signal(signalCplx,jaune);end
      else
      begin
        // si signal suivant est jaune
        a:=((aiguillage[19].position<>2) and testbit(EtatSignalCplx[260],jaune)) ;
        b:=(((aiguillage[19].position=2) and (aiguillage[22].position=2)) and testBit(EtatSignalCplx[420],jaune)) ;
        c:=(((aiguillage[19].position=2) and (aiguillage[22].position<>2)) and testBit(EtatSignalCplx[476],jaune)) ;
        if (a or b or c) then begin Maj_Etat_Signal(signalCplx,jaune_cli);end;    // si signal complexe suivant = jaune
      end;
    end
    else
    begin  // aiguilles locales non déviées
      EtatSignalCplx[signalCplx]:=0;               // raz état du signal
      a:=((aiguillage[19].position<>2) and (testBit(EtatSignalCplx[260],carre) or testBit(EtatSignalCplx[260],semaphore))) ;
      b:=(((aiguillage[19].position=2) and (aiguillage[22].position=2)) and (testBit(EtatSignalCplx[420],carre) or testBit(EtatSignalCplx[434],semaphore))) ;
      c:=(((aiguillage[19].position=2) and (aiguillage[22].position<>2)) and (testBit(EtatSignalCplx[476],carre) or testBit(EtatSignalCplx[476],semaphore))) ;
      if (a or b or c) then // si signalCplx suivant au rouge
        Maj_Etat_Signal(signalCplx,jaune)
      else
      begin
        if aiguillage[11].position<>2 then                  // avant : 11 si aiguille suivante prise en pointe est déviée
        begin
          Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          a:=((aiguillage[19].position<>2) and testBit(EtatSignalCplx[260],jaune)) ;
          b:=((aiguillage[19].position=2) and (aiguillage[22].position=2) and testBit(EtatSignalCplx[420],jaune) ) ;
          c:=((aiguillage[19].position=2) and (aiguillage[22].position<>2) and testBit(EtatSignalCplx[476],jaune) ) ;
          if (a or b or c) then                     // si signal  suivant est jaune
             Maj_Etat_Signal(signalCplx,jaune_cli)
          else Maj_Etat_Signal(signalCplx,vert);
        end;
      end;
    end;
  end;
end;

// signal 358============================================================*/
  signalCplx:=358;
  PresTrain:=MemZone[519,517] or MemZone[515,517]  or MemZone[520,517] or MemZone[521,527] or MemZone[522,527] or
           (MemZone[527,519] and (aiguillage[7].position=2)) or
           (MemZone[526,515] and (aiguillage[9].position<>2)) or
           (MemZone[527,520] and (aiguillage[7].position<>2) and (aiguillage[20].position<>2) and (aiguillage[12].position=2)) ;
  if ((PresTrain=FALSE) or (aiguillage[18].position=2)) then Maj_Etat_Signal(signalCplx,carre)
  else
    begin
      if  MemZone[517,524] or MemZone[517,525] then
      begin
        if (testBit(EtatSignalCplx[signalCplx],carre)=FALSE) then // si train quite zone de détection du signal
               Maj_Etat_Signal(signalCplx,semaphore);
      end
      else
      begin
        if (aiguillage[11].position<>2) then                   // si aiguille locale déviée
        begin
          EtatSignalCplx[signalCplx]:=0;
          Maj_Etat_Signal(signalCplx,rappel_30);      // afficher rappel ralentissement
          if testBit(EtatSignalCplx[218],semaphore) then                     // si signal suivant rouge
            Maj_Etat_Signal(signalCplx,jaune);
          if testBit(EtatSignalCplx[218],jaune) then                  // si signal suivant est jaune
            Maj_Etat_Signal(signalCplx,jaune_cli);
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;
          if testBit(EtatSignalCplx[274],semaphore) or testBit(EtatSignalCplx[274],carre) then   // si signal suivant est jaune
             Maj_Etat_Signal(signalCplx,jaune)
          else
          begin
            if TestBit(EtatSignalCplx[274],jaune) then
              Maj_Etat_Signal(signalCplx,jaune_cli)
            else Maj_Etat_Signal(signalCplx,vert);
          end;
        end;
      end;
    end;

// signal 392 ============================================================*/
signalCplx:=392;
if MemZone[535,533] then  // si train quite détection du signal
    Maj_Etat_Signal(signalCplx,semaphore)
else
  if testBit(EtatSignalCplx[448],carre) or testBit(EtatSignalCplx[448],semaphore) then Maj_Etat_Signal(signalCplx,jaune)
    else
        if testBit(EtatSignalCplx[448],ral_30) or testBit(EtatSignalCplx[448],jaune) then Maj_Etat_Signal(signalCplx,jaune_cli)
         else
            Maj_Etat_Signal(signalCplx,vert_cli);



// signal 420 ===================================================================
// signal regroupant 3 voies à revoir
// numéro de la voie en fonction de le position de l'aiguillage
if (aiguillage[25].position=2) then num_voie:=1 else
   if (aiguillage[27].position=2) then num_voie:=2 else num_voie:=3;
signalCplx:=420;

PresTrain:=(num_voie<=2) and MemZone[527,520] and (aiguillage[7].position<>2);
PresTrain:=((num_voie=1) and MemZone[520,529]) or PresTrain;
PresTrain:=((num_voie=2) and MemZone[520,530]) or PresTrain;
PresTrain:=((MemZone[521,527] or MemZone[522,527]) and (aiguillage[7].position<>2)) or PresTrain;
PresTrain:=((num_voie=3) and (MemZone[513,537] or (MemZone[526,513] and (aiguillage[10].position=2) and (aiguillage[19].position=2) and   (aiguillage[22].position=2)) or MemZone[528,537] or MemZone[524,537])) or PresTrain;

//if (((Mem_520_529) &&(num_voie!=1)) || ((Mem_520_530) && (num_voie!=2)) ||
//    ((Mem_528_537 || Mem_513_537 || Mem_524_537) &&(num_voie!=3))
//     && (aiguillage[31]!=0) ||
if (PresTrain=FALSE) then Maj_Etat_Signal(signalCplx,carre)
else
begin
  if (   ((num_voie=1) and MemZone[529,534])  or
         ((num_voie=2) and MemZone[530,534])  or
         ((num_voie=3) and MemZone[537,534])  ) then
  begin
    if TestBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin
    if testBit(EtatSignalCplx[406],semaphore) or testBit(EtatSignalCplx[406],carre) then     // si signal cplx suivant est rouge      Maj_Etat_Signal(signalCplx,jaune);
    else
    begin
      if aiguillage[11].position<>2 then  // si aiguille suivante est déviée
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        Maj_Etat_Signal(signalCplx,ral_30) ;
      end
      else
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        if testBit(EtatSignalCplx[406],jaune_F) or testBit(EtatSignalCplx[406],ral_60_F) then //si signal cplx suivant est jaune ou ralentissement-----------          Maj_Etat_Signal(signalCplx,jaune_cli);
        else Maj_Etat_Signal(signalCplx,vert);
      end;
    end;
  end;
end;


// signal 448 ===================================================================
  signalCplx:=448;
  PresTrain:=(MemZone[517,525] and (aiguillage[17].position=2)) or MemZone[525,535] or MemZone[535,533];
  if (aiguillage[24].position=2) or (PresTrain=FALSE) then Maj_Etat_Signal(signalCplx,carre)
  else
    begin
      if MemZone[533,538] then  //si train quitte zone de détection du signal
      begin
        if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
      end
      else
      begin
        if testBit(EtatSignalCplx[476],carre) or testBit(EtatSignalCplx[476],semaphore) then // si signal suivant rouge
        begin
          Maj_Etat_Signal(signalCplx,jaune);
        end
        else
        begin
          if (aiguillage[11].position<>2) then                   // si aiguille suivante prise en pointe est déviée
          begin
              EtatSignalCplx[signalCplx]:=0;               // raz état du signal
              Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
          end
          else
          begin  // cas si aiguille suivante prise en pointe pas déviée
            EtatSignalCplx[signalCplx]:=0;               // raz état du signal
            if testBit(EtatSignalCplx[476],jaune) then  //si signal suivant est jaune-----------
                  Maj_Etat_Signal(signalCplx,jaune_cli)
                      else Maj_Etat_Signal(signalCplx,vert);
          end;
     end;
   end;
end;

// signal 462 ============================================================*/
signalCplx:=462;
PresTrain:=MemZone[526,513] or ((MemZone[523,526] or MemZone[518,523]) and (aiguillage[9].position=2)) ;
// si aiguillages pris en talon mal positionnés  ou pas de train avant signal
if (aiguillage[10].position<>2) or (aiguillage[29].position<>2) or (PresTrain=FALSE) then
      Maj_Etat_Signal(signalCplx,carre)                //  mettre un carré}
else
begin
  // si présence train après le signal (3 directions à tester) et signal <> carré
  if ( MemZone[513,518] and (aiguillage[19].position<>2)) or
     ( MemZone[513,537] and (aiguillage[19].position=2) and (aiguillage[22].position=2)) or
     ( MemZone[513,538] and (aiguillage[19].position=2) and (aiguillage[22].position<>2))  then
  begin
     if TestBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin
    if (aiguillage[19].position<>0) or (aiguillage[22].position<>2) then  // si aiguilles locales déviées
    begin
      EtatSignalCplx[signalCplx]:=0; // raz état du signal
      Maj_Etat_Signal(signalCplx,rappel_30);
      // si aiguilles distantes déviées ou signal distant rouge -> avertissement
      a:=(aiguillage[19].position<>2) and ((aiguillage[1].position<>2) or testBit(EtatSignalCplx[260],semaphore) or testBit(EtatSignalCplx[260],carre));
      b:=(aiguillage[22].position<>2) and ((aiguillage[11].position<>2) or testBit(EtatSignalCplx[477],semaphore) or testBit(EtatSignalCplx[477],carre));
      if (a or b) then
         Maj_Etat_Signal(signalCplx,jaune)
      else
      begin // si signal distant est jaune
        a:=((aiguillage[19].position<>2) and testBit(EtatSignalCplx[260],jaune)) ;
        b:=(((aiguillage[19].position=2) and (aiguillage[22].position=2)) and testbit(EtatSignalCplx[420],jaune)) ;
        c:=(((aiguillage[19].position=2) and (aiguillage[22].position<>2)) and testbit(EtatSignalCplx[476],jaune)) ;
        if (a or b or c) then Maj_Etat_Signal(signalCplx,jaune_cli);     // si signal complexe suivant = jaune
      end;
    end
    else
    begin // aiguilles locales en position droite
      EtatSignalCplx[signalCplx]:=0;               // raz état du signal
      a:=((aiguillage[19].position<>0) and testBit(EtatSignalCplx[260],carre) or TestBit(EtatSignalCplx[260],semaphore)) ;
      b:=(((aiguillage[19].position<>0) and (aiguillage[22].position=2)) and TestBit(EtatSignalCplx[420],carre) or TestBit(EtatSignalCplx[434],semaphore)) ;
      c:=(((aiguillage[19].position=2) and (aiguillage[22].position<>0)) and testbit(EtatSignalCplx[476],carre) or TestBit(EtatSignalCplx[476],semaphore)) ;
      if (a or b or c) then  // si signalCplx suivant au rouge
        Maj_Etat_Signal(signalCplx,jaune)
      else
      begin
        //  aiguilles locales en position droite
        if (aiguillage[11].position<>2) then                   // si aiguille suivante prise en pointe est déviée
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          a:=((aiguillage[19].position<>2) and TestBit(EtatSignalCplx[260],jaune)) ;
          b:=((aiguillage[19].position=2) and (aiguillage[22].position=2) and TestBit(EtatSignalCplx[420],jaune) ) ;
          c:=((aiguillage[19].position=2) and (aiguillage[22].position<>2) and TestBit(EtatSignalCplx[476],jaune) ) ;
          if (a or b or c) then                     // si signal CDM suivant est jaune
             Maj_Etat_Signal(signalCplx,jaune_cli)
          else Maj_Etat_Signal(signalCplx,vert);
        end;
      end;
    end;
  end;
end;

// signal 476 ============================================================*/
  signalCplx:=476;
  PresTrain:=MemZone[533,538] or MemZone[535,533] or MemZone[525,535];
  PresTrain:=MemZone[528,538] or MemZone[513,538] or MemZone[524,538] or PresTrain;

  if ((((aiguillage[23].position<>2) or (aiguillage[18].position<>2)) or
          ((aiguillage[30].position<>2) or (aiguillage[11].position=2) or (aiguillage[23].position=2)) ) or (PresTrain=FALSE)) then   Maj_Etat_Signal(signalCplx,carre)
  else
  begin
    if MemZone[538,524] or MemZone[538,525] then //si train quitte signal
    begin
      if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
    end
    else
    begin
      if (aiguillage[11].position<>2) then                    // si aiguille locale déviée
      begin
        EtatSignalCplx[signalCplx]:=0; // raz état complet
        Maj_Etat_Signal(signalCplx,rappel_30);      // afficher rappel ralentissement
        if testBit(EtatSignalCplx[218],semaphore) then                     // si signal suivant rouge
                  Maj_Etat_Signal(signalCplx,jaune)
        else
        begin
          if testbit(EtatSignalCplx[218],jaune) or testBit(EtatSignalCplx[218],ral_30) then // si signal suivant est jaune ou ral30                  begin Maj_Etat_Signal(signalCplx,jaune_cli);end;
        end;
      end
      else
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz état du signal
        if testbit(EtatSignalCplx[274],jaune) then                     // si signal suivant est jaune
                Maj_Etat_Signal(signalCplx,jaune_cli)
        else Maj_Etat_Signal(signalCplx,vert);
      end;
    end;
  end ;

  // signal 497 ============================================================*/
  signalCplx:=497;
  //memZone[523,518]:=true;
  PresTrain:=MemZone[518,531] or MemZone[523,518] or MemZone[515,518] or MemZone[514,518] or 
             MemZone[526,523];
  //PresTrain:=true;
  //if PresTrain then Affiche('prestrain',clorange);
  // équations aiguillages mal positionnés
  if ((aiguillage[19].position<>1) or  // 1 = dévié
     ((aiguillage[19].position=1) and (aiguillage[10].position=2) and (aiguillage[29].position=1) and (aiguillage[30].position<>1)) or
      (PresTrain=FALSE)) then
        Maj_Etat_Signal(signalCplx,carre)
  else
  begin
    if MemZone[531,528] or MemZone[531,528] or MemZone[531,513] or MemZone[531,524] then //si train quitte signal
    begin
      if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
    end
    else
    begin
      if (aiguillage[10].position<>2) then                    // si aiguille locale déviée
      begin
        EtatSignalCplx[signalCplx]:=0; // raz état complet
        Maj_Etat_Signal(signalCplx,rappel_30);      // afficher rappel ralentissement
        //if testBit(EtatSignalCplx[xx],semaphore) then                     // si signal suivant rouge
        //          Maj_Etat_Signal(signalCplx,jaune)
        //else
        //begin
        //  if testbit(EtatSignalCplx[218],jaune) or testBit(EtatSignalCplx[218],ral_30) then // si signal suivant est jaune ou ral30        //          begin Maj_Etat_Signal(signalCplx,jaune_cli);end;
        //end;
      end
      else
      if (aiguillage[29].position<>2) then
      begin
        EtatSignalCplx[signalCplx]:=0; // raz état complet
        Maj_Etat_Signal(signalCplx,rappel_60);      // afficher rappel ralentissement
        if testBit(EtatSignalCplx[274],semaphore) then                     // si signal suivant rouge
                 Maj_Etat_Signal(signalCplx,jaune)
           else if testbit(EtatSignalCplx[274],jaune) then // si signal suivant est jaune ou ral30
                  begin Maj_Etat_Signal(signalCplx,jaune_cli);end;
      end
      else
      begin  // aiguilles locales non déviées
        //EtatSignalCplx[xx]:=0;               // raz état du signal
        //if testbit(EtatSignalCplx[xx],jaune) then                     // si signal suivant est jaune
        //        Maj_Etat_Signal(signalCplx,jaune_cli)
        //else
        Maj_Etat_Signal(signalCplx,vert);
      end;
    end;
  end ;


// signal 600 =====================================================*/
signalCplx:=600;
PresTrain:=MemZone[524,521] or MemZone[517,524] or MemZone[538,524] or MemZone[534,524];

//if ((aiguillage[8].position<>2) or (PresTrain=FALSE)) then  Maj_Etat_Signal(signalCplx,carre)
//else
  begin
    if MemZone[521,527] then
    begin
       if (testBit(EtatSignalCplx[signalCplx],carre)=FALSE) then Maj_Etat_Signal(signalCplx,semaphore);
    end
    else
    begin
      if testBit(EtatSignalCplx[204],semaphore) or testBit(EtatSignalCplx[204],carre) then     // si signal cplx suivant est rouge
        Maj_Etat_Signal(signalCplx,jaune)
      else
      begin
        if (aiguillage[7].position<>2) then// si aiguille suivante est déviée
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          Maj_Etat_Signal(signalCplx,ral_30) ;
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz état du signal
          if TestBit(EtatSignalCplx[204],jaune) or testBit(EtatSignalCplx[204],ral_60) then                 //si signal cplx suivant est jaune ou ralentissement-----------
            Maj_Etat_Signal(signalCplx,jaune_cli)
            else Maj_Etat_Signal(signalCplx,vert);
        end;
      end;
    end;
  end;

end;  // de la procédure pilote signaux

// pilotage d'un signal
procedure envoi_signal(Adr : integer);
var i : integer;
begin
  i:=index_feu(Adr);
  if feux[i].aspect<10 then 
    case feux[i].decodeur of
     0 : envoi_virtuel(Adr);
     1 : envoi_signalBahn(Adr);
     2 : envoi_CDF(Adr);
     3 : envoi_LDT(Adr);
     4 : envoi_LEB(Adr);
     5 : envoi_NMRA(Adr);
     6 : envoi_UniSemaf(Adr);
     end;
end;

// pilotage des signaux
procedure envoi_signauxCplx;
var i,signalCplx : integer;
begin
  //Affiche('Envoi des signaux (envoi_signaixCplx)',ClGreen);
  //chaque signal doit être appellé en fonction de sa procédure suivant le décodeur
  for i:=1 to NbreFeux do
  begin
   signalCplx:=feux[i].adresse;
   if not(ferme) and (signalCplx<>0) then envoi_signal(signalCplx);
  end;
end;

function virgule_suiv(sl : string;o : integer) : integer;
var k : integer;
begin
  o:=o+1;
  for k:=o to length(sl) do
  begin
   // Affiche(sl[k],clGreen);
    if sl[k]=',' then begin result:=k;exit;end;
  end;
  result:=0;
end;


// trouve l'enregistrement suivant après l'offset dans une branche
// en sortie : trouve_enregistrement= nouvel offset, enregistrement
// si 0 en sortie: fin de ligne
function trouve_enregistrement_suiv(num_branche : integer;offset : integer) : integer;
var j : integer;
    ss : string;
begin
  //Affiche(branche[num_branche],clWhite);
  j:=virgule_suiv(branche[Num_Branche],offset);    // pointe sur la virgule suivante
  //Affiche('virgule suivante j='+IntToStr(j),ClOrange);
  //Affiche(' j='+IntToStr(j),ClOrange);
  if j<>0 then ss:=copy(branche[Num_Branche],offset,j-offset) // champ suivant
        else ss:=copy(branche[Num_Branche],offset,length(branche[Num_Branche])-offset+1); // si j=0 c'est la fin de la chaîne
  //affiche(ss,clGreen);
  enregistrement:=ss;
  if j=0 then result:=0 else result:=j+1;
end;

// trouve l'index d'un détecteur dans une branche
// si pas trouvé, renvoie 0
function index_detecteur(det,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse;
        trouve:=(det=adr) and ((BrancheN[Num_Branche,i].Btype=1) or (BrancheN[Num_branche,i].BType=4)); // cherche un détecteur
        //Affiche('cherche='+intToSTR(det)+'/explore='+intToSTR(adr)+' Branche='+intToStr(Num_branche)+' index='+intToStr(i),ClWhite);
        if not(trouve) then inc(i);
        //if trouve then Affiche('Trouvé en branche'+IntToSTR(Num_branche)+' index='+IntToSTR(i),clGreen);
      until trouve or (adr=0) ;
    end;
begin
  i:=1;index2_det:=0;
  recherche;
  if trouve then result:=i else result:=0;
  //affiche(inttostr(ai+1),clOrange);
  i:=2; // à voir
  //affiche('------------------------',clWhite);
  recherche;
  //affiche('------------------------',clGreen);
  if trouve then index2_det:=i else index2_det:=0;
  //affiche('index2='+IntToSTR(index2_det),clWhite);
end;


// si pas trouvé, IndexBranche_trouve=0
procedure trouve_detecteur(detecteur : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  i:=1;
  repeat
    i:=index_detecteur(detecteur,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  // if (i<>0) and traceDet then Affiche('Détecteur trouvé en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;


procedure lit_config;
var s,sa,chaine,SOrigine: string;
    c,paig : char;
    tec,bistec,tjd,tjs,s2,trouve,triple,debugConfig,multiple,fini,finifeux : boolean;
    bd,virgule,i_detect,i,erreur,aig,detect,offset,index, adresse,j,position,temporisation,invers,indexPointe,indexDevie,indexDroit,
    ComptEl,Compt_IT,Num_Element,k,modele,aig2,adr,erreur2,l,t,bis : integer;
    function lit_ligne : string ;
    begin
      repeat
        readln(fichier,s);
        s:=uppercase(s);
        //Affiche(s,clWhite);
        if length(s)>0 then c:=s[1];
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      lit_ligne:=s;
    end;
begin
  debugConfig:=false;
  // initialisation des aiguillages avec des valeurs par défaut
  for i:=1 to MaxAcc do
  begin
    Aiguillage[i].modele:=0  ;  //  sans existence
    Aiguillage[i].position:=9;  // position inconnue
    Aiguillage[i].temps:=5   ;
    Aiguillage[i].inversion:=0;
    Aiguillage[i].inversionCDM:=0;
    Aiguillage[i].objet:=0;
  end;
  for i:=1 to 1024 do
  begin
     Detecteur[i]:=false;
     Ancien_detecteur[i]:=false;
  end;
  //ChDir(s);
  Affiche('lecture du fichier de configuration client-GL.cfg',clyellow);
  try
    assign(fichier,'client-GL.cfg');
    reset(fichier);
  except
    Affiche('Fichier client-gl.cfg non trouvé',clred);
  end;

  {lecture du fichier de configuration}
  // taille de fonte
  s:=lit_ligne;
  i:=StrToINT(s);
  with FormPrinc.ListBox1 do
  begin
    Font.Height:=i;
    ItemHeight:=i+1;
  end;
  // adresse ip et port de CDM

  s:=lit_ligne;
  i:=pos(':',s);
  if i<>0 then begin adresseIPCDM:=copy(s,1,i-1);Delete(s,1,i);portCDM:=StrToINT(s);end;


  // adresse ip et port de la centrale
  // AfficheDet:=true;
  s:=lit_ligne;
  i:=pos(':',s);
  if i<>0 then begin adresseIP:=copy(s,1,i-1);Delete(s,1,i);port:=StrToINT(s);end
  else begin adresseIP:='0';parSocket:=false;end;

  // configuration du port com
  s:=lit_ligne; // COM3:57600,N,8,1,2
  if not(config_com(s)) then Affiche('Erreur port com mal déclaré : '+s,clred);
  portcom:=s;

  // temporisation entre 2 caractères
  s:=lit_ligne;
  val(s,TempoOctet,erreur);
  if erreur<>0 then Affiche('Erreur temporisation entre 2 octets',clred);

  // temporisation attente maximale interface
  s:=lit_ligne;
  val(s,TimoutMaxInterface,erreur);
  if erreur<>0 then Affiche('Erreur temporisation maximale interface',clred);

  //entete
  s:=lit_ligne;
  val(s,Valeur_entete,erreur);
  entete:='';
  case Valeur_entete of
   0 : begin entete:='';suffixe:='';end;
   1 : begin entete:=#$FF+#$FE;suffixe:='';end;
   2 : begin entete:=#228;suffixe:=#13+#13+#10;end;
  end;
  if (erreur<>0) or (valeur_entete>2) then Affiche('Erreur déclaration variable entete',clred);


  //avec ou sans initialisation des aiguillages
  s:=lit_ligne;
  AvecInitAiguillages:=StrToINT(s);

  //Affiche('Valeurs d''initialisation des aiguillages',clyellow);
  //initialisation aiguillages
  repeat
    s:=lit_ligne;
    j:=pos(',',s);
    if j>1 then
    begin
      adresse:=StrToINT(copy(s,1,j-1));Delete(s,1,j); // adresse aiguillage
      if (adresse>0) then
      begin
        j:=pos(',',s);
        position:=StrToInt(copy(s,1,j-1));Delete(S,1,j);// position aiguillage
        if (position<1) or (position>2) then position:=1;
        aiguillage[adresse].position:=position;
        aiguillageB[adresse].position:=position;

        // temporisation aiguillage
        j:=pos(',',s);if j=0 then j:=length(s);
        val(s,temporisation,erreur);Delete(S,1,j);
        if (temporisation<0) or (temporisation>10) then temporisation:=5;
        aiguillage[adresse].temps:=temporisation;
        aiguillageB[adresse].temps:=temporisation;

        val(s,invers,erreur);
        if (invers<0) or (invers>1) then invers:=0;   // inversion commande
        aiguillage[adresse].inversion:=invers;
        aiguillageB[adresse].inversion:=invers;
        
      end;
    end;
  until (adresse=0);

  closefile(fichier);

  Affiche('lecture du fichier de configuration config.cfg',clyellow);
  try
    assign(fichier,'config.cfg');
    reset(fichier);
  except
    Affiche('Fichier config.cfg non trouvé',clred);
  end;

  s:=Lit_ligne;  //variable log non utilisée
  s:=Lit_ligne; // trace_det
  s:=Lit_ligne; // raz signaux
  Raz_Acc_signaux:=pos('1',s)<>0;
  if Raz_Acc_signaux then Affiche('Avec Raz commande signaux',clYellow);
  Affiche('Définition des aiguillages',clyellow);

  // définition des aiguillages dans les branches
  maxaiguillage:=0;
  repeat
    s:=lit_ligne;sOrigine:=s;
    //chaine:=s;
    if debugconfig then Affiche(s,ClLime);
    if (s<>'0') then
    begin
      virgule:=pos(',',s);
      enregistrement:=copy(s,1,virgule-1);  // adresse de l'aiguillage [TRI]
      delete(s,1,virgule);
      triple:=pos('TRI',enregistrement)<>0;
      if pos('B',enregistrement)<>0 then bis:=1 else bis:=0;
      tjd:=pos('TJD',enregistrement)<>0;
      tjs:=pos('TJS',enregistrement)<>0;
      // adresse de l'aiguillage
      Val(enregistrement,aig,erreur); // aig = adresse de l'aiguillage
      if aig>maxaiguillage then maxaiguillage:=aig;
      if debugConfig then Affiche('Adresse='+IntToSTR(aig)+' enregistrement='+Enregistrement,clyellow);

      if bis=0 then begin aiguillage[aig].AdroitB:='Z'; aiguillage[aig].AdevieB:='Z'; aiguillage[aig].ApointeB:='Z'; aiguillage[aig].Adevie2B:='Z';end
                   else begin aiguillageB[aig].AdroitB:='Z';aiguillageB[aig].AdevieB:='Z';aiguillageB[aig].ApointeB:='Z';aiguillageB[aig].Adevie2B:='Z';end ;

      if (triple) then aiguillage[aig].modele:=4;
      if (tjs) then
      begin
      if bis=0 then aiguillage[aig].modele:=3
          else aiguillageB[aig].modele:=3;
      end;
      if (tjd) then
      begin
      if bis=0 then aiguillage[aig].modele:=2
              else aiguillageB[aig].modele:=2;
      end;
      if not(tjs) and not(tjd) and not(triple) then
      begin
        if bis=0 then aiguillage[aig].modele:=1
             else aiguillageB[aig].modele:=1;
      end;
      //if debugConfig then Affiche(s,clyellow);

      if (triple) then
      begin
        Val(s,aig2,erreur); // aig = 2eme adresse de l'aiguillage
        aiguillage[aig].AdrTriple:=aig2;
        virgule:=pos(',',s);
        delete(s,1,virgule);
      end;
      ComptEl:=0;Compt_It:=0;Num_element:=Num_element+1;
      // préparer l'enregistrement pour la boucle de ligne
      virgule:=pos(',',s);
      enregistrement:=copy(s,1,virgule-1);
      delete(s,1,virgule);

      repeat  // parcoure la ligne
        if (debugConfig) then Affiche('boucle de ligne: '+s,clYellow);

        if (length(enregistrement)<>0) then
        if (enregistrement[1]='P') then
        begin
          if debugconfig then Affiche('Section P - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          delete(enregistrement,1,1); // supprime le P
          detect:=0;
          Val(enregistrement,detect,erreur);
          if erreur<>0 then delete(enregistrement,1,erreur-1);
          //if ((aig=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section P: '+chaine,clRed);
          if (erreur=0) then enregistrement:=copy(s,1,virgule-1);
          if bis=0 then aiguillage[aig].Apointe:=detect else aiguillageB[aig].Apointe:=detect;
          if (erreur<>0) then // si erreur<>0 peut être un B ou un S ou un ,
          begin
            if (enregistrement[1]='B') then
            begin
              if bis=0 then aiguillage[aig].ApointeBis:=1 else aiguillageB[aig].ApointeBis:=1;
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connecté a aiguillage BIS'+s,clYellow);
            end;
            if bis=0 then aiguillage[aig].ApointeB:=enregistrement[1] else aiguillageB[aig].ApointeB:=enregistrement[1];
            delete(enregistrement,1,1);
            Num_element:=Num_element+1;
          end;
          virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
          enregistrement:=copy(s,1,virgule-1);
          delete(s,1,virgule);
        end;

        if (length(enregistrement)<>0) then  // section droite
        if (enregistrement[1]='D') then
        begin
          if debugconfig then Affiche('Section D - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          delete(enregistrement,1,1); // supprime le P
          Val(enregistrement,detect,erreur);
          if erreur<>0 then delete(enregistrement,1,erreur-1);
          if debugconfig then Affiche(enregistrement,clyellow);
          //if ((aig=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section D: '+chaine,clRed);
          if (erreur=0) then enregistrement:='';
          if bis=0 then aiguillage[aig].Adroit:=detect else aiguillageB[aig].Adroit:=detect;
          if (erreur<>0) then // si erreur<>0 peut être un B ou un S ou un ,
          begin
            if (enregistrement[1]='B') then
            begin
              if bis=0 then aiguillage[aig].AdroitBis:=1 else aiguillageB[aig].AdroitBis:=1;
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connecté a aiguillage BIS'+s,clYellow);
            end;
            if (enregistrement[1]<>',') then  // copier si c'est S P D
            begin
              if bis=0 then aiguillage[aig].AdroitB:=enregistrement[1] else aiguillageB[aig].AdroitB:=enregistrement[1];
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connecté a aiguillage BIS'+s,clYellow);
            end;
            delete(enregistrement,1,1);
            Num_element:=Num_element+1;
          end;
          virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
          enregistrement:=copy(s,1,virgule-1);
          delete(s,1,virgule);
        end;

        if (length(enregistrement)<>0) then
        if (enregistrement[1]='S') then
        begin
          if debugconfig then Affiche('Section S - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          delete(enregistrement,1,1); // supprime le S
          erreur:=pos('2-',enregistrement);
          S2:=erreur<>0;
          if (S2) then delete(enregistrement,erreur,2);

          erreur:=pos('S2',enregistrement); // description d'un rattachement à la branche S2 d'un aiguillage triple
          tec:=erreur<>0;  // ne supprimer que le 2
          if (tec) then delete(enregistrement,erreur+1,1);

          erreur:=pos('B',enregistrement);  // description d'un rattachement connecté à un aiguillage bis
          bistec:=erreur<>0;
          if (bistec) then delete(enregistrement,erreur,1); // ne supprime que le B
          val(enregistrement,detect,erreur);  //  extraction de l'adresse
          //if ((detect=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section S: '+s,clred);
          c:='Z';
          if (erreur<>0) then begin delete(enregistrement,1,erreur-1);c:=enregistrement[1];end;

          if (bis=0) and not(bistec) and not(S2) and not(tec) then begin aiguillage[aig].Adevie:=detect;aiguillage[aig].AdevieB:=c;end;
          if (bis=0) and not(bistec) and     S2  and not(tec) then begin aiguillage[aig].Adevie2:=detect;aiguillage[aig].Adevie2B:=c;end;
          if (bis=0) and not(bistec) and     S2  and     tec  then begin aiguillage[aig].Adevie2:=detect;aiguillage[aig].Adevie2B:='T';end;
          if (bis=0) and    (bistec) and not(S2) and not(tec) then begin aiguillage[aig].Adevie:=detect;aiguillage[aig].AdevieBis:=1;aiguillage[aig].AdevieB:=c;end;

          if (bis=1) and not(bistec) and not(S2) and not(tec) then begin aiguillageB[aig].Adevie:=detect;aiguillageB[aig].AdevieB:=c;end;
          if (bis=1) and not(bistec) and     S2  and not(tec) then begin aiguillageB[aig].Adevie2:=detect;aiguillageB[aig].Adevie2B:=c;end;
          if (bis=1) and not(bistec) and     S2  and     tec  then begin aiguillageB[aig].Adevie2:=detect;aiguillageB[aig].Adevie2B:='T';end;
          if (bis=1) and    (bistec) and not(S2) and not(tec) then begin aiguillageB[aig].Adevie:=detect;aiguillageB[aig].AdevieBis:=1;aiguillageB[aig].AdevieB:=c;end;

          virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
          enregistrement:=copy(s,1,virgule-1);
          delete(s,1,virgule);
        end;

        // si vitesse définie
        Val(enregistrement,adr,erreur);
        if erreur=0 then
        begin
          aiguillage[aig].vitesse:=adr;
          enregistrement:='';
          virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
          enregistrement:=copy(s,1,virgule-1);
          delete(s,1,virgule);
        end;

        // si inversion aiguillage BIS pour parer à bug CDM aiguillage
        Val(enregistrement,adr,erreur);
        if erreur=0 then
        begin
          if bis=0 then 
          begin
            Affiche('Avertissement: le paramètre de lecture inversée de la position pour l''aiguillage non bis '+intToSTR(aig)+' sera ignorée',clOrange);
          end;
          if bis=1 then aiguillageB[aig].inversionCDM:=adr;
          
          enregistrement:='';
        end;

      until enregistrement='' ;
    end;
  until (s='0');
  //Affiche(IntToSTR(maxaiguillage)+' Aiguillages',clYellow);


  Affiche('définition des branches',clyellow);
  // branches de réseau
  NDetecteurs:=0;
  i:=1;i_detect:=1;
  repeat
    s:=lit_ligne;
    //Affiche(s,clWhite);
    //adresse:=pos('0',s);
    //s:='A16B,557,0'  ;
    if s<>'0' then
    begin
      branche[i]:=s;
      j:=1;offset:=1;
      repeat
        BrancheN[i,j].adresse:=0; // préparer le suivant à 0
        offset:=trouve_enregistrement_suiv(i,offset) ;
        // décoder l'enregistrement
        // si c'est un détecteur, fini trouvé
        //affiche(enregistrement,clred);
        Val(enregistrement,detect,erreur);      // détermine si le champ est numérique ou pas  (cad si aiguillage)
        //Affiche(enregistrement+'detect='+intToSTR(detect),clyellow);

        // il y a un aiguillage   ou un espace après le champ....en fin de ligne
        if erreur<>0 then
        begin
          c:=enregistrement[1];
          delete(enregistrement,1,1);
          if c='A' then
           begin
              Val(enregistrement,adresse,erreur2);
              //Affiche(IntToSTR(adresse),clyellow);
              BrancheN[i,j].adresse:=adresse;
              k:=pos('B',enregistrement);
              if k=0 then BrancheN[i,j].btype:=2 else BrancheN[i,j].btype:=3; // ident aiguillage
           end
           else erreur:=0; // forcer erreur à 0 pour obliger à passer sur un détecteur
        end;

        // détecteur
        if erreur=0 then
        begin
           //Affiche(IntToSTR(detect),clyellow);
          //Affiche(s,clorange); Affiche(IntToStr(detect),clorange);
          BrancheN[i,j].adresse:=detect;          // adresse
          BrancheN[i,j].btype:=1;// ident détecteur
          if detect=0 then begin BrancheN[i,j].btype:=4;end; // buttoir
          //if j=1 then Affiche('Erreur la ligne doit commencer par un aiguillage: '+s,clred);
          //if (offset=-1) then Affiche('Erreur la ligne soit se terminer par un aiguillage:'+s,clred);
          // vérifier si le détecteur est déja stocké
          bd:=0;
          repeat
            inc(bd);
            trouve:=Adresse_detecteur[bd]=detect;
          until ((bd=NDetecteurs+1) or trouve) ;
          if not(trouve) then
          begin
            Adresse_detecteur[bd]:=detect;
            NDetecteurs:=bd;
          end;
        end;
        inc(j);
        BrancheN[i,j].adresse:=0; // préparer le suivant à 0
        //Affiche('branche '+intToSTR(i)+' index='+intToStr(j),clGreen);
      until (offset=0);
      inc(i);
    end;
  until (s='0');
  NbreBranches:=i-1;
 // Affiche(IntToSTR(NbreBranches)+' branches',clYellow);

  // feux
  Affiche('Définition des feux',clyellow);
  i:=1;
  repeat
    s:=lit_ligne;
    if s<>'0' then
    begin
      chaine:=s;
      //Affiche(s,clYellow);
      finifeux:=s[1]='0';
      if not(finifeux) then
      begin
      chaine:=s;
      j:=pos(',',s);
      if j>1 then
      begin
        adresse:=StrToINT(copy(s,1,j-1));Delete(s,1,j); // adresse de feu
        feux[i].adresse:=adresse;
        j:=pos(',',s);
        if j>1 then
        begin
          sa:=copy(s,1,j-1);
          if sa[1]='D' then
          // feu directionnel
          begin
            delete(sa,1,1);
            j:=pos(',',s);
            l:=StrToInt(sa); // nombre de feux du signal directionnel
            if l>6 then
            begin
              Affiche('Ligne '+s+' 6 feux maximum pour un panneau directionnel',clred);
              exit;
            end;
            feux[i].aspect:=l+10;Delete(s,1,j);
            // décodeur
            val(s,adr,erreur);
            Feux[i].decodeur:=adr;
            j:=pos(',',s);Delete(s,1,j);
            //Affiche(s,clYellow);
            //s:='(A19D,A22D)(A19D,A22S)';
            // liste des aiguillages
            k:=1; // numéro de feu directionnel
            repeat
              // boucle de direction
              delete(s,1,1); // supprimer ( ou le ,
              j:=1; // Nombre de descriptions d'aiguillages dans le feu
              //Affiche('Boucle de Ligne',clyellow);
              //Affiche(s,clOrange);
              repeat
                //Affiche('Boucle de direction',clyellow);
                //Affiche(s,clOrange);
                if s[1]<>'A' then begin Affiche('Erreur a la ligne',clred);exit;end;
                delete(s,1,1);
                val(s,adr,erreur);  // adresse
                c:=s[erreur];       // type
                setlength(feux[i].AigDirection[k],j+1);  // auglenter le tableau dynamique
                feux[i].AigDirection[k][j].PosAig:=c;
                feux[i].AigDirection[k][j].Adresse:=adr;

               // Affiche(intToSTR(Adr)+c,clyellow);
              //  Affiche(intToSTR(erreur),clOrange);
                delete(s,1,erreur);   // supprime jusque S
                //Affiche(s,clLime);
                if s[1]=',' then delete(s,1,1);
                inc(j);
              until s[1]=')';
              delete(s,1,1);
              inc(k);
            until length(s)<1;
            dec(k);
            if k<>l+1 then
            begin
              Affiche('Ligne '+chaine,clred);
              Affiche('Nombre incorrect de description des aiguillages: '+intToSTR(k)+' pour '+intToSTR(l)+' feux directionnels',clred);
            end;

          end
          else
          // feu de signalisation
          begin
            feux[i].aspect:=StrToInt(sa);Delete(s,1,j);
            j:=pos(',',s);
            if j>1 then begin Feux[i].FeuBlanc:=(copy(s,1,j-1))='1';delete(s,1,j);end;
            j:=pos(',',s);
            if j=0 then begin Feux[i].decodeur:=StrToInt(s);end else begin Feux[i].decodeur:=StrToInt(copy(s,1,j-1));delete(s,1,j);end;
            feux[i].Adr_el_suiv1:=0;feux[i].Adr_el_suiv2:=0;feux[i].Adr_el_suiv3:=0;feux[i].Adr_el_suiv4:=0;
            feux[i].Btype_Suiv1:=0;feux[i].Btype_Suiv2:=0;feux[i].Btype_Suiv3:=0;feux[i].Btype_Suiv4:=0;
            feux[i].Adr_det1:=0;feux[i].Adr_det2:=0;feux[i].Adr_det3:=0;feux[i].Adr_det4:=0;
            // éléments optionnels
            if j<>0 then
            begin
              //Affiche('Entrée:s='+s,clyellow);
              sa:=s;
              multiple:=s[1]='(';
              if multiple then
              begin
               delete(s,1,1);
               j:=0;
               repeat
                 k:=pos(',',s);
                 if k>1 then
                 begin
                   val(s,adr,erreur); // extraire l'adresse
                   Delete(s,1,k);
                 end;
                 //Affiche('Adr='+IntToSTR(adr)+' ' +intToSTR(erreur),clyellow);
                 //Affiche('S avec premier champ supprimé='+s,clyellow);
                 inc(j);
                 if (j=1) then feux[i].Adr_det1:=adr;
                 if (j=2) then feux[i].Adr_det2:=adr;
                 if (j=3) then feux[i].Adr_det3:=adr;
                 if (j=4) then feux[i].Adr_det4:=adr;
                 //type de l'élément suivant (1=détecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 t:=0;
                 if s[1]='A' then
                 begin
                   t:=2;
                   //Affiche('détecté aiguillage',clyellow);
                   if (j=1) then feux[i].Btype_Suiv1:=2;
                   if (j=2) then feux[i].Btype_Suiv2:=2;
                   if (j=3) then feux[i].Btype_Suiv3:=2;
                   if (j=4) then feux[i].Btype_Suiv4:=2;
                   delete(s,1,1);
                 end;
                 l:=pos('TRI',s);
                 if l<>0 then
                 begin
                   t:=4;
                   delete(s,l,3);
                   //Affiche('détecté aiguillage tri',clyellow);
                   if (j=1) then feux[i].Btype_Suiv1:=4;
                   if (j=2) then feux[i].Btype_Suiv2:=4;
                   if (j=3) then feux[i].Btype_Suiv3:=4;
                   if (j=4) then feux[i].Btype_Suiv4:=4;
                 end;
                 l:=pos('B',s);
                 if l<>0 then
                 begin
                   t:=5;
                   delete(s,l,1);
                   //Affiche('détecté aiguillage bis',clyellow);
                   if (j=1) then feux[i].Btype_Suiv1:=5;
                   if (j=2) then feux[i].Btype_Suiv2:=5;
                   if (j=3) then feux[i].Btype_Suiv3:=5;
                   if (j=4) then feux[i].Btype_Suiv4:=5;
                 end;
                 if t=0 then //détecteur
                 begin
                   if (j=1) then feux[i].Btype_Suiv1:=1;
                   if (j=2) then feux[i].Btype_Suiv2:=1;
                   if (j=3) then feux[i].Btype_Suiv3:=1;
                   if (j=4) then feux[i].Btype_Suiv4:=1;
                 end;
                 Val(s,adr,erreur);
                 //Affiche('Adr='+IntToSTR(Adr),clyellow);
                 if (j=1) then feux[i].Adr_el_suiv1:=Adr;
                 if (j=2) then feux[i].Adr_el_suiv2:=Adr;
                 if (j=3) then feux[i].Adr_el_suiv3:=Adr;
                 if (j=4) then feux[i].Adr_el_suiv4:=Adr;
                 delete(s,1,erreur-1);
                 if s[1]=',' then delete(s,1,1);
                 //Affiche('S en fin de traitement s='+s,clyellow);
                 fini:=s[1]=')';
               until (fini) or (j>4);
              //if fini then Affiche('fini',clyellow);
            end;
          end;
          if (j>4) or (not(multiple)) then begin Affiche('Erreur: fichier de configuration ligne erronnée : '+chaine,clred); closefile(fichier);exit;end;

          k:=pos(',',s);
          delete(s,1,k);
          //Affiche('s='+s,clyellow);
          feux[i].VerrouCarre:=s[1]='1';
          delete(s,1,1);
          // si décodeur UniSemaf (6) champ supplémentaire
          if Feux[i].decodeur=6 then
          begin
             k:=pos(',',s);
             if k=0 then begin Affiche('Ligne '+chaine,clred);Affiche('Manque définition de la cible pour le décodeur UniSemaf',clred);end
             else
             begin
               Delete(S,1,k);
               Val(s,k,erreur);
               Feux[i].UniSemaf:=k;
             end;
            end;
          end;
        end;
        inc(i);
      end;
    end;
  end;
  until (finifeux) or (s='0');
  NbreFeux:=i-1; if NbreFeux<0 then NbreFeux:=0;
  //Affiche('Nombre de feux='+IntToSTR(NbreFeux),clYellow);

  configNulle:=(maxAiguillage=0) and (NbreBranches=0) and (Nbrefeux=0);
  if configNulle then Affiche('Fonctionnement en config nulle',ClYellow);
  // définition des actionneurs
  maxTablo_act:=1;
  NbrePN:=0;
  repeat        
    s:=lit_ligne;
    if pos('F',s)<>0 then
    // -----------------fonction
    begin
      // 815,1,CC406526,F2,450
      i:=pos(',',s);
      if i<>0 then
      begin
        val(copy(s,1,i-1),j,erreur);
        Tablo_actionneur[maxTablo_act].actionneur:=j;
        Delete(s,1,i);
        i:=pos(',',s);
        if i<>0 then
        begin
          i:=pos(',',s);
          val(copy(s,1,i-1),j,erreur);
          Tablo_actionneur[maxTablo_act].etat:=j;
          Delete(s,1,i);

          i:=pos(',',s);
          Tablo_actionneur[maxTablo_act].train:=copy(s,1,i-1);
          Delete(s,1,i);

          i:=pos('F',s);
          if i<>0 then
          begin
            Delete(s,1,1);
            val(s,j,erreur);
            Tablo_actionneur[maxTablo_act].Fonction:=j;

            i:=pos(',',s);
            if i<>0 then
            begin
              Delete(S,1,i);
              val(s,j,erreur);
              Tablo_actionneur[maxTablo_act].Tempo:=j;
              inc(maxTablo_act);
            end;
          end;
          s:='';i:=0;
        end;
      end;
    end;
    // Passage à niveau
    // (815,820),(830,810)...,PN(121+,121-)
    // (815,809),PN(121+,121-)
    if (pos('PN',s)<>0) then
    begin
      inc(NbrePN);
      NbreVoies:=0;
      repeat
        inc(NbreVoies);
        //Affiche('NbreVoies='+intToSTR(NbreVoies),clyellow);
        //SetLength(Tablo_PN[1].Voie,1);
        Delete(s,1,1); // supprime (
        val(s,j,erreur);

        Tablo_PN[NbrePN].voie[NbreVoies].ActFerme:=j;

        //  Affiche('Ferme='+intToSTR(j),clyellow);
        i:=pos(',',s);Delete(S,1,i);
        val(s,j,erreur);
        Tablo_PN[NbrePN].voie[NbreVoies].ActOuvre:=j;
        //  Affiche('Ouvre='+intToSTR(j),clyellow);
        i:=pos(')',s);Delete(S,1,i);
        i:=pos(',',s);Delete(S,1,i);
        Tablo_PN[NbrePN].voie[NbreVoies].PresTrain:=false;
      until (copy(s,1,2)='PN') or (NbreVoies=10);

      Tablo_PN[NbrePN].NbVoies:=NbreVoies;
      Delete(s,1,3);  // Supprime PN(
      val(s,j,erreur);
      Tablo_PN[NbrePN].Adresseferme:=j;
      Delete(s,1,erreur-1);
      if s[1]='+' then Tablo_PN[NbrePN].CommandeFerme:=2;
      if s[1]='-' then Tablo_PN[NbrePN].CommandeFerme:=1;
      Delete(s,1,2); // supprime +,

      val(s,j,erreur);
      Tablo_PN[NbrePN].AdresseOuvre:=j;
      Delete(s,1,erreur-1);
      if s[1]='+' then Tablo_PN[NbrePN].CommandeOuvre:=2;
      if s[1]='-' then Tablo_PN[NbrePN].CommandeOuvre:=1;
      Delete(s,1,1); // supprime )
      i:=0;
    end;
    if pos('PN',s)<>0 then i:=0;
  until (s='0');
  dec(maxTablo_act);

  closefile(fichier);
  // vérification de la cohérence1
  // parcoure les branches des détecteurs jusqu'à trouver un aiguillage pour voir s'il a été décrit
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;
      modele:=BrancheN[i][j].BType;  // 1= détecteur  2= aiguillage 3=bis 4=Buttoir
      j:=j+1;
    until ( (modele=1) or (modele=2) or (modele=3) or ((modele=0) and (detect=0)));
    // trouvé un aiguillage et récupéré son adresse dans detect
    //if (type!=1) Display("Erreur aucun détecteur dans la déclaration du réseau\r\n");
    if (modele=1) or (modele=2) or (modele=3) then
    begin
      modele:=aiguillage[detect].modele;
      if (modele=0) then Affiche('Erreur 1: Aiguillage='+intToStr(detect)+' non décrit mais présent dans la description des branches '+intToStr(i)+'/'+intToSTR(j),clred);
    end;
  end;

  // vérification de la cohérence2
  // parcoure les aiguillages pour voir si les détecteurs sont en branches des détecteurs
  for aig:=1 to maxaiguillage do
  begin
    adr:=aiguillage[aig].Adroit;
    if (aiguillage[aig].AdroitB='Z') then
    begin
      trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
      if (IndexBranche_trouve=0) then
        Affiche('Erreur 2: détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clred);
    end;
    adr:=aiguillage[aig].Adevie;
    if (aiguillage[aig].AdevieB='Z') then
    begin
      trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
      if (IndexBranche_trouve=0) then
          Affiche('Erreur 3: détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clRed);
    end;
    adr:=aiguillage[aig].Apointe;
    if ((aiguillage[aig].ApointeB='Z') and (aiguillage[aig].modele=1)) then
    begin
      trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
      if (IndexBranche_trouve=0) then
        Affiche('Erreur 4 : détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clRed);
    end;
    if (aiguillage[aig].modele=4) then // aiguillage triple
    begin
      if (aiguillage[aig].Adevie2B='Z') then
      begin
        adr:=aiguillage[aig].Adevie2;
        trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
        if (IndexBranche_trouve=0) then
          Affiche('Erreur 5 : détecteur '+intToSTR(adr)+' décrit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clRed);      
      end;
    end;
  end;
end;

// front descendant sur un détecteur
function detecteur_0(adresse : integer) : boolean;
begin
  detecteur_0:=(Ancien_detecteur[adresse]=true) and ((detecteur[adresse])=false);
  Ancien_detecteur[adresse]:=detecteur[adresse];
end;

function detecteur_1(adresse : integer) : boolean;
begin
  detecteur_1:=(Ancien_detecteur[adresse]=false) and ((detecteur[adresse])=true);
  Ancien_detecteur[adresse]:=detecteur[adresse];
end;

function virgule_prec(sl : string;o : integer) : integer;
var k : integer;
begin
  o:=o-1;
  for k:=o downto 1 do
  begin
    //Affiche(intToSTR(k)+'/'+sl[k],clGreen);
    if sl[k]=',' then begin result:=k;exit;end;
  end;
  result:=0;
end;

// trouve un élément dans les branches, renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'élément  TypeEL=(1=détécteur 2=aig  3=aig Bis)
procedure trouve_element(el : integer;TypeEl : integer);
var i,Btype,adr,Branche : integer ;
    s : string;
    sort : boolean;
begin
  Branche:=1;
  branche_trouve:=0;
  IndexBranche_trouve:=0;
  i:=1;
  repeat
    adr:=BrancheN[Branche,i].Adresse;
    Btype:=BrancheN[Branche,i].BType;
    if ((adr=0) and (Btype=0)) then begin inc(Branche);i:=0;end;
    inc(i);
    sort:=(Branche>NbreBranches) or
     ((adr=el) and (TypeEl=3) and (Btype=3)) or
     ((adr=el) and (TypeEl=2) and (Btype=2)) or
     ((adr=el) and (TypeEl=1) and (Btype=1)) ;
  until (sort);
  if (adr=el) then
  begin
    branche_trouve:=Branche;
    IndexBranche_trouve:=i-1;
  end
  else begin s:='Erreur 175 - élément '+intToSTR(el);
         if (TypeEl=3) then s:=s+'bis';
         s:=s+' non trouvé';Affiche(s,clred);
         branche_trouve:=0; IndexBranche_trouve:=0;
         if NivDebug>=1 then AfficheDebug(s,clred);
       end;
end;



// renvoie élément suivant entre deux éléments quels qu'ils soient mais contigus
// et en variables globales: typeGen le type de l'élément
// s'ils ne sont pas contigus, on aura une erreur
// alg= algorithme :
// 1=arret sur suivant qu'il soit un détecteur ou un aiguillage
// 2=arret sur aiguillage en talon mal positionné
// 3=arret sur un aiguillage pris en pointe dévié et AdrDevie contient l'adresse de l'aiguillage dévié ainsi que typeGen
// code de sortie : élément suivant ou:
// 9999=erreur fatale
// 9998= arret sur aiguillage en talon mal positionnée
// 9997: arrêt sur aiguillage dévié
// typeGen : 1=detecteur 2=aiguillage 3=aiguillage bis
function suivant_alg3(prec : integer;typeELprec : integer;actuel : integer;typeElActuel : integer;alg : integer) : integer;
var  Btype,Adr,AdrPrec,BtypePrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2,Abis,TypeEl : integer;
     tjscourbe1,tjscourbe2,tjd,tjs : boolean;
     A,Aprec,tjsc1B,tjsc2B: char;
     s : string;
label recommence;
begin
  recommence:
  if (TypeELPrec=0) or (typeElActuel=0) then
  begin
    s:='Erreur 800 - Types nuls : '+intToSTR(prec)+'/'+intToSTR(TypeElPrec)+' '+IntToSTr(actuel)+'/'+IntToSTR(typeElActuel) ;
    Affiche(s,clred);
    AfficheDebug(s,clred);
    Suivant_alg3:=9999;exit;
  end;
  if NivDebug=3 then AfficheDebug('Alg3 précédent='+intToSTR(prec)+'/'+intToStr(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+IntToSTR(typeElActuel),clyellow);
  // trouver les éléments du précédent
  trouve_element(prec,TypeELPrec); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouvé',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;
  //  if BTypePrec=2 then aiguillage[prec].A

  trouve_element(actuel,typeElActuel); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouvé',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Btype:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

  //Affiche('Btype='+intToSTR(Btype)+' Actuel='+inTToSTR(actuel),clyellow);

  if Btype=1 then  // l'élément actuel est un détecteur
  begin
    // on part de l'actuel pour retomber sur le précédent
    if BrancheN[branche_trouve_actuel,indexBranche_actuel-1].Adresse=prec then // c'est l'autre sens
    begin
      if NivDebug=3 then AfficheDebug('40 - trouvé détecteur '+intToSTR(adr)+' en + ',clwhite);
      Prec:=Adr;
      Aprec:=a;
      A:='Z';
      Adr:=BrancheN[branche_trouve_actuel,indexBranche_actuel+1].Adresse;
      typeGen:=BrancheN[branche_trouve_actuel,indexBranche_actuel+1].Btype;
      if NivDebug=3 then 
      begin
        s:='41 - Le suivant est :'+intToSTR(adr);
        if Btype=1 then s:=s+'(bis)';
        AfficheDebug(s,clwhite);
      end;  
      suivant_alg3:=adr;
      exit;
    end;
    if BrancheN[branche_trouve_actuel,indexBranche_actuel+1].Adresse=prec then
    begin
      if NivDebug=3 then AfficheDebug('42 - trouvé détecteur '+intToSTR(adr)+' en - ',clwhite);
      Prec:=Adr;
      Aprec:=a;
      A:='Z';
      Adr:=BrancheN[branche_trouve_actuel,indexBranche_actuel-1].Adresse;
      typeGen:=BrancheN[branche_trouve_actuel,indexBranche_actuel-1].Btype;
      if NivDebug=3 then 
      begin
        s:='43 - Le suivant est :'+intToSTR(adr);
        if typeGen=1 then s:=s+'(bis)';
        AfficheDebug(s,clwhite);
      end;  
      suivant_alg3:=adr;
      exit;
    end;
    // ici, les éléments sont non consécutifs. voir si l'un des deux est une TJD/TJS
    if (btypePrec=2) or (btypePrec=3) then
    begin
      if NivDebug=3 then AfficheDebug('Le précedent est une TJD/S - substitution du precédent par la pointe de la TJD',clYellow);
      // changer l'adresse du précédent par l'autre adresse de la TJD/S
      prec:=Aiguillage[prec].APointe;
      goto recommence;
    end;

    Affiche('44 - éléments non consécutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
    if NivDebug=3 then AfficheDebug('44 - éléments non consécutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
  end;

  if (Btype>=2) then  // aiguillage ou bis ou buttoir
  begin
    if (aiguillage[Adr].modele=1) and (Btype=2)  then // aiguillage normal non bis
    begin
      // aiguillage pris en pointe
      if (aiguillage[adr].Apointe=prec) then
      begin
        if aiguillage[Adr].position=const_droit then
        begin
          if NivDebug=3 then AfficheDebug('130 - aiguillage '+intToSTR(Adr)+' Pris en pointe droit',clyellow);
          AdrPrec:=Adr;
          if Adr=0 then
          begin
            Affiche('131 - Erreur fatale',clRed);suivant_alg3:=9999;exit;
          end;
          BtypePrec:=Btype;
          Aprec:=a;
          ABis:=aiguillage[Adr].AdroitBis; // Abis=1 si aiguillage bis
          A:=aiguillage[Adr].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(adr,typeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[Adr].position<>const_droit then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe dévié',clyellow);
          AdrPrec:=Adr;
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
          begin
            typeGen:=0;
            AdrDevie:=Adr;
            suivant_alg3:=9997;exit;
          end;
          if Adr=0 then
          begin Affiche('134 - Erreur fatale',clRed);
            if NivDebug>=1 then AfficheDebug('134 - Erreur fatale',clRed);
            suivant_alg3:=9999;exit;
          end;
          BtypePrec:=Btype;
          Aprec:=A;
          A:=aiguillage[Adr].AdevieB;
          ABis:=aiguillage[Adr].AdevieBis; // Abis=1 si aiguillage bis
          Adr:=aiguillage[Adr].Adevie;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;exit;
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if aiguillage[adr].position=const_droit then
          begin
            if prec<>aiguillage[Adr].Adroit then
              begin
                    if NivDebug=3 then AfficheDebug('135.1 - Aiguillage '+intToSTR(adr)+' mal positionné',clyellow);
                    suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('135.2 - Aiguillage '+intToSTR(adr)+' bien positionné',clyellow);
              end;
          end
          else
          begin
            if prec<>aiguillage[Adr].Adevie then
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+' mal positionné',clyellow);
                suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+' bien positionné',clyellow);
              end;
          end;
        end;

        AdrPrec:=Adr;
        if Adr=0 then
        begin Affiche('136 - Erreur fatale',clRed);
          if NivDebug>=1 then AfficheDebug('136 - Erreur fatale',clRed);
          suivant_alg3:=9999;exit;
        end;
        BtypePrec:=Btype;
        APrec:=A;
        // Affiche('trouvé'+intToSTR(adr),clyellow);
        A:=aiguillage[Adr].ApointeB;
        ABis:=aiguillage[Adr].ApointeBis;
        Adr:=aiguillage[Adr].Apointe;
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
        if Abis=1 then TypeEl:=3;
        trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        suivant_alg3:=adr;
        exit;
      end;
      Affiche('138 - Erreur fatale - Aucun cas Aiguillage',clred);
      if NivDebug=3 then AfficheDebug('138 - Erreur fatale - Aucun cas Aiguillage',clred);
      suivant_alg3:=9999;exit;
    end;

    if (aiguillageB[Adr].modele=1) and (Btype=3) then // aiguillage normal bis
    begin
      // aiguillage pris en pointe
      if (aiguillageB[Adr].Apointe=Prec) then
      begin
        if (aiguillageB[Adr].position=const_droit) then
        begin
          if NivDebug=3 then AfficheDebug('140 - Aiguillage '+intToSTR(adr)+' bis pris en pointe droit',clyellow);
          AdrPrec:=Adr;
          if (Adr=0) then begin Affiche('141 - Erreur fatale',clred);suivant_alg3:=9999;exit;end;
          BtypePrec:=Btype;
          APrec:=A;
          A:=aiguillageB[Adr].AdroitB;
          ABis:=aiguillageB[Adr].AdroitBis;
          Adr:=aiguillageB[Adr].Adroit;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=Adr;
          exit;
        end;
        if (aiguillageB[Adr].position<>const_droit) then
        begin
          if NivDebug=3 then AfficheDebug('142 - Aiguillage '+intToSTR(adr)+' bis pris en pointe dévié',clyellow);
          AdrPrec:=Adr;
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
          begin
            typeGen:=3;
            AdrDevie:=Adr;
            suivant_alg3:=9997;exit;
          end;
          if (Adr=0) then begin Affiche('144 - Erreur fatale',clred);suivant_alg3:=9999;exit;end;
          BtypePrec:=Btype;
          APrec:=A;
          A:=aiguillageB[Adr].AdevieB;
          ABis:=aiguillageB[Adr].AdevieBis;
          Adr:=aiguillageB[Adr].Adevie;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=Adr;
          exit;
        end;
      end
      else
      begin
        if (NivDebug=3) then AfficheDebug('145 - Aiguillage '+IntToSTR(adr)+' bis pris en talon',clyellow);
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if aiguillageB[adr].position=const_droit then
          begin
            if prec<>aiguillageB[Adr].Adroit then
              begin
                    if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'bis mal positionné',clyellow);
                    suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'bis bien positionné',clyellow);
              end;
          end
          else
          begin
            if prec<>aiguillageB[Adr].Adevie then
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+'bis mal positionné',clyellow);
                suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+'bis bien positionné',clyellow);
              end;
          end;
        end;
        AdrPrec:=Adr;
        if Adr=0 then
        begin Affiche('139 - Erreur fatale',clRed);
          if NivDebug>=1 then AfficheDebug('139 - Erreur fatale',clRed);
          suivant_alg3:=9999;exit;
        end;
        BtypePrec:=Btype;
        APrec:=A;
        // Affiche('trouvé'+intToSTR(adr),clyellow);
        A:=aiguillageB[Adr].ApointeB;
        ABis:=aiguillageB[Adr].ApointeBis;
        Adr:=aiguillageB[Adr].Apointe;
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
        if Abis=1 then TypeEl:=3;
        trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        suivant_alg3:=adr;
        exit;
      end;
    end;

    if (aiguillage[Adr].modele=2) or (aiguillage[Adr].modele=3) then // TJD ou TJS
    begin
      // récupérer les élements de la TJD/S
      AdrTjdP:=aiguillage[Adr].Apointe; // 2eme adresse de la TJD/S
      tjd:=aiguillage[Adr].modele=2;
      tjs:=aiguillage[Adr].modele=3;
      tjsc1:=aiguillage[Adr].tjsint;   // adresses de la courbe de la TJS
      tjsc2:=aiguillage[AdrTjdP].tjsint;
      tjsc1B:=aiguillage[Adr].tjsintB;
      tjsc2B:=aiguillage[AdrTjdP].tjsintB;
      if tjsc1<>0 then
      begin
        tjscourbe1:=(aiguillage[Adr].tjsintB='S') and (aiguillage[tjsc1].position<>const_droit);
        tjscourbe1:=((aiguillage[Adr].tjsintB='D') and (aiguillage[tjsc1].position=const_droit)) or tjscourbe1;
      end;
      if tjsc2<>0 then
      begin
        tjscourbe2:=(aiguillage[AdrTjdP].tjsintB='S') and (aiguillage[tjsc2].position<>const_droit);
        tjscourbe2:=((aiguillage[AdrTjdP].tjsintB='D') and (aiguillage[tjsc2].position=const_droit)) or tjscourbe2;
      end;
      if NivDebug=3 then AfficheDebug('137 - TJD '+intToSTR(Adr)+'/'+IntToSTR(AdrTjdP),clYellow);
      AdrTjdP:=aiguillage[Adr].Apointe;  // adresse TJD homologue
      // determiner la position de la première section de la TJD (4 cas)
      // cas 1 : droit droit
      if (( aiguillage[Adr].position=const_droit) and
           (aiguillage[AdrTjdP].position=const_droit) and tjd)  then
      begin
        if NivDebug=3 then AfficheDebug('cas1 tjd',clYellow);
        if aiguillage[AdrTjdP].Adroit=prec then
        begin
          A:=aiguillage[Adr].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          Abis:=aiguillage[Adr].AdroitBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[Adr].Adroit=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[AdrTjdP].Adroit;
          Abis:=aiguillage[AdrTjdP].AdroitBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;
          exit;
        end;
        //Affiche('Erreur 1021  adrTJD='+IntToSTR(Adr)+' adrTJDPointe='+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
        if nivDebug=3 then AfficheDebug('TJD mal positionnée',clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 2 TJD
      if (aiguillage[Adr].position<>const_droit)
         and (aiguillage[AdrTjdP].position=const_droit) and tjd then
      begin
        if NivDebug=3 then AfficheDebug('cas2 tjd',clYellow);
        if aiguillage[AdrTjdP].Adroit=prec then
        begin
          A:=aiguillage[Adr].AdevieB;
          Adr:=aiguillage[Adr].Adevie;
          Abis:=aiguillage[Adr].AdevieBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[AdrTjdP].Adroit;
          Abis:=aiguillage[AdrTjdP].AdroitBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if nivDebug=3 then AfficheDebug('TJD mal positionnée',clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 3 TJD
      if  (aiguillage[Adr].position=const_droit)
          and (aiguillage[AdrTjdP].position<>const_droit) and tjd then
      begin
        if NivDebug=3 then AfficheDebug('cas3 tjd',clYellow);
        if (aiguillage[AdrtjdP].Adevie=prec) then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          Abis:=aiguillage[Adr].AdroitBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if (aiguillage[Adr].Adroit=prec) then
        begin
          A:=aiguillage[Adr].AdevieB;
          Adr:=aiguillage[Adr].Adevie;
          Abis:=aiguillage[Adr].AdevieBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if nivDebug=3 then AfficheDebug('TJD mal positionnée',clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 4 tjd
      if (aiguillage[Adr].position<>const_droit)
         and (aiguillage[AdrTjdP].position<>const_droit)  then
      begin
        if NivDebug=3 then AfficheDebug('cas4 tjd',clYellow);
        if aiguillage[AdrTjdP].Adevie=prec then
        begin
          A:=aiguillage[Adr].AdevieB;
          Adr:=aiguillage[Adr].Adevie;
          Abis:=aiguillage[Adr].AdevieBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrtjdP].AdevieB;
          Adr:=aiguillage[AdrtjdP].Adevie;
          Abis:=aiguillage[AdrtjdP].AdevieBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if nivDebug=3 then AfficheDebug('TJD mal positionnée',clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas TJS prise dans sa position courbe
      if ((aiguillage[Adr].Adevie=Prec) and (aiguillage[Adr].AdevieB=Aprec) and (aiguillage[Adr].position<>const_droit)
        and (aiguillage[AdrTjdP].position=const_droit) and (tjs) and tjscourbe1 and tjscourbe2) then
      begin
        if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
        A:=aiguillage[AdrTjdP].AdevieB;
        Adr:=aiguillage[AdrTjdP].Adevie;
        ABis:=aiguillage[AdrTjdP].Adeviebis;
        if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
        if Abis=1 then typeGen:=3;
        suivant_alg3:=adr;exit;
      end;
      // cas 3 TJS prise dans sa 2eme position courbe
      if ((aiguillage[Adr].Adroit=Prec) and (aiguillage[Adr].AdroitB=Aprec) and (aiguillage[Adr].position=const_droit)
           and (aiguillage[AdrTjdP].position<>const_droit) and (tjs) and tjscourbe1 and tjscourbe2 ) then
      begin
        if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
        A:=aiguillage[AdrTjdP].AdevieB;
        Adr:=aiguillage[AdrTjdP].Adevie;
        Abis:=aiguillage[AdrTjdP].AdevieBis;
        if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
        if Abis=1 then typeGen:=3;
        suivant_alg3:=adr;exit;
      end;
      Affiche('139 - Erreur fatale - Aucun cas TJD/S : adr='+IntToSTR(Adr)+' '+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
      AfficheDebug('139 - Erreur fatale - Aucun cas TJD/S : adr='+IntToSTR(Adr)+' '+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
      suivant_alg3:=9999;exit;
    end;

    if (aiguillage[Adr].modele=4) then // aiguillage triple
    begin
      Adr2:=aiguillage[Adr].AdrTriple;
      if (aiguillage[adr].Apointe=prec) then
      begin
        // aiguillage triple pris en pointe
        //Affiche('position='+intToSTR(aiguillage[Adr].position),clyellow);
        if  (aiguillage[Adr].position=const_droit) and (aiguillage[Adr2].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple pris en pointe droit',clYellow);
          typeGen:=aiguillage[Adr].AdroitBis+1;
          A:=aiguillage[Adr].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[Adr].position<>const_droit) and (aiguillage[Adr2].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple dévié1 (à gauche)',clYellow);
          typeGen:=aiguillage[Adr].AdevieBis+1;
          A:=aiguillage[Adr].AdevieB;
          Adr:=aiguillage[Adr].Adevie;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[Adr].position=const_droit) and (aiguillage[Adr2].position<>const_droit)  then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple dévié2 (à droite)',clYellow);
          typeGen:=aiguillage[Adr].Adevie2Bis+1;
          A:=aiguillage[Adr].Adevie2B;
          Adr:=aiguillage[Adr].Adevie2;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        begin
          s:='Aiguillage triple '+IntToSTR(Adr)+' : configuration des aiguilles interdite';
          if CDM_connecte then s:=s+': '+IntToSTR(aiguillage[Adr].position);
          AfficheDebug(s,clYellow);
          Affiche(s,clRed);
          suivant_alg3:=9999;exit; // pour échappement
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('Aiguillage triple pris en talon',clyellow);
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if (aiguillage[adr].position=const_droit) and (aiguillage[adr2].position=const_droit) then
          begin
            if prec<>aiguillage[Adr].Adroit then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionné',clyellow);
            end;
          end;
          if (aiguillage[adr].position<>const_droit) and (aiguillage[adr2].position=const_droit) then
          begin
            if prec<>aiguillage[Adr].Adevie then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionné',clyellow);
            end;
          end;
          if (aiguillage[adr].position=const_droit) and (aiguillage[adr2].position<>const_droit) then
          begin
            if prec<>aiguillage[Adr].Adevie2 then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionné',clyellow);
            end;
          end;
        end;
        A:=aiguillage[Adr].ApointeB;
        Adr:=aiguillage[Adr].Apointe;
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=détécteur 2=aig  3=aig Bis)
        if Abis=1 then TypeEl:=3;
        trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        suivant_alg3:=Adr;exit;
      end;
    end;
  end;
  suivant_alg3:=adr;
end;

// trouve l'index du feu associé au détecteur adr
function index_feu_det(adr : integer) : integer ;
    var i : integer;
    trouve,trouve1,trouve2,trouve3,trouve4 : boolean;
begin
  i:=1;
  repeat
    trouve1:=feux[i].Adr_det1=adr;
    trouve2:=feux[i].Adr_det2=adr;
    trouve3:=feux[i].Adr_det3=adr;
    trouve4:=feux[i].Adr_det4=adr;
    trouve:=trouve1 or trouve2 or trouve3 or trouve4;
    if not(trouve) then inc(i);
  until (trouve) or (i>=100);
  if trouve then Index_feu_det:=i else Index_feu_det:=0;
end;


// renvoie l'adresse du détecteur suivant des deux éléments contigus
// TypeElprec/actuel: 1= détecteur  2= aiguillage 3=bis 4=Buttoir
function detecteur_suivant(prec : integer;TypeElPrec : integer;actuel : integer;TypeElActuel : integer) : integer ;
var actuelCalc,PrecCalc,etat,i,j,AdrSuiv : integer;
    BisprecCalc,BisActuelCalc : integer;
begin
  if NivDebug>=2 then AfficheDebug('cherche détecteur suivant aux '+IntToSTR(prec)+'/'+IntToSTR(typeElPrec)+' - '+intToSTR(actuel)+'/'+intToSTR(TypeElActuel),clyellow);
  j:=0;

  PrecCalc:=prec;
  bisprecCalc:=TypeElprec;
  ActuelCalc:=actuel;
  BisActuelCalc:=TypeELActuel;
  // étape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,BisPrecCalc,actuelCalc,BisActuelCalc,1);
    precCalc:=actuelCalc;
    BisPrecCalc:=BisActuelCalc;
    actuelCalc:=AdrSuiv;
    BisActuelCalc:=typeGen;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=10) or (typeGen=1) or (AdrSuiv=0) or (AdrSuiv>=9998); // arret si détecteur
  // si trouvé le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1);
  end;
  if NivDebug=3 then AfficheDebug('Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// renvoie les adresses des détecteurs adjacents au détecteur "adresse"
// résultat dans adj1 et adj2
procedure Det_Adj(adresse : integer);
var Adr,BtypePrec,AdrFonc,Branche,BtypeFonc,AdrPrec,IndexBranche,i,Dir : integer;
    sortie : boolean;
begin
  trouve_element(adresse,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('élément '+IntToSTR(adresse)+' non trouvé',clred);
    exit;
  end;
  IndexBranche:=IndexBranche_trouve;
  branche:=branche_trouve;
  Dir:=1 ; //test direction

  repeat
    if (Dir=1) then i:=IndexBranche-1 else i:=IndexBranche+1;

    AdrPrec:=Adresse;
    BtypePrec:=1;

    AdrFonc:=BrancheN[branche,i].Adresse;
    BtypeFonc:=BrancheN[branche,i].BType;

    i:=0;
    repeat
      if BtypeFonc<>1 then
        Adr:=suivant_alg3(AdrPrec,BtypePrec,AdrFonc,BtypeFonc,2)  // élément suivant mais arret sur aiguillage en talon mal positionnée
      else
        begin Adr:=AdrFonc;TypeGen:=BtypeFonc;end;
      if Adr>9990 then typeGen:=1;
      if (NivDebug=3) then AfficheDebug('trouvé '+intToSTR(Adr)+' '+intToSTR(typeGen),clorange);
      AdrPrec:=AdrFonc;BtypePrec:=BtypeFonc;
      AdrFonc:=Adr;BtypeFonc:=typeGen;
      i:=i+1;
      sortie:=(i=20) or (Adr=0) or (Adr>9997) or (TypeGen=1);
    until (sortie) ;   // boucle de parcours
    if (typeGen=1) and (Dir=1) then begin Adj1:=Adr;end;
    if (typeGen=1) and (Dir=2) then begin Adj2:=Adr;end;
    inc(dir);
  until dir=3;
end;

// renvoie l'adresse du détecteur suivant des deux éléments
// El1 et El2 peuvent être séparés par des aiguillages
// en sortie : 1= det1 non trouvé  2= det2 non trouvé
// code erreur>=9997  ou 0
function detecteur_suivant_El(el1: integer;TypeDet1 : integer;el2 : integer;TypeDet2 : integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,Btype,BisPrec,BisFonc,BisSuiv : integer;
    Sortie : boolean;
    s : string;

begin
  if NivDebug>=2 then AfficheDebug('cherche détecteur_suivant_El aux '+IntToSTR(el1)+'/'+intToSTR(TypeDet1)+'-'+intToSTR(el2)+'/'+intToSTr(TypeDet2),clyellow);
//  if (El1=553) and (el2=521) then
//  begin
//    TraceListe:=true;
//    NivDebug:=3;
//  end;
  // trouver détecteur 1
  trouve_element(el1,Typedet1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('élément '+IntToSTR(el1)+' non trouvé',clred);
    detecteur_suivant_El:=1;exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver élément 2
  trouve_element(el2,TypeDet2); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('élément '+IntToSTR(el2)+' non trouvé',clred);
    detecteur_suivant_El:=2;exit;
  end;

  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;

  j:=1;
  // étape 1 : trouver le sens de progression (en incrément ou en décrément)
  repeat // boucle d'incrément décrément
    if (NivDebug=3) then
    begin
      s:='Test 1 route en ';
      if (j=1) then s:=s+'décrément ' else s:=s+'incrément ';
      s:=s+'- départ depuis détecteur '+IntToSTR(el1);AfficheDebug(s,clyellow);
    end;
    AdrPrec:=el1;
    BisPrec:=typeDet1;

    if (j=1) then i:=IndexBranche_det1-1 else i:=IndexBranche_det1+1;
    if i=0 then Affiche('Erreur élément '+intToSTR(el1)+' en index 1',clred);
    //trouve_element(det1,FALSE);
    Adr:=BrancheN[branche_trouve_det1,i].Adresse; // élément suivant le det1
    AdrFonc:=Adr;
    Btype:=BrancheN[branche_trouve_det1,i].BType;  // élément suivant/précédent
    BisFonc:=Btype;
    i:=0;
    if (el2<>Adr) then
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);  // donne l'élément suivant de AdrPrec à AdrFonc et dans Bis si c'est un aig bis
      if (Adr>=9997) then begin detecteur_suivant_el:=Adr;exit;end;
      if (NivDebug=3) then AfficheDebug('trouvé='+intToSTR(Adr)+' type='+intToSTR(typeGen),clorange);
      trouve_element(Adr,typeGen);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype; // si aiguillage bis
      //Affiche(intToSTR(adr)+'/'+intToStr(Btype),clorange);
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=typeGen;
      i:=i+1;
      sortie:=(Adr=El2) or (i=20) or (Adr=0) or (Adr>9997) or ((Adr<>el2) and (btype=1));
    until (sortie) ;   // boucle de parcours

    if (i=20) then
      begin
        Affiche('Erreur fatale 300 : Itération trop longue',clred);
        AfficheDebug('Erreur fatale 300 : Itération trop longue',clred);
        detecteur_suivant_el:=3;
      end;
    if ((Btype=1) and (Adr<>el2) and (NivDebug=3)) then AfficheDebug('N''est pas le détecteur attendu '+intToSTR(Adr)+' pour '+intToSTR(el2),clyellow);
    inc(j);   // changement de sens
    sortie:=(Adr=el2) or (j=3) or (Adr=0);
  until sortie;

  // si arret sur buttoir
  if Adr=0 then begin detecteur_suivant_el:=0;exit;end;

  if ((j=3) and (Adr<>el2)) then
  begin
    if NivDebug=3 then AfficheDebug('El - Pas de suivant sur séquence '+IntToSTR(el1)+' à '+intToStr(el2),clyellow);
    detecteur_suivant_el:=0;exit;
  end;

  // étape 2 : on a trouvé le sens de progression, trouver le détecteur suivant
  if (Adr=el2) then
  begin
    // trouvé la route si j=2 : -  si j=3 : +
    if (NivDebug=3) then AfficheDebug('El - Route trouvée',clyellow);
    i:=0;
    AdrFonc:=Adr;
    BisFonc:=1;
    //typeGen:=0; //?
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);
      if Adr>9997 then
      begin
        detecteur_suivant_el:=Adr;
        exit;
      end;                                                                 
      if NivDebug=3 then 
      begin
        s:='trouvé 2: Adr='+intToSTR(Adr);
        case typeGen of
         1 : s:=s+' detecteur';
         2 : s:=s+' aiguillage';
         3 : s:=s+' aiguillage bis';
         end;
        AfficheDebug(s,clorange);
      end;  
      trouve_element(Adr,typeGen);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype; // si aiguillage bis
      if (NivDebug=3) then 
      begin
        s:='Suivant='+intToSTR(Adr);
        case Btype of
         1 : s:=s+' detecteur';
         2 : s:=s+' aiguillage';
         3 : s:=s+' aiguillage bis';
         end;
        AfficheDebug(s,clorange);
      end;  
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=typeGen;
      inc(i);
      sortie:=(Btype=1) or (Adr=0) or (i=20);
    until sortie;
    if NivDebug>=2 Then AfficheDebug('Détecteur suivant='+intToSTR(Adr),clOrange);
    if (bType=1) or (Adr=0) then detecteur_suivant_el:=Adr;
    if (i=20) then begin
       if NivDebug=3 then AfficheDebug('Erreur fatale 201 : Itération trop longue',clred);
       Affiche('Erreur fatale 201 : Itération trop longue',clred);detecteur_suivant_el:=3;end;
  end;
end;


// renvoi vrai si les aiguillages au delà du signal sont mal positionnés
function carre_signal(adresse : integer) : boolean;
var
   i,j,prec,AdrFeu,AdrSuiv,actuel,TypeELPrec,TypeElActuel : integer;
   multi, sort  : boolean;
   s : string;
begin
  if (NivDebug>=1) then AfficheDebug('Test si signal '+IntToSTR(adresse)+' doit afficher un carré si aiguillage avals mal positionnés',clyellow);

  i:=Index_feu(adresse);
  j:=0;
  prec:=feux[i].Adr_det1;
  TypeElPrec:=1;
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=1 then TypeElActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeElActuel:=2;
  if feux[i].Btype_suiv1=5 then TypeElActuel:=3; // le type du feu   1=détécteur   2=aig  5=bis
  multi:=feux[i].Adr_det2<>0;
   // trouver si une des voies présente un train
  if (multi) then
  begin
    carre_signal:=FALSE;   // pour l'instant verrouillé
    exit;
  end;

  //Affiche(IntToSTR(actuel),clyellow);
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(prec,typeElPrec,actuel,typeELActuel,2);
    if (AdrSuiv<>9998) then // arret sur aiguillage en talon mal positionnée
    begin
      prec:=actuel;
      TypeElPrec:=TypeElActuel;
      actuel:=AdrSuiv;
      TypeElActuel:=typeGen;
    end;
    // si le suivant est un détecteur comporte t-il un signal?
    AdrFeu:=0;
    if (AdrSuiv>500) then
    begin
      AdrFeu:=index_feu_det(AdrSuiv);
      //Affiche(IntToSTR(AdrFeu),clOrange);
    end;
    sort:=(j=10) or (AdrFeu<>0) or (AdrSuiv=9998) or (AdrSuiv=0); // arret si aiguillage en talon ou buttoir
  until (sort);
  // si trouvé un feu ou j=10, les aiguillages sont bien positionnés
  // si trouvé 9998, aiguillages mal positionnés
  if (NivDebug=3) then
  begin
   if (AdrSuiv=9998) then AfficheDebug('Le signal '+intToSTR(adresse)+' doit afficher un carré car l''aiguillage pris en talon '+IntToSTR(actuel)+' est mal positionné',clYellow)
    else AfficheDebug('Le signal '+IntToSTR(adresse)+' ne doit pas être au carré',clYellow);
  end;
  carre_signal:=AdrSuiv=9998;
end;


// renvoie l'état du signal suivant
// si renvoie 0, pas trouvé le signal suivant.
// rang=1 pour feu suivant, 2 pour feu suivant le 1, etc
// Dans AdresseFeuSuivant : adresse du feu suivant (variable globale)
function etat_signal_suivant(adresse,rang : integer) : integer ;
var num_feu,AdrDet,etat,AdrFeu,i,j,prec,AdrSuiv : integer;
    TypePrec,TypeActuel : integer;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then
  AfficheDebug('Cherche état du signal suivant au '+IntToSTR(adresse),clyellow);
  i:=Index_feu(adresse);
  if feux[i].aspect>10 then
  begin
    s:='La demande de l''état du signal suivant depuis un feu directionnel '+IntToSTR(Adresse)+' est irrecevable';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    etat_signal_suivant:=0;
    exit;
  end;

  if i=0 then
  begin
    Affiche('Erreur 600 - feu non trouvé',clred);
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;
  Etat:=0;
  j:=0;
  num_feu:=0;
  prec:=Feux[i].Adr_det1;  // détecteur sur le courant

  if prec=0 then
  begin
    Affiche('Msg 601 - feu '+intToSTR(adresse)+' non renseigné ',clOrange);
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;
  TypePrec:=1;  // détecteur
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=1 then TypeActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeActuel:=2;
  if feux[i].Btype_suiv1=4 then TypeActuel:=2; // aiguillage triple
  if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=détécteur   2=aig  5=bis
  // si actuel est un détecteur, regarder si il ya un feu
  repeat
    inc(j);
    // à la première itération, si "actuel" est déja un détecteur, ne pas faire de recherche sur le suivant
    if (j=1) and (TypeActuel=1) then
    begin
      AdrSuiv:=actuel;
      actuel:=prec;
      TypeActuel:=1;
      TypePrec:=1;
    end
    else
      begin
        AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
        prec:=actuel;TypePrec:=TypeActuel;
        actuel:=AdrSuiv;TypeActuel:=typeGen;
      end;
    if (AdrSuiv=9999) then
    begin
      Etat_signal_suivant:=0;
      AdresseFeuSuivant:=0;
      exit;
    end;
    if (AdrSuiv=0) then
    begin
      if NivDebug=3 then AfficheDebug('Le suivant est un buttoir',clyellow);
      Etat_signal_suivant:=carre_F; // faire comme si c'était un signal au carré
      AdresseFeuSuivant:=0;
      exit;
    end;

    // si le suivant est un détecteur comporte t-il un signal?

    AdrFeu:=0;
    if (TypeActuel=1) then  // détecteur?
    begin
      i:=Index_feu_det(AdrSuiv);
      AdrFeu:=Feux[i].Adresse;
      //affiche(intToSTR(Feux[i].Adr_el_suiv)+'/'+intTostr(prec),clyellow);
      if (adrFeu=Adresse) then // si on ne reboucle sur le même signal dont on cherche le suivant
      begin
        AdrFeu:=0;j:=10; // on ne trouve pas de suivant
      end;
      if (AdrFeu<>0) then // si l'adresse est <>0
      begin
        if (Feux[i].Adr_el_suiv1<>prec) then   // le feu est-il dans le bon sens de progression?
        begin
          // oui
          inc(num_feu);
          Etat:=EtatSignalCplx[AdrFeu];
          Signal_suivant:=AdrFeu;
          
          if NivDebug=3 then AfficheDebug('Trouvé feu suivant Adr='+IntToSTR(AdrFeu)+'='+IntToSTR(etat),clOrange);
        end
        else
        begin
          if NivDebug=3 then AfficheDebug('Trouvé feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
          AdrFeu:=0;
        end;
      end;
    end;
  until (j=10) or ((AdrFeu<>0) and (num_feu=rang));
  if etat=0 then Signal_Suivant:=0;
  etat_signal_suivant:=Etat;
  AdresseFeuSuivant:=Signal_suivant;
  if (NivDebug=3) and (adrFeu=0) then AfficheDebug('Pas Trouvé de feu suivant au feu Adr='+IntToSTR(ADresse),clOrange);
  //TraceDet:=false;
end;


// renvoie l'adresse de l'aiguille si elle est déviée après le signal et ce jusqu'au prochain signal
// sinon renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;
var AdrDet,AdrFeu,etat,i,j,prec,AdrSuiv,Actuel : integer;
    TypePrec,TypeActuel : integer;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('test si aiguille déviée après signal '+IntToSTR(Adresse),clyellow);
  j:=0;
  i:=Index_feu(adresse);
  prec:=feux[i].Adr_det1;
  TypePrec:=1;
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=1 then TypeActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeActuel:=2;
  if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=détécteur   2=aig  5=bis

  //Affiche(IntToSTR(actuel),clyellow);
  AdrFeu:=0;
  AdrDevie:=0;
  if (TypeActuel=2) or (TypeActuel=3) then  // aiguillage
  begin
    if (aiguillage[actuel].Apointe=prec) and (aiguillage[actuel].position<>const_droit) then Aiguille_deviee:=actuel;
  end;

  repeat
    inc(j);
    // 3=demande si le suivant est un aiguillage en pointe dévié oui si AdrSuiv=9997
    // dans ce cas la variable globale AdrDevie est mise à jour
    AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,3);
    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if ADrSuiv<>9997 then
    begin
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      // si le suivant est un détecteur comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=1) then  // détecteur
      begin
        i:=Index_feu_det(AdrSuiv);
        AdrFeu:=Feux[i].Adresse;
        if NivDebug=3 then AfficheDebug('trouvé signal '+intToSTR(AdrFeu)+' associé au détecteur '+IntToSTR(AdrSuiv),clyellow);
      end;
    end;
  until (j=10) or (AdrSuiv=9997) or (AdrFeu<>0) ;
  if (AdrSuiv=9997) then
  begin
     s:='le signal '+intToSTR(adresse)+' doit afficher un rappel car l''aiguillage '+intToSTR(AdrDevie);
     if (typeGen=3) then s:=s+'bis';
     s:=s+' est dévié';
     if NivDebug=3 then AfficheDebug(s,clYellow);
  end;
  if ((AdrSuiv<>9997) or (j=10)) and (NivDebug=3) then
  begin
    S:='le signal '+intToSTR(adresse)+' ne doit pas afficher de rappel car ';
    if j<>10 then s:=s+'trouvé un autre signal suivant et pas d''aiguillage dévié'
    else s:=s+' signal trop éloigné';
    AfficheDebug(s,clYellow);
  end;
  Aiguille_deviee:=AdrDevie;
end;

procedure pilote_direction(Adr,nbre : integer);
var i,j : integer;
begin
  i:=index_feu(Adr);
  j:=feux[i].decodeur;
  case j of
  // 0 : envoi_directionvirtuel(Adr,nbre);
    1 : envoi_DirectionBahn(Adr,nbre);
    2 : envoi_DirectionCDF(Adr,nbre);
   //3 : envoi_DirectionLDT(Adr,nbre);
    4 : envoi_DirectionLEB(Adr,nbre);
    //5 : envoi_DirectionNMRA(Adr,nbre);
   end;
end;

procedure Signal_direction(Adr : integer);
var NAig,i,id,j,NfeuxDir,AdrAigFeu,Position : integer;
    PosAigFeu : char;
    Positionok : boolean;
begin
  id:=Index_feu(Adr);
  NfeuxDir:=feux[id].aspect-10;
  //Affiche(IntToSTR(NfeuxDir),clyellow);
  i:=1;   // i=1 position éteinte du feu ; pour les autres valeurs de i : nombre de feux allumés
  repeat
    NAig:=length(feux[id].AigDirection[i])-1;
    if i=1 then positionok:=false else positionok:=true;
    for j:=1 to Naig do
    begin
      // vérifier la position déclarée des aiguillages pour chaque feu
      AdrAigFeu:=feux[id].AigDirection[i][j].Adresse;
      PosAigFeu:=feux[id].AigDirection[i][j].posAig;
      position:=aiguillage[AdrAigFeu].position;
      //
      if i=1 then positionok:=((position=const_droit) and (posAigFeu='D')) or ((position<>const_droit) and (posAigFeu='S')) or positionok;
      if i>1 then positionok:=((position=const_droit) and (posAigFeu='D')) or ((position<>const_droit) and (posAigFeu='S')) and positionok;

    end;
    //if positionok then Affiche('Signal directionnel '+IntToSTR(Adr)+' Position Ok sur feu '+intToSTR(i-1),clyellow);
    inc(i);
  until (i>NFeuxDir+1) or positionok;

  if positionok then
  begin
    // Affiche('i='+intToSTR(i),clyellow);
    dec(i,2);   // i correspond au nombre de feux à allumer
    pilote_direction(Adr,i);
  end;                 

end;

// renvoie vrai si une mémoire de zone est occupée du signal courant au signal suivant
// adresse=adresse du signal
function test_memoire_zones(adresse : integer) : boolean;
var
  AdrSuiv,prec,TypePrec,TypeActuel,ife,actuel,AdrDet,Etat,AdrFeu,i,j,PresTrain01,PrecInitial : integer;
  Pres_train,sort : boolean;

begin
  if NivDebug>=1 then AfficheDebug('Proc test_memoire_zones - Cherche mémoire à 1 du signal '+intToSTR(adresse)+' au signal suivant ',clyellow);
  i:=Index_feu(adresse);
  if (i=0) then
  begin
    Affiche('Erreur 650 - feu non trouvé',clred);
    AfficheDebug('Erreur 650 - feu non trouvé',clred);
    test_memoire_zones:=false;
  end;

  Pres_train:=FALSE;
  ife:=1;  // index feu de 1 à 4 pour explorer les 4 détecteurs d'un feu
  repeat
    j:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test feu '+intToSTR(ife)+'/4',clred);
    if (ife=1) then
    begin 
      prec:=feux[i].Adr_det1;
      actuel:=feux[i].Adr_el_suiv1;
      if feux[i].Btype_suiv1=1 then TypeActuel:=1;
      if feux[i].Btype_suiv1=2 then TypeActuel:=2;
      if feux[i].Btype_suiv1=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=détecteur   2=aig  5=bis
    end;  //détecteur sur le signal courant
    if (ife=2) then
    begin 
      prec:=feux[i].Adr_det2;actuel:=feux[i].Adr_el_suiv2;
      if feux[i].Btype_suiv2=1 then TypeActuel:=1;
      if feux[i].Btype_suiv2=2 then TypeActuel:=2;
      if feux[i].Btype_suiv2=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv2=5 then TypeActuel:=3; // le type du feu   1=détecteur   2=aig  5=bis
    end;  // détecteur sur le signal courant
    if (ife=3) then
    begin
      prec:=feux[i].Adr_det3;
      actuel:=feux[i].Adr_el_suiv3;
      if feux[i].Btype_suiv3=1 then TypeActuel:=1;
      if feux[i].Btype_suiv3=2 then TypeActuel:=2;
      if feux[i].Btype_suiv3=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv3=5 then TypeActuel:=3; // le type du feu   1=détecteur   2=aig  5=bis
    end;  // détecteur sur le signal courant
    if (ife=4) then
    begin
      prec:=feux[i].Adr_det4;
      actuel:=feux[i].Adr_el_suiv4;
      if feux[i].Btype_suiv4=1 then TypeActuel:=1;
      if feux[i].Btype_suiv4=2 then TypeActuel:=2;
      if feux[i].Btype_suiv4=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv4=5 then TypeActuel:=3; // le type du feu   1=détecteur   2=aig  5=bis
    end;  // détecteur sur le signal courant

    TypePrec:=1;
    if (prec=0) then
    begin
      // sortie si aucun détecteur déclaré sur le feu
      test_memoire_zones:=Pres_train;
      exit;
    end;

    PrecInitial:=Prec;
    repeat
      inc(j);
      // à la première itération, si "actuel" est déja un détecteur, ne pas faire de recherche sur le suivant
      // et chaîner mémoire de zone
      if (j=1) and (Typeactuel=1) then // si détecteur
      begin
        Pres_train:=MemZone[Prec,actuel];
        if Pres_Train and (NivDebug=3) then Affiche('Présence train de '+intToSTR(prec)+' à '+intToSTR(actuel),clyellow);
      end
      else
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          prec:=actuel;TypePrec:=TypeActuel;
          actuel:=AdrSuiv;TypeActuel:=typeGen;
         end;

      if NivDebug=3 then AfficheDebug('A suivant='+IntToSTR(adrsuiv),clred);
      if actuel=0 then
      begin
        // si c'est un buttoir
        test_memoire_zones:=false;
        if NivDebug=3 then AfficheDebug('sortie car buttoir',clyellow);
        exit;
      end;
       // si le suivant est un détecteur ; contrôler mémoire de zone et comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=1) then  // détecteur
      begin
        if (NivDebug=3) and MemZone[PrecInitial][actuel] then AfficheDebug('Présence train de '+intToSTR(PrecInitial)+' à '+intToSTR(actuel),clyellow);

        Pres_train:=MemZone[PrecInitial][actuel] or Pres_train; // mémoire de zone
        if Pres_Train then PresTrain01:=1 else PresTrain01:=0;
        if NivDebug=3 then AfficheDebug('de '+IntToSTR(PrecInitial)+' à '+intToSTR(actuel)+'='+IntToSTR(PresTrain01),clyellow);
       // prec:=actuel; // pour préparer le suivant

        i:=index_feu_det(AdrSuiv);  // renvoie l'index du signal se trouvant au détecteur "AdrSuiv": il peut y avoir 4 détecteurs par signal
        AdrFeu:=feux[i].adresse;    // adresse du feu
        if (AdrFeu=adresse) then  // si on ne reboucle sur le même signal dont on cherche le suivant
        begin
          AdrFeu:=0;j:=10; // on ne trouve pas de suivant
        end;
        if (AdrFeu<>0) then // si l'adresse est <>0
        begin
          if (feux[i].Adr_el_suiv1<>prec) then   // le feu est-il dans le bon sens de progression?
          begin
            if (NivDebug=3) And Pres_Train then AfficheDebug('Sortie proced:Mémoire de zone à 1',clyellow);
            if (NivDebug=3) And (not(Pres_Train)) then AfficheDebug('Sortie proced:Mémoire de zone à 0',clyellow);
            test_memoire_zones:=Pres_train;exit;
          
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouvé feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
            AdrFeu:=0;
          end;
        end
        else
        begin
          //if (traceDet) {sprintf(Affiche,"Trouvé détecteur %d mais sans signal\r\n",AdrSuiv,Etat);Display(Affiche);
          AdrFeu:=0;
        end;
      end
      else
      begin
        if (NivDebug=3) then AfficheDebug('Trouvé aiguillage '+intToSTR(AdrSuiv),clyellow);
      end;
      sort:=(j=10) or (AdrFeu<>0) ;
    until (sort);  // on arrete jusqu'à trouver un signal ou si on va trop loin (10 itérations)
    inc(ife);
  until ife>=5;
  if (NivDebug=3) and (Etat=0) then AfficheDebug('Pas trouvé de signal suivant au '+intToSTR(adresse),clyellow);
  test_memoire_zones:=Pres_train;
end;


Procedure affiche_Event_det;
var i : integer;
begin
  with FormDebug.MemoEvtDet do
  begin
    //lines.clear;
    lines.add('-------------');
    for i:=1 to N_event_det do
    begin
      lines.add(intToSTR(event_det[i]));
      if traceListe then AfficheDebug(intToSTR(event_det[i]),clyellow);
    end;
  end;
end;


// supprime un évènement détecteur dans la liste Event_det[]
procedure supprime_event(i : integer);
var l : integer;
begin
  for l:=i to N_Event_det do event_det[l]:=event_det[l+1];
  dec(N_event_det);
end;

// trouve adresse d'un détecteur à "etat" avant "index" dans le tableau chrono
function trouve_index_det_chrono(Adr,etat,index : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  if index<=0 then 
  begin 
    affiche('Erreur 784 index détecteur invalide',clred); 
    AfficheDebug('Erreur 784 index détecteur invalide',clred);
    exit; 
  end;
  i:=index;
  if i>N_Event_tick then begin trouve_index_det_chrono:=0;exit; end;
  inc(i);
  repeat
    dec(i);
    trouve:=(event_det_tick[i].etat=etat) and (event_det_tick[i].detecteur=Adr) ;
  until (trouve or (i=0));
  if trouve then
  begin
    trouve_index_det_chrono:=i;exit;
  end;
  trouve_index_det_chrono:=0;
end;

// teste si la route est valide de det1, det2 à det3
// les détecteurs doivent être consécutifs
// trouve le détecteur suivant de det1 à det2 si la route est correcte. (détecteurs en entrée obligatoires)
// transmis dans le tableau Event_det
// Variable globale:  El_suivant : adresse du détecteur suivant le détecteur "actuel"
// Résultat:
// si 0 : pas de route
// si 1 : détecteur det1 non trouvé
// si 2 : détecteur det2 non trouvé
// si 3 : erreur fatale
// si 10 : ok route trouvée
function test_route_valide(det1,det2,det3 : integer) : integer; 
var det_suiv,resultat : integer;
begin
  det_suiv:=detecteur_suivant_el(det1,1,det2,1);
  if (det_suiv<=2) or (det_suiv>=9997) or (det3<>det_suiv) then begin resultat:=0;end;
  // test sens inverse....
  if resultat=0 then 
  begin
    test_route_valide:=0;exit;  
    // si manipulation proche aiguillage
    det_suiv:=detecteur_suivant_el(det3,1,det2,1);
    if (det_suiv<=2) or (det_suiv>=9997) or (det1<>det_suiv) then begin test_route_valide:=0;exit;end;
  end;
  test_route_valide:=10 ;
end;


// mise à jour de l'état d'un feu en fontion de son environnement et affiche le feu
procedure Maj_Feu(Adrfeu : integer);
var i,j,k1,k2,BtypeSuiv,Adr_det,etat,Adr,Aig,DetPrec1,DetPrec2,Detprec3,Detprec4,Adr_El_Suiv,
    Btype_el_suivant,det_initial,bt,el_suiv,modele : integer ;
    PresTrain,Aff_semaphore,car : boolean;
    s : string;
begin
  s:='Traitement du feu '+intToSTR(Adrfeu)+'------------------------------------';
  if AffSignal then AfficheDebug(s,clOrange);
  i:=index_feu(Adrfeu);
  if AdrFeu<>0 then
  begin
    modele:=Feux[i].aspect;

    Adr_det:=Feux[i].Adr_det1;  // détecteur sur le signal
    Adr_El_Suiv:=Feux[i].Adr_el_suiv1; // adresse élément suivant au feu
    Btype_el_suivant:=Feux[i].Btype_suiv1;

    // signal directionnel ?
    if (modele>10) then
    begin
      //Affiche('Signal directionnel '+IntToSTR(AdrFeu),clyellow);
      Signal_direction(AdrFeu);
      exit;
    end;

    // signal non directionnel 
    etat:=etat_signal_suivant(AdrFeu,1) ;  // état du signal suivant + adresse du signal suivant dans Signal_Suivant
    if AffSignal then AfficheDebug('Etat signal suivant ('+intToSTR(AdresseFeuSuivant)+') est '+intToSTR(etat),clyellow);
    
    // signaux traités spécifiquement
    if (AdrFeu=201) then
    begin
      if ((aiguillage[28].position<>const_droit) and (aiguillage[29].position<>const_droit) and
         (aiguillage[31].position=2)) then // attention spécial
         Maj_Etat_Signal(AdrFeu,blanc) else Maj_Etat_Signal(AdrFeu,violet);
      envoi_LEB(AdrFeu);
      exit;
    end;
    if (AdrFeu=217) then
    begin
       if ((aiguillage[24].position<>const_droit) and (aiguillage[26].position<>const_droit)) then
           Maj_Etat_Signal(AdrFeu,blanc) else Maj_Etat_Signal(AdrFeu,violet);
       envoi_LEB(AdrFeu);
       exit;
    end;
                
    // signal à 2 feux = carré violet+blanc
    if (Feux[i].aspect=2) then //or (feux[i].check<>nil) then // si carré violet
    begin
      // si aiguillage après signal mal positionnées
      if carre_signal(AdrFeu) then
      begin 
        Maj_Etat_Signal(AdrFeu,violet); 
        Envoi_signauxCplx;
        exit;
      end
      else 
      begin 
        Maj_Etat_Signal(AdrFeu,blanc);
        Envoi_signauxCplx;
        exit;
      end;
    end;

    //if AffSignal then AfficheDebug('Debut du traitement général',clYellow);
    // traitement des feux >3 feux différents de violet (cas général)
    if (Feux[i].aspect>=3) and (EtatSignalCplx[AdrFeu]<>violet_F) then
    begin
      // détecteurs précédent le feu , pour déterminer si leurs mémoires de zones sont à 1 pour libérer le carré
      if Feux[i].VerrouCarre then
      begin
        if AffSignal then AfficheDebug('Le feu est verrouillable au carré',clyellow);
        // un feu peut être associé à 4 détecteurs (pour 4 voies)
        // il faut donc explorer les 4 détecteurs probables
        PresTrain:=FALSE;

        j:=1;
        repeat
          if NivDebug=3 then afficheDebug('Séquence '+IntToSTR(j)+' de recherche des 4 détecteurs précédents-----',clOrange);
          if (j=1) then
          begin det_initial:=feux[i].Adr_det1;Adr_El_Suiv:=feux[i].Adr_el_suiv1;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=détécteur   2=aig  5=bis
          end;
          if (j=2) then
          begin
            det_initial:=feux[i].Adr_det2;Adr_El_Suiv:=feux[i].Adr_el_suiv2;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=détécteur   2=aig  5=bis
          end;
          if (j=3) then
          begin det_initial:=feux[i].Adr_det3;Adr_El_Suiv:=feux[i].Adr_el_suiv3;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=détécteur   2=aig  5=bis
          end;
          if (j=4) then
          begin
            det_initial:=feux[i].Adr_det4;Adr_El_Suiv:=feux[i].Adr_el_suiv4;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=détécteur   2=aig  5=bis
          end;
          if (det_initial<>0) then
          begin
            DetPrec1:=detecteur_suivant(Adr_El_Suiv,Btype_el_suivant,det_initial,1);
            if DetPrec1<9997 then // route bloquée par aiguillage mal positionné
            begin
              DetPrec2:=detecteur_suivant_El(det_initial,1,DetPrec1,1);
              if DetPrec2<9997 then
              begin
                DetPrec3:=detecteur_suivant_El(DetPrec1,1,DetPrec2,1);
                if DetPrec3<9997 then
                begin
                  //DetPrec4:=detecteur_suivant_det(DetPrec2,DetPrec3);
                  if AffSignal then AfficheDebug('les détecteurs précédents au feu '+IntToSTR(Adrfeu)+' sont:'+intToSTR(Det_initial)+' '+intToSTR(DetPrec1)+' '+intToSTR(DetPrec2)+' '+intToSTR(DetPrec3)+' ',clyellow);
                  PresTrain:=//MemZone[DetPrec4,detPrec3] or
                  MemZone[DetPrec3,detPrec2] or MemZone[DetPrec2,detPrec1] or MemZone[DetPrec1,Det_initial] or presTrain ;
             //     Affiche('MemZone'+intToSTR(DetPrec3)+' '+IntToSTR(detPrec2) = '+MemZone[DetPrec3,detPrec2]
                end;
              end;
            end;
          end;
          inc(j);
        until (j>=5);
        if presTrain and AffSignal Then afficheDebug('présence train feu '+intToSTR(AdrFeu),clorange);
      end;
      if AffSignal then afficheDebug('Fin de la recherche des 4 détecteurs précédents-----',clOrange);
      // si le signal peut afficher un carré et les aiguillages après le signal sont mal positionnées ou que pas présence train avant signal et signal
      // verrouillable au carré, afficher un carré
      car:=carre_signal(AdrFeu);
      if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionnées',clYellow);
      if (NivDebug>=1) and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionnées',clYellow);
      if (Feux[i].aspect>=4) and ( (not(PresTrain) and Feux[i].VerrouCarre) or car) then Maj_Etat_Signal(AdrFeu,carre)
      else
      begin
        // si on quitte le détecteur on affiche un sémaphore :  attention tester le sens de circulation
        // pour ne pas passer au rouge un feu à contresens.
        // trouver la mémoire de zone MemZone[Adr_det,?] qui a déclenché le feu rouge
        if AffSignal then AfficheDebug('test du sémaphore',clYellow);
        Aff_semaphore:=test_memoire_zones(AdrFeu);  // test si présence train après signal
        if Aff_Semaphore then
        begin
          if AffSignal then AfficheDebug('Présence train après signal'+intToSTR(AdrFeu)+' -> sémaphore ou carré',clYellow);
          if testBit(EtatSignalCplx[Adrfeu],carre)=FALSE then Maj_Etat_Signal(AdrFeu,semaphore);
        end
        else
        begin
          // si aiguille locale déviée
          Aig:=Aiguille_deviee(Adrfeu);
          if (aig<>0) and (feux[i].aspect>=9) then // si le signal peut afficher un rappel et aiguille déviée
          begin
            if AffSignal then AfficheDebug('Aiguille '+intToSTR(aig)+' déviée',clYellow);
            EtatSignalCplx[AdrFeu]:=0;
            if (aiguillage[aig].vitesse=30) or (aiguillage[aig].vitesse=0) then Maj_Etat_Signal(AdrFeu,rappel_30);
            if aiguillage[aig].vitesse=60 then Maj_Etat_Signal(AdrFeu,rappel_60);

            // si signal suivant affiche rappel ou rouge
            if (TestBit(etat,rappel_60)) or (testBit(etat,rappel_30)) or (testBit(etat,carre)) or (testBit(etat,semaphore))
              then Maj_Etat_Signal(AdrFeu,jaune)
            else
            begin
              // sinon si signal suivant=jaune
              if (TestBit(etat,jaune)) then Maj_Etat_Signal(AdrFeu,jaune_cli);
            end;
          end
          else
          // aiguille locale non déviée ou aspect feu<9
          // si le signal suivant est rouge
          begin
            if AffSignal then AfficheDebug('pas d''aiguille déviée',clYellow);
            if TestBit(etat,carre) or testBit(etat,semaphore) or testBit(etat,semaphore_cli )then Maj_Etat_Signal(AdrFeu,jaune)
            else
            begin
              // si signal suivant affiche rappel
              if TestBit(etat,rappel_30) or TestBit(etat,rappel_60) then
              begin
                EtatSignalCplx[AdrFeu]:=0;
                if TestBit(etat,rappel_30) then  Maj_Etat_Signal(AdrFeu,ral_30);
                if TestBit(etat,rappel_60) then
                begin
                  Maj_Etat_Signal(AdrFeu,ral_60);  // si signal suivant est au rappel60, il faut tester s'il est à l'avertissement aussi
                  if TestBit(etat,jaune) then Maj_Etat_Signal(AdrFeu,jaune_cli);
                end;
              end
              else
                // si le signal suivant est jaune
                if TestBit(etat,jaune) then Maj_Etat_Signal(AdrFeu,jaune_cli)
                  else  Maj_Etat_Signal(AdrFeu,vert)
            end;
          end;
        end;
      end;
    end;
  end;
  envoi_signauxCplx;
end;

Procedure Maj_feux;
var i : integer;
begin
  Maj_feux_cours:=TRUE;
  for i:=1 to NbreFeux do
  begin
    Maj_feu(Feux[i].Adresse);
  end;
  Maj_feux_cours:=FALSE;
end;


procedure rafraichit;
begin
  //Affiche('Procédure rafraichit',cyan);
  begin
    Maj_feux;
    //Maj_feux;
  end
end;

// met à jour le signal adr dont le détecteur vient d'être franchi dans le bon sens
procedure signal(SignalCplx,detecteurAct,detecteurSuiv : integer);
begin
  if MemZone[detecteurAct,detecteurSuiv] then if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
end;

// trouve l'index d'un détecteur dans une branche depuis la fin de la branche
// si pas trouvé, renvoie 0
function index_detecteur_fin(det,Num_branche : integer) : integer;
var dernier,i,j : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        if BrancheN[Num_Branche,i].Btype=1 then   // cherche un détecteur
        begin
          j:=BrancheN[Num_Branche,i].adresse;
          trouve:=det=j;
        end;
        if not(trouve) then dec(i);
      until trouve or (j=0)
    end;
begin
  // déterminer la fin de la branche
  i:=1;
  repeat
     inc(i);
  until (BrancheN[Num_Branche,i].adresse=0) and (BrancheN[Num_Branche,i].btype=0);
  dernier:=i-1;
  //  Affiche('dernier'+intToSTR(dernier),clwhite);
  // rechercher le détecteur depuis l'index i
  i:=dernier;index2_det:=0;
  recherche;
  if trouve then result:=i else result:=0;
  //affiche(inttostr(ai+1),clOrange);

  //affiche('------------------------',clWhite);
  recherche;
  //affiche('------------------------',clGreen);
  if trouve then index2_det:=i else index2_det:=0;
  //affiche('index2='+IntToSTR(index2_det),clWhite);
end;

// calcul des zones depuis le tableau des fronts descendants des évènements détecteurs
// transmis dans le tableau Event_det
procedure calcul_zones_V2;
var Nbre,Nouveau_Det,i,resultat,det1,det2,det3,AdrSuiv : integer ;
    creer_tableau : boolean;
    s : string;
begin
  creer_tableau:=false;
  det3:=event_det[N_event_det]; // c'est le nouveau détecteur
  FormDebug.MemoEvtDet.lines.add('Le nouveau détecteur est '+IntToSTR(det3)) ;
  if TraceListe then AfficheDebug('Le nouveau détecteur est '+IntToSTR(det3),clyellow) ;
  // évaluer d'abord la route du nouveau détecteur sur tous les tableau déja rempli de 2 éléments
  for i:=1 to N_trains do
  begin
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'éléments du tableau courant exploré
    if Nbre=2 then 
    begin
      if TraceListe then AfficheDebug('traitement Train n°'+intToSTR(i)+' 2 détecteurs',clyellow);
      det1:=event_det_train[i].det[1];
      det2:=event_det_train[i].det[2];
      resultat:=test_route_valide(det1,det2,det3); 
      if resultat=10 then 
      begin
        AdrSuiv:=detecteur_suivant_el(det2,1,det3,1); // ici on cherche le suivant à det2 det3
        if (Adrsuiv<=2) or (Adrsuiv>=9997) then 
        begin
          Affiche('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' à '+intToSTR(det3),clRed);
        end
        else
        begin
          s:='route traitée de '+intToSTR(det2)+' à '+IntToSTR(det3)+' Mem '+intToSTR(det3)+' à '+IntToSTR(Adrsuiv);
          FormDebug.MemoEvtDet.lines.add(s);
          if traceListe then AfficheDebug(s,clyellow);
          With FormDebug.RichEdit do
          begin         
            s:='train '+IntToSTR(i)+' '+intToStr(det2)+' à '+intToStr(det3)+' => Mem '+IntToSTR(det3)+' à '+IntTOStr(AdrSuiv);
            Lines.Add(s);
            RE_ColorLine(FormDebug.RichEdit,lines.count,CouleurTrain[((i - 1) mod NbCouleurTrain)+1 ]);
          end;
          if TraceListe then AfficheDebug(s,clyellow);
          Affiche(s,clyellow);
          if AffAigDet then AfficheDebug(s,clyellow);

          MemZone[det2,det3]:=FALSE;        // efface zone précédente
          MemZone[det3,AdrSuiv]:=TRUE;      // valide la nouveau zone
          // supprimer le 1er et décaler
          event_det_train[i].det[1]:=event_det_train[i].det[2];
          event_det_train[i].det[2]:=det3;
          event_det_train[i].NbEl:=2;
          with FormDebug.MemoEvtDet do
          begin
            lines.add('Nouveau Tampon train '+intToStr(i)+'--------');
            lines.add(intToSTR(event_det_train[i].det[1]));
            lines.add(intToSTR(event_det_train[i].det[2]));
          end;  
          if TraceListe then
          begin
            AfficheDebug('Nouveau Tampon train '+intToStr(i)+'--------',clyellow);
            AfficheDebug(intToSTR(event_det_train[i].det[1]),clyellow);
            AfficheDebug(intToSTR(event_det_train[i].det[2]),clyellow);
          end;
          rafraichit;
          rafraichit;
          rafraichit;
          exit; // sortir absolument
        end;
      end;
    end;  
  end;

  // traiter pour les cas avec 1 élément
  for i:=1 to N_trains do
  begin
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'éléments du tableau courant exploré
    if Nbre=1 then 
    begin
      if traceListe then AfficheDebug('traitement Train n°'+intToSTR(i)+' 1 détecteur',clyellow);
      // vérifier si l'élément du tableau et le nouveau sont contigus
      det1:=event_det_train[i].det[1];
      Det_Adj(det1);
      if (Adj1=det3) or (Adj2=det3) then
      begin
        event_det_train[i].det[2]:=det3;
        event_det_train[i].NbEl:=2;
        with FormDebug.MemoEvtDet do
        begin
          lines.add('Nouveau Tampon train '+intToStr(i)+'--------');
          lines.add(intToSTR(event_det_train[i].det[1]));
          lines.add(intToSTR(event_det_train[i].det[2]));
        end;  
        if TraceListe then 
        begin
          AfficheDebug('Nouveau Tampon train '+intToStr(i)+'--------',clyellow);
          AfficheDebug(intToSTR(event_det_train[i].det[1]),clyellow );
          AfficheDebug(intToSTR(event_det_train[i].det[2]),clyellow );
        end; 
        exit; // sortir absolument
      end; 
    end;
  end;
   
  // créer un train, donc un tableau
  if N_Trains>=Max_Trains then 
  begin
    Affiche('Erreur nombre de train maximal atteint',clRed);
  end;
  Inc(N_trains); 
  if TraceListe then AfficheDebug('Création Train n°'+intToSTR(i),clyellow);
  Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);
  event_det_train[N_trains].det[1]:=det3;
  event_det_train[N_trains].NbEl:=1;
  with FormDebug.MemoEvtDet do
  begin
    lines.add('Nouveau Tampon train '+intToStr(N_trains)+'--------');
    lines.add(intToSTR(event_det_train[N_trains].det[1]));
  end;    
  if TraceListe then 
  begin
    AfficheDebug('Nouveau Tampon train '+intToStr(N_trains)+'--------',clyellow);
    AfficheDebug(intToSTR(event_det_train[N_trains].det[1]),clyellow );
  end;
end;


// calcul des zones depuis le tableau des fronts descendants des évènements détecteurs
// transmis dans le tableau Event_det
// appellé  par front descendant sur détecteur
// met à jour le tableau MemZone
(* plus utilisé
procedure calcul_zones ;
var i,det1,det2,index_1,index_2,index_3,resultat : integer;
   unevalide : boolean;
   s : string;
   label refaire;
begin
  uneValide:=false;
  //N_event_det pointe sur le dernier détecteur
  refaire:

  affiche_Event_det;

  if N_event_det<2 then begin exit;end; // pas assez de détecteurs pour évaluer
  // balayer index 1 à 2 puis 1 à 3 puis 1 à N_event_det et ensuite
  // de 2 à 3 puis de 2 à 4 puis de 2 à 5 etc
  index_1:=1;
  repeat
    index_2:=index_1+1;
    repeat
      //det0:=event_det[index_
      det1:=event_det[index_1];
      det2:=event_det[index_2];
      //if det1=det2 then    // si détecteurs identiques, supprimer le 2eme
      //begin
      //  if traceListe then AfficheDebug('trouvé doublon ('+intToSTR(dat1)+')',clyellow);
      //  supprime_event(index_2);
      //  //if traceListe then for index_3:=1 to N_event_det do affiche(intToSTR(event_det[index_3]),clyellow);
      //  goto refaire;
      //end;

      if det2=detecteur_chgt then // on cherche la route pour le 2eme détecteur qui vient de changer
      begin
        if traceListe then
        begin
          AfficheDebug('-------Cherche route de '+intToSTR(det1)+' à '+intToSTR(det2)+' i1='+intToSTR(index_1)+' i2='+intToSTR(index_2)+' n='+intToSTR(N_event_det),clyellow);
        end;
        resultat:=calcul_zones_det(det1,det2); 
        if resultat=10 then
        begin
          s:='route traitée de '+intToSTR(det1)+' à '+IntToSTR(det2)+' Mem '+intToSTR(det2)+' à '+IntToSTR(El_suivant);
          FormDebug.MemoEvtDet.lines.add(s);
          if traceListe then AfficheDebug(s,clyellow);
          uneValide:=true;
          FormDebug.MemoEvtDet.lines.add('Nouveau Tampon:');
          if traceListe then AfficheDebug('Nouveau Tampon',clyellow);
          affiche_Event_det; 
        end;

        // détecteur1 non trouvé
        if resultat=1 then begin supprime_event(index_1);goto refaire;end;
        // détecteur2 non trouvé
        if resultat=2 then begin supprime_event(index_2);goto refaire;end;

      end;
      inc(index_2);
      //Affiche('index2='+IntToSTR(index_2),clyellow);
      until (index_2>N_event_det);
      inc(index_1);
    until (index_1>=N_event_det);
    // si on a trouvé au moins une route valide, rafraichir les signaux
    if uneValide then
    begin
      rafraichit;
      rafraichit;
      rafraichit;
    end;
end;        *)

// demande l'état d'un accessoire à la centrale. Le résultat sera réceptionné sur réception des informations
// de rétrosignalisation.
procedure demande_info_acc(adresse : integer);
var s : string;
    n : integer;
begin
  // uniquement si connecté directement à la centrale
  if portCommOuvert or ParSocket then
  begin
    // envoyer 2 fois la commande, une fois avec N=0 pour récupérer le nibble bas,
    // une autre fois avec N=1 pour récupérer le nibble haut
    s:=#$42+char((adresse-1) div 4);
    n:=$80+((adresse-1) mod 4) div 2;
    s:=s+char(n);   // N=0 (bit 0)
    s:=checksum(s);
    envoi(s);

    s:=#$42+char((adresse-1) div 4);
    n:=$80+((adresse-1) mod 4) div 2;
    s:=s+char(n or 1);  // N=1 (bit 0)
    s:=checksum(s);
    envoi(s);
  end;  
end;

// demande l'état de tous les accessoires par l'interface
procedure demande_etat_acc;
var i : integer;
begin
  Affiche('Demande état des aiguillages',ClYellow);
  for i:=1 to maxaiguillage do
  begin
    demande_info_acc(i);
  end;
end;


// traitement des évènements actionneurs
procedure Event_act(adr,etat : integer;train : string);
var i,v,va,j,etatAct,Af,Ao : integer;
    s : string;
    presTrain_PN : boolean;
begin
  // vérifier si l'actionneur en évènement a été déclaré pour réagir
  if AffActionneur then Affiche('Actionneur '+intToSTR(Adr)+'='+intToSTR(etat),clyellow);
  // dans le tableau des actionneurs pour fonction train
  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].train;
    etatAct:=Tablo_actionneur[i].etat ;
    if (Tablo_actionneur[i].actionneur=adr) and ((s=train) or (s='X')) and (etatAct=etat) then
    begin
      Affiche('Actionneur '+intToSTR(adr)+' Train='+train+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':'+intToSTR(etat),clyellow);
      envoie_fonction_CDM(Tablo_actionneur[i].fonction,etat,train);
      TempoAct:=tablo_actionneur[i].Tempo div 100;
      RangActCours:=i;
    end;
  end;

  // dans le tableau des PN
  for i:=1 to NbrePN do
  begin
    for v:=1 to Tablo_PN[i].nbvoies do
    begin
      aO:=Tablo_PN[i].voie[v].actOuvre;
      aF:=Tablo_PN[i].voie[v].actFerme;

      if (aO=adr) and (etat=0) then  // actionneur d'ouverture
      begin
        Tablo_PN[i].voie[v].PresTrain:=false;
        // vérifier les présences train sur les autres voies du PN
        presTrain_PN:=false;
        for va:=1 to Tablo_PN[i].nbvoies do
        begin
          presTrain_PN:=presTrain_PN or Tablo_PN[i].voie[va].PresTrain;
        end;
        if not(presTrain_PN) then
        begin
          Affiche('Ouverture PN'+intToSTR(i),clOrange);
          pilote_acc(Tablo_PN[i].AdresseOuvre,Tablo_PN[i].CommandeOuvre,Aig);
        end;
      end;

      if (aF=adr) and (etat=1) then  // actionneur de fermeture
      begin
        Tablo_PN[i].voie[v].PresTrain:=true;
        Affiche('Fermeture PN'+IntToSTR(i)+' (train voie '+IntToSTR(v)+')',clOrange);
        pilote_acc(Tablo_PN[i].AdresseFerme,Tablo_PN[i].CommandeFerme,Aig);
      end;
    end;
  end;
end;

// traitement sur les évènements détecteurs 
procedure Event_Detecteur(Adresse : integer;etat : boolean);
var i,trainAdj1,TrainAdj2,TrainActuel,Etat01 : integer;
    s : string;
begin
  if Etat then Etat01:=1 else Etat01:=0;
 
  // vérifier si l'état du détecteur est déja stocké, car on peut reçevoir plusieurs évènements pour le même détecteur dans le même état
  // on reçoit un doublon dans deux index consécutifs.
  if N_Event_tick>=1 then
  begin
    if (event_det_tick[N_event_tick].etat=etat01) and (event_det_tick[N_event_tick].detecteur=Adresse) then 
    begin
      //Affiche(IntToSTR(Adresse)+' déja stocké',clorange);  
      exit;   // déja stocké
    end; 
  end;

  if Traceliste then AfficheDebug('--------------------- détecteur '+intToSTR(Adresse)+' à '+intToSTR(etat01)+'-----------------------------',clOrange);
  if AffAigDet then 
  begin
    s:='Evt Det '+intToSTR(adresse)+'='+intToSTR(etat01);
    Affiche(s,clyellow);
    if not(TraceListe) then AfficheDebug(s,clyellow);
  end;  
 
  //if etat then Mem[Adresse]:=true;  // mémoriser l'état à 1

  ancien_detecteur[Adresse]:=detecteur[Adresse];
  detecteur[Adresse]:=etat;
  detecteur_chgt:=Adresse;

  // stocke les changements d'état des détecteurs dans le tableau chronologique
  if (N_Event_tick<Max_Event_det_tick) then
  begin
    inc(N_Event_tick);
//    event_det_tick[N_event_tick].train:=0;

    event_det_tick[N_event_tick].tick:=tick;
    event_det_tick[N_event_tick].detecteur:=Adresse;
    event_det_tick[N_event_tick].etat:=etat01;
   // Affiche('stockage de '+intToSTR(N_event_tick)+' '+IntToSTR(Adresse)+' à '+intToSTR(etat01),clyellow);
  end;
  
  // mise a jour du tableau evt de fronts descendants
  if ancien_detecteur[Adresse] and not(detecteur[Adresse]) and (N_Event_det<Max_event_det) then
  begin
    // si le FD du détecteur a déjà été stocké à l'index précédent ne pas en tenir compte
    if event_det[N_event_det]<>Adresse then 
    begin
      if AffFD then AfficheDebug('index='+intToSTR(N_event_tick)+' FD '+intToSTR(Adresse),clyellow);
      inc(N_event_det);
      event_det[N_event_det]:=Adresse;
      // vérification de la connaissance de la position de tous les aiguillages au premier évènement FD détecteur
      if not(PremierFD) then
      begin
        for i:=1 to MaxAiguillage do
        begin
          if aiguillage[i].modele<>0 then
          begin
            if aiguillage[i].position=9 then
            Affiche('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',clred);
            AfficheDebug('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',clred);
          end;
        end;  
      end;
      premierFD:=True;
      if not(configNulle) then calcul_zones_V2;  // en avant les calculs
    end;  
  end;

  if (N_event_det>=Max_event_det) then 
  begin
    Affiche('Débordement d''évènements FD - Raz tampon',clred);
    N_event_det:=0;
    FormDebug.MemoEvtDet.lines.add('Raz sur débordement');
  end;   

  // attention à partir de cette section le code est susceptible de ne pas être exécuté

  // Mettre à jour le TCO
  if AvecTCO then
  begin
    formTCO.Maj_TCO(Adresse,etat);
  end;
end;

// évènement d'aiguillage
procedure Event_Aig(adresse,pos,objet : integer);
var s: string;
begin
  // ------------------- traitement du numéro d'objet -------------------------
  // il faut mémoriser le numéro d'objet le plus bas au détriment de celui qui a la même adresse
  // mais un numéro d'objet supérieur (bug CDM sur bretelles avec aiguillages à la même adresse)
  // init objet
  if aiguillage[adresse].objet=0 then 
  begin
    aiguillage[adresse].objet:=objet;
    //affiche('stockage Aiguillage '+intToSTR(adresse)+' objet='+intToSTR(objet),clYellow);
  end;  
  // si l'objet reçu < stocké, on met a jour
  if objet<aiguillage[adresse].objet then 
  begin
    aiguillage[adresse].objet:=objet;
    //affiche('stockage Aiguillage '+intToSTR(adresse)+' objet='+intToSTR(objet),clYellow);
  end;  
  if objet>aiguillage[adresse].objet then 
  begin
    s:='Evt aiguillage rejeté: Adr='+intToSTR(adresse)+'='+intToSTR(pos);
    if pos=const_droit then s:=s+' droit' else s:=s+' dévié';
    s:=s+' Objet='+intToSTr(objet);
    Affiche(s,clOrange);
    AfficheDebug(s,clOrange);
    exit;
  end;

  aiguillage[adresse].position:=pos;

  if aiguillageB[adresse].inversionCDM=0 then aiguillageB[adresse].position:=pos
  else 
  begin
    if pos=const_devie then aiguillageB[adresse].position:=const_droit;
    if pos=const_droit then aiguillageB[adresse].position:=const_devie;
    
  end;
  
  
  // ------------- stockage évènement aiguillage dans tampon event_det_tick -------------------------
  if (N_Event_tick<Max_Event_det_tick) then
  begin
    if AffAigDet then 
    begin
      s:='Evt Aig '+intToSTR(adresse)+'='+intToSTR(pos);
      if pos=const_droit then s:=s+' droit' else s:=s+' dévié';
      if objet<>0 then s:=s+' objet='+IntToSTR(objet);
      Affiche(s,clyellow);
      AfficheDebug(s,clyellow);      
    end;  
    inc(N_Event_tick);
    event_det_tick[N_event_tick].tick:=tick;
    event_det_tick[N_event_tick].aiguillage:=adresse;
    event_det_tick[N_event_tick].etat:=pos;
    event_det_tick[N_event_tick].objet:=objet;
  end;

  exit;
  {
  // -------------------------plus utilisé ----------------
  if N_Event_tick<2 then exit;
  // attribue un train et un détecteur sur un évènement aiguillage
  // étape 1 trouver le détecteur
  pos:=aiguillage[adresse].position;
  if pos=const_droit then
  begin
     Adet:=aiguillage[adresse].Adroit;
     if aiguillage[adresse].AdroitB='Z' then Btype:=1 else Btype:=2;
  end;
  if pos<>const_droit then
  begin
     Adet:=aiguillage[adresse].Adevie;
     if aiguillage[adresse].AdevieB='Z' then Btype:=1 else Btype:=2;
  end;

  if Btype<>1 then
  begin
    BtypeE:=Btype;
    AdresseE:=Adresse;
    i:=0;
    repeat
      // trouver le détecteur avant l'aiguillage - attention prévoir aiguillage BIS (btype=3)
      Det_Suiv:=suivant_alg3(adresseE,BtypeE,Adet,Btype,1) ;
      adresseE:=Adet; BtypeE:=Btype;
      Adet:=Det_Suiv;Btype:=TypeGen;
      inc(i);
    until (typeGen=1) or (i>20);
  end;
  if (i>20) then begin Affiche('Erreur 671',clRed);exit;end;
  Affiche('le détecteur suivant sur aiguillage '+intToSTR(adresse)+' est '+intToSTR(Adet),clyellow);

  // étape 2 : trouver si un train est sur le détecteur dans le tableau event_det_tick
  i:=N_Event_tick;
  repeat
    dec(i);
    trouve:=event_det_tick[i].detecteur[Adet]=1; // si le détecteur à rechercher en amont de la liste est à "etat"
    //train:=event_det_tick[i].train;
    index:=i;
  until trouve or (i=1);
  if trouve then
  begin
    Affiche('détecteur '+intToSTR(Adet)+' à 1',clyellow);
    // il y a a un train dessus,
    det_adj(Adet); // trouver les détecteurs adjacents (adj1 et adj2)
    Affiche('Adj1='+intToSTR(Adj1)+' Adj2='+intToSTR(Adj2),clyellow);
    // trouver le détecteur adjacent
    i:=N_Event_tick;
    trouve1:=false;trouve2:=false;
    repeat
      dec(i);
      if not(trouve1) then
      begin
        trouve1:=event_det_tick[i].detecteur[Adj1]=1;index1:=i; // si le détecteur
        train1:=event_det_tick[index1].train;
      end;
      if not(trouve2) then
      begin
        trouve2:=event_det_tick[i].detecteur[Adj2]=1;index2:=i;
        train2:=event_det_tick[index2].train;
      end; // si le détecteur à rechercher en amont de la liste est à 1
    until (trouve1 and trouve2) or (i=1);

    if not(trouve1) and not(trouve2) then affiche('pas trouve adj1 ni adj2 à 1',clOrange);
    if trouve1 and (train1=train) then
    begin
      Affiche(' détecteur Adj1='+intToSTR(Adj1)+' train='+intToSTR(train),clyellow);
      event_det_tick[index1].suivant:=Adet;
      event_det_tick[index].suivant:=Adj2;

    end;
    if trouve2 and (train2=train) then
    begin
      Affiche(' détecteur Adj2='+intToSTR(Adj2)+' train='+intToSTR(train),clyellow);
      event_det_tick[index2].suivant:=Adet;
      event_det_tick[index].suivant:=Adj1;
    end;


  end;
   }
end;


// le décodage de la rétro est appellée sur une réception d'une trame de la rétrosignalisation.
// On déclenche ensuite le rafraichissement
procedure decode_retro(adresse,valeur : integer);
var  s : string;
     adraig,bitsITT,i : integer;
begin
  //affiche(IntToSTR(adresse)+intToSTR(valeur),clorange);
  bitsITT:=(valeur and $E0);
  // bit à 010X XXXX = c'est un module de rétrosignalisation (pas un aiguillage)
  // doc LENZ Xpressnet protocol description page 31
  detecteur_chgt:=0;
  if (valeur and $10)=$10 then // si bit N=1, les 4 bits de poids faible sont les 4 bits de poids fort du décodeur
  begin
    // détermine le détecteur qui a changé d'état
    // -------état du détecteur
    if bitsITT=$40 then // module de rétro = détecteur
    begin
      // affecter l'état des détecteurs
      i:=adresse*8+8;
      if detecteur[i]<>((valeur and $8) = $8) then  // si changement de l'état du détecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8);
      end;

      i:=adresse*8+7;
      if detecteur[i]<>((valeur and $4) = $4) then  // si changement de l'état du détecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4);
      end;

      i:=adresse*8+6;
      if detecteur[i]<>((valeur and $2) = $2) then  // si changement de l'état du détecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2);
      end;

      i:=adresse*8+5;
      if detecteur[i]<>((valeur and $1) = $1) then  // si changement de l'état du détecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1); 
      end;
    end;

    // état de l'aiguillage
    if bitsITT=$00 then // module d'aiguillages, N=1
    begin
      adraig:=((adresse * 4)+1 ); // *4 car N=1, c'est le "poids fort"
      if (valeur and $C)=$8 then
      begin      
        Event_Aig(adraig+3,const_droit,0);
        if trace then begin s:='accessoire '+intToSTR(adraig+3)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        Event_Aig(adraig+3,const_devie,0);
        if trace then begin s:='accessoire '+intToSTR(adraig+3)+'=1';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        Event_Aig(adraig+2,const_droit,0);
        if trace then begin s:='accessoire '+intToSTR(adraig+2)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        Event_Aig(adraig+2,const_devie,0);
        if trace then begin s:='accessoire '+intToSTR(adraig+2)+'=1';Affiche(s,clYellow);end;
      end;
    end;
  end;

  if (valeur and $10)=$00 then // si bit N=0, les 4 bits de poids faible sont les 4 bits de poids faible du décodeur
  begin
    //Affiche('N=0',clYellow);
    if bitsITT=$40 then // module de rétro
    begin
      // affecter l'état des détecteurs
      i:=adresse*8+4;
      if detecteur[i]<>((valeur and $8) = $8) then  // si changement de l'état du détecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8); 
      end;
      i:=adresse*8+3;
      if detecteur[i]<>((valeur and $4) = $4) then  // si changement de l'état du détecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4); 
      end;

      i:=adresse*8+2;
      if detecteur[i]<>((valeur and $2) = $2) then  // si changement de l'état du détecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2); 
      end;

      i:=adresse*8+1;
      if detecteur[i]<>((valeur and $1) = $1) then  // si changement de l'état du détecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1); 
      end;

    end;
    if bitsITT=$00 then // module d'aiguillages
    begin
      adraig:=(adresse * 4)+1;
      if (valeur and $C)=$8 then
      begin
        Event_Aig(adraig+1,const_droit,0);
        if trace then begin s:='accessoire '+intToSTR(adraig+1)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        Event_Aig(adraig+1,const_devie,0);
        if trace then begin s:='accessoire '+intToSTR(adraig+1)+'=1';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        Event_Aig(adraig,const_droit,0);
        if trace then begin s:='accessoire '+intToSTR(adraig)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        Event_Aig(adraig,const_devie,0);
        if trace then begin s:='accessoire '+intToSTR(adraig)+'=1';Affiche(s,clYellow);end;
      end;
    end;
  end;
end;


// décodage d'une chaine simple de la rétrosignalisation
function decode_chaine_retro(chaineINT : string) : string ;
var msg : string;
    i,cvLoc : integer;
begin
  //affiche(chaine_hex(chaine),clyellow);
  msg:='';
  ack:=true;nack:=false;
  // décodage du 3eme octet de la chaîne
  if chaineINT[1]=#1 then
  begin
    case chaineINT[2] of   // page 13 doc XpressNet
    #1 :  begin nack:=true;msg:='erreur timout transmission';end;
    #2 :  begin nack:=true;msg:='erreur timout centrale';end;
    #3 :  begin nack:=true;msg:='erreur communication inconnue';end;
    #4 :  begin succes:=true;msg:='succès';end;
    #5 :  begin nack:=true;msg:='plus de time slot';end;
    #6 :  begin nack:=true;msg:='débordement tampon LI100';end;
    end;
    if trace and (chaineINT[2]=#4) then Affiche(msg,clYellow);
    if trace and (chaineINT[2]<>#4) then Affiche(msg,clRed);
    delete(chaineINT,1,3);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#2 then
  begin
    msg:='Version matérielle '+intTohex(ord(chaineINT[2]),2)+' - Version soft '+intToHex(ord(chaineINT[3]),2);
    Affiche(msg,clYellow);
    delete(chaineINT,1,2);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#$61 then
  begin
    delete(chaineInt,1,1);
    case chaineINT[1] of
    #$00 : begin ack:=true;msg:='Voie hors tension';end;
    #$01 : begin ack:=true;msg:='Reprise';end;

    #$02 : begin ack:=true;msg:='Mode programmation ';end;

    #$80 : begin nack:=true;msg:='erreurs de transferts- Voir doc XpressNet p29';end;
    #$81 : begin nack:=true;msg:='Station occupée - Voir doc XpressNet p29';end;
    #$82 : begin nack:=true;msg:='Commande non implantée';end;
    else begin nack:=true;msg:='Réception inconnue';end;
    end;
    if nack then affiche(msg,clred) else affiche(msg,clyellow);
    delete(chaineINT,1,2);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if ((chaineINT[1]=#$63) and (chaineINT[2]=#$14)) then    // V3.6 uniquement
  begin
    // réception d'un CV. DocXpressNet p26   63 14 01 03 chk

    delete(chaineInt,1,2);
    cvLoc:=ord(chaineINT[1]);
    //Affiche('Réception CV'+IntToSTR(cvLoc)+' à '+IntToSTR(ord(chaineINT[2])),clyellow);
    if cvLoc>255 then Affiche('Erreur Recu CV>255',clRed)
    else
    begin
       tablo_cv[cvLoc]:=ord(chaineINT[2]);
       inc(N_Cv); // nombre de CV recus
    end;
    recu_cv:=true;
    delete(chaineInt,1,3);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#$42 then
  begin
    delete(chaineInt,1,1);
    decode_retro(ord(chaineInt[1]),ord(chaineInt[2]));
    delete(chaineInt,1,3);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#$81 then
  begin
    delete(chaineInt,1,2);
    Affiche('Voie hors tension msg1',clRed);
    Hors_tension2:=true;
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#$61 then
  begin
    delete(chaineInt,1,2);
    Affiche('Voie hors tension msg2',clRed);
    Hors_tension2:=false;
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#$46 then
  begin
    //FF FD 46 43 40 41 40 40 49 4D non documentée   
    //FF FD 46 43 50 41 50 40 50 54 non documentée
    Affiche('Chaine non documentée recue: '+chaine_HEX(chaineINT),clred);
    delete(chaineInt,1,8);
    Hors_tension2:=false;
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  i:=pos(#$46+#$43+#$50,chaineInt);
  if (i<>0) and (length(chaineInt)>=3) then
  begin
    delete(chaineInt,1,3);
    Affiche('Reprise msg 2',clOrange);
    Hors_tension2:=false;
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineInt[1]=#$81 then
  begin
    delete(chaineInt,1,2);
    Affiche('Court circuit msg 1',clRed);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  ack:=false;
  nack:=true;
  affiche('Erreur 7, chaîne rétrosig. inconnue recue:'+chaine_HEX(chaineINT),clred);
  decode_chaine_retro:='';
end;

// procédure appellée après réception sur le port USB ou socket
procedure interprete_reponse(chaine : string);
var chaineInt,msg : string;
    i,cv : integer;

begin
  chaineINT:=chaine;

  while length(chaineINT)>=3 do
  begin
    if length(chaineINT)>4 then
    begin
      // supprimer l'entete éventuelle
      if (chaineINT[1]=#$ff) and (chaineINT[2]=#$fe) then Delete(chaineINT,1,2);
      if (chaineINT[1]=#$ff) and (chaineINT[2]=#$fd) then Delete(chaineINT,1,2);
    end;
    chaineINT:=decode_chaine_retro(chaineINT);
  end;

end;

function HexToStr(s: string) : string ;
// transforme une chaîne 0A FF CA.. en chaine d'octets
var i,long,erreur : integer;
    st : string;
    v : byte;
begin
  long:=length(s);
  st:='';
  i:=1;
  repeat
    val('$'+copy(s,i,2),v,erreur);
    st:=st+char(v);
    inc(i,3);
  until (i>=long);
  HexToStr:=st;
end;


procedure deconnecte_CDM;
begin
 with Formprinc do
    begin
      ClientSocketCDM.close;
    end;
end;


{$J+}
// vérifie si version OS32 bits ou OS64 bits
function IsWow64Process: Boolean;
type
  TIsWow64Process = function(hProcess: THandle; var Wow64Process: Boolean): Boolean; stdcall;
var
  DLL: THandle;
  pIsWow64Process: TIsWow64Process;
const
  IsWow64: Boolean = False;
begin
  IsWow64:=false;
  DLL:=LoadLibrary('kernel32.dll');
  if (DLL<>0) then
  begin
    pIsWow64Process:=GetProcAddress(DLL,'IsWow64Process');
    if (Assigned(pIsWow64Process)) then
    begin
      pIsWow64Process(GetCurrentProcess,IsWow64);
    end;
    FreeLibrary(DLL);
  end;
  Result:=IsWow64;
end;
{$J-}

procedure connecte_USB;
begin
// initialisation de la comm USB
    if NumPort<>0 then
    begin
      With Formprinc.MSCommUSBLenz do
      begin
        Affiche('Demande ouverture com'+intToSTR(nuMPort)+':'+ConfStCom+' protocole '+IntToSTR(protocole),CLYellow);
        Settings:=ConfStCom;   // COMx:vitesse,n,8,1
        if protocole>=4 then Handshaking:=0 {0=aucun 1=Xon-Xoff 2=cts 3=RTS-Xon-Xoff 4=5=protocoles "maison"}
          else Handshaking:=protocole;

        SThreshold:=1;
        RThreshold:=1;
        CommPort:=NumPort;
        DTREnable:=True;
        if protocole=4 then RTSEnable:=True //pour la genli
        else RTSenable:=False;

        InputMode:=comInputModeBinary;
      end;
      portCommOuvert:=true;
      try
         Formprinc.MSCommUSBLenz.portopen:=true;
      except
        portCommOuvert:=false;
      end;
    end
      else
        begin
          portCommOuvert:=false;
          Affiche('Port Com nul dans le fichier de configuration',clyellow);
        end;

    if portCommOuvert then
    begin
      affiche('port COM'+intToSTR(NumPort)+' ouvert',clGreen);
      With Formprinc do
      begin
        LabelTitre.caption:=titre+' Interface connectée au COM'+IntToSTR(NumPort);
        MenuConnecterUSB.enabled:=false;
        DeConnecterUSB.enabled:=true;
        ConnecterCDMRail.enabled:=false;
        DeConnecterCDMRail.enabled:=false;
      end;  
    end
    else
      begin
        Affiche('port COM'+intToSTR(NumPort)+' NON ouvert',clRed)  ;
      end;
end;


procedure TFormPrinc.FormCreate(Sender: TObject);
var
   i,j : integer;
   s,s2,Url,LocalFile : string;
   trouve,AvecMaj : Boolean;
   V_utile : real;
begin
  //AvecMaj:=false;
  TraceSign:=True;
  PremierFD:=false;
  AF:='Client TCP-IP CDM Rail ou USB - système LENZ - Version '+Version;
  Caption:=AF;
  Application.onHint:=doHint;

  // version d'OS pour info
  if IsWow64Process then s:='OS 64 Bits' else s:='OS 32 Bits';
  s:=DateToStr(date)+' '+TimeToStr(Time)+' '+s;
  Affiche(s,clLime);
  LabelEtat.Caption:='Initialisations en cours';

  //Menu_interface(devalide);

  // créée la fenetre debug
  FormDebug:=TFormDebug.Create(Self);
  FormDebug.Caption:=AF+' debug';
  N_Trains:=0;
  NivDebug:=0;
  TempoAct:=0;
  DebugOuv:=True;

  AvecInit:=true; //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  AvecTCO:=false;

  // créée la fenetre vérification de version
  FormVersion:=TformVersion.Create(Self);

  ferme:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  Nbre_recu_cdm:=0;
  AffMem:=true;
  N_routes:=0;
  N_trains:=0;
 // Train[1].index:=0;

  // lecture fichier de configuration  config.cfg
  lit_config;
  
  // TCO
  if avectco then
  begin
    //créée la fenêtre TCO
    FormTCO:=TformTCO.Create(Self);
    FormTCO.show;
    //construit_TCO;
    //affiche_TCO;
    //Formprinc.Hide;
  end;  


 
  // tenter la liaison vers CDM rail ou vers la centrale Lenz
  //Affiche('Test présence CDM',clYellow);
  connecte_CDM;
  if not(CDM_connecte) then        // si CDM est connecté, on n'ouvre pas de liaison vers la centrale
  begin
    Affiche('CDM absent - Ouverture liaison vers centrale Lenz',clYellow);
    // ouverture par USB
    Affiche('demande connexion à la centrale Lenz par USB',clyellow);
    connecte_USB;
    if not(portCommOuvert) then
    begin
      // sinon ouvrir socket vers la centrale
      // Initialisation de la comm socket LENZ
      if AdresseIP<>'0' then
      begin
        Affiche('demande connexion à la centrale Lenz par Ethernet',clyellow);
        ClientSocketLenz.port:=port;
        ClientSocketLenz.Address:=AdresseIP;
        ClientSocketLenz.Open;
      end
    end;
  end;
  
  if portCommOuvert or parsocket then
  With Formprinc do
  begin
    ButtonEcrCV.Enabled:=true;
    LireunfichierdeCV1.enabled:=true;
    ButtonLitCV.Enabled:=true;
  end
  else
  With Formprinc do
  begin
    ButtonEcrCV.Enabled:=false;
    ButtonLitCV.Enabled:=false;
    LireunfichierdeCV1.enabled:=false;
  end ;
  
  // Initialisation des images des signaux
  NbreImagePLigne:=Formprinc.ScrollBox1.Width div (largImg+5);

  // ajoute une image dynamiquement
  for i:=1 to NbreFeux do
  begin
    cree_image(i);  // et initialisation tableaux signaux
  end;
  Tempo_init:=10;  // démarre les initialisation des signaux et des aiguillages dans 1 s

  // initialisation de la chronologie des évènements détecteurs
  for i:=0 to Max_Event_det_tick do
  begin
    event_det_tick[i].aiguillage:=-1;
    //for j:=1 to 1100 do
    //event_det_tick[i].detecteur[j]:=-1;   // initialiser les détecteurs à -1
    event_det_tick[i].detecteur:=-1;
    event_det_tick[i].etat:=-1;
    event_det_tick[i].aiguillage:=-1;
    event_det_tick[i].actionneur:=-1;
    event_det_tick[i].traite:=false ; // non traité
  end;
           
  I_Simule:=0;
  tick:=0;

  N_Event_tick:=0 ; // dernier index
  NombreImages:=0;

  //essai
  //maj_feu(201);
// formdebug.Show;
 //AfficheDet:=true;
  //NivDebug:=3;
  //Aiguille_deviee(462);
  //aiguillageB[1].Position:=1;
  //i:=suivant_alg3(553,1,1,3,1);
  //Affichedebug(intToSTr(i),clred);
  //Affiche(IntToSTR(calcul_zones_det(522,514)),clyellow);
  
  //i:=detecteur_suivant_El(514,1,518,1);  // donne l'élément suivant de AdrPrec à AdrFonc et dans Bis si c'est un aig bis
  //i:=etat_signal_suivant(1001,1);
 // Affiche(IntToSTR(detecteur_suivant(25,2,529,1)),clyellow);
  //i:=Aiguille_deviee(176);
  //signal_direction(372);
  //FormDebug.show;
  //test_memoire_zones(218);
  //Det_Adj(520);
  //Affiche(' Adj1='+intToStr(Adj1)+' Adj2='+intToStr(Adj2),clyellow);
  //trace:=true;
  //TraceListe:=true;
  //interprete_reponse(#$FF+#$FD+#$46+#$43+#$40+#$41+#$40+#$40+#$49+#$4D);
  Affiche('Fin des initialisations',clyellow);
  
  //Menu_interface(valide);
  //s:=#$f0;
  //s:=checksum(s);
  //envoi(s);
  //id_cdm:='01';
  //envoie_fonction_CDM(0,1,'train');
  //i:=ShellExecute(handle,PChar('open'),PChar('C:\Program Files (x86)\CDM-Rail\cdr.exe'),nil,nil,SW_SHOWNORMAL);
end;


// évènement réception d'une trame sur le port COM USB (centrale Lenz)
procedure TFormPrinc.MSCommUSBLenzComm(Sender: TObject);
var i : integer;
begin
  //trace:=true;
  if MSCommUSBLenz.commEvent=comEvReceive then
  begin
    TpsRecuCom:=0;
    tablo:=MSCommUSBLenz.Input;
    for i:=0 to length(tablo)-1 do
    begin
      chaine_recue:=chaine_recue+char(tablo[i]);
    end;
    if trace then Affiche('Tick='+IntToSTR(tick)+'/Rec '+chaine_Hex(chaine_recue),Clwhite);
    if terminal then Affiche(chaine_recue,clLime);
    interprete_reponse(chaine_recue);
    chaine_recue:='';
  end;
end;

procedure TFormPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Ferme:=true;
  if portCommOuvert then begin portCommOuvert:=false;MSCommUSBLenz.Portopen:=false; end;
  portCommOuvert:=false;
  ClientSocketCDM.close;
  ClientSocketLenz.close;
end;


procedure init_aiguillages;
var i,pos : integer;
    s : string;
begin
  Affiche('Positionnement aiguillages',cyan);
  for i:=1 to maxaiguillage do
  begin
    if aiguillage[i].modele<>0 then // si l'aiguillage existe
    begin
      pos:=aiguillage[i].position;
      s:='Init aiguillage '+intToSTR(i)+'='+intToSTR(pos);
      if pos=1 then s:=s+' (dévié)' else s:=s+' (droit)';
      Affiche(s,cyan);
      pilote_acc(i,pos,aig);
      application.processMessages;
    end;
  end;
  with formprinc do
  begin
    //Menu_interface(valide);
  end;

end;



// timer à 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var index,aspect,i,a,x,y,adresse,TailleX,TailleY : integer;
   imageFeu : Timage;
   frx,fry : real;
    s : string;
begin
  inc(tick);

  if Tempo_init>0 then dec(Tempo_init);
  if (Tempo_init=1) and AvecInit then
  begin
    if not(ConfigNulle) then Affiche('Positionnement des feux',clYellow);
    if not(ferme) and not(ConfigNulle) then envoi_signauxCplx;  // initialisation des feux
    if not(ConfigNulle) and not(ferme) and (AvecInitAiguillages=1) then
    begin
      Affiche('Positionnement des aiguillages',clYellow);
      init_aiguillages;   // initialisation des aiguillages
    end;
    if (AvecInitAiguillages=0) and not(ferme) and (parSocket or portCommOuvert) then
    begin
      demande_etat_acc;   // demande l'état des accessoires (position des aiguillages)
    end;
    LabelEtat.Caption:=' ';
    Menu_interface(valide);
  end;

  if temps>0 then dec(temps);

  // gestion du clignotant des feux
  if tempsCli>0 then dec(tempsCli);
  if tempsCli=0 then
  begin
    tempsCli:=5;
    clignotant:=not(clignotant);
    //tester chaque feu pour voir s'il y a un code de clignotement
    for i:=1 to NbreFeux do
    begin
      adresse:=feux[i].adresse;
      a:=EtatsignalCplx[adresse];     // a = état binaire du feu
      if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
         TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
         testBit(a,vert_cli) or testbit(a,blanc_cli) then
         begin
           //Affiche(IntToSTR(adresse),clOrange);
           Dessine_feu_mx(Feux[i].Img.Canvas,0,0,1,1,adresse,1);
         end;  
    end;

    if avecTCO then
    begin
      for i:=1 to NbFeuTCO do
      begin
        x:=(FeuTCO[i].x-1)*LargeurCell;
        y:=(FeuTCO[i].y-1)*HauteurCell;
        adresse:=FeuTCO[i].adresse;
        if adresse<>0 then
        begin
          index:=index_feu(adresse);
          if index<>0 then
          begin
            aspect:=feux[index].aspect;
            case aspect of
             2 :  ImageFeu:=Formprinc.Image2feux;
             3 :  ImageFeu:=Formprinc.Image3feux;
             4 :  ImageFeu:=Formprinc.Image4feux;
             5 :  ImageFeu:=Formprinc.Image5feux;
             7 :  ImageFeu:=Formprinc.Image7feux;
             9 :  ImageFeu:=Formprinc.Image9feux;
           else ImageFeu:=Formprinc.Image3feux;
           end;
  
            TailleY:=ImageFeu.picture.BitMap.Height; // taille du feu d'origine  (verticale)
            TailleX:=ImageFeu.picture.BitMap.Width; 
            frx:=LargeurCell/TailleX;
            frY:=2*HauteurCell/TailleY;
          
            a:=EtatsignalCplx[adresse];     // a = état binaire du feu
            if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
            TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
            testBit(a,vert_cli) or testbit(a,blanc_cli) then 
            Dessine_feu_mx(PCanvasTCO,x,y,frx,fry,adresse,1);
          end;
        end;
      end;
    end;

    // fenêtre de pilotage manuel du feu
    if AdrPilote<>0 then
    begin
      a:=EtatsignalCplx[0];
      if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
         TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
         testBit(a,vert_cli) or testbit(a,blanc_cli) then
         Dessine_feu_pilote;  // dessiner le feu en fonction du bit "clignotant"
    end;
  end;

  // affiche la trame recue de l'interface après 500ms
  if TpsRecuCom<5 then inc(TpsRecuCom);
  if TpsRecuCom=5 then
  begin
    if trace then Affiche_chaine_hex(chaine_recue,clFuchsia); // en hexa ascii
    chaine_recue:='';
    TpsRecuCom:=6;
  end;

  if (not(Maj_feux_cours) and (Tempo_chgt_feux=1)) then Maj_feux(); // mise à jour des feux sur chgt aiguillage

  if (not(Maj_feux_cours) and (Tempo_chgt_feux>0)) then dec(Tempo_chgt_feux);

  // tempo retombée actionneur
  if TempoAct<>0 then
  begin
    dec(tempoAct);
    if tempoAct=0 then
    begin
      A:=Tablo_actionneur[RangActCours].actionneur;
      s:=Tablo_actionneur[RangActCours].train;
      Affiche('Actionneur '+intToSTR(a)+' F'+IntToSTR(Tablo_actionneur[RangActCours].fonction)+':0',clyellow);
      envoie_fonction_CDM(Tablo_actionneur[RangActCours].fonction,0,s);
    end;
  end;

  //simulation
  if (index_simule<>0) then
  begin
    if not(MsgSim) then 
    begin 
      Affiche('Simulation en cours ',Cyan);MsgSim:=true;
      N_Event_tick:=0;
      N_event_det:=0;
      N_trains:=0;
      for i:=1 to Max_Trains do Event_det_Train[i].NbEl:=0;
      FormDebug.MemoEvtDet.Clear;
      FormDebug.Richedit.Clear;
    end;
    while tick=Tablo_simule[i_simule+1].tick do
    begin
      inc(I_simule);
      
      // evt détecteur ?
      if Tablo_simule[i_simule].detecteur<>0 then
      begin
       // if i_simule=164 then 
       // begin
       // if Tablo_simule[i_simule].detecteur=538 then Affiche('création evt 538 index '+intToSTR(i_simule),clorange);
       // end;
      
        if AffTickSimu then Affiche('Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' det='+intToSTR(Tablo_simule[i_simule].detecteur)+'='+IntToSTR(Tablo_simule[i_simule].etat),Cyan);
        Event_Detecteur(Tablo_simule[i_simule].detecteur, Tablo_simule[i_simule].etat=1);  // créer évt détecteur
      end;
      // evt aiguillage ?
      if Tablo_simule[i_simule].aiguillage<>0 then
      begin
        if AffTickSimu then Affiche('Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' aig='+intToSTR(Tablo_simule[i_simule].aiguillage)+'='+IntToSTR(Tablo_simule[i_simule].etat),Cyan);
        Event_Aig(Tablo_simule[i_simule].Aiguillage,Tablo_simule[i_simule].etat,0);  // créer évt aiguillage
      end;

    end;
    if i_Simule>=Index_simule then
    begin
      Index_Simule:=0;  // fin de simulation
      I_Simule:=0;
      MsgSim:=false;
      Affiche('Fin de simulation',Cyan);
    end;
  end;

end;

// bouton version centrale Lenz
procedure TFormPrinc.BoutVersionClick(Sender: TObject);
var s : string;
begin
  s:=#$f0;
  s:=checksum(s);
  envoi(s);
end;

// bouton de commande d'un accessoire
procedure TFormPrinc.ButtonCommandeClick(Sender: TObject);
var adr,valeur,erreur : integer;
begin
  val(EditAdresse.text,adr,erreur);
  if (erreur<>0) or (adr<1) or (adr>2048) then 
  begin
    EditAdresse.text:='1';
    exit;
  end;

  val(EditVal.Text,valeur,erreur);
  if (erreur<>0) or (valeur<0) or (valeur>255) then 
  begin
    EditVal.text:='1';
    exit;
  end;  

  pilote_acc(adr,valeur,aig);
end;

procedure TFormPrinc.EditvalEnter(Sender: TObject);
begin
  if (Editval.Text<>'1') and (Editval.Text<>'2') then editval.text:='1';
end;

// gestion de la couleur des textes de la list box
procedure TFormPrinc.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  //with control as Tlistbox do
  with listbox1.Canvas do
  begin
    Font.color:=Tcolor(ListBox1.Items.Objects[index]);
    TextOut(Rect.Left,Rect.Top+4,ListBox1.Items[index]);
  end;
end;

procedure TFormPrinc.BoutonRafClick(Sender: TObject);
begin
  rafraichit;
end;

// erreur sur socket
procedure TFormPrinc.ClientSocketLenzError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var   s : string;
begin
   s:='Erreur '+IntToSTR(ErrorCode)+' socket IP Lenz';
   case ErrorCode of
   10053 : s:=s+': Connexion avortée - Timeout';
   10054 : s:=s+': Connexion avortée par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refusée';
   10065 : s:=s+': Port non connecté';
   end;
   if ErrorCode<>10060 then
   begin
     affiche(s,ClRed);
     afficheDebug(s,ClRed);
   end;  
   parSocket:=false;
   ErrorCode:=0;
end;


procedure TFormPrinc.ClientSocketCDMError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  var     s : string;
begin
   s:='Erreur '+IntToSTR(ErrorCode)+' socket IP CDM Rail';
   case ErrorCode of
   10053 : s:=s+': Connexion avortée - Timeout';
   10054 : s:=s+': Connexion avortée par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refusée';
   10065 : s:=s+': Port non connecté';
   end;
   affiche(s,ClRed);
   afficheDebug(s,ClRed);
   CDM_connecte:=false;
   LabelTitre.caption:=titre;
   ErrorCode:=0;
end;

// lecture depuis socket
procedure TFormPrinc.ClientSocketLenzRead(Sender: TObject;
  Socket: TCustomWinSocket);
var s : string;
begin
  s:=ClientSocketLenz.Socket.ReceiveText;
  if trace then affiche(chaine_hex(s),clWhite);
  interprete_reponse(s);
end;

procedure TFormPrinc.ButtonTestClick(Sender: TObject);
begin
  demande_etat_acc;
end;

// procédure Event appelée si on clique sur un checkbox des images des feux
procedure TFormprinc.proc_checkBoxFB(Sender : Tobject);
var Index,adr : integer;
    coche : boolean;
begin
  Maj_feux ;              // évalue l'état des signaux
end;


procedure TFormPrinc.ButtonInfoClick(Sender: TObject);
begin
  Affiche('Ce programme pilote des signaux complexes de façon autonome ou avec CDM rail ',ClYellow);
  Affiche('En fonction des détecteurs mis à 1 ou 0 par des locomotives',ClYellow);
  Affiche('en circulation sur le réseau',ClYellow);
  Affiche('Il est nécessaire de renseigner le fichier config.cfg',ClOrange);
  Affiche('En vert : Trames envoyées à l''interface',ClWhite);
  Affiche('En blanc : Trames reçues de l''interface',ClWhite);
  Affiche('En violet : Trames brutes reçues de l''interface',ClWhite);
  Affiche('En rouge : erreurs et défauts',ClWhite);
  Affiche('En orange : pilotage des signaux',ClWhite);
  Affiche('En bleu : pilotage des aiguillages',ClWhite);
  Affiche('En jaune : rétrosignalisation reçue depuis l''interface',ClWhite);
end;

procedure TFormPrinc.MenuConnecterUSBClick(Sender: TObject);
begin
  Hors_tension2:=false;
  connecte_USB;
end;

procedure deconnecte_usb;
begin
  Ferme:=true;
  if portCommOuvert then 
  begin
    portCommOuvert:=false;
    Formprinc.MSCommUSBLenz.Portopen:=false; 
  end;

  portCommOuvert:=false;
  with formprinc do
  begin
    ClientSocketLenz.close;
    MenuConnecterUSB.enabled:=true;
    DeConnecterUSB.enabled:=false;
    ConnecterCDMRail.enabled:=true;
    DeConnecterCDMRail.enabled:=false;
  end;  
end;

procedure TFormPrinc.DeconnecterUSBClick(Sender: TObject);
begin
  deconnecte_usb;
end;

procedure TFormPrinc.MenuConnecterEthernetClick(Sender: TObject);
begin
if AdresseIP<>'0' then
  begin
    ClientSocketLenz.port:=port;
    ClientSocketLenz.Address:=AdresseIP;
    ClientSocketLenz.Open;
    Hors_tension2:=false;
  end;
end;

procedure TFormPrinc.MenuDeconnecterEthernetClick(Sender: TObject);
begin
  ClientSocketLenz.Close;
end;

function cde_cdm(s : string) : string;
var i : integer;
begin
  i:=length(s)-1;
  cde_cdm:='0'+IntToSTR(i)+s;
end;

procedure TFormPrinc.locoClick(Sender: TObject);
begin
  // vitesse et direction 18 pas
  vitesse_loco(3,20,true);
end;

procedure TFormPrinc.AffEtatDetecteurs(Sender: TObject);
var j,adr,NBranche : integer;
    s : string;
begin
  for j:=1 to NDetecteurs do
  begin
   s:='Dét '+intToSTR(Adresse_detecteur[j])+'=';
   if Detecteur[adresse_detecteur[j]] then s:=s+'1' else s:=s+'0';
   //s:=s+' Mem=';
   //if Mem[adresse_detecteur[j]] then s:=s+'1' else s:=s+'0';
   Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Etatdesaiguillages1Click(Sender: TObject);
var i,j,model,objet : integer;
    s : string;
begin
  Affiche('les positions des aiguillages BIS sont les mêmes que leurs homologues non bis',Cyan);
  for i:=1 to MaxAcc do
  begin
    model:=aiguillage[i].modele ;
    if model<>0 then
    begin
      s:='Aiguillage '+IntToSTR(i)+' : '+intToSTR(aiguillage[i].position);
      if aiguillage[i].position=1 then s:=s+' (dévié)' else s:=s+' (droit)';
      objet:=aiguillage[i].objet;
      if objet<>0 then s:=s+' objet='+intToSTR(objet);
      if model=4 then // aig triple
      begin
        j:=aiguillage[i].AdrTriple;
        s:=s+' Aig '+IntToSTR(j)+': '+intToSTR(aiguillage[j].position);
        if aiguillage[j].position=1 then s:=s+' (dévié)' else s:=s+' (droit)';
      end;
      Affiche(s,clWhite);
    end;
  end;
end;

procedure TFormPrinc.Codificationdesaiguillages1Click(Sender: TObject);
var i : integer ;
    s : string;
begin
  Affiche('Codification interne des aiguillages',Cyan);
  Affiche('D=position droite S=position déviée P=pointe Z=détecteur',Cyan);
  for i:=1 to MaxAiguillage do
  begin
    s:=IntToSTR(i);
    if aiguillage[i].modele<>0 then
    begin
      if aiguillage[i].modele=1 then s:=s+' Pointe=';
      if aiguillage[i].modele=2 then s:=s+' TJD: centre TJD=';
      if aiguillage[i].modele=3 then s:=s+' TJS:';
      if aiguillage[i].modele=4 then s:=s+' Triple: Pointe=';
      s:=s+IntToSTR(aiguillage[i].APointe)+aiguillage[i].APointeB+
         ' Dévie='+IntToSTR(aiguillage[i].ADevie)+aiguillage[i].ADevieB+
         ' Droit='+IntToSTR(aiguillage[i].ADroit)+aiguillage[i].ADroitB;
      if aiguillage[i].modele=4 then s:=s+' Dévié2='+intToSTR(aiguillage[i].ADevie2)+aiguillage[i].ADevie2B;
      if aiguillage[i].vitesse<>0 then s:=s+' Vitesse déviée='+intToSTR(aiguillage[i].vitesse);
      if aiguillage[i].inversion<>0 then s:=s+' pilotage inversé';
      
      Affiche(s,clYellow);
    end;
  end;

  for i:=1 to MaxAiguillage do
  begin
    s:=IntToSTR(i)+'BIS';
    if aiguillageB[i].modele<>0 then
    begin
      if aiguillageB[i].modele=1 then s:=s+' Pointe=';
      if aiguillageB[i].modele=2 then s:=s+' TJD: centre TJD=';
      if aiguillageB[i].modele=3 then s:=s+' TJS:';
      if aiguillageB[i].modele=4 then s:=s+' Triple: Pointe=';
      s:=s+IntToSTR(aiguillageB[i].APointe)+aiguillageB[i].APointeB+
         ' Dévie='+IntToSTR(aiguillageB[i].ADevie)+aiguillageB[i].ADevieB+
         ' Droit='+IntToSTR(aiguillageB[i].ADroit)+aiguillageB[i].ADroitB;
      if aiguillageB[i].modele=4 then s:=s+' Dévié2='+intToSTR(aiguillageB[i].ADevie2)+aiguillageB[i].ADevie2B;
      if aiguillageB[i].vitesse<>0 then s:=s+' Vitesse déviée='+intToSTR(aiguillageB[i].vitesse);
      if aiguillageB[i].inversion<>0 then s:=s+' pilotage inversé';
      if aiguillageB[i].inversionCDM<>0 then s:=s+' lecture CDM inversée';
      Affiche(s,clYellow);
    end;  
  end;
end;


procedure TFormPrinc.ClientSocketLenzConnect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Lenz connecté ',clYellow);
  AfficheDebug('Lenz connecté ',clYellow);
  parSocket:=True;
  ButtonEcrCV.Enabled:=true;
  ButtonLitCV.Enabled:=true;
  LireunfichierdeCV1.enabled:=true;
  LabelTitre.caption:=titre+' Interface connectée par Ethernet';
end;

procedure TFormPrinc.ClientSocketCDMConnect(Sender: TObject;Socket: TCustomWinSocket);
var s : string;
begin
  s:='Socket CDM rail connecté';
  LabelTitre.caption:=titre+' '+s;
  Affiche(s,clYellow);
  AfficheDebug(s,clYellow);
  parSocketCDM:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  
end;

procedure Interprete_trameCDM(recuCDM : string);
var i,objet,posST,posAC,posDT,k,l,erreur, adr,adr2,etat,etataig,etatAig2,name : integer ;
      s,ss,train : string;
      traite,sort : boolean;
begin
  AckCDM:=recuCDM<>'';
  if pos('ACK',recuCDM)=0 then
  begin
    if pos('ERR=200',recuCDM)<>0 then Affiche('Erreur CDM : réseau non chargé',clred);
  end;
  k:=0;
  repeat
    //Affiche('K='+intToSTR(k)+' longueur='+intToSTR(length(recuCDM)),clyellow);
    // évènement aiguillage. Le champ AD2 n'est pas forcément présent
    posST:=pos('CMDACC-ST_TO',recuCDM);
    if posST<>0 then
    begin
      //Affiche(recuCDM,cllime);
      objet:=0;
      i:=posEx('OBJ=',recuCDM,posST);ss:=copy(recuCDM,i+4,10);
      if i<>0 then val(ss,objet,erreur) else 
        Affiche('Erreur pas d''objet ',clred);
      
      
      i:=posEx('AD=',recuCDM,posST);ss:=copy(recuCDM,i+3,10);  //Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
      if i<posST then begin Affiche('Erreur 96',clred);exit;end;
      val(ss,adr,erreur);
        
      //Affiche(copy(recuCDM,j,i+80),clOrange);
      //i:=posEx('AD2=',recuCDM,i);ss:=copy(recuCDM,i+3,10);  Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
      //val(ss,adr2,erreur);
      i:=posEx('STATE=',recuCDM,i);ss:=copy(recuCDM,i+6,10); //Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
      if i<posST then begin Affiche('Erreur 97',clred);exit;end;
      if i+5-posST>0 then begin Delete(recuCDM,posST,i+5-posST) ;end else
      begin
        s:='Erreur 95 posST='+IntToSTR(posST)+' i='+intToSTR(i);
        Affiche(s,clred);
        Nbre_recu_cdm:=0;
        Affiche(recuCDM,clred);
        exit;
      end;
      val(ss,etat,erreur);
      //Affiche('Aiguillage CDM '+intToSTR(adr)+'='+IntToStr(etat)+' objet='+intToSTR(objet),clLime);
      // conversion en position :
      // CDM:  0=droit 1=droite 3=gauche
      // logiciel : 1=dévié   2=droit
      
      // aiguillage normal
      if aiguillage[adr].modele=1 then 
      begin       
        //Affiche('Normal',clyellow);               
        if etat=0 then etatAig:=2 else etatAig:=1;
        Event_Aig(adr,etatAig,objet);
      end;
      // TJD TJS
      if (aiguillage[adr].modele=2) or (aiguillage[adr].modele=3) then 
      begin                      
        //Affiche('TJDS',clyellow);
        adr2:=aiguillage[adr].Apointe;  // 2eme adresse de la TJD
        case etat of
        1 : begin etatAig:=1;EtatAig2:=2;end;
        4 : begin etatAig:=1;EtatAig2:=1;end;
        5 : begin etatAig:=2;EtatAig2:=1;end;
        0 : begin etatAig:=2;EtatAig2:=2;end;
        end;
        Event_Aig(adr,etatAig,objet);
        Event_Aig(adr2,etatAig2,objet);
      end;
      if aiguillage[adr].modele=4 then // aiguillage triple
      begin
        //Affiche('Triple',clyellow);
        // état de l'aiguillage 1
        if (etat=0) or (etat=2) then etatAig:=2;
        if etat=3 then etatAig:=1;
        // état de l'aiguillage 2
        adr2:=aiguillage[adr].AdrTriple;
        if (etat=0) or (etat=3) then etatAig2:=2;
        if etat=2 then etatAig2:=1;
        Event_Aig(adr,etatAig,objet);
        Event_Aig(adr2,etatAig2,objet);
      end;

      Tempo_chgt_feux:=10; // demander la mise à jour des feux

      //Affiche(recuCDM,CLOrange);
      //if length(recuCDM)>80 then Affiche(copy(recuCDM,80,length(recuCDM)-80),clOrange);
    end;

    // évènement détecteur
    posDT:=pos('CMDACC-ST_DT',recuCDM);
    if posDT<>0 then
    begin
      i:=posEx('AD=',recuCDM,posDT);ss:=copy(recuCDM,i+3,10);
      val(ss,adr,erreur);
      i:=posEx('STATE=',recuCDM,posDT);ss:=copy(recuCDM,i+6,10);
      Delete(recuCDM,posDT,i+5-posDT);
      val(ss,etat,erreur);
      Event_detecteur(Adr,etat=1);
      //Affiche(IntToSTR(adr)+' '+IntToSTR(etat),clyellow);
      if AfficheDet then Affiche('Rétro Détecteur '+intToSTR(adr)+'='+IntToStr(etat),clYellow);
    end ;

    // évènement actionneur
    // attention un actionneur qui repasse à 0 ne contient pas de nom de train
    //S-E-03-0157-CMDACC-ST_AC|049|05|NAME=0;OBJ=7101;AD=815;TRAIN=CC406526;STATE=1;
    posAC:=pos('CMDACC-ST_AC',recuCDM);
    if posAC<>0 then
    begin
      i:=posEx('AD=',recuCDM,posAC);ss:=copy(recuCDM,i+3,10);
      val(ss,adr,erreur);
      i:=posEx('NAME=',recuCDM,posAC);ss:=copy(recuCDM,i+5,10);
      val(ss,name,erreur);
      i:=posEx('TRAIN=',recuCDM,posAC);l:=PosEx(';',recuCDM,i);
      train:=copy(recuCDM,i+6,l-i-6);
      i:=posEx('STATE=',recuCDM,posAC);ss:=copy(recuCDM,i+6,10);
      val(ss,etat,erreur);
      Delete(recuCDM,posAC,i-posAC);
      i:=pos(';',recuCDM);
      if i<>0 then Delete(recuCDM,1,i);
      if AfficheDet then
        Affiche('Actionneur AD='+intToSTR(adr)+' Nom='+intToSTR(name)+' Train='+train+' Etat='+IntToSTR(etat),clyellow);
      Event_act(adr,etat,train); // déclenche évent actionneur
    end;

    inc(k);
    //traite:=(k<30) or (pos('CMDACC-ST_TO',recuCDM)<>0) or (pos('CMDACC-ST_DT',recuCDM)<>0) ;
    sort:=(k>70) or (posST=0) and (posDT=0) and (posAC=0);
  until (sort);

  //Affiche('Ligne traitée'+recuCDM,clLime);
  if k>=70 then begin Affiche('Erreur 90 : Longrestante='+IntToSTR(length(recuCDM)),clred); Affiche(recuCDM,clred);  end;
  Nbre_recu_cdm:=0;
end;

// réception d'un message de CDM rail
procedure TFormPrinc.ClientSocketCDMRead(Sender: TObject;Socket: TCustomWinSocket);
  var i,j,k,l,erreur, adr,adr2,etat,etataig,etatAig2,name : integer ;
      s,ss,train : string;
      traite,sort : boolean;
begin
  inc(Nbre_recu_cdm);
  recuCDM:=ClientSocketCDM.Socket.ReceiveText;
  if trace then begin Affiche('recu de CDM:',clWhite);Affiche(recuCDM,clWhite);end;
  Interprete_trameCDM(recuCDM);
end;


procedure TFormPrinc.ButtonAffDebugClick(Sender: TObject);
begin
  formDebug.show;
end;

procedure TFormPrinc.ConnecterCDMrailClick(Sender: TObject);
begin
  connecte_CDM;
end;

procedure TFormPrinc.DeconnecterCDMRailClick(Sender: TObject);
begin
  deconnecte_CDM;
end;

procedure TFormPrinc.ClientSocketCDMDisconnect(Sender: TObject;  Socket: TCustomWinSocket);
begin
  LabelTitre.caption:=Titre;
  Affiche('CDM rail déconnecté',Cyan);
  AfficheDebug('CDM rail déconnecté',Cyan);
  CDM_connecte:=False;
  MenuConnecterUSB.enabled:=true;
  DeConnecterUSB.enabled:=true;
  ConnecterCDMRail.enabled:=true;
end;


procedure TFormPrinc.Codificationdesfeux1Click(Sender: TObject);
var i,j,k,NfeuxDir,adresse : integer;
    s : string;
begin
  Affiche('Codification interne des feux',Cyan);

  for i:=1 to NbreFeux do
  begin
    // feu de signalisation
    s:=IntToSTR(i)+' Adr='+IntToSTR(feux[i].Adresse);
    s:=s+' décodeur='+IntToStr(feux[i].decodeur);

    if feux[i].aspect<10 then
    begin
      s:=s+' SIG Nbre de feux='+IntToSTR(feux[i].aspect)+' ';
      s:=s+' El_Suivant1='+IntToSTR(feux[i].Adr_el_suiv1)+' Type suivant1='+intToSTR(feux[i].Btype_suiv1);
      case feux[i].Btype_suiv1 of
      1 : s:=s+' (détecteur)';
      2 : s:=s+' (aiguillage ou TJD-S)';
      4 : s:=s+' (aiguillage triple)';
      5 : s:=s+' (aiguillage bis)';
      end;
      if feux[i].decodeur=6 then
      s:=s+' Cible unisemaf='+intToSTR(feux[i].Unisemaf);
    end
    else
    // feu directionnel
    begin
      s:=s+' DIR Nbre de feux='+IntToSTR(feux[i].aspect-10)+' ';
      NfeuxDir:=feux[i].aspect-10;
      for j:=1 to NfeuxDir+1 do
      begin
        s:=s+'(';
        for k:=1 to Length(feux[i].AigDirection[j])-1 do
        begin
          s:=s+IntToSTR(feux[i].AigDirection[j][k].adresse) + feux[i].AigDirection[j][k].posaig+' ';
        end;
        s:=s+')';
      end;
    end;
    Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Versions1Click(Sender: TObject);
begin
   Affiche('Version 1.0  : première version',clLime);
   Affiche('Version 1.01 : gestion des trajectoires vers les buttoirs',clLime);
   Affiche('Version 1.02 : vérification automatique des versions',clLime);
   Affiche('Version 1.1  : gestion des tableaux indicateurs de direction',clLime);
   Affiche('                    gestion du décodeur de signaux Unisemaf Paco (expérimental)',clLime);
   Affiche('                    changement dynamique des feux en cliquant sur son image',clLime);
   Affiche('Version 1.11 : compatibilité pour la rétrosignalisation non XpressNet (intellibox)',clLime);
   Affiche('                    verrouillages routes pour trains consécutifs',clLime);
   Affiche('Version 1.2  : Renforcement de l''algorithme de suivi des trains',clLime);
   Affiche('Version 1.3  : Décodeur Unisemaf fonctionnel - Lecture/écriture des CV',clLime);
   Affiche('                     Protocoles variables de l''interface',clLime);
   Affiche('                     Configuration statique modifiable dans menu',clLime);
   Affiche('Version 1.31 : Correction des positions aiguillages triples et TJD',clLime);
   Affiche('Version 1.4  : Gestion des Fx vers les locomotives par actionneurs',clLime);
   Affiche('Version 1.41 : Gestion des passages à niveaux par actionneurs',clLime);
   Affiche('Version 1.42 : Correction erreur lecture feux',clLime);
   Affiche('Version 1.43 : Correction erreur gestion sémaphore',clLime);
   Affiche('Version 1.44 : Gestion trains avec voitures éclairées',clLime);
   Affiche('Version 1.45 : Rejette les n° d''objets supérieurs aiguillages à la même adresse',clLime);
   Affiche('Version 1.5  : Nouvel algorithme de suivi des trains',clLime);
   
end;

procedure TFormPrinc.ClientSocketLenzDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  parSocket:=False;
end;

procedure TFormPrinc.ChronoDetectClick(Sender: TObject);
var i,j,etat : integer;
    s : string;
begin
  if N_event_tick=0 then
  begin
    Affiche('Aucun évenèment détecteur ou aiguillage',clYellow);
  end;
  for i:=1 to N_Event_tick do
  begin

    //for j:=1 to 1100 do
    begin
      j:=event_det_tick[i].detecteur;
      if j<>-1 then
      begin
        s:=IntToSTR(i)+' Tick='+IntToSTR(event_det_tick[i].tick);
        s:=s+' Det='+IntToSTR(j)+'='+intToSTR(event_det_tick[i].etat);
       // s:=s+' Det suiv='+intTostr(event_det_tick[i].suivant);
        Affiche(s,clyellow);
      end;
    end;

    j:=event_det_tick[i].aiguillage;
    if j<>-1 then
    begin
      s:=IntToSTR(i)+' Tick='+IntToSTR(event_det_tick[i].tick);
      s:=s+' Aig='+intToSTR(j)+'='+intToSTR(event_det_tick[i].etat);
      Affiche(s,clyellow);
    end;
  end;

end;


procedure TFormPrinc.FichierSimuClick(Sender: TObject);
begin
  FormSimulation.showModal;
end;

procedure TFormPrinc.ButtonEcrCVClick(Sender: TObject);
var adr,valeur,erreur : integer;
    s : string;
begin
  // doc XpressNet page 55
  val(EditAdresse.text,adr,erreur);
  if (erreur<>0) or (Adr>255) or (Adr<0) then 
  begin
    EditAdresse.Text:='1';
    exit;
  end;  
  
  val(EditVal.Text,valeur,erreur);
  if (erreur<>0) or (valeur<0) or (valeur>255) then 
  begin
    EditAdresse.text:='1';
    exit;
  end;  
  
  //s:=#$ff+#$fe+#$23+#$1e+Char(adr)+Char(valeur);    //CV de 512 à 767 V3.4
  //s:=#$ff+#$fe+#$23+#$1d+Char(adr)+Char(valeur);    //CV de 256 à 511 V3.4
  s:=#$23+#$16+Char(adr)+Char(valeur);      //CV de 1 à 256

  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
  // la centrale passe en mode service (p23)
  Affiche('CV'+intToSTR(Adr)+'='+intToSTR(valeur),clyellow);

end;

procedure TFormPrinc.ButtonRepriseClick(Sender: TObject);
var s : string;
begin
  s:=#$21+#$81;
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack

end;

procedure Lire_fichier_CV;
var s: string;
    fte : textfile;
    cv,valeur,erreur : integer;
begin
  s:=GetCurrentDir;
  //s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  with FormPrinc do
  begin
    OpenDialog.InitialDir:=s;
    OpenDialog.DefaultExt:='txt';
    OpenDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
    if openDialog.Execute then
    begin
      s:=openDialog.FileName;
      assignFile(fte,s);
      reset(fte);
      while not(eof(fte)) do
      begin
        readln(fte,s);
     // s:=' 35     63';
        val(s,cv,erreur);

        if (cv<>0) then
        begin
          delete(s,1,erreur);
          val(s,valeur,erreur);
          Affiche('CV='+intToSTR(cv)+' Valeur='+IntToSTR(valeur),clLime);
          if cv>255 then Affiche('Erreur CV '+IntToSTR(cv)+'>255',clred);
          if valeur>255 then Affiche('Erreur valeur '+IntToSTR(valeur)+'>255',clred);

          if (cv<=255) and (valeur<=255) then
          begin
            s:=#$23+#$16+Char(cv)+Char(valeur);      //CV de 1 à 256
            s:=checksum(s);
            envoi(s);     // envoi de la trame et attente Ack, la premiere trame fait passer la centrale en mode programmation (service)
            tempo(5);
          end;
        end;

      end;
      closeFile(fte);
    end;
  end;
end;


procedure TFormPrinc.LireunfichierdeCV1Click(Sender: TObject);
begin
  Lire_fichier_CV;
end;

procedure TFormPrinc.ButtonLitCVClick(Sender: TObject);
var s,sa: string;
    fte : textfile;
    i,cv,valeur,erreur : integer;
begin
  s:=GetCurrentDir;
  //s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  N_Cv:=0; // nombre de CV recus à 0
  sa:='';
  Affiche('Lecture CV',clyellow);

  val(EditAdresse.Text,cv,erreur);
  if (erreur<>0) or (cv>255) or (cv<0) then 
  begin
    EditAdresse.Text:='1';
    exit;
  end;  
  //trace:=true;


  s:=#$22+#$15+Char(cv);      //CV de 1 à 256 (V3.0)
  //s:=#$22+#$18+Char(cv);      //CV de 1 à 255 + 1024 (V3.6)
  s:=checksum(s);
  // envoi de la trame : fait passer la centrale en mode programmation (service)
  envoi_ss_ack(s);

  // attendre la trame 01 04 05 (env 1s)
  succes:=false;i:=0;
  repeat
    Application.processMessages;
    Sleep(100);
    inc(i);
  until succes or (i>20);

  if succes then
  begin
    recu_cv:=false;
    //Affiche('reçu trame succes',clyellow);
    s:=#$21+#$10;      // demande d'envoi du résultat du mode service
    s:=checksum(s);
    //envoi(s);
    envoi_ss_ack(s);
    Tempo(1);
    // attente de la réponse de la centrale
    i:=0;
    repeat
      Tempo(2); // attend 200 ms
      inc(i);
    until recu_cv or (i>4);
    if (i>4) then
    begin
      Affiche('Erreur attente trop longue CV',clred);
      exit;
    end;
    sa:=sa+'Cv'+IntToSTR(cv)+'='+IntToSTR(Tablo_cv[cv])+' ';
    Affiche(sa,clyellow);sa:='';
  end
  else
  Affiche('Pas de réponse de l''interface',clOrange);
end;


procedure TFormPrinc.Quitter1Click(Sender: TObject);
begin
  close;
end;

procedure TFormPrinc.ConfigClick(Sender: TObject);
begin
  Tformconfig.create(self);
  formconfig.showmodal;
  formconfig.close;
end;

procedure TFormPrinc.Button2Click(Sender: TObject);
var i : integer;
begin
  //traceliste:=true;
  //NivDebug:=3;
  i:=test_route_valide(519,517,518);
  Affiche(IntToSTR(i),clOrange);
end;


procedure TFormPrinc.Codificationdesactionneurs1Click(Sender: TObject);
var i,adr,etatAct,v,aO,aF : integer;
    s,s2 : string;
begin
  if (maxTablo_act=0) and (NbrePN=0) then
  begin
    Affiche('Aucun actionneur déclaré',clYellow);
  end;
  

  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].train;
    etatAct:=Tablo_actionneur[i].etat ;
    Adr:=Tablo_actionneur[i].actionneur;
    s2:=Tablo_actionneur[i].train;
    if (s2<>'') then
    begin
      Affiche('FonctionF Actionneur='+intToSTR(adr)+' Train='+s2+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':'+intToSTR(etatAct)+
              ' Temporisation='+intToSTR(tablo_actionneur[i].Tempo),clyellow);
    end;
  end;

  // dans le tableau des PN
  for i:=1 to NbrePN do
  begin
    s:='PN'+intToSTR(i)+'         Adresse fermeture PN='+IntToSTR(Tablo_PN[i].AdresseFerme);
    s:=s+'        Adresse ouverture PN='+IntToSTR(Tablo_PN[i].AdresseOuvre);
    Affiche(s,clyellow);
    s:='               Commande fermeture='+intToSTR(Tablo_PN[i].commandeFerme);
    s:=s+'        Commande ouverture='+intToSTR(Tablo_PN[i].commandeOuvre);
    s:=s+'        Nbre de voies='+intToSTR(Tablo_PN[i].nbVoies);
    Affiche(s,clyellow);
    for v:=1 to Tablo_PN[i].nbvoies do
    begin
      s:='               Voie '+IntToSTR(v)+': Actionneur de fermeture='+intToSTR(Tablo_PN[i].voie[v].ActFerme);
      s:=s+' Actionneur d''ouverture='+intToSTR(Tablo_PN[i].voie[v].ActOuvre);
      Affiche(s,clyellow);
    end;
  end;
end;

procedure TFormPrinc.ButtonArretSimuClick(Sender: TObject);
begin
  Index_Simule:=0;  // fin de simulation
  I_Simule:=0;
  MsgSim:=false;
  Affiche('Fin de simulation',Cyan);
end;

procedure TFormPrinc.OuvrirunfichiertramesCDM1Click(Sender: TObject);
var  s : string;
   fte : textFile;
begin
  s:=GetCurrentDir;
  s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  OpenDialog.InitialDir:=s;
  OpenDialog.DefaultExt:='txt';
  OpenDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
  if openDialog.Execute then
  begin
    s:=openDialog.FileName;
    assignFile(fte,s);
    reset(fte);
    while not(eof(fte)) do
    begin
      readln(fte,s);
      Affiche(s,clLime);
      Interprete_trameCDM(s);
    end;  
    closeFile(fte);
  end;  
  
end;

begin






end.
