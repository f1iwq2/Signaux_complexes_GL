Unit UnitPrinc;
(********************************************
   programme direct signaux complexes
   delphi 7 + activeX Tmscomm + clientSocket
 ********************************************
 note sur le pilotage des accessoires:
 raquette   octet sortie
    +            2    = aiguillage droit
    -            1    = aiguillage d�vi�
*)


interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, ExtCtrls, jpeg, ComCtrls,
  ImgList, ScktComp, StrUtils, Menus, ActnList, MSCommLib_TLB ;

type
  TFormPrinc = class(TForm)
    BoutVersion: TButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    Label1: TLabel;
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
    GroupBox2: TGroupBox;
    EditDetecteur1: TEdit;
    BoutCalcZone: TButton;
    LabelDetSP: TLabel;
    MainMenu1: TMainMenu;
    Interface1: TMenuItem;
    MenuConnecterUSB: TMenuItem;
    DeconnecterUSB: TMenuItem;
    N2: TMenuItem;
    MenuConnecterEthernet: TMenuItem;
    MenuDeconnecterEthernet: TMenuItem;
    StatusBar1: TStatusBar;
    Label4: TLabel;
    MSComm1: TMSComm;
    LabelEtat: TLabel;
    loco: TButton;
    Afficher1: TMenuItem;
    Etatdesdtecteurs1: TMenuItem;
    Etatdesaiguillages1: TMenuItem;
    N3: TMenuItem;
    Codificationdesaiguillages1: TMenuItem;
    EditDetecteur2: TEdit;
    ClientSocketCDM: TClientSocket;
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
    procedure FormCreate(Sender: TObject);
    procedure MSComm1Comm(Sender: TObject);
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
    procedure BoutCalcZoneClick(Sender: TObject);
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

  private
    { D�clarations priv�es }
    procedure DoHint(Sender : Tobject);
  public
    { D�clarations publiques }
    procedure proc_checkBoxFB(Sender : Tobject);
  end;


// d�finition des adresses normalis�es du d�codeur de leds de digitalBahn
//    l'ordre des adresses est � respecter dans la programation des signaux.
//    L'oeilleton est cabl� sur la sortie 4, il est g�r� directement par le d�codeur. **/
// code des aspects des signaux
const
AF='Client TCP-IP CDM Rail ou USB - syst�me LENZ - Version 1.0';
carre          =0 ; carre_F=1;
semaphore      =1 ; semaphore_F=2;
semaphore_cli  =2 ; semaphore_cli_F=4;
vert           =3 ; vert_F=8;
vert_cli       =4 ; vert_cli_F=16;
violet         =5 ; violet_F=32;
blanc          =6 ; blanc_F=64;
blanc_cli      =7 ; blanc_cli_F=128;
jaune          =8 ; jaune_F=256;
jaune_cli      =9 ; jaune_cli_F=512;
ral_30         =10; ral_30_F=1024;
ral_60         =11; ral_60_F=2048;
rappel_30      =12; rappel_30_F=4096;
rappel_60      =13; rappel_60_F=8192;
Disque_D       =14; // pour d�codeur LDT
ral_60_jaune_cli =15;ral_60_jaune_cli_F=16384; // pour d�codeur LDT
aspect8        =16 ;

tempoFeu = 100;
MaxAcc = 2048;
LargImg=50;HtImg=91;
const_droit=2;const_devieD=2;const_devieG=3;   // aiguillages en position
MaxElParcours=40;

EtatSign : array[0..13] of string[20] =('carr�','s�maphore','s�maphore cli','vert','vert cli','violet',
           'blanc','blanc cli','jaune','jaune cli','ral 30','ral 60','rappel 30','rappel 60');

type TBranche = record
               BType : integer ;   // 1= d�tecteur  2= aiguillage 3=bis 4=Buttoir
               Adresse : integer ; // adresse du d�tecteur ou de l'aiguillage
            end;

     Taiguillage = record
                 modele : integer;   // 0=n'existe pas  1=aiguillage 2=TJD 3=TJS 4=aiguillage triple
                 position,                  // position actuelle : 1=d�vi�  2=droit
                 Adrtriple,
                 temps,                     // temps de pilotage (dur�e de l'impulsion en x 100 ms)
                 inversion : integer;       // pilotage invers� 0=normal 1=invers�
                 vitesse : integer;         // vitesse de franchissement de l"aiguillage en position d�vi�e (60 ou 90)

                 ADroit : integer ; // (identifiant ext�rieur � la TJD) connect� sur la position droite en talon
                 ADroitB : char ; // id de branche pour TJD
                 ADroitBis : integer ;    // 0=pas connect� � aiguillage dont l'adresse est bis  =1 connect� � un aig bis

                 ADevie : integer ; // (identifiant ext�rieur) adresse de l'�l�ment connect� en position d�vi�e
                 ADevieB : char;    // caract�re (D ou S)si aiguillage de l'�l�ment connect� en position d�vi�e
                 AdevieBis : integer ;   // 0=pas connect� � aiguillage dont l'adresse est bis  =1 connect� � un aig bis

                 APointe : integer; // adresse de l'�l�ment connect� en position droite ; pour les TJD : adresse de l'autre tjd
                 APointeB : char;
                 ApointeBis : integer;   // 0=pas connect� � aiguillage dont l'adresse est bis  =1 connect� � un aig bis

                 tjsint   : integer;
                 tjsintb  : char ;

                  // �l�ments connect�s sur la branche d�vi�e 2 (cas d'un aiguillage triple)
                 Adevie2 : integer;
                 Adevie2B : char ;
                 Adevie2Bis : integer;

                end;

Taccessoire     = (aig,feu);
TMA             = (valide,devalide);
//Tparcours = record
//               adresse : integer ;
//               BType   : char;
//            end;   
             
var ancien_tablo_signalCplx,EtatsignalCplx : array[0..MaxAcc] of word;
    AvecInitAiguillages,tempsCli,combine,NbreFeux,pasreponse,AdrDevie,precedent ,
    NombreImages,signalCpx,branche_trouve,Indexbranche_trouve,Actuel,Signal_suivant,
    Nbre_recu_cdm,NivDebug,Tempo_chgt_feux : integer;
    dem_calcul_zone,Hors_tension2,traceSign,TraceZone,Ferme,ParUSB,parSocket,ackCdm,
    NackCDM : boolean;
    clignotant,test_leb,nack,Maj_feux_cours,avecMSCom : boolean;
    N_event_det : integer; // index du dernier �v�nement (de 1 � 20)
    event_det : array[1..20] of integer;
    branche : array [1..100] of string;
    parcours : array[1..MaxElParcours] of TBranche ; // parcours des locos en fonction des d�tecteurs

const
  ClBleuClair=$FF7070 ;
  Cyan=$FFA0A0;
  clviolet=$FF00FF;
  GrisF=$333333;
  clOrange=$0077FF;
  Feu_X=50;Feu_Y=91;
var
  FormPrinc: TFormPrinc;
  ack,portCommOuvert,trace,AffMem,AfficheDet,Bis,CDM_connecte,parSocketCDM,
  DebugOuv : boolean;
  tablo : array of byte;
  Enregistrement,AdresseIP,chaine_Envoi,chaine_recue,AdresseIPCDM,recuCDM,Id_CDM : string;
  maxaiguillage,detecteur_chgt,Temps,TpsRecuCom,NumPort,Tempo_init,Suivant,
  timerSimule,NbreImagePligne,Port,NbreBranches,Index2_det,branche_det,Index_det,portCDM : integer;
  Ancien_detecteur,detecteur : array[0..1024] of boolean;  // anciens �tat des d�tecteurs et adresses des d�tecteurs et leur �tat
  Adresse_detecteur : array[0..60] of integer; // adresses des d�tecteurs par index
  mem : array[0..1024] of boolean ; // m�moire des �tats des d�tecteurs
  MemZone : array[0..1024,0..1024] of boolean ; // m�moires de zones
  detect_Simule : array[0..200] of integer;
  index_simule,NDetecteurs : integer;
  couleur : Tcolor;
  fichier : text;
  recuCDML : array of string;


  // l'indice du tableau aiguillage est son adresse
  aiguillage : array[0..MaxAcc] of Taiguillage;
  aiguillageB : array[0..MaxAcc] of Taiguillage;


  // dessin des feux
  feux : array[1..MaxAcc] of record
                 adresse, aspect : integer; // adresse du feu, aspect cod� en binaire
                 Img : TImage;              // Pointeur sur structure TImage du feu
                 Lbl : TLabel;              // pointeur sur structure Tlabel du feu
                 check : TCheckBox;         // pointeur sur structure Checkbox avec feu blanc
                 FeuBlanc : boolean ;       // avec checkbox ou pas
                 decodeur : integer;        // type du d�codeur
                 Adr_det1 : integer;        // adresse du d�tecteur1 sur lequel il est implant�
                 Adr_det2 : integer;        // adresse du d�tecteur1 sur lequel il est implant� (si un signal est pour plusieurs voies)
                 Adr_det3 : integer;        // adresse du d�tecteur1 sur lequel il est implant� (si un signal est pour plusieurs voies)
                 Adr_det4 : integer;        // adresse du d�tecteur1 sur lequel il est implant� (si un signal est pour plusieurs voies)
                 Adr_el_suiv1 : integer;     // adresse de l'�l�ment suivant
                 Adr_el_suiv2 : integer;     // adresse de l'�l�ment suivant (si un signal est pour plusieurs voies)
                 Adr_el_suiv3 : integer;     // adresse de l'�l�ment suivant (si un signal est pour plusieurs voies)
                 Adr_el_suiv4 : integer;     // adresse de l'�l�ment suivant (si un signal est pour plusieurs voies)
                 Btype_suiv1 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv2 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv3 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 Btype_suiv4 : integer ;     // type de l'�l�ment suivant (1=d�tecteur 2=aig ou TJD ou TJS  4=tri 5=bis
                 VerrouCarre : boolean ;    // si vrai, le feu se verrouille au carr� si pas de train avant le signal
                 EtatSignal  : word  ;      // comme EtatSignalCplx
                end;
  Fimage : Timage;

  BrancheN : array[1..100,1..200] of TBranche;

{$R *.dfm}

implementation

uses UnitDebug;

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

procedure AfficheDebug(s : string;lacouleur : TColor);
begin
  if DebugOuv then
  FormDebug.MemoDebug.Lines.add(s);
end;

// dessine les feux sur une cible � 7 feux
procedure dessine_feu7(Acanvas : Tcanvas;EtatSignal : word);
var code : integer;
begin
  code:=code_to_aspect(Etatsignal); // et combine
  // effacements

  if not((code=blanc_cli) and clignotant) then cercle(ACanvas,13,23,6,violet);
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
  2: dessine_feu2(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  3: dessine_feu3(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  4: dessine_feu4(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  5: dessine_feu5(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  7: dessine_feu7(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  9: dessine_feu9(Feux[i].Img.Canvas,EtatSignalCplx[adresse]);
  end;
end;


// cr��e une image dynamiquement pour un nouveau feu d�clar� dans le fichier de config
procedure cree_image(rang : integer);
var TypeFeu : integer;
    s : string;
const espY = 15; // espacement Y entre deux lignes de feux
begin
  TypeFeu:=feux[rang].aspect;
  Feux[rang].Img:=Timage.create(Formprinc.ScrollBox1);
  with Feux[rang].Img do
  begin
    Parent:=Formprinc.ScrollBox1;   // dire que l'image est dans la scrollBox1
    Top:=(HtImg+espY+20)*((rang-1) div NbreImagePLigne);   // d�termine les dimensions
    Left:=10+ (LargImg+5)*((rang-1) mod (NbreImagePLigne));
    s:='Signal @'+IntToSTR(Feux[rang].adresse)+' Decodeur='+intToSTR(feux[rang].Decodeur)+' Adresse d�tecteur associ�='+intToSTR(feux[rang].Adr_det1)+
       ' Adresse �lement suivant='+intToSTR(feux[rang].Adr_el_suiv1);
       if feux[rang].Btype_suiv1=2 then s:=s+' (aig)';
       if feux[rang].Btype_suiv1=5 then s:=s+' (aig bis)';

    Hint:=s;
    case TypeFeu of   // charger le bit map depuis le fichier
    2 : picture.bitmap:=Formprinc.Image2feux.picture.Bitmap;
    //picture.Bitmap.LoadFromFile('2feux.bmp');
    3 : picture.bitmap:=Formprinc.Image3feux.picture.Bitmap;
    //picture.Bitmap.LoadFromFile('3feux.bmp');
    4 : picture.bitmap:=Formprinc.Image4feux.picture.Bitmap;
    //picture.Bitmap.LoadFromFile('4feux.bmp');
    5 : picture.bitmap:=Formprinc.Image5feux.picture.Bitmap;
    //picture.Bitmap.LoadFromFile('5feux.bmp');
    7 : picture.bitmap:=Formprinc.Image7feux.picture.Bitmap;
    //picture.Bitmap.LoadFromFile('7feux.bmp');
    //9 : picture.Bitmap.LoadFromFile('9feux.bmp');
    9 : picture.bitmap:=Formprinc.Image9feux.picture.Bitmap;


    end;
    // mettre rouge par d�faut
    if feux[rang].aspect=2 then EtatSignalCplx[feux[rang].adresse]:=violet_F;
    if feux[rang].aspect=3 then EtatSignalCplx[feux[rang].adresse]:=semaphore_F;
    if feux[rang].aspect>3 then EtatSignalCplx[feux[rang].adresse]:=carre_F;
    
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
  // on commence � 3 pour ne pas calculer le checksum sur FF FE
  for i:=3 to length(s) do
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

// envoi d'une cha�ne � la centrale par USBLenz ou socket, puis attend l'ack ou le nack
function envoi(s : string) : boolean;
var temps : integer;
begin
  if Hors_tension2=false then
  begin
    if Trace then affiche_chaine_Hex(s,ClGreen);
    if portCommOuvert then FormPrinc.MSComm1.Output:=s;
    if parSocket then Formprinc.ClientSocketLenz.Socket.SendText(s);
    // attend l'ack
    ack:=false;nack:=false;
    if portCommOuvert or ParSocket then
    begin
      temps:=0;
      repeat
        inc(temps);tempo(1);
      until ferme or ack or nack or (temps>5); // l'interface r�pond < 5s en mode normal et 1,5 mn en mode programmation
      if not(ack) or nack then
      begin
        Affiche('Pas de r�ponse de l''interface',clRed);inc(pasreponse);
        if pasreponse>3 then hors_tension2:=true;
      end;
      if ack then begin pasreponse:=0;hors_tension2:=false;end;
    end;
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

// pr�pare la cha�ne de commande pour un accessoire via CDM
Function chaine_CDM_Acc(adresse,etat1 : integer) : string;
var so,sx,s : string;
    i : integer;
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
  //s:='NAME='+format('%.*d',[2,24])+';';
  //s:=s+'OBJ='+format('%.*d',[2,24])+';';
  s:=s+'AD='+format('%.*d',[1,adresse])+';';
  s:=s+'STATE='+format('%.*d',[1,etat1])+';';

  sx:=format('%.*d',[2,2])+'|';  // 2 param�tres
  so:=so+ '|'+format('%.*d',[3,length(s)+length(sx)])+'|'+sx;

  chaine_CDM_Acc:=so+s;
end;

// envoi d'une cha�ne � CDM par socket, puis attend l'ack ou le nack
function envoi_CDM(s : string) : boolean;
var temps : integer;
begin
    //if Trace then
    //if NivDebug=3 then begin AfficheDebug('Envoi � CDM rail',clRed);afficheDebug(s,ClGreen);end;
    if parSocketCDM then Formprinc.ClientSocketCDM.Socket.SendText(s);
    // attend l'ack
    ackCDM:=false;nackCDM:=false;
    if ParSocketCDM then
    begin
      temps:=0;
      repeat
        inc(temps);tempo(1);
      until ferme or ackCDM or nackCDM or (temps>2); // CDM r�pond < 1s
      if not(ackCDM) or nack then
      begin
        Affiche('Pas de r�ponse de CDM Rail',clRed);
      end;
    end;
  envoi_CDM:=ackCDM;
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
  s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $80)
  else
  s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $88);

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
  s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $80)
  else
  s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $88);

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
  if CDM_connecte then
  begin
    //AfficheDebug(intToSTR(adresse),clred);
    s:=chaine_CDM_Acc(adresse,octet);
    envoi_CDM(s);
    if acc=feu then exit;
    s:=chaine_CDM_Acc(adresse,0);
    envoi_CDM(s);
    exit;
  end;
  // test si pilotage invers�
  //Affiche('Accessoire '+intToSTR(adresse),clLime);
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
    s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
    // si l'accessoire est un feu, sortir
    if acc=feu then exit;

    // si aiguillage, faire une temporisation
    if index_feu(adresse)=0 then
    begin
      temps:=aiguillage[adresse].temps;if temps=0 then temps:=4;
      if portCommOuvert or ParSocket then tempo(temps);
    end;
    // pilotage � 0 pour �teindre le pilotage de la bobine du relais
    s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
    s:=checksum(s);
    envoi(s);     // envoi de la trame et attente Ack
  end;
end;

// pilote accessoire en entr�e 0->2  1->1
procedure pilote_acc01(adresse : integer;octet : byte);
var  groupe,temps : integer ;
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
  s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $88);   // activer la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
  sleep(10);    // temps minimal pour ne pas avoir le d�faut station occup�e qd on pilote un signal leb
  temps:=aiguillage[adresse].temps;if temps=0 then temps:=4;
  // si l'accessoire est un feu, fixer l tempo � 1
  //if index_feu(adresse)<>0 then temps:=1;

  //if portCommOuvert or ParSocket then tempo(temps);
  // pilotage � 0 pour �teindre le pilotage de la bobine du relais
  s:=#$ff+#$fe+#$52+Char(groupe)+char(fonction or $80);  // d�sactiver la sortie
  s:=checksum(s);
  envoi(s);     // envoi de la trame et attente Ack
end;

procedure vitesse_loco(loco : integer;vitesse : integer;sens : boolean);
var s : string;
begin
  if sens then vitesse:=vitesse or 128;
  s:=#$ff+#$fe+#$e4+#$13+#$0+char(loco)+char(vitesse);
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
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and $FF00;   // et effacer les bits 0 � 7
    end;
    if (aspect=jaune_cli) then // jaune clignotant
    begin
      EtatSignalCplx[adresse]:=RazBit(EtatSignalCplx[adresse],jaune);   // cas du jaunecli: efface le bit du jaune  (bit 8)
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and $FF00;   // et effacer les bits 0 � 7
    end;
    if (aspect=ral_30) then // ralentissement 30
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($38FF);   // cas du ral30: efface les bits 0 1 2 3 4 5 6 7 11 12 et 13 :  11 1000 1111 1111
    end;
    if (aspect=ral_60) then // ralentissement 60
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($34FF);   // cas du ral60: efface les bits 10 12 et 13 et de 0 � 7  : 11 0100 1111 1111
    end;
    if (aspect=rappel_30) then // rappel 30
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($2c00);   // cas du rappel30: efface les bits 10 11 et 13 : 10 1100 0000 0000
    end;
    if (aspect=rappel_60) then // rappel 60
    begin
      EtatSignalCplx[adresse]:=EtatSignalCplx[adresse] and not($1C00);   // cas du rappel60: efface les bits 10 11 et 12  1 1100 0000 0000
    end;
    if (aspect=aspect8) then // ral_60_jaune_cli d�codeur LDT
    begin
      EtatSignalCplx[adresse]:=jaune_cli_F or ral_60_F;   // cas du ralentissement 60 + avertissement clignotant : efface les bits 10 11 et 12
    end;
    if (aspect<>aspect8) then EtatSignalCplx[adresse]:=SetBit(EtatSignalCplx[adresse],aspect);   // allume le num�ro du bit de la fonction du signal
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
    if (traceSign) then Affiche('Signal directionnel '+IntToSTR(adr)+' '+intToSTR(code),clOrange);
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
    dessine_feu(adr);
    if traceSign then Affiche('signal directionnel CDF: '+IntToSTR(adr)+' '+intToSTR(code),ClOrange);

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
    dessine_feu(adresse);
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    aspect:=code_to_aspect(code);
    if traceSign then affiche('Signal CDF: '+intToSTR(adresse)+' '+intToSTR(code),clOrange);
  
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
      //Sleep(50);
    end;
    //Affiche(inttoStr(selection),clOrange);
    //Affiche(s,clOrange);
  end;
begin

if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //; && (stop_cmd==FALSE))
begin
  dessine_feu(adr);
  ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr];
  codebin:=EtatSignalCplx[adr];
  aspect:=code_to_aspect(codebin);
  if traceSign then
  begin
    s:='Signal LEB:  ad'+IntToSTR(adr)+'='+etatSign[aspect];
    //s:='Signal LEB:  ad'+IntToSTR(adr)+' aspect='+intToSTR(aspect)+' combine='+intToSTR(combine);
    if Combine<>0 then s:=s+' + '+etatSign[combine];
    Affiche(s,clYellow);
  end;
  Sleep(40);  // si le feu se positionne � la suite d'un positionnement d'aiguillage, on peut avoir le message station occup�e

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
procedure envoi_NMRA(adresse,code : integer);
var valeur : integer ;
begin
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then
  begin
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    case (code) of
      carre_F                     : valeur:=0;
      semaphore_F                 : valeur:=1;
      semaphore_cli_F             : valeur:=2;
      vert_F                      : valeur:=3;
      vert_cli_F                  : valeur:=4;
      violet_F                    : valeur:=5;
      blanc_F                     : valeur:=6;
      blanc_cli_F                 : valeur:=7;
      jaune_F                     : valeur:=8;
      jaune_cli_F                 : valeur:=9;
      ral_30_F                    : valeur:=10;
      ral_60_F                    : valeur:=11;
      (ral_60_F + jaune_cli_F)   : valeur:=12;
      (rappel_30_F)               : valeur:=13;
      (rappel_60_F)               : valeur:=14;
      (rappel_30_F + jaune_F)     : valeur:=15;
      (rappel_30_F + jaune_cli_F) : valeur:=16;
      (rappel_60_F + jaune_F)     : valeur:=17;
      (rappel_60_F + jaune_cli_F) : valeur:=18;
      else valeur:=code;
    end;
    pilote_acc(adresse,valeur,feu);
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
var index,codebin,aspect,mode : integer;
begin
  codebin:=EtatSignalCplx[adr];
  aspect:=code_to_aspect(codebin);
  if (ancien_tablo_signalCplx[adr]<>EtatSignalCplx[adr]) then //; && (stop_cmd==FALSE))
  begin
    ancien_tablo_signalCplx[adr]:=EtatSignalCplx[adr];
    dessine_feu(adr);
    //if (tempo_ACC>0) then sleep(100);  // les commandes entre 2 feux successives doivent �tre s�par�es au minimum de 100 ms
    if traceSign then affiche('Signal LDT: '+IntToSTR(adr)+' '+intToSTR(mode)+' '+intTOSTR(codebin),clOrange);
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
  end;
end;


procedure envoi_virtuel(adresse : integer);
var
  aspect,code : integer;
begin
  code:=etatsignalcplx[adresse];
  if (ancien_tablo_signalCplx[adresse]<>EtatSignalCplx[adresse]) then  //; && (stop_cmd==FALSE))
  begin
    dessine_feu(adresse);
    ancien_tablo_signalCplx[adresse]:=EtatSignalCplx[adresse];
    aspect:=code_to_aspect(code); // transforme le motif de bits en num�ro  "code des aspects des signaux"
    if (tracesign) then Affiche('Signal virtuel: '+intToSTR(adresse)+' Etat '+etatSign[aspect],clyellow);
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
    dessine_feu(adresse);
    codebin:=EtatSignalCplx[adresse];
    aspect:=code_to_aspect(codebin); // transforme le motifs de bits en num�ro  "code des aspects des signaux"
    combineLoc:=combine;  // copier dans variable locale
    if traceSign then
    begin
      s:='Signal bahn: ad'+IntToSTR(adresse)+'='+etatSign[aspect];
      if CombineLoc<>0 then s:=s+' + '+etatSign[combineLoc];
      Affiche(s,clOrange);
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
PresTrain:=((num_voie=3) and (MemZone[513,537] or (MemZone[526,513] and (aiguillage[10].position=2) and (aiguillage[19].position=2) and

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
    if testBit(EtatSignalCplx[406],semaphore) or testBit(EtatSignalCplx[406],carre) then     // si signal cplx suivant est rouge
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
        if testBit(EtatSignalCplx[406],jaune_F) or testBit(EtatSignalCplx[406],ral_60_F) then //si signal cplx suivant est jaune ou ralentissement-----------
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
          ((aiguillage[30].position<>2) or (aiguillage[11].position=2) or (aiguillage[23].position=2)) ) or (PresTrain=FALSE)) then
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
          if testbit(EtatSignalCplx[218],jaune) or testBit(EtatSignalCplx[218],ral_30) then // si signal suivant est jaune ou ral30
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
        //  if testbit(EtatSignalCplx[218],jaune) or testBit(EtatSignalCplx[218],ral_30) then // si signal suivant est jaune ou ral30
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


// pilotage des signaux
procedure envoi_signauxCplx;
var i,signalCplx : integer;
begin
  //Affiche('Envoi des signaux (envoi_signaixCplx)',ClGreen);
  //chaque signal doit �tre appell� en fonction de sa proc�dure suivant le d�codeur
  for i:=1 to NbreFeux do
  begin
   signalCplx:=feux[i].adresse;
   if not(ferme) and (signalCplx<>0) then
   begin
     case feux[i].decodeur of
     0 : envoi_virtuel(signalCplx);
     1 : envoi_signalBahn(signalCplx);
     2 : envoi_CDF(signalCplx);
     3 : envoi_LDT(signalCplx);
     4 : envoi_LEB(signalCplx);
     //5 : envoi_NMRA(SignalCplx);
     end;
   end;
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
    ComptEl,Compt_IT,Num_Element,k,modele,aig2,adr,erreur2,l : integer;
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
  // AfficheDet:=true;
  s:=lit_ligne;
  i:=pos(':',s);
  if i<>0 then begin adresseIPCDM:=copy(s,1,i-1);Delete(s,1,i);portCDM:=StrToINT(s);end;


  // adresse ip et port de la centrale
  // AfficheDet:=true;
  s:=lit_ligne;
  i:=pos(':',s);
  if i<>0 then begin adresseIP:=copy(s,1,i-1);Delete(s,1,i);port:=StrToINT(s);parSocket:=True;end
  else begin adresseIP:='0';parSocket:=false;end;

  // num�ro de port
  s:=lit_ligne;
  NumPort:=StrToINT(s);

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
      bis:=pos('B',enregistrement)<>0;
      tjd:=pos('TJD',enregistrement)<>0;
      tjs:=pos('TJS',enregistrement)<>0;
      // adresse de l'aiguillage
      Val(enregistrement,aig,erreur); // aig = adresse de l'aiguillage
      if aig>maxaiguillage then maxaiguillage:=aig;
      if debugConfig then Affiche('Adresse='+IntToSTR(aig)+' enregistrement='+Enregistrement,clyellow);

      if not(bis) then begin aiguillage[aig].AdroitB:='Z'; aiguillage[aig].AdevieB:='Z'; aiguillage[aig].ApointeB:='Z'; aiguillage[aig].Adevie2B:='Z';end
                   else begin aiguillageB[aig].AdroitB:='Z';aiguillageB[aig].AdevieB:='Z';aiguillageB[aig].ApointeB:='Z';aiguillageB[aig].Adevie2B:='Z';end ;

      if (triple) then aiguillage[aig].modele:=4;
      if (tjs) then
      begin
      if not(bis) then aiguillage[aig].modele:=3
          else aiguillageB[aig].modele:=3;
      end;
      if (tjd) then
      begin
      if not(bis) then aiguillage[aig].modele:=2
              else aiguillageB[aig].modele:=2;
      end;
      if not(tjs) and not(tjd) and not(triple) then
      begin
        if not(bis) then aiguillage[aig].modele:=1
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
          if not(bis) then aiguillage[aig].Apointe:=detect else aiguillageB[aig].Apointe:=detect;
          if (erreur<>0) then // si erreur<>0 peut �tre un B ou un S ou un ,
          begin
            if (enregistrement[1]='B') then
            begin
              if not(bis) then aiguillage[aig].ApointeBis:=1 else aiguillageB[aig].ApointeBis:=1;
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connect� a aiguillage BIS'+s,clYellow);
            end;
            if not(bis) then aiguillage[aig].ApointeB:=enregistrement[1] else aiguillageB[aig].ApointeB:=enregistrement[1];
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
          detect:=0;
          Val(enregistrement,detect,erreur);
          if erreur<>0 then delete(enregistrement,1,erreur-1);
          if debugconfig then Affiche(enregistrement,clyellow);
          //if ((aig=0) and (erreur=0)) then Affiche('Erreur pas d''adresse dans section D: '+chaine,clRed);
          if (erreur=0) then enregistrement:='';
          if not(bis) then aiguillage[aig].Adroit:=detect else aiguillageB[aig].Adroit:=detect;
          if (erreur<>0) then // si erreur<>0 peut �tre un B ou un S ou un ,
          begin
            if (enregistrement[1]='B') then
            begin
              if not(bis) then aiguillage[aig].AdroitBis:=1 else aiguillageB[aig].AdroitBis:=1;
              delete(enregistrement,1,1);
              if (debugConfig) then affiche('connect� a aiguillage BIS'+s,clYellow);
            end;
            if (enregistrement[1]<>',') then  // copier si c'est S P D
            begin
              if not(bis) then aiguillage[aig].AdroitB:=enregistrement[1] else aiguillageB[aig].AdroitB:=enregistrement[1];
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

          erreur:=pos('S2',enregistrement); // description d'un rattachement � mla branche S2 d'un aiguillage triple
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

          if not(bis) and not(bistec) and not(S2) and not(tec) then begin aiguillage[aig].Adevie:=detect;aiguillage[aig].AdevieB:=c;end;
          if not(bis) and not(bistec) and     S2  and not(tec) then begin aiguillage[aig].Adevie2:=detect;aiguillage[aig].Adevie2B:=c;end;
          if not(bis) and not(bistec) and     S2  and     tec  then begin aiguillage[aig].Adevie2:=detect;aiguillage[aig].Adevie2B:='T';end;
          if not(bis) and    (bistec) and not(S2) and not(tec) then begin aiguillage[aig].Adevie:=detect;aiguillage[aig].AdevieBis:=1;aiguillage[aig].AdevieB:=c;end;
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
    //Affiche(s,clYellow);
    finifeux:=s[1]='0';
    if not(finifeux) then
    begin
    chaine:=s;
    j:=pos(',',s);
    if j>1 then
    begin
      
      adresse:=StrToINT(copy(s,1,j-1));Delete(s,1,j); // adresse de feu
      //if (adresse<maxAiguillage) and (adresse>0) then adresse:=1000;
      feux[i].adresse:=adresse;
      j:=pos(',',s);
      if j>1 then begin feux[i].aspect:=StrToInt(copy(s,1,j-1));Delete(s,1,j);end;
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
            if s[1]='A' then
            begin
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
              delete(s,l,1);
              //Affiche('d�tect� aiguillage bis',clyellow);
              if (j=1) then feux[i].Btype_Suiv1:=5;
              if (j=2) then feux[i].Btype_Suiv2:=5;
              if (j=3) then feux[i].Btype_Suiv3:=5;
              if (j=4) then feux[i].Btype_Suiv4:=5;
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
        if (j>4) or (not(multiple)) then begin Affiche('Erreur: fichier de configuration ligne erronn�e : '+chaine,clred); closefile(fichier);exit;end;

        k:=pos(',',s);
        delete(s,1,k);
        //Affiche('s='+s,clyellow);
        feux[i].VerrouCarre:=s[1]='1';
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
      modele:=BrancheN[i][j].BType;  //1= d�tecteur 2 ou 3 aiguillage
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
var res : boolean;
begin
  detecteur_0:=(Ancien_detecteur[adresse]=true) and ((detecteur[adresse])=false);
  Ancien_detecteur[adresse]:=detecteur[adresse];
end;

function detecteur_1(adresse : integer) : boolean;
var fd : boolean;
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
procedure trouve_element(el : integer;sibis : boolean);
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
     ((adr=el) and sibis and (Btype=3)) or
     ((adr=el) and not(sibis) and (Btype=2)) or
     ((adr=el) and not(sibis) and (Btype=1)) ;
  until (sort);
  if (adr=el) then
  begin
    branche_trouve:=Branche;
    IndexBranche_trouve:=i-1;
  end
  else begin s:='Erreur 175 - �l�ment '+intToSTR(el);
         if (sibis) then s:=s+'bis';
         s:=s+' non trouv�';Affiche(s,clred);
         branche_trouve:=0; IndexBranche_trouve:=0;
         if NivDebug>=1 then AfficheDebug(s,clred);
       end;
end;



// renvoie �l�ment suivant entre deux �l�ments quels qu'ils soient mais contigus
// et en variables globales: bis si c'est un aiguillage bis
// s'ils ne sont pas contigus, on aura une erreur
// alg= algorithme : 
// 1=arret sur suivant qu'il soit un d�tecteur ou un aiguillage  
// 2=arret sur aiguillage en talon mal positionn�   
// 3=arret sur un aiguillage pris en pointe d�vi� et AdrDevie contient l'adresse de l'aiguillage d�vi� ainsi que Bis
// code de sortie : �l�ment suivant ou: 
// 9999=erreur fatale 
// 9998= arret sur aiguillage en talon mal positionn�e
// 9997: arr�t sur aiguillage d�vi�
function suivant_alg3(prec : integer;BisPrec : boolean;actuel : integer;BisActuel : boolean;alg : integer) : integer;
var  Btype,Adr,AdrPrec,BtypePrec,indexBranche_prec,branche_trouve_prec,indexBranche_actuel,branche_trouve_actuel,
     tjsc1,tjsc2,AdrTjdP,Adr2 : integer;
     Abis,tjscourbe1,tjscourbe2,tjd,tjs : boolean;
     A,Aprec,tjsc1B,tjsc2B: char;
label recommence;
begin
  recommence:
  if NivDebug=3 then AfficheDebug('Alg3 pr�cedent='+intToSTR(prec)+' actuel='+intToSTR(actuel),clyellow);
  // trouver les �l�ments du pr�c�dent
  trouve_element(prec,BisPrec); // branche_trouve  IndexBranche_trouve
  if IndexBranche_trouve=0 then
  begin
    if NivDebug=3 then AfficheDebug('Element '+intToSTR(prec)+' non trouv�',clred);
    suivant_alg3:=9999;exit;
  end;

  indexBranche_prec:=IndexBranche_trouve;
  branche_trouve_prec:=branche_trouve;
  BtypePrec:=BrancheN[branche_trouve_prec,indexBranche_prec].Btype;
  //  if BTypePrec=2 then aiguillage[prec].A

  trouve_element(actuel,BisActuel); // branche_trouve  IndexBranche_trouve
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
      Btype:=BrancheN[branche_trouve_actuel,indexBranche_actuel+1].Btype;
      Bis:=Btype=3;
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
      Btype:=BrancheN[branche_trouve_actuel,indexBranche_actuel-1].Btype;
      Bis:=Btype=3;
      if NivDebug=3 then AfficheDebug('43 - Le suivant est :'+intToSTR(adr)+'('+intToSTR(Btype)+')',clwhite);
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
    if ((aiguillage[Adr].modele=1) and (Btype=2) and not(BisActuel)) then // aiguillage normal non bis
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
          ABis:=aiguillage[Adr].AdroitBis=1;
          A:=aiguillage[Adr].AdroitB;
          Adr:=aiguillage[Adr].Adroit;
          trouve_element(adr,Abis); // branche_trouve  IndexBranche_trouve
          Btype:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          Bis:=Abis;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].position<>const_droit then
        begin
          if NivDebug=3 then AfficheDebug('133 - aiguillage '+intToSTR(Adr)+' Pris en pointe d�vi�',clyellow);
          AdrPrec:=Adr;
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
          begin
            bis:=false;
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
          ABis:=aiguillage[Adr].AdevieBis=1;
          Adr:=aiguillage[Adr].Adevie;
          trouve_element(adr,Abis); // branche_trouve  IndexBranche_trouve
          Btype:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
          Bis:=Abis;
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
        ABis:=aiguillage[Adr].ApointeBis=1;
        Adr:=aiguillage[Adr].Apointe;
        trouve_element(adr,Abis); // branche_trouve  IndexBranche_trouve
        Btype:=BrancheN[branche_trouve,IndexBranche_trouve].Btype;
        Bis:=Abis;
        suivant_alg3:=adr;exit;
      end;
      Affiche('138 - Erreur fatale - Aucun cas Aiguillage',clred);
      if NivDebug=3 then AfficheDebug('138 - Erreur fatale - Aucun cas Aiguillage',clred);
      suivant_alg3:=9999;exit;
    end;

    if ((aiguillage[Adr].modele=1) and (Btype=3) and (BisActuel)) then // aiguillage normal bis
    begin
      // aiguillage pris en pointe
      if (aiguillageB[Adr].Apointe=Prec) then
      begin
        if (aiguillageB[Adr].position=const_droit) then
        begin
          if NivDebug=3 then AfficheDebug('140 - Aiguillage '+intToSTR(adr)+' bis pris en pointe droit',clyellow);
          AdrPrec:=Adr;
          if alg=3 then // on demande d'arreter si l'aiguillage pris en pointe est d�vi�
          begin
            bis:=true;
            AdrDevie:=Adr;
            suivant_alg3:=9997;exit;
          end;
          if (Adr=0) then begin Affiche('141 - Erreur fatale',clred);suivant_alg3:=9999;exit;end;
          BtypePrec:=Btype;
          APrec:=A;
          A:=aiguillageB[Adr].AdroitB;
          ABis:=aiguillageB[Adr].AdroitBis=1;
          Adr:=aiguillageB[Adr].Adroit;
          trouve_element(Adr,ABis); // branche_trouve  IndexBranche_trouve
          Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          Bis:=ABis;
          suivant_alg3:=Adr; exit;
        end;
        if (aiguillage[Adr].position<>const_droit) then
        begin
          AdrPrec:=Adr;
          if (Adr=0) then begin Affiche('144 - Erreur fatale',clred);suivant_alg3:=9999;exit;end;
          BtypePrec:=Btype;
          APrec:=A;
          A:=aiguillageB[Adr].AdevieB;
          ABis:=aiguillageB[Adr].AdevieBis=1;
          Adr:=aiguillageB[Adr].Adevie;  
          trouve_element(Adr,ABis); // branche_trouve  IndexBranche_trouve
          Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
          Bis:=ABis;
          suivant_alg3:=Adr;exit;
        end;
      end
      else
      begin
        if (NivDebug=3) then AfficheDebug('145 - Aiguillage '+IntToSTR(adr)+' bis pris en talon',clyellow);
        AdrPrec:=Adr;
        if (Adr=0) then begin AfficheDebug('146 - Erreur fatale',clred);suivant_alg3:=9999;exit;end;
        BtypePrec:=Btype;
        APrec:=A;
        ABis:=aiguillageB[Adr].ApointeBis=1;
        // Affiche('trouv�'+intToSTR(adr),clyellow);
        A:=aiguillage[Adr].ApointeB;
        Adr:=aiguillageB[Adr].Apointe; // bug
        trouve_element(Adr,ABis); // branche_trouve  IndexBranche_trouve
        Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
        Bis:=ABis;
        suivant_alg3:=Adr;exit;
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
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[Adr].Adroit;
          BisPrec:=aiguillage[Adr].AdroitBis=1;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adroit=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[AdrTjdP].Adroit;
          BisPrec:=aiguillage[AdrTjdP].AdroitBis=1;
          suivant_alg3:=adr;exit;
        end;
        //Affiche('Erreur 1021  adrTJD='+IntToSTR(Adr)+' adrTJDPointe='+intToSTR(AdrTJDP)+' prec='+IntTOSTR(prec),clred);
        Suivant_alg3:=9999;exit;
      end;
      // cas 2 TJD
      if (aiguillage[Adr].position<>const_droit)
         and (aiguillage[AdrTjdP].position=const_droit) and tjd then
      begin
        if NivDebug=3 then AfficheDebug('cas2 tjd',clYellow);
        if aiguillage[AdrTjdP].Adroit=prec then
        begin
          A:=aiguillage[Adr].AdevieB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[Adr].Adevie;
          BisPrec:=aiguillage[Adr].AdevieBis=1;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[AdrTjdP].Adroit;
          BisPrec:=aiguillage[AdrTjdP].AdroitBis=1;
          suivant_alg3:=adr;exit;
        end;
        //Affiche('Erreur 1022',clred);
        Suivant_alg3:=9999;exit;
      end;
      // cas 3 TJD
      if  (aiguillage[Adr].position=const_droit)
          and (aiguillage[AdrTjdP].position<>const_droit) and tjd then
      begin
        if NivDebug=3 then AfficheDebug('cas3 tjd',clYellow);
        if (aiguillage[AdrtjdP].Adevie=prec) then
        begin
          A:=aiguillage[AdrTjdP].AdroitB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[Adr].Adroit;
          BisPrec:=aiguillage[Adr].AdroitBis=1;
          suivant_alg3:=adr;exit;
        end;
        if (aiguillage[Adr].Adroit=prec) then
        begin
          A:=aiguillage[Adr].AdevieB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[Adr].Adevie;
          BisPrec:=aiguillage[Adr].AdevieBis=1;
          suivant_alg3:=adr;exit;
        end;
        //Affiche('Erreur 1023',clred);
        Suivant_alg3:=9999;exit;
      end;
      // cas 4 tjd
      if (aiguillage[Adr].position<>const_droit)
         and (aiguillage[AdrTjdP].position<>const_droit)  then
      begin
        if NivDebug=3 then AfficheDebug('cas4 tjd',clYellow);
        if aiguillage[AdrTjdP].Adevie=prec then
        begin
          A:=aiguillage[Adr].AdevieB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[Adr].Adevie;
          BisPrec:=aiguillage[Adr].AdevieBis=1;
          suivant_alg3:=adr;exit;
        end;
        if aiguillage[Adr].Adevie=prec then
        begin
          A:=aiguillage[AdrtjdP].AdevieB;
          if A='Z' then Btype:=1 else Btype:=2;
          Adr:=aiguillage[AdrtjdP].Adevie;
          BisPrec:=aiguillage[AdrtjdP].AdevieBis=1;
          suivant_alg3:=adr;exit;
        end;
        //Affiche('Erreur 1024',clred);
        Suivant_alg3:=9999;exit;
      end;
      // cas TJS prise dans sa position courbe
      if ((aiguillage[Adr].Adevie=Prec) and (aiguillage[Adr].AdevieB=Aprec) and (aiguillage[Adr].position<>const_droit)
        and (aiguillage[AdrTjdP].position=const_droit) and (tjs) and tjscourbe1 and tjscourbe2) then
      begin
        if NivDebug=3 then AfficheDebug('cas tjs en courbe1',clYellow);
        A:=aiguillage[AdrTjdP].AdevieB;
        if A='Z' then Btype:=1 else Btype:=2;
        Adr:=aiguillage[AdrTjdP].Adevie;
        BisPrec:=aiguillage[AdrTjdP].AdroitBis=1;
        suivant_alg3:=adr;exit;
      end;
      // cas 3 TJS prise dans sa 2eme position courbe
      if ((aiguillage[Adr].Adroit=Prec) and (aiguillage[Adr].AdroitB=Aprec) and (aiguillage[Adr].position=const_droit)
           and (aiguillage[AdrTjdP].position<>const_droit) and (tjs) and tjscourbe1 and tjscourbe2 ) then
      begin
         if NivDebug=3 then AfficheDebug('cas1 tjs en courbe 2',clYellow);
        A:=aiguillage[AdrTjdP].AdevieB;
        if A='Z' then Btype:=1 else Btype:=2;
        Adr:=aiguillage[AdrTjdP].Adevie;
        BisPrec:=aiguillage[AdrTjdP].AdroitBis=1;
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
               BisPrec:=aiguillage[Adr].AdroitBis=1;
               //TSuiv=aiguillage[Adr].AdroitB;
               Adr:=aiguillage[Adr].Adroit;
             end;
               if ( CDM_connecte and (aiguillage[Adr].position=const_devieG) ) or
                ( not(CDM_connecte) and  (aiguillage[Adr].position<>const_droit) and (aiguillage[Adr2].position=const_droit) )  then
             begin
                if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�1 (gauche)',clYellow);
                BisPrec:=aiguillage[Adr].AdevieBis=1;
                //TSuiv=aiguillage[Adr].AdevieB;
                Adr:=aiguillage[Adr].Adevie;
             end;
               if ( CDM_connecte and (aiguillage[Adr].position=const_devieG) ) or
                ( not(CDM_connecte) and (aiguillage[Adr].position=const_droit) and (aiguillage[Adr2].position<>const_droit) ) then
             begin
                if NivDebug=3 then AfficheDebug('Aiguillage triple d�vi�2 (droit)',clYellow);
                BisPrec:=aiguillage[Adr].Adevie2Bis=1;
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
function detecteur_suivant(prec : integer;BisPrec : boolean;actuel : integer;BisActuel : boolean) : integer ;
var AdrDet,actuelCalc,PrecCalc,etat,i,j,AdrSuiv : integer;
    BisprecCalc,BisActuelCalc : boolean;
begin
  if NivDebug>=2 then AfficheDebug('cherche d�tecteur suivant aux '+IntToSTR(prec)+'-'+intToSTR(actuel),clyellow);
  j:=0;

  PrecCalc:=prec;
  bisprecCalc:=bisprec;
  ActuelCalc:=actuel;
  BisActuelCalc:=BisActuel;
  // �tape 1 trouver le sens
  repeat
    inc(j);
    AdrSuiv:=suivant_alg3(precCalc,BisPrecCalc,actuelCalc,BisActuelCalc,1);
    precCalc:=actuelCalc;
    BisPrecCalc:=BisActuelCalc;
    actuelCalc:=AdrSuiv;
    BisActuelCalc:=Bis;
    //Affiche('Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
  until (j=10) or (AdrSuiv>512) or (AdrSuiv=0); // 
  // si trouv� le sens, trouver le suivant
  if AdrSuiv=actuel then
  begin
     AdrSuiv:=suivant_alg3(prec,BisPrec,actuel,BisActuel,1);
  end;
  if NivDebug=3 then AfficheDebug('Le suivant est le '+intToSTR(AdrSuiv),clYellow);
  detecteur_suivant:=AdrSuiv;
end;

// renvoie l'adresse du d�tecteur suivant des deux �l�ments
// Det1 et Det2 peuvent �tre s�par�s par des aiguillages
function detecteur_suivant_El(el1: integer;BisDet1 : boolean;el2 : integer;BisDet2 : boolean) : integer ;
var IndexBranche_det1,IndexBranche_det2,branche_trouve_det1,branche_trouve_det2,i,
    j,AdrPrec,Adr,AdrFonc,Btype : integer;
    BisPrec,BisFonc,BisSuiv,Sortie : boolean;
    s : string;

begin
  if NivDebug>=2 then AfficheDebug('cherche d�tecteur_suivant_El aux '+IntToSTR(el1)+'-'+intToSTR(el2),clyellow);
  // traceDet=TRUE;
  // trouver d�tecteur 1
  trouve_detecteur(el1); // branche_trouve  IndexBranche_trouve
  if (IndexBranche_trouve=0) then
  begin
    Affiche('�l�ment '+IntToSTR(el1)+' non trouv�',clred);
    detecteur_suivant_El:=1;exit;
  end;
  IndexBranche_det1:=IndexBranche_trouve;
  branche_trouve_det1:=branche_trouve;
 
  // trouver d�tecteur 2
  trouve_detecteur(el2); // branche_trouve  IndexBranche_trouve
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
    if (NivDebug=4) then
    begin
      s:='Test route en ';
      if (j=1) then s:=s+'d�cr�ment ' else s:=s+'incr�ment ';
      s:=s+'- d�part depuis d�tecteur '+IntToSTR(el1);Affiche(s,clyellow);
    end;
    AdrPrec:=el1;
    BisPrec:=FALSE;
    Bis:=FALSE;
    if (j=1) then i:=IndexBranche_det1-1 else i:=IndexBranche_det1+1;
    //trouve_element(det1,FALSE);
    Adr:=BrancheN[branche_trouve_det1,i].Adresse;
    AdrFonc:=Adr;
    Btype:=BrancheN[branche_trouve,i].BType;  // �l�ment suivant/pr�c�dent
    BisFonc:=Btype=3; // bug si aiguillage bis
    i:=0;
    if (el2<>Adr) then
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);  // donne l'�l�ment suivant de AdrPrec � AdrFonc et dans Bis si c'est un aig bis
      trouve_element(Adr,Bis);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype=3; // si aiguillage bis
      //Affiche(intToSTR(adr)+'/'+intToStr(Btype),clorange);
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=Bis; 
      i:=i+1;                           
      sortie:=(Adr=El2) or (i=20) or (Adr=0) or ((Adr<>el2) and (btype=1)); 
    until (sortie) ;   // boucle de parcours
    if (i=20) then
      begin Affiche('Erreur fatale 300 : It�ration trop longue',clred);
      AfficheDebug('Erreur fatale 300 : It�ration trop longue',clred);
      detecteur_suivant_el:=3;end;
    if ((Btype=1) and (Adr<>el2) and (NivDebug=3)) then AfficheDebug('N''est pas le d�tecteur attendu '+intToSTR(Adr)+' pour '+intToSTR(el2),clyellow);
    inc(j);   // changement de sens 
    sortie:=(Adr=el2) or (j=3) or (Adr=0);
  until sortie;

  // si arret sur buttoir
  if Adr=0 then begin detecteur_suivant_el:=0;exit;end;
  
  if ((j=3) and (Adr<>el2)) then
  begin
    if NivDebug=3 then AfficheDebug('Pas de suivant sur s�quence '+IntToSTR(el1)+' � '+intToStr(el2),clyellow);
    detecteur_suivant_el:=0;exit;
  end;

  // �tape 2 : on a trouv� le sens de progression, trouver le d�tecteur suivant
  if (Adr=el2) then
  begin
    // trouv� la route si j=2 : -  si j=3 : +
    if (NivDebug=3) then AfficheDebug('Route trouv�e',clyellow);
    i:=0;
    AdrFonc:=Adr;
    BisFonc:=FALSE;
    BisSuiv:=FALSE;
    Bis:=FALSE;
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);
   //   if i=0 then El_suivant:=Adr; //???????
      trouve_element(Adr,Bis);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype=3; // si aiguillage bis
      if (NivDebug=3) then AfficheDebug('Suivant='+IntToSTR(Adr)+ '('+intToSTR(Btype)+')',clyellow);
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=Bis;
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
   i,j,prec,AdrFeu,AdrSuiv,actuel : integer;
   multi, sort, BisPrec,BisActuel : boolean;
   s : string;
begin
  if (NivDebug>=1) then AfficheDebug('Test si signal '+IntToSTR(adresse)+' doit afficher un carr� si aiguillage avals mal positionn�s',clyellow);

  i:=Index_feu(adresse);
//  if (feux[i].VerrouCarre=FALSE)    // si le feu n'est pas verrouillable au carr�
//  {
//    if (traceDet) {sprintf(s,"Ce signal %d n'est pas verrouillable au carr�\r\n",adresse);
//               Display(s);
//               if (echoLog) fputs(s,fichier);}
//    return FALSE;
//  }
  j:=0;
  prec:=feux[i].Adr_det1;
  BisPrec:=FALSE;
  actuel:=feux[i].Adr_el_suiv1;
  BisActuel:=feux[i].Btype_suiv1=5; 
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
    AdrSuiv:=suivant_alg3(prec,BisPrec,actuel,BisActuel,2);
    if (AdrSuiv<>9998) then // arret sur aiguillage en talon mal positionn�e
    begin
      prec:=actuel;
      BisPrec:=BisActuel;
      actuel:=AdrSuiv;
      BisActuel:=Bis;   
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
    BisPrec,BisActuel : boolean;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('Cherche �tat du signal suivant au '+IntToSTR(adresse),clyellow);
  i:=Index_feu(adresse);
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
  BisPrec:=false;
  actuel:=feux[i].Adr_el_suiv1;
  BisActuel:=feux[i].btype_suiv1=5;

  // si actuel est un d�tecteur, regarder si il ya un feu
  repeat
    inc(j);
    // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
    if (j=1) and (actuel>512) then
    begin
      AdrSuiv:=actuel;  
      actuel:=prec;
      BisPrec:=FALSE;
      BisActuel:=FALSE;
    end
    else
      AdrSuiv:=suivant_alg3(prec,BisPrec,actuel,BisActuel,1);
      
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
    
    prec:=actuel;
    BisPrec:=BisActuel;
    actuel:=AdrSuiv;
    BisActuel:=Bis;
    // si le suivant est un d�tecteur comporte t-il un signal?

    AdrFeu:=0;
    if (AdrSuiv>512) then
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
  if NivDebug=3 then AfficheDebug('Pas Trouv� de feu suivant au feu Adr='+IntToSTR(ADresse),clOrange);
  //TraceDet:=false;
end;


// renvoie l'adresse de l'aiguille si elle est d�vi�e apr�s le signal et ce jusqu'au prochain signal
// sinon renvoie 0
// adresse=adresse du signal
function Aiguille_deviee(adresse : integer) : integer ;  
var AdrDet,AdrFeu,etat,i,j,prec,AdrSuiv,Actuel : integer;
    BisPrec,BisActuel : boolean;
    s : string;
begin
  //traceDet:=true;
  if NivDebug>=2 then AfficheDebug('test si aiguille d�vi�e apr�s signal '+IntToSTR(Adresse),clyellow);
  j:=0;
  i:=Index_feu(adresse);
  prec:=feux[i].Adr_det1;
  BisPrec:=false;
  actuel:=feux[i].Adr_el_suiv1;
  BisActuel:=feux[i].btype_suiv1=3;
  //Affiche(IntToSTR(actuel),clyellow);
  AdrFeu:=0;
  AdrDevie:=0;
  if (actuel<512) then
  begin
    if (aiguillage[actuel].Apointe=prec) and (aiguillage[actuel].position<>const_droit) then Aiguille_deviee:=actuel;
  end;
  
  repeat
    inc(j);
    // 3=demande si le suivant est un aiguillage en pointe d�vi� oui si AdrSuiv=9997 
    // dans ce cas la variable globale AdrDevie est mise � jour
    AdrSuiv:=suivant_alg3(prec,BisPrec,actuel,BisActuel,3);  
    if NivDebug=3 then AfficheDebug('701 - Suivant signalaig='+IntToSTR(AdrSuiv),clyellow);
    if ADrSuiv<>9997 then
    begin
      prec:=actuel;
      BisPrec:=BisActuel;
      actuel:=AdrSuiv;
      BisActuel:=Bis;
      // si le suivant est un d�tecteur comporte t-il un signal?
      AdrFeu:=0;
      if (AdrSuiv>512) then
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
     if bis then s:=s+'bis';
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

// renvoie vrai si une m�moire de zone est occup�e du signal courant au signal suivant
// a compl�ter par les 4 d�tecteurs....
function test_memoire_zones(adresse : integer) : boolean;
var
  ife,Detecteur_precedent,actuel,AdrDet,Etat,AdrFeu,i,j,prec,AdrSuiv : integer;
  Pres_train,sort,BisPrec,BisActuel : boolean;
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
    if (ife=1) then begin prec:=feux[i].Adr_det1;actuel:=feux[i].Adr_el_suiv1;BisActuel:=feux[i].Btype_suiv1=5;end;  //d�tecteur sur le signal courant
    if (ife=2) then begin prec:=feux[i].Adr_det2;actuel:=feux[i].Adr_el_suiv2;BisActuel:=feux[i].Btype_suiv2=5;end;  // d�tecteur sur le signal courant
    if (ife=3) then begin prec:=feux[i].Adr_det3;actuel:=feux[i].Adr_el_suiv3;BisActuel:=feux[i].Btype_suiv3=5;end;  // d�tecteur sur le signal courant
    if (ife=4) then begin prec:=feux[i].Adr_det4;actuel:=feux[i].Adr_el_suiv4;BisActuel:=feux[i].Btype_suiv4=5;end;  // d�tecteur sur le signal courant

    Detecteur_precedent:=prec;
    if (prec=0) then
    begin
       test_memoire_zones:=Pres_train;
       exit;
    end;
    BisPrec:=FALSE;

    repeat
      inc(j);
      // � la premi�re it�ration, si "actuel" est d�ja un d�tecteur, ne pas faire de recherche sur le suivant
      // et cha�ner m�moire de zone
      if (j=1) and (actuel>512) then
      begin
        AdrSuiv:=actuel;
        actuel:=prec;
        BisPrec:=FALSE;
        BisActuel:=FALSE;
        Pres_train:=MemZone[prec,actuel];
        if Pres_Train and (NivDebug=3) then Affiche('Pr�sence train de '+intToSTR(prec)+' � '+intToSTR(actuel),clyellow);
        Detecteur_precedent:=actuel;
      end
      else
        AdrSuiv:=suivant_alg3(prec,BisPrec,actuel,BisActuel,1);
                 
      prec:=actuel;
      BisPrec:=BisActuel;
      actuel:=AdrSuiv;
      BisActuel:=Bis;
     
      if AdrSuiv=0 then
      begin
        // si c'est un buttoir
        test_memoire_zones:=false;
        exit;
      end;
       // si le suivant est un d�tecteur comporte t-il un signal?
      AdrFeu:=0;
      if (AdrSuiv>512) then
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



// calcul des zones depuis le tableau des fronts descendants des �v�nements d�tecteurs
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
  i,i1,i2,j,k,
      IndexBranche_det1,IndexBranche_det2,index_i1,index_i2,
      branche_trouve_det1,branche_trouve_det2,Adr,AdrPrec,position,Btype,BTypePrec,
      AdrFonc : integer;
  BisPrec,BisSuiv,BisFonc,sortie : boolean;
  s : string;

begin
  // traceDet=TRUE;
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
    if (NivDebug=3) then
    begin
      s:='Test route en ';
      if (j=1) then s:=s+'d�cr�ment ' else s:=s+'incr�ment ';
      s:=s+'- d�part depuis d�tecteur '+IntToSTR(det1);Affiche(s,clyellow);
    end;
    AdrPrec:=det1;
    BisPrec:=FALSE;
    Bis:=FALSE;
    if (j=1) then i:=IndexBranche_det1-1 else i:=IndexBranche_det1+1;
    //trouve_element(det1,FALSE);
    Adr:=BrancheN[branche_trouve_det1,i].Adresse;
    AdrFonc:=Adr;
    Btype:=BrancheN[branche_trouve,i].BType;  // �l�ment suivant/pr�c�dent
    BisFonc:=Btype=3; // bug si aiguillage bis
    i:=0;
    if (det2<>Adr) then
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);  // donne l'�l�ment suivant de AdrPrec � AdrFonc et dans Bis si c'est un aig bis
      trouve_element(Adr,Bis);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype=3; // si aiguillage bis
      //Affiche(intToSTR(adr)+'/'+intToStr(Btype),clorange);
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=Bis; 
      i:=i+1;
      sortie:=(Btype=1) or (Btype=4) or (i=20) or (Adr=0);
    until (sortie) ;   // boucle de parcours

    if (i=20) then begin Affiche('Erreur fatale 200 : It�ration trop longue',clred);
        AfficheDebug('Erreur fatale 200 : It�ration trop longue',clred);calcul_zones_det:=3;end;
    if ((Btype=1) and (Adr<>det2) and (NivDebug=3) ) then
       AfficheDebug('N''est pas le d�tecteur attendu '+intToSTR(Adr)+' pour '+intToSTR(det2),clyellow);
    inc(j);
    sortie:=((Adr=det2) and (Btype=1)) or (j=3);
  until sortie;
  
  if ((j=3) and (Adr<>det2)) then
  begin
    if (NivDebug=3) then AfficheDebug('Pas de suivant sur s�quence '+IntToSTR(det1)+' � '+intToStr(det2),clyellow);
    calcul_zones_det:=0;exit;
  end;
  // �tape 2 : on a trouv� le sens de progression, trouver le d�tecteur suivant
  if (Adr=det2) then
  begin
    // trouv� la route si j=2 : -  si j=3 : +
    if (NivDebug=3) then AfficheDebug('Route trouv�e',clyellow);
    i:=0;
    AdrFonc:=Adr;
    BisFonc:=FALSE;
    BisSuiv:=FALSE;
    Bis:=FALSE;
    repeat
      Adr:=suivant_alg3(AdrPrec,BisPrec,AdrFonc,BisFonc,1);
      //if i=0 then El_suivant:=Adr;
      trouve_element(Adr,Bis);
      Btype:=BrancheN[branche_trouve,IndexBranche_trouve].BType;
      BisSuiv:=Btype=3; // si aiguillage bis
      if (NivDebug=3) then AfficheDebug('Suivant='+IntToSTR(Adr)+ '('+intToSTR(Btype)+')',clyellow);
      AdrPrec:=AdrFonc;AdrFonc:=Adr;
      BisPrec:=BisFonc;BisFonc:=Bis;  
      inc(i);
      sortie:=(Btype=1) or (Adr=0) or (i=20);
    until sortie;
    if (i=20) then begin Affiche('Erreur fatale 201 : It�ration trop longue',clred);
                   AfficheDebug('Erreur fatale 201 : It�ration trop longue',clred);calcul_zones_det:=3;end;

    // le train vient de det1, quitte det2 et va vers Adr
    Mem[det1]:=false;
    Mem[det2]:=true;
    MemZone[det1,det2]:=FALSE;    // efface canton pr�c�dent
    MemZone[det2,Adr]:=TRUE;      // valide le nouveau canton
    precedent:=det1;
    Actuel:=det2;
    Suivant:=Adr;
    //if (aff_det) then
    //begin Affiche('MemZone '+intToStr(det1)+' 0',clyellow); Affiche('MemZone '+intToStr(det2)+' 1',clyellow); end;

    Affiche('Mem '+IntToSTR(det2)+' � '+IntTOStr(Adr),clyellow);
    
    //if (echoLog) then writeln(fichier,'it�ration '+intTOstr(iteration)+' - Mem '+IntToSTR(det2)+' � '+IntToSTR(Adr),clyellow);   
    calcul_zones_det:=10;
    exit;         // r�ussi
  end;
end;


// renvoie le d�tecteur de la zone m�moire si la m�moire MemZone[det,xxx] est � 1
// exemple si MemZone[512,517]=true alors Test_mem_origine(512) renvoie 517, sinon 0
function Test_mem_origine(det : integer) : integer ;
var i : integer;
    trouve : boolean;
begin
  i:=513;
  repeat
    trouve:=memzone[det,i];
    if not(trouve) then inc(i);
  until trouve or (i>1024);
  if trouve then Test_mem_origine:=i else Test_mem_origine:=0;
end;

// mise � jour de l'�tat d'un feu en fontion de son environnement et affiche le feu
procedure Maj_Feu(Adrfeu : integer);
var i,j,k1,k2,BtypeSuiv,Adr_det,etat,Adr,Aig,DetPrec1,DetPrec2,Detprec3,Detprec4,Adr_El_Suiv,
    Btype_el_suivant,det_initial,bt,el_suiv : integer ;
    bisSuiv,PresTrain,Aff_semaphore,AffSignal,car : boolean;
begin
  //if AdrFeu=344 then AffSignal:=true;
  if AffSignal then Affiche('Traitement du feu '+intToSTR(Adrfeu),clOrange);
  if NivDebug>=1 then AfficheDebug('Traitement du feu '+intToSTR(Adrfeu)+'------------------------------------',clOrange);
  i:=index_feu(Adrfeu);
  if AdrFeu<>0 then
  begin
    Adr_det:=Feux[i].Adr_det1;  // d�tecteur sur le signal
    Adr_El_Suiv:=Feux[i].Adr_el_suiv1; // adresse �l�ment suivant au feu
    Btype_el_suivant:=Feux[i].Btype_suiv1;
    etat:=etat_signal_suivant(AdrFeu,1) ;  // �tat du signal suivant + adresse du signal suivant dans Signal_Suivant

    // signaux trait�s sp�cifiquement
    if (AdrFeu=201) then
    begin
       //sprintf(Affiche,"Aiguille 27=%d \r\n",aiguillage[27].position);Display(Affiche);
       //   sprintf(Affiche,"Aiguille 31=%d \r\n",aiguillage[31].position);Display(Affiche);
       if ((aiguillage[28].position<>const_droit) and (aiguillage[29].position<>const_droit) and
           (aiguillage[31].position=const_devieD)) then
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

    if AffSignal then Affiche('Debut du traitement g�n�ral',clYellow);
    if NivDebug>=2 then AfficheDebug('D�but du traitement g�n�ral',clYellow);
    // traitement des feux >3 feux diff�rents de violet (cas g�n�ral)
    if (Feux[i].aspect>=3) and (EtatSignalCplx[AdrFeu]<>violet_F) then
    begin
      // d�tecteurs pr�c�dent le feu , pour d�terminer si leurs m�moires de zones sont � 1 pour lib�rer le carr�
      if Feux[i].VerrouCarre then
      begin
        if AffSignal then Affiche('Le feu est verrouillable au carr�',clyellow);
        if NivDebug>=1 then AfficheDebug('Le feu est verrouillable au carr�',clyellow);
        // un feu peut �tre associ� � 4 d�tecteurs (pour 4 voies)
        // il faut donc explorer les 4 d�tecteurs probables
        PresTrain:=FALSE;

        j:=1;
        repeat
          if NivDebug=3 then afficheDebug('S�quence '+IntToSTR(j)+' de recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
          if (j=1) then begin det_initial:=feux[i].Adr_det1;Adr_El_Suiv:=feux[i].Adr_el_suiv1; Btype_el_suivant:=feux[i].Btype_suiv1;end;
          if (j=2) then begin det_initial:=feux[i].Adr_det2;Adr_El_Suiv:=feux[i].Adr_el_suiv2; Btype_el_suivant:=feux[i].Btype_suiv2;end;
          if (j=3) then begin det_initial:=feux[i].Adr_det3;Adr_El_Suiv:=feux[i].Adr_el_suiv3; Btype_el_suivant:=feux[i].Btype_suiv3;end;
          if (j=4) then begin det_initial:=feux[i].Adr_det4;Adr_El_Suiv:=feux[i].Adr_el_suiv4; Btype_el_suivant:=feux[i].Btype_suiv4;end;
          if (det_initial<>0) then
          begin
            DetPrec1:=detecteur_suivant(Adr_El_Suiv,Btype_el_suivant=5,det_initial,false);
            if DetPrec1<>9999 then // route bloqu�e par aiguillage mal positionn�
            begin
              DetPrec2:=detecteur_suivant_El(det_initial,False,DetPrec1,false);
              if DetPrec2<>9999 then
              begin
                DetPrec3:=detecteur_suivant_El(DetPrec1,false,DetPrec2,false);
                if DetPrec3<>9999 then
                begin
                  //DetPrec4:=detecteur_suivant_det(DetPrec2,DetPrec3);
                  if AffSignal then Affiche('les d�tecteurs pr�c�dents au feu '+IntToSTR(Adrfeu)+' sont:'+intToSTR(Det_initial)+' '+intToSTR(DetPrec1)+' '+intToSTR(DetPrec2)+' '+intToSTR(DetPrec3)+' ',clyellow);
                  PresTrain:=//MemZone[DetPrec4,detPrec3] or
                  MemZone[DetPrec3,detPrec2] or MemZone[DetPrec2,detPrec1] or MemZone[DetPrec1,Det_initial] or presTrain ;
             //     Affiche('MemZone'+intToSTR(DetPrec3)+' '+IntToSTR(detPrec2) = '+MemZone[DetPrec3,detPrec2]
                end;
              end;
            end;
          end;
          inc(j);
        until (j>=5);
        if presTrain and AffSignal Then affiche('pr�sence train feu '+intToSTR(AdrFeu),clorange);
      end;
      if AffSignal then affiche('Fin de la recherche des 4 d�tecteurs pr�c�dents-----',clOrange);
      // si le signal peut afficher un carr� et les aiguillages apr�s le signal sont mal positionn�es ou que pas pr�sence train avant signal et signal
      // verrouillable au carr�, afficher un carr�
      car:=carre_signal(AdrFeu);
      if AffSignal and car then Affiche('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (NivDebug>=1) and car then AfficheDebug('le signal a des aiguilles en talon aval mal positionn�es',clYellow);
      if (Feux[i].aspect>=4) and ( (not(PresTrain) and Feux[i].VerrouCarre) or car) then Maj_Etat_Signal(AdrFeu,carre)
      else
      begin
        // si on quitte le d�tecteur on affiche un s�maphore :  attention tester le sens de circulation
        // pour ne pas passer au rouge un feu � contresens.
        // trouver la m�moire de zone MemZone[Adr_det,?] qui a d�clench� le feu rouge
        if AffSignal then Affiche('test du s�maphore',clYellow);
        if (NivDebug>=1) then AfficheDebug('test du s�maphore',clYellow);
        Aff_semaphore:=test_memoire_zones(AdrFeu);  // test si pr�sence train apr�s signal
        if Aff_Semaphore then
        begin
          if AffSignal then Affiche('train apr�s signal-> s�maphore ou carr�',clYellow);
          if (NivDebug>=1) and car then AfficheDebug('train apr�s signal-> s�maphore ou carr�',clYellow);
          if testBit(EtatSignalCplx[Adrfeu],carre)=FALSE then Maj_Etat_Signal(AdrFeu,semaphore);
        end
        else
        begin
          // si aiguille locale d�vi�e
          Aig:=Aiguille_deviee(Adrfeu);
          if (aig<>0) and (feux[i].aspect>=9) then // si le signal peut afficher un rappel et aiguille d�vi�e
          begin
            if AffSignal then Affiche('Aiguille '+intToSTR(aig)+' d�vi�e',clYellow);
            if (NivDebug>=1) then AfficheDebug('Aiguille '+intToSTR(aig)+' d�vi�e',clYellow);
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
            if AffSignal then Affiche('pas d''aiguille d�vi�e',clYellow);
            if (NivDebug>=1) then AfficheDebug('pas d''aiguille d�vi�e',clYellow);
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
    AffSignal:=false;
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
//  calcule_memoires;     // mise � jour des m�moires de zone
  begin
    Maj_feux;
    //Maj_feux;
  end
end;

// met � jour le signal adr dont le d�tecteur vient d'�tre franchi dans le bon sens
procedure signal(SignalCplx,detecteurAct,detecteurSuiv : integer);
begin
  //
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


// supprime un �v�nement d�tecteur dans la liste
procedure supprime_event(i : integer);
var l : integer;
begin
  for l:=i to N_Event_det do event_det[l]:=event_det[l+1];
  dec(N_event_det);
end;

// calcul des zones depuis le tableau des fronts descendants des �v�nements d�tecteurs
// transmis dans le tableau Event_det
// appell�  par front descendant sur d�tecteur
// met � jout le tableau MemZone
procedure calcul_zones ;
var i,det1,det2,index_1,index_2,index_3,resultat : integer;
   unevalide,traceListe : boolean;
   label refaire;
begin
  uneValide:=false;
  traceListe:=false;
  //N_event_det pointe sur le dernier d�tecteur
  refaire:
  with FormDebug.MemoEvtDet do
  begin
    lines.clear;
    for index_3:=1 to N_event_det do lines.add(intToSTR(event_det[index_3]));
  end;

  if traceListe then
  begin
    Affiche('Liste',clyellow);
    for index_3:=1 to N_event_det do affiche(intToSTR(event_det[index_3]),clyellow);
  end;
  if N_event_det<2 then begin exit;end; // pas assez de d�tecteurs pour �valuer
  // balayer index 1 � 2 puis 1 � 3 puis 1 � N_event_det et ensuite
  // de 2 � 3 puis de 2 � 4 puis de 2 � 5 etc
  index_1:=1;
  repeat
    index_2:=index_1+1;
    repeat
      det1:=event_det[index_1];
      det2:=event_det[index_2];
      if det1=det2 then    // si d�tecteurs identiques, supprimer le 2eme
      begin
        if traceListe then Affiche('trouv� doublon',clyellow);
        supprime_event(index_2);
        if traceListe then for index_3:=1 to N_event_det do affiche(intToSTR(event_det[index_3]),clyellow);
        goto refaire;
      end;
      if traceListe then Affiche('cherche '+intToSTR(det1)+' '+intToSTR(det2)+' '+intToSTR(index_1)+' '+intToSTR(index_2)+' '+intToSTR(N_event_det),clyellow);
      resultat:=calcul_zones_det(det1,det2);
      if resultat=10 then
      begin
        FormDebug.MemoEvtDet.lines.add('route trait�e de '+intToSTR(det1)+' � '+IntToSTR(det2));
        uneValide:=true;
        supprime_event(index_1);
        FormDebug.MemoEvtDet.lines.add('Nouveau Tampon:');
        for index_3:=1 to N_event_det do FormDebug.MemoEvtDet.lines.add(intToSTR(event_det[index_3]));
      end;

      // d�tecteur1 non trouv�
      if resultat=1 then begin supprime_event(index_1);goto refaire;end;
      // d�tecteur2 non trouv�
      if resultat=2 then begin supprime_event(index_2);goto refaire;end;
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




// demande l'�tat d'un accessoire. Le r�sultat sera r�ceptionn� sur r�ception des informations
// de r�trosignalisation.
procedure demande_info_acc(adresse : integer);
var s : string;
    n : integer;
begin
  // envoyer 2 fois la commande, une fois avec N=0 pour r�cup�rer le nibble bas,
  // une autre fois avec N=1 pour r�cup�rer le nibble haut
  s:=#$FF+#$FE+#$42+char((adresse-1) div 4);
  n:=$80+((adresse-1) mod 4) div 2;
  s:=s+char(n);   // N=0 (bit 0)
  s:=checksum(s);
  envoi(s);

  s:=#$FF+#$FE+#$42+char((adresse-1) div 4);
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
  dem_calcul_zone:=false;
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
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $8) = $8;
        detecteur_chgt:=i;
        // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

      i:=adresse*8+7;
      if detecteur[i]<>((valeur and $4) = $4) then  // si changement de l'�tat du d�tecteur bit 6
      begin
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $4) = $4;
        detecteur_chgt:=i;
        // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

      i:=adresse*8+6;
      if detecteur[i]<>((valeur and $2) = $2) then  // si changement de l'�tat du d�tecteur bit 5
      begin
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $2) = $2;
        detecteur_chgt:=i;
        // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

      i:=adresse*8+5;
      if detecteur[i]<>((valeur and $1) = $1) then  // si changement de l'�tat du d�tecteur bit 4
      begin
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $1) = $1;
        detecteur_chgt:=i;
        // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;
    end;

    // �tat de l'aiguillage
    if bitsITT=$00 then // module d'aiguillages, N=1
    begin
      adraig:=((adresse * 4)+1 ); // *4 car N=1, c'est le "poids fort"
      if (valeur and $C)=$8 then
      begin
        aiguillage[adraig+3].position:=2 ; // �tat aiguillage haut
        if trace then begin s:='accessoire '+intToSTR(adraig+3)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        aiguillage[adraig+3].position:=1 ; // �tat aiguillage haut
        if trace then begin s:='accessoire '+intToSTR(adraig+3)+'=1';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin                        
        aiguillage[adraig+2].position:=2; // �tat aiguillage bas
        if trace then begin s:='accessoire '+intToSTR(adraig+2)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        aiguillage[adraig+2].position:=1; // �tat aiguillage bas
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
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $8) = $8;
        detecteur_chgt:=i;
        // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

      i:=adresse*8+3;
      if detecteur[i]<>((valeur and $4) = $4) then  // si changement de l'�tat du d�tecteur bit 6
      begin
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $4) = $4;
        detecteur_chgt:=i;
         // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

      i:=adresse*8+2;
      if detecteur[i]<>((valeur and $2) = $2) then  // si changement de l'�tat du d�tecteur bit 5
      begin
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $2) = $2;
        detecteur_chgt:=i;
         // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

      i:=adresse*8+1;
      if detecteur[i]<>((valeur and $1) = $1) then  // si changement de l'�tat du d�tecteur bit 4
      begin
        ancien_detecteur[i]:=detecteur[i];
        detecteur[i]:=(valeur and $1) = $1;
        detecteur_chgt:=i;
         // mise a jour du tableau evt
        if ancien_detecteur[i] and not(detecteur[i]) and (N_Event_det<20) then
        begin
          inc(N_event_det);
          event_det[N_event_det]:=i;
          dem_calcul_zone:=true;
        end;
        if AfficheDet then begin s:='detecteur '+inttoSTR(i)+'=';if detecteur[i] then s:=s+'1' else s:=s+'0';Affiche(s,clYellow);end;
      end;

    end;
    if bitsITT=$00 then // module d'aiguillages
    begin
      adraig:=(adresse * 4)+1;
      if (valeur and $C)=$8 then
      begin
        aiguillage[adraig+1].position:=2 ; // �tat aiguillage haut
        if trace then begin s:='accessoire '+intToSTR(adraig+1)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $C)=$4 then
      begin
        aiguillage[adraig+1].position:=1 ; // �tat aiguillage haut
        if trace then begin s:='accessoire '+intToSTR(adraig+1)+'=1';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$2 then
      begin
        aiguillage[adraig].position:=2; // �tat aiguillage bas
        if trace then begin s:='accessoire '+intToSTR(adraig)+'=2';Affiche(s,clYellow);end;
      end;
      if (valeur and $3)=$1 then
      begin
        aiguillage[adraig].position:=1; // �tat aiguillage bas
        if trace then begin s:='accessoire '+intToSTR(adraig)+'=1';Affiche(s,clYellow);end;
      end;

    end;
  end;
  //if test_leb=false then rafraichit;
  if dem_calcul_zone then calcul_zones;
  //Affiche('Rafraichit',clorange);
end;

function decode_chaine_retro(s : string) : string;
var i : integer;
    chaineInt : string;
begin
  chaineInt:=s;
  i:=pos(#$FF+#$FD+#$42,chaineInt);
  if (i<>0) and (length(chaineInt)>=5) then
  begin
    delete(chaineInt,i,3);
    decode_retro(ord(chaineInt[i]),ord(chaineInt[i+1]));
    delete(chaineInt,i,3);
  end
  else
  begin
    i:=pos(#$FF+#$FD+#$81,chaineInt);
    if (i<>0) and (length(chaineInt)>=5) then
    begin
      delete(chaineInt,i,5);
      Affiche('Voie hors tension msg1',clRed);
    end
    else
    begin
      i:=pos(#$FF+#$FD+#$61,chaineInt);
      if (i<>0) and (length(chaineInt)>=5) then
      begin
        delete(chaineInt,i,5);
        Affiche('Voie hors tension msg2',clRed);
        Hors_tension2:=true;
      end
      else
      begin
        i:=pos(#$FF+#$FD+#$46+#$43+#$40,chaineInt);
        if (i<>0) and (length(chaineInt)>=6) then
        begin
          delete(chaineInt,i,6);
          Affiche('Reprise msg 1',clOrange);
          Hors_tension2:=false;
        end
        else
        begin
          i:=pos(#$FF+#$FD+#$46+#$43+#$50,chaineInt);
          if (i<>0) and (length(chaineInt)>=6) then
          begin
            delete(chaineInt,i,6);
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
  decode_chaine_retro:=chaineint;
end;

// proc�dure appell�e apr�s r�ception sur le port USB ou socket
procedure interprete_reponse(chaine : string);
var chaineInt,msg : string;
    i : integer;

begin
  //if test_leb then exit;
  chaineInt:=chaine;
  //ack:=false;
  //nack:=false;
  while length(chaineINT)>=5 do
  begin
    i:=pos(#$ff+#$fe,chaineINT);
    if (i<>0) and (length(chaineINT)>3) then
    begin
      msg:='';
      delete(chaineINT,i,2);
      if chaineINT[1]=#1 then
      begin
        case chaineINT[i+1] of
        #1 :  begin nack:=true;msg:='erreur timout transmission';end;
        #2 :  begin nack:=true;msg:='erreur timout centrale';end;
        #3 :  begin nack:=true;msg:='erreur communication inconnue';end;
        #4 :  begin msg:='succ�s';ack:=true;end;
        #5 :  begin nack:=true;msg:='plus de time slot';end;
        #6 :  begin nack:=true;msg:='d�bordement tampon LI100';end;
        end;
        if trace and (chaineINT[i+1]=#4) then Affiche(msg,clYellow);
        if trace and (chaineINT[i+1]<>#4) then Affiche(msg,clRed);
      end
      else
      begin
        if chaineINT[1]=#2 then
        begin
          ack:=true;
          msg:='Version mat�rielle '+intTohex(ord(chaineINT[2]),2)+' - Version soft '+intToHex(ord(chaineINT[3]),2);
          Affiche(msg,clYellow);
        end
        else
        begin
          if chaineINT[1]=#$42 then
          begin
            ack:=true;
            delete(chaineInt,1,1);
            decode_retro(ord(chaineInt[1]),ord(chaineInt[2]));
          end
          else
          begin
            if chaineINT[1]=#$61 then
            begin
              delete(chaineInt,1,1);
              case chaineINT[1] of
              #$80 : begin nack:=true;msg:='erreurs de transferts- Voir doc XpressNet p29';end;
              #$81 : begin nack:=true;msg:='Station occup�e - Voir doc XpressNet p29';end;
              #$82 : begin nack:=true;msg:='Commande non implant�e';end;
              else begin nack:=true;msg:='R�ception inconnue';end;
            end;
            Affiche(msg,clRed);
          end;
        end;
      end;
    end;
    if length(chaineINT)<=3 then delete(chaineINT,i,length(chaineINT));
    end
    else
    begin
      i:=pos(#$ff+#$fd,chaineINT);
      if (i<>0) and (length(chaineINT)>=5) then
        chaineINT:=decode_chaine_retro(chaineINT)
      else
      begin
        i:=pos(#$FF+#$FD+#$81,chaineInt);
        if (i<>0) and (length(chaineInt)>=6) then
        begin
          delete(chaineInt,i,6);
          Affiche('Court circuit msg 1',clRed);
        end
        else
        begin
          affiche('Erreur 1, cha�ne r�trosig. inconnue recue:'+chaine_HEX(chaineINT),clred);
          chaineINT:='';
        end;
      end;
    end;
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

procedure connecte_USB;
begin
// initialisation de la comm USB
  if avecMSCom then
  begin
    if NumPort<>0 then
    begin
      With Formprinc.Mscomm1 do
      begin
        Affiche('demande ouverture com'+intToSTR(nuMPort),CLYellow);
        Settings:='57600,N,8,1';
        Handshaking:=2; {2=cts  }
        SThreshold:=1;
        RThreshold:=1;
        CommPort:=NumPort;
        DTREnable:=false;
        InputMode:=comInputModeBinary;
      end;
      //portCommOuvert:=false;
      try
         Formprinc.MSComm1.portopen:=true;
      except
        portCommOuvert:=false;
      end;
    end
     else portCommOuvert:=false;
    if portCommOuvert then affiche('port COM'+intToSTR(NumPort)+' ouvert',clGreen) else
    Affiche('port COM'+intToSTR(NumPort)+' NON ouvert',clRed)  ;
    if portCommOuvert then ParUSB:=true else ParUSB:=false;
  end 
  else
  begin
    PortCommOuvert:=false;ParUSB:=false;
  end;  
end;

procedure deconnecte_CDM;
begin
 with Formprinc do
    begin
      ClientSocketCDM.close;
    end;
end;

procedure connecte_CDM;
var s : string;
begin
  // Initialisation de la comm socket CDM
  if CDM_connecte then begin Affiche('CDM d�ja connect�',Cyan);exit;end;
  if AdresseIPCDM<>'0' then
  begin
    with Formprinc do
    begin
      ClientSocketCDM.port:=portCDM;
      ClientSocketCDM.Address:=AdresseIPCDM;
      ClientSocketCDM.Open;
    end;
    tempo(5);
    // connexion � CDM rail
    s:='C-C-00-0001-CMDGEN-_CNCT|000|';
    //s:='C-C-00-0001-CMDGEN-_CNCT|019|01|LAY=CAPDEBOUHEYRE;';
    //s:='|01|LAY=CAPDEBOUHEYRE;';
    //s:='|01|LAY=RESEAU_TEST;';
    //s:='C-C-00-0001-CMDGEN-_CNCT|'+format('%.*d',[3,length(s)-1])+s;
    envoi_cdm(s);
    if pos('_ACK',recuCDM)<>0 then
    begin
      CDM_connecte:=True;
      Id_CDM:=copy(recuCDM,5,2);   // r�cup�re l'ID re�u de CDM, � utiliser dans toutes les futures trames
      s:='Connect� au serveur CDM rail avec l''ID='+Id_CDM;
      Affiche(s,clYellow);
      AfficheDebug(s,clyellow);

      // demande des services : ATNT=aiguillages, ADET=d�tecteurs AACT=actionneurs
      s:=place_id('C-C-00-0002-RQSERV-RTSIM|030|03|SRV=ATNT;SRV=ADET;SRV=AACT;');
      envoi_CDM(s);
      if pos('_ACK',recuCDM)<>0 then Affiche('Services accept�s: aiguillages - d�tecteurs - actionneurs',clYellow);
      // demande les trains
      ////s:=place_id('C-C-01-0002-DSCTRN-DLOAD|000|');
      //envoi_CDM(s);

      s:=chaine_CDM_Acc(23,2);
      envoi_CDM(s);
      s:=chaine_CDM_Acc(23,0);
      envoi_CDM(s);
    end;
  end
  else
  begin
    Affiche('La connexion a CDM n''est pas demand�e car l''adresse IP est nulle dans config.cfg',cyan);
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

procedure TFormPrinc.FormCreate(Sender: TObject);
var
   i : integer;
   s : string;
begin
  TraceSign:=True;
  Caption:=AF;
  avecMSCom:=false;
  Application.onHint:=doHint;
  LabelEtat.Caption:='Initialisations en cours';
  Menu_interface(devalide);

   // ouvre la fenetre debug
  FormDebug:=TFormDebug.Create(Application);
  FormDebug.Caption:=AF+' debug';
  FormDebug.Show;
  DebugOuv:=True;

  if IsWow64Process then s:='OS 64 Bits'
                    else s:='OS 32 Bits';
  s:=DateToStr(date)+' '+TimeToStr(Time)+' '+s;
  Affiche(s,clLime);AfficheDebug(s,ClLime);



  NivDebug:=0;
  // lecture fichier de configuration
  ferme:=false;
  CDM_connecte:=false;
  pasreponse:=0;
  lit_config;
  Nbre_recu_cdm:=0;

  connecte_USB;

  AffMem:=true;

  // Initialisation de la comm socket LENZ
  if AdresseIP<>'0' then
  begin
    ClientSocketLenz.port:=port;
    ClientSocketLenz.Address:=AdresseIP;
    ClientSocketLenz.Open;
  end;

  connecte_CDM;
  
  // Initialisation des images des signaux
  NbreImagePLigne:=Formprinc.ScrollBox1.Width div (largImg+5);

  // ajoute une image dynamiquement
  for i:=1 to NbreFeux do
  begin
    cree_image(i);  // et initialisation tableaux signaux
  end;

  if test_leb then Tempo_init:=0 else Tempo_init:=10;  // d�marre les initialisation des signaux et des aiguillages dans 1 s

  NombreImages:=0;

  detect_Simule[1]:=519;
  detect_Simule[2]:=517;
  detect_Simule[3]:=525;
  detect_Simule[4]:=528;
  detect_Simule[5]:=518;
  detect_Simule[6]:=514;
  detect_Simule[7]:=522;
  detect_Simule[8]:=527;
  detect_Simule[9]:=519;
  index_simule:=1;


  //essai
 // event_det[1]:=527;
 // event_det[2]:=520;
 // N_event_det:=2;
   //aiguillage[31].Position:=2;
   //aiguillage[27].Position:=2;
  //traceDet:=true;
 // calcul_zones;
  //carre_signal(358);
  //maj_feu(201);
  //etat_signal_suivant(201,1);
  //Aiguille_deviee(462);
  //i:=detecteur_suivant(23,false,538,false);  // donne l'�l�ment suivant de AdrPrec � AdrFonc et dans Bis si c'est un aig bis
  //  i:=etat_signal_suivant(462,2);
  //NivDebug:=3;
  //Affiche(IntToSTR(detecteur_suivant_El(531,false,518,false)),clyellow);
  //i:=Aiguille_deviee(176);


end;



procedure TFormPrinc.MSComm1Comm(Sender: TObject);
var i : integer;
begin
  if MSComm1.commEvent=comEvReceive then
  begin
    TpsRecuCom:=0;
    tablo:=MSComm1.Input;
    for i:=0 to length(tablo)-1 do
    begin
      chaine_recue:=chaine_recue+char(tablo[i]);
    end;
    if trace then affiche(chaine_hex(chaine_recue),clWhite);
    interprete_reponse(chaine_recue);
  end;
end;

procedure TFormPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Ferme:=true;
  if portCommOuvert then begin portCommOuvert:=false;MSComm1.Portopen:=false; end;
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
    Menu_interface(valide);
  end;

end;

procedure simulation;
var s : string;
    adr,ts : integer;
begin
  timerSimule:=timerSimule+1;
  ts:=timerSimule;
{
  if timersimule=60 then
  begin
    trace:=true;
    adr:=(513 div 8) -4 ;
    s:=#$FF+#$FD+#$42+Char(adr)+#$11;
    s:=checksum(s);
    interprete_reponse(s);
  end;
}

  //trace:=true;
  if ts=60 then
  begin
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=70 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=90 then
  begin
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=100 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=120 then
  begin
    Affiche('T=120',clWhite);
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=130 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=150 then
  begin
    Affiche('T=150',clWhite);
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=160 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=190 then
  begin
    Affiche('T=190',clWhite);
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=200 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=220 then
  begin
    Affiche('T=220',clWhite);
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=230 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=260 then
  begin
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=270 then
  begin
    Affiche('T=270',clWhite);
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=29 then
  begin
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=30 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;

  if ts=32 then
  begin
    adr:=detect_simule[index_simule];
    Affiche(intToSTR(adr),clwhite);
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=true;
    rafraichit;
  end;
  if ts=33 then
  begin
    adr:=detect_simule[index_simule];
    ancien_detecteur[adr]:=detecteur[adr];
    detecteur[adr]:=false;
    rafraichit;
    inc(index_simule);
  end;


end;


// timer � 100 ms
procedure TFormPrinc.Timer1Timer(Sender: TObject);
var i,a : integer;
begin
  if Tempo_init>0 then dec(Tempo_init);
  if Tempo_init=1 then
  begin
    Affiche('Positionnement des feux',clYellow);
    if not(ferme) then envoi_signauxCplx;  // initialisation des feux
    if not(ferme) and (AvecInitAiguillages=1) then init_aiguillages else   // initialisation des aiguillages
    if not(ferme) then demande_etat_acc;   // demande l'�tat des accessoires (position des aiguillages)
    LabelEtat.Caption:=' ';
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
  //simulation;

end;

// bouton version
procedure TFormPrinc.BoutVersionClick(Sender: TObject);
var s : string;
begin
  s:=hextostr('ff fe f0');
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
   affiche(s,ClRed);
   afficheDebug(s,ClRed);
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
   parSocket:=false;
   ErrorCode:=0;
end;

// lecture depuis socket
procedure TFormPrinc.ClientSocketLenzRead(Sender: TObject;
  Socket: TCustomWinSocket);
var s : string;
begin
  s:=ClientSocketLenz.Socket.ReceiveText;
  interprete_reponse(s);
  if trace then affiche(chaine_hex(s),clWhite);
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
  // r�cup�rer le contenu du Hint dans lequel on avait stock� lors de la cr�ation de la checkbox l'index du feu
  {
  with Sender as TcheckBox do
  begin
    Index:=StrToInt(hint);
    coche:=checked;
  end;
  adr:=feux[index].adresse;}
  Maj_feux ;              // �value l'�tat des signaux
  //envoi_signauxCplx;    // et affiche les signaux
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

procedure TFormPrinc.BoutCalcZoneClick(Sender: TObject);
var i1,i2 : integer;
begin
  i1:=StrToINT(EditDetecteur1.text);
  i2:=StrToINT(EditDetecteur2.text);
  Event_det[1]:=i1;
  Event_det[2]:=i2;
  N_event_det:=2;
  calcul_zones;
end;

procedure TFormPrinc.MenuConnecterUSBClick(Sender: TObject);
begin
  Hors_tension2:=false;
  connecte_USB;
end;

procedure TFormPrinc.DeconnecterUSBClick(Sender: TObject);
begin
  Ferme:=true;
  if portCommOuvert then begin portCommOuvert:=false;MSComm1.Portopen:=false; end;
  portCommOuvert:=false;
  ClientSocketLenz.close;
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
  for Nbranche:=1 to NbreBranches do
  begin
    j:=1;
    repeat
      adr:=BrancheN[Nbranche,j].adresse;

      if (adr<>0) and (BrancheN[Nbranche,j].BType=1) then
      begin
        s:='D�tecteur '+intToSTR(adr)+' = ';
        if Detecteur[adr] then s:=s+'1' else s:=s+'0';
      end;
      inc(j); // index de branche
    until (adr=0) ;
  end;

  for j:=1 to NDetecteurs do
  begin
   s:='D�tecteur '+intToSTR(Adresse_detecteur[j])+'=';
   if Detecteur[adresse_detecteur[j]] then s:=s+'1' else s:=s+'0';
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
end;



procedure TFormPrinc.ClientSocketLenzConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Affiche('Lenz connect� ',clYellow);
  AfficheDebug('Lenz connect� ',clYellow);
end;

procedure TFormPrinc.ClientSocketCDMConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Affiche('CDM Rail connect� ',clYellow);
  AfficheDebug('CDM Rail connect� ',clYellow);
  parSocketCDM:=True;
end;

procedure TFormPrinc.ClientSocketCDMRead(Sender: TObject;Socket: TCustomWinSocket);
  var i,j,k,erreur, adr,adr2,etat,etataig : integer ;
      s,ss : string;
      traite,sort : boolean;
begin
  inc(Nbre_recu_cdm);
  recuCDM:=ClientSocketCDM.Socket.ReceiveText;

  //AfficheDebug('recu de CDM:',clWhite);AfficheDebug(recuCDM,clWhite);
  AckCDM:=recuCDM<>'';
  if pos('ACK',recuCDM)=0 then
  begin
    if pos('ERR=200',recuCDM)<>0 then Affiche('Erreur CDM : r�seau non charg�',clred);
  end;
  k:=0;
  dem_calcul_zone:=false;
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

      ancien_detecteur[adr]:=detecteur[adr];
      Detecteur[adr]:=etat=1;
      detecteur_chgt:=adr;
      // mise a jour du tableau evt
      if ancien_detecteur[adr] and not(detecteur[adr]) and (N_Event_det<20) then
      begin
        inc(N_event_det);
        event_det[N_event_det]:=adr;
        dem_calcul_zone:=true;
      end;
      if AfficheDet then Affiche('D�tecteur '+intToSTR(adr)+'='+IntToStr(etat),clYellow);
    end ;
    inc(k);
    //traite:=(k<30) or (pos('CMDACC-ST_TO',recuCDM)<>0) or (pos('CMDACC-ST_DT',recuCDM)<>0) ;
    sort:=(k>70) or (pos('CMDACC-ST_TO',recuCDM)=0) and (pos('CMDACC-ST_DT',recuCDM)=0);
  until (sort);
  //Affiche('Ligne trait�e'+recuCDM,clLime);
  if k>=70 then begin Affiche('Erreur 90 : Longrestante='+IntToSTR(length(recuCDM)),clred); Affiche(recuCDM,clred);  end;
  if dem_calcul_zone then begin calcul_zones; end;
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

procedure TFormPrinc.ClientSocketCDMDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Affiche('CDM rail d�connect�',Cyan);
  AfficheDebug('CDM rail d�connect�',Cyan);
  CDM_connecte:=False;
end;



end.
