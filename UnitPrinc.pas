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
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls, ShellAPI, TlHelp32,
  ImgList, ScktComp, StrUtils, Menus, ActnList, MSCommLib_TLB   ;

type
  TFormPrinc = class(TForm)
    Timer1: TTimer;
    LabelTitre: TLabel;
    ScrollBox1: TScrollBox;
    ClientSocketLenz: TClientSocket;
    GroupBox1: TGroupBox;
    EditAdresse: TEdit;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    Interface1: TMenuItem;
    MenuConnecterUSB: TMenuItem;
    DeconnecterUSB: TMenuItem;
    N2: TMenuItem;
    MenuConnecterEthernet: TMenuItem;
    MenuDeconnecterEthernet: TMenuItem;
    StatusBar1: TStatusBar;
    MSCommUSBLenz: TMSComm;
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
    ClientSocketCDM: TClientSocket;
    FichierSimu: TMenuItem;
    OpenDialog: TOpenDialog;
    N1: TMenuItem;
    LireunfichierdeCV1: TMenuItem;
    SaveDialog: TSaveDialog;
    N5: TMenuItem;
    Quitter1: TMenuItem;
    Config: TMenuItem;
    Codificationdesactionneurs1: TMenuItem;
    OuvrirunfichiertramesCDM1: TMenuItem;
    Panel1: TPanel;
    BoutonRaf: TButton;
    BoutVersion: TButton;
    loco: TButton;
    ButtonInfo: TButton;
    ButtonReprise: TButton;
    ButtonTest: TButton;
    ButtonArretSimu: TButton;
    ButtonDroit: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    LabelNbTrains: TLabel;
    LabelEtat: TLabel;
    ButtonAffTCO: TButton;
    ButtonLanceCDM: TButton;
    Affichefentredebug1: TMenuItem;
    StaticText: TStaticText;
    FenRich: TRichEdit;
    PopupMenuFenRich: TPopupMenu;
    Copier1: TMenuItem;
    Etatdessignaux1: TMenuItem;
    N6: TMenuItem;
    Apropos1: TMenuItem;
    ButtonDevie: TButton;
    GroupBox2: TGroupBox;
    ButtonEcrCV: TButton;
    ButtonLitCV: TButton;
    EditCV: TEdit;
    Label3: TLabel;
    LabelVCV: TLabel;
    EditVal: TEdit;
    PopupMenuFeu: TPopupMenu;
    Proprits1: TMenuItem;
    N7: TMenuItem;
    Nouveaufeu1: TMenuItem;
    N8: TMenuItem;
    Vrifierlacohrence: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MSCommUSBLenzComm(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure BoutVersionClick(Sender: TObject);
    procedure ButtonDroitClick(Sender: TObject);
    procedure EditvalEnter(Sender: TObject);
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
    procedure ConnecterCDMrailClick(Sender: TObject);
    procedure DeconnecterCDMRailClick(Sender: TObject);
    procedure ClientSocketCDMDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Codificationdesfeux1Click(Sender: TObject);
    procedure ClientSocketLenzDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FichierSimuClick(Sender: TObject);
    procedure ButtonEcrCVClick(Sender: TObject);
    procedure ButtonRepriseClick(Sender: TObject);
    procedure LireunfichierdeCV1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure ConfigClick(Sender: TObject);
    procedure ButtonLitCVClick(Sender: TObject);
    procedure Codificationdesactionneurs1Click(Sender: TObject);
    procedure ButtonArretSimuClick(Sender: TObject);
    procedure OuvrirunfichiertramesCDM1Click(Sender: TObject);
    procedure ButtonAffTCOClick(Sender: TObject);
    procedure ButtonLanceCDMClick(Sender: TObject);
    procedure Affichefentredebug1Click(Sender: TObject);
    procedure FenRichChange(Sender: TObject);
    procedure Copier1Click(Sender: TObject);
    procedure Etatdessignaux1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure ButtonDevieClick(Sender: TObject);
    procedure Proprits1Click(Sender: TObject);
    procedure Nouveaufeu1Click(Sender: TObject);
    procedure Nouveaufeu2Click(Sender: TObject);
    procedure VrifierlacohrenceClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure DoHint(Sender : Tobject);
  public
    { Déclarations publiques }
    Procedure ImageOnClick(Sender : TObject);
    procedure ClicImage(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure proc_checkBoxFB(Sender : Tobject);
  end;


const
titre='Signaux complexes GL ';
espY = 15;            // espacement Y entre deux lignes de feux
tempoFeu=100;         // tempo en ms d'espacement entre deux envois consécutifs à un décodeur
MaxAcc=2048;          // adresse maxi d'accessoire XpressNet
LargImg=50;HtImg=91;  // Dimensions image des feux
const_droit=2;        // positions aiguillages transmises par la centrale LENZ
const_devie=1;        // positions aiguillages transmises par la centrale LENZ
const_devieG_CDM=3;   // positions aiguillages transmises par cdm
const_devieD_CDM=2;   // positions aiguillages transmises par cdm
const_droit_CDM=0;    // positions aiguillages transmises par cdm
const_inconnu=9;      // position inconnue
NbCouleurTrain=8;
ClBleuClair=$FF7070 ;
Cyan=$FF6060;
clviolet=$FF00FF;
GrisF=$414141;
clOrange=$0077FF;
couleurTrain : array[1..NbCouleurTrain] of Tcolor = (clYellow,clLime,clOrange,clAqua,clFuchsia,clLtGray,clred,clWhite);
Max_Simule=10000;

EtatSign : array[0..13] of string[20] =('carré','sémaphore','sémaphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');
NbDecodeur = 7;
decodeur : array[0..NbDecodeur-1] of string[20] =('rien','digital Bahn','CDF','LDT','LEB','NMRA','Unisemaf');

type 
Taccessoire   = (aigP,feu);
TMA           = (valide,devalide);
TEquipement   = (rien,aig,tjd,tjs,triple,det,buttoir,voie);   // voie uniquement pour le tco
TBranche = record
               BType : Tequipement ;   // ne prend que les valeurs suivantes: dét aig Buttoir
               Adresse : integer ; // adresse du détecteur ou de l'aiguillage
            end;

     Taiguillage = record
                 Adresse : integer;
                 modele : TEquipement;      // 0=n'existe pas  1=aiguillage 2=TJD 3=TJS 4=aiguillage triple
                 position,                  // position actuelle : 1=dévié  2=droit (centrale LENZ)
                 posInit,                   // position d'initialisation 1=dévié 2=droit 9=non positionné
                 Adrtriple,                 // 2eme adresse pour un aiguillage triple
                 temps,                     // temps de pilotage (durée de l'impulsion en x 100 ms
                 InversionCDM : integer ;   // pour les aiguillages déclarés inversés dans CDM, utilisé en mode autonome (paramètre I1)
                 vitesse : integer;         // vitesse de franchissement de l'aiguillage en position déviée (60 ou 90)

                 ADroit : integer ;         // (TJD:identifiant extérieur) connecté sur la position droite en talon
                 ADroitB : char ;           // P D S Z

                 ADevie : integer ;         // (TJD:identifiant extérieur) adresse de l'élément connecté en position déviée
                 ADevieB : char;            // caractère (D ou S)si aiguillage de l'élément connecté en position déviée

                 APointe : integer;         // adresse de l'élément connecté en position droite ;
                 APointeB : char;

                 DDroit : integer;          // destination de la TJD en position droite
                 DDroitB : char ;

                 DDevie : integer;          // destination de la TJD en position déviée
                 DDevieB : char ;

                 tjsint   : integer;        // pour TJS
                 tjsintb  : char ;

                  // éléments connectés sur la branche déviée 2 (cas d'un aiguillage triple)
                 Adevie2 : integer;
                 Adevie2B : char ;

                 // si modifié en mode config
                 modifie : boolean ;
              end;

         TFeu = record
                 adresse, aspect : integer; // adresse du feu, aspect (2 feux..9 feux 12=direction 2 feux .. 16=direction 6 feux)
                 Img : TImage;              // Pointeur sur structure TImage du feu
                 Lbl : TLabel;              // pointeur sur structure Tlabel du feu
                 check : TCheckBox;         // pointeur sur structure Checkbox "demande feu blanc"
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
                 Btype_suiv1 : TEquipement ; // type de l'élément suivant ne prend que les valeurs rien, det ou aig
                 Btype_suiv2 : TEquipement ; // 
                 Btype_suiv3 : TEquipement ; // 
                 Btype_suiv4 : TEquipement ; // 
                 VerrouCarre : boolean ;     // si vrai, le feu se verrouille au carré si pas de train avant le signal
                 modifie     : boolean;      // feu modifié
                 EtatSignal  : word  ;       // comme EtatSignalCplx
                 UniSemaf : integer ;        // définition supplémentaire de la cible pour les décodeurs UNISEMAF
                 AigDirection : array[1..6] of array of record        // pour les signaux directionnels : contient la liste des aiguillages associés
                                               Adresse : integer;     // 6 feux max associés à un tableau dynamique décrivant les aiguillages
                                               posAig  : char;
                                               end;
                 CondCarre : array[1..6] of array of record  // conditions supplémentaires d'aiguillages en position pour le carré
                                                // attention les données sont stockées en adresse 1 du tableau dynamique
                                               Adresse : integer;    // aiguillage
                                               posAig : char;
                                               end;
               end;

          
var
  ancien_tablo_signalCplx,EtatsignalCplx : array[0..MaxAcc] of word;
  tempsCli,NbreFeux,pasreponse,AdrDevie,fenetre,Tempo_Aig,
  NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
  Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,NbrePN,ServeurInterfaceCDM,
  ServeurRetroCDM,TailleFonte,Nb_Det_Dist : integer;

  Hors_tension2,traceSign,TraceZone,Ferme,parSocketLenz,ackCdm,PremierFD,
  NackCDM,MsgSim,succes,recu_cv,AffActionneur,AffAigDet,Option_demarrage,AffTiers,
  TraceListe,clignotant,nack,Maj_feux_cours,configNulle,LanceCDM,AvecInitAiguillages : boolean;

  CDMhd : THandle;

  FormPrinc: TFormPrinc;
  ack,portCommOuvert,traceTrames,AffMem,AfficheDet,CDM_connecte,SocketCDM_connecte,
  Raz_Acc_signaux,AvecInit,AvecTCO,terminal,Srvc_Aig,Srvc_Det,Srvc_Act,
  Srvc_PosTrain,Srvc_Sig,debugtrames : boolean;
  tablo : array of byte;  // tableau rx usb
  Enregistrement,chaine_Envoi,chaine_recue,Id_CDM,Af,
  entete,suffixe,ConfStCom,LAY : string;
  maxaiguillage,detecteur_chgt,Temps,Tempo_init,Suivant,
  NbreImagePligne,NbreBranches,Index2_det,Index2_aig,branche_det,Index_det,
  I_simule,maxTablo_act,NbreVoies,AdresseFeuSuivant,El_suivant : integer;
  Ancien_detecteur : array[0..1024] of boolean;   // anciens état des détecteurs et adresses des détecteurs et leur état
  detecteur : array[0..1024] of
  record
     etat : boolean;
     tempo : integer;
     train : string;
  end;

  TypeGen : TEquipement;
  Adresse_detecteur : array[0..60] of integer; // adresses des détecteurs par index
  MemZone : array[0..1024,0..1024] of boolean ; // mémoires de zones
  Tablo_actionneur : array[1..100] of
  record
    loco,act : boolean;   // type loco ou actionneur
    actionneur,etat,fonction,tempo,
    accessoire,sortie : integer;
    Raz : boolean;
    train : string;
  end;
  KeyInputs: array of TInput;
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
  TempoAct,RangActCours,N_Cv,index_simule,NDetecteurs,N_Trains,N_routes : integer;
  tablo_CV : array [1..255] of integer;
  couleur : Tcolor;
  fichier : text;
  tick,Premier_tick : longint;
  // modélisations des fichiers config
  branche : array [1..100] of string; 
  // l'indice du tableau aiguillage n'est pas son adresse
  aiguillage : array[0..MaxAcc] of Taiguillage;
  // signaux - L'index du tableau n'est pas son adresse
  feux :  array[1..MaxAcc] of Tfeu;
  Feu_supprime,Feu_sauve : Tfeu;
  Aig_supprime,Aig_sauve : TAiguillage;
  
  Fimage : Timage;
  BrancheN : array[1..100,1..200] of TBranche;  //

{$R *.dfm}

// utilisation des procédures et fonctions dans les autres unités
function Index_feu(adresse : integer) : integer;
function Index_Aig(adresse : integer) : integer;
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
function  IsWow64Process: Boolean;
procedure Dessine_feu_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : real;adresse : integer;orientation : integer);
procedure Pilote_acc0_X(adresse : integer;octet : byte);
procedure pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire);
function  etat_signal_suivant(Adresse,rang : integer) : integer;
function suivant_alg3(prec : integer;typeELprec : TEquipement;actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
function test_memoire_zones(adresse : integer) : boolean;
function PresTrainPrec(AdrFeu : integer) : boolean;
function cond_carre(adresse : integer) : boolean;
function carre_signal(adresse : integer) : boolean;
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
function verif_UniSemaf(adresse,UniSem : integer) : integer;
function Select_dessin_feu(TypeFeu : integer) : TBitmap;
procedure cree_image(rang : integer);
procedure trouve_aiguillage(adresse : integer);
procedure trouve_detecteur(detecteur : integer);
function BTypeToNum(BT : TEquipement) : integer;

implementation

uses UnitDebug, verif_version, UnitPilote, UnitSimule, UnitTCO, UnitConfig;

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

// renvoie le 1er numéro de bit à 1
// ex BitNum(4)=2
Function PremBitNum(n : word) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    trouve:=(n and 1)=1 ;
    if not(trouve) then inc(i);
    n:=n shr 1;
  until (i=16) or trouve;
  PremBitNum:=i;
end;

// conversion du motif de bits (codebin) de la configuration du signal complexe en deux mots:
// en sortie :
// premierBit : code de la signalisation
// Combine = code de la signalisation combinée
// Exemple code_to_aspect(10001000000000)  renvoie premierBit=jaune_cli (9) et Combine=rappel 60 (13)
procedure code_to_aspect(codebin : word;var premierbit,combine : word) ;
begin
  premierBit:=PremBitNum(CodeBin and $3ff);
  combine:=PremBitNum(CodeBin and $fc00);
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
end;

// dessine les feux sur une cible à 2 feux dans le canvas spécifié
// x,y : offset en pixels du coin supérieur gauche du feu
// frX, frY : facteurs de réduction
procedure dessine_feu2(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,rayon,xViolet,YViolet,xBlanc,yBlanc,
    LgImage,HtImage : integer;
    ech : real;
    code,combine : word;
begin
  code_to_aspect(Etatsignal,code,combine);
  rayon:=round(6*frX);

  // récupérer les dimensions de l'image d'origine du feu
  LgImage:=Formprinc.Image2feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image2feux.Picture.Bitmap.Height;

  XBlanc:=13;  YBlanc:=11;
  xViolet:=13; yViolet:=23;

  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yViolet;YViolet:=XViolet;XViolet:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
  end;

  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
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
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xvert,Yvert,
    LgImage,HtImage : integer;
    ech : real;
    code,combine : word;
begin
  code_to_aspect(Etatsignal,code,combine);
  rayon:=round(6*frX);

  LgImage:=Formprinc.Image3feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image3feux.Picture.Bitmap.Height;

  Xvert:=13;  Yvert:=11;
  xSem:=13;   ySem:=22;
  xJaune:=13; yJaune:=33;

  if (orientation=2) then
  begin
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;

  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    ech:=frY;frY:=frX;FrX:=ech;
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
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xcarre,Ycarre,Xvert,Yvert,
    LgImage,HtImage : integer;
    ech : real;
    code,combine : word;
begin
  code_to_aspect(Etatsignal,code,combine); // et aspect
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
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune; YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-ycarre; Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;   YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;  Yvert:=Xvert;Xvert:=Temp;
  end;
 
  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux
    // calcul des facteurs de réduction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
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
var XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,
    Temp,rayon,LgImage,HtImage : integer;
    ech : real;
    code,combine : word;
begin
  code_to_aspect(Etatsignal,code,combine); // et aspect
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
    ech:=frY;frY:=frX;FrX:=ech;
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
    ech:=frY;frY:=frX;FrX:=ech;
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
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clViolet);
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
var XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Temp,rayon,LgImage,HtImage : integer;
    ech : real;
    code,combine : word;
begin
  code_to_aspect(Etatsignal,code,combine); // et combine
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
    ech:=frY;frY:=frX;FrX:=ech;
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
    ech:=frY;frY:=frX;FrX:=ech;
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
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clViolet);
  if code=carre then
  begin
    cercle(ACanvas,xCarre,yCarre,rayon,clRed);
    cercle(ACanvas,xSem,ySem,rayon,clRed);
  end;
end;

// dessine les feux sur une cible à 9 feux
procedure dessine_feu9(Acanvas : Tcanvas;x,y : integer;frX,frY : real;etatsignal : word;orientation : integer);
var rayon,
    XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Xrap1,Yrap1,Xrap2,Yrap2,Temp          : integer;
    LgImage,HtImage,xt,yt : integer;
    ech : real;
    code,combine : word;
begin
  rayon:=round(6*frX);
  code_to_aspect(Etatsignal,code,combine); // et aspect
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
    ech:=frY;frY:=frX;FrX:=ech;
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
    ech:=frY;frY:=frX;FrX:=ech;
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
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clViolet);

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

// transforme le type TEquipement en valeur numérique
function BTypeToNum(BT : TEquipement) : integer;
begin
  case BT of
  det : result:=1;
  aig : result:=2;
  voie : result:=3;
  buttoir : result:=4;
  else result:=0;
  end;
end;

procedure Affiche(s : string;lacouleur : TColor);
begin
  with formprinc do
  begin
     FenRich.lines.add(s);
     RE_ColorLine(FenRich,FenRich.lines.count-1,lacouleur);
  end;
end;
 
// renvoie l'index du feu dans le tableau feux[] en fonction de son adresse
//si pas trouvé renvoie 0
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

// renvoie l'index de l'aiguillage dans le tableau aiguillages[] en fonction de son adresse
//si pas trouvé renvoie 0
function Index_Aig(adresse : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=aiguillage[i].adresse=adresse;
    if not(trouve) then inc(i);
  until (trouve) or (i>MaxAiguillage);
  if trouve then Index_Aig:=i else Index_Aig:=0 ;
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


// procédure activée quand on clique gauche ou droit sur l'image d'un feu
// le dessin ne fonctionne pas à cause de l'inhéritage (csinheritage)
procedure TFormPrinc.ClicImage(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s : string;
    P_image_pilote : Timage;
    i,erreur,adresse : integer;
begin
  inherited;
  P_image_pilote:=Sender as TImage;  // récupérer l'objet image de la forme pilote
  s:=P_Image_pilote.Hint;
  //Affiche(s,clyellow);
  i:=pos('@',s);  if i<>0 then delete(s,i,1);
  i:=pos('=',s);  if i<>0 then delete(s,i,1);
  i:=pos(' ',s);
  if i<>0 then s:=copy(s,1,i-1);
  val(s,Adresse,erreur); 
  if adresse=0 then exit;
  i:=Index_feu(Adresse);
  
  P_image_pilote:=feux[i].Img ;        

  with P_image_pilote.Canvas do
  begin
    Pen.Color:=clblue;
    
    Canvas.Rectangle(10,10,50,100);
  end;  
  
end;

// procédure activée quand on clique gauche sur l'image d'un feu
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
  if adrPilote=0 then exit;
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

function Select_dessin_feu(TypeFeu : integer) : TBitmap;
var Bm : TBitMap;
begin
    case TypeFeu of   // charger le bit map depuis le fichier
    2 : Bm:=Formprinc.Image2feux.picture.Bitmap;
    3 : Bm:=Formprinc.Image3feux.picture.Bitmap;
    4 : Bm:=Formprinc.Image4feux.picture.Bitmap;
    5 : Bm:=Formprinc.Image5feux.picture.Bitmap;
    7 : Bm:=Formprinc.Image7feux.picture.Bitmap;
    9 : Bm:=Formprinc.Image9feux.picture.Bitmap;

    12 : Bm:=Formprinc.Image2Dir.picture.Bitmap;
    13 : Bm:=Formprinc.Image3Dir.picture.Bitmap;
    14 : Bm:=Formprinc.Image4Dir.picture.Bitmap;
    15 : Bm:=Formprinc.Image5Dir.picture.Bitmap;
    16 : Bm:=Formprinc.Image6Dir.picture.Bitmap;
    end;
    Select_dessin_feu:=bm;
end;

// créée une image dynamiquement pour un nouveau feu déclaré dans le fichier de config
procedure cree_image(rang : integer);
var TypeFeu,adresse : integer;
    s : string;

begin
  TypeFeu:=feux[rang].aspect;
  if typeFeu<=0 then exit;
  Feux[rang].Img:=Timage.create(Formprinc.ScrollBox1);
  with Feux[rang].Img do
  begin
    Parent:=Formprinc.ScrollBox1;   // dire que l'image est dans la scrollBox1
    //Name:='ImageFeu'+IntToSTR(rang);   // nom de l'image - sert à identifier le composant si on fait clic droit.
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // détermine les points d'origine
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    width:=57;
    Height:=105;
    s:='@='+inttostr(feux[rang].Adresse)+' Decodeur='+intToSTR(feux[rang].Decodeur)+' Adresse détecteur associé='+intToSTR(feux[rang].Adr_det1)+
       ' Adresse élement suivant='+intToSTR(feux[rang].Adr_el_suiv1);
    if feux[rang].Btype_suiv1=aig then s:=s+' (aig)';
    Hint:=s;

    onClick:=Formprinc.Imageonclick;    // procédure clique sur image
    //PopUpMenu:=Formprinc.PopupMenuFeu;  // affectation popupmenu sur clic droit : ihnibé car pas géré l'aboutissement de la fenetre sur le feu
    //OnMouseDown:=Formprinc.ClicImage;   // affection pour clic gauche ou droit
                                       
    Picture.Bitmap.TransparentMode:=tmAuto; 
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;

    // affecter le type d'image de feu dans l'image créée
    picture.Bitmap:=Select_dessin_feu(TypeFeu);
    
    // mettre rouge par défaut
    adresse:=Feux[rang].adresse;
    if TypeFeu=2 then EtatSignalCplx[adresse]:=violet_F;
    if TypeFeu=3 then EtatSignalCplx[adresse]:=semaphore_F;
    if (TypeFeu>3) and (TypeFeu<10) then EtatSignalCplx[adresse]:=carre_F;
    if TypeFeu>10 then EtatSignalCplx[adresse]:=0;

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
    //Feux[rang].check.onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la procédure de traitement quand on clique dessus non utilisé
    Feux[rang].check.Hint:=intToSTR(adresse);  // affecter l'adresse du feu dans le HINT pour pouvoir le retrouver plus tard

    with Feux[rang].Check do
    begin
      caption:='dem FB';
      Parent:=Formprinc.ScrollBox1;
      width:=100;height:=15;
      Top:=HtImg+15+((HtImg+EspY+20)*((rang-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
      BringToFront;
    end;
  end
  else Feux[rang].check:=nil;
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
  if traceTrames then AfficheDebug(chaine_HEX(s),couleur);
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
  if traceTrames then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClGreen);
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
    // protocole Rts Cts ou sans temporisation
    if (protocole=2) or (tempoOctet=0) then begin FormPrinc.MSCommUSBLenz.Output:=s;exit;end;
    // sans procotole ou xon xoff ou xon-rts
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
  if parSocketLenz then Formprinc.ClientSocketLenz.Socket.SendText(s);
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
    if portCommOuvert or parSocketLenz then
    begin
      temps:=0;
      repeat
        Application.processMessages;
        inc(temps);Sleep(50);
      until ferme or ack or nack or (temps>(TimoutMaxInterface*3)); // l'interface répond < 5s en mode normal et 1,5 mn en mode programmation
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

// chaîne pour vitesse train
function chaine_CDM_vitesse(vitesse:integer;train:string) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:=s+'NAME='+train+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesse:=so+s;
end;

// prépare la chaîne de commande pour un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat : integer) : string;
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
  s:=s+'STATE='+format('%.*d',[1,etat])+';';

  sx:=format('%.*d',[2,2])+'|';  // 2 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_Acc:=so+s;
end;

procedure envoie_fonction_CDM(fonction,etat : integer;train : string);
var s : string;
begin
  s:=chaine_CDM_Func(fonction,etat,train);
  envoi_cdm(s);
end;

// active ou désactive une sortie par xpressnet. Une adresse comporte deux sorties identifiées par "octet"
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


procedure vitesse_loco(loco : integer;vitesse : integer;sens : boolean);
var s : string;
begin
  if portCommOuvert or parSocketLenz then
  begin
    if sens then vitesse:=vitesse or 128;
    s:=#$e4+#$13+#$0+char(loco)+char(vitesse);
    s:=checksum(s);
    envoi(s);
  end;
  if cdm_connecte then
  begin
     //s:=chaine_CDM_vitesse(0,'BB25531');
     s:=chaine_CDM_vitesse(1,'CC406526');   // 0 n'arrete pas le train
     envoi_CDM(s);
  end;
end;

// fonctions sur les bits
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

// renvoie la chaîne de l'état du signal
function chaine_signal(etat : word) : string;
var aspect,combine : word;
    s : string;
begin
  code_to_aspect(etat,aspect,combine);
  s:='';
  if aspect=16 then s:='' else s:=etatSign[aspect];
  if combine<>16 then
  begin
    if aspect<>16 then s:=s+'+';
    s:=s+etatSign[combine];
  end;
  chaine_signal:=s;
end;

// mise à jour état signal complexe dans le tableau de bits du signal EtatSignalCplx */
// adresse : adresse du signal complexe
// Aspect : code représentant l'état du signal de 0 à 15
procedure Maj_Etat_Signal(adresse,aspect : integer);
var i : integer;
begin                              
// ('0carré','1sémaphore','2sémaphore cli','3vert','4vert cli','5violet',
//           '6blanc','7blanc cli','8jaune','9jaune cli','10ral 30','11ral 60','12rappel 30','13rappel 60');
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
  // mise à jour de l'état du signal dans le tableau Feux
  i:=Index_feu(adresse);
  feux[i].EtatSignal:=EtatSignalCplx[adresse];
end;


{=============================================
envoie les données au décodeur digital bahn équipé du logiciel "led_schalten"
sur un panneau directionnel - adresse : adresse du signal - code de 1 à 3 pour allumer
; le panneau directionnel à 1, 2 ou 3 leds.
============================================== }
procedure envoi_directionBahn(adr : integer;code : integer);
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
envoie les données au décodeur CDF
===========================================================================*}
procedure envoi_CDF(adresse : integer);
var 
  code,aspect,combine : word;
  s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal CDF: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    if (aspect=carre)     then pilote_acc(adresse,2,feu) ;
    if (aspect=semaphore) then pilote_acc(adresse,1,feu) ;
    if (aspect=vert)      then pilote_acc(adresse+1,1,feu) ;
    if (aspect=jaune)     then pilote_acc(adresse+1,2,feu);
    // signalisation non combinée rappel 30 seul
    if (aspect=rappel_30) then pilote_acc(adresse+1,1,feu);

    // signalisation combinée  - rappel 30 + avertissement - à tester......
    if (Combine=0)      then pilote_acc(adresse+2,1,feu) ;    // éteindre rappel 30
    if (Combine=rappel_30) then pilote_acc(adresse+2,2,feu) ; // allumer rappel 30
  end;
end;

{==========================================================================
envoie les données au décodeur LEB
===========================================================================*}
procedure envoi_LEB(adresse : integer);
var  code,aspect,combine : word;
    s : string;
  procedure envoi5_LEB(selection :byte);
  var i : integer;
      octet : byte;
  begin
    s:='';
    for i:=0 to 4 do
    begin
      if (testBit(selection,i)) then begin octet:=1;s:=s+'1';end
      else begin octet:=2 ; s:=s+'0';end;
      Pilote_acc(adresse+i,octet,feu);
      // le décodeur LEB nécessite qu'on envoie 0 après son pilotage ; si on est en mode usb ou ethernet
      if (portCommOuvert or parSocketLenz) then Pilote_acc0_X(adresse+i,octet);
    end;
    //Affiche(inttoStr(selection),clOrange);
    //Affiche(s,clOrange);
  end;
begin

if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then //; && (stop_cmd==FALSE))
begin
  ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
  code:=EtatSignalCplx[adresse];
  code_to_aspect(code,aspect,combine);
  s:='Signal LEB: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
  if traceSign then affiche(s,clOrange);
  if Affsignal then afficheDebug(s,clOrange);

  Sleep(60);  // si le feu se positionne à la suite d'un positionnement d'aiguillage, on peut avoir le message station occupée
  //Affiche(IntToSTR(aspect)+' '+inttoSTR(combine),clOrange);
  if (Combine=16) then
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
  if (aspect=16) then
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
var valeur : integer ;
    aspect,combine,code : word;
    s : string;
begin
  //index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau
  //code:=feux[index].aspect; // aspect du feu;

  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal NMRA: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    case aspect of
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
    end;
    case combine of  
      ral_30                    : valeur:=10;
      ral_60                    : valeur:=11;
      rappel_30                 : valeur:=13;
      rappel_60                 : valeur:=14;
    end;

    if (Combine=ral_60)    and (aspect=jaune_cli) then valeur:=12;
    if (Combine=rappel_30) and (aspect=jaune)     then valeur:=15;
    if (Combine=rappel_30) and (aspect=jaune_cli) then valeur:=16;
    if (Combine=rappel_60) and (aspect=jaune)     then valeur:=17;
    if (Combine=rappel_60) and (aspect=jaune_cli) then valeur:=18;

    pilote_acc(adresse,valeur,feu);
  end;
end;

// décodeur unisemaf (paco)
procedure envoi_UniSemaf(adresse: integer);
var modele,index: integer ;
    s : string;
    code,aspect,combine : word;
begin
  index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau

  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal Unisemaf: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    // pour Unisemaf, la cible est définie dans le champ Unisemaf de la structure feux

    modele:=feux[index].Unisemaf;
    //Affiche('Adresse='+intToSTR(Adresse)+' code='+intToSTR(code)+' combine'+intToSTR(combine),clyellow);
        if modele=2 then // 2 feux
        begin
          if aspect=blanc then      pilote_acc(adresse,1,feu);
          if aspect=blanc_cli then  pilote_acc(adresse,1,feu);
          if aspect=violet then     pilote_acc(adresse,2,feu);
        end;

        if modele=3 then // 3 feux
        begin
          if aspect=vert then       pilote_acc(adresse,1,feu);
          if aspect=vert_cli then   pilote_acc(adresse,1,feu);

          if aspect=semaphore then  pilote_acc(adresse,2,feu);
          if aspect=semaphore_cli then pilote_acc(adresse,2,feu);

          if aspect=jaune then      pilote_acc(adresse+1,1,feu);
          if aspect=jaune_cli then  pilote_acc(adresse+1,1,feu);
        end;

        if modele=4 then
        begin
          case aspect of
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
          case aspect of
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
          case aspect of
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
          case aspect of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          end;
          if combine=ral_30 then pilote_acc(adresse+1,2,feu);
        end;
        // 72=VJR + carré + ralentissement 30
        if modele=72 then
        begin
          case aspect of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          end;
          if combine=ral_30 then pilote_acc(adresse+2,1,feu);
        end;
        // 73=VJR + carré + ralentissement 60
        if modele=73 then
        begin
          case aspect of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          end;
          if combine=ral_60 then pilote_acc(adresse+2,1,feu);
        end;
        // 91=VJR + carré + rappel 30
        if modele=91 then
        begin
          case aspect of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          end;
          if combine=rappel_30 then pilote_acc(adresse+2,1,feu);
        end;

        // 92=VJR + carré + rappel 60
        if modele=92 then
        begin
          case aspect of
          vert                  : pilote_acc(adresse,1,feu);
          vert_cli              : pilote_acc(adresse,1,feu);
          jaune                 : pilote_acc(adresse,2,feu);
          jaune_cli             : pilote_acc(adresse,2,feu);
          semaphore             : pilote_acc(adresse+1,1,feu);
          semaphore_cli         : pilote_acc(adresse+1,1,feu);
          carre                 : pilote_acc(adresse+1,2,feu);
          end;
          if combine=rappel_60 then pilote_acc(adresse+2,1,feu);
        end;

        // 93=VJR + carré + ral30 + rappel 30
        if modele=93 then
        begin
          if combine=16 then //pas de sig combinée
          begin
            if aspect=vert                  then pilote_acc(adresse,1,feu);
            if aspect=vert_cli              then pilote_acc(adresse,1,feu);
            if aspect=jaune                 then pilote_acc(adresse,2,feu);
            if aspect=jaune_cli             then pilote_acc(adresse,2,feu);
            if aspect=semaphore             then pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if aspect=carre                 then pilote_acc(adresse+1,2,feu);
          end;
          if combine=ral_30                then pilote_acc(adresse+2,1,feu);
          if combine=rappel_30             then pilote_acc(adresse+2,2,feu);
          if (aspect=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,feu);
        end;

        // 94=VJR + carré + ral60 + rappel60
        if modele=94 then
        begin
          if combine=16 then
          begin
            if aspect=vert                  then pilote_acc(adresse,1,feu);
            if aspect=vert_cli              then pilote_acc(adresse,1,feu);
            if aspect=jaune                 then pilote_acc(adresse,2,feu);
            if aspect=jaune_cli             then pilote_acc(adresse,2,feu);
            if aspect=semaphore             then pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if aspect=carre                 then pilote_acc(adresse+1,2,feu);
          end;
          if combine=ral_60                then pilote_acc(adresse+2,1,feu);
          if combine=rappel_60             then pilote_acc(adresse+2,2,feu);
          if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;

        // 95=VJR + carré + ral30 + rappel 60
        if modele=95 then
        begin
          if combine=16 then
          begin
            if aspect=vert                  then pilote_acc(adresse,1,feu);
            if aspect=vert_cli              then pilote_acc(adresse,1,feu);
            if aspect=jaune                 then pilote_acc(adresse,2,feu);
            if aspect=jaune_cli             then pilote_acc(adresse,2,feu);
            if aspect=semaphore             then pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if aspect=carre                 then pilote_acc(adresse+1,2,feu);
          end;
          if combine=ral_30                then pilote_acc(adresse+2,1,feu);
          if combine=rappel_60             then pilote_acc(adresse+2,2,feu);
          if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;
        // 96=VJR + blanc + carré + ral30 + rappel30
        if modele=96 then
        begin
          if combine=16 then
          begin
            if aspect=vert               then pilote_acc(adresse,1,feu);
            if aspect=vert_cli           then pilote_acc(adresse,1,feu);
            if aspect=jaune              then pilote_acc(adresse,2,feu);
            if aspect=jaune_cli          then pilote_acc(adresse,2,feu);
            if aspect=semaphore          then pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli      then pilote_acc(adresse+1,1,feu);
            if aspect=carre              then pilote_acc(adresse+1,2,feu);
            if aspect=blanc              then pilote_acc(adresse+3,2,feu);
            if aspect=blanc_cli          then pilote_acc(adresse+3,2,feu);
          end;
          if combine=ral_30             then pilote_acc(adresse+2,1,feu);
          if combine=rappel_30          then pilote_acc(adresse+2,2,feu);
          if (aspect=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,feu);
        end;

        // 97=VJR + blanc + carré + ral30 + rappel60
        if modele=97 then
        begin
          if combine=16 then
          begin
            if aspect=vert                  then pilote_acc(adresse,1,feu);
            if aspect=vert_cli              then pilote_acc(adresse,1,feu);
            if aspect=jaune                 then pilote_acc(adresse,2,feu);
            if aspect=jaune_cli             then pilote_acc(adresse,2,feu);
            if aspect=semaphore             then pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if aspect=carre                 then pilote_acc(adresse+1,2,feu);
            if aspect=blanc                 then pilote_acc(adresse+3,2,feu);
            if aspect=blanc_cli             then pilote_acc(adresse+3,2,feu);
          end;
          if combine=ral_30                then pilote_acc(adresse+2,1,feu);
          if combine=rappel_60             then pilote_acc(adresse+2,2,feu);
          if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
        end;

        // 98=VJR + blanc + violet + ral30 + rappel30
        if modele=98 then
        begin
          if combine=16 then
          begin
            if aspect=vert then               pilote_acc(adresse,1,feu);
            if aspect=vert_cli then           pilote_acc(adresse,1,feu);
            if aspect=jaune then              pilote_acc(adresse,2,feu);
            if aspect=jaune_cli then          pilote_acc(adresse,2,feu);
            if aspect=semaphore then          pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli then      pilote_acc(adresse+1,1,feu);
            if aspect=violet then             pilote_acc(adresse+1,2,feu);
            if aspect=blanc then              pilote_acc(adresse+3,2,feu);
            if aspect=blanc_cli then          pilote_acc(adresse+3,2,feu);
          end;
          if (aspect=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,feu);
          if combine=ral_30 then             pilote_acc(adresse+2,1,feu);
          if combine=rappel_30 then          pilote_acc(adresse+2,2,feu);
        end;

        // 99=VJR + blanc + violet + ral30 + rappel60
        if modele=99 then
        begin
          if combine=16 then
          begin
            if aspect=vert                  then pilote_acc(adresse,1,feu);
            if aspect=vert_cli              then pilote_acc(adresse,1,feu);
            if aspect=jaune                 then pilote_acc(adresse,2,feu);
            if aspect=jaune_cli             then pilote_acc(adresse,2,feu);
            if aspect=semaphore             then pilote_acc(adresse+1,1,feu);
            if aspect=semaphore_cli         then pilote_acc(adresse+1,1,feu);
            if aspect=violet                then pilote_acc(adresse+1,2,feu);
            if aspect=blanc                 then pilote_acc(adresse+3,2,feu);
            if aspect=blanc_cli             then pilote_acc(adresse+3,2,feu);
          end;
          if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,feu);
          if combine=ral_30                then pilote_acc(adresse+2,1,feu);
          if combine=rappel_60             then pilote_acc(adresse+2,2,feu);
        end;
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
procedure envoi_LDT(adresse : integer);
var code,aspect,combine,mode : word;
    s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal LDT: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    if (aspect=semaphore) or (aspect=vert) or (aspect=carre) or (aspect=jaune) then mode:=1 else mode:=2;

    if aspect>carre then mode:=2 else mode:=1;
    case mode of
      // pour les décodeurs en mode 0, il faut écrire la routine vous même car le pilotage dépend du cablage
      // sauf pour le sémaphore, vert et jaune fixe
    1 :       // mode 1: feux 2 3 & 4 feux
    begin
      if (aspect=semaphore) then pilote_acc(adresse,1,feu);
      if (aspect=vert)      then pilote_acc(adresse,2,feu);
      if (aspect=carre)     then pilote_acc(adresse+1,1,feu);
      if (aspect=jaune)     then pilote_acc(adresse+1,2,feu);
    end;
    2 :      // mode 2: plus de 4 feux
    begin
      if (aspect=semaphore) then begin pilote_acc(adresse+2,1,feu);sleep(tempoFeu);pilote_acc(adresse,1,feu);end;
      if (aspect=vert)   then begin pilote_acc(adresse+2,1,feu);sleep(tempoFeu);pilote_acc(adresse,2,feu);end;
      if (aspect=carre)  then begin pilote_acc(adresse+2,1,feu);sleep(tempoFeu);pilote_acc(adresse+1,1,feu);end;
      if (aspect=jaune)  then begin pilote_acc(adresse+2,1,feu);sleep(tempoFeu);pilote_acc(adresse+1,2,feu);end;
      if (aspect=violet) then begin pilote_acc(adresse+2,2,feu);sleep(tempoFeu);pilote_acc(adresse,1,feu);end;
      if (aspect=blanc)  then begin pilote_acc(adresse+2,2,feu);sleep(tempoFeu);pilote_acc(adresse,2,feu);end;
      if (aspect=semaphore) then begin pilote_acc(adresse+2,2,feu);sleep(tempoFeu);pilote_acc(adresse+1,1,feu);end;
      if (combine=aspect8) then begin pilote_acc(adresse+2,2,feu);sleep(tempoFeu);pilote_acc(adresse+1,2,feu);end;
      if (combine=ral_60_jaune_cli) then begin pilote_acc(adresse+3,1,feu);sleep(tempoFeu);pilote_acc(adresse,1,feu);end;  // demande groupe 3
      if (aspect=vert_cli) then begin pilote_acc(adresse+3,1,feu);sleep(tempoFeu);pilote_acc(adresse,2,feu);end; // demande groupe 3
      if (combine=Disque_D) then begin pilote_acc(adresse+3,1,feu);sleep(tempoFeu);pilote_acc(adresse+1,1,feu);end;// demande groupe 3
      if (aspect=jaune_cli) then begin pilote_acc(adresse+3,1,feu);sleep(tempoFeu);pilote_acc(adresse+1,2,feu);end;
      if (combine=ral_30) then begin pilote_acc(adresse+3,2,feu);sleep(tempoFeu);pilote_acc(adresse,1,feu);end;
      if (combine=ral_60) then begin pilote_acc(adresse+3,2,feu);sleep(tempoFeu);pilote_acc(adresse,2,feu);end;
      if (combine=rappel_30) then begin pilote_acc(adresse+3,2,feu);sleep(tempoFeu);pilote_acc(adresse+1,1,feu);end;
      if (combine=rappel_60) then begin pilote_acc(adresse+3,2,feu);sleep(tempoFeu);pilote_acc(adresse+1,2,feu);end;
    end;
    end;
  end;
end;


procedure envoi_virtuel(adresse : integer);
var
  combine,aspect,code : word;
  s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal virtuel: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
  end;
end;

(*==========================================================================
envoie les données au décodeur digitalbahn équipé du logiciel "led_signal_10"
       adresse=adresse sur le BUS DCC
       codebin=motif de bits représentant l'état des feux L'allumage est fait en
       adressant l'une des 14 adresses pour les 14 leds possibles du feu.
       Ici on met le bit 1 à 1 (état "vert" du programme hexmanipu
===========================================================================*)
procedure envoi_signalBahn(adresse : integer);
var aspect,code,combine : word;
    ralrap, jau ,Ancralrap,Ancjau : boolean;
    s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal Bahn: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    //Affiche(IntToSTR(aspect)+' '+inttoSTR(combine),clOrange);

    // spécifique au décodeur digital bahn:
    // si le signal affichait un signal combiné, il faut éteindre le signal avec un sémaphore
    // avant d'afficher le nouvel état non combiné
    Ancralrap:=(TestBit(ancien_tablo_signalCplx[adresse],ral_30)) or (TestBit(ancien_tablo_signalCplx[adresse],ral_60)) or
               (TestBit(ancien_tablo_signalCplx[adresse],rappel_30)) or (TestBit(ancien_tablo_signalCplx[adresse],rappel_60)) ;
    // si ancien état du signal=jaune ou jaune cli
    Ancjau:=(TestBit(ancien_tablo_signalCplx[adresse],jaune)) or (TestBit(ancien_tablo_signalCplx[adresse],jaune_cli)) ;

    //***ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];

    // si état demandé du signal=ralentissement ou rappel
    ralrap:=(TestBit(code,ral_30)) or (TestBit(code,ral_60)) or
            (TestBit(code,rappel_30)) or (TestBit(code,rappel_60)) ;
    // si état demandé du signal=jaune ou cli
    jau:=TestBit(code,jaune) or TestBit(code,jaune_cli) ;

    //effacement du signal combiné par sémaphore suivant condition
    if (((Ancralrap and not(ralrap)) or (Ancjau and not(jau))) and (aspect>=8)) then
    begin
      Sleep(40);
      pilote_acc(adresse+semaphore,2,feu) ;
     // dessine_feu(adresse);
    end;

    sleep(40);  // les commandes entre 2 feux successifs doivent être séparées au minimum de 100 ms
    // affichage du premier aspect du signal(1er bit à 1 dans codebin
    if aspect<>16 then pilote_acc(adresse+aspect,2,feu) ;

    // affichage de la signalisation combinée (2ème bit à 1 dans codebin)
    if (Combine<>16) then
    begin
      sleep(40);
      pilote_ACC(adresse+Combine,2,feu) ;
    end;
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
  end;
end;


// pilotage d'un signal
procedure envoi_signal(Adr : integer);
var i,adresse,det,a,b,aspect,x,y,x0,y0,TailleX,TailleY,Orientation : integer;
    ImageFeu : TImage;
    frX,frY : real;
    s : string;
begin
  i:=index_feu(Adr);
  if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //***
  begin
    if feux[i].aspect<10 then   // si signal non directionnel
    begin
      // envoie la commande au décodeur
      case feux[i].decodeur of
       0 : envoi_virtuel(Adr);
       1 : envoi_signalBahn(Adr);
       2 : envoi_CDF(Adr);
       3 : envoi_LDT(Adr);
       4 : envoi_LEB(Adr);
       5 : envoi_NMRA(Adr);
       6 : envoi_UniSemaf(Adr);
      end;

      // vérifier si on quitte le rouge
      if Option_demarrage then
      begin
      a:=ancien_tablo_signalCplx[adr];
      b:=EtatSignalCplx[adr];
      if ((a=semaphore_F) or (a=carre_F) or (a=violet_F)) and ((b<>semaphore_F) and (b<>carre_F) and (b<>violet_F)) then
      if not(Diffusion) then Affiche('On quitte le rouge du signal '+intToSTR(adr),clyellow);
      // y a t il un train en face du signal
      if cdm_connecte then
      begin
        det:=feux[i].Adr_det1;
        if det<>0 then
        begin
          // test si train sur le détecteur det
          if detecteur[det].etat then
          begin
            detecteur[det].tempo:=20;  // armer la tempo à 2s
            // arreter le train
            s:=detecteur[det].train;
            Affiche('et son détecteur '+IntToSTR(det)+'=1 tempo démarrage '+s,clYellow);
            s:=chaine_CDM_vitesse(1,s);  // 0%
            envoi_cdm(s);
          end;
        end;
      end;
      end;

      ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr]; //***

      // allume les signaux du feu dans la fenêtre de droite
      Dessine_feu_mx(Feux[i].Img.Canvas,0,0,1,1,adr,1);

      // allume les signaux du feu dans le TCO
      if AvecTCO then
      begin
       for y:=1 to NbreCellY do
       for x:=1 to NbreCellX do
       begin
         if TCO[x,y].Bimage=30 then
         begin
           adresse:=TCO[x,y].adresse;      // vérifie si le feu existe dans le TCO
           aspect:=TCO[x,y].aspect;
           case aspect of
                 2 :  ImageFeu:=Formprinc.Image2feux;
                 3 :  ImageFeu:=Formprinc.Image3feux;
                 4 :  ImageFeu:=Formprinc.Image4feux;
                 5 :  ImageFeu:=Formprinc.Image5feux;
                 7 :  ImageFeu:=Formprinc.Image7feux;
                 9 :  ImageFeu:=Formprinc.Image9feux;
           else ImageFeu:=Formprinc.Image3feux;
           end;
           x0:=(tco[x,y].x-1)*LargeurCell;  // coordonnées XY du feu
           y0:=(tco[x,y].y-1)*HauteurCell;
           TailleY:=ImageFeu.picture.BitMap.Height; // taille du feu d'origine  (verticale)
           TailleX:=ImageFeu.picture.BitMap.Width;
           Orientation:=TCO[x,y].FeuOriente;
           // réduction variable en fonction de la taille des cellules
           calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);

           // décalage en X pour mettre la tete du feu alignée sur le bord droit de la cellule pour les feux tournés à 90G
           if orientation=2 then
           begin
             if aspect=9 then x0:=x0+round(10*frX);
             if aspect=7 then x0:=x0+round(10*frX);
             if aspect=5 then begin x0:=x0+round(10*frX);y0:=y0+HauteurCell-round(tailleX*frY); end;
             if aspect=4 then begin x0:=x0+round(10*frX);y0:=y0+HauteurCell-round(tailleX*frY); end;
             if aspect=3 then begin x0:=x0+round(10*frX);y0:=y0+HauteurCell-round(tailleX*frY); end;
             if aspect=2 then begin x0:=x0+round(10*frX);y0:=y0+HauteurCell-round(tailleX*frY); end;
           end;
           // Dessine_feu_mx(PCanvasTCO,x0,y0,frx,fry,adresse,orientation);
              Dessine_feu_mx(PCanvasTCO,tco[x,y].x,tco[x,y].y,frx,fry,adresse,orientation);
        end;
     end;
    end;
  end;
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

// extrait un entier d'une chaine ex: extract_int('chaine123') = 123
function extract_int(s : string) : integer;
var i,j,l,erreur : integer;
    trouve : boolean;
begin
  i:=0;
  l:=length(s);
  trouve:=false;
  while (i<l) and not(trouve) do
  begin
    inc(i);
    trouve:=s[i] in ['0'..'9'];
  end;
  if trouve then 
  begin
    val(copy(s,i,l),j,erreur);
    extract_int:=j;
  end
  else extract_int:=0;  
end;

// trouve l'index d'un détecteur dans une branche
// si pas trouvé, renvoie 0
function index_detecteur(detecteur,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse;
        trouve:=(detecteur=adr) and ((BrancheN[Num_Branche,i].Btype=det) or (BrancheN[Num_branche,i].BType=buttoir)); // cherche un détecteur
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

// trouve l'index d'un aiguillage dans une branche
// si pas trouvé, renvoie 0
function index_aiguillage(AdrAig,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse; 
        trouve:=(AdrAig=adr) and ((BrancheN[Num_Branche,i].Btype=aig) or (BrancheN[Num_branche,i].BType=buttoir)); // cherche un aiguillage
        //Affiche('cherche='+intToSTR(det)+'/explore='+intToSTR(adr)+' Branche='+intToStr(Num_branche)+' index='+intToStr(i),ClWhite);
        if not(trouve) then inc(i);
        //if trouve then Affiche('Trouvé en branche'+IntToSTR(Num_branche)+' index='+IntToSTR(i),clGreen);
      until trouve or (adr=0) ;
    end;
begin
  i:=1;index2_aig:=0;
  recherche;
  if trouve then result:=i else result:=0;
  //affiche(inttostr(ai+1),clOrange);
  i:=2; // à voir
  //affiche('------------------------',clWhite);
  recherche;
  //affiche('------------------------',clGreen);
  if trouve then index2_aig:=i else index2_aig:=0;
  //affiche('index2='+IntToSTR(index2_det),clWhite);
end;

// si pas trouvé, IndexBranche_trouve=0
procedure trouve_detecteur(detecteur : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  repeat
    i:=index_detecteur(detecteur,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  // if (i<>0) and traceDet then Affiche('Détecteur trouvé en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;

// trouve un aiguillage dans une branche par son adresse
// si pas trouvé, IndexBranche_trouve=0
procedure trouve_aiguillage(adresse : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  repeat
    i:=index_aiguillage(Adresse,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  //if (i<>0) then Affiche('aiguillage '+IntToSTR(adresse)+' trouvé en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;

// si 0 = OK
// si 1 = erreur code Unisemaf
// si 2 = erreur cohérence entre code et aspect
function verif_UniSemaf(adresse,UniSem : integer) : integer;
var aspect : integer;
begin
  if UniSem=0 then begin verif_unisemaf:=0;exit;end;
  if (UniSem<>2) and (UniSem<>3) and (UniSem<>4) and (UniSem<>51) and (UniSem<>52) and (UniSem<>71) and (UniSem<>72) and (UniSem<>73) and
     ((UniSem<90) or (UniSem>99)) then begin verif_UniSemaf:=1;exit;end;

  aspect:=feux[index_feu(adresse)].aspect;
  if  ((aspect=2) and (UniSem=2)) or
      ((aspect=3) and (UniSem=3)) or
      ((aspect=4) and (UniSem=4)) or
      ((aspect=5) and ((UniSem=51) or (UniSem=52))) or 
      ((aspect=7) and ((UniSem=71) or (UniSem=72) or (UniSem=73))) or 
      ((aspect=9) and ((UniSem>=90) or (UniSem<=99))) 
      then Verif_unisemaf:=0
  else Verif_Unisemaf:=2;
end;

procedure lit_config;
var s,sa,chaine,SOrigine: string;
    c,paig : char;
    tec,tjdC,tjsC,s2,trouve,triC,debugConfig,multiple,fini,finifeux,trouve_NbDetDist,trouve_ipv4_PC,trouve_retro,
    trouve_sec_init,trouve_init_aig,trouve_lay,trouve_IPV4_INTERFACE,trouve_PROTOCOLE_SERIE,trouve_INTER_CAR,
    trouve_Tempo_maxi,trouve_Entete,trouve_tco,trouve_cdm,trouve_Serveur_interface,trouve_fenetre,
    trouve_NOTIF_VERSION,trouve_verif_version,trouve_fonte,trouve_tempo_aig,trouve_raz,trouve_section_aig,
    pds,trouve_section_branche,trouve_section_sig,trouve_section_act,compile_init_cfg   : boolean;
    bd,virgule,i_detect,i,erreur,aig2,detect,offset,index, adresse,j,position,temporisation,invers,indexPointe,indexDevie,indexDroit,
    ComptEl,Compt_IT,Num_Element,k,modele,adr,adr2,erreur2,l,t,Nligne,postriple,itl,
    postjd,postjs,nv,it,Num_Champ,asp,adraig : integer;
    label ici1,ici2,ici3,ici4 ;
    
    function lit_ligne : string ;
    var esp : integer;
    begin
      repeat
        readln(fichier,s);
        sOrigine:=s;
        s:=uppercase(s);
        if length(s)>0 then c:=s[1];
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      // supprime les espaces éventuels
      repeat
        esp:=pos(' ',s);
        if esp<>0 then delete(s,esp,1);
      until esp=0;
      lit_ligne:=s;
    end;
    

begin
  compile_init_cfg:=true;
  debugConfig:=false;
  trouve_NbDetDist:=false;
  trouve_ipv4_PC:=false;
  trouve_retro:=false;
  trouve_sec_init:=false;
  trouve_init_aig:=false;
  trouve_tempo_aig:=false;
  trouve_INTER_CAR:=false;
  trouve_entete:=false;
  trouve_IPV4_INTERFACE:=false;
  trouve_lay:=false;
  trouve_Tempo_maxi:=false;
  trouve_PROTOCOLE_SERIE:=false;
  trouve_TCO:=false;
  trouve_Serveur_interface:=false;
  trouve_cdm:=false;
  trouve_NOTIF_VERSION:=false;
  trouve_fenetre:=false;
  trouve_verif_version:=false;
  trouve_Fonte:=false;
  trouve_Raz:=false;

  Nb_Det_Dist:=3;
  // initialisation des aiguillages avec des valeurs par défaut
  for i:=1 to MaxAcc do
  begin
    Aiguillage[i].modele:=rien  ;  //  sans existence
    Aiguillage[i].adresse:=0;
    Aiguillage[i].position:=const_inconnu;  // position inconnue
    Aiguillage[i].PosInit:=const_inconnu;  // position inconnue
    Aiguillage[i].temps:=5   ;
    Aiguillage[i].inversionCDM:=0;
  end;
  for i:=1 to 1024 do
  begin
     Detecteur[i].etat:=false;
     Detecteur[i].train:='0';
     Ancien_detecteur[i]:=false;
  end;

  Affiche('lecture du fichier de configuration config.cfg',clyellow);
  {$I+}
  try
    assign(fichier,'config.cfg');
    reset(fichier);
  except
    Affiche('Fichier config.cfg non trouvé',clred);
    exit;
  end;
  {$I-}
  s:='';

  sa:=uppercase(Raz_signaux_ch)+'=';
  repeat 
  s:=lit_ligne;
  i:=pos(sa,s);
  if i<>0 then
  begin
    inc(nv);
    trouve_Raz:=true;
    delete(s,i,length(sa));
    i:=0;
    val(s,i,erreur);
    if i>1 then i:=1;
    Raz_Acc_signaux:=i=1;
  end;
  until trouve_raz;
  reset(fichier);
  
  if not(trouve_raz) then Affiche('ERREUR: manque variable dans config.cfg : '+Raz_signaux_ch,clred);
  if Raz_Acc_signaux then Affiche('Avec Raz commande signaux',clYellow);

  maxaiguillage:=0;
  Nligne:=1;
  sa:=uppercase(section_aig_ch);
  repeat
    s:=lit_ligne;i:=0;pds:=false;
    if s<>'' then
    begin
      pds:=(s[1]<>'[') and (pos('D',s)<>0) and (pos('S',s)<>0);
      i:=pos(sa,s);
    end;  
    trouve_section_aig:=i<>0;
  until trouve_section_aig or pds or eof(fichier);

  if eof(fichier) Then 
  begin
    affiche('Erreur manque nom des sections dans le fichier config.cfg',clRed);
    exit;
  end;  

  if pds and not(trouve_section_aig) then
    affiche('Manque nom de section '+section_aig_ch+' dans le fichier config.cfg',clred);
  
  Affiche('Définition des aiguillages',clyellow);
  if pds then goto ici1;
  
  repeat
    s:=lit_ligne;
    ici1:
    inc(Nligne);
    //Affiche(s,ClLime);
    //chaine:=s;
    if debugconfig then Affiche(s,ClLime);
    if (s<>'0') then
    begin
      inc(maxaiguillage);
      virgule:=pos(',',s);
      enregistrement:=copy(s,1,virgule-1);  // adresse de l'aiguillage [TRI]
      delete(s,1,virgule);
      postriple:=pos('TRI',enregistrement);triC:=postriple<>0;if triC then delete(enregistrement,postriple,3);
      postjd:=pos('TJD',enregistrement);tjdC:=postjd<>0;if tjdC then delete(enregistrement,postjd,3);
      postjs:=pos('TJS',enregistrement);tjsC:=postjs<>0;if tjsC then delete(enregistrement,postjs,3);

      // adresse de l'aiguillage
      Val(enregistrement,adraig,erreur); // adraig = adresse de l'aiguillage
      if erreur<>0 then Affiche('Erreur aiguillage '+intToSTR(adraig)+' ; caractère '+enregistrement[erreur]+' inconnu',clred);
      if debugConfig then Affiche('Adresse='+IntToSTR(adraig)+' enregistrement='+Enregistrement,clyellow);

      aiguillage[maxaiguillage].adresse:=adraig;
      aiguillage[maxaiguillage].AdroitB:='Z'; aiguillage[maxaiguillage].AdevieB:='Z';
      aiguillage[maxaiguillage].DdroitB:='Z'; aiguillage[maxaiguillage].DdevieB:='Z';

      aiguillage[maxaiguillage].ApointeB:='Z';
      aiguillage[maxaiguillage].Adevie2B:='Z';

      if (triC) then aiguillage[maxaiguillage].modele:=triple;
      if (tjsC) then
      begin
        aiguillage[maxaiguillage].modele:=tjs
      end;
      if (tjdC) then
      begin
        aiguillage[maxaiguillage].modele:=tjd ;
      end;
      if not(tjsC) and not(tjdC) and not(triC) then
      begin
        aiguillage[maxaiguillage].modele:=aig;
      end;
      //if debugConfig then Affiche(s,clyellow);

      if (triC) then
      begin
        Val(s,aig2,erreur); // aig = 2eme adresse de l'aiguillage
        aiguillage[maxaiguillage].AdrTriple:=aig2;
        virgule:=pos(',',s);
        delete(s,1,virgule);
      end;
      ComptEl:=0;Compt_It:=0;Num_element:=Num_element+1;
      // préparer l'enregistrement pour la boucle de ligne

      enregistrement:=s;

      Num_Champ:=1;
      itl:=0;
      repeat  // parcoure la ligne
        if (debugConfig) then Affiche('boucle de ligne: '+s,clYellow);
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='P') then
        begin
          if tjdC then begin affiche('Erreur P interdit dans une TJD : '+sOrigine,clred);closefile(fichier);exit; end;
          if debugconfig then Affiche('Section P - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          decodeAig(enregistrement,detect,c);
          if c='' then c:='Z';
          aiguillage[maxaiguillage].Apointe:=detect;
          aiguillage[maxaiguillage].ApointeB:=c;

          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(Enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        if (length(enregistrement)<>0) then  // section droite
        if (enregistrement[1]='D') then
        begin
          if debugconfig then Affiche('Section D - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          if tjdC or tjsC then
          begin
            Delete(Enregistrement,1,2);
            decodeAig(Enregistrement,detect,c);
            aiguillage[maxaiguillage].Adroit:=detect;
            aiguillage[maxaiguillage].AdroitB:=c;
            i:=pos(',',Enregistrement);Delete(Enregistrement,1,i);
            decodeAig(Enregistrement,detect,c);
            aiguillage[maxaiguillage].DDroit:=detect;
            aiguillage[maxaiguillage].DdroitB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);closefile(fichier);exit;end;
            Delete(enregistrement,1,i+1);

            //Affiche(enregistrement,clBlue);
          end
          else
          begin
            decodeAig(enregistrement,detect,c);
            if c='' then c:='Z';
            aiguillage[maxaiguillage].Adroit:=detect;
            aiguillage[maxaiguillage].AdroitB:=c;

            virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
            delete(enregistrement,1,virgule);
          end;
        end;

        if (length(enregistrement)<>0) then
        if (enregistrement[1]='S') then
        begin
          if debugconfig then Affiche('Section S - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;

          if tjdC or tjsC then
          begin
            Delete(enregistrement,1,2);
            decodeAig(enregistrement,detect,c);
            aiguillage[maxaiguillage].Adevie:=detect;
            aiguillage[maxaiguillage].AdevieB:=c;
            i:=pos(',',enregistrement);Delete(enregistrement,1,i);
            decodeAig(enregistrement,detect,c);
            aiguillage[maxaiguillage].DDevie:=detect;
            aiguillage[maxaiguillage].DDevieB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);closefile(fichier);exit;end;
            Delete(enregistrement,1,i+1);

            //Affiche(enregistrement,clBlue);
          end
          else
          begin
            delete(enregistrement,1,1); // supprime le S
            i:=pos(',',enregistrement);
            if i=0 then i:=length(enregistrement)+1;
            s:=copy(enregistrement,1,i-1); // isole la zone S

            erreur:=pos('2-',s);
            S2:=erreur<>0;
            if (S2) then delete(s,erreur,2);

            erreur:=pos('S2',s); // description d'un rattachement à la branche S2 d'un aiguillage triple
            tec:=erreur<>0;  // ne supprimer que le 2
            if (tec) then delete(s,erreur+1,1);

            //val(enregistrement,detect,erreur);  //  extraction de l'adresse
            decodeAig(s,detect,c);
            //if ((detect=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section S: '+s,clred);
            //c:='Z';
            //if (erreur<>0) then begin delete(enregistrement,1,erreur-1);c:=enregistrement[1];end;

            if not(S2) and not(tec) then begin aiguillage[maxaiguillage].Adevie:=detect;aiguillage[maxaiguillage].AdevieB:=c;end;
            if     S2  and not(tec) then begin aiguillage[maxaiguillage].Adevie2:=detect;aiguillage[maxaiguillage].Adevie2B:=c;end;
            if     S2  and     tec  then begin aiguillage[maxaiguillage].Adevie2:=detect;aiguillage[maxaiguillage].Adevie2B:='T';end;

            virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
            delete(enregistrement,1,virgule);;
          end;
        end;

        // inversion aiguillage
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='I')  then
        begin
           inc(Num_Champ);  
           delete(enregistrement,1,1);
           Val(enregistrement,adr,erreur);
           if (adr<0) or (adr>1) then begin Affiche('Erreur Inversion ; ligne '+sOrigine,clred);end;
           //Affiche(intTostr(adr),clblue);
           Aiguillage[maxaiguillage].inversionCDM:=adr;
           virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
           delete(enregistrement,1,virgule);
        end;
          
        // si vitesse définie
        if (length(enregistrement)<>0) then
        if enregistrement[1]='V' then 
        begin
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          //Affiche('section vitesse définie aig='+intToSTR(aig)+'/'+intToSTR(adr),clyellow);
          aiguillage[maxaiguillage].vitesse:=adr;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(s)+1;
          delete(enregistrement,1,virgule);
        end;  

        // TJS et L
        if (length(enregistrement)<>0) then
        if enregistrement[1]='L' then 
        begin
          if not(tjsC) then begin Affiche('Erreur paramètre L ligne: '+sOrigine,clred);closefile(fichier);exit;end;
          inc(num_champ);
          delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          aiguillage[maxaiguillage].tjsInt:=adr;
          c:=enregistrement[erreur];
          if ((c<>'S') and (c<>'D')) then 
          begin
            c:=' ';Affiche('Erreur paramètre L '+sOrigine,clred);
          end;
          aiguillage[maxaiguillage].tjsIntB:=c;
          virgule:=pos(',',enregistrement);if virgule=0 then virgule:=length(enregistrement)+1;
          delete(enregistrement,1,virgule);
        end;

        // Init aiguillage
        i:=pos('INIT(',enregistrement);
        if i=1 then 
        begin
          compile_init_cfg:=false;  // ne pas compiler la section init du fichier config-gl.cfg
          inc(num_champ);
          delete(enregistrement,i,i+4);
          Val(enregistrement,position,erreur);
          i:=pos(',',enregistrement);
          if i<>0 then delete(enregistrement,1,i);
          Val(enregistrement,j,erreur);
          //i:=pos(',',enregistrement);
          //if i<>0 then delete(enregistrement,1,i);
          //Val(enregistrement,inversion,erreur);
          aiguillage[maxaiguillage].temps:=j;     
          //aiguillage[maxaiguillage].inversion:=inversion;
          aiguillage[maxaiguillage].posinit:=position;
          i:=pos(')',enregistrement);
          delete(enregistrement,1,i);
        end;
        
        inc(itl);
      until (enregistrement='') or (itl>3);
      if itl>4 then begin Affiche('Erreur 400 ligne '+sOrigine,clred);closefile(fichier);exit;end;
    end;
  until (sOrigine='0');

  // branches 
  NDetecteurs:=0; Nligne:=1;
  i_detect:=1;
  repeat
    sa:=uppercase(section_branches_ch);
    s:=lit_ligne;
    if length(s)>0 then pds:=(s[1]<>'[') and (pos('A',s)<>0) and (pos(',',s)<>0);
    i:=pos(sa,s);
    trouve_section_branche:=i<>0;
  until trouve_section_branche or pds or eof(fichier);
  
  if pds and not(trouve_section_branche) then
    affiche('Manque nom de section '+section_branches_ch+' dans le fichier config.cfg',clred); 
  
  Affiche('Définition des branches',clyellow);
  i:=1;
  if pds then goto ici2;
             
  repeat
    s:=lit_ligne;
    ici2:
    if s<>'0' then
    begin
      branche[i]:=s;
      j:=1;offset:=1;
      inc(Nligne);
      compile_branche(s,i);
      inc(i);  
    end;
  until (s='0') or eof(fichier);
  NbreBranches:=i-1;

  // signaux - trouver la section ou une ligne valide feux
  repeat
    sa:=uppercase(section_sig_ch);
    s:=lit_ligne;
    if length(s)>0 then pds:=(s[1]<>'[') and (pos('(',s)<>0) and (pos(')',s)<>0);
    i:=pos(sa,s);
    trouve_section_sig:=i<>0;
  until trouve_section_sig or pds or eof(fichier);

  if pds and not(trouve_section_sig) then
    affiche('Manque nom de section '+section_sig_ch+' dans le fichier config.cfg',clred);
  
  Affiche('Définition des Signaux',clyellow);
  i:=1;Nligne:=1;
  if pds then goto ici3;

  repeat
    inc(Nligne);
    s:=lit_ligne;
    ici3:         
    if s<>'0' then 
    begin 
      decode_ligne_feux(s,i);inc(i);
    end;
  until (s='0') or  eof(fichier);
  NbreFeux:=i-1; if NbreFeux<0 then NbreFeux:=0;

  configNulle:=(maxAiguillage=0) and (NbreBranches=0) and (Nbrefeux=0);
  if configNulle then Affiche('Fonctionnement en config nulle',ClYellow);

  // raz des actionneurs
  for i:=1 to maxTablo_act do
  begin
    Tablo_actionneur[i].train:='';
    Tablo_actionneur[i].etat:=0;
    Tablo_actionneur[i].actionneur:=0;
    Tablo_actionneur[i].accessoire:=0;
    Tablo_actionneur[i].sortie:=0;
  end;  
  
  // actionneurs ou PN - trouver le section ou une ligne valide feux
  repeat
    sa:=uppercase(section_act_ch);
    s:=lit_ligne;
    if length(s)>0 then pds:=(s[1]<>'[') and ((pos('A',s)<>0) or (pos('F',s)<>0) or (pos('PN',s)<>0));   
    i:=pos(sa,s);
    trouve_section_act:=i<>0;
  until trouve_section_act or pds or eof(fichier);

  if pds and not(trouve_section_act) then
    affiche('Manque nom de section '+section_act_ch+' dans le fichier config.cfg',clred);
  
  Affiche('Définition des actionneurs',clyellow);
  maxTablo_act:=1;
  NbrePN:=0;Nligne:=1;
  if pds then goto ici4;
  
  // définition des actionneurs
  repeat        
    s:=lit_ligne;
    ici4:
    // vérifier si F ou A au 4eme champ
    sa:=s; sOrigine:=s;
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    
    inc(Nligne);

    if length(sa)>1 then if (sa[1]='A') then
    // -----------------accessoire
    begin
      // 815,1,CC406526,A600,1
      //Affiche(IntToSTR(maxtablo_act)+' '+sorigine,clLime);
      Tablo_actionneur[maxtablo_act].act:=true;
      Tablo_actionneur[maxtablo_act].loco:=false;
      
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

          i:=pos('A',s);
          if i<>0 then
          begin
            Delete(s,1,1);
            val(s,j,erreur);
            Tablo_actionneur[maxTablo_act].Accessoire:=j;

            i:=pos(',',s);
            if i<>0 then
            begin
              Delete(S,1,i);
              val(s,j,erreur);
              Tablo_actionneur[maxTablo_act].sortie:=j;
            end;

            i:=pos(',',s);
            if i<>0 then
            begin
              Delete(S,1,i);
              Tablo_actionneur[maxTablo_act].RAZ:=s[1]='Z';
              inc(maxTablo_act);
            end;
            
          end;
          s:='';i:=0;
        end;
      end;

    end;

    if length(sa)>1 then if (sa[1]='F') then
    // -----------------loco
    begin
      Tablo_actionneur[maxtablo_act].act:=false;
      Tablo_actionneur[maxtablo_act].loco:=true;
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
  
  Affiche('lecture du fichier de configuration client-GL.cfg',clyellow);
  {$I+}
  try
    assign(fichier,'client-GL.cfg');
    reset(fichier);
  except
    Affiche('Erreur fatale: fichier client-gl.cfg non trouvé',clred);
    exit;
  end;
  {$I-}
  nv:=0; it:=0;
  {lecture du fichier de configuration}
  // taille de fonte
  repeat
    s:=lit_ligne;
    //affiche(s,cllime);
    sa:=uppercase(Fonte_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_fonte:=true;
      delete(s,i,length(sa));
      val(s,TailleFonte,erreur);
      if (TailleFonte<8) or (tailleFonte>25) then taillefonte:=10;
      FormPrinc.FenRich.Font.Size:=TailleFonte;   
    end;

    // adresse ip et port de CDM
    sa:=uppercase(IpV4_PC_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_ipv4_PC:=true;
      delete(s,i,length(sa));
      i:=pos(':',s);
      if i<>0 then 
      begin 
        adresseIPCDM:=copy(s,1,i-1);Delete(s,1,i);
        val(s,portCDM,erreur);
        if (portCDM=0) or (portCDM>65535) or (erreur<>0) then affiche('Erreur port CDM : '+s,clred);
      end
      else affiche('Erreur adresse ip cdm rail '+s,clred);
    end;

    // adresse ip et port de la centrale
    // AfficheDet:=true;
    sa:=uppercase(IPV4_INTERFACE_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_IPV4_INTERFACE:=true;
      delete(s,i,length(sa));
      i:=pos(':',s);
      if i<>0 then 
      begin 
        adresseIP:=copy(s,1,i-1);Delete(s,1,i);port:=StrToINT(s);
        if (adresseIP<>'0') and (port=0) then affiche('Erreur port nul : '+sOrigine,clRed);
      end
      else begin adresseIP:='0';parSocketLenz:=false;end;
    end;

    // configuration du port com
    sa:=uppercase(PROTOCOLE_SERIE_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_PROTOCOLE_SERIE:=true;
      delete(s,i,length(sa));
      if not(config_com(s)) then Affiche('Erreur port com mal déclaré : '+s,clred);
      portcom:=s;
    end;

    // temporisation entre 2 caractères
    sa:=uppercase(INTER_CAR_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_INTER_CAR:=true;
      val(s,TempoOctet,erreur);
      if erreur<>0 then Affiche('Erreur temporisation entre 2 octets',clred);
    end;

    // temporisation attente maximale interface
    sa:=uppercase(TEMPO_MAXI_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_Tempo_maxi:=true;
      val(s,TimoutMaxInterface,erreur);
      if erreur<>0 then Affiche('Erreur temporisation maximale interface',clred);
    end;

    // entete
    sa:=uppercase(ENTETE_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_Entete:=true;
      val(s,Valeur_entete,erreur);
      entete:='';
      case Valeur_entete of
       0 : begin entete:='';suffixe:='';end;
       1 : begin entete:=#$FF+#$FE;suffixe:='';end;
       2 : begin entete:=#228;suffixe:=#13+#13+#10;end;
      end;
      if (erreur<>0) or (valeur_entete>2) then Affiche('Erreur déclaration variable '+entete_ch,clred);
    end;

    // avec ou sans initialisation des aiguillages
    sa:=uppercase(INIT_AIG_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      trouve_init_aig:=true;
      inc(nv);
      delete(s,i,length(sa));
      AvecInitAiguillages:=s='1';
    end;

    // taille de la fenetre
    sa:=uppercase(fenetre_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_fenetre:=true;
      delete(s,i,length(sa));
      val(s,fenetre,erreur);
      if fenetre=1 then Formprinc.windowState:=wsMaximized;
    end;

    // temporisation aiguillages
    sa:=uppercase(Tempo_Aig_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_Tempo_aig:=true;
      delete(s,i,length(sa));
      val(s,Tempo_Aig,erreur);
    end;
 
    sa:=uppercase(verif_version_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      trouve_verif_version:=true;
      inc(nv);
      delete(s,i,length(sa));
      // vérification de la version au démarrage
      verifVersion:=true;
      val(s,i,erreur);
      if erreur=0 then verifVersion:=i=1;
    end;

    sa:=uppercase(NOTIF_VERSION_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_NOTIF_VERSION:=true;
      // vérification de la version au démarrage
      val(s,i,erreur);
      notificationVersion:=i=1;
    end;

    sa:=uppercase(TCO_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      delete(s,i,length(sa));
      trouve_TCO:=true;
      // vérification de la version au démarrage
      val(s,i,erreur);
      AvecTCO:=i=1;
    end;

    sa:=uppercase(CDM_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_CDM:=true;
      delete(s,i,length(sa));
      // vérification de la version au démarrage
      val(s,i,erreur);
      LanceCDM:=i=1;
    end;

    sa:=uppercase(LAY_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_lay:=true;
      delete(s,i,length(sa));
      lay:=s;
    end;

    sa:=uppercase(SERVEUR_INTERFACE_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_serveur_interface:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      ServeurInterfaceCDM:=i;
    end;

    sa:=uppercase(RETRO_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_retro:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      ServeurRetroCDM:=i;
    end;

    sa:=uppercase(nb_det_dist_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_NbDetDist:=true;
      delete(s,i,length(sa));
      val(s,i,erreur);
      if i<2 then begin i:=2;Affiche('Attention '+nb_det_dist_ch+' ramené à '+IntToSTR(i),clOrange); end;
      Nb_Det_Dist:=i;
    end;
    inc(it);

  until ((Nv>=19) and compile_init_cfg) or ((Nv>=18) and not(compile_init_cfg)) or (it>30);

  s:='';//Affiche(intToSTR(Nv),clred);
  if not(trouve_NbDetDist) then s:=nb_det_dist_ch;
  if not(trouve_ipv4_PC) then s:=IpV4_PC_ch;
  if not(trouve_retro) then s:=retro_ch;
  if not(trouve_init_aig) then s:=INIT_AIG_ch;
  if not(trouve_lay) then s:=LAY_ch;
  if not(trouve_INTER_CAR) then s:=INTER_CAR_ch;
  if not(trouve_Tempo_maxi) then s:=Tempo_maxi_ch;
  if not(trouve_Entete) then s:=Entete_ch;
  if not(trouve_TCO) then s:=TCO_ch;
  if not(trouve_CDM) then s:=CDM_ch;
  if not(trouve_Serveur_interface) then s:=Serveur_interface_ch;
  if not(trouve_fenetre) then s:=fenetre_ch;
  if not(trouve_tempo_aig) then s:=tempo_aig_ch;
  if not(trouve_NOTIF_VERSION) then s:=NOTIF_VERSION_ch;
  if not(trouve_verif_version) then s:=verif_version_ch;
  if not(trouve_fonte) then s:=fonte_ch;
  if s<>'' then affiche('ERREUR: manque variables dans config-gl.cfg '+s,clred);

  closefile(fichier);
  verif_coherence;
end;  
  
// front descendant sur un détecteur
function detecteur_0(adresse : integer) : boolean;
begin
  detecteur_0:=(Ancien_detecteur[adresse]=true) and ((detecteur[adresse].etat)=false);
  Ancien_detecteur[adresse]:=detecteur[adresse].etat;
end;

function detecteur_1(adresse : integer) : boolean;
begin
  detecteur_1:=(Ancien_detecteur[adresse]=false) and ((detecteur[adresse].etat)=true);
  Ancien_detecteur[adresse]:=detecteur[adresse].etat;
end;

// trouve un élément dans les branches à partir de la branche offset renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'élément  TypeEL=(1=détécteur 2=aig  3=aig Bis 4=aig triple)
procedure trouve_element(el: integer; TypeEl : TEquipement; Offset : integer);
var i,adr,Branche : integer ;
    s : string;
    BT : TEquipement;
    sort : boolean;
begin
  //Affiche('cherche'+IntToSTR(el)+'/'+IntToSTR(TypeEl),clred);
  Branche:=Offset;
  branche_trouve:=0;
  IndexBranche_trouve:=0;
  i:=1;
  repeat
    adr:=BrancheN[Branche,i].Adresse;
    Bt:=BrancheN[Branche,i].BType;
       //Affiche(IntToSTR(adr)+'/'+IntToSTR(BType),clred);
    if ((adr=0) and (Bt=rien)) then begin inc(Branche);i:=0;end;
    inc(i);
    sort:=(Branche>NbreBranches) or ((adr=el) and (TypeEL=Bt));   
  until (sort);
  if (adr=el) then
  begin
    branche_trouve:=Branche;
    IndexBranche_trouve:=i-1;
    //Affiche('trouvé',clgreen);
  end
  else begin s:='Erreur 175 - élément '+intToSTR(el);
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
// 9999=erreur fatale ou itération trop longue
// 9998= arret sur aiguillage en talon mal positionnée
// 9997: arrêt sur aiguillage dévié
// 9996: arrêt sur position inconnue d'aiguillage
function suivant_alg3(prec : integer;typeELprec : TEquipement;actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
var  Adr,AdrPrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2,N_iteration,index : integer;
     tjscourbe1,tjscourbe2,tjdC,tjsC : boolean;
     A,Aprec,tjsc1B,tjsc2B: char;
     Md,BT,BtypePrec,TypeEL : TEquipement;
     s : string;

     procedure substitue;
     var IndexAdr,IndexActuel : integer;
     begin
       if (typeGen=tjd) then // si le précédent est une TJD/S et le suivant aussi , substituer pointe  (chgt de actuel en VAR dans la déclaration de alg3)
       begin
         IndexAdr:=index_aig(Adr);
         IndexActuel:=index_aig(Actuel);
          if ((aiguillage[IndexAdr].modele=tjd) or (aiguillage[indexAdr].modele=tjs)) and
             ((aiguillage[indexActuel].modele=tjd) or (aiguillage[indexActuel].modele=tjs)) then
          begin
            if nivDebug=3 then AfficheDebug('500 - Détection Précédent=TJD/S Suivant=TJD/S',clyellow);
            // subsituer la pointe
            Actuel:=aiguillage[indexActuel].APointe;
          end;
        end;
      end;


label recommence;
begin
  n_iteration:=0;
  recommence:
  if (TypeELPrec=rien) or (typeElActuel=rien) then
  begin
    s:='Erreur 800 - Types nuls : '+intToSTR(prec)+'/'+intToSTR(BtypeToNUM(TypeElPrec))+' '+IntToSTr(actuel)+'/'+IntToSTR(BtypeToNUM(typeElActuel)) ;
    Affiche(s,clred);
    AfficheDebug(s,clred);
    Suivant_alg3:=9999;exit;
  end;
  if NivDebug=3 then 
    AfficheDebug('Alg3 précédent='+intToSTR(prec)+'/'+intToStr(BtypeToNUM(TypeElprec))+' actuel='+intToSTR(actuel)+'/'+IntToSTR(BtypeToNUM(typeElActuel))+' Alg='+intToSTr(alg),clyellow);
  // trouver les éléments du précédent
  trouve_element(prec,TypeELPrec,1); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouvé',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;
  //  if BTypePrec=2 then aiguillage[index_aig(prec].A

  trouve_element(actuel,typeElActuel,1); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouvé',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Bt:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

  //Affiche('Btype='+intToSTR(Btype)+' Actuel='+inTToSTR(actuel),clyellow);

  if Bt=det then  // l'élément actuel est un détecteur
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
        AfficheDebug(s,clwhite);
      end;
      suivant_alg3:=adr;
      exit;
    end;
    // ici, les éléments sont non consécutifs. voir si l'un des deux est une TJD/TJS
    if (btypePrec=aig) then // car btype dans les branches vaut det, aig, buttoir mais jamais tjd ni tjs
    begin
      // changer l'adresse du précédent par l'autre adresse de la TJD/S
      index:=index_aig(prec);
      md:=aiguillage[index].modele;
      if (md=tjs) or (md=tjd) then
      begin
        prec:=Aiguillage[index_aig(prec)].Ddroit;
        if NivDebug=3 then AfficheDebug('Le précedent est une TJD/S - substitution du precédent par la pointe de la TJD qui est '+intToSTR(prec),clYellow);
      end;
    end;  
    inc(n_iteration);
    if n_iteration>50 then
    begin
      s:='Erreur fatale 9999, trop d''itérations';
      Affiche(s,clRed);
      AfficheDebug(s,clRed);
      suivant_alg3:=9999;
      exit;
    end;
    goto recommence;
    //Affiche('Erreur 44 - éléments non consécutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
    //if NivDebug=3 then AfficheDebug('Erreur 44 - éléments non consécutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
  end;

  if (Bt=aig) or (Bt=buttoir) then  // aiguillage ou buttoir
  begin
    index:=index_aig(adr);
    if (aiguillage[index].modele=aig) and (Bt=aig)  then // aiguillage normal 
    begin
      // aiguillage pris en pointe
      if (aiguillage[index].Apointe=prec) then
      begin
        if aiguillage[index].position=const_droit then
        begin
          if NivDebug=3 then AfficheDebug('130 - aiguillage '+intToSTR(Adr)+' Pris en pointe droit',clyellow);
          if Adr=0 then
          begin
            Affiche('131 - Erreur fatale',clRed);suivant_alg3:=9999;exit;
          end;
          BtypePrec:=Bt;
          Aprec:=a;
          A:=aiguillage[index].AdroitB;
          Adr:=aiguillage[index].Adroit;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
          trouve_element(adr,typeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[index].position=const_devie then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe dévié',clyellow);
          // AdrPrec:=Adr;  // JU
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
          begin
            typeGen:=rien;
            AdrDevie:=Adr;
            suivant_alg3:=9997;exit;
          end;
          if Adr=0 then
          begin Affiche('134 - Erreur fatale',clRed);
            if NivDebug>=1 then AfficheDebug('134 - Erreur fatale',clRed);
            suivant_alg3:=9999;exit;
          end;
          BtypePrec:=Bt;
          Aprec:=A;
          A:=aiguillage[index].AdevieB;
          Adr:=aiguillage[index].Adevie;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
          trouve_element(adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;exit;
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
        if (alg=2) then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if aiguillage[index].position=const_droit then
          begin
            // si TJD (modele=2) sur le précédent, alors substituer avec la 2eme adresse de la TJD
            if aiguillage[index_aig(prec)].modele=tjd then prec:=aiguillage[index_aig(prec)].DDroit;
            if prec<>aiguillage[index_aig(Adr)].Adroit then
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
            if prec<>aiguillage[index].Adevie then
              begin                           
                if NivDebug=3 then AfficheDebug('135.3 Aiguillage '+intToSTR(adr)+' mal positionné',clyellow);
                suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('135.4 Aiguillage '+intToSTR(adr)+' bien positionné',clyellow);
              end;
          end;
        end;

        // AdrPrec:=Adr;  // JU
        if Adr=0 then
        begin 
          Affiche('136 - Erreur fatale',clRed);
          if NivDebug>=1 then AfficheDebug('136 - Erreur fatale',clRed);
          suivant_alg3:=9999;exit;
        end;
        BtypePrec:=Bt;
        APrec:=A;
        A:=aiguillage[index].ApointeB;
        Adr:=aiguillage[index].Apointe;
        //  Affiche('trouvé '+intToSTR(adr),clyellow);
        if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
        trouve_element(adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        suivant_alg3:=adr;
        exit;
      end;
      if NivDebug=3 then 
      begin
        s:='138 - Aiguillage '+IntToSTR(adr)+' non résolu';
        if aiguillage[index].position=const_inconnu then s:=s+' car position inconnue';
        AfficheDebug(s,clOrange);
      end;
      
      suivant_alg3:=9999;exit;
    end;

    if (aiguillage[index].modele=tjd) or (aiguillage[index].modele=tjs) then // TJD ou TJS
    begin
      // récupérer les élements de la TJD/S
      AdrTjdP:=aiguillage[index].Ddroit; // 2eme adresse de la TJD/S
      tjdC:=aiguillage[index].modele=tjd;
      tjsC:=aiguillage[index].modele=tjs;
      tjsc1:=aiguillage[index].tjsint;   // adresses de la courbe de la TJS
      tjsc2:=aiguillage[index_aig(AdrTjdP)].tjsint;
      tjsc1B:=aiguillage[index].tjsintB;
      tjsc2B:=aiguillage[index_aig(AdrTjdP)].tjsintB;
      if tjsc1<>0 then  // si tjs
      begin
        tjscourbe1:=(aiguillage[index].tjsintB='S') and (aiguillage[index_aig(tjsc1)].position<>const_droit);
        tjscourbe1:=((aiguillage[index].tjsintB='D') and (aiguillage[index_aig(tjsc1)].position=const_droit)) or tjscourbe1;
      end;
      if tjsc2<>0 then
      begin
        tjscourbe2:=(aiguillage[index_aig(AdrTjdP)].tjsintB='S') and (aiguillage[index_aig(tjsc2)].position<>const_droit);
        tjscourbe2:=((aiguillage[index_aig(AdrTjdP)].tjsintB='D') and (aiguillage[index_aig(tjsc2)].position=const_droit)) or tjscourbe2;
      end;

      if NivDebug=3 then
      begin
        s:='137 - TJD '+intToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' pos=';
        if aiguillage[index].position=const_droit then s:=s+'droit'
        else if aiguillage[index].position=const_devie then s:=s+'dévié'
          else s:=s+'inconnu' ;
        if aiguillage[index_aig(AdrTJDP)].position=const_droit then s:=s+'/droit'
        else if aiguillage[index_aig(AdrTJDP)].position=const_devie then s:=s+'/dévié'
          else s:=s+'/inconnu' ;
        AfficheDebug(s,clyellow);
      end;

      // rechercher le port de destination de la tjd
      Adr2:=0;A:='Z';
      if aiguillage[index].position=const_droit then
      begin
        A:=aiguillage[index].DDroitB;
        adr2:=aiguillage[index].DDroit;
      end;
      if aiguillage[index].position=const_devie then
      begin
        A:=aiguillage[index].DDevieB;
        adr2:=aiguillage[index].DDevie;
      end;
      if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr2)+a,clyellow);

      // extraire l'élément connecté au port de destination de la tjd
      if A='S' then
      begin
        A:=aiguillage[index_aig(adr2)].AdevieB;
        adr2:=aiguillage[index_aig(adr2)].Adevie;
        //Affichedebug('element connecté:'+inttostr(adr)+A,clred);
      end
      else
      if A='D' then
      begin
        A:=aiguillage[index_aig(adr2)].AdroitB;
        adr2:=aiguillage[index_aig(adr2)].Adroit;
      end
      else
      begin
        if aiguillage[index].position<>9 then
        begin
          s:='Erreur 1021 TJD '+intToSTR(adr)+' non résolue';
          affichedebug(s,clred);
          Affiche(s,clred);
          suivant_alg3:=9996;
          exit;
        end
        else 
        begin
          if NivDebug=3 then
          begin
            s:='1022 - Position TJD '+intToSTR(adr)+' non résolue car position inconnue';
            affichedebug(s,clOrange);
          end;  
          suivant_alg3:=9996;
        end;
      end;

      if nivDebug=3 then AfficheDebug('tjd: '+s+' Suiv='+intToSTR(adr2)+A,clYellow);
      if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig  
      suivant_alg3:=adr2;
      exit;

      // determiner la position de la première section de la TJD (4 cas)
      // cas 1 : droit droit
      if (( aiguillage[index_aig(AdrTJdP)].position=const_droit) and
           (aiguillage[index].position=const_droit) and tjdC)  then
      begin
        // d'où vient ton sur la tjd
        if aiguillage[index].Adroit=prec then
        begin
          A:=aiguillage[index].DdroitB;
          Adr:=aiguillage[index].Ddroit;
          if A='D' then
          begin
             Adr:=aiguillage[index_aig(AdrTjDP)].Adroit;
             A:=aiguillage[index_aig(AdrTjDP)].AdroitB;
          end;
          if A='S' then
          begin
             Adr:=aiguillage[index_aig(AdrTjDP)].Adevie;
             A:=aiguillage[index_aig(AdrTjDP)].AdevieB;
          end;
          if NivDebug=3 then AfficheDebug('cas1.1 tjd: '+s+' Adr='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig  
          suivant_alg3:=adr;
          substitue;
          exit;
        end;
        if aiguillage[index].Adevie=prec then
        begin
          A:=aiguillage[index_aig(AdrTjdP)].AdroitB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adroit;
          if NivDebug=3 then AfficheDebug('cas1.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig 
          suivant_alg3:=adr;
          substitue;
          exit;
        end;
        s:='Erreur 1021, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionnée';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 2 TJD
      if (aiguillage[index].position=const_devie)
         and (aiguillage[index_aig(AdrTjdP)].position=const_droit) and tjdC then
      begin
        if aiguillage[index].Adevie=prec then
        begin
          A:=aiguillage[index_aig(AdrTjdP)].AdroitB;
          Adr:=aiguillage[index_aig(AdrTJDP)].Adroit;
          if NivDebug=3 then AfficheDebug('cas2.1 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig  
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        if (aiguillage[index].Adroit=prec)  then
        begin
          A:=aiguillage[index_aig(AdrTJDP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if NivDebug=3 then AfficheDebug('cas2.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);

          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig 
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        s:='Erreur 1023, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionnée';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 3 TJD
      if (aiguillage[index].position=const_droit)
          and (aiguillage[index_aig(AdrTjdP)].position=const_devie) and tjdC then
      begin
        // si on vient de
        if (aiguillage[index].Adroit=prec) then
        begin
          if NivDebug=3 then AfficheDebug('cas3.1 tjd: '+s,clYellow);
          A:=aiguillage[index].DdroitB;
          Adr:=aiguillage[index].Ddroit;
          if A='D' then
          begin
             Adr:=aiguillage[index_aig(AdrTjDP)].Adroit;
             A:=aiguillage[index_aig(AdrTjDP)].AdroitB;
          end;
          if A='S' then
          begin
             Adr:=aiguillage[index_aig(AdrTjDP)].Adevie;
             A:=aiguillage[index_aig(AdrTjDP)].AdevieB;
          end;

          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig 
          //substitue;
          suivant_alg3:=adr;
          exit;
        end;
        // si on vient de
        if (aiguillage[index].Adevie=prec) then
        begin
          A:=aiguillage[index_aig(AdrTJDP)].AdroitB;
          Adr:=aiguillage[index_aig(AdrTJDP)].Adroit;
          if NivDebug=3 then AfficheDebug('cas3.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig 
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        s:='Erreur 1024, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionnée';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 4 tjd
      if (aiguillage[index].position=const_devie)
         and (aiguillage[index_aig(AdrTjdP)].position=const_devie)  then
      begin
        if aiguillage[index].Adevie=prec then
        begin
          A:=aiguillage[index_aig(AdrtjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrtjdP)].Adevie;
          if NivDebug=3 then AfficheDebug('cas4.1 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[index].Adroit=prec then
        begin
          A:=aiguillage[index_aig(AdrtjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrtjdP)].Adevie;
          if NivDebug=3 then AfficheDebug('cas4.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig  
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        s:='Erreur 1025, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionnée';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;
        exit;
      end;
      // cas TJS prise dans sa position courbe
      if ((aiguillage[index].Adevie=Prec) and (aiguillage[index].AdevieB=Aprec) and (aiguillage[index].position<>const_droit)
        and (aiguillage[index_aig(AdrTjdP)].position=const_droit) and (tjsC) and tjscourbe1 and tjscourbe2) then
      begin
        if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
        A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
        Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
        if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig  
        substitue;
        suivant_alg3:=adr;
        exit;
      end;
      // cas 3 TJS prise dans sa 2eme position courbe
      if ((aiguillage[index].Adroit=Prec) and (aiguillage[index].AdroitB=Aprec) and (aiguillage[index].position=const_droit)
           and (aiguillage[index_aig(AdrTjdP)].position<>const_droit) and (tjsC) and tjscourbe1 and tjscourbe2 ) then
      begin
        if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
        A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
        Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
        if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig  
        suivant_alg3:=adr;
        substitue;
        exit;
      end;
      s:='1026 - Erreur fatale - position TJD/S '+IntToSTR(Adr)+'/'+intToSTR(AdrTJDP)+' inconnue';
      Affiche(s,clred);
      AfficheDebug(s,clred);
      suivant_alg3:=9999;exit;
    end;

    if (aiguillage[index].modele=triple) then // aiguillage triple
    begin
      Adr2:=aiguillage[index].AdrTriple;
      if (aiguillage[index].Apointe=prec) then
      begin
        // aiguillage triple pris en pointe
        //Affiche('position='+intToSTR(aiguillage[index_aig(Adr].position),clyellow);
        if  (aiguillage[index].position=const_droit) and (aiguillage[index_aig(Adr2)].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple pris en pointe droit',clYellow);
          A:=aiguillage[index].AdroitB;
          Adr:=aiguillage[index].Adroit;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[index].position<>const_droit) and (aiguillage[index_aig(Adr2)].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple dévié1 (à gauche)',clYellow);
          A:=aiguillage[index].AdevieB;
          Adr:=aiguillage[index].Adevie;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[index].position=const_droit) and (aiguillage[index_aig(Adr2)].position<>const_droit)  then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple dévié2 (à droite)',clYellow);
          A:=aiguillage[index].Adevie2B;
          Adr:=aiguillage[index].Adevie2;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        begin
          if aiguillage[index].position=const_inconnu then begin suivant_alg3:=9996;exit;end; // pour échappement
          s:='Aiguillage triple '+IntToSTR(Adr)+' : configuration des aiguilles interdite';
          if CDM_connecte then s:=s+': '+IntToSTR(aiguillage[index].position);
          AfficheDebug(s,clYellow);
          Affiche(s,clRed);
          suivant_alg3:=9999;
          exit; 
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('Aiguillage triple pris en talon',clyellow);
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(adr2)].position=const_droit) then
          begin
            if prec<>aiguillage[index].Adroit then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionné',clyellow);
            end;
          end;
          if (aiguillage[index].position<>const_droit) and (aiguillage[index_aig(adr2)].position=const_droit) then
          begin
            if prec<>aiguillage[index].Adevie then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionné',clyellow);
            end;
          end;
          if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(adr2)].position<>const_droit) then
          begin
            if prec<>aiguillage[index].Adevie2 then
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
        A:=aiguillage[index].ApointeB;
        Adr:=aiguillage[index].Apointe;
        if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig  
        trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
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
  until (trouve) or (i>=NbreFeux);
  if trouve then Index_feu_det:=i else Index_feu_det:=0;
end;

// renvoie l'adresse du détecteur suivant des deux éléments contigus
// TypeElprec/actuel: 1= détecteur  2= aiguillage 4=Buttoir
// algo= type d'algorythme pour suivant_alg3
function detecteur_suivant(prec : integer;TypeElPrec : TEquipement;actuel : integer;TypeElActuel : TEquipement;algo : integer) : integer ;
var actuelCalc,PrecCalc,j,AdrSuiv ,indexCalc : integer;
    TypeprecCalc,TypeActuelCalc : TEquipement;       
begin
  if NivDebug>=2 then 
    AfficheDebug('Proc Detecteur_suivant '+IntToSTR(prec)+','+IntToSTR(BTypeToNum(typeElPrec))+'/'+intToSTR(actuel)+','+
                  intToSTR(BTypeToNum(TypeElActuel))+
                  ' Alg='+IntToSTR(algo),clyellow);
  j:=0;

  PrecCalc:=prec;
  TypeprecCalc:=TypeElprec;
  ActuelCalc:=actuel;
  TypeActuelCalc:=TypeELActuel;
  // étape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,TypeprecCalc,actuelCalc,TypeActuelCalc,algo); 
    indexCalc:=index_aig(actuelCalc);
    if (typeGen=tjd) and false then // si le précédent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[index_aig(AdrSuiv)].modele=tjd) or (aiguillage[index_aig(AdrSuiv)].modele=tjs)) and
           ((aiguillage[indexCalc].modele=tjd) or (aiguillage[indexCalc].modele=tjs)) then
        begin
          if nivDebug=3 then AfficheDebug('501 - Détection Précédent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuelCalc:=aiguillage[indexCalc].APointe;
        end;
      end;
    precCalc:=actuelCalc;
    TypeprecCalc:=TypeActuelCalc;
    actuelCalc:=AdrSuiv;
    TypeActuelCalc:=typeGen;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=10) or (typeGen=det) or (AdrSuiv=0) or (AdrSuiv>=9996); // arret si détecteur

  // si trouvé le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1);
     {if (typeGen=2) then // si le précédent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[index_aig(AdrSuiv].modele=2) or (aiguillage[index_aig(AdrSuiv].modele=3)) and
           ((aiguillage[index_aig(actuel].modele=2) or (aiguillage[index_aig(Actuel].modele=3)) then
        begin
          if nivDebug=3 then AfficheDebug('501 - Détection Précédent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuel:=aiguillage[index_aig(Actuel].APointe;
        end;
      end;
      }
  end;
  if (NivDebug=3) and (AdrSuiv<9996) then AfficheDebug('618 : Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// renvoie les adresses des détecteurs adjacents au détecteur "adresse"
// résultat dans adj1 et adj2
procedure Det_Adj(adresse : integer);
var Adr,AdrFonc,Branche,AdrPrec,IndexBranche,i,Dir : integer;
    sortie : boolean;
    BtypeFonc,BtypePrec : TEquipement;
begin
  if TraceListe then AfficheDebug('Det_Adj '+IntToSTR(adresse),clyellow);
  trouve_element(adresse,det,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('Erreur 380 : élément '+IntToSTR(adresse)+' non trouvé',clred);
    exit;
  end;
  IndexBranche:=IndexBranche_trouve;
  branche:=branche_trouve;
  Dir:=1 ; //test direction

  repeat
    if (Dir=1) then i:=IndexBranche-1 else i:=IndexBranche+1;

    AdrPrec:=Adresse;
    BtypePrec:=det;

    AdrFonc:=BrancheN[branche,i].Adresse;
    BtypeFonc:=BrancheN[branche,i].BType;

    i:=0;
    repeat
      if BtypeFonc<>det then
      begin
        Adr:=suivant_alg3(AdrPrec,BtypePrec,AdrFonc,BtypeFonc,2);  // élément suivant mais arret sur aiguillage en talon mal positionnée
      end
      else
        begin Adr:=AdrFonc;TypeGen:=BtypeFonc;end;
      if Adr>9990 then typeGen:=det;
      if (NivDebug=3) then AfficheDebug('trouvé '+intToSTR(Adr)+' '+intToSTR(BTypeToNum(typeGen)),clorange);
      AdrPrec:=AdrFonc;BtypePrec:=BtypeFonc;
      AdrFonc:=Adr;BtypeFonc:=typeGen;
      i:=i+1;
      sortie:=(i=20) or (Adr=0) or (Adr>=9996) or (TypeGen=det);
    until (sortie) ;   // boucle de parcours
    if (typeGen=det) and (Dir=1) then begin Adj1:=Adr;end;
    if (typeGen=det) and (Dir=2) then begin Adj2:=Adr;end;
    inc(dir);
  until dir=3;
  if TraceListe then AfficheDebug('Fin Det_Adj ',clyellow);
end;

// renvoie l'adresse du détecteur suivant des deux éléments
// El1 et El2 peuvent être séparés par des aiguillages, mais de pas plus de 3 détecteurs
// en sortie : 9999= det1 ou det2 non trouvé
// 9996 : non trouvé
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,i1,N_det : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;
                                                           
begin
  if NivDebug>=2 then
  AfficheDebug('Proc Detecteur_suivant_EL '+intToSTR(el1)+','+intToSTR(BTypeToNum(Typedet1))+'/'+intToSTR(el2)+','+intToSTR(BTypeToNum(Typedet2))+'-------------------------',clLime);
  if (el1>9000) or (el2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('paramètres incorrects >9000',clred);
    detecteur_suivant_El:=9999;
  end;

  // trouver détecteur 1
  trouve_element(el1,Typedet1,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(el1)+' non trouvé';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    detecteur_suivant_El:=9999;exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver détecteur 2
  trouve_element(el2,Typedet2,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(el2)+' non trouvé';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    detecteur_suivant_El:=9999;exit;
  end;
  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  j:=1;  // J=1 test en incrément J=2 test en décrément

  // étape 1 : trouver le sens de progression (en incrément ou en décrément)
  
  repeat
    //préparer les variables
    AdrPrec:=el1;TypePrec:=typeDet1;
    if j=1 then i1:=IndexBranche_det1+1;
    if j=2 then i1:=IndexBranche_det1-1;
    // les suivants dansla branche sont:
    AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
    typeFonc:=BrancheN[branche_trouve_det1,i1].Btype ;
    
    if NivDebug=3 then
    begin
      s:='Test en ';
      if (j=1) then s:=s+'incrément ' else s:=s+'décrément ';
      s:=s+'- départ depuis élément '+IntToSTR(el1)+' trouvé en index='+intToSTR(IndexBranche_det1)+' Branche='+intToSTR(branche_trouve_det1);
      AfficheDebug(s,clyellow);
    end;

    i:=0;N_Det:=0;
    if AdrFonc<>El2 then // si pas déja trouvé le sens de progression
    begin
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        if nivDebug=3 then AfficheDebug('i='+IntToSTR(i)+' NDet='+IntToSTR(N_det),clyellow);
        if (AdrFonc<>0) or (TypeFonc<>rien) then Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg) else
        begin
          Adr:=9999;
        end;
        
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);
        if TypeGen=det then inc(N_Det);
        if NivDebug=3 then
        begin
          s:='613 : trouvé='+intToSTR(Adr);
          case typeGen of
           det : s:=s+' detecteur';
           aig : s:=s+' aiguillage';
           end;
          AfficheDebug(s,clYellow);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((typeDet2=TypeGen) and (Adr=el2)) or (Adr=0) or (Adr>=9996) or (i=15) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i=15) and (Nivdebug=3) then afficheDebug('Pas trouvé',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then afficheDebug('Détecteurs trop distants',clred);
    end

    else
    begin
      // déja trouvé
      adr:=el2;typeGen:=TypeDet2;
    end;
  
    if (typeDet2=TypeGen) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      if Nivdebug=3 then AfficheDebug('614 - Trouvé '+intToSTR(el2),clYellow);
      i:=0;
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg);
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);

        if NivDebug=3 then
        begin
          s:='614 : trouvé='+intToSTR(Adr);
          case typeGen of
           det : s:=s+' detecteur';
           aig : s:=s+' aiguillage';
           buttoir : s:=s+' buttoir';
           end;
           AfficheDebug(s,clorange);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=(TypeGen=det) or (Adr=0) or (Adr>=9996) or (i=10);
      until sortie;
    
      if (TypeGen=det) or (TypeGen=buttoir) then
      begin
        if NivDebug=3 then
        begin
          AfficheDebug('le détecteur suivant est le '+IntToSTR(Adr),clyellow);
          affichedebug('------------------',clyellow);
        end;
        detecteur_suivant_el:=Adr;
        exit;
      end;
    end;
    if (i=10) then if NivDebug=3 then AfficheDebug('201 : Itération trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incrément/décrément

  detecteur_suivant_el:=9996;
  if NivDebug=3 then affichedebug('------------------',clyellow);
end;


// renvoie vrai si les aiguillages déclarés dans la définition du signal sont mal positionnés
// (conditions suppplémentares)
function cond_carre(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig,index : integer;
    resultatET,resultatOU: boolean;
    s : string;
begin
  i:=index_feu(adresse);
  NCondCarre:=Length(feux[i].condcarre[1]);

  l:=1;
  resultatOU:=false;

  while NcondCarre<>0 do
  begin
    if Ncondcarre<>0 then dec(Ncondcarre);
    resultatET:=true;
    for k:=1 to NcondCarre do
    begin
      //s2:=s2+'A'+IntToSTR(feux[i].condcarre[l][k].Adresse)+feux[i].condcarre[l][k].PosAig+' ';
      AdrAig:=feux[i].condcarre[l][k].Adresse;
      index:=index_aig(adrAig);
      if index<>0 then
      begin
        if nivDebug=3 then AfficheDebug('Contrôle aiguillage '+IntToSTR(AdrAig),clyellow);
        resultatET:=((aiguillage[index].position=const_devie) and (feux[i].condcarre[l][k].PosAig='S') or (aiguillage[index].position=const_droit) and (feux[i].condcarre[l][k].PosAig='D'))
                  and resultatET;
      end;            
    end;
    //if resultatET then Affiche('VRAI',clyellow) else affiche('FAUX',clred);
    inc(l);
    resultatOU:=resultatOU or resultatET;
    NCondCarre:=Length(feux[i].condcarre[l]);
  end;
  //if resultatOU then Affiche('VRAI final',clyellow) else affiche('FAUX final',clred);
  if NivDebug=3 then
  begin
    s:='Conditions supp. de carré suivant aiguillages: ';
    if ResultatOU then s:=s+'vrai : le signal doit afficher carré' else s:=s+'faux : le signal ne doit pas afficher de carré';
    AfficheDebug(s,clyellow);
  end;
  cond_carre:=ResultatOU;
end;

// renvoi vrai si les aiguillages au delà du signal sont mal positionnés
function carre_signal(adresse : integer) : boolean;
var
   i,j,prec,AdrFeu,AdrSuiv,actuel : integer;
   TypeELPrec,TypeElActuel : TEquipement;
   multi, sort  : boolean;
begin
  if (NivDebug>=1) then AfficheDebug('Test si signal '+IntToSTR(adresse)+' doit afficher un carré si aiguillage avals mal positionnés',clyellow);

  i:=Index_feu(adresse);
  j:=0;
  prec:=feux[i].Adr_det1;
  TypeElPrec:=Det;
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=det then TypeElActuel:=det;  // le type du feu   1=détécteur   2=aig  5=bis
  if feux[i].Btype_suiv1=aig then TypeElActuel:=aig;
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
    {if (typeGen=2) then // si le précédent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[index_aig(AdrSuiv].modele=2) or (aiguillage[index_aig(AdrSuiv].modele=3)) and
           ((aiguillage[index_aig(actuel].modele=2) or (aiguillage[index_aig(actuel].modele=3)) then
        begin
          if nivDebug=3 then AfficheDebug('505 - Détection Précédent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuel:=aiguillage[index_aig(actuel].APointe;
        end;
      end;  }

    
    if (AdrSuiv=9999) or (AdrSuiv=9996) then // élément non trouvé ou position aiguillage inconnu
    begin
      carre_signal:=true;  
      exit;
    end;
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
      AdrFeu:=index_feu_det(AdrSuiv); // trouve l'index du feu correspondant au détecteur AdrSuiv
      //Affiche(IntToSTR(AdrFeu),clOrange);
    end;
    sort:=(j=10) or (AdrFeu<>0) or (AdrSuiv=9998) or (AdrSuiv=0); // arret si aiguillage en talon ou buttoir
  until (sort);
  // si trouvé un feu ou j=10, les aiguillages sont bien positionnés
  // si trouvé 9998, aiguillages mal positionnés
  if (NivDebug>=1) then
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
var num_feu,etat,AdrFeu,i,j,prec,AdrSuiv : integer;
    aspect,combine : word;
    TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('Cherche état du signal suivant au '+IntToSTR(adresse),clyellow);
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
    Affiche('Erreur 600 - feu '+IntToSTR(adresse)+' non trouvé',clred);
    if NivDebug=3 then AfficheDebug('Erreur 600 - feu '+IntToSTR(adresse)+' non trouvé',clred); 
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;
  Etat:=0;
  j:=0;
  num_feu:=0;
  prec:=Feux[i].Adr_det1;  // détecteur sur le courant
  TypePrec:=det;  
  if prec=0 then
  begin
    Affiche('Msg 601 - feu '+intToSTR(adresse)+' non renseigné ',clOrange);
    if NivDebug=3 then AfficheDebug('Msg 601 - feu '+intToSTR(adresse)+' non renseigné ',clOrange);
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;
 
  actuel:=feux[i].Adr_el_suiv1;
  typeActuel:=feux[i].Btype_suiv1;
  if nivDebug=3 then AfficheDebug('Actuel ='+IntToSTR(actuel),clyellow);  
  repeat
    inc(j);
    if nivDebug=3 then AfficheDebug('Itération '+IntToSTR(j),clyellow);

    // à la première itération, si "actuel" est déja un détecteur, ne pas faire de recherche sur le suivant
    if (j=1) and (TypeActuel=det) then
    begin
      AdrSuiv:=actuel;
    end
    else
    begin
      //if nivDebug=3 then AfficheDebug('Engagement j='+IntToSTR(j)+' '+IntToSTR(prec)+'/'+IntToSTR(actuel),clyellow);
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      if Nivdebug=3 then AfficheDebug('Suivant='+intToSTR(AdrSuiv),clyellow);
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

      if (AdrSuiv=9999) or (AdrSuiv=9996) then
      begin
        Etat_signal_suivant:=0;
        AdresseFeuSuivant:=0;
        exit;
      end;
      if (AdrSuiv=0) then
      begin
        if NivDebug=3 then AfficheDebug(intToSTR(j)+' Le suivant est un buttoir',clyellow);
        Etat_signal_suivant:=carre_F; // faire comme si c'était un signal au carré
        AdresseFeuSuivant:=0;
        exit;
      end;
    end;
    // si le suivant est un détecteur comporte t-il un signal?
    AdrFeu:=0;
    if (TypeActuel=det) then  // détecteur?
    begin
      i:=Index_feu_det(Actuel); // trouve l'index de feu affecté au détecteur "Actuel"
      AdrFeu:=Feux[i].Adresse;
      if adrFeu<>0 then
      begin
        if nivdebug=3 then afficheDebug('Détecteur='+IntToSTR(AdrSuiv)+' AdrFeu='+IntToSTR(AdrFeu)+' prec='+IntToSTR(prec),clyellow );
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
            code_to_aspect(Etat,aspect,combine);
            Signal_suivant:=AdrFeu;
            if NivDebug=3 then AfficheDebug('Trouvé feu suivant Adr='+IntToSTR(AdrFeu)+': '+IntToSTR(etat)+'='+EtatSign[aspect]+' '+EtatSign[combine],clorange);
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouvé feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
            AdrFeu:=0;
          end;
        end
      end
      else if nivDebug=3 then AfficheDebug('Pas de feu pour le det '+IntToSTR(AdrSuiv),clyellow);
    end;
  until (j=10) or ((AdrFeu<>0) and (num_feu=rang));
  if etat=0 then Signal_Suivant:=0;
  etat_signal_suivant:=Etat;
  AdresseFeuSuivant:=Signal_suivant;
  if (NivDebug=3) and (adrFeu=0) then AfficheDebug('Pas Trouvé de feu suivant au feu Adr='+IntToSTR(ADresse),clOrange);
end;

// renvoie l'adresse de l'aiguille si elle est déviée après le signal et ce jusqu'au prochain signal
// sinon renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;
var AdrFeu,i,j,prec,AdrSuiv,Actuel,index : integer;
   TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  if NivDebug>=2 then AfficheDebug('Test si aiguille déviée après signal '+IntToSTR(Adresse),clyellow);
  j:=0;
  i:=Index_feu(adresse);
  prec:=feux[i].Adr_det1;
  TypePrec:=det;
  actuel:=feux[i].Adr_el_suiv1;
  TypeActuel:=feux[i].Btype_suiv1 ;
  AdrFeu:=0;
  AdrDevie:=0;
  if (TypeActuel=aig) then  // aiguillage
  begin
    index:=index_aig(actuel);
    if (aiguillage[index].Apointe=prec) and (aiguillage[index].position<>const_droit) then Aiguille_deviee:=actuel;
  end;

  repeat
    inc(j);
    // le 3=demande si le suivant est un aiguillage en pointe dévié oui si AdrSuiv=9997
    // dans ce cas la variable globale AdrDevie est mise à jour
    AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,3);

    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if ADrSuiv<>9997 then
    begin
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      // si le suivant est un détecteur comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=det) then  // détecteur
      begin
        i:=Index_feu_det(AdrSuiv); // trouve l'index de feu affecté au détecteur "AdrSuiv"
        AdrFeu:=Feux[i].Adresse;
        if NivDebug=3 then AfficheDebug('trouvé signal '+intToSTR(AdrFeu)+' associé au détecteur '+IntToSTR(AdrSuiv),clyellow);
      end;
    end;
  until (j=10) or (AdrSuiv>=9996) or (AdrFeu<>0) ;
  if (AdrSuiv=9997) then
  begin
     s:='le signal '+intToSTR(adresse)+' doit afficher un rappel car l''aiguillage '+intToSTR(AdrDevie);
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

// allume le signal directionnel d'adresse ADR en fonction de la position des aiguillages déclarés pour ce feu
procedure Signal_direction(Adr : integer);
var NAig,i,id,j,NfeuxDir,AdrAigFeu,Position : integer;
    PosAigFeu : char;
    Positionok : boolean;
begin
  id:=Index_feu(Adr);
  NfeuxDir:=feux[id].aspect-10;
  i:=1;   // i=1 position éteinte du feu ; pour les autres valeurs de i : nombre de feux allumés
  repeat
    NAig:=length(feux[id].AigDirection[i])-1;
    if i=1 then positionok:=false else positionok:=true;
    for j:=1 to Naig do
    begin
      // vérifier la position déclarée des aiguillages pour chaque feu
      AdrAigFeu:=feux[id].AigDirection[i][j].Adresse;
      PosAigFeu:=feux[id].AigDirection[i][j].posAig;
      position:=aiguillage[index_aig(AdrAigFeu)].position;
      //
      if i=1 then positionok:=((position=const_droit) and (posAigFeu='D')) or ((position<>const_droit) and (posAigFeu='S')) or positionok;
      if i>1 then positionok:=((position=const_droit) and (posAigFeu='D')) or ((position<>const_droit) and (posAigFeu='S')) and positionok;
    end;
    inc(i);
  until (i>NFeuxDir+1) or positionok;

  if positionok then
  begin
    dec(i,2);   // i correspond au nombre de feux à allumer
    pilote_direction(Adr,i);
  end;                 

end;

// renvoie vrai si une mémoire de zone est occupée du signal courant au signal suivant
// adresse=adresse du signal
function test_memoire_zones(adresse : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,Etat,AdrFeu,i,j,PresTrain01,PrecInitial,
  N_Det : integer;
  TypePrec,TypeActuel : TEquipement;
  Pres_train,sort : boolean;
  s : string;
begin
  if NivDebug>=1 then AfficheDebug('Proc test_memoire_zones('+intToSTR(adresse)+') au signal suivant ',clyellow);
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
    N_Det:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test feu '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      prec:=feux[i].Adr_det1;
      actuel:=feux[i].Adr_el_suiv1;
      TypeActuel:=feux[i].Btype_suiv1;
    end;  //détecteur sur le signal courant
    if (ife=2) then
    begin
      prec:=feux[i].Adr_det2;
      actuel:=feux[i].Adr_el_suiv2;
      TypeActuel:=feux[i].Btype_suiv2;
    end;  // détecteur sur le signal courant
    if (ife=3) then
    begin
      prec:=feux[i].Adr_det3;
      actuel:=feux[i].Adr_el_suiv3;
      TypeActuel:=feux[i].Btype_suiv3;
    end;  // détecteur sur le signal courant
    if (ife=4) then
    begin
      prec:=feux[i].Adr_det4;
      actuel:=feux[i].Adr_el_suiv4;
      TypeActuel:=feux[i].Btype_suiv4;
    end;  // détecteur sur le signal courant

    TypePrec:=det;
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
      if (j=1) and (Typeactuel=det) then // si détecteur
      begin
        Pres_train:=MemZone[Prec,actuel];
        if Pres_Train and (NivDebug=3) then Affiche('Présence train de '+intToSTR(prec)+' à '+intToSTR(actuel),clyellow);
      end
      else
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          if Typegen=det then inc(N_Det);
          prec:=actuel;TypePrec:=TypeActuel;
          actuel:=AdrSuiv;TypeActuel:=typeGen;
          if AdrSuiv>9990 then
          begin
            test_memoire_zones:=false;exit;
          end;

         end;

      if NivDebug=3 then AfficheDebug('132 - suivant='+IntToSTR(adrsuiv)+'/'+IntToSTR(BtypeToNUM(TypeGen)),clYellow);
      if actuel=0 then
      begin
        // si c'est un buttoir
        test_memoire_zones:=false;
        if NivDebug=3 then AfficheDebug('sortie car buttoir',clyellow);
        exit;
      end;
       // si le suivant est un détecteur ; contrôler mémoire de zone et comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=det) then  // détecteur
      begin
        if (NivDebug>0) and MemZone[PrecInitial][actuel] then AfficheDebug('Présence train de '+intToSTR(PrecInitial)+' à '+intToSTR(actuel),clyellow);

        Pres_train:=MemZone[PrecInitial][actuel] or Pres_train; // mémoire de zone
        if Pres_Train then PresTrain01:=1 else PresTrain01:=0;
        if NivDebug=3 then AfficheDebug('de '+IntToSTR(PrecInitial)+' à '+intToSTR(actuel)+'='+IntToSTR(PresTrain01),clyellow);
        precInitial:=actuel; // pour préparer le suivant

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
            s:='Trouvé feu '+IntToSTR(AdrFeu);
            if (NivDebug>0) And Pres_Train then AfficheDebug(s+' et mémoire de zone à 1',clyellow);
            if (NivDebug>0) And (not(Pres_Train)) then AfficheDebug(s+' et sortie proced:Mémoire de zone à 0',clyellow);
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
      sort:=(j=10) or (AdrFeu<>0) or (N_Det>=Nb_det_dist);     
    until (sort);  // on arrete jusqu'à trouver un signal ou si on va trop loin (10 itérations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) and (Etat=0) then AfficheDebug('Pas trouvé de signal suivant au '+intToSTR(adresse),clyellow);
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
    trouve_index_det_chrono:=0;
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
// Résultat:
// si >=9996 : pas de route
// si 10 : ok route trouvée
function test_route_valide(det1,det2,det3 : integer) : integer;
var det_suiv,resultat : integer;
begin
  if TraceListe then AfficheDebug('test route valide '+IntToSTR(det1)+' '+IntToSTR(det2)+' vers '+IntToSTR(det3)+' ',clyellow);
  det_suiv:=detecteur_suivant_el(det1,det,det2,det,1);
  if det_suiv=det3 then begin test_route_valide:=10;exit;end;

  test_route_valide:=9999;
  exit;
  
  if (det_suiv>=9996) or (det3<>det_suiv) then begin resultat:=0; NivDebug:=0;end;
  // test sens inverse....
  if resultat=0 then
  begin
    test_route_valide:=0;exit;
    // si manipulation proche aiguillage
    det_suiv:=detecteur_suivant_el(det3,det,det2,det,1);
    if (det_suiv>=9996) or (det1<>det_suiv) then begin test_route_valide:=0; NivDebug:=0;exit;end;
  end;
  test_route_valide:=10 ;
end;


// présence train 3 détecteurs avant le feu
function PresTrainPrec(AdrFeu : integer) : boolean;
var PresTrain : boolean;
    j,i,Det_initial,Adr_El_Suiv,DetPrec1,DetPrec2,DetPrec3,DetPrec4 : integer;
    Btype_el_suivant : TEquipement;
begin
  If NivDebug=3 then AfficheDebug('Proc PresTrainPrec('+intToSTR(AdrFeu)+') ---------------',clOrange); 
  i:=index_feu(Adrfeu);
  if i=0 then 
  begin
    Affiche('Erreur 602 - feu '+IntToSTR(adrFeu)+' non trouvé',clred);
    if NivDebug=3 then AfficheDebug('Erreur 602 - feu '+IntToSTR(adrFeu)+' non trouvé',clred); 
    PresTrainPrec:=false;
    exit;
  end;
  
  // **** un feu peut être associé à 4 détecteurs (pour 4 voies convergentes) *****
  // il faut donc explorer les 4 détecteurs probables
  PresTrain:=FALSE;
  j:=1;
 
  repeat
    if NivDebug=3 then afficheDebug('Séquence '+IntToSTR(j)+' de recherche des 4 détecteurs précédents-----',clYellow);
    if (j=1) then
    begin
      det_initial:=feux[i].Adr_det1;
      Adr_El_Suiv:=feux[i].Adr_el_suiv1;
      Btype_el_suivant:=feux[i].Btype_suiv1;
    end;                                       
    if (j=2) then
    begin
      det_initial:=feux[i].Adr_det2;
      Adr_El_Suiv:=feux[i].Adr_el_suiv2;
      Btype_el_suivant:=feux[i].Btype_suiv2;
    end;
    if (j=3) then
    begin
      det_initial:=feux[i].Adr_det3;
      Adr_El_Suiv:=feux[i].Adr_el_suiv3;
      Btype_el_suivant:=feux[i].Btype_suiv3;
    end;
    if (j=4) then
    begin
      det_initial:=feux[i].Adr_det4;
      Adr_El_Suiv:=feux[i].Adr_el_suiv4;
      Btype_el_suivant:=feux[i].Btype_suiv4;
    end;
    if (det_initial<>0) then
    begin                     
      DetPrec1:=detecteur_suivant(Adr_El_Suiv,Btype_el_suivant,det_initial,det,2); // 2= algo2 = arret sur aiguillage en talon mal positionné
      if nivdebug=3 then afficheDebug('detPrec1='+intToSTR(DetPrec1),clYellow);
      if DetPrec1<1024 then // route bloquée par aiguillage mal positionné
      begin             
        if detPrec1<>0 then DetPrec2:=detecteur_suivant_El(det_initial,det,DetPrec1,det,2) else DetPrec2:=0;
        if nivdebug=3 then afficheDebug('detPrec2='+intToSTR(DetPrec2),clYellow);
        if DetPrec2<1024 then
        begin
          if detPrec2<>0 then DetPrec3:=detecteur_suivant_El(DetPrec1,det,DetPrec2,det,2) else DetPrec3:=0;
          if nivdebug=3 then afficheDebug('detPrec3='+intToSTR(DetPrec3),clYellow);
          if DetPrec3<1024 then
          begin
            if detPrec3<>0 then DetPrec4:=detecteur_suivant_El(DetPrec2,det,DetPrec3,det,2) else DetPrec4:=0;
            if nivdebug=3 then afficheDebug('detPrec4='+intToSTR(DetPrec4),clYellow);
            if DetPrec4<1024 then
            begin
              if AffSignal or (NivDebug>=2) then AfficheDebug('Les détecteurs précédents au feu '+IntToSTR(Adrfeu)+' sont:'+intToSTR(Det_initial)+' '+intToSTR(DetPrec1)+' '+intToSTR(DetPrec2)+' '+intToSTR(DetPrec3)+' '+intToSTR(DetPrec4),clyellow);
              PresTrain:=MemZone[DetPrec4,detPrec3] or
              MemZone[DetPrec3,detPrec2] or MemZone[DetPrec2,detPrec1] or MemZone[DetPrec1,Det_initial] or presTrain ;
              if AffSignal or (NivDebug=3) then
              begin
                if MemZone[DetPrec4,detPrec3] then AfficheDebug('0.présence train '+IntToSTR(DetPrec4)+' '+IntToSTR(detPrec3),clyellow);
                if MemZone[DetPrec3,detPrec2] then AfficheDebug('1.présence train '+IntToSTR(DetPrec3)+' '+IntToSTR(detPrec2),clyellow);
                if MemZone[DetPrec2,detPrec1] then AfficheDebug('2.présence train '+IntToSTR(DetPrec2)+' '+IntToSTR(detPrec1),clyellow);
                if MemZone[DetPrec1,det_initial] then AfficheDebug('3.présence train '+IntToSTR(DetPrec1)+' '+IntToSTR(det_Initial),clyellow);
                if PresTrain then AfficheDebug('présence train',clyellow) else afficheDebug('abscence train',clyellow);
              end;
            end;
            //if AffSignal then AfficheDebug('MemZone'+intToSTR(DetPrec3)+' '+IntToSTR(detPrec2) = '+MemZone[DetPrec3,detPrec2]
          end;
        end;
      end;
    end;
    inc(j);
  until (j>=5);
  if AffSignal or (NivDebug=3) then
  begin
    if presTrain Then afficheDebug('présence train feu '+intToSTR(AdrFeu),clorange)
    else AfficheDebug('Absence train feu '+intToSTR(AdrFeu),clorange);
  end;
  PresTrainPrec:=presTrain;
end;


// mise à jour de l'état d'un feu en fontion de son environnement et affiche le feu
procedure Maj_Feu(Adrfeu : integer);
var Adr_det,etat,Aig,Adr_El_Suiv,
    modele,index : integer ;
    PresTrain,Aff_semaphore,car : boolean;
    code,combine : word;
    Btype_el_suivant : TEquipement;
    s : string;
begin
  

  if signalDebug=AdrFeu then AffSignal:=true;
  if AffSignal then 
  begin
    s:='Traitement du feu '+intToSTR(Adrfeu)+'------------------------------------';
    AfficheDebug(s,clOrange);
  end;  
  index:=index_feu(Adrfeu);
  if AdrFeu<>0 then
  begin
    modele:=Feux[index].aspect;

    Adr_det:=Feux[index].Adr_det1;  // détecteur sur le signal
    Adr_El_Suiv:=Feux[index].Adr_el_suiv1; // adresse élément suivant au feu
    Btype_el_suivant:=Feux[index].Btype_suiv1;
                       
    // signal directionnel ?
    if (modele>10) then
    begin
      //Affiche('Signal directionnel '+IntToSTR(AdrFeu),clyellow);
      Signal_direction(AdrFeu);
      exit;
    end;

    // signal non directionnel       
    etat:=etat_signal_suivant(AdrFeu,1) ;  // état du signal suivant + adresse du signal suivant dans Signal_Suivant
    if AffSignal then
    begin
      code_to_aspect(etat,code,combine);
      s:='Etat_signal_suivant ('+intToSTR(AdresseFeuSuivant)+') est ';
      s:=s+' à '+etatSign[code];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      AfficheDebug(s,clyellow);
    end;
    // signaux traités spécifiquement
    {
    if (AdrFeu=201) then
    begin
      if ((aiguillage[index_aig(28].position<>const_droit) and (aiguillage[index_aig(29].position<>const_droit) and
         (aiguillage[index_aig(31].position=2)) then // attention spécial
         Maj_Etat_Signal(AdrFeu,blanc) else Maj_Etat_Signal(AdrFeu,violet);
      envoi_LEB(AdrFeu);
      exit;
    end;
    if (AdrFeu=217) then
    begin
       if ((aiguillage[index_aig(24].position<>const_droit) and (aiguillage[index_aig(26].position<>const_droit)) then
           Maj_Etat_Signal(AdrFeu,blanc) else Maj_Etat_Signal(AdrFeu,violet);
       envoi_LEB(AdrFeu);
       exit;
    end;
    }

    // signal à 2 feux = carré violet+blanc
    if (Feux[index].aspect=2) then //or (feux[i].check<>nil) then // si carré violet
    begin
      //AfficheDebug('Feux à 2 feux',CLOrange);
      // si aiguillage après signal mal positionnées
      if carre_signal(AdrFeu) then
      begin
        Maj_Etat_Signal(AdrFeu,violet);
        Envoi_signauxCplx;
        exit;
      end
      else
      begin
        if test_memoire_zones(AdrFeu) then Maj_Etat_Signal(AdrFeu,violet)  // test si présence train après signal
        else Maj_Etat_Signal(AdrFeu,blanc);
        
        Envoi_signauxCplx;
        exit;
      end;
    end;

    //if AffSignal then AfficheDebug('Debut du traitement général',clYellow);
    // traitement des feux >3 feux différents de violet (cas général)
    if (Feux[index].aspect>=3) and (EtatSignalCplx[AdrFeu]<>violet_F) then
    begin
      PresTrain:=false;
      // détecteurs précédent le feu , pour déterminer si leurs mémoires de zones sont à 1 pour libérer le carré
      if (Feux[index].VerrouCarre) and (Feux[index].aspect>=4) then presTrain:=PresTrainPrec(AdrFeu);
      
      if AffSignal then afficheDebug('Fin de la recherche des 4 détecteurs précédents-----',clOrange);
      // si le signal peut afficher un carré et les aiguillages après le signal sont mal positionnées ou que pas présence train avant signal et signal
      // verrouillable au carré, afficher un carré
      car:=carre_signal(AdrFeu);
      // conditions supplémentaires de carré en fonction des aiguillages décrits
      car:=cond_carre(AdrFeu) or car;    
      if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionnées',clYellow);
      if (NivDebug>=1) and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionnées',clYellow);
      if (Feux[index].aspect>=4) and ( (not(PresTrain) and Feux[index].VerrouCarre) or car) then Maj_Etat_Signal(AdrFeu,carre)
      else
      begin
        // si on quitte le détecteur on affiche un sémaphore :  attention tester le sens de circulation
        // pour ne pas passer au rouge un feu à contresens.
        // trouver la mémoire de zone MemZone[Adr_det,?] qui a déclenché le feu rouge
        //if adrFeu=197 then NivDebug:=3;
        if AffSignal then AfficheDebug('test du sémaphore',clYellow);
        Aff_semaphore:=test_memoire_zones(AdrFeu);  // test si présence train après signal
        //Nivdebug:=0;
        if Aff_Semaphore then
        begin
          if AffSignal then AfficheDebug('Présence train après signal'+intToSTR(AdrFeu)+' -> sémaphore ou carré',clYellow);
          if testBit(EtatSignalCplx[Adrfeu],carre)=FALSE then Maj_Etat_Signal(AdrFeu,semaphore);
        end
        else
        begin
          Aig:=Aiguille_deviee(Adrfeu);
          // si aiguille locale déviée
          if (aig<>0) and (feux[index].aspect>=9) then // si le signal peut afficher un rappel et aiguille déviée
          begin
            if AffSignal then AfficheDebug('Aiguille '+intToSTR(AdrFeu)+' déviée',clYellow);
            EtatSignalCplx[AdrFeu]:=0;
            if (aiguillage[index].vitesse=30) or (aiguillage[index].vitesse=0) then Maj_Etat_Signal(AdrFeu,rappel_30);
            if aiguillage[index].vitesse=60 then Maj_Etat_Signal(AdrFeu,rappel_60);

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
            // effacer la signbalisation combinée
            EtatSignalCplx[adrFeu]:=EtatSignalCplx[adrFeu] and not($3c00);
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
                  else  
                    begin
                      if feux[index].check<>nil then
                      begin
                        if feux[index].check.Checked then Maj_Etat_Signal(AdrFeu,blanc);
                      end
                      else
                      Maj_Etat_Signal(AdrFeu,vert);
                    end;
            end;
          end;
        end;
      end;
    end;
  end;
  envoi_signauxCplx;
  if signalDebug=AdrFeu then AffSignal:=false;
end;

Procedure Maj_feux;
var i : integer;
begin
  //Affiche('MAJ FEUX',clOrange);
  if not(maj_feux_cours) then
  begin
    Maj_feux_cours:=TRUE;
    for i:=1 to NbreFeux do
    begin
      Maj_feu(Feux[i].Adresse);
    end;
    Maj_feux_cours:=FALSE;
  end;  
end;


procedure rafraichit;
begin
  //Affiche('Procédure rafraichit',cyan);
  begin
    Maj_feux;
  end
end;

// trouve l'index d'un détecteur dans une branche depuis la fin de la branche
// si pas trouvé, renvoie 0
function index_detecteur_fin(detecteur,Num_branche : integer) : integer;
var dernier,i,j : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        if BrancheN[Num_Branche,i].Btype=det then   // cherche un détecteur
        begin
          j:=BrancheN[Num_Branche,i].adresse;
          trouve:=detecteur=j;
        end;
        if not(trouve) then dec(i);
      until trouve or (j=0)
    end;
begin
  // déterminer la fin de la branche
  i:=1;
  repeat
     inc(i);
  until (BrancheN[Num_Branche,i].adresse=0) and (BrancheN[Num_Branche,i].btype=rien);
  dernier:=i-1;
  // Affiche('dernier'+intToSTR(dernier),clwhite);
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

// trouve si le détecteur adr est contigu à un buttoir
function buttoir_adjacent(adr : integer) : boolean;
begin
  trouve_element(adr,det,1); // branche_trouve  IndexBranche_trouve
  if Branche_trouve=0 then begin buttoir_adjacent:=false;exit;end;
  buttoir_adjacent:=( (BrancheN[branche_trouve,IndexBranche_trouve+1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve+1].BType=buttoir) or 
                      (BrancheN[branche_trouve,IndexBranche_trouve-1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve-1].BType=buttoir) )
  
end;

// calcul des zones depuis le tableau des fronts descendants des évènements détecteurs
// transmis dans le tableau Event_det
procedure calcul_zones;
var AdrFeu,AdrDetFeu,Nbre,i,resultat,det1,det2,det3,AdrSuiv,AdrPrec : integer ;
    creer_tableau : boolean;
    TypeSuiv : tEquipement;
    s : string;
begin
  creer_tableau:=false;
  det3:=event_det[N_event_det]; // c'est le nouveau détecteur
  if det3=0 then exit; // pas de nouveau détecteur
  FormDebug.MemoEvtDet.lines.add('Le nouveau détecteur est '+IntToSTR(det3)) ;
  if TraceListe then AfficheDebug('Le nouveau détecteur est '+IntToSTR(det3),clyellow) ;

  // évaluer d'abord la route du nouveau détecteur sur tous les tableau déja rempli de 2 éléments
  for i:=1 to N_trains do
  begin
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'éléments du tableau courant exploré
    if Nbre=2 then
    begin
      if TraceListe or (NivDebug=3) then AfficheDebug('traitement Train n°'+intToSTR(i)+' 2 détecteurs',clyellow);
      det1:=event_det_train[i].det[1];
      det2:=event_det_train[i].det[2];
      resultat:=test_route_valide(det1,det2,det3);
      if resultat=10 then
      begin
        AdrSuiv:=detecteur_suivant_el(det2,det,det3,det,1); // ici on cherche le suivant à det2 det3, algo=1
        if (Adrsuiv>=9996) then
        begin
          Affiche('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' à '+intToSTR(det3),clRed);
          if NivDebug=3 then AfficheDebug('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' à '+intToSTR(det3),clRed);
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
            RE_ColorLine(FormDebug.RichEdit,lines.count-1,CouleurTrain[ ((i - 1) mod NbCouleurTrain) +1] );
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
          if avecTCO then
          begin
            zone_TCO(det2,det3,0);    // désactivation
            zone_TCO(det3,AdrSuiv,1); // activation
          end;
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
      Det_Adj(det1);  // renvoie les adresses des détecteurs adjacents au détecteur "det1" résultat dans adj1 et adj2
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

  // Nombre d'éléments à 0 : ici c'est un nouveau train donc créer un train, donc un tableau
  if N_Trains>=Max_Trains then
  begin
    Affiche('Erreur nombre de train maximal atteint',clRed);
  end;
  Inc(N_trains);

  // vérifier si le détecteur du nouveau train est associé à un feu vers un buttoir
  for i:=1 to NbreFeux do
  begin
    AdrFeu:=Feux[i].Adresse;
    AdrDetfeu:=Feux[i].Adr_Det1;
    if (AdrDetFeu=Det3) and (feux[i].aspect<10) then
    begin
      AdrSuiv:=Feux[i].Adr_el_suiv1;
      TypeSuiv:=Feux[i].Btype_suiv1;
      AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetFeu,det,1) ; // détecteur précédent le feu ; algo 1
      if AdrPrec=0 then
      begin
        if TraceListe then Affiche('FD - Le feu '+IntToSTR(AdrFeu)+' est précédé d''un buttoir',clyellow);
        MemZone[0,AdrDetFeu]:=false;
        //NivDebug:=3;
         //AffSignal:=true;
         maj_feu(AdrFeu);
      end;
    end;
  end;

  if TraceListe then AfficheDebug('Création Train n°'+intToSTR(N_trains),clyellow);
  Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);

  // si on démarre d'un buttoir
  if buttoir_adjacent(det3) then
  begin
    if TraceListe then AfficheDebug('detection démarrage depuis détecteur '+IntToSTR(det3)+' buttoir',clyellow);
    event_det_train[N_trains].det[1]:=0;
    event_det_train[N_trains].det[2]:=det3;
    event_det_train[N_trains].NbEl:=2;
    with FormDebug.MemoEvtDet do
    begin
      lines.add('Nouveau Tampon train '+intToStr(N_Trains)+'--------');
      lines.add(intToSTR(event_det_train[N_Trains].det[1]));
      lines.add(intToSTR(event_det_train[N_Trains].det[2]));
    end;  
  end
  else
  begin
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
end;

// demande l'état d'un accessoire à la centrale. Le résultat sera réceptionné sur évènement des informations
// de rétrosignalisation.
procedure demande_info_acc(adresse : integer);
var s : string;
    n : integer;
begin
  // uniquement si connecté directement à la centrale
  if portCommOuvert or parSocketLenz then
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
  if portCommOuvert or parSocketLenz then
  begin
    Affiche('Demande état des aiguillages',ClYellow);
    for i:=1 to maxaiguillage do
    begin
      demande_info_acc(i);
      Affiche('Demande état aiguillage '+intToSTR(i),clLime);
    end;
  end;  
end;


// traitement des évènements actionneurs
procedure Event_act(adr,etat : integer;train : string);
var i,v,va,etatAct,Af,Ao,Access,sortie : integer;
    s : string;
    presTrain_PN : boolean;
    Ts : TAccessoire;
begin
  // vérifier si l'actionneur en évènement a été déclaré pour réagir
  if AffActionneur then Affiche('Actionneur '+intToSTR(Adr)+'='+intToSTR(etat),clyellow);
    
  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].train;
    etatAct:=Tablo_actionneur[i].etat ;
    // actionneur pour fonction train
    if (Tablo_actionneur[i].actionneur=adr) and (Tablo_actionneur[i].fonction<>0) and ((s=train) or (s='X')) and (etatAct=etat) then
    begin
      Affiche('Actionneur '+intToSTR(adr)+' Train='+train+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':'+intToSTR(etat),clyellow);
      // exécutione la fonction F vers CDM
      envoie_fonction_CDM(Tablo_actionneur[i].fonction,etat,train);
      TempoAct:=tablo_actionneur[i].Tempo div 100;
      RangActCours:=i;
    end;
    // actionneur pour accessoire
    if (Tablo_actionneur[i].actionneur=adr) and (Tablo_actionneur[i].accessoire<>0) and ((s=train) or (s='X')) and (etatAct=etat) then
    begin
      access:=Tablo_actionneur[i].accessoire;
      sortie:=Tablo_actionneur[i].sortie;
      
      Affiche('Actionneur '+intToSTR(adr)+' Train='+train+' Accessoire '+IntToSTR(access)+':'+intToSTR(sortie),clyellow);
      // exécution la fonction accessoire vers CDM
      if Tablo_actionneur[i].RAZ then Ts:=aigP else Ts:=Feu;
      pilote_acc(access,sortie,Ts); // sans RAZ
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
          pilote_acc(Tablo_PN[i].AdresseOuvre,Tablo_PN[i].CommandeOuvre,AigP);
        end;
      end;

      if (aF=adr) and (etat=1) then  // actionneur de fermeture
      begin
        Tablo_PN[i].voie[v].PresTrain:=true;
        Affiche('Fermeture PN'+IntToSTR(i)+' (train voie '+IntToSTR(v)+')',clOrange);
        pilote_acc(Tablo_PN[i].AdresseFerme,Tablo_PN[i].CommandeFerme,AigP);
      end;
    end;
  end;
end;

Procedure affiche_memoire;
var s: string;
begin
  s:='Mémoire évènements '+IntToSTR( 100*N_Event_tick div Max_Event_det_tick)+' %';
  Formprinc.statictext.caption:=s;
end;

procedure evalue;
begin
  if not(configNulle) then
  begin
    //if CDM_connecte // and (length(recuCDM)<1000) then
    Maj_feux;  // on ne traite pas les calculs si CDM en envoie plusieurs
  end;
end;  

// traitement sur les évènements détecteurs 
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
var i,AdrSuiv,AdrFeu,AdrDetfeu,index,Etat01,AdrPrec : integer;
    typeSuiv : tequipement;
    s : string;
begin
  if Etat then Etat01:=1 else Etat01:=0;
 
  // vérifier si l'état du détecteur est déja stocké, car on peut reçevoir plusieurs évènements pour le même détecteur dans le même état
  // on reçoit un doublon dans deux index consécutifs.
 (*
  if N_Event_tick>=1 then
  begin
    if (event_det_tick[N_event_tick].etat=etat01) and (event_det_tick[N_event_tick].detecteur=Adresse) then 
    begin
      //Affiche(IntToSTR(Adresse)+' déja stocké',clorange);
      exit;   // déja stocké
    end; 
  end;
  *)
  if Traceliste then AfficheDebug('--------------------- détecteur '+intToSTR(Adresse)+' à '+intToSTR(etat01)+'-----------------------------',clOrange);
  if AffAigDet then 
  begin
    //s:='Evt Det '+intToSTR(adresse)+'='+intToSTR(etat01);
    s:='Tick='+IntToSTR(tick)+' Evt Det='+IntToSTR(adresse)+'='+intToSTR(etat01);
    Affiche(s,clyellow);
    if not(TraceListe) then AfficheDebug(s,clyellow);
  end;  
 
  ancien_detecteur[Adresse]:=detecteur[Adresse].etat;
  detecteur[Adresse].etat:=etat;
  detecteur[Adresse].train:=train;
  detecteur_chgt:=Adresse;

  // stocke les changements d'état des détecteurs dans le tableau chronologique
  if (N_Event_tick>=Max_Event_det_tick) then
  begin
    N_Event_tick:=0;
    Affiche('Raz Evts détecteurs',clLime);
  end;
  inc(N_Event_tick);
  event_det_tick[N_event_tick].tick:=tick;
  event_det_tick[N_event_tick].detecteur:=Adresse;
  event_det_tick[N_event_tick].etat:=etat01;
  if (n_Event_tick mod 10) =0 then affiche_memoire;
  // Affiche('stockage de '+intToSTR(N_event_tick)+' '+IntToSTR(Adresse)+' à '+intToSTR(etat01),clyellow);


  // détection front montant
  if not(ancien_detecteur[Adresse]) and detecteur[Adresse].etat then
  begin
    // explorer les feux pour déverrouiller les feux dont le trajets viennent d'un buttoir pour changer le feu qd un train se présente
    // sur le détecteur
    for i:=1 to NbreFeux do
    begin
      AdrFeu:=Feux[i].Adresse;
      AdrDetfeu:=Feux[i].Adr_Det1;
      if (AdrDetFeu=Adresse) and (feux[i].aspect<10) then
      begin
        AdrSuiv:=Feux[i].Adr_el_suiv1;
        TypeSuiv:=Feux[i].Btype_suiv1;
        if AffSignal then AfficheDebug('Pour Feu '+intToSTR(AdrFeu)+' detecteursuivant('+intToSTR(AdrSuiv)+','+IntToSTR(BTypeToNum(typeSuiv))+','+intToSTR(AdrDetFeu)+',1)',clyellow);
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetFeu,det,1) ; // détecteur précédent le feu, algo 1
        if AdrPrec=0 then
        begin
          If traceListe then AfficheDebug('Le feu '+IntToSTR(AdrFeu)+' est précédé d''un buttoir',clyellow);
          MemZone[0,AdrDetFeu]:=true;
          maj_feu(AdrFeu);
        end;
      end;
    end;
  end;

  // détection fronts descendants
  if ancien_detecteur[Adresse] and not(detecteur[Adresse].etat) and (N_Event_det<Max_event_det) then
  begin
    // si le FD du détecteur a déjà été stocké à l'index précédent ne pas en tenir compte
    //if event_det[N_event_det]<>Adresse then
    begin
      if AffFD then AfficheDebug('index='+intToSTR(N_event_tick)+' FD '+intToSTR(Adresse),clyellow);
      inc(N_event_det);
      event_det[N_event_det]:=Adresse;
      // vérification de la connaissance de la position de tous les aiguillages au premier évènement FD détecteur
      if not(PremierFD) then
      begin
        for i:=1 to MaxAiguillage do
        begin
          index:=index_aig(i);
          if aiguillage[index].modele<>rien then
          begin
            if aiguillage[index].position=const_inconnu then
            begin
              Affiche('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',clred);
              AfficheDebug('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',clred);
            end;
          end;
        end;
      end;
      premierFD:=True;
      calcul_zones;
    end;
  end;

  if (N_event_det>=Max_event_det) then
  begin
    Affiche('Débordement d''évènements FD - Raz tampon',clred);
    N_event_det:=0;
    FormDebug.MemoEvtDet.lines.add('Raz sur débordement');
  end;

  // attention à partir de cette section le code est susceptible de ne pas être exécuté??

  // Mettre à jour le TCO
  if AvecTCO then
  begin
    formTCO.Maj_TCO(Adresse);
  end;
end;

// évènement d'aiguillage (accessoire)
// pos = const_droit=2 ou const_devie=1
procedure Event_Aig(adresse,pos : integer);
var s: string;
    faire_event,inv : boolean;
    prov,i,index : integer;
begin
  // vérifier que l'évènement accessoire vient bien d'un aiguillage et pas d'un feu qu'on pilote (et que cdm renvoie)
  index:=index_aig(adresse);   
  if index=0 then exit; // non ce n'est pas un aiguillage, on sort

  // si l'aiguillage est inversé dans CDM et qu'on est en mode autonome, inverser sa position
  inv:=false;
  if (aiguillage[index].inversionCDM=1) and (portCommOuvert or parSocketLenz) then
  begin                                        
    prov:=pos;
    inv:=true;
    if prov=const_droit then pos:=const_devie else pos:=const_droit;
  end;

  // ne pas faire l'évaluation si l'ancien état de l'aiguillage est indéterminée (9)
  // car le RUN vient de démarrer
  faire_event:=aiguillage[index].position<>9;
  aiguillage[index].position:=pos;    // stockage de la nouvelle position de l'aiguillage

  // ------------- stockage évènement aiguillage dans tampon event_det_tick -------------------------
  if (N_Event_tick>=Max_Event_det_tick) then
  begin
    N_Event_tick:=0;
    Affiche('Raz Evts ',clLime);
  end;
  s:='Tick='+IntToSTR(tick)+' Evt Aig '+intToSTR(adresse)+'='+intToSTR(pos);
  case pos of 
    const_droit : s:=s+' droit';
    const_devie : s:=s+' dévié';
    const_inconnu : s:=s+' inconnu';
  end;  
  if inv then s:=s+' INV';
  if AffAigDet then
  begin
    Affiche(s,clyellow);
    AfficheDebug(s,clyellow);
  end;
  FormDebug.MemoEvtDet.lines.add(s) ;
  if (n_Event_tick mod 10) =0 then affiche_memoire;
  inc(N_Event_tick);
  event_det_tick[N_event_tick].tick:=tick;
  event_det_tick[N_event_tick].aiguillage:=adresse;
  event_det_tick[N_event_tick].etat:=pos;

  // Mettre à jour le TCO
  if AvecTCO then formTCO.Maj_TCO(Adresse);

  // l'évaluation des routes est à faire selon conditions
  if faire_event then evalue;
end;

// pilote une sortie à 0  dont l'adresse est à octet
procedure Pilote_acc0_X(adresse : integer;octet : byte);
var groupe : integer ;
    fonction : byte;
    s : string;
begin
  if debug_dec_sig then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet),clorange);
  groupe:=(adresse-1) div 4;
  fonction:=((adresse-1) mod 4)*2 + (octet-1);
  s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
end;

// pilotage d'un accessoire (décodeur d'aiguillage, de signal)
// octet = 1 (dévié) ou 2 (droit)
// la sortie "octet" est mise à 1 puis à 0
// acc = aig ou feu
procedure pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire);
var  groupe,temps,index : integer ;
     fonction : byte;
     s : string;
label mise0;
begin
  //Affiche(IntToSTR(adresse)+' '+intToSTr(octet),clYellow);
  
  index:=index_aig(adresse);

  // test si pilotage aiguillage inversé
  if (acc=aigP) and (aiguillage[index].inversionCDM=1) then
  begin
   if octet=1 then octet:=2 else octet:=1;
  end;

  // pilotage par CDM rail -----------------
  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet),clorange);
    s:=chaine_CDM_Acc(adresse,octet);
    envoi_CDM(s);
    if (acc=feu) and not(Raz_Acc_signaux) then exit;
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
    sleep(50);
    s:=chaine_CDM_Acc(adresse,0);
    envoi_CDM(s);
    exit;
  end;

  // pilotage par USB ou par éthernet de la centrale ------------
  if (hors_tension2=false) and (portCommOuvert or parSocketLenz) then
  begin
    if (octet=0) or (octet>2) then exit;

    groupe:=(adresse-1) div 4;
    fonction:=((adresse-1) mod 4)*2 + (octet-1);
    // pilotage à 1
    s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
    s:=checksum(s);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet),clorange);
    envoi(s);     // envoi de la trame et attente Ack

    // si l'accessoire est un feu et sans raz des signaux, sortir
    if (acc=feu) and not(Raz_Acc_signaux) then exit;

    // si aiguillage, faire une temporisation
    //if (index_feu(adresse)=0) or (Acc=aig) then
    if Acc=AigP then
    begin
      temps:=aiguillage[index].temps;if temps=0 then temps:=4;
      if portCommOuvert or parSocketLenz then tempo(temps);
    end;
    //sleep(50);

    // pilotage à 0 pour éteindre le pilotage de la bobine du relais
    s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
    s:=checksum(s);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
    envoi(s);     // envoi de la trame et attente Ack
    exit;
  end;

  // pas de centrale et pas CDM connecté: on change la position de l'aiguillage
  if acc=aigP then event_aig(adresse,octet);
end;


// le décodage de la rétro est appellée sur une réception d'une trame de la rétrosignalisation de la centrale.
// On déclenche ensuite les évènements détecteurs ou aiguillages.
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
      if detecteur[i].etat<>((valeur and $8) = $8) then  // si changement de l'état du détecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8,'');  // pas de train affecté sur le décodage de la rétrosignalisation
      end;

      i:=adresse*8+7;
      if detecteur[i].etat<>((valeur and $4) = $4) then  // si changement de l'état du détecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,'');
      end;

      i:=adresse*8+6;
      if detecteur[i].etat<>((valeur and $2) = $2) then  // si changement de l'état du détecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,'');
      end;

      i:=adresse*8+5;
      if detecteur[i].etat<>((valeur and $1) = $1) then  // si changement de l'état du détecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,''); 
      end;
    end;

    // état de l'aiguillage
    if bitsITT=$00 then // module d'aiguillages, N=1
    begin
      adraig:=((adresse * 4)+1 ); // *4 car N=1, c'est le "poids fort"
      if (valeur and $C)=$8 then
      begin      
        Event_Aig(adraig+3,const_droit);   
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+3)+'=2';AfficheDebug(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        Event_Aig(adraig+3,const_devie);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+3)+'=1';AfficheDebug(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        Event_Aig(adraig+2,const_droit);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+2)+'=2';AfficheDebug(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        Event_Aig(adraig+2,const_devie);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+2)+'=1';AfficheDebug(s,clYellow);end;
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
      if detecteur[i].etat<>((valeur and $8) = $8) then  // si changement de l'état du détecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8,''); 
      end;
      i:=adresse*8+3;
      if detecteur[i].etat<>((valeur and $4) = $4) then  // si changement de l'état du détecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,''); 
      end;

      i:=adresse*8+2;
      if detecteur[i].etat<>((valeur and $2) = $2) then  // si changement de l'état du détecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,''); 
      end;

      i:=adresse*8+1;
      if detecteur[i].etat<>((valeur and $1) = $1) then  // si changement de l'état du détecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,''); 
      end;

    end;
    if bitsITT=$00 then // module d'aiguillages
    begin
      adraig:=(adresse * 4)+1;
      if (valeur and $C)=$8 then
      begin
        Event_Aig(adraig+1,const_droit);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+1)+'=2';AfficheDebug(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        Event_Aig(adraig+1,const_devie);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+1)+'=1';AfficheDebug(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        Event_Aig(adraig,const_droit);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig)+'=2';AfficheDebug(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        Event_Aig(adraig,const_devie);
        if traceTrames then begin s:='accessoire '+intToSTR(adraig)+'=1';AfficheDebug(s,clYellow);end;
      end;
    end;
  end;
end;


// décodage d'une chaine simple de la rétrosignalisation de la centrale
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
    if traceTrames and (chaineINT[2]=#4) then AfficheDebug(msg,clYellow);
    if traceTrames and (chaineINT[2]<>#4) then AfficheDebug(msg,clRed);
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
var chaineInt: string;
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
// transforme une chaîne ascii 0A FF CA.. en chaine d'octets décimaux ascii = 10 255 ...
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
  Formprinc.ClientSocketCDM.close;
end;

{$J+}
// vérifie si version OS32 bits ou OS64 bits
function IsWow64Process: Boolean;
type
  TIsWow64Process=function(hProcess: THandle; var Wow64Process: Boolean): Boolean; stdcall;
var
  DLL: THandle;
  pIsWow64Process: TIsWow64Process;
const
  IsWow64: Boolean=False;
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

// initialisation de la comm USB
procedure connecte_USB;
var i,j : integer;
begin
    if NumPort<>0 then
    begin
      With Formprinc.MSCommUSBLenz do
      begin
        i:=pos(':',portCom);
        j:=pos(',',PortCom);
        j:=posEx(',',PortCom,j+1);
        j:=posEx(',',PortCom,j+1);
        j:=posEx(',',PortCom,j+1);

        confStCom:=copy(portCom,i+1,j-i-1);
        Settings:=ConfStCom;   // COMx:vitesse,n,8,1
        Affiche('Demande ouverture COM'+intToSTR(NumPort)+':'+ConfStCom+' protocole '+IntToSTR(protocole),CLYellow);
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
        Affiche('port COM'+intToSTR(NumPort)+' NON ouvert',clOrange)  ;
      end;
end;

Function GetWindowFromID(ProcessID : Cardinal): THandle;
Var TestID  : Cardinal;
    TestHandle : Thandle;
Begin
  Result:=0;
  TestHandle:=FindWindowEx(GetDesktopWindow,0,Nil,Nil);
  while TestHandle>0 do
    begin
      if GetParent(TestHandle)=0 then GetWindowThreadProcessId(TestHandle,@TestID);
      if TestID=ProcessID then
      begin
        Result:=TestHandle;
        exit;
      end;
      TestHandle:=GetWindow(TestHandle,GW_HWNDNEXT)
  end;
end;

// renvoie si un process EXE tourne. Renvoie le Handle du process dans CDMHd et l'Id du process dans ProcessID
// sExeName : Nom de l'EXE sans le chemin, et sans EXE }
function ProcessRunning(sExeName: String) : Boolean;
var hSnapShot : THandle;
    ProcessEntry32 : TProcessEntry32;   // pointeur sur la structure ProcessEntry32
    processID : DWord;
begin
  Result:=false;
  hSnapShot:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  Win32Check(hSnapShot<>INVALID_HANDLE_VALUE);

  sExeName:=LowerCase(sExeName);
  FillChar(ProcessEntry32,SizeOf(TProcessEntry32),#0);
  ProcessEntry32.dwSize:=SizeOf(TProcessEntry32);   // contient la structure de tous les process

  if (Process32First(hSnapShot,ProcessEntry32)) then
  repeat
    //Affiche(ProcessEntry32.szExeFile,ClYellow);
    if (Pos(sExeName,LowerCase(ProcessEntry32.szExeFile))=1) then
    begin
      processID:=ProcessEntry32.th32ProcessID;
      CDMhd:=GetWindowFromID(processID);
      Affiche('CDM rail processID='+IntToSTR(ProcessID)+' handle='+IntToSTR(CDMhd),clOrange);
      Result:=true;
      Break;
    end; 
  until (Process32Next(hSnapShot,ProcessEntry32)=false);
  CloseHandle(hSnapShot);
end; 

// préparation du tampon pour SendInput
procedure KeybdInput(VKey: Byte; Flags: DWORD);
begin
  SetLength(KeyInputs, Length(KeyInputs)+1);
  KeyInputs[high(KeyInputs)].Itype := INPUT_KEYBOARD;
  with KeyInputs[high(KeyInputs)].ki do
  begin
    wVk:=VKey;
    wScan:=MapVirtualKey(wVk,0);
    dwFlags:=Flags;
  end;
end;

// envoie des touches pour simuler un appui clavier
procedure SendKey(Wnd,VK : Cardinal; Ctrl,Alt,Shift : Boolean);
var MC,MA,MS : Boolean;
begin
  // Etats des touches spéciales 
  MC:=Hi(GetAsyncKeyState(VK_CONTROL))>127;
  MA:=Hi(GetAsyncKeyState(VK_MENU))>127;
  MS:=Hi(GetAsyncKeyState(VK_SHIFT))>127;

  // Simulation des touches de contrôle 
  if Ctrl<>MC then keybd_event(VK_CONTROL,0,Byte(MC)*KEYEVENTF_KEYUP,0);
  if Alt<>MA then keybd_event(VK_MENU,0,Byte(MA)*KEYEVENTF_KEYUP,0);
  if Shift<>MS then keybd_event(VK_SHIFT,0,Byte(MS)*KEYEVENTF_KEYUP,0);

  // Appui sur les touches
  keybd_event(VK,0,0,0);  
  keybd_event(VK,0,KEYEVENTF_KEYUP,0);

//  keybd_event(MapVirtualKeyA(VK,0),0,0,0);
//  keybd_event(MapVirtualKeyA(VK,0),0,KEYEVENTF_KEYUP,0);

  // Relâchement des touches si nécessaire
  if Ctrl<>MC then keybd_event(VK_CONTROL,0,Byte(Ctrl)*KEYEVENTF_KEYUP,0);
  if Alt<>MA then keybd_event(VK_MENU,0,Byte(Alt)*KEYEVENTF_KEYUP,0);
  if Shift<>MS then keybd_event(VK_SHIFT,0,Byte(Shift)*KEYEVENTF_KEYUP,0);
end;

// conversion d'une chaine standard en chaîne VK (virtual key) pour envoyer des évènements clavier
// 112=F1 .. 135=F20    136 à  143 rien    145 à 159 : spécifique ou non utilisé
// $A0 .. $B0 : contrôles curseur
// $BA : spécifique au pays 
// $6A à $6F * + espace  - . /   
// BB à BE  + - .   attention la description diffère
function convert_VK(LAY : string) : string;
var i : integer;
    s : string;
begin
  s:='';
  for i:=1 to Length(Lay) do
  begin
    case Lay[i] of
    '0' : s:=s+#96 ;
    '1' : s:=s+'a';
    '2' : s:=s+'b';
    '3' : s:=s+'c';
    '4' : s:=s+'d';    
    '5' : s:=s+'e';
    '6' : s:=s+'f';
    '7' : s:=s+'g';    
    '8' : s:=s+'h';
    '9' : s:=s+'i';
    '*' : s:=s+#$6a;
    '+' : s:=s+#$6b;
   // ' ' : s:=s+#$6c;
    '-' : s:=s+#$6d;
    '.' : s:=s+#$6e;
    '/' : s:=s+#$6f;
    '_' : s:=s+'{8}';
  //  '\' : s:=s+#$e2;
    'a'..'z' : s:=s+Upcase(lay[i]);
    ' ','A'..'Z',#8..#$D : s:=s+lay[i];
    else Affiche('Erreur de conversion VK : '+lay,clred);
    end;
  end;
  convert_VK:=s;
end;

// Lance et connecte CDM rail. en sortie si CDM est lancé Lance_CDM=true, 
function Lance_CDM : boolean;
var i : integer;
    s : string;
    cdm_lanceLoc : boolean;
begin
  s:='CDR';
  if (ProcessRunning(s)) then 
  begin 
    // CDM déja lancé;
    Lance_CDM:=true;
    if CDM_connecte then exit;
    deconnecte_USB;
    connecte_CDM;
    exit;
  end;

  Affiche('Lancement de CDM '+lay,clyellow);
  cdm_lanceLoc:=false;
  // lancement depuis le répertoire 32 bits d'un OS64
  if ShellExecute(Formprinc.Handle,'open',PChar('C:\Program Files (x86)\CDM-Rail\cdr.exe'),
                    Pchar('-f '+lay),  // paramètre
                    PChar('C:\Program Files (x86)\CDM-Rail\')  // répertoire
                    ,SW_SHOWNORMAL)>32 then 
                    begin
                      cdm_lanceLoc:=true;
                      //Affiche('lancé1',clyellow);
                    end;  

  if not(cdm_lanceLoc) then
  begin
    // si çà marche pas essayer depuis le répertoire de base sur un OS32
    Affiche('2eme lancement',clyellow);
    if ShellExecute(Formprinc.Handle,
                    'open',PChar('C:\Program Files\CDM-Rail\cdr.exe'),
                    Pchar('-f '+lay),  // paramètre
                    PChar('C:\Program Files\CDM-Rail\')  // répertoire
                    ,SW_SHOWNORMAL)<=32 then
    begin
      ShowMessage('répertoire CDM rail introuvable');
      lance_CDM:=false;exit;
    end;
    cdm_lanceLoc:=false;
  end;

  if cdm_lanceLoc then
  begin
    Formprinc.caption:=af+' - '+lay;
    // On a lancé CDM, déconnecter l'USB
    deconnecte_USB;
    Affiche('lance les fonctions automatiques de CDM',clyellow);
    Sleep(3000);
    ProcessRunning(s); // récupérer le handle de CDM
    SetForegroundWindow(CDMhd);
    Application.ProcessMessages;

    // démarre  le serveur IP ------------------------------------
    KeybdInput(VK_MENU,0);                 // enfonce Alt
    KeybdInput(Ord('C'),0);                // enfonce C
    KeybdInput(Ord('C'),KEYEVENTF_KEYUP);  // relache C

    KeybdInput(VK_MENU,KEYEVENTF_KEYUP);   // relache ALT

    KeybdInput(Ord('C'),0);
    KeybdInput(Ord('C'),KEYEVENTF_KEYUP);

    KeybdInput(VK_RETURN,0);
    KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
    KeybdInput(VK_RETURN,0);
    KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);

    i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  // la fenetre serveur démarré est affichée
    Sleep(300);

    KeybdInput(VK_RETURN,0);
    KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
    SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  //fermer la fenetre
    Sleep(500);

    connecte_CDM;
    Sleep(400);
    Application.processMessages;

    // Serveur d'interface --------------------------------------
    if ServeurInterfaceCDM>0 then
    begin
      KeybdInput(VK_MENU,0);               // enfonce ALT
      KeybdInput(Ord('I'),0);              // I
      KeybdInput(Ord('I'),KEYEVENTF_KEYUP);

      KeybdInput(VK_MENU,KEYEVENTF_KEYUP); // relache ALT
      KeybdInput(Ord('I'),0);
      KeybdInput(Ord('I'),KEYEVENTF_KEYUP);

      KeybdInput(VK_RETURN,0);
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
      KeybdInput(VK_RETURN,0);
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);     // affiche la fenetre d'interface
      Sleep(300);

      // descendre le curseur n fois pour sélectionner le serveur
      for i:=1 to ServeurInterfaceCDM-1 do
      begin
        KeybdInput(VK_DOWN, 0);
        KeybdInput(VK_DOWN, KEYEVENTF_KEYUP);
      end;
      // 2x TAB pour pointer sur OK
      KeybdInput(VK_TAB, 0);KeybdInput(VK_TAB, KEYEVENTF_KEYUP);
      KeybdInput(VK_TAB, 0);KeybdInput(VK_TAB, KEYEVENTF_KEYUP);
      KeybdInput(VK_SPACE, 0);KeybdInput(VK_SPACE, KEYEVENTF_KEYUP);
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Sleep(200);
     
      // Interface
      if (ServeurInterfaceCDM=1) or (ServeurInterfaceCDM=7) then
      begin
        for i:=1 to ServeurRetroCDM-1 do
        begin
          KeybdInput(VK_DOWN,0);KeybdInput(VK_DOWN,KEYEVENTF_KEYUP);
          SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
        end;
        // 2x TAB pour pointer sur OK
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB, KEYEVENTF_KEYUP);
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB, KEYEVENTF_KEYUP);
        KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE, KEYEVENTF_KEYUP); // valide la fenetre d'interface
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);

        Sleep(200);
        KeybdInput(VK_RETURN,0);KeybdInput(VK_RETURN, KEYEVENTF_KEYUP);  // valide la fenetre finale
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;
    end;
  end;
  Lance_CDM:=true;
end;

// démarrage principal du programpe signaux_complexes
procedure TFormPrinc.FormCreate(Sender: TObject);
var i : integer;
    s : string;
begin
  TraceSign:=True;
  PremierFD:=false;
  // services commIP CDM par défaut
  Srvc_Aig:=true;
  Srvc_Det:=true;
  Srvc_Act:=true;
  Srvc_PosTrain:=false;
  Srvc_sig:=false;

  config_modifie:=false;
  AF:='Client TCP-IP CDM Rail ou USB - système XpressNet - Version '+Version+sousVersion;
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
  debugtrames:=false;

  AvecInit:=true;           //&&&&    avec initialisation des aiguillages ou pas
  Option_demarrage:=false;  // démarrage des trains après tempo, pas encore au point
  Diffusion:=AvecInit;      // mode diffusion publique

  Application.processMessages;
  // créée la fenetre vérification de version
  FormVersion:=TformVersion.Create(Self);

  ferme:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  recuCDM:='';
  Nbre_recu_cdm:=0;
  AffMem:=true;
  N_routes:=0;
  N_trains:=0;
  Application.HintHidePause:=30000;

  // lecture fichiers de configuration  client_GL.cfg et config.cfg
  lit_config;
  Application.processMessages;

  // lancer CDM rail et le connecte si on le demande
  if LanceCDM then Lance_CDM;
  ButtonAffTCO.visible:=AvecTCO;
  Loco.Visible:=not(Diffusion);

  // tenter la liaison vers CDM rail
  if not(CDM_connecte) then connecte_CDM;

  // si CDM n'est pas connecté, on ouvre la liaison vers la centrale
  if not(CDM_connecte) then
  begin
    Affiche('CDM absent',clYellow);
    // ouverture par USB
    Affiche('Demande connexion à la centrale par USB protocole XpressNet',clyellow);
    connecte_USB;
    if not(portCommOuvert) then
    begin
      // sinon ouvrir socket vers la centrale
      // Initialisation de la comm socket LENZ
      if AdresseIP<>'0' then
      begin
        Affiche('Demande connexion à la centrale par Ethernet protocole XpressNet',clyellow);
        ClientSocketLenz.port:=port;
        ClientSocketLenz.Address:=AdresseIP;
        ClientSocketLenz.Open;
      end
    end;
  end;

  if portCommOuvert or parSocketLenz then
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

  if not(diffusion) then LireunfichierdeCV1.enabled:=true;

  // ajoute les images des feux dynamiquement
  for i:=1 to NbreFeux do
  begin
    cree_image(i);  // et initialisation tableaux signaux
  end;
  Tempo_init:=5;  // démarre les initialisation des signaux et des aiguillages dans 0,5 s

  // initialisation de la chronologie des évènements détecteurs
  for i:=0 to Max_Event_det_tick do
  begin
    event_det_tick[i].aiguillage:=-1;
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

  // TCO
  if avectco then
  begin
    //créée la fenêtre TCO non modale
    FormTCO:=TformTCO.Create(nil);
    FormTCO.show;
  end;

  Affiche('Fin des initialisations',clyellow);
  LabelEtat.Caption:=' ';
  Affiche_memoire;
  
//  i:=suivant_alg3(28,aig,529,det,1);
  //---------------------------------
    {
    NivDebug:=3;
    FormDebug.show;
    aiguillage[index_aig(7)].position:=const_devie;
    aiguillage[index_aig(20)].position:=const_droit;
    aiguillage[index_aig(21)].position:=const_droit;
    aiguillage[index_aig(28)].position:=const_devie;
    aiguillage[index_aig(26)].position:=const_devie;
    
    i:=suivant_alg3(28,aig,529,det,1);
    
    //i:=Detecteur_suivant_El(520,det,527,det,1);
    //i:=Detecteur_suivant_El(597,1,601,1);
    // i:=Detecteur_suivant_El(598,1,599,1);
    //i:=Detecteur_suivant_El(520,1,20,2);
   // AfficheDebug(IntToSTR(i),clyellow);
   }
end;


// évènement réception d'une trame sur le port COM USB (centrale Lenz)
procedure TFormPrinc.MSCommUSBLenzComm(Sender: TObject);
var i : integer;
begin
  if MSCommUSBLenz.commEvent=comEvReceive then
  begin
    tablo:=MSCommUSBLenz.Input;
    for i:=0 to length(tablo)-1 do
    begin
      chaine_recue:=chaine_recue+char(tablo[i]);
    end;
    if traceTrames then AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+chaine_Hex(chaine_recue),Clwhite);
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
  if TCO_modifie then 
    if MessageDlg('Le TCO a été modifié. Voulez vous le sauvegarder ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      sauve_fichier_tco;
  if config_modifie then
    if MessageDlg('La configuration a été modifiée. Voulez vous la sauvegarder ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      sauve_config;
end;


// positionnement des aiguillages au démarrage : seulement en mode autonome
procedure init_aiguillages;
var i,pos,index : integer;
    s : string;
begin
  if portCommOuvert or parSocketLenz then
  begin
    Affiche('Positionnement aiguillages',cyan);
    for i:=1 to maxaiguillage do
    begin
      index:=index_aig(i);
      if aiguillage[index].modele<>rien then // si l'aiguillage existe
      begin
        pos:=aiguillage[index].posInit;
        s:='Init aiguillage '+intToSTR(i)+'='+intToSTR(pos);
        if pos=1 then s:=s+' (dévié)' else s:=s+' (droit)';
        Affiche(s,cyan);
        pilote_acc(i,pos,aigP);
        sleep(Tempo_Aig);
        application.processMessages;
      end;
    end;  
  end;
end;

// timer à 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var aspect,i,a,x,y,Bimage,adresse,TailleX,TailleY,orientation : integer;
   imageFeu : Timage;
   frx,fry : real;
    s : string;
begin
  inc(tick);
  if Tempo_init>0 then dec(Tempo_init);
  if (Tempo_init=1) and AvecInit then
  begin
    if not(ConfigNulle) and not(ferme) and (AvecInitAiguillages) then
    begin
      Affiche('Positionnement des feux',clYellow);
      envoi_signauxCplx;  // initialisation des feux
      init_aiguillages;   // initialisation des aiguillages
    end;
    if not(AvecInitAiguillages) and not(ferme) and (parSocketLenz or portCommOuvert) then
    begin
      demande_etat_acc;   // demande l'état des accessoires (position des aiguillages)
    end;
    LabelEtat.Caption:=' ';
    Menu_interface(valide);
  end;

  if temps>0 then dec(temps);

  // gestion du clignotant des feux de la page principale
  if tempsCli>0 then dec(tempsCli);
  if tempsCli=0 then
  begin
    tempsCli:=4;
    clignotant:=not(clignotant);  // inversion du clignotant
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
        //Affiche('Clignote feu '+IntToSTR(adresse),clyellow);
      end;
    end;

    // feux du TCO
    if avecTCO then
    begin
      // parcourir les feux du TCO
      for y:=1 to NbreCellY do
      for x:=1 to NbreCellX do
      begin
        PcanvasTCO.pen.mode:=pmCOpy;
        BImage:=TCO[x,y].bImage;
        if Bimage=30 then
        begin
          adresse:=TCO[x,y].adresse;
          a:=EtatsignalCplx[adresse];     // a = état binaire du feu
          if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
          TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
          testBit(a,vert_cli) or testbit(a,blanc_cli) then
          begin
            aspect:=TCO[x,y].aspect;
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
            Orientation:=TCO[x,y].FeuOriente;
            // réduction variable en fonction de la taille des cellules
            calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);
            Dessine_feu_mx(PCanvasTCO,tco[x,y].x,tco[x,y].y,frx,fry,adresse,orientation);
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

  //if (not(Maj_feux_cours) and (Tempo_chgt_feux=1)) then Maj_feux(); // mise à jour des feux sur chgt aiguillage
  //if (not(Maj_feux_cours) and (Tempo_chgt_feux>0)) then dec(Tempo_chgt_feux);

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
      Raz_tout;
     // AffTickSimu:=true;
    end;
    while tick=Tablo_simule[i_simule+1].tick do
    //while i_simule<Index_simule do
    begin
      inc(I_simule);
      
      // evt détecteur ?
      if Tablo_simule[i_simule].detecteur<>0 then
      begin
        s:='Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' det='+intToSTR(Tablo_simule[i_simule].detecteur)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Detecteur(Tablo_simule[i_simule].detecteur, Tablo_simule[i_simule].etat=1,'');  // créer évt détecteur
        StaticText.caption:=s;
      end;

      // evt aiguillage ?
      if Tablo_simule[i_simule].aiguillage<>0 then
      begin
        s:='Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' aig='+intToSTR(Tablo_simule[i_simule].aiguillage)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Aig(Tablo_simule[i_simule].Aiguillage,Tablo_simule[i_simule].etat);  // créer évt aiguillage
        StaticText.caption:=s;
      end;

    end;

    if i_Simule>=Index_simule then
    begin
      Index_Simule:=0;  // fin de simulation
      I_Simule:=0;
      MsgSim:=false;
      Affiche('Fin de simulation',Cyan);
      StaticText.caption:='';
    end;
  end;

  // temporisations de démarrage des trains au feux pas encore au point
  if Option_demarrage then
  for i:=1 to 1024 do
  begin
    if detecteur[i].tempo<>0 then
    begin
      dec(detecteur[i].tempo);
      if detecteur[i].tempo=0 then
      begin
        //Affiche('tempo 0 Detecteur '+intToSTR(i),clyellow);
        s:=detecteur[i].train;
        Affiche('Tempo 0 timer train '+s,clOrange);
        s:=chaine_CDM_vitesse(100,s);  // 100%
        envoi(s);
      end;
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
procedure TFormPrinc.ButtonDroitClick(Sender: TObject);
var adr,erreur : integer;
   s : string;
begin
  val(EditAdresse.text,adr,erreur);
  if (erreur<>0) or (adr<1) or (adr>2048) then
  begin
    EditAdresse.text:='1';
    exit;
  end;

  pilote_acc(adr,const_droit,aigP);
  s:='accessoire '+IntToSTR(adr)+' droit';
  Affiche(s,clyellow);
end;

procedure TFormPrinc.ButtonDevieClick(Sender: TObject);
  var adr,erreur : integer;
   s : string;
begin
  val(EditAdresse.text,adr,erreur);
  if (erreur<>0) or (adr<1) or (adr>2048) then
  begin
    EditAdresse.text:='1';
    exit;
  end;

  pilote_acc(adr,const_devie,aigP);
  s:='accessoire '+IntToSTR(adr)+' dévié';
  Affiche(s,clyellow);
end;

procedure TFormPrinc.EditvalEnter(Sender: TObject);
begin
  if (Editval.Text<>'1') and (Editval.Text<>'2') then editval.text:='1';
end;

procedure TFormPrinc.BoutonRafClick(Sender: TObject);
begin
  rafraichit;
end;

// erreur sur socket Lenz
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
   if errorcode<>10061 then affiche(s,clOrange);
   if nivDebug=3 then afficheDebug(s,clOrange);
   parSocketLenz:=false;
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
   if errorcode<>10061 then affiche(s,ClOrange);
   afficheDebug(s,ClOrange);
   CDM_connecte:=false;
   if (portCommOuvert=false) and (parSocketLenz=false) then LabelTitre.caption:=titre;
   caption:=AF;
   ErrorCode:=0;
end;

// lecture depuis socket
procedure TFormPrinc.ClientSocketLenzRead(Sender: TObject;
  Socket: TCustomWinSocket);
var s : string;
begin
  s:=ClientSocketLenz.Socket.ReceiveText;
  if traceTrames then afficheDebug(chaine_hex(s),clWhite);
  interprete_reponse(s);
end;

procedure TFormPrinc.ButtonTestClick(Sender: TObject);
begin
  demande_etat_acc;
end;

// procédure Event appelée si on clique sur un checkbox de demande de feu blanc des images des feux
// non utilisé
procedure TFormprinc.proc_checkBoxFB(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat,adresse,erreur : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox; 
  coche:=cb.Checked;         // état de la checkbox
  s:=Cb.Hint; 
  val(s,adresse,erreur);   // adresse du signal correspondant au checkbox cliqué
  if erreur=0 then
  begin
    i:=index_feu(adresse);
    etat:=feux[i].EtatSignal;
    affiche(IntToSTR(etat),clyellow);
    // si le feu est vert et que la coche est mise, substituer le blanc
    if (etat=vert_F) and coche then 
    begin
      Maj_Etat_Signal(Adresse,blanc);
      Envoi_signauxCplx;
    end;
    // si pas coché, on revient en normal
    if not(coche) then rafraichit;
  end; 
end;

procedure TFormPrinc.ButtonInfoClick(Sender: TObject);
begin
  Affiche('Ce programme pilote des signaux complexes de façon autonome ou avec CDM rail ',ClYellow);
  Affiche('En fonction des détecteurs mis à 1 ou 0 par des locomotives',ClYellow);
  Affiche('en circulation sur le réseau',ClYellow);
  Affiche('En vert : Trames envoyées à l''interface',ClWhite);
  Affiche('En violet : Trames brutes reçues de l''interface',ClWhite);
  Affiche('En rouge : erreurs et défauts',ClWhite);
  Affiche('En orange : pilotage des signaux / erreurs mineures',ClWhite);
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
  if portCommOuvert then
  begin
    portCommOuvert:=false;
    Formprinc.MSCommUSBLenz.Portopen:=false;
    Affiche('Port USB déconnecté',clyellow);
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
    Affiche('Demande de connexion de l''interface XpressNet en ethernet sur '+AdresseIP+':'+IntToSTR(Port),clyellow);
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
  
procedure TFormPrinc.AffEtatDetecteurs(Sender: TObject);
var j,adr : integer;
    s : string;
begin
  Affiche('Etat des détecteurs:',ClLime);
  for j:=1 to NDetecteurs do
  begin
   adr:=Adresse_detecteur[j];
   s:='Dét '+intToSTR(adr)+'=';
   if Detecteur[adr].etat then s:=s+'1' else s:=s+'0';
   s:=s+' '+Detecteur[Adr].train;
   Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Etatdesaiguillages1Click(Sender: TObject);
var i,j,index : integer;
    model : TEquipement;
    s : string;
begin
  Affiche('Position des aiguillages:',ClLime);
  for i:=1 to MaxAcc do
  begin
    index:=index_aig(i);
    model:=aiguillage[index].modele ;
    if model<>rien then
    begin
      s:='Aiguillage '+IntToSTR(i)+' : ';
      if aiguillage[index].position=const_devie then s:=s+' (dévié)' ;
      if aiguillage[index].position=const_droit then s:=s+' (droit)';
      if aiguillage[index].position=const_inconnu then s:=s+' inconnue';
      
      if model=triple then // aig triple
      begin
        j:=aiguillage[index].AdrTriple;
        s:=s+' Aig '+IntToSTR(j)+': '+intToSTR(aiguillage[index_aig(j)].position);
        if aiguillage[index_aig(j)].position=1 then s:=s+' (dévié)' else s:=s+' (droit)';
      end;
      Affiche(s,clWhite);
    end;
  end;
end;

procedure TFormPrinc.Codificationdesaiguillages1Click(Sender: TObject);
var i,adr : integer ;
    s : string;
begin
  Affiche('Codification interne des aiguillages',Cyan);
  Affiche('D=position droite S=position déviée P=pointe Z=détecteur',Cyan);
  for i:=1 to MaxAiguillage do
  begin
    adr:=aiguillage[i].adresse;
    begin
      s:=IntToSTR(i)+' Adr='+IntToSTR(adr);
      if aiguillage[i].modele=aig then s:=s+' Pointe=';
      if (aiguillage[i].modele=tjd) then 
      begin
        s:=s+' TJD:';
        if aiguillage[i].inversionCDM=1 then s:=s+'(INV) ';
      end;  
      if aiguillage[i].modele=tjs then 
      begin
        s:=s+' TJS:';
        if aiguillage[i].inversionCDM=1 then s:=s+'(INV) ';
      end;  
      if aiguillage[i].modele=triple then s:=s+'/'+intToSTR(aiguillage[i].AdrTriple)+' Triple: Pointe=';
      
      if (aiguillage[i].modele=aig) or (aiguillage[i].modele=triple) then 
      begin
        s:=s+IntToSTR(aiguillage[i].APointe)+aiguillage[i].APointeB;
        s:=s+' Dévie='+IntToSTR(aiguillage[i].ADevie)+aiguillage[i].ADevieB+
         ' Droit='+IntToSTR(aiguillage[i].ADroit)+aiguillage[i].ADroitB;
      end;   
      if (aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs) then
      begin
        s:=s+' Ddroit='+intToSTR(aiguillage[i].Ddroit)+aiguillage[i].DdroitB;
        s:=s+' Ddevie='+intToSTR(aiguillage[i].DDevie)+aiguillage[i].DdevieB;
        s:=s+' Adroit='+intToSTR(aiguillage[i].Adroit)+aiguillage[i].AdroitB;
        s:=s+' Adevie='+intToSTR(aiguillage[i].ADevie)+aiguillage[i].AdevieB;
        if (aiguillage[i].modele=tjs) then 
          s:=s+' L='+IntToSTR(aiguillage[i].tjsInt)+aiguillage[i].tjsIntB;
      end;
      if aiguillage[i].modele=triple then s:=s+' Dévié2='+intToSTR(aiguillage[i].ADevie2)+aiguillage[i].ADevie2B;
      if aiguillage[i].vitesse<>0 then s:=s+' Vitesse déviée='+intToSTR(aiguillage[i].vitesse);
      if aiguillage[i].inversionCDM<>0 then s:=s+' pilotage inversé';

      Affiche(s,clYellow);
    end;
  end;
end;
    
procedure TFormPrinc.ClientSocketLenzConnect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Lenz connecté ',clYellow);
  AfficheDebug('Lenz connecté ',clYellow);
  parSocketLenz:=True;
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
  SocketCDM_connecte:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  DeConnecterCDMRail.enabled:=true;
end;

// décodage d'une trame CDM au protocole IPC
// la trame_CDM peut contenir 2000 caractères à l'initialisation du RUN.
procedure Interprete_trameCDM(trame_CDM:string);
var i,j,objet,posST,posAC,posDT,posSG,posXY,k,l,erreur, adr,adr2,etat,etataig,
    vitesse,etatAig2,name,prv,nbre,nbreVir,long,index : integer ;
    x,y,x2,y2 : longint ;
    s,ss,train,commandeCDM : string;
    traite,sort : boolean;
begin
{
  trame_CDM:='S-R-14-0004-CMDACC-__ACK|000|S-E-14-5162-CMDACC-ST_DT|052|05|NAME=2756;OBJ=2756;AD=518;TRAIN=CC406526;STATE=1;';
  trame_cdm:=trame_cdm+'S-E-14-5163-CMDACC-ST_DT|049|05|NAME=2757;OBJ=2757;AD=518;TRAIN=_NONE;STATE=1;';
  trame_cdm:=trame_cdm+'S-E-14-5164-CMDACC-ST_DT|049|05|NAME=2758;OBJ=2758;AD=519;TRAIN=_NONE;STATE=0;';
  trame_cdm:=trame_cdm+'S-E-14-5165-CMDACC-ST_DT|049|05|NAME=2759;OBJ=2759;AD=519;TRAIN=_NONE;STATE=0';
  trame_cdm:=trame_cdm+'S-E-14-5166-CMDACC-ST_DT|049|05|NAME=7060;OBJ=7060;AD=520;TRAIN=_NONE;STATE=0';
  trame_cdm:=trame_cdm+'S-E-14-5167-CMDACC-ST_DT|051|05|NAME=7061;OBJ=7061;AD=520;TRAIN=BB25531;STATE=0';
  trame_cdm:=trame_cdm+'S-E-14-5168-CMDACC-ST_DT|049|05|NAME=7057;OBJ=7057;AD=517;TRAIN=_NONE;STATE=0';
  trame_cdm:=trame_cdm+'S-E-14-5169-CMDACC-ST_DT|049|05|NAME=7058;OBJ=7058;AD=517;TRAIN=_NONE;STATE=0';
 }

  //debugtrames:=true;
  AckCDM:=trame_CDM<>'';
  if pos('ACK',trame_CDM)=0 then
  begin
    if pos('ERR=200',trame_CDM)<>0 then Affiche('Erreur CDM : réseau non chargé',clred);
  end;

  k:=0;
  //Affiche('L='+InTToSTR(length(recuCDM)),clyellow);
  repeat
    // trouver la longueur de la chaîne de paramètres
    i:=pos('|',trame_CDM);
    val(copy(trame_CDM,i+1,5),long,erreur);
    //Affiche('long chaine param='+intToSTR(long),clyellow);
    if long=0 then
    begin
      //if debugTrames then Affiche('Longueur nulle',clYellow);
      if pos('ACK',trame_cdm)<>0 then Ack_cdm:=true;
      i:=posEx('|',trame_CDM,i+1);
      if i=0 then begin Affiche('Erreur trames CDM manque 2ème |',clred);exit;end;
      delete(trame_cdm,1,i);
    end;

    if long<>0 then
    begin
      // trouver le nombre de paramètres
      i:=posEx('|',trame_CDM,i+1);
      if i=0 then
      begin
        if debugTrames then AfficheDebug('0 paramètres '+trame_CDM,clyellow);
        Nbre_recu_cdm:=0;
        exit;
      end;

      val(copy(trame_CDM,i+1,5),nbre,erreur);
      //Affiche('nbre='+IntToSTR(nbre),clyellow);
      // compter le nombre de virgules qui doit être égal au nombre de paramètres
      NbreVir:=0;  // nombre de virgules
      repeat
        i:=posEx(';',trame_CDM,i+1);
        if i<>0 then inc(NbreVir);
      until (i=0) or (NbreVir=nbre);
      if i=0 then
      begin
        if debugTrames then AfficheDebug('tronqué : '+trame_CDM,clyellow);
        residuCDM:=trame_CDM;
        Nbre_recu_cdm:=0;
        exit;
      end;

      CommandeCDM:=copy(trame_CDM,1,i);
      if debugTrames then AfficheDebug(commandeCDM,clorange);
      Delete(trame_CDM,1,i);

      // évènement aiguillage. Le champ AD2 n'est pas forcément présent
      posST:=pos('CMDACC-ST_TO',commandeCDM);
      if posST<>0 then
      begin
        delete(commandeCDM,posST,12);
        objet:=0;
        i:=posEx('OBJ=',commandeCDM,posST);ss:=copy(commandeCDM,i+4,10);
        if i<>0 then begin val(ss,objet,erreur);delete(commandeCDM,i,6);end else Affiche('Erreur 95 : pas d''objet ',clred);

        i:=posEx('AD=',commandeCDM,posST);ss:=copy(commandeCDM,i+3,10);  //Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
        if i=0 then begin Affiche('Erreur 96 : absence AD aig '+intToSTR(adr),clred);Affiche(commandeCDM,clyellow);end;
        val(ss,adr,erreur);Delete(commandeCDM,i,4);

        //Affiche(copy(recuCDM,j,i+80),clOrange);
        i:=posEx('AD2=',commandeCDM,i);ss:=copy(commandeCDM,i+4,10); // Affiche('i='+intToSTR(i),clOrange);
        if i=0 then begin Affiche('Erreur 97 : absence AD2 aig '+intToSTR(adr),clred);Affiche(commandeCDM,clyellow);end;
        val(ss,adr2,erreur);  //Affiche('adr2='+intToSTR(adr2),clyellow);
        Delete(commandeCDM,i,5);

        i:=posEx('STATE=',commandeCDM,i);ss:=copy(commandeCDM,i+6,10); //Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
        if i=0 then begin Affiche('Erreur 98 : absence STATE aig '+intToSTR(adr),clred);Affiche(commandeCDM,clyellow);end;
        val(ss,etat,erreur);
        Delete(commandeCDM,i,7);

        //Affiche('Aig '+inttostr(adr)+' pos='+IntToSTR(etat),clyellow);
        //Affiche(commandeCDM,clyellow);
        index:=index_aig(adr);
        if index<>0 then
        begin
          // aiguillage normal
          if aiguillage[index].modele=aig then
          begin
            //Affiche('Normal',clyellow);
            if etat=const_droit_CDM then etatAig:=const_droit else etatAig:=const_devie;
            Event_Aig(adr,etatAig);
          end;

          // TJD TJS
          if (aiguillage[index].modele=tjd) or (aiguillage[index].modele=tjs) then
          begin
            //Affiche('TJD/S',clyellow);
            //adr2:=aiguillage[index_aig(adr].Apointe;  // 2eme adresse de la TJD
            case etat of
            1 : begin etatAig:=const_devie;EtatAig2:=const_droit;end;
            4 : begin etatAig:=const_devie;EtatAig2:=const_devie;end;
            5 : begin etatAig:=const_droit;EtatAig2:=const_devie;end;
            0 : begin etatAig:=const_droit;EtatAig2:=const_droit;end;
            end;
            if (aiguillage[index].inversionCDM=1) or (aiguillage[index_aig(adr2)].inversionCDM=1) then
            begin
              //Affiche('inverse',clyellow);
              prv:=adr;
              adr:=adr2;
              adr2:=prv;
            end;
            Event_Aig(adr,etatAig);
            Event_Aig(adr2,etatAig2);
          end;

          // aiguillage triple
          if aiguillage[index].modele=triple then 
          begin
            //Affiche('Triple',clyellow);
            // état de l'aiguillage 1
            if (etat=0) or (etat=2) then etatAig:=2;
            if etat=3 then etatAig:=1;
            // état de l'aiguillage 2
            adr2:=aiguillage[index].AdrTriple;
            if (etat=0) or (etat=3) then etatAig2:=2;
            if etat=2 then etatAig2:=1;
            Event_Aig(adr,etatAig);
            Event_Aig(adr2,etatAig2);
          end;
        end
        else
        begin
          AfficheDebug('Recu evt aig de CDM pour un aiguillage '+intToSTR(Adr)+' non déclaré',clOrange);
        end;
      end;
        
      // évènement détecteur
      posDT:=pos('CMDACC-ST_DT',commandeCDM);
      if posDT<>0 then
      begin
        Delete(commandeCDM,posDT,12);
        i:=posEx('AD=',commandeCDM,posDT);
        if i<>0 then
        begin
          ss:=copy(commandeCDM,i+3,10);Delete(commandeCDM,i,4);
          val(ss,adr,erreur);
        end;
        i:=posEx('TRAIN=',commandeCDM,posDT);
        j:=PosEx(';',commandeCDM,i);
        train:=copy(commandeCDM,i+6,j-i-6);
        delete(commandeCDM,i,7);

        //Affiche('Train=*'+Train+'*',clOrange);
        i:=posEx('STATE=',commandeCDM,posDT);ss:=copy(commandeCDM,i+6,10);
        val(ss,etat,erreur); Delete(commandeCDM,i,7);

        if (train='_NONE') then train:=detecteur[Adr].train;
        Event_detecteur(Adr,etat=1,train);
        //AfficheDebug(IntToSTR(adr)+' '+IntToSTR(etat),clyellow);
        if AfficheDet then Affiche('Rétro Détecteur '+intToSTR(adr)+'='+IntToStr(etat),clYellow);
      end ;

      // évènement signal - non stocké ni interprété
      posSG:=pos('CMDACC-ST_SG',commandeCDM);
      if posSG<>0 then
      begin
        Delete(commandeCDM,posSG,12);
        i:=posEx('AD=',commandeCDM,posDT);ss:=copy(commandeCDM,i+3,10);
        val(ss,adr,erreur);
        i:=posEx('STATE=',commandeCDM,posSG);ss:=copy(commandeCDM,i+6,10);
        Delete(commandeCDM,posSG,i+5-posSG);
        val(ss,etat,erreur);
        s:='SignalCDM '+intToSTR(adr)+'='+IntToStr(etat);
        if afftiers then AfficheDebug(s,ClSkyBlue);
      end ;

      // évènement actionneur
      // attention un actionneur qui repasse à 0 ne contient pas de nom de train
      //S-E-03-0157-CMDACC-ST_AC|049|05|NAME=0;OBJ=7101;AD=815;TRAIN=CC406526;STATE=1;
      posAC:=pos('CMDACC-ST_AC',commandeCDM);
      if posAC<>0 then
      begin
        Delete(commandeCDM,posAC,12);
        i:=posEx('AD=',commandeCDM,posAC);ss:=copy(commandeCDM,i+3,10);
        val(ss,adr,erreur);
        i:=posEx('NAME=',commandeCDM,posAC);ss:=copy(commandeCDM,i+5,10);
        val(ss,name,erreur);
        i:=posEx('TRAIN=',commandeCDM,posAC);l:=PosEx(';',commandeCDM,i);
        train:=copy(commandeCDM,i+6,l-i-6);
        i:=posEx('STATE=',commandeCDM,posAC);ss:=copy(commandeCDM,i+6,10);
        val(ss,etat,erreur);
        Delete(commandeCDM,posAC,i-posAC);
        i:=pos(';',commandeCDM);
        if i<>0 then Delete(commandeCDM,1,i);
        if AfficheDet then
          Affiche('Actionneur AD='+intToSTR(adr)+' Nom='+intToSTR(name)+' Train='+train+' Etat='+IntToSTR(etat),clyellow);
        Event_act(adr,etat,train); // déclenche évent actionneur
      end;

      // évènement position des trains - non stocké ni interprété
      posXY:=pos('CMDTRN-SPDXY',commandeCDM);
      if posXY<>0 then
      begin
        Delete(commandeCDM,posXY,12);
        i:=posEx('AD=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+3,10);
        val(ss,adr,erreur);
        s:='Train AD='+IntToSTR(adr);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('NAME=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        train:=copy(commandeCDM,i+5,l-i-5);
        s:=s+' '+train;
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('SPEED=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+6,10);
        val(ss,vitesse,erreur);
        s:=s+' '+IntToSTR(vitesse);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('X=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+2,10);
        val(ss,x,erreur);
        s:=s+' X='+IntTostr(x);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('Y=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+2,10);
        val(ss,y,erreur);
        s:=s+' Y='+IntTostr(y);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('X2=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+3,10);
        val(ss,x2,erreur);
        s:=s+' X2='+IntTostr(x2);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('Y2=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+3,10);
        val(ss,y2,erreur);
        s:=s+' Y2='+IntTostr(y2);
        Delete(commandeCDM,i,l-i+1);
        if afftiers then afficheDebug(s,clAqua);

        Delete(commandeCDM,posXY,12);
      end;

      inc(k);
      //Affiche('k='+intToSTR(k),clyellow);
    end;

    sort:=(length(trame_CDM)<10) or (k>=2000);// or (posST=0) and (posDT=0) and (posAC=0) and (posSG=0);
  until (sort);

  //Affiche('k='+IntToSTR(k)+' Ligne traitée '+recuCDM,clLime);
  //if pos('_ACK',recuCDM)=0 then recuCDM:=''; // effacer la trame sauf si c'est une trame ACK car le trame est utilisée dans le process de connexion de cdm
  if k>=2000 then begin Affiche('Erreur 90 : Longrestante='+IntToSTR(length(trame_CDM)),clred); Affiche(trame_CDM,clred);  end;

  Nbre_recu_cdm:=0;
end;

// réception d'un message de CDM rail
procedure TFormPrinc.ClientSocketCDMRead(Sender: TObject;Socket: TCustomWinSocket);
begin
  inc(Nbre_recu_cdm);
  //if Nbre_recu_cdm>1 then Affiche('Empilement de trames CDM: '+intToSTR(Nbre_recu_cdm),clred);
  recuCDM:=ClientSocketCDM.Socket.ReceiveText;  // commandeCDM est le morceau tronqué de la fin de la réception précédente

  residuCDM:='';
  if traceTrames then AfficheDebug(recuCDM,clWhite);

  {begin
    n:=80;
    l:=length(recuCDM);
    i:=0;
    repeat
      AfficheDebug(copy(recuCDM,(i*n)+1,n),clWhite);
      inc(i);
    until l<i*n;
  end;}
  Interprete_trameCDM(recuCDM);
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
  caption:=AF;
  CDM_connecte:=False;
  SocketCDM_connecte:=false;
  MenuConnecterUSB.enabled:=true;
  DeConnecterUSB.enabled:=true;
  ConnecterCDMRail.enabled:=true;
end;
  
procedure TFormPrinc.Codificationdesfeux1Click(Sender: TObject);
var i,j,k,l,NfeuxDir,nc : integer;
    s,s2 : string;
begin
  Affiche('Codification interne des feux',Cyan);

  for i:=1 to NbreFeux do
  begin
    // feu de signalisation
    s:=IntToSTR(i)+' Adr='+IntToSTR(feux[i].Adresse);
    s:=s+' décodeur='+IntToStr(feux[i].decodeur);

    if feux[i].aspect<10 then
    begin
      s:=s+' SIG Nbrefeux='+IntToSTR(feux[i].aspect)+' ';
      s:=s+' Det='+IntToSTR(feux[i].Adr_det1);
      s:=s+' El_Suiv1='+IntToSTR(feux[i].Adr_el_suiv1)+' Type suiv1='+intToSTR(BTypeToNum(feux[i].Btype_suiv1));
      case feux[i].Btype_suiv1 of
      det : s:=s+' (détecteur) ';
      aig,tjs,tjd : s:=s+' (aiguillage ou TJD-S) ';
      triple : s:=s+' (aiguillage triple) ';
      end;
      if feux[i].decodeur=6 then
      s:=s+'Cible unisemaf= '+intToSTR(feux[i].Unisemaf);

      // conditions sur carré
      l:=1;
      repeat
        nc:=Length(feux[i].condcarre[l])-1 ;
        if (nc>0) and (l=1) then begin Affiche(s,clYellow);s:='';end;  // pour afficher sur 2 lignes
        for k:=1 to nc do
        begin
          s:=s+'A'+IntToSTR(feux[i].condcarre[l][k].Adresse)+feux[i].condcarre[l][k].PosAig;
            if k<nc then s:=s+',';
        end;
        inc(l);
        if nc>0 then s:=s+'/';
      until (nc<=0) or (l>6);
    end
    
    else
    // feu directionnel
    begin
      s:=s+' DIR Nbrefeux='+IntToSTR(feux[i].aspect-10)+' ';
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
    if s2<>'' then Affiche('Conditions de carré : '+s2,clYellow);
  end;
end;

procedure TFormPrinc.ClientSocketLenzDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  parSocketLenz:=False;
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
  val(EditCV.text,adr,erreur);
  if (erreur<>0) or (Adr>255) or (Adr<0) then 
  begin
    EditCV.Text:='1';
    exit;
  end;  
  
  val(EditVal.Text,valeur,erreur);
  if (erreur<>0) or (valeur<0) or (valeur>255) then 
  begin
    EditVal.text:='1';
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

// lit un fichier de CV vers un accessoire 
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
    i,cv,erreur : integer;
begin
  s:=GetCurrentDir;
  //s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  N_Cv:=0; // nombre de CV recus à 0
  sa:='';
  Affiche('Lecture CV',clyellow);

  val(EditCV.Text,cv,erreur);
  if (erreur<>0) or (cv>255) or (cv<0) then 
  begin
    EditCV.Text:='1';
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
  Affiche('Pas de réponse de l''interface après demande de passage en mode prog',clOrange);
end;

procedure TFormPrinc.Quitter1Click(Sender: TObject);
begin
  close;
end;

procedure TFormPrinc.ConfigClick(Sender: TObject);
begin
  Tformconfig.create(nil);
  FormConfig.PageControl.ActivePage:=Formconfig.TabSheetCDM;  // force le premier onglet sur la page
  formconfig.showmodal;
  formconfig.close;
end;

procedure TFormPrinc.Codificationdesactionneurs1Click(Sender: TObject);
var i,adract,etatAct,fonction,v,acc,sortie : integer;
    s,s2 : string;
begin
  if (maxTablo_act=0) and (NbrePN=0) then
  begin
    Affiche('Aucun actionneur déclaré',Cyan);
    exit;
  end;

  Affiche('Codification interne des actionneurs',Cyan);
  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].train;
    etatAct:=Tablo_actionneur[i].etat ;
    AdrAct:=Tablo_actionneur[i].actionneur;
    s2:=Tablo_actionneur[i].train;
    acc:=Tablo_actionneur[i].accessoire;
    sortie:=Tablo_actionneur[i].sortie;
    fonction:=Tablo_actionneur[i].fonction;
    if (s2<>'') then
    begin
      if fonction<>0 then
      s:='FonctionF  Actionneur='+intToSTR(adrAct)+':'+intToSTR(etatAct)+' Train='+s2+' F'+IntToSTR(fonction)+
              ' Temporisation='+intToSTR(tablo_actionneur[i].Tempo);
      if acc<>0 then 
      s:='Accessoire Actionneur='+intToSTR(adrAct)+':'+intToSTR(etatAct)+' Train='+s2+' A'+IntToSTR(acc)+
              ' sortie='+intToSTR(sortie);
      Affiche(s,clYellow);        
    end;
  end;

  // dans le tableau des PN
  for i:=1 to NbrePN do
  begin
    s:='PN'+intToSTR(i)+'        Adresse fermeture PN='+IntToSTR(Tablo_PN[i].AdresseFerme);
    s:=s+'        Adresse ouverture PN='+IntToSTR(Tablo_PN[i].AdresseOuvre);
    Affiche(s,clyellow);
    s:='                Commande fermeture='+intToSTR(Tablo_PN[i].commandeFerme);
    s:=s+'        Commande ouverture='+intToSTR(Tablo_PN[i].commandeOuvre);
    s:=s+'        Nbre de voies='+intToSTR(Tablo_PN[i].nbVoies);
    Affiche(s,clyellow);
    for v:=1 to Tablo_PN[i].nbvoies do
    begin
      s:='                Voie '+IntToSTR(v)+': Actionneur de fermeture='+intToSTR(Tablo_PN[i].voie[v].ActFerme);
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
      RecuCDM:=s;
      Interprete_trameCDM(s);
    end;  
    closeFile(fte);
  end;    
end;

procedure TFormPrinc.ButtonAffTCOClick(Sender: TObject);
begin
  formTCO.windowState:=wsNormal; //Maximized;
  formTCO.BringToFront;
end;

procedure TFormPrinc.ButtonLanceCDMClick(Sender: TObject);
begin
  Lance_CDM ;
end;

procedure TFormPrinc.Affichefentredebug1Click(Sender: TObject);
begin
  formDebug.show;
end;

procedure TFormPrinc.locoClick(Sender: TObject);
begin
  // vitesse et direction 18 pas
  vitesse_loco(3,20,true);
end;

// pour déplacer l'ascenseur de l'affichage automatiquement en bas
procedure TFormPrinc.FenRichChange(Sender: TObject);
begin
  SendMessage(FenRich.handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFormPrinc.Copier1Click(Sender: TObject);
begin
  FenRich.CopyToClipboard;
  FenRich.SetFocus;
end;

procedure TFormPrinc.Etatdessignaux1Click(Sender: TObject);
var Adr,etat,i : integer;
    aspect,combine : word;
    s : string;
begin
  for i:=1 to NbreFeux do
  begin
    Adr:=Feux[i].Adresse;
    Etat:=Feux[i].EtatSignal;
    s:='Feu '+IntToSTR(Adr)+' Etat=';
    code_to_aspect(Etat,aspect,combine);
    s:=s+IntToSTR(etat)+'='+EtatSign[aspect]+' '+EtatSign[combine];
    Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Apropos1Click(Sender: TObject);
begin
  Affiche(' ',clyellow);
  Affiche('Signaux complexes GL version '+version+sousVersion+' (C) 2020 F1IWQ Gily TDR',clWhite);
  Affiche('http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906',clWhite);
  Affiche('https://github.com/f1iwq2/Signaux_complexes_GL',clWhite);
  Affiche(' ',clyellow);  
end;

procedure TFormPrinc.Proprits1Click(Sender: TObject);
var s: string;
    index : integer;
begin
   clicliste:=false;
   s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pout récupérer l'index (ex: ImageFeu6)
   //Affiche(s,clOrange);     // nom de l'image du signal (ex: ImageFeu6)
   index:=extract_int(s);   // extraire l'index (ex 6)
   Tformconfig.create(nil);
   formconfig.PageControl.ActivePage:=formconfig.TabSheetSig;
   //Affiche(intToSTR(index),clOrange);
   ligneClicSig:=index-1;
   formconfig.showmodal;
   formconfig.close;
end;

procedure TFormPrinc.Nouveaufeu1Click(Sender: TObject);
var i : integer;
begin
  inc(NbreFeux);
  i:=NbreFeux;
  feux[i].Adresse:=999;
  feux[i].Aspect:=3;
  feux[i].decodeur:=0;
  feux[i].verrouCarre:=false;
  cree_image(i);
  Affiche('Feu 999 créé',clyellow);
end;

procedure TFormPrinc.Nouveaufeu2Click(Sender: TObject);
begin
  NouveauFeu1Click(Sender);
end;

procedure TFormPrinc.VrifierlacohrenceClick(Sender: TObject);
begin
  if verif_coherence then affiche('La configuration est cohérente',clLime);
end;

begin
end.
