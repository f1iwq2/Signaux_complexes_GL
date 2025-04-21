unit Unitprinc;
// 27/03/2025 
(********************************************
  Programme signaux complexes Graphique Lenz
  Composants ClientSocket et ServeurSocket pour les connexions r�seau socket

  Delphi 7 :
  on utilise activeX Tmscomm pour les liaisons s�rie/USB

  Delphi 12 :
  on utilise AsyncPro pour les liaisons s�rie/USB - ce composant est compilable en 32 et en 64 bits.
  https://github.com/TurboPack/AsyncPro
  liste des fichiers n�cessaires:
  AdDispLog.inc
  AdExcept.fra
  AdExcept.pas
  AdPort.pas
  AdSelCom.dfm
  AdSelCom.pas
  AdStrMap.pas
  AwDefine.inc
  AwUser.pas
  AwWin32.pas
  OoMisc.pas

  un essai avec IdTCPClient (Indy) a �t� fait avec D7/D12. En D7 n�c�ssite le fichier Idtcpclient.dcu.
  En D12 l'event Rx n�cessite un thread et ne fonctionne pas bien. C'est ok en D7.

  Options de compilation D7: options du debugger/exception du langage : d�cocher "arreter sur exceptions delphi"
  sinon une exception surgira au moment de l'ouverture du com
  Dans projet/option/fiches : fiches disponibles : formtco uniquement
  En cas d'erreur interne L1333, supprimer les fichiers DCU du projet ou simplement faire construire

  Pour le mode sombre sous D12, il faut s�lectionner:
  Projet / Options // Application / manifeste /  fichier manifeste : personnaliser
  � la sauvegarde, ce champ apparaitra sous "g�n�rer automatiquement"
  et : d�cocher "activer les th�mes d'ex�cution"

 ********************************************

 Pour TMSCOM : il est n�cessaire d'avoir le fichier mscomm32.ocx dans le repertoire system de windows
 (Pour un Os64, %systemroot%\sysWOW64   pour unOs32 : %systemroot%\system32)
 et que ce composant soit enregistr� (avec regsvr32)

 Attention si le r�pertoire d'install n'est pas autoris�, windows10-11 va sauver les fichiers dans
 C:\Users\Nom_utilisateur\AppData\Local\VirtualStore\Program Files (x86)\Signaux_complexes
 il faut autoriser l'utilisateur: Utilisateurs (nom\utilisateurs)

 Pilotage des accessoires:
 raquette   octet sortie           anglais   NL
    +            2    =   vert  =  close  =  rechts = aiguillage droit  = sortie 2 de l'adresse d'accessoire
    -            1    =   rouge =  thrown =  afb    = aiguillage d�vi�  = sortie 1 de l'adresse d'accessoire

 ligne de commande en mode administrateur pour valider le socket du pare feu:
 netsh advfirewall firewall add rule name="cdm rail" dir=in action=allow program="C:\Program Files (x86)\CDM-Rail\cdr.exe" enable=yes
 *)
//
// En mode simulation run:
// CDM ne renvoie pas les d�tecteurs au d�part du RUN, ou pendant le RUN
// les noms des trains sont bien renvoy�s sur les actionneurs � 1
//
// En mode RUN CDM avec train:
// CDM renvoie le nom des trains sur les actionneurs � 1, jamais � 0
// et quelquefois (pas toujours!) sur les d�tecteurs � 1, jamais � 0 (il renvoie _NONE)
// Au d�but du RUN, CDM renvoie les �tats des d�tecteurs � 1 et en m�lang� les aiguillages et on en re�oit les �tats.
// Puis on re�oit la position des trains qui bougent. Si un train parqu� ne bouge pas, on ne re�oit rien de ce train.
//
// En mode RUN TCO CDM (sans trains) : une commande de vitesse � un train n'est pas transmise
// sur le r�seau. Les aiguillages oui
//
// En simulation:
// CDM Rail ne renvoie pas les �tats des aiguillages en d�but de simu
// Les aiguillages sont renvoy�s quand on clique dessus
// Les actionneurs fonctionnent. Les d�tecteurs ne sont pas renvoy�s.
//
// En mode centrale connect�e � signaux complexes (autonome)
// si on bouge un aiguillage � la raquette, SC r�cup�re bien sa position par XpressNet.
// Une loco sur un d�tecteur au lancement ne renvoie pas son �tat statique. Seuls les changements
// d'�tat sont renvoy�s par la centrale. Ou alors il faut demander explicitement les �tats des d�tecteurs
// � la centrale par le menu "interface / demander �tat d�tecteurs"
//
// Si SC envoie une position d'aiguillage � CDM, il ne change pas sa repr�sentation dans CDM.

//{$Q-}  // pas de v�rification du d�bordement des op�rations de calcul
//{$R-}  // pas de v�rification des limites d'index du tableau et des variables
//{$D-}    // pas d'information de debuggage : pas de d�bug possible
//{$L-}    // pas d'information sur les symboles locaux

{$DEFINE xAvecIdTCP}   // le composant IdTCPClient n'a pas d'evt receive, il faut le traiter dans un thread
// il ne marche pas bien en version D12, l'�vent RX provoque une violation au d�marrage puis plus rien

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls, ShellAPI, TlHelp32,
  ImgList, ScktComp, StrUtils, Menus, ActnList, MMSystem , math,
  Buttons, NB30, comObj, activeX //,DateUtils//, PsAPI

  {$IFDEF AvecIdTCP}
    ,IdTCPClient        // client socket indy , ne marche pas bien
  {$ENDIF}

  {$IF CompilerVersion >= 28.0}   // si delphi>=12
    ,Vcl.Themes         // pour les th�mes d'affichage (auric etc)
    ,Vcl.Styles.Ext     // styles �tendus
    ,AdPort, OoMisc     // AsyncPro pour COM/USB
    ,idGlobal           // pour utiliser tidBytes
  {$ELSE}
    ,MSCommLib_TLB      // TMSComm pour COM/USB
  {$IFEND}
  ;


type
  TFormPrinc = class(TForm)
    Timer1: TTimer;
    LabelTitre: TLabel;
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
    OpRoulage: TMenuItem;
    Demandetatdtecteurs1: TMenuItem;
    Informationsdusignal1: TMenuItem;
    Evenementsdetecteurspartrain1: TMenuItem;
    RazResa: TMenuItem;
    Vrifiernouvelleversion1: TMenuItem;
    N9: TMenuItem;
    Analyser1: TMenuItem;
    Coller1: TMenuItem;
    Affiche_fenetre_CDM: TMenuItem;
    ImageSignal20: TImage;
    TCOs1: TMenuItem;
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
    GroupBoxAcc: TGroupBox;
    Label2: TLabel;
    EditAdresse: TEdit;
    ButtonDroit: TButton;
    ButtonDevie: TButton;
    GroupBoxTrains: TGroupBox;
    Label4: TLabel;
    LabelFonction: TLabel;
    Label6: TLabel;
    EditAdrTrain: TEdit;
    ComboTrains: TComboBox;
    EditNumFonction: TEdit;
    ButtonFonction: TButton;
    EditFonc01: TEdit;
    Panel1: TPanel;
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
    Codificationdescantons1: TMenuItem;
    ButtonEssai: TButton;
    Routes1: TMenuItem;
    N17: TMenuItem;
    Codificationdestrains1: TMenuItem;
    Afficheroutespartrain1: TMenuItem;
    Sauvegarderlaconfiguration1: TMenuItem;
    N18: TMenuItem;
    Mesurerlavitessedestrains: TMenuItem;
    Affichelamesuredesvitesses1: TMenuItem;
    Etatdesactionneurs1: TMenuItem;
    Compilerlabasededonnes1: TMenuItem;
    PageControl: TPageControl;
    TabSheetSig: TTabSheet;
    ScrollBoxSig: TScrollBox;
    TabSheetTrains: TTabSheet;
    ScrollBoxTrains: TScrollBox;
    PopupMenuTrains: TPopupMenu;
    Propritsdutrain1: TMenuItem;
    ImageCompteur1: TImage;
    N19: TMenuItem;
    Affiche_compteur: TMenuItem;
    TabSheetComp: TTabSheet;
    ScrollBoxC: TScrollBox;
    ImageTachro: TImage;
    TrackBarZC: TTrackBar;
    PopupMenuCompteurs: TPopupMenu;
    Propritsdescompteurs1: TMenuItem;
    Dtacherlecompteur1: TMenuItem;
    Label1: TLabel;
    LabelNbTrains: TLabel;
    SBMarcheArretLoco: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    {$IF CompilerVersion >= 28.0}
    procedure RecuInterface(Sender: TObject;count : word);
    procedure RecuPeriph1(Sender: TObject;count : word);
    procedure RecuPeriph2(Sender: TObject;count : word);
    {$ELSE}
    procedure RecuInterface(Sender: TObject);
    procedure RecuPeriph1(Sender: TObject);
    procedure RecuPeriph2(Sender: TObject);
    {$IFEND}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonDroitClick(Sender: TObject);
    procedure EditvalEnter(Sender: TObject);
    procedure BoutonRafClick(Sender: TObject);

    procedure ClientSocketInterfaceError(Sender: TObject; Socket: TCustomWinSocket;ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketInterfaceConnect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ClientSocketInterfaceDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketInterfaceRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure ClientInfoError(Sender: TObject; Socket: TCustomWinSocket;ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientInfoConnect(Sender: TObject;Socket: TCustomWinSocket);
    procedure ClientInfoDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientInfoRead(Sender: TObject; Socket: TCustomWinSocket);


    procedure MenuConnecterUSBClick(Sender: TObject);
    procedure DeconnecterUSBClick(Sender: TObject);
    procedure MenuConnecterEthernetClick(Sender: TObject);
    procedure MenuDeconnecterEthernetClick(Sender: TObject);
    procedure AffEtatDetecteurs(Sender: TObject);
    procedure Etatdesaiguillages1Click(Sender: TObject);
    procedure Codificationdesaiguillages1Click(Sender: TObject);
    procedure ClientSocketCDMError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);

    procedure ClientSocketCDMConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketCDMRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ConnecterCDMrailClick(Sender: TObject);
    procedure DeconnecterCDMRailClick(Sender: TObject);
    procedure ClientSocketCDMDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure CodificationdessignauxClick(Sender: TObject);
    procedure FichierSimuClick(Sender: TObject);
    procedure ButtonEcrCVClick(Sender: TObject);
    procedure LireunfichierdeCV1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure ConfigClick(Sender: TObject);
    procedure ButtonLitCVClick(Sender: TObject);
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
    procedure OpRoulageClick(Sender: TObject);
    procedure Demandetatdtecteurs1Click(Sender: TObject);
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
    procedure Codificationdescantons1Click(Sender: TObject);
    procedure Routes1Click(Sender: TObject);
    procedure Codificationdestrains1Click(Sender: TObject);
    procedure Afficheroutespartrain1Click(Sender: TObject);
    procedure Sauvegarderlaconfiguration1Click(Sender: TObject);
    procedure MesurerlavitessedestrainsClick(Sender: TObject);
    procedure Affichelamesuredesvitesses1Click(Sender: TObject);
    procedure Button0Click(Sender: TObject);
    procedure Etatdesactionneurs1Click(Sender: TObject);
    procedure Compilerlabasededonnes1Click(Sender: TObject);
    procedure PopupMenuTrainsPopup(Sender: TObject);
    procedure Propritsdutrain1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Affiche_compteurClick(Sender: TObject);
    procedure ButtonEssaiClick(Sender: TObject);
    procedure TrackBarZCChange(Sender: TObject);
    procedure Propritsdescompteurs1Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure Dtacherlecompteur1Click(Sender: TObject);
    procedure PopupMenuCompteursPopup(Sender: TObject);
  private
    { D�clarations priv�es }
    procedure DoHint(Sender : Tobject);
    procedure WindowPosChanging(var Msg: TWMWindowPosMsg);  message WM_WINDOWPOSCHANGING;
  public
    { D�clarations publiques des composants dynamiques}
    Procedure ImageOnClick(Sender : TObject);
    procedure ImageTrainonclick(Sender : TObject);
    procedure ImageTrainDoubleClic(Sender : Tobject);
    procedure ProcOnMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure proc_checkBoxFB(Sender : Tobject);
    procedure proc_checkBoxFV(Sender : Tobject);
    procedure proc_checkBoxFR(Sender : Tobject);
    procedure procAide(Sender : Tobject);
    procedure ImCOnclic(Sender : TObject);
    procedure ImCOnDblclic(Sender : TObject);
    procedure ImC0Onclic(Sender : Tobject);
    procedure ImTBOnChange(Sender : Tobject);
    {$IF CompilerVersion >= 28.0}
    procedure DataReceived(const Data: TidBytes);
    {$ELSE}
    procedure DataReceived(const Data: string);  // r�ception interface socket indy
    {$IFEND}
  end;

  {$IFDEF AvecIdTCP}
    {$IF CompilerVersion >= 28.0}
    // thread interface socket Indy D12, pour cr�er event en r�ception
    TDataEventInterface=procedure(const Data: TidBytes) of object;
    TreadingThreadInterface=class(TThread)
    private
      FClient: TIdTCPClient;
      Fdata : Tidbytes;
      FOnData: TDataEventInterface;
    protected
      procedure Execute; override;
    public
      constructor Create(AClient: TIdTCPClient); reintroduce;
      property OnData: TDataEventInterface read FOnData write FOnData;
      procedure DataReceived;
    end;

    // thread p�riph�rique1 D12 socket Indy
    TDataEventPeriph1=procedure(const Data: TidBytes) of object;
    TreadingThreadPeriph1=class(TThread)
    private
      FClient: TIdTCPClient;
      Fdata : Tidbytes;
      FOnData: TDataEventPeriph1;
    protected
      procedure Execute; override;
    public
      constructor Create(AClient: TIdTCPClient); reintroduce;
      property OnData: TDataEventPeriph1 read FOnData write FOnData;
     procedure DataReceived;
    end;

    // thread p�riph�rique2 D12 socket Indy
    TDataEventPeriph2=procedure(const Data: TidBytes) of object;
    TreadingThreadPeriph2=class(TThread)
    private
      FClient: TIdTCPClient;
      Fdata : Tidbytes;
      FOnData: TDataEventPeriph2;
    protected
      procedure Execute; override;
    public
      constructor Create(AClient: TIdTCPClient); reintroduce;
      property OnData: TDataEventPeriph2 read FOnData write FOnData;
      procedure DataReceived;
    end;

    {$ELSE}

    // Thread interface Indy D7
    TDataEventInterface=procedure(const Data: string) of object;
    TreadingThreadInterface=class(TThread)
    private
      FClient: TIdTCPClient;
      FData: string;
      FOnData: TDataEventInterface;
    protected
    procedure Execute; override;
    public
      constructor Create(AClient: TIdTCPClient); reintroduce;
      property OnData: TDataEventInterface read FOnData write FOnData;
      procedure DataReceived;
    end;

    // Thread p�riph1 Indy D7
    TDataEventPeriph1=procedure(const Data: string) of object;
    TreadingThreadPeriph1=class(TThread)
    private
      FClient: TIdTCPClient;
      FData: string;
      FOnData: TDataEventPeriph1;
    protected
      procedure Execute; override;
    public
      constructor Create(AClient: TIdTCPClient); reintroduce;
      property OnData: TDataEventPeriph1 read FOnData write FOnData;
      procedure DataReceived;
    end;

    // Thread p�riph2 Indy D7
    TDataEventPeriph2=procedure(const Data: string) of object;
    TreadingThreadPeriph2=class(TThread)
    private
      FClient: TIdTCPClient;
      FData: string;
      FOnData: TDataEventPeriph2;
    protected
      procedure Execute; override;
    public
      constructor Create(AClient: TIdTCPClient); reintroduce;
      property OnData: TDataEventPeriph2 read FOnData write FOnData;
      procedure DataReceived;
    end;
    {$IFEND}
  {$ENDIF}

const
titre='Signaux complexes GL ';
itMaxi=70;            // it�rations maxi pour les recherches
MaxAcc=1024;          // adresse maxi d'accessoire XpressNet (test� � la LH100)
NbMaxDet=2048;        // indice maximal de d�tecteurs d'un r�seau
NbDetArret=500;       // Nombre de d�tecteurs arret de train
Max_Trains=200;       // nombre maximal de train de CDM ou d�clar�s ou en circulation
MaxZones=250;         // nombre de zones de d�tecteurs activ�s par les trains
MaxMemoires=100;      // Nombre maxi de m�moires
MaxTrainZone=40;      // nombre maximal de trains pour le tableau d'historique des zones
Mtd=128;              // nombre maxi de d�tecteurs pr�c�dents stock�s
Max_event_det=4000;   // nombre maximal d'�venements d�tecteurs
Max_action=100;       // nombre maximal d'actions
MaxCantons=100;       // nombre maximal de cantons
Long_tampon_interface=5000; // taille tampon interface
Max_actionneurs=2048; // nombre maxi d'actionneurs cdm
Maxelements=100;      // nombre maxi d'�l�ments de voies scann�s/r�serv�s
MaxBranches=200;      // nombre maxi de branches
MaxElBranches=200;    // nombre maxi d'�l�ments par branche
NbreMaxiAiguillages=MaxAcc; // nombre maxi d'aiguillages
NbreMaxiSignaux=250;  // nombre maxi de signaux
NbreMaxiDecPers=10;   // nombre maxi de d�codeurs personnalis�s
NbMaxi_Periph=10;     // nombre maxi de p�riph�riques COM/USB/Socket
LargImg=50;HtImg=91;  // Dimensions image des signaux (le plus grand, le 9 feux)
MaxTaches=300;        // Nombre maxi de taches pour pilotage des accessoires en mode asynchrone
MaxComUSBPeriph=2;    // Nombre maxi d'objets p�riph�riques p�riph�riques USB Tmscom
MaxComSocketPeriph=2; // Nombre maxi d'objets p�riph�riques p�riph�riques socket TClientsocket
const_droit=2;        // position droite aiguillages transmises par la centrale LENZ
const_devie=1;        // position d�vi�e aiguillages transmises par la centrale LENZ
const_devieG_CDM=3;   // position d�vi�e gauche aiguillages transmises par cdm
const_devieD_CDM=2;   // position d�vi�e droite aiguillages transmises par cdm
const_droit_CDM=0;    // position non d�vi�e aiguillages transmises par cdm
const_inconnu=9;      // position inconnue
const_pointe=10;      // aiguillage pris en pointe
const_talon=11;       // aiguillage pris en talon
IdClients=10;         // Index maxi de clients r�seau
LargImgTrain=200;     // largeur r�serv�e icone train page pricipale, onglets trains
HautImgTrain=50;      // hauteur r�serv�e icone train page pricipale, onglets trains
WH_KEYBOARD_LL=13;    // code api windows pour hooker clavier de bas niveau
MaxParcoursTablo=200; // taille maxi du tableau des routes
MaxRoutesCte=25000;   // Nombre maximal de routes
NbCouleurTrain=8;
MaxCdeDccpp=20;
DiamFeu=6.5;
couleurTexte=$A0FFFF;
clRose=$AAAAFF;
clCyan=$FFA0A0;
clviolet=$FF00FF;
GrisF=$191919;
clOrange=$0077FF;
couleurTrain : array[0..NbCouleurTrain] of Tcolor = (clRose,clYellow,clLime,ClCyan,clAqua,clFuchsia,clLtGray,clred,clWhite);
Max_Simule=10000;
Max_Event_det_tick=30000;
EtatSign : array[0..13] of string[20] =('carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','avertissement','jaune cli','ral 30','ral 60','rappel 30','rappel 60');

// texte de la combo box des signaux - attention ce n'est pas l'index de Signaux[x].aspect!!
Aspects : array[0..11] of string[20]=('2 feux','3 feux','4 feux','5 feux','7 feux','9 feux','Directionnel 2 feux','Directionnel 3 feux','Directionnel 4 feux',
                                     'Directionnel 5 feux','Directionnel 6 feux','Signal belge type 1');

// combinaisons possibles des �tats fran�ais
Etats : array[0..20] of string[30]=('Non command�',
                                    'carr�','s�maphore','rouge cli','vert','vert cli','violet','blanc','blanc cli','avertissement','jaune cli',
                                    'ralen 30','ralen 60','rappel 30','rappel 60','ralen 60 + jaune cli','rappel 30 + jaune','rappel 30 + jaune cli',
                                    'rappel 60 + jaune','rappel 60 + jaune cli','reserve');

// combinaisons possibles des �tats belges
EtatSignBelge: array[0..9] of string[30]=
                                   ('Non command�','vert jaune horizontal','rouge','vert','vert jaune vertical','rouge blanc',
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

consigneBLocUSB=125;
// constantes pour la proc�dure tache()
ttacheAcc=1;    // pilote accessoire
ttacheVit=2;    // vitesse train
ttacheFF=3;     // fonction F
ttacheTempo=4;  // tempo
//
ttDestCDM=1;   // destinataire CDM
ttDestXpressNet=2; // xpresset
ttDestDccpp=3;  // dccpp

// Type de d�clencheurs
Decl0=0;
DeclHorloge=1;
DeclPeriph=2;
DeclAccessoire=3;
DeclDetAct=4;
DeclZoneDet=5;
DeclDemarTrain=6;
DeclArretTrain=7;
DeclSignal=8;
DeclFonction=9;
DeclClavier=10;

// conditions
CondVrai=1;
CondFaux=2;
CondVitTrain=3;
CondPosAcc=4;
CondHorl=5;
CondTrainSig=6;
CondFonction=7;
CondBouton=8;
CondMemoireEgal=9;
CondMemoireSup=10;
CondMemoireInf=11;

// Type d'op�ration (action)
Action0=0;
ActionAffTCO=1;
ActionAffSC=2;
ActionAffCDM=3;
ActionAccessoire=4;
ActionArretTrains=5;
ActionLanceHorl=6;
ActionArretHorl=7;
ActionInitHorl=8;
ActionAffHorl=9;
ActionVitesse=10;
ActionCdePeriph=11;
ActionFonctionF=12;
ActionSon=13;
ActionTempo=14;
ActionBoutonTCO=15;
ActionAffecteMemoire=16;
ActionIncMemoire=17;
ActionDecMemoire=18;

// icones
IconeTCO=0;
IconeSC=1;
IconeCDM=2;
IconeAccessoire=3;
IconeStopTrains=4;
IconeLanceHorl=5;
IconeArretHorl=6;
IconeInitHorl=7;
IconeHorloge=8;
IconeVitTrain=9;
IconePeriph=10;  //usb
IconeDet=17;
IconeZoneDet=18;
IconeArretTrain=19;
IconeDemarTrain=20;
IconeVrai=21;
IconeFaux=15;
IconeSignal=22;
IconeDeclSignal=23;
IconeDroite=24;
IconeFonction=25;
IconeBouton=26;
IconeActionAffecteMemoire=27;
IconeActionIncMemoire=28;
IconeActionDecMemoire=29;
IconeCondMemoireEgal=30;
IconeCondMemoireSup=31;
IconeCondMemoireInf=32;
IconeBoutonClavier=33;


type
Tproc=(Ttrouve_actionneurs_aig,TAig_Adj,Tsuivant_alg3,Tindex_signal_det,TAig_ext,Tdet_contigu,Tdet_suiv_cont,Tdet_adj,
       texplore_branche,Tdet_prec_signal,tdetecteur_suivant_El,ttrouve_actionneur,Tcond_carre,Tcarre_signal,
       Tsignal_suivant_det,Tetat_signal_suivant,TAiguille_deviee,Ttest_memoire_zones,TSignal_precedent,tPresTrainPrec,
       Treserve_canton,Tlibere_canton,Treserve_dereserve_det,Texplore_el,TAction_Operation);
Tinterface    = (_interface,periph1,periph2);   // interface USB : interface vers centrale, p�riph�rique 1 ou 2
TEquipement   = (rien,aig,tjd,tjs,triple,det,buttoir,voie,crois,act,sig);   // voie uniquement pour le tco
Taccessoire   = (aigP,signal);             // aiguillage ou signal  pour la proc�dure pilote_acc
TBranche      = record
                  BType : Tequipement ;   // ne prend que les valeurs suivantes: d�t aig Buttoir
                  Adresse : integer ;     // adresse du d�tecteur ou de l'aiguillage
                end;
// structure pour hook clavier bas niveau pour le bloc USB
tagKBDLLHOOKSTRUCT =
   packed record    // type enregistrement compact�
    vkCode,scanCode,flags,time : dword;
    dwExtraInfo : Integer;
  end;
  KbDLLHookStruct = tagKbDLLHookStruct;
  PkBDLLHookStruct= ^KbDLLHookStruct;

// type fonction
Tfonction =
 record
    typ : integer;               // opOU, EtatDCC, EtatDet ... etc
    Indexprec  : integer ;       // index du niveau pr�c�dent d'origine (parent)
    adresse,etat : integer;      // adresse : l'indice 0 contient le nombre d'�l�ments
    OpMemoire : integer;         // op�rateur "m�moire" : 0=�gal 1=> 2=<
    niveau : integer;            // niveau : l'indice 0 contient le num�ro de fonction modifiable
    traite : boolean;
    etatprec : boolean;          // sert au front montant
    etatactuel : boolean;        // etat actuel
    train : string;
  end;

Tstyle = record
    NomCheminFichier : string;   // avec le chemin
    NomFichier  : string;
    NomStyle : string;     // nom � utiliser pour l'ouverture
    clarte   : (tous,sombre,moyen,clair);
  end;

Taiguillage = record
                Adresse : integer;         // adresse de l'aiguillage
                AncienAdresse : integer;
                modele : TEquipement;      // rien, aig, tjd ...
                position,AncPos,           // position actuelle : 1=d�vi�  2=droit (centrale LENZ) , position ancienne
                posInit,                   // position d'initialisation 1=d�vi� 2=droit 9=non positionn�
                Adrtriple,                 // 2eme adresse pour un aiguillage triple
                temps,                     // temps de pilotage (dur�e de l'impulsion en x 100 ms
                InversionCDM : integer ;   // pour les aiguillages d�clar�s invers�s dans CDM, utilis� en mode autonome (param�tre I1)
                vitesse : integer;         // vitesse de franchissement de l'aiguillage en position d�vi�e (60 ou 90)
                AdrTrain : integer;        // adresse du train qui a r�serv� l'aiguillage
                ADroit : integer ;         // adresse (TJD:identifiant ext�rieur) connect� sur la position droite en talon
                ADroitB : char ;           // P D S Z
                ADevie : integer ;         // adresse (TJD:identifiant ext�rieur) adresse de l'�l�ment connect� en position d�vi�e
                ADevieB : char;            // caract�re (D ou S)si aiguillage de l'�l�ment connect� en position d�vi�e
                APointe : integer;         // adresse de l'�l�ment connect� en position droite ;   ou adresse de l'aiguillage triple
                APointeB : char;           // P D S Z
                DDroit : integer;          // destination de la TJD en position droite
                DDroitB : char ;
                DDevie : integer;          // destination de la TJD en position d�vi�e ou 2eme adresse de la TJD
                DDevieB : char ;
                tjsint   : integer;        // pour TJS
                tjsintb  : char ;
                // �l�ments connect�s sur la branche d�vi�e 2 (cas d'un aiguillage triple)
                Adevie2 : integer;         // aiguilage triple
                Adevie2B : char ;
                // �tats d'une TJD (2 ou 4, 4 par d�faut)
                EtatTJD : integer;

                // si modifi� en mode config
                modifie : boolean ;
                visible : boolean ; //invisible si 2eme adresse triple
                AdrCDM : integer; // adresse de l'aiguillage dans CDM, si c'est une BJD (bretelle jonction double)
              end;
TtabloDet = array[0..MaxParcoursTablo] of integer;
TSignal = record
                adresse, aspect : integer;  // adresse du signal, aspect (2 feux..9 feux 12=direction 2 feux .. 16=direction 6 feux)  (11=signal belge 1)
                Img : TImage;               // Pointeur sur structure TImage du signal
                Lbl : TLabel;               // pointeur sur structure Tlabel du signal
                checkFB : TCheckBox;        // pointeur sur structure Checkbox "demande feu blanc"
                checkFR : boolean;          // demande feu rouge cli
                checkFV : boolean;          // demande feu vert cli
                FeuVertCli : boolean ;      // avec checkbox ou pas
                FeuRougeCli : boolean ;     // avec checkbox ou pas
                contrevoie : boolean;       // signal de contrevoie (SNCB)
                Verscontrevoie : boolean;   // signal vers contrevoie (SNCB)
                FeuBlanc : boolean ;        // avec checkbox ou pas
                decodeur : integer;         // type du d�codeur  // 'rien','DigitalBahn','CDF','LS-DEC-SNCF','LEB','Digikeijs','Unisemaf','SR','Arcomora',LS_DEC_NMBS,Bmodels,LEA puis les perso
                Adr_det1 : integer;         // adresse du d�tecteur1 sur lequel il est implant�
                Adr_det2 : integer;         // adresse du d�tecteur2 sur lequel il est implant� (si un signal est pour plusieurs voies)
                Adr_det3 : integer;         // adresse du d�tecteur3 sur lequel il est implant� (si un signal est pour plusieurs voies)
                Adr_det4 : integer;         // adresse du d�tecteur4 sur lequel il est implant� (si un signal est pour plusieurs voies)
                Adr_el_suiv1 : integer;     // adresse de l'�l�ment1 suivant voie 1
                Adr_el_suiv2 : integer;     // adresse de l'�l�ment2 suivant voie 2 (si un signal est pour plusieurs voies)
                Adr_el_suiv3 : integer;     // adresse de l'�l�ment3 suivant voie 3 (si un signal est pour plusieurs voies)
                Adr_el_suiv4 : integer;     // adresse de l'�l�ment4 suivant voie 4 (si un signal est pour plusieurs voies)
                Btype_suiv1 : TEquipement ; // type de l'�l�ment suivant voie 1 - Ne prend que les valeurs rien, det ou aig
                Btype_suiv2 : TEquipement ; // type de l'�l�ment suivant voie 2 - Ne prend que les valeurs rien, det ou aig
                Btype_suiv3 : TEquipement ; // type de l'�l�ment suivant voie 3 - Ne prend que les valeurs rien, det ou aig
                Btype_suiv4 : TEquipement ; // type de l'�l�ment suivant voie 4 - Ne prend que les valeurs rien, det ou aig
                VerrouCarre : boolean ;     // si vrai, le feu se verrouille au carr� si pas de train avant le signal
                // EtatVerrouCarre : boolean ; // si vrai, le feu est verrouill� au carr�
                modifie     : boolean;      // feu modifi�
                EtatSignal  : word  ;       // �tat du signal
                AncienEtat  : word  ;       // ancien �tat du signal
                AncienAff   : word  ;       // �tat ancien affichage
                UniSemaf    : integer ;     // d�finition suppl�mentaire de la cible pour les d�codeurs UNISEMAF
                BinLin      : integer;      // Binaire=0 ou Lin�aire d�codeur LEB - =1 : mode 2 signaux d�codeur CDF
                AigDirection : array[1..7] of array of record        // pour les signaux directionnels : contient la liste des aiguillages associ�s
                                  Adresse : integer;     // 6 feux max associ�s � un tableau dynamique d�crivant les aiguillages +1 position 0
                                  posAig  : char;
                                end;
                CondCarre : array[1..6] of array of record  // conditions suppl�mentaires d'aiguillages en position pour le carr�
                                  // attention les donn�es sont stock�es en adresse 1 du tableau dynamique
                                  Adresse : integer;    // aiguillage
                                  posAig : char;
                               end;
                CondFeuBlanc : array[1..6] of array of record  // conditions suppl�mentaires d'aiguillages en position pour le blanc
                                  // attention les donn�es sont stock�es en adresse 1 du tableau dynamique
                                  Adresse : integer;    // aiguillage
                                  posAig : char;
                               end;
                SR : array[1..19] of record   // configuration des sorties du d�codeur St�phane Ravaut ou digikeijs ou cdf ou LEA pour chacun des 19 �tats
                                   sortie1,sortie0 : integer;     // ex SR[1]=[carre] (voir tableau Etats)
                                   end;
                Na : integer;               // nombre d'adresses du signal occup�es par le d�codeur CDF/SR/digikeijs/Belge
                DetAmont : TtabloDet;       // tableau des d�tecteurs amonts, calcul�s � la lecture du fichier de config
              end;

TPeripherique = record
                  nom : string;              // nom du p�riph�rique
                  NumCom : integer;          // num�ro de port COM si c'est une liaison com usb
                  portouvert : boolean;      // si le port COM est ouvert
                  numComposant : integer ;   // num�ro de composant MSCOM ou clientSocket
                  ScvAig,ScvDet,ScvAct,ScvVis,cr,dtr,rts : boolean ;  // services, visible, avecCR ...
                  protocole,tamponRX : string; // protocole COM ou socket, tampon de r�ception
                end;

TPn = record  // structure passage � niveau
    AdresseFerme  : integer;  // adresse de pilotage DCC pour la fermeture  ou num�ro de p�riph�rique pour pilotage usb
    commandeFerme : integer;  // commande de fermeture (1 ou 2)
    AdresseOuvre  : integer;  // adresse de pilotage DCC pour l'ouverture
    commandeOuvre : integer;  // commande d'ouverture (1 ou 2)
    NbVoies       : integer;  // Nombre de voies du PN
    Pulse         : integer;  // 0=commande maintenue  1=Impulsionnel
    TypeCde       : integer;  // 0=par accessoire / 1=par COMUSB ou sockets
    commandeF,CommandeO : string; // commande pour com/usb ou socket
    compteur      : integer;  // comptage actionneurs fermeture et d�comptage actionneurs ouverture
    actionneur    : boolean;  // =vrai par actionneur sinon pae zone
    Voie : array [1..5] of record
             ActFerme,ActOuvre : integer ; // actionneurs provoquant la fermeture et l'ouverture
             detZ1F,detZ2F,detZ1O,detZ2O : integer; // Zones de d�tection
           end;
  end;

Toperation = record
               numoperation,heure,minute,
               adresse,
               etat,NumTCO,
               TempoCourante,      // valeur courante de la tempoF
               vitesse,periph,
               fonctionF,TempoF    : integer;
               zero,valide         : boolean;
               chaine              : string;
               train,traincourant  : string;
              end;

Tcondition = record
               numcondition    : integer;
               adresse         : integer;
               vitmini,vitMaxi : integer;
               accessoire,etat : integer;
               HeureMin,MinuteMin,
               HeureMax,MinuteMax : integer;
               train           : string;
             end;

TparamCompt=record
       AigCX,AigCY,         // centre de l'aiguille
       Raig,                // rayon aiguille
       Rav,                 // rayon arc vert (consigne vitesse)
       ImgL,ImgH : integer; // larg haut image
       idTrain :  integer;
       AngleFin : integer;  // angle maxi du compteur
       redX,redY,ComptA,ComptB : single;
     end;

Taction = record
    // action
    NbCond,NbOperations,declencheur,vitesse,
    heure,minute,NumPeriph,
    adresse,etat,adresse2   : integer;  // adresse: adresse de base ou heure ; adresse2=cas d'une Zone  ou minute
    trainDecl,ordrePeriph,NomAction : string;
    traite                  : boolean;
    TabloCond               : array of Tcondition;
    TabloOp                 : array of Toperation;
  end;

TelementRoute=record
             // l'index 0 contient dans "adresse" le nombre d'�l�ments
             //                    dans "talon" (si talon=true : consigne vitesse n�gative)
             //                    dans "pos" l'id de route
                adresse : integer;   // adresse de l'�l�ment
                typ : tequipement;   // type de l'�l�ment
                pos : integer;       // position pour la route si l'�l�ment est un aiguillage // indice[0] : id de la route
                talon : boolean;     // vrai si l'�l�ment est un aiguillage pris en talon pour la route // indice[0]: inverse le sens de la loco
                traite : boolean;    // trait� ou non par la proc�dure aig_canton
              end;

Tactionneur = record
    adresse,prox1,prox2  : integer;
    NumBranche,IndexBranche : integer;
    etat                    : boolean;
    train                   : string;
  end;

TUneRoute=array[0..MaxParcoursTablo] of TelementRoute;      // Une route

TElroute=array[1..MaxRoutesCte] of TUneroute;             // tableau de routes

// la longueur de la structure ttrain ne permet pas le passage de param�tre en proc�dure
tTrain =  record
              nom_train : string;
              inverse : boolean;                // placement
              detecteurA : integer;             // d�tecteur sur lequel le train se trouve
              detecteurSuiv : integer;          // d�tecteur vers lequel se dirige le train
              ElSuivant : integer;              // �l�ment suivant vers lequel se dirige le train
              TElSuivant : tEquipement;
              adresse,vitmax,VitNominale,VitRalenti : integer;
              AncVitesseCons : integer;         // ancienne consigne
              AVitesseCons : integer;           // ancienne consigne du tick pr�c�dent
              VitesseCompteur : integer;        // vitesse en cours jusque VitesseCons du compteur
              vitesseCons : integer;            // vitesse Consigne actuelle de pilotage par CDM ou SC
              VitesseReelleR : single;          // Vitesse r�elle calcul�e (tient compte de la d�c�l�ration)
              VitesseReelle : integer;
              VitesseBlocUSB : integer;
              BlocUSB : integer;                // N0 du bloc USB sur lequel le train est affect�
              sens   : integer;                 // sens de d�placement, stockage provisoire pour restocker dans le tableau canton[]
              longueur: integer;                // longueur de la loco
              compteur_consigne : integer;      // compteur de consigne pour envoyer deux fois la vitesse en 10eme de s
              cv3,cv4 : integer;
              crans : integer;                  // crans du d�codeur
              // pilotage des trains-------------------
              TempoArretCour : integer;         // valeur dynamique
              TempoArretTemp : integer;         // temps d'arr�t temporis� sur un d�tecteur
              TempoDemarre : integer;           // tempo de d�marrage, valeur dynamique
              TempsDemarreSig : integer;        // temps de red�marrage du signal qui s'ouvre, valeur d'initialisation (fichier de config)

              index_event_det_train : integer;  // index du train en cours de roulage du tableau event_det_train
              arret_det : boolean;              // arr�t du train sur le d�tecteur
              phase_arret : integer;            // num�ro de phase arret
              // mesure et �talonnage de la vitesse------
              VitesseDetE : integer;            // vitesse en entr�e du d�tecteur
              VitesseDetS : integer;            // vitesse en sortie du d�tecteur
              //Temps_cour  : integer;            // compteur du temps en 1/10 s �volution pendant le d�tecteur � 1
              pointMes    : integer;            // pointeur de mesures 1 � 100
              // tableau des mesures
              mesure : array[1..100] of record
                // valeurs mesur�es:
                VitCons   : integer;            // vitesse de consigne en crans
                detecteurM : integer;            // d�tecteur
                temps     : integer;            // temps de passage sur le d�tecteue � 1 (1/10s)
                // valeurs calcul�es:
                vr        : single;             // vitesse r�elle calcul�e en cm/s
              end;
              // Mesure vitesse des trains: affectation des vitesses moyennes aux d�tecteurs rencontr�s
              // par detecteur (NbMaxDet) et par consigne (128 max)
              detecteurR  : array[0..NbMaxDet,1..128] of record
                nombre    : integer;
                moyenne   : single;            // moyenne de la vitesse calcul�e par d�tecteur/
                ecart     : single;            //
                somme     : single;
              end;
              ConsV1,consV2,consV3 : integer;  // consignes auxquels les coefficients V1 V2 V3 ont �t� calcul�s
              CoeffV1,CoeffV2,CoeffV3 : single; // coefficients pour calculer la vitesse r�elle en cm/s depuis la vitesse en crans
              pente1,b1,pente2,b2 : single;     // pente et b des 2 �quations de droite de vitesse
              //---------
              canton : integer ;                // num�ro du canton (pas index) sur lequel le train se trouve
              icone : Timage ;
              NomIcone : string;
              // icone sur fenetre cdm (FormAnalyseCDM)---
              SbitMap : TBitmap ;               // pointeur sur tampon sous l'icone de d�placement du train en page CDM
              ax,ay,x,y : integer;              // coordonn�es du train (anciennes et nouvelles) en points windows
              x0,y0,x1,y1 : integer;            // ancien contour du tampon, pour l'animation dans la fen�tre cdm
              // routes -----------------------------------
              roulage : integer;                // =1 train en roulage mais arr�t� pour r�servation par tiers =2 en roulage effectif
              dernierDet : integer;             // dernier d�tecteur trait�
              cantonOrg,CantonDest : integer;   // cantons origine et destination si route
              route :  TuneRoute;               // tableau de la route en cours du train
              NomRoute : array[1..30] of string; // nom de la route sauvegard�e
              NomRouteCour : string;            // nom de la route courante
              routePref : array[0..30] of TUneroute; // tableaux dess route sauvegard�es du train. routePref[0,0].adresse est le nombre de routes
                                                     // routePref[0,0].talon = consigne inverse au train
              PointRout : integer;
              // cantons (via leurs d�tecteurs) sur lesquels le train doit d'arr�ter
              DetecteurArret : array[1..NbDetArret] of record
                              Prec,             // adresse pr�c�dent, pour le sens
                              detecteur,        // d�tecteur sur lequel s'arreter si le canton a 2 d�tecteurs
                              temps : integer;  // temps d'arr�t en s
                              TPrec : tEquipement; // aig ou det uniquement
                             end;
          end;


Ttache = array[1..MaxTaches] of record
              typeTache : integer ; // 0 : rien  - 1 : accessoire ... etc
              traite    : boolean;  // traitement en cours
              tempo     : integer;  // tempo avant ex�cution de la commande
              dest      : integer;  // destinataire : 1=CDM  - 2=XpressNet  3=Dccpp
              chaine    : string;   // chaine de commande � envoyer au p�riph�rique
            end;

TchaineBIN=array[0..Long_tampon_interface] of byte;

{$IF CompilerVersion >= 28.0}   // si delphi>=11
BinaryString = UnicodeString;
{$ELSE}
BinaryString = String;
{$IFEND}

var
  maxaiguillage,detecteur_chgt,Temps,Tempo_init,Suivant,ntrains,MaxPortCom,rAig,idTrainF3,
  N_Cv,index_simule,NDetecteurs,N_Trains,N_routes,espY,Tps_affiche_retour_dcc,
  NbreImagePligne,NbreBranches,Index2_aig,branche_det,ntrains_cdm,compteur,
  I_simule,maxTablo_act,NbreVoies,El_suivant,N_modules_dcc,NbDet1,ncrois,NbreCompteursPLigne,
  tempsCli,NbreSignaux,pasreponse,AdrDevie,fenetre,Tempo_Aig,Tempo_Signal,etat_init_interface,
  NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
  Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,NbrePN,ServeurInterfaceCDM,index_couleur,
  ServeurRetroCDM,TailleFonte,Nb_Det_Dist,Tdoubleclic,algo_Unisemaf,fA,fB,
  etape,idEl,intervalle_courant,filtrageDet0,Nactionneurs,nombreStyles,idTrainUSB,
  TpsTimeoutSL,formatY,OsBits,NbreDecPers,NbDecodeur,NbDecodeurdeBase,HautImageC,LargImageC,
  LargeurF,HauteurF,OffsetXF,OffsetYF,PosSplitter,NbPeriph,NbPeriph_COMUSB,NbPeriph_Socket,
  AigMal,AncMinute,axFP,ayFP,NbreOperations,NbreDeclencheurs,index_seqAct,NbreConditions,
  SensAig,NbreRoutes,nbreIti,DetAtrouve,DetDepart,iteration,IdActTr,Long_recue,
  prec1,prec2,Eprec,Esuiv,param1,param2,param3,MaxParcours,MaxRoutes,tempoBlocUSB,
  IdTrainClic,TempoCombo,RayonCompteur,XcentreCompteur,YCentreCompteur,AigCX,AigCY,
  IncrCompteur,tickt2,pointeurTaches,Nbre_Interfaces_CDM : integer;

  ack,portCommOuvert,traceTrames,AffMem,CDM_connecte,dupliqueEvt,affiche_retour_dcc,
  Raz_Acc_signaux,AvecTCO,terminal,Srvc_Aig,Srvc_Det,Srvc_Act,MasqueBandeauTCO,
  Srvc_Pos,Srvc_Sig,debugtrames,LayParParam,AvecFVR,InverseMotif,Srvc_tspd,fermeSC,
  Hors_tension,TraceZone,parSocketLenz,ackCdm,PremierFD,doubleclic,debugRoulage,
  NackCDM,MsgSim,StopSimu,succes,recu_cv,AffAigDet,AffTiers,AvecDemandeAiguillages,
  TraceListe,clignotant,nack,Maj_signaux_cours,configNulle,LanceCDM,AvecInitAiguillages,
  AvecDemandeInterfaceUSB,AvecDemandeInterfaceEth,aff_acc,affiche_aigdcc,modeStkRetro,
  retEtatDet,roulage,init_aig_cours,affevt,placeAffiche,clicComboTrain,clicAdrTrain,
  fichier_module_cdm,Diffusion,cdmDevant,serveurIPCDM_Touche,avecAckCDM,Stop_Maj_Sig,
  Modesombre,serveur_ouvert,pasChgTBV,FpBouge,debugPN,simuInterface,option_demitour,
  mesureTrains,AffCompteur,clicTBGB,clicTBfen,clicTBTrain,ModeTache,NoTraite : boolean;

  Style : array[0..200] of Tstyle;

  Interfaces_CDM : array[1..20] of string;

  tick,Premier_tick : longint;

  // composants de s�lection du train
  Image_Train: array[0..Max_Trains] of tImage;
  LabelTrain,LabelVitesse,LabelBlocUSB : array[0..Max_Trains] of tLabel;

  KBHook: HHook;

  {$IF CompilerVersion >= 28.0}
  MSCommUSBInterface, MsCommCde1,MsCommCde2 : tApdComPort;  // objets AsyncPro
  {$ELSE}
  MSCommUSBInterface, MsCommCde1,MsCommCde2 : TMSComm; // objets TMSCOM
  {$IFEND}

  CDMhd : THandle;

  proc : Tproc;

  FormPrinc: TFormPrinc;

  Enregistrement,chaine_Envoi,Id_CDM,Af,version_Interface,entete,suffixe,Lay,
  CheminProgrammesCDM,CheminProgrammes,cheminWin,fichierAide : string;

  Ancien_detecteur : array[0..NbMaxDet] of boolean;   // anciens �tat des d�tecteurs et adresses des d�tecteurs et leur �tat

  trameIF : array of Byte;

  detecteur : array[0..NbMaxDet] of  // d�tecteurs index�s par l'adresse
  record
    Etat : boolean;            // �tat 0/1 du d�tecteur
    Train : string;            // nom du train ayant enclench� le d�tecteur (CDM - pas fiable)
    AdrTrain : integer;        // adresse du train sur le d�tecteur
    AdrTrainRes : integer;     // adresse du train qui r�serve le d�tecteur
    IndexTrainRoulant : integer;    // index du train plac� (g�n�r� dans calcul_zones_V1F)
    Tempo0   : integer;        // tempo de retomb�e � 0 du d�tecteur (filtrage)
    Temps_cour : integer;      // tempo de comptage d�ecteur � 1 pour mesurer la vitesse du train
    NumBranche,IndexBranche : integer; // o� se trouve le d�tecteur dans les branches
    index : integer;
    canton1,canton2 : integer; // Num�ro (pas index) des deux cantons adjacents (1 ou 2)
    longueur : integer;        // longueur en cm
    distCour : integer;        // distance courante accumul�e, en mm
    DistIncr : single ;        // distance accumul�e
    ComptCour : integer;       // compteur en 1/10s d�t � 1
    distArret : integer;       // distance du train au fd du d�tecteur si ModeArret=1
    ModeArret : integer;       // 1=arret en fin de d�tecteur + DistArret   2=arret au milieu du d�tecteur
    suivant,precedent : integer;       // �l�ments suivants/pr�c�dents pour le sens de circulation en cours
    TypSuivant,TypPrecedent : Tequipement;
  end;
  Adresse_detecteur : array[0..NbMaxDet] of integer; // adresses des d�tecteurs par index

  {$IFDEF AvecIdTCP}
  clientTCPInterface: tidtcpclient;
  {$ENDIF}

  Ecran : array[1..10] of record     // �crans du pc
            x0,y0,larg,haut : integer;
          end;

  Liste_clients : array[0..IdClients] of record
                    adresse : string;
                    PortDistant,PortLocal : integer;
                  end;

  taches : Ttache;

  Actionneur_trouve : array[1..10] of integer;

  TypeGen,t1,t2,tprec,tsuiv : TEquipement;

  // Historique des zones d'occupation par train
  TrainZone : array[1..MaxTrainZone] of  // train, index
              record
                train : string;
                adrTrain : integer; // adresse du train
                Nbre : integer;     // nombre de zones (ci dessous)
                Zone : array[1..MaxZones] of record det1,det2 : integer; end;
              end;

  // tableau des �v�nements d�tecteurs , aiguillages, actionneurs
  event_det_tick : array[0..Max_Event_det_tick] of
  record
    tick : longint;
    adresse : integer ;
    train : integer;        // num�ro du train si d�tecteur
    modele : Tequipement ;  // d�tecteur, aiguillage, actionneur
    etat : integer ;        // �tat du d�tecteur de l'aiguillage ou de l'actionneur
    reaffecte : integer ;   // =1 r�affect� au bon train dans le cas de 2 d�tecteurs contigus qui ne s'enchainent pas bien =2 r�affect� par changement aiguillage
  end;

  tablo_Index_Signal : array[0..MaxAcc] of integer; // tableau d'index des accessoires signaux sur le bus DCC
  tablo_Index_Aiguillage : array[0..MaxAcc] of integer; // tableau d'index des aiguillages sur le bus DCC

  // tableau des p�riph�riques
  Tablo_periph : array[1..NbMaxi_Periph] of TPeripherique;

  // Zones d'occupations actuelles
  MemZone : array[0..NbMaxDet,0..NbMaxDet] of
  record
    etat : boolean;  // m�moires de zones des d�tecteurs
    train : string;
    IndexTrainRoulant,      //  index du train plac� (g�n�r� dans calcul_zones_V1)
    AdrTrain : integer;
    Prev : integer ;     // d�tecteur suivant pr�visionnel
  end;

  Tablo_action : array[0..Max_action] of Taction;

  Actionneur : array[0..Max_actionneurs] of Tactionneur;  // actionneurs index�s par num�ro

  // d�codeurs personnalis�s de signaux
  decodeur_pers : array[1..NbreMaxiDecPers] of
  record
    nom                    : string;
    NbreAdr,
    nation                 : integer;      // 1=FR  2=BE
    commande               : integer;      // =0 pilotage par centrale  =1 pilotage par p�riph�rique COM/USB/Socket
    Peripherique : integer;                // num�ro du p�riph�rique
    desc : array[1..20] of                 // Description des 20 �tats. Index=adresse d'offset
    record
      etat1,etat2,                         // �tats (rouge, s�maphore etc)
      offsetAdresse,                       // d�calage d'adresse des deux sorties
      sortie1,sortie2       : integer;     // valeur des deux sorties pour les �tats
      Chcommande            : string;      // si commande com/usb/socket
    end;
  end;

  Ancien_actionneur : array[0..MaxAcc] of integer;

  KeyInputs: array of TInput;
  Tablo_PN : array[0..Max_action] of TPn;

  Tablo_Simule : array[0..Max_Simule] of
  record
    tick : longint;
    modele : Tequipement;
    Adresse,etat : integer ;
    train : string;
  end;

  seq_actions : array[1..30] of
  record
    indiceAction,IndiceOp,  // indice � partir duquel reprendre l'ex�cution
    op,tick : integer;      // op�ration
  end;

  Declencheurs : array[0..10] of
  record
    nom : string;
    index : integer;
    famille : integer; // 1=syst�me 2=CDM 3=SC  ne sert qu'� filtrer l'affichage par la combobox
  end;

  Fonction : array[0..100,0..100] of Tfonction;
  NomFonction : array[0..100] of string;
  ArbreFonc : array[0..100,0..100] of integer;

  blocUSB : array[1..10] of record
              AffTrain : string;
              rotatifM,rotatifP,clic,increment : integer;
              Bp1,bp2,bp3,bp4,bp5,bp6,bp7,bp8,bp9,bp10 : integer;
              Fbp1,fbp2,fbp3,Fbp4,fbp5,fbp6,Fbp7,fbp8,fbp9,Fbp10 : integer; // fonctions F des BP
              Fnp1,fnp2,fnp3,Fnp4,fnp5,fnp6,Fnp7,fnp8,fnp9,Fnp10 : integer; // �tat F des BP
            end;
           
  Memoire : array[0..MaxMemoires] of integer;

  Conditions : array[0..12] of
  record
    nom : string;
    index : integer;
    famille : integer;
  end;

  operations : array[0..20] of
  record
    nom : string;
    index : integer;
    famille : integer;
  end;

  tablo_CV : array [1..255] of integer;
  couleur,Couleurfond : Tcolor;

  // mod�lisations des fichiers config
  branche : array [1..MaxBranches] of string;

  // Pour les tableaux aiguillage et signaux : l'indice du tableau aiguillage n'est pas son adresse
  // ils sont stock�s dans les tableaux tablo_Index_Signal[adresse]=index  et tablo_Index_Aiguillage[adresse]=index
  Aiguillage : array[0..NbreMaxiAiguillages] of Taiguillage;
  // signaux - L'index du tableau n'est pas son adresse
  Signaux : array[0..NbreMaxiSignaux] of TSignal;

  CompteurT : array[0..Max_trains] of record
     gb : tgroupBox;
     Img : timage;
     tb : ttrackbar;
     bouton : tbutton;
     FcBitmap : Tbitmap;         // bitmap de fond de compteur
     paramcompt : TparamCompt;   // liste de param�tres du compteur
     lbl : Tlabel;
  end;

  CdeDccpp : array[1..MaxCdeDccpp] of string;

  trains_cdm : array[1..Max_Trains] of record
              nom_train : string;
              adresse,vitmax : integer;
           end;

  // trains en roulage sur le r�seau et de la base de donn�es [section_trains]
  // trains[0] est utilis� pour le tri. L'indice 1 contient le 1er train.
  trains : array[0..Max_Trains] of tTrain;

  // �l�ments scann�s et/ou verrouill�s
  elements : array[1..Maxelements] of
             record
               adresse : integer;
               typ : Tequipement;
             end;

  TabloParcours,TabloRoute,TabloItin : TelRoute;

  // liste des �v�nements d�tecteurs
  event_det : array[1..Max_event_det] of
              record
                adresse : integer;
                etat : boolean;
              end;

  event_det_train : array[0..Max_Trains] of record
                    NbEl : integer;               // nombre d'�l�ments dans le tableau ci-dessous
                    AdrTrain : integer;           // index du train
                    signal_rouge : integer ;      // adresse du signal si le train est arret� sur un signal au rouge (carr� s�maphore violet)
                    nom_train : string;           // nom du train
                    suivant : integer;            // suivant pr�visionnel � det1 et det2
                    Det : array[1..3] of record   // tableau des evts d�tecteurs par train - 1 train peut occuper 2 d�tecteurs simultan�ment donc il faut 3 �tats historique
                      adresse : integer;
                      etat : boolean;
                      end;
                    end;

  decodeur : array[0..30] of string[20];

  Signal_supprime,Signal_sauve : TSignal;
  Aig_supprime,Aig_sauve : TAiguillage;
  BrancheN : array[1..MaxBranches,1..MaxElBranches] of TBranche;
  chaine_recue : TchaineBIN;
  {$IFDEF AvecIdTCP}  //-----------composant Indy
  ThreadInterface : TReadingThreadInterface;
  ThreadPeriph1 : TReadingThreadPeriph1;
  ThreadPeriph2 : TReadingThreadPeriph2;
  ClientSocketIdInterface: tIdTCPClient;
  {$ENDIF}
  ClientSocketInterface: TClientSocket;
  ClientInfo : TclientSocket;

{$R *.dfm}

// utilisation des proc�dures et fonctions dans les autres unit�s
function Index_Signal(adresse : integer) : integer;
function Index_Aig(adresse : integer) : integer;
procedure dessine_signal2(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
procedure dessine_signal3(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
procedure dessine_signal4(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
procedure dessine_signal5(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
procedure dessine_signal7(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
procedure dessine_signal9(Acanvas : Tcanvas;x,y : integer;frX,frY : single;etatsignal : word;orientation,index : integer);
procedure dessine_signal20(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,adresse : integer);
procedure dessine_dirN(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,N : integer);
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
procedure Dessine_signal_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : single;adresse : integer;orientation : integer);
procedure Pilote_acc0_X(adresse : integer;octet : byte);
Function pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire) : boolean; overload;
Function pilote_acc(adresse : integer;octet : byte;adrTrain : integer) : boolean; overload;
function suivant_alg3(prec : integer;typeELprec : TEquipement;actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
function test_memoire_zones(adresse : integer) : boolean;
function PresTrainPrec(Adresse,NbCtSig : integer;detect : boolean;var AdrTr,voie : integer) : boolean;
function cond_carre(adresse : integer) : boolean;
function carre_signal(adresse,TrainReserve : integer;var reserveTrainTiers : boolean;Var AdrTrain : integer) : integer;
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
procedure Event_act(adr,adr2,etat : integer;trainDecl : string);
function verif_UniSemaf(adresse,UniSem : integer) : integer;
function verif_LEB(adresse,UniSem : integer) : integer;
function Select_dessin_Signal(TypeSignal : integer) : TBitmap;
procedure cree_image_signal(rang : integer);
procedure cree_image_Train(rang : integer);
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
function index_train_nom(nom : string) : integer;
procedure vitesse_loco(nom_train :string;index : integer;adr_loco : integer;vitesse : integer;repetition,proc : integer);
procedure Maj_Signaux(detect : boolean);
procedure Det_Adj(adresse : integer);
function reserve_canton(detecteur1,detecteur2,adrtrain,NumTrain,NCantons : integer) : integer;
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
// proc�dures signaux
function etat_signal_suivant(Adresse,rang : integer;var AdrSignalsuivant : integer) : integer;
function InfoSignal(adresse : integer) : string;
procedure det_prec_signal(adresse : integer;var tabloDet : TTabloDet);
function signal_sens(adrSig,det1,det2 : integer) : boolean;
procedure index_signal_det(adr : integer;var voie1,index1,voie2,index2 : integer);
function Signal_precedent(adresse : integer) : integer;
function signal_rouge(adresse : word) : boolean;
function chaine_signal(adresse : word) : string;
function signal_suivant_det(det1,det2 : integer) : integer;

procedure composant(c : tComponent;fond,texte : tColor);
procedure maj_couleurs;
procedure AffTexteIncliBordeTexture(c : TCanvas; x,y : integer; Fonte : tFont;
                                    clBord : TColor; EpBord : integer; PenMode : TPenMode;
                                    texte : string; AngleDD : longint);
procedure change_style;
function isDirectionnel(index : integer) : boolean;
procedure stop_trains;
function Aiguille_deviee(adresse : integer) : integer ;
function envoi_CDM(s : string) : boolean;
function place_id(s : string) : string;
procedure fin_preliminaire;
function Index_operation(s : string) : integer;
function Index_Condition(s : string) : integer;
function Lance_CDM(avecSocket : boolean) : boolean;
procedure action(action : integer);
procedure interface_ou_cdm;
procedure cercle(ACanvas : Tcanvas;x,y,rayon : integer;coulcercle,couleurfond : Tcolor);
procedure Event_vitesse(adr: integer ;train : string;vitesse : integer);
function detecteur_suivant(prec : integer;TypeElPrec : TEquipement;actuel : integer;TypeElActuel : TEquipement;algo : integer) : integer ;
function prepare_route(IndexTCO,cantonOrg,arrivee,sens : integer) : integer;
function route_totale_to_string(tablo : tUneRoute) : string;
function route_restreinte_to_string(tablo : tUneRoute) : string;
procedure supprime_route_train(idtrain : integer);
procedure trouve_element(el: integer; TypeEl : TEquipement;Branche_pref : integer;erreur : boolean); overload;
procedure trouve_element(el: integer; TypeEl : TEquipement); overload;
procedure trouve_element_V1(el: integer; TypeEl : TEquipement; Offset,branche_pref,OffsetDsBranche : integer;erreur : boolean;it : integer);
procedure procetape(s : string);
procedure Affiche_routes_brut;
procedure TJD4(adr1,pos1,adr2,pos2 : integer;var c1,c2 : char);
procedure affecte_trains_config;
procedure Fonction_Loco_Operation(loco,fonction,etat : integer);
procedure calcul_equations_coeff(indexTrain : integer);
procedure connecte_interface_ethernet;
function lire_cv(cv : integer) : integer;
procedure reprise_dcc;
procedure renseigne_comp_trains(i : integer);
function ClavierHookLLProc(Code : integer; WordParam : wparam; LongParam: lparam) : LongInt; stdcall;
procedure cree_GB_compteur(rang : integer);

implementation

uses UnitDebug, UnitPilote, UnitSimule, UnitTCO, UnitConfig,
  verif_version , UnitCDF, UnitAnalyseSegCDM, UnitConfigCellTCO,
  UnitConfigTCO,UnitSR,  UnitHorloge,  UnitFicheHoraire,  UnitClock,
  UnitModifAction, selection_train, UnitRouteTrains, UnitRoute, UnitMesure,
  UnitCompteur;

{$IFDEF AvecIdTCP} //------ composant indy socket r�seau
  // cr�ation thread interface
  constructor TReadingThreadInterface.Create(AClient: TIdTCPClient);
  begin
    inherited Create(True);
    FClient:=AClient;
  end;

  procedure TReadingThreadInterface.Execute;
  begin
    while not Terminated do
    begin
      {$IF CompilerVersion >= 28.0}
      Fclient.IOHandler.ReadBytes(Fdata,0,false);
      if (FData <> nil) and Assigned(FOnData) then
      {$ELSE}
      FData := FClient.CurrentReadBuffer;
      if (FData <> '') and Assigned(FOnData) then
      {$IFEND}
      Synchronize(DataReceived);
    end;
  end;

  procedure TReadingThreadInterface.DataReceived;
  begin
    if Assigned(FOnData) then FOnData(FData);
  end;

  constructor TReadingThreadPeriph1.Create(AClient: TIdTCPClient);
  begin
    inherited Create(True);
    FClient := AClient;
  end;

  // cr�ation thread p�riph�rique1
  procedure TReadingThreadPeriph1.DataReceived;
  begin
    if Assigned(FOnData) then FOnData(FData);
  end;

  procedure TReadingThreadPeriph1.Execute;
  begin
    while not Terminated do
    begin
      {$IF CompilerVersion >= 28.0}
      Fclient.IOHandler.ReadBytes(Fdata,0,false);
      if (FData <> nil) and Assigned(FOnData) then
      {$ELSE}
      FData := FClient.CurrentReadBuffer;
      if (FData <> '') and Assigned(FOnData) then
      {$IFEND}
        Synchronize(DataReceived);
    end;
  end;

  // cr�ation thread p�riph�rique2
  procedure TReadingThreadPeriph2.DataReceived;
  begin
    if Assigned(FOnData) then FOnData(FData);
  end;

  constructor TReadingThreadPeriph2.Create(AClient: TIdTCPClient);
  begin
    inherited Create(True);
    FClient := AClient;
  end;

  procedure TReadingThreadPeriph2.Execute;
  begin
    while not Terminated do
    begin
      {$IF CompilerVersion >= 28.0}
      Fclient.IOHandler.ReadBytes(Fdata,0,false);
      if (FData <> nil) and Assigned(FOnData) then
      {$ELSE}
      FData := FClient.CurrentReadBuffer;
      if (FData <> '') and Assigned(FOnData) then
      {$IFEND}
        Synchronize(DataReceived);
    end;
  end;
{$ENDIF}

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

// lire les fichiers styles vsf - Uniquement D12
procedure lire_styles;
var path,ext : string;
    DirList : TStrings;
    ok  : boolean;
    Sr      : TSearchRec;
    chem,s : string;
    nombre,i,j : integer;
    Style1 : tStyle;
    {$IF CompilerVersion >= 28.0}
    ss : TArray<string>;
    si : tStyleInfo;
    {$IFEND}
    Nbss : integer;
begin
  // liste des fichiers chemin destination
  {$IF CompilerVersion >= 28.0}

  ss:=TStyleManager.StyleNames;  // contient les styles d�ja charg�s en m�moire
  Nbss:=high(ss);

  s:=GetCurrentDir;

  Path:=s+'\Styles\';

  // trouver les fichiers
  DirList:=TStringList.Create;
  nombreStyles:=0;
  if FindFirst(Path+'*.*',faAnyFile,Sr) = 0 then
  begin
    repeat
      s:=sr.Name;
      if (s<>'.') and (s<>'..') and ((sr.Attr and faDirectory)=0) then
      begin
        DirList.Add(SR.Name); //remplir la liste
        i:=pos('.',s);
        s:=copy(s,1,i-1);
        ext:=lowercase(copy(sr.Name,i+1));
        ok:=true;
        if ext='vsf' then
        begin
          try TStylemanager.loadFromFile(path+sr.Name);
          except begin Affiche('Impossible de charger le style '+sr.name,clOrange);ok:=false;end;
          end;
          if ok then // style charg�
          begin
            if debug=1 then Affiche('chargement du style '+sr.name,clYellow);
            inc(nombreStyles);
            style[NombreStyles].NomCheminFichier:=path+sr.name;
            style[NombreStyles].NomFichier:=sr.name;

            if tStyleManager.IsValidStyle(path+sr.name,si)=false then
            begin
              Affiche('Le style '+sr.name+' est invalide. Version='+si.Version,clOrange);
              dec(nombreStyles);
            end
            else
            begin
              style[NombreStyles].NomStyle:=si.Name;
            end;
          end;
        end;
      end;
    until FindNext(Sr)<>0;
    FindClose(Sr);
  end;

  // trier par NomStyle
  Style[0].NomStyle:=tStyleManager.StyleNames[0];

  for i:=1 to nombreStyles-1 do
  begin
    for j:=i+1 to nombreStyles do
    begin
      if Style[i].NomStyle>Style[j].NomStyle then
      begin
        style1:=Style[i];
        Style[i]:=Style[j];
        Style[j]:=style1;
      end;
    end;
  end;
  {$IFEND}

  // renseigner clair/sombre
  for i:=1 to nombreStyles do
  begin
    s:=lowercase(style[i].NomStyle);

    if s='amakrits' then style[i].clarte:=sombre;
    if s='amethyst kamri' then style[i].clarte:=sombre;
    if s='aqua graphite' then style[i].clarte:=sombre;       // tr�s beau
    if s='aqua light slate' then style[i].clarte:=clair;
    if s='aqua light slate 2' then style[i].clarte:=clair;
    if s='auric' then style[i].clarte:=sombre;               // tr�s beau
    if s='calypso' then style[i].clarte:=sombre;
    if s='calypso le' then style[i].clarte:=sombre;
    if s='calypso se' then style[i].clarte:=sombre;
    if s='calypso sle' then style[i].clarte:=sombre;
    if s='carbon' then style[i].clarte:=sombre;
    if s='charcoal dark slate' then style[i].clarte:=sombre;
    if s='cobalt xemedia' then style[i].clarte:=sombre;
    if s='copper' then style[i].clarte:=clair;
    if s='copperdark' then style[i].clarte:=sombre;
    if s='coppervari' then style[i].clarte:=clair;
    if s='coppervaridark' then style[i].clarte:=clair;
    if s='coppervarii' then style[i].clarte:=clair;
    if s='coppervariiblack' then style[i].clarte:=clair;
    if s='coppervariii' then style[i].clarte:=clair;
    if s='coppervariiiblack' then style[i].clarte:=clair;
    if s='coppervariv' then style[i].clarte:=clair;
    if s='coppervarivblack' then style[i].clarte:=clair;
    if s='coppervarv' then style[i].clarte:=clair;
    if s='coppervarvblack' then style[i].clarte:=clair;
    if s='coppervarvi' then style[i].clarte:=clair;
    if s='coppervarviblack' then style[i].clarte:=clair;
    if s='coppervarvii' then style[i].clarte:=clair;
    if s='coppervarviiblack' then style[i].clarte:=clair;
    if s='coral' then style[i].clarte:=clair;
    if s='cyan dusk' then style[i].clarte:=clair;
    if s='cyan night' then style[i].clarte:=clair;
    if s='diamond' then style[i].clarte:=clair;
    if s='emerald' then style[i].clarte:=clair;             // moche
    if s='emerald Light Slate' then style[i].clarte:=clair;
    if s='flat ui light' then style[i].clarte:=clair;
    if s='gnome hybrid' then style[i].clarte:=clair;
    if s='glossy' then style[i].clarte:=sombre;
    if s='glossy2' then style[i].clarte:=sombre;
    if s='glow' then style[i].clarte:=sombre;
    if s='golden graphite' then style[i].clarte:=sombre;
    if s='iceberg classico' then style[i].clarte:=clair;     //beau
    if s='jet' then style[i].clarte:=sombre;
    if s='golden graphite' then style[i].clarte:=sombre;  // beau avec boutons or
    if s='glossy' then style[i].clarte:=sombre;
    if s='glossy2' then style[i].clarte:=sombre;
    if s='glow' then style[i].clarte:=sombre;
    if s='golden graphite' then style[i].clarte:=sombre;
    if s='iceberg classico' then style[i].clarte:=clair;
    if s='jet' then style[i].clarte:=sombre;
    if s='lavender classico' then style[i].clarte:=clair;
    if s='light' then style[i].clarte:=clair;
    if s='light green' then style[i].clarte:=clair;
    if s='light' then style[i].clarte:=clair;
    if s='lilac' then style[i].clarte:=clair;
    if s='luna' then style[i].clarte:=clair;
    if s='lucky point' then style[i].clarte:=sombre;
    if s='material' then style[i].clarte:=sombre;
    if s='material oxford blue' then style[i].clarte:=sombre;
    if s='material oxford blue se' then style[i].clarte:=sombre;
    if s='material patterns blue' then style[i].clarte:=clair;
    if s='material white texture' then style[i].clarte:=clair;
    if s='metro black' then style[i].clarte:=sombre;
    if s='metropolis ui dark' then style[i].clarte:=sombre;
    if s='mountain mist' then style[i].clarte:=clair;
    if s='obsidian' then style[i].clarte:=sombre;
    if s='onyx blue' then style[i].clarte:=sombre;                   // beau
    if s='puerto rico' then style[i].clarte:=clair;
    if s='radiant' then style[i].clarte:=clair;
    if s='ruby graphite' then style[i].clarte:=sombre;               // beau, boutons rouge
    if s='sapphire kamri' then style[i].clarte:=clair;               // beau , fond orange
    if s='sky' then style[i].clarte:=clair;
    if s='sky2' then style[i].clarte:=clair;
    if s='smokey quartz kamri' then style[i].clarte:=clair;
    if s='stellar' then style[i].clarte:=clair;
    if s='stellar dark' then style[i].clarte:=clair;
    if s='sterling' then style[i].clarte:=clair;
    if s='state classico' then style[i].clarte:=clair;
    if s='tablet dark' then style[i].clarte:=sombre;
    if s='tablet light' then style[i].clarte:=clair;
    if s='turquoise gray' then style[i].clarte:=clair;
    if s='vapor' then style[i].clarte:=sombre;
    if s='wedgewood light' then style[i].clarte:=clair;
    if s='win10ide_dark' then style[i].clarte:=sombre;   //beau  fond bleu clair
    if s='win10ide_light' then style[i].clarte:=clair;   //beau  fond bleu clair
    if s='windows' then style[i].clarte:=clair;
    if s='windows designer' then style[i].clarte:=clair;
    if s='windows designer dark' then style[i].clarte:=clair;
    if s='windows10' then style[i].clarte:=clair;
    if s='windows10 black pearl' then style[i].clarte:=sombre;
    if s='windows10 blue' then style[i].clarte:=sombre;       // moche
    if s='windows10 blue whale' then style[i].clarte:=sombre;
    if s='windows10 blue whale le' then style[i].clarte:=sombre;
    if s='windows10 charcoal' then style[i].clarte:=sombre;
    if s='windows10 clear day' then style[i].clarte:=clair;
    if s='windows10 dark' then style[i].clarte:=sombre;
    if s='windows10 green' then style[i].clarte:=sombre;
    if s='windows10 malibu' then style[i].clarte:=clair;
    if s='windows10 purple' then style[i].clarte:=sombre;
    if s='windows10 stategray' then style[i].clarte:=sombre;   //beau
    if s='windows11 impressive dark se' then style[i].clarte:=sombre;   //beau
    if s='windows11 impressive dark se' then style[i].clarte:=sombre;   //beau
    if s='windows11 impressive light' then style[i].clarte:=clair;   //beau
    if s='windows11 impressive light se' then style[i].clarte:=clair;   //beau
    if s='windows11 mineShaft' then style[i].clarte:=sombre;   //beau
    if s='windows11 modern dark' then style[i].clarte:=sombre;
    if s='windows11 modern light' then style[i].clarte:=clair;
    if s='windows11 polar dark' then style[i].clarte:=sombre;
    if s='windows11 polar light' then style[i].clarte:=clair;           // beau
    if s='windows11 white smoke' then style[i].clarte:=clair;
    if s='zircon' then style[i].clarte:=clair;
    if s='zircon se' then style[i].clarte:=clair;
  end;
end;

// change le style en fonction de Style_aff pour Delphi12 (compilateur>=28)
// Cette proc�dure doit �tre appell�e depuis le module principal UnitPrinc sinon exception violation
// Pour les RichEdit, il faut les r�afficher apr�s chaque changement de style, sinon elles peuvent �tre mal contrast�es.
// ceci doit �tre fait dans l'evt OnActivate de chaque feuille.
procedure change_style;
var i,j,index : integer;
    Re : tRichEdit;
    s : string;
    comp : Tcomponent;
    {$IF CompilerVersion >= 28.0}
    si : tStyleInfo;
    {$IFEND}
begin
  {$IF CompilerVersion >= 28.0}
  if Ancien_Nom_Style<>Nom_style_aff then
  begin
    TStyleManager.TrySetStyle(TStyleManager.StyleNames[0]);   // repasse en windows (style 0) pour �viter exception apr�s changement du nouveau style
    if Nom_Style_Aff='Windows' then exit;
    index:=trouve_index_style;
    if index<0 then
    begin
      Affiche('Style '+Nom_Style_aff+' non trouv�',clred);
      exit;
    end;
    s:=style[index].NomCheminFichier;

    // v�rifie si le fichier de style existe
    if FileExists(s)=false then
    begin
      Affiche('Le fichier de style '+Nom_Style_aff+' est inexistant',clOrange);
      Affiche(s,clOrange);
      Exit;
    end;

    // v�rification de la validit� du style, et r�cup�ration de la structure si qui contient le vrai nom
    // du style qu'il faudra utiliser dans la fonction d'ouverture du style
    try
      if tStyleManager.IsValidStyle(s,si)=false then
      begin
        Affiche('Le style '+Nom_Style_Aff+' est invalide. Version='+si.Version,clOrange);
        exit;
      end;
    except
      begin
        Affiche('Le style '+Nom_Style_Aff+' est inexistant',clOrange);
        exit;
      end;
    end;

    // reprendre le vrai nom du style depuis SI.name car le nom du fichier peur �tre diff�rent du nom du style
    // exemple le style "Metropolis UI Dark" (avec espaces) a pour nom de fichier "MetropolisUIDark.vsf"
    Nom_style_aff:=si.Name;

    try
      TStyleManager.ReloadStyle(Nom_Style_aff);   // charge le style - librairie Vcl.Styles.Ext
    except
      Affiche('Erreur d''application du style '+Nom_style_aff+' version='+si.version,clOrange);
      exit;
    end;

    // repasser certains composants dans le styleName windows permet que le composant affiche en couleurs voulues
    // car changer de style sur un composant dont le styleName n'est plus windows interdit de changer sa couleur
    Formprinc.FenRich.StyleName:='Windows';
    // et dans formdebug.Create aussi

    // �num�rer tous les composants pour repaint les richedit - ne marche pas
    {
    for i:=0 to Screen.FormCount-1 do
    begin
      //Affiche(Screen.Forms[i].Name,clYellow);
      for j:=0 to Screen.Forms[i].ComponentCount-1 do
      begin
        comp:=Screen.Forms[i].Components[j];
        if comp is tRichEdit then
        begin
          re:=comp as tRichEdit;
          re.repaint;
          //Affiche(comp.name,clWhite);
        end;
      end;
    end;
    }

    Ancien_nom_style:=nom_Style_aff;
  end;
  {$IFEND}
end;

// consigne du train courant cliqu�
// origine=1 vient du clic bouton "envoi vitesse � loco"
//        =2 vient de bloc USB
procedure consigne_train(origine : integer);
var s : string;
    vit,erreur,vientde : integer;
begin
  vientde:=0;
  with formprinc do
  begin
    if (idTrainClic<1) or (idTrainClic>nTrains) then exit;
    // Affiche('origine='+intToSTR(origine),clYellow);
    {if origine=1 then
    begin
     // s:=editVitesse.Text;
     // val(s,vit,erreur);
      //Affiche('vitconsigne1='+intToSTR(vit),clOrange);
      if (erreur<>0) or (vit<-128) or (vit>127) then exit;
      vitesse_loco(trains[IdTrainClic].nom_train,
                          idTrainClic,
                          trains[idTrainClic].adresse,
                          trains[idTrainClic].vitesseCons,  // vit 
                          10,vientde);
    end; }
    //if origine=2 then
    begin
      vit:=trains[idTrainUSB].VitesseBlocUSB;
      VientDe:=consigneBLocUSB; // ne g�n�re pas event_vitesse
      vitesse_loco(trains[IdTrainUSB].nom_train,idTrainUSB,trains[idTrainUSB].adresse,vit,10,vientde);
      //Affiche('vitconsigne2='+intToSTR(vit),cllime);
    end;
  end;
  //Affiche('consigne_train='+trains[IdTrainClic].nom_train+' '+intToSTR(vit),cllime);
end;


procedure positionne_principal;
begin
  // positionnement de la fen�tre principale
  //Affiche('positionne_principal',clyellow);
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
      height:=formprinc.height-StatusBar1.Height-labeltitre.Height-labelTitre.top-70; //64;
      Anchors:=[akLeft,akTop,akRight,akBottom];
    end;


    with Fenrich do
    begin
      begin
        left:=5;
        Align:=AlLeft;   // si on ne met pas Align � AlLeft, alors le splitter n'est pas accrochable
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
        align:=fenrich.align;   // dessine le splitter � droite de la fenetre Fenrich
        Visible:=true;
      end;

      with PageControl do
      begin
        Parent:=GrandPanel;
        Anchors:=[akTop,akleft,akRight,akBottom];
        left:=SplitterV.left+20;
        width:=GrandPanel.Width-SplitterV.left-5;
        height:=GrandPanel.Height-GroupBoxTrains.height-GroupBoxTrains.top-4;
        top:=GroupBoxTrains.Top+GroupBoxTrains.Height+5;
      end;

      with ScrollBoxSig do
      begin
        Left:=0;top:=0;
        width:=TabSheetSig.Width;
        Height:=TabSheetSig.Height;
      end;
      with ScrollBoxTrains do
      begin
        Left:=0;top:=0;
        width:=TabSheetTrains.Width;
        Height:=TabSheetTrains.Height;
      end;
      With ScrollBoxC do
      begin
        Left:=1;top:=0;
        width:=TabSheetComp.Width-TrackBarZC.Width;
        Height:=TabSheetComp.Height;
      end;
      positionne_elements(splitterV.left);
    end;

    if (PosSplitter>0) and (PosSPlitter<formPrinc.Width) and (AffMemoFenetre=1) then
    begin
      fenRich.Width:=PosSplitter;
      positionne_elements(PosSplitter);
    end;

    //affichage de la fen�tre principale
//    show;
  end;
end;

function GetMACAdress: tstrings;
var
  NCB: PNCB;
  Adapter: PAdapterStatus;
  RetCode: Ansichar;
  s : tstrings;
  I: integer;
  Lenum: PlanaEnum;
  _SystemID: string;
begin
  Result:=nil;
  _SystemID:='';
  Getmem(NCB,SizeOf(TNCB));
  Fillchar(NCB^,SizeOf(TNCB),0);

  Getmem(Lenum,SizeOf(TLanaEnum));
  Fillchar(Lenum^,SizeOf(TLanaEnum),0);

  Getmem(Adapter,SizeOf(TAdapterStatus));
  Fillchar(Adapter^,SizeOf(TAdapterStatus),0);

  Lenum.Length:=chr(0);
  NCB.ncb_command:=chr(NCBENUM);
  NCB.ncb_buffer:=Pointer(Lenum);
  NCB.ncb_length:=SizeOf(Lenum);
  RetCode:=Netbios(NCB);

  s:=TstringList.Create;
  i:=0;
  repeat
    Fillchar(NCB^,SizeOf(TNCB), 0);
    Ncb.ncb_command:=chr(NCBRESET);
    Ncb.ncb_lana_num:=lenum.lana[I];
    RetCode:=Netbios(Ncb);

    Fillchar(NCB^,SizeOf(TNCB), 0);
    Ncb.ncb_command:=chr(NCBASTAT);
    Ncb.ncb_lana_num:=lenum.lana[I];
    // doit �tre 16
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
      s.add(_SystemID);
      //Affiche(_systemID,clYellow);
    end;
    Inc(i);
  until (i>=Ord(Lenum.Length)) ;//or (_SystemID<>'00-00-00-00-00-00');
  FreeMem(NCB);
  FreeMem(Adapter);
  FreeMem(Lenum);
  result:=s;
end;

// ex2
function GetAdapterInfo(Lana: AnsiChar): String;
var
  Adapter: TAdapterStatus;
  Ncb: Tncb;
begin
  FillChar(Ncb,SizeOf(Ncb),0);
  Ncb.ncb_command:=Char(NCBRESET);
  Ncb.ncb_lana_num:=Lana;
  if Netbios(@Ncb)<>Char(NRC_GOODRET) then
  begin
    Result:='mac non trouv�e';
    Exit;
  end;

  FillChar(NCB,SizeOf(Ncb), 0);
  NCB.ncb_command:=Char(NCBASTAT);
  NCB.ncb_lana_num:=Lana;
  NCB.ncb_callname:='*';

  FillChar(Adapter,SizeOf(Adapter), 0);
  NCB.ncb_buffer:=@Adapter;
  NCB.ncb_length:=SizeOf(Adapter);
  if Netbios(@Ncb)<>Char(NRC_GOODRET) then
  begin
    Result:='mac non trouv�e';
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
  Ncb: Tncb;
begin
  FillChar(Ncb,SizeOf(NCB),0);
  NCB.ncb_command:=Char(NCBENUM);
  NCB.ncb_buffer:=@AdapterList;
  NCB.ncb_length:=SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length)>0 then
    Result:=GetAdapterInfo(AdapterList.lana[0])
  else
    Result:='mac non trouv�e';
end;

// renvoyer date heure, MAC, version SC , verif_version
// ex 1 ... renvoie celui de la virtual box
// mode=1 envoie en affichage
// mode=2 envoie au r�seau
procedure envoie_infos(mode : integer);
var ts : tstrings;
    s,cmd : string;
    retour,i,erreur,n : integer;
    f : textFile;
begin
  s:=GetCurrentProcessEnvVar('SystemDrive'); // s='c:'

  cmd:='/c vol '+s+' >vol.txt';  // /c ferme la fenetre en fin d'exec   /k ne ferme pas
  // si on fait un runas au lieu de open, �� ouvre une fenetre de demande admin sur les postes non admin
  // ou dont le niveau d'utilisateur est bas dans le profil
  retour:=ShellExecute(formprinc.Handle,pchar('open'),pchar('cmd.exe'),PChar(cmd),nil,SW_HIDE);
  s:='';
  if retour<=32 then
  begin
    ShowMessage(SysErrorMessage(GetLastError));
  end
  else
  begin
    assignfile(f,'vol.txt');
    {$I-}
    reset(f);
    erreur:=IoResult;
    {$I+}
    if erreur=0 then
    begin
      readln(f,s);
      readln(f,s);
      closefile(f);
      i:=pos('-',s);
      if i>4 then
      begin
        i:=i-4;
        s:=copy(s,i,9)+'  ';  // Id de formatage de c:\
      end;
    end
    else
      s:='Fichier vol non ouvert:'+intToSTR(erreur)+'  ';
  end;

  ts:=GetMACAdress;
  for i:=0 to ts.Count-1 do
  begin
    s:=s+ts[i]+'  ';
  end;
  if mode=1 then Affiche(s,clyellow);
  if mode=2 then ClientInfo.Socket.SendText(s);

  s:=DateToStr(date)+' '+TimeToStr(Time)+' V'+versionSC;
  {$IF CompilerVersion >= 28.0}
  s:=s+' D12';
  {$IFEND}
  {$IFDEF WIN64}       // si compil� en 64 bits
  s:=s+' x64';
  {$ENDIF}
  if mode=1 then Affiche(s,clyellow);
  if mode=2 then ClientInfo.Socket.SendText(s+#13+#10);

  //Affiche(GetCurrentDir,clyellow);

  s:='NbreTCO='+intToSTR(nbreTCO);
  s:=s+' Nbrecantons='+intToSTR(ncantons);
  s:=s+' NbreTrains='+intToSTR(ntrains);
  s:=s+' NbreHoraires='+intToSTR(Nombre_horaires);
  s:=s+' NbreAig='+intToSTR(maxaiguillage);
  s:=s+' NbreSignaux='+intToSTR(NbreSignaux);
  s:=s+' NbreActions='+intToSTR(maxTablo_act);
  s:=s+' NbrePN='+intToSTR(NbrePN);
  s:=s+' Nbrefonctions='+intToSTR(NbreFL);
  s:=s+' NbrePeriph='+intToSTR(NbPeriph);

  if mode=1 then Affiche(s,clyellow);
  if mode=2 then ClientInfo.Socket.SendText(s);

  for i:=1 to ntrains do
  begin
    n:=trains[i].routePref[0,0].adresse;
    if n<>0 then
    begin
      s:=' train '+intToSTR(i)+' : '+intToSTR(n)+' routes';
      if mode=1 then Affiche(s,clyellow);
      if mode=2 then ClientInfo.Socket.SendText(s);
    end;
  end;
end;

procedure menu_selec;
begin
  // autoriser le menu
  with formprinc do
  begin
    Afficher1.Enabled:=true;
    Interface1.Enabled:=true;
    Horaires1.Enabled:=true;
    Divers1.Enabled:=true;
    TCOs1.Enabled:=true;
    Roulage1.Enabled:=true;
  end;
end;

procedure fin_preliminaire;
var i : integer;
    s : string;
begin
  s:='D�but du pr�liminaire';
  procetape(s);

  // en D12, oblig� de positionner la fen�tre principale apr�s avoir fix� le style
  positionne_principal;

  calcul_pos_horloge_compt;
  if AffHorl then Affiche_horloge;
  if LanceHorl then Demarre_horloge;
  // cr�ation des compteurs
  if (compteur<0) or (compteur>3) then compteur:=1;
  for i:=1 to 1 do
  begin
    formCompteur[i]:=TformCompteur.Create(nil);
    with formCompteur[i] do
    begin
      Name:='FormCompteur'+intToSTR(i);
      Caption:='Compteur ';
      formStyle:=fsStayonTop;
      afficherIconeDuTrain1.Checked:=afftrainCompteur;
      Verrouillerdevant1.Checked:=VerrouilleCompteur;
      Dverrouiller1.Checked:=not(VerrouilleCompteur);
      Compteurdevitesse11.Checked:=compteur=1;
      Compteurdevitesse21.Checked:=compteur=2;
      Compteurtachro1.Checked:=compteur=3;
      Vitesseencrans1.Checked:=true;
      Vitesserelle1.checked:=false;
    end;

    Init_compteur(i,formcompteur[1]);

    formCompteur[i].left:=formprinc.left+formPrinc.width-formCompteur[i].width;
    if AffCompteur then formCompteur[i].Show;
  end;

  formConfig.listBoxPeriph.clear;
  formModifAction.ComboBoxAccComUSB.Clear;
  formconfig.ComboBoxPNCom.Clear;
  for i:=1 to NbPeriph do
  begin
    formconfig.listBoxPeriph.items.Add(encode_Periph(i));
    ajoute_champs_combos(i);
  end;

  s:='Pr�liminaire 2';
  procetape(s);

  if avecTCO then
  for i:=1 to NbreTco do
  begin
    FormTCO[i].Visible:=false;
    Affiche_Fenetre_TCO(i,avecTCO);
  end;

  s:='Pr�liminaire 3';
  procetape(s);

  renseigne_tous_cantons;  // les cantons doivent �tre renseign�s pour les evts d�tecteurs
  renseigne_TJDs_TCO;

  interface_ou_cdm; // d�marrer l'interface , g�n�re les evts d�tecteurs  ; ou cdm

  // cr�er les compteurs apr�s avoir t�l�charg� la liste des trains de CDM
  s:='Cr�ation des compteurs GB';
  procetape(s);

  for i:=1 to ntrains do
  begin
    cree_GB_compteur(i);

    trains[i].canton:=0;
    trains[i].x:=-999999;
    trains[i].y:=-999999;
    trains[i].BlocUSB:=0;
    calcul_equations_coeff(i);
  end;

  s:='Fin du pr�liminaire';
  procetape(s);

  formprinc.SetFocus;
  menu_selec;

  Maj_Signaux(false);
end;

// renvoie une chaine ASCI Hexa affichable � partir d'une cha�ne
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

// Affiche une cha�ne en Hexa Ascii
procedure affiche_chaine_hex(s : string;couleur : Tcolor);
begin
  if traceTrames then AfficheDebug(chaine_HEX(s),couleur);
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

// proc�dures liaisons s�rie com usb ------------------------------------------------
// envoie une chaine s � un p�riph�rique COM/USB en fonction du composant comp
// contr�le si le pointeur comp est valide par traitement de l'exception
{$IF CompilerVersion >= 28.0}
procedure envoi_usb_comp(comp : tApdComPort;s : variant);
var i : integer;
begin
  if comp=nil then
  begin
    Affiche('Erreur 600X: le composant p�riph�rique n''est pas cr��',clred);
    exit;
  end;
  try
    comp.output:=s;
  except
    on e : exception do
    begin
      Affiche(e.message+' COM'+intToSTR(comp.ComNumber)+': d�connect�. Fermeture du port ',clred);
      // passe � faux les indicateurs d'ouverture du port
      if comp=MSCommUSBInterface then portCommOuvert:=false;
      for i:=1 to NbMaxi_Periph do
      begin
        if (tablo_periph[i].numComposant=1) and (comp=MSCommCde1) then tablo_periph[i].portouvert:=false;
        if (tablo_periph[i].numComposant=2) and (comp=MSCommCde2) then tablo_periph[i].portouvert:=false;
      end;
      // ferme le port
      comp.Open:=false;
      Formprinc.StatusBar1.Panels[3].Text:='';
    end;
  end;
end;

{$ELSE}
// envoie une chaine s � un p�riph�rique COM/USB en fonction du composant comp :tmscomm
// contr�le si le pointeur comp est valide par traitement de l'exception
procedure envoi_usb_comp(comp : Tmscomm;s : variant);
var i : integer;
begin
  if comp=nil then
  begin
    Affiche('Erreur 600X: le composant p�riph�rique tmscom n''est pas cr��',clred);
    exit;
  end;

  try
    comp.output:=s;
  except
    on e : exception do
    begin
      Affiche(e.message+' COM'+intToSTR(comp.CommPort)+': d�connect�. Fermeture du port ',clred);
      // passe � faux les indicateurs d'ouverture du port
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
{$IFEND}

{$IF CompilerVersion >= 28.0}
// envoi la cha�ne trameIF � la centrale par USBLenz ou socket, n'attend pas l'ack
// pour le protole XpressNet (1), on ajoute l'entete et le suffixe dans la trame.
// ici on envoie pas � CDM
// la fonction PutBlock n�cessite un tableau z[] commen�ant � 1 et pas � 0
// avec asyncpro
procedure envoi_ss_ack(s : string);
var i,timeout,valto,l : integer;
    z : array[1..100] of byte;
begin
  if simuInterface then exit;

  if protocole=1 then s:=entete+s; // ajout de l'entete en Xpressnet, pas en Dccpp
  l:=length(s);
  for i:=1 to l do z[i]:=byte(ord(s[i]));        // transforme la chaine en tableau d'octets

  if traceTrames then
  begin
    if protocole=1 then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClLime);    //XpreeeNet
    if protocole=2 then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+s,ClLime);                //DCC++
  end;

  // par port com-usb
  if portCommOuvert then
  begin
    if (prot_serie=4) then // le protocole 4 contr�le simplement la ligne CTS avant de transmettre et temporise octet par octet
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
        until (MSCommUSBInterface.CTS=false) or (timeout>valto);

        if timeout<=valto then
        begin
          envoi_usb_comp(MSCommUSBInterface,Ansichar(z[i]));
          //Affiche(intToSTR(TrameIF[i]),clyellow);
          inc(i);
        end;
      until (i=l+1) or (timeout>valto);
      Sleep(30);
      if timeout>valto then affiche('Erreur attente interface trop longue',clred);
    end;

    // protocole Rts Cts
    if (prot_serie=2) then
    begin
      MSCommUSBInterface.PutBlock(z,l);
      if not modetache then Sleep(30);    // �vite "station occup�e"
      //Sleep(TempoOctet);
    end;

    // procotole xon xoff ou temporis�
    if (prot_serie=1) then
    begin
      for i:=1 to l do
      begin
        envoi_usb_comp(MSCommUSBInterface,AnsiChar(z[i]));
        //Affiche(s[i],clyellow);// else Affiche(chaine_hex(s[i]),clyellow);
        Sleep(TempoOctet);
      end;
      if not modetache then Sleep(30);
    end;

    // sans protocole sans temporisation
    if (prot_serie=0) and (TempoOctet=0) then
    begin
      MSCommUSBInterface.PutBlock(z,l);
      if not modetache then Sleep(30);    // �vite "station occup�e"
    end;

    // sans procotole avec temporisation
    if (prot_serie=0) and (TempoOctet<>0) then
    begin
      for i:=1 to l do
      begin
        envoi_usb_comp(MSCommUSBInterface,AnsiChar(z[i]));       // conversion correcte pour tous les caract�res binaires
        Sleep(TempoOctet);
      end;
      if not modetache then Sleep(30);
    end;
  end;

  // par socket (ethernet)
  if parSocketLenz or (etat_init_interface>=11) then
  begin
    {$IFDEF AvecIdTCP}
    ClientSocketIdInterface.IoHandler.write(RawToBytes(z,l));   // RawToBytes() convertit n'importe quoi en TidBytes
    {$ELSE}
    ClientSocketInterface.Socket.SendBuf(z,l);
    {$ENDIF}
    if not modetache then sleep(30);
  end;
end;

{$ELSE}
// envoi la cha�ne trameIF � la centrale par USBLenz ou socket, n'attend pas l'ack
// pour le protole XpressNet (1), on ajoute l'entete et le suffixe dans la trame.
// ici on envoie pas � CDM
// utilisation de TMSCOMM
procedure envoi_ss_ack(s : string);
var i,timeout,valto,l : integer;
begin
  if simuInterface then exit;

  if protocole=1 then s:=entete+s; // ajout de l'entete en Xpressnet, pas en Dccpp
  l:=length(s);
  Setlength(TrameIF,l);
  for i:=0 to l-1 do TrameIF[i]:=byte(ord(s[i+1]));      // transforme la chaine en tableau dynamique d'octets

  if traceTrames then
  begin
    if protocole=1 then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClLime);    //XpreeeNet
    if protocole=2 then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+s,ClLime);                //DCC++
  end;

  // par port com-usb
  if portCommOuvert then
  begin
    if (prot_serie=4) then // le protocole 4 contr�le simplement la ligne CTS avant de transmettre et temporise octet par octet
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
        until (MSCommUSBInterface.CTSHolding=false) or (timeout>valto);

        if timeout<=valto then
        begin
          envoi_usb_comp(MSCommUSBInterface,s[i]);
          //Affiche(intToSTR(TrameIF[i]),clyellow);
          inc(i);
        end;
      until (i>l) or (timeout>valto);
      Sleep(30);
      if timeout>valto then affiche('Erreur attente interface trop longue',clred);
    end;

    // protocole Rts Cts ou avec temporisation entre trames
    if (prot_serie=2) then
    begin
      envoi_usb_comp(MSCommUSBInterface,s);
      Sleep(30);
    end;

    // procotole xon xoff ou temporis�
    if (prot_serie=1) then
    begin
      for i:=1 to l do
      begin
        envoi_usb_comp(MSCommUSBInterface,s[i]);
        //Affiche(s[i],clyellow);// else Affiche(chaine_hex(s[i]),clyellow);
        Sleep(TempoOctet);
      end;
      if not modetache then Sleep(30);
    end;

    // sans protocole sans temporisation
    if (prot_serie=0) and (TempoOctet=0) then
    begin
      envoi_usb_comp(MSCommUSBInterface,TrameIF);
      if not modetache then Sleep(30);    // �vite "station occup�e"
    end;

    // sans procotole avec temporisation
    if (prot_serie=0) and (TempoOctet<>0) then
    begin
      for i:=1 to l do
      begin
        MSCommUSBInterface.Output:=s[i];
        //Affiche(s[i],clyellow);// else Affiche(chaine_hex(s[i]),clyellow);
        Sleep(TempoOctet);
      end;
      if not modetache then Sleep(30);
    end;
  end;

  // par socket (ethernet)
  if parSocketLenz or (etat_init_interface>=11) then
  begin
    {$IFDEF AvecIdTCP}
    ClientSocketIdInterface.Socket.Send(TrameIF[0],l);
    {$ELSE}
    ClientSocketInterface.Socket.SendBuf(TrameIF[0],l);
    {$ENDIF}
    if not modetache then Sleep(30);
  end;
end;
{$IFEND}

function test_protocole : boolean;
var s: string;
   temp : integer;
begin
  if simuInterface then
  begin
    result:=true;
    exit;
  end;
  begin
    if protocole=1 then   // Xpressnet
    begin
      s:=#$f0;
      s:=checksum(s);
    end;
    if protocole=2 then s:='<s>';    // dcc++

    application.processMessages;
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
      s:=' mais l''interface n''a pas r�pondu ';
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
        if (version_interface<>'') then
        begin
          Affiche_suivi(' et l''interface a r�pondu correctement en '+intToSTR(temp)+'00 ms',clLime);
          result:=true;
          exit;
        end;
      end;
      Affiche_suivi(s+' mais l''interface a r�pondu incorrectement',clyellow);
      result:=false;
    end;
  end;
end;

{$IF CompilerVersion >= 28.0}
// connecte un port usb interface vers centrale avec AsyncPro. Si le port n'est pas ouvert, renvoie 0, sinon renvoie
// le num�ro de port
// affichage dans panel[3]
function connecte_port_usb(port : integer) : integer;
var i,j,nport,vit,Nbits,_StopBits,Parite,erreur : integer;
    trouve : boolean;
    s,sc : string;
begin
  result:=0;
  trouve:=false;
  application.processmessages;
  if MSCommUSBInterface=nil then
  begin
    Affiche('Erreur 6000: le composant interface n''est pas cr��',clred);
    result:=0;
    exit;
  end;

  With MSCommUSBInterface do
  begin
    //if debug=1 then Affiche('Test port com'+intToSTR(port),clLime);
    version_interface:='';
    s:=PortCom;
    i:=pos(':',s);Delete(s,1,i);
    val(s,vit,erreur);i:=pos(',',s);delete(s,1,i);

    case s[1] of
    'n' : parite:=0;
    end;
    parite:=0;
    i:=pos(',',s);delete(s,1,i);

    val(s,nBits,erreur);i:=pos(',',s);delete(s,1,i);
    val(s,_StopBits,erreur);i:=pos(',',s);delete(s,1,i);
    val(s,prot_serie,erreur);

    StopBits:=_StopBits;
    DataBits:=nBits;
    Parity:=pNone;
    Baud:=vit;
    ComNumber:=port;

    case prot_serie of
    0 : HWFlowOptions:=[]; // aucun, envoi la trame compl�te
    1 : HWFlowOptions:=[]; // xon-xoff
    2 : HWFlowOptions:=[hwfUSERTS,hwfRequireCTS]; // rts-cts
    3 : HWFlowOptions:=[]; // non utilis�
    4 : HWFlowOptions:=[]; // controle CTS avant �mission :on utilise sans protocole
    end;

    portCommOuvert:=true;
    try
      open:=true;
    except
      //Affiche('Port COM'+intToSTR(port)+' absent',clOrange);
      portCommOuvert:=false;
    end;
    if protocole=2 then DTR:=false // �vite de reset de l'arduino � la connexion
    else DTR:=True;
    if prot_serie=4 then RTS:=True //pour la genli
    else RTS:=false;
  end;

  if simuInterface then PortCommOuvert:=true;

  if portCommOuvert and not(simuInterface) then
  begin
    FormPrinc.StatusBar1.Panels[3].Style:=psOwnerDraw;  // permet de d�clencher l'event onDrawPanel
    s:='COM'+intToSTR(port)+' ouvert';
    Affiche(s,clLime);
    s:='COM'+intToSTR(port)+':'+sc;

    Formprinc.StatusBar1.Panels[3].Text:=s;
    sleep(1000);
    trouve:=test_protocole;
    if not(trouve) then
    begin
      portCommOuvert:=false;
      MSCommUSBInterface.open:=false;
    end;
  end;
  if trouve then result:=port else result:=0;
end;


{$ELSE}

// connecte un port usb interface vers centrale avec TMSCOMM. Si le port n'est pas ouvert, renvoie 0, sinon renvoie
// le num�ro de port
// affichage dans panel[3]
function connecte_port_usb(port : integer) : integer;
var i,j : integer;
    trouve : boolean;
    s,sc : string;
begin
  result:=0;
  trouve:=false;
  application.processmessages;
  if MSCommUSBInterface=nil then
  begin
    Affiche('Erreur 6000: le composant interface n''est pas cr��',clred);
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

    case prot_serie of
    0 : Handshaking:=0; // aucun, envoi la trame compl�te
    1 : Handshaking:=1; // xon-xoff
    2 : Handshaking:=2; // rts-cts
    3 : Handshaking:=0; // non utilis�
    4 : Handshaking:=0; // controle CTS avant �mission :on utilise sans protocole
    end;

    {HandShaking: 0=aucun 1=Xon-Xoff 2=cts 3=RTS-Xon-Xoff 4=5=protocoles "maison"}
    SThreshold:=1;
    RThreshold:=1;
    InputLen:=0;
    CommPort:=Port;
    if protocole=2 then DTREnable:=false // �vite de reset de l'arduino � la connexion
    else DTREnable:=True;
    if prot_serie=4 then RTSEnable:=True //pour la genli
    else RTSenable:=false;
    InputMode:=comInputModeBinary;
  end;

  portCommOuvert:=true;
  try
     MSCommUSBInterface.portopen:=true;
  except
    portCommOuvert:=false;
    //Affiche('Port COM'+intToSTR(port)+' absent',clOrange);
  end;

  if simuInterface then PortCommOuvert:=true;

  if portCommOuvert and not(simuInterface) then
  begin
    FormPrinc.StatusBar1.Panels[3].Style:=psOwnerDraw;  // permet de d�clencher l'event onDrawPanel
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
{$IFEND}

{$IF CompilerVersion >= 28.0}
// connecte un port usb pour la comm p�riph�riques. Si le port n'est pas ouvert, renvoie false
// version AsyncPro
function connecte_usb_periph(index : integer) : boolean;
var i,j,nc,numport,_vitesse,parite,nbits,stopbits,erreur,prot : integer;
    s,sc,portComCde : string;
    com : tApdComPort;
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 60 : num�ro de p�riph�rique hors limite '+intToSTR(index),clred);
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
    Affiche('Erreur 6001: le composant p�riph�rique 1 n''est pas cr��',clred);
    result:=false;
    exit;
  end;
  if MsCommCde2=nil then
  begin
    Affiche('Erreur 6002: le composant p�riph�rique 2 n''est pas cr��',clred);
    result:=false;
    exit;
  end;

  case nc of
  1 : com:=MSCommCde1;
  2 : com:=MSCommCde2;
  end;

  if nc>MaxComUSBPeriph then
  begin
    affiche('Le nombre maxi de portCom p�riph�riques est atteint. Le port COM'+inttostr(Tablo_periph[index].NumCom)+' ne sera pas ouvert',clred);
    result:=false;
    exit;
  end;

  if debug=1 then Affiche('Test port com cde'+intToSTR(port),clLime);
  i:=pos(':',portComcde);delete(portComcde,1,i);
  val(PortComCde,_vitesse,erreur);i:=pos(',',PortComcde); delete(s,1,i);
  val(PortComCde,parite,erreur); i:=pos(',',PortComcde); delete(s,1,i);
  val(PortComCde,nBits,erreur); i:=posEx(',',PortComcde,j+1); delete(s,1,i);
  val(PortComCde,StopBits,erreur);i:=posEx(',',PortComcde,j+1); delete(s,1,i);
  val(PortComCde,prot,erreur);

  if (_vitesse<>300) and (_vitesse<>1200) and (_vitesse<>2400) and (_vitesse<>4800) and (_vitesse<>9600) and
     (_vitesse<>19200) and (_vitesse<>38400) and (_vitesse<>57600) and (_vitesse<>115200) and (_vitesse<>128000) and (_vitesse<>256000) then
  begin
    Affiche('Vitesse p�riph�rique COM'+intToSTR(port)+' ('+intToSTR(_vitesse)+') incorrecte',clred);
    tablo_periph[index].PortOuvert:=false;
    result:=false;
    exit;
  end;

  tablo_periph[index].PortOuvert:=true;
  With com do
  begin
    Baud:=_vitesse;

    HWFlowOptions:=[]; {0=aucun 1=Xon-Xoff 2=cts 3=RTS-Xon-Xoff 4=5=protocoles "maison"}
    ComNumber:=numport;
    DTR:=Tablo_periph[index].dtr;
    RTS:=Tablo_periph[index].rts;
  end;
  try
    com.open:=true;
  except
    tablo_periph[index].PortOuvert:=false;
  end;

  FormPrinc.StatusBar1.Panels[3].Style:=psOwnerDraw;  // permet de d�clencher l'event onDrawPanel

  if tablo_periph[index].PortOuvert then
  begin
    s:='COM'+intToSTR(numport)+':'+sc;
    Formprinc.StatusBar1.Panels[3].Text:=s;
  end;
  result:=tablo_periph[index].PortOuvert;
end;

{$ELSE}

// connecte un port usb pour la comm des p�riph�riques. Si le port n'est pas ouvert, renvoie false
// version TMSCom
function connecte_usb_periph(index : integer) : boolean;
var i,j,nc,numport,vitesse,erreur : integer;
    s,sc,portComCde : string;
    com : TMSComm;
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 60 : num�ro de p�riph�rique hors limite '+intToSTR(index),clred);
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
    Affiche('Erreur 6001: le composant p�riph�rique 1 n''est pas cr��',clred);
    result:=false;
    exit;
  end;
  if MsCommCde2=nil then
  begin
    Affiche('Erreur 6002: le composant p�riph�rique 2 n''est pas cr��',clred);
    result:=false;
    exit;
  end;

  case nc of
  1 : com:=MSCommCde1;
  2 : com:=MSCommCde2;
  end;

  if nc>MaxComUSBPeriph then
  begin
    affiche('Le nombre maxi de portCom p�riph�riques est atteint. Le port COM'+inttostr(Tablo_periph[index].NumCom)+' ne sera pas ouvert',clred);
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
    Affiche('Vitesse p�riph�rique COM'+intToSTR(port)+' ('+intToSTR(vitesse)+') incorrecte',clred);
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

  FormPrinc.StatusBar1.Panels[3].Style:=psOwnerDraw;  // permet de d�clencher l'event onDrawPanel

  if tablo_periph[index].PortOuvert then
  begin
    s:='COM'+intToSTR(numport)+':'+sc;
    Formprinc.StatusBar1.Panels[3].Text:=s;
  end;
  result:=tablo_periph[index].PortOuvert;
end;
{$IFEND}

procedure procetape(s : string);
begin
  if debug=1 then
  begin
    Affiche(s,clLime);
    exit;
  end;
  if debug<>2 then exit;
  MessageDlg('Etape '+intToSTR(etape)+#13+s,mtInformation,[mbOk],0);
  inc(etape);
end;

// renvoie vrai si le signal d'index index est directionnel
function isDirectionnel(index : integer) : boolean;
var a : integer;
begin
  a:=Signaux[index].aspect;
  isDirectionnel:=(a>=12) and (a<=16);
end;

// Event do hint
procedure Tformprinc.DoHint(Sender : Tobject);     // le sender est du type tApplication
var s,nomForm: string;
    FormeTCO : boolean;
begin
  s:=Application.Hint;       // texte du hint
  StatusBar1.Panels[0].text:=s;

  formeTCO:=false;
  // d�tection d'un hint provoqu� dans formtco
  if Screen.ActiveForm<>nil then
  begin
    NomForm:=uppercase(Screen.activeform.Name);
    formeTCO:=copy(NomForm,1,7)='FORMTCO';
  end;

  // dessine les encadr�s de colonne/ligne dans le tco suivant s�lection du popup menu, en fonction du hint qu'on accroche
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

// renvoie le 1er num�ro de bit � 1 du mot (en commen�ant � droite)
// PremBitNum(1)=0  car 1
// PremBitNum(4)=2  car 100
// si pas de bit � 1, renvoie -1
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
// Combine = code de la signalisation combin�e
// Exemple code_to_aspect(10001000000000)  renvoie premierBit=jaune_cli (9) et Combine=rappel 60 (13)
procedure code_to_aspect(codebin : word;var aspect,combine : integer) ;
begin
  aspect:=PremBitNum(CodeBin and $3ff);
  combine:=PremBitNum(CodeBin and $fc00);
end;

// conversion d'un �tat signal binaire en �tat unique de 1 � 19
// exemple code_to_etat(10001000000000) (jaune_cli et rappel 60) renvoie 19
function code_to_etat(code : word) : integer;
var aspect,combine : integer;
begin
  code_to_aspect(code,aspect,combine);
  result:=9999;
  if combine=-1 then
  begin
    if aspect=0 then result:=1;  // carr�
    if aspect=1 then result:=2;  // s�maphore
    if aspect=2 then result:=3;  // s�maphore cli
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
    if combine=12 then result:=13; // rappel 30
    if combine=13 then result:=14; // rappel 60
  end;

  if (aspect=9) and (combine=11) then result:=15;   //ralen 60 + jaune cli
  if (aspect=8) and (combine=12) then result:=16;   //rappel 30 + jaune
  if (aspect=9) and (combine=12) then result:=17;   //rappel 30 + jaune cli
  if (aspect=8) and (combine=13) then result:=18;   //rappel 60 + jaune
  if (aspect=9) and (combine=13) then result:=19;   //rappel 60 + jaune cli

  code_to_etat:=result;
  {'Non command�','carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ralen 30','ralen 60','ralen 60 + jaune cli','rappel 30','rappel 60',
               7        8         9         10         11          12               13               14         15
           'rappel 30 + jaune','rappel 30 + jaune cli','rappel 60 + jaune','rappel 60 + jaune cli');
                     16                  17                      18                   19     }
end;

// renvoie la cha�ne de l'�tat du signal
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
    // en signalisation belge, on peut avoir plusieurs bits � 1 simultan�ment en combine
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

  // signalisation fran�aise
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


// dessine un cercle plein dans le signal dans le canvas
procedure cercle(ACanvas : Tcanvas;x,y,rayon : integer;coulcercle,couleurfond : Tcolor);
var hdc,canvasHd : hwnd;
    ps : PAINTSTRUCT ;
begin
  //vwhd:=getparent(Acanvas.Handle);

  with Acanvas do
  begin
    brush.Style:=bsSolid;
    brush.Color:=couleurFond;
    pen.Color:=coulCercle;
    pen.Width:=2;
    pen.Mode:=pmCopy;
    Ellipse(x-rayon,y-rayon,x+rayon,y+rayon);
  end;
  exit;

  // avec api windows
  canvasHd:=Acanvas.Handle;
  hdc:= BeginPaint(canvasHd, ps);

  SelectObject(canvasHd, GetStockObject(DC_BRUSH));
  SetDCBrushColor(canvasHd, couleurFond);
  SelectObject(canvasHd, GetStockObject(DC_PEN));
  SetDCPenColor(canvasHd, coulCercle);

  Ellipse(canvasHd,x-rayon,y-rayon,x+rayon,y+rayon);

  EndPaint(canvashd,ps);
end;

// Ecrire sur un canvas un texte avec un angle, avec ou sans bordure, monochrome ou � face textur�e
// params : C       = Canvas-cible
//          X,Y     = Coordonn�es angle sup�rieur gauche du d�but du texte.
//          Fonte   = Police de caract�res � utiliser : uniquement des fontes scalables.
//          clBord  = Couleur de la bordure.
//          EpBord  = Epaisseur de la bordure.
//          PenMode = TPenMode : utiliser en g�n�ral pmCopy.
//          si Clfond=clback, on �crit en transparent
//          Texte   = Texte � �crire.
//          AngleDD = Angle d'inclinaison en Dixi�mes de degr�.
procedure AffTexteIncliBordeTexture(c : TCanvas; x,y : integer; Fonte : tFont;
                                    clBord : TColor; EpBord : integer; PenMode : TPenMode;
                                    texte : string; AngleDD : longint);
var dc : Hdc;
    lgFont : Logfont;           // structure d'attributs de police
    AncFonte,NouvFonte : Hfont;
    AncPen,NouvPen : Hpen;
    AncBrush,NouvBrush : Hbrush;
    i : integer;
begin
  C.Pen.Mode:=PenMode;
  dc:=C.Handle;

  c.pen.Mode:=PmCopy;
  //c.pen.Color:=clfond; //clfond;
  //c.Brush.color:=clfond;
  c.pen.width:=1;
  i:=round(length(texte)*0.5*abs(fonte.size));
//  c.Rectangle(x+2,y,x+15,y-i);

  // Initialisation de la fonte
  zeroMemory(@lgFont,sizeOf(lgFont));      // remplit la structure de 0
  strPCopy(lgFont.lfFaceName,Fonte.Name);  // copie la cha�ne dans le nom de la fonte depuis le param�tre
  lgFont.lfHeight:=Fonte.Height;           // la taille
  if Fonte.style=[] then lgFont.lfWeight:=FW_REGULAR; // Normal
  if Fonte.style=[fsBold] then lgFont.lfWeight:=FW_BOLD;    // Gras

  if fsItalic in Fonte.style    then lgFont.lfItalic:=1;
  if fsUnderline in Fonte.style then lgFont.lfUnderline:=1;
  if fsStrikeout in Fonte.style then lgFont.lfStrikeout:=1;

  lgFont.lfEscapement:=AngleDD; // Angle d'inclinaison en dixi�mes de degr�s

  NouvFonte:=CreateFontInDirect(lgFont);
  AncFonte:=SelectObject(dc,NouvFonte);

  // Initialisation du contour :
  if EpBord<>0 then NouvPen := CreatePen(PS_SOLID,EpBord,clBord)
                       else NouvPen := CreatePen(PS_NULL,0,0);
  AncPen:= SelectObject(dc,NouvPen);

  // Initialisation de la couleur de la police ou de la Texture :
  //if Texture=nil then
  NouvBrush := CreateSolidBrush(Fonte.color);
  //                       else NouvBrush := CreatePatternBrush(Texture.Handle);
  AncBrush:=SelectObject(dc,NouvBrush);
  // Le contexte doit �tre transparent
  SetBkMode(dc,TRANSPARENT);

  // Dessin du texe :
  BeginPath(dc);
  TextOut(dc,X,Y,PChar(Texte),length(texte)); //<- au lieu de TextOut(dc,X,Y,PansiChar(Texte),length(texte)) pour rendre le code compatible avec toutes les versions de Delphi (de D2 � XE2);
  EndPath(dc);
  StrokeAndFillPath(dc);

  // Restauration objets et lib�ration m�moire
  SelectObject(dc,AncFonte);
  DeleteObject(NouvFonte);
  SelectObject(dc,AncPen);
  DeleteObject(NouvPen);
  SelectObject(dc,AncBrush);
  DeleteObject(NouvBrush);
end;
// inverse une image (miroir horizontal) et la met dans dest
// Utilis� pour les signaux belges, et les trains
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

{
// dessine les 2 feux sur la cible dans le canvas sp�cifi�
// x,y : offset en pixels du coin sup�rieur gauche du feu
// Acanvas : canvas de destination
// frX, frY : facteurs de r�duction (pour agrandissement)
// EtatSignal : �tat du signal
// orientation � donner au signal : 1= vertical 2=90� � gauche  3=90� � droite  4=180�
procedure dessine_signal2(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
var Temp,rayon,xViolet,YViolet,xBlanc,yBlanc,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine);
  rayon:=round(6*frX);

  // r�cup�rer les dimensions de l'image d'origine du feu
  with Formprinc.Image2feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;

  XBlanc:=13; YBlanc:=11;
  xViolet:=13; yViolet:=23;

  if (orientation=2) then
  begin
    //rotation 90� vers la gauche des feux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yViolet;YViolet:=XViolet;XViolet:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
  end;

  if (orientation=3) then
  begin
    // rotation 90� vers la droite des feux
    // inversion des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-XBlanc;Xblanc:=Yblanc;Yblanc:=Temp;
    Temp:=LgImage-Xviolet;Xviolet:=Yviolet;Yviolet:=Temp;
  end;

  // 180�
  if orientation=4 then
  begin
    Xblanc:=LgIMage-Xblanc;Yblanc:=HtImage-Yblanc;
    Xviolet:=LgIMage-Xviolet;Yviolet:=HtImage-Yviolet;
  end;

  XBlanc:=round(xBlanc*Frx)+x;   YBlanc:=round(Yblanc*Fry)+y;
  XViolet:=round(XViolet*FrX)+x; YViolet:=round(YViolet*FrY)+y;

  if signaux[index].AncienAff<>EtatSignal then
  begin
    //Affiche('efface tout',clred);
    cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
    cercle(ACanvas,xViolet,yViolet,rayon,GrisF);
    signaux[index].AncienAff:=EtatSignal;
  end;


  // extinctions
  if (code=blanc_cli) and not(clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);

  // allumages
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clWhite);
  if code=violet then cercle(ACanvas,xViolet,yViolet,rayon,clviolet);
end;

// dessine les feux sur une cible � 3 feux
procedure dessine_signal3(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation,index : integer);
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
    //rotation 90� vers la droite des signaux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
  end;

  if (orientation=4) then
  begin
    //rotation 180�
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

  // efface
  if (code=vert_cli) and not(clignotant) then cercle(ACanvas,xVert,yVert,rayon,GrisF);
  if (code=jaune_cli) and not(clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
  if (code=semaphore_cli) and not(clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,xJaune,yJaune,rayon,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clRed);

end;

// dessine les feux sur une cible � 4 feux
// orientation=1 vertical
procedure dessine_signal4(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
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
    // rotation 90� vers la gauche des feux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune; YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-ycarre; Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;   YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;  Yvert:=Xvert;Xvert:=Temp;
  end;

  if (orientation=3) then
  begin
    //rotation 90� vers la droite des feux
    // calcul des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
  end;

  if (orientation=4) then
  begin
    // rotation 180�
    Xjaune:=LgImage-Xjaune;YJaune:=HtImage-YJaune;
    XSem:=LgImage-XSem;    YSem:=HtImage-YSem;
    XVert:=LgImage-Xvert;  Yvert:=HtImage-Yvert;
    Xcarre:=LgImage-Xcarre;Ycarre:=HtImage-Ycarre;
  end;

  XJaune:=round(Xjaune*Frx)+x;  YJaune:=round(Yjaune*Fry)+Y;
  Xvert:=round(Xvert*FrX)+x;    Yvert:=round(Yvert*FrY)+Y;
  XSem:=round(XSem*FrX)+x;      YSem:=round(YSem*FrY)+Y;
  Xcarre:=round(Xcarre*FrX)+x;  Ycarre:=round(Ycarre*FrY)+Y;

  // nouveau cercle(ACanvas,Xcarre,yCarre,rayon,GrisF); Affiche('Eteint carr�',clYellow);

  if signaux[index].AncienAff<>EtatSignal then
  begin
    //Affiche('efface tout',clred);
    cercle(ACanvas,xVert,yVert,rayon,GrisF);
    cercle(ACanvas,xSem,ySem,rayon,GrisF);
    cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
    cercle(ACanvas,xCarre,yCarre,rayon,GrisF);

    signaux[index].AncienAff:=EtatSignal;
  end;

  // extinctions
  if (code=vert_cli) and not(clignotant) then cercle(ACanvas,Xvert,yvert,rayon,GrisF);
  if (code=semaphore_cli) and not(clignotant) then cercle(ACanvas,Xsem,Ysem,rayon,GrisF);
  if (code=jaune_cli) and not(clignotant) then cercle(ACanvas,Xjaune,YJaune,rayon,GrisF);

  // allumages
  if (code=vert_cli) and clignotant or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clGreen);
  if (code=semaphore_cli) and clignotant or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clRed);
  if (code=jaune_cli) and clignotant or (code=jaune) then cercle(Acanvas,Xjaune,yJaune,rayon,clOrange);
  if code=carre then begin cercle(ACanvas,xSem,Ysem,rayon,clRed);cercle(ACanvas,xCarre,yCarre,rayon,clRed);end;

end;

// dessine les feux sur une cible � 5 feux
procedure dessine_signal5(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
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
    // rotation 90� vers la gauche des signaux
    // calcul des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;

  if (orientation=3) then
  begin
    // rotation 90� vers la droite des signaux
    // calcul des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;
  end;

  if (orientation=4) then
  begin
    // rotation 180�
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

  if signaux[index].AncienAff<>EtatSignal then
  begin
    //Affiche('efface tout',clred);
    cercle(ACanvas,xVert,yVert,rayon,GrisF);
    cercle(ACanvas,xSem,ySem,rayon,GrisF);
    cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
    cercle(ACanvas,xCarre,yCarre,rayon,GrisF);
    cercle(ACanvas,xblanc,yblanc,rayon,GrisF);
    signaux[index].AncienAff:=EtatSignal;
  end;

  // extinctions
  if (code=blanc_cli) and not(clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
  if (code=vert_cli) and not(clignotant) then cercle(ACanvas,xvert,yvert,rayon,GrisF);
  if (code=semaphore_cli) and not(clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);
  if (code=jaune_cli) and not(clignotant) then cercle(ACanvas,xjaune,yjaune,rayon,GrisF);

  // allumages
  if code=carre then begin cercle(ACanvas,xcarre,ycarre,rayon,clRed);cercle(ACanvas,xsem,ysem,rayon,clRed);end;

  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xsem,ysem,rayon,clRed);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xblanc,yblanc,rayon,clWhite);
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clViolet);
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xvert,yVert,rayon,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(ACanvas,xJaune,yjaune,rayon,clorange);
end;


// dessine les feux sur une cible � 7 feux
procedure dessine_signal7(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
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
    // rotation 90� vers la gauche des feux
    // calcul des facteurs de r�duction pour la rotation
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
    // rotation 90� vers la droite des feux
    // calcul des facteurs de r�duction pour la rotation
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
    //rotation 180�
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

  if signaux[index].AncienAff<>EtatSignal then
  begin
    //Affiche('efface tout',clred);
    cercle(ACanvas,xVert,yVert,rayon,GrisF);
    cercle(ACanvas,xSem,ySem,rayon,GrisF);
    cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
    cercle(ACanvas,xCarre,yCarre,rayon,GrisF);
    cercle(ACanvas,xblanc,yblanc,rayon,GrisF);
    cercle(ACanvas,xRal1,yRal1,rayon,GrisF);
    cercle(ACanvas,xRal2,yRal2,rayon,GrisF);

    signaux[index].AncienAff:=EtatSignal;
  end;

  // effacements
  if (code=blanc_cli) and not(clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,grisF);
  if (combine=ral_60) and not(clignotant) then begin cercle(ACanvas,Xral1,Yral1,rayon,grisF);cercle(ACanvas,Xral2,Yral2,rayon,GrisF);end;
  if (code=vert_cli) and not(clignotant) then cercle(ACanvas,xVert,yVert,rayon,GrisF);
  if (code=jaune_cli) and not(clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
  if (code=semaphore_cli) and not(clignotant) then cercle(ACanvas,xSem,ySem,rayon,GrisF);

  // Allumages
  if (combine=ral_30) or ((combine=ral_60) and clignotant) then begin cercle(ACanvas,xRal1,yRal1,rayon,clOrange);cercle(ACanvas,xRal2,yRal2,Rayon,clOrange);end;
  if ((code=jaune_cli) and clignotant) or (code=jaune) then cercle(Acanvas,xjaune,yjaune,rayon,clOrange);
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

// dessine les feux sur une cible � 9 feux
procedure dessine_signal9(Acanvas : Tcanvas;x,y : integer;frX,frY : single;etatsignal : word;orientation,index : integer);
var rayon,
    XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Xrap1,Yrap1,Xrap2,Yrap2,Temp,LgImage,HtImage,xt,yt,code,combine  : integer;
    ech : real;
begin
  rayon:=round(6*frX);
  code_to_aspect(Etatsignal,code,combine); // et aspect
  // mise � l'�chelle des coordonn�es des feux en fonction du facteur de r�duction frX et frY et x et y (offsets)

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
    //rotation 90� vers la gauche des feux : �change des coordonn�es X et Y et translation sur HtImage
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
    //rotation 90� vers la droite des feux : �change des coordonn�es X et Y et translation sur LgImage
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
    //rotation 180�
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

  if signaux[index].AncienAff<>EtatSignal then
  begin
    //Affiche('efface tout',clred);
    cercle(ACanvas,xVert,yVert,rayon,GrisF);
    cercle(ACanvas,xSem,ySem,rayon,GrisF);
    cercle(ACanvas,xJaune,yJaune,rayon,GrisF);
    cercle(ACanvas,xCarre,yCarre,rayon,GrisF);
    cercle(ACanvas,xblanc,yblanc,rayon,GrisF);
    cercle(ACanvas,xRal1,yRal1,rayon,GrisF);
    cercle(ACanvas,xRal2,yRal2,rayon,GrisF);
    cercle(ACanvas,xRap1,yRap1,rayon,GrisF);
    cercle(ACanvas,xRap2,yRap2,rayon,GrisF);

    signaux[index].AncienAff:=EtatSignal;
  end;

  // extinctions
  if (code=blanc_cli) and not(clignotant) then cercle(ACanvas,xBlanc,yBlanc,Rayon,grisF);
  if (combine=ral_60) and not(clignotant) then begin cercle(ACanvas,Xral1,Yral1,rayon,grisF);cercle(ACanvas,xRal2,yRal2,rayon,grisF);end;
  if (code=jaune_cli) and not(clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,grisF);
  if (code=rappel_60) and not(clignotant) then begin cercle(ACanvas,xrap1,yrap1,rayon,grisF);cercle(ACanvas,xrap2,yrap2,rayon,grisF);end;
  if (code=semaphore_cli) and not(clignotant) then cercle(ACanvas,xSem,ySem,rayon,grisF);
  if (code=vert_cli) and not(clignotant) then cercle(ACanvas,xvert,yvert,rayon,grisF);

  // allumages
  if ((code=ral_60) and clignotant) or (code=ral_30) or ((combine=ral_60) and clignotant) or (combine=ral_30) then
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


// dessine les feux sur une cible belge � 5 feux
// cette image peut �tre invers�e (contre voie)

procedure dessine_signal20(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,adresse : integer);
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
    //rotation 90� vers la gauche des signaux
    // calcul des facteurs de r�duction pour la rotation
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
    // rotation 90� vers la droite des signaux
    // calcul des facteurs de r�duction pour la rotation
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

  if signaux[index].AncienAff<>EtatSignal then
  begin
    //Affiche('efface tout',clred);
    cercle(ACanvas,xVert,yVert,rayon,GrisF);
    cercle(ACanvas,xRouge,yRouge,rayon,GrisF);
    cercle(ACanvas,xblanc,yblanc,rayon,GrisF);
    cercle(ACanvas,xJauneBas,yJauneBas,rayon,GrisF);
    cercle(ACanvas,xJauneHaut,yJauneHaut,rayon,GrisF);

    signaux[index].AncienAff:=EtatSignal;
  end;

  // extinctions
  if (code=vertB_F) and codeclignote and not(clignotant) then cercle(ACanvas,xvert,yvert,rayon,GrisF);
  if (code=rouge_F) and codeclignote and not(clignotant) then cercle(ACanvas,xrouge,yrouge,rayon,GrisF);
  if (code=rouge_blanc_F) and codeclignote and not(clignotant) then
  begin
    cercle(ACanvas,xBlanc,yBlanc,rayon,GrisF);
    cercle(ACanvas,xRouge,yRouge,rayon,GrisF);
  end;
  if (code=deux_jaunes_F) and codeclignote and not(clignotant) then
  begin
    cercle(ACanvas,xjaunebas,yjauneBas,rayon,GrisF);
    cercle(ACanvas,xjaunehaut,yjauneHaut,rayon,GrisF);
  end;
  if (code=vert_jaune_H_F) and codeclignote and not(clignotant) then
  begin
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,grisF);
    cercle(ACanvas,xvert,yvert,rayon,grisF);
  end;
  if (code=vert_jaune_V_F) and codeclignote and not(clignotant) then
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

    // �crit le chiffre
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
          AffTexteIncliBordeTexture(Acanvas,XTexte,YTexte,Acanvas.Font,clYellow,0,pmcopy,intToSTR(vitesse),angle);
        end;
      end;
    end
    else
    begin
      // �teint le chiffre
      Brush.Color:=clblack;
      Pen.Color:=clblack;
      r.Left:=xchiffre;r.Top:=Ychiffre;
      r.Right:=Xfin;r.Bottom:=Yfin;
      Fillrect(r);
    end;
  end;
end;    }

// dessine les 2 feux sur la cible dans le canvas sp�cifi�
// x,y : offset en pixels du coin sup�rieur gauche du feu
// Acanvas : canvas de destination
// frX, frY : facteurs de r�duction (pour agrandissement)
// EtatSignal : �tat du signal
// orientation � donner au signal : 1= vertical 2=90� � gauche  3=90� � droite  4=180�
procedure dessine_signal2(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
var Temp,rayon,xViolet,YViolet,xBlanc,yBlanc,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine);
  rayon:=round(DiamFeu*frX);

  // r�cup�rer les dimensions de l'image d'origine du feu
  with Formprinc.Image2feux.Picture.Bitmap do
  begin
    LgImage:=Width;
    HtImage:=Height;
  end;

  XBlanc:=13; YBlanc:=11;
  xViolet:=13; yViolet:=23;

  if (orientation=2) then
  begin
    //rotation 90� vers la gauche des feux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yViolet;YViolet:=XViolet;XViolet:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
  end;

  if (orientation=3) then
  begin
    // rotation 90� vers la droite des feux
    // inversion des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-XBlanc;Xblanc:=Yblanc;Yblanc:=Temp;
    Temp:=LgImage-Xviolet;Xviolet:=Yviolet;Yviolet:=Temp;
  end;

  // 180�
  if orientation=4 then
  begin
    Xblanc:=LgIMage-Xblanc;Yblanc:=HtImage-Yblanc;
    Xviolet:=LgIMage-Xviolet;Yviolet:=HtImage-Yviolet;
  end;

  XBlanc:=round(xBlanc*Frx)+x;   YBlanc:=round(Yblanc*Fry)+y;
  XViolet:=round(XViolet*FrX)+x; YViolet:=round(YViolet*FrY)+y;

  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,grisF);
  cercle(ACanvas,xViolet,yViolet,rayon,clBlack,GrisF);

  // allumages
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,clWhite);
  if code=violet then cercle(ACanvas,xViolet,yViolet,rayon,clBlack,clViolet);
end;

// dessine les feux sur une cible � 3 feux
procedure dessine_signal3(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xvert,Yvert,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
//  Affiche('dessine_feu3',clred);
  code_to_aspect(Etatsignal,code,combine);
  //Affiche(intToSTR(ancienEtat),clred);

  rayon:=round(DiamFeu*frX);

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
    //rotation 90� vers la droite des signaux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
  end;

  if (orientation=4) then
  begin
    //rotation 180�
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


  if not((code=jaune_cli) and clignotant)      then cercle(ACanvas,xJaune,yJaune,rayon,clBlack,grisF);
  if not((code=vert_cli)  and clignotant)      then cercle(ACanvas,xVert,yVert,rayon,clBlack,grisF);
  if not((code=semaphore_cli) and clignotant)  then cercle(ACanvas,xSem,ySem,rayon,clBlack,grisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clBlack,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,xJaune,yJaune,rayon,clBlack,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clBlack,clRed);
end;


// dessine les feux sur une cible � 4 feux
// orientation=1 vertical
procedure dessine_signal4(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
var Temp,rayon,xSem,Ysem,xJaune,Yjaune,Xcarre,Ycarre,Xvert,Yvert,
    LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine); // et aspect
  rayon:=round(DiamFeu*frX);

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
    // rotation 90� vers la gauche des feux
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune; YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-ycarre; Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;   YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;  Yvert:=Xvert;Xvert:=Temp;
  end;

  if (orientation=3) then
  begin
    //rotation 90� vers la droite des feux
    // calcul des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
  end;

  if (orientation=4) then
  begin
    // rotation 180�
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
  if not(code=carre) then cercle(ACanvas,Xcarre,yCarre,rayon,clBlack,grisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,Xsem,Ysem,rayon,clBlack,grisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,Xvert,yvert,rayon,clBlack,grisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,Xjaune,YJaune,rayon,clBlack,grisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clBlack,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,Xjaune,yJaune,rayon,clBlack,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xSem,ySem,rayon,clBlack,clRed);
  if code=carre then
  begin
    cercle(ACanvas,xSem,Ysem,rayon,clBlack,clRed);
    cercle(ACanvas,xCarre,yCarre,rayon,clBlack,clRed);
  end;
end;

// dessine les feux sur une cible � 5 feux
procedure dessine_signal5(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
var XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,
    Temp,rayon,LgImage,HtImage,code,combine : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine); // et aspect
  rayon:=round(DiamFeu*frX);
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
    // rotation 90� vers la gauche des signaux
    // calcul des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune;YJaune:=XJaune;Xjaune:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc;XBlanc:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert;Xvert:=Temp;
  end;

  if (orientation=3) then
  begin
    // rotation 90� vers la droite des signaux
    // calcul des facteurs de r�duction pour la rotation
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp;
  end;

  if (orientation=4) then
  begin
    // rotation 180�
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
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,GrisF);
  if not(code=carre) then cercle(ACanvas,xcarre,ycarre,rayon,grisF,GrisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,xvert,yvert,rayon,clBlack,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,clBlack,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xjaune,yjaune,rayon,clBlack,GrisF);

  // allumages
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xsem,ysem,rayon,clBlack,clRed);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xblanc,yblanc,rayon,clBlack,clWhite);
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clBlack,clViolet);
  if code=carre then
  begin
    cercle(ACanvas,xcarre,ycarre,rayon,clBlack,clRed);
    cercle(ACanvas,xsem,ysem,rayon,clBlack,clRed);
  end;
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xvert,yVert,rayon,clBlack,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(ACanvas,xJaune,yjaune,rayon,clBlack,clorange);
end;


// dessine les feux sur une cible � 7 feux
procedure dessine_signal7(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,index : integer);
var XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Temp,rayon,LgImage,HtImage,code,combine  : integer;
    ech : real;
begin
  code_to_aspect(Etatsignal,code,combine); // et combine
  rayon:=round(DiamFeu*frX);
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
    // rotation 90� vers la gauche des feux
    // calcul des facteurs de r�duction pour la rotation
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
    // rotation 90� vers la droite des feux
    // calcul des facteurs de r�duction pour la rotation
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
    //rotation 180�
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
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,grisF);
  if not((code=ral_60) and clignotant) or not((combine=ral_60) and clignotant) then
  begin
    cercle(ACanvas,Xral1,Yral1,rayon,clBlack,grisF);cercle(ACanvas,Xral2,Yral2,rayon,clBlack,GrisF);
  end;
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,xVert,yVert,rayon,clBlack,GrisF);
  if not(code=carre) then cercle(ACanvas,xcarre,yCarre,rayon,clBlack,GrisF);cercle(ACanvas,xSem,ySem,rayon,clBlack,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,clBlack,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,clBlack,GrisF);

  // Allumages
  if (code=ral_30) or (combine=ral_30) or ((code=ral_60) or (combine=ral_60)) and clignotant then
  begin
    cercle(ACanvas,xRal1,yRal1,rayon,clBlack,clOrange);cercle(ACanvas,xRal2,yRal2,Rayon,clBlack,clOrange);
  end;
  if (code=jaune) or ((code=jaune_cli) and clignotant) then cercle(Acanvas,xjaune,yjaune,rayon,clBlack,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,xsem,ysem,rayon,clBlack,clRed);
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,xVert,yVert,rayon,clBlack,clGreen);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,clWhite);
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clBlack,clViolet);
  if code=carre then
  begin
    cercle(ACanvas,xCarre,yCarre,rayon,clBlack,clRed);
    cercle(ACanvas,xSem,ySem,rayon,clBlack,clRed);
  end;
end;

// dessine les feux sur une cible � 9 feux
procedure dessine_signal9(Acanvas : Tcanvas;x,y : integer;frX,frY : single;etatsignal : word;orientation,index : integer);
var rayon,
    XBlanc,Yblanc,xJaune,yJaune,Xsem,YSem,Xvert,YVert,Xcarre,Ycarre,Xral1,Yral1,Xral2,YRal2,
    Xrap1,Yrap1,Xrap2,Yrap2,Temp,LgImage,HtImage,xt,yt,code,combine  : integer;
    ech : real;
begin
  rayon:=round(DiamFeu*frX);
  code_to_aspect(Etatsignal,code,combine); // et aspect
  // mise � l'�chelle des coordonn�es des feux en fonction du facteur de r�duction frX et frY et x et y (offsets)

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
    //rotation 90� vers la gauche des feux : �change des coordonn�es X et Y et translation sur HtImage
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=HtImage-yjaune;YJaune:=XJaune-1;Xjaune:=Temp;
    Temp:=HtImage-yBlanc;YBlanc:=XBlanc-1;XBlanc:=Temp;
    Temp:=HtImage-yRal1;YRal1:=XRal1-1;XRal1:=Temp;
    Temp:=HtImage-yRal2;YRal2:=XRal2-1;XRal2:=Temp;
    Temp:=HtImage-ycarre;Ycarre:=Xcarre-1;Xcarre:=Temp;
    Temp:=HtImage-ySem;YSem:=XSem-1;XSem:=Temp;
    Temp:=HtImage-yvert;Yvert:=Xvert-1;Xvert:=Temp;
    Temp:=HtImage-yRap1;YRap1:=XRap1-1;XRap1:=Temp;
    Temp:=HtImage-yRap2;YRap2:=XRap2-1;XRap2:=Temp;
  end;

  if (orientation=3) then
  begin
    //rotation 90� vers la droite des feux : �change des coordonn�es X et Y et translation sur LgImage
    ech:=frY;frY:=frX;FrX:=ech;
    Temp:=LgImage-Xjaune;XJaune:=YJaune;Yjaune:=Temp-1;
    Temp:=LgImage-XSem;XSem:=YSem;YSem:=Temp-1;
    Temp:=LgImage-Xvert;Xvert:=Yvert;Yvert:=Temp-1;
    Temp:=LgImage-Xcarre;Xcarre:=Ycarre;Ycarre:=Temp-1;
    Temp:=LgImage-Xblanc;Xblanc:=Yblanc;Yblanc:=Temp-1;
    Temp:=LgImage-Xral1;Xral1:=Yral1;Yral1:=Temp-1;
    Temp:=LgImage-Xral2;Xral2:=Yral2;Yral2:=Temp-1;
    Temp:=LgImage-Xrap1;Xrap1:=Yrap1;Yrap1:=Temp-1;
    Temp:=LgImage-Xrap2;Xrap2:=Yrap2;Yrap2:=Temp-1;
  end;

  if (orientation=4) then
  begin
    //rotation 180�
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
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,xBlanc,yBlanc,Rayon,clBlack,grisF);
  if not((code=ral_60) and clignotant) or not((combine=ral_60) and clignotant) then
  begin
    cercle(ACanvas,Xral1,Yral1,rayon,clBlack,grisF);cercle(ACanvas,xRal2,yRal2,rayon,clBlack,grisF);
  end;
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,xJaune,yJaune,rayon,clBlack,grisF);
  if not((code=rappel_60) and clignotant) or not((combine=rappel_60) and clignotant) then
  begin
    cercle(ACanvas,xrap1,yrap1,rayon,clBlack,grisF);cercle(ACanvas,xrap2,yrap2,rayon,clBlack,grisF);
  end;
  if not(code=carre) then cercle(ACanvas,xcarre,Ycarre,rayon,clblack,grisF); // carr� sup�rieur
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,xSem,ySem,rayon,clBlack,grisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,xvert,yvert,rayon,clBlack,grisF);

  // allumages
  if ((code=ral_60) and clignotant) or (code=ral_30) or
     ((combine=ral_60) and clignotant) or (combine=ral_30) then
  begin
    cercle(ACanvas,Xral1,yRal1,rayon,clBlack,clOrange);cercle(ACanvas,xral2,yral2,rayon,clBlack,clOrange);
  end;

  if ((code=rappel_60) and clignotant) or (code=rappel_30) or
     ((combine=rappel_60) and clignotant) or (combine=rappel_30) then
  begin
    cercle(ACanvas,xrap1,yrap1,rayon,clBlack,clOrange);cercle(ACanvas,xrap2,yrap2,rayon,clBlack,clOrange);
  end;
  if ((code=jaune_cli) and clignotant) or (code=jaune) then cercle(Acanvas,xjaune,yjaune,rayon,clBlack,clOrange);
  if ((code=semaphore_cli) and clignotant) or (code=semaphore) then cercle(ACanvas,Xsem,ySem,rayon,clBlack,clRed);
  if ((code=vert_cli) and clignotant) or (code=vert) then cercle(ACanvas,xvert,yvert,rayon,clBlack,clGreen);
  if ((code=blanc_cli) and clignotant) or (code=blanc) then cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,clWhite);
  if (code=violet) then cercle(ACanvas,xblanc,yblanc,rayon,clBlack,clViolet);

  if code=carre then
  begin
    cercle(ACanvas,xcarre,yCarre,rayon,clBlack,clRed);
    cercle(ACanvas,xsem,ysem,rayon,clBlack,clRed);
  end;
end;


// dessine les feux sur une cible belge � 5 feux
// cette image peut �tre invers�e (contre voie)
procedure dessine_signal20(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,adresse : integer);
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

  rayon:=round(DiamFeu*frX);
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
    //rotation 90� vers la gauche des signaux
    // calcul des facteurs de r�duction pour la rotation
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
    // rotation 90� vers la droite des signaux
    // calcul des facteurs de r�duction pour la rotation
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
  if not((code=vertB_F) and codeclignote and clignotant) then cercle(ACanvas,xvert,yvert,rayon,clBlack,GrisF);
  if not((code=rouge_F) and codeclignote and clignotant) then cercle(ACanvas,xrouge,yrouge,rayon,clBlack,GrisF);
  if not((code=rouge_blanc_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xBlanc,yBlanc,rayon,clBlack,GrisF);
    cercle(ACanvas,xRouge,yRouge,rayon,clBlack,GrisF);
  end;
  if not((code=deux_jaunes_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xjaunebas,yjauneBas,rayon,clBlack,GrisF);
    cercle(ACanvas,xjaunehaut,yjauneHaut,rayon,clBlack,GrisF);
  end;
  if not((code=vert_jaune_H_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,clBlack,grisF);
    cercle(ACanvas,xvert,yvert,rayon,clBlack,grisF);
  end;
  if not((code=vert_jaune_V_F) and codeclignote and clignotant) then
  begin
    cercle(ACanvas,xjauneBas,yjauneBas,rayon,clBlack,grisF);
    cercle(ACanvas,xvert,yvert,rayon,clBlack,grisF);
  end;


  //allumages
  if ((code=vertB_F) and codeClignote and clignotant) or ((code=vertB_F) and not(codeclignote)) then cercle(ACanvas,xvert,yvert,rayon,clBlack,clGreen);
  if ((code=rouge_F) and codeClignote and clignotant) or ((code=rouge_F) and not(codeclignote)) then cercle(ACanvas,xrouge,yrouge,rayon,clBlack,clRed);
  if ((code=rouge_blanc_F) and codeClignote and clignotant) or ((code=rouge_blanc_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xblanc,yblanc,rayon,clBlack,clWhite);
    cercle(ACanvas,xrouge,yrouge,rayon,clBlack,clred);
  end;
  if ((code=deux_jaunes_F) and codeClignote and clignotant) or ((code=deux_jaunes_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xjauneBas,yjauneBas,rayon,clBlack,clOrange);
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,clBlack,clOrange);
  end;
  if ((code=vert_jaune_H_F) and codeClignote and clignotant) or ((code=vert_jaune_H_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xjauneHaut,yjauneHaut,rayon,clBlack,clorange);
    cercle(ACanvas,xvert,yvert,rayon,clBlack,clgreen);
  end;
  if ((code=vert_jaune_V_F) and codeClignote and clignotant) or ((code=vert_jaune_V_F) and not(codeclignote)) then
  begin
    cercle(ACanvas,xjaunebas,yjaunebas,rayon,clBlack,clorange);
    cercle(ACanvas,xvert,yvert,rayon,clBlack,clgreen);
  end;

  with Acanvas do
  begin
    if Etatchevron then pen.color:=ClWhite else pen.color:=clblack;

    // dessine le chevron
    pen.Width:=2;
    Moveto(x1,y1);Lineto(x2,y2);Lineto(x3,y3);

    // �crit le chiffre
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
          AffTexteIncliBordeTexture(Acanvas,XTexte,YTexte,Acanvas.Font,clYellow,0,pmcopy,intToSTR(vitesse),angle);
        end;
      end;
    end
    else
    begin
      // �teint le chiffre
      Brush.Color:=clblack;
      Pen.Color:=clblack;
      r.Left:=xchiffre;r.Top:=Ychiffre;
      r.Right:=Xfin;r.Bottom:=Yfin;
      Fillrect(r);
    end;
  end;
end;

// dessine les feux sur une cible directionnelle � N feux
procedure dessine_dirN(Acanvas : Tcanvas;x,y : integer;frX,frY : single;EtatSignal : word;orientation,N : integer);
var rayon,x1,x2,x3,y1,y2,y3,x4,y4,x5,y5,x6,y6,LgImage,HtImage,temp : integer;
    ech : real;
begin
  if (n<2) or (n>6) then n:=2;
  if (orientation<1) or (orientation>3) then orientation:=1;
  rayon:=round(DiamFeu*frX);
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
    //rotation 90� vers la gauche des feux : �change des coordonn�es X et Y et translation sur HtImage
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
    //rotation 90� vers la droite des feux : �change des coordonn�es X et Y et translation sur LgImage
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
    cercle(ACanvas,x1,y1,rayon,clBlack,GrisF);
    cercle(ACanvas,x2,y2,rayon,clBlack,GrisF);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,GrisF);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,GrisF);
  end;
  if EtatSignal=1 then
  begin
    cercle(ACanvas,x1,y1,rayon,clBlack,clWhite);
    cercle(ACanvas,x2,y2,rayon,clBlack,grisF);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,grisF);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,GrisF);
  end;
  if EtatSignal=2 then
  begin
    cercle(ACanvas,x1,y1,rayon,clBlack,clWhite);
    cercle(ACanvas,x2,y2,rayon,clBlack,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,GrisF);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,GrisF);
  end;                  
  if EtatSignal=3 then
  begin
    cercle(ACanvas,x1,y1,rayon,clBlack,clWhite);
    cercle(ACanvas,x2,y2,rayon,clBlack,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,GrisF);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,GrisF);
  end;
  if EtatSignal=4 then
  begin
    cercle(ACanvas,x1,y1,rayon,clBlack,clWhite);
    cercle(ACanvas,x2,y2,rayon,clBlack,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,clWhite);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,GrisF);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,GrisF);
  end;
  if EtatSignal=5 then 
  begin
    cercle(ACanvas,x1,y1,rayon,clBlack,clWhite);
    cercle(ACanvas,x2,y2,rayon,clBlack,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,clWhite);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,clWhite);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,GrisF);
  end;
  if EtatSignal=6 then 
  begin
    cercle(ACanvas,x1,y1,rayon,clBlack,clWhite);
    cercle(ACanvas,x2,y2,rayon,clBlack,clWhite);
    if N>2 then cercle(ACanvas,x3,y3,rayon,clBlack,clWhite);
    if N>3 then cercle(ACanvas,x4,y4,rayon,clBlack,clWhite);
    if N>4 then cercle(ACanvas,x5,y5,rayon,clBlack,clWhite);
    if N>5 then cercle(ACanvas,x6,y6,rayon,clBlack,clWhite);
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


// affiche un texte contenu dans une chaine avec plusieurs CR, et le d�coupe � l'affichage.
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

// trouve l'index d'un actionneur par son adresse
function index_actionneur(adr : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  repeat
    trouve:=actionneur[i].adresse=adr;
    inc(i);
  until trouve or (i>Nactionneurs);
  if trouve then result:=i-1 else result:=0;
end;

// trouve l'index d'un train par son nom dans le tableau trains
function index_train_nom(nom : string) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  nom:=lowercase(nom);
  repeat
    trouve:=lowercase(trains[i].nom_train)=nom;
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
// si pas trouv� renvoie 0
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
  // v�rifier si l'adresse correspond
  if Signaux[result].adresse<>adresse then result:=0;
end;

// renvoie l'index de l'aiguillage dans le tableau aiguillages[] en fonction de son adresse
// si pas trouv� renvoie 0
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
  // v�rifier si l'adresse correspond
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
procedure Dessine_signal_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : single;adresse : integer;orientation : integer);
var i,aspect : integer;
begin
  i:=Index_Signal(adresse);
  if i<>0 then
  begin
    aspect:=Signaux[i].aspect ;
    case aspect of
      // signaux
      2 : dessine_signal2(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,i);
      3 : dessine_signal3(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,i);
      4 : dessine_signal4(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,i);
      5 : dessine_signal5(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,i);
      7 : dessine_signal7(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,i);
      9 : dessine_signal9(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,i);
     20 : dessine_signal20(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,Signaux[i].adresse);   // signal belge
     // indicateurs de direction
     12..16 : dessine_dirN(CanvasDest,x,y,frx,fry,Signaux[i].EtatSignal,orientation,aspect-10);
    end;
  end;
end;

// proc�dure activ�e si on clique G ou D sur une image d'un signal
procedure TFormPrinc.ProcOnMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;
begin
  if button=mbRight then
  begin
    P_image_pilote:=Sender as TImage;  // r�cup�rer l'objet image du signal cliqu� de la forme pilote
    s:=P_Image_pilote.Hint;            // r�cup�rer son hint qui contient l'adresse du signal cliqu�
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

// proc�dure activ�e quand on clique gauche sur l'image d'un signal
Procedure TFormprinc.ImageOnClick(Sender : Tobject);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;
begin
  P_image_pilote:=Sender as TImage;  // r�cup�rer l'objet image du signal cliqu� de la forme pilote
  s:=P_Image_pilote.Hint;            // r�cup�rer son hint qui contient l'adresse du feu cliqu�
  //Affiche(s,clyellow);
  i:=pos('@',s);  if i<>0 then delete(s,1,i);
  i:=pos('=',s);  if i<>0 then delete(s,i,1);
  i:=pos(' ',s);
  if i<>0 then s:=copy(s,1,i-1);
  val(s,AdrPilote,erreur);
  if adrPilote=0 then exit;
  i:=Index_Signal(AdrPilote);
  if i=0 then exit;

  Formpilote.show;
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
    20 : Bm:=Formprinc.ImageSignal20.picture.Bitmap;  // belge

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

// cr��e une image dynamiquement dans la partie droite pour un nouveau signal d�clar� dans le fichier de config
// rang commence � 1
procedure cree_image_signal(rang : integer);
var adresse,TypeSignal : integer;
    s : string;
    T_BP : TBitMap;
begin
  TypeSignal:=Signaux[rang].aspect;
  if typeSignal<=0 then exit;
  adresse:=Signaux[rang].adresse;
  Signaux[rang].Img:=Timage.create(Formprinc.ScrollBoxSig);
  if Signaux[rang].Img=nil then begin affiche('Erreur 900 : impossible de cr�er une image',clred);exit;end;

  with Signaux[rang].Img do
  begin
    if debug=1 then affiche('Image '+intToSTR(rang)+' cr��e',clLime);
    Autosize:=true;
    align:=alNone;
    Parent:=Formprinc.ScrollBoxSig;   // dire que l'image est dans la scrollBox1
    Name:='ImageSignal'+IntToSTR(rang);   // nom de l'image
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // d�termine les points d'origine
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    width:=LargImg;
    Height:=HtImg;

    // hint - sert � identifier le composant si on fait clic droit.
    s:='Index='+IntToSTR(rang)+'  @='+inttostr(Adresse)+'  D�codeur='+decodeur[Signaux[rang].Decodeur]+#13+
       '  Adresse d�tecteur associ�='+intToSTR(Signaux[rang].Adr_det1)+#13+
       '  Adresse �lement suivant='+intToSTR(Signaux[rang].Adr_el_suiv1);
    if Signaux[rang].Btype_suiv1=aig then s:=s+' (aig)';
    Hint:=s;
    showHint:=true;

    onClick:=Formprinc.Imageonclick;    // affectation proc�dure clique G sur image
    onMouseDown:=Formprinc.ProcOnMouseDown; // clique G ou D
    PopUpMenu:=Formprinc.PopupMenuSignal;  // affectation popupmenu sur clic droit

    // affecter le type d'image de signal dans l'image cr��e
    T_BP:=Select_dessin_Signal(TypeSignal);
    if T_BP=nil then
    begin
      Affiche('Erreur 418 : s�lection type signal incorrecte pour signal '+intToSTR(adresse),clred);
      exit;
    end;
    picture.Bitmap:=T_Bp;

    picture.BitMap.TransparentMode:=tmfixed;     // tmauto  (la couleur transparente est d�termin�e par pixel le plus en haut � gauche du bitmap)
                                                 // tmfixed (la couleur transparente est explicitement assign�e et stock�e dans le bitmap)
    Picture.Bitmap.TransparentColor:=clblue;     // la couleur de transparence est bleue
    Transparent:=true;

    // mettre rouge par d�faut
    Signaux[rang].AncienEtat:=9999;
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

  // cr��e le label pour afficher son adresse
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

  // cr��e le checkBox si un feu blanc est d�clar� sur ce feu
  if Signaux[rang].FeuBlanc then
  begin
    if debug=1 then affiche('Cr�ation CheckBox feu blanc '+intToSTR(rang),clLime);
    Signaux[rang].checkFB:=TCheckBox.create(Formprinc.ScrollBoxSig);  // ranger l'adresse de la Checkbox dans la structure du feu
    with Signaux[rang].CheckFB do
    begin
      onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la proc�dure de traitement quand on clique dessus
      Hint:='Feu blanc';
      Name:='CheckBoxFB'+intToSTR(adresse);  // affecter l'adresse du feu pour pouvoir le retrouver dans la proc�dure
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

procedure change_clic_train(i : integer);
begin
  if (i<1) or (i>nTrains) then exit;
  if idTrainClic>0 then Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,clWhite);

  IdTrainClic:=i;

  Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,$e0e0e0);
  with formprinc do
  begin
    Combotrains.ItemIndex:=IdTrainclic-1;
    EditAdrTrain.Text:=intToSTR(trains[idTrainClic].adresse);
    //Editvitesse.Text:=intToSTR(trains[idTrainClic].vitesseCons);
  end;
  // affiche le compteur du train cliqu�
  affiche_train_compteur(1);
  aiguille_compteur(1,idTrainClic,formCompteur[1]);
end;

// cliqu� sur 0 compteur
procedure tFormprinc.ImC0Onclic(Sender : Tobject);
var i : integer;
begin
  i:=extract_int((Sender as tbutton).Name);
  vitesse_loco(trains[i].nom_train,i,trains[i].adresse,0,10,0);
end;

// changement trackbar compteurs groupBox
procedure tformprinc.ImTBOnChange(Sender : tObject);
var i,vit : integer;
    tb : TtrackBar;
begin
  if clicTBFen or clicTBTrain then exit;
  //if Affevt then
  //Affiche('ImTBonchange',clYellow);
  ClicTBGB:=true;
  tb:=Sender as tTrackBar;
  i:=extract_int(tb.Name);
  vit:=Tb.position;
  vitesse_loco(trains[i].nom_train,i,trains[i].adresse,vit,10,0);
  //compteurT[1].tb.Position:=vit;
  if formCompteur[1].Labeltrain.caption=trains[i].nom_train then FormCompteur[1].TrackBarC.position:=vit;
  clicTBGB:=false;
end;

procedure tformPrinc.ImcOnclic(Sender : TObject);
var i : integer;
begin
  i:=extract_int((Sender as timage).Name);
  change_clic_train(i);
end;

procedure tformPrinc.ImcOnDblclic(Sender : TObject);
var i : integer;
begin
  i:=extract_int((Sender as timage).Name);
  change_clic_train(i);
  formCompteur[1].Show;
end;

// cr��e une image dynamiquement dans la partie droite pour un nouveau compteur par train
// rang commence � 1
procedure cree_GB_compteur(rang : integer);
const HautTb=10;  // hauteur trackbar
      ofsGBH=15;  // marge haut du groupbox
      ofsGBB=8;  // marge bas du groupbox
var Imh,Iml : integer;
begin
  iml:=0;imh:=0;
  //Affiche('Cr�ation compteur GroupBox'+intToSTR(rang),clYellow);
  CompteurT[rang].gb:=TGroupBox.Create(Formprinc.ScrollBoxC);
  // groupBox
  with CompteurT[rang].gb do
  begin
    Parent:=formprinc.ScrollBoxC;
    caption:=' ';
    Name:='GroupBoxT'+IntToSTR(rang);   // nom
    Top:=(HautComptC+5)*((rang-1) div NbreCompteursPLigne);   // d�termine les points d'origine
    Left:=10+ (LargComptC+5)*((rang-1) mod (NbreCompteursPLigne));
    width:=LargComptC;
    Height:=HautComptC;
    CompteurT[rang].paramcompt.imgL:=LargComptC-10;
    CompteurT[rang].paramcompt.imgH:=HautComptC-HautTb-ofsGBH-ofsGBB;
    //CompteurT[rang].ImgL:=imL;
    //CompteurT[rang].ImgH:=imH;
  end;

  CompteurT[rang].lbl:=TLabel.Create(Formprinc.ScrollBoxC);
  with CompteurT[rang].lbl do
  begin
    Parent:=compteurT[rang].gb;
    caption:=trains[rang].nom_train;
    Name:='LabelT'+IntToSTR(rang);   // nom
    Alignment:=taCenter;
    Top:=0;
    left:=8;
    width:=largComptC-10;
    font.Name:='Arial';
    font.Size:=10;
    font.Style:=[fsbold];
    //transparent:=false;
    //couleur:=compteurT[rang].gb.Color;
    //affiche(intToHex(couleur,6),clyellow);
    //color:=couleur;

    caption:=trains[rang].nom_train;

  end;

  CompteurT[rang].Img:=Timage.create(CompteurT[rang].gb);
  with compteurT[rang].Img do
  begin
    Autosize:=true;
    align:=alNone;
    Parent:=CompteurT[rang].gb;
    Name:='ImageCompteurT'+IntToSTR(rang);
    Top:=ofsGBH;
    Left:=5;
    width:=ImL;
    Height:=ImH;
    picture.Bitmap.Width:=ImL;
    picture.Bitmap.Height:=ImH;
    onClick:=formPrinc.ImConclic;
    onDblClick:=formPrinc.ImConDblclic;
    PopUpMenu:=Formprinc.PopupmenuCompteurs;
    //with Picture.Bitmap.canvas do
    with canvas do
    begin
      pen.Width:=3;
      pen.Color:=clLime;
      Moveto(0,0);lineto(imL,imH);
    end;
  end;

  compteurT[rang].FCBitMap.Free;
  compteurT[rang].fcBitMap:=tbitmap.Create;
  with compteurT[rang].FCBitMap do
  begin
    Width:=imL;
    Height:=imH;
  end;

  // bouton
  CompteurT[rang].bouton:=Tbutton.create(CompteurT[rang].gb);
  with compteurT[rang].bouton do
  begin
    Parent:=CompteurT[rang].gb;
    Name:='BoutonT'+IntToSTR(rang);
    Top:=compteurT[rang].Img.Height+compteurT[rang].Img.top-14;
    Left:=(Iml div 2)-3;
    width:=12;
    Height:=14;
    caption:='0';
    onclick:=formprinc.ImC0Onclic;
  end;

  // trackbar
  CompteurT[rang].tb:=Ttrackbar.create(CompteurT[rang].gb);
  with compteurT[rang].tb do
  begin
    Parent:=CompteurT[rang].gb;
    Name:='TrackBarT'+IntToSTR(rang);
    Top:=compteurT[rang].Img.Height+compteurT[rang].Img.top;
    Left:=3;
    width:=ImL;
    Height:=HautTB;
    min:=-128;
    Max:=128;
    ctl3D:=false;
    onChange:=formprinc.ImTBOnChange;
  end;
  init_compteur(rang,CompteurT[rang].gb);
end;


// cliqu� sur image, labelnom ou labelvitesse
// cliqu� train
procedure tFormprinc.ImageTrainonclick(Sender : tObject);
var P_component : tComponent;
     i : integer;
begin
  //Affiche('clic image train',clred);
  P_component:=sender as Tcomponent;

  i:=extract_int(P_Component.name);  // r�cup�rer le nom du composant cliqu� (image, label) qui contient l'index du train
  if (i<1) or (i>nTrains) then exit;
  change_clic_train(i);
end;

procedure tformprinc.ImageTrainDoubleClic(Sender : tObject);
var P_component : tComponent;
     i : integer;
begin
  P_component:=sender as Tcomponent;

  i:=extract_int(P_Component.name);  // r�cup�rer le nom du composant cliqu� (image, label) qui contient l'index du train
  if (i<1) or (i>nTrains) then exit;

  IdTrainClic:=i;
  AffCompteur:=true;
  formCompteur[1].Show;
end;


// renseigne les composants image train, label et vitesse
procedure renseigne_comp_trains(i : integer);
begin
 with image_train[i] do
        begin
          Autosize:=true;
          align:=alNone;
          Parent:=Formprinc.ScrollBoxTrains;
          Name:='ImageTrain'+IntToSTR(i);   // nom de l'image
          Top:=50*(i-1);   // d�termine les points d'origine
          Left:=0;
          picture.Bitmap.Width:=LargImgTrain;
          picture.Bitmap.Height:=HautImgTrain;
        end;
        with labeltrain[i] do
        begin
          Name:='LabelTrain'+intToSTR(i);
          Caption:=Trains[i].nom_train;
          Parent:=Formprinc.ScrollBoxTrains;
          font.color:=clBlack;
          font.Style:=[fsbold];
          width:=100;height:=20;
          Top:=Image_train[i].Top+(HautImgTrain div 3);
          Left:=LargImgTrain+10;
          BringToFront;
        end;
        with LabelVitesse[i] do
        begin
          Name:='LabelVitesse'+intToSTR(i);
          Caption:='V=0';
          Parent:=Formprinc.ScrollBoxTrains;
          font.color:=clBlack;
          width:=100;height:=20;
          Top:=Image_train[i].Top+(HautImgTrain div 3)+12;
          Left:=LargImgTrain+10;
          BringToFront;
        end;
         with LabelBlocUSB[i] do
        begin
          Name:='LabelBlocUSB'+intToSTR(i);
          caption:='';
          Parent:=Formprinc.ScrollBoxTrains;
          font.color:=clBlack;
          width:=100;height:=20;
          Top:=Image_train[i].Top+(HautImgTrain div 3)+24;
          Left:=LargImgTrain+10;
          BringToFront;
        end;
end;

// cr��e une image dans l'onglet trains , 2 label dynamiquement dans la partie droite pour un nouveau train d�clar� dans le fichier de config
// rang commence � 1
procedure cree_image_Train(rang : integer);
var i,adresse : integer;
    s : string;
begin
  if rang<1 then exit;
  adresse:=trains[rang].adresse;
  Image_Train[rang]:=Timage.create(Formprinc.ScrollBoxTrains);
  if Image_Train[rang]=nil then begin affiche('Erreur 901 : impossible de cr�er une image',clred);exit;end;

  // cr��e le label pour afficher son adresse
  LabelTrain[rang]:=Tlabel.create(Formprinc.ScrollBoxTrains);
  LabelTrain[rang].OnClick:=formprinc.ImageTrainonclick;

  // cr��e le label pour afficher sa vitesse
  LabelVitesse[rang]:=Tlabel.create(Formprinc.ScrollBoxTrains);
  LabelVitesse[rang].OnClick:=formprinc.ImageTrainonclick;

  // cr��e le label pour afficher les infos du bloc USB
  LabelBlocUSB[rang]:=Tlabel.create(Formprinc.ScrollBoxTrains);
  LabelBlocUSB[rang].OnClick:=formprinc.ImageTrainonclick;

  {$IF CompilerVersion >= 28.0}
  Formprinc.TabSheetTrains.styleName:='Windows';     // pour avoir le fond clair ind�pendant du style
  {$IFEND}

  renseigne_comp_trains(rang);
  with Image_Train[rang] do
  begin

    onClick:=Formprinc.ImageTrainonclick;    // affectation proc�dure clique G sur image
    OnDblClick:=formPrinc.ImageTrainDoubleClic;
    //onMouseDown:=Formprinc.ProcOnMouseDown; // clique G ou D
    PopUpMenu:=Formprinc.PopupMenuTrains;  // affectation popupmenu sur clic droit


    if debug=1 then affiche('Image '+intToSTR(rang)+' cr��e',clLime);
    Maj_icone_train(Image_Train[rang],rang,clWhite);   // copie le bitmap � l'�chelle depuis trains[].icone

    picture.BitMap.TransparentMode:=tmfixed;     // tmauto  (la couleur transparente est d�termin�e par pixel le plus en haut � gauche du bitmap)
                                                 // tmfixed (la couleur transparente est explicitement assign�e et stock�e dans le bitmap)
    Picture.Bitmap.TransparentColor:=clWhite;    // la couleur de transparence est blanche
    Transparent:=true;

    // hint - sert � identifier le composant si on fait clic droit.
    s:=trains[rang].nom_train+' @='+intToSTR(trains[rang].adresse);
    Hint:=s;
    showHint:=true;

    //refresh;
    Picture.Bitmap.Modified:=True;
  end;

  s:=trains[rang].nom_train;
  // si un bloc usb est affect� � un train
  for i:=1 to 10 do
  begin
    if blocUSB[i].AffTrain=s then
    begin
      labelBlocUSB[rang].Caption:='Bloc USB '+intToSTR(i);
    end;

  end;
end;


// affiche les signaux dans la fen�tre de droite
procedure Affiche_signaux;
var i : integer;
begin
  //Affiche('SIG='+intToSTR(Formprinc.ScrollBoxSig.Width),clYellow);
  //Application.ProcessMessages;
  i:=(Formprinc.ScrollBoxSig.Width div (largImg+2))-1 ;
  if (i<=0) then exit;
  NbreImagePLigne:=i;
  for i:=1 to NbreSignaux do
  begin
    if Signaux[i].Img<>nil then
    begin
      with Signaux[i].img do
      begin
        Top:=(HtImg+espY+20)*((i-1) div NbreImagePLigne);   // d�termine les points d'origine
        Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
        //repaint;
      end;

      with Signaux[i].lbl do
      begin
        Top:=HtImg+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
        Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
        //repaint;
      end;

      if Signaux[i].FeuBlanc then
      with Signaux[i].checkFB do
      begin
        Top:=HtImg+15+((HtImg+EspY+20)*((i-1) div NbreImagePLigne));
        Left:=10+ (LargImg+5)*((i-1) mod (NbreImagePLigne));
        //repaint;
      end;
    end;
    //else
    //  Affiche('Anomalie donn�es du signal '+intToSTR(signaux[i].adresse),clred);
  end  ;
  //Affiche('FinSIG',clyellow);
end;

// affiche les compteurs dans la fen�tre de droite
procedure Affiche_CompteursT;
var i : integer;
begin
  if largComptC=0 then largComptC:=150;
  i:=(Formprinc.ScrollBoxC.Width-formprinc.trackBarZC.width+10) div (LargComptC) ;
  if (i<=0) then exit;
  NbreCompteursPLigne:=i;
  for i:=1 to ntrains do
  begin
    if CompteurT[i].gb<>nil then
    begin
      with compteurT[i].gb do
      begin
        Top:=(height+5)*((i-1) div NbreCompteursPLigne);   // d�termine les points d'origine
        //Affiche('Top='+intToSTR(top),clred);
        Left:=(LargComptC+5)*((i-1) mod (NbreCompteursPLigne));
        //repaint;
      end;
    end;
  end;
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

function tablo_HEX(s: TchaineBIN) : string;
var i : integer;
    sa_hex: string;
begin
  sa_hex:='';
  for i:=1 to long_recue do
  begin
    sa_hex:=sa_hex+IntToHex(chaine_recue[i],2)+' ';
  end;
  tablo_HEX:=sa_hex;
end;

// temporisation en x 100 ms (0,1 s)
procedure Tempo(ValTemps : integer);
var i : longint;
begin
  temps:=Valtemps;
  i:=0;
  repeat
    inc(i);
    Application.ProcessMessages;
  until (temps<=0) or (i>5000000);
  if i>5000000 then Affiche('Erreur temporisation',clred);
end;

// tempo en ValTemps x100ms
procedure tempo2(ValTemps : integer);
var Tc,seuil: Cardinal;
begin
  Tc:=GetTickCount;
  Seuil:=ValTemps*100;
  repeat
    Application.ProcessMessages;
  until Cardinal(GetTickCount-Tc)>Seuil;
end;

// envoi d'une cha�ne � l'interface par USB ou socket, puis attend l'ack ou le nack
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
    until fermeSC or ack or nack or (tempo>(TimoutMaxInterface*3)); // l'interface r�pond < 5s en mode normal et 1,5 mn en mode programmation
    if not(ack) or nack then
    begin
      s:='Pas de r�ponse de l''interface';
      Affiche(s,clRed);
      if traceTrames then AfficheDebug(s,clred);
      inc(pasreponse);
    end;
    if ack then begin pasreponse:=0;hors_tension:=false;end;
  end;
  envoi:=ack;
end;

// ins�re l'id pour le serveur CDM dans une cha�ne
function place_id(s : string) : string;
begin
  delete(s,5,2);
  insert(id_cdm,s,5);
  place_id:=s;
end;

// cha�ne pour une fonction F � un train via CDM
Function chaine_CDM_Func(fonction,etat : integer;train : string) : string;
var so,sx,s : string;
begin
  {  exemple de commande envoy�e au serveur CDM pour une fonction
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=nomdutrain;FXnumfonction=etat;
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=train;FX0=0;
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=train;FX1=0;
  C-C-00-0002-CMDTRN-DCCSF|047|02|NAME=train;FX0=1;FX1=1;FX2=1;FX3=1;
  maxi=C-C-00-0002-CMDTRN-DCCSF|111|15|NAME=train;FX0=1;FX1=1;FX2=1;FX3=1;FX4=0;FX5=0;FX6=0;FX7=0;FX8=0;FX9=0;FX10=0;FX11=0;FX12=0;FX13=0;
  }
  so:=place_id('C-C-01-0004-CMDTRN-DCCSF');
  s:='NAME='+train+';';
  s:=s+'FX'+intToSTR(fonction)+'='+intToSTR(etat)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;
  chaine_CDM_Func:=so+s;
end;

// cha�ne pour vitesse train par son nom string
function chaine_CDM_vitesseST(vitesse:integer;train:string) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:='NAME='+train+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesseST:=so+s;
  //Affiche(so+s,clyellow);
  //C-C-02-0004-CMDTRN-SPEED|025|02|NAME=CC406526;UREQ=39;
end;

// renvoie une cha�ne pour vitesse train INT par son adresse
function chaine_CDM_vitesseINT(vitesse:integer;train:integer) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:='AD='+intToSTR(train)+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesseINT:=so+s;
end;

//C-C-01-0004-CMDTRN-_STOP|055|01|NAME=C-C-01-0004-CMDTRN-_STOP|017|01|NAME=CC406526;;
// renvoie une cha�ne pour vitesse train INT par son nom
function chaine_CDM_StopTrainST(train:string) : string;
var s,so,sx: string;
begin
  so:=place_id('C-C-01-0004-CMDTRN-_STOP');
  s:='NAME='+train+';';
  sx:=format('%.*d',[2,1])+'|';  // 1 param�tre
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;
  chaine_CDM_StopTrainST:=so+s;
end;

function chaine_CDM_StopTrainINT(train:integer) : string;
var s,so,sx: string;
begin
  so:=place_id('C-C-01-0004-CMDTRN-_STOP');
  s:='AD='+intToSTR(train)+';';
  sx:=format('%.*d',[2,1])+'|';  // 1 param�tre
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;
  chaine_CDM_StopTrainINT:=so+s;
end;


// renvoie une cha�ne pour piloter un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat : integer) : string;
var so,sx,s : string;
begin
 {  exemple de commande envoy�e au serveur pour manoeuvrer un accessoire
  C-C-00-0004-CMDACC-DCCAC|018|02|AD=100;STATE=1;
  "	AD: adresse (DCC) de l'aiguille
  "	AD2: adresse #2 (DCC) de l'aiguille (TJD bi-moteurs ou aiguille triples)
  "	STATE: �tat de l'aiguille
  o	0: position droite (non d�vi�e)
  o	1: d�vi� (TJD, bretelles doubles)
  o	2: d�vi� droit
  o	3: d�vi� gauche
  o	4: pos. droite #2 (TJD 4 �tats)
  o	5: pos. d�vi�e #2 (TJD 4 �tats)
  en fait seules les fonctions 1 et 2 fonctionnent...
  }
  so:=place_id('C-C-01-0004-CMDACC-DCCAC');
  s:='AD='+format('%.*d',[1,adresse])+';';
  s:=s+'STATE='+format('%.*d',[1,etat])+';';

  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_Acc:=so+s;
end;

// pr�pare une tache pour le timer
// ttache=1 : pilote accessoire...
// temporisation pour le timer avant action
// destinataire (1=CDM  2=XpressNet  3=Dccpp)
// commande : chaine de pilotage pour le destinataire
procedure tache(ttache,temporisation,destinataire : integer;commande : string);
begin
  //Affiche('Pr�pare tache'+intToSTR(pointeurTaches+1)+' destinataire='+intToSTR(destinataire),clcyan);

  if pointeurTaches>MaxTaches then
  begin
    Affiche('Nombre de taches d�pass�',clred);
    exit;
  end;

  NoTraite:=true;   // interdire le traitement pour �viter interf�rence 
  with taches[pointeurTaches+1] do
  begin
    traite:=false;
    typeTache:=Ttache;
    Tempo:=temporisation;
    dest:=destinataire;          // CDM XpressNet DCCpp
    chaine:=commande;
  end;
  inc(pointeurTaches);
  NoTraite:=false;
end;


// envoie une fonction F � une loco via CDM ou socket ou usb
// si c'est une fonction F>12 elle peut �tre envoy�e en XpressNet
procedure envoie_fonction(fonction,etat : integer;train : string);
var loco : integer;
    s : string;
begin
  if CDM_connecte and (fonction<=12) then
  begin
    s:=chaine_CDM_Func(fonction,etat,train);
    if modeTache then tache(ttacheFF,0,ttDestCDM,s) else envoi_cdm(s);
  end;

  if (portCommOuvert or parSocketLenz) then
  begin
    loco:=index_train_nom(train);
    loco:=trains[loco].adresse;
    if protocole=1 then Fonction_Loco_operation(loco,fonction,etat);
    if protocole=2 then begin Affiche('Fonction F loco pas encore implant�e',clred);end;
  end;
end;

// teste la condition d'une action
function teste_condition(action : integer) : boolean;
var condValide : boolean;
 vit,vit1,vit2,it,pa,m1,m2,hc,n,ncond,cond,etat : integer;
 tr : string;
begin
  // 1 condition - pas de cha�nage avec 1 seule condition
  condValide:=false;
  n:=Tablo_Action[action].NbCond;
  for ncond:=1 to n do
  begin
    cond:=Tablo_Action[action].tabloCond[ncond].numcondition;
    case cond of
      CondVrai : condValide:=true;
      CondFaux : condValide:=false;
      CondVitTrain :
      begin
        tr:=Tablo_Action[action].tabloCond[ncond].train;
        vit1:=Tablo_Action[action].tabloCond[ncond].vitmini;
        vit2:=Tablo_Action[action].tabloCond[ncond].vitmaxi;
        it:=index_train_nom(tr);
        if it>0 then
        begin
         vit:=Trains[it].vitesseCons;
          condvalide:=(vit>=vit1) and (vit<=vit2);
        end;
      end;
      CondPosAcc :
      begin
        vit1:=Tablo_Action[action].tabloCond[ncond].accessoire;
        vit2:=Tablo_Action[action].tabloCond[ncond].etat;
        it:=index_aig(vit1);
        if it>0 then
        begin
          pa:=aiguillage[it].position;
          if pa=const_inconnu then Affiche('Action '+intToSTR(action)+' / condition '+intToSTR(ncond)+' : position accessoire '+intToSTR(vit1)+' inconnue',clred);
          condvalide:=pa=vit2;
        end else Affiche('Action '+intToSTR(action)+' / condition '+intToSTR(ncond)+' : Aiguillage '+intToSTR(vit1)+' inconnu',clred);
      end;
      CondHorl :
      begin
        vit1:=Tablo_Action[action].tabloCond[ncond].HeureMin*60;
        vit2:=Tablo_Action[action].tabloCond[ncond].HeureMax*60;
        m1:=Tablo_Action[action].tabloCond[ncond].MinuteMin;
        m2:=Tablo_Action[action].tabloCond[ncond].MinuteMax;
        vit1:=vit1+m1;
        vit2:=vit2+m2;
        hc:=heure*60+minute;
        condValide:=(hc>=vit1) and (hc<=vit2);
      end;
      condTrainSig :
      begin
        vit1:=Tablo_Action[action].tabloCond[ncond].adresse;
        tr:=Tablo_Action[action].tabloCond[ncond].train;
        it:=index_Signal(vit1);
        if it=0 then begin Affiche('Action '+intToSTR(action)+' / condition '+intToSTR(ncond)+' signal '+intToSTR(vit1)+' inconnu',clred);exit;end;
        vit1:=signaux[it].Adr_det1;
        condValide:=detecteur[vit1].Train=tr;
      end;
      condFonction :
      begin
        adr:=Tablo_Action[action].tabloCond[ncond].adresse;  // num�ro de fonction
        condValide:=evalue_fonction(adr,tr);
      end;
      condBouton :
      begin
        adr:=Tablo_Action[action].tabloCond[ncond].adresse;  // num�ro de bouton
        condValide:=false;
        if (adr>1) or (adr<=MaxMemoires) then condValide:=boutonTCO[adr].etat=1;
      end;
      condMemoireEgal :
      begin
        adr:=Tablo_Action[action].tabloCond[ncond].adresse;  // num�ro de m�moire
        etat:=Tablo_Action[action].tabloCond[ncond].etat;
        condValide:=false;
        if (adr>1) or (adr<=MaxMemoires) then condValide:=memoire[adr]=etat;
      end;
      condMemoireInf :
      begin
        adr:=Tablo_Action[action].tabloCond[ncond].adresse;  // num�ro de m�moire
        etat:=Tablo_Action[action].tabloCond[ncond].etat;
        condValide:=false;
        if (adr>1) or (adr<=MaxMemoires) then condValide:=memoire[adr]<etat;
      end;
      condMemoireSup :
      begin
        adr:=Tablo_Action[action].tabloCond[ncond].adresse;  // num�ro de m�moire
        etat:=Tablo_Action[action].tabloCond[ncond].etat;
        condValide:=false;
        if (adr>1) or (adr<=MaxMemoires) then condValide:=memoire[adr]>etat;
      end;
    end;
  end;
  result:=condValide;
end;


// appell� par le hooker clavier
function traite_code_blocUSB(code: integer) : integer;
var vitesse,f,n,i : integer;
    condValide,EtatValide,BlocSelec : boolean;
    s : string;
begin
  if VisuIntercepte then Affiche('It='+intToSTR(code)+' '+char(code),cllime);
  // bouton rotatif en mode multim�dia=109 = -        107 = +
  BlocSelec:=true;    // le bloc USB est affect� au train s�lectionn�

  // si onglet config bloc usb affich�
  if tsbouton then
  begin
    formConfig.LabelCode.Caption:=intToSTR(code)+' '+char(code);

    if (code=blocUSB[NumBlocUSB].rotatifM) or
       (code=blocUSB[NumBlocUSB].rotatifP) or
       (code=blocUSB[NumBlocUSB].clic) then clic_BRM;
    result:=255;
    exit;
  end;

  //pos:=formprinc.trackBarVit.Position;
  //vitesse:=trains[idTrainClic].vitesseCons;

  result:=0;
  for i:=1 to 10 do // balayer les 10 blocs
  begin
    s:=lowercase(blocUSB[i].AffTrain);
    // si bloc usb pas affect� � un train
    if (s='') or (pos('pas d',s)<>0) then
    begin
      idTrainUSB:=IdTrainClic   // index du train cliqu�
    end
    else
    begin
      // le bloc USB est affect� au train s
      idtrainUSB:=Index_train_nom(s);
      {if idTrain<>idTrainClic then
      begin
        // le train cliqu� n'est pas celui du bloc USB
        BlocSelec:=false;    // ne pas traiter au compteur car train s�lec diff�rent
      end; }
    end;
    vitesse:=trains[idTrainUSB].vitesseCons;
    // rotation moins -------------------------------
    // ne pas envoyer de consigne de vitesse ici, passer la demande dans "tempoblocUSB" pour le timer1
    // sinon ca d�valide le hook clavier au bout d'un certain temps !
    if code=blocUSB[i].rotatifM then
    begin
      if vitesse>-128 then
      begin
        trains[idTrainUSB].vitesseBlocUSB:=vitesse;
        if vitesse-blocUSB[i].increment<-128 then trains[idTrainUSB].vitesseBlocUSB:=-128
        else
          dec(trains[idTrainUSB].vitesseBlocUSB,blocUSB[i].increment);
        //Affiche('IdTrain='+intToSTR(idTrainUSB)+' vitesse'+IntToSTR(trains[idTrainUSB].vitesseBlocUSB),clYellow);
        if BlocSelec then tempoBlocUSB:=2  // affichage du compteur
        else
        begin
          // si le compteur n'est pas celui du train s�lectionn�, envoyer la consigne du train en direct
          trains[idTrainUSB].vitesseCons:=trains[idTrainUSB].vitesseBlocUSB;
          idTrainF3:=idTrainUSB;
          TempoBlocUSB:=3;   // demande consigne vitesse pour idTrainF3
        end;
      end;
      result:=255;      // pas de transmission de la touche - � windows
      exit;
    end
    else
    // rotation plus -------------------------------
    if code=blocUSB[i].rotatifP then
    begin
      if vitesse<127 then
      begin
        //Affiche('Avant IdTrain='+intToSTR(idTrain)+' vitesse'+IntToSTR(vitesse),clYellow);
        trains[idTrainUSB].vitesseBlocUSB:=vitesse;
        if vitesse+blocUSB[i].increment>127 then trains[idTrainUSB].vitesseBlocUSB:=127
        else
          inc(trains[idTrainUSB].vitesseBlocUSB,blocUSB[i].increment);

          if blocSelec then tempoBlocUSB:=2
          else
          begin
            trains[idTrainUSB].vitesseCons:=trains[idTrainUSB].vitesseBlocUSB;
            //Affiche('IdTrain='+intToSTR(idTrain)+' vitesse'+IntToSTR(trains[idTrain].vitesseBlocUSB),clYellow);
            idTrainF3:=idTrainUSB;
            TempoBlocUSB:=3;   // demande consigne vitesse pour idTrainF3
          end;
      end;
      result:=255;  // pas de transmission de la touche + � windows
      exit;
    end
    else
    // clic -------------------------------
    if code=blocUSB[i].clic then
    begin
      //formprinc.trackBarVit.Position:=0;
      //trains[idTrainClic].vitesseCons:=0;
      trains[idTrainUSB].vitesseBlocUSB:=0;
      if BlocSelec then TempoBlocUSB:=1
      else
      begin
        trains[idTrainUSB].vitesseCons:=trains[idTrainUSB].vitesseBlocUSB;
        idTrainF3:=idTrainUSB;
        TempoBlocUSB:=3;   // demande consigne vitesse pour idTrainF3
      end;
      result:=255;
      exit;
    end
    else
    // Fonction F -------------------------------
    if code=blocUSB[i].Bp1 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp1; // num�ro de fonction F
      n:=blocUSB[1].Fnp1;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B1 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp2 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp2; // num�ro de fonction F
      n:=blocUSB[1].Fnp2;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B2 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp3 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp3; // num�ro de fonction F
      n:=blocUSB[1].Fnp3;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B3 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp4 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp4; // num�ro de fonction F
      n:=blocUSB[1].Fnp4;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B4 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp5 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp5; // num�ro de fonction F
      n:=blocUSB[1].Fnp5;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B4Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp6 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp6; // num�ro de fonction F
      n:=blocUSB[1].Fnp6;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B6 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp7 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp7; // num�ro de fonction F
      n:=blocUSB[1].Fnp7;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B7 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
    else
    if code=blocUSB[i].Bp8 then
    begin
      if not(BlocSelec) then
      begin
        result:=255;
        exit;
      end;
      f:=blocUSB[1].Fbp8; // num�ro de fonction F
      n:=blocUSB[1].Fnp8;
      s:=trains[IdTrainUSB].nom_train;
      Affiche('B8 Fonction F'+intToSTR(f)+' � '+intToSTR(n)+' train '+s,clWhite);
      envoie_fonction(f,n,s);
      result:=255;
      exit;
    end
  end;

  // d�clencheur touche
  // si onglet config affich�
  if (formConfig=nil) then exit;
  if formConfig.showing then exit;
  i:=1;
  repeat
    if Tablo_Action[i].declencheur=declClavier then
    begin
      etatValide:=tablo_Action[i].adresse=code;
      condvalide:=teste_condition(i);
      if condValide and etatValide then
      begin
        //Affiche('Action dans EventAct',clred);
        if not(Diffusion) then Affiche('CCC Action '+intToSTR(i),clred);
        result:=255;
        action(i); // ex�cute toutes les op�rations de l'actionneur i
      end;
    end;
    inc(i);
  until (i>maxTablo_act);
end;


// fonction hook clavier de bas niveau (LL) appell�e par appui ou relache sur une touche
// cette fonction intercepte tous les �v�nements clavier (pas les touches de fonctions [hotkeys]) windows quelque soit la fenetre ou le prog activ�.
// https://learn.microsoft.com/en-us/previous-versions/windows/desktop/legacy/ms644984(v=vs.85)?redirectedfrom=MSDN
// https://learn.microsoft.com/fr-fr/windows/win32/api/winuser/ns-winuser-kbdllhookstruct
function ClavierHookLLProc(Code : integer; WordParam : wparam; LongParam: lparam) : longint;
const LLKHF_UP=$0080;       // masque pour touche enfonc�e
var
  KeyState : TKeyboardState;
  NewChar: array[0..1] of Char;
  Hook : PkbDllHookStruct;
  codeTouche,r : integer;
begin
  r:=99;
  //Affiche('Code='+IntToHex(Code,2)+' WordParam='+IntToHex(WordParam,4)+' LongParam='+intTohex(Longparam,16),clWhite);

  if (Code<0) or (Code=HC_NOREMOVE) then
  begin
    // pr�conisation windows
    Result:=CallNextHookEx(KBHook,Code,wordparam,longparam);
    exit;
  end;

  Hook:=Pointer(longParam);
  if Code=HC_ACTION then
  begin
    //Affiche('code='+intToHex(Hook^.flags,2),clYellow);
    If (Hook^.flags and LLKHF_UP)=0 Then // si appui touche (pas relache)
    begin
      FillChar(NewChar,2,#0);
      if GetKeyboardState(KeyState) then
      begin
       //provoque exception si on fait ctrl home dans delphi donc mis en commentaire
       { KeyState[VK_CAPITAL]:=GetKeyState(VK_CAPITAL);
        KeyState[VK_SHIFT]:=GetKeyState(VK_SHIFT);
        KeyState[VK_CONTROL]:=GetKeyState(VK_CONTROL);
        KeyState[VK_MENU]:=GetKeyState(VK_MENU); }
        //Affiche('passe',clLime);
        If ToAscii(Hook^.vkCode,Hook^.scanCode,KeyState,NewChar,0)=1 then
        begin
          codeTouche:=ord(NewChar[0]);
          //Affiche('B='+intToSTR(codeTouche),clLime);
          r:=traite_code_blocUSB(codeTouche);
          if formprinc.Active and (r=255) then r:=255 else r:=0;
        end;
      end else Affiche('Erreur 157',clred);
    end;
    //else Affiche('action='+intToSTR(code),clLime);
  end;

  // en sortie si on renvoie <>0,la touche n'est pas transmise
  callNextHookEx(kbHook,code,wordparam,longparam);
  if r=99 then result:=0 else result:=r;
end;

// active ou d�sactive une sortie par xpressnet (mode autonome, donc connect� � la centrale)
// Une adresse comporte deux sorties identifi�es par "octet"
// Adresse : adresse de l'accessoire
// octet : num�ro (1-2) de la sortie � cette adresse
// etat  : false (d�sactiv�) true (activ�)
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
  if protocole=2 then Affiche('D1: Commande DCC++ pas encore implant�e',clred);
end;

// envoie un octet 1 ou 2 � l'adresse DCC en Xpressnet, sans remise � 0 de l'adresse
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
  if protocole=2 then Affiche('D2: Commande DCC++ pas encore implant�e',clred);
end;

// renvoie les �tats de la loco en fa, fb, apr�s r�ception de la trame
// loco : adresse de la loco
procedure demande_etat_loco(loco : integer);
var ah,al : integer;
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
{      i:=0;
      repeat
        inc(i);
        Sleep(100);
        Application.ProcessMessages;
      until (fa<>256) or (i=10);   }
    end;
    if protocole=2 then Affiche('D3: Commande DCC++ pas encore implant�e',clred);
  end;
end;

// envoie une fonctionF � une loco en Xpressnet
// loco=adresse de la loco  fonction de 0 � 28 �tat 0/1
procedure Fonction_Loco_Operation(loco,fonction,etat : integer);
var s : string ;
    ah,al : integer;
    b,c : byte ;
begin
  if (fonction<0) or (fonction>28) or (loco<0) or (loco>9999) then exit;
  if portCommOuvert or parSocketLenz then
  begin
    if protocole=1 then   // protocole XpressNet
    begin
      demande_etat_loco(loco);    // r�cup�re les �tats des fonctions Fa=F0 � 4 Fb=F5 � F12 AdrTrain
      //Affiche('Train='+IntToSTR(AdrTrain)+' '+IntToHex(fa,2)+' '+IntToHex(fb,2),clyellow);
      // en fonction du d�codeur, on n'a pas le bon train!!
      if (fa<>256) then
      begin
        s:=#$E4;
        if fonction<=4 then s:=s+#$20;
        if (fonction>=5) and (fonction<=8) then s:=s+#$21;
        if (fonction>=9) and (fonction<=12) then s:=s+#$22;
        if (fonction>=13) and (fonction<=20) then s:=s+#$23;    // rang 23 non document�e
        if (fonction>=21) and (fonction<=28) then s:=s+#$28;    // rang 28 non document�e
        //  codification de l'adresse de la loco : doc Xpressnet page 40 (�2.1.15)
        if loco<99 then begin Ah:=0;Al:=loco;end
        else begin ah:=((loco or $C000) shr 8);al:=loco and 255;end;
        s:=s+char(ah)+char(al);
        // codification de la fonction : doc Xpressnet page 64 {�2.2.20.5)
        if etat<>0 then
        begin
          case fonction of
            0           : b:=fa or setbit(0,4);
            1,2,3,4     : b:=fa or setbit(0,fonction-1);         // fa est align� avec l'octet de demande
            5,6,7,8     : b:=fb or setbit(0,fonction-5);         // fa est align� avec l'octet de demande
            9,10,11,12  : b:=(fb shr 4) or setbit(0,fonction-9); // fa est d�cal� � gauche de 4 avec l'octet de demande
          end;
          if (fonction>=13) and (fonction<=20) then b:=(fb shr 8) or setbit(0,fonction-13);   // non doc
          if (fonction>=21) and (fonction<=28) then b:=(fb shr 8) or setbit(0,fonction-21);   // non doc
        end
        else
        begin
          case fonction of
            0           : b:=fa and razbit(255,4);               // fa est align� avec l'octet de demande
            1,2,3,4     : b:=fa and razbit(255,fonction-1);      // fa est align� avec l'octet de demande
            5,6,7,8     : b:=fb and razbit(255,fonction-5);
            9,10,11,12  : b:=(fb shr 4) and razbit(255,fonction-9);
          end;
          if (fonction>=13) and (fonction<=20) then b:=(fb shr 8) or razbit(255,fonction-13);   // non doc
          if (fonction>=21) and (fonction<=28) then b:=(fb shr 8) or razbit(255,fonction-21);   // non doc
        end;
        s:=s+char(b);
        s:=checksum(s);
        tache(ttacheFF,0,ttDestXpressNet,s)
        //envoi(s);
      end;
    end;
    if protocole=2 then  // protocole DCC
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
        b:=160;     // 1010 0000
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
      tache(ttacheFF,0,ttDestDccpp,s)
      //envoi_ss_ack(s);  // pas d'ack sur les fonctions F
    end;
  end;
end;

// loco=adresse de la loco  fonction de 0 � 12 �tat 0/1
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
      //  codification de l'adresse de la loco : doc Xpressnet page 40 (�2.1.15)
      if loco<99 then begin Ah:=0;Al:=loco;end
      else begin ah:=((loco and $FF00) + $C000) shr 8;al:=loco and 255;end;
      s:=s+char(ah)+char(al);
      // codification de la fonction : doc Xpressnet page 64 {�2.2.20.5)
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
    if protocole=2 then Affiche('D5: Commande DCC++ pas encore implant�e',clred);
  end;
end;

// envoie une vitesse � une loco par XpressNet/Dcc++ ou par CDM
// index=index du train dans le tableau trains[]
// sens en fonction du sens dans le tableau train ou vitesse positive ou n�gative
// r�p�tition=avec r�p�tition de la commande dans 1s
//
// Pilotage de l'inversion de vitesse (or 128)
//
//                     vitesse   vitesse
// trains[].inverse     <0        >=0
//       faux           non       oui
//       vrai           oui       non
//  inversion train[].inverse xor (vitesse>=0)
// proc�dure : si ActionVitesse vient de ActionVitesse
// si consigneBLocUSB on vient d'une consigne par bloc usb
procedure vitesse_loco(nom_train :string;index : integer;adr_loco : integer;vitesse : integer;repetition,proc : integer);
var s : string;
    v,erreur : integer;
    sc : boolean;
begin
  if (index=0) and (adr_loco=0) then adr_loco:=index_train_nom(nom_train);
  if (index=0) and (adr_loco<>0) then index:=index_train_adresse(adr_loco);
  if (s='') and (index<>0) then nom_train:=trains[index].nom_train;

  //if debugRoulage then Affiche('Vitesse train @'+inttostr(adr_loco)+'='+inttostr(vitesse),clLime);

  sc:=true; // stocker vitesse dans trains[].vitessecons

  // mettre � jour la trackBar et edit si le train s�lectionn�=editAdrTrain
  val(Formprinc.EditAdrTrain.Text,v,erreur);
  if (v=adr_loco) then
  begin
    pasChgTBV:=true; // �vite de repositionner la trackbar
    //Formprinc.TrackBarVit.Position:=vitesse;
    //formprinc.EditVitesse.text:=intToSTR(vitesse);
    pasChgTBV:=false;
  end;

  if not(hors_tension) and ((portCommOuvert or parSocketLenz)) then
  begin
    sc:=true;
    if protocole=1 then
    begin
      //AfficheDebug('X9 train '+inttostr(loco)+' '+inttostr(vitesse),clOrange);
      v:=vitesse;
      if v>127 then v:=127;
      if v<-128 then v:=-128;
      v:=abs(v);
      if (trains[index].inverse) xor (vitesse>=0) then v:=v or 128;
      s:=#$e4+#$13+#$0+char(adr_loco)+char(v);
      s:=checksum(s);
      if modetache then tache(ttacheVit,0,ttDestXpressNet,s)  // TypeTache,tempo,destinataire,chaine
      else
        if avecAck then envoi(s) else envoi_ss_ack(s);
    end;
    if protocole=2 then
    begin
      s:='<t 1 '+intToSTR(adr_loco)+' '+intToSTR(vitesse)+' ';
      if (trains[index].inverse) xor (vitesse>=0) then s:=s+'1>' else s:=s+'0>';
      if modetache then tache(ttacheVit,0,ttDestDccpp,s)  // TypeTache,tempo,destinataire,chaine
      else
        if avecAck then envoi(s) else envoi_ss_ack(s);
    end;

    LabelVitesse[index].Caption:=IntToSTR(vitesse);

  end;

  if cdm_connecte then
  begin
    sc:=false;
    // il faut qu'on soit en RUN pour que les vitesses des trains soient prises en compte
    // pour arr�ter un train dans CDM, envoyer une consigne nulle ne suffit pas, il faut envoyer un _STOP
    if PilotageTrainsCDMNom then
      s:=chaine_CDM_vitesseST(vitesse,nom_train)  // par nom du train
    else
      s:=chaine_CDM_vitesseINT(vitesse,adr_loco);  // par adresse du train : ne marche pas toujours!!!

    //Affiche('COMIP='+s,clWhite);
    if modetache then tache(ttacheVit,0,ttDestCDM,s) else  // TypeTache,tempo,destinataire,chaine
      envoi_CDM(s);

    if vitesse=0 then
    begin
      if PilotageTrainsCDMNom then
        s:=chaine_CDM_StopTrainST(nom_train)
      else
        s:=chaine_CDM_StopTrainINT(adr_loco);
      if modetache then tache(ttacheVit,0,ttDestCDM,s) else  // TypeTache,tempo,destinataire,chaine
        envoi_CDM(s);
    end;
  end;

  // r�p�tition de la consigne dans x s
  if repetition<>0 then
  begin
    trains[index].compteur_consigne:=repetition;
  end;

  // on stocke la vitesse qu'en mode autonome ou non connect�.
  // en mode CDM on ne la stocke pas, elle sera stock�e par un event_vitesse.
  if sc then trains[index].vitesseCons:=vitesse;

  //Affiche('Mesure vitesse train '+nom_train+' = '+intToSTR(vitesse),clWhite);
  if (proc<>ActionVitesse) and (proc<>consigneBlocUSB) then event_vitesse(adr_loco,nom_train,vitesse);  // si on vient pas d'une action vitesse
end;


procedure Maj_Etat_Signal_Belge(adresse,aspect : integer);
var i : integer;
    etats : word;
// La signalisation combin�e belge est � partir du bit 10 (chiffre, chevron)
begin
  if debug=3 then formprinc.Caption:='Maj_Etat_Signal '+IntToSTR(adresse)+' '+intToSTR(aspect);
  i:=Index_Signal(adresse);
  begin
    // signalisation de base
    if aspect<=$3f then
    begin
      // razer tous les bits non combin�s
      etats:=Signaux[i].EtatSignal and not($3F);
      // et allumer le nouveau
      etats:=setbit(etats,aspect);
      Signaux[i].EtatSignal:=etats;
    end;
    // signalisation combin�e
    if (aspect and $1C0)<>0 then
    begin
      etats:=Signaux[i].EtatSignal;
      //si le bit 15 (bita1) est � 1, c'est l'indicateur de mise � 1
      if testBit(aspect,bita1) then
      begin
         etats:=etats or (aspect and $1C0);   // mise � 1 par masquage
         Signaux[i].EtatSignal:=Signaux[i].EtatSignal or etats;
      end
      else
      begin
        etats:=etats and not(aspect and $1c0); // mise � 0 par masquage
        Signaux[i].EtatSignal:=Signaux[i].EtatSignal and etats;
      end;
    end;
  end;
end;

// mise � jour �tat signal complexe francais dans le tableau de bits du signal EtatSignalCplx
// adresse : adresse du signal complexe
// Aspect : code repr�sentant l'�tat du signal de 0 � 15
// La signalisation combin�e est � partir du bit 10 (ralen 30)
procedure Maj_Etat_Signal_fr(adresse,aspect : integer);
var i : integer;
begin
// ('0carr�','1s�maphore','2s�maphore cli','3vert','4vert cli','5violet',
//           '6blanc','7blanc cli','8jaune','9jaune cli','10ral 30','11ral 60','12rappel 30','13rappel 60');

  if debug=3 then formprinc.Caption:='Maj_Etat_Signal '+IntToSTR(adresse);
  i:=Index_Signal(adresse);
  if testBit(Signaux[i].EtatSignal,aspect)=false then  // si le bit dans l'�tat du signal n'est pas allum�, proc�der.
  begin
    // effacement du motif de bits en fonction du nouvel �tat demand� suivant la r�gle des signaux complexes
    if (aspect<=blanc_cli) then
    begin
      Signaux[i].EtatSignal:=0;  //Tout aspect <=7 efface les autres
    end;
    if (aspect=jaune) then // jaune
    begin
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,jaune_cli); // cas du jaune: efface le bit du jaune clignotant (bit 9)
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,ral_30);  // cas du jaune: efface le bit du ral_30 (bit 10)
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,ral_60);  // cas du jaune: efface le bit du ral_60 (bit 11)
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($00FF);   // et effacer les bits 0 � 7
    end;
    if (aspect=jaune_cli) then // jaune clignotant
    begin
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,jaune);   // efface le bit du jaune  (bit 8)
      Signaux[i].EtatSignal:=RazBit(Signaux[i].EtatSignal,ral_30);  // efface ral 30
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and $FF00;   // et effacer les bits 0 � 7
    end;
    if (aspect=ral_30) then // ralentissement 30
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($3BFF);   // cas du ral 30: efface les bits 0 1 2 3 4 5 6 7 8 9 11 12 et 13 :  11 1000 1111 1111
    end;
    if (aspect=ral_60) then // ralentissement 60
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($35FF);   // cas du ral 60: efface les bits 8 10 12 et 13 et de 0 � 7  : 11 0100 1111 1111
    end;
    if (aspect=rappel_30) then // rappel 30
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($2cff);   // cas du rappel 30: efface les bits 0 1 2 3 4 5 6 7 10 11 et 13 : 10 1100 1111 0000
    end;
    if (aspect=rappel_60) then // rappel 60
    begin
      Signaux[i].EtatSignal:=Signaux[i].EtatSignal and not($1cff);   // cas du rappel 60: efface les bits 0 1 2 3 4 5 6 7 10 11 et 12  1 1100 1111 0000
    end;
    if (aspect=aspect8) then // ral_60_jaune_cli d�codeur LDT
    begin
      Signaux[i].EtatSignal:=jaune_cli_F or ral_60_F;   // cas du ralentissement 60 + avertissement clignotant : efface les bits 10 11 et 12
    end;
    if (aspect<>aspect8) then
    begin
      Signaux[i].EtatSignal:=SetBit(Signaux[i].EtatSignal,aspect);   // allume le num�ro du bit de la fonction du signal
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
envoie les donn�es au d�codeur digital bahn �quip� du logiciel "led_schalten"
sur un panneau directionnel - adresse : adresse du signal - code de 1 � 3 pour allumer
; le panneau directionnel � 1, 2 ou 3 leds.
============================================== }
procedure envoi_directionBahn(adr : integer;code : integer);
var i : integer;
begin
  i:=Index_Signal(adr);
  if (Signaux[i].EtatSignal<>code) then
  begin
    if (AffSig) then Affiche('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);
    if AffSignal then AfficheDebug('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);

    case code of
    0 :  begin      pilote_acc(adr,1,signal);   // sortie 1 � 0
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+1,1,signal); // sortie 2 � 0
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+2,1,signal); // sortie 3 � 0
                    if not modetache then sleep(Tempo_Signal);
         end;
    1 :  begin      pilote_acc(adr,2,signal);   // sortie 1 � 1
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+1,1,signal); // sortie 2 � 0
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+2,1,signal); // sortie 3 � 0
                    if not modetache then sleep(Tempo_Signal);
          end;
    2 :  begin      pilote_acc(adr,2,signal);   // sortie 1 � 1
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+1,2,signal); // sortie 2 � 1
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+2,1,signal); // sortie 3 � 0
                    if not modetache then sleep(Tempo_Signal);
          end;
    3 :  begin      pilote_acc(adr,2,signal);   // sortie 1 � 1
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+1,2,signal); // sortie 2 � 1
                    if not modetache then sleep(Tempo_Signal);
                    pilote_acc(adr+2,2,signal); // sortie 3 � 1
                    if not modetache then sleep(Tempo_Signal);
          end;
    end;
    Signaux[i].EtatSignal:=code;
    Dessine_signal_mx(Signaux[Index_Signal(adr)].Img.Canvas,0,0,1,1,adr,1);
  end;
end;

{ =============================================
envoie les donn�es au signal de direction pour un d�codeur CDF
adresse : adresse du signal - code de 1 � 3 pour allumer
le panneau directionnel � 1, 2, 3 ou 4 leds.
============================================== }
procedure envoi_directionCDF(adr : integer;code : integer);
var i : integer;
begin
  i:=Index_Signal(adr);
  if (Signaux[i].EtatSignal<>code) then
  begin
    if AffSig then Affiche('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
    if AffSignal then AfficheDebug('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

    case code of
      // �teindre toutes les leds
    0 :
      begin
        pilote_acc(adr,1,signal) ;
        if not modetache then sleep(200);
      end;
      // code 1 : allume le feu le plus � gauche
    1 :
      begin
        pilote_acc(adr,2,signal) ;
        if not modetache then sleep(200);
      end;
    2 : //allume 2 feux
      begin
        pilote_acc(adr+1,1,signal) ;
        if not modetache then sleep(200);
      end;
      // code 3 : allume 3 feux
    3 :
      begin
        pilote_acc(adr+1,2,signal) ;
        if not modetache then sleep(200);
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
    if AffSig then Affiche('signal directionnel LEB: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
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
envoie les donn�es au d�codeur CDF
===========================================================================*}
procedure envoi_CDF(adresse : integer);
var
  combine,aspect,code,i,nombre: integer;
  s : string;

  // envoi les bits 0 � 3
  procedure Xecrire(v : integer);
  var j : integer;
  begin
    // bit 0 � 3
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

  // envoi les bits 0 � 7
  procedure Xecrire_2(v : integer);
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

  // envoie les bits 0 � n en fonction du nombre maxi 7
  procedure ecrire_3(v : integer);
  var bit2 : integer;
  begin
    // adresse+0
    if (nombre>0) then
    begin
      bit2:=v and 3;  //0000 0011
      if bit2<>0 then
      begin
        {if bit2=3 then
        begin
          pilote_acc(adresse,1,signal);
          pilote_acc(adresse,2,signal);
        end
        else }
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
        {if bit2=$c then
        begin
          pilote_acc(adresse+1,1,signal);
          pilote_acc(adresse+1,2,signal);
        end
        else }
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
        {if bit2=$30 then
        begin
          pilote_acc(adresse+2,1,signal);
          pilote_acc(adresse+2,2,signal);
        end
        else }
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
        {if bit2=$c0 then
        begin
          pilote_acc(adresse+3,1,signal);
          pilote_acc(adresse+3,2,signal);
        end
        else}
        pilote_acc(adresse+3,bit2 shr 6,signal);
      end;
    end;
  end;

begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    nombre:=Signaux[i].Na;          // nombre d'adresses occup�es par le signal
    code_to_aspect(code,aspect,combine);
    s:='Signal CDF: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

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

    begin
      case combine of
        ral_30        : ecrire_3(Signaux[i].SR[11].sortie1);
        ral_60        : ecrire_3(Signaux[i].SR[12].sortie1);
        rappel_30     : ecrire_3(Signaux[i].SR[13].sortie1);
        rappel_60     : ecrire_3(Signaux[i].SR[14].sortie1);
      end;
      exit;
    end;
    exit;
  end;
end;

procedure envoi_LEA(adresse:integer);
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
    s:='Signal LEA: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    etat:=code_to_etat(code);    // transforme le motif de bits en �tat de 1 � 19
    nAdr:=Signaux[index].Na;     // nombre d'asdresses du signal

    if index<>0 then
    begin
      i:=0;
      // trouve l'index dans la configuration du signal correspondant � son �tat demand�
      repeat
        inc(i);
        s0:=Signaux[index].SR[i].sortie0=etat;
        s1:=Signaux[index].SR[i].sortie1=etat;
      until s1 or s0 or (i=8) or (i=nAdr);

      if s1 then
      begin
        //affiche('trouv� en sortie1 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,1,signal);
      end;
      if s0 then
      begin
        //affiche('trouv� en sortie0 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,2,signal);
      end;
      if not(s0) and not(s1) then
        Affiche('Erreur 622 : d�codeur LEA du signal '+intToSTR(adresse)+': pas trouv� l''�tat demand� '+chaine_signal(adresse)+' dans sa configuration',clOrange);
    end;
  end;
end;


{==========================================================================
envoie les donn�es au d�codeur SR
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
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    etat:=code_to_etat(code);    // transforme le motif de bits en �tat de 1 � 19
    nAdr:=Signaux[index].Na;

    if index<>0 then
    begin
      i:=0;
      // trouve l'index dans la configuration du signal correspondant � son �tat demand�
      repeat
        inc(i);
        s0:=Signaux[index].SR[i].sortie0=etat;
        s1:=Signaux[index].SR[i].sortie1=etat;
      until s1 or s0 or (i=8) or (i=nAdr);

      if s1 then
      begin
        //affiche('trouv� en sortie1 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,2,signal);
      end;
      if s0 then
      begin
        //affiche('trouv� en sortie0 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,1,signal);
      end;
      if not(s0) and not(s1) then
        Affiche('Erreur 621 : d�codeur SR du signal '+intToSTR(adresse)+': pas trouv� l''�tat demand� '+chaine_signal(adresse)+' dans sa configuration',clOrange);
    end;
  end;
end;

{==========================================================================
envoie les donn�es du signal au d�codeur LEB
===========================================================================*}
procedure envoi_LEB(adresse : integer);
var index,mode,code,aspect,cible,combine,offset,sortie : integer;
    s : string;

  // pour le mode binaire
  procedure envoi5_LEB(selection :byte);
  var i : integer;
      octet : byte;
  begin
    for i:=0 to 4 do
    begin
      if (testBit(selection,i)) then begin octet:=1;end
      else begin octet:=2 ;end;
      Pilote_acc(adresse+i,octet,signal);
      if (Cdm_connecte or portCommOuvert or parSocketLenz) then 
      begin 
        if not modetache then
        begin
          Sleep(Tempo_Signal);
          Application.ProcessMessages;
        end;
        // le d�codeur LEB n�cessite qu'on envoie 0 apr�s son pilotage
        Pilote_acc0_X(adresse+i,octet);
        if not modetache then
        begin
          Sleep(Tempo_Signal);
          Application.ProcessMessages;
        end;
      end;
    end;
  end;

begin
  index:=Index_Signal(adresse);
  if (Signaux[index].AncienEtat<>Signaux[index].EtatSignal) then //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[index].EtatSignal;
    mode:=Signaux[index].BinLin;
    cible:=Signaux[index].UniSemaf;  // num�ro de cible LEB
    code_to_aspect(code,aspect,combine);

    if not modetache then Sleep(60);  // si le signal se met � jour � la suite d'un positionnement d'aiguillage, on peut avoir le message station occup�e
    //Affiche('Aspect='+IntToSTR(aspect)+' Combine='+inttoSTR(combine),clOrange);

    // mode binaire ancien
    if (cible=100) then
    begin
      s:='Signal LEB (ancien binaire) : ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
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

    // lin�aire ou nouveau binaire
    if (cible>0) and (cible<100) then
    begin
      begin
        if (aspect<>-1) and (combine=-1) then
        begin
          case aspect of
            carre           : begin offset:=tableLEB[cible,CarreLEB].offset;sortie:=tableLEB[cible,CarreLEB].sortie;code:=tableLEB[cible,CarreLEB].code; end;
            violet          : begin offset:=tableLEB[cible,VioletLEB].offset;sortie:=tableLEB[cible,VioletLEB].sortie;code:=tableLEB[cible,VioletLEB].code; end;
            semaphore       : begin offset:=tableLEB[cible,SemaphoreLEB].offset;sortie:=tableLEB[cible,SemaphoreLEB].sortie;code:=tableLEB[cible,SemaphoreLEB].code; end;
            jaune           : begin offset:=tableLEB[cible,AvertissementLEB].offset;sortie:=tableLEB[cible,AvertissementLEB].sortie;code:=tableLEB[cible,AvertissementLEB].code; end;
            blanc           : begin offset:=tableLEB[cible,BlancLEB].offset;sortie:=tableLEB[cible,BlancLEB].sortie;code:=tableLEB[cible,BlancLEB].code; end;
            vert            : begin offset:=tableLEB[cible,VoieLibreLEB].offset;sortie:=tableLEB[cible,VoieLibreLEB].sortie;code:=tableLEB[cible,VoieLibreLEB].code; end;
            semaphore_cli   : begin offset:=tableLEB[cible,RougeCliLEB].offset; sortie:=tableLEB[cible,RougeCliLEB].sortie;code:=tableLEB[cible,RougeCliLEB].code; end;
            jaune_cli       : begin offset:=tableLEB[cible,JauneCliLEB].offset; sortie:=tableLEB[cible,JauneCliLEB].sortie;code:=tableLEB[cible,JauneCliLEB].code; end;
            blanc_cli       : begin offset:=tableLEB[cible,BlancCliLEB].offset; sortie:=tableLEB[cible,BlancCliLEB].sortie;code:=tableLEB[cible,BlancCliLEB].code; end;
            vert_cli        : begin offset:=tableLEB[cible,VertCliLEB].offset; sortie:=tableLEB[cible,VertCliLEB].sortie;code:=tableLEB[cible,VertCliLEB].code; end;
          end;
        end;
        if (aspect=-1) and (combine<>-1) then
        begin
          case combine of
            rappel_30       : begin offset:=tableLEB[cible,Rappel30LEB].offset; sortie:=tableLEB[cible,Rappel30LEB].sortie;code:=tableLEB[cible,Rappel30LEB].code;end;
            rappel_60       : begin offset:=tableLEB[cible,Rappel60LEB].offset; sortie:=tableLEB[cible,Rappel60LEB].sortie;code:=tableLEB[cible,Rappel60LEB].code;end;
            ral_30          : begin offset:=tableLEB[cible,Ralen30LEB].offset; sortie:=tableLEB[cible,Ralen30LEB].sortie;code:=tableLEB[cible,Ralen30LEB].code; end;
            ral_60          : begin offset:=tableLEB[cible,Ralen60LEB].offset; sortie:=tableLEB[cible,Ralen60LEB].sortie;code:=tableLEB[cible,Ralen60LEB].code; end;
          end;
        end;
        if (aspect<>-1) and (combine<>-1) then
        begin
          if (aspect=jaune) and (combine=rappel_30) then begin offset:=tableLEB[cible,AvertissementRappel30LEB].offset; sortie:=tableLEB[cible,AvertissementRappel30LEB].sortie;code:=tableLEB[cible,AvertissementRappel30LEB].code;end;
          if (aspect=jaune_cli) and (combine=rappel_30) then begin offset:=tableLEB[cible,JauneCliRappel30LEB].offset;  sortie:=tableLEB[cible,JauneCliRappel30LEB].sortie;code:=tableLEB[cible,JauneCliRappel30LEB].code;end;
          if (aspect=jaune) and (combine=rappel_60) then begin offset:=tableLEB[cible,AvertissementRappel60LEB].offset; sortie:=tableLEB[cible,AvertissementRappel60LEB].sortie;code:=tableLEB[cible,AvertissementRappel60LEB].code;end;
          if (aspect=jaune_cli) and (combine=rappel_60) then begin offset:=tableLEB[cible,JauneCliRappel60LEB].offset;  sortie:=tableLEB[cible,JauneCliRappel60LEB].sortie;code:=tableLEB[cible,JauneCliRappel60LEB].code;end;
          if (aspect=jaune_cli) and (combine=ral_60) then begin offset:=tableLEB[cible,JauneCliRalen60LEB].offset; sortie:=tableLEB[cible,JauneCliRalen60LEB].sortie;code:=tableLEB[cible,JauneCliRalen60LEB].code;end;
        end;

        if mode=0 then
        begin
          s:='Signal LEB (binaire) : ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
          envoi5_LEB(code);
        end;

        if mode=1 then
        begin
          s:='Signal LEB (lin�aire) : ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
          pilote_acc(adresse+offset,sortie,signal);
          Pilote_acc0_X(adresse+offset,sortie);  // remise � 0 obligatoire pour LEB
        end;
      end;
    end;

    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    {if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end; }
  end;
end;

// pilote le d�codeur arcomora
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
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    if not modetache then Sleep(60);
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
envoie les donn�es au d�codeur NMRA �tendu - ne peut pas marcher par XpressNet �videmment
       adresse=adresse sur le BUS DCC
       code=code d'allumage :
0.	Carr�
1.	S�maphore
2.	S�maphore clignotant
3.	Vert
4.	Vert clignotant
5.	Carr� violet
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
    if AffSig then affiche(s,clOrange);
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

// d�codeur unisemaf (paco)
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
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    // pour Unisemaf, la cible est d�finie dans le champ Unisemaf de la structure Tsignal

    modele:=Signaux[index].Unisemaf;
    if modele=0 then Affiche('Erreur 741 : sp�cification unisemaf signal '+intToSTR(adresse)+' non d�fini',clred);
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
      // 51=carr� + blanc
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
      // 72=VJR + carr� + ralentissement 30
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
      // 73=VJR + carr� + ralentissement 60
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
      // 91=VJR + carr� + rappel 30
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

      // 92=VJR + carr� + rappel 60
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

      // 93=VJR + carr� + ral30 + rappel 30
      if modele=93 then
      begin
        if combine=-1 then //pas de sig combin�e
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

      // 94=VJR + carr� + ral60 + rappel60
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
      // 95=VJR + carr� + ral30 + rappel 60
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
      // 96=VJR + blanc + carr� + ral30 + rappel30
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
      // 97=VJR + blanc + carr� + ral30 + rappel60
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
        // 51=carr� + blanc
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
        // 72=VJR + carr� + ralentissement 30
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
        // 73=VJR + carr� + ralentissement 60
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
        // 91=VJR + carr� + rappel 30
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

        // 92=VJR + carr� + rappel 60
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

        // 93=VJR + carr� + ral30 + rappel 30
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

        // 94=VJR + carr� + ral60 + rappel60
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
        // 95=VJR + carr� + ral30 + rappel 60
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
        // 96=VJR + blanc + carr� + ral30 + rappel30
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

        // 97=VJR + blanc + carr� + ral30 + rappel60
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

// d�codeur b-models
// l'adresse du signal doit �tre un multiple de 8 +1
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
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    na:=Signaux[i].Na;  // nombre d'adresses
    // doc VB 5 lampes + chiffre + V
    // marqu� recht et Afb dans la doc !!
    afb:=1; // afb rouge
    recht:=2; // recht vert=droit
    if aspect=rouge then
    begin
      pilote_acc(adresse,afb,signal);
      if (na>=4) then
      begin
        // chiffre                        allume                                �teint
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
envoie les donn�es au d�codeur LDT_nmbs (belge)
ce d�codeur ne permet seulement que 4 aspects !!
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
    if AffSig then affiche(s,clOrange);
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
envoie les donn�es au d�codeur LDT_sncf
       adresse=adresse sur le BUS DCC
       code=code d'allumage selon l'adressage (ex carre, vert, rappel_30 ..).
       mode=mode du d�codeur adress�, de 1 � 2
       un d�codeur occupe 8 adresses
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
    if AffSig then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;

    if (aspect=semaphore) or (aspect=vert) or (aspect=carre) or (aspect=jaune) then mode:=1 else mode:=2;
    if aspect>carre then mode:=2 else mode:=1;

    case mode of
      // pour les d�codeurs en mode 0, il faut �crire la routine vous m�me car le pilotage d�pend du cablage
      // sauf pour le s�maphore, vert et jaune fixe
    1 :       // mode 1: feux 2 3 & 4 feux
    begin
      if (aspect=semaphore) then pilote_acc(adresse,1,signal);
      if (aspect=vert)      then pilote_acc(adresse,2,signal);
      if (aspect=carre)     then pilote_acc(adresse+1,1,signal);
      if (aspect=jaune)     then pilote_acc(adresse+1,2,signal);
    end;
    2 :      // mode 2: plus de 4 feux
    begin
      if (aspect=semaphore)  then begin
                                    pilote_acc(adresse+2,1,signal);
                                    if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,1,signal);
                                  end;
      if (aspect=vert)       then begin pilote_acc(adresse+2,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end;
      if (aspect=carre)      then begin pilote_acc(adresse+2,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;
      if (aspect=jaune)      then begin pilote_acc(adresse+2,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
      if (aspect=violet)     then begin pilote_acc(adresse+2,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;
      if (aspect=blanc)      then begin pilote_acc(adresse+2,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end;
      if (aspect=semaphore)  then begin pilote_acc(adresse+2,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;
      if (combine=aspect8)   then begin pilote_acc(adresse+2,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
      if (combine=ral_60) and (aspect=jaune_cli)
                             then begin pilote_acc(adresse+3,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;  // demande groupe 3
      if (aspect=vert_cli)   then begin pilote_acc(adresse+3,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end; // demande groupe 3
      if (combine=Disque_D)  then begin pilote_acc(adresse+3,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;// demande groupe 3
      if (aspect=jaune_cli)  then begin pilote_acc(adresse+3,1,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
      if (combine=ral_30)    then begin pilote_acc(adresse+3,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,1,signal);end;
      if (combine=ral_60)    then begin pilote_acc(adresse+3,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse,2,signal);end;
      if (combine=rappel_30) then begin pilote_acc(adresse+3,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,1,signal);end;
      if (combine=rappel_60) then begin pilote_acc(adresse+3,2,signal);if not modetache then sleep(Tempo_Signal);pilote_acc(adresse+1,2,signal);end;
    end;
    end;
  end;
end;

procedure envoi_virtuel(adresse : integer);
var i,combine,aspect,code : integer;
    s : string;
begin
  i:=Index_Signal(adresse);
  if (Signaux[i].AncienEtat<>Signaux[i].EtatSignal) then  //; && (stop_cmd==FALSE))
  begin
    code:=Signaux[i].EtatSignal;
    code_to_aspect(code,aspect,combine);
    s:='Signal virtuel: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if AffSig then affiche(s,clOrange);
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

// envoie les donn�es au d�codeur digikeijs 4018
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
    nombre:=Signaux[i].Na;          // nombre d'adresses occup�es par le signal
    code_to_aspect(code,aspect,combine);
    s:='Signal digikeijs 4018: ad'+IntToSTR(adresse)+'='+chaine_signal(adresse);
    if AffSig then affiche(s,clOrange);
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
envoie les donn�es au d�codeur digitalbahn �quip� du logiciel "led_signal_10"
       adresse=adresse sur le bus
       codebin=motif de bits repr�sentant l'�tat des feux L'allumage est fait en
       adressant l'une des 14 adresses pour les 14 leds possibles du feu.
       Ici on met le bit 1 � 1 (�tat "vert" du programme hexmanipu
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
    if AffSig then affiche(s,clOrange);
    if Affsignal or traceListe then afficheDebug(s,clOrange);
    if AffDetSig then
    begin
      s:='Tick='+IntToSTR(tick)+' Signal '+IntToSTR(adresse)+'='+chaine_signal(adresse);
      AfficheDebug(s,clyellow);
    end;
    //Affiche(IntToSTR(aspect)+' '+inttoSTR(combine),clOrange);

    // sp�cifique au d�codeur digital bahn:
    // si le signal affichait un signal combin�, il faut �teindre le signal avec un s�maphore
    // avant d'afficher le nouvel �tat non combin�
    Ancralrap:=(TestBit(Signaux[i].AncienEtat,ral_30)) or (TestBit(Signaux[i].AncienEtat,ral_60)) or
               (TestBit(Signaux[i].AncienEtat,rappel_30)) or (TestBit(Signaux[i].AncienEtat,rappel_60)) ;
    // si ancien �tat du signal=jaune ou jaune cli
    Ancjau:=(TestBit(Signaux[i].AncienEtat,jaune)) or (TestBit(Signaux[i].AncienEtat,jaune_cli)) ;

    // si �tat demand� du signal=ralentissement ou rappel
    ralrap:=(TestBit(code,ral_30)) or (TestBit(code,ral_60)) or
            (TestBit(code,rappel_30)) or (TestBit(code,rappel_60)) ;
    // si �tat demand� du signal=jaune ou cli
    jau:=TestBit(code,jaune) or TestBit(code,jaune_cli) ;

    // effacement du signal combin� par s�maphore suivant condition
    if (((Ancralrap and not(ralrap)) or (Ancjau and not(jau))) and (combine<>0)) then
    begin
      if connecte then
      begin
        if not modetache then Sleep(40);
        pilote_acc(adresse+semaphore,2,signal) ;
      end;
    end;

    if not modetache then sleep(40);  // les commandes entre 2 signaux successifs doivent �tre s�par�es au minimum de 100 ms
    // affichage du premier aspect du signal(1er bit � 1 dans codebin)
    if aspect<>-1 then pilote_acc(adresse+aspect,2,signal) ;

    // affichage de la signalisation combin�e
    if (Combine<>-1) and connecte then
    begin
      if not modetache then sleep(40);
      pilote_ACC(adresse+Combine,2,signal) ;
    end;
  end;
end;

// pilote un signal par un d�codeur personnalis�
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
    // fran�ais --------------------------------------------
    begin
      if decodeur_pers[dp].nation<>1 then
      begin
        Affiche('Erreur 381 : le signal '+IntToSTR(adresse)+' est fran�ais mais son d�codeur est belge',clred);
        exit;
      end;

      // commande par centrale
      if decodeur_pers[dp].commande=0 then
      begin
        j:=1;
        code_to_aspect(etat,aspect,combine);

        // trouver l'�tat dans le d�codeur
        repeat
          if (aspect<>-1) and (combine=-1) then
          begin
            // base
            trouve1:=decodeur_pers[dp].desc[j].etat1=aspect+1;
            trouve2:=decodeur_pers[dp].desc[j].etat2=aspect+1;
          end;
          if (aspect=-1) and (combine<>-1) then
          begin
            // signalisation non combin�e (ralen30,60 rappel 30,60)
            trouve3:=decodeur_pers[dp].desc[j].etat1=combine+1;
            trouve4:=decodeur_pers[dp].desc[j].etat2=combine+1;
          end;
          // combin�e
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
          Affiche('Erreur 54 : num�ro de p�riph�rique hors limite pour d�codeur personnalis� '+intToSTR(dp),clred);
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
          v:=Tablo_periph[numacc].NumCom;  // num�ro de com
          if v=0 then exit;
          if tablo_periph[numacc].PortOuvert then
          begin
            cmd:=Tablo_periph[numacc].numComposant;
            if cmd=1 then envoi_usb_comp(MSCommCde1,s);
            if cmd=2 then envoi_usb_comp(MSCommCde2,s);

            if Tablo_periph[numacc].ScvVis then Affiche('Envoi COM'+intToSTR(v)+': '+s,clYellow);
          end
          else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non d�tect�',clred);
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
        Affiche('Erreur 381 : le signal '+IntToSTR(adresse)+' est belge mais son d�codeur est fran�ais',clred);
        exit;
      end;

      // commande par centrale
      if decodeur_pers[dp].commande=0 then
      begin
        nAdresses:=decodeur_pers[dp].NbreAdr;
        // trouver l'�tat dans le d�codeur
        for j:=0 to 8 do
        begin     // balayer les bits de 0 � 8
          if testbit(etat,j) then
          begin
            // explorer les �tats
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
          Affiche('Erreur 55 : num�ro de p�riph�rique hors limite pour d�codeur personnalis� '+intToSTR(dp),clred);
          exit;
        end;
        // trouver l'�tat dans le d�codeur
        for j:=0 to 8 do
        begin     // balayer les bits de 0 � 8
          if testbit(etat,j) then
          begin
            s:=intToSTR(adresse)+' '+decodeur_pers[dp].desc[j+1].Chcommande;  // chaine � envoyer
            if Tablo_periph[numacc].cr then s:=s+#13;
            numAcc:=decodeur_pers[dp].Peripherique;

            if com_socket(numacc)=1 then
            begin
              // com USB
              v:=Tablo_periph[numacc].NumCom;  // num�ro de com
              if v=0 then exit;
              if tablo_periph[numacc].PortOuvert then
              begin
                cmd:=Tablo_periph[numacc].numComposant;
                if cmd=1 then envoi_usb_comp(MSCommCde1,s);
                if cmd=2 then envoi_usb_comp(MsCommCde2,s);

                if Tablo_periph[numacc].ScvVis then Affiche('Envoi COM'+intToSTR(v)+': '+s,clYellow);
              end
              else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non d�tect�',clred);
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


// renvoie l'adresse du d�tecteur suivant des deux �l�ments **contigus**
// TypeElprec/actuel: 1= d�tecteur  2= aiguillage 4=Buttoir
// algo= type d'algorithme pour suivant_alg3
function detecteur_suivant(prec : integer;TypeElPrec : TEquipement;actuel : integer;TypeElActuel : TEquipement;algo : integer) : integer ;
var actuelCalc,PrecCalc,j,AdrSuiv,ia : integer;
    TypeprecCalc,TypeActuelCalc : TEquipement;
begin
  if (NivDebug>=2) or procPrinc then
    AfficheDebug('Proc Detecteur_suivant '+IntToSTR(prec)+','+BTypeToChaine(typeElPrec)+'/'+intToSTR(actuel)+','+
                  BTypeToChaine(TypeElActuel)+
                  ' Alg='+IntToSTR(algo),clyellow);
  j:=0;

  PrecCalc:=prec;
  TypeprecCalc:=TypeElprec;
  ActuelCalc:=actuel;
  TypeActuelCalc:=TypeELActuel;
  // �tape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,TypeprecCalc,actuelCalc,TypeActuelCalc,algo);
    //Affiche(intToSTR(AdrSuiv)+'=alg3('+intToSTR(precCalc)+','+intToSTR(actuelCalc)+')',clWhite);
    // modif sp�cial TJD ==============
    ia:=index_aig(actuelCalc);
    if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
      PrecCalc:=aiguillage[ia].Ddevie else
    // ================================


    {indexCalc:=index_aig(actuelCalc);
    if (typeGen=tjd) and false then // si le pr�c�dent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[index_aig(AdrSuiv)].modele=tjd) or (aiguillage[index_aig(AdrSuiv)].modele=tjs)) and
           ((aiguillage[indexCalc].modele=tjd) or (aiguillage[indexCalc].modele=tjs)) then
        begin
          if nivDebug=3 then AfficheDebug('501 - D�tection Pr�c�dent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuelCalc:=aiguillage[indexCalc].APointe;
        end;
      end; }
    precCalc:=actuelCalc;
    TypeprecCalc:=TypeActuelCalc;

    actuelCalc:=AdrSuiv;
    TypeActuelCalc:=typeGen;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=itmaxi) or (typeGen=det) or (AdrSuiv=0) or (AdrSuiv>=9990); // arret si d�tecteur

  // si trouv� le sens, trouver le suivant

  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1); // suivant imm�diat
  end;
  if (NivDebug=3) and (AdrSuiv<9990) then AfficheDebug('618 : Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;


// index signal niveau=0 : (ouvert) 1= ouvert au vert  =2 ouvert restreint  =3 ferm� (carr� s�maphore violet)
procedure event_Signal(idSignal,niveau : integer);
var i : integer;
begin
  for i:=1 to MaxTablo_act do
  begin
    if (Tablo_Action[i].declencheur=DeclSignal) then
    begin
      if (Tablo_Action[i].adresse=signaux[idSignal].adresse) then
      begin
        if (Tablo_Action[i].etat=niveau) then
        begin
          if teste_condition(i) then
          begin
            Affiche('ZZ test condition',clRed);
            action(i); // ex�cute toutes les op�rations de l'actionneur i
          end
        end;
      end;
    end;
  end;
end;


procedure arret_train(nom : string;id,adresse : integer);
begin
  if (portCommOuvert or parSocketLenz or Cdm_connecte) then
  begin
    if id=0 then id:=index_train_adresse(adresse);
    vitesse_loco(nom,id,adr,0,10,0);
    trains[id].TempoArretCour:=0;
    trains[id].arret_det:=false;
    trains[id].phase_arret:=0;
  end;
end;

procedure stop_trains;
var i,adr : integer;
begin
  for i:=1 to Ntrains do
  begin
    adr:=Trains[i].adresse;
    if adr<>0 then
    begin
      Affiche('Arr�t train @'+intToSTR(adr)+' '+Trains[i].nom_train,clyellow);
      vitesse_loco('',i,adr,0,10,0);
      trains[i].TempoArretCour:=0;
      trains[i].arret_det:=false;
      trains[i].phase_arret:=0;
    end;
  end;
end;


// pilotage d'un signal, et mise � jour du graphisme du signal dans les 3 fenetres
procedure envoi_signal(Adr : integer);
var i,it,index_train,adresse,detect,a,b,aspect,x,y,TailleX,TailleY,Orientation,
    indexTCO,AdrTrain,dec,td : integer;
    etatAvert,etatBvert,etatArouge,etatBrouge : boolean;
    ImageSignal : TImage;
    frX,frY : single;
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
      // envoie la commande au d�codeur
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
       11 : envoi_LEA(adr);
      end;

      // d�codeur personnalis�
      if (dec>=NbDecodeurdeBase) then
        if (dec<NbDecodeurdeBase+NbreDecPers) then envoi_decodeur_pers(adr)
          else Affiche('Erreur 192 : d�codeur '+IntToSTR(dec)+' non d�fini',clred);

      // Gestion d�marrage temporis� des trains si on quitte le rouge
      if roulage then
      begin
        a:=Signaux[i].AncienEtat;
        b:=Signaux[i].EtatSignal;
        etatAvert:=testbit(a,vert);  // ancien �tat
        etatBvert:=testbit(b,vert);
        etatArouge:=testbit(a,semaphore) or testbit(a,carre) or testbit(a,violet);
        etatBrouge:=testbit(b,semaphore) or testbit(b,carre) or testbit(b,violet);

        if etatArouge and not(etatBrouge) then event_signal(i,0); // le signal passe du rouge au non rouge
        if not(etatAvert) and etatBvert   then event_signal(i,1); // le signal passe d'un �tat pas vert au vert
        if etatArouge and not(etatBvert)  then event_signal(i,2); // le signal �tait rouge et d'ouvre � autre chose que vert : ouverture restreinte
        if not(etatArouge) and etatBrouge then event_Signal(i,3); // fermeture du signal
        if etatArouge and not(etatBRouge) then  // si ouverture du signal au non rouge pour temporiser d�part
        begin
          // y a t il un train en face du signal: trouver le d�tecteur
          detect:=Signaux[i].Adr_det1;
          if detect<>0 then
          begin
            // test si train sur le d�tecteur det
            if detecteur[detect].etat then
            begin
              AdrTrain:=detecteur[detect].AdrTrain;
              if (AdrTrain<>0) then
              begin
                if TraceListe then AfficheDebug(s,clWhite);
                index_train:=index_train_adresse(adrtrain);
                if index_train<>0 then it:=trains[index_train].index_event_det_train;
                if it<>0 then event_det_train[it].signal_rouge:=0;
                // faire la r�servation du canton
                {
                if Signaux[i].Btype_suiv1<>det then detSuiv:=detecteur_suivant(detect,det,Signaux[i].Adr_el_suiv1,Signaux[i].Btype_suiv1,1)
                  else detSuiv:=Signaux[i].Adr_el_suiv1;
                if detSuiv<9990 then reserve_canton(detect,detSuiv,Adrtrain,0,nCantonsRes);
                }
                // d�marrage d'un train
                td:=trains[index_train].TempsDemarreSig;
                if td<>0 then
                begin
                  trains[index_train].tempoDemarre:=td*10;  // armer la tempo, en dixi�mes de s
                  // annuler la demande d'arret �ventuelle
                  //trains[index_train].TempoArret:=0;

                  s:='Le train @'+intToSTR(AdrTrain)+' va d�marrer dans '+intToSTR(td)+'s du signal '+intToSTR(adr);
                  Affiche(s,clyellow);
                  // arreter le train

                  //detecteur[det].train:=s;
                  //Affiche('et son d�tecteur '+IntToSTR(det)+'=1 tempo d�marrage ; train '+s,clYellow);
                  s:=detecteur[detect].train;
                  arret_train(s,index_train,AdrTrain);
                  //Affiche('arret train cdm '+s,clorange);
                end;
              end;
            end;
          end;
        end;
      end;
    end

    else
    // signal directionnel
    begin
      pilote_direction(Adr,Signaux[i].etatSignal)
    end;

    Signaux[i].AncienEtat:=Signaux[i].EtatSignal;

    // allume les feux du signal dans la fen�tre de droite
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
            adresse:=TCO[IndexTCO,x,y].adresse;      // v�rifie si le signal existe dans le TCO
            if adresse=adr then
            begin
              aspect:=Signaux[Index_Signal(adresse)].Aspect;
              case aspect of
                 2 : ImageSignal:=Formprinc.Image2feux;
                 3 : ImageSignal:=Formprinc.Image3feux;
                 4 : ImageSignal:=Formprinc.Image4feux;
                 5 : ImageSignal:=Formprinc.Image5feux;
                 7 : ImageSignal:=Formprinc.Image7feux;
                 9 : ImageSignal:=Formprinc.Image9feux;
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
              // r�duction variable en fonction de la taille des cellules
              calcul_reduction(frx,fry,LargeurCell[indexTCO],HauteurCell[indexTCO]);
              // d�calage en X pour mettre la tete du signal align�e sur le bord droit de la cellule pour les signaux tourn�s � 90G
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
    if not modetache then Sleep(25);
    Application.processMessages;
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

// trouve l'index d'un d�tecteur dans une branche
// si pas trouv�, renvoie 0 sinon renvoie l'index du d�tecteur dans la branche
function index_detecteur_branche(detecteur,Num_branche : integer) : integer;
var i,adr : integer;
    trouve,fin : boolean;
    // trouve si detecteur est dans la branche num_branche � partir de l'index i
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse;
        trouve:=(detecteur=adr) and ((BrancheN[Num_Branche,i].Btype=det) or (BrancheN[Num_branche,i].BType=buttoir)); // cherche un d�tecteur
        fin:=(adr=0) and (BrancheN[Num_branche,i].BType<>buttoir);
        //Affiche('cherche='+intToSTR(det)+'/explore='+intToSTR(adr)+' Branche='+intToStr(Num_branche)+' index='+intToStr(i),ClWhite);
        if not(trouve) then inc(i);
        //if trouve then Affiche('Trouv� en branche'+IntToSTR(Num_branche)+' index='+IntToSTR(i),clGreen);
      until trouve or fin ;
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
// si pas trouv�, renvoie 0
function index_aiguillage(AdrAig,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse;
        trouve:=(AdrAig=adr) and ((BrancheN[Num_Branche,i].Btype=aig) or (BrancheN[Num_branche,i].BType=buttoir)); // cherche un aiguillage
        //Affiche('cherche='+intToSTR(AdrAig)+'/explore='+intToSTR(adr)+' Branche='+intToStr(Num_branche)+' index='+intToStr(i),ClWhite);
        if not(trouve) then inc(i);
        //if trouve then Affiche('Trouv� en branche'+IntToSTR(Num_branche)+' index='+IntToSTR(i),clGreen);
      until trouve or (adr=0) or (i>MaxElBranches) ;
    end;
begin
  i:=1;index2_aig:=0;
  recherche;
  if trouve then result:=i else result:=0;
  //affiche(inttostr(ai+1),clOrange);
  i:=2; // � voir
  //affiche('------------------------',clWhite);
  recherche;
  //affiche('------------------------',clGreen);
  if trouve then index2_aig:=i else index2_aig:=0;
  //affiche('index2='+IntToSTR(index2_det),clWhite);
end;

// trouve le d�tecteur dans les branches  et stocke le r�sultat des index dans branche_trouve, Indexbranche_trouve)
// si pas trouv�, IndexBranche_trouve=0
procedure trouve_detecteur(detecteur : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  repeat
    i:=index_detecteur_branche(detecteur,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  // if (i<>0) and traceDet then Affiche('D�tecteur trouv� en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;

// trouve un aiguillage dans une branche par son adresse
// si pas trouv�, IndexBranche_trouve=0
procedure trouve_aiguillage(adresse : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  repeat
    i:=index_aiguillage(Adresse,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  //if (i<>0) then Affiche('aiguillage '+IntToSTR(adresse)+' trouv� en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;

// v�rifie la configuration du d�codeur Unisemaf
// si 0 = OK
// si 1 = erreur code Unisemaf
// si 2 = erreur coh�rence entre code et aspect
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

// v�rifie la configuration du d�codeur LEB
// si 0 = OK
// si 1 = erreur code cible LEB
// si 2 = erreur coh�rence entre code cible et aspect
// si 3 = signal inconnu
function verif_LEB(adresse,UniSem : integer) : integer;
var aspect,i : integer;
begin
  if UniSem=0 then begin result:=1;exit;end;
  if ((UniSem<0) or (UniSem>29)) and (UniSem<>41) and (UniSem<>100) then begin result:=1;exit;end;

  i:=Index_Signal(adresse);
  if i<>0 then
  begin
    aspect:=Signaux[i].aspect;
    if ((aspect=2) and ((UniSem=1) or (UniSem=2) or (UniSem=4) or (UniSem=21) or (UniSem=29))) or
       ((aspect=3) and ((UniSem=3) or (UniSem=5) or (UniSem=22))) or
       ((aspect=4) and ((UniSem=6) or (UniSem=23) or (UniSem=27) or (UniSem=28))) or
       ((aspect=5) and ((UniSem=7) or (UniSem=8))) or
       ((aspect=7) and (((UniSem>=9) and (UniSem<=13)) or (UniSem=24) or (UniSem=25) or (UniSem=26))) or
       ((aspect=9) and (((UniSem>=14) and (UniSem<=20)) or (UniSem=41))) or
       (UniSem=100)
       then result:=0
    else result:=2;
  end
  else
  begin
    Affiche('Erreur 395 : Signal '+intToSTR(adresse)+' inconnu',clred);
    result:=3;
  end;
end;

function quelle_procedure(var n : integer) : string;
begin
  n:=0;
  case proc of
    Ttrouve_actionneurs_aig : begin n:=2;result:='trouve_actionneurs_aig';end;
    TAig_Adj : begin n:=3;result:='Aig_Adj';end;
    Tsuivant_alg3 : begin n:=2;result:='suivant_alg3';end;
    Tindex_signal_det : begin n:=1;result:='Tindex_signal_det';end;
    TAig_ext : begin n:=1;result:='AigExt';end;
    Tdet_contigu : begin n:=2;result:='det_contigu';end;
    tdet_suiv_cont : begin n:=2;result:='det_suiv_cont';end;
    tdet_adj : begin n:=1;result:='det_adj';end;
    texplore_branche : begin n:=2;result:='explore_branche';end;
    Tdet_prec_signal : begin n:=1;result:='det_prec_signal';end;
    Tdetecteur_suivant_El : begin n:=2;result:='detecteur_suivant_El';end;
    Ttrouve_actionneur : begin n:=2;result:='trouve_actionneur';end;
    Tcond_carre : begin n:=1;result:='cond_carre';end;
    Tcarre_signal : begin n:=2;result:='carre_signal';end;
    Tsignal_suivant_det : begin n:=2;result:='signal_suivant_det';end;
    Tetat_signal_suivant : begin n:=2;result:='etat_signal_suivant';end;
    TAiguille_deviee : begin n:=1;result:='Aiguille_deviee';end;
    Ttest_memoire_zones : begin n:=1;result:='test_memoire_zones';end;
    TSignal_precedent : begin n:=1;result:='Signal_precedent';end;
    TPresTrainPrec : begin n:=2;result:='PresTrainPrec';end;
    Treserve_canton : begin n:=3;result:='reserve_canton';end;
    Tlibere_canton : begin n:=2;result:='libere_canton';end;
    Treserve_dereserve_det : begin n:=3;result:='reserve_dereserve_det';end;
    Texplore_el : begin n:=2;result:='explore_el';end;
  else result:='';
  end;
end;

// trouve un �l�ment en balayant les branches � partir de la branche offset renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'�l�ment  TypeEL=(1=d�t�cteur 2=aig  3=aig Bis 4=aig triple - Buttoir)
// si l'�l�ment est une TJD et qu'on la trouve pas, on cherche l'homologue
// explore les branches
// si une branche pref�r�e est choisie, elle est non nulle.
// erreur=true affiche le message d'erreur
// it<>0 permet de ne pas chercher une TJD homologue si 2 �tats
// si pas trouv�, Branche_trouve=0 IndexBranche_trouve=0
procedure trouve_element_V1(el: integer; TypeEl : TEquipement; Offset,branche_pref,OffsetDsBranche : integer;erreur : boolean;it : integer);
var i,adr,Branche,ia : integer ;
    s : string;
    BT : TEquipement;
    sort : boolean;
begin
  if debug=3 then formprinc.Caption:='Trouve_element '+IntToSTR(el);

  if (typeEL=triple) or (typeEL=tjd) or (typeEL=tjs) or (typeEL=crois) then TypeEL:=aig;

  i:=1;
  if OffsetDsBranche<>0 then i:=OffsetDsBranche;
  branche_trouve:=0;
  IndexBranche_trouve:=0;
  if branche_pref<>0 then branche:=Branche_Pref else Branche:=offset;
  repeat
    sort:=false;
    adr:=BrancheN[Branche,i].Adresse;
    Bt:=BrancheN[Branche,i].BType;
    if ((adr=0) and (Bt=rien)) then
    begin
      inc(Branche);i:=0;
      if branche_pref<>0 then sort:=true;
    end;
    inc(i);
    sort:=sort or ((Branche>NbreBranches) or ((adr=el) and (TypeEL=Bt)));
  until (sort);
  if (adr=el) then
  begin
    branche_trouve:=Branche;
    IndexBranche_trouve:=i-1;
  end
  else
  begin
    // si pas trouv�, si TJD 4 �tats, chercher son homologue
    if (TypeEl=Aig) and (it=0) then  // it c'est pour ne faire qu'une it�ration
    begin
      ia:=index_aig(el);
      if (aiguillage[ia].modele=TJD) and (aiguillage[ia].EtatTJD=4) then
      begin
        el:=aiguillage[ia].dDroit; // homologue
        trouve_element_v1(el,TypeEl,Offset,branche_pref,OffsetDsBranche,erreur,1);
        if branche_trouve<>0 then exit;
      end;
    end;
    branche_trouve:=0; IndexBranche_trouve:=0;
    if erreur then
    begin
      s:='Erreur 175 : �l�ment '+intToSTR(el)+' ';
      s:=s+BTypeToChaine(TypeEl);
      s:=s+' non trouv�';Affiche(s,clred);
      AfficheDebug(s,clred);
    end;
  end;
  if debug=3 then formprinc.Caption:='';
end;

// trouve un �l�ment dans les branches depuis les index.
// Plus rapide que la proc�dure pr�c�dente. Renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'�l�ment  TypeEL=det aig triple tjd buttoir)
// avec cet algorithme, un d�tecteur ne peut se trouver qu'� un seul endroit dans les branches
// si branche_Pref<>0 : recherche un aig sur la branche_Pref
procedure trouve_element(el: integer; TypeEl : TEquipement;Branche_pref : integer;erreur : boolean); overload;
var s : string;
    n,i : integer;
begin
  if debug=3 then formprinc.Caption:='Trouve_element '+IntToSTR(el);

  branche_trouve:=0;
  IndexBranche_trouve:=0;

  if el>NbMaxDet then
  begin
    s:='Erreur 97 : trouve_element='+inttoStr(el)+' : '+quelle_procedure(n)+'(';
    for i:=1 to n do
    begin
      case i of
      1: s:=s+intToSTR(param1);
      2: s:=s+','+intToSTR(param2);
      3: s:=s+','+intToSTR(param3);
      end;
    end;
    s:=s+')';

    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  if (el<1) and (typeEL<>buttoir) then
  begin
    s:='Erreur 81 : trouve_element el='+inttoStr(el);
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;

  if typeEL=det then
  begin
    branche_trouve:=detecteur[el].NumBranche;              // le d�tecteur det se trouve dans
    indexBranche_trouve:=detecteur[el].IndexBranche;       // NumBranche et Indexbranche  - detecteur[] sont index�s par l'adresse
  end;

  if (TypeEl=triple) or (typeEL=aig) or (typeEL=crois) or (typeEL=tjd) or (typeEL=tjs) then
  begin
    Trouve_element_V1(el,TypeEl,1,branche_pref,0,erreur,0);
  end;

  if typeEL=buttoir then
  begin
    branche_trouve:=detecteur[el].NumBranche;              // le d�tecteur det se trouve dans
    indexBranche_trouve:=detecteur[el].IndexBranche;
  end;

  if typeEL=act then
  begin
    branche_trouve:=actionneur[el].NumBranche;
    indexBranche_trouve:=actionneur[el].IndexBranche;
  end;

  //Affiche_Suivi(intToSTR(el),clred);

  if IndexBranche_trouve=0 then
  begin
    branche_trouve:=0; IndexBranche_trouve:=0;
    if erreur then
    begin
      s:='Erreur 176 : �l�ment '+intToSTR(el)+' ';
      s:=s+BTypeToChaine(TypeEl);
      s:=s+' non trouv� dans les branches';Affiche(s,clred);
      AfficheDebug(s,clred);
    end;
  end;
  if debug=3 then formprinc.Caption:='';
end;

procedure trouve_element(el: integer; TypeEl : TEquipement); overload;
begin
  trouve_element(el,TypeEl,0,true);
end;

// trouve actionneur_aig
// trouve les actionneurs de l'aiguillage "index" au suivant (qui peut �tre un d�tecteur ou un aig)
// index = index d'aiguillage - suivant
// Index et Suivant doivent �tre contigus !!!!
procedure trouve_actionneurs_aig(index,suivant : integer;tsuiv : tequipement);
var i,adrAig,indexBranche_aig,branche_trouve_aig,indexBranche_Suiv,branche_trouve_Suiv : integer;
    typ : tequipement;
    s : string;
begin
  proc:=Ttrouve_actionneurs_aig;
  param1:=index;
  param2:=suivant;
  adrAig:=aiguillage[index].Adresse;
  typ:=aiguillage[index].modele;
  if (nivDebug=3) then AfficheDebug('trouve_actionneurs_aig '+intToSTR(adrAig)+' '+intToSTR(suivant),clCyan);
  if suivant=0 then  // possible sur buttoir
  begin
    exit;
  end;

  // si suivant est un d�tecteur la recherche de l'aig se fera dans la m�me branche
  if tSuiv=det then
  begin
    trouve_element(suivant,tSuiv); // branche_trouve  IndexBranche_trouve
    if IndexBranche_trouve=0 then
    begin
      if NivDebug=3 then AfficheDebug('33. Element '+intToSTR(suivant)+' non trouv�',clred);
      exit;
    end;
    indexBranche_Suiv:=IndexBranche_trouve;
    branche_trouve_Suiv:=branche_trouve;

    // chercher l'aig dans la m�me branche
    trouve_element(AdrAig,typ,Branche_trouve_Suiv,false);  // ne pas afficher l'erreur
    if IndexBranche_trouve=0 then
    begin
      // si pas trouv�, c'est peut �tre une TJD, elle a �t� d�clar�e par sa 2eme adresse dans les branches
      if (typ=tjd) and (aiguillage[index].EtatTJD=4) then
      begin
        AdrAig:=aiguillage[index].DDroit;  // homologue
        index:=index_aig(adrAig);
        trouve_element(AdrAig,typ,Branche_trouve_Suiv,false);  // ne pas afficher l'erreur
        if IndexBranche_trouve=0 then
        begin
          //if NivDebug=3 then
          AfficheDebug('34. Element '+intToSTR(adrAig)+' non trouv� en branche '+intToSTR(Branche_trouve_Suiv),clred);
          exit;
        end;
      end
      else exit;  
    end;
    indexBranche_aig:=IndexBranche_trouve;
    branche_trouve_aig:=branche_trouve;
  end
  else
  // si le suivant est un aiguillage
  if tSuiv=aig then
  begin
    // if nivDebug=3 then AfficheDebug('SuivAig',clred);
    // v�rifier que si index est une TJD 4 �tats, et v�rifier la contiguit� avec suivant
    if (aiguillage[index].EtatTJD=4) and (aiguillage[index].modele=tjd) then
    begin
      if (aiguillage[index].ADroit<>suivant) and (aiguillage[index].ADevie<>suivant) then
      begin
        index:=index_aig(aiguillage[index].ddroit); // homologue
        AdrAig:=aiguillage[index].Adresse;
        if (aiguillage[index].ADroit<>suivant) and (aiguillage[index].ADevie<>suivant) then
        begin
          s:='Erreur 68 - proc trouve_actionneurs_aig a �chou� : '+intToSTR(adrAig)+' '+intToSTR(suivant)+' : �l�ments non contigus';
          Affiche(s,clred);
          AfficheDebug(s,Clred);
        end;
      end;
    end;

    suivant_alg3(adraig,typ,suivant,tsuiv,1);
    if nivDebug=3 then AfficheDebug('FinProc trouve_actionneurs',clCyan);
    exit;
  end;

  // mettre aig avant det
  if indexBranche_aig>indexBranche_suiv then
  begin
    i:=indexBranche_aig;
    indexBranche_aig:=indexBranche_suiv;
    indexBranche_suiv:=i;
  end;

  if nivDebug=3 then AfficheDebug('Det en branche'+intToSTR(branche_trouve_Suiv)+' Aig en branche'+intToSTR(branche_trouve_Suiv),clYellow);
  if branche_trouve_Suiv=branche_trouve_Suiv then
  begin
    for i:=indexBranche_aig to indexBranche_suiv do
    begin
      //AfficheDebug(intToSTR(index)+' '+intToSTR(suivant),clWhite);
      if BrancheN[branche_trouve_suiv,i].BType=act then
      begin
        //AfficheDebug(IntToSTR(BrancheN[branche_trouve_det,i].Adresse),clwhite);
        inc(idActTr);
        if idActTr<11 then Actionneur_trouve[idActTr]:=BrancheN[branche_trouve_suiv,i].Adresse;
      end;
    end;
    if nivDebug=3 then AfficheDebug('FinProc trouve_actionneurs',clCyan);
    exit;
  end;

  //suivant_alg3(adresse,typ,suivant,tsuiv,1);
  AfficheDebug('cas non pr�vu - Fin proc trouve_actionneurs',clCyan);
end;


// renvoie les adresses des 2 aiguillages adjacents au d�tecteur "adresse" (avant, apr�s)
// r�sultat dans var1 et var2
procedure Aig_Adj(adresse : integer;var adr1: integer;var adr2 : integer);
var Branche,IndexBranche,i : integer;
    sortie : boolean;
    Bt : TEquipement;
    s : string;
begin
  proc:=TAig_Adj;
  param1:=adresse;
  param2:=adr1;
  param3:=adr2;
  trouve_element(adresse,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    s:='Erreur 380 : �l�ment '+IntToSTR(adresse)+' det non trouv�';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  IndexBranche:=IndexBranche_trouve;
  branche:=branche_trouve;

  i:=indexBranche;
  repeat
    bt:=brancheN[branche,i].BType;
    inc(i);
  until bt=aig;
  adr1:=brancheN[branche,i-1].Adresse;

  i:=indexBranche;
  repeat
    bt:=brancheN[branche,i].BType;
    dec(i);
    sortie:=bt=aig;
  until (i=0) or (bt=aig);
  adr2:=brancheN[branche,i+1].Adresse;
end;

// renvoie l'�l�ment suivant des deux �l�ments dans le sens (prec,typeElprec) -> (actuel,typeElActuel) quels qu'ils soient mais contigus
// *** attention, si les �l�ments ne sont pas contigus, le r�sultat est erron�!!! ***
// un �l�ment est constitu� de son adresse et de son type
// et renvoie aussi en variable globale: typeGen le type de l'�l�ment (det aig uniquement! pas tjd ni crois)
//                                     : AigMal = aiguillage mal positionn� ou inconnu
//                                     : SensAig = sens de prise de l'aiguillage (const_pointe, const_talon)
// remplit le tableau Actionneur_trouve[] entre actuel et suivant.
// alg= algorithme 1 � 8 sous forme de bits fonctionnels:
// bit0 (1)=arret sur suivant qu'il soit un d�tecteur ou un aiguillage
// bit1 (2)=arret sur aiguillage en talon mal positionn�
// bit2 (4)=arret sur aiguillage r�serv�
// bits1 et 2: (2+4)=6= arret sur aiguillage en talon mal positionn�e ou aiguillage r�serv�
// bit3 (8)=arret sur un aiguillage pris en pointe d�vi� et AdrDevie contient l'adresse de l'aiguillage d�vi� ainsi que typeGen
// code de sortie : �l�ment suivant ou:
// 9999: erreur fatale: �l�ment non trouv� ou it�ration trop longue
// 9998: arret sur aiguillage en talon mal positionn�e
// 9997: arr�t sur aiguillage d�vi�
// 9996: arr�t sur position inconnue d'aiguillage
// 9995: arr�t sur buttoir
// 9994: arr�t sur aiguillage r�serv�
// 9993: �l�ments non cons�cutifs
// la variable "actuel" peut etre chang�e en cas de TJD!
function suivant_alg3(prec : integer;typeELprec : TEquipement;actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
var  Adr,AdrPrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2,N_iteration,index,NetatTJD,index2,k,delta,posPrec,IndexPrec : integer;
     tjscourbe1,tjscourbe2,tjdC,tjsC,id : boolean;
     A,Aprec,tjsc1B,tjsc2B,typeprec: char;
     TypeGenS,Md,BT,BtypePrec,TypeEL : TEquipement;
     s : string;

label recommence;
begin
  n_iteration:=0;
  proc:=Tsuivant_alg3;
  param1:=prec;
  param2:=actuel;

  recommence:
  if (TypeELPrec=rien) or (typeElActuel=rien) then
  begin
    s:='Erreur 800 - Types nuls : '+intToSTR(prec)+'/'+BtypeToChaine(TypeElPrec)+' '+IntToSTr(actuel)+'/'+BtypeToChaine(typeElActuel) ;
    Affiche(s,clred);
    AfficheDebug(s,clred);
    Suivant_alg3:=9999;exit;
  end;
  if (NivDebug=3) then
    AfficheDebug('it='+intToSTR(n_iteration)+' Alg3 pr�c�dent='+intToSTR(prec)+'/'+BtypeToChaine(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+BtypeToChaine(typeElActuel)+' Alg='+intToSTr(alg),clyellow);

  // trouver les �l�ments du pr�c�dent dans les branches
  trouve_element(prec,TypeELPrec); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;

  trouve_element(actuel,typeElActuel); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;
  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Bt:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

  if nivDebug=3 then AfficheDebug('Btype='+BTypeToChaine(Bt)+' Actuel='+inTToSTR(actuel),clyellow);

  id:=false;
  if (Bt=det) or (bt=act) then  // l'�l�ment actuel est un d�tecteur  ou un actionneur
  begin
    if bt=act then
    begin
      if (NivDebug=3) then AfficheDebug('40 - Trouv� actionneur '+intToSTR(brancheN[branche_trouve_actuel,indexBranche_actuel].Adresse),clLime);
      inc(IdActTr);
      if idActTr<10 then actionneur_trouve[IdActTr]:=brancheN[branche_trouve_actuel,indexBranche_actuel].Adresse;
    end;

    // on part de l'actuel en - pour retomber sur le pr�c�dent
    delta:=0;
    repeat
      inc(delta);
      md:=brancheN[branche_trouve_actuel,indexBranche_actuel-delta].BType;
      if md=act then
      begin
        if (NivDebug=3) then AfficheDebug('41 - Trouv� actionneur '+intToSTR(brancheN[branche_trouve_actuel,indexBranche_actuel-delta].Adresse),clLime);
        inc(IdActTr);
        if idActTr<10 then actionneur_trouve[IdActTr]:=brancheN[branche_trouve_actuel,indexBranche_actuel-delta].Adresse;
      end;
    until (md<>act);

    if BrancheN[branche_trouve_actuel,indexBranche_actuel-delta].Adresse=prec then // c'est l'autre sens
    begin
      id:=true;
      //if NivDebug=3 then AfficheDebug('42 - trouv� '+intToSTR(adr)+' en - et RAZ du pointeur d''actionneurs',clwhite);
      //IdActTr:=0;
      Prec:=Adr;
      Aprec:=a;
      A:='Z';
      delta:=1;
      repeat
        Adr:=BrancheN[branche_trouve_actuel,indexBranche_actuel+delta].Adresse;
        typeGen:=BrancheN[branche_trouve_actuel,indexBranche_actuel+delta].Btype;
        if (typeGen=act) then
        begin
          if nivDebug=3 then AfficheDebug('43 - Trouv� actionneur '+intToSTR(adr),clLime);
          inc(IdActTr);
          if idActTr<10 then actionneur_trouve[IdActTr]:=adr;
        end;
        inc(delta);
      until (typeGen<>act) ;

      if NivDebug=3 then
      begin
        s:='44 - Le suivant est :'+intToSTR(adr);
        AfficheDebug(s,clwhite);
      end;
      suivant_alg3:=adr;
      exit;
    end;

    // maintenant en +
    delta:=0;
    repeat
      inc(delta);
      md:=brancheN[branche_trouve_actuel,indexBranche_actuel+delta].BType;

      if md=act then
      begin
        if (NivDebug=3) then AfficheDebug('45 - Trouv� actionneur '+intToSTR(BrancheN[branche_trouve_actuel,indexBranche_actuel+delta].adresse),clLime);
        inc(IdActTr);
        if idActTr<10 then actionneur_trouve[IdActTr]:=BrancheN[branche_trouve_actuel,indexBranche_actuel+delta].adresse;
      end;
    until (md<>act);

    if BrancheN[branche_trouve_actuel,indexBranche_actuel+delta].Adresse=prec then
    begin
      id:=true;
      //IdActTr:=0;
      if NivDebug=3 then AfficheDebug('46 - trouv� d�t/act '+intToSTR(adr)+' en - et RAZ du pointeur d''actionneurs',clwhite);
      if bt=act then
      begin
        if (NivDebug=3) then AfficheDebug('47 - Trouv� actionneur '+intToSTR(adr),clLime);
        inc(IdActTr);
        if idActTr<10 then actionneur_trouve[IdActTr]:=adr;
      end;

      Prec:=Adr;
      Aprec:=a;
      A:='Z';
      delta:=1;
      repeat
        Adr:=BrancheN[branche_trouve_actuel,indexBranche_actuel-delta].Adresse;
        typeGen:=BrancheN[branche_trouve_actuel,indexBranche_actuel-delta].Btype;
        if (typeGen=act) then
        begin
          if nivDebug=3 then AfficheDebug('48 - Trouv� actionneur '+intToSTR(adr),clLime);
          inc(IdActTr);
          if idActTr<10 then actionneur_trouve[IdActTr]:=adr;
        end;
        inc(delta);
      until (typeGen<>act) ;

      if NivDebug=3 then
      begin
        s:='49 - Le suivant est :'+intToSTR(adr);
        AfficheDebug(s,clwhite);
      end;
      suivant_alg3:=adr;
      exit;
    end;

    // ici, les �l�ments dans des branches diff�rentes.
    if (btypePrec=aig) then // car btype dans les branches vaut det, aig, buttoir mais jamais tjd ni tjs
    begin
      id:=true;
      index:=tablo_index_aiguillage[prec];
      md:=aiguillage[index].modele;
      // si aiguillage triple : prendre l'adresse de base de l'aig triple
      if (md=aig) and aiguillage[index].visible then
      begin
        prec:=Aiguillage[index].APointe;
      end;

      // changer l'adresse du pr�c�dent par l'autre adresse de la TJD/S
      if (md=tjs) or (md=tjd) then   // attention voir si on applique au TJD 2 et 4 �tats!!!!!!!!!!!!!!!!!!!!!!
      begin
        prec:=Aiguillage[tablo_index_aiguillage[prec]].Ddroit;
        if NivDebug=3 then AfficheDebug('Le pr�cedent est une TJD/S - substitution du pr�c�dent par la pointe de la TJD qui est '+intToSTR(prec),clYellow);
      end;
    end;
    if not(id) then
    begin
      AfficheDebug('Erreur 780 alg3: '+intToSTR(prec)+' '+intToSTR(actuel)+' non cons�cutifs',clRed);
      result:=9993;
      exit;
    end;

    inc(n_iteration);

    if n_iteration>50 then
    begin
      s:='Erreur fatale 9999, trop d''it�rations:';
      s:=s+' Alg3 pr�c�dent='+intToSTR(prec)+'/'+BtypeToChaine(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+BtypeToChaine(typeElActuel)+' Alg='+intToSTr(alg);
      Affiche(s,clRed);
      AfficheDebug(s,clRed);
      suivant_alg3:=9999;
      exit;
    end;
    goto recommence;
  end;

  if (Bt=aig) or (Bt=buttoir) then  // aiguillage ou buttoir
  begin
    // si le prec est un actionneur, remonter au d�tecteur
    if TypeElPrec=act then
    begin
      delta:=0;
      repeat
        inc(delta);
        k:=brancheN[branche_trouve_prec,indexBranche_prec+delta].Adresse;
      until (k=actuel) or (k=0);
      if k=actuel then prec:=brancheN[branche_trouve_prec,indexBranche_prec-1].Adresse
      else
      begin
        delta:=0;
        repeat
          inc(delta);
          k:=brancheN[branche_trouve_prec,indexBranche_prec-delta].Adresse;
        until (k=actuel) or (k=0);
        if k=actuel then prec:=brancheN[branche_trouve_prec,indexBranche_prec+1].Adresse;
      end;
    end;
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
      // si aiguillage reserv�
      if (alg and $4=$4) and (aiguillage[index].AdrTrain<>0) then
      begin
        if NivDebug=3 then AfficheDebug('230 - aiguillage '+intToSTR(adr)+' r�serv� par train @'+intToSTR(aiguillage[index].AdrTrain),clyellow);
        suivant_alg3:=9997;     // attention code incorrect devrait �tre 9994
        exit;
      end;

      // aiguillage index (adr) pris en pointe
      if (aiguillage[index].Apointe=prec) then
      begin
        SensAig:=const_pointe;
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
            if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
            trouve_element(adr,typeEl); // branche_trouve  IndexBranche_trouve
            if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
            typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          end
          else
            typeGenS:=buttoir;
          suivant_alg3:=adr;
          // trouver entre actuel et adr s'il y a des actionneurs
          trouve_actionneurs_aig(index,adr,typeEl);
          typeGen:=TypeGenS;
          exit;
        end;

        
        if aiguillage[index].position=const_devie then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe d�vi�',clyellow);
          if (alg and 8)=8 then // on demande d'arreter sur un aiguillage pris en pointe est d�vi�
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
            if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig)
            trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
            if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
            typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          end
            else typeGenS:=buttoir;
          // trouver entre actuel et adr s'il y a des actionneurs
          trouve_actionneurs_aig(index,adr,typeEl); // attention �crase typegen
          typeGen:=TypeGenS;
          suivant_alg3:=adr;
          exit;
        end;

        if aiguillage[index].position=const_inconnu then
        begin
          if NivDebug>=1 then AfficheDebug('134.2 - Aiguillage '+IntToSTR(adr)+' non r�solu car position inconnue',clOrange);
          typeGen:=rien;
          suivant_alg3:=9996;
          AigMal:=adr;
          exit;
        end;
      end
      else
      begin
        // aiguillage index (adr) pris en talon
        if (aiguillage[index].ADevie=prec) or (aiguillage[index].ADroit=prec) then
        begin
          SensAig:=const_talon;
          if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
          if (alg and 2)=2 then // on demande d'arreter si l'aiguillage en talon est mal positionn�
          begin
            if aiguillage[index].position=const_droit then
            begin
              k:=index_aig(Adr);
              if ( (prec<>aiguillage[index_aig(Adr)].Adroit) and (aiguillage[k].InversionCDM=0) ) or     //Adroit
                 ( (prec=aiguillage[k].Adroit) and (aiguillage[k].InversionCDM=1) ) then
              begin
                if NivDebug=3 then AfficheDebug('135.1 - Aiguillage '+intToSTR(adr)+' mal positionn�',clyellow);
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('135.2 - Aiguillage '+intToSTR(adr)+' bien positionn�',clyellow);
              end;
            end
            else
            begin
             { // si TJD (modele=2) sur le pr�c�dent, alors substituer avec la 2eme adresse de la TJD
              if TypeElPrec<>det then
              begin
                md:=aiguillage[index_aig(prec)].modele;
                if (md=tjd) or (md=tjs) then prec:=aiguillage[index_aig(prec)].Ddevie;
              end; }
              if (prec<>aiguillage[index].Adevie) or (aiguillage[index].position=const_inconnu) then
              begin
                if NivDebug=3 then AfficheDebug('135.3 Aiguillage '+intToSTR(adr)+' mal positionn�',clyellow);
                suivant_alg3:=9998;
                AigMal:=adr;
                exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('135.4 Aiguillage '+intToSTR(adr)+' bien positionn�',clyellow);
              end;
            end;
          end;
        end
        else
        begin
          s:='Impossible de d�terminer le passage de l''aiguillage '+intToSTR(adr);
          if (nivDebug=3) or ProcPrinc then AfficheDebug(s,clred);
          Affiche(s,clred);
          result:=9999;
          exit;
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
          //  Affiche('trouv� '+intToSTR(adr),clyellow);
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        end
          else TypeGenS:=Buttoir;
        suivant_alg3:=adr;
        // trouver entre actuel et adr s'il y a des actionneurs
        trouve_actionneurs_aig(index,adr,typeEl);
        typeGen:=TypeGenS;
        exit;
      end;
      if (NivDebug>1) or traceListe then
      begin
        s:='138 - Aiguillage '+IntToSTR(adr)+' non r�solu';
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
        if NivDebug=3 then AfficheDebug('231 - TJD/S '+intToSTR(Adrtjdp)+' r�serv�e par train @'+intToSTR(aiguillage[index].AdrTrain),clyellow);
        suivant_alg3:=9994;
        exit;
      end;

      // r�cup�rer les �lements de la TJD/S
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
        if NivDebug=3 then AfficheDebug('130 - TJD/S '+intToSTR(Adrtjdp)+' r�serv�e par train @'+intToSTR(aiguillage[index2].AdrTrain),clyellow);
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
          else if aiguillage[index].position=const_devie then s:=s+'d�vi�'
          else s:=s+'inconnu' ;
        if NetatTJD=4 then
        begin
          if aiguillage[index_aig(AdrTJDP)].position=const_droit then s:=s+'/droit'
          else if aiguillage[index_aig(AdrTJDP)].position=const_devie then s:=s+'/d�vi�'
            else s:=s+'/inconnu' ;
        end;
        AfficheDebug(s,clyellow);
      end;

      // rechercher le port de destination de la tjd
      Adr2:=0;A:='Z';

      //---------------TJD 2 �tats
      if (NetatTJD=2) and tjdC then
      begin
        if (TypeElPrec=aig) or (TypeElPrec=triple) or (TypeElPrec=Tjd) then
        begin
          IndexPrec:=index_Aig(prec);
          posPrec:=aiguillage[IndexPrec].position;
          if posPrec=const_droit then Aprec:=aiguillage[indexPrec].ADroitB;
          if posPrec=const_devie then Aprec:=aiguillage[indexPrec].AdevieB;
        end;
        if TypeElPrec=det then Aprec:='Z';
        // d'ou vient t-on de la TJD
        // extr�mit� 1      530
        if (aiguillage[index].ADroit=prec) and (aiguillage[index].ADroitB=Aprec) then
        begin
          if aiguillage[index].position=const_droit then 
          begin
            adr:=aiguillage[index].Ddroit;
            a:=aiguillage[index].DDroitB;
          end
          else
          if aiguillage[index].position=const_devie then 
          begin
            adr:=aiguillage[index].DDevie;
            a:=aiguillage[index].DdevieB;
          end
          else
          begin
            s:='Erreur 121.1 : position inconnue de la TJD 2 �tats '+intToSTR(Adr);
            AfficheDebug(s,clred);
            suivant_alg3:=9996;
            exit;
          end;
        end
        else

        // extr�mit� 2 - 21D
        if (aiguillage[index].DDroit=prec) and (aiguillage[index].DDroitB=Aprec) then
        begin
          if aiguillage[index].position=const_droit then
          begin
            adr:=aiguillage[index].Adroit;
            a:=aiguillage[index].ADroitB;
          end
          else
          if aiguillage[index].position=const_devie then 
          begin
            adr:=aiguillage[index].ADevie;
            a:=aiguillage[index].AdevieB;
          end
          else
          begin
            s:='Erreur 121.2 : position inconnue de la TJD 2 �tats '+intToSTR(Adr);
            AfficheDebug(s,clred);
            suivant_alg3:=9996;
            exit;
          end;
        end
        else

        // extr�mit� 3 - 529
        if (aiguillage[index].ADevie=prec) and (aiguillage[index].AdevieB=Aprec) then
        begin
          if aiguillage[index].position=const_droit then
          begin
            adr:=aiguillage[index].Ddevie;
            a:=aiguillage[index].DdevieB;
          end
          else
          if aiguillage[index].position=const_devie then 
          begin
            adr:=aiguillage[index].Ddroit;
            a:=aiguillage[index].DdroitB;
          end
          else
          begin
            s:='Erreur 121.2 : position inconnue de la TJD 2 �tats '+intToSTR(Adr);
            AfficheDebug(s,clred);
            suivant_alg3:=9996;
            exit;
          end;
        end
        else

        // extr�mit� 4  - 21S
        if (aiguillage[index].DDevie=prec) and (aiguillage[index].DDevieB=Aprec) then
        begin
          if aiguillage[index].position=const_droit then
          begin
            adr:=aiguillage[index].ADevie;
            a:=aiguillage[index].ADevieB;
          end
          else
          if aiguillage[index].position=const_devie then 
          begin
            adr:=aiguillage[index].ADroit;
            a:=aiguillage[index].AdroitB;
          end
          else
          begin
            s:='Erreur 121.4 : position inconnue de la TJD 2 �tats '+intToSTR(Adr);
            AfficheDebug(s,clred);
            suivant_alg3:=9996;
            exit;
          end;
        end
        else

        begin
          if (nivdebug>1) or traceliste then
          begin
            s:='Erreur 120 : TJD 2 �tats '+intToSTR(Adr)+' non r�solue';
            AfficheDebug(s,clred);
            suivant_alg3:=9999;
            exit;
          end;
        end;

        if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
        suivant_alg3:=adr;
        if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 �tats est '+IntToSTR(adr)+a,clyellow);
        trouve_actionneurs_aig(index,adr,TypeGenS);
        typeGen:=TypeGenS;
        exit;
      end;

      //--------------- 4 �tats ou TJS
      if (NetatTJD=4) or tjsC then
      begin
        // v�rifier que l'entr�e de la TJD correspond � l'�l�ment actuel
        if (aiguillage[index].Adroit<>prec) and (aiguillage[index].Adevie<>prec) then
        begin
          if (aiguillage[index2].Adroit=prec) or (aiguillage[index2].Adevie=prec) then
          begin
            // en fait, l'�l�ment prec est sur l'homologue...
            echange(index,index2);
          end;
        end;

        // determiner la position de la premi�re section de la TJD (4 cas)
        // cas 1 : droit droit
        if (( aiguillage[index].position=const_droit) and
             (aiguillage[index2].position=const_droit) )  then
        begin
          // d'o� vient ton sur la tjs
          if BtypePrec=Aig then
          begin
             if ( ((aiguillage[index].AdroitB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
                ( ((aiguillage[index].AdroitB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
             then
               begin if NivDebug=3 then AfficheDebug('TJD/S '+intToSTR(adr)+' bien positionn�e cas 1.1',clyellow);end
             else
             begin
               if (nivdebug>1) or traceliste then AfficheDebug('135.5- TJD/S '+intToSTR(adr)+' mal positionn�e cas 1.1',clyellow);
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
              if NivDebug=3 then AfficheDebug('TJD/S '+intToSTR(adr)+' bien positionn�e cas 1.2',clyellow);end
            else
            begin
              if (nivdebug>1) then AfficheDebug('135.6- TJD/S '+intToSTR(adr)+' mal positionn�e cas 1.2',clyellow);
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
          if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          suivant_alg3:=adr;
          Actuel:=aiguillage[index2].Adresse; // substitution de la TJS
          if nivDebug=3 then Affichedebug('A. le port de destination de la tjd/s est '+IntToSTR(adr)+a,clyellow);
          trouve_actionneurs_aig(index,adr,TypeGenS);
          typeGen:=TypeGenS;
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

          // d'o� vient ton sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdroitB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdroitB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
            begin if NivDebug=3 then AfficheDebug('TJD/S '+intToSTR(adr)+' bien positionn�e - cas 2.1',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionn�e - cas 2.1',clyellow);
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
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 2.2',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;
                exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.18- TJD '+intToSTR(adr)+' mal positionn�e cas 2.2',clyellow);
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
          if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('B. le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          trouve_actionneurs_aig(index2,adr,TypeGenS);
          typeGen:=TypeGenS;
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
          // d'o� vient t-on sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdevieB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdevieB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
              begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 3.1',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionn�e cas 3.1',clyellow);
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
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 3.2',clyellow);
              if (alg and 4)=4 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;
                exit;
              end;
            end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.8- TJD '+intToSTR(adr)+' mal positionn�e cas 3.2',clyellow);
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
          if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('C. Le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          trouve_actionneurs_aig(index2,adr,TypeGenS);
          typeGen:=TypeGenS;
          exit;
        end;

        // cas 4 tjd
        if (aiguillage[index].position=const_devie)
           and (aiguillage[index2].position=const_devie)  then
        begin
          // d'o� vient ton sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdevieB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdevieB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
              begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 4.1',clyellow);end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionn�e cas 4.1',clyellow);
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
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 4.2',clyellow);end
            else
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.8- TJD '+intToSTR(adr)+' mal positionn�e cas 4.2',clyellow);
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
          if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          trouve_actionneurs_aig(index2,adr,TypeGenS);
          typeGen:=TypeGenS;
          exit;
        end;

        // cas TJS prise dans sa position courbe
        if ((aiguillage[index].Adevie=Prec) and (aiguillage[index].AdevieB=Aprec) and (aiguillage[index].position<>const_droit)
        and (aiguillage[index_aig(AdrTjdP)].position=const_droit) and (tjsC) and tjscourbe1 and tjscourbe2) then
        begin
          if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
          A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          trouve_actionneurs_aig(index,adr,TypeGenS);
          typeGen:=TypeGenS;
          exit;
        end;

        // cas 3 TJS prise dans sa 2eme position courbe
        if ((aiguillage[index].Adroit=Prec) and (aiguillage[index].AdroitB=Aprec) and (aiguillage[index].position=const_droit)
             and (aiguillage[index_aig(AdrTjdP)].position<>const_droit) and (tjsC) and tjscourbe1 and tjscourbe2 ) then
        begin
          if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
          A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
          suivant_alg3:=adr;
          Actuel:=aiguillage[index2].Adresse;
          if nivDebug=3 then Affichedebug('D. le port de destination de la tjd est '+IntToSTR(adr)+a,clyellow);
          trouve_actionneurs_aig(index,adr,TypeGenS);
          typeGen:=TypeGenS;
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
       // si reserv�
      if ((alg and 4)=4) and (aiguillage[index].AdrTrain<>0) then
      begin
        if NivDebug=3 then AfficheDebug('235 - croisement '+intToSTR(adr)+' r�serv� par train @'+intToSTR(aiguillage[index].AdrTrain),clyellow);
        suivant_alg3:=9994;
        exit;
      end;

      adr:=9999;
      if aiguillage[index].Adroit=prec then begin adr:=aiguillage[index].Ddroit;A:=aiguillage[index].DdroitB;end;
      if aiguillage[index].Adevie=prec then begin adr:=aiguillage[index].Ddevie;A:=aiguillage[index].DdevieB;end;
      if aiguillage[index].Ddevie=prec then begin adr:=aiguillage[index].Adevie;A:=aiguillage[index].AdevieB;end;
      if aiguillage[index].Ddroit=prec then begin adr:=aiguillage[index].Adroit;A:=aiguillage[index].AdroitB;end;
      if adr=9999 then
      begin
        Affiche('Erreur 183 : L''aiguillage '+IntToSTR(aiguillage[index].adresse)+' n''a aucun point de connexion � l''�l�ment '+intToSTR(prec),clred);
        result:=adr;
        exit;
      end;
      if (A='Z') or (a=#0) then typeGenS:=det else typeGenS:=aig;
      suivant_alg3:=adr;
      if a='' then a:=' ';
      if (nivdebug>1) then Affichedebug('le port de destination du croisement '+intToSTR(aiguillage[index].adresse)+' est '+IntToSTR(adr)+a,clyellow);
      // Affiche('croisement '+intToSTR(prec)+' '+intToSTR(actuel),clLime);
      // m�moriser dans un tableau l'entr�e et la sortie du croisement
      trouve_actionneurs_aig(index,adr,TypeGenS);
      typeGen:=TypeGenS;
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
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          if adr=0 then TypeEl:=buttoir;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;
          trouve_actionneurs_aig(index,adr,TypeGenS);
          typeGen:=TypeGenS;
          exit;
        end;
        if (aiguillage[index].position=const_devie) and (aiguillage[index_aig(Adr2)].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�1 (� gauche)',clYellow);
          A:=aiguillage[index].AdevieB;
          Adr:=aiguillage[index].Adevie;
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;
          if adr=0 then TypeEl:=buttoir;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;
          trouve_actionneurs_aig(index,adr,TypeGenS);
          typeGen:=TypeGenS;
          exit;
        end;
        if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(Adr2)].position=const_devie)  then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�2 (� droite)',clYellow);
          A:=aiguillage[index].Adevie2B;
          Adr:=aiguillage[index].Adevie2;
          if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
          typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;
          trouve_actionneurs_aig(index,adr,TypeGenS);
          typeGen:=TypeGenS;
          exit;
        end;
        if aiguillage[index].position=const_inconnu then
        begin
          AigMal:=aiguillage[index].adresse;
          suivant_alg3:=9996;
          exit;
        end; // pour �chappement
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
        if (alg and 2)=2 then // on demande d'arreter si l'aiguillage en talon est mal positionn�
        begin
          if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(adr2)].position=const_droit) then
          begin
            if prec<>aiguillage[index].Adroit then
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionn�',clyellow);
            end;
          end;
          if (aiguillage[index].position<>const_droit) and (aiguillage[index_aig(adr2)].position=const_droit) then
          begin
            if prec<>aiguillage[index].Adevie then
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionn�',clyellow);
            end;
          end;
          if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(adr2)].position<>const_droit) then
          begin
            if prec<>aiguillage[index].Adevie2 then
            begin
              if (nivdebug>1) or traceliste then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;
              AigMal:=adr;
              exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionn�',clyellow);
            end;
          end;
        end;
        A:=aiguillage[index].ApointeB;
        Adr:=aiguillage[index].Apointe;
        if (A='Z') or (a=#0) then TypeEl:=det else TypeEL:=aig;
        trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
        if branche_trouve=0 then begin suivant_alg3:=9999;exit;end;
        typeGenS:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        suivant_alg3:=Adr;
        trouve_actionneurs_aig(index,adr,TypeGenS);
        typeGen:=TypeGenS;
        exit;
      end;
    end;
  end;
  suivant_alg3:=adr;
end;

// renvoie l'adresse du signal s'il est associ� au d�tecteur "detecteur"
// supprim�
// sinon renvoie 0
// utilis� 10 fois
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

// trouve l'index du signal associ� au d�tecteur adr
// renvoie dans voie le num�ro de la voie (1 � 4) du signal sur lequel le d�tecteur se trouve et son index
// attention , il peut y avoir deux signaux sur un detecteur (sens oppos�s)
// le 2eme signal est dans voie2,index2
procedure index_signal_det(adr : integer;var voie1,index1,voie2,index2 : integer) ;
var trouve,i : integer;
    trouve1,trouve2,trouve3,trouve4 : boolean;
begin
  proc:=Tindex_signal_det;
  param1:=adr;
  i:=1;
  trouve:=0;
  index2:=0;
  index1:=0;
  voie1:=0;
  voie2:=0;
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
      if trouve=1 then              // on ne m�morise la voie qu'� la premiere recherche
      begin
        if trouve1 then voie1:=1;
        if trouve2 then voie1:=2;
        if trouve3 then voie1:=3;
        if trouve4 then voie1:=4;
      end;
      if trouve=2 then
      begin
        if trouve1 then voie2:=1;
        if trouve2 then voie2:=2;
        if trouve3 then voie2:=3;
        if trouve4 then voie2:=4;
      end;
    end;
    inc(i);
  until (trouve=2) or (i>NbreSignaux);
end;


//renvoie l'�l�ment connect� de l'aiguillage ou de la tjd tjs "adr" sur le point D,S ou P pass� par connect
procedure aig_ext(adr : integer ; connect : char;var suiv : integer;var typ_suiv: char);
var i : integer;
    typ : TEquipement;
begin
  proc:=TAig_ext;
  param1:=adr;
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


// renvoie l'�l�ment avant det2 si det1 et det2 sont contigus ou ne sont s�par�s que par des aiguillages
// les aiguillages n'ont pas besoin d'�tre positionn�s
// si det1 et det2 sont contigus sans aiguillages entre eux, �� renvoie det1 sinon renvoie l'aiguillage entre les 2
// s'ils ne sont pas contigus, renvoie 0
// Si un �l�ment est inconnu, renvoie 9999
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
  // prec=adresse de det ou aig ; suiv soit �tre une adresse d'aig
  // aig_suiv(527,7) : renvoie 520 dans suiv_2
  // proc�dure r�cursive
  procedure aig_suiv(prec,suiv : integer);
  var adr2,index : integer;
      typ : Tequipement;
  begin
    inc(it);
    if it>50 then
    begin
      Affiche('Erreur 670 : limite de r�cursivit�',clred);
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
          if afdeb then afficheDebug('trouv� ',clLime);
          exit;
        end;
        if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow);
      end;

      // faire le d�vi�
      if afdeb then afficheDebug('252.Aig '+intToSTR(suiv)+' test en pointe d�vi�',clyellow);
      type_Dernier:=aig;
      aig_ext(suiv,'S',suiv_2,type_tmp);
      if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
      begin
        trouve:=(suiv_2=det2);
        if trouve then
        begin
          dernier:=suiv;
          if afdeb then afficheDebug('trouv� ',clLime);
          exit;
        end;
        if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu ('+intToSTR(det2)+')',clyellow)
      end;

      // si triple faire S2
      if typ=triple then
      begin
        if afdeb then afficheDebug('Aig triple'+intToSTR(suiv)+' test en pointe d�vi�2',clyellow);
        type_Dernier:=aig;
        aig_ext(suiv,'2',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouv� ',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
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
            if afdeb then afficheDebug('trouv� ',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
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
            if afdeb then afficheDebug('trouv� sur D',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
        end;
        aig_ext(suiv,'S',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouv� sur S',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
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
            if afdeb then afficheDebug('trouv� sur D',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu ('+intToSTR(det2)+')',clyellow)
        end;
        aig_ext(suiv,'S',suiv_2,type_tmp);
        if type_tmp<>'Z' then aig_suiv(suiv,suiv_2) else
        begin
          trouve:=(suiv_2=det2);
          if trouve then
          begin
            dernier:=suiv;
            if afdeb then afficheDebug('trouv� sur S',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu('+intToSTR(det2)+')',clyellow)
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
            if afdeb then afficheDebug('trouv� ',clLime);
            exit;
          end;
          if afdeb then afficheDebug('trouv� '+intToSTR(suiv_2)+' mais pas attendu ('+intToSTR(det2)+')',clyellow)
        end;
      end;
    end;
  end;    // fin de la proc�dure r�cursive aig_suiv


begin
  proc:=Tdet_contigu;
  param1:=det1;
  param2:=det2;
  // trouver les �l�ments du pr�c�dent
  if debug=3 then formprinc.Caption:='Det_contigu '+intToSTR(det1)+' '+intToSTr(det2);
  if NivDebug=3 then afdeb:=true else afdeb:=false;
  it:=0;
  if afdeb or (nivdebug=3) then afficheDebug('Det_contigu '+intToSTR(det1)+' '+intToSTr(det2),clyellow);
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
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(det1)+' non trouv�',clred);
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
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(det2)+' non trouv�',clred);
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

  // faire en incr�ment
  if afdeb or (nivDebug=3) then afficheDebug('incr�ment',clcyan);
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

  // faire en d�cr�ment
  if afdeb or (nivDebug=3) then afficheDebug('d�cr�ment',clcyan);
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
    if (dernier=0) then afficheDebug('----Pas trouv�',ClLime)
    else afficheDebug('----Trouv� dernier='+intToSTR(dernier),clLime);
  end;

  suivant:=dernier;ElSuiv:=type_dernier;
  if debug=3 then formprinc.Caption:='';
end;


// renvoie le d�tecteur suivant aux d�tecteurs 1 et 2
// les aiguillages n'ont pas besoin d'�tre positionn�s entre 1 et 2.
// par contre pour le suivant au det2, les aiguillages doivent �tre positionn�s
// si on ne trouve pas le suivant, renvoie 9999
function det_suiv_cont(det1,det2,alg : integer) : integer;
var dernier: integer;
    derniertyp : Tequipement;
begin
  proc:=Tdet_suiv_cont;
  param1:=det1;
  param2:=det2;
  // si un aiguilage est entre det1 et det2 renvoie l'aig, sinon renvoie det1 si det1 et det2 sont contigus
  det_contigu(det1,det2,dernier,dernierTyp);
  if (dernier<>0) and (dernier<>9999) then
  begin
    // d�tecteur suivant
    det_suiv_cont:=detecteur_suivant(dernier,dernierTyp,det2,det,alg);
     //Affiche(intToSTR(suivant),clorange);
  end
  else det_suiv_cont:=9999;
end;

// renvoie les adresses des d�tecteurs adjacents au d�tecteur "adresse" (avant, apr�s)
// les aiguillages entre det1 et det2 doivent �tre positionn�s
// trouve aussi les premiers �l�ments contigus au d�tecteur "adresse"
// r�sultat dans adj1 et adj2 ; et prec1,t1 et prec2,t2 en variable globale
procedure Det_Adj(adresse : integer);
var ia,Adr,AdrFonc,Branche,AdrPrec,IndexBranche,i,Dir,delta : integer;
    sortie : boolean;
    BtypeFonc,BtypePrec : TEquipement;
    s : string;
begin
  proc:=Tdet_adj;
  param1:=Adresse;
  trouve_element(adresse,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    s:='Erreur 380 : �l�ment '+IntToSTR(adresse)+' det non trouv�';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  IndexBranche:=IndexBranche_trouve;
  branche:=branche_trouve;
  prec1:=0;prec2:=0;
  Dir:=1 ; //test direction 1 ou 2 (incr�ment ou d�cr�ment)

  repeat

    AdrPrec:=Adresse;
    BtypePrec:=det;

    delta:=1;
    repeat
      if Dir=1 then i:=IndexBranche-delta else i:=IndexBranche+delta;
      AdrFonc:=BrancheN[branche,i].Adresse;
      BtypeFonc:=BrancheN[branche,i].BType;
      inc(delta);
    until btypeFonc<>act;

    i:=0;
    repeat
      if BtypeFonc<>det then
      begin
        Adr:=suivant_alg3(AdrPrec,BtypePrec,AdrFonc,BtypeFonc,2);  // �l�ment suivant mais arret sur aiguillage en talon mal positionn�e
        //Affiche(intToSTR(Adr)+'=alg3('+intToSTR(Adrprec)+','+intToSTR(AdrFonc)+')',clWhite);
      end
      else
      begin
        Adr:=AdrFonc;
        TypeGen:=BtypeFonc;
      end;
      if Adr>9990 then typeGen:=det;
      if (NivDebug=3) then AfficheDebug('trouv� '+intToSTR(Adr)+' '+BTypeToChaine(typeGen),clorange);

      // modif sp�cial TJD ==============
      ia:=index_aig(AdrFonc);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         AdrPrec:=aiguillage[ia].Ddevie else
      // ================================

      AdrPrec:=AdrFonc;BtypePrec:=BtypeFonc;
      AdrFonc:=Adr;BtypeFonc:=typeGen;
      inc(i);
      sortie:=(i=itmaxi) or (Adr=0) or (Adr>=9990) or (TypeGen=det);

      // �l�ments contigus � "adresse"
      if (dir=1) and (i=1) then begin prec1:=AdrPrec;t1:=BtypePrec;end;
      if (dir=2) and (i=1) then begin prec2:=AdrPrec;t2:=BtypePrec;end;

    until (sortie) ;   // boucle de parcours
    if (typeGen=det) and (Dir=1) then Adj1:=Adr;
    if (typeGen=det) and (Dir=2) then Adj2:=Adr;

    inc(dir);
  until dir=3;
end;

// explore les connexions d'un aiguillage - r�cursif
// prec : �l�ment d'entr�e de l'aiguillage, adrAig : adresse de l'aiguillage
// remplit le tableau des d�tecteurs tabloDet contigus � tous les aiguillages , quelles que soient leurs positions
// rempli le TabloParcours
// si d�bordement, resultat=faux
function explore_branche(prec,adrAig : integer;var it: integer;var tabloDet : TTabloDet;var index : integer;var Nparcours,idParcours: integer) : boolean;
var i,i2,el1,el2,erreur : integer;
    c: char;
    typ,tq1,tq2 : tEquipement;
begin
  Proc:=texplore_branche;
  param1:=prec;
  param2:=AdrAig;
  result:=true;
    inc(it);
    erreur:=0;
    if it>40 then begin Affiche('Erreur r�cursive 95',clred);result:=false;exit;end;
    i:=index_aig(adrAig);
    typ:=aiguillage[i].modele;

    if erreur>0 then begin result:=false;exit;end
    else
    begin
      inc(Idparcours);
      Tabloparcours[nparcours,0].adresse:=idparcours;
      Tabloparcours[nparcours,idparcours].adresse:=AdrAig;
      Tabloparcours[nparcours,idparcours].typ:=typ;
    end;

    if (typ=triple) then
    begin
       // pris en pointe?
      if aiguillage[i].APointe=prec then
      begin

        //Affiche('Aig'+inttostr(adraig)+' pointe droit',clyellow);
        el1:=adraig;tq1:=typ;
        // explore droit----------------
        if (idparcours>0) and (idparcours<MaxParcours) then
        begin
          Tabloparcours[nparcours,idparcours].pos:=const_droit;
        end;

        el2:=aiguillage[i].ADroit;
        c:=aiguillage[i].ADroitB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,tabloDet,index,nparcours,idparcours);
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);

          if (idparcours>=MaxParcours) then Erreur:=521
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
            // on a trouv� un d�t�cteur, on change de tableau
            if nparcours>=MaxRoutes then Erreur:=522
            else
            begin
              inc(nparcours);idparcours:=0;
            end;
          end;
        end;

        // explore d�vi� 1-----------------
        if (idparcours>=MaxParcours) then Erreur:=523
        else
        begin
          inc(idparcours);
          Tabloparcours[nparcours,0].adresse:=idparcours;
          Tabloparcours[nparcours,idparcours].adresse:=AdrAig;
          Tabloparcours[nparcours,idparcours].typ:=aig;
          Tabloparcours[nparcours,idparcours].pos:=const_devie;
        end;
        i:=index_aig(adrAig);
        el2:=aiguillage[i].ADevie;
        c:=aiguillage[i].ADevieB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,tabloDet,index,nparcours,idparcours);
          // stocke l'aig d'origine
          tq2:=aiguillage[index_aig(el2)].modele;
          if (tq2=aig) then
          begin
            if idparcours>=MaxParcours then Erreur:=524
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              Tabloparcours[nparcours,idparcours].adresse:=el2;
              Tabloparcours[nparcours,idparcours].typ:=aig;
            end;
          end;
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;inc(index);
          if (idparcours>=MaxParcours) then Erreur:=525
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
          end;
          // on a trouv� un d�t�cteur, on change de tableau
          if nparcours>=MaxRoutes then Erreur:=526
          else
          begin
            inc(nparcours);idparcours:=0;
          end;
        end;

        // explore d�vi� 2
        if (idparcours>=MaxParcours) then Erreur:=527
        else
        begin
          inc(idparcours);
          Tabloparcours[nparcours,0].adresse:=idparcours;
          Tabloparcours[nparcours,idparcours].adresse:=Adraig;
          Tabloparcours[nparcours,idparcours].typ:=aig;
          Tabloparcours[nparcours,idparcours].pos:=const_devie;
        end;
        i:=index_aig(adrAig);
        el2:=aiguillage[i].ADevie2;
        c:=aiguillage[i].ADevie2B;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,tabloDet,index,nparcours,idparcours);
          // stocke l'aig d'origine
          tq2:=aiguillage[index_aig(el2)].modele;
          if (tq2=aig) then
          begin
            if (idparcours>=MaxParcours) then Erreur:=528
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              Tabloparcours[nparcours,idparcours].adresse:=el2;
              Tabloparcours[nparcours,idparcours].typ:=aig;
            end;
          end;
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
          if (idparcours>=MaxParcours) then Erreur:=529
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
          end;
          // on a trouv� un d�tecteur, on change de tableau
          if nparcours>=MaxRoutes then Erreur:=530
          else
          begin
            inc(nparcours);idparcours:=0;
          end;
        end;
      end
      else
      // triple pris en talon
      begin
        el1:=adraig;tq1:=typ;
        //Affiche('Aig'+inttostr(adraig)+' talon',clyellow);
        // pris en talon
        if (idparcours>0) and (idparcours<100) then
        begin
          Tabloparcours[nparcours,idparcours].pos:=0;
        end;
        el2:=aiguillage[i].APointe;
        c:=aiguillage[i].APointeB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,tabloDet,index,nparcours,idparcours);
          exit;
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
          if (idparcours>=MaxParcours) then Erreur:=531
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
          end;
          // on a trouv� un d�t�cteur, on change de tableau
          if nparcours>=MaxRoutes then Erreur:=532
          else
          begin
            inc(nparcours);idparcours:=0;
          end;
        end;
      end;
    end;

    // --
    if (typ=tjd) or (typ=tjs) then
    begin
      // 4 �tats ; c'est l'entr�e de la TJD qui d�termine ou on sort
      if index_aig(aiguillage[i].EtatTJD)=4 then
      begin
        i2:=index_aig(aiguillage[i].DDevie);  // index de la tjd homologue
        // explorer la position droite
        Tabloparcours[nparcours,idparcours].pos:=const_droit;

        el2:=aiguillage[i2].ADroit;
        c:=aiguillage[i2].ADroitB;
        if (c='P') or (c='D') or (c='S') then // l'�l�ment sur droit est un aig
        begin
          explore_branche(Adraig,el2,it,Tablodet,index,nparcours,idparcours);
        end
        else
        begin    // l'�l�ment sur droit est un det
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);

          if (idparcours>=MaxParcours) then Erreur:=533
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
            // comme on a trouv� un d�t�cteur, on change de tableau
            if nparcours>=MaxRoutes then Erreur:=534
            else
            begin
              inc(nparcours);idparcours:=0;
            end;
          end;
        end;

        // explore d�vi�-------------------
        if (idparcours>=MaxParcours) then Erreur:=535
        else
        begin
          inc(idparcours);
          Tabloparcours[nparcours,0].adresse:=idparcours;
          Tabloparcours[nparcours,idparcours].adresse:=Adraig;
          Tabloparcours[nparcours,idparcours].typ:=tjd;
          Tabloparcours[nparcours,idparcours].pos:=const_devie;
        end;

        //i:=index_aig(adrAig);
        el2:=aiguillage[i2].ADevie;
        c:=aiguillage[i2].ADevieB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          // stocke l'aig d'origine
          tq2:=aiguillage[index_aig(el2)].modele;
          if (tq2=aig) then
          begin
            if (idparcours>=MaxParcours) then Erreur:=536
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              Tabloparcours[nparcours,idparcours].adresse:=el2;
              Tabloparcours[nparcours,idparcours].typ:=aig;
            end;
          end;
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
          if (idparcours>=MaxParcours) then Erreur:=537
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
          end;
          // on a trouv� un d�t�cteur, on change de tableau
          if nparcours>=MaxRoutes then Erreur:=538
          else
          begin
            inc(nparcours);idparcours:=0;
          end;
        end;
      end;

      // 2 �tats
      if index_aig(aiguillage[i].EtatTJD)=2 then
      begin
        // provenance sens 1
        if (aiguillage[i].ADroit=prec) or (aiguillage[i].ADevie=prec) then
        begin
          // destination 1 de la tjd
          el2:=aiguillage[i].Ddevie;c:=aiguillage[i].DDevieB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);

            if (idparcours>=MaxParcours) then Erreur:=539
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              TabloParcours[nparcours,idparcours].adresse:=el2;
              TabloParcours[nparcours,idparcours].typ:=det;
              TabloParcours[nparcours,idparcours].pos:=0;
              // on a trouv� un d�t�cteur, on change de tableau
              if nparcours>=MaxRoutes then Erreur:=540
              else
              begin
                inc(nparcours);idparcours:=0;
              end;
            end;
          end;
           // destination 2 de la tjd
          el2:=aiguillage[i].Ddroit;c:=aiguillage[i].DDroitB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
            if (idparcours>=MaxParcours) then Erreur:=541
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              TabloParcours[nparcours,idparcours].adresse:=el2;
              TabloParcours[nparcours,idparcours].typ:=det;
              TabloParcours[nparcours,idparcours].pos:=0;
              // on a trouv� un d�t�cteur, on change de tableau
              if nparcours>=MaxRoutes then Erreur:=542
              else
              begin
                inc(nparcours);idparcours:=0;
              end;
            end;
          end;
        end;

        // provenance sens 2
        if (aiguillage[i].DDevie=prec) or (aiguillage[i].Ddroit=prec) then
        begin
          // destination 1 de la tjd
          el2:=aiguillage[i].Adroit;c:=aiguillage[i].ADroitB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
            if (idparcours>=MaxParcours) then Erreur:=543
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              Tabloparcours[nparcours,idparcours].adresse:=el2;
              Tabloparcours[nparcours,idparcours].typ:=det;
            end;
          end;
          // destination 2 de la tjd
          el2:=aiguillage[i].Adevie;c:=aiguillage[i].AdevieB;
          if (c='P') or (c='D') or (c='S') then
          begin
            explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          end
          else
          begin
            //Affiche(IntToSTR(el2),clLime);
            tabloDet[index]:=el2;inc(index);
            if (idparcours>=MaxParcours) then Erreur:=544
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              Tabloparcours[nparcours,idparcours].adresse:=el2;
              Tabloparcours[nparcours,idparcours].typ:=det;
            end;
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
        explore_branche(Adraig,el2,it,Tablodet,index,nparcours,idparcours);
        exit;
      end
      else
      begin
        //Affiche(IntToSTR(el2),clLime);
        tabloDet[index]:=el2;inc(index);
        if (idparcours>=MaxParcours) then Erreur:=545
        else
        begin
          inc(idparcours);
          Tabloparcours[nparcours,0].adresse:=idparcours;
          TabloParcours[nparcours,idparcours].adresse:=el2;
          TabloParcours[nparcours,idparcours].typ:=det;
          TabloParcours[nparcours,idparcours].pos:=0;
        end;
        // on a trouv� un d�t�cteur, on change de tableau
        if nparcours>=MaxRoutes then Erreur:=546
        else
        begin
          inc(nparcours);idparcours:=0;
        end;
      end;
    end;

    if typ=aig then
    begin
      // pris en pointe?-----------------------
      if aiguillage[i].APointe=prec then
      begin
        //Affiche('Aig'+inttostr(adraig)+' pointe droit',clyellow);
        el1:=adraig;tq1:=typ;
        // explore droit-------------
        if (idparcours>0) and (idparcours<100) then
        begin
          Tabloparcours[nparcours,idparcours].pos:=const_droit;
        end;

        el2:=aiguillage[i].ADroit;
        c:=aiguillage[i].ADroitB;
        if (c='P') or (c='D') or (c='S') then // l'�l�ment sur droit est un aig
        begin
          explore_branche(Adraig,el2,it,Tablodet,index,nparcours,idparcours);
        end
        else
        begin    // l'�l�ment sur droit est un det
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);

          if (idparcours>=MaxParcours) then Erreur:=547
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
            // on a trouv� un d�t�cteur, on change de tableau
            if nparcours>=MaxRoutes then Erreur:=548
            else
            begin
              inc(nparcours);idparcours:=0;
            end;
          end;
        end;

        // explore d�vi�-------------------
        if (idparcours>=MaxParcours) then Erreur:=549
        else
        begin
          inc(idparcours);
          Tabloparcours[nparcours,0].adresse:=idparcours;
          Tabloparcours[nparcours,idparcours].adresse:=Adraig;
          Tabloparcours[nparcours,idparcours].typ:=aig;
          Tabloparcours[nparcours,idparcours].pos:=const_devie;
        end;

        i:=index_aig(adrAig);
        el2:=aiguillage[i].ADevie;
        c:=aiguillage[i].ADevieB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          // stocke l'aig d'origine
          tq2:=aiguillage[index_aig(el2)].modele;
          if (tq2=aig) then
          begin
            if (idparcours>=MaxParcours) then Erreur:=550
            else
            begin
              inc(idparcours);
              Tabloparcours[nparcours,0].adresse:=idparcours;
              Tabloparcours[nparcours,idparcours].adresse:=el2;
              Tabloparcours[nparcours,idparcours].typ:=aig;
            end;
          end;
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;
          inc(index);
          if (idparcours>=MaxParcours) then Erreur:=551
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
          end;
          // on a trouv� un d�t�cteur, on change de tableau
          if nparcours>=MaxRoutes then Erreur:=552
          else
          begin
            inc(nparcours);idparcours:=0;
          end;
        end;
      end
      else
      begin // en talon
        el1:=adraig;tq1:=typ;
        //Affiche('Aig'+inttostr(adraig)+' talon',clyellow);
        // pris en talon
        if (idparcours>0) and (idparcours<100) then
        begin
          Tabloparcours[nparcours,idparcours].pos:=0;
        end;
        el2:=aiguillage[i].APointe;
        c:=aiguillage[i].APointeB;
        if (c='P') or (c='D') or (c='S') then
        begin
          explore_branche(Adraig,el2,it,TabloDet,index,nparcours,idparcours);
          exit;
        end
        else
        begin
          //Affiche(IntToSTR(el2),clLime);
          tabloDet[index]:=el2;inc(index);
          if (idparcours>=MaxParcours) then Erreur:=553
          else
          begin
            inc(idparcours);
            Tabloparcours[nparcours,0].adresse:=idparcours;
            TabloParcours[nparcours,idparcours].adresse:=el2;
            TabloParcours[nparcours,idparcours].typ:=det;
            TabloParcours[nparcours,idparcours].pos:=0;
          end;
          // on a trouv� un d�t�cteur, on change de tableau
          if nparcours>=MaxRoutes then Erreur:=554
          else
          begin
            inc(nparcours);idparcours:=0;
          end;
        end;
      end;
    end;
end;


// renvoie l'adresse des d�tecteurs convergents pr�c�dents un signal apr�s les aiguillages
// renvoie dans le tableau TabloDet
procedure det_prec_signal(adresse : integer;var tabloDet : TTabloDet);
var el1,el2,i,index,it,voie,Nparcours,IdParcours : integer;
    tq1,tq2 : tEquipement;
begin
  proc:=Tdet_prec_signal;
  param1:=adresse;
  // trouver �l�ments avant le signal
  for i:=1 to MaxParcours do tabloDet[i]:=0;
  i:=index_signal(adresse);
  if i=0 then
  begin
    affiche('Erreur 842 : signal '+intToSTR(adresse)+' inconnu',clred);
    exit;
  end;
  index:=1;
  nParcours:=1;
  idParcours:=0;
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
      // �l�ment avant le signal
      suivant:=suivant_alg3(el1,tq1,el2,det,0); //typeGen
      // si aiguillage
      if (typeGen=aig) or (typeGen=tjd) or (typeGen=tjs) or (typeGen=triple) then explore_branche(el2,suivant,it,TabloDet,index,nparcours,idparcours);
      if typeGen=det then begin tabloDet[1]:=suivant;index:=2;end;
    end;
  end;
  if index<=MaxParcours then tabloDet[index]:=0 else Affiche('D�passement TabloDet signal '+intToSTR(Adresse),clred);
  {
  for i:=1 to Index do
  begin
    Affiche(IntToSTR(tabloDet[i]),clyellow);
  end;
  }
end;


// Attention : confusion sur detecteur_suivant_el(525,101) renvoie 517 car on reboucle !!
// renvoie l'adresse du d�tecteur suivant les deux �l�ments
// les aiguillages doivent �tre correctement positionn�s entre El1 et el2
// El1 et El2 peuvent �tre s�par�s par des aiguillages, mais de pas plus de 2 d�tecteurs
// remplit aussi le tableau des �l�ments[idEl] rencontr�s de el2 au suivant
// ne fonctionne pas si un des �l�ments est un buttoir!!!
// en sortie : 9999= det1 ou det2 non trouv� ; en variable globale : prec,tprec et suiv,tsuiv
// 9995 : el2=0 buttoir
// 9996 : non trouv�
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,i1,N_det,Ia,delta : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;

begin
  proc:=Tdetecteur_suivant_El;
  param1:=el1;
  param2:=el2;
  if debug=3 then formprinc.Caption:='Detecteur_suivant_el '+intToSTR(el1)+' '+intToSTR(el2);
  if NivDebug>=2 then
  AfficheDebug('Proc Detecteur_suivant_EL '+intToSTR(el1)+','+BTypeToChaine(Typedet1)+'/'+intToSTR(el2)+','+BTypeToChaine(Typedet2)+'-------------------------',clLime);
  if (el1>9000) or (el2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('Param�tres incorrects >9000',clred);
    detecteur_suivant_El:=9999;
    exit;
  end;

  if (el2=0) then
  begin
    detecteur_suivant_El:=9995;
    exit;
  end;

  // trouver �l�ment 2
  trouve_element(el2,Typedet2); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(el2)+' non trouv�';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    detecteur_suivant_El:=9999;exit;
  end;
  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  
  if el1=0 then
  begin
    typeDet1:=buttoir;
    //trouver l'index du buttoir de det2
    j:=1;
    repeat
      //pr�parer les variables
      AdrPrec:=el1;TypePrec:=typeDet1;
      IdActTr:=0;   // init pointeur des actionneurs

      // sens
      delta:=1;
      repeat
        if j=1 then i1:=IndexBranche_det2+delta;
        if j=2 then i1:=IndexBranche_det2-delta;

        if i1=0 then begin result:=9999;exit;end;

        AdrFonc:=BrancheN[branche_trouve_det2,i1].adresse;
        typeFonc:=BrancheN[branche_trouve_det2,i1].Btype;
        elements[idEl].adresse:=adrFonc;
        elements[idEl].typ:=TypeFonc;
        sortie:=typefonc=buttoir;
        inc(delta);
      until (sortie) or (TypeFonc=rien) ;
      inc(j);
    until (j=3) or sortie; 
    if sortie then
    begin
      IndexBranche_det1:=i1;
      Branche_trouve_det1:=Branche_trouve_det2;
    end
    else 
    begin  
      result:=9999;
      exit;
    end;
  end;

  // trouver �l�ment 1
  if el1<>0 then
  begin
    trouve_element(el1,Typedet1); // branche_trouve  IndexBranche_trouve
    if (IndexBranche_trouve=0) then
    begin
      if NivDebug=3 then
      begin
        s:='611. '+IntToSTR(el1)+' non trouv�';
        AfficheDebug(s,clOrange);
      end;
      detecteur_suivant_El:=9999;
      exit;
    end;
    IndexBranche_det1:=IndexBranche_trouve;
    branche_trouve_det1:=branche_trouve;
  end;
  

  j:=1;  // J=1 test en incr�ment J=2 test en d�cr�ment
  idEl:=1;
  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)

  repeat
    //pr�parer les variables
    AdrPrec:=el1;TypePrec:=typeDet1;
    IdActTr:=0;   // init pointeur des actionneurs
    if nivDebug=3 then afficheDebug('Init pointeur actionneurs',clLime);

    // sens
    delta:=1;
    repeat
      if j=1 then i1:=IndexBranche_det1+delta;
      if j=2 then i1:=IndexBranche_det1-delta;

      if IndexBranche_det1<>0 then
      begin
        if i1=0 then begin result:=9999;exit;end;

        AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
        typeFonc:=BrancheN[branche_trouve_det1,i1].Btype;
        elements[idEl].adresse:=adrFonc;
        elements[idEl].typ:=TypeFonc;
        inc(delta);
      end;
    until typeFonc<>act ;

    AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
    typeFonc:=BrancheN[branche_trouve_det1,i1].Btype;
    elements[idEl].adresse:=adrFonc;
    elements[idEl].typ:=TypeFonc;
    N_Det:=0;
    if Typefonc=det then N_det:=1;


    if NivDebug=3 then
    begin
      s:='------> Test en ';
      if (j=1) then s:=s+'incr�ment ' else s:=s+'d�cr�ment ';
      s:=s+'- d�part depuis �l�ment '+IntToSTR(el1)+' trouv� en index='+intToSTR(IndexBranche_det1)+' Branche='+intToSTR(branche_trouve_det1);
      AfficheDebug(s,clyellow);
    end;

    i:=0;
    if AdrFonc<>El2 then // si pas d�ja trouv� le sens de progression
    begin
      repeat
        if nivDebug=3 then AfficheDebug('i='+IntToSTR(i)+' NDet='+IntToSTR(N_det),clyellow);
        if (AdrFonc<>0) or (TypeFonc<>rien) then Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg) else
        begin
          Adr:=9999;
        end;

        if TypeGen=det then inc(N_Det);
        if NivDebug=3 then
        begin
          s:='613.1 : Suivant='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
        end;

       // modif sp�cial TJD ==============
       ia:=index_aig(adrfonc);
       if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         AdrPrec:=aiguillage[ia].Ddevie else
       // ================================
        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((typeDet2=TypeGen) and (Adr=el2)) or (Adr=0) or (Adr>=9990) or (i=15) or (N_Det=2);
      until sortie ;
      if (i=itMaxi) and (Nivdebug=3) then afficheDebug('Pas trouv�',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(el1)+' '+intToSTR(el2);
        afficheDebug(s,clorange);
      end;
    end

    else
    begin
      // d�ja trouv�
      adr:=el2;typeGen:=TypeDet2;
    end;

    // ---------- phase 2
    IdActTr:=0;   // init pointeur des actionneurs
    if nivDebug=3 then afficheDebug('Init pointeur actionneurs',clLime);
    idel:=1;
    if (typeDet2=TypeGen) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      if Nivdebug=3 then AfficheDebug('614 - Trouv� '+intToSTR(el2),clOrange);
      inc(idEl);
      elements[idEl].adresse:=el2;
      elements[idEl].typ:=Typedet2;

      i:=0;
      repeat
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg);

        if NivDebug=3 then
        begin
          s:='615 : trouv�='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clorange);
        end;
        inc(idEl);
        elements[idEl].adresse:=adr;
        elements[idEl].typ:=TypeGen;

        // modif sp�cial TJD ==============
        ia:=index_aig(ADrFonc);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
          AdrPrec:=aiguillage[ia].Ddevie else
        // ================================

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=(TypeGen=det) or (Adr=0) or (Adr>=9990) or (i>=itMaxi);
      until sortie;
      if i>=itMaxi then Affiche('Erreur 67 : D�passement it�rations',clred);
      if (TypeGen=det) or (TypeGen=buttoir) then
      begin
        Eprec:=AdrPrec;tprec:=TypePrec;
        Esuiv:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg);
        tsuiv:=typegen;
        if NivDebug=3 then
        begin
          AfficheDebug('Le d�tecteur suivant est le '+IntToSTR(Adr),clyellow);
          affichedebug('------------------',clyellow);
        end;
        detecteur_suivant_el:=Adr;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
    end;
    if (i>=itMaxi) then if NivDebug=3 then AfficheDebug('201 : It�ration trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incr�ment/d�cr�ment

  detecteur_suivant_el:=9996;
  if NivDebug=3 then affichedebug('------------------',clyellow);
  if debug=3 then formprinc.Caption:='';
end;

// trouve les actionneurs entre el1 et el2
procedure trouve_actionneur(el1,el2 : integer);
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,i1,N_det,Ia,delta : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;

begin
  proc:=ttrouve_actionneur;
  param1:=el1;
  param2:=el2;
  if NivDebug>=2 then
  AfficheDebug('trouve_actionneur '+intToSTR(el1)+','+intToSTR(el2)+','+'-------------------------',clLime);
  if (el1>9000) or (el2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('Param�tres incorrects >9000',clred);
    exit;
  end;

  if (el2=0) then
  begin
    exit;
  end;

  // trouver d�tecteur 1
  trouve_element(el1,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(el1)+' non trouv�';
      AfficheDebug(s,clOrange);
    end;
    exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver d�tecteur 2
  trouve_element(el2,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(el2)+' non trouv�';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    exit;
  end;

  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  j:=1;  // J=1 test en incr�ment J=2 test en d�cr�ment
  idEl:=1;
  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)

  repeat
    //pr�parer les variables
    AdrPrec:=el1;TypePrec:=det;
    IdActTr:=0;   // init pointeur des actionneurs
    if nivDebug=3 then afficheDebug('Init pointeur actionneurs',clLime);
    // sens
    //========================nouveau
    delta:=1;
    repeat
      if j=1 then i1:=IndexBranche_det1+delta;
      if j=2 then i1:=IndexBranche_det1-delta;
      if i1=0 then begin exit;end;

      AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
      typeFonc:=BrancheN[branche_trouve_det1,i1].Btype;

      if typeFonc=act then
      begin
        if nivDebug=3 then AfficheDebug('Act='+intToSTR(AdrFonc),clLime);
        inc(IdActTr);
        Actionneur_trouve[IdActTr]:=adrFonc;
      end;

      elements[idEl].adresse:=adrFonc;
      elements[idEl].typ:=TypeFonc;
      inc(delta);
    until typeFonc<>act ;
    //===============================

    N_Det:=0;
    if Typefonc=det then N_det:=1;


    if NivDebug=3 then
    begin
      s:='------> Test en ';
      if (j=1) then s:=s+'incr�ment ' else s:=s+'d�cr�ment ';
      s:=s+'- d�part depuis �l�ment '+IntToSTR(el1)+' trouv� en index='+intToSTR(IndexBranche_det1)+' Branche='+intToSTR(branche_trouve_det1);
      AfficheDebug(s,clyellow);
    end;

    i:=0;
    if AdrFonc<>El2 then // si pas d�ja trouv� le sens de progression
    begin
      repeat
        if nivDebug=3 then AfficheDebug('i='+IntToSTR(i)+' NDet='+IntToSTR(N_det),clyellow);
        if (AdrFonc<>0) or (TypeFonc<>rien) then Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,1) else
        begin
          Adr:=9999;
        end;

        if TypeGen=det then inc(N_Det);
        if NivDebug=3 then
        begin
          s:='613.1 : Suivant='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
          if adr=el2 then exit;
        end;

       // modif sp�cial TJD ==============
       ia:=index_aig(adrfonc);
       if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         AdrPrec:=aiguillage[ia].Ddevie else
       // ================================
        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((TypeGen=det) and (Adr=el2)) or (Adr=0) or (Adr>=9990) or (i=15) or (N_Det=2);
      until sortie ;
      if (i=itMaxi) and (Nivdebug=3) then afficheDebug('Pas trouv�',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(el1)+' '+intToSTR(el2);
        afficheDebug(s,clorange);
      end;
    end

    else
    begin
      // d�ja trouv�
      adr:=el2;typeGen:=det;
    end;

    // ---------- phase 2
    IdActTr:=0;   // init pointeur des actionneurs
    if nivDebug=3 then afficheDebug('Init pointeur actionneurs',clLime);
    idel:=1;
    if (TypeGen=det) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      if Nivdebug=3 then AfficheDebug('614 - Trouv� '+intToSTR(el2),clOrange);
      exit;
      inc(idEl);
      elements[idEl].adresse:=el2;
      elements[idEl].typ:=det;

      i:=0;
      repeat
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,1);

        if NivDebug=3 then
        begin
          s:='615 : trouv�='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clorange);
        end;
        inc(idEl);
        elements[idEl].adresse:=adr;
        elements[idEl].typ:=TypeGen;

        // modif sp�cial TJD ==============
        ia:=index_aig(ADrFonc);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
          AdrPrec:=aiguillage[ia].Ddevie else
        // ================================

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=(TypeGen=det) or (Adr=0) or (Adr>=9990) or (i>=itMaxi);
      until sortie;
      if i>=itMaxi then Affiche('Erreur 67 : D�passement it�rations',clred);
      if (TypeGen=det) or (TypeGen=buttoir) then
      begin
        if NivDebug=3 then
        begin
          AfficheDebug('le d�tecteur suivant est le '+IntToSTR(Adr),clyellow);
          affichedebug('------------------',clyellow);
        end;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
    end;
    if (i>=itMaxi) then if NivDebug=3 then AfficheDebug('201 : It�ration trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incr�ment/d�cr�ment

  if NivDebug=3 then affichedebug('------------------',clyellow);
  if debug=3 then formprinc.Caption:='';
end;


// renvoie le nombre de croisements entre les d�tecteurs el1 et el2
// jamais utilis�e !
function Test_croisement(el1,el2,alg: integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,i1,N_det,ia : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;

begin
  if NivDebug>2 then AfficheDebug('Proc Test_croisement '+intToSTR(el1)+','+intToSTR(el2)+',',clyellow);
  if (el1>9000) or (el2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('param�tres incorrects >9000',clred);
    Test_croisement:=9999;
    exit;
  end;

  // trouver d�tecteur 1
  trouve_element(el1,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(el1)+' non trouv�';
      AfficheDebug(s,clOrange);
    end;
    Test_croisement:=9999;
    exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver d�tecteur 2
  trouve_element(el2,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(el2)+' non trouv�';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    Test_croisement:=9999;exit;
  end;
  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  j:=1;  // J=1 test en incr�ment J=2 test en d�cr�ment

  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)

  repeat
    //pr�parer les variables
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
      if (j=1) then s:=s+'incr�ment ' else s:=s+'d�cr�ment ';
      s:=s+'- d�part depuis �l�ment '+IntToSTR(el1)+' trouv� en index='+intToSTR(IndexBranche_det1)+' Branche='+intToSTR(branche_trouve_det1);
      AfficheDebug(s,clyellow);
    end;

    i:=0;N_Det:=0;
    if AdrFonc<>El2 then // si pas d�ja trouv� le sens de progression
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
          s:='713 : trouv�='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
        end;

        // modif sp�cial TJD ==============
        ia:=index_aig(AdrFonc);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
           AdrPrec:=aiguillage[ia].Ddevie else
        // ================================

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((TypeGen=det) and (Adr=el2)) or (Adr=0) or (Adr>=9990) or (i>=itMaxi) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i>=itMaxi) and (Nivdebug=3) then afficheDebug('Pas trouv�',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(el1)+' '+intToSTR(el2);
        afficheDebug(s,clorange);
      end;
    end

    else
    begin
      // d�ja trouv�
      adr:=el2;typeGen:=det;
    end;

    if (TypeGen=det) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      test_croisement:=ncrois;
      exit;
    end;
    if (i>=itMaxi) then if NivDebug=3 then AfficheDebug('711 : It�ration trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incr�ment/d�cr�ment

  Test_croisement:=0;
  ncrois:=0;    // annuler le croisement d�tect�
  if NivDebug=3 then affichedebug('------------------',clyellow);
end;

// renvoie vrai si les aiguillages d�clar�s pour le feu blanc sont bien positionn�s
function cond_feuBlanc(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig,index : integer;
    resultatET,resultatOU: boolean;
    s : string;
begin
  i:=Index_Signal(adresse);
  if i=0 then
  begin
    s:='Erreur 602 - Signal '+IntToSTR(adresse)+' non trouv�';
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
        if nivDebug=3 then AfficheDebug('Contr�le aiguillage '+IntToSTR(AdrAig),clyellow);
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


// renvoie vrai si les aiguillages d�clar�s dans les conditions suppl�mentaires pour le signal "adresse" sont mal positionn�s
function cond_carre(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig,index : integer;
    resultatET,resultatOU: boolean;
    s : string;
begin
  proc:=Tcond_carre;
  param1:=adresse;
  i:=Index_Signal(adresse);
  if i=0 then
  begin
    s:='Erreur 602 - Signal '+IntToSTR(adresse)+' non trouv�';
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
        if nivDebug=3 then AfficheDebug('Contr�le aiguillage '+IntToSTR(AdrAig),clyellow);
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
    s:='Conditions supp. de carr� suivant aiguillages: ';
    if ResultatOU then s:=s+'le signal doit afficher carr�' else s:=s+'le signal ne doit pas afficher de carr�';
    AfficheDebug(s,clyellow);
  end;
  cond_carre:=ResultatOU;
end;

// renvoie l'adresse de l'aiguillage mal positionn� si le signal adresse doit afficher un carr� car les aiguillages au dela du signal
// sont mal positionn�s. renvoie 0 si les aiguillages sont bien positionn�s
// et teste si les �l�ments jusqu'au signal suivant s'ils sont verrouill�s
// TrainReserve : adresse du train qui demande la fonction ou 0
// Si reserveTrainTiers=vrai, le parcours est r�serv� par un autre train
function carre_signal(adresse,TrainReserve : integer;var reserveTrainTiers : boolean;Var AdrTrain : integer) : integer;
var
   ia,i,j,k,prec,AdrSuiv,indexSig1,indexSig2,voieSig1,voieSig2,AdrSignal,voie : integer;
   TypeELPrec,TypeElActuel : TEquipement;
   sort,prestrain  : boolean;
   s : string;
begin
  proc:=Tcarre_signal;
  param1:=adresse;
  param2:=TrainReserve;
  AdrTrain:=0;
  ReserveTrainTiers:=false;
  if (NivDebug>=1) or ProcPrinc then AfficheDebug('Proc carre_signal '+IntToSTR(adresse)+' -----------',clyellow);

  i:=Index_Signal(adresse);
  if i=0 then
  begin
    s:='Erreur 603 - Signal '+IntToSTR(adresse)+' non trouv�';
    Affiche(s,clred);
    if NivDebug=3 then AfficheDebug(s,clred);
    carre_signal:=adresse;
    exit;
  end;

  if isDirectionnel(i) then
  begin
    s:='La demande de carr� d''un signal directionnel '+IntToSTR(Adresse)+' est irrecevable';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    carre_signal:=adresse;
    exit;
  end;

  j:=0;
  prec:=Signaux[i].Adr_det1;
  if prec=0 then Begin affiche('Msg 681 : Signal '+intToSTR(adresse)+' d�tecteur non renseign�',clOrange);result:=0;exit;end;
  TypeElPrec:=Det;
  actuel:=Signaux[i].Adr_el_suiv1;
  if Signaux[i].Btype_suiv1=det then TypeElActuel:=det;  // le type du signal   1=d�tecteur   2=aig  5=bis
  if Signaux[i].Btype_suiv1=aig then TypeElActuel:=aig;

  // en multivoie, trouver si une des voies pr�sente un train
  if Signaux[i].Adr_det2<>0 then
  begin
    prestrain:=presTrainPrec(adresse,Nb_cantons_Sig,false,AdrTrain,voie); // retourne la voie o� se trouve le train avant le signal
    if prestrain then
    begin
      if nivdebug=3 then AfficheDebug('trouv� train sur voie '+intToSTR(voie),clYellow);
      case voie of
      1: begin prec:=Signaux[i].Adr_det1; actuel:=Signaux[i].Adr_el_suiv1; TypeElActuel:=Signaux[i].Btype_suiv1; end;
      2: begin prec:=Signaux[i].Adr_det2; actuel:=Signaux[i].Adr_el_suiv2; TypeElActuel:=Signaux[i].Btype_suiv2; end;
      3: begin prec:=Signaux[i].Adr_det3; actuel:=Signaux[i].Adr_el_suiv3; TypeElActuel:=Signaux[i].Btype_suiv3; end;
      4: begin prec:=Signaux[i].Adr_det4; actuel:=Signaux[i].Adr_el_suiv4; TypeElActuel:=Signaux[i].Btype_suiv4; end;
      end;
      if (prec=0) then
      begin
        s:='Erreur 780 : d�tecteur nul d�clar� sur signal '+intToSTR(adresse);
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
      // si pas de train avant signal : verrouiller au carr�
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
        if (nivdebug>=1) then AfficheDebug('Aiguillage '+intToSTR(aiguillage[k].adresse)+' verrouill� par train @'+intToSTR(AdrTrain),clorange);
      end;
    end;
  end;

  //Affiche(IntToSTR(actuel),clyellow);
  sort:=false;
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(prec,typeElPrec,actuel,typeELActuel,2);  // arret sur aiguille en talon mal position�ne

    if (AdrSuiv=9999) or (AdrSuiv=9996) or (AdrSuiv=9995) then // �l�ment non trouv� ou position aiguillage inconnu ou buttoir
    begin;
      carre_signal:=AigMal;
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    if (AdrSuiv<>9998) then // pas arret sur aiguillage en talon mal positionn�e
    begin
      // modif sp�cial TJD ==============
      ia:=index_aig(Actuel);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         prec:=aiguillage[ia].Ddevie else
      // ================================


      prec:=actuel;
      TypeElPrec:=TypeElActuel;
      actuel:=AdrSuiv;
      TypeElActuel:=typeGen;
    end;

    // si le pr�c�dent est un d�tecteur comporte t-il un signal?
    indexSig1:=0;
    indexSig2:=0;

    if (typeElPrec=det) then
    begin
      index_signal_det(prec,voieSig1,indexSig1,voieSig2,indexSig2); // trouve l'index du signal correspondant au d�tecteur AdrSuiv

      if indexSig1<>0 then
      begin
        AdrSignal:=Signaux[indexSig1].adresse;

        if nivdebug=3 then s:='Trouv� signal '+intToSTR(AdrSignal);
        if ((voieSig1=1) and (Signaux[indexSig1].Adr_el_suiv1=AdrSuiv)) or
           ((voieSig1=2) and (Signaux[indexSig1].Adr_el_suiv2=AdrSuiv)) or
           ((voieSig1=3) and (Signaux[indexSig1].Adr_el_suiv3=AdrSuiv)) or
           ((voieSig1=4) and (Signaux[indexSig1].Adr_el_suiv4=AdrSuiv))
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
          indexSig1:=0;
          // 2eme signal?
          if indexSig2<>0 then
          begin
            // v�rifier le 2eme signal
            AdrSignal:=Signaux[indexSig2].Adresse;

            if (adrSignal=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
            begin
              IndexSig2:=0;
              sort:=true; // on ne trouve pas de suivant
            end;
            if (Signaux[indexSig2].Adr_el_suiv1=AdrSuiv) then   // le signal est-il dans le bon sens de progression?
            begin
              // oui
              if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� signal2 suivant Adr='+IntToSTR(AdrSignal)+': ',clYellow);
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� signal2 '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
              IndexSig2:=0;
            end;
         end;
        end;
      end;
      //Affiche(IntToSTR(AdrFeu),clOrange);
    end;

    // si le suivant est un aiguillage , mais ne v�rifier que si pas trouv� de signal
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
          if (nivdebug>=1) then AfficheDebug('Aiguillage '+intToSTR(aiguillage[k].adresse)+' verrouill� par train @'+intToSTR(AdrTrain),clorange);
        end;
      end;
    end;
    if (typeElActuel=det) and (AdrSignal=0) then
    begin
      // adresse
      if detecteur[actuel].AdrTrainRes<>0 then
      begin
        AdrTrain:=detecteur[actuel].AdrTrainRes;
        if adrTrain<>0 then
        begin
          reserveTrainTiers:=reserveTrainTiers or (AdrTrain<>Trainreserve);
          if (nivdebug>=1) then AfficheDebug('D�tecteur '+intToSTR(actuel)+' verrouill� par train @'+intToSTR(AdrTrain),clorange);
        end;
      end;
    end;

    sort:=(j>=itMaxi) or (indexSig1<>0) or (indexSig2<>0) or (AdrSuiv=9998) or (AdrSuiv=0) or sort; // arret si aiguillage en talon ou buttoir
  until (sort);
  if j>=itMaxi then Affiche('Erreur 76 : it�ration maximale',clred);
  // si trouv� un signal ou j=10, les aiguillages sont bien positionn�s
  // si trouv� 9998, aiguillages mal positionn�s
  if (NivDebug=3) then
  begin
   if (AdrSuiv=9998) then AfficheDebug('Le signal '+intToSTR(adresse)+' doit afficher un carr� car l''aiguillage pris en talon '+IntToSTR(actuel)+' est mal positionn�',clYellow);
   if AdrTrain<>0 then afficheDebug('Un aiguillage est r�serv� par le train '+intToSTR(AdrTrain),clyellow);
   if (AdrSuiv<>9998) and (AdrTrain=0) then AfficheDebug('Le signal '+intToSTR(adresse)+' ne doit pas afficher de carr�',clyellow);
  end;
  if AdrSuiv=9998 then result:=actuel else result:=0;
  //AdrSuiv=9998;
  if debug=3 then formprinc.Caption:='';
end;


// renvoie l'adresse du signal suivant (et dans le bon sens) � partir du d�tecteur det1 (non compris) et dans le sens det1 vers det2.
// Si renvoie 0, pas trouv� le signal suivant.
function signal_suivant_det(det1,det2 : integer) : integer;
var num_signal,AdrSignal,i,j,prec,AdrSuiv,indexSig1,indexSig2,voie1,voie2,ia : integer;
    Typ,TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  proc:=tsignal_suivant_det;
  param1:=det1;
  param2:=det2;
  //traceDet:=true;
  if (NivDebug>=2) or ProcPrinc then AfficheDebug('Cherche signal suivant au d�tecteurs '+IntToSTR(det1)+' '+intToSTR(det2),clyellow);

  if (det1>NbMaxDet) or (det2>NbMaxDet) then
  begin
    Affiche('Erreur 64 : signal_suivant_det '+intToSTR(det1)+' '+intToSTr(det2),clred);
    exit;
  end;

  // trouve l'�l�ment suivant contigu
  det_contigu(det2,det1,i,Typ);
  if (i=0) or (i=9995) then  // 9995:buttoir
  begin
    //affiche('Erreur 65 : Signal_suivant_det('+intToSTR(det1)+','+intToSTR(det2)+') ne sont pas li�s ',clred);
    signal_suivant_det:=0;
    exit;
  end;

  // si det1 et det2 sont contigus, i=det1
  // sinon i contient l'adresse de l'aiguillage avant det2

  if debug=3 then formprinc.Caption:='signal_suivant_det '+intToSTR(det1)+' '+inttostr(det2);
  j:=0;
  prec:=det1;  // d�tecteur sur le courant
  TypePrec:=det;
  if prec=0 then
  begin
    Affiche('Msg 601 - Signal '+intToSTR(prec)+' d�tecteur non renseign� ',clOrange);
    if NivDebug=3 then AfficheDebug('Msg 602 - d�tecteur '+intToSTR(prec)+' non renseign� ',clOrange);
    signal_suivant_det:=0;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;

  actuel:=i;
  typeActuel:=typ;

  if nivDebug=3 then AfficheDebug('Actuel ='+IntToSTR(actuel),clyellow);
  repeat
    inc(j);
    if nivDebug=3 then AfficheDebug('It�ration '+IntToSTR(j),clyellow);

    // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
    if (j=1) and (TypeActuel=det) then
    begin
      AdrSuiv:=actuel;
    end
    else
    begin
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);  // arret sur �l�ment suivant
      if Nivdebug=3 then AfficheDebug('Suivant='+intToSTR(AdrSuiv),clyellow);

      // modif sp�cial TJD ==============
      ia:=index_aig(actuel);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         prec:=aiguillage[ia].Ddevie else
      // ================================


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
    // si le suivant est un d�tecteur comporte t-il un signal?
    AdrSignal:=0;
    if (TypeActuel=det) then  // d�tecteur?
    begin
      //i:=Index_signal_det(Actuel,voie,index2); // trouve l'index de signal affect� au d�tecteur "Actuel"
      //Index_signal_det(Actuel,voie,index2);
      index_signal_det(actuel,voie1,indexSig1,voie2,indexSig2);
      if indexSig1<>0 then
      begin
        AdrSignal:=Signaux[indexSig1].Adresse;
        if (AdrSignal=det1) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
        begin
          AdrSignal:=0;j:=10; // on ne trouve pas de suivant
        end;
        if (AdrSignal<>0) then // si l'adresse est <>0
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          if nivdebug=3 then afficheDebug('Trouv� signal='+IntToSTR(AdrSignal)+'sur det '+intToSTR(actuel)+' Suivant='+IntToSTR(AdrSuiv)+' sur voie='+IntToSTR(voie1),clyellow );
          if ((voie1=1) and (Signaux[indexSig1].Adr_el_suiv1=AdrSuiv)) or
             ((voie1=2) and (Signaux[indexSig1].Adr_el_suiv2=AdrSuiv)) or
             ((voie1=3) and (Signaux[indexSig1].Adr_el_suiv3=AdrSuiv)) or
             ((voie1=4) and (Signaux[indexSig1].Adr_el_suiv4=AdrSuiv))
          then   // le signal est-il dans le bon sens de progression?
          begin
            // oui
            signal_suivant_det:=AdrSignal;
            if NivDebug=3 then
            begin
              s:='Trouv� signal suivant Adr='+IntToSTR(AdrSignal);
              AfficheDebug(s,clorange);
            end;
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouv� signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
            AdrSignal:=0;
            if indexSig2<>0 then
            begin
              // v�rifier le 2eme signal
              AdrSignal:=Signaux[indexSig2].Adresse;
              if (AdrSignal=det1) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
              begin
                 AdrSignal:=0;j:=10; // on ne trouve pas de suivant
              end;
              if (Signaux[indexSig2].Adr_el_suiv1=AdrSuiv) then   // le signal est-il dans le bon sens de progression?
              begin
                // oui
                inc(num_signal);
                signal_suivant_det:=AdrSignal;
                if NivDebug=3 then
                begin
                  s:=IntToSTR(AdrSignal);
                  AfficheDebug('Sur m�me d�tecteur, trouv� signal2 suivant Adr='+s,clorange);
                end;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� signal2 '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
                AdrSignal:=0;
              end;
            end;
          end;
        end
      end
      else if nivDebug=3 then AfficheDebug('Pas de signal pour le det '+IntToSTR(AdrSuiv),clyellow);
    end;
  until (j>=itMaxi) or (AdrSignal<>0);
  signal_suivant_det:=AdrSignal;
  if j>=itMaxi then affiche('Erreur 77 : it�ration maximale',clred);
  if debug=3 then formprinc.Caption:='';
  if (NivDebug=3) and (AdrSignal=0) then AfficheDebug('Pas Trouv� de signal suivant au signal Adr='+IntToSTR(det1),clOrange);
end;

function modele(adresse : integer;mdl : tEquipement) : tequipement;
begin
  if mdl=det then result:=det;
  if mdl=aig then
  begin
    result:=aiguillage[index_aig(adresse)].modele;
  end;
end;


// renvoie l'�tat du signal suivant du signal "adresse". Si renvoie 0, pas trouv� le signal suivant.
// les aiguillages en pointe doivent �tre positionn�s
// adresse : adresse du signal
// rang=1 pour signal suivant, 2 pour signal suivant le 1, etc
// retour dans AdrSignalsuivant : adresse du signal suivant
// remplit aussi les �lements[] rencontr�s
// stocke les �l�ments trouv�s dans Elements
function etat_signal_suivant(Adresse,rang : integer;var AdrSignalsuivant : integer) : integer;
const MaxIt=20;
var index,num_signal,etat,AdrSignal,i,j,prec,AdrSuiv,indexSig1,indexSig2,voie1,voie2 : integer;
    aspect,combine,ia : integer;
    TypePrec,TypeActuel,typ : TEquipement;
    s : string;
begin
  proc:=Tetat_signal_suivant;
  param1:=adresse;
  param2:=rang;
  if ProcPrinc or (NivDebug>=2) then AfficheDebug('Cherche �tat du signal suivant au '+IntToSTR(adresse),clyellow);
  Application.ProcessMessages;
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    if NivDebug>=2 then AfficheDebug('Signal '+IntToSTR(adresse)+' non trouv�',clyellow);
    etat_signal_suivant:=0;
    AdrSignalsuivant:=0;
    exit;
  end;
  if isDirectionnel(i) then
  begin
    s:='La demande de l''�tat du signal suivant depuis un signal directionnel '+IntToSTR(Adresse)+' est irrecevable';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    etat_signal_suivant:=0;
    exit;
  end;

  Etat:=0;
  j:=0;
  num_signal:=0;
  prec:=Signaux[i].Adr_det1;  // d�tecteur sur le courant
  TypePrec:=det;
  if prec=0 then
  begin
    s:='Msg 601 - Signal '+intToSTR(adresse)+' d�tecteur non renseign�';
    Affiche(s,clOrange);
    if NivDebug=3 then AfficheDebug(s,clOrange);
    etat_signal_suivant:=0;
    AdrSignalsuivant:=0;
    exit;
  end;

  if debug=3 then formprinc.Caption:='Etat_signal_suivant '+intToSTR(adresse);
  actuel:=Signaux[i].Adr_el_suiv1;
  typeActuel:=Signaux[i].Btype_suiv1;

  elements[1].adresse:=prec;elements[1].typ:=typePrec;
  elements[2].adresse:=actuel;elements[2].typ:=typeActuel;
  idEl:=3;

  if nivDebug=3 then AfficheDebug('Actuel ='+IntToSTR(actuel),clyellow);
  repeat
    inc(j);
    if nivDebug=3 then AfficheDebug('It�ration '+IntToSTR(j),clyellow);

    // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
    if (j=1) and (TypeActuel=det) then
    begin
      AdrSuiv:=actuel;
    end
    else
    begin
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1); // 1 =
      if Nivdebug=3 then
      begin
        if AdrSuiv=9996 then AfficheDebug('position aiguillage inconnue',clorange) else
        AfficheDebug('Suivant='+intToSTR(AdrSuiv),clyellow);
      end;

      // modif sp�cial TJD ==============
      ia:=index_aig(Actuel);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         Prec:=aiguillage[ia].Ddevie else
      // ================================

      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

      if idEl<Maxelements then
      begin
        // rectifier le type de l'�l�ment
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
        Etat_signal_suivant:=carre_F; // faire comme si c'�tait un signal au carr�
        AdrSignalsuivant:=0;
        if debug=3 then formprinc.Caption:='';
        exit;
      end;
    end;
    // si le suivant est un d�tecteur comporte t-il un signal?
    AdrSignal:=0;
    if (TypeActuel=det) then  // d�tecteur?
    begin
      //  i:=Index_signal_det(Actuel,voie,index2); // trouve l'index de signal affect� au d�tecteur "Actuel"
      index_signal_det(actuel,voie1,indexSig1,voie2,indexSig2);
      if indexSig1<>0 then
      begin
        AdrSignal:=Signaux[indexSig1].Adresse;
        if (AdrSignal=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
        begin
          AdrSignal:=0;j:=MaxIt; // on ne trouve pas de suivant : provoquer la sortie
        end;
        if (AdrSignal<>0) then // si l'adresse est <>0
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);

          if nivdebug=3 then afficheDebug('Trouv� signal='+IntToSTR(AdrSignal)+'sur det '+intToSTR(actuel)+' Suivant='+IntToSTR(AdrSuiv)+' sur voie='+IntToSTR(voie1),clyellow );
          if ((voie1=1) and (Signaux[indexSig1].Adr_el_suiv1=AdrSuiv)) or
             ((voie1=2) and (Signaux[indexSig1].Adr_el_suiv2=AdrSuiv)) or
             ((voie1=3) and (Signaux[indexSig1].Adr_el_suiv3=AdrSuiv)) or
             ((voie1=4) and (Signaux[indexSig1].Adr_el_suiv4=AdrSuiv))
          then   // le signal est-il dans le bon sens de progression?
          begin
            // oui
            inc(num_signal);
            Etat:=Signaux[IndexSig1].EtatSignal;
            code_to_aspect(Etat,aspect,combine);
            Signal_suivant:=AdrSignal;
            if NivDebug=3 then
            begin
              s:='Trouv� signal suivant Adr='+IntToSTR(AdrSignal)+': '+IntToSTR(etat)+'=';
              s:=s+chaine_signal(AdrSignal);
              AfficheDebug(s,clorange);
            end;
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouv� signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
            AdrSignal:=0;
            if indexSig2<>0 then
            begin
               // v�rifier le 2eme signal
               AdrSignal:=Signaux[indexSig2].Adresse;

               if (AdrSignal=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
               begin
                 AdrSignal:=0;j:=10; // on ne trouve pas de suivant
               end;
               if (Signaux[indexSig2].Adr_el_suiv1=AdrSuiv) then   // le signal est-il dans le bon sens de progression?
               begin
                 // oui
                 inc(num_signal);
                 Etat:=Signaux[IndexSig2].EtatSignal;
                 code_to_aspect(Etat,aspect,combine);
                 Signal_suivant:=AdrSignal;
                 if NivDebug=3 then
                 begin
                   s:=IntToSTR(AdrSignal)+': '+IntToSTR(etat)+'=';
                   if aspect<>-1 then s:=s+EtatSign[aspect]+' ';
                   if combine<>-1 then s:=s+EtatSign[combine];
                   AfficheDebug('Sur m�me d�tecteur, trouv� signal2 suivant Adr='+s,clorange);
                 end;
               end
               else
               begin
                 if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� signal2 '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clOrange);
                 AdrSignal:=0;
               end;
            end;
          end;
        end
      end
      else if nivDebug=3 then AfficheDebug('Pas de signal pour le det '+IntToSTR(AdrSuiv),clyellow);
    end;
  until (j>=MaxIt) or ((AdrSignal<>0) and (num_signal=rang));   
  // laisser 20, il peut ne pas y avoir de signal suivant

  if etat=0 then Signal_Suivant:=0;
  etat_signal_suivant:=Etat;
  AdrSignalsuivant:=Signal_suivant;
  if (NivDebug=3) and (AdrSignal=0) then AfficheDebug('Pas trouv� de signal suivant au signal Adr='+IntToSTR(ADresse)+')',clOrange);
end;

// renvoie l'adresse de la premi�re aiguille d�vi�e apr�s le signal "adresse" et ce jusqu'au prochain signal
// sinon il n'y a pas d'aiguille ou si pas d�vi�, renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;
var AdrSignal,i,j,prec,AdrSuiv,Actuel,index,indexSig1,indexSig2,voie1,voie2,ia : integer;
   TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  proc:=TAiguille_deviee;
  param1:=adresse;
  if NivDebug>=2 then AfficheDebug('Test si aiguille d�vi�e apr�s signal '+IntToSTR(Adresse),clOrange);
  j:=0;
  i:=Index_Signal(adresse);
  if i=0 then
  begin
    Affiche('Erreur 168: signal '+intToSTR(adresse)+' non trouv�',clred);
    Aiguille_deviee:=0;
    exit;
  end;
  prec:=Signaux[i].Adr_det1;
  if prec=0 then begin affiche('Msg 683 : Signal '+intToSTR(adresse)+' d�tecteur non renseign�',clOrange);result:=0;exit;end;
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
    // le 8=demande si le suivant est un aiguillage en pointe d�vi� oui si AdrSuiv=9997
    // dans ce cas la variable globale AdrDevie est mise � jour
    AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,8);  //

    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if (AdrSuiv<>9997) and (AdrSuiv<>0) then
    begin
      // pas trouv� aig d�vi�

      // modif sp�cial TJD ==============
      ia:=index_aig(Actuel);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         Prec:=aiguillage[ia].Ddevie else
      // ================================

      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      // si le suivant est un d�tecteur comporte t-il un signal?
      AdrSignal:=0;
      if (TypeActuel=det) then  // d�tecteur
      begin
//        i:=Index_signal_det(AdrSuiv,voie,index2); // trouve l'index de feu affect� au d�tecteur "AdrSuiv"
        index_signal_det(AdrSuiv,voie1,indexSig1,voie2,indexSig2);

        // � compl�ter par signal inverse
        AdrSignal:=Signaux[indexSig1].Adresse;


        if NivDebug=3 then AfficheDebug('trouv� signal '+intToSTR(AdrSignal)+' associ� au d�tecteur '+IntToSTR(AdrSuiv),clyellow);
      end;
    end;
  until (j>=itMaxi) or (AdrSuiv>=9990) or (AdrSignal<>0) or (AdrSuiv=0) ;

  if j>=itMaxi then affiche('Erreur 79 : it�ration maximale Aiguille_deviee('+intToSTR(adresse)+')',clred);
  if (AdrSuiv=9997) then
  begin
     s:='Le signal '+intToSTR(adresse)+' doit afficher un rappel car l''aiguillage '+intToSTR(AdrDevie);
     s:=s+' est d�vi�';
     if NivDebug=3 then AfficheDebug(s,clWhite);
  end;
  if ((AdrSuiv<>9997) or (j>=itmaxi)) and (NivDebug=3) then
  begin
    S:='Le signal '+intToSTR(adresse)+' ne doit pas afficher de rappel car ';
    if j<itmaxi then s:=s+'trouv� un signal suivant ('+intToSTR(AdrSignal)+') et pas d''aiguillage d�vi�'
    else s:=s+' signal trop �loign�';
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

// allume le signal directionnel d'adresse ADR en fonction de la position des aiguillages d�clar�s pour ce signal
procedure Signal_direction(Adr : integer);
var NAig,i,id,j,NfeuxDir,AdrAigFeu,Position : integer;
    PosAigFeu : char;
    Positionok : boolean;
begin
  id:=Index_Signal(Adr);
  NfeuxDir:=Signaux[id].aspect-10;
  i:=1;   // i=1 position �teinte du feu ; pour les autres valeurs de i : nombre de feux allum�s
  repeat
    NAig:=length(Signaux[id].AigDirection[i])-1;
    if i=1 then positionok:=false else positionok:=true;
    for j:=1 to Naig do
    begin
      // v�rifier la position d�clar�e des aiguillages pour chaque feu
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
    dec(i,2);   // i correspond au nombre de feux � allumer
    pilote_direction(Adr,i);
  end;
end;

{
// test si train dans le bon sens sur canton d'index idcanton , sur d�tecteur prec
// si pres=faux : teste le sens de la loco dans le canton
// si pres=true ne teste que la pr�sence quelque soit le sens de la loco dans le canton
function Test_train_canton(prec : integer;typePrec : tequipement;actuel : integer;TypeActuel : tequipement;pres : boolean) : integer;
var AdrTr,sens,sens1,sens2,el1,el2,icanton : integer;
    tel1,tel2 : tequipement;
    tcanton : boolean;
begin
  icanton:=1;
  repeat
    el1:=canton[iCanton].el1;tel1:=Canton[iCanton].typ1;
    el2:=canton[iCanton].el2;tel2:=Canton[iCanton].typ2;
    tCanton:=((el1=prec) and (tel1=TypePrec) and (el2=actuel) and (tel2=TypeActuel)) or
             ((el1=actuel) and (tel1=TypeActuel) and (el2=prec) and (tel2=TypePrec));
    inc(icanton);
  until tCanton or (icanton>nCantons);
  dec(icanton);
  if tcanton then
  begin
    AdrTr:=canton[icanton].adresseTrain;
    sens:=canton[icanton].SensLoco;
    sens1:=canton[icanton].SensEl1;
    sens2:=canton[icanton].SensEl2;

    // v�rifier si le train dans le canton est dans le bon sens
    tcanton:= (sens=sensGauche) and (sens1=sensGauche) and (el1=prec) or
              (sens=sensDroit)  and (sens2=sensDroit) and (el2=prec) or
              (sens=sensHaut)  and (sens1=sensHaut) and (el1=prec) or
              (sens=sensBas)  and (sens2=sensBas) and (el2=prec) ;
    tcanton:= tcanton or pres;

    if (adrTr<>0) and tcanton then
    begin
      if nivDebug=3 then AfficheDebug('Trouv� train sur canton '+intToSTR(canton[iCanton].numero),clYellow);
      result:=AdrTr;
      exit;
    end;
  end;
  result:=0;
end;  }

// renvoie vrai si une m�moire de zone est occup�e apr�s le signal "adresse" jusqu'au
// nombre de signaux suivants d�fini par NSigMax=1, 2 ou 3.. (=canton)
// sort de suite si on trouve un train
// adresse=adresse du signal
function test_memoire_zones(adresse : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,i,j,it,
  dernierdet,AdrSignal,NSignaux,NSigMax,voie1,voie2,indexSig2,indexSig1,ia : integer;
  TypePrec,TypeActuel : TEquipement;
  Pres_train : boolean;
  s : string;
begin
  proc:=Ttest_memoire_zones;
  param1:=adresse;
  if NivDebug>=1 then AfficheDebug('Proc test_memoire_zones('+intToSTR(adresse)+')',clyellow);
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    s:='Erreur 605 - Signal '+IntToSTR(adresse)+' non trouv�';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    test_memoire_zones:=false;
    exit;
  end;

  Pres_Train:=false;
  if debug=3 then formprinc.Caption:='Test_memoire_zones '+IntToSTR(adresse);
  NSigMax:=1; // nombre de feux � trouver (nombre de cantons)

  ife:=1;  // index feu de 1 � 4 pour explorer les 4 d�tecteurs d'un feu
  repeat
    NSignaux:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test signal '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      prec:=Signaux[i].Adr_det1;
      Actuel:=Signaux[i].Adr_el_suiv1;
      TypeActuel:=Signaux[i].Btype_suiv1;
    end;  //d�tecteur sur le signal courant
    if (ife=2) then
    begin
      prec:=Signaux[i].Adr_det2;
      Actuel:=Signaux[i].Adr_el_suiv2;
      TypeActuel:=Signaux[i].Btype_suiv2;
    end;  // d�tecteur sur le signal courant
    if (ife=3) then
    begin
      prec:=Signaux[i].Adr_det3;
      Actuel:=Signaux[i].Adr_el_suiv3;
      TypeActuel:=Signaux[i].Btype_suiv3;
    end;  // d�tecteur sur le signal courant
    if (ife=4) then
    begin
      prec:=Signaux[i].Adr_det4;
      Actuel:=Signaux[i].Adr_el_suiv4;
      TypeActuel:=Signaux[i].Btype_suiv4;
    end;  // d�tecteur sur le signal courant

    if (actuel=0) or (actuel>NbMaxDet) or (prec=0) or (prec>NbMaxDet) then
    begin
      // sortie si aucun d�tecteur d�clar� sur le signal
      test_memoire_zones:=Pres_train;
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    Pres_train:=false;
    TypePrec:=det;
    dernierdet:=prec;

    // purge les aiguillages apr�s le signal
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

      // modif sp�cial TJD ==============
      ia:=index_aig(Actuel);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         Prec:=aiguillage[ia].Ddevie else
      // ================================

      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

      //Adrtr:=Test_train_canton(prec,typePrec,actuel,TypeActuel,true);  // non!!
      //pres_train:=(adrTr<>0) or pres_train;

      inc(it);
    until (typeactuel=det) or pres_Train or (it>100);

    if it>100 then
    begin
      Affiche('Erreur 750 : trop d''it�rations',clred);
      AfficheDebug('Erreur 750 : trop d''it�rations',clred);
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
          if Pres_Train then AfficheDebug('Pr�sence train de '+intToSTR(dernierdet)+' � '+intToSTR(actuel),clyellow)
          else AfficheDebug('Absence train de '+intToSTR(dernierdet)+' � '+intToSTR(actuel),clyellow)
        end;
        Pres_train:=MemZone[actuel,dernierdet].etat or Pres_Train;
        if (nivDebug=3) then
        begin
          if Pres_Train then AfficheDebug('Pr�sence train inverse de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow)
          else AfficheDebug('Absence train de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow)
        end;
        // sortir de suite
        if Pres_train then
        begin
          test_memoire_zones:=Pres_train;
          if debug=3 then formprinc.Caption:='';
          exit;
        end;

        dernierdet:=actuel;

//        isi:=index_signal_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au d�tecteur "AdrSuiv": il peut y avoir 4 d�tecteurs par signal
        index_signal_det(actuel,voie1,indexSig1,voie2,indexSig2);
        if indexSig1<>0 then
        begin
          AdrSignal:=Signaux[indexSig1].adresse;    // adresse du signal
          if (AdrSignal=adresse) then  // si on ne reboucle sur le m�me signal dont on cherche le suivant
          begin
            AdrSignal:=0;j:=10; // on ne trouve pas de suivant
            test_memoire_zones:=false;
            if debug=3 then formprinc.Caption:='';
            exit;
          end;
          if (AdrSignal<>0) then // si l'adresse est <>0
          begin
            if (Signaux[indexSig1].Adr_el_suiv1<>prec) then   // le signal est-il dans le bon sens de progression?
            begin
              inc(NSignaux);
              j:=0;
              s:='Trouv� signal (n�'+IntToSTR(NSignaux)+'/'+intToSTR(NSigMax)+') '+IntToSTR(AdrSignal);
              if (NivDebug=3) And Pres_Train then AfficheDebug(s+' et m�moire de zone � 1',clyellow);
              if (NivDebug=3) And (not(Pres_Train)) then AfficheDebug(s+' et m�moire de zone � 0',clOrange);
              if NSignaux=NSigMax then
              begin
                test_memoire_zones:=Pres_train;
                if debug=3 then formprinc.Caption:='';
              end;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('Trouv� signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
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

      // modif sp�cial TJD ==============
      ia:=index_aig(Actuel);
      if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
         Prec:=aiguillage[ia].Ddevie else
      // ================================

      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

    until (j=10) or pres_train or (NSignaux=NSigMax);  // on arrete si on va trop loin (10 it�rations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) then AfficheDebug('Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);
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


// supprime un �v�nement d�tecteur dans la liste Event_det[]
procedure supprime_event(i : integer);
var l : integer;
begin
  for l:=i to N_Event_det do event_det[l]:=event_det[l+1];
  dec(N_event_det);
end;

// trouve adresse d'un d�tecteur � "etat" avant "index" dans le tableau chrono
function trouve_index_det_chrono(Adr,etat,index : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  if index<=0 then
  begin
    affiche('Erreur 784 index d�tecteur invalide',clred);
    AfficheDebug('Erreur 784 index d�tecteur invalide',clred);
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

// renvoie l'adresse du signal pr�c�dent au signal "adresse"
// remplit aussi les �lements[] rencontr�s
// les positions des aiguillages pris en pointe doivent �tre connus
function Signal_precedent(adresse : integer) : integer;
var
  AdrSuiv,prec,ife,actuel,i,j,index,
  dernierdet,AdrSignal,Nsignaux,voie1,voie2,indexSig1,indexSig2,ia : integer;
  TypePrec,TypeActuel : TEquipement;
  malpositionne : boolean;
  s : string;
begin
  proc:=TSignal_precedent;
  param1:=adresse;
  if debug=3 then formprinc.Caption:='Signal_precedent '+IntToSTR(adresse);
  if NivDebug>=1 then AfficheDebug('Proc Signal_Precedent'+intToSTR(adresse)+')',clyellow);
  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    s:='Erreur 605 - Signal '+IntToSTR(adresse)+' non trouv�';
    AfficheDebug(s,clred);
    Affiche(s,clred);
    Signal_precedent:=0;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;
  idEl:=1;

  Nsignaux:=0;
  ife:=1;  // index feu de 1 � 4 pour explorer les 4 d�tecteurs d'un feu
  repeat
    j:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test signal voie '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      actuel:=Signaux[i].Adr_det1;
      prec:=Signaux[i].Adr_el_suiv1;
      Typeprec:=Signaux[i].Btype_suiv1;
    end;  //d�tecteur sur le signal courant
    if (ife=2) then
    begin
      actuel:=Signaux[i].Adr_det2;
      prec:=Signaux[i].Adr_el_suiv2;
      Typeprec:=Signaux[i].Btype_suiv2;
    end;  // d�tecteur sur le signal courant
    if (ife=3) then
    begin
      actuel:=Signaux[i].Adr_det3;
      prec:=Signaux[i].Adr_el_suiv3;
      Typeprec:=Signaux[i].Btype_suiv3;
    end;  // d�tecteur sur le signal courant
    if (ife=4) then
    begin
      actuel:=Signaux[i].Adr_det4;
      prec:=Signaux[i].Adr_el_suiv4;
      Typeprec:=Signaux[i].Btype_suiv4;
    end;  // d�tecteur sur le signal courant

    TypeActuel:=det;
    if actuel=0 then
    begin
      // sortie si aucun d�tecteur d�clar� sur le feu
      Signal_precedent:=0;
      if nivDebug=3 then AfficheDebug('Pas de voie '+intToSTR(ife),clyellow);
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    elements[idEl].adresse:=actuel;
    elements[idEl].typ:=det;
    inc(idEl);

    dernierdet:=actuel;

    repeat
      inc(j);
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      malpositionne:=(AdrSuiv=0) or (AdrSuiv>9990);
      if malpositionne then
      begin
        if (nivDebug=3) then
        begin
          if adrSuiv=9996 then AfficheDebug('Position aiguillage inconnue',clOrange)
          else
          if (AdrSuiv>9990) then AfficheDebug('Erreur 41: Alg3='+intToSTR(AdrSuiv)+' Anomalie',clYellow);
          if AdrSuiv=0 then AfficheDebug('Buttoir',clyellow);
        end;
        if debug=3 then formprinc.Caption:='';
        Signal_precedent:=0;
        exit;
      end;

      if not(malpositionne) then
      begin
        // modif sp�cial TJD ==============
        ia:=index_aig(Actuel);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
        Prec:=aiguillage[ia].Ddevie else
        // ================================

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

//         ifd:=index_signal_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au d�tecteur "AdrSuiv": il peut y avoir 4 d�tecteurs par signal
          index_signal_det(actuel,voie1,indexSig1,voie2,indexSig2);
          if indexSig1<>0 then
          begin
            AdrSignal:=Signaux[indexSig1].adresse;    // adresse du feu
            if (AdrSignal=adresse) then  // si on ne reboucle sur le m�me signal dont on cherche le suivant
            begin
              Signal_precedent:=0;
            end;
            if (AdrSignal<>0) then // si l'adresse est <>0
            begin
              if (Signaux[indexSig1].Adr_el_suiv1=prec) then   // le signal est-il dans le bon sens de progression?
              begin
                inc(Nsignaux);
                s:='Trouv� signal '+IntToSTR(AdrSignal);
                Signal_precedent:=AdrSignal;
                if debug=3 then formprinc.Caption:='';
                exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Trouv� signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
                AdrSignal:=0;
              end;
            end;
          end;
        end;
      end;
    until (j=10) or malpositionne ;  // on arrete jusqu'� trouver un signal ou si on va trop loin (10 it�rations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) then AfficheDebug('607. Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);
  if debug=3 then formprinc.Caption:='';
  Signal_precedent:=0;
end;

// trouve si un train est dans le canton idcanton, et dans le sens el1 -> el2
// si 1 trouv� train, AdresseTrain=son adresse
function test_canton(idcanton : integer;el1 : integer;tel1 : tequipement;el2 : integer;tel2 : tequipement; var AdresseTrain : integer) : integer;
var eL1c,eL2c,AdrTrain,elp,els,deta1 : integer;
    t1c,t2c,tp,ts : tequipement;
begin
  if nivdebug=3 then AfficheDebug('test_canton id='+intToSTR(idcanton)+' el1='+intToSTR(el1)+' el2='+intToSTR(el2),clOrange);
  deta1:=0;
  result:=0;
  AdresseTrain:=0;

  if idcanton=0 then exit;

  // test canton ------------------------------------
  AdrTrain:=canton[idcanton].adresseTrain;
  if adrTrain=0 then exit;

  // �l�ments adjacents au canton
  eL1c:=canton[idcanton].el1; t1c:=canton[idcanton].typ1;
  eL2c:=canton[idcanton].el2; t2c:=canton[idcanton].typ2;

  // tester le d�tecteur � 1 du canton pour chercher son suivant et pr�c�dent
  if t1c=det then
  begin
    if detecteur[eL1c].Etat then
    begin
      deta1:=eL1c;
      Elp:=detecteur[eL1c].precedent;
      Tp:=detecteur[eL1c].TypPrecedent;
      Els:=detecteur[eL1c].Suivant;
      Ts:=detecteur[eL1c].TypSuivant;
    end;
  end;
  if t2c=det then
  begin
    if detecteur[eL2c].Etat then
    begin
      deta1:=eL2c;
      Elp:=detecteur[eL2c].precedent;
      Tp:=detecteur[eL2c].TypPrecedent;
      Els:=detecteur[eL2c].Suivant;
      Ts:=detecteur[eL2c].TypSuivant;
    end;
  end;

  if deta1<>0 then
  begin
    if ((els=el2) and (ts=tel2)) or ((els=el1) and (ts=tel1)) then
    begin
      if AdrTrain<>0 then
      begin
        if nivDebug=3 then AfficheDebug('train '+intToSTR(adrTrain)+' trouv� sur canton '+intToSTR(canton[idcanton].numero)+' Sens '+intToSTR(el1)+' '+intToSTR(el2),clWhite);
        AdresseTrain:=AdrTrain;
        result:=1
      end;
    end;
  end;
end;

// pr�sence train pr�c�dent les n (NbCtSig) cantons du signal Adresse, dans le sens d'avance vers le signal.
// detect=true si on doit contr�ler aussi sur les d�tecteurs
// renvoie vrai si pr�sence train
// dans AdrTr: renvoie 0 si pas de train
// en mode roulage,  renvoie l'adresse du train
// dans voie : num�ro de la voie du signal sur laquelle on a trouv� le train
function PresTrainPrec(Adresse,NbCtSig : integer;detect : boolean;var AdrTr,voie : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,i,j,k,ifd,d,ia,AdresseTrain,
  dernierdet,AdrSignal,Nsignaux,voieLoc,voie1,voie2,indexSig1,indexSig2,
  ElSuiv,els,elp,c1,c2,numcanton : integer;
  Tsuiv,TypePrec,TypeActuel,ts,tp : TEquipement;
  Pres_train,malpositionne,etat,etatDet,EtatZone,tcanton : boolean;
  s : string;
begin
  proc:=TPresTrainPrec;
  param1:=adresse;
  param2:=NbCtSig;
  AdrTr:=0;
  if (debug=3) or ProcPrinc then formprinc.Caption:='PresTrainPrec '+IntToSTR(adresse);
  if NivDebug>=1 then
  begin
    s:='Proc PresTrainPrec('+intToSTR(adresse)+','+intToSTR(NbCtSig)+') ';
    if detect then s:=s+'avec zones de d�tecteurs et d�tecteurs'
    else s:=s+'sur zones de d�tecteurs uniquement';
    AfficheDebug(s,clyellow);
  end;

  i:=Index_Signal(adresse);
  if (i=0) then
  begin
    AfficheDebug('Erreur 605 - Signal '+IntToSTR(adresse)+' non trouv�',clred);
    Affiche('Erreur 605 - Signal '+IntToSTR(adresse)+' non trouv�',clred);
    PresTrainPrec:=False;
    AdrTr:=0;
    if debug=3 then formprinc.Caption:='';
    exit;
  end;

  ife:=1;  // index voie de 1 � 4 pour explorer les 4 d�tecteurs d'un signal
  repeat
    if NivDebug=3 then AfficheDebug('Boucle de test signal '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      actuel:=Signaux[i].Adr_det1;
      prec:=Signaux[i].Adr_el_suiv1;
      Typeprec:=Signaux[i].Btype_suiv1;
    end;  //d�tecteur sur le signal courant
    if (ife=2) then
    begin
      actuel:=Signaux[i].Adr_det2;
      prec:=Signaux[i].Adr_el_suiv2;
      Typeprec:=Signaux[i].Btype_suiv2;
    end;  // d�tecteur sur le signal courant
    if (ife=3) then
    begin
      actuel:=Signaux[i].Adr_det3;
      prec:=Signaux[i].Adr_el_suiv3;
      Typeprec:=Signaux[i].Btype_suiv3;
    end;  // d�tecteur sur le signal courant
    if (ife=4) then
    begin
      actuel:=Signaux[i].Adr_det4;
      prec:=Signaux[i].Adr_el_suiv4;
      Typeprec:=Signaux[i].Btype_suiv4;
    end;  // d�tecteur sur le signal courant

    if actuel>NbMaxDet then
    begin
      Affiche('Erreur 179 : d�tecteur '+intToSTR(actuel)+' trop �lev� sur signal '+intToSTR(adresse),clred);
      result:=false;
      exit;
    end;

    //pres_Train:=Detecteur[actuel].etat and detect;

    if pres_train and (AdrTr=0) then
    begin
      if roulage then AdrTr:=Detecteur[actuel].AdrTrain;
    end;
    if pres_train and (nivDebug=3) then AfficheDebug('1.Pr�sence train '+intToSTR(AdrTr)+' sur d�t '+intToSTR(actuel),clyellow);

    TypeActuel:=det;
    if actuel=0 then
    begin
      // sortie si aucun d�tecteur d�clar� sur le signal
      PresTrainPrec:=Pres_train;
      voie:=ife;
      if nivDebug=3 then AfficheDebug('Pas de d�tecteur sur voie '+intToSTR(ife)+' au signal '+IntToSTR(adresse),clyellow);
      if debug=3 then formprinc.Caption:='';
      exit;
    end;

    // d�tecte train dans canton si d�tecteur � 1 avant signal
    AdrSuiv:=suivant_alg3(prec,typePrec,actuel,det,1); // typeGen
    Numcanton:=trouve_canton(actuel,det,adrSuiv,TypeGen); //index canton encadr� par les 2 �l�ments

    if test_canton(NumCanton,prec,typeprec,actuel,det,AdresseTrain)=1 then
    begin
      AdrTr:=AdresseTrain;
      result:=true;
      voie:=ife;
      if nivDebug=3 then AfficheDebug('trouv� train sur canton',clYellow);
      exit;
    end;

    // lire la m�moire de zone des d�tecteurs pr�c�dant le signal
    k:=1;
    repeat
      d:=Signaux[i].DetAmont[k];
      if (d>0) and (d<NbMaxDet) then
      begin
        pres_Train:=MemZone[d,actuel].etat or Pres_Train;
        if MemZone[d,actuel].etat and (adrTr=0) then
        begin
          if roulage then AdrTr:=MemZone[d,actuel].AdrTrain;
        end;
        if (NivDebug=3) and MemZone[d,actuel].etat then AfficheDebug('Trouv� train '+intToSTR(AdrTr)+' sur m�moire de zone '+intToSTR(d)+','+intToSTR(actuel),clyellow);
      end;
      inc(k);
    until (d=0) or (k=Mtd);

    dernierdet:=actuel;
    j:=0;
    Nsignaux:=0;
    repeat
      inc(j);
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,2);  // 2 car arr�t sur aiguille en talon mal positionn�e

      // et v�rifier si canton et pr�sence train dans le bon sens
      Numcanton:=trouve_canton(actuel,TypeActuel,AdrSuiv,TypeGen);    // trouve le canton encadr� par actuel et adrsuiv
      if test_canton(NumCanton,prec,typePrec,actuel,typeActuel,AdresseTrain)=1 then
      begin
        AdrTr:=AdresseTrain;
        voie:=0;
        result:=true;
        exit;
      end;

      if (adrTr<>0)  then
      begin
        if nivDebug=3 then AfficheDebug('Trouv� train sur canton ',clYellow);
        presTrainPrec:=true;
        voie:=ife;
        exit;
      end;

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
          end;
        end;

        if (AdrSuiv=0) and (nivdebug=3) then AfficheDebug('Buttoir',clyellow);
        if EtatDet then
        begin
          if nivDebug=3 then
          begin
            s:='2.Pr�sence train ';
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
        // modif sp�cial TJD ==============
        ia:=index_aig(Actuel);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
        Prec:=aiguillage[ia].Ddevie else
        // ================================

        prec:=actuel;TypePrec:=TypeActuel;
        actuel:=AdrSuiv;TypeActuel:=typeGen;

        if typeactuel=det then
        begin
          etatDet:=Detecteur[actuel].etat and detect;
          ElSuiv:=Detecteur[actuel].suivant;
          Tsuiv:=detecteur[actuel].TypSuivant;
          etatZone:=MemZone[actuel,dernierdet].etat;
          Pres_train:=Pres_Train or EtatZone or EtatDet;

          if Pres_Train and (AdrTr=0) then
          begin
            if roulage then
            begin
              AdrTr:=MemZone[actuel,dernierdet].AdrTrain; // adresse
              if AdrTr=0 then AdrTr:=detecteur[actuel].AdrTrain;
            end;
            if (nivDebug=3) then
            begin
              s:='3.Pr�sence train ';
              if AdrTr<>0 then s:=s+'@'+IntToSTR(AdrTr)+' ';
              if etatZone then s:=s+'de '+intToSTR(actuel)+' � '+intToSTR(dernierdet);
              if etatDet  then s:=s+'sur det '+intToSTR(actuel);
              if El<>0 then s:=s+' Elsuiv='+intToSTR(ElSuiv);
              AfficheDebug(s,clYellow);
              if debug=3 then formprinc.Caption:='';
            end;
            presTrainPrec:=Pres_train;
            voie:=ife;
            exit;
          end
            else begin if nivDebug=3 then AfficheDebug('Absence train de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow);end;

          dernierdet:=actuel;

//          ifd:=index_signal_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au d�tecteur "AdrSuiv": il peut y avoir 4 d�tecteurs par signal
          index_signal_det(actuel,voie1,indexSig1,voie2,indexSig2);
          if indexSig1<>0 then
          begin
            AdrSignal:=Signaux[indexSig1].adresse;    // adresse du signal
            if (AdrSignal=adresse) then  // si on ne reboucle sur le m�me signal dont on cherche le suivant
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
              if (Signaux[indexSig1].Adr_el_suiv1=prec) then   // le signal est-il dans le bon sens de progression?
              begin
                inc(Nsignaux);
                j:=0;
                s:='Trouv� signal '+intToStr(AdrSignal)+' ('+IntToSTR(Nsignaux)+'/'+intToSTR(NbCtSig)+') ';
                if (NivDebug=3) And Pres_Train then AfficheDebug(s+' et m�moire de zone � 1',clOrange);
                if (NivDebug=3) And (not(Pres_Train)) then AfficheDebug(s+' et m�moire de zone � 0',clOrange);
                if nSignaux=NbCtSig then // si atteint les 3 signaux (3 cantons)
                begin
                  presTrainPrec:=pres_train;
                  if debug=3 then formprinc.Caption:='';
                  voie:=ife;  // changer la voie
                  exit;
                end;
                // explorer les pr�sence trains sur les voies en convergence du signal
                // lire la m�moire de zone des d�tecteurs n-2 pr�c�dent le signal
                k:=1;
                repeat
                  d:=Signaux[indexSig1].DetAmont[k];
                  if (d<>0) and (d<NbMaxDet) and (actuel<NbMaxDet) then
                  begin
                    pres_Train:=MemZone[d,actuel].etat or Pres_Train;
                    if Pres_Train and (adrtr=0) then
                    begin
                      if roulage then AdrTr:=MemZone[d,actuel].AdrTrain; // adresse
                      if (NivDebug=3) then AfficheDebug('Trouv� train '+intToSTR(AdrTr)+' sur m�moire de zone '+intToSTR(d)+','+intToSTR(actuel),clyellow);
                    end;
                  end;
                  inc(k);
                until (d=0) or (k=Mtd);
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Trouv� signal '+intToSTR(AdrSignal)+' mais dans le mauvais sens',clYellow);
                AdrSignal:=0;
              end;
            end;
          end;
        end;
      end;
    until (j=10) or Pres_train or malpositionne or (Nsignaux>=NbCtSig);  // on arrete jusqu'� trouver un train ou un signal ou si on va trop loin (10 it�rations)
    inc(ife);
  until (ife>=5) or Pres_train;
  //if (NivDebug>0) then AfficheDebug('606. Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);
  if debug=3 then formprinc.Caption:='';
  voie:=ife-1;
  PresTrainPrec:=Pres_Train;
end;

// renvoie vrai si le signal est au carr�, s�maphore, s�maphore cli, violet
function signal_rouge(adresse : word) : boolean;
var etat,i : integer;
begin
  i:=index_signal(adresse);
  etat:=Signaux[i].EtatSignal;
  if Signaux[i].aspect=20 then result:=testbit(etat,rouge)
  else result:=testbit(etat,semaphore) or testbit(etat,carre) or testbit(etat,violet);
end;

// appel�e en fin de mise � jour signal
procedure fin_maj_signal(AdrSignal : integer);
var index,etat,adr_Det : integer;

begin
  if (roulage) then
  begin
    index:=index_signal(AdrSignal);
    etat:=Signaux[index].EtatSignal;
    if not(signal_rouge(AdrSignal)) then
    begin
      adr_Det:=Signaux[index].Adr_det1;
      if detecteur[adr_det].Etat then    // d�tecteur doit �tre activ� par loco
      begin
        // trouver si le signal est dans le bon sens
        //id:=detecteur[adr_det].IndexTrain;
        //det1:=event_det_train[id].Det[2].adresse;
        //det2:=event_det_train[id].suivant;
        //det3:=suivant_alg3(det1,

        {
        AdrTrainLoc:=detecteur[adr_det].AdrTrain;
        IndexTrain:=index_train_adresse(adrTrainLoc);
        roulageTrain:=trains[indexTrain].roulage;
        if adrTrainLoc<>0 then
        begin
          // trouver le d�tecteur suivant
          if Signaux[index].Btype_suiv1<>det then detSuiv:=detecteur_suivant(Signaux[index].Adr_det1,det,Signaux[index].Adr_el_suiv1,Signaux[index].Btype_suiv1,1)
                      else detSuiv:=Signaux[index].Adr_el_suiv1;
          if detSuiv<9990 then
          begin
            if roulageTrain>0 then reserve_canton(Signaux[index].Adr_det1,detSuiv,AdrtrainLoc,0,nCantonsRes) else
          end;
        end;  }
      end;
    end;
  end;
end;

// met � jour l'�tat du signel belge selon l'environnement des aiguillages et des trains
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
  Adr_det:=Signaux[index].Adr_det1;  // d�tecteur sur le signal
  Adr_El_Suiv:=Signaux[index].Adr_el_suiv1; // adresse �l�ment suivant au signal
  Btype_el_suivant:=Signaux[index].Btype_suiv1;
  PresTrain:=false;

  // d�tecteurs pr�c�dent le signal , pour d�terminer si leurs m�moires de zones sont � 1 pour lib�rer le carr�
  //if (Signaux[index].VerrouCarre) and (modele>=4) then

  presTrain:=PresTrainPrec(AdrSignal,Nb_cantons_Sig,false,AdrTrainLoc,voie); //etape A   // pr�sence train par adresse train ; renvoie l'adresse du train dans AdrTrainLoc
  if AffSignal and roulage then AfficheDebug('L''@ du train avant le signal est '+intToSTR(AdrTrainLoc),clYellow);

  // si le signal peut afficher un carr� et les aiguillages apr�s le signal sont mal positionn�es ou aig r�serv� ou que pas pr�sence train avant signal et signal
  // verrouillable au carr�, afficher un carr�

  car:=carre_signal(AdrSignal,AdrTrainLoc,reserveTrainTiers,AdrTrainRes)<>0;  // si reserveTrainTiers, r�serv� par un autre train
  if AffSignal and reserveTrainTiers then AfficheDebug('Trouv� aiguillage r�serv� par autre train (@'+intToSTR(AdrTrainRes)+')',clYellow);
  if AffSignal and car then AfficheDebug('Le signal a des aiguilles en talon aval mal positionn�es',clYellow);
  // En mode roulage, si la r�servation est faite par le train d�tect� en �tape A, ne pas verrouiller au carr�
  if roulage then car:=reserveTrainTiers or car;

  // conditions suppl�mentaires de carr� en fonction des aiguillages d�crits
  car:=cond_carre(AdrSignal) or car;
  if AffSignal and Signaux[index].VerrouCarre then AfficheDebug('le signal est verrouill� au carr�',clYellow);

  if (Signaux[index].VerrouCarre and not(presTrain)) or car
       then Maj_Etat_Signal_belge(AdrSignal,semaphore)
  else
  begin
    // si on quitte le d�tecteur on affiche un s�maphore :  tester le sens de circulation
    // pour ne pas passer au rouge un signal � contresens.
    // trouver la m�moire de zone MemZone[Adr_det,?] qui a d�clench� le feu rouge
    if AffSignal then AfficheDebug('Test du s�maphore',clYellow);
    Aff_semaphore:=test_memoire_zones(AdrSignal);  // test si pr�sence train apr�s signal
    if Aff_Semaphore then
    begin
      if AffSignal then AfficheDebug('Pr�sence train apr�s signal'+intToSTR(AdrSignal)+' -> s�maphore ou carr�',clYellow);
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
      etat:=etat_signal_suivant(AdrSignal,1,AdrSignalsuivant) ;  // �tat du signal suivant + adresse du signal suivant dans Signal_Suivant
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
            if AffSignal then AfficheDebug('Pas d''aiguille d�vi�e',clYellow);
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

  fin_maj_signal(AdrSignal);

  if signalDebug=AdrSignal then begin AffSignal:=false;nivDebug:=0;end;
  if debug=3 then formprinc.Caption:='';
end;


// mise � jour de l'�tat d'un signal en fonction de son environnement et affiche le signal
// AdrSignal: adresse du signal
// detect: si true, tient compte de la pr�sence des trains par d�tecteurs dans la fonction signalPrec
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

  // ici signal fran�ais

  Adr_det:=Signaux[index].Adr_det1;  // d�tecteur sur le signal
  Adr_El_Suiv:=Signaux[index].Adr_el_suiv1; // adresse �l�ment suivant au signal
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
  etat:=etat_signal_suivant(AdrSignal,1,AdrSignalsuivant) ;  // �tat du signal suivant + adresse du signal suivant dans Signal_Suivant
  if AffSignal then
  begin
    code_to_aspect(etat,code,combine);
    s:='Etat_signal_suivant ('+intToSTR(AdrSignalsuivant)+') est ';
    s:=s+' � ';
    if code<>-1 then s:=s+etatSign[code];
    if (Combine<>0) and (combine<>-1) then s:=s+' + '+etatSign[combine];
    AfficheDebug(s,clyellow);
  end;
    // signal � 2 feux = carr� violet+blanc
  if (modele=2) then //or (Signaux[i].check<>nil) then // si carr� violet
  begin
    // si aiguillage apr�s signal mal positionn�es ou r�serv� ou pas de train avant le signal
    PresTrain:=PresTrainPrec(AdrSignal,Nb_cantons_Sig,detect,AdrTrainLoc,voie);     // renvoie AdrTrainLoc et voie
    if (carre_signal(AdrSignal,AdrTrainLoc,reserveTrainTiers,AdrTrainRes)<>0) or not(PresTrain) or (Signaux[index].VerrouCarre) then
    begin
      Maj_Etat_Signal(AdrSignal,violet);
      if debug=3 then formprinc.Caption:='';
    end
    else
    begin
      if not(cond_FeuBlanc(AdrSignal)) and test_memoire_zones(AdrSignal) then Maj_Etat_Signal(AdrSignal,violet)  // test si pr�sence train apr�s signal
        else Maj_Etat_Signal(AdrSignal,blanc);
          // faire la r�servation des aiguillages
      if debug=3 then formprinc.Caption:='';
    end;
  end;
  //if AffSignal then AfficheDebug('Debut du traitement g�n�ral',clYellow);
  // traitement des feux >=3 feux diff�rents de violet (cas g�n�ral)
  if (modele>=3) and (Signaux[index].EtatSignal<>violet_F) then
  begin
    PresTrain:=false;
    // d�tecteurs pr�c�dent le signal , pour d�terminer si leurs m�moires de zones sont � 1 pour lib�rer le carr�
    //if (Signaux[index].VerrouCarre) and (modele>=4) then
    presTrain:=PresTrainPrec(AdrSignal,Nb_cantons_Sig,detect,AdrTrainLoc,voie); //etape A   // pr�sence train par adresse train ; renvoie l'adresse du train dans AdrTrainLoc

    if AffSignal and roulage then AfficheDebug('L''@ du train avant le signal est '+intToSTR(AdrTrainLoc),clYellow);
      // si le signal peut afficher un carr� et les aiguillages apr�s le signal sont mal positionn�es ou aig r�serv� ou que pas pr�sence train avant signal et signal
    // verrouillable au carr�, afficher un carr�
    car:=carre_signal(AdrSignal,AdrTrainLoc,reserveTrainTiers,AdrTrainRes)<>0;  // si reserveTrainTiers, r�serv� par un autre train
    if AffSignal and reserveTrainTiers then AfficheDebug('trouv� aiguillage r�serv� par autre train',clYellow);
    if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
    // En mode roulage, si la r�servation est faite par le train d�tect� en �tape A, ne pas verrouiller au carr�
    if roulage then car:=(reserveTrainTiers and Signaux[index].VerrouCarre) or car;  // tenir compte de la r�servation si on est en mode avec r�servation des aiguillages
      // conditions suppl�mentaires de carr� en fonction des aiguillages d�crits
    car:=cond_carre(AdrSignal) or car;
    //if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
    if AffSignal and Signaux[index].VerrouCarre then AfficheDebug('le signal est verrouill� au carr�',clYellow);

    if (modele>=4) and  ((not(PresTrain) and Signaux[index].Verroucarre) or car ) then Maj_Etat_Signal(AdrSignal,carre)
    else
    begin
      // si on quitte le d�tecteur on affiche un s�maphore :  tester le sens de circulation
      // pour ne pas passer au rouge un signal � contresens.
      // trouver la m�moire de zone MemZone[Adr_det,?] qui a d�clench� le feu rouge
      if AffSignal then AfficheDebug('test du s�maphore',clYellow);
      Aff_semaphore:=test_memoire_zones(AdrSignal);  // test si pr�sence train apr�s signal
      if Aff_Semaphore then
      begin
        if AffSignal then AfficheDebug('Pr�sence train apr�s signal'+intToSTR(AdrSignal)+' -> s�maphore ou carr�',clYellow);
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
          // si aiguille locale d�vi�e
          if (aig<>0) and (Signaux[index].aspect>=9) then // si le signal peut afficher un rappel et aiguille d�vi�e
          begin
            indexAig:=Index_aig(aig);
            if AffSignal then AfficheDebug('Aiguillage '+intToSTR(aig)+' du signal '+intToSTR(AdrSignal)+' d�vi�e',clYellow);
            Signaux[index].EtatSignal:=0;
            if (aiguillage[indexAig].vitesse<=30) then Maj_Etat_Signal(AdrSignal,rappel_30) else
              if ((aiguillage[indexAig].vitesse>30) and (aiguillage[indexAig].vitesse<=60)) then Maj_Etat_Signal(AdrSignal,rappel_60)
                else
                begin
                  Maj_Etat_Signal(AdrSignal,rappel_30);
                  s:='Aiguillage '+intToSTR(aig)+'d�vi� mais vitesse de franchissement mal d�finie pour le signal '+intToSTR(AdrSignal)+' ';
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
          // aiguille locale non d�vi�e ou aspect signal<9
          begin
            if AffSignal then AfficheDebug('pas d''aiguille d�vi�e',clYellow);
            // effacer la signalisation combin�e
            Signaux[index].EtatSignal:=Signaux[index].EtatSignal and not($3c00);

            // si signal suivant rouge
            if signal_rouge(AdrSignalSuivant) then
            begin
              Maj_Etat_Signal(AdrSignal,jaune);
              //if AffSignal then AfficheDebug('Mise du signal � l''avertissement',clyellow);
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
                  if (modele>=5) then Maj_Etat_Signal(AdrSignal,ral_30) else Maj_etat_signal(AdrSignal,jaune_cli);
                  //if affsignal then AfficheDebug('Mise du feu au ralen 30',clyellow);
                end;
                if TestBit(etat,rappel_60) then
                begin
                  //if AffSignal then AfficheDebug('Mise du Feu au ralen 60',clyellow);
                  if (modele>=5) then Maj_Etat_Signal(AdrSignal,ral_60)
                    else Maj_etat_signal(AdrSignal,jaune_cli);
                      // si signal suivant est au rappel60, il faut tester s'il est � l'avertissement aussi
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
                // si le signal suivant est jaune ou ral_30 (et pas ral_60)
                //if affsignal then AfficheDebug('test 404',clyellow);
                if TestBit(etat,jaune) or TestBit(etat,ral_30) then
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

  // si le signal n'est pas rouge avec un train sur le d�tecteur du signal, r�server les aiguillages en aval

  fin_maj_signal(AdrSignal);

  if signaldebug=AdrSignal then AfficheDebug(chaine_signal(adrSIgnal),clWhite);


  if signalDebug=AdrSignal then begin
  AffSignal:=false;nivDebug:=0;end;
  if debug=3 then formprinc.Caption:='';
end;

// mise � jour du signal et de son pr�c�dent
procedure maj_Signal_P(adrSignal : integer;detect : boolean);
var adrPrec,etat : integer;
begin
  Maj_signal(Adrsignal,detect);
  // si le signal est rouge ou rappel, mettre � jour son pr�c�dent
  etat:=Signaux[index_signal(AdrSignal)].EtatSignal;
  if (signal_rouge(AdrSignal)) or testbit(etat,rappel_60) or testbit(etat,rappel_30) then
  begin
    adrPrec:=Signal_precedent(AdrSignal);
    if adrPrec<>0 then
    begin
      //Affiche('signal='+intToSTR(AdrSignal)+' pr�c�dent='+intToSTR(adrPrec),clyellow);
      Maj_signal(adrPrec,detect);
    end;
  end;
end;

// mise � jour des signaux
// detect: si true, tient compte de la pr�sence des trains sur les d�tecteurs dans la fonction signalPrec
Procedure Maj_Signaux(detect : boolean);
var i : integer;
begin
  if (nivDebug=1) or ProcPrinc then AfficheDebug('Proc Maj_signaux',clorange);
  if not(Maj_signaux_cours) and not(Stop_Maj_sig) then
  begin
    Maj_signaux_cours:=TRUE;
    i:=1;
    repeat
      Maj_Signal_P(Signaux[i].Adresse,detect);
      inc(i);
    until (i>NbreSignaux) or Stop_Maj_Sig;
    Maj_signaux_cours:=FALSE;
  end;
  Stop_Maj_Sig:=false;
end;


// trouve si le d�tecteur adr est contigu � un buttoir
function buttoir_adjacent(adr : integer) : boolean;
begin
  trouve_element(adr,det); // branche_trouve  IndexBranche_trouve
  if Branche_trouve=0 then begin buttoir_adjacent:=false;exit;end;
  buttoir_adjacent:=( (BrancheN[branche_trouve,IndexBranche_trouve+1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve+1].BType=buttoir) or
                      (BrancheN[branche_trouve,IndexBranche_trouve-1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve-1].BType=buttoir) )
end;

// renvoie vrai si le signal adresse est dans le sens det1 det2
function signal_sens(adrSig,det1,det2 : integer) : boolean;
var i,it,suiv,succ,actuel,ia : integer;
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
    // parcourir les �l�ments jusque detecteur2
    // oui, est-il dans le bon sens?
    succ:=suivant_alg3(actuel,typeAct,suiv,typSuiv,1);
    if (succ>9990) then
    begin
      Affiche('Erreur 154',clred);
    end;

    // modif sp�cial TJD ==============
    ia:=index_aig(suiv);
    if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
    actuel:=aiguillage[ia].Ddevie else
    // ================================

    actuel:=suiv;typeact:=typSuiv;
    suiv:=succ;typSuiv:=typeGen;

    inc(it);
  until (succ=det2) or (succ=0) or (it>Max_Signal_Sens);
  if debug=3 then formprinc.Caption:='';
  signal_sens:=succ=det2;
end;

// r�serve le nombre de cantons "nCantons" du detecteur1 (non compris) au detecteur2 (compris) �quip� du signal ou le prochain suivant si le signal n'est pas au rouge
// la r�servation consiste � marquer un aiguillage ou un d�tecteur avec l'adresse du train "adrTrain" ou "NumTrain"
// La proc�dure v�rifie si les aiguillages ou les d�tecteurs sont r�serv�s par un autre train, dans ce cas en sortie, on a le train qui a r�serv� les aiguillages.
// la r�servation est faite en direction des aiguillages d�ja positionn�s.
// det1 et det2 doivent se suivre.
// adrTrain = adresse du train (mode roulage uniquement)
// NumTrain = index du train (pas mode roulage, avec CDM)
// met � jour le tableau en var globale  "elements[]"  Nombre : IdEl-1
// en sortie : result=train qui a r�serv� les aiguillages
// ou -1 si pas de signal
function reserve_canton(detecteur1,detecteur2,adrtrain,NumTrain,NCantons : integer) : integer;
var nc,AdrSig,i,j,etat,etatSuiv,AdrSignalsuivant,TrainExistant : integer;
    rouge,cas2 : boolean;
    typ : tEquipement;
    s : string;
begin
  proc:=treserve_canton;
  param1:=detecteur1;
  param2:=detecteur2;
  param3:=adrTrain;
  result:=0;
  if not(roulage) then exit;
  if (detecteur1=0) then
  begin
    s:='Erreur 62 : reserve_canton';
    if detecteur1=0 then s:=s+' det1 nul';
    Affiche(s,clred);
    exit;
  end;
  if detecteur2=0 then exit;

  s:='R�servation '+intToSTR(nCantons)+' cantons apr�s d�tecteur '+intToSTR(detecteur1)+' '+intToSTR(detecteur2)+' pour train ';
  if roulage then s:=s+'@'+intToSTR(adrtrain) ;
  if traceliste or ProcPrinc then afficheDebug(s,clorange);
  if affres then Affiche(s,ClOrange);

  if (detecteur1>NbMaxDet) or (detecteur2>NbMaxDet) then
  begin
    Affiche('Erreur 63 : reserve_canton '+intToSTR(detecteur1)+' '+intToSTr(detecteur2),clred);
    exit;
  end;

  idEl:=0;
  // y a t-il un signal sur le d�tecteur1
  cas2:=false;


  AdrSig:=signal_detecteur(detecteur1);  // trouve le signal associ� au detecteur1
  if adrSig<>0 then
  begin
    // si le signal est dans le bon sens
    if signal_sens(AdrSig,detecteur1,detecteur2) then
    begin
      cas2:=true;  // oui
      if TraceListe then AfficheDebug('Trouv� signal '+intToSTR(adrSig)+' dans bon sens',clYellow);
    end
    else if TraceListe then AfficheDebug('Trouv� signal '+intToSTR(adrSig)+' dans mauvais sens',clYellow);
  end;

  if not(cas2) then AdrSig:=signal_suivant_det(detecteur1,detecteur2);   // signal suivant dans le bon sens

  if traceListe then afficheDebug('Le signal est '+intToSTR(AdrSig)+' ',clyellow);

  // pas de signal !!
  if adrSig=0 then
  begin
    //Affiche('Absence de signal apr�s '+intToSTR(detecteur2)+', r�servation pour train @'+intToStr(AdrTrain)+' '+intToSTR(detecteur1)+' '+intToSTR(detecteur2)+' impossible',clred);
 //   i:=indexbrut_train_adresse(AdrTrain); // num�ro de train
//    if i<>0 then reserve_dereserve_det(detecteur1,detecteur2,adrTrain,i,1);
    result:=-1;
    exit;
  end;

  etat:=Signaux[Index_Signal(AdrSig)].etatSignal;
  rouge:=signal_rouge(AdrSig);
  if rouge then
  begin
    if TraceListe then AfficheDebug('Le signal '+intToSTR(AdrSig)+' �tant rouge, pas de r�servation aval ',clYellow);
    exit;
  end;

  etatSuiv:=etat_signal_suivant(AdrSig,1,AdrSignalsuivant);    // remplit elements[]

  //r�serve le canton du signal AdrSig au suivant : AdresseSignalSuivant
  // dans le bon sens
  // 1er canton
  // marquer les aiguillages r�serv�s
  if roulage then result:=AdrTrain;


  // balayer les �l�ments pour v�rifier si un d'entre eux est r�serv� par un autre train
  // si c'est le cas on sort.
  // on ne r�serve pas le premier d�tecteur ; exemple : reserve_canton(525,528) ne r�serve pas 525
  for i:=1 to idEl-1 do
  begin
    j:=elements[i].adresse;
    typ:=elements[i].typ;
    if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
    begin
      if TraceListe then AfficheDebug_Suivi(intToSTR(j)+' ',clOrange);
      // v�rifier si l'aiguillage est libre
      TrainExistant:=Aiguillage[index_aig(j)].AdrTrain;
      if (trainexistant<>AdrTrain) and (TrainExistant<>0) then
      begin
        result:=Aiguillage[index_aig(j)].AdrTrain;
        if traceListe then AfficheDebug('Aiguillage '+intToSTR(j)+' r�serv� par autre train : @='+intToSTR(result),clyellow);
        exit;
      end;
    end;
    if (typ=det) then
    begin
      TrainExistant:=detecteur[j].AdrTrainRes;
      if (TrainExistant<>AdrTrain) and (trainExistant<>0) then
      begin
        result:=Detecteur[j].AdrTrainRes;
        if traceListe then AfficheDebug('D�tecteur '+intToSTR(j)+' r�serv� par autre train : @='+intToSTR(result),clyellow);
        exit;
      end;
    end;
  end;

  if traceliste then AfficheDebug('A. Elements r�serv�s: ',clOrange);

  // 1er �l�ment de detecteur[] : le d�r�server si c'est le train demand�
  j:=elements[1].adresse;
  TrainExistant:=detecteur[j].AdrTrainRes;
  if (TrainExistant<>AdrTrain) and (trainExistant<>0) then
  begin
    result:=Detecteur[1].AdrTrainRes;
    if traceListe then AfficheDebug('D�tecteur '+intToSTR(j)+' r�serv� par autre train : @='+intToSTR(result),clyellow);
    exit;
  end;
  detecteur[j].AdrTrainRes:=0;

  for i:=2 to idEl-1 do
  begin
    j:=elements[i].adresse;
    typ:=elements[i].typ;
    if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
    begin
      if TraceListe then AfficheDebug_Suivi(intToSTR(j)+' ',clOrange);
      // v�rifier si l'aiguillage est libre
      if roulage then
      begin
        Aiguillage[index_aig(j)].AdrTrain:=AdrTrain;
        result:=AdrTrain;
      end;
    end;
    if (typ=det) then
    begin
      if roulage then
      begin
        Detecteur[j].AdrTrainRes:=AdrTrain;
        result:=AdrTrain;
      end;
    end;
    // maj tco
    Texte_aig_fond(j) ;
  end;

  // --------canton suivant
  rouge:=signal_rouge(AdrSignalSuivant);
  if rouge then
  begin
    if TraceListe then
    begin
      s:='Le signal sursuivant '+intToSTR(AdrSignalSuivant)+' �tant rouge, pas de r�servation aval pour le train @';
      if roulage then s:=s+'@'+intToSTR(adrtrain);
      AfficheDebug(s,clyellow);
    end;
    exit;
  end;

  nc:=2;
  // r�servation canton suivant sauf si signal est rouge
  repeat
    if Traceliste then AfficheDebug('Canton '+intToSTR(nc),clOrange);

    AdrSig:=AdrSignalSuivant;
    etatsuiv:=etat_signal_suivant(AdrSig,1,AdrSignalsuivant);  //r�serve le canton du signal AdrSig au suivant : AdresseSignalSuivant
    if traceListe then afficheDebug('Le signal sursuivant est '+intToSTR(AdrSig),clyellow);
    rouge:=signal_rouge(AdrSignalSuivant);
    if rouge then
    begin
      if TraceListe then
      begin
        s:='Le signal sursuivant '+intToSTR(AdrSignalSuivant)+' �tant rouge, pas de r�servation aval pour le train @';
        if roulage then s:=s+'@'+intToSTR(adrtrain);
        AfficheDebug(s,clyellow);
      end;
    end;

    etat:=etat_signal_suivant(AdrSig,1,AdrSignalsuivant);  //r�serve le canton du signal
    // marquer les aiguillages r�serv�s
    if traceliste then AfficheDebug('B. Elements r�serv�s: ',clOrange);
    for i:=1 to idEl-1 do
    begin
      j:=elements[i].adresse;
      typ:=elements[i].typ;
      if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
      begin
        if TraceListe then AfficheDebug_Suivi(intToSTR(j)+' ',clOrange);
        if roulage then
        begin
          if (Aiguillage[index_aig(j)].AdrTrain)=0 then Aiguillage[index_aig(j)].AdrTrain:=AdrTrain;
          result:=Aiguillage[index_aig(j)].AdrTrain;
        end;
      end;
      if (typ=det) then
      begin
        if roulage then
        begin
          if (detecteur[j].AdrTrainRes=0) then Detecteur[j].AdrTrainRes:=AdrTrain;
          result:=Detecteur[j].AdrTrainRes;
        end;
      end;
      Texte_aig_fond(j);
    end;

    inc(nc);
  until (nc>Ncantons);

  Maj_Signaux(false);  // sans_maj
end;


// lib�re le canton avant detecteur2, qui doit �tre associ� � un signal depuis la direction de detecteur1
// detecteur1->detecteur2
Procedure libere_canton(detecteur1,detecteur2,AdrTrain : integer);
var i,j,index,adrSig1,adrSig2,detsig1,detSig2,it,n,id1,id2 : integer;
    typ : tEquipement;
    trouve1,trouve2 : boolean;
begin
  if not(roulage) then exit;
  it:=index_train_adresse(AdrTrain);
  if it=0 then exit;
  proc:=Tlibere_canton;
  param1:=detecteur1;
  param2:=detecteur2;
  if traceliste or ProcPrinc or affres or debugroulage then
  affiche('Lib�re_canton '+intToSTR(detecteur1)+' '+intToSTR(detecteur2),clLime);
  if ProcPrinc or traceListe then AfficheDebug('Lib�re_Canton '+intToSTR(detecteur1)+' '+intToSTR(detecteur2),clLime);

  // est-on en limite de canton du detecteur 2 pour le lib�rer?
  adrSig2:=signal_detecteur(detecteur2);  // trouve le signal associ� au detecteur2
  if adrSig2=0 then
  begin
    if traceliste then affiche('le d�tecteur '+intToSTR(detecteur2)+' n''est pas pas associ� � un signal - pas de lib�ration du canton',clorange);
    exit;  // pas de signal associ�
  end;
  // ce signal sd2 est il dans le bon sens
  i:=signal_suivant_det(detecteur1,detecteur2);  // adresse du signal dans le bon sens associ� au d�tecteur
  if i<>adrSig2 then
  begin
    if traceliste then affiche('Le signal '+intToSTR(adrsig2)+' n''est pas dans le bon sens',clOrange);
    exit;
  end;
  if i=0 then exit;

  index:=index_signal(adrSig2);
  detSig2:=signaux[index].Adr_det1;
  // trouver le signal pr�c�dent
  AdrSig1:=Signal_precedent(AdrSig2);    // trouve les �l�ments entre les deux signaux
  if AdrSig1<>0 then
  begin
    index:=index_signal(adrSig1);
    detSig1:=signaux[index].Adr_det1;
  end
  else DetSig1:=trains[it].route[1].adresse;

  // trouve les index des d�tecteurs des deux signaux dans la route
  i:=1;id1:=1;id2:=1;
  n:=trains[it].route[0].adresse;
  trouve1:=false;trouve2:=false;
  repeat
    if (trains[it].route[i].adresse=detSig1) and (trains[it].route[i].typ=det) then
    begin
      trouve1:=true;
      id1:=i;
    end;
    if trouve1 and (trains[it].route[i].adresse=detSig2) and (trains[it].route[i].typ=det) then
    begin
      trouve2:=true;
      id2:=i;
    end;
    inc(i);
  until (trouve1 and trouve2) or (i>n);

  for i:=id1 to id2 do
  begin
   typ:=trains[it].route[i].typ;
   j:=trains[it].route[i].adresse;
    if (typ=Aig) or (typ=tjd) or (typ=tjs) or (typ=crois) or (typ=triple) then
    begin
      index:=index_aig(j);
      if traceListe then Affichedebug_Suivi('A'+intToSTR(j)+' ',clLime);
      if debugRoulage then Affiche('Lib�ration aiguillage A'+intToSTR(j),clWhite);
      Aiguillage[index].AdrTrain:=0;  // lib�re l'aiguillage
      Texte_aig_fond(j);
      typ:=aiguillage[index].modele;
      if (typ=Tjd) and (aiguillage[index].EtatTJD=4) then
      begin
        j:=aiguillage[index].Ddroit;// homologue
        if debugRoulage then Affiche('Lib�ration aiguillage A'+intToSTR(j),clWhite);
        Aiguillage[index_aig(j)].AdrTrain:=0;    // lib�re l'homologue
      end;
    end;
    if (typ=det) then
    begin
      if traceListe then Affichedebug_Suivi(intToSTR(j)+' ',clLime);
      detecteur[j].AdrTrainRes:=0;  // lib�re le d�tecteur
      Texte_aig_fond(j);
    end;
  end;

  Maj_Signaux(false);
end;

// mode=0 = lib�re    1=r�serve  reserve_dereserve_det(detecteur1,detecteur2,adrTrain,i,1);
// du d�tecteur1 au d�tecteur2 NON INCLUS
// r�sultat : 0 si ok sinon code de d�faut
// ou adresse train
function reserve_dereserve_det(det1,det2,adrTrain,indexTrain,mode : integer) : integer;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,k,AdrPrec,Adr,AdrFonc,i1,N_det,ia : integer;
    Sortie : boolean;
    TypePrec,TypeFonc : Tequipement;
    s : string;
    label reprise;
begin
  s:='Reserve_dereserve_det '+intToSTR(det1)+' '+intToSTR(det2)+' pour train ';
  proc:=Treserve_dereserve_det;
  param1:=det1;
  param1:=det2;
  param3:=adrtrain;
  if roulage then s:=s+'@'+intToSTR(adrtrain);
  if traceliste or ProcPrinc then afficheDebug(s,clorange);
  if affRes then Affiche(s,ClOrange);

  if NivDebug>=2 then
  if (det1>9000) or (det2>9000) then
  begin
    if NivDebug=3 then AfficheDebug('Param�tres incorrects >9000',clred);
    reserve_dereserve_det:=9999;
    exit;
  end;

  if (det2=0) then
  begin
    reserve_dereserve_det:=9995;
    exit;
  end;

  // trouver d�tecteur 1
  trouve_element(det1,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(det1)+' non trouv�';
      AfficheDebug(s,clOrange);
    end;
    reserve_dereserve_det:=9999;
    exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver d�tecteur 2
  trouve_element(det2,det); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='612. '+IntToSTR(det2)+' non trouv�';
      AfficheDebug(s,clred);
      AfficheDebug(s,clOrange);
    end;
    reserve_dereserve_det:=9999;exit;
  end;

  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;
  j:=1;  // J=1 test en incr�ment J=2 test en d�cr�ment

  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)

  repeat
    //pr�parer les variables
    AdrPrec:=det1;TypePrec:=det;
    if j=1 then i1:=IndexBranche_det1+1;
    if j=2 then i1:=IndexBranche_det1-1;
    // les suivants dansla branche sont:
    AdrFonc:=BrancheN[branche_trouve_det1,i1].adresse;
    typeFonc:=BrancheN[branche_trouve_det1,i1].Btype;

    if NivDebug=3 then
    begin
      s:='------> Test en ';
      if (j=1) then s:=s+'incr�ment ' else s:=s+'d�cr�ment ';
      s:=s+'- d�part depuis �l�ment '+IntToSTR(det1)+' trouv� en index='+intToSTR(IndexBranche_det1)+' Branche='+intToSTR(branche_trouve_det1);
      AfficheDebug(s,clyellow);
    end;

    i:=0;N_Det:=0;
    if AdrFonc<>det2 then // si pas d�ja trouv� le sens de progression
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
          s:='613.2 : trouv�='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clYellow);
        end;

        // modif sp�cial TJD ==============
        ia:=index_aig(adrfonc);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
          adrPrec:=aiguillage[ia].Ddevie else
        // ================================

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((TypeGen=det) and (Adr=det2)) or (Adr=0) or (Adr>=9990) or (i=15) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i=itMaxi) and (Nivdebug=3) then afficheDebug('Pas trouv�',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then
      begin
        s:='Elements trop distants '+intToStr(det1)+' '+intToSTR(det2);
        afficheDebug(s,clorange);
      end;
    end

    else
    begin
      // d�ja trouv�
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
          s:='615 : trouv�='+intToSTR(Adr)+BTypeToChaine(typeGen);
          AfficheDebug(s,clorange);
        end;
        inc(idEl);
        elements[idEl].adresse:=adr;
        elements[idEl].typ:=TypeGen;

        // modif sp�cial TJD ==============
        ia:=index_aig(adrprec);
        if (aiguillage[ia].modele=tjd) and (aiguillage[ia].EtatTJD=4) then
          AdrFonc:=aiguillage[ia].Ddevie else
        // ================================

        AdrFonc:=AdrPrec;TypeFonc:=TypePrec;
        AdrPrec:=Adr;TypePrec:=TypeGen;

        inc(i);
        sortie:=(TypeGen=det) or (Adr=0) or (Adr>=9990) or (i>=itMaxi);
      until sortie;

      if (TypeGen=det) or (TypeGen=buttoir) then
      begin
        // Elements contient les �l�ments dans l'ordre inverse
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
              if roulage then Aiguillage[index_aig(j)].AdrTrain:=AdrTrain;
              result:=Aiguillage[index_aig(j)].AdrTrain;
            end;
          end;
          if (typePrec=det) then
          begin
            if TraceListe then AfficheDebug_Suivi(intToSTR(k)+' ',clOrange);
            if mode=0 then detecteur[j].AdrTrainRes:=0
            else
            if detecteur[j].AdrTrainRes=0 then
            begin
              if roulage then detecteur[j].AdrTrainRes:=AdrTrain;
              result:=detecteur[j].AdrTrainRes;
            end;
          end;
          Texte_aig_fond(j);
        end;
        reserve_dereserve_det:=0;
        exit;
      end;
    end;
    if (i>=itMaxi) then if NivDebug=3 then AfficheDebug('201 : It�ration trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incr�ment/d�cr�ment

  reserve_dereserve_det:=9996;
  if NivDebug=3 then affichedebug('------------------',clyellow);
  if debug=3 then formprinc.Caption:='';
end;

// pilote le train sur le d�tecteur det2, d'adresse adrtrain
// appel� depuis calcul_zones sur d�tecteur � 1 (sauf pour le 1er du train)
// le det1 indique d'ou vient le train pour le bon sens du signal
// det2 est le d�tecteur sur lequel se trouve le train
// le train est pilot� si on trouve un signal dans le bon sens sur det2, et on modula sa vitesse
// suivant l'�tat du signal
// it : num�ro du train du r�seau (pour la couleur)
procedure pilote_train(det1,det2,AdrTrain,it : integer);
var entree_signal,jauneC,rappel30C,blancC,rappel60C,rouge : boolean;
    index_train,adresse,adresse1,adresse2,Etat,voie1,voie2,indexSig,indexSig1,indexSig2,
    n,vitesse,i2,PointRoute : integer;
    couleur : TColor;
    s,nomTrain : string;
begin
  if not(roulage) or (adrtrain=0) then exit;
  if debugRoulage then Affiche('Pilote train '+intToSTR(det1)+' '+intToSTR(det2),clYellow);
  if ProcPrinc then AfficheDebug('Pilote_train '+intToSTR(det1)+' '+intToSTR(det2)+' '+intToSTR(AdrTrain),clWhite);
  index_train:=index_train_adresse(adrTrain);  // index du tableau trains
  if (index_train<1) or (index_train>Max_Trains) then
  begin
    Affiche('Erreur 650 : index train='+intToSTR(index_train),clred);
    exit;
  end;
  nomTrain:=trains[Index_train].nom_train;
  i2:=((it-1) mod NbCouleurTrain) +1;
  couleur:=CouleurTrain[i2];
  n:=trains[index_train].route[0].adresse;

  // si le d�tecteur est le dernier d�tecteur de la route
  //if (det2=trains[index_train].route[n].adresse) and (trains[index_train].route[n].typ=det) then
  pointroute:=trains[index_train].PointRout;
  if (pointroute>=n) and (trains[index_train].route[n].typ=det) then
  begin
    s:='Fin de route '+nomTrain+' - Arr�t train - Pointeur=';
    if debugRoulage then s:=s+intToSTR(PointRoute)+'/'+intToSTR(n);
    if traceListe then AfficheDebug(s,couleur);
    Affiche(s,couleur);
    trains[index_train].roulage:=0; // �vite le d�marrage du train s'il s'arr�te sur un detecteur avec demade d'arret temporis�.
    //event_det_train[it].signal_rouge:=adresse;
    //Affiche('*************Arret train',clred);
    Trains[index_train].arret_det:=true;
    Trains[index_train].phase_arret:=0;
    supprime_route_train(index_train);
    exit;
  end;

  index_signal_det(det2,voie1,indexSig1,voie2,indexSig2);     // renvoie les signaux1 et 2 (on peut avoir les signaux dan les 2 sens)
  if (indexSig1=0) and (indexSig2=0) then exit;

  adresse:=0;adresse1:=0;Adresse2:=0;indexSig:=0;
  if indexSig1<>0 then adresse1:=Signaux[indexSig1].adresse;
  if indexSig2<>0 then adresse2:=Signaux[indexSig1].adresse;

  if signaux[indexSig1].Adr_el_suiv1=detecteur[det2].suivant then indexSig:=indexSig1;
  if signaux[indexSig2].Adr_el_suiv1=detecteur[det2].suivant then indexSig:=indexSig2;

  {
  if (det1=523) and (det2=526) then
  begin
    Affiche('Adresse1='+intToSTR(Adresse1)+' IndexSig2='+intToSTR(Adresse2),clred);
    Affiche('ADrElSuiv1 du signal1='+intToSTR(signaux[indexSig1].Adr_el_suiv1)+' det2.suivant='+intToSTR(detecteur[det2].suivant),clred);
    Affiche('ADrElSuiv1 du signal2='+intToSTR(signaux[indexSig1].Adr_el_suiv1)+' det2.suivant='+intToSTR(detecteur[det2].suivant),clred);
  end;
  }

  if indexSig=0 then exit; // non pas dans le bon sens
  adresse:=signaux[indexsig].adresse;
  etat:=Signaux[indexSig].EtatSignal;

  rouge:=signal_rouge(Signaux[indexSig1].adresse);
  jauneC:=testbit(etat,jaune);
  BlancC:=testbit(etat,blanc) or testbit(etat,blanc_cli);
  rappel30C:=testbit(etat,rappel_30);
  rappel60C:=testbit(etat,rappel_60);

  entree_signal:=detecteur[det2].etat;

  // si le signal est au rouge et qu'on entre dans son d�tecteur
  if rouge and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' est au rouge - Arr�t train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,couleur);
    Affiche(s,couleur);
    event_det_train[it].signal_rouge:=adresse;
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      trains[index_train].TempoArretTemp:=0;  // pas d'arr�t temporis� : on arr�te
      trains[index_train].arret_det:=true;
      trains[index_train].phase_arret:=0;
    end;
  end;

  event_det_train[it].signal_rouge:=0;

  if (jauneC or Rappel30C or blancC) and entree_signal then
  begin
    begin
      if jauneC then
      begin
        s:='Signal '+intToSTR(adresse)+' � l''avertissement - Ralentissement train @'+intToSTR(AdrTrain);
        if traceListe then AfficheDebug(s,clLime);
        Affiche(s,ClLime);
      end;
      if Rappel30C and not(jauneC) then
      begin
        s:='Signal '+intToSTR(adresse)+' au rappel30 - Ralentissement train @'+intToSTR(AdrTrain);
        Affiche(s,clLime);
        if traceliste then affichedebug(s,Cllime);
      end;
      if blancC then
      begin
        s:='Signal '+intToSTR(adresse)+' au blanc - Ralentissement train @'+intToSTR(AdrTrain);
        Affiche(s,clLime);
        if traceliste then affichedebug(s,Cllime);
      end;
    end;
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitRalenti;
      //if trains[index_train].inverse then vitesse:=-vitesse;
      if trains[index_train].route[0].talon then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,10,0);
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
      if trains[index_train].route[0].talon then vitesse:=-vitesse;
      //if trains[index_train].inverse then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,10,0);
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
      //if trains[index_train].inverse then vitesse:=-vitesse;
      if trains[index_train].route[0].talon then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,10,0);
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
      //if (trains[index_train].inverse) then vitesse:=-vitesse;
      if trains[index_train].route[0].talon then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,10,0);
    end;

  end;

  if testbit(etat,semaphore_cli) and entree_signal then
  begin
    s:='Signal '+intToSTR(adresse)+' S�maphore cli - Vitesse r�duite train @'+intToSTR(AdrTrain);
    if traceListe then AfficheDebug(s,clLime);
    Affiche(s,clLime);
    if (index_train<>0) and (index_train<Max_Trains) then
    begin
      vitesse:=trains[index_train].VitRalenti;
      //if (trains[index_train].inverse) then vitesse:=-vitesse;
      if trains[index_train].route[0].talon then vitesse:=-vitesse;
      vitesse_loco('',index_train,AdrTrain,vitesse,10,0);
    end;
  end;
end;

// lib�rer tous les �l�ments de la route d'un train
procedure supprime_route_train(idtrain : integer);
var l,adr,dest,org,AdrTrainLoc,AdrTrain : integer;
    tz : tequipement;
begin
  if (idTrain<1) or (idTrain>nTrains) then exit;
  with trains[idTrain] do
  begin
    AdrTrain:=adresse;
    for l:=1 to route[0].adresse do
    begin
      Adr:=route[l].adresse;
      tz:=route[l].typ;
      // d�saffecter les aiguillages et les d�tecteurs affect�s � ce train

      if tz=det then
      begin
        adrTrainLoc:=detecteur[adr].AdrTrainRes;
        if (adrTrainLoc=AdrTrain) then detecteur[adr].AdrTrainRes:=0
      end;
      if tz<>det then
      begin
        adrTrainLoc:=aiguillage[index_aig(adr)].AdrTrain;
        if (adrTrainLoc=AdrTrain) then aiguillage[index_aig(adr)].AdrTrain:=0;
      end;

      route[l].adresse:=0;
      route[l].typ:=rien;
      route[l].pos:=0;
      route[l].talon:=false;
      Texte_aig_fond(Adr);
    end;
    route[0].adresse:=0;
    roulage:=0;
  end;

  // d�saffecter les cantons
  l:=trains[idTrain].CantonDest;
  trains[idTrain].cantonDest:=0;    // d�saffecte le canton du train
  trains[idTrain].cantonOrg:=0;

  if l>0 then
  begin
    l:=index_canton_numero(l);
    if l>0 then
    begin
      canton[l].bouton:=0;
      dest:=canton[l].NumcantonDest;
      org:=canton[l].NumcantonOrg;
      if org>0 then
      begin
        org:=index_canton_numero(org);
        canton[org].NumcantonOrg:=0;
        canton[org].NumcantonDest:=0;
        canton[org].bouton:=0;
        canton[org].AdrTrainRoute:=0;
        dessin_canton(org,0);
      end;
      if dest>0 then
      begin
        dest:=index_canton_numero(dest);
        canton[dest].NumcantonOrg:=0;
        canton[dest].NumcantonDest:=0;
        canton[dest].bouton:=0;
        canton[dest].AdrTrainRoute:=0;
        dessin_canton(dest,0);
      end;
    end;
  end;
  detdepart:=0;
  DetAtrouve:=0;

  // supprimer le tableau ParcoursDet[]
  ParcoursDet[0].adresse:=0;
  NbreRoutes:=0;
end;

// inverse une route
procedure Inverse_route(var A: TuneRoute);
var i,n: Integer;
    Tmp: TelementRoute;
begin
  n:=a[0].adresse;
  for i:=1 to n div 2 do
  begin
    Tmp:=A[i];
    A[i]:=A[n-i+1];
    A[n-i+1]:=Tmp;
  end;
end;


// un train s'est arr�t� apr�s la tempo d'arret sur un d�tecteur en mode roulage
// copie TempoArretTemp dans tempoDemarre
// appell� par le timer1
procedure train_sarrete(idTrain : integer);
var finroute,trouve : boolean;
    j,n,detect : integer;
    t : tequipement;
begin
  if trains[idTrain].TempoArretTemp<>0 then
  begin
    trains[idTrain].TempoDemarre:=trains[idTrain].TempoArretTemp;
    trains[idTrain].TempoArretTemp:=0;
  end;
  if tempoCombo>0 then dec(TempoCombo);

  if not(roulage) then exit;
  //Affiche('Maj Route det '+intToSTR(detect),clWhite);
  finroute:=false;
  trouve:=false;
  begin
    with trains[idTrain] do
    begin
      detect:=dernierDet;
      if roulage<>0 then
      begin
        n:=route[0].adresse;
        j:=0;
        repeat
          inc(j);
        until (j>n) or (route[j].traite=false);
        if (j>n) and (route[n].adresse=detect) then
        begin
          //Affiche('Route du train '+nom_train,clWhite);
          Affiche('Route du train '+nom_train+' termin�e.',clOrange);
          trains[Idtrain].roulage:=0; //
          // repartir � l'envers
          if false then
          begin
            if debugRoulage then Affiche('Route inverse',clWhite);
            // inverser �lement suivant et pr�c�dent du d�tecteur
            echange(detecteur[detect].suivant,detecteur[detect].precedent);
            t:=detecteur[detect].TypSuivant;
            detecteur[detect].TypSuivant:=detecteur[detect].TypPrecedent;
            detecteur[detect].TypPrecedent:=t;
            j:=trains[IdTrain].index_event_det_train;
            event_det_train[j].NbEl:=0;
            Inverse_route(route);
            for j:=1 to n do route[j].traite:=false;
            aig_canton(idTrain,trains[idTrain].route[1].adresse);
            demarre_index_train(idTrain);    // met la m�moire de roulage du train � 1
            // effacer le trac� du TCO
            for j:=1 to NbreTCO do zone_tco(j,detect,trains[idTrain].detecteurSuiv,1,trains[idTrain].adresse,0,false,true);  // true=efface loco
          end
          else supprime_route_train(idTrain);
        end;
      end;
    end;
  end;
end;

//--�volution de la route par train et mise � jour du pointeur
// doit �tre appell�e sur un �tat � 0 ou 1 de detect
procedure maj_route(detect : integer);
var i : integer;
begin
  if DebugRoulage then Affiche('Maj_route '+intToSTR(detect),clYellow);
  if roulage then
  begin
    // explorer les autres trains pour lib�rer leurs routes et positionner les aiguillages
    for i:=1 to ntrains do
    begin
      if trains[i].roulage<>0 then
        begin
          aig_canton(i,detect);
        end;
    end;
  end;
end;

procedure affiche_act_trouves;
var i : integer;
begin
  if IdActTr>10 then IdActTr:=10;
  for i:=1 to IdActTr do
    AfficheDebug(intToSTR(Actionneur_trouve[i]),clWhite);
end;

procedure Affiche_mesure_trains;
var i,j,k,n : integer;
    m : single;
    s : string;
begin
  n:=0;
  for i:=1 to nTrains do
  begin
    for j:=1 to trains[i].pointMes do
    begin
      with trains[i].mesure[j] do
      begin
        inc(n);
        s:=trains[i].nom_train+' D�tecteur=';
        s:=s+inttoSTR(detecteurM)+' Temps (1/10s)='+intToSTR(temps);
        s:=s+' V='+FloatToSTRF(vr,ffFixed,5,1)+' cm/s'+ ' Consigne='+intToSTR(vitcons);
        //s:=s+FloatToSTRF(trains[i].detecteurR[detecteurM,vitcons].moyenne,ffFixed,5,1);
        Affiche(s,clLime);
      end;
    end;

    with trains[i] do
    for k:=1 to 128 do
    begin
      for j:=1 to NbMaxDet do
      begin
        m:=detecteurR[j,k].moyenne;
        if m<>0 then
        begin
          s:='  Det='+intToSTR(j)+'  Consigne='+intToSTR(k)+' Crans  Moy='+FloatToSTRF(m,ffFixed,5,1)+
             'cm/s  NbreMes='+intToSTR(detecteurR[j,k].Nombre)+' Ecart='+FloatToSTRF(detecteurR[j,k].Ecart,ffFixed,5,1);
          Affiche(s,ClYellow);
        end;
      end;
    end;

    with trains[i] do
    begin
//      if pointMes<>0 then
      begin
        Affiche('Coefficients '+trains[i].nom_train,clWhite);
        if (consV1=0) and (consV2=0) and (consV3=0) then Affiche_Suivi(' Non mesur�',clWhite)
        else
        begin
          Affiche('  ConsV1='+intToSTR(consV1)+'  CoeffV1='+FloatToSTRF(coeffV1,ffFixed,5,2),clwhite);
          Affiche('  ConsV2='+intToSTR(consV2)+'  CoeffV2='+FloatToSTRF(coeffV2,ffFixed,5,2),clwhite);
          Affiche('  ConsV3='+intToSTR(consV3)+'  CoeffV3='+FloatToSTRF(coeffV3,ffFixed,5,2),clwhite);
        end;
      end;
    end;
  end;
  //if n=0 then affiche('Aucun train identifi� n''a �t� mesur�',clLime);
end;


// remplissage du tableau mesure de vitesse du train
// la mesure commence sur d�tecteur � 1 et se termine sur d�tecteur � 0, cette proc�dure est alors appell�e
// la mesure n'est pas faite si la vitesse en entr�e de d�tecteur et en sortie ne sont pas identiques (mesure en vitesse constante)
procedure calcul_vitesse_train(indextrain,detect : integer);
var vitesser,vm,moy : single;
    tps,j,n,consigne,ncd,EcartMin,Ecart,long_loco : integer;
begin
  //Affiche('Calcul_vitesse sur det '+intToSTR(detect),clYellow);
  if (indexTrain=0) or not mesureTrains then exit;
  trains[indexTrain].VitesseDetS:=trains[indexTrain].vitesseCons;
  consigne:=trains[indexTrain].VitesseDetS;
  //IdDet:=Index_adresse_detecteur(detect);
  tps:=detecteur[detect].Temps_cour;
  long_loco:=trains[indexTrain].longueur;
  if long_loco=0 then long_loco:=18;

  // si la consigne est la m�me que la consigne d'entr�e, on a parcouru le d�tecteur � vitesse constante
  if (consigne=trains[indexTrain].VitesseDetE) and
     (tps<>0) and (consigne<>0) then
  begin
    vitesseR:=10*(detecteur[detect].longueur+long_loco)/tps; // vitesse en cm/s
    Affiche('Tps='+intToSTR(tps)+'  Det='+intToSTR(detect)+'  l='+intToSTR(detecteur[detect].longueur)+'  Cons='+intToSTR(consigne)+'  V='+FloatToSTRF(vitesser,ffFixed,35,1)+' cm/s ',clWhite);

    if trains[indexTrain].pointMes>=100 then exit;
    inc(trains[indexTrain].pointMes);
    n:=trains[indexTrain].pointMes;  //nombre de mesures du tableau

    // remplir le tableau de mesures
    with trains[indexTrain].mesure[n] do
    begin
      vitcons:=trains[indexTrain].vitesseCons;
      detecteurM:=detect;
      temps:=tps;
      vr:=vitesser;
    end;

    // phase 1 : additionner les vitesses r�elles en cm/s par d�tecteur et par consigne, et compter leur nombre  (ncd)
    // les stocker dans trains[].detecteurR
    begin
      with trains[indexTrain] do
      begin
        inc(detecteurR[detect,consigne].nombre);
        //Affiche('Nouvelle phase ',clLime);
        ncd:=detecteurR[detect,consigne].nombre;
        if (ncd=1) and (detecteurREF=0) then
        begin
          //Affiche('D�tecteur de r�f�rence='+intToSTR(detect),clOrange);
          detecteurREF:=detect;  // d�tecteur de r�f�rence qui sert de bouclage
        end;
        FormMesure.LabelProg.Caption:=intToSTR(ncd)+'/'+FormMesure.EditNbrePassages.Text;
        if (ncd mod NbreArret=0) and (detect=detecteurREF) then
        begin
          inc(PhaseVitesse);
          if PhaseVitesse=2 then
          begin
            FormMesure.LabelMesC.Top:=202;
            Affiche('Mesure vitesse 2',clYellow);
            vitesse_loco('',0,trains[indexTrain].adresse,v2,10,ActionVitesse);
          end
          else
          if PhaseVitesse=3 then
          begin
            formmesure.LabelMesC.top:=226;
            Affiche('Mesure vitesse 3',clyellow);
            vitesse_loco('',0,trains[indexTrain].adresse,v3,10,ActionVitesse);
          end
          else
          if PhaseVitesse>=4 then
          begin
            formmesure.LabelMesC.Visible:=false;
            dec(trains[indexTrain].pointMes);  // ne pas prendre en compte la derni�re mesure
            mesureTrains:=false;
            vitesse_loco('',0,trains[indexTrain].adresse,0,10,ActionVitesse);
            Affiche_mesure_trains;
            Affiche('Fin des mesures',clWhite);
            with formMesure do
            begin
              ComboBoxTrains.Enabled:=true;
              ButtonLanceMes.Enabled:=true;
            end;
            exit;
          end;
        end;

        //Affiche('INC det'+intToSTR(detect)+' ='+intToSTR(ncd),clWhite);
        if (mesure[n].detecteurM=detect) and (mesure[n].vitcons=consigne) and (consigne<>0) and (detect<>0) then
        begin
          //Affiche('Ajout de '+FloatToSTRF(vitesser,ffFixed,35,1)+' � '+FloatToSTRF(detecteurR[detect,consigne].somme,ffFixed,35,1),clLime);
          detecteurR[detect,consigne].somme:=detecteurR[detect,consigne].somme+vitesseR;
          detecteurR[detect,consigne].moyenne:=detecteurR[detect,consigne].somme/ncd;
        end
        else
        begin
      //    Affiche('Refus� car ',clred);
      //    if consigne=0 then Affiche_suivi('consigne=0',clred);
        end;

        // phase 2: mesurer les �carts entre les vitesses sur les d�tecteurs par vitesse de consigne
        n:=0;
        moy:=0;
        // 1ere boucle pour d�terminer la moyenne de la vitesse consigne
        for j:=1 to nbMaxDet do
        begin
          vm:=detecteurR[j,consigne].moyenne;
          if vm<>0 then
          begin
            inc(n);
            moy:=moy+vm;
          end;
        end;
        if n<>0 then
        begin
          moy:=moy/n;
          ecartMin:=9999;
          // 2eme boucle pour calculer l'�cart entre les valeurs
          for j:=1 to nbMaxDet do
          begin
            vm:=detecteurR[j,consigne].moyenne;
            if vm<>0 then
            begin
              //Affiche(FloatToSTRF(vm,ffFixed,5,1),clOrange);
              detecteurR[j,consigne].ecart:=abs(vm-moy);
              Ecart:=round(abs(vm-moy));
              if ecartMin>Ecart then     // on choisit le mini de l'�cart pour calculer le coeff de vitesse
              begin
                EcartMin:=Ecart;
                // Affiche(intToSTR(consigne)+' '+FloatToSTRF(vm,ffFixed,5,2),clOrange);
                case phaseVitesse of
                1 : begin consV1:=consigne;coeffV1:=consigne/vm;end; // coefficient du train sauvegarde dans train
                2 : begin consV2:=consigne;coeffV2:=consigne/vm;end; // coeff = Consigne (crans) / Vitesse en (cm/s)
                3 : begin consV3:=consigne;coeffV3:=consigne/vm;calcul_equations_coeff(indexTrain);end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  detecteur[detect].Temps_cour:=0;                // arret incr�mente le compteur
end;

// calcul des zones depuis le tableau des fronts montants ou descendants des �v�nements d�tecteurs
// transmis dans le tableau Event_det
// rattache le nouveau d�tecteur � un train
// adresse: adresse du detecteur, front: �tat du d�tecteur
// les aiguillages doivent �tre positionn�s
procedure calcul_zones_V1(adresse: integer;etat : boolean);
var m,AdrSignal,AdrDetSignal,AdrTrainLoc,Nbre,i,i2,j,k,l,n,det1,det2,det3,det4,AdrSuiv,AdrPrec,Prev,
    id_couleur,det_suiv,nc,etatSig,ntco,d1,d2,sens,sensTCO,suivant2,prec,indexTrain,
    a1,a2 : integer ;
    traite,trouve,SuivOk1,Suivok2,casaig,rebond,finroute,but : boolean;
    couleur : tcolor;
    TypePrec,TypeSuiv : tEquipement;
    s,train_ch : string;
begin
  //Affiche('calcul zones '+intToSTR(adresse),clYellow);
  det3:=adresse; // c'est le nouveau d�tecteur
  if det3=0 then exit; // pas de nouveau d�tecteur
  traite:=false;
  rebond:=false;
  s:='Le nouveau d�tecteur est '+IntToSTR(det3);
  if etat then s:=s+' 1' else s:=s+' 0';
  Affiche_evt(s,clwhite) ;
  if dupliqueEvt then Affiche(s,clyellow) ;

  for i:=1 to N_trains do // nombre de trains d�tect�s en circulation
  begin
    index_couleur:=((i - 1) mod NbCouleurTrain) +1;
    couleur:=CouleurTrain[index_couleur];
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'�l�ments du tableau courant explor�
    det1:=event_det_train[i].det[1].adresse;
    det2:=event_det_train[i].det[2].adresse;
    adrTrainLoc:=event_det_train[i].Adrtrain;
    IndexTrain:=index_train_adresse(adrTrainLoc);
    trains[indexTrain].dernierDet:=det3;

    if ((det2=det3) and (nbre=2)) or ((det1=det3) and (nbre=1)) then
    begin
      //s:='D�t. '+intToSTR(det3)+' d�j� affect� au train '+IntToSTR(i);
      //Affiche_evt(s,clwhite);
      event_det_tick[N_event_tick].train:=i;
      event_det_tick[N_event_tick].reaffecte:=3;
      if dupliqueEvt then Affiche(s,clyellow);
      rebond:=true;  // possible rebond ?
    end;

    // 1 �l�ment dans le tableau et d�tecteur � 0---------------------------------------------
    if (nbre=1) and not(etat) then
    begin
      Det_Adj(det3);  // renvoie les adresses des d�tecteurs adjacents au d�tecteur "det3" r�sultat dans adj1 et adj2
      // traiter pour les cas avec 1 �l�ment
      if traceListe or ProcPrinc then AfficheDebug('1-0 traitement Train n�'+intToSTR(i)+' 1 d�tecteur',clyellow);

      CasAig:=(MemZone[det1,det2].Prev=adj2) or (MemZone[det1,det2].Prev=adj1);

      // v�rifier si l'�l�ment du tableau et le pr�c�dent sont contigus
      if (Adj1=det1) or (Adj2=det1) or casAig then
      begin
        event_det_tick[N_event_tick].train:=i;
        with event_det_train[i] do
        begin
          det[2].adresse:=det3;
          det[2].etat:=etat;
          NbEl:=2;
        end;
        Train_ch:=event_det_train[i].nom_train;
        if (AdrTrainLoc=0) and roulage then
        begin
          Affiche('D�marrage train non plac� depuis d�tecteur '+intToSTR(det3),clred);
          if TraceListe then AfficheDebug('D�marrage train non plac� depuis d�tecteur '+intToSTR(det3),clred);
        end;
         // affecter le nouveau d�tecteur
        detecteur[det3].train:=Train_ch;
        detecteur[det3].AdrTrain:=AdrTrainLoc;
        detecteur[det3].IndexTrainRoulant:=i;

        if not(casAig) then
        begin
          AdrSuiv:=detecteur_suivant_el(det1,det,det3,det,1); // trouve les actionneurs
        end
        else
        begin
          AdrSuiv:=MemZone[det1,det2].Prev;
          det1:=event_det_train[i].det[1].adresse;
        end;

        if adrSuiv>NbMaxDet then
        begin
          if adrsuiv=9996 then affiche_evt('Erreur aiguillage '+intToSTR(AigMal)+' mal positionn�',clred)
          else
          Affiche_evt('Info 1-0 '+intToSTR(AdrSuiv)+' : pas de suivant detecteur_suivant_el '+intToSTR(det1)+' '+intToSTR(det3),clWhite);
          exit;
        end
        else
        begin
          indexTrain:=Index_train_adresse(AdrTrainLoc);
          if indexTrain<>0 then
          begin
            Trains[indexTrain].detecteurSuiv:=AdrSuiv;
          end
          else trains[i].detecteurSuiv:=AdrSuiv;
        end;
        //*** route valid�e ***
        if (det1<NbMaxDet) and (det2<NbMaxDet) and (det3<NbMaxDet) and (adrSuiv<NbMaxDet) then
        begin
          MemZone[det1,det3].etat:=FALSE;      // d�valide l'ancienne zone
          MemZone[det1,det3].train:='';
          MemZone[det1,det3].Adrtrain:=0;
          MemZone[det1,det3].IndexTrainRoulant:=0;
          MemZone[det3,det1].etat:=FALSE;      // d�valide l'ancienne zone inverse
          MemZone[det3,det1].train:='';
          MemZone[det3,det1].Adrtrain:=0;      // lib�re la r�servation
          MemZone[det3,det1].IndexTrainRoulant:=0;
          MemZone[det3,AdrSuiv].etat:=true;    // valide la nouvelle zone
          MemZone[det3,AdrSuiv].train:=Train_ch;
          MemZone[det3,AdrSuiv].AdrTrain:=AdrTrainLoc;
          MemZone[det3,AdrSuiv].IndexTrainRoulant:=i;
          MemZone[AdrSuiv,det3].etat:=False;     // on d�valide la zone inverse
          MemZone[AdrSuiv,det3].train:='';
          MemZone[AdrSuiv,det3].AdrTrain:=0;
          MemZone[AdrSuiv,det3].IndexTrainRoulant:=0;
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
            AdrTrain:=AdrTrainLoc;
          end;
        end;
        libere_canton(det1,det3,AdrTrainLoc);   // on quitte det3
        event_act(det1,det3,0,'');     // �v�nement d�tecteur de zone � 0
        // affichages
        Affiche_Evt('1-0 route ok de '+intToSTR(det1)+' � '+IntToSTR(det3),clWhite);
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
        if roulage then maj_route(det3);  // positionner les aiguillages avant d'afficher le tco
        for ntco:=1 to nbreTCO do
        begin
          if PcanvasTCO[ntco]<>nil then
          begin
            // d�sactivation
            Zone_TCO(ntco,det1,det3,i,AdrTrainLoc,0,true,true);   // tco,det1,det2,train, mode
            // activation
            if ModeCouleurCanton=0 then zone_TCO(ntco,det3,AdrSuiv,i,AdrTrainLoc,1,true,true)
            else zone_TCO(ntco,det3,adrSuiv,i,AdrTrainLoc,2,true,true);  // affichage avec la couleur de index_couleur du train
          end;
        end;
        Maj_Signaux(false);
        Maj_Signaux(false);
        exit; // sortir absolument
      end
      else
      begin
        Affiche_evt('1-0 Train '+intToSTR(i)+' El�ments '+intToSTR(det1)+' et '+intToSTR(det3)+' non contigus',clyellow);
        AdrTrainLoc:=detecteur[det3].AdrTrain;
       // idt:=index_train_Adresse(AdrTrainLoc);
        if indexTrain<>0 then
        begin
          det_Suiv:=trains[indexTrain].detecteurSuiv;
          {event_det_train[i].NbEl:=2;
          event_det_train[i].Det[1].adresse:=det3;
          event_det_train[i].Det[1].etat:=false;
          event_det_train[i].Det[2].adresse:=trains[idt].detecteurSuiv;
          event_det_train[i].Det[2].etat:=false;
          nbre:=2; }
          MemZone[det3,det_suiv].etat:=true;
          MemZone[det3,det_suiv].AdrTrain:=AdrTrainLoc;
          for ntco:=1 to nbreTCO do
          begin
            //raz_cantons_train(AdrTrainLoc);        // efface tous les cantons contenant le train adrloc
             if ModeCouleurCanton=0 then zone_TCO(ntco,det3,det_suiv,i,AdrTrainLoc,1,true,true)
             else zone_TCO(ntco,det3,det_suiv,i,AdrTrainLoc,2,true,true);  // affichage avec la couleur de index_couleur du train
           end;
        end;
          for ntco:=1 to nbreTCO do
          maj_tco(ntco,det3);
        // det3 et det1 non adjacents
      end;
    end;

    // 1 �l�ment dans le tableau et d�tecteur � 1 : on pilote le train si feu sur det3---------------------------------------------
    if (nbre=1) and etat then
    begin
      if traceListe or ProcPrinc then AfficheDebug('1-1 Traitement Train n�'+intToSTR(i)+' 1 d�tecteur',clyellow);

      // si le d�tecteur est d�ja connu et que le nom du train est ok, l'affecter
      // (on recoit un 2eme evt sur ce det � 1 depuis CDM avec le nom du train)
      if (event_det_train[i].det[2].adresse=det3)  then
      begin
        s:=detecteur[det3].Train;
        if (s<>'_NONE') and (s<>'') then
        begin
          event_det_train[i].nom_train:=s;
          l:=index_train_nom(s);
          if l>0 then event_det_train[i].AdrTrain:=trains[l].adresse;
        end;
        exit;
      end;

      // v�rifier si l'�l�ment du tableau et le nouveau sont contigus
      Det_Adj(det1);  // renvoie les adresses des d�tecteurs adjacents au d�tecteur "det1" r�sultat dans adj1 et adj2

      suivok1:=((Adj1=det3) and (adj1<9999))  or ((Adj2=det3) and (adj2<9990));
      if suivok1 then
      begin
        Train_ch:=event_det_train[i].nom_train;
        AdrTrainLoc:=event_det_train[i].AdrTrain;
        indexTrain:=index_train_adresse(adrTrainLoc);
        event_det_tick[N_event_tick].train:=i;

        detecteur[det3].Temps_cour:=1;
        trains[indexTrain].VitesseDetE:=trains[indexTrain].VitesseCons;

        begin
          if (TrainZone[i].Nbre=0) and (det1<NbMaxDet) and (det3<NbMaxDet) then
          begin
            //Affiche('on a trouv� le train '+intToSTR(j),clYellow);
            detecteur[det3].train:=train_ch;    // affecter le nom du train au d�tecteur
            detecteur[det3].AdrTrain:=AdrTrainLoc ;    // affecter l'@ du train au d�tecteur
            trains[indexTrain].detecteurA:=det3;

            // mettre � jour �l�ments prec et suivant du nouveau d�tecteur
            det_adj(det3);
            // on autorise l'adjacent sur un aiguillage mal positionn� en talon
            if (adj1=det1) or (adj1=9998) then begin prec:=prec1;typePrec:=t1;end  // les variables sont renvoy�es par detAdj
            else
            if (adj2=det1) or (adj2=9998) then begin prec:=prec2;typePrec:=t2;end
            else exit;

            // affectation pr�c�dent au nouveau d�tecteur
            detecteur[det3].precedent:=prec;
            detecteur[det3].TypPrecedent:=TypePrec;
            // affecter le suivant
            AdrSuiv:=suivant_alg3(prec,typePrec,det3,det,1);
            detecteur[det3].suivant:=AdrSuiv;
            detecteur[det3].TypSuivant:=typeGen;

            detecteur[det1].train:=''; // d�saffecter le nom du train du d�tecteur pr�c�dent
            detecteur[det1].AdrTrain:=0;
            detecteur[det1].IndexTrainRoulant:=0;

            //*** route valid�e ***
            MemZone[det1,det3].etat:=TRUE;      // valide la nouvelle zone
            MemZone[det1,det3].train:=train_ch;
            MemZone[det1,det3].AdrTrain:=AdrTrainLoc;
            MemZone[det1,det3].IndexTrainRoulant:=i;

            MemZone[det3,det1].etat:=False;     // on d�valide la zone inverse

            event_det_train[i].Det[2].adresse:=det3;
            event_det_train[i].Det[2].etat:=etat;

            // test si on peut r�server le canton suivant
            //det_suiv:=det_suiv_cont(det1,det3,1);
            det_suiv:=detecteur_suivant_el(det1,det,det3,det,1);
            MemZone[det1,det3].Prev:=det_suiv;
            if det_suiv<9990 then
            begin
              indexTrain:=Index_train_adresse(AdrTrainLoc);
              if indexTrain<>0 then trains[indexTrain].detecteurSuiv:=det_suiv        // affecter le d�tecteur suivant au train
              else trains[i].detecteurSuiv:=det_suiv;
            end
            else
            begin
              if det_suiv=9996 then affiche_evt('Erreur 1-1 position inconnue aiguillage ',clred)
              else Affiche_evt('Erreur 1-1 '+intToSTR(Det_Suiv)+' : pas de suivant detecteur_suivant_el '+intToSTR(det1)+' '+intToSTR(det3),clred);
              //exit;
            end;
            s:='1-1 route ok de '+intToSTR(det1)+' � '+IntToSTR(det3)+' pour train '+intToSTR(i);
            Affiche_Evt(s,clWhite);
            // activation
            for ntco:=1 to nbreTCO do
             begin
               if ModeCouleurCanton=0 then zone_TCO(ntco,det1,det3,i,AdrTrainLoc,1,true,true)
               else zone_TCO(ntco,det1,det3,i,AdrTrainLoc,2,true,true);  // affichage avec la couleur de index_couleur du train
             end;
          end;
        end;

        pilote_train(det1,det3,adrtrainLoc,i);  // pilote le train sur det3
        event_act(det1,det3,1,'');     // activation zone - 2
        // actualiser le signal du det3
        j:=signal_detecteur(det3);
        if j<>0 then Maj_Signal_P(j,false);
        if roulage then maj_route(det3);
        maj_signaux(false);
        exit;
      end;

      if Traceliste then AfficheDebug(inttoSTR(det3)+' n''est pas contigu � '+intToSTR(det1)+' pour le train '+intToSTR(i),clyellow);
      traite:=true;  // traiter le train suivant
    end;

    // 2 �l�ments dans le tableau et d�tecteur � 0---------------------------------------------
    if (nbre=2) and not(etat) then
    begin
      if TraceListe or ProcPrinc then AfficheDebug('2-0 traitement Train n�'+intToSTR(i)+' 2 d�tecteurs',couleur);
      // test si det1, det2 et det3 sont contigus malgr� aig mal positionn�s
      //det_suiv:=det_suiv_cont(det1,det2,1);   // test si le suivant de det1 � det2 est bien le nouveau d�tecteur (det3)
      det_suiv:=detecteur_suivant_el(det1,det,det2,det,1);
      // si det_suiv=0 ; on fait un aller retour depuis un buttoir
      but:=false;
      if false and (det_suiv=0) then
      begin
        with event_det_train[i] do
        begin
          det[1].adresse:=0;
          det[1].etat:=false;
          det[2].adresse:=0;  // det3
          det[2].etat:=false;
          NbEl:=2;
        end;
        det2:=0;
        det_suiv:=det1;
        AdrSuiv:=det1;
        but:=true;
      end;
      if traceliste then affichedebug('Le suivant aux '+intToSTR(det1)+' '+intToSTR(det2)+' est '+intToSTR(det_suiv),couleur);
      SuivOk1:=(det_suiv=det3) and (det_suiv<9990);
      CasAig:=false;

      if not(SuivOk1) and not(but) then
      begin
        // cas d'un aiguillage qui a chang�
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
          event_det_tick[N_event_tick].reaffecte:=2;  // r�affect� par changement d'aiguillage
        end;
      end;

      if SuivOk1 or CasAig or but then
      begin
        if TraceListe then AfficheDebug('Route est valide, d�t '+intToSTR(det2)+' '+intToSTR(det3)+' contigus',couleur);
        // ici on cherche le suivant � det2 det3, algo=1
        event_det_tick[N_event_tick].train:=i;
        indexTrain:=Index_train_adresse(AdrTrainLoc);

        if not(casAig) and not(but) then AdrSuiv:=detecteur_suivant_el(det2,det,det3,det,0);  // dans le cas de CasAig, alors adrSuiv=9996 donc AdrSuiv a �t� calcul� plus haut (ligne -27)
        if AdrSuiv<9990 then
        begin
          event_det_train[i].suivant:=AdrSuiv;
          if indexTrain<>0 then trains[indexTrain].detecteurSuiv:=AdrSuiv       // affecter le d�tecteur sursuivant au train
          else trains[i].detecteurSuiv:=AdrSuiv;
        end;
        if TraceListe then AfficheDebug('le sursuivant est '+intToSTR(adrsuiv),couleur);
        if (Adrsuiv>=9990) and not(casaig) then
        begin
          //Affiche('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' � '+intToSTR(det3),clRed);
          if (NivDebug=3) or TraceListe then AfficheDebug('Msg 1500 : pas de suivant sur la route de '+intToSTR(det2)+' � '+intToSTR(det3),clorange);
        end
        else
        begin
          // en mode roulage, voir si on perd le d�tecteur si le train �tait arret� devant un signal rouge
          //if roulage then
          //begin
          //  AdrFeu:=event_det_train[i].signal_rouge;
          //  if AdrFeu<>0 then
          //  begin
          //    s:='Erreur signal '+intToSTR(AdrFeu)+' au rouge et perte d�tecteur: ignor�';
          //    Affiche_Evt(s,clred);
          //    if traceListe then AfficheDebug(s,clred);
          //    event_det_tick[N_event_tick].reaffecte:=4;   // fd sur un feu � 0
          //    exit;
          //  end;
          //end;

          if (det2<NbMaxDet) and (det3<NbMaxDet) and (AdrSuiv<NbMaxDet) then
          begin
            //*** route valid�e ***
            train_ch:=event_det_train[i].nom_train;
            AdrTrainLoc:=event_det_train[i].Adrtrain;
             // efface zone pr�c�dente
            MemZone[det2,det3].etat:=FALSE;
            MemZone[det2,det3].train:='';
            MemZone[det2,det3].AdrTrain:=0;
            MemZone[det2,det3].IndexTrainRoulant:=0;
            // on d�valide la zone inverse
            MemZone[det3,det2].etat:=False;
            MemZone[det3,det2].train:='';
            MemZone[det3,det2].AdrTrain:=0;
            MemZone[det3,det2].IndexTrainRoulant:=0;

            // valide la nouvelle zone
            MemZone[det3,AdrSuiv].etat:=TRUE;
            MemZone[det3,AdrSuiv].train:=train_ch;
            MemZone[det3,AdrSuiv].AdrTrain:=AdrTrainLoc;
            MemZone[det3,AdrSuiv].IndexTrainRoulant:=i;
            // on d�valide la zone inverse
            MemZone[AdrSuiv,det3].etat:=False;
            MemZone[AdrSuiv,det3].train:='';
            MemZone[AdrSuiv,det3].AdrTrain:=0;
            MemZone[AdrSuiv,det3].IndexTrainRoulant:=0;

            detecteur[det3].train:=train_ch ;   // affectation nom train au nouveau d�tecteur
            detecteur[det3].AdrTrain:=AdrTrainLoc;
            if detecteur[det2].train=train_ch then  detecteur[det2].train:='';    // d�saffectation du nom de train de l'ancien d�tecteur si le nom du train est �gal
            if detecteur[det2].AdrTrain=AdrTrainLoc then detecteur[det2].AdrTrain:=0;    // d�saffectation du nom de train de l'ancien d�tecteur

            libere_canton(det2,det3,AdrTrainLoc);
            det4:=detecteur_suivant_EL(det3,det,AdrSuiv,det,1);
            if det4>9990 then
            begin
              if det4=9996 then affiche_evt('Erreur: 2-0 position inconnue aiguillage ',clred)
              else Affiche_evt('Info: 2-0 '+intToSTR(Det4)+' : pas de detecteur_suivant_el '+intToSTR(det3)+' '+intToSTR(AdrSuiv),clyellow);
            end
            else
            begin
              indexTrain:=Index_train_adresse(AdrTrainLoc);
          //    if indexTrain<>0 then trains[indexTrain].detecteurSuiv:=det4       // affecter le d�tecteur sursuivant au train
          //    else trains[i].detecteurSuiv:=det4;
          //    Affiche('P3 detsuiv='+intToSTR(det4),clYellow);
            end;

            // calculer la constante de vitesse du train
            if indexTrain<>0 then
            begin
              calcul_vitesse_train(indextrain,det3);
            end;

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

            event_act(det2,det3,0,'');        // d�sactivation zone
            event_act(det3,AdrSuiv,1,'');     // activation zone
          end
          else
          begin
            s:='Erreur 740 : Adresse d�tecteur trop �lev� ';
            if det2>NbMaxDet then s:=s+inttostr(det2)+' ';
            if det3>NbMaxDet then s:=s+inttostr(det2)+' ';
            if AdrSuiv>NbMaxDet then s:=s+inttostr(det2);
            Affiche(s,clred);
          end;

          // supprimer le 1er evt et d�caler
          with event_det_train[i] do
          begin
            det[1].adresse:=event_det_train[i].det[2].adresse;
            det[1].etat:=event_det_train[i].det[2].etat;
            det[2].adresse:=det3;
            det[2].etat:=detecteur[det3].etat;
            NbEl:=2;
          end;

          // affichages
          s:='2-0 Train n�'+intToSTR(i)+' route ok de '+intToSTR(det2)+' � '+IntToSTR(det3);
          if casAig then s:=s+'A';
          s:=s+' � '+IntToSTR(Adrsuiv);

          Affiche_evt(s,couleur);
          if traceListe then AfficheDebug(s,clyellow);

          s:='Train '+IntToSTR(i);
          if AdrTrainLoc<>0 then s:=s+' @'+intToSTR(AdrTrainLoc);
          s:=s+' '+Train_ch+' sur zones '+IntToSTR(det3)+' � '+IntToStr(AdrSuiv);
          if traceListe then AfficheDebug(s,couleur);

          s:='Train '+IntToSTR(i);
          if AdrTrainLoc<>0 then s:=s+' '+train_ch+' @'+intToSTR(AdrTrainLoc);
          s:=s+' sur zones '+IntToSTR(det3)+' � '+IntToStr(AdrSuiv);
          if AffLoc then Affiche(s,Couleur);
          if AffAigDet then AfficheDebug(s,couleur);

          Affiche_Evt('1.Tampon train '+intToStr(i)+' '+event_det_train[i].nom_train+'--------',couleur);
          Affiche_Evt(intToSTR(event_det_train[i].det[1].adresse),couleur);
          Affiche_Evt(intToStr(event_det_train[i].det[2].adresse),couleur);
          if TraceListe then
          begin
            AfficheDebug(intToSTR(event_det_train[i].det[1].adresse),couleur);
            AfficheDebug(intToSTR(event_det_train[i].det[2].adresse),couleur);
          end;

          //Affiche('AdrTrainLoc='+inttoSTR(adrTrainLoc),clRed);
          //Affiche('>>> Le canton 7 contient le train '+intToSTR(canton[7].indexTrain),clWhite);

          for ntco:=1 to nbreTCO do
          begin
            if PcanvasTCO[ntco]<>nil then
            begin
              Maj_Aig_TCO(ntco);
              zone_TCO(ntco,det2,det3,i,AdrTrainLoc,0,true,true);    // d�sactivation
              // activation
              //affiche('Efface train '+intToSTR(AdrTrainLoc),clred);
              //raz_cantons_train(AdrTrainLoc);        // efface tous les cantons contenant le train
              if ModeCouleurCanton=0 then zone_TCO(ntco,det3,AdrSuiv,i,AdrTrainLoc,1,true,true)
              else zone_TCO(ntco,det3,AdrSuiv,i,AdrTrainLoc,2,true,true);  // affichage avec la couleur de index_couleur du train
            end;
          end;

          //Affiche('��� Le canton 7 contient le train '+intToSTR(canton[7].indexTrain),clWhite);
          if roulage then maj_route(det3);
          // mettre � jour si pr�sence signal sur det3 pour le passer au rouge de suite
          j:=signal_detecteur(det3);
          if j<>0 then
          begin
            Maj_Signal_P(j,false);
            etatSig:=Signaux[k].etatsignal;
          end;
          Maj_Signaux(false); // mise � jour g�n�rale
          exit; // sortir absolument
        end;
      end
      else
      begin
        Affiche_evt('2-0 Train '+intToSTR(i)+' El�ments '+intToSTR(det2)+' et '+intToSTR(det3)+' non contigus',clyellow);
        if event_det_train[i].det[2].adresse=det3 then
        begin
          s:='7. Rebond d�t. '+intToSTR(det3)+' d�j� affect� au train '+IntToSTR(i);
          FormDebug.MemoEvtDet.lines.add(s);
          if dupliqueEvt then AfficheDebug(s,clyellow);
          if dupliqueEvt then Affiche(s,clyellow);
        end;
      end;
    end;

    if (nbre=2) and etat then
    begin
      if TraceListe or (NivDebug=3)  or ProcPrinc then AfficheDebug('2-1 traitement Train n�'+intToSTR(i)+' 2 d�tecteurs',couleur);

      det_suiv:=detecteur_suivant_el(det1,det,det2,det,1);
      Suivok1:=(det_suiv=det3) and (det_suiv<9990);
      if traceliste then affichedebug('Le suivant aux '+intToSTR(det1)+' '+intToSTR(det2)+' est '+intToSTR(det_suiv),clWhite);
      det_Adj(det2); // adj1, adj2
      a1:=adj1;a2:=adj2;
      det_Adj(det3);
      if (a1<NbMaxdet) and (a2<NbMaxDet) then
        SuivOk2:=((a1=adj1) and detecteur[a1].Etat) or ((a1=adj2) and detecteur[a1].Etat) or
                 ((a2=adj1) and detecteur[a2].Etat) or ((a2=adj2) and detecteur[a2].Etat)
        else Suivok2:=false;

      if suivOk1 or Suivok2 then
      begin
        event_det_tick[N_event_tick].train:=i;
        if TraceListe then AfficheDebug('La route est valide car les d�tecteurs '+intToSTR(det2)+' '+intToSTR(det3)+' sont contigus',couleur);
        if (det1<NbMaxDet) and (det2<NbMaxDet) and (det3<NbMaxDet) then
        begin
          //*** route valid�e ***
          // on ne d�valide pas la zone pr�c�dente car sinon ne marche pas quand 2 trains se suivent
          MemZone[det2,det3].etat:=TRUE;      // valide la nouvelle zone
          MemZone[det3,det2].etat:=False;     // on d�valide la zone inverse
          Train_ch:=MemZone[det2,det3].train;
          AdrTrainLoc:=MemZone[det2,det3].AdrTrain;
          IndexTrain:=index_train_adresse(AdrTrainLoc);

          detecteur[det3].train:=Train_ch;   // affectation nom train au nouveau d�tecteur
          detecteur[det3].AdrTrain:=AdrTrainLoc;   // affectation train au nouveau d�tecteur
          detecteur[det3].IndexTrainRoulant:=i;

          detecteur[det3].suivant:=ESuiv;        // variables globales venant de detecteur_suivant_el
          detecteur[det3].TypSuivant:=tSuiv;
          detecteur[det3].precedent:=Eprec;
          detecteur[det3].TypPrecedent:=tPrec;

          detecteur[det2].train:=''; // d�saffectation du nom de train de l'ancien d�tecteur
          detecteur[det2].AdrTrain:=0;
          detecteur[det2].IndexTrainRoulant:=0;

          if indexTrain<>0 then
          begin
            trains[indexTrain].detecteurA:=det3;
            trains[indexTrain].index_event_det_train:=i;   // lier l'index du train en circulation
            // lancer la mesure de vitesse
            trains[indexTrain].VitesseDetE:=trains[indexTrain].vitesseCons;
            detecteur[det3].Temps_cour:=1;
            //Affiche('D�but comptage det '+intToSTR(det3),clYellow);
            //MessageBeep(mb_Iconwarning);
          end;

          pilote_train(det2,det3,adrtrainLoc,i);   // pilote le train sur det3
          // test si on peut r�server le canton suivant
          det_suiv:=detecteur_suivant_el(det2,det,det3,det,1);

          if det_suiv<9990 then
          begin
            if indexTrain<>0 then trains[indexTrain].detecteurSuiv:=det_Suiv       // affecter le d�tecteur suivant au train
            else trains[i].detecteurSuiv:=det_Suiv;
          end
          else
          begin
            if det_suiv=9996 then affiche_evt('Erreur 2-1 position inconnue aiguillage ',clred)
              else Affiche_evt('Erreur 2-1 '+intToSTR(Det_Suiv)+' : pas de suivant det_suiv_cont '+intToSTR(det2)+' '+intToSTR(det3),clred);
          end;
        end
        else
        begin
          s:='Erreur 740 : Adresse d�tecteur trop �lev� ';
          if det2>NbMaxDet then s:=s+inttostr(det2)+' ';
          if det3>NbMaxDet then s:=s+inttostr(det2)+' ';
          if AdrSuiv>NbMaxDet then s:=s+inttostr(det2);
          Affiche(s,clred);
        end;
        // stockage dans historique de zones sauf s'il est d�ja stock�
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
        s:='2-1 Train n�'+intToSTR(i)+' Route ok de '+intToSTR(det2)+' � '+IntToSTR(det3);
        Affiche_evt(s,couleur);
        if traceListe then AfficheDebug(s,Couleur);
        if AffAigDet then AfficheDebug(s,couleur);
        for ntco:=1 to nbreTCO do
        begin
          // d�sactivation du morceau avant l'aiguillage
          efface_trajet(det3,i);
        end;
        if roulage then maj_route(det3);
        exit; // sortir absolument
      end
      else
      begin
        if (det1=det3) and option_demitour then
        begin
          s:='Demi-tour train '+intToSTR(i);
          if TraceListe then AfficheDebug(s,clOrange);
          Affiche_evt(s,clOrange);
          MemZone[det2,det_Suiv].etat:=false;
          MemZone[det2,det3].etat:=true;
          for ntco:=1 to nbreTCO do
          begin
            // d�sactivation du morceau avant l'aiguillage
            efface_trajet(det2,i);
            if PcanvasTCO[ntco]<>nil then
            begin
              Maj_Aig_TCO(ntco);
              zone_TCO(ntco,det2,det_suiv,i,AdrTrainLoc,0,true,true);    // d�sactivation}
            end;
          end;
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
          if TraceListe then AfficheDebug('La route est invalide car les d�tecteurs '+intToSTR(det1)+' '+intToSTR(det2)+' n''ont pas le '+intToSTR(det3)+' attendu',clOrange);
          s:='2-1 Train n�'+intToSTR(i)+' Route nok de '+intToSTR(det2)+' � '+IntToSTR(det3);
          Affiche_evt(s,couleur);
          for ntco:=1 to nbreTCO do
          begin
            // d�sactivation du morceau avant l'aiguillage
            efface_trajet(det3,i);
          end;
        end;
      end;
      traite:=true; // non trait�: train suivant
    end;
  end;  // fin de la boucle for i

  // dans cette partie, le d�tecteur n'a pas encore �t� affect� � un train existant.
  if rebond then exit;

  if etat then
  begin
    // mettre � jour le signal du d�tecteur
    i2:=signal_detecteur(det3);  // trouve le signal associ� au detecteur2
    if i2<>0 then Maj_Signal_P(i2,false);  // avec d�tecteur

    for i:=1 to N_trains do // N_trains est le nombre de trains d�tect�s en circulation
    begin
      i2:=event_det_train[i].Suivant;
      if i2>NbMaxDet then begin AfficheDebug('Erreur 715 : d�tecteur '+intToSTR(i2)+' trop grand',clred);exit;end;
      SuivOk1:=event_det_train[i].Det[2].etat ;
      det_adj(det3);
      if (adj1=i2) or (adj2=i2) then
      begin
        s:='Train '+intToSTR(i)+' D�tection '+intToSTR(det3)+' � 1 avant RAZ du '+intToSTR(i2);
        Affiche_evt(s,clorange);
        if traceListe then afficheDebug(s,clorange);
        detecteur[det3].AdrTrain:=i; // r�cup�ration du train au d�tecteur

        adrTrainLoc:=detecteur[i2].AdrTrain;
        Train_ch:=MemZone[det2,i2].train;

        detecteur[det3].train:=Train_ch;   // affectation nom train au nouveau d�tecteur
        detecteur[det3].AdrTrain:=AdrTrainLoc;   // affectation train au nouveau d�tecteur
        detecteur[det2].train:=''; // d�saffectation du nom de train de l'ancien d�tecteur
        detecteur[det2].AdrTrain:=0;

        event_det_tick[N_event_tick].train:=i;
        event_det_tick[N_event_tick].reaffecte:=1;    // mauvais s�quen�age d�tecteurs contigus

        pilote_train(i2,det3,adrtrainLoc,i);   // pilote le train sur det3
        // test si on peut r�server le canton suivant
        det_suiv:=det_suiv_cont(i2,det3,1);
        if roulage then maj_route(det3);
        Maj_Signaux(true);
        exit;
      end;
    end;
    Maj_Signaux(false);
  end;

  // nouveau train front det=0
  if not(etat) then
  begin
    if traceListe or ProcPrinc then AfficheDebug('Nouveau train',clyellow);
    // Nombre d'�l�ments � 0 : ici c'est un nouveau train donc cr�er un train, donc un tableau
    if N_Trains>=Max_Trains then
    begin
      Affiche('Erreur nombre de train maximal atteint',clRed);
      N_trains:=0;
    end;
    Inc(N_trains);
    event_det_tick[N_event_tick].train:=n_trains;  // num�ro du train en circulation

    with event_det_train[N_trains] do
    begin
      det[1].adresse:=0;
      det[2].adresse:=0;
      NbEl:=0;
      nom_train:='';
    end;

    if roulage then maj_route(det3);
    // v�rifier si le d�tecteur du nouveau train est associ� � un feu vers un buttoir
    for i:=1 to NbreSignaux do
    begin
      AdrSignal:=Signaux[i].Adresse;
      AdrDetSignal:=Signaux[i].Adr_Det1;
      if (AdrDetSignal=Det3) and not(isDirectionnel(i)) then
      begin
        AdrSuiv:=Signaux[i].Adr_el_suiv1;
        TypeSuiv:=Signaux[i].Btype_suiv1;
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetSignal,det,1) ; // d�tecteur pr�c�dent le feu ; algo 1
        if AdrPrec=0 then
        begin
          if TraceListe then Affiche('FD - Le signal '+IntToSTR(AdrSignal)+' est pr�c�d� d''un buttoir',clyellow);
          if AdrDetSignal<NbMaxDet then
            MemZone[0,AdrDetSignal].etat:=false
          else
            Affiche('Erreur 741: Adresse d�tecteur signal trop �lev�: '+intToSTR(AdrDetSignal),clred);
          Maj_Signal_P(AdrSignal,false);
        end;
      end;
    end;

    if TraceListe then AfficheDebug('Cr�ation Train n�'+intToSTR(N_trains),clyellow);
    Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);

    // v�rifier si le train est d�marr� avec positionnement dans le canton
    j:=1;trouve:=false;
    while (j<nCantons) and not trouve do
    begin
      trouve_det_canton(j,det1,det2);
      adrTrainLoc:=canton[j].adresseTrain;
      if adrTrainLoc>9000 then
      begin
        Affiche('Anomalie 625 canton n�'+intToSTR(canton[j].numero),clred);
        canton[j].indexTrain:=0;
        AdrTrainLoc:=0;
        MessageBeep(MB_ICONERROR);
      end;
      trouve:=((det1=det3) or (det2=det3)) and ((AdrTrainLoc<>0) and (AdrTrainLoc<>9999));
      inc(j);
    end;

    if trouve then
    begin
      dec(j);
      sens:=canton[j].SensLoco;
      if sens=0 then
      begin
        Affiche('Anomalie 626 : Pas de sens de circulation d�clar� pour le train '+trains[canton[j].indexTrain].nom_train+' canton '+intToSTR(canton[j].numero),clred);
      end;
      // convertir en sens canton
      case sens of
        sensGauche : sensTCO:=SensTCO_O;
        sensDroit  : sensTCO:=SensTCO_E;
        sensBas    : sensTCO:=SensTCO_S;
        sensHaut   : sensTCO:=SensTCO_N;
      end;
      suivant:=trouve_det_suiv_canton(j,det3,sensTCO);
      if suivant>9990 then exit;
      adrTrainLoc:=canton[j].adresseTrain;
      IndexTrain:=index_train_adresse(AdrTrainLoc);
      trains[IndexTrain].detecteurSuiv:=suivant;

      event_det_train[n_trains].suivant:=suivant;
      
      detecteur[det3].Train:=canton[j].NomTrain;
      detecteur[det3].AdrTrain:=AdrTrainLoc;
      detecteur[det3].IndexTrainRoulant:=n_trains;

      MemZone[det3,suivant].etat:=true;
      MemZone[det3,suivant].train:=canton[j].NomTrain;
      MemZone[det3,suivant].AdrTrain:=AdrTrainLoc;
      MemZone[det3,suivant].IndexTrainRoulant:=n_trains;
      suivant2:=detecteur_Suivant_el(det3,det,suivant,det,1);
      MemZone[det3,suivant].Prev:=suivant2;

      index_couleur:=((n_trains - 1) mod NbCouleurTrain) +1;
      for ntco:=1 to nbreTCO do
      begin
        //raz_cantons_train(AdrTrainLoc);        // efface tous les cantons contenant le train adrloc
        if ModeCouleurCanton=0 then zone_TCO(ntco,det3,suivant,AdrTrainloc,0,1,true,true)
               else zone_TCO(ntco,det3,suivant,n_trains,AdrTrainLoc,2,true,true);  // affichage avec la couleur de index_couleur du train
      end;
      pilote_train(0,det3,adrtrainLoc,n_trains);  // pilote le train sur det3

      // lib�rer le canton pr�c�dent
      libere_canton(det1,det2,AdrTrainLoc);

    end;
    begin
      // si d�marr� sans positionnement dans canton
      with event_det_train[N_trains] do
      begin
        det[1].adresse:=det3;
        det[1].etat:=etat;
        NbEl:=1;
        nom_train:=detecteur[det3].train;
       // Affiche('d�tecteur='+intToSTR(det3)+' '+nom_train,clWhite);
        AdrTrain:=detecteur[det3].AdrTrain;
      end;
    end;

    TrainZone[n_trains].train:=detecteur[det3].train;
    TrainZone[n_trains].AdrTrain:=detecteur[det3].Adrtrain;

    // chercher le train sur le canton par le d�tecteur det3
    {
    if roulage then
    begin
      n:=1;
      repeat
        d1:=canton[n].det1;
        d2:=canton[n].det2;
        if (d1=det3) or (d2=det3) then trouve:=true;
        inc(n);
      until (n>nCantons);
      if trouve then //
      begin
        dec(n);
        sens:=canton[n].sens;
        //case sens of
        //sensGauche : d1:=
        j:=index_train_adresse(detecteur[det3].AdrTrain);
       // j:=trains[j].detdir; // detecteur destination
        MemZone[det3,j].etat:=true;
        MemZone[det3,j].train:=detecteur[det3].train;
        MemZone[det3,j].AdrTrain:=detecteur[det3].AdrTrain;
        MemZone[det3,j].IndexTrain:=n_trains;
      end;
    end; }


    s:=intToSTR(event_det_train[N_trains].det[1].adresse);
    id_couleur:=((N_trains - 1) mod NbCouleurTrain) +1;

    for i2:=1 to NbreTCO do maj_TCO(i2,det3);

    Affiche_Evt('0-0 Cr�ation train '+intToStr(N_trains)+' '+detecteur[det3].train+'--------',CouleurTrain[id_couleur]);
    Affiche_evt(s,CouleurTrain[id_couleur]);
    if dupliqueEvt then
    begin
      Affiche('0-0 Cr�ation train '+intToStr(N_trains)+' '+detecteur[det3].train+'--------',clyellow);
      Affiche(s,clyellow);
    end;
    if TraceListe or ProcPrinc then
    begin
      AfficheDebug('0-0 Cr�ation train '+intToStr(N_trains)+' '+detecteur[det3].train+'--------',clyellow);
      AfficheDebug(s,clyellow);
    end;
    Maj_Signaux(false);
    exit;
  end;

  //if etat then detecteur[det3].IndexTrain:=1;
end;


// affecte le d�tecteur "adresse" d'�tat "front" au train et met sa route � jour
procedure calcul_zones(adresse: integer;front : boolean);
begin
  if debug=3 then formprinc.Caption:='Calcul_zones '+intToSTR(adresse);
  case Algo_localisation of
  1 : calcul_zones_v1(adresse,front);
  else affiche('Algo localisation inconnu',clred);
  end;
  if debug=3 then formprinc.Caption:='';
end;


// demande l'�tat d'un d�tecteur � la centrale. Le r�sultat sera r�ceptionn� sur �v�nement des informations
// de r�trosignalisation : decode_retro_XpressNet
procedure demande_info_det_XpressNet(adresse : integer);
var s : string;
    n,module : byte;
begin
  // uniquement si connect� directement � la centrale
  if portCommOuvert or parSocketLenz or (etat_init_interface>=11)  then
  begin
    if protocole=1 then
    begin
      module:=(adresse-1) div 8;  // module � partir de 64
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
      Affiche('Erreur demande info d�tecteur '+intToSTR(adresse)+' non trait�e en dcc+',clred);
    end;
  end;
end;


// demande l'�tat d'un accessoire � la centrale. Le r�sultat sera r�ceptionn� sur �v�nement des informations
// de r�trosignalisation.
procedure demande_info_acc_XpressNet(adresse : integer);
var s : string;
    n : byte;
begin
  // uniquement si connect� directement � la centrale
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
      Affiche('Erreur demande info accessoire '+intToSTR(adresse)+' non trait�e en dcc+',clred);
    end;
  end;
end;

// demande l'�tat de tous les d�tecteurs par l'interface en XpressNet
// v�rifie l'�tat des d�tecteurs en fonction de la d�claration des cantons
procedure demande_etat_det;
var i,j,adr,t : integer;
    s : string;
begin
  if simuInterface then exit; // ####
  if portCommOuvert or parSocketLenz or (etat_init_interface>=11) then
  begin
    Affiche('Demande �tat des d�tecteurs',ClYellow);
    if protocole=1 then
    begin
      modeStkRetro:=true; // stockage sans evt
      for j:=1 to NDetecteurs do
      begin
        adr:=Adresse_detecteur[j];
        Affiche('Demande �tat d�tecteur '+intToSTR(adr),clLime);
        retEtatDet:=false;
        demande_info_det_XpressNet(adr);
        t:=0;
        repeat
          Application.ProcessMessages;
          inc(t);
          sleep(10);
        until (retEtatDet) or (t>100);
        if t>100 then s:='=?' else
        //if Detecteur[adr].etat then s:='=1' else s:='=0';
        //Affiche_suivi(s,clLime);
      end;
      modeStkRetro:=false; // avec evt
    end;
    for j:=1 to Ndetecteurs do
    begin
      adr:=Adresse_detecteur[j];
      for i:=1 to ncantons do
      begin
        if ((canton[i].el1=adr) and (canton[i].typ1=det)) or
           ((canton[i].el2=adr) and (canton[i].typ2=det)) then
        begin
          if (canton[i].adresseTrain=0) and (detecteur[j].etat) then
          begin
            s:='Le canton '+intToSTR(canton[i].numero)+' contigu au d�tecteur '+intToSTR(adr)+' � 1 ne contient pas de train';
            Affiche(s,clOrange);
          end;
        end;
      end;
    end;
  end;
end;


// demande l'�tat de tous les accessoires par l'interface
procedure demande_etat_acc;
var i,adresse : integer;
    model : Tequipement;
begin
  if portCommOuvert or parSocketLenz then
  begin
    Affiche('Demande �tat des aiguillages',ClYellow);
    if protocole=1 then
    begin
      for i:=1 to maxaiguillage do
      begin
        model:=aiguillage[i].modele ;
        if (model<>rien) and (model<>crois) then
        begin
          adresse:=aiguillage[i].Adresse;
          Affiche('Demande �tat aiguillage '+intToSTR(adresse),clLime);
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
  numacc:=Tablo_pn[i].AdresseFerme; // num�ro de p�riph�rique
  if numacc=0 then exit;
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
    Affiche('Erreur 56 : num�ro de p�riph�rique hors limite pour PN '+intToSTR(i),clred);
    exit;
  end;
  v:=Tablo_periph[numacc].NumCom;  // num�ro de com
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
    else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non d�tect�',clred);
end;

// ouvre le pn par port com usb
procedure ouvre_pn_usb(i : integer);
var v,cmd,numacc : integer;
    s : string;
begin
  numacc:=Tablo_pn[i].AdresseFerme; // num�ro d'accessoire
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
   Affiche('Erreur 57 : num�ro de p�riph�rique hors limite pour PN '+intToSTR(i),clred);
   exit;
  end;
  v:=Tablo_periph[numacc].NumCom;  // num�ro de com
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
   else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non d�tect�',clred);
end;

// ouvre le pn par socket i = index tablo_pn
procedure ouvre_pn_socket(i : integer);
var numacc,cmd : integer;
    s : string;
begin
  numacc:=Tablo_pn[i].AdresseFerme; // num�ro d'accessoire
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
  numacc:=Tablo_pn[i].AdresseFerme; // num�ro d'accessoire
  if numacc=0 then exit;
  s:=Tablo_PN[i].CommandeF;
  if Tablo_periph[numacc].cr then s:=s+#13;
  cmd:=Tablo_periph[numacc].numComposant;
  if cmd=1 then Formprinc.ClientSocketCde1.Socket.SendText(s);
  if cmd=2 then Formprinc.ClientSocketCde2.Socket.SendText(s);
  Affiche('Envoie socket'+intToSTR(numacc)+' commande: '+s,clWhite);
end;


// envoie une chaine de caract�res du tablo actionneur index i : index action , j : index op�ration
procedure envoi_periph_usb(i,j : integer);
var numacc,v,cmd : integer;
    s : string;
begin
  numacc:=Tablo_Action[i].TabloOp[j].periph; // num�ro de p�riph�rique
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
    Affiche('Erreur 58 : num�ro de p�riph�rique hors limite '+intToSTR(i),clred);
    exit;
  end;
  v:=Tablo_periph[numacc].NumCom;  // num�ro de com
  if v=0 then exit;
  if tablo_periph[numacc].PortOuvert then
  begin
    s:=Tablo_Action[i].TabloOp[j].chaine;
    if Tablo_periph[numacc].cr then s:=s+#13;
    cmd:=Tablo_periph[numacc].numComposant;
    if cmd=1 then envoi_usb_comp(MSCommCde1,s);
    if cmd=2 then envoi_usb_comp(MSCommCde2,s);

    if Tablo_periph[numacc].ScvVis then Affiche('Envoi COM'+intToSTR(v)+': '+s,clYellow);
  end
    else Affiche('Envoi commande impossible ; COM'+intToSTR(v)+' non d�tect�',clred);
end;

// envoi le texte traindest de l'accessoire sur le socket de l'actionneur i
procedure envoi_socket_periph_act(i,j : integer);
var v,numacc : integer;
    s : string;
begin
  v:=Tablo_Action[i].tabloOp[j].periph; // num�ro de p�riph�rique
  numacc:=Tablo_periph[v].numComposant;   //num�ro de composant
  if (numAcc>NbMaxi_Periph) or (numacc=0) then
  begin
    Affiche('Erreur 59 : num�ro de p�riph�rique hors limite',clred);
    exit;
  end;
  s:=Tablo_Action[i].TabloOp[j].chaine;
  if Tablo_periph[numacc].cr then s:=s+#13;
  if numacc=1 then Formprinc.ClientSocketCde1.socket.SendText(s);
  if numacc=2 then Formprinc.ClientSocketCde2.socket.SendText(s);
  if Tablo_periph[numacc].ScvVis then Affiche('Envoi socket '+s,clYellow);
end;

// envoie un texte vers tous les clients, connect�s au serveur signaux_complexes
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

// test si "train" est dans la liste des trains combin�s traincombine
// pour le d�clenchement s�lectif des actionneurs
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


// faire l'op�ration "ida" de l'action i
procedure action_operation(i,ida : integer);
var decl,op,af,access,sortie,t,v,etat,adr : integer;
    st,trainDest : string;
    Ts : TAccessoire;
    tr : single;
begin
  st:='Action '+Tablo_Action[i].NomAction+' op='+intToSTR(ida)+' : ';
  op:=Tablo_Action[i].tabloOp[ida].numoperation;
  if Tablo_Action[i].tabloOp[ida].valide then  // si l'op�ration n'est pas inhib�e par le double clic
  begin
    decl:=Tablo_Action[i].declencheur;
    if decl=DeclHorloge then
    begin
      st:=st+'Horaire '+format('%.2dh%.2d',[t,v]);
      t:=Tablo_Action[i].heure;
      v:=Tablo_Action[i].minute;
    end;

    // 1 : affiche TCO
    if (op=ActionAffTCO) then
    begin
      af:=Tablo_Action[i].tabloOp[ida].NumTCO;
      Affiche(st+' Affiche TCO'+intToSTR(af),clyellow);
      Affiche_Fenetre_TCO(af,true);
    end;

    if (op=ActionAffSC) then
    begin
      Affiche(st+' Affiche SC',clyellow);
      with FormPrinc do
      begin
        windowState:=wsNormal; //Maximized;
        show;
        BringToFront;
      end;
    end;

    if (op=ActionAffCDM) then
    begin
      if CDMhd<>0 then
      begin                                 // afficher CDM rail
        Affiche(st+' Affiche CDM',clyellow);
        ShowWindow(CDMhd,SW_MAXIMIZE);
        SetForegroundWindow(CDMhd);             // met CDM en premier plan
        SetActiveWindow(CdmHd);
      end;
    end;

    // 4 : accessoire
    if (op=ActionAccessoire) then
    begin
      access:=Tablo_Action[i].tabloOp[ida].adresse;
      sortie:=Tablo_Action[i].tabloOp[ida].etat;
      Affiche(st+' Accessoire '+IntToSTR(access)+':'+intToSTR(sortie),clyellow);
      // ex�cution la fonction accessoire vers CDM
      if Tablo_Action[i].tabloOp[ida].zero then Ts:=aigP else Ts:=signal;
      pilote_acc(access,sortie,Ts);
    end;

    // 5 : arret des trains
    if (op=actionArretTrains) then
    begin
      Affiche(st+' Arr�t de tous les trains',clYellow);
      for t:=1 to ntrains do
      arret_train(trains[t].nom_train,t,trains[t].adresse);
    end;

    // 6 : Lance Horloge
    if op=ActionLanceHorl then
    begin
      Affiche(st+' Lancement horloge',clyellow);
      Demarre_horloge;
    end;

    // 7 : Arret Horloge
    if op=ActionArretHorl then
    begin
      Affiche(st+' Arret horloge',clyellow);
      horloge:=false;
    end;

    // 8 : init Horloge
    if op=ActionInitHorl then
    begin
      Affiche(st+' Init horloge',clyellow);
      Init_horloge;
    end;

    // 9 : Affiche Horloge
    if op=ActionAffHorl then
    begin
      Affiche(st+' Affiche horloge',clyellow);
      Affiche_horloge;
    end;

    // 10: vitesse
    if (op=ActionVitesse) then
    begin
      traindest:=Tablo_Action[i].tabloOp[ida].train;
      Affiche(st+' Vitesse train='+trainDest+' � '+IntToSTR(Tablo_Action[i].tabloOp[ida].vitesse),clyellow);
      vitesse_loco(trainDest,0,0,Tablo_Action[i].tabloOp[ida].vitesse,10,ActionVitesse);
    end;

    // 11 : commande COM/USB socket
    if (op=ActionCdePeriph) then
    begin
      v:=Tablo_Action[i].TabloOp[ida].periph;   // num�ro d'accessoire
      Affiche(st+' Envoi commande',clYellow);
      af:=com_socket(v);
      if af=1 then envoi_periph_usb(i,ida);    // num�ro d'actionneur
      if af=2 then envoi_socket_periph_act(i,ida); // num�ro d'actionneur
    end;

    // 12 actionneur pour fonction train
    if (op=ActionFonctionF) then
    begin
      trainDest:=Tablo_Action[i].tabloOp[ida].train;
      // ex�cution de la fonction F vers CDM
      etat:=Tablo_Action[i].tabloop[ida].etat;

      tr:=Tablo_Action[i].tabloop[ida].TempoF/10;
      Affiche(st+' TrainDest='+trainDest+' F'+IntToSTR(Tablo_Action[i].tabloOp[ida].fonctionF)+':'+intToSTR(etat)+' t='+Format('%.1f', [tr])+'s',clyellow);
      envoie_fonction(Tablo_Action[i].TabloOp[ida].fonctionF,etat,trainDest);
      Tablo_Action[i].tabloOp[ida].TrainCourant:=trainDest;  // pour m�moriser le train pour la retomb�e de la fonction
      Tablo_Action[i].TabloOp[ida].TempoCourante:=Tablo_Action[i].tabloop[ida].TempoF;
    end;

    // 13 : son
    if (op=ActionSon) then //and ( test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')) and (etatValide) then
    begin
      Affiche(st+' son '+Tablo_Action[i].tabloop[ida].chaine,clyellow);
      PlaySound(pchar(Tablo_Action[i].tabloop[ida].train),0,SND_ASYNC);
    end;

    // 14 : tempo
    if op=ActionTempo then
    begin
      etat:=Tablo_Action[i].tabloop[ida].TempoF;
      tr:=etat/10;
      Affiche(st+' Tempo '+Format('%.1f', [tr])+'s',clyellow);
      Tablo_Action[i].TabloOp[ida].TempoCourante:=etat;
      // si on a une tempo, passer la main au timer pour toutes les actions suivantes.
      if (ida<Tablo_Action[i].NbOperations  ) then
      begin
        inc(index_seqAct);
        seq_actions[index_seqAct].tick:=tick+Tablo_Action[i].tabloop[ida].TempoF+1;
        seq_actions[index_seqAct].indiceAction:=i;
        seq_actions[index_seqAct].indiceOp:=ida+1;
      end;
    end;

    //15 action bouton tco
    if op=ActionBoutonTCO then
    begin
      etat:=Tablo_Action[i].tabloop[ida].etat;
      adr:=Tablo_Action[i].tabloop[ida].adresse;
      Affiche(st+' Bouton TCO '+intToSTR(adr)+' � '+intToSTR(etat),clYellow);
      if (adr<=0) or (adr>MaxMemoires) then exit;
      BoutonTCO[adr].etat:=etat;
      affiche_cellule(BoutonTCO[adr].idtco,BoutonTCO[adr].x,BoutonTCO[adr].y);
    end;

    if op=ActionAffecteMemoire then
    begin
      adr:=Tablo_Action[i].tabloop[ida].adresse;
      etat:=Tablo_Action[i].tabloop[ida].etat;
      Affiche(st+' M�moire '+intToSTR(adr)+' � '+intToSTR(etat),clYellow);
      if (adr<0) or (adr>MaxMemoires) then exit;
      Memoire[adr]:=etat;
    end;

    if op=ActionIncMemoire then
    begin
      adr:=Tablo_Action[i].tabloop[ida].adresse;
      if (adr<0) or (adr>MaxMemoires) then exit;
      inc(Memoire[adr]);
      Affiche(st+' Incr�mente m�moire '+intToSTR(adr)+' - Nouvelle valeur='+intToSTR(memoire[adr]),clYellow);
    end;
    if op=ActionDecMemoire then
    begin
      adr:=Tablo_Action[i].tabloop[ida].adresse;
      if (adr<0) or (adr>MaxMemoires) then exit;
      dec(Memoire[adr]);
      Affiche(st+' Decr�mente m�moire '+intToSTR(adr)+' - Nouvelle valeur='+intToSTR(memoire[adr]),clYellow);
    end;
  end
  else
    Affiche(st+operations[op].nom+' d�valid�e',clOrange);
end;

// lance les op�rations de l'action action
procedure action(action : integer);
var i,nb : integer;
    sort : boolean;
begin
  nb:=Tablo_Action[action].NbOperations;
  i:=1;
  repeat
    action_operation(action,i);
    // si on a une tempo et que c'est pas la derni�re action, la main  est pass�e au timer pour toutes les actions suivantes, donc on sort de la boucle
    sort:=(Tablo_Action[action].TabloOp[i].numoperation=ActionTempo) and (i<nb) ;
    inc(i);
  until (i>nb) or sort;
end;

// traite l'�v�nement vitesse train - appel� depuis r�ception trame CDM ou vitesse_loco
// stocke la vitesse dans trains[].vitesseCons
procedure Event_vitesse(adr: integer ;train : string;vitesse : integer);
var i,idt,ac : integer;
begin
  //Affiche('Event vitesse',clYellow);
  idt:=index_train_adresse(adr);

  // chercher dans les actions un d�clencheur "d�marre train" (icone pente verte)
  for i:=1 to MaxTablo_act do
  begin
    if (Tablo_Action[i].declencheur=DeclDemarTrain) then
    begin
      if (Tablo_Action[i].trainDecl=train) then // train concern� dans l'action doit �tre = � train
      begin
        //Affiche('Vitesse='+intToSTR(vitesse),clyellow);
        //if (vitesse>Tablo_Action[i].adresse) // la vitesse est dans adresse
        if (trains[idt].AncVitesseCons=0) and (vitesse<>0) then
        begin
          if not(Tablo_Action[i].traite) and teste_condition(i) then // si d�ja trait� ne pas retraiter
          begin
//            Affiche('YY test condition',clred);
            Tablo_Action[i].traite:=true;
            action(i); // ex�cute toutes les op�rations de l'actionneur i
          end
        end
        else Tablo_Action[i].traite:=false;
      end;
    end;

    if (Tablo_Action[i].declencheur=DeclArretTrain) then
    begin
      if (Tablo_Action[i].trainDecl=train) then
      begin
        //if (vitesse<Tablo_Action[i].adresse) then
        if (trains[idt].AncVitesseCons<>0) and (vitesse=0) then
        begin
          if not(Tablo_Action[i].traite) and teste_condition(i) then
          begin
            Tablo_Action[i].traite:=true;
            if not(Diffusion) then Affiche('CCC EventVitesse action',clred);
            action(i); // ex�cute toutes les op�rations de l'actionneur i
          end
        end
        else Tablo_Action[i].traite:=false;
      end;
    end;
  end;

  // met � jour la vitesse du train dans trains[] et affichage de la vitesse
  if idt>0 then
  begin
    ac:=trains[idt].AncVitesseCons;
    if vitesse<>ac then
    begin
      trains[idt].AncVitesseCons:=trains[idt].vitesseCons;
      trains[idt].vitesseCons:=vitesse;
      LabelVitesse[idt].Caption:='V='+intToSTR(vitesse);
    end;
  end;
end;


// traitement des �v�nements actions (d�tecteurs et m�moire de zone aussi)
// autres que horaire et p�rip�riques
// adr adr2 : pour m�moire de zone
// trainDecl : compos� de X, d'un train ou de plusieurs, s�par�s par +
procedure Event_act(adr,adr2,etat : integer;trainDecl : string);
var typ,i,v,etatAct,Af,Ao,dZ1F,dZ2F,dZ1O,dZ2O : integer;
    s,sDecl : string;
    Typdet,Typact,rf,fm,fd,adresseOk,etatvalide,condValide : boolean;
    Ts : TAccessoire;
begin
  if adr<=0 then exit;
  if adr>1024 then
  begin
    Affiche('Erreur 281 : re�u adresse accessoire trop grande : '+intToSTR(adr),clred);
    exit;
  end;

  // Etat accessoire (un �tat aiguillage peut prendre les valeurs de 1 � 2)
  // ancien  nouveau
  //    0      1     FM
  //    0      2     FM
  //    1      2     FM
  //    2      1     FM
  //---------------------
  //    1      0     FD
  //    2      0     FD

  TypDet:=detecteur[adr].index<>0;
  if not typDet then TypAct:=true; // TypAct:=index_actionneur(adr)<>0;

  // normalement il faut diff�rencier les actionneurs des d�tecteurs
  // les actionneurs sont stock�s par index
  if (adr2=0) then
  begin
    fd:=(Ancien_actionneur[adr]>0)  and (etat=0);         // front descendant (FD)
    fm:=(Ancien_actionneur[adr]<>etat) and (etat<>0);     // front montant (FM)

    ancien_actionneur[adr]:=etat;
    if not(fd) and not(fm) then exit;

    detecteur[adr].Etat:=etat=1;
    detecteur[adr].Train:=TrainDecl;
  end;


  i:=index_actionneur(adr);
  actionneur[i].etat:=etat=1;
  actionneur[i].train:=trainDecl;

  if AffAigDet and (adr2=0) then AfficheDebug('Tick='+IntToSTR(tick)+' Evt Act='+intToSTR(Adr)+'='+intToSTR(etat)+' Train='+trainDecl,clyellow);
  //Affiche('Tick='+IntToSTR(tick)+' Evt Act='+intToSTR(Adr)+'='+intToSTR(etat)+'/'+intToSTR(Adr2)+' Train='+trainDecl,clyellow);
  //if fm then affiche('Front montant',clred);
  //if fd then affiche('Front desc',clLime);

  // v�rifier si l'actionneur en �v�nement a �t� d�clar� pour r�agir
  // dans tableau des actions
       
  i:=1;
  repeat
    sDecl:=Tablo_Action[i].trainDecl;
    etatAct:=Tablo_Action[i].etat ;  // �tat � r�agir
    etatValide:=((etatAct=etat) and fm) or ((etatAct=0) and fd);      // front montant ou descendant
    typ:=Tablo_Action[i].declencheur;

    // fonction. Attention l'�valuation de la fonction est prise sur sur front montant.
    // Or � chaque evt d�tecteur actionneur , elle est r��valu�e.
    if (typ=DeclFonction) and (Adr2=0) then
    begin
      condvalide:=teste_condition(i);
      if condValide then
      begin
        //Affiche('Eval 10 action '+intToSTR(i),clwhite);
        rf:=evalue_fonction(tablo_action[i].adresse,s);
        if rf and not(fonction[tablo_action[i].adresse,0].etatprec) then
        begin
          if not(Diffusion) then Affiche('AAA EventAct '+intToSTR(i)+' fonction adr='+intToSTR(adr)+' �tat'+' '+intToSTR(etat),clred);
          action(i); // ex�cute toutes les op�rations de l'actionneur i
        end;
      end;
    end;

    // si d�clencheur par adresse
    adresseok:=( ((Tablo_Action[i].adresse=adr) and (adr2=0) ) and ((typ=declDetAct) or (typ=DeclAccessoire)) ) or
               ( ((Tablo_Action[i].adresse=adr) and (Tablo_Action[i].adresse2=adr2)  and ((typ=DeclZoneDet) )));

    adresseok:=adresseok and
               (
                 // par train
                 ((typ=DeclDetAct) or (typ=DeclZoneDet)) and  test_train_decl(sDecl,trainDecl) or (sDecl='X') or (trainDecl='X') or (trainDecl='')
               ) ;

    condvalide:=teste_condition(i);

    if adresseok and condValide and etatValide then
    begin
      //Affiche('Action dans EventAct',clred);
      if not(Diffusion) then Affiche('BBB Action '+intToSTR(i),clred);
      action(i); // ex�cute toutes les op�rations de l'actionneur i
    end;
    inc(i);
  until (i>maxTablo_act);

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
              typ:=Tablo_PN[i].AdresseFerme;  // num�ro accessoire
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
              typ:=Tablo_PN[i].AdresseFerme;  // num�ro accessoire
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
      // PN par zone de d�tection
      // Affiche(intToSTR(adr)+'/'+intToSTR(adr2)+' '+intToSTR(etat),clyellow);
      if Tablo_PN[i].nbvoies>5 then Tablo_PN[i].nbvoies:=5;
      for v:=1 to Tablo_PN[i].nbvoies do
      begin
        dZ1F:=Tablo_PN[i].voie[v].detZ1F;
        dZ2F:=Tablo_PN[i].voie[v].detZ2F;
        dZ1O:=Tablo_PN[i].voie[v].detZ1O;
        dZ2O:=Tablo_PN[i].voie[v].detZ2O;
        if debugPN then Affiche('Test ouvre sur evt'+intToSTR(Adr)+' '+intToSTR(adr2)+' '+intToSTR(etat),clwhite);
        if (dZ1O=adr) and (dZ2O=adr2) and (etat=0) then  // zone d'ouverture
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
              typ:=Tablo_PN[i].AdresseFerme;  // num�ro accessoire
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

        if debugPN then Affiche('Test ferme '+intToSTR(Adr)+' '+intToSTR(adr2)+' '+intToSTR(etat),clwhite);
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
              typ:=Tablo_PN[i].AdresseFerme;  // num�ro accessoire
              typ:=com_socket(typ);
              if typ=1 then ferme_pn_usb(i);
              if typ=2 then ferme_pn_socket(i);
            end;
          end;
        end;
      end;
    end;
  end;

  // envoyer au p�riph�rique le service actionneur
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

// t�l�commande de signaux complexes par les clients ou les p�riph�riques
function telecommande(s : string) : boolean;
var adresse,i,erreur : integer;
    sa : string;
begin
  result:=false;
  sa:=s;
  s:=uppercase(s);
  // --- commandes sans param�tres
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

  // --- commandes avec param�tres
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

  for i:=1 to maxTablo_act do
  begin
    if Tablo_Action[i].declencheur=DeclPeriph then
     begin
      if Tablo_Action[i].ordrePeriph=sa then
      action(i);
    end;
  end;

  //FormPrinc.AffEtatDetecteurs(formprinc);
end;


Procedure affiche_memoire;
var s: string;
begin
  s:='M�m evt: '+IntToSTR(100*N_Event_tick div Max_Event_det_tick)+' %';
  FormPrinc.StatusBar1.Panels[3].Style:=psText; // sans event
  FormPrinc.StatusBar1.Panels[2].text:=s;
end;

procedure evalue;
begin
  if nivDebug=1 then AfficheDebug('Proc evalue',clorange);
  if not(configNulle) then Maj_Signaux(false);  // on ne traite pas les calculs si CDM en envoie plusieurs
end;

// calcule la distance incr�mentale en mm d'un train qui avance en fonction du temps en 1/10 et de la vitesse en cran du train d'index i
// est appel� par le timer
function distance_temps_incr(temps,i : integer) : integer;
var adrDet,vitesse,vitesseAbs : integer;
    vitR,coeff,incr,d : single;
begin
  if i<1 then begin result:=0;exit;end;
  with trains[i] do
  begin
    vitesse:=VitesseReelle;
    vitesseAbs:=abs(Vitesse);
    if vitesse=0 then
    begin
      AdrDet:=detecteurA;
      result:=round(detecteur[AdrDet].DistIncr);
      exit;
    end;

    coeff:=0;
    if vitesseAbs<consV2 then coeff:=pente1*vitesseAbs+b1
      else coeff:=pente2*vitesseAbs+b2;

    //if coeff<>0 then result:=round((vitesse*temps/10)/coeff)  en cm
    //temps:=temps-round(180*coeff/vitesse);    // il ne faut pas enlever la distance de la loco, car on mesure en incr�metal
    if (coeff<>0) and (coeff<9999) then
    begin
      incr:=(vitesseAbs*temps)/coeff;  // en mm
      adrDet:=detecteurA;
      d:=detecteur[AdrDet].DistIncr;
      if d=0 then d:=6*incr;        // valeur initiale, pour l'intertie de mesure due a la vitesse
      detecteur[adrDet].DistIncr:=d+incr;
    //  if debugRoulage then affiche('VitR='+intToSTR(vitesse)+' Incr='+intToSTR(round(incr))+' Dist='+intToSTR(round(detecteur[adrDet].DistIncr)),clYellow);
      result:=round(detecteur[adrDet].distIncr);
    end
    else result:=round(temps*9/vitesseAbs); // si non �talonn�, formule empirique
  end;

  if coeff<>0 then vitR:=vitesseAbs/coeff;
 // Affiche('Vitesse r�elle='+intTostr(round(vitR))+' cm/s  Temps='+intToSTR(temps),clYellow);
end;

// traitement des �v�nements d�tecteurs
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
var dr,i,AdrSuiv,AdrSignal,AdrDetSignal,index,Etat01,AdrPrec,d1,d2,AdrTrain : integer;
    TypeSuiv : tequipement;
    s : string;
begin
  //Affiche('Event Det '+inTToSTR(adresse)+' '+IntToSTR(etat01)+' '+train,ClCyan);
  if adresse>NbMaxDet then
  begin
    Affiche('Erreur 82 : re�u adresse de d�tecteur trop grande : '+intToSTR(adresse),clred);
    exit;
  end;

  // si d�tecteur inexistant. Peut �tre renvoy� par la centrale dans un groupe de 4 d�tecteurs
  if index_adresse_detecteur(Adresse)=0 then exit;
  Stop_Maj_Sig:=Maj_signaux_cours;  // si une maj de signaux est en cours, l'annuler

  // v�rifier si front descendant pour filtrage
  if (filtrageDet0<>0) and not(CDM_connecte) and (i_simule=0) then
  begin
    dr:=detecteur[adresse].tempo0;
    if (detecteur[Adresse].etat and not(etat)) and (dr=0) then
    begin
      // init de la tempo
      detecteur[adresse].tempo0:=filtrageDet0;
      exit;
    end;
    // si tempo �chue (99)
    if dr=99 then detecteur[adresse].tempo0:=0;

    // si d�tecteur passe � 1 et qu'un filtrage � 0 est en cours, annuler le 0
    if etat and (dr<>0) then
    begin
      Affiche_Evt('D�tecteur '+intToSTR(adresse)+' � 0 annul� par le filtrage',clorange);
      detecteur[adresse].tempo0:=0;
    end;
  end;

  //s:=detecteur[adresse].train;
  //if (train='') and (s<>'') then train:=s;
  if Etat then Etat01:=1 else Etat01:=0;

  if traceliste or (debugRoulage and roulage) then Affiche('Event Det '+inTToSTR(adresse)+' '+IntToSTR(etat01),ClCyan);
  // v�rifier si l'�tat du d�tecteur est d�ja stock�, car on peut re�evoir plusieurs �v�nements pour le m�me d�tecteur dans le m�me �tat
  // on re�oit un doublon dans deux index cons�cutifs.
 (*
  if N_Event_tick>=1 then
  begin
    if (event_det_tick[N_event_tick].etat=etat01) and (event_det_tick[N_event_tick].detecteur=Adresse) then
    begin
      //Affiche(IntToSTR(Adresse)+' d�ja stock�',clorange);
      exit;   // d�ja stock�
    end;
  end;
  *)
  if Traceliste or ProcPrinc then AfficheDebug('--------------- d�tecteur '+intToSTR(Adresse)+' � '+intToSTR(etat01)+' par train'+Detecteur[adresse].Train+' -----------------------',clOrange);
  if AffAigDet then
  begin
    //s:='Evt Det '+intToSTR(adresse)+'='+intToSTR(etat01);
    s:='Tick='+IntToSTR(tick)+' Evt Det='+IntToSTR(adresse)+'='+intToSTR(etat01)+' Train='+train;
    if not etat then s:=s+' t='+IntToSTR(detecteur[adresse].ComptCour);
    AfficheDebug(s,clyellow);
  end;
  if AFfDetSig then AfficheDebug('Tick='+IntToSTR(tick)+' Evt Det='+IntToSTR(adresse)+'='+intToSTR(etat01),clOrange);

  ancien_detecteur[Adresse]:=detecteur[Adresse].etat;
  detecteur[Adresse].etat:=etat;

  // affecter le train s'il est non nul
  if (train<>'_NONE') and (train<>'') then
  begin
    detecteur[Adresse].train:=train;
    detecteur[Adresse].AdrTrain:=index_train_nom(train);
  end;
  detecteur_chgt:=Adresse;


  // stocke les changements d'�tat des d�tecteurs dans le tableau chronologique
  if (N_Event_tick>=Max_Event_det_tick) then
  begin
    N_Event_tick:=0;
    Affiche('Raz Evts d�tecteurs',clLime);
  end;

  inc(N_Event_tick);
  event_det_tick[N_event_tick].tick:=tick;
  event_det_tick[N_event_tick].adresse:=Adresse;
  event_det_tick[N_event_tick].modele:=det;
  event_det_tick[N_event_tick].etat:=etat01;
  if (n_Event_tick mod 10)=0 then affiche_memoire;

  // v�rifier si le d�tecteur est attach� � un canton, pour voir si une loco y est affect�e
  // et affecter l'�l�ment suivant et pr�c�dent, et dernierDet au train
  i:=1;
  repeat
    d1:=canton[i].el1;t1:=canton[i].typ1;
    d2:=canton[i].el2;t2:=canton[i].typ2;
    if ((d1=adresse) and (t1=det)) or ((d2=adresse) and (t2=det)) then
    begin
      AdrTrain:=canton[i].adresseTrain;
      if AdrTrain<>0 then
      begin
        Maj_detecteurs_canton(i,AdrTrain,Adresse);
      end;
    end;
    inc(i);
  until (i>Ncantons);

  // Affiche('stockage de '+intToSTR(N_event_tick)+' '+IntToSTR(Adresse)+' � '+intToSTR(etat01),clyellow);

  // compter le nombre de d�tecteurs � 1 simultan�ment
  NbDet1:=0;
  for i:=1 to NDetecteurs do
  begin
    dr:=Adresse_detecteur[i];
    if Detecteur[dr].etat then inc(NbDet1);
  end;

  // d�tection front montant
  if not(ancien_detecteur[Adresse]) and (detecteur[Adresse].etat) then
  begin
    if AffFD then AfficheDebug('Tick='+intToSTR(tick)+' Index='+intToSTR(N_event_tick)+' FM '+intToSTR(Adresse),clyellow);
    inc(N_event_det);
    if algo_localisation=1 then event_det[N_event_det].adresse:=Adresse;
    event_det[N_event_det].etat:=true;
    with detecteur[adresse] do
    begin
      distCour:=0;
      ComptCour:=0;
    end;
    detecteur[Adresse].distIncr:=0;

    if not(confignulle) then
    //explore les signaux pour voir si on d�marre d'un buttoir
    for i:=1 to NbreSignaux do
    begin
      AdrSignal:=Signaux[i].Adresse;
      AdrDetSignal:=Signaux[i].Adr_Det1;
      if (AdrDetSignal=Adresse) and not(isDirectionnel(i)) then
      begin
        AdrSuiv:=Signaux[i].Adr_el_suiv1;
        TypeSuiv:=Signaux[i].Btype_suiv1;
        if AffSignal then AfficheDebug('Pour signal '+intToSTR(AdrSignal)+' detecteursuivant('+intToSTR(AdrSuiv)+','+BTypeToChaine(typeSuiv)+','+intToSTR(AdrDetSignal)+',1)',clyellow);
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetSignal,det,1) ; // d�tecteur pr�c�dent le feu, algo 1
        if AdrPrec=0 then
        begin
          If traceListe then AfficheDebug('Le signal '+IntToSTR(AdrSignal)+' est pr�c�d� d''un buttoir',clyellow);
          MemZone[0,AdrDetSignal].etat:=true;
          event_act(0,AdrDetSignal,1,'');             // activation zone
          Maj_Signal_P(AdrSignal,false);
        end;
      end;
    end;

    if etat then i:=1 else i:=0;
    if not(confignulle) then calcul_zones(adresse,true);   // *** calcul zones

    // g�rer l'�v�nement actionneur pour action
    event_act(Adresse,0,i,'');
  end;

  // d�tection fronts descendants

  if ancien_detecteur[Adresse] and not(detecteur[Adresse].etat) and (N_Event_det<Max_event_det) then
  begin
    // si le FD du d�tecteur a d�j� �t� stock� � l'index pr�c�dent ne pas en tenir compte
    //if event_det[N_event_det]<>Adresse then
    begin
      if AffFD then AfficheDebug('Tick='+intToSTR(tick)+' Index='+intToSTR(N_event_tick)+' FD '+intToSTR(Adresse),clyellow);
      inc(N_event_det);
      if algo_localisation=1 then event_det[N_event_det].adresse:=Adresse;
      event_det[N_event_det].etat:=false;

      // v�rification de la connaissance de la position de tous les aiguillages au premier �v�nement FD d�tecteur
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

     // idTrain:=index_train_adresse(detecteur[adresse].AdrTrain);
     // if idTrain<>0 then trains[idTrain].detecteurA:=adresse;

      if etat then i:=1 else i:=0;
      if not(confignulle) then calcul_zones(adresse,false);  // *** calcul zones

      // g�rer l'�v�nement detecteur pour action
      event_act(Adresse,0,i,train);
    end;
  end;

  if (N_event_det>=Max_event_det) then
  begin
    Affiche('D�bordement d''�v�nements FD - Raz tampon',clred);
    N_event_det:=0;
    FormDebug.MemoEvtDet.lines.add('Raz sur d�bordement');
  end;


  // Envoyer �vent vers p�riph�riques si le service est demand�
  for i:=1 to NbPeriph do
  begin
    dr:=com_socket(i);
    // envoyer event act au p�riph�rique
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

  // Maj des d�tecteurs des TCOs
  for i:=1 to nbreTCO do
  begin
    if PCanvasTCO[i]<>nil then Maj_TCO(i,Adresse);
  end;

end;

// note: si on pilote un aiguillage par signaux complexes vers CDM et que celui ci est invers�,
// on recoit un evt de CDM de l'aiguillage dans le mauvais sens.
// par contre si on pilote cet aiguillage dans CDM, on le recoit dans le bon sens.
// �v�nement d'aiguillage (accessoire)
// pos = const_droit=2 ou const_devie=1
procedure Event_Aig(adresse,pos : integer);
var s: string;
    faire_event,inv,bjd,rf : boolean;
    prov,index,i,id,etatact,typ,adr : integer;
begin
  if AffAigDet then Affiche('Tick='+IntToSTR(tick)+' Event Aig '+intToSTR(adresse)+'='+intToSTR(pos),clorange);
  index:=index_aig(adresse);
  if index<>0 then
  begin
    // si l'aiguillage est invers� dans CDM et qu'on est en mode autonome ou CDM, inverser sa position
    inv:=false;
    if (aiguillage[index].inversionCDM=1) and (portCommOuvert or parSocketLenz) then
    begin
      prov:=pos;
      inv:=true;
      if prov=const_droit then pos:=const_devie else pos:=const_droit;
    end;

    // ne pas faire l'�valuation si l'ancien �tat de l'aiguillage est ind�termin�e (9)
    // car le RUN vient de d�marrer
    faire_event:=aiguillage[index].position<>9;
    aiguillage[index].position:=pos;    // stockage de la nouvelle position de l'aiguillage

    // ------------- stockage �v�nement aiguillage dans tampon event_det_tick -------------------------
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
        const_devie : s:=s+' d�vi�';
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

    // l'�valuation des routes est � faire selon conditions
    if faire_event and not(confignulle) then
    begin
      evalue;evalue;evalue;
    end;
  end

  else
    if AffAigND then affiche('Avertissement 47 : un evt accessoire '+intToSTR(adresse)+' non d�clar� a �t� re�u',clOrange);

  // evt actionneur d'aiguillage
  for i:=1 to maxTablo_act do
  begin
    etatAct:=Tablo_Action[i].etat ;
    adr:=Tablo_Action[i].adresse;
    typ:=Tablo_Action[i].declencheur;
    rf:=false;

    if ((typ=DeclAccessoire) and (Adr=adresse)) or (typ=declFonction) then event_act(Adresse,0,pos,''); // �vent aig
  end;

  // pour services aux p�riph�riques
  for i:=1 to NbPeriph do
  begin
    if Tablo_periph[i].ScvAig then
    begin
      // envoyer event act � accessoire
      typ:=com_socket(i);
      if typ=1 then
      begin
        s:='T'+intToSTR(adresse)+','+intToSTR(pos);
        if Tablo_periph[i].ScvVis then Affiche(s,clWhite);
        if Tablo_periph[i].cr then s:=s+#13;
        id:=Tablo_periph[i].NumComposant;
        if id=1 then envoi_usb_comp(MSCommCde1,s);
        if id=2 then envoi_usb_comp(MSCommCde2,s);
      end;
      if typ=2 then
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

  // Mettre � jour les TCOs contenant l'adresse
  id:=Index_Aig(adresse);
  if id<>0 then
  for i:=1 to NbreTCO do
  begin
    // v�rifier si TJD � 2 adresses pour changer sa position dans le TCO
    if (aiguillage[id].modele=TJD) or (aiguillage[id].modele=TJS) then
    begin
      if aiguillage[id].EtatTJD=4 then
      begin
        adr:=aiguillage[id].Ddevie; // homologue
        Maj_TCO(i,adr);
      end;
    end;
    Maj_TCO(i,Adresse);
  end;
end;

// pilote une sortie � 0 � l'interface dont l'adresse est � 1 ou 2 (octet)
procedure Pilote_acc0_X(adresse : integer;octet : byte);
var groupe : integer ;
    fonction : byte;
    s : string;
begin
  if (portCommOuvert or parSocketLenz) then
  begin
    if debug_dec_sig then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet)+' � 0',clorange);
    if protocole=1 then
    begin
      groupe:=(adresse-1) div 4;
      fonction:=((adresse-1) mod 4)*2 + (octet-1);
      s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
      s:=checksum(s);
      if avecAck then envoi(s) else envoi_ss_ack(s);  
    end;
    if protocole=2 then
    begin
      //la RAZ d'une sortie n'existe pas en DCC+!
    end;
  end;
  if cdm_connecte then
  begin
    // remise � 0
    s:=chaine_CDM_Acc(adresse,0);
    envoi_CDM(s);
  end;
end;

// envoi d'une cha�ne Com_IPC � CDM par socket, puis attend l'ack ou le nack
function envoi_CDM(s : string) : boolean;
var temps : integer;
begin
  if CDM_connecte=false then begin envoi_CDM:=false;exit;end;
  if traceTrames then afficheDebug(s,clLime);
  Formprinc.ClientSocketCDM.Socket.SendText(s);
  // attend l'ack
  if avecAckCDM then
  begin
    ackCDM:=false;nackCDM:=false;
    temps:=0;
    repeat
      inc(temps);
      Sleep(50);
      Application.processMessages;
    until fermeSC or ackCDM or nackCDM or (temps>20); // CDM r�pond < 1s
    //Affiche(intToSTR(temps),clred);
    if not(ackCDM) or nack then
    begin
      Affiche('Pas de r�ponse de CDM Rail',clRed);
    end;
  end;
  envoi_CDM:=ackCDM;
end;


// pilote accessoire sous condition, version taches par le timer
function pilote_acc_sc_taches(adresse : integer;octet : byte;Acc : TAccessoire;adrTrain : integer) : boolean;
var  groupe,temp,indexAig,AdrTrainLoc : integer ;
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
  indexAig:=index_aig(adresse);
  // test si pilotage aiguillage invers�
  if (acc=aigP) then
  begin
    if indexAig<>0 then
    begin
      AdrTrainLoc:=aiguillage[indexAig].AdrTrain;
      if (AdrTrainLoc<>0) and (AdrTrain<>0) and (AdrTrainLoc<>AdrTrain) then
      begin
        Affiche('Pilotage impossible, l''aiguillage '+intToSTR(adresse)+' est r�serv� par le train @'+intToSTR(AdrTrainLoc),clred);
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
    if aff_acc then Affiche('Accessoire '+intToSTR(adresse)+' � '+intToSTR(pilotage),clorange);
    if pilotage=1 then pilotageCDM:=1;     // 3 = wrong state or value
    if pilotage=2 then pilotageCDM:=2;

    s:=chaine_CDM_Acc(adresse,pilotageCDM);
    // pilotage actif de l'accessoire----------------
    tache(ttacheAcc,0,ttDestCDM,s);  // TypeTache,tempo,destinataire,chaine

    // si l'accessoire est un signal et sans raz des signaux, sortir
    if (acc=signal) and not(Raz_Acc_signaux) then exit;
    if Acc=AigP then
    begin
      temp:=aiguillage[indexAig].temps;if temp=0 then temp:=4; // mini pour pilotage en signaux LEB
    end;

    // remise � 0 --------------
    s:=chaine_CDM_Acc(adresse,0);

    tache(ttacheAcc,temp,ttDestCDM,s);  // TypeTache,tempo,destinataire,chaine
    // si l'accessoire est un aiguillage, temporiser suivant variable de s�quenceent
    if indexaig<>0 then tache(ttacheTempo,tempo_Aig div 100,0,'');

    result:=true;
  end;

  // if (pilotage=0) or (pilotage>2) then begin result:=true;exit;end;

  // pilotage par USB ou par �thernet de la centrale ------------
  if (portCommOuvert or parSocketLenz) and not CDM_connecte then
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
      // pilotage � 1
      s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
      s:=checksum(s);
      if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(pilotage),clorange);
      //if avecAck then envoi(s) else envoi_ss_ack(s);     // envoi de la trame avec/sans attente Ack

      tache(ttacheAcc,0,ttDestXpressNet,s);  // TypeTache,tempo,destinataire,chaine

      // si l'accessoire est un signal et sans raz des signaux, sortir
      if (acc=signal) and not(Raz_Acc_signaux) then exit;

      // si aiguillage, faire une temporisation
      if Acc=AigP then
      begin
        temp:=aiguillage[indexAig].temps;if temp=0 then temp:=4;
      end;

      // pilotage � 0 pour �teindre le pilotage de la bobine du relais
      s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
      s:=checksum(s);
      if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
      //if avecAck then envoi(s) else envoi_ss_ack(s);     // envoi de la trame avec ou sans Ack
      tache(ttacheAcc,temp,ttDestXpressNet,s);

      if indexAig<>0 then tache(ttacheTempo,tempo_Aig div 100,0,'');

      //affiche('5.'+intToSTR(tick),clyellow);
      result:=true;
      //exit;
    end;

    if protocole=2 then  // dcc++
    begin
      if acc<>signal then event_aig(adresse,pilotage);
      // en pilotage, on envoie que l'ID cad l'adresse - 0=droit 1=d�vi�
      if pilotage=const_devie then fonction:=1;
      if pilotage=const_droit then fonction:=0;
      //affiche_retour_DCC:=true;
      s:='<T '+intToSTR(adresse)+' '+intToSTR(fonction)+'>';
      //Affiche(s,clYellow);
      //envoi(s);

      tache(ttacheAcc,0,ttDestDccpp,s);  // TypeTache,tempo,destinataire,chaine

      result:=true;
    end;
  end;

  if indexAig<>0 then event_aig(adresse,octet)
  else
    // Serveur envoi au clients
    Envoi_serveur('T'+intToSTR(adresse)+','+intToSTR(octet));

  result:=true;

end;

// pilote aiguillage sous condition (accessoire) avec condition : l'aiguillage doit �tre r�serv� par AdrTrain (adrTrain<>0) ou sans condition (adrTrain=0)
// acc : AigP (aiguillage) ou signal
function pilote_acc_sc(adresse : integer;octet : byte;Acc : TAccessoire;adrTrain : integer) : boolean;
var  groupe,temp,indexAig,AdrTrainLoc : integer ;
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
  // test si pilotage aiguillage invers�
  if (acc=aigP) then
  begin
    indexAig:=index_aig(adresse);
    if indexAig<>0 then
    begin
      AdrTrainLoc:=aiguillage[indexAig].AdrTrain;
      if (AdrTrainLoc<>0) and (AdrTrain<>0) and (AdrTrainLoc<>AdrTrain) then
      begin
        Affiche('Pilotage impossible, l''aiguillage '+intToSTR(adresse)+' est r�serv� par le train @'+intToSTR(AdrTrainLoc),clred);
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
    if aff_acc then Affiche('Accessoire '+intToSTR(adresse)+' � '+intToSTR(pilotage),clorange);
    if pilotage=1 then pilotageCDM:=1;     // 3 = wrong state or value
    if pilotage=2 then pilotageCDM:=2;

    s:=chaine_CDM_Acc(adresse,pilotageCDM);
    envoi_CDM(s);

    if Acc<>Signal then event_aig(adresse,pilotage);

    // si l'accessoire est un signal et sans raz des signaux, sortir
    if (acc=signal) and not(Raz_Acc_signaux) then exit;
    if Acc=AigP then
    begin
      temp:=aiguillage[indexAig].temps;if temp=0 then temp:=4; // mini pour pilotage en signaux LEB
      if portCommOuvert or parSocketLenz then tempo2(temp);
    end;

    // remise � 0
    s:=chaine_CDM_Acc(adresse,0);
    envoi_CDM(s);

    result:=true;
    //exit;
  end;

  if (pilotage=0) or (pilotage>2) then begin result:=true;exit;end;

  // pilotage par USB ou par �thernet de la centrale ------------
  if (portCommOuvert or parSocketLenz) and not CDM_connecte then
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
      // pilotage � 1
      s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
      s:=checksum(s);
      if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(pilotage),clorange);
      if avecAck then envoi(s) else envoi_ss_ack(s);     // envoi de la trame avec/sans attente Ack
      if acc<>signal then event_aig(adresse,pilotage);

      // si l'accessoire est un signal et sans raz des signaux, sortir
      if (acc=signal) and not(Raz_Acc_signaux) then exit;

      // si aiguillage, faire une temporisation
      if Acc=AigP then
      begin
        temp:=aiguillage[indexAig].temps;if temp=0 then temp:=4;
        if portCommOuvert or parSocketLenz then tempo2(temp);
      end;

      // pilotage � 0 pour �teindre le pilotage de la bobine du relais
      s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
      s:=checksum(s);
      if debug_dec_sig and (acc=signal) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
      if avecAck then envoi(s) else envoi_ss_ack(s);     // envoi de la trame avec ou sans Ack
      //affiche('5.'+intToSTR(tick),clyellow);
      result:=true;
      //exit;
    end;

    if protocole=2 then  // dcc++
    begin
      if acc<>signal then event_aig(adresse,pilotage);
      // en pilotage, on envoie que l'ID cad l'adresse - 0=droit 1=d�vi�
      if pilotage=const_devie then fonction:=1;
      if pilotage=const_droit then fonction:=0;
      //affiche_retour_DCC:=true;
      s:='<T '+intToSTR(adresse)+' '+intToSTR(fonction)+'>';
      //Affiche(s,clYellow);
      envoi(s);
      result:=true;
      //exit;
    end;
  end;

  // pas de centrale et pas CDM connect�: on change la position de l'aiguillage
  if acc=aigP then event_aig(adresse,octet)
  else
  // Serveur envoi au clients
  Envoi_serveur('T'+intToSTR(adresse)+','+intToSTR(octet));

  result:=true;
end;

// pilotage d'un accessoire (d�codeur d'aiguillage, de signal) et g�n�re l'event aig
// par CDM ou interface
// octet = 1 (d�vi�) ou 2 (droit) si 0 on ne traite pas
// uniquement en mode autonome:
// si acc=Taig, alors la sortie "octet" est mise � 1 puis � 0
// si acc=signal,  alors la sortie "octet" est mise � 1 uniquement.
// R�sultat true si ok
function pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire): boolean; overload;
begin
  if ModeTache then pilote_acc_sc_taches(adresse,octet,Acc,9999) else
    pilote_acc_sc(adresse,octet,Acc,9999);
end;

// pilotage l'accessoire si l'accesoire est r�serv� par adrTrain ou non r�serv�
Function pilote_acc(adresse : integer;octet : byte;adrTrain : integer) : boolean; overload;
begin
  if ModeTache then pilote_acc_sc_taches(adresse,octet,aigP,AdrTrain) else
    pilote_acc_sc(adresse,octet,aigP,AdrTrain)
end;


// le d�codage de la r�tro XpressNet est appel� sur une r�ception d'une trame de la r�trosignalisation de la centrale.
// On d�clenche ensuite les �v�nements d�tecteurs ou aiguillages.
// valeur = ITTN ZZZZ
// var globale modeStkRetro=false = stockage sur changement d'�tat, et g�n�re �v�nement d�tecteur
//                          true  = stockage de l'�tat sans �v�nement
procedure decode_retro_XpressNet(adresse,valeur : integer);
var  s : string;
     adraig,bitsTT,i,n : integer;
     etat : boolean;
begin
  //afficheDebug(IntToSTR(adresse)+' '+intToSTR(valeur),clorange);
  bitsTT:=valeur and $60;  // 0110 0000
  n:=valeur and $10;
  // bit � 010X XXXX = c'est un module de r�trosignalisation (pas un aiguillage)
  // doc LENZ Xpressnet protocol description page 31
  detecteur_chgt:=0;

  // ---------- Cas N=1, les 4 bits de poids faible sont les 4 bits de poids fort du d�codeur
  if n=$10 then
  begin
    // d�termine le d�tecteur qui a chang� d'�tat
    // -------�tat du d�tecteur
    if bitsTT and $40=$40 then // TT=10 l'adresse est un module de r�tro = d�tecteur
    begin
      // affecter l'�tat des d�tecteurs
      i:=adresse*8+8;
      etat:=(valeur and $8) = $8;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 7
      begin
        Event_detecteur(i,etat,'');  // pas de train affect� sur le d�codage de la r�trosignalisation
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+7;
      etat:=(valeur and $4) = $4;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+6;
      etat:=(valeur and $2) = $2;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+5;
      etat:=(valeur and $1) = $1;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      retEtatDet:=true;
    end;

    // �tat de l'aiguillage
    if (bitsTT=$00) or (bitsTT=$20) then // TT=00 ou TT=01 l'adresse est un d�codeur d'accessoires sans(TT=00)/avec(TT=01) r�trosignalisation, avec N=1
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
      if ((valeur and $C)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig+3)+' ind�fini';AfficheDebug(s,clYellow);end;

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
      if ((valeur and $3)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig+2)+' ind�fini';AfficheDebug(s,clYellow);end;
    end;
  end;

  // ---------- Cas N=0
  if n=0 then // si bit N=0, les 4 bits de poids faible sont les 4 bits de poids faible du d�codeur
  begin
    //Affiche('N=0',clYellow);
    if (bitsTT and $40)=$40 then  // TT=10 l'adresse est un module de r�tro = d�tecteur avec N=0
    begin
      // affecter l'�tat des d�tecteurs
      i:=adresse*8+4;
      etat:=(valeur and $8) = $8;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+3;
      etat:=(valeur and $4) = $4;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+2;
      etat:=(valeur and $2) = $2;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;

      i:=adresse*8+1;
      etat:=(valeur and $1) = $1;
      if detecteur[i].etat<>etat then  // si changement de l'�tat du d�tecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,'');
      end;
      if modeStkRetro then detecteur[i].etat:=etat;
      retEtatDet:=true;  // marqueur "re�u �tat d�tecteur"
    end;

    if (bitsTT=$00) or (bitsTT=$20) then // TT=00 ou TT=01 l'adresse est un d�codeur d'accessoires sans(TT=00)/avec(TT=01) r�trosignalisation, avec N=0
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
      if ((valeur and $C)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig+1)+' ind�fini';AfficheDebug(s,clYellow);end;

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
      if ((valeur and $3)=0) and TraceTrames then begin s:='accessoire '+intToSTR(adraig)+' ind�fini';AfficheDebug(s,clYellow);end;
    end;
  end;
end;

// renvoi le nombre de param�tres dans une chaine DCC++ entre le premier < >
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

// d�codage chaine au protocole DCC (un seul param�tre encadr� par < > )
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

  // r�ponse �criture eprom
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

  // d�tecteur 1 (Q ID) ou r�ponse � un d�tecteur si 3 param�tres (Q ID PIN PULLUP)
  i:=pos('<Q',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i=erreur then // 1 seul param�tre
    begin
      if i<>0 then delete(chaineINT,1,i);
      result:=chaineINT;
      Event_detecteur(valeur+AdrBaseDetDccpp,true,'');  // pas de train affect�
      exit;
    end;
    // sinon 3 param�tres
    if i<>0 then delete(chaineINT,1,i);
    exit;
  end;

  // d�tecteur 0
  i:=pos('<q',chaineINT);
  if i<>0 then
  begin
    delete(chaineINT,1,i+2);
    val(chaineINT,valeur,erreur);
    i:=pos('>',chaineINT);
    if i<>0 then delete(chaineINT,1,i);
    result:=chaineINT;
    Event_detecteur(valeur+AdrBaseDetDccpp,false,'');  // pas de train affect�
    exit;
  end;

  // r�ponse � la demande de mise sous tension ou hors tension de la voie
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

  // r�ponse � la commande <Y nombre format>
  // y  d�tecteurs
  //  <y 00001010000101000111010000>     format 0
  //  <y 0A0147405801CE..40�             format 1 quartets renvers�s
  //  <y XXXXX......�       (hexa pur)   format 2
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

  // r�ponse � un aiguillage ou � leur d�finition
  i:=pos('<H',chaineINT);
  if i<>0 then
  begin
    // d�termine le nombre de param�tres
    delete(chaineINT,1,i+1);
    n:=nombre_parametres(chaineINT);
    if n=4 then // position d'un aiguillage, r�ponse � <T>
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
      else affiche('Erreur 70 : Aiguillage '+intToSTR(adresse)+' envoy� par la centrale non d�fini dans signaux_complexes',clred);
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

  // r�ponse � une demande de vitesse loco
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

  // r�ponse � la programmation d'un CV
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

  // r�ponse aux d�finitions des sorties
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

  if chaineINT<>'' then Affiche('Re�u commande inconnue :'+chaineINT,clred);
  result:='';
end;

// v�rifie le checksum de l'interface
function check(s : TchaineBIN;n : integer): boolean;
var x: byte;
    i,l : integer;
begin
  x:=0;
  i:=1;
  l:=Long_recue;
  if l>0 then
  begin
    repeat
      x:=x xor (s[i]);
      inc(i);
    until (i>l) or (i>n);
  end;
  result:=x=0;
end;

// supprime en d�calant une longueur � partir de l'offset
procedure Delete_tablo(var cb : TchaineBIN;offset,longueur : integer);
var i,j : integer;
begin
  if (Long_recue<offset) or (Long_recue<offset+longueur-1) then exit;
  for j:=offset+longueur-1 downto offset do
    for i:=j to long_recue do
    begin
      cb[i]:=cb[i+1];
    end;
    cb[long_recue+1]:=0;
  dec(Long_recue,longueur);
end;

// d�codage d'une chaine Xpressnet de la r�trosignalisation de la centrale
// la chaine peut �tre compos�e de plusieurs ordres, car on boucle, et �tre coup�e.
// en sortie, la chaine chaineINT est supprim�e de la partie trait�e
procedure decode_chaine_retro_Xpress;
var msg,s : string;
    n,i,it,cvLoc,AdrTrainLoc,l,NOctets : integer;
    traite,connu: boolean;
begin
  //affiche(chaine_hex(chaineINT),clOrange);
  msg:='';
  ack:=true;nack:=false;
  it:=0;

  if Long_recue>3 then
  repeat
    inc(it);
    //AfficheDebug('It='+IntToSTR(it),clLime);
    connu:=false;
    traite:=false;

    if Long_recue>4 then
    begin
      // supprimer l'entete �ventuelle FFFE ou FFFD
      if (chaine_recue[1]=$ff) and ((chaine_recue[2]=$fe) or (chaine_recue[2]=$fd)) then Delete_tablo(chaine_recue,1,2);
    end;

    l:=Long_recue;

    if (chaine_recue[1]=$01) then
    begin
      nOctets:=3;
      connu:=true;
      if (l>=nOctets) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          case chaine_recue[2] of   // page 13 doc XpressNet
            $01 :  begin nack:=true;msg:='Erreur timeout transmission - Voir doc XpressNet p13';end;
            $02 :  begin nack:=true;msg:='Erreur timout centrale - Voir doc XpressNet p13';end;
            $03 :  begin nack:=true;msg:='Erreur communication inconnue - Voir doc XpressNet p13';end;
            $04 :  begin succes:=true;msg:='Succ�s';end;
            $05 :  begin nack:=true;msg:='Plus de time slot - Voir doc XpressNet p13';end;
            $06 :  begin nack:=true;msg:='D�bordement tampon LI100 - Voir doc XpressNet p13';end;
          end;
          if traceTrames and (chaine_recue[2]=4) then AfficheDebug(msg,clYellow);
          if traceTrames and (chaine_recue[2]<>4) then AfficheDebug(msg,clRed);
          if (chaine_recue[2]<>$4) then Affiche(msg,clRed);
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_01: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else

    if (chaine_recue[1]=$02) then
    begin
      connu:=true;
      nOctets:=4;
      if (l>=nOctets) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          msg:='Version mat�rielle '+intTohex(chaine_recue[2],2)+' - Version soft '+intToHex(chaine_recue[3],2);
          Affiche(msg,clYellow);
          version_Interface:=intToSTR(chaine_recue[2]);
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_02: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else

    // accessory decodeur information response $40+N 40 N=1 � 14  ex: 42 41 40 43  ou 44 xx xx yy yy
    if (ord(chaine_recue[1]) and $F0)=$40 then
    begin
      connu:=true;
      n:=chaine_recue[1] and $0F;  // nombre d'octets (doit �tre pair)
      nOctets:=n+2;             // nombre d'octets du message (+check + le premier)

      if (l>=nOctets) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          n:= n div 2;
          for i:=1 to n do
          begin
            decode_retro_XpressNet(chaine_recue[i*2],chaine_recue[i*2+1]);  // traitement long
          end;
          traite:=true;
        end
        else
        begin
          s:='ErrCheck_4X: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets';
          AfficheDebug(s,clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else

    // recu 61 01 60
    if (chaine_recue[1]=$61)  then
    begin
      nOctets:=3;
      connu:=true;
      if l>=nOctets then
      begin
        if check(chaine_recue,nOctets) then
        begin
          case chaine_recue[2] of
            $00 : begin ack:=true;msg:='Voie hors tension';end;
            $01 : begin ack:=true;msg:='Reprise';Hors_tension:=false;end;
            $02 : begin ack:=true;msg:='Mode programmation ';end;

            $11 : begin nack:=true;msg:='Voie prog Station pr�te';end;
            $12 : begin ack:=true;msg:='Voie prog court-circuit';Hors_tension:=false;end;
            $13 : begin ack:=true;msg:='Voie prog octet non trouv�';end;
            $1F : begin nack:=true;msg:='Voie prog Station occup�e - Voir doc XpressNet p29';end;

            $80 : begin nack:=true;msg:='Erreurs de transferts (Chk erron�) - Voir doc XpressNet p29';end;
            $81 : begin nack:=true;msg:='Station occup�e - Voir doc XpressNet p29';end;
            $82 : begin nack:=true;msg:='Commande non implant�e';end;

            else begin nack:=true;msg:='R�ception inconnue';end;
          end;
          if nack then
          begin
            afficheDebug(msg,clred);
            Affiche(msg,clred);
          end
          else
          begin
            afficheDebug(msg,clyellow);
            affiche(msg,clyellow);
          end;
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_61: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else

    if (chaine_recue[1]=$63) then    // V3.6 uniquement
    begin
      connu:=true;
      nOctets:=5;
      if (l>=nOctets) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          if chaine_recue[2]=$14 then
          begin
            // r�ception d'un CV. DocXpressNet p26   63 14 01 03 chk
            cvLoc:=(chaine_recue[3]);
            //Affiche('R�ception CV'+IntToSTR(cvLoc)+' � '+IntToSTR(ord(chaine_recue[2])),clyellow);
            if cvLoc>255 then Affiche('Erreur Recu CV>255',clRed)
            else
            begin
              tablo_cv[cvLoc]:=(chaine_recue[4]);
              inc(N_Cv); // nombre de CV recus
            end;
            recu_cv:=true;
            traite:=true;
          end;
          if chaine_recue[2]=$10 then
          begin
            traite:=true;
          end;
          if chaine_recue[2]=$21 then
          begin
            traite:=true;
          end;
        end
        else
        begin
          AfficheDebug('ErrCheck_63: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else
    // 81 00 mise hors tension
    if (chaine_recue[1]=$81) then    // arr�t urgence  3 octets
    begin
      connu:=true;
      nOctets:=3;
      if (l>=3) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          Affiche('Voie hors tension msg1',clRed);
          Hors_tension:=true;
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_81: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
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

    if (chaine_recue[1]=$E1) then
    begin
      NOctets:=3;
      connu:=true;
      if (l>=NOctets) then
      begin
        if check(chaine_recue,NOctets) then
        begin
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_E1: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,NOctets);
      end;
    end
    else

    // E2  4

    // E3
    if (chaine_recue[1]=$E3) then
    begin
      connu:=true;
      nOctets:=5;
      if (l>=nOctets) then
      begin
        // la loco ah al est pilot�e par le PC
        if check(chaine_recue,nOctets) then
        begin
          if chaine_recue[1]=$40 then
          begin
          end;
          if chaine_recue[2]=$50 then
          begin
          end;
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_E3: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else

    // E4 id speed FcA FcB xor    loco information
    if (chaine_recue[1]=$E4) then
    begin
      connu:=true;
      nOctets:=6;
      if (l>=nOctets) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          AdrTrainLoc:=(chaine_recue[2]); // identification
          i:=(chaine_recue[3]);  // vitesse
          Fa:=(chaine_recue[4]); // fonction A en var globale
          Fb:=(chaine_recue[5]); // fonction B en var globale
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_E4: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end
    else

    // E5  7
    // E6  8

    // sp�cifique Z21 : E7 0C 89 00 00 00 00 00 62
    //                  E7 0C 8F 00 00 00 00 00 64
    // on en fait rien, c'est un genre d'ack � la r�ponse de stop loco ?
    if (chaine_recue[1]=$E7) then
    begin
      connu:=true;
      nOctets:=9;
      if (l>=nOctets) then
      begin
        if check(chaine_recue,nOctets) then
        begin
          traite:=true;
        end
        else
        begin
          AfficheDebug('ErrCheck_E7: '+copy(tablo_hex(chaine_recue),1,noctets*3)+' : '+intToSTR(nOctets)+' octets',clred);
        end;
        delete_tablo(chaine_recue,1,nOctets);
      end;
    end;

    // suppression du caract�re inconnu car il n'a pas �t� trait�
    if not(connu) then
    begin
      if traceTrames then AfficheDebug('Suppression '+intToHex(chaine_recue[1],2),clred);
      delete_tablo(chaine_recue,1,1);
      traite:=true;
    end;

  until ((Long_recue<3) or not(traite) or (it>=100)); // conditions de sortie du repeat until

  if it>=100 then
  begin
    s:='';
    for i:=1 to long_recue do s:=s+intToHex(chaine_recue[i],2)+' ';
    s:='Erreur 623 : it�rations trames XpressNet n='+intToSTR(long_recue)+' '+s;
    Affiche(s,clred);
    AfficheDebug(s,clred);
    Long_recue:=0;
  end;

  //decode_chaine_retro_Xpress:=chaineINT;
end;


function pos_tablo(b : byte;t : tchaineBIN) : integer;
var i : integer;
   trouve : boolean;
begin
  i:=0;
  repeat
    inc(i);
    trouve:=t[i]=b;
  until trouve or (i>=Long_recue);
  if trouve then result:=i else result:=0;
end;

// proc�dure appell�e apr�s r�ception sur le port USB ou socket
// la chaine peut contenir plusieurs informations
// on boucle tant qu'on a pas trait�e toute la chaine
procedure interprete_reponse;
var //chaineInt: TchaineBIN;
   s : string;
   i,j : integer;
   balise : boolean;
   c : char;
begin
  //chaineINT:=chaine;
  if protocole=1 then // xpressNet
  begin
    decode_chaine_retro_Xpress;
    //chaineINT:=decode_chaine_retro_Xpress(chaineINT);
  end;

  if protocole=2 then // Dccpp
  begin
    // transformer chaine en s ascii
    s:='';
    for i:=1 to Long_recue do
    begin
      c:=char(chaine_recue[i]);
      if c<>#0 then s:=s+c else Affiche('DCC caract�re #0 filtr�',clOrange);
    end;
    i:=pos('<',s);
    j:=pos('>',s);
    while (i<>0) and (j<>0) do
    begin
      balise:=true;
      s:=decode_chaine_retro_dcc(s);
      i:=pos('<',s);
      j:=pos('>',s);
    end;
    // if not(balise) then Affiche(s,clLime);
    // retransformer en tchaineBIN
    for i:=1 to length(s) do chaine_recue[i]:=ord(s[i]);
    long_recue:=length(s);
  end;

  //interprete_reponse:=chaineINT;
end;

function HexToStr(s: string) : string ;
// transforme une cha�ne ascii 0A FF CA.. en chaine d'octets d�cimaux ascii = 10 255 ...
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
    Affiche('CDM rail d�connect�',clCyan);
    AfficheDebug('CDM rail d�connect�',clCyan);
    Formprinc.StatusBar1.Panels[2].text:='';
  end;
end;

{$J+}
// v�rifie si version OS32 bits ou OS64 bits
function IsWow64Process: Boolean;
type
  TIsWow64Process=function(hProcess: THandle; var Wow64Process: Boolean): Boolean; stdcall;
var
  Dll: THandle;
  pIsWow64Process: TIsWow64Process;
const
  IsWow64: Boolean=False;
begin
  {$IFDEF WIN64}       // si d�j� compil� en 64 bits
  result:=true;
  exit;
  {$ENDIF}
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
  Affiche('Envoi la liste des aiguillages � la centrale DCC++',clyellow);
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

// d�termine si le p�riph�rique i est un comusb ou un socket
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
    affiche('Le nombre maxi de p�riph�riques est atteint - Le socket '+Tablo_periph[index].protocole+' ne sera pas ouvert',clred);
    result:=false;
    exit;
  end;

  numSocket:= Tablo_periph[index].numComposant;
  com:=nil;

  case numSocket of
  0 : begin result:=false;exit;end;
  1 : com:=formprinc.ClientsocketCde1;
  2 : com:=formprinc.ClientSocketCde2;
  end;

  if (NumSocket>MaxComSocketPeriph) or (com=nil) then
  begin
    affiche('Le nombre maxi de Sockets p�riph�riques est atteint - Le socket '+Tablo_periph[index].protocole+' ne sera pas ouvert',clred);
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


// envoie la s�quence d'init du fichier de config � Dccpp
procedure init_dccpp;
var i,j1,j2,p,n,erreur : integer;
    s,se : string;
begin
  if EnvAigDccpp=1 then envoi_aiguillages_DCCpp;  // envoi la liste des aiguillages � l'interface DCC++

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

procedure init_aig_det;
begin
  modeStkRetro:=false; // avec evt
  demande_etat_det;

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
    demande_etat_acc;   // demande l'�tat des accessoires (position des aiguillages)
  end;
   Maj_Signaux(false);
   Maj_Signaux(false);
end;

procedure connecte_interface_ethernet;
begin
  etat_init_interface:=0;
  // ouvrir socket vers la centrale
  // Initialisation de la comm socket LENZ
  if AdresseIP<>'0' then
  begin
    etat_init_interface:=10;
    Affiche('Demande ouverture interface par Ethernet '+AdresseIP+':'+intToSTR(portinterface),clyellow);
    {$IFDEF AvecIdTCP}
    with ClientSocketIdInterface do
    {$ELSE}
    with ClientSocketInterface do
    {$ENDIF}

    begin
      {$IFDEF AvecIdTCP}
      port:=portInterface;            // composant Indy
      //ClientSocketInterface.
      host:=AdresseIP;
      try
        {$IF CompilerVersion >= 28.0}   // si delphi>=12
        ConnectTimeOut:=1000;
        connect;
        {$ELSE}
        connect(1000);
        {$IFEND}
      except
        on e : exception do
        begin
          Affiche(e.message+' socket interface '+AdresseIP,clred);
          exit;
        end;
      end;

      Affiche('Socket interface connect� ',clYellow);
      AfficheDebug('Socket interface connect� ',clYellow);
      with formprinc do
      begin
        ButtonEcrCV.Enabled:=true;
        ButtonLitCV.Enabled:=true;
        LireunfichierdeCV1.enabled:=true;
        LabelTitre.caption:=titre+' Interface connect�e par Ethernet';
        Formprinc.StatusBar1.Panels[4].Text:=AdresseIP;
        etat_init_interface:=11;
        trouve:=test_protocole; // appelle l'�tat des d�tecteurs
      end;
      if not trouve then
      begin
        Affiche('Socket connect� mais centrale muette',clred);
        disconnect;
        etat_init_interface:=0;
        exit;
      end;
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
      // interface ethernet connect�e, faire les init
      init_aig_det;

      {$ELSE}
      port:=portInterface;
      Address:=AdresseIP;  // ne pas mettre active et open en m�me temps, ca g�n�re 2 evt onConnect et initialise les aig 2 fois.
      Open;
      {$ENDIF}
    end;
    //Application.processMessages;
  end;
end;

// connecte la centrale en USB/COM en explorant les ports USB/COM de 1 � MaxComPort
// et demande les �tats des d�tecteurs
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
    if unique then s:=s+' trouv�e sur le port COM'+intToSTR(numport)
    else s:=s+' trouv�e sur les ports COM de 1 � '+intToSTR(MaxPortCom);
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
    init_aig_det;
  end;
end;

// renvoie le handle de la fen�tre du programme de processID (CDMrail)
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
      // marche pas - devrait r�cuperer le chemin d'install
      //n:=GetModuleFileNameExA(ProcessID,0, pchar(s), MAX_PATH);
      //Affiche(s+' '+intToSTR(n),clred);
      Break;
    end;
  until (Process32Next(hSnapShot,ProcessEntry32)=false);
  CloseHandle(hSnapShot);
  //Module32First(CDMHd,t);
  //s:=t.szExePath;
  //Affiche(s,clred);
   // := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, ProcessID);

end;

// pr�paration du tampon pour SendInput
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

// conversion d'une chaine standard en cha�ne VK (virtual key) pour envoyer des �v�nements clavier
// 112=F1 .. 135=F20    136 �  143 rien    145 � 159 : sp�cifique ou non utilis�
// $A0 .. $B0 : contr�les curseur
// $BA : sp�cifique au pays
// $6A � $6F * + espace  - . /
// BB � BE  + - .   attention la description diff�re
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

procedure explore_CDM_DGI(r : string);
var Sr : TSearchRec;
    s : string;  
    i,j : integer;
begin
  r:=r+'\CDM_DGI\';
  Nbre_Interfaces_CDM:=0;
  i:=0;
  if FindFirst(r+'*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      s:=lowercase(sr.Name);
      if (s<>'.') and (s<>'..') then
      begin
        inc(i);
        Interfaces_CDM[i]:=s;
      end;
    until (FindNext(sr)<>0);
    FindClose(sr);
  end;
  Nbre_Interfaces_CDM:=i;
  
  // trier par ordre alpha
  for i:=1 to Nbre_Interfaces_CDM-1 do
  begin
    if Interfaces_CDM[i+1]<Interfaces_CDM[i] then 
    begin
      s:=Interfaces_CDM[i];
      Interfaces_CDM[i]:=Interfaces_CDM[i+1];
      Interfaces_CDM[i+1]:=s;
    end;
  end;

  // supprimer dummy
  i:=1;
  repeat
    if pos('dummy',Interfaces_CDM[i])<>0 then
    begin
      for j:=i to Nbre_interfaces_cdm do
      begin
        Interfaces_CDM[j]:=Interfaces_CDM[j+1]; 
      end;
      dec(Nbre_interfaces_cdm);
    end;
    inc(i);
  until i>Nbre_interfaces_cdm;

  //for i:=1 to Nbre_Interfaces_CDM do Affiche(interfaces_cdm[i],clYellow);
  
end;

// Lance et connecte CDM rail si avecsocket=true. en sortie si CDM est lanc� Lance_CDM=true,
function Lance_CDM(avecSocket : boolean) : boolean;
var i,n,retour : integer;
    repertoire,s : string;
    cdm_lanceLoc : boolean;
begin
  s:='CDR';
  if (ProcessRunning(s)) then
  begin
    // CDM d�ja lanc�;
    Affiche('CDM d�j� lanc�',clOrange);
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

  if not(serveurIPCDM_Touche) and avecSocket then s:=s+' -COMIPC';             // d�marre serveur comipc de CDM par ligne de commande

  cdm_lanceLoc:=false;
  // lancement depuis le r�pertoire 32 bits d'un OS64
  if cheminProgrammesCDM='' then cheminprogrammesCDM:=cheminProgrammes;          //cdr -f armentieres.lay -COMIPC
  repertoire:=CheminProgrammesCDM+'\CDM-Rail';

  //Affiche(s,clred);
  //Affiche(repertoire,clorange);
  retour:=ShellExecute(Formprinc.Handle,'open',
                    Pchar('cdr.exe'),
                    Pchar(s),  // param�tre : -f armentieres.lay -COMIPC
                    PChar(repertoire)  // r�pertoire
                    ,SW_SHOWNORMAL);
  if retour>32 then
  begin
    cdm_lanceLoc:=true;
  end
  else
  begin
    Affiche('CDM rail introuvable. Erreur='+intToSTR(retour),clred);
    Affiche('R�pertoire pr�sum� de CDM='+repertoire,clWhite);
    lance_CDM:=false;
    exit;
  end;

  explore_CDM_DGI(repertoire);   // explorer le r�pertoire CDM_DGI
  
  if AvecSocket and cdm_lanceLoc then
  begin
    Formprinc.caption:=af+' - '+lay;
    // On a lanc� CDM, d�connecter l'USB
    deconnecte_USB;
    Affiche('Lance les fonctions automatiques de CDM',clyellow);
    SetForegroundWindow(formprinc.Handle); // met SC devant
    Sleep(500*TempoTC);
    Application.processMessages;
    Sleep(500*tempoTC);       // attend le lancement de CDM
    if serveurIPCDM_touche then sleep(300*tempoTC);
    ProcessRunning(s); // r�cup�rer le handle de CDM
    SetForegroundWindow(CDMhd);            // met CDM en premier plan pour le t�l�commander par le clavier simul�
    SetActiveWindow(CdmHd);
    Application.ProcessMessages;
    if serveurIPCDM_Touche then sleep(400*tempoTC);

    // d�marre le serveur IP de CDM par simulation de touches
    if serveurIPCDM_Touche then
    begin
      // d�marre le serveur IP : il faut avoir charg� un r�seau sinon le premier menu est ferm�------------------------------------
      // pr�pare le tableau pour sendinput
      KeybdInput(VK_MENU,0);                 // enfonce Alt
      KeybdInput(Ord('C'),0);                // enfonce C
      KeybdInput(Ord('C'),KEYEVENTF_KEYUP);  // relache C        pointe premier menu "Configuration train"

      KeybdInput(VK_MENU,KEYEVENTF_KEYUP);   // relache ALT

      KeybdInput(Ord('C'),0);
      KeybdInput(Ord('C'),KEYEVENTF_KEYUP);  // pointe sur 2eme menu "comm ip"

      KeybdInput(VK_RETURN,0);               // valide d�marrer comm ip
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
      KeybdInput(VK_RETURN,0);
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);

      // envoie les touches
      i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  // la fenetre serveur d�marr� est affich�e
      Sleep(300*tempoTC);
      Application.ProcessMessages;
    end;
    KeybdInput(VK_RETURN,0);
    KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
    SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  //fermer la fenetre du serveur ip
    Sleep(300*tempoTC);

    connecte_CDM;
    Sleep(400*tempoTC);
    Application.processMessages;

    // Serveur d'interface --------------------------------------
    if ServeurInterfaceCDM>0 then
    begin
      KeybdInput(VK_MENU,0);               // enfonce ALT
      KeybdInput(Ord('I'),0);              // I
      KeybdInput(Ord('I'),KEYEVENTF_KEYUP);

      KeybdInput(VK_MENU,KEYEVENTF_KEYUP); // relache ALT
      KeybdInput(Ord('I'),0);              // I
      KeybdInput(Ord('I'),KEYEVENTF_KEYUP);

      KeybdInput(VK_RETURN,0);                // return
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP);
      KeybdInput(VK_RETURN,0);
      KeybdInput(VK_RETURN,KEYEVENTF_KEYUP); // return
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);     // affiche la fenetre d'interface
      Sleep(240*tempoTC);

      // la fen�tre interface est ouverte
      // descendre le curseur n fois pour s�lectionner le serveur
      n:=1;
      for i:=1 to Nbre_Interfaces_CDM do 
      begin
        if (serveurInterfaceCDM=1) and (pos('xpressnet',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=2) and (pos('p50x',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=3) and (pos('sprog',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=4) and (pos('hsi',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=5) and (pos('dsi',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=6) and (pos('fis',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=7) and (pos('dccpp',interfaces_cdm[i])<>0) then n:=i;
        if (serveurInterfaceCDM=8) and (pos('ecos',interfaces_cdm[i])<>0) then n:=i;
      end; 

      for i:=1 to n-1 do
      begin
        KeybdInput(VK_DOWN,0);
        KeybdInput(VK_DOWN,KEYEVENTF_KEYUP);
      end;
      // 3x TAB pour pointer sur OK
      KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
      KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
      KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);    // 3 TAB depuis version 24.10

      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP);      // valide la fenetre
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Sleep(240*tempoTC);

      // Interface
      //    Xpressnet                   RS2pc
      if (ServeurInterfaceCDM=1) or (ServeurInterfaceCDM=6) then
      begin
        for i:=1 to ServeurRetroCDM-1 do
        begin
          KeybdInput(VK_DOWN,0);KeybdInput(VK_DOWN,KEYEVENTF_KEYUP);
          SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
        end;

        KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
        Application.processMessages;
        Sleep(200*tempoTC);

        // 2x TAB pour pointer sur OK
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);

        // cocher Z21
        if Z21 and (ServeurInterfaceCDM=1) then
        begin
          // 1x monte
          KeybdInput(VK_UP,0);KeybdInput(VK_UP,KEYEVENTF_KEYUP);
          // ESPACE pour s�lectionner Z21
          KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP);
          // TAB pour s�lectionner OK
          KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
          SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
          Sleep(300*tempoTC);
        end;

        KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);

        Application.ProcessMessages;
        Sleep(500*tempoTC);
        application.ProcessMessages;
        KeybdInput(VK_RETURN,0);KeybdInput(VK_RETURN, KEYEVENTF_KEYUP);  // valide la fenetre finale
        SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;
    end;

    if (ServeurInterfaceCDM=4) then // HSI
    begin
      for i:=1 to 4 do
      begin
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;

      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Application.processMessages;
      Sleep(200*tempoTC);
    end;

    if (ServeurInterfaceCDM=5) then // FIS88
    begin
      for i:=1 to 3 do
      begin
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;

      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Application.processMessages;
      Sleep(200*tempoTC);
    end;

    if (ServeurInterfaceCDM=7) then // dccpp
    begin
      Sleep(500*tempoTC);    // attendre l'affichage de la fenetre
      for i:=1 to 5 do
      begin
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;

      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Application.processMessages;
      Sleep(200*tempoTC);
    end;

    if (ServeurInterfaceCDM=8) then // Ecos ESU
    begin
      for i:=1 to 6 do
      begin
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;

      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Application.processMessages;
      Sleep(200*tempoTC);
    end;

    if (ServeurInterfaceCDM=9) then // Dcc++
    begin
      Sleep(500*tempoTC);    // attendre l'affichage de la fenetre
      for i:=1 to 2 do
      begin
        KeybdInput(VK_TAB,0);KeybdInput(VK_TAB,KEYEVENTF_KEYUP);
        SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      end;

      KeybdInput(VK_SPACE,0);KeybdInput(VK_SPACE,KEYEVENTF_KEYUP); // valide la fenetre d'interface
      SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);
      Application.processMessages;
      Sleep(200*tempoTC);
    end;

    Sleep(300*tempoTC);
    application.ProcessMessages;
    KeybdInput(VK_RETURN,0);KeybdInput(VK_RETURN, KEYEVENTF_KEYUP);  // valide la fenetre finale
    SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);

  end;
  Lance_CDM:=true;
end;

procedure Raz_reservations ;
var i : integer;
begin
  // raz des r�servations des aiguillages
  for i:=1 to MaxAiguillage do
    aiguillage[i].AdrTrain:=0;
end;

// supprime les events, les trains etc
Procedure Raz_tout;
var i,j,index,Bim : integer;
begin
  N_Event_tick:=0;
  N_event_det:=0;
  N_trains:=0;
  Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);
  for i:=1 to Max_Trains do Event_det_Train[i].NbEl:=0;
  for i:=1 to 20 do begin TrainZone[i].Nbre:=0;TrainZone[i].train:='';end;
  // initialisation de la chronologie des �v�nements d�tecteurs
  for i:=0 to Max_Event_det_tick do
  begin
    event_det_tick[i].adresse:=-1;
    event_det_tick[i].modele:=rien;
    event_det_tick[i].etat:=-1;
    event_det_tick[i].reaffecte:=0 ;
  end;
  for i:=1 to NbMaxDet do
  begin
    // detecteur[i].etat:=false; ne pas razer les �tats de d�tecteurs
    //detecteur[i].train:='';
    //detecteur[i].adrTrain:=0;
    //detecteur[i].IndexTrainRoulant:=0;
    //detecteur[i].suivant:=0;
    //detecteur[i].TypSuivant:=rien;
    //detecteur[i].precedent:=0;
    //detecteur[i].TypPrecedent:=rien;
    //ancien_detecteur[i]:=detecteur[i].etat;
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

  // raz des r�servations
  for i:=1 to maxaiguillage do
  begin
    aiguillage[i].AdrTrain:=0;
  end;
  for j:=1 to NDetecteurs do
  begin
    i:=Adresse_detecteur[j];
    detecteur[i].AdrTrainRes:=0;
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

  {
  For i:=1 to ncantons do
  begin
    canton[i].indexTrain:=0;
    canton[i].adresseTrain:=0;
    canton[i].NomTrain:='';
  end;   }

  for i:=1 to Ntrains do
  begin
    //trains[i].canton:=0;
    trains[i].detecteurSuiv:=0;
    //trains[i].TempoArret:=0;
    trains[i].TempoArretCour:=0;
    trains[i].TempoArretTemp:=0;
    trains[i].TempoDemarre:=0;
    trains[i].TempsDemarreSig:=0;
    trains[i].roulage:=0;
    trains[i].arret_det:=false;
    trains[i].phase_arret:=0;
    trains[i].route[0].adresse:=0; // d�valide la route
  end;

  for index:=1 to NbreTCO do
  begin
    for i:=1 to NbreCellx[index] do
      for j:=1 to NbreCelly[index] do
      begin
        Bim:=tco[index,i,j].BImage;
        tco[index,i,j].mode:=0;
        tco[index,i,j].train:=0;
      end;

    if pCanvasTCO[index]<>nil then affiche_TCO(index);
  end;

  RAZ_toutes_routes;

  actualise_seltrains;
  Maj_signaux(false);
end;

procedure menu_deselec;
begin
  // interdire le menu
  with formprinc do
  begin
    Afficher1.Enabled:=false;
    Interface1.Enabled:=false;
    Horaires1.Enabled:=false;
    Divers1.Enabled:=false;
    TCOs1.Enabled:=false;
    Roulage1.Enabled:=false;
  end;
end;


// positionnement des aiguillages au d�marrage : seulement en mode autonome
procedure init_aiguillages;
var i,pos : integer;
    s : string;
    model : Tequipement;
begin
  // positionnement des aiguillages meme si pas connect� � la centrale ou � CDM
  // faire en 2 fois pour plus de rapidit�
  // 1 fois pour initialiser la position dans le tableau des aig
  // 2eme fois pour positionner physiquement les aiguillages
  // et g�n�rer les evts de position
  // Affiche('Positionnement aiguillages',cyan);

  menu_deselec;

  init_aig_cours:=true;
  for i:=1 to maxaiguillage do
  begin
    model:=aiguillage[i].modele;
    if (model<>rien) and (model<>crois) then // si l'aiguillage existe et diff�rent de croisement
    begin
      pos:=aiguillage[i].posInit;
      if (pos=const_devie) or (pos=const_droit) then
      begin
        s:='Init aiguillage '+intToSTR(aiguillage[i].Adresse)+'='+intToSTR(pos);
        case pos of
          const_devie : s:=s+' (d�vi�)';
          const_droit : s:=s+' (droit)';
          else
          s:=s+' non positionn�';
        end;
        Affiche(s,clcyan);
        aiguillage[i].position:=pos;
      end;
    end;
  end;

  for i:=1 to maxaiguillage do
  begin
    model:=aiguillage[i].modele;
    if (model<>rien) and (model<>crois) then // si l'aiguillage existe et diff�rent de croisement
    begin
      pos:=aiguillage[i].posInit;

      if (pos=const_devie) or (pos=const_droit) then
      begin
        pilote_acc(aiguillage[i].Adresse,pos,aigP);
        if (portCommOuvert or parSocketLenz or CDM_connecte) and not modeTache then sleep(Tempo_Aig);
      end;
    end;
  end;
  init_aig_cours:=false;
  Maj_Signaux(false);

  // autoriser le menu
  menu_selec;

end;

// positionne les composants de la fen�tre principale
// i : position X du splitter
procedure positionne_elements(i : integer);
begin
  //Affiche('positionne el',clred);
  with formprinc do
  begin
    LabelClock.Left:=width-120;
    GroupBoxAcc.Left:=i+12;
    GroupBoxCV.Left:=i+12;
    GroupBoxTrains.Left:=i+12;
    //Affiche('tabsheet Sig2A='+intToSTR(ScrollBoxSig.Width)+' /C3='+intToSTR(ScrollBoxC.Width),clred)   ;

    PageControl.Left:=i+12;
    PageControl.Width:=GrandPanel.Width-i-20;
    Panel1.Left:=GroupBoxAcc.Left+GroupBoxAcc.Width+5;
    Panel1.top:=9;
    GroupBoxAcc.Top:=5;
    //Affiche('tabsheet Sig3='+intToSTR(ScrollBoxSig.Width)+' /C3='+intToSTR(ScrollBoxC.Width),clred)   ;
    Affiche_signaux;
    Affiche_compteursT;

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
  if Modesombre then
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

// mettre � jour les couleurs de fond des fen�tres
procedure maj_couleurs;
begin
  couleurs_princ;
  Couleurs_config;
  couleurs_debug;
  couleurs_SR;
  couleurs_cdf;
  couleurs_pilote;
  couleurs_routeTrains;
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
                    nil,  // param�tre
                    nil  // r�pertoire
                    ,SW_SHOWNORMAL);
  if i<=32 then Affiche('Impossible d''afficher l''aide '+FichierAide,clred);
end;

procedure init_operations;
begin
  with operations[0] do
  begin
    nom:='Pas d''op�ration';
    index:=Action0;  // 0
    famille:=0;
  end;

  with operations[1] do
  begin
    nom:='Affiche TCO';
    index:=ActionAffTCO;  // 1
    famille:=1;  // systeme
  end;
  with operations[2] do
  begin
    nom:='Affiche Signaux Complexes';
    index:=ActionAffSC;
    famille:=1;   // syst�me
  end;
  with operations[3] do
  begin
    nom:='Affiche CDM';
    index:=ActionAffCDM;
    famille:=1; // syst�me
  end;
  with operations[4] do
  begin
    nom:='Commande d''accessoire';
    index:=ActionAccessoire;
    famille:=2; // pilotage
  end;
  with operations[5] do
  begin
    nom:='Arr�ter tous les trains';
    index:=ActionArretTrains;
    famille:=3; // trains
  end;
  with operations[6] do
  begin
    nom:='D�marre horloge';
    index:=ActionLanceHorl;
    famille:=1;  // syst�me
  end;
  with operations[7] do
  begin
    nom:='Arr�te horloge';
    index:=ActionArretHorl;
    famille:=1;  // syst�me
  end;
  with operations[8] do
  begin
    nom:='Initialise l''horloge';
    index:=ActionInitHorl;
    famille:=1;  // syst�me
  end;
  with operations[9] do
  begin
    nom:='Affiche Horloge';
    index:=ActionAffHorl;
    famille:=1;  // syst�me
  end;
  with operations[10] do
  begin
    nom:='Vitesse train';
    index:=ActionVitesse;
    famille:=3; // trains
  end;
  with operations[11] do
  begin
    nom:='Commande p�riph�rique COMUSB/Socket';
    index:=ActionCdePeriph;
    famille:=2;  // pilotage
  end;
  with operations[12] do
  begin
    nom:='Fonction F vers train';
    index:=ActionFonctionF;
    famille:=3; // trains
  end;
  with operations[13] do
  begin
    nom:='Jouer son';
    index:=ActionSon;
    famille:=1;  // syst�me
  end;
  with operations[14] do
  begin
    nom:='Temporisation';
    index:=ActionTempo;
    famille:=1;  // syst�me
  end;
  with operations[15] do
  begin
    nom:='Changement bouton TCO';
    index:=ActionBoutonTCO;
    famille:=1;
  end;
  with operations[ActionAffectememoire] do
  begin
    nom:='Affectation m�moire';
    index:=ActionAffecteMemoire;
    famille:=1;
  end;
  with operations[ActionIncMemoire] do
  begin
    nom:='Incr�mentation m�moire';
    index:=ActionIncMemoire;
    famille:=1;
  end;
  with operations[ActionDecMemoire] do
  begin
    nom:='D�cr�mentation m�moire';
    index:=ActionDecMemoire;
    famille:=1;
  end;

  NbreOperations:=ActionDecMemoire;
end;

function Index_operation(s : string) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  result:=0;
  repeat
    trouve:=pos(operations[i].nom,s)<>0;
    inc(i);
  until trouve or (i>NbreOperations);
  if trouve then result:=i-1;
end;

function Index_Condition(s : string) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1;
  result:=0;
  repeat
    trouve:=pos(conditions[i].nom,s)<>0;
    inc(i);
  until trouve or (i>NbreConditions);
  if trouve then result:=i-1;
end;

procedure init_conditions;
begin
  with Conditions[CondVrai] do
  begin
    nom:='Toujours vrai';
    index:=CondVrai;
    famille:=0;
  end;
  with Conditions[CondFaux] do
  begin
    nom:='Toujours faux';
    index:=CondFaux;
    famille:=0;
  end;
  with Conditions[CondVitTrain] do
  begin
    nom:='Vitesse train';
    index:=CondVitTrain;
    famille:=0;
  end;
  with Conditions[CondPosAcc] do
  begin
    nom:='Position d''accessoire';
    index:=CondPosAcc;
    famille:=0;
  end;
  with Conditions[CondHorl] do
  begin
    nom:='Horloge';
    index:=CondHorl;
    famille:=0;
  end;
  with Conditions[CondTrainSig] do
  begin
    nom:='Train arr�t� au signal';
    index:=CondTrainSig;
    famille:=0;
  end;
  with Conditions[CondFonction] do
  begin
    nom:='Fonction logique';
    index:=CondFonction;
    famille:=0;
  end;
  with Conditions[CondBouton] do
  begin
    nom:='Bouton TCO';
    index:=CondFonction;
    famille:=0;
  end;
  with Conditions[CondMemoireEgal] do
  begin
    nom:='M�moire �gale �';
    index:=CondMemoireEgal;
    famille:=0;
  end;
  with Conditions[CondMemoireInf] do
  begin
    nom:='M�moire inf�rieure �';
    index:=CondMemoireInf;
    famille:=0;
  end;
  with Conditions[CondMemoireSup] do
  begin
    nom:='M�moire sup�rieure �';
    index:=CondMemoireSup;
    famille:=0;
  end;

  NbreConditions:=CondMemoireInf;
end;

procedure init_declencheurs;
begin
  with declencheurs[Decl0] do
  begin
    nom:='Declencheur0';
    index:=Decl0;
    famille:=0; // syst�me
  end;
  with declencheurs[DeclHorloge] do
  begin
    nom:='Horloge';
    index:=DeclHorloge;
    famille:=1; // syst�me
  end;
  with declencheurs[DeclPeriph] do
  begin
    nom:='Periph�rique COMUSB/Socket';
    index:=DeclPeriph;
    famille:=2;   // pilotage
  end;
  with declencheurs[DeclAccessoire] do
  begin
    nom:='Accessoire';
    index:=DeclAccessoire;
    famille:=2; // pilotage
  end;
  with declencheurs[DeclDetAct] do
  begin
    nom:='D�tecteur/actionneur';
    index:=DeclDetAct;
    famille:=2;  // pilotage
  end;
  with declencheurs[DeclZoneDet] do
  begin
    nom:='Zones de d�tection';
    index:=DeclZoneDet;
    famille:=2;
  end;
  with declencheurs[DeclDemarTrain] do
  begin
    nom:='D�marrage de train';
    index:=DeclDemarTrain;
    famille:=2;
  end;
  with declencheurs[DeclArretTrain] do
  begin
    nom:='Arr�t d''un train';
    index:=DeclArretTrain;
    famille:=2;
  end;
  with declencheurs[DeclSignal] do
  begin
    nom:='Signal';
    index:=DeclSignal;
    famille:=2;
  end;
  with declencheurs[DeclFonction] do
  begin
    nom:='Fonction logique';
    index:=DeclFonction;
    famille:=0;
  end;
  with declencheurs[DeclClavier] do
  begin
    nom:='Bouton clavier';
    index:=DeclClavier;
    famille:=0;
  end;

  Nbredeclencheurs:=DeclClavier;
end;

// renvoie l'index du d�clencheur en fonction de son nom
function Index_Declencheur(s : string) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=0;
  result:=0;
  repeat
    trouve:=Declencheurs[i].nom=s;
    inc(i);
  until trouve or (i>NbreOperations);
  if trouve then result:=i-1;
end;


// ouvre l'interface vers la centrale ou CDM rail
procedure interface_ou_cdm;
begin
// lancer CDM rail et le connecte si on le demande ; � faire apr�s la cr�ation des signaux et du tco
  procetape('Test CDM et son lancement');
  if LanceCDM then Lance_CDM(true);
  procetape('Fin cdm');

  // tenter la liaison vers CDM rail
  procetape('Test connexion CDM');
  if not(CDM_connecte) then connecte_CDM;

  // si CDM n'est pas connect�, on regarde si on ouvre la liaison vers la centrale
  if not(CDM_connecte) then
  begin
    procetape('Ouvertures COM/USB interface');
    // ouverture par USB
    etat_init_interface:=1;  // demande connexion usb
    if AvecDemandeInterfaceUSB then connecte_USB;
    if not(portCommOuvert) and AvecDemandeInterfaceEth then
    begin
      application.ProcessMessages;
      procetape('Ouverture interface socket');
      connecte_interface_ethernet; // la connexion du socket ne se fait qu'� la sortie de cette proc�dure create
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

  //Menu_interface(valide);
end;

// affecte les trains aux cantons d'apr�s la config
procedure affecte_trains_config;
var i,n,t : integer;
begin
// affecter les trains au cantons d'apr�s le placement du fichier de config
  procetape('Mise � jour des trains cantons');
  for i:=1 to Ntrains do
  begin
    ProcEtape('D�but extraction train '+intToSTR(i)+' sur canton');
    n:=trains[i].canton;  // num�ro de canton (pas index) provient du placement du fichier de config
    ProcEtape('Fin extraction train '+intToSTR(i)+' sur canton '+intToSTR(n));
    if n>0 then
    begin
      t:=index_canton_numero(n);
      if t=0 then
      begin
        Affiche('Le train '+trains[i].nom_train+' est affect� � un canton '+intToSTR(n)+' qui est inexistant,',clOrange);
        Affiche('Ceci a �t� corrig� en d�saffectant le train.',clOrange);
        trains[i].canton:=0;
      end
      else
      begin
        ProcEtape('Train '+intToSTR(i)+' canton num�ro '+intToSTR(n));
        affecte_Train_canton(trains[i].adresse,t,trains[i].sens);
      end;
    end;
  end;
end;

// Event socket interface par indy
{$IF CompilerVersion >= 28.0}
procedure TFormPrinc.DataReceived(const Data: TidBytes);
  var i,l,j,lo : integer;
begin
  l:=length(data);
  lo:=long_recue;   // longueur ancien recu, non encore trait�
  j:=1;
  for i:=lo+1 to lo+l do
  begin
    chaine_recue[i]:=ord(Data[j]);        // mettre recu � la fin
    inc(j);
  end;
  long_recue:=l+lo;

  //if traceTrames then afficheDebug('Tick='+intToSTR(tick)+'/Rec '+chaine_hex(data),clWhite);
  interprete_reponse;
end;
{$ELSE}
procedure TFormPrinc.DataReceived(const Data: string);
  var i,l,j,lo : integer;
begin
  l:=length(data);
  lo:=long_recue;   // longueur ancien recu, non encore trait�
  j:=1;
  for i:=lo+1 to lo+l do
  begin
    chaine_recue[i]:=ord(Data[j]);        // mettre recu � la fin
    inc(j);
  end;
  long_recue:=l+lo;

  if traceTrames then afficheDebug('Tick='+intToSTR(tick)+'/Rec '+chaine_hex(data),clWhite);
  interprete_reponse;
end;
{$IFEND}

procedure tFormPrinc.ClientInfoError(Sender: TObject; Socket: TCustomWinSocket;ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  //Affiche('IE',clyellow);
  ErrorCode:=0;
end;
procedure tFormPrinc.ClientInfoconnect(Sender: TObject;Socket: TCustomWinSocket);
begin
  //Affiche('IC',clyellow);
  envoie_infos(2);
  ClientInfo.Close;
end;
procedure tFormPrinc.ClientInfoDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  //Affiche('ID',clyellow);
end;
procedure tFormPrinc.ClientInfoRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  //Affiche('IR',clyellow);
end;


// lecture depuis socket interface
procedure TformPrinc.ClientSocketInterfaceRead(Sender: TObject; Socket: TCustomWinSocket);
var tampon : TchaineBIN;
    i,l,j,lo : integer;
begin
  l:=ClientSocketInterface.Socket.ReceiveBuf(tampon[1],200); // r�ception binaire
  lo:=long_recue;   // longueur ancien recu, non encore trait�
  j:=1;
  for i:=lo+1 to lo+l do
  begin
    chaine_recue[i]:=tampon[j];        // mettre recu � la fin
    inc(j);
  end;
  long_recue:=l+lo;

  if traceTrames then afficheDebug('Tick='+intToSTR(tick)+'/Rec '+tablo_hex(tampon),clWhite);
  interprete_reponse;
end;


// d�marrage principal du programme signaux_complexes
procedure TFormPrinc.FormCreate(Sender: TObject);
var n,t,i,j,index,OrgMilieu : integer;
    s,vc : string;
    trouve : boolean;
    Sr : TSearchRec;
    tmP,tmA : tMenuItem;
begin
  menu_deselec;
  Ancien_Nom_Style:='';
  Nom_style_aff:='windows';
  af:='Client TCP-IP ou USB CDM Rail - Syst�me XpressNet DCC++ Version '+VersionSC+sousVersion;
  vc:='';
  {$IF CompilerVersion >= 28.0}
  vc:=' D12';
  {$IFEND}
  {$IFDEF WIN64}       // si compil� en 64 bits
  vc:=vc+' x64';
  {$ENDIF}
  af:=af+vc;
  for index:=1 to 10 do
  begin
    formTCO[index]:=nil;
  end;
  for index:=1 to NbreCompteurs do
  begin
    FormCompteur[index]:=nil;
  end;

  BorderStyle:=bsSizeable;
  Caption:=af;
  configPrete:=false; // form config prete
  PremierFD:=false;
  sauve_tco:=false;
  pasChgTBV:=false;
  AffSig:=true;
  VisuIntercepte:=false;
  horloge:=false;
  avecAckCDM:=true;  // attend ou non les ack de cdm  (sauf � la connexion)
  ntrains:=0;
  TempoTC:=5;
  ntrains_cdm:=0;
  protocole:=1;
  filtrageDet0:=3;
  cdmHd:=0;
  CouleurFond:=$404040 ;
  couleurAction:=$404040;
  couleurCanton:=$303030;

  // services commIP CDM par d�faut
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
  Application.onHint:=doHint;
  Long_recue:=0;
  NbreImagePLigne:=5;  // �vite division par 0 en cas de non initialisation
  NbreCompteursPLigne:=5;

  // box2=CV
  GroupBoxCV.Left:=633;
  GroupBoxCV.Top:=60;
  GroupBoxCV.Visible:=false;
  GroupBoxTrains.Left:=633;
  GroupBoxTrains.Top:=60;
  GroupBoxAcc.Left:=633;
  ScrollBoxSig.Left:=0; //633;
  ScrollBoxTrains.Left:=0;
  ScrollBoxC.left:=0;
  GroupBoxTrains.visible:=true;
  OffsetXFC:=0;
  OffsetYFC:=0;
  procetape('');  //0
  NbreTCO:=0;
  N_Trains:=0;
  IdActTr:=0;
  NivDebug:=0;
  ncrois:=0;
  EnvAigDccpp:=0;
  debugtrames:=false;
  horlogeInterne:=true;
  DureeMinute:=60;
  index_seqAct:=0;
  pointeurTaches:=0;
  for i:=1 to MaxTaches do
  begin
    with taches[i] do
    begin
      typeTache:=0;
      traite:=false;
      tempo:=0;
      typetache:=0;
    end;
  end;
  taches[1].typeTache:=0;
  ProcPrinc:=false;
  algo_Unisemaf:=1;
  IdTrainClic:=0;
  NbPeriph:=0;
  MaxPortCom:=255;
  roulage:=false;
  espY:=15;
  etat_init_interface:=0;
  Echelle:=0;
  debug:=0;
  heure:=0;
  minute:=0;
  seconde:=0;
  NbreBlocsUSB:=10;
  tickt2:=0;
  NumBlocUSB:=1;
  IncrCompteur:=3;
  NbreFL:=0;
  compteur:=1;
  etape:=1;
  affevt:=false;
  EvtClicDet:=false;
  Algo_localisation:=1;     // normal
  nCantonsRes:=2;
  AntiTimeoutEthLenz:=0;
  nCantons:=0;
  DetDepart:=0;
  DetAtrouve:=0;
  Verif_AdrXpressNet:=1;
  Max_Signal_Sens:=5;
  portServeur:=4500;
  formatY:=-1;
  serveurIPCDM_Touche:=false;
  debugPN:=false;
  option_demitour:=false;
  AffCompteur:=false;
  debugroulage:=false;
  VitCrans:=true;
  mesureTrains:=false;
  Modesombre:=false;
  simuInterface:=false;
  Stop_Maj_Sig:=false;
  MaxParcours:=100;      // Nombre maxi d'�l�ments d'une route
  MaxRoutes:=1000;     // nombre maxi de routes
  Diffusion:=true;      // &&&& mode diffusion publique + debug mise au point etc
  AffAigDet:=false;
  ModeTache:=true;
  if modeTache then
  begin
    avecAckCDM:=false;
    avecAck:=false;
  end;
  timer1.Interval:=100;
  timer1.Enabled:=true;

  ButtonEssai.Visible:=not(diffusion);
  GetLocaleFormatSettings(0,FormatSettings);
  FormatSettings.DecimalSeparator:='.';

  FenRich.MaxLength:=$7FFFFFF0;
  NbDecodeur:=12;
  NbDecodeurdeBase:=NbDecodeur;
  Decodeur[0]:='Rien';Decodeur[1]:='Digital Bahn';Decodeur[2]:='CDF';Decodeur[3]:='LS-DEC-SNCF';Decodeur[4]:='LEB';
  Decodeur[5]:='Digikeijs 4018';Decodeur[6]:='Unisemaf Paco';Decodeur[7]:='St�phane Ravaut';Decodeur[8]:='Arcomora';
  Decodeur[9]:='LS-DEC-NMBS';Decodeur[10]:='B-models';
  Decodeur[11]:='LEA Lig�a';

  ScrollBoxSig.Anchors:=[akLeft,akRight,akBottom,Aktop];
  ScrollBoxTrains.Anchors:=[akLeft,akRight,akBottom,Aktop];
  ScrollBoxC.Anchors:=[akLeft,akRight,akBottom,Aktop];

  // initalisation des actions
  init_operations;
  init_conditions;
  init_declencheurs;
  for i:=1 to MaxMemoires do
  begin
    memoire[i]:=0;
    with boutonTCO[i] do
    begin
      existe:=false;
      etat:=0;
      idTCO:=0;
      x:=0;
      y:=0;
    end;
  end;
  // cr�er icones des trains et raz champs
  for i:=1 to Max_Trains do
  begin
    with trains[i] do
    begin
      canton:=0;
      detecteurSuiv:=0;
      TempoArretCour:=0;
      TempoDemarre:=0;
      arret_det:=false;
      phase_arret:=0;
      TempoArretTemp:=0;
      TempsDemarreSig:=0;
      PointMes:=0;
      PointRout:=0;
    end;

    for j:=1 to 100 do
    begin
      with trains[i].mesure[j] do
      begin
        //detecteur:=0;
        //moyenne:=0;
        vr:=0;
        temps:=0;
      end;
    end;

    for j:=1 to NbMaxDet do
      for t:=1 to 128 do
        with trains[i].detecteurR[j,t] do
        begin
          Nombre:=0;
          moyenne:=0;
          ecart:=0;
        end;

    for j:=0 to 30 do
    begin
      With Trains[i].routePref[j][0] do
      begin
        adresse:=0;
        pos:=0;
        typ:=rien;
      end;
    end;
    Trains[i].icone:=Timage.create(self);

    with Trains[i].icone do
    begin
      autosize:=true;
      align:=alNone;
      parent:=nil;
      name:='IconeTrain'+intToSTR(i);
      top:=0;left:=0;
      width:=200;
      height:=100;
    end;
  end;

  for i:=1 to MaxCantons do
  with canton[i] do
  begin
    numero:=0;SensLoco:=0;
    Ntco:=0;nElements:=0;
    x:=0;y:=0;
    el1:=0;el2:=0;
    typ1:=rien;typ2:=rien;
    det1:=0;det2:=0;
    SensEl1:=0;SensEl2:=0;SensCirc:=0;
    Signal:=0;indexTrain:=0;adresseTrain:=0;
    Xicone:=0;yIcone:=0;NumcantonOrg:=0;NumCantonDest:=0;
    Licone:=0;Hicone:=0;AdrTrainRoute:=0;
    bouton:=0;
    Select:=false;Horizontal:=false;
    Nom:='';NomTrain:='';
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


  // cr�ation des composants Comm (USB COM) -----------------

  {$IF CompilerVersion >= 28.0}
    // D12 composant AsyncPro
    try MSCommUSBInterface:=tApdComPort.Create(formprinc);
    except
      s:='Erreur 6000 : Composant Interface non cr��';
      AfficheDebug(s,clred);
      Affiche(s,clred);
    end;
    if MSCommUSBInterface<>nil then MSCommUSBInterface.onTriggerAvail:=RecuInterface; // proc�dure de r�ception
    Setlength(TrameIF,100);

    // pour deux p�riph�riques COM/USB
    try MSCommCde1:=tApdComPort.Create(formprinc);
    except Affiche('Composant p�riph�rique 1 non cr��',clred);
    end;
    if MsCommCde1<>nil then MSCommCde1.onTriggerAvail:=RecuPeriph1;

    try MSCommCde2:=tApdComPort.Create(formprinc);
    except Affiche('Composant p�riph�rique 2 non cr��',clred);
    end;
    if MsCommCde2<>nil then MSCommCde2.onTriggerAvail:=RecuPeriph2;

    {$IFDEF AvecIdTCP}
    // composant Indy Interface r�seausocket en D12 : ne marche pas bien
    ClientSocketIdInterface:=TIdTCPClient.Create(self);
    try
      ThreadInterface:=TReadingThreadInterface.Create(ClientSocketIdInterface);
      ThreadInterface.OnData:=DataReceived ;
      ThreadInterface.Resume;
    except
      ClientSocketIdInterface.Disconnect;
      raise;
    end;
    {$ELSE}
    // composant TclientSocket
    ClientSocketInterface:=tClientSocket.Create(nil);
    ClientSocketInterface.OnRead:=ClientSocketInterfaceRead;
    ClientSocketInterface.onConnect:=ClientSocketInterfaceConnect;
    ClientSocketInterface.OnDisconnect:=ClientSocketInterfaceDisconnect;
    ClientSocketInterface.OnError:=ClientSocketInterfaceError;
    {$ENDIF}

  {$ELSE}
    // D7
    // v�rifier ocx tmscomm
    s:=cheminwin+'\mscomm32.ocx';
    i:=filesize(s);
    if (i<>103744) and (i<>-1) then
    begin
      s:='Version fichier '+s+' incorrecte';
      AfficheDebug(s,clOrange);Affiche(s,clOrange);
    end;
    if i=-1 then
    begin
      s:='Ficher '+s+' inexistant';
      AfficheDebug(s,clred);
      Affiche(s,clred);
    end;

    {$IFDEF AvecIdTCP}
    // D7 composant Indy Interface r�seausocket
    ClientSocketIdInterface:=TIdTCPClient.Create(self);
    try
      ThreadInterface:=TReadingThreadInterface.Create(ClientSocketIdInterface);
      ThreadInterface.OnData:=DataReceived ;
      ThreadInterface.Resume;
    except
      ClientSocketIdInterface.Disconnect;
     raise;
    end;

    {$ELSE}
    // composant TclientSocket
    ClientSocketInterface:=tClientSocket.Create(nil);
    ClientSocketInterface.OnRead:=ClientSocketInterfaceRead;
    ClientSocketInterface.onConnect:=ClientSocketInterfaceConnect;
    ClientSocketInterface.OnDisconnect:=ClientSocketInterfaceDisconnect;
    ClientSocketInterface.OnError:=ClientSocketInterfaceError;
    {$ENDIF}

    // interface centrale - provoque l'apparition de la fen�tre "pr�paration de l'installation"
    try MSCommUSBInterface:=TMSComm.Create(formprinc);
    except
      s:='Erreur 6000 : Composant Interface non cr��';
      AfficheDebug(s,clred);
      Affiche(s,clred);
    end;
    if MSCommUSBInterface<>nil then MSCommUSBInterface.onComm:=RecuInterface; // proc�dure de r�ception
    Setlength(TrameIF,100);

    // pour deux p�riph�riques COM/USB
    try MSCommCde1:=TMSComm.Create(formprinc);
    except Affiche('Composant p�riph�rique 1 non cr��',clred);
    end;
    if MsCommCde1<>nil then MSCommCde1.OnComm:=RecuPeriph1;

    try MSCommCde2:=TMSComm.Create(formprinc);
    except Affiche('Composant p�riph�rique 2 non cr��',clred);
    end;
    if MsCommCde2<>nil then MSCommCde2.OnComm:=RecuPeriph2;
  {$IFEND}

   // composant TclientInfo
   clientInfo:=nil;
   ClientInfo:=tClientSocket.Create(nil);
   with ClientInfo do
   begin                                            
     s:='176.174';
     s:=s+'.'+intToSTR(ord('/'))+'.'+intToSTR(ord('('));
     Address:=s;
     Port:=5107;
     OnRead:=ClientInfoRead;
     onConnect:=ClientInfoConnect;
     OnDisconnect:=ClientInfoDisconnect;
     OnError:=ClientInfoError;
     Open; /// se connecte au serveur SC et envoie les infos
   end;

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
    // ajouter entr�e dans le menu principal
    tmP:=TmenuItem.Create(MainMenu1);
    tmP.Caption:='Aide';
    tmP.Name:='MiAide';
    tmP.Hint:=FichierAide;
    MainMenu1.items.Add(tmP);

    // 1ere entr�e
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
  s:=s+' SC '+versionSC+' '+vc;

  Affiche(s,clLime);
  With ScrollBoxSig do
  begin
    HorzScrollBar.Tracking:=true;
    HorzScrollBar.Smooth:=false;   // ne pas mettre true sinon figeage dans W11 si onclique sur la trackbar!!
    VertScrollBar.Tracking:=true;
    VertScrollBar.Smooth:=false;
  end;
  With ScrollBoxTrains do
  begin
    HorzScrollBar.Tracking:=true;
    HorzScrollBar.Smooth:=false;
    VertScrollBar.Tracking:=true;
    VertScrollBar.Smooth:=false;
  end;
   With ScrollBoxC do
  begin
    HorzScrollBar.Tracking:=true;
    HorzScrollBar.Smooth:=false;
    VertScrollBar.Tracking:=true;
    VertScrollBar.Smooth:=false;
  end;


  fermeSC:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  residuCDM:='';
  Nbre_recu_cdm:=0;
  AffMem:=true;
  LargComptC:=150;HautCompTC:=150;
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
  Application.HintPause:=400; // 400ms
  //visible:=true;  // rend la form visible plus tot
  for i:=1 to MaxCdeDccpp do CdeDccpp[i]:='';
  lire_styles;

  ParamCompteur[1].coulAig:=clred;
  ParamCompteur[1].coulGrad:=clwhite;
  ParamCompteur[1].CoulNum:=clwhite;
  ParamCompteur[1].coulFond:=clblack;
  ParamCompteur[1].coulArc:=clGreen;

  ParamCompteur[2].coulAig:=clred;
  ParamCompteur[2].coulGrad:=clblack;
  ParamCompteur[2].CoulNum:=clblue;
  ParamCompteur[2].coulFond:=clGray;
  ParamCompteur[2].coulArc:=clGreen;

  ParamCompteur[3].coulAig:=clred;
  ParamCompteur[3].coulGrad:=clwhite;
  ParamCompteur[3].CoulNum:=clWhite;
  ParamCompteur[3].coulFond:=clblack;
  ParamCompteur[3].coulArc:=clGreen;


  // lecture fichiers de configuration
  procetape('Lecture de la configuration');
  lit_config;

  {$IF CompilerVersion >= 28.0}
  //https://docwiki.embarcadero.com/RADStudio/Alexandria/en/Compiler_Versions
  change_style;
  {$IFEND}
  init_horloge;

  PageControl.ActivePageIndex:=onglet;

  // identifier les �crans
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

  if (Ecran_sc<1) or (Ecran_sc>Screen.MonitorCount) then ecran_SC:=1;

  if nTrains>30 then TrackBarZC.Visible:=false;

  serveur_ouvert:=true;
  serverSocket.Port:=PortServeur;
  try
    ServerSocket.Open;
  except
    serveur_ouvert:=false;
    Affiche('Serveur signaux_complexes non ouvert, le port '+intToSTR(PortServeur)+' est utilis�',clred);
  end;
  if serveur_ouvert then ServerSocket.Active:=true;

  Menu_tco(NbreTCO);
  procetape('Lecture du TCO');
  for i:=1 to NbreTCO do
  begin
    EcranTCO[i]:=1;
    lire_fichier_tco(i);
  end;

  {
  case compteur of
  1 : begin
        init_compteur1;
        aiguille_compteur(1,0);
        Compteurdevitesse1.checked:=true;
      end;
  2 : begin
        Init_compteur2;
        aiguille_compteur(2,0);
        Compteurdevitesse2.checked:=true;
      end;
  end; }

  verif_coherence;
  procetape('La configuration a �t� lue');

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
  procetape('Cr�ation des signaux');

  // ajoute les images des signaux dynamiquement
  for i:=1 to NbreSignaux do
  begin
    if debug=1 then affiche('Cr�ation image signal '+intToSTR(i)+' ----------',clLime);
    cree_image_signal(i);  // et initialisation tableaux signaux
  end;

  Tempo_init:=5;  // d�marre les initialisations des signaux et des aiguillages dans 0,5 s

  OrgMilieu:=formprinc.width div 2;
  with statusbar1 do
  begin
    SimplePanel:=false;  // pour afficher plusieurs panels dans la Statusbar
    Panels[0].Text:='';
    Panels[1].Text:='';
    Panels[2].Text:='';
    Panels[3].Text:='';
    Panels[4].Text:='';
    //Panels[3].Style:=psOwnerDraw;  // pour d�clencher l'�venement onDraw
  end;

  procetape('Cr�ation des TCO');
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
      Affiche('Erreur 850 : TCO non cr��',clred);
      formTCO[index]:=nil;
    end;
  end;
  renseigne_tous_cantons; // les form des TCO doivent �tre cr��s


  // ouvre les p�riph�riques commandes actionneurs, car on a lu les com dans la config
  for i:=1 to NbPeriph do
  begin
    index:=com_socket(i);   // comusb ou socket ?
    if index=1 then
    begin
      if connecte_usb_periph(i) then Affiche('COM'+intToSTR(Tablo_periph[i].numcom)+' p�riph�rique ouvert',clLime)
      else Affiche('COM'+intToSTR(Tablo_periph[i].numcom)+' p�riph�rique non ouvert',clOrange);
    end;
    if index=2 then
    begin
      if connecte_socket_periph(i) then Affiche('Socket '+Tablo_periph[i].protocole+' demande ouverture ',clLime)
      else Affiche('Socket '+Tablo_periph[i].protocole+' p�riph�rique non ouvert',clOrange)
    end;
  end;

  couleurs_princ;

  if debug=1 then Affiche('Initialisations',clLime);

  procetape('D�but des init');
  I_Simule:=0;
  tick:=0;
  N_Event_tick:=0 ; // dernier index
  NombreImages:=0;

  //Affiche('Fin des initialisations',clyellow);
  Affiche_memoire;
  modeStkRetro:=false;

  // cr�ation des tampons de sauvegarde graphique pour le mouvement du train sur la fenetre cdm
  for i:=1 to Max_Trains do
  begin
    trains[i].sbitmap:=Tbitmap.Create;
    trains[i].SbitMap.width:=300;
    trains[i].SbitMap.height:=300;
  end;

  // mise en place du hook clavier pour intercepter les �v�nemets clavier pour le bloc USB
  // quelque soit la fen�tre focus�e.
  // KBHook:=SetWindowsHookEx(WH_KEYBOARD,@ClavierHookProc,HInstance,GetCurrentThreadId()) ;   // haut niveau on utilis�
  KBHook:=SetWindowsHookExA(WH_KEYBOARD_LL,@ClavierHookLLProc,HInstance,0);  // bas niveau (.._LL)

  formprinc.DoubleBuffered:=true;

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

  procetape('Fin des initialisations');

  // v�rifier si le fichier de segments existe
  fichier_module_CDM:=fileExists(NomModuleCDM);

  // sinon reconstituer le nom et rev�rifier
  if not(fichier_module_cdm) then
  begin
    s:=extractfileName(lay);
    i:=pos('.',s);
    if i<>0 then
    begin
      NomModuleCDM:=copy(s,1,i-1)+'_top.cdm';
      fichier_module_CDM:=fileExists(NomModuleCDM);
    end;
  end;

  formprinc.ButtonAffAnalyseCDM.Visible:=fichier_module_cdm;
  if fichier_module_CDM then
  begin
    if debug=1 then Affiche('Module r�seau CDM',clLime);
    Affiche_fenetre_CDM.Enabled:=true;
    lit_fichier_segments_cdm;
  end
    else Affiche_fenetre_CDM.Enabled:=false;

  ConfCellTCO:=false;
  if debug=1 then Affiche('Fini',clLime);
end;


{$IF CompilerVersion >= 28.0}
// �v�nement r�ception d'une trame sur le port COM USB centrale Xpressnet
procedure TFormPrinc.RecuInterface(Sender: TObject;Count : word);
var i,tev,l : integer;
    s : string;
    tablo : array[1..255] of byte;
begin
  MSCommUSBInterface.GetBlock(tablo,count);

  l:=Long_Recue; // r�sidu pr�c�dent � chainer - longueur du tampon

  i:=1;
  repeat
    // Affiche(intToSTR(tablo[i]),clYellow);
    if i+l<Long_tampon_interface then chaine_recue[i+l]:=tablo[i] else Affiche('Trop long',clred);
    inc(i);
  until (i+l>Long_tampon_interface) or (i>=255) or (i>count);

  Long_recue:=l+count;

  if traceTrames then
  begin
    if protocole=1 then AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+tablo_Hex(chaine_recue),Clwhite);
    if protocole=2 then
    begin
      s:='';
      for i:=1 to Long_Recue do
      if (chaine_recue[i]<>$0D) and (chaine_recue[i]<>$0A) then s:=s+char(chaine_recue[i]);
      AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+s,Clwhite);
    end;
  end;
//  chaine_recue:=interprete_reponse(chaine_recue);
  interprete_reponse;
end;

{$ELSE}

// �v�nement r�ception d'une trame sur le port COM USB centrale Xpressnet par TMSCOMM
procedure TFormPrinc.RecuInterface(Sender: TObject);
var i,tev,l : integer;
    tablo : array of byte;  // tableau rx usb
    s : string;
begin
  tev:=MSCommUSBInterface.commEvent;
  {
  // il n'y a pas d'evt de d�connexion !!
  Affiche('Evt '+intToSTR(tev),clOrange);
  Case tev of
    //liste des erreurs possibles
     comEventBreak : Affiche('Break',clOrange);     // On a re�u un signal d�interruption (Break)
     comEventCDTO  : Affiche('Timeout Porteuse',clOrange);     // Timeout de la porteuse
     comEventCTSTO : Affiche('Timeout signal CTS',clOrange);    // Timeout du signal CTS (Clear To Send)
     comEventDSRTO : Affiche('Timeout signal Rx',clOrange);    // Timeout du signal de r�ception
     comEventFrame : Affiche('Erreur trame',clOrange);     // Erreur de trame
     comEventOverrun : Affiche('Donn�es perdues',clOrange);   // Des donn�es ont �t� perdues
     comEventRxOver   : Affiche('Tampon Rx satur�',clOrange);  // Tampon de r�ception satur�
     comEventRxParity  : Affiche('111Erreur parit�',clOrange);    //Erreur de parit�
     comEventTxFull    : Affiche('Tampon Tx satur�',clOrange); //Tampon d�envoi satur�
     comEventDCB      : Affiche('Erreur DCB',clOrange); //Erreur de r�ception DCB (jamais vu)

    // liste des �v�nements normaux possibles
     comEvCD : Affiche('Chgt CD',clYellow);       //    ' Changement dans la broche CD (porteuse)
     comEvCTS: Affiche('Chgt CTS',clYellow);           // Changement dans broche CTS
     comEvDSR  : Affiche('Chgt DSR',clYellow);        // Changement dans broche DSR (r�ception)
     comEvRing : Affiche('Chgt RI',clYellow);         // Changement dans broche RING (sonnerie)
     comEvSend : Affiche('Car a envoyer',clYellow);   // Il y a des caract�res � envoyer
     comEvEOF  : Affiche('Recu EOF',clYellow);      //On a re�u le caract�re EOF
  end;}


  if tev=comEvReceive then
  begin
    tablo:=MSCommUSBInterface.Input;
    l:=long_recue; // r�sidu pr�c�dent � chainer - longueur du tampon
    i:=0;
    repeat
     // Affiche(intToSTR(tablo[i]),clYellow);
      if i+l+1<Long_tampon_interface then chaine_recue[i+l+1]:=ord(tablo[i]) else Affiche('Trop long',clred);
      inc(i);
    until (i+l+1>Long_tampon_interface) or (i>=length(tablo));

    Long_recue:=l+length(tablo);
    //chaine_recue[0]:=l+length(tablo);
    setlength(tablo,0);
    if traceTrames then
    begin
      if protocole=1 then AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+tablo_Hex(chaine_recue),Clwhite);
      if protocole=2 then
      begin
        s:='';
        for i:=1 to Long_Recue do
        if (chaine_recue[i]<>$0D) and (chaine_recue[i]<>$0A) then s:=s+char(chaine_recue[i]);
        AfficheDebug('Tick='+IntToSTR(tick)+'/Rec '+s,Clwhite);
      end;
    end;
    //chaine_recue:=interprete_reponse(chaine_recue);
    interprete_reponse;
  end;
end;
{$IFEND}

procedure TFormPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
var i,res : integer;
begin
  if TCO_modifie then
  begin
    res:=MessageDlg('Un des TCO a �t� modifi�. Voulez-vous les sauvegarder ?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if res=mrYes then sauve_fichiers_tco;
    if res=mrCancel then abort;
  end;
  if config_modifie then
  begin
    res:=MessageDlg('La configuration a �t� modifi�e. Voulez-vous la sauvegarder ?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if res=mrYes then sauve_config;
    if res=mrCancel then abort;
  end;
  if confasauver then sauve_config;
  if sauve_tco then sauve_fichiers_tco;

  for i:=1 to NbreTCO do
  begin
    if FormTCO[i]<>nil then FormTCO[i].Close;
  end;

  timer1.Enabled:=false;
  FermeSC:=true;
  UnHookWindowsHookEx(KBHook);  // supprimer le hook clavier

  if portCommOuvert and not(simuInterface) then
  begin
    portCommOuvert:=false;
    {$IF CompilerVersion >= 28.0}
    MSCommUSBInterface.open:=false;
    {$ELSE}
    MSCommUSBInterface.Portopen:=false;
    {$IFEND}
  end;
  // d�connecte les 10 p�riph�riques
  for res:=1 to 10 do
  begin
    i:=com_socket(res);
    if i=1 then deconnecte_USB_periph(res);
    if i=2 then deconnecte_socket_periph(res);
  end;
  ServerSocket.Close;
  ClientSocketCDM.close;
  {$IFDEF AvecIdTCP}
  ClientSocketIdInterface.Disconnect;
  ClientSocketIdInterface.Free;
  {$ELSE}
  ClientSocketInterface.close;
  {$ENDIF}
  clientInfo.Close;
end;

// appell� sur r�ception trame train CDM
// v�rifie qu'un train est dans l'horaire de d�part
procedure verifie_train_horaire(adresse : integer;train : string;vitesse : integer);
var i : integer;
    sens : boolean;
begin
  if vitesse>0 then
  for i:=1 to MaxHoraire do
  begin
    if (grilleHoraire[i].NomTrain=train) and (grilleHoraire[i].arretDepart) then
    begin
      if ( (grilleHoraire[i].heure<heure) or
          ((grilleHoraire[i].heure=heure) and (grilleHoraire[i].minute>minute))
         ) and (seconde<10) then
      begin
        Affiche('Arr�t du train '+Train+' hors horaire',clOrange);
        sens:=true;
        vitesse_loco(train,i,adresse,0,10,0);
      end;
    end;
  end;
end;

// appel� par le timer, si l'horloge tourne
procedure gestion_horaire;
var n,i,j,indexTrain,vitesse : integer;
   traite,trouve : boolean;
   train,route : string;
begin
  // d�marrage des trains � l'horaire
  for i:=1 to MaxHoraire do
  begin
    if (grilleHoraire[i].heure=heure) and (grilleHoraire[i].minute=minute) then
    begin
      train:=grilleHoraire[i].NomTrain;
      indexTrain:=index_train_nom(train);
      traite:=true;
      if indexTrain>0 then
      begin
        if roulage then
        begin
          traite:=trains[indexTrain].roulage>0;
        end;

        if traite then
        begin
          vitesse:=grilleHoraire[i].vitesse;
          if not(grilleHoraire[i].sens) then vitesse:=-vitesse;
          Affiche('D�marrage train '+train+' � l''horaire '+format('%.2dh%.2d',[heure,minute]),clyellow);
          // &&& voir pour la couleur
          FormFicheHoraire.StringGridFO.Cells[1,i]:=GrilleHoraire[i].NomTrain;

          Demarre_index_train(indextrain);
          route:=grilleHoraire[i].route;
          if route<>'' then
          begin
            // trouver la route dans la liste des routes sauvegard�es du train
            n:=trains[indexTrain].routePref[0][0].adresse;  // nombre de routes sauvegard�es du train
            j:=1;
            trouve:=false;
            while not(trouve) and (j<=n) do
            begin
              trouve:=Trains[indexTrain].NomRoute[j]=route;
              inc(j);
            end;
            if trouve then
            begin
              dec(j); //j est l'index de la route dans le train
              // affecte la route au train
              Affiche('La route est : '+route,clYellow);
              trains[indexTrain].route:=trains[indexTrain].routePref[j];   // copier la route dans le train
              trains[indexTrain].route[0].talon:=grilleHoraire[i].sens;    // copier le sens
              aig_canton(indexTrain,trains[indexTrain].route[1].adresse);  // positionne aiguillage et fait les r�servations
            end;
          end;
        end;
      end;
   end;
  end;

  // �v�nements actionneurs horaires
  for i:=1 to maxTablo_act do
  begin
    if Tablo_Action[i].declencheur=DeclHorloge then
    begin
//      affiche(intToSTR(Tablo_Action[i].adresse)+' '+Tablo_Action[i].,clLime);
      if (Tablo_Action[i].heure=heure) and (Tablo_Action[i].minute=minute) then
      begin
        action(i);
      end;
    end;
  end;
end;

// equation droite
procedure equation_droite(y1,y2,x1,x2 : single;var pente,b : single);
begin
  if x2-x1<>0 then pente:=(y2-y1)/(x2-x1) else pente:=9999;
  b:=y1-pente*x1;
end;



// calcule les 2 �quations de droite des coefficients
// pour les �talonnages des trains
procedure calcul_equations_coeff(indexTrain : integer);
begin
  with trains[indexTrain] do
  begin
    equation_droite(CoeffV1,CoeffV2,ConsV1,ConsV2,pente1,b1);
    equation_droite(CoeffV2,CoeffV3,ConsV2,ConsV3,pente2,b2);
  end;
  courbe_train(indexTrain);
end;

// traite les taches par le timer
// tableau taches[].typeTache
//               [].chaine
//               [].tempo
procedure traite_taches;
const affe=false;
var fonc,i,j,sortie,etat :integer;
begin
  if noTraite then exit;
  if pointeurTaches<0 then
  begin
    pointeurTaches:=0;
    exit;
  end;
  //if affe then Affiche('Tick='+intToSTR(tick)+' Pointeur de taches='+intToSTR(pointeurTaches),clYellow);
  // pilote accessoire
  i:=1;
  //repeat
    with taches[i] do
    begin
      //if affe then Affiche('Traite adr '+intToSTR(Typetache),clLime);
      if traite then
      begin
        if affe then Affiche('Traite 1 en cours',clblue);
        exit;
      end;
      // si tempo non nulle de fin d'accessoire
      if (typeTache=ttacheAcc) and (tempo<>0) then
      begin
        if affe then Affiche('dec tempo ',clLime);
        dec(tempo);
        exit;  // ne rien faire d'autre dans ce tour timer
      end
      else
      if (TypeTache=ttacheTempo) then
      begin
        if affe then Affiche('Dec tempo fin aig',clLime);
        if tempo<>0 then dec(tempo);
        if tempo=0 then
        begin
          if affe then Affiche('dec tempo fin aig',clLime);
          for j:=i to pointeurTaches do
          begin
            taches[j]:=taches[j+1];
          end;
          dec(pointeurtaches);
        end;
        exit;
      end
      else
      begin
        // ------------ envoyer au destinataire -------------
        // pilotage accessoire
        if typetache=ttacheACC then
        begin
          traite:=true;
          if dest=ttDestCDM then
          begin
            if affe then Affiche(chaine,clyellow);
            envoi_cdm(chaine);    // cdm taches[].chaine
          end;
          if dest=ttDestXpressNet then
          begin
            envoi_ss_ack(chaine); // xpressnet
            if affe then
            begin
              adresse:=4*ord(chaine[2]) ;
              fonc:=((ord(chaine[3]) shr 1) and 3);
              adresse:=adresse+fonc+1;
              sortie:=(ord(chaine[3]) and 1) +1;
              etat:=(ord(chaine[3]) and $08) div 8;
              Affiche(chaine_HEX(chaine),clYellow);
              Affiche('adr='+intToSTR(adresse)+' Sortie '+intToSTR(sortie)+' �tat = '+intToSTR(etat),clyellow);
            end;
          end;
          if dest=ttDestDccpp then envoi_ss_ack(chaine);

          // lorsque l'action i est trait�e, la supprimer, et d�caler la liste des taches d'un cran
          for j:=i to pointeurTaches do
          begin
            taches[j]:=taches[j+1];
          end;
          dec(pointeurtaches);
          exit;
        end;

        // vitesse ou fonctionF
        if (typeTache=ttacheVit) or (typetache=ttacheFF) then
        begin
          if dest=ttDestCDM then
          begin
            if affe then Affiche(chaine,clyellow);
            envoi_cdm(chaine);    // cdm taches[].chaine
          end;
          if dest=ttDestXpressNet then
          begin
            envoi_ss_ack(chaine); // xpressnet
            if affe then Affiche(chaine_HEX(chaine),clYellow);
          end;
          if dest=ttDestDccpp then
          begin
            envoi_ss_ack(chaine);
          end;
          // lorsque l'action 1 est trait�e, la supprimer, et d�caler la liste d'un cran
          for j:=i to pointeurTaches do
          begin
            taches[j]:=taches[j+1];
          end;
          dec(pointeurtaches);
          exit;
        end;

      end;
     //affiche('Pointeur='+intToSTR(pointeurtaches),clred);
    end;
    Affiche('Erreur tache typ='+intTOSTR(taches[1].typeTache)+' t='+intToSTR(taches[1].tempo),clred);
    exit;
    inc(i);
    Affiche('INC',clwhite);
  //until (i>pointeurtaches);
end;

// timer � 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var n,i,j,a,d,longueur,adresseEl,TailleX,TailleY,orientation,indexTCO,x,y,Bimage,aspect,
   IdDet,longDet,LongLoco,distArret,vitcons,vitesseABS,delta : integer;
   imageSignal : Timage;
   frx,fry : single;
   incrementPas,tempsArret,coeff,vitR : single;
   faire : boolean;
   h,m,sec,ms : word;
   s : string;
begin
  inc(tick);

  //if tick<10 then Affiche(intToSTR(scrollBoxSig.width)+' '+inttostr(scrollBoxC.width),clred);

  if pointeurTaches>0 then Traite_taches;

  // vitesses par bloc USB
  if tempoBlocUSB>0 then
  begin
    case TempoBlocUSB of
    // consigne sur train cliqu�
    1,2 : consigne_train(2);  // 2=la consigne vient de bloc U
    // consigne sur train demand�
    3 : begin
          vitesse_loco(trains[idTrainF3].nom_train,idTrainF3,trains[idTrainF3].adresse,trains[idTrainF3].vitesseCons,10,consigneBLocUSB);
        end;
    end;
    tempoblocUSB:=0;
  end;

  // s�quencement des actions apr�s tempo
  if index_seqAct>0 then
  begin
    if seq_actions[index_seqAct].tick=tick then
    begin
      i:=seq_actions[index_seqAct].indiceAction;
      j:=seq_actions[index_seqAct].IndiceOp;
      n:=Tablo_Action[i].NbOperations;
      dec(index_seqAct);
      a:=j;
      repeat
        Affiche('Faire action s�quenc�e '+intToSTR(i)+' op '+intToSTR(a),clLime);
        Action_operation(i,a);
        faire:=(Tablo_Action[i].TabloOp[a].numoperation=ActionTempo);
        inc(a);
      until (a>n) or faire;
    end;
  end;

  // --- horloge syst�me
  if horloge then
  begin
    inc(comptSec);
    if not(horlogeInterne) then
    begin
      if ComptSec>=9 then
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
            init_horloge;
            Affiche('Horloge en initialisation',clyellow);
            if not(relanceHorl_init) then
            begin
              horloge:=false;
              Affiche('Arr�t horloge',clyellow);
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
    // raz du flag "fenetre confcellTCO affich�e"
    ConfCellTCO:=false;
  end;

  // envoi timeout socket ethernet centrale lenz
  if parSocketLenz and (AntiTimeoutEthLenz=1) then
  begin
    dec(TpsTimeoutSL);
    if TpsTimeoutSL<=0 then
    begin
      TpsTimeoutSL:=450;  // envoyer caract�re toutes les 45 secondes
      // indy
      {$IFDEF AvecIdTCP}
      s:=' ';
        {$IF CompilerVersion >= 28.0}
        ClientSocketIdInterface.IoHandler.write(RawToBytes(s,1),1);
        {$ELSE}
        ClientSocketIdInterface.Socket.Send(s,1)
        {$IFEND}
      {$ELSE}
      ClientSocketInterface.Socket.SendText(' ');
      {$ENDIF}
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
      a:=Signaux[i].EtatSignal;     // a = �tat binaire du signal
      adresseEl:=Signaux[i].adresse;
      // signal belge
      if Signaux[i].aspect=20 then
      begin
        // signal belge
        if TestBit(a,clignote) or Signaux[i].contrevoie then
        begin
          Dessine_signal_mx(Signaux[i].Img.Canvas,0,0,1,1,adresseEl,1);
        end;
      end
      else
      begin
        // signal fran�ais
        if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
           TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
           testBit(a,vert_cli)  or testbit(a,blanc_cli) then
           begin
             Dessine_signal_mx(Signaux[i].Img.Canvas,0,0,1,1,adresseEl,1);
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
            adresseEl:=TCO[indexTCO,x,y].adresse;
            i:=Index_Signal(adresseEl);
            a:=Signaux[i].EtatSignal;     // a = �tat binaire du signal
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
              aspect:=Signaux[Index_Signal(adresseEl)].Aspect;
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
              // r�duction variable en fonction de la taille des cellules
              calcul_reduction(frx,fry,LargeurCell[indexTCO],HauteurCell[indexTCO]);
              Dessine_signal_mx(PCanvasTCO[indexTCO],tco[indexTCO,x,y].x,tco[indexTCO,x,y].y,frx,fry,adresseEl,orientation);
            end;
          end;
        end;
      end;
    end;

    // fen�tre de pilotage manuel du signal -------------------
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
  end;

  // tempo retomb�e actionneur
  for i:=1 to maxTablo_act do
  begin
    n:=Tablo_Action[i].NbOperations;
    for j:=1 to n do
    begin
      a:=Tablo_Action[i].TabloOp[j].TempoCourante;
      if a<>0 then
      begin
        dec(a);
        Tablo_Action[i].TabloOp[j].TempoCourante:=a;
        if a=0 then
        begin
          x:=Tablo_Action[i].TabloOp[j].numoperation;
          case x of
            actionFonctionF :
            begin
              s:=Tablo_Action[i].tabloOp[j].trainCourant;
              //Affiche('Action TrainDest='+s+' F'+IntToSTR(Tablo_Action[i].TabloOP[j].fonctionF)+':0',clyellow);
              Affiche('Action TrainDest='+s+' F'+format('%d',[Tablo_Action[i].TabloOP[j].fonctionF])+':0',clyellow);
              envoie_fonction(Tablo_Action[i].tabloOP[j].fonctionF,0,s);
            end;
            actionTempo :
            begin
              Affiche('Fin temporisation action '+intToSTR(i)+' Op '+intToSTR(j)+' '+Tablo_Action[i].NomAction,clYellow);
            end;
          end;
        end;
      end;
    end;
  end;


  // if (tick mod 10)=0 then Affiche(intToSTR(trains[4].TempoArretCour),clWhite);
  for i:=1 to ntrains do
  begin
    // change l'aiguille du compteur de vitesse du train i
    with trains[i] do
    begin
      delta:=vitesseCons-VitesseCompteur;   // diff�rence entre la vitesse � atteindre et l'actuelle
      if delta<>0 then
      begin
        //Affiche('Delta '+intToSTR(Delta),clYellow);
        a:=abs(delta);
        if a>10 then IncrCompteur:=3 else IncrCompteur:=1;
        if a<IncrCompteur then vitesseCompteur:=vitesseCons;
        if a>=IncrCompteur then
          if vitesseCompteur<vitesseCons then
          begin
            inc(vitesseCompteur,IncrCompteur);
            //Affiche('Apr�s + '+intToSTR(vitesseCompteur),clYellow);
          end
          else
          begin
            dec(vitesseCompteur,IncrCompteur);
            //Affiche('Apr�s - '+intToSTR(vitesseCompteur),clYellow);
          end;

        //Affiche('Appel '+intToSTR(vitesseCompteur),clYellow);
        aiguille_compteur(1,idTrainClic,formCompteur[1]); // fenetre
        aiguille_compteur(i,i,compteurT[i].gb);  // compteurs des groupbox
      end;

      // calculer la vitesse instantan�e du train en fonction des accel et des d�cel
      if vitesseCons<>AVitesseCons then
      begin
        // m�moriser changement de consigne vitesse
        AncVitesseCons:=AvitesseCons;  // ancienne vitesse conserv�e
        //Affiche('Ancienne vitesse='+intToSTR(ancVitesseCons),clYellow);
        AVitesseCons:=vitesseCons;    // ancienne vitesse du tick pr�c�dent
      end;

      // calcul vitesse r�elle instantan�e en crans, tenant compte des accel et d�cel
      if (vitesseReelle<>VitesseCons) then
      begin
        IncrementPas:=0;
        if (cv3<>0) and (AncVitesseCons<VitesseCons) and (vitesseReelle<vitesseCons) then
        begin
          // IncrementPas:=(128*0.1)/(0.896*cv3);   // acc�l�ration
          IncrementPas:=128/(8.96*cv3);   // nombre de pas � incr�menter toutes les 1/10 de s
          VitesseReelleR:=vitesseReelleR+Incrementpas;
          if VitesseReelleR>VitesseCons then VitesseReelleR:=VitesseCons;
          VitesseReelle:=round(vitesseReelleR);
        end
        else
        if (cv4<>0) and (AncVitesseCons>VitesseCons) and (vitesseReelle>vitesseCons) then
        begin
          //IncrementPas:=(128*0.1)/(0.896*cv4);   // d�c�l�ration
          IncrementPas:=128/(8.96*cv4);   // nombre de pas � d�cr�menter toutes les 1/10 de s
          VitesseReelleR:=round(vitesseReelleR-Incrementpas);
          if VitesseReelleR<VitesseCons then VitesseReelleR:=VitesseCons;     // en crans
          VitesseReelle:=round(vitesseReelleR);
        end
        else
          //vitesseReelle:=VitesseCons;
      end;

      //if vitesseReelle<>0 then Affiche('Vitesse r�elle '+intToSTR(vitesseReelle)+' crans',clOrange);

      // arret loco sur n secondes
      // d�marrage loco temporis�
      // renvoi de la consigne
      // l'index de train 0 est le train courant
      // mesure temps de parcours et distance d'un train sur d�tecteur � 1
      j:=detecteurA;
      if j<>0 then
      begin
        if detecteur[j].Etat then
        begin
          d:=abs(distance_temps_incr(1,i));     // distance incr�mentale en mm sur d�tecteur : distance additionn�e tous les 1/10 seconde
          detecteur[j].distCour:=d;
          //Affiche('DistInc='+intToSTR(d),clWhite);
        end;

        if detecteur[j].Temps_cour<>0 then
        begin
          inc(detecteur[j].Temps_cour);
          if trains[i].vitesseCons=0 then detecteur[j].Temps_cour:=0;   // impossible de mesurer vitesse train si elle est nulle
        end;
      end;

      // gestion ralenti : on doit arreter le train sur le d�tecteur
      if trains[i].arret_det then   // le train est sur un d�tecteur d'arr�t
      begin
        //Affiche('Ralenti train '+intToSTR(i),clYellow);
        adresseEl:=dernierDet; // identifie le d�tecteur
        if adresseEl<>0 then
        case phase_arret of   // !! voir si phase arret est multitrains!!!
          0 : begin
                //if debugroulage then Affiche('Phase arret 0',clred);
                vitesseCons:=VitRalenti div 2;
                if route[0].talon then vitesseCons:=-vitesseCons;
                vitesse_loco(nom_train,i,trains[i].adresse,vitesseCons,3,0);  // r�p�tition dans 0,3 s
                phase_arret:=1;
              end;
          1 : begin
                //if debugroulage then Affiche('Phase arret 1',clred);
                //inc(detecteur[adresseEl].temps);
                if vitesseReelle<>0 then
                begin
                  if CV4<>0 then d:=d div 10; // distance mesure incr�mentale en cm, calcul�e plus haut
                  //else d:=abs(round(detecteur[adresseEl].temps_cour*90/vitesseReelle)) // distance parcourue depuis l'arriv�e sur le d�tecteur
                end
                else d:=9999;   // si la vitesse du train est nulle, mettre une condition qui arrete le train en fin de parcours sur le d�tecteur
                if not detecteur[adresseEl].Etat then d:=9999; // si on passe le d�tecteur arr�ter le train.
                if DebugRoulage then Affiche('D='+intToSTR(d)+' train '+intToSTR(i),clOrange);

                // arr�t
                //if debugRoulage then Affiche('Timer Dist='+intToSTR(d)+' Vit='+intToSTR(trains[i].vitesseReelle),clYellow);
                longDet:=detecteur[adresseEl].longueur;
                LongLoco:=trains[i].longueur;
                longueur:=longDet-longLoco;
                CompteurT[i].lbl.Caption:=trains[i].nom_train+' '+intToSTR(d);
                // calculer quelle distance il faudra pour s'arr�ter avec la d�c�l�ration
                 TempsArret:=abs(0.896*cv4*VitesseCons/128);
                 // convertir la vitesse en cran en cm/s
                 VitesseAbs:=abs(VitesseCons);
                 if vitesseAbs<consV2 then coeff:=pente1*vitesseAbs+b1
                   else coeff:=pente2*vitesseAbs+b2;
                 if coeff<>0 then vitR:=vitesseAbs/coeff else vitR:=0;
                 distArret:=round(TempsArret*vitR/2.2);   // en cm    2.2 est empirique

                //Affiche('Vreelle='+intToSTR(round(VitR))+' Dist arret='+intToSTR(DistArret),clRed);

                //                                              long du det      distance dynamique
                if ( (detecteur[adresseEl].modeArret<=1) and (d>=(longDet-detecteur[adresseEl].distArret-distArret)) ) or    // arret en fin
                   ( (detecteur[adresseEl].modeArret=2) and (d>=(longDet div 2)) )  then                         // arret au milieu

              {if ((d>longueur-5) and (longueur>0)) or
                 ((d>10) and (longueur=0)) then   }
                begin
                  //Affiche('TempsArret='+FloatToSTRF(TempsArret,ffFixed,5,2)+' Vreelle='+intToSTR(round(VitR))+' Dist arret='+intToSTR(DistArret),clRed);
                  trains[i].TempoArretCour:=0;
                  trains[i].arret_det:=false;
                  trains[i].phase_arret:=0;
                  if debugRoulage then Affiche('Timer '+trains[i].nom_train+' Arr�t�',ClWhite);
                  CompteurT[i].lbl.Caption:=trains[i].nom_train;
                  trains[i].vitesseCons:=0;
                  vitesse_loco(trains[i].nom_train,i,trains[i].adresse,0,0,0);  // arr�t du train
                  train_sarrete(i);   // v�rifie si fin de route, et copie tempo_demarre si d�tecteur arr�t optionnel+ tempo de red�marrage
                end;
              end;
        end  // case
        else
        begin
          if DebugRoulage then Affiche('Erreur 682 : adresse detecteur nul train '+Trains[i].nom_train,clred);
        end;
      end; // fin du ralenti

      // d�marrage sur tempo
      a:=trains[i].TempoDemarre;
      if a<>0 then
      begin
        if debugRoulage then Affiche('Timer tempo d�marre '+intToSTR(a)+' '+intToSTR(trains[i].TempsDemarreSig-5),clWhite);
        if a=(trains[i].TempsDemarreSig*10)-5 then  // renvoi consigne d'arret 5x1/10 de secondes apres
        begin
          vitesse_loco(trains[i].nom_train,i,trains[i].adresse,0,0,0);   // vitesse nulle
        end;

        dec(a);
        if a mod 10=0 then Affiche_temps_arret(i,a);  // affiche le temps d'arr�t sur le canton
        trains[i].TempoDemarre:=a;
        if a=0 then  // fin de la tempo d'arr�t: on red�marre!
        begin
          vitcons:=trains[i].VitNominale;
          if trains[i].roulage<>0 then if trains[i].route[0].talon then vitcons:=-vitCons;
          trains[i].vitesseCons:=vitCons;

          //if (trains[i].inverse) then trains[i].vitesseCons:=-trains[i].vitesseCons;
          vitesse_loco(trains[i].nom_train,i,trains[i].adresse,vitcons,0,0);
        end;

        // d�marrage sur consigne ou r�p�tition de la consigne
        a:=trains[i].compteur_consigne;
        if a<>0 then
        begin
          dec(a);
          //Affiche('consigne '+intToSTR(a),clWhite);
          trains[i].compteur_consigne:=a;
          if a=0 then
          begin
            //trains[i].vitesseCons:=trains[i].VitesseCons;
           vitesse_loco(trains[i].nom_train,i,trains[i].adresse,trains[i].vitesseCons,0,0);
          end;
          //Affiche('vitesse ' +intToSTR(i)+' '+intToSTR(trains[i].vitesse),clred);
        end;
      end; // fin d�marre sur tempo
    end; // fin du with
  end;  // fin de la boucle de trains

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

      // evt d�tecteur ?
      if Tablo_simule[I_simule].modele=det then
      begin
        s:='Simu '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' det='+intToSTR(Tablo_simule[i_simule].adresse)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Detecteur(Tablo_simule[i_simule].adresse, Tablo_simule[i_simule].etat=1, Tablo_simule[i_simule].train);  // cr�er �vt d�tecteur
        StatusBar1.Panels[1].text:=s;
        Affiche(s,clyellow);
      end;

      // evt actionneur ?
      if Tablo_simule[I_simule].modele=act then
      begin
        s:='Simu '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' act='+intToSTR(Tablo_simule[i_simule].adresse)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Act(Tablo_simule[i_simule].adresse,0,Tablo_simule[i_simule].etat, Tablo_simule[i_simule].train);
        StatusBar1.Panels[1].text:=s;
        //Affiche(s,clyellow);
      end;

      // evt aiguillage ?
      if Tablo_simule[I_simule].modele=aig then
      begin
        s:='Simu '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' aig='+intToSTR(Tablo_simule[i_simule].adresse)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Aig(Tablo_simule[i_simule].Adresse,Tablo_simule[i_simule].etat);  // cr�er �vt aiguillage
        StatusBar1.Panels[1].text:=s;
        Affiche(s,clyellow);
      end;

      inc(i_simule);
      if i_Simule>Index_simule then
      begin
        Index_Simule:=0;  // fin de simulation
        I_Simule:=0;
        MsgSim:=false;
        Affiche('Fin de simulation',clCyan);
        StatusBar1.Panels[1].text:='';
        ButtonArretSimu.Visible:=false;
      end;
    end;
    inc(intervalle_courant);
  end;

  // temporisation d�tecteur � 0
  for i:=1 to NDetecteurs do
  begin
    adr:=Adresse_detecteur[i];
    if detecteur[adr].Etat then inc(detecteur[adr].ComptCour);  // pour affichage du temps d�tecteur � 1
    a:=detecteur[adr].tempo0;
    if a<>0 then
    begin
      dec(a);
      detecteur[adr].tempo0:=a;
      if (a=0) then
      begin
        detecteur[adr].tempo0:=99;   // indicateur tempo �chue
        event_detecteur(adr,false,detecteur[adr].train);
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
    s:='Accessoire '+IntToSTR(adr)+' droit';
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
    s:='Accessoire '+IntToSTR(adr)+' d�vi�';
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
             s:=s+': Connexion avort�e - Timeout';
             deconnecte_cdm;
           end;
   10054 : s:=s+': Connexion avort�e par un tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
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
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
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


// proc�dure Event appel�e si on clique sur un checkbox de demande de feu blanc des images des feux
procedure TFormprinc.proc_checkBoxFB(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat : word;
    aspect,combine,adresse : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;         // �tat de la checkbox
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
    // si pas coch�, on revient en normal
    if not(coche) then Maj_Signaux(false);
  end;
end;

// proc�dure Event appel�e si on clique sur un checkbox de demande de feu vert des images des feux
procedure TFormprinc.proc_checkBoxFV(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat,adresse : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;       // �tat de la checkbox
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
    // si pas coch�, on revient en normal
    if not(coche) then Maj_Signaux(false);
  end;
end;

// proc�dure Event appel�e si on clique sur un checkbox de demande de feu blanc des images des feux
procedure TFormprinc.proc_checkBoxFR(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat,adresse : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;         // �tat de la checkbox
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
    // si pas coch�, on revient en normal
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
    if not simuInterface then
    begin
      {$IF CompilerVersion >= 28.0}
      MSCommUSBInterface.open:=false;         // AsyncPro
      {$ELSE}
      MSCommUSBInterface.Portopen:=false;     // Tmscomm
      {$IFEND}
    end;
    Affiche('Port USB d�connect�',clyellow);
    Formprinc.StatusBar1.Panels[3].Text:='';
  end;

  portCommOuvert:=false;
  with formprinc do
  begin
    {$IFDEF AvecIdTCP}
    ClientSocketIdInterface.Disconnect;
    {$ELSE}
    ClientSocketInterface.close;
    {$ENDIF}
    MenuConnecterUSB.enabled:=true;
    DeConnecterUSB.enabled:=false;
    ConnecterCDMRail.enabled:=true;
    DeConnecterCDMRail.enabled:=false;
  end;
end;

// d�connecte le p�riph�rique n�index
procedure deconnecte_usb_periph(index : integer);
var n : integer;
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 61 : num�ro de p�riph�rique hors limite ',clred);
    exit;
  end;
  if tablo_periph[index].PortOuvert then
  begin
    tablo_periph[index].PortOuvert:=false;
    n:=Tablo_periph[index].numComposant;
    {$IF CompilerVersion >= 28.0}
    if n=1 then MscommCde1.open:=false;
    if n=2 then MscommCde2.open:=false;
    {$ELSE}
    if n=1 then MscommCde1.Portopen:=false;
    if n=2 then MscommCde2.Portopen:=false;
    {$IFEND}
    
    if debug>0 then Affiche('Port COM'+intToSTR(Tablo_periph[index].NumCom)+' p�riph�rique d�connect�',clyellow);
    Formprinc.StatusBar1.Panels[3].Text:='';
  end;
end;

// d�connecte le p�riph�rique socket
procedure deconnecte_socket_periph(index : integer);
begin
  if (index>NbMaxi_Periph) or (index=0) then
  begin
    Affiche('Erreur 627 : num�ro de p�riph�rique hors limite ',clred);
    exit;
  end;
  if tablo_periph[index].PortOuvert then
  begin
    tablo_periph[index].PortOuvert:=false;
    if index=1 then Formprinc.ClientSocketCde1.close;
    if index=2 then Formprinc.ClientSocketCde1.close;
    if debug>0 then Affiche('Socket '+intToSTR(Tablo_periph[index].NumCom)+' p�riph�rique d�connect�',clyellow);
    Formprinc.StatusBar1.Panels[3].Text:='';
  end;
end;

procedure TFormPrinc.DeconnecterUSBClick(Sender: TObject);
begin
  deconnecte_usb;
end;

procedure deconnecte_interfaceEth;
begin
  {$IFDEF AvecIdTCP}
  ClientSocketIdInterface.disconnect;
  {$ELSE}
  ClientSocketInterface.Close;
  {$ENDIF}
end;

procedure TFormPrinc.MenuConnecterEthernetClick(Sender: TObject);
begin
  deconnecte_interfaceEth;
  connecte_interface_ethernet;
end;

procedure TFormPrinc.MenuDeconnecterEthernetClick(Sender: TObject);
begin
  Affiche('D�connexion interface ethernet',clyellow);
  deconnecte_interfaceEth;
end;

procedure TFormPrinc.AffEtatDetecteurs(Sender: TObject);
var j,adr,adrTrain : integer;
    c : tcolor;
    s : string;
begin
  Affiche('Etat des d�tecteurs:',ClLime);
  nbDet1:=0;
  for j:=1 to NDetecteurs do
  begin
    adr:=Adresse_detecteur[j];
    s:='D�t '+intToSTR(adr)+'=';
    if Detecteur[adr].etat then
    begin
      s:=s+'1 ';
      c:=clWhite;
      inc(NbDet1);
    end
    else
    begin
      s:=s+'0 ';
      c:=clyellow;
    end;

    s:=s+detecteur[adr].train;
    AdrTrain:=detecteur[adr].AdrTrain;
    if AdrTrain<>0 then s:=s+' @='+intToSTR(AdrTrain);
    AdrTrain:=detecteur[adr].IndexTrainRoulant;
    if AdrTrain<>0 then s:=s+' IndexTrain='+intToSTR(AdrTrain);
    s:=s+' Prec='+intToSTR(detecteur[adr].precedent);
    s:=s+' Suiv='+intToSTR(detecteur[adr].suivant);

    AdrTrain:=detecteur[adr].AdrTrainRes;
    if AdrTrain<>0 then s:=s+' @RES='+intToSTR(AdrTrain);

    Affiche(s,c);
  end;
  Affiche('Nombre de d�tecteurs � 1 :'+intToSTR(NbDet1),clyellow);
end;

procedure TFormPrinc.Etatdesactionneurs1Click(Sender: TObject);
var j : integer;
    s : string;
begin
  Affiche('Etat des actionneurs',clYellow);
  for j:=1 to Nactionneurs do
  begin
   // if detecteur[j].index<>0 then
   // if actionneur[j].etat then
   s:='Act '+intToSTR(j)+' '+intToSTR(actionneur[j].adresse)+' ';
   if actionneur[j].etat then s:=s+'1' else s:=s+'0';
   s:=s+actionneur[j].train;
   Affiche(s,clyellow);
  end;
end;

// trouve l'index du d�tecteur de. Si pas trouv�, renvoie 0
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
          const_devie : s:=s+' d�vi�' ;
          const_droit : s:=s+' droit';
          const_inconnu : s:=s+' inconnue';
          else s:=s+' erreur ('+intToSTR(pos)+')';
        end;
      end;

      if model=triple then // aig triple
      begin
        j:=aiguillage[i].AdrTriple;
        s:=s+' Aig '+IntToSTR(j)+': '+intToSTR(aiguillage[j].position)+' ';
        if aiguillage[j].position=const_devie then s:=s+' (d�vi�)' else s:=s+' (droit)';
      end;

      if (model=Crois) then s:='Croisement '+IntToSTR(aiguillage[i].Adresse);

      r:=aiguillage[i].AdrTrain;
      if r<>0 then s:=s+'     R�serv� par train @'+intToSTR(r);
      if s<>'' then Affiche(s,clWhite);
    end;
  end;
end;

procedure TFormPrinc.Codificationdesaiguillages1Click(Sender: TObject);
var i,adr : integer ;
    s : string;
begin
  Affiche('Codification interne des aiguillages',clCyan);
  Affiche('D=position droite S=position d�vi�e P=pointe Z=d�tecteur',clCyan);
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
        s:=s+intToSTR(aiguillage[i].EtatTJD)+' �tats ';
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
        s:=s+' D�vie='+IntToSTR(aiguillage[i].ADevie)+aiguillage[i].ADevieB+
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
      if aiguillage[i].modele=triple then s:=s+' D�vi�2='+intToSTR(aiguillage[i].ADevie2)+aiguillage[i].ADevie2B;
      if aiguillage[i].vitesse<>0 then s:=s+' Vitesse d�vi�e='+intToSTR(aiguillage[i].vitesse);
      if aiguillage[i].inversionCDM<>0 then s:=s+' pilotage invers�';

      Affiche(s,clYellow);
    end;
  end;
end;

// connnecter le socket de interface vers la centrale
procedure TFormPrinc.ClientSocketInterfaceConnect(Sender: TObject;Socket: TCustomWinSocket);
var trouve : boolean;
begin
  Affiche('Socket interface connect� ',clYellow);
  AfficheDebug('Socket interface connect� ',clYellow);
  ButtonEcrCV.Enabled:=true;
  ButtonLitCV.Enabled:=true;
  LireunfichierdeCV1.enabled:=true;
  LabelTitre.caption:=titre+' Interface connect�e par Ethernet';
  Formprinc.StatusBar1.Panels[4].Text:=AdresseIP;
  etat_init_interface:=11; // socket connect�
  trouve:=test_protocole; // appelle l'�tat des d�tecteurs

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
    // interface ethernet connect�e, faire les init
    init_aig_det;
  end;
  {$IFNDEF AvecIdTCP}
  if not(trouve) then ClientSocketInterface.Close;
  {$ENDIF}
end;

// CDM rail se connecte
procedure TFormPrinc.ClientSocketCDMConnect(Sender: TObject;Socket: TCustomWinSocket);
var s : string;
begin
  s:='Socket CDM rail connect�';
  LabelTitre.caption:=titre+' '+s;
  Affiche(s,clYellow);
  StatusBar1.Panels[2].Style:=psOwnerDraw;  // permet de d�clencher l'event onDrawPanel
  StatusBar1.Panels[2].text:=' CDM connect�';
  CDM_connecte:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  DeConnecterCDMRail.enabled:=true;
end;


// d�codage d'une trame CDM au protocole IPC (COMIP)
// la trame_CDM peut contenir 2000 caract�res � l'initialisation du RUN.
procedure Interprete_trameCDM(trame_CDM:string);
var i,j,objet,k,l,erreur,posErr,adr,adr2,etat,etataig,
    vitesse,etatAig2,name,prv,nbre,nbreVir,long,index,posDes,AncNumTrameCDM,idt : integer ;
    x,y,x2,y2 : longint ;
    nom,s,ss,train,commandeCDM : string;
    traite,sort,trouve : boolean;
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
    // trouver la longueur de la cha�ne de param�tres entre les 2 premiers |xxx|
    i:=pos('|',trame_CDM);
    if i=0 then
    begin
      if debugTrames then
      begin
        Affiche('tronqu�1 : '+trame_CDM,clred);
        AfficheDebug('tronqu�1 : '+trame_CDM,clyellow);
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
        Affiche('tronqu�2 : '+trame_CDM,clRed);
        AfficheDebug('tronqu�2 : '+trame_CDM,clyellow);
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
      if (pos('DSCTRN-__END',trame_cdm)<>0) and (ntrains_CDM<>0) then
      begin
        //fin de la description des trains
        FormPrinc.ComboTrains.Items.Clear;

        // on remplace les trains du combo et de la base (non stock�e)
        // dans la m�me adresse que l'existante
        // ne pas �craser j
        for i:=1 to ntrains_cdm do
        begin
          l:=1;
          repeat
            trouve:=trains[l].adresse=trains_cdm[i].adresse;
            if trouve then   // si l'adresse du train CDM est d�ja existante on copie le train CDM dans le train SC
            begin
              //affiche('train '+intToSTR(trains_cdm[i].adresse)+' trouv� dans l''existant',clLime);
              Formprinc.ComboTrains.Items.Add(trains_cdm[i].nom_train);
              Trains[l].nom_train:=trains_cdm[i].nom_train;
              Trains[l].adresse:=Trains_cdm[i].adresse;
              Trains[l].vitmax:=Trains_cdm[i].vitmax;
            end;
            inc(l);
          until (l>ntrains) or trouve;

          if not(trouve) then // si pas trouv� le train dans SC, on cr��e le train
          begin
            inc(ntrains);
            //affiche('train '+intToSTR(trains_cdm[i].adresse)+' cr��',clLime);
            Trains[ntrains].nom_train:=trains_cdm[i].nom_train;
            Trains[ntrains].adresse:=Trains_cdm[i].adresse;
            Trains[ntrains].vitmax:=Trains_cdm[i].vitmax;
            FormPrinc.ComboTrains.Items.Add(trains_cdm[i].nom_train);
            cree_image_Train(ntrains);
            cree_GB_compteur(ntrains);
          end;
        end;

        // v�rifier si pas doublon adresse train
        verif_trains;

        //ntrains:=ntrains_cdm;
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
        Affiche('tronqu�3 : '+trame_CDM,clRed);
        AfficheDebug('tronqu�3 : '+trame_CDM,clyellow);
      end;
      residuCDM:=trame_CDM;
      Nbre_recu_cdm:=0;
      exit;
    end;

    reprise:
    if long<>0 then
    begin
      // nombre de param�tres
      val(copy(trame_CDM,j+1,5),nbre,erreur);
      //Affiche('nbre='+IntToSTR(nbre),clyellow);
      // compter le nombre de virgules qui doit �tre �gal au nombre de param�tres
      NbreVir:=0;  // nombre de virgules
      repeat
        i:=posEx(';',trame_CDM,i+1);
        if i<>0 then inc(NbreVir);
      until (i=0) or (NbreVir=nbre);
      if (i=0) then
      begin
      if debugTrames then
        begin
          Affiche('tronqu�4 : '+trame_CDM,clRed);
          AfficheDebug('tronqu�4 : '+trame_CDM,clyellow);
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
        if pos('ERR=200',commandeCDM)<>0 then s:='Erreur CDM : r�seau non charg� '
        else
        if pos('ERR=500',commandeCDM)<>0 then s:='Erreur CDM : serveur DCC non lanc� '
        else
        if pos('ERR=300',commandeCDM)<>0 then s:='Erreur CDM : RUN non lanc� ou train non trouv� '
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

        //Affiche('TrainCDM='+trains_cdm[ntrains_cdm].nom_train,clYellow);

      end;

      // �v�nement aiguillage. Le champ AD2 n'est pas forc�ment pr�sent
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
          // conversion des �tats CDM en �tat Xpressnet standardis�s
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
            // �tat de l'aiguillage 1
            if (etat=0) or (etat=2) then etatAig:=2;
            if etat=3 then etatAig:=1;
            // �tat de l'aiguillage 2
            adr2:=aiguillage[index].AdrTriple;
            if (etat=0) or (etat=3) then etatAig2:=2;
            if etat=2 then etatAig2:=1;
            Event_Aig(adr,etatAig);
            Event_Aig(adr2,etatAig2);
          end;
        end
        else
        begin
          s:='Recu evt aig de CDM pour un aiguillage '+intToSTR(Adr)+' non d�clar�';
          Affiche(s,clorange);
          AfficheDebug(s,clOrange);
        end;
      end;

      // �v�nement d�tecteur. Si det=1, Le nom du train est souvent _NONE
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
        //if etat=1 then Affiche(intToSTR(adr)+' '+TRain,clWhite);
        Event_detecteur(Adr,etat=1,train);
      end ;

      // �v�nement signal - non stock� ni interpr�t�
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

      // �v�nement actionneur
      // attention un actionneur qui repasse � 0 ne contient pas de nom de train
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
        Event_act(adr,0,etat,train); // d�clenche �vent actionneur
      end;

      // �v�nement position et vitesse des trains
      // g�n�re un �v�nement vitesse
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
          vitesse:=(vitesse*100) div 120;
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

        Event_vitesse(adr,train,vitesse); // d�clenche �vent actionneur vitesse train
        // fait bouger le train dans la fenetre cdm
        if fichier_module_CDM then Aff_train(adr,train,x,y,x2,y2);
        if afftiers then afficheDebug(s,clAqua);
      end;

      // �v�nement vitesse des trains - non stock� ni interpr�t�
      // S-E-01-0189-CDMTRN-SPEED|054|06|NAME=TRAIN_3;AD=0;SPEED=99;RMAX=120;CMAX=120;REQ=8;
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
          vitesse:=(vitesse*100) div 120;
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

      // �v�nement port CDM - non stock� ni interpr�t�
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
      //S-E-02-0254-CMDTRN-DCCSF|137|19|NAME=CC406526;AD=4;MODE=128;STEP=100;CSTEP=88;FX0=0;FX1=0;FX2=0;FX3=0;FX4=0;FX5=0;FX6=0;FX7=0;FX8=0;FX9=0;FX10=0;FX11=0;FX12=0;FX13=0;
      // �v�nement train
      // pas trait� !!

      inc(k);
      //Affiche('k='+intToSTR(k),clyellow);
    end;

    sort:=(length(trame_CDM)<10) or (k>=2000);
  until (sort);

  //Affiche('k='+IntToSTR(k)+' Ligne trait�e '+recuCDM,clLime);
  //if pos('_ACK',recuCDM)=0 then recuCDM:=''; // effacer la trame sauf si c'est une trame ACK car le trame est utilis�e dans le process de connexion de cdm
  if k>=2000 then begin Affiche('Erreur 90 : Longrestante='+IntToSTR(length(trame_CDM)),clred); Affiche(trame_CDM,clred);  end;

  Nbre_recu_cdm:=0;
end;

// r�ception d'un message de CDM rail
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
  Interprete_trameCDM(residuCDM+recuCDM);  // residuCDM est le morceau tronqu� de la fin de la r�ception pr�c�dente
end;

procedure TFormPrinc.ConnecterCDMrailClick(Sender: TObject);
begin
  if not(connecte_CDM) then affiche('CDM Rail non connect�',clorange);
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
    s:=s+' d�codeur='+IntToStr(Signaux[i].decodeur);
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

      // conditions sur carr�
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
      s:=s+'D�t amont niv 2 : ';
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
    if s2<>'' then Affiche('Conditions de carr� : '+s2,clYellow);
  end;
end;

procedure TFormPrinc.ClientSocketInterfaceDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  parSocketLenz:=False;
  LabelTitre.caption:=titre;
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
    //s:=#$ff+#$fe+#$23+#$1e+Char(adr)+Char(valeur);    //CV de 512 � 767 V3.4
    //s:=#$ff+#$fe+#$23+#$1d+Char(adr)+Char(valeur);    //CV de 256 � 511 V3.4
    s:=#$23+#$16+Char(adr)+Char(valeur);      //CV de 1 � 256
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
            s:=#$23+#$16+Char(cv)+Char(valeur);      //CV de 1 � 256
            s:=checksum(s);
            envoi(s);     // envoi de la trame et attente Ack, la premiere trame fait passer la centrale en mode programmation (service)
            tempo2(5);
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

function lire_cv(cv : integer) : integer;
var s : string;
    i : integer;
begin
  result:=-1;
  s:=#$22+#$15+Char(cv);      //CV de 1 � 256 (V3.0)
  //s:=#$22+#$18+Char(cv);    //CV de 1 � 255 + 1024 (V3.6)
  s:=checksum(s);
  // envoi de la trame : fait passer la centrale en mode programmation (service)
  envoi_ss_ack(s);

  // attendre la trame 01 04 05 "succ�s" (env 1s)
  succes:=false;i:=0;
  repeat
    Application.processMessages;
    Sleep(100);
    inc(i);
  until succes or (i>20);

  if succes then
  begin
    recu_cv:=false;
    //Affiche('re�u trame succes',clyellow);
    s:=#$21+#$10;      // demande d'envoi du r�sultat du mode service
    s:=checksum(s);
    //envoi(s);
    envoi_ss_ack(s);
    Tempo2(1);
    // attente de la r�ponse de la centrale
    i:=0;
    repeat
      Tempo2(2); // attend 200 ms
      inc(i);
     until recu_cv or (i>4);
    if (i>4) then
    begin
      Affiche('Erreur attente trop longue CV',clred);
      result:=-1;
      exit;
    end;
    result:=Tablo_cv[cv];
  end
  else
  begin
    Affiche('Pas de r�ponse de l''interface apr�s demande de passage en mode prog',clOrange);
    result:=-2;
  end;
end;

procedure TFormPrinc.ButtonLitCVClick(Sender: TObject);
var s,sa: string;
    i,cv,r,erreur : integer;
begin
  s:=GetCurrentDir;
  N_Cv:=0; // nombre de CV recus � 0
  Affiche('Lecture CV',clyellow);

  val(EditCV.Text,cv,erreur);
  if (erreur<>0) or (cv>255) or (cv<0) then
  begin
    EditCV.Text:='1';
    exit;
  end;

  if protocole=1 then
  begin
    {
    //trace:=true;
    s:=#$22+#$15+Char(cv);      //CV de 1 � 256 (V3.0)
    //s:=#$22+#$18+Char(cv);    //CV de 1 � 255 + 1024 (V3.6)
    s:=checksum(s);
    // envoi de la trame : fait passer la centrale en mode programmation (service)
    envoi_ss_ack(s);

    // attendre la trame 01 04 05 "succ�s" (env 1s)
    succes:=false;i:=0;
    repeat
      Application.processMessages;
      Sleep(100);
      inc(i);
    until succes or (i>20);

    if succes then
    begin
      recu_cv:=false;
      //Affiche('re�u trame succes',clyellow);
      s:=#$21+#$10;      // demande d'envoi du r�sultat du mode service
      s:=checksum(s);
      //envoi(s);
      envoi_ss_ack(s);
      Tempo2(1);
      // attente de la r�ponse de la centrale
      i:=0;
      repeat
        Tempo2(2); // attend 200 ms
        inc(i);
      until recu_cv or (i>4);
      if (i>4) then
      begin
        Affiche('Erreur attente trop longue CV',clred);
        exit;
      end;
      sa:='Cv'+IntToSTR(cv)+'='+IntToSTR(Tablo_cv[cv])+' ';
      Affiche(sa,clyellow);sa:='';
    end
    else
    Affiche('Pas de r�ponse de l''interface apr�s demande de passage en mode prog',clOrange);
    }
    r:=lire_cv(cv);
    if r<>-1 then
    begin
      sa:='Cv'+IntToSTR(cv)+'='+IntToSTR(Tablo_cv[cv])+' ';
      Affiche(sa,clyellow);sa:='';
    end;
  end;

  if protocole=2 then
  begin
    s:='<R '+intToSTR(cv)+' 1 1>';
    envoi_ss_ack(s);
    Tempo2(1);
    // attente de la r�ponse de la centrale
    i:=0;
    repeat
      Tempo2(2); // attend 200 ms
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
    // ne pas faire close : d�ja provoqu� par le self de la fermeture
  end;
end;

procedure TFormPrinc.ButtonArretSimuClick(Sender: TObject);
begin
  Index_Simule:=0;  // fin de simulation
  I_Simule:=0;
  MsgSim:=false;
  StopSimu:=true;
  Affiche('Fin de simulation',clCyan);
  ButtonArretSimu.Visible:=false;
end;

procedure TFormPrinc.OuvrirunfichiertramesCDM1Click(Sender: TObject);
var s : string;
    fte : textFile;
begin
  s:=GetCurrentDir;
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
  ButtonArretSimu.Visible:=false;
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



// pour d�placer l'ascenseur de l'affichage automatiquement en bas
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

procedure affiche_routes;
var i,j,v : integer;
    s : string;
begin
  for i:=1 to N_trains do
  begin
    v:=event_det_train[i].AdrTrain;
    s:=intToSTR(i)+' AdresseTrain='+intToSTR(v)+' '+event_det_train[i].nom_train+' ';
    v:=event_det_train[i].NbEl;
    s:=s+' NbEl='+intToSTR(v)+' ';
    Affiche(s,clWhite);
    for j:=1 to v do
    begin
      s:='  -> El='+intToSTR(j)+' '+intToSTR(event_det_train[i].Det[j].adresse)+' �tat=';
      if event_det_train[i].Det[j].etat then s:=s+'1' else s:=s+'0';
      Affiche(s,clwhite);
    end;
  end;
end;

procedure TFormPrinc.Etatdeszonespartrain1Click(Sender: TObject);
var i,j,n,train : integer;
    couleur : tcolor;
    rien,aff : boolean;
    s,ss : string;
begin
  Affiche('',clyellow);
  Affiche('Historique de l''�tat des zones par train',clWhite);
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
  Affiche('Liste des zones actuellement occup�es:',clWhite);
  i:=0;
  repeat
    j:=0;
    repeat
      aff:=MemZone[i,j].etat;
      if aff then
      begin
        s:='MemZone['+intToSTR(i)+','+intToSTR(j)+'] '+MemZone[i,j].train+' @='+intToSTR(MemZone[i,j].AdrTrain);
        s:=s+' Train n�'+intToSTR(MemZone[i,j].IndexTrainRoulant);
        s:=s+' PrevSuiv='+intToSTR(MemZone[i,j].Prev);
        Affiche(s,couleurTrain[MemZone[i,j].IndexTrainRoulant]);

        rien:=false;
      end;
      inc(j);
    until (j>NbMaxDet);
    inc(i);
  until (i>NbMaxDet);

  {Affiche('Derniers �l�ments scann�s:',clWhite);
  for i:=1 to idEl do
  begin
    Affiche(IntToSTR(elements[i].adresse),clLime);
  end;}

  Affiche(' ',clyellow);
  for i:=1 to n_trains do
  begin
    s:='Event det train '+intToSTR(i);
    n:=event_det_train[i].AdrTrain;
    if n<>0 then s:=s+' @'+intToSTR(n);
    ss:=event_det_train[i].nom_train;
    if ss<>'' then s:=s+' '+ss+' ';

    n:=event_det_train[i].signal_rouge;
    if n<>0 then s:=s+'Arret� devant signal '+intToSTR(n);
    Affiche(s,clyellow);
    for j:=1 to event_det_train[i].NbEl do
    begin
      s:=intToSTR(event_det_train[i].Det[j].adresse);
      Affiche(s,couleurTrain[i]);
    end;
  end;

  affiche_routes;

  Affiche(' ',clyellow);

  for i:=1 to ntrains do
  begin
    Affiche(trains[i].nom_train+' @='+intToSTR(trains[i].adresse)+' Det suiv='+intToSTR(trains[i].detecteurSuiv),clYellow);
  end;

  {
  Affiche('Ev�nements d�tecteurs par train',clWhite);
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
  //if rien then Affiche('Aucune zone n''a �t� d�clench�e',clOrange);
end;

procedure TFormPrinc.Apropos1Click(Sender: TObject);
var i,t,t1 : integer;
    s: string;
begin
  Affiche(' ',clyellow);
  s:='Signaux complexes GL version '+versionSC+sousVersion;
  {$IF CompilerVersion >= 28.0}
  s:=s+' D12';         // si compil� avec Delphi12
  {$IFEND}
  {$IFDEF WIN64}       // si compil� en 64 bits
  s:=s+' x64';
  {$ENDIF}
  s:=s+' (C) 2022-25 F1IWQ Gily TDR';
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

  Affiche('Ce programme pilote des signaux complexes et les trains de fa�on autonome ou avec CDM rail ',ClYellow);
  Affiche('en fonction des d�tecteurs mis � 1 ou 0 par des locomotives',ClYellow);
  Affiche('en circulation sur le r�seau',ClYellow);
  Affiche('En vert : Trames envoy�es � l''interface',ClWhite);
  Affiche('En blanc : Trames brutes re�ues de l''interface',ClWhite);
  Affiche('En rouge : erreurs et d�fauts',ClWhite);
  Affiche('En orange : pilotage des signaux / erreurs mineures',ClWhite);
  Affiche('En bleu : pilotage des aiguillages',ClWhite);
  Affiche('En jaune : r�trosignalisation re�ue depuis l''interface',ClWhite);
  t:=0;
  t1:=sizeof(TTCO);
  for i:=1 to nbreTCO do
    t:=t+t1*NbreCellX[i]*NbreCellY[i];
  Affiche('Taille des '+intToSTR(NbreTCO)+' TCOs : '+intToSTR(t)+' octets',clOrange);
  Affiche('Taille des aiguillages : '+intToSTR(SizeOf(aiguillage) )+' octets',clorange);
  Affiche('Taille de la structure aiguillage : '+intToSTR(SizeOf(Taiguillage) )+' octets',clorange);
  Affiche('Taille des signaux : '+intToSTR(SizeOf(Signaux) )+' octets',clorange);
  Affiche('Taille de la structure signal : '+intToSTR(SizeOf(Tsignal) )+' octets',clorange);
  Affiche('Taille des branches : '+intToSTR(SizeOf(brancheN) )+' octets',clorange);
  Affiche('Taille des trains  : '+intToSTR(sizeOf(Trains) div 1024)+' Ko',clOrange);
  Affiche('Taille de la structure train  : '+intToSTR(sizeOf(Ttrain) div 1024)+' Ko',clOrange);
  Affiche('Taille des actions : '+intToSTR(SizeOf(Tablo_Action))+' octets',clorange);
  Affiche('Taille des PN: '+intToSTR(SizeOf(Tablo_PN) )+' octets',clorange);
  Affiche('Taille du tableau d''�v�nements d�tecteurs '+intToSTR(SizeOf(event_det) )+' octets',clorange);
  Affiche(' ',clyellow);

  envoie_infos(1);
end;

// cliqu� droit sur un signal puis sur le menu propri�t�s
procedure TFormPrinc.Proprits1Click(Sender: TObject);
var s: string;
begin
  clicliste:=false;
  if affEvt then Affiche('Clic propri�t�s',clYellow);
  s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pour r�cup�rer l'index du signal (ex: ImageSignal2)
  //Affiche(s,clOrange);     // nom de l'image du signal (ex: ImageSignal)
  IndexSignalClic:=extract_int(s);   // extraire l'adresse (ex 2)
  formconfig.PageControl.ActivePage:=formconfig.TabSheetSig;
  clicproprietesSig:=true;
  formconfig.showmodal;
  formconfig.close;
end;

function InfoSignal(adresse : integer) : string;
var s,ss : string;
    nation,etat,i,j,aspect,n,combine,aig,trainReserve,AdrSignalsuivant,voie,
    indexTrain,AdrTrainRes,adraig : integer;
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

  s:='Le signal '+intToSTR(adresse)+' pr�sente '+chaine_signal(adresse)+#13;

  if aspect=blanc then
  begin
    if cond_feuBlanc(adresse) then s:=s+'Des conditions d''affichage du feu blanc ont �t� d�finies sur la'+#13+'position d''aiguillages et elles sont remplies';
  end;

  // carr�
  if (aspect=carre) and (nation=1) then
  begin
    //Affiche(s,clyellow);
    adraig:=carre_signal(Adresse,trainreserve,reserveTrainTiers,AdrTrainRes);
    IndexTrain:=Index_train_adresse(AdrTrainRes);
    if adraig<>0 then s:=s+'les aiguillages en aval du signal sont mal positionn�s (A'+IntToSTR(AdrAig)+') ou leur positions inconnues'+#13;
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
      if j=1 then s:=s+'Un aiguillage ou un croisement en aval du signal '+#13+'('+ss+') est r�serv� par le train (@'+intToSTR(AdrTrainRes)+')'
      else s:=s+'Des aiguillages ou des croisements en aval du signal '+#13+'('+ss+') sont r�serv�s par le train (@'+intToSTR(AdrTrainRes)+')';
      s:=s+' '+trains[Indextrain].nom_train+#13;
    end;
    if Cond_Carre(Adresse) then s:=s+'les aiguillages d�clar�s dans la d�finition du signal sont mal positionn�s'+#13;
    if Signaux[i].VerrouCarre and not(PresTrainPrec(Adresse,Nb_cantons_Sig,false,TrainReserve,voie)) then s:=s+'le signal est verrouillable au carr� et aucun train n''est pr�sent avant le signal'+#13;
    if test_memoire_zones(Adresse) then s:=s+'pr�sence train dans canton suivant le signal'+#13;
   //   if Signaux[i].EtatVerrouCarre then s:=s+'le signal est verrouill� au carr� dans la fen�tre de pilotage'+#13;
  end;

  if (aspect=vert_jaune_H) and (nation=2) then
  begin
    etat:=etat_signal_suivant(Adresse,1,AdrSignalsuivant) ;  // �tat du signal suivant + adresse du signal suivant dans Signal_Suivant
    if testbit(etat,chiffre) then
    begin
      s:=s+'le signal suivant '+intToSTR(adrSignalSuivant)+' affiche une r�duction de vitesse '+#13;
    end;
  end;

  if ((aspect=semaphore) and (nation=1)) or ((aspect=rouge) and (nation=2)) then
  begin
    if test_memoire_zones(Adresse) then s:=s+'pr�sence train dans canton apr�s le signal'+#13;
    if n=20 then
    begin
      // signal belge
      AdrAig:=carre_signal(Adresse,trainreserve,reserveTrainTiers,AdrTrainRes);
      if AdrAig<>0 then s:=s+'les aiguillages en aval du signal sont mal positionn�s (A'+intToSTr(AdrAig)+') ou leur positions inconnues'+#13;
      if reserveTrainTiers then s:=s+'un aiguillage ou un croisement en aval du signal sont r�serv�s par un autre train (@'+intToSTR(AdrTrainRes)+')'+#13;
      if Cond_Carre(Adresse) then s:=s+'les aiguillages d�clar�s dans la d�finition du signal sont mal positionn�s'+#13;
      if Signaux[i].VerrouCarre and not(PresTrainPrec(Adresse,Nb_cantons_Sig,false,TrainReserve,voie)) then s:=s+'le signal est verrouillable au carr� et aucun train n''est pr�sent avant le signal'+#13;
      if test_memoire_zones(Adresse) then s:=s+'pr�sence train dans canton suivant le signal'+#13;
      //if Signaux[i].EtatVerrouCarre then s:=s+'le signal est verrouill� au rouge dans la fen�tre de pilotage'+#13;
    end;
  end;
  // avertissement ou deux-jaunes (belge)
  if ((aspect=jaune) and (n<>20)) or ((aspect=deux_jaunes) and (n=20)) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalsuivant)+#13;
  end;

  // jaune cli
  if (aspect=jaune_cli) and (nation=1) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    index:=Index_Signal(AdrSignalSuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est a '+chaine_signal(AdrSignalSuivant)+#13;
  end;
  // ralen 30
  if (combine=ral_30) and (nation=1) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    index:=Index_Signal(AdrSignalSuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalSuivant)+#13;
  end;
  if (combine=ral_60)  and (nation=1) then
  begin
    i:=etat_signal_suivant(Adresse,1,AdrSignalsuivant);
    index:=Index_Signal(AdrSignalSuivant);
    s:=s+'son signal suivant '+intToSTR(AdrSignalsuivant)+' est au '+chaine_signal(AdrSignalSuivant)+#13;
  end;
  if ((combine=rappel_30) or (combine=rappel_60)) and (nation=1) then
  begin
    Aig:=Aiguille_deviee(Adresse);
    // si aiguille locale d�vi�e
    if (aig<>0) then s:=s+'l''aiguillage suivant '+intToSTR(Aig)+' est d�vi�'+#13;
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
      s:=s+'le signal doit �tre franchi � <'+intToSTR(aiguillage[aig].vitesse)+'km/h'+#13;
    end;
    if testbit(combine,chevron) then
    begin
      aig:=Signaux[i].Adr_el_suiv1;
      aig:=index_aig(aig);
      s:=s+'l''aiguillage m�ne � une voie en contresens'+#13;
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
  s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pout r�cup�rer l'adresse du signal (ex: ImageSignal2)
  //Affiche(s,clOrange);     // nom de l'image du signal (ex: ImageSignak2)
  i:=extract_int(s);   // extraire l'index (ex 2)
  adresse:=Signaux[i].adresse;

  s:=InfoSignal(adresse);
  Affiche_CR(s,clyellow);
end;

procedure TFormPrinc.VrifierlacohrenceClick(Sender: TObject);
begin
  if verif_coherence then affiche('La configuration est coh�rente',clLime);
end;

// cliqu� gauche dans la fenetre Fenrich
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
  TempoCombo:=2;
  if (i<>0) and (i<Max_Trains) then
  begin
    //if CDM_connecte then EditAdrTrain.Text:=intToSTR(trains_cdm[i].adresse) else
    Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,clWhite);
    IdTrainClic:=i;
    EditAdrTrain.Text:=intToSTR(trains[IdTrainClic].adresse);
    //editVitesse.Text:=intToSTR(trains[idTrainClic].vitesseCons);
    Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,$e0e0e0);

    //mise � jour compteur train
    affiche_train_compteur(1);
    aiguille_compteur(1,idTrainClic,formCompteur[1]);

  end;
  clicComboTrain:=false;
end;

procedure TFormPrinc.ButtonFonctionClick(Sender: TObject);
var erreur,fonction,etat,loco : integer;
    s : string;
begin
  val(editNumFonction.Text,fonction,erreur);
  if (erreur<>0) or (fonction<0) then exit;
  val(editFonc01.Text,etat,erreur);
  if (erreur<>0) or (etat<0) then exit;
  if not(portCommOuvert) and not(parSocketLenz) and not(CDM_connecte) then exit;
  val(editAdrTrain.Text,loco,erreur);
  s:=trains[combotrains.itemindex+1].nom_train;
  if CDM_connecte then
  begin
    if s='' then begin Affiche('S�lectionnez un train',clOrange);exit;end;
    envoie_fonction(fonction,etat,s);
    Affiche('Train='+s+' F'+IntToSTR(fonction)+':'+intToSTR(etat),clyellow);
    exit;
  end;

  begin
    if erreur<>0 then begin Affiche('S�lectionnez un train',clOrange);exit;end;
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
    Affiche('L''interface n''est pas connect�e par USB ou par Ethernet',clorange);
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
    Affiche('L''interface n''est pas connect�e par USB ou par Ethernet',clorange);
    exit;
  end;
  if (protocole=1) then demande_etat_acc ;
end;

procedure reprise_dcc;
var s : string;
begin
  if protocole=1 then
  begin
    s:=#$21+#$81;
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
  end;
  if protocole=2 then envoi('<1>');
end;

procedure TFormPrinc.RepriseDCC1Click(Sender: TObject);
begin
  if (portcommOuvert=false) and (parsocketLenz=false) then
  begin
    Affiche('L''interface n''est pas connect�e par USB ou par Ethernet',clorange);
    exit;
  end;
  reprise_dcc;
end;

procedure TFormPrinc.BoutonRazTrainsClick(Sender: TObject);
begin
  Affiche('Raz tous trains et routes',clLime);
  Raz_tout;
end;

procedure TFormPrinc.Demandetataccessoires1Click(Sender: TObject);
begin
  if portCommOuvert or parSocketLenz then demande_etat_acc
  else Affiche('L''interface n''est pas connect�e par USB ou par Ethernet',clorange);
end;

procedure TFormPrinc.LancerCDMrail1Click(Sender: TObject);
begin
  Lance_CDM(true);
end;

// tackBar "commande aux trains"
procedure TFormPrinc.TrackBarVitChange(Sender: TObject);
var s : string;
    i,adr,vit,erreur : integer;
begin
  if pasChgTBV then exit;
  //if affEvt then
  if clicTBFen or clicTBGB then exit;
  if affevt then Affiche('Changement TrackBarVit',clyellow);
  clicTBTrain:=true;
  //EditVitesse.Text:=intToSTR(TrackBarVit.position);
  s:=editAdrTrain.Text;
  val(s,adr,erreur);
  if (erreur<>0) or (adr<0) then
  begin
    clicTBTrain:=false;
    exit;
  end;
  //if not(portCommOuvert) and not(parSocketLenz) and not(CDM_Connecte) then exit;
  //s:=editVitesse.Text;
  val(s,vit,erreur);
  if (erreur<>0) or (vit<-126) or (vit>126) then
  begin
    clicTBTrain:=false;
    exit;
  end;
  i:=0;s:='';
  if combotrains.itemindex<>-1 then
  begin
    s:=combotrains.Items[combotrains.itemindex];
    i:=index_train_nom(s);
  end;

  //Affiche('Commande vitesse train '+s+' ('+intToSTR(adr)+') � '+IntToSTR(vit)+'%',cllime);
  // ne pas commander la vitesse car la r�tro met � jour la track bar!!!
  //sens:=vit>0;
  //vitesse_loco(s,i,adr,vit,sens,true);
  //if s='' then s:=intToSTR(adr);
  clicTBTrain:=false;
end;

procedure TFormPrinc.EditVitesseChange(Sender: TObject);
var i,e : integer;
begin
{  if pasChgTBV then exit;
  val(EditVitesse.Text,i,e);
  if (e=0) and (i>=-127) and (i<=128) then TrackBarVit.position:=i;}
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

procedure TFormPrinc.OpRoulageClick(Sender: TObject);
begin
  init_aiguillages;
end;

procedure TFormPrinc.Demandetatdtecteurs1Click(Sender: TObject);
begin
  if portCommOuvert or parSocketLenz then
  begin
    modeStkRetro:=false; // avec evt
    demande_etat_det;
  end
  else Affiche('L''interface n''est pas connect�e par USB ou par Ethernet',clorange);
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

// informations sur les ports s�rie/usb disponibles
procedure DemandeSerialPortInfo;
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
  i:=0;
  FSWbemLocator:=CreateOleObject('WbemScripting.SWbemLocator');
  FWMIService:=FSWbemLocator.ConnectServer(WbemComputer,'root\CIMV2',WbemUser,WbemPassword);   // nom de l'espace par d�faut et classes du mat�riel du pc
  //                  exception
  // SELECT * FROM MSSerial_PortName   ou SELECT * FROM Win32_SerialPort    ou SELECT * FROM Win32_PnPEntity

  {
  FWbemObjectSet:=FWMIService.ExecQuery('select * from win32_pnpentity','WQL',wbemFlagForwardOnly);
  //FWbemObjectSet:=FWMIService.ExecQuery('select * from Win32_USBControllerDevice','WQL',wbemFlagForwardOnly);

  // requete 0 pour les usb composites ------------------
  oEnum:=IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  while oEnum.Next(1,FWbemObject,iValue)=0 do
  begin
    inc(i);
    // pour les autres champs: https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-serialport
    if FWbemObject.DeviceID<>null then s:=FWbemObject.DeviceID+' ';
    if FWbemObject.name<>null then s:=s+FWbemObject.Name+' ';
    if FWbemObject.Description<>null then s:=s+FWbemObject.Description;
    Affiche(s,clyellow);
    FWbemObject:=Unassigned;
  end;
  if i=0 then Affiche('R0 : Aucun port usb composite',clLIme);
  }

  // requete 1 pour les com natifs ------------------
  FWbemObjectSet:=FWMIService.ExecQuery('select * FROM Win32_SerialPort','WQL',wbemFlagForwardOnly);
  //FWbemObjectSet:=FWMIService.ExecQuery('select * from win32_pnpentity','WQL',wbemFlagForwardOnly);

  oEnum:=IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
  i:=0;
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

// affiche les ports com s�rie ou usb
procedure liste_portcom ;
begin
  try
    CoInitialize(nil);           // on va utiliser Ole
    try
      DemandeSerialPortInfo;     // chercher les ports com avec Ole
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
  Affiche('Evenements tous d�tecteurs et aiguillages',clwhite);
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
       4 : s:=s+'/0';  // non utilis�
       end;
      Affiche(s,couleur);
    end;

    if event_det_tick[i].modele=aig then
    begin
      s:='Aiguillage '+intToSTR(event_det_tick[i].adresse)+' ';
      pos:=event_det_tick[i].etat;
        case pos of
          const_devie : s:=s+' d�vi�' ;
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
  Affiche('Mise � 0 de la r�servation des aiguillages',clYellow);
  Raz_reservations;
  //Maj_Signaux(false);
  for i:=1 to nbreTCO do
    Affiche_tco(i);
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
  // AdrPilote est r�cup�r� de l'event OnMouseDown de l'image du signal qui se produit avant
  if Affevt then Affiche('PopupMenuFeu',clYellow);
  ob:=Sender as Tpopupmenu;
  ob.Items[0].Caption:='Propri�t�s du signal '+intToSTR(AdrPilote);
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
    if V_utile=V_publie then Affiche('Votre version '+VersionSC+SousVersion+' publi�e le '+date_creation+' est � jour',clLime);
    if V_utile>V_publie then Affiche('Votre version '+versionSC+SousVersion+' est plus r�cente que la version publi�e '+s,clLime);
  end
end;

procedure TFormPrinc.Analyser1Click(Sender: TObject);
var s1,s2 : string;
    i : integer;
begin
  s1:=lowercase(fenRich.Lines[0]);
  if pos('module',s1)=0 then
  begin
    Affiche('Pas de module r�seau CDM d�tect�.',clyellow);
    Affiche('Proc�dure: dans CDM RAIL ouvrez votre r�seau ; Menu ... / TrackDrawing  / Module Display',clLime);
    Affiche('Attention : n�cessite la version >=23.05 de CDM',clLime);
    Affiche('Cela ouvre une fen�tre DEBUG dans cdm',clLime);
    Affiche('Dans cette fen�tre, faire Clic droit puis "s�lectionner tout" et "copier"',clLime);
    Affiche(' ',clLime);
    Affiche('Dans Signaux complexes, clic droit et "coller, compiler et importer le r�seau CDM rail" ',clLime);
    Affiche('Dans la fen�tre graphique d''importation cliquer sur "compiler"',clLime);

    if lance_cdm(false) then
    begin
      sleep(400);
      s2:='CDR';
      //SetBackgroundWindow(formprinc.Handle); // met SC devant
      ProcessRunning(s2); // r�cup�rer le handle de CDM
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
      i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  // la fenetre serveur d�marr� est affich�e
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
    nbTCOE : array[1..10] of integer; // nombre de TCO par �cran
    CeTCO  : array[1..10] of integer; // nombre de TCO en cours d'affichage par �cran
begin
  for i:=1 to 10 do begin nbTCOE[i]:=0;CeTCO[i]:=0;end;
  for i:=1 to NbreTCO do
  begin
    e:=ECranTCO[i]; // �cran du tco i
    if (e>=1) and (e<=10) then inc(nbTCOE[e]);  //nbTCOE[2]=3 signifie que l'�cran 2 contient 3 TCOs
  end;

  NombreEcrans:=Screen.MonitorCount;
  if NombreEcrans>10 then NombreEcrans:=10;
  if NombreEcrans=1 then NbTCOE[1]:=NbreTCO;

  for i:=1 to NbreTCO do
  begin

    for e:=1 to NombreEcrans do
    begin

      if (ecranTCO[i]=e) or (NombreEcrans=1) then  // si l'�cran TCO doit aller sur e
      begin
        inc(CeTCO[e]);
        largEcran:=ecran[e].larg;
        hautEcran:=ecran[e].haut;
        TopEcran:=ecran[e].y0;
        LeftEcran:=ecran[e].x0;
        largTCO:=largEcran ;
        if NbTCOE[e]<>0 then
          HautTCO:=(HautEcran div NbTCOE[e]) else HautTCO:=HautEcran;
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
    nbTCOE : array[1..10] of integer; // nombre de TCO par �cran
    CeTCO  : array[1..10] of integer; // nombre de TCO en cours d'affchage par �cran
begin
  for i:=1 to 10 do begin nbTCOE[i]:=0;CeTCO[i]:=0;end;
  for i:=1 to NbreTCO do
  begin
    e:=ECranTCO[i]; // �cran du tco i
    if (e>=1) and (e<=10) then inc(nbTCOE[e]);  //nbTCOE[2]=3 signifie que l'�cran 2 contient 3 TCO
  end;

  NombreEcrans:=Screen.MonitorCount;
  if NombreEcrans>10 then NombreEcrans:=10;
  if NombreEcrans=1 then NbTCOE[1]:=NbreTCO;

  for i:=1 to NbreTCO do
  begin
    for e:=1 to NombreEcrans do
    begin
      if (ecranTCO[i]=e) or (NombreEcrans=1) then  // si l'�cran TCO doit aller sur e
      begin
        inc(CeTCO[e]);
        largEcran:=ecran[e].larg;
        hautEcran:=ecran[e].haut;
        TopEcran:=ecran[e].y0;
        LeftEcran:=ecran[e].x0;
        if NbTCOE[e]<>0 then largTCO:=largEcran div NbTCOE[e] else largTCO:=LargEcran;
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

// Affiche le TCO i sur l'�cran d�sign� dans la structure du TCO
procedure Affiche_Fenetre_TCO(i : integer;laisseOuvert : boolean);
var e : integer;
begin
  if (i<1) or (i>NbreTCO) or (formTCO[i]=nil) then exit;
  e:=ecranTCO[i];
  if e>10 then e:=10;
  if e>Screen.MonitorCount then e:=1;

  formTCO[i].show;    // on est oblig� d'afficher la fenetre TCO pour provoquer OnActivate pour valider les pointeurs

  application.ProcessMessages;
  if formTCO[i].Left<>Ecran[e].x0 then formTCO[i].Left:=Ecran[e].x0;
  if formTCO[i].Top<>Ecran[e].y0 then formTCO[i].Top:=Ecran[e].y0;
  formTCO[i].BringToFront;

  // pour maximiser la fen�tre, oblig� de faire wsnormal avant
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

// mise � jour des menus TCO en fonction du nombre i de TCO
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
     formTCO[nbreTCO]:=TformTCO.Create(self);   // g�n�re formCreate
  except
     Affiche('Erreur 6800 Impossible de cr�er la fen�tre du TCO',clred);
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
  formTCO[nbreTCO].show;     // g�n�re formActivate ce qui implique que le nom de la form soit � jour, et que le TCO soit initialis�

  FormConfigTCO.show;
end;

procedure Supprimer_TCO(TcoS : integer);
var c,x,y,i,SauvNbreTCO : integer;
    s : string;
begin
  if Tcos>NbreTCO then exit;
  s:='Voulez-vous supprimer le TCO '+intToSTR(TcoS)+' ('+NomFichierTCO[tcoS]+')';
  if Application.MessageBox(pchar(s),pchar('confirm'), MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION)=idNo then exit;

  SauvNbreTCO:=NbreTCO;  // dire au programme Timer qu'il n'y a plus de TCO le temps de supprimer sinon il peut tenter d'allumer un feu sur le TCO qu'on supprime->violation
  NbreTCO:=0;
  TCOActive:=false;

  Affiche('Suppression du TCO '+intToSTR(Tcos),clOrange);

  // supprimer les cantons
  for y:=1 to NbreCellY[tcos] do
    for x:=1 to NbreCellX[tcos] do
    begin
      if isCanton(tco[tcos,x,y].Bimage) then
      begin
        c:=tco[tcos,x,y].NumCanton;
        if c<>0 then supprime_canton(c);
      end;
    end;

  FormTCO[tcos].Release;   // annuler le pointeur et raz les m�moires de la form

  for i:=tCos to SauvNbreTCO-1 do
  begin
    NomFichierTCO[i]:=NomFichierTCO[i+1];

    FormTCO[i]:=FormTCO[i+1];
    FormTCO[i].Name:='TCO'+intToSTR(i);  // renommer le TCO
    TCO[i]:=Tco[i+1]; // d�placer les donn�es
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
  // pour �viter de coincer le splitter � gauche fenetre r�duite et on le glisse compl�tement � gauche
  //Affiche('On Resize',clyellow);
  splitterV.Left:=FenRich.left+FenRich.Width-5;
  positionne_elements(SplitterV.left);
  calcul_pos_horloge_compt;
end;

procedure TFormPrinc.Affichagenormal1Click(Sender: TObject);
begin
  FenRich.Width:=GrandPanel.Width-Panel1.Width-GroupBoxAcc.Width-25;
  splitterV.Left:=FenRich.left+FenRich.Width-5;
  positionne_elements(splitterV.Left);
  LargeurFC:=0;
  calcul_pos_horloge_compt;
end;

procedure TFormPrinc.Sauvegarderla1Click(Sender: TObject);
begin
  // fen�tre principale
  LargeurF:=width;
  HauteurF:=Height;
  OffsetXF:=left;
  OffsetYF:=top;
  // fen�tre clock
  LargeurFC:=formClock.width;
  HauteurFC:=formClock.Height;
  OffsetXFC:=formClock.left;
  OffsetYFC:=formClock.top;

  // �cart entre fenetre principale et clock , pour proc�dure formprinc WindowPosChanging
  DeltaFPCY:=OffsetYFC-formprinc.top;
  DeltaFPCX:=OffsetXFC-formprinc.left;

  PosSplitter:=splitterV.Left;
  AffMemoFenetre:=1;
  sauve_config;
end;

// change la couleur du texte du panel dans la status bar
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

{$IF CompilerVersion >= 28.0}
// r�ception COM/USB du p�riph�rique 1 avec Asyncpro
procedure TFormPrinc.RecuPeriph1(Sender: TObject;Count : Word);
var s : string;
   tablo : array[1..255] of byte;  // tableau rx usb
   c : char;
   i : integer;
begin
  MScommCde1.GetBlock(Tablo,count);

  for i:=1 to count do
  begin
    c:=char(tablo[i]);
    //Affiche(c,clorange);
    if c=#13 then
    begin
      s:=tablo_periph[1].tamponrx;
      affiche(s,clyellow);
      tablo_periph[1].tamponrx:='';

      telecommande(s);
    end;
    if (c>#31) and (c<#128) then tablo_periph[1].tamponrx:=tablo_periph[1].tamponrx+c;
  end;
end;

// r�ception COM/USB du p�riph�rique 2 avec asyncpro
procedure TFormPrinc.RecuPeriph2(Sender: TObject;count : word);
var s : string;
   tablo : array[1..255] of byte;  // tableau rx usb
   c : char;
   i : integer;
begin
  MSCommCde2.GetBlock(Tablo,count);  // TMSComm autoadapte la longueur du tampon dynamique
  for i:=1 to length(tablo) do
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
    if (c>#31) and (c<#128) then tablo_periph[2].tamponrx:=tablo_periph[2].tamponrx+c;
  end;
end;
{$ELSE}

// r�ception COM/USB du p�riph�rique 1 avec TMScomm
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
      //Affiche(c,clorange);
      if c=#13 then
      begin
        s:=tablo_periph[1].tamponrx;
        affiche(s,clyellow);
        tablo_periph[1].tamponrx:='';

        telecommande(s);
      end;
      if (c>#31) and (c<#128) then tablo_periph[1].tamponrx:=tablo_periph[1].tamponrx+c;
    end;
  end;
end;

// r�ception COM/USB du p�riph�rique 2 avec tmsComm
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
{$IFEND}

procedure TFormPrinc.ClientSocketCde1Connect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Socket '+ClientSocketCde1.Address+':'+intToSTR(ClientSocketCde1.port)+' connect� ',clYellow);
end;

procedure TFormPrinc.ClientSocketCde1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;var ErrorCode: Integer);
var s : string;
begin
  s:='Erreur '+IntToSTR(ErrorCode)+' socket '+ClientSocketCde1.Address+':'+intToSTR(ClientSocketCde1.port);
  case ErrorCode of
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par un tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
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
  Affiche('Socket '+ClientSocketCde2.Address+':'+intToSTR(ClientSocketCde2.port)+' connect� ',clYellow);
end;

procedure TFormPrinc.ClientSocketCde2Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;var ErrorCode: Integer);
var s : string;
begin
  s:='Erreur '+IntToSTR(ErrorCode)+' socket '+ClientSocketCde2.Address+':'+intToSTR(ClientSocketCde2.port);

  case ErrorCode of
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par un tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
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

procedure TFormPrinc.Copierltatdesaiguillageseninitialisation1Click(Sender: TObject);
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
  if tsi then Affiche('La position initiale des aiguillages dont la position est connue a �t� mise � jour',clYellow)
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
  Affiche('Client '+intToSTR(n)+' '+Socket.remoteAddress+':'+intToSTR(Socket.RemotePort)+':'+intToSTR(Socket.LocalPort)+' connect�',clyellow);
end;

// r�ception de donn�es des clients de signaux complexes
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
      Affiche('Client '+intToSTR(n+1)+' '+socket.remoteAddress+':'+intToSTR(socket.remotePort)+':'+intToSTR(socket.LocalPort)+' d�connect�',clyellow);
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
  if n=0 then affiche('Aucun client connect�',clYellow);
  if n=1 then affiche('1 client connect�',clyellow);
  if n>1 then affiche(intToSTR(n)+' clients connect�s',clyellow);
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

  if horloge then Affiche('Horloge valid�e',clWhite)
  else Affiche('Horloge d�valid�e',clWhite);
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
  if not(VerrouilleClock) then exit;
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
  position_compteur;
  inherited;
end;

procedure TFormPrinc.Codificationdescantons1Click(Sender: TObject);
var i : integer;
    s : string;
begin
  Affiche('Etat des cantons',clWhite);
  for i:=1 to ncantons do
  begin
    s:=intToSTR(i)+' Canton '+IntToSTR(canton[i].numero);
    if canton[i].horizontal then s:=s+' H ' else s:=s+' V ';

    s:=s+'  TCO'+intToSTR(canton[i].nTco)+'   x='+intToSTR(canton[i].x)+' y='+
            intToSTR(canton[i].y)+' Nel='+intToSTR(canton[i].Nelements)+'   '+canton[i].nom+
            '   IndexTrain='+intToSTR(Canton[i].indexTrain)+'  train='+Canton[i].NomTrain+
            ' El contigu1='+intToSTR(canton[i].el1);

    case canton[i].typ1 of
      det : s:=s+' Det';
      buttoir : s:=s+' But';
      else s:=s+' Aig';
    end;

    s:=s+' El contigu2='+intToSTR(canton[i].el2);
    case canton[i].typ2 of
      det : s:=s+' Det';
      buttoir : s:=s+' But';
      else s:=s+' Aig';
    end;
    if canton[i].NumcantonOrg<>0 then s:=s+' CantonD�part='+intToSTR(canton[i].NumcantonOrg);
    if canton[i].NumcantonDest<>0 then s:=s+' CantonArriv�e='+intToSTR(canton[i].NumcantonDest);

    Affiche(s,clyellow);
  end;
end;

// renvoie les 2 points d'entr�e et de sortie possibles d'une TJD 4 �tats en fonction de son �tat pass� en param�tres
procedure TJD4(adr1,pos1,adr2,pos2 : integer;var c1,c2 : char);
begin
  if (pos1=const_droit) and (pos2=const_droit) then begin c1:='D';c2:='D';end;
  if (pos1=const_devie) and (pos2=const_droit) then begin c1:='D';c2:='S';end;
  if (pos1=const_droit) and (pos2=const_devie) then begin c1:='S';c2:='D';end;
  if (pos1=const_devie) and (pos2=const_devie) then begin c1:='S';c2:='S';end;
end;

// copie le parcours source vers le fin de la route dest
function copie_route(source,dest : integer) : boolean;
var i,n,d : integer;
begin
  n:=tabloParcours[source,0].adresse;
  d:=tabloRoute[dest,0].adresse;
  for i:=1 to n do
  begin
    if d+i>MaxParcours then
    begin
      //Affiche('Erreur 187 : '+intToSTR(d+i),clred)
      result:=false;
      exit;
    end
    else
    tabloroute[dest,d+i]:=tabloParcours[source,i];
  end;
  if d+n<=MaxParcours then tabloroute[dest,0].adresse:=d+n;
  result:=true;
end;


// trouve toutes les routes de "depart" � "fin" ,
// "prec" est le d�part
// "actuel" est l'�l�ment suivant � pres  , pour le sens de rechercher au d�part
// remplit le tableau tabloroute[route,id] (route=index de la route trouv�e)
// on teste les aiguillages et les tjd sur toutes leurs positions
// proc�dure r�cursive
// tabloroute[n,0].adresse contient le nombre d'�l�ments de la route n
// prec,typePrec ; actuel,TypActuel : �l�ments contigus � explorer ; nroute : num�ro de la route , id=index dans la route; ir = n� de r�cursivit� : d�part,fin : d�tecteurs de d�part et de fin cliqu�s.
// retourne:
// 0 si trouv� adresse 0
// sorties anormale: ------
// 1 si max Parcours
// 2 si max routes
// 3 si max it�rations
// 4 si max r�cursivit�
// sorties normales: -----
// 5 si rebouclage sur d�part
// 6 si rebouclage sur �l�ment d�ja trait�  (n'est plus envisag� car c'est possible sur une route qui repasse)
// 7 fin exploration aiguillage
// 8 fin exploration TJD
// --------------
// 9 demande sortie (trop de traitements);
// 10 trouv� le d�tecteur "fin"
// 11 nouvelle route, vient apr�s 10
// 12 mauvais sens
// 13 trouv� d�tecteur � 1
// 14 trouv� d�tecteur interdit
// 15 d�tecteur obligatoire non trouv�
// 16 tjd non r�solue
// 98 erreur de type
// 99 erreur alg3
// Nota:
// sur un moyen r�seau (Djeff pour trouver toutes les routes, les param�tres sont:
// MaxRoutes:=10000
// MaxParcours=300
// Ctot=1 000 000
// ce qui est excessif, donc on limite une route � 150 �l�ments (MaxParcours)
function explore_el(prec : integer;typPrec : Tequipement;actuel : integer;TypActuel : Tequipement;var nroute : integer;id : integer;ir,depart,fin : integer;var ctot : integer) : integer;

  // copie la route dans la suivante
  procedure copie;
  var i : integer;
  begin
    if nroute+1<=Maxroutes then
    begin
      tabloroute[nroute+1,0].adresse:=id;   // nombre d'�l�ments de la route
      for i:=1 to id-1 do
        tabloroute[nroute+1,i]:=tabloroute[nroute,i];
    end;
  end;

  function test_reboucle : boolean;
  var i : integer;
  begin
    // voir si on reboucle sur un �l�ment d�ja trait�
    i:=1;
    while (i<id) do
    begin
      if ((tabloroute[nroute,i].adresse=tabloroute[nroute,id].adresse) and (tabloroute[nroute,i].pos=tabloroute[nroute,id].pos)) or    // prise en pointe en m�me position
         ((tabloroute[nroute,i].adresse=tabloroute[nroute,id].adresse) and (tabloroute[nroute,i].talon=tabloroute[nroute,id].talon))   // en talon
      then
      begin
        //Affiche('Route '+intToSTR(nroute)+' Rebouclage sur '+intToSTR(actuel),clOrange);
        result:=true;
        exit;
      end;
      inc(i);
      result:=false;
    end;
  end;

const
itmax=90;
var
suivant,indexAig,IndexAigSuiv,it,r,c1,c2,sensEL1c1,sensEL2c1,el1c1,el2c1,sensCirc1,SensCirc2,
NumCanton1,NumCanton2,origine,position,idx,indexAig2,TJDEntre,nEtats,i,k,sensEL1c2,sensEL2c2,
el1c2,el2c2,posPrec,TjdS,adresse2 : integer;
typSuiv,tel1c1,tel2c1,tel1c2,tel2c2 : tEquipement;
ok,AffRouteR,taig,Horzc1,Horzc2,DebugRoute : boolean;
s : string;
c : char;
begin
  proc:=Texplore_el;
  param1:=prec;
  param2:=actuel;
  inc(ctot);
  AffRouteR:=false;      // pour d�bug d�taill�
  DebugRoute:=formRoute.CheckBoxDebugRoutes.Checked;  // pour debug


  if ctot>1500000 then   // 500000 nombre d'it�rations
  begin
    result:=9;
    if affRouteR then
    Affiche('Sortie totale',clred);
    Affichedebug('Sortie totale Explore_el:'+intToSTR(prec)+' '+intToSTR(actuel),clred);
    exit;
  end;

  r:=0;

  if AffRouteR then Affiche('Explore_el '+intToSTR(prec)+' '+intToSTR(actuel)+' route='+intToSTR(nroute)+
     ' id='+intToSTR(id)+' ir='+intToSTR(ir)+' Depart='+intToSTR(depart)+' Fin='+intToSTR(fin)+'----------------',clYellow);
  it:=0;
  inc(ir);
  if ir>itMax then
  begin
    if affRouteR or DebugRoute then
    Affiche('MaxRecursivit� recherche route',clred);
    result:=4;
    exit;
  end;

  repeat
    if affRouteR then Affiche(intToSTR(id)+' : '+intToSTR(actuel),clyellow);
    if id>MaxParcours then
    begin
      if affRouteR or DebugRoute then Affiche('MaxParcours',clred);
      result:=1;
      exit;
    end;
    tabloroute[nRoute,id].adresse:=actuel;
    tabloroute[nRoute,id].typ:=typActuel;
    tabloRoute[nRoute,0].adresse:=id;

    // voir si le d�tecteur a un canton
    // et si le canton contient un sens de circulation impos� : canton[].el1 ou el2 typ1 typ2
    // exit si pas le bon sens du canton avec le code 12
    if (TypActuel=det) then  // un d�tecteur peut �tre jointif de 2 cantons
    begin
      NumCanton1:=0;
      if actuel<NbMaxDet then NumCanton1:=detecteur[actuel].canton1;    // num�ro de canton 1
      if numCanton1<>0 then  // il y a un canton
      begin
        c1:=Index_canton_numero(NumCanton1);
        SensCirc1:=canton[c1].SensCirc;
        el1c1:=canton[c1].el1;
        tel1c1:=canton[c1].typ1;
        el2c1:=canton[c1].el2;
        tel2c1:=canton[c1].typ2;
        sensEL1c1:=canton[c1].SensEl1;  //( SensGauche SensDroit SensHaut SensBas)
        sensEL2c1:=canton[c1].SensEl2;  //( SensGauche SensDroit SensHaut SensBas)
        Horzc1:=canton[c1].horizontal;
      end;

      numcanton2:=0;
      if actuel<NbMaxDet then NumCanton2:=detecteur[actuel].canton2;   // num�ro de canton 2
      if numcanton2<>0 then
      begin
        c2:=Index_canton_numero(NumCanton2);
        SensCirc2:=canton[c2].SensCirc;
        el1c2:=canton[c2].el1;
        tel1c2:=canton[c2].typ1;
        el2c2:=canton[c2].el2;
        tel2c2:=canton[c2].typ2;
        sensEL1c2:=canton[c2].SensEl1;  //( SensGauche SensDroit SensHaut SensBas)
        sensEL2c2:=canton[c2].SensEl2;  //( SensGauche SensDroit SensHaut SensBas)
        Horzc2:=canton[c2].horizontal;
      end;

      suivant:=suivant_alg3(prec,TypPrec,actuel,TypActuel,1);
      if suivant>9000 then
      begin
        Affiche('Erreur 96 : '+intToSTR(prec)+' '+intToSTR(actuel),clred);
        result:=suivant;
        exit;
      end;
      //v�rif si d�tecteur interdit (vient des cantons interdits)
      i:=1;

      while (list_det_int[i].adresse<>0) and (i<20) do
      begin
        if (actuel=list_det_int[i].adresse) and (typActuel=det) then
        begin
          if affRouteR or DebugRoute then
            Affiche('D�tecteur interdit: '+intToSTR(actuel)+' route='+intToSTR(nroute),clLime);
          result:=14;
          exit;           // le fait de faire un exit sans incr�menter le num�ro de route annule cette route, reprise de l'aiguillage pr�c�dent.
        end;
        inc(i);
      end;

      // d�tecteur � 1
      if (TypActuel=det) and (actuel<>depart) and (detecteur[actuel].Etat) then
      begin
        ok:=false;
        // si l'un des deux d�tecteurs est le final, ne pas consid�rer le detecteur � 1 de l'autre d�tecteur du canton
        if numcanton1<>0 then
        begin
          if ((el1c1=actuel) or (el2c1=actuel)) and ((el1c1=fin) or (el2c1=fin)) then ok:=true;
        end;
        if numcanton2<>0 then
        begin
          if ((el1c2=actuel) or (el2c2=actuel)) and ((el1c2=fin) or (el2c2=fin)) then ok:=true;
        end;

        if not ok then
        begin
          if affRouteR or DebugRoute then
          Affiche('Route '+intToSTR(nroute)+' annul�e car d�tecteur '+intToSTR(actuel)+' � 1',clyellow);
          result:=13;
          exit;
        end;
      end;

      //                                        le suivant doit �tre l'un des 2 �l�ments du canton
      if (numcanton1<>0) and (sensCirc1<>0) and ((suivant=el1c1) or (suivant=el2c1)) then
      begin
        if horzc1 then // si le canton 1 est horizontal
        begin
          ok:=(actuel=el2c1) and (sensEl2c1=sensDroit) and (SensCirc1=SensGauche) ;
          ok:=((actuel=el2c1) and (sensEl2c1=sensGauche) and (SensCirc1=SensDroit)) or ok;
          ok:=((actuel=el1c1) and (sensEl1c1=sensDroit) and (SensCirc1=SensGauche)) or ok ;
          ok:=((actuel=el1c1) and (sensEl1c1=sensGauche) and (SensCirc1=SensDroit)) or ok ;
          if not(ok) then begin
          if affRouteR or DebugRoute then
            Affiche('1 Canton '+intToSTR(NumCanton1)+' sens nok',clLime);
          result:=12;exit;end;
        end
        else
        begin  // le canton 1 est vertical
          ok:=(actuel=el2c1) and (sensEl2c1=sensBas) and (SensCirc1=SensHaut) ;
          ok:=((actuel=el2c1) and (sensEl2c1=sensHaut) and (SensCirc1=SensBas)) or ok;
          ok:=((actuel=el1c1) and (sensEl1c1=sensBas) and (SensCirc1=SensHaut)) or ok;
          ok:=((actuel=el1c1) and (sensEl1c1=sensHaut) and (SensCirc1=SensBas)) or ok;
          if not(ok) then begin
          if affRouteR or DebugRoute then
            Affiche('2 Canton '+intToSTR(NumCanton1)+' sens nok',clLime);
            result:=12;exit;end;
        end;
      end;

      if (numcanton2<>0) and (sensCirc2<>0) and ((suivant=el1c2) or (suivant=el2c2)) then
      begin
        if horzc2 then
        begin
          ok:=(actuel=el2c2) and (sensEl2c2=sensDroit) and (SensCirc2=SensGauche) ;
          ok:=((actuel=el2c2) and (sensEl2c2=sensGauche) and (SensCirc2=SensDroit)) or ok;
          ok:=((actuel=el1c2) and (sensEl1c2=sensDroit) and (SensCirc2=SensGauche)) or ok ;
          ok:=((actuel=el1c2) and (sensEl1c2=sensGauche) and (SensCirc2=SensDroit)) or ok ;
          if not(ok) then begin
          if affRouteR or DebugRoute then
            Affiche('3 Canton '+intToSTR(NumCanton2)+' sens nok',clLime);
            result:=12;exit;end;
        end
        else
        begin
          ok:=(actuel=el2c2) and (sensEl2c2=sensBas) and (SensCirc2=SensHaut) ;
          ok:=((actuel=el2c2) and (sensEl2c2=sensHaut) and (SensCirc2=SensBas)) or ok;
          ok:=((actuel=el1c2) and (sensEl1c2=sensBas) and (SensCirc2=SensHaut)) or ok;
          ok:=((actuel=el1c2) and (sensEl1c2=sensHaut) and (SensCirc2=SensBas)) or ok;
          if not(ok) then begin
          if affRouteR or DebugRoute then
            Affiche('4 Canton '+intToSTR(NumCanton2)+' sens nok',clLime);
            result:=12;exit;end;
        end;
      end;
    end;

    if actuel=0 then
    begin
      if affRouteR or DebugRoute then
      Affiche('Trouv� 0',clred);
      result:=0;
      exit;
    end;
    if id>=MaxParcours then
    begin
      if affRouteR or DebugRoute then
      Affiche('MaxParcours',clred);
      result:=1;
      exit;
    end;
    if nroute>=MaxRoutes then
    begin
      if affRouteR or DebugRoute then Affiche('MaxRoutes atteint',clred);
      Affichedebug('Max routes atteint: '+intToSTR(prec)+' '+intToSTR(actuel),clred);
      result:=2;
      exit;
    end;
    if (actuel=fin) and (id>2) then //   fin de route?
    begin
      tabloroute[nRoute,id].typ:=det;
      // voir si tous les d�tecteurs obligatoires sont dans la route

      for i:=1 to 20 do List_det_obl[i].n:=0;
      i:=1;
      while (list_det_obl[i].adresse<>0) and (i<20) do
      begin
        for k:=1 to tabloroute[nRoute,0].adresse do
        begin
          if (tabloRoute[nRoute,k].adresse=list_det_obl[i].adresse) and (tabloroute[nroute,k].typ=det) then
          begin
            inc(list_det_obl[i].n);    // incr�menter le nombre de d�tecteurs obligatoires
          end;
        end;
        inc(i);
      end;

      i:=1;
      while (list_det_obl[i].adresse<>0) and (i<20) do
      begin
        if list_det_obl[i].n=0 then
        begin
          if AffrouteR or DebugRoute then Affiche('D�tecteur obligatoire '+intToSTR(list_det_obl[i].adresse)+' absent',clorange);
          result:=15;
          exit;
        end;
        inc(i);
      end;

      if affRouteR or DebugRoute then Affiche('Trouv� d�tecteur final **********',clWhite);

      {if nroute=1 then
      for i:=1 to tabloroute[1,0].adresse do
      begin
        s:=intToSTR(i)+' : '+intToSTR(tabloroute[1,i].adresse)+' '+BTypeToChaine(tabloroute[1,i].typ)+' ';
        Affiche(s,clyellow);
      end; }
      copie;
      inc(nRoute);   // l'index ID ne change pas, on passe � la route suivante � l'index ID
      if nroute>NbreRoutes then NbreRoutes:=nroute;
      result:=10;
      exit;
    end;
    if (actuel=depart) and (ir>1) then
    begin
      if affRouteR or DebugRoute then affiche('Rebouclage',clred);
      result:=5;
      exit;
    end;

    taig:=(typactuel=Aig) or (typActuel=tjs) or (typactuel=crois) or (typActuel=tjd) or (typActuel=triple);

    if taig then
    begin
      // si aiguillage en pointe
      indexAig:=index_aig(actuel);
      // rechercher le type exact
      typactuel:=aiguillage[indexAig].modele;
      tabloroute[nRoute,id].typ:=typactuel;

      if (typactuel=aig) or (typactuel=triple)  then
      begin
        if aiguillage[indexAig].APointe=prec then // on le franchit en pointe
        begin
          inc(id);
          // faire droit
          tabloroute[nroute,id-1].pos:=const_droit;
          tabloroute[nroute,id-1].talon:=false;

          if affRouteR then Affiche('Faire droit aig'+intToSTR(actuel),clorange);
          suivant:=aiguillage[indexAig].ADroit;
          c:=aiguillage[indexAig].AdroitB;
          if (c='S') or (c='D') or (c='P') then typSuiv:=aig else TypSuiv:=det;
          if typSuiv=aig then
          begin
            indexAigSuiv:=index_aig(suivant);
            TypSuiv:=aiguillage[indexAigSuiv].modele;
          end;
          if suivant=0 then TypSuiv:=buttoir;

          if TypActuel=Triple then                  // pour prendre aiguillage droit droit
          begin
            inc(id);
            tabloroute[nroute,id-1].adresse:=aiguillage[indexAig].Adrtriple;
            tabloroute[nroute,id-1].typ:=triple;
            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].talon:=false;
          end;

          r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
          if affrouteR then affiche('1.Retour explore_el de l''aig '+intToSTR(actuel)+' pos droit :'+intToSTR(r),clCyan);
          if r=9 then
          begin
            result:=r;
            exit;
          end;
          if r=10 then
          begin
            result:=11;
            exit;
          end;
          // d�vi�
          if affRouteR then Affiche('Faire d�vi� aig'+intToSTR(actuel),clorange);
          suivant:=aiguillage[indexAig].ADevie;
          c:=aiguillage[indexAig].AdevieB;
          if (c='S') or (c='D') or (c='P') then typSuiv:=aig else TypSuiv:=det;
          if typSuiv=aig then
          begin
            indexAigSuiv:=index_aig(suivant);
            TypSuiv:=aiguillage[indexAigSuiv].modele;   // trouver le type exact (aig tjd ...)
          end;
          if suivant=0 then TypSuiv:=buttoir;


          if typActuel=Triple then             // 1ere position: d�vi�e : aig triple=adr1=devi� - adr2=droit
          begin
            dec(id);
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].talon:=false;
            inc(id);
            tabloroute[nroute,id-1].adresse:=aiguillage[indexAig].Adrtriple;

            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].talon:=false;
          end
          else
          begin
            // aig normal
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].talon:=false;
          end;
          if nroute>NbreRoutes then NbreRoutes:=nroute;
          r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
          if affrouteR then affiche('2.Retour explore_el de l''aig '+intToSTR(actuel)+' pos d�vi� :'+intToSTR(r),clCyan);
          if r=9 then
          begin
            result:=r;
            exit;
          end;
          if r=10 then
          begin
            result:=11;
          end;

          if typActuel<>triple then
          begin
            result:=7;  // fin exploration aiguillage
            exit;
          end
          else
          begin
            // d�vi� 2 du triple
            if affRouteR then Affiche('Faire d�vi�2 aig triple '+intToSTR(actuel),clorange);
            suivant:=aiguillage[indexAig].ADevie2;
            c:=aiguillage[indexAig].Adevie2B;
            if (c='S') or (c='D') or (c='P') then typSuiv:=aig else TypSuiv:=det;
            if typSuiv=aig then
            begin
              indexAigSuiv:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAigSuiv].modele;
            end;
            if suivant=0 then TypSuiv:=buttoir;
            dec(id);
            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].talon:=false;
            inc(id);
            tabloroute[nroute,id-1].adresse:=aiguillage[indexAig].Adrtriple;
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].talon:=false;

            r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
            if affrouteR then affiche('2.Retour explore_el de l''aig '+intToSTR(actuel)+' pos d�vi�2 :'+intToSTR(r),clCyan);
            if r=9 then
            begin
              result:=r;
              exit;
            end;
            if r=10 then
            begin
              result:=11;
            end;

            result:=7;
            exit;
          end;
        end
        else
        begin
          // aig ou triple en talon

          //d�terminer la position
          if typActuel=triple then
          begin
            tabloroute[nroute,id].talon:=true;

            inc(id);
            //indexAig2:=index_aig(aiguillage[indexaig].Adrtriple);
            tabloroute[nroute,id].adresse:=aiguillage[indexaig].Adrtriple;
            tabloroute[nroute,id].typ:=triple;

            if aiguillage[indexaig].Adroit=prec then
            begin
              tabloroute[nroute,id-1].pos:=const_droit;   // aig1
              tabloroute[nroute,id].pos:=const_droit; // aig2
            end;
            if aiguillage[indexaig].Adevie=prec then
            begin
              tabloroute[nroute,id-1].pos:=const_devie;
              tabloroute[nroute,id].pos:=const_droit;
            end;
            if aiguillage[indexaig].Adevie2=prec then
            begin
              tabloroute[nroute,id-1].pos:=const_droit;
              tabloroute[nroute,id].pos:=const_devie;
            end;

          end
          else
          begin
            if aiguillage[indexaig].Adevie=prec then tabloroute[nroute,id].pos:=const_devie;
            if aiguillage[indexaig].Adroit=prec then tabloroute[nroute,id].pos:=const_droit;
          end;
          tabloroute[nroute,id].talon:=true;

          {if test_reboucle then
          begin
            result:=6;
            if AffRouteR then Affiche('Reboucle sur '+intToSTR(actuel)+' �l�ment d�ja trait� ',clred);
            exit;
          end;}

          suivant:=aiguillage[indexAig].APointe;
          c:=aiguillage[indexAig].APointeB;
          if (c='S') or (c='D') or (c='P') then typSuiv:=aig else TypSuiv:=det;
          if typSuiv=aig then
          begin
            indexAigSuiv:=index_aig(suivant);
            TypSuiv:=aiguillage[indexAigSuiv].modele;
          end;
          if suivant=0 then TypSuiv:=buttoir;
          prec:=Actuel;
          typPrec:=TypActuel;
          actuel:=Suivant;
          TypActuel:=TypSuiv;
        end;
      end
      else

      if (typactuel=tjd) or (typactuel=tjs) then
      begin
        inc(id);
        origine:=tabloroute[nroute,id-2].adresse;   // d'o� on vient  : identique � prec/typprec !!
        prec:=origine;
        if (typPrec=aig) or (typPrec=tjd) or (typPrec=triple) then posPrec:=TabloRoute[nroute,id-2].pos; //position de l'aig pr�c�dent
        indexAig:=index_aig(actuel);                // 28: entr�e TJD
        TjdEntre:=actuel;
        nEtats:=aiguillage[indexAig].EtatTJD;
        if nEtats=2 then
        begin
          if affRouteR then Affiche('Faire travers�e directe tjd 2 �tats '+intToSTR(actuel),clorange);

          if ((aiguillage[indexAig].dDroit=prec) and    // on vient de ddroit
          (
            (
              typPrec=det) or (typPrec=buttoir)
            )
            or
            (
                  ((aiguillage[indexAig].DdroitB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].DdroitB='D') and (posprec=const_droit))
              and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
            )
          )
          then
          begin
            // travers�e de la tjd
            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;

            Suivant:=aiguillage[indexAig].Adroit;
            c:=aiguillage[IndexAig].AdroitB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end
          else
          if ((aiguillage[indexAig].DDevie=prec) and       // on vient de ddevi�
          (
            (
              typPrec=det) or (typPrec=buttoir)
            )
            or
            (
                  ((aiguillage[indexAig].DdevieB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].DdevieB='D') and (posprec=const_droit))
              and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
            )
          )
          then
          begin
            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;
            Suivant:=aiguillage[indexAig].Adevie;
            c:=aiguillage[IndexAig].AdevieB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end
          else
          if ((aiguillage[indexAig].Adroit=prec) and       // on vient de Adroit
          (
          (
            typPrec=det) or (typPrec=buttoir)
          )
          or
          (
                ((aiguillage[indexAig].AdroitB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].AdroitB='D') and (posprec=const_droit))
            and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
          )
          )
          then
          begin
            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;

            Suivant:=aiguillage[indexAig].Ddroit;
            c:=aiguillage[IndexAig].DdroitB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end

          else
          if ((aiguillage[indexAig].ADevie=prec) and       // on vient de adevi�
          (
          (
            typPrec=det) or (typPrec=buttoir)
          )
          or
          (
                ((aiguillage[indexAig].AdevieB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].AdevieB='D') and (posprec=const_droit))
            and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
          )
          )
          then
          begin
            tabloroute[nroute,id-1].pos:=const_droit;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;

            Suivant:=aiguillage[indexAig].Ddevie;
            c:=aiguillage[IndexAig].dDevieB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end
          else
          begin
            Affiche('Anomalie 580 : Route '+intToSTR(nroute)+' Id='+intToSTR(id)+' : pas de r�solution de la TJD 2 �tats '+intToSTR(actuel),clred);
            if c=#0 then c:=' ';
            Affiche('Origine = '+intToSTR(Origine)+c,clred);
            Affiche('In�galit� de '+intToSTR(aiguillage[indexAig].ADroit)+' ou '+intToSTR(aiguillage[indexAig].ADevie)+' avec : '+intToSTR(prec),clred);
            {for i:=1 to tabloroute[nroute,0].adresse do
            begin
              s:=intToSTR(i)+' : '+intToSTR(tabloroute[nroute,i].adresse)+' '+BTypeToChaine(tabloroute[nroute,i].typ)+' ';
              Affiche(s,clyellow);
            end;}
            result:=16;
            exit;
          end;
          r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
          // faire d�vi� TJD 2 �tats
          if affRouteR then
          begin
            Affiche('Retour de la travers�e directe tjd 2 �tats '+intToSTR(actuel),clorange);
          end;

          if r=9 then
          begin
            result:=r;
            exit;
          end;
          if r=10 then
          begin
            result:=11;
          end;

          // faire TJD en mode "courbe"
          // reprendre les �l�ments de la tjd entrante
          actuel:=TjdEntre;
          indexaig:=index_aig(actuel);
          if ((aiguillage[indexAig].dDroit=prec) and    // on vient de ddroit
          (
            (
              typPrec=det) or (typPrec=buttoir)
            )
            or
            (
                  ((aiguillage[indexAig].DdroitB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].DdroitB='D') and (posprec=const_droit))
              and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
            )
          )
          then
          begin
            // travers�e de la tjd
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;

            Suivant:=aiguillage[indexAig].Adevie;
            c:=aiguillage[IndexAig].AdevieB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end
          else
          if ((aiguillage[indexAig].DDevie=prec) and       // on vient de ddevi�
          (
            (
              typPrec=det) or (typPrec=buttoir)
            )
            or
            (
                  ((aiguillage[indexAig].DdevieB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].DdevieB='D') and (posprec=const_droit))
              and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
            )
          )
          then
          begin
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;
            Suivant:=aiguillage[indexAig].Adroit;
            c:=aiguillage[IndexAig].AdroitB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end
          else
          if ((aiguillage[indexAig].Adroit=prec) and       // on vient de Adroit
          (
          (
            typPrec=det) or (typPrec=buttoir)
          )
          or
          (
                ((aiguillage[indexAig].AdroitB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].AdroitB='D') and (posprec=const_droit))
            and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
          )
          )
          then
          begin
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;

            Suivant:=aiguillage[indexAig].Ddevie;
            c:=aiguillage[IndexAig].DdevieB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end

          else
          if ((aiguillage[indexAig].ADevie=prec) and       // on vient de adevi�
          (
          (
            typPrec=det) or (typPrec=buttoir)
          )
          or
          (
                ((aiguillage[indexAig].AdevieB='S') and (posprec=const_devie)) or ((aiguillage[indexAig].AdevieB='D') and (posprec=const_droit))
            and ((typPrec=aig) or (typPrec=tjd) or (typPrec=Triple))
          )
          )
          then
          begin
            // faire droit depuis extr�mit� Droit
            tabloroute[nroute,id-1].pos:=const_devie;
            tabloroute[nroute,id-1].typ:=tjd;
            tabloroute[nroute,id-1].adresse:=actuel;

            Suivant:=aiguillage[indexAig].Ddroit;
            c:=aiguillage[IndexAig].DdroitB;
            if ((c='Z') or (c=#0)) and (suivant<>0) then TypSuiv:=det;
            if ((c='Z') or (c=#0)) and (suivant=0) then TypSuiv:=buttoir;
            if (c='P') or (c='S') or (c='D') then
            begin
              IndexAig:=index_aig(suivant);
              TypSuiv:=aiguillage[indexAig].modele;
            end;
          end
          else
          begin
            Affiche('Anomalie 580 : Route '+intToSTR(nroute)+' Id='+intToSTR(id)+' : pas de r�solution de la TJD 2 �tats '+intToSTR(actuel),clred);
            if c=#0 then c:=' ';
            Affiche('Origine = '+intToSTR(Origine)+c,clred);
            Affiche('In�galit� de '+intToSTR(aiguillage[indexAig].ADroit)+' ou '+intToSTR(aiguillage[indexAig].ADevie)+' avec : '+intToSTR(prec),clred);
            {for i:=1 to tabloroute[nroute,0].adresse do
            begin
              s:=intToSTR(i)+' : '+intToSTR(tabloroute[nroute,i].adresse)+' '+BTypeToChaine(tabloroute[nroute,i].typ)+' ';
              Affiche(s,clyellow);
            end;}
            result:=16;
            exit;
          end;
          r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
          // faire d�vi� TJD 2 �tats
          if affRouteR then Affiche('Retour de la travers�e courbe tjd 2 �tats '+intToSTR(actuel),clorange);
          if r=9 then
          begin
            result:=r;
            exit;
          end;
          if r=10 then
          begin
            result:=11;
          end;
          result:=8;
          exit;
        end;

        if nEtats=4 then
        begin
          //************************VERSION 3
          if affRouteR then
          Affiche('Faire travers�e directe tjd 4 �tats '+intToSTR(actuel),clorange);

          // TJD d'entr�e
          origine:=prec;

          TjdS:=aiguillage[indexAig].Ddroit;          // TJD de sortie
          indexAig2:=index_Aig(TjdS);

          // trouver la bonne entr�e de la TJD
          if (aiguillage[indexAig2].Adroit=prec) or (aiguillage[indexAig2].ADevie=prec) then
          begin
            // c'est l'autre!
            Echange(actuel,TjdS);  // inverser les adresses
            Echange(IndexAig,IndexAig2); // et les index
          end;

          TjdEntre:=actuel;
          tabloroute[nroute,id-1].typ:=tjd;
          tabloroute[nroute,id-1].adresse:=actuel;    // 28


          if typSuiv=det then c:='Z';

          if (typPrec=Tjd) or (TypPrec=det) then   //le pr�c�dent est une TJD ou un d�tecteur (trait� de la m�me fa�on, on ne v�rifie pas l'�l�ment B)
          begin
            // chercher d'ou on vient de la TJD
            if aiguillage[indexAig].Adroit=prec then
            begin
              tabloroute[nroute,id-1].pos:=const_droit;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              // tjd homologue
              tabloroute[nroute,id].pos:=const_droit;   // faire droit
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].ADroit;     // 26 sortie TJD, direction droit
              c:=aiguillage[indexAig2].AdroitB;
            end;
            if aiguillage[indexAig].ADevie=prec then
            begin
               // on vient de la position d�vi�e de l'entr�e de la TJD, ce qui d�termine l'aiguille de sortie
              tabloroute[nroute,id-1].pos:=const_devie;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_devie;   // faire d�vi�
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].ADevie;     // 26 sortie TJD
              c:=aiguillage[indexAig2].AdevieB;
            end;
          end;

          if (typPrec=aig) or (typPrec=triple) then  // le pr�c�dent est un aiguillage ou un triple
          begin
            // si l'aig pr�c est d�vi� et n'a pas �t� pris en talon
            c:='P';
            if not tabloroute[nroute,id-2].talon then
            begin
              if typprec=triple then
              begin
                // position de l'aig triple:
                // Droit  : droit droit : le pr�c�dent est la 2�me adresse
                // D�vi�1 : d�vi� droit : le pr�c�dent est la 1ere adresse
                // D�vi�2 : droit d�vi� : le pr�c�d�nt est la 2�me adresse
                if (tabloroute[nroute,id-3].pos=const_droit) and (tabloroute[nroute,id-2].pos=const_droit) then c:='D';
                if (tabloroute[nroute,id-3].pos=const_devie) and (tabloroute[nroute,id-2].pos=const_droit) then
                begin
                  c:='S';
                  prec:=tabloroute[nroute,id-3].adresse;
                end;
                if (tabloroute[nroute,id-3].pos=const_droit) and (tabloroute[nroute,id-2].pos=const_devie) then c:='S';
              end
              else if tabloroute[nroute,id-2].pos=const_devie then c:='S' else c:='D';
            end;

            // test d'ou l'on vient sur la tjd
            if (aiguillage[indexAig].ADroit=prec) and (aiguillage[indexAig].ADroitB=c) then     // on vient de Adroit
            begin
              // on vient de la position droite de l'entr�e de la TJD, ce qui d�termine l'aiguille de sortie
              tabloroute[nroute,id-1].pos:=const_droit;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_droit;   // faire droit
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].ADroit;     // 26 sortie TJD, direction droit
              c:=aiguillage[indexAig2].AdroitB;
            end
            else

            if (aiguillage[indexAig].ADevie=prec) and (aiguillage[indexAig].ADevieB=c) then     // on vient de Adevie
            begin
              // on vient de la position d�vi�e de l'entr�e de la TJD, ce qui d�termine l'aiguille de sortie
              tabloroute[nroute,id-1].pos:=const_devie;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_devie;   // faire d�vi�
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].ADevie;     // 26 sortie TJD
              c:=aiguillage[indexAig2].AdevieB;
            end
            else
            begin
              Affiche('Anomalie 584 : Route '+intToSTR(nroute)+' Id='+intToSTR(id)+' : pas de r�solution de la TJD '+intToSTR(actuel),clred);
              if c=#0 then c:=' ';
              Affiche('Origine = '+intToSTR(Origine)+c,clred);
              Affiche('In�galit� de '+intToSTR(aiguillage[indexAig].ADroit)+' ou '+intToSTR(aiguillage[indexAig].ADevie)+' avec : '+intToSTR(prec),clred);
              result:=16;
              exit;
            end;
          end;

          if (c='Z') or (c=#0) then TypSuiv:=det;
          if suivant=0 then TypSuiv:=buttoir;
          if (c='S') or (c='D') or (c='P') then typSuiv:=aig else TypSuiv:=det;
          if typSuiv=aig then
          begin
            indexAigSuiv:=index_aig(suivant);
            TypSuiv:=aiguillage[indexAigSuiv].modele;
          end;
          r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
          if affrouteR then affiche('3.Retour explore_el de la tjd '+intToSTR(actuel)+' pos droit :'+intToSTR(r),clCyan);
          if r=9 then      // demande de sortie
          begin
            result:=r;
            exit;
          end;
          if r=10 then    // trouv� le d�tecteur de fin
          begin
            result:=11;
          end;

          actuel:=TjdEntre;
          if affRouteR then
          // faire courbe TJD - il faut positionner la premi�re adresse � d�vi� et la 2�me � droit
          Affiche('Faire travers�e courbe tjd 4 �tats'+intToSTR(actuel),clorange);
          if typSuiv=det then c:='Z';
          TypActuel:=Tjd;
          c:=aiguillage[indexAig2].AdevieB;
          dec(id);
          origine:=tabloroute[nroute,id-2].adresse;
          tabloroute[nroute,id-1].typ:=tjd;
          tabloroute[nroute,id-1].adresse:=actuel;    // 28
          TjdS:=aiguillage[indexAig].Ddroit;          // TJD de sortie
          indexAig2:=index_Aig(TjdS);

          if (typPrec=Tjd) or (TypPrec=det) then   //le pr�c�dent est une TJD ou un d�tecteur
          begin
            // chercher d'ou on vient de la TJD
            if aiguillage[indexAig].Adroit=prec then
            begin
               tabloroute[nroute,id-1].pos:=const_devie;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_droit;
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].Adevie;     // 26 sortie TJD, direction droit
              c:=aiguillage[indexAig2].AdevieB;
            end;
            if aiguillage[indexAig].ADevie=prec then
            begin
               // on vient de la position d�vi�e de l'entr�e de la TJD, ce qui d�termine l'aiguille de sortie
              tabloroute[nroute,id-1].pos:=const_droit;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_devie;
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].Adroit;     // 26 sortie TJD
              c:=aiguillage[indexAig2].AdroitB;           // ok cas valid�
            end;
          end;
          if (typPrec=aig) or (typprec=triple) then  // le pr�c�dent est un aiguillage
          begin
            // si l'aig pr�c est d�vi� et n'a pas �t� pris en talon
            c:='P';
            if not tabloroute[nroute,id-2].talon then
            begin
              if typprec=triple then
              begin
                // position de l'aig triple:
                // Droit  : droit droit : le pr�c�dent est la 2�me adresse
                // D�vi�1 : d�vi� droit : le pr�c�dent est la 1ere adresse
                // D�vi�2 : droit d�vi� : le pr�c�d�nt est la 2�me adresse
                if (tabloroute[nroute,id-3].pos=const_droit) and (tabloroute[nroute,id-2].pos=const_droit) then c:='D';
                if (tabloroute[nroute,id-3].pos=const_devie) and (tabloroute[nroute,id-2].pos=const_droit) then
                begin
                  c:='S';
                  prec:=tabloroute[nroute,id-3].adresse;
                end;
                if (tabloroute[nroute,id-3].pos=const_droit) and (tabloroute[nroute,id-2].pos=const_devie) then c:='S';
              end
              else if tabloroute[nroute,id-2].pos=const_devie then c:='S' else c:='D';
            end;

            // test d'ou l'on vient sur la tjd
            if (aiguillage[indexAig].ADroit=prec) and (aiguillage[indexAig].ADroitB=c) then     // on vient de Adroit
            begin
              // on vient de la position droite de l'entr�e de la TJD, ce qui d�termine l'aiguille de sortie
              tabloroute[nroute,id-1].pos:=const_devie;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_droit;
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].Adevie;     // 26 sortie TJD, direction droit
              c:=aiguillage[indexAig2].AdevieB;
            end
            else
            if (aiguillage[indexAig].ADevie=prec) and (aiguillage[indexAig].ADevieB=c) then     // on vient de Adevie
            begin
              // on vient de la position d�vi�e de l'entr�e de la TJD, ce qui d�termine l'aiguille de sortie
              tabloroute[nroute,id-1].pos:=const_droit;
              // sortie de TJD 4 �tats
              actuel:=TjdS;
              TypActuel:=tjd;

              tabloroute[nroute,id].pos:=const_devie;
              tabloroute[nroute,id].typ:=tjd;
              tabloroute[nroute,id].adresse:=TjdS;
              inc(id);

              suivant:=aiguillage[indexAig2].ADroit;     // 26 sortie TJD
              c:=aiguillage[indexAig2].AdroitB;
            end
            else
            begin
              Affiche('Anomalie 585 : Route '+intToSTR(nroute)+' Id='+intToSTR(id)+' : pas de r�solution de la TJD '+intToSTR(actuel),clred);
              if c=#0 then c:=' ';
              Affiche('Origine = '+intToSTR(Origine)+c,clred);
              Affiche('In�galit� de '+intToSTR(aiguillage[indexAig].ADroit)+' ou '+intToSTR(aiguillage[indexAig].ADevie)+' avec : '+intToSTR(prec),clred);
              result:=16;
              exit;
            end;
          end;

          if (c='Z') or (c=#0) then TypSuiv:=det;
          if suivant=0 then TypSuiv:=buttoir;
          if (c='S') or (c='D') or (c='P') then typSuiv:=aig else TypSuiv:=det;
          if typSuiv=aig then
          begin
            indexAigSuiv:=index_aig(suivant);
            TypSuiv:=aiguillage[indexAigSuiv].modele;
          end;
          r:=explore_El(actuel,typActuel,Suivant,TypSuiv,nroute,id,ir,depart,fin,ctot);
          if affrouteR then affiche('3.Retour explore_el de la tjd '+intToSTR(actuel)+' pos droit :'+intToSTR(r),clCyan);
          if r=9 then      // demande de sortie
          begin
            result:=r;
            exit;
          end;
          if r=10 then    // trouv� le d�tecteur de fin
          begin
            result:=11;
          end;
          result:=8;
          exit;
        end;
      end
      else

      if (typActuel=crois) then
      begin
        indexAig:=index_aig(actuel);
        if aiguillage[indexAig].Adroit=prec then begin suivant:=aiguillage[indexAig].Ddroit;c:=aiguillage[indexAig].DdroitB;end;
        if aiguillage[indexAig].Adevie=prec then begin suivant:=aiguillage[indexAig].Ddevie;c:=aiguillage[indexAig].DdevieB;end;
        if aiguillage[indexAig].Ddevie=prec then begin suivant:=aiguillage[indexAig].Adevie;c:=aiguillage[indexAig].AdevieB;end;
        if aiguillage[indexAig].Ddroit=prec then begin suivant:=aiguillage[indexAig].Adroit;c:=aiguillage[indexAig].AdroitB;end;
        if (c='S') or (c='D') or (c='P') then TypSuiv:=aig else typSuiv:=det;
        if suivant=0 then typSuiv:=buttoir;
        prec:=Actuel;
        typPrec:=TypActuel;
        actuel:=Suivant;
        TypActuel:=TypSuiv;
      end;
    end
    else

    if typActuel=det then
    begin
      // d�tecteur
      tabloroute[nRoute,id].typ:=det;

      suivant:=suivant_alg3(prec,typPrec,actuel,TypActuel,1);
      typSuiv:=typegen;

      prec:=Actuel;
      typPrec:=TypActuel;
      actuel:=Suivant;
      TypActuel:=TypSuiv;
    end;
    inc(id);
    inc(it);
  until (it>50);
  result:=3;
  if affRouteR then Affiche('Max it�rations',clred);
end;

procedure supprime_route(route : integer);
var i : integer;
begin
  if NbreRoutes+1>Maxroutes then NbreRoutes:=MaxRoutes-1;
  for i:=route to NbreRoutes do
    tabloRoute[i]:=tabloRoute[i+1];
  dec(NbreRoutes);
end;

// trouve les routes du canton selon le sens � arriv�e
// IndexTCO : indexTCO dans lequel on a choisi la route
// CantonOrg : canton de d�part (num�ro)
// arrivee : d�tecteur � trouver
// sens de d�marrage du canton de d�part
function prepare_route(IndexTCO,CantonOrg,arrivee,sens : integer) : integer;
var r,i,j,n,p,nroute,id,Suiv,ctot,IndexCanton,prec,detDepart,det1,det2 : integer;
    s : string;
    T1,t2,typeS,TypeP : tequipement;
    tg : boolean;
    temp : Tuneroute;
begin
  TraceListe:=false;
  if traceliste then
  begin
    s:='prepare_route de canton='+intToSTR(CantonOrg)+' � '+intToSTR(arrivee);
    case sens of
    SensTCO_O : s:=s+' gauche';
    SensTCO_E : s:=s+' droite';
    SensTCO_N : s:=s+' haut';
    SensTCO_S : s:=s+' bas';
    else s:=s+' inconnu';
    end;
    // � gauche(5) du d�tecteur / droite (6) / en bas (8) / haut (7)
    Affiche(s,clYellow);
  end;

  // initialisation de la route � 0
  for j:=1 to Maxroutes do
    for i:=0 to MaxParcours do
    begin
      tabloRoute[j,i].adresse:=0;
      tabloRoute[j,i].typ:=rien;
      tabloRoute[j,i].pos:=0;
      tabloRoute[j,i].traite:=false;
    end;

  raz_route_fenetre;
  NbreRoutes:=0;

  indexCanton:=index_canton_numero(CantonOrg);
  // trouver l'�l�ment pr�c�dent/suivant
  {case sens of
    SensTCO_O : begin prec:=canton[indexcanton].el2;TypeP:=canton[indexcanton].Typ2;Suiv:=canton[indexcanton].el1;TypeS:=canton[indexcanton].Typ1;end;
    SensTCO_E : begin prec:=canton[indexcanton].el1;TypeP:=canton[indexcanton].Typ1;Suiv:=canton[indexcanton].el2;TypeS:=canton[indexcanton].Typ2;end;
    SensTCO_N : begin prec:=canton[indexcanton].el2;TypeP:=canton[indexcanton].Typ2;Suiv:=canton[indexcanton].el1;TypeS:=canton[indexcanton].Typ1;end;
    SensTCO_S : begin prec:=canton[indexcanton].el1;TypeP:=canton[indexcanton].Typ1;Suiv:=canton[indexcanton].el2;TypeS:=canton[indexcanton].Typ2;end;
  end;
  }
  // la proc�dure explore_el attend un d�tecteur en 1er param�tre et un �l�ment en 2�me param�tre

  detDepart:=0;

  // convention : le 1er �l�ment de la route doit �tre un d�tecteur
  // d�marrer sur le d�tecteur � 1 du canton
  det1:=canton[indexcanton].el1;T1:=canton[indexcanton].Typ1;
  det2:=canton[indexcanton].el2;T2:=canton[indexcanton].Typ2;

  prec:=0;
  if t1=det then
  begin
    if detecteur[det1].Etat then prec:=det1;
  end;
  if t2=det then
  begin
    if detecteur[det2].Etat then prec:=det2;
  end;
  if prec=0 then
  begin
    FormRoute.ListBoxRoutes.Clear;
    FormRoute.ListBoxRoutes.items.AddObject('Erreur 846: aucun des deux d�tecteurs du canton n''est activ�',pointer(CoulText));
    result:=1;
    exit;
  end;
  detDepart:=prec;
  TypeP:=det;

  zone_tco(indexTCO,DetDepart,det,sens,13,false,false);    // trouver le suivant dans le sens, r�sultat dans xCanton, tel1
  Suiv:=xCanton;
  TypeS:=tel1;

  if Suiv=0 then
  begin
    FormRoute.ListBoxRoutes.Clear;
    FormRoute.ListBoxRoutes.items.AddObject('Erreur 15 : le sens de la loco du canton de d�part aboutit � un buttoir',pointer(CoulText));
    result:=2;
    exit;
  end;

  if detDepart=0 then
  begin
    FormRoute.ListBoxRoutes.Clear;
    FormRoute.ListBoxRoutes.items.AddObject('Erreur 14 : configuration canton '+intToSTR(cantonOrg)+' sans d�tecteur contigu',pointer(CoulText));
    result:=3;
    exit;
  end;

  // v�rifier si le suivant est une TJD, et v�rifier si c'est la bonne adresse de la TJD
  if (TypeS=aig) or (TypeS=tjd) or (typeS=Triple) then
  begin
    i:=index_aig(suiv);
    TypeS:=aiguillage[i].modele;
  end;
  if typeS=TJD then
  begin
    if (aiguillage[i].ADroit<>DetDepart) and (aiguillage[i].ADevie<>DetDepart) then
    begin
      // c'est l'autre
      j:=index_aig(aiguillage[i].DDevie);
      suivant:=aiguillage[j].Adresse;
    end;
  end;

  // stocker le d�part
  nroute:=1;
  detAtrouve:=arrivee;
  id:=1;
  ctot:=0;
  tabloroute[nroute,id].adresse:=DetDepart;
  tabloroute[nroute,id].typ:=det;
  tabloroute[nroute,0].adresse:=1;   // nombre d'�l�ments
  inc(id);

  // trouve toutes les routes de DetDeprt � Suivant
  Screen.Cursor:=crSQLWait;
  r:=explore_el(prec,TypeP,suiv,TypeS,nroute,id,0,DetDepart,detAtrouve,ctot);

 {
  for j:=1 to NbreRoutes do
  begin
    n:=tabloroute[j,0].adresse;
    Affiche('Route '+intToSTR(j)+' n='+intToSTR(n),clwhite);
  end;
  }
  TraceListe:=false;
  if NbreRoutes>1 then Dec(NbreRoutes);  // la derni�re route est forc�ment mauvaise
  if TraceListe then
  Affiche('Trouv� '+intToSTR(NbreRoutes)+' routes',clYellow);
  // supprimer les routes inutiles : trop grandes ou qui se rebouclent ou qui ont un d�tecteur de fin qui n'est pas celui attendu
  j:=1;
  repeat
    n:=tabloroute[j,0].adresse;
    //if traceListe then Affiche('Route '+inttostr(j)+' Nbre='+inttostr(n),clWhite);
    tg:=n>MaxParcours;

    if tg or (tabloroute[j,n].adresse<>detAtrouve) then
    begin
      s:=' Supprime route '+intToSTR(j)+' ';
      if tg then s:=s+' trop grande ;';
      if traceListe then
      Affiche_suivi(s,clOrange);

      supprime_route(j);
    end
    else inc(j);
  until j>NbreRoutes;

  traceliste:=false;
  // trier les routes de l plus petite � la plus grande
  tg:=true;
  while tg do
  begin
    tg:=false;
    for i:=1 to NbreRoutes-1 do
    begin
      n:=tabloroute[i,0].adresse;
      if n>tabloroute[i+1,0].adresse then
      begin
        temp:=tabloroute[i];
        tabloroute[i]:=tabloroute[i+1];
        tabloroute[i+1]:=temp;
        tg:=true;
      end;
    end;
  end;
  TraceListe:=False;
  Screen.Cursor:=crDefault;

  if traceListe then
  for j:=1 to NbreRoutes do
  begin
    n:=tabloroute[j,0].adresse;
    Affiche('Route '+intToSTR(j)+' ---------------n='+intToSTR(n),clwhite);
    for i:=1 to n do
    begin
      s:=intToSTR(tabloroute[j,i].adresse)+' '+BTypeToChaine(tabloroute[j,i].typ)+' ';
      p:=tabloRoute[j,i].pos;
      case p of
        const_droit : s:=s+'droit';
        const_devie : s:=s+'dev';
        0 : s:=s+'talon';
        else s:=s+intToSTR(p);
      end;
      if tabloroute[j,i].talon then s:=s+' (talon)';
      Affiche(s,clyellow);
    end;
  end;
  if traceListe then Affiche('il y a '+intToSTR(NbreRoutes)+' routes',clYellow);
  result:=0;
end;

function route_restreinte_to_string(tablo : tUneRoute) : string;
var i,p,n : integer;
    typ : tequipement;
    s : string;
begin
  s:='';
  n:=tablo[0].adresse;
  if n<>0 then
  begin
    s:=intToSTR(tablo[1].adresse)+'->';  // premier d�tecteur
    for i:=1 to n do
    begin
      p:=tablo[i].pos;
      typ:=tablo[i].typ;
      if ((typ=aig) or (typ=tjd) or (typ=tjs) or (typ=triple)) and (not(tablo[i].talon)) then
      begin
        s:=s+intToSTR(tablo[i].adresse)+' ';
        case p of
          const_droit : s:=s+'droit';
          const_devie : s:=s+'dev';
          else s:=s+intToSTR(p);
        end;
        s:=s+'->';
      end;
    end;
    s:=s+intToSTR(tablo[n].adresse);  // dernier d�tecteur
  end;
  result:=s;
end;

function route_totale_to_string(tablo : tUneRoute) : string;
var i,p,n : integer;
    typ : tequipement;
    s : string;
begin
  s:='';
  n:=tablo[0].adresse;
  if n<>0 then
  begin
    // s:=intToSTR(tablo[1].adresse)+'->';  // premier d�tecteur
    s:='';
    for i:=1 to n do
    begin
      s:=s+intToSTR(tablo[i].adresse);
      typ:=tablo[i].typ;
      if (typ=tjd) or (typ=tjs) or (typ=aig) or (typ=triple) then
      begin
        p:=tablo[i].pos;
        case p of
          const_droit : s:=s+'droit';
          const_devie : s:=s+'dev';
          else s:=s+intToSTR(p);
        end;
      end;
      if typ=crois then s:=s+'crois';
      if i<n then s:=s+'->';
    end;
  end;
  result:=s;
end;

procedure Affiche_routes_brut;
var i,j,n,p,nr : integer;
    s : string;
    typ : tequipement;
begin
  nr:=0;
  for i:=1 to Ntrains do
  begin
    with trains[i] do
    begin
      n:=route[0].adresse;
      if n<>0 then
      begin
        inc(nr);
        Affiche('Route du train '+Nom_Train+' ---------------n='+intToSTR(n),clwhite);
        for j:=1 to n do
        begin
          s:=inttoSTR(j)+':  '+intToSTR(route[j].adresse)+' '+BTypeToChaine(route[j].typ)+' ';
          p:=Route[j].pos;
          typ:=Route[j].typ;
          if (typ=aig) or (typ=tjd) or (typ=tjs) or (typ=triple) then
          begin
            case p of
            const_droit : s:=s+'droit';
            const_devie : s:=s+'dev';
            0 : s:=s+'talon';
            else s:=s+intToSTR(p);
            end;
            if route[j].talon then s:=s+' (en talon)';
          end;
          if route[j].traite then s:=s+' Trait�' else s:=s+' Non trait�';
          Affiche(s,clyellow);
        end;
      end ;
    end;
  end;
  if nr=0 then Affiche('Aucune route sur aucun train',ClWhite);
end;

procedure TFormPrinc.Routes1Click(Sender: TObject);
begin
  with formRouteTrain do
  begin
    TabSheetRA.Enabled:=true;
    show;
  end;
end;

procedure TFormPrinc.Codificationdestrains1Click(Sender: TObject);
var i : integer;
begin
  for i:=1 to nTrains do
  begin
    Affiche('Train '+intToSTR(i)+' @='+intToSTR(trains[i].adresse)+' '+trains[i].nom_train+
            ' Roulage='+intToSTR(trains[i].roulage)+
            ' Vitesse='+intToSTR(trains[i].vitesseCons)+
            ' DernierDet='+intToSTR(trains[i].dernierDet)+
            ' sur canton='+intToSTR(trains[i].canton)+
            ' BlocUSB='+intToSTR(trains[i].BlocUSB)
            ,clyellow);
     //       ' DetDepart='+intToSTR(trains[i].Det_depart)+' DetFin='+intToSTR(trains[i].Det_fin),clYellow);
  end;
end;

procedure TFormPrinc.Afficheroutespartrain1Click(Sender: TObject);
begin
  Affiche_routes_brut;
end;

procedure TFormPrinc.Sauvegarderlaconfiguration1Click(Sender: TObject);
begin
  Sauve_config;
end;

procedure TFormPrinc.MesurerlavitessedestrainsClick(Sender: TObject);
begin
  if not diffusion then FormMesure.showModal;
  if CDM_connecte then
  begin
    Affiche('La mesure de la vitesse des trains n''est disponible qu''en mode autonome sans CDM rail',clYellow);
    exit;
  end;
  if (parSocketLenz or portCommOuvert) then FormMesure.showModal
  else Affiche('Interface non connect�e',clYellow);
end;


procedure TFormPrinc.Affichelamesuredesvitesses1Click(Sender: TObject);
begin
  Affiche_mesure_trains;
end;

procedure TFormPrinc.Button0Click(Sender: TObject);
begin
{  EditVitesse.Text:='0';
  TrackBarVit.Position:=0; }
end;

procedure TFormPrinc.Compilerlabasededonnes1Click(Sender: TObject);
begin
  genere_informations_BD;
  Affiche('Recompilation des bases de donn�es termin�e',clLime);
end;

{
procedure TFormPrinc.ButtonEssaiClick(Sender: TObject);
var ABitMap : TBitMap;
    sin,cos,angle : extended;
    xc,yc : integer;

  procedure DessineAiguille(Angle,Scale : single;AWidth : integer);
  var SR : single;
  begin

    with ABitMap.Canvas do
    begin
      Pen.Width:=AWidth;
      MoveTo(xc div 2,yc div 2);
      SR:=Scale*50;
      sincos(Angle,sin,cos);
      LineTo(round(SR*sin)+ (xc div 2),round(-SR*cos)+ (yc div 2));
    end;
  end;

begin
  angle:=20;
  xc:=ImageCompteur.Width ;
  yc:=ImageCompteur.Height ;

  // Cr�e le bitmap AbitMap hors �cran
  ABitMap:=TBitMap.Create;
  // dessine les aiguilles sur l'image hors �cran
  // Attributs du bitmap hors �cran
  ABitMap.Width:=xc;
  ABitMap.Height:=yc;

   // Copie l'image de fond du bitmap dans le bitmap hors �cran
  ABitMap.Canvas.CopyMode:=cmSrcCopy;
  ABitMap.Canvas.CopyRect(ABitMap.Canvas.ClipRect,ImageCompteur.Canvas,ImageCompteur.Canvas.ClipRect);
  // Dessine les nouvelles aiguilles dans le bitmap hors �cran

  ABitMap.Canvas.Pen.color:=clred;
  DessineAiguille(50*pisur30,50, 10);   // minute


  // copie le bitmap hors �cran (Abitmap) dans l'horloge
  ImageCompteur.Canvas.CopyMode:=cmSrcCopy;
  ImageCompteur.Canvas.Draw(0,0,ABitMap);              // copie formclock.canvas<-Abitmap
  ABitMap.Free;

end;

procedure Cree_fond_compteur;
  // Dessine les tirets minute sur FBitMap
  procedure DessineTiretsMn;
  const EpGd=2;       // epaisseurs grands marqueurs 12 3 6 9
        LgGd=12;      // longueur grands marqueurs
        EpPt=0.5;       // epaisseurs petits marqueurs
        LgPt=7;       // longueur petits marqueurs
  var
    lg,OfsX,LapStepW : integer;
    Angle,cangle : integer;
    SR,ep : single;
    sin,cos : extended;
    x1,y1,x2,y2,x3,y3,x4,y4 : integer;
  begin
    FCBitMap.Free;
    FCBitMap:=TBitMap.Create;
    FCBitMap.Width:=140;
    FCBitMap.Height:=80;
    with FCBitMap.Canvas do
    begin
      Brush.Style:=bsSolid;
      Brush.Color:=$e0e0e0;
      FillRect(ClipRect);
    end;
    RayonCompteur:=round(FCBitMap.Height / 1.2);
    LapStepW:=5;
    OfsX := LapStepW div 2;
    Angle:=92;
    XcentreCompteur:=FCBitMap.Width div 2;
    YcentreCompteur:=70;
    FCBitMap.Canvas.Pen.color:=Clblue;
    FCbitmap.canvas.Brush.Color:=clBlue;
    cangle:=0;
    while Angle<274 do
    begin
      if cAngle mod 5 = 0 then
      begin
        // grands marqueurs
        ep:=EpGd;
        lg:=LgGd;
      end
      else
      begin
        ep:=EpPt;
        lg:=LgPt;
      end;

      sr:=RayonCompteur + OfsX;
      sincos((Angle+Ep)*pisur180,cos,sin);
      x1:=round(-sr*cos)+XcentreCompteur; y1:=round(sr*sin)+YcentreCompteur;

      sincos((Angle-Ep)*pisur180,cos,sin);
      x2:=round(-sr*cos)+XcentreCompteur; y2:=round(sr*sin)+YcentreCompteur;

      if Angle=0 then   //6h
      begin
        inc(x2);
        x3:=x2;y3:=y2-lg;
        x4:=x1;y4:=y1-lg;
      end
      else
      if Angle=90 then //3h
      begin
        inc(y1);
        x3:=x2-lg;y3:=y2;
        x4:=x1-lg;y4:=y1;
      end
      else
      if Angle=180 then  //0h
      begin
        inc(x1);
        x3:=x2;y3:=y2+lg;
        x4:=x1;y4:=y1+lg;
      end
      else
      if Angle=270 then  //9h
      begin
        inc(y2);
        x3:=x2+lg;y3:=y2;
        x4:=x1+lg;y4:=y1;
      end
      else
      begin
        sr:=(RayonCompteur-lg) + OfsX;
        sincos((Angle-Ep)*pisur180,sin,cos);
        x3:=round(-sr*sin)+XcentreCompteur; y3:=round(sr*cos)+YcentreCompteur;

        sincos((Angle+Ep)*pisur180,sin,cos);
        x4:=round(-sr*sin)+XcentreCompteur; y4:=round(sr*cos)+YcentreCompteur;
      end;

      FCbitmap.canvas.polygon([point(x1,y1),point(x2,y2),point(x3,y3),point(x4,y4)]);

      inc(Angle,6);
      inc(cangle,6);
    end;
  end; // DrawMinSteps

begin

  DessineTiretsMn;
  with formprinc.ImageC do
  begin
    left:=350;
    Width:=FCbitMap.Width;
    Height:=FCbitMap.Height;
    Picture.Bitmap.Width:=FCbitMap.Width;
    Picture.Bitmap.Height:=FCbitMap.Height;
    stretch:=false;
    canvas.Draw(0,0,FCBitMap);
 //
  end;

end;   }

procedure TFormPrinc.PopupMenuTrainsPopup(Sender: TObject);
var ob : TPopupMenu;
begin
  // AdrPilote est r�cup�r� de l'event OnMouseDown de l'image du signal qui se produit avant
  if Affevt then Affiche('PopupMenuTrain',clYellow);
  ob:=Sender as Tpopupmenu;
 // ob.Items[0].Caption:='Propri�t�s du train '+intToSTR(AdrPilote);

end;

procedure TFormPrinc.Propritsdutrain1Click(Sender: TObject);
var s : string;
begin
  clicliste:=false;
  if affEvt then Affiche('Clic propri�t�s train',clYellow);
  s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pour r�cup�rer l'index du train (ex: ImageSignal2)
  ligneclicTrain:=extract_int(s)-1;   // extraire l'adresse (ex 2)
  formconfig.PageControl.ActivePage:=formconfig.TabSheetTrains;
  clicproprietesTrains:=true;
  formconfig.showmodal;
  formconfig.close;
end;


procedure TFormPrinc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (PageControl.ActivePage<>TabSheettrains) or (TempoCombo>0) or (ComboTrains.Focused) or clicComboTrain then exit;
  //Affiche('FormKeyDown',clyellow);
  if (key=vk_down) and (IdTrainClic<NTrains) then
  begin
    Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,clWhite);
    inc(IdTrainClic);
    EditAdrTrain.Text:=intToSTR(trains[IdTrainClic].adresse);
    Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,$e0e0e0);
    Combotrains.ItemIndex:=IdTrainclic-1;
    //affiche_train_compteur;
    affiche_train_compteur(1);
    aiguille_compteur(1,idTrainClic,formCompteur[1]);
    key:=0;
  end;
  if (key=vk_up) and (IdTrainClic>1) then
  begin
    Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,clWhite);
    dec(IdTrainClic);
    EditAdrTrain.Text:=intToSTR(trains[IdTrainClic].adresse);
    Maj_icone_train(Image_Train[IdTrainClic],IdTrainClic,$e0e0e0);
    Combotrains.ItemIndex:=IdTrainclic-1;
    //affiche_train_compteur;
    affiche_train_compteur(1);
    aiguille_compteur(1,idTrainClic,formCompteur[1]);
    key:=0;
  end;
end;

procedure TFormPrinc.Affiche_compteurClick(Sender: TObject);
begin
  AffCompteur:=true;
  formCompteur[1].Show;
end;

procedure TFormPrinc.ButtonEssaiClick(Sender: TObject);
var i : integer;
begin
  test_canton(0,518,det,1,aig,i);
end;

procedure TFormPrinc.TrackBarZCChange(Sender: TObject);
const maxi=10;
      mini=0;
var i : integer;
begin
  ScrollBoxC.VertScrollBar.Position:=0;  // sinon bug bizarre sur la position verticale des gb
  i:=(maxi-TrackBarZC.Position)+mini;
  // mini 150 maxi 250
  LargComptC:=i*20+150;
  HautCompTC:=LargComptC;
  for i:=1 to ntrains do
    init_compteur(i,compteurT[i].gb);
  Affiche_compteursT;
end;

procedure TFormPrinc.Propritsdescompteurs1Click(Sender: TObject);
begin
  if affEvt then Affiche('Clic propri�t�s compteurs',clYellow);
  //s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pour r�cup�rer l'index du train (ex: ImageSignal2)
  //ligneclicTrain:=extract_int(s)-1;   // extraire l'adresse (ex 2)
  formconfig.PageControl.ActivePage:=formconfig.TabSheetCompt;
  formconfig.showmodal;
  formconfig.close;
end;

procedure TFormPrinc.PageControlChange(Sender: TObject);
begin
  onglet:=PageControl.ActivePageIndex;
end;

procedure TFormPrinc.Dtacherlecompteur1Click(Sender: TObject);
begin
  change_clic_train(IdTrainClic);
  formCompteur[1].Show;
end;

procedure TFormPrinc.PopupMenuCompteursPopup(Sender: TObject);
var menu: TpopUpMenu;
begin
  menu:=Sender as tPopUpMenu;
  menu.Items[1].caption:='Extraire le compteur du train '+trains[IdTrainClic].nom_train;
end;

end.
