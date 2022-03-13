Unit UnitPrinc;
(********************************************
  programme signaux complexes Graphique Lenz
  delphi 7 + activeX Tmscomm + clientSocket
 ********************************************
 6/3/2022 16h
 note sur le pilotage des accessoires:
 raquette   octet sortie
    +            2    = aiguillage droit  = sortie 2 de l'adresse d'accessoire
    -            1    = aiguillage d�vi�  = sortie 1 de l'adresse d'accessoire
*)

// en mode simulation run, CDM ne renvoie pas les d�tecteurs au d�part du RUN.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls, ShellAPI, TlHelp32,
  ImgList, ScktComp, StrUtils, Menus, ActnList, MSCommLib_TLB, MMSystem   ;

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
    N8: TMenuItem;
    Vrifierlacohrence: TMenuItem;
    GroupBox3: TGroupBox;
    loco: TButton;
    ButtonLocCV: TButton;
    EditAdrTrain: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditVitesse: TEdit;
    ComboTrains: TComboBox;
    LabelFonction: TLabel;
    EditNumFonction: TEdit;
    ButtonFonction: TButton;
    EditFonc01: TEdit;
    Label6: TLabel;
    Button1: TButton;
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
    procedure VrifierlacohrenceClick(Sender: TObject);
    procedure FenRichMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonLocCVClick(Sender: TObject);
    procedure ComboTrainsChange(Sender: TObject);
    procedure ButtonFonctionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { D�clarations priv�es }
    procedure DoHint(Sender : Tobject);
  public
    { D�clarations publiques }
    Procedure ImageOnClick(Sender : TObject);
    procedure proc_checkBoxFB(Sender : Tobject);
  end;


const
titre='Signaux complexes GL ';
espY = 15;            // espacement Y entre deux lignes de feux
MaxAcc=2048;          // adresse maxi d'accessoire XpressNet
NbMaxDet=100;         // nombre maximal de d�tecteurs d'un r�seau
NbMemZone=2048;       // adresse maximale des d�tecteurs
Max_Trains=100;
Max_event_det=400;
MaxBranches=100;
MaxElBranches=200;
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

EtatSign : array[0..13] of string[20] =('carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');
NbDecodeur = 8;
decodeur : array[0..NbDecodeur-1] of string[20] =('rien','digital Bahn','CDF','LDT','LEB','NMRA','Unisemaf','SR');
Etats : array[0..19] of string[30]=('Non command�','carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ralen 30','ralen 60','ralen 60 + jaune cli','rappel 30','rappel 60',
           'rappel 30 + jaune','rappel 30 + jaune cli','rappel 60 + jaune','rappel 60 + jaune cli');

type
Taccessoire   = (aigP,feu);    // aiguillage ou feu
TMA           = (valide,devalide);
TEquipement   = (rien,aig,tjd,tjs,triple,det,buttoir,voie);   // voie uniquement pour le tco
TBranche = record
               BType : Tequipement ;   // ne prend que les valeurs suivantes: d�t aig Buttoir
               Adresse : integer ; // adresse du d�tecteur ou de l'aiguillage
            end;

Taiguillage = record
                 Adresse : integer;         // adresse d'accessoire
                 modele : TEquipement;      // rien, aig, tjd ...
                 position,                  // position actuelle : 1=d�vi�  2=droit (centrale LENZ)
                 posInit,                   // position d'initialisation 1=d�vi� 2=droit 9=non positionn�
                 Adrtriple,                 // 2eme adresse pour un aiguillage triple
                 temps,                     // temps de pilotage (dur�e de l'impulsion en x 100 ms
                 InversionCDM : integer ;   // pour les aiguillages d�clar�s invers�s dans CDM, utilis� en mode autonome (param�tre I1)
                 vitesse : integer;         // vitesse de franchissement de l'aiguillage en position d�vi�e (60 ou 90)

                 ADroit : integer ;         // (TJD:identifiant ext�rieur) connect� sur la position droite en talon
                 ADroitB : char ;           // P D S Z

                 ADevie : integer ;         // (TJD:identifiant ext�rieur) adresse de l'�l�ment connect� en position d�vi�e
                 ADevieB : char;            // caract�re (D ou S)si aiguillage de l'�l�ment connect� en position d�vi�e

                 APointe : integer;         // adresse de l'�l�ment connect� en position droite ;
                 APointeB : char;

                 DDroit : integer;          // destination de la TJD en position droite
                 DDroitB : char ;

                 DDevie : integer;          // destination de la TJD en position d�vi�e
                 DDevieB : char ;

                 tjsint   : integer;        // pour TJS
                 tjsintb  : char ;

                  // �l�ments connect�s sur la branche d�vi�e 2 (cas d'un aiguillage triple)
                 Adevie2 : integer;
                 Adevie2B : char ;
                 // �tats d'une TJD (2 ou 4, 4 par d�faut)
                 EtatTJD : integer;

                 // si modifi� en mode config
                 modifie : boolean ;
              end;

TFeu = record
                 adresse, aspect : integer; // adresse du feu, aspect (2 feux..9 feux 12=direction 2 feux .. 16=direction 6 feux)
                 Img : TImage;              // Pointeur sur structure TImage du feu
                 Lbl : TLabel;              // pointeur sur structure Tlabel du feu
                 check : TCheckBox;         // pointeur sur structure Checkbox "demande feu blanc"
                 FeuBlanc : boolean ;       // avec checkbox ou pas
                 decodeur : integer;        // type du d�codeur
                 Adr_det1 : integer;        // adresse du d�tecteur1 sur lequel il est implant�
                 Adr_det2 : integer;        // adresse du d�tecteur2 sur lequel il est implant� (si un signal est pour plusieurs voies)
                 Adr_det3 : integer;        // adresse du d�tecteur3 sur lequel il est implant� (si un signal est pour plusieurs voies)
                 Adr_det4 : integer;        // adresse du d�tecteur4 sur lequel il est implant� (si un signal est pour plusieurs voies)
                 Adr_el_suiv1 : integer;     // adresse de l'�l�ment1 suivant
                 Adr_el_suiv2 : integer;     // adresse de l'�l�ment2 suivant (si un signal est pour plusieurs voies)
                 Adr_el_suiv3 : integer;     // adresse de l'�l�ment3 suivant (si un signal est pour plusieurs voies)
                 Adr_el_suiv4 : integer;     // adresse de l'�l�ment4 suivant (si un signal est pour plusieurs voies)
                 Btype_suiv1 : TEquipement ; // type de l'�l�ment suivant ne prend que les valeurs rien, det ou aig
                 Btype_suiv2 : TEquipement ; // 
                 Btype_suiv3 : TEquipement ; //
                 Btype_suiv4 : TEquipement ; // 
                 VerrouCarre : boolean ;     // si vrai, le feu se verrouille au carr� si pas de train avant le signal
                 modifie     : boolean;      // feu modifi�
                 EtatSignal  : word  ;       // comme EtatSignalCplx (doublon)
                 UniSemaf : integer ;        // d�finition suppl�mentaire de la cible pour les d�codeurs UNISEMAF
                 AigDirection : array[1..6] of array of record        // pour les signaux directionnels : contient la liste des aiguillages associ�s
                                               Adresse : integer;     // 6 feux max associ�s � un tableau dynamique d�crivant les aiguillages
                                               posAig  : char;
                                               end;
                 CondCarre : array[1..6] of array of record  // conditions suppl�mentaires d'aiguillages en position pour le carr�
                                                // attention les donn�es sont stock�es en adresse 1 du tableau dynamique
                                               Adresse : integer;    // aiguillage
                                               posAig : char;
                                               end;
                 SR : array[1..8] of record    // configuration du d�codeur St�phane Ravaut
                                               sortie1,sortie0 : integer;
                                     end;  
               end;


var
  ancien_tablo_signalCplx,EtatsignalCplx : array[0..MaxAcc] of word;  // attention tableau indic� par l'adresse du signal et non son index!!
  tempsCli,NbreFeux,pasreponse,AdrDevie,fenetre,Tempo_Aig,Tempo_feu,
  NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
  Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,NbrePN,ServeurInterfaceCDM,
  ServeurRetroCDM,TailleFonte,Nb_Det_Dist,Tdoubleclic,algo_Unisemaf,fA,fB,AdrTrain : integer;

  Hors_tension2,traceSign,TraceZone,Ferme,parSocketLenz,ackCdm,PremierFD,doubleclic,
  NackCDM,MsgSim,succes,recu_cv,AffActionneur,AffAigDet,Option_demarrage,AffTiers,
  TraceListe,clignotant,nack,Maj_feux_cours,configNulle,LanceCDM,AvecInitAiguillages : boolean;

  CDMhd : THandle;

  FormPrinc: TFormPrinc;
  ack,portCommOuvert,traceTrames,AffMem,AfficheDet,CDM_connecte,
  Raz_Acc_signaux,AvecInit,AvecTCO,terminal,Srvc_Aig,Srvc_Det,Srvc_Act,
  Srvc_PosTrain,Srvc_Sig,debugtrames : boolean;
  tablo : array of byte;  // tableau rx usb
  Enregistrement,chaine_Envoi,chaine_recue,Id_CDM,Af,
  entete,suffixe,ConfStCom,LAY : string;
  maxaiguillage,detecteur_chgt,Temps,Tempo_init,Suivant,ntrains,
  NbreImagePligne,NbreBranches,Index2_det,Index2_aig,branche_det,Index_det,
  I_simule,maxTablo_act,NbreVoies,AdresseFeuSuivant,El_suivant : integer;
  Ancien_detecteur : array[0..NbMemZone] of boolean;   // anciens �tat des d�tecteurs et adresses des d�tecteurs et leur �tat
  detecteur : array[0..NbMemZone] of
  record
     etat : boolean;
     tempo : integer;
     train : string;
  end;

  TypeGen : TEquipement;
  Adresse_detecteur : array[0..NbMaxDet] of integer; // adresses des d�tecteurs par index

  MemZone : array[0..NbMemZone,0..NbMemZone] of boolean ; // m�moires de zones des d�tecteurs

  Tablo_actionneur : array[1..100] of
  record
    loco,act,son: boolean;   // type loco actionneur ou son 
    adresse,adresse2,        // adresse: adresse de base ; adresse2=cas d'une Zone
    etat,fonction,tempo,TempoCourante,  
    accessoire,sortie,
    typActMemZone  : integer;  // 0=actioneur  1=MemZone
    Raz : boolean;
    det : boolean; // d�signe un d�tecteur
    FichierSon,trainDecl,TrainDest : string;
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
             PresTrain : boolean; // m�moire de pr�sence de train sur la voie
           end;
  end;
  Tablo_Simule : array[0..Max_Simule] of
    record
      tick : longint;
      Detecteur,Aiguillage,etat : integer ;
    end;
  N_Cv,index_simule,NDetecteurs,N_Trains,N_routes : integer;
  tablo_CV : array [1..255] of integer;
  couleur : Tcolor;
 
  tick,Premier_tick : longint;
  // mod�lisations des fichiers config
  branche : array [1..100] of string; 
  // l'indice du tableau aiguillage n'est pas son adresse
  aiguillage : array[0..MaxAcc] of Taiguillage;
  // signaux - L'index du tableau n'est pas son adresse
  feux :  array[1..MaxAcc] of Tfeu;
  trains : array[1..Max_Trains] of record
              nom_train : string;
              adresse,vitmax : integer;
           end;
  event_det : array[1..Max_event_det] of integer;
  event_det_train : array[1..Max_Trains] of record
                    NbEl : integer;
                    Det : array[1..3] of integer; // tableau des evts d�tecteurs par train
                    end;
  Feu_supprime,Feu_sauve : Tfeu;
  Aig_supprime,Aig_sauve : TAiguillage;

  Fimage : Timage;

  BrancheN : array[1..MaxBranches,1..MaxElBranches] of TBranche;

{$R *.dfm}

// utilisation des proc�dures et fonctions dans les autres unit�s
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
function suivant_alg3(prec : integer;typeELprec : TEquipement;var actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
function detecteur_suivant_El(el1: integer;TypeDet1 : TEquipement;el2 : integer;TypeDet2 : TEquipement;alg : integer) : integer ;
function test_memoire_zones(adresse : integer) : boolean;
function PresTrainPrec(Adresse : integer) : boolean; 
function cond_carre(adresse : integer) : boolean;
function carre_signal(adresse : integer) : boolean;
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
procedure Event_act(adr,adr2,etat : integer;trainDecl : string);
function verif_UniSemaf(adresse,UniSem : integer) : integer;
function Select_dessin_feu(TypeFeu : integer) : TBitmap;
procedure cree_image(rang : integer);
procedure trouve_aiguillage(adresse : integer);
procedure trouve_detecteur(detecteur : integer);
function BTypeToNum(BT : TEquipement) : integer;
function ProcessRunning(sExeName: String) : Boolean;

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

// renvoie le 1er num�ro de bit � 1
// PremBitNum(1)=0
// PremBitNum(4)=2
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
// Combine = code de la signalisation combin�e
// Exemple code_to_aspect(10001000000000)  renvoie premierBit=jaune_cli (9) et Combine=rappel 60 (13)
procedure code_to_aspect(codebin : word;var premierbit,combine : word) ;
begin
  premierBit:=PremBitNum(CodeBin and $3ff);
  combine:=PremBitNum(CodeBin and $fc00);
end;

// conversion d'un �tat signal binaire en �tat unique
// exemple code_to_etat(10001000000000) (jaune_cli et rappel 60) renvoie 19
function code_to_etat(code : word) : integer;
var aspect,combine : word;    
begin
  code_to_aspect(code,aspect,combine);
  result:=9999;
  if aspect=0 then result:=1; // carr�
  if aspect=1 then result:=2; // s�maphore
  if aspect=2 then result:=3; // s�maphore cli
  if aspect=3 then result:=4; // vert
  if aspect=4 then result:=5; // vert cli
  if aspect=5 then result:=6; // violet
  if aspect=6 then result:=7; // blanc
  if aspect=7 then result:=8; // blanc cli
  if aspect=8 then result:=9; // jaune
  if aspect=9 then result:=10; // jaune cli
  
  if aspect=16 then
  begin
    if combine=10 then result:=11; // ralen 30
    if combine=11 then result:=12; // ralen 60
    if combine=12 then result:=14; // rappel 30
    if combine=13 then result:=15; // rappel 60           
  end
  else
  begin
    if (aspect=9) and (combine=11) then result:=13;   //ralen 60 + jaune cli
    if (aspect=8) and (combine=12) then result:=16;   //rappel 30 + jaune
    if (aspect=9) and (combine=12) then result:=17;   //rappel 30 + jaune cli
    if (aspect=8) and (combine=13) then result:=18;   //rappel 60 + jaune
    if (aspect=9) and (combine=13) then result:=19;   //rappel 60 + jaune cli
  end;  
  code_to_etat:=result;  
  {'Non command�','carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ralen 30','ralen 60','ralen 60 + jaune cli','rappel 30','rappel 60',
               7        8         9         10         11          12               13               14         15   
           'rappel 30 + jaune','rappel 30 + jaune cli','rappel 60 + jaune','rappel 60 + jaune cli');
                     16                  17                      18                   19     }
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

// dessine les feux sur une cible � 2 feux dans le canvas sp�cifi�
// x,y : offset en pixels du coin sup�rieur gauche du feu
// frX, frY : facteurs de r�duction
procedure dessine_feu2(Acanvas : Tcanvas;x,y : integer;frX,frY : real;EtatSignal : word;orientation : integer);
var Temp,rayon,xViolet,YViolet,xBlanc,yBlanc,
    LgImage,HtImage : integer;
    ech : real;
    code,combine : word;
begin
  code_to_aspect(Etatsignal,code,combine);
  rayon:=round(6*frX);

  // r�cup�rer les dimensions de l'image d'origine du feu
  LgImage:=Formprinc.Image2feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image2feux.Picture.Bitmap.Height;

  XBlanc:=13;  YBlanc:=11;
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
    //rotation 90� vers la droite des feux
    // calcul des facteurs de r�duction pour la rotation
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

// dessine les feux sur une cible � 3 feux
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
    //rotation 90� vers la droite des feux
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

// dessine les feux sur une cible � 4 feux
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
    //rotation 90� vers la gauche des feux
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

// dessine les feux sur une cible � 5 feux
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
    //rotation 90� vers la gauche des feux
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
    //rotation 90� vers la droite des feux
    // calcul des facteurs de r�duction pour la rotation
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


// dessine les feux sur une cible � 7 feux
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
    //rotation 90� vers la gauche des feux
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
    //rotation 90� vers la droite des feux
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

// dessine les feux sur une cible � 9 feux
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

  LgImage:=Formprinc.Image9feux.Picture.Bitmap.Width;
  HtImage:=Formprinc.Image9feux.Picture.Bitmap.Height;

  if (orientation=2) then
  begin
    //rotation 90� vers la gauche des feux
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
    //rotation 90� vers la droite des feux
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
  cercle(ACanvas,xcarre,Ycarre,rayon,grisF); // carr� sup�rieur
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


// dessine les feux sur une cible directionnelle � 2 feux
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

// dessine les feux sur une cible directionnelle � 4 feux
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


// dessine les feux sur une cible directionnelle � 2 feux
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

// transforme le type TEquipement en valeur num�rique
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

// transforme le type TEquipement en chaine
function BTypeToChaine(BT : TEquipement) : string;
begin
  case BT of
  det : result:='det';
  aig : result:='aig';
  voie : result:='voie';
  buttoir : result:='but';
  else result:='rien';
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
//si pas trouv� renvoie 0
function Index_feu(adresse : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=1; 
  repeat
    trouve:=feux[i].adresse=adresse;
    if not(trouve) then inc(i);
  until (trouve) or (i>NbreFeux);
  if trouve then Index_feu:=i else Index_feu:=0 ;
end;

// renvoie l'index de l'aiguillage dans le tableau aiguillages[] en fonction de son adresse
//si pas trouv� renvoie 0
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

// proc�dure activ�e quand on clique gauche sur l'image d'un feu
Procedure TFormprinc.ImageOnClick(Sender : Tobject);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;
begin
  P_image_pilote:=Sender as TImage;  // r�cup�rer l'objet image de la forme pilote
  s:=P_Image_pilote.Hint;
  //Affiche(s,clyellow);
  i:=pos('@',s);  if i<>0 then delete(s,1,i);
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

// cr��e une image dynamiquement pour un nouveau feu d�clar� dans le fichier de config
// rang commence � 1
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
    Name:='ImageFeu'+IntToSTR(rang);   // nom de l'image - sert � identifier le composant si on fait clic droit.
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // d�termine les points d'origine
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    //Affiche(intToSTR(rang)+' '+intToSTR(left),clorange);
    width:=57;
    Height:=105;
    s:='Index='+IntToSTR(rang)+' @='+inttostr(feux[rang].Adresse)+' D�codeur='+intToSTR(feux[rang].Decodeur)+
       ' Adresse d�tecteur associ�='+intToSTR(feux[rang].Adr_det1)+
       ' Adresse �lement suivant='+intToSTR(feux[rang].Adr_el_suiv1);
    if feux[rang].Btype_suiv1=aig then s:=s+' (aig)';
    Hint:=s;

    onClick:=Formprinc.Imageonclick;    // affectation proc�dure clique sur image
    PopUpMenu:=Formprinc.PopupMenuFeu;  // affectation popupmenu sur clic droit

    Picture.Bitmap.TransparentMode:=tmAuto;
    Picture.Bitmap.TransparentColor:=clblue;
    Transparent:=true;

    // affecter le type d'image de feu dans l'image cr��e
    picture.Bitmap:=Select_dessin_feu(TypeFeu);

    // mettre rouge par d�faut
    adresse:=Feux[rang].adresse;
    if TypeFeu=2 then EtatSignalCplx[adresse]:=violet_F;
    if TypeFeu=3 then EtatSignalCplx[adresse]:=semaphore_F;
    if (TypeFeu>3) and (TypeFeu<10) then EtatSignalCplx[adresse]:=carre_F;
    if TypeFeu>10 then EtatSignalCplx[adresse]:=0;

    dessine_feu_mx(Feux[rang].Img.Canvas,0,0,1,1,feux[rang].adresse,1);
    //if feux[rang].aspect=5 then cercle(Picture.Bitmap.Canvas,13,22,6,ClYellow);
  end;

  // cr��e le label pour afficher son adresse
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

  // cr��e le checkBox si un feu blanc est d�clar� sur ce feu
  if feux[rang].FeuBlanc then
  begin
    Feux[rang].check:=TCheckBox.create(Formprinc.ScrollBox1);  // ranger l'adresse de la Checkbox dans la structure du feu
    //Feux[rang].check.onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la proc�dure de traitement quand on clique dessus non utilis�
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

// temporisation en x 100 ms (0,1 s)
procedure Tempo(ValTemps : integer);
begin
  temps:=Valtemps;
  repeat
    Application.ProcessMessages;
  until (temps<=0);
end;


// envoi d'une cha�ne � la centrale par USBLenz ou socket, n'attend pas l'ack
// ici on envoie pas � CDM
procedure envoi_ss_ack(s : string);
var i,timeout,valto : integer;
begin
//  com:=formprinc.MSCommUSBLenz;
  s:=entete+s+suffixe;
  if traceTrames then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClLime);
  // par port com-usb

  if portCommOuvert then
  begin
    if (protocole=4) then // le protocole 4 contr�le simplement la ligne CTS avant de transmettre et temporise octet par octet
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

// envoi d'une cha�ne � la centrale Lenz par USBLenz ou socket, puis attend l'ack ou le nack
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
      until ferme or ack or nack or (temps>(TimoutMaxInterface*3)); // l'interface r�pond < 5s en mode normal et 1,5 mn en mode programmation
      if not(ack) or nack then
      begin
        Affiche('Pas de r�ponse de l''interface',clRed);inc(pasreponse);
        // &&&if pasreponse>3 then hors_tension2:=true;
      end;
      if ack then begin pasreponse:=0;hors_tension2:=false;end;
    end;
  end;
  envoi:=ack;
end;

// cha�ne pour une fonction F � un train via CDM
Function chaine_CDM_Func(fonction,etat : integer;train : string) : string;
var so,sx,s : string;
begin
  {  exemple de commande envoy�e au serveur pour une fonction
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=nomdutrain;FXnumfonction=etat;

  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=train;FX0=0;
  C-C-00-0002-CMDTRN-DCCSF|029|02|NAME=train;FX1=0;
  C-C-00-0002-CMDTRN-DCCSF|047|02|NAME=train;FX0=1;FX1=1;FX2=1;FX3=1;
  maxi=C-C-00-0002-CMDTRN-DCCSF|111|15|NAME=train;FX0=1;FX1=1;FX2=1;FX3=1;FX4=0;FX5=0;FX6=0;FX7=0;FX8=0;FX9=0;FX10=0;FX11=0;FX12=0;FX13=0;
  }
  so:=place_id('C-C-01-0004-CMDTRN-DCCSF');
  s:=s+'NAME='+train+';';
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
  s:=s+'NAME='+train+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesseST:=so+s;
end;

// cha�ne pour vitesse train INT par son adresse
function chaine_CDM_vitesseINT(vitesse:integer;train:integer) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:=s+'AD='+intToSTR(train)+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesseINT:=so+s;
end;

// cha�ne pour un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat : integer) : string;
var so,sx,s : string;
begin
 {  exemple de commande envoy�e au serveur pour manoeuvrer un accessoire
  C-C-00-0004-CMDACC-DCCAC|018|02|AD=100;STATE=1;
  "	NAME : nom de l'aiguille
  "	OBJ: num�ro CDM-Rail de l'aiguille (index)
  "	AD: adresse (DCC) de l'aiguille
  "	AD2: adresse #2 (DCC) de l'aiguille (TJD bi-moteurs ou aiguille triples)
  "	STATE: �tat de l'aiguille
  o	0: position droite (non d�vi�e)
  o	1: d�vi� (TJD, bretelles doubles)
  o	2: d�vi� droit
  o	3: d�vi� gauche
  o	4: pos. droite #2 (TJD 4 �tats)
  o	5: pos. d�vi�e #2 (TJD 4 �tats)
  }
  so:=place_id('C-C-01-0004-CMDACC-DCCAC');
  s:=s+'AD='+format('%.*d',[1,adresse])+';';
  s:=s+'STATE='+format('%.*d',[1,etat])+';';

  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_Acc:=so+s;
end;

procedure envoie_fonction_CDM(fonction,etat : integer;train : string);
var s : string;
begin
  s:=chaine_CDM_Func(fonction,etat,train);
  envoi_cdm(s);
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


procedure demande_etat_loco(loco : integer);
var ah,al,i : integer;
    s : string;
begin
  if portCommOuvert or parSocketLenz then
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
end;

    
// loco=adresse de la loco  fonction de 0 � 20 �tat 0/1
procedure Fonction_Loco_Operation(loco,fonction,etat : integer);
var s : string ;
    ah,al : integer;
    b : byte ;
begin

  if (fonction<0) or (fonction>28) or (loco<0) or (loco>9999) then exit;
  if portCommOuvert or parSocketLenz then
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
      if (fonction>=13) and (fonction<=20) then s:=s+#$23;    // 23 non doc
      if (fonction>=21) and (fonction<=28) then s:=s+#$28;    // 28 non doc
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
      envoi(s);
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
end;

// envoie une vitesse � une loco par XpressNet ou par CDM
procedure vitesse_loco(nom_train :string;loco : integer;vitesse : integer;sens : boolean);
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
     //s:=chaine_CDM_vitesseST(vitesse,nom_train);  // par nom du train
     s:=chaine_CDM_vitesseINT(vitesse,loco);    // par adresse du train
     envoi_CDM(s);
     //affiche(s,clLime);    
  end;
end;


// renvoie la cha�ne de l'�tat du signal
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

// mise � jour �tat signal complexe dans le tableau de bits du signal EtatSignalCplx */
// adresse : adresse du signal complexe
// Aspect : code repr�sentant l'�tat du signal de 0 � 15
procedure Maj_Etat_Signal(adresse,aspect : integer);
var i : integer;
begin                              
// ('0carr�','1s�maphore','2s�maphore cli','3vert','4vert cli','5violet',
//           '6blanc','7blanc cli','8jaune','9jaune cli','10ral 30','11ral 60','12rappel 30','13rappel 60');
  if testBit((EtatSignalCplx[adresse]),aspect)=false then  // si le bit dans l'�tat du signal n'est pas allum�, proc�der.
  begin
    // effacement du motif de bits en fonction du nouvel �tat demand� suivant la r�gle des signaux complexes
    if (aspect<=blanc_cli) then
    begin
      EtatSignalCplx[adresse]:=0;  //Tout aspect <=7 efface les autres
    end;
    if (aspect=jaune) then // jaune
    begin
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],jaune_cli); // cas du jaune: efface le bit du jaune clignotant (bit 9)
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],ral_30);  // cas du jaune: efface le bit du ral_30 (bit 10)
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],ral_60);  // cas du jaune: efface le bit du ral_60 (bit 11)
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($00FF);   // et effacer les bits 0 � 7
    end;
    if (aspect=jaune_cli) then // jaune clignotant
    begin
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],jaune);   // cas du jaunecli: efface le bit du jaune  (bit 8)
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and $FF00;   // et effacer les bits 0 � 7
    end;
    if (aspect=ral_30) then // ralentissement 30
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($3BFF);   // cas du ral 30: efface les bits 0 1 2 3 4 5 6 7 8 9 11 12 et 13 :  11 1000 1111 1111
    end;
    if (aspect=ral_60) then // ralentissement 60
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($35FF);   // cas du ral 60: efface les bits 8 10 12 et 13 et de 0 � 7  : 11 0100 1111 1111
    end;
    if (aspect=rappel_30) then // rappel 30
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($2cff);   // cas du rappel 30: efface les bits 0 1 2 3 4 5 6 7 10 11 et 13 : 10 1100 1111 0000
    end;
    if (aspect=rappel_60) then // rappel 60
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($1Cff);   // cas du rappel 60: efface les bits 0 1 2 3 4 5 6 7 10 11 et 12  1 1100 1111 0000
    end;
    if (aspect=aspect8) then // ral_60_jaune_cli d�codeur LDT
    begin
      EtatSignalCplx[adresse]:=jaune_cli_F or ral_60_F;   // cas du ralentissement 60 + avertissement clignotant : efface les bits 10 11 et 12
    end;
    if (aspect<>aspect8) then
    begin
      EtatSignalCplx[adresse]:=SetBit(EtatSignalCplx[adresse],aspect);   // allume le num�ro du bit de la fonction du signal
      // Affiche(IntToSTR(EtatSignalCplx[adresse]),clyellow);
    end;
  end;
  // mise � jour de l'�tat du signal dans le tableau Feux
  i:=Index_feu(adresse);
  if i<>0 then feux[i].EtatSignal:=EtatSignalCplx[adresse];
end;


{=============================================
envoie les donn�es au d�codeur digital bahn �quip� du logiciel "led_schalten"
sur un panneau directionnel - adresse : adresse du signal - code de 1 � 3 pour allumer
; le panneau directionnel � 1, 2 ou 3 leds.
============================================== }
procedure envoi_directionBahn(adr : integer;code : integer);
begin
  if (EtatSignalCplx[adr]<>code) then
  begin
    if (traceSign) then Affiche('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);
    if AffSignal then AfficheDebug('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);

    case code of
    0 :  begin      pilote_acc(adr,1,feu);   // sortie 1 � 0
                    sleep(tempo_Feu);
                    pilote_acc(adr+1,1,feu); // sortie 2 � 0
                    sleep(Tempo_feu);
                    pilote_acc(adr+2,1,feu); // sortie 3 � 0
                    sleep(Tempo_Feu);
         end;
    1 :  begin      pilote_acc(adr,2,feu);   // sortie 1 � 1
                    sleep(tempo_Feu);
                    pilote_acc(adr+1,1,feu); // sortie 2 � 0
                    sleep(Tempo_feu);
                    pilote_acc(adr+2,1,feu); // sortie 3 � 0
                    sleep(Tempo_Feu);
          end;
    2 :  begin      pilote_acc(adr,2,feu);   // sortie 1 � 1
                    sleep(tempo_Feu);
                    pilote_acc(adr+1,2,feu); // sortie 2 � 1
                    sleep(Tempo_feu);
                    pilote_acc(adr+2,1,feu); // sortie 3 � 0
                    sleep(Tempo_Feu);
          end;
    3 :  begin      pilote_acc(adr,2,feu);   // sortie 1 � 1
                    sleep(tempo_Feu);
                    pilote_acc(adr+1,2,feu); // sortie 2 � 1
                    sleep(Tempo_feu);
                    pilote_acc(adr+2,2,feu); // sortie 3 � 1
                    sleep(Tempo_Feu);
          end;
    end;
    EtatSignalCplx[adr]:=code;
    Dessine_feu_mx(Feux[Index_Feu(adr)].Img.Canvas,0,0,1,1,adr,1);
  end;
end;


{ =============================================
envoie les donn�es au signal de direction pour un d�codeur CDF
adresse : adresse du signal - code de 1 � 3 pour allumer
le panneau directionnel � 1, 2, 3 ou 4 leds.
============================================== }
procedure envoi_directionCDF(adr : integer;code : integer);
begin
  if (EtatSignalCplx[adr]<>code) then
  begin
    if traceSign then Affiche('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);
    if AffSignal then AfficheDebug('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

    case code of
      // �teindre toutes les leds
    0 :
      begin
        pilote_acc(adr,1,feu) ;
        sleep(200);
      end;
      // code 1 : allume le feu le plus � gauche
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
envoie les donn�es au d�codeur CDF
===========================================================================*}
procedure envoi_CDF(adresse : integer);
var
  code,aspect,combine : word;
  s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal CDF: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    if (aspect=carre)     then pilote_acc(adresse,2,feu) ;
    if (aspect=semaphore) then pilote_acc(adresse,1,feu) ;
    if (aspect=vert)      then pilote_acc(adresse+1,1,feu) ;
    if (aspect=jaune)     then pilote_acc(adresse+1,2,feu);
    // signalisation non combin�e rappel 30 seul
    if (aspect=rappel_30) then pilote_acc(adresse+1,1,feu);

    // signalisation combin�e  - rappel 30 + avertissement - � tester......
    if (Combine=0)      then pilote_acc(adresse+2,1,feu) ;    // �teindre rappel 30
    if (Combine=rappel_30) then pilote_acc(adresse+2,2,feu) ; // allumer rappel 30
  end;
end;

{==========================================================================
envoie les donn�es au d�codeur SR
===========================================================================*}
procedure envoi_SR(adresse : integer);
var 
  code : word;
  index,i,etat : integer;
  s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    code:=EtatSignalCplx[adresse];
    //code_to_aspect(code,aspect,combine);
    s:='Signal SR: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
    index:=index_feu(adresse);                    
    etat:=code_to_etat(code);
          
    //Affiche('Code a chercher='+IntToSTR(etat),clyellow);

    if index<>0 then
    begin
      i:=0;
      // trouve l'index dans la configuration du feu correspondant � son �tat demand�
      repeat
        inc(i);                                   
      until (feux[index].SR[i].sortie1=etat) or (feux[index].SR[i].sortie0=etat) or (i=8);
                            
      if (feux[index].SR[i].sortie1=etat) then 
      begin
        //affiche('trouv� en sortie1 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,2,feu);
      end;  
      if (feux[index].SR[i].sortie0=etat) then 
      begin
        //affiche('trouv� en sortie0 index '+IntToSTR(i),clyellow);
        Pilote_acc(adresse+i-1,1,feu);
      end;  
    end; 
  end;
end;


{==========================================================================
envoie les donn�es au d�codeur LEB
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
      // le d�codeur LEB n�cessite qu'on envoie 0 apr�s son pilotage ; si on est en mode usb ou ethernet
      if (portCommOuvert or parSocketLenz) then Pilote_acc0_X(adresse+i,octet);
    end;
    //Affiche(inttoStr(selection),clOrange);
    //Affiche(s,clOrange);
  end;
begin

if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then //; && (stop_cmd==FALSE))
begin
  code:=EtatSignalCplx[adresse];
  code_to_aspect(code,aspect,combine);
  s:='Signal LEB: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
  if traceSign then affiche(s,clOrange);
  if Affsignal then afficheDebug(s,clOrange);

  Sleep(60);  // si le feu se positionne � la suite d'un positionnement d'aiguillage, on peut avoir le message station occup�e
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
envoie les donn�es au d�codeur NMRA �tendu
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
var valeur : integer ;
    aspect,combine,code : word;
    s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal NMRA: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    // attention: impossible d'envoyer des octets en XpressNet!!
    // NMRA ne focntionnera pas..

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

// d�codeur unisemaf (paco)
procedure envoi_UniSemaf(adresse: integer);
var modele,index: integer ;
    s : string;
    code,aspect,combine : word;
begin
  index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau

  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal Unisemaf: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    // pour Unisemaf, la cible est d�finie dans le champ Unisemaf de la structure feux

    modele:=feux[index].Unisemaf;
    //Affiche('Adresse='+intToSTR(Adresse)+' code='+intToSTR(code)+' combine'+intToSTR(combine),clyellow);

    // pilotage qui marche chez JEF
    if algo_Unisemaf=1 then 
    begin
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
        // 51=carr� + blanc
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
        // 72=VJR + carr� + ralentissement 30
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
        // 73=VJR + carr� + ralentissement 60
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
        // 91=VJR + carr� + rappel 30
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

        // 92=VJR + carr� + rappel 60
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

        // 93=VJR + carr� + ral30 + rappel 30
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

        // 94=VJR + carr� + ral60 + rappel60
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

        // 95=VJR + carr� + ral30 + rappel 60
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
        // 96=VJR + blanc + carr� + ral30 + rappel30
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

        // 97=VJR + blanc + carr� + ral30 + rappel60
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

    // algo de la doc qui ne marche pas chez JEF
    if algo_Unisemaf=2 then 
    begin
        if modele=2 then // 2 feux
        begin
          if (aspect=blanc) or (aspect=blanc_cli) then pilote_acc(adresse,1,feu);
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
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,1,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,1,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,1,feu);end;
          carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          end;
        end;
        // 51=carr� + blanc
        if modele=51 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,2,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,2,feu);end;
          carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          blanc,blanc_cli       : pilote_acc(adresse+2,1,feu);
          end;
        end;
        // 52=VJR + blanc + violet
        if modele=52 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,2,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,2,feu);end;
          blanc,blanc_cli       : pilote_acc(adresse+1,2,feu);
          violet                : pilote_acc(adresse+2,1,feu);
          end;
        end;
        // 71=VJR + ralentissement 30
        if modele=71 then
        begin
          case aspect of
          vert,vert_cli          : pilote_acc(adresse+1,1,feu);
          jaune,jaune_cli        : pilote_acc(adresse,1,feu);
          semaphore,semaphore_cli: pilote_acc(adresse,2,feu);
          end;
          if combine=ral_30 then pilote_acc(adresse+1,2,feu);
        end;
        // 72=VJR + carr� + ralentissement 30
        if modele=72 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,2,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,2,feu);end;
          carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          end;
          if combine=ral_30 then pilote_acc(adresse+2,1,feu); //pilote_acc(adresse+2,2,feu); impossible en lenz
        end;
        // 73=VJR + carr� + ralentissement 60
        if modele=73 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,2,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,2,feu);end;
          carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          end;
          if combine=ral_60 then pilote_acc(adresse+2,1,feu); //pilote_acc(adresse+2,2,feu); impossible en lenz
        end;
        // 91=VJR + carr� + rappel 30
        if modele=91 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,2,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,2,feu);end;
          carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          end;
          if combine=rappel_30 then pilote_acc(adresse+2,1,feu);//pilote_acc(adresse+2,2,feu); impossible en lenz
        end;

        // 92=VJR + carr� + rappel 60
        if modele=92 then
        begin
          case aspect of
          vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+2,2,feu);end;
          jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);end;
          semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+2,2,feu);end;
          carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          end;
          if combine=rappel_60 then pilote_acc(adresse+2,1,feu);//pilote_acc(adresse+2,2,feu); impossible en lenz
        end;

        // 93=VJR + carr� + ral30 + rappel 30
        if modele=93 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,1,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,1,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,1,feu);end;
            carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,1,feu);end;
          if combine=rappel_30      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,1,feu);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_30) then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,1,feu);end;
        end;

        // 94=VJR + carr� + ral60 + rappel60
        if modele=94 then
        begin
          case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,1,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,1,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,1,feu);end;
            carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
          end;
          if combine=ral_60         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,1,feu);end;
          if combine=rappel_60      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,1,feu);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60) then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,1,feu);end;
        end;
        // 95=VJR + carr� + ral30 + rappel 60
        if modele=95 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,1,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,1,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,1,feu);end;
            carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,1,feu);end;
          if combine=rappel_60      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,1,feu);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60)
                                    then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,1,feu);end;
        end;
        // 96=VJR + blanc + carr� + ral30 + rappel30
        if modele=96 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,2,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,2,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,2,feu);end;
            carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
            blanc,blanc_cli       : pilote_acc(adresse+3,1,feu);
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,2,feu);end;
          if combine=rappel_30      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_30)
                                    then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
        end;

        // 97=VJR + blanc + carr� + ral30 + rappel60
        if modele=97 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,2,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,2,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,2,feu);end;
            carre                 : begin pilote_acc(adresse,2,feu);pilote_acc(adresse+1,2,feu);end;
            blanc,blanc_cli       : pilote_acc(adresse+3,1,feu);
            end;
        if combine=ral_30         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,2,feu);end;
        if combine=rappel_60      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
        if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60)
                                  then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
        end;

        // 98=VJR + blanc + violet + ral30 + rappel30
        if modele=98 then
        begin
            case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,2,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,2,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,2,feu);end;
            blanc,blanc_cli       : pilote_acc(adresse+1,2,feu);
            violet                : pilote_acc(adresse+3,1,feu);
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,2,feu);end;
          if combine=rappel_30      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_30)
                                    then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
         end;

        // 99=VJR + blanc + violet + ral30 + rappel60
        if modele=99 then
        begin
          case aspect of
            vert,vert_cli         : begin pilote_acc(adresse+1,1,feu);pilote_acc(adresse+3,2,feu);end;
            jaune,jaune_cli       : begin pilote_acc(adresse,1,feu);pilote_acc(adresse+3,2,feu);end;
            semaphore,semaphore_cli: begin pilote_acc(adresse,2,feu);pilote_acc(adresse+3,2,feu);end;
            blanc,blanc_cli       : pilote_acc(adresse+1,2,feu);
            violet                : pilote_acc(adresse+3,1,feu);
            end;
          if combine=ral_30         then begin pilote_acc(adresse+2,1,feu);pilote_acc(adresse+3,2,feu);end;
          if combine=rappel_60      then begin pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
          if ((aspect=jaune) or (aspect=jaune_cli)) and (combine=rappel_60)
                                    then begin pilote_acc(adresse,1,feu);pilote_acc(adresse+2,2,feu);pilote_acc(adresse+3,2,feu);end;
        end;
    end;    
  end;
end;

{==========================================================================
envoie les donn�es au d�codeur LDT
       adresse=adresse sur le BUS DCC
       code=code d'allumage selon l'adressage (ex carre, vert, rappel_30 ..).
       mode=mode du d�codeur adress�, de 1 � 2
       un d�codeur occupe 8 adresses
       Le mode 1 permet la commande des signaux de 2, 3 et 4 feux
       Le mode 2 permet la commande de signaux de plus de 4 feux
===========================================================================}
procedure envoi_LDT(adresse : integer);
var code,aspect,combine,mode : word;
    s : string;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then //; && (stop_cmd==FALSE))
  begin
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal LDT: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);

    if (aspect=semaphore) or (aspect=vert) or (aspect=carre) or (aspect=jaune) then mode:=1 else mode:=2;

    if aspect>carre then mode:=2 else mode:=1;
    case mode of
      // pour les d�codeurs en mode 0, il faut �crire la routine vous m�me car le pilotage d�pend du cablage
      // sauf pour le s�maphore, vert et jaune fixe
    1 :       // mode 1: feux 2 3 & 4 feux
    begin
      if (aspect=semaphore) then pilote_acc(adresse,1,feu);
      if (aspect=vert)      then pilote_acc(adresse,2,feu);
      if (aspect=carre)     then pilote_acc(adresse+1,1,feu);
      if (aspect=jaune)     then pilote_acc(adresse+1,2,feu);
    end;
    2 :      // mode 2: plus de 4 feux
    begin
      if (aspect=semaphore)  then begin pilote_acc(adresse+2,1,feu);sleep(tempo_Feu);pilote_acc(adresse,1,feu);end;
      if (aspect=vert)       then begin pilote_acc(adresse+2,1,feu);sleep(tempo_Feu);pilote_acc(adresse,2,feu);end;
      if (aspect=carre)      then begin pilote_acc(adresse+2,1,feu);sleep(tempo_Feu);pilote_acc(adresse+1,1,feu);end;
      if (aspect=jaune)      then begin pilote_acc(adresse+2,1,feu);sleep(tempo_Feu);pilote_acc(adresse+1,2,feu);end;
      if (aspect=violet)     then begin pilote_acc(adresse+2,2,feu);sleep(tempo_Feu);pilote_acc(adresse,1,feu);end;
      if (aspect=blanc)      then begin pilote_acc(adresse+2,2,feu);sleep(tempo_Feu);pilote_acc(adresse,2,feu);end;
      if (aspect=semaphore)  then begin pilote_acc(adresse+2,2,feu);sleep(tempo_Feu);pilote_acc(adresse+1,1,feu);end;
      if (combine=aspect8)   then begin pilote_acc(adresse+2,2,feu);sleep(tempo_Feu);pilote_acc(adresse+1,2,feu);end;
      if (combine=ral_60_jaune_cli) then begin pilote_acc(adresse+3,1,feu);sleep(tempo_Feu);pilote_acc(adresse,1,feu);end;  // demande groupe 3
      if (aspect=vert_cli)   then begin pilote_acc(adresse+3,1,feu);sleep(tempo_Feu);pilote_acc(adresse,2,feu);end; // demande groupe 3
      if (combine=Disque_D)  then begin pilote_acc(adresse+3,1,feu);sleep(tempo_Feu);pilote_acc(adresse+1,1,feu);end;// demande groupe 3
      if (aspect=jaune_cli)  then begin pilote_acc(adresse+3,1,feu);sleep(tempo_Feu);pilote_acc(adresse+1,2,feu);end;
      if (combine=ral_30)    then begin pilote_acc(adresse+3,2,feu);sleep(tempo_Feu);pilote_acc(adresse,1,feu);end;
      if (combine=ral_60)    then begin pilote_acc(adresse+3,2,feu);sleep(tempo_Feu);pilote_acc(adresse,2,feu);end;
      if (combine=rappel_30) then begin pilote_acc(adresse+3,2,feu);sleep(tempo_Feu);pilote_acc(adresse+1,1,feu);end;
      if (combine=rappel_60) then begin pilote_acc(adresse+3,2,feu);sleep(tempo_Feu);pilote_acc(adresse+1,2,feu);end;
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
    code:=EtatSignalCplx[adresse];
    code_to_aspect(code,aspect,combine);
    s:='Signal virtuel: ad'+IntToSTR(adresse)+'='+chaine_signal(code);
    if traceSign then affiche(s,clOrange);
    if Affsignal then afficheDebug(s,clOrange);
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

    // sp�cifique au d�codeur digital bahn:
    // si le signal affichait un signal combin�, il faut �teindre le signal avec un s�maphore
    // avant d'afficher le nouvel �tat non combin�
    Ancralrap:=(TestBit(ancien_tablo_signalCplx[adresse],ral_30)) or (TestBit(ancien_tablo_signalCplx[adresse],ral_60)) or
               (TestBit(ancien_tablo_signalCplx[adresse],rappel_30)) or (TestBit(ancien_tablo_signalCplx[adresse],rappel_60)) ;
    // si ancien �tat du signal=jaune ou jaune cli
    Ancjau:=(TestBit(ancien_tablo_signalCplx[adresse],jaune)) or (TestBit(ancien_tablo_signalCplx[adresse],jaune_cli)) ;

    // si �tat demand� du signal=ralentissement ou rappel
    ralrap:=(TestBit(code,ral_30)) or (TestBit(code,ral_60)) or
            (TestBit(code,rappel_30)) or (TestBit(code,rappel_60)) ;
    // si �tat demand� du signal=jaune ou cli
    jau:=TestBit(code,jaune) or TestBit(code,jaune_cli) ;

    //effacement du signal combin� par s�maphore suivant condition
    if (((Ancralrap and not(ralrap)) or (Ancjau and not(jau))) and (aspect>=8)) then
    begin
      Sleep(40);
      pilote_acc(adresse+semaphore,2,feu) ;
     // dessine_feu(adresse);
    end;

    sleep(40);  // les commandes entre 2 feux successifs doivent �tre s�par�es au minimum de 100 ms
    // affichage du premier aspect du signal(1er bit � 1 dans codebin
    if aspect<>16 then pilote_acc(adresse+aspect,2,feu) ;

    // affichage de la signalisation combin�e (2�me bit � 1 dans codebin)
    if (Combine<>16) then
    begin
      sleep(40);
      pilote_ACC(adresse+Combine,2,feu) ;
    end;
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
  if i=0 then
  begin
    s:='Erreur 75: index signal '+intToSTR(adr)+' nul';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    exit;
  end;
  //Affiche(intToSTR(Adr)+' '+intToSTR(i),clWhite);
  if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //***
  begin
    if feux[i].aspect<10 then   // si signal non directionnel
    begin
      // envoie la commande au d�codeur
      case feux[i].decodeur of
       0 : envoi_virtuel(Adr);
       1 : envoi_signalBahn(Adr);
       2 : envoi_CDF(Adr);
       3 : envoi_LDT(Adr);
       4 : envoi_LEB(Adr);
       5 : envoi_NMRA(Adr);
       6 : envoi_UniSemaf(Adr);
       7 : envoi_SR(Adr);
      end;

      // Gestion d�marrage temporis� des trains si on quitte le rouge : ne fonctionne qu'avec CDM rail connect�
      if Option_demarrage and cdm_connecte then
      begin
        a:=ancien_tablo_signalCplx[adr];
        b:=EtatSignalCplx[adr];
        if ((a=semaphore_F) or (a=carre_F) or (a=violet_F)) and ((b<>semaphore_F) and (b<>carre_F) and (b<>violet_F)) then
        begin
          if not(Diffusion) then Affiche('On quitte le rouge du signal '+intToSTR(adr),clyellow);
          // y a t il un train en face du signal
          det:=feux[i].Adr_det1;
          if det<>0 then
          begin
            // test si train sur le d�tecteur det
            if detecteur[det].etat then
            begin
              detecteur[det].tempo:=20;  // armer la tempo � 2s
              // arreter le train
              s:=detecteur[det].train;
              detecteur[det].train:=s;
              //Affiche('et son d�tecteur '+IntToSTR(det)+'=1 tempo d�marrage ; train '+s,clYellow);
              s:=chaine_CDM_vitesseST(0,s);  // 0%
              envoi_cdm(s);
            end;
          end;
        end;
      end;

      ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr];

      // allume les signaux du feu dans la fen�tre de droite
      Dessine_feu_mx(Feux[i].Img.Canvas,0,0,1,1,adr,1);

      // allume les signaux du feu dans le TCO
      if AvecTCO then
      begin
       for y:=1 to NbreCellY do
       for x:=1 to NbreCellX do
       begin
         if TCO[x,y].Bimage=30 then
         begin
           adresse:=TCO[x,y].adresse;      // v�rifie si le feu existe dans le TCO
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
           x0:=(tco[x,y].x-1)*LargeurCell;  // coordonn�es XY du feu
           y0:=(tco[x,y].y-1)*HauteurCell;
           TailleY:=ImageFeu.picture.BitMap.Height; // taille du feu d'origine  (verticale)
           TailleX:=ImageFeu.picture.BitMap.Width;
           Orientation:=TCO[x,y].FeuOriente;
           // r�duction variable en fonction de la taille des cellules
           calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);

           // d�calage en X pour mettre la tete du feu align�e sur le bord droit de la cellule pour les feux tourn�s � 90G
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
  //chaque signal doit �tre appell� en fonction de sa proc�dure suivant le d�codeur
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

// trouve l'index d'un d�tecteur dans une branche
// si pas trouv�, renvoie 0
function index_detecteur(detecteur,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse;
        trouve:=(detecteur=adr) and ((BrancheN[Num_Branche,i].Btype=det) or (BrancheN[Num_branche,i].BType=buttoir)); // cherche un d�tecteur
        //Affiche('cherche='+intToSTR(det)+'/explore='+intToSTR(adr)+' Branche='+intToStr(Num_branche)+' index='+intToStr(i),ClWhite);
        if not(trouve) then inc(i);
        //if trouve then Affiche('Trouv� en branche'+IntToSTR(Num_branche)+' index='+IntToSTR(i),clGreen);
      until trouve or (adr=0) ;
    end;
begin
  i:=1;index2_det:=0;
  recherche;
  if trouve then result:=i else result:=0;
  //affiche(inttostr(ai+1),clOrange);
  i:=2; // � voir
  //affiche('------------------------',clWhite);
  recherche;
  //affiche('------------------------',clGreen);
  if trouve then index2_det:=i else index2_det:=0;
  //affiche('index2='+IntToSTR(index2_det),clWhite);
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
        //Affiche('cherche='+intToSTR(det)+'/explore='+intToSTR(adr)+' Branche='+intToStr(Num_branche)+' index='+intToStr(i),ClWhite);
        if not(trouve) then inc(i);
        //if trouve then Affiche('Trouv� en branche'+IntToSTR(Num_branche)+' index='+IntToSTR(i),clGreen);
      until trouve or (adr=0) ;
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

// si pas trouv�, IndexBranche_trouve=0
procedure trouve_detecteur(detecteur : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  repeat
    i:=index_detecteur(detecteur,Nbranche);
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

  i:=index_feu(adresse);
  if i<>0 then
  begin
    aspect:=feux[i].aspect;
    if  ((aspect=2) and (UniSem=2)) or
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
     Affiche('Erreur Signal '+intToSTR(adresse)+' inconnu',clred);
     Verif_Unisemaf:=3;
  end;
end;


// front descendant sur un d�tecteur
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

// trouve un �l�ment dans les branches � partir de la branche offset renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'�l�ment  TypeEL=(1=d�t�cteur 2=aig  3=aig Bis 4=aig triple)
procedure trouve_element(el: integer; TypeEl : TEquipement; Offset : integer);
var i,adr,Branche : integer ;
    s : string;
    BT : TEquipement;
    sort : boolean;
begin
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
  else begin s:='Erreur 175 - �l�ment '+intToSTR(el);
         s:=s+' non trouv�';Affiche(s,clred);
         branche_trouve:=0; IndexBranche_trouve:=0;
         if NivDebug>=1 then AfficheDebug(s,clred);
       end;
end;


// renvoie �l�ment suivant entre deux �l�ments quels qu'ils soient mais contigus
// attention, si les �l�ments ne sont pas contigus, le r�sultat est erronn�!!!
// et en variables globales: typeGen le type de l'�l�ment
// s'ils ne sont pas contigus, on aura une erreur
// alg= algorithme 1 � 3:
// 1=arret sur suivant qu'il soit un d�tecteur ou un aiguillage
// 2=arret sur aiguillage en talon mal positionn�
// 3=arret sur un aiguillage pris en pointe d�vi� et AdrDevie contient l'adresse de l'aiguillage d�vi� ainsi que typeGen
// code de sortie : �l�ment suivant ou:
// 9999: erreur fatale ou it�ration trop longue
// 9998: arret sur aiguillage en talon mal positionn�e
// 9997: arr�t sur aiguillage d�vi�
// 9996: arr�t sur position inconnue d'aiguillage
// la variable actuel peut etre chang�e en cas de TJD!
function suivant_alg3(prec : integer;typeELprec : TEquipement;var actuel : integer;typeElActuel : TEquipement;alg : integer) : integer;
var  Adr,AdrPrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2,N_iteration,index,NetatTJD,index2 : integer;
     tjscourbe1,tjscourbe2,tjdC,tjsC : boolean;
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
  if NivDebug=3 then
    AfficheDebug('Alg3 pr�c�dent='+intToSTR(prec)+'/'+BtypeToChaine(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+BtypeToChaine(typeElActuel)+' Alg='+intToSTr(alg),clyellow);
  // trouver les �l�ments du pr�c�dent
  trouve_element(prec,TypeELPrec,1); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;

  trouve_element(actuel,typeElActuel,1); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Bt:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

  //Affiche('Btype='+intToSTR(Btype)+' Actuel='+inTToSTR(actuel),clyellow);

  if Bt=det then  // l'�l�ment actuel est un d�tecteur
  begin
    // on part de l'actuel pour retomber sur le pr�c�dent
    if BrancheN[branche_trouve_actuel,indexBranche_actuel-1].Adresse=prec then // c'est l'autre sens
    begin
      if NivDebug=3 then AfficheDebug('40 - trouv� d�tecteur '+intToSTR(adr)+' en + ',clwhite);
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
      if NivDebug=3 then AfficheDebug('42 - trouv� d�tecteur '+intToSTR(adr)+' en - ',clwhite);
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
    // ici, les �l�ments sont non cons�cutifs. voir si l'un des deux est une TJD/TJS
    if (btypePrec=aig) then // car btype dans les branches vaut det, aig, buttoir mais jamais tjd ni tjs
    begin
      // changer l'adresse du pr�c�dent par l'autre adresse de la TJD/S
      index:=index_aig(prec);
      md:=aiguillage[index].modele;
      if (md=tjs) or (md=tjd) then
      begin
        prec:=Aiguillage[index_aig(prec)].Ddroit;
        if NivDebug=3 then AfficheDebug('Le pr�cedent est une TJD/S - substitution du prec�dent par la pointe de la TJD qui est '+intToSTR(prec),clYellow);
      end;
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
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          trouve_element(adr,typeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[index].position=const_devie then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe d�vi�',clyellow);
          // AdrPrec:=Adr;  // JU
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
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
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          trouve_element(adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;
          exit;
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
        if (alg=2) then // on demande d'arreter si l'aiguillage en talon est mal positionn�
        begin
          if aiguillage[index].position=const_droit then
          begin
            // si TJD (modele=2) sur le pr�c�dent, alors substituer avec la 2eme adresse de la TJD
            //if aiguillage[index_aig(prec)].modele=tjd then prec:=aiguillage[index_aig(prec)].DDroit;
            if prec<>aiguillage[index_aig(Adr)].Adroit then     //Adroit
            begin
              if NivDebug=3 then AfficheDebug('135.1 - Aiguillage '+intToSTR(adr)+' mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.2 - Aiguillage '+intToSTR(adr)+' bien positionn�',clyellow);
            end;
          end
          else
          begin
            if prec<>aiguillage[index].Adevie then   // Adevie
            begin
              if NivDebug=3 then AfficheDebug('135.3 Aiguillage '+intToSTR(adr)+' mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 Aiguillage '+intToSTR(adr)+' bien positionn�',clyellow);
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
        //  Affiche('trouv� '+intToSTR(adr),clyellow);
        if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
        trouve_element(adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        suivant_alg3:=adr;
        exit;
      end;
      if NivDebug=3 then
      begin
        s:='138 - Aiguillage '+IntToSTR(adr)+' non r�solu';
        if aiguillage[index].position=const_inconnu then s:=s+' car position inconnue';
        AfficheDebug(s,clOrange);
        Affiche(s,clOrange);
      end;

      suivant_alg3:=9999;exit;
    end;

    if (aiguillage[index].modele=tjd) or (aiguillage[index].modele=tjs) then // TJD ou TJS
    begin
      // r�cup�rer les �lements de la TJD/S
      AdrTjdP:=aiguillage[index].Ddroit; // 2eme adresse de la TJD/S
      index2:=index_aig(AdrTjdP);
      tjdC:=aiguillage[index].modele=tjd;
      tjsC:=aiguillage[index].modele=tjs;
      tjsc1:=aiguillage[index].tjsint;   // adresses de la courbe de la TJS
      tjsc2:=aiguillage[index2].tjsint;
      tjsc1B:=aiguillage[index].tjsintB;
      tjsc2B:=aiguillage[index2].tjsintB;
      NetatTJD:=aiguillage[index].etatTJD;
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
        s:='137 - TJD '+intToSTR(Adr);
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
        if aiguillage[index].position=const_droit then
        begin
          // d'o� vient t-on de la tjd
          if BtypePrec=Aig then
          begin
            if (aiguillage[index].Ddroit=prec) and
               (
                 ((aiguillage[index].DdroitB='D') and (aiguillage[index_aig(prec)].position=const_droit))  or
                 ((aiguillage[index].DdroitB='S') and (aiguillage[index_aig(prec)].position=const_devie))
                )   then
            begin
              Adr:=aiguillage[index].Adroit;  //Ddroit
              A:=aiguillage[index].AdroitB;
            end
            else
            begin
              if nivdebug=3 then
              begin
                s:='Erreur 120 : TJD 2 �tats '+intToSTR(Adr)+' non r�solue';
                AfficheDebug(s,clred);
                suivant_alg3:=9999;
                exit;
              end;
            end;

            if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig)
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 �tats est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;

          if BtypePrec=det then
          begin
            if aiguillage[index].Adroit=prec then
            begin
              Adr:=aiguillage[index].DDroit;  //Ddroit
              A:=aiguillage[index].DdroitB;
            end;
            if aiguillage[index].Adevie=prec then
            begin
              Adr:=aiguillage[index].Ddevie;
              A:=aiguillage[index].DdevieB;
            end;
            if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig)
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 �tats est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;
        end;

        if aiguillage[index].position=const_devie then
        begin
          if BtypePrec=Aig then
          begin
            if (aiguillage[index].Ddroit=prec) and
               (
                 ((aiguillage[index].DdroitB='D') and (aiguillage[index_aig(prec)].position=const_droit))  or
                 ((aiguillage[index].DdroitB='S') and (aiguillage[index_aig(prec)].position=const_devie))
                )   then
            begin
              Adr:=aiguillage[index].Adevie;
              A:=aiguillage[index].AdevieB;
            end
            else
            begin
              if nivdebug=3 then
              begin
                s:='Erreur 121 : TJD 2 �tats '+intToSTR(Adr)+' non r�solue';
                AfficheDebug(s,clred);
                suivant_alg3:=9999;
                exit;
              end;
            end;

            if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig)
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 �tats est '+IntToSTR(adr)+a,clyellow);
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
            if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig)
            suivant_alg3:=adr;
            if nivDebug=3 then Affichedebug('le port de destination de la tjd 2 �tats est '+IntToSTR(adr)+a,clyellow);
            exit;
          end;
        end;
      end;

      //---------------TJD 4 �tats ou TJS
      if (NetatTJD=4) or tjsC then
      begin
        // determiner la position de la premi�re section de la TJD (4 cas)
        // cas 1 : droit droit
        if (( aiguillage[index].position=const_droit) and
             (aiguillage[index2].position=const_droit) and tjdC)  then
        begin
          // d'o� vient ton sur la tjd
          if BtypePrec=Aig then
          begin
             if ( ((aiguillage[index].AdroitB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
                ( ((aiguillage[index].AdroitB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
             then
               begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 1.1',clyellow);end
             else
             begin
               if NivDebug=3 then AfficheDebug('135.5- TJD '+intToSTR(adr)+' mal positionn�e cas 1.1',clyellow);
               if alg=2 then
               begin
                 suivant_alg3:=9998;exit;
               end;
             end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adroit)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 1.2',clyellow);end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.6- TJD '+intToSTR(adr)+' mal positionn�e cas 1.2',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
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
          if NivDebug=3 then AfficheDebug('cas1.1 tjd: '+s+' Adr='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          suivant_alg3:=adr;
          Actuel:=aiguillage[index2].Adresse; // substitution de la TJS
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 2 TJD
        if (aiguillage[index].position=const_devie)
           and (aiguillage[index2].position=const_droit) and tjdC then
        begin
          // d'o� vient ton sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdroitB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdroitB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
            begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e - cas 2.1',clyellow);
              if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionn�e - cas 2.1',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
              end;
            end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adroit)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 2.2',clyellow);
              if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.18- TJD '+intToSTR(adr)+' mal positionn�e cas 2.2',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
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
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 3 TJD
        if (aiguillage[index].position=const_droit)
          and (aiguillage[index2].position=const_devie) and tjdC then
        begin
          // d'o� vient ton sur la tjd
          if BtypePrec=Aig then
          begin
            if ( ((aiguillage[index].AdevieB)='S') and (aiguillage[index_aig(prec)].position=const_devie) ) or
               ( ((aiguillage[index].AdevieB)='D') and (aiguillage[index_aig(prec)].position=const_droit) )
            then
              begin if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 3.1',clyellow);
              if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end  
            else
            begin
              if NivDebug=3 then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionn�e cas 3.1',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
              end;
            end;
          end;

          if BtypePrec=det then
          begin
            if (aiguillage[index].Adevie)=prec then
            begin
              if NivDebug=3 then AfficheDebug('TJD '+intToSTR(adr)+' bien positionn�e cas 3.2',clyellow);
              if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
              begin
                typeGen:=rien;
                AdrDevie:=Adr;
                suivant_alg3:=9997;exit;
              end;
            end  
            else
            begin
              if NivDebug=3 then AfficheDebug('135.8- TJD '+intToSTR(adr)+' mal positionn�e cas 3.2',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
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
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
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
              if NivDebug=3 then AfficheDebug('135.7- TJD '+intToSTR(adr)+' mal positionn�e cas 4.1',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
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
              if NivDebug=3 then AfficheDebug('135.8- TJD '+intToSTR(adr)+' mal positionn�e cas 4.2',clyellow);
              if alg=2 then
              begin
                suivant_alg3:=9998;exit;
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
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas TJS prise dans sa position courbe
        if ((aiguillage[index].Adevie=Prec) and (aiguillage[index].AdevieB=Aprec) and (aiguillage[index].position<>const_droit)
        and (aiguillage[index_aig(AdrTjdP)].position=const_droit) and (tjsC) and tjscourbe1 and tjscourbe2) then
        begin
          if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
          A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          Actuel:=aiguillage[index2].Adresse;
          suivant_alg3:=adr;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;

        // cas 3 TJS prise dans sa 2eme position courbe
        if ((aiguillage[index].Adroit=Prec) and (aiguillage[index].AdroitB=Aprec) and (aiguillage[index].position=const_droit)
             and (aiguillage[index_aig(AdrTjdP)].position<>const_droit) and (tjsC) and tjscourbe1 and tjscourbe2 ) then
        begin
          if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
          A:=aiguillage[index_aig(AdrTjdP)].AdevieB;
          Adr:=aiguillage[index_aig(AdrTjdP)].Adevie;
          if A='Z' then typeGen:=det else typeGen:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          suivant_alg3:=adr;
          Actuel:=aiguillage[index2].Adresse;
          if nivDebug=3 then Affichedebug('le port de destination de la tjd 4 �tats est '+IntToSTR(adr)+a,clyellow);
          exit;
        end;
        s:='1026 - position TJD/S '+IntToSTR(Adr)+'/'+intToSTR(AdrTJDP)+' inconnue';
        AfficheDebug(s,clOrange);
        suivant_alg3:=9999;exit;
      end;
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
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig  
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[index].position<>const_droit) and (aiguillage[index_aig(Adr2)].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�1 (� gauche)',clYellow);
          A:=aiguillage[index].AdevieB;
          Adr:=aiguillage[index].Adevie;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[index].position=const_droit) and (aiguillage[index_aig(Adr2)].position<>const_droit)  then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�2 (� droite)',clYellow);
          A:=aiguillage[index].Adevie2B;
          Adr:=aiguillage[index].Adevie2;
          if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        begin
          if aiguillage[index].position=const_inconnu then begin suivant_alg3:=9996;exit;end; // pour �chappement
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
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionn�
        begin
          if (aiguillage[index].position=const_droit) and (aiguillage[index_aig(adr2)].position=const_droit) then
          begin
            if prec<>aiguillage[index].Adroit then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
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
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
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
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionn�',clyellow);
            end;
          end;
        end;
        A:=aiguillage[index].ApointeB;
        Adr:=aiguillage[index].Apointe;
        if A='Z' then TypeEl:=det else TypeEL:=aig;  //TypeEL=(1=d�t�cteur 2=aig  
        trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        suivant_alg3:=Adr;exit;
      end;
    end;
  end;
  suivant_alg3:=adr;
end;

// trouve l'index du feu associ� au d�tecteur adr
// renvoie dans voie le num�ro de la voie (1 � 4) du signal sur lequel le d�tecteur se trouve
// attention , il peut y avoir plus d'un feu sur un detecteur (suivant le sens)!
// si 2eme feu, son indes est dans index2
function index_feu_det(adr : integer;var voie,index2 : integer) : integer ;
    var trouve,i,index1 : integer;
    trouve1,trouve2,trouve3,trouve4 : boolean;
begin
  i:=1;
  trouve:=0;
  index2:=0;
  index1:=0;
  voie:=0;
  repeat
    trouve1:=feux[i].Adr_det1=adr;
    trouve2:=feux[i].Adr_det2=adr;
    trouve3:=feux[i].Adr_det3=adr;
    trouve4:=feux[i].Adr_det4=adr;


    if trouve1 or trouve2 or trouve3 or trouve4 then
    begin
      inc(trouve);
      if trouve=1 then index1:=i;
      if trouve=2 then index2:=i;
      if trouve=1 then              // on ne m�morise la voie qu'a la premiere recherche
      begin
        if trouve1 then voie:=1;
        if trouve2 then voie:=2;
        if trouve3 then voie:=3;
        if trouve4 then voie:=4;
      end;
    end;
    inc(i);
  until (trouve=2) or (i>NbreFeux);
  Index_feu_det:=index1;
end;

// renvoie l'adresse du d�tecteur suivant des deux �l�ments contigus
// TypeElprec/actuel: 1= d�tecteur  2= aiguillage 4=Buttoir
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
  // �tape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,TypeprecCalc,actuelCalc,TypeActuelCalc,algo); 
    indexCalc:=index_aig(actuelCalc);
    if (typeGen=tjd) and false then // si le pr�c�dent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[index_aig(AdrSuiv)].modele=tjd) or (aiguillage[index_aig(AdrSuiv)].modele=tjs)) and
           ((aiguillage[indexCalc].modele=tjd) or (aiguillage[indexCalc].modele=tjs)) then
        begin
          if nivDebug=3 then AfficheDebug('501 - D�tection Pr�c�dent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuelCalc:=aiguillage[indexCalc].APointe;
        end;
      end;
    precCalc:=actuelCalc;
    TypeprecCalc:=TypeActuelCalc;
    actuelCalc:=AdrSuiv;
    TypeActuelCalc:=typeGen;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=10) or (typeGen=det) or (AdrSuiv=0) or (AdrSuiv>=9996); // arret si d�tecteur

  // si trouv� le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1);
  end;
  if (NivDebug=3) and (AdrSuiv<9996) then AfficheDebug('618 : Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// renvoie les adresses des d�tecteurs adjacents au d�tecteur "adresse" (avant, apr�s)
// r�sultat dans adj1 et adj2 en variable globale
procedure Det_Adj(adresse : integer);
var Adr,AdrFonc,Branche,AdrPrec,IndexBranche,i,Dir : integer;
    sortie : boolean;
    BtypeFonc,BtypePrec : TEquipement;
begin
  if TraceListe then AfficheDebug('Det_Adj '+IntToSTR(adresse),clyellow);
  trouve_element(adresse,det,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('Erreur 380 : �l�ment '+IntToSTR(adresse)+' non trouv�',clred);
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
        Adr:=suivant_alg3(AdrPrec,BtypePrec,AdrFonc,BtypeFonc,2);  // �l�ment suivant mais arret sur aiguillage en talon mal positionn�e
      end
      else
        begin Adr:=AdrFonc;TypeGen:=BtypeFonc;end;
      if Adr>9990 then typeGen:=det;
      if (NivDebug=3) then AfficheDebug('trouv� '+intToSTR(Adr)+' '+intToSTR(BTypeToNum(typeGen)),clorange);
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

// renvoie l'adresse du d�tecteur suivant des deux �l�ments
// El1 et El2 peuvent �tre s�par�s par des aiguillages, mais de pas plus de 3 d�tecteurs
// en sortie : 9999= det1 ou det2 non trouv�
// 9996 : non trouv�
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
    if NivDebug=3 then AfficheDebug('param�tres incorrects >9000',clred);
    detecteur_suivant_El:=9999;
  end;

  // trouver d�tecteur 1
  trouve_element(el1,Typedet1,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    if NivDebug=3 then
    begin
      s:='611. '+IntToSTR(el1)+' non trouv�';
      AfficheDebug(s,clOrange);
    end;
    detecteur_suivant_El:=9999;exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver d�tecteur 2
  trouve_element(el2,Typedet2,1); // branche_trouve  IndexBranche_trouve
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
  j:=1;  // J=1 test en incr�ment J=2 test en d�cr�ment

  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)

  repeat
    //pr�parer les variables
    AdrPrec:=el1;TypePrec:=typeDet1;
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
          s:='613 : trouv�='+intToSTR(Adr);
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
      if (i=15) and (Nivdebug=3) then afficheDebug('Pas trouv�',clyellow);
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
  
    if (typeDet2=TypeGen) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      if Nivdebug=3 then AfficheDebug('614 - Trouv� '+intToSTR(el2),clYellow);
      i:=0;
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,alg);
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);

        if NivDebug=3 then
        begin
          s:='614 : trouv�='+intToSTR(Adr);
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
          AfficheDebug('le d�tecteur suivant est le '+IntToSTR(Adr),clyellow);
          affichedebug('------------------',clyellow);
        end;
        detecteur_suivant_el:=Adr;
        exit;
      end;
    end;
    if (i=10) then if NivDebug=3 then AfficheDebug('201 : It�ration trop longue',clred);
    inc(j);
    //AfficheDebug('j='+intToSTR(j),clyellow);
  until j=3;  // boucle incr�ment/d�cr�ment

  detecteur_suivant_el:=9996;
  if NivDebug=3 then affichedebug('------------------',clyellow);
end;


// renvoie vrai si les aiguillages d�clar�s dans la d�finition du signal sont mal positionn�s
// (conditions supppl�mentares)
function cond_carre(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig,index : integer;
    resultatET,resultatOU: boolean;
    s : string;
begin
  i:=index_feu(adresse);
  if i=0 then
  begin
    Affiche('Erreur 602 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    if NivDebug=3 then AfficheDebug('Erreur 602 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    cond_carre:=true;
    exit;
  end;
  
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
        if nivDebug=3 then AfficheDebug('Contr�le aiguillage '+IntToSTR(AdrAig),clyellow);
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
    s:='Conditions supp. de carr� suivant aiguillages: ';
    if ResultatOU then s:=s+'vrai : le signal doit afficher carr�' else s:=s+'faux : le signal ne doit pas afficher de carr�';
    AfficheDebug(s,clyellow);
  end;
  cond_carre:=ResultatOU;
end;

// renvoi vrai si les aiguillages au del� du signal sont mal positionn�s
function carre_signal(adresse : integer) : boolean;
var
   i,j,prec,indexFeu,AdrSuiv,index2,voie,AdrFeu : integer;
   TypeELPrec,TypeElActuel : TEquipement;
   multi, sort  : boolean;
   s : string;
begin
  if (NivDebug>=1) then AfficheDebug('Test si signal '+IntToSTR(adresse)+' doit afficher un carr� si aiguillage avals mal positionn�s',clyellow);

  i:=Index_feu(adresse);
  if i=0 then
  begin
    Affiche('Erreur 603 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    if NivDebug=3 then AfficheDebug('Erreur 603 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    carre_signal:=true;
    exit;
  end;

  j:=0;
  prec:=feux[i].Adr_det1;
  TypeElPrec:=Det;
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=det then TypeElActuel:=det;  // le type du feu   1=d�t�cteur   2=aig  5=bis
  if feux[i].Btype_suiv1=aig then TypeElActuel:=aig;
  multi:=feux[i].Adr_det2<>0;
   // trouver si une des voies pr�sente un train
  if (multi) then
  begin
    carre_signal:=FALSE;   // pour l'instant verrouill�
    exit;
  end;

  //Affiche(IntToSTR(actuel),clyellow);
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(prec,typeElPrec,actuel,typeELActuel,2);

    if (AdrSuiv=9999) or (AdrSuiv=9996) then // �l�ment non trouv� ou position aiguillage inconnu
    begin
      carre_signal:=true;
      exit;
    end;
    if (AdrSuiv<>9998) then // arret sur aiguillage en talon mal positionn�e
    begin
      prec:=actuel;
      TypeElPrec:=TypeElActuel;
      actuel:=AdrSuiv;
      TypeElActuel:=typeGen;
    end;
    // si le suivant est un d�tecteur comporte t-il un signal?
    indexFeu:=0;
    if (prec>500) then
    begin
      //indexFeu:=index_feu_det(AdrSuiv,voie,index2); // trouve l'index du feu correspondant au d�tecteur AdrSuiv
      indexFeu:=index_feu_det(prec,voie,index2); // trouve l'index du feu correspondant au d�tecteur AdrSuiv

      if indexFeu<>0 then
      begin
        AdrFeu:=feux[indexFeu].adresse;
                                                 
        if nivdebug=3 then s:='Trouv� signal '+intToSTR(AdrFeu);
        if ((voie=1) and (Feux[indexFeu].Adr_el_suiv1=AdrSuiv)) or
           ((voie=2) and (Feux[indexFeu].Adr_el_suiv2=AdrSuiv)) or
           ((voie=3) and (Feux[indexFeu].Adr_el_suiv3=AdrSuiv)) or
           ((voie=4) and (Feux[indexFeu].Adr_el_suiv4=AdrSuiv))
        then   // le feu est-il dans le bon sens de progression?
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
          indexFeu:=0;
          // 2eme feu?
          if index2<>0 then
          begin
            // v�rifier le 2eme feu
            AdrFeu:=Feux[index2].Adresse;

            if (adrFeu=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
            begin
              IndexFeu:=0;j:=10; // on ne trouve pas de suivant
            end;
            //AdrSuivProv:=suivant_alg3(prec,typeElPrec,actuel,typeELActuel,2);
            if (Feux[index2].Adr_el_suiv1=AdrSuiv) then   // le feu est-il dans le bon sens de progression?
            begin
              // oui
              if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� feu2 suivant Adr='+IntToSTR(AdrFeu)+': ',clYellow);
              indexFeu:=index2;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� feu2 '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clYellow);
              IndexFeu:=0;
            end;
         end;
        end;
      end;
      //Affiche(IntToSTR(AdrFeu),clOrange);
    end;
    sort:=(j=10) or (indexFeu<>0) or (AdrSuiv=9998) or (AdrSuiv=0); // arret si aiguillage en talon ou buttoir
  until (sort);
  // si trouv� un feu ou j=10, les aiguillages sont bien positionn�s
  // si trouv� 9998, aiguillages mal positionn�s
  if (NivDebug>=1) then
  begin
   if (AdrSuiv=9998) then AfficheDebug('Le signal '+intToSTR(adresse)+' doit afficher un carr� car l''aiguillage pris en talon '+IntToSTR(actuel)+' est mal positionn�',clYellow)
    else AfficheDebug('Le signal '+IntToSTR(adresse)+' ne doit pas �tre au carr�',clYellow);
  end;
  carre_signal:=AdrSuiv=9998;
end;

// renvoie l'�tat du signal suivant
// si renvoie 0, pas trouv� le signal suivant.
// rang=1 pour feu suivant, 2 pour feu suivant le 1, etc
// Dans AdresseFeuSuivant : adresse du feu suivant (variable globale)
function etat_signal_suivant(adresse,rang : integer) : integer ; 
var num_feu,etat,AdrFeu,i,j,prec,AdrSuiv,index2,voie : integer;
    aspect,combine : word;
    TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('Cherche �tat du signal suivant au '+IntToSTR(adresse),clyellow);
  i:=Index_feu(adresse);
  if i=0 then
  begin
    if NivDebug>=2 then AfficheDebug('Feu '+IntToSTR(adresse)+' non trouv�',clyellow);
    etat_signal_suivant:=0;
    exit;
  end;
  if feux[i].aspect>10 then
  begin
    s:='La demande de l''�tat du signal suivant depuis un feu directionnel '+IntToSTR(Adresse)+' est irrecevable';
    Affiche(s,clred);
    AfficheDebug(s,clred);
    etat_signal_suivant:=0;
    exit;
  end;
  if i=0 then
  begin
    Affiche('Erreur 600 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    if NivDebug=3 then AfficheDebug('Erreur 600 - feu '+IntToSTR(adresse)+' non trouv�',clred); 
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;
  Etat:=0;
  j:=0;
  num_feu:=0;
  prec:=Feux[i].Adr_det1;  // d�tecteur sur le courant
  TypePrec:=det;
  if prec=0 then
  begin
    Affiche('Msg 601 - feu '+intToSTR(adresse)+' d�tecteur non renseign� ',clOrange);
    if NivDebug=3 then AfficheDebug('Msg 601 - feu '+intToSTR(adresse)+' d�tecteur non renseign� ',clOrange);
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;

  actuel:=feux[i].Adr_el_suiv1;
  typeActuel:=feux[i].Btype_suiv1;
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
        Etat_signal_suivant:=carre_F; // faire comme si c'�tait un signal au carr�
        AdresseFeuSuivant:=0;
        exit;
      end;
    end;
    // si le suivant est un d�tecteur comporte t-il un signal?
    AdrFeu:=0;
    if (TypeActuel=det) then  // d�tecteur?
    begin
      i:=Index_feu_det(Actuel,voie,index2); // trouve l'index de feu affect� au d�tecteur "Actuel"
      if i<>0 then
      begin
        AdrFeu:=Feux[i].Adresse;
        if (adrFeu=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
        begin
          AdrFeu:=0;j:=10; // on ne trouve pas de suivant
        end;
        if (AdrFeu<>0) then // si l'adresse est <>0
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          if nivdebug=3 then afficheDebug('Trouv� Feu='+IntToSTR(AdrFeu)+'sur det '+intToSTR(actuel)+' Suivant='+IntToSTR(AdrSuiv)+' sur voie='+IntToSTR(voie),clyellow );
          //if NivDebug=3 then AfficheDebug('Suiv='+intToSTR(AdrSuiv),clyellow);
          if ((voie=1) and (Feux[i].Adr_el_suiv1=AdrSuiv)) or
             ((voie=2) and (Feux[i].Adr_el_suiv2=AdrSuiv)) or
             ((voie=3) and (Feux[i].Adr_el_suiv3=AdrSuiv)) or
             ((voie=4) and (Feux[i].Adr_el_suiv4=AdrSuiv))
           then   // le feu est-il dans le bon sens de progression?
          begin
            // oui
            inc(num_feu);
            Etat:=EtatSignalCplx[AdrFeu];
            code_to_aspect(Etat,aspect,combine);
            Signal_suivant:=AdrFeu;
            if NivDebug=3 then AfficheDebug('Trouv� feu suivant Adr='+IntToSTR(AdrFeu)+': '+IntToSTR(etat)+'='+EtatSign[aspect]+' '+EtatSign[combine],clorange);
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouv� feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
            AdrFeu:=0;
            if index2<>0 then
            begin
               // v�rifier le 2eme feu
               AdrFeu:=Feux[index2].Adresse;

               if (adrFeu=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
               begin
                 AdrFeu:=0;j:=10; // on ne trouve pas de suivant
               end;
               if (Feux[index2].Adr_el_suiv1=AdrSuiv) then   // le feu est-il dans le bon sens de progression?
               begin
                 // oui
                 inc(num_feu);
                 Etat:=EtatSignalCplx[AdrFeu];
                 code_to_aspect(Etat,aspect,combine);
                 Signal_suivant:=AdrFeu;
                 if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� feu2 suivant Adr='+IntToSTR(AdrFeu)+': '+IntToSTR(etat)+'='+EtatSign[aspect]+' '+EtatSign[combine],clorange);

               end
               else
               begin
                 if NivDebug=3 then AfficheDebug('Sur m�me d�tecteur, trouv� feu2 '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
                 AdrFeu:=0;
               end;
            end;
//            AdrFeu:=0;
          end;
        end
      end
      else if nivDebug=3 then AfficheDebug('Pas de feu pour le det '+IntToSTR(AdrSuiv),clyellow);
    end;
  until (j=10) or ((AdrFeu<>0) and (num_feu=rang));
  if etat=0 then Signal_Suivant:=0;
  etat_signal_suivant:=Etat;
  AdresseFeuSuivant:=Signal_suivant;
  if (NivDebug=3) and (adrFeu=0) then AfficheDebug('Pas Trouv� de feu suivant au feu Adr='+IntToSTR(ADresse),clOrange);
end;

// renvoie l'adresse de l'aiguille si elle est d�vi�e apr�s le signal et ce jusqu'au prochain signal
// sinon renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;
var AdrFeu,i,j,prec,AdrSuiv,Actuel,index,index2,voie : integer;
   TypePrec,TypeActuel : TEquipement;
    s : string;
begin
  if NivDebug>=2 then AfficheDebug('Test si aiguille d�vi�e apr�s signal '+IntToSTR(Adresse),clyellow);
  j:=0;
  i:=Index_feu(adresse);
  if i=0 then
  begin
    Affiche('Erreur 168: signal '+intToSTR(adresse)+' non trouv�',clred);
    exit;
  end;
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
    // le 3=demande si le suivant est un aiguillage en pointe d�vi� oui si AdrSuiv=9997
    // dans ce cas la variable globale AdrDevie est mise � jour
    AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,3);

    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if (AdrSuiv<>9997) and (AdrSuiv<>0) then
    begin
      // pas trouv� aig d�vi�
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      // si le suivant est un d�tecteur comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=det) then  // d�tecteur
      begin
        i:=Index_feu_det(AdrSuiv,voie,index2); // trouve l'index de feu affect� au d�tecteur "AdrSuiv"
        AdrFeu:=Feux[i].Adresse;
        if NivDebug=3 then AfficheDebug('trouv� signal '+intToSTR(AdrFeu)+' associ� au d�tecteur '+IntToSTR(AdrSuiv),clyellow);
      end;
    end;
  until (j=10) or (AdrSuiv>=9996) or (AdrFeu<>0) or (AdrSuiv=0) ;
  if (AdrSuiv=9997) then
  begin
     s:='le signal '+intToSTR(adresse)+' doit afficher un rappel car l''aiguillage '+intToSTR(AdrDevie);
     s:=s+' est d�vi�';
     if NivDebug=3 then AfficheDebug(s,clYellow);
  end;
  if ((AdrSuiv<>9997) or (j=10)) and (NivDebug=3) then
  begin
    S:='le signal '+intToSTR(adresse)+' ne doit pas afficher de rappel car ';
    if j<>10 then s:=s+'trouv� un autre signal suivant et pas d''aiguillage d�vi�'
    else s:=s+' signal trop �loign�';
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

// allume le signal directionnel d'adresse ADR en fonction de la position des aiguillages d�clar�s pour ce feu
procedure Signal_direction(Adr : integer);
var NAig,i,id,j,NfeuxDir,AdrAigFeu,Position : integer;
    PosAigFeu : char;
    Positionok : boolean;
begin
  id:=Index_feu(Adr);
  NfeuxDir:=feux[id].aspect-10;
  i:=1;   // i=1 position �teinte du feu ; pour les autres valeurs de i : nombre de feux allum�s
  repeat
    NAig:=length(feux[id].AigDirection[i])-1;
    if i=1 then positionok:=false else positionok:=true;
    for j:=1 to Naig do
    begin
      // v�rifier la position d�clar�e des aiguillages pour chaque feu
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
    dec(i,2);   // i correspond au nombre de feux � allumer
    pilote_direction(Adr,i);
  end;                 

end;

// renvoie vrai si une m�moire de zone est occup�e du signal courant au signal suivant
// sort de suite si on trouve un train
// adresse=adresse du signal
function test_memoire_zones(adresse : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,i,j,
  dernierdet,AdrFeu,Nfeux,NFeuxMax,voie,index2 : integer;
  TypePrec,TypeActuel : TEquipement;
  Pres_train : boolean;
  s : string;
begin
  if NivDebug>=1 then AfficheDebug('Proc test_memoire_zones('+intToSTR(adresse)+')',clyellow);
  i:=Index_feu(adresse);
  if (i=0) then
  begin
    Affiche('Erreur 605 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    AfficheDebug('Erreur 605 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    test_memoire_zones:=false;
  end;

  Nfeux:=0;
  NFeuxMax:=1; // nombre de feux � trouver (nombre de cantons)
  Pres_train:=FALSE;
  ife:=1;  // index feu de 1 � 4 pour explorer les 4 d�tecteurs d'un feu
  repeat
    j:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test feu '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      prec:=feux[i].Adr_det1;
      Actuel:=feux[i].Adr_el_suiv1;
      TypeActuel:=feux[i].Btype_suiv1;
    end;  //d�tecteur sur le signal courant
    if (ife=2) then
    begin
      prec:=feux[i].Adr_det2;
      Actuel:=feux[i].Adr_el_suiv2;
      TypeActuel:=feux[i].Btype_suiv2;
    end;  // d�tecteur sur le signal courant
    if (ife=3) then
    begin
      prec:=feux[i].Adr_det3;
      Actuel:=feux[i].Adr_el_suiv3;
      TypeActuel:=feux[i].Btype_suiv3;
    end;  // d�tecteur sur le signal courant
    if (ife=4) then
    begin
      prec:=feux[i].Adr_det4;
      Actuel:=feux[i].Adr_el_suiv4;
      TypeActuel:=feux[i].Btype_suiv4;
    end;  // d�tecteur sur le signal courant

    if prec=0 then
    begin
      // sortie si aucun d�tecteur d�clar� sur le feu
      test_memoire_zones:=Pres_train;
      exit;
    end;
    
    TypePrec:=det;
    dernierdet:=prec;
           
    // purge les aiguillages apr�s le feu
    if TypeActuel=aig then
    repeat
      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      if (AdrSuiv>9900) or (AdrSuiv=0) then
      begin
        test_memoire_zones:=Pres_train;
        exit;
      end;
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
    until typeactuel=det;

    repeat
      inc(j);

      if (typeactuel=det) and (dernierdet<>0) then
      begin
        Pres_train:=MemZone[dernierdet,actuel] or Pres_Train;
        if (nivDebug=3) then
        begin
          if Pres_Train then AfficheDebug('Pr�sence train de '+intToSTR(dernierdet)+' � '+intToSTR(actuel),clyellow)
          else AfficheDebug('Absence train de '+intToSTR(dernierdet)+' � '+intToSTR(actuel),clyellow)
        end;
        Pres_train:=MemZone[actuel,dernierdet] or Pres_Train;
        if (nivDebug=3) then
        begin
          if Pres_Train then AfficheDebug('Pr�sence train inverse de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow)
          else AfficheDebug('Absence train de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow)
        end;
        // sortir de suite
        if Pres_train then
        begin
          test_memoire_zones:=Pres_train;
          exit;
        end;  
        
        dernierdet:=actuel;

        i:=index_feu_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au d�tecteur "AdrSuiv": il peut y avoir 4 d�tecteurs par signal
        if i<>0 then
        begin
          AdrFeu:=feux[i].adresse;    // adresse du feu
          if (AdrFeu=adresse) then  // si on ne reboucle sur le m�me signal dont on cherche le suivant
          begin
            AdrFeu:=0;j:=10; // on ne trouve pas de suivant
            test_memoire_zones:=false;
            exit;
          end;
          if (AdrFeu<>0) then // si l'adresse est <>0
          begin
            if (feux[i].Adr_el_suiv1<>prec) then   // le feu est-il dans le bon sens de progression?
            begin
              inc(Nfeux);
              j:=0;
              s:='Trouv� feu ('+IntToSTR(nfeux)+'/'+intToSTR(NFeuxMax)+') '+IntToSTR(AdrFeu);
              if (NivDebug>0) And Pres_Train then AfficheDebug(s+' et m�moire de zone � 1',clyellow);
              if (NivDebug>0) And (not(Pres_Train)) then AfficheDebug(s+' et m�moire de zone � 0',clOrange);
              if nFeux=NFeuxMax then
              begin
                test_memoire_zones:=Pres_train;
                exit;
              end;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('Trouv� feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clYellow);
              AdrFeu:=0;
            end;
          end;
        end;
      end;

      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
      if (AdrSuiv=0) or (AdrSuiv>9990) then
      begin
        test_memoire_zones:=Pres_train;
        exit;
      end;
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

    until (j=10);  // on arrete si on va trop loin (10 it�rations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) then AfficheDebug('Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);
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
    trouve:=(event_det_tick[i].etat=etat) and (event_det_tick[i].detecteur=Adr) ;
  until (trouve or (i=0));
  if trouve then
  begin
    trouve_index_det_chrono:=i;exit;
  end;
  trouve_index_det_chrono:=0;
end;

// teste si la route est valide de det1, det2 � det3
// les d�tecteurs doivent �tre cons�cutifs
// trouve le d�tecteur suivant de det1 � det2 si la route est correcte. (d�tecteurs en entr�e obligatoires)
// transmis dans le tableau Event_det
// R�sultat:
// si 9999 : pas de route
// si 10 : ok route trouv�e
function test_route_valide(det1,det2,det3 : integer) : integer;
var det_suiv,resultat : integer;
begin
  if TraceListe then AfficheDebug('test route valide '+IntToSTR(det1)+' '+IntToSTR(det2)+' vers '+IntToSTR(det3)+' ',clyellow);
  det_suiv:=detecteur_suivant_el(det1,det,det2,det,1);
  if det_suiv=det3 then begin test_route_valide:=10;exit;end;

  test_route_valide:=9999;
  exit;
end;

// pr�sence train pr�c�dent les 3 cantons du signal (soit 4 feux avant)
function PresTrainPrec(Adresse : integer) : boolean;
var
  AdrSuiv,prec,ife,actuel,i,j,
  dernierdet,AdrFeu,Nfeux,NFeuxMax,voie,index2 : integer;
  TypePrec,TypeActuel : TEquipement;
  Pres_train : boolean;
  s : string;
begin
  if NivDebug>=1 then AfficheDebug('Proc testTrainPrec('+intToSTR(adresse)+')',clyellow);
  i:=Index_feu(adresse);
  if (i=0) then
  begin
    Affiche('Erreur 605 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    AfficheDebug('Erreur 605 - feu '+IntToSTR(adresse)+' non trouv�',clred);
    PresTrainPrec:=false;
  end;

  Nfeux:=0;
  NFeuxMax:=3; // nombre de feux � trouver (nombre de cantons)
  Pres_train:=FALSE;
  ife:=1;  // index feu de 1 � 4 pour explorer les 4 d�tecteurs d'un feu
  repeat
    j:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test feu '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      actuel:=feux[i].Adr_det1;
      prec:=feux[i].Adr_el_suiv1;
      Typeprec:=feux[i].Btype_suiv1;
    end;  //d�tecteur sur le signal courant
    if (ife=2) then
    begin
      actuel:=feux[i].Adr_det2;
      prec:=feux[i].Adr_el_suiv2;
      Typeprec:=feux[i].Btype_suiv2;
    end;  // d�tecteur sur le signal courant
    if (ife=3) then
    begin
      actuel:=feux[i].Adr_det3;
      prec:=feux[i].Adr_el_suiv3;
      Typeprec:=feux[i].Btype_suiv3;
    end;  // d�tecteur sur le signal courant
    if (ife=4) then
    begin
      actuel:=feux[i].Adr_det4;
      prec:=feux[i].Adr_el_suiv4;
      Typeprec:=feux[i].Btype_suiv4;
    end;  // d�tecteur sur le signal courant

    TypeActuel:=det;
    if actuel=0 then
    begin
      // sortie si aucun d�tecteur d�clar� sur le feu
      PresTrainPrec:=Pres_train;
      exit;
    end;

    dernierdet:=actuel;

    repeat
      inc(j);

      AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,2);  // 2 car arr�t sur aiguille en talon mal positionn�e
      if (AdrSuiv=0) or (AdrSuiv>9990) then
      begin
        PresTrainPrec:=Pres_train;
        exit;
      end;

      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;

      if typeactuel=det then
      begin
        Pres_train:=MemZone[actuel,dernierdet] or Pres_Train;
        if (nivDebug=3) then
        begin
          if Pres_Train then
          begin
            AfficheDebug('Pr�sence train de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow);
            PresTrainPrec:=Pres_train;
            exit;
          end
          else AfficheDebug('Absence train de '+intToSTR(actuel)+' � '+intToSTR(dernierdet),clyellow)
        end;
        dernierdet:=actuel;

        i:=index_feu_det(Actuel,voie,index2);  // renvoie l'index du signal se trouvant au d�tecteur "AdrSuiv": il peut y avoir 4 d�tecteurs par signal
        if i<>0 then
        begin
          AdrFeu:=feux[i].adresse;    // adresse du feu
          if (AdrFeu=adresse) then  // si on ne reboucle sur le m�me signal dont on cherche le suivant
          begin
            AdrFeu:=0;j:=10; // on ne trouve pas de suivant
            PresTrainPrec:=false;
            exit;
          end;
          if (AdrFeu<>0) then // si l'adresse est <>0
          begin
            if (feux[i].Adr_el_suiv1=prec) then   // le feu est-il dans le bon sens de progression?
            begin
              inc(Nfeux);
              j:=0;
              s:='Trouv� feu ('+IntToSTR(nfeux)+'/'+intToSTR(NFeuxMax)+') '+IntToSTR(AdrFeu);
              if (NivDebug>0) And Pres_Train then AfficheDebug(s+' et m�moire de zone � 1',clyellow);
              if (NivDebug>0) And (not(Pres_Train)) then AfficheDebug(s+' et m�moire de zone � 0',clOrange);
              if nFeux=NFeuxMax then
              begin
                PresTrainPrec:=Pres_train;
                exit;
              end;
             end
             else
             begin
              if NivDebug=3 then AfficheDebug('Trouv� feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clYellow);
              AdrFeu:=0;
            end;
          end;
        end;
      end;
      until (j=10);  // on arrete jusqu'� trouver un signal ou si on va trop loin (10 it�rations)
      inc(ife);
    until ife>=5;
  if (NivDebug>0) then AfficheDebug('Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);
  PresTrainPrec:=Pres_train;
end;


// pr�sence train 3 d�tecteurs avant le feu
function PresTrainPrecVieux(AdrFeu : integer) : boolean;
var PresTrain : boolean;
    j,i,Det_initial,Adr_El_Suiv,DetPrec1,DetPrec2,DetPrec3,DetPrec4 : integer;
    Btype_el_suivant : TEquipement;
begin
  If NivDebug=3 then AfficheDebug('Proc PresTrainPrec('+intToSTR(AdrFeu)+') ---------------',clOrange);
  i:=index_feu(Adrfeu);
  if i=0 then
  begin
    Affiche('Erreur 604 - feu '+IntToSTR(adrFeu)+' non trouv�',clred);
    if NivDebug=3 then AfficheDebug('Erreur 604 - feu '+IntToSTR(adrFeu)+' non trouv�',clred);
    PresTrainPrecVieux:=false;
    exit;
  end;
  
  // **** un feu peut �tre associ� � 4 d�tecteurs (pour 4 voies convergentes) *****
  // il faut donc explorer les 4 d�tecteurs probables
  PresTrain:=FALSE;
  j:=1;
 
  repeat
    if NivDebug=3 then afficheDebug('S�quence '+IntToSTR(j)+' de recherche des 4 d�tecteurs pr�c�dents-----',clYellow);
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
      DetPrec1:=detecteur_suivant(Adr_El_Suiv,Btype_el_suivant,det_initial,det,2); // 2= algo2 = arret sur aiguillage en talon mal positionn�
      if nivdebug=3 then afficheDebug('detPrec1='+intToSTR(DetPrec1),clYellow);
      if DetPrec1<1024 then // route bloqu�e par aiguillage mal positionn�
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
              if AffSignal or (NivDebug>=2) then AfficheDebug('Les d�tecteurs pr�c�dents au feu '+IntToSTR(Adrfeu)+' sont:'+intToSTR(Det_initial)+' '+intToSTR(DetPrec1)+' '+intToSTR(DetPrec2)+' '+intToSTR(DetPrec3)+' '+intToSTR(DetPrec4),clyellow);
              PresTrain:=MemZone[DetPrec4,detPrec3] or
              MemZone[DetPrec3,detPrec2] or MemZone[DetPrec2,detPrec1] or MemZone[DetPrec1,Det_initial] or presTrain ;
              if AffSignal or (NivDebug=3) then
              begin
                if MemZone[DetPrec4,detPrec3] then AfficheDebug('0.pr�sence train '+IntToSTR(DetPrec4)+' '+IntToSTR(detPrec3),clyellow);
                if MemZone[DetPrec3,detPrec2] then AfficheDebug('1.pr�sence train '+IntToSTR(DetPrec3)+' '+IntToSTR(detPrec2),clyellow);
                if MemZone[DetPrec2,detPrec1] then AfficheDebug('2.pr�sence train '+IntToSTR(DetPrec2)+' '+IntToSTR(detPrec1),clyellow);
                if MemZone[DetPrec1,det_initial] then AfficheDebug('3.pr�sence train '+IntToSTR(DetPrec1)+' '+IntToSTR(det_Initial),clyellow);
                if PresTrain then AfficheDebug('pr�sence train',clyellow) else afficheDebug('abscence train',clyellow);
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
    if presTrain Then afficheDebug('pr�sence train feu '+intToSTR(AdrFeu),clorange)
    else AfficheDebug('Absence train feu '+intToSTR(AdrFeu),clorange);
  end;
  PresTrainPrecVieux:=presTrain;
end;


// mise � jour de l'�tat d'un feu en fontion de son environnement et affiche le feu
procedure Maj_Feu(Adrfeu : integer);
var Adr_det,etat,Aig,Adr_El_Suiv,modele,index,IndexAig : integer ;
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

    Adr_det:=Feux[index].Adr_det1;  // d�tecteur sur le signal
    Adr_El_Suiv:=Feux[index].Adr_el_suiv1; // adresse �l�ment suivant au feu
    Btype_el_suivant:=Feux[index].Btype_suiv1;
                       
    // signal directionnel ?
    if (modele>10) then
    begin
      //Affiche('Signal directionnel '+IntToSTR(AdrFeu),clyellow);
      Signal_direction(AdrFeu);
      exit;
    end;

    // signal non directionnel       
    etat:=etat_signal_suivant(AdrFeu,1) ;  // �tat du signal suivant + adresse du signal suivant dans Signal_Suivant
    if AffSignal then
    begin
      code_to_aspect(etat,code,combine);
      s:='Etat_signal_suivant ('+intToSTR(AdresseFeuSuivant)+') est ';
      s:=s+' � '+etatSign[code];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      AfficheDebug(s,clyellow);
    end;
    // signaux trait�s sp�cifiquement
    {
    if (AdrFeu=201) then
    begin
      if ((aiguillage[index_aig(28].position<>const_droit) and (aiguillage[index_aig(29].position<>const_droit) and
         (aiguillage[index_aig(31].position=2)) then // attention sp�cial
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

    // signal � 2 feux = carr� violet+blanc
    if (Feux[index].aspect=2) then //or (feux[i].check<>nil) then // si carr� violet
    begin
      //AfficheDebug('Feux � 2 feux',CLOrange);
      // si aiguillage apr�s signal mal positionn�es
      if carre_signal(AdrFeu) then
      begin
        Maj_Etat_Signal(AdrFeu,violet);
        Envoi_signauxCplx;
        exit;
      end
      else
      begin
        if test_memoire_zones(AdrFeu) then Maj_Etat_Signal(AdrFeu,violet)  // test si pr�sence train apr�s signal
        else Maj_Etat_Signal(AdrFeu,blanc);
        
        Envoi_signauxCplx;
        exit;
      end;
    end;

    //if AffSignal then AfficheDebug('Debut du traitement g�n�ral',clYellow);
    // traitement des feux >3 feux diff�rents de violet (cas g�n�ral)
    if (Feux[index].aspect>=3) and (EtatSignalCplx[AdrFeu]<>violet_F) then
    begin
      PresTrain:=false;
      // d�tecteurs pr�c�dent le feu , pour d�terminer si leurs m�moires de zones sont � 1 pour lib�rer le carr�
      if (Feux[index].VerrouCarre) and (Feux[index].aspect>=4) then presTrain:=PresTrainPrec(AdrFeu);

      if AffSignal then afficheDebug('Fin de la recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
      // si le signal peut afficher un carr� et les aiguillages apr�s le signal sont mal positionn�es ou que pas pr�sence train avant signal et signal
      // verrouillable au carr�, afficher un carr�
      car:=carre_signal(AdrFeu);
      // conditions suppl�mentaires de carr� en fonction des aiguillages d�crits
      car:=cond_carre(AdrFeu) or car;
      if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (NivDebug>=1) and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (Feux[index].aspect>=4) and ( (not(PresTrain) and Feux[index].VerrouCarre) or car) then Maj_Etat_Signal(AdrFeu,carre)
      else
      begin
        // si on quitte le d�tecteur on affiche un s�maphore :  attention tester le sens de circulation
        // pour ne pas passer au rouge un feu � contresens.
        // trouver la m�moire de zone MemZone[Adr_det,?] qui a d�clench� le feu rouge
        //if adrFeu=1002 then NivDebug:=3;
        if AffSignal then AfficheDebug('test du s�maphore',clYellow);
        Aff_semaphore:=test_memoire_zones(AdrFeu);  // test si pr�sence train apr�s signal
        //Nivdebug:=0;
        if Aff_Semaphore then
        begin
          if AffSignal then AfficheDebug('Pr�sence train apr�s signal'+intToSTR(AdrFeu)+' -> s�maphore ou carr�',clYellow);
          if testBit(EtatSignalCplx[Adrfeu],carre)=FALSE then Maj_Etat_Signal(AdrFeu,semaphore);
        end
        else
        begin
          Aig:=Aiguille_deviee(Adrfeu);
          // si aiguille locale d�vi�e
          if (aig<>0) and (feux[index].aspect>=9) then // si le signal peut afficher un rappel et aiguille d�vi�e
          begin
            indexAig:=Index_aig(aig);
            if AffSignal then AfficheDebug('Aiguille '+intToSTR(aig)+' du signal '+intToSTR(AdrFeu)+' d�vi�e',clYellow);
            EtatSignalCplx[AdrFeu]:=0;
            if (aiguillage[indexAig].vitesse=30) or (aiguillage[indexAig].vitesse=0) then Maj_Etat_Signal(AdrFeu,rappel_30);
            if aiguillage[indexAig].vitesse=60 then Maj_Etat_Signal(AdrFeu,rappel_60);

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
          // aiguille locale non d�vi�e ou aspect feu<9
          // si le signal suivant est rouge
          begin
            if AffSignal then AfficheDebug('pas d''aiguille d�vi�e',clYellow);
            // effacer la signbalisation combin�e
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
                  Maj_Etat_Signal(AdrFeu,ral_60);  // si signal suivant est au rappel60, il faut tester s'il est � l'avertissement aussi
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
  //Affiche('Proc�dure rafraichit',cyan);
  begin
    Maj_feux;
  end
end;

// trouve l'index d'un d�tecteur dans une branche depuis la fin de la branche
// si pas trouv�, renvoie 0
function index_detecteur_fin(detecteur,Num_branche : integer) : integer;
var dernier,i,j : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        if BrancheN[Num_Branche,i].Btype=det then   // cherche un d�tecteur
        begin
          j:=BrancheN[Num_Branche,i].adresse;
          trouve:=detecteur=j;
        end;
        if not(trouve) then dec(i);
      until trouve or (j=0)
    end;
begin
  // d�terminer la fin de la branche
  i:=1;
  repeat
     inc(i);
  until (BrancheN[Num_Branche,i].adresse=0) and (BrancheN[Num_Branche,i].btype=rien);
  dernier:=i-1;
  // Affiche('dernier'+intToSTR(dernier),clwhite);
  // rechercher le d�tecteur depuis l'index i
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

// trouve si le d�tecteur adr est contigu � un buttoir
function buttoir_adjacent(adr : integer) : boolean;
begin
  trouve_element(adr,det,1); // branche_trouve  IndexBranche_trouve
  if Branche_trouve=0 then begin buttoir_adjacent:=false;exit;end;
  buttoir_adjacent:=( (BrancheN[branche_trouve,IndexBranche_trouve+1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve+1].BType=buttoir) or
                      (BrancheN[branche_trouve,IndexBranche_trouve-1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve-1].BType=buttoir) )
end;

// calcul des zones depuis le tableau des fronts descendants des �v�nements d�tecteurs
// transmis dans le tableau Event_det
procedure calcul_zones;
var AdrFeu,AdrDetFeu,Nbre,i,resultat,det1,det2,det3,AdrSuiv,AdrPrec : integer ;
    creer_tableau : boolean;
    TypeSuiv : tEquipement;
    s : string;
begin
  creer_tableau:=false;
  det3:=event_det[N_event_det]; // c'est le nouveau d�tecteur
  if det3=0 then exit; // pas de nouveau d�tecteur
  FormDebug.MemoEvtDet.lines.add('Le nouveau d�tecteur est '+IntToSTR(det3)) ;
  if TraceListe then AfficheDebug('Le nouveau d�tecteur est '+IntToSTR(det3),clyellow) ;

  // �valuer d'abord la route du nouveau d�tecteur sur tous les tableau d�ja rempli de 2 �l�ments
  for i:=1 to N_trains do
  begin
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'�l�ments du tableau courant explor�
    if Nbre=2 then
    begin
      if TraceListe or (NivDebug=3) then AfficheDebug('traitement Train n�'+intToSTR(i)+' 2 d�tecteurs',clyellow);
      det1:=event_det_train[i].det[1];
      det2:=event_det_train[i].det[2];
      resultat:=test_route_valide(det1,det2,det3);
      if resultat=10 then
      begin
        AdrSuiv:=detecteur_suivant_el(det2,det,det3,det,1); // ici on cherche le suivant � det2 det3, algo=1
        if (Adrsuiv>=9996) then
        begin
          Affiche('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' � '+intToSTR(det3),clRed);
          if NivDebug=3 then AfficheDebug('Erreur 1500 : pas de suivant sur la route de '+intToSTR(det2)+' � '+intToSTR(det3),clRed);
        end
        else
        begin
          s:='route trait�e de '+intToSTR(det2)+' � '+IntToSTR(det3)+' Mem '+intToSTR(det3)+' � '+IntToSTR(Adrsuiv);
          FormDebug.MemoEvtDet.lines.add(s);
          if traceListe then AfficheDebug(s,clyellow);
          With FormDebug.RichEdit do
          begin
            s:='train '+IntToSTR(i)+' '+intToStr(det2)+' � '+intToStr(det3)+' => Mem '+IntToSTR(det3)+' � '+IntTOStr(AdrSuiv);
            Lines.Add(s);
            RE_ColorLine(FormDebug.RichEdit,lines.count-1,CouleurTrain[ ((i - 1) mod NbCouleurTrain) +1] );
          end;
          if TraceListe then AfficheDebug(s,clyellow);
          Affiche(s,clyellow);
          if AffAigDet then AfficheDebug(s,clyellow);

          if (det2<NbMemZone) and (det3<NbMemZone) and (AdrSuiv<NbMemZone) then
          begin
            MemZone[det2,det3]:=FALSE;        // efface zone pr�c�dente
            MemZone[det3,AdrSuiv]:=TRUE;      // valide la nouvelle zone
            event_act(det2,det3,0,'');        // d�sactivation zone
            event_act(det3,AdrSuiv,1,'');     // activation zone
          end
          else Affiche('Erreur 740 : Adresse d�tecteur trop �lev�',clred);

          // supprimer le 1er et d�caler
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
            zone_TCO(det2,det3,0);    // d�sactivation
            zone_TCO(det3,AdrSuiv,1); // activation
          end;
          exit; // sortir absolument
        end;
      end;
    end;
  end;

  // traiter pour les cas avec 1 �l�ment
  for i:=1 to N_trains do
  begin
    Nbre:=event_det_train[i].NbEl ;  // Nombre d'�l�ments du tableau courant explor�
    if Nbre=1 then
    begin
      if traceListe then AfficheDebug('traitement Train n�'+intToSTR(i)+' 1 d�tecteur',clyellow);
      // v�rifier si l'�l�ment du tableau et le nouveau sont contigus
      det1:=event_det_train[i].det[1];
      Det_Adj(det1);  // renvoie les adresses des d�tecteurs adjacents au d�tecteur "det1" r�sultat dans adj1 et adj2
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

  // Nombre d'�l�ments � 0 : ici c'est un nouveau train donc cr�er un train, donc un tableau
  if N_Trains>=Max_Trains then
  begin
    Affiche('Erreur nombre de train maximal atteint',clRed);
    N_trains:=0;
  end;
  Inc(N_trains);

  // v�rifier si le d�tecteur du nouveau train est associ� � un feu vers un buttoir
  for i:=1 to NbreFeux do
  begin
    AdrFeu:=Feux[i].Adresse;
    AdrDetfeu:=Feux[i].Adr_Det1;
    if (AdrDetFeu=Det3) and (feux[i].aspect<10) then
    begin
      AdrSuiv:=Feux[i].Adr_el_suiv1;
      TypeSuiv:=Feux[i].Btype_suiv1;
      AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetFeu,det,1) ; // d�tecteur pr�c�dent le feu ; algo 1
      if AdrPrec=0 then
      begin
        if TraceListe then Affiche('FD - Le feu '+IntToSTR(AdrFeu)+' est pr�c�d� d''un buttoir',clyellow);
        if AdrDetFeu<NbMemZone then
          MemZone[0,AdrDetFeu]:=false
        else
          Affiche('Erreur 741: Adresse d�tecteur feu trop �lev�: '+intToSTR(AdrDetFeu),clred);
         //NivDebug:=3;
         //AffSignal:=true;
         maj_feu(AdrFeu);
      end;
    end;
  end;

  if TraceListe then AfficheDebug('Cr�ation Train n�'+intToSTR(N_trains),clyellow);
  Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);

  // si on d�marre d'un buttoir
  if buttoir_adjacent(det3) then
  begin
    if TraceListe then AfficheDebug('detection d�marrage depuis d�tecteur '+IntToSTR(det3)+' buttoir',clyellow);
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

// demande l'�tat d'un accessoire � la centrale. Le r�sultat sera r�ceptionn� sur �v�nement des informations
// de r�trosignalisation.
procedure demande_info_acc(adresse : integer);
var s : string;
    n : integer;
begin
  // uniquement si connect� directement � la centrale
  if portCommOuvert or parSocketLenz then
  begin
    // envoyer 2 fois la commande, une fois avec N=0 pour r�cup�rer le nibble bas,
    // une autre fois avec N=1 pour r�cup�rer le nibble haut
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

// demande l'�tat de tous les accessoires par l'interface
procedure demande_etat_acc;
var i : integer;
begin
  if portCommOuvert or parSocketLenz then
  begin
    Affiche('Demande �tat des aiguillages',ClYellow);
    for i:=1 to maxaiguillage do
    begin
      demande_info_acc(i);
      Affiche('Demande �tat aiguillage '+intToSTR(i),clLime);
    end;
  end;  
end;


// traitement des �v�nements actionneurs
procedure Event_act(adr,adr2,etat : integer;trainDecl : string);
var i,v,va,etatAct,Af,Ao,Access,sortie : integer;
    s,st,trainDest : string;
    presTrain_PN,adresseOk : boolean;
    Ts : TAccessoire;
begin
  // v�rifier si l'actionneur en �v�nement a �t� d�clar� pour r�agir
  if AffActionneur then AfficheDebug('Act/Det '+intToSTR(Adr)+'='+intToSTR(etat),clyellow);
  //Affiche(intToSTR(adr)+'/'+intToSTR(adr2)+' '+intToSTR(etat),clyellow);
  for i:=1 to maxTablo_act do
  begin
    
    s:=Tablo_actionneur[i].trainDecl;  
    etatAct:=Tablo_actionneur[i].etat ;

    adresseok:=(Tablo_actionneur[i].adresse=adr) ;
    
    if Tablo_actionneur[i].det then 
    begin
      st:='D�tecteur '+intToSTR(adr);
      if Tablo_actionneur[i].typActMemZone=1 then
      begin
        adresseok:=adresseOk and (Tablo_actionneur[i].adresse2=adr2);
        st:='M�moire de zone '+intToSTR(adr)+' '+intToStr(adr2);
      end; 
    end
    else 
    begin
      st:='Actionneur '+intToSTR(adr);
    end; 
    
    // actionneur pour fonction train
    if adresseOk and (Tablo_actionneur[i].loco) and ((s=trainDecl) or (s='X') or (trainDecl='X')) and (etatAct=etat) then
    begin
      trainDest:=Tablo_actionneur[i].trainDest;
      Affiche(st+' TrainDecl='+trainDecl+' TrainDest='+trainDest+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':'+intToSTR(etat),clyellow);
      // ex�cution de la fonction F vers CDM
      envoie_fonction_CDM(Tablo_actionneur[i].fonction,etat,trainDest);
      tablo_actionneur[i].TempoCourante:=tablo_actionneur[i].Tempo div 100;
    end;

    // actionneur pour accessoire
    if adresseOk and (Tablo_actionneur[i].act) and ((s=trainDecl) or (s='X') or (trainDecl='X')) and (etatAct=etat) then
    begin
      access:=Tablo_actionneur[i].accessoire;
      sortie:=Tablo_actionneur[i].sortie;

      Affiche(st+' Train='+trainDecl+' Accessoire '+IntToSTR(access)+':'+intToSTR(sortie),clyellow);
      // ex�cution la fonction accessoire vers CDM
      if Tablo_actionneur[i].RAZ then Ts:=aigP else Ts:=Feu;
      pilote_acc(access,sortie,Ts); // sans RAZ
    end;

    // actionneur pour son
    if adresseOk and (Tablo_actionneur[i].Son) and ((s=trainDecl) or (s='X') or (trainDecl='X')) and (etatAct=etat)
    then
    begin
      Affiche(st+' Train='+trainDecl+' son '+Tablo_actionneur[i].FichierSon,clyellow);
      PlaySound(pchar(Tablo_actionneur[i].FichierSon),0,SND_ASYNC);
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
        // v�rifier les pr�sences train sur les autres voies du PN
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
  s:='M�moire �v�nements '+IntToSTR(100*N_Event_tick div Max_Event_det_tick)+' %';
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

// traitement sur les �v�nements d�tecteurs
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);
var i,AdrSuiv,AdrFeu,AdrDetfeu,index,Etat01,AdrPrec : integer;
    typeSuiv : tequipement;
    s : string;
begin
  if Etat then Etat01:=1 else Etat01:=0;
  if train='' then train:='X';
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
  if Traceliste then AfficheDebug('--------------------- d�tecteur '+intToSTR(Adresse)+' � '+intToSTR(etat01)+'-----------------------------',clOrange);
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

  // stocke les changements d'�tat des d�tecteurs dans le tableau chronologique
  if (N_Event_tick>=Max_Event_det_tick) then
  begin
    N_Event_tick:=0;
    Affiche('Raz Evts d�tecteurs',clLime);
  end;
  
  inc(N_Event_tick);
  event_det_tick[N_event_tick].tick:=tick;
  event_det_tick[N_event_tick].detecteur:=Adresse;
  event_det_tick[N_event_tick].etat:=etat01;
  if (n_Event_tick mod 10) =0 then affiche_memoire;
  // Affiche('stockage de '+intToSTR(N_event_tick)+' '+IntToSTR(Adresse)+' � '+intToSTR(etat01),clyellow);

  // d�tection front montant
  if not(ancien_detecteur[Adresse]) and detecteur[Adresse].etat then
  begin
    // explorer les feux pour d�verrouiller les feux dont le trajets viennent d'un buttoir pour changer le feu qd un train se pr�sente
    // sur le d�tecteur
    if not(confignulle) then
    for i:=1 to NbreFeux do
    begin
      AdrFeu:=Feux[i].Adresse;
      AdrDetfeu:=Feux[i].Adr_Det1;
      if (AdrDetFeu=Adresse) and (feux[i].aspect<10) then
      begin
        AdrSuiv:=Feux[i].Adr_el_suiv1;
        TypeSuiv:=Feux[i].Btype_suiv1;
        if AffSignal then AfficheDebug('Pour Feu '+intToSTR(AdrFeu)+' detecteursuivant('+intToSTR(AdrSuiv)+','+IntToSTR(BTypeToNum(typeSuiv))+','+intToSTR(AdrDetFeu)+',1)',clyellow);
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetFeu,det,1) ; // d�tecteur pr�c�dent le feu, algo 1
        if AdrPrec=0 then
        begin
          If traceListe then AfficheDebug('Le feu '+IntToSTR(AdrFeu)+' est pr�c�d� d''un buttoir',clyellow);
          MemZone[0,AdrDetFeu]:=true;                      
          event_act(0,AdrDetFeu,1,'');             // activation zone
          maj_feu(AdrFeu);
        end;
      end;
    end;

    // g�rer l'�v�nement detecteur pour action
    if etat then i:=1 else i:=0;
    event_act(Adresse,0,i,train);
  end;

  // d�tection fronts descendants
  if ancien_detecteur[Adresse] and not(detecteur[Adresse].etat) and (N_Event_det<Max_event_det) then
  begin
    // si le FD du d�tecteur a d�j� �t� stock� � l'index pr�c�dent ne pas en tenir compte
    //if event_det[N_event_det]<>Adresse then
    begin
      if AffFD then AfficheDebug('Tick='+intToSTR(tick)+' Index='+intToSTR(N_event_tick)+' FD '+intToSTR(Adresse),clyellow);
      inc(N_event_det);
      event_det[N_event_det]:=Adresse;
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
              Affiche('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',clred);
              AfficheDebug('Attention : position de l''aiguillage '+IntToSTR(i)+' inconnue',clred);
            end;
          end;
        end;
      end;
      premierFD:=True;

      // g�rer l'�v�nement detecteur pour action
      if etat then i:=1 else i:=0;
      event_act(Adresse,0,i,train);
      if not(confignulle) then calcul_zones;
    end;
  end;

  if (N_event_det>=Max_event_det) then
  begin
    Affiche('D�bordement d''�v�nements FD - Raz tampon',clred);
    N_event_det:=0;
    FormDebug.MemoEvtDet.lines.add('Raz sur d�bordement');
  end;
  
  // attention � partir de cette section le code est susceptible de ne pas �tre ex�cut�??

  // Mettre � jour le TCO
  if AvecTCO then
  begin
    formTCO.Maj_TCO(Adresse);
  end;
end;

// note: si on pilote un aiguillage par signaux complexes vers CDM et que celui ci est invers�,
// on recoit un evt de CDM de l'aiguillage dans le mauvais sens.
// par contre si on pilote cet aiguillage dans CDM, on le recoit dans le bon sens.
// �v�nement d'aiguillage (accessoire)
// pos = const_droit=2 ou const_devie=1
procedure Event_Aig(adresse,pos : integer);
var s: string;
    faire_event,inv : boolean;
    prov,index : integer;
begin
  // v�rifier que l'�v�nement accessoire vient bien d'un aiguillage et pas d'un feu qu'on pilote (et que cdm renvoie)
  index:=index_aig(adresse);
  if index=0 then exit; // non ce n'est pas un aiguillage ou alors aiguillage non d�clar�, on sort

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
  event_det_tick[N_event_tick].aiguillage:=adresse;
  event_det_tick[N_event_tick].etat:=pos;

  // Mettre � jour le TCO
  if AvecTCO then formTCO.Maj_TCO(Adresse);

  // l'�valuation des routes est � faire selon conditions
  if faire_event and not(confignulle) then evalue;
end;

// pilote une sortie � 0  dont l'adresse est � octet
procedure Pilote_acc0_X(adresse : integer;octet : byte);
var groupe : integer ;
    fonction : byte;
    s : string;
begin
  if debug_dec_sig then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet),clorange);
  groupe:=(adresse-1) div 4;
  fonction:=((adresse-1) mod 4)*2 + (octet-1);
  s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
end;

// pilotage d'un accessoire (d�codeur d'aiguillage, de signal)
// octet = 1 (d�vi�) ou 2 (droit)
// la sortie "octet" est mise � 1 puis � 0
// acc = aig ou feu
procedure pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire);
var  groupe,temps,index : integer ;
     fonction,pilotage : byte;
     s : string;
label mise0;
begin
  //Affiche(IntToSTR(adresse)+' '+intToSTr(octet),clYellow);

  pilotage:=octet;
  // test si pilotage aiguillage invers�
  if (acc=aigP) then
  begin
    index:=index_aig(adresse);
    if (aiguillage[index].inversionCDM=1) then
    begin
      if octet=1 then pilotage:=2 else pilotage:=1;
    end;
  end;

  // pilotage par CDM rail -----------------
  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(pilotage),clorange);
    s:=chaine_CDM_Acc(adresse,pilotage);
    envoi_CDM(s); 
    if (acc=feu) and not(Raz_Acc_signaux) then exit;
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
    sleep(50);
    s:=chaine_CDM_Acc(adresse,0);
    envoi_CDM(s);   
    event_aig(adresse,pilotage);
    exit;
  end;

  // pilotage par USB ou par �thernet de la centrale ------------
  if (hors_tension2=false) and (portCommOuvert or parSocketLenz) then
  begin
    if (pilotage=0) or (pilotage>2) then exit;

    groupe:=(adresse-1) div 4;
    fonction:=((adresse-1) mod 4)*2 + (pilotage-1);
    // pilotage � 1
    s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
    s:=checksum(s);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(pilotage),clorange);
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
    // pilotage � 0 pour �teindre le pilotage de la bobine du relais
    s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
    s:=checksum(s);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' 0',clorange);
    envoi(s);     // envoi de la trame et attente Ack
    exit;
  end;

  // pas de centrale et pas CDM connect�: on change la position de l'aiguillage
  if acc=aigP then event_aig(adresse,octet);
end;


// le d�codage de la r�tro est appel� sur une r�ception d'une trame de la r�trosignalisation de la centrale.
// On d�clenche ensuite les �v�nements d�tecteurs ou aiguillages.
procedure decode_retro(adresse,valeur : integer);
var  s : string;
     adraig,bitsITT,i : integer;
begin
  //affiche(IntToSTR(adresse)+intToSTR(valeur),clorange);
  bitsITT:=(valeur and $E0);
  // bit � 010X XXXX = c'est un module de r�trosignalisation (pas un aiguillage)
  // doc LENZ Xpressnet protocol description page 31
  detecteur_chgt:=0;
  if (valeur and $10)=$10 then // si bit N=1, les 4 bits de poids faible sont les 4 bits de poids fort du d�codeur
  begin
    // d�termine le d�tecteur qui a chang� d'�tat
    // -------�tat du d�tecteur
    if bitsITT=$40 then // module de r�tro = d�tecteur
    begin
      // affecter l'�tat des d�tecteurs
      i:=adresse*8+8;
      if detecteur[i].etat<>((valeur and $8) = $8) then  // si changement de l'�tat du d�tecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8,'');  // pas de train affect� sur le d�codage de la r�trosignalisation
      end;

      i:=adresse*8+7;
      if detecteur[i].etat<>((valeur and $4) = $4) then  // si changement de l'�tat du d�tecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,'');
      end;

      i:=adresse*8+6;
      if detecteur[i].etat<>((valeur and $2) = $2) then  // si changement de l'�tat du d�tecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,'');
      end;

      i:=adresse*8+5;
      if detecteur[i].etat<>((valeur and $1) = $1) then  // si changement de l'�tat du d�tecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1,''); 
      end;
    end;

    // �tat de l'aiguillage
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

  if (valeur and $10)=$00 then // si bit N=0, les 4 bits de poids faible sont les 4 bits de poids faible du d�codeur
  begin
    //Affiche('N=0',clYellow);
    if bitsITT=$40 then // module de r�tro
    begin
      // affecter l'�tat des d�tecteurs
      i:=adresse*8+4;
      if detecteur[i].etat<>((valeur and $8) = $8) then  // si changement de l'�tat du d�tecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8,''); 
      end;
      i:=adresse*8+3;
      if detecteur[i].etat<>((valeur and $4) = $4) then  // si changement de l'�tat du d�tecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4,''); 
      end;

      i:=adresse*8+2;
      if detecteur[i].etat<>((valeur and $2) = $2) then  // si changement de l'�tat du d�tecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2,''); 
      end;

      i:=adresse*8+1;
      if detecteur[i].etat<>((valeur and $1) = $1) then  // si changement de l'�tat du d�tecteur bit 4
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


// d�codage d'une chaine simple de la r�trosignalisation de la centrale
function decode_chaine_retro(chaineINT : string) : string ;
var msg : string;
    i,cvLoc : integer;
begin
  //affiche(chaine_hex(chaine),clyellow);
  msg:='';
  ack:=true;nack:=false;
  // d�codage du 3eme octet de la cha�ne
  if chaineINT[1]=#1 then
  begin
    case chaineINT[2] of   // page 13 doc XpressNet
    #1 :  begin nack:=true;msg:='erreur timout transmission';end;
    #2 :  begin nack:=true;msg:='erreur timout centrale';end;
    #3 :  begin nack:=true;msg:='erreur communication inconnue';end;
    #4 :  begin succes:=true;msg:='succ�s';end;
    #5 :  begin nack:=true;msg:='plus de time slot';end;
    #6 :  begin nack:=true;msg:='d�bordement tampon LI100';end;
    end;
    if traceTrames and (chaineINT[2]=#4) then AfficheDebug(msg,clYellow);
    if traceTrames and (chaineINT[2]<>#4) then AfficheDebug(msg,clRed);
    delete(chaineINT,1,3);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if chaineINT[1]=#2 then
  begin
    msg:='Version mat�rielle '+intTohex(ord(chaineINT[2]),2)+' - Version soft '+intToHex(ord(chaineINT[3]),2);
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
    #$81 : begin nack:=true;msg:='Station occup�e - Voir doc XpressNet p29';end;
    #$82 : begin nack:=true;msg:='Commande non implant�e';end;
    else begin nack:=true;msg:='R�ception inconnue';end;
    end;
    if nack then affiche(msg,clred) else affiche(msg,clyellow);
    delete(chaineINT,1,2);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  if ((chaineINT[1]=#$63) and (chaineINT[2]=#$14)) then    // V3.6 uniquement
  begin
    // r�ception d'un CV. DocXpressNet p26   63 14 01 03 chk

    delete(chaineInt,1,2);
    cvLoc:=ord(chaineINT[1]);
    //Affiche('R�ception CV'+IntToSTR(cvLoc)+' � '+IntToSTR(ord(chaineINT[2])),clyellow);
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
    //FF FD 46 43 40 41 40 40 49 4D non document�e   
    //FF FD 46 43 50 41 50 40 50 54 non document�e
    //      46 43 40 41 40 40 48 4C
    //      46 43 50 41 54 40 50 50

    Affiche('reprise puissance ',clLime);
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

  if chaineInt[1]=#$E4 then
  begin
    AdrTrain:=ord(chaineInt[2]); // identification
    i:=ord(chaineInt[3]); // vitesse
    Fa:=ord(chaineInt[4]); // fonction A
    Fb:=ord(chaineInt[5]); // fonction B
    delete(chaineInt,1,6);
    decode_chaine_retro:=chaineINT;
    exit;
  end;

  ack:=false;
  nack:=true;
  affiche('Erreur 7, cha�ne r�trosig. inconnue recue:'+chaine_HEX(chaineINT),clred);
  decode_chaine_retro:='';
end;

// proc�dure appell�e apr�s r�ception sur le port USB ou socket
procedure interprete_reponse(chaine : string);
var chaineInt: string;
begin
  chaineINT:=chaine;
  while length(chaineINT)>=3 do
  begin
    if length(chaineINT)>4 then
    begin
      // supprimer l'entete �ventuelle
      if (chaineINT[1]=#$ff) and (chaineINT[2]=#$fe) then Delete(chaineINT,1,2);
      if (chaineINT[1]=#$ff) and (chaineINT[2]=#$fd) then Delete(chaineINT,1,2);
    end;
    chaineINT:=decode_chaine_retro(chaineINT);
  end;
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
      comboTrains.clear;
      ntrains:=0;
    end;
    Affiche('CDM rail d�connect�',Cyan);
    AfficheDebug('CDM rail d�connect�',Cyan);

  end;
end;

{$J+}
// v�rifie si version OS32 bits ou OS64 bits
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
    With Formprinc.MSCommUSBLenz do   // MSComm est le composant OCX TMSComm32
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
      LabelTitre.caption:=titre+' Interface connect�e au COM'+IntToSTR(NumPort);
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
      //Affiche('CDM rail processID='+IntToSTR(ProcessID)+' handle='+IntToSTR(CDMhd),clOrange);
      Result:=true;
      Break;
    end;
  until (Process32Next(hSnapShot,ProcessEntry32)=false);
  CloseHandle(hSnapShot);
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

// envoie des touches pour simuler un appui clavier
procedure SendKey(Wnd,VK : Cardinal; Ctrl,Alt,Shift : Boolean);
var MC,MA,MS : Boolean;
begin
  // Etats des touches sp�ciales 
  MC:=Hi(GetAsyncKeyState(VK_CONTROL))>127;
  MA:=Hi(GetAsyncKeyState(VK_MENU))>127;
  MS:=Hi(GetAsyncKeyState(VK_SHIFT))>127;

  // Simulation des touches de contr�le 
  if Ctrl<>MC then keybd_event(VK_CONTROL,0,Byte(MC)*KEYEVENTF_KEYUP,0);
  if Alt<>MA then keybd_event(VK_MENU,0,Byte(MA)*KEYEVENTF_KEYUP,0);
  if Shift<>MS then keybd_event(VK_SHIFT,0,Byte(MS)*KEYEVENTF_KEYUP,0);

  // Appui sur les touches
  keybd_event(VK,0,0,0);  
  keybd_event(VK,0,KEYEVENTF_KEYUP,0);

//  keybd_event(MapVirtualKeyA(VK,0),0,0,0);
//  keybd_event(MapVirtualKeyA(VK,0),0,KEYEVENTF_KEYUP,0);

  // Rel�chement des touches si n�cessaire
  if Ctrl<>MC then keybd_event(VK_CONTROL,0,Byte(Ctrl)*KEYEVENTF_KEYUP,0);
  if Alt<>MA then keybd_event(VK_MENU,0,Byte(Alt)*KEYEVENTF_KEYUP,0);
  if Shift<>MS then keybd_event(VK_SHIFT,0,Byte(Shift)*KEYEVENTF_KEYUP,0);
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

// Lance et connecte CDM rail. en sortie si CDM est lanc� Lance_CDM=true, 
function Lance_CDM : boolean;
var i : integer;
    s : string;
    cdm_lanceLoc : boolean;
begin
  s:='CDR';
  if (ProcessRunning(s)) then 
  begin 
    // CDM d�ja lanc�;
    Affiche('CDM d�j� lanc�',clOrange);
    Lance_CDM:=true;
    if CDM_connecte then exit;
    deconnecte_USB;
    connecte_CDM;
    exit;
  end;

  cdm_lanceLoc:=false;
  // lancement depuis le r�pertoire 32 bits d'un OS64
  if ShellExecute(Formprinc.Handle,'open',PChar('C:\Program Files (x86)\CDM-Rail\cdr.exe'),
                    Pchar('-f '+lay),  // param�tre
                    PChar('C:\Program Files (x86)\CDM-Rail\')  // r�pertoire
                    ,SW_SHOWNORMAL)>32 then
                    begin
                      cdm_lanceLoc:=true;
                      Affiche('Lancement de CDM 64 '+lay,clyellow);
                    end;

  if not(cdm_lanceLoc) then
  begin
    // si �� marche pas essayer depuis le r�pertoire de base sur un OS32
    if ShellExecute(Formprinc.Handle,
                    'open',PChar('C:\Program Files\CDM-Rail\cdr.exe'),
                    Pchar('-f '+lay),  // param�tre
                    PChar('C:\Program Files\CDM-Rail\')  // r�pertoire
                    ,SW_SHOWNORMAL)<=32 then
    begin
      ShowMessage('r�pertoire CDM rail introuvable');
      lance_CDM:=false;exit;
    end;
    cdm_lanceLoc:=true;
    Affiche('Lancement de CDM 32 '+lay,clyellow);
  end;

  if cdm_lanceLoc then
  begin
    Formprinc.caption:=af+' - '+lay;
    // On a lanc� CDM, d�connecter l'USB
    deconnecte_USB;
    Affiche('lance les fonctions automatiques de CDM',clyellow);
    Sleep(3000);
    ProcessRunning(s); // r�cup�rer le handle de CDM
    SetForegroundWindow(CDMhd);
    Application.ProcessMessages;

    // d�marre  le serveur IP ------------------------------------
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

    i:=SendInput(Length(KeyInputs),KeyInputs[0],SizeOf(KeyInputs[0]));SetLength(KeyInputs,0);  // la fenetre serveur d�marr� est affich�e
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

      // descendre le curseur n fois pour s�lectionner le serveur
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

// d�marrage principal du programpe signaux_complexes
procedure TFormPrinc.FormCreate(Sender: TObject);
var i,voie : integer;
    s : string;
begin
  TraceSign:=True;
  PremierFD:=false;
  // services commIP CDM par d�faut
  ntrains:=1;
  Srvc_Aig:=true;
  Srvc_Det:=true;
  Srvc_Act:=true;
  Srvc_PosTrain:=false;
  Srvc_sig:=false;

  config_modifie:=false;
  AF:='Client TCP-IP CDM Rail ou USB - syst�me XpressNet - Version '+Version+sousVersion;
  Caption:=AF;
  Application.onHint:=doHint;

  // version d'OS pour info
  if IsWow64Process then s:='OS 64 Bits' else s:='OS 32 Bits';
  s:=DateToStr(date)+' '+TimeToStr(Time)+' '+s;
  Affiche(s,clLime);
  LabelEtat.Caption:='Initialisations en cours';

  //Menu_interface(devalide);

  // cr��e la fenetre debug
  FormDebug:=TFormDebug.Create(Self);
  FormDebug.Caption:=AF+' debug';
  N_Trains:=0;
  NivDebug:=0;
  debugtrames:=false;
  algo_Unisemaf:=1;

  AvecInit:=true;           //&&&&    avec initialisation des aiguillages ou pas
  Option_demarrage:=false;  // d�marrage des trains apr�s tempo, pas encore au point
  Diffusion:=AvecInit;      // mode diffusion publique

  Application.processMessages;
  // cr��e la fenetre v�rification de version
  FormVersion:=TformVersion.Create(Self);

  ferme:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  recuCDM:='';
  residuCDM:='';
  Nbre_recu_cdm:=0;
  AffMem:=true;
  N_routes:=0;
  N_trains:=0;
  NumTrameCDM:=0;
  Application.HintHidePause:=30000;

  // lecture fichiers de configuration 
  lit_config;
  Application.processMessages;

  // lancer CDM rail et le connecte si on le demande
  if LanceCDM then Lance_CDM;
  ButtonAffTCO.visible:=AvecTCO;
  Loco.Visible:=true;

  // tenter la liaison vers CDM rail
  if not(CDM_connecte) then connecte_CDM;

  // si CDM n'est pas connect�, on ouvre la liaison vers la centrale
  if not(CDM_connecte) then
  begin
    Affiche('CDM absent',clYellow);
    // ouverture par USB
    Affiche('Demande connexion � la centrale par USB protocole XpressNet',clyellow);
    connecte_USB;
    if not(portCommOuvert) then
    begin
      // sinon ouvrir socket vers la centrale
      // Initialisation de la comm socket LENZ
      if AdresseIP<>'0' then
      begin
        Affiche('Demande connexion � la centrale par Ethernet protocole XpressNet',clyellow);
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

  // ajoute les images des feux dynamiquement
  for i:=1 to NbreFeux do
  begin
    cree_image(i);  // et initialisation tableaux signaux
  end;
  Tempo_init:=5;  // d�marre les initialisation des signaux et des aiguillages dans 0,5 s

  // initialisation de la chronologie des �v�nements d�tecteurs
  for i:=0 to Max_Event_det_tick do
  begin
    event_det_tick[i].aiguillage:=-1;
    event_det_tick[i].detecteur:=-1;
    event_det_tick[i].etat:=-1;
    event_det_tick[i].aiguillage:=-1;
    event_det_tick[i].actionneur:=-1;
    event_det_tick[i].traite:=false ; // non trait�
  end;
           
  I_Simule:=0;
  tick:=0;
  N_Event_tick:=0 ; // dernier index
  NombreImages:=0;

  GroupBox2.Left:=633;
  GroupBox2.Top:=64;
  GroupBox2.Visible:=false;
  GroupBox3.Left:=633;
  GroupBox3.Top:=64;
  GroupBox3.visible:=true;

  // TCO
  if avectco then
  begin
    //cr��e la fen�tre TCO non modale
    FormTCO:=TformTCO.Create(nil);
    FormTCO.show;
  end;

  Affiche('Fin des initialisations',clyellow);
  LabelEtat.Caption:=' ';
  Affiche_memoire;
 {
    aiguillage[index_aig(1)].position:=const_devie;
    aiguillage[index_aig(3)].position:=const_devie;
    aiguillage[index_aig(5)].position:=const_droit;
    aiguillage[index_aig(7)].position:=const_droit;
    aiguillage[index_aig(19)].position:=const_devie;
    aiguillage[index_aig(20)].position:=const_droit;
    aiguillage[index_aig(21)].position:=const_droit;
    aiguillage[index_aig(26)].position:=const_droit;
    aiguillage[index_aig(27)].position:=const_droit;
    aiguillage[index_aig(28)].position:=const_devie;
    aiguillage[index_aig(31)].position:=const_devie;
    aiguillage[index_aig(25)].position:=const_droit;
    aiguillage[index_aig(9)].position:=const_droit;

   // index_feu_det(530,voie,i);
   // Affiche(intToSTR(voie)+intToSTr(i),clred);
   //Affiche(IntToSTR(aiguille_deviee(1001)),clyellow);
  
  //cursor:=crHandPoint;
  }
end;


// �v�nement r�ception d'une trame sur le port COM USB (centrale Lenz)
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
    if MessageDlg('Le TCO a �t� modifi�. Voulez vous le sauvegarder ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      sauve_fichier_tco;
  if config_modifie then
    if MessageDlg('La configuration a �t� modifi�e. Voulez vous la sauvegarder ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      sauve_config;
end;


// positionnement des aiguillages au d�marrage : seulement en mode autonome
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
        if pos=const_devie then s:=s+' (d�vi�)' else s:=s+' (droit)';     
        Affiche(s,cyan);
        pilote_acc(i,pos,aigP);
        sleep(Tempo_Aig);
        application.processMessages;
      end;
    end;  
  end;
end;

// timer � 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var aspect,i,a,x,y,Bimage,adresse,TailleX,TailleY,orientation : integer;
   imageFeu : Timage;
   frx,fry : real;
    s : string;
begin
  inc(tick);
  if Tdoubleclic>0 then dec(Tdoubleclic);
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
      demande_etat_acc;   // demande l'�tat des accessoires (position des aiguillages)
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
      a:=EtatsignalCplx[adresse];     // a = �tat binaire du feu
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
          a:=EtatsignalCplx[adresse];     // a = �tat binaire du feu
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
            // r�duction variable en fonction de la taille des cellules
            calcul_reduction(frx,fry,round(TailleX*LargeurCell/ZoomMax),round(tailleY*HauteurCell/ZoomMax),TailleX,TailleY);
            Dessine_feu_mx(PCanvasTCO,tco[x,y].x,tco[x,y].y,frx,fry,adresse,orientation);
          end;
        end;
      end;
    end;

    // fen�tre de pilotage manuel du feu
    if AdrPilote<>0 then
    begin
      a:=EtatsignalCplx[0];
      if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
         TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
         testBit(a,vert_cli) or testbit(a,blanc_cli) then
         Dessine_feu_pilote;  // dessiner le feu en fonction du bit "clignotant"
    end;
  end;

  //if (not(Maj_feux_cours) and (Tempo_chgt_feux=1)) then Maj_feux(); // mise � jour des feux sur chgt aiguillage
  //if (not(Maj_feux_cours) and (Tempo_chgt_feux>0)) then dec(Tempo_chgt_feux);

  // tempo retomb�e actionneur
  for i:=1 to maxTablo_act do
  begin
    if Tablo_actionneur[i].TempoCourante<>0 then
    begin
      dec(Tablo_actionneur[i].TempoCourante);
      if Tablo_actionneur[i].TempoCourante=0 then
      begin
        A:=Tablo_actionneur[i].adresse;
        s:=Tablo_actionneur[i].trainDest;
        Affiche('Actionneur '+intToSTR(a)+' TrainDest='+s+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':0',clyellow);
        envoie_fonction_CDM(Tablo_actionneur[i].fonction,0,s);
      end;
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
      
      // evt d�tecteur ?
      if Tablo_simule[i_simule].detecteur<>0 then
      begin
        s:='Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' det='+intToSTR(Tablo_simule[i_simule].detecteur)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Detecteur(Tablo_simule[i_simule].detecteur, Tablo_simule[i_simule].etat=1,'');  // cr�er �vt d�tecteur
        StaticText.caption:=s;
      end;

      // evt aiguillage ?
      if Tablo_simule[i_simule].aiguillage<>0 then
      begin
        s:='Simulation '+intToSTR(I_simule)+' Tick='+IntToSTR(tick)+' aig='+intToSTR(Tablo_simule[i_simule].aiguillage)+'='+IntToSTR(Tablo_simule[i_simule].etat);
        Event_Aig(Tablo_simule[i_simule].Aiguillage,Tablo_simule[i_simule].etat);  // cr�er �vt aiguillage
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

  // temporisations de d�marrage des trains au feux pas encore au point
  if Option_demarrage then
  for i:=1 to 1024 do
  begin
    if detecteur[i].tempo<>0 then
    begin
      dec(detecteur[i].tempo);
      if detecteur[i].tempo=0 then
      begin
        s:=detecteur[i].train;
        //Affiche('Tempo 0 timer train '+s+' det '+intToSTR(i),clOrange);
        s:=chaine_CDM_vitesseST(100,s);  // 100%
        envoi_cdm(s);
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

  pilote_acc(adr,const_devie,aigP);
  s:='accessoire '+IntToSTR(adr)+' d�vi�';
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

// erreur sur socket Lenz (interface XpressNet)
procedure TFormPrinc.ClientSocketLenzError(Sender: TObject;
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
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
   end;
   if errorcode<>10061 then affiche(s,ClOrange);
   afficheDebug(s,ClOrange);
   deconnecte_cdm;
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

// proc�dure Event appel�e si on clique sur un checkbox de demande de feu blanc des images des feux
// non utilis�
procedure TFormprinc.proc_checkBoxFB(Sender : Tobject);
var s : string;
    Cb : TcheckBox;
    etat,adresse,erreur : integer;
    i : word;
    coche : boolean;
begin
  Cb:=Sender as TcheckBox;
  coche:=cb.Checked;         // �tat de la checkbox
  s:=Cb.Hint;
  val(s,adresse,erreur);   // adresse du signal correspondant au checkbox cliqu�
  if erreur=0 then
  begin
    i:=index_feu(adresse);
    if i=0 then exit;
    etat:=feux[i].EtatSignal;
    affiche(IntToSTR(etat),clyellow);
    // si le feu est vert et que la coche est mise, substituer le blanc
    if (etat=vert_F) and coche then
    begin
      Maj_Etat_Signal(Adresse,blanc);
      Envoi_signauxCplx;
    end;
    // si pas coch�, on revient en normal
    if not(coche) then rafraichit;
  end; 
end;

procedure TFormPrinc.ButtonInfoClick(Sender: TObject);
begin
  Affiche('Ce programme pilote des signaux complexes de fa�on autonome ou avec CDM rail ',ClYellow);
  Affiche('En fonction des d�tecteurs mis � 1 ou 0 par des locomotives',ClYellow);
  Affiche('en circulation sur le r�seau',ClYellow);
  Affiche('En vert : Trames envoy�es � l''interface',ClWhite);
  Affiche('En violet : Trames brutes re�ues de l''interface',ClWhite);
  Affiche('En rouge : erreurs et d�fauts',ClWhite);
  Affiche('En orange : pilotage des signaux / erreurs mineures',ClWhite);
  Affiche('En bleu : pilotage des aiguillages',ClWhite);
  Affiche('En jaune : r�trosignalisation re�ue depuis l''interface',ClWhite);
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
    Affiche('Port USB d�connect�',clyellow);
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
  Affiche('Etat des d�tecteurs:',ClLime);
  for j:=1 to NDetecteurs do
  begin
   adr:=Adresse_detecteur[j];
   s:='D�t '+intToSTR(adr)+'=';
   if Detecteur[adr].etat then s:=s+'1 '+Detecteur[Adr].train else s:=s+'0';
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
      if aiguillage[index].position=const_devie then s:=s+' (d�vi�)' ;
      if aiguillage[index].position=const_droit then s:=s+' (droit)';
      if aiguillage[index].position=const_inconnu then s:=s+' inconnue';
      
      if model=triple then // aig triple
      begin
        j:=aiguillage[index].AdrTriple;
        s:=s+' Aig '+IntToSTR(j)+': '+intToSTR(aiguillage[index_aig(j)].position);
        if aiguillage[index_aig(j)].position=1 then s:=s+' (d�vi�)' else s:=s+' (droit)';
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
  Affiche('D=position droite S=position d�vi�e P=pointe Z=d�tecteur',Cyan);
  for i:=1 to MaxAiguillage do
  begin
    adr:=aiguillage[i].adresse;
    begin
      s:=IntToSTR(i)+' Adr='+IntToSTR(adr);
      if aiguillage[i].modele=aig then s:=s+' Pointe=';
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
      if (aiguillage[i].modele=tjd) or (aiguillage[i].modele=tjs) then
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
    
procedure TFormPrinc.ClientSocketLenzConnect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Lenz connect� ',clYellow);
  AfficheDebug('Lenz connect� ',clYellow);
  parSocketLenz:=True;
  ButtonEcrCV.Enabled:=true;
  ButtonLitCV.Enabled:=true;
  LireunfichierdeCV1.enabled:=true;
  LabelTitre.caption:=titre+' Interface connect�e par Ethernet';
end;

procedure TFormPrinc.ClientSocketCDMConnect(Sender: TObject;Socket: TCustomWinSocket);
var s : string;
begin
  s:='Socket CDM rail connect�';
  LabelTitre.caption:=titre+' '+s;
  Affiche(s,clYellow);
  AfficheDebug(s,clYellow);
  CDM_connecte:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  DeConnecterCDMRail.enabled:=true;
end;

// d�codage d'une trame CDM au protocole IPC
// la trame_CDM peut contenir 2000 caract�res � l'initialisation du RUN.
procedure Interprete_trameCDM(trame_CDM:string);
var i,j,objet,posST,posAC,posDT,posSG,posXY,k,l,erreur,posErr, adr,adr2,etat,etataig,
    vitesse,etatAig2,name,prv,nbre,nbreVir,long,index,posDes,AncNumTrameCDM : integer ;
    x,y,x2,y2 : longint ;
    s,ss,train,commandeCDM : string;
    traite,sort : boolean;
label reprise;
begin
{
  trame_CDM:='S-R-14-0004-CMDACC-__ACK|000|S-E-14-5162-CMDACC-ST_DT|052|05|NAME=2756;OBJ=2756;AD=518;TRAIN=CC406526;STATE=1;';
  trame_cdm:=trame_cdm+'S-E-14-5163-CMDACC-ST_DT|049|05|NAME=2757;OBJ=2757;AD=518;TRAIN=_NONE;STATE=1;';
  trame_cdm:=trame_cdm+'S-C-07-1373-DSCTRN-SPEED|029|03|NAME=CAMERA;AD=6;TMAX=120;'  ;
  trame_cdm:=trame_cdm+'S-C-07-1374-DSCTRN-__END|000|' ;
  S-R-01-0004-CMDTRN-__ERR|048|03|ERR=300;SEV=2;MSG=Throttle_By_Name_Not_Found;
  }
  //affiche(trame_cdm,clLime);
  residuCDM:='';
  AckCDM:=trame_CDM<>'';

  k:=0;
  repeat
    {// inutile de v�rifier les num�ros de trames, elles peuvent ne pas �tre envoy�es dans l'ordre!!
    if length(trame_CDM)>3 then
    begin
      if copy(trame_CDM,1,3)='S-E' then
      begin
        // num�ro de la trame
        i:=pos('-',trame_CDM);
        if i<>0 then
        begin
          i:=posEx('-',trame_CDM,i+1);
          if i<>0 then
          begin
            i:=posEx('-',trame_CDM,i+1);
            if i<>0 then
            begin
              j:=posEx('-',trame_CDM,i+1);
              AncNumTrameCDM:=NumTrameCDM;
              val(copy(trame_CDM,i+1,j-1),NumTrameCDM,erreur);
              if AncNumTrameCDM=0 then AncNumTrameCDM:=NumTrameCDM-1;
              affiche(IntToSTR(NumTrameCDM),clLime);
              if AncNumTrameCDM+1<>NumTrameCDM then
              begin
                s:='Erreur trames CDM perdues: #derni�re='+intToSTR(AncNumTrameCDM)+' #Nouvelle='+intToSTR(NumTrameCDM);
                Affiche(s,clred);
                AfficheDebug(s,clred);
              end;
            end;
          end;
        end;
      end;
    end;}

    // trouver la longueur de la cha�ne de param�tres entre les 2 premiers |xxx|
    i:=pos('|',trame_CDM);
    if i=0 then
    begin
      if debugTrames then AfficheDebug('tronqu�1 : '+trame_CDM,clyellow);
      residuCDM:=trame_CDM;
      Nbre_recu_cdm:=0;
      exit;
    end;
    j:=posEx('|',trame_CDM,i+1);
    if j=0 then
    begin
      if debugTrames then AfficheDebug('tronqu�2 : '+trame_CDM,clyellow);
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
      delete(trame_cdm,1,j);
      goto reprise;
    end;


    if long>l then
    begin
      if debugTrames then AfficheDebug('tronqu�3 : '+trame_CDM,clyellow);
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
        if debugTrames then AfficheDebug('tronqu�4 : '+trame_CDM,clyellow);
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
        if pos('ERR=200',commandeCDM)<>0 then s:='Erreur CDM : r�seau non charg� ';
        if pos('ERR=500',commandeCDM)<>0 then s:='Erreur CDM : serveur DCC non lanc� ';
        if pos('ERR=300',commandeCDM)<>0 then s:='Erreur CDM : train non trouv� ';
        j:=pos('MSG=',commandeCDM);if j<>0 then s:=s+copy(commandeCDM,j,i-j);
        Affiche(s,clred);
        delete(commandeCDM,1,i);
      end;

      // description des trains  03|NAME=BB16024;AD=3;TMAX=120;'
      posDES:=pos('DSCTRN-SPEED',commandeCDM);
      if posDES<>0 then
      begin
        inc(ntrains);
        delete(commandeCDM,1,posDES+12);
        i:=posEx('NAME=',commandeCDM,posST);delete(commandeCDM,1,i+4);
        i:=pos(';',commandeCDM);
        trains[ntrains].nom_train:=copy(commandeCDM,1,i-1);
        delete(commandeCDM,1,i);

        i:=pos('AD=',commandeCDM);Delete(commandeCDM,1,i+2);
        val(commandeCDM,trains[ntrains].adresse,erreur);
        i:=pos(';',commandeCDM);
        delete(commandeCDM,1,i);

        i:=pos('TMAX=',commandeCDM);Delete(commandeCDM,1,i+4);
        val(commandeCDM,trains[ntrains].vitmax,erreur);
        i:=pos(';',commandeCDM);
        delete(commandeCDM,1,i);
        Formprinc.ComboTrains.Items.Add(trains[ntrains].nom_train);
      end;

      // �v�nement aiguillage. Le champ AD2 n'est pas forc�ment pr�sent
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
          AfficheDebug('Recu evt aig de CDM pour un aiguillage '+intToSTR(Adr)+' non d�clar�',clOrange);
        end;
      end;

      // �v�nement d�tecteur
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
        //Affiche(IntToSTR(adr)+' '+IntToSTR(etat)+' '+train,clyellow);
        if AfficheDet then Affiche('R�tro D�tecteur '+intToSTR(adr)+'='+IntToStr(etat),clYellow);
      end ;

      // �v�nement signal - non stock� ni interpr�t�
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
      end;

      // �v�nement actionneur
      // attention un actionneur qui repasse � 0 ne contient pas de nom de train
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
        Event_act(adr,0,etat,train); // d�clenche �vent actionneur
      end;

      // �v�nement position des trains - non stock� ni interpr�t�
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
  connecte_CDM;
end;

procedure TFormPrinc.DeconnecterCDMRailClick(Sender: TObject);
begin
  deconnecte_CDM;
end;

procedure TFormPrinc.ClientSocketCDMDisconnect(Sender: TObject;  Socket: TCustomWinSocket);
begin
  deconnecte_cdm;
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
    s:=s+' d�codeur='+IntToStr(feux[i].decodeur);

    if feux[i].aspect<10 then
    begin
      s:=s+' SIG Nbrefeux='+IntToSTR(feux[i].aspect)+' ';
      s:=s+' Det='+IntToSTR(feux[i].Adr_det1);
      s:=s+' El_Suiv1='+IntToSTR(feux[i].Adr_el_suiv1)+' Type suiv1='+intToSTR(BTypeToNum(feux[i].Btype_suiv1));
      case feux[i].Btype_suiv1 of
      det : s:=s+' (d�tecteur) ';
      aig,tjs,tjd : s:=s+' (aiguillage ou TJD-S) ';
      triple : s:=s+' (aiguillage triple) ';
      end;
      if feux[i].decodeur=6 then
      s:=s+'Cible unisemaf='+intToSTR(feux[i].Unisemaf);

      // conditions sur carr�
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

      if feux[i].decodeur=7 then
      begin
        s:=s+' SR(';
        for l:=1 to 8 do
        begin
          s:=s+intToSTR(feux[i].SR[l].sortie1)+',';
          s:=s+intToSTR(feux[i].SR[l].sortie0);
          if l<8 then s:=s+'/' else s:=s+')';
        end;
      end;  

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
    if s2<>'' then Affiche('Conditions de carr� : '+s2,clYellow);
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
  
  //s:=#$ff+#$fe+#$23+#$1e+Char(adr)+Char(valeur);    //CV de 512 � 767 V3.4
  //s:=#$ff+#$fe+#$23+#$1d+Char(adr)+Char(valeur);    //CV de 256 � 511 V3.4
  s:=#$23+#$16+Char(adr)+Char(valeur);      //CV de 1 � 256
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
            s:=#$23+#$16+Char(cv)+Char(valeur);      //CV de 1 � 256
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
  N_Cv:=0; // nombre de CV recus � 0
  sa:='';
  Affiche('Lecture CV',clyellow);

  val(EditCV.Text,cv,erreur);
  if (erreur<>0) or (cv>255) or (cv<0) then 
  begin
    EditCV.Text:='1';
    exit;
  end;  
  //trace:=true;
  s:=#$22+#$15+Char(cv);      //CV de 1 � 256 (V3.0)
  //s:=#$22+#$18+Char(cv);      //CV de 1 � 255 + 1024 (V3.6)
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
    //Affiche('re�u trame succes',clyellow);
    s:=#$21+#$10;      // demande d'envoi du r�sultat du mode service
    s:=checksum(s);
    //envoi(s);
    envoi_ss_ack(s);
    Tempo(1);
    // attente de la r�ponse de la centrale
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
  Affiche('Pas de r�ponse de l''interface apr�s demande de passage en mode prog',clOrange);
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
    son,Mem : boolean;
    s,s2 : string;
begin
  if (maxTablo_act=0) and (NbrePN=0) then
  begin
    Affiche('Aucun actionneur d�clar�',Cyan);
    exit;
  end;

  Affiche('Codification interne des actionneurs',Cyan);
  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].trainDecl;
    etatAct:=Tablo_actionneur[i].etat ;
    AdrAct:=Tablo_actionneur[i].adresse;
    s2:=Tablo_actionneur[i].trainDecl;
    acc:=Tablo_actionneur[i].accessoire;
    sortie:=Tablo_actionneur[i].sortie;
    fonction:=Tablo_actionneur[i].fonction;
    son:=Tablo_actionneur[i].son;
    Mem:=Tablo_actionneur[i].typActMemZone=1;

    if Mem then s:='Mem '+intToSTR(adrAct)+' '+inttostr(Tablo_actionneur[i].Adresse2)
    else s:=intToSTR(adrAct);

    if (s2<>'') then
    begin
      if fonction<>0 then
      s:='FonctionF  D�clencheur='+s+' :'+intToSTR(etatAct)+' TrainD�cl='+s2+' TrainDest='+Tablo_actionneur[i].TrainDest+' F'+IntToSTR(fonction)+
              ' Temporisation='+intToSTR(tablo_actionneur[i].Tempo);
      if acc<>0 then
      s:='Accessoire D�clencheur='+s+' :'+intToSTR(etatAct)+' TrainD�cl='+s2+' A'+IntToSTR(acc)+
              ' sortie='+intToSTR(sortie);
      if son then
      s:='Son D�clencheur='+s+' :'+intToSTR(etatAct)+' TrainD�cl='+s2+
         '  Fichier:'+Tablo_actionneur[i].FichierSon;

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
  OpenDialog.Title:='Ouvrir un fichier de trames CDM (protocole COM-IPC)';
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
var adr,vit,erreur : integer;
    s : string;
begin
  // vitesse et direction 18 pas
  s:=editAdrTrain.Text;
  val(s,adr,erreur);
  if (erreur<>0) or (adr<0) then exit;
  s:=editVitesse.Text;
  val(s,vit,erreur);
  if (erreur<>0) or (vit<0) then exit;
  s:=trains[combotrains.itemindex+1].nom_train;
  vitesse_loco(s,adr,vit,true);
  if s='' then s:=intToSTR(adr);
  Affiche('Commande vitesse train '+s+ ' � '+IntToSTR(vit)+'%',cllime);

end;

// pour d�placer l'ascenseur de l'affichage automatiquement en bas
procedure TFormPrinc.FenRichChange(Sender: TObject);
begin
  SendMessage(FenRich.handle,WM_VSCROLL,SB_BOTTOM, 0);
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
  Affiche('Signaux complexes GL version '+version+sousVersion+' (C) 2022 F1IWQ Gily TDR',clWhite);

  FenRich.SelStart:=length(FenRich.Text);
  FenRich.SelAttributes.Style:=[fsUnderline];
  FenRich.lines.add('https://github.com/f1iwq2/Signaux_complexes_GL');
  RE_ColorLine(FenRich,FenRich.lines.count-1,clAqua);

  FenRich.SelStart:=length(FenRich.Text);
  FenRich.SelAttributes.Style:=[fsUnderline];
  FenRich.lines.add('http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906');
  RE_ColorLine(FenRich,FenRich.lines.count-1,clAqua);

  Affiche(' ',clyellow);
end;

// cliqu� droit sur un feu puis sur le menu propri�t�s
procedure TFormPrinc.Proprits1Click(Sender: TObject);
var s: string;
    index : integer;
begin
  clicliste:=false;
  s:=((Tpopupmenu(Tmenuitem(sender).GetParentMenu).PopupComponent) as TImage).name; // nom du composant, pout r�cup�rer l'index (ex: ImageFeu6)
  //Affiche(s,clOrange);     // nom de l'image du signal (ex: ImageFeu6)
  index:=extract_int(s);   // extraire l'index (ex 6)
  Tformconfig.create(nil);
  formconfig.PageControl.ActivePage:=formconfig.TabSheetSig;
  indexfeuclic:=index-1;
  clicproprietes:=true;
  formconfig.showmodal;
  formconfig.close;
end;

procedure TFormPrinc.VrifierlacohrenceClick(Sender: TObject);
begin
  if verif_coherence then affiche('La configuration est coh�rente',clLime);
end;

// cliqu� gauche dans la fenetre Fenrich
procedure TFormPrinc.FenRichMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var lc : integer;
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
      lc:=Perform(EM_LINEFROMCHAR,-1,0);
      s:=lines[lc];
    end;
    if pos('http',s)<>0 then
    begin
      ShellExecute(0,'open',Pchar(s),nil,nil,sw_shownormal);
    end;
  end;
end;

procedure TFormPrinc.ButtonLocCVClick(Sender: TObject);
begin
  if groupBox3.Visible then begin groupBox3.Visible:=false;groupBox2.Visible:=true;exit;end
  else begin groupBox2.Visible:=false;groupBox3.Visible:=true;end;
end;


procedure TFormPrinc.ComboTrainsChange(Sender: TObject);
var i : integer;
begin
   i:=ComboTrains.itemIndex;
   EditAdrTrain.Text:=intToSTR(trains[i+1].adresse);
end;

procedure TFormPrinc.ButtonFonctionClick(Sender: TObject);
var erreur,fonction,etat,loco : integer;
    s : string;
begin
  val(editNumFonction.Text,fonction,erreur);
  if erreur<>0 then exit;
  val(editFonc01.Text,etat,erreur);
  if erreur<>0 then exit;
  val(editAdrTrain.Text,loco,erreur);
  s:=trains[combotrains.itemindex+1].nom_train;
  if CDM_connecte then 
  begin
    if s='' then begin Affiche('S�lectionnez un train',clOrange);exit;end;
    if fonction>12 then 
    begin
      Affiche('Avec CDM Rail, F12 maxi',clOrange);
      exit;
    end;
    envoie_fonction_CDM(fonction,etat,s);
    Affiche('Train='+s+' F'+IntToSTR(fonction)+':'+intToSTR(etat),clyellow);
  end;
  if portCommOuvert or parSocketLenz then 
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


procedure TFormPrinc.Button1Click(Sender: TObject);
var erreur,fonction,etat,loco : integer;
    s : string;
begin
   val(editNumFonction.Text,fonction,erreur);
  if erreur<>0 then exit;
  val(editFonc01.Text,etat,erreur);
  if erreur<>0 then exit;
  val(editAdrTrain.Text,loco,erreur);
  s:=trains[combotrains.itemindex+1].nom_train;
  if CDM_connecte then 
  begin
    envoie_fonction_CDM(fonction,etat,s);
    Affiche('Train='+s+' F'+IntToSTR(fonction)+':'+intToSTR(etat),clyellow);
  end;
  //if portCommOuvert or parSocketLenz then 
  begin
    if erreur<>0 then exit;
    Affiche('Train adresse '+intToStr(loco)+' F'+IntToSTR(fonction)+':'+intToSTR(etat),clyellow);
    Fonction_Loco_State(loco,fonction,etat);
  end;  
end;

begin
end.
