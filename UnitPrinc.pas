Unit UnitPrinc;
(********************************************
   programme direct signaux complexes
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
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls, 
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
    LireunaccessoireversunfichierdeCV1: TMenuItem;
    SaveDialog: TSaveDialog;
    N5: TMenuItem;
    Quitter1: TMenuItem;
    EditGenli: TEdit;
    Button1: TButton;
    Button2: TButton;
    Config: TMenuItem;
    Label1: TLabel;
    LabelNbTrains: TLabel;
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
    procedure LireunaccessoireversunfichierdeCV1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ConfigClick(Sender: TObject);

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
tempoFeu = 100;
MaxAcc = 2048;
LargImg=50;HtImg=91;
const_droit=2;const_devieD=1;  // positions transmises par la centrale LENZ
const_devieG=3;   
MaxElParcours=4000;


EtatSign : array[0..13] of string[20] =('carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');

type TBranche = record
               BType : integer ;   // 1= d�tecteur  2= aiguillage 3=bis 4=Buttoir
               Adresse : integer ; // adresse du d�tecteur ou de l'aiguillage
            end;

     Taiguillage = record
                 modele : integer;          // 0=n'existe pas  1=aiguillage 2=TJD 3=TJS 4=aiguillage triple
                 position,                  // position actuelle : 1=d�vi�  2=droit
                 Adrtriple,
                 temps,                     // temps de pilotage (dur�e de l'impulsion en x 100 ms)
                 inversion : integer;       // pilotage invers� 0=normal 1=invers�
                 vitesse : integer;         // vitesse de franchissement de l"aiguillage en position d�vi�e (60 ou 90)

                 ADroit : integer ;         // (identifiant ext�rieur � la TJD) connect� sur la position droite en talon
                 ADroitB : char ;           // id de branche pour TJD
                 ADroitBis : integer ;      // 0=pas connect� � aiguillage dont l'adresse est bis  =1 connect� � un aig bis

                 ADevie : integer ;         // (identifiant ext�rieur) adresse de l'�l�ment connect� en position d�vi�e
                 ADevieB : char;            // caract�re (D ou S)si aiguillage de l'�l�ment connect� en position d�vi�e
                 AdevieBis : integer ;      // 0=pas connect� � aiguillage dont l'adresse est bis  =1 connect� � un aig bis

                 APointe : integer;         // adresse de l'�l�ment connect� en position droite ; pour les TJD : adresse de l'autre tjd
                 APointeB : char;
                 ApointeBis : integer;      // 0=pas connect� � aiguillage dont l'adresse est bis  =1 connect� � un aig bis

                 tjsint   : integer;
                 tjsintb  : char ;

                  // �l�ments connect�s sur la branche d�vi�e 2 (cas d'un aiguillage triple)
                 Adevie2 : integer;
                 Adevie2B : char ;
                 Adevie2Bis : integer;

                end;

Taccessoire     = (aig,feu);
TMA             = (valide,devalide);


var ancien_tablo_signalCplx,EtatsignalCplx : array[0..MaxAcc] of word;
    AvecInitAiguillages,tempsCli,combine,NbreFeux,pasreponse,AdrDevie,precedent ,
    NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
    Nbre_recu_cdm,Tempo_chgt_feux,Adj1,Adj2,protocole : integer;
    Hors_tension2,traceSign,TraceZone,Ferme,parSocket,ackCdm,
    NackCDM,MsgSim : boolean;
    TraceListe,clignotant,nack,Maj_feux_cours : boolean;

    branche : array [1..100] of string;

const
  ClBleuClair=$FF7070 ;
  Cyan=$FFA0A0;
  clviolet=$FF00FF;
  GrisF=$414141;
  clOrange=$0077FF;
  Feu_X=50;Feu_Y=91;
  couleurTrain : array[1..8] of Tcolor = (clYellow,clLime,clOrange,clAqua,clFuchsia,clLtGray,clred,clWhite);
  
var
  FormPrinc: TFormPrinc;
  ack,portCommOuvert,trace,AffMem,AfficheDet,CDM_connecte,parSocketCDM,
  DebugOuv,Raz_Acc_signaux,AvecInit,AvecTCO,terminal : boolean;
  tablo : array of byte;
  Enregistrement,chaine_Envoi,chaine_recue,Id_CDM,Af,
  entete,suffixe,ConfStCom : string;
  maxaiguillage,detecteur_chgt,Temps,TpsRecuCom,Tempo_init,Suivant,TypeGen,
  NbreImagePligne,NbreBranches,Index2_det,branche_det,Index_det,
  I_simule : integer;
  Ancien_detecteur,detecteur : array[0..1024] of boolean;  // anciens �tat des d�tecteurs et adresses des d�tecteurs et leur �tat
  Adresse_detecteur : array[0..60] of integer; // adresses des d�tecteurs par index
  mem : array[0..1024] of boolean ; // m�moire des �tats des d�tecteurs
  MemZone : array[0..1024,0..1024] of boolean ; // m�moires de zones
  Train : array[1..30] of record
             index : integer ; // nombre de routes pour ce train
             route : array[1..2000] of record
             Mem1,Mem2 : integer;
           end;
          end; 
  Tablo_Simule : array[0..200] of
    record
      tick : longint;
      Detecteur,etat : integer ;
    end;
  Route : array[1..2000] of record
     Mem1,Mem2 : integer;
     end;  
  N_Cv,index_simule,NDetecteurs,N_Trains,N_routes : integer;
  tablo_CV : array [1..255] of integer;
  couleur : Tcolor;
  fichier : text;
  recuCDML : array of string;
  tick,Premier_tick : longint;

  // l'indice du tableau aiguillage est son adresse
  aiguillage : array[0..MaxAcc] of Taiguillage;
  aiguillageB : array[0..MaxAcc] of Taiguillage;


  // dessin des feux
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
                 Btype_suiv1 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv2 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv3 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv4 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 VerrouCarre : boolean ;    // si vrai, le feu se verrouille au carr� si pas de train avant le signal
                 EtatSignal  : word  ;      // comme EtatSignalCplx
                 UniSemaf : integer ;        // d�finition suppl�mentaire de la cible pour les d�codeurs UNISEMAF
                 AigDirection : array[1..6] of array of record  // pour les signaux directionnels : contient la liste des aiguillages associ�s
                                               Adresse : integer;     // 6 feux max associ�s � un tableau dynamique d�crivant les aiguillages
                                               posAig  : char;
                                               end;
                end;
  Fimage : Timage;

  BrancheN : array[1..100,1..200] of TBranche;

{$R *.dfm}

// utilisation dans unit� UnitPilote et configunit
function Index_feu(adresse : integer) : integer;
procedure dessine_feu2(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_feu3(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_feu4(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_feu5(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_feu7(Acanvas : Tcanvas;EtatSignal : word);
procedure dessine_feu9(Acanvas : Tcanvas;EtatSignal : word);
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
// deuxi�me mot: variable Combine = code de la signalisation combin�e
// Exemple code_to_aspect(10001000000000)  renvoie jaune et Combine=rappel_30
function code_to_aspect(codebin : word) : word;
var i,mot,premierbit : word;
begin
  mot:=codebin;
  i:=0;premierbit:=0;Combine:=0;

  while (i<15) do
  begin
    if (mot and 1)=1 then  // si bit 0 du mot est � 1
    begin
       if (premierbit=0) then premierbit:=i else Combine:=i;
    end;
    mot:=mot shr 1; //d�caler � droite
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
    Ellipse(x-rayon,y-rayon,x+rayon,y+rayon);
  end;
end;

// dessine les feux sur une cible � 2 feux
procedure dessine_feu2(Acanvas : Tcanvas;EtatSignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,13,11,6,GrisF);
  cercle(ACanvas,13,23,6,GrisF);

  // allumages
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,13,11,6,clWhite);
  if code=violet then cercle(ACanvas,13,23,6,clviolet);
end;

// dessine les feux sur une cible � 3 feux
procedure dessine_feu3(Acanvas : Tcanvas;EtatSignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  // extinctions
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,13,33,6,GrisF);
  if not((code=vert_cli)  and clignotant) then cercle(ACanvas,13,11,6,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,13,22,6,GrisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,13,11,6,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,13,33,6,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,13,22,6,clRed);
end;

// dessine les feux sur une cible � 4 feux
procedure dessine_feu4(Acanvas : Tcanvas;EtatSignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect

  //extinctions
  cercle(ACanvas,13,11,6,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,13,33,6,GrisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,13,22,6,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,13,44,6,GrisF);

  // allumages
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,13,22,6,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(Acanvas,13,44,6,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,13,33,6,clRed);
  if code=carre then
  begin
    cercle(ACanvas,13,33,6,clRed);
    cercle(ACanvas,13,11,6,clRed);
  end;
end;

// dessine les feux sur une cible � 5 feux
procedure dessine_feu5(Acanvas : Tcanvas;EtatSignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,13,22,6,GrisF);
  cercle(ACanvas,13,11,6,GrisF);
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,13,33,6,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,13,44,6,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,13,55,6,GrisF);

  //allumages
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,13,44,6,clRed);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,13,22,6,clWhite);
  if code=carre then
  begin
    cercle(ACanvas,13,44,6,clRed);
    cercle(ACanvas,13,11,6,clRed);
  end;
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,13,33,6,clGreen);
  if ((code=jaune_cli) and (clignotant)) or (code=jaune) then cercle(ACanvas,13,55,6,clorange);
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


// affiche un texte dans la fen�tre
procedure Affiche(s : string;lacouleur : TColor);
begin
  couleur:=lacouleur;
  with formprinc.ListBox1 do
  begin
     Items.addObject(s,pointer(lacouleur));
     TopIndex:= Items.Count - 1;
  end;
end;



// dessine les feux sur une cible � 7 feux
procedure dessine_feu7(Acanvas : Tcanvas;EtatSignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et combine
  // effacements

  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,13,23,6,grisF);
  if not((code=ral_60) and clignotant) or not((combine=ral_60) and clignotant) then
  begin
    cercle(ACanvas,13,11,6,grisF);cercle(ACanvas,37,11,6,GrisF);
  end;
  if not((code=vert_cli) and clignotant) then cercle(ACanvas,13,45,6,GrisF);
  cercle(ACanvas,13,35,6,GrisF);cercle(ACanvas,13,55,6,GrisF);
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,13,66,6,GrisF);
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,13,56,6,GrisF);

  // Allumages
  if (code=ral_30) or (combine=ral_30) or ((code=ral_60) or (combine=ral_60)) and clignotant then
  begin
    cercle(ACanvas,13,11,6,clOrange);cercle(ACanvas,37,11,6,clOrange);
  end;
  if (code=jaune) or ((code=jaune_cli) and clignotant) then cercle(Acanvas,13,66,6,clOrange);
  if ((code=semaphore_cli) and (clignotant)) or (code=semaphore) then cercle(ACanvas,13,56,6,clRed);
  if ((code=vert_cli) and (clignotant)) or (code=vert) then cercle(ACanvas,13,45,6,clGreen);
  if ((code=blanc_cli) and (clignotant)) or (code=blanc) then cercle(ACanvas,13,23,6,clWhite);
  if code=carre then
  begin
    cercle(ACanvas,13,35,6,clRed);
    cercle(ACanvas,13,55,6,clRed);
  end;
end;

// dessine les feux sur une cible � 9 feux
procedure dessine_feu9(Acanvas : Tcanvas;etatsignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et aspect
  // extinctions
  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,13,36,6,grisF);
  if not((code=ral_60) and clignotant) or not((combine=ral_60) and clignotant) then
  begin
   cercle(ACanvas,13,24,6,grisF);cercle(ACanvas,37,24,6,grisF);
  end;
  if not((code=jaune_cli) and clignotant) then cercle(ACanvas,13,80,6,grisF);
  if not((code=rappel_60) and clignotant) or not((combine=rappel_60) and clignotant) then
  begin
    cercle(ACanvas,37,12,6,grisF);cercle(ACanvas,37,37,6,grisF);
  end;
  cercle(ACanvas,13,47,6,grisF); // carr� sup�rieur
  if not((code=semaphore_cli) and clignotant) then cercle(ACanvas,13,69,6,grisF);
  if not((code=vert_cli) and clignotant) then  cercle(ACanvas,13,58,6,grisF);

  // allumages
  if ((code=ral_60) and clignotant) or (code=ral_30) or
     ((combine=ral_60) and clignotant) or (combine=ral_30) then
  begin
    cercle(ACanvas,13,24,6,clOrange);cercle(ACanvas,37,24,6,clOrange);
  end;

  if ((code=rappel_60) and clignotant) or (code=rappel_30) or
     ((combine=rappel_60) and clignotant) or (combine=rappel_30) then
  begin
    cercle(ACanvas,37,12,6,clOrange);cercle(ACanvas,37,37,6,clOrange);
  end;
  if ((code=jaune_cli) and clignotant) or (code=jaune) then cercle(Acanvas,13,80,6,clOrange);
  if ((code=semaphore_cli) and clignotant) or (code=semaphore) then cercle(ACanvas,13,69,6,clRed);
  if ((code=vert_cli) and clignotant) or (code=vert) then cercle(ACanvas,13,58,6,clGreen);
  if ((code=blanc_cli) and clignotant) or (code=blanc) then cercle(ACanvas,13,36,6,clWhite);

  if code=carre then
  begin
    cercle(ACanvas,13,47,6,clRed);
    cercle(ACanvas,13,69,6,clRed);
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

// dessine l'aspect du feu en fonction de son adresse
procedure Dessine_feu(adresse : integer);
var i : integer;
begin
  i:=Index_feu(adresse);
  if i<>0 then
  case feux[i].aspect of
  // feux de signalisation
   2 : dessine_feu2(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
   3 : dessine_feu3(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
   4 : dessine_feu4(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
   5 : dessine_feu5(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
   7 : dessine_feu7(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
   9 : dessine_feu9(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
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
    if feux[rang].Btype_suiv1=5 then s:=s+' (aig bis)';
    Hint:=s;
    onClick:=Formprinc.Imageonclick;

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

    dessine_feu(feux[rang].adresse);
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


// envoi d'une cha�ne � la centrale par USBLenz ou socket, n'attend pas l'ack
// ici on envoie pas � CDM
procedure envoi_ss_ack(s : string);
var i,timeout,valto : integer;
    com : Tobject;
    sa : string;
begin
//  com:=formprinc.MSCommUSBLenz;
  s:=entete+s+suffixe;
  if Trace then Affiche('Tick='+IntToSTR(tick)+'/Env '+chaine_Hex(s),ClGreen);
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

// envoi d'une cha�ne � la centrale Lenz par USBLenz ou socket, puis attend l'ack ou le nack
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
      until ferme or ack or nack or (temps>TimoutMaxInterface); // l'interface r�pond < 5s en mode normal et 1,5 mn en mode programmation
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



// pr�pare la cha�ne de commande pour un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat1 : integer) : string;
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
  s:=s+'STATE='+format('%.*d',[1,etat1])+';';

  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_Acc:=so+s;
end;



// active ou d�sactive une sortie. Une adresse comporte deux sorties identifi�es par "octet"
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


// pilotage d'un accessoire (d�codeur d'aiguillage, de signal)
// octet = 0 ou 1 ou 2
// la sortie "octet" est mise � 1 puis � 0
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

  // pilotage par USB ou par r�seau de la centrale
  // test si pilotage invers�
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
    // pilotage � 1
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

    // pilotage � 0 pour �teindre le pilotage de la bobine du relais
    s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
  end;
end;

// pilote accessoire en entr�e 0->2  1->1
procedure pilote_acc01(adresse : integer;octet : byte);
var  groupe : integer ;
     fonction : byte;
     s : string;
begin
  // test si pilotage invers�
  if octet=0 then octet:=2;
  if aiguillage[adresse].inversion=1 then
  begin
    if octet=1 then octet:=2 else octet:=1;
  end;
  if (octet=0) or (octet>2) then exit;
  groupe:=(adresse-1) div 4;
  fonction:=((adresse-1) mod 4)*2 + (octet-1);
  // pilotage � 1
  s:=#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
  sleep(10);    // temps minimal pour ne pas avoir le d�faut station occup�e qd on pilote un signal leb
  //temps:=aiguillage[adresse].temps;if temps=0 then temps:=4;
  // si l'accessoire est un feu, fixer l tempo � 1
  //if index_feu(adresse)<>0 then temps:=1;

  //if portCommOuvert or ParSocket then tempo(temps);
  // pilotage � 0 pour �teindre le pilotage de la bobine du relais
  s:=#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
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

// mise � jour �tat signal complexe dans le tableau de bits du signal EtatSignalCplx */
// adresse : adresse du signal complexe
// Aspect : code repr�sentant l'�tat du signal de 0 � 15
procedure Maj_Etat_Signal(adresse,aspect : integer);
begin

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
    Dessine_feu(adr);
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
envoie les donn�es au d�codeur CDF pour un signal
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
    // signalisation non combin�e rappel 30 seul
    if (aspect=rappel_30) then pilote_acc(adresse+1,1,feu);

    // signalisation combin�e  - rappel 30 + avertissement - � tester......
    if (Combine=0)      then pilote_acc(adresse+2,1,feu) ;    // �teindre rappel 30
    if (Combine=rappel_30) then pilote_acc(adresse+2,2,feu) ; // allumer rappel 30  
    dessine_feu(adresse);
  end;
end;

{==========================================================================
envoie les donn�es au d�codeur LEB pour un signal
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
  
  Sleep(60);  // si le feu se positionne � la suite d'un positionnement d'aiguillage, on peut avoir le message station occup�e

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
  dessine_feu(adr);
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
var valeur,index,code,codebin,aspect : integer ;
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
    dessine_feu(adresse);
  end;
end;

// d�codeur unisemaf (paco)
procedure envoi_UniSemaf(adresse: integer);
var modele,index,code,codebin,aspect : integer ;
    s : string;
begin
  index:=Index_feu(adresse);    // tranforme l'adresse du feu en index tableau
  //code:=feux[index].aspect; // aspect du feu;

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
    
    // pour Unisemaf, la cible est d�finie dans le champ Unisemaf de la structure feux

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
        // 51=carr� + blanc
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
        // 72=VJR + carr� + ralentissement 30
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
        // 73=VJR + carr� + ralentissement 60
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
        // 91=VJR + carr� + rappel 30
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

        // 92=VJR + carr� + rappel 60
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

        // 93=VJR + carr� + ral30 + rappel 30
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

        // 94=VJR + carr� + ral60 + rappel60
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

        // 95=VJR + carr� + ral30 + rappel 60
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
        // 96=VJR + blanc + carr� + ral30 + rappel30
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

        // 97=VJR + blanc + carr� + ral30 + rappel60
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
    dessine_feu(adresse);
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
procedure envoi_LDT(adr : integer);
var codebin,aspect,mode : integer;
begin
  codebin:=EtatSignalCplx[adr];
  aspect:=code_to_aspect(codebin);
  if aspect>carre then mode:=2 else mode:=1;
  if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr];
    //if (tempo_ACC>0) then sleep(100);  // les commandes entre 2 feux successives doivent �tre s�par�es au minimum de 100 ms
    if traceSign then affiche('Signal LDT: '+IntToSTR(adr)+' '+intToSTR(mode)+' '+intTOSTR(codebin),clOrange);
    if AffSignal then afficheDebug('Signal LDT: '+IntToSTR(adr)+' '+intToSTR(mode)+' '+intTOSTR(codebin),clOrange);
    
    if (aspect=semaphore) or (aspect=vert) or (aspect=carre) or (aspect=jaune) then mode:=1 else mode:=2;

    case mode of
      // pour les d�codeurs en mode 0, il faut �crire la routine vous m�me car le pilotage d�pend du cablage
      // sauf pour le s�maphore, vert et jaune fixe
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
  dessine_feu(adr);
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
    aspect:=code_to_aspect(code); // transforme le motif de bits en num�ro  "code des aspects des signaux"
    if (tracesign) then Affiche('Signal virtuel: ad'+intToSTR(adresse)+'='+etatSign[aspect],clOrange);
    if AffSignal then AfficheDebug('Signal virtuel: ad'+intToSTR(adresse)+'='+etatSign[aspect],clOrange);
    dessine_feu(adresse);
  end;
end;

(*==========================================================================
envoie les donn�es au d�codeur digitalbahn �quip� du logiciel "led_signal_10"
       adresse=adresse sur le BUS DCC
       codebin=motif de bits repr�sentant l'�tat des feux L'allumage est fait en
       adressant l'une des 14 adresses pour les 14 leds possibles du feu.
       Ici on met le bit 1 � 1 (�tat "vert" du programme hexmanipu
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
    aspect:=code_to_aspect(codebin); // transforme le motifs de bits en num�ro  "code des aspects des signaux"
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
    // sp�cifique au d�codeur digital bahn:
    // si le signal affichait un signal combin�, il faut �teindre le signal avec un s�maphore
    // avant d'afficher le nouvel �tat non combin�
    Ancralrap:=(TestBit(ancien_tablo_signalCplx[adresse],ral_30)) or (TestBit(ancien_tablo_signalCplx[adresse],ral_60)) or
               (TestBit(ancien_tablo_signalCplx[adresse],rappel_30)) or (TestBit(ancien_tablo_signalCplx[adresse],rappel_60)) ;
    // si ancien �tat du signal=jaune ou jaune cli
    Ancjau:=(TestBit(ancien_tablo_signalCplx[adresse],jaune)) or (TestBit(ancien_tablo_signalCplx[adresse],jaune_cli)) ;

    // si �tat demand� du signal=ralentissement ou rappel
    ralrap:=(TestBit(codebin,ral_30)) or (TestBit(codebin,ral_60)) or
           (TestBit(codebin,rappel_30)) or (TestBit(codebin,rappel_60)) ;
    // si �tat demand� du signal=jaune ou cli
    jau:=TestBit(codebin,jaune) or TestBit(codebin,jaune_cli) ;

    //effacement du signal combin� par s�maphore suivant condition
    if (((Ancralrap and not(ralrap)) or (Ancjau and not(jau))) and (aspect>=8)) then
    begin
      Sleep(40);
      pilote_acc(adresse+semaphore,2,feu) ;
     // dessine_feu(adresse);
    end;

    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];

    sleep(40);  // les commandes entre 2 feux successifs doivent �tre s�par�es au minimum de 100 ms
    // affichage du premier aspect du signal(1er bit � 1 dans codebin
    pilote_acc(adresse+aspect,2,feu) ;


    // affichage de la signalisation combin�e (2�me bit � 1 dans codebin)
    if (CombineLoc<>0) then
    begin
      sleep(40);
      pilote_ACC(adresse+CombineLoc,2,feu) ;
    end;
    dessine_feu(adresse);
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
     if detecteur[518] then Maj_Etat_Signal(signalCplx,blanc_cli) else Maj_Etat_Signal(signalCplx,blanc) ;
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
  // initialisation des aiguillages avec des valeurs par d�faut
  for i:=1 to MaxAcc do
  begin
    Aiguillage[i].modele:=0  ;//  sans existence
    Aiguillage[i].position:=2; //droit
    Aiguillage[i].temps:=5   ;
    Aiguillage[i].inversion:=0;
  end;
  for i:=1 to 1024 do
  begin
     Detecteur[i]:=false;
     Ancien_detecteur[i]:=false;
  end;
  //ChDir(s);
  Affiche('lecture du fichier de configuration client-GL.cfg',clyellow);
  assign(fichier,'client-GL.cfg');
  reset(fichier);
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
  if not(config_com(s)) then Affiche('Erreur port com mal d�clar� : '+s,clred);
  portcom:=s;

  // temporisation entre 2 caract�res
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
  if (erreur<>0) or (valeur_entete>2) then Affiche('Erreur d�claration variable entete',clred);


  //avec ou sans initialisation des aiguillages
  s:=lit_ligne;
  AvecInitAiguillages:=StrToINT(s);

  Affiche('Valeurs d''initialisation des aiguillages',clyellow);
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
        j:=pos(',',s);
        temporisation:=StrToInt(copy(s,1,j-1));Delete(S,1,j);
        if (temporisation<0) or (temporisation>10) then temporisation:=5;
        aiguillage[adresse].temps:=temporisation;
        aiguillageB[adresse].temps:=temporisation;

        invers:=StrToInt(s);
        if (invers<0) or (invers>1) then invers:=0;   // inversion commande
        aiguillage[adresse].inversion:=invers;
        aiguillageB[adresse].inversion:=invers;
        
      end;
    end;
  until (adresse=0);

  closefile(fichier);

  Affiche('lecture du fichier de configuration config.cfg',clyellow);
  assign(fichier,'config.cfg');
  reset(fichier);

  s:=Lit_ligne;  //variable log non utilis�e
  s:=Lit_ligne; // trace_det
  s:=Lit_ligne; // raz signaux
  Raz_Acc_signaux:=pos('1',s)<>0;
  if Raz_Acc_signaux then Affiche('Avec Raz commande signaux',clYellow);
  Affiche('D�finition des aiguillages',clyellow);

  // d�finition des aiguillages dans les branches
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
      // pr�parer l'enregistrement pour la boucle de ligne
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
          if (erreur<>0) then // si erreur<>0 peut �tre un B ou un S ou un ,
          begin
            if (enregistrement[1]='B') then
            begin
              if bis=0 then aiguillage[aig].ApointeBis:=1 else aiguillageB[aig].ApointeBis:=1;
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connect� a aiguillage BIS'+s,clYellow);
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
          if (erreur<>0) then // si erreur<>0 peut �tre un B ou un S ou un ,
          begin
            if (enregistrement[1]='B') then
            begin
              if bis=0 then aiguillage[aig].AdroitBis:=1 else aiguillageB[aig].AdroitBis:=1;
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connect� a aiguillage BIS'+s,clYellow);
            end;
            if (enregistrement[1]<>',') then  // copier si c'est S P D
            begin
              if bis=0 then aiguillage[aig].AdroitB:=enregistrement[1] else aiguillageB[aig].AdroitB:=enregistrement[1];
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connect� a aiguillage BIS'+s,clYellow);
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

          erreur:=pos('S2',enregistrement); // description d'un rattachement � la branche S2 d'un aiguillage triple
          tec:=erreur<>0;  // ne supprimer que le 2
          if (tec) then delete(enregistrement,erreur+1,1);

          erreur:=pos('B',enregistrement);  // description d'un rattachement connect� � un aiguillage bis
          bistec:=erreur<>0;
          if (bistec) then delete(enregistrement,erreur,1); // ne supprime que le B
          detect:=0;
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

        Val(enregistrement,adr,erreur);
        if erreur=0 then
        begin
          aiguillage[aig].vitesse:=adr;
          enregistrement:='';
        end;
        
      until enregistrement='' ;
    end;
  until (s='0');

  Affiche('d�finition des branches',clyellow);
  // branches de r�seau
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
  //Affiche(IntToSTR(NbreBranches)+' branches',clYellow);

   // feux
  Affiche('D�finition des feux',clyellow); 
  i:=1;
  repeat
    s:=lit_ligne;
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
          // �l�ments optionnels
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
               //type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
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
               l:=pos('B',s);
               if l<>0 then
               begin
                 t:=5;
                 delete(s,l,1);
                 //Affiche('d�tect� aiguillage bis',clyellow);
                 if (j=1) then feux[i].Btype_Suiv1:=5;
                 if (j=2) then feux[i].Btype_Suiv2:=5;
                 if (j=3) then feux[i].Btype_Suiv3:=5;
                 if (j=4) then feux[i].Btype_Suiv4:=5;
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
    end;
    inc(i);
    end;
  end;
  until (finifeux);
  NbreFeux:=i-1; if NbreFeux<0 then NbreFeux:=0;
  //Affiche('Nombre de feux='+IntToSTR(NbreFeux),clYellow);

  //Affiche(IntToStr(NbreBranches)+' branches',clwhite);
  closefile(fichier);
  // v�rification de la coh�rence1
  // parcoure les branches des d�tecteurs jusqu'� trouver un aiguillage pour voir s'il a �t� d�crit
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
  for aig:=1 to maxaiguillage do
  begin
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

// trouve un �l�ment dans les branches, renvoie  branche_trouve IndexBranche_trouve
// el : adresse de l'�l�ment  TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
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
  else begin s:='Erreur 175 - �l�ment '+intToSTR(el);
         if (TypeEl=3) then s:=s+'bis';
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
// 9999=erreur fatale
// 9998= arret sur aiguillage en talon mal positionn�e
// 9997: arr�t sur aiguillage d�vi�
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
  if NivDebug=3 then AfficheDebug('Alg3 pr�cedent='+intToSTR(prec)+'/'+intToStr(TypeElprec)+' actuel='+intToSTR(actuel)+'/'+IntToSTR(typeElActuel),clyellow);
  // trouver les �l�ments du pr�c�dent
  trouve_element(prec,TypeELPrec); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;
  //  if BTypePrec=2 then aiguillage[prec].A

  trouve_element(actuel,typeElActuel); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(actuel)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_actuel:=IndexBranche_trouve;
  branche_trouve_actuel:=branche_trouve;

  Adr:=actuel;
  Btype:=BrancheN[branche_trouve_actuel,indexBranche_actuel].Btype;

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
      if NivDebug=3 then AfficheDebug('41 - Le suivant est :'+intToSTR(adr)+'('+intToSTR(Btype)+')',clwhite);
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
      if NivDebug=3 then AfficheDebug('43 - Le suivant est :'+intToSTR(adr)+'('+intToSTR(TypeGen)+')',clwhite);
      suivant_alg3:=adr;
      exit;
    end;
    // ici, les �l�ments sont non cons�cutifs. voir si l'un des deux est une TJD/TJS
    if (btypePrec=2) or (btypePrec=3) then
    begin
      if NivDebug=3 then AfficheDebug('Le pr�cedent est une TJD/S - substitution du prec�dent par la pointe de la TJD',clYellow);
      // changer l'adresse du pr�c�dent par l'autre adresse de la TJD/S
      prec:=Aiguillage[prec].APointe;
      goto recommence;
    end;

    Affiche('44 - �l�ments non cons�cutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
    if NivDebug=3 then AfficheDebug('44 - �l�ments non cons�cutifs: Prec='+intToSTR(prec)+' Actuel='+intTostr(Actuel),clred);
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
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(adr,typeEl); // branche_trouve  IndexBranche_trouve
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
          ABis:=aiguillage[Adr].AdevieBis; // Abis=1 si aiguillage bis
          Adr:=aiguillage[Adr].Adevie;
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          suivant_alg3:=adr;exit;
        end;
      end
      else
      begin
        if NivDebug=3 then AfficheDebug('135 - aiguillage '+intToSTR(Adr)+' Pris en talon',clyellow);
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionn�
        begin
          if aiguillage[adr].position=const_droit then
          begin
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
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+' mal positionn�',clyellow);
                suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+' bien positionn�',clyellow);
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
        // Affiche('trouv�'+intToSTR(adr),clyellow);
        A:=aiguillage[Adr].ApointeB;
        ABis:=aiguillage[Adr].ApointeBis;
        Adr:=aiguillage[Adr].Apointe;
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
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
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then TypeEl:=3;
          trouve_element(Adr,TypeEl); // branche_trouve  IndexBranche_trouve
          typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          suivant_alg3:=Adr;
          exit;
        end;
        if (aiguillageB[Adr].position<>const_droit) then
        begin
          if NivDebug=3 then AfficheDebug('142 - Aiguillage '+intToSTR(adr)+' bis pris en pointe d�vi�',clyellow);
          AdrPrec:=Adr;
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
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
          if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
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
        if alg=2 then // on demande d'arreter si l'aiguillage en talon est mal positionn�
        begin
          if aiguillageB[adr].position=const_droit then
          begin
            if prec<>aiguillageB[Adr].Adroit then
              begin
                    if NivDebug=3 then AfficheDebug('135.3 - Aiguillage '+intToSTR(adr)+'bis mal positionn�',clyellow);
                    suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('135.4 - Aiguillage '+intToSTR(adr)+'bis bien positionn�',clyellow);
              end;
          end
          else
          begin
            if prec<>aiguillageB[Adr].Adevie then
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+'bis mal positionn�',clyellow);
                suivant_alg3:=9998;exit;
              end
              else
              begin
                if NivDebug=3 then AfficheDebug('Aiguillage '+intToSTR(adr)+'bis bien positionn�',clyellow);
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
        // Affiche('trouv�'+intToSTR(adr),clyellow);
        A:=aiguillageB[Adr].ApointeB;
        ABis:=aiguillageB[Adr].ApointeBis;
        Adr:=aiguillageB[Adr].Apointe;
        if A='Z' then TypeEl:=1 else TypeEL:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
        if Abis=1 then TypeEl:=3;
        trouve_element(adr,TypeEl); // branche_trouve  IndexBranche_trouve
        typeGen:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        suivant_alg3:=adr;
        exit;
      end;
    end;

    if (aiguillage[Adr].modele=2) or (aiguillage[Adr].modele=3) then // TJD ou TJS
    begin
      AdrTjdP:=aiguillage[Adr].Apointe;
      tjd:=aiguillage[Adr].modele=2;
      tjs:=aiguillage[Adr].modele=3;
      tjsc1:=aiguillage[Adr].tjsint;   // adresses de la courbe de la TJD
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
      // determiner la position de la premi�re section de la TJD (4 cas)
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
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;
          exit;
        end;
        if aiguillage[Adr].Adroit=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[AdrTjdP].Adroit;
          Abis:=aiguillage[AdrTjdP].AdroitBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;
          exit;
        end;
        //Affiche('Erreur 1021  adrTJD='+IntToSTR(Adr)+' adrTJDPointe='+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
        if nivDebug=3 then AfficheDebug('TJD mal positionn�e',clred);
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
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          Adr:=aiguillage[AdrTjdP].Adroit;
          Abis:=aiguillage[AdrTjdP].AdroitBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if nivDebug=3 then AfficheDebug('TJD mal positionn�e',clred);
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
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if (aiguillage[Adr].Adroit=prec) then
        begin
          A:=aiguillage[Adr].AdevieB;
          Adr:=aiguillage[Adr].Adevie;
          Abis:=aiguillage[Adr].AdevieBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if nivDebug=3 then AfficheDebug('TJD mal positionn�e',clred);
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
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrtjdP].AdevieB;
          Adr:=aiguillage[AdrtjdP].Adevie;
          Abis:=aiguillage[AdrtjdP].AdevieBis;
          if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
          if Abis=1 then typeGen:=3;
          suivant_alg3:=adr;exit;
        end;
        if nivDebug=3 then AfficheDebug('TJD mal positionn�e',clred);
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
        if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
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
        if A='Z' then typeGen:=1 else typeGen:=2;  //TypeEL=(1=d�t�cteur 2=aig  3=aig Bis)
        if Abis=1 then typeGen:=3;
        suivant_alg3:=adr;exit;
      end;
      Affiche('139 - Erreur fatale - Aucun cas TJD/S : adr='+IntToSTR(Adr)+' '+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
      AfficheDebug('139 - Erreur fatale - Aucun cas TJD/S : adr='+IntToSTR(Adr)+' '+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
      suivant_alg3:=9999;exit;
    end;
    if (aiguillage[Adr].modele=4) then // aiguillage triple
    begin
       // aiguillage triple pris en pointe
             Adr2:=aiguillage[Adr].AdrTriple;
             // attention la lecture d'un aiguillage triple est diff�rente suivant la connexion avec CDM
             // ou avec l'interface
             if ( CDM_connecte and (aiguillage[Adr].position=const_droit) ) or
                ( not(CDM_connecte) and  (aiguillage[Adr].position=const_droit) and (aiguillage[Adr2].position=const_droit) )  then
             begin
               if NivDebug=3 then AfficheDebug('Aiguillage triple droit',clYellow);
               typeGen:=aiguillage[Adr].AdroitBis+1;
               //TSuiv=aiguillage[Adr].AdroitB;
               Adr:=aiguillage[Adr].Adroit;
             end;
             if ( CDM_connecte and (aiguillage[Adr].position=const_devieG) ) or
                ( not(CDM_connecte) and  (aiguillage[Adr].position<>const_droit) and (aiguillage[Adr2].position=const_droit) )  then
             begin
                if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�1 (gauche)',clYellow);
                typeGen:=aiguillage[Adr].AdevieBis+1;
                //TSuiv=aiguillage[Adr].AdevieB;
                Adr:=aiguillage[Adr].Adevie;
             end;
             if ( CDM_connecte and (aiguillage[Adr].position=const_devieG) ) or
                ( not(CDM_connecte) and (aiguillage[Adr].position=const_droit) and (aiguillage[Adr2].position<>const_droit) ) then
             begin
                if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�2 (droit)',clYellow);
                typeGen:=aiguillage[Adr].Adevie2Bis+1;
                //TSuiv=aiguillage[Adr].Adevie2B;
                Adr:=aiguillage[Adr].Adevie2;
             end;
             if ((aiguillage[Adr].position<>const_droit) and (aiguillage[Adr2].position<>const_droit) ) then
             begin
                AfficheDebug('Aiguillage triple '+IntToSTR(Adr)+' : configuration des aiguilles interdite',clYellow);
                Affiche('Aiguillage triple : '+IntToSTR(Adr)+' configuration des aiguilles interdite',clRed);
                //TSuiv='Z';
               suivant_alg3:=9999;exit; // pour �chappement
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
// TypeElprex/actuel: 1= d�tecteur  2= aiguillage 3=bis 4=Buttoir
function detecteur_suivant(prec : integer;TypeElPrec : integer;actuel : integer;TypeElActuel : integer) : integer ;
var AdrDet,actuelCalc,PrecCalc,etat,i,j,AdrSuiv : integer;
    BisprecCalc,BisActuelCalc : integer;
begin
  if NivDebug>=2 then AfficheDebug('cherche d�tecteur suivant aux '+IntToSTR(prec)+'/'+IntToSTR(typeElPrec)+' - '+intToSTR(actuel)+'/'+intToSTR(TypeElActuel),clyellow);
  j:=0;

  PrecCalc:=prec;
  bisprecCalc:=TypeElprec;
  ActuelCalc:=actuel;
  BisActuelCalc:=TypeELActuel;
  // �tape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,BisPrecCalc,actuelCalc,BisActuelCalc,1);
    precCalc:=actuelCalc;
    BisPrecCalc:=BisActuelCalc;
    actuelCalc:=AdrSuiv;
    BisActuelCalc:=typeGen;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=10) or (typeGen=1) or (AdrSuiv=0) or (AdrSuiv>=9998); // arret si d�tecteur
  // si trouv� le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,TypeElPrec,actuel,TypeElActuel,1);
  end;
  if NivDebug=3 then AfficheDebug('Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// renvoie les adresses des d�tecteurs adjacents au d�tecteur "adresse"
// r�sultat dans adj1 et adj2
procedure Det_Adj(adresse : integer);
var Adr,BtypePrec,AdrFonc,Branche,BtypeFonc,AdrPrec,IndexBranche,i,Dir : integer;
    sortie : boolean;
begin
  trouve_element(adresse,1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('�l�ment '+IntToSTR(adresse)+' non trouv�',clred);
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
        Adr:=suivant_alg3(AdrPrec,BtypePrec,AdrFonc,BtypeFonc,2)  // �l�ment suivant mais arret sur aiguillage en talon mal positionn�e
      else
        begin Adr:=AdrFonc;TypeGen:=BtypeFonc;end;
      if Adr>9990 then typeGen:=1;
      if (NivDebug=3) then AfficheDebug('trouv� '+intToSTR(Adr)+' '+intToSTR(typeGen),clorange);
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

// renvoie l'adresse du d�tecteur suivant des deux �l�ments
// El1 et El2 peuvent �tre s�par�s par des aiguillages
function detecteur_suivant_El(el1: integer;TypeDet1 : integer;el2 : integer;TypeDet2 : integer) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,Btype,BisPrec,BisFonc,BisSuiv : integer;
    Sortie : boolean;
    s : string;

begin
  if NivDebug>=2 then AfficheDebug('cherche d�tecteur_suivant_El aux '+IntToSTR(el1)+'/'+intToSTR(TypeDet1)+'-'+intToSTR(el2)+'/'+intToSTr(TypeDet2),clyellow);
  // traceDet=TRUE;
  // trouver d�tecteur 1
  trouve_element(el1,Typedet1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('�l�ment '+IntToSTR(el1)+' non trouv�',clred);
    detecteur_suivant_El:=1;exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver �l�ment 2
  trouve_element(el2,TypeDet2); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('�l�ment '+IntToSTR(el2)+' non trouv�',clred);
    detecteur_suivant_El:=2;exit;
  end;

  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;

  j:=1;
  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)
  repeat // boucle d'incr�ment d�cr�ment
    if (NivDebug=3) then
    begin
      s:='Test 1 route en ';
      if (j=1) then s:=s+'d�cr�ment ' else s:=s+'incr�ment ';
      s:=s+'- d�part depuis d�tecteur '+IntToSTR(el1);AfficheDebug(s,clyellow);
    end;
    AdrPrec:=el1;
    BisPrec:=typeDet1;

    if (j=1) then i:=IndexBranche_det1-1 else i:=IndexBranche_det1+1;
    if i=0 then Affiche('Erreur �l�ment '+intToSTR(el1)+' en index 1',clred);
    //trouve_element(det1,FALSE);
    Adr:=BrancheN[branche_trouve_det1,i].Adresse; // �l�ment suivant le det1
    AdrFonc:=Adr;
    Btype:=BrancheN[branche_trouve_det1,i].BType;  // �l�ment suivant/pr�c�dent
    BisFonc:=Btype;
    i:=0;
    if (el2<>Adr) then
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);  // donne l'�l�ment suivant de AdrPrec � AdrFonc et dans Bis si c'est un aig bis
      if (Adr>=9997) then begin detecteur_suivant_el:=Adr;exit;end;
      if (NivDebug=3) then AfficheDebug('trouv� '+intToSTR(Adr)+' '+intToSTR(typeGen),clorange);
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
        Affiche('Erreur fatale 300 : It�ration trop longue',clred);
        AfficheDebug('Erreur fatale 300 : It�ration trop longue',clred);
        detecteur_suivant_el:=3;
      end;
    if ((Btype=1) and (Adr<>el2) and (NivDebug=3)) then AfficheDebug('N''est pas le d�tecteur attendu '+intToSTR(Adr)+' pour '+intToSTR(el2),clyellow);
    inc(j);   // changement de sens
    sortie:=(Adr=el2) or (j=3) or (Adr=0);
  until sortie;

  // si arret sur buttoir
  if Adr=0 then begin detecteur_suivant_el:=0;exit;end;

  if ((j=3) and (Adr<>el2)) then
  begin
    if NivDebug=3 then AfficheDebug('El - Pas de suivant sur s�quence '+IntToSTR(el1)+' � '+intToStr(el2),clyellow);
    detecteur_suivant_el:=0;exit;
  end;

  // �tape 2 : on a trouv� le sens de progression, trouver le d�tecteur suivant
  if (Adr=el2) then
  begin
    // trouv� la route si j=2 : -  si j=3 : +
    if (NivDebug=3) then AfficheDebug('El - Route trouv�e',clyellow);
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
      if NivDebug=3 then AfficheDebug('trouv� 2:'+intToSTR(Adr)+' '+intToSTR(typeGen),clorange);
      trouve_element(Adr,typeGen);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype; // si aiguillage bis
      if (NivDebug=3) then AfficheDebug('Suivant='+IntToSTR(Adr)+ '('+intToSTR(Btype)+')',clyellow);
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=typeGen;
      inc(i);
      sortie:=(Btype=1) or (Adr=0) or (i=20);
    until sortie;
    if NivDebug>=2 Then AfficheDebug('D�tecteur suivant='+intToSTR(Adr),clOrange);
    if (bType=1) or (Adr=0) then detecteur_suivant_el:=Adr;
    if (i=20) then begin
       if NivDebug=3 then AfficheDebug('Erreur fatale 201 : It�ration trop longue',clred);
       Affiche('Erreur fatale 201 : It�ration trop longue',clred);detecteur_suivant_el:=3;end;
  end;
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
  if (NivDebug=3) then
  begin
   if (AdrSuiv=9998) then AfficheDebug('Le signal '+intToSTR(adresse)+' doit afficher un carr� car l''aiguillage pris en talon '+IntToSTR(actuel)+' est mal positionn�',clYellow)
    else AfficheDebug('Le signal '+IntToSTR(adresse)+' ne doit pas �tre au carr�',clYellow);
  end;
  carre_signal:=AdrSuiv=9998;
end;


// renvoie l'�tat du signal suivant
// si renvoie 0, pas trouv� le signal suivant.
// rang=1 pour feu suivant, 2 pour feu suivant le 1, etc
function etat_signal_suivant(adresse,rang : integer) : integer ;
var num_feu,AdrDet,etat,AdrFeu,i,j,prec,AdrSuiv : integer;
    TypePrec,TypeActuel : integer;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then
  AfficheDebug('Cherche �tat du signal suivant au '+IntToSTR(adresse),clyellow);
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
    Affiche('Erreur 600 - feu non trouv�',clred);
    etat_signal_suivant:=0;
    exit;
  end;
  Etat:=0;
  j:=0;
  num_feu:=0;
  prec:=Feux[i].Adr_det1;  // d�tecteur sur le courant

  if prec=0 then
  begin
    Affiche('Msg 601 - feu '+intToSTR(adresse)+' non renseign� ',clOrange);
    etat_signal_suivant:=0;
    exit;
  end;
  TypePrec:=1;  // d�tecteur
  actuel:=feux[i].Adr_el_suiv1;
  if feux[i].Btype_suiv1=1 then TypeActuel:=1;
  if feux[i].Btype_suiv1=2 then TypeActuel:=2;
  if feux[i].Btype_suiv1=4 then TypeActuel:=2; // aiguillage triple
  if feux[i].Btype_suiv1=5 then TypeActuel:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis
  // si actuel est un d�tecteur, regarder si il ya un feu
  repeat
    inc(j);
    // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
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
      exit;
    end;
    if (AdrSuiv=0) then
    begin
      if NivDebug=3 then AfficheDebug('Le suivant est un buttoir',clyellow);
      Etat_signal_suivant:=carre_F; // faire comme si c'�tait un signal au carr�
      exit;
    end;

    // si le suivant est un d�tecteur comporte t-il un signal?

    AdrFeu:=0;
    if (TypeActuel=1) then  // d�tecteur?
    begin
      i:=Index_feu_det(AdrSuiv);
      AdrFeu:=Feux[i].Adresse;
      //affiche(intToSTR(Feux[i].Adr_el_suiv)+'/'+intTostr(prec),clyellow);
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
          Signal_suivant:=AdrFeu;
          if NivDebug=3 then AfficheDebug('Trouv� feu suivant Adr='+IntToSTR(AdrFeu)+'='+IntToSTR(etat),clOrange);
        end
        else
        begin
          if NivDebug=3 then AfficheDebug('Trouv� feu '+intToSTR(AdrFeu)+' mais dans le mauvais sens',clOrange);
          AdrFeu:=0;
        end;
      end;
    end;
  until (j=10) or ((AdrFeu<>0) and (num_feu=rang));
  if etat=0 then Signal_Suivant:=0;
  etat_signal_suivant:=Etat;
  if (NivDebug=3) and (adrFeu=0) then AfficheDebug('Pas Trouv� de feu suivant au feu Adr='+IntToSTR(ADresse),clOrange);
  //TraceDet:=false;
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
  until (j=10) or (AdrSuiv=9997) or (AdrFeu<>0) ;
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
function test_memoire_zones(adresse : integer) : boolean;
var
  TypePrec,TypeActuel,ife,Detecteur_precedent,actuel,AdrDet,Etat,AdrFeu,i,j,prec,AdrSuiv : integer;
  Pres_train,sort : boolean;

begin
  if NivDebug>=1 then AfficheDebug('Cherche m�moire � 1 du signal '+intToSTR(adresse)+' au signal suivant ',clyellow);

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
    if NivDebug=3 then AfficheDebug('Boucle de test feu '+intToSTR(ife)+'/4',clred);
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

    Detecteur_precedent:=prec;
    TypePrec:=1;
    if (prec=0) then
    begin
       test_memoire_zones:=Pres_train;
       exit;
    end;

    repeat
      inc(j);
      // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
      // et cha�ner m�moire de zone
      if (j=1) and (Typeactuel=1) then // si d�tecteur
      begin
        //AfficheDebug('C''est un d�tecteur',clred);
        AdrSuiv:=actuel;
        actuel:=prec;
        TypePrec:=1;
        TypeActuel:=1;
        //TypeGen:=1;
        Pres_train:=MemZone[prec,actuel];
        if Pres_Train and (NivDebug=3) then Affiche('Pr�sence train de '+intToSTR(prec)+' � '+intToSTR(actuel),clyellow);
        Detecteur_precedent:=actuel;
      end
      else
        begin
          AdrSuiv:=suivant_alg3(prec,TypePrec,actuel,TypeActuel,1);
          //AfficheDebug('A:'+IntToSTR(BisActuel);
          prec:=actuel;TypePrec:=TypeActuel;
          actuel:=AdrSuiv;TypeActuel:=typeGen;
         end;
      //AfficheDebug('A suivant='+IntToSTR(adrsuiv),clred);
      if AdrSuiv=0 then
      begin
        // si c'est un buttoir
        test_memoire_zones:=false;
        exit;
      end;
       // si le suivant est un d�tecteur comporte t-il un signal?
      AdrFeu:=0;
      if (TypeActuel=1) then  // d�tecteur
      begin
        if (NivDebug=3) and MemZone[Detecteur_precedent][actuel] then AfficheDebug('Pr�sence train de '+intToSTR(Detecteur_precedent)+' � '+intToSTR(actuel),clyellow);

        Pres_train:=MemZone[Detecteur_precedent][actuel] or Pres_train; // m�moire de zone
        Detecteur_precedent:=actuel; // pour pr�parer le suivant

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
            if (NivDebug=3) And Pres_Train then AfficheDebug('M�moire de zone � 1',clyellow);
            if (NivDebug=3) And (not(Pres_Train)) then AfficheDebug('M�moire de zone � 0',clyellow);
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
      sort:=(j=10) or (AdrFeu<>0) ;
    until (sort);
    inc(ife);
  until ife>=5;
  if (NivDebug=3) and (Etat=0) then AfficheDebug('Pas trouv� de signal suivant au '+intToSTR(adresse),clyellow);

  test_memoire_zones:=Pres_train;
end;

// trouve une s�quence chronologique 010 sur un d�tecteur
function trouve_seq_chrono_010(Adresse : integer) : boolean;
var i,etat : integer;
    etat0_seq1,etat1_seq2,etat0_seq3 : boolean;
begin
  i:=N_Event_tick;
  if i<2 then exit;
   Affiche('test si seq 010 sur det '+intToSTR(Adresse),clyellow);
  etat0_seq1:=false;  etat1_seq2:=false;  etat0_seq3:=false;
  if (event_det_tick[i].detecteur[Adresse]=0) then begin etat0_seq1:=true;end;
  repeat
//    if (event_det_tick[i].detecteur[Adresse]=0) then etat0_seq1:=true;

    if (event_det_tick[i].detecteur[Adresse]=1) and etat0_seq1 then begin etat1_seq2:=true;end;
    dec(i);     // remonter le temps ...
  until (i=0) or (etat1_seq2);
  trouve_seq_chrono_010:=etat1_seq2;
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

// trouve adresse d'un d�tecteur � "etat" avant "index" dans le tableai chrono
function trouve_index_det_chrono(Adr,etat,index : integer) : integer;
var i : integer;
    trouve : boolean;
begin
  i:=index;
  if i>N_Event_tick then begin trouve_index_det_chrono:=0;exit; end;
  inc(i);
  repeat
    dec(i);
    trouve:=event_det_tick[i].detecteur[Adr]=etat ;
  until trouve or (i=0);
  if trouve then
  begin
    trouve_index_det_chrono:=i;exit;
  end;
  trouve_index_det_chrono:=0;
end;


// calcul des zones depuis le tableau des fronts descendants des �v�nements d�tecteurs
// les d�tecteurs doivent �tre cons�cutifs
// trouve le d�tecteur suivant de det1 � det2 si la route est correcte. (d�tecteurs en entr�e obligatoires)
// transmis dans le tableau Event_det
// Variable globale:  El_suivant : adresse du d�tecteur suivant le d�tecteur "actuel"
//                    Actuel,Suivant : nouveaux d�tecteurs du canton suivant
// R�sultat:
// si 0 : pas de route
// si 1 : d�tecteur det1 non trouv�
// si 2 : d�tecteur det2 non trouv�
// si 3 : erreur fatale
// si 10 : ok route trouv�e

function calcul_zones_det(det1,det2 : integer) : integer;
var
  i,i1,i2,j,k,IndexBranche_det1,IndexBranche_det2,index_i1,index_i2,
  branche_trouve_det1,branche_trouve_det2,Adr,AdrPrec,position,Btype,BTypePrec,
  AdrFonc,TypePrec,TypeSuiv,TypeFonc,AdrSuiv,Train_Courant : integer;
  t,sortie,trouve : boolean;
  s,ss : string;

begin
  // if trouve_seq_chrono_010(det1) then Affiche('trouv� s�quence 010 sur d�tecteur '+intToSTR(det1),clyellow);
  // if trouve_seq_chrono_010(det2) then Affiche('trouv� s�quence 010 sur d�tecteur '+intToSTR(det2),clyellow);
  if traceListe then AfficheDebug('calcul_zones_det('+intToSTR(det1)+','+intToSTR(det2)+')',clyellow);
  // trouver d�tecteur 1
  trouve_detecteur(det1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('d�tecteur '+IntToSTR(det1)+' non trouv�',clred);
    calcul_zones_det:=1;exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;

  // trouver d�tecteur 2
  trouve_detecteur(det2); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('d�tecteur '+IntToSTR(det2)+' non trouv�',clred);
    calcul_zones_det:=2;exit;
  end;

  IndexBranche_det2:=IndexBranche_trouve;
  branche_trouve_det2:=branche_trouve;

  j:=1;
  // �tape 1 : trouver le sens de progression (en incr�ment ou en d�cr�ment)
  repeat // boucle d'incr�ment d�cr�ment
    if (traceListe) then
    begin
      s:='Test 2 route en ';
      if (j=1) then s:=s+'d�cr�ment ' else s:=s+'incr�ment ';
      s:=s+'- d�part depuis d�tecteur '+IntToSTR(det1);
      AfficheDebug(s,clyellow);
    end;
    AdrPrec:=det1;
    TypePrec:=1;
    if (j=1) then i:=IndexBranche_det1-1 else i:=IndexBranche_det1+1;
    //trouve_element(det1,FALSE);
    Adr:=BrancheN[branche_trouve_det1,i].Adresse;
    AdrFonc:=Adr;
    Btype:=BrancheN[branche_trouve_det1,i].BType;  // �l�ment suivant/pr�c�dent
    TypeFonc:=Btype;

    // si l'�l�ment suivant est un d�tecteur et il est diff�rent de det2, c'est pas le bon sens  : inutile de traiter le cas
    if (Btype<>1) or (Adr=Det2) then
    begin
      i:=0;
      if (det2<>Adr) then
      repeat
        Adr:=suivant_alg3(AdrPrec,TypePrec,AdrFonc,TypeFonc,1);  // donne l'�l�ment suivant de AdrPrec � AdrFonc et dans Bis si c'est un aig bis
        trouve_element(Adr,typeGen);
        Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        TypeSuiv:=Btype; // si aiguillage bis
        //Affiche(intToSTR(adr)+'/'+intToStr(Btype),clorange);
        AdrPrec:=AdrFonc;AdrFonc:=Adr;
        TypePrec:=TypeFonc;TypeFonc:=typeGen;
        i:=i+1;
        sortie:=(Btype=1) or (Btype=4) or (i=20) or (Adr=0);
      until (sortie) ;   // boucle de parcours
    end;

    if (i=20) then 
    begin Affiche('Erreur fatale 200 : It�ration trop longue',clred);
        AfficheDebug('Erreur fatale 200 : It�ration trop longue',clred);calcul_zones_det:=3;
    end;
    if ((Btype=1) and (Adr<>det2) and (TraceListe) ) then
       AfficheDebug('N''est pas le d�tecteur attendu '+intToSTR(Adr)+' pour '+intToSTR(det2),clyellow);
    inc(j);
    sortie:=((Adr=det2) and (Btype=1)) or (j=3);
  until sortie;

  if ((j=3) and (Adr<>det2)) then
  begin
    if (TraceListe) then AfficheDebug('Pas de suivant sur s�quence '+IntToSTR(det1)+' � '+intToStr(det2),clyellow);
    calcul_zones_det:=0;exit;
  end;

  // �tape 2 : on a trouv� le sens de progression, trouver le d�tecteur suivant
  if (Adr=det2) then
  begin
    // trouv� la route si j=2 : -  si j=3 : +
    if (TraceListe) then AfficheDebug('Route trouv�e',clyellow);

    AdrSuiv:=detecteur_suivant_El(det1,1,det2,1);
    AdrPrec:=detecteur_suivant_El(det2,1,det1,1);

    // le train vient de det1, quitte det2 et va vers Adr
    // il faut v�rifier si le d�tecteur pr�c�dent � �t� mis � 1 puis � 0 (on cherche 0)
    //s:='Test route pour prec='+intToSTR(AdrPrec)+' det1='+intToSTR(det1)+' det2='+IntToSTR(det2) ;
    //FormDebug.MemoDet.lines.add(s);
    if traceListe then AfficheDebug(s,clyellow);

    // trouver l'index du d�tecteur (det1) � 0
    i:=trouve_index_det_chrono(det1,0,N_Event_tick);
    if TraceListe then AfficheDebug('Index det='+intToSTR(i),clyellow);

    // et trouver l'index du d�tecteur pr�c�dent � 0 avant l'index i
    i:=trouve_index_det_chrono(AdrPrec,0,i-1);
    if TraceListe then AfficheDebug('Index prec='+intToSTR(i),clyellow);

    t:=event_det_tick[i].traite;  // d�tecteur pr�c�dent d�ja trait� ?
    if (i=0) or t then
    begin
      if (i=0) and TraceListe then AfficheDebug('La memoire prec '+intToSTR(AdrPrec)+'=0 donc route non valide',clyellow);
      if t and TraceListe then AfficheDebug('La memoire prec '+intToSTR(AdrPrec)+' a d�ja �t� trait�e donc route non valide',clyellow);
      calcul_zones_det:=0;exit;
    end;

    if TraceListe then AfficheDebug('route ok car '+IntToStr(AdrPrec)+'=0 � l''index '+intToSTR(i),clyellow);

    Mem[AdrPrec]:=false;    // inutile
    //marquer l'adresse pr�c�dente comme trait�e
    event_det_tick[i].traite:=true;
    if traceListe then AfficheDebug('Mise � 1 m�moire trait�e pour l''index '+intToSTR(i),clyellow);

    MemZone[det1,det2]:=FALSE;        // efface zone pr�c�dente
    MemZone[det2,AdrSuiv]:=TRUE;      // valide la nouveau zone
   
    //if N_trains=0 then inc(N_trains);
    // ajouter la route dans le tableau des routes
    if N_routes<2000 then inc(N_routes);
    Route[N_routes].Mem1:=det2;Route[N_routes].Mem2:=AdrSuiv;
    
    // affecter la route � un train
    if N_trains=0 then N_trains:=1;
    // premier train
    if (N_trains=1) and (Train[1].index=0) then 
    begin 
      Train[1].index:=1;Train[1].route[1].Mem1:=det2;Train[1].route[1].Mem2:=AdrSuiv;
      Train_Courant:=1;
      //FormDebug.MemoDet.lines.add('Premier train');
      Formprinc.LabelNbTrains.caption:='1';
    end
    else
    begin
      // parcourir les trains pour voir si det2 correspond � la derniere route du train explor�
      i:=1;
      repeat
        j:=Train[i].index;
        trouve:=Train[i].route[j].mem2=det2 ;
        inc(i);
      until (i>N_Trains) or trouve;
      if trouve then 
      begin
        dec(i);
        //FormDebug.MemoDet.lines.add('route train '+intToSTR(i));
        train_courant:=i;
        inc(j);
        Train[i].index:=j;Train[i].route[j].Mem1:=det2;Train[i].route[j].Mem2:=AdrSuiv; 
      end     
      else
      // nouveau train
      begin
        //FormDebug.MemoDet.lines.add('Nouveau train');
        inc(N_Trains);
        Train[N_trains].index:=1;Train[N_trains].route[1].Mem1:=det2;Train[N_trains].route[1].Mem2:=AdrSuiv;
        Train_courant:=N_trains;
        Formprinc.LabelNbTrains.caption:=IntToSTR(N_trains);
      end;
    end;

    With FormDebug.RichEdit do
    begin
      s:='train '+IntToSTR(Train_Courant)+' '+intToStr(det1)+' � '+intToStr(det2)+' => Mem '+IntToSTR(det2)+' � '+IntTOStr(AdrSuiv);
      Lines.Add(s);
      RE_ColorLine(FormDebug.RichEdit,lines.count,CouleurTrain[((Train_Courant - 1) mod 8)+1 ]);
    end;
    s:='train '+IntToSTR(Train_Courant)+' Mem '+IntToSTR(det2)+' � '+IntTOStr(AdrSuiv);
    Affiche(s,clyellow);
    
    // et effacer le premier d�tecteur de la route (det1)
    i:=1;
    repeat
      trouve:=Event_det[i]=Det1;
      if not(trouve) then inc(i);
    until (i>N_event_det) or trouve;
    if trouve then
    begin
      supprime_event(i);
      if TraceListe then AfficheDebug('Efface index '+IntToSTR(i),clyellow);
    end;
     
    calcul_zones_det:=10;  // route trouv�e et coh�rente
    exit;
  end;  
end;
  

// renvoie le d�tecteur de la zone m�moire si la m�moire MemZone[det,xxx] est � 1
// exemple si MemZone[513,517]=true alors Test_mem_origine(513) renvoie 517, sinon 0
function Test_mem_origine(det : integer) : integer ;
var i : integer;
    trouve : boolean;
begin
  i:=513;  // normalement mettre 0 pour etre compatible avec la r�trosignalisation non XpressNet
  repeat
    trouve:=memzone[det,i];
    if not(trouve) then inc(i);
  until trouve or (i>1024);
  if trouve then Test_mem_origine:=i else Test_mem_origine:=0;
end;

// mise � jour de l'�tat d'un feu en fontion de son environnement et affiche le feu
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

    Adr_det:=Feux[i].Adr_det1;  // d�tecteur sur le signal
    Adr_El_Suiv:=Feux[i].Adr_el_suiv1; // adresse �l�ment suivant au feu
    Btype_el_suivant:=Feux[i].Btype_suiv1;

    if (modele>10) then
    begin
      //Affiche('Signal directionnel '+IntToSTR(AdrFeu),clyellow);
      Signal_direction(AdrFeu);
      exit;
    end;

    etat:=etat_signal_suivant(AdrFeu,1) ;  // �tat du signal suivant + adresse du signal suivant dans Signal_Suivant

    // signaux trait�s sp�cifiquement
    if (AdrFeu=201) then
    begin
      //sprintf(Affiche,"Aiguille 27=%d \r\n",aiguillage[27].position);Display(Affiche);
      //   sprintf(Affiche,"Aiguille 31=%d \r\n",aiguillage[31].position);Display(Affiche);
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


    if (Feux[i].aspect=2) then //or (feux[i].check<>nil) then // si carr� violet
    begin
      if carre_signal(AdrFeu) and (Feux[i].aspect=2) then
      begin Maj_Etat_Signal(AdrFeu,violet) ; Envoi_signauxCplx;
       exit;
      end
      else if not(carre_signal(AdrFeu)) then //ici ya pas de check and feux[i].check.checked then
      begin Maj_Etat_Signal(AdrFeu,blanc);Envoi_signauxCplx;
        exit;
      end;
    end;

    //if AffSignal then AfficheDebug('Debut du traitement g�n�ral',clYellow);
    // traitement des feux >3 feux diff�rents de violet (cas g�n�ral)
    if (Feux[i].aspect>=3) and (EtatSignalCplx[AdrFeu]<>violet_F) then
    begin
      // d�tecteurs pr�c�dent le feu , pour d�terminer si leurs m�moires de zones sont � 1 pour lib�rer le carr�
      if Feux[i].VerrouCarre then
      begin
        if AffSignal then AfficheDebug('Le feu est verrouillable au carr�',clyellow);
        // un feu peut �tre associ� � 4 d�tecteurs (pour 4 voies)
        // il faut donc explorer les 4 d�tecteurs probables
        PresTrain:=FALSE;

        j:=1;
        repeat
          if NivDebug=3 then afficheDebug('S�quence '+IntToSTR(j)+' de recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
          if (j=1) then
          begin det_initial:=feux[i].Adr_det1;Adr_El_Suiv:=feux[i].Adr_el_suiv1;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis
          end;
          if (j=2) then
          begin
            det_initial:=feux[i].Adr_det2;Adr_El_Suiv:=feux[i].Adr_el_suiv2;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis
          end;
          if (j=3) then
          begin det_initial:=feux[i].Adr_det3;Adr_El_Suiv:=feux[i].Adr_el_suiv3;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis
          end;
          if (j=4) then
          begin
            det_initial:=feux[i].Adr_det4;Adr_El_Suiv:=feux[i].Adr_el_suiv4;
            if feux[i].Btype_suiv1=1 then Btype_el_suivant:=1;
            if feux[i].Btype_suiv1=2 then Btype_el_suivant:=2;
            if feux[i].Btype_suiv1=5 then Btype_el_suivant:=3; // le type du feu   1=d�t�cteur   2=aig  5=bis
          end;
          if (det_initial<>0) then
          begin
            DetPrec1:=detecteur_suivant(Adr_El_Suiv,Btype_el_suivant,det_initial,1);
            if DetPrec1<9997 then // route bloqu�e par aiguillage mal positionn�
            begin
              DetPrec2:=detecteur_suivant_El(det_initial,1,DetPrec1,1);
              if DetPrec2<9997 then
              begin
                DetPrec3:=detecteur_suivant_El(DetPrec1,1,DetPrec2,1);
                if DetPrec3<9997 then
                begin
                  //DetPrec4:=detecteur_suivant_det(DetPrec2,DetPrec3);
                  if AffSignal then AfficheDebug('les d�tecteurs pr�c�dents au feu '+IntToSTR(Adrfeu)+' sont:'+intToSTR(Det_initial)+' '+intToSTR(DetPrec1)+' '+intToSTR(DetPrec2)+' '+intToSTR(DetPrec3)+' ',clyellow);
                  PresTrain:=//MemZone[DetPrec4,detPrec3] or
                  MemZone[DetPrec3,detPrec2] or MemZone[DetPrec2,detPrec1] or MemZone[DetPrec1,Det_initial] or presTrain ;
             //     Affiche('MemZone'+intToSTR(DetPrec3)+' '+IntToSTR(detPrec2) = '+MemZone[DetPrec3,detPrec2]
                end;
              end;
            end;
          end;
          inc(j);
        until (j>=5);
        if presTrain and AffSignal Then afficheDebug('pr�sence train feu '+intToSTR(AdrFeu),clorange);
      end;
      if AffSignal then afficheDebug('Fin de la recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
      // si le signal peut afficher un carr� et les aiguillages apr�s le signal sont mal positionn�es ou que pas pr�sence train avant signal et signal
      // verrouillable au carr�, afficher un carr�
      car:=carre_signal(AdrFeu);
      if AffSignal and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (NivDebug>=1) and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (Feux[i].aspect>=4) and ( (not(PresTrain) and Feux[i].VerrouCarre) or car) then Maj_Etat_Signal(AdrFeu,carre)
      else
      begin
        // si on quitte le d�tecteur on affiche un s�maphore :  attention tester le sens de circulation
        // pour ne pas passer au rouge un feu � contresens.
        // trouver la m�moire de zone MemZone[Adr_det,?] qui a d�clench� le feu rouge
        if AffSignal then AfficheDebug('test du s�maphore',clYellow);
        Aff_semaphore:=test_memoire_zones(AdrFeu);  // test si pr�sence train apr�s signal
        if Aff_Semaphore then
        begin
          if AffSignal then AfficheDebug('train apr�s signal-> s�maphore ou carr�',clYellow);
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
              if  (TestBit(etat,jaune)) then Maj_Etat_Signal(AdrFeu,jaune_cli);
            end;
          end
          else
          // aiguille locale non d�vi�e
          // si le signal suivant est rouge
          begin
            if AffSignal then AfficheDebug('pas d''aiguille d�vi�e',clYellow);
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
  Maj_feux_cours:=TRUE;
  for i:=1 to NbreFeux do
  begin
    Maj_feu(Feux[i].Adresse);
  end;
  Maj_feux_cours:=FALSE;
end;


procedure rafraichit;
begin
  //Affiche('Proc�dure rafraichit',cyan);
  begin
    Maj_feux;
    //Maj_feux;
  end
end;

// met � jour le signal adr dont le d�tecteur vient d'�tre franchi dans le bon sens
procedure signal(SignalCplx,detecteurAct,detecteurSuiv : integer);
begin
  if MemZone[detecteurAct,detecteurSuiv] then if testBit(EtatSignalCplx[signalCplx],carre)=FALSE then Maj_Etat_Signal(signalCplx,semaphore);
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


// calcul des zones depuis le tableau des fronts descendants des �v�nements d�tecteurs
// transmis dans le tableau Event_det
// appell�  par front descendant sur d�tecteur
// met � jour le tableau MemZone
procedure calcul_zones ;
var i,det1,det2,index_1,index_2,index_3,resultat : integer;
   unevalide : boolean;
   s : string;
   label refaire;
begin
  uneValide:=false;
  //N_event_det pointe sur le dernier d�tecteur
  refaire:

  affiche_Event_det;

  if N_event_det<2 then begin exit;end; // pas assez de d�tecteurs pour �valuer
  // balayer index 1 � 2 puis 1 � 3 puis 1 � N_event_det et ensuite
  // de 2 � 3 puis de 2 � 4 puis de 2 � 5 etc
  index_1:=1;
  repeat
    index_2:=index_1+1;
    repeat
      det1:=event_det[index_1];
      det2:=event_det[index_2];
      //if det1=det2 then    // si d�tecteurs identiques, supprimer le 2eme
      //begin
      //  if traceListe then AfficheDebug('trouv� doublon ('+intToSTR(dat1)+')',clyellow);
      //  supprime_event(index_2);
      //  //if traceListe then for index_3:=1 to N_event_det do affiche(intToSTR(event_det[index_3]),clyellow);
      //  goto refaire;
      //end;

      if det2=detecteur_chgt then // on cherche la route pour le 2eme d�tecteur qui vient de changer
      begin
        if traceListe then
        begin
          AfficheDebug('-------Cherche route de '+intToSTR(det1)+' � '+intToSTR(det2)+' i1='+intToSTR(index_1)+' i2='+intToSTR(index_2)+' n='+intToSTR(N_event_det),clyellow);
        end;
        resultat:=calcul_zones_det(det1,det2);
        if resultat=10 then
        begin
          s:='route trait�e de '+intToSTR(det1)+' � '+IntToSTR(det2);
          FormDebug.MemoEvtDet.lines.add(s);
          if traceListe then AfficheDebug(s,clyellow);
          uneValide:=true;
          FormDebug.MemoEvtDet.lines.add('Nouveau Tampon:');
          affiche_Event_det;
        end;

        // d�tecteur1 non trouv�
        if resultat=1 then begin supprime_event(index_1);goto refaire;end;
        // d�tecteur2 non trouv�
        if resultat=2 then begin supprime_event(index_2);goto refaire;end;

      end;
      inc(index_2);
      //Affiche('index2='+IntToSTR(index_2),clyellow);
      until (index_2>N_event_det);
      inc(index_1);
    until (index_1>=N_event_det);
    // si on a trouv� au moins une route valide, rafraichir les signaux
    if uneValide then
    begin
      rafraichit;
      rafraichit;
      rafraichit;
    end;
end;

// demande l'�tat d'un accessoire � la centrale. Le r�sultat sera r�ceptionn� sur r�ception des informations
// de r�trosignalisation.
procedure demande_info_acc(adresse : integer);
var s : string;
    n : integer;
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

// demande l'�tat de tous les accessoires
procedure demande_etat_acc;
var i : integer;
begin
  Affiche('Demande �tat des aiguillages',ClYellow);
  for i:=1 to maxaiguillage do
  begin
    demande_info_acc(i);
  end;
end;

// affecte le num�ro de train � un �v�nement d�tecteur
// en sortie : num�ro de train
{
function affecte_train(index,AdresseAdj,AdresseActuel,etat : integer) : integer;
var i,train : integer;
    trouve : boolean;
begin
  if AffAffect then AfficheDebug('Cherche train pour Index='+intToSTR(index)+' pour d�tecteur='+intToStr(AdresseAdj)+' � '+intToStr(Etat),clyellow);
  train:=0;
  if index<2 then begin Affecte_train:=1;exit;end;
  i:=index;
  repeat
    dec(i);
    trouve:=event_det_tick[i].detecteur[AdresseAdj]=etat; // si le d�tecteur � rechercher en amont de la liste est � "etat"
  until trouve or (i=1);
  if trouve then
  begin
    train:=event_det_tick[i].train;
    //if train<>0 then
    begin
      if AffAffect then AfficheDebug('Affectation au train n�'+intToSTR(train),clyellow);
      event_det_tick[N_event_tick].train:=train;
      event_det_tick[N_event_tick].suivant:=AdresseActuel;

      //event_det_tick[i].train:=0; // trait�
    end;
  end
  else
    if AffAffect then AfficheDebug('Pas trouv�',clyellow);
  affecte_train:=train;
end;
}

// traitement sur les �v�nements d�tecteurs
procedure Event_Detecteur(Adresse : integer;etat : boolean);
var i,trainAdj1,TrainAdj2,TrainActuel,Etat01 : integer;
    s : string;
begin
  if Etat then Etat01:=1 else Etat01:=0;
  // v�rifier si l'�tat du d�tecteur est d�ja stock�, car on peut re�evoir plusieurs �v�nements pour le m�me d�tecteur dans le m�me �tat
  // on re�oit un doublon dans deux index cons�cutifs.
  if N_Event_tick>=1 then
  begin
    //Affiche('Event_det_tick['+intToSTR(N_event_tick)+'].detecteur['+intToSTR(Adresse)+']='+intToSTr(event_det_tick[N_event_tick].detecteur[Adresse]),clyellow);
    if event_det_tick[N_event_tick].detecteur[Adresse]=etat01 then exit;    // d�ja stock�
  end;

  if Traceliste then AfficheDebug('--------------------- d�tecteur '+intToSTR(Adresse)+' � '+intToSTR(etat01)+'-----------------------------',clOrange);

  //if etat then Mem[Adresse]:=true;  // m�moriser l'�tat � 1

  ancien_detecteur[Adresse]:=detecteur[Adresse];
  detecteur[Adresse]:=etat;
  detecteur_chgt:=Adresse;
  
  // mise a jour du tableau evt de fronts descendants
  if ancien_detecteur[Adresse] and not(detecteur[Adresse]) and (N_Event_det<20) then
  begin
    //Affiche('front descendant',clyellow);
    inc(N_event_det);
    event_det[N_event_det]:=Adresse;
    calcul_zones;  // en avant les calculs
  end;
  
  // stocke les changements d'�tat des d�tecteurs dans le tableau chronologique
  if (N_Event_tick<Max_Event_det_tick) then
  begin
    inc(N_Event_tick);
//    event_det_tick[N_event_tick].train:=0;

    event_det_tick[N_event_tick].tick:=tick;
    event_det_tick[N_event_tick].detecteur[Adresse]:=etat01;
   // Affiche('stockage de '+intToSTR(N_event_tick)+' � '+intToSTR(etat01),clyellow);
  end;

  exit;
  //------------------------plus utilis� ----------------
  {
  // front descendant
    if etat01=0 then
    begin
//      affecte_train(N_event_tick,Adresse,0,1); // affecter le num�ro du train dont l'adresse du d�tecteur est � 1
    end;
    if etat01=1 then
    begin
      det_adj(Adresse); // d�tecteurs adjacents � Adr (adj1 et adj2)
      if Adj1>9997 then Adj1:=0;
      if Adj2>9997 then Adj2:=0;
      if AffAffect then AfficheDebug('Det='+intToStr(Adresse)+' Adj1='+intToStr(Adj1)+' Adj2='+intToStr(Adj2),clyellow);

      //affecter le num�ro de train sur l'un des deux d�tecteurs adjacents � 0
      if adj1<>0 then trainAdj1:=affecte_train(N_event_tick,Adj1,Adj2,0); // affecter le num�ro du train dont l'adresse du d�tecteur est � 0
      if adj2<>0 then trainAdj2:=affecte_train(N_event_tick,Adj2,Adj1,0); // affecter le num�ro du train dont l'adresse du d�tecteur est � 0
      if AffAffect then AfficheDebug('Det='+intToSTR(Adresse)+' TrainAdj1='+intToSTR(TrainAdj1)+' TrainAdj2='+intToSTR(TrainAdj2),clyellow);
      if (trainAdj1=0) and (TrainAdj2=0) then
      begin
        inc(N_trains);
        if AffAffect then
        begin
          s:='Nouveau train sur '+intToSTR(Adresse)+'='+intToSTR(N_trains);
          affiche(s,clyellow);
          afficheDebug(s,clyellow);
        end;
        event_det_tick[N_event_tick].train:=N_trains;
      end;
    end;
   }
end;

// �v�nement d'aiguillage
procedure Event_Aig(adresse : integer);
var i,index1,index2,AdresseE,Adet,det_suiv,pos,Btype,BtypeE,train1,train2,train,
    index : integer;
    trouve,trouve1,trouve2 : boolean;
begin
  exit;
  {
  // -------------------------plus utilis� ----------------
  if N_Event_tick<2 then exit;
  // attribue un train et un d�tecteur sur un �v�nement aiguillage
  // �tape 1 trouver le d�tecteur
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
      // trouver le d�tecteur avant l'aiguillage - attention pr�voir aiguillage BIS (btype=3)
      Det_Suiv:=suivant_alg3(adresseE,BtypeE,Adet,Btype,1) ;
      adresseE:=Adet; BtypeE:=Btype;
      Adet:=Det_Suiv;Btype:=TypeGen;
      inc(i);
    until (typeGen=1) or (i>20);
  end;
  if (i>20) then begin Affiche('Erreur 671',clRed);exit;end;
  Affiche('le d�tecteur suivant sur aiguillage '+intToSTR(adresse)+' est '+intToSTR(Adet),clyellow);

  // �tape 2 : trouver si un train est sur le d�tecteur dans le tableau event_det_tick
  i:=N_Event_tick;
  repeat
    dec(i);
    trouve:=event_det_tick[i].detecteur[Adet]=1; // si le d�tecteur � rechercher en amont de la liste est � "etat"
    //train:=event_det_tick[i].train;
    index:=i;
  until trouve or (i=1);
  if trouve then
  begin
    Affiche('d�tecteur '+intToSTR(Adet)+' � 1',clyellow);
    // il y a a un train dessus,
    det_adj(Adet); // trouver les d�tecteurs adjacents (adj1 et adj2)
    Affiche('Adj1='+intToSTR(Adj1)+' Adj2='+intToSTR(Adj2),clyellow);
    // trouver le d�tecteur adjacent
    i:=N_Event_tick;
    trouve1:=false;trouve2:=false;
    repeat
      dec(i);
      if not(trouve1) then
      begin
        trouve1:=event_det_tick[i].detecteur[Adj1]=1;index1:=i; // si le d�tecteur
        train1:=event_det_tick[index1].train;
      end;
      if not(trouve2) then
      begin
        trouve2:=event_det_tick[i].detecteur[Adj2]=1;index2:=i;
        train2:=event_det_tick[index2].train;
      end; // si le d�tecteur � rechercher en amont de la liste est � 1
    until (trouve1 and trouve2) or (i=1);

    if not(trouve1) and not(trouve2) then affiche('pas trouve adj1 ni adj2 � 1',clOrange);
    if trouve1 and (train1=train) then
    begin
      Affiche(' d�tecteur Adj1='+intToSTR(Adj1)+' train='+intToSTR(train),clyellow);
      event_det_tick[index1].suivant:=Adet;
      event_det_tick[index].suivant:=Adj2;

    end;
    if trouve2 and (train2=train) then
    begin
      Affiche(' d�tecteur Adj2='+intToSTR(Adj2)+' train='+intToSTR(train),clyellow);
      event_det_tick[index2].suivant:=Adet;
      event_det_tick[index].suivant:=Adj1;
    end;


  end;
   }
end;



// le d�codage de la r�tro est appell�e sur une r�ception d'une trame de la r�trosignalisation.
// On d�clenche ensuite le rafraichissement
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
      if detecteur[i]<>((valeur and $8) = $8) then  // si changement de l'�tat du d�tecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8);
      end;

      i:=adresse*8+7;
      if detecteur[i]<>((valeur and $4) = $4) then  // si changement de l'�tat du d�tecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4);
      end;

      i:=adresse*8+6;
      if detecteur[i]<>((valeur and $2) = $2) then  // si changement de l'�tat du d�tecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2);
      end;

      i:=adresse*8+5;
      if detecteur[i]<>((valeur and $1) = $1) then  // si changement de l'�tat du d�tecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1); 
      end;
    end;

    // �tat de l'aiguillage
    if bitsITT=$00 then // module d'aiguillages, N=1
    begin
      adraig:=((adresse * 4)+1 ); // *4 car N=1, c'est le "poids fort"
      if (valeur and $C)=$8 then
      begin
        aiguillage[adraig+3].position:=2 ; // �tat aiguillage haut
        Event_Aig(adraig+3);
        if trace then begin s:='accessoire '+intToSTR(adraig+3)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        aiguillage[adraig+3].position:=1 ; // �tat aiguillage haut
        Event_Aig(adraig+3);
        if trace then begin s:='accessoire '+intToSTR(adraig+3)+'=1';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        aiguillage[adraig+2].position:=2; // �tat aiguillage bas
        Event_Aig(adraig+2);
        if trace then begin s:='accessoire '+intToSTR(adraig+2)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        aiguillage[adraig+2].position:=1; // �tat aiguillage bas
        Event_Aig(adraig+2);
        if trace then begin s:='accessoire '+intToSTR(adraig+2)+'=1';Affiche(s,clYellow);end;
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
      if detecteur[i]<>((valeur and $8) = $8) then  // si changement de l'�tat du d�tecteur bit 7
      begin
        Event_detecteur(i,(valeur and $8) = $8); 
      end;
      i:=adresse*8+3;
      if detecteur[i]<>((valeur and $4) = $4) then  // si changement de l'�tat du d�tecteur bit 6
      begin
        Event_detecteur(i,(valeur and $4) = $4); 
      end;

      i:=adresse*8+2;
      if detecteur[i]<>((valeur and $2) = $2) then  // si changement de l'�tat du d�tecteur bit 5
      begin
        Event_detecteur(i,(valeur and $2) = $2); 
      end;

      i:=adresse*8+1;
      if detecteur[i]<>((valeur and $1) = $1) then  // si changement de l'�tat du d�tecteur bit 4
      begin
        Event_detecteur(i,(valeur and $1) = $1); 
      end;

    end;
    if bitsITT=$00 then // module d'aiguillages
    begin
      adraig:=(adresse * 4)+1;
      if (valeur and $C)=$8 then
      begin
        aiguillage[adraig+1].position:=2 ; // �tat aiguillage haut
        Event_Aig(adraig+1);
        if trace then begin s:='accessoire '+intToSTR(adraig+1)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        aiguillage[adraig+1].position:=1 ; // �tat aiguillage haut
        Event_Aig(adraig+1);
        if trace then begin s:='accessoire '+intToSTR(adraig+1)+'=1';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        aiguillage[adraig].position:=2; // �tat aiguillage bas
        Event_Aig(adraig);
        if trace then begin s:='accessoire '+intToSTR(adraig)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        aiguillage[adraig].position:=1; // �tat aiguillage bas
        Event_Aig(adraig);
        if trace then begin s:='accessoire '+intToSTR(adraig)+'=1';Affiche(s,clYellow);end;
      end;

    end;
  end;
end;

function Xdecode_chaine_retro(s : string) : string;
var i : integer;
    chaineInt : string;
begin
  chaineInt:=s;

  // r�ponse de l'information des accessoires
  if s[1]=#$42 then
  begin
    delete(chaineInt,1,1);
    //Xdecode_retro(ord(chaineInt[1]),ord(chaineInt[2]));
    delete(chaineInt,1,3);
  end
  else
  begin
    if s[1]=#$81 then
    begin
      delete(chaineInt,1,2);
      Affiche('Voie hors tension msg1',clRed);
      Hors_tension2:=true;
    end
    else
    begin
      if s[1]=#$61 then
      begin
        delete(chaineInt,1,2);
        Affiche('Voie hors tension msg2',clRed);
        Hors_tension2:=false;
      end
      else
      begin
        i:=pos(#$46+#$43+#$40,chaineInt);
        if (i<>0) and (length(chaineInt)>=3) then
        begin
          delete(chaineInt,1,3);
          Affiche('Reprise msg 1',clOrange);
          Hors_tension2:=false;
        end
        else
        begin
          i:=pos(#$46+#$43+#$50,chaineInt);
          if (i<>0) and (length(chaineInt)>=3) then
          begin
            delete(chaineInt,1,3);
            Affiche('Reprise msg 2',clOrange);
            Hors_tension2:=false;
          end
          else
          begin
            affiche('Erreur 2, cha�ne r�trosig. inconnue recue:',clRed);
            affiche(chaine_HEX(chaineInt),clred);
            chaineInt:='';
          end;
        end;
      end;
    end;
  end;
  Xdecode_chaine_retro:=chaineint;
end;

// d�codage d'une chaine simple de la r�trosignalisation
function decode_chaine_retro(chaineINT : string) : string ;
var msg : string;
    i,cv : integer;
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
    #4 :  begin msg:='succ�s';end;
    #5 :  begin nack:=true;msg:='plus de time slot';end;
    #6 :  begin nack:=true;msg:='d�bordement tampon LI100';end;
    end;
    if trace and (chaineINT[2]=#4) then Affiche(msg,clYellow);
    if trace and (chaineINT[2]<>#4) then Affiche(msg,clRed);
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
    // r�ception d'un CV. DocXpressNet p26

    delete(chaineInt,1,2);
    cv:=ord(chaineINT[1]);
    Affiche('R�ception CV'+IntToSTR(cv)+' � '+IntToSTR(ord(chaineINT[2])),clyellow);
    if cv>255 then Affiche('Erreur Recu CV>255',clRed)
    else
    begin
       tablo_cv[cv]:=ord(chaineINT[2]);
       inc(N_Cv); // nombre de CV recus
    end;
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
        Affiche('Demande ouverture com'+intToSTR(nuMPort)+':'+ConfStCom+','+IntToSTR(protocole),CLYellow);
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
        LabelTitre.caption:=titre+' Interface connect�e au COM'+IntToSTR(NumPort);
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
   V_utile,V_publie : real;
begin
  //AvecMaj:=false;
  TraceSign:=True;
  AF:='Client TCP-IP CDM Rail ou USB - syst�me LENZ - Version '+Version;
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
  DebugOuv:=True;

  //LireunaccessoireversunfichierdeCV1.Visible:=false;

  AvecInit:=true; //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  AvecTCO:=false;


  // cr��e la fenetre v�rification de version
  FormVersion:=TformVersion.Create(Self);

  ferme:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  Nbre_recu_cdm:=0;
  AffMem:=true;
  N_routes:=0;
  N_trains:=0;
  Train[1].index:=0;

  // lecture fichier de configuration  config.cfg
  lit_config;
  
  // TCO
  if avectco then
  begin
    //cr��e la fen�tre TCO
    FormTCO:=TformTCO.Create(Self);
    FormTCO.show;
    construit_TCO;
    affiche_TCO;
    //Formprinc.Hide;
  end;  


 
  // tenter la liaison vers CDM rail ou vers la centrale Lenz
  //Affiche('Test pr�sence CDM',clYellow);
  connecte_CDM;
  if not(CDM_connecte) then        // si CDM est connect�, on n'ouvre pas de liaison vers la centrale
  begin
    Affiche('CDM absent - Ouverture liaison vers centrale Lenz',clYellow);
    // ouverture par USB
    Affiche('demande connexion � la centrale Lenz par USB',clyellow);
    connecte_USB;
    if not(portCommOuvert) then
    begin
      // sinon ouvrir socket vers la centrale
      // Initialisation de la comm socket LENZ
      if AdresseIP<>'0' then
      begin
        Affiche('demande connexion � la centrale Lenz par Ethernet',clyellow);
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
    LireunaccessoireversunfichierdeCV1.Enabled:=true;
  end
  else
  With Formprinc do
  begin
    ButtonEcrCV.Enabled:=false;
    LireunfichierdeCV1.enabled:=false;
    LireunaccessoireversunfichierdeCV1.Enabled:=false;
  end ;
  
  // Initialisation des images des signaux
  NbreImagePLigne:=Formprinc.ScrollBox1.Width div (largImg+5);

  // ajoute une image dynamiquement
  for i:=1 to NbreFeux do
  begin
    cree_image(i);  // et initialisation tableaux signaux
  end;
  Tempo_init:=10;  // d�marre les initialisation des signaux et des aiguillages dans 1 s

  // initialisation de la chronologie des �v�nements d�tecteurs
  for i:=0 to Max_Event_det_tick do
  begin
    for j:=1 to 1100 do
    event_det_tick[i].detecteur[j]:=-1;   // initialiser les d�tecteurs � -1
    event_det_tick[i].traite:=false ; // non trait�
  end;

  I_Simule:=0;
  tick:=0;

  N_Event_tick:=0 ; // dernier index
  NombreImages:=0;
  
  // �num�ration des ports USB
  //EnumerateDevices;
  //for i:=1 to NumLine do
  //begin
  //  if pos('Ports',Line[i])<>0 then Affiche(Line[i],clyellow);
  //end;
  
  //essai
 // event_det[1]:=527;
 // event_det[2]:=520;
 // N_event_det:=2;
   //aiguillage[20].Position:=const_droit+1;
   //aiguillage[12].Position:=const_droit+1;
  //traceDet:=true;
 // calcul_zones;
  //maj_feu(201);
  //etat_signal_suivant(201,1);
  //Aiguille_deviee(462);
 //NivDebug:=3;
 //formdebug.Show;
 //AfficheDet:=true;
  //aiguillageB[1].Position:=1;
  //i:=suivant_alg3(553,1,1,3,1);
  //Affichedebug(intToSTr(i),clred);
  //Affiche(IntToSTR(calcul_zones_det(522,514)),clyellow);
  //test_memoire_zones(1011);
  //i:=detecteur_suivant_El(514,1,518,1);  // donne l'�l�ment suivant de AdrPrec � AdrFonc et dans Bis si c'est un aig bis
  //i:=etat_signal_suivant(1001,1);
 // Affiche(IntToSTR(detecteur_suivant(25,2,529,1)),clyellow);
  //i:=Aiguille_deviee(176);
  //signal_direction(372);
  //FormDebug.show;
  //NivDebug:=3;
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
end;


// �v�nement r�ception d'une trame sur le port COM USB (centrale Lenz)
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
      if pos=1 then s:=s+' (d�vi�)' else s:=s+' (droit)';
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



// timer � 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var i,a : integer;
begin
  inc(tick);

  if Tempo_init>0 then dec(Tempo_init);
  if (Tempo_init=1) and AvecInit then
  begin
    Affiche('Positionnement des feux',clYellow);
    if not(ferme) then envoi_signauxCplx;  // initialisation des feux
    if not(ferme) and (AvecInitAiguillages=1) then
    begin
      Affiche('Positionnement des aiguillages',clYellow);
      init_aiguillages;   // initialisation des aiguillages
    end;
    if (AvecInitAiguillages=0) and not(ferme) and (parSocket or portCommOuvert) then
    begin
      demande_etat_acc;   // demande l'�tat des accessoires (position des aiguillages)
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
      a:=EtatsignalCplx[feux[i].adresse];     // a = �tat binaire du feu
      if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
         TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
         testBit(a,vert_cli) or testbit(a,blanc_cli) then
         Dessine_feu(feux[i].adresse);  // dessiner le feu en fonction du bit "clignotant"
    end;
    if AdrPilote<>0 then
    begin
      a:=EtatsignalCplx[0];
      if TestBit(a,jaune_cli) or TestBit(a,ral_60) or
         TestBit(a,rappel_60) or testBit(a,semaphore_cli) or
         testBit(a,vert_cli) or testbit(a,blanc_cli) then
         Dessine_feu_pilote;  // dessiner le feu en fonction du bit "clignotant"
    end;
  end;

  // affiche la trame recue de l'interface apr�s 500ms
  if TpsRecuCom<5 then inc(TpsRecuCom);
  if TpsRecuCom=5 then
  begin
    if trace then Affiche_chaine_hex(chaine_recue,clFuchsia); // en hexa ascii
    chaine_recue:='';
    TpsRecuCom:=6;
  end;

  if (not(Maj_feux_cours) and (Tempo_chgt_feux=1)) then Maj_feux(); // mise � jour des feux sur chgt aiguillage

  if (not(Maj_feux_cours) and (Tempo_chgt_feux>0)) then dec(Tempo_chgt_feux);


  //simulation
  if index_simule<>0 then 
  begin
    if not(MsgSim) then begin Affiche('Simulation en cours ',Cyan);MsgSim:=true;end;
    while tick=Tablo_simule[i_simule+1].tick do
    begin
      inc(I_simule);
      Affiche('Simulation tick='+IntToSTR(tick)+' det='+intToSTR(Tablo_simule[i_simule].detecteur)+'='+IntToSTR(Tablo_simule[i_simule].etat),Cyan);
      Event_Detecteur(Tablo_simule[i_simule].detecteur, Tablo_simule[i_simule].etat=1);  // cr�er �vt d�tecteur
    end;
    if i_Simule>=Index_simule then
    begin
      Index_Simule:=0;  // fin de simulation
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
  val(EditVal.Text,valeur,erreur);
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
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
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
   10053 : s:=s+': Connexion avort�e - Timeout';
   10054 : s:=s+': Connexion avort�e par tiers';
   10060 : s:=s+': Timeout';
   10061 : s:=s+': Connexion refus�e';
   10065 : s:=s+': Port non connect�';
   end;
   affiche(s,ClRed);
   afficheDebug(s,ClRed);
   CDM_connecte:=false;
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
  Affiche('Il est n�cessaire de renseigner le fichier config.cfg',ClOrange);
  Affiche('En vert : Trames envoy�es � l''interface',ClWhite);
  Affiche('En blanc : Trames re�ues de l''interface',ClWhite);
  Affiche('En violet : Trames brutes re�ues de l''interface',ClWhite);
  Affiche('En rouge : erreurs et d�fauts',ClWhite);
  Affiche('En orange : pilotage des signaux',ClWhite);
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
   s:='D�t '+intToSTR(Adresse_detecteur[j])+'=';
   if Detecteur[adresse_detecteur[j]] then s:=s+'1' else s:=s+'0';
   s:=s+' Mem=';
   if Mem[adresse_detecteur[j]] then s:=s+'1' else s:=s+'0';
   Affiche(s,clYellow);
  end;
end;

procedure TFormPrinc.Etatdesaiguillages1Click(Sender: TObject);
var i : integer;
    s : string;
begin
  Affiche('les positions des aiguillages BIS sont les m�mes que leurs homologues non bis',Cyan);
  for i:=1 to MaxAcc do
  begin
    if aiguillage[i].modele<>0 then
    begin
      s:='Aiguillage '+IntToSTR(i)+' : '+intToSTR(aiguillage[i].position);
      if aiguillage[i].position=1 then s:=s+' (d�vi�)' else s:=s+' (droit)';
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
      if aiguillage[i].modele=2 then s:=s+' TJD: centre TJD=';
      if aiguillage[i].modele=3 then s:=s+' TJS:';
      if aiguillage[i].modele=4 then s:=s+' Triple: Pointe=';
      s:=s+IntToSTR(aiguillage[i].APointe)+aiguillage[i].APointeB+
         ' D�vie='+IntToSTR(aiguillage[i].ADevie)+aiguillage[i].ADevieB+
         ' Droit='+IntToSTR(aiguillage[i].ADroit)+aiguillage[i].ADroitB;
      if aiguillage[i].modele=4 then s:=s+' D�vi�2='+intToSTR(aiguillage[i].ADevie2)+aiguillage[i].ADevie2B;
      if aiguillage[i].vitesse<>0 then s:=s+' Vitesse d�vi�e='+intToSTR(aiguillage[i].vitesse);
    end
    else
      s:=s+' absent';
    Affiche(s,clYellow);
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
         ' D�vie='+IntToSTR(aiguillageB[i].ADevie)+aiguillageB[i].ADevieB+
         ' Droit='+IntToSTR(aiguillageB[i].ADroit)+aiguillageB[i].ADroitB;
      if aiguillageB[i].modele=4 then s:=s+' D�vi�2='+intToSTR(aiguillageB[i].ADevie2)+aiguillageB[i].ADevie2B;
      if aiguillageB[i].vitesse<>0 then s:=s+' Vitesse d�vi�e='+intToSTR(aiguillageB[i].vitesse);
    end
    else
      s:=s+' absent';

    Affiche(s,clYellow);
  end;
end;


procedure TFormPrinc.ClientSocketLenzConnect(Sender: TObject;Socket: TCustomWinSocket);
begin
  Affiche('Lenz connect� ',clYellow);
  AfficheDebug('Lenz connect� ',clYellow);
  parSocket:=True;
  ButtonEcrCV.Enabled:=true;
  LireunfichierdeCV1.enabled:=true;
  LireunaccessoireversunfichierdeCV1.Enabled:=true;
  LabelTitre.caption:=titre+' Interface connect�e par Ethernet';
end;

procedure TFormPrinc.ClientSocketCDMConnect(Sender: TObject;Socket: TCustomWinSocket);
var s : string;
begin
  s:='Socket CDM rail connect�';
  LabelTitre.caption:=titre+' '+s;
  Affiche(s,clYellow);
  AfficheDebug(s,clYellow);
  parSocketCDM:=True;
  MenuConnecterUSB.enabled:=false;
  DeConnecterUSB.enabled:=false;
  ConnecterCDMRail.enabled:=false;
  
end;

// r�ception d'un message de CDM rail
procedure TFormPrinc.ClientSocketCDMRead(Sender: TObject;Socket: TCustomWinSocket);
  var i,j,k,erreur, adr,adr2,etat,etataig : integer ;
      s,ss : string;
      traite,sort : boolean;
begin
  inc(Nbre_recu_cdm);
  recuCDM:=ClientSocketCDM.Socket.ReceiveText;

  // Affiche('recu de CDM:',clWhite);Affiche(recuCDM,clWhite);
  AckCDM:=recuCDM<>'';
  if pos('ACK',recuCDM)=0 then
  begin
    if pos('ERR=200',recuCDM)<>0 then Affiche('Erreur CDM : r�seau non charg�',clred);
  end;
  k:=0;
  repeat
    //Affiche('K='+intToSTR(k)+' longueur='+intToSTR(length(recuCDM)),clyellow);
    //Affiche(recuCDM,clwhite);
    // �v�nement aiguillage. Le champ AD2 n'est pas forc�ment pr�sent
    j:=pos('CMDACC-ST_TO',recuCDM);
    if j<>0 then
    begin
      //Affiche(recuCDM,cllime);
      i:=posEx('AD=',recuCDM,j);ss:=copy(recuCDM,i+3,10);  //Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
      if i<j then begin Affiche('Erreur 96',clred);exit;end;
      val(ss,adr,erreur);
      //Affiche(copy(recuCDM,j,i+80),clOrange);
      //i:=posEx('AD2=',recuCDM,i);ss:=copy(recuCDM,i+3,10);  Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
      //val(ss,adr2,erreur);
      i:=posEx('STATE=',recuCDM,i);ss:=copy(recuCDM,i+6,10); //Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
      if i<j then begin Affiche('Erreur 97',clred);exit;end;
      if i+5-j>0 then begin Delete(recuCDM,j,i+5-j) ;end else
      begin
        Affiche('Erreur 95',clred);
        Affiche('j='+IntToSTR(j)+' i='+intToSTR(i),clred);
        Nbre_recu_cdm:=0;
        Affiche(recuCDM,clred);
        exit;
      end;
      val(ss,etat,erreur);

      // conversion en position : 1=d�vi� (CDM envoie 2 ou 1)  2=droit (CDM envoie 0)
      if etat=0 then etatAig:=2 else etatAig:=1;
      aiguillage[adr].position:=etatAig;
      aiguillageB[adr].position:=etatAig;
      Event_Aig(adr);
      Tempo_chgt_feux:=10; // demander la mise � jour des feux
      //Affiche('Aiguillage '+intToSTR(adr)+'='+IntToStr(etatAig),clYellow);
      //Affiche(recuCDM,CLOrange);
      //if length(recuCDM)>80 then Affiche(copy(recuCDM,80,length(recuCDM)-80),clOrange);
    end;

    // �v�nement d�tecteur
    j:=pos('CMDACC-ST_DT',recuCDM);
    if j<>0 then
    begin
      i:=posEx('AD=',recuCDM,j);ss:=copy(recuCDM,i+3,10);
      val(ss,adr,erreur);
      i:=posEx('STATE=',recuCDM,j);ss:=copy(recuCDM,i+6,10);
      Delete(recuCDM,j,i+5-j);
      val(ss,etat,erreur);
      Event_detecteur(Adr,etat=1);
      //FormDebug.MemoDet.Lines.Add(IntToSTR(adr)+' '+IntToSTR(etat));
       
      if AfficheDet then Affiche('R�tro D�tecteur '+intToSTR(adr)+'='+IntToStr(etat),clYellow);
    end ;

    inc(k);
    //traite:=(k<30) or (pos('CMDACC-ST_TO',recuCDM)<>0) or (pos('CMDACC-ST_DT',recuCDM)<>0) ;
    sort:=(k>70) or (pos('CMDACC-ST_TO',recuCDM)=0) and (pos('CMDACC-ST_DT',recuCDM)=0);
  until (sort);

  //Affiche('Ligne trait�e'+recuCDM,clLime);
  if k>=70 then begin Affiche('Erreur 90 : Longrestante='+IntToSTR(length(recuCDM)),clred); Affiche(recuCDM,clred);  end;
  Nbre_recu_cdm:=0;
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
  Affiche('CDM rail d�connect�',Cyan);
  AfficheDebug('CDM rail d�connect�',Cyan);
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
    s:=IntToSTR(i)+' Adresse='+IntToSTR(feux[i].Adresse);
    s:=s+' d�codeur='+IntToStr(feux[i].decodeur);

    if feux[i].aspect<10 then
    begin
      s:=s+' SIG Nombre de feux='+IntToSTR(feux[i].aspect)+' ';
      s:=s+' El Suivant1='+IntToSTR(feux[i].Adr_el_suiv1)+' Type suivant1='+intToSTR(feux[i].Btype_suiv1);

      if feux[i].decodeur=6 then
      s:=s+' Cible unisemaf='+intToSTR(feux[i].Unisemaf);
    end
    else
    // feu directionnel
    begin
      s:=s+' DIR Nombre de feux='+IntToSTR(feux[i].aspect-10)+' ';
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
   Affiche('Version 1.0  : premi�re version',clLime);
   Affiche('Version 1.01 : gestion des trajectoires vers les buttoirs',clLime);
   Affiche('Version 1.02 : v�rification automatique des versions',clLime);
   Affiche('Version 1.1  : gestion des tableaux indicateurs de direction',clLime);
   Affiche('                    gestion du d�codeur de signaux Unisemaf Paco (exp�rimental)',clLime);
   Affiche('                    changement dynamique des feux en cliquant sur son image',clLime);
   Affiche('Version 1.11 : compatibilit� pour la r�trosignalisation non XpressNet (intellibox)',clLime);
   Affiche('                    verrouillages routes pour trains cons�cutifs',clLime);
   Affiche('Version 1.2  : Renforcement de l''algorithme de suivi des trains',clLime);
   Affiche('Version 1.3  : D�codeur Unisemaf fonctionnel - Lecture/�criture des CV',clLime);
   Affiche('                     Protocoles variables de l''interface',clLime);
   Affiche('                     Configuration statique modifiable dans menu',clLime);
   
end;

procedure TFormPrinc.ClientSocketLenzDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  parSocket:=False;
end;

procedure TFormPrinc.ChronoDetectClick(Sender: TObject);
var i,j,etat : integer;
    s : string;
    trouve : boolean;
begin
  for i:=1 to N_Event_tick do
  begin
    s:=IntToSTR(i)+' Tick='+IntToSTR(event_det_tick[i].tick)+' Det=';
    trouve:=false;
    for j:=1 to 1100 do
    begin
      etat:=event_det_tick[i].detecteur[j];
      if etat<>-1 then
      begin
        s:=s+IntToSTR(j)+'='+intToSTR(etat);
        //s:=s+' Train n�'+intTostr(event_det_tick[i].Train);
        s:=s+' Det suiv='+intTostr(event_det_tick[i].suivant);

        trouve:=true;
      end;
    end;
    if trouve then Affiche(s,clyellow);
  end;

end;


procedure TFormPrinc.FichierSimuClick(Sender: TObject);
begin
  FormSimulation.showModal;
  //TraceListe:=true;
end;

procedure TFormPrinc.ButtonEcrCVClick(Sender: TObject);
var adr,valeur,erreur : integer;
    s : string;
begin
  // doc XpressNet page 55
  val(EditAdresse.text,adr,erreur);
  val(EditVal.Text,valeur,erreur);
  if (Adr>255) or (valeur>255) then exit;
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

procedure TFormPrinc.LireunaccessoireversunfichierdeCV1Click(Sender: TObject);
var s,sa: string;
    fte : textfile;
    i,cv,valeur,erreur : integer;
begin
  s:=GetCurrentDir;
  //s:='C:\Program Files (x86)\Borland\Delphi7\Projects\Signaux_complexes_GL';
  N_Cv:=0; // nombre de CV recus � 0
  sa:='';
  //for cv:=1 to 255 do
  begin
        cv:=3;
        trace:=true;
        //s:=#$ff+#$fe+#$22+#$15+Char(cv);      //CV de 1 � 256 (V3.0)
        s:=#$22+#$18+Char(cv);      //CV de 1 � 255 + 1024 (V3.6)
        s:=checksum(s);
        // envoi(s);     // envoi de la trame et attente Ack, la premiere trame fait passer la centrale en mode programmation (service)
        envoi_ss_ack(s);
        Tempo(1);

        s:=#$21+#$10+Char(cv);      // demande d'envoi du r�sultat du mode service
        s:=checksum(s);
        //envoi(s);
        envoi_ss_ack(s);
        Tempo(1);

        // attente de la r�ponse de la centrale
        tablo_CV[cv]:=0;
        i:=0;
        repeat
          Tempo(2); // attend 200 ms
          inc(i);
        // N_cv:=cv;
        until (N_cv=cv) or (i>4);
        if (i>4) then
        begin
          Affiche('Erreur attente trop longue CV',clred);
          exit;
        end;
        //tablo_cv[cv]:=123;
        sa:=sa+'Cv'+IntToSTR(cv)+'='+IntToSTR(Tablo_cv[cv])+' ';
        if cv mod 9=0 then
        begin
           Affiche(sa,clyellow);sa:='';
        end;
  end;
  Affiche(sa,clyellow);sa:='';

  with FormPrinc.SaveDialog do
  begin
    InitialDir:=s;
    title:='Ecrire un nom de fichier dans lequel sauvegarder les CV';
    DefaultExt:='txt';
    Filter:='Fichiers texte (*.txt)|*.txt|Tous fichiers (*.*)|*.*';

    if Execute then
    begin
      s:=FileName;
      assignFile(fte,s);
      rewrite(fte);
      Writeln(fte,'cv   valeur');
      for cv:=1 to 255 do
      begin
        s:=IntToSTR(cv)+'  '+intToSTR(tablo_CV[cv]);
        Writeln(fte,s);
      end;
      closeFile(fte);
    end;
  end;
end;


procedure TFormPrinc.Quitter1Click(Sender: TObject);
begin
   close;
end;

procedure TFormPrinc.Button1Click(Sender: TObject);
var s : string;
begin
  s:=EditGenli.text; //+#13+#10+#10;
  terminal:=true;
  if portCommOuvert then
  begin
    Affiche('Envoi a genli de '+ EditGenli.text,clorange);
    envoi_ss_ack(s);
  end;
end;

procedure TFormPrinc.Button2Click(Sender: TObject);
begin
  if MSCommUSBLenz.CTSHolding=true then Affiche('CTS=1',Clyellow)
  else Affiche('CTS=0',clyellow);
  
end;

procedure TFormPrinc.ConfigClick(Sender: TObject);
begin
  Tformconfig.create(self);
  formconfig.showmodal;
  formconfig.close;  
end;


end.

