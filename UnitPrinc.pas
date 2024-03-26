Unit UnitPrinc;
// 12/03/24
(********************************************
  Programme signaux complexes Graphique Lenz
  Delphi 7 + activeX Tmscomm + clientSocket
  ou RadStudio
  options de compilation: options du debugger/exception du langage : décocher "arreter sur exceptions delphi"
  sinon une exception surgira au moment de l'ouverture du com
  Dans projet/option/fiches : fiches disponibles : formtco uniquement
 ********************************************

 Pour TMSCOM : il est nécessaire d'avoir le fichier mscomm32.ocx dans le repertoire system de windows
 (Pour un Os64, %systemroot%\sysWOW64   pour unOs32 : %systemroot%\system32)
 et que ce composant soit enregistré (avec regsvr32)

 Attention si le répertoire d'install n'est pas autorisé, windows10-11 va sauver les fichiers dans
 C:\Users\moi\AppData\Local\VirtualStore\Program Files (x86)\Signaux_complexes
 il faut autoriser l'utilisateur: Utilisateurs (nom\utilisateurs)


 Pilotage des accessoires:
 raquette   octet sortie
    +            2    =   vert  = aiguillage droit  = sortie 2 de l'adresse d'accessoire
    -            1    =   rouge = aiguillage dévié  = sortie 1 de l'adresse d'accessoire

 vitesse port com lenz par défaut=57600

 ligne de commande en mode administrateur pour valider le socket du pare feu:
 netsh advfirewall firewall add rule name="cdm rail" dir=in action=allow program="C:\Program Files (x86)\CDM-Rail\cdr.exe" enable=yes
*)

// En mode simulation run:
// CDM ne renvoie pas les détecteurs au départ du RUN.
// il ne renvoie pas non plus le nom des trains sur les actionneurs
// les noms des trains sont bien renvoyés sur les détecteurs à 1
//
// En mode RUN:
// CDM renvoie le nom des trains sur les actionneurs à 1, jamais à 0
// et quelquefois (pas toujours!) sur les détecteurs à 1, jamais à 0
// Au début du RUN, CDM renvoie les états des détecteurs et en mélangé les aiguillages et on en reçoit les états.
// Puis on reçoit la position des trains qui bougent. Si un train parqué ne bouge pas, on ne reçoit rien de ce train.
//
// En simulation:
// CDM Rail ne renvoie pas les états des aiguillages en début de simu
// Les aiguillages sont renvoyés quand on clique dessus
// Les actionneurs fonctionnent. Les détecteurs ne sont pas renvoyés.
//
// En mode centrale connectée à signaux complexes (autonome)
// si on bouge un aiguillage à la raquette, on récupère bien sa position par XpressNet.
// Une loco sur un détecteur au lancement ne renvoie pas son état statique. Seuls les changements
// d'état sont renvoyés par la centrale.
//
// Notes pour compilation sous Embarcadero : --------------------------------------------------
// Pour compilation avec Rad Studio (Delphi11): Projet / Options // Application / Apparence /
// Embarcadero technologies / carbon ou Auric
//
// Pour le mode sombre sous embarcadero, il faut sélectionner:
// Projet / Options // Application / manifeste /  fichier manifeste : personnaliser
// à la sauvegarde, ce champ appraitra sous "générer automatiquement"
// et : décocher "activer les thèmes d'exécution"

//{$Q-}  // pas de vérification du débordement des opérations de calcul
//{$R-}  // pas de vérification des limites d'index du tableau et des variables
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls, ShellAPI, TlHelp32,
  ImgList, ScktComp, StrUtils, Menus, ActnList, MSCommLib_TLB, MMSystem ,
  Buttons, NB30, comObj, activeX ,DateUtils 
  {$IF CompilerVersion >= 28.0}   // si delphi>=11
  ,Vcl.Themes
  {$IFEND}
  ;

type
  TFormPrinc = class(TForm)
    Timer1: TTimer;
    LabelTitre: TLabel;
    ClientSocketInterface: TClientSocket;
    MainMenu1: TMainMenu;
    Interface1: TMenuItem;
    MenuConnecterUSB: TMenuItem;
    DeconnecterUSB: TMenuItem;
    N2: TMenuItem;
    MenuConnecterEthernet: TMenuItem;
    MenuDeconnecterEthernet: TMenuItem;
    StatusBar1: TStatusBar;
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
    Codificationdessignaux: TMenuItem;
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
    Affichefentredebug1: TMenuItem;
    PopupMenuFenRich: TPopupMenu;
    Copier1: TMenuItem;
    Etatdessignaux1: TMenuItem;
    N6: TMenuItem;
    Apropos1: TMenuItem;
    PopupMenuSignal: TPopupMenu;
    Proprits1: TMenuItem;
    N8: TMenuItem;
    Vrifierlacohrence: TMenuItem;
    Etatdeszonespartrain1: TMenuItem;
    N7: TMenuItem;
    Demanderversiondelacentrale1: TMenuItem;
    Demanderlaversiondelacentrale1: TMenuItem;
    RepriseDCC1: TMenuItem;
    Demandetataccessoires1: TMenuItem;
    LancerCDMrail1: TMenuItem;
    Roulage1: TMenuItem;
    Placerlestrains1: TMenuItem;
    Demandetatdtecteurs1: TMenuItem;
    Informationsdusignal1: TMenuItem;
    Button1: TButton;
    Evenementsdetecteurspartrain1: TMenuItem;
    RazResa: TMenuItem;
    Vrifiernouvelleversion1: TMenuItem;
    N9: TMenuItem;
    Analyser1: TMenuItem;
    Coller1: TMenuItem;
    Affiche_fenetre_CDM: TMenuItem;
    ImageSignal20: TImage;
    COs1: TMenuItem;
    AffichertouslesTCO1: TMenuItem;
    N10: TMenuItem;
    Mosaquehorizontale1: TMenuItem;
    Mosaqueverticale1: TMenuItem;
    N11: TMenuItem;
    Mosaiquecarre1: TMenuItem;
    N12: TMenuItem;
    AfficherTCO11: TMenuItem;
    AfficherTCO21: TMenuItem;
    AfficherTCO31: TMenuItem;
    AfficherTCO41: TMenuItem;
    AfficherTCO51: TMenuItem;
    AfficherTCO61: TMenuItem;
    AfficherTCO71: TMenuItem;
    AfficherTCO81: TMenuItem;
    AfficherTCO91: TMenuItem;
    AfficherTCO101: TMenuItem;
    N13: TMenuItem;
    NouveauTCO1: TMenuItem;
    SupprimerTCO1: TMenuItem;
    CO11: TMenuItem;
    CO21: TMenuItem;
    CO31: TMenuItem;
    CO41: TMenuItem;
    CO51: TMenuItem;
    CO61: TMenuItem;
    CO71: TMenuItem;
    CO81: TMenuItem;
    CO91: TMenuItem;
    CO101: TMenuItem;
    GrandPanel: TPanel;
    FenRich: TRichEdit;
    SplitterV: TSplitter;
    ScrollBoxSig: TScrollBox;
    GroupBoxAcc: TGroupBox;
    Label2: TLabel;
    EditAdresse: TEdit;
    ButtonDroit: TButton;
    ButtonDevie: TButton;
    GroupBoxTrains: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    LabelFonction: TLabel;
    Label6: TLabel;
    SBMarcheArretLoco: TSpeedButton;
    loco: TButton;
    EditAdrTrain: TEdit;
    EditVitesse: TEdit;
    ComboTrains: TComboBox;
    EditNumFonction: TEdit;
    ButtonFonction: TButton;
    EditFonc01: TEdit;
    TrackBarVit: TTrackBar;
    Panel1: TPanel;
    Label1: TLabel;
    LabelNbTrains: TLabel;
    BoutonRaf: TButton;
    ButtonArretSimu: TButton;
    ButtonAffTCO: TButton;
    ButtonLanceCDM: TButton;
    ButtonLocCV: TButton;
    BoutonRazTrains: TButton;
    ButtonAffAnalyseCDM: TButton;
    ButtonCDM: TButton;
    GroupBoxCV: TGroupBox;
    Label3: TLabel;
    LabelVCV: TLabel;
    ButtonEcrCV: TButton;
    ButtonLitCV: TButton;
    EditCV: TEdit;
    EditVal: TEdit;
    Affichagenormal1: TMenuItem;
    N14: TMenuItem;
    Sauvegarderla1: TMenuItem;
    ClientSocketCde1: TClientSocket;
    ClientSocketCde2: TClientSocket;
    EditEnvoi: TEdit;
    ButtonEnv: TButton;
    N15: TMenuItem;
    outslectionner1: TMenuItem;
    Copierltatdesaiguillageseninitialisation1: TMenuItem;
    ServerSocket: TServerSocket;
    Listedesclientsconnects1: TMenuItem;
    Horaires1: TMenuItem;
    Horloge1: TMenuItem;
    Ficheshoraires1: TMenuItem;
    Validationdeshoraires1: TMenuItem;
    LabelClock: TLabel;
    Ini1: TMenuItem;
    N16: TMenuItem;
    Afficherlhorloge1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure RecuInterface(Sender: TObject);
    procedure RecuPeriph1(Sender: TObject);
    procedure RecuPeriph2(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonDroitClick(Sender: TObject);
    procedure EditvalEnter(Sender: TObject);
    procedure BoutonRafClick(Sender: TObject);
    procedure ClientSocketInterfaceError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketInterfaceRead(Sender: TObject; Socket: TCustomWinSocket);
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
    procedure ClientSocketInterfaceConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCDMConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCDMRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ConnecterCDMrailClick(Sender: TObject);
    procedure DeconnecterCDMRailClick(Sender: TObject);
    procedure ClientSocketCDMDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure CodificationdessignauxClick(Sender: TObject);
    procedure ClientSocketInterfaceDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FichierSimuClick(Sender: TObject);
    procedure ButtonEcrCVClick(Sender: TObject);
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
    procedure VrifierlacohrenceClick(Sender: TObject);
    procedure FenRichMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonLocCVClick(Sender: TObject);
    procedure ComboTrainsChange(Sender: TObject);
    procedure ButtonFonctionClick(Sender: TObject);
    procedure Etatdeszonespartrain1Click(Sender: TObject);
    procedure Demanderlaversiondelacentrale1Click(Sender: TObject);
    procedure Demandetatdesaiguillages1Click(Sender: TObject);
    procedure RepriseDCC1Click(Sender: TObject);
    procedure BoutonRazTrainsClick(Sender: TObject);
    procedure Demandetataccessoires1Click(Sender: TObject);
    procedure LancerCDMrail1Click(Sender: TObject);
    procedure TrackBarVitChange(Sender: TObject);
    procedure EditVitesseChange(Sender: TObject);
    procedure ButtonEnvClick(Sender: TObject);
    procedure Placerlestrains1Click(Sender: TObject);
    procedure Demandetatdtecteurs1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Informationsdusignal1Click(Sender: TObject);
    procedure Evenementsdetecteurspartrain1Click(Sender: TObject);
    procedure RazResaClick(Sender: TObject);
    procedure SBMarcheArretLocoClick(Sender: TObject);
    procedure EditAdrTrainChange(Sender: TObject);
    procedure SplitterVMoved(Sender: TObject);
    procedure PopupMenuSignalPopup(Sender: TObject);
    procedure Vrifiernouvelleversion1Click(Sender: TObject);
    procedure Analyser1Click(Sender: TObject);
    procedure Coller1Click(Sender: TObject);
    procedure ButtonAffAnalyseCDMClick(Sender: TObject);
    procedure Affiche_fenetre_CDMClick(Sender: TObject);
    procedure AffichertouslesTCO1Click(Sender: TObject);
    procedure Mosaquehorizontale1Click(Sender: TObject);
    procedure Mosaqueverticale1Click(Sender: TObject);
    procedure Mosaiquecarre1Click(Sender: TObject);
    procedure AfficherTCO11Click(Sender: TObject);
    procedure AfficherTCO21Click(Sender: TObject);
    procedure AfficherTCO41Click(Sender: TObject);
    procedure AfficherTCO51Click(Sender: TObject);
    procedure AfficherTCO61Click(Sender: TObject);
    procedure AfficherTCO71Click(Sender: TObject);
    procedure AfficherTCO81Click(Sender: TObject);
    procedure AfficherTCO91Click(Sender: TObject);
    procedure AfficherTCO101Click(Sender: TObject);
    procedure AfficherTCO31Click(Sender: TObject);
    procedure NouveauTCO1Click(Sender: TObject);
    procedure CO11Click(Sender: TObject);
    procedure CO21Click(Sender: TObject);
    procedure CO31Click(Sender: TObject);
    procedure CO41Click(Sender: TObject);
    procedure CO51Click(Sender: TObject);
    procedure CO61Click(Sender: TObject);
    procedure CO71Click(Sender: TObject);
    procedure CO81Click(Sender: TObject);
    procedure CO91Click(Sender: TObject);
    procedure CO101Click(Sender: TObject);
    procedure ButtonCDMClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Affichagenormal1Click(Sender: TObject);
    procedure Sauvegarderla1Click(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure ClientSocketCde1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCde1Error(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ClientSocketCde1Read(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCde2Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCde2Error(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ClientSocketCde2Read(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Toutslectionner1Click(Sender: TObject);
    procedure Copierltatdesaiguillageseninitialisation1Click(
      Sender: TObject);
    procedure ServerSocketAccept(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Listedesclientsconnects1Click(Sender: TObject);
    procedure Horloge1Click(Sender: TObject);
    procedure Ficheshoraires1Click(Sender: TObject);
    procedure Validationdeshoraires1Click(Sender: TObject);
    procedure Ini1Click(Sender: TObject);
    procedure Afficherlhorloge1Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure DoHint(Sender : Tobject);
    procedure WindowPosChanging(var Msg: TWMWindowPosMsg);  message WM_WINDOWPOSCHANGING;
  public
    { Déclarations publiques des composants dynamiques}
    Procedure ImageOnClick(Sender : TObject);
    procedure ProcOnMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure proc_checkBoxFB(Sender : Tobject);
    procedure proc_checkBoxFV(Sender : Tobject);
    procedure proc_checkBoxFR(Sender : Tobject);
    procedure procAide(Sender : Tobject);
  end;


const
titre='Signaux complexes GL ';
MaxAcc=1024;          // adresse maxi d'accessoire XpressNet (testé à la LH100)
NbMaxDet=2048;        // indice maximal de détecteurs d'un réseau
Max_Trains=100;       // nombre maximal de train de CDM ou déclarés ou en circulation
MaxZones=250;         // nombre de zones de détecteurs activés par les trains
MaxTrainZone=40;      // nombre maximal de trains pour le tableau d'historique des zones
Mtd=128;              // nombre maxi de détecteurs précédents stockés
Max_event_det=4000;   // nombre maximal d'évenements détecteurs
Max_actionneurs=100;  // nombre maximal d'actionneurs
Maxelements=100;      // nombre maxi d'éléments scannés/réservés
MaxBranches=200;      // nombre maxi de branches
MaxElBranches=200;    // nombre maxi d'éléments par branche
NbreMaxiAiguillages=MaxAcc; // nombre maxi d'aiguillages
NbreMaxiSignaux=200;  // nombre maxi de signaux
NbreMaxiDecPers=10;   // nombre maxi de décodeurs personnalisés
NbMaxi_Periph=10;     // nombre maxi de périphériques COM/USB/Socket
LargImg=50;HtImg=91;  // Dimensions image des signaux (le plus grand, le 9 feux)
MaxComUSBPeriph=2;    // Nombre maxi d'objets périphériques périphériques USB Tmscom
MaxComSocketPeriph=2; // Nombre maxi d'objets périphériques périphériques socket TClientsocket
const_droit=2;        // positions aiguillages transmises par la centrale LENZ
const_devie=1;        // positions aiguillages transmises par la centrale LENZ
const_devieG_CDM=3;   // positions aiguillages transmises par cdm
const_devieD_CDM=2;   // positions aiguillages transmises par cdm
const_droit_CDM=0;    // positions aiguillages transmises par cdm
const_inconnu=9;      // position inconnue
IdClients=10;         // Index maxi de clients
NbCouleurTrain=8;
MaxCdeDccpp=20;
couleurTexte=$A0FFFF;
clRose=$AAAAFF;
clCyan=$FFA0A0;
clviolet=$FF00FF;
GrisF=$191919;
clOrange=$0077FF;
couleurTrain : array[0..NbCouleurTrain] of Tcolor = (clRose,clYellow,clLime,ClCyan,clAqua,clFuchsia,clLtGray,clred,clWhite);
Max_Simule=10000;
Max_Event_det_tick=30000;
EtatSign : array[0..13] of string[20] =('carré','sémaphore','sémaphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');

// texte de la combo box des signaux - attention ce n'est pas l'index de Signaux[x].aspect!!
Aspects : array[0..11] of string[20]=('2 feux','3 feux','4 feux','5 feux','7 feux','9 feux','Directionnel 2 feux','Directionnel 3 feux','Directionnel 4 feux',
                                     'Directionnel 5 feux','Directionnel 6 feux','Signal belge type 1');

// combinaisons possibles des états français
Etats : array[0..20] of string[30]=('Non commandé',
                                    'carré','sémaphore','sémaphore cli','vert','vert cli','violet','blanc','blanc cli','jaune','jaune cli',
                                    'ralen 30','ralen 60','rappel 30','rappel 60','ralen 60 + jaune cli','rappel 30 + jaune','rappel 30 + jaune cli',
                                    'rappel 60 + jaune','rappel 60 + jaune cli','reserve');

// combinaisons possibles des états belges
EtatSignBelge: array[0..9] of string[30]=
                                   ('Non commandé','vert jaune horizontal','rouge','vert','vert jaune vertical','rouge blanc',
                                    'deux jaunes','Chiffre','Chevron','Clignote');

// conversion index et Signaux[aspect]
//             index  aspect
// 2feux        0      2
// 3feux        1      3
// 4feux        2      4
// 5feux        3      5
// 7feux        4      7
// 9feux        5      9
// dir2 feux    6     12
// dir3 feux    7     13
// dir4 feux    8     14
// dir5 feux    9     15
// dir6 feux   10     16
// belge       11     20




type
Tinterface    = (_interface,periph1,periph2);   // interface USB : interface vers centrale, périphérique 1 ou 2
Taccessoire   = (aigP,signal);    // aiguillage ou signal
TEquipement   = (rien,aig,tjd,tjs,triple,det,buttoir,voie,crois,act);   // voie uniquement pour le tco
TBranche      = record
                  BType : Tequipement ;   // ne prend que les valeurs suivantes: dét aig Buttoir
                  Adresse : integer ;     // adresse du détecteur ou de l'aiguillage
                end;

Taiguillage = record
                Adresse : integer;         // adresse de l'aiguillage
                AncienAdresse : integer;
                modele : TEquipement;      // rien, aig, tjd ...
                position,                  // position actuelle : 1=dévié  2=droit (centrale LENZ)
                posInit,                   // position d'initialisation 1=dévié 2=droit 9=non positionné
                Adrtriple,                 // 2eme adresse pour un aiguillage triple
                temps,                     // temps de pilotage (durée de l'impulsion en x 100 ms
                InversionCDM : integer ;   // pour les aiguillages déclarés inversés dans CDM, utilisé en mode autonome (paramètre I1)
                vitesse : integer;         // vitesse de franchissement de l'aiguillage en position déviée (60 ou 90)
                AdrTrain : integer;        // adresse du train qui a réservé l'aiguillage
                ADroit : integer ;         // adresse (TJD:identifiant extérieur) connecté sur la position droite en talon
                ADroitB : char ;           // P D S Z
                ADevie : integer ;         // adresse (TJD:identifiant extérieur) adresse de l'élément connecté en position déviée
                ADevieB : char;            // caractère (D ou S)si aiguillage de l'élément connecté en position déviée
                APointe : integer;         // adresse de l'élément connecté en position droite ;
                APointeB : char;           // P D S Z
                DDroit : integer;          // destination de la TJD en position droite
                DDroitB : char ;
                DDevie : integer;          // destination de la TJD en position déviée ou 2eme adresse de la TJD
                DDevieB : char ;
                tjsint   : integer;        // pour TJS
                tjsintb  : char ;
                // éléments connectés sur la branche déviée 2 (cas d'un aiguillage triple)
                Adevie2 : integer;         // aiguilage triple
                Adevie2B : char ;
                // états d'une TJD (2 ou 4, 4 par défaut)
                EtatTJD : integer;

                // si modifié en mode config
                modifie : boolean ;
                NumBranche,IndexBranche : integer;  // index dans les branches
                AdrCDM : integer; // adresse de l'aiguillage dans CDM, si c'est une BDJ (bretelle double jonction)
              end;
TtabloDet = array[1..Mtd] of integer;
TSignal = record
                 adresse, aspect : integer;  // adresse du signal, aspect (2 feux..9 feux 12=direction 2 feux .. 16=direction 6 feux)  (11=signal belge 1)
                 Img : TImage;               // Pointeur sur structure TImage du feu
                 Lbl : TLabel;               // pointeur sur structure Tlabel du feu
                 checkFB : TCheckBox;        // pointeur sur structure Checkbox "demande feu blanc"
                 checkFR : boolean;          // demande feu rouge cli
                 checkFV : boolean;          // demande feu vert cli
                 FeuVertCli : boolean ;      // avec checkbox ou pas
                 FeuRougeCli : boolean ;     // avec checkbox ou pas
                 contrevoie : boolean;       // signal de contrevoie (SNCB)
                 Verscontrevoie : boolean;   // signal vers contrevoie (SNCB)
                 FeuBlanc : boolean ;        // avec checkbox ou pas
                 decodeur : integer;         // type du décodeur  // 'rien','DigitalBahn','CDF','LS-DEC-SNCF','LEB','Digikeijs','Unisemaf','SR','Arcomora',LS_DEC_NMBS,Bmodels, puis les perso
                 Adr_det1 : integer;         // adresse du détecteur1 sur lequel il est implanté
                 Adr_det2 : integer;         // adresse du détecteur2 sur lequel il est implanté (si un signal est pour plusieurs voies)
                 Adr_det3 : integer;         // adresse du détecteur3 sur lequel il est implanté (si un signal est pour plusieurs voies)
                 Adr_det4 : integer;         // adresse du détecteur4 sur lequel il est implanté (si un signal est pour plusieurs voies)
                 Adr_el_suiv1 : integer;     // adresse de l'élément1 suivant voie 1
                 Adr_el_suiv2 : integer;     // adresse de l'élément2 suivant voie 2 (si un signal est pour plusieurs voies)
                 Adr_el_suiv3 : integer;     // adresse de l'élément3 suivant voie 3 (si un signal est pour plusieurs voies)
                 Adr_el_suiv4 : integer;     // adresse de l'élément4 suivant voie 4 (si un signal est pour plusieurs voies)
                 Btype_suiv1 : TEquipement ; // type de l'élément suivant voie 1 - Ne prend que les valeurs rien, det ou aig
                 Btype_suiv2 : TEquipement ; // type de l'élément suivant voie 2 - Ne prend que les valeurs rien, det ou aig
                 Btype_suiv3 : TEquipement ; // type de l'élément suivant voie 3 - Ne prend que les valeurs rien, det ou aig
                 Btype_suiv4 : TEquipement ; // type de l'élément suivant voie 4 - Ne prend que les valeurs rien, det ou aig
                 VerrouCarre : boolean ;     // si vrai, le feu se verrouille au carré si pas de train avant le signal
                 EtatVerrouCarre : boolean ; // si vrai, le feu est verrouillé au carré
                 modifie     : boolean;      // feu modifié
                 EtatSignal  : word  ;       // état du signal
                 AncienEtat  : word  ;       // ancien état du signal
                 AncienAff   : word  ;       // état ancien affichage
                 UniSemaf : integer ;        // définition supplémentaire de la cible pour les décodeurs UNISEMAF
                 AigDirection : array[1..7] of array of record        // pour les signaux directionnels : contient la liste des aiguillages associés
                                  Adresse : integer;     // 6 feux max associés à un tableau dynamique décrivant les aiguillages +1 position 0
                                  posAig  : char;
                                end;
                 CondCarre : array[1..6] of array of record  // conditions supplémentaires d'aiguillages en position pour le carré
                                  // attention les données sont stockées en adresse 1 du tableau dynamique
                                  Adresse : integer;    // aiguillage
                                  posAig : char;
                               end;
                 CondFeuBlanc : array[1..6] of array of record  // conditions supplémentaires d'aiguillages en position pour le blanc
                                  // attention les données sont stockées en adresse 1 du tableau dynamique
                                  Adresse : integer;    // aiguillage
                                  posAig : char;
                               end;
                 SR : array[1..19] of record   // configuration des sorties du décodeur Stéphane Ravaut ou digikeijs ou cdf pour chacun des 19 états
                                   sortie1,sortie0 : integer;     // ex SR[1]=[carre] (voir tableau Etats)
                                   end;
                 Na : integer;               // nombre d'adresses du signal occupées par le décodeur CDF/SR/digikeijs/Belge
                 DetAmont : TtabloDet;       // tableau des détecteurs amonts, calculés à la lecture du fichier de config
               end;

TPeripherique = record
                  nom : string;              // nom du périphérique
                  NumCom : integer;          // numéro de port COM si c'est une liaison com usb
                  portouvert : boolean;      // si le port COM est ouvert
                  numComposant : integer ;   // numéro de composant MSCOM ou clientSocket
                  ScvAig,ScvDet,ScvAct,ScvVis,cr,dtr,rts : boolean ;  // services, visible, avecCR ...
                  protocole,tamponRX : string; // protocole COM ou socket, tanpon de réception
                end;

var
  maxaiguillage,detecteur_chgt,Temps,Tempo_init,Suivant,ntrains,MaxPortCom,
  N_Cv,index_simule,NDetecteurs,N_Trains,N_routes,espY,Tps_affiche_retour_dcc,
  NbreImagePligne,NbreBranches,Index2_aig,branche_det,ntrains_cdm,
  I_simule,maxTablo_act,NbreVoies,El_suivant,N_modules_dcc,NbDet1,ncrois,
  tempsCli,NbreSignaux,pasreponse,AdrDevie,fenetre,Tempo_Aig,Tempo_Signal,etat_init_interface,
  NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
  Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,NbrePN,ServeurInterfaceCDM,index_couleur,
  ServeurRetroCDM,TailleFonte,Nb_Det_Dist,Tdoubleclic,algo_Unisemaf,fA,fB,
  etape,idEl,avecRoulage,intervalle_courant,filtrageDet0,SauvefiltrageDet0,
  TpsTimeoutSL,formatY,OsBits,NbreDecPers,NbDecodeur,NbDecodeurdeBase,
  LargeurF,HauteurF,OffsetXF,OffsetYF,PosSplitter,NbPeriph,NbPeriph_COMUSB,NbPeriph_Socket,
  AigMal,AncMinute,axFP,ayFP : integer;

  ack,portCommOuvert,traceTrames,AffMem,CDM_connecte,dupliqueEvt,affiche_retour_dcc,
  Raz_Acc_signaux,AvecInit,AvecTCO,terminal,Srvc_Aig,Srvc_Det,Srvc_Act,MasqueBandeauTCO,
  Srvc_Pos,Srvc_Sig,debugtrames,LayParParam,AvecFVR,InverseMotif,Srvc_tdcc,
  Hors_tension,traceSign,TraceZone,parSocketLenz,ackCdm,PremierFD,doubleclic,
  NackCDM,MsgSim,StopSimu,succes,recu_cv,AffAigDet,AffTiers,AvecDemandeAiguillages,
  TraceListe,clignotant,nack,Maj_signaux_cours,configNulle,LanceCDM,AvecInitAiguillages,
  AvecDemandeInterfaceUSB,AvecDemandeInterfaceEth,aff_acc,affiche_aigdcc,modeStkRetro,
  retEtatDet,roulage,init_aig_cours,affevt,placeAffiche,clicComboTrain,clicAdrTrain,
  fichier_module_cdm,Diffusion,cdmDevant,avecRESA,serveurIPCDM_Touche,
  sombre,serveur_ouvert,pasChgTBV,FpBouge,debugPN : boolean;

  tick,Premier_tick : longint;

  MSCommUSBInterface,MsCommCde1,MsCommCde2 : TMSComm;

  CDMhd : THandle;

  FormPrinc: TFormPrinc;

  Enregistrement,chaine_Envoi,chaine_recue,Id_CDM,Af,version_Interface,entete,suffixe,Lay,
  CheminProgrammes,cheminWin,fichierAide : string;

  Ancien_detecteur : array[0..NbMaxDet] of boolean;   // anciens état des détecteurs et adresses des détecteurs et leur état
  detecteur : array[0..NbMaxDet] of  // détecteurs indexés par l'adresse
  record
    Etat : boolean;          // état 0/1 du détecteur
    Train : string;          // nom du train ayant enclenché le détecteur (CDM - pas fiable)
    AdrTrain : integer;      // adresse du train "train"
    IndexTrain : integer;    // index du train
    Tempo0   : integer;      // tempo de retombée à 0 du détecteur (filtrage)
    NumBranche,IndexBranche : integer; // où se trouve le détecteur dans les branches
  end;
  Adresse_detecteur : array[0..NbMaxDet] of integer; // adresses des détecteurs par index

  Ecran : array[1..10] of record     // écrans du pc
            x0,y0,larg,haut : integer;
          end;

  Liste_clients : array[0..IdClients] of record
                    adresse : string;
                    PortDistant,PortLocal : integer;
                  end;

  TypeGen : TEquipement;

  // Historique des zones d'occupation par train
  TrainZone : array[1..MaxTrainZone] of  // train, index
              record
                train : string;
                adrTrain : integer; // adresse du train
                Nbre : integer;     // nombre de zones (ci dessous)
                Zone : array[1..MaxZones] of record det1,det2 : integer; end;
              end;

  // tableau des évènements détecteurs , aiguillages, actionneurs
  event_det_tick : array[0..Max_Event_det_tick] of
  record
    tick : longint;
    adresse : integer ;
    train : integer;        // numéro du train si détecteur
    modele : Tequipement ;  // détecteur, aiguillage, actionneur
    etat : integer ;        // état du détecteur de l'aiguillage ou de l'actionneur
    reaffecte : integer ;   // =1 réaffecté au bon train dans le cas de 2 détecteurs contigus qui ne s'enchainent pas bien =2 réaffecté par changement aiguillage
  end;

  tablo_Index_Signal : array[0..MaxAcc] of integer; // tableau d'index des accessoires signaux sur le bus DCC
  tablo_Index_Aiguillage : array[0..MaxAcc] of integer; // tableau d'index des aiguillages sur le bus DCC

  // tableau des périphériques
  Tablo_periph : array[1..NbMaxi_Periph] of TPeripherique;

  // Zones d'occupations actuelles
  MemZone : array[0..NbMaxDet,0..NbMaxDet] of
  record
    etat : boolean;  // mémoires de zones des détecteurs
    train : string;
    IndexTrain,      // index du tableau de tous les trains
    AdrTrain : integer;
  end;

  Tablo_actionneur : array[0..Max_actionneurs] of
  record
    loco,act,son,periph,vit : boolean;     // destinataire loco acessoire son ou périphérique ou vitesse train
    adresse,adresse2,                      // adresse: adresse de base ou heure ; adresse2=cas d'une Zone  ou minute
    etat,
    fonction,                              // fonction F de train ou périphérique ou vitesse train
    tempo,TempoCourante,
    accessoire,sortie,
    typdeclenche            : integer;     // déclencheur: 0=actionneur/détecteur 1=Horloge 2=evt aig  3=MemZone
    Raz                     : boolean;
    FichierSon,trainDecl,
    TrainDest,                             // train destinataire ou Commande au périphérique
    TrainCourant            : string;
  end;

  // décodeurs personnalisés de signaux
  decodeur_pers : array[1..NbreMaxiDecPers] of
  record
    nom                    : string;
    NbreAdr,
    nation                 : integer;      // 1=FR  2=BE
    commande               : integer;      // =0 pilotage par centrale  =1 pilotage par périphérique COM/USB/Socket
    Peripherique : integer;                // numéro du périphérique
    desc : array[1..20] of                 // Description des 20 états. Index=adresse d'offset
    record
      etat1,etat2,                         // états (rouge, sémaphore etc)
      offsetAdresse,                       // décalage d'adresse des deux sorties
      sortie1,sortie2       : integer;     // valeur des deux sorties pour les états
      Chcommande            : string;      // si commande com/usb/socket
    end;
  end;

  Ancien_actionneur : array[0..MaxAcc] of integer;

  KeyInputs: array of TInput;
  Tablo_PN : array[0..Max_actionneurs] of
  record
    AdresseFerme  : integer;  // adresse de pilotage DCC pour la fermeture  ou numéro de périphérique pour pilotage usb
    commandeFerme : integer;  // commande de fermeture (1 ou 2)
    AdresseOuvre  : integer;  // adresse de pilotage DCC pour l'ouverture
    commandeOuvre : integer;  // commande d'ouverture (1 ou 2)
    NbVoies       : integer;  // Nombre de voies du PN
    Pulse         : integer;  // 0=commande maintenue  1=Impulsionnel
    TypeCde       : integer;  // 0=par accessoire / 1=par COMUSB ou sockets
    commandeF,CommandeO : string; // commande pour com/usb ou socket
    compteur      : integer;  // comptage actionneurs fermeture et décomptage actionneurs ouverture
    actionneur    : boolean;  // =vrai par actionneur sinon pae zone
    Voie : array [1..5] of record
             ActFerme,ActOuvre : integer ; // actionneurs provoquant la fermeture et l'ouverture
             detZ1F,detZ2F,detZ1O,detZ2O : integer; // Zones de détection
           end;
  end;

  Tablo_Simule : array[0..Max_Simule] of
  record
    tick : longint;
    modele : Tequipement;
    Adresse,etat : integer ;
    train : string;
  end;

  tablo_CV : array [1..255] of integer;
  couleur,Couleurfond : Tcolor;

  // modélisations des fichiers config
  branche : array [1..MaxBranches] of string;

  // Pour les tableaux aiguillage et signaux : l'indice du tableau aiguillage n'est pas son adresse
  // ils sont stockés dans les tableaux tablo_Index_Signal[adresse]=index  et tablo_Index_Aiguillage[adresse]=index
  Aiguillage : array[0..NbreMaxiAiguillages] of Taiguillage;
  // signaux - L'index du tableau n'est pas son adresse
  Signaux :  array[0..NbreMaxiSignaux] of TSignal;

  CdeDccpp : array[1..MaxCdeDccpp] of string;

  trains_cdm : array[1..Max_Trains] of record
              nom_train : string;
              adresse,vitmax : integer;
           end;

  // trains en roulage sur le réseau et de la base de données [section_trains]
  trains : array[0..Max_Trains] of record
              nom_train : string;
              adresse,vitmax,VitNominale,VitRalenti : integer;
              vitesse : integer;                // vitesse actuelle de pilotage
              sens   : boolean;                 // sens de déplacement
              compteur_consigne : integer;      // compteur de consigne pour envoyer deux fois la vitesse en 10eme de s
              TempoArret : integer;             // tempo d'arret pour le timer
              TempoDemarre : integer;           // tempo de démarrage
              index_event_det_train : integer;  // index du train en cours de roulage du tableau event_det_train
              roulage : boolean;                // train en roulage
              //-----------------------------------
              SbitMap : TBitmap ;               // pointeur sur tampon sous l'icone de déplacement du train en page CDM
              ax,ay,x,y : integer;              // coordonnées du train (anciennes et nouvelles) en points windows
              x0,y0,x1,y1 : integer;            // ancien contour du tampon, pour l'animation dans la fenêtre cdm
           end;

  // éléments scannés et/ou verrouillés
  elements : array[1..Maxelements] of
             record
               adresse : integer;
               typ : Tequipement;
             end;

  // liste des trains placés
  Placement : array[1..10] of
              record
                train : string;
                detecteur,detdir : integer;
                inverse : boolean;
              end;

  // liste des évènements détecteurs
  event_det : array[1..Max_event_det] of
              record
                adresse : integer;
                etat : boolean;
              end;

  event_det_train : array[0..Max_Trains] of record
                    NbEl : integer;               // nombre d'éléments dans le tableau ci-dessous
                    AdrTrain : integer;
                    signal_rouge : integer ;      // adresse du signal si le train est arreté sur un signal au rouge (carré sémaphore violet)
                    nom_train : string;           // nom du train
                    suivant : integer;            // suivant prévisionnel à det1 et det2
                    Det : array[1..2] of record   // tableau des evts détecteurs par train
                       adresse : integer;
                       etat : boolean;
                       end;
                    end;

  decodeur : array[0..30] of string[20];

  Signal_supprime,Signal_sauve : TSignal;
  Aig_supprime,Aig_sauve : TAiguillage;
  BrancheN : array[1..MaxBranches,1..MaxElBranches] of TBranche;

{$R *.dfm}

// utilisation des procédures et fonctions dans les autres unités
function Index_Signal(adresse : integer) : integer;
function Index_Aig(adresse : integer) : integer;
procedure dessine_signal2(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_signal3(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_signal4(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_signal5(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_signal7(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
procedure dessine_signal9(Acanvas : Tcanvas;x,y : integer;frX,frY : real;etatsignal : word;orientation : integer);
procedure dessine_signal20(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation,adresse : integer);
procedure dessine_dirN(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation,N : integer);
procedure Maj_Etat_Signal(adresse,aspect : integer);
procedure Maj_Etat_Signal_Belge(adresse,aspect : integer);
procedure Affiche(s : string;lacouleur : TColor);
procedure envoi_signal(Adr : integer);
procedure pilote_direction(Adr,nbre : integer);
procedure connecte_USB;
function connecte_usb_periph(index : integer) : boolean;
procedure deconnecte_usb_periph(index : integer);
function connecte_socket_periph(index : integer) : boolean;
procedure deconnecte_socket_periph(index : integer);
procedure deconnecte_usb;
function IsWow64Process: Boolean;
procedure Dessine_signal_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : real;adresse : integer;orientation : integer);
procedure Pilote_acc0_X(adresse : integer;octet : byte);
Function pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire) : boolean;
function etat_signal_suivant(Adresse,rang : integer;var AdrSignalsuivant : integer) : integer;
function suivant_alg3(prec : integer;typeELprec : TEquipement;actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
function test_memoire_zones(adresse : integer) : boolean;
function PresTrainPrec(Adresse,NbCtSig : integer;detect : boolean;var AdrTr,voie : integer) : boolean;
function cond_carre(adresse : integer) : boolean;
function carre_signal(adresse,TrainReserve : integer;var reserveTrainTiers : boolean;Var AdrTrain : integer) : integer;
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
procedure Event_act(adr,adr2,etat : integer;trainDecl : string;hor : boolean);
function verif_UniSemaf(adresse,UniSem : integer) : integer;
function Select_dessin_Signal(TypeSignal : integer) : TBitmap;
procedure cree_image(rang : integer);
procedure trouve_aiguillage(adresse : integer);
procedure trouve_detecteur(detecteur : integer);
function ProcessRunning(sExeName: String) : Boolean;
Procedure Raz_tout;
Function chaine_CDM_Acc(adresse,etat : integer) : string;
Function Checksum(s : string) : string;
function envoi(s : string) : boolean;
procedure init_dccpp;
procedure init_aiguillages;
function index_adresse_detecteur(de : integer) : integer;
function index_train_adresse(adr : integer) : integer;
procedure vitesse_loco(nom_train :string;index : integer;adr_loco : integer;vitesse : integer;repetition : boolean);
procedure Maj_Signaux(detect : boolean);
procedure Det_Adj(adresse : integer);
procedure reserve_canton(detecteur1,detecteur2,adrtrain,NumTrain,NCantons : integer);
function signal_detecteur(detecteur : integer) : integer;
function det_suiv_cont(det1,det2,alg : integer) : integer;
function BTypeToChaine(BT : TEquipement) : string;
function testBit(n : word;position : integer) : boolean;
procedure det_contigu(det1,det2 : integer;var suivant : integer;var ElSuiv : TEquipement);
Function SetBit(n : word;position : integer) : word;
Function RazBit(n : word;position : integer) : word;
procedure inverse_image(imageDest,ImageSrc : Timage) ;
function extract_int(s : string) : integer;
Procedure Menu_tco(i : integer);
procedure Affiche_Fenetre_TCO(i : integer;laisseOuvert : boolean);
procedure positionne_elements(i : integer);
procedure ouvre_pn_usb(i : integer);
procedure ferme_pn_usb(i : integer);
procedure ouvre_pn_socket(i : integer);
procedure ferme_pn_socket(i : integer);
function com_socket(i : integer) : integer;
procedure liste_portcom;
procedure mosaiqueH;
procedure mosaiqueV;
function InfoSignal(adresse : integer) : string;
procedure det_prec_signal(adresse : integer;var tabloDet : TTabloDet);
procedure composant(c : tComponent;fond,texte : tColor);
procedure maj_couleurs;
procedure AffTexteIncliBordeTexture(c : TCanvas; x,y : integer; Fonte : tFont;
                                    clBord : TColor; EpBord : integer; PenMode : TPenMode;
                                    Texture : tBitMap; texte : string; AngleDD : longint);
procedure change_style;
function isDirectionnel(index : integer) : boolean;
procedure stop_trains;
function Aiguille_deviee(adresse : integer) : integer ;
function envoi_CDM(s : string) : boolean;
function place_id(s : string) : string;
procedure fin_preliminaire;

implementation

uses UnitDebug, UnitPilote, UnitSimule, UnitTCO, UnitConfig,
  Unitplace, verif_version , UnitCDF, UnitAnalyseSegCDM, UnitConfigCellTCO,
  UnitConfigTCO,UnitSR,  UnitHorloge,  UnitFicheHoraire,  UnitClock;

{
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
}

// change le style en fonction de Style_aff pour Delphi11 (compilateur>=28)
// Cette procédure doit être appellée depuis le module principal UnitPrinc sinon exception violation
procedure change_style;
var i : integer;
begin
  {$IF CompilerVersion >= 28.0}
  if Ancien_Style<>Style_Aff then
  begin
    TStyleManager.TrySetStyle(TStyleManager.StyleNames[0]);   // repasse en windows (style 0) pour éviter exception
    TStyleManager.TrySetStyle(TStyleManager.StyleNames[Style_Aff]);    // passe dans le style demandé
    // repasser certains composants dans le style windows permet que le composant affiche en couleurs
    Formprinc.FenRich.StyleName:='Windows';
    if formDebug<>nil then
    begin
      FormDebug.RichDebug.StyleName:='Windows';
      formDebug.MemoEvtDet.StyleName:='Windows';
    end;
    if formConfig<>nil then
    begin
      FormConfig.RichBranche.StyleName:='Windows';
      FormConfig.RichCdeDccpp.StyleName:='Windows';
    end;
    for i:=1 to NbreTCO do
    begin
      if FormTCO[i]<>nil then FormTCO[i].ScrollBox.StyleName:='Windows';
    end;
    Ancien_style:=Style_aff;
  end;
  {$IFEND}
end;

procedure positionne_principal;
begin
// positionnement de la fenêtre principale
  with formprinc do
  begin
    position:=poDefault;

    if AffMemoFenetre=1 then
    begin
      if largeurF>0 then formPrinc.width:=LargeurF;
      if HauteurF>0 then formPrinc.Height:=hauteurF;
      formPrinc.left:=offsetXF;
      formPrinc.top:=offsetYF;

      if (PosSplitter>0) and (PosSPlitter<formPrinc.Width) then
      begin
        fenRich.Width:=PosSplitter;
        positionne_elements(PosSplitter);
      end;
    end
    else
    begin
      formprinc.width:=1100;
      formPrinc.Height:=700;
      formPrinc.Left:=(Ecran[Ecran_sc].larg div 2)-(formprinc.width div 2)+Ecran[Ecran_sc].x0;
      formPrinc.Top:=(Ecran[Ecran_sc].haut div 2)-(formprinc.height div 2)+Ecran[Ecran_sc].y0;
    end;

    if fenetre=1 then Formprinc.windowState:=wsMaximized ;

    with GrandPanel do
    begin
      left:=2;
      top:=formprinc.LabelTitre.top+formprinc.LabelTitre.Height+4;;
      width:=formprinc.width-20;
      height:=formprinc.height-StatusBar1.Height-labeltitre.Height-labelTitre.top-64;
      Anchors:=[akLeft,akTop,akRight,akBottom];
    end;

    with Fenrich do
    begin
      begin
        left:=5;
        Align:=AlLeft;   // si on ne met pas Align à AlLeft, alors le splitter n'est pas accrochable
        top:=5;  // par rapport au panel
        Width:=GrandPanel.Width-Panel1.Width-GroupBoxAcc.Width-25;
        //height:=formprinc.Height-StatusBar1.Height-StaticText.Height-LabelTitre.Height-90;
        Anchors:=[akLeft,akTop,akRight,akBottom];
      end;

      with splitterV do
      begin
        Left:=FenRich.left+FenRich.Width-30;
        MinSize:=200;
        Parent:=GrandPanel;
        align:=fenrich.align;   // dessine le splitter à droite de la fenetre Fenrich
        Visible:=true;
      end;

      with ScrollBoxSig do
      begin
        Parent:=GrandPanel;
        Anchors:=[akTop,akRight,akBottom];
        width:=GrandPanel.Width-SplitterV.Width-5;
        height:=GrandPanel.Height-GroupBoxTrains.height-GroupBoxTrains.top-10;
        top:=GroupBoxTrains.Top+GroupBoxTrains.Height+5;
      end;
      positionne_elements(splitterV.left);
    end;

    if (PosSplitter>0) and (PosSPlitter<formPrinc.Width) and (AffMemoFenetre=1) then
    begin
      fenRich.Width:=PosSplitter;
      positionne_elements(PosSplitter);
    end;

    //affichage de la fenêtre principale
    show;
  end;
end;


procedure fin_preliminaire;
begin
  {$IF CompilerVersion >= 28.0}
  // en D11, obligé de positionner la fenêtre principale après avoir fixé le style
  positionne_principal;
  {$IFEND}

  calcul_pos_horloge;
  if (versionSC<>'8.53') then
  begin
    if AffHorl then Affiche_horloge;
    if LanceHorl then Demarre_horloge;
  end;
  formprinc.SetFocus;
end;

// envoi une chaine à un périphérique COM/USB en fonction de l'interface
// non utilisé
procedure envoi_usb(interf : Tinterface;s : string);
begin
  case interf of
    _interface : MSCommUSBInterface.Output:=s;
    periph1    : MSCommCde1.Output:=s;
    periph2    : MSCommCde2.Output:=s;
  end;
end;

// envoie une chaine s à un périphérique COM/USB en fonction du composant comp
// contrôle si le pointeur comp est valide par traitement de l'exception
procedure envoi_usb_comp(comp : Tmscomm;s : string);
var i : integer;
begin
  if comp=nil then
  begin
    Affiche('Erreur 600X: le composant périphérique n''est pas créé',clred);
    exit;
  end;

  try
    comp.output:=s;
  except
    on e : exception do
    begin
      Affiche(e.message+' COM'+intToSTR(comp.CommPort)+': déconnecté. Fermeture du port ',clred);
      // passe à faux les indicateurs d'ouverture du port
      if comp=MSCommUSBInterface then portCommOuvert:=false;
      for i:=1 to NbMaxi_Periph do
      begin
        if (tablo_periph[i].numComposant=1) and (comp=MSCommCde1) then tablo_periph[i].portouvert:=false;
        if (tablo_periph[i].numComposant=2) and (comp=MSCommCde2) then tablo_periph[i].portouvert:=false;
      end;
      // ferme le port
      comp.PortOpen:=false;
      Formprinc.StatusBar1.Panels[3].Text:='';
    end;
  end;
end;


procedure procetape(s : string);
begin
  if debug<>2 then exit;
  MessageDlg('Etape '+intToSTR(etape)+' '+s,mtInformation,[mbOk],0);
  inc(etape);
end;

// renvoie vrai si le signal d'index index est directionnel
function isDirectionnel(index : integer) : boolean;
var a : integer;
begin
  a:=Signaux[index].aspect;
  isDirectionnel:=(a>=12) and (a<=16);
end;

procedure Tformprinc.DoHint(Sender : Tobject);     // le sender est du type tApplication
var s,nomForm: string;
    FormeTCO : boolean;
begin
  s:=Application.Hint;       // texte du hint
  StatusBar1.Panels[0].text:=s;

  // détection d'un hint provoqué dans formtco
  NomForm:=uppercase(Screen.activeform.Name);
  formeTCO:=copy(NomForm,1,7)='FORMTCO';

  // dessine les encadrés de colonne/ligne dans le tco suivant sélection du popup menu, en fonction du hint qu'on accroche
  if formeTCO then
  begin
    // hints des colonnes
    if (s=s101) or (s=s93) or (s=s94) then
    begin
      if not(colonneAffiche) then encadre_colonne;
    end
    else if colonneAffiche then encadre_colonne;

    // hints des lignes
    if (s=s90) or (s=s91) or (s=s100) then
    begin
      if not(ligneAffiche) then encadre_ligne;
    end
    else if ligneAffiche then encadre_ligne;
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

// renvoie le 1er numéro de bit à 1 du mot (en commençant à droite)
// PremBitNum(1)=0
// PremBitNum(4)=2
// si pas de bit à 1, renvoie -1
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
  if trouve then PremBitNum:=i else PremBitNum:=-1;
end;

// conversion du motif de bits (codebin) de la configuration du signal complexe en deux mots:
// en sortie :
// premierBit : code de la signalisation
// Combine = code de la signalisation combinée
// Exemple code_to_aspect(10001000000000)  renvoie premierBit=jaune_cli (9) et Combine=rappel 60 (13)
// si pas de combinaison, renvoie -1
procedure code_to_aspect(codebin : word;var aspect,combine : integer) ;
begin
  aspect:=PremBitNum(CodeBin and $3ff);
  combine:=PremBitNum(CodeBin and $fc00);
end;

// conversion d'un état signal binaire en état unique de 1 à 19
// exemple code_to_etat(10001000000000) (jaune_cli et rappel 60) renvoie 19
function code_to_etat(code : word) : integer;
var aspect,combine : integer;    
begin
  code_to_aspect(code,aspect,combine);
  result:=9999;
  if combine=-1 then
  begin
    if aspect=0 then result:=1;  // carré
    if aspect=1 then result:=2;  // sémaphore
    if aspect=2 then result:=3;  // sémaphore cli
    if aspect=3 then result:=4;  // vert
    if aspect=4 then result:=5;  // vert cli
    if aspect=5 then result:=6;  // violet
    if aspect=6 then result:=7;  // blanc
    if aspect=7 then result:=8;  // blanc cli
    if aspect=8 then result:=9;  // jaune
    if aspect=9 then result:=10; // jaune cli
  end;   
  if aspect=-1 then
  begin
    if combine=10 then result:=11; // ralen 30
    if combine=11 then result:=12; // ralen 60
    if combine=12 then result:=14; // rappel 30
    if combine=13 then result:=15; // rappel 60           
  end;

  if (aspect=9) and (combine=11) then result:=13;   //ralen 60 + jaune cli
  if (aspect=8) and (combine=12) then result:=16;   //rappel 30 + jaune
  if (aspect=9) and (combine=12) then result:=17;   //rappel 30 + jaune cli
  if (aspect=8) and (combine=13) then result:=18;   //rappel 60 + jaune
  if (aspect=9) and (combine=13) then result:=19;   //rappel 60 + jaune cli

  code_to_etat:=result;
  {'Non commandé','carré','sémaphore','sémaphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ralen 30','ralen 60','ralen 60 + jaune cli','rappel 30','rappel 60',
               7        8         9         10         11          12               13               14         15   
           'rappel 30 + jaune','rappel 30 + jaune cli','rappel 60 + jaune','rappel 60 + jaune cli');
                     16                  17                      18                   19     }
end;

// renvoie la chaîne de l'état du signal
function chaine_signal(adresse : word) : string;
var a,i,aspect,etat,combine,nation : integer;
    s : string;
begin
  i:=Index_Signal(adresse);
  //i:=index_accessoire[adresse];
  etat:=Signaux[i].EtatSignal  ;
  nation:=1;
  a:=Signaux[i].aspect;
  if a=20 then nation:=2;

  if nation=2 then
  begin
    // en signalisation belge, on peut avoir plusieurs bits à 1 simultanément en combine
    aspect:=etat and $3f;
    combine:=etat and $1c0;
    aspect:=PremBitNum(aspect) ;
    s:=EtatSignBelge[Aspect+1];
    if combine<>0 then
    begin
      if testBit(combine,chiffre) then s:=s+'+'+EtatSignBelge[chiffre+1];
      if testBit(combine,chevron) then s:=s+'+'+EtatSignBelge[chevron+1];
    end;
    result:=s;
    exit;
  end;

  // signalisation française
  if (a>10) and (a<17) then
  begin
    // directionnel
    s:=intToSTR(etat)+' feu';
    if etat>1 then s:=s+'x';
    result:=s;
    exit;
  end;

  code_to_aspect(etat,aspect,combine);
  s:='';

  if (aspect=16) then s:='' else begin if aspect<>-1 then s:=etatSign[aspect];end;
  if combine<>16 then
  begin
    if (aspect<>16) and (combine<>-1) then
    begin
      if aspect<>-1 then s:=s+'+';
      s:=s+etatSign[combine];
    end;
  end;
  chaine_signal:=s;
end;


// dessine un cercle plein dans le signal
procedure cercle(ACanvas : Tcanvas;x,y,rayon : integer;couleur : Tcolor);
begin
  with Acanvas do
  begin
    //brush.Style:=bsSolid; 
    brush.Color:=couleur;
    pen.Color:=clBlack;
    pen.Width:=1;
    pen.Mode:=pmCopy;
    Ellipse(x-rayon,y-rayon,x+rayon,y+rayon);
  end;
end;

// dessine les 2 feux sur la cible dans le canvas spécifié
// x,y : offset en pixels du coin supérieur gauche du feu
// Acanvas : canvas de destination
// frX, frY : facteurs de réduction (pour agrandissement)
// EtatSignal : état du signal
// orientation à donner au signal : 1= vertical 2=90° à gauche  3=90° à droite  4=180°
procedure dessine_signal2(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,rayon,xViolet,YViolet,xBlanc,yBlanc,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine);
  rayon:=round(6*frX);

  // récupérer les dimensions de l'image d'origine du feu
  with Formprinc.Image2feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;

  XBlanc:=13; YBlanc:=11;
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
    // rotation 90° vers la droite des feux
    // inversion des facteurs de réduction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-XBlanc;Xblanc:=Yblanc;Yblanc:=Temp;
    Temp:=LgImage-Xviolet;Xviolet:=Yviolet;Yviolet:=Temp;
  end;

  // 180°
  if orientation=4 then
  begin
    Xblanc:=LgIMage-Xblanc;Yblanc:=HtImage-Yblanc;
    Xviolet:=LgIMage-Xviolet;Yviolet:=HtImage-Yviolet;
  end;

  XBlanc:=round(xBlanc*Frx)+x;   YBlanc:=round(Yblanc*Fry)+y;
  XViolet:=round(XViolet*FrX)+x; YViolet:=round(YViolet*FrY)+y;

  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
  cercle(ACanvas,xViolet,yViolet,rayon,GrisF);

  // allumages
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clWhite);
  if code=violet then cercle(ACanvas,xViolet,yViolet,rayon,clviolet);
end;

// dessine les feux sur une cible à 3 feux
procedure dessine_signal3x(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation,index : integer);
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xvert,Yvert,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine);
 // Affiche('nouveau='+intToSTR(Etatsignal)+' ancien='+intToSTR(ancienEtat),clred);

  rayon:=round(6*frX);

  with Formprinc.Image3feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;
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
    //rotation 90° vers la droite des signaux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
  end;

  if (orientation=4) then
  begin
    //rotation 180°
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
  end;


  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;


  if signaux[index].AncienAff<>EtatSignal then
  begin
    Affiche('efface tout',clred);
    cercle(ACanvas,xVert,yVert,rayon,GrisF);
    cercle(ACanvas,xSem,ySem,rayon,GrisF);
    cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
    signaux[index].AncienAff:=EtatSignal;
  end;

  if (code=vert_cli) and not(clignotant) then cercle(ACanvas,xVert,yVert,rayon,GrisF);
  if (code=jaune_cli) and not(clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
  if (code=semaphore_cli) and not(clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);

  if (code=vert_cli) and not(clignotant) then Affiche('efface vert',clred);
  if (code=jaune_cli) and not(clignotant) then Affiche('efface jaune',clred);
  if (code=semaphore_cli) and not(clignotant) then Affiche('efface rouge',clred);


  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,xJaune,yJaune,rayon,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clRed);
end;

// dessine les feux sur une cible à 3 feux
procedure dessine_signal3(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xvert,Yvert,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
//  Affiche('dessine_feu3',clred);
  code_to_aspect(Etatsignal,code,combine);
  //Affiche(intToSTR(ancienEtat),clred);

  rayon:=round(6*frX);

  with Formprinc.Image3feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;
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
    //rotation 90° vers la droite des signaux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
  end;

  if (orientation=4) then
  begin
    //rotation 180°
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
  end;


  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;

{  if code=jaune_CLI then Affiche('JC',clyellow);
  if code=vert_cli then Affiche('VC',clyellow);
  if code=semaphore_CLI then Affiche('SC',clyellow);

  if Anccode=jaune_CLI then Affiche('AJC',clyellow);
  if Anccode=vert_cli then Affiche('AVC',clyellow);
  if Anccode=semaphore_CLI then Affiche('ASC',clyellow);
}


  if not((code=jaune_cli) and clignotant)      then cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
  if not((code=vert_cli)  and clignotant)      then cercle(ACanvas,xVert,yVert,rayon,GrisF);
  if not((code=semaphore_cli) and clignotant)  then cercle(ACanvas,xSem,ySem,rayon,GrisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,xJaune,yJaune,rayon,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clRed);
end;


// dessine les feux sur une cible à 4 feux
// orientation=1 vertical
procedure dessine_signal4(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xcarre,Ycarre,Xvert,Yvert,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine); // et aspect
  rayon:=round(6*frX);

  with Formprinc.Image4feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;

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

  if (orientation=4) then
  begin
    //rotation 180°
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
    Xcarre:=LgImage-Xcarre;Ycarre:=HtImage-Ycarre;
  end;

  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
  Xcarre:=round(Xcarre*FrX)+x;  Ycarre:=round(Ycarre*FrY)+Y;

  // extinctions
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
procedure dessine_signal5(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,
    Temp,rayon,LgImage,HtImage,code,combine : integer;
    ech : real;

begin
  code_to_aspect(Etatsignal,code,combine); // et aspect
  rayon:=round(6*frX);
  XBlanc:=13; YBlanc:=11;
  xJaune:=13; yJaune:=55;
  Xcarre:=13; Ycarre:=22;
  XSem:=13;   Ysem:=44;
  XVert:=13;  YVert:=33;

  with Formprinc.Image5feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;
  if (orientation=2) then
  begin
    // rotation 90° vers la gauche des signaux
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
    // rotation 90° vers la droite des signaux
    // calcul des facteurs de réduction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;
  end;

  if (orientation=4) then
  begin
    //rotation 180°
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
    Xcarre:=LgImage-Xcarre;Ycarre:=HtImage-Ycarre;
    Xblanc:=LgImage-Xblanc;Yblanc:=HtImage-YBlanc;
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
procedure dessine_signal7(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Temp,rayon,LgImage,HtImage,code,combine  : integer;
    ech : real;
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

  with Formprinc.Image7feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;
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

  if (orientation=4) then
  begin
    //rotation 180°
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
    Xcarre:=LgImage-Xcarre;Ycarre:=HtImage-Ycarre;
    Xblanc:=LgImage-Xblanc;Yblanc:=HtImage-YBlanc;
    Xral1:=LgImage-Xral1;  Yral1:=HtImage-Yral1;
    Xral2:=LgImage-Xral2;  Yral2:=HtImage-Yral2;
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
procedure dessine_signal9(Acanvas : Tcanvas;x,y : integer;frX,frY : real;etatsignal : word;orientation : integer);
var rayon,
    XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Xrap1,Yrap1,Xrap2,Yrap2,Temp,LgImage,HtImage,xt,yt,code,combine  : integer;
    ech : real;
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

  with Formprinc.Image9feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;
  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux : échange des coordonnées X et Y et translation sur HtImage
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
    //rotation 90° vers la droite des feux : échange des coordonnées X et Y et translation sur LgImage
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

  if (orientation=4) then
  begin
    //rotation 180°
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
    Xcarre:=LgImage-Xcarre;Ycarre:=HtImage-Ycarre;
    Xblanc:=LgImage-Xblanc;Yblanc:=HtImage-YBlanc;
    Xral1:=LgImage-Xral1;  Yral1:=HtImage-Yral1;
    Xral2:=LgImage-Xral2;  Yral2:=HtImage-Yral2;
    Xrap1:=LgImage-Xrap1;  Yrap1:=HtImage-Yrap1;
    Xrap2:=LgImage-Xrap2;  Yrap2:=HtImage-Yrap2;
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

// Ecrire sur un canvas un texte avec un angle, avec ou sans bordure, monochrome ou à face texturée
// params : C       = Canvas-cible
//          X,Y     = Coordonnées angle supérieur gauche du début du texte.
//          Fonte   = Police de caractères à utiliser : uniquement des fontes scalables.
//          clBord  = Couleur de la bordure.
//          EpBord  = Epaisseur de la bordure.
//          PenMode = TPenMode : utiliser en général pmCopy.
//          Texture = BitMap de texture : Si Texture = Nil alors la face sera de la couleur de Fonte avec un contour de clBord si EpBord > 0.
//          Texte   = Texte à écrire.
//          AngleDD = Angle d'inclinaison en Dixièmes de degré.
procedure AffTexteIncliBordeTexture(c : TCanvas; x,y : integer; Fonte : tFont;
                                    clBord : TColor; EpBord : integer; PenMode : TPenMode;
                                    Texture : tBitMap; texte : string; AngleDD : longint);
var dc : Hdc;
    lgFont : Logfont;           // structure d'attributs de police
    AncFonte,NouvFonte : Hfont;
    AncPen,NouvPen : Hpen;
    AncBrush,NouvBrush : Hbrush;
begin
  C.Pen.Mode:=PenMode;
  dc:=C.Handle;

  // Initialisation de la fonte
  zeroMemory(@lgFont,sizeOf(lgFont));      // remplit la structure de 0
  strPCopy(lgFont.lfFaceName,Fonte.Name);  // copie la chaîne dans le nom de la fonte depuis le paramètre
  lgFont.lfHeight:=Fonte.Height;           // la taille
  if Fonte.style=[] then lgFont.lfWeight:=FW_REGULAR; // Normal
  if Fonte.style=[fsBold] then lgFont.lfWeight:=FW_BOLD;    // Gras

  if fsItalic in Fonte.style    then lgFont.lfItalic:=1;
  if fsUnderline in Fonte.style then lgFont.lfUnderline:=1;
  if fsStrikeout in Fonte.style then lgFont.lfStrikeout:=1;

  lgFont.lfEscapement:=AngleDD; // Angle d'inclinaison en dixièmes de degrés

  NouvFonte:=CreateFontInDirect(lgFont);
  AncFonte:=SelectObject(dc,NouvFonte);

  // Initialisation du contour :
  if EpBord<>0 then NouvPen := CreatePen(PS_SOLID,EpBord,clBord)
                       else NouvPen := CreatePen(PS_NULL,0,0);
  AncPen:= SelectObject(dc,NouvPen);

  // Initialisation de la couleur de la police ou de la Texture :
  if Texture=nil then NouvBrush := CreateSolidBrush(Fonte.color)
                         else NouvBrush := CreatePatternBrush(Texture.Handle);
  AncBrush:=SelectObject(dc,NouvBrush);
  // Le contexte doit être transparent
  SetBkMode(dc,TRANSPARENT);

  // Dessin du texe :
  BeginPath(dc);
  TextOut(dc,X,Y,PChar(Texte),length(texte)); //<- au lieu de TextOut(dc,X,Y,PansiChar(Texte),length(texte)) pour rendre le code compatible avec toutes les versions de Delphi (de D2 à XE2);
  EndPath(dc);
  StrokeAndFillPath(dc);

  // Restauration objets et libération mémoire
  SelectObject(dc,AncFonte);
  DeleteObject(NouvFonte);
  SelectObject(dc,AncPen);
  DeleteObject(NouvPen);
  SelectObject(dc,AncBrush);
  DeleteObject(NouvBrush);
end;

// inverse une image (miroir horizontal) et la met dans dest
// Utilisé pour les signaux belges
procedure inverse_image(imageDest,ImageSrc : Timage);
var mrect,nrect : trect;
    larg,haut : integer;
begin
  larg:=ImageSrc.Width;
  haut:=ImageSrc.Height;
  mRect:=rect(0,0,larg,haut);
  nRect:=rect(larg-1,0,-1,haut);
  ImageDest.canvas.CopyRect(mRect,ImageSrc.canvas,nRect);
end;

// dessine les feux sur une cible belge à 5 feux
// cette image peut être inversée (contre voie)
procedure dessine_signal20(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation,adresse : integer);
var xblanc,xvert,xrouge,Yblanc,xjauneBas,xJauneHaut,yJauneBas,yJauneHaut,YVert,Yrouge,largeur,
    index,Temp,rayon,LgImage,HtImage,code,combine,x1,y1,x2,y2,x3,y3,xChiffre,yChiffre,xfin,yfin,angle,
    AdrAig,IndexAig,vitesse,indexTCO,tailleFonte,xTexte,yTexte : integer;
    ech : real;
    inverse,etatChevron,EtatChiffre,codeClignote : boolean;
    r : Trect;
begin

  code:=etatSignal and $3f;
  combine:=etatSignal and $1c0;
  // LDT-DEC-NMBS ou b-model
  etatChiffre:=testBit(combine,chiffre);
  etatChevron:=testBit(combine,chevron);
  CodeClignote:=testBit(combine,clignote);
  largeur:=57;

  rayon:=round(6*frX);
  xVert:=15; yvert:=24;
  xrouge:=15; yrouge:=37;
  xjauneBas:=15;yjauneBas:=50;
  xblanc:=15;yblanc:=63;
  xJauneHaut:=41;yJauneHaut:=24;

  // chevron
  x1:=9;y1:=3;
  x2:=16;y2:=10;
  x3:=x2+(x2-x1);y3:=y1;
  // effacement du chiffre
  XChiffre:=11;Ychiffre:=77;
  Xfin:=27;yFin:=102;
  // texte du chiffre
  xTexte:=xChiffre+2;
  yTexte:=yChiffre+1;

  index:=index_signal(adresse);
  if Signaux[index].contrevoie then
  begin
    xvert:=largeur-xvert;
    xrouge:=largeur-xrouge;
    xjaunebas:=largeur-xjaunebas;
    xjaunehaut:=largeur-xjaunehaut;
    xblanc:=largeur-xblanc;
    x1:=largeur-x1;
    x2:=largeur-x2;
    x3:=largeur-x3;
    Xchiffre:=32;
    Xfin:=44;
    Xtexte:=Xchiffre+1;
    codeclignote:=true;
  end;

  if XChiffre>Xfin then echange(Xchiffre,Xfin);

  with Formprinc.ImageSignal20.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;

  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des signaux
    // calcul des facteurs de réduction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjauneBas;YJauneBas:=XJauneBas;XjauneBas:=Temp;
    Temp:=HtImage-yjauneHaut;YJauneHaut:=XJauneHaut;XjauneHaut:=Temp;
    Temp:=HtImage-yblanc;YBlanc:=XBlanc;XBlanc:=Temp;
    Temp:=HtImage-yRouge;YRouge:=Xrouge;XRouge:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
    Temp:=HtImage-y1;Y1:=X1;X1:=Temp;
    Temp:=HtImage-y2;Y2:=X2;X2:=Temp;
    Temp:=HtImage-y3;Y3:=X3;X3:=Temp;
    Temp:=HtImage-yChiffre;YChiffre:=XChiffre;XChiffre:=Temp;
    Temp:=HtImage-yTexte;YTexte:=XTexte;XTexte:=Temp;
    Temp:=HtImage-yfin;Yfin:=Xfin;Xfin:=Temp;
  end;

  if (orientation=3) then
  begin
    // rotation 90° vers la droite des signaux
    // calcul des facteurs de réduction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-XjauneBas;XJauneBas:=YJauneBas;YjauneBas:=Temp;
    Temp:=LgImage-XJauneHaut;XJauneHaut:=YJauneHaut;YjauneHaut:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xrouge;Xrouge:=Yrouge;Yrouge:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;

    Temp:=LgImage-x1;X1:=Y1;Y1:=Temp;
    Temp:=LgImage-X2;X2:=Y2;Y2:=Temp;
    Temp:=LgImage-X3;X3:=Y3;Y3:=Temp;
    Temp:=LgImage-XChiffre;XChiffre:=YChiffre;YChiffre:=Temp;
    Temp:=LgImage-Xfin;Xfin:=Yfin;Yfin:=Temp;
    Temp:=LgImage-XTexte;XTexte:=YTexte;YTexte:=Temp;
  end;

  if orientation=4 then
  begin
    XjauneBas:=LgImage-XjauneBas;YjauneBas:=HtImage-YjauneBas;
    XJauneHaut:=LgImage-XJauneHaut;YjauneHaut:=HtImage-YjauneHaut;
    Xvert:=LgImage-Xvert;Yvert:=HtImage-Yvert;
    Xrouge:=LgImage-Xrouge;Yrouge:=HtImage-Yrouge;
    XBlanc:=LgImage-XBlanc;YBlanc:=HtImage-YBlanc;

    X1:=LgImage-X1;Y1:=HtImage-Y1;
    X2:=LgImage-X2;Y2:=HtImage-Y2;
    X3:=LgImage-X3;Y3:=HtImage-Y3;
    XChiffre:=LgImage-XChiffre;YChiffre:=HtImage-YChiffre;
    XFin:=LgImage-Xfin;Yfin:=HtImage-yFin;
    xTexte:=LgImage-XTexte;YTexte:=HtImage-YTexte;
  end;

  XJauneBas:=round(XjauneBas*Frx)+x;  YJauneBas:=round(YjauneBas*Fry)+Y;
  XJauneHaut:=round(XjauneHaut*Frx)+x;  YJauneHaut:=round(YjauneHaut*Fry)+Y;
  Xblanc:=round(XBlanc*FrX)+x;  YBlanc:=round(YBlanc*FrY)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  Xrouge:=round(Xrouge*FrX)+x;  Yrouge:=round(Yrouge*FrY)+Y;
  xchiffre:=round(Xchiffre*frx)+x;  ychiffre:=round(ychiffre*fry)+y;
  xTexte:=round(XTexte*frx)+x;  yTexte:=round(yTexte*fry)+y;
  xfin:=round(Xfin*frx)+x;  yfin:=round(yfin*fry)+y;
  x1:=round(X1*frx)+x;  y1:=round(y1*fry)+y;
  x2:=round(X2*frx)+x;  y2:=round(y2*fry)+y;
  x3:=round(X3*frx)+x;  y3:=round(y3*fry)+y;

  // extinctions
  if not((code=vertB_F) and codeclignote and clignotant) then cercle(ACanvas,xvert,yvert,rayon,GrisF);
  if not((code=rouge_F) and codeclignote and clignotant) then cercle(ACanvas,xrouge,yrouge,rayon,GrisF);
  if not((code=rouge_blanc_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
    cercle(ACanvas,xRouge,yRouge,rayon,GrisF);
  end;
  if not((code=deux_jaunes_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xjaunebas,yjauneBas,rayon,GrisF);
    cercle(ACanvas,xjaunehaut,yjauneHaut,rayon,GrisF);
  end;
  if not((code=vert_jaune_H_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,grisF);
    cercle(ACanvas,xvert,yvert,rayon,grisF);
  end;
  if not((code=vert_jaune_V_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xjauneBas,yjauneBas,rayon,grisF);
    cercle(ACanvas,xvert,yvert,rayon,grisF);
  end;


  //allumages
  if ((code=vertB_F) and codeClignote and clignotant) or ((code=vertB_F) and not(codeclignote)) then cercle(ACanvas,xvert,yvert,rayon,clGreen);
  if ((code=rouge_F) and codeClignote and clignotant) or ((code=rouge_F) and not(codeclignote)) then cercle(ACanvas,xrouge,yrouge,rayon,clRed);
  if ((code=rouge_blanc_F) and codeClignote and clignotant) or ((code=rouge_blanc_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xblanc,yblanc,rayon,clWhite);
    cercle(ACanvas,xrouge,yrouge,rayon,clred);
  end;
  if ((code=deux_jaunes_F) and codeClignote and clignotant) or ((code=deux_jaunes_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xjauneBas,yjauneBas,rayon,clOrange);
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,clOrange);
  end;
  if ((code=vert_jaune_H_F) and codeClignote and clignotant) or ((code=vert_jaune_H_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,clorange);
    cercle(ACanvas,xvert,yvert,rayon,clgreen);
  end;
  if ((code=vert_jaune_V_F) and codeClignote and clignotant) or ((code=vert_jaune_V_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xjaunebas,yjaunebas,rayon,clorange);
    cercle(ACanvas,xvert,yvert,rayon,clgreen);
  end;

  with Acanvas do
  begin
    if Etatchevron then pen.color:=ClWhite else pen.color:=clblack;

    // dessine le chevron
    pen.Width:=2;
    Moveto(x1,y1);Lineto(x2,y2);Lineto(x3,y3);

    // écrit le chiffre
    if etatChiffre then
    begin                           
      taillefonte:=round(frx*ZoomMax);
      tailleFonte:=(taillefonte div 4)+2;
      //Affiche(inttoSTR(taillefonte),clred);
      Brush.Color:=clblack;
      with font do
      begin
        Color:=clWhite;
        Size:=taillefonte;
        Style:=[fsbold];
        Name:='Arial';
      end;

      if Signaux[index].Btype_suiv1=aig then
      begin
        adrAig:=Signaux[index].Adr_el_suiv1;
        IndexAig:=index_aig(adrAig);
        vitesse:=aiguillage[IndexAig].vitesse div 10;

        if orientation=1 then Textout(XTexte,YTexte,intToSTR(vitesse))
        else
        begin
          case orientation of
          2 : angle:=-900;
          3 : angle:=900;
          4 : angle:=1800;
          end;
          AffTexteIncliBordeTexture(Acanvas,XTexte,YTexte,Acanvas.Font,clYellow,0,pmcopy,nil,intToSTR(vitesse),angle);
        end;
      end;
    end
    else
    begin
      // éteint le chiffre
      Brush.Color:=clblack;
      Pen.Color:=clblack;
      r.Left:=xchiffre;r.Top:=Ychiffre;
      r.Right:=Xfin;r.Bottom:=Yfin;
      Fillrect(r);
    end;
  end;
end;

// dessine les feux sur une cible directionnelle à N feux
procedure dessine_dirN(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation,N : integer);
var rayon,x1,x2,x3,y1,y2,y3,x4,y4,x5,y5,x6,y6,LgImage,HtImage,temp : integer;
    ech : real;
begin
  if (n<2) or (n>6) then n:=2;
  if (orientation<1) or (orientation>3) then orientation:=1;
  rayon:=round(6*frX);
  if n=2 then x2:=25 else x2:=22;
  x1:=11;x3:=33;x4:=43;x5:=53;x6:=63;
  y1:=13;y2:=13;y3:=13;y4:=13;y5:=13;y6:=13;

  case n of
  2 : with Formprinc.Image2Dir.Picture.Bitmap do
      begin
        LgImage:=Width;
        HtImage:=Height;
      end;
  3 : with Formprinc.Image3Dir.Picture.Bitmap do
      begin
        LgImage:=Width;
        HtImage:=Height;
      end;
  4 : with Formprinc.Image4Dir.Picture.Bitmap do
      begin
        LgImage:=Width;
        HtImage:=Height;
      end;
  5 : with Formprinc.Image5Dir.Picture.Bitmap do
      begin
        LgImage:=Width;
        HtImage:=Height;
      end;
  6 : with Formprinc.Image6Dir.Picture.Bitmap do
      begin
        LgImage:=Width;
        HtImage:=Height;
      end;  
  end;    

  if (orientation=2) then
  begin
    //rotation 90° vers la gauche des feux : échange des coordonnées X et Y et translation sur HtImage
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-y1;y1:=X1;X1:=Temp;
    Temp:=HtImage-y2;y2:=X2;X2:=Temp;
    Temp:=HtImage-y3;y3:=X3;X3:=Temp;
    Temp:=HtImage-y4;y4:=X4;X4:=Temp;
    Temp:=HtImage-y5;y5:=X5;X5:=Temp;
    Temp:=HtImage-y6;y6:=X6;X6:=Temp;
  end;

  if (orientation=3) then
  begin
    //rotation 90° vers la droite des feux : échange des coordonnées X et Y et translation sur LgImage
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-X1;X1:=Y1;Y1:=Temp;
    Temp:=LgImage-X2;X2:=Y2;Y2:=Temp;
    Temp:=LgImage-X3;X3:=Y3;Y3:=Temp;
    Temp:=LgImage-X4;X4:=Y4;Y4:=Temp;
    Temp:=LgImage-X5;X5:=Y5;Y5:=Temp;
    Temp:=LgImage-X6;X6:=Y6;Y6:=Temp;
  end;

  X1:=round(X1*Frx)+x;  Y1:=round(Y1*Fry)+Y;
  X2:=round(X2*FrX)+x;  Y2:=round(Y2*FrY)+Y;
  X3:=round(X3*FrX)+x;  Y3:=round(Y3*FrY)+Y;
  X4:=round(X4*Frx)+x;  Y4:=round(Y4*Fry)+Y;
  X5:=round(X5*FrX)+x;  Y5:=round(Y5*FrY)+Y;
  X6:=round(X6*FrX)+x;  Y6:=round(Y6*FrY)+Y;

  if EtatSignal=0 then
  begin
    cercle(ACanvas,x1,y1,rayon,GrisF);
    cercle(ACanvas,x2,y2,rayon,GrisF);
    if N>2 then cercle(ACanvas,x3,y3,rayon,GrisF);
    if N>3 then cercle(ACanvas,x4,y4,rayon,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,GrisF);
  end;
  if EtatSignal=1 then
  begin
    cercle(ACanvas,x1,y1,rayon,clWhite);
    cercle(ACanvas,x2,y2,rayon,grisF);
    if N>2 then cercle(ACanvas,x3,y3,rayon,grisF);
    if N>3 then cercle(ACanvas,x4,y4,rayon,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,GrisF);
  end;
  if EtatSignal=2 then
  begin
    cercle(ACanvas,x1,y1,rayon,clWhite);
    cercle(ACanvas,x2,y2,rayon,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,GrisF);
    if N>3 then cercle(ACanvas,x4,y4,rayon,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,GrisF);
  end;                  
  if EtatSignal=3 then
  begin
    cercle(ACanvas,x1,y1,rayon,clWhite);
    cercle(ACanvas,x2,y2,rayon,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,GrisF);
  end;
  if EtatSignal=4 then
  begin
    cercle(ACanvas,x1,y1,rayon,clWhite);
    cercle(ACanvas,x2,y2,rayon,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clWhite);
    if N>4 then cercle(ACanvas,x5,y5,rayon,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,GrisF);
  end;
  if EtatSignal=5 then 
  begin
    cercle(ACanvas,x1,y1,rayon,clWhite);
    cercle(ACanvas,x2,y2,rayon,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clWhite);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clWhite);
    if N>5 then cercle(ACanvas,x6,y6,rayon,GrisF);
  end;
  if EtatSignal=6 then 
  begin
    cercle(ACanvas,x1,y1,rayon,clWhite);
    cercle(ACanvas,x2,y2,rayon,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clWhite);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clWhite);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clWhite);
  end;
end;

// transforme le type TEquipement en chaine
// rien,aig,tjd,tjs,triple,det,buttoir,voie,crois,act
function BTypeToChaine(BT : TEquipement) : string;
begin
  case BT of
  rien : result:='rien';
  det : result:='det';
  aig : result:='aig';
  voie : result:='voie';
  buttoir : result:='buttoir';
  triple : result:='triple';
  tjd : result:='tjd';
  tjs : result:='tjs';
  crois : result:='crois';
  act : result:='act';
  else result:='???';
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

procedure Affiche_suivi(s : string;lacouleur : TColor);
var i : integer;
begin
  with formprinc.FenRich do
  begin
    i:=lines.Count-1;
    s:=lines.Strings[i]+s;
    lines.Strings[i]:=s;
    RE_ColorLine(Formprinc.FenRich,i,lacouleur);
  end;
end;

// affiche un texte contenu dans une chaine avec plusieurs CR, et le découpe à l'affichage.
procedure Affiche_CR(s: string;lacouleur : Tcolor);
var i : integer;
begin
  repeat
    i:=pos(#13,s);
    Affiche(copy(s,1,i-1),lacouleur);
    delete(s,1,i);
  until (i=0);
end;

function indexbrut_train_adresse(adr : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=TrainZone[i].adrTrain=adr;
    inc(i);
  until trouve or (i>MaxTrainZone);
  if trouve then result:=i-1 else result:=0;
end;

// trouve l'index d'un train par son nom dans le tableau trains
function index_train_nom(nom : string) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=trains[i].nom_train=nom;
    if not(trouve) then inc(i);
  until (trouve) or (i>Ntrains);
  if trouve then Index_train_nom:=i else Index_train_nom:=0 ;
end;

// trouve l'index d'un train par son adresse dans le tableau trains
function index_train_adresse(adr : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=trains[i].adresse=adr;
    if not(trouve) then inc(i);
  until (trouve) or (i>Ntrains);
  if trouve then index_train_adresse:=i else index_train_adresse:=0 ;
end;

// renvoie l'index du signal dans le tableau Signaux[] en fonction de son adresse
// si pas trouvé renvoie 0
function Index_signal_V1(adresse : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=Signaux[i].adresse=adresse;
    if not(trouve) then inc(i);
  until (trouve) or (i>NbreSignaux);
  if trouve then result:=i else result:=0 ;
end;

function index_signal(adresse : integer) : integer;
begin
  if adresse>MaxAcc then result:=0 else
  //result:=Index_Accessoire[adresse];
  result:=Tablo_Index_Signal[adresse];
  // vérifier si l'adresse correspond
  if Signaux[result].adresse<>adresse then result:=0;
end;

// renvoie l'index de l'aiguillage dans le tableau aiguillages[] en fonction de son adresse
// si pas trouvé renvoie 0
function Index_Aig_V1(adresse : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=aiguillage[i].adresse=adresse;
    if not(trouve) then inc(i);
  until (trouve) or (i>MaxAiguillage);
  if trouve then result:=i else result:=0 ;
end;

function Index_Aig(adresse : integer) : integer;
begin
  if adresse>MaxAcc then result:=0 else
  result:=tablo_index_aiguillage[adresse];
  // vérifier si l'adresse correspond
  if Aiguillage[result].adresse<>adresse then result:=0;
end;

{
function Index_com(NumPort : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  result:=0;
  i:=1;
  repeat
    trouve:=Tablo_com_cde[i].NumPort=NumPort;
    if not(trouve) then inc(i);
  until (trouve) or (i>10);
  if trouve then result:=i;
end;
}

// dessine l'aspect du signal en fonction de son adresse dans la partie droite de droite
procedure Dessine_signal_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : real;adresse : integer;orientation : integer);
var i,aspect : integer;
begin
  i:=Index_Signal(adresse);
  if i<>0 then
  begin
    aspect:=Signaux[i].aspect ;
    case aspect of
      // signaux
      2 : dessine_signal2(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation);
      3 : dessine_signal3(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation);
      4 : dessine_signal4(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation);
      5 : dessine_signal5(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation);
      7 : dessine_signal7(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation);
      9 : dessine_signal9(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation);
     20 : dessine_signal20(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,Signaux[i].adresse);
     // indicateurs de direction
     12..16 : dessine_dirN(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,aspect-10);
    end;
  end;
end;

// procédure activée si on clique G ou D sur une image d'un signal
procedure TFormPrinc.ProcOnMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;
begin
  if button=mbRight then
  begin
    P_image_pilote:=Sender as TImage;  // récupérer l'objet image du signal cliqué de la forme pilote
    s:=P_Image_pilote.Hint;            // récupérer son hint qui contient l'adresse du signal cliqué
    i:=pos('@',s);  if i<>0 then delete(s,1,i);
    i:=pos('=',s);  if i<>0 then delete(s,i,1);
    i:=pos(' ',s);
    if i<>0 then
    begin
      s:=copy(s,1,i-1);
      val(s,AdrPilote,erreur);
    end;  
  end;
end;

// procédure activée quand on clique gauche sur l'image d'un signal
Procedure TFormprinc.ImageOnClick(Sender : Tobject);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;
begin
  P_image_pilote:=Sender as TImage;  // récupérer l'objet image du signal cliqué de la forme pilote
  s:=P_Image_pilote.Hint;            // récupérer son hint qui contient l'adresse du feu cliqué
  //Affiche(s,clyellow);
  i:=pos('@',s);  if i<>0 then delete(s,1,i);
  i:=pos('=',s);  if i<>0 then delete(s,i,1);
  i:=pos(' ',s);
  if i<>0 then s:=copy(s,1,i-1);
  val(s,AdrPilote,erreur);
  if adrPilote=0 then exit;
  i:=Index_Signal(AdrPilote);
  if i=0 then exit;

  with Formpilote do
  begin
   // TFormPilote.Create(Self);
    show;
  end;
end;

function Select_dessin_Signal(TypeSignal : integer) : TBitmap;
var Bm : TBitMap;
begin
   case TypeSignal of
    2 : Bm:=Formprinc.Image2feux.picture.Bitmap;
    3 : Bm:=Formprinc.Image3feux.picture.Bitmap;
    4 : Bm:=Formprinc.Image4feux.picture.Bitmap;
    5 : Bm:=Formprinc.Image5feux.picture.Bitmap;
    7 : Bm:=Formprinc.Image7feux.picture.Bitmap;
    9 : Bm:=Formprinc.Image9feux.picture.Bitmap;
    20 : Bm:=Formprinc.ImageSignal20.picture.Bitmap;

    // signaux directionnels
    12 : Bm:=Formprinc.Image2Dir.picture.Bitmap;
    13 : Bm:=Formprinc.Image3Dir.picture.Bitmap;
    14 : Bm:=Formprinc.Image4Dir.picture.Bitmap;
    15 : Bm:=Formprinc.Image5Dir.picture.Bitmap;
    16 : Bm:=Formprinc.Image6Dir.picture.Bitmap;
    else Bm:=nil;
    end;
    Select_dessin_Signal:=bm;
end;

// créée une image dynamiquement pour un nouveau signal déclaré dans le fichier de config
// rang commence à 1
procedure cree_image(rang : integer);
var adresse,TypeSignal : integer;
    s : string;
    T_BP : TBitMap;
begin
  TypeSignal:=Signaux[rang].aspect;
  if typeSignal<=0 then exit;
  adresse:=Signaux[rang].adresse;
  Signaux[rang].Img:=Timage.create(Formprinc.ScrollBoxSig);
  if Signaux[rang].Img=nil then begin affiche('Erreur 900 : impossible de créer une image',clred);exit;end;

  with Signaux[rang].Img do
  begin
    if debug=1 then affiche('Image '+intToSTR(rang)+' créée',clLime);
    //canvas.Create;
    Autosize:=true;
    align:=alNone;
    Parent:=Formprinc.ScrollBoxSig;   // dire que l'image est dans la scrollBox1
    //formprinc.ScrollBox1.Color:=ClGreen;
    Name:='ImageSignal'+IntToSTR(rang);   // nom de l'image
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // détermine les points d'origine
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    width:=LargImg;
    Height:=HtImg;

    // hint - sert à identifier le composant si on fait clic droit.
    s:='Index='+IntToSTR(rang)+'  @='+inttostr(Adresse)+'  Décodeur='+decodeur[Signaux[rang].Decodeur]+#13+
       '  Adresse détecteur associé='+intToSTR(Signaux[rang].Adr_det1)+#13+
       '  Adresse élement suivant='+intToSTR(Signaux[rang].Adr_el_suiv1);
    if Signaux[rang].Btype_suiv1=aig then s:=s+' (aig)';
    Hint:=s;
    showHint:=true;

    onClick:=Formprinc.Imageonclick;    // affectation procédure clique G sur image
    onMouseDown:=Formprinc.ProcOnMouseDown; // clique G ou D
    PopUpMenu:=Formprinc.PopupMenuSignal;  // affectation popupmenu sur clic droit

    // affecter le type d'image de signal dans l'image créée
    T_BP:=Select_dessin_Signal(TypeSignal);
    if T_BP=nil then
    begin
      Affiche('Erreur 418 : sélection type signal incorrecte pour signal '+intToSTR(adresse),clred);
      exit;
    end;
    picture.Bitmap:=T_Bp;

    picture.BitMap.TransparentMode:=tmfixed;     // tmauto  (la couleur transparente est déterminée par pixel le plus en haut à gauche du bitmap)
                                                 // tmfixed (la couleur transparente est explicitement assignée et stockée dans le bitmap)
    Picture.Bitmap.TransparentColor:=clblue;     // la couleur de transparence est bleue
    Transparent:=true;

    // mettre rouge par défaut
    if TypeSignal=2 then Signaux[rang].EtatSignal:=violet_F;
    if TypeSignal=3 then Signaux[rang].EtatSignal:=semaphore_F;
    if (TypeSignal>3) and (TypeSignal<10) and Signaux[rang].VerrouCarre then Signaux[rang].EtatSignal:=carre_F;
    if (TypeSignal>3) and (TypeSignal<10) and not(Signaux[rang].VerrouCarre) then Signaux[rang].EtatSignal:=semaphore_F;
    if isDirectionnel(rang) then Signaux[rang].EtatSignal:=0;

    if TypeSignal=20 then // signal belge
    begin
      Signaux[rang].EtatSignal:=semaphore_F;
      if Signaux[rang].contrevoie then
      begin
        inverse_image(Signaux[rang].Img,Formprinc.ImageSignal20);
        Signaux[rang].EtatSignal:=Signaux[rang].EtatSignal+clignote_F;
      end;
    end;
    dessine_signal_mx(Signaux[rang].Img.Canvas,0,0,1,1,Signaux[rang].adresse,1);
    //if Signaux[rang].aspect=5 then cercle(Picture.Bitmap.Canvas,13,22,6,ClYellow);
    refresh;
    Picture.Bitmap.Modified:=True;
  end;

  // créée le label pour afficher son adresse
  Signaux[rang].Lbl:=Tlabel.create(Formprinc.ScrollBoxSig);
  with Signaux[rang].Lbl do
  begin
    Name:='LabelFeu'+intToSTR(Signaux[rang].adresse);
    caption:='@'+IntToSTR(Signaux[rang].adresse);
    Parent:=Formprinc.ScrollBoxSig;
    font.color:=clBlack;
    width:=100;height:=20;
    Top:=HtImg+((HtImg+EspY+20)*((rang-1) div NbreImagePLigne));
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    BringToFront;
  end;

  // créée le checkBox si un feu blanc est déclaré sur ce feu
  if Signaux[rang].FeuBlanc then
  begin
    if debug=1 then affiche('Création CheckBox feu blanc '+intToSTR(rang),clLime);
    Signaux[rang].checkFB:=TCheckBox.create(Formprinc.ScrollBoxSig);  // ranger l'adresse de la Checkbox dans la structure du feu
    with Signaux[rang].CheckFB do
    begin
      onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la procédure de traitement quand on clique dessus
      Hint:='Feu blanc';
      Name:='CheckBoxFB'+intToSTR(adresse);  // affecter l'adresse du feu pour pouvoir le retrouver dans la procédure
      caption:='dem FB';
      font.color:=clBlack;
      Parent:=Formprinc.ScrollBoxSig;
      width:=100;height:=15;
      Top:=HtImg+15+((HtImg+EspY+20)*((rang-1) div NbreImagePLigne));
      Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
      BringToFront;
    end;
  end
  else Signaux[rang].checkFB:=nil;
end;

// affiche les signaux dans la fenêtre de droite
procedure Affiche_signaux;
var i : integer;
begin
  i:=(Formprinc.ScrollBoxSig.Width div (largImg+5)) -1;
  if i=NbreImagePLigne then exit;
  NbreImagePLigne:=i;
  for i:=1 to NbreSignaux do
  begin
    if Signaux[i].Img<>nil then
    begin
      with Signaux[i].img do
      begin
        Top:=(HtImg+espY+20)*((i-1) div NbreImagePLigne);   // détermine les points d'origine
        Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
        repaint;
      end;

      with Signaux[i].lbl do
      begin
        Top:=HtImg+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
        Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
        repaint;
      end;

      if Signaux[i].FeuBlanc then
      with Signaux[i].checkFB do
      begin
        Top:=HtImg+15+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
        Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
        repaint;
      end;
    end
    else
      Affiche('Anomalie données du signal '+intToSTR(signaux[i].adresse),clred);
  end
end;

// ajoute en bout de chaine le checksum d'une trame pour XpressNet
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
// pour le protole XpressNet (1), on ajoute l'entete et le suffixe dans la trame.
// ici on envoie pas à CDM
procedure envoi_ss_ack(s : string);
var i,timeout,valto : integer;
begin
  // XpressNet
  if protocole=1 then
  begin
    s:=entete+s+suffixe;
    if traceTrames then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClLime);
  end;
  // DCC++
  if (protocole=2) and TraceTrames then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+s,ClLime);

  // par port com-usb
  if portCommOuvert then
  begin
    if (prot_serie=4) then // le protocole 4 contrôle simplement la ligne CTS avant de transmettre et temporise octet par octet
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
        until (MSCommUSBInterface.CTSHolding=true) or (timeout>valto);

        if timeout<=valto then
        begin
          //if formprinc.MSCommUSBLenz.CTSHolding then sa:='CTS=1 ' else sa:='CTS=0 ';
          envoi_usb_comp(MSCommUSBInterface,s[i]);
          if terminal then Affiche(chaine_hex(s[i]),clyellow);
          inc(i);
        end;
      until (i=length(s)+1) or (timeout>valto);
      if timeout>valto then affiche('Erreur attente interface trop longue',clred);
    end;

    // protocole Rts Cts ou sans temporisation
    if (prot_serie=2) or (tempoOctet=0) then
    begin
      envoi_usb_comp(MSCommUSBInterface,s);
      exit;
    end;

    // procotole xon xoff ou xon-rts
    if (prot_serie=1) or (prot_serie=3) then
    begin
      for i:=1 to length(s) do
      begin
        envoi_usb_comp(MSCommUSBInterface,s[i]);
        //Affiche(s[i],clyellow);// else Affiche(chaine_hex(s[i]),clyellow);
        Sleep(TempoOctet);
      end;
    end;
    if (prot_serie=0) then
    begin
      envoi_usb_comp(MSCommUSBInterface,s);
      Sleep(TempoOctet);
    end;
  end;

  // par socket (ethernet)
  if parSocketLenz or (etat_init_interface>=11) then Formprinc.ClientSocketInterface.Socket.SendText(s);
end;

// envoi d'une chaîne à l'interface par USB ou socket, puis attend l'ack ou le nack
function envoi(s : string) : boolean;
var tempo : integer;
begin
  envoi_ss_ack(s);
  // attend l'ack
  ack:=false;nack:=false;
  if portCommOuvert or parSocketLenz then
  begin
    tempo:=0;
    repeat
      Application.processMessages;
      inc(tempo);Sleep(50);
    until fermeSC or ack or nack or (tempo>(TimoutMaxInterface*3)); // l'interface répond < 5s en mode normal et 1,5 mn en mode programmation
    if not(ack) or nack then
    begin
      s:='Pas de réponse de l''interface';
      Affiche(s,clRed);
      if traceTrames then AfficheDebug(s,clred);
      inc(pasreponse);
    end;
    if ack then begin pasreponse:=0;hors_tension:=false;end;
  end;
  envoi:=ack;
end;

// insère l'id pour le serveur CDM dans une chaîne
function place_id(s : string) : string;
begin
  delete(s,5,2);
  insert(id_cdm,s,5);
  place_id:=s;
end;

// chaîne pour une fonction F à un train via CDM
Function chaine_CDM_Func(fonction,etat : integer;train : string) : string;
var so,sx,s : string;
begin
  {  exemple de commande envoyée au serveur CDM pour une fonction
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=nomdutrain;FXnumfonction=etat;
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=train;FX0=0;
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=train;FX1=0;
  C-C-00-0002-CMDTRN-DCCSF|047|02|NAME=train;FX0=1;FX1=1;FX2=1;FX3=1;
  maxi=C-C-00-0002-CMDTRN-DCCSF|111|15|NAME=train;FX0=1;FX1=1;FX2=1;FX3=1;FX4=0;FX5=0;FX6=0;FX7=0;FX8=0;FX9=0;FX10=0;FX11=0;FX12=0;FX13=0;
  }
  so:=place_id('C-C-01-0004-CMDTRN-DCCSF');
  s:=s+'NAME='+train+';';
  s:=s+'FX'+intToSTR(fonction)+'='+intToSTR(etat)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;
  chaine_CDM_Func:=so+s;
end;

// chaîne pour vitesse train par son nom string
function chaine_CDM_vitesseST(vitesse:integer;train:string) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:=s+'NAME='+train+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesseST:=so+s;
  //Affiche(so+s,clyellow);
  //C-C-02-0004-CMDTRN-SPEED|025|02|NAME=CC406526;UREQ=39;
end;

// renvoie une chaîne pour vitesse train INT par son adresse
function chaine_CDM_vitesseINT(vitesse:integer;train:integer) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:=s+'AD='+intToSTR(train)+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 paramètres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesseINT:=so+s;
end;

// renvoie une chaîne pour piloter un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat : integer) : string;
var so,sx,s : string;
begin
 {  exemple de commande envoyée au serveur pour manoeuvrer un accessoire
  C-C-00-0004-CMDACC-DCCAC|018|02|AD=100;STATE=1;
  "	AD: adresse (DCC) de l'aiguille
  "	AD2: adresse #2 (DCC) de l'aiguille (TJD bi-moteurs ou aiguille triples)
  "	STATE: état de l'aiguille
  o	0: position droite (non déviée)
  o	1: dévié (TJD, bretelles doubles)
  o	2: dévié droit
  o	3: dévié gauche
  o	4: pos. droite #2 (TJD 4 états)
  o	5: pos. déviée #2 (TJD 4 états)
  en fait seules les fonctions 1 et 2 fonctionnent...
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

// active ou désactive une sortie par xpressnet (mode autonome, donc connecté à la centrale)
// Une adresse comporte deux sorties identifiées par "octet"
// Adresse : adresse de l'accessoire
// octet : numéro (1-2) de la sortie à cette adresse
// etat  : false (désactivé) true (activé)
procedure pilote_direct(adresse:integer;octet : byte;etat : boolean);
var  groupe : integer ;
     fonction : byte;
     s : string;
begin
  if protocole=1 then
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
  if protocole=2 then Affiche('D1: Commande DCC++ pas encore implantée',clred);
end;

// envoie un octet 1 ou 2 à l'adresse DCC en Xpressnet, sans remise à 0 de l'adresse
procedure pilote_direct01(adresse:integer;octet:integer);
var  groupe : integer ;
     fonction : byte;
     s : string;
begin
  if protocole=1 then
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
  if protocole=2 then Affiche('D2: Commande DCC++ pas encore implantée',clred);
end;


procedure demande_etat_loco(loco : integer);
var ah,al,i : integer;
    s : string;
begin
  if portCommOuvert or parSocketLenz then
  begin
    if protocole=1 then
    begin
      if loco<99 then begin Ah:=0;Al:=loco;end
      else begin ah:=((loco and $FF00) + $C000) shr 8;al:=loco and 255;end;
      s:=#$E3+#0+char(ah)+char(al);
      s:=checksum(s);
      fa:=256;fb:=256;
      envoi(s);
      i:=0;
      repeat
        inc(i);
        Sleep(100);
        Application.ProcessMessages;
      until (fa<>256) or (i=10);
    end;
    if protocole=2 then Affiche('D3: Commande DCC++ pas encore implantée',clred);
  end;
end;

// loco=adresse de la loco  fonction de 0 à 20 état 0/1
procedure Fonction_Loco_Operation(loco,fonction,etat : integer);
var s : string ;
    ah,al : integer;
    b,c : byte ;
begin
  if (fonction<0) or (fonction>28) or (loco<0) or (loco>9999) then exit;
  if portCommOuvert or parSocketLenz then
  begin
    if protocole=1 then
    begin
      demande_etat_loco(loco);    // récupère les états des fonctions Fa=F0 à 4 Fb=F5 à F12 AdrTrain
      //Affiche('Train='+IntToSTR(AdrTrain)+' '+IntToHex(fa,2)+' '+IntToHex(fb,2),clyellow);
      // en fonction du décodeur, on n'a pas le bon train!!
      if (fa<>256) then
      begin
        s:=#$E4;
        if fonction<=4 then s:=s+#$20;
        if (fonction>=5) and (fonction<=8) then s:=s+#$21;
        if (fonction>=9) and (fonction<=12) then s:=s+#$22;
        if (fonction>=13) and (fonction<=20) then s:=s+#$23;    // 23 non doc
        if (fonction>=21) and (fonction<=28) then s:=s+#$28;    // 28 non doc
        //  codification de l'adresse de la loco : doc Xpressnet page 40 (§2.1.15)
        if loco<99 then begin Ah:=0;Al:=loco;end
        else begin ah:=((loco or $C000) shr 8);al:=loco and 255;end;
        s:=s+char(ah)+char(al);
        // codification de la fonction : doc Xpressnet page 64 {§2.2.20.5)
        if etat<>0 then
        begin
          case fonction of
            0           : b:=fa or setbit(0,4);
            1,2,3,4     : b:=fa or setbit(0,fonction-1);         // fa est aligné avec l'octet de demande
            5,6,7,8     : b:=fb or setbit(0,fonction-5);         // fa est aligné avec l'octet de demande
            9,10,11,12  : b:=(fb shr 4) or setbit(0,fonction-9); // fa est décalé à gauche de 4 avec l'octet de demande
          end;
          if (fonction>=13) and (fonction<=20) then b:=(fb shr 8) or setbit(0,fonction-13);   // non doc
          if (fonction>=21) and (fonction<=28) then b:=(fb shr 8) or setbit(0,fonction-21);   // non doc
          end
        else
        begin
          case fonction of
            0           : b:=fa and razbit(255,4);               // fa est aligné avec l'octet de demande
            1,2,3,4     : b:=fa and razbit(255,fonction-1);      // fa est aligné avec l'octet de demande
            5,6,7,8     : b:=fb and razbit(255,fonction-5);
            9,10,11,12  : b:=(fb shr 4) and razbit(255,fonction-9);
          end;
          if (fonction>=13) and (fonction<=20) then b:=(fb shr 8) or razbit(255,fonction-13);   // non doc
          if (fonction>=21) and (fonction<=28) then b:=(fb shr 8) or razbit(255,fonction-21);   // non doc
        end;
        s:=s+char(b);
        s:=checksum(s);
        envoi(s);
      end;
    end;
    if protocole=2 then 
    begin
      c:=0;
      if fonction<=4 then
      begin
        b:=128;
        if etat=1 then
        case fonction of
        0 : b:=b+16;
        1 : b:=b+1;
        2 : b:=b+2;
        3 : b:=b+4;
        4 : b:=b+8;
        end;
      end;
      if (fonction>=5) and (fonction<=8) then
      begin
        b:=176;
        if etat=1 then
        case fonction of
        5 : b:=b+1;
        6 : b:=b+2;
        7 : b:=b+4;
        8 : b:=b+8;
        end;
      end;
      if (fonction>=9) and (fonction<=12) then
      begin
        b:=160;
        if etat=1 then
        case fonction of
        9 : b:=b+1;
        10 : b:=b+2;
        11 : b:=b+4;
        12 : b:=b+8;
        end;
      end;
      if (fonction>=13) and (fonction<=20) then
      begin
        b:=222;
        if etat=1 then
        case fonction of
        13 : c:=1;
        14 : c:=2;
        15 : c:=4;
        16 : c:=8;
        17 : c:=16;
        18 : c:=32;
        19 : c:=64;
        20 : c:=128;
        end;
      end;
      if (fonction>=21) and (fonction<=28) then
      begin
        b:=223;
        if etat=1 then
        case fonction of
        21 : c:=1;
        22 : c:=2;
        23 : c:=4;
        24 : c:=8;
        25 : c:=16;
        26 : c:=32;
        27 : c:=64;
        28 : c:=128;
        end;
      end;
      s:='<'+intToSTR(loco)+' '+intToSTR(b);
      if c<>0 then s:=s+' '+inttostr(c);
      s:=s+'>';
      envoi_ss_ack(s);  // pas d'ack sur les fonctions F
    end;
  end;
end;

// loco=adresse de la loco  fonction de 0 à 12 état 0/1
procedure Fonction_Loco_state(loco,fonction,etat : integer);
var s : string ;
    ah,al : integer;
    b : byte ;
begin
  if (fonction<0) or (fonction>28) or (loco<0) or (loco>9999) then exit;
  if portCommOuvert or parSocketLenz then
  begin
    if protocole=1 then
    begin
      s:=#$E4;
      case fonction of
        0,1,2,3,4   : s:=s+#$24;
        5,6,7,8     : s:=s+#$25;
        9,10,11,12  : s:=s+#$26;
        13,14,15,16 : s:=s+#$27;    // non doc
      end;
      //  codification de l'adresse de la loco : doc Xpressnet page 40 (§2.1.15)
      if loco<99 then begin Ah:=0;Al:=loco;end
      else begin ah:=((loco and $FF00) + $C000) shr 8;al:=loco and 255;end;
      s:=s+char(ah)+char(al);
      // codification de la fonction : doc Xpressnet page 64 {§2.2.20.5)
      case fonction of
        0           : b:=setbit(0,4);
        1,2,3,4     : b:=setbit(0,fonction-1);
        5,6,7,8     : b:=setbit(0,fonction-5);
        9,10,11,12  : b:=setbit(0,fonction-9);
        13,14,15,16 : b:=setbit(0,fonction-13);     // non doc
      end;
      s:=s+char(b);
      s:=checksum(s);
      envoi(s);
    end;
    if protocole=2 then Affiche('D5: Commande DCC++ pas encore implantée',clred);
  end;
end;

// envoie une vitesse à une loco par XpressNet/Dcc++ ou par CDM
// index=index du train dans le tableau trains[]
// vitesse positive ou négative
// répétition=avec répétition de la commande dans 1s
procedure vitesse_loco(nom_train :string;index : integer;adr_loco : integer;vitesse : integer;repetition : boolean);
var s : string;
    sens : boolean;
    v,erreur : integer;
begin
  if not(hors_tension) and ((portCommOuvert or parSocketLenz)) then
  begin
    Affiche('vitesse train '+inttostr(adr_loco)+' '+inttostr(vitesse),clLime);

    // mettre à jour la trackBar si le train sélectionné=editAdrTrain
    val(Formprinc.EditAdrTrain.Text,v,erreur);
    if v=adr_loco then
    begin
      pasChgTBV:=true; // évite de repositionner la trackbar
      Formprinc.TrackBarVit.Position:=vitesse;
      pasChgTBV:=false;
    end;
    if protocole=1 then
    begin
      //AfficheDebug('X9 train '+inttostr(loco)+' '+inttostr(vitesse),clOrange);
      sens:=vitesse>0;
      vitesse:=abs(vitesse);
      if vitesse>127 then vitesse:=127;
      v:=vitesse;
      if (sens) then v:=v or 128;
      s:=#$e4+#$13+#$0+char(adr_loco)+char(v);
      s:=checksum(s);
      envoi(s);
    end;
    if protocole=2 then
    begin
      s:='<t 1 '+intToSTR(adr_loco)+' '+intToSTR(vitesse)+' ';
      if sens then s:=s+'1>' else s:=s+'0>';
      envoi(s);
    end;
  end;

  if cdm_connecte then
  begin
    // il faut qu'on soit en RUN pour que les vitesses trains soient prises en compte
    if PilotageTrainsCDMNom then
      s:=chaine_CDM_vitesseST(vitesse,nom_train)  // par nom du train
    else
      s:=chaine_CDM_vitesseINT(vitesse,adr_loco);  // par adresse du train
    envoi_CDM(s);
    //affiche(s,clLime);
  end;

  // répétition de la consigne dans 1 s
  if repetition then
  begin
   // trains[index].nom_train:=Nom_train;
 //   trains[index].adresse:=adr_loco;
    trains[index].vitesse:=vitesse;
 //   trains[index].sens:=sens;
    trains[index].compteur_consigne:=10;
  end;

end;


procedure Maj_Etat_Signal_Belge(adresse,aspect : integer);
var i : integer;
    etats : word;
// La signalisation combinée belge est à partir du bit 10 (chiffre, chevron)
begin
  if debug=3 then formprinc.Caption:='Maj_Etat_Signal '+IntToSTR(adresse)+' '+intToSTR(aspect);
  i:=Index_Signal(adresse);
  begin
    // signalisation de base
    if aspect<=$3f then
    begin
      // razer tous les bits non combinés
      etats:=Signaux[i].EtatSignal and not($3F);
      // et allumer le nouveau
      etats:=setbit(etats,aspect);
      Signaux[i].EtatSignal:=etats;
    end;
    // signalisation combinée
    if (aspect and $1C0)<>0 then
    begin
      etats:=Signaux[i].EtatSignal;
      //si le bit 15 (bita1) est à 1, c'est l'indicateur de mise à 1
      if testBit(aspect,bita1) then
      begin
         etats:=etats or (aspect and $1C0);   // mise à 1 par masquage
         Signaux[i].EtatSignal:=Signaux[i].EtatSignal or etats;
      end
      else
      begin
        etats:=etats and not(aspect and $1c0); // mise à 0 par masquage
        Signaux[i].EtatSignal:=Signaux[i].EtatSignal and etats;
      end;
    end;
  end;
end;

// mise à jour état signal complexe francais dans le tableau de bits du signal EtatSignalCplx
// adresse : adresse du signal complexe
// Aspect : code représentant l'état du signal de 0 à 15
// La signalisation combinée est à partir du bit 10 (ralen 30)
procedure Maj_Etat_Signal_fr(adresse,aspect : integer);
var i : integer;
begin
// ('0carré','1sémaphore','2sémaphore cli','3vert','4vert cli','5violet',
//           '6blanc','7blanc cli','8jaune','9jaune cli','10ral 30','11ral 60','12rappel 30','13rappel 60');

  if debug=3 then formprinc.Caption:='Maj_Etat_Signal '+IntToSTR(adresse);
  i:=Index_Signal(adresse);
  if testBit(Signaux[i].EtatSignal,aspect)=false then  // si le bit dans l'état du signal n'est pas allumé, procéder.
  begin
    // effacement du motif de bits en fonction du nouvel état demandé suivant la règle des signaux complexes
    if (aspect<=blanc_cli) then
    begin
      Signaux[i].EtatSignal:=0;  //Tout aspect <=7 efface les autres
    end;
    if (aspect=jaune) then // jaune
    begin
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,jaune_cli); // cas du jaune: efface le bit du jaune clignotant (bit 9)
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,ral_30);  // cas du jaune: efface le bit du ral_30 (bit 10)
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,ral_60);  // cas du jaune: efface le bit du ral_60 (bit 11)
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($00FF);   // et effacer les bits 0 à 7
    end;
    if (aspect=jaune_cli) then // jaune clignotant
    begin
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,jaune);   // efface le bit du jaune  (bit 8)
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,ral_30);  // efface ral 30
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and $FF00;   // et effacer les bits 0 à 7
    end;
    if (aspect=ral_30) then // ralentissement 30
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($3BFF);   // cas du ral 30: efface les bits 0 1 2 3 4 5 6 7 8 9 11 12 et 13 :  11 1000 1111 1111
    end;
    if (aspect=ral_60) then // ralentissement 60
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($35FF);   // cas du ral 60: efface les bits 8 10 12 et 13 et de 0 à 7  : 11 0100 1111 1111
    end;
    if (aspect=rappel_30) then // rappel 30
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($2cff);   // cas du rappel 30: efface les bits 0 1 2 3 4 5 6 7 10 11 et 13 : 10 1100 1111 0000
    end;
    if (aspect=rappel_60) then // rappel 60
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($1Cff);   // cas du rappel 60: efface les bits 0 1 2 3 4 5 6 7 10 11 et 12  1 1100 1111 0000
    end;
    if (aspect=aspect8) then // ral_60_jaune_cli décodeur LDT
    begin
      Signaux[i].EtatSignal:=jaune_cli_F or ral_60_F;   // cas du ralentissement 60 + avertissement clignotant : efface les bits 10 11 et 12
    end;
    if (aspect<>aspect8) then
    begin
      Signaux[i].EtatSignal:=SetBit(Signaux[i].EtatSignal,aspect);   // allume le numéro du bit de la fonction du signal
    end;
  end;
  if debug=3 then formprinc.Caption:='';
end;

procedure Maj_Etat_Signal(adresse,aspect : integer);
var i,d : integer;
begin
  i:=Index_Signal(adresse);
  d:=Signaux[i].aspect;
  if d=20 then Maj_Etat_Signal_belge(adresse,aspect)
  else Maj_Etat_Signal_fr(adresse,aspect);
end;

{=============================================
envoie les données au décodeur digital bahn équipé du logiciel "led_schalten"
sur un panneau directionnel - adresse : adresse du signal - code de 1 à 3 pour allumer
; le panneau directionnel à 1, 2 ou 3 leds.
============================================== }
procedure envoi_directionBahn(adr : integer;code : integer);
var i : integer;
begin
  i:=Index_Signal(adr);
  if (Signaux[i].EtatSignal<>code) then
  begin
    if (traceSign) then Affiche('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);
    if AffSignal then AfficheDebug('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);

    case code of
    0 :  begin      pilote_acc(adr,1,signal);   // sortie 1 à 0
                    sleep(Tempo_Signal);
                    pilote_acc(adr+1,1,signal); // sortie 2 à 0
                    sleep(Tempo_Signal);
                    pilote_acc(adr+2,1,signal); // sortie 3 à 0
                    sleep(Tempo_Signal);
         end;
    1 :  begin      pilote_acc(adr,2,signal);   // sortie 1 à 1
                    sleep(Tempo_Signal);
                    pilote_acc(adr+1,1,signal); // sortie 2 à 0
                    sleep(Tempo_Signal);
                    pilote_acc(adr+2,1,signal); // sortie 3 à 0
                    sleep(Tempo_Signal);
          end;
    2 :  begin      pilote_acc(adr,2,signal);   // sortie 1 à 1
                    sleep(Tempo_Signal);
                    pilote_acc(adr+1,2,signal); // sortie 2 à 1
                    sleep(Tempo_Signal);
                    pilote_acc(adr+2,1,signal); // sortie 3 à 0
                    sleep(Tempo_Signal);
          end;
    3 :  begin      pilote_acc(adr,2,signal);   // sortie 1 à 1
                    sleep(Tempo_Signal);
                    pilote_acc(adr+1,2,signal); // sortie 2 à 1
                    sleep(Tempo_Signal);
                    pilote_acc(adr+2,2,signal); // sortie 3 à 1
                    sleep(Tempo_Signal);
          end;
    end;
    Signaux[i].EtatSignal:=code;
    Dessine_signal_mx(Signaux[Index_Signal(adr)].Img.Canvas,0,0,1,1,adr,1);
  end;
end;

{ =============================================
envoie les données au signal de direction pour un décodeur CDF
adresse : adresse du signal - code de 1 à 3 pour allumer
le panneau directionnel à 1, 2, 3 ou 4 leds.
============================================== }
procedure envoi_directionCDF(adr : integer;code : integer);
var i : integer;
begin
  i:=Index_Signal(adr);
  if (Signaux[i].EtatSignal<>code) then
  begin
    if traceSign then Affiche('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
    if AffSignal then AfficheDebug('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

    case code of
      // éteindre toutes les leds
    0 :
      begin
        pilote_acc(adr,1,signal) ;
        sleep(200);
      end;
      // code 1 : allume le feu le plus à gauche
    1 :
      begin
        pilote_acc(adr,2,signal) ;
        sleep(200);
      end;
    2 : //allume 2 feux
      begin
        pilote_acc(adr+1,1,signal) ;
        sleep(200);
      end;
      // code 3 : allume 3 feux
    3 :
      begin
        pilote_acc(adr+1,2,signal) ;
        sleep(200);
      end;
    end;
    Signaux[i].EtatSignal:=code;
  end;
end;

procedure Envoi_DirectionLEB(Adr : integer;code : integer);
var i : integer;
begin
  i:=Index_Signal(i);
  if Signaux[i].EtatSignal<>code then
  begin
    if traceSign then Affiche('signal directionnel LEB: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
    if affsignal then AfficheDebug('signal directionnel LEB: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

    case code of
    0 : begin pilote_acc(adr+5,2,signal) ;  pilote_acc(adr+6,2,signal) ;end;  //00
    1 : begin pilote_acc(adr+5,1,signal) ;  pilote_acc(adr+6,2,signal) ;end;  //10
    2 : begin pilote_acc(adr+5,2,signal) ;  pilote_acc(adr+6,1,signal) ;end;  //01
    3 : begin pilote_acc(adr+5,1,signal) ;  pilote_acc(adr+6,1,signal) ;end;  //11
    end;
    Signaux[i].EtatSignal:=code;
  end;
end;

{==========================================================================
envoie les données au décodeur CDF
===========================================================================*}
procedure envoi_CDF(adresse : integer);
var
  combine,aspect,code : integer;
  i,nombre : integer;
  s : string;

  procedure ecrire(v : integer);
  var j : integer;
  begin
    // bit 0
    if nombre>0 then
    begin
      if (v and 1)=0 then j:=1 else j:=2;
      pilote_acc(adresse,j,signal);
    end;

    // bit 1
    if nombre>1 then
    begin
      if (v and 2)=0 then j:=1 else j:=2;
      pilote_acc(adresse+1,j,signal);
    end;

    // bit 2
    if nombre>2 then
    begin
      if (v and 4)=0 then j:=1 else j:=2;
      pilote_acc(adresse+2,j,signal);
    end;

    // bit 3
    if nombre>3 then
    begin
      if (v and 8)=0 then j:=1 else j:=2;
      pilote_acc(adresse+3,j,signal);
    end;
  end;

  procedure ecrire_2(v : integer);
  var bit2 : integer;
  begin
    // bit 0-1 (adresse)
    if nombre>0 then
    begin
      bit2:=v and 3;
      if bit2=0 then
      begin
        // raz les 2 bits
        Pilote_acc0_X(adresse,1);Pilote_acc0_X(adresse,2);
      end;
      if bit2=1 then pilote_acc(adresse,1,signal);
      if bit2=2 then pilote_acc(adresse,2,signal);
    end;

    // bit 2-3 (adresse+1)
    if nombre>1 then
    begin
      inc(adresse);
      bit2:=v and $c;  // 1100
      if bit2=0 then
      begin
        // raz les 2 bits
        Pilote_acc0_X(adresse,1);Pilote_acc0_X(adresse,2);
      end;
      if bit2=4 then pilote_acc(adresse,1,signal);
      if bit2=8 then pilote_acc(adresse,2,signal);
    end;

    // bit 4-5 (adresse+2)
    if nombre>2 then
    begin
      inc(adresse);
      bit2:=v and $30;  // 11 0000
      if bit2=0 then
      begin
        // raz les 2 bits
        Pilote_acc0_X(adresse,1);Pilote_acc0_X(adresse,2);
      end;
      if bit2=16 then pilote_acc(adresse,1,signal);
      if bit2=32 then pilote_acc(adresse,2,signal);
    end;

    // bit 6-7 (adresse+3)
    if nombre>3 then
    begin
      inc(adresse);
      bit2:=v and $c0;  // 1100 0000
      if bit2=0 then
      begin
        // raz les 2 bits
        Pilote_acc0_X(adresse,1);Pilote_acc0_X(adresse,2);
      end;
      if bit2=64  then pilote_acc(adresse,1,signal);
      if bit2=128 then pilote_acc(adresse,2,signal);
    end;
  end;

  procedure ecrire_3(v : integer);
  var bit2 : integer;
  begin
    // adresse+0
    if (nombre>0) then
    begin
      bit2:=v and 3;  //0000 0011
      if bit2<>0 then
      begin
        pilote_acc(adresse,bit2,signal);
        exit;
      end;
    end;

    // adresse+1
    if (nombre>1) then
    begin
      bit2:=v and $c; //0000 1100
      if bit2<>0 then
     begin
        pilote_acc(adresse+1,bit2 shr 2,signal);
        exit;
      end;
    end;

    // adresse+2
    if (nombre>2) then
    begin
      bit2:=v and $30; //0011 0000
      if bit2<>0 then
      begin
        pilote_acc(adresse+2,bit2 shr 4,signal);
        exit;
      end;
    end;

    // adresse+3
    if (nombre>3) then
    begin
      bit2:=v and $c0; //1100 0000
      if bit2<>0 then
      begin
        pilote_acc(adresse+3,bit2 shr 6,signal);
      end;
    end;
  end;

begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    nombre:=Signaux[i].Na;          // nombre d'adresses occupées par le signal
    code_to_aspect(code,aspect,combine);
    s:='Signal CDF: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;


    if combine=-1 then
    case aspect of
      carre         : ecrire_3(Signaux[i].SR[1].sortie1);
      semaphore     : ecrire_3(Signaux[i].SR[2].sortie1);
      semaphore_cli : ecrire_3(Signaux[i].SR[3].sortie1);
      vert          : ecrire_3(Signaux[i].SR[4].sortie1);
      vert_cli      : ecrire_3(Signaux[i].SR[5].sortie1);
      violet        : ecrire_3(Signaux[i].SR[6].sortie1);
      blanc         : ecrire_3(Signaux[i].SR[7].sortie1);
      blanc_cli     : ecrire_3(Signaux[i].SR[8].sortie1);
      jaune         : ecrire_3(Signaux[i].SR[9].sortie1);
      jaune_cli     : ecrire_3(Signaux[i].SR[10].sortie1);
    end;
    if aspect=-1 then
    case combine of
      ral_30        : ecrire_3(Signaux[i].SR[11].sortie1);
      ral_60        : ecrire_3(Signaux[i].SR[12].sortie1);
      rappel_30     : ecrire_3(Signaux[i].SR[14].sortie1);
      rappel_60     : ecrire_3(Signaux[i].SR[15].sortie1);
    end;
    if (aspect<>-1) and (combine<>-1) then
    begin
      if (Combine=ral_60)    and (aspect=jaune_cli) then ecrire_3(Signaux[i].SR[13].sortie1);
      if (Combine=rappel_30) and (aspect=jaune)     then ecrire_3(Signaux[i].SR[16].sortie1);
      if (Combine=rappel_30) and (aspect=jaune_cli) then ecrire_3(Signaux[i].SR[17].sortie1);
      if (Combine=rappel_60) and (aspect=jaune)     then ecrire_3(Signaux[i].SR[18].sortie1);
      if (Combine=rappel_60) and (aspect=jaune_cli) then ecrire_3(Signaux[i].SR[19].sortie1);
    end;
  end;
end;

{==========================================================================
envoie les données au décodeur SR
===========================================================================*}
procedure envoi_SR(adresse : integer);
var
  code : word;
  index,i,etat,nAdr : integer;
  s0,s1 : boolean;
  s : string;
begin
  index:=Index_Signal(adresse);
  if (Signaux[index].AncienEtat<>Signaux[index].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[index].EtatSignal;
    //code_to_aspect(code,aspect,combine);
    s:='Signal SR: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    etat:=code_to_etat(code);
    nAdr:=Signaux[index].Na;

    if index<>0 then
    begin
      {
      i:=0;
      // trouve l'index dans la configuration du signal correspondant à son état demandé
      repeat
        inc(i);
        s0:=etatsDefSR[i]=etat;
        s1:=false;
       // s1:=Signaux[index].SR[i].sortie1=etat;
       // s0:=Signaux[index].SR[i].sortie0=etat;
      until s0 or s1 or (i=8) or (i=nAdr);

      if s0 then
      begin
        affiche('trouvé index '+IntToSTR(i-1),clyellow);
        if index mod 2 = 0 then Pilote_acc(adresse+i-1,2,signal) else Pilote_acc(adresse+i-1,1,signal);
      end;
      if s1 then
      begin
        affiche('trouvé en sortie1 index '+IntToSTR(i-1),clyellow);
        Pilote_acc(adresse+i-1,1,signal);
      end;
      if not(s0) and not(s1) then
      Affiche('Erreur 621 : décodeur SR du signal '+intToSTR(adresse)+' pas trouvé l''état demandé dans sa configuration',clOrange);
      }

      i:=0;
      // trouve l'index dans la configuration du signal correspondant à son état demandé
      repeat
        inc(i);
        s0:=Signaux[index].SR[i].sortie0=etat;
        s1:=Signaux[index].SR[i].sortie1=etat;
      until s1 or s0 or (i=8) or (i=nAdr);

      if s1 then
      begin
        //affiche('trouvé en sortie1 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,2,signal);
      end;
      if s0 then
      begin
        //affiche('trouvé en sortie0 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,1,signal);
      end;
      if not(s0) and not(s1) then
        Affiche('Erreur 621 : décodeur SR du signal '+intToSTR(adresse)+' pas trouvé l''état demandé '+chaine_signal(etat)+' dans sa configuration',clOrange);

    end;
  end;
end;


{==========================================================================
envoie les données du signal au décodeur LEB
===========================================================================*}
procedure envoi_LEB(adresse : integer);
var code,aspect,combine : integer;
    index : integer;
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
      Pilote_acc(adresse+i,octet,signal);
      // le décodeur LEB nécessite qu'on envoie 0 après son pilotage ; si on est en mode usb ou ethernet
      if (portCommOuvert or parSocketLenz) then Pilote_acc0_X(adresse+i,octet);
    end;
    //Affiche(inttoStr(selection),clOrange);
    //Affiche(s,clOrange);
  end;

begin
  index:=Index_Signal(adresse);
  if (Signaux[index].AncienEtat<>Signaux[index].EtatSignal) then //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[index].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal LEB: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    Sleep(60);  // si le signal se met à jour à la suite d'un positionnement d'aiguillage, on peut avoir le message station occupée
    //Affiche(IntToSTR(aspect)+' '+inttoSTR(combine),clOrange);
    if (aspect<>-1) and (combine=-1) then
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
    if (combine<>-1) and (aspect=-1) then
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

// pilote le décodeur arcomora
procedure envoi_arcomora(adresse :integer);
var asp,aspect,combine,code,offset,sortie : integer;
    s : string;
begin
  index:=Index_Signal(adresse);
  if (Signaux[index].AncienEtat<>Signaux[index].EtatSignal) then //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[index].EtatSignal;
    asp:=Signaux[index].aspect;
    code_to_aspect(code,aspect,combine);
    s:='Signal Arcomora: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    Sleep(60);
    if asp=2 then
    begin
      case aspect of
        violet        : begin offset:=0;sortie:=2;end;
        blanc         : begin offset:=0;sortie:=1;end;
        blanc_cli     : begin offset:=1;sortie:=1;end;
      end;
    end;

    if asp=3 then
    begin
      case aspect of
        vert          : begin offset:=0;sortie:=1;end;
        jaune         : begin offset:=0;sortie:=2;end;
        semaphore     : begin offset:=1;sortie:=1;end;
        vert_cli      : begin offset:=1;sortie:=2;end;
        semaphore_cli : begin offset:=2;sortie:=1;end;
        jaune_cli     : begin offset:=2;sortie:=2;end;
      end;
    end;

    if (asp=4) or (asp=5) then
    begin
      case aspect of
        vert          : begin offset:=0;sortie:=1;end;
        jaune         : begin offset:=0;sortie:=2;end;
        semaphore     : begin offset:=1;sortie:=1;end;
        carre         : begin offset:=1;sortie:=2;end;
        vert_cli      : begin offset:=2;sortie:=1;end;
        jaune_cli     : begin offset:=2;sortie:=2;end;
        semaphore_cli : begin offset:=3;sortie:=1;end;
      end;
    end;

    if (asp=7) then
    begin
      case aspect of
        vert          : begin offset:=0;sortie:=1;end;
        jaune         : begin offset:=0;sortie:=2;end;
        semaphore     : begin offset:=1;sortie:=1;end;
        carre         : begin offset:=1;sortie:=2;end;
        vert_cli      : begin offset:=4;sortie:=1;end;
        semaphore_cli : begin offset:=4;sortie:=2;end;
      end;
      case combine of
        ral_30        : begin offset:=2;sortie:=1;end;
        ral_60        : begin offset:=3;sortie:=1;end;
      end;
    end;

    if (asp=9) then
    begin
      case aspect of
        vert          : begin offset:=0;sortie:=1;end;
        jaune         : begin offset:=0;sortie:=2;end;
        semaphore     : begin offset:=1;sortie:=1;end;
        carre         : begin offset:=1;sortie:=2;end;
        vert_cli      : begin offset:=4;sortie:=1;end;
        semaphore_cli : begin offset:=4;sortie:=2;end;
      end;
      case combine of
        ral_30        : begin offset:=2;sortie:=1;end;
        rappel_30     : begin offset:=2;sortie:=2;end;
        ral_60        : begin offset:=3;sortie:=1;end;
        rappel_60     : begin offset:=3;sortie:=2;end;
      end;
    end;

  end;
  Pilote_acc(adresse+offset,sortie,signal);

end;


(*==========================================================================
envoie les données au décodeur NMRA étendu - ne peut pas marcher par XpressNet évidemment
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
var valeur,i : integer ;
    aspect,combine,code : integer;
    s : string;
begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal NMRA: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

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

    pilote_acc(adresse,valeur,signal);
  end;
end;

// décodeur unisemaf (paco)
procedure envoi_UniSemaf(adresse: integer);
var modele,index: integer ;
    s : string;
    code,aspect,combine : integer;
begin
  index:=Index_Signal(adresse);    // tranforme l'adresse du signal en index tableau

  if (Signaux[index].AncienEtat<>Signaux[index].EtatSignal) then
  begin
    code:=Signaux[index].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal Unisemaf: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    // pour Unisemaf, la cible est définie dans le champ Unisemaf de la structure Tsignal

    modele:=Signaux[index].Unisemaf;
    if modele=0 then Affiche('Erreur 741 : spécification unisemaf signal '+intToSTR(adresse)+' non défini',clred);
    //Affiche('Adresse='+intToSTR(Adresse)+' code='+intToSTR(code)+' combine'+intToSTR(combine),clyellow);

    // pilotage qui marche chez JEF
    if algo_Unisemaf=1 then
    begin
      if modele=2 then // 2 feux
      begin
        if aspect=blanc then      pilote_acc(adresse,1,signal);
        if aspect=blanc_cli then  pilote_acc(adresse,1,signal);
        if aspect=violet then     pilote_acc(adresse,2,signal);
      end;

      if modele=3 then // 3 feux
      begin
        if aspect=vert then       pilote_acc(adresse,1,signal);
        if aspect=vert_cli then   pilote_acc(adresse,1,signal);
        if aspect=semaphore then  pilote_acc(adresse,2,signal);
        if aspect=semaphore_cli then pilote_acc(adresse,2,signal);

        if aspect=jaune then      pilote_acc(adresse+1,1,signal);
        if aspect=jaune_cli then  pilote_acc(adresse+1,1,signal);
      end;
      if modele=4 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          carre                 : pilote_acc(adresse+1,2,signal);
          end;
        end;
      // 51=carré + blanc
      if modele=51 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          carre                 : pilote_acc(adresse+1,2,signal);
          blanc                 : pilote_acc(adresse+2,1,signal);
          blanc_cli             : pilote_acc(adresse+2,1,signal);
        end;
      end;
      // 52=VJR + blanc + violet
      if modele=52 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          violet                : pilote_acc(adresse+2,1,signal);
          blanc                 : pilote_acc(adresse+1,2,signal);
          blanc_cli             : pilote_acc(adresse+1,2,signal);
        end;
      end;
      // 71=VJR + ralentissement 30
      if modele=71 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
        end;
        if combine=ral_30 then pilote_acc(adresse+1,2,signal);
      end;
      // 72=VJR + carré + ralentissement 30
      if modele=72 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          carre                 : pilote_acc(adresse+1,2,signal);
        end;
        if combine=ral_30 then pilote_acc(adresse+2,1,signal);
      end;
      // 73=VJR + carré + ralentissement 60
      if modele=73 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          carre                 : pilote_acc(adresse+1,2,signal);
        end;
        if combine=ral_60 then pilote_acc(adresse+2,1,signal);
      end;
      // 91=VJR + carré + rappel 30
      if modele=91 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          carre                 : pilote_acc(adresse+1,2,signal);
        end;
        if combine=rappel_30 then pilote_acc(adresse+2,1,signal);
      end;

      // 92=VJR + carré + rappel 60
      if modele=92 then
      begin
        case aspect of
          vert                  : pilote_acc(adresse,1,signal);
          vert_cli              : pilote_acc(adresse,1,signal);
          jaune                 : pilote_acc(adresse,2,signal);
          jaune_cli             : pilote_acc(adresse,2,signal);
          semaphore             : pilote_acc(adresse+1,1,signal);
          semaphore_cli         : pilote_acc(adresse+1,1,signal);
          carre                 : pilote_acc(adresse+1,2,signal);
        end;
        if combine=rappel_60 then pilote_acc(adresse+2,1,signal);
      end;

      // 93=VJR + carré + ral30 + rappel 30
      if modele=93 then
      begin
        if combine=-1 then //pas de sig combinée
        begin
          if aspect=vert                  then pilote_acc(adresse,1,signal);
          if aspect=vert_cli              then pilote_acc(adresse,1,signal);
          if aspect=jaune                 then pilote_acc(adresse,2,signal);
          if aspect=jaune_cli             then pilote_acc(adresse,2,signal);
          if aspect=semaphore             then pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli         then pilote_acc(adresse+1,1,signal);
          if aspect=carre                 then pilote_acc(adresse+1,2,signal);
        end;
        if combine=ral_30                then pilote_acc(adresse+2,1,signal);
        if combine=rappel_30             then pilote_acc(adresse+2,2,signal);
        if (aspect=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,signal);
      end;

      // 94=VJR + carré + ral60 + rappel60
      if modele=94 then
      begin
        if combine=-1 then
        begin
          if aspect=vert                  then pilote_acc(adresse,1,signal);
          if aspect=vert_cli              then pilote_acc(adresse,1,signal);
          if aspect=jaune                 then pilote_acc(adresse,2,signal);
          if aspect=jaune_cli             then pilote_acc(adresse,2,signal);
          if aspect=semaphore             then pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli         then pilote_acc(adresse+1,1,signal);
          if aspect=carre                 then pilote_acc(adresse+1,2,signal);
        end;
        if combine=ral_60                then pilote_acc(adresse+2,1,signal);
        if combine=rappel_60             then pilote_acc(adresse+2,2,signal);
        if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,signal);
      end;
      // 95=VJR + carré + ral30 + rappel 60
      if modele=95 then
      begin
        if combine=-1 then
        begin
          if aspect=vert                  then pilote_acc(adresse,1,signal);
          if aspect=vert_cli              then pilote_acc(adresse,1,signal);
          if aspect=jaune                 then pilote_acc(adresse,2,signal);
          if aspect=jaune_cli             then pilote_acc(adresse,2,signal);
          if aspect=semaphore             then pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli         then pilote_acc(adresse+1,1,signal);
          if aspect=carre                 then pilote_acc(adresse+1,2,signal);
        end;
        if combine=ral_30                then pilote_acc(adresse+2,1,signal);
        if combine=rappel_60             then pilote_acc(adresse+2,2,signal);
        if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,signal);
      end;
      // 96=VJR + blanc + carré + ral30 + rappel30
      if modele=96 then
      begin
        if combine=-1 then
        begin
          if aspect=vert               then pilote_acc(adresse,1,signal);
          if aspect=vert_cli           then pilote_acc(adresse,1,signal);
          if aspect=jaune              then pilote_acc(adresse,2,signal);
          if aspect=jaune_cli          then pilote_acc(adresse,2,signal);
          if aspect=semaphore          then pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli      then pilote_acc(adresse+1,1,signal);
          if aspect=carre              then pilote_acc(adresse+1,2,signal);
          if aspect=blanc              then pilote_acc(adresse+3,2,signal);
          if aspect=blanc_cli          then pilote_acc(adresse+3,2,signal);
        end;
        if combine=ral_30             then pilote_acc(adresse+2,1,signal);
        if combine=rappel_30          then pilote_acc(adresse+2,2,signal);
        if (aspect=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,signal);
      end;
      // 97=VJR + blanc + carré + ral30 + rappel60
      if modele=97 then
      begin
        if combine=-1 then
        begin
          if aspect=vert                  then pilote_acc(adresse,1,signal);
          if aspect=vert_cli              then pilote_acc(adresse,1,signal);
          if aspect=jaune                 then pilote_acc(adresse,2,signal);
          if aspect=jaune_cli             then pilote_acc(adresse,2,signal);
          if aspect=semaphore             then pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli         then pilote_acc(adresse+1,1,signal);
          if aspect=carre                 then pilote_acc(adresse+1,2,signal);
          if aspect=blanc                 then pilote_acc(adresse+3,2,signal);
          if aspect=blanc_cli             then pilote_acc(adresse+3,2,signal);
        end;
        if combine=ral_30                then pilote_acc(adresse+2,1,signal);
        if combine=rappel_60             then pilote_acc(adresse+2,2,signal);
        if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,signal);
      end;

      // 98=VJR + blanc + violet + ral30 + rappel30
      if modele=98 then
      begin
        if combine=-1 then
        begin
          if aspect=vert then               pilote_acc(adresse,1,signal);
          if aspect=vert_cli then           pilote_acc(adresse,1,signal);
          if aspect=jaune then              pilote_acc(adresse,2,signal);
          if aspect=jaune_cli then          pilote_acc(adresse,2,signal);
          if aspect=semaphore then          pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli then      pilote_acc(adresse+1,1,signal);
          if aspect=violet then             pilote_acc(adresse+1,2,signal);
          if aspect=blanc then              pilote_acc(adresse+3,2,signal);
          if aspect=blanc_cli then          pilote_acc(adresse+3,2,signal);
        end;
        if (aspect=jaune) and (combine=rappel_30) then pilote_acc(adresse+3,1,signal);
        if combine=ral_30 then             pilote_acc(adresse+2,1,signal);
        if combine=rappel_30 then          pilote_acc(adresse+2,2,signal);
      end;
      // 99=VJR + blanc + violet + ral30 + rappel60
      if modele=99 then
      begin
        if combine=-1 then
        begin
          if aspect=vert                  then pilote_acc(adresse,1,signal);
          if aspect=vert_cli              then pilote_acc(adresse,1,signal);
          if aspect=jaune                 then pilote_acc(adresse,2,signal);
          if aspect=jaune_cli             then pilote_acc(adresse,2,signal);
          if aspect=semaphore             then pilote_acc(adresse+1,1,signal);
          if aspect=semaphore_cli         then pilote_acc(adresse+1,1,signal);
          if aspect=violet                then pilote_acc(adresse+1,2,signal);
          if aspect=blanc                 then pilote_acc(adresse+3,2,signal);
          if aspect=blanc_cli             then pilote_acc(adresse+3,2,signal);
        end;
        if (aspect=jaune) and (combine=rappel_60) then pilote_acc(adresse+3,1,signal);
        if combine=ral_30                then pilote_acc(adresse+2,1,signal);
        if combine=rappel_60             then pilote_acc(adresse+2,2,signal);
      end;
    end;

    // algo de la doc qui ne marche pas chez JEF
    if algo_Unisemaf=2 then
    begin
        if modele=2 then // 2 feux
        begin
          if (aspect=blanc) or (aspect=blanc_cli) then pilote_acc(adresse,1,signal);
          if aspect=violet then     pilote_acc(adresse,2,signal);
        end;

        if modele=3 then // 3 feux
        begin
          if aspect=vert then       pilote_acc(adresse,1,signal);
          if aspect=vert_cli then   pilote_acc(adresse,1,signal);

          if aspect=semaphore then  pilote_acc(adresse,2,signal);
          if aspect=semaphore_cli then pilote_acc(adresse,2,signal);

          if aspect=jaune then      pilote_acc(adresse+1,1,signal);
          if aspect=jaune_cli then  pilote_acc(adresse+1,1,signal);
        end;

        if modele=4 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,1,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,1,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,1,signal);end;
          carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          end;
        end;
        // 51=carré + blanc
        if modele=51 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,2,signal);end;
          carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          blanc,blanc_cli       : pilote_acc(adresse+2,1,signal);
          end;
        end;
        // 52=VJR + blanc + violet
        if modele=52 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,2,signal);end;
          blanc,blanc_cli       : pilote_acc(adresse+1,2,signal);
          violet                : pilote_acc(adresse+2,1,signal);
          end;
        end;
        // 71=VJR + ralentissement 30
        if modele=71 then
        begin
          case aspect of
          vert,vert_cli          : pilote_acc(adresse+1,1,signal);
          jaune,jaune_cli        : pilote_acc(adresse,1,signal);
          semaphore,semaphore_cli: pilote_acc(adresse,2,signal);
          end;
          if combine=ral_30 then pilote_acc(adresse+1,2,signal);
        end;
        // 72=VJR + carré + ralentissement 30
        if modele=72 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,2,signal);end;
          carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          end;
          if combine=ral_30 then pilote_acc(adresse+2,1,signal); //pilote_acc(adresse+2,2,signal); impossible en lenz
        end;
        // 73=VJR + carré + ralentissement 60
        if modele=73 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,2,signal);end;
          carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          end;
          if combine=ral_60 then pilote_acc(adresse+2,1,signal); //pilote_acc(adresse+2,2,signal); impossible en lenz
        end;
        // 91=VJR + carré + rappel 30
        if modele=91 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,2,signal);end;
          carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          end;
          if combine=rappel_30 then pilote_acc(adresse+2,1,signal);//pilote_acc(adresse+2,2,signal); impossible en lenz
        end;

        // 92=VJR + carré + rappel 60
        if modele=92 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+2,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+2,2,signal);end;
          carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          end;
          if combine=rappel_60 then pilote_acc(adresse+2,1,signal);//pilote_acc(adresse+2,2,signal); impossible en lenz
        end;

        // 93=VJR + carré + ral30 + rappel 30
        if modele=93 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,1,signal);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,1,signal);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,1,signal);end;
            carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,1,signal);end;
          if combine=rappel_30      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,1,signal);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_30) then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,1,signal);end;
        end;

        // 94=VJR + carré + ral60 + rappel60
        if modele=94 then
        begin
          case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,1,signal);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,1,signal);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,1,signal);end;
            carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
          end;
          if combine=ral_60         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,1,signal);end;
          if combine=rappel_60      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,1,signal);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60) then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,1,signal);end;
        end;
        // 95=VJR + carré + ral30 + rappel 60
        if modele=95 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,1,signal);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,1,signal);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,1,signal);end;
            carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,1,signal);end;
          if combine=rappel_60      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,1,signal);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60)
                                    then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,1,signal);end;
        end;
        // 96=VJR + blanc + carré + ral30 + rappel30
        if modele=96 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,2,signal);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,2,signal);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,2,signal);end;
            carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
            blanc,blanc_cli       : pilote_acc(adresse+3,1,signal);
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,2,signal);end;
          if combine=rappel_30      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_30)
                                    then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
        end;

        // 97=VJR + blanc + carré + ral30 + rappel60
        if modele=97 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,2,signal);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,2,signal);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,2,signal);end;
            carre                 : begin pilote_acc(adresse,2,signal);pilote_acc(adresse+1,2,signal);end;
            blanc,blanc_cli       : pilote_acc(adresse+3,1,signal);
            end;
        if combine=ral_30         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,2,signal);end;
        if combine=rappel_60      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
        if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60)
                                  then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
        end;

        // 98=VJR + blanc + violet + ral30 + rappel30
        if modele=98 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,2,signal);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,2,signal);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,2,signal);end;
            blanc,blanc_cli       : pilote_acc(adresse+1,2,signal);
            violet                : pilote_acc(adresse+3,1,signal);
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,2,signal);end;
          if combine=rappel_30      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_30)
                                    then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
      end;

      // 99=VJR + blanc + violet + ral30 + rappel60
      if modele=99 then
      begin
        case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,signal);pilote_acc(adresse+3,2,signal);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,signal);pilote_acc(adresse+3,2,signal);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,signal);pilote_acc(adresse+3,2,signal);end;
          blanc,blanc_cli       : pilote_acc(adresse+1,2,signal);
          violet                : pilote_acc(adresse+3,1,signal);
        end;
        if combine=ral_30         then begin pilote_acc(adresse+2,1,signal);pilote_acc(adresse+3,2,signal);end;
        if combine=rappel_60      then begin pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
        if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60)
                                    then begin pilote_acc(adresse,1,signal);pilote_acc(adresse+2,2,signal);pilote_acc(adresse+3,2,signal);end;
      end;
    end;
  end;
end;

// décodeur b-models
// l'adresse du signal doit être un multiple de 8 +1
// un signal peut occuper 1 3 4 ou 5 adresses
procedure envoi_b_models(adresse : integer);
var na,code,aspect,combine : integer;
    afb,recht,i : integer;
    s : string;
begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    combine:=code and $01c0;
    s:='Signal b_models: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    na:=Signaux[i].Na;  // nombre d'adresses
    // doc VB 5 lampes + chiffre + V
    // marqué recht et Afb dans la doc !!
    afb:=1; // afb rouge
    recht:=2; // recht vert
    if aspect=rouge then
    begin
      pilote_acc(adresse,afb,signal);
      if (na>=4) then
      begin
        // chiffre                        allume                                éteint
        if testbit(combine,chiffre) then pilote_acc(adresse+3,recht,signal) else pilote_acc(adresse+3,afb,signal)
      end;
      if (na>=5) then
      begin
        // chevron
        if testbit(combine,chevron) then pilote_acc(adresse+4,recht,signal) else pilote_acc(adresse+4,afb,signal)
      end;
    end;
    if aspect=vert then
    begin
      pilote_acc(adresse,recht,signal);
      if (na>=4) then
      begin
        // chiffre
        if testbit(combine,chiffre) then pilote_acc(adresse+3,recht,signal) else pilote_acc(adresse+3,afb,signal)
      end;
      if (na>=5) then
      begin
        // chevron
        if testbit(combine,chevron) then pilote_acc(adresse+4,recht,signal) else pilote_acc(adresse+4,afb,signal)
      end;
    end;
    if na=1 then exit;
    if aspect=deux_jaunes then
    begin
      pilote_acc(adresse+1,afb,signal);
      if (na>=4) then
      begin
        // chiffre
        if testbit(combine,chiffre) then pilote_acc(adresse+3,recht,signal) else pilote_acc(adresse+3,afb,signal)
      end;
      if (na>=5) then
      begin
        // chevron
        if testbit(combine,chevron) then pilote_acc(adresse+4,recht,signal) else pilote_acc(adresse+4,afb,signal)
      end;
    end;
    if aspect=vert_jaune_H  then
    begin
      pilote_acc(adresse+1,recht,signal);
      if (na>=4) then
      begin
        // chiffre
        if testbit(combine,chiffre) then pilote_acc(adresse+3,recht,signal) else pilote_acc(adresse+3,afb,signal)
      end;
      if (na>=5) then
      begin
        // chevron
        if testbit(combine,chevron) then pilote_acc(adresse+4,recht,signal) else pilote_acc(adresse+4,afb,signal)
      end;
    end;
    if aspect=vert_jaune_V then
    begin
      pilote_acc(adresse+2,afb,signal)  ;
      if (na>=4) then
      begin
        // chiffre
        if testbit(combine,chiffre) then pilote_acc(adresse+3,recht,signal) else pilote_acc(adresse+3,afb,signal)
      end;
      if (na>=5) then
      begin
        // chevron
        if testbit(combine,chevron) then pilote_acc(adresse+4,recht,signal) else pilote_acc(adresse+4,afb,signal)
      end;
    end;
    if aspect=rouge_blanc then
    begin
      pilote_acc(adresse+2,recht,signal);
      if (na>=4) then
      begin
        // chiffre
        if testbit(combine,chiffre) then pilote_acc(adresse+3,recht,signal) else pilote_acc(adresse+3,afb,signal)
      end;
      if (na>=5) then
      begin
        // chevron
        if testbit(combine,chevron) then pilote_acc(adresse+4,recht,signal) else pilote_acc(adresse+4,afb,signal)
      end;
    end;
  end;
end;

{==========================================================================
envoie les données au décodeur LDT_nmbs (belge)
ce décodeur ne permet seulement que 4 aspects !!
rouge
vert
2 jaune (slow approch de la doc ldt)
blanc
}
procedure envoi_ldt_nmbs(adresse : integer);
var code,aspect,combine : integer;
    i : integer;
    s : string;
begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal LDT_NMBS: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    if aspect=vert          then begin pilote_acc(adresse,2,signal);end;
    if aspect=semaphore     then begin pilote_acc(adresse,1,signal);end;
    if aspect=deux_jaunes   then begin pilote_acc(adresse+1,2,signal);end;
    if aspect=vert_jaune_H  then begin pilote_acc(adresse+1,1,signal);end;
    // a voir!!!
  end;
end;

{==========================================================================
envoie les données au décodeur LDT_sncf
       adresse=adresse sur le BUS DCC
       code=code d'allumage selon l'adressage (ex carre, vert, rappel_30 ..).
       mode=mode du décodeur adressé, de 1 à 2
       un décodeur occupe 8 adresses
       Le mode 1 permet la commande des signaux de 2, 3 et 4 feux
       Le mode 2 permet la commande de signaux de plus de 4 feux
===========================================================================}
procedure envoi_LDT_sncf(adresse : integer);
var code,aspect,combine,mode : integer;
    i : integer;
    s : string;
begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal LDT: ad'+IntToSTR(adresse)+'='+chaine_signal(NbDecodeurdeBase+NbreDecPers-1);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    if (aspect=semaphore) or (aspect=vert) or (aspect=carre) or (aspect=jaune) then mode:=1 else mode:=2;
    if aspect>carre then mode:=2 else mode:=1;

    case mode of
      // pour les décodeurs en mode 0, il faut écrire la routine vous même car le pilotage dépend du cablage
      // sauf pour le sémaphore, vert et jaune fixe
    1 :       // mode 1: feux 2 3 & 4 feux
    begin
      if (aspect=semaphore) then pilote_acc(adresse,1,signal);
      if (aspect=vert)      then pilote_acc(adresse,2,signal);
      if (aspect=carre)     then pilote_acc(adresse+1,1,signal);
      if (aspect=jaune)     then pilote_acc(adresse+1,2,signal);
    end;
    2 :      // mode 2: plus de 4 feux
    begin
      if (aspect=semaphore)  then begin pilote_acc(adresse+2,1,signal);sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;
      if (aspect=vert)       then begin pilote_acc(adresse+2,1,signal);sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end;
      if (aspect=carre)      then begin pilote_acc(adresse+2,1,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;
      if (aspect=jaune)      then begin pilote_acc(adresse+2,1,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
      if (aspect=violet)     then begin pilote_acc(adresse+2,2,signal);sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;
      if (aspect=blanc)      then begin pilote_acc(adresse+2,2,signal);sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end;
      if (aspect=semaphore)  then begin pilote_acc(adresse+2,2,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;
      if (combine=aspect8)   then begin pilote_acc(adresse+2,2,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
      if (combine=ral_60) and (aspect=jaune_cli)
                             then begin pilote_acc(adresse+3,1,signal);sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;  // demande groupe 3
      if (aspect=vert_cli)   then begin pilote_acc(adresse+3,1,signal);sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end; // demande groupe 3
      if (combine=Disque_D)  then begin pilote_acc(adresse+3,1,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;// demande groupe 3
      if (aspect=jaune_cli)  then begin pilote_acc(adresse+3,1,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
      if (combine=ral_30)    then begin pilote_acc(adresse+3,2,signal);sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;
      if (combine=ral_60)    then begin pilote_acc(adresse+3,2,signal);sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end;
      if (combine=rappel_30) then begin pilote_acc(adresse+3,2,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;
      if (combine=rappel_60) then begin pilote_acc(adresse+3,2,signal);sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
    end;
    end;
  end;
end;

procedure envoi_virtuel(adresse : integer);
var
  combine,aspect,code : integer;
  i : integer;
  s : string;
begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal virtuel: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
  end;
end;

// inverse l'ordre des bits dans un octet
// le bit 7 passe en 0 et inversement
function inverse(b : byte) : byte;
var r : byte;
begin
  r:= ((b and $80) shr 7);
  r:=r or ((b and $40) shr 5);
  r:=r or ((b and $20) shr 3);
  r:=r or ((b and $10) shr 2);
  r:=r or ((b and $08) shl 1);
  r:=r or ((b and $04) shl 3);
  r:=r or ((b and $02) shl 5);
  r:=r or ((b and $01) shl 7);
  inverse:=r;
end;

// inverse l'ordre des bits dans les deux quartets d'un octet
// ex 0010 1010 devient 0100 0101
function inverseQuartet(b : byte) : byte;
var r : byte;
begin
  r:= ((b and $8) shr 3);       // vers bit 0
  r:=r or ((b and $4) shr 1);   // vers bit 1
  r:=r or ((b and $2) shl 1);   // vers bit 2
  r:=r or ((b and $1) shl 3);   // vers bit 3
  r:=r or ((b and $80) shr 3);  // vers bit 4
  r:=r or ((b and $40) shr 1);  // vers bit 5
  r:=r or ((b and $20) shl 1);  // vers bit 6
  r:=r or ((b and $10) shl 3);  // vers bit 7
  inverseQuartet:=r;
end;

// envoie les données au décodeur digikeijs 4018
procedure digi_4018(adresse : integer);
var
  combine,nombre,aspect,code : integer;
  i : integer;
  s : string;

  procedure ecrire(v : integer);
  var j,k : integer;
  begin
    // bits 7 6
    k:=0;
    if nombre>=5 then
    begin
      if (v and $c0)=$80 then j:=2 else j:=1;
      pilote_acc(adresse,j,signal);
      inc(k);
    end;

    // bits 5 4
    if nombre>=3 then
    begin
      if (v and $30)=$20 then j:=2 else j:=1;
      pilote_acc(adresse+k,j,signal);
      inc(k);
    end;

    // bits 3 2
    if nombre>=2 then
    begin
      if (v and $c)=$8 then j:=2 else j:=1;
      pilote_acc(adresse+k,j,signal);
      inc(k);
    end;

    // bits 1 0
    if nombre>=1 then
    begin
      if (v and $3)=$2 then j:=2 else j:=1;
      if k=3 then k:=4;  // saut d'adresse
      pilote_acc(adresse+k,j,signal);
      inc(adresse);
    end;
  end;

begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    nombre:=Signaux[i].Na;          // nombre d'adresses occupées par le signal
    code_to_aspect(code,aspect,combine);
    s:='Signal digikeijs 4018: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    if combine=-1 then
    case aspect of
      carre         : ecrire(Signaux[i].SR[1].sortie1);
      semaphore     : ecrire(Signaux[i].SR[2].sortie1);
      semaphore_cli : ecrire(Signaux[i].SR[3].sortie1);
      vert          : ecrire(Signaux[i].SR[4].sortie1);
      vert_cli      : ecrire(Signaux[i].SR[5].sortie1);
      violet        : ecrire(Signaux[i].SR[6].sortie1);
      blanc         : ecrire(Signaux[i].SR[7].sortie1);
      blanc_cli     : ecrire(Signaux[i].SR[8].sortie1);
      jaune         : ecrire(Signaux[i].SR[9].sortie1);
      jaune_cli     : ecrire(Signaux[i].SR[10].sortie1);
    end;
    if aspect=-1 then
    case combine of
      ral_30        : ecrire(Signaux[i].SR[11].sortie1);
      ral_60        : ecrire(Signaux[i].SR[12].sortie1);
      rappel_30     : ecrire(Signaux[i].SR[14].sortie1);
      rappel_60     : ecrire(Signaux[i].SR[15].sortie1);
    end;
    if (aspect<>-1) and (combine<>-1) then
    begin
      if (Combine=ral_60)    and (aspect=jaune_cli) then ecrire(Signaux[i].SR[13].sortie1);
      if (Combine=rappel_30) and (aspect=jaune)     then ecrire(Signaux[i].SR[16].sortie1);
      if (Combine=rappel_30) and (aspect=jaune_cli) then ecrire(Signaux[i].SR[17].sortie1);
      if (Combine=rappel_60) and (aspect=jaune)     then ecrire(Signaux[i].SR[18].sortie1);
      if (Combine=rappel_60) and (aspect=jaune_cli) then ecrire(Signaux[i].SR[19].sortie1);
    end;
  end;
end;

(*==========================================================================
envoie les données au décodeur digitalbahn équipé du logiciel "led_signal_10"
       adresse=adresse sur le bus
       codebin=motif de bits représentant l'état des feux L'allumage est fait en
       adressant l'une des 14 adresses pour les 14 leds possibles du feu.
       Ici on met le bit 1 à 1 (état "vert" du programme hexmanipu
===========================================================================*)
procedure envoi_signalBahn(adresse : integer);
var i,aspect,code,combine : integer;
    ralrap, jau ,Ancralrap,Ancjau,connecte : boolean;
    s : string;
begin
  connecte:=cdm_connecte or portCommOuvert or parSocketLenz;
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal Bahn: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if traceSign then affiche(s,clOrange);
    if Affsignal or traceListe then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    //Affiche(IntToSTR(aspect)+' '+inttoSTR(combine),clOrange);

    // spécifique au décodeur digital bahn:
    // si le signal affichait un signal combiné, il faut éteindre le signal avec un sémaphore
    // avant d'afficher le nouvel état non combiné
    Ancralrap:=(TestBit(Signaux[i].AncienEtat,ral_30)) or (TestBit(Signaux[i].AncienEtat,ral_60)) or
               (TestBit(Signaux[i].AncienEtat,rappel_30)) or (TestBit(Signaux[i].AncienEtat,rappel_60)) ;
    // si ancien état du signal=jaune ou jaune cli
    Ancjau:=(TestBit(Signaux[i].AncienEtat,jaune)) or (TestBit(Signaux[i].AncienEtat,jaune_cli)) ;

    // si état demandé du signal=ralentissement ou rappel
    ralrap:=(TestBit(code,ral_30)) or (TestBit(code,ral_60)) or
            (TestBit(code,rappel_30)) or (TestBit(code,rappel_60)) ;
    // si état demandé du signal=jaune ou cli
    jau:=TestBit(code,jaune) or TestBit(code,jaune_cli) ;

    // effacement du signal combiné par sémaphore suivant condition
    if (((Ancralrap and not(ralrap)) or (Ancjau and not(jau))) and (combine<>0)) then
    begin
      if connecte then
      begin
        Sleep(40);
        pilote_acc(adresse+semaphore,2,signal) ;
      end;
    end;

    if connecte then sleep(40);  // les commandes entre 2 signaux successifs doivent être séparées au minimum de 100 ms
    // affichage du premier aspect du signal(1er bit à 1 dans codebin)
    if aspect<>-1 then pilote_acc(adresse+aspect,2,signal) ;

    // affichage de la signalisation combinée
    if (Combine<>-1) and connecte then
    begin
      sleep(40);
      pilote_ACC(adresse+Combine,2,signal) ;
    end;
  end;
end;

// pilote un signal par un décodeur personnalisé
procedure envoi_decodeur_pers(Adresse : integer);
var s : string;
    d,dp,i,j,k,etat,asp,combine,aspect,numacc,nAdresses,v,cmd : integer;
    trouve1,trouve2,trouve3,trouve4 : boolean;
begin
  i:=Index_Signal(adresse);
  etat:=Signaux[i].EtatSignal;
  if (Signaux[i].AncienEtat<>etat) then  //; && (stop_cmd==FALSE))
  begin
    d:=Signaux[i].decodeur;
    dp:=d-NbDecodeurdeBase+1;
    if dp<0 then exit;
    s:='Signal '+decodeur_pers[dp].nom+' : ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    Affiche(s,clOrange);

    nAdresses:=decodeur_pers[dp].NbreAdr;

    asp:=Signaux[i].aspect;
    if asp<>20 then
    // français --------------------------------------------
    begin
      if decodeur_pers[dp].nation<>1 then
      begin
        Affiche('Erreur 381 : le signal '+IntToSTR(adresse)+' est français mais son décodeur est belge',clred);
        exit;
      end;

      // commande par centrale
      if decodeur_pers[dp].commande=0 then
      begin
        j:=1;
        code_to_aspect(etat,aspect,combine);

        // trouver l'état dans le décodeur
        repeat
          if (aspect<>-1) and (combine=-1) then
          begin
            // base
            trouve1:=decodeur_pers[dp].desc[j].etat1=aspect+1;
            trouve2:=decodeur_pers[dp].desc[j].etat2=aspect+1;
          end;
          if (aspect=-1) and (combine<>-1) then
          begin
            // signalisation non combinée (ralen30,60 rappel 30,60)
            trouve3:=decodeur_pers[dp].desc[j].etat1=combine+1;
            trouve4:=decodeur_pers[dp].desc[j].etat2=combine+1;
          end;
          // combinée
          if (combine<>-1) and (aspect<>-1) then
          begin
            // ral_60+jaune cli
            trouve3:=false;trouve4:=false;
            if (aspect=jaune_cli) and (combine=ral_60) then
            begin
              trouve3:=(decodeur_pers[dp].desc[j].etat1=15);
              trouve4:=(decodeur_pers[dp].desc[j].etat2=15);
            end;
            // rappel_30+jaune
            if (aspect=jaune) and (combine=rappel_30) then
            begin
              trouve3:=(decodeur_pers[dp].desc[j].etat1=16);
              trouve4:=(decodeur_pers[dp].desc[j].etat2=16);
            end;
            // rappel_30+jaune cli
            if (aspect=jaune_cli) and (combine=rappel_30) then
            begin
              trouve3:=(decodeur_pers[dp].desc[j].etat1=17);
              trouve4:=(decodeur_pers[dp].desc[j].etat2=17);
            end;
            // rappel_60+jaune
            if (aspect=jaune) and (combine=rappel_60) then
            begin
              trouve3:=(decodeur_pers[dp].desc[j].etat1=18);
              trouve4:=(decodeur_pers[dp].desc[j].etat2=18);
            end;
            // rappel_60+jaune cli
            if (aspect=jaune_cli) and (combine=rappel_60) then
            begin
              trouve3:=(decodeur_pers[dp].desc[j].etat1=19);
              trouve4:=(decodeur_pers[dp].desc[j].etat2=19);
            end;
          end;
          inc(j);
        until trouve1 or trouve2 or trouve3 or trouve4 or (j>nAdresses) or (j=11);
        dec(j);
        if trouve1 or trouve3 then
        begin
          pilote_ACC(adresse+decodeur_pers[dp].desc[j].offsetAdresse,decodeur_pers[dp].desc[j].sortie1,signal) ;
         // Affiche(intToSTR(adresse+decodeur_pers[dp].desc[j].offsetAdresse)+' '+intToSTR(decodeur_pers[dp].desc[j].sortie1),clYellow);
        end;
        if trouve2 or trouve4 then
        begin
          pilote_ACC(adresse+decodeur_pers[dp].desc[j].offsetAdresse,decodeur_pers[dp].desc[j].sortie2,signal) ;
         // Affiche(intToSTR(adresse+decodeur_pers[dp].desc[j].offsetAdresse)+' '+intToSTR(decodeur_pers[dp].desc[j].sortie2),clYellow);
        end;
      end;

      // commande par com/USB/Socket
      if decodeur_pers[dp].commande=1 then
      begin
        j:=1;
        numAcc:=decodeur_pers[dp].Peripherique;
        if numAcc>NbMaxi_Periph then
        begin
          Affiche('Erreur 54 : numéro de périphérique hors limite pour décodeur personnalisé '+intToSTR(dp),clred);
          exit;
        end;
        code_to_aspect(etat,aspect,combine);
        if combine=-1 then
        begin
          if aspect=carre then j:=1;
          if aspect=semaphore then j:=2;
          if aspect=semaphore_cli then j:=3;
          if aspect=vert then j:=4;
          if aspect=vert_cli then j:=5;
          if aspect=violet then j:=6;
          if aspect=blanc then j:=7;
          if aspect=blanc_cli then j:=8;
          if aspect=jaune then j:=9;
          if aspect=jaune_cli then j:=10;
        end;
        if aspect=-1 then
        begin
          if combine=ral_30 then j:=11;
          if combine=ral_60 then j:=12;
          if combine=rappel_30 then j:=13;
          if combine=rappel_60 then j:=14;
        end;
        if (aspect=jaune_cli) and (combine=ral_60) then j:=15;
        if (aspect=jaune)     and (combine=rappel_30) then j:=16;
        if (aspect=jaune_cli) and (combine=rappel_30) then j:=17;
        if (aspect=jaune)     and (combine=rappel_60) then j:=18;
        if (aspect=jaune_cli) and (combine=rappel_60) then j:=19;

        s:=intToSTR(adresse)+' '+decodeur_pers[dp].desc[j].Chcommande;
        if Tablo_periph[numacc].cr then s:=s+#13;

        if com_socket(numacc)=1 then
        begin
          // com USB
          v:=Tablo_periph[numacc].NumCom;  // numéro de com
          if v=0 then exit;
          if tablo_periph[numacc].PortOuvert then
          begin
            cmd:=Tablo_periph[numacc].numComposant;
            if cmd=1 then envoi_usb_comp(MSCommCde1,s);
            if cmd=2 then envoi_usb_comp(MSCommCde2,s);

            if Tablo_periph[numacc].ScvVis then Affiche('Envoi COM'+intToSTR(v)+': '+s,clYellow);
          end
          else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non détecté',clred);
        end
        else
        begin
          // socket
          begin
            numAcc:=decodeur_pers[dp].Peripherique;
            cmd:=Tablo_periph[numacc].numComposant;
            if cmd=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
            if cmd=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
            if Tablo_periph[numacc].ScvVis then Affiche('Envoi Socket: '+s,clYellow);
          end
        end;
      end;
    end

    else
    // signal belge (aspect=20)---------------------------------
    begin
      if decodeur_pers[dp].nation<>2 then
      begin
        Affiche('Erreur 381 : le signal '+IntToSTR(adresse)+' est belge mais son décodeur est français',clred);
        exit;
      end;

      // commande par centrale
      if decodeur_pers[dp].commande=0 then
      begin
        nAdresses:=decodeur_pers[dp].NbreAdr;
        // trouver l'état dans le décodeur
        for j:=0 to 8 do
        begin     // balayer les bits de 0 à 8
          if testbit(etat,j) then
          begin
            // explorer les états
            for k:=1 to nAdresses do
            begin
              if decodeur_pers[dp].desc[k].etat1=j+1 then
                pilote_ACC(adresse+decodeur_pers[dp].desc[k].offsetAdresse,decodeur_pers[dp].desc[k].sortie1,signal) ;
              if decodeur_pers[dp].desc[k].etat2=j+1 then
                pilote_ACC(adresse+decodeur_pers[dp].desc[k].offsetAdresse,decodeur_pers[dp].desc[k].sortie2,signal) ;
            end;
          end;
        end;
      end;
      // commande par com/usb/socket
      if decodeur_pers[dp].commande=1 then
      begin
        numAcc:=decodeur_pers[dp].Peripherique;
        if numAcc>NbMaxi_Periph then
        begin
          Affiche('Erreur 55 : numéro de périphérique hors limite pour décodeur personnalisé '+intToSTR(dp),clred);
          exit;
        end;
        // trouver l'état dans le décodeur
        for j:=0 to 8 do
        begin     // balayer les bits de 0 à 8
          if testbit(etat,j) then
          begin
            s:=intToSTR(adresse)+' '+decodeur_pers[dp].desc[j+1].Chcommande;  // chaine à envoyer
            if Tablo_periph[numacc].cr then s:=s+#13;
            numAcc:=decodeur_pers[dp].Peripherique;

            if com_socket(numacc)=1 then
            begin
              // com USB
              v:=Tablo_periph[numacc].NumCom;  // numéro de com
              if v=0 then exit;
              if tablo_periph[numacc].PortOuvert then
              begin
                cmd:=Tablo_periph[numacc].numComposant;
                if cmd=1 then envoi_usb_comp(MSCommCde1,s);
                if cmd=2 then envoi_usb_comp(MsCommCde2,s);

                if Tablo_periph[numacc].ScvVis then Affiche('Envoi COM'+intToSTR(v)+': '+s,clYellow);
              end
              else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non détecté',clred);
            end
            else
            begin
              // socket
              cmd:=Tablo_periph[numacc].numComposant;
              if cmd=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
              if cmd=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
              if Tablo_periph[numacc].ScvVis then Affiche('Envoi Socket: '+s,clYellow);
            end;
          end;
        end;
      end;
    end;
  end;
end;


// renvoie l'adresse du détecteur suivant des deux éléments contigus
// TypeElprec/actuel: 1= détecteur  2= aiguillage 4=Buttoir
// algo= type d'algorithme pour suivant_alg3
function detecteur_suivant(prec : integer;TypeElPrec : TEquipement;actuel : integer;TypeElActuel : TEquipement;algo : integer) : integer ;
var actuelCalc,PrecCalc,j,AdrSuiv ,indexCalc : integer;
    TypeprecCalc,TypeActuelCalc : TEquipement;
begin
  if NivDebug>=2 then
    AfficheDebug('Proc Detecteur_suivant '+IntToSTR(prec)+','+BTypeToChaine(typeElPrec)+'/'+intToSTR(actuel)+','+
                  BTypeToChaine(TypeElActuel)+
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
  until (j=10) or (typeGen=det) or (AdrSuiv=0) or (AdrSuiv>=9990); // arret si détecteur

  // si trouvé le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1); // suivant immédiat
  end;
  if (NivDebug=3) and (AdrSuiv<9990) then AfficheDebug('618 : Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// pilotage d'un signal, et mise à jour du graphisme du signal dans les 3 fenetres
procedure envoi_signal(Adr : integer);
var i,it,j,index_train,adresse,detect,detsuiv,a,b,aspect,x,y,TailleX,TailleY,Orientation,
    indexTCO,AdrTrain,dec : integer;
    rougeA,rougeB : boolean;
    ImageSignal : TImage;
    frX,frY : real;
    s : string;
begin
  i:=Index_Signal(Adr);
  if i=0 then
  begin
    s:='Erreur 75: index signal '+intToSTR(adr)+' nul';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  //Affiche(intToSTR(Adr)+' '+intToSTR(i),clWhite);

  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then
  begin
    if not(isDirectionnel(i))  then   // si signal non directionnel
    begin
      dec:=Signaux[i].decodeur;
      // envoie la commande au décodeur
      case dec of
       0 : envoi_virtuel(Adr);
       1 : envoi_signalBahn(Adr);
       2 : envoi_CDF(Adr);
       3 : envoi_LDT_sncf(Adr);
       4 : envoi_LEB(Adr);
       5 : digi_4018(Adr);
       6 : envoi_UniSemaf(Adr);
       7 : envoi_SR(Adr);
       8 : envoi_arcomora(Adr);
       9 : envoi_ldt_nmbs(adr);
       10 : envoi_b_models(adr);
      end;

      // décodeur personnalisé
      if (dec>=NbDecodeurdeBase) then
        if (dec<NbDecodeurdeBase+NbreDecPers) then envoi_decodeur_pers(adr)
          else Affiche('Erreur 192 : décodeur '+IntToSTR(dec)+' non défini',clred);

      // Gestion démarrage temporisé des trains si on quitte le rouge : ne fonctionne qu'en roulage
      if roulage then
      begin
        a:=Signaux[i].AncienEtat;
        b:=Signaux[i].EtatSignal;
        // si l'ancien état était au rouge/violet et on quitte le rouge/violet
        if Signaux[i].aspect=20 then begin rougeA:=testbit(a,rouge);rougeB:=testbit(b,rouge);end // signal belge
           else
           begin
             rougeA:=testbit(a,semaphore) or testbit(a,carre) or testbit(a,violet);
             rougeB:=testbit(b,semaphore) or testbit(b,carre) or testbit(b,violet);
           end;
        if not(rougeB) and rougeA then // le signal quitte le rouge/violet
        begin
          // y a t il un train en face du signal
          detect:=Signaux[i].Adr_det1;
          if detect<>0 then
          begin
            // test si train sur le détecteur det
            if detecteur[detect].etat then
            begin
              AdrTrain:=detecteur[detect].AdrTrain;
              if AdrTrain<>0 then
              begin
                s:='Le train @'+intToSTR(AdrTrain)+' va démarrer du signal '+intToSTR(adr);
                Affiche(s,clWhite);
                if TraceListe then AfficheDebug(s,clWhite);
                index_train:=index_train_adresse(adrtrain);
                if index_train<>0 then it:=trains[index_train].index_event_det_train;
                if it<>0 then event_det_train[it].signal_rouge:=0;
                // faire la réservation du canton
                if Signaux[i].Btype_suiv1<>det then detSuiv:=detecteur_suivant(detect,det,Signaux[i].Adr_el_suiv1,Signaux[i].Btype_suiv1,1)
                  else detSuiv:=Signaux[i].Adr_el_suiv1;
                if detSuiv<9990 then reserve_canton(detect,detSuiv,Adrtrain,0,nCantonsRes);
                // démarrage d'un train
                j:=index_train_adresse(adrtrain);
                trains[j].tempoDemarre:=20;  // armer la tempo à 2s
                // annuler la demande d'arret éventuelle
                trains[j].TempoArret:=0;

                // arreter le train
                //s:=detecteur[det].train;
                //detecteur[det].train:=s;
                //Affiche('et son détecteur '+IntToSTR(det)+'=1 tempo démarrage ; train '+s,clYellow);
                //if cdm_connecte then
                //begin
                //  s:=chaine_CDM_vitesseST(0,s);  // 0%
                //  envoi_cdm(s);
                //end;
              end;
            end;
          end;
        end;
      end;
    end

    else
    // signal directionel
    begin
      pilote_direction(Adr,Signaux[i].etatSignal)
    end;

    Signaux[i].AncienEtat:=Signaux[i].EtatSignal;

    // allume les feux du signal dans la fenêtre de droite
    Dessine_signal_mx(Signaux[i].Img.Canvas,0,0,1,1,adr,1);

    // allume les feux du signal dans le TCO
    for indexTCO:=1 to NbreTCO do
    begin
      if PcanvasTCO[indexTCO]<>nil then
      begin
        for y:=1 to NbreCellY[indexTCO] do
        for x:=1 to NbreCellX[indexTCO] do
        begin
          if TCO[indexTCO,x,y].Bimage=Id_signal then
          begin
            adresse:=TCO[IndexTCO,x,y].adresse;      // vérifie si le signal existe dans le TCO
            if adresse=adr then
            begin
              aspect:=Signaux[Index_Signal(adresse)].Aspect;
              case aspect of
                2 :  ImageSignal:=Formprinc.Image2feux;
                3 :  ImageSignal:=Formprinc.Image3feux;
                4 :  ImageSignal:=Formprinc.Image4feux;
                5 :  ImageSignal:=Formprinc.Image5feux;
                7 :  ImageSignal:=Formprinc.Image7feux;
                9 :  ImageSignal:=Formprinc.Image9feux;
                12 : ImageSignal:=Formprinc.Image2Dir;
                13 : ImageSignal:=Formprinc.Image3Dir;
                14 : ImageSignal:=Formprinc.Image4Dir;
                15 : ImageSignal:=Formprinc.Image5Dir;
                16 : ImageSignal:=Formprinc.Image6Dir;
                20 : ImageSignal:=formprinc.ImageSignal20;
                else ImageSignal:=Formprinc.Image3feux;
              end;
              TailleY:=ImageSignal.picture.BitMap.Height; // taille du signal d'origine
              TailleX:=ImageSignal.picture.BitMap.Width;
              Orientation:=tco[indextco,x,y].FeuOriente;
              // réduction variable en fonction de la taille des cellules
              calcul_reduction(frx,fry,LargeurCell[indexTCO],HauteurCell[indexTCO]);
              // décalage en X pour mettre la tete du signal alignée sur le bord droit de la cellule pour les signaux tournés à 90G
              Dessine_signal_mx(PCanvasTCO[indexTCO],tco[indexTCO,x,y].x,tco[indextco,x,y].y,frx,fry,adresse,orientation);
            end;
          end;
        end;
      end;
    end;
  end;
end;

// pilotage des signaux
procedure envoi_signauxCplx;
var i,adr : integer;
begin
  //Affiche('Envoi des signaux (envoi_signauxCplx)',ClGreen);
  for i:=1 to NbreSignaux do
  begin
    adr:=Signaux[i].adresse;
    if not(fermeSC) and (adr<>0) then envoi_signal(adr);
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
// si pas trouvé, renvoie 0 sinon renvoie l'index du détecteur dans la branche
function index_detecteur(detecteur,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    // trouve si detecteur est dans la branche num_branche à partir de l'index i
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
  if debug=3 then formprinc.Caption:='index_detecteur '+IntToSTR(detecteur);
  {
  i:=1;index2_det:=0;
  recherche;
  if trouve then result:=i else result:=0;
  //affiche(inttostr(ai+1),clOrange);
  }
  i:=1;
  //affiche('------------------------',clWhite);
  recherche;  
  //affiche('------------------------',clGreen);
  if trouve then result:=i else result:=0;
  //affiche('index2='+IntToSTR(index2_det),clWhite);
  if debug=3 then formprinc.Caption:='';
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
      until trouve or (adr=0) or (i>MaxElBranches) ;
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

// trouve le détecteur dans les branches  et stocke le résultat des index dans branche_trouve, Indexbranche_trouve)
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

// vérifie la configuration du décodeur Unisemaf
// si 0 = OK
// si 1 = erreur code Unisemaf
// si 2 = erreur cohérence entre code et aspect
// si 3 = signal inconnu
function verif_UniSemaf(adresse,UniSem : integer) : integer;
var aspect,i : integer;
begin
  if UniSem=0 then begin verif_unisemaf:=1;exit;end;
  if (UniSem<>2) and (UniSem<>3) and (UniSem<>4) and (UniSem<>51) and (UniSem<>52) and (UniSem<>71) and (UniSem<>72) and (UniSem<>73) and
     ((UniSem<90) or (UniSem>99)) then begin verif_UniSemaf:=1;exit;end;

  i:=Index_Signal(adresse);
  if i<>0 then
  begin
    aspect:=Signaux[i].aspect;
    if ((aspect=2) and (UniSem=2)) or
       ((aspect=3) and (UniSem=3)) or
       ((aspect=4) and (UniSem=4)) or
       ((aspect=5) and ((UniSem=51) or (UniSem=52))) or
       ((aspect=7) and ((UniSem=71) or (UniSem=72) or (UniSem=73))) or
       ((aspect=9) and ((UniSem>=90) or (UniSem<=99)))
       then Verif_unisemaf:=0
    else Verif_Unisemaf:=2;
  end
  else
  begin
    Affiche('Erreur 395 : Signal '+intToSTR(adresse)+' inconnu',clred);
    Verif_Unisemaf:=3;
  end;
end;

// trouve un élément en balayant les branches à partir de la branche offset renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'élément  TypeEL=(1=détécteur 2=aig  3=aig Bis 4=aig triple - Buttoir)
// explore les branches
// si pas trouvé, Branche_trouve=0 IndexBranche_trouve=0
procedure trouve_element_V1(el: integer; TypeEl : TEquipement; Offset : integer);
var i,adr,Branche : integer ;
    s : string;
    BT : TEquipement;
    sort : boolean;
begin
  if debug=3 then formprinc.Caption:='Trouve_element '+IntToSTR(el);

  Branche:=Offset;
  branche_trouve:=0;
  IndexBranche_trouve:=0;
  i:=1;
  repeat
    adr:=BrancheN[Branche,i].Adresse;
    Bt:=BrancheN[Branche,i].BType;
    if ((adr=0) and (Bt=rien)) then begin inc(Branche);i:=0;end;
    inc(i);
    sort:=(Branche>NbreBranches) or ((adr=el) and (TypeEL=Bt));
  until (sort);
  if (adr=el) then
  begin
    branche_trouve:=Branche;
    IndexBranche_trouve:=i-1;
  end
  else begin s:='Erreur 175 : élément '+intToSTR(el)+' ';
             s:=s+BTypeToChaine(TypeEl);
             s:=s+' non trouvé';Affiche(s,clred);
             branche_trouve:=0; IndexBranche_trouve:=0;
             AfficheDebug(s,clred);
       end;
  if debug=3 then formprinc.Caption:='';

end;

// trouve un élément dans les branches depuis les index.
// Plus rapide que la procédure précédente. Renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'élément  TypeEL=(1=détécteur 2=aig  3=aig Bis 4=aig triple - Buttoir)
// avec cet algorithme, un détecteur et un aiguillage ne peut se trouver qu'à un seul endroit dans les branches
procedure trouve_element(el: integer; TypeEl : TEquipement);
var s : string;
begin
  if debug=3 then formprinc.Caption:='Trouve_element '+IntToSTR(el);

  branche_trouve:=0;
  IndexBranche_trouve:=0;

  if el>NbMaxDet then
  begin
    s:='Erreur 78 : trouve_element el='+inttoStr(el);
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  if el<1 then
  begin
    if TypeEL=buttoir then exit;
    s:='Erreur 79 : trouve_element el='+inttoStr(el);
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;


  if typeEL=det then
  begin
    branche_trouve:=detecteur[el].NumBranche;              // le détecteur det se trouve dans
    indexBranche_trouve:=detecteur[el].IndexBranche;       // NumBranche et Indexbranche  - detecteur[] sont indexés par l'adresse
  end;

  if typeEL=aig then
  begin
    //Affiche('aig ',clred);
    branche_trouve:=aiguillage[index_aig(el)].NumBranche;            // l'aiguillage aig se trouve dans
    indexBranche_trouve:=aiguillage[index_aig(el)].IndexBranche;     // NumBranche et Indexbranche  aiguillage[] sont indexés par un index
  end;

  if typeEL=buttoir then
  begin
    branche_trouve:=detecteur[el].NumBranche;              // le détecteur det se trouve dans
    indexBranche_trouve:=detecteur[el].IndexBranche;
  end;

  //Affiche_Suivi(intToSTR(el),clred);

  if IndexBranche_trouve=0 then
  begin
    s:='Erreur 176 : élément '+intToSTR(el)+' ';
    s:=s+BTypeToChaine(TypeEl);
    s:=s+' non trouvé';Affiche(s,clred);
    branche_trouve:=0; IndexBranche_trouve:=0;
    AfficheDebug(s,clred);
  end;
  if debug=3 then formprinc.Caption:='';

end;

// renvoie l'élément suivant des deux éléments dans le sens (prec,typeElprec) -> (actuel,typeElActuel) quels qu'ils soient mais contigus
// *** attention, si les éléments ne sont pas contigus, le résultat est erronné!!! ***
// un élément est constitué de son adresse et de son type
// et renvoie aussi en variable globale: typeGen le type de l'élément (det aig uniquement! pas tjd ni crois)
//                                     : AigMal = aiguillage mal positionné ou inconnu
// alg= algorithme 1 à 8 sous forme de bits fonctionnels:
// bit0 (1)=arret sur suivant qu'il soit un détecteur ou un aiguillage
// bit1 (2)=arret sur aiguillage en talon mal positionné
// bit2 (4)=arret sur aiguillage réservé
// bits1 et 2: (2+4)=6= arret sur aiguillage en talon mal positionnée ou aiguillage réservé
// bit3 (8)=arret sur un aiguillage pris en pointe dévié et AdrDevie contient l'adresse de l'aiguillage dévié ainsi que typeGen
// code de sortie : élément suivant ou:
// 9999: erreur fatale: élément non trouvé ou itération trop longue
// 9998: arret sur aiguillage en talon mal positionnée
// 9997: arrêt sur aiguillage dévié
// 9996: arrêt sur position inconnue d'aiguillage
// 9995: arrêt sur buttoir
// 9994: arrêt sur aiguillage réservé
// 9993: éléments non consécutifs

// la variable "actuel" peut etre changée en cas de TJD!
function suivant_alg3(prec : integer;typeELprec : TEquipement;actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
var  Adr,AdrPrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2,N_iteration,index,NetatTJD,index2 : integer;
     tjscourbe1,tjscourbe2,tjdC,tjsC,id : boolean;
     A,Aprec,tjsc1B,tjsc2B,typeprec: char;
     Md,BT,BtypePrec,TypeEL : TEquipement;
     s : string;

label recommence;
begin
  n_iteration:=0;

  recommence:
  if (TypeELPrec=rien) or (typeElActuel=rien) then
  begin
    s:='Erreur 800 - Types nuls : '+intToSTR(prec)+'/'+BtypeToChaine(TypeElPrec)+' '+IntToSTr(actuel)+'/'+BtypeToChaine(typeElActuel) ;
    Affiche(s,clred);
    AfficheDebug(s,clred);
    Suivant_alg3:=9999;exit;
  end;
  if (NivDebug=3) then
    AfficheDebug('it='+intToSTR(n_iteration)+' Alg3 précédent='+intToSTR(prec)+'/'+BtypeToChaine(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+BtypeToChaine(typeElActuel)+' Alg='+intToSTr(alg),clyellow);

  // trouver les éléments du précédent dans les branches
  trouve_element(prec,TypeELPrec); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouvé',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;

  trouve_element(actuel,typeElActuel); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouvé',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Bt:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

  if nivDebug=3 then AfficheDebug('Btype='+BTypeToChaine(Bt)+' Actuel='+inTToSTR(actuel),clyellow);

  id:=false;
  if Bt=det then  // l'élément actuel est un détecteur
  begin
    // on part de l'actuel pour retomber sur le précédent
    if BrancheN[branche_trouve_actuel,indexBranche_actuel-1].Adresse=prec then // c'est l'autre sens
    begin
      id:=true;
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
      id:=true;
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
      id:=true;
      // changer l'adresse du précédent par l'autre adresse de la TJD/S
      // V1 index:=index_aig(prec);
      index:=tablo_index_aiguillage[prec];
      md:=aiguillage[index].modele;
      if (md=tjs) or (md=tjd) then
      begin
        //V1 prec:=Aiguillage[index_aig(prec)].Ddroit;
        prec:=Aiguillage[tablo_index_aiguillage[prec]].Ddroit;
        if NivDebug=3 then AfficheDebug('Le précedent est une TJD/S - substitution du précédent par la pointe de la TJD qui est '+intToSTR(prec),clYellow);
      end;
    end;
    if not(id) then
    begin
      Affiche('Erreur 780 alg3: '+intToSTR(prec)+' '+intToSTR(actuel)+' non consécutifs',clRed);
      result:=9993;
      exit;
    end;

    inc(n_iteration);

    if n_iteration>50 then
    begin
      s:='Erreur fatale 9999, trop d''itérations:';
      s:=s+' Alg3 précédent='+intToSTR(prec)+'/'+BtypeToChaine(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+BtypeToChaine(typeElActuel)+' Alg='+intToSTr(alg);
      Affiche(s,clRed);
      AfficheDebug(s,clRed);
      suivant_alg3:=9999;
      exit;
    end;
    goto recommence;
  end;

  if (Bt=aig) or (Bt=buttoir) then  // aiguillage ou buttoir
  begin
    //V1 index:=index_aig(adr);
    index:=tablo_index_aiguillage[adr];
    if index=0 then
    begin
      if bt=aig then
      begin
        s:='Erreur 420 : aiguillage '+intToSTR(adr)+' inconnu';
        Affiche(s,clred);
        AfficheDebug(s,clred);
        suivant_alg3:=9999;
        exit;
      end;
      suivant_alg3:=9995;
      exit;
    end;

    if (aiguillage[index].modele=aig) and (Bt=aig)  then // aiguillage normal
    begin
      // si aiguillage reservé
      if (alg and $4=$4) and (aiguillage[index].AdrTrain<>0) then
      begin
        if NivDebug=3 then AfficheDebug('230 - aiguillage '+intToSTR(adr)+' réservé par train @'+intToSTR(aiguillage[index].AdrTrain),clyellow);
        suivant_alg3:=9997;     // attention code incorrect devrait être 9994
        exit;
      end;

      // aiguillage index (adr) pris en pointe
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
          if adr<>0 then
          begin
            if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig
            trouve_element(adr,typeEl); // branche_trouve  IndexBranche_trouve
            if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
            typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          end
          else
            typeGen:=buttoir;
          suivant_alg3:=adr;
          exit;
        end;

        if aiguillage[index].position=const_devie then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe dévié',clyellow);
          if (alg and 8)=8 then // on demande d'arreter sur un aiguillage pris en pointe est dévié
          begin
            typeGen:=rien;
            AdrDevie:=Adr;
            suivant_alg3:=9997;
            exit;
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
          if adr<>0 then
          begin
            if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig)
            trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
            if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
            typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          end
            else typeGen:=buttoir;
          suivant_alg3:=adr;
          exit;
        end;

        if aiguillage[index].position=const_inconnu then
        begin
          if NivDebug>=1 then AfficheDebug('134.2 - Aiguillage '+IntToSTR(adr)+' non résolu car position inconnue',clOrange);
          typeGen:=rien;
          suivant_alg3:=9996;
          AigMal:=adr;
          exit;
        end;
      end
      else
      begin
        // aiguillage index (adr) pris en talon
        if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
        if (alg and 2)=2 then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if aiguillage[index].position=const_droit then
          begin
            // si TJD (modele=2) sur le précédent, alors substituer avec la 2eme adresse de la TJD
            // V1 md:=aiguillage[index_aig(prec)].modele;
            md:=aiguillage[tablo_index_aiguillage[prec]].modele;
            if (md=tjd) or (md=tjs) then prec:=aiguillage[index_aig(prec)].DDroit;
            if prec<>aiguillage[index_aig(Adr)].Adroit then     //Adroit
            begin
              if NivDebug=3 then AfficheDebug('135.1 - Aiguillage '+intToSTR(adr)+' mal positionné',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.2 - Aiguillage '+intToSTR(adr)+' bien positionné',clyellow);
            end;
          end
          else
          begin
            // si TJD (modele=2) sur le précédent, alors substituer avec la 2eme adresse de la TJD
            if TypeElPrec<>det then
            begin
              md:=aiguillage[index_aig(prec)].modele;
              if (md=tjd) or (md=tjs) then prec:=aiguillage[index_aig(prec)].Ddevie;
            end;
            if (prec<>aiguillage[index].Adevie) or (aiguillage[index].position=const_inconnu) then
            begin
              if NivDebug=3 then AfficheDebug('135.3 Aiguillage '+intToSTR(adr)+' mal positionné',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 Aiguillage '+intToSTR(adr)+' bien positionné',clyellow);
            end;
          end;
        end;

        // AdrPrec:=Adr;
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
        if adr<>0 then
        begin
          //  Affiche('trouvé '+intToSTR(adr),clyellow);
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig
          trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        end
          else TypeGen:=Buttoir;
        suivant_alg3:=adr;
        exit;
      end;
      if (NivDebug>1) or traceListe then
      begin
        s:='138 - Aiguillage '+IntToSTR(adr)+' non résolu';
        if aiguillage[index].position=const_inconnu then s:=s+' car position inconnue';
        AfficheDebug(s,clOrange);
        Affiche(s,clOrange);
      end;
      suivant_alg3:=9996; // position inconnue
      AigMal:=adr;
      exit;
    end;

    // TJD ou TJS-----------------------------
    if (aiguillage[index].modele=tjd) or (aiguillage[index].modele=tjs) then
    begin
      if ((alg and 4)=4) and (aiguillage[index].AdrTrain<>0) then
      begin
        if NivDebug=3 then AfficheDebug('231 - TJD/S '+intToSTR(Adrtjdp)+' réservée par train @'+intToSTR(aiguillage[index].AdrTrain),clyellow);
        suivant_alg3:=9994;
        exit;
      end;

      // récupérer les élements de la TJD/S
      AdrTjdP:=aiguillage[index].Ddroit; // 2eme adresse de la TJD/S
      // V1 index2:=index_aig(AdrTjdP);
      index2:=tablo_index_aiguillage[AdrTjdP];

      tjdC:=aiguillage[index].modele=tjd;
      tjsC:=aiguillage[index].modele=tjs;
      tjsc1:=aiguillage[index].tjsint;   // adresses de la courbe de la TJS
      tjsc2:=aiguillage[index2].tjsint;
      tjsc1B:=aiguillage[index].tjsintB;
      tjsc2B:=aiguillage[index2].tjsintB;
      NetatTJD:=aiguillage[index].etatTJD;

      if ((alg and 4)=4) and (aiguillage[index2].AdrTrain<>0) then
      begin
        if NivDebug=3 then AfficheDebug('130 - TJD/S '+intToSTR(Adrtjdp)+' réservée par train @'+intToSTR(aiguillage[index2].AdrTrain),clyellow);
        suivant_alg3:=9994;
        exit;
      end;

      if tjsc1<>0 then  // si tjs
      begin
        tjscourbe1:=(aiguillage[index].tjsintB='S') and (aiguillage[index2].position<>const_droit);
        tjscourbe1:=((aiguillage[index].tjsintB='D') and (aiguillage[index2].position=const_droit)) or tjscourbe1;
      end;
      if tjsc2<>0 then
      begin
        tjscourbe2:=(aiguillage[index2].tjsintB='S') and (aiguillage[index2].position<>const_droit);
        tjscourbe2:=((aiguillage[index2].tjsintB='D') and (aiguillage[index2].position=const_droit)) or tjscourbe2;
      end;

      if NivDebug=3 then
      begin
        s:='137 - TJD/S '+intToSTR(Adr);
        if NetatTJD=4 then s:=s+'/'+IntToSTR(AdrTjdP);
        s:=s+' pos=';
        if aiguillage[index].position=const_droit then s:=s+'droit'
          else if aiguillage[index].position=const_devie then s:=s+'dévié'
          else s:=s+'inconnu' ;
        if NetatTJD=4 then
        begin
          if aiguillage[index_aig(AdrTJDP)].position=const_droit then s:=s+'/droit'
          else if aiguillage[index_aig(AdrTJDP)].position=const_devie then s:=s+'/dévié'
            else s:=s+'/inconnu' ;
        end;
        AfficheDebug(s,clyellow);
      end;

      // rechercher le port de destination de la tjd
      Adr2:=0;A:='Z';

      //---------------TJD 2 états
      if (NetatTJD=2) and tjdC then
      begin
        if aiguillage[index].position=const_droit then
        begin
          // d'où vient t-on de la tjd
          if BtypePrec=Aig then
          begin
            if (aiguillage[index].Ddroit=prec) and
               (
                 ((aiguillage[index].DdroitB='D') and (aiguillage[index_aig(prec)].position=const_droit))  or
                 ((aiguillage[index].DdroitB='S') and (aiguillage[index_aig(prec)].position=const_devie))
               ) then
            begin
              Adr:=aiguillage[index].Adroit;
              A:=aiguillage[index].AdroitB;
            end
            else
            begin
              if (nivdebug>1) or traceliste then
              begin
                s:='Erreur 120 : TJD 2 états '+intToSTR(Adr)+' non résolue';
                AfficheDebug(s,clred);
                suivant_alg3:=9999;
                exit;
              end;
            end;

            if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 états est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;

          if BtypePrec=det then
          begin
            if aiguillage[index].Adroit=prec then
            begin
              Adr:=aiguillage[index].DDroit;
              A:=aiguillage[index].DdroitB;
            end;
            if aiguillage[index].Adevie=prec then
            begin
              Adr:=aiguillage[index].Ddevie;
              A:=aiguillage[index].DdevieB;
            end;
            if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 états est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;
        end;

        if aiguillage[index].position=const_devie then
        begin
          if (alg and 8)=8 then
          begin
            typeGen:=rien;
            AdrDevie:=Adr;
            suivant_alg3:=9997;
            exit;
          end;
          if BtypePrec=Aig then
          begin
            if (aiguillage[index].Ddroit=prec) and
               (
                 ((aiguillage[index].DdroitB='D') and (aiguillage[index_aig(prec)].position=const_droit))  or
                 ((aiguillage[index].DdroitB='S') and (aiguillage[index_aig(prec)].position=const_devie))
                )
            then
            begin
              Adr:=aiguillage[index].Adevie;
              A:=aiguillage[index].AdevieB;
            end
            else
            begin
              if (nivdebug>1) or traceliste then
              begin
                s:='Erreur 121 : TJD 2 états '+intToSTR(Adr)+' non résolue';
                AfficheDebug(s,clred);
                suivant_alg3:=9999;
                exit;
              end;
            end;

            if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 états est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;

          if BtypePrec=det then
          begin
            if aiguillage[index].Adroit=prec then
            begin
              Adr:=aiguillage[index].Ddevie;
              A:=aiguillage[index].DdevieB;
            end;
            if aiguillage[index].Adevie=prec then
            begin
              Adr:=aiguillage[index].Ddroit;
              A:=aiguillage[index].DdroitB;
            end;
            if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 états est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;
        end;
      end;

      //--------------- 4 états ou TJS
      if (NetatTJD=4) or tjsC then
      begin
        // determiner la position de la première section de la TJD (4 cas)
        // cas 1 : droit droit
        if (( aiguillage[index].position=const_droit) and
             (aiguillage[index2].position=const_droit) )  then
        begin
          // d'où vient ton sur la tjs
          if BtypePrec=Aig then
          begin
             if ( ((aiguillage[index].AdroitB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
                ( ((aiguillage[index].AdroitB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
             then
               begin if NivDebug=3 then AfficheDebug('TJD/S '+intToSTR(adr)+' bien positionnée cas 1.1',clyellow);end
             else
             begin
               if (nivdebug>1) or traceliste then AfficheDebug('135.5- TJD/S '+intToSTR(adr)+' mal positionnée cas 1.1',clyellow);
               if (alg and 2)=2 then
               begin
                 suivant_alg3:=9998;
                 AigMal:=adr;
                 exit;
               end;
             end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adroit)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD/S '+intToSTR(adr)+' bien positionnée cas 1.2',clyellow);end
            else
            begin
              if (nivdebug>1) then AfficheDebug('135.6- TJD/S '+intToSTR(adr)+' mal positionnée cas 1.2',clyellow);
              if (alg and 2=2) then
              begin
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if aiguillage[index].position=const_droit then
          begin
            Adr:=aiguillage[index2].Adroit;
            A:=aiguillage[index2].AdroitB;
          end
          else
          //if A='S' then
          begin
            Adr:=aiguillage[index2].Adevie;
            A:=aiguillage[index2].AdevieB;
          end;
          if NivDebug=3 then AfficheDebug('cas1.1 tjd/s: '+s+' Adr='+intToSTR(adr)+A,clYellow);
          if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;  //TypeEL=(1=détécteur 2=aig
          suivant_alg3:=adr;
          Actuel:=aiguillage[index2].Adresse; // substitution de la TJS
          if nivDebug=3 then Affichedebug('le port de destination de la tjd/s est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 2 TJD
        if (aiguillage[index].position=const_devie) and
           (aiguillage[index2].position=const_droit) and tjdC then
        begin
          if (alg and 8)=8 then
          begin
            typeGen:=rien;
            AdrDevie:=Adr;
            suivant_alg3:=9997;
            exit;
          end;

          // d'où vient ton sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdroitB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdroitB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
            begin if NivDebug=3 then AfficheDebug('TJD/S '+intToSTR(adr)+' bien positionnée - cas 2.1',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionnée - cas 2.1',clyellow);
              if (alg and 2)=2 then
              begin
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adroit)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionnée cas 2.2',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;
                exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.18- TJD '+intToSTR(adr)+' mal positionnée cas 2.2',clyellow);
              if (alg and 2)=2 then
              begin
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if aiguillage[index].position=const_devie then
          begin
            Adr:=aiguillage[index2].Adevie;
            A:=aiguillage[index2].AdevieB;
          end
          else
          begin
            Adr:=aiguillage[index2].Adroit;
            A:=aiguillage[index2].AdroitB;
          end;
          if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 états est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 3 TJD
        if (aiguillage[index].position=const_droit) and (aiguillage[index2].position=const_devie) and tjdC then
        begin
          if (alg and 8)=8 then
          begin
            typeGen:=rien;
            AdrDevie:=Adr;
            suivant_alg3:=9997;
            exit;
          end;
          // d'où vient t-on sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdevieB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdevieB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
              begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionnée cas 3.1',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionnée cas 3.1',clyellow);
              if (alg and 2)=2 then
              begin
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adevie)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionnée cas 3.2',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est dévié
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;
                exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.8- TJD '+intToSTR(adr)+' mal positionnée cas 3.2',clyellow);
              if (alg and 2)=2 then
              begin
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if aiguillage[index].position=const_devie then
          begin
            Adr:=aiguillage[index2].Adevie;
            A:=aiguillage[index2].AdevieB;
          end
          //if A='S' then
          else
          begin
            Adr:=aiguillage[index2].Adroit;
            A:=aiguillage[index2].AdroitB;
          end;
          if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 4 tjd
        if (aiguillage[index].position=const_devie)
           and (aiguillage[index2].position=const_devie)  then
        begin
          // d'où vient ton sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdevieB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdevieB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
              begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionnée cas 4.1',clyellow);end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionnée cas 4.1',clyellow);
              if (alg and 2)=2 then
              begin
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adevie)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionnée cas 4.2',clyellow);end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.8- TJD '+intToSTR(adr)+' mal positionnée cas 4.2',clyellow);
              if (alg and 2)=2 then
              begin
                suivant_alg3:=9998;  
                AigMal:=adr;
                exit;
              end;
            end;
          end;

          if aiguillage[index].position=const_droit then
          begin
            Adr:=aiguillage[index2].Adroit;
            A:=aiguillage[index2].AdroitB;
          end
          //if A='S' then
          else
          begin
             Adr:=aiguillage[index2].Adevie;
             A:=aiguillage[index2].AdevieB;
          end;
          if NivDebug=3 then AfficheDebug('cas4.1 tjd: '+s+' Adr='+intToSTR(adr)+A,clYellow);
          if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas TJS prise dans sa position courbe
        if ((aiguillage[index].Adevie=Prec) and (aiguillage[index].AdevieB=Aprec) and (aiguillage[index].position<>const_droit)
        and (aiguillage[index_aig(AdrTjdP)].position=const_droit) and (tjsC) and tjscourbe1 and tjscourbe2) then
        begin
          if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
          A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 3 TJS prise dans sa 2eme position courbe
        if ((aiguillage[index].Adroit=Prec) and (aiguillage[index].AdroitB=Aprec) and (aiguillage[index].position=const_droit)
             and (aiguillage[index_aig(AdrTjdP)].position<>const_droit) and (tjsC) and tjscourbe1 and tjscourbe2 ) then
        begin
          if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
          A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
          suivant_alg3:=adr;
          Actuel:=aiguillage[index2].Adresse;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;
        if ((nivdebug>1) or traceliste) and not(init_aig_cours) then
        begin
          s:='1026 - position TJD/S '+IntToSTR(Adr)+'='+intToSTR(aiguillage[index].position)+' / '+intToSTR(index)+'='+intToSTR(aiguillage[index2].position)+' inconnue';
          AfficheDebug(s,clOrange);
        end;
        suivant_alg3:=9996; // position inconnue
        AigMal:=aiguillage[index].adresse;
        exit;
      end;
    end;

    if (aiguillage[index].modele=crois) then
    begin
       // si reservé
      if ((alg and 4)=4) and (aiguillage[index].AdrTrain<>0) then
      begin
        if NivDebug=3 then AfficheDebug('235 - croisement '+intToSTR(adr)+' réservé par train @'+intToSTR(aiguillage[index].AdrTrain),clyellow);
        suivant_alg3:=9994;
        exit;
      end;

      adr:=9999;
      if aiguillage[index].Adroit=prec then begin adr:=aiguillage[index].Ddroit;A:=aiguillage[index].DdroitB;end;
      if aiguillage[index].Adevie=prec then begin adr:=aiguillage[index].Ddevie;A:=aiguillage[index].DdevieB;end;
      if aiguillage[index].Ddevie=prec then begin adr:=aiguillage[index].Adevie;A:=aiguillage[index].AdevieB;end;
      if aiguillage[index].Ddroit=prec then begin adr:=aiguillage[index].Adroit;A:=aiguillage[index].AdroitB;end;
      if (A='Z') or (a=#0) then typeGen:=det else typeGen:=aig;
      suivant_alg3:=adr;
      if a='' then a:=' ';
      if (nivdebug>1) then Affichedebug('le port de destination du croisement '+intToSTR(aiguillage[index].adresse)+' est '+IntToSTR(adr)+a,clyellow);
      // Affiche('croisement '+intToSTR(prec)+' '+intToSTR(actuel),clLime);
      // mémoriser dans un tableau l'entrée et la sortie du croisement
      exit;
    end;

    if (aiguillage[index].modele=triple) then // aiguillage triple
    begin
      Adr2:=aiguillage[index].AdrTriple;
      if (aiguillage[index].Apointe=prec) then
      begin
        //aiguillage triple pris en pointe
        //Affiche('position='+intToSTR(aiguillage[index_aig(Adr].position),clyellow);
        if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(Adr2)].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple '+inttoSTR(aiguillage[index].adresse)+' pris en pointe droit',clYellow);
          A:=aiguillage[index].AdroitB;
          Adr:=aiguillage[index].Adroit;
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=détécteur 2=aig
          if adr=0 then TypeEl:=buttoir;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;  //??
          suivant_alg3:=adr;
          exit;
        end;
        if (aiguillage[index].position<>const_droit) and (aiguillage[index_aig(Adr2)].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple dévié1 (à gauche)',clYellow);
          A:=aiguillage[index].AdevieB;
          Adr:=aiguillage[index].Adevie;
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;
          if adr=0 then TypeEl:=buttoir;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(Adr2)].position<>const_droit)  then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple dévié2 (à droite)',clYellow);
          A:=aiguillage[index].Adevie2B;
          Adr:=aiguillage[index].Adevie2;
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[index].position=const_inconnu then
        begin
          AigMal:=aiguillage[index].adresse;
          suivant_alg3:=9996;
          exit;
        end; // pour échappement
        s:='Aiguillage triple '+IntToSTR(Adr)+' : configuration des aiguilles interdite';
        if CDM_connecte then s:=s+': '+IntToSTR(aiguillage[index].position);
        AfficheDebug(s,clYellow);
        Affiche(s,clRed);
        suivant_alg3:=9999;
        exit;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('Aiguillage triple pris en talon',clyellow);
        if (alg and 2)=2 then // on demande d'arreter si l'aiguillage en talon est mal positionné
        begin
          if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(adr2)].position=const_droit) then
          begin
            if prec<>aiguillage[index].Adroit then
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
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
              if (nivdebug>1) or traceliste then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
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
              if (nivdebug>1) or traceliste then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionné',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionné',clyellow);
            end;
          end;
        end;
        A:=aiguillage[index].ApointeB;
        Adr:=aiguillage[index].Apointe;
        if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;
        trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
        if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        suivant_alg3:=Adr;
        exit;
      end;
    end;
  end;
  suivant_alg3:=adr;
end;

// renvoie l'adresse du signal s'il est associé au détecteur "detecteur"
// sinon renvoie 0
function signal_detecteur(detecteur : integer) : integer;
var trouve : boolean;
    i : integer;
begin
  i:=1;
  repeat
    trouve:=(Signaux[i].Adr_det1=detecteur) or (Signaux[i].Adr_det2=detecteur) or (Signaux[i].Adr_det3=detecteur) or (Signaux[i].Adr_det4=detecteur);
    inc(i);
  until (i>=NbreSignaux+1) or trouve;
  if trouve then signal_detecteur:=Signaux[i-1].adresse else signal_detecteur:=0;
end;

// trouve l'index du signal associé au détecteur adr
// renvoie dans voie le numéro de la voie (1 à 4) du signal sur lequel le détecteur se trouve
// attention , il peut y avoir plus d'un signal sur un detecteur (suivant le sens)!
// si 2eme signal, son index est dans index2
function index_signal_det(adr : integer;var voie,index2 : integer) : integer ;
var trouve,i,index1 : integer;
    trouve1,trouve2,trouve3,trouve4 : boolean;
begin
  i:=1;
  trouve:=0;
  index2:=0;
  index1:=0;
  voie:=0;
  repeat
    trouve1:=Signaux[i].Adr_det1=adr;
    trouve2:=Signaux[i].Adr_det2=adr;
    trouve3:=Signaux[i].Adr_det3=adr;
    trouve4:=Signaux[i].Adr_det4=adr;

    if trouve1 or trouve2 or trouve3 or trouve4 then
    begin
      inc(trouve);
      if trouve=1 then index1:=i;
      if trouve=2 then index2:=i;
      if trouve=1 then              // on ne mémorise la voie qu'à la premiere recherche
      begin
        if trouve1 then voie:=1;
        if trouve2 then voie:=2;
        if trouve3 then voie:=3;
        if trouve4 then voie:=4;
      end;
    end;
    inc(i);
  until (trouve=2) or (i>NbreSignaux);
  Index_signal_det:=index1;
end;


//renvoie l'élément connecté de l'aiguillage ou de la tjd tjs "adr" sur le point D,S ou P passé par connect
procedure aig_ext(adr : integer ; connect : char;var suiv : integer;var typ_suiv: char);
var i : integer;
    typ : TEquipement;
begin
  i:=index_aig(adr);
  typ:=aiguillage[i].modele;

  if (typ=aig) or (typ=triple) then
  begin
    if connect='P' then
    begin
      suiv:=aiguillage[i].APointe;typ_suiv:=aiguillage[i].ApointeB;
    end;

    if connect='S' then
    begin
      suiv:=aiguillage[i].ADevie;typ_suiv:=aiguillage[i].ADevieB;
    end;

    if connect='D' then
    begin
      suiv:=aiguillage[i].ADroit;typ_suiv:=aiguillage[i].ADroitB;
    end;

    // aiguillage triple
    if connect='2' then
    begin
      suiv:=aiguillage[i].ADevie2;typ_suiv:=aiguillage[i].ADevie2B;
    end;
  end;

  if (typ=tjd) or (typ=tjs)  then
  begin
    //Affiche('TJD',clYellow);
    if connect='S' then
    begin
      suiv:=aiguillage[i].ADevie;typ_suiv:=aiguillage[i].ADevieB;
    end;
    if connect='D' then
    begin
      suiv:=aiguillage[i].ADroit;typ_suiv:=aiguillage[i].ADroitB;
    end;
  end;

  if (typ=crois) then
  begin
    if connect='S' then
    begin
      suiv:=aiguillage[i].ADevie;typ_suiv:=aiguillage[i].ADevieB;
    end;
    if connect='D' then
    begin
      suiv:=aiguillage[i].ADroit;typ_suiv:=aiguillage[i].ADroitB;
    end;
  end;
  if (typ_suiv=#0) or (typ_suiv='') or (typ_suiv=' ') then typ_suiv:='Z';
end;


// renvoie l'élément avant det2 si det1 et det2 sont contigus ou ne sont séparés que par des aiguillages
// les aiguillages n'ont pas besoin d'être positionnés
// si det1 et det2 sont contigus sans aiguillages entre eux, çà renvoie det1 sinon renvoie l'aiguillage entre les 2
// s'ils ne sont pas contigus, renvoie 0
// Si un élément est inconnu, renvoie 9999
// si le suivant est un buttoir 9995 
// det_contigu(527,520: renvoie   7 dans suivant
// det_contigu(514,522: renvoie 514 dans suivant
// det_contigu(517,524: renvoie  30
procedure det_contigu(det1,det2 : integer;var suivant : integer;var ElSuiv : TEquipement);
var suiv1,indexBranche_det1,indexBranche_det2,branche_det2,branche_det1,
    suiv_2,detC,indexBranche_det,suiv_pointe,dernier,it : integer;
    type1,Tp,type_dernier : Tequipement;
    type_tmp : char;
    trouve,afdeb : boolean;

  // donne le suivant au point de connexion de l'aiguillage
  // prec=adresse de det ou aig ; suiv soit être une adresse d'aig
  // aig_suiv(527,7) : renvoie 520 dans suiv_2
  // procédure récursive
  procedure aig_suiv(prec,suiv : integer);
  var adr2,index : integer;
      typ : Tequipement;
  begin
    inc(it);
    if it>50 then
    begin
      Affiche('Erreur 670 : limite de récursivité',clred);
      exit;
    end;
    index:=index_aig(suiv);
    typ:=aiguillage[index].modele;

    // aiguillage en pointe?
    if afdeb then afficheDebug('250. Aig_suiv('+intToSTR(prec)+','+intToSTR(suiv)+')',clOrange);

    aig_ext(suiv,'P',suiv_pointe,type_tmp);
    if (suiv_pointe=prec) and ((typ=aig) or (typ=triple)) then
    begin
      // faire le droit
      if afdeb then afficheDebug('251. Aig '+intToSTR(suiv)+' test en pointe droit',clyellow);
      type_Dernier:=aig;
      aig_ext(suiv,'D',suiv_2,type_tmp);
      if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
      begin
        trouve:=(suiv_2=det2);
        if trouve then
        begin
          dernier:=suiv;
          if afdeb then afficheDebug('trouvé ',clLime);
          exit;
        end;
        if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow);
      end;

      // faire le dévié
      if afdeb then afficheDebug('252.Aig '+intToSTR(suiv)+' test en pointe dévié',clyellow);
      type_Dernier:=aig;
      aig_ext(suiv,'S',suiv_2,type_tmp);
      if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
      begin
        trouve:=(suiv_2=det2);
        if trouve then
        begin
          dernier:=suiv;
          if afdeb then afficheDebug('trouvé ',clLime);
          exit;
        end;
        if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu ('+intToSTR(det2)+')',clyellow)
      end;

      // si triple faire S2
      if typ=triple then
      begin
        if afdeb then afficheDebug('Aig triple'+intToSTR(suiv)+' test en pointe dévié2',clyellow);
        type_Dernier:=aig;
        aig_ext(suiv,'2',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé ',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
        end;
      end;
    end
    else
    begin
      // aiguillage en talon ou tjd ou croisement

      type_Dernier:=aig;
      if (typ=aig) or (typ=triple) then
      begin
        if afdeb then afficheDebug('Aig '+intToSTR(suiv)+' test en talon',clyellow);
        aig_ext(suiv,'P',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé ',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
        end;
      end;

      if typ=tjd then
      begin
        if afdeb then afficheDebug('Tjd '+intToSTR(suiv),clyellow);
        Adr2:=aiguillage[index].DDevie; // 2eme adresse de la tjd
        //index2:=index_aig(adr2);
        suiv:=Adr2;

        aig_ext(suiv,'D',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé sur D',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
        end;
        aig_ext(suiv,'S',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé sur S',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
        end;
      end;

      if typ=tjs then
      begin
        if afdeb then afficheDebug('Tjs '+intToSTR(suiv),clyellow);
        Adr2:=aiguillage[index].DDevie; // 2eme adresse de la tjd
        //index2:=index_aig(adr2);
        suiv:=Adr2;
        aig_ext(suiv,'D',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé sur D',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu ('+intToSTR(det2)+')',clyellow)
        end;
        aig_ext(suiv,'S',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé sur S',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
        end;
      end;
      if typ=crois then
      begin
        if afdeb then afficheDebug('crois '+intToSTR(suiv),clyellow);
        if aiguillage[index].ADroit=prec then begin suiv_2:=aiguillage[index].Ddroit;type_tmp:=aiguillage[index].DdroitB;end;
        if aiguillage[index].DDroit=prec then begin suiv_2:=aiguillage[index].Adroit;type_tmp:=aiguillage[index].AdroitB;end;
        if aiguillage[index].ADevie=prec then begin suiv_2:=aiguillage[index].Ddevie;type_tmp:=aiguillage[index].DdevieB;end;
        if aiguillage[index].DDevie=prec then begin suiv_2:=aiguillage[index].ADevie;type_tmp:=aiguillage[index].AdevieB;end;
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouvé ',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouvé '+intToSTR(suiv_2)+' mais pas attendu ('+intToSTR(det2)+')',clyellow)
        end;
      end;
    end;
  end;    // fin de la procédure récursive aig_suiv


begin
  // trouver les éléments du précédent
  if debug=3 then formprinc.Caption:='Det_contigu '+intToSTR(det1)+' '+intToSTr(det2);
  afdeb:=false;//TraceListe  ;
  it:=0;
  if afdeb then afficheDebug('Det_contigu '+intToSTR(det1)+' '+intToSTr(det2),clyellow);
  if (det1>NbMaxDet) or (det2>NbMaxDet) then
  begin
    Affiche('Erreur 87 : Det_contigu '+intToSTR(det1)+' '+intToSTr(det2),clred);
    exit;
  end;

  tp:=det;
  if det1=0 then tp:=buttoir;
  trouve_element(det1,tp); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) and (tp<>buttoir) then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(det1)+' non trouvé',clred);
    if debug=3 then formprinc.Caption:='';
    suivant:=9999;
    exit;
  end;
  if (IndexBranche_trouve=0) and (tp=buttoir) then
  begin
    suivant:=9995;
    exit;
  end;

  indexBranche_det1:=IndexBranche_trouve;
  branche_det1:=branche_trouve;

  tp:=det;
  if det2=0 then tp:=buttoir;
  trouve_element(det2,tp); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(det2)+' non trouvé',clred);
    if debug=3 then formprinc.Caption:='';
    suivant:=9999;
    exit;
  end;

  trouve:=false;
  indexBranche_det2:=IndexBranche_trouve;
  branche_det2:=branche_trouve;
  detC:=det1;
  indexBranche_det:=indexBranche_det1;
  Branche_Det:=Branche_det1;
  dernier:=0;

  // faire en incrément
  if afdeb then afficheDebug('incrément',clcyan);
  suiv1:=BrancheN[Branche_Det,indexBranche_det+1].adresse;
  type1:=BrancheN[Branche_Det,indexBranche_det+1].Btype;  // det aig buttoir

  // type aig, aig triple, tjd, tjs
  if type1=aig then
  begin
    aig_suiv(detC,suiv1);
    if trouve then
    begin
      type_dernier:=aig;
      if afdeb then afficheDebug('ok1',cllime);
    end;
  end;

  if (type1=det) and not(trouve) then
  begin
    trouve:=suiv1=det2;
    if trouve then
    begin
      dernier:=det1;
      type_Dernier:=det;
      if afdeb then afficheDebug('ok2',ClLime);
    end;
  end;

  // faire en décrément
  if afdeb then afficheDebug('décrément',clcyan);
  if not(trouve) then
  begin
    suiv1:=BrancheN[Branche_Det,indexBranche_det-1].adresse;
    type1:=BrancheN[Branche_Det,indexBranche_det-1].Btype;
    if type1=aig then
    begin
      aig_suiv(detC,suiv1);
      if trouve then
      begin
        type_Dernier:=aig;
        if afdeb then afficheDebug('ok3',cllime);
      end;
    end;

    if (type1=det) and not(trouve) then
    begin
      trouve:=suiv1=det2;
      if trouve then
      begin
        dernier:=det1;
        if dernier=0 then type_dernier:=buttoir else type_dernier:=det;
        if afdeb then afficheDebug('ok4',ClLime);
      end;
    end;

  end;

  //Affiche(intToSTR(dernier),clOrange);
  if afdeb then
  begin
    if (dernier=0) then afficheDebug('----Pas trouvé',ClLime)
    else afficheDebug('----Trouvé dernier='+intToSTR(dernier),clLime);
  end;

  suivant:=dernier;ElSuiv:=type_dernier;
  if debug=3 then formprinc.Caption:='';
end;


// renvoie le détecteur suivant aux détecteurs 1 et 2
// les aiguillages n'ont pas besoin d'être positionnés entre 1 et 2.
// par contre pour le suivant au det2, les aiguillages doivent être positionnés
// si on ne trouve pas le suivant, renvoie 9999
function det_suiv_cont(det1,det2,alg : integer) : integer;
var dernier: integer;
    derniertyp : Tequipement;
begin
  // si un aiguilage est entre det1 et det2 renvoie l'aig, sinon renvoie det1 si det1 et det2 sont contigus
  det_contigu(det1,det2,dernier,dernierTyp);
  if (dernier<>0) and (dernier<>9999) then
  begin
    // détecteur suivant
    det_suiv_cont:=detecteur_suivant(dernier,dernierTyp,det2,det,alg);
     //Affiche(intToSTR(suivant),clorange);
  end
  else det_suiv_cont:=9999;
end;

// renvoie les adresses des détecteurs adjacents au détecteur "adresse" (avant, après)
// les aiguillages entre det1 et det2 doivent être positionnés
// résultat dans adj1 et adj2 en variable globale
procedure Det_Adj(adresse : integer);
var Adr,AdrFonc,Branche,AdrPrec,IndexBranche,i,Dir : integer;
    sortie : boolean;
    BtypeFonc,BtypePrec : TEquipement;
    s : string;
begin
  trouve_element(adresse,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    s:='Erreur 380 : élément '+IntToSTR(adresse)+' det non trouvé';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  IndexBranche:=IndexBranche_trouve;
  branche:=branche_trouve;
  Dir:=1 ; //test direction 1 ou 2 (incrément ou décrément)

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
      begin
        Adr:=AdrFonc;
        TypeGen:=BtypeFonc;
      end;
      if Adr>9990 then typeGen:=det;
      if (NivDebug=3) then AfficheDebug('trouvé '+intToSTR(Adr)+' '+BTypeToChaine(typeGen),clorange);
      AdrPrec:=AdrFonc;BtypePrec:=BtypeFonc;
      AdrFonc:=Adr;BtypeFonc:=typeGen;
      i:=i+1;
      sortie:=(i=20) or (Adr=0) or (Adr>=9990) or (TypeGen=det);
    until (sortie) ;   // boucle de parcours
    if (typeGen=det) and (Dir=1) then begin Adj1:=Adr;end;
    if (typeGen=det) and (Dir=2) then begin Adj2:=Adr;end;
    inc(dir);
  until dir=3;
end;

// renvoie l'adresse des détecteurs convergents précédents un signal après les aiguillages
// renvoie dans le tableau TabloDet
procedure det_prec_signal(adresse : integer;var tabloDet : TTabloDet);
var el1,el2,i,i2,index,it,voie : integer;
    tq1,tq2 : tEquipement;

  // explore les connexions d'un aiguillage - récursif
  procedure explore_branche(prec,adrAig : integer);
  var i,el1,el2 : integer;
      c: char;
      typ : tEquipement;
  begin
    inc(it);
    if it>40 then begin Affiche('Erreur récursive 95',clred);exit;end;
    i:=index_aig(adrAig);
    typ:=aiguillage[i].modele;

    if (typ=triple) then
    begin
       // pris en pointe?
      if aiguillage[i].APointe=prec then
      begin
        //Affiche('Aig'+inttostr(adraig)+' pointe droit',clyellow);
        el1:=adraig;tq1:=typ;
        // explore droit
        el2:=aiguillage[i].ADroit;
        c:=aiguillage[i].ADroitB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;inc(index);
        end;

        //Affiche('Aig'+inttostr(adraig)+' pointe dévié',clyellow);
        // explore dévié 1
        i:=index_aig(adrAig);
        el2:=aiguillage[i].ADevie;
        c:=aiguillage[i].ADevieB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;inc(index);
        end;

        // explore dévié 2
        i:=index_aig(adrAig);
        el2:=aiguillage[i].ADevie2;
        c:=aiguillage[i].ADevie2B;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
        end;
      end
      else
      // pris en talon
      begin
        el1:=adraig;tq1:=typ;
        //Affiche('Aig'+inttostr(adraig)+' talon',clyellow);
        // pris en talon
        el2:=aiguillage[i].APointe;
        c:=aiguillage[i].APointeB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
        end;
      end;
    end;

    if (typ=tjd) or (typ=tjs) then
    begin
      // 4 états
      if index_aig(aiguillage[i].EtatTJD)=4 then
      begin
        i2:=index_aig(aiguillage[i].DDevie);  // index de la tjd homologue
        // provenance de la tjd
        if (aiguillage[i].ADroit=prec) or (aiguillage[i].ADevie=prec) then
        begin
          // destination 1 de la tjd
          el2:=aiguillage[i2].Adevie;c:=aiguillage[i2].ADevieB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;

          // destination 2 de la tjd
          el2:=aiguillage[i2].Adroit;c:=aiguillage[i2].ADroitB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
           end;
        end;

        {
        // provenance 2 de la tjd
        if (aiguillage[i].ADevie=prec) or (aiguillage[i].ADroit=prec) then
        begin
          // destination 2 de la tjd
          el2:=aiguillage[i2].Adevie;c:=aiguillage[i2].ADevieB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;

          el2:=aiguillage[i2].Adroit;c:=aiguillage[i2].ADroitB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;
        end;}
      end;

      // 2 états
      if index_aig(aiguillage[i].EtatTJD)=2 then
      begin
        // provenance sens 1
        if (aiguillage[i].ADroit=prec) or (aiguillage[i].ADevie=prec) then
        begin
          // destination 1 de la tjd
          el2:=aiguillage[i].Ddevie;c:=aiguillage[i].DDevieB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;
           // destination 2 de la tjd
          el2:=aiguillage[i].Ddroit;c:=aiguillage[i].DDroitB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;
        end;

        // provenance sens 2
        if (aiguillage[i].DDevie=prec) or (aiguillage[i].Ddroit=prec) then
        begin
          // destination 1 de la tjd
          el2:=aiguillage[i].Adroit;c:=aiguillage[i].ADroitB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;
          // destination 2 de la tjd
          el2:=aiguillage[i].Adevie;c:=aiguillage[i].AdevieB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
          end;
        end;

      end;
    end;

    if typ=crois then
    begin
      //Affiche('croisement '+intToSTR(adrAig),clyellow);
      if aiguillage[i].Adroit=prec then begin el2:=aiguillage[i].Ddroit;c:=aiguillage[i].DdroitB;end;
      if aiguillage[i].Adevie=prec then begin el2:=aiguillage[i].Ddevie;c:=aiguillage[i].DdevieB;end;
      if aiguillage[i].Ddevie=prec then begin el2:=aiguillage[i].Adevie;c:=aiguillage[i].AdevieB;end;
      if aiguillage[i].Ddroit=prec then begin el2:=aiguillage[i].Adroit;c:=aiguillage[i].AdroitB;end;
      if (c='P') or (c='D') or (c='S') then
      begin
        //i:=index_aig(el2);
        //teq2:=aiguillage[i].modele;
        explore_branche(Adraig,el2);
      end
      else
      begin
        //Affiche(IntToSTR(el2),clLime);
        tabloDet[index]:=el2;inc(index);
      end;
    end;

    if typ=aig then
    begin
      // pris en pointe?
      if aiguillage[i].APointe=prec then
      begin
        //Affiche('Aig'+inttostr(adraig)+' pointe droit',clyellow);
        el1:=adraig;tq1:=typ;
        // explore droit
        el2:=aiguillage[i].ADroit;
        c:=aiguillage[i].ADroitB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
        end;

        //Affiche('Aig'+inttostr(adraig)+' pointe dévié',clyellow);
        // explore dévié
        i:=index_aig(adrAig);
        el2:=aiguillage[i].ADevie;
        c:=aiguillage[i].ADevieB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
        end;
      end
      else
      begin
        el1:=adraig;tq1:=typ;
        //Affiche('Aig'+inttostr(adraig)+' talon',clyellow);
        // pris en talon
        el2:=aiguillage[i].APointe;
        c:=aiguillage[i].APointeB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;inc(index);
        end;
      end;
    end;
  end;

begin
  // trouver éléments avant le signal
  for i:=1 to Mtd do tabloDet[i]:=0;
  i:=index_signal(adresse);
  if i=0 then
  begin
    affiche('Erreur 842 : signal '+intToSTR(adresse)+' inconnu',clred);
    exit;
  end;
  index:=1;
  for voie:=1 to 4 do
  begin
    //Affiche('Voie '+intToStr(voie),clyellow);
    case voie of
    1 : begin
          el2:=Signaux[i].Adr_det1;
          tq2:=det;
          el1:=Signaux[i].Adr_el_suiv1;
          tq1:=Signaux[i].Btype_suiv1;
        end;
    2 : begin
          el2:=Signaux[i].Adr_det2;
          tq2:=det;
          el1:=Signaux[i].Adr_el_suiv2;
          tq1:=Signaux[i].Btype_suiv2;
        end;
    3 : begin
          el2:=Signaux[i].Adr_det3;
          tq2:=det;
          el1:=Signaux[i].Adr_el_suiv3;
          tq1:=Signaux[i].Btype_suiv3;
        end;
    4 : begin
          el2:=Signaux[i].Adr_det4;
          tq2:=det;
          el1:=Signaux[i].Adr_el_suiv4;
          tq1:=Signaux[i].Btype_suiv4;
        end;
    end;

    if el2<>0 then
    begin
      it:=0;
      // élément avant le signal
      suivant:=suivant_alg3(el1,tq1,el2,det,0); //typeGen
      // si aiguillage
      if (typeGen=aig) or (typeGen=tjd) or (typeGen=tjs) or (typeGen=triple) then explore_branche(el2,suivant);
      if typeGen=det then begin tabloDet[1]:=suivant;index:=2;end;
    end;
  end;
  if index<=Mtd then tabloDet[index]:=0 else Affiche('Dépassement TabloDet signal '+intToSTR(Adresse),clred);
  {
  for i:=1 to Index do
  begin
    Affiche(IntToSTR(tabloDet[i]),clyellow);
  end;
  }
end;


// renvoie l'adresse du détecteur suivant les deux éléments
// les aiguillages doivent être correctement positionnés entre El1 et el2
// El1 et El2 peuvent être séparés par des aiguillages, mais de pas plus de 3 détecteurs
// remplit aussi le tableau des éléments[idEl] rencontrés de el2 au suivant
// en sortie : 9999= det1 ou det2 non trouvé
// 9995 : el2=0 buttoir
// 9996 : non trouvé
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,i1,N_det : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;

begin
  if debug=3 then formprinc.Caption:='Detecteur_suivant_el '+intToSTR(el1)+' '+intToSTR(el2);
  if NivDebug>=2 then
  AfficheDebug('Proc Detecteur_suivant_EL '+intToSTR(el1)+','+BTypeToChaine(Typedet1)+'/'+intToSTR(el2)+','+BTypeToChaine(Typedet2)+'-------------------------',clLime);
  if (el1>9000) or (el2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('Paramètres incorrects >9000',clred);
    detecteur_suivant_El:=9999;
    exit;
  end;

  if (el2=0) then
  begin
    detecteur_suivant_El:=9995;
    exit;
  end;

  // trouver détecteur 1
  trouve_element(el1,Typedet1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(el1)+' non trouvé';
      AfficheDebug(s,clOrange);
    end;
    detecteur_suivant_El:=9999;
    exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver détecteur 2
  trouve_element(el2,Typedet2); // branche_trouve  IndexBranche_trouve
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
  idEl:=1;
  // étape 1 : trouver le sens de progression (en incrément ou en décrément)

  repeat
    //préparer les variables
    AdrPrec:=el1;TypePrec:=typeDet1;
    if j=1 then i1:=IndexBranche_det1+1;
    if j=2 then i1:=IndexBranche_det1-1;
    // les suivants dansla branche sont:
    AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
    typeFonc:=BrancheN[branche_trouve_det1,i1].Btype;
    elements[idEl].adresse:=adrFonc;
    elements[idEl].typ:=TypeFonc;

    if NivDebug=3 then
    begin
      s:='------> Test en ';
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
          s:='613 : trouvé='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((typeDet2=TypeGen) and (Adr=el2)) or (Adr=0) or (Adr>=9990) or (i=15) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i=15) and (Nivdebug=3) then afficheDebug('Pas trouvé',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(el1)+' '+intToSTR(el2);
        afficheDebug(s,clorange);
      end;
    end

    else
    begin
      // déja trouvé
      adr:=el2;typeGen:=TypeDet2;
    end;

    idel:=1;
    if (typeDet2=TypeGen) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      if Nivdebug=3 then AfficheDebug('614 - Trouvé '+intToSTR(el2),clYellow);
      inc(idEl);
      elements[idEl].adresse:=el2;
      elements[idEl].typ:=Typedet2;

      i:=0;
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg);
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);

        if NivDebug=3 then
        begin
          s:='615 : trouvé='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clorange);
        end;
        inc(idEl);
        elements[idEl].adresse:=adr;
        elements[idEl].typ:=TypeGen;

        ADrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=(TypeGen=det) or (Adr=0) or (Adr>=9990) or (i=10);
      until sortie;

      if (TypeGen=det) or (TypeGen=buttoir) then
      begin
        if NivDebug=3 then
        begin
          AfficheDebug('le détecteur suivant est le '+IntToSTR(Adr),clyellow);
          affichedebug('------------------',clyellow);
        end;
        detecteur_suivant_el:=Adr;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
    end;
    if (i=10) then if NivDebug=3 then AfficheDebug('201 : Itération trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incrément/décrément

  detecteur_suivant_el:=9996;
  if NivDebug=3 then affichedebug('------------------',clyellow);
  if debug=3 then formprinc.Caption:='';
end;


// mode=0 = libère    1=réserve  reserve_dereserve_det(detecteur1,detecteur2,adrTrain,i,1);
function reserve_dereserve_det(det1,det2,adrTrain,indexTrain,mode : integer) : integer;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,k,AdrPrec,Adr,AdrFonc,i1,N_det : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;
begin
  s:='Reserve_dereserve_det '+intToSTR(det1)+' '+intToSTR(det2)+' pour train ';
  if roulage then s:=s+'@'+intToSTR(adrtrain)
  else if avecResa then s:=s+intToSTR(IndexTrain);
  if traceliste or ProcPrinc then afficheDebug(s,clorange);
  Affiche(s,ClOrange);

  if NivDebug>=2 then
  if (det1>9000) or (det2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('Paramètres incorrects >9000',clred);
    reserve_dereserve_det:=9999;
    exit;
  end;

  if (det2=0) then
  begin
    reserve_dereserve_det:=9995;
    exit;
  end;

  // trouver détecteur 1
  trouve_element(det1,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(det1)+' non trouvé';
      AfficheDebug(s,clOrange);
    end;
    reserve_dereserve_det:=9999;
    exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver détecteur 2
  trouve_element(det2,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(det2)+' non trouvé';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    reserve_dereserve_det:=9999;exit;
  end;

  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  j:=1;  // J=1 test en incrément J=2 test en décrément

  // étape 1 : trouver le sens de progression (en incrément ou en décrément)

  repeat
    //préparer les variables
    AdrPrec:=det1;TypePrec:=det;
    if j=1 then i1:=IndexBranche_det1+1;
    if j=2 then i1:=IndexBranche_det1-1;
    // les suivants dansla branche sont:
    AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
    typeFonc:=BrancheN[branche_trouve_det1,i1].Btype;
    
    if NivDebug=3 then
    begin
      s:='------> Test en ';
      if (j=1) then s:=s+'incrément ' else s:=s+'décrément ';
      s:=s+'- départ depuis élément '+IntToSTR(det1)+' trouvé en index='+intToSTR(IndexBranche_det1)+' Branche='+intToSTR(branche_trouve_det1);
      AfficheDebug(s,clyellow);
    end;

    i:=0;N_Det:=0;
    if AdrFonc<>det2 then // si pas déja trouvé le sens de progression
    begin
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        if nivDebug=3 then AfficheDebug('i='+IntToSTR(i)+' NDet='+IntToSTR(N_det),clyellow);
        if (AdrFonc<>0) or (TypeFonc<>rien) then Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,1) else
        begin
          Adr:=9999;
        end;
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);
        if TypeGen=det then inc(N_Det);
        if NivDebug=3 then
        begin
          s:='613 : trouvé='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((TypeGen=det) and (Adr=det2)) or (Adr=0) or (Adr>=9990) or (i=15) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i=15) and (Nivdebug=3) then afficheDebug('Pas trouvé',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(det1)+' '+intToSTR(det2);
        afficheDebug(s,clorange);
      end;
    end

    else
    begin
      // déja trouvé
      adr:=det2;typeGen:=det;
    end;

    idel:=1;
    elements[idEl].adresse:=adrPrec;
    elements[idEl].typ:=TypePrec;

    if (TypeGen=det) and (Adr=det2) and (N_Det<>Nb_det_dist) then
    begin

      i:=0;
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        Adr:=suivant_alg3(AdrFonc,TypeFonc,AdrPrec,TypePrec,1);
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);

        if NivDebug=3 then
        begin
          s:='615 : trouvé='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clorange);
        end;
        inc(idEl);
        elements[idEl].adresse:=adr;
        elements[idEl].typ:=TypeGen;

        AdrFonc:=AdrPrec;TypeFonc:=TypePrec;
        AdrPrec:=Adr;TypePrec:=TypeGen;

        inc(i);
        sortie:=(TypeGen=det) or (Adr=0) or (Adr>=9990) or (i=10);
      until sortie;

      if (TypeGen=det) or (TypeGen=buttoir) then
      begin
        for k:=1 to IdEl do
        begin
          j:=elements[k].adresse;
          typePrec:=elements[k].typ;
          if (typePrec=Aig) or (typePrec=tjd) or (typePrec=tjs) or (typePrec=crois) or (typePrec=triple) then
          begin
            if TraceListe then AfficheDebug_Suivi(intToSTR(k)+' ',clOrange);
            if mode=0 then Aiguillage[index_aig(j)].AdrTrain:=0
            else
              if (Aiguillage[index_aig(k)].AdrTrain=0) then
              begin
                if avecresa then Aiguillage[index_aig(j)].AdrTrain:=indexTrain;
                if roulage then Aiguillage[index_aig(j)].AdrTrain:=AdrTrain;
              end;
            Texte_aig_fond(j);
          end;
        end;
        reserve_dereserve_det:=0;
        exit;
      end;
    end;
    if (i=10) then if NivDebug=3 then AfficheDebug('201 : Itération trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incrément/décrément

  reserve_dereserve_det:=9996;
  if NivDebug=3 then affichedebug('------------------',clyellow);
  if debug=3 then formprinc.Caption:='';
end;

// renvoie le nombre de croisements entre les détecteurs el1 et el2
// jamais utilisée !
function Test_croisement(el1,el2,alg: integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,i1,N_det : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;

begin
  if NivDebug>2 then AfficheDebug('Proc Test_croisement '+intToSTR(el1)+','+intToSTR(el2)+',',clyellow);
  if (el1>9000) or (el2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('paramètres incorrects >9000',clred);
    Test_croisement:=9999;
    exit;
  end;

  // trouver détecteur 1
  trouve_element(el1,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(el1)+' non trouvé';
      AfficheDebug(s,clOrange);
    end;
    Test_croisement:=9999;
    exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver détecteur 2
  trouve_element(el2,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(el2)+' non trouvé';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    Test_croisement:=9999;exit;
  end;
  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  j:=1;  // J=1 test en incrément J=2 test en décrément

  // étape 1 : trouver le sens de progression (en incrément ou en décrément)

  repeat
    //préparer les variables
    ncrois:=0;  // pour voir si on passe par un croisement
    AdrPrec:=el1;TypePrec:=det;
    if j=1 then i1:=IndexBranche_det1+1;
    if j=2 then i1:=IndexBranche_det1-1;
    // les suivants dansla branche sont:
    AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
    typeFonc:=BrancheN[branche_trouve_det1,i1].Btype ;

    if NivDebug=3 then
    begin
      s:='------> Test en ';
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
          s:='713 : trouvé='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((TypeGen=det) and (Adr=el2)) or (Adr=0) or (Adr>=9990) or (i=15) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i=15) and (Nivdebug=3) then afficheDebug('Pas trouvé',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(el1)+' '+intToSTR(el2);
        afficheDebug(s,clorange);
      end;  
    end

    else
    begin
      // déja trouvé
      adr:=el2;typeGen:=det;
    end;
  
    if (TypeGen=det) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      test_croisement:=ncrois;
      exit;
    end;
    if (i=10) then if NivDebug=3 then AfficheDebug('711 : Itération trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incrément/décrément

  Test_croisement:=0;
  ncrois:=0;    // annuler le croisement détecté
  if NivDebug=3 then affichedebug('------------------',clyellow);
end;


// renvoie vrai si les aiguillages déclarés pour le feu blanc sont bien positionnés
function cond_feuBlanc(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig,index : integer;
    resultatET,resultatOU: boolean;
    s : string;
begin
  i:=Index_Signal(adresse);
  if i=0 then
  begin
    s:='Erreur 602 - Signal '+IntToSTR(adresse)+' non trouvé';
    Affiche(s,clred);
    if NivDebug=3 then AfficheDebug(s,clred);
    cond_feuBlanc:=false;
    exit;
  end;

  NCondCarre:=Length(Signaux[i].condFeuBlanc[1]);

  l:=1;
  resultatOU:=false;

  while NcondCarre<>0 do
  begin
    if Ncondcarre<>0 then dec(Ncondcarre);
    resultatET:=true;
    for k:=1 to NcondCarre do
    begin
      //s2:=s2+'A'+IntToSTR(Signaux[i].condFeuBlanc[l][k].Adresse)+Signaux[i].condFeuBlanc[l][k].PosAig+' ';
      AdrAig:=Signaux[i].condFeuBlanc[l][k].Adresse;
      index:=index_aig(adrAig);
      if index<>0 then
      begin
        if nivDebug=3 then AfficheDebug('Contrôle aiguillage '+IntToSTR(AdrAig),clyellow);
        resultatET:=( (aiguillage[index].position=const_devie) and (Signaux[i].condFeuBlanc[l][k].PosAig='S') or
                      (aiguillage[index].position=const_droit) and (Signaux[i].condFeuBlanc[l][k].PosAig='D') )
                     and resultatET;
      end;
    end;
    //if resultatET then Affiche('VRAI',clyellow) else affiche('FAUX',clred);
    inc(l);
    resultatOU:=resultatOU or resultatET;
    NCondCarre:=Length(Signaux[i].condFeuBlanc[l]);
  end;
  //if resultatOU then Affiche('VRAI final',clyellow) else affiche('FAUX final',clred);
  if NivDebug=3 then
  begin
    s:='Conditions supp. de feu blanc suivant aiguillages: ';
    if ResultatOU then s:=s+'le signal doit afficher blanc' else s:=s+'le signal ne doit pas afficher de feu blanc';
    AfficheDebug(s,clyellow);
  end;
  cond_feuBlanc:=ResultatOU;
end;


// renvoie vrai si les aiguillages déclarés dans les conditions supplémentaires pour le signal "adresse" sont mal positionnés
function cond_carre(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig,index : integer;
    resultatET,resultatOU: boolean;
    s : string;
begin
  i:=Index_Signal(adresse);
  if i=0 then
  begin
    s:='Erreur 602 - Signal '+IntToSTR(adresse)+' non trouvé';
    Affiche(s,clred);
    if NivDebug=3 then AfficheDebug(s,clred);
    cond_carre:=true;
    exit;
  end;

  NCondCarre:=Length(Signaux[i].condcarre[1]);

  l:=1;
  resultatOU:=false;

  while NcondCarre<>0 do
  begin
    if Ncondcarre<>0 then dec(Ncondcarre);
    resultatET:=true;
    for k:=1 to NcondCarre do
    begin
      //s2:=s2+'A'+IntToSTR(Signaux[i].condcarre[l][k].Adresse)+Signaux[i].condcarre[l][k].PosAig+' ';
      AdrAig:=Signaux[i].condcarre[l][k].Adresse;
      index:=index_aig(adrAig);
      if index<>0 then
      begin
        if nivDebug=3 then AfficheDebug('Contrôle aiguillage '+IntToSTR(AdrAig),clyellow);
        resultatET:=((aiguillage[index].position=const_devie) and (Signaux[i].condcarre[l][k].PosAig='S') or (aiguillage[index].position=const_droit) and (Signaux[i].condcarre[l][k].PosAig='D'))
                  and resultatET;
      end;
    end;
    //if resultatET then Affiche('VRAI',clyellow) else affiche('FAUX',clred);
    inc(l);
    resultatOU:=resultatOU or resultatET;
    NCondCarre:=Length(Signaux[i].condcarre[l]);
  end;
  //if resultatOU then Affiche('VRAI final',clyellow) else affiche('FAUX final',clred);
  if NivDebug=3 then
  begin
    s:='Conditions supp. de carré suivant aiguillages: ';
    if ResultatOU then s:=s+'le signal doit afficher carré' else s:=s+'le signal ne doit pas afficher de carré';
    AfficheDebug(s,clyellow);
  end;
  cond_carre:=ResultatOU;
end;

// renvoie l'adresse de l'aiguillage mal positionné si le signal adresse doit afficher un carré car les aiguillages au dela du signal
// sont mal positionnés. renvoie 0 si les aiguillages sont bien positionnés
// et teste si les éléments jusqu'au signal suivant s'ils sont verrouillés
// TrainReserve : adresse du train qui demande la fonction ou 0
// Si reserveTrainTiers=vrai, le parcours est réservé par un autre train
function carre_signal(adresse,TrainReserve : integer;var reserveTrainTiers : boolean;Var AdrTrain : integer) : integer;
var
   i,j,k,prec,indexSignal,AdrSuiv,index2,voie,AdrSignal : integer;
   TypeELPrec,TypeElActuel : TEquipement;
   sort,prestrain  : boolean;
   s : string;
begin
  AdrTrain:=0;
  ReserveTrainTiers:=false;
  if (NivDebug>=1) or ProcPrinc then AfficheDebug('Proc carre_signal '+IntToSTR(adresse)+' -----------',clyellow);

  i:=Index_Signal(adresse);
  if i=0 then
  begin
    s:='Erreur 603 - Signal '+IntToSTR(adresse)+' non trouvé';
    Affiche(s,clred);
    if NivDebug=3 then AfficheDebug(s,clred);
    carre_signal:=adresse;
    exit;
  end;

  if isDirectionnel(i) then
  begin
    s:='La demande de carré d''un signal directionnel '+IntToSTR(Adresse)+' est irrecevable';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    carre_signal:=adresse;
    exit;
  end;

  j:=0;
  prec:=Signaux[i].Adr_det1;
  TypeElPrec:=Det;
  actuel:=Signaux[i].Adr_el_suiv1;
  if Signaux[i].Btype_suiv1=det then TypeElActuel:=det;  // le type du signal   1=détecteur   2=aig  5=bis
  if Signaux[i].Btype_suiv1=aig then TypeElActuel:=aig;

  // en multivoie, trouver si une des voies présente un train
  if Signaux[i].Adr_det2<>0 then
  begin
    prestrain:=presTrainPrec(adresse,Nb_cantons_Sig,false,AdrTrain,voie); // retourne la voie où se trouve le train avant le signal
    if prestrain then
    begin
      if nivdebug=3 then AfficheDebug('trouvé train sur voie '+intToSTR(voie),clYellow);
      case voie of
      1: begin prec:=Signaux[i].Adr_det1; actuel:=Signaux[i].Adr_el_suiv1; TypeElActuel:=Signaux[i].Btype_suiv1; end;
      2: begin prec:=Signaux[i].Adr_det2; actuel:=Signaux[i].Adr_el_suiv2; TypeElActuel:=Signaux[i].Btype_suiv2; end;
      3: begin prec:=Signaux[i].Adr_det3; actuel:=Signaux[i].Adr_el_suiv3; TypeElActuel:=Signaux[i].Btype_suiv3; end;
      4: begin prec:=Signaux[i].Adr_det4; actuel:=Signaux[i].Adr_el_suiv4; TypeElActuel:=Signaux[i].Btype_suiv4; end;
      end;
      if (prec=0) then
      begin
        s:='Erreur 780 : détecteur nul déclaré sur signal '+intToSTR(adresse);
        Affiche(s,clred);
        affichedebug(s,clred);
        result:=0;
        reserveTrainTiers:=false;
        AdrTrain:=0;
        exit;
      end;

      TypeElPrec:=Det;
    end
    else
    begin
      // si pas de train avant signal : verrouiller au carré
      reserveTrainTiers:=false;
      carre_signal:=adresse;
      exit;
    end;

  end;

  if debug=3 then formprinc.Caption:='carre_signal '+intToSTR(adresse);
  if (typeElActuel=Aig) or (typeElActuel=Crois) then
  begin
    // adresse
    k:=index_aig(actuel);
    if aiguillage[k].AdrTrain<>0 then
    begin
      AdrTrain:=aiguillage[k].AdrTrain;
      if AdrTrain<>0 then
      begin
        reserveTrainTiers:=reserveTrainTiers or (adrTrain<>TrainReserve);
        if (nivdebug>=1) then AfficheDebug('Aiguillage '+intToSTR(aiguillage[k].adresse)+' verrouillé par train @'+intToSTR(AdrTrain),clorange);
      end;
    end;
  end;

  //Affiche(IntToSTR(actuel),clyellow);
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(prec,typeElPrec,actuel,typeELActuel,2);  // arret sur aiguille en talon mal positionéne

    if (AdrSuiv=9999) or (AdrSuiv=9996) or (AdrSuiv=9995) then // élément non trouvé ou position aiguillage inconnu ou buttoir
    begin;
      carre_signal:=AigMal;
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    if (AdrSuiv<>9998) then // arret sur aiguillage en talon mal positionnée
    begin
      prec:=actuel;
      TypeElPrec:=TypeElActuel;
      actuel:=AdrSuiv;
      TypeElActuel:=typeGen;
    end;

    // si le précédent est un détecteur comporte t-il un signal?
    indexSignal:=0;
    if (typeElPrec=det) then
    begin
      indexSignal:=index_signal_det(prec,voie,index2); // trouve l'index du signal correspondant au détecteur AdrSuiv

      if indexSignal<>0 then
      begin
        AdrSignal:=Signaux[indexSignal].adresse;

        if nivdebug=3 then s:='Trouvé signal '+intToSTR(AdrSignal);
        if ((voie=1) and (Signaux[indexSignal].Adr_el_suiv1=AdrSuiv)) or
           ((voie=2) and (Signaux[indexSignal].Adr_el_suiv2=AdrSuiv)) or
           ((voie=3) and (Signaux[indexSignal].Adr_el_suiv3=AdrSuiv)) or
           ((voie=4) and (Signaux[indexSignal].Adr_el_suiv4=AdrSuiv))
        then   // le signal est-il dans le bon sens de progression?
        begin
          if nivdebug=3 then begin s:=s+' dans le bon sens';AfficheDebug(s,clYellow);end;
        end
        else
        begin
          if nivdebug=3 then
          begin
            s:=s+' dans le mauvais sens';
            AfficheDebug(s,clYellow);
          end;
          indexSignal:=0;
          // 2eme signal?
          if index2<>0 then
          begin
            // vérifier le 2eme signal
            AdrSignal:=Signaux[index2].Adresse;

            if (adrSignal=Adresse) then // si on ne reboucle sur le même signal dont on cherche le suivant
            begin
              IndexSignal:=0;
              j:=10; // on ne trouve pas de suivant
            end;
            if (Signaux[index2].Adr_el_suiv1=AdrSuiv) then   // le signal est-il dans le bon sens de progression?
            begin
              // oui
              if NivDebug=3 then AfficheDebug('Sur même détecteur, trouvé signal2 suivant Adr='+IntToSTR(AdrSignal)+': ',clYellow);
              indexSignal:=index2;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('Sur même détecteur, trouvé signal2 '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
              IndexSignal:=0;
            end;
         end;
        end;
      end;
      //Affiche(IntToSTR(AdrFeu),clOrange);
    end;

    // si le suivant est un aiguillage , mais ne vérifier que si pas trouvé de signal
    if ((typeElActuel=Aig) or (typeElActuel=Crois)) and (AdrSignal=0) then
    begin
      // adresse
      k:=index_aig(actuel);
      if aiguillage[k].AdrTrain<>0 then
      begin
        AdrTrain:=aiguillage[k].AdrTrain;
        if adrTrain<>0 then
        begin
          reserveTrainTiers:=reserveTrainTiers or (AdrTrain<>Trainreserve);
          if (nivdebug>=1) then AfficheDebug('Aiguillage '+intToSTR(aiguillage[k].adresse)+' verrouillé par train @'+intToSTR(AdrTrain),clorange);
        end;
      end;
    end;

    sort:=(j=10) or (indexSignal<>0) or (AdrSuiv=9998) or (AdrSuiv=0); // arret si aiguillage en talon ou buttoir
  until (sort);
  // si trouvé un signal ou j=10, les aiguillages sont bien positionnés
  // si trouvé 9998, aiguillages mal positionnés
  if (NivDebug=3) then
  begin
   if (AdrSuiv=9998) then AfficheDebug('Le signal '+intToSTR(adresse)+' doit afficher un carré car l''aiguillage pris en talon '+IntToSTR(actuel)+' est mal positionné',clYellow);
   if AdrTrain<>0 then afficheDebug('Un aiguillage est réservé par le train '+intToSTR(AdrTrain),clyellow);
   if (AdrSuiv<>9998) and (AdrTrain=0) then AfficheDebug('Le signal '+intToSTR(adresse)+' ne doit pas afficher de carré',clyellow);
  end;
  if AdrSuiv=9998 then result:=actuel else result:=0;
  //AdrSuiv=9998;
  if debug=3 then formprinc.Caption:='';
end;


// renvoie l'adresse du signal suivant (et dans le bon sens) à partir du détecteur det1 (non compris) et dans le sens det1 vers det2.
// Si renvoie 0, pas trouvé le signal suivant.
function signal_suivant_det(det1,det2 : integer) : integer;
var num_signal,AdrSignal,i,j,prec,AdrSuiv,index2,voie : integer;
    Typ,TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  //traceDet:=true;
  if (NivDebug>=2) or ProcPrinc then AfficheDebug('Cherche signal suivant au détecteurs '+IntToSTR(det1)+' '+intToSTR(det2),clyellow);

  if (det1>NbMaxDet) or (det2>NbMaxDet) then
  begin
    Affiche('Erreur 64 : signal_suivant_det '+intToSTR(det1)+' '+intToSTr(det2),clred);
    exit;
  end;

  // trouve l'élément suivant contigu
  det_contigu(det2,det1,i,Typ);
  if (i=0) or (i=9995) then  // 9995:buttoir
  begin
    //affiche('Erreur 65 : Signal_suivant_det('+intToSTR(det1)+','+intToSTR(det2)+') ne sont pas liés ',clred);
    signal_suivant_det:=0;
    exit;
  end;

  // si det1 et det2 sont contigus, i=det1
  // sinon i contient l'adresse de l'aiguillage avant det2

  if debug=3 then formprinc.Caption:='signal_suivant_det '+intToSTR(det1)+' '+inttostr(det2);
  j:=0;
  prec:=det1;  // détecteur sur le courant
  TypePrec:=det;
  if prec=0 then
  begin
    Affiche('Msg 601 - Signal '+intToSTR(prec)+' détecteur non renseigné ',clOrange);
    if NivDebug=3 then AfficheDebug('Msg 602 - détecteur '+intToSTR(prec)+' non renseigné ',clOrange);
    signal_suivant_det:=0;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;

  actuel:=i;
  typeActuel:=typ;

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
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);  // arret sur élément suivant
      if Nivdebug=3 then AfficheDebug('Suivant='+intToSTR(AdrSuiv),clyellow);

      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

      if (AdrSuiv=9999) or (AdrSuiv=9996) then
      begin
        signal_suivant_det:=0;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
      if (AdrSuiv=0) then
      begin
        if NivDebug=3 then AfficheDebug(intToSTR(j)+' Le suivant est un buttoir',clyellow);
        signal_suivant_det:=0;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
    end;
    // si le suivant est un détecteur comporte t-il un signal?
    AdrSignal:=0;
    if (TypeActuel=det) then  // détecteur?
    begin
      i:=Index_signal_det(Actuel,voie,index2); // trouve l'index de signal affecté au détecteur "Actuel"
      if i<>0 then
      begin
        AdrSignal:=Signaux[i].Adresse;
        if (AdrSignal=det1) then // si on ne reboucle sur le même signal dont on cherche le suivant
        begin
          AdrSignal:=0;j:=10; // on ne trouve pas de suivant
        end;
        if (AdrSignal<>0) then // si l'adresse est <>0
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          if nivdebug=3 then afficheDebug('Trouvé signal='+IntToSTR(AdrSignal)+'sur det '+intToSTR(actuel)+' Suivant='+IntToSTR(AdrSuiv)+' sur voie='+IntToSTR(voie),clyellow );
          if ((voie=1) and (Signaux[i].Adr_el_suiv1=AdrSuiv)) or
             ((voie=2) and (Signaux[i].Adr_el_suiv2=AdrSuiv)) or
             ((voie=3) and (Signaux[i].Adr_el_suiv3=AdrSuiv)) or
             ((voie=4) and (Signaux[i].Adr_el_suiv4=AdrSuiv))
          then   // le signal est-il dans le bon sens de progression?
          begin
            // oui
            signal_suivant_det:=AdrSignal;
            if NivDebug=3 then
            begin
              s:='Trouvé signal suivant Adr='+IntToSTR(AdrSignal);
              AfficheDebug(s,clorange);
            end;
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouvé signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
            AdrSignal:=0;
            if index2<>0 then
            begin
              // vérifier le 2eme signal
              AdrSignal:=Signaux[index2].Adresse;
              if (AdrSignal=det1) then // si on ne reboucle sur le même signal dont on cherche le suivant
              begin
                 AdrSignal:=0;j:=10; // on ne trouve pas de suivant
              end;
              if (Signaux[index2].Adr_el_suiv1=AdrSuiv) then   // le signal est-il dans le bon sens de progression?
              begin
                // oui
                inc(num_signal);
                signal_suivant_det:=AdrSignal;
                if NivDebug=3 then
                begin
                  s:=IntToSTR(AdrSignal);
                  AfficheDebug('Sur même détecteur, trouvé signal2 suivant Adr='+s,clorange);
                end;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Sur même détecteur, trouvé signal2 '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
                AdrSignal:=0;
              end;
            end;
          end;
        end
      end
      else if nivDebug=3 then AfficheDebug('Pas de signal pour le det '+IntToSTR(AdrSuiv),clyellow);
    end;
  until (j=10) or (AdrSignal<>0);
  signal_suivant_det:=AdrSignal;

  if debug=3 then formprinc.Caption:='';
  if (NivDebug=3) and (AdrSignal=0) then AfficheDebug('Pas Trouvé de signal suivant au signal Adr='+IntToSTR(det1),clOrange);
end;

function modele(adresse : integer;mdl : tEquipement) : tequipement;
begin
  if mdl=det then result:=det;
  if mdl=aig then
  begin
    result:=aiguillage[index_aig(adresse)].modele;
  end;
end;


// renvoie l'état du signal suivant du signal "adresse". Si renvoie 0, pas trouvé le signal suivant.
// adresse : adresse du signal
// rang=1 pour signal suivant, 2 pour signal suivant le 1, etc
// retour dans AdrSignalsuivant : adresse du signal suivant
// remplit aussi les élements[] rencontrés
// stocke les éléments trouvés dans Elements
function etat_signal_suivant(Adresse,rang : integer;var AdrSignalsuivant : integer) : integer;
var index,num_signal,etat,AdrSignal,i,j,prec,AdrSuiv,index2,voie : integer;
    aspect,combine : integer;
    TypePrec,TypeActuel,typ : TEquipement;
    s : string;
begin
  if ProcPrinc or (NivDebug>=2) then AfficheDebug('Cherche état du signal suivant au '+IntToSTR(adresse),clyellow);
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    if NivDebug>=2 then AfficheDebug('Signal '+IntToSTR(adresse)+' non trouvé',clyellow);
    etat_signal_suivant:=0;
    AdrSignalsuivant:=0;
    exit;
  end;
  if isDirectionnel(i) then
  begin
    s:='La demande de l''état du signal suivant depuis un signal directionnel '+IntToSTR(Adresse)+' est irrecevable';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    etat_signal_suivant:=0;
    exit;
  end;

  Etat:=0;
  j:=0;
  num_signal:=0;
  prec:=Signaux[i].Adr_det1;  // détecteur sur le courant
  TypePrec:=det;
  if prec=0 then
  begin
    s:='Msg 601 - Signal '+intToSTR(adresse)+' détecteur non renseigné';
    Affiche(s,clOrange);
    if NivDebug=3 then AfficheDebug(s,clOrange);
    etat_signal_suivant:=0;
    AdrSignalsuivant:=0;
    exit;
  end;

  if debug=3 then formprinc.Caption:='Etat_signal_suivant '+intToSTR(adresse);
  actuel:=Signaux[i].Adr_el_suiv1;
  typeActuel:=Signaux[i].Btype_suiv1;

  elements[1].adresse:=actuel;elements[1].typ:=typeActuel;
  idEl:=2;

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
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1); // 1 =
      if Nivdebug=3 then AfficheDebug('Suivant='+intToSTR(AdrSuiv),clyellow);
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

      if idEl<Maxelements then
      begin
        // rectifier le type de l'élément
        elements[idEl].adresse:=actuel;
        typ:=modele(actuel,typeActuel);
        elements[IdEl].typ:=typ;
        inc(idEl);

        if (typ=tjs) or (typ=tjd) then
        begin
          index:=index_aig(actuel);
          if aiguillage[index].EtatTJD=4 then
          begin
            index:=index_aig(aiguillage[index].DDevie);  // index de la tjd homologue
            elements[idEl].adresse:=aiguillage[index].Adresse;
            elements[idEl].typ:=typ;
            inc(idel);
          end;
        end;
      end;

      if (AdrSuiv=9999) or (AdrSuiv=9996) then // erreur fatale ou position inconnue
      begin
        Etat_signal_suivant:=0;
        AdrSignalsuivant:=0;
        exit;
      end;
      if (AdrSuiv=0) then
      begin
        if NivDebug=3 then AfficheDebug(intToSTR(j)+' Le suivant est un buttoir',clyellow);
        Etat_signal_suivant:=carre_F; // faire comme si c'était un signal au carré
        AdrSignalsuivant:=0;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
    end;
    // si le suivant est un détecteur comporte t-il un signal?
    AdrSignal:=0;
    if (TypeActuel=det) then  // détecteur?
    begin
      i:=Index_signal_det(Actuel,voie,index2); // trouve l'index de signal affecté au détecteur "Actuel"
      if i<>0 then
      begin
        AdrSignal:=Signaux[i].Adresse;
        if (AdrSignal=Adresse) then // si on ne reboucle sur le même signal dont on cherche le suivant
        begin
          AdrSignal:=0;j:=10; // on ne trouve pas de suivant
        end;
        if (AdrSignal<>0) then // si l'adresse est <>0
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          if nivdebug=3 then afficheDebug('Trouvé signal='+IntToSTR(AdrSignal)+'sur det '+intToSTR(actuel)+' Suivant='+IntToSTR(AdrSuiv)+' sur voie='+IntToSTR(voie),clyellow );
          if ((voie=1) and (Signaux[i].Adr_el_suiv1=AdrSuiv)) or
             ((voie=2) and (Signaux[i].Adr_el_suiv2=AdrSuiv)) or
             ((voie=3) and (Signaux[i].Adr_el_suiv3=AdrSuiv)) or
             ((voie=4) and (Signaux[i].Adr_el_suiv4=AdrSuiv))
           then   // le signal est-il dans le bon sens de progression?
          begin
            // oui
            inc(num_signal);
            Etat:=Signaux[Index_Signal(AdrSignal)].EtatSignal;
            code_to_aspect(Etat,aspect,combine);
            Signal_suivant:=AdrSignal;
            if NivDebug=3 then
            begin
              s:='Trouvé signal suivant Adr='+IntToSTR(AdrSignal)+': '+IntToSTR(etat)+'=';
              s:=s+chaine_signal(AdrSignal);
              AfficheDebug(s,clorange);
            end;
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouvé signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
            AdrSignal:=0;
            if index2<>0 then
            begin
               // vérifier le 2eme signal
               AdrSignal:=Signaux[index2].Adresse;

               if (AdrSignal=Adresse) then // si on ne reboucle sur le même signal dont on cherche le suivant
               begin
                 AdrSignal:=0;j:=10; // on ne trouve pas de suivant
               end;
               if (Signaux[index2].Adr_el_suiv1=AdrSuiv) then   // le signal est-il dans le bon sens de progression?
               begin
                 // oui
                 inc(num_signal);
                 Etat:=Signaux[Index_Signal(AdrSignal)].EtatSignal;
                 code_to_aspect(Etat,aspect,combine);
                 Signal_suivant:=AdrSignal;
                 if NivDebug=3 then
                 begin
                   s:=IntToSTR(AdrSignal)+': '+IntToSTR(etat)+'=';
                   if aspect<>-1 then s:=s+EtatSign[aspect]+' ';
                   if combine<>-1 then s:=s+EtatSign[combine];
                   AfficheDebug('Sur même détecteur, trouvé signal2 suivant Adr='+s,clorange);
                 end;
               end
               else
               begin
                 if NivDebug=3 then AfficheDebug('Sur même détecteur, trouvé signal2 '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
                 AdrSignal:=0;
               end;
            end;
          end;
        end
      end
      else if nivDebug=3 then AfficheDebug('Pas de signal pour le det '+IntToSTR(AdrSuiv),clyellow);
    end;
  until (j=10) or ((AdrSignal<>0) and (num_signal=rang));
  if etat=0 then Signal_Suivant:=0;
  etat_signal_suivant:=Etat;
  AdrSignalsuivant:=Signal_suivant;
  if (NivDebug=3) and (AdrSignal=0) then AfficheDebug('Pas Trouvé de signal suivant au signal Adr='+IntToSTR(ADresse),clOrange);
end;

// renvoie l'adresse de la première aiguille déviée après le signal "adresse" et ce jusqu'au prochain signal
// sinon il n'y a pas d'aiguille ou si pas dévié, renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;
var AdrSignal,i,j,prec,AdrSuiv,Actuel,index,index2,voie : integer;
   TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  if NivDebug>=2 then AfficheDebug('Test si aiguille déviée après signal '+IntToSTR(Adresse),clOrange);
  j:=0;
  i:=Index_Signal(adresse);
  if i=0 then
  begin
    Affiche('Erreur 168: signal '+intToSTR(adresse)+' non trouvé',clred);
    Aiguille_deviee:=0;
    exit;
  end;
  prec:=Signaux[i].Adr_det1;
  TypePrec:=det;
  actuel:=Signaux[i].Adr_el_suiv1;
  TypeActuel:=Signaux[i].Btype_suiv1 ;
  AdrSignal:=0;
  AdrDevie:=0;
  if (TypeActuel=aig) then  // aiguillage
  begin
    index:=index_aig(actuel);
    if (aiguillage[index].Apointe=prec) and (aiguillage[index].position<>const_droit) then Aiguille_deviee:=actuel;
  end;

  repeat
    inc(j);
    // le 8=demande si le suivant est un aiguillage en pointe dévié oui si AdrSuiv=9997
    // dans ce cas la variable globale AdrDevie est mise à jour
    AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,8);  //

    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if (AdrSuiv<>9997) and (AdrSuiv<>0) then
    begin
      // pas trouvé aig dévié
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      // si le suivant est un détecteur comporte t-il un signal?
      AdrSignal:=0;
      if (TypeActuel=det) then  // détecteur
      begin
        i:=Index_signal_det(AdrSuiv,voie,index2); // trouve l'index de feu affecté au détecteur "AdrSuiv"
        AdrSignal:=Signaux[i].Adresse;
        if NivDebug=3 then AfficheDebug('trouvé signal '+intToSTR(AdrSignal)+' associé au détecteur '+IntToSTR(AdrSuiv),clyellow);
      end;
    end;
  until (j=10) or (AdrSuiv>=9990) or (AdrSignal<>0) or (AdrSuiv=0) ;
  if (AdrSuiv=9997) then
  begin
     s:='Le signal '+intToSTR(adresse)+' doit afficher un rappel car l''aiguillage '+intToSTR(AdrDevie);
     s:=s+' est dévié';
     if NivDebug=3 then AfficheDebug(s,clWhite);
  end;
  if ((AdrSuiv<>9997) or (j=10)) and (NivDebug=3) then
  begin
    S:='Le signal '+intToSTR(adresse)+' ne doit pas afficher de rappel car ';
    if j<>10 then s:=s+'trouvé un signal suivant ('+intToSTR(AdrSignal)+') et pas d''aiguillage dévié'
    else s:=s+' signal trop éloigné';
    AfficheDebug(s,clWhite);
  end;
  Aiguille_deviee:=AdrDevie;
end;

procedure pilote_direction(Adr,nbre : integer);
var i,j : integer;
begin
  i:=Index_Signal(Adr);
  j:=Signaux[i].decodeur;
  case j of
  // 0 : envoi_directionvirtuel(Adr,nbre);
    1 : envoi_DirectionBahn(Adr,nbre);
    2 : envoi_DirectionCDF(Adr,nbre);
   //3 : envoi_DirectionLDT(Adr,nbre);
    4 : envoi_DirectionLEB(Adr,nbre);
   end;
end;

// allume le signal directionnel d'adresse ADR en fonction de la position des aiguillages déclarés pour ce signal
procedure Signal_direction(Adr : integer);
var NAig,i,id,j,NfeuxDir,AdrAigFeu,Position : integer;
    PosAigFeu : char;
    Positionok : boolean;
begin
  id:=Index_Signal(Adr);
  NfeuxDir:=Signaux[id].aspect-10;
  i:=1;   // i=1 position éteinte du feu ; pour les autres valeurs de i : nombre de feux allumés
  repeat
    NAig:=length(Signaux[id].AigDirection[i])-1;
    if i=1 then positionok:=false else positionok:=true;
    for j:=1 to Naig do
    begin
      // vérifier la position déclarée des aiguillages pour chaque feu
      AdrAigFeu:=Signaux[id].AigDirection[i][j].Adresse;
      PosAigFeu:=Signaux[id].AigDirection[i][j].posAig;
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

// renvoie vrai si une mémoire de zone est occupée après le signal "adresse" jusqu'au
// nombre de signaux suivants défini par NSigMax=1, 2 ou 3.. (=canton)
// sort de suite si on trouve un train
// adresse=adresse du signal
function test_memoire_zones(adresse : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,i,j,it,isi,
  dernierdet,AdrSignal,NSignaux,NSigMax,voie,index2 : integer;
  TypePrec,TypeActuel : TEquipement;
  Pres_train : boolean;
  s : string;
begin
  if NivDebug>=1 then AfficheDebug('Proc test_memoire_zones('+intToSTR(adresse)+')',clyellow);
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    s:='Erreur 605 - Signal '+IntToSTR(adresse)+' non trouvé';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    test_memoire_zones:=false;
    exit;
  end;

  if debug=3 then formprinc.Caption:='Test_memoire_zones '+IntToSTR(adresse);
  NSigMax:=1; // nombre de feux à trouver (nombre de cantons)

  ife:=1;  // index feu de 1 à 4 pour explorer les 4 détecteurs d'un feu
  repeat
    NSignaux:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test signal '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      prec:=Signaux[i].Adr_det1;
      Actuel:=Signaux[i].Adr_el_suiv1;
      TypeActuel:=Signaux[i].Btype_suiv1;
    end;  //détecteur sur le signal courant
    if (ife=2) then
    begin
      prec:=Signaux[i].Adr_det2;
      Actuel:=Signaux[i].Adr_el_suiv2;
      TypeActuel:=Signaux[i].Btype_suiv2;
    end;  // détecteur sur le signal courant
    if (ife=3) then
    begin
      prec:=Signaux[i].Adr_det3;
      Actuel:=Signaux[i].Adr_el_suiv3;
      TypeActuel:=Signaux[i].Btype_suiv3;
    end;  // détecteur sur le signal courant
    if (ife=4) then
    begin
      prec:=Signaux[i].Adr_det4;
      Actuel:=Signaux[i].Adr_el_suiv4;
      TypeActuel:=Signaux[i].Btype_suiv4;
    end;  // détecteur sur le signal courant

    if (actuel=0) or (actuel>NbMaxDet) or (prec=0) or (prec>NbMaxDet) then
    begin
      // sortie si aucun détecteur déclaré sur le signal
      test_memoire_zones:=Pres_train;
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    Pres_train:=false;
    TypePrec:=det;
    dernierdet:=prec;

    // purge les aiguillages après le feu
    it:=0;
    if TypeActuel=aig then
    repeat
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      if (AdrSuiv>9900) or (AdrSuiv=0) then
      begin
        test_memoire_zones:=Pres_train;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      inc(it);
    until (typeactuel=det) or (it>100);

    if it>100 then
    begin
      Affiche('Erreur 750 : trop d''itérations',clred);
      AfficheDebug('Erreur 750 : trop d''itérations',clred);
      test_memoire_zones:=false;
    end;

    j:=0;
    repeat
      inc(j);

      if (typeactuel=det) and (dernierdet<>0) then
      begin
        Pres_train:=MemZone[dernierdet,actuel].etat or detecteur[actuel].etat or Pres_Train;
        if (nivDebug=3) then
        begin
          if Pres_Train then AfficheDebug('Présence train de '+intToSTR(dernierdet)+' à '+intToSTR(actuel),clyellow)
          else AfficheDebug('Absence train de '+intToSTR(dernierdet)+' à '+intToSTR(actuel),clyellow)
        end;
        Pres_train:=MemZone[actuel,dernierdet].etat or Pres_Train;
        if (nivDebug=3) then
        begin
          if Pres_Train then AfficheDebug('Présence train inverse de '+intToSTR(actuel)+' à '+intToSTR(dernierdet),clyellow)
          else AfficheDebug('Absence train de '+intToSTR(actuel)+' à '+intToSTR(dernierdet),clyellow)
        end;
        // sortir de suite
        if Pres_train then
        begin
          test_memoire_zones:=Pres_train;
          if debug=3 then formprinc.Caption:='';
          exit;
        end;

        dernierdet:=actuel;

        isi:=index_signal_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au détecteur "AdrSuiv": il peut y avoir 4 détecteurs par signal
        if isi<>0 then
        begin
          AdrSignal:=Signaux[isi].adresse;    // adresse du feu
          if (AdrSignal=adresse) then  // si on ne reboucle sur le même signal dont on cherche le suivant
          begin
            AdrSignal:=0;j:=10; // on ne trouve pas de suivant
            test_memoire_zones:=false;
            if debug=3 then formprinc.Caption:='';
            exit;
          end;
          if (AdrSignal<>0) then // si l'adresse est <>0
          begin
            if (Signaux[isi].Adr_el_suiv1<>prec) then   // le signal est-il dans le bon sens de progression?
            begin
              inc(NSignaux);
              j:=0;
              s:='Trouvé signal (n°'+IntToSTR(NSignaux)+'/'+intToSTR(NSigMax)+') '+IntToSTR(AdrSignal);
              if (NivDebug=3) And Pres_Train then AfficheDebug(s+' et mémoire de zone à 1',clyellow);
              if (NivDebug=3) And (not(Pres_Train)) then AfficheDebug(s+' et mémoire de zone à 0',clOrange);
              if NSignaux=NSigMax then
              begin
                test_memoire_zones:=Pres_train;
                if debug=3 then formprinc.Caption:='';
              end;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('Trouvé signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
              AdrSignal:=0;
            end;
          end;
        end;
      end;

      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      if (AdrSuiv=0) or (AdrSuiv>9990) then
      begin
        test_memoire_zones:=Pres_train;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

    until (j=10) or pres_train or (NSignaux=NSigMax);  // on arrete si on va trop loin (10 itérations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) then AfficheDebug('Pas trouvé de signal suivant au '+intToSTR(adresse),clyellow);
  if debug=3 then formprinc.Caption:='';
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
      lines.add(intToSTR(event_det[i].adresse));
      if traceListe then AfficheDebug(intToSTR(event_det[i].adresse),clyellow);
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
    trouve:=(event_det_tick[i].etat=etat) and (event_det_tick[i].Adresse=Adr) and (event_det_tick[i].modele=det);
  until (trouve or (i=0));
  if trouve then
  begin
    trouve_index_det_chrono:=i;exit;
  end;
  trouve_index_det_chrono:=0;
end;

// renvoie l'adresse du signal précédent au signal "adresse"
// remplit aussi les élements[] rencontrés
function Signal_precedent(adresse : integer) : integer;
var
  AdrSuiv,prec,ife,actuel,i,j,ifd,index,
  dernierdet,AdrSignal,Nsignaux,voie,index2 : integer;
  TypePrec,TypeActuel : TEquipement;
  malpositionne : boolean;
  s : string;
begin
  if debug=3 then formprinc.Caption:='Signal_precedent '+IntToSTR(adresse);
  if NivDebug>=1 then AfficheDebug('Proc Signal_Precedent'+intToSTR(adresse)+')',clyellow);
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    s:='Erreur 605 - Signal '+IntToSTR(adresse)+' non trouvé';
    AfficheDebug(s,clred);
    Affiche(s,clred);
    Signal_precedent:=0;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;
  idEl:=1;

  Nsignaux:=0;
  ife:=1;  // index feu de 1 à 4 pour explorer les 4 détecteurs d'un feu
  repeat
    j:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test signal voie '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      actuel:=Signaux[i].Adr_det1;
      prec:=Signaux[i].Adr_el_suiv1;
      Typeprec:=Signaux[i].Btype_suiv1;
    end;  //détecteur sur le signal courant
    if (ife=2) then
    begin
      actuel:=Signaux[i].Adr_det2;
      prec:=Signaux[i].Adr_el_suiv2;
      Typeprec:=Signaux[i].Btype_suiv2;
    end;  // détecteur sur le signal courant
    if (ife=3) then
    begin
      actuel:=Signaux[i].Adr_det3;
      prec:=Signaux[i].Adr_el_suiv3;
      Typeprec:=Signaux[i].Btype_suiv3;
    end;  // détecteur sur le signal courant
    if (ife=4) then
    begin
      actuel:=Signaux[i].Adr_det4;
      prec:=Signaux[i].Adr_el_suiv4;
      Typeprec:=Signaux[i].Btype_suiv4;
    end;  // détecteur sur le signal courant

    TypeActuel:=det;
    if actuel=0 then
    begin
      // sortie si aucun détecteur déclaré sur le feu
      Signal_precedent:=0;
      if nivDebug=3 then AfficheDebug('Pas de voie '+intToSTR(ife),clyellow);
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    dernierdet:=actuel;

    repeat
      inc(j);
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      malpositionne:=(AdrSuiv=0) or (AdrSuiv>9990);
      if malpositionne then
      begin
        if (nivDebug=3) then
        begin
          if (AdrSuiv>9990) then AfficheDebug('Erreur 41: Alg3='+intToSTR(AdrSuiv)+' Anomalie',clYellow);
          if AdrSuiv=0 then AfficheDebug('Buttoir',clyellow);
        end;
        if debug=3 then formprinc.Caption:='';
        Signal_precedent:=0;
        exit;
      end;

      if not(malpositionne) then
      begin
        prec:=actuel;TypePrec:=TypeActuel;
        actuel:=AdrSuiv;TypeActuel:=typeGen;

        if idEl<Maxelements then
        begin
          elements[idEl].adresse:=actuel;
          elements[idEl].typ:=typeActuel;
          inc(idEl);

          if (typeActuel=tjs) or (typeActuel=tjd) then
          begin
            index:=index_aig(actuel);
            if aiguillage[index].EtatTJD=4 then
            begin
              index:=index_aig(aiguillage[index].DDevie);  // index de la tjd homologue
              elements[idEl].adresse:=aiguillage[index].Adresse;
              elements[idEl].typ:=typeActuel;
              inc(idel);
            end;
          end;
        end;

        if typeactuel=det then
        begin
          dernierdet:=actuel;

          ifd:=index_signal_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au détecteur "AdrSuiv": il peut y avoir 4 détecteurs par signal
          if ifd<>0 then
          begin
            AdrSignal:=Signaux[ifd].adresse;    // adresse du feu
            if (AdrSignal=adresse) then  // si on ne reboucle sur le même signal dont on cherche le suivant
            begin
              Signal_precedent:=0;
            end;
            if (AdrSignal<>0) then // si l'adresse est <>0
            begin
              if (Signaux[ifd].Adr_el_suiv1=prec) then   // le signal est-il dans le bon sens de progression?
              begin
                inc(Nsignaux);
                s:='Trouvé signal '+IntToSTR(AdrSignal);
                Signal_precedent:=AdrSignal;
                if debug=3 then formprinc.Caption:='';
                exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Trouvé signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
                AdrSignal:=0;
              end;
            end;
          end;
        end;
      end;
    until (j=10) or malpositionne ;  // on arrete jusqu'à trouver un signal ou si on va trop loin (10 itérations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) then AfficheDebug('607. Pas trouvé de signal suivant au '+intToSTR(adresse),clyellow);
  if debug=3 then formprinc.Caption:='';
  Signal_precedent:=0;
end;

// libère le canton avant detecteur2 comportant un signal et le signal précédent
// attention le détecteur 2 n'est pas forcément associé à un signal (et dans le bon sens)
Procedure libere_canton(detecteur1,detecteur2 : integer);
var sd2,i,j: integer;
    typ : tEquipement;
begin
  // mode_reserve  0 = par canton - 1=par détecteurs
  if mode_reserve=1 then
  begin
    reserve_dereserve_det(detecteur1,detecteur2,0,0,0);
    exit;
  end;

  if not(roulage) and not(avecResa) then exit;
  //if traceliste or ProcPrinc then
  affiche('Libère_canton '+intToSTR(detecteur1)+' '+intToSTR(detecteur2),clLime);
  if ProcPrinc or traceListe then AfficheDebug('Libère_Canton '+intToSTR(detecteur1)+' '+intToSTR(detecteur2),clLime);
  // est-on en limite de canton du detecteur 2 pour le libérer?
  sd2:=signal_detecteur(detecteur2);  // trouve le signal associé au detecteur2
  if sd2=0 then
  begin
    if traceliste then affiche('le détecteur '+intToSTR(detecteur2)+' n''est pas pas associé à un signal - pas de libération du canton',clorange);
    exit;  // pas de signal associé
  end;
  // ce signal sd2 est il dans le bon sens
  i:=signal_suivant_det(detecteur1,detecteur2);  // adresse du signal dans le bon sens associé au détecteur
  //if i<>sd2 then exit;
  if i=0 then exit;

  // trouver le signal précédent
  i:=Signal_precedent(i);    // trouve les éléments entre les deux signaux

  if traceListe then AfficheDebug('Libération canton det '+IntToSTR(detecteur1)+' '+intToSTR(detecteur2)+' : ',clLime);
  for i:=1 to idEl-1 do
  begin
    j:=elements[i].adresse;
    typ:=elements[i].typ;
    if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
    begin
      if traceListe then Affichedebug_Suivi('A'+intToSTR(j)+' ',clLime);
      Aiguillage[index_aig(j)].AdrTrain:=0;  // libère l'aiguillage
    end;
  end;
  Maj_Signaux(false);
end;



// présence train précédent les n (NbCtSig) cantons du signal Adresse, dans le sens d'avance vers le signal.
// detect=true si on doit contrôler aussi sur les détecteurs
// renvoie vrai si présence train
// dans AdrTrain: renvoie 0 si pas de train
//                si on est en mode AvecRESA, renvoie l'index du train
//                                  roulage,  renvoie l'adresse du train
// dans voie : numéro de la voie du signal sur laquelle on a trouvé le train
function PresTrainPrec(Adresse,NbCtSig : integer;detect : boolean;var AdrTr,voie : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,i,j,k,ifd,d,
  dernierdet,AdrSignal,Nsignaux,voieLoc,index2 : integer;
  TypePrec,TypeActuel : TEquipement;
  Pres_train,malpositionne,etat,etatDet,EtatZone : boolean;
  s : string;
begin
  AdrTr:=0;
  if (debug=3) or ProcPrinc then formprinc.Caption:='PresTrainPrec '+IntToSTR(adresse);
  if NivDebug>=1 then
  begin
    s:='Proc PresTrainPrec('+intToSTR(adresse)+','+intToSTR(NbCtSig)+') ';
    if detect then s:=s+'avec zones de détecteurs et détecteurs'
    else s:=s+'sur zones de détecteurs uniquement';
    AfficheDebug(s,clyellow);
  end;
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    AfficheDebug('Erreur 605 - Signal '+IntToSTR(adresse)+' non trouvé',clred);
    Affiche('Erreur 605 - Signal '+IntToSTR(adresse)+' non trouvé',clred);
    PresTrainPrec:=False;
    AdrTr:=0;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;

  ife:=1;  // index voie de 1 à 4 pour explorer les 4 détecteurs d'un feu
  repeat
    if NivDebug=3 then AfficheDebug('Boucle de test signal '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      actuel:=Signaux[i].Adr_det1;
      prec:=Signaux[i].Adr_el_suiv1;
      Typeprec:=Signaux[i].Btype_suiv1;
    end;  //détecteur sur le signal courant
    if (ife=2) then
    begin
      actuel:=Signaux[i].Adr_det2;
      prec:=Signaux[i].Adr_el_suiv2;
      Typeprec:=Signaux[i].Btype_suiv2;
    end;  // détecteur sur le signal courant
    if (ife=3) then
    begin
      actuel:=Signaux[i].Adr_det3;
      prec:=Signaux[i].Adr_el_suiv3;
      Typeprec:=Signaux[i].Btype_suiv3;
    end;  // détecteur sur le signal courant
    if (ife=4) then
    begin
      actuel:=Signaux[i].Adr_det4;
      prec:=Signaux[i].Adr_el_suiv4;
      Typeprec:=Signaux[i].Btype_suiv4;
    end;  // détecteur sur le signal courant

    if actuel>NbMaxDet then
    begin
      Affiche('Erreur 179 : détecteur '+intToSTR(actuel)+' trop élevé sur signal '+intToSTR(adresse),clred);
      result:=false;
      exit;
    end;

    pres_Train:=Detecteur[actuel].etat and detect;

    if pres_train and (AdrTr=0) then
    begin
      if avecRESA then AdrTR:=Detecteur[actuel].IndexTrain;
      if roulage then AdrTr:=Detecteur[actuel].AdrTrain;
    end;
    if pres_train and (nivDebug=3) then AfficheDebug('Présence train '+intToSTR(AdrTr)+' sur dét '+intToSTR(actuel),clyellow);

    TypeActuel:=det;
    if actuel=0 then
    begin
      // sortie si aucun détecteur déclaré sur le feu
      PresTrainPrec:=Pres_train;
      voie:=ife;
      if nivDebug=3 then AfficheDebug('Pas de détecteur sur voie '+intToSTR(ife)+' au signal '+IntToSTR(adresse),clyellow);
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    // lire la mémoire de zone des détecteurs précédent le signal
    k:=1;
    repeat
      d:=Signaux[i].DetAmont[k];
      if (d>0) and (d<NbMaxDet) then
      begin
        pres_Train:=MemZone[d,actuel].etat or Pres_Train;
        if MemZone[d,actuel].etat and (adrTr=0) then
        begin
          if avecRESA then AdrTR:=MemZone[d,actuel].indexTrain;
          if roulage then AdrTr:=MemZone[d,actuel].AdrTrain;
        end;
        if (NivDebug=3) and MemZone[d,actuel].etat then AfficheDebug('Trouvé train '+intToSTR(AdrTr)+' sur mémoire de zone '+intToSTR(d)+','+intToSTR(actuel),clyellow);
      end;
      inc(k);
    until (d=0) or (k=Mtd);

    dernierdet:=actuel;
    j:=0;
    Nsignaux:=0;
    repeat
      inc(j);

      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,2);  // 2 car arrêt sur aiguille en talon mal positionnée
      malpositionne:=(AdrSuiv=0) or (AdrSuiv>9990);
      if malpositionne then
      begin
        if AdrSuiv=0 then
        begin
          EtatDet:=Detecteur[actuel].etat and detect;
          Pres_Train:=Pres_Train or etatDet;
          if Pres_Train and (adrTr=0) then
          begin
            if roulage then AdrTr:=Detecteur[actuel].AdrTrain;
            if avecResa then AdrTr:=Detecteur[actuel].indexTrain;
          end;
        end;

        if (AdrSuiv=0) and (nivdebug=3) then AfficheDebug('Buttoir',clyellow);
        if EtatDet then
        begin
          if nivDebug=3 then
          begin
            s:='Présence train ';
            if AdrTr<>0 then s:=s+'@'+IntToSTR(AdrTr)+' ';
            s:=s+'sur det '+intToSTR(actuel);
            AfficheDebug(s,clYellow);
          end;
          presTrainPrec:=Pres_train;
          voie:=ife;
          exit;
        end;
        if debug=3 then formprinc.Caption:='';
      end;

      if not(malpositionne) then
      begin
        prec:=actuel;TypePrec:=TypeActuel;
        actuel:=AdrSuiv;TypeActuel:=typeGen;

        if typeactuel=det then
        begin
          etatDet:=Detecteur[actuel].etat and detect;
          etatZone:=MemZone[actuel,dernierdet].etat;
          Pres_train:=Pres_Train or EtatZone or EtatDet;

          if Pres_Train and (AdrTr=0) then
          begin
            if roulage then AdrTr:=MemZone[actuel,dernierdet].AdrTrain; // adresse
            if AvecRESA then AdrTr:=MemZone[actuel,dernierdet].IndexTrain; // index
            if (nivDebug=3) then
            begin
              s:='Présence train ';
              if AdrTr<>0 then s:=s+'@'+IntToSTR(AdrTr)+' ';
              if etatZone then s:=s+'de '+intToSTR(actuel)+' à '+intToSTR(dernierdet);
              if etatDet  then s:=s+'sur det '+intToSTR(actuel);
              AfficheDebug(s,clYellow);
              if debug=3 then formprinc.Caption:='';
            end;
            presTrainPrec:=Pres_train;
            voie:=ife;
            exit;
          end
            else begin if nivDebug=3 then AfficheDebug('Absence train de '+intToSTR(actuel)+' à '+intToSTR(dernierdet),clyellow);end;

          dernierdet:=actuel;

          ifd:=index_signal_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au détecteur "AdrSuiv": il peut y avoir 4 détecteurs par signal
          if ifd<>0 then
          begin
            AdrSignal:=Signaux[ifd].adresse;    // adresse du signal
            if (AdrSignal=adresse) then  // si on ne reboucle sur le même signal dont on cherche le suivant
            begin
              AdrSignal:=0; // on ne trouve pas de suivant
              PresTrainPrec:=false;
              AdrTr:=0;
              if debug=3 then formprinc.Caption:='';
              voie:=ife;
              exit;
            end;
            if (AdrSignal<>0) then // si l'adresse est <>0
            begin
              if (Signaux[ifd].Adr_el_suiv1=prec) then   // le signal est-il dans le bon sens de progression?
              begin
                inc(Nsignaux);
                j:=0;
                s:='Trouvé signal '+intToStr(AdrSignal)+' ('+IntToSTR(Nsignaux)+'/'+intToSTR(NbCtSig)+') '+IntToSTR(AdrSignal);
                if (NivDebug=3) And Pres_Train then AfficheDebug(s+' et mémoire de zone à 1',clOrange);
                if (NivDebug=3) And (not(Pres_Train)) then AfficheDebug(s+' et mémoire de zone à 0',clOrange);
                if nSignaux=NbCtSig then // si atteint les 3 signaux (3 cantons)
                begin
                  presTrainPrec:=pres_train;
                  if debug=3 then formprinc.Caption:='';
                  voie:=ife;  // changer la voie
                  exit;
                end;
                // explorer les présence trains sur les voies en convergence du signal
                // lire la mémoire de zone des détecteurs n-2 précédent le signal
                k:=1;
                repeat
                  d:=Signaux[ifd].DetAmont[k];
                  if d<>0 then
                  begin
                    pres_Train:=MemZone[d,actuel].etat or Pres_Train;
                    if Pres_Train and (adrtr=0) then
                    begin
                      if roulage then AdrTr:=MemZone[d,actuel].AdrTrain; // adresse
                      if avecRESA then AdrTr:=MemZone[d,actuel].IndexTrain; // index
                      if (NivDebug=3) then AfficheDebug('Trouvé train '+intToSTR(AdrTr)+' sur mémoire de zone '+intToSTR(d)+','+intToSTR(actuel),clyellow);
                    end;
                  end;
                  inc(k);
                until (d=0) or (k=Mtd);
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Trouvé signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
                AdrSignal:=0;
              end;
            end;
          end;
        end;
      end;
    until (j=10) or Pres_train or malpositionne or (Nsignaux>=NbCtSig);  // on arrete jusqu'à trouver un train ou un signal ou si on va trop loin (10 itérations)
    inc(ife);
  until (ife>=5) or Pres_train;
  if (NivDebug>0) then AfficheDebug('606. Pas trouvé de signal suivant au '+intToSTR(adresse),clyellow);
  if debug=3 then formprinc.Caption:='';
  voie:=ife-1;
  PresTrainPrec:=Pres_Train;
end;

// renvoie vrai si le signal est au carré, sémaphore, sémaphore cli, violet
function signal_rouge(adresse : word) : boolean;
var etat,i : integer;
begin
  i:=index_signal(adresse);
  etat:=Signaux[i].EtatSignal;
  if Signaux[i].aspect=20 then result:=testbit(etat,rouge)
  else result:=testbit(etat,semaphore) or testbit(etat,carre) or testbit(etat,violet);
end;


// met à jour l'état du signel belge selon l'environnement des aiguillages et des trains
procedure signal_belge(AdrSignal : integer;detect : boolean);
var adrAig,adr_det,adr_el_suiv,AdrTrainLoc,voie,indexAig,etat,AdrSignalsuivant,AdrTrainRes : integer;
    Btype_el_suivant : TEquipement;
    car,presTrain,reserveTrainTiers,Aff_Semaphore : boolean;
    s: string;
begin
  if affsignal=false then
  begin
    if signalDebug=AdrSignal then AffSignal:=true
    else affsignal:=false;
  end;
  if AffSignal then
  begin
    s:='Traitement du signal '+intToSTR(AdrSignal)+'------------------------------------';
    AfficheDebug(s,clOrange);
    //nivDebug:=3;
  end;

  if affSignal then AfficheDebug('Signal belge',clOrange);

  index:=Index_Signal(AdrSignal);
  Adr_det:=Signaux[index].Adr_det1;  // détecteur sur le signal
  Adr_El_Suiv:=Signaux[index].Adr_el_suiv1; // adresse élément suivant au signal
  Btype_el_suivant:=Signaux[index].Btype_suiv1;
  PresTrain:=false;

  // détecteurs précédent le signal , pour déterminer si leurs mémoires de zones sont à 1 pour libérer le carré
  //if (Signaux[index].VerrouCarre) and (modele>=4) then

  presTrain:=PresTrainPrec(AdrSignal,Nb_cantons_Sig,false,AdrTrainLoc,voie); //etape A   // présence train par adresse train ; renvoie l'adresse du train dans AdrTrainLoc
  if AffSignal and roulage then AfficheDebug('L''@ du train avant le signal est '+intToSTR(AdrTrainLoc),clYellow);

  // si le signal peut afficher un carré et les aiguillages après le signal sont mal positionnées ou aig réservé ou que pas présence train avant signal et signal
  // verrouillable au carré, afficher un carré

  car:=carre_signal(AdrSignal,AdrTrainLoc,reserveTrainTiers,AdrTrainRes)<>0;  // si reserveTrainTiers, réservé par un autre train
  if AffSignal and reserveTrainTiers then AfficheDebug('Trouvé aiguillage réservé par autre train (@'+intToSTR(AdrTrainRes)+')',clYellow);
  if AffSignal and car then AfficheDebug('Le signal a des aiguilles en talon aval mal positionnées',clYellow);
  // En mode roulage, si la réservation est faite par le train détecté en étape A, ne pas verrouiller au carré
  if roulage then car:=reserveTrainTiers or car;

  // conditions supplémentaires de carré en fonction des aiguillages décrits
  car:=cond_carre(AdrSignal) or car;
  if AffSignal and Signaux[index].VerrouCarre then AfficheDebug('le signal est verrouillé au carré',clYellow);

  if (Signaux[index].VerrouCarre and not(presTrain)) or car
       then Maj_Etat_Signal_belge(AdrSignal,semaphore)
  else
  begin
    // si on quitte le détecteur on affiche un sémaphore :  tester le sens de circulation
    // pour ne pas passer au rouge un signal à contresens.
    // trouver la mémoire de zone MemZone[Adr_det,?] qui a déclenché le feu rouge
    if AffSignal then AfficheDebug('Test du sémaphore',clYellow);
    Aff_semaphore:=test_memoire_zones(AdrSignal);  // test si présence train après signal
    if Aff_Semaphore then
    begin
      if AffSignal then AfficheDebug('Présence train après signal'+intToSTR(AdrSignal)+' -> sémaphore ou carré',clYellow);
      if Signaux[index].checkFR then Maj_Etat_Signal_belge(AdrSignal,semaphore_cli)
        else Maj_Etat_Signal_belge(AdrSignal,semaphore);
    end
    else
    begin
      // si aiguillage au pied du signal avec chevron
      if Signaux[index].Btype_suiv1=aig then
      begin
        adrAig:=Signaux[index].Adr_el_suiv1;
        IndexAig:=index_aig(adrAig);
        //rouge
        if aiguillage[IndexAig].position=const_devie then
        begin
          if Signaux[index].verscontrevoie then Maj_Etat_Signal_belge(AdrSignal,chevron_F or bita1_F) else Maj_Etat_Signal_belge(AdrSignal,chevron_F);
          if aiguillage[indexAig].vitesse<>0 then Maj_Etat_Signal_belge(AdrSignal,chiffre_F or bita1_F) // allumer le chiffre
            else
              Maj_Etat_Signal_belge(AdrSignal,chiffre_F);  // effacer le chiffre
        end
        else begin Maj_Etat_Signal_belge(AdrSignal,chiffre_F); Maj_Etat_Signal_belge(AdrSignal,chevron_F);end;
      end;
      // rouge
      etat:=etat_signal_suivant(AdrSignal,1,AdrSignalsuivant) ;  // état du signal suivant + adresse du signal suivant dans Signal_Suivant
      if adrSignalSuivant=0 then Maj_Etat_Signal_belge(AdrSignal,semaphore)
      else
      begin

        if TestBit(etat,semaphore) or TestBit(etat,carre) or TestBit(etat,rouge_blanc) then Maj_Etat_Signal_belge(AdrSignal,deux_jaunes)
        else
        begin
          if testBit(etat,chiffre) then
          begin
            Maj_Etat_Signal_belge(AdrSignal,vert_jaune_H)
          end
          else
          // aiguille signal suivant  droite
          begin
            if AffSignal then AfficheDebug('Pas d''aiguille déviée',clYellow);
            // feu vert, vert cli ou blanc
            //if affsignal then AfficheDebug('test 405',clyellow);
            if Signaux[index].checkFB<>nil then
            begin
              //if affsignal then AfficheDebug('test 406',clyellow);
              if Signaux[index].checkFB.Checked then
                Maj_Etat_Signal_belge(AdrSignal,rouge_blanc)
                  else Maj_Etat_Signal_belge(AdrSignal,vertB);
            end
            else
            begin
              Maj_Etat_Signal_belge(AdrSignal,vertB);
              //if affsignal then AfficheDebug('Mise du signal au vert',clyellow);
            end;
          end;
        end;
      end;
    end;
  end;
  envoi_signal(AdrSignal);

  // si le signal n'est pas rouge, réserver les aiguillages en aval
  {
  if (roulage or AvecResa) and (AdrTrainLoc<>0) then
  begin
    etat:=Signaux[index].EtatSignal;
    if not(signal_rouge(AdrSignal)) then
    begin
      adr_Det:=Signaux[index].Adr_det1;
      if detecteur[adr_det].Etat then
      begin
        if Signaux[index].Btype_suiv1<>det then detSuiv:=detecteur_suivant(Signaux[index].Adr_det1,det,Signaux[index].Adr_el_suiv1,Signaux[index].Btype_suiv1,1)
                      else detSuiv:=Signaux[index].Adr_el_suiv1;
        if detSuiv<9990 then
        begin
          if roulage then reserve_canton(Signaux[index].Adr_det1,detSuiv,AdrtrainLoc,0,nCantonsRes) else
            if AvecResa then reserve_canton(Signaux[index].Adr_det1,detSuiv,0,AdrtrainLoc,nCantonsRes) ;
        end;
      end;
    end;
  end;  }

  if signalDebug=AdrSignal then begin AffSignal:=false;nivDebug:=0;end;
  if debug=3 then formprinc.Caption:='';
end;


// mise à jour de l'état d'un signal en fonction de son environnement et affiche le signal
// AdrSignal: adresse du signal
// detect: si true, tient compte de la présence des trains par détecteurs dans la fonction signalPrec
procedure Maj_Signal(AdrSignal : integer;detect : boolean);
var Adr_det,etat,Aig,Adr_El_Suiv,modele,index,IndexAig,AdrTrainLoc,voie,code,combine,AdrSignalsuivant,AdrTrainRes : integer ;
    PresTrain,Aff_semaphore,car,reserveTrainTiers : boolean;
    Btype_el_suivant : TEquipement;
    s : string;
begin
  if affsignal=false then
  begin
    if signalDebug=AdrSignal then
    AffSignal:=true
    else affsignal:=false;
  end;
  if AffSignal or ProcPrinc then
  begin
    s:='Traitement du signal '+intToSTR(AdrSignal)+'------------------------------------';
    AfficheDebug(s,clOrange);
    //if AffSignal then nivDebug:=3;
  end;

  index:=Index_Signal(AdrSignal);
  if (Nivdebug>=1) then AfficheDebug('Proc Maj_Signal '+IntToSTR(AdrSignal)+'-------------',clorange);

  if (AdrSignal=0) or (index=0) then exit;

  modele:=Signaux[index].aspect;

  if modele=20 then
  begin
    signal_belge(AdrSignal,detect);
    exit;
  end;

  // ici signal français

  Adr_det:=Signaux[index].Adr_det1;  // détecteur sur le signal
  Adr_El_Suiv:=Signaux[index].Adr_el_suiv1; // adresse élément suivant au signal
  Btype_el_suivant:=Signaux[index].Btype_suiv1;

  // signal directionnel ?
  if (modele>10) and (modele<20) then
  begin
   //Affiche('Signal directionnel '+IntToSTR(AdrSignal),clyellow);
    Signal_direction(AdrSignal);
    if debug=3 then formprinc.Caption:='';
    exit;
  end;
    // signal non directionnel
  etat:=etat_signal_suivant(AdrSignal,1,AdrSignalsuivant) ;  // état du signal suivant + adresse du signal suivant dans Signal_Suivant
  if AffSignal then
  begin
    code_to_aspect(etat,code,combine);
    s:='Etat_signal_suivant ('+intToSTR(AdrSignalsuivant)+') est ';
    s:=s+' à ';
    if code<>-1 then s:=s+etatSign[code];
    if (Combine<>0) and (combine<>-1) then s:=s+' + '+etatSign[combine];
    AfficheDebug(s,clyellow);
  end;
    // signal à 2 feux = carré violet+blanc
  if (modele=2) then //or (Signaux[i].check<>nil) then // si carré violet
  begin
    // si aiguillage après signal mal positionnées ou réservé ou pas de train avant le signal
    PresTrain:=PresTrainPrec(AdrSignal,Nb_cantons_Sig,detect,AdrTrainLoc,voie);
    if (carre_signal(AdrSignal,AdrTrainLoc,reserveTrainTiers,AdrTrainRes)<>0) or not(PresTrain) or (Signaux[index].VerrouCarre) then
    begin
      Maj_Etat_Signal(AdrSignal,violet);
      if debug=3 then formprinc.Caption:='';
    end
    else
    begin
      if not(cond_FeuBlanc(AdrSignal)) and test_memoire_zones(AdrSignal) then Maj_Etat_Signal(AdrSignal,violet)  // test si présence train après signal
       else Maj_Etat_Signal(AdrSignal,blanc);
          // faire la réservation des aiguillages
      if debug=3 then formprinc.Caption:='';
    end;
  end;
    //if AffSignal then AfficheDebug('Debut du traitement général',clYellow);
  // traitement des feux >3 feux différents de violet (cas général)
  if (modele>=3) and (Signaux[index].EtatSignal<>violet_F) then
  begin
    PresTrain:=false;
    // détecteurs précédent le signal , pour déterminer si leurs mémoires de zones sont à 1 pour libérer le carré
    //if (Signaux[index].VerrouCarre) and (modele>=4) then
    presTrain:=PresTrainPrec(AdrSignal,Nb_cantons_Sig,detect,AdrTrainLoc,voie); //etape A   // présence train par adresse train ; renvoie l'adresse du train dans AdrTrainLoc
    if AffSignal and roulage then AfficheDebug('L''@ du train avant le signal est '+intToSTR(AdrTrainLoc),clYellow);
      // si le signal peut afficher un carré et les aiguillages après le signal sont mal positionnées ou aig réservé ou que pas présence train avant signal et signal
    // verrouillable au carré, afficher un carré
    car:=carre_signal(AdrSignal,AdrTrainLoc,reserveTrainTiers,AdrTrainRes)<>0;  // si reserveTrainTiers, réservé par un autre train
    if AffSignal and reserveTrainTiers then AfficheDebug('trouvé aiguillage réservé par autre train',clYellow);
    if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionnées',clYellow);
    // En mode roulage, si la réservation est faite par le train détecté en étape A, ne pas verrouiller au carré
    if avecRESA or roulage then car:=(reserveTrainTiers and Signaux[index].VerrouCarre) or car;  // tenir compte de la réservation si on est en mode avec réservation des aiguillages
      // conditions supplémentaires de carré en fonction des aiguillages décrits
    car:=cond_carre(AdrSignal) or car;
    //if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionnées',clYellow);
    if AffSignal and Signaux[index].VerrouCarre then AfficheDebug('le signal est verrouillé au carré',clYellow);

    if (modele>=4) and  ((not(PresTrain) and Signaux[index].Verroucarre) or car ) then Maj_Etat_Signal(AdrSignal,carre)
    else
    begin
      // si on quitte le détecteur on affiche un sémaphore :  tester le sens de circulation
      // pour ne pas passer au rouge un signal à contresens.
      // trouver la mémoire de zone MemZone[Adr_det,?] qui a déclenché le feu rouge
      if AffSignal then AfficheDebug('test du sémaphore',clYellow);
      Aff_semaphore:=test_memoire_zones(AdrSignal);  // test si présence train après signal
      if Aff_Semaphore then
      begin
        if AffSignal then AfficheDebug('Présence train après signal'+intToSTR(AdrSignal)+' -> sémaphore ou carré',clYellow);
        if testBit(Signaux[index].EtatSignal,carre)=FALSE then
        begin
          if Signaux[index].checkFR then Maj_Etat_Signal(AdrSignal,semaphore_cli)
          else Maj_Etat_Signal(AdrSignal,semaphore);
        end;
      end
      else
      begin
        if cond_feuBlanc(AdrSignal) then Maj_Etat_Signal(AdrSignal,blanc)
        else
        begin
          Aig:=Aiguille_deviee(AdrSignal);
          // si aiguille locale déviée
          if (aig<>0) and (Signaux[index].aspect>=9) then // si le signal peut afficher un rappel et aiguille déviée
          begin
            indexAig:=Index_aig(aig);
            if AffSignal then AfficheDebug('Aiguillage '+intToSTR(aig)+' du signal '+intToSTR(AdrSignal)+' déviée',clYellow);
            Signaux[index].EtatSignal:=0;
            if (aiguillage[indexAig].vitesse<=30) then Maj_Etat_Signal(AdrSignal,rappel_30) else
              if ((aiguillage[indexAig].vitesse>30) and (aiguillage[indexAig].vitesse<=60)) then Maj_Etat_Signal(AdrSignal,rappel_60)
                else
                begin
                  Maj_Etat_Signal(AdrSignal,rappel_30);
                  s:='Aiguillage '+intToSTR(aig)+'dévié mais vitesse de franchissement mal définie pour le signal '+intToSTR(AdrSignal)+' ';
                  Affiche(s,clred);
                  if AffSignal then AfficheDebug(s,clred);
                end;
            // si signal suivant affiche rappel ou rouge (etat=signal suivant)
            if TestBit(etat,rappel_60) or testBit(etat,rappel_30) or signal_rouge(AdrSignalSuivant)
              then Maj_Etat_Signal(AdrSignal,jaune)
            else
            begin
              // sinon si signal suivant=jaune
              if (TestBit(etat,jaune)) then
              begin
                Maj_Etat_Signal(AdrSignal,jaune_cli);
                //if AffSignal then AfficheDebug('400.Mise du signal au jaune cli',clyellow);
              end
              else
              //sinon si signal suivant=ral30 ou 60
              if TestBit(etat,ral_30) or TestBit(etat,ral_60) then
              begin
                Maj_Etat_Signal(AdrSignal,jaune_cli);
              end
            end;
          end
          else
          // aiguille locale non déviée ou aspect signal<9
          begin
            if AffSignal then AfficheDebug('pas d''aiguille déviée',clYellow);
            // effacer la signalisation combinée
            Signaux[index].EtatSignal:=Signaux[index].EtatSignal and not($3c00);

            // si signal suivant rouge
            if signal_rouge(AdrSignalSuivant) then
            begin
              Maj_Etat_Signal(AdrSignal,jaune);
              //if AffSignal then AfficheDebug('Mise du signal à l''avertissement',clyellow);
            end
            else
            begin
              if affsignal then AfficheDebug('Evaluation signal '+intToSTR(ADrSIgnal)+' test 403',clyellow);
              // si signal suivant affiche rappel
              if TestBit(etat,rappel_30) or TestBit(etat,rappel_60) then
              begin
                Signaux[index].EtatSignal:=0;
                if TestBit(etat,rappel_30) then
                begin
                  Maj_Etat_Signal(AdrSignal,ral_30);
                  //if affsignal then AfficheDebug('Mise du feu au ralen 30',clyellow);
                end;
                if TestBit(etat,rappel_60) then
                begin
                  //if AffSignal then AfficheDebug('Mise du Feu au ralen 60',clyellow);
                  Maj_Etat_Signal(AdrSignal,ral_60);  // si signal suivant est au rappel60, il faut tester s'il est à l'avertissement aussi
                  if TestBit(etat,jaune) then Maj_Etat_Signal(AdrSignal,jaune_cli);

                  if TestBit(etat,jaune) then
                  begin
                    Maj_Etat_Signal(AdrSignal,jaune_cli);
                    //if affsignal then AfficheDebug('401.Mise du feu au jaune cli',clyellow);
                  end;
                end;
              end
              else
              begin
                // si le signal suivant est jaune
                //if affsignal then AfficheDebug('test 404',clyellow);
                if TestBit(etat,jaune) or TestBit(etat,ral_30) or TestBit(etat,ral_60) then
                begin
                  Maj_Etat_Signal(AdrSignal,jaune_cli);
                  //if affsignal then AfficheDebug('401.Mise du feu au jaune cli',clyellow);
                end
                else
                begin
                  // feu vert, vert cli ou blanc
                  //if affsignal then AfficheDebug('test 405',clyellow);
                  if Signaux[index].checkFB<>nil then
                  begin
                    //if affsignal then AfficheDebug('test 406',clyellow);
                    if Signaux[index].checkFB.Checked then
                    begin
                      Maj_Etat_Signal(AdrSignal,blanc);
                      //if affsignal then AfficheDebug('Mise du feu au blanc',clyellow);
                    end
                    else Maj_Etat_Signal(AdrSignal,vert);
                  end
                  else
                  begin
                    if Signaux[index].checkFV then Maj_Etat_Signal(AdrSignal,vert_cli)
                    else Maj_Etat_Signal(AdrSignal,vert);
                    //if affsignal then AfficheDebug('Mise du feu au vert',clyellow);
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  envoi_signal(AdrSignal);

  // si le signal n'est pas rouge avec un train sur le détecteur du signal, réserver les aiguillages en aval
  {
  if (roulage or AvecResa) and (AdrTrainLoc<>0) then
  begin
    etat:=Signaux[index].EtatSignal;
    if not(signal_rouge(AdrSignal)) then
    begin
      adr_Det:=Signaux[index].Adr_det1;
      if detecteur[adr_det].Etat then    // détecteur doit être activé par loco
      begin
        // trouver si le signal est dans le bon sens
        //id:=detecteur[adr_det].IndexTrain;
        //det1:=event_det_train[id].Det[2].adresse;
        //det2:=event_det_train[id].suivant;
        //det3:=suivant_alg3(det1,

        // trouver le détecteur suivant
        if Signaux[index].Btype_suiv1<>det then detSuiv:=detecteur_suivant(Signaux[index].Adr_det1,det,Signaux[index].Adr_el_suiv1,Signaux[index].Btype_suiv1,1)
                    else detSuiv:=Signaux[index].Adr_el_suiv1;
        if detSuiv<9990 then
        begin
          if roulage then reserve_canton(Signaux[index].Adr_det1,detSuiv,AdrtrainLoc,0,nCantonsRes) else
            if AvecResa then reserve_canton(Signaux[index].Adr_det1,detSuiv,0,AdrtrainLoc,nCantonsRes) ;
        end;
      end;
    end;
  end; }

  if signalDebug=AdrSignal then begin AffSignal:=false;nivDebug:=0;end;
  if debug=3 then formprinc.Caption:='';
end;

// mise à jour du signal et de son précédent
procedure maj_Signal_P(adrSignal : integer;detect : boolean);
var adrPrec,etat : integer;
begin
  Maj_signal(Adrsignal,detect);
  // si le signal est rouge ou rappel, mettre à jour son précédent
  etat:=Signaux[index_signal(AdrSignal)].EtatSignal;
  if (signal_rouge(AdrSignal)) or testbit(etat,rappel_60) or testbit(etat,rappel_30) then
  begin
    adrPrec:=Signal_precedent(AdrSignal);
    if adrPrec<>0 then
    begin
      //Affiche('signal='+intToSTR(AdrSignal)+' précédent='+intToSTR(adrPrec),clyellow);
      Maj_signal(adrPrec,detect);
    end;
  end;
end;

// mise à jour des signaux
// detect: si true, tient compte de la présence des trains sur les détecteurs dans la fonction signalPrec
Procedure Maj_Signaux(detect : boolean);
var i : integer;
begin
  if (nivDebug=1) or ProcPrinc then AfficheDebug('Proc Maj_signaux',clorange);
  if not(Maj_signaux_cours) then
  begin
    Maj_signaux_cours:=TRUE;
    for i:=1 to NbreSignaux do
    begin
      Maj_Signal_P(Signaux[i].Adresse,detect);
    end;
    Maj_signaux_cours:=FALSE;
  end;
end;


// trouve si le détecteur adr est contigu à un buttoir
function buttoir_adjacent(adr : integer) : boolean;
begin
  trouve_element(adr,det); // branche_trouve  IndexBranche_trouve
  if Branche_trouve=0 then begin buttoir_adjacent:=false;exit;end;
  buttoir_adjacent:=( (BrancheN[branche_trouve,IndexBranche_trouve+1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve+1].BType=buttoir) or
                      (BrancheN[branche_trouve,IndexBranche_trouve-1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve-1].BType=buttoir) )
end;


// renvoie vrai si le signal adresse est dans le sens det1 det2
function signal_sens(adrSig,det1,det2 : integer) : boolean;
var i,it,suiv,succ,actuel : integer;
    typeAct,typSuiv : tEquipement;
begin
  if debug=3 then formprinc.Caption:='Signal_sens '+IntToSTR(AdrSig);
  it:=0;
  i:=Index_Signal(adrsig);
  if i=0 then
  begin
    result:=false;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;
  actuel:=det1;
  typeAct:=det;
  suiv:=Signaux[i].Adr_el_suiv1;
  typSuiv:=Signaux[i].Btype_suiv1;
  if suiv=det2 then
  begin
    signal_sens:=true;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;
  repeat
    // parcourir les éléments jusque detecteur2
    // oui, est-il dans le bon sens?
    succ:=suivant_alg3(actuel,typeAct,suiv,typSuiv,1);
    if (succ>9990) then
    begin
      Affiche('Erreur 154',clred);
    end;
    actuel:=suiv;typeact:=typSuiv;
    suiv:=succ;typSuiv:=typeGen;

    inc(it);
  until (succ=det2) or (succ=0) or (it>Max_Signal_Sens);
  if debug=3 then formprinc.Caption:='';
  signal_sens:=succ=det2;
end;

// réserve le nombre de cantons "nCantons" du detecteur1 (non compris) équipé du signal ou le prochain suivant si le signal n'est pas au rouge
// la réservation consiste à marquer un aiguillage avec l'adresse du train "adrTrain" ou "NumTrain"
// det1 et det2 sont contigus
// adrTrain = adresse du train (mode roulage uniquement)
// NumTrain = index du train (pas mode roulage, avec CDM)
procedure reserve_canton(detecteur1,detecteur2,adrtrain,NumTrain,NCantons : integer);
var nc,AdrSig,i,j,etat,etatSuiv,AdrSignalsuivant : integer;
    rouge,cas2 : boolean;
    typ : tEquipement;
    s : string;
begin
  if not(roulage) and not(avecResa) then exit;

  begin
    s:='Réservation '+intToSTR(nCantons)+' cantons après détecteur '+intToSTR(detecteur1)+' '+intToSTR(detecteur2)+' pour train ';
    if roulage then s:=s+'@'+intToSTR(adrtrain)
    else if avecResa then s:=s+intToSTR(NumTrain);
    if traceliste or ProcPrinc then afficheDebug(s,clorange);
    Affiche(s,ClOrange);
  end;

  if (detecteur1>NbMaxDet) or (detecteur2>NbMaxDet) then
  begin
    Affiche('Erreur 63 : reserve_canton '+intToSTR(detecteur1)+' '+intToSTr(detecteur2),clred);
    exit;
  end;

  idEl:=0;
  // y a t-il un signal sur le détecteur1
  cas2:=false;

  AdrSig:=signal_detecteur(detecteur1);  // trouve le signal associé au detecteur1
  if adrSig<>0 then
  begin
    // si le signal est dans le bon sens
    if signal_sens(AdrSig,detecteur1,detecteur2) then
    begin
      cas2:=true;  // oui
      if TraceListe then AfficheDebug('Trouvé signal '+intToSTR(adrSig)+' dans bon sens',clYellow);
    end
    else if TraceListe then AfficheDebug('Trouvé signal '+intToSTR(adrSig)+' dans mauvais sens',clYellow);
  end;

  if not(cas2) then AdrSig:=signal_suivant_det(detecteur1,detecteur2);   // signal suivant dans le bon sens

  if traceListe then afficheDebug('Le signal est '+intToSTR(AdrSig)+' ',clyellow);

  // pas de signal !!
  if adrSig=0 then
  begin
    //Affiche('Absence de signal après '+intToSTR(detecteur2)+', réservation pour train @'+intToStr(AdrTrain)+' '+intToSTR(detecteur1)+' '+intToSTR(detecteur2)+' impossible',clred);
    i:=indexbrut_train_adresse(AdrTrain); // numéro de train
    if i<>0 then reserve_dereserve_det(detecteur1,detecteur2,adrTrain,i,1);
    exit;
  end;

  etat:=Signaux[Index_Signal(AdrSig)].etatSignal;
  rouge:=signal_rouge(AdrSig);
  if rouge then
  begin
    if TraceListe then AfficheDebug('Le signal '+intToSTR(AdrSig)+' étant rouge, pas de réservation aval ',clYellow);
    exit;
  end;

  etatSuiv:=etat_signal_suivant(AdrSig,1,AdrSignalsuivant);  //réserve le canton du signal AdrSig au suivant : AdresseSignalSuivant
  // dans le bon sens
  // 1er canton
  // marquer les aiguillages réservés
  if traceliste then AfficheDebug('A. Elements réservés: ',clOrange);
  for i:=1 to idEl-1 do
  begin
    j:=elements[i].adresse;
    typ:=elements[i].typ;
    if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
    begin
      if TraceListe then AfficheDebug_Suivi(intToSTR(j)+' ',clOrange);
      // vérifier si l'aiguillage est libre
      if AvecResa then
      begin
        if (Aiguillage[index_aig(j)].AdrTrain=0) then Aiguillage[index_aig(j)].AdrTrain:=numtrain;
      end;
      if roulage then
      begin
        if (Aiguillage[index_aig(j)].AdrTrain)=0 then Aiguillage[index_aig(j)].AdrTrain:=AdrTrain;
      end;

      // maj tco
      Texte_aig_fond(j) ;
    end;
  end;

  // --------canton suivant
  rouge:=signal_rouge(AdrSignalSuivant);
  if rouge then
  begin
    if TraceListe then
    begin
      s:='Le signal sursuivant '+intToSTR(AdrSignalSuivant)+' étant rouge, pas de réservation aval pour le train @';
      if roulage then s:=s+'@'+intToSTR(adrtrain) else if avecResa then s:=s+intToSTR(NumTrain);
      AfficheDebug(s,clyellow);
    end;
    exit;
  end;

  nc:=2;
  // réservation canton suivant sauf si signal est rouge
  repeat
    if Traceliste then AfficheDebug('Canton '+intToSTR(nc),clOrange);

    AdrSig:=AdrSignalSuivant;
    etatsuiv:=etat_signal_suivant(AdrSig,1,AdrSignalsuivant);  //réserve le canton du signal AdrSig au suivant : AdresseSignalSuivant
    if traceListe then afficheDebug('Le signal sursuivant est '+intToSTR(AdrSig),clyellow);
    rouge:=signal_rouge(AdrSignalSuivant);
    if rouge then
    begin
      if TraceListe then
      begin
        s:='Le signal sursuivant '+intToSTR(AdrSignalSuivant)+' étant rouge, pas de réservation aval pour le train @';
        if roulage then s:=s+'@'+intToSTR(adrtrain) else if avecResa then s:=s+intToSTR(NumTrain);
        AfficheDebug(s,clyellow);
      end;
      exit;
    end;

    etat:=etat_signal_suivant(AdrSig,1,AdrSignalsuivant);  //réserve le canton du signal
    // marquer les aiguillages réservés
    if traceliste then AfficheDebug('B. Elements réservés: ',clOrange);
    for i:=1 to idEl-1 do
    begin
      j:=elements[i].adresse;
      typ:=elements[i].typ;
      if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
      begin
        if TraceListe then AfficheDebug_Suivi(intToSTR(j)+' ',clOrange);
        if AvecResa then
        begin
          if (Aiguillage[index_aig(j)].AdrTrain=0) then Aiguillage[index_aig(j)].AdrTrain:=numtrain;
        end;
        if roulage then
        begin
          if (Aiguillage[index_aig(j)].AdrTrain)=0 then Aiguillage[index_aig(j)].AdrTrain:=AdrTrain;
        end;
        Texte_aig_fond(j);
      end;
    end;

    inc(nc);
  until (nc>Ncantons);

  Maj_Signaux(false);  // sans_maj
end;

// pilote le train sur le détecteur det2, d'adresse adrtrain
// le det1 indique d'ou vient le train pour le bon sens du signal
// le train est piloté si on trouve un signal dans le bon sens sur det2
// it : numéro du train du réseau (pour la couleur)
procedure pilote_train(det1,det2,AdrTrain,it : integer);
var entree_signal,jauneC,rappel30C,rappel60C,rouge : boolean;
    i,index_train,adresse,adresse2,Etat,voie,i2,vitesse : integer;
    couleur : TColor;
    s : string;
begin
  if not(roulage) or (adrtrain=0) then exit;
  Affiche('Pilote train '+intToSTR(det1)+' '+intToSTR(det2),clYellow);
  i:=index_signal_det(det2,voie,i2); // index du signal associé au det2  j:=signal_detecteur(det3);
  if i=0 then exit;

  i2:=((it-1) mod NbCouleurTrain) +1;
  couleur:=CouleurTrain[i2];
  index_train:=index_train_adresse(adrTrain);  // index du tableau trains

  adresse:=Signaux[i].adresse;    // voir si il est dans le bon sens

  adresse2:=signal_suivant_det(det1,det2); // renvoie le signal suivant dans le sens det1 det2
  if adresse<>adresse2 then exit; // non pas dans le bon sens

  etat:=Signaux[i].EtatSignal;

  rouge:=signal_rouge(Signaux[i].adresse);
  jauneC:=testbit(etat,jaune) or testbit(etat,blanc) or testbit(etat,blanc_cli);
  rappel30C:=testbit(etat,rappel_30);
  rappel60C:=testbit(etat,rappel_60);

  entree_signal:=detecteur[det2].etat;

  // si le signal est au rouge et qu'on entre dans son détecteur
  if rouge and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' au rouge - Arrêt train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,couleur);
    Affiche(s,couleur);
    event_det_train[it].signal_rouge:=adresse;
    if (index_train<>0) and (index_train<Max_Trains) then trains[index_train].TempoArret:=50;
    exit;
  end;

  event_det_train[it].signal_rouge:=0;

  if (jauneC or Rappel30C) and entree_signal then
  begin
    begin
      if jauneC then
      begin
        s:='Signal '+intToSTR(adresse)+' à l''avertissement - Ralentissement train @'+intToSTR(AdrTrain);
        if traceListe then AfficheDebug(s,clLime);
        Affiche(s,ClLime);
      end;
      if Rappel30C and not(jauneC) then
      begin
        s:='Signal '+intToSTR(adresse)+' au rappel30 - Ralentissement train @'+intToSTR(AdrTrain);
        Affiche(s,clLime);
        if traceliste then affichedebug(s,Cllime);
      end;
    end;
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitRalenti;
      if placement[index_train].inverse then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,true);
    end;
  end;

  if (Rappel60C) and not(jauneC) and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' au rappel60 - Ralentissement train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,clLime);
    Affiche(s,clLime);
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitRalenti;
      if placement[index_train].inverse then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,true);
    end;
  end;

  if (testbit(etat,vert) or testbit(etat,vert_cli)) and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' Voie libre - Vitesse nominale train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,clLime);
    Affiche(s,ClLime);
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitNominale;
      if placement[index_train].inverse then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,true);
    end;

    begin
      vitesse:=trains[index_train].VitNominale;
      if (placement[index_train].inverse) then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,true);
    end;

  end;

  if testbit(etat,jaune_Cli) and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' Jaune cli - Vitesse nominale train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,clLime);
    Affiche(s,Cllime);
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitNominale;
      if (placement[index_train].inverse) then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,true);
    end;

  end;

  if testbit(etat,semaphore_cli) and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' Sémaphore cli - Vitesse réduite train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,clLime);
    Affiche(s,clLime);
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitRalenti;
      if (placement[index_train].inverse) then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,true);
    end;
  end;
end;


// calcul des zones depuis le tableau des fronts montants ou descendants des évènements détecteurs
// transmis dans le tableau Event_det
// rattache le nouveau détecteur à un train
// adresse: adresse du detecteur, front: état du détecteur
procedure calcul_zones_V1(adresse: integer;etat : boolean);
var m,AdrSignal,AdrDetSignal,AdrTrainLoc,Nbre,i,i2,j,k,n,det1,det2,det3,det4,AdrSuiv,AdrPrec,Prev,
    id_couleur,det_suiv,nc,etatSig,tco : integer ;
    traite,trouve,SuivOk,casaig,rebond : boolean;
    couleur : tcolor;
    TypeSuiv : tEquipement;
    s,train_ch : string;
begin
  det3:=adresse; // c'est le nouveau détecteur
  if det3=0 then exit; // pas de nouveau détecteur
  traite:=false;
  rebond:=false;
  s:='Le nouveau détecteur est '+IntToSTR(det3);
  if etat then s:=s+' 1' else s:=s+' 0';
  Affiche_evt(s,clwhite) ;
  if dupliqueEvt then Affiche(s,clyellow) ;

  for i:=1 to N_trains do // nombre de trains détectés en circulation
  begin
    index_couleur:=((i - 1) mod NbCouleurTrain) +1;
    couleur:=CouleurTrain[index_couleur];
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'éléments du tableau courant exploré
    det1:=event_det_train[i].det[1].adresse;
    det2:=event_det_train[i].det[2].adresse;

    if ((det2=det3) and (nbre=2)) or ((det1=det3) and (nbre=1)) then
    begin
      //s:='Dét. '+intToSTR(det3)+' déjà affecté au train '+IntToSTR(i);
      //Affiche_evt(s,clwhite);
      event_det_tick[N_event_tick].train:=i;
      event_det_tick[N_event_tick].reaffecte:=3;
      if dupliqueEvt then Affiche(s,clyellow);
      rebond:=true;  // possible rebond ?
    end;


    // 1 élément dans le tableau et détecteur à 0---------------------------------------------
    if (nbre=1) and not(etat) then
    begin
      Det_Adj(det3);  // renvoie les adresses des détecteurs adjacents au détecteur "det3" résultat dans adj1 et adj2
      //if (roulage) then
      begin
        // traiter pour les cas avec 1 élément
        if traceListe or ProcPrinc then AfficheDebug('1-0 traitement Train n°'+intToSTR(i)+' 1 détecteur',clyellow);
        // vérifier si l'élément du tableau et le nouveau sont contigus
        if (Adj1=det1) or (Adj2=det1) then
        begin
          event_det_tick[N_event_tick].train:=i;

          with event_det_train[i] do
          begin
            det[2].adresse:=det3;
            det[2].etat:=etat;
            NbEl:=2;
          end;

          adrTrainLoc:=event_det_train[i].Adrtrain;
          Train_ch:=event_det_train[i].nom_train;
          if (AdrTrainLoc=0) and roulage then
          begin
            Affiche('Démarrage train non placé depuis détecteur '+intToSTR(det3),clred);
            if TraceListe then AfficheDebug('Démarrage train non placé depuis détecteur '+intToSTR(det3),clred);
          end;
          if roulage then
          begin
            j:=1;
            trouve:=false;
            repeat
              trouve:=placement[j].detdir=det3;
              inc(j);
            until (j>6) or trouve;
            dec(j);
            //si début de démarrage train i
            if not(trouve) or (TrainZone[i].Nbre>0) then exit;
            // affecter le nouveau détecteur
            detecteur[det3].train:=Train_ch;
            detecteur[det3].AdrTrain:=AdrTrainLoc;
            detecteur[det3].IndexTrain:=i;
          end;

          AdrSuiv:=detecteur_suivant_el(det1,det,det3,det,1);
          if adrSuiv>NbMaxDet then
          begin
            if adrsuiv=9996 then affiche_evt('Erreur position inconnue aiguillage ',clred)
            else
            Affiche_evt('Info 1-0 '+intToSTR(AdrSuiv)+' : pas de suivant detecteur_suivant_el '+intToSTR(det1)+' '+intToSTR(det3),clWhite);
            exit;
          end;

          //*** route validée ***
          if (det1<NbMaxDet) and (det2<NbMaxDet) and (det3<NbMaxDet) and (adrSuiv<NbMaxDet) then
          begin
            MemZone[det1,det3].etat:=FALSE;      // dévalide l'ancienne zone
            MemZone[det1,det3].train:='';
            MemZone[det1,det3].Adrtrain:=0;
            MemZone[det1,det3].IndexTrain:=0;

            MemZone[det3,det1].etat:=FALSE;      // dévalide l'ancienne zone inverse
            MemZone[det3,det1].train:='';
            MemZone[det3,det1].Adrtrain:=0;      // libère la réservation
            MemZone[det3,det1].IndexTrain:=0;

            MemZone[det3,AdrSuiv].etat:=true;    // valide la nouvelle zone
            MemZone[det3,AdrSuiv].train:=Train_ch;
            MemZone[det3,AdrSuiv].AdrTrain:=AdrTrainLoc;
            MemZone[det3,AdrSuiv].IndexTrain:=i;

            MemZone[AdrSuiv,det3].etat:=False;     // on dévalide la zone inverse
            MemZone[AdrSuiv,det3].train:='';
            MemZone[AdrSuiv,det3].AdrTrain:=0;
            MemZone[AdrSuiv,det3].IndexTrain:=0;
          end;

          // stockage dans historique de zones
          if i<MaxTrainZone then
          begin
            n:=TrainZone[i].Nbre+1;
            if n>MaxZones then n:=1;
            with TrainZone[i] do
            begin
              Nbre:=n;
              Zone[n].det1:=det1;
              Zone[n].det2:=det3;
              train:=train_ch;
              AdrTrain:=AdrTrainLoc
            end;
          end;
          reserve_canton(det3,AdrSuiv,AdrTrainLoc,i,nCantonsRes); // si feu réserve canton courant
          libere_canton(det1,det3);   // on quitte det3
          Maj_Signaux(false);
          Maj_Signaux(false);
          det4:=detecteur_suivant_EL(det3,det,AdrSuiv,det,1);
          if det4<9990 then reserve_canton(AdrSuiv,det4,AdrTrainLoc,i,nCantonsRes)  // réserve canton suivant après maj signaux
          else Affiche_evt('Réservation canton après '+intToSTR(det3)+' '+intToSTR(ADrSuiv)+' impossible (pos? aig)',clOrange);

          event_act(det1,det3,1,'',false);     // évènement détecteur de zone - 1

          // affichages
          Affiche_Evt('1-0 route ok de '+intToSTR(det1)+' à '+IntToSTR(det3),clWhite);
          if traceListe then AfficheDebug(s,clyellow);
          //Affiche(s,CouleurTrain[index_couleur]);
          if AffAigDet then AfficheDebug(s,clyellow);

          Affiche_Evt('1-0. Tampon train '+intToStr(i)+' '+event_det_train[i].nom_train+'--------',couleur);
          s:=intToSTR(event_det_train[i].det[1].adresse);
          Affiche_Evt(s,couleur);
          if traceliste then AfficheDebug(s,clyellow);
          if dupliqueEvt then Affiche(s,clyellow);
          s:=intToSTR(event_det_train[i].det[2].adresse);

          if TraceListe then AfficheDebug(s,clyellow);
          if dupliqueEvt then Affiche(s,clyellow);
          for tco:=1 to nbreTCO do
          begin
            if PcanvasTCO[tco]<>nil then
            begin
              // désactivation
              Zone_TCO(tco,det1,det3,i,0);
              // activation
              if ModeCouleurCanton=0 then zone_TCO(tco,det3,AdrSuiv,i,1)
              else zone_TCO(tco,det3,adrSuiv,i,2);  // affichage avec la couleur de index_couleur du train
            end;
          end;
          exit; // sortir absolument
        end
        else
        begin
          Affiche_evt('1-0 Train '+intToSTR(i)+' Eléments '+intToSTR(det1)+' et '+intToSTR(det3)+' non contigus',clyellow);
          
          for tco:=1 to nbreTCO do
            maj_tco(tco,det3);
          // det3 et det1 non adjacents
        end;
      end;
    end;

    // 1 élément dans le tableau et détecteur à 1 : on pilote le train si feu sur det3---------------------------------------------
    if (nbre=1) and etat then
    begin
      if traceListe or ProcPrinc then AfficheDebug('1-1 Traitement Train n°'+intToSTR(i)+' 1 détecteur',clyellow);
      // vérifier si l'élément du tableau et le nouveau sont contigus
      Det_Adj(det1);  // renvoie les adresses des détecteurs adjacents au détecteur "det1" résultat dans adj1 et adj2
      suivok:=((Adj1=det3) and (adj1<9999))  or ((Adj2=det3) and (adj2<9990));
      if suivok then
      begin
        Train_ch:=event_det_train[i].nom_train;
        AdrTrainLoc:=event_det_train[i].AdrTrain;

        event_det_tick[N_event_tick].train:=i;

        // en mode roulage, on a placé les trains
        //if roulage then
        begin
          j:=1;
          repeat
            trouve:=placement[j].detdir=det3;
            inc(j);
          until (j>6) or trouve;
          dec(j);
          //si début de démarrage train i
          //if trouve and (TrainZone[i].Nbre=0) and (det1<NbMaxDet) and (det3<NbMaxDet) then
          if (TrainZone[i].Nbre=0) and (det1<NbMaxDet) and (det3<NbMaxDet) then
          begin
            //Affiche('on a trouvé le train '+intToSTR(j),clYellow);
            detecteur[det3].train:=train_ch;    // affecter le nom du train au détecteur
            detecteur[det3].AdrTrain:=AdrTrainLoc ;    // affecter l'@ du train au détecteur

            detecteur[det1].train:=''; // désaffecter le nom du train du détecteur précédent
            detecteur[det1].AdrTrain:=0;

            //*** route validée ***
            MemZone[det1,det3].etat:=TRUE;      // valide la nouvelle zone
            MemZone[det1,det3].train:=train_ch;
            MemZone[det1,det3].AdrTrain:=AdrTrainLoc;
            MemZone[det1,det3].IndexTrain:=i;

            MemZone[det3,det1].etat:=False;     // on dévalide la zone inverse

            // test si on peut réserver le canton suivant
            det_suiv:=det_suiv_cont(det1,det3,1);
            if det_suiv<9990 then reserve_canton(det3,det_suiv,AdrTrainLoc,i,nCantonsRes) else
            begin
              if det_suiv=9996 then affiche_evt('Erreur 1-1 position inconnue aiguillage ',clred)
              else Affiche_evt('Erreur 1-1 '+intToSTR(Det_Suiv)+' : pas de suivant detecteur_suivant_el '+intToSTR(det1)+' '+intToSTR(det3),clred);
              exit;
            end;
            s:='route ok de '+intToSTR(det1)+' à '+IntToSTR(det3)+' pour train '+intToSTR(i);
            Affiche_Evt(s,clWhite);
            // activation
            for tco:=1 to nbreTCO do
             begin
               if ModeCouleurCanton=0 then zone_TCO(tco,det1,det3,i,1)
               else zone_TCO(tco,det1,det3,i,2);  // affichage avec la couleur de index_couleur du train
             end;
          end;
        end;

        pilote_train(det1,det3,adrtrainLoc,i);  // pilote le train sur det3
        event_act(det1,det3,1,'',false);     // activation zone - 2
        maj_signaux(false);
        // actualiser le signal du det3
        j:=signal_detecteur(det3);
        if j<>0 then Maj_Signal_P(j,false);
        exit;
      end;
      if Traceliste then AfficheDebug(inttoSTR(det3)+' n''est pas contigu à '+intToSTR(det1)+' pour le train '+intToSTR(i),clyellow);
      traite:=true;  // traiter le train suivant
    end;

    // 2 éléments dans le tableau et détecteur à 0---------------------------------------------
    if (nbre=2) and not(etat) then
    begin
      if TraceListe or ProcPrinc then AfficheDebug('2-0 traitement Train n°'+intToSTR(i)+' 2 détecteurs',couleur);
      // test si det1, det2 et det3 sont contigus malgré aig mal positionnés
      det_suiv:=det_suiv_cont(det1,det2,1);   // test si le suivant de det1 à det2 est bien le nouveau détecteur (det3)
      if traceliste then affichedebug('Le suivant aux '+intToSTR(det1)+' '+intToSTR(det2)+' est '+intToSTR(det_suiv),couleur);
      SuivOk:=(det_suiv=det3) and (det_suiv<9990);
      CasAig:=false;

      if not(SuivOk) then
      begin
        // cas d'un aiguillage qui a changé
        if det3=event_det_train[i].suivant then
        begin
          CasAig:=true;
          s:='Aiguillage Chgt, train '+intToSTR(i)+' '+intToSTR(det1)+' '+intToSTR(det2)+' '+intToSTR(det3);
          Affiche_Evt(s,couleur);
          if TraceListe then AfficheDebug(s,couleur);
          // trouver le suivant
          det_Adj(det3);
          if adj1<9990 then adrSuiv:=adj1;
          if adj2<9990 then adrSuiv:=adj2;
          event_det_tick[N_event_tick].reaffecte:=2;  // réaffecté par changement d'aiguillage
        end;
      end;

      if SuivOk or CasAig then
      begin
        if TraceListe then AfficheDebug('Route est valide, dét '+intToSTR(det2)+' '+intToSTR(det3)+' contigus',couleur);
        // ici on cherche le suivant à det2 det3, algo=1
        event_det_tick[N_event_tick].train:=i;
        if not(casAig) then AdrSuiv:=detecteur_suivant_el(det2,det,det3,det,0);  // dans le cas de CasAig, alors adrSuiv=9996 donc AdrSuiv est calculé plus haut
        if AdrSuiv<9990 then event_det_train[i].suivant:=AdrSuiv;
        if TraceListe then AfficheDebug('le sursuivant est '+intToSTR(adrsuiv),couleur);
        if (Adrsuiv>=9990) and not(casaig) then
        begin
          //Affiche('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' à '+intToSTR(det3),clRed);
          if (NivDebug=3) or TraceListe then AfficheDebug('Msg 1500 : pas de suivant sur la route de '+intToSTR(det2)+' à '+intToSTR(det3),clorange);
        end
        else
        begin
          // en mode roulage, voir si on perd le détecteur si le train était arreté devant un signal rouge
          //if roulage then
          //begin
          //  AdrFeu:=event_det_train[i].signal_rouge;
          //  if AdrFeu<>0 then
          //  begin
          //    s:='Erreur signal '+intToSTR(AdrFeu)+' au rouge et perte détecteur: ignoré';
          //    Affiche_Evt(s,clred);
          //    if traceListe then AfficheDebug(s,clred);
          //    event_det_tick[N_event_tick].reaffecte:=4;   // fd sur un feu à 0
          //    exit;
          //  end;
          //end;
          if (det2<NbMaxDet) and (det3<NbMaxDet) and (AdrSuiv<NbMaxDet) then
          begin
            //*** route validée ***
            train_ch:=event_det_train[i].nom_train;
            AdrTrainLoc:=event_det_train[i].Adrtrain;
             // efface zone précédente
            MemZone[det2,det3].etat:=FALSE;
            MemZone[det2,det3].train:='';
            MemZone[det2,det3].AdrTrain:=0;
            MemZone[det2,det3].IndexTrain:=0;
            // on dévalide la zone inverse
            MemZone[det3,det2].etat:=False;
            MemZone[det3,det2].train:='';
            MemZone[det3,det2].AdrTrain:=0;
            MemZone[det3,det2].IndexTrain:=0;

            // valide la nouvelle zone
            MemZone[det3,AdrSuiv].etat:=TRUE;
            MemZone[det3,AdrSuiv].train:=train_ch;
            MemZone[det3,AdrSuiv].AdrTrain:=AdrTrainLoc;
            MemZone[det3,AdrSuiv].IndexTrain:=i;
            // on dévalide la zone inverse
            MemZone[AdrSuiv,det3].etat:=False;
            MemZone[AdrSuiv,det3].train:='';
            MemZone[AdrSuiv,det3].AdrTrain:=0;
            MemZone[AdrSuiv,det3].IndexTrain:=0;

            detecteur[det3].train:=train_ch ;   // affectation nom train au nouveau détecteur
            detecteur[det3].AdrTrain:=AdrTrainLoc;
            if detecteur[det2].train=train_ch then  detecteur[det2].train:='';    // désaffectation du nom de train de l'ancien détecteur si le nom du train est égal
            if detecteur[det2].AdrTrain=AdrTrainLoc then detecteur[det2].AdrTrain:=0;    // désaffectation du nom de train de l'ancien détecteur

            //libere_canton(det2,det3);
            reserve_dereserve_det(det2,det3,0,0,0);  // libère
            reserve_canton(det3,AdrSuiv,adrTrainLoc,i,nCantonsRes);
            det4:=detecteur_suivant_EL(det3,det,AdrSuiv,det,1);
            if det4>9990 then
            begin
              if det4=9996 then affiche_evt('Erreur: 2-0 position inconnue aiguillage ',clred)
              else Affiche_evt('Info: 2-0 '+intToSTR(Det4)+' : pas de detecteur_suivant_el '+intToSTR(det3)+' '+intToSTR(AdrSuiv),clyellow);
            end
            else
              reserve_canton(AdrSuiv,det4,adrTrainLoc,i,nCantonsRes);

            //Maj_Signaux(false); sans_maj
            // stockage dans historique de zones
            if i<MaxTrainZone then
            begin
              n:=TrainZone[i].Nbre+1;
              if n>MaxZones then n:=1;
              with TrainZone[i] do
              begin
                Nbre:=n;
                Zone[n].det1:=det3;
                Zone[n].det2:=AdrSuiv;
                Nbre:=n;
              end;
            end;

            event_act(det2,det3,0,'',false);        // désactivation zone
            event_act(det3,AdrSuiv,1,'',false);     // activation zone
          end
          else
          begin
            s:='Erreur 740 : Adresse détecteur trop élevé ';
            if det2>NbMaxDet then s:=s+inttostr(det2)+' ';
            if det3>NbMaxDet then s:=s+inttostr(det2)+' ';
            if AdrSuiv>NbMaxDet then s:=s+inttostr(det2);
            Affiche(s,clred);
          end;

          // supprimer le 1er evt et décaler
          with event_det_train[i] do
          begin
            det[1].adresse:=event_det_train[i].det[2].adresse;
            det[1].etat:=event_det_train[i].det[2].etat;
            det[2].adresse:=det3;
            det[2].etat:=detecteur[det3].etat;
            NbEl:=2;
          end;

          // affichages
          s:='2-0 Train n°'+intToSTR(i)+' route ok de '+intToSTR(det2)+' à '+IntToSTR(det3);
          if casAig then s:=s+'A';
          s:=s+' à '+IntToSTR(Adrsuiv);

          Affiche_evt(s,couleur);
          if traceListe then AfficheDebug(s,clyellow);
          s:='Train '+IntToSTR(i);
          if AdrTrainLoc<>0 then s:=s+' @'+intToSTR(AdrTrainLoc);
          s:=s+' '+Train_ch+' sur zones '+IntToSTR(det3)+' à '+IntToStr(AdrSuiv);
          if traceListe then AfficheDebug(s,couleur);

          s:='Train '+IntToSTR(i);
          if AdrTrainLoc<>0 then s:=s+' '+train_ch+' @'+intToSTR(AdrTrainLoc);
          s:=s+' sur zones '+IntToSTR(det3)+' à '+IntToStr(AdrSuiv);
          Affiche(s,Couleur);
          if AffAigDet then AfficheDebug(s,couleur);

          Affiche_Evt('1.Tampon train '+intToStr(i)+' '+event_det_train[i].nom_train+'--------',couleur);
          Affiche_Evt(intToSTR(event_det_train[i].det[1].adresse),couleur);
          Affiche_Evt(intToStr(event_det_train[i].det[2].adresse),couleur);
          if TraceListe then
          begin
            AfficheDebug(intToSTR(event_det_train[i].det[1].adresse),couleur);
            AfficheDebug(intToSTR(event_det_train[i].det[2].adresse),couleur);
          end;

          for tco:=1 to nbreTCO do
          begin
            if PcanvasTCO[tco]<>nil then
            begin
              Maj_Aig_TCO(tco);
              zone_TCO(tco,det2,det3,i,0);    // désactivation
              // activation
              if ModeCouleurCanton=0 then zone_TCO(tco,det3,AdrSuiv,i,1)
              else zone_TCO(tco,det3,AdrSuiv,i,2);  // affichage avec la couleur de index_couleur du train
            end;
          end;

          // mettre à jour si présence signal sur det3 pour le passer au rouge de suite
          j:=signal_detecteur(det3);
          if j<>0 then
          begin
            Maj_Signal_P(j,false);
            etatSig:=Signaux[k].etatsignal;
          end;
          Maj_Signaux(false); // mise à jour générale
          exit; // sortir absolument
        end;
      end
      else
      begin
        Affiche_evt('2-0 Train '+intToSTR(i)+' Eléments '+intToSTR(det2)+' et '+intToSTR(det3)+' non contigus',clyellow);
        if event_det_train[i].det[2].adresse=det3 then
        begin
          s:='7. Rebond dét. '+intToSTR(det3)+' déjà affecté au train '+IntToSTR(i);
          FormDebug.MemoEvtDet.lines.add(s);
          if dupliqueEvt then AfficheDebug(s,clyellow);
          if dupliqueEvt then Affiche(s,clyellow);
        end;
      end;
    end;

    if (nbre=2) and etat then
    begin
      if TraceListe or (NivDebug=3)  or ProcPrinc then AfficheDebug('2-1 traitement Train n°'+intToSTR(i)+' 2 détecteurs',couleur);
      // front descendant sur détecteur 2
      det_suiv:=det_suiv_cont(det1,det2,1);   // test si le suivant de det1 à det2 est bien le nouveau détecteur (det3)
      if traceliste then affichedebug('Le suivant aux '+intToSTR(det1)+' '+intToSTR(det2)+' est '+intToSTR(det_suiv),clWhite);
      if (det_suiv=det3) and (det_suiv<9990) then
      begin
        event_det_tick[N_event_tick].train:=i;
        if TraceListe then AfficheDebug('La route est valide car les détecteurs '+intToSTR(det2)+' '+intToSTR(det3)+' sont contigus',couleur);
        if (det1<NbMaxDet) and (det2<NbMaxDet) and (det3<NbMaxDet) then
        begin
          //*** route validée ***
          // on ne dévalide pas la zone précédente car sinon ne marche pas quand 2 trains se suivent
          MemZone[det2,det3].etat:=TRUE;      // valide la nouvelle zone
          MemZone[det3,det2].etat:=False;     // on dévalide la zone inverse
          Train_ch:=MemZone[det2,det3].train;
          AdrTrainLoc:=MemZone[det2,det3].AdrTrain;

          detecteur[det3].train:=Train_ch;   // affectation nom train au nouveau détecteur
          detecteur[det3].AdrTrain:=AdrTrainLoc;   // affectation train au nouveau détecteur
          detecteur[det3].IndexTrain:=i;

          detecteur[det2].train:=''; // désaffectation du nom de train de l'ancien détecteur
          detecteur[det2].AdrTrain:=0;
          detecteur[det2].IndexTrain:=0;

          i2:=index_train_adresse(AdrTrainLoc);
          if i2<>0 then trains[i2].index_event_det_train:=i;   // lier l'index du train en circulation

          pilote_train(det2,det3,adrtrainLoc,i);   // pilote le train sur det3
          // test si on peut réserver le canton suivant
          det_suiv:=det_suiv_cont(det2,det3,1);
          if det_suiv<9990 then reserve_canton(det3,det_suiv,AdrTrainLoc,i,nCantonsRes)
          else
          begin
            if det_suiv=9996 then affiche_evt('Erreur 2-1 position inconnue aiguillage ',clred)
              else Affiche_evt('Erreur 2-1 '+intToSTR(Det_Suiv)+' : pas de suivant detecteur_suivant_el '+intToSTR(det2)+' '+intToSTR(det3),clred);
          end;
        end
        else
        begin
          s:='Erreur 740 : Adresse détecteur trop élevé ';
          if det2>NbMaxDet then s:=s+inttostr(det2)+' ';
          if det3>NbMaxDet then s:=s+inttostr(det2)+' ';
          if AdrSuiv>NbMaxDet then s:=s+inttostr(det2);
          Affiche(s,clred);
        end;
        // stockage dans historique de zones sauf s'il est déja stocké
        if i<MaxTrainZone then
        begin
          n:=TrainZone[i].Nbre;
          if n>0 then
          begin
            if (TrainZone[i].Zone[n].det1<>det2) or (TrainZone[i].Zone[n].det2<>det3) then
            begin
              n:=TrainZone[i].Nbre+1;
              if n>MaxZones then n:=1;
              TrainZone[i].Nbre:=n;
              TrainZone[i].Zone[n].det1:=det2;
              TrainZone[i].Zone[n].det2:=det3;
              TrainZone[i].Nbre:=n;
            end;
          end;
        end;
        // affichages
        s:='2-1 Train n°'+intToSTR(i)+' Route ok de '+intToSTR(det2)+' à '+IntToSTR(det3);
        Affiche_evt(s,couleur);
        if traceListe then AfficheDebug(s,Couleur);
        if AffAigDet then AfficheDebug(s,couleur);
        for tco:=1 to nbreTCO do
        begin
          // désactivation du morceau avant l'aiguillage
          efface_trajet(det3,i);
        end;
        exit; // sortir absolument
      end
      else
      begin
        if (det1=det3) and false then
        begin
          s:='Demi-tour train '+intToSTR(i);
          if TraceListe then AfficheDebug(s,clOrange);
          Affiche_evt(s,clOrange);
          MemZone[det2,det_Suiv].etat:=false;
          MemZone[det2,det3].etat:=true;
          efface_trajet(det2,i);
          with event_det_train[i] do
          begin
            det[1].adresse:=det_suiv;
            det[1].etat:=false;
            det[2].adresse:=det2;
            det[2].etat:=false;
            NbEl:=2;
          end;

        end
        else
        begin
          if TraceListe then AfficheDebug('La route est invalide car les détecteurs '+intToSTR(det1)+' '+intToSTR(det2)+' n''ont pas le '+intToSTR(det3)+' attendu',clOrange);
          s:='2-1 Train n°'+intToSTR(i)+' Route nok de '+intToSTR(det2)+' à '+IntToSTR(det3);
          Affiche_evt(s,couleur);
          for tco:=1 to nbreTCO do
          begin
            // désactivation du morceau avant l'aiguillage
            efface_trajet(det3,i);
          end;
        end;
      end;
      traite:=true; // non traité: train suivant
    end;
  end;  // fin de la boucle for i

  // dans cette partie, le détecteur n'a pas encore été affecté à un train existant.
  if rebond then exit;

  if etat then
  begin
   { inutile
    Maj_Signaux(false);                    // les autres signaux  , avec détecteurs
    // mettre à jour le signal du détecteur
    i2:=signal_detecteur(det3);  // trouve le signal associé au detecteur2
    if i2<>0 then Maj_Signal_P(i2,false);  // avec détecteur
    }
    for i:=1 to N_trains do
    begin
      i2:=event_det_train[i].Suivant;
      if i2>NbMaxDet then begin AfficheDebug('Erreur 715 : détecteur '+intToSTR(i2)+' trop grand',clred);exit;end;
      SuivOk:=event_det_train[i].Det[2].etat ;
      det_adj(det3);
      if (adj1=i2) or (adj2=i2) then
      begin
        s:='Train '+intToSTR(i)+' Détection '+intToSTR(det3)+' à 1 avant RAZ du '+intToSTR(i2);
        Affiche_evt(s,clorange);
        if traceListe then afficheDebug(s,clorange);
        detecteur[det3].AdrTrain:=i; // récupération du train au détecteur

        adrTrainLoc:=detecteur[i2].AdrTrain;
        Train_ch:=MemZone[det2,i2].train;

        detecteur[det3].train:=Train_ch;   // affectation nom train au nouveau détecteur
        detecteur[det3].AdrTrain:=AdrTrainLoc;   // affectation train au nouveau détecteur
        detecteur[det2].train:=''; // désaffectation du nom de train de l'ancien détecteur
        detecteur[det2].AdrTrain:=0;

        event_det_tick[N_event_tick].train:=i;
        event_det_tick[N_event_tick].reaffecte:=1;    // mauvais séquençage détecteurs contigus

        pilote_train(i2,det3,adrtrainLoc,i);   // pilote le train sur det3
        // test si on peut réserver le canton suivant
        det_suiv:=det_suiv_cont(i2,det3,1);
        if det_suiv<9990 then reserve_canton(det3,det_suiv,AdrTrainLoc,i,nCantonsRes);
        // libère canton
        libere_canton(i2,det3);
        exit;
      end;
    end;
  end;

  // nouveau train front det=0
  if not(etat) then
  begin
    if traceListe or ProcPrinc then AfficheDebug('Nouveau train',clyellow);
    // Nombre d'éléments à 0 : ici c'est un nouveau train donc créer un train, donc un tableau
    if N_Trains>=Max_Trains then
    begin
      Affiche('Erreur nombre de train maximal atteint',clRed);
      N_trains:=0;
    end;
    Inc(N_trains);
    event_det_tick[N_event_tick].train:=n_trains;

    with event_det_train[N_trains] do
    begin
      det[1].adresse:=0;
      det[2].adresse:=0;
      NbEl:=0;
      nom_train:='';
    end;

    // vérifier si le détecteur du nouveau train est associé à un feu vers un buttoir
    for i:=1 to NbreSignaux do
    begin
      AdrSignal:=Signaux[i].Adresse;
      AdrDetSignal:=Signaux[i].Adr_Det1;
      if (AdrDetSignal=Det3) and not(isDirectionnel(i)) then
      begin
        AdrSuiv:=Signaux[i].Adr_el_suiv1;
        TypeSuiv:=Signaux[i].Btype_suiv1;
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetSignal,det,1) ; // détecteur précédent le feu ; algo 1
        if AdrPrec=0 then
        begin
          if TraceListe then Affiche('FD - Le signal '+IntToSTR(AdrSignal)+' est précédé d''un buttoir',clyellow);
          if AdrDetSignal<NbMaxDet then
            MemZone[0,AdrDetSignal].etat:=false
          else
            Affiche('Erreur 741: Adresse détecteur signal trop élevé: '+intToSTR(AdrDetSignal),clred);
          Maj_Signal_P(AdrSignal,false);
        end;
      end;
    end;

    if TraceListe then AfficheDebug('Création Train n°'+intToSTR(N_trains),clyellow);
    Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);

    with event_det_train[N_trains] do
    begin
      det[1].adresse:=det3;
      det[1].etat:=etat;
      NbEl:=1;
      nom_train:=detecteur[det3].train;
      AdrTrain:=detecteur[det3].AdrTrain;
    end;

    TrainZone[n_trains].train:=detecteur[det3].train;
    TrainZone[n_trains].AdrTrain:=detecteur[det3].Adrtrain;
    if roulage then
    begin
      j:=index_train_adresse(detecteur[det3].AdrTrain);
      j:=placement[j].detdir; // detecteur destination
      MemZone[det3,j].etat:=true;
      MemZone[det3,j].train:=detecteur[det3].train;
      MemZone[det3,j].AdrTrain:=detecteur[det3].AdrTrain;
    end;
    MemZone[det3,j].IndexTrain:=n_trains;

    s:=intToSTR(event_det_train[N_trains].det[1].adresse);
    id_couleur:=((N_trains - 1) mod NbCouleurTrain) +1;

    for i2:=1 to NbreTCO do maj_TCO(i2,det3);

    Affiche_Evt('0-0 Création train '+intToStr(N_trains)+' '+detecteur[det3].train+'--------',CouleurTrain[id_couleur]);
    Affiche_evt(s,CouleurTrain[id_couleur]);
    if dupliqueEvt then
    begin
      Affiche('0-0 Création train '+intToStr(N_trains)+' '+detecteur[det3].train+'--------',clyellow);
      Affiche(s,clyellow);
    end;
    if TraceListe or ProcPrinc then
    begin
      AfficheDebug('0-0 Création train '+intToStr(N_trains)+' '+detecteur[det3].train+'--------',clyellow);
      AfficheDebug(s,clyellow);
    end;
    Maj_Signaux(false);
    exit;
  end;

  //if etat then detecteur[det3].IndexTrain:=1;

end;

// affecte le détecteur "adresse" d'état "front" au train et met sa route à jour
procedure calcul_zones(adresse: integer;front : boolean);
begin
  if debug=3 then formprinc.Caption:='Calcul_zones '+intToSTR(adresse);
  if Algo_localisation=1 then calcul_zones_v1(adresse,front)
    else affiche('Algo localisation inconnu',clred);

  if debug=3 then formprinc.Caption:='';
end;


// demande l'état d'un détecteur à la centrale. Le résultat sera réceptionné sur évènement des informations
// de rétrosignalisation.
procedure demande_info_det_XpressNet(adresse : integer);
var s : string;
    n,module : byte;
begin
  // uniquement si connecté directement à la centrale
  if portCommOuvert or parSocketLenz or (etat_init_interface>=11)  then
  begin
    if protocole=1 then
    begin
      module:=(adresse-1) div 8;  // module à partir de 64
      module:=module;
      s:=#$42+char(module);
      //n:=((module-64) mod 8) div 2;   // N=0 ou 1 (513..516 N=0  517..520 N=1  etc)
      n:=((adresse-1) mod 8) div 4;     // N=0 ou 1 (513..516 N=0  517..520 N=1  etc)
      n:=$80 or n;
      s:=s+char(n);
      s:=checksum(s);
      envoi(s);
    end;
    if protocole=2 then
    begin
      Affiche('Erreur demande info détecteur '+intToSTR(adresse)+' non traitée en dcc+',clred);
    end;
  end;
end;


// demande l'état d'un accessoire à la centrale. Le résultat sera réceptionné sur évènement des informations
// de rétrosignalisation.
procedure demande_info_acc_XpressNet(adresse : integer);
var s : string;
    n : byte;
begin
  // uniquement si connecté directement à la centrale
  if portCommOuvert or parSocketLenz then
  begin
    if protocole=1 then
    begin
      s:=#$42+char((adresse-1) div 4);
      n:=((adresse-1) mod 4) div 2;   // N=0 ou 1
      //AfficheDebug(intToSTR(adresse)+' '+intToSTR(n),ClWhite);
      n:=$80 or n;
      s:=s+char(n);
      s:=checksum(s);
      envoi(s);
    end;
    if protocole=2 then
    begin
      Affiche('Erreur demande info accessoire '+intToSTR(adresse)+' non traitée en dcc+',clred);
    end;
  end;
end;

// demande l'état de tous les détecteurs par l'interface
procedure demande_etat_det;
var j,adr,t : integer;
    s : string;
begin
  if portCommOuvert or parSocketLenz or (etat_init_interface>=11) then
  begin
    Affiche('Demande état des détecteurs',ClYellow);
    if protocole=1 then
    begin
      modeStkRetro:=true; // stockage sans evt
      for j:=1 to NDetecteurs do
      begin
        adr:=Adresse_detecteur[j];
        Affiche('Demande état détecteur '+intToSTR(adr),clLime);
        retEtatDet:=false;
        demande_info_det_XpressNet(adr);
        t:=0;
        repeat
          Application.ProcessMessages;
          inc(t);
          sleep(10);
        until (retEtatDet) or (t>100);
        if t>100 then s:='=?' else
        if Detecteur[adr].etat then s:='=1' else s:='=0';
        Affiche_suivi(s,clLime);
      end;
      modeStkRetro:=false; // avec evt
    end;
  end;
end;


// demande l'état de tous les accessoires par l'interface
procedure demande_etat_acc;
var i,adresse : integer;
    model : Tequipement;
begin
  if portCommOuvert or parSocketLenz then
  begin
    Affiche('Demande état des aiguillages',ClYellow);
    if protocole=1 then
    begin
      for i:=1 to maxaiguillage do
      begin
        model:=aiguillage[i].modele ;
        if (model<>rien) and (model<>crois) then
        begin
          adresse:=aiguillage[i].Adresse;
          Affiche('Demande état aiguillage '+intToSTR(adresse),clLime);
          demande_info_acc_XpressNet(adresse);
        end;
      end;
    end;
    if protocole=2 then
    begin
      affiche_aigdcc:=true;
      envoi('<T>');
      affiche_aigdcc:=false;
    end;
  end;
end;

// ferme le pn par port com usb
procedure ferme_pn_usb(i : integer);
var v,cmd,numacc : integer;
    s : string;
begin
  numacc:=Tablo_pn[i].AdresseFerme; // numéro de périphérique
  if numacc=0 then exit;
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
    Affiche('Erreur 56 : numéro de périphérique hors limite pour PN '+intToSTR(i),clred);
    exit;
  end;
  v:=Tablo_periph[numacc].NumCom;  // numéro de com
  if v=0 then exit;
  if tablo_periph[numacc].PortOuvert then
  begin
    s:=Tablo_PN[i].CommandeF;
    if Tablo_periph[numacc].cr then s:=s+#13;
    cmd:=Tablo_periph[numacc].numComposant;
    if cmd=1 then envoi_usb_comp(MSCommCde1,s);
    if cmd=2 then envoi_usb_comp(MSCommCde2,s);

    Affiche('Envoie port COM'+intToSTR(v)+' commande: '+s,clWhite);
  end
    else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non détecté',clred);
end;

// ouvre le pn par port com usb
procedure ouvre_pn_usb(i : integer);
var v,cmd,numacc : integer;
    s : string;
begin
  numacc:=Tablo_pn[i].AdresseFerme; // numéro d'accessoire
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
   Affiche('Erreur 57 : numéro de périphérique hors limite pour PN '+intToSTR(i),clred);
   exit;
  end;
  v:=Tablo_periph[numacc].NumCom;  // numéro de com
  if v=0 then exit;
  if tablo_periph[numacc].PortOuvert then
  begin
    s:=Tablo_PN[i].CommandeO;
    if Tablo_periph[numacc].cr then s:=s+#13;
    cmd:=Tablo_periph[numacc].numComposant;
    if cmd=1 then envoi_usb_comp(MSCommCde1,s);
    if cmd=2 then envoi_usb_comp(MSCommCde2,s);

    Affiche('Envoie port COM'+intToSTR(v)+' commande: '+s,clWhite);
  end
   else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non détecté',clred);
end;

// ouvre le pn par socket i = index tablo_pn
procedure ouvre_pn_socket(i : integer);
var numacc,cmd : integer;
    s : string;
begin
  numacc:=Tablo_pn[i].AdresseFerme; // numéro d'accessoire
  if numacc=0 then exit;
  s:=Tablo_PN[i].CommandeO;
  if Tablo_periph[numacc].cr then s:=s+#13;
  cmd:=Tablo_periph[numacc].numComposant;
  if cmd=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
  if cmd=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
  Affiche('Envoie socket'+intToSTR(numacc)+' commande: '+s,clWhite);
end;

// ferme le pn par socket i = index tablo_pn
procedure ferme_pn_socket(i : integer);
var numacc,cmd : integer;
    s : string;
begin
  numacc:=Tablo_pn[i].AdresseFerme; // numéro d'accessoire
  if numacc=0 then exit;
  s:=Tablo_PN[i].CommandeF;
  if Tablo_periph[numacc].cr then s:=s+#13;
  cmd:=Tablo_periph[numacc].numComposant;
  if cmd=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
  if cmd=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
  Affiche('Envoie socket'+intToSTR(numacc)+' commande: '+s,clWhite);
end;


// envoie une chaine de caractères du tablo actionneur index i
procedure envoi_periph_usb(i : integer);
var numacc,v,cmd : integer;
    s : string;
begin
  numacc:=Tablo_actionneur[i].fonction; // numéro de périphérique
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
    Affiche('Erreur 58 : numéro de périphérique hors limite '+intToSTR(i),clred);
    exit;
  end;
  v:=Tablo_periph[numacc].NumCom;  // numéro de com
  if v=0 then exit;
  if tablo_periph[numacc].PortOuvert then
  begin
    s:=Tablo_actionneur[i].trainDest;
    if Tablo_periph[numacc].cr then s:=s+#13;
    cmd:=Tablo_periph[numacc].numComposant;
    if numacc=1 then envoi_usb_comp(MSCommCde1,s);
    if numacc=2 then envoi_usb_comp(MSCommCde2,s);

    if Tablo_periph[numacc].ScvVis then Affiche('Envoi COM'+intToSTR(v)+': '+s,clYellow);
  end
    else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non détecté',clred);
end;

// envoi le texte traindest de l'accessoire sur le socket de l'actionneur i
procedure envoi_socket_periph_act(i : integer);
var v,numacc : integer;
    s : string;
begin
  v:=Tablo_actionneur[i].fonction; // numéro de périphérique
  numacc:=Tablo_periph[v].numComposant;   //numéro de composant
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
    Affiche('Erreur 59 : numéro de périphérique hors limite',clred);
    exit;
  end;
  s:=Tablo_actionneur[i].trainDest;
  if Tablo_periph[numacc].cr then s:=s+#13;
  if numacc=1 then Formprinc.ClientSocketCde1.socket.SendText(s);
  if numacc=2 then Formprinc.ClientSocketCde2.socket.SendText(s);
  if Tablo_periph[numacc].ScvVis then Affiche('Envoi socket '+s,clYellow);
end;

// envoie un texte vers tous les clients, connectés au serveur signaux_complexes
procedure envoi_serveur(s : string);
var i : integer;
begin
  with Formprinc.serverSocket.Socket do
  begin
    for i:=0 to ActiveConnections-1 do
    begin
      if i<=IdClients then
      if Liste_Clients[i].adresse<>'' then connections[i].SendText(s+#13);
    end;
  end;
end;

// test si "train" est dans la liste des trains combinés traincombine
// pour le déclenchement sélectif des actionneurs
// ex : TrainCombine='BB1542+CC6500' train='CC6500' renvoie vrai
function test_train_decl(TrainCombine,train: string) : boolean;
var i : integer;
    trainUnique : string;
    trouve : boolean;
begin
  trouve:=false;
  repeat
    i:=pos('+',Traincombine);
    if i<>0 then
    begin
      TrainUnique:=Copy(Traincombine,1,i-1);
      delete(traincombine,1,i);
      trouve:=trainUnique=train;
    end
    else trouve:=traincombine=train;
  until (i=0) or trouve;
  result:=trouve;
end;

// traitement des évènements actionneurs (detecteurs aussi)
// adr adr2 : pour mémoire de zone
// trainDecl : composé de X, d'un train ou de plusieurs, séparés par +
// hor : si évt horaire
procedure Event_act(adr,adr2,etat : integer;trainDecl : string;hor : boolean);
var typ,i,v,etatAct,Af,Ao,Access,sortie,dZ1F,dZ2F,dZ1O,dZ2O : integer;
    sDecl,st,trainDest : string;
    fm,fd,adresseOk,etatvalide : boolean;
    Ts : TAccessoire;
begin
  if adr<=0 then exit;
  if debugPN then
  begin
    if (adr=539) and (adr2=529)  then
    affiche('CAS OUVRE',clred);
    if (adr=528) and (adr2=522)  then
    affiche('CAS FERME',clred);
  end;
  if debugPN then Affiche(intToSTR(adr)+'/'+intToSTR(adr2)+' '+intToSTR(etat)+' '+TrainDecl,clyellow);

  if adr>1024 then
  begin
    Affiche('Erreur 81 : reçu adresse actionneur trop grande : '+intToSTR(adr),clred);
    exit;
  end;

  // Etat actionneur (un état aiguillage peut prendre les valeurs de 1 à 2)
  // ancien  nouveau
  //    0      1     FM
  //    0      2     FM
  //    1      2     FM
  //    2      1     FM
  //---------------------
  //    1      0     FD
  //    2      0     FD

  if not(hor) and (adr2=0) then
  begin
    fd:=(Ancien_actionneur[adr]>0)  and (etat=0);         // front descendant (FD)
    fm:=(Ancien_actionneur[adr]<>etat) and (etat<>0);     // front montant (FM)

    ancien_actionneur[adr]:=etat;
    if not(fd) and not(fm) then exit;
  end;

  if AffAigDet and (adr2=0) then AfficheDebug('Tick='+IntToSTR(tick)+' Evt Act='+intToSTR(Adr)+'='+intToSTR(etat)+' Train='+trainDecl,clyellow);
  // vérifier si l'actionneur en évènement a été déclaré pour réagir
  // dans tableau des actionneurs
  for i:=1 to maxTablo_act do
  begin
    sDecl:=Tablo_actionneur[i].trainDecl;
    etatAct:=Tablo_actionneur[i].etat ;  // état à réagir
    etatValide:=((etatAct=etat) and fm) or ((etatAct=0) and fd);      // front montant ou descendant
    typ:=Tablo_actionneur[i].typdeclenche;  // déclencheur: 0=actioneur/détecteur  2=evt aig  3=MemZone
    if typ=0 then
    begin
      st:='Détecteur/actionneur '+intToSTR(adr);
    end;
    if typ=1 then
    begin
      st:='Horaire '+format('%.2dh%.2d',[adr,adr2]);
      etatvalide:=true;  // valider systématiquement l'état valide en actionneur horaire
    end;
    if typ=2 then
    begin
      st:='Aiguillage '+intToSTR(adr);
    end;
    if typ=3 then
    begin
      adresseok:=adresseOk and (Tablo_actionneur[i].adresse2=adr2);
      st:='Mémoire de zone '+intToSTR(adr)+' '+intToStr(adr2);
    end;

    adresseok:=( ((Tablo_actionneur[i].adresse=adr) and (adr2=0) ) and ((typ=0) or (typ=2)) ) or
               ( ((Tablo_actionneur[i].adresse=adr) and (Tablo_actionneur[i].adresse2=adr2)  and ((typ=3) or (typ=1))) ) ;


    // actionneur pour fonction train
    if adresseOk and (Tablo_actionneur[i].loco) and ( test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')) and (etatValide) then
    begin
      trainDest:=Tablo_actionneur[i].trainDest;
      // exécution de la fonction F vers CDM
      if (trainDest='X') or (trainDest='') then traindest:=traindecl;
      //if (trainDest='X') then traindest:=sDecl;
      Affiche(st+' TrainDecl='+trainDecl+' TrainDest='+trainDest+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':'+intToSTR(etat),clyellow);
      envoie_fonction_CDM(Tablo_actionneur[i].fonction,etat,trainDest);
      tablo_actionneur[i].TrainCourant:=trainDest;  // pour mémoriser le train pour la retombée de la fonction
      tablo_actionneur[i].TempoCourante:=tablo_actionneur[i].Tempo div 100;
    end;

    // pour vitesse
    if adresseOk and (Tablo_actionneur[i].vit) and ( test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')) and (etatValide) then
    begin
      trainDest:=Tablo_actionneur[i].trainDest;
      // exécution de la fonction F vers CDM
      if (trainDest='X') or (trainDest='') then traindest:=traindecl;
      //if (trainDest='X') then traindest:=sDecl;
      Affiche(st+' TrainDecl='+trainDecl+' TrainDest='+trainDest+' V'+IntToSTR(Tablo_actionneur[i].fonction),clyellow);

      vitesse_loco(trainDest,0,0,Tablo_actionneur[i].fonction,true);   
    end;


    // actionneur pour accessoire
    if adresseOk and (Tablo_actionneur[i].act) and ( test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')) and (etatValide) then
    begin
      access:=Tablo_actionneur[i].accessoire;
      sortie:=Tablo_actionneur[i].sortie;

      Affiche(st+' Train='+trainDecl+' Accessoire '+IntToSTR(access)+':'+intToSTR(sortie),clyellow);
      // exécution la fonction accessoire vers CDM
      if Tablo_actionneur[i].RAZ then Ts:=aigP else Ts:=signal;
      pilote_acc(access,sortie,Ts); // sans RAZ
    end;

    // actionneur pour son
    if adresseOk and (Tablo_actionneur[i].Son) and ( test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')) and (etatValide) then
    begin
      if typ<>2 then st:=st+' Train='+trainDecl;
      Affiche(st+' son '+Tablo_actionneur[i].FichierSon,clyellow);
      PlaySound(pchar(Tablo_actionneur[i].FichierSon),0,SND_ASYNC);
    end;

    // commande COM/USB socket
    if adresseOK and (Tablo_actionneur[i].periph) and ( test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')) and (etatValide) then
    begin
      trainDest:=Tablo_actionneur[i].trainDest;
      v:=tablo_actionneur[i].fonction;   // numéro d'accessoire
      Affiche(st+' TrainDecl='+trainDecl+' Envoi commande '+TrainDest,clWhite);
      af:=com_socket(v);
      if af=1 then envoi_periph_usb(i);    // numéro d'actionneur
      if af=2 then envoi_socket_periph_act(i); // numéro d'actionneur
    end;
  end;

  // dans le tableau des PN
  for i:=1 to NbrePN do
  begin
    if Tablo_PN[i].voie[1].actOuvre<>0 then
    begin
      // PN par actionneur
      if Tablo_PN[i].nbvoies>5 then Tablo_PN[i].nbvoies:=5;
      for v:=1 to Tablo_PN[i].nbvoies do
      begin
        aF:=Tablo_PN[i].voie[v].actFerme;
        aO:=Tablo_PN[i].voie[v].actOuvre;

        if (aO=adr) and (fd) then  // actionneur d'ouverture sur front descendant
        begin
          if DebugPN then Affiche('Compteur PN'+intToSTR(i)+'='+intToSTR(tablo_pn[i].compteur),clwhite);
          if tablo_pn[i].compteur=1 then  // compteur du nombre de trains sur le PN
          begin
            Affiche('Ouverture PN'+intToSTR(i)+' par act '+intToSTr(adr)+' (voie '+IntToSTR(v)+')',clwhite);
            if tablo_pn[i].TypeCde=0 then
            begin
              if Tablo_PN[i].pulse=1 then ts:=aigP else ts:=signal;
              pilote_acc(Tablo_PN[i].AdresseOuvre,Tablo_PN[i].CommandeOuvre,ts);
            end
            else
            begin
              typ:=Tablo_PN[i].AdresseFerme;  // numéro accessoire
              typ:=com_socket(typ);
              if typ=1 then ouvre_pn_usb(i);
              if typ=2 then ouvre_pn_socket(i);
            end;
          end;
          if tablo_pn[i].compteur>0 then
          begin
            dec(tablo_pn[i].compteur);
            if debugPN then Affiche('Compteur PN'+intToSTR(i)+'='+intToSTR(tablo_pn[i].compteur),clwhite);
          end;
        end;

        if (aF=adr) and (fm) then  // actionneur de fermeture sur front montant
        begin
          inc(tablo_pn[i].compteur);
          if DebugPN then Affiche('Compteur PN'+intToSTR(i)+'='+intToSTR(tablo_pn[i].compteur),clwhite);
          if tablo_pn[i].compteur=1 then
          begin
            sDecl:='Fermeture PN'+IntToSTR(i)+' par act '+intToSTr(adr)+' (train voie '+IntToSTR(v)+')';
            Affiche(sDecl,clwhite);
            if tablo_pn[i].TypeCde=0 then   // par accessoire
            begin
              if Tablo_PN[i].pulse=1 then ts:=aigP else ts:=signal;
              pilote_acc(Tablo_PN[i].AdresseFerme,Tablo_PN[i].CommandeFerme,ts);
            end
            else
            begin
              typ:=Tablo_PN[i].AdresseFerme;  // numéro accessoire
              typ:=com_socket(typ);
              if typ=1 then ferme_pn_usb(i);
              if typ=2 then ferme_pn_socket(i);
            end;
          end;
        end;
      end
    end
    else
    if (adr2<>0) then
    begin
      // PN par zone de détection
      // Affiche(intToSTR(adr)+'/'+intToSTR(adr2)+' '+intToSTR(etat),clyellow);
      if Tablo_PN[i].nbvoies>5 then Tablo_PN[i].nbvoies:=5;
      for v:=1 to Tablo_PN[i].nbvoies do
      begin
        dZ1F:=Tablo_PN[i].voie[v].detZ1F;
        dZ2F:=Tablo_PN[i].voie[v].detZ2F;
        dZ1O:=Tablo_PN[i].voie[v].detZ1O;
        dZ2O:=Tablo_PN[i].voie[v].detZ2O;
        if debugPN then Affiche('test ouvre '+intToSTR(Adr)+' '+intToSTR(adr2)+' '+intToSTR(etat),clwhite);
        if (dZ1O =adr) and (dZ2O=adr2) and (etat=0) then  // zone d'ouverture
        begin
          if Tablo_PN[i].compteur=1 then
          begin
            sDecl:='Ouverture PN'+intToSTR(i)+' par zone '+intToSTr(adr)+' '+intToSTR(adr2);
            Affiche(sDecl,clwhite);
            if tablo_pn[i].TypeCde=0 then  // par accessoire
            begin
              if Tablo_PN[i].pulse=1 then ts:=aigP else ts:=signal;
              pilote_acc(Tablo_PN[i].AdresseOuvre,Tablo_PN[i].CommandeOuvre,ts);
            end
            else
            begin
              typ:=Tablo_PN[i].AdresseFerme;  // numéro accessoire
              typ:=com_socket(typ);
              if typ=1 then ouvre_pn_usb(i);
              if typ=2 then ouvre_pn_socket(i);
            end;
          end;
          if tablo_pn[i].compteur>0 then
          begin
            dec(tablo_pn[i].compteur);
            if debugPN then Affiche('Compteur PN'+intToSTR(i)+'='+intToSTR(tablo_pn[i].compteur),clwhite);
          end;
        end;

        if debugPN then Affiche('test ferme '+intToSTR(Adr)+' '+intToSTR(adr2)+' '+intToSTR(etat),clwhite);
        if (dZ1F=adr) and (dZ2F=adr2) and (etat=1) then  // zone de fermeture
        begin
          inc(Tablo_PN[i].compteur);
          if debugPN then Affiche('Compteur PN'+intToSTR(i)+'='+intToSTR(tablo_pn[i].compteur),clwhite);
          if tablo_pn[i].compteur=1 then
          begin
            sDecl:='Fermeture PN'+IntToSTR(i)+' par zone '+intToSTr(adr)+' '+intToSTR(adr2)+' (train voie '+IntToSTR(v)+')';
            affiche(sDecl,clwhite);
            if tablo_pn[i].TypeCde=0 then  // par accessoire
            begin
              if Tablo_PN[i].pulse=1 then ts:=aigP else ts:=signal;
              pilote_acc(Tablo_PN[i].AdresseFerme,Tablo_PN[i].CommandeFerme,ts);
            end
            else
            begin
              typ:=Tablo_PN[i].AdresseFerme;  // numéro accessoire
              typ:=com_socket(typ);
              if typ=1 then ferme_pn_usb(i);
              if typ=2 then ferme_pn_socket(i);
            end;
          end;
        end;
      end;
    end;
  end;

  // envoyer au périphérique le service actionneur
  for i:=1 to NbPeriph do
  begin
    sDecl:='A'+intToSTR(adr)+','+intToSTR(etat)+','+trainDecl;
    if Tablo_periph[i].ScvAct then
    begin
      v:=com_socket(i);
      if v=1 then
      begin
        if tablo_periph[i].portOuvert then
        begin
          if Tablo_periph[i].ScvVis then Affiche(sDecl,clWhite);
          if Tablo_periph[i].cr then sDecl:=sDecl+#13;
          typ:=Tablo_periph[i].numComposant;
          if typ=1 then envoi_usb_comp(MSCommCde1,sDecl);
          if typ=2 then envoi_usb_comp(MSCommCde2,sDecl);
        end;
      end;

      if v=2 then
      begin
        if Tablo_periph[i].ScvVis then Affiche(sDecl,clWhite);
        if Tablo_periph[i].cr then sDecl:=sDecl+#13;
        typ:=Tablo_periph[i].numComposant;
        if typ=1 then Formprinc.ClientSocketCde1.Socket.SendText(sDecl);
        if typ=2 then Formprinc.ClientSocketCde2.Socket.SendText(sDecl);
      end;
    end;
  end;

  // Serveur envoi au clients
  Envoi_serveur('A'+intToSTR(adr)+','+intToSTR(etat)+','+trainDecl);
end;

Procedure affiche_memoire;
var s: string;
begin
  s:='Mém evt: '+IntToSTR(100*N_Event_tick div Max_Event_det_tick)+' %';
  FormPrinc.StatusBar1.Panels[3].Style:=psText; // sans event
  FormPrinc.StatusBar1.Panels[2].text:=s;
end;

procedure evalue;
begin
  if nivDebug=1 then AfficheDebug('Proc evalue',clorange);
  if not(configNulle) then Maj_Signaux(false);  // on ne traite pas les calculs si CDM en envoie plusieurs
end;


// traitement des évènements détecteurs
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
var dr,i,AdrSuiv,AdrSignal,AdrDetSignal,index,Etat01,AdrPrec : integer;
    typeSuiv : tequipement;
    s : string;
begin
  if adresse>NbMaxDet then
  begin
    Affiche('Erreur 82 : reçu adresse de détecteur trop grande : '+intToSTR(adresse),clred);
    exit;
  end;

  if index_adresse_detecteur(Adresse)=0 then
  begin      // si détecteur inexistant. Peut être renvoyé par la centrale dans un groupe de 4 détecteurs
    exit;
  end;

  // vérifier si front descendant pour filtrage
  if filtrageDet0<>0 then
  begin
    dr:=detecteur[adresse].tempo0;
    if (detecteur[Adresse].etat and not(etat)) and (dr=0) then
    begin
      // init de la tempo
      detecteur[adresse].tempo0:=filtrageDet0;
      exit;
    end;
    // si tempo échue (99)
    if dr=99 then detecteur[adresse].tempo0:=0;

    // si détecteur passe à 1 et qu'un filtrage à 0 est en cours, annuler le 0
    if etat and (dr<>0) then
    begin
      Affiche_Evt('Détecteur '+intToSTR(adresse)+' à 0 annulé par le filtrage',clorange);
      detecteur[adresse].tempo0:=0;
    end;
  end;

  s:=detecteur[adresse].train;
  if (train='') and (s<>'') then train:=s;
  if Etat then Etat01:=1 else Etat01:=0;
  //Affiche('Event Det '+inTToSTR(adresse)+' '+IntToSTR(etat01),Cyan);
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
  if Traceliste or ProcPrinc then AfficheDebug('--------------- détecteur '+intToSTR(Adresse)+' à '+intToSTR(etat01)+' par train'+Detecteur[adresse].Train+' -----------------------',clOrange);
  if AffAigDet then
  begin
    //s:='Evt Det '+intToSTR(adresse)+'='+intToSTR(etat01);
    s:='Tick='+IntToSTR(tick)+' Evt Det='+IntToSTR(adresse)+'='+intToSTR(etat01)+' Train='+train;
    AfficheDebug(s,clyellow);
  end;
  if AFfDetSIg then AfficheDebug('Tick='+IntToSTR(tick)+' Evt Det='+IntToSTR(adresse)+'='+intToSTR(etat01),clOrange);

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
  event_det_tick[N_event_tick].adresse:=Adresse;
  event_det_tick[N_event_tick].modele:=det;
  event_det_tick[N_event_tick].etat:=etat01;
  if (n_Event_tick mod 10) =0 then affiche_memoire;
  // Affiche('stockage de '+intToSTR(N_event_tick)+' '+IntToSTR(Adresse)+' à '+intToSTR(etat01),clyellow);

  // compter le nombre de détecteurs à 1 simultanément
  NbDet1:=0;
  for i:=1 to NDetecteurs do
  begin
    dr:=Adresse_detecteur[i];
    if Detecteur[dr].etat then inc(NbDet1);
  end;

  // détection front montant
  if not(ancien_detecteur[Adresse]) and (detecteur[Adresse].etat) then
  begin
    if AffFD then AfficheDebug('Tick='+intToSTR(tick)+' Index='+intToSTR(N_event_tick)+' FM '+intToSTR(Adresse),clyellow);
    inc(N_event_det);
    if algo_localisation=1 then event_det[N_event_det].adresse:=Adresse;
    event_det[N_event_det].etat:=true;

    if not(confignulle) then
    //explore les signaux pour voir si on démarre d'un buttoir
    for i:=1 to NbreSignaux do
    begin
      AdrSignal:=Signaux[i].Adresse;
      AdrDetSignal:=Signaux[i].Adr_Det1;
      if (AdrDetSignal=Adresse) and not(isDirectionnel(i)) then
      begin
        AdrSuiv:=Signaux[i].Adr_el_suiv1;
        TypeSuiv:=Signaux[i].Btype_suiv1;
        if AffSignal then AfficheDebug('Pour signal '+intToSTR(AdrSignal)+' detecteursuivant('+intToSTR(AdrSuiv)+','+BTypeToChaine(typeSuiv)+','+intToSTR(AdrDetSignal)+',1)',clyellow);
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetSignal,det,1) ; // détecteur précédent le feu, algo 1
        if AdrPrec=0 then
        begin
          If traceListe then AfficheDebug('Le signal '+IntToSTR(AdrSignal)+' est précédé d''un buttoir',clyellow);
          MemZone[0,AdrDetSignal].etat:=true;
          event_act(0,AdrDetSignal,1,'',false);             // activation zone
          Maj_Signal_P(AdrSignal,false);
        end;
      end;
    end;

    // gérer l'évènement actionneur pour action
    if etat then i:=1 else i:=0;
    if not(confignulle) then calcul_zones(adresse,true);
    event_act(Adresse,0,i,'',false);
  end;

  // détection fronts descendants
  if ancien_detecteur[Adresse] and not(detecteur[Adresse].etat) and (N_Event_det<Max_event_det) then
  begin
    // si le FD du détecteur a déjà été stocké à l'index précédent ne pas en tenir compte
    //if event_det[N_event_det]<>Adresse then
    begin
      if AffFD then AfficheDebug('Tick='+intToSTR(tick)+' Index='+intToSTR(N_event_tick)+' FD '+intToSTR(Adresse),clyellow);
      inc(N_event_det);
      if algo_localisation=1 then event_det[N_event_det].adresse:=Adresse;
      event_det[N_event_det].etat:=false;

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
              Affiche('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',ClOrange);
              AfficheDebug('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',ClOrange);
            end;
          end;
        end;
      end;
      premierFD:=True;

      // gérer l'évènement detecteur pour action
      if etat then i:=1 else i:=0;
      if not(confignulle) then calcul_zones(adresse,false);
      event_act(Adresse,0,i,train,false);
    end;
  end;

  if (N_event_det>=Max_event_det) then
  begin
    Affiche('Débordement d''évènements FD - Raz tampon',clred);
    N_event_det:=0;
    FormDebug.MemoEvtDet.lines.add('Raz sur débordement');
  end;

  // Envoyer évent vers périphériques si le service est demandé
  for i:=1 to NbPeriph do
  begin
    dr:=com_socket(i);
    // envoyer event act au périphérique
    if dr=1 then
    begin
      if (tablo_periph[i].portOuvert) and (Tablo_periph[i].ScvDet) then
      begin
        s:='D'+intToSTR(adresse)+','+intToSTR(etat01)+','+train;
        if Tablo_periph[i].ScvVis then Affiche(s,clWhite);
        if Tablo_periph[i].cr then s:=s+#13;
        index:=Tablo_periph[i].NumComposant;
        if index=1 then envoi_usb_comp(MSCommCde1,s);
        if index=2 then envoi_usb_comp(MSCommCde2,s);

      end;
    end;
    if dr=2 then
    begin
      if (Tablo_periph[i].ScvDet) then
      begin
        s:='D'+intToSTR(adresse)+','+intToSTR(etat01)+','+train;
        if Tablo_periph[i].ScvVis then Affiche(s,clWhite);
        if Tablo_periph[i].cr then s:=s+#13;
        index:=Tablo_periph[i].NumComposant;
        if index=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
        if index=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
      end;
    end;
  end;

  // Serveur envoi au clients
  Envoi_serveur('D'+intToSTR(adresse)+','+intToSTR(etat01)+','+train);

  // Maj TCOs
  for i:=1 to nbreTCO do
  begin
    if PCanvasTCO[i]<>nil then Maj_TCO(i,Adresse);
  end;

end;

// note: si on pilote un aiguillage par signaux complexes vers CDM et que celui ci est inversé,
// on recoit un evt de CDM de l'aiguillage dans le mauvais sens.
// par contre si on pilote cet aiguillage dans CDM, on le recoit dans le bon sens.
// évènement d'aiguillage (accessoire)
// pos = const_droit=2 ou const_devie=1
procedure Event_Aig(adresse,pos : integer);
var s: string;
    faire_event,inv,bjd : boolean;
    prov,index,i,id,etatact,typ,adr : integer;
begin
  //if AffAigDet then Affiche('Tick='+IntToSTR(tick)+' Event Aig '+intToSTR(adresse)+'='+intToSTR(pos),clorange);
  index:=index_aig(adresse);
  if index<>0 then
  begin
    // si l'aiguillage est inversé dans CDM et qu'on est en mode autonome ou CDM, inverser sa position
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

    if AffAigDet then
    begin
      s:='Tick='+IntToSTR(tick)+' Evt Aig '+intToSTR(adresse)+'='+intToSTR(pos);
      case pos of
        const_droit : s:=s+' droit';
        const_devie : s:=s+' dévié';
        const_inconnu : s:=s+' inconnu';
      end;
      if inv then s:=s+' INV';
      AfficheDebug(s,clyellow);
      FormDebug.MemoEvtDet.lines.add(s) ;
    end;

    if (n_Event_tick mod 10) =0 then affiche_memoire;
    inc(N_Event_tick);
    event_det_tick[N_event_tick].tick:=tick;
    event_det_tick[N_event_tick].adresse:=adresse;
    event_det_tick[N_event_tick].modele:=aig;
    event_det_tick[N_event_tick].etat:=pos;

    // l'évaluation des routes est à faire selon conditions
    if faire_event and not(confignulle) then
    begin
      evalue;evalue;evalue;
    end;
  end

  else if AffAigND then affiche('Avertissement 47 : un evt aiguillage '+intToSTR(adresse)+' non déclaré a été reçu',clOrange);

  // evt actionneur d'aiguillage
  for i:=1 to maxTablo_act do
  begin
    etatAct:=Tablo_actionneur[i].etat ;
    adr:=Tablo_actionneur[i].adresse;
    typ:=Tablo_actionneur[i].typdeclenche;
    if (typ=2) and (Adr=adresse) then event_act(Adresse,0,pos,'',false); // évent aig
  end;

  // pour périphériques
  for i:=1 to NbPeriph do
  begin
    // envoyer event act à accessoire
    typ:=com_socket(i);
    if typ=1 then
    begin
      if tablo_periph[i].portOuvert then
      begin
        if Tablo_periph[i].ScvAig then
        begin
          s:='T'+intToSTR(adresse)+','+intToSTR(pos);
          if Tablo_periph[i].ScvVis then Affiche(s,clWhite);
          if Tablo_periph[i].cr then s:=s+#13;
          id:=Tablo_periph[i].NumComposant;
         //jeans if id=1 then envoi_usb(periph1,s);
         // if id=2 then envoi_usb(periph2,s);
         if id=1 then envoi_usb_comp(MSCommCde1,s);
         if id=2 then envoi_usb_comp(MSCommCde2,s);

        end;
      end;
    end;
    if typ=2 then
    begin
      if Tablo_periph[i].ScvAig then
      begin
        s:='T'+intToSTR(adresse)+','+intToSTR(pos);
        if Tablo_periph[i].ScvVis then Affiche(s,clWhite);
        if Tablo_periph[i].cr then s:=s+#13;
        id:=Tablo_periph[i].NumComposant;
        if id=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
        if id=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
      end;
    end;
  end;

  // Serveur envoi au clients
  Envoi_serveur('T'+intToSTR(adresse)+','+intToSTR(pos));

  // Si aiguillage de bjd
  bjd:=false;
  begin
    for i:=1 to MaxAiguillage do
    begin
      if (aiguillage[i].AdrCDM=adresse) then
      begin
        bjd:=true;
        aiguillage[i].position:=pos;    // stockage de la nouvelle position de l'aiguillage
      end;
    end;
    if bjd then evalue;
  end;

  // Mettre à jour les TCOs
  for i:=1 to NbreTCO do Maj_TCO(i,Adresse);
end;

// pilote une sortie à 0 à l'interface dont l'adresse est à 1 ou 2 (octet)
procedure Pilote_acc0_X(adresse : integer;octet : byte);
var groupe : integer ;
    fonction : byte;
    s : string;
begin
  if (portCommOuvert or parSocketLenz) then
  begin
    if debug_dec_sig then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet)+' à 0',clorange);
    if protocole=1 then
    begin
      groupe:=(adresse-1) div 4;
      fonction:=((adresse-1) mod 4)*2 + (octet-1);
      s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
      s:=checksum(s);
      envoi(s);     // envoi de la trame à l'interface et attente Ack
    end;
    if protocole=2 then
    begin
      //la RAZ d'une sortie n'existe pas en DCC+!
    end;
  end;
end;

// envoi d'une chaîne Com_IPC à CDM par socket, puis attend l'ack ou le nack
function envoi_CDM(s : string) : boolean;
var temps : integer;
begin
  if CDM_connecte=false then begin envoi_CDM:=false;exit;end;
  if traceTrames then afficheDebug(s,clLime);
  Formprinc.ClientSocketCDM.Socket.SendText(s);
  // attend l'ack
  ackCDM:=false;nackCDM:=false;
  temps:=0;

  repeat
    inc(temps);
    Sleep(50);
    Application.processMessages;       
  until fermeSC or ackCDM or nackCDM or (temps>20); // CDM répond < 1s
  //Affiche(intToSTR(temps),clred);
  if not(ackCDM) or nack then
  begin
    Affiche('Pas de réponse de CDM Rail',clRed);
  end;

  envoi_CDM:=ackCDM;
end;


// pilotage d'un accessoire (décodeur d'aiguillage, de signal) et génère l'event aig
// par CDM ou interface
// octet = 1 (dévié) ou 2 (droit) si 0 on ne traite pas
// uniquement en mode autonome:
// si acc=Taig, alors la sortie "octet" est mise à 1 puis à 0
// si acc=signal,  alors la sortie "octet" est mise à 1 uniquement.
// Résultat true si ok
function pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire): boolean;
var  groupe,temp,indexAig,AdrTrain : integer ;
     fonction,pilotage,pilotageCDM : byte;
     s : string;
begin
  //Affiche(IntToSTR(adresse)+' '+intToSTr(octet),clYellow);
  if adresse=0 then
  begin
    result:=false;
    exit;
  end;
  pilotage:=octet;
  // test si pilotage aiguillage inversé
  if (acc=aigP) then
  begin
    indexAig:=index_aig(adresse);
    if indexAig<>0 then
    begin
      AdrTrain:=aiguillage[indexAig].AdrTrain;
      if AdrTrain<>0 then
      begin
        Affiche('Pilotage impossible, l''aiguillage '+intToSTR(adresse)+' est réservé par le train @'+intToSTR(AdrTrain),clred);
        Result:=false;
        exit;
      end;
      if (aiguillage[indexAig].inversionCDM=1) then
      begin
        if octet=1 then pilotage:=2 else pilotage:=1;
      end;
    end;
  end;

  // pilotage par CDM rail -----------------
  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(pilotage),clorange);
    //if aff_acc then
    Affiche('Accessoire '+intToSTR(adresse)+' à '+intToSTR(pilotage),clorange);
    if pilotage=1 then pilotageCDM:=1;     // 3 = wrong state or value
    if pilotage=2 then pilotageCDM:=2;

    s:=chaine_CDM_Acc(adresse,pilotageCDM);
    envoi_CDM(s);

    event_aig(adresse,pilotage);
    result:=true;
    exit;
  end;

  if (pilotage=0) or (pilotage>2) then begin result:=true;exit;end;

  // pilotage par USB ou par éthernet de la centrale ------------
  if (portCommOuvert or parSocketLenz) then
  begin
    if hors_tension then
    begin
      Affiche('Voie hors tension, pas de pilotage d''accessoires',clRose);
      result:=false;
      exit;
    end;

    if protocole=1 then // xpressnet
    begin
      groupe:=(adresse-1) div 4;
      fonction:=((adresse-1) mod 4)*2 + (pilotage-1);
      // pilotage à 1
      s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
      s:=checksum(s);
      if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(pilotage),clorange);
      envoi(s);     // envoi de la trame et attente Ack
      event_aig(adresse,pilotage);

      // si l'accessoire est un signal et sans raz des signaux, sortir
      if (acc=signal) and not(Raz_Acc_signaux) then exit;

      // si aiguillage, faire une temporisation
      //if (Index_Signal(adresse)=0) or (Acc=aig) then
      if Acc=AigP then
      begin
        temp:=aiguillage[indexAig].temps;if temp=0 then temp:=4;
        if portCommOuvert or parSocketLenz then tempo(temp);
      end;
      //sleep(50);
      // pilotage à 0 pour éteindre le pilotage de la bobine du relais
      s:=#$52+Char(groupe)+char(fonction or $80);  // désactiver la sortie
      s:=checksum(s);
      if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
      envoi(s);     // envoi de la trame et attente Ack
      result:=true;
      exit;
    end;

    if protocole=2 then  // dcc++
    begin
      event_aig(adresse,pilotage);
      // en pilotage, on envoie que l'ID cad l'adresse - 0=droit 1=dévié
      if pilotage=const_devie then fonction:=1;
      if pilotage=const_droit then fonction:=0;
      //affiche_retour_DCC:=true;
      s:='<T '+intToSTR(adresse)+' '+intToSTR(fonction)+'>';
      //Affiche(s,clYellow);
      envoi(s);
      result:=true;
      exit;
    end;
  end;

  // pas de centrale et pas CDM connecté: on change la position de l'aiguillage
  if acc=aigP then event_aig(adresse,octet)
  else
  // Serveur envoi au clients
  Envoi_serveur('T'+intToSTR(adresse)+','+intToSTR(octet));

  result:=true;
end;


// le décodage de la rétro XpressNet est appelé sur une réception d'une trame de la rétrosignalisation de la centrale.
// On déclenche ensuite les évènements détecteurs ou aiguillages.
// valeur = ITTN ZZZZ
// var globale modeStkRetro=false = stockage sur changement d'état, et génère évènement détecteur
//                          true  = stockage de l'état sans évènement
procedure decode_retro_XpressNet(adresse,valeur : integer);
var  s : string;
     adraig,bitsTT,i,n : integer;
     etat : boolean;
begin
  //afficheDebug(IntToSTR(adresse)+' '+intToSTR(valeur),clorange);
  bitsTT:=valeur and $60;  // 0110 0000
  n:=valeur and $10;
  // bit à 010X XXXX = c'est un module de rétrosignalisation (pas un aiguillage)
  // doc LENZ Xpressnet protocol description page 31
  detecteur_chgt:=0;

  // ---------- Cas N=1, les 4 bits de poids faible sont les 4 bits de poids fort du décodeur
  if n=$10 then
  begin
    // détermine le détecteur qui a changé d'état
    // -------état du détecteur
    if bitsTT and $40=$40 then // TT=10 l'adresse est un module de rétro = détecteur
    begin
      // affecter l'état des détecteurs
      i:=adresse*8+8;
      etat:=(valeur and $8) = $8;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 7
      begin
        Event_detecteur(i,etat,'');  // pas de train affecté sur le décodage de la rétrosignalisation
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+7;
      etat:=(valeur and $4) = $4;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+6;
      etat:=(valeur and $2) = $2;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+5;
      etat:=(valeur and $1) = $1;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      retEtatDet:=true;
    end;

    // état de l'aiguillage
    if (bitsTT=$00) or (bitsTT=$20) then // TT=00 ou TT=01 l'adresse est un décodeur d'accessoires sans(TT=00)/avec(TT=01) rétrosignalisation, avec N=1
    begin
      adraig:=((adresse * 4)+1 ); // *4 car N=1, c'est le "poids fort"
      if (valeur and $C)=$8 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+3)+'=2';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig+3,const_droit);
      end;
      if (valeur and $C)=$4 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+3)+'=1';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig+3,const_devie);
      end;
      if ((valeur and $C)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig+3)+' indéfini';AfficheDebug(s,clYellow);end;

      if (valeur and $3)=$2 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+2)+'=2';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig+2,const_droit);
      end;
      if (valeur and $3)=$1 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+2)+'=1';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig+2,const_devie);
      end;
      if ((valeur and $3)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig+2)+' indéfini';AfficheDebug(s,clYellow);end;
    end;
  end;

  // ---------- Cas N=0
  if n=0 then // si bit N=0, les 4 bits de poids faible sont les 4 bits de poids faible du décodeur
  begin
    //Affiche('N=0',clYellow);
    if (bitsTT and $40)=$40 then  // TT=10 l'adresse est un module de rétro = détecteur avec N=0
    begin
      // affecter l'état des détecteurs
      i:=adresse*8+4;
      etat:=(valeur and $8) = $8;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+3;
      etat:=(valeur and $4) = $4;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+2;
      etat:=(valeur and $2) = $2;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+1;
      etat:=(valeur and $1) = $1;
      if detecteur[i].etat<>etat then  // si changement de l'état du détecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;
      retEtatDet:=true;  // marqueur "reçu état détecteur"
    end;

    if (bitsTT=$00) or (bitsTT=$20) then // TT=00 ou TT=01 l'adresse est un décodeur d'accessoires sans(TT=00)/avec(TT=01) rétrosignalisation, avec N=0
    begin
      adraig:=(adresse * 4)+1;
      if (valeur and $C)=$8 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+1)+'=2';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig+1,const_droit);
      end;
      if (valeur and $C)=$4 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig+1)+'=1';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig+1,const_devie);
      end;
      if ((valeur and $C)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig+1)+' indéfini';AfficheDebug(s,clYellow);end;

      if (valeur and $3)=$2 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig)+'=2';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig,const_droit);
      end;
      if (valeur and $3)=$1 then
      begin
        if traceTrames then begin s:='accessoire '+intToSTR(adraig)+'=1';AfficheDebug(s,clYellow);end;
        Event_Aig(adraig,const_devie);
      end;
      if ((valeur and $3)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig)+' indéfini';AfficheDebug(s,clYellow);end;
    end;
  end;
end;

// renvoi le nombre de paramètres dans une chaine DCC++ entre le premier < >
function nombre_parametres(s : string) : integer;
var i,j,n : integer;
begin
  i:=1;n:=0;
  j:=pos('>',s);
  repeat
    i:=posEx(' ',s,i);
    if i<>0 then begin inc(n);inc(i);end;
  until (i=0) or (i>j);
  result:=n;
end;

// décodage chaine au protocole DCC (un seul paramètre encadré par < > )
function decode_chaine_retro_dcc(chaineINT : string) : string;
var i,j,n,adresse,groupe,rang,valeur,erreur : integer;
    b : byte;
    s : string;
begin
  if length(s)>0 then if chaineINT[1]=#$0D then delete(chaineINT,1,1);
  if length(s)>0 then if chaineINT[1]=#$0A then delete(chaineINT,1,1);

  i:=pos('<',chaineINT);
  j:=pos('>',chaineINT);
  if (i=0) or (j=0) then exit;

  n:=pos(#$0D,chaineINT);
  if n>j then delete(chaineINT,n,1);
  n:=pos(#$0A,chaineINT);
  if n>j then delete(chaineINT,n,1);

  if i>1 then delete(chaineINT,1,i-1);

  ack:=chaineINT<>'';
//  Affiche(copy(chaineINT,i,j-i+1),clblue);

  if affiche_retour_dcc then Affiche(copy(chaineINT,i,j-i+1),clOrange);

  if pos('DCC',chaineINT)<>0 then
  begin
    version_Interface:=chaineINT;
    delete(chaineINT,i,j-i+1);
    result:=chaineINT;
    exit;
  end;

  // rien
  i:=pos('<N',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,j);
    result:=chaineINT;
    exit;
  end;

  // réponse écriture eprom
  i:=pos('<e',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  // eprom vide
  i:=pos('<0>',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,i,j-i);
    result:=chaineINT;
    exit;
  end;

  // détecteur 1 (Q ID) ou réponse à un détecteur si 3 paramètres (Q ID PIN PULLUP)
  i:=pos('<Q',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i=erreur then // 1 seul paramètre
    begin
      if i<>0 then delete(chaineINT,1,i);
      result:=chaineINT;
      Event_detecteur(valeur+AdrBaseDetDccpp,true,'');  // pas de train affecté
      exit;
    end;
    // sinon 3 paramètres
    if i<>0 then delete(chaineINT,1,i);
    exit;
  end;

  // détecteur 0
  i:=pos('<q',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    Event_detecteur(valeur+AdrBaseDetDccpp,false,'');  // pas de train affecté
    exit;
  end;

  // réponse à la demande de mise sous tension ou hors tension de la voie
  i:=pos('<p',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+1);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  // Ok
  i:=pos('<O>',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,i,3);
    result:=chaineINT;
    exit;
  end;


  // o
  i:=pos('<o',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,N_modules_dcc,erreur);
    Affiche('Nombre de modules s88='+intToSTR(N_modules_dcc),clyellow);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  // réponse à la commande <Y nombre format>
  // y  détecteurs
  //  <y 00001010000101000111010000>     format 0
  //  <y 0A0147405801CE..40›             format 1 quartets renversés
  //  <y XXXXX......›       (hexa pur)   format 2
  //  <Q ID>                             format 3
  //
  i:=pos('<y',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    if (formatY=0) or (formatY=-1) then
    begin
      i:=0;
      repeat
        if chaineINT[1]='0' then valeur:=0 else valeur:=1;
        delete(chaineINT,1,1);
        Event_detecteur(AdrBaseDetDccpp+i,valeur=1,'');
        //affiche(intToSTR(513+i),clyellow);
        inc(i);
      until (chaineINT[1]='>') or (length(chaineINT)=1);
    end;

    if formatY=1 then
    begin
      j:=0;
      repeat
        val('$'+copy(chaineINT,1,2),b,erreur);
        delete(chaineINT,1,2);
        b:=inverseQuartet(b);
        for i:=7 downto 0 do
        begin
          event_detecteur(AdrBaseDetDccpp+j,testbit(b,i),'');
          inc(j);
        end;
      until length(chaineINT)<=1;
    end;

    if formatY=2 then
    begin
      j:=0;
      repeat
        val('$'+copy(chaineINT,1,2),b,erreur);
        delete(chaineINT,1,2);
        for i:=7 downto 0 do
        begin
          event_detecteur(AdrBaseDetDccpp+j,testbit(b,i),'');
          inc(j);
        end;
      until length(chaineINT)<=1;
    end;
    delete(chaineINT,1,1);
    result:=chaineINT;
    formatY:=-1;
    exit;
  end;

  // Nok
  i:=pos('<X>',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,i,3);
    result:=chaineINT;
    exit;
  end;

  // réponse à un aiguillage ou à leur définition
  i:=pos('<H',chaineINT);
  if i<>0 then
  begin
    // détermine le nombre de paramètres
    delete(chaineINT,1,i+1);
    n:=nombre_parametres(chaineINT);
    if n=4 then // position d'un aiguillage, réponse à <T>
    begin
      val(chaineINT,adresse,erreur);
      delete(chaineINT,1,erreur);
      val(chaineINT,groupe,erreur);
      delete(chaineINT,1,erreur);
      val(chaineINT,rang,erreur);
      delete(chaineINT,1,erreur);
      val(chaineINT,valeur,erreur);
      j:=const_inconnu;
      if valeur=0 then j:=const_droit;
      if valeur=1 then j:=const_devie;
      i:=index_aig(adresse);
      if i<>0 then aiguillage[i].position:=j
      else affiche('Erreur 70 : Aiguillage '+intToSTR(adresse)+' envoyé par la centrale non défini dans signaux_complexes',clred);
      if affiche_aigdcc then
      begin
        s:='Aiguillage '+intToSTR(adresse)+':';
        if j=const_droit then s:=s+'droit';
        if j=const_devie then s:=s+'devie';
        Affiche(s,clyellow);
      end;
    end;
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  // réponse à une demande de vitesse loco
  i:=pos('<T',chaineINT);   // <t 4 4 9 7 1>   ou <t 4 9 7>
  if i<>0 then
  begin
    delete(chaineINT,1,i+1);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  // réponse à la programmation d'un CV
  i:=pos('<r',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+1);
    j:=pos('|',chaineINT);
    j:=posEx('|',chaineINT,j+1);
    delete(chaineINT,1,j);
    val(chaineINT,valeur,erreur);
    tablo_cv[1]:=valeur;
    recu_cv:=true;
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  // réponse aux définitions des sorties
  i:=pos('<Y',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    exit;
  end;

  if chaineINT<>'' then Affiche('Reçu commande inconnue :'+chaineINT,clred);
  result:='';
end;

// vérifie le checksum
function check(s : string;n : integer): boolean;
var x: byte;
    i,l : integer;
begin
  x:=0;
  i:=1;
  l:=length(s);
  if l>0 then
  begin
    repeat
      x:=x xor ord(s[i]);
      inc(i);
    until (i>l) or (i>n);
  end;

  result:=x=0;

end;

// décodage d'une chaine Xpressnet de la rétrosignalisation de la centrale
// la chaine peut être composée de plusieurs ordres, car on boucle, et être coupée.
// en sortie, la chaine chaineINT est supprimée de la partie traitée
function decode_chaine_retro_Xpress(chaineINT : string) : string ;
var msg,s : string;
    n,i,it,cvLoc,AdrTrainLoc,l,NOctets : integer;
    traite,connu: boolean;
begin
  //affiche(chaine_hex(chaineINT),clOrange);
  msg:='';
  ack:=true;nack:=false;
  it:=0;

  if length(chaineINT)>3 then
  repeat
    inc(it);
    //AfficheDebug('It='+IntToSTR(it),clLime);
    connu:=false;
    traite:=false;

    if length(chaineINT)>4 then
    begin
      // supprimer l'entete éventuelle FFFE ou FFFD
      if (chaineINT[1]=#$ff) and ((chaineINT[2]=#$fe) or (chaineINT[2]=#$fd)) then Delete(chaineINT,1,2);
    end;

    l:=length(chaineINT);

    if (chaineINT[1]=#$01) then
    begin
      nOctets:=3;
      connu:=true;
      if (l>=nOctets) then
      begin
        if check(chaineINT,nOctets) then
        begin
          case chaineINT[2] of   // page 13 doc XpressNet
            #$01 :  begin nack:=true;msg:='Erreur timout transmission';end;
            #$02 :  begin nack:=true;msg:='Erreur timout centrale';end;
            #$03 :  begin nack:=true;msg:='Erreur communication inconnue';end;
            #$04 :  begin succes:=true;msg:='Succès';end;
            #$05 :  begin nack:=true;msg:='Plus de time slot';end;
            #$06 :  begin nack:=true;msg:='Débordement tampon LI100';end;
          end;
          if traceTrames and (chaineINT[2]=#4) then AfficheDebug(msg,clYellow);
          if traceTrames and (chaineINT[2]<>#4) then AfficheDebug(msg,clRed);

          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end
    else

    if (chaineINT[1]=#$02) then
    begin
      connu:=true;
      nOctets:=4;
      if (l>=nOctets) then
      begin
        if check(chaineINT,nOctets) then
        begin
          msg:='Version matérielle '+intTohex(ord(chaineINT[2]),2)+' - Version soft '+intToHex(ord(chaineINT[3]),2);
          Affiche(msg,clYellow);
          version_Interface:=chaineInt;
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end
    else

    // accessory decodeur information response $40+N 40 N=1 à 14
    if (ord(chaineINT[1]) and $F0)=$40 then
    begin
      connu:=true;
      n:=ord(chaineINT[1]) and $0F;  // nombre d'octets (doit être pair)
      nOctets:=n+2;
      if (l>=nOctets) then
      begin
        if check(chaineINT,nOctets) then
        begin
          n:= n div 2;
          for i:=1 to n do
          begin
            decode_retro_XpressNet(ord(chaineInt[i*2]),ord(chaineInt[i*2+1]));
          end;
          traite:=true;
        end
        else
        begin
          s:='ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets));
          if TraceTrames then AfficheDebug(s,clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end
    else


    // recu 61 01 60
    if (chaineINT[1]=#$61)  then
    begin
      nOctets:=3;
      connu:=true;
      if l>nOctets then
      begin
        if check(chaineINT,nOctets) then
        begin
          case chaineINT[2] of
            #$00 : begin ack:=true;msg:='Voie hors tension';end;
            #$01 : begin ack:=true;msg:='Reprise';Hors_tension:=false;end;

            #$02 : begin ack:=true;msg:='Mode programmation ';end;

            #$11 : begin nack:=true;msg:='Voie prog Station prête';end;
            #$12 : begin ack:=true;msg:='Voie prog court-circuit';Hors_tension:=false;end;
            #$13 : begin ack:=true;msg:='Voie prog octet non trouvé';end;
            #$1F : begin nack:=true;msg:='Voie prog Station occupée - Voir doc XpressNet p29';end;

            #$80 : begin nack:=true;msg:='Erreurs de transferts (Chk erroné) - Voir doc XpressNet p29';end;
            #$81 : begin nack:=true;msg:='Station occupée - Voir doc XpressNet p29';end;
            #$82 : begin nack:=true;msg:='Commande non implantée';end;

            else begin nack:=true;msg:='Réception inconnue';end;
          end;
          if nack then affiche(msg,clred) else affiche(msg,clyellow);
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end
    else

    if (chaineINT[1]=#$63) then    // V3.6 uniquement
    begin
      connu:=true;
      nOctets:=5;
      if (l>=nOctets) then
      begin
        if check(chaineINT,nOctets) then
        begin
          if chaineINT[2]=#$14 then
          begin
            // réception d'un CV. DocXpressNet p26   63 14 01 03 chk
            cvLoc:=ord(chaineINT[3]);
            //Affiche('Réception CV'+IntToSTR(cvLoc)+' à '+IntToSTR(ord(chaineINT[2])),clyellow);
            if cvLoc>255 then Affiche('Erreur Recu CV>255',clRed)
            else
            begin
              tablo_cv[cvLoc]:=ord(chaineINT[4]);
              inc(N_Cv); // nombre de CV recus
            end;
            recu_cv:=true;
            traite:=true;
          end;
          if chaineINT[2]=#$10 then
          begin
            traite:=true;
          end;
          if chaineINT[2]=#$21 then
          begin
            traite:=true;
          end;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end
    else


    // 81 00 mise hors tension
    if (chaineINT[1]=#$81) then    // arrêt urgence  3 octets
    begin
      connu:=true;
      nOctets:=3;
      if (l>=3) then
      begin
        if check(chaineINT,nOctets) then
        begin
          Affiche('Voie hors tension msg1',clRed);
          Hors_tension:=true;
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end
    else

    // id  n
    // 83  5
    // 84  6
    // C5  7
    // C6  8
    // A3  5
    // A4  6

    if (chaineInt[1]=#$E1) then
    begin
      NOctets:=3;
      connu:=true;
      if (l>=NOctets) then
      begin
        if check(chaineINT,NOctets) then
        begin
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,NOctets)),clred);
        end;
        delete(chaineInt,1,NOctets);
      end;
    end
    else

    // E2  4

    // E3
    if (chaineInt[1]=#$E3) then
    begin
      connu:=true;
      nOctets:=5;
      if (l>=nOctets) then
      begin
        // la loco ah al est pilotée par le PC
        if check(chaineINT,nOctets) then
        begin
          if chaineInt[1]=#$40 then
          begin
          end;
          if chaineInt[2]=#$50 then
          begin
          end;
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineInt,1,nOctets);
      end;
    end
    else

    // E4 id speed FcA FcB xor    loco information
    if (chaineInt[1]=#$E4) then
    begin
      connu:=true;
      nOctets:=6;
      if (l>=nOctets) then
      begin
        if check(chaineINT,nOctets) then
        begin
          AdrTrainLoc:=ord(chaineInt[2]); // identification
          i:=ord(chaineInt[3]);  // vitesse
          Fa:=ord(chaineInt[4]); // fonction A
          Fb:=ord(chaineInt[5]); // fonction B
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineInt,1,nOctets);
      end;
    end
    else

    // E5  7
    // E6  8

    // spécifique Z21 : E7 0C 89 00 00 00 00 00 62
    // on n'en fait rien, c'est un genre d'ack à la réponse de stop loco ?
    if (chaineINT[1]=#$E7) then
    begin
      connu:=true;
      nOctets:=9;
      if (l>=nOctets) then
      begin
        if check(chaineINT,nOctets) then
        begin
          traite:=true;
        end
        else
        begin
          if TraceTrames then AfficheDebug('ErrCheck '+chaine_hex(copy(chaineINT,1,nOctets)),clred);
        end;
        delete(chaineINT,1,nOctets);
      end;
    end;

    // suppression du caractère inconnu car il n'a pas été traité
    if not(connu) then
    begin
      if traceTrames then AfficheDebug('Suppression '+chaine_Hex(copy(chaineINT,1,1)),clred);
      delete(chaineINT,1,1);
      traite:=true;
    end;

  until (length(chaineINT)<3) or not(traite) or (it>20); // conditions de sortie du repeat until

  if it>=20 then
  begin
    s:='Erreur 623 : itérations trames XpressNet';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    chaineINT:='';
  end;

  decode_chaine_retro_Xpress:=chaineINT;
end;

// procédure appellée après réception sur le port USB ou socket
// la chaine peut contenir plusieurs informations
// on boucle tant qu'on a pas traitée toute la chaine
function interprete_reponse(chaine : string): string;
var chaineInt: string;
    i,j : integer;
begin
  chaineINT:=chaine;
  if protocole=1 then
  begin
    chaineINT:=decode_chaine_retro_Xpress(chaineINT);
  end;

  if protocole=2 then
  begin
    i:=pos('<',chaineINT);
    j:=pos('>',chaineINT);
    while (i<>0) and (j<>0) do
    begin
      chaineINT:=decode_chaine_retro_dcc(chaineINT);
      i:=pos('<',chaineINT);
      j:=pos('>',chaineINT);
    end;
  end;

  interprete_reponse:=chaineINT;
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
var i : integer;
begin
  if Cdm_connecte then
  begin
    with formprinc do
    begin
      CDM_connecte:=False;
      ClientSocketCDM.close;
      LabelTitre.caption:=Titre;
      caption:=AF;
      MenuConnecterUSB.enabled:=true;
      DeConnecterUSB.enabled:=true;
      ConnecterCDMRail.enabled:=true;
      FormPrinc.ComboTrains.Items.Clear;
      for i:=1 to ntrains do ComboTrains.Items.Add(trains[i].nom_train);
      if ntrains>0 then
      begin
        ComboTrains.ItemIndex:=0;
        editadrtrain.Text:=inttostr(trains[1].adresse);
      end;
    end;
    Affiche('CDM rail déconnecté',clCyan);
    AfficheDebug('CDM rail déconnecté',clCyan);
    Formprinc.StatusBar1.Panels[2].text:='';
    filtrageDet0:=SauvefiltrageDet0;
  end;
end;

{$J+}
// vérifie si version OS32 bits ou OS64 bits
function IsWow64Process: Boolean;
type
  TIsWow64Process=function(hProcess: THandle; var Wow64Process: Boolean): Boolean; stdcall;
var
  Dll: THandle;
  pIsWow64Process: TIsWow64Process;
const
  IsWow64: Boolean=False;
begin
  IsWow64:=false;
  Dll:=LoadLibrary('kernel32.dll');
  if (Dll<>0) then
  begin
    pIsWow64Process:=GetProcAddress(DLL,'IsWow64Process');
    if (Assigned(pIsWow64Process)) then
    begin
      pIsWow64Process(GetCurrentProcess,IsWow64);
    end;
    FreeLibrary(Dll);
  end;
  Result:=IsWow64;
end;
{$J-}

procedure envoi_aiguillages_DCCpp;
var adr,groupe,fonction,i : integer;
    s :string;
begin
  Affiche('Envoi la liste des aiguillages à la centrale DCC++',clyellow);
  Affiche('',clyellow);
  for i:=1 to MaxAiguillage do
  begin
    adr:=aiguillage[i].adresse;
    groupe:=((adr-1) div 4)+1;
    fonction:=((adr-1) mod 4);
    s:='<T '+intToSTR(adr)+' '+intToSTR(groupe)+' '+intToSTR(fonction)+'>';
    Affiche_suivi(intToSTR(adr)+' ',clyellow);
    envoi(s);
  end;
end;

function test_protocole : boolean;
var s: string;
   temp : integer;
begin
  begin
    if protocole=1 then   // Xpressnet
    begin
      s:=#$f0;
      s:=checksum(s);
    end;
    if protocole=2 then s:='<s>';    // dcc++

    envoi_ss_ack(s);
    application.processMessages;

    temp:=0;
    repeat
      sleep(100);
      inc(temp);
      Application.processmessages;
    until (version_Interface<>'') or (temp>15);

    // result:=true;
    //      exit;

    if (temp>15) then
    begin
      s:=' mais l''interface n''a pas répondu ';
      if protocole=1 then s:=s+' en XpressNet';
      if protocole=2 then s:=s+' en DCC++';
      Affiche_suivi(s,clyellow);
      portCommOuvert:=false;  // refermer le port
      result:=false;
      exit;
    end
    else
    
    begin
      if length(version_interface)>0 then
      begin
        if (protocole=1) and (version_interface[1]=#2) then
        begin
          Affiche_suivi(' et l''interface a répondu correctement en '+intToSTR(temp)+'00 ms',clLime);
          result:=true;
          exit;
        end;
        if (protocole=2) and (version_interface<>'') then
        begin
          Affiche_suivi(' et l''interface a répondu correctement en '+intToSTR(temp)+'00 ms',clLime);
          result:=true;
          exit;
        end;
      end;
      Affiche_suivi(s+' mais l''interface a répondu incorrectement',clyellow);
      result:=false;
    end;
  end;
end;

// connecte un port usb pour la comm périphériques. Si le port n'est pas ouvert, renvoie false
function connecte_usb_periph(index : integer) : boolean;
var i,j,nc,numport,vitesse,erreur : integer;
    s,sc,portComCde : string;
    com : TMSComm;
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 60 : numéro de périphérique hors limite '+intToSTR(index),clred);
    exit;
  end;
  numport:=Tablo_periph[index].NumCom;
  if (numport<1) or (numport>255) then
  begin
    affiche('Erreur portCom cde acc <0 ou >255',clred);
    result:=false;
    exit;
  end;
  portComCde:=Tablo_periph[index].protocole;

  nc:=Tablo_periph[index].NumComposant;
  // voir si le composant est valide
  if MsCommCde1=nil then
  begin
    Affiche('Erreur 6001: le composant périphérique 1 n''est pas créé',clred);
    result:=false;
    exit;
  end;
  if MsCommCde2=nil then
  begin
    Affiche('Erreur 6002: le composant périphérique 2 n''est pas créé',clred);
    result:=false;
    exit;
  end;

  case nc of
  1 : com:=MSCommCde1;
  2 : com:=MSCommCde2;
  end;

  if nc>MaxComUSBPeriph then
  begin
    affiche('Le nombre maxi de portCom périphériques est atteint. Le port COM'+inttostr(Tablo_periph[index].NumCom)+' ne sera pas ouvert',clred);
    result:=false;
    exit;
  end;

  if debug=1 then Affiche('Test port com cde'+intToSTR(port),clLime);
  i:=pos(':',portComcde);
  j:=pos(',',PortComcde);
  j:=posEx(',',PortComcde,j+1);
  j:=posEx(',',PortComcde,j+1);

  sc:=copy(portComCde,i+1,j-i+1);
  val(sc,vitesse,erreur);
  if (vitesse<>300) and (vitesse<>1200) and (vitesse<>2400) and (vitesse<>4800) and (vitesse<>9600) and
     (vitesse<>19200) and (vitesse<>38400) and (vitesse<>57600) and (vitesse<>115200) and (vitesse<>128000) and (vitesse<>256000) then
  begin
    Affiche('Vitesse périphérique COM ('+intToSTR(vitesse)+') incorrecte',clred);
    tablo_periph[index].PortOuvert:=false;
    result:=false;
    exit;
  end;

  tablo_periph[index].PortOuvert:=true;
  With com do
  begin
    Settings:=sc;   // vitesse,n,8,1
    Handshaking:=0; {0=aucun 1=Xon-Xoff 2=cts 3=RTS-Xon-Xoff 4=5=protocoles "maison"}
    SThreshold:=1;
    RThreshold:=1;
    InputLen:=0;
    CommPort:=numport;
    DTREnable:=Tablo_periph[index].dtr;
    RTSEnable:=Tablo_periph[index].rts;

    InputMode:=comInputModeBinary;

  end;
  try
    com.portopen:=true;
  except
    tablo_periph[index].PortOuvert:=false;
  end;

  FormPrinc.StatusBar1.Panels[3].Style:=psOwnerDraw;  // permet de déclencher l'event onDrawPanel

  if tablo_periph[index].PortOuvert then
  begin
    s:='COM'+intToSTR(numport)+':'+sc;
    Formprinc.StatusBar1.Panels[3].Text:=s;
  end;
  result:=tablo_periph[index].PortOuvert;
end;

// détermine si le périphérique i est un comusb ou un socket
// =0 erreur
// =1 comusb
// =2 socket
function com_socket(i : integer) : integer;
var s : string;
begin
  result:=0;
  if (i=0) or (i>NbMaxi_Periph) then exit;
  s:=Tablo_periph[i].protocole;
  if pos('COM',uppercase(s))<>0 then result:=1;
  if Ipok(s) then result:=2;
end;

function connecte_socket_periph(index :integer) : boolean;
var s,sc,ip: string;
    i,erreur,NumSocket : integer;
    com : TClientSocket;
begin
  if (index<0) or (index>NbMaxi_Periph) then
  begin
    affiche('Le nombre maxi de périphériques est atteint - Le socket '+Tablo_periph[index].protocole+' ne sera pas ouvert',clred);
    result:=false;
    exit;
  end;

  numSocket:= Tablo_periph[index].numComposant;

  com:=nil;
  case numSocket of
  1 : com:=formprinc.ClientsocketCde1;
  2 : com:=formprinc.ClientSocketCde2;
  end;

  if (NumSocket>MaxComSocketPeriph) or (com=nil) then
  begin
    affiche('Le nombre maxi de Sockets périphériques est atteint - Le socket '+Tablo_periph[index].protocole+' ne sera pas ouvert',clred);
    result:=false;
    exit;
  end;

  s:=Tablo_periph[index].protocole;
  sc:=s;

  i:=pos(':',s);
  ip:=copy(s,1,i-1);
  if Ipok(ip)=false then
  begin
    Affiche('Erreur 538 : Adresse IP '+sc+' incorrecte',clred);
    result:=false;
    exit;
  end;
  com.address:=ip;
  delete(s,1,i);
  val(s,i,erreur);
  if (i<1) or (i>65535) then
   begin
    Affiche('Erreur 539 : port de l''adresse ip '+sc+' incorrect',clred);
    result:=false;
    exit;
  end;
  com.port:=i;
  com.open;
  result:=true;
end;

// connecte un port usb interface. Si le port n'est pas ouvert, renvoie 0, sinon renvoie
// le numéro de port
// affichage dans panel[3]
function connecte_port_usb(port : integer) : integer;
var i,j : integer;
    trouve,portOK : boolean;
    s,sc : string;
begin
  result:=0;
  trouve:=false;

  if MSCommUSBInterface=nil then
  begin
    Affiche('Erreur 6000: le composant interface n''est pas créé',clred);
    result:=0;
    exit;
  end;

  With MSCommUSBInterface do
  begin
    //if debug=1 then Affiche('Test port com'+intToSTR(port),clLime);
    version_interface:='';
    i:=pos(':',portCom);
    j:=pos(',',PortCom);
    j:=posEx(',',PortCom,j+1);
    j:=posEx(',',PortCom,j+1);
    j:=posEx(',',PortCom,j+1);

    sc:=copy(portCom,i+1,j-i-1);
    Settings:=sc;   // vitesse,n,8,1
    if prot_serie>=4 then Handshaking:=0 {0=aucun 1=Xon-Xoff 2=cts 3=RTS-Xon-Xoff 4=5=protocoles "maison"}
      else Handshaking:=prot_serie;
    SThreshold:=1;
    RThreshold:=1;
    InputLen:=0;
    portOK:=true;
    try
      CommPort:=Port;
    except
      Affiche('Port COM'+intToSTR(port)+' invalide',clred);
      portOK:=false;
    end;
    if protocole=2 then DTREnable:=false // évite de reset de l'arduino à la connexion
    else DTREnable:=True;
    if prot_serie=4 then RTSEnable:=True //pour la genli
    else RTSenable:=False;
    InputMode:=comInputModeBinary;
  end;

  portCommOuvert:=false;
  if portOK then
  begin
    portCommOuvert:=true;
    try
       MSCommUSBInterface.portopen:=true;
    except
      portCommOuvert:=false;
    end;
  end;

  if portCommOuvert then
  begin
    FormPrinc.StatusBar1.Panels[3].Style:=psOwnerDraw;  // permet de déclencher l'event onDrawPanel
    s:='COM'+intToSTR(port)+' ouvert';
    Affiche(s,clLime);
    s:='COM'+intToSTR(port)+':'+sc;

    Formprinc.StatusBar1.Panels[3].Text:=s;
    sleep(1000);
    trouve:=test_protocole;
    if not(trouve) then
    begin
      portCommOuvert:=false;
      MSCommUSBInterface.portopen:=false;
    end;
  end;
  if trouve then result:=port else result:=0;
end;

// envoie la séquence d'init du fichier de config à Dccpp
procedure init_dccpp;
var i,j1,j2,p,n,erreur : integer;
    s,se : string;
begin
  if EnvAigDccpp=1 then envoi_aiguillages_DCCpp;  // envoi la liste des aiguillages à l'interface DCC++

  i:=1;
  repeat
    s:=CdeDccpp[i];
    if s<>'' then
    begin
      se:=s+'  : '+decodeDCC(s);
      Affiche(se,clLime);
      affiche_retour_dcc:=true;
      tps_affiche_retour_dcc:=2;
      p:=pos('<Y',s);
      if p<>0 then
      begin
        j1:=pos(' ',s);
        j2:=PosEx(' ',s,j1+1);
        val(copy(s,j1+1,1),n,erreur);
        val(copy(s,j2+1,length(s)-j2-1),formatY,erreur);
      end;
      envoi(s);
      sleep(200);
    end;
    inc(i);
  until (s='') or (i>MaxCdeDccpp);
end;

procedure connecte_interface_ethernet;
begin
  etat_init_interface:=0;
  // ouvrir socket vers la centrale
  // Initialisation de la comm socket LENZ
  if AdresseIP<>'0' then
  begin
    procetape('Ouverture interface socket');
    etat_init_interface:=10;
    Affiche('Demande ouverture interface par Ethernet '+AdresseIP+':'+intToSTR(portinterface),clyellow);
    with formprinc.ClientSocketInterface do
    begin
      port:=portInterface;
      Address:=AdresseIP;
      Open;
    end;
    //Application.processMessages;
  end;
end;

// connecte la centrale en USB/COM en explorant les ports USB/COM de 1 à MaxComPort
procedure connecte_usb;
var numport,erreur : integer;
    s : string;
    unique: boolean;
begin
  if debug=1 then affiche('Connexion interface USB',clLime);
  if portcommouvert then exit;
  numport:=0;
  if portcom<>'' then
  begin
    val(copy(portcom,4,6),Numport,erreur);
  end;

  unique:=numport<>0;

  if numport=0 then
  // scan des ports
  begin
    numport:=1;
    repeat
      With MSCommUSBInterface do
      begin
        //Affiche('Test port com'+intToSTR(numport),clyellow);
        port:=connecte_port_usb(numport);
        inc(numport);
      end;
    until (port<>0) or (numport>MaxPortCom);
  end
  else port:=connecte_port_usb(numport);

  if port=0 then
  begin
    s:='Pas d''interface ';
    if protocole=1 then s:=s+'XpressNet';
    if protocole=2 then s:=s+'DCC++';
    if unique then s:=s+' trouvée sur le port COM'+intToSTR(numport)
    else s:=s+' trouvée sur les ports COM de 1 à '+intToSTR(MaxPortCom);
    Affiche(s,clOrange);
    Formprinc.StatusBar1.Panels[3].Text:='';
  end
  else
  begin
    Formprinc.DeConnecterUSB.enabled:=true;
    With Formprinc do
    begin
      ButtonEcrCV.Enabled:=true;
      LireunfichierdeCV1.enabled:=true;
      ButtonLitCV.Enabled:=true;
    end;
    if (protocole=2) then
    begin
      init_dccpp;
      etat_init_interface:=20;
    end;
  end;
end;

// renvoie le handle de la fenêtre du programme de processID (CDMrail)
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
      //Affiche('CDM rail processID='+IntToSTR(ProcessID)+' handle='+IntToSTR(CDMhd),clOrange);
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

// Lance et connecte CDM rail si avecsocket=true. en sortie si CDM est lancé Lance_CDM=true,
function Lance_CDM(avecSocket : boolean) : boolean;
var i,retour : integer;
    repertoire,s : string;
    cdm_lanceLoc : boolean;
begin
  s:='CDR';
  if (ProcessRunning(s)) then
  begin
    // CDM déja lancé;
    Affiche('CDM déjà lancé',clOrange);
    Lance_CDM:=true;
    if CDM_connecte then exit;
    if avecSocket then
    begin
      deconnecte_USB;
      connecte_CDM;
    end;
    exit;
  end;

  s:='';
  if lay<>'' then s:='-f '+lay;  // lay

  if not(serveurIPCDM_Touche) and avecSocket then s:=s+' -COMIPC';             // démarre serveur comipc de CDM par ligne de commande

  cdm_lanceLoc:=false;
  // lancement depuis le répertoire 32 bits d'un OS64
  repertoire:=CheminProgrammes+'\CDM-Rail';

  //Affiche(s,clred);
  //Affiche(repertoire,clorange);
  retour:=ShellExecute(Formprinc.Handle,'open',
                    Pchar('cdr.exe'),
                    Pchar(s),  // paramètre
                    PChar(repertoire)  // répertoire
                    ,SW_SHOWNORMAL);
  if retour>32 then
  begin
    cdm_lanceLoc:=true;
  end
  else
  begin
    Affiche('CDM rail introuvable. Erreur='+intToSTR(retour),clred);
    lance_CDM:=false;
    exit;
  end;

  if AvecSocket and cdm_lanceLoc then
  begin
    Formprinc.caption:=af+' - '+lay;
    // On a lancé CDM, déconnecter l'USB
    deconnecte_USB;
    Affiche('Lance les fonctions automatiques de CDM',clyellow);
    SetForegroundWindow(formprinc.Handle); // met SC devant
    Sleep(1500);       // attend le lancement de CDM
    if serveurIPCDM_touche then sleep(1000);
    ProcessRunning(s); // récupérer le handle de CDM
    SetForegroundWindow(CDMhd);            // met CDM en premier plan pour le télécommander par le clavier simulé
    SetActiveWindow(CdmHd);
    Application.ProcessMessages;
    if serveurIPCDM_Touche then sleep(1000);

    // démarre le serveur IP de CDM par simulation de touches
    if serveurIPCDM_Touche then
    begin
      // démarre le serveur IP : il faut avoir chargé un réseau sinon le permier menu est fermé------------------------------------
      // prépare le tableau pour sendinput
      KeybdInput(VK_MENU,0);                 // enfonce Alt
      KeybdInput(Ord('C'),0);                // enfonce C
      KeybdInput(Ord('C'),KEYEVENTF_KEYUP);  // relache C        pointe premier menu "Configuration train"

      KeybdInput(VK_MENU,KEYEVENTF_KEYUP);   // relache ALT

      KeybdInput(Ord('C'),0);
      KeybdInput(Ord('C'),KEYEVENTF_KEYUP);  // pointe sur 2eme menu "comm ip"

      KeybdInput(VK_RETURN,0);               // valide démarrer comm ip
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
      KeybdInput(VK_RETURN,0);
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);

      // envoie les touches
      i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  // la fenetre serveur démarré est affichée
      Sleep(400);
      Application.ProcessMessages;
    end;
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
      Sleep(400);

      // descendre le curseur n fois pour sélectionner le serveur
      for i:=1 to ServeurInterfaceCDM-1 do
      begin
        KeybdInput(VK_DOWN,0);
        KeybdInput(VK_DOWN,KEYEVENTF_KEYUP);
      end;
      // 2x TAB pour pointer sur OK
      KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
      KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP);
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Sleep(400);

      // Interface
      if (ServeurInterfaceCDM=1) or (ServeurInterfaceCDM=5) then
      begin
        for i:=1 to ServeurRetroCDM-1 do
        begin
          KeybdInput(VK_DOWN,0);KeybdInput(VK_DOWN,KEYEVENTF_KEYUP);
          SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
        end;

        // 2x TAB pour pointer sur OK
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);

        // cocher Z21
        if Z21 and (ServeurInterfaceCDM=1) then
        begin
          // 1x monte
          KeybdInput(VK_UP,0);KeybdInput(VK_UP,KEYEVENTF_KEYUP);
          // ESPACE pour sélectionner Z21
          KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP);
          // TAB pour sélectionner OK
          KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
          SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
          Sleep(200);
        end;

        KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);

        Sleep(400);
        KeybdInput(VK_RETURN,0);KeybdInput(VK_RETURN, KEYEVENTF_KEYUP);  // valide la fenetre finale
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;
    end;
  end;
  Lance_CDM:=true;
end;

procedure Raz_reservations ;
var i : integer;
begin
  // raz des réservations des aiguillages
  for i:=1 to MaxAiguillage do
    aiguillage[i].AdrTrain:=0;
end;

// supprime les events, les trains etc
Procedure Raz_tout;
var i,j,index : integer;
begin
  N_Event_tick:=0;
  N_event_det:=0;
  N_trains:=0;
  Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);
  for i:=1 to Max_Trains do Event_det_Train[i].NbEl:=0;
  for i:=1 to 20 do begin TrainZone[i].Nbre:=0;TrainZone[i].train:='';end;
  // initialisation de la chronologie des évènements détecteurs
  for i:=0 to Max_Event_det_tick do
  begin
    event_det_tick[i].adresse:=-1;
    event_det_tick[i].modele:=rien;
    event_det_tick[i].etat:=-1;
    event_det_tick[i].reaffecte:=0 ;
  end;
  for i:=1 to NbMaxDet do
  begin
    detecteur[i].etat:=false;
    detecteur[i].train:='';
    detecteur[i].adrTrain:=0;
    detecteur[i].IndexTrain:=0;
    ancien_detecteur[i]:=false;
  end;
  for i:=1 to NbMaxDet do
    for j:=1 to NbMaxDet do
    begin
      MemZone[i,j].etat:=false;
      MemZone[i,j].train:='';
    end;

  for i:=1 to idEl do
  begin
    elements[i].adresse:=0;
    elements[i].typ:=rien;
  end;

  for i:=1 to Max_Trains do
  begin
    event_det_train[i].NbEl:=0;
    event_det_train[i].AdrTrain:=0;
    event_det_train[i].nom_train:='';
    event_det_train[i].Det[1].adresse:=0;
    event_det_train[i].Det[1].etat:=false;
    event_det_train[i].Det[2].adresse:=0;
    event_det_train[i].Det[2].etat:=false;
  end;

  // raz des réservations
  for i:=1 to maxaiguillage do
  begin
    aiguillage[i].AdrTrain:=0;
  end;

  i_simule:=0;
  if DebugAffiche then
  begin
    FormDebug.MemoEvtDet.Clear;
  end;
  roulage:=false;

  // raz compteurs de trains des PN
  for i:=1 to NbrePN do
  begin
    Tablo_Pn[i].compteur:=0;
  end;

  for index:=1 to NbreTCO do
  begin
    for i:=1 to NbreCellx[index] do
      for j:=1 to NbreCelly[index] do
        tco[index,i,j].mode:=0;

    if pCanvasTCO[index]<>nil then affiche_TCO(index);
  end;

  Maj_signaux(false);
end;

// positionnement des aiguillages au démarrage : seulement en mode autonome
procedure init_aiguillages;
var i,pos : integer;
    s : string;
    model : Tequipement;
begin
  // positionnement des aiguillages meme si pas connecté à la centrale ou à CDM
  // faire en 2 fois pour plus de rapidité
  // 1 fois pour initialiser la position dans le tableau
  // 2eme fois pour positionner physiquement les aiguillages
  // et générer les evts de position
  // Affiche('Positionnement aiguillages',cyan);
  init_aig_cours:=true;
  for i:=1 to maxaiguillage do
  begin
    model:=aiguillage[i].modele;
    if (model<>rien) and (model<>crois) then // si l'aiguillage existe et différent de croisement
    begin
      pos:=aiguillage[i].posInit;
      if (pos=const_devie) or (pos=const_droit) then
      begin
        s:='Init aiguillage '+intToSTR(aiguillage[i].Adresse)+'='+intToSTR(pos);
        case pos of
          const_devie : s:=s+' (dévié)';
          const_droit : s:=s+' (droit)';
          else
          s:=s+' non positionné';
        end;
        Affiche(s,clcyan);
        aiguillage[i].position:=pos;
      end;
    end;
  end;

  for i:=1 to maxaiguillage do
  begin
    model:=aiguillage[i].modele;
    if (model<>rien) and (model<>crois) then // si l'aiguillage existe et différent de croisement
    begin
      pos:=aiguillage[i].posInit;

      if (pos=const_devie) or (pos=const_droit) then
      begin
        pilote_acc(aiguillage[i].Adresse,pos,aigP);
        if portCommOuvert or parSocketLenz or CDM_connecte then sleep(Tempo_Aig);
      end;
    end;
  end;
  init_aig_cours:=false;
end;

// renvoyer date heure, MAC, version SC , verif_version, avec_roulage

// ex 1
function GetMACAdress: string;
var
  NCB: PNCB;
  Adapter: PAdapterStatus;
  RetCode: Ansichar;
  I: integer;
  Lenum: PlanaEnum;
  _SystemID: string;
begin
  Result:='';
  _SystemID:='';
  Getmem(NCB,SizeOf(TNCB));
  Fillchar(NCB^,SizeOf(TNCB),0);

  Getmem(Lenum,SizeOf(TLanaEnum));
  Fillchar(Lenum^,SizeOf(TLanaEnum),0);

  Getmem(Adapter,SizeOf(TAdapterStatus));
  Fillchar(Adapter^,SizeOf(TAdapterStatus),0);

  Lenum.Length    := chr(0);
  NCB.ncb_command := chr(NCBENUM);
  NCB.ncb_buffer  := Pointer(Lenum);
  NCB.ncb_length  := SizeOf(Lenum);
  RetCode         := Netbios(NCB);

  i:=0;
  repeat
    Fillchar(NCB^,SizeOf(TNCB), 0);
    Ncb.ncb_command:=chr(NCBRESET);
    Ncb.ncb_lana_num:=lenum.lana[I];
    RetCode:=Netbios(Ncb);

    Fillchar(NCB^,SizeOf(TNCB), 0);
    Ncb.ncb_command:=chr(NCBASTAT);
    Ncb.ncb_lana_num:=lenum.lana[I];
    // Must be 16
    Ncb.ncb_callname:='*               ';

    Ncb.ncb_buffer:=Pointer(Adapter);

    Ncb.ncb_length:=SizeOf(TAdapterStatus);
    RetCode:=Netbios(Ncb);
    //---- calc _systemId de la mac-address[2-5] XOR mac-address[1]...
    if (RetCode=chr(0)) or (RetCode=chr(6)) then
    begin
      _SystemId := IntToHex(Ord(Adapter.adapter_address[0]), 2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[1]),2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[2]),2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[3]),2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[4]),2) + '-' +
        IntToHex(Ord(Adapter.adapter_address[5]),2);
    end;
    Inc(i);
  until (i>=Ord(Lenum.Length)) or (_SystemID<>'00-00-00-00-00-00');
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
  GetMacAdress:=_SystemID;
end;

// ex2
function GetAdapterInfo(Lana: AnsiChar): String;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB,SizeOf(NCB),0);
  NCB.ncb_command:=Char(NCBRESET);
  NCB.ncb_lana_num:=Lana;
  if Netbios(@NCB)<>Char(NRC_GOODRET) then
  begin
    Result:='mac non trouvée';
    Exit;
  end;

  FillChar(NCB,SizeOf(NCB), 0);
  NCB.ncb_command:=Char(NCBASTAT);
  NCB.ncb_lana_num:=Lana;
  NCB.ncb_callname:='*';

  FillChar(Adapter,SizeOf(Adapter), 0);
  NCB.ncb_buffer:=@Adapter;
  NCB.ncb_length:=SizeOf(Adapter);
  if Netbios(@NCB)<>Char(NRC_GOODRET) then
  begin
    Result:='mac non trouvée';
    Exit;
  end;
  Result:=
    IntToHex(Byte(Adapter.adapter_address[0]),2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[1]),2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[2]),2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[3]),2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[4]),2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[5]),2);
end;

function GetMACAddress: string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
begin
  FillChar(NCB,SizeOf(NCB),0);
  NCB.ncb_command:=Char(NCBENUM);
  NCB.ncb_buffer:=@AdapterList;
  NCB.ncb_length:=SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length)>0 then
    Result:=GetAdapterInfo(AdapterList.lana[0])
  else
    Result:='mac non trouvée';
end;

// positionne les composants de la fenêtre principale
// i : position X du splitter
procedure positionne_elements(i : integer);
begin
  with formprinc do
  begin
    LabelClock.Left:=width-120;
    GroupBoxAcc.Left:=i+12;
    GroupBoxCV.Left:=i+12;
    GroupBoxTrains.Left:=i+12;
    ScrollBoxSig.Left:=i+12;
    ScrollBoxSig.width:=GrandPanel.Width-i-20;
    Panel1.Left:=GroupBoxAcc.Left+GroupBoxAcc.Width+5;
    Panel1.top:=9;
    GroupBoxAcc.Top:=5;
    Affiche_signaux;
  end;
end;

// positionne la couleur de fond et le texte du composant
procedure composant(c : tComponent;fond,texte : tColor);
var cGB : TGroupBox;
    cTE : tEdit;
    cCB : tComboBox;
    cPa : tPanel;
    cLa : tLabel;
    cSB : tcheckBox;
    cSh : tShape;
    cMe : tMemo;
    cRa : tRadioGroup;
    cRb : tRadioButton;
begin
  if c is Tshape then
  begin
    csH:=c as tShape;
    csH.Brush.Color:=fond;
    exit;
  end;
  if c is TGroupBox then
  begin
    cGB:=c as TgroupBox;
    cGB.color:=fond;
    cGB.font.color:=texte;
    exit;
  end;
  if c is TRadioGroup then
  begin
    cRa:=c as TRadioGroup;
    cRa.color:=fond;
    cRa.font.color:=texte;
    exit;
  end;
  if c is TRadioButton then
  begin
    cRb:=c as tRadioButton;
    cRb.color:=fond;
    cRb.font.color:=texte;
    exit;
  end;
  if c is TMemo then
  begin
    cMe:=c as TMemo;
    cMe.color:=fond;
    cMe.font.color:=texte;
    exit;
  end;
  if c is TGroupBox then
  begin
    cGB:=c as TgroupBox;
    cGB.color:=fond;
    cGB.font.color:=texte;
    cGB.Repaint;
    exit;
  end;
  if c is TEdit then
  begin
    cTE:=c as tEdit;
    cTE.color:=fond;
    cTE.Font.Color:=texte;
    exit;
  end;
  if c is tComboBox then
  begin
    cCB:=c as tComboBox;
    cCB.color:=fond;
    cCb.Font.Color:=clWhite;
    exit;
  end;
  if c is tPanel then
  begin
    cPa:=c as tPanel;
    cPA.Color:=fond;
    cPA.Font.Color:=texte;
    exit;
  end;
  if c is tLabel then
  begin
    cLa:=c as tLabel;
    cLa.Color:=fond;
    cLa.Font.Color:=texte;
    exit;
  end;
  if c is tCheckBox then
  begin
    cSb:=c as tCheckBox;
    cSb.Color:=fond;
    cSB.Font.Color:=texte;
    exit;
  end;
end;

// couleurs de la fenetre principale
procedure couleurs_Princ;
var fond,texte : tColor;
    i : integer;
    c : Tcomponent;
    cSc: tScrollBox;
begin
  fond:=couleurFond;
  texte:=couleurTexte;
  if sombre then
  begin
    formprinc.Color:=fond;
    for i:=0 to formprinc.ComponentCount-1 do
    begin
      c:=formprinc.Components[i];
      //Affiche(c.Name,clyellow);
      composant(c,fond,texte);
    end;

    cSc:=Formprinc.FindComponent('ScrollBox1') as tScrollBox;
    if assigned(cSc) then
    begin
      texte:=clBlack;
      fond:=Formprinc.ScrollBoxSig.Color;
      for i:=0 to formprinc.ScrollBoxSig.ComponentCount-1 do
      begin
        c:=formprinc.ScrollBoxSig.Components[i];
        //Affiche(c.Name,clLime);
        composant(c,fond,texte);
      end;
    end;
  end;
end;

// mettre à jour les couleurs de fond des fenêtres
procedure maj_couleurs;
begin
  couleurs_princ;
  Couleurs_config;
  couleurs_debug;
  couleurs_SR;
  couleurs_cdf;
  couleurs_place;
  couleurs_pilote;
end;

// renvoie la taille d'un fichier
function FileSize(const aFilename: String): Int64;
var info: TWin32FileAttributeData;
begin
  result:=-1;
  if not GetFileAttributesEx(PChar(aFileName),GetFileExInfoStandard,@info) then exit;
  result:=Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
end;

procedure Tformprinc.procAide(Sender : Tobject);
var i : integer;
begin
  i:=ShellExecute(Formprinc.Handle,'open',
                    Pchar(FichierAide),
                    nil,  // paramètre
                    nil  // répertoire
                    ,SW_SHOWNORMAL);
  if i<=32 then Affiche('Impossible d''afficher l''aide '+FichierAide,clred);
end;

// démarrage principal du programme signaux_complexes
procedure TFormPrinc.FormCreate(Sender: TObject);
var n,t,i,index,OrgMilieu : integer;
    s : string;
    trouve : boolean;
    Sr : TSearchRec;
    tmP,tmA : tMenuItem;
begin
  af:='Client TCP-IP ou USB CDM Rail - système XpressNet DCC++ Version '+VersionSC+sousVersion;
  {$IF CompilerVersion >= 28.0}
  af:=af+' D11';
  {$IFEND}
  for index:=1 to 10 do
  begin
    formTCO[index]:=nil;
  end;


  BorderStyle:=bsSizeable;
  Caption:=af;
  TraceSign:=True;
  configPrete:=false; // form config prete
  PremierFD:=false;
  sauve_tco:=false;
  pasChgTBV:=false;
  horloge:=false;
  ntrains:=0;

  mode_reserve:=0; // mode_reserve  0 = par canton - 1=par détecteurs
  ntrains_cdm:=0;
  protocole:=1;
  filtrageDet0:=3;
  cdmHd:=0;
  CouleurFond:=$404040 ;
  couleurAction:=$606060;

  // services commIP CDM par défaut
  Srvc_Aig:=true;
  Srvc_Det:=true;
  Srvc_Act:=true;
  Srvc_Pos:=true;
  Srvc_sig:=false;

  Z21:=false;
  DebugAffiche:=false;
  ConfCellTCO:=false;
  confasauver:=false;
  config_modifie:=false;
  chaine_recue:='';
  Application.onHint:=doHint;

  // box2=CV
  GroupBoxCV.Left:=633;
  GroupBoxCV.Top:=60;
  GroupBoxCV.Visible:=false;
  // box3=vitesses et fonctions F
  GroupBoxTrains.Left:=633;
  GroupBoxTrains.Top:=60;
  GroupBoxAcc.Left:=633;
  GroupBoxTrains.visible:=true;
  ScrollBoxSig.Left:=633;

  procetape('');  //0
  NbreTCO:=0;
  N_Trains:=0;
  NivDebug:=0;
  ncrois:=0;
  EnvAigDccpp:=0;
  debugtrames:=false;
  horlogeInterne:=true;
  DureeMinute:=60;
  ProcPrinc:=false;
  algo_Unisemaf:=1;
  NbPeriph:=0;
  MaxPortCom:=255;
  roulage:=false;
  espY:=15;
  etat_init_interface:=0;
  debug:=0;
  heure:=0;
  minute:=0;
  seconde:=0;
  etape:=1;
  affevt:=false;
  EvtClicDet:=false;
  Algo_localisation:=1;     // normal
  nCantonsRes:=2;
  AntiTimeoutEthLenz:=0;
  Verif_AdrXpressNet:=1;
  Max_Signal_Sens:=5;
  portServeur:=4500;
  avecRoulage:=0;
  formatY:=-1;
  avecResa:=false;          // réservation des aiguillages en mode normal
  serveurIPCDM_Touche:=false;
  debugPN:=false;
  sombre:=false;
  AvecInit:=true;           // &&&&    avec initialisation des aiguillages ou pas
  Diffusion:=AvecInit;      // mode diffusion publique + debug mise au point etc
  Button1.Visible:=not(avecInit);
  roulage1.visible:=false;
  FenRich.MaxLength:=$7FFFFFF0;
  NbDecodeur:=11;
  NbDecodeurdeBase:=NbDecodeur;
  Decodeur[0]:='Rien';Decodeur[1]:='Digital Bahn';Decodeur[2]:='CDF';Decodeur[3]:='LS-DEC-SNCF';Decodeur[4]:='LEB';
  Decodeur[5]:='Digikeijs 4018';Decodeur[6]:='Unisemaf Paco';Decodeur[7]:='Stéphane Ravaut';Decodeur[8]:='Arcomora';
  Decodeur[9]:='LS-DEC-NMBS';Decodeur[10]:='B-models';

  if versionSC='8.53' then
  begin
    Horaires1.enabled:=false;
    LabelClock.Visible:=false;
  end;

  OsBits:=0;
  if IsWow64Process then
  begin
    OsBits:=64;
    CheminProgrammes:=GetCurrentProcessEnvVar('PROGRAMFILES(X86)');
    cheminWin:=GetCurrentProcessEnvVar('windir')+'\SysWOW64';
  end
  else
  begin
    OsBits:=32;
    CheminProgrammes:=GetCurrentProcessEnvVar('PROGRAMFILES');
    cheminWin:=GetCurrentProcessEnvVar('windir')+'\System32';
  end;

  // vérifier ocx tmscomm
  s:=cheminwin+'\mscomm32.ocx';
  i:=filesize(s);
  if (i<>103744) and (i<>-1) then
  begin
    s:='Version fichier '+s+' incorrecte';
    AfficheDebug(s,clOrange);
    Affiche(s,clOrange);
  end;
  if i=-1 then
  begin
    s:='Ficher '+s+' inexistant';
    AfficheDebug(s,clred);
    Affiche(s,clred);
  end;
  // création des composants MSCom (USB COM) -----------------
  // interface centrale - provoque l'apparition de la fenêtre "préparation de l'installation"

  try MSCommUSBInterface:=TMSComm.Create(formprinc);
  except
    s:='Erreur 6000 : Composant Interface non créé';
    AfficheDebug(s,clred);
    Affiche(s,clred);
  end;
  if MSCommUSBInterface<>nil then MSCommUSBInterface.onComm:=RecuInterface;

  // pour deux périphériques COM/USB
  try MSCommCde1:=TMSComm.Create(formprinc);
  except Affiche('Composant périphérique 1 non créé',clred);
  end;
  if MsCommCde1<>nil then MSCommCde1.OnComm:=RecuPeriph1;

  try MSCommCde2:=TMSComm.Create(formprinc);
  except Affiche('Composant périphérique 2 non créé',clred);
  end;
  if MsCommCde2<>nil then MSCommCde2.OnComm:=RecuPeriph2;


  //s:=GetCurrentDir;
  //Affiche(s,clLime);
  if FindFirst('*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      s:=sr.Name;
      if (s<>'.') and (s<>'..') then
      begin
        FichierAide:=lowercase(SR.Name);
        trouve:=pos('.pdf',FichierAide)<>0;
      end;
    until (FindNext(sr)<>0) or (trouve);
    FindClose(sr);
  end;
  if trouve then
  begin
    // menu principal
    tmP:=TmenuItem.Create(MainMenu1);
    tmP.Caption:='Aide';
    tmP.Name:='MiAide';
    tmP.Hint:=FichierAide;
    MainMenu1.items.Add(tmP);

    // 1ere entrée
    i:=MainMenu1.Items.Count;
    tmA:=TmenuItem.Create(MainMenu1);
    tmA.Caption:='Fichier d''aide';
    tmA.Name:='MiAidePDF';
    tmA.Hint:=FichierAide;
    MainMenu1.Items[i-1].Add(tmA);

    MainMenu1.Items[i-1].Items[0].OnClick:=ProcAide;
  end;

  // version d'OS pour info
  application.ProcessMessages;

  if OsBits=64 then s:='OS 64 Bits' else s:='OS 32 Bits';
  s:=DateToStr(date)+' '+TimeToStr(Time)+' '+s;
  Affiche(s,clLime);
  With ScrollBoxSig do
  begin
    HorzScrollBar.Tracking:=true;
    HorzScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si onclique sur la trackbar!!
    VertScrollBar.Tracking:=true;
    VertScrollBar.Smooth:=false;
  end;

  fermeSC:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  residuCDM:='';
  Nbre_recu_cdm:=0;
  AffMem:=true;
  N_routes:=0;
  N_trains:=0;
  NumTrameCDM:=0;
  protocole:=1;
  procetape('');  //1
  for i:=1 to NbMaxDet do
  begin
    Ancien_detecteur[i]:=false;
    detecteur[i].etat:=false;
    detecteur[i].train:='';
  end;
  for i:=0 to IdClients do
  begin
    Liste_clients[i].adresse:='';
    Liste_Clients[i].PortLocal:=0;
    Liste_Clients[i].PortDistant:=0;
  end;

  Application.HintHidePause:=30000;
  Application.HintColor:=$70FFFF;
  Application.HintPause:=400;
  //visible:=true;  // rend la form visible plus tot
  for i:=1 to MaxCdeDccpp do CdeDccpp[i]:='';
  // lecture fichiers de configuration
  procetape('Lecture de la configuration');
  lit_config;
  {$IF CompilerVersion >= 28.0}
  //https://docwiki.embarcadero.com/RADStudio/Alexandria/en/Compiler_Versions
  change_style;
  {$IFEND}
  init_horloge;

  // identifier les écrans
  n:=Screen.MonitorCount-1;
  if n>9 then n:=9;
  for i:=0 to n do
  begin
    //Affiche('Ecran '+intToSTR(i),clyellow);
    ecran[i+1].x0:=Screen.Monitors[i].BoundsRect.Left;
    ecran[i+1].y0:=Screen.Monitors[i].BoundsRect.Top;
    ecran[i+1].larg:=Screen.Monitors[i].BoundsRect.right-Screen.Monitors[i].BoundsRect.left;
    ecran[i+1].Haut:=Screen.Monitors[i].BoundsRect.bottom-Screen.Monitors[i].BoundsRect.top;

   { Affiche('left='+intToSTR(Screen.Monitors[i].BoundsRect.left)+' top='+intToSTR(Screen.Monitors[i].BoundsRect.Top)+' '+
            'right='+intToSTR(Screen.Monitors[i].BoundsRect.right)+' bottom='+intToSTR(Screen.Monitors[i].BoundsRect.bottom),clLime);

    Affiche(intToSTR(ecran[i+1].x0)+' '+intToSTR(ecran[i+1].y0)+' '+
            intToSTR(ecran[i+1].larg)+' '+intToSTR(ecran[i+1].haut),clyellow); }
  end;

  if ecran_sc<1 then ecran_SC:=1;
  if Ecran_sc>Screen.MonitorCount then Ecran_SC:=1;

  serveur_ouvert:=true;
  serverSocket.Port:=PortServeur;
  try
    ServerSocket.Open;
  except
    serveur_ouvert:=false;
    Affiche('Serveur signaux_complexes non ouvert, le port '+intToSTR(PortServeur)+' est utilisé',clred);
  end;
  if serveur_ouvert then ServerSocket.Active:=true;

  Menu_tco(NbreTCO);
  procetape('Lecture du TCO');
  for i:=1 to NbreTCO do
  begin
    EcranTCO[i]:=1;
    lire_fichier_tco(i);
  end;

  verif_coherence;
  procetape('La configuration a été lue');

  if protocole=1 then
  begin
    ButtonEnv.visible:=false;
    EditEnvoi.Visible:=false;
  end;
  if protocole=2 then
  begin
    ButtonEnv.visible:=true;
    EditEnvoi.Visible:=true;
  end;

  Application.ProcessMessages;
  // Initialisation des images des signaux
  procetape('Création des signaux');
  NbreImagePLigne:=(Formprinc.ScrollBoxSig.Width div (largImg+5)) -1;
  if NbreImagePLigne=0 then NbreImagePLigne:=1;

  // ajoute les images des signaux dynamiquement
  for i:=1 to NbreSignaux do
  begin
    if debug=1 then affiche('Création du signal '+intToSTR(i)+' ----------',clLime);
    cree_image(i);  // et initialisation tableaux signaux
  end;

  Tempo_init:=5;  // démarre les initialisation des signaux et des aiguillages dans 0,5 s

  OrgMilieu:=formprinc.width div 2;
  with statusbar1 do
  begin
    SimplePanel:=false;  // pour afficher plusieurs panels dans la Statusbar
    Panels[0].Text:='';
    Panels[1].Text:='';
    Panels[2].Text:='';
    Panels[3].Text:='';
    Panels[4].Text:='';
    //Panels[3].Style:=psOwnerDraw;  // pour déclencher l'évenement onDraw
  end;

  {$IF CompilerVersion < 28.0}
  positionne_principal;
  {$IFEND}

  if debug=1 then Affiche('Création TCO',clLime);
  for index:=1 to nbreTCO do
  begin
    tcoCree:=false;
    IndexTCOCreate:=index;
    formTCO[index]:=TformTCO.Create(self);
    formTCO[index].Name:='FormTCO'+intToSTR(index);
    formTCO[index].Caption:='TCO'+intToSTR(index);
    t:=0;
    repeat
      Application.ProcessMessages;
      inc(t);
    until tcoCree or (t>10);
    if t>10 then
    begin
      Affiche('Erreur 850 : TCO non créé',clred);
      formTCO[index]:=nil;
    end
    else
    if avecTCO then Affiche_Fenetre_TCO(index,avecTCO);
  end;

  // ouvre les périphériques commandes actionneurs, car on a lu les com dans la config
  for i:=1 to NbPeriph do
  begin
    index:=com_socket(i);   // comusb ou socket ?
    if index=1 then
    begin
      if connecte_usb_periph(i) then Affiche('COM'+intToSTR(Tablo_periph[i].numcom)+' périphérique ouvert',clLime)
      else Affiche('COM'+intToSTR(Tablo_periph[i].numcom)+' périphérique non ouvert',clOrange);
    end;
    if index=2 then
    begin
      if connecte_socket_periph(i) then Affiche('Socket '+Tablo_periph[i].protocole+' demande ouverture ',clLime)
      else Affiche('Socket '+Tablo_periph[i].protocole+' périphérique non ouvert',clOrange)
    end;
  end;

  couleurs_princ;

  if debug=1 then Affiche('Initialisations',clLime);

  procetape('Début des init');
  I_Simule:=0;
  tick:=0;
  N_Event_tick:=0 ; // dernier index
  NombreImages:=0;

  //Affiche('Fin des initialisations',clyellow);
  Affiche_memoire;
  modeStkRetro:=false;

  // création des tampons de sauvegarde graphique pour le mouvement du train sur la fenetre cdm
  for i:=1 to Max_Trains do
  begin
    trains[i].sbitmap:=Tbitmap.Create;
    trains[i].SbitMap.width:=300;
    trains[i].SbitMap.height:=300;
  end;


  // lancer CDM rail et le connecte si on le demande ; à faire après la création des signaux et du tco
  if debug=1 then Affiche('Procédure CDM',clLime);
  procetape('Test CDM et son lancement');
  if LanceCDM then Lance_CDM(true);
  procetape('Fin cdm');
  Loco.Visible:=true;

  // tenter la liaison vers CDM rail
  procetape('Test connexion CDM');
  if not(CDM_connecte) then connecte_CDM;

  // si CDM n'est pas connecté, on regarde si on ouvre la liaison vers la centrale
  if not(CDM_connecte) then
  begin
    procetape('Ouvertures COM/USB interface');
    // ouverture par USB
    etat_init_interface:=1;  // demande connexion usb
    if AvecDemandeInterfaceUSB then connecte_USB;
    if not(portCommOuvert) and AvecDemandeInterfaceEth then
    begin
      application.ProcessMessages;
      connecte_interface_ethernet; // la connexion du socket ne se fait qu'à la sortie de cette procédure create
    end;
  end;

  if debug=1 then Affiche('Tentative ouverture liaison centrale',clLime);
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
  end;

  if AvecInit then
  begin
    if not(ConfigNulle) and not(fermeSC) and (AvecInitAiguillages) then
    begin
      if maxaiguillage>0 then
      begin
        Affiche('Positionnement des aiguillages',clcyan);
        init_aiguillages;   // initialisation des aiguillages
      end;
    end;

    if not(AvecInitAiguillages) and not(fermeSC) and (parSocketLenz or portCommOuvert)
       and AvecDemandeAiguillages then
    begin
      procetape('Demande etats accessoires');
      demande_etat_acc;   // demande l'état des accessoires (position des aiguillages)
    end;
    //Menu_interface(valide);
  end;
  raz_tout;
 {
  //DoubleBuffered:=true;
    aiguillage[index_aig(1)].position:=const_devie;
    aiguillage[index_aig(2)].position:=const_droit;
    aiguillage[index_aig(3)].position:=const_droit;
    aiguillage[index_aig(4)].position:=const_droit;
    aiguillage[index_aig(5)].position:=const_droit;
    aiguillage[index_aig(6)].position:=const_devie;
    aiguillage[index_aig(7)].position:=const_devie;
    aiguillage[index_aig(8)].position:=const_droit;
    aiguillage[index_aig(10)].position:=const_devie;
    aiguillage[index_aig(11)].position:=const_droit;
    aiguillage[index_aig(12)].position:=const_droit;
    aiguillage[index_aig(17)].position:=const_devie;
    aiguillage[index_aig(18)].position:=const_devie;
    aiguillage[index_aig(19)].position:=const_devie;
    aiguillage[index_aig(20)].position:=const_devie;
    aiguillage[index_aig(21)].position:=const_droit;
    aiguillage[index_aig(26)].position:=const_droit;
    aiguillage[index_aig(27)].position:=const_droit;
    aiguillage[index_aig(28)].position:=const_devie;
    aiguillage[index_aig(29)].position:=const_droit;
    aiguillage[index_aig(30)].position:=const_droit;
    aiguillage[index_aig(31)].position:=const_devie;
    aiguillage[index_aig(25)].position:=const_droit;
    aiguillage[index_aig(9)].position:=const_droit;

  }

  procetape('Terminé !!');
  if debug=1 then Affiche('Positionnement des signaux',clLime);
  Maj_Signaux(false);

  // vérifier si le fichier de segments existe
  fichier_module_CDM:=fileExists(NomModuleCDM);
  formprinc.ButtonAffAnalyseCDM.Visible:=fichier_module_cdm;
  if fichier_module_CDM then
  begin
    if debug=1 then Affiche('Module réseau CDM',clLime);
    Affiche_fenetre_CDM.Enabled:=true;
    lit_fichier_segments_cdm;
  end
    else Affiche_fenetre_CDM.Enabled:=false;

  //Affiche(GetMACAddress,clred);
  //formPrinc.left:=-1000;
  ConfCellTCO:=false;
   if debug=1 then Affiche('Fini',clLime);

end;


// évènement réception d'une trame sur le port COM USB centrale Xpressnet
procedure TFormPrinc.RecuInterface(Sender: TObject);
var i,tev : integer;
    tablo : array of byte;  // tableau rx usb
begin
  tev:=MSCommUSBInterface.commEvent;
  {
  // il n'y a pas d'evt de déconnexion !!
  Affiche('Evt '+intToSTR(tev),clOrange);
  Case tev of
    //liste des erreurs possibles
     comEventBreak : Affiche('Break',clOrange);     // On a reçu un signal d’interruption (Break)
     comEventCDTO  : Affiche('Timeout Porteuse',clOrange);     // Timeout de la porteuse
     comEventCTSTO : Affiche('Timeout signal CTS',clOrange);    // Timeout du signal CTS (Clear To Send)
     comEventDSRTO : Affiche('Timeout signal Rx',clOrange);    // Timeout du signal de réception
     comEventFrame : Affiche('Erreur trame',clOrange);     // Erreur de trame
     comEventOverrun : Affiche('Données perdues',clOrange);   // Des données ont été perdues
     comEventRxOver   : Affiche('Tampon Rx saturé',clOrange);  // Tampon de réception saturé
     comEventRxParity  : Affiche('111Erreur parité',clOrange);    //Erreur de parité
     comEventTxFull    : Affiche('Tampon Tx saturé',clOrange); //Tampon d’envoi saturé
     comEventDCB      : Affiche('Erreur DCB',clOrange); //Erreur de réception DCB (jamais vu)

    // liste des événements normaux possibles
     comEvCD : Affiche('Chgt CD',clYellow);       //    ' Changement dans la broche CD (porteuse)
     comEvCTS: Affiche('Chgt CTS',clYellow);           // Changement dans broche CTS
     comEvDSR  : Affiche('Chgt DSR',clYellow);        // Changement dans broche DSR (réception)
     comEvRing : Affiche('Chgt RI',clYellow);         // Changement dans broche RING (sonnerie)
     comEvSend : Affiche('Car a envoyer',clYellow);   // Il y a des caractères à envoyer
     comEvEOF  : Affiche('Recu EOF',clYellow);      //On a reçu le caractère EOF
  end;}


  if tev=comEvReceive then
  begin
    tablo:=MSCommUSBInterface.Input;
    for i:=0 to length(tablo)-1 do
    begin
      chaine_recue:=chaine_recue+char(tablo[i]);
    end;
    setlength(tablo,0);
    if traceTrames then
    begin
      if protocole=1 then AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+chaine_Hex(chaine_recue),Clwhite);
      if protocole=2 then AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+chaine_recue,Clwhite);
    end;
    chaine_recue:=interprete_reponse(chaine_recue);
  end;
end;

procedure TFormPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
var i,res : integer;
begin
  if TCO_modifie then
  begin
    res:=MessageDlg('Un des TCO a été modifié. Voulez-vous les sauvegarder ?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if res=mrYes then sauve_fichiers_tco;
    if res=mrCancel then abort;
  end;
  if config_modifie then
  begin
    res:=MessageDlg('La configuration a été modifiée. Voulez-vous la sauvegarder ?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if res=mrYes then sauve_config;
    if res=mrCancel then abort;
  end;
  if confasauver then sauve_config;
  if sauve_tco then sauve_fichiers_tco;

  timer1.Enabled:=false;
  FermeSC:=true;

  if portCommOuvert then
  begin
    portCommOuvert:=false;
    MSCommUSBInterface.Portopen:=false;
  end;
  // déconnecte les 10 périphériques
  for res:=1 to 10 do
  begin
    i:=com_socket(res);
    if i=1 then deconnecte_USB_periph(res);
    if i=2 then deconnecte_socket_periph(res);
  end;
  ServerSocket.Close;
  ClientSocketCDM.close;
  ClientSocketInterface.close;
end;

// appellé sur réception trame train CDM
procedure verifie_train_horaire(adresse : integer;train : string;vitesse : integer);
var i : integer;
    sens : boolean;
begin
  if vitesse>0 then
  for i:=1 to MaxHoraire do
  begin
    if (grilleHoraire[i].NomTrain=train) and (grilleHoraire[i].arretDepart) then
    begin
      if (  (grilleHoraire[i].heure<heure) or
          ((grilleHoraire[i].heure=heure) and (grilleHoraire[i].minute>minute))
         ) and (seconde<10) then
      begin
        Affiche('Arrêt du train '+Train+' hors horaire',clOrange);
        sens:=true;
        vitesse_loco(train,i,adresse,0,true);
      end;

    end;
  end;
end;

// appelé par le timer, si l'horloge tourne
procedure gestion_horaire;
var i,indexTrain,vitesse : integer;
   traite : boolean;
    train : string;
begin
  // démarrage des trains à l'horaire
  for i:=1 to MaxHoraire do
  begin
    if (grilleHoraire[i].heure=heure) and (grilleHoraire[i].minute=minute) then
    begin
      train:=grilleHoraire[i].NomTrain;

      traite:=true;
      if roulage then
      begin
        indexTrain:=index_train_nom(train);
        traite:=trains[indexTrain].roulage;
      end;

      if traite then
      begin
        vitesse:=grilleHoraire[i].vitesse;
        if not(grilleHoraire[i].sens) then vitesse:=-vitesse;
        Affiche('Démarrage train '+train+' à l''horaire '+format('%.2dh%.2d',[heure,minute]),clyellow);
        Demarre_index_train(index_train_nom(train));
        //vitesse_loco(train,0,adr,vitesse,true);
      end;
    end;

  end;

  // évènements actionneurs horaires
  for i:=1 to maxTablo_act do
  begin
    if Tablo_actionneur[i].typdeclenche=1 then
    begin
//      affiche(intToSTR(Tablo_Actionneur[i].adresse)+' '+Tablo_Actionneur[i].,clLime);
      if (Tablo_Actionneur[i].adresse=heure) and (Tablo_Actionneur[i].adresse2=minute) then
      begin
        event_act(heure,minute,1,'',true);
      end;
    end;
  end;
end;

// timer à 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var vitesse,i,a,adresse,TailleX,TailleY,orientation,indexTCO,x,y,Bimage,aspect : integer;
   imageSignal : Timage;
   frx,fry : real;
   faire : boolean;
   h,m,sec,ms : word;
   s : string;
begin
  inc(tick);

  // --- horloge système
  if horloge then
  begin
    inc(comptSec);
    if not(horlogeInterne) then
    begin
      if ComptSec=9 then
      begin
        comptSec:=0;
        decodeTime(GetTime,h,m,sec,ms);
        heure:=h;minute:=m;seconde:=sec;
        //if seconde-Asec<>1 then Affiche('Erreur s - Ecart='+intToSTR(seconde-Asec),clred);
        Asec:=seconde;
        labelClock.Caption:=format('%.2dh%.2d:%.2d',[heure,minute,seconde] );
        Clock.tickercall;
        if minute<>AncMinute then gestion_horaire;
        AncMinute:=minute;
      end;
    end;

    // --- horloge de signaux complexes
    if horlogeInterne then
    begin
      //if comptSec>=(DureeMinute*5) div 30 then
      if comptSec>=CompteurDixiemes then
      begin
        comptSec:=0;
        inc(seconde);
        //if seconde>=DureeMinute then
        if seconde=60 then
        begin
          seconde:=0;
          inc(minute);
          if minute=60 then
          begin
            minute:=0;
            inc(heure);
            if heure=24 then heure:=0;
          end;
          gestion_horaire;  // au chgt minute
          if (heure=RetourHeure) and (minute=RetourMinute) then
          begin
            heure:=heureinit;Minute:=minuteInit;
            Affiche('Horloge en initialisation',clyellow);
            if not(relanceHorl_init) then
            begin
              horloge:=false;
              Affiche('Arrêt horloge',clyellow);
            end;
          end;
        end;
        labelClock.Caption:=format('%.2dh%.2d:%.2d',[heure,minute,seconde] );
        Clock.tickercall;
      end
    end;
  end;

  if (tick=30) or (tick=100) then
  begin
    // raz du flag "fenetre confcellTCO affichée"
    ConfCellTCO:=false;
  end;

  // envoi timeout socket ethernet centrale lenz
  if parSocketLenz and (AntiTimeoutEthLenz=1) then
  begin
    dec(TpsTimeoutSL);
    if TpsTimeoutSL<=0 then
    begin
      TpsTimeoutSL:=450;  // envoyer caractère toutes les 45 secondes
      ClientSocketInterface.Socket.SendText(' ');
    end;
  end;

  if tempoSouris>0 then dec(Temposouris);
  if Tdoubleclic>0 then dec(Tdoubleclic);
  if Tempo_init>0 then dec(Tempo_init);
  if tps_affiche_retour_dcc>0 then
  begin
    dec(tps_affiche_retour_dcc);
    if tps_affiche_retour_dcc=0 then affiche_retour_dcc:=false;
  end;

  if temps>0 then dec(temps);

  // gestion du clignotant des signaux de la page principale----------------------
  if tempsCli>0 then dec(tempsCli);
  if tempsCli=0 then
  begin
    tempsCli:=4;
    clignotant:=not(clignotant);  // inversion du clignotant
    //tester chaque signal pour voir s'il y a un code de clignotement
    for i:=1 to NbreSignaux do
    begin
      a:=Signaux[i].EtatSignal;     // a = état binaire du signal
      adresse:=Signaux[i].adresse;
      // signal belge
      if Signaux[i].aspect=20 then
      begin
        // signal belge
        if TestBit(a,clignote) or Signaux[i].contrevoie then
        begin
          Dessine_signal_mx(Signaux[i].Img.Canvas,0,0,1,1,adresse,1);
        end;
      end
      else
      begin
        // signal français
        if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
           TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
           testBit(a,vert_cli)  or testbit(a,blanc_cli) then
           begin
             Dessine_signal_mx(Signaux[i].Img.Canvas,0,0,1,1,adresse,1);
            //Affiche('Clignote signal '+IntToSTR(adresse),clyellow);
           end;
      end;
    end;

    // signaux des TCO-----------------------------------------------
    for IndexTCO:=1 to NbreTCO do
    begin
      if (pCanvasTCO[indexTCO]<>nil) then
      begin
        // parcourir les signaux du TCO
        for y:=1 to NbreCellY[indexTCO] do
        for x:=1 to NbreCellX[indexTCO] do
        begin
          //affiche(intToSTR(indexTCO),clred);
          PcanvasTCO[IndexTCO].pen.mode:=pmCOpy;
          BImage:=TCO[indexTCO,x,y].bImage;
          if Bimage=Id_signal then
          begin
            adresse:=TCO[indexTCO,x,y].adresse;
            i:=Index_Signal(adresse);
            a:=Signaux[i].EtatSignal;     // a = état binaire du signal
            faire:=false;
            if Signaux[i].aspect<>20 then
              faire:=TestBit(a,jaune_cli) or TestBit(a,ral_60) or
              TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
              testBit(a,vert_cli) or testbit(a,blanc_cli)
            else
            begin
              // signal belge
              faire:=testBit(a,clignote);
            end;
            if faire then
            begin
              aspect:=Signaux[Index_Signal(adresse)].Aspect;
              case aspect of
               2 :  ImageSignal:=Formprinc.Image2feux;
               3 :  ImageSignal:=Formprinc.Image3feux;
               4 :  ImageSignal:=Formprinc.Image4feux;
               5 :  ImageSignal:=Formprinc.Image5feux;
               7 :  ImageSignal:=Formprinc.Image7feux;
               9 :  ImageSignal:=Formprinc.Image9feux;
              else  ImageSignal:=Formprinc.Image3feux;
              end;

              TailleY:=ImageSignal.picture.BitMap.Height; // taille du feu d'origine  (verticale)
              TailleX:=ImageSignal.picture.BitMap.Width;
              Orientation:=TCO[indexTCO,x,y].FeuOriente;
              // réduction variable en fonction de la taille des cellules
              calcul_reduction(frx,fry,LargeurCell[indexTCO],HauteurCell[indexTCO]);
              Dessine_signal_mx(PCanvasTCO[indexTCO],tco[indexTCO,x,y].x,tco[indexTCO,x,y].y,frx,fry,adresse,orientation);
            end;
          end;
        end;
      end;
    end;

    // fenêtre de pilotage manuel du signal -------------------
    if AdrPilote<>0 then
    begin
      a:=Signaux[0].EtatSignal;
      if Signaux[0].aspect<>20 then
      begin
        if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
           TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
           testBit(a,vert_cli) or testbit(a,blanc_cli) then
           begin
             //if clignotant then affiche('1',clyellow) else affiche('0',clwhite);
             Dessine_Signal_pilote;  // dessiner le signal en fonction du bit "clignotant"
           end;
      end
      else
      begin
        // signal belge
        if TestBit(a,clignote) or Signaux[0].contrevoie then dessine_signal_pilote;
      end;
      
    end;

    // fenetre de config du signal CDF
    if dessineCDF then
    begin
      a:=Signaux[0].EtatSignal;
      if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
         TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
         testBit(a,vert_cli) or testbit(a,blanc_cli) then
         Dessine_Signal_CDF;  // dessiner le feu CDF en fonction du bit "clignotant"
    end;
  end;

  // tempo retombée actionneur
  for i:=1 to maxTablo_act do
  begin
    if Tablo_actionneur[i].TempoCourante<>0 then
    begin
      dec(Tablo_actionneur[i].TempoCourante);
      if Tablo_actionneur[i].TempoCourante=0 then
      begin
        A:=Tablo_actionneur[i].adresse;
        s:=Tablo_actionneur[i].trainCourant;
        Affiche('Actionneur '+intToSTR(a)+' TrainDest='+s+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':0',clyellow);
        envoie_fonction_CDM(Tablo_actionneur[i].fonction,0,s);
      end;
    end;
  end;

  // pilotage des trains :
  // arret loco sur n secondes
  // démarrage loco temporisé
  // renvoi de la consigne
  // l'index de train 0 est le train courant
  for i:=1 to ntrains do
  begin
    a:=trains[i].TempoArret;
    if a<>0 then
    begin
      dec(a);
      trains[i].TempoArret:=a;
      if a=0 then vitesse_loco(trains[i].nom_train,i,trains[i].adresse,0,false) else
        if (a mod 10)=0 then
        begin
          vitesse:=trains[i].VitRalenti div 2;
          if (placement[i].inverse) then vitesse:=-vitesse;
          //Affiche('train'+intToSTR(i)+' '+intToSTR(vitesse),clred);
          vitesse_loco(trains[i].nom_train,i,trains[i].adresse,vitesse,false);
        end;

    end;

    a:=trains[i].TempoDemarre;
    if a<>0 then
    begin
      dec(a);
      trains[i].TempoDemarre:=a;
      if a=0 then
      begin
        vitesse:=trains[i].VitNominale;
        if (placement[i].inverse) then vitesse:=-vitesse;
        vitesse_loco(trains[i].nom_train,i,trains[i].adresse,vitesse,false);
      end;
    end;

    a:=trains[i].compteur_consigne;
    if a<>0 then
    begin
      dec(a);
      trains[i].compteur_consigne:=a;
      if a=0 then
      begin
        vitesse:=trains[i].Vitesse;
        if (placement[i].inverse) then vitesse:=-vitesse;
        vitesse_loco(trains[i].nom_train,i,trains[i].adresse,vitesse,false);
      end;
      //Affiche('vitesse ' +intToSTR(i)+' '+intToSTR(trains[i].vitesse),clred);
    end;
  end;

  // simulation
  if (i_simule<>0) then
  begin
    if not(MsgSim) then
    begin
      Affiche('Simulation en cours ',clCyan);MsgSim:=true;
    end;

    if intervalle_courant>=Intervalle then
    begin
      intervalle_courant:=0;
      tick:=Tablo_simule[i_simule].tick;
      //s:='Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick);Affiche(s,clYellow);

      // evt détecteur ?
      if Tablo_simule[I_simule].modele=det then
      begin
        s:='Simu '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' det='+intToSTR(Tablo_simule[i_simule].adresse)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Detecteur(Tablo_simule[i_simule].adresse, Tablo_simule[i_simule].etat=1, Tablo_simule[i_simule].train);  // créer évt détecteur
        StatusBar1.Panels[1].text:=s;
        //Affiche(s,clyellow);
      end;

      // evt actionneur ?
      if Tablo_simule[I_simule].modele=act then
      begin
        s:='Simu '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' act='+intToSTR(Tablo_simule[i_simule].adresse)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Act(Tablo_simule[i_simule].adresse,0,Tablo_simule[i_simule].etat, Tablo_simule[i_simule].train,false);
        StatusBar1.Panels[1].text:=s;
        //Affiche(s,clyellow);
      end;

      // evt aiguillage ?
      if Tablo_simule[I_simule].modele=aig then
      begin
        s:='Simu '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' aig='+intToSTR(Tablo_simule[i_simule].adresse)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Aig(Tablo_simule[i_simule].Adresse,Tablo_simule[i_simule].etat);  // créer évt aiguillage
        StatusBar1.Panels[1].text:=s;
        //Affiche(s,clyellow);
      end;

      inc(i_simule);
      if i_Simule>Index_simule then
      begin
        Index_Simule:=0;  // fin de simulation
        I_Simule:=0;
        MsgSim:=false;
        filtrageDet0:=SauvefiltrageDet0;
        Affiche('Fin de simulation',clCyan);
        StatusBar1.Panels[1].text:='';
      end;
    end;
    inc(intervalle_courant);
  end;

  // temporisation détecteur à 0
  for i:=1 to NbMaxDet do    // i=index détecteur
  begin
    a:=detecteur[i].tempo0;
    if a<>0 then
    begin
      dec(a);
      detecteur[i].tempo0:=a;
      if (a=0) then
      begin
        detecteur[i].tempo0:=99;   // indicateur tempo échue
        event_detecteur(i,false,detecteur[i].train);
      end;
    end;
  end;
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

  if pilote_acc(adr,const_droit,aigP) then
  begin
    s:='accessoire '+IntToSTR(adr)+' droit';
    Affiche(s,clyellow);
  end;
  Self.ActiveControl:=nil;
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

  if pilote_acc(adr,const_devie,aigP) then
  begin
    s:='accessoire '+IntToSTR(adr)+' dévié';
    Affiche(s,clyellow);
  end;
  Self.ActiveControl:=nil;
end;

procedure TFormPrinc.EditvalEnter(Sender: TObject);
begin
  if (Editval.Text<>'1') and (Editval.Text<>'2') then editval.text:='1';
end;

procedure TFormPrinc.BoutonRafClick(Sender: TObject);
begin
  Maj_Signaux(false);
end;

// erreur sur socket Lenz (interface XpressNet)
procedure TFormPrinc.ClientSocketInterfaceError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var   s : string;
begin
   s:='Erreur '+IntToSTR(ErrorCode)+' socket IP Xpressnet';
   case ErrorCode of
   10053 : begin
             s:=s+': Connexion avortée - Timeout';
             deconnecte_cdm;
           end;
   10054 : s:=s+': Connexion avortée par un tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refusée';
   10065 : s:=s+': Port non connecté';
   end;
   if nivDebug=3 then
   begin
     afficheDebug(s,clOrange);
     affiche(s,clOrange);
   end;
   parSocketLenz:=false;
   Formprinc.StatusBar1.Panels[4].Text:='';
   ErrorCode:=0;
end;

procedure TFormPrinc.ClientSocketCDMError(Sender: TObject;socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var s : string;
begin
   s:='Erreur '+IntToSTR(ErrorCode)+' socket IP CDM Rail';
   case ErrorCode of
   10053 : s:=s+': Connexion avortée - Timeout';
   10054 : s:=s+': Connexion avortée par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refusée';
   10065 : s:=s+': Port non connecté';
   end;

   if nivdebug=3 then
   begin
     afficheDebug(s,ClOrange);
     affiche(s,clOrange);
   end;
   deconnecte_cdm;
   if (portCommOuvert=false) and (parSocketLenz=false) then LabelTitre.caption:=titre;
   caption:=AF;
   ErrorCode:=0;
end;

// lecture depuis socket interface
procedure TFormPrinc.ClientSocketInterfaceRead(Sender: TObject; Socket: TCustomWinSocket);
var s : string;
begin
  s:=ClientSocketInterface.Socket.ReceiveText;
  if traceTrames then afficheDebug(chaine_hex(s),clWhite);
  chaine_recue:=chaine_recue+s;
  chaine_recue:=interprete_reponse(chaine_recue);
end;

// procédure Event appelée si on clique sur un checkbox de demande de feu blanc des images des feux
procedure TFormprinc.proc_checkBoxFB(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat : word;
    aspect,combine,adresse : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;         // état de la checkbox
  s:=Cb.Name;
  adresse:=extract_int(s);
  if adresse<>0 then
  begin
    i:=Index_Signal(adresse);
    if i=0 then exit;
    etat:=Signaux[i].EtatSignal;
    code_to_aspect(etat,aspect,combine);
    // si le feu est vert et que la coche est mise, substituer le blanc
    if ((aspect=vert) or (aspect=vert_cli)) and coche then
    begin
      Maj_Etat_Signal(Adresse,blanc);
      Envoi_signauxCplx;
    end;
    // si pas coché, on revient en normal
    if not(coche) then Maj_Signaux(false);
  end;
end;

// procédure Event appelée si on clique sur un checkbox de demande de feu vert des images des feux
procedure TFormprinc.proc_checkBoxFV(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat,adresse : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;       // état de la checkbox
  s:=Cb.name;
  adresse:=extract_int(s);
  if adresse<>0 then
  begin
    i:=Index_Signal(adresse);
    if i=0 then exit;
    etat:=Signaux[i].EtatSignal;
    // si le feu est vert et que la coche est mise, substituer le blanc
    if (etat=vert_f) and coche then
    begin
      Maj_Etat_Signal(Adresse,vert_cli);
      Envoi_signauxCplx;
    end;
    // si pas coché, on revient en normal
    if not(coche) then Maj_Signaux(false);
  end;
end;

// procédure Event appelée si on clique sur un checkbox de demande de feu blanc des images des feux
procedure TFormprinc.proc_checkBoxFR(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat,adresse : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;         // état de la checkbox
  s:=Cb.Name;                // le nom contient l'adresse du signal
  adresse:=extract_int(s);
  if adresse<>0 then
  begin
    i:=Index_Signal(adresse);
    if i=0 then exit;
    etat:=Signaux[i].EtatSignal;
    //affiche(IntToSTR(etat),clyellow);
    // si le feu est vert et que la coche est mise, substituer le blanc
    if (etat=semaphore_f) and coche then
    begin
      Maj_Etat_Signal(Adresse,semaphore_cli);
      Envoi_signauxCplx;
    end;
    // si pas coché, on revient en normal
    if not(coche) then Maj_Signaux(false);
  end;
end;

procedure TFormPrinc.MenuConnecterUSBClick(Sender: TObject);
begin
  Hors_tension:=false;
  connecte_USB;
end;

procedure deconnecte_usb;
begin
  if portCommOuvert then
  begin
    portCommOuvert:=false;
    MSCommUSBInterface.Portopen:=false;
    Affiche('Port USB déconnecté',clyellow);
    Formprinc.StatusBar1.Panels[3].Text:='';
  end;

  portCommOuvert:=false;
  with formprinc do
  begin
    ClientSocketInterface.close;
    MenuConnecterUSB.enabled:=true;
    DeConnecterUSB.enabled:=false;
    ConnecterCDMRail.enabled:=true;
    DeConnecterCDMRail.enabled:=false;
  end;
end;

// déconnecte le périphérique n°index
procedure deconnecte_usb_periph(index : integer);
var n : integer;
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 61 : numéro de périphérique hors limite ',clred);
    exit;
  end;
  if tablo_periph[index].PortOuvert then
  begin
    tablo_periph[index].PortOuvert:=false;
    n:=Tablo_periph[index].numComposant;
    if n=1 then MscommCde1.Portopen:=false;
    if n=2 then MscommCde2.Portopen:=false;

    if debug>0 then Affiche('Port COM'+intToSTR(Tablo_periph[index].NumCom)+' périphérique déconnecté',clyellow);
    Formprinc.StatusBar1.Panels[3].Text:='';
  end;
end;

// déconnecte le périphérique socket
procedure deconnecte_socket_periph(index : integer);
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 62 : numéro de périphérique hors limite ',clred);
    exit;
  end;
  if tablo_periph[index].PortOuvert then
  begin
    tablo_periph[index].PortOuvert:=false;
    if index=1 then Formprinc.ClientSocketCde1.close;
    if index=2 then Formprinc.ClientSocketCde1.close;
    if debug>0 then Affiche('Socket '+intToSTR(Tablo_periph[index].NumCom)+' périphérique déconnecté',clyellow);
    Formprinc.StatusBar1.Panels[3].Text:='';
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
    Affiche('Demande de connexion de l''interface en ethernet sur '+AdresseIP+':'+IntToSTR(PortInterface),clyellow);
    ClientSocketInterface.port:=portInterface;
    ClientSocketInterface.Address:=AdresseIP;
    ClientSocketInterface.Open;
    Hors_tension:=false;
  end;
end;

procedure TFormPrinc.MenuDeconnecterEthernetClick(Sender: TObject);
begin
  Affiche('Déconnexion interface ethernet',clyellow);
  ClientSocketInterface.Close;
end;

procedure TFormPrinc.AffEtatDetecteurs(Sender: TObject);
var j,adr,adrTrain : integer;
    s : string;
begin
  Affiche('Etat des détecteurs:',ClLime);
  nbDet1:=0;
  for j:=1 to NDetecteurs do
  begin
    adr:=Adresse_detecteur[j];
    s:='Dét '+intToSTR(adr)+'=';
    if Detecteur[adr].etat then
    begin
      s:=s+'1 ';
      inc(NbDet1);
    end
      else s:=s+'0 ';

    s:=s+detecteur[adr].train;
    AdrTrain:=detecteur[adr].AdrTrain;
    if AdrTrain<>0 then s:=s+' @='+intToSTR(AdrTrain);
    AdrTrain:=detecteur[adr].IndexTrain;
    if AdrTrain<>0 then s:=s+' IndexTrain='+intToSTR(AdrTrain);

    Affiche(s,clYellow);
  end;
  Affiche('Nombre de détecteurs à 1 :'+intToSTR(NbDet1),clYellow);
end;

// trouve l'index du détecteur de. Si pas trouvé, renvoie 0
function index_adresse_detecteur(de : integer) : integer;
var j : integer;
    trouve : boolean;
begin
  j:=1;
  repeat
    trouve:=Adresse_detecteur[j]=de;
    inc(j);
  until (j>NbMaxDet) or trouve;
  if trouve then index_adresse_detecteur:=j
  else index_adresse_detecteur:=0;
end;

procedure TFormPrinc.Etatdesaiguillages1Click(Sender: TObject);
var i,j,pos,r : integer;
    model : TEquipement;
    s : string;
begin
  Affiche('Etat des aiguillages:',ClLime);
  for i:=1 to maxaiguillage do
  begin
    s:='';
    model:=aiguillage[i].modele ;
    if (model<>rien) then
    begin

      if model<>crois then
      begin
        s:='Aiguillage '+IntToSTR(aiguillage[i].Adresse)+' : ';
        pos:=aiguillage[i].position;
        case pos of
          const_devie : s:=s+' dévié' ;
          const_droit : s:=s+' droit';
          const_inconnu : s:=s+' inconnue';
          else s:=s+' erreur ('+intToSTR(pos)+')';
        end;
      end;

      if model=triple then // aig triple
      begin
        j:=aiguillage[i].AdrTriple;
        s:=s+' Aig '+IntToSTR(j)+': '+intToSTR(aiguillage[index_aig(j)].position);
        if aiguillage[index_aig(j)].position=const_devie then s:=s+' (dévié)' else s:=s+' (droit)';
      end;

      if (model=Crois) then s:='Croisement '+IntToSTR(aiguillage[i].Adresse);

      r:=aiguillage[i].AdrTrain;
      if r<>0 then s:=s+'     Réservé par train @'+intToSTR(r);
      if s<>'' then Affiche(s,clWhite);
    end;
  end;
end;

procedure TFormPrinc.Codificationdesaiguillages1Click(Sender: TObject);
var i,adr : integer ;
    s : string;
begin
  Affiche('Codification interne des aiguillages',clCyan);
  Affiche('D=position droite S=position déviée P=pointe Z=détecteur',clCyan);
  for i:=1 to MaxAiguillage do
  begin
    adr:=aiguillage[i].adresse;
    begin
      s:=IntToSTR(i)+' i='+intToSTR(tablo_index_aiguillage[adr])+' Adr='+IntToSTR(adr);
      if aiguillage[i].modele=aig then s:=s+' Pointe=';

      if (aiguillage[i].modele=crois) then
      begin
        s:=s+' CROI:';
      end;

      if (aiguillage[i].modele=tjd) then
      begin
        s:=s+' TJD:';
        s:=s+intToSTR(aiguillage[i].EtatTJD)+' états ';
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
      if (aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs) or (aiguillage[i].modele=crois) then
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
// connnecter le socket de interface vers la centrale
procedure TFormPrinc.ClientSocketInterfaceConnect(Sender: TObject;Socket: TCustomWinSocket);
var trouve : boolean;
begin
  Affiche('Socket interface connecté ',clYellow);
  AfficheDebug('Socket interface connecté ',clYellow);
  ButtonEcrCV.Enabled:=true;
  ButtonLitCV.Enabled:=true;
  LireunfichierdeCV1.enabled:=true;
  LabelTitre.caption:=titre+' Interface connectée par Ethernet';
  Formprinc.StatusBar1.Panels[4].Text:=ClientSocketInterface.Address;
  etat_init_interface:=11; // socket connecté
  trouve:=test_protocole; // appelle l'état des détécteurs

  if trouve then // protocole reconnu
  begin
    if protocole=1 then
    begin
      etat_init_interface:=20;  // interface protocole reconnue
      parSocketLenz:=true;
    end;
    if (protocole=2) then
    begin
      init_dccpp;
      etat_init_interface:=20;
    end;
    // interface ethernet connectée, faire les init
    demande_etat_det;
    if AvecInit then
    begin
      if not(ConfigNulle) and not(fermeSC) and (AvecInitAiguillages) then
      begin
        Affiche('Positionnement des signaux',clYellow);
        init_aiguillages;   // initialisation des aiguillages
      end;
      if not(AvecInitAiguillages) and not(fermeSC) and (parSocketLenz or portCommOuvert)
       and AvecDemandeAiguillages then
      begin
        procetape('demande etats accessoires');
        demande_etat_acc;   // demande l'état des accessoires (position des aiguillages)
      end;
      envoi_signauxCplx;  // initialisation des signaux
    end;
  end;
  if not(trouve) then ClientSocketInterface.Close;
end;

// CDM rail connecté
procedure TFormPrinc.ClientSocketCDMConnect(Sender: TObject;Socket: TCustomWinSocket);
var s : string;
begin
  s:='Socket CDM rail connecté';
  LabelTitre.caption:=titre+' '+s;
  Affiche(s,clYellow);
  StatusBar1.Panels[2].Style:=psOwnerDraw;  // permet de déclencher l'event onDrawPanel
  StatusBar1.Panels[2].text:=' CDM connecté';
  CDM_connecte:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  DeConnecterCDMRail.enabled:=true;
end;





// décodage d'une trame CDM au protocole IPC
// la trame_CDM peut contenir 2000 caractères à l'initialisation du RUN.
procedure Interprete_trameCDM(trame_CDM:string);
var i,j,objet,k,l,erreur,posErr,adr,adr2,etat,etataig,
    vitesse,etatAig2,name,prv,nbre,nbreVir,long,index,posDes,AncNumTrameCDM : integer ;
    x,y,x2,y2 : longint ;
    nom,s,ss,train,commandeCDM : string;
    traite,sort : boolean;
label reprise;
begin
{
  trame_CDM:='S-R-14-0004-CMDACC-__ACK|000|S-E-14-5162-CMDACC-ST_DT|052|05|NAME=2756;OBJ=2756;AD=518;TRAIN=CC406526;STATE=1;';
  trame_cdm:=trame_cdm+'S-E-14-5163-CMDACC-ST_DT|049|05|NAME=2757;OBJ=2757;AD=518;TRAIN=_NONE;STATE=1;';
  trame_cdm:='';
  trame_cdm:=trame_cdm+'S-C-07-1373-DSCTRN-SPEED|029|03|NAME=CAMERA;AD=6;TMAX=120;'  ;
  trame_cdm:=trame_cdm+'S-C-07-1374-DSCTRN-__END|000|' ;
  //S-R-01-0004-CMDTRN-__ERR|048|03|ERR=300;SEV=2;MSG=Throttle_By_Name_Not_Found;
  }
  //affiche(trame_cdm,clLime);
  residuCDM:='';
  AckCDM:=trame_CDM<>'';

  k:=0;
  repeat
    // trouver la longueur de la chaîne de paramètres entre les 2 premiers |xxx|
    i:=pos('|',trame_CDM);
    if i=0 then
    begin
      if debugTrames then
      begin
        Affiche('tronqué1 : '+trame_CDM,clred);
        AfficheDebug('tronqué1 : '+trame_CDM,clyellow);
      end;
      residuCDM:=trame_CDM;
      Nbre_recu_cdm:=0;
      exit;
    end;
    j:=posEx('|',trame_CDM,i+1);
    if j=0 then
    begin
      if debugTrames then
      begin
        Affiche('tronqué2 : '+trame_CDM,clRed);
        AfficheDebug('tronqué2 : '+trame_CDM,clyellow);
      end;
      residuCDM:=trame_CDM;
      Nbre_recu_cdm:=0;
      exit;
    end;

    l:=length(trame_cdm)-j;
    val(copy(trame_CDM,i+1,5),long,erreur);

    //Affiche('long chaine param='+intToSTR(long),clyellow);
    if long=0 then
    begin
      //if debugTrames then Affiche('Longueur nulle',clYellow);
      if pos('ACK',trame_cdm)<>0 then Ack_cdm:=true;
      if pos('DSCTRN-__END',trame_cdm)<>0 then
      begin
        //fin de la description des trains
        FormPrinc.ComboTrains.Items.Clear;

        // on remplace les trains du combo et de la base (non stockée)
        for i:=1 to ntrains_cdm do
        begin
          Formprinc.ComboTrains.Items.Add(trains_cdm[i].nom_train);
          Trains[i].nom_train:=trains_cdm[i].nom_train;
          Trains[i].adresse:=Trains_cdm[i].adresse;
          Trains[i].vitmax:=Trains_cdm[i].vitmax;
        end;
        ntrains:=ntrains_cdm;
        with formprinc do
        begin
          ComboTrains.ItemIndex:=0;
          editadrtrain.Text:=inttostr(trains_cdm[1].adresse);
        end;


      end;
      delete(trame_cdm,1,j);
      goto reprise;
    end;

    if long>l then
    begin
      if debugTrames then
      begin
        Affiche('tronqué3 : '+trame_CDM,clRed);
        AfficheDebug('tronqué3 : '+trame_CDM,clyellow);
      end;
      residuCDM:=trame_CDM;
      Nbre_recu_cdm:=0;
      exit;
    end;

    reprise:
    if long<>0 then
    begin
      // nombre de paramètres
      val(copy(trame_CDM,j+1,5),nbre,erreur);
      //Affiche('nbre='+IntToSTR(nbre),clyellow);
      // compter le nombre de virgules qui doit être égal au nombre de paramètres
      NbreVir:=0;  // nombre de virgules
      repeat
        i:=posEx(';',trame_CDM,i+1);
        if i<>0 then inc(NbreVir);
      until (i=0) or (NbreVir=nbre);
      if (i=0) then
      begin
      if debugTrames then
        begin
          Affiche('tronqué4 : '+trame_CDM,clRed);
          AfficheDebug('tronqué4 : '+trame_CDM,clyellow);
        end;
        residuCDM:=trame_CDM;
        Nbre_recu_cdm:=0;
        exit;
      end;

      CommandeCDM:=copy(trame_CDM,1,i);
      //if debugTrames then AfficheDebug(commandeCDM,clorange);
      Delete(trame_CDM,1,i);

      //Affiche('long chaine param='+intToSTR(long),clyellow);
      if long=0 then
      begin
        //if debugTrames then Affiche('Longueur nulle',clYellow);
        if pos('ACK',trame_cdm)<>0 then Ack_cdm:=true;
        delete(trame_cdm,1,j);
        goto reprise;
      end;

      posERR:=pos('_ERR',commandeCDM);
      if posErr<>0 then
      begin
        if pos('ERR=200',commandeCDM)<>0 then s:='Erreur CDM : réseau non chargé '
        else
        if pos('ERR=500',commandeCDM)<>0 then s:='Erreur CDM : serveur DCC non lancé '
        else
        if pos('ERR=300',commandeCDM)<>0 then s:='Erreur CDM : RUN non lancé ou train non trouvé '
        else
        begin
          j:=pos('MSG=',commandeCDM);
          if j<>0 then s:='CDM: '+copy(commandeCDM,j,i-j);
        end;
        Affiche(s,clred);
        delete(commandeCDM,1,i);
      end;

      // description des trains  03|NAME=BB16024;AD=3;TMAX=120;'
      posDES:=pos('DSCTRN-SPEED',commandeCDM);
      if posDES<>0 then
      begin
        inc(ntrains_cdm);
        delete(commandeCDM,1,posDES+12);

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          trains_cdm[ntrains_cdm].nom_train:=ss;
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,trains_cdm[ntrains_cdm].adresse,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('TMAX=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          val(ss,trains_cdm[ntrains_cdm].vitmax,erreur);
          //s:='AD='+IntToSTR(adr)f;
          Delete(commandeCDM,i,l-i+1);
        end;
      end;

      // évènement aiguillage. Le champ AD2 n'est pas forcément présent
      i:=pos('CMDACC-ST_TO',commandeCDM);
      if i<>0 then
      begin
        delete(commandeCDM,i,12);

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          nom:=ss;
          Delete(commandeCDM,i,l-i+1);
        end; 
        
        i:=posEx('OBJ=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,objet,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          //s:='AD='+IntToSTR(adr);
          Delete(commandeCDM,i,l-i+1);
        end;  

        i:=posEx('AD2=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,adr2,erreur);
          //s:='AD='+IntToSTR(adr);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('STATE=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,etat,erreur);
          //s:='AD='+IntToSTR(adr);
          Delete(commandeCDM,i,l-i+1);
        end;

        //Affiche('Aig '+inttostr(adr)+' pos='+IntToSTR(etat),clyellow);
        //Affiche(commandeCDM,clyellow);
        index:=index_aig(adr);
        if index<>0 then
        begin
          // conversion des états CDM en état Xpressnet standardisés
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
            if aiguillage[index].EtatTJD=4 then
            begin
              adr2:=aiguillage[index].Ddroit;  // 2eme adresse de la TJD
              if (aiguillage[index].inversionCDM=0) and (aiguillage[index_aig(adr2)].inversionCDM=0) then // pas d'inversions
              case etat of
                0 : begin etatAig:=const_droit;EtatAig2:=const_droit;end;
                1 : begin etatAig:=const_devie;EtatAig2:=const_droit;end;
                4 : begin etatAig:=const_devie;EtatAig2:=const_devie;end;
                5 : begin etatAig:=const_droit;EtatAig2:=const_devie;end;
              end;

              if (aiguillage[index].inversionCDM=1) then    // inversion tjd1
              case etat of
                0 : begin etatAig:=const_devie;EtatAig2:=const_droit;end;
                1 : begin etatAig:=const_droit;EtatAig2:=const_droit;end;
                4 : begin etatAig:=const_droit;EtatAig2:=const_devie;end;
                5 : begin etatAig:=const_devie;EtatAig2:=const_devie;end;
              end;

              if (aiguillage[index_aig(adr2)].inversionCDM=1) then    // inversion tjd2
              case etat of
                0 : begin etatAig:=const_droit;EtatAig2:=const_devie;end;
                1 : begin etatAig:=const_devie;EtatAig2:=const_devie;end;
                4 : begin etatAig:=const_devie;EtatAig2:=const_droit;end;
                5 : begin etatAig:=const_droit;EtatAig2:=const_droit;end;
              end;

              Event_Aig(adr,etatAig);
              Event_Aig(adr2,etatAig2);
            end;

            if aiguillage[index].EtatTJD=2 then
            begin
              if (aiguillage[index].inversionCDM=0) then
              case etat of
                0 : etatAig:=const_droit;
                1 : etatAig:=const_devie;
              end;

              if (aiguillage[index].inversionCDM=1) then
              case etat of
                0 : etatAig:=const_devie;
                1 : etatAig:=const_droit;
              end;
              Event_Aig(adr,etatAig);
            end;
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
          s:='Recu evt aig de CDM pour un aiguillage '+intToSTR(Adr)+' non déclaré';
          Affiche(s,clorange);
          AfficheDebug(s,clOrange);
        end;
      end;

      // évènement détecteur. Si det=1, Le nom du train est souvent _NONE
      // si det=0 le nom du train est toujours _NONE
      i:=pos('CMDACC-ST_DT',commandeCDM);
      if i<>0 then
      begin
        Delete(commandeCDM,i,12);

        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('TRAIN=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          train:=copy(commandeCDM,i+6,l-i-6);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('STATE=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,etat,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          nom:=copy(commandeCDM,i+6,l-i-6);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('OBJ=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,objet,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        Event_detecteur(Adr,etat=1,train);
      end ;

      // évènement signal - non stocké ni interprété
      // S-E-01-0021-CMDACC-ST_SG|039|05|NAME=150;OBJ=150;AD=0;AD2=0;STATE=0;
      i:=pos('CMDACC-ST_SG',commandeCDM);
      if i<>0 then
      begin
        Delete(commandeCDM,i,12);
        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          nom:=copy(commandeCDM,i+5,l-i-5);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('OBJ=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,objet,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;  

        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('AD2=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,adr2,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;  

        i:=posEx('STATE=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,etat,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        s:='SignalCDM '+intToSTR(adr)+'='+IntToStr(etat);
        if afftiers then AfficheDebug(s,ClSkyBlue);
      end;

      // évènement actionneur
      // attention un actionneur qui repasse à 0 ne contient pas de nom de train
      // S-E-03-0157-CMDACC-ST_AC|049|05|NAME=0;OBJ=7101;AD=815;TRAIN=CC406526;STATE=1;
      i:=pos('CMDACC-ST_AC',commandeCDM);
      if i<>0 then
      begin
        Delete(commandeCDM,i,12);
        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if i<>0 then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('OBJ=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if i<>0 then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,objet,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if i<>0 then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          nom:=ss;
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('TRAIN=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if i<>0 then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          train:=ss;
          Delete(commandeCDM,i,l-i+1);
        end;
        
        i:=posEx('STATE=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if i<>0 then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,etat,erreur);
          Delete(commandeCDM,i,l-i+1);
        end;
        
        if AffAigDet then AfficheDebug('Actionneur AD='+intToSTR(adr)+' Nom='+nom+' Train='+train+' Etat='+IntToSTR(etat),clyellow);
        Event_act(adr,0,etat,train,false); // déclenche évent actionneur
      end;

      // évènement position des trains
      // S-E-01-0039-CDMTRN-SPDXY|063|07|NAME=TRAIN_3;AD=0;SPEED=3;X=24735;Y=19630;X2=16874;Y2=19630;
      i:=pos('CMDTRN-SPDXY',commandeCDM);
      if i<>0 then
      begin
        Delete(commandeCDM,i,12);
        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          s:='Train AD='+IntToSTR(adr);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          train:=copy(commandeCDM,i+5,l-i-5);
          s:=s+' '+train;
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('SPEED=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,vitesse,erreur);
          s:=s+' SPEED='+IntToSTR(vitesse);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('X=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+2,l-i-2);
          val(ss,x,erreur);
          s:=s+' X='+IntTostr(x);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('Y=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+2,l-i-2);
          val(ss,y,erreur);
          s:=s+' Y='+IntTostr(y);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('X2=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,x2,erreur);
          s:=s+' X2='+IntTostr(x2);
          Delete(commandeCDM,i,l-i+1);
        end;

        if (i<>0) and (l<>0) then
        begin
          i:=posEx('Y2=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,y2,erreur);
          s:=s+' Y2='+IntTostr(y2);
          Delete(commandeCDM,i,l-i+1);
        end;
        if horloge then verifie_train_horaire(adr,train,vitesse);
        // fait bouger le train dans la fenetre cdm
        if fichier_module_CDM then Aff_train(adr,train,x,y,x2,y2);
        if afftiers then afficheDebug(s,clAqua);
      end;

      // évènement vitesse des trains - non stocké ni interprété
      //S-E-01-0189-CDMTRN-SPEED|054|06|NAME=TRAIN_3;AD=0;SPEED=99;RMAX=120;CMAX=120;REQ=8;
      i:=pos('CMDTRN-SPEED',commandeCDM);
      if i<>0 then
      begin
        Delete(commandeCDM,i,12);
        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          s:='Train AD='+IntToSTR(adr);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          train:=copy(commandeCDM,i+5,l-i-5);
          s:=s+' '+train;
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('SPEED=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,vitesse,erreur);
          s:=s+' SPEED='+IntToSTR(vitesse);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('RMAX=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          val(ss,x,erreur);
          s:=s+' RMAX='+IntTostr(x);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('CMAX=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          val(ss,y,erreur);
          s:=s+' CMAX='+IntTostr(y);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('REQ=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,x2,erreur);
          s:=s+' REQ='+IntTostr(x2);
          Delete(commandeCDM,i,l-i+1);
        end;

        if afftiers then afficheDebug(s,clAqua);

      end;


      // évènement port CDM - non stocké ni interprété
      // S-E-01-0188-CDMTRN-P_CDM|060|07|NAME=TRAIN_3;AD=0;SPEED=99;SEG=38;PORT=1;X=35565;Y=12364;
      i:=pos('CMDTRN-P_CDM',commandeCDM);
      if i<>0 then
      begin
        Delete(commandeCDM,i,12);
        i:=posEx('AD=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+3,l-i-3);
          val(ss,adr,erreur);
          s:='Train AD='+IntToSTR(adr);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('NAME=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          train:=copy(commandeCDM,i+5,l-i-5);
          s:=s+' '+train;
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('SPEED=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+6,l-i-6);
          val(ss,vitesse,erreur);
          s:=s+' SPEED='+IntToSTR(vitesse);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('SEG=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+4,l-i-4);
          val(ss,x,erreur);
          s:=s+' SEG='+IntTostr(x);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('PORT=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+5,l-i-5);
          val(ss,y,erreur);
          s:=s+' PORT='+IntTostr(y);
          Delete(commandeCDM,i,l-i+1);
        end;

        i:=posEx('X=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+2,l-i-2);
          val(ss,x2,erreur);
          s:=s+' X='+IntTostr(x2);
          Delete(commandeCDM,i,l-i+1);
        end;

        if afftiers then afficheDebug(s,clAqua);

        i:=posEx('Y=',commandeCDM,1);l:=posEx(';',commandeCDM,i);
        if (i<>0) and (l<>0) then
        begin
          ss:=copy(commandeCDM,i+2,l-i-2);
          val(ss,x2,erreur);
          s:=s+' Y='+IntTostr(x2);
          Delete(commandeCDM,i,l-i+1);
        end;

        if afftiers then afficheDebug(s,clAqua);
      end;

      //S-E-03-0477-CMDTRN-DCCSF|137|19|NAME=CC406526;AD=4;MODE=128;STEP=100;CSTEP=75;FX0=0;FX1=0;FX2=0;FX3=0;FX4=0;FX5=0;FX6=0;FX7=0;FX8=0;FX9=0;FX10=0;FX11=0;FX12=0;FX13=0;
      // évènement train
      // pas traité !!

      inc(k);
      //Affiche('k='+intToSTR(k),clyellow);
    end;

    sort:=(length(trame_CDM)<10) or (k>=2000);
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
  recuCDM:=ClientSocketCDM.Socket.ReceiveText;

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
  Interprete_trameCDM(residuCDM+recuCDM);  // residuCDM est le morceau tronqué de la fin de la réception précédente
end;

procedure TFormPrinc.ConnecterCDMrailClick(Sender: TObject);
begin
  if not(connecte_CDM) then affiche('CDM Rail non connecté',clorange);
end;

procedure TFormPrinc.DeconnecterCDMRailClick(Sender: TObject);
begin
  deconnecte_CDM;
end;

procedure TFormPrinc.ClientSocketCDMDisconnect(Sender: TObject;  Socket: TCustomWinSocket);
begin
  deconnecte_cdm;
end;

procedure TFormPrinc.CodificationdessignauxClick(Sender: TObject);
var nation,i,j,k,l,d,NfeuxDir,nc,asp : integer;
    s,s2 : string;
begin
  Affiche('Codification interne des signaux:',ClYellow);

  for i:=1 to NbreSignaux do
  begin
    s:=IntToSTR(i)+' i='+intToSTR(tablo_index_signal[Signaux[i].Adresse])+' Adr='+IntToSTR(Signaux[i].Adresse);
    s:=s+' décodeur='+IntToStr(Signaux[i].decodeur);
    asp:=Signaux[i].aspect;
    if asp<>20 then nation:=1 else nation:=2;

    // non directionnel
    if not(isDirectionnel(i)) then
    begin
      l:=Signaux[i].aspect;
      if asp=20 then l:=5;
      s:=s+' SIG Nbrefeux='+intToSTR(l)+' ';
      s:=s+' Det='+IntToSTR(Signaux[i].Adr_det1);
      s:=s+' El_Suiv1='+IntToSTR(Signaux[i].Adr_el_suiv1)+' Type suiv1='+BTypeToChaine(Signaux[i].Btype_suiv1);
      case Signaux[i].Btype_suiv1 of
      det : s:=s+' (det) ';
      aig,tjs,tjd : s:=s+' (aig ou TJD-S) ';
      triple : s:=s+' (aig triple) ';
      end;
      if Signaux[i].decodeur=6 then
      s:=s+'Cible unisemaf='+intToSTR(Signaux[i].Unisemaf);

      // conditions sur carré
      l:=1;
      repeat
        nc:=Length(Signaux[i].condcarre[l])-1 ;
        if (nc>0) and (l=1) then begin Affiche(s,clYellow);s:='';end;  // pour afficher sur 2 lignes
        for k:=1 to nc do
        begin
          s:=s+'A'+IntToSTR(Signaux[i].condcarre[l][k].Adresse)+Signaux[i].condcarre[l][k].PosAig;
            if k<nc then s:=s+',';
        end;
        inc(l);
        if nc>0 then s:=s+'/';
      until (nc<=0) or (l>6);

      if Signaux[i].decodeur=7 then
      begin
        s:=s+' SR(';
        for l:=1 to 8 do
        begin
          s:=s+intToSTR(Signaux[i].SR[l].sortie1)+',';
          s:=s+intToSTR(Signaux[i].SR[l].sortie0);
          if l<8 then s:=s+'/' else s:=s+')';
        end;
      end;
      if (Signaux[i].decodeur=2) or (Signaux[i].decodeur=5) then
      begin
        s:=s+' MOT(';
        for l:=1 to 19 do
        begin
          s:=s+intToSTR(Signaux[i].SR[l].sortie1);
          if l<19 then s:=s+',' else s:=s+')';
        end;
      end;

      k:=1;
      s:=s+'Dét amont niv 2 : ';
      repeat
        d:=Signaux[i].DetAmont[k];
        if d<>0 then
        begin
          s:=s+IntToSTR(d)+' ';
        end;
        inc(k);
      until (d=0) or (k=Mtd);

    end

    else
    // signal directionnel
    begin
      s:=s+' DIR Nbrefeux='+IntToSTR(Signaux[i].aspect-10)+' ';
      NfeuxDir:=Signaux[i].aspect-10;
      for j:=1 to NfeuxDir+1 do
      begin
        s:=s+'(';
        for k:=1 to Length(Signaux[i].AigDirection[j])-1 do
        begin
          s:=s+IntToSTR(Signaux[i].AigDirection[j][k].adresse) + Signaux[i].AigDirection[j][k].posaig+' ';
        end;
        s:=s+')';
      end;
    end;
    Affiche(s,clYellow);
    if s2<>'' then Affiche('Conditions de carré : '+s2,clYellow);
  end;
end;

procedure TFormPrinc.ClientSocketInterfaceDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  parSocketLenz:=False;
  Formprinc.StatusBar1.Panels[4].Text:='';
end;

procedure TFormPrinc.FichierSimuClick(Sender: TObject);
begin
  if formSimulation<>nil then FormSimulation.showModal;
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

  if protocole=1 then
  begin
    //s:=#$ff+#$fe+#$23+#$1e+Char(adr)+Char(valeur);    //CV de 512 à 767 V3.4
    //s:=#$ff+#$fe+#$23+#$1d+Char(adr)+Char(valeur);    //CV de 256 à 511 V3.4
    s:=#$23+#$16+Char(adr)+Char(valeur);      //CV de 1 à 256
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
    // la centrale passe en mode service (p23)
  end;
  if protocole=2 then
  begin
    s:='<W '+inttostr(adr)+' '+intToSTR(valeur)+' 1 1>';
    envoi(s);
  end;
  Affiche('CV'+intToSTR(Adr)+'='+intToSTR(valeur),clyellow);
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

  if protocole=1 then
  begin
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

  if protocole=2 then
  begin
    s:='<R '+intToSTR(cv)+' 1 1>';
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
    sa:=sa+'Cv'+IntToSTR(cv)+'='+IntToSTR(Tablo_cv[1])+' ';
    Affiche(sa,clyellow);sa:='';
  end;
end;

procedure TFormPrinc.Quitter1Click(Sender: TObject);
begin
  close;
end;

procedure TFormPrinc.ConfigClick(Sender: TObject);
begin
  if ConfigPrete then
  begin
    formconfig.showmodal;
    {$IF CompilerVersion >= 28.0}
    change_style;
    {$IFEND}
    // ne pas faire close : déja provoqué par le self de la fermeture
  end;
end;

procedure TFormPrinc.Codificationdesactionneurs1Click(Sender: TObject);
var i,typ,adract,etatAct,fonction,v,acc,sortie : integer;
    loc,act,son,periph : boolean;
    s,s2 : string;
begin
  if (maxTablo_act=0) and (NbrePN=0) then
  begin
    Affiche('Aucun actionneur déclaré',clCyan);
    exit;
  end;

  Affiche('Codification interne des actionneurs',clCyan);
  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].trainDecl;
    etatAct:=Tablo_actionneur[i].etat ;
    AdrAct:=Tablo_actionneur[i].adresse;
    s2:=Tablo_actionneur[i].trainDecl;
    acc:=Tablo_actionneur[i].accessoire;
    sortie:=Tablo_actionneur[i].sortie;
    fonction:=Tablo_actionneur[i].fonction;
    loc:=Tablo_actionneur[i].loco;
    act:=Tablo_actionneur[i].act;
    son:=Tablo_actionneur[i].son;
    periph:=Tablo_actionneur[i].periph;
    typ:=Tablo_actionneur[i].typdeclenche;

    if typ=3 then s:='Mem '+intToSTR(adrAct)+' '+inttostr(Tablo_actionneur[i].Adresse2);
    if typ=0 then s:=intToSTR(adrAct);
    if typ=2 then s:='Aig '+intToSTR(AdrAct);

    if loc then
      s:='FonctionF  Déclencheur='+s+' :'+intToSTR(etatAct)+' TrainDécl='+s2+' TrainDest='+Tablo_actionneur[i].TrainDest+' F'+IntToSTR(fonction)+
              ' Temporisation='+intToSTR(tablo_actionneur[i].Tempo);
    if act then
      s:='Accessoire Déclencheur='+s+' :'+intToSTR(etatAct)+' TrainDécl='+s2+' Adresse='+IntToSTR(acc)+
              ' sortie='+intToSTR(sortie);
    if son then
      s:='Son        Déclencheur='+s+' :'+intToSTR(etatAct)+' TrainDécl='+s2+
         '  Fichier:'+Tablo_actionneur[i].FichierSon;

    if periph then
      s:='Périphérique Déclencheur='+s;

    Affiche(s,clYellow);
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
    s:='                Compteur trains engagés sur PN='+intToSTR(tablo_PN[i].compteur);
    Affiche(s,clyellow);

    if tablo_PN[i].Voie[1].ActFerme<>0 then
    // par actionneur
    begin
      for v:=1 to Tablo_PN[i].nbvoies do
      begin
        s:='                Voie '+IntToSTR(v)+': Actionneur de fermeture='+intToSTR(Tablo_PN[i].voie[v].ActFerme);
        s:=s+' Actionneur d''ouverture='+intToSTR(Tablo_PN[i].voie[v].ActOuvre);
        Affiche(s,clyellow);
      end;
    end
    else
    // par zone de détection
      for v:=1 to Tablo_PN[i].nbvoies do
      begin
        s:='                Voie '+IntToSTR(v)+': Zones de fermeture='+intToSTR(tablo_PN[i].Voie[v].detZ1F)+'-'+intToSTR(tablo_PN[i].Voie[v].detZ2F);
        s:=s+'  Zones d''ouverture='+intToSTR(tablo_PN[i].Voie[v].detZ1O)+'-'+intToSTR(tablo_PN[i].Voie[v].detZ2O);
        Affiche(s,clyellow);
      end;
  end;
end;

procedure TFormPrinc.ButtonArretSimuClick(Sender: TObject);
begin
  Index_Simule:=0;  // fin de simulation
  I_Simule:=0;
  MsgSim:=false;
  filtrageDet0:=SauvefiltrageDet0;
  StopSimu:=true;
  Affiche('Fin de simulation',clCyan);
end;

procedure TFormPrinc.OuvrirunfichiertramesCDM1Click(Sender: TObject);
var  s : string;
   fte : textFile;
begin
  s:=GetCurrentDir;
  //s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  OpenDialog.InitialDir:=s;
  OpenDialog.Title:='Ouvrir un fichier de trames CDM (protocole COM-IPC)';
  OpenDialog.DefaultExt:='txt';
  OpenDialog.Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';
  if openDialog.Execute then
  begin
    ButtonArretSimu.Visible:=true;
    s:=openDialog.FileName;
    assignFile(fte,s);
    reset(fte);
    StopSimu:=false;
    while not(eof(fte)) and (StopSimu=false) do
    begin
      readln(fte,s);
      Affiche(s,clLime);
      sleep(100);
      Interprete_trameCDM(s);
      application.processmessages;
    end;
    closeFile(fte);
  end;
end;

procedure TFormPrinc.ButtonAffTCOClick(Sender: TObject);
var i : integer;
begin
  for i:=1 to NbreTCO do
    Affiche_Fenetre_TCO(i,true);
end;

procedure TFormPrinc.ButtonLanceCDMClick(Sender: TObject);
begin
  Lance_CDM(true);
end;

procedure TFormPrinc.Affichefentredebug1Click(Sender: TObject);
begin
  if debugaffiche then
  begin
    formdebug.windowState:=wsNormal; //Maximized;
    formDebug.show;
  end;
end;

procedure TFormPrinc.locoClick(Sender: TObject);
var i,adr,vit,erreur : integer;
    s : string;
begin
  // vitesse et direction 18 pas
  s:=editAdrTrain.Text;
  val(s,adr,erreur);
  if (erreur<>0) or (adr<0) then exit;
  //if not(portCommOuvert) and not(parSocketLenz) and not(CDM_Connecte) then exit;
  s:=editVitesse.Text;
  val(s,vit,erreur);
  if (erreur<>0) or (vit<-100) or (vit>100) then exit;
  i:=0;s:='';
  if combotrains.itemindex<>-1 then
  begin
    s:=combotrains.Items[combotrains.itemindex];
    i:=index_train_nom(s);
  end;
  Affiche('Commande vitesse train '+s+' ('+intToSTR(adr)+') à '+IntToSTR(vit)+'%',cllime);
  vitesse_loco(s,i,adr,vit,true);
  if s='' then s:=intToSTR(adr);
end;

// pour déplacer l'ascenseur de l'affichage automatiquement en bas
procedure TFormPrinc.FenRichChange(Sender: TObject);
begin
  SendMessage(FenRich.handle,WM_VSCROLL,SB_BOTTOM,0);
end;

procedure TFormPrinc.Copier1Click(Sender: TObject);
begin
  FenRich.CopyToClipboard;
  FenRich.SetFocus;
end;


procedure TFormPrinc.Toutslectionner1Click(Sender: TObject);
begin
  FenRich.SelectAll;
end;

procedure TFormPrinc.Etatdessignaux1Click(Sender: TObject);
var Adr,i : integer;
    s : string;
begin
  for i:=1 to NbreSignaux do
  begin
    Adr:=Signaux[i].Adresse;
    s:='Signal '+IntToSTR(Adr)+' Etat=';
    s:=s+chaine_signal(adr);
    Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Etatdeszonespartrain1Click(Sender: TObject);
var i,j,n,train : integer;
    couleur : tcolor;
    rien,aff : boolean;
    s,ss : string;
begin
  Affiche('',clyellow);
  Affiche('Historique de l''état des zones par train',clWhite);
  rien:=true;
  for train:=1 to 20 do
  begin
    n:=TrainZone[train].Nbre;
    for i:=1 to n do
    begin
      rien:=false;
      s:='Train='+intToSTR(train)+' '+TrainZone[train].train;
      if TrainZone[train].adrTrain<>0 then s:=s+' @='+intToSTR(TrainZone[train].adrTrain);
      s:=s+' index='+intToSTR(i);
      s:=s+' '+intToSTR(TrainZone[train].Zone[i].det1);
      s:=s+' '+intToSTR(TrainZone[train].Zone[i].det2);
      couleur:=((train - 1) mod NbCouleurTrain) +1;
      Affiche(s,CouleurTrain[couleur]);
    end;
  end;
  Affiche('Liste des zones actuellement occupées:',clWhite);
  i:=0;
  repeat
    j:=0;
    repeat
      aff:=MemZone[i,j].etat;
      if aff then
      begin
        Affiche('MemZone['+intToSTR(i)+','+intToSTR(j)+'] '+MemZone[i,j].train+' @='+intToSTR(MemZone[i,j].AdrTrain)+' Train n°'+intToSTR(MemZone[i,j].IndexTrain),couleurTrain[MemZone[i,j].IndexTrain]);
        rien:=false;
      end;
      inc(j);
    until (j>NbMaxDet);
    inc(i);
  until (i>NbMaxDet);

  Affiche('Derniers éléments scannés:',clWhite);
  for i:=1 to idEl do
  begin
    Affiche(IntToSTR(elements[i].adresse),clLime);
  end;

  for i:=1 to n_trains do
  begin
    s:='Event det train '+intToSTR(i);
    n:=event_det_train[i].AdrTrain;
    if n<>0 then s:=s+' @'+intToSTR(n);
    ss:=event_det_train[i].nom_train;
    if ss<>'' then s:=s+' '+ss;
    Affiche(s,couleurTrain[i]);

    n:=event_det_train[i].signal_rouge;
    if n<>0 then Affiche('Arreté devant signal '+intToSTR(n),clyellow);
    for j:=1 to event_det_train[i].NbEl do
    begin
      s:=intToSTR(event_det_train[i].Det[j].adresse);
      Affiche(s,couleurTrain[i]);
    end;
  end;

  {
  Affiche('Evènements détecteurs par train',clWhite);
  for i:=1 to n_trains do
  begin
    index_couleur:=((i - 1) mod NbCouleurTrain) +1;
    couleur:=couleurTrain[index_couleur];
    Affiche('Train '+intToSTR(i),couleur);
    for j:=1 to N_event_tick do
    begin
      if event_det_tick[j].train=i then Affiche(intToSTR(event_det_tick[j].adresse)+' '+intToSTR(event_det_tick[j].etat),couleur);
    end;
  end;
  }
  if rien then Affiche('Aucune zone n''a été déclenchée',clOrange);
end;

procedure TFormPrinc.Apropos1Click(Sender: TObject);
var i,t,t1 : integer;
    s: string;
begin
  Affiche(' ',clyellow);
  s:='Signaux complexes GL version '+versionSC+sousVersion;
  {$IF CompilerVersion >= 28.0}
  s:=s+' D11';
  {$IFEND}
  s:=s+' (C) 2022-24 F1IWQ Gily TDR';
  Affiche(s,clWhite);

  Affiche('Double cliquez sur un des liens ci-dessous',clWhite);

  FenRich.SelStart:=length(FenRich.Text);
  FenRich.SelAttributes.Style:=[fsUnderline];
  FenRich.lines.add('https://github.com/f1iwq2/Signaux_complexes_GL');
  RE_ColorLine(FenRich,FenRich.lines.count-1,clAqua);

  FenRich.SelStart:=length(FenRich.Text);
  FenRich.SelAttributes.Style:=[fsUnderline];
  FenRich.Lines.add('https://github.com/f1iwq2/Signaux_complexes_GL/releases');
  RE_ColorLine(FenRich,FenRich.lines.count-1,clAqua);

  FenRich.SelStart:=length(FenRich.Text);
  FenRich.SelAttributes.Style:=[fsUnderline];
  FenRich.lines.add('http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906');
  RE_ColorLine(FenRich,FenRich.lines.count-1,clAqua);

  Affiche('Ce programme pilote des signaux complexes et les trains de façon autonome ou avec CDM rail ',ClYellow);
  Affiche('en fonction des détecteurs mis à 1 ou 0 par des locomotives',ClYellow);
  Affiche('en circulation sur le réseau',ClYellow);
  Affiche('En vert : Trames envoyées à l''interface',ClWhite);
  Affiche('En blanc : Trames brutes reçues de l''interface',ClWhite);
  Affiche('En rouge : erreurs et défauts',ClWhite);
  Affiche('En orange : pilotage des signaux / erreurs mineures',ClWhite);
  Affiche('En bleu : pilotage des aiguillages',ClWhite);
  Affiche('En jaune : rétrosignalisation reçue depuis l''interface',ClWhite);
  t:=0;
  t1:=sizeof(TTCO);
  for i:=1 to nbreTCO do
    t:=t+t1*NbreCellX[i]*NbreCellY[i];
  Affiche('Taille des '+intToSTR(NbreTCO)+' TCOs : '+intToSTR(t)+' octets',clOrange);
  Affiche('Taille des aiguillages : '+intToSTR(SizeOf(aiguillage) )+' octets',clorange);
  Affiche('Taille des signaux : '+intToSTR(SizeOf(Signaux) )+' octets',clorange);
  Affiche('Taille des branches : '+intToSTR(SizeOf(brancheN) )+' octets',clorange);
  Affiche('Taille des actionneurs standards: '+intToSTR(SizeOf(Tablo_actionneur))+' octets',clorange);
  Affiche('Taille des actionneurs PN: '+intToSTR(SizeOf(Tablo_PN) )+' octets',clorange);
  Affiche('Taille du tableau d''évènements détecteurs '+intToSTR(SizeOf(event_det) )+' octets',clorange);
  Affiche(' ',clyellow);
end;

// cliqué droit sur un signal puis sur le menu propriétés
procedure TFormPrinc.Proprits1Click(Sender: TObject);
var s: string;
begin
  clicliste:=false;
  if affEvt then Affiche('Clic propriétés',clYellow);
  s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pour récupérer l'index du signal (ex: ImageSignal2)
  //Affiche(s,clOrange);     // nom de l'image du signal (ex: ImageSignal)
  IndexSignalClic:=extract_int(s);   // extraire l'adresse (ex 2)
  formconfig.PageControl.ActivePage:=formconfig.TabSheetSig;
  clicproprietes:=true;
  formconfig.showmodal;
  formconfig.close;
end;

function InfoSignal(adresse : integer) : string;
var s,ss : string;
    nation,etat,i,j,aspect,n,combine,aig,trainReserve,AdrSignalsuivant,voie,AdrTrainRes,adraig : integer;
    reserveTrainTiers : boolean;
    code : word;
begin
  i:=index_signal(adresse);
  n:=Signaux[i].aspect;
  if (n>10) and (n<20) then exit;
  if n=20 then nation:=2 else nation:=1;
  code:=Signaux[i].EtatSignal;
  code_to_aspect(code,aspect,combine);
  //s:='Signal ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
  //Affiche(s,clYellow);
  //Affiche(IntToSTR(aspect),clred);
  //Affiche(IntToSTR(combine),clred);

  s:='Le signal '+intToSTR(adresse)+' présente '+chaine_signal(adresse)+#13;

  if aspect=blanc then
  begin
    if cond_feuBlanc(adresse) then s:=s+'Des conditions d''affichage du feu blanc ont été définies sur la'+#13+'position d''aiguillages et elles sont remplies';
  end;

  // carré
  if (aspect=carre) and (nation=1) then
  begin
    //Affiche(s,clyellow);
    adraig:=carre_signal(Adresse,trainreserve,reserveTrainTiers,AdrTrainRes);
    if adraig<>0 then s:=s+'les aiguillages en aval du signal sont mal positionnés (A'+IntToSTR(AdrAig)+') ou leur positions inconnues'+#13;
    if reserveTrainTiers then
    begin
      ss:='';j:=0;
      for voie:=1 to maxaiguillage do
      begin
        if aiguillage[voie].AdrTrain=AdrTrainRes then
        begin
          ss:=ss+'A'+intToSTR(aiguillage[voie].Adresse)+' ';
          inc(j);
        end;
      end;
      if j=1 then s:=s+'Un aiguillage ou un croisement en aval du signal ('+ss+') est réservé par le train (@'+intToSTR(AdrTrainRes)+')'+#13
      else s:=s+'Des aiguillages ou des croisements en aval du signal ('+ss+') sont réservés par le train (@'+intToSTR(AdrTrainRes)+')'+#13
    end;
    if Cond_Carre(Adresse) then s:=s+'les aiguillages déclarés dans la définition du signal sont mal positionnés'+#13;
    if Signaux[i].VerrouCarre and not(PresTrainPrec(Adresse,Nb_cantons_Sig,false,TrainReserve,voie)) then s:=s+'le signal est verrouillable au carré et aucun train n''est présent avant le signal'+#13;
    if test_memoire_zones(Adresse) then s:=s+'présence train dans canton suivant le signal'+#13;
    if Signaux[i].EtatVerrouCarre then s:=s+'le signal est verrouillé au carré dans la fenêtre de pilotage'+#13;
  end;

  if (aspect=vert_jaune_H) and (nation=2) then
  begin
    etat:=etat_signal_suivant(Adresse,1,AdrSignalsuivant) ;  // état du signal suivant + adresse du signal suivant dans Signal_Suivant
    if testbit(etat,chiffre) then
    begin
      s:=s+'le signal suivant '+intToSTR(adrSignalSuivant)+' affiche une réduction de vitesse '+#13;
    end;
  end;

  if ((aspect=semaphore) and (nation=1)) or ((aspect=rouge) and (nation=2)) then
  begin
    if test_memoire_zones(Adresse) then s:=s+'présence train dans canton après le signal'+#13;
    if n=20 then
    begin
      // signal belge
      AdrAig:=carre_signal(Adresse,trainreserve,reserveTrainTiers,AdrTrainRes);
      if AdrAig<>0 then s:=s+'les aiguillages en aval du signal sont mal positionnés (A'+intToSTr(AdrAig)+') ou leur positions inconnues'+#13;
      if reserveTrainTiers then s:=s+'un aiguillage ou un croisement en aval du signal sont réservés par un autre train (@'+intToSTR(AdrTrainRes)+')'+#13;
      if Cond_Carre(Adresse) then s:=s+'les aiguillages déclarés dans la définition du signal sont mal positionnés'+#13;
      if Signaux[i].VerrouCarre and not(PresTrainPrec(Adresse,Nb_cantons_Sig,false,TrainReserve,voie)) then s:=s+'le signal est verrouillable au carré et aucun train n''est présent avant le signal'+#13;
      if test_memoire_zones(Adresse) then s:=s+'présence train dans canton suivant le signal'+#13;
      if Signaux[i].EtatVerrouCarre then s:=s+'le signal est verrouillé au rouge dans la fenêtre de pilotage'+#13;
    end;
  end;
  // avertissement ou deux-jaunes (belge)
  if ((aspect=jaune) and (n<>20)) or ((aspect=deux_jaunes) and (n=20)) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalsuivant)+#13;
  end;

  // avertissement cli
  if (aspect=jaune_cli) and (nation=1) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    index:=Index_Signal(AdrSignalSuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalSuivant)+#13;
  end;
  // ralen 30
  if (combine=10) and (nation=1) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    index:=Index_Signal(AdrSignalSuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalSuivant)+#13;
  end;
  if (combine=11)  and (nation=1) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    index:=Index_Signal(AdrSignalSuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalSuivant)+#13;
  end;
  if ((combine=rappel_30) or (combine=rappel_60)) and (nation=1) then
  begin
    Aig:=Aiguille_deviee(Adresse);
    // si aiguille locale déviée
    if (aig<>0) then s:=s+'l''aiguillage suivant '+intToSTR(Aig)+' est dévié'+#13;
  end;

  if aspect=vert then s:=s+'la voie en aval est libre'+#13;

  // chiffre et signal belge
  if nation=2 then
  begin
    combine:=code and $1C0;
    if testbit(combine,chiffre) then
    begin
      aig:=Signaux[i].Adr_el_suiv1;
      aig:=index_aig(aig);
      s:=s+'le signal doit être franchi à <'+intToSTR(aiguillage[aig].vitesse)+'km/h'+#13;
    end;
    if testbit(combine,chevron) then
    begin
      aig:=Signaux[i].Adr_el_suiv1;
      aig:=index_aig(aig);
      s:=s+'l''aiguillage mène à une voie en contresens'+#13;
    end;
  end;
  infoSignal:=s;
end;

procedure TFormPrinc.Informationsdusignal1Click(Sender: TObject);
var s: string;
    i,adresse : integer;
begin
  if affEvt then Affiche('clic Informationsdusignal',clYellow);
  clicliste:=false;
  s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pout récupérer l'adresse du signal (ex: ImageSignal2)
  //Affiche(s,clOrange);     // nom de l'image du signal (ex: ImageSignak2)
  i:=extract_int(s);   // extraire l'index (ex 2)
  adresse:=Signaux[i].adresse;

  s:=InfoSignal(adresse);
  Affiche_CR(s,clyellow);

end;

procedure TFormPrinc.VrifierlacohrenceClick(Sender: TObject);
begin
  if verif_coherence then affiche('La configuration est cohérente',clLime);
end;

// cliqué gauche dans la fenetre Fenrich
procedure TFormPrinc.FenRichMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var lc,i : integer;
    s : string;
begin
  if Tdoubleclic=0 then doubleclic:=false;

  if not(doubleclic) then
  begin
    doubleclic:=true;
    Tdoubleclic:=3;
    exit;
  end;
  if doubleclic then
  begin
    doubleclic:=false;
    TdoubleClic:=0;
    with FenRich do
    begin
      i:=Selstart;
      lc:=Perform(EM_LINEFROMCHAR,i,0);
      s:=lines[lc];
    end;
    if pos('http',s)=1 then ShellExecute(0,'open',Pchar(s),nil,nil,sw_shownormal);
  end;
end;

procedure TFormPrinc.ButtonLocCVClick(Sender: TObject);
begin
  if GroupBoxTrains.Visible then begin GroupBoxTrains.Visible:=false;GroupBoxCV.Visible:=true;exit;end
  else begin GroupBoxCV.Visible:=false;GroupBoxTrains.Visible:=true;end;
end;

procedure TFormPrinc.ComboTrainsChange(Sender: TObject);
var i : integer;
begin
  if clicAdrTrain then exit;
  clicComboTrain:=true;
  i:=ComboTrains.itemIndex+1;
  if (i<>0) and (i<Max_Trains) then
  //if CDM_connecte then EditAdrTrain.Text:=intToSTR(trains_cdm[i].adresse) else
  EditAdrTrain.Text:=intToSTR(trains[i].adresse);
  clicComboTrain:=false;
end;

procedure TFormPrinc.ButtonFonctionClick(Sender: TObject);
var erreur,fonction,etat,loco : integer;
    s : string;
begin
  val(editNumFonction.Text,fonction,erreur);
  if (erreur<>0) or (fonction<1) then exit;
  val(editFonc01.Text,etat,erreur);
  if (erreur<>0) or (etat<0) then exit;
  if not(portCommOuvert) and not(parSocketLenz) and not(CDM_connecte) then exit;
  val(editAdrTrain.Text,loco,erreur);
  s:=trains[combotrains.itemindex+1].nom_train;
  if CDM_connecte then
  begin
    if s='' then begin Affiche('Sélectionnez un train',clOrange);exit;end;
    if fonction>12 then
    begin
      Affiche('Avec CDM Rail, F12 maxi',clOrange);
      exit;
    end;
    envoie_fonction_CDM(fonction,etat,s);
    Affiche('Train='+s+' F'+IntToSTR(fonction)+':'+intToSTR(etat),clyellow);
  end;

  begin
    if erreur<>0 then begin Affiche('Sélectionnez un train',clOrange);exit;end;
    if fonction>28 then
    begin
      Affiche('F28 maxi',clOrange);
      exit;
    end;
    Affiche('Train adresse '+intToStr(loco)+' F'+IntToSTR(fonction)+':'+intToSTR(etat),clyellow);
    Fonction_Loco_operation(loco,fonction,etat);
  end;
end;


procedure TFormPrinc.Demanderlaversiondelacentrale1Click(Sender: TObject);
var s : string;
begin
  if (portcommOuvert=false) and (parsocketLenz=false) then
  begin
    Affiche('L''interface n''est pas connectée par USB ou par Ethernet',clorange);
    exit;
  end;
  if (protocole=1) then
  begin
    s:=#$f0;
    s:=checksum(s);
    envoi(s);
  end ;
  if (protocole=2) then
  begin
    affiche_retour_dcc:=true;
    tps_affiche_retour_dcc:=2;
    s:=checksum('<s>');
    envoi(s);
  end
end;

procedure TFormPrinc.Demandetatdesaiguillages1Click(Sender: TObject);
begin
  if (portcommOuvert=false) and (parsocketLenz=false) then
  begin
    Affiche('L''interface n''est pas connectée par USB ou par Ethernet',clorange);
    exit;
  end;
  if (protocole=1) then demande_etat_acc ;
end;

procedure TFormPrinc.RepriseDCC1Click(Sender: TObject);
var s : string;
begin
  if (portcommOuvert=false) and (parsocketLenz=false) then
  begin
    Affiche('L''interface n''est pas connectée par USB ou par Ethernet',clorange);
    exit;
  end;
  if protocole=1 then
  begin
    s:=#$21+#$81;
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
  end;
  if protocole=2 then envoi('<1>');
end;

procedure TFormPrinc.BoutonRazTrainsClick(Sender: TObject);
begin
  Affiche('Raz tous trains et routes',clLime);
  Raz_tout;
end;

procedure TFormPrinc.Demandetataccessoires1Click(Sender: TObject);
begin
  if portCommOuvert or parSocketLenz then demande_etat_acc
  else Affiche('L''interface n''est pas connectée par USB ou par Ethernet',clorange);
end;

procedure TFormPrinc.LancerCDMrail1Click(Sender: TObject);
begin
  Lance_CDM(true);
end;

procedure TFormPrinc.TrackBarVitChange(Sender: TObject);
var s : string;
    i,adr,vit,erreur : integer;
begin
  if affEvt then Affiche('Changement TrackBarVit',clyellow);
  if pasChgTBV then exit;
  EditVitesse.Text:=intToSTR(TrackBarVit.position);
  s:=editAdrTrain.Text;
  val(s,adr,erreur);
  if (erreur<>0) or (adr<0) then exit;
  //if not(portCommOuvert) and not(parSocketLenz) and not(CDM_Connecte) then exit;
  s:=editVitesse.Text;
  val(s,vit,erreur);
  if (erreur<>0) or (vit<-100) or (vit>100) then exit;
  i:=0;s:='';
  if combotrains.itemindex<>-1 then
  begin
    s:=combotrains.Items[combotrains.itemindex];
    i:=index_train_nom(s);
  end;

  //Affiche('Commande vitesse train '+s+' ('+intToSTR(adr)+') à '+IntToSTR(vit)+'%',cllime);
  // ne pas commander la vitesse car la rétro met à jour la track bar!!!
  //sens:=vit>0;
  //vitesse_loco(s,i,adr,vit,sens,true);
  //if s='' then s:=intToSTR(adr);
end;

procedure TFormPrinc.EditVitesseChange(Sender: TObject);
var i,e : integer;
begin
  val(EditVitesse.Text,i,e);
  if (e=0) and (i>=-100) and (i<=100) then TrackBarVit.position:=i;
end;

procedure TFormPrinc.ButtonEnvClick(Sender: TObject);
var se,s : string;
begin
  affiche_retour_dcc:=true;
  tps_affiche_retour_dcc:=2;
  s:=editEnvoi.Text;
  se:=s+'  : '+decodeDCC(s);
  Affiche(se,ClWhite);
  envoi(s);
end;

procedure TFormPrinc.Placerlestrains1Click(Sender: TObject);
begin
  if PlaceAffiche then
  begin
    if cdm_connecte then
    begin
      Affiche('Placement des trains incompatible en mode CDM rail',clOrange);
      exit;
    end;
    formplace.showmodal;
  end;
end;

procedure TFormPrinc.Demandetatdtecteurs1Click(Sender: TObject);
begin
  if portCommOuvert or parSocketLenz then
  begin
    modeStkRetro:=false; // avec evt
    demande_etat_det;
  end
  else Affiche('L''interface n''est pas connectée par USB ou par Ethernet',clorange);
end;

// place les trains, positionne aiguillages et lance le roulage
procedure placement_trains;
var adr,AdrTrain,i,j,vitesse : integer;
    trouve : boolean;
    s : string;
begin
  trouve:=false;
  for i:=1 to 6 do
  begin
    Adr:=placement[i].detecteur;
    if adr<>0 then
    begin
      detecteur[Adr].train:=placement[i].train;
      detecteur[Adr].AdrTrain:=trains[i].adresse;
      event_detecteur(Adr,true,trains[i].nom_train);
      Affiche('Positionnement train '+detecteur[Adr].train+' sur détecteur '+intToSTR(Adr),clLime);
    end;
  end;
  init_aiguillages;

  for i:=1 to NDetecteurs do
  begin
    adr:=Adresse_detecteur[i];
    if Detecteur[adr].etat and (detecteur[adr].train<>'') then
    begin
      s:='Lancement du train '+detecteur[adr].train+' depuis détecteur '+intToSTR(adr);
      Affiche(s,clYellow);
      if traceListe then AfficheDebug(s,clyellow);
      AdrTrain:=detecteur[Adr].AdrTrain;
      j:=index_train_adresse(AdrTrain);

      vitesse:=trains[j].VitNominale;
      if (placement[j].inverse) then vitesse:=-vitesse;
      vitesse_loco('',j,adrTrain,vitesse,true);

      trouve:=true;
      roulage:=true;
    end;
  end;
  if trouve then Maj_Signaux(true);
end;

procedure TFormPrinc.Button1Click(Sender: TObject);
begin
  reserve_dereserve_det(888,561,1,1,0);
  //libere_canton
end;


procedure affiche_com(s : string;var n : integer);
var i : integer;
begin
  i:=pos('COM',Uppercase(s));
  if i=0 then exit;
  if i+3<=length(s) then
  begin
    if s[i+3] in ['0'..'9'] then
    begin
      Affiche(s,clLime);
      inc(n);
    end;
  end;
end;

// informations sur les ports série/usb disponibles
procedure GetWin32_SerialPortInfo;
const
  WbemUser='';
  WbemPassword='';
  WbemComputer='localhost';
  wbemFlagForwardOnly=$00000020;
var
  FSWbemLocator,FWMIService,FWbemObjectSet,FWbemObject : OLEVariant;
  oEnum : IEnumvariant;
  iValue : LongWord;
  i : integer;
  s : string;
begin
  FSWbemLocator:=CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService:=FSWbemLocator.ConnectServer(WbemComputer,'root\CIMV2',WbemUser,WbemPassword);   // nom de l'espace par défaut et classes du matériel du pc
  //                  exception
  // SELECT * FROM MSSerial_PortName   ou SELECT * FROM Win32_SerialPort    ou SELECT * FROM Win32_PnPEntity

  // requete 1 pour les com natifs ------------------
  FWbemObjectSet:=FWMIService.ExecQuery('SELECT * FROM Win32_SerialPort','WQL',wbemFlagForwardOnly);

  oEnum:=IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  while oEnum.Next(1,FWbemObject,iValue)=0 do
  begin
    inc(i);
    // pour les autres champs: https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-serialport
    if FWbemObject.DeviceID<>null then s:=FWbemObject.DeviceID+' ';
    if FWbemObject.name<>null then s:=s+FWbemObject.Name+' ';
    if FWbemObject.Description<>null then s:=s+FWbemObject.Description;
    Affiche_com(s,i);
    FWbemObject:=Unassigned;
  end;
  if i=0 then Affiche('R1 : Aucun port com natif',clLIme);

  // requete 2 pour les com sur usb -------------------
  FWbemObjectSet:=FWMIService.ExecQuery('SELECT * FROM Win32_PnPEntity WHERE ConfigManagerErrorCode = 0','WQL',wbemFlagForwardOnly);

  oEnum:=IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  i:=0;
  while oEnum.Next(1,FWbemObject,iValue)=0 do
  begin
    if FWbemObject.DeviceID<>null then s:=FWbemObject.DeviceID+' ';
    if FWbemObject.name<>null then s:=s+FWbemObject.Name+' ';
    if FWbemObject.Description<>null then s:=s+FWbemObject.Description;
    Affiche_com(s,i);
    FWbemObject:=Unassigned;
  end;
  if i=0 then Affiche('R2 : Aucun port com sur usb',clLime);
end;

procedure liste_portcom ;
begin
  try
    CoInitialize(nil);           // on va utiliser Ole
    try
      GetWin32_SerialPortInfo;   // chercher les ports com avec Ole
    finally
      CoUninitialize;            // on a fini d'utiliser Ole
    end;

  except
    on E:EOleException do
        Affiche(Format('EOleException %s %x', [E.Message,E.ErrorCode]),clyellow);
    on E:Exception do
        Affiche(E.Classname+ ':'+ E.Message,clyellow);
  end;
end;

procedure TFormPrinc.Evenementsdetecteurspartrain1Click(Sender: TObject);
var i,j,train,pos : integer;
    s : string;
begin
  Affiche('Evenements tous détecteurs et aiguillages',clwhite);
  Affiche(' ',clyellow);
  for i:=0 to n_trains do
  begin
    Affiche_Suivi('Train '+intToSTR(i)+' ',clYellow);
  end;
  for i:=1 to N_event_tick do
  begin
    if event_det_tick[i].modele=det then
    begin
      train:=event_det_tick[i].train;
      index_couleur:=((train - 1) mod NbCouleurTrain) +1;
      couleur:=couleurTrain[index_couleur];
      s:='';
      for j:=1 to train*15 do s:=s+' ';
      s:=s+intToSTR(event_det_tick[i].adresse)+' '+intToSTR(event_det_tick[i].etat);
      case event_det_tick[i].reaffecte of
       1 : s:=s+'/S';
       2 : s:=s+'/A';
       3 : s:=s+'/R';
       4 : s:=s+'/0';  // non utilisé
       end;
      Affiche(s,couleur);
    end;

    if event_det_tick[i].modele=aig then
    begin
      s:='Aiguillage '+intToSTR(event_det_tick[i].adresse)+' ';
      pos:=event_det_tick[i].etat;
        case pos of
          const_devie : s:=s+' dévié' ;
          const_droit : s:=s+' droit';
          const_inconnu : s:=s+' inconnue';
          else s:=s+' erreur ('+intToSTR(pos)+')';
         end;
       Affiche(s,clWhite);
    end;
  end;
end;

procedure TFormPrinc.RazResaClick(Sender: TObject);
var i : integer;
begin
  Affiche('Mise à 0 de la réservation des aiguillages',clYellow);
  Raz_reservations;
  //Maj_Signaux(false);
  for i:=1 to nbreTCO do
    Affiche_tco(i);
end;

procedure stop_trains;
var i,adr : integer;
begin
  for i:=1 to Ntrains do
  begin
    adr:=Trains[i].adresse;
    if adr<>0 then
    begin
      Affiche('Arrêt train @'+intToSTR(adr)+' '+Trains[i].nom_train,clyellow);
      vitesse_loco('',i,adr,0,true);
    end;
  end;
end;

procedure TFormPrinc.SBMarcheArretLocoClick(Sender: TObject);
begin
  stop_trains;
end;

procedure TFormPrinc.EditAdrTrainChange(Sender: TObject);
var i,adr,erreur : integer;
begin
  if clicComboTrain then exit;
  clicAdrTrain:=true;
  val(editAdrTrain.Text,adr,erreur);
  if (erreur=0) and (adr>0) then
  begin
    i:=index_train_adresse(adr);
    comboTrains.ItemIndex:=i-1;
  end;
  clicAdrTrain:=false;
end;


procedure TFormPrinc.SplitterVMoved(Sender: TObject);
var i : integer;
begin
  i:=SplitterV.Left;
  //Affiche(IntToSTR(i),clred);
  if i<200 then SplitterV.Left:=201;
  positionne_elements(SplitterV.Left);
end;

procedure TFormPrinc.PopupMenuSignalPopup(Sender: TObject);
var ob : TPopupMenu;
begin
  // AdrPilote est récupéré de l'event OnMouseDown de l'image du signal qui se produit avant
  if Affevt then Affiche('PopupMenuFeu',clYellow);
  ob:=Sender as Tpopupmenu;
  ob.Items[0].Caption:='Propriétés du signal '+intToSTR(AdrPilote);
  ob.Items[1].Caption:='Informations du signal '+intToSTR(AdrPilote);
end;

procedure TFormPrinc.Vrifiernouvelleversion1Click(Sender: TObject);
var s : string;
    v_publie,v_utile : real;
    erreur : integer;
begin
  V_publie:=verifie_version;
  str(v_publie:2:2,s);
  if v_publie>0 then
  begin
    val(versionSC,V_utile,erreur);
    Affiche('Nt='+nombre_tel,clLime);
    if V_utile=V_publie then Affiche('Votre version '+VersionSC+SousVersion+' publiée le '+date_creation+' est à jour',clLime);
    if V_utile>V_publie then Affiche('Votre version '+versionSC+SousVersion+' est plus récente que la version publiée '+s,clLime);
  end
end;

procedure TFormPrinc.Analyser1Click(Sender: TObject);
var s1,s2 : string;
    i : integer;
begin
  s1:=lowercase(fenRich.Lines[0]);
  if pos('module',s1)=0 then
  begin
    Affiche('Pas de module réseau CDM détecté.',clyellow);
    Affiche('Procédure: dans CDM RAIL ouvrez votre réseau ; Menu ... / TrackDrawing  / Module Display',clLime);
    Affiche('Attention : nécessite la version >=23.05 de CDM',clLime);
    Affiche('Cela ouvre une fenêtre DEBUG dans cdm',clLime);
    Affiche('Dans cette fenêtre, faire Clic droit puis "sélectionner tout" et "copier"',clLime);
    Affiche(' ',clLime);
    Affiche('Dans Signaux complexes, clic droit et "coller, compiler et importer le réseau CDM rail" ',clLime);
    Affiche('Dans la fenêtre graphique d''importation cliquer sur "compiler"',clLime);

    if lance_cdm(false) then
    begin
      sleep(400);
      s2:='CDR';
      //SetBackgroundWindow(formprinc.Handle); // met SC devant
      ProcessRunning(s2); // récupérer le handle de CDM
      SetForegroundWindow(CDMhd);
      SetActiveWindow(CdmHd);
      Application.ProcessMessages;
      sleep(900);
      Application.ProcessMessages;


      KeybdInput(VK_MENU,0);                 // enfonce Alt
      KeybdInput(vk_decimal,0);
      KeybdInput(vk_decimal,KEYEVENTF_KEYUP);
      KeybdInput(VK_MENU,KEYEVENTF_KEYUP);   // relache ALT

      KeybdInput(VK_DOWN,0);
      KeybdInput(VK_DOWN,KEYEVENTF_KEYUP);
      KeybdInput(VK_RETURN,0);
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
      KeybdInput(VK_RETURN,0);                // valide le menu "track drawing"
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);

      // envoie les touches
      i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  // la fenetre serveur démarré est affichée
      Sleep(500);
      Application.ProcessMessages;

      // clic droit valider le menu
      KeybdInput(VK_RBUTTON,0);                // VK_APPS = menu droit
      KeybdInput(VK_RBUTTON,KEYEVENTF_KEYUP);
      i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Application.ProcessMessages;
    end;
    exit;
  end;
end;

procedure TFormPrinc.Coller1Click(Sender: TObject);
begin
  With FenRich do
  begin
    ReadOnly:=false;
    clear;
    Affiche('',clYellow);
    PasteFromClipboard;
    SetFocus;
    ReadOnly:=true;
  end;
  compilation;
end;

procedure TFormPrinc.ButtonAffAnalyseCDMClick(Sender: TObject);
begin
  //FormAnalyseCDM.WindowState:=wsMaximized;
  formAnalyseCDM.Show;
end;

procedure TFormPrinc.Affiche_fenetre_CDMClick(Sender: TObject);
begin
  formAnalyseCDM.Show;
end;


procedure TFormPrinc.AffichertouslesTCO1Click(Sender: TObject);
var i : integer;
begin
  for i:=1 to NbreTCO do Affiche_fenetre_TCO(i,true);
end;

procedure mosaiqueH;
var NombreEcrans,e,i,largEcran,hautEcran,topEcran,LeftEcran,LargTCO,HautTCO : integer;
    nbTCOE : array[1..10] of integer; // nombre de TCO par écran
    CeTCO  : array[1..10] of integer; // nombre de TCO en cours d'affchage par écran
begin
  for i:=1 to 10 do begin nbTCOE[i]:=0;CeTCO[i]:=0;end;
  for i:=1 to NbreTCO do
  begin
    e:=ECranTCO[i]; // écran du tco i
    if (e>=1) and (e<=10) then inc(nbTCOE[e]);  //nbTCOE[2]=3 signifie que l'écran 2 contient 3 TCOs
  end;

  NombreEcrans:=Screen.MonitorCount;
  if NombreEcrans>10 then NombreEcrans:=10;
  if NombreEcrans=1 then NbTCOE[1]:=NbreTCO;

  for i:=1 to NbreTCO do
  begin

    for e:=1 to NombreEcrans do
    begin

      if (ecranTCO[i]=e) or (NombreEcrans=1) then  // si l'écran TCO doit aller sur e
      begin
        inc(CeTCO[e]);
        largEcran:=ecran[e].larg;
        hautEcran:=ecran[e].haut;
        TopEcran:=ecran[e].y0;
        LeftEcran:=ecran[e].x0;
        largTCO:=largEcran ;
        HautTCO:=(HautEcran div NbTCOE[e]);

        //Affiche(intToSTR(leftEcran),clred);

        with formtco[i] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;

          Top:=((CeTCO[e]-1)*HautTCO)+Topecran;
          //if i>1 then top:=formTCO[i-1].Top+formTCO[i-1].Height else top:=topEcran;
          Left:=leftECran;
          width:=largTCO;
          height:=HautTCO;
        end;
      end;
    end;
  end;
end;

procedure MosaiqueV;
var e,topEcran,LeftEcran,i,largEcran,hautEcran,LargTCO,HautTCO,NombreEcrans : integer;
    nbTCOE : array[1..10] of integer; // nombre de TCO par écran
    CeTCO  : array[1..10] of integer; // nombre de TCO en cours d'affchage par écran
begin
  for i:=1 to 10 do begin nbTCOE[i]:=0;CeTCO[i]:=0;end;
  for i:=1 to NbreTCO do
  begin
    e:=ECranTCO[i]; // écran du tco i
    if (e>=1) and (e<=10) then inc(nbTCOE[e]);  //nbTCOE[2]=3 signifie que l'écran 2 contient 3 TCO
  end;

  NombreEcrans:=Screen.MonitorCount;
  if NombreEcrans>10 then NombreEcrans:=10;
  if NombreEcrans=1 then NbTCOE[1]:=NbreTCO;

  for i:=1 to NbreTCO do
  begin
    for e:=1 to NombreEcrans do
    begin
      if (ecranTCO[i]=e) or (NombreEcrans=1) then  // si l'écran TCO doit aller sur e
      begin
        inc(CeTCO[e]);
        largEcran:=ecran[e].larg;
        hautEcran:=ecran[e].haut;
        TopEcran:=ecran[e].y0;
        LeftEcran:=ecran[e].x0;
        largTCO:=largEcran div NbTCOE[e];
        HautTCO:=HautEcran;

        with formtco[i] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;

          Top:=Topecran;
          Left:=((CeTCO[e]-1)*largTCO)+leftECran;
          width:=largTCO+8;
          height:=HautTCO;
        end;
      end;
    end;
  end;
end;

procedure TFormPrinc.Mosaquehorizontale1Click(Sender: TObject);
begin
  mosaiqueH;
end;

procedure TFormPrinc.Mosaqueverticale1Click(Sender: TObject);
begin
  mosaiqueV;
end;

procedure TFormPrinc.Mosaiquecarre1Click(Sender: TObject);
var topEcran,LeftEcran,i,largEcran,hautEcran,LargTCO,HautTCO : integer;
begin
  largEcran:=Screen.WorkAreaWidth;
  hautEcran:=Screen.WorkAreaHeight;
  TopEcran:=screen.WorkAreaTop;
  LeftEcran:=screen.WorkAreaLeft;

  case NbreTCO of
  1 : begin
        formTCO[1].windowState:=wsNormal;
        formTCO[1].show;
        formTCO[1].BringToFront;
      end;
  2 : mosaiqueH;
  3 : begin
        HautTCO:=HautEcran div 2;
        with formtco[1] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;

          Top:=Topecran;    Left:=0;
          width:=largEcran+8; height:=HautTCO;
        end;
        largTCO:=largEcran div 2;

        with formtco[2] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;
          Top:=Topecran+HautTCO;    Left:=0;
          width:=largTCO+8; height:=HautTCO;
        end;
        with formtco[3] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;
          Top:=Topecran+HautTCO;    Left:=largTCO;
          width:=largTCO+8; height:=HautTCO;
        end;
      end;
  4 : begin
        HautTCO:=HautEcran div 2;
        largTCO:=largEcran div 2;
        for i:=1 to 4 do
        begin
          with formtco[i] do
          begin
            windowState:=wsNormal;
            show;
            BringToFront;
            Top:=Topecran+((i-1) div 2)*HautTCO;  Left:=((i-1) mod 2)*LargTCO;
            width:=largTCO+8; height:=HautTCO+8;
          end;
        end;
     end;

   5 : begin
        HautTCO:=HautEcran div 3;
        largTCO:=largEcran div 2;
        with formtco[1] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;
          Top:=Topecran;    Left:=0;
          width:=largEcran+8; height:=HautTCO;
        end;
        for i:=2 to 5 do
        begin
          with formtco[i] do
          begin
            windowState:=wsNormal;
            show;
            BringToFront;
            Top:=Topecran+HautTCO+((i-2) div 2)*HautTCO;  Left:=((i-2) mod 2)*LargTCO;
            width:=largTCO+8; height:=HautTCO+8;
          end;
        end;
      end;

   6 : begin
        HautTCO:=HautEcran div 3;
        largTCO:=largEcran div 2;
        for i:=1 to 6 do
        begin
          with formtco[i] do
          begin
            windowState:=wsNormal;
            show;
            BringToFront;
            Top:=Topecran+((i-1) div 2)*HautTCO;  Left:=((i-1) mod 2)*LargTCO;
            width:=largTCO+8; height:=HautTCO+8;
          end;
        end;
     end;

  7 : begin
        HautTCO:=HautEcran div 4;
        largTCO:=largEcran div 2;
        with formtco[1] do
        begin
          windowState:=wsNormal;
          show;
          BringToFront;
          Top:=Topecran;    Left:=0;
          width:=largEcran+8; height:=HautTCO;
        end;
        for i:=2 to 7 do
        begin
          with formtco[i] do
          begin
            windowState:=wsNormal;
            show;
            BringToFront;
            Top:=Topecran+HautTCO+((i-2) div 2)*HautTCO;  Left:=((i-2) mod 2)*LargTCO;
            width:=largTCO+8; height:=HautTCO+8;
          end;
        end;
      end;

  8 : begin
        HautTCO:=HautEcran div 3;
        largTCO:=largEcran div 2;
        with formtco[1] do
        begin
           windowState:=wsNormal;
          show;
          BringToFront;
          Top:=Topecran;    Left:=0;
          width:=largTCO+8; height:=HautTCO;
        end;
        with formtco[2] do
        begin
         windowState:=wsNormal;
          show;
          BringToFront;
          Top:=Topecran;      Left:=largTCO;
          width:=largTCO+8; height:=HautTCO;
        end;
        largTCO:=largEcran div 3;
        for i:=3 to 8 do
        begin
          with formtco[i] do
          begin
            windowState:=wsNormal;
            show;
            BringToFront;
            Top:=Topecran+HautTCO+((i-3) div 3)*HautTCO;  Left:=((i-3) mod 3)*LargTCO;
            width:=largTCO+8; height:=HautTCO+8;
          end;
        end;
      end;

   9 : begin
        HautTCO:=HautEcran div 3;
        largTCO:=largEcran div 3;
        for i:=1 to 9 do
        begin
          with formtco[i] do
          begin
            windowState:=wsNormal;
            show;
            BringToFront;
            Top:=Topecran+((i-1) div 3)*HautTCO;  Left:=((i-1) mod 3)*LargTCO;
            width:=largTCO+8; height:=HautTCO+8;
          end;
        end;
     end;
  end;
end;

// Affiche le TCO i sur l'écran désigné dans la structure du TCO
procedure Affiche_Fenetre_TCO(i : integer;laisseOuvert : boolean);
var e : integer;
begin
  if (i<1) or (i>NbreTCO) then exit;
  e:=ecranTCO[i];
  if e>10 then e:=10;
  if e>Screen.MonitorCount then e:=1;

  formTCO[i].show;    // on est obligé d'afficher la fenetre TCO pour provoquer OnActivate pour valider les pointeurs

  application.ProcessMessages;
  if formTCO[i].Left<>Ecran[e].x0 then formTCO[i].Left:=Ecran[e].x0;
  if formTCO[i].Top<>Ecran[e].y0 then formTCO[i].Top:=Ecran[e].y0;
  formTCO[i].BringToFront;

  // pour maximiser la fenêtre, obligé de faire wsnormal avant
  if formTCO[i].windowState<>wsMaximized then
  begin
    formTCO[i].windowState:=wsNormal;
    formTCO[i].windowState:=wsMaximized;
  end;
  if not(laisseOuvert) then formTCO[i].Close; // .. et si on en veut pas, on la ferme.
end;

procedure TFormPrinc.AfficherTCO11Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(1,true);
end;

procedure TFormPrinc.AfficherTCO21Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(2,true);
end;

procedure TFormPrinc.AfficherTCO31Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(3,true);
end;

procedure TFormPrinc.AfficherTCO41Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(4,true);
end;

procedure TFormPrinc.AfficherTCO51Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(5,true);
end;

procedure TFormPrinc.AfficherTCO61Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(6,true);
end;

procedure TFormPrinc.AfficherTCO71Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(7,true);
end;

procedure TFormPrinc.AfficherTCO81Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(8,true);
end;

procedure TFormPrinc.AfficherTCO91Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(9,true);
end;

procedure TFormPrinc.AfficherTCO101Click(Sender: TObject);
begin
  Affiche_Fenetre_TCO(10,true);
end;

// mise à jour des menus TCO en fonction du nombre i de TCO
Procedure Menu_tco(i : integer);
begin
  with formprinc do
  begin
    if i>=1 then AfficherTCO11.Caption:='Afficher TCO1 : '+NomfichierTCO[1];
    if i>=2 then AfficherTCO21.Caption:='Afficher TCO2 : '+NomfichierTCO[2];
    if i>=3 then AfficherTCO31.Caption:='Afficher TCO3 : '+NomfichierTCO[3];
    if i>=4 then AfficherTCO41.Caption:='Afficher TCO4 : '+NomfichierTCO[4];
    if i>=5 then AfficherTCO51.Caption:='Afficher TCO5 : '+NomfichierTCO[5];
    if i>=6 then AfficherTCO61.Caption:='Afficher TCO6 : '+NomfichierTCO[6];
    if i>=7 then AfficherTCO71.Caption:='Afficher TCO7 : '+NomfichierTCO[7];
    if i>=8 then AfficherTCO81.Caption:='Afficher TCO8 : '+NomfichierTCO[8];
    if i>=9 then AfficherTCO91.Caption:='Afficher TCO9 : '+NomfichierTCO[9];
    if i>=10 then AfficherTCO101.Caption:='Afficher TCO10 : '+NomfichierTCO[10];
    if i=0 then
    begin
      AfficherTCO11.Enabled:=false;
      AfficherTCO21.Enabled:=false;
      AfficherTCO31.Enabled:=false;
      AfficherTCO41.Enabled:=false;
      AfficherTCO51.Enabled:=false;
      AfficherTCO61.Enabled:=false;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=false;
      CO21.Enabled:=false;
      CO31.Enabled:=false;
      CO41.Enabled:=false;
      CO51.Enabled:=false;
    end;
    if i=1 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=false;
      AfficherTCO31.Enabled:=false;
      AfficherTCO41.Enabled:=false;
      AfficherTCO51.Enabled:=false;
      AfficherTCO61.Enabled:=false;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=false;
      CO31.Enabled:=false;
      CO41.Enabled:=false;
      CO51.Enabled:=false;
      CO61.Enabled:=false;
      CO71.Enabled:=false;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=2 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=false;
      AfficherTCO41.Enabled:=false;
      AfficherTCO51.Enabled:=false;
      AfficherTCO61.Enabled:=false;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=false;
      CO41.Enabled:=false;
      CO51.Enabled:=false;
      CO61.Enabled:=false;
      CO71.Enabled:=false;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=3 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=false;
      AfficherTCO51.Enabled:=false;
      AfficherTCO61.Enabled:=false;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=false;
      CO51.Enabled:=false;
      CO61.Enabled:=false;
      CO71.Enabled:=false;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=4 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=false;
      AfficherTCO61.Enabled:=false;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=false;
      CO61.Enabled:=false;
      CO71.Enabled:=false;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=5 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=true;
      AfficherTCO61.Enabled:=false;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=true;
      CO61.Enabled:=false;
      CO71.Enabled:=false;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=6 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=true;
      AfficherTCO61.Enabled:=true;
      AfficherTCO71.Enabled:=false;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=true;
      CO61.Enabled:=true;
      CO71.Enabled:=false;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=7 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=true;
      AfficherTCO61.Enabled:=true;
      AfficherTCO71.Enabled:=true;
      AfficherTCO81.Enabled:=false;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=true;
      CO61.Enabled:=true;
      CO71.Enabled:=true;
      CO81.Enabled:=false;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=8 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=true;
      AfficherTCO61.Enabled:=true;
      AfficherTCO71.Enabled:=true;
      AfficherTCO81.Enabled:=true;
      AfficherTCO91.Enabled:=false;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=true;
      CO61.Enabled:=true;
      CO71.Enabled:=true;
      CO81.Enabled:=true;
      CO91.Enabled:=false;
      CO101.Enabled:=false;
    end;
    if i=9 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=true;
      AfficherTCO61.Enabled:=true;
      AfficherTCO71.Enabled:=true;
      AfficherTCO81.Enabled:=true;
      AfficherTCO91.Enabled:=true;
      AfficherTCO101.Enabled:=false;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=true;
      CO61.Enabled:=true;
      CO71.Enabled:=true;
      CO81.Enabled:=true;
      CO91.Enabled:=true;
      CO101.Enabled:=false;
    end;
    if i=10 then
    begin
      AfficherTCO11.Enabled:=true;
      AfficherTCO21.Enabled:=true;
      AfficherTCO31.Enabled:=true;
      AfficherTCO41.Enabled:=true;
      AfficherTCO51.Enabled:=true;
      AfficherTCO61.Enabled:=true;
      AfficherTCO71.Enabled:=true;
      AfficherTCO81.Enabled:=true;
      AfficherTCO91.Enabled:=true;
      AfficherTCO101.Enabled:=true;
      CO11.Enabled:=true;
      CO21.Enabled:=true;
      CO31.Enabled:=true;
      CO41.Enabled:=true;
      CO51.Enabled:=true;
      CO61.Enabled:=true;
      CO71.Enabled:=true;
      CO81.Enabled:=true;
      CO91.Enabled:=true;
      CO101.Enabled:=true;
    end;
  end;
end;


procedure TFormPrinc.NouveauTCO1Click(Sender: TObject);
begin
  if NbreTCO>=10 then
  begin
    Affiche('Nombre maximum de TCO atteint',clred);
    exit;
  end;

  TCOActive:=false;
  inc(nbreTCO);
  IndexTCOCreate:=nbreTCO;

  formTCO[NbreTCO]:=nil;
  try
     formTCO[nbreTCO]:=TformTCO.Create(self);   // génère formCreate
  except
     Affiche('Erreur 6800 Impossible de créer la fenêtre du TCO',clred);
     dec(NbreTCO);
     exit;
  end;

  formTCO[nbreTCO].Name:='FormTCO'+intToSTR(nbreTCO);
  formTCO[nbreTCO].Caption:='TCO'+intToSTR(nbreTCO);
  Forminit[nbreTCO]:=false;

  init_TCO(nbreTCO);
  menu_tco(NbreTCO);
  TCO_modifie:=true;
  config_modifie:=true;
  {$IF CompilerVersion >= 28.0}
  formTCO[nbreTCO].StyleName:='windows';
  {$IFEND}
  formTCO[nbreTCO].show;     // génère formActivate ce qui implique que le nom de la form soit à jour, et que le TCO soit initialisé

  FormConfigTCO.show;
end;

procedure Supprimer_TCO(TcoS : integer);
var i,SauvNbreTCO : integer;
    s : string;
begin
  if Tcos>NbreTCO then exit;
  s:='Voulez-vous supprimer le TCO '+intToSTR(TcoS)+' ('+NomFichierTCO[tcoS]+')';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  SauvNbreTCO:=NbreTCO;  // dire au programme Timer qu'il n'y a plus de TCO le temps de supprimer sinon il peut tenter d'allumer un feu sur le TCO qu'on supprime->violation
  NbreTCO:=0;
  TCOActive:=false;

  Affiche('Suppression du TCO '+intToSTR(Tcos),clOrange);
  FormTCO[tcos].Release;   // annuler le pointeur et raz les mémoires de la form

  for i:=tCos to SauvNbreTCO-1 do
  begin
    NomFichierTCO[i]:=NomFichierTCO[i+1];

    FormTCO[i]:=FormTCO[i+1];
    FormTCO[i].Name:='TCO'+intToSTR(i);  // renommer le TCO
    TCO[i]:=Tco[i+1]; // déplacer les données
    // et toutes les variables du tco
    PcanvasTCO[i]:=PcanvasTCO[i+1];
    PBitMapTCO[i]:=PBitMapTCO[i+1];
    PImageTCO[i]:=PImageTCO[i+1];
    PImageTemp[i]:=PImageTemp[i+1];
    frXGlob[i]:=frXGlob[i+1];
    frYGlob[i]:=frYGlob[i+1];
    SelectionAffichee[i]:=SelectionAffichee[i+1];
    forminit[i]:=forminit[i+1];
    modeTrace[i]:=modeTrace[i+1];
    entoure[i]:=entoure[i+1];
    avecGrille[i]:=avecGrille[i+1];
    NbreCellX[i]:=NbreCellX[i+1];
    NbreCellY[i]:=NbreCellY[i+1];
    largeurCelld2[i]:=largeurCelld2[i+1];
    HauteurCelld2[i]:=HauteurCelld2[i+1];
    largeurCell[i]:=largeurCell[i+1];
    HauteurCell[i]:=HauteurCell[i+1];
    EcranTCO[i]:=EcranTCO[i+1];
    Forminit[i]:=false;
  end;

  setlength(TCO[SauvNbreTCO],0);
  PcanvasTCO[SauvNbreTCO]:=nil;
  dec(SauvNbreTCO);
  Menu_tco(SauvNbreTCO);
  config_modifie:=true;
  if SauvNbreTCO<>0 then Affiche('La nouvelle liste des noms des fichiers des TCO est la suivante:',ClLime);

  for i:=1 to SauvNbreTCO do
  begin
    Affiche(IntToSTR(i)+'  '+NomFichierTCO[i],clLime);
  end;
  NbreTCO:=SauvNbreTCO;
  tcoActive:=true;
end;

procedure TFormPrinc.CO11Click(Sender: TObject);
begin
  Supprimer_TCO(1);
end;

procedure TFormPrinc.CO21Click(Sender: TObject);
begin
  Supprimer_TCO(2);
end;

procedure TFormPrinc.CO31Click(Sender: TObject);
begin
  Supprimer_TCO(3);
end;

procedure TFormPrinc.CO41Click(Sender: TObject);
begin
  Supprimer_TCO(4);
end;

procedure TFormPrinc.CO51Click(Sender: TObject);
begin
  Supprimer_TCO(5);
end;

procedure TFormPrinc.CO61Click(Sender: TObject);
begin
  Supprimer_TCO(6);
end;

procedure TFormPrinc.CO71Click(Sender: TObject);
begin
  Supprimer_TCO(7);
end;

procedure TFormPrinc.CO81Click(Sender: TObject);
begin
  Supprimer_TCO(8);
end;

procedure TFormPrinc.CO91Click(Sender: TObject);
begin
  Supprimer_TCO(9);
end;

procedure TFormPrinc.CO101Click(Sender: TObject);
begin
  Supprimer_TCO(10);
end;

procedure TFormPrinc.ButtonCDMClick(Sender: TObject);
begin
  if cdmHd=0 then exit;
  if not(cdmDevant) then ShowWindow(CDMhd,SW_MINIMIZE) else ShowWindow(CDMhd,SW_MAXIMIZE);
  cdmDevant:=not(cdmDevant);
end;


procedure TFormPrinc.FormResize(Sender: TObject);
begin
  // pour éviter de coincer le splitter à gauche fenetre réduite et on le glisse complètement à gauche
  splitterV.Left:=FenRich.left+FenRich.Width-5;
end;

procedure TFormPrinc.Affichagenormal1Click(Sender: TObject);
begin
  FenRich.Width:=GrandPanel.Width-Panel1.Width-GroupBoxAcc.Width-25;
  splitterV.Left:=FenRich.left+FenRich.Width-5;
  positionne_elements(splitterV.Left);
  FormClock.Width:=250;
  FormClock.Height:=250;
  OffsetYFC:=(formprinc.top+formPrinc.height)-250-20;
  OffsetXFC:=(formprinc.left+formPrinc.width)-250;
  FormClock.top:=OffsetYFC;
  FormClock.left:=OffsetXFC;
  DeltaFPCY:=OffsetYFC-formprinc.top;
  DeltaFPCX:=OffsetXFC-formprinc.left;
end;

procedure TFormPrinc.Sauvegarderla1Click(Sender: TObject);
begin
  // fenêtre principale
  LargeurF:=width;
  HauteurF:=Height;
  OffsetXF:=left;
  OffsetYF:=top;
  // fenêtre clock
  LargeurFC:=formClock.width;
  HauteurFC:=formClock.Height;
  OffsetXFC:=formClock.left;
  OffsetYFC:=formClock.top;

  // écart entre fenetre principale et clock , pour procédure formprinc WindowPosChanging
  DeltaFPCY:=OffsetYFC-formprinc.top;
  DeltaFPCX:=OffsetXFC-formprinc.left;


  PosSplitter:=splitterV.Left;
  AffMemoFenetre:=1;
  sauve_config;
end;

// change la couleur du texte du panel
procedure TFormPrinc.StatusBar1DrawPanel(StatusBar: TStatusBar;  Panel: TStatusPanel; const Rect: TRect);
var RectForText: TRect;
begin
  if (Panel=StatusBar.Panels[2]) or (Panel=StatusBar.Panels[3]) then
  begin
    if Panel.Text<>'' then
    begin
      StatusBar1.Canvas.Font.Color:=clwhite;
      StatusBar1.Canvas.Brush.color:=clGreen;
      RectForText:=Rect;
      StatusBar1.Canvas.FillRect(RectForText);
      DrawText(StatusBar1.Canvas.Handle,PChar(Panel.Text),-1,RectForText,DT_SINGLELINE or DT_VCENTER or DT_LEFT);
    end;
  end;

end;

// télécommande de signaux complexes par les clients
function telecommande(s : string) : boolean;
var adresse,i,erreur : integer;
begin
  result:=false;
  s:=uppercase(s);
  // --- commandes sans paramètres
  if pos('<LCDM>',s)<>0 then
  begin
    Lance_CDM(true);
    result:=true;
  end;
  if pos('<ACDM>',s)<>0 then
  begin
    if cdmHd=0 then exit;
    if not(cdmDevant) then ShowWindow(CDMhd,SW_MINIMIZE) else ShowWindow(CDMhd,SW_MAXIMIZE);
    cdmDevant:=not(cdmDevant);
    result:=true;
  end;
  if pos('<ASCO>',s)<>0 then
  begin
    with formprinc do
    begin
      windowState:=wsNormal; //Maximized;
      show;
      BringToFront;
    end;
    result:=true;
  end;

  // --- commandes avec paramètres
  if copy(s,1,4)='<TCO' then
  begin
    delete(s,1,4);
    val(s,i,erreur);
    if (i>0) and (i<=10) and (formTCO[i]<>nil) then
    begin
      formTCO[i].windowState:=wsNormal; //Maximized;
      formTCO[i].show;
      formTCO[i].BringToFront;
    end;
    result:=true;
  end;
  if copy(s,1,4)='<ACS' then      // ACS3,1
  begin
    delete(s,1,4);
    val(s,adresse,erreur);
    delete(s,1,erreur);
    val(s,i,erreur);
    pilote_acc(adresse,i,aigP);   // impulsionnel
  end;

  //FormPrinc.AffEtatDetecteurs(formprinc);
end;

// réception COM/USB du périphérique 1
procedure TFormPrinc.RecuPeriph1(Sender: TObject);
var s : string;
   tablo : array of byte;  // tableau rx usb
   c : char;
   i : integer;
begin
  if MSCommCde1.commEvent=ComEvReceive then
  begin
    tablo:=MSCommCde1.Input;

    for i:=0 to length(tablo)-1 do
    begin
      c:=char(tablo[i]);
      //Affiche(intToSTR(ord(c)),clorange);
      if c=#13 then
      begin
        s:=tablo_periph[1].tamponrx;
        affiche(s,clyellow);
        tablo_periph[1].tamponrx:='';
        telecommande(s);
      end;
      if (c>#31) and (c<#128) then tablo_periph[1].tamponrx:=tablo_periph[1].tamponrx+c;;
    end;
  end;
end;

// réception COM/USB du périphérique 2
procedure TFormPrinc.RecuPeriph2(Sender: TObject);
var s : string;
   tablo : array of byte;  // tableau rx usb
   c : char;
   i : integer;
begin
  if MSCommCde2.commEvent=ComEvReceive then
  begin
    tablo:=MSCommCde2.Input;
    for i:=0 to length(tablo)-1 do
    begin
      c:=char(tablo[i]);
      //Affiche(intToSTR(ord(c)),clorange);
      if c=#13 then
      begin
        s:=tablo_periph[2].tamponrx;
        affiche(s,clyellow);
        tablo_periph[2].tamponrx:='';
        telecommande(s);
      end;
      if (c>#31) and (c<#128) then tablo_periph[2].tamponrx:=tablo_periph[2].tamponrx+c;;
    end;
  end;
end;

procedure TFormPrinc.ClientSocketCde1Connect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Socket '+ClientSocketCde1.Address+':'+intToSTR(ClientSocketCde1.port)+' connecté ',clYellow);
end;

procedure TFormPrinc.ClientSocketCde1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;var ErrorCode: Integer);
var s : string;
begin
  s:='Erreur '+IntToSTR(ErrorCode)+' socket '+ClientSocketCde1.Address+':'+intToSTR(ClientSocketCde1.port);
  case ErrorCode of
   10053 : s:=s+': Connexion avortée - Timeout';
   10054 : s:=s+': Connexion avortée par un tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refusée';
   10065 : s:=s+': Port non connecté';
   end;
   if nivDebug=3 then
   begin
     afficheDebug(s,clOrange);
   end;
   affiche(s,clOrange);
   ErrorCode:=0;
end;

procedure TFormPrinc.ClientSocketCde1Read(Sender: TObject; Socket: TCustomWinSocket);
var s : string;
begin
  s:=ClientSocketCde1.Socket.ReceiveText;
  if not(telecommande(s)) then Affiche(s,clWhite);
end;

procedure TFormPrinc.ClientSocketCde2Connect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Socket '+ClientSocketCde2.Address+':'+intToSTR(ClientSocketCde2.port)+' connecté ',clYellow);
end;

procedure TFormPrinc.ClientSocketCde2Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;var ErrorCode: Integer);
var s : string;
begin
  s:='Erreur '+IntToSTR(ErrorCode)+' socket '+ClientSocketCde2.Address+':'+intToSTR(ClientSocketCde2.port);

  case ErrorCode of
   10053 : s:=s+': Connexion avortée - Timeout';
   10054 : s:=s+': Connexion avortée par un tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refusée';
   10065 : s:=s+': Port non connecté';
   end;
   if nivDebug=3 then
   begin
     afficheDebug(s,clOrange);
   end;
   affiche(s,clOrange);
   ErrorCode:=0;
end;


procedure TFormPrinc.ClientSocketCde2Read(Sender: TObject;
  Socket: TCustomWinSocket);
var s : string;
begin
  s:=ClientSocketCde2.Socket.ReceiveText;
  Affiche(s,clWhite);
  telecommande(s);
end;

procedure TFormPrinc.Copierltatdesaiguillageseninitialisation1Click(
  Sender: TObject);
var i,p : integer;
    tsi : boolean;
begin
  tsi:=false;
  for i:=1 to maxaiguillage do
  begin
    p:=aiguillage[i].position;
    if (p<>const_inconnu) and (aiguillage[i].modele<>crois) then
    begin
      aiguillage[i].posInit:=p;
      tsi:=true;
    end;
  end;
  config_modifie:=true;
  if tsi then Affiche('La position initiale des aiguillages dont la position est connue a été mise à jour',clYellow)
    else affiche('Aucun aiguillage n''a de position connue',clorange);
end;

procedure TFormPrinc.ServerSocketAccept(Sender: TObject;
  Socket: TCustomWinSocket);
var n : integer;
begin
  n:=serverSocket.Socket.ActiveConnections;
  if n<=IdClients then
  begin
    Liste_clients[n-1].Adresse:=Socket.remoteAddress;
    Liste_clients[n-1].PortLocal:=Socket.LocalPort;
    Liste_clients[n-1].PortDistant:=Socket.RemotePort;
  end;
  Affiche('Client '+intToSTR(n)+' '+Socket.remoteAddress+':'+intToSTR(Socket.RemotePort)+':'+intToSTR(Socket.LocalPort)+' connecté',clyellow);
end;

// réception de données des clients de signaux complexes
procedure TFormPrinc.ServerSocketClientRead(Sender: TObject;Socket: TCustomWinSocket);
var s :string;
begin
  s:=socket.ReceiveText;
  if not(telecommande(s)) then Affiche(s,clWhite);
end;

procedure TFormPrinc.ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
var n : integer;
begin
  for n:=0 to IdClients do
  begin
    if (Liste_clients[n].adresse=socket.remoteAddress) and (Liste_clients[n].portDistant=socket.remotePort) and (Liste_clients[n].portLocal=socket.LocalPort) then
    begin
      Liste_clients[n].adresse:='';Liste_clients[n].portDistant:=0;Liste_clients[n].PortLocal:=0;
      Affiche('Client '+intToSTR(n+1)+' '+socket.remoteAddress+':'+intToSTR(socket.remotePort)+':'+intToSTR(socket.LocalPort)+' déconnecté',clyellow);
    end;
  end;
end;

procedure TFormPrinc.Listedesclientsconnects1Click(Sender: TObject);
var i,n : integer;
begin
  n:=0;
  for i:=0 to IdClients do
  begin
    if Liste_clients[n].adresse<>'' then
    begin
      Affiche('Client '+intToSTR(n+1)+' '+Liste_clients[n].adresse+':'+intToSTR(Liste_clients[n].portDistant)+':'+intToSTR(Liste_clients[n].portLocal),clyellow);
      inc(n);
    end;
  end;
  if n=0 then affiche('Aucun client connecté',clYellow);
  if n=1 then affiche('1 client connecté',clyellow);
  if n>1 then affiche(intToSTR(n)+' clients connectés',clyellow);
end;

procedure TFormPrinc.Horloge1Click(Sender: TObject);
begin
 if formHorloge<>nil then formHorloge.showModal;
end;

procedure TFormPrinc.Ficheshoraires1Click(Sender: TObject);
begin
  if formFicheHoraire<>nil then formFicheHoraire.showModal;
end;

procedure TFormPrinc.Validationdeshoraires1Click(Sender: TObject);
begin
  if not(horloge) then Demarre_horloge
  else horloge:=false;

  if horloge then Affiche('Horloge validée',clWhite)
  else Affiche('Horloge dévalidée',clWhite);
end;

procedure TFormPrinc.Ini1Click(Sender: TObject);
begin
  Init_Horloge;
end;

procedure TFormPrinc.Afficherlhorloge1Click(Sender: TObject);
begin
  affiche_horloge;
end;

procedure TFormPrinc.WindowPosChanging(var Msg: TWMWindowPosMsg);
begin
  if not(Verrouille) then exit;
  if (formclock<>nil) and not(FermeSC) then
  begin
    if (axFP<>left) or (ayFP<>top) then
    begin
      if affEvt then Affiche('FenPrinc bouge',clYellow);
      formclock.top:=top+DeltaFPCY;
      formclock.left:=left+DeltaFPCX;
     // formclock.Top:=top+height-Formclock.Height-20;
     // formclock.Left:=left+width-Formclock.width;
   end;
   axFP:=left;
   ayFP:=top;

  end;
  inherited;
end;



end.


