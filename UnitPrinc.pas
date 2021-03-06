Unit UnitPrinc;
(********************************************
  programme signaux complexes Graphique Lenz
  delphi 7 + activeX Tmscomm + clientSocket
 ********************************************
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
  ImgList, ScktComp, StrUtils, Menus, ActnList, MSCommLib_TLB , unitConfig  ;

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
tempoFeu=100;
MaxAcc=2048;
LargImg=50;HtImg=91; // image des feux
const_droit=2;const_devie=1;  // positions aiguillages transmises par la centrale LENZ
const_devieG_CDM=3;  // positions aiguillages transmises par cdm
const_devieD_CDM=2;  // positions aiguillages transmises par cdm
const_droit_CDM=0;   // positions aiguillages transmises par cdm
const_inconnu=9;     // position inconnue
ClBleuClair=$FF7070 ;
Cyan=$FF6060;
clviolet=$FF00FF;
GrisF=$414141;
clOrange=$0077FF;
Feu_X=50;Feu_Y=91;
Max_Simule=10000;
NbCouleurTrain=8;
couleurTrain : array[1..NbCouleurTrain] of Tcolor = (clYellow,clLime,clOrange,clAqua,clFuchsia,clLtGray,clred,clWhite);
EtatSign : array[0..13] of string[20] =('carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');
NbDecodeur = 7;
decodeur : array[0..NbDecodeur-1] of string[20] =('rien','digital Bahn','CDF','LDT','LEB','NMRA','Unisemaf');

type TBranche = record
               BType : integer ;   // 1= d�tecteur  2= aiguillage 4=Buttoir
               Adresse : integer ; // adresse du d�tecteur ou de l'aiguillage
            end;

     Taiguillage = record
                 modele : integer;          // 0=n'existe pas  1=aiguillage 2=TJD 3=TJS 4=aiguillage triple
                 position,                  // position actuelle : 1=d�vi�  2=droit (centrale LENZ)
                 Adrtriple,                 // 2eme adresse pour un aiguillage triple
                 temps,                     // temps de pilotage (dur�e de l'impulsion en x 100 ms)
                 inversion : integer;       // pilotage invers� pour la commande (en mode sans CDM) 0=normal 1=invers� (positionn� dans fichier config_gl section_init
                 InversionCDM : integer ;   // inversion pour les aiguillages en lecture (param�tre I1)
                 vitesse : integer;         // vitesse de franchissement de l'aiguillage en position d�vi�e (60 ou 90)

                 ADroit : integer ;         // (TJD:identifiant ext�rieur) connect� sur la position droite en talon
                 ADroitB : char ;           // id de branche pour TJD

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

                 // si modifi� en mode config
                 modifie : boolean ;
                end;

Taccessoire     = (aig,feu);
TMA             = (valide,devalide);

var
  ancien_tablo_signalCplx,EtatsignalCplx : array[0..MaxAcc] of word;
  tempsCli,NbreFeux,pasreponse,AdrDevie,fenetre,Tempo_Aig,
  NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
  Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,NbrePN,ServeurInterfaceCDM,
  ServeurRetroCDM,TailleFonte,Nb_Det_Dist : integer;

  Hors_tension2,traceSign,TraceZone,Ferme,parSocketLenz,ackCdm,PremierFD,
  NackCDM,MsgSim,succes,recu_cv,AffActionneur,AffAigDet,Option_demarrage,
  TraceListe,clignotant,nack,Maj_feux_cours,configNulle,LanceCDM,AvecInitAiguillages : boolean;

  CDMhd : THandle;
  branche : array [1..100] of string;

  FormPrinc: TFormPrinc;
  ack,portCommOuvert,traceTrames,AffMem,AfficheDet,CDM_connecte,SocketCDM_connecte,
  Raz_Acc_signaux,AvecInit,AvecTCO,terminal,Srvc_Aig,Srvc_Det,Srvc_Act,
  Srvc_PosTrain,Srvc_Sig,debugtrames : boolean;
  tablo : array of byte;  // tableau rx usb
  Enregistrement,chaine_Envoi,chaine_recue,Id_CDM,Af,
  entete,suffixe,ConfStCom,LAY : string;
  maxaiguillage,detecteur_chgt,Temps,Tempo_init,Suivant,TypeGen,
  NbreImagePligne,NbreBranches,Index2_det,Index2_aig,branche_det,Index_det,
  I_simule,maxTablo_act,NbreVoies,AdresseFeuSuivant,El_suivant : integer;
  Ancien_detecteur : array[0..1024] of boolean;   // anciens �tat des d�tecteurs et adresses des d�tecteurs et leur �tat
  detecteur : array[0..1024] of
  record
     etat : boolean;
     tempo : integer;
     train : string;
  end;

  Adresse_detecteur : array[0..60] of integer; // adresses des d�tecteurs par index
  mem : array[0..1024] of boolean ; // m�moire des �tats des d�tecteurs
  MemZone : array[0..1024,0..1024] of boolean ; // m�moires de zones
  Tablo_actionneur : array[1..100] of
  record
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
             PresTrain : boolean; // m�moire de pr�sence de train sur la voie
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
  // mod�lisations des fichiers config
  mod_branches,mod_act : array[1..100] of string;
  // l'indice du tableau aiguillage est son adresse
  aiguillage : array[0..MaxAcc] of Taiguillage;
  // signaux - L'index du tableau n'est pas l'adresse du feu
  feux : array[1..MaxAcc] of record
                 adresse, aspect : integer; // adresse du feu, aspect (2 feux..9 feux 12=direction 2 feux .. 16=direction 6 feux)
                 Img : TImage;              // Pointeur sur structure TImage du feu
                 Lbl : TLabel;              // pointeur sur structure Tlabel du feu
                 check : TCheckBox;         // pointeur sur structure Checkbox avec feu blanc
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
                 Btype_suiv1 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri
                 Btype_suiv2 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri
                 Btype_suiv3 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri
                 Btype_suiv4 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri
                 VerrouCarre : boolean ;     // si vrai, le feu se verrouille au carr� si pas de train avant le signal
                 modifie     : boolean;      // feu modifi�
                 EtatSignal  : word  ;       // comme EtatSignalCplx
                 UniSemaf : integer ;        // d�finition suppl�mentaire de la cible pour les d�codeurs UNISEMAF
                 AigDirection : array[1..6] of array of record        // pour les signaux directionnels : contient la liste des aiguillages associ�s
                                               Adresse : integer;     // 6 feux max associ�s � un tableau dynamique d�crivant les aiguillages
                                               posAig  : char;
                                               end;
                 CondCarre : array[1..6] of array of record  // conditions suppl�mentaires d'aiguillages en position pour le carr�
                                               Adresse : integer;    // aiguillage
                                               posAig : char;
                                               end;
               end;
  Fimage : Timage;
  BrancheN : array[1..100,1..200] of TBranche;  //

{$R *.dfm}

// utilisation des proc�dures et fonctions dans les autres unit�s
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
function  IsWow64Process: Boolean;
procedure Dessine_feu_mx(CanvasDest : Tcanvas;x,y : integer;FrX,frY : real;adresse : integer;orientation : integer);
procedure Pilote_acc0_X(adresse : integer;octet : byte);
procedure pilote_acc(adresse : integer;octet : byte;Acc : TAccessoire);
function  etat_signal_suivant(Adresse,rang : integer) : integer;
function suivant_alg3(prec : integer;typeELprec : integer;var actuel : integer;typeElActuel : integer;alg : integer) : integer;
function detecteur_suivant_El(el1: integer;TypeDet1 : integer;el2 : integer;TypeDet2 : integer) : integer ;
function test_memoire_zones(adresse : integer) : boolean;
function PresTrainPrec(AdrFeu : integer) : boolean;
function cond_carre(adresse : integer) : boolean;
function carre_signal(adresse : integer) : boolean;
procedure Event_Detecteur(Adresse : integer;etat : boolean;train : string);

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

// renvoie le 1er num�ro de bit � 1
// ex BitNum(4)=2
Function BitNum(n : word) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=0;
  repeat
    trouve:=(n and 1)=1 ;
    if not(trouve) then inc(i);
    n:=n shr 1;
  until (i=16) or trouve;
  BitNum:=i;
end;

// conversion du motif de bits (codebin) de la configuration du signal complexe en deux mots:
// en sortie :
// premierBit : code de la signalisation
// Combine = code de la signalisation combin�e
// Exemple code_to_aspect(10001000000000)  renvoie premierBit=jaune_cli (9) et Combine=rappel 60 (13)
procedure code_to_aspect(codebin : word;var premierbit,combine : word) ;
var i,mot : word;
begin
  premierBit:=BitNum(CodeBin and $3ff);
  combine:=BitNum(CodeBin and $fc00);
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
    s : string;
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

procedure Affiche(s : string;lacouleur : TColor);
begin
  with formprinc do
  begin
     FenRich.lines.add(s);
     RE_ColorLine(FenRich,FenRich.lines.count-1,lacouleur);
     //FenRich.SetFocus;
     //FenRich.SelStart := FenRich.GetTextLen;
     //FenRich.Perform(EM_SCROLLCARET, 0, 0);
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

Procedure TFormprinc.ImageOnClick(Sender : Tobject);
var s : string;
    P_image_pilote : Timage;
    i,erreur : integer;
begin
  P_image_pilote:=Sender as TImage;  // r�cup�rer l'objet image de la forme pilote
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

// cr��e une image dynamiquement pour un nouveau feu d�clar� dans le fichier de config
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
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // d�termine les dimensions
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    //Left:=10+(LargImg+10)*((rang-1) mod (NbreImagePLigne));
    s:='@='+inttostr(feux[rang].Adresse)+' Decodeur='+intToSTR(feux[rang].Decodeur)+' Adresse d�tecteur associ�='+intToSTR(feux[rang].Adr_det1)+
       ' Adresse �lement suivant='+intToSTR(feux[rang].Adr_el_suiv1);
    if feux[rang].Btype_suiv1=2 then s:=s+' (aig)';
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

    // mettre rouge par d�faut
    if TypeFeu=2 then EtatSignalCplx[feux[rang].adresse]:=violet_F;
    if TypeFeu=3 then EtatSignalCplx[feux[rang].adresse]:=semaphore_F;
    if (TypeFeu>3) and (TypeFeu<10) then EtatSignalCplx[feux[rang].adresse]:=carre_F;
    if TypeFeu>10 then EtatSignalCplx[feux[rang].adresse]:=0;

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
    Feux[rang].check.onClick:=formprinc.proc_checkBoxFB;  // affecter l'adresse de la proc�dure de traitement quand on clique dessus
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
  if traceTrames then AfficheDebug('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClGreen);
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
  {  exemple de commande envoy�e au serveur pour une fonction
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
  sx:=format('%.*d',[2,3])+'|';  // 3 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;
  chaine_CDM_Func:=so+s;
end;

// cha�ne pour vitesse train
function chaine_CDM_vitesse(vitesse:integer;train:string) : string;
var s,so,sx: string;
begin
  { C-C-00-0002-CMDTRN-SPEED|0xx|02|NAME=nomdutrain;UREQ=vitesse;   }
  so:=place_id('C-C-01-0004-CMDTRN-SPEED');
  s:=s+'NAME='+train+';';
  s:=s+'UREQ='+intToSTR(vitesse)+';';
  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_vitesse:=so+s;
end;

// pr�pare la cha�ne de commande pour un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat : integer) : string;
var so,sx,s : string;
begin
 {  exemple de commande envoy�e au serveur pour un manoeuvrer accessoire
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


// active ou d�sactive une sortie par xpressnet. Une adresse comporte deux sorties identifi�es par "octet"
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
  feux[i].EtatSignal:=EtatSignalCplx[adresse];
end;


{=============================================
envoie les donn�es au d�codeur digital bahn �quip� du logiciel "led_schalten"
sur un panneau directionnel - adresse : adresse du signal - code de 1 � 3 pour allumer
; le panneau directionnel � 1, 2 ou 3 leds.
============================================== }
procedure envoi_directionBahn(adr : integer;code : integer);
var i : integer;
begin
  if (EtatSignalCplx[adr]<>code) then
  begin
    if (traceSign) then Affiche('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);
    if AffSignal then AfficheDebug('Signal directionnel: ad'+IntToSTR(adr)+'='+intToSTR(code),clOrange);

    case code of
    0 :  begin      pilote_acc(adr,1,feu);   // sortie 1 � 0
                    sleep(tempoFeu);
                    pilote_acc(adr+1,1,feu); // sortie 2 � 0
                    sleep(Tempofeu);
                    pilote_acc(adr+2,1,feu); // sortie 3 � 0
                    sleep(TempoFeu);
         end;
    1 :  begin      pilote_acc(adr,2,feu);   // sortie 1 � 1
                    sleep(tempoFeu);
                    pilote_acc(adr+1,1,feu); // sortie 2 � 0
                    sleep(Tempofeu);
                    pilote_acc(adr+2,1,feu); // sortie 3 � 0
                    sleep(TempoFeu);
          end;
    2 :  begin      pilote_acc(adr,2,feu);   // sortie 1 � 1
                    sleep(tempoFeu);
                    pilote_acc(adr+1,2,feu); // sortie 2 � 1
                    sleep(Tempofeu);
                    pilote_acc(adr+2,1,feu); // sortie 3 � 0
                    sleep(TempoFeu);
          end;
    3 :  begin      pilote_acc(adr,2,feu);   // sortie 1 � 1
                    sleep(tempoFeu);
                    pilote_acc(adr+1,2,feu); // sortie 2 � 1
                    sleep(Tempofeu);
                    pilote_acc(adr+2,2,feu); // sortie 3 � 1
                    sleep(TempoFeu);
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
var index : integer;
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
    // signalisation non combin�e rappel 30 seul
    if (aspect=rappel_30) then pilote_acc(adresse+1,1,feu);

    // signalisation combin�e  - rappel 30 + avertissement - � tester......
    if (Combine=0)      then pilote_acc(adresse+2,1,feu) ;    // �teindre rappel 30
    if (Combine=rappel_30) then pilote_acc(adresse+2,2,feu) ; // allumer rappel 30
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
  ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
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

// d�codeur unisemaf (paco)
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

    // pour Unisemaf, la cible est d�finie dans le champ Unisemaf de la structure feux

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
          if combine=16 then //pas de sig combin�e
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
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
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
  code:=etatsignalcplx[adresse];
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
envoie les donn�es au d�codeur digitalbahn �quip� du logiciel "led_signal_10"
       adresse=adresse sur le BUS DCC
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

    //***ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];

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
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
  end;
end;

//�valuation des signaux ancienne version==================================================================*/
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
  // si train quitte zone de d�tection du signal
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
    begin    // si signal complexe suivant est au carr� ou s�maphore
      Maj_Etat_Signal(signalCplx,jaune);       // afficher un avertissement
    end
    else
    begin
      if ((aiguillage[11].position<>2) and (aiguillage[20].position<>2)
        and (aiguillage[12].position=2) and (aiguillage[18].position<>2)) then // si aiguille suivante prise en pointe est d�vi�e
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
      end
      else
      begin
        a:=(aiguillage[20].position<>2) and testbit(EtatSignalCplx[358],jaune);
        b:=((aiguillage[20].position=2) and testbit(EtatSignalCplx[420],jaune));
        if (a or b) then              // si signal cplx suivant est jaune
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
          Maj_Etat_Signal(signalCplx,jaune_cli);   // afficher un avertissement clignotant sur le signal complexe
        end
        else Maj_Etat_Signal(signalCplx,vert);      // sinon afficher un feu vert
      end;
    end;
  end;
end;

// signal 190 ================================================================ */
signalCplx:=190;
if memZone[523,526]=true then // si train quite zone de d�tection du signal
  begin
    Maj_Etat_Signal(signalCplx,semaphore);     //  mettre un s�maphore}
  end
  else
  begin
    if testBit(EtatSignalCplx[302],carre) or testBit(EtatSignalCplx[302],semaphore) then  // si signal complexe suivant= carr� ou s�maphore
     // Maj_Etat_Signal(signalCplx,jaune); //
      Maj_Etat_Signal(signalCplx,semaphore_cli)
    else
    begin
      if (aiguillage[9].position<>2) then                   // si aiguille suivante d�vi�e?
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        if testBit(EtatSignalCplx[302],jaune) then         // si signal suivant jaune ?
          Maj_Etat_Signal(signalCplx,jaune_cli);
        Maj_Etat_Signal(signalCplx,ral_60);      // afficher ralentissement
      end
      else   // aiguille 9 droite
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
  if (PresTrain=FALSE) then Maj_Etat_Signal(signalCplx,carre)        // si pas de train avant le signal, mettre au carr�
  else
  begin
    if ( (MemZone[527,520] and (aiguillage[7].position<>2)) or
         (MemZone[527,519] and (aiguillage[7].position=2)) ) then // si train quitte d�tection signal
    begin
      if (TestBit(EtatSignalCplx[signalCplx],carre)=FALSE) then Maj_Etat_Signal(signalCplx,semaphore);
    end
    else
    begin
      if (aiguillage[7].position<>2) then                         // aiguille locale prise en pointe d�vi�e?
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,rappel_30);      // afficher rappel ralentissement
        if (TestBit(EtatSignalCplx[176],carre)) or (testBit(EtatSignalCplx[176],semaphore)) then // si signal complexe suivant rouge
             Maj_Etat_Signal(signalCplx,jaune)
        else
             if TestBit(EtatSignalCplx[176],jaune) then                  // si signal complexe suivant est jaune
               Maj_Etat_Signal(signalCplx,jaune_cli);
      end
      else  // pas aiguille locale d�vi�e
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
if MemZone[525,528] or MemZone[525,535] then Maj_Etat_Signal(signalCplx,semaphore)  // si train quitte zone d�tection du signal
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
      // si aiguille distante d�vi�e
      if ( ((aiguillage[19].position<>2) or ((aiguillage[19].position=2) and (aiguillage[22].position<>2))) and (aiguillage[17].position<>2) ) then
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,ral_30);
      end
      else
      begin
        // si signal suivant jaune
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
  if detecteur[516].etat then Maj_Etat_Signal(signalCplx,blanc)
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
    // �quations de pr�sence train avant signal
    a:= MemZone[525,528] and (aiguillage[17].position<>2) and (aiguillage[10].position<>2);
    b:= MemZone[526,513] and (aiguillage[10].position<>2);
    PresTrain:=(a or b or MemZone[513,518] or MemZone[528,518]) and (aiguillage[19].position<>2);

    // �quations d'aiguillages prises en talon mal positionn�es
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
          if (aiguillage[1].position<>2) then                     // aiguille locale prise en pointe d�vi�e?
          begin
            EtatSignalCplx[signalCplx]:=0; // raz �tat du signal
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
          else  // pas aiguille locale d�vi�e
          begin
            // si signal suivant est rouge
            EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
  if MemZone[524,521] then // si train quite d�tection du signal
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
    if TestBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore); //  sinon mettre un s�maphore}
  end
  else
  begin
    if TestBit(EtatSignalCplx[204],carre) or testBit(EtatSignalCplx[204],semaphore) then    // si signal complexe suivant est au carr� ou s�maphore
    begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,jaune);       // afficher un avertissement
    end
    else
    begin
      if (aiguillage[7].position<>2) then                   // si aiguille suivante prise en pointe est d�vi�e
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
      end
      else
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
     (MemZone[526,515] and (aiguillage[9].position<>2)) then   // si train quitte zone de d�tection du signal
  begin
      if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then
        Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin
    if (aiguillage[9].position<>2) then                      // si aiguille locale d�vi�e
    begin
      EtatSignalCplx[signalCplx]:=0; // raz �tat du signal
      Maj_Etat_Signal(signalCplx,rappel_60);      // afficher rappel ralentissement
      if (testBit(EtatSignalCplx[316],carre) or testBit(EtatSignalCplx[316],semaphore )) then   // si signal suivant rouge
        Maj_Etat_Signal(signalCplx,jaune);
      // signal suivant jaune avec aiguille locale d�vi�e
      if testBit(EtatSignalCplx[316],jaune) then                  // si signal cplx suivant est jaune
        Maj_Etat_Signal(signalCplx,jaune_cli);
    end
    else  // si aiguille locale non d�vi�e
    begin
      // si signal suivant rouge
      if testBit(EtatSignalCplx[462],semaphore) or testBit(EtatSignalCplx[462],carre) then
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,jaune);
      end
      else
      begin
        // si aiguille suivante prise en pointe d�vi�e
        if ((aiguillage[19].position<>2) or ((aiguillage[19].position=2) and (aiguillage[22].position<>2))) then
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
          Maj_Etat_Signal(signalCplx,jaune);    // le ral30 est remplac� par avertissement sur ce signal
        end
        else
        // si signal suivant est jaune ou ralentissement 30
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
     if detecteur[518].etat then Maj_Etat_Signal(signalCplx,blanc_cli) else Maj_Etat_Signal(signalCplx,blanc) ;
   end
else
begin
  PresTrain:=MemZone[526,515] or (((MemZone[518,523] and (aiguillage[1].position=2)) or MemZone[523,526]) and (aiguillage[9].position<>2)) ;
  // �quations d'aiguillages mal positionn�s

  a:=((aiguillage[5].position=2) and (aiguillage[3].position=2)) or
            ((aiguillage[5].position=2) and (aiguillage[1].position=2)) or
            ((aiguillage[5].position<>2) and (aiguillage[2].position=2)) or
            ((aiguillage[5].position<>2) and (aiguillage[2].position<>2) and (aiguillage[12].position=2))  ;
  if a or (PresTrain=FALSE) then Maj_Etat_Signal(signalCplx,carre)
  else
  begin  // train quitte zone de d�tection du signal
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
           (testBit(EtatSignalCplx[358],carre) or testBit(EtatSignalCplx[358],semaphore)) ) then           // si signalCplx suivant est carr�
            Maj_Etat_Signal(signalCplx,jaune)
         else
         if ( ((aiguillage[5].position=2) and (aiguillage[3].position<>2) and (aiguillage[1].position<>2)) and     // si signal suivant est rouge
           (testBit(EtatSignalCplx[497],carre) or testBit(EtatSignalCplx[497],semaphore)) ) then
           Maj_Etat_Signal(signalCplx,jaune)
         else
         begin
           if (((aiguillage[11].position<>2) and (aiguillage[5].position<>2)) or
               ((aiguillage[10].position<>2) and (aiguillage[5].position=2))  ) then
           // si aiguille suivante prise en pointe est d�vi�e
             Maj_Etat_Signal(signalCplx,ral_30)      // afficher ralentissement

           else
           begin
             // si aiguille suivante en pointe est d�vi�e
             if ((aiguillage[29].position<>2) and (aiguillage[5].position=2)) then// si aiguille suivante prise en pointe est d�vi�e
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
b:=MemZone[522,527] or MemZone[514,522] or MemZone[518,514] or MemZone[514,522]; // and (aiguillage[8].position=0)) ;  ///� voirrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
PresTrain:=MemZone[527,519] or ( (aiguillage[7].position=2) and (a or b));

// aiguilles 2 et 12 mal positionn�es ou pas de train
  if (aiguillage[2].position=1) or (aiguillage[12].position=2) or (PresTrain=FALSE) then
  Maj_Etat_Signal(signalCplx,carre)          //  mettre un carr�}
  else
  begin
    //if (Mem_519_517=true) then
    if MemZone[519,517] then
    begin
      if (testbit(EtatSignalCplx[signalCplx],carre)=FALSE) then  Maj_Etat_Signal(signalCplx,semaphore);   //  sinon mettre un s�maphore}
    end
    else
    begin
      if (testbit(EtatSignalCplx[358],carre)) or  (testbit(EtatSignalCplx[358],semaphore)) then   // si signal complexe suivant est au carr� ou s�maphore
        Maj_Etat_Signal(signalCplx,jaune)       // afficher un avertissement
      else
      begin
        if (aiguillage[11].position<>2) then            // si aiguille suivante prise en pointe est d�vi�e
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
          Maj_Etat_Signal(signalCplx,ral_30);          // afficher ralentissement
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
      or (PresTrain=FALSE) )  then   // si aiguillage 10 non d�vi�  ou pas de train avant signal
      Maj_Etat_Signal(signalCplx,carre)                //  mettre un carr�}
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
    if ((aiguillage[19].position<>2) or (aiguillage[22].position<>2)) then   // aiguilles locales d�vi�es
    begin
      EtatSignalCplx[signalCplx]:=0; // raz �tat du signal
      Maj_Etat_Signal(signalCplx,rappel_30);
      // si aiguilles distantes d�vi�e ou signal distant rouge -> avertissement
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
    begin  // aiguilles locales non d�vi�es
      EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
      a:=((aiguillage[19].position<>2) and (testBit(EtatSignalCplx[260],carre) or testBit(EtatSignalCplx[260],semaphore))) ;
      b:=(((aiguillage[19].position=2) and (aiguillage[22].position=2)) and (testBit(EtatSignalCplx[420],carre) or testBit(EtatSignalCplx[434],semaphore))) ;
      c:=(((aiguillage[19].position=2) and (aiguillage[22].position<>2)) and (testBit(EtatSignalCplx[476],carre) or testBit(EtatSignalCplx[476],semaphore))) ;
      if (a or b or c) then // si signalCplx suivant au rouge
        Maj_Etat_Signal(signalCplx,jaune)
      else
      begin
        if aiguillage[11].position<>2 then                  // avant : 11 si aiguille suivante prise en pointe est d�vi�e
        begin
          Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
        if (testBit(EtatSignalCplx[signalCplx],carre)=FALSE) then // si train quite zone de d�tection du signal
               Maj_Etat_Signal(signalCplx,semaphore);
      end
      else
      begin
        if (aiguillage[11].position<>2) then                   // si aiguille locale d�vi�e
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
if MemZone[535,533] then  // si train quite d�tection du signal
    Maj_Etat_Signal(signalCplx,semaphore)
else
  if testBit(EtatSignalCplx[448],carre) or testBit(EtatSignalCplx[448],semaphore) then Maj_Etat_Signal(signalCplx,jaune)
    else
        if testBit(EtatSignalCplx[448],ral_30) or testBit(EtatSignalCplx[448],jaune) then Maj_Etat_Signal(signalCplx,jaune_cli)
         else
            Maj_Etat_Signal(signalCplx,vert_cli);



// signal 420 ===================================================================
// signal regroupant 3 voies � revoir
// num�ro de la voie en fonction de le position de l'aiguillage
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
      if aiguillage[11].position<>2 then  // si aiguille suivante est d�vi�e
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
        Maj_Etat_Signal(signalCplx,ral_30) ;
      end
      else
      begin
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
      if MemZone[533,538] then  //si train quitte zone de d�tection du signal
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
          if (aiguillage[11].position<>2) then                   // si aiguille suivante prise en pointe est d�vi�e
          begin
              EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
              Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
          end
          else
          begin  // cas si aiguille suivante prise en pointe pas d�vi�e
            EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
// si aiguillages pris en talon mal positionn�s  ou pas de train avant signal
if (aiguillage[10].position<>2) or (aiguillage[29].position<>2) or (PresTrain=FALSE) then
      Maj_Etat_Signal(signalCplx,carre)                //  mettre un carr�}
else
begin
  // si pr�sence train apr�s le signal (3 directions � tester) et signal <> carr�
  if ( MemZone[513,518] and (aiguillage[19].position<>2)) or
     ( MemZone[513,537] and (aiguillage[19].position=2) and (aiguillage[22].position=2)) or
     ( MemZone[513,538] and (aiguillage[19].position=2) and (aiguillage[22].position<>2))  then
  begin
     if TestBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
  end
  else
  begin
    if (aiguillage[19].position<>0) or (aiguillage[22].position<>2) then  // si aiguilles locales d�vi�es
    begin
      EtatSignalCplx[signalCplx]:=0; // raz �tat du signal
      Maj_Etat_Signal(signalCplx,rappel_30);
      // si aiguilles distantes d�vi�es ou signal distant rouge -> avertissement
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
      EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
      a:=((aiguillage[19].position<>0) and testBit(EtatSignalCplx[260],carre) or TestBit(EtatSignalCplx[260],semaphore)) ;
      b:=(((aiguillage[19].position<>0) and (aiguillage[22].position=2)) and TestBit(EtatSignalCplx[420],carre) or TestBit(EtatSignalCplx[434],semaphore)) ;
      c:=(((aiguillage[19].position=2) and (aiguillage[22].position<>0)) and testbit(EtatSignalCplx[476],carre) or TestBit(EtatSignalCplx[476],semaphore)) ;
      if (a or b or c) then  // si signalCplx suivant au rouge
        Maj_Etat_Signal(signalCplx,jaune)
      else
      begin
        //  aiguilles locales en position droite
        if (aiguillage[11].position<>2) then                   // si aiguille suivante prise en pointe est d�vi�e
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
          Maj_Etat_Signal(signalCplx,ral_30);      // afficher ralentissement
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
      if (aiguillage[11].position<>2) then                    // si aiguille locale d�vi�e
      begin
        EtatSignalCplx[signalCplx]:=0; // raz �tat complet
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
        EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
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
  // �quations aiguillages mal positionn�s
  if ((aiguillage[19].position<>1) or  // 1 = d�vi�
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
      if (aiguillage[10].position<>2) then                    // si aiguille locale d�vi�e
      begin
        EtatSignalCplx[signalCplx]:=0; // raz �tat complet
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
        EtatSignalCplx[signalCplx]:=0; // raz �tat complet
        Maj_Etat_Signal(signalCplx,rappel_60);      // afficher rappel ralentissement
        if testBit(EtatSignalCplx[274],semaphore) then                     // si signal suivant rouge
                 Maj_Etat_Signal(signalCplx,jaune)
           else if testbit(EtatSignalCplx[274],jaune) then // si signal suivant est jaune ou ral30
                  begin Maj_Etat_Signal(signalCplx,jaune_cli);end;
      end
      else
      begin  // aiguilles locales non d�vi�es
        //EtatSignalCplx[xx]:=0;               // raz �tat du signal
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
        if (aiguillage[7].position<>2) then// si aiguille suivante est d�vi�e
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
          Maj_Etat_Signal(signalCplx,ral_30) ;
        end
        else
        begin
          EtatSignalCplx[signalCplx]:=0;               // raz �tat du signal
          if TestBit(EtatSignalCplx[204],jaune) or testBit(EtatSignalCplx[204],ral_60) then                 //si signal cplx suivant est jaune ou ralentissement-----------
            Maj_Etat_Signal(signalCplx,jaune_cli)
            else Maj_Etat_Signal(signalCplx,vert);
        end;
      end;
    end;
  end;

end;  // de la proc�dure pilote signaux

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
      // envoie la commande au d�codeur
      case feux[i].decodeur of
       0 : envoi_virtuel(Adr);
       1 : envoi_signalBahn(Adr);
       2 : envoi_CDF(Adr);
       3 : envoi_LDT(Adr);
       4 : envoi_LEB(Adr);
       5 : envoi_NMRA(Adr);
       6 : envoi_UniSemaf(Adr);
      end;

      // v�rifier si on quitte le rouge
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
          // test si train sur le d�tecteur det
          if detecteur[det].etat then
          begin
            detecteur[det].tempo:=20;  // armer la tempo � 2s
            // arreter le train
            s:=detecteur[det].train;
            Affiche('et son d�tecteur '+IntToSTR(det)+'=1 tempo d�marrage '+s,clYellow);
            s:=chaine_CDM_vitesse(1,s);  // 0%
            envoi_cdm(s);
          end;
        end;
      end;
      end;
      
      ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr]; //***

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
           a:=EtatsignalCplx[adresse];     // a = �tat binaire du feu
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


// trouve l'enregistrement suivant apr�s l'offset dans une branche
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
        else ss:=copy(branche[Num_Branche],offset,length(branche[Num_Branche])-offset+1); // si j=0 c'est la fin de la cha�ne
  //affiche(ss,clGreen);
  enregistrement:=ss;
  if j=0 then result:=0 else result:=j+1;
end;

// trouve l'index d'un d�tecteur dans une branche
// si pas trouv�, renvoie 0
function index_detecteur(det,Num_branche : integer) : integer;
var i,adr : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        adr:=BrancheN[Num_Branche,i].adresse;
        trouve:=(det=adr) and ((BrancheN[Num_Branche,i].Btype=1) or (BrancheN[Num_branche,i].BType=4)); // cherche un d�tecteur
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
        trouve:=(AdrAig=adr) and ((BrancheN[Num_Branche,i].Btype=2) or (BrancheN[Num_branche,i].BType=3)); // cherche un aiguillage
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
  i:=1;
  repeat
    i:=index_detecteur(detecteur,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  // if (i<>0) and traceDet then Affiche('D�tecteur trouv� en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;

// si pas trouv�, IndexBranche_trouve=0
procedure trouve_aiguillage(adresse : integer);
var NBranche,i : integer;
begin
  Nbranche:=1;
  i:=1;
  repeat
    i:=index_aiguillage(Adresse,Nbranche);
    if i=0 then inc(NBranche);
  until (Nbranche>NbreBranches) or (i<>0);
  //if (i<>0) then Affiche('aiguillage '+IntToSTR(adresse)+' trouv� en branche '+intToSTR(NBranche)+' index='+IntToSTR(i),clYellow);
  branche_trouve:=NBranche;
  IndexBranche_trouve:=i;
end;

procedure lit_config;
var s,sa,chaine,SOrigine: string;
    c,paig : char;
    tec,tjd,tjs,s2,trouve,triple,debugConfig,multiple,fini,finifeux,trouve_NbDetDist,trouve_ipv4_PC,trouve_retro,
    trouve_sec_init,trouve_init_aig,trouve_lay,trouve_IPV4_INTERFACE,trouve_PROTOCOLE_SERIE,trouve_INTER_CAR,
    trouve_Tempo_maxi,trouve_Entete,trouve_tco,trouve_cdm,trouve_Serveur_interface,trouve_fenetre,
    trouve_NOTIF_VERSION,trouve_verif_version,trouve_fonte,trouve_tempo_aig   : boolean;
    bd,virgule,i_detect,i,erreur,aig,aig2,detect,offset,index, adresse,j,position,temporisation,invers,indexPointe,indexDevie,indexDroit,
    ComptEl,Compt_IT,Num_Element,k,modele,adr,adr2,erreur2,l,t,Nligne,postriple,itl,
    postjd,postjs,nv,it,Num_Champ : integer;
    function lit_ligne : string ;
    begin
      repeat
        readln(fichier,s);
        s:=uppercase(s);
        if length(s)>0 then c:=s[1];
      until ((c<>'/') and (s<>'')) or eof(fichier) ;
      lit_ligne:=s;
      //Affiche(s,clWhite);
    end;
    procedure compile_section_init;
    begin
     //initialisation aiguillages
      repeat
        s:=lit_ligne;
        j:=pos(',',s);
        if j>1 then
        begin
          begin
            adresse:=StrToINT(copy(s,1,j-1));Delete(s,1,j); // adresse aiguillage
            if (adresse>0) and (AvecInitAiguillages) then
            begin
              j:=pos(',',s);
              position:=StrToInt(copy(s,1,j-1));Delete(S,1,j);// position aiguillage
              if (position<1) or (position>2) then position:=1;
              aiguillage[adresse].position:=position;

              // temporisation aiguillage
              j:=pos(',',s);if j=0 then j:=length(s);
              val(s,temporisation,erreur);Delete(S,1,j);
              if (temporisation<0) or (temporisation>10) then temporisation:=5;
              aiguillage[adresse].temps:=temporisation;

              val(s,invers,erreur);
              if (invers<0) or (invers>1) then invers:=0;   // inversion commande
              aiguillage[adresse].inversion:=invers;
            end;
          end;
        end;
      until (adresse=0);
    end;

begin
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

  Nb_Det_Dist:=3;
  // initialisation des aiguillages avec des valeurs par d�faut
  for i:=1 to MaxAcc do
  begin
    Aiguillage[i].modele:=0  ;  //  sans existence
    Aiguillage[i].position:=const_inconnu;  // position inconnue
    Aiguillage[i].temps:=5   ;
    Aiguillage[i].inversion:=0;
    Aiguillage[i].inversionCDM:=0;
  end;
  for i:=1 to 1024 do
  begin
     Detecteur[i].etat:=false;
     Detecteur[i].train:='0';
     Ancien_detecteur[i]:=false;
  end;
  
  Affiche('lecture du fichier de configuration client-GL.cfg',clyellow);
  {$I+}
  try
    assign(fichier,'client-GL.cfg');
    reset(fichier);
  except
    Affiche('Erreur fatale: fichier client-gl.cfg non trouv�',clred);
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
      TailleFonte:=StrToINT(s);
      with FormPrinc.FenRich do
      begin
        Font.Size:=TailleFonte;
      end;
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
      if i<>0 then begin adresseIPCDM:=copy(s,1,i-1);Delete(s,1,i);portCDM:=StrToINT(s);end;
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
      if i<>0 then begin adresseIP:=copy(s,1,i-1);Delete(s,1,i);port:=StrToINT(s);end
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
      if not(config_com(s)) then Affiche('Erreur port com mal d�clar� : '+s,clred);
      portcom:=s;
    end;

    // temporisation entre 2 caract�res
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
      if (erreur<>0) or (valeur_entete>2) then Affiche('Erreur d�claration variable '+entete_ch,clred);
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

    sa:=uppercase(Tempo_Aig_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      inc(nv);
      trouve_Tempo_aig:=true;
      delete(s,i,length(sa));
      val(s,Tempo_Aig,erreur);
    end;
 
    
    i:=pos(uppercase(section_init),s);
    if i<>0 then
    begin
      inc(nv);
      trouve_sec_init:=true;
      compile_section_init;
    end;

    sa:=uppercase(verif_version_ch)+'=';
    i:=pos(sa,s);
    if i<>0 then
    begin
      trouve_verif_version:=true;
      inc(nv);
      delete(s,i,length(sa));
      // v�rification de la version au d�marrage
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
      // v�rification de la version au d�marrage
      i:=0;
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
      // v�rification de la version au d�marrage
      i:=0;
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
      // v�rification de la version au d�marrage
      i:=0;
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
      i:=0;
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
      i:=0;
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
      i:=0;
      val(s,i,erreur);
      if i<2 then begin i:=2;Affiche('Attention '+nb_det_dist_ch+' ramen� � '+IntToSTR(i),clOrange); end;
      Nb_Det_Dist:=i;
    end;
    inc(it);

  until (Nv>=19) or (it>30);

  //affiche(IntToSTR(Nv)+' variables',cyan);
  s:='';
  if (nv<19) then s:='ERREUR: manque variables dans config-gl.cfg :';

  if not(trouve_NbDetDist) then s:=s+' '+nb_det_dist_ch;
  if not(trouve_ipv4_PC) then s:=s+' '+IpV4_PC_ch;
  if not(trouve_retro) then s:=s+' '+retro_ch;
  if not(trouve_sec_init) then s:=s+' '+section_init;
  if not(trouve_init_aig) then s:=s+' '+INIT_AIG_ch;
  if not(trouve_lay) then s:=s+' '+LAY_ch;
  if not(trouve_INTER_CAR) then s:=s+' '+INTER_CAR_ch;
  if not(trouve_Tempo_maxi) then s:=s+' '+Tempo_maxi_ch;
  if not(trouve_Entete) then s:=s+' '+Entete_ch;
  if not(trouve_TCO) then s:=s+' '+TCO_ch;
  if not(trouve_CDM) then s:=s+' '+CDM_ch;
  if not(trouve_Serveur_interface) then s:=s+' '+Serveur_interface_ch;
  if not(trouve_fenetre) then s:=s+' '+fenetre_ch;
  if not(trouve_tempo_aig) then s:=s+' '+tempo_aig_ch;
  if not(trouve_NOTIF_VERSION) then s:=s+' '+NOTIF_VERSION_ch;
  if not(trouve_verif_version) then s:=s+' '+verif_version_ch;
  if not(trouve_fonte) then s:=s+' '+fonte_ch;

  if s<>'' then affiche(s,clred);

  //Affiche('Valeurs d''initialisation des aiguillages',clyellow);

  closefile(fichier);

  Affiche('lecture du fichier de configuration config.cfg',clyellow);
  {$I+}
  try
    assign(fichier,'config.cfg');
    reset(fichier);
  except
    Affiche('Fichier config.cfg non trouv�',clred);
    exit;
  end;
  {$I-}

  s:=Lit_ligne;  //variable log non utilis�e
  s:=Lit_ligne; // trace_det
  s:=Lit_ligne; // raz signaux
  Raz_Acc_signaux:=pos('1',s)<>0;
  if Raz_Acc_signaux then Affiche('Avec Raz commande signaux',clYellow);
  Affiche('D�finition des aiguillages',clyellow);

  // d�finition des aiguillages
  maxaiguillage:=0;
  Nligne:=1;
  repeat
    s:=lit_ligne;sOrigine:=s;inc(Nligne);
    //Affiche(s,ClLime);
    //chaine:=s;
    if debugconfig then Affiche(s,ClLime);
    if (s<>'0') then
    begin
      virgule:=pos(',',s);
      enregistrement:=copy(s,1,virgule-1);  // adresse de l'aiguillage [TRI]
      delete(s,1,virgule);
      postriple:=pos('TRI',enregistrement);triple:=postriple<>0;if triple then delete(enregistrement,postriple,3);
      postjd:=pos('TJD',enregistrement);tjd:=postjd<>0;if tjd then delete(enregistrement,postjd,3);
      postjs:=pos('TJS',enregistrement);tjs:=postjs<>0;if tjs then delete(enregistrement,postjs,3);

      // adresse de l'aiguillage
      Val(enregistrement,aig,erreur); // aig = adresse de l'aiguillage
      if erreur<>0 then Affiche('Erreur aiguillage '+intToSTR(aig)+' ; caract�re '+enregistrement[erreur]+' inconnu',clred);
      if aig>maxaiguillage then maxaiguillage:=aig;
      if debugConfig then Affiche('Adresse='+IntToSTR(aig)+' enregistrement='+Enregistrement,clyellow);

      aiguillage[aig].AdroitB:='Z'; aiguillage[aig].AdevieB:='Z';
      aiguillage[aig].DdroitB:='Z'; aiguillage[aig].DdevieB:='Z';

      aiguillage[aig].ApointeB:='Z';
      aiguillage[aig].Adevie2B:='Z';

      if (triple) then aiguillage[aig].modele:=4;
      if (tjs) then
      begin
        aiguillage[aig].modele:=3
      end;
      if (tjd) then
      begin
        aiguillage[aig].modele:=2 ;
      end;
      if not(tjs) and not(tjd) and not(triple) then
      begin
        aiguillage[aig].modele:=1;
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
      // pr�parer l'enregistrement pour la boucle de ligne
      virgule:=pos(',',s);
      if tjd then enregistrement:=s else
      begin
        enregistrement:=copy(s,1,virgule-1);
        delete(s,1,virgule);
      end;

      Num_Champ:=1;
      itl:=0;
      repeat  // parcoure la ligne
        if (debugConfig) then Affiche('boucle de ligne: '+s,clYellow);
        if (length(enregistrement)<>0) then
        if (enregistrement[1]='P') then
        begin
          inc(Num_Champ);
          if tjd then begin affiche('Erreur P interdit dans une TJD : '+sOrigine,clred);closefile(fichier);exit; end;
          if debugconfig then Affiche('Section P - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          decodeAig(enregistrement,detect,c);
          if c='' then c:='Z';
          aiguillage[aig].Apointe:=detect;
          aiguillage[aig].ApointeB:=c;

          virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
          enregistrement:=copy(s,1,virgule-1);
          delete(s,1,virgule);
          
        end;

        if (length(enregistrement)<>0) then  // section droite
        if (enregistrement[1]='D') then
        begin
          inc(Num_Champ);
          if debugconfig then Affiche('Section D - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;
          if tjd then
          begin
            s:=Enregistrement;
            Delete(s,1,2);
            decodeAig(s,detect,c);
            aiguillage[aig].Adroit:=detect;
            aiguillage[aig].AdroitB:=c;
            i:=pos(',',s);Delete(s,1,i);
            decodeAig(s,detect,c);
            aiguillage[aig].DDroit:=detect;
            aiguillage[aig].DdroitB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);closefile(fichier);exit;end;
            Delete(enregistrement,1,i+1);
            i:=pos(')',s); delete(s,1,i);
            // mettre en forme s
            i:=pos(')',s); delete(s,1,i);
            i:=pos(',',s); delete(s,1,i);

            //Affiche(enregistrement,clBlue);
          end
          else
          begin
            decodeAig(enregistrement,detect,c);
            if c='' then c:='Z';
            aiguillage[aig].Adroit:=detect;
            aiguillage[aig].AdroitB:=c;

            virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
            enregistrement:=copy(s,1,virgule-1);
            delete(s,1,virgule);
          end;
        end;

        if (length(enregistrement)<>0) then
        if (enregistrement[1]='S') then
        begin
          inc(Num_Champ);
          if debugconfig then Affiche('Section S - enregistrement='+enregistrement,clYellow);
          ComptEl:=ComptEl+1;

          if tjd then
          begin
            Delete(enregistrement,1,2);
            decodeAig(enregistrement,detect,c);
            aiguillage[aig].Adevie:=detect;
            aiguillage[aig].AdevieB:=c;
            i:=pos(',',enregistrement);Delete(enregistrement,1,i);
            decodeAig(enregistrement,detect,c);
            aiguillage[aig].DDevie:=detect;
            aiguillage[aig].DDevieB:=c;
            i:=pos(')',enregistrement);if i=0 then begin Affiche('Erreur de syntaxe ligne '+SOrigine,clred);closefile(fichier);exit;end;
            Delete(enregistrement,1,i+1);
            // mettre en forme s
            i:=pos(')',s); delete(s,1,i);
            i:=pos(',',s); delete(s,1,i);

            //Affiche(enregistrement,clBlue);
          end
          else
          begin
            delete(enregistrement,1,1); // supprime le S
            erreur:=pos('2-',enregistrement);
            S2:=erreur<>0;
            if (S2) then delete(enregistrement,erreur,2);

            erreur:=pos('S2',enregistrement); // description d'un rattachement � la branche S2 d'un aiguillage triple
            tec:=erreur<>0;  // ne supprimer que le 2
            if (tec) then delete(enregistrement,erreur+1,1);

            val(enregistrement,detect,erreur);  //  extraction de l'adresse
            //if ((detect=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section S: '+s,clred);
            c:='Z';
            if (erreur<>0) then begin delete(enregistrement,1,erreur-1);c:=enregistrement[1];end;

            if not(S2) and not(tec) then begin aiguillage[aig].Adevie:=detect;aiguillage[aig].AdevieB:=c;end;
            if     S2  and not(tec) then begin aiguillage[aig].Adevie2:=detect;aiguillage[aig].Adevie2B:=c;end;
            if     S2  and     tec  then begin aiguillage[aig].Adevie2:=detect;aiguillage[aig].Adevie2B:='T';end;

            virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
            enregistrement:=copy(s,1,virgule-1);
            delete(s,1,virgule);
          end;
        end;

        // inversion aiguillage
        if (length(enregistrement)<>0) then
          if (Num_champ=5) then
          begin
            if (enregistrement[1]='I')  then
            begin
              inc(Num_Champ);  
              delete(enregistrement,1,1);
            end;
            Val(enregistrement,adr,erreur);
            if erreur<>0 then begin Affiche('Erreur Inversion ; ligne '+sOrigine,clred);closefile(fichier);exit;end;
            enregistrement:='';
            //Affiche(intTostr(adr),clblue);
            Aiguillage[aig].inversionCDM:=adr;
          end;
          
        // si vitesse d�finie
        if Num_Champ=4 then
        begin
          inc(num_champ);
          if (length(enregistrement)<>0) then
          if enregistrement[1]='V' then delete(enregistrement,1,1);
          Val(enregistrement,adr,erreur);
          if (erreur=0) or (erreur=1) then
          begin
            //Affiche('section vitesse d�finie aig='+intToSTR(aig)+'/'+intToSTR(adr),clyellow);
            aiguillage[aig].vitesse:=adr;
            enregistrement:='';
            virgule:=pos(',',s);if virgule=0 then virgule:=length(s)+1;
            enregistrement:=copy(s,1,virgule-1);
            delete(s,1,virgule);
            s:='';//enregistrement:='';
          end;
       end;
       inc(itl);
      until (enregistrement='') or (itl>2);
      if itl>2 then begin Affiche('Erreur 400 ligne '+sOrigine,clred);closefile(fichier);exit;end;
    end;
  until (s='0');
  //Affiche(IntToSTR(maxaiguillage)+' Aiguillages',clYellow);

  Affiche('D�finition des branches',clyellow);
  // branches de r�seau
  NDetecteurs:=0; Nligne:=1;
  i:=1;i_detect:=1;
  repeat
    s:=lit_ligne;
    mod_Branches[Nligne]:=s;inc(Nligne);
    //Affiche(s,clWhite);
 
    if s<>'0' then
    begin
      branche[i]:=s;
      j:=1;offset:=1;
      repeat
        BrancheN[i,j].adresse:=0; // pr�parer le suivant � 0
        offset:=trouve_enregistrement_suiv(i,offset) ;
        // d�coder l'enregistrement
        // si c'est un d�tecteur, fini trouv�
        //affiche(enregistrement,clred);
        Val(enregistrement,detect,erreur);      // d�termine si le champ est num�rique ou pas  (cad si aiguillage)
        //Affiche(enregistrement+'detect='+intToSTR(detect),clyellow);

        // il y a un aiguillage   ou un espace apr�s le champ....en fin de ligne
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
           else erreur:=0; // forcer erreur � 0 pour obliger � passer sur un d�tecteur
        end;

        // d�tecteur
        if erreur=0 then
        begin
           //Affiche(IntToSTR(detect),clyellow);
          //Affiche(s,clorange); Affiche(IntToStr(detect),clorange);
          //if detect=0 then affiche('buttoir'+sOrigine,clyellow);
          BrancheN[i,j].adresse:=detect;          // adresse
          BrancheN[i,j].btype:=1;// ident d�tecteur
          if detect=0 then begin BrancheN[i,j].btype:=4;end; // buttoir
          //if j=1 then Affiche('Erreur la ligne doit commencer par un aiguillage: '+s,clred);
          //if (offset=-1) then Affiche('Erreur la ligne soit se terminer par un aiguillage:'+s,clred);
          // v�rifier si le d�tecteur est d�ja stock�
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
        BrancheN[i,j].adresse:=0; // pr�parer le suivant � 0
        //Affiche('branche '+intToSTR(i)+' index='+intToStr(j),clGreen);
      until (offset=0);
      inc(i);
    end;
  until (s='0');
  NbreBranches:=i-1;
 // Affiche(IntToSTR(NbreBranches)+' branches',clYellow);

  // feux
  Affiche('D�finition des feux',clyellow);
  i:=1;Nligne:=1;
  repeat
    s:=lit_ligne;
    if s<>'0' then
    begin
      chaine:=s;  inc(Nligne);
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
          // feu directionnel ------------------------------------------
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
            // d�codeur
            val(s,adr,erreur);
            Feux[i].decodeur:=adr;
            j:=pos(',',s);Delete(s,1,j);
            //Affiche(s,clYellow);
            //s:='(A19D,A22D)(A19D,A22S)';
            // liste des aiguillages
            k:=1; // num�ro de feu directionnel
            repeat
              // boucle de direction
              delete(s,1,1); // supprimer ( ou le ,
              j:=1; // Nombre de descriptions d'aiguillages dans le feu
              //Affiche('Boucle de Ligne',clyellow);
              //Affiche(s,clOrange);
              repeat
                //Affiche('Boucle de direction',clyellow);
                //Affiche(s,clOrange);
                if s[1]<>'A' then begin Affiche('Erreur a la ligne '+s,clred);exit;end;
                delete(s,1,1);
                val(s,adr,erreur);  // adresse
                c:=s[erreur];       // type
                setlength(feux[i].AigDirection[k],j+1);  // augmenter le tableau dynamique
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
          // feu de signalisation---------------------------------
          begin
            k:=StrToInt(sa); //aspect
            feux[i].aspect:=k;Delete(s,1,j);
            if (k=0) or (k=6) or (k>9) then
            Affiche('Fichier config.cfg: configuration aspect ('+intToSTR(k)+') feu incorrecte � la ligne '+chaine,clRed);
            j:=pos(',',s);
            if j>1 then begin Feux[i].FeuBlanc:=(copy(s,1,j-1))='1';delete(s,1,j);end;
            j:=pos(',',s);
            if j=0 then begin Feux[i].decodeur:=StrToInt(s);end else begin Feux[i].decodeur:=StrToInt(copy(s,1,j-1));delete(s,1,j);end;
            feux[i].Adr_el_suiv1:=0;feux[i].Adr_el_suiv2:=0;feux[i].Adr_el_suiv3:=0;feux[i].Adr_el_suiv4:=0;
            feux[i].Btype_Suiv1:=0;feux[i].Btype_Suiv2:=0;feux[i].Btype_Suiv3:=0;feux[i].Btype_Suiv4:=0;
            feux[i].Adr_det1:=0;feux[i].Adr_det2:=0;feux[i].Adr_det3:=0;feux[i].Adr_det4:=0;
            // �l�ments optionnels des voies suppl�mentaires
            if j<>0 then
            begin
              //Affiche('Entr�e:s='+s,clyellow);
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
                 //Affiche('S avec premier champ supprim�='+s,clyellow);
                 inc(j);
                 if (j=1) then feux[i].Adr_det1:=adr;
                 if (j=2) then feux[i].Adr_det2:=adr;
                 if (j=3) then feux[i].Adr_det3:=adr;
                 if (j=4) then feux[i].Adr_det4:=adr;
                 //type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 
                 t:=0;
                 if s[1]='A' then
                 begin
                   t:=2;
                   //Affiche('d�tect� aiguillage',clyellow);
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
                   //Affiche('d�tect� aiguillage tri',clyellow);
                   if (j=1) then feux[i].Btype_Suiv1:=4;
                   if (j=2) then feux[i].Btype_Suiv2:=4;
                   if (j=3) then feux[i].Btype_Suiv3:=4;
                   if (j=4) then feux[i].Btype_Suiv4:=4;
                 end;

                 if t=0 then //d�tecteur
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
          if (j>4) or (not(multiple)) then begin Affiche('Erreur: fichier de configuration ligne erronn�e : '+chaine,clred); closefile(fichier);exit;end;

          k:=pos(',',s);
          delete(s,1,k);
          //Affiche('s='+s,clyellow);
          feux[i].VerrouCarre:=s[1]='1';
          delete(s,1,1);
          // si d�codeur UniSemaf (6) champ suppl�mentaire
          if Feux[i].decodeur=6 then
          begin
             k:=pos(',',s);
             if k=0 then begin Affiche('Ligne '+chaine,clred);Affiche('Manque d�finition de la cible pour le d�codeur UniSemaf',clred);end
             else
             begin
               Delete(S,1,k);
               Val(s,k,erreur);
               Feux[i].UniSemaf:=k;
             end;
            end;
          end;
          // voir si conditions suppl�mentaires de carr�
          l:=1;  // nombre de parenth�ses
          repeat
            t:=pos('(',s);
            if t<>0 then 
            begin
              //Affiche('Conditions suppl�mentaires pour le feu '+IntToSTR(adresse)+' parenth�se '+intToSTR(l),clyellow);
              k:=pos(')',s);
              sa:=copy(s,t+1,k-t-1); // contient l'int�rieur des parenth�ses sans les parenth�ses
              //Affiche(sa,clLime);
              delete(s,1,k);//Affiche(s,clYellow);
              // boucle dans la parenth�se
              bd:=0;
              repeat
                inc(bd);
                setlength(feux[i].condCarre[l],bd+1);  // une condition en plus
                k:=pos(',',sa); 
                if k<>0 then
                  chaine:=copy(sa,1,k-1)
                  else
                  chaine:=sa;

                if chaine[1]='A' then
                begin
                  delete(chaine,1,1);
                  //Affiche(chaine,ClOrange);
                  val(chaine,adresse,erreur);
                  feux[i].condCarre[l][bd].Adresse:=adresse;
                  if erreur<>0 then feux[i].condCarre[l][bd].PosAig:=chaine[erreur] else
                  Affiche('D�finition du feu '+IntToSTR(feux[i].adresse)+': Manque D ou S dans les conditions de carr� des aiguillages',clred);
                end;
                                 
                k:=pos(',',sa);if k<>0 then delete(sa,1,k);
                //Affiche(sa,clyellow); 
              until k=0;
              //Affiche('Longueur tableau '+IntToSTR(l)+':'+intToSTR(length(feux[i].condCarre[l])),clyellow);
              inc(l);
            end;
          until t=0;  
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

  // raz des actionneurs
  for i:=1 to maxTablo_act do
  begin
    Tablo_actionneur[i].train:='';
    Tablo_actionneur[i].etat:=0;
    Tablo_actionneur[i].actionneur:=0;
    Tablo_actionneur[i].accessoire:=0;
    Tablo_actionneur[i].sortie:=0;
  end;  
  
  // d�finition des actionneurs
  maxTablo_act:=1;
  NbrePN:=0;Nligne:=1;
  repeat        
    s:=lit_ligne;
    // v�rifier si F ou A au 4eme champ
    sa:=s;
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    i:=pos(',',sa);
    if i>0 then delete(sa,1,i) else s:='0';
    
    mod_act[Nligne]:=s;inc(Nligne);

    if length(sa)>1 then if (sa[1]='A') then
    // -----------------accessoire
    begin
      // 815,1,CC406526,A600,1
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
    
    // Passage � niveau
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
      inc(maxTablo_act);
      i:=0;
    end;
    if pos('PN',s)<>0 then i:=0;
  until (s='0');
  dec(maxTablo_act);

  closefile(fichier);
  // v�rification de la coh�rence1
  // parcoure les branches jusqu'� trouver un aiguillage pour voir s'il a �t� d�crit
  for i:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      detect:=BrancheN[i][j].Adresse;
      modele:=BrancheN[i][j].BType;  // 1= d�tecteur  2= aiguillage 3=bis 4=Buttoir
      j:=j+1;
    until ( (modele=1) or (modele=2) or (modele=3) or ((modele=0) and (detect=0)));
    // trouv� un aiguillage et r�cup�r� son adresse dans detect
    //if (type!=1) Display("Erreur aucun d�tecteur dans la d�claration du r�seau\r\n");
    if (modele=1) or (modele=2) or (modele=3) then
    begin
      modele:=aiguillage[detect].modele;
      if (modele=0) then Affiche('Erreur 1: Aiguillage='+intToStr(detect)+' non d�crit mais pr�sent dans la description des branches '+intToStr(i)+'/'+intToSTR(j),clred);
    end;
  end;

  // v�rification de la coh�rence2
  // parcoure les aiguillages pour voir si les d�tecteurs sont en branches des d�tecteurs
  // et les tjd pour voir si pb de coh�rence
  for aig:=1 to maxaiguillage do
  begin
    // tjd
    if aiguillage[aig].modele=2 then
    begin
      if aiguillage[aig].Ddroit<>aiguillage[aig].Ddevie then
        Affiche('Erreur 7: la TJD '+IntToStr(aig)+' a des adresses de destination diff�rentes ('+intToSTR(aiguillage[aig].Ddroit)+' et '+intToSTR(aiguillage[aig].Ddevie)+')',clred);
      // v�rifier si son homologue est une tjd
      adr2:=aiguillage[aig].Ddroit;
      if aiguillage[adr2].modele<>2 then Affiche('Erreur 8: l''aiguillage '+intToStr(Adr2)+' n''est pas une TJD, mais apparait dans la TJD '+IntToSTR(aig),clred);
    end;
    // v�rifier si l'aiguillage est dans les branches
    if aiguillage[aig].modele<>0 then
    begin
      trouve_aiguillage(aig);
      if (IndexBranche_trouve=0) then
        Affiche('Erreur 6: aiguillage '+intToSTR(aig)+' d�crit dans les aiguillages mais absent dans la description des branches',clred);
    end;
    adr:=aiguillage[aig].Adroit;
    if (aiguillage[aig].AdroitB='Z') then
    begin
      trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
      if (IndexBranche_trouve=0) then
        Affiche('Erreur 2: d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clred);
    end;
    adr:=aiguillage[aig].Adevie;
    if (aiguillage[aig].AdevieB='Z') then
    begin
      trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
      if (IndexBranche_trouve=0) then
          Affiche('Erreur 3: d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clRed);
    end;
    adr:=aiguillage[aig].Apointe;
    if ((aiguillage[aig].ApointeB='Z') and (aiguillage[aig].modele=1)) then
    begin
      trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
      if (IndexBranche_trouve=0) then
        Affiche('Erreur 4 : d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clRed);
    end;
    if (aiguillage[aig].modele=4) then // aiguillage triple
    begin
      if (aiguillage[aig].Adevie2B='Z') then
      begin
        adr:=aiguillage[aig].Adevie2;
        trouve_detecteur(adr); // branche_trouve   IndexBranche_trouve
        if (IndexBranche_trouve=0) then
          Affiche('Erreur 5 : d�tecteur '+intToSTR(adr)+' d�crit dans l''aiguillage '+intToSTR(aig)+' mais absent dans la description des branches',clRed);
      end;
    end;
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
procedure trouve_element(el, TypeEl, Offset : integer);
var i,Btype,adr,Branche : integer ;
    s : string;
    sort : boolean;
begin
  //Affiche('cherche'+IntToSTR(el)+'/'+IntToSTR(TypeEl),clred);
  Branche:=Offset;
  branche_trouve:=0;
  IndexBranche_trouve:=0;
  i:=1;
  repeat
    adr:=BrancheN[Branche,i].Adresse;
    Btype:=BrancheN[Branche,i].BType;
       //Affiche(IntToSTR(adr)+'/'+IntToSTR(BType),clred);
    if ((adr=0) and (Btype=0)) then begin inc(Branche);i:=0;end;
    inc(i);
    sort:=(Branche>NbreBranches) or    // 1= d�tecteur  2= aiguillage 3=bis 4=Buttoir
     ((adr=el) and (TypeEl=4) and (Btype=2)) or  //typeEl=4=aig triple
     ((adr=el) and (TypeEl=3) and (Btype=3)) or
     ((adr=el) and (TypeEl=2) and (Btype=2)) or
     ((adr=el) and (TypeEl=1) and (Btype=1)) or
     ((adr=el) and (TypeEl=1) and (Btype=4)) ; //buttoir
  until (sort);
  if (adr=el) then
  begin
    branche_trouve:=Branche;
    IndexBranche_trouve:=i-1;
    //Affiche('trouv�',clgreen);
  end
  else begin s:='Erreur 175 - �l�ment '+intToSTR(el);
         s:=s+' non trouv�';Affiche(s,clred);
         branche_trouve:=0; IndexBranche_trouve:=0;
         if NivDebug>=1 then AfficheDebug(s,clred);
       end;
end;


// renvoie �l�ment suivant entre deux �l�ments quels qu'ils soient mais contigus
// et en variables globales: typeGen le type de l'�l�ment
// s'ils ne sont pas contigus, on aura une erreur
// alg= algorithme :
// 1=arret sur suivant qu'il soit un d�tecteur ou un aiguillage
// 2=arret sur aiguillage en talon mal positionn�
// 3=arret sur un aiguillage pris en pointe d�vi� et AdrDevie contient l'adresse de l'aiguillage d�vi� ainsi que typeGen
// code de sortie : �l�ment suivant ou:
// 9999=erreur fatale ou it�ration trop longue
// 9998= arret sur aiguillage en talon mal positionn�e
// 9997: arr�t sur aiguillage d�vi�
// 9996: arr�t sur position inconnue d'aiguillage
// typeGen : 1=detecteur 2=aiguillage 3=aiguillage bis
function suivant_alg3(prec : integer;typeELprec : integer;var actuel : integer;typeElActuel : integer;alg : integer) : integer;
var  Btype,Adr,AdrPrec,BtypePrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2,TypeEl,N_iteration : integer;
     tjscourbe1,tjscourbe2,tjd,tjs : boolean;
     A,Aprec,tjsc1B,tjsc2B: char;
     s : string;

     procedure substitue;
     begin
       if (typeGen=2) then // si le pr�c�dent est une TJD/S et le suivant aussi , substituer pointe  (chgt de actuel en VAR dans la d�claration de alg3)
        begin
          if ((aiguillage[Adr].modele=2) or (aiguillage[Adr].modele=3)) and
             ((aiguillage[Actuel].modele=2) or (aiguillage[Actuel].modele=3)) then
          begin
            if nivDebug=3 then AfficheDebug('500 - D�tection Pr�c�dent=TJD/S Suivant=TJD/S',clyellow);
            // subsituer la pointe
            Actuel:=aiguillage[Actuel].APointe;
          end;
        end;
      end;


label recommence;
begin
  n_iteration:=0;
  recommence:
  if (prec=29) and (actuel=31) then NivDebug:=3;
  if (TypeELPrec=0) or (typeElActuel=0) then
  begin
    s:='Erreur 800 - Types nuls : '+intToSTR(prec)+'/'+intToSTR(TypeElPrec)+' '+IntToSTr(actuel)+'/'+IntToSTR(typeElActuel) ;
    Affiche(s,clred);
    AfficheDebug(s,clred);
    Suivant_alg3:=9999;exit;
  end;
  if NivDebug=3 then AfficheDebug('Alg3 pr�c�dent='+intToSTR(prec)+'/'+intToStr(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+IntToSTR(typeElActuel),clyellow);
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
  //  if BTypePrec=2 then aiguillage[prec].A

  trouve_element(actuel,typeElActuel,1); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Btype:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

  //Affiche('Btype='+intToSTR(Btype)+' Actuel='+inTToSTR(actuel),clyellow);

  if Btype=1 then  // l'�l�ment actuel est un d�tecteur
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
    if (btypePrec=2) or (btypePrec=3) then
    begin
      // changer l'adresse du pr�c�dent par l'autre adresse de la TJD/S
      prec:=Aiguillage[prec].Ddroit;
      if NivDebug=3 then AfficheDebug('Le pr�cedent est une TJD/S - substitution du prec�dent par la pointe de la TJD qui est '+intToSTR(prec),clYellow);
      inc(n_iteration);
      if n_iteration>50 then
      begin
        s:='Erreur fatale 9999, trop d''it�rations';
        Affiche(s,clRed);
        AfficheDebug(s,clRed);
        suivant_alg3:=9999;
        exit;
      end;
      goto recommence;
    end;

    Affiche('44 - �l�ments non cons�cutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
    if NivDebug=3 then AfficheDebug('44 - �l�ments non cons�cutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
  end;

  if (Btype>=2) then  // aiguillage ou buttoir
  begin
    if (aiguillage[Adr].modele=1) and (Btype=2)  then // aiguillage normal 
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
          A:=aiguillage[Adr].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          trouve_element(adr,typeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[Adr].position<>const_droit then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe d�vi�',clyellow);
          AdrPrec:=Adr;
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
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
          Adr:=aiguillage[Adr].Adevie;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          trouve_element(adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;exit;
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
        if (alg=2) then // on demande d'arreter si l'aiguillage en talon est mal positionn�
        begin
          if aiguillage[adr].position=const_droit then
          begin
            // si TJD (modele=2) sur le pr�c�dent, alors substituer avec la 2eme adresse de la TJD
            if aiguillage[prec].modele=2 then prec:=aiguillage[prec].DDroit;
            if prec<>aiguillage[Adr].Adroit then
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
            if prec<>aiguillage[Adr].Adevie then
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

        AdrPrec:=Adr;
        if Adr=0 then
        begin Affiche('136 - Erreur fatale',clRed);
          if NivDebug>=1 then AfficheDebug('136 - Erreur fatale',clRed);
          suivant_alg3:=9999;exit;
        end;
        BtypePrec:=Btype;
        APrec:=A;
        A:=aiguillage[Adr].ApointeB;
        Adr:=aiguillage[Adr].Apointe;
        //  Affiche('trouv� '+intToSTR(adr),clyellow);
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
        trouve_element(adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        suivant_alg3:=adr;
        exit;
      end;
      Affiche('138 - Erreur fatale - Aucun cas Aiguillage',clred);
      if NivDebug=3 then AfficheDebug('138 - Erreur fatale - Aucun cas Aiguillage',clred);
      suivant_alg3:=9999;exit;
    end;

    if (aiguillage[Adr].modele=2) or (aiguillage[Adr].modele=3) then // TJD ou TJS
    begin
      // r�cup�rer les �lements de la TJD/S
      AdrTjdP:=aiguillage[Adr].Ddroit; // 2eme adresse de la TJD/S
      tjd:=aiguillage[Adr].modele=2;
      tjs:=aiguillage[Adr].modele=3;
      tjsc1:=aiguillage[Adr].tjsint;   // adresses de la courbe de la TJS
      tjsc2:=aiguillage[AdrTjdP].tjsint;
      tjsc1B:=aiguillage[Adr].tjsintB;
      tjsc2B:=aiguillage[AdrTjdP].tjsintB;
      if tjsc1<>0 then  // si tjs
      begin
        tjscourbe1:=(aiguillage[Adr].tjsintB='S') and (aiguillage[tjsc1].position<>const_droit);
        tjscourbe1:=((aiguillage[Adr].tjsintB='D') and (aiguillage[tjsc1].position=const_droit)) or tjscourbe1;
      end;
      if tjsc2<>0 then
      begin
        tjscourbe2:=(aiguillage[AdrTjdP].tjsintB='S') and (aiguillage[tjsc2].position<>const_droit);
        tjscourbe2:=((aiguillage[AdrTjdP].tjsintB='D') and (aiguillage[tjsc2].position=const_droit)) or tjscourbe2;
      end;

      if NivDebug=3 then
      begin
        s:='137 - TJD '+intToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' pos=';
        if aiguillage[Adr].position=const_droit then s:=s+'droit'
        else if aiguillage[Adr].position=const_devie then s:=s+'d�vi�'
          else s:=s+'inconnu' ;
        if aiguillage[AdrTJDP].position=const_droit then s:=s+'/droit'
        else if aiguillage[AdrTJDP].position=const_devie then s:=s+'/d�vi�'
          else s:=s+'/inconnu' ;
        AfficheDebug(s,clyellow);
      end;

      // rechercher le port de destination de la tjd
      Adr2:=0;A:=#0;
      if aiguillage[Adr].position=const_droit then
      begin
        A:=aiguillage[Adr].DDroitB;
        adr2:=aiguillage[Adr].DDroit;
      end;
      if aiguillage[Adr].position=const_devie then
      begin
        A:=aiguillage[Adr].DDevieB;
        adr2:=aiguillage[Adr].DDevie;
      end;
      if nivDebug=3 then Affichedebug('le port de destination de la tjd est '+IntToSTR(adr2)+a,clyellow);

      // extraire l'�l�ment connect� au port de destination de la tjd
      if A='S' then
      begin
        A:=aiguillage[adr2].AdevieB;
        adr2:=aiguillage[adr2].Adevie;
        //Affichedebug('element connect�:'+inttostr(adr)+A,clred);
      end
      else
      if A='D' then
      begin
        A:=aiguillage[adr2].AdroitB;
        adr2:=aiguillage[adr2].Adroit;
      end
      else
      begin
        if aiguillage[adr].position<>9 then
        begin
          s:='Erreur 1021 TJD '+intToSTR(adr)+' non r�solue';
          affichedebug(s,clred);
          Affiche(s,clred);
          suivant_alg3:=9996;
          exit;
        end;
      end;

      if nivDebug=3 then AfficheDebug('tjd: '+s+' Suiv='+intToSTR(adr2)+A,clYellow);
      if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
      suivant_alg3:=adr2;
      exit;

      // determiner la position de la premi�re section de la TJD (4 cas)
      // cas 1 : droit droit
      if (( aiguillage[AdrTJdP].position=const_droit) and
           (aiguillage[Adr].position=const_droit) and tjd)  then
      begin
        // d'o� vient ton sur la tjd
        if aiguillage[Adr].Adroit=prec then
        begin
         
          A:=aiguillage[Adr].DdroitB;
          Adr:=aiguillage[Adr].Ddroit;
          if A='D' then
          begin
             Adr:=aiguillage[AdrTjDP].Adroit;
             A:=aiguillage[AdrTjDP].AdroitB;
          end;
          if A='S' then
          begin
             Adr:=aiguillage[AdrTjDP].Adevie;
             A:=aiguillage[AdrTjDP].AdevieB;
          end;
          if NivDebug=3 then AfficheDebug('cas1.1 tjd: '+s+' Adr='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          suivant_alg3:=adr;
          substitue;
          exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[AdrTjdP].Adroit;
          if NivDebug=3 then AfficheDebug('cas1.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          suivant_alg3:=adr;
          substitue;
          exit;
        end;
        s:='Erreur 1021, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionn�e';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 2 TJD
      if (aiguillage[Adr].position=const_devie)
         and (aiguillage[AdrTjdP].position=const_droit) and tjd then
      begin
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[AdrTJDP].Adroit;
          if NivDebug=3 then AfficheDebug('cas2.1 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        if (aiguillage[Adr].Adroit=prec)  then
        begin
          A:=aiguillage[AdrTJDP].AdevieB;
          Adr:=aiguillage[AdrTjdP].Adevie;
          if NivDebug=3 then AfficheDebug('cas2.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);

          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        s:='Erreur 1022, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionn�e';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 3 TJD
      if (aiguillage[Adr].position=const_droit)
          and (aiguillage[AdrTjdP].position=const_devie) and tjd then
      begin
        // si on vient de
        if (aiguillage[Adr].Adroit=prec) then
        begin
          if NivDebug=3 then AfficheDebug('cas3.1 tjd: '+s,clYellow);
          A:=aiguillage[Adr].DdroitB;
          Adr:=aiguillage[Adr].Ddroit;
          if A='D' then
          begin
             Adr:=aiguillage[AdrTjDP].Adroit;
             A:=aiguillage[AdrTjDP].AdroitB;
          end;
          if A='S' then
          begin
             Adr:=aiguillage[AdrTjDP].Adevie;
             A:=aiguillage[AdrTjDP].AdevieB;
          end;

          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          //substitue;
          suivant_alg3:=adr;
          exit;
        end;
        // si on vient de
        if (aiguillage[Adr].Adevie=prec) then
        begin
          A:=aiguillage[AdrTJDP].AdroitB;
          Adr:=aiguillage[AdrTJDP].Adroit;
          if NivDebug=3 then AfficheDebug('cas3.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        s:='Erreur 1023, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionn�e';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;exit;
      end;
      // cas 4 tjd
      if (aiguillage[Adr].position=const_devie)
         and (aiguillage[AdrTjdP].position=const_devie)  then
      begin
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrtjdP].AdevieB;
          Adr:=aiguillage[AdrtjdP].Adevie;
          if NivDebug=3 then AfficheDebug('cas4.1 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[Adr].Adroit=prec then
        begin
          A:=aiguillage[AdrtjdP].AdevieB;
          Adr:=aiguillage[AdrtjdP].Adevie;
          if NivDebug=3 then AfficheDebug('cas4.2 tjd: '+s+' Suiv='+intToSTR(adr)+A,clYellow);
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          substitue;
          suivant_alg3:=adr;
          exit;
        end;
        s:='Erreur 1024, TJD '+IntToSTR(Adr)+'/'+IntToSTR(AdrTjdP)+' mal positionn�e';
        if nivDebug=3 then AfficheDebug(s,clred);
        Affiche(s,clred);
        Suivant_alg3:=9998;
        exit;
      end;
      // cas TJS prise dans sa position courbe
      if ((aiguillage[Adr].Adevie=Prec) and (aiguillage[Adr].AdevieB=Aprec) and (aiguillage[Adr].position<>const_droit)
        and (aiguillage[AdrTjdP].position=const_droit) and (tjs) and tjscourbe1 and tjscourbe2) then
      begin
        if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
        A:=aiguillage[AdrTjdP].AdevieB;
        Adr:=aiguillage[AdrTjdP].Adevie;
        if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
        substitue;
        suivant_alg3:=adr;
        exit;
      end;
      // cas 3 TJS prise dans sa 2eme position courbe
      if ((aiguillage[Adr].Adroit=Prec) and (aiguillage[Adr].AdroitB=Aprec) and (aiguillage[Adr].position=const_droit)
           and (aiguillage[AdrTjdP].position<>const_droit) and (tjs) and tjscourbe1 and tjscourbe2 ) then
      begin
        if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
        A:=aiguillage[AdrTjdP].AdevieB;
        Adr:=aiguillage[AdrTjdP].Adevie;
        if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
        suivant_alg3:=adr;
        substitue;
        exit;
      end;
      s:='1025 - Erreur fatale - position TJD/S '+IntToSTR(Adr)+'/'+intToSTR(AdrTJDP)+' inconnue';
      Affiche(s,clred);
      AfficheDebug(s,clred);
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
          A:=aiguillage[Adr].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[Adr].position<>const_droit) and (aiguillage[Adr2].position=const_droit)   then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�1 (� gauche)',clYellow);
          A:=aiguillage[Adr].AdevieB;
          Adr:=aiguillage[Adr].Adevie;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        if  (aiguillage[Adr].position=const_droit) and (aiguillage[Adr2].position<>const_droit)  then
        begin
          if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�2 (� droite)',clYellow);
          A:=aiguillage[Adr].Adevie2B;
          Adr:=aiguillage[Adr].Adevie2;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=adr;exit;
        end;
        begin
          if aiguillage[Adr].position=const_inconnu then begin suivant_alg3:=9996;exit;end; // pour �chappement
          s:='Aiguillage triple '+IntToSTR(Adr)+' : configuration des aiguilles interdite';
          if CDM_connecte then s:=s+': '+IntToSTR(aiguillage[Adr].position);
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
          if (aiguillage[adr].position=const_droit) and (aiguillage[adr2].position=const_droit) then
          begin
            if prec<>aiguillage[Adr].Adroit then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionn�',clyellow);
            end;
          end;
          if (aiguillage[adr].position<>const_droit) and (aiguillage[adr2].position=const_droit) then
          begin
            if prec<>aiguillage[Adr].Adevie then
            begin
              if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'triple mal positionn�',clyellow);
              suivant_alg3:=9998;exit;
            end
            else
            begin
              if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'triple bien positionn�',clyellow);
            end;
          end;
          if (aiguillage[adr].position=const_droit) and (aiguillage[adr2].position<>const_droit) then
          begin
            if prec<>aiguillage[Adr].Adevie2 then
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
        A:=aiguillage[Adr].ApointeB;
        Adr:=aiguillage[Adr].Apointe;
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
        trouve_element(Adr,TypeEl,1); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        suivant_alg3:=Adr;exit;
      end;
    end;
  end;
  suivant_alg3:=adr;
end;

// trouve l'index du feu associ� au d�tecteur adr
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


// renvoie l'adresse du d�tecteur suivant des deux �l�ments contigus
// TypeElprec/actuel: 1= d�tecteur  2= aiguillage 4=Buttoir
// algo= type d'algorythme pour suivant_alg3
function detecteur_suivant(prec : integer;TypeElPrec : integer;actuel : integer;TypeElActuel,algo : integer) : integer ;
var actuelCalc,PrecCalc,etat,i,j,AdrSuiv ,
    TypeprecCalc,TypeActuelCalc : integer;
begin
  if NivDebug>=2 then AfficheDebug('Proc Detecteur_suivant '+IntToSTR(prec)+','+IntToSTR(typeElPrec)+'/'+intToSTR(actuel)+','+intToSTR(TypeElActuel),clyellow);
  j:=0;

  PrecCalc:=prec;
  TypeprecCalc:=TypeElprec;
  ActuelCalc:=actuel;
  TypeActuelCalc:=TypeELActuel;
  // �tape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,TypeprecCalc,actuelCalc,TypeActuelCalc,algo);
    if (typeGen=2) and false then // si le pr�c�dent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[AdrSuiv].modele=2) or (aiguillage[AdrSuiv].modele=3)) and
           ((aiguillage[actuelCalc].modele=2) or (aiguillage[ActuelCalc].modele=3)) then
        begin
          if nivDebug=3 then AfficheDebug('501 - D�tection Pr�c�dent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuelCalc:=aiguillage[ActuelCalc].APointe;
        end;
      end;
    precCalc:=actuelCalc;
    TypeprecCalc:=TypeActuelCalc;
    actuelCalc:=AdrSuiv;
    TypeActuelCalc:=typeGen;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=10) or (typeGen=1) or (AdrSuiv=0) or (AdrSuiv>=9996); // arret si d�tecteur

  // si trouv� le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1);
     {if (typeGen=2) then // si le pr�c�dent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[AdrSuiv].modele=2) or (aiguillage[AdrSuiv].modele=3)) and
           ((aiguillage[actuel].modele=2) or (aiguillage[Actuel].modele=3)) then
        begin
          if nivDebug=3 then AfficheDebug('501 - D�tection Pr�c�dent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuel:=aiguillage[Actuel].APointe;
        end;
      end;
      }
  end;
  if (NivDebug=3) and (AdrSuiv<9996) then AfficheDebug('618 : Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// renvoie les adresses des d�tecteurs adjacents au d�tecteur "adresse"
// r�sultat dans adj1 et adj2
procedure Det_Adj(adresse : integer);
var Adr,BtypePrec,AdrFonc,Branche,BtypeFonc,AdrPrec,IndexBranche,i,Dir : integer;
    sortie : boolean;
begin
  if TraceListe then AfficheDebug('Det_Adj '+IntToSTR(adresse),clyellow);
  trouve_element(adresse,1,1); // branche_trouve  IndexBranche_trouve
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
    BtypePrec:=1;

    AdrFonc:=BrancheN[branche,i].Adresse;
    BtypeFonc:=BrancheN[branche,i].BType;

    i:=0;
    repeat
      if BtypeFonc<>1 then
      begin
        Adr:=suivant_alg3(AdrPrec,BtypePrec,AdrFonc,BtypeFonc,2);  // �l�ment suivant mais arret sur aiguillage en talon mal positionn�e
      end
      else
        begin Adr:=AdrFonc;TypeGen:=BtypeFonc;end;
      if Adr>9990 then typeGen:=1;
      if (NivDebug=3) then AfficheDebug('trouv� '+intToSTR(Adr)+' '+intToSTR(typeGen),clorange);
      AdrPrec:=AdrFonc;BtypePrec:=BtypeFonc;
      AdrFonc:=Adr;BtypeFonc:=typeGen;
      i:=i+1;
      sortie:=(i=20) or (Adr=0) or (Adr>=9996) or (TypeGen=1);
    until (sortie) ;   // boucle de parcours
    if (typeGen=1) and (Dir=1) then begin Adj1:=Adr;end;
    if (typeGen=1) and (Dir=2) then begin Adj2:=Adr;end;
    inc(dir);
  until dir=3;
  if TraceListe then AfficheDebug('Fin Det_Adj ',clyellow);
end;

// renvoie l'adresse du d�tecteur suivant des deux �l�ments
// El1 et El2 peuvent �tre s�par�s par des aiguillages, mais de pas plus de 3 d�tecteurs
// en sortie : 9999= det1 ou det2 non trouv�
// 9996 : non trouv�
function detecteur_suivant_El(el1: integer;TypeDet1 : integer;el2 : integer;TypeDet2 : integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,TypePrec,TypeFonc,i1,i2,index,N_det : integer;
    Sortie : boolean;
    s : string;
    label reprise;

begin
  if NivDebug>=2 then
  AfficheDebug('Proc Detecteur_suivant_EL '+intToSTR(el1)+','+intToSTR(Typedet1)+'/'+intToSTR(el2)+','+intToSTR(Typedet2)+'-------------------------',clLime);
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
      AfficheDebug(s,clred);
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
      s:='Test en ';
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
        if (AdrFonc<>0) or (TypeFonc<>0) then Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,1) else
        begin
          Adr:=9999;
        end;
        
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);
        if TypeGen=1 then inc(N_Det);
        if NivDebug=3 then
        begin
          s:='613 : trouv�='+intToSTR(Adr);
          case typeGen of
           1 : s:=s+' detecteur';
           2 : s:=s+' aiguillage';
           3 : s:=s+' aiguillage bis';
           end;
          AfficheDebug(s,clorange);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=((typeDet2=TypeGen) and (Adr=el2)) or (Adr=0) or (Adr>=9996) or (i=15) or (N_Det=Nb_det_dist);
      until sortie ;
      if (i=15) and (Nivdebug=3) then afficheDebug('Pas trouv�',clyellow);
      if (N_det=Nb_det_dist) and (Nivdebug=3) then afficheDebug('D�tecteurs trop distants',clred);
    end

    else
    begin
      // d�ja trouv�
      adr:=el2;typeGen:=TypeDet2;
    end;
  
    if (typeDet2=TypeGen) and (Adr=el2) and (N_Det<>Nb_det_dist) then
    begin
      if Nivdebug=3 then AfficheDebug('614 : Trouv� '+intToSTR(el2),clYellow);
      i:=0;
      repeat
        //AfficheDebug('Engage '+IntToSTR(AdrPrec)+','+IntToSTR(typePrec)+'/'+IntToSTR(AdrFonc)+','+IntToSTR(typeFonc),clyellow);
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,1);
        //AfficheDebug('Sortie Alg3: '+IntToSTR(Adr)+'/'+intToSTR(typeGen),clyellow);

        if NivDebug=3 then
        begin
          s:='614 : trouv�='+intToSTR(Adr);
          case typeGen of
           1 : s:=s+' detecteur';
           2 : s:=s+' aiguillage';
           4 : s:=s+' buttoir';
           end;
          AfficheDebug(s,clorange);
        end;

        AdrPrec:=AdrFonc;TypePrec:=TypeFonc;
        AdrFonc:=Adr;TypeFonc:=typeGen;
        inc(i);
        sortie:=(TypeGen=1) or (Adr=0) or (Adr>=9996) or (i=10);
      until sortie;
    
      if (TypeGen=1) or (TypeGen=4) then
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
function cond_carre(adresse : integer) : boolean;
var i,l,k,NCondCarre,adrAig : integer;
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
      if nivDebug=3 then AfficheDebug('Contr�le aiguillage '+IntToSTR(AdrAig),clyellow);
      resultatET:=((aiguillage[AdrAig].position=const_devie) and (feux[i].condcarre[l][k].PosAig='S') or (aiguillage[AdrAig].position=const_droit) and (feux[i].condcarre[l][k].PosAig='D'))
                and resultatET;
    end;
    //if resultatET then Affiche('VRAI',clyellow) else affiche('FAUX',clred);
    inc(l);
    resultatOU:=resultatOU or resultatET;
    NCondCarre:=Length(feux[i].condcarre[l]);
  end;
  //if resultatOU then Affiche('VRAI final',clyellow) else affiche('FAUX final',clred);
  if NivDebug=3 then
  begin
    s:='Conditions de carr� suivant aiguillages: ';
    if ResultatOU then s:=s+'vrai : le signal doit afficher carr�' else s:=s+'faux : le signal ne doit pas afficher de carr�';
    AfficheDebug(s,clyellow);
  end;
  cond_carre:=ResultatOU;
end;

// renvoi vrai si les aiguillages au del� du signal sont mal positionn�s
function carre_signal(adresse : integer) : boolean;
var
   i,j,prec,AdrFeu,AdrSuiv,actuel,TypeELPrec,TypeElActuel : integer;
   multi, sort  : boolean;
   s : string;
begin
  if (NivDebug>=1) then AfficheDebug('Test si signal '+IntToSTR(adresse)+' doit afficher un carr� si aiguillage avals mal positionn�s',clyellow);

  i:=Index_feu(adresse);
  j:=0;
  prec:=feux[i].Adr_det1;
  TypeElPrec:=1;
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=1 then TypeElActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeElActuel:=2;
  if feux[i].Btype_suiv1=5 then TypeElActuel:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis
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
    {if (typeGen=2) then // si le pr�c�dent est une TJD/S et le suivant aussi
      begin
        if ((aiguillage[AdrSuiv].modele=2) or (aiguillage[AdrSuiv].modele=3)) and
           ((aiguillage[actuel].modele=2) or (aiguillage[actuel].modele=3)) then
        begin
          if nivDebug=3 then AfficheDebug('505 - D�tection Pr�c�dent=TJD/S Suivant=TJD/S',clyellow);
          // subsituer la pointe
          actuel:=aiguillage[actuel].APointe;
        end;
      end;  }

    
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
    AdrFeu:=0;
    if (AdrSuiv>500) then
    begin
      AdrFeu:=index_feu_det(AdrSuiv);
      //Affiche(IntToSTR(AdrFeu),clOrange);
    end;
    sort:=(j=10) or (AdrFeu<>0) or (AdrSuiv=9998) or (AdrSuiv=0); // arret si aiguillage en talon ou buttoir
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
var num_feu,AdrDet,etat,AdrFeu,i,j,prec,AdrSuiv : integer;
    aspect,combine : word;
    TypePrec,TypeActuel : integer;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('Cherche �tat du signal suivant au '+IntToSTR(adresse),clyellow);
  i:=Index_feu(adresse);
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

  if prec=0 then
  begin
    Affiche('Msg 601 - feu '+intToSTR(adresse)+' non renseign� ',clOrange);
    if NivDebug=3 then AfficheDebug('Msg 601 - feu '+intToSTR(adresse)+' non renseign� ',clOrange);
    etat_signal_suivant:=0;
    AdresseFeuSuivant:=0;
    exit;
  end;
  TypePrec:=1;  // d�tecteur
  actuel:=feux[i].Adr_el_suiv1;
  if nivDebug=3 then AfficheDebug('Actuel ='+IntToSTR(actuel),clyellow);
  if feux[i].Btype_suiv1=1 then TypeActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeActuel:=2;
  if feux[i].Btype_suiv1=4 then TypeActuel:=2; // aiguillage triple
  if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis

  repeat
    inc(j);
    if nivDebug=3 then AfficheDebug('It�ration '+IntToSTR(j),clyellow);

    // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
    if (j=1) and (TypeActuel=1) then
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
    if (TypeActuel=1) then  // d�tecteur?
    begin
      i:=Index_feu_det(Actuel);
      AdrFeu:=Feux[i].Adresse;
      if adrFeu<>0 then
      begin
        if nivdebug=3 then afficheDebug('D�tecteur='+IntToSTR(AdrSuiv)+' AdrFeu='+IntToSTR(AdrFeu)+' prec='+IntToSTR(prec),clyellow );
        if (adrFeu=Adresse) then // si on ne reboucle sur le m�me signal dont on cherche le suivant
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
            if NivDebug=3 then AfficheDebug('Trouv� feu suivant Adr='+IntToSTR(AdrFeu)+': '+IntToSTR(etat)+'='+EtatSign[aspect]+' '+EtatSign[combine],clorange);
          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouv� feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
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
  if (NivDebug=3) and (adrFeu=0) then AfficheDebug('Pas Trouv� de feu suivant au feu Adr='+IntToSTR(ADresse),clOrange);
end;


// renvoie l'adresse de l'aiguille si elle est d�vi�e apr�s le signal et ce jusqu'au prochain signal
// sinon renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;
var AdrDet,AdrFeu,etat,i,j,prec,AdrSuiv,Actuel : integer;
    TypePrec,TypeActuel : integer;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('test si aiguille d�vi�e apr�s signal '+IntToSTR(Adresse),clyellow);
  j:=0;
  i:=Index_feu(adresse);
  prec:=feux[i].Adr_det1;
  TypePrec:=1;
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=1 then TypeActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeActuel:=2;
  if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis

  //Affiche(IntToSTR(actuel),clyellow);
  AdrFeu:=0;
  AdrDevie:=0;
  if (TypeActuel=2) or (TypeActuel=3) then  // aiguillage
  begin
    if (aiguillage[actuel].Apointe=prec) and (aiguillage[actuel].position<>const_droit) then Aiguille_deviee:=actuel;
  end;

  repeat
    inc(j);
    // 3=demande si le suivant est un aiguillage en pointe d�vi� oui si AdrSuiv=9997
    // dans ce cas la variable globale AdrDevie est mise � jour
    AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,3);

    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if ADrSuiv<>9997 then
    begin
      prec:=actuel;TypePrec:=TypeActuel;
      actuel:=AdrSuiv;TypeActuel:=typeGen;
      // si le suivant est un d�tecteur comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=1) then  // d�tecteur
      begin
        i:=Index_feu_det(AdrSuiv);
        AdrFeu:=Feux[i].Adresse;
        if NivDebug=3 then AfficheDebug('trouv� signal '+intToSTR(AdrFeu)+' associ� au d�tecteur '+IntToSTR(AdrSuiv),clyellow);
      end;
    end;
  until (j=10) or (AdrSuiv>=9996) or (AdrFeu<>0) ;
  if (AdrSuiv=9997) then
  begin
     s:='le signal '+intToSTR(adresse)+' doit afficher un rappel car l''aiguillage '+intToSTR(AdrDevie);
     if (typeGen=3) then s:=s+'bis';
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

procedure Signal_direction(Adr : integer);
var NAig,i,id,j,NfeuxDir,AdrAigFeu,Position : integer;
    PosAigFeu : char;
    Positionok : boolean;
begin
  id:=Index_feu(Adr);
  NfeuxDir:=feux[id].aspect-10;
  //Affiche(IntToSTR(NfeuxDir),clyellow);
  i:=1;   // i=1 position �teinte du feu ; pour les autres valeurs de i : nombre de feux allum�s
  repeat
    NAig:=length(feux[id].AigDirection[i])-1;
    if i=1 then positionok:=false else positionok:=true;
    for j:=1 to Naig do
    begin
      // v�rifier la position d�clar�e des aiguillages pour chaque feu
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
    dec(i,2);   // i correspond au nombre de feux � allumer
    pilote_direction(Adr,i);
  end;                 

end;

// renvoie vrai si une m�moire de zone est occup�e du signal courant au signal suivant
// adresse=adresse du signal
function test_memoire_zones(adresse : integer) : boolean;
var
  AdrSuiv,prec,TypePrec,TypeActuel,ife,actuel,AdrDet,Etat,AdrFeu,i,j,PresTrain01,PrecInitial,
  N_Det : integer;
  Pres_train,sort : boolean;
  s : string;
begin
  if NivDebug>=1 then AfficheDebug('Proc test_memoire_zones - Cherche m�moire � 1 du signal '+intToSTR(adresse)+' au signal suivant ',clyellow);
  i:=Index_feu(adresse);
  if (i=0) then
  begin
    Affiche('Erreur 650 - feu non trouv�',clred);
    AfficheDebug('Erreur 650 - feu non trouv�',clred);
    test_memoire_zones:=false;
  end;

  Pres_train:=FALSE;
  ife:=1;  // index feu de 1 � 4 pour explorer les 4 d�tecteurs d'un feu
  repeat
    j:=0;
    N_Det:=0;
    if NivDebug=3 then AfficheDebug('Boucle de test feu '+intToSTR(ife)+'/4',clOrange);
    if (ife=1) then
    begin
      prec:=feux[i].Adr_det1;
      actuel:=feux[i].Adr_el_suiv1;
      if feux[i].Btype_suiv1=1 then TypeActuel:=1;
      if feux[i].Btype_suiv1=2 then TypeActuel:=2;
      if feux[i].Btype_suiv1=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=d�tecteur   2=aig  5=bis
    end;  //d�tecteur sur le signal courant
    if (ife=2) then
    begin
      prec:=feux[i].Adr_det2;actuel:=feux[i].Adr_el_suiv2;
      if feux[i].Btype_suiv2=1 then TypeActuel:=1;
      if feux[i].Btype_suiv2=2 then TypeActuel:=2;
      if feux[i].Btype_suiv2=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv2=5 then TypeActuel:=3; // le type du feu   1=d�tecteur   2=aig  5=bis
    end;  // d�tecteur sur le signal courant
    if (ife=3) then
    begin
      prec:=feux[i].Adr_det3;
      actuel:=feux[i].Adr_el_suiv3;
      if feux[i].Btype_suiv3=1 then TypeActuel:=1;
      if feux[i].Btype_suiv3=2 then TypeActuel:=2;
      if feux[i].Btype_suiv3=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv3=5 then TypeActuel:=3; // le type du feu   1=d�tecteur   2=aig  5=bis
    end;  // d�tecteur sur le signal courant
    if (ife=4) then
    begin
      prec:=feux[i].Adr_det4;
      actuel:=feux[i].Adr_el_suiv4;
      if feux[i].Btype_suiv4=1 then TypeActuel:=1;
      if feux[i].Btype_suiv4=2 then TypeActuel:=2;
      if feux[i].Btype_suiv4=4 then TypeActuel:=2; // aiguillage triple
      if feux[i].Btype_suiv4=5 then TypeActuel:=3; // le type du feu   1=d�tecteur   2=aig  5=bis
    end;  // d�tecteur sur le signal courant

    TypePrec:=1;
    if (prec=0) then
    begin
      // sortie si aucun d�tecteur d�clar� sur le feu
      test_memoire_zones:=Pres_train;
      exit;
    end;

    PrecInitial:=Prec;
    repeat
      inc(j);
      // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
      // et cha�ner m�moire de zone
      if (j=1) and (Typeactuel=1) then // si d�tecteur
      begin
        Pres_train:=MemZone[Prec,actuel];
        if Pres_Train and (NivDebug=3) then Affiche('Pr�sence train de '+intToSTR(prec)+' � '+intToSTR(actuel),clyellow);
      end
      else
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          if Typegen=1 then inc(N_Det);
          prec:=actuel;TypePrec:=TypeActuel;
          actuel:=AdrSuiv;TypeActuel:=typeGen;
          if AdrSuiv>9990 then
          begin
            test_memoire_zones:=false;exit;
          end;

         end;

      if NivDebug=3 then AfficheDebug('132 - suivant='+IntToSTR(adrsuiv)+'/'+IntToSTR(TypeGen),clYellow);
      if actuel=0 then
      begin
        // si c'est un buttoir
        test_memoire_zones:=false;
        if NivDebug=3 then AfficheDebug('sortie car buttoir',clyellow);
        exit;
      end;
       // si le suivant est un d�tecteur ; contr�ler m�moire de zone et comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=1) then  // d�tecteur
      begin
        if (NivDebug>0) and MemZone[PrecInitial][actuel] then AfficheDebug('Pr�sence train de '+intToSTR(PrecInitial)+' � '+intToSTR(actuel),clyellow);

        Pres_train:=MemZone[PrecInitial][actuel] or Pres_train; // m�moire de zone
        if Pres_Train then PresTrain01:=1 else PresTrain01:=0;
        if NivDebug=3 then AfficheDebug('de '+IntToSTR(PrecInitial)+' � '+intToSTR(actuel)+'='+IntToSTR(PresTrain01),clyellow);
        precInitial:=actuel; // pour pr�parer le suivant

        i:=index_feu_det(AdrSuiv);  // renvoie l'index du signal se trouvant au d�tecteur "AdrSuiv": il peut y avoir 4 d�tecteurs par signal
        AdrFeu:=feux[i].adresse;    // adresse du feu
        if (AdrFeu=adresse) then  // si on ne reboucle sur le m�me signal dont on cherche le suivant
        begin
          AdrFeu:=0;j:=10; // on ne trouve pas de suivant
        end;
        if (AdrFeu<>0) then // si l'adresse est <>0
        begin
          if (feux[i].Adr_el_suiv1<>prec) then   // le feu est-il dans le bon sens de progression?
          begin
            s:='Trouv� feu '+IntToSTR(AdrFeu);
            if (NivDebug>0) And Pres_Train then AfficheDebug(s+' et sortie proced:M�moire de zone � 1',clyellow);
            if (NivDebug>0) And (not(Pres_Train)) then AfficheDebug(s+' et sortie proced:M�moire de zone � 0',clyellow);
            test_memoire_zones:=Pres_train;exit;

          end
          else
          begin
            if NivDebug=3 then AfficheDebug('Trouv� feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
            AdrFeu:=0;
          end;
        end
        else
        begin
          //if (traceDet) {sprintf(Affiche,"Trouv� d�tecteur %d mais sans signal\r\n",AdrSuiv,Etat);Display(Affiche);
          AdrFeu:=0;
        end;
      end
      else
      begin
        if (NivDebug=3) then AfficheDebug('Trouv� aiguillage '+intToSTR(AdrSuiv),clyellow);
      end;
      sort:=(j=10) or (AdrFeu<>0) or (N_Det>=Nb_det_dist);     
    until (sort);  // on arrete jusqu'� trouver un signal ou si on va trop loin (10 it�rations)
    inc(ife);
  until ife>=5;
  if (NivDebug>0) and (Etat=0) then AfficheDebug('Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);
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
// si >=9996 : pas de route
// si 10 : ok route trouv�e
function test_route_valide(det1,det2,det3 : integer) : integer;
var det_suiv,resultat : integer;
begin
  if TraceListe then AfficheDebug('test route valide '+IntToSTR(det1)+' '+IntToSTR(det2)+' vers '+IntToSTR(det3)+' ',clyellow);
  det_suiv:=detecteur_suivant_el(det1,1,det2,1);
  if det_suiv=det3 then begin test_route_valide:=10;exit;end;

  test_route_valide:=9999;
  exit;
  
  if (det_suiv>=9996) or (det3<>det_suiv) then begin resultat:=0; NivDebug:=0;end;
  // test sens inverse....
  if resultat=0 then
  begin
    test_route_valide:=0;exit;
    // si manipulation proche aiguillage
    det_suiv:=detecteur_suivant_el(det3,1,det2,1);
    if (det_suiv>=9996) or (det1<>det_suiv) then begin test_route_valide:=0; NivDebug:=0;exit;end;
  end;
  test_route_valide:=10 ;
end;


// pr�sence train 3 d�tecteurs avant le feu
function PresTrainPrec(AdrFeu : integer) : boolean;
var PresTrain : boolean;
    j,i,Det_initial,Adr_El_Suiv,Btype_el_suivant,DetPrec1,DetPrec2,DetPrec3,DetPrec4 : integer;
begin
  i:=index_feu(Adrfeu);
  if i=0 then 
  begin
    Affiche('Erreur 602 - feu '+IntToSTR(adrFeu)+' non trouv�',clred);
    if NivDebug=3 then AfficheDebug('Erreur 602 - feu '+IntToSTR(adrFeu)+' non trouv�',clred); 
    PresTrainPrec:=false;
    exit;
  end;
  
  // **** un feu peut �tre associ� � 4 d�tecteurs (pour 4 voies convergentes) *****
  // il faut donc explorer les 4 d�tecteurs probables
  PresTrain:=FALSE;
  j:=1;
 
  repeat
    if NivDebug=3 then afficheDebug('S�quence '+IntToSTR(j)+' de recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
    if (j=1) then
    begin
      det_initial:=feux[i].Adr_det1;Adr_El_Suiv:=feux[i].Adr_el_suiv1;
      if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
      if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
      if feux[i].Btype_suiv1=4 then Btype_el_suivant:=2; // BType_suiv: 1=d�tecteur 2=aig ou TJD ou TJS  4=tri
    end;                                                 // Btye_el_suivant: 1= d�tecteur  2= aiguillage 4=Buttoir
    if (j=2) then
    begin
      det_initial:=feux[i].Adr_det2;Adr_El_Suiv:=feux[i].Adr_el_suiv2;
      if feux[i].Btype_suiv2=1 then Btype_el_suivant:=1;
      if feux[i].Btype_suiv2=2 then Btype_el_suivant:=2;
      if feux[i].Btype_suiv2=4 then Btype_el_suivant:=2;
    end;
    if (j=3) then
    begin
      det_initial:=feux[i].Adr_det3;Adr_El_Suiv:=feux[i].Adr_el_suiv3;
      if feux[i].Btype_suiv3=1 then Btype_el_suivant:=1;
      if feux[i].Btype_suiv3=2 then Btype_el_suivant:=2;
      if feux[i].Btype_suiv3=4 then Btype_el_suivant:=2;
    end;
    if (j=4) then
    begin
      det_initial:=feux[i].Adr_det4;Adr_El_Suiv:=feux[i].Adr_el_suiv4;
      if feux[i].Btype_suiv4=1 then Btype_el_suivant:=1;
      if feux[i].Btype_suiv4=2 then Btype_el_suivant:=2;
      if feux[i].Btype_suiv4=4 then Btype_el_suivant:=2;
    end;
    if (det_initial<>0) then
    begin
      DetPrec1:=detecteur_suivant(Adr_El_Suiv,Btype_el_suivant,det_initial,1,2); // 2= algo2 = arret sur aiguillage en talon mal positionn�
      if nivdebug=3 then afficheDebug('detPrec1='+intToSTR(DetPrec1),clorange);
      if DetPrec1<1024 then // route bloqu�e par aiguillage mal positionn�
      begin             
        if detPrec1<>0 then DetPrec2:=detecteur_suivant_El(det_initial,1,DetPrec1,1) else DetPrec2:=0;
        if nivdebug=3 then afficheDebug('detPrec2='+intToSTR(DetPrec2),clorange);
        if DetPrec2<1024 then
        begin
          if detPrec2<>0 then DetPrec3:=detecteur_suivant_El(DetPrec1,1,DetPrec2,1) else DetPrec3:=0;
          if nivdebug=3 then afficheDebug('detPrec3='+intToSTR(DetPrec3),clorange);
          if DetPrec3<1024 then
          begin
            if detPrec3<>0 then DetPrec4:=detecteur_suivant_El(DetPrec2,1,DetPrec3,1) else DetPrec4:=0;
            if nivdebug=3 then afficheDebug('detPrec4='+intToSTR(DetPrec4),clorange);
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
  PresTrainPrec:=presTrain;
end;


// mise � jour de l'�tat d'un feu en fontion de son environnement et affiche le feu
procedure Maj_Feu(Adrfeu : integer);
var i,j,k1,k2,BtypeSuiv,Adr_det,etat,Adr,Aig,Adr_El_Suiv,
    Btype_el_suivant,det_initial,bt,el_suiv,modele : integer ;
    PresTrain,Aff_semaphore,car : boolean;
    code,combine : word;
    s : string;
begin
  s:='Traitement du feu '+intToSTR(Adrfeu)+'------------------------------------';

  if AffSignal then AfficheDebug(s,clOrange);
  i:=index_feu(Adrfeu);
  if AdrFeu<>0 then
  begin
    modele:=Feux[i].aspect;

    Adr_det:=Feux[i].Adr_det1;  // d�tecteur sur le signal
    Adr_El_Suiv:=Feux[i].Adr_el_suiv1; // adresse �l�ment suivant au feu
    Btype_el_suivant:=Feux[i].Btype_suiv1;

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
      s:='Etat signal suivant ('+intToSTR(AdresseFeuSuivant)+') est ';
      s:=s+' � '+etatSign[code];
      if Combine<>0 then s:=s+' + '+etatSign[combine];
      AfficheDebug(s,clyellow);
    end;
      
    // signaux trait�s sp�cifiquement
    {
    if (AdrFeu=201) then
    begin
      if ((aiguillage[28].position<>const_droit) and (aiguillage[29].position<>const_droit) and
         (aiguillage[31].position=2)) then // attention sp�cial
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
    }

    // signal � 2 feux = carr� violet+blanc
    if (Feux[i].aspect=2) then //or (feux[i].check<>nil) then // si carr� violet
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
    if (Feux[i].aspect>=3) and (EtatSignalCplx[AdrFeu]<>violet_F) then
    begin
      // d�tecteurs pr�c�dent le feu , pour d�terminer si leurs m�moires de zones sont � 1 pour lib�rer le carr�
      if (Feux[i].VerrouCarre) and (Feux[i].aspect>=4)  then presTrain:=PresTrainPrec(AdrFeu);
      
      if AffSignal then afficheDebug('Fin de la recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
      // si le signal peut afficher un carr� et les aiguillages apr�s le signal sont mal positionn�es ou que pas pr�sence train avant signal et signal
      // verrouillable au carr�, afficher un carr�
      car:=carre_signal(AdrFeu);
      // conditions suppl�mentaires de carr� en fonction des aiguillages d�crits
      car:=cond_carre(AdrFeu) or car;
      if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (NivDebug>=1) and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (Feux[i].aspect>=4) and ( (not(PresTrain) and Feux[i].VerrouCarre) or car) then Maj_Etat_Signal(AdrFeu,carre)
      else
      begin
        // si on quitte le d�tecteur on affiche un s�maphore :  attention tester le sens de circulation
        // pour ne pas passer au rouge un feu � contresens.
        // trouver la m�moire de zone MemZone[Adr_det,?] qui a d�clench� le feu rouge
        //if adrFeu=197 then NivDebug:=3;
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
          // si aiguille locale d�vi�e
          Aig:=Aiguille_deviee(Adrfeu);
          if (aig<>0) and (feux[i].aspect>=9) then // si le signal peut afficher un rappel et aiguille d�vi�e
          begin
            if AffSignal then AfficheDebug('Aiguille '+intToSTR(aig)+' d�vi�e',clYellow);
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
    //Maj_feux;
  end
end;

// trouve l'index d'un d�tecteur dans une branche depuis la fin de la branche
// si pas trouv�, renvoie 0
function index_detecteur_fin(det,Num_branche : integer) : integer;
var dernier,i,j : integer;
    trouve : boolean;
    procedure recherche;
    begin
      repeat
        if BrancheN[Num_Branche,i].Btype=1 then   // cherche un d�tecteur
        begin
          j:=BrancheN[Num_Branche,i].adresse;
          trouve:=det=j;
        end;
        if not(trouve) then dec(i);
      until trouve or (j=0)
    end;
begin
  // d�terminer la fin de la branche
  i:=1;
  repeat
     inc(i);
  until (BrancheN[Num_Branche,i].adresse=0) and (BrancheN[Num_Branche,i].btype=0);
  dernier:=i-1;
  //  Affiche('dernier'+intToSTR(dernier),clwhite);
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
  trouve_element(adr,1,1); // branche_trouve  IndexBranche_trouve
  if Branche_trouve=0 then begin buttoir_adjacent:=false;exit;end;
  buttoir_adjacent:=( (BrancheN[branche_trouve,IndexBranche_trouve+1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve+1].BType=4) or 
                      (BrancheN[branche_trouve,IndexBranche_trouve-1].Adresse=0) and (BrancheN[branche_trouve,IndexBranche_trouve-1].BType=4) )
  
end;

// calcul des zones depuis le tableau des fronts descendants des �v�nements d�tecteurs
// transmis dans le tableau Event_det
procedure calcul_zones;
var AdrFeu,AdrDetFeu,Nbre,Nouveau_Det,i,resultat,det1,det2,det3,AdrSuiv,TypeSuiv,AdrPrec : integer ;
    creer_tableau : boolean;
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
        AdrSuiv:=detecteur_suivant_el(det2,1,det3,1); // ici on cherche le suivant � det2 det3
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

          MemZone[det2,det3]:=FALSE;        // efface zone pr�c�dente
          MemZone[det3,AdrSuiv]:=TRUE;      // valide la nouveau zone
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
  end;
  Inc(N_trains);

  
  
  // v�rifier si le d�tecteur du nouveau train est associ� � un feu vers un buttoir
  for i:=1 to NbreFeux do
  begin
    AdrFeu:=Feux[i].Adresse;
    AdrDetfeu:=Feux[i].Adr_Det1;
    if (AdrDetFeu=Det3) and (feux[i].aspect<10) then
    begin
      AdrSuiv:=Feux[i].Adr_el_suiv1;TypeSuiv:=Feux[i].Btype_suiv1;
      AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetFeu,1,1) ; // d�tecteur pr�c�dent le feu ; algo 1
      if AdrPrec=0 then
      begin
        if TraceListe then Affiche('FD - Le feu '+IntToSTR(AdrFeu)+' est pr�c�d� d''un buttoir',clyellow);
        MemZone[0,AdrDetFeu]:=false;
        //NivDebug:=3;
         //AffSignal:=true;
         maj_feu(AdrFeu);
      end;
    end;
  end;

  if TraceListe then AfficheDebug('Cr�ation Train n�'+intToSTR(i),clyellow);
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
procedure Event_act(adr,etat : integer;train : string);
var i,v,va,j,etatAct,Af,Ao,Access,sortie : integer;
    s : string;
    presTrain_PN : boolean;
    Ts : TAccessoire;
begin
  // v�rifier si l'actionneur en �v�nement a �t� d�clar� pour r�agir
  if AffActionneur then Affiche('Actionneur '+intToSTR(Adr)+'='+intToSTR(etat),clyellow);
    
  for i:=1 to maxTablo_act do
  begin
    s:=Tablo_actionneur[i].train;
    etatAct:=Tablo_actionneur[i].etat ;
    // actionneur pour fonction train
    if (Tablo_actionneur[i].actionneur=adr) and (Tablo_actionneur[i].fonction<>0) and ((s=train) or (s='X')) and (etatAct=etat) then
    begin
      Affiche('Actionneur '+intToSTR(adr)+' Train='+train+' F'+IntToSTR(Tablo_actionneur[i].fonction)+':'+intToSTR(etat),clyellow);
      // ex�cutione la fonction F vers CDM
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
      // ex�cution la fonction accessoire vers CDM
      if Tablo_actionneur[i].RAZ then Ts:=aig else Ts:=Feu;
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
        // v�rifier les pr�sences train sur les autres voies du PN
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

Procedure affiche_memoire;
var s: string;
begin
  s:='M�moire �v�nements '+IntToSTR( 100*N_Event_tick div Max_Event_det_tick)+' %';
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
var i,AdrSuiv,AdrFeu,AdrDetfeu,TrainActuel,Etat01,typeSuiv,AdrPrec : integer;
    s : string;
begin
  if Etat then Etat01:=1 else Etat01:=0;
 
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
 
  //if etat then Mem[Adresse]:=true;  // m�moriser l'�tat � 1

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
    for i:=1 to NbreFeux do
    begin
      AdrFeu:=Feux[i].Adresse;
      AdrDetfeu:=Feux[i].Adr_Det1;
      if (AdrDetFeu=Adresse) and (feux[i].aspect<10) then
      begin
        AdrSuiv:=Feux[i].Adr_el_suiv1;TypeSuiv:=Feux[i].Btype_suiv1;
        if AffSignal then AfficheDebug('Pour Feu '+intToSTR(AdrFeu)+' detecteursuivant('+intToSTR(AdrSuiv)+','+IntToSTR(typeSuiv)+','+intToSTR(AdrDetFeu)+',1)',clyellow);
        AdrPrec:=detecteur_suivant(AdrSuiv,typeSuiv,AdrDetFeu,1,1) ; // d�tecteur pr�c�dent le feu, algo 1
        if AdrPrec=0 then
        begin
          If traceListe then AfficheDebug('Le feu '+IntToSTR(AdrFeu)+' est pr�c�d� d''un buttoir',clyellow);
          MemZone[0,AdrDetFeu]:=true;
          maj_feu(AdrFeu);
        end;
      end;

    end;

  end;

  // d�tection fronts descendants
  if ancien_detecteur[Adresse] and not(detecteur[Adresse].etat) and (N_Event_det<Max_event_det) then
  begin
    // si le FD du d�tecteur a d�j� �t� stock� � l'index pr�c�dent ne pas en tenir compte
    //if event_det[N_event_det]<>Adresse then
    begin
      if AffFD then AfficheDebug('index='+intToSTR(N_event_tick)+' FD '+intToSTR(Adresse),clyellow);
      inc(N_event_det);
      event_det[N_event_det]:=Adresse;
      // v�rification de la connaissance de la position de tous les aiguillages au premier �v�nement FD d�tecteur
      if not(PremierFD) then
      begin
        for i:=1 to MaxAiguillage do
        begin
          if aiguillage[i].modele<>0 then
          begin
            if aiguillage[i].position=const_inconnu then
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
    Affiche('D�bordement d''�v�nements FD - Raz tampon',clred);
    N_event_det:=0;
    FormDebug.MemoEvtDet.lines.add('Raz sur d�bordement');
  end;

  // attention � partir de cette section le code est susceptible de ne pas �tre ex�cut�

  // Mettre � jour le TCO
  if AvecTCO then
  begin
    formTCO.Maj_TCO(Adresse);
  end;
end;

// �v�nement d'aiguillage (accessoire)
// pos = const_droit=2 ou const_devie=1
procedure Event_Aig(adresse,pos : integer);
var s: string;
    faire_event,inv : boolean;
    prov,i : integer;
begin
  // v�rifier que l'�v�nement accessoire vient bien d'un aiguillage et pas d'un feu
  i:=0;
  repeat
    inc(i);
  until (i>MaxAiguillage) or (i=adresse);
  if i>MaxAiguillage then exit; // non ce n'est pas un aiguillage, on sort

  // si l'aiguillage est invers� dans CDM et qu'on est en mode autonome, inverser sa position
  inv:=false;
  if (aiguillage[adresse].inversionCDM=1) then // and (portCommOuvert or parSocketLenz) then
  begin
    prov:=pos;
    inv:=true;
    if prov=const_droit then pos:=const_devie else pos:=const_droit;
  end;

  // ne pas faire l'�valuation si l'ancien �tat de l'aiguillage est ind�termin�e (9)
  // car le RUN vient de d�marrer
  faire_event:=aiguillage[adresse].position<>9;
  aiguillage[adresse].position:=pos;

  // ------------- stockage �v�nement aiguillage dans tampon event_det_tick -------------------------
  if (N_Event_tick>=Max_Event_det_tick) then
  begin
    N_Event_tick:=0;
    Affiche('Raz Evts ',clLime);
  end;
  s:='Tick='+IntToSTR(tick)+' Evt Aig '+intToSTR(adresse)+'='+intToSTR(pos);
  if pos=const_droit then s:=s+' droit' else s:=s+' d�vi�';
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

  // Mettre � jour le TCO
  if AvecTCO then
  begin
    formTCO.Maj_TCO(Adresse);
  end;

  // l'�valuation des routes est � faire selon conditions
  if faire_event then evalue;
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
var  groupe,temps : integer ;
     fonction : byte;
     s : string;
label mise0;
begin
  //Affiche(IntToSTR(adresse)+' '+intToSTr(octet),clYellow);

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

  // pilotage par USB ou par �thernet de la centrale ------------
  if (hors_tension2=false) and (portCommOuvert or parSocketLenz) then
  begin
    // test si pilotage aiguillage invers�
    if (acc=aig) and (aiguillage[adresse].inversion=1) then
    begin
      if octet=1 then octet:=2 else octet:=1;
    end;

    if (octet=0) or (octet>2) then exit;

    groupe:=(adresse-1) div 4;
    fonction:=((adresse-1) mod 4)*2 + (octet-1);
    // pilotage � 1
    s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
    s:=checksum(s);
    if debug_dec_sig and (acc=feu) then AfficheDebug('Tick='+IntToSTR(Tick)+' signal '+intToSTR(adresse)+' '+intToSTR(octet),clorange);
    envoi(s);     // envoi de la trame et attente Ack

    // si l'accessoire est un feu et sans raz des signaux, sortir
    if (acc=feu) and not(Raz_Acc_signaux) then exit;

    // si aiguillage, faire une temporisation
    //if (index_feu(adresse)=0) or (Acc=aig) then
    if Acc=Aig then
    begin
      temps:=aiguillage[adresse].temps;if temps=0 then temps:=4;
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
  if acc=aig then event_aig(adresse,octet);
end;


// le d�codage de la r�tro est appell�e sur une r�ception d'une trame de la r�trosignalisation de la centrale.
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
    Affiche('Chaine non document�e recue: '+chaine_HEX(chaineINT),clred);
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
  affiche('Erreur 7, cha�ne r�trosig. inconnue recue:'+chaine_HEX(chaineINT),clred);
  decode_chaine_retro:='';
end;

// proc�dure appell�e apr�s r�ception sur le port USB ou socket
procedure interprete_reponse(chaine : string);
var chaineInt,msg : string;
    i,cv : integer;

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
// transforme une cha�ne 0A FF CA.. en chaine d'octets
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
      With Formprinc.MSCommUSBLenz do
      begin
        i:=pos(':',portCom);
        j:=pos(',',PortCom);
        j:=posEx(',',PortCom,j+1);
        j:=posEx(',',PortCom,j+1);
        j:=posEx(',',PortCom,j+1);

        confStCom:=copy(portCom,i+1,j-i-1); //Affiche(ConfStCom,clred);
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
var
    hSnapShot : THandle;
    ProcessEntry32 : TProcessEntry32;   // pointeur sur la structure ProcessEntry32
    processID : DWord;
begin
  Result:=false;
  hSnapShot:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  Win32Check(hSnapShot <> INVALID_HANDLE_VALUE);

  sExeName:=LowerCase (sExeName);
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


// pr�paration du tampon pour SendInput
procedure KeybdInput(VKey: Byte; Flags: DWORD);
begin
  SetLength(KeyInputs, Length(KeyInputs)+1);
  KeyInputs[high(KeyInputs)].Itype := INPUT_KEYBOARD;
  with KeyInputs[high(KeyInputs)].ki do
  begin
    wVk:=VKey;
    wScan:=MapVirtualKey(wVk, 0);
    dwFlags:=Flags;
  end;
end;



procedure SendKey(Wnd,VK : Cardinal; Ctrl,Alt,Shift : Boolean);
var
  MC,MA,MS : Boolean;
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
    Lance_CDM:=true;
    if CDM_connecte then exit;
    deconnecte_USB;
    connecte_CDM;
    exit;
  end;

  Affiche('Lancement de CDM '+lay,clyellow);
  cdm_lanceLoc:=false;
  // lancement depuis le r�pertoire 32 bits d'un OS64
  if ShellExecute(Formprinc.Handle,
                    'open',PChar('C:\Program Files (x86)\CDM-Rail\cdr.exe'),
                    Pchar('-f '+lay),  // param�tre

                    PChar('C:\Program Files (x86)\CDM-Rail\')  // r�pertoire
                    ,SW_SHOWNORMAL)>32 then 
                    begin
                      cdm_lanceLoc:=true;
                      //Affiche('lanc�1',clyellow);
                    end;  

  if not(cdm_lanceLoc) then
  begin
    // si �� marche pas essayer depuis le r�pertoire de base sur un OS32
    Affiche('2eme lancement',clyellow);
    if ShellExecute(Formprinc.Handle,
                    'open',PChar('C:\Program Files\CDM-Rail\cdr.exe'),
                    Pchar('-f '+lay),  // param�tre
                    PChar('C:\Program Files\CDM-Rail\')  // r�pertoire
                    ,SW_SHOWNORMAL)<=32 then
    begin
      ShowMessage('r�pertoire CDM rail introuvable');
      lance_CDM:=false;exit;
    end;
    cdm_lanceLoc:=false;
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


procedure TFormPrinc.FormCreate(Sender: TObject);
var
   i,j : integer;
   s,s2,Url,LocalFile : string;
   trouve,AvecMaj : Boolean;
   V_utile : real;
   CibleHandle : Thandle;
begin
  //DoubleBuffered:=true;
  TraceSign:=True;
  PremierFD:=false;
  // services commIP CDM par d�faut
  Srvc_Aig:=true;
  Srvc_Det:=true;
  Srvc_Act:=true;
  Srvc_PosTrain:=false;
  Srvc_sig:=false;
  
  AF:='Client TCP-IP CDM Rail ou USB - syst�me XpressNet - Version '+Version;
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
  TempoAct:=0;
  debugtrames:=false;

  AvecInit:=true; //&&&&
  Option_demarrage:=false;
  Diffusion:=AvecInit;

  Application.processMessages;
  // cr��e la fenetre v�rification de version
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

  // Train[1].index:=0;

  // lecture fichiers de configuration  client_GL.cfg et config.cfg
  lit_config;
  Application.processMessages;

  // lancer CDM rail et le connecte si on le demande
  if LanceCDM then Lance_CDM;
  ButtonAffTCO.visible:=AvecTCO;
  Loco.Visible:=not(Diffusion);

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

  if not(diffusion) then LireunfichierdeCV1.enabled:=true;

  // ajoute les images des feux dynamiquement
  for i:=1 to NbreFeux do
  begin
    cree_image(i);  // et initialisation tableaux signaux
  end;
  Tempo_init:=5;  // d�marre les initialisation des signaux et des aiguillages dans 1 s

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
  //---------------------------------
  {
    aiguillage[6].position:=const_devie;
    aiguillage[4].position:=const_droit;
    aiguillage[3].position:=const_droit;
    aiguillage[1].position:=const_devie;
    aiguillage[26].position:=const_droit;
    aiguillage[28].position:=const_devie;
    
    if buttoir_adjacent(515) then affiche('oui',clred);
    
  
    NivDebug:=3;
    FormDebug.show;
    //i:=Detecteur_suivant_El(591,1,602,1);
    //i:=Detecteur_suivant_El(597,1,601,1);
    // posent pb:
   // i:=Detecteur_suivant_El(598,1,599,1);
    i:=Detecteur_suivant_El(520,1,20,2);
   // AfficheDebug(IntToSTR(i),clyellow);
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
end;


// positionnement des aiguillages au d�marrage : seulement en mode autonome
procedure init_aiguillages;
var i,pos : integer;
    s : string;
begin
  if portCommOuvert or parSocketLenz then
  begin
    Affiche('Positionnement aiguillages',cyan);
    for i:=1 to maxaiguillage do
    begin
      if aiguillage[i].modele<>0 then // si l'aiguillage existe
      begin
        pos:=aiguillage[i].position;
        s:='Init aiguillage '+intToSTR(i)+'='+intToSTR(pos);
        if pos=1 then s:=s+' (d�vi�)' else s:=s+' (droit)';
        Affiche(s,cyan);
        pilote_acc(i,pos,aig);
        sleep(Tempo_Aig);
        application.processMessages;
      end;
    end;  
  end;
end;

// timer � 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var index,aspect,i,a,x,y,x0,y0,Bimage,adresse,TailleX,TailleY,orientation : integer;
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

  pilote_acc(adr,const_droit,aig);
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

  pilote_acc(adr,const_devie,aig);
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

// erreur sur socket Lenz
procedure TFormPrinc.ClientSocketLenzError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
var   s : string;
begin
   s:='Erreur '+IntToSTR(ErrorCode)+' socket IP Lenz';
   case ErrorCode of
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par tiers';
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

// proc�dure Event appel�e si on clique sur un checkbox des images des feux
procedure TFormprinc.proc_checkBoxFB(Sender : Tobject);
var Index,adr : integer;
    coche : boolean;
begin
  Maj_feux ;              // �value l'�tat des signaux
end;


procedure TFormPrinc.ButtonInfoClick(Sender: TObject);
begin
  Affiche('Ce programme pilote des signaux complexes de fa�on autonome ou avec CDM rail ',ClYellow);
  Affiche('En fonction des d�tecteurs mis � 1 ou 0 par des locomotives',ClYellow);
  Affiche('en circulation sur le r�seau',ClYellow);
  Affiche('Il est n�cessaire de renseigner les fichiers config.cfg et config-gl.cfg',ClOrange);
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
    Affiche('Demande de connexion de l''interface Lenz en ethernet '+AdresseIP+':'+IntToSTR(Port),clyellow);
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
var j,adr,NBranche : integer;
    s : string;
begin
  for j:=1 to NDetecteurs do
  begin
   adr:=Adresse_detecteur[j];
   s:='D�t '+intToSTR(adr)+'=';
   if Detecteur[adr].etat then s:=s+'1' else s:=s+'0';
   s:=s+' '+Detecteur[Adr].train;
   //s:=s+' Mem=';
   //if Mem[adresse_detecteur[j]] then s:=s+'1' else s:=s+'0';
   Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Etatdesaiguillages1Click(Sender: TObject);
var i,j,model : integer;
    s : string;
begin
  for i:=1 to MaxAcc do
  begin
    model:=aiguillage[i].modele ;
    if model<>0 then
    begin
      s:='Aiguillage '+IntToSTR(i)+' : '+intToSTR(aiguillage[i].position);
      if aiguillage[i].position=const_devie then s:=s+' (d�vi�)' ;
      if aiguillage[i].position=const_droit then s:=s+' (droit)';
      if aiguillage[i].position=const_inconnu then s:=s+' inconnue';
      
      if model=4 then // aig triple
      begin
        j:=aiguillage[i].AdrTriple;
        s:=s+' Aig '+IntToSTR(j)+': '+intToSTR(aiguillage[j].position);
        if aiguillage[j].position=1 then s:=s+' (d�vi�)' else s:=s+' (droit)';
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
  Affiche('D=position droite S=position d�vi�e P=pointe Z=d�tecteur',Cyan);
  for i:=1 to MaxAiguillage do
  begin
    s:=IntToSTR(i);
    if aiguillage[i].modele<>0 then
    begin
      if aiguillage[i].modele=1 then s:=s+' Pointe=';
      if aiguillage[i].modele=2 then 
      begin
        s:=s+' TJD:';
        if aiguillage[i].inversionCDM=1 then s:=s+'(INV) ';
      end;  
      if aiguillage[i].modele=3 then s:=s+' TJS:';
      if aiguillage[i].modele=4 then s:=s+' Triple: Pointe=';
      
      if (aiguillage[i].modele=1) or (aiguillage[i].modele=4) then s:=s+IntToSTR(aiguillage[i].APointe)+aiguillage[i].APointeB;
      s:=s+' D�vie='+IntToSTR(aiguillage[i].ADevie)+aiguillage[i].ADevieB+
         ' Droit='+IntToSTR(aiguillage[i].ADroit)+aiguillage[i].ADroitB;
      if aiguillage[i].modele=2 then
      begin
        s:=s+' DestDroit='+intToSTR(aiguillage[i].Ddroit)+aiguillage[i].DdroitB;
        s:=s+' DestD�vi�='+intToSTR(aiguillage[i].DDevie)+aiguillage[i].DdevieB;
      end;
      if aiguillage[i].modele=4 then s:=s+' D�vi�2='+intToSTR(aiguillage[i].ADevie2)+aiguillage[i].ADevie2B;
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
  SocketCDM_connecte:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  DeConnecterCDMRail.enabled:=true;
end;

procedure Interprete_trameCDM(trame_CDM:string);
var i,j,objet,posST,posAC,posDT,posSG,posXY,k,l,erreur, adr,adr2,etat,etataig,
    vitesse,etatAig2,name,prv,nbre,nbreVir,long : integer ;
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
    if pos('ERR=200',trame_CDM)<>0 then Affiche('Erreur CDM : r�seau non charg�',clred);
  end;

  k:=0;
  //Affiche('L='+InTToSTR(length(recuCDM)),clyellow);
  repeat
    // trouver la longueur de la cha�ne de param�tres
    i:=pos('|',trame_CDM);
    val(copy(trame_CDM,i+1,5),long,erreur);
    //Affiche('long chaine param='+intToSTR(long),clyellow);
    if long=0 then
    begin
      //if debugTrames then Affiche('Longueur nulle',clYellow);
      if pos('ACK',trame_cdm)<>0 then Ack_cdm:=true;
      i:=posEx('|',trame_CDM,i+1);
      if i=0 then begin Affiche('Erreur trames CDM manque 2�me |',clred);exit;end;
      delete(trame_cdm,1,i);
    end;

    if long<>0 then
    begin
      // trouver le nombre de param�tres
      i:=posEx('|',trame_CDM,i+1);
      if i=0 then
      begin
        if debugTrames then AfficheDebug('0 param�tres '+trame_CDM,clyellow);
        Nbre_recu_cdm:=0;
        exit;
      end;

      val(copy(trame_CDM,i+1,5),nbre,erreur);
      //Affiche('nbre='+IntToSTR(nbre),clyellow);
      // compter le nombre de virgules qui doit �tre �gal au nombre de param�tres
      NbreVir:=0;  // nombre de virgules
      repeat
        i:=posEx(';',trame_CDM,i+1);
        if i<>0 then inc(NbreVir);
      until (i=0) or (NbreVir=nbre);
      if i=0 then
      begin
        if debugTrames then AfficheDebug('tronqu� : '+trame_CDM,clyellow);
        residuCDM:=trame_CDM;
        Nbre_recu_cdm:=0;
        exit;
      end;

      CommandeCDM:=copy(trame_CDM,1,i);
      if debugTrames then AfficheDebug(commandeCDM,clorange);
      Delete(trame_CDM,1,i);

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

        // aiguillage normal
        if aiguillage[adr].modele=1 then
        begin
          //Affiche('Normal',clyellow);
          if etat=const_droit_CDM then etatAig:=const_droit else etatAig:=const_devie;
          Event_Aig(adr,etatAig);
        end;

        // TJD TJS
        if (aiguillage[adr].modele=2) or (aiguillage[adr].modele=3) then
        begin
          //Affiche('TJD/S',clyellow);
          //adr2:=aiguillage[adr].Apointe;  // 2eme adresse de la TJD
          case etat of
          1 : begin etatAig:=const_devie;EtatAig2:=const_droit;end;
          4 : begin etatAig:=const_devie;EtatAig2:=const_devie;end;
          5 : begin etatAig:=const_droit;EtatAig2:=const_devie;end;
          0 : begin etatAig:=const_droit;EtatAig2:=const_droit;end;
          end;
          if (aiguillage[adr].inversionCDM=1) or (aiguillage[adr2].inversionCDM=1) then
          begin
            //Affiche('inverse',clyellow);
            prv:=adr;
            adr:=adr2;
            adr2:=prv;
          end;
          Event_Aig(adr,etatAig);
          Event_Aig(adr2,etatAig2);
        end;
        if aiguillage[adr].modele=4 then // aiguillage triple
        begin
          //Affiche('Triple',clyellow);
          // �tat de l'aiguillage 1
          if (etat=0) or (etat=2) then etatAig:=2;
          if etat=3 then etatAig:=1;
          // �tat de l'aiguillage 2
          adr2:=aiguillage[adr].AdrTriple;
          if (etat=0) or (etat=3) then etatAig2:=2;
          if etat=2 then etatAig2:=1;
          Event_Aig(adr,etatAig);
          Event_Aig(adr2,etatAig2);
        end;
      //  Tempo_chgt_feux:=10; // demander la mise � jour des feux
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
        //AfficheDebug(IntToSTR(adr)+' '+IntToSTR(etat),clyellow);
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
        //Affiche('SignalCDM '+intToSTR(adr)+'='+IntToStr(etat),clYellow);
      end ;

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
        Event_act(adr,etat,train); // d�clenche �vent actionneur
      end;

      // �v�nement position des trains - non stock� ni interpr�t�
      posXY:=pos('CMDTRN-SPDXY',commandeCDM);
      if posXY<>0 then
      begin
        Delete(commandeCDM,posXY,12);
        i:=posEx('AD=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+3,10);
        val(ss,adr,erreur);
        //Affiche('AD='+IntToSTR(adr),clyellow);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('NAME=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        train:=copy(commandeCDM,i+5,l-i-5);
        //Affiche('Train='+train,clyellow);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('SPEED=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+6,10);
        val(ss,vitesse,erreur);
        //Affiche('Vitesse='+intToSTR(vitesse),clyellow);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('X=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+2,10);
        val(ss,x,erreur);
        //Affiche('X='+IntTostr(x),clyellow);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('Y=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+2,10);
        val(ss,y,erreur);
        //Affiche('Y='+IntTostr(y),clyellow);;
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('X2=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+3,10);
        val(ss,x2,erreur);
        //Affiche('X2='+IntTostr(x2),clyellow);
        Delete(commandeCDM,i,l-i+1);

        i:=posEx('Y2=',commandeCDM,posXY);l:=posEx(';',commandeCDM,i);
        ss:=copy(commandeCDM,i+3,10);
        val(ss,y2,erreur);
        //Affiche('Y2='+IntTostr(y2),clyellow);
        Delete(commandeCDM,i,l-i+1);

        Delete(commandeCDM,posXY,12);
      end;

      inc(k);
      //Affiche('k='+intToSTR(k),clyellow);
    end;

    sort:=(length(trame_CDM)<10) or (k>=2000);// or (posST=0) and (posDT=0) and (posAC=0) and (posSG=0);
  until (sort);

  //Affiche('k='+IntToSTR(k)+' Ligne trait�e '+recuCDM,clLime);
  //if pos('_ACK',recuCDM)=0 then recuCDM:=''; // effacer la trame sauf si c'est une trame ACK car le trame est utilis�e dans le process de connexion de cdm
  if k>=2000 then begin Affiche('Erreur 90 : Longrestante='+IntToSTR(length(trame_CDM)),clred); Affiche(trame_CDM,clred);  end;

  Nbre_recu_cdm:=0;
end;

// r�ception d'un message de CDM rail
procedure TFormPrinc.ClientSocketCDMRead(Sender: TObject;Socket: TCustomWinSocket);
  var i,l,n : integer ;
      s,ss,train : string;
      traite,sort : boolean;
begin
  inc(Nbre_recu_cdm);
  //if Nbre_recu_cdm>1 then Affiche('Empilement de trames CDM: '+intToSTR(Nbre_recu_cdm),clred);
  recuCDM:=ClientSocketCDM.Socket.ReceiveText;  // commandeCDM est le morceau tronqu�e de la fin de la r�ception pr�c�dente

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
  Affiche('CDM rail d�connect�',Cyan);
  AfficheDebug('CDM rail d�connect�',Cyan);
  caption:=AF;
  CDM_connecte:=False;
  SocketCDM_connecte:=false;
  MenuConnecterUSB.enabled:=true;
  DeConnecterUSB.enabled:=true;
  ConnecterCDMRail.enabled:=true;
end;


procedure TFormPrinc.Codificationdesfeux1Click(Sender: TObject);
var i,j,k,l,CondCarre,NfeuxDir,adresse : integer;
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
      s:=s+' SIG Nbre de feux='+IntToSTR(feux[i].aspect)+' ';
      s:=s+' El_Suivant1='+IntToSTR(feux[i].Adr_el_suiv1)+' Type suivant1='+intToSTR(feux[i].Btype_suiv1);
      case feux[i].Btype_suiv1 of
      1 : s:=s+' (d�tecteur)';
      2 : s:=s+' (aiguillage ou TJD-S)';
      4 : s:=s+' (aiguillage triple)';
      5 : s:=s+' (aiguillage bis)';
      end;
      if feux[i].decodeur=6 then
      s:=s+' Cible unisemaf='+intToSTR(feux[i].Unisemaf);

      // conditions sur carr�
      CondCarre:=Length(feux[i].condcarre[1]);
      l:=1;
      s2:='';
      while condCarre<>0 do
      begin
        if condcarre<>0 then dec(condcarre);
        for k:=1 to condCarre do
        begin
          s2:=s2+'A'+IntToSTR(feux[i].condcarre[l][k].Adresse)+feux[i].condcarre[l][k].PosAig+' ';
        end;
        s2:=s2+'/';
        inc(l);
        CondCarre:=Length(feux[i].condcarre[l]);
      end;
      
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
    fte : textfile;
    i,cv,valeur,erreur : integer;
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
  formconfig.showmodal;
  formconfig.close;
end;


procedure TFormPrinc.Codificationdesactionneurs1Click(Sender: TObject);
var i,adract,etatAct,fonction,v,acc,aO,aF,accessoire,sortie : integer;
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
    s:='PN'+intToSTR(i)+'          Adresse fermeture PN='+IntToSTR(Tablo_PN[i].AdresseFerme);
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
var hd : THandle;
begin
  formTCO.windowState:=wsNormal; //Maximized;
  formTCO.BringToFront;
end;


procedure TFormPrinc.ButtonLanceCDMClick(Sender: TObject);
begin

 // ButtonArretSimu.Setfocus;
  Lance_CDM ;
//  ButtonLanceCDM.unfocused;
  
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

// pour d�placer l'ascenseur de l'affichage automatiquement en bas
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
  Affiche('Signaux complexes GL version '+version+' (C) 2020 F1IWQ Gily TDR',clWhite);
  Affiche('http://cdmrail.free.fr/ForumCDR/viewtopic.php?f=77&t=3906',clWhite);
  Affiche('https://github.com/f1iwq2/Signaux_complexes_GL',clWhite);
  Affiche(' ',clyellow);  
  
end;

begin




end.
